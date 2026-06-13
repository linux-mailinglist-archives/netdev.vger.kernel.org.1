Return-Path: <netdev+bounces-299034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 81x4JGW5LWppjAQAu9opvQ
	(envelope-from <netdev+bounces-299034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616C67F96F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RJbO6NkM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299034-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299034-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D1723004F31
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7423612F3;
	Sat, 13 Jun 2026 20:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3159396D0D
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381448; cv=none; b=TyssClC3cmghXeYTlpwlPwbx9xK3DkYRFmVwbP9OQpFflfCltUYL3OeeAGF0TDtotAsbk/Y7Kp8Er6s2z6NHl70X0E6Uyk0mdY02yt8Fey4fCr/YIF403TX22P73a6rlepJXyd7S8SVWRQT39kE0qVjW1sxWhTugmzjoEwmAx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381448; c=relaxed/simple;
	bh=CXQDYh4ycErZfraNowMpHBgvLgZ+zmBOjghFjjpGv88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g56gs6FfIR2Oi4GVjBCikAZe1YIyZu4LgIb3bPwSKqAklxrOg49/BbOyLOvE9vPKYeCb3xToCygmtcvepyVjjYs3KIQYZlzwd+kzwYO0udtqkJLMDisnii1rC5e4F74xz2oTQzGaK1AIy1b6FBEYWoEbX4HPsP09w7u7rl9nl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJbO6NkM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD021F000E9;
	Sat, 13 Jun 2026 20:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381445;
	bh=9lSatJJYLu7mU8+GS0trc3OSTfD0BG/jdJe9njeZD5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RJbO6NkMzls05Q6geITm8CoTh05Uwxuj+uhmg8ysM6LlKO5qEAxLlk9JJiea5f8GB
	 UJu15yxACowjlEv8VR2k1cthc3G21nBKYc0txTV8PpebJlDt0PMgkHaHXE6b+L1rBG
	 /62R8DGvCkeslhu3cwsCsvHIi5yow76teTS+DxeHFzx6WrF0XJOPIFnoj6Ik0micpx
	 L2uwfwQ2XqaIDs0rE6LNgv5p8x9MJoK+uPG/2PwnJD6L50YaD3rsx5DH04GJRZfC0l
	 m2FvSIGV3OIJ1rDwGlRt0FasUDXFUF8kSTnrVJAlWt7okubPyVVeVBm3zRcDdl4hzo
	 M3VJmTuUEJJUw==
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
Subject: [PATCH net-next 5/9] atm: remove SVC socket support and the signaling daemon interface
Date: Sat, 13 Jun 2026 13:10:28 -0700
Message-ID: <20260613201032.77274-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299034-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2616C67F96F

ATM switched virtual circuits (SVCs) are set up and torn down by a
user-space signaling daemon (atmsigd) which the kernel talks to over
a dedicated "sigd" socket: the kernel marshals Q.2931-style requests
(as_connect, as_listen, as_accept, as_close, ...) to the daemon and
applies the results to PF_ATMSVC sockets. This is the machinery behind
classical SVC use and was the foundation for LANE / MPOA, all of which
have been removed.

DSL deployments do not use any of this. PPPoATM and BR2684 run over
permanent virtual circuits (PF_ATMPVC) with a statically configured
VPI/VCI; no atmsigd, no Q.2931. Neither remaining ATM driver
(solos-pci, the USB DSL modems) is reachable through the SVC path.

Remove the SVC socket family and the signaling interface:

 - delete net/atm/svc.c, net/atm/signaling.c and signaling.h
 - drop atmsvc_init()/atmsvc_exit() and the PF_ATMSVC registration and
   module alias
 - drop the ATMSIGD_CTRL ioctl (sigd_attach) and the /proc/net/atm/svc
   file
 - fold the SVC branch out of atm_change_qos(); all sockets are PVCs now

The obsolete ATM_SETSC ioctl stub is left in place (it already just
warns and returns 0), as is the struct atm_vcc SVC bookkeeping shared
with the queueing layer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/atm/Makefile       |   2 +-
 include/linux/atmdev.h |  38 +--
 net/atm/common.h       |   5 -
 net/atm/signaling.h    |  31 --
 net/atm/br2684.c       |   3 +-
 net/atm/common.c       |  35 +--
 net/atm/ioctl.c        |  32 --
 net/atm/pppoatm.c      |   3 +-
 net/atm/proc.c         |  56 ----
 net/atm/resources.c    |   1 -
 net/atm/signaling.c    | 297 ------------------
 net/atm/svc.c          | 694 -----------------------------------------
 12 files changed, 12 insertions(+), 1185 deletions(-)
 delete mode 100644 net/atm/signaling.h
 delete mode 100644 net/atm/signaling.c
 delete mode 100644 net/atm/svc.c

diff --git a/net/atm/Makefile b/net/atm/Makefile
index 5ed48d50df35..0a14ea7d4683 100644
--- a/net/atm/Makefile
+++ b/net/atm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the ATM Protocol Families.
 #
 
-atm-y		:= pvc.o signaling.o svc.o ioctl.o common.o atm_misc.o raw.o resources.o atm_sysfs.o
+atm-y		:= pvc.o ioctl.o common.o atm_misc.o raw.o resources.o atm_sysfs.o
 
 obj-$(CONFIG_ATM) += atm.o
 obj-$(CONFIG_ATM_BR2684) += br2684.o
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 7abbd23fada6..59477676063c 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -51,33 +51,11 @@ enum {
 				   driver, cleared by anybody. */
 	ATM_VF_PARTIAL,		/* resources are bound to PVC (partial PVC
 				   setup), controlled by socket layer */
-	ATM_VF_REGIS,		/* registered with demon, controlled by SVC
-				   socket layer */
-	ATM_VF_BOUND,		/* local SAP is set, controlled by SVC socket
-				   layer */
-	ATM_VF_RELEASED,	/* demon has indicated/requested release,
-				   controlled by SVC socket layer */
 	ATM_VF_HASQOS,		/* QOS parameters have been set */
-	ATM_VF_LISTEN,		/* socket is used for listening */
-	ATM_VF_META,		/* SVC socket isn't used for normal data
-				   traffic and doesn't depend on signaling
-				   to be available */
-	ATM_VF_SESSION,		/* VCC is p2mp session control descriptor */
-	ATM_VF_HASSAP,		/* SAP has been set */
-	ATM_VF_CLOSE,		/* asynchronous close - treat like VF_RELEASED*/
-	ATM_VF_WAITING,		/* waiting for reply from sigd */
-	ATM_VF_IS_CLIP,		/* in use by CLIP protocol */
+	ATM_VF_CLOSE,		/* asynchronous close - VC is being torn down */
 };
 
 
-#define ATM_VF2VS(flags) \
-    (test_bit(ATM_VF_READY,&(flags)) ? ATM_VS_CONNECTED : \
-     test_bit(ATM_VF_RELEASED,&(flags)) ? ATM_VS_CLOSING : \
-     test_bit(ATM_VF_LISTEN,&(flags)) ? ATM_VS_LISTEN : \
-     test_bit(ATM_VF_REGIS,&(flags)) ? ATM_VS_INUSE : \
-     test_bit(ATM_VF_BOUND,&(flags)) ? ATM_VS_BOUND : ATM_VS_IDLE)
-
-
 enum {
 	ATM_DF_REMOVED,		/* device was removed from atm_devs list */
 };
@@ -100,7 +78,6 @@ struct atm_vcc {
 	unsigned long	atm_options;	/* ATM layer options */
 	struct atm_dev	*dev;		/* device back pointer */
 	struct atm_qos	qos;		/* QOS */
-	struct atm_sap	sap;		/* SAP */
 	void (*release_cb)(struct atm_vcc *vcc); /* release_sock callback */
 	void (*push)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void (*pop)(struct atm_vcc *vcc,struct sk_buff *skb); /* optional */
@@ -109,16 +86,8 @@ struct atm_vcc {
 	void		*proto_data;	/* per-protocol data */
 	struct k_atm_aal_stats *stats;	/* pointer to AAL stats group */
 	struct module *owner;		/* owner of ->push function */
-	/* SVC part --- may move later ------------------------------------- */
-	short		itf;		/* interface number */
-	struct sockaddr_atmsvc local;
-	struct sockaddr_atmsvc remote;
-	/* Multipoint part ------------------------------------------------- */
-	struct atm_vcc	*session;	/* session VCC descriptor */
-	/* Other stuff ----------------------------------------------------- */
-	void		*user_back;	/* user backlink - not touched by */
-					/* native ATM stack. Currently used */
-					/* by CLIP and sch_atm. */
+	void		*user_back;	/* user backlink - not touched by the */
+					/* native ATM stack, used by sch_atm */
 };
 
 static inline struct atm_vcc *atm_sk(struct sock *sk)
@@ -151,7 +120,6 @@ struct atm_dev {
 	char		signal;		/* signal status (ATM_PHY_SIG_*) */
 	int		link_rate;	/* link rate (default: OC3) */
 	refcount_t	refcnt;		/* reference count */
-	spinlock_t	lock;		/* protect internal members */
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *proc_entry; /* proc entry */
 	char *proc_name;		/* proc entry name */
diff --git a/net/atm/common.h b/net/atm/common.h
index ae4502abf028..11cb51dd7dbb 100644
--- a/net/atm/common.h
+++ b/net/atm/common.h
@@ -28,8 +28,6 @@ void vcc_process_recv_queue(struct atm_vcc *vcc);
 
 int atmpvc_init(void);
 void atmpvc_exit(void);
-int atmsvc_init(void);
-void atmsvc_exit(void);
 int atm_sysfs_init(void);
 void atm_sysfs_exit(void);
 
@@ -48,9 +46,6 @@ static inline void atm_proc_exit(void)
 }
 #endif /* CONFIG_PROC_FS */
 
-/* SVC */
-int svc_change_qos(struct atm_vcc *vcc,struct atm_qos *qos);
-
 void atm_dev_release_vccs(struct atm_dev *dev);
 
 #endif
diff --git a/net/atm/signaling.h b/net/atm/signaling.h
deleted file mode 100644
index 2df8220f7ab5..000000000000
--- a/net/atm/signaling.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* net/atm/signaling.h - ATM signaling */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#ifndef NET_ATM_SIGNALING_H
-#define NET_ATM_SIGNALING_H
-
-#include <linux/atm.h>
-#include <linux/atmdev.h>
-#include <linux/atmsvc.h>
-
-
-extern struct atm_vcc *sigd; /* needed in svc_release */
-
-
-/*
- * sigd_enq is a wrapper for sigd_enq2, covering the more common cases, and
- * avoiding huge lists of null values.
- */
-
-void sigd_enq2(struct atm_vcc *vcc,enum atmsvc_msg_type type,
-    struct atm_vcc *listen_vcc,const struct sockaddr_atmpvc *pvc,
-    const struct sockaddr_atmsvc *svc,const struct atm_qos *qos,int reply);
-void sigd_enq(struct atm_vcc *vcc,enum atmsvc_msg_type type,
-    struct atm_vcc *listen_vcc,const struct sockaddr_atmpvc *pvc,
-    const struct sockaddr_atmsvc *svc);
-int sigd_attach(struct atm_vcc *vcc);
-
-#endif
diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index 6580d67c3456..05712c28386a 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -311,8 +311,7 @@ static netdev_tx_t br2684_start_xmit(struct sk_buff *skb,
 
 	bh_lock_sock(sk_atm(atmvcc));
 
-	if (test_bit(ATM_VF_RELEASED, &atmvcc->flags) ||
-	    test_bit(ATM_VF_CLOSE, &atmvcc->flags) ||
+	if (test_bit(ATM_VF_CLOSE, &atmvcc->flags) ||
 	    !test_bit(ATM_VF_READY, &atmvcc->flags)) {
 		dev->stats.tx_dropped++;
 		dev_kfree_skb(skb);
diff --git a/net/atm/common.c b/net/atm/common.c
index 7d5b7c39b80b..650814d0a56c 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -30,7 +30,6 @@
 #include "resources.h"		/* atm_find_dev */
 #include "common.h"		/* prototypes */
 #include "protocols.h"		/* atm_init_<transport> */
-#include "signaling.h"		/* for WAITING and sigd_attach */
 
 struct hlist_head vcc_hash[VCC_HTABLE_SIZE];
 EXPORT_SYMBOL(vcc_hash);
@@ -154,8 +153,6 @@ int vcc_create(struct net *net, struct socket *sock, int protocol, int family, i
 
 	vcc = atm_sk(sk);
 	vcc->dev = NULL;
-	memset(&vcc->local, 0, sizeof(struct sockaddr_atmsvc));
-	memset(&vcc->remote, 0, sizeof(struct sockaddr_atmsvc));
 	vcc->qos.txtp.max_sdu = 1 << 16; /* for meta VCs */
 	refcount_set(&sk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 	atomic_set(&sk->sk_rmem_alloc, 0);
@@ -216,7 +213,6 @@ void vcc_release_async(struct atm_vcc *vcc, int reply)
 	set_bit(ATM_VF_CLOSE, &vcc->flags);
 	sk->sk_shutdown |= RCV_SHUTDOWN;
 	sk->sk_err = -reply;
-	clear_bit(ATM_VF_WAITING, &vcc->flags);
 	sk->sk_state_change(sk);
 }
 EXPORT_SYMBOL(vcc_release_async);
@@ -527,8 +523,7 @@ int vcc_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		return -EOPNOTSUPP;
 
 	vcc = ATM_SD(sock);
-	if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
-	    test_bit(ATM_VF_CLOSE, &vcc->flags) ||
+	if (test_bit(ATM_VF_CLOSE, &vcc->flags) ||
 	    !test_bit(ATM_VF_READY, &vcc->flags))
 		return 0;
 
@@ -575,8 +570,7 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 		goto out;
 	}
 	vcc = ATM_SD(sock);
-	if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
-	    test_bit(ATM_VF_CLOSE, &vcc->flags) ||
+	if (test_bit(ATM_VF_CLOSE, &vcc->flags) ||
 	    !test_bit(ATM_VF_READY, &vcc->flags)) {
 		error = -EPIPE;
 		send_sig(SIGPIPE, current, 0);
@@ -604,8 +598,7 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 			error = -ERESTARTSYS;
 			break;
 		}
-		if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
-		    test_bit(ATM_VF_CLOSE, &vcc->flags) ||
+		if (test_bit(ATM_VF_CLOSE, &vcc->flags) ||
 		    !test_bit(ATM_VF_READY, &vcc->flags)) {
 			error = -EPIPE;
 			send_sig(SIGPIPE, current, 0);
@@ -665,8 +658,7 @@ __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
 	if (sk->sk_err)
 		mask = EPOLLERR;
 
-	if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
-	    test_bit(ATM_VF_CLOSE, &vcc->flags))
+	if (test_bit(ATM_VF_CLOSE, &vcc->flags))
 		mask |= EPOLLHUP;
 
 	/* readable? */
@@ -674,10 +666,6 @@ __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* writable? */
-	if (sock->state == SS_CONNECTING &&
-	    test_bit(ATM_VF_WAITING, &vcc->flags))
-		return mask;
-
 	if (vcc->qos.txtp.traffic_class != ATM_NONE &&
 	    vcc_writable(sk))
 		mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
@@ -704,9 +692,7 @@ static int atm_change_qos(struct atm_vcc *vcc, struct atm_qos *qos)
 		return error;
 	if (!vcc->dev->ops->change_qos)
 		return -EOPNOTSUPP;
-	if (sk_atm(vcc)->sk_family == AF_ATMPVC)
-		return vcc->dev->ops->change_qos(vcc, qos, ATM_MF_SET);
-	return svc_change_qos(vcc, qos);
+	return vcc->dev->ops->change_qos(vcc, qos, ATM_MF_SET);
 }
 
 static int check_tp(const struct atm_trafprm *tp)
@@ -854,15 +840,10 @@ static int __init atm_init(void)
 		pr_err("atmpvc_init() failed with %d\n", error);
 		goto out_unregister_vcc_proto;
 	}
-	error = atmsvc_init();
-	if (error < 0) {
-		pr_err("atmsvc_init() failed with %d\n", error);
-		goto out_atmpvc_exit;
-	}
 	error = atm_proc_init();
 	if (error < 0) {
 		pr_err("atm_proc_init() failed with %d\n", error);
-		goto out_atmsvc_exit;
+		goto out_atmpvc_exit;
 	}
 	error = atm_sysfs_init();
 	if (error < 0) {
@@ -873,8 +854,6 @@ static int __init atm_init(void)
 	return error;
 out_atmproc_exit:
 	atm_proc_exit();
-out_atmsvc_exit:
-	atmsvc_exit();
 out_atmpvc_exit:
 	atmpvc_exit();
 out_unregister_vcc_proto:
@@ -886,7 +865,6 @@ static void __exit atm_exit(void)
 {
 	atm_proc_exit();
 	atm_sysfs_exit();
-	atmsvc_exit();
 	atmpvc_exit();
 	proto_unregister(&vcc_proto);
 }
@@ -898,4 +876,3 @@ module_exit(atm_exit);
 MODULE_DESCRIPTION("Asynchronous Transfer Mode (ATM) networking core");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_ATMPVC);
-MODULE_ALIAS_NETPROTO(PF_ATMSVC);
diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 97f20cd051ed..11f6d236f5d6 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -13,13 +13,11 @@
 #include <linux/atmdev.h>
 #include <linux/atmarp.h>	/* manifest constants */
 #include <linux/capability.h>
-#include <linux/atmsvc.h>
 #include <linux/mutex.h>
 #include <asm/ioctls.h>
 #include <net/compat.h>
 
 #include "resources.h"
-#include "signaling.h"		/* for WAITING and sigd_attach */
 #include "common.h"
 
 
@@ -86,36 +84,6 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 				     current->comm, task_pid_nr(current));
 		error = 0;
 		goto done;
-	case ATMSIGD_CTRL:
-		if (!capable(CAP_NET_ADMIN)) {
-			error = -EPERM;
-			goto done;
-		}
-		/*
-		 * The user/kernel protocol for exchanging signalling
-		 * info uses kernel pointers as opaque references,
-		 * so the holder of the file descriptor can scribble
-		 * on the kernel... so we should make sure that we
-		 * have the same privileges that /proc/kcore needs
-		 */
-		if (!capable(CAP_SYS_RAWIO)) {
-			error = -EPERM;
-			goto done;
-		}
-#ifdef CONFIG_COMPAT
-		/* WTF? I don't even want to _think_ about making this
-		   work for 32-bit userspace. TBH I don't really want
-		   to think about it at all. dwmw2. */
-		if (compat) {
-			net_warn_ratelimited("32-bit task cannot be atmsigd\n");
-			error = -EINVAL;
-			goto done;
-		}
-#endif
-		error = sigd_attach(vcc);
-		if (!error)
-			sock->state = SS_CONNECTED;
-		goto done;
 	case ATM_SETBACKEND:
 	case ATM_NEWBACKENDIF:
 	{
diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index e3c422dc533a..6da52d12df68 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -308,8 +308,7 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 		test_and_set_bit(BLOCKED, &pvcc->blocked);
 		goto nospace;
 	}
-	if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
-	    test_bit(ATM_VF_CLOSE, &vcc->flags) ||
+	if (test_bit(ATM_VF_CLOSE, &vcc->flags) ||
 	    !test_bit(ATM_VF_READY, &vcc->flags)) {
 		bh_unlock_sock(sk_atm(vcc));
 		kfree_skb(skb);
diff --git a/net/atm/proc.c b/net/atm/proc.c
index b650da764a23..8f20b49b9c02 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -29,7 +29,6 @@
 #include <linux/atomic.h>
 #include "resources.h"
 #include "common.h" /* atm_proc_init prototype */
-#include "signaling.h" /* to get sigd - ugly too */
 
 static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
 				 size_t count, loff_t *pos);
@@ -156,13 +155,6 @@ static void pvc_info(struct seq_file *seq, struct atm_vcc *vcc)
 	seq_putc(seq, '\n');
 }
 
-static const char *vcc_state(struct atm_vcc *vcc)
-{
-	static const char *const map[] = { ATM_VS2TXT_MAP };
-
-	return map[ATM_VF2VS(vcc->flags)];
-}
-
 static void vcc_info(struct seq_file *seq, struct atm_vcc *vcc)
 {
 	struct sock *sk = sk_atm(vcc);
@@ -177,9 +169,6 @@ static void vcc_info(struct seq_file *seq, struct atm_vcc *vcc)
 	case AF_ATMPVC:
 		seq_printf(seq, "PVC");
 		break;
-	case AF_ATMSVC:
-		seq_printf(seq, "SVC");
-		break;
 	default:
 		seq_printf(seq, "%3d", sk->sk_family);
 	}
@@ -190,26 +179,6 @@ static void vcc_info(struct seq_file *seq, struct atm_vcc *vcc)
 		   refcount_read(&sk->sk_refcnt));
 }
 
