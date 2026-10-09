
# db/seeds.rb
#
# Intended for a clean development database.
# Run with: bin/rails db:seed
#
# For a complete reset, use: bin/rails db:reset
# WARNING: db:reset deletes existing database data.

puts "Creating locations..."

braga = Location.create!(
  address: "Rua do Souto, Braga, Portugal",
  latitude: 41.5504533,
  longitude: -8.3843179
)

porto = Location.create!(
  address: "Rua de Santa Catarina, Porto, Portugal",
  latitude: 41.1490511,
  longitude: -8.6060568
)

aveiro = Location.create!(
  address: "Rua João Mendonça, Aveiro, Portugal",
  latitude: 40.6415361,
  longitude: -8.6546821
)

coimbra = Location.create!(
  address: "Rua Ferreira Borges, Coimbra, Portugal",
  latitude: 40.208566,
  longitude: -8.4290994
)

lisboa = Location.create!(
  address: "Rua Augusta, Lisboa, Portugal",
  latitude: 38.7113158,
  longitude: -9.1379346
)

faro = Location.create!(
  address: "Rua de Santo António, Faro, Portugal",
  latitude: 37.0161037,
  longitude: -7.933248
)

viana_do_castelo = Location.create!(
  address: "Rua Manuel Espregueira, Viana do Castelo, Portugal",
  latitude: 41.6920814,
  longitude: -8.8313957
)

evora = Location.create!(
  address: "Rua 5 de Outubro, Évora, Portugal",
  latitude: 38.64593,
  longitude: -7.7300106
)

vigo = Location.create!(
  address: "Rúa do Príncipe, Vigo, Spain",
  latitude: 42.2370479,
  longitude: -8.7233093
)

santiago = Location.create!(
  address: "Rúa do Franco, Santiago de Compostela, Spain",
  latitude: 42.8781552,
  longitude: -8.5453174
)


puts "Creating services..."

service_30 = Service.create!(
  name: "30 minutes Appointment",
  price: BigDecimal("20.50"),
  duration_in_minutes: 30
)

service_60 = Service.create!(
  name: "60 minutes Appointment",
  price: BigDecimal("30.25"),
  duration_in_minutes: 60
)

service_120 = Service.create!(
  name: "2 hours Appointment",
  price: BigDecimal("10.00"),
  duration_in_minutes: 120
)

service_15 = Service.create!(
  name: "15 minutes Appointment",
  price: BigDecimal("5.00"),
  duration_in_minutes: 15
)


puts "Creating nutritionists..."

tomas = Nutritionist.create!(
  name: "Tomas T. Aveiro",
  email: "tommy@arq.pt"
)

joao = Nutritionist.create!(
  name: "Joao Pecados",
  email: "joao_p@med.pt"
)

mia = Nutritionist.create!(
  name: "Mia Filipa",
  email: "mia_f@can.pt"
)

ines = Nutritionist.create!(
  name: "Ines Ribeiro",
  email: "ines.ribeiro@example.com"
)

miguel = Nutritionist.create!(
  name: "Miguel Costa",
  email: "miguel.costa@example.com"
)

catarina = Nutritionist.create!(
  name: "Catarina Alves",
  email: "catarina.alves@example.com"
)

pedro = Nutritionist.create!(
  name: "Pedro Ferreira",
  email: "pedro.ferreira@example.com"
)

sofia = Nutritionist.create!(
  name: "Sofia Sousa",
  email: "sofia.sousa@example.com"
)

rui = Nutritionist.create!(
  name: "Rui Martins",
  email: "rui.martins@example.com"
)

ana = Nutritionist.create!(
  name: "Ana Costa",
  email: "ana.costa@example.com"
)

joana = Nutritionist.create!(
  name: "Joana Silva",
  email: "joana.silva@example.com"
)

tiago = Nutritionist.create!(
  name: "Tiago Pereira",
  email: "tiago.pereira@example.com"
)

marta = Nutritionist.create!(
  name: "Marta Oliveira",
  email: "marta.oliveira@example.com"
)


