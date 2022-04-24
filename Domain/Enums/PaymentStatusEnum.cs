namespace Domain.Enums
{
    public enum PaymentStatusEnum
    {
        // Open Invoice Categories
        Pending,
        OverdueAccount,

        // Paid Invoice Categories
        Paid,
        AdvancePayment,
        LatePayment
    }
}
