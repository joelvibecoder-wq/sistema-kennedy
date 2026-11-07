# Kennedy Presente — Firebase setup

- Enable Authentication > Email/Password in Firebase Console.
- Create the administrator account manually in Firebase Authentication.
- In Firestore, create collection `admins` and a document whose ID is that account's Firebase UID. Set `role: admin`.
- Publish the rules in `firestore.rules` under Firestore > Rules.
- The app reads and writes student records in the `students` collection.
- Render uses the root Dockerfile (Nginx static hosting).

Public self-registration is intentionally disabled. Use only fictional student data for testing until school authorization and a privacy/security review are complete. Firebase web configuration is client-side configuration; do not commit service-account JSON or private keys.
