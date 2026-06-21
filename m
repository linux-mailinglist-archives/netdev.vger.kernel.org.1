Return-Path: <netdev+bounces-300876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jn2+D5XFN2pOSwcAu9opvQ
	(envelope-from <netdev+bounces-300876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 13:05:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD86AAA21
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 13:05:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T6TiNyPI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300876-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300876-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D13C3009B13
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EAB287247;
	Sun, 21 Jun 2026 11:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6627A12F
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 11:05:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782039954; cv=pass; b=a4EgTtv6DhLko3lR342uBT3wW7QfK6rcJlEgvcodpHBKvvX5fpmCueODjubCmkPYZmunJ3AU8874dAKbs2ZBIvgWJY/CmWaMPhIH/KtnvQxA1m3yWxy8+kvo09fVTJ08dMyYb9etHjzKLXv5Save3ZIINnNYQj8pjCtJ8SDM22Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782039954; c=relaxed/simple;
	bh=kOEMh6X7ceoGnQlWoDq9LGklXWgaG3j/PzHHnb8zeRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs3ZW9NsJpfQy6uPdFp3WiNzXyh/6ViNJFRwsZLWLfIVRKoVsnXeiDBeWTmObVbb9tlr7Upm/JMOsy2TmpsqlOjNtzmcUtgbEjh6FIXIKaeIDZm9Yl6kPviMYCF/8HZwBFKCAvx8p+JoxknFWhlogoH0zWnNKPpfL4guDum1wFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6TiNyPI; arc=pass smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf887de87so39314436d6.0
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 04:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782039952; cv=none;
        d=google.com; s=arc-20240605;
        b=guJ/t+Phv2yrwKs09u885DCxPMbRrqo+V7hbRKXR/6lbuunRPzyhBu5VRP1QOtqMr8
         f4OwUjX9e6sCU4fJ1ePYHlCHpLojwcUAjFJu1chaFc6rmOam79O7tGnGcbIm7DaOYYys
         89X5hED/SNmYxROcKXmkO10GHCLKKNL0KbLftPorZQYzDUQBwSZtkxFav7GAUeXeZFPp
         ITIxED8L2YzDivpjjsZcdREYW9ChvNR+eiQZg2gevfuyzQkcyNP/+auysMsmJTBZtQOf
         vRVpWa1ufGwu0cOjUIcR2KRb3kdbj2iXgeCF+EupBVecXeuVCOa+rYfXQ8O/zZtRIF7K
         DagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Al7HrqITtp0ImFEcpZU7zjljRwPRCpAkxys5/BPJBBs=;
        fh=7JOo7v5ywQBk/KKhkjB9Hc82kRG9OeJRKDY7454oGL4=;
        b=kl137tKkRwxvnjpPDRwoEynn5Qk/6WEf+6XfLTtxMvSupSipKaya8WpGicczf8hh02
         icjYcq5N/6O/G1LLRwyhrNor98DWxk3qtzsOPNfo9aqLUHDS/JQaXt1jcad6YXmPX+mJ
         qg6i1Kaa3uJBvuGz5m7pXoCGniiNN+dty4ShwvBOoa9hwRtgm+EieINUmapb5lKAkQni
         Fj34cjBIXQSbDzDDWPWWrKMdBk2n6PcvzZyO3S+SaIZJvivZVMoE7WbCx9otZlMcZHve
         zBvynOAhQ6DAQB8+jCG4axPXAreTWdp7FFwi3NLGUMPWkpNhrOt+CAK+8+QvQ8HvRetC
         RiAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782039952; x=1782644752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Al7HrqITtp0ImFEcpZU7zjljRwPRCpAkxys5/BPJBBs=;
        b=T6TiNyPIppuQXf3sfqrwAUKF8OPgZfF/h+bZNahvu9VSAr67OdC1ly83C7Qsb0it+v
         qPenWE9b6J1zUsOlVDRKdiHrUpeJ+kzWTLT3Y3U35btIxwRlc0BwGerPx4UkvmRGccQ2
         738Pc4NRhzEgGP7Zj9ltuoIAxO6gkC4deKuzkh6ynmJjRwQL8xWj0Nx06v/9EKYRMlLE
         oF2Z4aChzj8XzbBvykoc3VzvLKfgJQ3EL4R8HGHX2U+aOwAGA7o2ugmX90WBC3al4jW9
         uT5Xm17XatpFf3pDS8xeEagGvuLbxQmkBEKT/EcipNwP/3ZxZJPUKjA23bxYpuyBmc+4
         Mrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782039952; x=1782644752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al7HrqITtp0ImFEcpZU7zjljRwPRCpAkxys5/BPJBBs=;
        b=NPunx4Z6GsNY0jGMd7DhDLgiZyfFKbsQgUbirBinUocUMc1NRJTeltTUrbMxLQO3vT
         4gJ/4X8TRPtKnyU4Q1ba11aY4ErsmKYIsEmff4qMPtIPqvTpfTg30JSpRluv4+yMq9S8
         WVi6/vWQB+QzPOcWZOf2UsCq3qddXJXYnWbbX6zWSYXtbqUyrwRKEvVZwk87s4aMhx7O
         37hU3GxoOD8EDgrsBL0KTTlvIQ5ti4ndCOweoUUFLfY6a4/WCEd2VaGkxiBnBovM7FF2
         poC6lZnaHgue9b5BdwZVRq8WlvknIHnFwPeeNGkHJWt7jYeuPkiJH5eSRbeqUgbw6nOx
         3+xg==
X-Forwarded-Encrypted: i=1; AHgh+RrrzrFITvOAXM8qQ4/NLf8lpSxnl2HnGBgpSdg0cYCMN9zqQvNhDuQ6wjwEnDk8qXS7QOOFs+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRCVwIo8TejrL0/rFQtt8TxtJCclu45ya56fM+Guxl6Sa4/7n
	+qPo9mNpiaR0H7QAssmxwOMMuSxohGbqMQBW20owvJLhdd5be0gxfRNfPp3ZM/a1+KA294cmDlf
	FQBZWUVJzcdY4MZNKSZ0sGX/bJiZRsYuGOOikJ1A=
X-Gm-Gg: AfdE7ckeK7szG97SstHwgIbjsOo9TPB0SP1MGt7dMakEA5XSC8uMSWbU6lbOwGV3iVP
	9/QZJAmK5ZsG++2GWTxnhFUPB+hNF6D5vJFyEMaLsbfsHrGwGIgOLGL2fIbGqbfUf04R6DXN+1Z
	N6Xp2ZyrEVOBXhpfJOo+yDHoxN86nih9O6JL6vN4N7cC4Sduc3AiSRU5UkUmrvMp2CZJwLM07UK
	i4HHaKOPb3YgA0ShZL0uAz1g7GGUFN4gLjaXybvvRcn8qqPDBGoUtYgsnQBE6pv1GkoPQ465A==
X-Received: by 2002:a05:6214:1302:b0:8d0:b39c:50bd with SMTP id
 6a1803df08f44-8dea12b6d2amr174095676d6.3.1782039951681; Sun, 21 Jun 2026
 04:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
In-Reply-To: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
From: Alex Goltsev <sasha.goltsev777@gmail.com>
Date: Sun, 21 Jun 2026 14:05:40 +0300
X-Gm-Features: AVVi8CeXUehdkjHrB6-kIHlN7uht40jB7BvC19H2TvhP0AQfc3pIo1wdkmmuol0
Message-ID: <CAEKmD4K-v_srabQDJCfqaqA6vssk-Hg-mLHEdTsphTBLmQVjnw@mail.gmail.com>
Subject: Re: [PATCH v2] net: add sock_open() with flags for socket creation
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viro@zeniv.linux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300876-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98BD86AAA21

From a9316957e594708dfb4258ad968fe88666c9b736 Mon Sep 17 00:00:00 2001
From: 0-x-0-0 <sasha.goltsev777@gmail.com>
Date: Sun, 21 Jun 2026 13:24:29 +0300
Subject: [PATCH v2] net: add sock_open() with flags for socket creation

---
Changes in V2:
- Replaced the use of plain integer constants for flags with proper
enums to improve readability and type safety.
- `sock_open` is intentionally left as a regular exported symbol rather
than being moved to a header as `static inline`. This is because it
dereferences `current->nsproxy->net_ns`, which would require pulling
in heavy headers like <linux/sched.h> and <linux/nsproxy.h> into the
already widely-used <linux/net.h>, causing unnecessary header bloat
and potential circular dependencies.
- Introduced two new creation flags for specialized use cases within
kernel modules:

* SOCK_CREATE_NOLSM: This flag allows a kernel module to bypass
LSM hooks during socket creation. This
enables a micro-optimization for kernel-internal sockets where
the security check is known *a priori* to be a no-op (e.g., for
specific configurations or high-performance paths).
This is safe because the API is restricted to in-kernel (LKM)
contexts only, and does not weaken the security boundary for
user-triggered socket creation.

* SOCK_CREATE_NOWARN: This flag suppresses the standard warning
messages on creation failure. This is useful for callers in the
kernel that probe for protocol support and handle the error
gracefully, without wanting to pollute the kernel log with
misleading warnings.

Signed-off-by: Alexander Goltsev <sasha.goltsev777@gmail.com>
---
include/linux/net.h | 22 ++++++++
net/socket.c | 133 +++++++++++++++++++++++++++++++++++++-------
2 files changed, 134 insertions(+), 21 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index f268f395c..6367c00db 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -116,6 +116,22 @@ enum sock_shutdown_cmd {
SHUT_RDWR,
};
+/**
+ * enum sock_create_flags - socket creation flags
+ * @SOCK_CREATE_KERN: creates a kernel socket
+ * @SOCK_CREATE_USER: creates a regular socket
+ * @SOCK_CREATE_LITE: creates a lite socket
+ * @SOCK_CREATE_NOLSM: disables LSM
+ * @SOCK_CREATE_NOWARN: disables warning
+ */
+enum sock_create_flags {
+ SOCK_CREATE_KERN = BIT(0),
+ SOCK_CREATE_USER = BIT(1),
+ SOCK_CREATE_LITE = BIT(2),
+ SOCK_CREATE_NOLSM = BIT(3),
+ SOCK_CREATE_NOWARN = BIT(4),
+};
+
struct socket_wq {
/* Note: wait MUST be first field of socket_wq */
wait_queue_head_t wait;
@@ -275,6 +291,12 @@ void sock_unregister(int family);
bool sock_is_registered(int family);
int __sock_create(struct net *net, int family, int type, int proto,
struct socket **res, int kern);
+int __sock_create_flags(struct net *net, int family, int type, int protocol,
+ struct socket **res, int kern, int flags);
+int __sock_create_lite_flags(int family, int type, int protocol,
+ struct socket **res, int flags);
+int sock_open(struct net *net, int family,
+ int type, int protocol, struct socket **res, int flags);
int sock_create(int family, int type, int proto, struct socket **res);
int sock_create_kern(struct net *net, int family, int type, int proto,
struct socket **res);
int sock_create_lite(int family, int type, int proto, struct socket **res);
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa..2359fd5bf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1425,26 +1425,28 @@ static long sock_ioctl(struct file *file,
unsigned cmd, unsigned long arg)
}
/**
- * sock_create_lite - creates a socket
+ * __sock_create_lite_flags - creates a socket (with flags)
* @family: protocol family (AF_INET, ...)
* @type: communication type (SOCK_STREAM, ...)
* @protocol: protocol (0, ...)
* @res: new socket
+ * @flags: defines socket creation flags
*
* Creates a new socket and assigns it to @res, passing through LSM.
* The new socket initialization is not complete, see kernel_accept().
* Returns 0 or an error. On failure @res is set to %NULL.
* This function internally uses GFP_KERNEL.
*/
-
-int sock_create_lite(int family, int type, int protocol, struct socket **res)
+int __sock_create_lite_flags(int family, int type, int protocol,
struct socket **res, int flags)
{
int err;
struct socket *sock = NULL;
- err = security_socket_create(family, type, protocol, 1);
- if (err)
- goto out;
+ if (!(flags & SOCK_CREATE_NOLSM)) {
+ err = security_socket_create(family, type, protocol, 1);
+ if (err)
+ goto out;
+ }
sock = sock_alloc();
if (!sock) {
@@ -1453,9 +1455,11 @@ int sock_create_lite(int family, int type, int
protocol, struct socket **res)
}
sock->type = type;
- err = security_socket_post_create(sock, family, type, protocol, 1);
- if (err)
- goto out_release;
+ if (!(flags & SOCK_CREATE_NOLSM)) {
+ err = security_socket_post_create(sock, family, type, protocol, 1);
+ if (err)
+ goto out_release;
+ }
out:
*res = sock;
@@ -1465,6 +1469,25 @@ int sock_create_lite(int family, int type, int
protocol, struct socket **res)
sock = NULL;
goto out;
}
+EXPORT_SYMBOL(__sock_create_lite_flags);
+
+/**
+ * sock_create_lite - creates a socket
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ * The new socket initialization is not complete, see kernel_accept().
+ * Returns 0 or an error. On failure @res is set to %NULL.
+ * This function internally uses GFP_KERNEL.
+ */
+
+int sock_create_lite(int family, int type, int protocol, struct socket **res)
+{
+ return __sock_create_lite_flags(family, type, protocol, res, 0);
+}
EXPORT_SYMBOL(sock_create_lite);
/* No kernel lock held - perfect */
@@ -1563,22 +1586,23 @@ int sock_wake_async(struct socket_wq *wq, int
how, int band)
EXPORT_SYMBOL(sock_wake_async);
/**
- * __sock_create - creates a socket
+ * __sock_create_flags - creates a socket (with flags)
* @net: net namespace
* @family: protocol family (AF_INET, ...)
* @type: communication type (SOCK_STREAM, ...)
* @protocol: protocol (0, ...)
* @res: new socket
* @kern: boolean for kernel space sockets
+ * @flags: defines socket creation flags
*
* Creates a new socket and assigns it to @res, passing through LSM.
* Returns 0 or an error. On failure @res is set to %NULL. @kern must
* be set to true if the socket resides in kernel space.
* This function internally uses GFP_KERNEL.
*/
-
-int __sock_create(struct net *net, int family, int type, int protocol,
- struct socket **res, int kern)
+int __sock_create_flags(struct net *net, int family,
+ int type, int protocol, struct socket **res,
+ int kern, int flags)
{
int err;
struct socket *sock;
@@ -1598,14 +1622,18 @@ int __sock_create(struct net *net, int family,
int type, int protocol,
deadlock in module load.
*/
if (family == PF_INET && type == SOCK_PACKET) {
- pr_info_once("%s uses obsolete (PF_INET,SOCK_PACKET)\n",
+ if (!(flags & SOCK_CREATE_NOWARN)) {
+ pr_info_once("%s uses obsolete (PF_INET,SOCK_PACKET)\n",
current->comm);
+ }
family = PF_PACKET;
}
- err = security_socket_create(family, type, protocol, kern);
- if (err)
- return err;
+ if (!(flags & SOCK_CREATE_NOLSM)) {
+ err = security_socket_create(family, type, protocol, kern);
+ if (err)
+ return err;
+ }
/*
* Allocate the socket and allow the family to set things up. if
@@ -1614,7 +1642,8 @@ int __sock_create(struct net *net, int family,
int type, int protocol,
*/
sock = sock_alloc();
if (!sock) {
- net_warn_ratelimited("socket: no more sockets\n");
+ if (!(flags & SOCK_CREATE_NOWARN))
+ net_warn_ratelimited("socket: no more sockets\n");
return -ENFILE; /* Not exactly a match, but its the
closest posix thing */
}
@@ -1671,9 +1700,12 @@ int __sock_create(struct net *net, int family,
int type, int protocol,
* module can have its refcnt decremented
*/
module_put(pf->owner);
- err = security_socket_post_create(sock, family, type, protocol, kern);
- if (err)
- goto out_sock_release;
+
+ if (!(flags & SOCK_CREATE_NOLSM)) {
+ err = security_socket_post_create(sock, family, type, protocol, kern);
+ if (err)
+ goto out_sock_release;
+ }
*res = sock;
return 0;
@@ -1691,6 +1723,28 @@ int __sock_create(struct net *net, int family,
int type, int protocol,
rcu_read_unlock();
goto out_sock_release;
}
+EXPORT_SYMBOL(__sock_create_flags);
+
+/**
+ * __sock_create - creates a socket
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ * @kern: boolean for kernel space sockets
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ * Returns 0 or an error. On failure @res is set to %NULL. @kern must
+ * be set to true if the socket resides in kernel space.
+ * This function internally uses GFP_KERNEL.
+ */
+
+int __sock_create(struct net *net, int family, int type, int protocol,
+ struct socket **res, int kern)
+{
+ return __sock_create_flags(net, family, type, protocol, res, kern, 0);
+}
EXPORT_SYMBOL(__sock_create);
/**
@@ -1710,6 +1764,43 @@ int sock_create(int family, int type, int
protocol, struct socket **res)
}
EXPORT_SYMBOL(sock_create);
+/**
+ * sock_open - creates a socket (with flags)
+ * @net: net namespace (may be NULL in non-SOCK_CREATE_KERN modes)
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ * @flags: socket creation flags
+ *
+ * Unified entry point for socket creation with flags.
+ * Returns 0 or an error. This function internally uses GFP_KERNEL.
+ */
+int sock_open(struct net *net, int family,
+ int type, int protocol, struct socket **res,
+ int flags)
+{
+ int type_bits = flags & (SOCK_CREATE_KERN | SOCK_CREATE_USER |
SOCK_CREATE_LITE);
+ int optional_flags = flags & ~(SOCK_CREATE_KERN | SOCK_CREATE_USER |
SOCK_CREATE_LITE);
+
+ if (type_bits == 0 || (type_bits & (type_bits - 1)) != 0)
+ return -EINVAL;
+
+ if (optional_flags & ~(SOCK_CREATE_NOLSM | SOCK_CREATE_NOWARN))
+ return -EINVAL;
+
+ switch (type_bits) {
+ case SOCK_CREATE_KERN: return __sock_create_flags(net, family, type, protocol,
+ res, 1, optional_flags);
+ case SOCK_CREATE_USER: return __sock_create_flags(current->nsproxy->net_ns,
+ family, type, protocol, res, 0, optional_flags);
+ case SOCK_CREATE_LITE: return __sock_create_lite_flags(family,
+ type, protocol, res, optional_flags);
+ default: return -EINVAL;
+ }
+}
+EXPORT_SYMBOL(sock_open);
+
/**
* sock_create_kern - creates a socket (kernel space)
* @net: net namespace
-- 
2.47.3

