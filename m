Return-Path: <netdev+bounces-124491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A93969AB8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64361F2449C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA301C62CE;
	Tue,  3 Sep 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hNJ/vdRh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DEF1B985C;
	Tue,  3 Sep 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360585; cv=none; b=nu0sKEp+kYmhR5TFWCaNpGdBL1EBlAGpjt/6F4x3dUyWFn+wnGeZZZNFTpW7QTELk0w1PT1u3yiMM08jKeHaBjt1+nynbqwQaa0lCOkqEDNiPd0eAqM3zbqurs//Y18Yv0oN9IZ8Kf+UA5F0D2vz7zPbju7D3q78+0aox9sR6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360585; c=relaxed/simple;
	bh=r1uxgoJPoE+8uqH5E+e/fMZqPM3mC7pDOl4tz6skaTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMsVR6bpzBJz3B3zmaemIKYv5uxAg+/kODGVqiILqdp5OxGFNaNhBfwgnY0F+BDbonIpUuAlCaI1fJM6NNJjggD7eXQYRPtFd5O0YE5tAxCivvdtespCtoT6yUJdUfwgbAyxxAQTlZTPAPWWKywzLO4PwUAVUJSfrqOBSGb+/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hNJ/vdRh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360582; x=1756896582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r1uxgoJPoE+8uqH5E+e/fMZqPM3mC7pDOl4tz6skaTg=;
  b=hNJ/vdRhq2+OakxqtMXG/3hDblg9j7rSKitE69v0dHPc5/8IM4Xm2r1m
   Ifmong25MD1dYwssqUz1yCak46QyZSWL2H+YKjWrZ1DLIZ1x1i6b/N0aH
   1u4WlBo7p9/UW0GC38m4O6RZKLK7Eer62EROIYmREhxy/nrkulpNhShfs
   jCxDgtK9d3PWLs98S2XfV6pm8MBQivDDDdIyD8gqCE377m3JXb6m6IkP+
   2Osf0HLmT68dMY1gj8/rTBYStRwl6TZkiXhCeeJDXB3ZXcATSs+KEr1kI
   HvJ52gM0u304gA7YsnNIWQRRkyOE5z0LidezM7QiheTl/gPE97rQcpWMm
   g==;
X-CSE-ConnectionGUID: HEQGaLT3R9WXYpJSnDLQuw==
X-CSE-MsgGUID: 0YeX7vLVQlKpcmfq0sdzIA==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="31159324"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:49:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:49:01 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:48:50 -0700
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
Subject: [PATCH net-next v7 09/14] net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames
Date: Tue, 3 Sep 2024 16:17:00 +0530
Message-ID: <20240903104705.378684-10-Parthiban.Veerasooran@microchip.com>
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

The transmit ethernet frame will be converted into multiple transmit data
chunks. Each transmit data chunk consists of a 4 bytes header followed by
a 64 bytes transmit data chunk payload. The 4 bytes data header occurs at
the beginning of each transmit data chunk on MOSI. The data header
contains the information needed to determine the validity and location of
the transmit frame data within the data chunk payload. The number of
transmit data chunks transmitted to mac-phy is limited to the number
transmit credits available in the mac-phy. Initially the transmit credits
will be updated from the buffer status register and then it will be
updated from the footer received on each spi data transfer. The received
footer will be examined for the transmit errors if any.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 399 +++++++++++++++++++++++++++++++++-
 include/linux/oa_tc6.h        |   1 +
 2 files changed, 398 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 8958af863b6e..bbc4b7fce64c 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -27,6 +27,13 @@
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
 #define STATUS0_RESETC				BIT(6)	/* Reset Complete */
+#define STATUS0_HEADER_ERROR			BIT(5)
+#define STATUS0_LOSS_OF_FRAME_ERROR		BIT(4)
+#define STATUS0_TX_PROTOCOL_ERROR		BIT(0)
+
+/* Buffer Status Register */
+#define OA_TC6_REG_BUFFER_STATUS		0x000B
+#define BUFFER_STATUS_TX_CREDITS_AVAILABLE	GENMASK(15, 8)
 
 /* Interrupt Mask Register #0 */
 #define OA_TC6_REG_INT_MASK0			0x000C
