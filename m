Return-Path: <netdev+bounces-289896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDlDAlGaDWoMzwUAu9opvQ
	(envelope-from <netdev+bounces-289896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:26:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067358C63B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A282E30C5426
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE43A9633;
	Wed, 20 May 2026 11:19:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7403A382F;
	Wed, 20 May 2026 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275953; cv=none; b=l7WeNA0+6woUIabC1Kc2qtp3wsa2yF4diN5XNL0YhCAv2ErzE5Q7tdoAX2XRKl8rqC/CxEU/gJ+sIEq0sfws7CGbnWCcX4JKOUnYsuQ+UIGzimwLyA8osk1KBMdCQJFva7Ut2C0DmGAY9/L3lIYbxLtFdLOffg5oLPOkw5gxvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275953; c=relaxed/simple;
	bh=G4lHXtEREaijy1lXcdbLuSi9MSP6DEzPos3gZddYI7c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S05PUgXugdAXuesqGjt+QNt63WTGhbxTzPo+OJFIYpmj4fDEFqm91GfEjETsDoB9x8vMNuKCN9BhAPy+jXEasLBIW1WzW6HiPlHTKq9yJWIunqNKNGrVjXDAEPxJKlE9VyZ8JFKrvNJqG9xAoETz/tfUfK4AmDyy9kPlWP1PUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BE04A92009C; Wed, 20 May 2026 13:19:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id BA25592009B;
	Wed, 20 May 2026 12:19:06 +0100 (BST)
Date: Wed, 20 May 2026 12:19:06 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 5/5] ethernet: 3c509: Fix most coding style issues
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605201208280.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289896-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wild-wind.fr.eu.org:email,scyld.com:url,scyld.com:email,farfalle.com:email,pobox.com:email,angie.orcam.me.uk:mid,orcam.me.uk:email,rainbow-software.org:email,commfireservices.com:email]
X-Rspamd-Queue-Id: 3067358C63B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the driver for our current coding style according to output from
`checkpatch.pl' and manual code review, where no change to binary code
results, as indicated by `objdump -dr'.  Exceptions are as follows:

- incomplete reverse xmas tree in set_multicast_list(), as that would
  change binary output,

- referring el3_start_xmit() verbatim rather than via `__func__' with
  pr_debug(), likewise,

- a bunch of pr_cont() calls, likewise,

- a long udelay() call in el3_netdev_set_ecmd() made under a spinlock,
  likewise plus it's not eligible for conversion to a sleep in the first
  place,

- a blank line at the start of a block in el3_interrupt(), to improve
  readability where the first statement would otherwise visually merge
  with the controlling expression of the enclosing `while' statement.

These issues are benign and depending on circumstances may be adressed
with suitable code refactoring later on.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/3com/3c509.c |  837 +++++++++++++++++++++-----------------
 1 file changed, 465 insertions(+), 372 deletions(-)

linux-3c509-style.diff
Index: linux-3c509/drivers/net/ethernet/3com/3c509.c
===================================================================
--- linux-3c509.orig/drivers/net/ethernet/3com/3c509.c
+++ linux-3c509/drivers/net/ethernet/3com/3c509.c
@@ -1,94 +1,99 @@
 // SPDX-License-Identifier: GPL-2.0
 /* 3c509.c: A 3c509 EtherLink3 ethernet driver for linux. */
 /*
-	Written 1993-2000 by Donald Becker.
-
-	Copyright 1994-2000 by Donald Becker.
-	Copyright 1993 United States Government as represented by the
-	Director, National Security Agency.	 This software may be used and
-	distributed according to the terms of the GNU General Public License,
-	incorporated herein by reference.
-
-	This driver is for the 3Com EtherLinkIII series.
-
-	The author may be reached as becker@scyld.com, or C/O
-	Scyld Computing Corporation
-	410 Severn Ave., Suite 210
-	Annapolis MD 21403
-
-	Known limitations:
-	Because of the way 3c509 ISA detection works it's difficult to predict
-	a priori which of several ISA-mode cards will be detected first.
-
-	This driver does not use predictive interrupt mode, resulting in higher
-	packet latency but lower overhead.  If interrupts are disabled for an
-	unusually long time it could also result in missed packets, but in
-	practice this rarely happens.
-
-
-	FIXES:
-		Alan Cox:       Removed the 'Unexpected interrupt' bug.
-		Michael Meskes:	Upgraded to Donald Becker's version 1.07.
-		Alan Cox:	Increased the eeprom delay. Regardless of
-				what the docs say some people definitely
-				get problems with lower (but in card spec)
-				delays
-		v1.10 4/21/97 Fixed module code so that multiple cards may be detected,
-				other cleanups.  -djb
-		Andrea Arcangeli:	Upgraded to Donald Becker's version 1.12.
-		Rick Payne:	Fixed SMP race condition
-		v1.13 9/8/97 Made 'max_interrupt_work' an insmod-settable variable -djb
-		v1.14 10/15/97 Avoided waiting..discard message for fast machines -djb
-		v1.15 1/31/98 Faster recovery for Tx errors. -djb
-		v1.16 2/3/98 Different ID port handling to avoid sound cards. -djb
-		v1.18 12Mar2001 Andrew Morton
-			- Avoid bogus detect of 3c590's (Andrzej Krzysztofowicz)
-			- Reviewed against 1.18 from scyld.com
-		v1.18a 17Nov2001 Jeff Garzik <jgarzik@pobox.com>
-			- ethtool support
-		v1.18b 1Mar2002 Zwane Mwaikambo <zwane@commfireservices.com>
-			- Power Management support
-		v1.18c 1Mar2002 David Ruggiero <jdr@farfalle.com>
-			- Full duplex support
-		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
-			- Additional ethtool features
-		v1.19a 28Oct2002 Davud Ruggiero <jdr@farfalle.com>
-			- Increase *read_eeprom udelay to workaround oops with 2 cards.
-		v1.19b 08Nov2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
-			- Introduce driver model for EISA cards.
-		v1.20  04Feb2008 Ondrej Zary <linux@rainbow-software.org>
-			- convert to isa_driver and pnp_driver and some cleanups
-*/
+ *	Written 1993-2000 by Donald Becker.
+ *
+ *	Copyright 1994-2000 by Donald Becker.
+ *	Copyright 1993 United States Government as represented by the
+ *	Director, National Security Agency.	 This software may be used and
+ *	distributed according to the terms of the GNU General Public License,
+ *	incorporated herein by reference.
+ *
+ *	This driver is for the 3Com EtherLinkIII series.
+ *
+ *	The author may be reached as becker@scyld.com, or C/O
+ *	Scyld Computing Corporation
+ *	410 Severn Ave., Suite 210
+ *	Annapolis MD 21403
+ *
+ *	Known limitations:
+ *	Because of the way 3c509 ISA detection works it's difficult to predict
+ *	a priori which of several ISA-mode cards will be detected first.
+ *
+ *	This driver does not use predictive interrupt mode, resulting in higher
+ *	packet latency but lower overhead.  If interrupts are disabled for an
+ *	unusually long time it could also result in missed packets, but in
+ *	practice this rarely happens.
+ *
+ *
+ *	FIXES:
+ *		Alan Cox:	Removed the 'Unexpected interrupt' bug.
+ *		Michael Meskes:	Upgraded to Donald Becker's version 1.07.
+ *		Alan Cox:	Increased the eeprom delay. Regardless of
+ *				what the docs say some people definitely
+ *				get problems with lower (but in card spec)
+ *				delays.
+ *		v1.10 4/21/97	Fixed module code so that multiple cards may be
+ *				detected, other cleanups.  -djb
+ *		Andrea Arcangeli: Upgraded to Donald Becker's version 1.12.
+ *		Rick Payne:	Fixed SMP race condition.
+ *		v1.13 9/8/97	Made 'max_interrupt_work' an insmod-settable
+ *				variable. -djb
+ *		v1.14 10/15/97	Avoided waiting..discard message for fast
+ *				machines. -djb
+ *		v1.15 1/31/98	Faster recovery for Tx errors. -djb
+ *		v1.16 2/3/98	Different ID port handling to avoid sound
+ *				cards. -djb
+ *		v1.18 12Mar2001 Andrew Morton
+ *			- Avoid bogus detect of 3c590's (Andrzej Krzysztofowicz)
+ *			- Reviewed against 1.18 from scyld.com
+ *		v1.18a 17Nov2001 Jeff Garzik <jgarzik@pobox.com>
+ *			- ethtool support.
+ *		v1.18b 1Mar2002 Zwane Mwaikambo <zwane@commfireservices.com>
+ *			- Power Management support.
+ *		v1.18c 1Mar2002 David Ruggiero <jdr@farfalle.com>
+ *			- Full duplex support.
+ *		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
+ *			- Additional ethtool features.
+ *		v1.19a 28Oct2002 David Ruggiero <jdr@farfalle.com>
+ *			- Increase *read_eeprom udelay to workaround oops with
+ *			  2 cards.
+ *		v1.19b 08Nov2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
+ *			- Introduce driver model for EISA cards.
+ *		v1.20  04Feb2008 Ondrej Zary <linux@rainbow-software.org>
+ *			- convert to isa_driver and pnp_driver and some
+ *			  cleanups.
+ */
 
 #define DRV_NAME	"3c509"
 
 /* A few values that may be tweaked. */
 
 /* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT  (400*HZ/1000)
+#define TX_TIMEOUT  (400 * HZ / 1000)
 
-#include <linux/module.h>
-#include <linux/isa.h>
-#include <linux/pnp.h>
-#include <linux/string.h>
-#include <linux/interrupt.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>	/* for udelay() */
+#include <linux/device.h>
+#include <linux/eisa.h>
 #include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/in.h>
