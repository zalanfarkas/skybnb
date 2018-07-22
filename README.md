## AWAD Individual Assessment 2017

**Report**

by Zalan Farkas

In this assignment I built an Airbnb clone called SkyBnB. During the development of the application my intention was to create an application which satisfies the requirements of a booking site in the real life by completing the elements from the grading criteria and also by adding some extra features.

**With respect to the grading criteria:**

### Criterion 1:

I used the devise gem to implement the authentication system of my application which was a great bootstrap to getting started. Firstly, the default devise views had been update to achieve responsive design by adding bootstrap with the necessary gems. Then the three different levels of access had been created. I decided to use a real world approach instead of adding an admin attribute to the user model. As a result, the app contains two devise models, one for users and one for admins. After that the user types had been distinguished by adding the user\_type attribute to the user model. Since this attribute is a string I took care of that so that it can be only &quot;host&quot; and &quot;guest&quot; by model validation:

validates :user\_type, presence: true, inclusion: { in: %w(guest host), message: &quot;%{value} is not a valid value&quot; }

Since Admin is a different model we can keep the admin functions safe by adding admin authentication before\_action to the admins controller. Also, admins have a separate login page at **&#39;/admin123456&#39;** which makes it possible to access admin interface easily. In addition to this, due to the fact that lots of confidential information can go through the site, admins do not have access to everything. They can list the rooms of a given host and filter these rooms by numerous criteria as well as they can delete any of these rooms. Besides, they can look for the reservations of a given guest then list them or delete any of them.

Finally, guest users can only search rooms, make reservations, edit their guest profile, send messages and manage their reservations. Hosts have the same rights as guests extended by the options of adding and managing rooms.

Note: Rooms which have reservations cannot be deleted neither by an admin nor by a host.

### Criterion 2:

When users sign up for SkyBnB they can select whether they want to register as a host or a guest. Later they can upgrade or downgrade their account in their account settings. The guest profiles include the following information about the user: full name, email, a short introduction and photos. The profile photos of the users are handled by the paperclip gem and they are stored in AWS&#39;s  Amazon S3 using a different S3 bucket in development and production. Moreover, it can be also mentioned that deletion of these images is done by AJAX request because it provides better user experience and also because I wanted to show my experience with AJAX in hope of extra marks.

In addition to these, users can log in and sign up with their Google or Facebook accounts by the aid of omniauth gem. If the user is registered previously with the corresponding email address then the existing account will be loaded. Otherwise, a new account will be created with guest user type.

As a last thing to mention, the avatars of the users are loaded from their Gravatar, Facebook or Google accounts.

### Criterion 3:

During the development of the app I used git and made new branches for every new feature and for each major step of the development. Moreover, after every merging the code had been pushed to bitbucket and heroku. Also it is accessible on cloud 9. Details on how the access the app are provided later.

### Criterion 4:

As I said earlier, users can sign up as a host or they can become hosts anytime by visiting their profile settings or by clicking the dedicated link on the navigation panel. After they became hosts they can create and manage rooms/properties easily. Each room possesses the following attributes: home type, room type, accommodate, bedrooms, bathrooms, listing name, summary, address, TV, heating, Kitchen, Air Conditioning, Internet, price, house rules and photos. Photos of rooms are handled the same way as photos of users. They are managed by the Paperclip gem and stored on AWS. Also, room photo destroy is made by AJAX. Moreover, the locations of the rooms are displayed on Google Maps which requires to turn address into longitude and latitude by the geocoder gem.

### Criterion 5:

I spent a day trying to find open source live data for this project but it turned out that booking websites only provide API services to their corporate partners. Attempts to create open source Airbnb API exist but none of them worked for me in this project. As a result, I chose database seeding. Unfortunately, photos cannot be seeded so only a few users and rooms have images uploaded. The rest uses a default image when they are displayed in listings.

On the other hand, I implemented other APIs which provide live data such as the Google and Facebook sign-in as well as the Paypal checkout.

### Criterion 6:

The search feature is based on the ransack gem which makes the searching more precise and simple than sending costume database queries written by a student like me. However, it took a while for me to understand how it should be setup and how it works. Users can access search from the navigation panel anytime as well as from the root and search pages. In the search page complex result filtering can be made by the following filters: location, start date, end date, minimum price, maximum price, house type, number of guests, number of bedrooms, number of bathrooms and amenities.

### Criterion 7:

The room booking feature can be found on the show views of the rooms. It requires the user to select a certain start and end date by using an intelligent jquery datepicker with AJAX. Due to the jquery code with AJAX, the datepicker only displays the available booking periods to the user. Also it also prevents user error such as booking a period which is not continuous because there is another reservation within that period. After the booking is sent the app redirects to paypal where the user can pay. If the payment is completed, it notifies the SkyBnB app with a booking confirmation. Then the user will be redirected to their trip list&#39;s page.

