Return-Path: <netdev+bounces-280234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGDZBcXW52mzBgIAu9opvQ
	(envelope-from <netdev+bounces-280234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:57:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC743F21E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FC7A3047DC2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6A3DCDB2;
	Tue, 21 Apr 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5McdgCw1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7023DCDB5;
	Tue, 21 Apr 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801473; cv=none; b=kSbePN3bCl8bd+lRFvBBkXq45EuBeQWiw9Qu3v8rb+eHep475vCK03s3QtNtP8xgXNcxC1N9XIt4Z+BGyxqIMSRWipFngQmWWmplbze0uC0ofP8K/HNJPrmonC4zmPvf4fDO3oNTePPi+LDgtQ46k+A28D/BRHXGnDUn9b9b+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801473; c=relaxed/simple;
	bh=W1gByLU7axMFlzQs7RTKWTuBeaHMDgQ5lwxUGkNl6HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e28Vo5N8TjFTLZrohrFVXkKSdeqX8QT/TF159WEBDenNARimlOZbv9W5w5tWY6KT+c91GyKlattWu1Q6sMjHhQG7XBX2r99ubBI/q798G55C8URBC/jdtZJrsTBUNKl8Gr+v6ZEItF/+TPPuGJvaxfJSjJMNOwgyUnvPdj/WZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5McdgCw1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Gd0a+9Q2VoHOHPG1E+QCXElTHRR9W0KDTLt9O+vVhTI=; b=5M
	cdgCw1EmrZ8dYVKZIxscB8mLLVjowyTJizh7KitQrBeYzSvnbK3AjUIrdqAyk6F/n/8967qE1ZPrF
	0O8T705/GQ3IJOH3wzMxrygkWdIVt+0jGctbw5VIxcx6MBBTGK5DY6sqqW3m48SOAUr6ZG3frOdCs
	x/++y0LRUNZsUQQ=;
Received: from c-66-41-74-139.hsd1.mn.comcast.net ([66.41.74.139] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFGp1-00GwVc-0X; Tue, 21 Apr 2026 21:31:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 21 Apr 2026 14:31:15 -0500
Subject: [PATCH net 12/18] drivers: net: cirrus: mac89x0: Remove this
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-v7-0-0-net-next-driver-removal-v1-v1-12-69517c689d1f@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=37353; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=W1gByLU7axMFlzQs7RTKWTuBeaHMDgQ5lwxUGkNl6HY=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBp59CCrWRWDeCPtow9iT9kHuJ9PwyUfcJZt73+H
 EW+0LVj2suJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaefQggAKCRDmvw3LpmlM
 hI6nEADcNEHlBlyAzxJo5LnqQ7rRYxwI7CJwTdJ1EgecHN7Z2+Ohbix0Aeg8VmBDMAARtrKbXhP
 Efy8dumX6uWVM2i+tYhqKcBmfHyp+XmXsZc++/6KuTw3+H3rdj8qfD3Y815HZ3Ngi472kCWj0OT
 LvWwliOD35lwNxYx7Bdsm8Qdyow9hLNNAjHhhMGWRPJJm/0gB/sKUp3vvrI7Bd7QnxOJ8ThFQzJ
 umMgxGsTmilWEgCmaio7N0/Nuy0ffieyDFEOx1EtAo/Zw84icc0B8ngAWIo8K/d4nEmVY9OlDei
 VeXcoF6sFp0DhWpKhYVO0UTOoSV/b+72586OzhRa7PaG0HcBP/Lr2nbUuaMuRLjQ71QsLMjGdPz
 PS4EagEyAS9WU/JrsTRdkL4XXW6RcyKV1Nl6qOIpH1HBXc/egGDySsUsMwqyNRLQTg9Gi0C/Ktg
 fXif6ywEyAlUz+bqWcbiYVsNgKfMS59gzG/f+MCxcEMx6O8fZwyzTniHCYQTPKFv/Re0wzY8G75
 bDxzkeWJ4kzQOkKUsPIcf6LLvaLFTGyRsSCKcS3B9XaX23NeCBO//YnCCrOKzvxsPnAi4nljhtb
 yBN7xr0x4mXXpp5j5WlREQYQ2VmMR4/IhbiMq+OYgJLRGzVpGRVSH2Wn7/bQ6bcn3r4Jshzr3e+
 3NWp5FiP1LXbU+g==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280234-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,conectiva.com.br:email,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 7EBC743F21E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mac89x0 was written by Russell Nelson in 1996. It is an MAC
device, so unlikely to be used with modern kernels.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/cirrus/Kconfig   |  10 -
 drivers/net/ethernet/cirrus/Makefile  |   1 -
 drivers/net/ethernet/cirrus/cs89x0.h  | 461 ---------------------------
 drivers/net/ethernet/cirrus/mac89x0.c | 577 ----------------------------------
 4 files changed, 1049 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/Kconfig b/drivers/net/ethernet/cirrus/Kconfig
index 1a0c7b3bfcd6..786d379e79fe 100644
--- a/drivers/net/ethernet/cirrus/Kconfig
+++ b/drivers/net/ethernet/cirrus/Kconfig
@@ -25,14 +25,4 @@ config EP93XX_ETH
 	  This is a driver for the ethernet hardware included in EP93xx CPUs.
 	  Say Y if you are building a kernel for EP93xx based devices.
 
-config MAC89x0
-	tristate "Macintosh CS89x0 based ethernet cards"
-	depends on MAC
-	help
-	  Support for CS89x0 chipset based Ethernet cards.  If you have a
-	  Nubus or LC-PDS network (Ethernet) card of this type, say Y here.
-
-	  To compile this driver as a module, choose M here. This module will
-	  be called mac89x0.
-
 endif # NET_VENDOR_CIRRUS
diff --git a/drivers/net/ethernet/cirrus/Makefile b/drivers/net/ethernet/cirrus/Makefile
index cb740939d976..03800af0f0e1 100644
--- a/drivers/net/ethernet/cirrus/Makefile
+++ b/drivers/net/ethernet/cirrus/Makefile
@@ -4,4 +4,3 @@
 #
 
 obj-$(CONFIG_EP93XX_ETH) += ep93xx_eth.o
-obj-$(CONFIG_MAC89x0) += mac89x0.o
diff --git a/drivers/net/ethernet/cirrus/cs89x0.h b/drivers/net/ethernet/cirrus/cs89x0.h
deleted file mode 100644
index 210f9ec9af4b..000000000000
--- a/drivers/net/ethernet/cirrus/cs89x0.h
+++ /dev/null
@@ -1,461 +0,0 @@
-/*  Copyright, 1988-1992, Russell Nelson, Crynwr Software
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation, version 1.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-   */
-
-
-#define PP_ChipID 0x0000	/* offset   0h -> Corp -ID              */
-				/* offset   2h -> Model/Product Number  */
-				/* offset   3h -> Chip Revision Number  */
-
-#define PP_ISAIOB 0x0020	/*  IO base address */
-#define PP_CS8900_ISAINT 0x0022	/*  ISA interrupt select */
-#define PP_CS8920_ISAINT 0x0370	/*  ISA interrupt select */
-#define PP_CS8900_ISADMA 0x0024	/*  ISA Rec DMA channel */
-#define PP_CS8920_ISADMA 0x0374	/*  ISA Rec DMA channel */
-#define PP_ISASOF 0x0026	/*  ISA DMA offset */
-#define PP_DmaFrameCnt 0x0028	/*  ISA DMA Frame count */
-#define PP_DmaByteCnt 0x002A	/*  ISA DMA Byte count */
-#define PP_CS8900_ISAMemB 0x002C	/*  Memory base */
-#define PP_CS8920_ISAMemB 0x0348 /*  */
-
-#define PP_ISABootBase 0x0030	/*  Boot Prom base  */
-#define PP_ISABootMask 0x0034	/*  Boot Prom Mask */
-
-/* EEPROM data and command registers */
-#define PP_EECMD 0x0040		/*  NVR Interface Command register */
-#define PP_EEData 0x0042	/*  NVR Interface Data Register */
-#define PP_DebugReg 0x0044	/*  Debug Register */
-
-#define PP_RxCFG 0x0102		/*  Rx Bus config */
-#define PP_RxCTL 0x0104		/*  Receive Control Register */
-#define PP_TxCFG 0x0106		/*  Transmit Config Register */
-#define PP_TxCMD 0x0108		/*  Transmit Command Register */
-#define PP_BufCFG 0x010A	/*  Bus configuration Register */
-#define PP_LineCTL 0x0112	/*  Line Config Register */
-#define PP_SelfCTL 0x0114	/*  Self Command Register */
-#define PP_BusCTL 0x0116	/*  ISA bus control Register */
-#define PP_TestCTL 0x0118	/*  Test Register */
-#define PP_AutoNegCTL 0x011C	/*  Auto Negotiation Ctrl */
-
-#define PP_ISQ 0x0120		/*  Interrupt Status */
-#define PP_RxEvent 0x0124	/*  Rx Event Register */
-#define PP_TxEvent 0x0128	/*  Tx Event Register */
-#define PP_BufEvent 0x012C	/*  Bus Event Register */
-#define PP_RxMiss 0x0130	/*  Receive Miss Count */
-#define PP_TxCol 0x0132		/*  Transmit Collision Count */
-#define PP_LineST 0x0134	/*  Line State Register */
-#define PP_SelfST 0x0136	/*  Self State register */
-#define PP_BusST 0x0138		/*  Bus Status */
-#define PP_TDR 0x013C		/*  Time Domain Reflectometry */
-#define PP_AutoNegST 0x013E	/*  Auto Neg Status */
-#define PP_TxCommand 0x0144	/*  Tx Command */
-#define PP_TxLength 0x0146	/*  Tx Length */
-#define PP_LAF 0x0150		/*  Hash Table */
-#define PP_IA 0x0158		/*  Physical Address Register */
-
-#define PP_RxStatus 0x0400	/*  Receive start of frame */
-#define PP_RxLength 0x0402	/*  Receive Length of frame */
-#define PP_RxFrame 0x0404	/*  Receive frame pointer */
-#define PP_TxFrame 0x0A00	/*  Transmit frame pointer */
-
-/*  Primary I/O Base Address. If no I/O base is supplied by the user, then this */
-/*  can be used as the default I/O base to access the PacketPage Area. */
-#define DEFAULTIOBASE 0x0300
-#define FIRST_IO 0x020C		/*  First I/O port to check */
-#define LAST_IO 0x037C		/*  Last I/O port to check (+10h) */
-#define ADD_MASK 0x3000		/*  Mask it use of the ADD_PORT register */
-#define ADD_SIG 0x3000		/*  Expected ID signature */
-
-/* On Macs, we only need use the ISA I/O stuff until we do MEMORY_ON */
-#ifdef CONFIG_MAC
-#define LCSLOTBASE 0xfee00000
-#define MMIOBASE 0x40000
-#endif
-
-#define CHIP_EISA_ID_SIG 0x630E   /*  Product ID Code for Crystal Chip (CS8900 spec 4.3) */
-#define CHIP_EISA_ID_SIG_STR "0x630E"
-
-#ifdef IBMEIPKT
-#define EISA_ID_SIG 0x4D24	/*  IBM */
-#define PART_NO_SIG 0x1010	/*  IBM */
-#define MONGOOSE_BIT 0x0000	/*  IBM */
-#else
-#define EISA_ID_SIG 0x630E	/*  PnP Vendor ID (same as chip id for Crystal board) */
-#define PART_NO_SIG 0x4000	/*  ID code CS8920 board (PnP Vendor Product code) */
-#define MONGOOSE_BIT 0x2000	/*  PART_NO_SIG + MONGOOSE_BUT => ID of mongoose */
-#endif
-
-#define PRODUCT_ID_ADD 0x0002   /*  Address of product ID */
-
-/*  Mask to find out the types of  registers */
-#define REG_TYPE_MASK 0x001F
-
-/*  Eeprom Commands */
-#define ERSE_WR_ENBL 0x00F0
-#define ERSE_WR_DISABLE 0x0000
-
-/*  Defines Control/Config register quintuplet numbers */
-#define RX_BUF_CFG 0x0003
-#define RX_CONTROL 0x0005
-#define TX_CFG 0x0007
-#define TX_COMMAND 0x0009
-#define BUF_CFG 0x000B
-#define LINE_CONTROL 0x0013
-#define SELF_CONTROL 0x0015
-#define BUS_CONTROL 0x0017
-#define TEST_CONTROL 0x0019
-
-/*  Defines Status/Count registers quintuplet numbers */
-#define RX_EVENT 0x0004
-#define TX_EVENT 0x0008
-#define BUF_EVENT 0x000C
-#define RX_MISS_COUNT 0x0010
-#define TX_COL_COUNT 0x0012
-#define LINE_STATUS 0x0014
-#define SELF_STATUS 0x0016
-#define BUS_STATUS 0x0018
-#define TDR 0x001C
-
-/* PP_RxCFG - Receive  Configuration and Interrupt Mask bit definition -  Read/write */
-#define SKIP_1 0x0040
-#define RX_STREAM_ENBL 0x0080
-#define RX_OK_ENBL 0x0100
-#define RX_DMA_ONLY 0x0200
-#define AUTO_RX_DMA 0x0400
-#define BUFFER_CRC 0x0800
-#define RX_CRC_ERROR_ENBL 0x1000
-#define RX_RUNT_ENBL 0x2000
-#define RX_EXTRA_DATA_ENBL 0x4000
-
-/* PP_RxCTL - Receive Control bit definition - Read/write */
-#define RX_IA_HASH_ACCEPT 0x0040
-#define RX_PROM_ACCEPT 0x0080
-#define RX_OK_ACCEPT 0x0100
-#define RX_MULTCAST_ACCEPT 0x0200
-#define RX_IA_ACCEPT 0x0400
-#define RX_BROADCAST_ACCEPT 0x0800
-#define RX_BAD_CRC_ACCEPT 0x1000
-#define RX_RUNT_ACCEPT 0x2000
-#define RX_EXTRA_DATA_ACCEPT 0x4000
-#define RX_ALL_ACCEPT (RX_PROM_ACCEPT|RX_BAD_CRC_ACCEPT|RX_RUNT_ACCEPT|RX_EXTRA_DATA_ACCEPT)
-/*  Default receive mode - individually addressed, broadcast, and error free */
-#define DEF_RX_ACCEPT (RX_IA_ACCEPT | RX_BROADCAST_ACCEPT | RX_OK_ACCEPT)
-
-/* PP_TxCFG - Transmit Configuration Interrupt Mask bit definition - Read/write */
-#define TX_LOST_CRS_ENBL 0x0040
-#define TX_SQE_ERROR_ENBL 0x0080
-#define TX_OK_ENBL 0x0100
-#define TX_LATE_COL_ENBL 0x0200
-#define TX_JBR_ENBL 0x0400
-#define TX_ANY_COL_ENBL 0x0800
-#define TX_16_COL_ENBL 0x8000
-
-/* PP_TxCMD - Transmit Command bit definition - Read-only */
-#define TX_START_4_BYTES 0x0000
-#define TX_START_64_BYTES 0x0040
-#define TX_START_128_BYTES 0x0080
-#define TX_START_ALL_BYTES 0x00C0
-#define TX_FORCE 0x0100
-#define TX_ONE_COL 0x0200
-#define TX_TWO_PART_DEFF_DISABLE 0x0400
-#define TX_NO_CRC 0x1000
-#define TX_RUNT 0x2000
-
-/* PP_BufCFG - Buffer Configuration Interrupt Mask bit definition - Read/write */
-#define GENERATE_SW_INTERRUPT 0x0040
-#define RX_DMA_ENBL 0x0080
-#define READY_FOR_TX_ENBL 0x0100
-#define TX_UNDERRUN_ENBL 0x0200
-#define RX_MISS_ENBL 0x0400
-#define RX_128_BYTE_ENBL 0x0800
-#define TX_COL_COUNT_OVRFLOW_ENBL 0x1000
-#define RX_MISS_COUNT_OVRFLOW_ENBL 0x2000
-#define RX_DEST_MATCH_ENBL 0x8000
-
-/* PP_LineCTL - Line Control bit definition - Read/write */
-#define SERIAL_RX_ON 0x0040
-#define SERIAL_TX_ON 0x0080
-#define AUI_ONLY 0x0100
-#define AUTO_AUI_10BASET 0x0200
-#define MODIFIED_BACKOFF 0x0800
-#define NO_AUTO_POLARITY 0x1000
-#define TWO_PART_DEFDIS 0x2000
-#define LOW_RX_SQUELCH 0x4000
-
-/* PP_SelfCTL - Software Self Control bit definition - Read/write */
-#define POWER_ON_RESET 0x0040
-#define SW_STOP 0x0100
-#define SLEEP_ON 0x0200
-#define AUTO_WAKEUP 0x0400
-#define HCB0_ENBL 0x1000
-#define HCB1_ENBL 0x2000
-#define HCB0 0x4000
-#define HCB1 0x8000
-
-/* PP_BusCTL - ISA Bus Control bit definition - Read/write */
-#define RESET_RX_DMA 0x0040
-#define MEMORY_ON 0x0400
-#define DMA_BURST_MODE 0x0800
-#define IO_CHANNEL_READY_ON 0x1000
-#define RX_DMA_SIZE_64K 0x2000
-#define ENABLE_IRQ 0x8000
-
-/* PP_TestCTL - Test Control bit definition - Read/write */
-#define LINK_OFF 0x0080
-#define ENDEC_LOOPBACK 0x0200
-#define AUI_LOOPBACK 0x0400
-#define BACKOFF_OFF 0x0800
-#define FDX_8900 0x4000
-#define FAST_TEST 0x8000
-
-/* PP_RxEvent - Receive Event Bit definition - Read-only */
-#define RX_IA_HASHED 0x0040
-#define RX_DRIBBLE 0x0080
-#define RX_OK 0x0100
-#define RX_HASHED 0x0200
-#define RX_IA 0x0400
-#define RX_BROADCAST 0x0800
-#define RX_CRC_ERROR 0x1000
-#define RX_RUNT 0x2000
-#define RX_EXTRA_DATA 0x4000
-
-#define HASH_INDEX_MASK 0x0FC00
-
-/* PP_TxEvent - Transmit Event Bit definition - Read-only */
-#define TX_LOST_CRS 0x0040
-#define TX_SQE_ERROR 0x0080
-#define TX_OK 0x0100
-#define TX_LATE_COL 0x0200
-#define TX_JBR 0x0400
-#define TX_16_COL 0x8000
-#define TX_SEND_OK_BITS (TX_OK|TX_LOST_CRS)
-#define TX_COL_COUNT_MASK 0x7800
-
-/* PP_BufEvent - Buffer Event Bit definition - Read-only */
-#define SW_INTERRUPT 0x0040
-#define RX_DMA 0x0080
-#define READY_FOR_TX 0x0100
-#define TX_UNDERRUN 0x0200
-#define RX_MISS 0x0400
-#define RX_128_BYTE 0x0800
-#define TX_COL_OVRFLW 0x1000
-#define RX_MISS_OVRFLW 0x2000
-#define RX_DEST_MATCH 0x8000
-
-/* PP_LineST - Ethernet Line Status bit definition - Read-only */
-#define LINK_OK 0x0080
-#define AUI_ON 0x0100
-#define TENBASET_ON 0x0200
-#define POLARITY_OK 0x1000
-#define CRS_OK 0x4000
-
-/* PP_SelfST - Chip Software Status bit definition */
-#define ACTIVE_33V 0x0040
-#define INIT_DONE 0x0080
-#define SI_BUSY 0x0100
-#define EEPROM_PRESENT 0x0200
-#define EEPROM_OK 0x0400
-#define EL_PRESENT 0x0800
-#define EE_SIZE_64 0x1000
-
-/* PP_BusST - ISA Bus Status bit definition */
-#define TX_BID_ERROR 0x0080
-#define READY_FOR_TX_NOW 0x0100
-
-/* PP_AutoNegCTL - Auto Negotiation Control bit definition */
-#define RE_NEG_NOW 0x0040
-#define ALLOW_FDX 0x0080
-#define AUTO_NEG_ENABLE 0x0100
-#define NLP_ENABLE 0x0200
-#define FORCE_FDX 0x8000
-#define AUTO_NEG_BITS (FORCE_FDX|NLP_ENABLE|AUTO_NEG_ENABLE)
-#define AUTO_NEG_MASK (FORCE_FDX|NLP_ENABLE|AUTO_NEG_ENABLE|ALLOW_FDX|RE_NEG_NOW)
-
-/* PP_AutoNegST - Auto Negotiation Status bit definition */
-#define AUTO_NEG_BUSY 0x0080
-#define FLP_LINK 0x0100
-#define FLP_LINK_GOOD 0x0800
-#define LINK_FAULT 0x1000
-#define HDX_ACTIVE 0x4000
-#define FDX_ACTIVE 0x8000
-
-/*  The following block defines the ISQ event types */
-#define ISQ_RECEIVER_EVENT 0x04
-#define ISQ_TRANSMITTER_EVENT 0x08
-#define ISQ_BUFFER_EVENT 0x0c
-#define ISQ_RX_MISS_EVENT 0x10
-#define ISQ_TX_COL_EVENT 0x12
-
-#define ISQ_EVENT_MASK 0x003F   /*  ISQ mask to find out type of event */
-#define ISQ_HIST 16		/*  small history buffer */
-#define AUTOINCREMENT 0x8000	/*  Bit mask to set bit-15 for autoincrement */
-
-#define TXRXBUFSIZE 0x0600
-#define RXDMABUFSIZE 0x8000
-#define RXDMASIZE 0x4000
-#define TXRX_LENGTH_MASK 0x07FF
-
-/*  rx options bits */
-#define RCV_WITH_RXON	1       /*  Set SerRx ON */
-#define RCV_COUNTS	2       /*  Use Framecnt1 */
-#define RCV_PONG	4       /*  Pong respondent */
-#define RCV_DONG	8       /*  Dong operation */
-#define RCV_POLLING	0x10	/*  Poll RxEvent */
-#define RCV_ISQ		0x20	/*  Use ISQ, int */
-#define RCV_AUTO_DMA	0x100	/*  Set AutoRxDMAE */
-#define RCV_DMA		0x200	/*  Set RxDMA only */
-#define RCV_DMA_ALL	0x400	/*  Copy all DMA'ed */
-#define RCV_FIXED_DATA	0x800	/*  Every frame same */
-#define RCV_IO		0x1000	/*  Use ISA IO only */
-#define RCV_MEMORY	0x2000	/*  Use ISA Memory */
-
-#define RAM_SIZE	0x1000       /*  The card has 4k bytes or RAM */
-#define PKT_START PP_TxFrame  /*  Start of packet RAM */
-
-#define RX_FRAME_PORT	0x0000
-#define TX_FRAME_PORT RX_FRAME_PORT
-#define TX_CMD_PORT	0x0004
-#define TX_NOW		0x0000       /*  Tx packet after   5 bytes copied */
-#define TX_AFTER_381	0x0040       /*  Tx packet after 381 bytes copied */
-#define TX_AFTER_ALL	0x00c0       /*  Tx packet after all bytes copied */
-#define TX_LEN_PORT	0x0006
-#define ISQ_PORT	0x0008
-#define ADD_PORT	0x000A
-#define DATA_PORT	0x000C
-
-#define EEPROM_WRITE_EN		0x00F0
-#define EEPROM_WRITE_DIS	0x0000
-#define EEPROM_WRITE_CMD	0x0100
-#define EEPROM_READ_CMD		0x0200
-
-/*  Receive Header */
-/*  Description of header of each packet in receive area of memory */
-#define RBUF_EVENT_LOW	0   /*  Low byte of RxEvent - status of received frame */
-#define RBUF_EVENT_HIGH	1   /*  High byte of RxEvent - status of received frame */
-#define RBUF_LEN_LOW	2   /*  Length of received data - low byte */
-#define RBUF_LEN_HI	3   /*  Length of received data - high byte */
-#define RBUF_HEAD_LEN	4   /*  Length of this header */
-
-#define CHIP_READ 0x1   /*  Used to mark state of the repins code (chip or dma) */
-#define DMA_READ 0x2   /*  Used to mark state of the repins code (chip or dma) */
-
-/*  for bios scan */
-/*  */
-#ifdef CSDEBUG
-/*  use these values for debugging bios scan */
-#define BIOS_START_SEG 0x00000
-#define BIOS_OFFSET_INC 0x0010
-#else
-#define BIOS_START_SEG 0x0c000
-#define BIOS_OFFSET_INC 0x0200
-#endif
-
-#define BIOS_LAST_OFFSET 0x0fc00
-
-/*  Byte offsets into the EEPROM configuration buffer */
-#define ISA_CNF_OFFSET 0x6
-#define TX_CTL_OFFSET (ISA_CNF_OFFSET + 8)			/*  8900 eeprom */
-#define AUTO_NEG_CNF_OFFSET (ISA_CNF_OFFSET + 8)		/*  8920 eeprom */
-
-  /*  the assumption here is that the bits in the eeprom are generally  */
-  /*  in the same position as those in the autonegctl register. */
-  /*  Of course the IMM bit is not in that register so it must be  */
-  /*  masked out */
-#define EE_FORCE_FDX  0x8000
-#define EE_NLP_ENABLE 0x0200
-#define EE_AUTO_NEG_ENABLE 0x0100
-#define EE_ALLOW_FDX 0x0080
-#define EE_AUTO_NEG_CNF_MASK (EE_FORCE_FDX|EE_NLP_ENABLE|EE_AUTO_NEG_ENABLE|EE_ALLOW_FDX)
-
-#define IMM_BIT 0x0040		/*  ignore missing media	 */
-
-#define ADAPTER_CNF_OFFSET (AUTO_NEG_CNF_OFFSET + 2)
-#define A_CNF_10B_T 0x0001
-#define A_CNF_AUI 0x0002
-#define A_CNF_10B_2 0x0004
-#define A_CNF_MEDIA_TYPE 0x0070
-#define A_CNF_MEDIA_AUTO 0x0070
-#define A_CNF_MEDIA_10B_T 0x0020
-#define A_CNF_MEDIA_AUI 0x0040
-#define A_CNF_MEDIA_10B_2 0x0010
-#define A_CNF_DC_DC_POLARITY 0x0080
-#define A_CNF_NO_AUTO_POLARITY 0x2000
-#define A_CNF_LOW_RX_SQUELCH 0x4000
-#define A_CNF_EXTND_10B_2 0x8000
-
-#define PACKET_PAGE_OFFSET 0x8
-
-/*  Bit definitions for the ISA configuration word from the EEPROM */
-#define INT_NO_MASK 0x000F
-#define DMA_NO_MASK 0x0070
-#define ISA_DMA_SIZE 0x0200
-#define ISA_AUTO_RxDMA 0x0400
-#define ISA_RxDMA 0x0800
-#define DMA_BURST 0x1000
-#define STREAM_TRANSFER 0x2000
-#define ANY_ISA_DMA (ISA_AUTO_RxDMA | ISA_RxDMA)
-
-/*  DMA controller registers */
-#define DMA_BASE 0x00     /*  DMA controller base */
-#define DMA_BASE_2 0x0C0    /*  DMA controller base */
-
-#define DMA_STAT 0x0D0    /*  DMA controller status register */
-#define DMA_MASK 0x0D4    /*  DMA controller mask register */
-#define DMA_MODE 0x0D6    /*  DMA controller mode register */
-#define DMA_RESETFF 0x0D8    /*  DMA controller first/last flip flop */
-
-/*  DMA data */
-#define DMA_DISABLE 0x04     /*  Disable channel n */
-#define DMA_ENABLE 0x00     /*  Enable channel n */
-/*  Demand transfers, incr. address, auto init, writes, ch. n */
-#define DMA_RX_MODE 0x14
-/*  Demand transfers, incr. address, auto init, reads, ch. n */
-#define DMA_TX_MODE 0x18
-
-#define DMA_SIZE (16*1024) /*  Size of dma buffer - 16k */
-
-#define CS8900 0x0000
-#define CS8920 0x4000
-#define CS8920M 0x6000
-#define REVISON_BITS 0x1F00
-#define EEVER_NUMBER 0x12
-#define CHKSUM_LEN 0x14
-#define CHKSUM_VAL 0x0000
-#define START_EEPROM_DATA 0x001c /*  Offset into eeprom for start of data */
-#define IRQ_MAP_EEPROM_DATA 0x0046 /*  Offset into eeprom for the IRQ map */
-#define IRQ_MAP_LEN 0x0004 /*  No of bytes to read for the IRQ map */
-#define PNP_IRQ_FRMT 0x0022 /*  PNP small item IRQ format */
-#define CS8900_IRQ_MAP 0x1c20 /*  This IRQ map is fixed */
-
-#define CS8920_NO_INTS 0x0F   /*  Max CS8920 interrupt select # */
-
-#define PNP_ADD_PORT 0x0279
-#define PNP_WRITE_PORT 0x0A79
-
-#define GET_PNP_ISA_STRUCT 0x40
-#define PNP_ISA_STRUCT_LEN 0x06
-#define PNP_CSN_CNT_OFF 0x01
-#define PNP_RD_PORT_OFF 0x02
-#define PNP_FUNCTION_OK 0x00
-#define PNP_WAKE 0x03
-#define PNP_RSRC_DATA 0x04
-#define PNP_RSRC_READY 0x01
-#define PNP_STATUS 0x05
-#define PNP_ACTIVATE 0x30
-#define PNP_CNF_IO_H 0x60
-#define PNP_CNF_IO_L 0x61
-#define PNP_CNF_INT 0x70
-#define PNP_CNF_DMA 0x74
-#define PNP_CNF_MEM 0x48
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
deleted file mode 100644
index 6723df9b65d9..000000000000
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ /dev/null
@@ -1,577 +0,0 @@
-/* mac89x0.c: A Crystal Semiconductor CS89[02]0 driver for linux. */
-/*
-	Written 1996 by Russell Nelson, with reference to skeleton.c
-	written 1993-1994 by Donald Becker.
-
-	This software may be used and distributed according to the terms
-	of the GNU General Public License, incorporated herein by reference.
-
-	The author may be reached at nelson@crynwr.com, Crynwr
-	Software, 11 Grant St., Potsdam, NY 13676
-
-  Changelog:
-
-  Mike Cruse        : mcruse@cti-ltd.com
-                    : Changes for Linux 2.0 compatibility.
-                    : Added dev_id parameter in net_interrupt(),
-                    : request_irq() and free_irq(). Just NULL for now.
-
-  Mike Cruse        : Added MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT macros
-                    : in net_open() and net_close() so kerneld would know
-                    : that the module is in use and wouldn't eject the
-                    : driver prematurely.
-
-  Mike Cruse        : Rewrote init_module() and cleanup_module using 8390.c
-                    : as an example. Disabled autoprobing in init_module(),
-                    : not a good thing to do to other devices while Linux
-                    : is running from all accounts.
-
-  Alan Cox          : Removed 1.2 support, added 2.1 extra counters.
-
-  David Huggins-Daines <dhd@debian.org>
-
-  Split this off into mac89x0.c, and gutted it of all parts which are
-  not relevant to the existing CS8900 cards on the Macintosh
-  (i.e. basically the Daynaport CS and LC cards).  To be precise:
-
-    * Removed all the media-detection stuff, because these cards are
-    TP-only.
-
-    * Lobotomized the ISA interrupt bogosity, because these cards use
-    a hardwired NuBus interrupt and a magic ISAIRQ value in the card.
-
-    * Basically eliminated everything not relevant to getting the
-    cards minimally functioning on the Macintosh.
-
-  I might add that these cards are badly designed even from the Mac
-  standpoint, in that Dayna, in their infinite wisdom, used NuBus slot
-  I/O space and NuBus interrupts for these cards, but neglected to
-  provide anything even remotely resembling a NuBus ROM.  Therefore we
-  have to probe for them in a brain-damaged ISA-like fashion.
-
-  Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 11/01/2001
-  check kmalloc and release the allocated memory on failure in
-  mac89x0_probe and in init_module
-  use local_irq_{save,restore}(flags) in net_get_stat, not just
-  local_irq_{dis,en}able()
-*/
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-static const char version[] =
-"cs89x0.c:v1.02 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
-
-#include <linux/module.h>
-
-/*
-  Sources:
-
-	Crynwr packet driver epktisa.
-
-	Crystal Semiconductor data sheets.
-
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/in.h>
-#include <linux/string.h>
-#include <linux/nubus.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <linux/platform_device.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-#include <linux/gfp.h>
-
-#include <asm/io.h>
-#include <asm/hwtest.h>
-#include <asm/macints.h>
-
-#include "cs89x0.h"
-
-static int debug = -1;
-module_param(debug, int, 0);
-MODULE_PARM_DESC(debug, "debug message level");
-
-/* Information that need to be kept for each board. */
-struct net_local {
-	int msg_enable;
-	int chip_type;		/* one of: CS8900, CS8920, CS8920M */
-	char chip_revision;	/* revision letter of the chip ('A'...) */
-	int send_cmd;		/* the propercommand used to send a packet. */
-	int rx_mode;
-	int curr_rx_cfg;
-        int send_underrun;      /* keep track of how many underruns in a row we get */
-};
-
-/* Index to functions, as function prototypes. */
-static int net_open(struct net_device *dev);
-static netdev_tx_t net_send_packet(struct sk_buff *skb, struct net_device *dev);
-static irqreturn_t net_interrupt(int irq, void *dev_id);
-static void set_multicast_list(struct net_device *dev);
-static void net_rx(struct net_device *dev);
-static int net_close(struct net_device *dev);
-static struct net_device_stats *net_get_stats(struct net_device *dev);
-static int set_mac_address(struct net_device *dev, void *addr);
-
-/* For reading/writing registers ISA-style */
-static inline int
-readreg_io(struct net_device *dev, int portno)
-{
-	nubus_writew(swab16(portno), dev->base_addr + ADD_PORT);
-	return swab16(nubus_readw(dev->base_addr + DATA_PORT));
-}
-
-static inline void
-writereg_io(struct net_device *dev, int portno, int value)
-{
-	nubus_writew(swab16(portno), dev->base_addr + ADD_PORT);
-	nubus_writew(swab16(value), dev->base_addr + DATA_PORT);
-}
-
-/* These are for reading/writing registers in shared memory */
-static inline int
-readreg(struct net_device *dev, int portno)
-{
-	return swab16(nubus_readw(dev->mem_start + portno));
-}
-
-static inline void
-writereg(struct net_device *dev, int portno, int value)
-{
-	nubus_writew(swab16(value), dev->mem_start + portno);
-}
-
-static const struct net_device_ops mac89x0_netdev_ops = {
-	.ndo_open		= net_open,
-	.ndo_stop		= net_close,
-	.ndo_start_xmit		= net_send_packet,
-	.ndo_get_stats		= net_get_stats,
-	.ndo_set_rx_mode	= set_multicast_list,
-	.ndo_set_mac_address	= set_mac_address,
-	.ndo_validate_addr	= eth_validate_addr,
-};
-
-/* Probe for the CS8900 card in slot E.  We won't bother looking
-   anywhere else until we have a really good reason to do so. */
-static int mac89x0_device_probe(struct platform_device *pdev)
-{
-	struct net_device *dev;
-	struct net_local *lp;
-	int i, slot;
-	unsigned rev_type = 0;
-	unsigned long ioaddr;
-	unsigned short sig;
-	int err = -ENODEV;
-	struct nubus_rsrc *fres;
-
-	dev = alloc_etherdev(sizeof(struct net_local));
-	if (!dev)
-		return -ENOMEM;
-
-	/* We might have to parameterize this later */
-	slot = 0xE;
-	/* Get out now if there's a real NuBus card in slot E */
-	for_each_func_rsrc(fres)
-		if (fres->board->slot == slot)
-			goto out;
-
-	/* The pseudo-ISA bits always live at offset 0x300 (gee,
-           wonder why...) */
-	ioaddr = (unsigned long)
-		nubus_slot_addr(slot) | (((slot&0xf) << 20) + DEFAULTIOBASE);
-	{
-		int card_present;
-
-		card_present = (hwreg_present((void *)ioaddr + 4) &&
-				hwreg_present((void *)ioaddr + DATA_PORT));
-		if (!card_present)
-			goto out;
-	}
-
-	nubus_writew(0, ioaddr + ADD_PORT);
-	sig = nubus_readw(ioaddr + DATA_PORT);
-	if (sig != swab16(CHIP_EISA_ID_SIG))
-		goto out;
-
-	SET_NETDEV_DEV(dev, &pdev->dev);
-
-	/* Initialize the net_device structure. */
-	lp = netdev_priv(dev);
-
-	lp->msg_enable = netif_msg_init(debug, 0);
-
-	/* Fill in the 'dev' fields. */
-	dev->base_addr = ioaddr;
-	dev->mem_start = (unsigned long)
-		nubus_slot_addr(slot) | (((slot&0xf) << 20) + MMIOBASE);
-	dev->mem_end = dev->mem_start + 0x1000;
-
-	/* Turn on shared memory */
-	writereg_io(dev, PP_BusCTL, MEMORY_ON);
-
-	/* get the chip type */
-	rev_type = readreg(dev, PRODUCT_ID_ADD);
-	lp->chip_type = rev_type &~ REVISON_BITS;
-	lp->chip_revision = ((rev_type & REVISON_BITS) >> 8) + 'A';
-
-	/* Check the chip type and revision in order to set the correct send command
-	CS8920 revision C and CS8900 revision F can use the faster send. */
-	lp->send_cmd = TX_AFTER_381;
-	if (lp->chip_type == CS8900 && lp->chip_revision >= 'F')
-		lp->send_cmd = TX_NOW;
-	if (lp->chip_type != CS8900 && lp->chip_revision >= 'C')
-		lp->send_cmd = TX_NOW;
-
-	netif_dbg(lp, drv, dev, "%s", version);
-
-	pr_info("cs89%c0%s rev %c found at %#8lx\n",
-		lp->chip_type == CS8900 ? '0' : '2',
-		lp->chip_type == CS8920M ? "M" : "",
-		lp->chip_revision, dev->base_addr);
-
-	/* Try to read the MAC address */
-	if ((readreg(dev, PP_SelfST) & (EEPROM_PRESENT | EEPROM_OK)) == 0) {
-		pr_info("No EEPROM, giving up now.\n");
-		goto out1;
-        } else {
-		u8 addr[ETH_ALEN];
-
-                for (i = 0; i < ETH_ALEN; i += 2) {
-			/* Big-endian (why??!) */
-			unsigned short s = readreg(dev, PP_IA + i);
-			addr[i] = s >> 8;
-			addr[i+1] = s & 0xff;
-                }
-		eth_hw_addr_set(dev, addr);
-        }
-
-	dev->irq = SLOT2IRQ(slot);
-
-	/* print the IRQ and ethernet address. */
-
-	pr_info("MAC %pM, IRQ %d\n", dev->dev_addr, dev->irq);
-
-	dev->netdev_ops		= &mac89x0_netdev_ops;
-
-	err = register_netdev(dev);
-	if (err)
-		goto out1;
-
-	platform_set_drvdata(pdev, dev);
-	return 0;
-out1:
-	nubus_writew(0, dev->base_addr + ADD_PORT);
-out:
-	free_netdev(dev);
-	return err;
-}
-
-/* Open/initialize the board.  This is called (in the current kernel)
-   sometime after booting when the 'ifconfig' program is run.
-
-   This routine should set everything up anew at each open, even
-   registers that "should" only need to be set once at boot, so that
-   there is non-reboot way to recover if something goes wrong.
-   */
-static int
-net_open(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	int i;
-
-	/* Disable the interrupt for now */
-	writereg(dev, PP_BusCTL, readreg(dev, PP_BusCTL) & ~ENABLE_IRQ);
-
-	/* Grab the interrupt */
-	if (request_irq(dev->irq, net_interrupt, 0, "cs89x0", dev))
-		return -EAGAIN;
-
-	/* Set up the IRQ - Apparently magic */
-	if (lp->chip_type == CS8900)
-		writereg(dev, PP_CS8900_ISAINT, 0);
-	else
-		writereg(dev, PP_CS8920_ISAINT, 0);
-
-	/* set the Ethernet address */
-	for (i=0; i < ETH_ALEN/2; i++)
-		writereg(dev, PP_IA+i*2, dev->dev_addr[i*2] | (dev->dev_addr[i*2+1] << 8));
-
-	/* Turn on both receive and transmit operations */
-	writereg(dev, PP_LineCTL, readreg(dev, PP_LineCTL) | SERIAL_RX_ON | SERIAL_TX_ON);
-
-	/* Receive only error free packets addressed to this card */
-	lp->rx_mode = 0;
-	writereg(dev, PP_RxCTL, DEF_RX_ACCEPT);
-
-	lp->curr_rx_cfg = RX_OK_ENBL | RX_CRC_ERROR_ENBL;
-
-	writereg(dev, PP_RxCFG, lp->curr_rx_cfg);
-
-	writereg(dev, PP_TxCFG, TX_LOST_CRS_ENBL | TX_SQE_ERROR_ENBL | TX_OK_ENBL |
-	       TX_LATE_COL_ENBL | TX_JBR_ENBL | TX_ANY_COL_ENBL | TX_16_COL_ENBL);
-
-	writereg(dev, PP_BufCFG, READY_FOR_TX_ENBL | RX_MISS_COUNT_OVRFLOW_ENBL |
-		 TX_COL_COUNT_OVRFLOW_ENBL | TX_UNDERRUN_ENBL);
-
-	/* now that we've got our act together, enable everything */
-	writereg(dev, PP_BusCTL, readreg(dev, PP_BusCTL) | ENABLE_IRQ);
-	netif_start_queue(dev);
-	return 0;
-}
-
-static netdev_tx_t
-net_send_packet(struct sk_buff *skb, struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	unsigned long flags;
-
-	netif_dbg(lp, tx_queued, dev, "sent %d byte packet of type %x\n",
-		  skb->len, skb->data[ETH_ALEN + ETH_ALEN] << 8 |
-		  skb->data[ETH_ALEN + ETH_ALEN + 1]);
-
-	/* keep the upload from being interrupted, since we
-	   ask the chip to start transmitting before the
-	   whole packet has been completely uploaded. */
-	local_irq_save(flags);
-	netif_stop_queue(dev);
-
-	/* initiate a transmit sequence */
-	writereg(dev, PP_TxCMD, lp->send_cmd);
-	writereg(dev, PP_TxLength, skb->len);
-
-	/* Test to see if the chip has allocated memory for the packet */
-	if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
-		/* Gasp!  It hasn't.  But that shouldn't happen since
-		   we're waiting for TxOk, so return 1 and requeue this packet. */
-		local_irq_restore(flags);
-		return NETDEV_TX_BUSY;
-	}
-
-	/* Write the contents of the packet */
-	skb_copy_from_linear_data(skb, (void *)(dev->mem_start + PP_TxFrame),
-				  skb->len+1);
-
-	local_irq_restore(flags);
-	dev_kfree_skb (skb);
-
-	return NETDEV_TX_OK;
-}
-
-/* The typical workload of the driver:
-   Handle the network interface interrupts. */
-static irqreturn_t net_interrupt(int irq, void *dev_id)
-{
-	struct net_device *dev = dev_id;
-	struct net_local *lp;
-	int ioaddr, status;
-
-	ioaddr = dev->base_addr;
-	lp = netdev_priv(dev);
-
-	/* we MUST read all the events out of the ISQ, otherwise we'll never
-           get interrupted again.  As a consequence, we can't have any limit
-           on the number of times we loop in the interrupt handler.  The
-           hardware guarantees that eventually we'll run out of events.  Of
-           course, if you're on a slow machine, and packets are arriving
-           faster than you can read them off, you're screwed.  Hasta la
-           vista, baby!  */
-	while ((status = swab16(nubus_readw(dev->base_addr + ISQ_PORT)))) {
-		netif_dbg(lp, intr, dev, "status=%04x\n", status);
-		switch(status & ISQ_EVENT_MASK) {
-		case ISQ_RECEIVER_EVENT:
-			/* Got a packet(s). */
-			net_rx(dev);
-			break;
-		case ISQ_TRANSMITTER_EVENT:
-			dev->stats.tx_packets++;
-			netif_wake_queue(dev);
-			if ((status & TX_OK) == 0)
-				dev->stats.tx_errors++;
-			if (status & TX_LOST_CRS)
-				dev->stats.tx_carrier_errors++;
-			if (status & TX_SQE_ERROR)
-				dev->stats.tx_heartbeat_errors++;
-			if (status & TX_LATE_COL)
-				dev->stats.tx_window_errors++;
-			if (status & TX_16_COL)
-				dev->stats.tx_aborted_errors++;
-			break;
-		case ISQ_BUFFER_EVENT:
-			if (status & READY_FOR_TX) {
-				/* we tried to transmit a packet earlier,
-                                   but inexplicably ran out of buffers.
-                                   That shouldn't happen since we only ever
-                                   load one packet.  Shrug.  Do the right
-                                   thing anyway. */
-				netif_wake_queue(dev);
-			}
-			if (status & TX_UNDERRUN) {
-				netif_dbg(lp, tx_err, dev, "transmit underrun\n");
-                                lp->send_underrun++;
-                                if (lp->send_underrun == 3) lp->send_cmd = TX_AFTER_381;
-                                else if (lp->send_underrun == 6) lp->send_cmd = TX_AFTER_ALL;
-                        }
-			break;
-		case ISQ_RX_MISS_EVENT:
-			dev->stats.rx_missed_errors += (status >> 6);
-			break;
-		case ISQ_TX_COL_EVENT:
-			dev->stats.collisions += (status >> 6);
-			break;
-		}
-	}
-	return IRQ_HANDLED;
-}
-
-/* We have a good packet(s), get it/them out of the buffers. */
-static void
-net_rx(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	struct sk_buff *skb;
-	int status, length;
-
-	status = readreg(dev, PP_RxStatus);
-	if ((status & RX_OK) == 0) {
-		dev->stats.rx_errors++;
-		if (status & RX_RUNT)
-				dev->stats.rx_length_errors++;
-		if (status & RX_EXTRA_DATA)
-				dev->stats.rx_length_errors++;
-		if ((status & RX_CRC_ERROR) &&
-		    !(status & (RX_EXTRA_DATA|RX_RUNT)))
-			/* per str 172 */
-			dev->stats.rx_crc_errors++;
-		if (status & RX_DRIBBLE)
-				dev->stats.rx_frame_errors++;
-		return;
-	}
-
-	length = readreg(dev, PP_RxLength);
-	/* Malloc up new buffer. */
-	skb = alloc_skb(length, GFP_ATOMIC);
-	if (skb == NULL) {
-		dev->stats.rx_dropped++;
-		return;
-	}
-	skb_put(skb, length);
-
-	skb_copy_to_linear_data(skb, (void *)(dev->mem_start + PP_RxFrame),
-				length);
-
-	netif_dbg(lp, rx_status, dev, "received %d byte packet of type %x\n",
-		  length, skb->data[ETH_ALEN + ETH_ALEN] << 8 |
-		  skb->data[ETH_ALEN + ETH_ALEN + 1]);
-
-        skb->protocol=eth_type_trans(skb,dev);
-	netif_rx(skb);
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += length;
-}
-
-/* The inverse routine to net_open(). */
-static int
-net_close(struct net_device *dev)
-{
-
-	writereg(dev, PP_RxCFG, 0);
-	writereg(dev, PP_TxCFG, 0);
-	writereg(dev, PP_BufCFG, 0);
-	writereg(dev, PP_BusCTL, 0);
-
-	netif_stop_queue(dev);
-
-	free_irq(dev->irq, dev);
-
-	/* Update the statistics here. */
-
-	return 0;
-
-}
-
-/* Get the current statistics.	This may be called with the card open or
-   closed. */
-static struct net_device_stats *
-net_get_stats(struct net_device *dev)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	/* Update the statistics from the device registers. */
-	dev->stats.rx_missed_errors += (readreg(dev, PP_RxMiss) >> 6);
-	dev->stats.collisions += (readreg(dev, PP_TxCol) >> 6);
-	local_irq_restore(flags);
-
-	return &dev->stats;
-}
-
-static void set_multicast_list(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-
-	if(dev->flags&IFF_PROMISC)
-	{
-		lp->rx_mode = RX_ALL_ACCEPT;
-	} else if ((dev->flags & IFF_ALLMULTI) || !netdev_mc_empty(dev)) {
-		/* The multicast-accept list is initialized to accept-all, and we
-		   rely on higher-level filtering for now. */
-		lp->rx_mode = RX_MULTCAST_ACCEPT;
-	}
-	else
-		lp->rx_mode = 0;
-
-	writereg(dev, PP_RxCTL, DEF_RX_ACCEPT | lp->rx_mode);
-
-	/* in promiscuous mode, we accept errored packets, so we have to enable interrupts on them also */
-	writereg(dev, PP_RxCFG, lp->curr_rx_cfg |
-	     (lp->rx_mode == RX_ALL_ACCEPT? (RX_CRC_ERROR_ENBL|RX_RUNT_ENBL|RX_EXTRA_DATA_ENBL) : 0));
-}
-
-
-static int set_mac_address(struct net_device *dev, void *addr)
-{
-	struct sockaddr *saddr = addr;
-	int i;
-
-	if (!is_valid_ether_addr(saddr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(dev, saddr->sa_data);
-	netdev_info(dev, "Setting MAC address to %pM\n", dev->dev_addr);
-
-	/* set the Ethernet address */
-	for (i=0; i < ETH_ALEN/2; i++)
-		writereg(dev, PP_IA+i*2, dev->dev_addr[i*2] | (dev->dev_addr[i*2+1] << 8));
-
-	return 0;
-}
-
-MODULE_DESCRIPTION("Macintosh CS89x0-based Ethernet driver");
-MODULE_LICENSE("GPL");
-
-static void mac89x0_device_remove(struct platform_device *pdev)
-{
-	struct net_device *dev = platform_get_drvdata(pdev);
-
-	unregister_netdev(dev);
-	nubus_writew(0, dev->base_addr + ADD_PORT);
-	free_netdev(dev);
-}
-
-static struct platform_driver mac89x0_platform_driver = {
-	.probe = mac89x0_device_probe,
-	.remove = mac89x0_device_remove,
-	.driver = {
-		.name = "mac89x0",
-	},
-};
-
-module_platform_driver(mac89x0_platform_driver);

-- 
2.53.0