-static void svc_info(struct seq_file *seq, struct atm_vcc *vcc)
-{
-	if (!vcc->dev)
-		seq_printf(seq, sizeof(void *) == 4 ?
-			   "N/A@%pK%10s" : "N/A@%pK%2s", vcc, "");
-	else
-		seq_printf(seq, "%3d %3d %5d         ",
-			   vcc->dev->number, vcc->vpi, vcc->vci);
-	seq_printf(seq, "%-10s ", vcc_state(vcc));
-	seq_printf(seq, "%s%s", vcc->remote.sas_addr.pub,
-	    *vcc->remote.sas_addr.pub && *vcc->remote.sas_addr.prv ? "+" : "");
-	if (*vcc->remote.sas_addr.prv) {
-		int i;
-
-		for (i = 0; i < ATM_ESA_LEN; i++)
-			seq_printf(seq, "%02x", vcc->remote.sas_addr.prv[i]);
-	}
-	seq_putc(seq, '\n');
-}
-
 static int atm_dev_seq_show(struct seq_file *seq, void *v)
 {
 	static char atm_dev_banner[] =
@@ -278,29 +247,6 @@ static const struct seq_operations vcc_seq_ops = {
 	.show	= vcc_seq_show,
 };
 
-static int svc_seq_show(struct seq_file *seq, void *v)
-{
-	static const char atm_svc_banner[] =
-		"Itf VPI VCI           State      Remote\n";
-
-	if (v == SEQ_START_TOKEN)
-		seq_puts(seq, atm_svc_banner);
-	else {
-		struct vcc_state *state = seq->private;
-		struct atm_vcc *vcc = atm_sk(state->sk);
-
-		svc_info(seq, vcc);
-	}
-	return 0;
-}
-
-static const struct seq_operations svc_seq_ops = {
-	.start	= vcc_seq_start,
-	.next	= vcc_seq_next,
-	.stop	= vcc_seq_stop,
-	.show	= svc_seq_show,
-};
-
 static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
 				 size_t count, loff_t *pos)
 {
@@ -376,8 +322,6 @@ int __init atm_proc_init(void)
 	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
 	proc_create_seq_private("pvc", 0444, atm_proc_root, &pvc_seq_ops,
 			sizeof(struct vcc_state), (void *)(uintptr_t)PF_ATMPVC);
-	proc_create_seq_private("svc", 0444, atm_proc_root, &svc_seq_ops,
-			sizeof(struct vcc_state), (void *)(uintptr_t)PF_ATMSVC);
 	proc_create_seq_private("vc", 0444, atm_proc_root, &vcc_seq_ops,
 			sizeof(struct vcc_state), NULL);
 	return 0;
diff --git a/net/atm/resources.c b/net/atm/resources.c
index a08f65aacf75..3fa4b0df63a8 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -40,7 +40,6 @@ static struct atm_dev *__alloc_atm_dev(const char *type)
 	dev->type = type;
 	dev->signal = ATM_PHY_SIG_UNKNOWN;
 	dev->link_rate = ATM_OC3_PCR;
-	spin_lock_init(&dev->lock);
 
 	return dev;
 }
