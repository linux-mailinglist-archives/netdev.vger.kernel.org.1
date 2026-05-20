Return-Path: <netdev+bounces-289894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHlKSqaDWoMzwUAu9opvQ
	(envelope-from <netdev+bounces-289894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:25:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FE58C5FF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0AD30B868B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A253D47DE;
	Wed, 20 May 2026 11:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949033A4F26;
	Wed, 20 May 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275942; cv=none; b=QwdXSsy6PLgM5kKu5nTnyXfNwLR7mVk6h91+2KHvRwk2dj7P3M7xI9pY/PXCSCXiXC2jw6a0UhbbjBaBKdYpeM7U1sLHEa2s7JN6BQlS/ik66m2XL7pFgo5mZFgki5gTMWWHh1t1n6bUIhQMBSCjbFBK14342rwpAp1uTNzmXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275942; c=relaxed/simple;
	bh=j+BkmpgKoGfCPUnzf7gICrLLy0glQLgw4VvtlL2wOF4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VPi75LhWRde3JN4E6armPVjcmUxi3mpa3D8X/U3yRt+Ga11bgXWtIr5kj5uxQ9eX/PWuJhVnbNVgWeB0UHg4Ph40LCPhuKd0HBs0+72i+2pPToR/sGCGJhPmXKFNdxPRaFOCCLcVSjXP0AwcCE8CVSpN/4lC7dQkLVCYH6+3LXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A7B1D92009D; Wed, 20 May 2026 13:18:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9F15B92009B;
	Wed, 20 May 2026 12:18:49 +0100 (BST)
Date: Wed, 20 May 2026 12:18:49 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/5] Revert "drivers: net: 3com: 3c509: Remove this
 driver"
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605201204260.1450@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289894-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[wild-wind.fr.eu.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,farfalle.com:email,commfireservices.com:email,scyld.com:url,scyld.com:email,rainbow-software.org:email,angie.orcam.me.uk:mid,pobox.com:email,orcam.me.uk:email]
X-Rspamd-Queue-Id: CD5FE58C5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 91f3a27ae9f66d81a5906461762c37c8a2bcab06.

Contrary to the assumption stated with the original commit description
this driver is in use and I'm going to maintain it for the foreseeable
future.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/.renames.txt                                      |    1 
 Documentation/networking/device_drivers/ethernet/3com/3c509.rst |  249 +
 Documentation/networking/device_drivers/ethernet/index.rst      |    1 
 arch/powerpc/configs/ppc6xx_defconfig                           |    1 
 drivers/net/ethernet/3com/3c509.c                               | 1448 ++++++++++
 drivers/net/ethernet/3com/Kconfig                               |   14 
 drivers/net/ethernet/3com/Makefile                              |    1 
 7 files changed, 1715 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/3com/3c509.rst
 create mode 100644 drivers/net/ethernet/3com/3c509.c

linux-3c509-revert.diff
Index: linux-3c509/Documentation/.renames.txt
===================================================================
--- linux-3c509.orig/Documentation/.renames.txt
+++ linux-3c509/Documentation/.renames.txt
@@ -786,6 +786,7 @@ networking/altera_tse networking/device_
 networking/bpf_flow_dissector bpf/prog_flow_dissector
 networking/cxacru networking/device_drivers/atm/cxacru
 networking/defza networking/device_drivers/fddi/defza
+networking/device_drivers/3com/3c509 networking/device_drivers/ethernet/3com/3c509
 networking/device_drivers/3com/vortex networking/device_drivers/ethernet/3com/vortex
 networking/device_drivers/amazon/ena networking/device_drivers/ethernet/amazon/ena
 networking/device_drivers/aquantia/atlantic networking/device_drivers/ethernet/aquantia/atlantic
