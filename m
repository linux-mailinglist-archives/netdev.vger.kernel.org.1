Return-Path: <netdev+bounces-280224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK5BDLfR52k4BAIAu9opvQ
	(envelope-from <netdev+bounces-280224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA543F023
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2FA307D231
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FD3DCDBD;
	Tue, 21 Apr 2026 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OJDX1Fq7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936373233ED;
	Tue, 21 Apr 2026 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799899; cv=none; b=NcbFRvZ2cR9qadE/Fl7f1Z9RpuyAzlRbybJoidWz+plEl+ekhn2z+Xw9/wn6qua/tfXvYsbJ5SLosIcmpyl0QaJP+GA+9gLMT3NnoD5F6qa5HlH5vfrSXjOCq/vrKlYO5XeMpW0Xb+8Rj/FPEq5EUytZofa6Af9BUjQ4b5M+oMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799899; c=relaxed/simple;
	bh=hJkKR8T4Ja4ogSrxHXxI6VqOE+ELVVW0A5hz0S0B+Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAGsEggL9GtHat3iVbMtUKZ69l1NBMNz7yvLCXglDbJ76Oth4zQ5RGHBBRR6zZWjaG272/H8rk3By7szCad41g70ErlsDcXbJeLHEzl1DfSy0lG2sHvWgjwzCkyibtPSbKngn9ORzhIPUsbaOEjWxMACrazUco2h4OohKSYW+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OJDX1Fq7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tUayKS3mLOTKQTpTDfP8IG9gYrhahBM/lCBtLPKhmjA=; b=OJ
	DX1Fq7WkKyIZkjhZPwPcJgKStDk4uQ//IP4yfI+rB+IrXXfZesw0AonPmeMsF5niMTJAhqMVi8aCR
	fqG5gQ2PsT25ysYjydLvUmjBOEiRU6CrL2RBvf0neTGtYMHgY3A/5y7Ar9gHRy6DsJR2vvx6V8w/E
	up9sQj6S6wKb2JA=;
Received: from c-66-41-74-139.hsd1.mn.comcast.net ([66.41.74.139] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFGoe-00GwVc-HL; Tue, 21 Apr 2026 21:31:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 21 Apr 2026 14:31:06 -0500
Subject: [PATCH net 03/18] drivers: net: 3com: 3c574: Remove this driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-v7-0-0-net-next-driver-removal-v1-v1-3-69517c689d1f@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=38013; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=hJkKR8T4Ja4ogSrxHXxI6VqOE+ELVVW0A5hz0S0B+Bg=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBp59CBWAZS/qhrlVhUVJ5HmryGyPivnXN4MIxl0
 z8LlyXg/T2JAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaefQgQAKCRDmvw3LpmlM
 hBj4EADJTUB6LO1RLG2mBKGVDIYQUs6v+ZKYSno66XxMCTcV86B6sqO73oWVVTMgq4k2bMTSvdY
 3jEPzutLcbg5+ghFPa4T/WJ0cc/xIR4VEDQZwlVciyUtY9WQVqxryaPk0s9fcI2ip7ksVMy3bxE
 rJ9CHSzF0O2S0p+qVq6ataydim99Vus70VwVSkllBkJ45AIMIu8tc+5nqTqirnyMx1xqjygaH2Z
 KTfd5DkeaqJTUE1VklCBG9L+N6su2U7cpuPUWBRVqZ7V8kpuDeaExwq+gUqkSxsY/6+IUDvVBad
 8Ma7qydAx/+H+HBMW6LutgysWNe+l+H3Rpbov8bQP2LXf6k+vk4cUgTrWTc+xifuhIYYm0TyJYb
 h89JEX/2U90OyL1BEkvNMqbQf0sZG3168A8FL/PQTrROIzTfaNY22nv0SaLF9OSif6YhaCi7RbM
 42Q8Ua+wE876zzRv2gfvIx02SgSw05dHyXIfp4Oc0JAjl0VDEvuOEkpv4fz4cmntqzEW+8xLbs+
 v5ApUMiMT4SDm3/Jcncz9nvtbSZu5bee3nt+Hh+tz3FS0ajMTnguun3xAKpbdXdBsX3oAP6tzNX
 V2+5kYvOLmzZLaqSWCJcnnpgUV7IzqDZpTmw15UJ7tA1iPf4/B6VmKmZE//XIpkSuOX3TpypUW9
 kB6sAExNKPMBv3g==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280224-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scyld.com:url,scyld.com:email]
X-Rspamd-Queue-Id: 3FAA543F023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 3c574 was written by Donald Becker between 19973-1998. It is an
PCMCIA device, so unlikely to be used with modern kernels.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/3com/3c574_cs.c | 1164 ----------------------------------
 drivers/net/ethernet/3com/Kconfig    |   10 -
 drivers/net/ethernet/3com/Makefile   |    1 -
 3 files changed, 1175 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c574_cs.c b/drivers/net/ethernet/3com/3c574_cs.c
deleted file mode 100644
index 1f2070497a75..000000000000
--- a/drivers/net/ethernet/3com/3c574_cs.c
+++ /dev/null
@@ -1,1164 +0,0 @@
-/* 3c574.c: A PCMCIA ethernet driver for the 3com 3c574 "RoadRunner".
-
-	Written 1993-1998 by
-	Donald Becker, becker@scyld.com, (driver core) and
-	David Hinds, dahinds@users.sourceforge.net (from his PC card code).
-	Locking fixes (C) Copyright 2003 Red Hat Inc
-
-	This software may be used and distributed according to the terms of
-	the GNU General Public License, incorporated herein by reference.
-
-	This driver derives from Donald Becker's 3c509 core, which has the
-	following copyright:
-	Copyright 1993 United States Government as represented by the
-	Director, National Security Agency.
-	
-
-*/
-
-/*
-				Theory of Operation
-
-I. Board Compatibility
-
-This device driver is designed for the 3Com 3c574 PC card Fast Ethernet
-Adapter.
-
-II. Board-specific settings
-
-None -- PC cards are autoconfigured.
-
-III. Driver operation
-
-The 3c574 uses a Boomerang-style interface, without the bus-master capability.
-See the Boomerang driver and documentation for most details.
-
-IV. Notes and chip documentation.
-
-Two added registers are used to enhance PIO performance, RunnerRdCtrl and
-RunnerWrCtrl.  These are 11 bit down-counters that are preloaded with the
-count of word (16 bits) reads or writes the driver is about to do to the Rx
-or Tx FIFO.  The chip is then able to hide the internal-PCI-bus to PC-card
-translation latency by buffering the I/O operations with an 8 word FIFO.
-Note: No other chip accesses are permitted when this buffer is used.
-
-A second enhancement is that both attribute and common memory space
-0x0800-0x0fff can translated to the PIO FIFO.  Thus memory operations (faster
-with *some* PCcard bridges) may be used instead of I/O operations.
-This is enabled by setting the 0x10 bit in the PCMCIA LAN COR.
-
-Some slow PC card bridges work better if they never see a WAIT signal.
-This is configured by setting the 0x20 bit in the PCMCIA LAN COR.
-Only do this after testing that it is reliable and improves performance.
-
-The upper five bits of RunnerRdCtrl are used to window into PCcard
-configuration space registers.  Window 0 is the regular Boomerang/Odie
-register set, 1-5 are various PC card control registers, and 16-31 are
-the (reversed!) CIS table.
-
-A final note: writing the InternalConfig register in window 3 with an
-invalid ramWidth is Very Bad.
-
-V. References
-
-http://www.scyld.com/expert/NWay.html
-http://www.national.com/opf/DP/DP83840A.html
-
-Thanks to Terry Murphy of 3Com for providing development information for
-earlier 3Com products.
-
-*/
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/in.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/if_arp.h>
-#include <linux/ioport.h>
-#include <linux/bitops.h>
-#include <linux/mii.h>
-
-#include <pcmcia/cistpl.h>
-#include <pcmcia/cisreg.h>
-#include <pcmcia/ciscode.h>
-#include <pcmcia/ds.h>
-
-#include <linux/uaccess.h>
-#include <asm/io.h>
-
-/*====================================================================*/
-
-/* Module parameters */
-
-MODULE_AUTHOR("David Hinds <dahinds@users.sourceforge.net>");
-MODULE_DESCRIPTION("3Com 3c574 series PCMCIA ethernet driver");
-MODULE_LICENSE("GPL");
-
-#define INT_MODULE_PARM(n, v) static int n = v; module_param(n, int, 0)
-
-/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-INT_MODULE_PARM(max_interrupt_work, 32);
-
-/* Force full duplex modes? */
-INT_MODULE_PARM(full_duplex, 0);
-
-/* Autodetect link polarity reversal? */
-INT_MODULE_PARM(auto_polarity, 1);
-
-
-/*====================================================================*/
-
-/* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT  ((800*HZ)/1000)
-
-/* To minimize the size of the driver source and make the driver more
-   readable not all constants are symbolically defined.
-   You'll need the manual if you want to understand driver details anyway. */
-/* Offsets from base I/O address. */
-#define EL3_DATA	0x00
-#define EL3_CMD		0x0e
-#define EL3_STATUS	0x0e
-
-#define EL3WINDOW(win_num) outw(SelectWindow + (win_num), ioaddr + EL3_CMD)
-
-/* The top five bits written to EL3_CMD are a command, the lower
-   11 bits are the parameter, if applicable. */
-enum el3_cmds {
-	TotalReset = 0<<11, SelectWindow = 1<<11, StartCoax = 2<<11,
-	RxDisable = 3<<11, RxEnable = 4<<11, RxReset = 5<<11, RxDiscard = 8<<11,
-	TxEnable = 9<<11, TxDisable = 10<<11, TxReset = 11<<11,
-	FakeIntr = 12<<11, AckIntr = 13<<11, SetIntrEnb = 14<<11,
-	SetStatusEnb = 15<<11, SetRxFilter = 16<<11, SetRxThreshold = 17<<11,
-	SetTxThreshold = 18<<11, SetTxStart = 19<<11, StatsEnable = 21<<11,
-	StatsDisable = 22<<11, StopCoax = 23<<11,
-};
-
-enum elxl_status {
-	IntLatch = 0x0001, AdapterFailure = 0x0002, TxComplete = 0x0004,
-	TxAvailable = 0x0008, RxComplete = 0x0010, RxEarly = 0x0020,
-	IntReq = 0x0040, StatsFull = 0x0080, CmdBusy = 0x1000 };
-
-/* The SetRxFilter command accepts the following classes: */
-enum RxFilter {
-	RxStation = 1, RxMulticast = 2, RxBroadcast = 4, RxProm = 8
-};
-
-enum Window0 {
-	Wn0EepromCmd = 10, Wn0EepromData = 12, /* EEPROM command/address, data. */
-	IntrStatus=0x0E,		/* Valid in all windows. */
-};
-/* These assumes the larger EEPROM. */
-enum Win0_EEPROM_cmds {
-	EEPROM_Read = 0x200, EEPROM_WRITE = 0x100, EEPROM_ERASE = 0x300,
-	EEPROM_EWENB = 0x30,		/* Enable erasing/writing for 10 msec. */
-	EEPROM_EWDIS = 0x00,		/* Disable EWENB before 10 msec timeout. */
-};
-
-/* Register window 1 offsets, the window used in normal operation.
-   On the "Odie" this window is always mapped at offsets 0x10-0x1f.
-   Except for TxFree, which is overlapped by RunnerWrCtrl. */
-enum Window1 {
-	TX_FIFO = 0x10,  RX_FIFO = 0x10,  RxErrors = 0x14,
-	RxStatus = 0x18,  Timer=0x1A, TxStatus = 0x1B,
-	TxFree = 0x0C, /* Remaining free bytes in Tx buffer. */
-	RunnerRdCtrl = 0x16, RunnerWrCtrl = 0x1c,
-};
-
-enum Window3 {			/* Window 3: MAC/config bits. */
-	Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
-};
-enum wn3_config {
-	Ram_size = 7,
-	Ram_width = 8,
-	Ram_speed = 0x30,
-	Rom_size = 0xc0,
-	Ram_split_shift = 16,
-	Ram_split = 3 << Ram_split_shift,
-	Xcvr_shift = 20,
-	Xcvr = 7 << Xcvr_shift,
-	Autoselect = 0x1000000,
-};
-
-enum Window4 {		/* Window 4: Xcvr/media bits. */
-	Wn4_FIFODiag = 4, Wn4_NetDiag = 6, Wn4_PhysicalMgmt=8, Wn4_Media = 10,
-};
-
-#define MEDIA_TP	0x00C0	/* Enable link beat and jabber for 10baseT. */
-
-struct el3_private {
-	struct pcmcia_device	*p_dev;
-	u16 advertising, partner;		/* NWay media advertisement */
-	unsigned char phys;			/* MII device address */
-	unsigned int autoselect:1, default_media:3;	/* Read from the EEPROM/Wn3_Config. */
-	/* for transceiver monitoring */
-	struct timer_list media;
-	unsigned short media_status;
-	unsigned short fast_poll;
-	unsigned long last_irq;
-	spinlock_t window_lock;			/* Guards the Window selection */
-};
-
-/* Set iff a MII transceiver on any interface requires mdio preamble.
-   This only set with the original DP83840 on older 3c905 boards, so the extra
-   code size of a per-interface flag is not worthwhile. */
-static char mii_preamble_required = 0;
-
-/* Index of functions. */
-
-static int tc574_config(struct pcmcia_device *link);
-static void tc574_release(struct pcmcia_device *link);
-
-static void mdio_sync(unsigned int ioaddr, int bits);
-static int mdio_read(unsigned int ioaddr, int phy_id, int location);
-static void mdio_write(unsigned int ioaddr, int phy_id, int location,
-		       int value);
-static unsigned short read_eeprom(unsigned int ioaddr, int index);
-static void tc574_wait_for_completion(struct net_device *dev, int cmd);
-
-static void tc574_reset(struct net_device *dev);
-static void media_check(struct timer_list *t);
-static int el3_open(struct net_device *dev);
-static netdev_tx_t el3_start_xmit(struct sk_buff *skb,
-					struct net_device *dev);
-static irqreturn_t el3_interrupt(int irq, void *dev_id);
-static void update_stats(struct net_device *dev);
-static struct net_device_stats *el3_get_stats(struct net_device *dev);
-static int el3_rx(struct net_device *dev, int worklimit);
-static int el3_close(struct net_device *dev);
-static void el3_tx_timeout(struct net_device *dev, unsigned int txqueue);
-static int el3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-static void set_rx_mode(struct net_device *dev);
-static void set_multicast_list(struct net_device *dev);
-
-static void tc574_detach(struct pcmcia_device *p_dev);
-
-/*
-	tc574_attach() creates an "instance" of the driver, allocating
-	local data structures for one device.  The device is registered
-	with Card Services.
-*/
-static const struct net_device_ops el3_netdev_ops = {
-	.ndo_open 		= el3_open,
-	.ndo_stop 		= el3_close,
-	.ndo_start_xmit		= el3_start_xmit,
-	.ndo_tx_timeout 	= el3_tx_timeout,
-	.ndo_get_stats		= el3_get_stats,
-	.ndo_eth_ioctl		= el3_ioctl,
-	.ndo_set_rx_mode	= set_multicast_list,
-	.ndo_set_mac_address 	= eth_mac_addr,
-	.ndo_validate_addr	= eth_validate_addr,
-};
-
-static int tc574_probe(struct pcmcia_device *link)
-{
-	struct el3_private *lp;
-	struct net_device *dev;
-
-	dev_dbg(&link->dev, "3c574_attach()\n");
-
-	/* Create the PC card device object. */
-	dev = alloc_etherdev(sizeof(struct el3_private));
-	if (!dev)
-		return -ENOMEM;
-	lp = netdev_priv(dev);
-	link->priv = dev;
-	lp->p_dev = link;
-
-	spin_lock_init(&lp->window_lock);
-	link->resource[0]->end = 32;
-	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_16;
-	link->config_flags |= CONF_ENABLE_IRQ;
-	link->config_index = 1;
-
-	dev->netdev_ops = &el3_netdev_ops;
-	dev->watchdog_timeo = TX_TIMEOUT;
-
-	return tc574_config(link);
-}
-
-static void tc574_detach(struct pcmcia_device *link)
-{
-	struct net_device *dev = link->priv;
-
-	dev_dbg(&link->dev, "3c574_detach()\n");
-
-	unregister_netdev(dev);
-
-	tc574_release(link);
-
-	free_netdev(dev);
-} /* tc574_detach */
-
-static const char *ram_split[] = {"5:3", "3:1", "1:1", "3:5"};
-
-static int tc574_config(struct pcmcia_device *link)
-{
-	struct net_device *dev = link->priv;
-	struct el3_private *lp = netdev_priv(dev);
-	int ret, i, j;
-	__be16 addr[ETH_ALEN / 2];
-	unsigned int ioaddr;
-	char *cardname;
-	__u32 config;
-	u8 *buf;
-	size_t len;
-
-	dev_dbg(&link->dev, "3c574_config()\n");
-
-	link->io_lines = 16;
-
-	for (i = j = 0; j < 0x400; j += 0x20) {
-		link->resource[0]->start = j ^ 0x300;
-		i = pcmcia_request_io(link);
-		if (i == 0)
-			break;
-	}
-	if (i != 0)
-		goto failed;
-
-	ret = pcmcia_request_irq(link, el3_interrupt);
-	if (ret)
-		goto failed;
-
-	ret = pcmcia_enable_device(link);
-	if (ret)
-		goto failed;
-
-	dev->irq = link->irq;
-	dev->base_addr = link->resource[0]->start;
-
-	ioaddr = dev->base_addr;
-
-	/* The 3c574 normally uses an EEPROM for configuration info, including
-	   the hardware address.  The future products may include a modem chip
-	   and put the address in the CIS. */
-
-	len = pcmcia_get_tuple(link, 0x88, &buf);
-	if (buf && len >= 6) {
-		for (i = 0; i < 3; i++)
-			addr[i] = htons(le16_to_cpu(buf[i * 2]));
-		kfree(buf);
-	} else {
-		kfree(buf); /* 0 < len < 6 */
-		EL3WINDOW(0);
-		for (i = 0; i < 3; i++)
-			addr[i] = htons(read_eeprom(ioaddr, i + 10));
-		if (addr[0] == htons(0x6060)) {
-			pr_notice("IO port conflict at 0x%03lx-0x%03lx\n",
-				  dev->base_addr, dev->base_addr+15);
-			goto failed;
-		}
-	}
-	eth_hw_addr_set(dev, (u8 *)addr);
-	if (link->prod_id[1])
-		cardname = link->prod_id[1];
-	else
-		cardname = "3Com 3c574";
-
-	{
-		u_char mcr;
-		outw(2<<11, ioaddr + RunnerRdCtrl);
-		mcr = inb(ioaddr + 2);
-		outw(0<<11, ioaddr + RunnerRdCtrl);
-		pr_info("  ASIC rev %d,", mcr>>3);
-		EL3WINDOW(3);
-		config = inl(ioaddr + Wn3_Config);
-		lp->default_media = (config & Xcvr) >> Xcvr_shift;
-		lp->autoselect = config & Autoselect ? 1 : 0;
-	}
-
-	timer_setup(&lp->media, media_check, 0);
-
-	{
-		int phy;
-		
-		/* Roadrunner only: Turn on the MII transceiver */
-		outw(0x8040, ioaddr + Wn3_Options);
-		mdelay(1);
-		outw(0xc040, ioaddr + Wn3_Options);
-		tc574_wait_for_completion(dev, TxReset);
-		tc574_wait_for_completion(dev, RxReset);
-		mdelay(1);
-		outw(0x8040, ioaddr + Wn3_Options);
-		
-		EL3WINDOW(4);
-		for (phy = 1; phy <= 32; phy++) {
-			int mii_status;
-			mdio_sync(ioaddr, 32);
-			mii_status = mdio_read(ioaddr, phy & 0x1f, 1);
-			if (mii_status != 0xffff) {
-				lp->phys = phy & 0x1f;
-				dev_dbg(&link->dev, "  MII transceiver at "
-					"index %d, status %x.\n",
-					  phy, mii_status);
-				if ((mii_status & 0x0040) == 0)
-					mii_preamble_required = 1;
-				break;
-			}
-		}
-		if (phy > 32) {
-			pr_notice("  No MII transceivers found!\n");
-			goto failed;
-		}
-		i = mdio_read(ioaddr, lp->phys, 16) | 0x40;
-		mdio_write(ioaddr, lp->phys, 16, i);
-		lp->advertising = mdio_read(ioaddr, lp->phys, 4);
-		if (full_duplex) {
-			/* Only advertise the FD media types. */
-			lp->advertising &= ~0x02a0;
-			mdio_write(ioaddr, lp->phys, 4, lp->advertising);
-		}
-	}
-
-	SET_NETDEV_DEV(dev, &link->dev);
-
-	if (register_netdev(dev) != 0) {
-		pr_notice("register_netdev() failed\n");
-		goto failed;
-	}
-
-	netdev_info(dev, "%s at io %#3lx, irq %d, hw_addr %pM\n",
-		    cardname, dev->base_addr, dev->irq, dev->dev_addr);
-	netdev_info(dev, " %dK FIFO split %s Rx:Tx, %sMII interface.\n",
-		    8 << (config & Ram_size),
-		    ram_split[(config & Ram_split) >> Ram_split_shift],
-		    config & Autoselect ? "autoselect " : "");
-
-	return 0;
-
-failed:
-	tc574_release(link);
-	return -ENODEV;
-
-} /* tc574_config */
-
-static void tc574_release(struct pcmcia_device *link)
-{
-	pcmcia_disable_device(link);
-}
-
-static int tc574_suspend(struct pcmcia_device *link)
-{
-	struct net_device *dev = link->priv;
-
-	if (link->open)
-		netif_device_detach(dev);
-
-	return 0;
-}
-
-static int tc574_resume(struct pcmcia_device *link)
-{
-	struct net_device *dev = link->priv;
-
-	if (link->open) {
-		tc574_reset(dev);
-		netif_device_attach(dev);
-	}
-
-	return 0;
-}
-
-static void dump_status(struct net_device *dev)
-{
-	unsigned int ioaddr = dev->base_addr;
-	EL3WINDOW(1);
-	netdev_info(dev, "  irq status %04x, rx status %04x, tx status %02x, tx free %04x\n",
-		    inw(ioaddr+EL3_STATUS),
-		    inw(ioaddr+RxStatus), inb(ioaddr+TxStatus),
-		    inw(ioaddr+TxFree));
-	EL3WINDOW(4);
-	netdev_info(dev, "  diagnostics: fifo %04x net %04x ethernet %04x media %04x\n",
-		    inw(ioaddr+0x04), inw(ioaddr+0x06),
-		    inw(ioaddr+0x08), inw(ioaddr+0x0a));
-	EL3WINDOW(1);
-}
-
-/*
-  Use this for commands that may take time to finish
-*/
-static void tc574_wait_for_completion(struct net_device *dev, int cmd)
-{
-	int i = 1500;
-	outw(cmd, dev->base_addr + EL3_CMD);
-	while (--i > 0)
-		if (!(inw(dev->base_addr + EL3_STATUS) & 0x1000)) break;
-	if (i == 0)
-		netdev_notice(dev, "command 0x%04x did not complete!\n", cmd);
-}
-
-/* Read a word from the EEPROM using the regular EEPROM access register.
-   Assume that we are in register window zero.
- */
-static unsigned short read_eeprom(unsigned int ioaddr, int index)
-{
-	int timer;
-	outw(EEPROM_Read + index, ioaddr + Wn0EepromCmd);
-	/* Pause for at least 162 usec for the read to take place. */
-	for (timer = 1620; timer >= 0; timer--) {
-		if ((inw(ioaddr + Wn0EepromCmd) & 0x8000) == 0)
-			break;
-	}
-	return inw(ioaddr + Wn0EepromData);
-}
-
-/* MII transceiver control section.
-   Read and write the MII registers using software-generated serial
-   MDIO protocol.  See the MII specifications or DP83840A data sheet
-   for details.
-   The maxium data clock rate is 2.5 Mhz.  The timing is easily met by the
-   slow PC card interface. */
-
-#define MDIO_SHIFT_CLK	0x01
-#define MDIO_DIR_WRITE	0x04
-#define MDIO_DATA_WRITE0 (0x00 | MDIO_DIR_WRITE)
-#define MDIO_DATA_WRITE1 (0x02 | MDIO_DIR_WRITE)
-#define MDIO_DATA_READ	0x02
-#define MDIO_ENB_IN		0x00
-
-/* Generate the preamble required for initial synchronization and
-   a few older transceivers. */
-static void mdio_sync(unsigned int ioaddr, int bits)
-{
-	unsigned int mdio_addr = ioaddr + Wn4_PhysicalMgmt;
-
-	/* Establish sync by sending at least 32 logic ones. */
-	while (-- bits >= 0) {
-		outw(MDIO_DATA_WRITE1, mdio_addr);
-		outw(MDIO_DATA_WRITE1 | MDIO_SHIFT_CLK, mdio_addr);
-	}
-}
-
-static int mdio_read(unsigned int ioaddr, int phy_id, int location)
-{
-	int i;
-	int read_cmd = (0xf6 << 10) | (phy_id << 5) | location;
-	unsigned int retval = 0;
-	unsigned int mdio_addr = ioaddr + Wn4_PhysicalMgmt;
-
-	if (mii_preamble_required)
-		mdio_sync(ioaddr, 32);
-
-	/* Shift the read command bits out. */
-	for (i = 14; i >= 0; i--) {
-		int dataval = (read_cmd&(1<<i)) ? MDIO_DATA_WRITE1 : MDIO_DATA_WRITE0;
-		outw(dataval, mdio_addr);
-		outw(dataval | MDIO_SHIFT_CLK, mdio_addr);
-	}
-	/* Read the two transition, 16 data, and wire-idle bits. */
-	for (i = 19; i > 0; i--) {
-		outw(MDIO_ENB_IN, mdio_addr);
-		retval = (retval << 1) | ((inw(mdio_addr) & MDIO_DATA_READ) ? 1 : 0);
-		outw(MDIO_ENB_IN | MDIO_SHIFT_CLK, mdio_addr);
-	}
-	return (retval>>1) & 0xffff;
-}
-
-static void mdio_write(unsigned int ioaddr, int phy_id, int location, int value)
-{
-	int write_cmd = 0x50020000 | (phy_id << 23) | (location << 18) | value;
-	unsigned int mdio_addr = ioaddr + Wn4_PhysicalMgmt;
-	int i;
-
-	if (mii_preamble_required)
-		mdio_sync(ioaddr, 32);
-
-	/* Shift the command bits out. */
-	for (i = 31; i >= 0; i--) {
-		int dataval = (write_cmd&(1<<i)) ? MDIO_DATA_WRITE1 : MDIO_DATA_WRITE0;
-		outw(dataval, mdio_addr);
-		outw(dataval | MDIO_SHIFT_CLK, mdio_addr);
-	}
-	/* Leave the interface idle. */
-	for (i = 1; i >= 0; i--) {
-		outw(MDIO_ENB_IN, mdio_addr);
-		outw(MDIO_ENB_IN | MDIO_SHIFT_CLK, mdio_addr);
-	}
-}
-
-/* Reset and restore all of the 3c574 registers. */
-static void tc574_reset(struct net_device *dev)
-{
-	struct el3_private *lp = netdev_priv(dev);
-	int i;
-	unsigned int ioaddr = dev->base_addr;
-	unsigned long flags;
-
-	tc574_wait_for_completion(dev, TotalReset|0x10);
-
-	spin_lock_irqsave(&lp->window_lock, flags);
-	/* Clear any transactions in progress. */
-	outw(0, ioaddr + RunnerWrCtrl);
-	outw(0, ioaddr + RunnerRdCtrl);
-
-	/* Set the station address and mask. */
-	EL3WINDOW(2);
-	for (i = 0; i < 6; i++)
-		outb(dev->dev_addr[i], ioaddr + i);
-	for (; i < 12; i+=2)
-		outw(0, ioaddr + i);
-
-	/* Reset config options */
-	EL3WINDOW(3);
-	outb((dev->mtu > 1500 ? 0x40 : 0), ioaddr + Wn3_MAC_Ctrl);
-	outl((lp->autoselect ? 0x01000000 : 0) | 0x0062001b,
-		 ioaddr + Wn3_Config);
-	/* Roadrunner only: Turn on the MII transceiver. */
-	outw(0x8040, ioaddr + Wn3_Options);
-	mdelay(1);
-	outw(0xc040, ioaddr + Wn3_Options);
-	EL3WINDOW(1);
-	spin_unlock_irqrestore(&lp->window_lock, flags);
-	
-	tc574_wait_for_completion(dev, TxReset);
-	tc574_wait_for_completion(dev, RxReset);
-	mdelay(1);
-	spin_lock_irqsave(&lp->window_lock, flags);
-	EL3WINDOW(3);
-	outw(0x8040, ioaddr + Wn3_Options);
-
-	/* Switch to the stats window, and clear all stats by reading. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
-	EL3WINDOW(6);
-	for (i = 0; i < 10; i++)
-		inb(ioaddr + i);
-	inw(ioaddr + 10);
-	inw(ioaddr + 12);
-	EL3WINDOW(4);
-	inb(ioaddr + 12);
-	inb(ioaddr + 13);
-
-	/* .. enable any extra statistics bits.. */
-	outw(0x0040, ioaddr + Wn4_NetDiag);
-	
-	EL3WINDOW(1);
-	spin_unlock_irqrestore(&lp->window_lock, flags);
-	
-	/* .. re-sync MII and re-fill what NWay is advertising. */
-	mdio_sync(ioaddr, 32);
-	mdio_write(ioaddr, lp->phys, 4, lp->advertising);
-	if (!auto_polarity) {
-		/* works for TDK 78Q2120 series MII's */
-		i = mdio_read(ioaddr, lp->phys, 16) | 0x20;
-		mdio_write(ioaddr, lp->phys, 16, i);
-	}
-
-	spin_lock_irqsave(&lp->window_lock, flags);
-	/* Switch to register set 1 for normal use, just for TxFree. */
-	set_rx_mode(dev);
-	spin_unlock_irqrestore(&lp->window_lock, flags);
-	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
-	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
-	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
-	/* Allow status bits to be seen. */
-	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
-	/* Ack all pending events, and set active indicator mask. */
-	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
-		 ioaddr + EL3_CMD);
-	outw(SetIntrEnb | IntLatch | TxAvailable | RxComplete | StatsFull
-		 | AdapterFailure | RxEarly, ioaddr + EL3_CMD);
-}
-
-static int el3_open(struct net_device *dev)
-{
-	struct el3_private *lp = netdev_priv(dev);
-	struct pcmcia_device *link = lp->p_dev;
-
-	if (!pcmcia_dev_present(link))
-		return -ENODEV;
-	
-	link->open++;
-	netif_start_queue(dev);
-	
-	tc574_reset(dev);
-	lp->media.expires = jiffies + HZ;
-	add_timer(&lp->media);
-	
-	dev_dbg(&link->dev, "%s: opened, status %4.4x.\n",
-		  dev->name, inw(dev->base_addr + EL3_STATUS));
-	
-	return 0;
-}
-
-static void el3_tx_timeout(struct net_device *dev, unsigned int txqueue)
-{
-	unsigned int ioaddr = dev->base_addr;
-	
-	netdev_notice(dev, "Transmit timed out!\n");
-	dump_status(dev);
-	dev->stats.tx_errors++;
-	netif_trans_update(dev); /* prevent tx timeout */
-	/* Issue TX_RESET and TX_START commands. */
-	tc574_wait_for_completion(dev, TxReset);
-	outw(TxEnable, ioaddr + EL3_CMD);
-	netif_wake_queue(dev);
-}
-
-static void pop_tx_status(struct net_device *dev)
-{
-	unsigned int ioaddr = dev->base_addr;
-	int i;
-    
-	/* Clear the Tx status stack. */
-	for (i = 32; i > 0; i--) {
-		u_char tx_status = inb(ioaddr + TxStatus);
-		if (!(tx_status & 0x84))
-			break;
-		/* reset transmitter on jabber error or underrun */
-		if (tx_status & 0x30)
-			tc574_wait_for_completion(dev, TxReset);
-		if (tx_status & 0x38) {
-			pr_debug("%s: transmit error: status 0x%02x\n",
-				  dev->name, tx_status);
-			outw(TxEnable, ioaddr + EL3_CMD);
-			dev->stats.tx_aborted_errors++;
-		}
-		outb(0x00, ioaddr + TxStatus); /* Pop the status stack. */
-	}
-}
-
-static netdev_tx_t el3_start_xmit(struct sk_buff *skb,
-					struct net_device *dev)
-{
-	unsigned int ioaddr = dev->base_addr;
-	struct el3_private *lp = netdev_priv(dev);
-	unsigned long flags;
-
-	pr_debug("%s: el3_start_xmit(length = %ld) called, "
-		  "status %4.4x.\n", dev->name, (long)skb->len,
-		  inw(ioaddr + EL3_STATUS));
-
-	spin_lock_irqsave(&lp->window_lock, flags);
-
-	dev->stats.tx_bytes += skb->len;
-
-	/* Put out the doubleword header... */
-	outw(skb->len, ioaddr + TX_FIFO);
-	outw(0, ioaddr + TX_FIFO);
-	/* ... and the packet rounded to a doubleword. */
-	outsl(ioaddr + TX_FIFO, skb->data, (skb->len+3)>>2);
-
-	/* TxFree appears only in Window 1, not offset 0x1c. */
-	if (inw(ioaddr + TxFree) <= 1536) {
-		netif_stop_queue(dev);
-		/* Interrupt us when the FIFO has room for max-sized packet. 
-		   The threshold is in units of dwords. */
-		outw(SetTxThreshold + (1536>>2), ioaddr + EL3_CMD);
-	}
-
-	pop_tx_status(dev);
-	spin_unlock_irqrestore(&lp->window_lock, flags);
-	dev_kfree_skb(skb);
-	return NETDEV_TX_OK;
-}
-
-/* The EL3 interrupt handler. */
-static irqreturn_t el3_interrupt(int irq, void *dev_id)
-{
-	struct net_device *dev = (struct net_device *) dev_id;
-	struct el3_private *lp = netdev_priv(dev);
-	unsigned int ioaddr;
-	unsigned status;
-	int work_budget = max_interrupt_work;
-	int handled = 0;
-
-	if (!netif_device_present(dev))
-		return IRQ_NONE;
-	ioaddr = dev->base_addr;
-
-	pr_debug("%s: interrupt, status %4.4x.\n",
-		  dev->name, inw(ioaddr + EL3_STATUS));
-
-	spin_lock(&lp->window_lock);
-	
-	while ((status = inw(ioaddr + EL3_STATUS)) &
-		   (IntLatch | RxComplete | RxEarly | StatsFull)) {
-		if (!netif_device_present(dev) ||
-			((status & 0xe000) != 0x2000)) {
-			pr_debug("%s: Interrupt from dead card\n", dev->name);
-			break;
-		}
-
-		handled = 1;
-
-		if (status & RxComplete)
-			work_budget = el3_rx(dev, work_budget);
-
-		if (status & TxAvailable) {
-			pr_debug("  TX room bit was handled.\n");
-			/* There's room in the FIFO for a full-sized packet. */
-			outw(AckIntr | TxAvailable, ioaddr + EL3_CMD);
-			netif_wake_queue(dev);
-		}
-
-		if (status & TxComplete)
-			pop_tx_status(dev);
-
-		if (status & (AdapterFailure | RxEarly | StatsFull)) {
-			/* Handle all uncommon interrupts. */
-			if (status & StatsFull)
-				update_stats(dev);
-			if (status & RxEarly) {
-				work_budget = el3_rx(dev, work_budget);
-				outw(AckIntr | RxEarly, ioaddr + EL3_CMD);
-			}
-			if (status & AdapterFailure) {
-				u16 fifo_diag;
-				EL3WINDOW(4);
-				fifo_diag = inw(ioaddr + Wn4_FIFODiag);
-				EL3WINDOW(1);
-				netdev_notice(dev, "adapter failure, FIFO diagnostic register %04x\n",
-					      fifo_diag);
-				if (fifo_diag & 0x0400) {
-					/* Tx overrun */
-					tc574_wait_for_completion(dev, TxReset);
-					outw(TxEnable, ioaddr + EL3_CMD);
-				}
-				if (fifo_diag & 0x2000) {
-					/* Rx underrun */
-					tc574_wait_for_completion(dev, RxReset);
-					set_rx_mode(dev);
-					outw(RxEnable, ioaddr + EL3_CMD);
-				}
-				outw(AckIntr | AdapterFailure, ioaddr + EL3_CMD);
-			}
-		}
-
-		if (--work_budget < 0) {
-			pr_debug("%s: Too much work in interrupt, "
-				  "status %4.4x.\n", dev->name, status);
-			/* Clear all interrupts */
-			outw(AckIntr | 0xFF, ioaddr + EL3_CMD);
-			break;
-		}
-		/* Acknowledge the IRQ. */
-		outw(AckIntr | IntReq | IntLatch, ioaddr + EL3_CMD);
-	}
-
-	pr_debug("%s: exiting interrupt, status %4.4x.\n",
-		  dev->name, inw(ioaddr + EL3_STATUS));
-		  
-	spin_unlock(&lp->window_lock);
-	return IRQ_RETVAL(handled);
-}
-
-/*
-    This timer serves two purposes: to check for missed interrupts
-	(and as a last resort, poll the NIC for events), and to monitor
-	the MII, reporting changes in cable status.
-*/
-static void media_check(struct timer_list *t)
-{
-	struct el3_private *lp = timer_container_of(lp, t, media);
-	struct net_device *dev = lp->p_dev->priv;
-	unsigned int ioaddr = dev->base_addr;
-	unsigned long flags;
-	unsigned short /* cable, */ media, partner;
-
-	if (!netif_device_present(dev))
-		goto reschedule;
-	
-	/* Check for pending interrupt with expired latency timer: with
-	   this, we can limp along even if the interrupt is blocked */
-	if ((inw(ioaddr + EL3_STATUS) & IntLatch) && (inb(ioaddr + Timer) == 0xff)) {
-		if (!lp->fast_poll)
-			netdev_info(dev, "interrupt(s) dropped!\n");
-
-		local_irq_save(flags);
-		el3_interrupt(dev->irq, dev);
-		local_irq_restore(flags);
-
-		lp->fast_poll = HZ;
-	}
-	if (lp->fast_poll) {
-		lp->fast_poll--;
-		lp->media.expires = jiffies + 2*HZ/100;
-		add_timer(&lp->media);
-		return;
-	}
-
-	spin_lock_irqsave(&lp->window_lock, flags);
-	EL3WINDOW(4);
-	media = mdio_read(ioaddr, lp->phys, 1);
-	partner = mdio_read(ioaddr, lp->phys, 5);
-	EL3WINDOW(1);
-	
-	if (media != lp->media_status) {
-		if ((media ^ lp->media_status) & 0x0004)
-			netdev_info(dev, "%s link beat\n",
-				    (lp->media_status & 0x0004) ? "lost" : "found");
-		if ((media ^ lp->media_status) & 0x0020) {
-			lp->partner = 0;
-			if (lp->media_status & 0x0020) {
-				netdev_info(dev, "autonegotiation restarted\n");
-			} else if (partner) {
-				partner &= lp->advertising;
-				lp->partner = partner;
-				netdev_info(dev, "autonegotiation complete: "
-					    "%dbaseT-%cD selected\n",
-					    (partner & 0x0180) ? 100 : 10,
-					    (partner & 0x0140) ? 'F' : 'H');
-			} else {
-				netdev_info(dev, "link partner did not autonegotiate\n");
-			}
-
-			EL3WINDOW(3);
-			outb((partner & 0x0140 ? 0x20 : 0) |
-				 (dev->mtu > 1500 ? 0x40 : 0), ioaddr + Wn3_MAC_Ctrl);
-			EL3WINDOW(1);
-
-		}
-		if (media & 0x0010)
-			netdev_info(dev, "remote fault detected\n");
-		if (media & 0x0002)
-			netdev_info(dev, "jabber detected\n");
-		lp->media_status = media;
-	}
-	spin_unlock_irqrestore(&lp->window_lock, flags);
-
-reschedule:
-	lp->media.expires = jiffies + HZ;
-	add_timer(&lp->media);
-}
-
-static struct net_device_stats *el3_get_stats(struct net_device *dev)
-{
-	struct el3_private *lp = netdev_priv(dev);
-
-	if (netif_device_present(dev)) {
-		unsigned long flags;
-		spin_lock_irqsave(&lp->window_lock, flags);
-		update_stats(dev);
-		spin_unlock_irqrestore(&lp->window_lock, flags);
-	}
-	return &dev->stats;
-}
-
-/*  Update statistics.
-	Surprisingly this need not be run single-threaded, but it effectively is.
-	The counters clear when read, so the adds must merely be atomic.
- */
-static void update_stats(struct net_device *dev)
-{
-	unsigned int ioaddr = dev->base_addr;
-	u8 up;
-
-	pr_debug("%s: updating the statistics.\n", dev->name);
-
-	if (inw(ioaddr+EL3_STATUS) == 0xffff) /* No card. */
-		return;
-		
-	/* Unlike the 3c509 we need not turn off stats updates while reading. */
-	/* Switch to the stats window, and read everything. */
-	EL3WINDOW(6);
-	dev->stats.tx_carrier_errors 		+= inb(ioaddr + 0);
-	dev->stats.tx_heartbeat_errors		+= inb(ioaddr + 1);
-	/* Multiple collisions. */	   	inb(ioaddr + 2);
-	dev->stats.collisions			+= inb(ioaddr + 3);
-	dev->stats.tx_window_errors		+= inb(ioaddr + 4);
-	dev->stats.rx_fifo_errors		+= inb(ioaddr + 5);
-	dev->stats.tx_packets			+= inb(ioaddr + 6);
-	up		 			 = inb(ioaddr + 9);
-	dev->stats.tx_packets			+= (up&0x30) << 4;
-	/* Rx packets   */			   inb(ioaddr + 7);
-	/* Tx deferrals */			   inb(ioaddr + 8);
-	/* rx */				   inw(ioaddr + 10);
-	/* tx */				   inw(ioaddr + 12);
-
-	EL3WINDOW(4);
-	/* BadSSD */				   inb(ioaddr + 12);
-	up					 = inb(ioaddr + 13);
-
-	EL3WINDOW(1);
-}
-
-static int el3_rx(struct net_device *dev, int worklimit)
-{
-	unsigned int ioaddr = dev->base_addr;
-	short rx_status;
-	
-	pr_debug("%s: in rx_packet(), status %4.4x, rx_status %4.4x.\n",
-		  dev->name, inw(ioaddr+EL3_STATUS), inw(ioaddr+RxStatus));
-	while (!((rx_status = inw(ioaddr + RxStatus)) & 0x8000) &&
-			worklimit > 0) {
-		worklimit--;
-		if (rx_status & 0x4000) { /* Error, update stats. */
-			short error = rx_status & 0x3800;
-			dev->stats.rx_errors++;
-			switch (error) {
-			case 0x0000:	dev->stats.rx_over_errors++; break;
-			case 0x0800:	dev->stats.rx_length_errors++; break;
-			case 0x1000:	dev->stats.rx_frame_errors++; break;
-			case 0x1800:	dev->stats.rx_length_errors++; break;
-			case 0x2000:	dev->stats.rx_frame_errors++; break;
-			case 0x2800:	dev->stats.rx_crc_errors++; break;
-			}
-		} else {
-			short pkt_len = rx_status & 0x7ff;
-			struct sk_buff *skb;
-
-			skb = netdev_alloc_skb(dev, pkt_len + 5);
-
-			pr_debug("  Receiving packet size %d status %4.4x.\n",
-				  pkt_len, rx_status);
-			if (skb != NULL) {
-				skb_reserve(skb, 2);
-				insl(ioaddr+RX_FIFO, skb_put(skb, pkt_len),
-						((pkt_len+3)>>2));
-				skb->protocol = eth_type_trans(skb, dev);
-				netif_rx(skb);
-				dev->stats.rx_packets++;
-				dev->stats.rx_bytes += pkt_len;
-			} else {
-				pr_debug("%s: couldn't allocate a sk_buff of"
-					  " size %d.\n", dev->name, pkt_len);
-				dev->stats.rx_dropped++;
-			}
-		}
-		tc574_wait_for_completion(dev, RxDiscard);
-	}
-
-	return worklimit;
-}
-
-/* Provide ioctl() calls to examine the MII xcvr state. */
-static int el3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct el3_private *lp = netdev_priv(dev);
-	unsigned int ioaddr = dev->base_addr;
-	struct mii_ioctl_data *data = if_mii(rq);
-	int phy = lp->phys & 0x1f;
-
-	pr_debug("%s: In ioct(%-.6s, %#4.4x) %4.4x %4.4x %4.4x %4.4x.\n",
-		  dev->name, rq->ifr_ifrn.ifrn_name, cmd,
-		  data->phy_id, data->reg_num, data->val_in, data->val_out);
-
-	switch(cmd) {
-	case SIOCGMIIPHY:		/* Get the address of the PHY in use. */
-		data->phy_id = phy;
-		fallthrough;
-	case SIOCGMIIREG:		/* Read the specified MII register. */
-		{
-			int saved_window;
-			unsigned long flags;
-
-			spin_lock_irqsave(&lp->window_lock, flags);
-			saved_window = inw(ioaddr + EL3_CMD) >> 13;
-			EL3WINDOW(4);
-			data->val_out = mdio_read(ioaddr, data->phy_id & 0x1f,
-						  data->reg_num & 0x1f);
-			EL3WINDOW(saved_window);
-			spin_unlock_irqrestore(&lp->window_lock, flags);
-			return 0;
-		}
-	case SIOCSMIIREG:		/* Write the specified MII register */
-		{
-			int saved_window;
-                       unsigned long flags;
-
-			spin_lock_irqsave(&lp->window_lock, flags);
-			saved_window = inw(ioaddr + EL3_CMD) >> 13;
-			EL3WINDOW(4);
-			mdio_write(ioaddr, data->phy_id & 0x1f,
-				   data->reg_num & 0x1f, data->val_in);
-			EL3WINDOW(saved_window);
-			spin_unlock_irqrestore(&lp->window_lock, flags);
-			return 0;
-		}
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-/* The Odie chip has a 64 bin multicast filter, but the bit layout is not
-   documented.  Until it is we revert to receiving all multicast frames when
-   any multicast reception is desired.
-   Note: My other drivers emit a log message whenever promiscuous mode is
-   entered to help detect password sniffers.  This is less desirable on
-   typical PC card machines, so we omit the message.
-   */
-
-static void set_rx_mode(struct net_device *dev)
-{
-	unsigned int ioaddr = dev->base_addr;
-
-	if (dev->flags & IFF_PROMISC)
-		outw(SetRxFilter | RxStation | RxMulticast | RxBroadcast | RxProm,
-			 ioaddr + EL3_CMD);
-	else if (!netdev_mc_empty(dev) || (dev->flags & IFF_ALLMULTI))
-		outw(SetRxFilter|RxStation|RxMulticast|RxBroadcast, ioaddr + EL3_CMD);
-	else
-		outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
-}
-
-static void set_multicast_list(struct net_device *dev)
-{
-	struct el3_private *lp = netdev_priv(dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&lp->window_lock, flags);
-	set_rx_mode(dev);
-	spin_unlock_irqrestore(&lp->window_lock, flags);
-}
-
-static int el3_close(struct net_device *dev)
-{
-	unsigned int ioaddr = dev->base_addr;
-	struct el3_private *lp = netdev_priv(dev);
-	struct pcmcia_device *link = lp->p_dev;
-
-	dev_dbg(&link->dev, "%s: shutting down ethercard.\n", dev->name);
-	
-	if (pcmcia_dev_present(link)) {
-		unsigned long flags;
-
-		/* Turn off statistics ASAP.  We update lp->stats below. */
-		outw(StatsDisable, ioaddr + EL3_CMD);
-		
-		/* Disable the receiver and transmitter. */
-		outw(RxDisable, ioaddr + EL3_CMD);
-		outw(TxDisable, ioaddr + EL3_CMD);
-		
-		/* Note: Switching to window 0 may disable the IRQ. */
-		EL3WINDOW(0);
-		spin_lock_irqsave(&lp->window_lock, flags);
-		update_stats(dev);
-		spin_unlock_irqrestore(&lp->window_lock, flags);
-
-		/* force interrupts off */
-		outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
-	}
-
-	link->open--;
-	netif_stop_queue(dev);
-	timer_delete_sync(&lp->media);
-
-	return 0;
-}
-
-static const struct pcmcia_device_id tc574_ids[] = {
-	PCMCIA_DEVICE_MANF_CARD(0x0101, 0x0574),
-	PCMCIA_MFC_DEVICE_CIS_MANF_CARD(0, 0x0101, 0x0556, "cis/3CCFEM556.cis"),
-	PCMCIA_DEVICE_NULL,
-};
-MODULE_DEVICE_TABLE(pcmcia, tc574_ids);
-
-static struct pcmcia_driver tc574_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "3c574_cs",
-	.probe		= tc574_probe,
-	.remove		= tc574_detach,
-	.id_table       = tc574_ids,
-	.suspend	= tc574_suspend,
-	.resume		= tc574_resume,
-};
-module_pcmcia_driver(tc574_driver);
diff --git a/drivers/net/ethernet/3com/Kconfig b/drivers/net/ethernet/3com/Kconfig
index 3fd3202d9776..294403ad7141 100644
--- a/drivers/net/ethernet/3com/Kconfig
+++ b/drivers/net/ethernet/3com/Kconfig
@@ -17,16 +17,6 @@ config NET_VENDOR_3COM
 
 if NET_VENDOR_3COM
 
-config PCMCIA_3C574
-	tristate "3Com 3c574 PCMCIA support"
-	depends on PCMCIA && HAS_IOPORT
-	help
-	  Say Y here if you intend to attach a 3Com 3c574 or compatible PCMCIA
-	  (PC-card) Fast Ethernet card to your computer.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called 3c574_cs.  If unsure, say N.
-
 config PCMCIA_3C589
 	tristate "3Com 3c589 PCMCIA support"
 	depends on PCMCIA && HAS_IOPORT
diff --git a/drivers/net/ethernet/3com/Makefile b/drivers/net/ethernet/3com/Makefile
index babfd93d5d53..45fb9af9b5c7 100644
--- a/drivers/net/ethernet/3com/Makefile
+++ b/drivers/net/ethernet/3com/Makefile
@@ -4,6 +4,5 @@
 #
 
 obj-$(CONFIG_PCMCIA_3C589) += 3c589_cs.o
-obj-$(CONFIG_PCMCIA_3C574) += 3c574_cs.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_TYPHOON) += typhoon.o

-- 
2.53.0


