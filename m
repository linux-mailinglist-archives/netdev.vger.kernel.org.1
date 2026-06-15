Return-Path: <netdev+bounces-299586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id InQRNkRWMGoMRwUAu9opvQ
	(envelope-from <netdev+bounces-299586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:45:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910668986E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:45:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NfLgZAot;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299586-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299586-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2C3304CF47
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F773AFAEA;
	Mon, 15 Jun 2026 19:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4333B4E83
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552679; cv=none; b=oATX9j3WVF0NJhYpkwe4LZASrlgg+zRUY0KA8Vb/Q2fGSnCWixSFKZ3k/bx3AYxdaKJuwhCg1Aqhv5xHwWmCdez+7iutHor1kIpf2ZRMgF8DWpje83mBpCykP8Tx0DTWQAt4q8+oY/H7MZxmX3H0nuBfUXJrRsFR8xfe+qGqbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552679; c=relaxed/simple;
	bh=nglRCSFwF5vPaX2kqVzDq/ZNF8JoJa5TXO490M4T5gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSH3uIrhSF2Wrg3TVYnFmKhtKm9bOwqgV5icCv2muixdOcb9bKXeYsbJSDYb5n3lQd/c/7uUab2DXEjXgBmNsYVISBzScbKr4QjLDy5g0F7cLNP2k887Tlf0S1A9Xp8wpPTLZ1f6UHTVmsw4Y/pZxwl3HVgMo4h3kDNh7Q9gpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfLgZAot; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16961F000E9;
	Mon, 15 Jun 2026 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552665;
	bh=5D2fKKalt4rCqyeSYAiP6KG0FG9s4aT93nSbVuDtsfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfLgZAotYgOKQ1ZGiMeKbG/EIOkpVMfyN8QRM/S//my3NXiV1F+KVisHlp94S1ml1
	 DpZBpqtb6cwH62yFglcQDNGihVtAS2SRPESCaXhsNyY4GwzBx0kxTMUNfMtzjA5V5q
	 lMovrwPjUecNjeDg1/ISHDefRL5U86f4XvzLTA5LpbPZt4L+AZqVOi4RqrB6uM0ADh
	 rYnBV+xo1oFHz0kFMRpiupzH4Nw8w/NQCueP854gctZc/aGlyVdgKHo02pY2PeXVLs
	 +s3rXwYMw3Mk4+4ovbhcG8w7YOk6KXXv60vGE67/DfVaoAWRwykNZWERRHnAmqMET3
	 dLixnYx/20NaQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 9/9] atm: remove orphaned uAPI for deleted drivers, protocols and SVCs
Date: Mon, 15 Jun 2026 12:44:16 -0700
Message-ID: <20260615194416.752559-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299586-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4910668986E

ATM removals have left a number of uAPI headers and ioctl
definitions with no in-kernel implementation behind them:

 - device headers for adapters deleted with the legacy PCI/SBUS drivers:
   atm_eni.h, atm_he.h, atm_idt77105.h, atm_nicstar.h, atm_zatm.h and
   the atmtcp pair atm_tcp.h / <linux/atm_tcp.h>
 - protocol headers for the removed CLIP, LANE and MPOA stacks:
   atmarp.h, atmclip.h, atmlec.h, atmmpc.h
 - atmsvc.h and the SVC / p2mp / local-address ioctls in atmdev.h
   (ATM_{GET,RST,ADD,DEL}ADDR, ATM_{ADD,DEL,GET}LECSADDR,
   ATM_{ADD,DROP}PARTY) left behind by the SVC and address-registry
   removals

