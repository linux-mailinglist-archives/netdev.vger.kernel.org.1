Return-Path: <netdev+bounces-287216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH5mHL5JA2pU2wEAu9opvQ
	(envelope-from <netdev+bounces-287216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9800523D72
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EC2312C36F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0AB37F013;
	Tue, 12 May 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="laO2BdjE"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B76351C1E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599201; cv=none; b=owlxj/Tim2OnS9booGaaDv7v1fsennWqOR17AxOtoqg6NHdVZoHz4Yh+AN0zXRy0KW1nhkF9ePqPOT/SRi4kl2xjmJ8Dauuhkdlgid7b+OBdj0mgDntyzPSEOJKxytp8mS1ePFFdif5z2ED/LtNQkBrpyGwT9jZ0IQAhrBTueak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599201; c=relaxed/simple;
	bh=Rr0yOvAy2OYroBskmrPRn9iLt4GOBaitmk181FxRCMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=mQOzBB+guBPV++m3R6yaybV7TUrjBkPLWQmBf+LpoUYN1eZFHb2TR6Olw/QAEri80ZVDrmbMRmB2J0+XXa16H4FolMY16Mluf4RE3f7LRGj4FKS6dUSkN7yxRD+xTP020ceRV5sgNrthfoEEhe51jbSdPKfY+avTa8YjzkTTGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=laO2BdjE; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260512151955euoutp016e4c91b6065fa53110771733ba2dd51e~u2ouDlGIT0643506435euoutp01w
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:19:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260512151955euoutp016e4c91b6065fa53110771733ba2dd51e~u2ouDlGIT0643506435euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778599195;
	bh=AgY2OB4EE/GBB0Q06D8Y0dnBBrNdPXCQ0AmSvJOFd0Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=laO2BdjE/BY38dpji3ytsuyzbKrG7XW7FjkJ2IJANKiuIMkiEAkb9Hf7lfxmDm4AC
	 BIE9YQGv7+M08t+eLI/KKTz1wYonuuIZtx18WuLpdnoMrTZKckllvk5HLI3uaM2Pyx
	 40oRXfTcvgeDtQKenJNdMj2hAdqTUwGJ6xZZ+tcg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f~u2otylPS91976719767eucas1p1y;
	Tue, 12 May 2026 15:19:55 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260512151954eusmtip15b006a12ad6578d9275edde4f60fab02~u2otSs7ZN2746327463eusmtip1d;
	Tue, 12 May 2026 15:19:54 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kuba@kernel.org, Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH v2 net-next] net/sun: Fix multiple typos in comments
Date: Tue, 12 May 2026 17:19:32 +0200
Message-Id: <20260512151931.3576906-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f
X-EPHeader: CA
X-CMS-RootMailID: 20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f
References: <CGME20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f@eucas1p1.samsung.com>
X-Rspamd-Queue-Id: C9800523D72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Action: no action

There are some typos in comments and while they are harmless and not visible,
there is no reason not to fix them. Fix the ones that are not register related,
which might have intentional naming convention.
Also fix double spaces in lines where typos are fixed, but don't change any
other double spaces, since it would obfuscate typo changes.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
Link to v1:
https://lore.kernel.org/kernel-janitors/20260428101728.3537456-1-j.raczynski@samsung.com/

Changes in v2:
- Fix typo within typo fix ('empirical' word)
- Change autoneg related sentence to make sense
- Fix double spaces in lines where typos are fixed.
  Add annotation to commit message why only these

 drivers/net/ethernet/sun/cassini.c | 10 +++++-----
 drivers/net/ethernet/sun/cassini.h | 16 ++++++++--------
 drivers/net/ethernet/sun/sunbmac.h |  2 +-
 drivers/net/ethernet/sun/sungem.c  |  4 ++--
 drivers/net/ethernet/sun/sungem.h  |  4 ++--
 drivers/net/ethernet/sun/sunhme.c  |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index fe00e7dd3fe4..860d16a826bf 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1029,7 +1029,7 @@ static int cas_pcs_link_check(struct cas *cp)
 			 * point a bit earlier in the sequence. If we had
 			 * generated a reset a short time ago, we'll wait for
 			 * the link timer to check the status until a
