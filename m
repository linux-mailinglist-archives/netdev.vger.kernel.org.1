Return-Path: <netdev+bounces-124481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DD969A92
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9423D28625D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436F1C984E;
	Tue,  3 Sep 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zPMkFLZ5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B511C62A8;
	Tue,  3 Sep 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360470; cv=none; b=VcvpFJooaA57ZGWCrmwwWl8O0yI7O/chXGOqd4n+cHoteXG3K5GKKcIubjYrbhl+JNvbR2ICda/ZEN4/4BVYWhTavmI0ubKx8cnvQsepGVfFM6e7uE4NCArMK6s75Qj0YRKWsxrw+jmtnzPgWggQkv0UQ47M+Vl0mrWl6u0UJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360470; c=relaxed/simple;
	bh=r2np5lMohhB5z4Xc8SNEzxOUjsFqrm7fBTszxWbaOE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfLiimKmROuNb7hmn/7t/Zm5EXS7ewgiwGRQJdIqpZKQ/49fLEfvriGtwqfGfe2wBfYq1tBf/QKwFyo8/Yg33NK5zSKs2+Q3qOvJp6O6dMw9MhHI0jB1FfyA1o4yoj5ad4AtUiwtyHVisBZkru1tZlFoiby0S8KSGpVfy3hhmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zPMkFLZ5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360467; x=1756896467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r2np5lMohhB5z4Xc8SNEzxOUjsFqrm7fBTszxWbaOE0=;
  b=zPMkFLZ57xalroCeK+f+vR6UoIvBK2s262qDFeurH8bpRlXPOCHx2WPK
   o3/c0Vij3y3ZPdvu3MucVoXDZYoJmbBiw3pcMLwRp4esGD+scLR7ib4fC
   P6jOf1qanjvGA4lD6ENlktgolkeI+gosswB5cffY/eaqFsGp5fOq8APvK
   6UAmwin/tMDU2fHhJpNe/gTQTksMy52rLD6mfokCg2jo5/8t5y+zFPShT
   H5gmZR5QUNkOwg68hoMDxgnZvQBkVx2VmnSi9JNoFCt4GIECNZdL9mdxg
   iZZhrN5qTb60iFPYo0/li/IH8IKKzaGQ6R2UG/fHPF8+kdDO6tQtQyMHn
   A==;
X-CSE-ConnectionGUID: gMxGs1AKRjyzUsZY+6HQ0g==
X-CSE-MsgGUID: flAQc4MMRYGmSIHboUCjkA==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="34314849"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:47:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:47:33 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:47:22 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v7 01/14] Documentation: networking: add OPEN Alliance 10BASE-T1x MAC-PHY serial interface
Date: Tue, 3 Sep 2024 16:16:52 +0530
Message-ID: <20240903104705.378684-2-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The IEEE 802.3cg project defines two 10 Mbit/s PHYs operating over a
single pair of conductors. The 10BASE-T1L (Clause 146) is a long reach
PHY supporting full duplex point-to-point operation over 1 km of single
balanced pair of conductors. The 10BASE-T1S (Clause 147) is a short reach
PHY supporting full / half duplex point-to-point operation over 15 m of
single balanced pair of conductors, or half duplex multidrop bus
operation over 25 m of single balanced pair of conductors.

Furthermore, the IEEE 802.3cg project defines the new Physical Layer
Collision Avoidance (PLCA) Reconciliation Sublayer (Clause 148) meant to
provide improved determinism to the CSMA/CD media access method. PLCA
works in conjunction with the 10BASE-T1S PHY operating in multidrop mode.

The aforementioned PHYs are intended to cover the low-speed / low-cost
applications in industrial and automotive environment. The large number
of pins (16) required by the MII interface, which is specified by the
IEEE 802.3 in Clause 22, is one of the major cost factors that need to be
addressed to fulfil this objective.

The MAC-PHY solution integrates an IEEE Clause 4 MAC and a 10BASE-T1x PHY
exposing a low pin count Serial Peripheral Interface (SPI) to the host
microcontroller. This also enables the addition of Ethernet functionality
to existing low-end microcontrollers which do not integrate a MAC
controller.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/oa-tc6-framework.rst | 497 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 3 files changed, 504 insertions(+)
 create mode 100644 Documentation/networking/oa-tc6-framework.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c71b87346178..171bace26c91 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -87,6 +87,7 @@ Contents:
    nexthop-group-resilient
    nf_conntrack-sysctl
    nf_flowtable