None of these are referenced by any remaining in-tree code.
Let's try to delete all this. Chances are nobody cares about
these headers any more. I'm keeping this separate from the
kernel side code changes for ease of revert, in case I am
proven wrong...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atm_tcp.h           |  24 ------
 include/uapi/linux/atm_eni.h      |  24 ------
 include/uapi/linux/atm_he.h       |  21 -----
 include/uapi/linux/atm_idt77105.h |  29 -------
 include/uapi/linux/atm_nicstar.h  |  54 -------------
 include/uapi/linux/atm_tcp.h      |  62 ---------------
 include/uapi/linux/atm_zatm.h     |  47 -----------
 include/uapi/linux/atmarp.h       |  42 ----------
 include/uapi/linux/atmclip.h      |  22 ------
 include/uapi/linux/atmdev.h       |  18 -----
 include/uapi/linux/atmlec.h       |  92 ----------------------
 include/uapi/linux/atmmpc.h       | 127 ------------------------------
 include/uapi/linux/atmsvc.h       |  56 -------------
 net/atm/ioctl.c                   |   1 -
 14 files changed, 619 deletions(-)
 delete mode 100644 include/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_eni.h
 delete mode 100644 include/uapi/linux/atm_he.h
 delete mode 100644 include/uapi/linux/atm_idt77105.h
 delete mode 100644 include/uapi/linux/atm_nicstar.h
 delete mode 100644 include/uapi/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_zatm.h
 delete mode 100644 include/uapi/linux/atmarp.h
 delete mode 100644 include/uapi/linux/atmclip.h
 delete mode 100644 include/uapi/linux/atmlec.h
 delete mode 100644 include/uapi/linux/atmmpc.h
 delete mode 100644 include/uapi/linux/atmsvc.h