-#include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/isa.h>
+#include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/etherdevice.h>
 #include <linux/pm.h>
+#include <linux/pnp.h>
 #include <linux/skbuff.h>
-#include <linux/delay.h>	/* for udelay() */
 #include <linux/spinlock.h>
-#include <linux/ethtool.h>
-#include <linux/device.h>
-#include <linux/eisa.h>
-#include <linux/bitops.h>
-
+#include <linux/string.h>
 #include <linux/uaccess.h>
-#include <asm/io.h>
+
 #include <asm/irq.h>
 
 #ifdef EL3_DEBUG
@@ -98,14 +103,15 @@ static int el3_debug = 2;
 #endif
 
 /* Used to do a global count of all the cards in the system.  Must be
- * a global variable so that the eisa probe routines can increment
- * it */
-static int el3_cards = 0;
+ * a global variable so that the eisa probe routines can increment it.
+ */
+static int el3_cards;
 #define EL3_MAX_CARDS 8
 
 /* To minimize the size of the driver source I only define operating
-   constants if they are used several times.  You'll need the manual
-   anyway if you want to understand driver details. */
+ * constants if they are used several times.  You'll need the manual
+ * anyway if you want to understand driver details.
+ */
 /* Offsets from base I/O address. */
 #define EL3_DATA 0x00
 #define EL3_CMD 0x0e
@@ -114,60 +120,90 @@ static int el3_cards = 0;
 
 #define EL3_IO_EXTENT	16
 
-#define EL3WINDOW(win_num) outw(SelectWindow + (win_num), ioaddr + EL3_CMD)
-
+#define EL3WINDOW(win_num) outw(SELECT_WINDOW + (win_num), ioaddr + EL3_CMD)
 
 /* The top five bits written to EL3_CMD are a command, the lower
-   11 bits are the parameter, if applicable. */
+ * 11 bits are the parameter, if applicable.
+ */
 enum c509cmd {
-	TotalReset = 0<<11, SelectWindow = 1<<11, StartCoax = 2<<11,
-	RxDisable = 3<<11, RxEnable = 4<<11, RxReset = 5<<11, RxDiscard = 8<<11,
-	TxEnable = 9<<11, TxDisable = 10<<11, TxReset = 11<<11,
-	FakeIntr = 12<<11, AckIntr = 13<<11, SetIntrEnb = 14<<11,
-	SetStatusEnb = 15<<11, SetRxFilter = 16<<11, SetRxThreshold = 17<<11,
-	SetTxThreshold = 18<<11, SetTxStart = 19<<11, StatsEnable = 21<<11,
-	StatsDisable = 22<<11, StopCoax = 23<<11, PowerUp = 27<<11,
-	PowerDown = 28<<11, PowerAuto = 29<<11};
+	TOTAL_RESET =		 0 << 11,
+	SELECT_WINDOW =		 1 << 11,
+	START_COAX =		 2 << 11,
+	RX_DISABLE =		 3 << 11,
+	RX_ENABLE =		 4 << 11,
+	RX_RESET =		 5 << 11,
+	RX_DISCARD =		 8 << 11,
+	TX_ENABLE =		 9 << 11,
+	TX_DISABLE =		10 << 11,
+	TX_RESET =		11 << 11,
+	FAKE_INTR =		12 << 11,
+	ACK_INTR =		13 << 11,
+	SET_INTR_ENB =		14 << 11,
+	SET_STATUS_ENB =	15 << 11,
+	SET_RX_FILTER =		16 << 11,
+	SET_RX_THRESHOLD =	17 << 11,
+	SET_TX_THRESHOLD =	18 << 11,
+	SET_TX_START =		19 << 11,
+	STATS_ENABLE =		21 << 11,
+	STATS_DISABLE =		22 << 11,
+	STOP_COAX =		23 << 11,
+	POWER_UP =		27 << 11,
+	POWER_DOWN =		28 << 11,
+	POWER_AUTO =		29 << 11,
+};
 
 enum c509status {
-	IntLatch = 0x0001, AdapterFailure = 0x0002, TxComplete = 0x0004,
-	TxAvailable = 0x0008, RxComplete = 0x0010, RxEarly = 0x0020,
-	IntReq = 0x0040, StatsFull = 0x0080, CmdBusy = 0x1000, };
+	INT_LATCH =		0x0001,
+	ADAPTER_FAILURE =	0x0002,
+	TX_COMPLETE =		0x0004,
+	TX_AVAILABLE =		0x0008,
+	RX_COMPLETE =		0x0010,
+	RX_EARLY =		0x0020,
+	INT_REQ =		0x0040,
+	STATS_FULL =		0x0080,
+	CMD_BUSY =		0x1000,
+};
 
-/* The SetRxFilter command accepts the following classes: */
-enum RxFilter {
-	RxStation = 1, RxMulticast = 2, RxBroadcast = 4, RxProm = 8 };
+/* The SET_RX_FILTER command accepts the following classes: */
+enum rx_filter {
+	RX_STATION =	1,
+	RX_MULTICAST =	2,
+	RX_BROADCAST =	4,
+	RX_PROM =	8,
+};
 
 /* Register window 1 offsets, the window used in normal operation. */
 #define TX_FIFO		0x00
 #define RX_FIFO		0x00
-#define RX_STATUS 	0x08
-#define TX_STATUS 	0x0B
-#define TX_FREE		0x0C		/* Remaining free bytes in Tx buffer. */
+#define RX_STATUS	0x08
+#define TX_STATUS	0x0B
+#define TX_FREE		0x0C	/* Remaining free bytes in Tx buffer. */
 
-#define WN0_CONF_CTRL	0x04		/* Window 0: Configuration control register */
-#define WN0_ADDR_CONF	0x06		/* Window 0: Address configuration register */
-#define WN0_IRQ		0x08		/* Window 0: Set IRQ line in bits 12-15. */
-#define WN4_MEDIA	0x0A		/* Window 4: Various transcvr/media bits. */
-#define	MEDIA_TP	0x00C0		/* Enable link beat and jabber for 10baseT. */
-#define WN4_NETDIAG	0x06		/* Window 4: Net diagnostic */
-#define FD_ENABLE	0x8000		/* Enable full-duplex ("external loopback") */
+#define WN0_CONF_CTRL	0x04	/* Window 0: Configuration control register. */
+#define WN0_ADDR_CONF	0x06	/* Window 0: Address configuration register. */
+#define WN0_IRQ		0x08	/* Window 0: Set IRQ line in bits 12-15. */
+#define WN4_MEDIA	0x0A	/* Window 4: Various transcvr/media bits. */
+#define	MEDIA_TP	0x00C0	/* Enable link beat and jabber for 10baseT. */
+#define WN4_NETDIAG	0x06	/* Window 4: Net diagnostic. */
+#define FD_ENABLE	0x8000	/* Enable full-duplex ("external loopback"). */
 
 /*
  * Must be a power of two (we use a binary and in the
- * circular queue)
+ * circular queue).
  */
 #define SKB_QUEUE_SIZE	64
 
 enum el3_cardtype { EL3_ISA, EL3_PNP, EL3_EISA };
 
 struct el3_private {
+	/* for device access */
 	spinlock_t lock;
 	/* skb send-queue */
 	int head, size;
 	struct sk_buff *queue[SKB_QUEUE_SIZE];
 	enum el3_cardtype type;
 };
