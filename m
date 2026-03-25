Return-Path: <netdev+bounces-271518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH4tGgvWw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E32324ED3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE925310DBB1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BEA3D525E;
	Wed, 25 Mar 2026 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QGK/ugS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wXYOeApM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QGK/ugS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wXYOeApM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A693D5652
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440647; cv=none; b=cJ+FiW3283+Z99ywFXO/5ct11G9KqSoMGkG3R1SnUVq98EITUvfIj/QDll2ScaoQhwWwcftsgLlitOHDox5K6BY4xNESdsX4okJ0BSzy/gz1K9PO4oW5cxut7XDsMb8REQqkoOi6DJ1CNsc2yX+Mp5wpq8UKWeuRridBbE+Julw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440647; c=relaxed/simple;
	bh=OI/6dH34Dkx0vf1OTyKvpqCNnQL2h50RJNt88vxvq8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNiBvo89aMs4EqUK0LJ3P/KJLQ71BoH2n60xUBUXq5BkbkqUocPT541WhWmhXtYj38aEYvXdtVFRnOMxHubliTBo1X5Uxxy5tQY1NpqQNldnPH7iczB1rk9ZWInlTY30sCmv/vTHtps5L1QLGXJw212ON7g7/vCcSGvR22FWaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QGK/ugS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wXYOeApM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QGK/ugS5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wXYOeApM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D7C74D22F;
	Wed, 25 Mar 2026 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYpLSZag5yeJIgKi/czl86lnaiHJOvkNlD/Duzj/IiA=;
	b=QGK/ugS5EJVv6k3wQSxSNH4PybeA1YiRSAZGboAXz1+nvGiizQuEjpzC9OUZSjAcv0k8Uv
	iPuXEnp3/dhyGXEiSah/ixAptPro4ClY8XDXDczZdos7lAfRzKz+idRQONXfkfzHWk2Sd0
	N3TfrLuJCMEFqvpOCVDHjl4GH8T3CwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYpLSZag5yeJIgKi/czl86lnaiHJOvkNlD/Duzj/IiA=;
	b=wXYOeApMMC55RNVKWb+HtP7fHvuYDHFbg3Q4HVX+EGz3mI3gBKmWPBI7PpVWvubF/u2SRq
	3ZS0hTTaFISTaNBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYpLSZag5yeJIgKi/czl86lnaiHJOvkNlD/Duzj/IiA=;
	b=QGK/ugS5EJVv6k3wQSxSNH4PybeA1YiRSAZGboAXz1+nvGiizQuEjpzC9OUZSjAcv0k8Uv
	iPuXEnp3/dhyGXEiSah/ixAptPro4ClY8XDXDczZdos7lAfRzKz+idRQONXfkfzHWk2Sd0
	N3TfrLuJCMEFqvpOCVDHjl4GH8T3CwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYpLSZag5yeJIgKi/czl86lnaiHJOvkNlD/Duzj/IiA=;
	b=wXYOeApMMC55RNVKWb+HtP7fHvuYDHFbg3Q4HVX+EGz3mI3gBKmWPBI7PpVWvubF/u2SRq
	3ZS0hTTaFISTaNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B88EA443BF;
	Wed, 25 Mar 2026 12:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BT0KcLQw2kbNgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 12:10:42 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11 net-next v5] ipv6: remove dynamic ICMPv6 sender registration infrastructure
Date: Wed, 25 Mar 2026 13:08:45 +0100
Message-ID: <20260325120928.15848-5-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325120928.15848-1-fmancera@suse.de>
References: <20260325120928.15848-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271518-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:email]
X-Rspamd-Queue-Id: D8E32324ED3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, there is no need to maintain the sender
registration infrastructure used to allow built-in subsystems to send
ICMPv6 messages when IPv6 was compiled as a module.

Drop the registration mechanism and the __icmpv6_send() sender
implementation. While icmpv6_send() users could be converted to
icmp6_send() that doesn't seems necessary as none of them are using the
force_saddr parameter.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/linux/icmpv6.h | 29 ++------------------------
 net/ipv6/icmp.c        |  6 ------
 net/ipv6/ip6_icmp.c    | 46 +++---------------------------------------
 3 files changed, 5 insertions(+), 76 deletions(-)

diff --git a/include/linux/icmpv6.h b/include/linux/icmpv6.h
index e3b3b0fa2a8f..2bd9f2157e6c 100644
--- a/include/linux/icmpv6.h
+++ b/include/linux/icmpv6.h
@@ -15,38 +15,13 @@ static inline struct icmp6hdr *icmp6_hdr(const struct sk_buff *skb)
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-typedef void ip6_icmp_send_t(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-			     const struct in6_addr *force_saddr,
-			     const struct inet6_skb_parm *parm);
 void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		const struct in6_addr *force_saddr,
 		const struct inet6_skb_parm *parm);
