Return-Path: <netdev+bounces-255169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOeDLF/HfGnaOgIAu9opvQ
	(envelope-from <netdev+bounces-255169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:59:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076ABBD45
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A4B30327E0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4732938D;
	Fri, 30 Jan 2026 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="SRBhcykL"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-g125.zoho.com (sender4-pp-g125.zoho.com [136.143.188.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C654303C9F;
	Fri, 30 Jan 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784779; cv=pass; b=qRdfNU7yNV+r0t2fwSEQW0ruyQSzdA6uO53QhnNe/pku4RsvrPDTiC34y07buZuyBzqQXHZ4Ryy/aFqsS6C+PSqeWqUa6IWJ8apoF9zZXfB+X+SMlnIPGKQmzKFgmWszkatOX5cRcTN2kRuNhoMtgzHj2hfOjhNkN0bOWtxOBB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784779; c=relaxed/simple;
	bh=41ZSw8e/e5f/AuqeCxVE2oTQbqIo+4zi3gJPu89fVgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9ZxdAvRdAOcIkbMyJIBpZ5oeMQz96exSpkz+SurF6qrMpqpOcnenl3r8X9oZe07/Uf0jc3ogO9syz6jsupqZ12MCCfXQWWGR+oIJz3PsT00kHjhGmE0VFW8ENWtkrxaWb+8SOJYU/bZT9gvTmcO6iBdBChQwcmtsGo4WGD8eoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=SRBhcykL; arc=pass smtp.client-ip=136.143.188.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1769784720; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lo3kwHp0jF3jjdfnzFC/JNibTZag0oNVgjbwbRUQZLU9vCynlluDt44DHI2kLU7aVNn2LMh7TnN94TwBkKaU3UqSU+XmcuQDZba2jrZTjOuNi4SY0sj6tgGkLQNylcvvgESMgLANJKh/IasCWZ+NnVsRaP5ZY/YAErbEoGwPnlM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769784720; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g30GeD5luz415Zspf8u9IYtmiaQwDaZdE/ttvlyNc/k=; 
	b=m8nPvh9njtD+hMoXBjSVhUYU5p5o9BgUCLxxAC6IzOnqoOG1F6o8QGnC+6XWKBakORMHBDLFM7+qR7oKIJKR3o0oJmeQyx+Wyq6MRYRhIiOQiIa6a0WZzSX+7kPPAxtj5B7GScNyrINa1P/N+Gw0CBevsioKnqwCEYMOMXZ/4n0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769784720;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=g30GeD5luz415Zspf8u9IYtmiaQwDaZdE/ttvlyNc/k=;
	b=SRBhcykLjLSun/HHplWgjobxH70QpCOxNnIB0DaWK5iZEO87zOwRxq54q8nyP2jx
	XoHxEUvMJqbdI9x8JxfKq6C7wU84zHuW/+iGhgbIyQRHralNG+Vndzb1oQNEUZGhII6
	2eLU4e0KbIMr5dvuwlU2SX7498WOIsToXjII5Nu8=
Received: by mx.zohomail.com with SMTPS id 176978471899844.65970746766061;
	Fri, 30 Jan 2026 06:51:58 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	Frank van der Linden <fvdl@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v1 3/3] liveupdate: suppress TCP RST during post-kexec restore window
Date: Fri, 30 Jan 2026 22:51:19 +0800
Message-ID: <20260130145122.368748-4-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145122.368748-1-me@linux.beauty>
References: <20260130145122.368748-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[linux.beauty:email,linux.beauty:dkim,linux.beauty:mid];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux.beauty];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lwn.net,soleen.com,kernel.org,google.com,davemloft.net,redhat.com,linux-foundation.org,alien8.de,infradead.org,linux.intel.com,suse.com,linux.alibaba.com,baidu.com,arndb.de,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux.beauty:s=zmail];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,netdev@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[netdev];
	TAGGED_FROM(0.00)[bounces-255169-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.900];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.beauty:email,linux.beauty:dkim,linux.beauty:mid]
X-Rspamd-Queue-Id: 6076ABBD45
X-Rspamd-Action: add header
X-Spam: Yes

During a kexec-based live update, userspace may restore established TCP
connections after the new kernel has booted (e.g. via CRIU). Any packet
arriving for a not-yet-restored socket will hit the no-socket path and
trigger a TCP RST, causing the peer to immediately drop the connection.
Add an optional cmdline knob, liveupdate_tcp_rst_suppress=, to drop such
packets while liveupdate_restore_in_progress() is true. Only segments
with ACK set and SYN clear are dropped, and the default behavior remains
unchanged.
Document the liveupdate_tcp_rst_suppress cmdline parameter.