+   oa-tc6-framework
    openvswitch
    operstates
    packet_mmap
diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
new file mode 100644
index 000000000000..fe2aabde923a
--- /dev/null
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -0,0 +1,497 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=========================================================================
+OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface (TC6) Framework Support
+=========================================================================
+
+Introduction
+------------
+
+The IEEE 802.3cg project defines two 10 Mbit/s PHYs operating over a
+single pair of conductors. The 10BASE-T1L (Clause 146) is a long reach
+PHY supporting full duplex point-to-point operation over 1 km of single
+balanced pair of conductors. The 10BASE-T1S (Clause 147) is a short reach
+PHY supporting full / half duplex point-to-point operation over 15 m of
+single balanced pair of conductors, or half duplex multidrop bus
+operation over 25 m of single balanced pair of conductors.
+
+Furthermore, the IEEE 802.3cg project defines the new Physical Layer
+Collision Avoidance (PLCA) Reconciliation Sublayer (Clause 148) meant to
+provide improved determinism to the CSMA/CD media access method. PLCA
+works in conjunction with the 10BASE-T1S PHY operating in multidrop mode.
+
+The aforementioned PHYs are intended to cover the low-speed / low-cost
+applications in industrial and automotive environment. The large number
+of pins (16) required by the MII interface, which is specified by the
+IEEE 802.3 in Clause 22, is one of the major cost factors that need to be
+addressed to fulfil this objective.
+
+The MAC-PHY solution integrates an IEEE Clause 4 MAC and a 10BASE-T1x PHY
+exposing a low pin count Serial Peripheral Interface (SPI) to the host
+microcontroller. This also enables the addition of Ethernet functionality
+to existing low-end microcontrollers which do not integrate a MAC
+controller.
+
+Overview
+--------
+
+The MAC-PHY is specified to carry both data (Ethernet frames) and control
+(register access) transactions over a single full-duplex serial peripheral
+interface.
+
+Protocol Overview
+-----------------
+
+Two types of transactions are defined in the protocol: data transactions
+for Ethernet frame transfers and control transactions for register
+read/write transfers. A chunk is the basic element of data transactions
+and is composed of 4 bytes of overhead plus 64 bytes of payload size for
+each chunk. Ethernet frames are transferred over one or more data chunks.
+Control transactions consist of one or more register read/write control
+commands.
+
+SPI transactions are initiated by the SPI host with the assertion of CSn
+low to the MAC-PHY and ends with the deassertion of CSn high. In between
+each SPI transaction, the SPI host may need time for additional
+processing and to setup the next SPI data or control transaction.
+
+SPI data transactions consist of an equal number of transmit (TX) and
+receive (RX) chunks. Chunks in both transmit and receive directions may
+or may not contain valid frame data independent from each other, allowing
+for the simultaneous transmission and reception of different length
+frames.
+
+Each transmit data chunk begins with a 32-bit data header followed by a
+data chunk payload on MOSI. The data header indicates whether transmit
+frame data is present and provides the information to determine which
+bytes of the payload contain valid frame data.
+
+In parallel, receive data chunks are received on MISO. Each receive data
+chunk consists of a data chunk payload ending with a 32-bit data footer.
+The data footer indicates if there is receive frame data present within
+the payload or not and provides the information to determine which bytes
+of the payload contain valid frame data.
+
+Reference
+---------
+
+10BASE-T1x MAC-PHY Serial Interface Specification,
+
+Link: https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
+
+Hardware Architecture
+---------------------
+
+.. code-block:: none
+
+  +----------+      +-------------------------------------+
+  |          |      |                MAC-PHY              |
+  |          |<---->| +-----------+  +-------+  +-------+ |
+  | SPI Host |      | | SPI Slave |  |  MAC  |  |  PHY  | |
+  |          |      | +-----------+  +-------+  +-------+ |
+  +----------+      +-------------------------------------+
+
+Software Architecture
+---------------------
+
+.. code-block:: none
+
+  +----------------------------------------------------------+
+  |                 Networking Subsystem                     |
+  +----------------------------------------------------------+
+            / \                             / \
+             |                               |
+             |                               |
+            \ /                              |
+  +----------------------+     +-----------------------------+
+  |     MAC Driver       |<--->| OPEN Alliance TC6 Framework |
+  +----------------------+     +-----------------------------+
+            / \                             / \
+             |                               |
+             |                               |
+             |                              \ /
+  +----------------------------------------------------------+
+  |                    SPI Subsystem                         |
+  +----------------------------------------------------------+
+                          / \
+                           |
+                           |
+                          \ /
+  +----------------------------------------------------------+
+  |                10BASE-T1x MAC-PHY Device                 |
+  +----------------------------------------------------------+
+
+Implementation
+--------------
+
+MAC Driver
+~~~~~~~~~~
+
+- Probed by SPI subsystem.
+
+- Initializes OA TC6 framework for the MAC-PHY.
+
+- Registers and configures the network device.
+
+- Sends the tx ethernet frames from n/w subsystem to OA TC6 framework.
+
+OPEN Alliance TC6 Framework
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- Initializes PHYLIB interface.
+
+- Registers mac-phy interrupt.
+
+- Performs mac-phy register read/write operation using the control
+  transaction protocol specified in the OPEN Alliance 10BASE-T1x MAC-PHY
+  Serial Interface specification.
+
+- Performs Ethernet frames transaction using the data transaction protocol
+  for Ethernet frames specified in the OPEN Alliance 10BASE-T1x MAC-PHY
+  Serial Interface specification.
+
+- Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
+  subsystem.
+
+Data Transaction
+~~~~~~~~~~~~~~~~
+
+The Ethernet frames that are typically transferred from the SPI host to
+the MAC-PHY will be converted into multiple transmit data chunks. Each
+transmit data chunk will have a 4 bytes header which contains the
+information needed to determine the validity and the location of the
+transmit frame data within the 64 bytes data chunk payload.
+
+.. code-block:: none
+
+  +---------------------------------------------------+
+  |                     Tx Chunk                      |
+  | +---------------------------+  +----------------+ |   MOSI
+  | | 64 bytes chunk payload    |  | 4 bytes header | |------------>
+  | +---------------------------+  +----------------+ |
+  +---------------------------------------------------+
+
+4 bytes header contains the below fields,
+
+DNC (Bit 31) - Data-Not-Control flag. This flag specifies the type of SPI
+               transaction. For TX data chunks, this bit shall be ’1’.
+               0 - Control command
+               1 - Data chunk
+
+SEQ (Bit 30) - Data Chunk Sequence. This bit is used to indicate an
+               even/odd transmit data chunk sequence to the MAC-PHY.
+
+NORX (Bit 29) - No Receive flag. The SPI host may set this bit to prevent
+                the MAC-PHY from conveying RX data on the MISO for the
+                current chunk (DV = 0 in the footer), indicating that the
+                host would not process it. Typically, the SPI host should
+                set NORX = 0 indicating that it will accept and process
+                any receive frame data within the current chunk.
+
+RSVD (Bit 28..24) - Reserved: All reserved bits shall be ‘0’.
+
+VS (Bit 23..22) - Vendor Specific. These bits are implementation specific.
+                  If the MAC-PHY does not implement these bits, the host
+                  shall set them to ‘0’.
+
+DV (Bit 21) - Data Valid flag. The SPI host uses this bit to indicate
+              whether the current chunk contains valid transmit frame data
+              (DV = 1) or not (DV = 0). When ‘0’, the MAC-PHY ignores the
+              chunk payload. Note that the receive path is unaffected by
+              the setting of the DV bit in the data header.
+
+SV (Bit 20) - Start Valid flag. The SPI host shall set this bit when the
+              beginning of an Ethernet frame is present in the current
+              transmit data chunk payload. Otherwise, this bit shall be
+              zero. This bit is not to be confused with the Start-of-Frame
+              Delimiter (SFD) byte described in IEEE 802.3 [2].
+
+SWO (Bit 19..16) - Start Word Offset. When SV = 1, this field shall
+                   contain the 32-bit word offset into the transmit data
+                   chunk payload that points to the start of a new
+                   Ethernet frame to be transmitted. The host shall write
+                   this field as zero when SV = 0.
+
+RSVD (Bit 15) - Reserved: All reserved bits shall be ‘0’.
+
+EV (Bit 14) - End Valid flag. The SPI host shall set this bit when the end
+              of an Ethernet frame is present in the current transmit data
+              chunk payload. Otherwise, this bit shall be zero.
+
+EBO (Bit 13..8) - End Byte Offset. When EV = 1, this field shall contain
+                  the byte offset into the transmit data chunk payload
+                  that points to the last byte of the Ethernet frame to
+                  transmit. This field shall be zero when EV = 0.
+
+TSC (Bit 7..6) - Timestamp Capture. Request a timestamp capture when the
+                 frame is transmitted onto the network.
+                 00 - Do not capture a timestamp
+                 01 - Capture timestamp into timestamp capture register A
+                 10 - Capture timestamp into timestamp capture register B
+                 11 - Capture timestamp into timestamp capture register C
+
+RSVD (Bit 5..1) - Reserved: All reserved bits shall be ‘0’.
+
+P (Bit 0) - Parity. Parity bit calculated over the transmit data header.
+            Method used is odd parity.
+
+The number of buffers available in the MAC-PHY to store the incoming
+transmit data chunk payloads is represented as transmit credits. The
+available transmit credits in the MAC-PHY can be read either from the
+Buffer Status Register or footer (Refer below for the footer info)
+received from the MAC-PHY. The SPI host should not write more data chunks
+than the available transmit credits as this will lead to transmit buffer
+overflow error.
+
+In case the previous data footer had no transmit credits available and
+once the transmit credits become available for transmitting transmit data
+chunks, the MAC-PHY interrupt is asserted to SPI host. On reception of the
+first data header this interrupt will be deasserted and the received
+footer for the first data chunk will have the transmit credits available
+information.
+
+The Ethernet frames that are typically transferred from MAC-PHY to SPI
+host will be sent as multiple receive data chunks. Each receive data
+chunk will have 64 bytes of data chunk payload followed by 4 bytes footer
+which contains the information needed to determine the validity and the
+location of the receive frame data within the 64 bytes data chunk payload.
+
+.. code-block:: none
+
+  +---------------------------------------------------+
+  |                     Rx Chunk                      |
+  | +----------------+  +---------------------------+ |   MISO
+  | | 4 bytes footer |  | 64 bytes chunk payload    | |------------>
+  | +----------------+  +---------------------------+ |
+  +---------------------------------------------------+
+
+4 bytes footer contains the below fields,
+
+EXST (Bit 31) - Extended Status. This bit is set when any bit in the
+                STATUS0 or STATUS1 registers are set and not masked.
+
+HDRB (Bit 30) - Received Header Bad. When set, indicates that the MAC-PHY
+                received a control or data header with a parity error.
+
+SYNC (Bit 29) - Configuration Synchronized flag. This bit reflects the
+                state of the SYNC bit in the CONFIG0 configuration
+                register (see Table 12). A zero indicates that the MAC-PHY
+                configuration may not be as expected by the SPI host.
+                Following configuration, the SPI host sets the
+                corresponding bitin the configuration register which is
+                reflected in this field.
+
+RCA (Bit 28..24) - Receive Chunks Available. The RCA field indicates to
+                   the SPI host the minimum number of additional receive
+                   data chunks of frame data that are available for
+                   reading beyond the current receive data chunk. This
+                   field is zero when there is no receive frame data
+                   pending in the MAC-PHY’s buffer for reading.
+
+VS (Bit 23..22) - Vendor Specific. These bits are implementation specific.
+                  If not implemented, the MAC-PHY shall set these bits to
+                  ‘0’.
+
+DV (Bit 21) - Data Valid flag. The MAC-PHY uses this bit to indicate
+              whether the current receive data chunk contains valid
+              receive frame data (DV = 1) or not (DV = 0). When ‘0’, the
+              SPI host shall ignore the chunk payload.
+
+SV (Bit 20) - Start Valid flag. The MAC-PHY sets this bit when the current
+              chunk payload contains the start of an Ethernet frame.
+              Otherwise, this bit is zero. The SV bit is not to be
+              confused with the Start-of-Frame Delimiter (SFD) byte
+              described in IEEE 802.3 [2].
+
+SWO (Bit 19..16) - Start Word Offset. When SV = 1, this field contains the
+                   32-bit word offset into the receive data chunk payload
+                   containing the first byte of a new received Ethernet
+                   frame. When a receive timestamp has been added to the
+                   beginning of the received Ethernet frame (RTSA = 1)
+                   then SWO points to the most significant byte of the
+                   timestamp. This field will be zero when SV = 0.
+
+FD (Bit 15) - Frame Drop. When set, this bit indicates that the MAC has
+              detected a condition for which the SPI host should drop the
+              received Ethernet frame. This bit is only valid at the end
+              of a received Ethernet frame (EV = 1) and shall be zero at
+              all other times.
+
+EV (Bit 14) - End Valid flag. The MAC-PHY sets this bit when the end of a
+              received Ethernet frame is present in this receive data
+              chunk payload.
+
+EBO (Bit 13..8) - End Byte Offset: When EV = 1, this field contains the
+                  byte offset into the receive data chunk payload that
+                  locates the last byte of the received Ethernet frame.
+                  This field is zero when EV = 0.
+
+RTSA (Bit 7) - Receive Timestamp Added. This bit is set when a 32-bit or
+               64-bit timestamp has been added to the beginning of the
+               received Ethernet frame. The MAC-PHY shall set this bit to
+               zero when SV = 0.
+
+RTSP (Bit 6) - Receive Timestamp Parity. Parity bit calculated over the
+               32-bit/64-bit timestamp added to the beginning of the
+               received Ethernet frame. Method used is odd parity. The
+               MAC-PHY shall set this bit to zero when RTSA = 0.
+
+TXC (Bit 5..1) - Transmit Credits. This field contains the minimum number
+                 of transmit data chunks of frame data that the SPI host
+                 can write in a single transaction without incurring a
+                 transmit buffer overflow error.
+
+P (Bit 0) - Parity. Parity bit calculated over the receive data footer.
+            Method used is odd parity.
+
+SPI host will initiate the data receive transaction based on the receive
+chunks available in the MAC-PHY which is provided in the receive chunk
+footer (RCA - Receive Chunks Available). SPI host will create data invalid
+transmit data chunks (empty chunks) or data valid transmit data chunks in
+case there are valid Ethernet frames to transmit to the MAC-PHY. The
+receive chunks available in MAC-PHY can be read either from the Buffer
+Status Register or footer.
+
+In case the previous data footer had no receive data chunks available and
+once the receive data chunks become available again for reading, the
+MAC-PHY interrupt is asserted to SPI host. On reception of the first data
+header this interrupt will be deasserted and the received footer for the
+first data chunk will have the receive chunks available information.
+
+MAC-PHY Interrupt
+~~~~~~~~~~~~~~~~~
+
+The MAC-PHY interrupt is asserted when the following conditions are met.
+
+Receive chunks available - This interrupt is asserted when the previous
+data footer had no receive data chunks available and once the receive
+data chunks become available for reading. On reception of the first data
+header this interrupt will be deasserted.
+
+Transmit chunk credits available - This interrupt is asserted when the
+previous data footer indicated no transmit credits available and once the
+transmit credits become available for transmitting transmit data chunks.
+On reception of the first data header this interrupt will be deasserted.
+
+Extended status event - This interrupt is asserted when the previous data
+footer indicated no extended status and once the extended event become
+available. In this case the host should read status #0 register to know
+the corresponding error/event. On reception of the first data header this
+interrupt will be deasserted.
+
+Control Transaction
+~~~~~~~~~~~~~~~~~~~
+
+4 bytes control header contains the below fields,
+
+DNC (Bit 31) - Data-Not-Control flag. This flag specifies the type of SPI
+               transaction. For control commands, this bit shall be ‘0’.
+               0 - Control command
+               1 - Data chunk
+
+HDRB (Bit 30) - Received Header Bad. When set by the MAC-PHY, indicates
+                that a header was received with a parity error. The SPI
+                host should always clear this bit. The MAC-PHY ignores the
+                HDRB value sent by the SPI host on MOSI.
+
+WNR (Bit 29) - Write-Not-Read. This bit indicates if data is to be written
+               to registers (when set) or read from registers
+               (when clear).
+
+AID (Bit 28) - Address Increment Disable. When clear, the address will be
+               automatically post-incremented by one following each
+               register read or write. When set, address auto increment is
+               disabled allowing successive reads and writes to occur at
+               the same register address.
+
+MMS (Bit 27..24) - Memory Map Selector. This field selects the specific
+                   register memory map to access.
+
+ADDR (Bit 23..8) - Address. Address of the first register within the
+                   selected memory map to access.
+
+LEN (Bit 7..1) - Length. Specifies the number of registers to read/write.
+                 This field is interpreted as the number of registers
+                 minus 1 allowing for up to 128 consecutive registers read
+                 or written starting at the address specified in ADDR. A
+                 length of zero shall read or write a single register.
+
+P (Bit 0) - Parity. Parity bit calculated over the control command header.
+            Method used is odd parity.
+
+Control transactions consist of one or more control commands. Control
+commands are used by the SPI host to read and write registers within the
+MAC-PHY. Each control commands are composed of a 4 bytes control command
+header followed by register write data in case of control write command.
+
+The MAC-PHY ignores the final 4 bytes of data from the SPI host at the end
+of the control write command. The control write command is also echoed
+from the MAC-PHY back to the SPI host to identify which register write
+failed in case of any bus errors. The echoed Control write command will
+have the first 4 bytes unused value to be ignored by the SPI host
+followed by 4 bytes echoed control header followed by echoed register
+write data. Control write commands can write either a single register or
+multiple consecutive registers. When multiple consecutive registers are
+written, the address is automatically post-incremented by the MAC-PHY.
+Writing to any unimplemented or undefined registers shall be ignored and
+yield no effect.
+
+The MAC-PHY ignores all data from the SPI host following the control
+header for the remainder of the control read command. The control read
+command is also echoed from the MAC-PHY back to the SPI host to identify
+which register read is failed in case of any bus errors. The echoed
+Control read command will have the first 4 bytes of unused value to be
+ignored by the SPI host followed by 4 bytes echoed control header followed
+by register read data. Control read commands can read either a single
+register or multiple consecutive registers. When multiple consecutive
+registers are read, the address is automatically post-incremented by the
+MAC-PHY. Reading any unimplemented or undefined registers shall return
+zero.
+
+Device drivers API
+==================
+
+The include/linux/oa_tc6.h defines the following functions:
+
+.. c:function:: struct oa_tc6 *oa_tc6_init(struct spi_device *spi, \
+                                           struct net_device *netdev)
+
+Initialize OA TC6 lib.
+
+.. c:function:: void oa_tc6_exit(struct oa_tc6 *tc6)
+
+Free allocated OA TC6 lib.
+
+.. c:function:: int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, \
+                                          u32 value)
+
+Write a single register in the MAC-PHY.
+
+.. c:function:: int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, \
+                                           u32 value[], u8 length)
+
+Writing multiple consecutive registers starting from @address in the MAC-PHY.
+Maximum of 128 consecutive registers can be written starting at @address.
+
+.. c:function:: int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, \
+                                         u32 *value)
+
+Read a single register in the MAC-PHY.
+
+.. c:function:: int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, \
+                                          u32 value[], u8 length)
+
+Reading multiple consecutive registers starting from @address in the MAC-PHY.
+Maximum of 128 consecutive registers can be read starting at @address.
+
+.. c:function:: netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, \
+                                              struct sk_buff *skb);
+
+The transmit Ethernet frame in the skb is or going to be transmitted through
+the MAC-PHY.
+
+.. c:function:: int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+
+Zero align receive frame feature can be enabled to align all receive ethernet
+frames data to start at the beginning of any receive data chunk payload with a
+start word offset (SWO) of zero.
diff --git a/MAINTAINERS b/MAINTAINERS
index baf88e74c907..e9131d19d2ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17095,6 +17095,12 @@ L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/ulp/opa_vnic
 
+OPEN ALLIANCE 10BASE-T1S MACPHY SERIAL INTERFACE FRAMEWORK
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/oa-tc6-framework.rst
+
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
 M:	Saravana Kannan <saravanak@google.com>
-- 
2.34.1