-			 * timer expires (link_transistion_jiffies_valid is
+			 * timer expires (link_transition_jiffies_valid is
 			 * true when the timer is running.)  Instead of using
 			 * a system timer, we just do a check whenever the
 			 * link timer is running - this clears the flag after
@@ -4547,9 +4547,9 @@ static int cas_get_link_ksettings(struct net_device *dev,
 	}
 	if (linkstate != link_up) {
 		/* Force these to "unknown" if the link is not up and
-		 * autonogotiation in enabled. We can set the link
+		 * autonegotiation is enabled. We can set the link
 		 * speed to 0, but not cmd->duplex,
-		 * because its legal values are 0 and 1.  Ethtool will
+		 * because its legal values are 0 and 1. Ethtool will
 		 * print the value reported in parentheses after the
 		 * word "Unknown" for unrecognized values.
 		 *
@@ -4799,7 +4799,7 @@ static void cas_program_bridge(struct pci_dev *cas_pdev)
 	 */
 	pci_write_config_word(pdev, 0x50, (5 << 10) | 0x3ff);
 
-	/* The Read Prefecth Policy register is 16-bit and sits at
+	/* The Read Prefetch Policy register is 16-bit and sits at
 	 * offset 0x52.  It enables a "smart" pre-fetch policy.  We
 	 * enable it and max out all of the settings since only one
 	 * device is sitting underneath and thus bandwidth sharing is
@@ -4906,7 +4906,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/*
 	 * On some architectures, the default cache line size set
-	 * by pci_try_set_mwi reduces perforamnce.  We have to increase
+	 * by pci_try_set_mwi reduces performance. We have to increase
 	 * it for this case.  To start, we'll print some configuration
 	 * data.
 	 */
diff --git a/drivers/net/ethernet/sun/cassini.h b/drivers/net/ethernet/sun/cassini.h
index 2d91f4936d52..0c24547a4534 100644
--- a/drivers/net/ethernet/sun/cassini.h
+++ b/drivers/net/ethernet/sun/cassini.h
@@ -259,7 +259,7 @@
 
 /* output enables are provided for each device's chip select and for the rest
  * of the outputs from cassini to its local bus devices. two sw programmable
- * bits are connected to general purpus control/status bits.
+ * bits are connected to general purpose control/status bits.
  * DEFAULT: 0x7
  */
 #define  REG_BIM_LOCAL_DEV_EN          0x1020  /* BIM local device
@@ -404,7 +404,7 @@
 						    GMII on SERDES pins for
 						    monitoring. */
 #define   SATURN_PCFG_FSI             0x00000200 /* 1 = freeze serdes/gmii. all
-						    pins configed as outputs.
+						    pins configured as outputs.
 						    for power saving when using
 						    internal phy. */
 #define   SATURN_PCFG_LAD             0x00000800 /* 0 = mac core led ctrl
@@ -622,7 +622,7 @@
 						      enabled */
 #define    RX_CFG_SWIVEL_MASK           0x00001C00 /* byte offset of the 1st
 						      data byte of the packet
-						      w/in 8 byte boundares.
+						      w/in 8 byte boundaries.
 						      this swivels the data
 						      DMA'ed to header
 						      buffers, jumbo buffers
@@ -1248,7 +1248,7 @@
  */
 #define  REG_MAC_TX_STATUS                 0x6010  /* TX MAC status reg */
 #define    MAC_TX_FRAME_XMIT               0x0001  /* successful frame
-						      transmision */
+						      transmission */
 #define    MAC_TX_UNDERRUN                 0x0002  /* terminated frame
 						      transmission due to
 						      data starvation in the
@@ -1414,7 +1414,7 @@
  * when passed to the host. to ensure proper operation, need to wait 3.2ms
  * after clearing RX_CFG_EN before writing to any other RX MAC registers
  * or other MAC parameters. alternatively, poll RX_CFG_EN until it clears
- * to 0. similary, HASH_FILTER_EN and ADDR_FILTER_EN have the same
+ * to 0. Similarly, HASH_FILTER_EN and ADDR_FILTER_EN have the same
  * restrictions as CFG_EN.
  */
 #define  REG_MAC_RX_CFG                 0x6034  /* RX MAC config reg */
@@ -1670,7 +1670,7 @@
  * programmed in frame mode. load this register w/ a valid instruction
  * (as per IEEE 802.3u MII spec). poll this register to check for instruction
  * execution completion. during a read operation, this register will also
- * contain the 16-bit data returned by the tranceiver. unless specified
+ * contain the 16-bit data returned by the transceiver. unless specified
  * otherwise, fields are considered "don't care" when polling for
  * completion.
  */
@@ -1734,7 +1734,7 @@
 #define    MIF_CFG_POLL_REG_SHIFT       3
 #define    MIF_CFG_MDIO_0               0x0100 /* (ro) dual purpose.
 						  when MDIO_0 is idle,
-						  1 -> tranceiver is
+						  1 -> transceiver is
 						  connected to MDIO_0.
 						  when MIF is communicating
 						  w/ MDIO_0 in bit-bang
@@ -1750,7 +1750,7 @@
 						  mode, this bit indicates
 						  the incoming bit stream
 						  during a read op */
-#define    MIF_CFG_POLL_PHY_MASK        0x7C00 /* tranceiver address to
+#define    MIF_CFG_POLL_PHY_MASK        0x7C00 /* transceiver address to
 						  be polled */
 #define    MIF_CFG_POLL_PHY_SHIFT       10
 
diff --git a/drivers/net/ethernet/sun/sunbmac.h b/drivers/net/ethernet/sun/sunbmac.h
index d379bd407eca..85778edcf8dc 100644
--- a/drivers/net/ethernet/sun/sunbmac.h
+++ b/drivers/net/ethernet/sun/sunbmac.h
@@ -205,7 +205,7 @@
 #define FRAME_WRITE           0x50020000
 #define FRAME_READ            0x60020000
 
-/* Tranceiver registers. */
+/* Transceiver registers. */
 #define TCVR_PAL_SERIAL       0x00000001 /* Enable serial mode              */
 #define TCVR_PAL_EXTLBACK     0x00000002 /* Enable external loopback        */
 #define TCVR_PAL_MSENSE       0x00000004 /* Media sense                     */
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 8e69d917d827..35c3226ce719 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2187,7 +2187,7 @@ static void gem_do_stop(struct net_device *dev, int wol)
 	 * if we did. This is not an issue however as the reset
 	 * task is synchronized vs. us (rtnl_lock) and will do
 	 * nothing if the device is down or suspended. We do
-	 * still clear reset_task_pending to avoid a spurrious
+	 * still clear reset_task_pending to avoid a spurious
 	 * reset later on in case we do resume before it gets
 	 * scheduled.
 	 */
@@ -2370,7 +2370,7 @@ static int __maybe_unused gem_resume(struct device *dev_d)
 	gem_do_start(dev);
 
 	/* If we had WOL enabled, the cell clock was never turned off during
-	 * sleep, so we end up beeing unbalanced. Fix that here
+	 * sleep, so we end up being unbalanced. Fix that here
 	 */
 	if (gp->asleep_wol)
 		gem_put_cell(gp);
diff --git a/drivers/net/ethernet/sun/sungem.h b/drivers/net/ethernet/sun/sungem.h
index 626302a9bc89..b921d3074017 100644
--- a/drivers/net/ethernet/sun/sungem.h
+++ b/drivers/net/ethernet/sun/sungem.h
@@ -352,7 +352,7 @@
 #define MAC_HASH14	0x60F8UL	/* Hash Table 14 Register	*/
 #define MAC_HASH15	0x60FCUL	/* Hash Table 15 Register	*/
 #define MAC_NCOLL	0x6100UL	/* Normal Collision Counter	*/
-#define MAC_FASUCC	0x6104UL	/* First Attmpt. Succ Coll Ctr.	*/
+#define MAC_FASUCC	0x6104UL	/* First Attempt. Succ Coll Ctr.*/
 #define MAC_ECOLL	0x6108UL	/* Excessive Collision Counter	*/
 #define MAC_LCOLL	0x610CUL	/* Late Collision Counter	*/
 #define MAC_DTIMER	0x6110UL	/* Defer Timer			*/
@@ -657,7 +657,7 @@
 
 /* MIF Frame/Output Register.  This 32-bit register allows the host to
  * communicate with a transceiver in frame mode (as opposed to big-bang
- * mode).  Writes by the host specify an instrution.  After being issued
+ * mode). Writes by the host specify an instruction. After being issued
  * the host must poll this register for completion.  Also, after
  * completion this register holds the data returned by the transceiver
  * if applicable.
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 4c9d5d4dd8a0..a70f704eb9f3 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -1118,7 +1118,7 @@ static void happy_meal_transceiver_check(struct happy_meal *hp, void __iomem *tr
  *
  * We use skb_reserve() to align the data block we get in the skb.  We
  * also program the etxregs->cfg register to use an offset of 2.  This
- * imperical constant plus the ethernet header size will always leave
+ * empirical constant plus the ethernet header size will always leave
  * us with a nicely aligned ip header once we pass things up to the
  * protocol layers.
  *
-- 
2.34.1


