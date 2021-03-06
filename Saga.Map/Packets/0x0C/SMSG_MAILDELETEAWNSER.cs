using Saga.Network.Packets;

namespace Saga.Packets
{
    /// <summary>
    ///
    /// </summary>
    /// <remarks>
    /// This packet is sent over as an reply indicating if the mail item
    /// could be deleted.
    /// </remarks>
    /// <id>
    /// 0C06
    /// </id>
    internal class SMSG_MAILDELETEAWNSER : RelayPacket
    {
        public SMSG_MAILDELETEAWNSER()
        {
            this.Cmd = 0x0601;
            this.Id = 0x0C06;
            this.data = new byte[1];
        }

        public byte Result
        {
            set
            {
                this.data[0] = value;
            }
        }
    }
}