Index: linux-3c509/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
===================================================================
--- /dev/null
+++ linux-3c509/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
@@ -0,0 +1,249 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================================================
+Linux and the 3Com EtherLink III Series Ethercards (driver v1.18c and higher)
+=============================================================================
+
+This file contains the instructions and caveats for v1.18c and higher versions
+of the 3c509 driver. You should not use the driver without reading this file.
+
+release 1.0
+
+28 February 2002
+
+Current maintainer (corrections to):
+  David Ruggiero <jdr@farfalle.com>
+
+Introduction
+============
+
+The following are notes and information on using the 3Com EtherLink III series
+ethercards in Linux. These cards are commonly known by the most widely-used
+card's 3Com model number, 3c509. They are all 10mb/s ISA-bus cards and shouldn't
+be (but sometimes are) confused with the similarly-numbered PCI-bus "3c905"
+(aka "Vortex" or "Boomerang") series.  Kernel support for the 3c509 family is
+provided by the module 3c509.c, which has code to support all of the following
+models:
+
+ - 3c509 (original ISA card)
+ - 3c509B (later revision of the ISA card; supports full-duplex)
+ - 3c589 (PCMCIA)
+ - 3c589B (later revision of the 3c589; supports full-duplex)
+ - 3c579 (EISA)
+
+Large portions of this documentation were heavily borrowed from the guide
+written the original author of the 3c509 driver, Donald Becker. The master
+copy of that document, which contains notes on older versions of the driver,
+currently resides on Scyld web server: http://www.scyld.com/.
+
+
+Special Driver Features
+=======================
+
+Overriding card settings
+
+The driver allows boot- or load-time overriding of the card's detected IOADDR,
+IRQ, and transceiver settings, although this capability shouldn't generally be
+needed except to enable full-duplex mode (see below). An example of the syntax
+for LILO parameters for doing this::
+
+    ether=10,0x310,3,0x3c509,eth0
+
+This configures the first found 3c509 card for IRQ 10, base I/O 0x310, and
+transceiver type 3 (10base2). The flag "0x3c509" must be set to avoid conflicts
+with other card types when overriding the I/O address. When the driver is
+loaded as a module, only the IRQ may be overridden. For example,
+setting two cards to IRQ10 and IRQ11 is done by using the irq module
+option::
+
+   options 3c509 irq=10,11
+
+
+Full-duplex mode
+================
+
+The v1.18c driver added support for the 3c509B's full-duplex capabilities.
+In order to enable and successfully use full-duplex mode, three conditions
+must be met:
+
+(a) You must have a Etherlink III card model whose hardware supports full-
+duplex operations. Currently, the only members of the 3c509 family that are
+positively known to support full-duplex are the 3c509B (ISA bus) and 3c589B
+(PCMCIA) cards. Cards without the "B" model designation do *not* support
+full-duplex mode; these include the original 3c509 (no "B"), the original
+3c589, the 3c529 (MCA bus), and the 3c579 (EISA bus).
+
+(b) You must be using your card's 10baseT transceiver (i.e., the RJ-45
+connector), not its AUI (thick-net) or 10base2 (thin-net/coax) interfaces.
+AUI and 10base2 network cabling is physically incapable of full-duplex
+operation.
+
+(c) Most importantly, your 3c509B must be connected to a link partner that is
+itself full-duplex capable. This is almost certainly one of two things: a full-
+duplex-capable  Ethernet switch (*not* a hub), or a full-duplex-capable NIC on
+another system that's connected directly to the 3c509B via a crossover cable.
+
+Full-duplex mode can be enabled using 'ethtool'.
+
+.. warning::
+
+  Extremely important caution concerning full-duplex mode
+
+  Understand that the 3c509B's hardware's full-duplex support is much more
+  limited than that provide by more modern network interface cards. Although
+  at the physical layer of the network it fully supports full-duplex operation,
+  the card was designed before the current Ethernet auto-negotiation (N-way)
+  spec was written. This means that the 3c509B family ***cannot and will not
+  auto-negotiate a full-duplex connection with its link partner under any
+  circumstances, no matter how it is initialized***. If the full-duplex mode
+  of the 3c509B is enabled, its link partner will very likely need to be
+  independently _forced_ into full-duplex mode as well; otherwise various nasty
+  failures will occur - at the very least, you'll see massive numbers of packet
+  collisions. This is one of very rare circumstances where disabling auto-
+  negotiation and forcing the duplex mode of a network interface card or switch
+  would ever be necessary or desirable.
+
+
+Available Transceiver Types
+===========================
+
+For versions of the driver v1.18c and above, the available transceiver types are:
+
+== =========================================================================
+0  transceiver type from EEPROM config (normally 10baseT); force half-duplex
+1  AUI (thick-net / DB15 connector)
+2  (undefined)
+3  10base2 (thin-net == coax / BNC connector)
+4  10baseT (RJ-45 connector); force half-duplex mode
+8  transceiver type and duplex mode taken from card's EEPROM config settings
+12 10baseT (RJ-45 connector); force full-duplex mode
+== =========================================================================
+
+Prior to driver version 1.18c, only transceiver codes 0-4 were supported. Note
+that the new transceiver codes 8 and 12 are the *only* ones that will enable
+full-duplex mode, no matter what the card's detected EEPROM settings might be.
+This insured that merely upgrading the driver from an earlier version would
+never automatically enable full-duplex mode in an existing installation;
+it must always be explicitly enabled via one of these code in order to be
+activated.
+
+The transceiver type can be changed using 'ethtool'.
+
+
+Interpretation of error messages and common problems
+----------------------------------------------------
+
+Error Messages
+^^^^^^^^^^^^^^
+
+eth0: Infinite loop in interrupt, status 2011.
+These are "mostly harmless" message indicating that the driver had too much
+work during that interrupt cycle. With a status of 0x2011 you are receiving
+packets faster than they can be removed from the card. This should be rare
+or impossible in normal operation. Possible causes of this error report are:
+
+   - a "green" mode enabled that slows the processor down when there is no
+     keyboard activity.
+
+   - some other device or device driver hogging the bus or disabling interrupts.
+     Check /proc/interrupts for excessive interrupt counts. The timer tick
+     interrupt should always be incrementing faster than the others.
+
+No received packets
+^^^^^^^^^^^^^^^^^^^
+
+If a 3c509, 3c562 or 3c589 can successfully transmit packets, but never
+receives packets (as reported by /proc/net/dev or 'ifconfig') you likely
+have an interrupt line problem. Check /proc/interrupts to verify that the
+card is actually generating interrupts. If the interrupt count is not
+increasing you likely have a physical conflict with two devices trying to
+use the same ISA IRQ line. The common conflict is with a sound card on IRQ10
+or IRQ5, and the easiest solution is to move the 3c509 to a different
+interrupt line. If the device is receiving packets but 'ping' doesn't work,
+you have a routing problem.
+
+Tx Carrier Errors Reported in /proc/net/dev
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+
+If an EtherLink III appears to transmit packets, but the "Tx carrier errors"
+field in /proc/net/dev increments as quickly as the Tx packet count, you
+likely have an unterminated network or the incorrect media transceiver selected.
+
+3c509B card is not detected on machines with an ISA PnP BIOS.
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+While the updated driver works with most PnP BIOS programs, it does not work
+with all. This can be fixed by disabling PnP support using the 3Com-supplied
+setup program.
+
+3c509 card is not detected on overclocked machines
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Increase the delay time in id_read_eeprom() from the current value, 500,
+to an absurdly high value, such as 5000.
+
+
+Decoding Status and Error Messages
+----------------------------------
+
+
+The bits in the main status register are:
+
+=====	======================================
+value 	description
+=====	======================================
+0x01 	Interrupt latch
+0x02 	Tx overrun, or Rx underrun
+0x04 	Tx complete
+0x08 	Tx FIFO room available
+0x10 	A complete Rx packet has arrived
+0x20 	A Rx packet has started to arrive
+0x40 	The driver has requested an interrupt
+0x80 	Statistics counter nearly full
+=====	======================================
+
+The bits in the transmit (Tx) status word are:
+
+=====	============================================
+value	description
+=====	============================================
+0x02	Out-of-window collision.
+0x04	Status stack overflow (normally impossible).
+0x08	16 collisions.
+0x10	Tx underrun (not enough PCI bus bandwidth).
+0x20	Tx jabber.
+0x40	Tx interrupt requested.
+0x80	Status is valid (this should always be set).
+=====	============================================
+
+
+When a transmit error occurs the driver produces a status message such as::
+
+   eth0: Transmit error, Tx status register 82
+
+The two values typically seen here are:
+
+0x82
+^^^^
+
+Out of window collision. This typically occurs when some other Ethernet
+host is incorrectly set to full duplex on a half duplex network.
+
+0x88
+^^^^
+
+16 collisions. This typically occurs when the network is exceptionally busy
+or when another host doesn't correctly back off after a collision. If this
+error is mixed with 0x82 errors it is the result of a host incorrectly set
+to full duplex (see above).
+
+Both of these errors are the result of network problems that should be
+corrected. They do not represent driver malfunction.
+
+
+Revision history (this file)
+============================
+
+28Feb02 v1.0  DR   New; major portions based on Becker original 3c509 docs
+
Index: linux-3c509/Documentation/networking/device_drivers/ethernet/index.rst
===================================================================
--- linux-3c509.orig/Documentation/networking/device_drivers/ethernet/index.rst
+++ linux-3c509/Documentation/networking/device_drivers/ethernet/index.rst
@@ -10,6 +10,7 @@ Device drivers for Ethernet and Ethernet
 .. toctree::
    :maxdepth: 2
 
+   3com/3c509
    3com/vortex
    amazon/ena
    altera/altera_tse
Index: linux-3c509/arch/powerpc/configs/ppc6xx_defconfig
===================================================================
--- linux-3c509.orig/arch/powerpc/configs/ppc6xx_defconfig
+++ linux-3c509/arch/powerpc/configs/ppc6xx_defconfig
@@ -393,6 +393,7 @@ CONFIG_NETCONSOLE=m
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
+CONFIG_EL3=m
 CONFIG_VORTEX=m
 CONFIG_TYPHOON=m
 CONFIG_ADAPTEC_STARFIRE=m