puts "Creating nutritionist services..."

# Tomas offers four different services in different cities.
tomas_service_30 = NutritionistService.create!(
  nutritionist: tomas,
  service: service_30,
  location: braga
)

tomas_service_60 = NutritionistService.create!(
  nutritionist: tomas,
  service: service_60,
  location: porto
)

tomas_service_120 = NutritionistService.create!(
  nutritionist: tomas,
  service: service_120,
  location: aveiro
)

tomas_service_15 = NutritionistService.create!(
  nutritionist: tomas,
  service: service_15,
  location: coimbra
)

# Joao offers two services at different locations.
joao_service_30 = NutritionistService.create!(
  nutritionist: joao,
  service: service_30,
  location: porto
)

joao_service_60 = NutritionistService.create!(
  nutritionist: joao,
  service: service_60,
  location: lisboa
)

# Mia offers three services at different locations.
mia_service_60 = NutritionistService.create!(
  nutritionist: mia,
  service: service_60,
  location: viana_do_castelo
)

mia_service_120 = NutritionistService.create!(
  nutritionist: mia,
  service: service_120,
  location: faro
)

mia_service_15 = NutritionistService.create!(
  nutritionist: mia,
  service: service_15,
  location: vigo
)

# Additional nutritionists distributed across the ten cities.
ines_service_15 = NutritionistService.create!(
  nutritionist: ines,
  service: service_15,
  location: viana_do_castelo
)

miguel_service_30 = NutritionistService.create!(
  nutritionist: miguel,
  service: service_30,
  location: faro
)

catarina_service_60 = NutritionistService.create!(
  nutritionist: catarina,
  service: service_60,
  location: evora
)

pedro_service_120 = NutritionistService.create!(
  nutritionist: pedro,
  service: service_120,
  location: vigo
)

sofia_service_15 = NutritionistService.create!(
  nutritionist: sofia,
  service: service_15,
  location: santiago
)

rui_service_30 = NutritionistService.create!(
  nutritionist: rui,
  service: service_30,
  location: braga
)

ana_service_60 = NutritionistService.create!(
  nutritionist: ana,
  service: service_60,
  location: porto
)

joana_service_120 = NutritionistService.create!(
  nutritionist: joana,
  service: service_120,
  location: aveiro
)

tiago_service_15 = NutritionistService.create!(
  nutritionist: tiago,
  service: service_15,
  location: coimbra
)

marta_service_30 = NutritionistService.create!(
  nutritionist: marta,
  service: service_30,
  location: lisboa
)


puts "Creating guests..."

guest_history = Guest.create!(
  name: "Seed Guest History",
  email: "seed.history@example.com"
)

guest_approved_joao = Guest.create!(
  name: "Guest Approved Joao",
  email: "seed.approved.joao@example.com"
)

guest_pending_a = Guest.create!(
  name: "Guest Pending A",
  email: "seed.pending.a@example.com"
)

guest_pending_b = Guest.create!(
  name: "Guest Pending B",
  email: "seed.pending.b@example.com"
)

guest_canceled = Guest.create!(
  name: "Guest Canceled Tomas",
  email: "seed.canceled.tomas@example.com"
)

guest_rejected = Guest.create!(
  name: "Guest Rejected Tomas",
  email: "seed.rejected.tomas@example.com"
)

guest_approved_mia = Guest.create!(
  name: "Guest Approved Mia",
  email: "seed.approved.mia@example.com"
)

guest_pending_mia = Guest.create!(
  name: "Guest Pending Mia",
  email: "seed.pending.mia@example.com"
)

guest_approved_miguel = Guest.create!(
  name: "Guest Approved Miguel",
  email: "seed.approved.miguel@example.com"
)


puts "Creating appointments..."

# Dates relative to the current day keep appointments within
# the one-hour minimum lead time and three-month booking horizon.
base_day = (Time.current + 7.days).beginning_of_day
second_day = base_day + 1.day
third_day = base_day + 2.days
fourth_day = base_day + 3.days