With respect to paypal there are three important things to mention. All the payment happens in sandbox mode on paypal so these purchases do not involve real money.

Here are the details of the sandbox paypal user with whom the booking can be finished:

email: ***

password: foobarfoobar

Secondly, during the development of the app it happened twice that paypal responded with a 500 internal error. In this case the page should be refreshed or another trial should be made a few minutes later.

Thirdly, when paypal redirects back to the SkyBnB app&#39;s trip page the page should be refreshed to display the new reservation.

### Criterion 8:

During the development of the app I applied TDD. I did several tests with Rspec With Capybara. I also did only half a test with Cucumber to show evidence of my understanding on how it works but I ran out of time so it was not finished. With Capybara I tested numerous features such as login/logout, sign-up, admin control panel, making reservations, room creation, search, the correct layout is displayed to the hosts and guests. Moreover, with rspec I wrote model, controller and request tests. It is important to mention that controller tests were extremely useful when I was developing the authentication and authorization systems because they could notify me to fix security flaws.

Unfortunately, I could not run capybara tests which use javascript on Cloud 9. So those parts of the tests were removed which results that Rails flash messages are not tested because they were customized with the toastr gem&#39;s  javascript code.

### Criterion 9:

With respect to security it can be seen that Rails provides a huge range of security tools by default. However, some features require turning on such as SSL. So I setup forcing SSL in production to prevent Session Hijacking. It is also important to keep confidential variables such as API keys and app secret safe. Therefore, in production I used environment variables instead of storing plain keys in the application code. Besides, I applied dotenv gem to be able to use environment variables in development as well.  Furthermore, recaptcha verification had been implemented in the devise&#39;s registrations and passwords controller so brute-force attacks can be prevented. Devise also takes care of security in numerous ways such as with session and cookies expiry as well as password encryption. In addition, SQL queries which interact with the user are handled in a safe way. Finally, to prevent unpaid reservation error, which is similar to the Domino&#39;s example mentioned in the lecture, each reservation has an attribute called status which is true only if the paypal confirms that the payment was successful.

### Criterion 10 (Extra features):

SkyBnB also contains a messaging system which uses the conversation and messaging model with the corresponding controllers. Moreover, with the aid of private\_pub gem a listening server can be opened on Cloud 9 ( with the command: rackup private\_pub.ru -o $IP -s thin -p 8081 -E production) in another terminal which makes real-time chat messaging possible. Note: This listening server is a separate application on Heroku so it runs automatically but sometimes it takes some time to wake from sleeping state so a page refresh is required after sending the first message. Besides, an email notification is sent when somebody sends a message to you. These notifications and devise uses Sendgrid to send emails.

Secondly, users, who have completed reservations on a certain room can write a review about the room.

Thirdly, there are nearby rooms recommendation (other rentable rooms within 10km) lists on each room&#39;s show view. The elements of this recommendation list are gathered by the geocoder gem.

Notice: All the features on the application work in both development (Cloud9) and production (Heroku).

## Login credentials:

Guest:

        email: [z2@example.com](mailto:z2@example.com)

        foobar

Host:

        email: [z@example.com](mailto:z@example.com)

        password: foobar

Admin:

        **login url: /admin123456**

        email: [zadmin@example.com](mailto:zadmin@example.com)

        password: foobar


        **Seeded rooms are in London, Brooklyn and Aberdeen.**

**/Rooms/1 is the URL for the room which has images uploaded**

## Instruction on the access and use of SkyBnB

The live application is available at [**https://skybnb.herokuapp.com/**](https://skybnb.herokuapp.com/) **.** 

## Installation

```console
  $ git clone https://github.com/zalanfarkas/skybnb.git

  $ cd skybnb/skybnb-app
```

After that, in order to be able to use the application in a local or Cloud9 Rails workspace, it is necessary to install the needed gems:
```console
$ bundle install --without production
```

Next, migrate the database:

```console
$ rails db:reset

$ rails db:migrate:reset

 $ rails db:migrate

 $ rails db:seed
```

Finally, run the test suite to verify that everything is working correctly:

```console
$ rspec
```

If the test suite passes, you&#39;ll be ready to run the app on a local server:

```console
$ rails server (or in Cloud9: rails server -b $IP -p $PORT)
```
in another teminal:
```console
rackup private\_pub.ru -o $IP -s thin -p 8081 -E production
```
**Seeded rooms are in London, Brooklyn and Aberdeen.**

**/Rooms/1 is the URL for the room which has images uploaded**