Index: linux-3c509/drivers/net/ethernet/3com/3c509.c
===================================================================
--- /dev/null
+++ linux-3c509/drivers/net/ethernet/3com/3c509.c
@@ -0,0 +1,1448 @@
+/* 3c509.c: A 3c509 EtherLink3 ethernet driver for linux. */
+/*
+	Written 1993-2000 by Donald Becker.
+
+	Copyright 1994-2000 by Donald Becker.
+	Copyright 1993 United States Government as represented by the
+	Director, National Security Agency.	 This software may be used and
+	distributed according to the terms of the GNU General Public License,
+	incorporated herein by reference.
+
+	This driver is for the 3Com EtherLinkIII series.
+
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
+	Known limitations:
+	Because of the way 3c509 ISA detection works it's difficult to predict
+	a priori which of several ISA-mode cards will be detected first.
+
+	This driver does not use predictive interrupt mode, resulting in higher
+	packet latency but lower overhead.  If interrupts are disabled for an
+	unusually long time it could also result in missed packets, but in
+	practice this rarely happens.
+
+
+	FIXES:
+		Alan Cox:       Removed the 'Unexpected interrupt' bug.
+		Michael Meskes:	Upgraded to Donald Becker's version 1.07.
+		Alan Cox:	Increased the eeprom delay. Regardless of
+				what the docs say some people definitely
+				get problems with lower (but in card spec)
+				delays
+		v1.10 4/21/97 Fixed module code so that multiple cards may be detected,
+				other cleanups.  -djb
+		Andrea Arcangeli:	Upgraded to Donald Becker's version 1.12.
+		Rick Payne:	Fixed SMP race condition
+		v1.13 9/8/97 Made 'max_interrupt_work' an insmod-settable variable -djb
+		v1.14 10/15/97 Avoided waiting..discard message for fast machines -djb
+		v1.15 1/31/98 Faster recovery for Tx errors. -djb
+		v1.16 2/3/98 Different ID port handling to avoid sound cards. -djb
+		v1.18 12Mar2001 Andrew Morton
+			- Avoid bogus detect of 3c590's (Andrzej Krzysztofowicz)
+			- Reviewed against 1.18 from scyld.com
+		v1.18a 17Nov2001 Jeff Garzik <jgarzik@pobox.com>
+			- ethtool support
+		v1.18b 1Mar2002 Zwane Mwaikambo <zwane@commfireservices.com>
+			- Power Management support
+		v1.18c 1Mar2002 David Ruggiero <jdr@farfalle.com>
+			- Full duplex support
+		v1.19  16Oct2002 Zwane Mwaikambo <zwane@linuxpower.ca>
+			- Additional ethtool features
+		v1.19a 28Oct2002 Davud Ruggiero <jdr@farfalle.com>
+			- Increase *read_eeprom udelay to workaround oops with 2 cards.
+		v1.19b 08Nov2002 Marc Zyngier <maz@wild-wind.fr.eu.org>
+			- Introduce driver model for EISA cards.
+		v1.20  04Feb2008 Ondrej Zary <linux@rainbow-software.org>
+			- convert to isa_driver and pnp_driver and some cleanups
+*/
+
+#define DRV_NAME	"3c509"
+
+/* A few values that may be tweaked. */
+
+/* Time in jiffies before concluding the transmitter is hung. */
+#define TX_TIMEOUT  (400*HZ/1000)
+
+#include <linux/module.h>
+#include <linux/isa.h>
+#include <linux/pnp.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/in.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/pm.h>
+#include <linux/skbuff.h>
+#include <linux/delay.h>	/* for udelay() */
+#include <linux/spinlock.h>
+#include <linux/ethtool.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
+#include <linux/bitops.h>
+
+#include <linux/uaccess.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#ifdef EL3_DEBUG
+static int el3_debug = EL3_DEBUG;
+#else
+static int el3_debug = 2;
+#endif
+
+/* Used to do a global count of all the cards in the system.  Must be
+ * a global variable so that the eisa probe routines can increment
+ * it */
+static int el3_cards = 0;
+#define EL3_MAX_CARDS 8
+
+/* To minimize the size of the driver source I only define operating
+   constants if they are used several times.  You'll need the manual
+   anyway if you want to understand driver details. */
+/* Offsets from base I/O address. */
+#define EL3_DATA 0x00
+#define EL3_CMD 0x0e
+#define EL3_STATUS 0x0e
+#define	EEPROM_READ 0x80
+
+#define EL3_IO_EXTENT	16
+
+#define EL3WINDOW(win_num) outw(SelectWindow + (win_num), ioaddr + EL3_CMD)
+
+
+/* The top five bits written to EL3_CMD are a command, the lower
+   11 bits are the parameter, if applicable. */
+enum c509cmd {
+	TotalReset = 0<<11, SelectWindow = 1<<11, StartCoax = 2<<11,
+	RxDisable = 3<<11, RxEnable = 4<<11, RxReset = 5<<11, RxDiscard = 8<<11,
+	TxEnable = 9<<11, TxDisable = 10<<11, TxReset = 11<<11,
+	FakeIntr = 12<<11, AckIntr = 13<<11, SetIntrEnb = 14<<11,
+	SetStatusEnb = 15<<11, SetRxFilter = 16<<11, SetRxThreshold = 17<<11,
+	SetTxThreshold = 18<<11, SetTxStart = 19<<11, StatsEnable = 21<<11,
+	StatsDisable = 22<<11, StopCoax = 23<<11, PowerUp = 27<<11,
+	PowerDown = 28<<11, PowerAuto = 29<<11};
+
+enum c509status {
+	IntLatch = 0x0001, AdapterFailure = 0x0002, TxComplete = 0x0004,
+	TxAvailable = 0x0008, RxComplete = 0x0010, RxEarly = 0x0020,
+	IntReq = 0x0040, StatsFull = 0x0080, CmdBusy = 0x1000, };
+
+/* The SetRxFilter command accepts the following classes: */
+enum RxFilter {
+	RxStation = 1, RxMulticast = 2, RxBroadcast = 4, RxProm = 8 };
+
+/* Register window 1 offsets, the window used in normal operation. */
+#define TX_FIFO		0x00
+#define RX_FIFO		0x00
+#define RX_STATUS 	0x08
+#define TX_STATUS 	0x0B
+#define TX_FREE		0x0C		/* Remaining free bytes in Tx buffer. */
+
+#define WN0_CONF_CTRL	0x04		/* Window 0: Configuration control register */
+#define WN0_ADDR_CONF	0x06		/* Window 0: Address configuration register */
+#define WN0_IRQ		0x08		/* Window 0: Set IRQ line in bits 12-15. */
+#define WN4_MEDIA	0x0A		/* Window 4: Various transcvr/media bits. */
+#define	MEDIA_TP	0x00C0		/* Enable link beat and jabber for 10baseT. */
+#define WN4_NETDIAG	0x06		/* Window 4: Net diagnostic */
+#define FD_ENABLE	0x8000		/* Enable full-duplex ("external loopback") */
+
+/*
+ * Must be a power of two (we use a binary and in the
+ * circular queue)
+ */
+#define SKB_QUEUE_SIZE	64
+
+enum el3_cardtype { EL3_ISA, EL3_PNP, EL3_EISA };
+
+struct el3_private {
+	spinlock_t lock;
+	/* skb send-queue */
+	int head, size;
+	struct sk_buff *queue[SKB_QUEUE_SIZE];
+	enum el3_cardtype type;
+};
+static int id_port;
+static int current_tag;
+static struct net_device *el3_devs[EL3_MAX_CARDS];
+
+/* Parameters that may be passed into the module. */
+static int debug = -1;
+static int irq[] = {-1, -1, -1, -1, -1, -1, -1, -1};
+/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
+static int max_interrupt_work = 10;
+#ifdef CONFIG_PNP
+static int nopnp;
+#endif
+
+static int el3_common_init(struct net_device *dev);
+static void el3_common_remove(struct net_device *dev);
+static ushort id_read_eeprom(int index);
+static ushort read_eeprom(int ioaddr, int index);
+static int el3_open(struct net_device *dev);
+static netdev_tx_t el3_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static irqreturn_t el3_interrupt(int irq, void *dev_id);
+static void update_stats(struct net_device *dev);
+static struct net_device_stats *el3_get_stats(struct net_device *dev);
+static int el3_rx(struct net_device *dev);
+static int el3_close(struct net_device *dev);
+static void set_multicast_list(struct net_device *dev);
+static void el3_tx_timeout (struct net_device *dev, unsigned int txqueue);
+static void el3_down(struct net_device *dev);
+static void el3_up(struct net_device *dev);
+static const struct ethtool_ops ethtool_ops;
+#ifdef CONFIG_PM
+static int el3_suspend(struct device *, pm_message_t);
+static int el3_resume(struct device *);
+#else
+#define el3_suspend NULL
+#define el3_resume NULL
+#endif
+
+
+/* generic device remove for all device types */
+static int el3_device_remove (struct device *device);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void el3_poll_controller(struct net_device *dev);
+#endif
+
+/* Return 0 on success, 1 on error, 2 when found already detected PnP card */
+static int el3_isa_id_sequence(__be16 *phys_addr)
+{
+	short lrs_state = 0xff;
+	int i;
+
+	/* ISA boards are detected by sending the ID sequence to the
+	   ID_PORT.  We find cards past the first by setting the 'current_tag'
+	   on cards as they are found.  Cards with their tag set will not
+	   respond to subsequent ID sequences. */
+
+	outb(0x00, id_port);
+	outb(0x00, id_port);
+	for (i = 0; i < 255; i++) {
+		outb(lrs_state, id_port);
+		lrs_state <<= 1;
+		lrs_state = lrs_state & 0x100 ? lrs_state ^ 0xcf : lrs_state;
+	}
+	/* For the first probe, clear all board's tag registers. */
+	if (current_tag == 0)
+		outb(0xd0, id_port);
+	else			/* Otherwise kill off already-found boards. */
+		outb(0xd8, id_port);
+	if (id_read_eeprom(7) != 0x6d50)
+		return 1;
+	/* Read in EEPROM data, which does contention-select.
+	   Only the lowest address board will stay "on-line".
+	   3Com got the byte order backwards. */
+	for (i = 0; i < 3; i++)
+		phys_addr[i] = htons(id_read_eeprom(i));
+#ifdef CONFIG_PNP
+	if (!nopnp) {
+		/* The ISA PnP 3c509 cards respond to the ID sequence too.
+		   This check is needed in order not to register them twice. */
+		for (i = 0; i < el3_cards; i++) {
+			struct el3_private *lp = netdev_priv(el3_devs[i]);
+			if (lp->type == EL3_PNP &&
+			    ether_addr_equal((u8 *)phys_addr, el3_devs[i]->dev_addr)) {
+				if (el3_debug > 3)
+					pr_debug("3c509 with address %02x %02x %02x %02x %02x %02x was found by ISAPnP\n",
+						phys_addr[0] & 0xff, phys_addr[0] >> 8,
+						phys_addr[1] & 0xff, phys_addr[1] >> 8,
+						phys_addr[2] & 0xff, phys_addr[2] >> 8);
+				/* Set the adaptor tag so that the next card can be found. */
+				outb(0xd0 + ++current_tag, id_port);
+				return 2;
+			}
+		}
+	}
+#endif /* CONFIG_PNP */
+	return 0;
+
+}
+
+static void el3_dev_fill(struct net_device *dev, __be16 *phys_addr, int ioaddr,
+			 int irq, int if_port, enum el3_cardtype type)
+{
+	struct el3_private *lp = netdev_priv(dev);
+
+	eth_hw_addr_set(dev, (u8 *)phys_addr);
+	dev->base_addr = ioaddr;
+	dev->irq = irq;
+	dev->if_port = if_port;
+	lp->type = type;
+}
+
+static int el3_isa_match(struct device *pdev, unsigned int ndev)
+{
+	struct net_device *dev;
+	int ioaddr, isa_irq, if_port, err;
+	unsigned int iobase;
+	__be16 phys_addr[3];
+
+	while ((err = el3_isa_id_sequence(phys_addr)) == 2)
+		;	/* Skip to next card when PnP card found */
+	if (err == 1)
+		return 0;
+
+	iobase = id_read_eeprom(8);
+	if_port = iobase >> 14;
+	ioaddr = 0x200 + ((iobase & 0x1f) << 4);
+	if (irq[el3_cards] > 1 && irq[el3_cards] < 16)
+		isa_irq = irq[el3_cards];
+	else
+		isa_irq = id_read_eeprom(9) >> 12;
+
+	dev = alloc_etherdev(sizeof(struct el3_private));
+	if (!dev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(dev, pdev);
+
+	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509-isa")) {
+		free_netdev(dev);
+		return 0;
+	}
+
+	/* Set the adaptor tag so that the next card can be found. */
+	outb(0xd0 + ++current_tag, id_port);
+
+	/* Activate the adaptor at the EEPROM location. */
+	outb((ioaddr >> 4) | 0xe0, id_port);
+
+	EL3WINDOW(0);
+	if (inw(ioaddr) != 0x6d50) {
+		free_netdev(dev);
+		return 0;
+	}
+
+	/* Free the interrupt so that some other card can use it. */
+	outw(0x0f00, ioaddr + WN0_IRQ);
+
+	el3_dev_fill(dev, phys_addr, ioaddr, isa_irq, if_port, EL3_ISA);
+	dev_set_drvdata(pdev, dev);
+	if (el3_common_init(dev)) {
+		free_netdev(dev);
+		return 0;
+	}
+
+	el3_devs[el3_cards++] = dev;
+	return 1;
+}
+
+static void el3_isa_remove(struct device *pdev,
+				    unsigned int ndev)
+{
+	el3_device_remove(pdev);
+	dev_set_drvdata(pdev, NULL);
+}
+
+#ifdef CONFIG_PM
+static int el3_isa_suspend(struct device *dev, unsigned int n,
+			   pm_message_t state)
+{
+	current_tag = 0;
+	return el3_suspend(dev, state);
+}
+
+static int el3_isa_resume(struct device *dev, unsigned int n)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	int ioaddr = ndev->base_addr, err;
+	__be16 phys_addr[3];
+
+	while ((err = el3_isa_id_sequence(phys_addr)) == 2)
+		;	/* Skip to next card when PnP card found */
+	if (err == 1)
+		return 0;
+	/* Set the adaptor tag so that the next card can be found. */
+	outb(0xd0 + ++current_tag, id_port);
+	/* Enable the card */
+	outb((ioaddr >> 4) | 0xe0, id_port);
+	EL3WINDOW(0);
+	if (inw(ioaddr) != 0x6d50)
+		return 1;
+	/* Free the interrupt so that some other card can use it. */
+	outw(0x0f00, ioaddr + WN0_IRQ);
+	return el3_resume(dev);
+}
+#endif
+
+static struct isa_driver el3_isa_driver = {
+	.match		= el3_isa_match,
+	.remove		= el3_isa_remove,
+#ifdef CONFIG_PM
+	.suspend	= el3_isa_suspend,
+	.resume		= el3_isa_resume,
+#endif
+	.driver		= {
+		.name	= "3c509"
+	},
+};
+static int isa_registered;
+
+#ifdef CONFIG_PNP
+static const struct pnp_device_id el3_pnp_ids[] = {
+	{ .id = "TCM5090" }, /* 3Com Etherlink III (TP) */
+	{ .id = "TCM5091" }, /* 3Com Etherlink III */
+	{ .id = "TCM5094" }, /* 3Com Etherlink III (combo) */
+	{ .id = "TCM5095" }, /* 3Com Etherlink III (TPO) */
+	{ .id = "TCM5098" }, /* 3Com Etherlink III (TPC) */
+	{ .id = "PNP80f7" }, /* 3Com Etherlink III compatible */
+	{ .id = "PNP80f8" }, /* 3Com Etherlink III compatible */
+	{ .id = "" }
+};
+MODULE_DEVICE_TABLE(pnp, el3_pnp_ids);
+
+static int el3_pnp_probe(struct pnp_dev *pdev, const struct pnp_device_id *id)
+{
+	short i;
+	int ioaddr, irq, if_port;
+	__be16 phys_addr[3];
+	struct net_device *dev = NULL;
+	int err;
+
+	ioaddr = pnp_port_start(pdev, 0);
+	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509-pnp"))
+		return -EBUSY;
+	irq = pnp_irq(pdev, 0);
+	EL3WINDOW(0);
+	for (i = 0; i < 3; i++)
+		phys_addr[i] = htons(read_eeprom(ioaddr, i));
+	if_port = read_eeprom(ioaddr, 8) >> 14;
+	dev = alloc_etherdev(sizeof(struct el3_private));
+	if (!dev) {
+		release_region(ioaddr, EL3_IO_EXTENT);
+		return -ENOMEM;
+	}
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	el3_dev_fill(dev, phys_addr, ioaddr, irq, if_port, EL3_PNP);
+	pnp_set_drvdata(pdev, dev);
+	err = el3_common_init(dev);
+
+	if (err) {
+		pnp_set_drvdata(pdev, NULL);
+		free_netdev(dev);
+		return err;
+	}
+
+	el3_devs[el3_cards++] = dev;
+	return 0;
+}
+
+static void el3_pnp_remove(struct pnp_dev *pdev)
+{
+	el3_common_remove(pnp_get_drvdata(pdev));
+	pnp_set_drvdata(pdev, NULL);
+}
+
+#ifdef CONFIG_PM
+static int el3_pnp_suspend(struct pnp_dev *pdev, pm_message_t state)
+{
+	return el3_suspend(&pdev->dev, state);
+}
+
+static int el3_pnp_resume(struct pnp_dev *pdev)
+{
+	return el3_resume(&pdev->dev);
+}
+#endif
+
+static struct pnp_driver el3_pnp_driver = {
+	.name		= "3c509",
+	.id_table	= el3_pnp_ids,
+	.probe		= el3_pnp_probe,
+	.remove		= el3_pnp_remove,
+#ifdef CONFIG_PM
+	.suspend	= el3_pnp_suspend,
+	.resume		= el3_pnp_resume,
+#endif
+};
+static int pnp_registered;
+#endif /* CONFIG_PNP */
+
+#ifdef CONFIG_EISA
+static const struct eisa_device_id el3_eisa_ids[] = {
+		{ "TCM5090" },
+		{ "TCM5091" },
+		{ "TCM5092" },
+		{ "TCM5093" },
+		{ "TCM5094" },
+		{ "TCM5095" },
+		{ "TCM5098" },
+		{ "" }
+};
+MODULE_DEVICE_TABLE(eisa, el3_eisa_ids);
+
+static int el3_eisa_probe (struct device *device);
+
+static struct eisa_driver el3_eisa_driver = {
+		.id_table = el3_eisa_ids,
+		.driver   = {
+				.name    = "3c579",
+				.probe   = el3_eisa_probe,
+				.remove  = el3_device_remove,
+				.suspend = el3_suspend,
+				.resume  = el3_resume,
+		}
+};
+static int eisa_registered;
+#endif
+
+static const struct net_device_ops netdev_ops = {
+	.ndo_open 		= el3_open,
+	.ndo_stop	 	= el3_close,
+	.ndo_start_xmit 	= el3_start_xmit,
+	.ndo_get_stats 		= el3_get_stats,
+	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_tx_timeout 	= el3_tx_timeout,
+	.ndo_set_mac_address 	= eth_mac_addr,
+	.ndo_validate_addr	= eth_validate_addr,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= el3_poll_controller,
+#endif
+};
+
+static int el3_common_init(struct net_device *dev)
+{
+	struct el3_private *lp = netdev_priv(dev);
+	int err;
+	static const char * const if_names[] = {
+		"10baseT", "AUI", "undefined", "BNC"
+	};
+
+	spin_lock_init(&lp->lock);
+
+	if (dev->mem_start & 0x05) { /* xcvr codes 1/3/4/12 */
+		dev->if_port = (dev->mem_start & 0x0f);
+	} else { /* xcvr codes 0/8 */
+		/* use eeprom value, but save user's full-duplex selection */
+		dev->if_port |= (dev->mem_start & 0x08);
+	}
+
+	/* The EL3-specific entries in the device structure. */
+	dev->netdev_ops = &netdev_ops;
+	dev->watchdog_timeo = TX_TIMEOUT;
+	dev->ethtool_ops = &ethtool_ops;
+
+	err = register_netdev(dev);
+	if (err) {
+		pr_err("Failed to register 3c5x9 at %#3.3lx, IRQ %d.\n",
+			dev->base_addr, dev->irq);
+		release_region(dev->base_addr, EL3_IO_EXTENT);
+		return err;
+	}
+
+	pr_info("%s: 3c5x9 found at %#3.3lx, %s port, address %pM, IRQ %d.\n",
+	       dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)],
+	       dev->dev_addr, dev->irq);
+
+	return 0;
+
+}
+
+static void el3_common_remove (struct net_device *dev)
+{
+	unregister_netdev (dev);
+	release_region(dev->base_addr, EL3_IO_EXTENT);
+	free_netdev (dev);
+}
+
+#ifdef CONFIG_EISA
+static int el3_eisa_probe(struct device *device)
+{
+	short i;
+	int ioaddr, irq, if_port;
+	__be16 phys_addr[3];
+	struct net_device *dev = NULL;
+	struct eisa_device *edev;
+	int err;
+
+	/* Yeepee, The driver framework is calling us ! */
+	edev = to_eisa_device (device);
+	ioaddr = edev->base_addr;
+
+	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c579-eisa"))
+		return -EBUSY;
+
+	/* Change the register set to the configuration window 0. */
+	outw(SelectWindow | 0, ioaddr + 0xC80 + EL3_CMD);
+
+	irq = inw(ioaddr + WN0_IRQ) >> 12;
+	if_port = inw(ioaddr + 6)>>14;
+	for (i = 0; i < 3; i++)
+		phys_addr[i] = htons(read_eeprom(ioaddr, i));
+
+	/* Restore the "Product ID" to the EEPROM read register. */
+	read_eeprom(ioaddr, 3);
+
+	dev = alloc_etherdev(sizeof (struct el3_private));
+	if (dev == NULL) {
+		release_region(ioaddr, EL3_IO_EXTENT);
+		return -ENOMEM;
+	}
+
+	SET_NETDEV_DEV(dev, device);
+
+	el3_dev_fill(dev, phys_addr, ioaddr, irq, if_port, EL3_EISA);
+	eisa_set_drvdata (edev, dev);
+	err = el3_common_init(dev);
+
+	if (err) {
+		eisa_set_drvdata (edev, NULL);
+		free_netdev(dev);
+		return err;
+	}
+
+	el3_devs[el3_cards++] = dev;
+	return 0;
+}
+#endif
+
+/* This remove works for all device types.
+ *
+ * The net dev must be stored in the driver data field */
+static int el3_device_remove(struct device *device)
+{
+	struct net_device *dev;
+
+	dev = dev_get_drvdata(device);
+
+	el3_common_remove (dev);
+	return 0;
+}
+
+/* Read a word from the EEPROM using the regular EEPROM access register.
+   Assume that we are in register window zero.
+ */
+static ushort read_eeprom(int ioaddr, int index)
+{
+	outw(EEPROM_READ + index, ioaddr + 10);
+	/* Pause for at least 162 us. for the read to take place.
+	   Some chips seem to require much longer */
+	mdelay(2);
+	return inw(ioaddr + 12);
+}
+
+/* Read a word from the EEPROM when in the ISA ID probe state. */
+static ushort id_read_eeprom(int index)
+{
+	int bit, word = 0;
+
+	/* Issue read command, and pause for at least 162 us. for it to complete.
+	   Assume extra-fast 16Mhz bus. */
+	outb(EEPROM_READ + index, id_port);
+
+	/* Pause for at least 162 us. for the read to take place. */
+	/* Some chips seem to require much longer */
+	mdelay(4);
+
+	for (bit = 15; bit >= 0; bit--)
+		word = (word << 1) + (inb(id_port) & 0x01);
+
+	if (el3_debug > 3)
+		pr_debug("  3c509 EEPROM word %d %#4.4x.\n", index, word);
+
+	return word;
+}
+
+
+static int
+el3_open(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+	int i;
+
+	outw(TxReset, ioaddr + EL3_CMD);
+	outw(RxReset, ioaddr + EL3_CMD);
+	outw(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
+
+	i = request_irq(dev->irq, el3_interrupt, 0, dev->name, dev);
+	if (i)
+		return i;
+
+	EL3WINDOW(0);
+	if (el3_debug > 3)
+		pr_debug("%s: Opening, IRQ %d	 status@%x %4.4x.\n", dev->name,
+			   dev->irq, ioaddr + EL3_STATUS, inw(ioaddr + EL3_STATUS));
+
+	el3_up(dev);
+
+	if (el3_debug > 3)
+		pr_debug("%s: Opened 3c509  IRQ %d  status %4.4x.\n",
+			   dev->name, dev->irq, inw(ioaddr + EL3_STATUS));
+
+	return 0;
+}
+
+static void
+el3_tx_timeout (struct net_device *dev, unsigned int txqueue)
+{
+	int ioaddr = dev->base_addr;
+
+	/* Transmitter timeout, serious problems. */
+	pr_warn("%s: transmit timed out, Tx_status %2.2x status %4.4x Tx FIFO room %d\n",
+		dev->name, inb(ioaddr + TX_STATUS), inw(ioaddr + EL3_STATUS),
+		inw(ioaddr + TX_FREE));
+	dev->stats.tx_errors++;
+	netif_trans_update(dev); /* prevent tx timeout */
+	/* Issue TX_RESET and TX_START commands. */
+	outw(TxReset, ioaddr + EL3_CMD);
+	outw(TxEnable, ioaddr + EL3_CMD);
+	netif_wake_queue(dev);
+}
+
+
+static netdev_tx_t
+el3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct el3_private *lp = netdev_priv(dev);
+	int ioaddr = dev->base_addr;
+	unsigned long flags;
+
+	netif_stop_queue (dev);
+
+	dev->stats.tx_bytes += skb->len;
+
+	if (el3_debug > 4) {
+		pr_debug("%s: el3_start_xmit(length = %u) called, status %4.4x.\n",
+			   dev->name, skb->len, inw(ioaddr + EL3_STATUS));
+	}
+	/*
+	 *	We lock the driver against other processors. Note
+	 *	we don't need to lock versus the IRQ as we suspended
+	 *	that. This means that we lose the ability to take
+	 *	an RX during a TX upload. That sucks a bit with SMP
+	 *	on an original 3c509 (2K buffer)
+	 *
+	 *	Using disable_irq stops us crapping on other
+	 *	time sensitive devices.
+	 */
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	/* Put out the doubleword header... */
+	outw(skb->len, ioaddr + TX_FIFO);
+	outw(0x00, ioaddr + TX_FIFO);
+	/* ... and the packet rounded to a doubleword. */
+	outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
+
+	if (inw(ioaddr + TX_FREE) > 1536)
+		netif_start_queue(dev);
+	else
+		/* Interrupt us when the FIFO has room for max-sized packet. */
+		outw(SetTxThreshold + 1536, ioaddr + EL3_CMD);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	dev_consume_skb_any (skb);
+
+	/* Clear the Tx status stack. */
+	{
+		short tx_status;
+		int i = 4;
+
+		while (--i > 0	&&	(tx_status = inb(ioaddr + TX_STATUS)) > 0) {
+			if (tx_status & 0x38) dev->stats.tx_aborted_errors++;
+			if (tx_status & 0x30) outw(TxReset, ioaddr + EL3_CMD);
+			if (tx_status & 0x3C) outw(TxEnable, ioaddr + EL3_CMD);
+			outb(0x00, ioaddr + TX_STATUS); /* Pop the status stack. */
+		}
+	}
+	return NETDEV_TX_OK;
+}
+
+/* The EL3 interrupt handler. */
+static irqreturn_t
+el3_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct el3_private *lp;
+	int ioaddr, status;
+	int i = max_interrupt_work;
+
+	lp = netdev_priv(dev);
+	spin_lock(&lp->lock);
+
+	ioaddr = dev->base_addr;
+
+	if (el3_debug > 4) {
+		status = inw(ioaddr + EL3_STATUS);
+		pr_debug("%s: interrupt, status %4.4x.\n", dev->name, status);
+	}
+
+	while ((status = inw(ioaddr + EL3_STATUS)) &
+		   (IntLatch | RxComplete | StatsFull)) {
+
+		if (status & RxComplete)
+			el3_rx(dev);
+
+		if (status & TxAvailable) {
+			if (el3_debug > 5)
+				pr_debug("	TX room bit was handled.\n");
+			/* There's room in the FIFO for a full-sized packet. */
+			outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
+			netif_wake_queue (dev);
+		}
+		if (status & (AdapterFailure | RxEarly | StatsFull | TxComplete)) {
+			/* Handle all uncommon interrupts. */
+			if (status & StatsFull)				/* Empty statistics. */
+				update_stats(dev);
+			if (status & RxEarly) {				/* Rx early is unused. */
+				el3_rx(dev);
+				outw(AckIntr | RxEarly, ioaddr + EL3_CMD);
+			}
+			if (status & TxComplete) {			/* Really Tx error. */
+				short tx_status;
+				int i = 4;
+
+				while (--i>0 && (tx_status = inb(ioaddr + TX_STATUS)) > 0) {
+					if (tx_status & 0x38) dev->stats.tx_aborted_errors++;
+					if (tx_status & 0x30) outw(TxReset, ioaddr + EL3_CMD);
+					if (tx_status & 0x3C) outw(TxEnable, ioaddr + EL3_CMD);
+					outb(0x00, ioaddr + TX_STATUS); /* Pop the status stack. */
+				}
+			}
+			if (status & AdapterFailure) {
+				/* Adapter failure requires Rx reset and reinit. */
+				outw(RxReset, ioaddr + EL3_CMD);
+				/* Set the Rx filter to the current state. */
+				outw(SetRxFilter | RxStation | RxBroadcast
+					 | (dev->flags & IFF_ALLMULTI ? RxMulticast : 0)
+					 | (dev->flags & IFF_PROMISC ? RxProm : 0),
+					 ioaddr + EL3_CMD);
+				outw(RxEnable, ioaddr + EL3_CMD); /* Re-enable the receiver. */
+				outw(AckIntr | AdapterFailure, ioaddr + EL3_CMD);
+			}
+		}
+
+		if (--i < 0) {
+			pr_err("%s: Infinite loop in interrupt, status %4.4x.\n",
+				   dev->name, status);
+			/* Clear all interrupts. */
+			outw(AckIntr | 0xFF, ioaddr + EL3_CMD);
+			break;
+		}
+		/* Acknowledge the IRQ. */
+		outw(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD); /* Ack IRQ */
+	}
+
+	if (el3_debug > 4) {
+		pr_debug("%s: exiting interrupt, status %4.4x.\n", dev->name,
+			   inw(ioaddr + EL3_STATUS));
+	}
+	spin_unlock(&lp->lock);
+	return IRQ_HANDLED;
+}
+
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void el3_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	el3_interrupt(dev->irq, dev);
+	enable_irq(dev->irq);
+}
+#endif
+
+static struct net_device_stats *
+el3_get_stats(struct net_device *dev)
+{
+	struct el3_private *lp = netdev_priv(dev);
+	unsigned long flags;
+
+	/*
+	 *	This is fast enough not to bother with disable IRQ
+	 *	stuff.
+	 */
+
+	spin_lock_irqsave(&lp->lock, flags);
+	update_stats(dev);
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return &dev->stats;
+}
+
+/*  Update statistics.  We change to register window 6, so this should be run
+	single-threaded if the device is active. This is expected to be a rare
+	operation, and it's simpler for the rest of the driver to assume that
+	window 1 is always valid rather than use a special window-state variable.
+	*/
+static void update_stats(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+
+	if (el3_debug > 5)
+		pr_debug("   Updating the statistics.\n");
+	/* Turn off statistics updates while reading. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+	/* Switch to the stats window, and read everything. */
+	EL3WINDOW(6);
+	dev->stats.tx_carrier_errors 	+= inb(ioaddr + 0);
+	dev->stats.tx_heartbeat_errors	+= inb(ioaddr + 1);
+	/* Multiple collisions. */	   inb(ioaddr + 2);
+	dev->stats.collisions		+= inb(ioaddr + 3);
+	dev->stats.tx_window_errors	+= inb(ioaddr + 4);
+	dev->stats.rx_fifo_errors	+= inb(ioaddr + 5);
+	dev->stats.tx_packets		+= inb(ioaddr + 6);
+	/* Rx packets	*/		   inb(ioaddr + 7);
+	/* Tx deferrals */		   inb(ioaddr + 8);
+	inw(ioaddr + 10);	/* Total Rx and Tx octets. */
+	inw(ioaddr + 12);
+
+	/* Back to window 1, and turn statistics back on. */
+	EL3WINDOW(1);
+	outw(StatsEnable, ioaddr + EL3_CMD);
+}
+
+static int
+el3_rx(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+	short rx_status;
+
+	if (el3_debug > 5)
+		pr_debug("   In rx_packet(), status %4.4x, rx_status %4.4x.\n",
+			   inw(ioaddr+EL3_STATUS), inw(ioaddr+RX_STATUS));
+	while ((rx_status = inw(ioaddr + RX_STATUS)) > 0) {
+		if (rx_status & 0x4000) { /* Error, update stats. */
+			short error = rx_status & 0x3800;
+
+			outw(RxDiscard, ioaddr + EL3_CMD);
+			dev->stats.rx_errors++;
+			switch (error) {
+			case 0x0000:		dev->stats.rx_over_errors++; break;
+			case 0x0800:		dev->stats.rx_length_errors++; break;
+			case 0x1000:		dev->stats.rx_frame_errors++; break;
+			case 0x1800:		dev->stats.rx_length_errors++; break;
+			case 0x2000:		dev->stats.rx_frame_errors++; break;
+			case 0x2800:		dev->stats.rx_crc_errors++; break;
+			}
+		} else {
+			short pkt_len = rx_status & 0x7ff;
+			struct sk_buff *skb;
+
+			skb = netdev_alloc_skb(dev, pkt_len + 5);
+			if (el3_debug > 4)
+				pr_debug("Receiving packet size %d status %4.4x.\n",
+					   pkt_len, rx_status);
+			if (skb != NULL) {
+				skb_reserve(skb, 2);     /* Align IP on 16 byte */
+
+				/* 'skb->data' points to the start of sk_buff data area. */
+				insl(ioaddr + RX_FIFO, skb_put(skb,pkt_len),
+					 (pkt_len + 3) >> 2);
+
+				outw(RxDiscard, ioaddr + EL3_CMD); /* Pop top Rx packet. */
+				skb->protocol = eth_type_trans(skb,dev);
+				netif_rx(skb);
+				dev->stats.rx_bytes += pkt_len;
+				dev->stats.rx_packets++;
+				continue;
+			}
+			outw(RxDiscard, ioaddr + EL3_CMD);
+			dev->stats.rx_dropped++;
+			if (el3_debug)
+				pr_debug("%s: Couldn't allocate a sk_buff of size %d.\n",
+					   dev->name, pkt_len);
+		}
+		inw(ioaddr + EL3_STATUS); 				/* Delay. */
+		while (inw(ioaddr + EL3_STATUS) & 0x1000)
+			pr_debug("	Waiting for 3c509 to discard packet, status %x.\n",
+				   inw(ioaddr + EL3_STATUS) );
+	}
+
+	return 0;
+}
+
+/*
+ *     Set or clear the multicast filter for this adaptor.
+ */
+static void
+set_multicast_list(struct net_device *dev)
+{
+	unsigned long flags;
+	struct el3_private *lp = netdev_priv(dev);
+	int ioaddr = dev->base_addr;
+	int mc_count = netdev_mc_count(dev);
+
+	if (el3_debug > 1) {
+		static int old;
+		if (old != mc_count) {
+			old = mc_count;
+			pr_debug("%s: Setting Rx mode to %d addresses.\n",
+				 dev->name, mc_count);
+		}
+	}
+	spin_lock_irqsave(&lp->lock, flags);
+	if (dev->flags&IFF_PROMISC) {
+		outw(SetRxFilter | RxStation | RxMulticast | RxBroadcast | RxProm,
+			 ioaddr + EL3_CMD);
+	}
+	else if (mc_count || (dev->flags&IFF_ALLMULTI)) {
+		outw(SetRxFilter | RxStation | RxMulticast | RxBroadcast, ioaddr + EL3_CMD);
+	}
+	else
+		outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
+	spin_unlock_irqrestore(&lp->lock, flags);
+}
+
+static int
+el3_close(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+	struct el3_private *lp = netdev_priv(dev);
+
+	if (el3_debug > 2)
+		pr_debug("%s: Shutting down ethercard.\n", dev->name);
+
+	el3_down(dev);
+
+	free_irq(dev->irq, dev);
+	/* Switching back to window 0 disables the IRQ. */
+	EL3WINDOW(0);
+	if (lp->type != EL3_EISA) {
+		/* But we explicitly zero the IRQ line select anyway. Don't do
+		 * it on EISA cards, it prevents the module from getting an
+		 * IRQ after unload+reload... */
+		outw(0x0f00, ioaddr + WN0_IRQ);
+	}
+
+	return 0;
+}
+
+static int
+el3_link_ok(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+	u16 tmp;
+
+	EL3WINDOW(4);
+	tmp = inw(ioaddr + WN4_MEDIA);
+	EL3WINDOW(1);
+	return tmp & (1<<11);
+}
+
+static void
+el3_netdev_get_ecmd(struct net_device *dev, struct ethtool_link_ksettings *cmd)
+{
+	u16 tmp;
+	int ioaddr = dev->base_addr;
+	u32 supported;
+
+	EL3WINDOW(0);
+	/* obtain current transceiver via WN4_MEDIA? */
+	tmp = inw(ioaddr + WN0_ADDR_CONF);
+	switch (tmp >> 14) {
+	case 0:
+		cmd->base.port = PORT_TP;
+		break;
+	case 1:
+		cmd->base.port = PORT_AUI;
+		break;
+	case 3:
+		cmd->base.port = PORT_BNC;
+		break;
+	default:
+		break;
+	}
+
+	cmd->base.duplex = DUPLEX_HALF;
+	supported = 0;
+	tmp = inw(ioaddr + WN0_CONF_CTRL);
+	if (tmp & (1<<13))
+		supported |= SUPPORTED_AUI;
+	if (tmp & (1<<12))
+		supported |= SUPPORTED_BNC;
+	if (tmp & (1<<9)) {
+		supported |= SUPPORTED_TP | SUPPORTED_10baseT_Half |
+				SUPPORTED_10baseT_Full;	/* hmm... */
+		EL3WINDOW(4);
+		tmp = inw(ioaddr + WN4_NETDIAG);
+		if (tmp & FD_ENABLE)
+			cmd->base.duplex = DUPLEX_FULL;
+	}
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	cmd->base.speed = SPEED_10;
+	EL3WINDOW(1);
+}
+
+static int
+el3_netdev_set_ecmd(struct net_device *dev,
+		    const struct ethtool_link_ksettings *cmd)
+{
+	u16 tmp;
+	int ioaddr = dev->base_addr;
+
+	if (cmd->base.speed != SPEED_10)
+		return -EINVAL;
+	if ((cmd->base.duplex != DUPLEX_HALF) &&
+	    (cmd->base.duplex != DUPLEX_FULL))
+		return -EINVAL;
+
+	/* change XCVR type */
+	EL3WINDOW(0);
+	tmp = inw(ioaddr + WN0_ADDR_CONF);
+	switch (cmd->base.port) {
+	case PORT_TP:
+		tmp &= ~(3<<14);
+		dev->if_port = 0;
+		break;
+	case PORT_AUI:
+		tmp |= (1<<14);
+		dev->if_port = 1;
+		break;
+	case PORT_BNC:
+		tmp |= (3<<14);
+		dev->if_port = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	outw(tmp, ioaddr + WN0_ADDR_CONF);
+	if (dev->if_port == 3) {
+		/* fire up the DC-DC convertor if BNC gets enabled */
+		tmp = inw(ioaddr + WN0_ADDR_CONF);
+		if (tmp & (3 << 14)) {
+			outw(StartCoax, ioaddr + EL3_CMD);
+			udelay(800);
+		} else
+			return -EIO;
+	}
+
+	EL3WINDOW(4);
+	tmp = inw(ioaddr + WN4_NETDIAG);
+	if (cmd->base.duplex == DUPLEX_FULL)
+		tmp |= FD_ENABLE;
+	else
+		tmp &= ~FD_ENABLE;
+	outw(tmp, ioaddr + WN4_NETDIAG);
+	EL3WINDOW(1);
+
+	return 0;
+}
+
+static void el3_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+}
+
+static int el3_get_link_ksettings(struct net_device *dev,
+				  struct ethtool_link_ksettings *cmd)
+{
+	struct el3_private *lp = netdev_priv(dev);
+
+	spin_lock_irq(&lp->lock);
+	el3_netdev_get_ecmd(dev, cmd);
+	spin_unlock_irq(&lp->lock);
+	return 0;
+}
+
+static int el3_set_link_ksettings(struct net_device *dev,
+				  const struct ethtool_link_ksettings *cmd)
+{
+	struct el3_private *lp = netdev_priv(dev);
+	int ret;
+
+	spin_lock_irq(&lp->lock);
+	ret = el3_netdev_set_ecmd(dev, cmd);
+	spin_unlock_irq(&lp->lock);
+	return ret;
+}
+
+static u32 el3_get_link(struct net_device *dev)
+{
+	struct el3_private *lp = netdev_priv(dev);
+	u32 ret;
+
+	spin_lock_irq(&lp->lock);
+	ret = el3_link_ok(dev);
+	spin_unlock_irq(&lp->lock);
+	return ret;
+}
+
+static u32 el3_get_msglevel(struct net_device *dev)
+{
+	return el3_debug;
+}
+
+static void el3_set_msglevel(struct net_device *dev, u32 v)
+{
+	el3_debug = v;
+}
+
+static const struct ethtool_ops ethtool_ops = {
+	.get_drvinfo = el3_get_drvinfo,
+	.get_link = el3_get_link,
+	.get_msglevel = el3_get_msglevel,
+	.set_msglevel = el3_set_msglevel,
+	.get_link_ksettings = el3_get_link_ksettings,
+	.set_link_ksettings = el3_set_link_ksettings,
+};
+
+static void
+el3_down(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+
+	netif_stop_queue(dev);
+
+	/* Turn off statistics ASAP.  We update lp->stats below. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+
+	/* Disable the receiver and transmitter. */
+	outw(RxDisable, ioaddr + EL3_CMD);
+	outw(TxDisable, ioaddr + EL3_CMD);
+
+	if (dev->if_port == 3)
+		/* Turn off thinnet power.  Green! */
+		outw(StopCoax, ioaddr + EL3_CMD);
+	else if (dev->if_port == 0) {
+		/* Disable link beat and jabber, if_port may change here next open(). */
+		EL3WINDOW(4);
+		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
+	}
+
+	outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
+
+	update_stats(dev);
+}
+
+static void
+el3_up(struct net_device *dev)
+{
+	int i, sw_info, net_diag;
+	int ioaddr = dev->base_addr;
+
+	/* Activating the board required and does no harm otherwise */
+	outw(0x0001, ioaddr + 4);
+
+	/* Set the IRQ line. */
+	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
+
+	/* Set the station address in window 2 each time opened. */
+	EL3WINDOW(2);
+
+	for (i = 0; i < 6; i++)
+		outb(dev->dev_addr[i], ioaddr + i);
+
+	if ((dev->if_port & 0x03) == 3) /* BNC interface */
+		/* Start the thinnet transceiver. We should really wait 50ms...*/
+		outw(StartCoax, ioaddr + EL3_CMD);
+	else if ((dev->if_port & 0x03) == 0) { /* 10baseT interface */
+		/* Combine secondary sw_info word (the adapter level) and primary
+			sw_info word (duplex setting plus other useless bits) */
+		EL3WINDOW(0);
+		sw_info = (read_eeprom(ioaddr, 0x14) & 0x400f) |
+			(read_eeprom(ioaddr, 0x0d) & 0xBff0);
+
+		EL3WINDOW(4);
+		net_diag = inw(ioaddr + WN4_NETDIAG);
+		net_diag = (net_diag | FD_ENABLE); /* temporarily assume full-duplex will be set */
+		pr_info("%s: ", dev->name);
+		switch (dev->if_port & 0x0c) {
+			case 12:
+				/* force full-duplex mode if 3c5x9b */
+				if (sw_info & 0x000f) {
+					pr_cont("Forcing 3c5x9b full-duplex mode");
+					break;
+				}
+				fallthrough;
+			case 8:
+				/* set full-duplex mode based on eeprom config setting */
+				if ((sw_info & 0x000f) && (sw_info & 0x8000)) {
+					pr_cont("Setting 3c5x9b full-duplex mode (from EEPROM configuration bit)");
+					break;
+				}
+				fallthrough;
+			default:
+				/* xcvr=(0 || 4) OR user has an old 3c5x9 non "B" model */
+				pr_cont("Setting 3c5x9/3c5x9B half-duplex mode");
+				net_diag = (net_diag & ~FD_ENABLE); /* disable full duplex */
+		}
+
+		outw(net_diag, ioaddr + WN4_NETDIAG);
+		pr_cont(" if_port: %d, sw_info: %4.4x\n", dev->if_port, sw_info);
+		if (el3_debug > 3)
+			pr_debug("%s: 3c5x9 net diag word is now: %4.4x.\n", dev->name, net_diag);
+		/* Enable link beat and jabber check. */
+		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
+	}
+
+	/* Switch to the stats window, and clear all stats by reading. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+	EL3WINDOW(6);
+	for (i = 0; i < 9; i++)
+		inb(ioaddr + i);
+	inw(ioaddr + 10);
+	inw(ioaddr + 12);
+
+	/* Switch to register set 1 for normal use. */
+	EL3WINDOW(1);
+
+	/* Accept b-case and phys addr only. */
+	outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
+	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
+
+	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
+	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
+	/* Allow status bits to be seen. */
+	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
+	/* Ack all pending events, and set active indicator mask. */
+	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
+		 ioaddr + EL3_CMD);
+	outw(SetIntrEnb | IntLatch|TxAvailable|TxComplete|RxComplete|StatsFull,
+		 ioaddr + EL3_CMD);
+
+	netif_start_queue(dev);
+}
+
+/* Power Management support functions */
+#ifdef CONFIG_PM
+
+static int
+el3_suspend(struct device *pdev, pm_message_t state)
+{
+	unsigned long flags;
+	struct net_device *dev;
+	struct el3_private *lp;
+	int ioaddr;
+
+	dev = dev_get_drvdata(pdev);
+	lp = netdev_priv(dev);
+	ioaddr = dev->base_addr;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	if (netif_running(dev))
+		netif_device_detach(dev);
+
+	el3_down(dev);
+	outw(PowerDown, ioaddr + EL3_CMD);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return 0;
+}
+
+static int
+el3_resume(struct device *pdev)
+{
+	unsigned long flags;
+	struct net_device *dev;
+	struct el3_private *lp;
+	int ioaddr;
+
+	dev = dev_get_drvdata(pdev);
+	lp = netdev_priv(dev);
+	ioaddr = dev->base_addr;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	outw(PowerUp, ioaddr + EL3_CMD);
+	EL3WINDOW(0);
+	el3_up(dev);
+
+	if (netif_running(dev))
+		netif_device_attach(dev);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+module_param(debug,int, 0);
+module_param_hw_array(irq, int, irq, NULL, 0);
+module_param(max_interrupt_work, int, 0);
+MODULE_PARM_DESC(debug, "debug level (0-6)");
+MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
+MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt");
+#ifdef CONFIG_PNP
+module_param(nopnp, int, 0);
+MODULE_PARM_DESC(nopnp, "disable ISA PnP support (0-1)");
+#endif	/* CONFIG_PNP */
+MODULE_DESCRIPTION("3Com Etherlink III (3c509, 3c509B, 3c529, 3c579) ethernet driver");
+MODULE_LICENSE("GPL");
+
+static int __init el3_init_module(void)
+{
+	int ret = 0;
+
+	if (debug >= 0)
+		el3_debug = debug;
+
+#ifdef CONFIG_PNP
+	if (!nopnp) {
+		ret = pnp_register_driver(&el3_pnp_driver);
+		if (!ret)
+			pnp_registered = 1;
+	}
+#endif
+	/* Select an open I/O location at 0x1*0 to do ISA contention select. */
+	/* Start with 0x110 to avoid some sound cards.*/
+	for (id_port = 0x110 ; id_port < 0x200; id_port += 0x10) {
+		if (!request_region(id_port, 1, "3c509-control"))
+			continue;
+		outb(0x00, id_port);
+		outb(0xff, id_port);
+		if (inb(id_port) & 0x01)
+			break;
+		else
+			release_region(id_port, 1);
+	}
+	if (id_port >= 0x200) {
+		id_port = 0;
+		pr_err("No I/O port available for 3c509 activation.\n");
+	} else {
+		ret = isa_register_driver(&el3_isa_driver, EL3_MAX_CARDS);
+		if (!ret)
+			isa_registered = 1;
+	}
+#ifdef CONFIG_EISA
+	ret = eisa_driver_register(&el3_eisa_driver);
+	if (!ret)
+		eisa_registered = 1;
+#endif
+
+#ifdef CONFIG_PNP
+	if (pnp_registered)
+		ret = 0;
+#endif
+	if (isa_registered)
+		ret = 0;
+#ifdef CONFIG_EISA
+	if (eisa_registered)
+		ret = 0;
+#endif
+	return ret;
+}
+
+static void __exit el3_cleanup_module(void)
+{
+#ifdef CONFIG_PNP
+	if (pnp_registered)
+		pnp_unregister_driver(&el3_pnp_driver);
+#endif
+	if (isa_registered)
+		isa_unregister_driver(&el3_isa_driver);
+	if (id_port)
+		release_region(id_port, 1);
+#ifdef CONFIG_EISA
+	if (eisa_registered)
+		eisa_driver_unregister(&el3_eisa_driver);
+#endif
+}
+
+module_init (el3_init_module);
+module_exit (el3_cleanup_module);
Index: linux-3c509/drivers/net/ethernet/3com/Kconfig
===================================================================
--- linux-3c509.orig/drivers/net/ethernet/3com/Kconfig
+++ linux-3c509/drivers/net/ethernet/3com/Kconfig
@@ -17,6 +17,20 @@ config NET_VENDOR_3COM
 
 if NET_VENDOR_3COM
 
+config EL3
+	tristate "3c509/3c579 \"EtherLink III\" support"
+	depends on (ISA || EISA)
+	help
+	  If you have a network (Ethernet) card belonging to the 3Com
+	  EtherLinkIII series, say Y here.
+
+	  If your card is not working you may need to use the DOS
+	  setup disk to disable Plug & Play mode, and to select the default
+	  media type.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called 3c509.
+
 config VORTEX
 	tristate "3c590/3c900 series (592/595/597) \"Vortex/Boomerang\" support"
 	depends on (PCI || EISA) && HAS_IOPORT_MAP
Index: linux-3c509/drivers/net/ethernet/3com/Makefile
===================================================================
--- linux-3c509.orig/drivers/net/ethernet/3com/Makefile
+++ linux-3c509/drivers/net/ethernet/3com/Makefile
@@ -3,5 +3,6 @@
 # Makefile for the 3Com Ethernet device drivers
 #
 
+obj-$(CONFIG_EL3) += 3c509.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_TYPHOON) += typhoon.o