+
 static int id_port;
 static int current_tag;
 static struct net_device *el3_devs[EL3_MAX_CARDS];
@@ -193,7 +229,7 @@ static struct net_device_stats *el3_get_
 static int el3_rx(struct net_device *dev);
 static int el3_close(struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
-static void el3_tx_timeout (struct net_device *dev, unsigned int txqueue);
+static void el3_tx_timeout(struct net_device *dev, unsigned int txqueue);
 static void el3_down(struct net_device *dev);
 static void el3_up(struct net_device *dev);
 static const struct ethtool_ops ethtool_ops;
@@ -205,24 +241,23 @@ static int el3_resume(struct device *);
 #define el3_resume NULL
 #endif
 
-
-/* generic device remove for all device types */
-static int el3_device_remove (struct device *device);
+/* Generic device remove for all device types. */
+static int el3_device_remove(struct device *device);
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void el3_poll_controller(struct net_device *dev);
 #endif
 
-/* Return 0 on success, 1 on error, 2 when found already detected PnP card */
+/* Return 0 on success, 1 on error, 2 when found already detected PnP card. */
 static int el3_isa_id_sequence(__be16 *phys_addr)
 {
 	short lrs_state = 0xff;
 	int i;
 
 	/* ISA boards are detected by sending the ID sequence to the
-	   ID_PORT.  We find cards past the first by setting the 'current_tag'
-	   on cards as they are found.  Cards with their tag set will not
-	   respond to subsequent ID sequences. */
-
+	 * ID_PORT.  We find cards past the first by setting the 'current_tag'
+	 * on cards as they are found.  Cards with their tag set will not
+	 * respond to subsequent ID sequences.
+	 */
 	outb(0x00, id_port);
 	outb(0x00, id_port);
 	for (i = 0; i < 255; i++) {
@@ -238,24 +273,33 @@ static int el3_isa_id_sequence(__be16 *p
 	if (id_read_eeprom(7) != 0x6d50)
 		return 1;
 	/* Read in EEPROM data, which does contention-select.
-	   Only the lowest address board will stay "on-line".
-	   3Com got the byte order backwards. */
+	 * Only the lowest address board will stay "on-line".
+	 * 3Com got the byte order backwards.
+	 */
 	for (i = 0; i < 3; i++)
 		phys_addr[i] = htons(id_read_eeprom(i));
 #ifdef CONFIG_PNP
 	if (!nopnp) {
 		/* The ISA PnP 3c509 cards respond to the ID sequence too.
-		   This check is needed in order not to register them twice. */
+		 * This check is needed in order not to register them twice.
+		 */
 		for (i = 0; i < el3_cards; i++) {
 			struct el3_private *lp = netdev_priv(el3_devs[i]);
+
 			if (lp->type == EL3_PNP &&
-			    ether_addr_equal((u8 *)phys_addr, el3_devs[i]->dev_addr)) {
+			    ether_addr_equal((u8 *)phys_addr,
+					     el3_devs[i]->dev_addr)) {
 				if (el3_debug > 3)
 					pr_debug("3c509 with address %02x %02x %02x %02x %02x %02x was found by ISAPnP\n",
-						phys_addr[0] & 0xff, phys_addr[0] >> 8,
-						phys_addr[1] & 0xff, phys_addr[1] >> 8,
-						phys_addr[2] & 0xff, phys_addr[2] >> 8);
-				/* Set the adaptor tag so that the next card can be found. */
+						 phys_addr[0] & 0xff,
+						 phys_addr[0] >> 8,
+						 phys_addr[1] & 0xff,
+						 phys_addr[1] >> 8,
+						 phys_addr[2] & 0xff,
+						 phys_addr[2] >> 8);
+				/* Set the adaptor tag so that the next card
+				 * can be found.
+				 */
 				outb(0xd0 + ++current_tag, id_port);
 				return 2;
 			}
@@ -263,7 +307,6 @@ static int el3_isa_id_sequence(__be16 *p
 	}
 #endif /* CONFIG_PNP */
 	return 0;
-
 }
 
 static void el3_dev_fill(struct net_device *dev, __be16 *phys_addr, int ioaddr,
@@ -280,8 +323,8 @@ static void el3_dev_fill(struct net_devi
 
 static int el3_isa_match(struct device *pdev, unsigned int ndev)
 {
-	struct net_device *dev;
 	int ioaddr, isa_irq, if_port, err;
+	struct net_device *dev;
 	unsigned int iobase;
 	__be16 phys_addr[3];
 
@@ -335,8 +378,7 @@ static int el3_isa_match(struct device *
 	return 1;
 }
 
-static void el3_isa_remove(struct device *pdev,
-				    unsigned int ndev)
+static void el3_isa_remove(struct device *pdev, unsigned int ndev)
 {
 	el3_device_remove(pdev);
 	dev_set_drvdata(pdev, NULL);
@@ -384,6 +426,7 @@ static struct isa_driver el3_isa_driver
 		.name	= "3c509"
 	},
 };
+
 static int isa_registered;
 
 #ifdef CONFIG_PNP
@@ -401,10 +444,10 @@ MODULE_DEVICE_TABLE(pnp, el3_pnp_ids);
 
 static int el3_pnp_probe(struct pnp_dev *pdev, const struct pnp_device_id *id)
 {
-	short i;
+	struct net_device *dev = NULL;
 	int ioaddr, irq, if_port;
 	__be16 phys_addr[3];
-	struct net_device *dev = NULL;
+	short i;
 	int err;
 
 	ioaddr = pnp_port_start(pdev, 0);
@@ -464,6 +507,7 @@ static struct pnp_driver el3_pnp_driver
 	.resume		= el3_pnp_resume,
 #endif
 };
+
 static int pnp_registered;
 #endif /* CONFIG_PNP */
 
@@ -480,7 +524,7 @@ static const struct eisa_device_id el3_e
 };
 MODULE_DEVICE_TABLE(eisa, el3_eisa_ids);
 
-static int el3_eisa_probe (struct device *device);
+static int el3_eisa_probe(struct device *device);
 
 static struct eisa_driver el3_eisa_driver = {
 		.id_table = el3_eisa_ids,
@@ -492,17 +536,18 @@ static struct eisa_driver el3_eisa_drive
 				.resume  = el3_resume,
 		}
 };
+
 static int eisa_registered;
 #endif
 
 static const struct net_device_ops netdev_ops = {
-	.ndo_open 		= el3_open,
-	.ndo_stop	 	= el3_close,
-	.ndo_start_xmit 	= el3_start_xmit,
-	.ndo_get_stats 		= el3_get_stats,
+	.ndo_open		= el3_open,
+	.ndo_stop		= el3_close,
+	.ndo_start_xmit		= el3_start_xmit,
+	.ndo_get_stats		= el3_get_stats,
 	.ndo_set_rx_mode	= set_multicast_list,
-	.ndo_tx_timeout 	= el3_tx_timeout,
-	.ndo_set_mac_address 	= eth_mac_addr,
+	.ndo_tx_timeout		= el3_tx_timeout,
+	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= el3_poll_controller,
@@ -511,11 +556,11 @@ static const struct net_device_ops netde
 
 static int el3_common_init(struct net_device *dev)
 {
-	struct el3_private *lp = netdev_priv(dev);
-	int err;
-	static const char * const if_names[] = {
+	static const char *const if_names[] = {
 		"10baseT", "AUI", "undefined", "BNC"
 	};
+	struct el3_private *lp = netdev_priv(dev);
+	int err;
 
 	spin_lock_init(&lp->lock);
 
@@ -534,56 +579,55 @@ static int el3_common_init(struct net_de
 	err = register_netdev(dev);
 	if (err) {
 		pr_err("Failed to register 3c5x9 at %#3.3lx, IRQ %d.\n",
-			dev->base_addr, dev->irq);
+		       dev->base_addr, dev->irq);
 		release_region(dev->base_addr, EL3_IO_EXTENT);
 		return err;
 	}
 
 	pr_info("%s: 3c5x9 found at %#3.3lx, %s port, address %pM, IRQ %d.\n",
-	       dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)],
-	       dev->dev_addr, dev->irq);
+		dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)],
+		dev->dev_addr, dev->irq);
 
 	return 0;
-
 }
 
-static void el3_common_remove (struct net_device *dev)
+static void el3_common_remove(struct net_device *dev)
 {
-	unregister_netdev (dev);
+	unregister_netdev(dev);
 	release_region(dev->base_addr, EL3_IO_EXTENT);
-	free_netdev (dev);
+	free_netdev(dev);
 }
 
 #ifdef CONFIG_EISA
 static int el3_eisa_probe(struct device *device)
 {
-	short i;
-	int ioaddr, irq, if_port;
-	__be16 phys_addr[3];
 	struct net_device *dev = NULL;
 	struct eisa_device *edev;
+	int ioaddr, irq, if_port;
+	__be16 phys_addr[3];
+	short i;
 	int err;
 
 	/* Yeepee, The driver framework is calling us ! */
-	edev = to_eisa_device (device);
+	edev = to_eisa_device(device);
 	ioaddr = edev->base_addr;
 
 	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c579-eisa"))
 		return -EBUSY;
 
 	/* Change the register set to the configuration window 0. */
-	outw(SelectWindow | 0, ioaddr + 0xC80 + EL3_CMD);
+	outw(SELECT_WINDOW | 0, ioaddr + 0xC80 + EL3_CMD);
 
 	irq = inw(ioaddr + WN0_IRQ) >> 12;
-	if_port = inw(ioaddr + 6)>>14;
+	if_port = inw(ioaddr + 6) >> 14;
 	for (i = 0; i < 3; i++)
 		phys_addr[i] = htons(read_eeprom(ioaddr, i));
 
 	/* Restore the "Product ID" to the EEPROM read register. */
 	read_eeprom(ioaddr, 3);
 
-	dev = alloc_etherdev(sizeof (struct el3_private));
-	if (dev == NULL) {
+	dev = alloc_etherdev(sizeof(struct el3_private));
+	if (!dev) {
 		release_region(ioaddr, EL3_IO_EXTENT);
 		return -ENOMEM;
 	}
@@ -591,11 +635,11 @@ static int el3_eisa_probe(struct device
 	SET_NETDEV_DEV(dev, device);
 
 	el3_dev_fill(dev, phys_addr, ioaddr, irq, if_port, EL3_EISA);
-	eisa_set_drvdata (edev, dev);
+	eisa_set_drvdata(edev, dev);
 	err = el3_common_init(dev);
 
 	if (err) {
-		eisa_set_drvdata (edev, NULL);
+		eisa_set_drvdata(edev, NULL);
 		free_netdev(dev);
 		return err;
 	}
@@ -607,25 +651,27 @@ static int el3_eisa_probe(struct device
 
 /* This remove works for all device types.
  *
- * The net dev must be stored in the driver data field */
+ * The net dev must be stored in the driver data field.
+ */
 static int el3_device_remove(struct device *device)
 {
 	struct net_device *dev;
 
 	dev = dev_get_drvdata(device);
 
-	el3_common_remove (dev);
+	el3_common_remove(dev);
 	return 0;
 }
 
 /* Read a word from the EEPROM using the regular EEPROM access register.
-   Assume that we are in register window zero.
+ * Assume that we are in register window zero.
  */
 static ushort read_eeprom(int ioaddr, int index)
 {
 	outw(EEPROM_READ + index, ioaddr + 10);
-	/* Pause for at least 162 us. for the read to take place.
-	   Some chips seem to require much longer */
+	/* Pause for at least 162 us for the read to take place.
+	 * Some chips seem to require much longer.
+	 */
 	mdelay(2);
 	return inw(ioaddr + 12);
 }
@@ -635,12 +681,14 @@ static ushort id_read_eeprom(int index)
 {
 	int bit, word = 0;
 
-	/* Issue read command, and pause for at least 162 us. for it to complete.
-	   Assume extra-fast 16Mhz bus. */
+	/* Issue read command, and pause for at least 162 us for it to
+	 * complete. Assume extra-fast 16MHz bus.
+	 */
 	outb(EEPROM_READ + index, id_port);
 
-	/* Pause for at least 162 us. for the read to take place. */
-	/* Some chips seem to require much longer */
+	/* Pause for at least 162 us for the read to take place.
+	 * Some chips seem to require much longer.
+	 */
 	mdelay(4);
 
 	for (bit = 15; bit >= 0; bit--)
@@ -652,16 +700,14 @@ static ushort id_read_eeprom(int index)
 	return word;
 }
 
-
-static int
-el3_open(struct net_device *dev)
+static int el3_open(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
 	int i;
 
-	outw(TxReset, ioaddr + EL3_CMD);
-	outw(RxReset, ioaddr + EL3_CMD);
-	outw(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
+	outw(TX_RESET, ioaddr + EL3_CMD);
+	outw(RX_RESET, ioaddr + EL3_CMD);
+	outw(SET_STATUS_ENB | 0x00, ioaddr + EL3_CMD);
 
 	i = request_irq(dev->irq, el3_interrupt, 0, dev->name, dev);
 	if (i)
@@ -669,20 +715,20 @@ el3_open(struct net_device *dev)
 
 	EL3WINDOW(0);
 	if (el3_debug > 3)
-		pr_debug("%s: Opening, IRQ %d	 status@%x %4.4x.\n", dev->name,
-			   dev->irq, ioaddr + EL3_STATUS, inw(ioaddr + EL3_STATUS));
+		pr_debug("%s: Opening, IRQ %d	 status@%x %4.4x.\n",
+			 dev->name, dev->irq,
+			 ioaddr + EL3_STATUS, inw(ioaddr + EL3_STATUS));
 
 	el3_up(dev);
 
 	if (el3_debug > 3)
 		pr_debug("%s: Opened 3c509  IRQ %d  status %4.4x.\n",
-			   dev->name, dev->irq, inw(ioaddr + EL3_STATUS));
+			 dev->name, dev->irq, inw(ioaddr + EL3_STATUS));
 
 	return 0;
 }
 
-static void
-el3_tx_timeout (struct net_device *dev, unsigned int txqueue)
+static void el3_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	int ioaddr = dev->base_addr;
 
@@ -693,33 +739,31 @@ el3_tx_timeout (struct net_device *dev,
 	dev->stats.tx_errors++;
 	netif_trans_update(dev); /* prevent tx timeout */
 	/* Issue TX_RESET and TX_START commands. */
-	outw(TxReset, ioaddr + EL3_CMD);
-	outw(TxEnable, ioaddr + EL3_CMD);
+	outw(TX_RESET, ioaddr + EL3_CMD);
+	outw(TX_ENABLE, ioaddr + EL3_CMD);
 	netif_wake_queue(dev);
 }
 
-
-static netdev_tx_t
-el3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t el3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct el3_private *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
 	unsigned long flags;
 
-	netif_stop_queue (dev);
+	netif_stop_queue(dev);
 
 	dev->stats.tx_bytes += skb->len;
 
 	if (el3_debug > 4) {
 		pr_debug("%s: el3_start_xmit(length = %u) called, status %4.4x.\n",
-			   dev->name, skb->len, inw(ioaddr + EL3_STATUS));
+			 dev->name, skb->len, inw(ioaddr + EL3_STATUS));
 	}
 	/*
 	 *	We lock the driver against other processors. Note
 	 *	we don't need to lock versus the IRQ as we suspended
 	 *	that. This means that we lose the ability to take
 	 *	an RX during a TX upload. That sucks a bit with SMP
-	 *	on an original 3c509 (2K buffer)
+	 *	on an original 3c509 (2K buffer).
 	 *
 	 *	Using disable_irq stops us crapping on other
 	 *	time sensitive devices.
@@ -733,39 +777,43 @@ el3_start_xmit(struct sk_buff *skb, stru
 	/* ... and the packet rounded to a doubleword. */
 	outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
 
-	if (inw(ioaddr + TX_FREE) > 1536)
+	if (inw(ioaddr + TX_FREE) > 1536) {
 		netif_start_queue(dev);
-	else
+	} else {
 		/* Interrupt us when the FIFO has room for max-sized packet. */
-		outw(SetTxThreshold + 1536, ioaddr + EL3_CMD);
+		outw(SET_TX_THRESHOLD + 1536, ioaddr + EL3_CMD);
+	}
 
 	spin_unlock_irqrestore(&lp->lock, flags);
 
-	dev_consume_skb_any (skb);
+	dev_consume_skb_any(skb);
 
 	/* Clear the Tx status stack. */
 	{
 		short tx_status;
 		int i = 4;
 
-		while (--i > 0	&&	(tx_status = inb(ioaddr + TX_STATUS)) > 0) {
-			if (tx_status & 0x38) dev->stats.tx_aborted_errors++;
-			if (tx_status & 0x30) outw(TxReset, ioaddr + EL3_CMD);
-			if (tx_status & 0x3C) outw(TxEnable, ioaddr + EL3_CMD);
-			outb(0x00, ioaddr + TX_STATUS); /* Pop the status stack. */
+		while (--i > 0 && (tx_status = inb(ioaddr + TX_STATUS)) > 0) {
+			if (tx_status & 0x38)
+				dev->stats.tx_aborted_errors++;
+			if (tx_status & 0x30)
+				outw(TX_RESET, ioaddr + EL3_CMD);
+			if (tx_status & 0x3C)
+				outw(TX_ENABLE, ioaddr + EL3_CMD);
+			/* Pop the status stack. */
+			outb(0x00, ioaddr + TX_STATUS);
 		}
 	}
 	return NETDEV_TX_OK;
 }
 
 /* The EL3 interrupt handler. */
-static irqreturn_t
-el3_interrupt(int irq, void *dev_id)
+static irqreturn_t el3_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
+	int i = max_interrupt_work;
 	struct el3_private *lp;
 	int ioaddr, status;
-	int i = max_interrupt_work;
 
 	lp = netdev_priv(dev);
 	spin_lock(&lp->lock);
@@ -778,70 +826,89 @@ el3_interrupt(int irq, void *dev_id)
 	}
 
 	while ((status = inw(ioaddr + EL3_STATUS)) &
-		   (IntLatch | RxComplete | StatsFull)) {
+	       (INT_LATCH | RX_COMPLETE | STATS_FULL)) {
 
-		if (status & RxComplete)
+		if (status & RX_COMPLETE)
 			el3_rx(dev);
 
-		if (status & TxAvailable) {
+		if (status & TX_AVAILABLE) {
 			if (el3_debug > 5)
 				pr_debug("	TX room bit was handled.\n");
 			/* There's room in the FIFO for a full-sized packet. */
-			outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
-			netif_wake_queue (dev);
+			outw(ACK_INTR | TX_AVAILABLE, ioaddr + EL3_CMD);
+			netif_wake_queue(dev);
 		}
-		if (status & (AdapterFailure | RxEarly | StatsFull | TxComplete)) {
+		if (status &
+		    (ADAPTER_FAILURE | RX_EARLY | STATS_FULL | TX_COMPLETE)) {
 			/* Handle all uncommon interrupts. */
-			if (status & StatsFull)				/* Empty statistics. */
+			if (status & STATS_FULL) {
+				/* Empty statistics. */
 				update_stats(dev);
-			if (status & RxEarly) {				/* Rx early is unused. */
+			}
+			if (status & RX_EARLY) {
+				/* Rx early is unused. */
 				el3_rx(dev);
-				outw(AckIntr | RxEarly, ioaddr + EL3_CMD);
+				outw(ACK_INTR | RX_EARLY, ioaddr + EL3_CMD);
 			}
-			if (status & TxComplete) {			/* Really Tx error. */
+			if (status & TX_COMPLETE) {
+				/* Really Tx error. */
 				short tx_status;
 				int i = 4;
 
-				while (--i>0 && (tx_status = inb(ioaddr + TX_STATUS)) > 0) {
-					if (tx_status & 0x38) dev->stats.tx_aborted_errors++;
-					if (tx_status & 0x30) outw(TxReset, ioaddr + EL3_CMD);
-					if (tx_status & 0x3C) outw(TxEnable, ioaddr + EL3_CMD);
-					outb(0x00, ioaddr + TX_STATUS); /* Pop the status stack. */
+				while (--i > 0 &&
+				       ((tx_status = inb(ioaddr + TX_STATUS))
+					> 0)) {
+					if (tx_status & 0x38)
+						dev->stats.tx_aborted_errors++;
+					if (tx_status & 0x30)
+						outw(TX_RESET,
+						     ioaddr + EL3_CMD);
+					if (tx_status & 0x3C)
+						outw(TX_ENABLE,
+						     ioaddr + EL3_CMD);
+					/* Pop the status stack. */
+					outb(0x00, ioaddr + TX_STATUS);
 				}
 			}
-			if (status & AdapterFailure) {
-				/* Adapter failure requires Rx reset and reinit. */
-				outw(RxReset, ioaddr + EL3_CMD);
+			if (status & ADAPTER_FAILURE) {
+				/* Adapter failure requires Rx reset
+				 * and reinit.
+				 */
+				outw(RX_RESET, ioaddr + EL3_CMD);
 				/* Set the Rx filter to the current state. */
-				outw(SetRxFilter | RxStation | RxBroadcast
-					 | (dev->flags & IFF_ALLMULTI ? RxMulticast : 0)
-					 | (dev->flags & IFF_PROMISC ? RxProm : 0),
-					 ioaddr + EL3_CMD);
-				outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
-				outw(AckIntr | AdapterFailure, ioaddr + EL3_CMD);
+				outw((SET_RX_FILTER | RX_STATION |
+				      RX_BROADCAST |
+				      (dev->flags & IFF_ALLMULTI ?
+				       RX_MULTICAST : 0) |
+				      (dev->flags & IFF_PROMISC ?
+				       RX_PROM : 0)),
+				     ioaddr + EL3_CMD);
+				/* Re-enable the receiver. */
+				outw(RX_ENABLE, ioaddr + EL3_CMD);
+				outw(ACK_INTR | ADAPTER_FAILURE,
+				     ioaddr + EL3_CMD);
 			}
 		}
 
 		if (--i < 0) {
 			pr_err("%s: Infinite loop in interrupt, status %4.4x.\n",
-				   dev->name, status);
+			       dev->name, status);
 			/* Clear all interrupts. */
-			outw(AckIntr | 0xFF, ioaddr + EL3_CMD);
+			outw(ACK_INTR | 0xFF, ioaddr + EL3_CMD);
 			break;
 		}
 		/* Acknowledge the IRQ. */
-		outw(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD); /* Ack IRQ */
+		outw(ACK_INTR | INT_REQ | INT_LATCH, ioaddr + EL3_CMD);
 	}
 
 	if (el3_debug > 4) {
 		pr_debug("%s: exiting interrupt, status %4.4x.\n", dev->name,
-			   inw(ioaddr + EL3_STATUS));
+			 inw(ioaddr + EL3_STATUS));
 	}
 	spin_unlock(&lp->lock);
 	return IRQ_HANDLED;
 }
 
-
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /*
  * Polling receive - used by netconsole and other diagnostic tools
@@ -855,28 +922,23 @@ static void el3_poll_controller(struct n
 }
 #endif
 
-static struct net_device_stats *
-el3_get_stats(struct net_device *dev)
+static struct net_device_stats *el3_get_stats(struct net_device *dev)
 {
 	struct el3_private *lp = netdev_priv(dev);
 	unsigned long flags;
 
-	/*
-	 *	This is fast enough not to bother with disable IRQ
-	 *	stuff.
-	 */
-
+	/* This is fast enough not to bother with disable IRQ stuff. */
 	spin_lock_irqsave(&lp->lock, flags);
 	update_stats(dev);
 	spin_unlock_irqrestore(&lp->lock, flags);
 	return &dev->stats;
 }
 
-/*  Update statistics.  We change to register window 6, so this should be run
-	single-threaded if the device is active. This is expected to be a rare
-	operation, and it's simpler for the rest of the driver to assume that
-	window 1 is always valid rather than use a special window-state variable.
-	*/
+/* Update statistics.  We change to register window 6, so this should be run
+ * single-threaded if the device is active. This is expected to be a rare
+ * operation, and it's simpler for the rest of the driver to assume that
+ * window 1 is always valid rather than use a special window-state variable.
+ */
 static void update_stats(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
@@ -884,10 +946,10 @@ static void update_stats(struct net_devi
 	if (el3_debug > 5)
 		pr_debug("   Updating the statistics.\n");
 	/* Turn off statistics updates while reading. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
+	outw(STATS_DISABLE, ioaddr + EL3_CMD);
 	/* Switch to the stats window, and read everything. */
 	EL3WINDOW(6);
-	dev->stats.tx_carrier_errors 	+= inb(ioaddr + 0);
+	dev->stats.tx_carrier_errors	+= inb(ioaddr + 0);
 	dev->stats.tx_heartbeat_errors	+= inb(ioaddr + 1);
 	/* Multiple collisions. */	   inb(ioaddr + 2);
 	dev->stats.collisions		+= inb(ioaddr + 3);
@@ -901,31 +963,42 @@ static void update_stats(struct net_devi
 
 	/* Back to window 1, and turn statistics back on. */
 	EL3WINDOW(1);
-	outw(StatsEnable, ioaddr + EL3_CMD);
+	outw(STATS_ENABLE, ioaddr + EL3_CMD);
 }
 
-static int
-el3_rx(struct net_device *dev)
+static int el3_rx(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
 	short rx_status;
 
 	if (el3_debug > 5)
 		pr_debug("   In rx_packet(), status %4.4x, rx_status %4.4x.\n",
-			   inw(ioaddr+EL3_STATUS), inw(ioaddr+RX_STATUS));
+			 inw(ioaddr + EL3_STATUS), inw(ioaddr + RX_STATUS));
 	while ((rx_status = inw(ioaddr + RX_STATUS)) > 0) {
-		if (rx_status & 0x4000) { /* Error, update stats. */
+		if (rx_status & 0x4000) {
+			/* Error, update stats. */
 			short error = rx_status & 0x3800;
 
-			outw(RxDiscard, ioaddr + EL3_CMD);
+			outw(RX_DISCARD, ioaddr + EL3_CMD);
 			dev->stats.rx_errors++;
 			switch (error) {
-			case 0x0000:		dev->stats.rx_over_errors++; break;
-			case 0x0800:		dev->stats.rx_length_errors++; break;
-			case 0x1000:		dev->stats.rx_frame_errors++; break;
-			case 0x1800:		dev->stats.rx_length_errors++; break;
-			case 0x2000:		dev->stats.rx_frame_errors++; break;
-			case 0x2800:		dev->stats.rx_crc_errors++; break;
+			case 0x0000:
+				dev->stats.rx_over_errors++;
+				break;
+			case 0x0800:
+				dev->stats.rx_length_errors++;
+				break;
+			case 0x1000:
+				dev->stats.rx_frame_errors++;
+				break;
+			case 0x1800:
+				dev->stats.rx_length_errors++;
+				break;
+			case 0x2000:
+				dev->stats.rx_frame_errors++;
+				break;
+			case 0x2800:
+				dev->stats.rx_crc_errors++; break;
 			}
 		} else {
 			short pkt_len = rx_status & 0x7ff;
@@ -934,49 +1007,51 @@ el3_rx(struct net_device *dev)
 			skb = netdev_alloc_skb(dev, pkt_len + 5);
 			if (el3_debug > 4)
 				pr_debug("Receiving packet size %d status %4.4x.\n",
-					   pkt_len, rx_status);
-			if (skb != NULL) {
-				skb_reserve(skb, 2);     /* Align IP on 16 byte */
+					 pkt_len, rx_status);
+			if (skb) {
+				/* Align IP on 16 byte. */
+				skb_reserve(skb, 2);
 
-				/* 'skb->data' points to the start of sk_buff data area. */
-				insl(ioaddr + RX_FIFO, skb_put(skb,pkt_len),
-					 (pkt_len + 3) >> 2);
+				/* 'skb->data' points to the start of sk_buff
+				 * data area.
+				 */
+				insl(ioaddr + RX_FIFO, skb_put(skb, pkt_len),
+				     (pkt_len + 3) >> 2);
 
-				outw(RxDiscard, ioaddr + EL3_CMD); /* Pop top Rx packet. */
-				skb->protocol = eth_type_trans(skb,dev);
+				/* Pop top Rx packet. */
+				outw(RX_DISCARD, ioaddr + EL3_CMD);
+				skb->protocol = eth_type_trans(skb, dev);
 				netif_rx(skb);
 				dev->stats.rx_bytes += pkt_len;
 				dev->stats.rx_packets++;
 				continue;
 			}
-			outw(RxDiscard, ioaddr + EL3_CMD);
+			outw(RX_DISCARD, ioaddr + EL3_CMD);
 			dev->stats.rx_dropped++;
 			if (el3_debug)
 				pr_debug("%s: Couldn't allocate a sk_buff of size %d.\n",
-					   dev->name, pkt_len);
+					 dev->name, pkt_len);
 		}
-		inw(ioaddr + EL3_STATUS); 				/* Delay. */
+		inw(ioaddr + EL3_STATUS);			/* Delay. */
 		while (inw(ioaddr + EL3_STATUS) & 0x1000)
 			pr_debug("	Waiting for 3c509 to discard packet, status %x.\n",
-				   inw(ioaddr + EL3_STATUS) );
+				 inw(ioaddr + EL3_STATUS));
 	}
 
 	return 0;
 }
 
-/*
- *     Set or clear the multicast filter for this adaptor.
- */
-static void
-set_multicast_list(struct net_device *dev)
+/* Set or clear the multicast filter for this adaptor. */
+static void set_multicast_list(struct net_device *dev)
 {
-	unsigned long flags;
 	struct el3_private *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
 	int mc_count = netdev_mc_count(dev);
+	unsigned long flags;
 
 	if (el3_debug > 1) {
 		static int old;
+
 		if (old != mc_count) {
 			old = mc_count;
 			pr_debug("%s: Setting Rx mode to %d addresses.\n",
@@ -984,23 +1059,24 @@ set_multicast_list(struct net_device *de
 		}
 	}
 	spin_lock_irqsave(&lp->lock, flags);
-	if (dev->flags&IFF_PROMISC) {
-		outw(SetRxFilter | RxStation | RxMulticast | RxBroadcast | RxProm,
-			 ioaddr + EL3_CMD);
-	}
-	else if (mc_count || (dev->flags&IFF_ALLMULTI)) {
-		outw(SetRxFilter | RxStation | RxMulticast | RxBroadcast, ioaddr + EL3_CMD);
+	if (dev->flags & IFF_PROMISC) {
+		outw((SET_RX_FILTER | RX_STATION | RX_MULTICAST |
+		      RX_BROADCAST | RX_PROM),
+		     ioaddr + EL3_CMD);
+	} else if (mc_count || (dev->flags & IFF_ALLMULTI)) {
+		outw(SET_RX_FILTER | RX_STATION | RX_MULTICAST | RX_BROADCAST,
+		     ioaddr + EL3_CMD);
+	} else {
+		outw(SET_RX_FILTER | RX_STATION | RX_BROADCAST,
+		     ioaddr + EL3_CMD);
 	}
-	else
-		outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
 	spin_unlock_irqrestore(&lp->lock, flags);
 }
 
-static int
-el3_close(struct net_device *dev)
+static int el3_close(struct net_device *dev)
 {
-	int ioaddr = dev->base_addr;
 	struct el3_private *lp = netdev_priv(dev);
+	int ioaddr = dev->base_addr;
 
 	if (el3_debug > 2)
 		pr_debug("%s: Shutting down ethercard.\n", dev->name);
@@ -1013,15 +1089,15 @@ el3_close(struct net_device *dev)
 	if (lp->type != EL3_EISA) {
 		/* But we explicitly zero the IRQ line select anyway. Don't do
 		 * it on EISA cards, it prevents the module from getting an
-		 * IRQ after unload+reload... */
+		 * IRQ after unload+reload...
+		 */
 		outw(0x0f00, ioaddr + WN0_IRQ);
 	}
 
 	return 0;
 }
 
-static int
-el3_link_ok(struct net_device *dev)
+static int el3_link_ok(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
 	u16 tmp;
@@ -1029,18 +1105,18 @@ el3_link_ok(struct net_device *dev)
 	EL3WINDOW(4);
 	tmp = inw(ioaddr + WN4_MEDIA);
 	EL3WINDOW(1);
-	return tmp & (1<<11);
+	return tmp & (1 << 11);
 }
 
-static void
-el3_netdev_get_ecmd(struct net_device *dev, struct ethtool_link_ksettings *cmd)
+static void el3_netdev_get_ecmd(struct net_device *dev,
+				struct ethtool_link_ksettings *cmd)
 {
-	u16 tmp;
 	int ioaddr = dev->base_addr;
 	u32 supported;
+	u16 tmp;
 
 	EL3WINDOW(0);
-	/* obtain current transceiver via WN4_MEDIA? */
+	/* Obtain current transceiver via WN4_MEDIA? */
 	tmp = inw(ioaddr + WN0_ADDR_CONF);
 	switch (tmp >> 14) {
 	case 0:
@@ -1059,13 +1135,13 @@ el3_netdev_get_ecmd(struct net_device *d
 	cmd->base.duplex = DUPLEX_HALF;
 	supported = 0;
 	tmp = inw(ioaddr + WN0_CONF_CTRL);
-	if (tmp & (1<<13))
+	if (tmp & (1 << 13))
 		supported |= SUPPORTED_AUI;
-	if (tmp & (1<<12))
+	if (tmp & (1 << 12))
 		supported |= SUPPORTED_BNC;
-	if (tmp & (1<<9)) {
+	if (tmp & (1 << 9)) {
 		supported |= SUPPORTED_TP | SUPPORTED_10baseT_Half |
-				SUPPORTED_10baseT_Full;	/* hmm... */
+			     SUPPORTED_10baseT_Full;	/* hmm... */
 		EL3WINDOW(4);
 		tmp = inw(ioaddr + WN4_NETDIAG);
 		if (tmp & FD_ENABLE)
@@ -1078,17 +1154,15 @@ el3_netdev_get_ecmd(struct net_device *d
 	EL3WINDOW(1);
 }
 
-static int
-el3_netdev_set_ecmd(struct net_device *dev,
-		    const struct ethtool_link_ksettings *cmd)
+static int el3_netdev_set_ecmd(struct net_device *dev,
+			       const struct ethtool_link_ksettings *cmd)
 {
-	u16 tmp;
 	int ioaddr = dev->base_addr;
+	u16 tmp;
 
 	if (cmd->base.speed != SPEED_10)
 		return -EINVAL;
-	if ((cmd->base.duplex != DUPLEX_HALF) &&
-	    (cmd->base.duplex != DUPLEX_FULL))
+	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
 		return -EINVAL;
 
 	/* change XCVR type */
@@ -1096,16 +1170,16 @@ el3_netdev_set_ecmd(struct net_device *d
 	tmp = inw(ioaddr + WN0_ADDR_CONF);
 	switch (cmd->base.port) {
 	case PORT_TP:
-		tmp &= ~(3<<14);
+		tmp &= ~(3 << 14);
 		dev->if_port = 0;
 		break;
 	case PORT_AUI:
-		tmp &= ~(3<<14);
-		tmp |= (1<<14);
+		tmp &= ~(3 << 14);
+		tmp |= 1 << 14;
 		dev->if_port = 1;
 		break;
 	case PORT_BNC:
-		tmp |= (3<<14);
+		tmp |= 3 << 14;
 		dev->if_port = 3;
 		break;
 	default:
@@ -1114,13 +1188,14 @@ el3_netdev_set_ecmd(struct net_device *d
 
 	outw(tmp, ioaddr + WN0_ADDR_CONF);
 	if (dev->if_port == 3) {
-		/* fire up the DC-DC convertor if BNC gets enabled */
+		/* Fire up the DC-DC converter if BNC gets enabled. */
 		tmp = inw(ioaddr + WN0_ADDR_CONF);
 		if (tmp & (3 << 14)) {
-			outw(StartCoax, ioaddr + EL3_CMD);
+			outw(START_COAX, ioaddr + EL3_CMD);
 			udelay(800);
-		} else
+		} else {
 			return -EIO;
+		}
 	}
 
 	EL3WINDOW(4);
@@ -1135,7 +1210,8 @@ el3_netdev_set_ecmd(struct net_device *d
 	return 0;
 }
 
-static void el3_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+static void el3_get_drvinfo(struct net_device *dev,
+			    struct ethtool_drvinfo *info)
 {
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 }
@@ -1193,41 +1269,41 @@ static const struct ethtool_ops ethtool_
 	.set_link_ksettings = el3_set_link_ksettings,
 };
 
-static void
-el3_down(struct net_device *dev)
+static void el3_down(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
 
 	netif_stop_queue(dev);
 
 	/* Turn off statistics ASAP.  We update lp->stats below. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
+	outw(STATS_DISABLE, ioaddr + EL3_CMD);
 
 	/* Disable the receiver and transmitter. */
-	outw(RxDisable, ioaddr + EL3_CMD);
-	outw(TxDisable, ioaddr + EL3_CMD);
+	outw(RX_DISABLE, ioaddr + EL3_CMD);
+	outw(TX_DISABLE, ioaddr + EL3_CMD);
 
-	if (dev->if_port == 3)
+	if (dev->if_port == 3) {
 		/* Turn off thinnet power.  Green! */
-		outw(StopCoax, ioaddr + EL3_CMD);
-	else if (dev->if_port == 0) {
-		/* Disable link beat and jabber, if_port may change here next open(). */
+		outw(STOP_COAX, ioaddr + EL3_CMD);
+	} else if (dev->if_port == 0) {
+		/* Disable link beat and jabber, if_port may change here next
+		 * open().
+		 */
 		EL3WINDOW(4);
 		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
 	}
 
-	outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
+	outw(SET_INTR_ENB | 0x0000, ioaddr + EL3_CMD);
 
 	update_stats(dev);
 }
 
-static void
-el3_up(struct net_device *dev)
+static void el3_up(struct net_device *dev)
 {
-	int i, sw_info, net_diag;
 	int ioaddr = dev->base_addr;
+	int i, sw_info, net_diag;
 
-	/* Activating the board required and does no harm otherwise */
+	/* Activating the board required and does no harm otherwise. */
 	outw(0x0001, ioaddr + 4);
 
 	/* Set the IRQ line. */
@@ -1239,51 +1315,67 @@ el3_up(struct net_device *dev)
 	for (i = 0; i < 6; i++)
 		outb(dev->dev_addr[i], ioaddr + i);
 
-	if ((dev->if_port & 0x03) == 3) /* BNC interface */
-		/* Start the thinnet transceiver. We should really wait 50ms...*/
-		outw(StartCoax, ioaddr + EL3_CMD);
-	else if ((dev->if_port & 0x03) == 0) { /* 10baseT interface */
-		/* Combine secondary sw_info word (the adapter level) and primary
-			sw_info word (duplex setting plus other useless bits) */
+	if ((dev->if_port & 0x03) == 3) {
+		/* BNC interface */
+
+		/* Start the thinnet transceiver. We should really wait
+		 * 50ms...
+		 */
+		outw(START_COAX, ioaddr + EL3_CMD);
+	} else if ((dev->if_port & 0x03) == 0) {
+		/* 10baseT interface */
+
+		/* Combine secondary sw_info word (the adapter level) and
+		 * primary sw_info word (duplex setting plus other useless
+		 * bits).
+		 */
 		EL3WINDOW(0);
 		sw_info = (read_eeprom(ioaddr, 0x14) & 0x400f) |
-			(read_eeprom(ioaddr, 0x0d) & 0xBff0);
+			  (read_eeprom(ioaddr, 0x0d) & 0xBff0);
 
 		EL3WINDOW(4);
 		net_diag = inw(ioaddr + WN4_NETDIAG);
-		net_diag = (net_diag | FD_ENABLE); /* temporarily assume full-duplex will be set */
+		/* Temporarily assume full-duplex will be set. */
+		net_diag = (net_diag | FD_ENABLE);
 		pr_info("%s: ", dev->name);
 		switch (dev->if_port & 0x0c) {
-			case 12:
-				/* force full-duplex mode if 3c5x9b */
-				if (sw_info & 0x000f) {
-					pr_cont("Forcing 3c5x9b full-duplex mode");
-					break;
-				}
-				fallthrough;
-			case 8:
-				/* set full-duplex mode based on eeprom config setting */
-				if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
-					pr_cont("Setting 3c5x9b full-duplex mode (from EEPROM configuration bit)");
-					break;
-				}
-				fallthrough;
-			default:
-				/* xcvr=(0 || 4) OR user has an old 3c5x9 non "B" model */
-				pr_cont("Setting 3c5x9/3c5x9B half-duplex mode");
-				net_diag = (net_diag & ~FD_ENABLE); /* disable full duplex */
+		case 12:
+			/* Force full-duplex mode if 3c5x9b. */
+			if (sw_info & 0x000f) {
+				pr_cont("Forcing 3c5x9b full-duplex mode");
+				break;
+			}
+			fallthrough;
+		case 8:
+			/* Set full-duplex mode based on eeprom config
+			 * setting.
+			 */
+			if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
+				pr_cont("Setting 3c5x9b full-duplex mode (from EEPROM configuration bit)");
+				break;
+			}
+			fallthrough;
+		default:
+			/* xcvr = (0 || 4) OR user has an old 3c5x9 non "B"
+			 * model.
+			 */
+			pr_cont("Setting 3c5x9/3c5x9B half-duplex mode");
+			/* Disable full duplex. */
+			net_diag = (net_diag & ~FD_ENABLE);
 		}
 
 		outw(net_diag, ioaddr + WN4_NETDIAG);
-		pr_cont(" if_port: %d, sw_info: %4.4x\n", dev->if_port, sw_info);
+		pr_cont(" if_port: %d, sw_info: %4.4x\n",
+			dev->if_port, sw_info);
 		if (el3_debug > 3)
-			pr_debug("%s: 3c5x9 net diag word is now: %4.4x.\n", dev->name, net_diag);
+			pr_debug("%s: 3c5x9 net diag word is now: %4.4x.\n",
+				 dev->name, net_diag);
 		/* Enable link beat and jabber check. */
 		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
 	}
 
 	/* Switch to the stats window, and clear all stats by reading. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
+	outw(STATS_DISABLE, ioaddr + EL3_CMD);
 	EL3WINDOW(6);
 	for (i = 0; i < 9; i++)
 		inb(ioaddr + i);
@@ -1294,18 +1386,22 @@ el3_up(struct net_device *dev)
 	EL3WINDOW(1);
 
 	/* Accept b-case and phys addr only. */
-	outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
-	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
+	outw(SET_RX_FILTER | RX_STATION | RX_BROADCAST, ioaddr + EL3_CMD);
+	/* Turn on statistics. */
+	outw(STATS_ENABLE, ioaddr + EL3_CMD);
 
-	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
-	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
+	/* Enable the receiver. */
+	outw(RX_ENABLE, ioaddr + EL3_CMD);
+	/* Enable transmitter. */
+	outw(TX_ENABLE, ioaddr + EL3_CMD);
 	/* Allow status bits to be seen. */
-	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
+	outw(SET_STATUS_ENB | 0xff, ioaddr + EL3_CMD);
 	/* Ack all pending events, and set active indicator mask. */
-	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
-		 ioaddr + EL3_CMD);
-	outw(SetIntrEnb | IntLatch|TxAvailable|TxComplete|RxComplete|StatsFull,
-		 ioaddr + EL3_CMD);
+	outw(ACK_INTR | INT_LATCH | TX_AVAILABLE | RX_EARLY | INT_REQ,
+	     ioaddr + EL3_CMD);
+	outw((SET_INTR_ENB | INT_LATCH | TX_AVAILABLE | TX_COMPLETE |
+	      RX_COMPLETE | STATS_FULL),
+	     ioaddr + EL3_CMD);
 
 	netif_start_queue(dev);
 }
@@ -1313,12 +1409,11 @@ el3_up(struct net_device *dev)
 /* Power Management support functions */
 #ifdef CONFIG_PM
 
-static int
-el3_suspend(struct device *pdev, pm_message_t state)
+static int el3_suspend(struct device *pdev, pm_message_t state)
 {
-	unsigned long flags;
 	struct net_device *dev;
 	struct el3_private *lp;
+	unsigned long flags;
 	int ioaddr;
 
 	dev = dev_get_drvdata(pdev);
@@ -1331,18 +1426,17 @@ el3_suspend(struct device *pdev, pm_mess
 		netif_device_detach(dev);
 
 	el3_down(dev);
-	outw(PowerDown, ioaddr + EL3_CMD);
+	outw(POWER_DOWN, ioaddr + EL3_CMD);
 
 	spin_unlock_irqrestore(&lp->lock, flags);
 	return 0;
 }
 
-static int
-el3_resume(struct device *pdev)
+static int el3_resume(struct device *pdev)
 {
-	unsigned long flags;
 	struct net_device *dev;
 	struct el3_private *lp;
+	unsigned long flags;
 	int ioaddr;
 
 	dev = dev_get_drvdata(pdev);
@@ -1351,7 +1445,7 @@ el3_resume(struct device *pdev)
 
 	spin_lock_irqsave(&lp->lock, flags);
 
-	outw(PowerUp, ioaddr + EL3_CMD);
+	outw(POWER_UP, ioaddr + EL3_CMD);
 	EL3WINDOW(0);
 	el3_up(dev);
 
@@ -1364,7 +1458,7 @@ el3_resume(struct device *pdev)
 
 #endif /* CONFIG_PM */
 
-module_param(debug,int, 0);
+module_param(debug, int, 0);
 module_param_hw_array(irq, int, irq, NULL, 0);
 module_param(max_interrupt_work, int, 0);
 MODULE_PARM_DESC(debug, "debug level (0-6)");
@@ -1393,15 +1487,14 @@ static int __init el3_init_module(void)
 #endif
 	/* Select an open I/O location at 0x1*0 to do ISA contention select. */
 	/* Start with 0x110 to avoid some sound cards.*/
-	for (id_port = 0x110 ; id_port < 0x200; id_port += 0x10) {
+	for (id_port = 0x110; id_port < 0x200; id_port += 0x10) {
 		if (!request_region(id_port, 1, "3c509-control"))
 			continue;
 		outb(0x00, id_port);
 		outb(0xff, id_port);
 		if (inb(id_port) & 0x01)
 			break;
-		else
-			release_region(id_port, 1);
+		release_region(id_port, 1);
 	}
 	if (id_port >= 0x200) {
 		id_port = 0;
@@ -1446,5 +1539,5 @@ static void __exit el3_cleanup_module(vo
 #endif
 }
 
-module_init (el3_init_module);
-module_exit (el3_cleanup_module);
+module_init(el3_init_module);
+module_exit(el3_cleanup_module);