-#if IS_BUILTIN(CONFIG_IPV6)
-static inline void __icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-				 const struct inet6_skb_parm *parm)
-{
-	icmp6_send(skb, type, code, info, NULL, parm);
-}
-static inline int inet6_register_icmp_sender(ip6_icmp_send_t *fn)
-{
-	BUILD_BUG_ON(fn != icmp6_send);
-	return 0;
-}
-static inline int inet6_unregister_icmp_sender(ip6_icmp_send_t *fn)
-{
-	BUILD_BUG_ON(fn != icmp6_send);
-	return 0;
-}
-#else
-extern void __icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-			  const struct inet6_skb_parm *parm);
-extern int inet6_register_icmp_sender(ip6_icmp_send_t *fn);
-extern int inet6_unregister_icmp_sender(ip6_icmp_send_t *fn);
-#endif
 
 static inline void icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info)
 {
-	__icmpv6_send(skb, type, code, info, IP6CB(skb));
+	icmp6_send(skb, type, code, info, NULL, IP6CB(skb));
 }
 
 int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
@@ -58,7 +33,7 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info);
 static inline void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 {
 	struct inet6_skb_parm parm = { 0 };
-	__icmpv6_send(skb_in, type, code, info, &parm);
+	icmp6_send(skb_in, type, code, info, NULL, &parm);
 }
 #endif
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 813d2e9edb8b..8e8d7bd84a4c 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1288,13 +1288,8 @@ int __init icmpv6_init(void)
 	if (inet6_add_protocol(&icmpv6_protocol, IPPROTO_ICMPV6) < 0)
 		goto fail;
 
-	err = inet6_register_icmp_sender(icmp6_send);
-	if (err)
-		goto sender_reg_err;
 	return 0;
 
-sender_reg_err:
-	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
 fail:
 	pr_err("Failed to register ICMP6 protocol\n");
 	return err;
@@ -1302,7 +1297,6 @@ int __init icmpv6_init(void)
 
 void icmpv6_cleanup(void)
 {
-	inet6_unregister_icmp_sender(icmp6_send);
 	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
 }
 
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 233914b63bdb..e43ea9492332 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -7,47 +7,8 @@
 
 #include <net/ipv6.h>
 
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6) && IS_ENABLED(CONFIG_NF_NAT)
 
-#if !IS_BUILTIN(CONFIG_IPV6)
-
-static ip6_icmp_send_t __rcu *ip6_icmp_send;
-
-int inet6_register_icmp_sender(ip6_icmp_send_t *fn)
-{
-	return (cmpxchg((ip6_icmp_send_t **)&ip6_icmp_send, NULL, fn) == NULL) ?
-		0 : -EBUSY;
-}
-EXPORT_SYMBOL(inet6_register_icmp_sender);
-
-int inet6_unregister_icmp_sender(ip6_icmp_send_t *fn)
-{
-	int ret;
-
-	ret = (cmpxchg((ip6_icmp_send_t **)&ip6_icmp_send, fn, NULL) == fn) ?
-	      0 : -EINVAL;
-
-	synchronize_net();
-
-	return ret;
-}
-EXPORT_SYMBOL(inet6_unregister_icmp_sender);
-
-void __icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-		   const struct inet6_skb_parm *parm)
-{
-	ip6_icmp_send_t *send;
-
-	rcu_read_lock();
-	send = rcu_dereference(ip6_icmp_send);
-	if (send)
-		send(skb, type, code, info, NULL, parm);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(__icmpv6_send);
-#endif
-
-#if IS_ENABLED(CONFIG_NF_NAT)
 #include <net/netfilter/nf_conntrack.h>
 void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 {
@@ -60,7 +21,7 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 
 	ct = nf_ct_get(skb_in, &ctinfo);
 	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
-		__icmpv6_send(skb_in, type, code, info, &parm);
+		icmp6_send(skb_in, type, code, info, NULL, &parm);
 		return;
 	}
 
@@ -76,11 +37,10 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 	orig_ip = ipv6_hdr(skb_in)->saddr;
 	dir = CTINFO2DIR(ctinfo);
 	ipv6_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.in6;
-	__icmpv6_send(skb_in, type, code, info, &parm);
+	icmp6_send(skb_in, type, code, info, NULL, &parm);
 	ipv6_hdr(skb_in)->saddr = orig_ip;
 out:
 	consume_skb(cloned_skb);
 }
 EXPORT_SYMBOL(icmpv6_ndo_send);
 #endif
-#endif
-- 
2.53.0


