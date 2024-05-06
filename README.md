# T3 Stack - Shadcn UI

[![Quality Gate Status](http://146.190.150.93:9000/api/project_badges/measure?project=game-connect&metric=alert_status&token=sqb_444d47b12078e0727034ab6fab9967281f31939f)](http://146.190.150.93:9000/dashboard?id=game-connect)

This project is built on the [T3 Stack](https://create.t3.gg/) and is bootstrapped with `create-t3-app`. It integrates multiple cutting-edge technologies including Drizzle ORM for database interactions, Next.js for server-side rendering, NextAuth for authentication, and much more. This setup is designed to be scalable and efficient, making it suitable for both development and production environments.

## Technologies Used

- **[Next.js](https://nextjs.org)** - The React framework for production.
- **[NextAuth.js](https://next-auth.js.org)** - For secure authentication.
- **[Drizzle ORM](https://orm.drizzle.team)** - An ORM for managing database entities.
- **[Tailwind CSS](https://tailwindcss.com)** - For utility-first CSS.
- **[tRPC](https://trpc.io)** - End-to-end typesafe APIs made easy.
- **[Ansible](https://www.ansible.com/)** - For automating deployment and configuration.
- **[SonarQube](https://www.sonarqube.org/)** - For continuous inspection of code quality.
- **[PostgreSQL](https://www.postgresql.org/)** - As the underlying database system.

## Local Development Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Youngermaster/T3-Stack-Shadcn-UI.git
   cd T3-Stack-Shadcn-UI
   ```

2. **Install dependencies:**

   ```bash
   pnpm install
   ```

3. **Setup the environment:**
   Copy the `.env.example` file to `.env` and update the environment variables to match your setup:

   ```bash
   cp .env.example .env
   ```

4. **Start the local development database:**

   ```bash
   ./start-database.sh
   ```

5. **Run the development server:**

   ```bash
   pnpm dev
   ```

   Visit `http://localhost:3000` to view the application.

## Database Management

- **Migrate and push changes to the database:**

  ```bash
  pnpm db:push
  ```

- **Open Drizzle Studio to manage the database interactively:**

  ```bash
  pnpm db:studio
  ```

### Environment Configuration and Authentication Setup

Before starting your development server or deploying the application, ensure that your environment variables are set up correctly. The `.env` file holds crucial configurations that influence the behavior of your application, including database connections and authentication mechanisms.

1. **Set Up Environment Variables:**

   - Copy the `.env.example` file to a new file named `.env` in the root directory:

     ```bash
     cp .env.example .env
     ```

   - Modify the `.env` file to include your specific settings. This file should never be committed to your version control system as it contains sensitive information.

2. **Configure Discord Authentication:**

   - You will need to set up a Discord application to use Discord as an authentication provider. Visit the [Discord Developer Portal](https://discord.com/developers/applications), create a new application, and configure OAuth2.
   - Add the following URLs to your OAuth2 redirect URIs in the Discord Developer Portal:

     ```plaintext
     http://localhost:3000/api/auth/callback/discord
     ```

     Replace `localhost:3000` with your production domain if deploying to a live server.
   - Obtain the `Client ID` and `Client Secret` from your Discord application and set them in your `.env` file:

     ```ts
     DISCORD_CLIENT_ID=your_client_id_here
     DISCORD_CLIENT_SECRET=your_client_secret_here
     ```

3. **Verify Authentication Configuration:**
   - Ensure `NEXTAUTH_URL` is set to the base URL of your site. For local development, this will typically be:

     ```python
     NEXTAUTH_URL=http://localhost:3000
     ```

For detailed instructions on setting up your project and additional configurations, refer to the [T3 documentation](https://create.t3.gg/en/usage/first-steps). This documentation provides a comprehensive guide on first steps, including further customization and enhancement of your application.

## Code Quality with SonarQube

Run SonarQube analysis to ensure high code quality:

```bash
./sonar_scanner.sh
```

Ensure SonarQube is running locally or adjust `SONARQUBE_URL` in your `.env` to point to your SonarQube server.

## Deployment

The application can be deployed using Docker. See the `docker-compose.yml` file for Docker configuration details. Use the following command to build and run the Docker environment:

```bash
docker-compose up --build
```

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the Apache License. See `LICENSE` for more information.

## Need Help?

If you have any questions or need help, please open an issue.

---

Thank you for choosing this T3 Stack implementation for your next project!
