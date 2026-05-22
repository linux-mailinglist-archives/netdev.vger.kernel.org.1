Return-Path: <netdev+bounces-290935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAfHFUffEGr2ewYAu9opvQ
	(envelope-from <netdev+bounces-290935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39585BB48F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 968CD3036E8F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAB3909A6;
	Fri, 22 May 2026 22:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB238D3F8
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490535; cv=none; b=Lul+itM/QeKF+rqmabM1O9EXBIpf2/WOxNz0Ee0h0S95pJ/Gs41r6w7JsVtrhtOA+J5gxwkgnU8JuoXapglDqpz/9M5wSV+zZ7K9QGz/BFHiI/ur1EB8Jei7oz6zIKjlfQcQvgXDWJfDHu27R1wjqrHJg5AV77nsdtGwht5sWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490535; c=relaxed/simple;
	bh=SlqhaaXkce7zxI3hQwH1QsW3IdKyO4BZ1oJs8RthxXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0HTohjqveaLcV4uHiKOkVMXlpLHk0+5Ndpu8ID+rRc08mbO6eodwEjd4L5P1sHXq/L7KT/p63Kg/atjDgVd0tOzpLMe+d9bfMi5wiqpHhBBqtljgImJHpuadTTHu80nLtXbzv511zEOVLxq0rcq58CXt+V9GasmhhKBGDVq328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id QXuWw1uNiXAbtQYmCwiz5Q; Fri, 22 May 2026 22:55:32 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id QYmBwj6yqcYN5QYmBw7Vam; Fri, 22 May 2026 22:55:31 +0000
X-Authority-Analysis: v=2.4 cv=QN5oRhLL c=1 sm=1 tr=0 ts=6a10dee3
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=QeWor2tdjpy9U23wdFvjzw==:17
 a=NGcC8JguVDcA:10 a=z6gsHLkEAAAA:8 a=hGzw-44bAAAA:8 a=Xie9NPzdAAAA:8
 a=gg6Chm5RLGiIV223kOgA:9 a=HvKuF1_PTVFglORKqfwH:22 a=vUoOGYJDS1_Kmot3Fv_X:22
 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.44.127] (port=33396 helo=timdesk.home.local)
	by host2044.hostmonster.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <tim.bird@sony.com>)
	id 1wQYmA-00000002vK2-416T;
	Fri, 22 May 2026 16:55:31 -0600
From: Tim Bird <tim.bird@sony.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.kernel.org,
	horms@kernel.org,
	acme@redhat.com,
	jjschlst@gmail.com
Cc: tim.bird@sony.com,
	netdev@vger.kernel.org,
	linux-spdx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] llc: Add SPDX id lines to some llc source files
Date: Fri, 22 May 2026 16:55:08 -0600
Message-ID: <20260522225508.24006-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.44.127
X-Source-L: No
X-Exim-ID: 1wQYmA-00000002vK2-416T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk.home.local) [66.118.44.127]:33396
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfIUhH/P/xSM91CWBYiirvqDChouCJbuaMb57Sa9taZsHWsaTyeoE+VIoo5lZCPlEUIHH2mJ8iAT7OasrGS0zFpm5oAI2j4MWDPeukmUXNmNRUVQjubCE
 d6xu946bnJuHNBkqf2UeB4Z70FQaTEY50ORlTlrwpLVQVfhgI24T3oIFSniD9atcwobpoXNYu31apSZdFyqrvqLgOlfqLCXAWL8=
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[sony.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290935-lists,netdev=lfdr.de];
	HAS_X_SOURCE(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.bird@sony.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samba.org:email,conectiva.com.br:email]
X-Rspamd-Queue-Id: C39585BB48F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most of the lls source files are missing SPDX-License-Identifier
lines.  Add appropriate IDs to these files, and remove other license
info from the header.  In once case, leave the existing id line
and just remove the license reference text.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 include/linux/llc.h      | 8 +-------
 include/net/llc.h        | 8 +-------
 include/uapi/linux/llc.h | 7 -------
 net/llc/Makefile         | 8 +-------
 net/llc/af_llc.c         | 8 +-------
 net/llc/llc_c_ac.c       | 8 +-------
 net/llc/llc_c_ev.c       | 8 +-------
 net/llc/llc_c_st.c       | 8 +-------
 net/llc/llc_conn.c       | 8 +-------
 net/llc/llc_core.c       | 8 +-------
 net/llc/llc_if.c         | 8 +-------
 net/llc/llc_input.c      | 8 +-------
 net/llc/llc_pdu.c        | 8 +-------
 net/llc/llc_proc.c       | 8 +-------
 net/llc/llc_s_ac.c       | 8 +-------
 net/llc/llc_s_ev.c       | 8 +-------
 net/llc/llc_s_st.c       | 8 +-------
 net/llc/llc_sap.c        | 8 +-------
 net/llc/llc_station.c    | 8 +-------
 19 files changed, 18 insertions(+), 133 deletions(-)

diff --git a/include/linux/llc.h b/include/linux/llc.h
index b965314d017f..944e9e213112 100644
--- a/include/linux/llc.h
+++ b/include/linux/llc.h
@@ -1,14 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * IEEE 802.2 User Interface SAPs for Linux, data structures and indicators.
  *
  * Copyright (c) 2001 by Jay Schulist <jschlst@samba.org>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #ifndef __LINUX_LLC_H
 #define __LINUX_LLC_H