diff --git a/net/atm/signaling.c b/net/atm/signaling.c
deleted file mode 100644
index b991d937205a..000000000000
--- a/net/atm/signaling.c
+++ /dev/null
@@ -1,297 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* net/atm/signaling.c - ATM signaling */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
-
-#include <linux/errno.h>	/* error codes */
-#include <linux/kernel.h>	/* printk */
-#include <linux/skbuff.h>
-#include <linux/wait.h>
-#include <linux/sched.h>	/* jiffies and HZ */
-#include <linux/atm.h>		/* ATM stuff */
-#include <linux/atmsap.h>
-#include <linux/atmsvc.h>
-#include <linux/atmdev.h>
-#include <linux/bitops.h>
-#include <linux/slab.h>
-
-#include "resources.h"
-#include "signaling.h"
-
-struct atm_vcc *sigd = NULL;
-
-/*
- * find_get_vcc - validate and get a reference to a vcc pointer
- * @vcc: the vcc pointer to validate
- *
- * This function validates that @vcc points to a registered VCC in vcc_hash.
- * If found, it increments the socket reference count and returns the vcc.
- * The caller must call sock_put(sk_atm(vcc)) when done.
- *
- * Returns the vcc pointer if valid, NULL otherwise.
- */
-static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
-{
-	int i;
-
-	read_lock(&vcc_sklist_lock);
-	for (i = 0; i < VCC_HTABLE_SIZE; i++) {
-		struct sock *s;
-
-		sk_for_each(s, &vcc_hash[i]) {
-			if (atm_sk(s) == vcc) {
-				sock_hold(s);
-				read_unlock(&vcc_sklist_lock);
-				return vcc;
-			}
-		}
-	}
-	read_unlock(&vcc_sklist_lock);
-	return NULL;
-}
-
-static void sigd_put_skb(struct sk_buff *skb)
-{
-	if (!sigd) {
-		pr_debug("atmsvc: no signaling daemon\n");
-		kfree_skb(skb);
-		return;
-	}
-	atm_force_charge(sigd, skb->truesize);
-	skb_queue_tail(&sk_atm(sigd)->sk_receive_queue, skb);
-	sk_atm(sigd)->sk_data_ready(sk_atm(sigd));
-}
-
-static void modify_qos(struct atm_vcc *vcc, struct atmsvc_msg *msg)
-{
-	struct sk_buff *skb;
-
-	if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
-	    !test_bit(ATM_VF_READY, &vcc->flags))
-		return;
-	msg->type = as_error;
-	if (!vcc->dev->ops->change_qos)
-		msg->reply = -EOPNOTSUPP;
-	else {
-		/* should lock VCC */
-		msg->reply = vcc->dev->ops->change_qos(vcc, &msg->qos,
-						       msg->reply);
-		if (!msg->reply)
-			msg->type = as_okay;
-	}
-	/*
-	 * Should probably just turn around the old skb. But then, the buffer
-	 * space accounting needs to follow the change too. Maybe later.
-	 */
-	while (!(skb = alloc_skb(sizeof(struct atmsvc_msg), GFP_KERNEL)))
-		schedule();
-	*(struct atmsvc_msg *)skb_put(skb, sizeof(struct atmsvc_msg)) = *msg;
-	sigd_put_skb(skb);
-}
-
-static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
-{
-	struct atmsvc_msg *msg;
-	struct atm_vcc *session_vcc;
-	struct sock *sk;
-
-	msg = (struct atmsvc_msg *) skb->data;
-	WARN_ON(refcount_sub_and_test(skb->truesize, &sk_atm(vcc)->sk_wmem_alloc));
-
-	vcc = find_get_vcc(*(struct atm_vcc **)&msg->vcc);
-	if (!vcc) {
-		pr_debug("invalid vcc pointer in msg\n");
-		dev_kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	pr_debug("%d (0x%lx)\n", (int)msg->type, (unsigned long)vcc);
-	sk = sk_atm(vcc);
-
-	switch (msg->type) {
-	case as_okay:
-		sk->sk_err = -msg->reply;
-		clear_bit(ATM_VF_WAITING, &vcc->flags);
-		if (!*vcc->local.sas_addr.prv && !*vcc->local.sas_addr.pub) {
-			vcc->local.sas_family = AF_ATMSVC;
-			memcpy(vcc->local.sas_addr.prv,
-			       msg->local.sas_addr.prv, ATM_ESA_LEN);
-			memcpy(vcc->local.sas_addr.pub,
-			       msg->local.sas_addr.pub, ATM_E164_LEN + 1);
-		}
-		session_vcc = vcc->session ? vcc->session : vcc;
-		if (session_vcc->vpi || session_vcc->vci)
-			break;
-		session_vcc->itf = msg->pvc.sap_addr.itf;
-		session_vcc->vpi = msg->pvc.sap_addr.vpi;
-		session_vcc->vci = msg->pvc.sap_addr.vci;
-		if (session_vcc->vpi || session_vcc->vci)
-			session_vcc->qos = msg->qos;
-		break;
-	case as_error:
-		clear_bit(ATM_VF_REGIS, &vcc->flags);
-		clear_bit(ATM_VF_READY, &vcc->flags);
-		sk->sk_err = -msg->reply;
-		clear_bit(ATM_VF_WAITING, &vcc->flags);
-		break;
-	case as_indicate:
-		/* Release the reference from msg->vcc, we'll use msg->listen_vcc instead */
-		sock_put(sk);
-
-		vcc = find_get_vcc(*(struct atm_vcc **)&msg->listen_vcc);
-		if (!vcc) {
-			pr_debug("invalid listen_vcc pointer in msg\n");
-			dev_kfree_skb(skb);
-			return -EINVAL;
-		}
-
-		sk = sk_atm(vcc);
-		pr_debug("as_indicate!!!\n");
-		lock_sock(sk);
-		if (sk_acceptq_is_full(sk)) {
-			sigd_enq(NULL, as_reject, vcc, NULL, NULL);
-			dev_kfree_skb(skb);
-			goto as_indicate_complete;
-		}
-		sk_acceptq_added(sk);
-		skb_queue_tail(&sk->sk_receive_queue, skb);
-		pr_debug("waking sk_sleep(sk) 0x%p\n", sk_sleep(sk));
-		sk->sk_state_change(sk);
-as_indicate_complete:
-		release_sock(sk);
-		/* Paired with find_get_vcc(msg->listen_vcc) above */
-		sock_put(sk);
-		return 0;
-	case as_close:
-		set_bit(ATM_VF_RELEASED, &vcc->flags);
-		vcc_release_async(vcc, msg->reply);
-		goto out;
-	case as_modify:
-		modify_qos(vcc, msg);
-		break;
-	case as_addparty:
-	case as_dropparty:
-		WRITE_ONCE(sk->sk_err_soft, -msg->reply);
-					/* < 0 failure, otherwise ep_ref */
-		clear_bit(ATM_VF_WAITING, &vcc->flags);
-		break;
-	default:
-		pr_alert("bad message type %d\n", (int)msg->type);
-		dev_kfree_skb(skb);
-		/* Paired with find_get_vcc(msg->vcc) above */
-		sock_put(sk);
-		return -EINVAL;
-	}
-	sk->sk_state_change(sk);
-out:
-	dev_kfree_skb(skb);
-	/* Paired with find_get_vcc(msg->vcc) above */
-	sock_put(sk);
-	return 0;
-}
-
-void sigd_enq2(struct atm_vcc *vcc, enum atmsvc_msg_type type,
-	       struct atm_vcc *listen_vcc, const struct sockaddr_atmpvc *pvc,
-	       const struct sockaddr_atmsvc *svc, const struct atm_qos *qos,
-	       int reply)
-{
-	struct sk_buff *skb;
-	struct atmsvc_msg *msg;
-	static unsigned int session = 0;
-
-	pr_debug("%d (0x%p)\n", (int)type, vcc);
-	while (!(skb = alloc_skb(sizeof(struct atmsvc_msg), GFP_KERNEL)))
-		schedule();
-	msg = skb_put_zero(skb, sizeof(struct atmsvc_msg));
-	msg->type = type;
-	*(struct atm_vcc **) &msg->vcc = vcc;
-	*(struct atm_vcc **) &msg->listen_vcc = listen_vcc;
-	msg->reply = reply;
-	if (qos)
-		msg->qos = *qos;
-	if (vcc)
-		msg->sap = vcc->sap;
-	if (svc)
-		msg->svc = *svc;
-	if (vcc)
-		msg->local = vcc->local;
-	if (pvc)
-		msg->pvc = *pvc;
-	if (vcc) {
-		if (type == as_connect && test_bit(ATM_VF_SESSION, &vcc->flags))
-			msg->session = ++session;
-			/* every new pmp connect gets the next session number */
-	}
-	sigd_put_skb(skb);
-	if (vcc)
-		set_bit(ATM_VF_REGIS, &vcc->flags);
-}
-
-void sigd_enq(struct atm_vcc *vcc, enum atmsvc_msg_type type,
-	      struct atm_vcc *listen_vcc, const struct sockaddr_atmpvc *pvc,
-	      const struct sockaddr_atmsvc *svc)
-{
-	sigd_enq2(vcc, type, listen_vcc, pvc, svc, vcc ? &vcc->qos : NULL, 0);
-	/* other ISP applications may use "reply" */
-}
-
-static void purge_vcc(struct atm_vcc *vcc)
-{
-	if (sk_atm(vcc)->sk_family == PF_ATMSVC &&
-	    !test_bit(ATM_VF_META, &vcc->flags)) {
-		set_bit(ATM_VF_RELEASED, &vcc->flags);
-		clear_bit(ATM_VF_REGIS, &vcc->flags);
-		vcc_release_async(vcc, -EUNATCH);
-	}
-}
-
-static void sigd_close(struct atm_vcc *vcc)
-{
-	struct sock *s;
-	int i;
-
-	pr_debug("\n");
-	sigd = NULL;
-	if (skb_peek(&sk_atm(vcc)->sk_receive_queue))
-		pr_err("closing with requests pending\n");
-	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
-
-	read_lock(&vcc_sklist_lock);
-	for (i = 0; i < VCC_HTABLE_SIZE; ++i) {
-		struct hlist_head *head = &vcc_hash[i];
-
-		sk_for_each(s, head) {
-			vcc = atm_sk(s);
-
-			purge_vcc(vcc);
-		}
-	}
-	read_unlock(&vcc_sklist_lock);
-}
-
-static const struct atmdev_ops sigd_dev_ops = {
-	.close = sigd_close,
-	.send =	sigd_send
-};
-
-static struct atm_dev sigd_dev = {
-	.ops =		&sigd_dev_ops,
-	.type =		"sig",
-	.number =	999,
-	.lock =		__SPIN_LOCK_UNLOCKED(sigd_dev.lock)
-};
-
-int sigd_attach(struct atm_vcc *vcc)
-{
-	if (sigd)
-		return -EADDRINUSE;
-	pr_debug("\n");
-	sigd = vcc;
-	vcc->dev = &sigd_dev;
-	vcc_insert_socket(sk_atm(vcc));
-	set_bit(ATM_VF_META, &vcc->flags);
-	set_bit(ATM_VF_READY, &vcc->flags);
-	return 0;
-}
diff --git a/net/atm/svc.c b/net/atm/svc.c
deleted file mode 100644
index 270e95154a2b..000000000000
--- a/net/atm/svc.c
+++ /dev/null
@@ -1,694 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* net/atm/svc.c - ATM SVC sockets */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
-
-#include <linux/string.h>
-#include <linux/net.h>		/* struct socket, struct proto_ops */
-#include <linux/errno.h>	/* error codes */
-#include <linux/kernel.h>	/* printk */
-#include <linux/skbuff.h>
-#include <linux/wait.h>
-#include <linux/sched/signal.h>
-#include <linux/fcntl.h>	/* O_NONBLOCK */
-#include <linux/init.h>
-#include <linux/atm.h>		/* ATM stuff */
-#include <linux/atmsap.h>
-#include <linux/atmsvc.h>
-#include <linux/atmdev.h>
-#include <linux/bitops.h>
-#include <net/sock.h>		/* for sock_no_* */
-#include <linux/uaccess.h>
-#include <linux/uio.h>
-#include <linux/export.h>
-
-#include "resources.h"
-#include "common.h"		/* common for PVCs and SVCs */
-#include "signaling.h"
-
-#ifdef CONFIG_COMPAT
-/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
-#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL + 4, struct compat_atm_iobuf)
-#endif
-
-static int svc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern);
-
-/*
- * Note: since all this is still nicely synchronized with the signaling demon,
- *       there's no need to protect sleep loops with clis. If signaling is
- *       moved into the kernel, that would change.
- */
-
-
-static int svc_shutdown(struct socket *sock, int how)
-{
-	return 0;
-}
-
-static void svc_disconnect(struct atm_vcc *vcc)
-{
-	DEFINE_WAIT(wait);
-	struct sk_buff *skb;
-	struct sock *sk = sk_atm(vcc);
-
-	pr_debug("%p\n", vcc);
-	if (test_bit(ATM_VF_REGIS, &vcc->flags)) {
-		sigd_enq(vcc, as_close, NULL, NULL, NULL);
-		for (;;) {
-			prepare_to_wait(sk_sleep(sk), &wait, TASK_UNINTERRUPTIBLE);
-			if (test_bit(ATM_VF_RELEASED, &vcc->flags) || !sigd)
-				break;
-			schedule();
-		}
-		finish_wait(sk_sleep(sk), &wait);
-	}
-	/* beware - socket is still in use by atmsigd until the last
-	   as_indicate has been answered */
-	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
-		atm_return(vcc, skb->truesize);
-		pr_debug("LISTEN REL\n");
-		sigd_enq2(NULL, as_reject, vcc, NULL, NULL, &vcc->qos, 0);
-		dev_kfree_skb(skb);
-	}
-	clear_bit(ATM_VF_REGIS, &vcc->flags);
-	/* ... may retry later */
-}
-
-static int svc_release(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc;
-
-	if (sk) {
-		vcc = ATM_SD(sock);
-		pr_debug("%p\n", vcc);
-		clear_bit(ATM_VF_READY, &vcc->flags);
-		/*
-		 * VCC pointer is used as a reference,
-		 * so we must not free it (thereby subjecting it to re-use)
-		 * before all pending connections are closed
-		 */
-		svc_disconnect(vcc);
-		vcc_release(sock);
-	}
-	return 0;
-}
-
-static int svc_bind(struct socket *sock, struct sockaddr_unsized *sockaddr,
-		    int sockaddr_len)
-{
-	DEFINE_WAIT(wait);
-	struct sock *sk = sock->sk;
-	struct sockaddr_atmsvc *addr;
-	struct atm_vcc *vcc;
-	int error;
-
-	if (sockaddr_len != sizeof(struct sockaddr_atmsvc))
-		return -EINVAL;
-	lock_sock(sk);
-	if (sock->state == SS_CONNECTED) {
-		error = -EISCONN;
-		goto out;
-	}
-	if (sock->state != SS_UNCONNECTED) {
-		error = -EINVAL;
-		goto out;
-	}
-	vcc = ATM_SD(sock);
-	addr = (struct sockaddr_atmsvc *) sockaddr;
-	if (addr->sas_family != AF_ATMSVC) {
-		error = -EAFNOSUPPORT;
-		goto out;
-	}
-	clear_bit(ATM_VF_BOUND, &vcc->flags);
-	    /* failing rebind will kill old binding */
-	/* @@@ check memory (de)allocation on rebind */
-	if (!test_bit(ATM_VF_HASQOS, &vcc->flags)) {
-		error = -EBADFD;
-		goto out;
-	}
-	vcc->local = *addr;
-	set_bit(ATM_VF_WAITING, &vcc->flags);
-	sigd_enq(vcc, as_bind, NULL, NULL, &vcc->local);
-	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_UNINTERRUPTIBLE);
-		if (!test_bit(ATM_VF_WAITING, &vcc->flags) || !sigd)
-			break;
-		schedule();
-	}
-	finish_wait(sk_sleep(sk), &wait);
-	clear_bit(ATM_VF_REGIS, &vcc->flags); /* doesn't count */
-	if (!sigd) {
-		error = -EUNATCH;
-		goto out;
-	}
-	if (!sk->sk_err)
-		set_bit(ATM_VF_BOUND, &vcc->flags);
-	error = -sk->sk_err;
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_connect(struct socket *sock, struct sockaddr_unsized *sockaddr,
-		       int sockaddr_len, int flags)
-{
-	DEFINE_WAIT(wait);
-	struct sock *sk = sock->sk;
-	struct sockaddr_atmsvc *addr;
-	struct atm_vcc *vcc = ATM_SD(sock);
-	int error;
-
-	pr_debug("%p\n", vcc);
-	lock_sock(sk);
-	if (sockaddr_len != sizeof(struct sockaddr_atmsvc)) {
-		error = -EINVAL;
-		goto out;
-	}
-
-	switch (sock->state) {
-	default:
-		error = -EINVAL;
-		goto out;
-	case SS_CONNECTED:
-		error = -EISCONN;
-		goto out;
-	case SS_CONNECTING:
-		if (test_bit(ATM_VF_WAITING, &vcc->flags)) {
-			error = -EALREADY;
-			goto out;
-		}
-		sock->state = SS_UNCONNECTED;
-		if (sk->sk_err) {
-			error = -sk->sk_err;
-			goto out;
-		}
-		break;
-	case SS_UNCONNECTED:
-		addr = (struct sockaddr_atmsvc *) sockaddr;
-		if (addr->sas_family != AF_ATMSVC) {
-			error = -EAFNOSUPPORT;
-			goto out;
-		}
-		if (!test_bit(ATM_VF_HASQOS, &vcc->flags)) {
-			error = -EBADFD;
-			goto out;
-		}
-		if (vcc->qos.txtp.traffic_class == ATM_ANYCLASS ||
-		    vcc->qos.rxtp.traffic_class == ATM_ANYCLASS) {
-			error = -EINVAL;
-			goto out;
-		}
-		if (!vcc->qos.txtp.traffic_class &&
-		    !vcc->qos.rxtp.traffic_class) {
-			error = -EINVAL;
-			goto out;
-		}
-		vcc->remote = *addr;
-		set_bit(ATM_VF_WAITING, &vcc->flags);
-		sigd_enq(vcc, as_connect, NULL, NULL, &vcc->remote);
-		if (flags & O_NONBLOCK) {
-			sock->state = SS_CONNECTING;
-			error = -EINPROGRESS;
-			goto out;
-		}
-		error = 0;
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
-		while (test_bit(ATM_VF_WAITING, &vcc->flags) && sigd) {
-			schedule();
-			if (!signal_pending(current)) {
-				prepare_to_wait(sk_sleep(sk), &wait,
-						TASK_INTERRUPTIBLE);
-				continue;
-			}
-			pr_debug("*ABORT*\n");
-			/*
-			 * This is tricky:
-			 *   Kernel ---close--> Demon
-			 *   Kernel <--close--- Demon
-			 * or
-			 *   Kernel ---close--> Demon
-			 *   Kernel <--error--- Demon
-			 * or
-			 *   Kernel ---close--> Demon
-			 *   Kernel <--okay---- Demon
-			 *   Kernel <--close--- Demon
-			 */
-			sigd_enq(vcc, as_close, NULL, NULL, NULL);
-			while (test_bit(ATM_VF_WAITING, &vcc->flags) && sigd) {
-				prepare_to_wait(sk_sleep(sk), &wait,
-						TASK_INTERRUPTIBLE);
-				schedule();
-			}
-			if (!sk->sk_err)
-				while (!test_bit(ATM_VF_RELEASED, &vcc->flags) &&
-				       sigd) {
-					prepare_to_wait(sk_sleep(sk), &wait,
-							TASK_INTERRUPTIBLE);
-					schedule();
-				}
-			clear_bit(ATM_VF_REGIS, &vcc->flags);
-			clear_bit(ATM_VF_RELEASED, &vcc->flags);
-			clear_bit(ATM_VF_CLOSE, &vcc->flags);
-			    /* we're gone now but may connect later */
-			error = -EINTR;
-			break;
-		}
-		finish_wait(sk_sleep(sk), &wait);
-		if (error)
-			goto out;
-		if (!sigd) {
-			error = -EUNATCH;
-			goto out;
-		}
-		if (sk->sk_err) {
-			error = -sk->sk_err;
-			goto out;
-		}
-	}
-
-	vcc->qos.txtp.max_pcr = SELECT_TOP_PCR(vcc->qos.txtp);
-	vcc->qos.txtp.pcr = 0;
-	vcc->qos.txtp.min_pcr = 0;
-
-	error = vcc_connect(sock, vcc->itf, vcc->vpi, vcc->vci);
-	if (!error)
-		sock->state = SS_CONNECTED;
-	else
-		(void)svc_disconnect(vcc);
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_listen(struct socket *sock, int backlog)
-{
-	DEFINE_WAIT(wait);
-	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc = ATM_SD(sock);
-	int error;
-
-	pr_debug("%p\n", vcc);
-	lock_sock(sk);
-	/* let server handle listen on unbound sockets */
-	if (test_bit(ATM_VF_SESSION, &vcc->flags)) {
-		error = -EINVAL;
-		goto out;
-	}
-	if (test_bit(ATM_VF_LISTEN, &vcc->flags)) {
-		error = -EADDRINUSE;
-		goto out;
-	}
-	set_bit(ATM_VF_WAITING, &vcc->flags);
-	sigd_enq(vcc, as_listen, NULL, NULL, &vcc->local);
-	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_UNINTERRUPTIBLE);
-		if (!test_bit(ATM_VF_WAITING, &vcc->flags) || !sigd)
-			break;
-		schedule();
-	}
-	finish_wait(sk_sleep(sk), &wait);
-	if (!sigd) {
-		error = -EUNATCH;
-		goto out;
-	}
-	set_bit(ATM_VF_LISTEN, &vcc->flags);
-	vcc_insert_socket(sk);
-	sk->sk_max_ack_backlog = backlog > 0 ? backlog : ATM_BACKLOG_DEFAULT;
-	error = -sk->sk_err;
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_accept(struct socket *sock, struct socket *newsock,
-		      struct proto_accept_arg *arg)
-{
-	struct sock *sk = sock->sk;
-	struct sk_buff *skb;
-	struct atmsvc_msg *msg;
-	struct atm_vcc *old_vcc = ATM_SD(sock);
-	struct atm_vcc *new_vcc;
-	int error;
-
-	lock_sock(sk);
-
-	error = svc_create(sock_net(sk), newsock, 0, arg->kern);
-	if (error)
-		goto out;
-
-	new_vcc = ATM_SD(newsock);
-
-	pr_debug("%p -> %p\n", old_vcc, new_vcc);
-	while (1) {
-		DEFINE_WAIT(wait);
-
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
-		while (!(skb = skb_dequeue(&sk->sk_receive_queue)) &&
-		       sigd) {
-			if (test_bit(ATM_VF_RELEASED, &old_vcc->flags))
-				break;
-			if (test_bit(ATM_VF_CLOSE, &old_vcc->flags)) {
-				error = -sk->sk_err;
-				break;
-			}
-			if (arg->flags & O_NONBLOCK) {
-				error = -EAGAIN;
-				break;
-			}
-			release_sock(sk);
-			schedule();
-			lock_sock(sk);
-			if (signal_pending(current)) {
-				error = -ERESTARTSYS;
-				break;
-			}
-			prepare_to_wait(sk_sleep(sk), &wait,
-					TASK_INTERRUPTIBLE);
-		}
-		finish_wait(sk_sleep(sk), &wait);
-		if (error)
-			goto out;
-		if (!skb) {
-			error = -EUNATCH;
-			goto out;
-		}
-		msg = (struct atmsvc_msg *)skb->data;
-		new_vcc->qos = msg->qos;
-		set_bit(ATM_VF_HASQOS, &new_vcc->flags);
-		new_vcc->remote = msg->svc;
-		new_vcc->local = msg->local;
-		new_vcc->sap = msg->sap;
-		error = vcc_connect(newsock, msg->pvc.sap_addr.itf,
-				    msg->pvc.sap_addr.vpi,
-				    msg->pvc.sap_addr.vci);
-		dev_kfree_skb(skb);
-		sk_acceptq_removed(sk);
-		if (error) {
-			sigd_enq2(NULL, as_reject, old_vcc, NULL, NULL,
-				  &old_vcc->qos, error);
-			error = error == -EAGAIN ? -EBUSY : error;
-			goto out;
-		}
-		/* wait should be short, so we ignore the non-blocking flag */
-		set_bit(ATM_VF_WAITING, &new_vcc->flags);
-		sigd_enq(new_vcc, as_accept, old_vcc, NULL, NULL);
-		for (;;) {
-			prepare_to_wait(sk_sleep(sk_atm(new_vcc)), &wait,
-					TASK_UNINTERRUPTIBLE);
-			if (!test_bit(ATM_VF_WAITING, &new_vcc->flags) || !sigd)
-				break;
-			release_sock(sk);
-			schedule();
-			lock_sock(sk);
-		}
-		finish_wait(sk_sleep(sk_atm(new_vcc)), &wait);
-		if (!sigd) {
-			error = -EUNATCH;
-			goto out;
-		}
-		if (!sk_atm(new_vcc)->sk_err)
-			break;
-		if (sk_atm(new_vcc)->sk_err != ERESTARTSYS) {
-			error = -sk_atm(new_vcc)->sk_err;
-			goto out;
-		}
-	}
-	newsock->state = SS_CONNECTED;
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_getname(struct socket *sock, struct sockaddr *sockaddr,
-		       int peer)
-{
-	struct sockaddr_atmsvc *addr;
-
-	addr = (struct sockaddr_atmsvc *) sockaddr;
-	memcpy(addr, peer ? &ATM_SD(sock)->remote : &ATM_SD(sock)->local,
-	       sizeof(struct sockaddr_atmsvc));
-	return sizeof(struct sockaddr_atmsvc);
-}
-
-int svc_change_qos(struct atm_vcc *vcc, struct atm_qos *qos)
-{
-	struct sock *sk = sk_atm(vcc);
-	DEFINE_WAIT(wait);
-
-	set_bit(ATM_VF_WAITING, &vcc->flags);
-	sigd_enq2(vcc, as_modify, NULL, NULL, &vcc->local, qos, 0);
-	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_UNINTERRUPTIBLE);
-		if (!test_bit(ATM_VF_WAITING, &vcc->flags) ||
-		    test_bit(ATM_VF_RELEASED, &vcc->flags) || !sigd) {
-			break;
-		}
-		schedule();
-	}
-	finish_wait(sk_sleep(sk), &wait);
-	if (!sigd)
-		return -EUNATCH;
-	return -sk->sk_err;
-}
-
-static int svc_setsockopt(struct socket *sock, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
-{
-	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc = ATM_SD(sock);
-	int value, error = 0;
-
-	lock_sock(sk);
-	switch (optname) {
-	case SO_ATMSAP:
-		if (level != SOL_ATM || optlen != sizeof(struct atm_sap)) {
-			error = -EINVAL;
-			goto out;
-		}
-		if (copy_from_sockptr(&vcc->sap, optval, optlen)) {
-			error = -EFAULT;
-			goto out;
-		}
-		set_bit(ATM_VF_HASSAP, &vcc->flags);
-		break;
-	case SO_MULTIPOINT:
-		if (level != SOL_ATM || optlen != sizeof(int)) {
-			error = -EINVAL;
-			goto out;
-		}
-		if (copy_from_sockptr(&value, optval, sizeof(int))) {
-			error = -EFAULT;
-			goto out;
-		}
-		if (value == 1)
-			set_bit(ATM_VF_SESSION, &vcc->flags);
-		else if (value == 0)
-			clear_bit(ATM_VF_SESSION, &vcc->flags);
-		else
-			error = -EINVAL;
-		break;
-	default:
-		error = vcc_setsockopt(sock, level, optname, optval, optlen);
-	}
-
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_getsockopt(struct socket *sock, int level, int optname,
-			  sockopt_t *opt)
-{
-	struct sock *sk = sock->sk;
-	int error = 0, len;
-
-	lock_sock(sk);
-	if (!__SO_LEVEL_MATCH(optname, level) || optname != SO_ATMSAP) {
-		error = vcc_getsockopt(sock, level, optname, opt);
-		goto out;
-	}
-	len = opt->optlen;
-	if (len != sizeof(struct atm_sap)) {
-		error = -EINVAL;
-		goto out;
-	}
-	if (copy_to_iter(&ATM_SD(sock)->sap, sizeof(struct atm_sap),
-			 &opt->iter_out) != sizeof(struct atm_sap)) {
-		error = -EFAULT;
-		goto out;
-	}
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_addparty(struct socket *sock, struct sockaddr *sockaddr,
-			int sockaddr_len, int flags)
-{
-	DEFINE_WAIT(wait);
-	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc = ATM_SD(sock);
-	int error;
-
-	lock_sock(sk);
-	set_bit(ATM_VF_WAITING, &vcc->flags);
-	sigd_enq(vcc, as_addparty, NULL, NULL,
-		 (struct sockaddr_atmsvc *) sockaddr);
-	if (flags & O_NONBLOCK) {
-		error = -EINPROGRESS;
-		goto out;
-	}
-	pr_debug("added wait queue\n");
-	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
-		if (!test_bit(ATM_VF_WAITING, &vcc->flags) || !sigd)
-			break;
-		schedule();
-	}
-	finish_wait(sk_sleep(sk), &wait);
-	error = -xchg(&sk->sk_err_soft, 0);
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_dropparty(struct socket *sock, int ep_ref)
-{
-	DEFINE_WAIT(wait);
-	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc = ATM_SD(sock);
-	int error;
-
-	lock_sock(sk);
-	set_bit(ATM_VF_WAITING, &vcc->flags);
-	sigd_enq2(vcc, as_dropparty, NULL, NULL, NULL, NULL, ep_ref);
-	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
-		if (!test_bit(ATM_VF_WAITING, &vcc->flags) || !sigd)
-			break;
-		schedule();
-	}
-	finish_wait(sk_sleep(sk), &wait);
-	if (!sigd) {
-		error = -EUNATCH;
-		goto out;
-	}
-	error = -xchg(&sk->sk_err_soft, 0);
-out:
-	release_sock(sk);
-	return error;
-}
-
-static int svc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
-{
-	int error, ep_ref;
-	struct sockaddr_atmsvc sa;
-	struct atm_vcc *vcc = ATM_SD(sock);
-
-	switch (cmd) {
-	case ATM_ADDPARTY:
-		if (!test_bit(ATM_VF_SESSION, &vcc->flags))
-			return -EINVAL;
-		if (copy_from_user(&sa, (void __user *) arg, sizeof(sa)))
-			return -EFAULT;
-		error = svc_addparty(sock, (struct sockaddr *)&sa, sizeof(sa),
-				     0);
-		break;
-	case ATM_DROPPARTY:
-		if (!test_bit(ATM_VF_SESSION, &vcc->flags))
-			return -EINVAL;
-		if (copy_from_user(&ep_ref, (void __user *) arg, sizeof(int)))
-			return -EFAULT;
-		error = svc_dropparty(sock, ep_ref);
-		break;
-	default:
-		error = vcc_ioctl(sock, cmd, arg);
-	}
-
-	return error;
-}
-
-#ifdef CONFIG_COMPAT
-static int svc_compat_ioctl(struct socket *sock, unsigned int cmd,
-			    unsigned long arg)
-{
-	/* The definition of ATM_ADDPARTY uses the size of struct atm_iobuf.
-	   But actually it takes a struct sockaddr_atmsvc, which doesn't need
-	   compat handling. So all we have to do is fix up cmd... */
-	if (cmd == COMPAT_ATM_ADDPARTY)
-		cmd = ATM_ADDPARTY;
-
-	if (cmd == ATM_ADDPARTY || cmd == ATM_DROPPARTY)
-		return svc_ioctl(sock, cmd, arg);
-	else
-		return vcc_compat_ioctl(sock, cmd, arg);
-}
-#endif /* CONFIG_COMPAT */
-
-static const struct proto_ops svc_proto_ops = {
-	.family =	PF_ATMSVC,
-	.owner =	THIS_MODULE,
-
-	.release =	svc_release,
-	.bind =		svc_bind,
-	.connect =	svc_connect,
-	.socketpair =	sock_no_socketpair,
-	.accept =	svc_accept,
-	.getname =	svc_getname,
-	.poll =		vcc_poll,
-	.ioctl =	svc_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl =	svc_compat_ioctl,
-#endif
-	.gettstamp =	sock_gettstamp,
-	.listen =	svc_listen,
-	.shutdown =	svc_shutdown,
-	.setsockopt =	svc_setsockopt,
-	.getsockopt_iter = svc_getsockopt,
-	.sendmsg =	vcc_sendmsg,
-	.recvmsg =	vcc_recvmsg,
-	.mmap =		sock_no_mmap,
-};
-
-
-static int svc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
-{
-	int error;
-
-	if (!net_eq(net, &init_net))
-		return -EAFNOSUPPORT;
-
-	sock->ops = &svc_proto_ops;
-	error = vcc_create(net, sock, protocol, AF_ATMSVC, kern);
-	if (error)
-		return error;
-	ATM_SD(sock)->local.sas_family = AF_ATMSVC;
-	ATM_SD(sock)->remote.sas_family = AF_ATMSVC;
-	return 0;
-}
-
-static const struct net_proto_family svc_family_ops = {
-	.family = PF_ATMSVC,
-	.create = svc_create,
-	.owner = THIS_MODULE,
-};
-
-
-/*
- *	Initialize the ATM SVC protocol family
- */
-
-int __init atmsvc_init(void)
-{
-	return sock_register(&svc_family_ops);
-}
-
-void atmsvc_exit(void)
-{
-	sock_unregister(PF_ATMSVC);
-}
-- 
2.54.0