@@ -47,6 +54,21 @@
 #define OA_TC6_CTRL_HEADER_LENGTH		GENMASK(7, 1)
 #define OA_TC6_CTRL_HEADER_PARITY		BIT(0)
 
+/* Data header */
+#define OA_TC6_DATA_HEADER_DATA_NOT_CTRL	BIT(31)
+#define OA_TC6_DATA_HEADER_DATA_VALID		BIT(21)
+#define OA_TC6_DATA_HEADER_START_VALID		BIT(20)
+#define OA_TC6_DATA_HEADER_START_WORD_OFFSET	GENMASK(19, 16)
+#define OA_TC6_DATA_HEADER_END_VALID		BIT(14)
+#define OA_TC6_DATA_HEADER_END_BYTE_OFFSET	GENMASK(13, 8)
+#define OA_TC6_DATA_HEADER_PARITY		BIT(0)
+
+/* Data footer */
+#define OA_TC6_DATA_FOOTER_EXTENDED_STS		BIT(31)
+#define OA_TC6_DATA_FOOTER_RXD_HEADER_BAD	BIT(30)
+#define OA_TC6_DATA_FOOTER_CONFIG_SYNC		BIT(29)
+#define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
+
 /* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
  * OPEN Alliance specification.
  */
@@ -64,6 +86,13 @@
 						(OA_TC6_CTRL_MAX_REGISTERS *\
 						OA_TC6_CTRL_REG_VALUE_SIZE) +\
 						OA_TC6_CTRL_IGNORED_SIZE)
+#define OA_TC6_CHUNK_PAYLOAD_SIZE		64
+#define OA_TC6_DATA_HEADER_SIZE			4
+#define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
+						OA_TC6_CHUNK_PAYLOAD_SIZE)
+#define OA_TC6_MAX_TX_CHUNKS			48
+#define OA_TC6_SPI_DATA_BUF_SIZE		(OA_TC6_MAX_TX_CHUNKS *\
+						OA_TC6_CHUNK_SIZE)
 #define STATUS0_RESETC_POLL_DELAY		1000
 #define STATUS0_RESETC_POLL_TIMEOUT		1000000
 
@@ -77,10 +106,20 @@ struct oa_tc6 {
 	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
 	void *spi_ctrl_tx_buf;
 	void *spi_ctrl_rx_buf;
+	void *spi_data_tx_buf;
+	void *spi_data_rx_buf;
+	struct sk_buff *ongoing_tx_skb;
+	struct sk_buff *waiting_tx_skb;
+	struct task_struct *spi_thread;
+	wait_queue_head_t spi_wq;
+	u16 tx_skb_offset;
+	u16 spi_data_tx_buf_offset;
+	u16 tx_credits;
 };
 
 enum oa_tc6_header_type {
 	OA_TC6_CTRL_HEADER,
+	OA_TC6_DATA_HEADER,
 };
 
 enum oa_tc6_register_op {
@@ -88,14 +127,34 @@ enum oa_tc6_register_op {
 	OA_TC6_CTRL_REG_WRITE = 1,
 };
 
+enum oa_tc6_data_valid_info {
+	OA_TC6_DATA_INVALID,
+	OA_TC6_DATA_VALID,
+};
+
+enum oa_tc6_data_start_valid_info {
+	OA_TC6_DATA_START_INVALID,
+	OA_TC6_DATA_START_VALID,
+};
+
+enum oa_tc6_data_end_valid_info {
+	OA_TC6_DATA_END_INVALID,
+	OA_TC6_DATA_END_VALID,
+};
+
 static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
 			       enum oa_tc6_header_type header_type, u16 length)
 {
 	struct spi_transfer xfer = { 0 };
 	struct spi_message msg;
 
-	xfer.tx_buf = tc6->spi_ctrl_tx_buf;
-	xfer.rx_buf = tc6->spi_ctrl_rx_buf;
+	if (header_type == OA_TC6_DATA_HEADER) {
+		xfer.tx_buf = tc6->spi_data_tx_buf;
+		xfer.rx_buf = tc6->spi_data_rx_buf;
+	} else {
+		xfer.tx_buf = tc6->spi_ctrl_tx_buf;
+		xfer.rx_buf = tc6->spi_ctrl_rx_buf;
+	}
 	xfer.len = length;
 
 	spi_message_init(&msg);
@@ -578,6 +637,309 @@ static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
 }
 
