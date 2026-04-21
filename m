Return-Path: <netdev+bounces-280225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMnAGv3R52k4BAIAu9opvQ
	(envelope-from <netdev+bounces-280225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCE43F057
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BDD308EA3D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80643DD505;
	Tue, 21 Apr 2026 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BAhP6voP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01806382F07;
	Tue, 21 Apr 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799902; cv=none; b=NTjAjPDFcZCs2KIkEZcwC3odxY1/gf5ClMUYh+RNHHUxPgvxJcVismeXGj+TECFwYNwq1h2/AUShWPVO2hFziGJWR4lEtPCYLVBybbDp2uwtjOu4YkSORGbJ4J7zAGa+8WAmZ3kNeId8T/lIu7oYUnrVUEVH55Z3hlvi3K5aU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799902; c=relaxed/simple;
	bh=QzVjYhlVs8O7FjQC4I9T81l+70WbEErYqShy73VvZx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXsnSRwB+vHtn1ChK8UQwBsbg6AbW4Azf8NWFthExJEQTMBRJmZLM7G8viprkHKKdTaHD5jA4KHLY+ghbyVzG3hQpSpO9teRaBK9X8k54kFzFM5tpbXwZVh/h5549Hy/AUrbl3fh82QFzggBOntdv8QuaDVbVYajxW9B7ZVJtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BAhP6voP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0BqQhgcpaaIsToikKUuvpKUZ1Hg++TGl3gSSbJqq5LM=; b=BA
	hP6voP041GK1qxe6nKCGHri3IL+rN4DOKCDZo3YlHUBa3cF5HjaPRq3KsuAZ/Txbh3F5ehycZWuqR
	86y6rWXXdiUBX13FaFO7HAXG6+pWokAzWhxBcF6LTHr2yaFONQVYopvP9Et5GZKGurOdW9Xu4Ay56
	3/1CWOBhrpYH+5c=;
Received: from c-66-41-74-139.hsd1.mn.comcast.net ([66.41.74.139] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFGom-00GwVc-04; Tue, 21 Apr 2026 21:31:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 21 Apr 2026 14:31:09 -0500
Subject: [PATCH net 06/18] drivers: net: amd: Remove hplance and mvme147
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-v7-0-0-net-next-driver-removal-v1-v1-6-69517c689d1f@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=47473; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=QzVjYhlVs8O7FjQC4I9T81l+70WbEErYqShy73VvZx4=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBp59CBmWCGp3YB3NfOaoRv40h1hti4pS1FzI0/g
 M4Pb3vNh4eJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaefQgQAKCRDmvw3LpmlM
 hGyMD/9ZQSqFlPuLUTEfXB+JOVf93IZYC1fOv1ZstXCURLavtMO0CCMhnqcvYni6NThIdnHuoeY
 S1r2PoyjkSq2v7fRNpKd6AunAXophAE4ySvP3v+EqaHIKNwqyGggBSpVIodZ1hu8RVsJ6ViSh7C
 SJeUSLiQ+d+1ilAibyeS+kKcLcOqIBykwNpm+MrU/Cc8BKCvdpps6qL2iguW3eQwMhOTYJVfmE5
 OtCf4wWcRbWxKGJq9ztmE4cSAIPIBtvYtRGbCpwqnQRvxIOqK/njbwnJqktDkBEdgR4AOEf0Di/
 rWma2IFh5R73qXMwmt7LGrtGSHG+DcWMITF4dSEWU3UrLiQdddfuebxi3qbHIuKBEpWMLly4NHJ
 wZlrMDL9vrjD3voCp7+uPqtc5rumeLs8Z+5iKs9xS7E1PWV+IpzrsQVXHJ5Z1iPA6TujjaVlke9
 rm8WN2u10BVxC4N9W8ogs4XQu32lAUjA4W28MCsGOgvCQH8FCMARDagrGtErgDxD/e74anznzaT
 v35JQWeRfp03CIuVf8Dev8H8AlZ0hO4I8V6GHF0OXIVgULDb2kDgIDpmfZWoCcMfcU5FHrSyQd0
 6Q7Qkx2IBCiqLfJ81AXpN6uL/iSE5Aq3q2XZAhgvQQxZ4qTUQRvaj37SLhz8N+oR6llLhIIqrS3
 XehBlrlPXEHIXew==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280225-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[greenend.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 9AFCE43F057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These drivers use the 7990 core with wrappers for the HP300 and
Motorola MVME147 SBC circa 1998. It is unlikely they are used with a
modern kernel.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/amd/7990.c    | 671 -------------------------------------
 drivers/net/ethernet/amd/7990.h    | 251 --------------
 drivers/net/ethernet/amd/Kconfig   |  18 -
 drivers/net/ethernet/amd/Makefile  |   2 -
 drivers/net/ethernet/amd/hplance.c | 238 -------------
 drivers/net/ethernet/amd/hplance.h |  27 --
 drivers/net/ethernet/amd/mvme147.c | 198 -----------
 7 files changed, 1405 deletions(-)

diff --git a/drivers/net/ethernet/amd/7990.c b/drivers/net/ethernet/amd/7990.c
deleted file mode 100644
index 27792a52b6cf..000000000000
--- a/drivers/net/ethernet/amd/7990.c
+++ /dev/null
@@ -1,671 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * 7990.c -- LANCE ethernet IC generic routines.
- * This is an attempt to separate out the bits of various ethernet
- * drivers that are common because they all use the AMD 7990 LANCE
- * (Local Area Network Controller for Ethernet) chip.
- *
- * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
- *
- * Most of this stuff was obtained by looking at other LANCE drivers,
- * in particular a2065.[ch]. The AMD C-LANCE datasheet was also helpful.
- * NB: this was made easy by the fact that Jes Sorensen had cleaned up
- * most of a2025 and sunlance with the aim of merging them, so the
- * common code was pretty obvious.
- */
-#include <linux/crc32.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/in.h>
-#include <linux/route.h>
-#include <linux/string.h>
-#include <linux/skbuff.h>
-#include <linux/pgtable.h>
-#include <asm/irq.h>
-/* Used for the temporal inet entries and routing */
-#include <linux/socket.h>
-#include <linux/bitops.h>
-
-#include <asm/io.h>
-#include <asm/dma.h>
-#ifdef CONFIG_HP300
-#include <asm/blinken.h>
-#endif
-
-#include "7990.h"
-
-#define WRITERAP(lp, x)	out_be16(lp->base + LANCE_RAP, (x))
-#define WRITERDP(lp, x)	out_be16(lp->base + LANCE_RDP, (x))
-#define READRDP(lp)	in_be16(lp->base + LANCE_RDP)
-
-#if IS_ENABLED(CONFIG_HPLANCE)
-#include "hplance.h"
-
-#undef WRITERAP
-#undef WRITERDP
-#undef READRDP
-
-#if IS_ENABLED(CONFIG_MVME147_NET)
-
-/* Lossage Factor Nine, Mr Sulu. */
-#define WRITERAP(lp, x)	(lp->writerap(lp, x))
-#define WRITERDP(lp, x)	(lp->writerdp(lp, x))
-#define READRDP(lp)	(lp->readrdp(lp))
-
-#else
-
-/* These inlines can be used if only CONFIG_HPLANCE is defined */
-static inline void WRITERAP(struct lance_private *lp, __u16 value)
-{
-	do {
-		out_be16(lp->base + HPLANCE_REGOFF + LANCE_RAP, value);
-	} while ((in_8(lp->base + HPLANCE_STATUS) & LE_ACK) == 0);
-}
-
-static inline void WRITERDP(struct lance_private *lp, __u16 value)
-{
-	do {
-		out_be16(lp->base + HPLANCE_REGOFF + LANCE_RDP, value);
-	} while ((in_8(lp->base + HPLANCE_STATUS) & LE_ACK) == 0);
-}
-
-static inline __u16 READRDP(struct lance_private *lp)
-{
-	__u16 value;
-	do {
-		value = in_be16(lp->base + HPLANCE_REGOFF + LANCE_RDP);
-	} while ((in_8(lp->base + HPLANCE_STATUS) & LE_ACK) == 0);
-	return value;
-}
-
-#endif
-#endif /* IS_ENABLED(CONFIG_HPLANCE) */
-
-/* debugging output macros, various flavours */
-/* #define TEST_HITS */
-#ifdef UNDEF
-#define PRINT_RINGS() \
-do { \
-	int t; \
-	for (t = 0; t < RX_RING_SIZE; t++) { \
-		printk("R%d: @(%02X %04X) len %04X, mblen %04X, bits %02X\n", \
-		       t, ib->brx_ring[t].rmd1_hadr, ib->brx_ring[t].rmd0, \
-		       ib->brx_ring[t].length, \
-		       ib->brx_ring[t].mblength, ib->brx_ring[t].rmd1_bits); \
-	} \
-	for (t = 0; t < TX_RING_SIZE; t++) { \
-		printk("T%d: @(%02X %04X) len %04X, misc %04X, bits %02X\n", \
-		       t, ib->btx_ring[t].tmd1_hadr, ib->btx_ring[t].tmd0, \
-		       ib->btx_ring[t].length, \
-		       ib->btx_ring[t].misc, ib->btx_ring[t].tmd1_bits); \
-	} \
-} while (0)
-#else
-#define PRINT_RINGS()
-#endif
-
-/* Load the CSR registers. The LANCE has to be STOPped when we do this! */
-static void load_csrs(struct lance_private *lp)
-{
-	volatile struct lance_init_block *aib = lp->lance_init_block;
-	int leptr;
-
-	leptr = LANCE_ADDR(aib);
-
-	WRITERAP(lp, LE_CSR1);                    /* load address of init block */
-	WRITERDP(lp, leptr & 0xFFFF);
-	WRITERAP(lp, LE_CSR2);
-	WRITERDP(lp, leptr >> 16);
-	WRITERAP(lp, LE_CSR3);
-	WRITERDP(lp, lp->busmaster_regval);       /* set byteswap/ALEctrl/byte ctrl */
-
-	/* Point back to csr0 */
-	WRITERAP(lp, LE_CSR0);
-}
-
-/* #define to 0 or 1 appropriately */
-#define DEBUG_IRING 0
-/* Set up the Lance Rx and Tx rings and the init block */
-static void lance_init_ring(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	volatile struct lance_init_block *ib = lp->init_block;
-	volatile struct lance_init_block *aib; /* for LANCE_ADDR computations */
-	int leptr;
-	int i;
-
-	aib = lp->lance_init_block;
-
-	lp->rx_new = lp->tx_new = 0;
-	lp->rx_old = lp->tx_old = 0;
-
-	ib->mode = LE_MO_PROM;                             /* normal, enable Tx & Rx */
-
-	/* Copy the ethernet address to the lance init block
-	 * Notice that we do a byteswap if we're big endian.
-	 * [I think this is the right criterion; at least, sunlance,
-	 * a2065 and atarilance do the byteswap and lance.c (PC) doesn't.
-	 * However, the datasheet says that the BSWAP bit doesn't affect
-	 * the init block, so surely it should be low byte first for
-	 * everybody? Um.]
-	 * We could define the ib->physaddr as three 16bit values and
-	 * use (addr[1] << 8) | addr[0] & co, but this is more efficient.
-	 */
-#ifdef __BIG_ENDIAN
-	ib->phys_addr[0] = dev->dev_addr[1];
-	ib->phys_addr[1] = dev->dev_addr[0];
-	ib->phys_addr[2] = dev->dev_addr[3];
-	ib->phys_addr[3] = dev->dev_addr[2];
-	ib->phys_addr[4] = dev->dev_addr[5];
-	ib->phys_addr[5] = dev->dev_addr[4];
-#else
-	for (i = 0; i < 6; i++)
-	       ib->phys_addr[i] = dev->dev_addr[i];
-#endif
-
-	if (DEBUG_IRING)
-		printk("TX rings:\n");
-
-	lp->tx_full = 0;
-	/* Setup the Tx ring entries */
-	for (i = 0; i < (1 << lp->lance_log_tx_bufs); i++) {
-		leptr = LANCE_ADDR(&aib->tx_buf[i][0]);
-		ib->btx_ring[i].tmd0      = leptr;
-		ib->btx_ring[i].tmd1_hadr = leptr >> 16;
-		ib->btx_ring[i].tmd1_bits = 0;
-		ib->btx_ring[i].length    = 0xf000; /* The ones required by tmd2 */
-		ib->btx_ring[i].misc      = 0;
-		if (DEBUG_IRING)
-			printk("%d: 0x%8.8x\n", i, leptr);
-	}
-
-	/* Setup the Rx ring entries */
-	if (DEBUG_IRING)
-		printk("RX rings:\n");
-	for (i = 0; i < (1 << lp->lance_log_rx_bufs); i++) {
-		leptr = LANCE_ADDR(&aib->rx_buf[i][0]);
-
-		ib->brx_ring[i].rmd0      = leptr;
-		ib->brx_ring[i].rmd1_hadr = leptr >> 16;
-		ib->brx_ring[i].rmd1_bits = LE_R1_OWN;
-		/* 0xf000 == bits that must be one (reserved, presumably) */
-		ib->brx_ring[i].length    = -RX_BUFF_SIZE | 0xf000;
-		ib->brx_ring[i].mblength  = 0;
-		if (DEBUG_IRING)
-			printk("%d: 0x%8.8x\n", i, leptr);
-	}
-
-	/* Setup the initialization block */
-
-	/* Setup rx descriptor pointer */
-	leptr = LANCE_ADDR(&aib->brx_ring);
-	ib->rx_len = (lp->lance_log_rx_bufs << 13) | (leptr >> 16);
-	ib->rx_ptr = leptr;
-	if (DEBUG_IRING)
-		printk("RX ptr: %8.8x\n", leptr);
-
-	/* Setup tx descriptor pointer */
-	leptr = LANCE_ADDR(&aib->btx_ring);
-	ib->tx_len = (lp->lance_log_tx_bufs << 13) | (leptr >> 16);
-	ib->tx_ptr = leptr;
-	if (DEBUG_IRING)
-		printk("TX ptr: %8.8x\n", leptr);
-
-	/* Clear the multicast filter */
-	ib->filter[0] = 0;
-	ib->filter[1] = 0;
-	PRINT_RINGS();
-}
-
-/* LANCE must be STOPped before we do this, too... */
-static int init_restart_lance(struct lance_private *lp)
-{
-	int i;
-
-	WRITERAP(lp, LE_CSR0);
-	WRITERDP(lp, LE_C0_INIT);
-
-	/* Need a hook here for sunlance ledma stuff */
-
-	/* Wait for the lance to complete initialization */
-	for (i = 0; (i < 100) && !(READRDP(lp) & (LE_C0_ERR | LE_C0_IDON)); i++)
-		barrier();
-	if ((i == 100) || (READRDP(lp) & LE_C0_ERR)) {
-		printk("LANCE unopened after %d ticks, csr0=%4.4x.\n", i, READRDP(lp));
-		return -1;
-	}
-
-	/* Clear IDON by writing a "1", enable interrupts and start lance */
-	WRITERDP(lp, LE_C0_IDON);
-	WRITERDP(lp, LE_C0_INEA | LE_C0_STRT);
-
-	return 0;
-}
-
-static int lance_reset(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	int status;
-
-	/* Stop the lance */
-	WRITERAP(lp, LE_CSR0);
-	WRITERDP(lp, LE_C0_STOP);
-
-	load_csrs(lp);
-	lance_init_ring(dev);
-	netif_trans_update(dev); /* prevent tx timeout */
-	status = init_restart_lance(lp);
-#ifdef DEBUG_DRIVER
-	printk("Lance restart=%d\n", status);
-#endif
-	return status;
-}
-
-static int lance_rx(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	volatile struct lance_init_block *ib = lp->init_block;
-	volatile struct lance_rx_desc *rd;
-	unsigned char bits;
-#ifdef TEST_HITS
-	int i;
-#endif
-
-#ifdef TEST_HITS
-	printk("[");
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		if (i == lp->rx_new)
-			printk("%s",
-			       ib->brx_ring[i].rmd1_bits & LE_R1_OWN ? "_" : "X");
-		else
-			printk("%s",
-			      ib->brx_ring[i].rmd1_bits & LE_R1_OWN ? "." : "1");
-	}
-	printk("]");
-#endif
-#ifdef CONFIG_HP300
-	blinken_leds(0x40, 0);
-#endif
-	WRITERDP(lp, LE_C0_RINT | LE_C0_INEA);     /* ack Rx int, reenable ints */
-	for (rd = &ib->brx_ring[lp->rx_new];     /* For each Rx ring we own... */
-	     !((bits = rd->rmd1_bits) & LE_R1_OWN);
-	     rd = &ib->brx_ring[lp->rx_new]) {
-
-		/* We got an incomplete frame? */
-		if ((bits & LE_R1_POK) != LE_R1_POK) {
-			dev->stats.rx_over_errors++;
-			dev->stats.rx_errors++;
-			continue;
-		} else if (bits & LE_R1_ERR) {
-			/* Count only the end frame as a rx error,
-			 * not the beginning
-			 */
-			if (bits & LE_R1_BUF)
-				dev->stats.rx_fifo_errors++;
-			if (bits & LE_R1_CRC)
-				dev->stats.rx_crc_errors++;
-			if (bits & LE_R1_OFL)
-				dev->stats.rx_over_errors++;
-			if (bits & LE_R1_FRA)
-				dev->stats.rx_frame_errors++;
-			if (bits & LE_R1_EOP)
-				dev->stats.rx_errors++;
-		} else {
-			int len = (rd->mblength & 0xfff) - 4;
-			struct sk_buff *skb = netdev_alloc_skb(dev, len + 2);
-
-			if (!skb) {
-				dev->stats.rx_dropped++;
-				rd->mblength = 0;
-				rd->rmd1_bits = LE_R1_OWN;
-				lp->rx_new = (lp->rx_new + 1) & lp->rx_ring_mod_mask;
-				return 0;
-			}
-
-			skb_reserve(skb, 2);           /* 16 byte align */
-			skb_put(skb, len);             /* make room */
-			skb_copy_to_linear_data(skb,
-					 (unsigned char *)&(ib->rx_buf[lp->rx_new][0]),
-					 len);
-			skb->protocol = eth_type_trans(skb, dev);
-			netif_rx(skb);
-			dev->stats.rx_packets++;
-			dev->stats.rx_bytes += len;
-		}
-
-		/* Return the packet to the pool */
-		rd->mblength = 0;
-		rd->rmd1_bits = LE_R1_OWN;
-		lp->rx_new = (lp->rx_new + 1) & lp->rx_ring_mod_mask;
-	}
-	return 0;
-}
-
-static int lance_tx(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	volatile struct lance_init_block *ib = lp->init_block;
-	volatile struct lance_tx_desc *td;
-	int i, j;
-	int status;
-
-#ifdef CONFIG_HP300
-	blinken_leds(0x80, 0);
-#endif
-	/* csr0 is 2f3 */
-	WRITERDP(lp, LE_C0_TINT | LE_C0_INEA);
-	/* csr0 is 73 */
-
-	j = lp->tx_old;
-	for (i = j; i != lp->tx_new; i = j) {
-		td = &ib->btx_ring[i];
-
-		/* If we hit a packet not owned by us, stop */
-		if (td->tmd1_bits & LE_T1_OWN)
-			break;
-
-		if (td->tmd1_bits & LE_T1_ERR) {
-			status = td->misc;
-
-			dev->stats.tx_errors++;
-			if (status & LE_T3_RTY)
-				dev->stats.tx_aborted_errors++;
-			if (status & LE_T3_LCOL)
-				dev->stats.tx_window_errors++;
-
-			if (status & LE_T3_CLOS) {
-				dev->stats.tx_carrier_errors++;
-				if (lp->auto_select) {
-					lp->tpe = 1 - lp->tpe;
-					printk("%s: Carrier Lost, trying %s\n",
-					       dev->name,
-					       lp->tpe ? "TPE" : "AUI");
-					/* Stop the lance */
-					WRITERAP(lp, LE_CSR0);
-					WRITERDP(lp, LE_C0_STOP);
-					lance_init_ring(dev);
-					load_csrs(lp);
-					init_restart_lance(lp);
-					return 0;
-				}
-			}
-
-			/* buffer errors and underflows turn off the transmitter */
-			/* Restart the adapter */
-			if (status & (LE_T3_BUF|LE_T3_UFL)) {
-				dev->stats.tx_fifo_errors++;
-
-				printk("%s: Tx: ERR_BUF|ERR_UFL, restarting\n",
-				       dev->name);
-				/* Stop the lance */
-				WRITERAP(lp, LE_CSR0);
-				WRITERDP(lp, LE_C0_STOP);
-				lance_init_ring(dev);
-				load_csrs(lp);
-				init_restart_lance(lp);
-				return 0;
-			}
-		} else if ((td->tmd1_bits & LE_T1_POK) == LE_T1_POK) {
-			/*
-			 * So we don't count the packet more than once.
-			 */
-			td->tmd1_bits &= ~(LE_T1_POK);
-
-			/* One collision before packet was sent. */
-			if (td->tmd1_bits & LE_T1_EONE)
-				dev->stats.collisions++;
-
-			/* More than one collision, be optimistic. */
-			if (td->tmd1_bits & LE_T1_EMORE)
-				dev->stats.collisions += 2;
-
-			dev->stats.tx_packets++;
-		}
-
-		j = (j + 1) & lp->tx_ring_mod_mask;
-	}
-	lp->tx_old = j;
-	WRITERDP(lp, LE_C0_TINT | LE_C0_INEA);
-	return 0;
-}
-
-static irqreturn_t
-lance_interrupt(int irq, void *dev_id)
-{
-	struct net_device *dev = (struct net_device *)dev_id;
-	struct lance_private *lp = netdev_priv(dev);
-	int csr0;
-
-	spin_lock(&lp->devlock);
-
-	WRITERAP(lp, LE_CSR0);              /* LANCE Controller Status */
-	csr0 = READRDP(lp);
-
-	PRINT_RINGS();
-
-	if (!(csr0 & LE_C0_INTR)) {     /* Check if any interrupt has */
-		spin_unlock(&lp->devlock);
-		return IRQ_NONE;        /* been generated by the Lance. */
-	}
-
-	/* Acknowledge all the interrupt sources ASAP */
-	WRITERDP(lp, csr0 & ~(LE_C0_INEA|LE_C0_TDMD|LE_C0_STOP|LE_C0_STRT|LE_C0_INIT));
-
-	if ((csr0 & LE_C0_ERR)) {
-		/* Clear the error condition */
-		WRITERDP(lp, LE_C0_BABL|LE_C0_ERR|LE_C0_MISS|LE_C0_INEA);
-	}
-
-	if (csr0 & LE_C0_RINT)
-		lance_rx(dev);
-
-	if (csr0 & LE_C0_TINT)
-		lance_tx(dev);
-
-	/* Log misc errors. */
-	if (csr0 & LE_C0_BABL)
-		dev->stats.tx_errors++;       /* Tx babble. */
-	if (csr0 & LE_C0_MISS)
-		dev->stats.rx_errors++;       /* Missed a Rx frame. */
-	if (csr0 & LE_C0_MERR) {
-		printk("%s: Bus master arbitration failure, status %4.4x.\n",
-		       dev->name, csr0);
-		/* Restart the chip. */
-		WRITERDP(lp, LE_C0_STRT);
-	}
-
-	if (lp->tx_full && netif_queue_stopped(dev) && (TX_BUFFS_AVAIL >= 0)) {
-		lp->tx_full = 0;
-		netif_wake_queue(dev);
-	}
-
-	WRITERAP(lp, LE_CSR0);
-	WRITERDP(lp, LE_C0_BABL|LE_C0_CERR|LE_C0_MISS|LE_C0_MERR|LE_C0_IDON|LE_C0_INEA);
-
-	spin_unlock(&lp->devlock);
-	return IRQ_HANDLED;
-}
-
-int lance_open(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	int res;
-
-	/* Install the Interrupt handler. Or we could shunt this out to specific drivers? */
-	if (request_irq(lp->irq, lance_interrupt, IRQF_SHARED, lp->name, dev))
-		return -EAGAIN;
-
-	res = lance_reset(dev);
-	spin_lock_init(&lp->devlock);
-	netif_start_queue(dev);
-
-	return res;
-}
-EXPORT_SYMBOL_GPL(lance_open);
-
-int lance_close(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-
-	netif_stop_queue(dev);
-
-	/* Stop the LANCE */
-	WRITERAP(lp, LE_CSR0);
-	WRITERDP(lp, LE_C0_STOP);
-
-	free_irq(lp->irq, dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(lance_close);
-
-void lance_tx_timeout(struct net_device *dev, unsigned int txqueue)
-{
-	printk("lance_tx_timeout\n");
-	lance_reset(dev);
-	netif_trans_update(dev); /* prevent tx timeout */
-	netif_wake_queue(dev);
-}
-EXPORT_SYMBOL_GPL(lance_tx_timeout);
-
-netdev_tx_t lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	volatile struct lance_init_block *ib = lp->init_block;
-	int entry, skblen, len;
-	static int outs;
-	unsigned long flags;
-
-	netif_stop_queue(dev);
-
-	if (!TX_BUFFS_AVAIL) {
-		dev_consume_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
-
-	skblen = skb->len;
-
-#ifdef DEBUG_DRIVER
-	/* dump the packet */
-	{
-		int i;
-
-		for (i = 0; i < 64; i++) {
-			if ((i % 16) == 0)
-				printk("\n");
-			printk("%2.2x ", skb->data[i]);
-		}
-	}
-#endif
-	len = (skblen <= ETH_ZLEN) ? ETH_ZLEN : skblen;
-	entry = lp->tx_new & lp->tx_ring_mod_mask;
-	ib->btx_ring[entry].length = (-len) | 0xf000;
-	ib->btx_ring[entry].misc = 0;
-
-	if (skb->len < ETH_ZLEN)
-		memset((void *)&ib->tx_buf[entry][0], 0, ETH_ZLEN);
-	skb_copy_from_linear_data(skb, (void *)&ib->tx_buf[entry][0], skblen);
-
-	/* Now, give the packet to the lance */
-	ib->btx_ring[entry].tmd1_bits = (LE_T1_POK|LE_T1_OWN);
-	lp->tx_new = (lp->tx_new + 1) & lp->tx_ring_mod_mask;
-
-	outs++;
-	/* Kick the lance: transmit now */
-	WRITERDP(lp, LE_C0_INEA | LE_C0_TDMD);
-	dev_consume_skb_any(skb);
-
-	spin_lock_irqsave(&lp->devlock, flags);
-	if (TX_BUFFS_AVAIL)
-		netif_start_queue(dev);
-	else
-		lp->tx_full = 1;
-	spin_unlock_irqrestore(&lp->devlock, flags);
-
-	return NETDEV_TX_OK;
-}
-EXPORT_SYMBOL_GPL(lance_start_xmit);
-
-/* taken from the depca driver via a2065.c */
-static void lance_load_multicast(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	volatile struct lance_init_block *ib = lp->init_block;
-	volatile u16 *mcast_table = (u16 *)&ib->filter;
-	struct netdev_hw_addr *ha;
-	u32 crc;
-
-	/* set all multicast bits */
-	if (dev->flags & IFF_ALLMULTI) {
-		ib->filter[0] = 0xffffffff;
-		ib->filter[1] = 0xffffffff;
-		return;
-	}
-	/* clear the multicast filter */
-	ib->filter[0] = 0;
-	ib->filter[1] = 0;
-
-	/* Add addresses */
-	netdev_for_each_mc_addr(ha, dev) {
-		crc = ether_crc_le(6, ha->addr);
-		crc = crc >> 26;
-		mcast_table[crc >> 4] |= 1 << (crc & 0xf);
-	}
-}
-
-
-void lance_set_multicast(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-	volatile struct lance_init_block *ib = lp->init_block;
-	int stopped;
-
-	stopped = netif_queue_stopped(dev);
-	if (!stopped)
-		netif_stop_queue(dev);
-
-	while (lp->tx_old != lp->tx_new)
-		schedule();
-
-	WRITERAP(lp, LE_CSR0);
-	WRITERDP(lp, LE_C0_STOP);
-	lance_init_ring(dev);
-
-	if (dev->flags & IFF_PROMISC) {
-		ib->mode |= LE_MO_PROM;
-	} else {
-		ib->mode &= ~LE_MO_PROM;
-		lance_load_multicast(dev);
-	}
-	load_csrs(lp);
-	init_restart_lance(lp);
-
-	if (!stopped)
-		netif_start_queue(dev);
-}
-EXPORT_SYMBOL_GPL(lance_set_multicast);
-
-#ifdef CONFIG_NET_POLL_CONTROLLER
-void lance_poll(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-
-	spin_lock(&lp->devlock);
-	WRITERAP(lp, LE_CSR0);
-	WRITERDP(lp, LE_C0_STRT);
-	spin_unlock(&lp->devlock);
-	lance_interrupt(dev->irq, dev);
-}
-EXPORT_SYMBOL_GPL(lance_poll);
-#endif
-
-MODULE_DESCRIPTION("LANCE Ethernet IC generic routines");
-MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/7990.h b/drivers/net/ethernet/amd/7990.h
deleted file mode 100644
index e53551daeea1..000000000000
--- a/drivers/net/ethernet/amd/7990.h
+++ /dev/null
@@ -1,251 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * 7990.h -- LANCE ethernet IC generic routines.
- * This is an attempt to separate out the bits of various ethernet
- * drivers that are common because they all use the AMD 7990 LANCE
- * (Local Area Network Controller for Ethernet) chip.
- *
- * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
- *
- * Most of this stuff was obtained by looking at other LANCE drivers,
- * in particular a2065.[ch]. The AMD C-LANCE datasheet was also helpful.
- */
-
-#ifndef _7990_H
-#define _7990_H
-
-/* The lance only has two register locations. We communicate mostly via memory. */
-#define LANCE_RDP	0	/* Register Data Port */
-#define LANCE_RAP	2	/* Register Address Port */
-
-/* Transmit/receive ring definitions.
- * We allow the specific drivers to override these defaults if they want to.
- * NB: according to lance.c, increasing the number of buffers is a waste
- * of space and reduces the chance that an upper layer will be able to
- * reorder queued Tx packets based on priority. [Clearly there is a minimum
- * limit too: too small and we drop rx packets and can't tx at full speed.]
- * 4+4 seems to be the usual setting; the atarilance driver uses 3 and 5.
- */
-
-/* Blast! This won't work. The problem is that we can't specify a default
- * setting because that would cause the lance_init_block struct to be
- * too long (and overflow the RAM on shared-memory cards like the HP LANCE.
- */
-#ifndef LANCE_LOG_TX_BUFFERS
-#define LANCE_LOG_TX_BUFFERS 1
-#define LANCE_LOG_RX_BUFFERS 3
-#endif
-
-#define TX_RING_SIZE		(1 << LANCE_LOG_TX_BUFFERS)
-#define RX_RING_SIZE		(1 << LANCE_LOG_RX_BUFFERS)
-#define TX_RING_MOD_MASK	(TX_RING_SIZE - 1)
-#define RX_RING_MOD_MASK	(RX_RING_SIZE - 1)
-#define TX_RING_LEN_BITS	((LANCE_LOG_TX_BUFFERS) << 29)
-#define RX_RING_LEN_BITS	((LANCE_LOG_RX_BUFFERS) << 29)
-#define PKT_BUFF_SIZE		(1544)
-#define RX_BUFF_SIZE		PKT_BUFF_SIZE
-#define TX_BUFF_SIZE		PKT_BUFF_SIZE
-
-/* Each receive buffer is described by a receive message descriptor (RMD) */
-struct lance_rx_desc {
-	volatile unsigned short rmd0;	    /* low address of packet */
-	volatile unsigned char  rmd1_bits;  /* descriptor bits */
-	volatile unsigned char  rmd1_hadr;  /* high address of packet */
-	volatile short    length;	    /* This length is 2s complement (negative)!
-					     * Buffer length */
-	volatile unsigned short mblength;   /* Actual number of bytes received */
-};
-
-/* Ditto for TMD: */
-struct lance_tx_desc {
-	volatile unsigned short tmd0;	    /* low address of packet */
-	volatile unsigned char  tmd1_bits;  /* descriptor bits */
-	volatile unsigned char  tmd1_hadr;  /* high address of packet */
-	volatile short    length;	    /* Length is 2s complement (negative)! */
-	volatile unsigned short misc;
-};
-
-/* There are three memory structures accessed by the LANCE:
- * the initialization block, the receive and transmit descriptor rings,
- * and the data buffers themselves. In fact we might as well put the
- * init block,the Tx and Rx rings and the buffers together in memory:
- */
-struct lance_init_block {
-	volatile unsigned short mode;		/* Pre-set mode (reg. 15) */
-	volatile unsigned char phys_addr[6];	/* Physical ethernet address */
-	volatile unsigned filter[2];		/* Multicast filter (64 bits) */
-
-	/* Receive and transmit ring base, along with extra bits. */
-	volatile unsigned short rx_ptr;		/* receive descriptor addr */
-	volatile unsigned short rx_len;		/* receive len and high addr */
-	volatile unsigned short tx_ptr;		/* transmit descriptor addr */
-	volatile unsigned short tx_len;		/* transmit len and high addr */
-
-	/* The Tx and Rx ring entries must be aligned on 8-byte boundaries.
-	 * This will be true if this whole struct is 8-byte aligned.
-	 */
-	volatile struct lance_tx_desc btx_ring[TX_RING_SIZE];
-	volatile struct lance_rx_desc brx_ring[RX_RING_SIZE];
-
-	volatile char tx_buf[TX_RING_SIZE][TX_BUFF_SIZE];
-	volatile char rx_buf[RX_RING_SIZE][RX_BUFF_SIZE];
-	/* we use this just to make the struct big enough that we can move its startaddr
-	 * in order to force alignment to an eight byte boundary.
-	 */
-};
-
-/* This is where we keep all the stuff the driver needs to know about.
- * I'm definitely unhappy about the mechanism for allowing specific
- * drivers to add things...
- */
-struct lance_private {
-	const char *name;
-	unsigned long base;
-	volatile struct lance_init_block *init_block; /* CPU address of RAM */
-	volatile struct lance_init_block *lance_init_block; /* LANCE address of RAM */
-
-	int rx_new, tx_new;
-	int rx_old, tx_old;
-
-	int lance_log_rx_bufs, lance_log_tx_bufs;
-	int rx_ring_mod_mask, tx_ring_mod_mask;
-
-	int tpe;			/* TPE is selected */
-	int auto_select;		/* cable-selection is by carrier */
-	unsigned short busmaster_regval;
-
-	unsigned int irq;		/* IRQ to register */
-
-	/* This is because the HP LANCE is disgusting and you have to check
-	 * a DIO-specific register every time you read/write the LANCE regs :-<
-	 * [could we get away with making these some sort of macro?]
-	 */
-	void (*writerap)(void *, unsigned short);
-	void (*writerdp)(void *, unsigned short);
-	unsigned short (*readrdp)(void *);
-	spinlock_t devlock;
-	char tx_full;
-};
-
-/*
- *		Am7990 Control and Status Registers
- */
-#define LE_CSR0		0x0000	/* LANCE Controller Status */
-#define LE_CSR1		0x0001	/* IADR[15:0] (bit0==0 ie word aligned) */
-#define LE_CSR2		0x0002	/* IADR[23:16] (high bits reserved) */
-#define LE_CSR3		0x0003	/* Misc */
-
-/*
- *		Bit definitions for CSR0 (LANCE Controller Status)
- */
-#define LE_C0_ERR	0x8000	/* Error = BABL | CERR | MISS | MERR */
-#define LE_C0_BABL	0x4000	/* Babble: Transmitted too many bits */
-#define LE_C0_CERR	0x2000	/* No Heartbeat (10BASE-T) */
-#define LE_C0_MISS	0x1000	/* Missed Frame (no rx buffer to put it in) */
-#define LE_C0_MERR	0x0800	/* Memory Error */
-#define LE_C0_RINT	0x0400	/* Receive Interrupt */
-#define LE_C0_TINT	0x0200	/* Transmit Interrupt */
-#define LE_C0_IDON	0x0100	/* Initialization Done */
-#define LE_C0_INTR	0x0080	/* Interrupt Flag
-				   = BABL | MISS | MERR | RINT | TINT | IDON */
-#define LE_C0_INEA	0x0040	/* Interrupt Enable */
-#define LE_C0_RXON	0x0020	/* Receive On */
-#define LE_C0_TXON	0x0010	/* Transmit On */
-#define LE_C0_TDMD	0x0008	/* Transmit Demand */
-#define LE_C0_STOP	0x0004	/* Stop */
-#define LE_C0_STRT	0x0002	/* Start */
-#define LE_C0_INIT	0x0001	/* Initialize */
-
-
-/*
- *		Bit definitions for CSR3
- */
-#define LE_C3_BSWP	0x0004	/* Byte Swap (on for big endian byte order) */
-#define LE_C3_ACON	0x0002	/* ALE Control (on for active low ALE) */
-#define LE_C3_BCON	0x0001	/* Byte Control */
-
-
-/*
- *		Mode Flags
- */
-#define LE_MO_PROM	0x8000	/* Promiscuous Mode */
-/* these next ones 0x4000 -- 0x0080 are not available on the LANCE 7990,
- * but they are in NetBSD's am7990.h, presumably for backwards-compatible chips
- */
-#define LE_MO_DRCVBC	0x4000	/* disable receive broadcast */
-#define LE_MO_DRCVPA	0x2000	/* disable physical address detection */
-#define LE_MO_DLNKTST	0x1000	/* disable link status */
-#define LE_MO_DAPC	0x0800	/* disable automatic polarity correction */
-#define LE_MO_MENDECL	0x0400	/* MENDEC loopback mode */
-#define LE_MO_LRTTSEL	0x0200	/* lower RX threshold / TX mode selection */
-#define LE_MO_PSEL1	0x0100	/* port selection bit1 */
-#define LE_MO_PSEL0	0x0080	/* port selection bit0 */
-/* and this one is from the C-LANCE data sheet... */
-#define LE_MO_EMBA	0x0080	/* Enable Modified Backoff Algorithm
-				   (C-LANCE, not original LANCE) */
-#define LE_MO_INTL	0x0040	/* Internal Loopback */
-#define LE_MO_DRTY	0x0020	/* Disable Retry */
-#define LE_MO_FCOLL	0x0010	/* Force Collision */
-#define LE_MO_DXMTFCS	0x0008	/* Disable Transmit CRC */
-#define LE_MO_LOOP	0x0004	/* Loopback Enable */
-#define LE_MO_DTX	0x0002	/* Disable Transmitter */
-#define LE_MO_DRX	0x0001	/* Disable Receiver */
-
-
-/*
- *		Receive Flags
- */
-#define LE_R1_OWN	0x80	/* LANCE owns the descriptor */
-#define LE_R1_ERR	0x40	/* Error */
-#define LE_R1_FRA	0x20	/* Framing Error */
-#define LE_R1_OFL	0x10	/* Overflow Error */
-#define LE_R1_CRC	0x08	/* CRC Error */
-#define LE_R1_BUF	0x04	/* Buffer Error */
-#define LE_R1_SOP	0x02	/* Start of Packet */
-#define LE_R1_EOP	0x01	/* End of Packet */
-#define LE_R1_POK	0x03	/* Packet is complete: SOP + EOP */
-
-
-/*
- *		Transmit Flags
- */
-#define LE_T1_OWN	0x80	/* LANCE owns the descriptor */
-#define LE_T1_ERR	0x40	/* Error */
-#define LE_T1_RES	0x20	/* Reserved, LANCE writes this with a zero */
-#define LE_T1_EMORE	0x10	/* More than one retry needed */
-#define LE_T1_EONE	0x08	/* One retry needed */
-#define LE_T1_EDEF	0x04	/* Deferred */
-#define LE_T1_SOP	0x02	/* Start of Packet */
-#define LE_T1_EOP	0x01	/* End of Packet */
-#define LE_T1_POK	0x03	/* Packet is complete: SOP + EOP */
-
-/*
- *		Error Flags
- */
-#define LE_T3_BUF	0x8000	/* Buffer Error */
-#define LE_T3_UFL	0x4000	/* Underflow Error */
-#define LE_T3_LCOL	0x1000	/* Late Collision */
-#define LE_T3_CLOS	0x0800	/* Loss of Carrier */
-#define LE_T3_RTY	0x0400	/* Retry Error */
-#define LE_T3_TDR	0x03ff	/* Time Domain Reflectometry */
-
-/* Miscellaneous useful macros */
-
-#define TX_BUFFS_AVAIL ((lp->tx_old <= lp->tx_new) ? \
-			lp->tx_old + lp->tx_ring_mod_mask - lp->tx_new : \
-			lp->tx_old - lp->tx_new - 1)
-
-/* The LANCE only uses 24 bit addresses. This does the obvious thing. */
-#define LANCE_ADDR(x) ((int)(x) & ~0xff000000)
-
-/* Now the prototypes we export */
-int lance_open(struct net_device *dev);
-int lance_close(struct net_device *dev);
-netdev_tx_t lance_start_xmit(struct sk_buff *skb, struct net_device *dev);
-void lance_set_multicast(struct net_device *dev);
-void lance_tx_timeout(struct net_device *dev, unsigned int txqueue);
-#ifdef CONFIG_NET_POLL_CONTROLLER
-void lance_poll(struct net_device *dev);
-#endif
-
-#endif /* ndef _7990_H */
diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index 45e8d698781c..9e83f3aa435a 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -93,14 +93,6 @@ config DECLANCE
 	  DEC (now Compaq) based on the AMD LANCE chipset, including the
 	  DEPCA series.  (This chipset is better known via the NE2100 cards.)
 
-config HPLANCE
-	tristate "HP on-board LANCE support"
-	depends on DIO
-	select CRC32
-	help
-	  If you want to use the builtin "LANCE" Ethernet controller on an
-	  HP300 machine, say Y here.
-
 config MIPS_AU1X00_ENET
 	tristate "MIPS AU1000 Ethernet support"
 	depends on MIPS_ALCHEMY
@@ -110,16 +102,6 @@ config MIPS_AU1X00_ENET
 	  If you have an Alchemy Semi AU1X00 based system
 	  say Y.  Otherwise, say N.
 
-config MVME147_NET
-	tristate "MVME147 (LANCE) Ethernet support"
-	depends on MVME147
-	select CRC32
-	help
-	  Support for the on-board Ethernet interface on the Motorola MVME147
-	  single-board computer.  Say Y here to include the
-	  driver for this chip in your kernel.
-	  To compile this driver as a module, choose M here.
-
 config PCMCIA_NMCLAN
 	tristate "New Media PCMCIA support"
 	depends on PCMCIA && HAS_IOPORT
diff --git a/drivers/net/ethernet/amd/Makefile b/drivers/net/ethernet/amd/Makefile
index 2dcfb84731e1..387ec74e8e95 100644
--- a/drivers/net/ethernet/amd/Makefile
+++ b/drivers/net/ethernet/amd/Makefile
@@ -8,10 +8,8 @@ obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
 obj-$(CONFIG_ARIADNE) += ariadne.o
 obj-$(CONFIG_ATARILANCE) += atarilance.o
 obj-$(CONFIG_DECLANCE) += declance.o
-obj-$(CONFIG_HPLANCE) += hplance.o 7990.o
 obj-$(CONFIG_LANCE) += lance.o
 obj-$(CONFIG_MIPS_AU1X00_ENET) += au1000_eth.o
-obj-$(CONFIG_MVME147_NET) += mvme147.o 7990.o
 obj-$(CONFIG_PCMCIA_NMCLAN) += nmclan_cs.o
 obj-$(CONFIG_PCNET32) += pcnet32.o
 obj-$(CONFIG_SUN3LANCE) += sun3lance.o
diff --git a/drivers/net/ethernet/amd/hplance.c b/drivers/net/ethernet/amd/hplance.c
deleted file mode 100644
index df42294530cb..000000000000
--- a/drivers/net/ethernet/amd/hplance.c
+++ /dev/null
@@ -1,238 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* hplance.c  : the  Linux/hp300/lance ethernet driver
- *
- * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
- * Based on the Sun Lance driver and the NetBSD HP Lance driver
- * Uses the generic 7990.c LANCE code.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/string.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/pgtable.h>
-/* Used for the temporal inet entries and routing */
-#include <linux/socket.h>
-#include <linux/route.h>
-#include <linux/dio.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-
-#include <asm/io.h>
-
-#include "hplance.h"
-
-/* We have 16392 bytes of RAM for the init block and buffers. This places
- * an upper limit on the number of buffers we can use. NetBSD uses 8 Rx
- * buffers and 2 Tx buffers, it takes (8 + 2) * 1544 bytes.
- */
-#define LANCE_LOG_TX_BUFFERS 1
-#define LANCE_LOG_RX_BUFFERS 3
-
-#include "7990.h"                                 /* use generic LANCE code */
-
-/* Our private data structure */
-struct hplance_private {
-	struct lance_private lance;
-};
-
-/* function prototypes... This is easy because all the grot is in the
- * generic LANCE support. All we have to support is probing for boards,
- * plus board-specific init, open and close actions.
- * Oh, and we need to tell the generic code how to read and write LANCE registers...
- */
-static int hplance_init_one(struct dio_dev *d, const struct dio_device_id *ent);
-static void hplance_init(struct net_device *dev, struct dio_dev *d);
-static void hplance_remove_one(struct dio_dev *d);
-static void hplance_writerap(void *priv, unsigned short value);
-static void hplance_writerdp(void *priv, unsigned short value);
-static unsigned short hplance_readrdp(void *priv);
-static int hplance_open(struct net_device *dev);
-static int hplance_close(struct net_device *dev);
-
-static struct dio_device_id hplance_dio_tbl[] = {
-	{ DIO_ID_LAN },
-	{ 0 }
-};
-
-static struct dio_driver hplance_driver = {
-	.name      = "hplance",
-	.id_table  = hplance_dio_tbl,
-	.probe     = hplance_init_one,
-	.remove    = hplance_remove_one,
-};
-
-static const struct net_device_ops hplance_netdev_ops = {
-	.ndo_open		= hplance_open,
-	.ndo_stop		= hplance_close,
-	.ndo_start_xmit		= lance_start_xmit,
-	.ndo_set_rx_mode	= lance_set_multicast,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= lance_poll,
-#endif
-};
-
-/* Find all the HP Lance boards and initialise them... */
-static int hplance_init_one(struct dio_dev *d, const struct dio_device_id *ent)
-{
-	struct net_device *dev;
-	int err = -ENOMEM;
-
-	dev = alloc_etherdev(sizeof(struct hplance_private));
-	if (!dev)
-		goto out;
-
-	err = -EBUSY;
-	if (!request_mem_region(dio_resource_start(d),
-				dio_resource_len(d), d->name))
-		goto out_free_netdev;
-
-	hplance_init(dev, d);
-	err = register_netdev(dev);
-	if (err)
-		goto out_release_mem_region;
-
-	dio_set_drvdata(d, dev);
-
-	printk(KERN_INFO "%s: %s; select code %d, addr %pM, irq %d\n",
-	       dev->name, d->name, d->scode, dev->dev_addr, d->ipl);
-
-	return 0;
-
- out_release_mem_region:
-	release_mem_region(dio_resource_start(d), dio_resource_len(d));
- out_free_netdev:
-	free_netdev(dev);
- out:
-	return err;
-}
-
-static void hplance_remove_one(struct dio_dev *d)
-{
-	struct net_device *dev = dio_get_drvdata(d);
-
-	unregister_netdev(dev);
-	release_mem_region(dio_resource_start(d), dio_resource_len(d));
-	free_netdev(dev);
-}
-
-/* Initialise a single lance board at the given DIO device */
-static void hplance_init(struct net_device *dev, struct dio_dev *d)
-{
-	unsigned long va = (d->resource.start + DIO_VIRADDRBASE);
-	struct hplance_private *lp;
-	u8 addr[ETH_ALEN];
-	int i;
-
-	/* reset the board */
-	out_8(va + DIO_IDOFF, 0xff);
-	udelay(100);                              /* ariba! ariba! udelay! udelay! */
-
-	/* Fill the dev fields */
-	dev->base_addr = va;
-	dev->netdev_ops = &hplance_netdev_ops;
-	dev->dma = 0;
-
-	for (i = 0; i < 6; i++) {
-		/* The NVRAM holds our ethernet address, one nibble per byte,
-		 * at bytes NVRAMOFF+1,3,5,7,9...
-		 */
-		addr[i] = ((in_8(va + HPLANCE_NVRAMOFF + i*4 + 1) & 0xF) << 4)
-			| (in_8(va + HPLANCE_NVRAMOFF + i*4 + 3) & 0xF);
-	}
-	eth_hw_addr_set(dev, addr);
-
-	lp = netdev_priv(dev);
-	lp->lance.name = d->name;
-	lp->lance.base = va;
-	lp->lance.init_block = (struct lance_init_block *)(va + HPLANCE_MEMOFF); /* CPU addr */
-	lp->lance.lance_init_block = NULL;              /* LANCE addr of same RAM */
-	lp->lance.busmaster_regval = LE_C3_BSWP;        /* we're bigendian */
-	lp->lance.irq = d->ipl;
-	lp->lance.writerap = hplance_writerap;
-	lp->lance.writerdp = hplance_writerdp;
-	lp->lance.readrdp = hplance_readrdp;
-	lp->lance.lance_log_rx_bufs = LANCE_LOG_RX_BUFFERS;
-	lp->lance.lance_log_tx_bufs = LANCE_LOG_TX_BUFFERS;
-	lp->lance.rx_ring_mod_mask = RX_RING_MOD_MASK;
-	lp->lance.tx_ring_mod_mask = TX_RING_MOD_MASK;
-}
-
-/* This is disgusting. We have to check the DIO status register for ack every
- * time we read or write the LANCE registers.
- */
-static void hplance_writerap(void *priv, unsigned short value)
-{
-	struct lance_private *lp = (struct lance_private *)priv;
-
-	do {
-		out_be16(lp->base + HPLANCE_REGOFF + LANCE_RAP, value);
-	} while ((in_8(lp->base + HPLANCE_STATUS) & LE_ACK) == 0);
-}
-
-static void hplance_writerdp(void *priv, unsigned short value)
-{
-	struct lance_private *lp = (struct lance_private *)priv;
-
-	do {
-		out_be16(lp->base + HPLANCE_REGOFF + LANCE_RDP, value);
-	} while ((in_8(lp->base + HPLANCE_STATUS) & LE_ACK) == 0);
-}
-
-static unsigned short hplance_readrdp(void *priv)
-{
-	struct lance_private *lp = (struct lance_private *)priv;
-	__u16 value;
-
-	do {
-		value = in_be16(lp->base + HPLANCE_REGOFF + LANCE_RDP);
-	} while ((in_8(lp->base + HPLANCE_STATUS) & LE_ACK) == 0);
-	return value;
-}
-
-static int hplance_open(struct net_device *dev)
-{
-	int status;
-	struct lance_private *lp = netdev_priv(dev);
-
-	status = lance_open(dev);                 /* call generic lance open code */
-	if (status)
-		return status;
-	/* enable interrupts at board level. */
-	out_8(lp->base + HPLANCE_STATUS, LE_IE);
-
-	return 0;
-}
-
-static int hplance_close(struct net_device *dev)
-{
-	struct lance_private *lp = netdev_priv(dev);
-
-	out_8(lp->base + HPLANCE_STATUS, 0);	/* disable interrupts at boardlevel */
-	lance_close(dev);
-	return 0;
-}
-
-static int __init hplance_init_module(void)
-{
-	return dio_register_driver(&hplance_driver);
-}
-
-static void __exit hplance_cleanup_module(void)
-{
-	dio_unregister_driver(&hplance_driver);
-}
-
-module_init(hplance_init_module);
-module_exit(hplance_cleanup_module);
-
-MODULE_DESCRIPTION("HP300 on-board LANCE Ethernet driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/amd/hplance.h b/drivers/net/ethernet/amd/hplance.h
deleted file mode 100644
index bc845a2c60c1..000000000000
--- a/drivers/net/ethernet/amd/hplance.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Random defines and structures for the HP Lance driver.
- * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
- * Based on the Sun Lance driver and the NetBSD HP Lance driver
- */
-
-/* Registers */
-#define HPLANCE_ID		0x01		/* DIO register: ID byte */
-#define HPLANCE_STATUS		0x03		/* DIO register: interrupt enable/status */
-
-/* Control and status bits for the status register */
-#define LE_IE 0x80                                /* interrupt enable */
-#define LE_IR 0x40                                /* interrupt requested */
-#define LE_LOCK 0x08                              /* lock status register */
-#define LE_ACK 0x04                               /* ack of lock */
-#define LE_JAB 0x02                               /* loss of tx clock (???) */
-/* We can also extract the IPL from the status register with the standard
- * DIO_IPL(hplance) macro, or using dio_scodetoipl()
- */
-
-/* These are the offsets for the DIO regs (hplance_reg), lance_ioreg,
- * memory and NVRAM:
- */
-#define HPLANCE_IDOFF 0                           /* board baseaddr */
-#define HPLANCE_REGOFF 0x4000                     /* lance registers */
-#define HPLANCE_MEMOFF 0x8000                     /* struct lance_init_block */
-#define HPLANCE_NVRAMOFF 0xC008                   /* etheraddress as one *nibble* per byte */
diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
deleted file mode 100644
index f19b04b92fa9..000000000000
--- a/drivers/net/ethernet/amd/mvme147.c
+++ /dev/null
@@ -1,198 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* mvme147.c  : the  Linux/mvme147/lance ethernet driver
- *
- * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
- * Based on the Sun Lance driver and the NetBSD HP Lance driver
- * Uses the generic 7990.c LANCE code.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/string.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/gfp.h>
-#include <linux/pgtable.h>
-/* Used for the temporal inet entries and routing */
-#include <linux/socket.h>
-#include <linux/route.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-
-#include <asm/io.h>
-#include <asm/mvme147hw.h>
-
-/* We have 32K of RAM for the init block and buffers. This places
- * an upper limit on the number of buffers we can use. NetBSD uses 8 Rx
- * buffers and 2 Tx buffers, it takes (8 + 2) * 1544 bytes.
- */
-#define LANCE_LOG_TX_BUFFERS 1
-#define LANCE_LOG_RX_BUFFERS 3
-
-#include "7990.h"                                 /* use generic LANCE code */
-
-/* Our private data structure */
-struct m147lance_private {
-	struct lance_private lance;
-	unsigned long ram;
-};
-
-/* function prototypes... This is easy because all the grot is in the
- * generic LANCE support. All we have to support is probing for boards,
- * plus board-specific init, open and close actions.
- * Oh, and we need to tell the generic code how to read and write LANCE registers...
- */
-static int m147lance_open(struct net_device *dev);
-static int m147lance_close(struct net_device *dev);
-static void m147lance_writerap(struct lance_private *lp, unsigned short value);
-static void m147lance_writerdp(struct lance_private *lp, unsigned short value);
-static unsigned short m147lance_readrdp(struct lance_private *lp);
-
-typedef void (*writerap_t)(void *, unsigned short);
-typedef void (*writerdp_t)(void *, unsigned short);
-typedef unsigned short (*readrdp_t)(void *);
-
-static const struct net_device_ops lance_netdev_ops = {
-	.ndo_open		= m147lance_open,
-	.ndo_stop		= m147lance_close,
-	.ndo_start_xmit		= lance_start_xmit,
-	.ndo_set_rx_mode	= lance_set_multicast,
-	.ndo_tx_timeout		= lance_tx_timeout,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
-};
-
-/* Initialise the one and only on-board 7990 */
-static struct net_device * __init mvme147lance_probe(void)
-{
-	struct net_device *dev;
-	static int called;
-	static const char name[] = "MVME147 LANCE";
-	struct m147lance_private *lp;
-	u8 macaddr[ETH_ALEN];
-	u_long *addr;
-	u_long address;
-	int err;
-
-	if (!MACH_IS_MVME147 || called)
-		return ERR_PTR(-ENODEV);
-	called++;
-
-	dev = alloc_etherdev(sizeof(struct m147lance_private));
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	/* Fill the dev fields */
-	dev->base_addr = (unsigned long)MVME147_LANCE_BASE;
-	dev->netdev_ops = &lance_netdev_ops;
-	dev->dma = 0;
-
-	addr = (u_long *)ETHERNET_ADDRESS;
-	address = *addr;
-	macaddr[0] = 0x08;
-	macaddr[1] = 0x00;
-	macaddr[2] = 0x3e;
-	address = address >> 8;
-	macaddr[5] = address&0xff;
-	address = address >> 8;
-	macaddr[4] = address&0xff;
-	address = address >> 8;
-	macaddr[3] = address&0xff;
-	eth_hw_addr_set(dev, macaddr);
-
-	lp = netdev_priv(dev);
-	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
-	if (!lp->ram) {
-		printk("%s: No memory for LANCE buffers\n", dev->name);
-		free_netdev(dev);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	lp->lance.name = name;
-	lp->lance.base = dev->base_addr;
-	lp->lance.init_block = (struct lance_init_block *)(lp->ram); /* CPU addr */
-	lp->lance.lance_init_block = (struct lance_init_block *)(lp->ram);                 /* LANCE addr of same RAM */
-	lp->lance.busmaster_regval = LE_C3_BSWP;        /* we're bigendian */
-	lp->lance.irq = MVME147_LANCE_IRQ;
-	lp->lance.writerap = (writerap_t)m147lance_writerap;
-	lp->lance.writerdp = (writerdp_t)m147lance_writerdp;
-	lp->lance.readrdp = (readrdp_t)m147lance_readrdp;
-	lp->lance.lance_log_rx_bufs = LANCE_LOG_RX_BUFFERS;
-	lp->lance.lance_log_tx_bufs = LANCE_LOG_TX_BUFFERS;
-	lp->lance.rx_ring_mod_mask = RX_RING_MOD_MASK;
-	lp->lance.tx_ring_mod_mask = TX_RING_MOD_MASK;
-
-	err = register_netdev(dev);
-	if (err) {
-		free_pages(lp->ram, 3);
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
-
-	return dev;
-}
-
-static void m147lance_writerap(struct lance_private *lp, unsigned short value)
-{
-	out_be16(lp->base + LANCE_RAP, value);
-}
-
-static void m147lance_writerdp(struct lance_private *lp, unsigned short value)
-{
-	out_be16(lp->base + LANCE_RDP, value);
-}
-
-static unsigned short m147lance_readrdp(struct lance_private *lp)
-{
-	return in_be16(lp->base + LANCE_RDP);
-}
-
-static int m147lance_open(struct net_device *dev)
-{
-	int status;
-
-	status = lance_open(dev);                 /* call generic lance open code */
-	if (status)
-		return status;
-	/* enable interrupts at board level. */
-	m147_pcc->lan_cntrl = 0;       /* clear the interrupts (if any) */
-	m147_pcc->lan_cntrl = 0x08 | 0x04;     /* Enable irq 4 */
-
-	return 0;
-}
-
-static int m147lance_close(struct net_device *dev)
-{
-	/* disable interrupts at boardlevel */
-	m147_pcc->lan_cntrl = 0x0; /* disable interrupts */
-	lance_close(dev);
-	return 0;
-}
-
-MODULE_DESCRIPTION("MVME147 LANCE Ethernet driver");
-MODULE_LICENSE("GPL");
-
-static struct net_device *dev_mvme147_lance;
-static int __init m147lance_init(void)
-{
-	dev_mvme147_lance = mvme147lance_probe();
-	return PTR_ERR_OR_ZERO(dev_mvme147_lance);
-}
-module_init(m147lance_init);
-
-static void __exit m147lance_exit(void)
-{
-	struct m147lance_private *lp = netdev_priv(dev_mvme147_lance);
-	unregister_netdev(dev_mvme147_lance);
-	free_pages(lp->ram, 3);
-	free_netdev(dev_mvme147_lance);
-}
-module_exit(m147lance_exit);

-- 
2.53.0


