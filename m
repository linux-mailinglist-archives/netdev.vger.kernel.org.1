Return-Path: <netdev+bounces-281869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEyMCzm08GnsXQEAu9opvQ
	(envelope-from <netdev+bounces-281869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A5485B9F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B72E314D378
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134AA4611CA;
	Tue, 28 Apr 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gS3ab7LT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB83EB7F0;
	Tue, 28 Apr 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381704; cv=none; b=EjNankI5ZoXY3dB8MFoOOgbL9/qLB2/vDLn+tvSH83bQNGhVvuuaUCjI2O+tjneDUPB/gEox3oPUgWGq8I11yJH/xE4DrtAZwCBX75jUm7B8qC2Oevsg+D30RGmS43eooyVHHxBy69+La1Iw0RdAoh8plzGDoczDuQ2bwCnUXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381704; c=relaxed/simple;
	bh=etgNE0cJiajiEqQmTuWQ7M6vjwIb6tR29mmXtwAcUIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uy65XdmzC4EM0G239YG/9Le6H3lBMuNOx1qWDhE0tCWK7EycgkAY9F8AkNSjPAFmsm8tjIaP9nVLiK1Og2ArjjH8c3y8ljXo2WPydcPAMA8Xl/t2kwciIYwa59lqsn6J3mx5fuCH4fxLK/HlpLuIfgT3f4bSnmRjP1yaC/coMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gS3ab7LT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381702; x=1808917702;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=etgNE0cJiajiEqQmTuWQ7M6vjwIb6tR29mmXtwAcUIs=;
  b=gS3ab7LTz1w9OKFOjmePmKsMiKxInO+sBPvlgaZbEvEsG2h5Vh1I3PkI
   N2qXzm7ZB4marEOpBLbjnyxeQ+7Vzsur2R510jMGXPsnnNR6M1JopbJ7+
   yCIqED5LLtQzQ9b3gbc7hlkjMy3peJlNGrh1itozmLtTunTNPlDlTE1PG
   UkLm08XBallGYp5t0LwP+o9SvYlsIJ67JIwQwARt0nZuH8aOT4kiryQiV
   Ry6eR4s2Ewgvy2b+KjUDz+V4YEG4XoyesxocFxXEnsOQjSSYJUPepOngv
   FoepSlQT5qdHWw22Rs04vrdX9KnzVOeydpsi5DOrRSx/HKWtlnotN9b3Y
   w==;
X-CSE-ConnectionGUID: tIebLSBFSYq1E2yHaJt67A==
X-CSE-MsgGUID: HSHHY2x+QMmQBZK3Z/CEnw==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="64844183"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 06:08:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Apr 2026 06:07:24 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:21 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:06:53 +0200
Subject: [PATCH net-next v2 04/13] net: lan966x: add FDMA LLP register
 write helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-4-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 9D6A5485B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The FDMA Link List Pointer (LLP) register points to the first DCB in the
chain and must be written before the channel is activated. This tells
the FDMA engine where to begin DMA transfers.

Move the LLP register writes from the channel start/activate functions
into the allocation functions and introduce a shared
lan966x_fdma_llp_configure() helper. This is needed because the upcoming
PCIe FDMA path writes ATU-translated addresses to the LLP registers
instead of DMA addresses. Keeping the writes in the shared
start/activate path would overwrite these translated addresses.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 29 ++++++++++------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index f8ce735a7fc0..6c5761e886d4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -109,6 +109,13 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 	return PTR_ERR_OR_ZERO(rx->page_pool);
 }
 
+static void lan966x_fdma_llp_configure(struct lan966x *lan966x, u64 addr,
+				       u8 channel_id)
+{
+	lan_wr(lower_32_bits(addr), lan966x, FDMA_DCB_LLP(channel_id));
+	lan_wr(upper_32_bits(addr), lan966x, FDMA_DCB_LLP1(channel_id));
+}
+
 static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
@@ -127,6 +134,9 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
 
+	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
+				   fdma->channel_id);
+
 	return 0;
 }
 
@@ -136,14 +146,6 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 	u32 mask;
 
-	/* When activating a channel, first is required to write the first DCB
-	 * address and then to activate it
-	 */
-	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP(fdma->channel_id));
-	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP1(fdma->channel_id));
-
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
@@ -214,6 +216,9 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 
 	fdma_dcbs_init(fdma, 0, 0);
 
+	lan966x_fdma_llp_configure(lan966x, (u64)fdma->dma,
+				   fdma->channel_id);
+
 	return 0;
 
 out:
@@ -235,14 +240,6 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 	struct fdma *fdma = &tx->fdma;
 	u32 mask;
 
-	/* When activating a channel, first is required to write the first DCB
-	 * address and then to activate it
-	 */
-	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP(fdma->channel_id));
-	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP1(fdma->channel_id));
-
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |

-- 
2.34.1