# Approved appointment for Tomas.
tomas_approved_start = base_day + 9.hours

Appointment.create!(
  guest: guest_history,
  nutritionist_service: tomas_service_30,
  start_date_time: tomas_approved_start,
  end_date_time: tomas_approved_start + service_30.duration_in_minutes.minutes,
  status: :approved
)

# Approved appointment for Joao.
joao_approved_start = base_day + 9.hours

Appointment.create!(
  guest: guest_approved_joao,
  nutritionist_service: joao_service_30,
  start_date_time: joao_approved_start,
  end_date_time: joao_approved_start + service_30.duration_in_minutes.minutes,
  status: :approved
)

# Approved appointment for Mia.
mia_approved_start = second_day + 10.hours

Appointment.create!(
  guest: guest_approved_mia,
  nutritionist_service: mia_service_60,
  start_date_time: mia_approved_start,
  end_date_time: mia_approved_start + service_60.duration_in_minutes.minutes,
  status: :approved
)

# Approved appointment for Miguel.
miguel_approved_start = second_day + 11.hours

Appointment.create!(
  guest: guest_approved_miguel,
  nutritionist_service: miguel_service_30,
  start_date_time: miguel_approved_start,
  end_date_time: miguel_approved_start + service_30.duration_in_minutes.minutes,
  status: :approved
)

# One guest can have appointments in different statuses.
# This guest has only one pending appointment.
history_rejected_start = second_day + 14.hours

Appointment.create!(
  guest: guest_history,
  nutritionist_service: mia_service_15,
  start_date_time: history_rejected_start,
  end_date_time: history_rejected_start + service_15.duration_in_minutes.minutes,
  status: :rejected
)

history_canceled_start = third_day + 9.hours

Appointment.create!(
  guest: guest_history,
  nutritionist_service: joao_service_60,
  start_date_time: history_canceled_start,
  end_date_time: history_canceled_start + service_60.duration_in_minutes.minutes,
  status: :canceled
)

history_pending_start = fourth_day + 13.hours

Appointment.create!(
  guest: guest_history,
  nutritionist_service: ines_service_15,
  start_date_time: history_pending_start,
  end_date_time: history_pending_start + service_15.duration_in_minutes.minutes,
  status: :pending
)

# Two pending appointments overlap for Joao.
# Neither blocks the schedule while it is pending.
# Approving one should reject the other.
overlap_start = base_day + 14.hours

Appointment.create!(
  guest: guest_pending_a,
  nutritionist_service: joao_service_30,
  start_date_time: overlap_start,
  end_date_time: overlap_start + service_30.duration_in_minutes.minutes,
  status: :pending
)

Appointment.create!(
  guest: guest_pending_b,
  nutritionist_service: joao_service_60,
  start_date_time: overlap_start,
  end_date_time: overlap_start + service_60.duration_in_minutes.minutes,
  status: :pending
)

# Canceled appointment for Tomas.
tomas_canceled_start = base_day + 11.hours

Appointment.create!(
  guest: guest_canceled,
  nutritionist_service: tomas_service_60,
  start_date_time: tomas_canceled_start,
  end_date_time: tomas_canceled_start + service_60.duration_in_minutes.minutes,
  status: :canceled
)

# Rejected appointment for Tomas.
tomas_rejected_start = base_day + 14.hours

Appointment.create!(
  guest: guest_rejected,
  nutritionist_service: tomas_service_120,
  start_date_time: tomas_rejected_start,
  end_date_time: tomas_rejected_start + service_120.duration_in_minutes.minutes,
  status: :rejected
)

# A pending appointment for Mia.
mia_pending_start = third_day + 14.hours

Appointment.create!(
  guest: guest_pending_mia,
  nutritionist_service: mia_service_15,
  start_date_time: mia_pending_start,
  end_date_time: mia_pending_start + service_15.duration_in_minutes.minutes,
  status: :pending
)

puts "Seed completed successfully!"