+static void oa_tc6_cleanup_ongoing_tx_skb(struct oa_tc6 *tc6)
+{
+	if (tc6->ongoing_tx_skb) {
+		tc6->netdev->stats.tx_dropped++;
+		kfree_skb(tc6->ongoing_tx_skb);
+		tc6->ongoing_tx_skb = NULL;
+	}
+}
+
+static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
+{
+	u32 value;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &value);
+	if (ret) {
+		netdev_err(tc6->netdev, "STATUS0 register read failed: %d\n",
+			   ret);
+		return ret;
+	}
+
+	/* Clear the error interrupts status */
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, value);
+	if (ret) {
+		netdev_err(tc6->netdev, "STATUS0 register write failed: %d\n",
+			   ret);
+		return ret;
+	}
+
+	if (FIELD_GET(STATUS0_TX_PROTOCOL_ERROR, value)) {
+		netdev_err(tc6->netdev, "Transmit protocol error\n");
+		return -ENODEV;
+	}
+	/* TODO: Currently loss of frame and header errors are treated as
+	 * non-recoverable errors. They will be handled in the next version.
+	 */
+	if (FIELD_GET(STATUS0_LOSS_OF_FRAME_ERROR, value)) {
+		netdev_err(tc6->netdev, "Loss of frame error\n");
+		return -ENODEV;
+	}
+	if (FIELD_GET(STATUS0_HEADER_ERROR, value)) {
+		netdev_err(tc6->netdev, "Header error\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int oa_tc6_process_rx_chunk_footer(struct oa_tc6 *tc6, u32 footer)
+{
+	/* Process rx chunk footer for the following,
+	 * 1. tx credits
+	 * 2. errors if any from MAC-PHY
+	 */
+	tc6->tx_credits = FIELD_GET(OA_TC6_DATA_FOOTER_TX_CREDITS, footer);
+
+	if (FIELD_GET(OA_TC6_DATA_FOOTER_EXTENDED_STS, footer)) {
+		int ret = oa_tc6_process_extended_status(tc6);
+
+		if (ret)
+			return ret;
+	}
+
+	/* TODO: Currently received header bad and configuration unsync errors
+	 * are treated as non-recoverable errors. They will be handled in the
+	 * next version.
+	 */
+	if (FIELD_GET(OA_TC6_DATA_FOOTER_RXD_HEADER_BAD, footer)) {
+		netdev_err(tc6->netdev, "Rxd header bad error\n");
+		return -ENODEV;
+	}
+
+	if (!FIELD_GET(OA_TC6_DATA_FOOTER_CONFIG_SYNC, footer)) {
+		netdev_err(tc6->netdev, "Config unsync error\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static u32 oa_tc6_get_rx_chunk_footer(struct oa_tc6 *tc6, u16 footer_offset)
+{
+	u8 *rx_buf = tc6->spi_data_rx_buf;
+	__be32 footer;
+
+	footer = *((__be32 *)&rx_buf[footer_offset]);
+
+	return be32_to_cpu(footer);
+}
+
+static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
+{
+	u16 no_of_rx_chunks = length / OA_TC6_CHUNK_SIZE;
+	u32 footer;
+	int ret;
+
+	/* All the rx chunks in the receive SPI data buffer are examined here */
+	for (int i = 0; i < no_of_rx_chunks; i++) {
+		/* Last 4 bytes in each received chunk consist footer info */
+		footer = oa_tc6_get_rx_chunk_footer(tc6, i * OA_TC6_CHUNK_SIZE +
+						    OA_TC6_CHUNK_PAYLOAD_SIZE);
+
+		ret = oa_tc6_process_rx_chunk_footer(tc6, footer);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static __be32 oa_tc6_prepare_data_header(bool data_valid, bool start_valid,
+					 bool end_valid, u8 end_byte_offset)
+{
+	u32 header = FIELD_PREP(OA_TC6_DATA_HEADER_DATA_NOT_CTRL,
+				OA_TC6_DATA_HEADER) |
+		     FIELD_PREP(OA_TC6_DATA_HEADER_DATA_VALID, data_valid) |
+		     FIELD_PREP(OA_TC6_DATA_HEADER_START_VALID, start_valid) |
+		     FIELD_PREP(OA_TC6_DATA_HEADER_END_VALID, end_valid) |
+		     FIELD_PREP(OA_TC6_DATA_HEADER_END_BYTE_OFFSET,
+				end_byte_offset);
+
+	header |= FIELD_PREP(OA_TC6_DATA_HEADER_PARITY,
+			     oa_tc6_get_parity(header));
+
+	return cpu_to_be32(header);
+}
+
+static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc6 *tc6)
+{
+	enum oa_tc6_data_end_valid_info end_valid = OA_TC6_DATA_END_INVALID;
+	__be32 *tx_buf = tc6->spi_data_tx_buf + tc6->spi_data_tx_buf_offset;
+	u16 remaining_len = tc6->ongoing_tx_skb->len - tc6->tx_skb_offset;
+	u8 *tx_skb_data = tc6->ongoing_tx_skb->data + tc6->tx_skb_offset;
+	enum oa_tc6_data_start_valid_info start_valid;
+	u8 end_byte_offset = 0;
+	u16 length_to_copy;
+
+	/* Initial value is assigned here to avoid more than 80 characters in
+	 * the declaration place.
+	 */
+	start_valid = OA_TC6_DATA_START_INVALID;
+
+	/* Set start valid if the current tx chunk contains the start of the tx
+	 * ethernet frame.
+	 */
+	if (!tc6->tx_skb_offset)
+		start_valid = OA_TC6_DATA_START_VALID;
+
+	/* If the remaining tx skb length is more than the chunk payload size of
+	 * 64 bytes then copy only 64 bytes and leave the ongoing tx skb for
+	 * next tx chunk.
+	 */
+	length_to_copy = min_t(u16, remaining_len, OA_TC6_CHUNK_PAYLOAD_SIZE);
+
+	/* Copy the tx skb data to the tx chunk payload buffer */
+	memcpy(tx_buf + 1, tx_skb_data, length_to_copy);
+	tc6->tx_skb_offset += length_to_copy;
+
+	/* Set end valid if the current tx chunk contains the end of the tx
+	 * ethernet frame.
+	 */
+	if (tc6->ongoing_tx_skb->len == tc6->tx_skb_offset) {
+		end_valid = OA_TC6_DATA_END_VALID;
+		end_byte_offset = length_to_copy - 1;
+		tc6->tx_skb_offset = 0;
+		tc6->netdev->stats.tx_bytes += tc6->ongoing_tx_skb->len;
+		tc6->netdev->stats.tx_packets++;
+		kfree_skb(tc6->ongoing_tx_skb);
+		tc6->ongoing_tx_skb = NULL;
+	}
+
+	*tx_buf = oa_tc6_prepare_data_header(OA_TC6_DATA_VALID, start_valid,
+					     end_valid, end_byte_offset);
+	tc6->spi_data_tx_buf_offset += OA_TC6_CHUNK_SIZE;
+}
+
+static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
+{
+	u16 used_tx_credits;
+
+	/* Get tx skbs and convert them into tx chunks based on the tx credits
+	 * available.
+	 */
+	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
+	     used_tx_credits++) {
+		if (!tc6->ongoing_tx_skb) {
+			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
+			tc6->waiting_tx_skb = NULL;
+		}
+		if (!tc6->ongoing_tx_skb)
+			break;
+		oa_tc6_add_tx_skb_to_spi_buf(tc6);
+	}
+
+	return used_tx_credits * OA_TC6_CHUNK_SIZE;
+}
+
+static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
+{
+	int ret;
+
+	while (true) {
+		u16 spi_length = 0;
+
+		tc6->spi_data_tx_buf_offset = 0;
+
+		if (tc6->ongoing_tx_skb || tc6->waiting_tx_skb)
+			spi_length = oa_tc6_prepare_spi_tx_buf_for_tx_skbs(tc6);
+
+		if (spi_length == 0)
+			break;
+
+		ret = oa_tc6_spi_transfer(tc6, OA_TC6_DATA_HEADER, spi_length);
+		if (ret) {
+			netdev_err(tc6->netdev, "SPI data transfer failed: %d\n",
+				   ret);
+			return ret;
+		}
+
+		ret = oa_tc6_process_spi_data_rx_buf(tc6, spi_length);
+		if (ret) {
+			oa_tc6_cleanup_ongoing_tx_skb(tc6);
+			netdev_err(tc6->netdev, "Device error: %d\n", ret);
+			return ret;
+		}
+
+		if (!tc6->waiting_tx_skb && netif_queue_stopped(tc6->netdev))
+			netif_wake_queue(tc6->netdev);
+	}
+
+	return 0;
+}
+
+static int oa_tc6_spi_thread_handler(void *data)
+{
+	struct oa_tc6 *tc6 = data;
+	int ret;
+
+	while (likely(!kthread_should_stop())) {
+		/* This kthread will be waken up if there is a tx skb */
+		wait_event_interruptible(tc6->spi_wq, tc6->waiting_tx_skb ||
+					 kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		ret = oa_tc6_try_spi_transfer(tc6);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int oa_tc6_update_buffer_status_from_register(struct oa_tc6 *tc6)
+{
+	u32 value;
+	int ret;
+
+	/* Initially tx credits to be updated from the register as there is no
+	 * data transfer performed yet. Later it will be updated from the rx
+	 * footer.
+	 */
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_BUFFER_STATUS, &value);
+	if (ret)
+		return ret;
+
+	tc6->tx_credits = FIELD_GET(BUFFER_STATUS_TX_CREDITS_AVAILABLE, value);
+
+	return 0;
+}
+
+/**
+ * oa_tc6_start_xmit - function for sending the tx skb which consists ethernet
+ * frame.
+ * @tc6: oa_tc6 struct.
+ * @skb: socket buffer in which the ethernet frame is stored.
+ *
+ * Return: NETDEV_TX_OK if the transmit ethernet frame skb added in the tx_skb_q
+ * otherwise returns NETDEV_TX_BUSY.
+ */
+netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
+{
+	if (tc6->waiting_tx_skb) {
+		netif_stop_queue(tc6->netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	if (skb_linearize(skb)) {
+		dev_kfree_skb_any(skb);
+		tc6->netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	tc6->waiting_tx_skb = skb;
+
+	/* Wake spi kthread to perform spi transfer */
+	wake_up_interruptible(&tc6->spi_wq);
+
+	return NETDEV_TX_OK;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_start_xmit);
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -616,6 +978,18 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	if (!tc6->spi_ctrl_rx_buf)
 		return NULL;
 
+	tc6->spi_data_tx_buf = devm_kzalloc(&tc6->spi->dev,
+					    OA_TC6_SPI_DATA_BUF_SIZE,
+					    GFP_KERNEL);
+	if (!tc6->spi_data_tx_buf)
+		return NULL;
+
+	tc6->spi_data_rx_buf = devm_kzalloc(&tc6->spi->dev,
+					    OA_TC6_SPI_DATA_BUF_SIZE,
+					    GFP_KERNEL);
+	if (!tc6->spi_data_rx_buf)
+		return NULL;
+
 	ret = oa_tc6_sw_reset_macphy(tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev,
@@ -644,6 +1018,24 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 		goto phy_exit;
 	}
 
+	ret = oa_tc6_update_buffer_status_from_register(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"Failed to update buffer status: %d\n", ret);
+		goto phy_exit;
+	}
+
+	init_waitqueue_head(&tc6->spi_wq);
+
+	tc6->spi_thread = kthread_run(oa_tc6_spi_thread_handler, tc6,
+				      "oa-tc6-spi-thread");
+	if (IS_ERR(tc6->spi_thread)) {
+		dev_err(&tc6->spi->dev, "Failed to create SPI thread\n");
+		goto phy_exit;
+	}
+
+	sched_set_fifo(tc6->spi_thread);
+
 	return tc6;
 
 phy_exit:
@@ -659,6 +1051,9 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
 void oa_tc6_exit(struct oa_tc6 *tc6)
 {
 	oa_tc6_phy_exit(tc6);
+	kthread_stop(tc6->spi_thread);
+	dev_kfree_skb_any(tc6->ongoing_tx_skb);
+	dev_kfree_skb_any(tc6->waiting_tx_skb);
 }
 EXPORT_SYMBOL_GPL(oa_tc6_exit);
 
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 606ba9f1e663..5c7811ac9cbe 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -20,3 +20,4 @@ int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value);
 int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
+netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
-- 
2.34.1