Signed-off-by: Li Chen <me@linux.beauty>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 include/linux/liveupdate.h                      | 11 +++++++++++
 kernel/liveupdate/luo_core.c                    | 14 ++++++++++++++
 kernel/liveupdate/luo_session.c                 |  1 +
 net/ipv4/tcp_ipv4.c                             |  5 +++++
 net/ipv6/tcp_ipv6.c                             |  5 +++++
 6 files changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3097e4266d76..b73347a0aefd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3442,6 +3442,16 @@ Kernel parameters
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
+	liveupdate_tcp_rst_suppress=	[KNL,EARLY]
+			Format: <bool>
+			When enabled, drop packets for established connections
+			(ACK set, SYN clear) that would otherwise trigger a RST
+			in the LUO post-kexec restore window.
+			This is useful when userspace restores sockets after
+			kexec (e.g. via CRIU).
+			Requires liveupdate=on.
+			Default: off.
+
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 301d3e94516e..6ca740ec19d4 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -227,6 +227,12 @@ bool liveupdate_enabled(void);
  */
 bool liveupdate_restore_in_progress(void);
 
+/*
+ * Return true when TCP RST suppression is enabled for the post-kexec restore
+ * window.
+ */
+bool liveupdate_tcp_rst_suppress_enabled(void);
+
 /* Called during kexec to tell LUO that entered into reboot */
 int liveupdate_reboot(void);
 
@@ -253,6 +259,11 @@ static inline bool liveupdate_restore_in_progress(void)
 	return false;
 }
 
+static inline bool liveupdate_tcp_rst_suppress_enabled(void)
+{
+	return false;
+}
+
 static inline int liveupdate_reboot(void)
 {
 	return 0;
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index fb6a73c08979..0ed5c9ce1421 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -64,6 +64,7 @@
 
 static struct {
 	bool enabled;
+	bool tcp_rst_suppress;
 	void *fdt_out;
 	void *fdt_in;
 	u64 liveupdate_num;
@@ -75,6 +76,13 @@ static int __init early_liveupdate_param(char *buf)
 }
 early_param("liveupdate", early_liveupdate_param);
 
+static int __init early_liveupdate_tcp_rst_suppress_param(char *buf)
+{
+	return kstrtobool(buf, &luo_global.tcp_rst_suppress);
+}
+early_param("liveupdate_tcp_rst_suppress",
+	    early_liveupdate_tcp_rst_suppress_param);
+
 static int __init luo_early_startup(void)
 {
 	phys_addr_t fdt_phys;
@@ -259,6 +267,12 @@ bool liveupdate_enabled(void)
 	return luo_global.enabled;
 }
 
+bool liveupdate_tcp_rst_suppress_enabled(void)
+{
+	return liveupdate_enabled() && luo_global.tcp_rst_suppress;
+}
+EXPORT_SYMBOL_GPL(liveupdate_tcp_rst_suppress_enabled);
+
 /**
  * DOC: LUO ioctl Interface
  *
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 2c7dd3b12303..427ae74061ba 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -146,6 +146,7 @@ bool liveupdate_restore_in_progress(void)
 {
 	return atomic_long_read(&liveupdate_incoming_sessions_left) > 0;
 }
+EXPORT_SYMBOL_GPL(liveupdate_restore_in_progress);
 
 void __init luo_session_restore_window_init(void)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f8a9596e8f4d..9a95f3dbf39a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -56,6 +56,7 @@
 #include <linux/fips.h>
 #include <linux/jhash.h>
 #include <linux/init.h>
+#include <linux/liveupdate.h>
 #include <linux/times.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -2349,6 +2350,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
+		if (liveupdate_tcp_rst_suppress_enabled() &&
+		    liveupdate_restore_in_progress() &&
+		    th->ack && !th->syn)
+			goto discard_it;
 		tcp_v4_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 280fe5978559..c2e680eba041 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -40,6 +40,7 @@
 #include <linux/icmpv6.h>
 #include <linux/random.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/liveupdate.h>
 
 #include <net/aligned_data.h>
 #include <net/tcp.h>
@@ -1900,6 +1901,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
+		if (liveupdate_tcp_rst_suppress_enabled() &&
+		    liveupdate_restore_in_progress() &&
+		    th->ack && !th->syn)
+			goto discard_it;
 		tcp_v6_send_reset(NULL, skb, sk_rst_convert_drop_reason(drop_reason));
 	}
 
-- 
2.52.0