diff --git a/include/linux/atm_tcp.h b/include/linux/atm_tcp.h
deleted file mode 100644
index 2558439d849b..000000000000
--- a/include/linux/atm_tcp.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* atm_tcp.h - Driver-specific declarations of the ATMTCP driver (for use by
-	       driver-specific utilities) */
-
-/* Written 1997-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-#ifndef LINUX_ATM_TCP_H
-#define LINUX_ATM_TCP_H
-
-#include <uapi/linux/atm_tcp.h>
-
-struct atm_vcc;
-struct module;
-
-struct atm_tcp_ops {
-	int (*attach)(struct atm_vcc *vcc,int itf);
-	int (*create_persistent)(int itf);
-	int (*remove_persistent)(int itf);
-	struct module *owner;
-};
-
-extern struct atm_tcp_ops atm_tcp_ops;
-
-#endif
diff --git a/include/uapi/linux/atm_eni.h b/include/uapi/linux/atm_eni.h
deleted file mode 100644
index cf5bfd1a2691..000000000000
--- a/include/uapi/linux/atm_eni.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atm_eni.h - Driver-specific declarations of the ENI driver (for use by
-	       driver-specific utilities) */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#ifndef LINUX_ATM_ENI_H
-#define LINUX_ATM_ENI_H
-
-#include <linux/atmioc.h>
-
-
-struct eni_multipliers {
-	int tx,rx;	/* values are in percent and must be > 100 */
-};
-
-
-#define ENI_MEMDUMP     _IOW('a',ATMIOC_SARPRV,struct atmif_sioc)
-                                                /* printk memory map */
-#define ENI_SETMULT	_IOW('a',ATMIOC_SARPRV+7,struct atmif_sioc)
-						/* set buffer multipliers */
-
-#endif
diff --git a/include/uapi/linux/atm_he.h b/include/uapi/linux/atm_he.h
deleted file mode 100644
index 9f4b43293988..000000000000
--- a/include/uapi/linux/atm_he.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atm_he.h */
-
-#ifndef LINUX_ATM_HE_H
-#define LINUX_ATM_HE_H
-
-#include <linux/atmioc.h>
-
-#define HE_GET_REG	_IOW('a', ATMIOC_SARPRV, struct atmif_sioc)
-
-#define HE_REGTYPE_PCI	1
-#define HE_REGTYPE_RCM	2
-#define HE_REGTYPE_TCM	3
-#define HE_REGTYPE_MBOX	4
-
-struct he_ioctl_reg {
-	unsigned addr, val;
-	char type;
-};
-
-#endif /* LINUX_ATM_HE_H */
diff --git a/include/uapi/linux/atm_idt77105.h b/include/uapi/linux/atm_idt77105.h
deleted file mode 100644
index f0fd6912a14b..000000000000
--- a/include/uapi/linux/atm_idt77105.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atm_idt77105.h - Driver-specific declarations of the IDT77105 driver (for
- * use by driver-specific utilities) */
-
-/* Written 1999 by Greg Banks <gnb@linuxfan.com>. Copied from atm_suni.h. */
-
-
-#ifndef LINUX_ATM_IDT77105_H
-#define LINUX_ATM_IDT77105_H
-
-#include <linux/types.h>
-#include <linux/atmioc.h>
-#include <linux/atmdev.h>
-
-/*
- * Structure for IDT77105_GETSTAT and IDT77105_GETSTATZ ioctls.
- * Pointed to by `arg' in atmif_sioc.
- */
-struct idt77105_stats {
-        __u32 symbol_errors;  /* wire symbol errors */
-        __u32 tx_cells;       /* cells transmitted */
-        __u32 rx_cells;       /* cells received */
-        __u32 rx_hec_errors;  /* Header Error Check errors on receive */
-};
-
-#define IDT77105_GETSTAT	_IOW('a',ATMIOC_PHYPRV+2,struct atmif_sioc)	/* get stats */
-#define IDT77105_GETSTATZ	_IOW('a',ATMIOC_PHYPRV+3,struct atmif_sioc)	/* get stats and zero */
-
-#endif
diff --git a/include/uapi/linux/atm_nicstar.h b/include/uapi/linux/atm_nicstar.h
deleted file mode 100644
index 880d368b5b9a..000000000000
--- a/include/uapi/linux/atm_nicstar.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/******************************************************************************
- *
- * atm_nicstar.h
- *
- * Driver-specific declarations for use by NICSTAR driver specific utils.
- *
- * Author: Rui Prior
- *
- * (C) INESC 1998
- *
- ******************************************************************************/
-
-
-#ifndef LINUX_ATM_NICSTAR_H
-#define LINUX_ATM_NICSTAR_H
-
-/* Note: non-kernel programs including this file must also include
- * sys/types.h for struct timeval
- */
-
-#include <linux/atmapi.h>
-#include <linux/atmioc.h>
-
-#define NS_GETPSTAT	_IOWR('a',ATMIOC_SARPRV+1,struct atmif_sioc)
-						/* get pool statistics */
-#define NS_SETBUFLEV	_IOW('a',ATMIOC_SARPRV+2,struct atmif_sioc)
-						/* set buffer level markers */
-#define NS_ADJBUFLEV	_IO('a',ATMIOC_SARPRV+3)
-						/* adjust buffer level */
-
-typedef struct buf_nr
-{
-   unsigned min;
-   unsigned init;
-   unsigned max;
-}buf_nr;
-
-
-typedef struct pool_levels
-{
-   int buftype;
-   int count;		/* (At least for now) only used in NS_GETPSTAT */
-   buf_nr level;
-} pool_levels;
-
-/* type must be one of the following: */
-#define NS_BUFTYPE_SMALL 1
-#define NS_BUFTYPE_LARGE 2
-#define NS_BUFTYPE_HUGE 3
-#define NS_BUFTYPE_IOVEC 4
-
-
-#endif /* LINUX_ATM_NICSTAR_H */
diff --git a/include/uapi/linux/atm_tcp.h b/include/uapi/linux/atm_tcp.h
deleted file mode 100644
index 7309e1bc8867..000000000000
--- a/include/uapi/linux/atm_tcp.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atm_tcp.h - Driver-specific declarations of the ATMTCP driver (for use by
-	       driver-specific utilities) */
-
-/* Written 1997-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#ifndef _UAPILINUX_ATM_TCP_H
-#define _UAPILINUX_ATM_TCP_H
-
-#include <linux/atmapi.h>
-#include <linux/atm.h>
-#include <linux/atmioc.h>
-#include <linux/types.h>
-
-
-/*
- * All values in struct atmtcp_hdr are in network byte order
- */
-
-struct atmtcp_hdr {
-	__u16	vpi;
-	__u16	vci;
-	__u32	length;		/* ... of data part */
-};
-
-/*
- * All values in struct atmtcp_command are in host byte order
- */
-
-#define ATMTCP_HDR_MAGIC	(~0)	/* this length indicates a command */
-#define ATMTCP_CTRL_OPEN	1	/* request/reply */
-#define ATMTCP_CTRL_CLOSE	2	/* request/reply */
-
-struct atmtcp_control {
-	struct atmtcp_hdr hdr;	/* must be first */
-	int type;		/* message type; both directions */
-	atm_kptr_t vcc;		/* both directions */
-	struct sockaddr_atmpvc addr; /* suggested value from kernel */
-	struct atm_qos	qos;	/* both directions */
-	int result;		/* to kernel only */
-} __ATM_API_ALIGN;
-
-/*
- * Field usage:
- * Messge type	dir.	hdr.v?i	type	addr	qos	vcc	result
- * -----------  ----	------- ----	----	---	---	------
- * OPEN		K->D	Y	Y	Y	Y	Y	0
- * OPEN		D->K	-	Y	Y	Y	Y	Y
- * CLOSE	K->D	-	-	Y	-	Y	0
- * CLOSE	D->K	-	-	-	-	Y	Y
- */
-
-#define SIOCSIFATMTCP	_IO('a',ATMIOC_ITF)	/* set ATMTCP mode */
-#define ATMTCP_CREATE	_IO('a',ATMIOC_ITF+14)	/* create persistent ATMTCP
-						   interface */
-#define ATMTCP_REMOVE	_IO('a',ATMIOC_ITF+15)	/* destroy persistent ATMTCP
-						   interface */
-
-
-
-#endif /* _UAPILINUX_ATM_TCP_H */
diff --git a/include/uapi/linux/atm_zatm.h b/include/uapi/linux/atm_zatm.h
deleted file mode 100644
index 5135027b93c1..000000000000
--- a/include/uapi/linux/atm_zatm.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atm_zatm.h - Driver-specific declarations of the ZATM driver (for use by
-		driver-specific utilities) */
-
-/* Written 1995-1999 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#ifndef LINUX_ATM_ZATM_H
-#define LINUX_ATM_ZATM_H
-
-/*
- * Note: non-kernel programs including this file must also include
- * sys/types.h for struct timeval
- */
-
-#include <linux/atmapi.h>
-#include <linux/atmioc.h>
-
-#define ZATM_GETPOOL	_IOW('a',ATMIOC_SARPRV+1,struct atmif_sioc)
-						/* get pool statistics */
-#define ZATM_GETPOOLZ	_IOW('a',ATMIOC_SARPRV+2,struct atmif_sioc)
-						/* get statistics and zero */
-#define ZATM_SETPOOL	_IOW('a',ATMIOC_SARPRV+3,struct atmif_sioc)
-						/* set pool parameters */
-
-struct zatm_pool_info {
-	int ref_count;			/* free buffer pool usage counters */
-	int low_water,high_water;	/* refill parameters */
-	int rqa_count,rqu_count;	/* queue condition counters */
-	int offset,next_off;		/* alignment optimizations: offset */
-	int next_cnt,next_thres;	/* repetition counter and threshold */
-};
-
-struct zatm_pool_req {
-	int pool_num;			/* pool number */
-	struct zatm_pool_info info;	/* actual information */
-};
-
-#define ZATM_OAM_POOL		0	/* free buffer pool for OAM cells */
-#define ZATM_AAL0_POOL		1	/* free buffer pool for AAL0 cells */
-#define ZATM_AAL5_POOL_BASE	2	/* first AAL5 free buffer pool */
-#define ZATM_LAST_POOL	ZATM_AAL5_POOL_BASE+10 /* max. 64 kB */
-
-#define ZATM_TIMER_HISTORY_SIZE	16	/* number of timer adjustments to
-					   record; must be 2^n */
-
-#endif
diff --git a/include/uapi/linux/atmarp.h b/include/uapi/linux/atmarp.h
deleted file mode 100644
index 8e44d121fde1..000000000000
--- a/include/uapi/linux/atmarp.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atmarp.h - ATM ARP protocol and kernel-demon interface definitions */
- 
-/* Written 1995-1999 by Werner Almesberger, EPFL LRC/ICA */
- 
-
-#ifndef _LINUX_ATMARP_H
-#define _LINUX_ATMARP_H
-
-#include <linux/types.h>
-#include <linux/atmapi.h>
-#include <linux/atmioc.h>
-
-
-#define ATMARP_RETRY_DELAY 30		/* request next resolution or forget
-					   NAK after 30 sec - should go into
-					   atmclip.h */
-#define ATMARP_MAX_UNRES_PACKETS 5	/* queue that many packets while
-					   waiting for the resolver */
-
-
-#define ATMARPD_CTRL	_IO('a',ATMIOC_CLIP+1)	/* become atmarpd ctrl sock */
-#define ATMARP_MKIP	_IO('a',ATMIOC_CLIP+2)	/* attach socket to IP */
-#define ATMARP_SETENTRY	_IO('a',ATMIOC_CLIP+3)	/* fill or hide ARP entry */
-#define ATMARP_ENCAP	_IO('a',ATMIOC_CLIP+5)	/* change encapsulation */
-
-
-enum atmarp_ctrl_type {
-	act_invalid,		/* catch uninitialized structures */
-	act_need,		/* need address resolution */
-	act_up,			/* interface is coming up */
-	act_down,		/* interface is going down */
-	act_change		/* interface configuration has changed */
-};
-
-struct atmarp_ctrl {
-	enum atmarp_ctrl_type	type;	/* message type */
-	int			itf_num;/* interface number (if present) */
-	__be32			ip;	/* IP address (act_need only) */
-};
-
-#endif
diff --git a/include/uapi/linux/atmclip.h b/include/uapi/linux/atmclip.h
deleted file mode 100644
index c818bb82b4e6..000000000000
--- a/include/uapi/linux/atmclip.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atmclip.h - Classical IP over ATM */
- 
-/* Written 1995-1998 by Werner Almesberger, EPFL LRC/ICA */
- 
-
-#ifndef LINUX_ATMCLIP_H
-#define LINUX_ATMCLIP_H
-
-#include <linux/sockios.h>
-#include <linux/atmioc.h>
-
-
-#define RFC1483LLC_LEN	8		/* LLC+OUI+PID = 8 */
-#define RFC1626_MTU	9180		/* RFC1626 default MTU */
-
-#define CLIP_DEFAULT_IDLETIMER 1200	/* 20 minutes, see RFC1755 */
-#define CLIP_CHECK_INTERVAL	 10	/* check every ten seconds */
-
-#define	SIOCMKCLIP	_IO('a',ATMIOC_CLIP)	/* create IP interface */
-
-#endif
diff --git a/include/uapi/linux/atmdev.h b/include/uapi/linux/atmdev.h
index 20b0215084fc..a94e7b8360ee 100644
--- a/include/uapi/linux/atmdev.h
+++ b/include/uapi/linux/atmdev.h
@@ -60,14 +60,6 @@ struct atm_dev_stats {
 					/* get interface type name */
 #define ATM_GETESI	_IOW('a',ATMIOC_ITF+5,struct atmif_sioc)
 					/* get interface ESI */
-#define ATM_GETADDR	_IOW('a',ATMIOC_ITF+6,struct atmif_sioc)
-					/* get itf's local ATM addr. list */
-#define ATM_RSTADDR	_IOW('a',ATMIOC_ITF+7,struct atmif_sioc)
-					/* reset itf's ATM address list */
-#define ATM_ADDADDR	_IOW('a',ATMIOC_ITF+8,struct atmif_sioc)
-					/* add a local ATM address */
-#define ATM_DELADDR	_IOW('a',ATMIOC_ITF+9,struct atmif_sioc)
-					/* remove a local ATM address */
 #define ATM_GETCIRANGE	_IOW('a',ATMIOC_ITF+10,struct atmif_sioc)
 					/* get connection identifier range */
 #define ATM_SETCIRANGE	_IOW('a',ATMIOC_ITF+11,struct atmif_sioc)
@@ -76,12 +68,6 @@ struct atm_dev_stats {
 					/* set interface ESI */
 #define ATM_SETESIF	_IOW('a',ATMIOC_ITF+13,struct atmif_sioc)
 					/* force interface ESI */
-#define ATM_ADDLECSADDR	_IOW('a', ATMIOC_ITF+14, struct atmif_sioc)
-					/* register a LECS address */
-#define ATM_DELLECSADDR	_IOW('a', ATMIOC_ITF+15, struct atmif_sioc)
-					/* unregister a LECS address */
-#define ATM_GETLECSADDR	_IOW('a', ATMIOC_ITF+16, struct atmif_sioc)
-					/* retrieve LECS address(es) */
 
 #define ATM_GETSTAT	_IOW('a',ATMIOC_SARCOM+0,struct atmif_sioc)
 					/* get AAL layer statistics */
@@ -99,10 +85,6 @@ struct atm_dev_stats {
 					/* set backend handler */
 #define ATM_NEWBACKENDIF _IOW('a',ATMIOC_SPECIAL+3,atm_backend_t)
 					/* use backend to make new if */
-#define ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct atm_iobuf)
- 					/* add party to p2mp call */
-#define ATM_DROPPARTY 	_IOW('a', ATMIOC_SPECIAL+5,int)
-					/* drop party from p2mp call */
 
 /*
  * These are backend handkers that can be set via the ATM_SETBACKEND call
diff --git a/include/uapi/linux/atmlec.h b/include/uapi/linux/atmlec.h
deleted file mode 100644
index c68346bb40e6..000000000000
--- a/include/uapi/linux/atmlec.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * ATM Lan Emulation Daemon driver interface
- *
- * Marko Kiiskila <mkiiskila@yahoo.com>
- */
-
-#ifndef _ATMLEC_H_
-#define _ATMLEC_H_
-
-#include <linux/atmapi.h>
-#include <linux/atmioc.h>
-#include <linux/atm.h>
-#include <linux/if_ether.h>
-#include <linux/types.h>
-
-/* ATM lec daemon control socket */
-#define ATMLEC_CTRL	_IO('a', ATMIOC_LANE)
-#define ATMLEC_DATA	_IO('a', ATMIOC_LANE+1)
-#define ATMLEC_MCAST	_IO('a', ATMIOC_LANE+2)
-
-/* Maximum number of LEC interfaces (tweakable) */
-#define MAX_LEC_ITF 48
-
-typedef enum {
-	l_set_mac_addr,
-	l_del_mac_addr,
-	l_svc_setup,
-	l_addr_delete,
-	l_topology_change,
-	l_flush_complete,
-	l_arp_update,
-	l_narp_req,		/* LANE2 mandates the use of this */
-	l_config,
-	l_flush_tran_id,
-	l_set_lecid,
-	l_arp_xmt,
-	l_rdesc_arp_xmt,
-	l_associate_req,
-	l_should_bridge		/* should we bridge this MAC? */
-} atmlec_msg_type;
-
-#define ATMLEC_MSG_TYPE_MAX l_should_bridge
-
-struct atmlec_config_msg {
-	unsigned int maximum_unknown_frame_count;
-	unsigned int max_unknown_frame_time;
-	unsigned short max_retry_count;
-	unsigned int aging_time;
-	unsigned int forward_delay_time;
-	unsigned int arp_response_time;
-	unsigned int flush_timeout;
-	unsigned int path_switching_delay;
-	unsigned int lane_version;	/* LANE2: 1 for LANEv1, 2 for LANEv2 */
-	int mtu;
-	int is_proxy;
-};
-
-struct atmlec_msg {
-	atmlec_msg_type type;
-	int sizeoftlvs;		/* LANE2: if != 0, tlvs follow */
-	union {
-		struct {
-			unsigned char mac_addr[ETH_ALEN];
-			unsigned char atm_addr[ATM_ESA_LEN];
-			unsigned int flag;	/*
-						 * Topology_change flag,
-						 * remoteflag, permanent flag,
-						 * lecid, transaction id
-						 */
-			unsigned int targetless_le_arp;	/* LANE2 */
-			unsigned int no_source_le_narp;	/* LANE2 */
-		} normal;
-		struct atmlec_config_msg config;
-		struct {
-			__u16 lec_id;				/* requestor lec_id  */
-			__u32 tran_id;				/* transaction id    */
-			unsigned char mac_addr[ETH_ALEN];	/* dst mac addr      */
-			unsigned char atm_addr[ATM_ESA_LEN];	/* reqestor ATM addr */
-		} proxy;	/*
-				 * For mapping LE_ARP requests to responses. Filled by
-				 * zeppelin, returned by kernel. Used only when proxying
-				 */
-	} content;
-} __ATM_API_ALIGN;
-
-struct atmlec_ioc {
-	int dev_num;
-	unsigned char atm_addr[ATM_ESA_LEN];
-	unsigned char receive;	/* 1= receive vcc, 0 = send vcc */
-};
-#endif /* _ATMLEC_H_ */
diff --git a/include/uapi/linux/atmmpc.h b/include/uapi/linux/atmmpc.h
deleted file mode 100644
index cc17f4304839..000000000000
--- a/include/uapi/linux/atmmpc.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ATMMPC_H_
-#define _ATMMPC_H_
-
-#include <linux/atmapi.h>
-#include <linux/atmioc.h>
-#include <linux/atm.h>
-#include <linux/types.h>
-
-#define ATMMPC_CTRL _IO('a', ATMIOC_MPOA)
-#define ATMMPC_DATA _IO('a', ATMIOC_MPOA+1)
-
-#define MPC_SOCKET_INGRESS 1
-#define MPC_SOCKET_EGRESS  2
-
-struct atmmpc_ioc {
-        int dev_num;
-        __be32 ipaddr;              /* the IP address of the shortcut    */
-        int type;                     /* ingress or egress                 */
-};
-
-typedef struct in_ctrl_info {
-        __u8   Last_NHRP_CIE_code;
-        __u8   Last_Q2931_cause_value;
-        __u8   eg_MPC_ATM_addr[ATM_ESA_LEN];
-        __be32  tag;
-        __be32  in_dst_ip;      /* IP address this ingress MPC sends packets to */
-        __u16  holding_time;
-        __u32  request_id;
-} in_ctrl_info;
-
-typedef struct eg_ctrl_info {
-        __u8   DLL_header[256];
-        __u8   DH_length;
-        __be32  cache_id;
-        __be32  tag;
-        __be32  mps_ip;
-        __be32  eg_dst_ip;      /* IP address to which ingress MPC sends packets */
-        __u8   in_MPC_data_ATM_addr[ATM_ESA_LEN];
-        __u16  holding_time;
-} eg_ctrl_info;
-
-struct mpc_parameters {
-        __u16 mpc_p1;   /* Shortcut-Setup Frame Count    */
-        __u16 mpc_p2;   /* Shortcut-Setup Frame Time     */
-        __u8 mpc_p3[8]; /* Flow-detection Protocols      */
-        __u16 mpc_p4;   /* MPC Initial Retry Time        */
-        __u16 mpc_p5;   /* MPC Retry Time Maximum        */
-        __u16 mpc_p6;   /* Hold Down Time                */
-} ;
-
-struct k_message {
-        __u16 type;
-        __be32 ip_mask;
-        __u8  MPS_ctrl[ATM_ESA_LEN];
-        union {
-                in_ctrl_info in_info;
-                eg_ctrl_info eg_info;
-                struct mpc_parameters params;
-        } content;
-        struct atm_qos qos;       
-} __ATM_API_ALIGN;
-
-struct llc_snap_hdr {
-	/* RFC 1483 LLC/SNAP encapsulation for routed IP PDUs */
-        __u8  dsap;    /* Destination Service Access Point (0xAA)     */
-        __u8  ssap;    /* Source Service Access Point      (0xAA)     */
-        __u8  ui;      /* Unnumbered Information           (0x03)     */
-        __u8  org[3];  /* Organizational identification    (0x000000) */
-        __u8  type[2]; /* Ether type (for IP)              (0x0800)   */
-};
-
-/* TLVs this MPC recognizes */
-#define TLV_MPOA_DEVICE_TYPE         0x00a03e2a  
-
-/* MPOA device types in MPOA Device Type TLV */
-#define NON_MPOA    0
-#define MPS         1
-#define MPC         2
-#define MPS_AND_MPC 3
-
-
-/* MPC parameter defaults */
-
-#define MPC_P1 10  /* Shortcut-Setup Frame Count  */ 
-#define MPC_P2 1   /* Shortcut-Setup Frame Time   */
-#define MPC_P3 0   /* Flow-detection Protocols    */
-#define MPC_P4 5   /* MPC Initial Retry Time      */
-#define MPC_P5 40  /* MPC Retry Time Maximum      */
-#define MPC_P6 160 /* Hold Down Time              */
-#define HOLDING_TIME_DEFAULT 1200 /* same as MPS-p7 */
-
-/* MPC constants */
-
-#define MPC_C1 2   /* Retry Time Multiplier       */
-#define MPC_C2 60  /* Initial Keep-Alive Lifetime */
-
-/* Message types - to MPOA daemon */
-
-#define SND_MPOA_RES_RQST    201
-#define SET_MPS_CTRL_ADDR    202
-#define SND_MPOA_RES_RTRY    203 /* Different type in a retry due to req id         */
-#define STOP_KEEP_ALIVE_SM   204
-#define EGRESS_ENTRY_REMOVED 205
-#define SND_EGRESS_PURGE     206
-#define DIE                  207 /* tell the daemon to exit()                       */
-#define DATA_PLANE_PURGE     208 /* Data plane purge because of egress cache hit miss or dead MPS */
-#define OPEN_INGRESS_SVC     209
-
-/* Message types - from MPOA daemon */
-
-#define MPOA_TRIGGER_RCVD     101
-#define MPOA_RES_REPLY_RCVD   102
-#define INGRESS_PURGE_RCVD    103
-#define EGRESS_PURGE_RCVD     104
-#define MPS_DEATH             105
-#define CACHE_IMPOS_RCVD      106
-#define SET_MPC_CTRL_ADDR     107 /* Our MPC's control ATM address   */
-#define SET_MPS_MAC_ADDR      108
-#define CLEAN_UP_AND_EXIT     109
-#define SET_MPC_PARAMS        110 /* MPC configuration parameters    */
-
-/* Message types - bidirectional */       
-
-#define RELOAD                301 /* kill -HUP the daemon for reload */
-
-#endif /* _ATMMPC_H_ */
diff --git a/include/uapi/linux/atmsvc.h b/include/uapi/linux/atmsvc.h
deleted file mode 100644
index 137b5f853449..000000000000
--- a/include/uapi/linux/atmsvc.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* atmsvc.h - ATM signaling kernel-demon interface definitions */
- 
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
- 
-
-#ifndef _LINUX_ATMSVC_H
-#define _LINUX_ATMSVC_H
-
-#include <linux/atmapi.h>
-#include <linux/atm.h>
-#include <linux/atmioc.h>
-
-
-#define ATMSIGD_CTRL _IO('a',ATMIOC_SPECIAL)
-				/* become ATM signaling demon control socket */
-
-enum atmsvc_msg_type { as_catch_null, as_bind, as_connect, as_accept, as_reject,
-		       as_listen, as_okay, as_error, as_indicate, as_close,
-		       as_itf_notify, as_modify, as_identify, as_terminate,
-		       as_addparty, as_dropparty };
-
-struct atmsvc_msg {
-	enum atmsvc_msg_type type;
-	atm_kptr_t vcc;
-	atm_kptr_t listen_vcc;		/* indicate */
-	int reply;			/* for okay and close:		   */
-					/*   < 0: error before active	   */
-					/*        (sigd has discarded ctx) */
-					/*   ==0: success		   */
-				        /*   > 0: error when active (still */
-					/*        need to close)	   */
-	struct sockaddr_atmpvc pvc;	/* indicate, okay (connect) */
-	struct sockaddr_atmsvc local;	/* local SVC address */
-	struct atm_qos qos;		/* QOS parameters */
-	struct atm_sap sap;		/* SAP */
-	unsigned int session;		/* for p2pm */
-	struct sockaddr_atmsvc svc;	/* SVC address */
-} __ATM_API_ALIGN;
-
-/*
- * Message contents: see ftp://icaftp.epfl.ch/pub/linux/atm/docs/isp-*.tar.gz
- */
-
-/*
- * Some policy stuff for atmsigd and for net/atm/svc.c. Both have to agree on
- * what PCR is used to request bandwidth from the device driver. net/atm/svc.c
- * tries to do better than that, but only if there's no routing decision (i.e.
- * if signaling only uses one ATM interface).
- */
-
-#define SELECT_TOP_PCR(tp) ((tp).pcr ? (tp).pcr : \
-  (tp).max_pcr && (tp).max_pcr != ATM_MAX_PCR ? (tp).max_pcr : \
-  (tp).min_pcr ? (tp).min_pcr : ATM_MAX_PCR)
-
-#endif
diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 11f6d236f5d6..194587fc15e8 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -11,7 +11,6 @@
 #include <linux/net.h>		/* struct socket, struct proto_ops */
 #include <linux/atm.h>		/* ATM stuff */
 #include <linux/atmdev.h>
-#include <linux/atmarp.h>	/* manifest constants */
 #include <linux/capability.h>
 #include <linux/mutex.h>
 #include <asm/ioctls.h>
-- 
2.54.0