diff --git a/include/net/llc.h b/include/net/llc.h
index e250dca03963..029ba8a22319 100644
--- a/include/net/llc.h
+++ b/include/net/llc.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_H
 #define LLC_H
 /*
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/if.h>
diff --git a/include/uapi/linux/llc.h b/include/uapi/linux/llc.h
index cf8806b14d5f..2ffd81f9cc01 100644
--- a/include/uapi/linux/llc.h
+++ b/include/uapi/linux/llc.h
@@ -3,13 +3,6 @@
  * IEEE 802.2 User Interface SAPs for Linux, data structures and indicators.
  *
  * Copyright (c) 2001 by Jay Schulist <jschlst@samba.org>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #ifndef _UAPI__LINUX_LLC_H
 #define _UAPI__LINUX_LLC_H
diff --git a/net/llc/Makefile b/net/llc/Makefile
index 5e0ef436daae..46b1cd905ffd 100644
--- a/net/llc/Makefile
+++ b/net/llc/Makefile
@@ -1,15 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
 ###########################################################################
 # Makefile for the Linux 802.2 LLC (fully-functional) layer.
 #
 # Copyright (c) 1997 by Procom Technology,Inc.
 #		2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
-#
-# This program can be redistributed or modified under the terms of the
-# GNU General Public License as published by the Free Software Foundation.
-# This program is distributed without any warranty or implied warranty
-# of merchantability or fitness for a particular purpose.
-#
-# See the GNU General Public License for more details.
 ###########################################################################
 
 obj-$(CONFIG_LLC) += llc.o
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 1b210db3119e..e8a418a3a53d 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * af_llc.c - LLC User Interface SAPs
  * Description:
@@ -12,13 +13,6 @@
  *
  * Copyright (c) 2001 by Jay Schulist <jschlst@samba.org>
  *		 2002-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/compiler.h>
 #include <linux/kernel.h>
diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
index 0779daa8aa8f..efa3e8bf3f07 100644
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_c_ac.c - actions performed during connection state transition.
  *
@@ -9,13 +10,6 @@
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/netdevice.h>
 #include <linux/slab.h>
diff --git a/net/llc/llc_c_ev.c b/net/llc/llc_c_ev.c
index d6627a80cb45..beb2836c7db0 100644
--- a/net/llc/llc_c_ev.c
+++ b/net/llc/llc_c_ev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_c_ev.c - Connection component state transition event qualifiers
  *
@@ -25,13 +26,6 @@
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/netdevice.h>
 #include <net/llc_conn.h>
diff --git a/net/llc/llc_c_st.c b/net/llc/llc_c_st.c
index 1c267db304df..5fbd8d19c6c4 100644
--- a/net/llc/llc_c_st.c
+++ b/net/llc/llc_c_st.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_c_st.c - This module contains state transition of connection component.
  *
@@ -6,13 +7,6 @@
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/types.h>
 #include <net/llc_if.h>
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..e8f427375c68 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_conn.c - Driver routines for connection component.
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/init.h>
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index d73f5414d8ce..5b0f1986bddc 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_core.c - Minimum needed routines for sap handling and module init/exit
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/net/llc/llc_if.c b/net/llc/llc_if.c
index 58a5f419adc6..1514362e613d 100644
--- a/net/llc/llc_if.c
+++ b/net/llc/llc_if.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_if.c - Defines LLC interface to upper layer
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/gfp.h>
 #include <linux/module.h>
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 61b0159b2fbe..8eb3d73c39d1 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_input.c - Minimal input path for LLC
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/netdevice.h>
 #include <linux/slab.h>
diff --git a/net/llc/llc_pdu.c b/net/llc/llc_pdu.c
index 63749dde542f..c1938fa24a3f 100644
--- a/net/llc/llc_pdu.c
+++ b/net/llc/llc_pdu.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_pdu.c - access to PDU internals
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/netdevice.h>
diff --git a/net/llc/llc_proc.c b/net/llc/llc_proc.c
index aa81c67b24a1..4804a08c2490 100644
--- a/net/llc/llc_proc.c
+++ b/net/llc/llc_proc.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * proc_llc.c - proc interface for LLC
  *
  * Copyright (c) 2001 by Jay Schulist <jschlst@samba.org>
  *		 2002-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/init.h>
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 7a0cae9a8111..98deee560373 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_s_ac.c - actions performed during sap state transition.
  *
@@ -9,13 +10,6 @@
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/netdevice.h>
diff --git a/net/llc/llc_s_ev.c b/net/llc/llc_s_ev.c
index a74d2a1d6581..cfbecba589e7 100644
--- a/net/llc/llc_s_ev.c
+++ b/net/llc/llc_s_ev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_s_ev.c - Defines SAP component events
  *
@@ -6,13 +7,6 @@
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/socket.h>
 #include <net/sock.h>
diff --git a/net/llc/llc_s_st.c b/net/llc/llc_s_st.c
index acccc827c562..e14d4f520327 100644
--- a/net/llc/llc_s_st.c
+++ b/net/llc/llc_s_st.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_s_st.c - Defines SAP component state machine transitions.
  *
@@ -6,13 +7,6 @@
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/types.h>
 #include <net/llc_if.h>
diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 6cd03c2ae7d5..1bd446a21092 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_sap.c - driver routines for SAP component.
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <net/llc.h>
diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index f50654292510..77fd0ac75263 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * llc_station.c - station component of LLC
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.43.0


