Return-Path: <netdev+bounces-266225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOyWOPVJsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:42:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7B255000
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28D9F318FBE1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7039C01F;
	Tue, 10 Mar 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yeaW4FrK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aw2rneJv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yeaW4FrK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aw2rneJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176B3A1689
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157059; cv=none; b=EZ5F5VU/+uUniE39cAfAWro5WBDZ9nr5mjgufPVWyrdYqaxSN2Pr3hNcUJQGsoCUFeS/H5mNeiQmv9PN3wmwe9p3VIrcqUalwjx5kfX/h2gBeUB3ijyloqDXpAQ+ua3sEQLPoP7FbszNgVVOtRaL9LgmMOjsQIs/xwQG+WKoQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157059; c=relaxed/simple;
	bh=GrBJ8KgLDjzpDsC4+lsoO34Wi6iwbKlPguJNjP1d9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSptaopQ/2DBFeiYSSZWcu5wXOpVG9KDdgCE20yV50nvm+WfBFJ+XGAK7o37tIKLGnnqr3tHrl/QyLezsWV3kUobvjBZJObCcp7OKqCes1vW+Qd5q/VHnOv0hWh+wsw0b+4HeBKxuEyDbLxCsq0pwbdKehoyOM/aYk0bOKVeTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yeaW4FrK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aw2rneJv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yeaW4FrK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aw2rneJv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6D1E5BCEA;
	Tue, 10 Mar 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773157055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNUCJFxoUAdE23YTl9IMhJP5SV/0oDKXCGWqAEKpeN8=;
	b=yeaW4FrKrW+eKl+QF9ZIMvrxFE69M7oJdvu1cI9xk57s+k0YNDVMWQzEFIW2Z3R99TVg/9
	vJN7X8+XyfuOSjutCyjJxc1KaY1bhsCBGBONPgrG+E5z8PUyEwJCdvFtiKk3FmeGj3VwQo
	rnOTrbdg/kdUzNxTWc77MFStE4RRtmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773157055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNUCJFxoUAdE23YTl9IMhJP5SV/0oDKXCGWqAEKpeN8=;
	b=aw2rneJvS1VlRrzjpU8CmSRcH7FDVDEqZW5wLuFH6V1PSjUBt0LS7rlZAJC2kS2ozMWXJY
	WWQWLvi17MLe7LCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773157055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNUCJFxoUAdE23YTl9IMhJP5SV/0oDKXCGWqAEKpeN8=;
	b=yeaW4FrKrW+eKl+QF9ZIMvrxFE69M7oJdvu1cI9xk57s+k0YNDVMWQzEFIW2Z3R99TVg/9
	vJN7X8+XyfuOSjutCyjJxc1KaY1bhsCBGBONPgrG+E5z8PUyEwJCdvFtiKk3FmeGj3VwQo
	rnOTrbdg/kdUzNxTWc77MFStE4RRtmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773157055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNUCJFxoUAdE23YTl9IMhJP5SV/0oDKXCGWqAEKpeN8=;
	b=aw2rneJvS1VlRrzjpU8CmSRcH7FDVDEqZW5wLuFH6V1PSjUBt0LS7rlZAJC2kS2ozMWXJY
	WWQWLvi17MLe7LCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39D323F519;
	Tue, 10 Mar 2026 15:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PrFCr46sGlKXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 10 Mar 2026 15:37:34 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: rbm@suse.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH 08/10 net-next v2] bpf: remove ipv6_bpf_stub completely and use direct function calls
Date: Tue, 10 Mar 2026 16:34:31 +0100
Message-ID: <20260310153506.5181-9-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310153506.5181-1-fmancera@suse.de>
References: <20260310153506.5181-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3BB7B255000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,suse.de,davemloft.net,kernel.org,google.com,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266225-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

As IPv6 is built-in only, the ipv6_bpf_stub can be removed completely.

Convert all ipv6_bpf_stub usage to direct function calls instead. The
fallback functions introduced previously will prevent linkage errors
when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
---
 include/net/ipv6.h       |  2 ++
 include/net/ipv6_stubs.h | 21 ---------------
 net/core/filter.c        | 56 +++++++++++++++++-----------------------
 net/core/lwt_bpf.c       | 10 ++++---
 net/ipv6/af_inet6.c      | 15 +++++------
 5 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 06d1fa54cbf7..c55a5e60e821 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1151,6 +1151,8 @@ void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
 int inet6_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len);
 int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
+int inet6_bind_flags(struct sock *sk, struct sockaddr_unsized *uaddr,
+		     int addr_len, u32 flags);
 int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		  int peer);
 int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index d3013e721b14..c5c049b4473f 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -78,25 +78,4 @@ struct ipv6_stub {
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
-/* A stub used by bpf helpers. Similarly ugly as ipv6_stub */
-struct ipv6_bpf_stub {
-	int (*inet6_bind)(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
-			  u32 flags);
-	struct sock *(*udp6_lib_lookup)(const struct net *net,
-				     const struct in6_addr *saddr, __be16 sport,
-				     const struct in6_addr *daddr, __be16 dport,
-				     int dif, int sdif, struct udp_table *tbl,
-				     struct sk_buff *skb);
-	int (*ipv6_setsockopt)(struct sock *sk, int level, int optname,
-			       sockptr_t optval, unsigned int optlen);
-	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
-			       sockptr_t optval, sockptr_t optlen);
-	int (*ipv6_dev_get_saddr)(struct net *net,
-				  const struct net_device *dst_dev,
-				  const struct in6_addr *daddr,
-				  unsigned int prefs,
-				  struct in6_addr *saddr);
-};
-extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
-
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index 62cae2bcc562..ae395b2b7966 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -73,7 +73,6 @@
 #include <net/seg6.h>
 #include <net/seg6_local.h>
 #include <net/lwtunnel.h>
-#include <net/ipv6_stubs.h>
 #include <net/bpf_sk_storage.h>
 #include <net/transp_v6.h>
 #include <linux/btf_ids.h>
@@ -2276,7 +2275,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 			.saddr	      = ip6h->saddr,
 		};
 
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+		dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
 		if (IS_ERR(dst))
 			goto out_drop;
 
@@ -5570,12 +5569,12 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 	}
 
 	if (getopt)
-		return ipv6_bpf_stub->ipv6_getsockopt(sk, SOL_IPV6, optname,
-						      KERNEL_SOCKPTR(optval),
-						      KERNEL_SOCKPTR(optlen));
+		return do_ipv6_getsockopt(sk, SOL_IPV6, optname,
+					  KERNEL_SOCKPTR(optval),
+					  KERNEL_SOCKPTR(optlen));
 
-	return ipv6_bpf_stub->ipv6_setsockopt(sk, SOL_IPV6, optname,
-					      KERNEL_SOCKPTR(optval), *optlen);
+	return do_ipv6_setsockopt(sk, SOL_IPV6, optname,
+				  KERNEL_SOCKPTR(optval), *optlen);
 }
 
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
@@ -5974,9 +5973,6 @@ static const struct bpf_func_proto bpf_sock_ops_cb_flags_set_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
-EXPORT_SYMBOL_GPL(ipv6_bpf_stub);
-
 BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 	   int, addr_len)
 {
@@ -6000,11 +5996,9 @@ BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
 			return err;
 		if (((struct sockaddr_in6 *)addr)->sin6_port == htons(0))
 			flags |= BIND_FORCE_ADDRESS_NO_PORT;
-		/* ipv6_bpf_stub cannot be NULL, since it's called from
-		 * bpf_cgroup_inet6_connect hook and ipv6 is already loaded
-		 */
-		return ipv6_bpf_stub->inet6_bind(sk, (struct sockaddr_unsized *)addr,
-						 addr_len, flags);
+
+		return inet6_bind_flags(sk, (struct sockaddr_unsized *)addr,
+					addr_len, flags);
 #endif /* CONFIG_IPV6 */
 	}
 #endif /* CONFIG_INET */
@@ -6215,7 +6209,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		neigh = __ipv4_neigh_lookup_noref(dev,
 						  (__force u32)params->ipv4_dst);
 	else
-		neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
+		neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);
 
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
@@ -6283,12 +6277,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			params->tbid = 0;
 		}
 
-		tb = ipv6_stub->fib6_get_table(net, tbid);
+		tb = fib6_get_table(net, tbid);
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
-						   strict);
+		err = fib6_table_lookup(net, tb, oif, &fl6, &res, strict);
 	} else {
 		if (flags & BPF_FIB_LOOKUP_MARK)
 			fl6.flowi6_mark = params->mark;
@@ -6298,7 +6291,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl6.flowi6_tun_key.tun_id = 0;
 		fl6.flowi6_uid = sock_net_uid(net, NULL);
 
-		err = ipv6_stub->fib6_lookup(net, oif, &fl6, &res, strict);
+		err = fib6_lookup(net, oif, &fl6, &res, strict);
 	}
 
 	if (unlikely(err || IS_ERR_OR_NULL(res.f6i) ||
@@ -6319,11 +6312,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		return BPF_FIB_LKUP_RET_NOT_FWDED;
 	}
 
-	ipv6_stub->fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
-				    fl6.flowi6_oif != 0, NULL, strict);
+	fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
+			 fl6.flowi6_oif != 0, NULL, strict);
 
 	if (check_mtu) {
-		mtu = ipv6_stub->ip6_mtu_from_fib6(&res, dst, src);
+		mtu = ip6_mtu_from_fib6(&res, dst, src);
 		if (params->tot_len > mtu) {
 			params->mtu_result = mtu; /* union with tot_len */
 			return BPF_FIB_LKUP_RET_FRAG_NEEDED;
@@ -6344,9 +6337,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		if (res.f6i->fib6_prefsrc.plen) {
 			*src = res.f6i->fib6_prefsrc.addr;
 		} else {
-			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
-								&fl6.daddr, 0,
-								src);
+			err = ipv6_dev_get_saddr(net, dev, &fl6.daddr, 0, src);
 			if (err)
 				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
 		}
@@ -6358,7 +6349,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	/* xdp and cls_bpf programs are run in RCU-bh so rcu_read_lock_bh is
 	 * not needed here.
 	 */
-	neigh = __ipv6_neigh_lookup_noref_stub(dev, dst);
+	neigh = __ipv6_neigh_lookup_noref(dev, dst);
 	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
 	memcpy(params->dmac, neigh->ha, ETH_ALEN);
@@ -6893,12 +6884,11 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 					    src6, tuple->ipv6.sport,
 					    dst6, ntohs(tuple->ipv6.dport),
 					    dif, sdif, &refcounted);
-		else if (likely(ipv6_bpf_stub))
-			sk = ipv6_bpf_stub->udp6_lib_lookup(net,
-							    src6, tuple->ipv6.sport,
-							    dst6, tuple->ipv6.dport,
-							    dif, sdif,
-							    net->ipv4.udp_table, NULL);
+		else
+			sk = __udp6_lib_lookup(net, src6, tuple->ipv6.sport,
+					       dst6, tuple->ipv6.dport,
+					       dif, sdif,
+					       net->ipv4.udp_table, NULL);
 #endif
 	}
 
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 9f40be0c3e71..f71ef82a5f3d 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -13,7 +13,6 @@
 #include <net/gre.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
-#include <net/ipv6_stubs.h>
 
 struct bpf_lwt_prog {
 	struct bpf_prog *prog;
@@ -103,7 +102,12 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
-		err = ipv6_stub->ipv6_route_input(skb);
+		if (IS_ENABLED(CONFIG_IPV6)) {
+			ip6_route_input(skb);
+			err = skb_dst(skb)->error;
+		} else {
+			err = -EAFNOSUPPORT;
+		}
 	} else {
 		err = -EAFNOSUPPORT;
 	}
@@ -233,7 +237,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl6.daddr = iph6->daddr;
 		fl6.saddr = iph6->saddr;
 
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
+		dst = ip6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
 		if (IS_ERR(dst)) {
 			err = PTR_ERR(dst);
 			goto err;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 448be9704313..75a9d9fe1308 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -460,6 +460,12 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 	return __inet6_bind(sk, uaddr, addr_len, flags);
 }
 
+int inet6_bind_flags(struct sock *sk, struct sockaddr_unsized *uaddr,
+		     int addr_len, u32 flags)
+{
+	return __inet6_bind(sk, uaddr, addr_len, flags);
+}
+
 /* bind for INET6 API */
 int inet6_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
 {
@@ -1050,14 +1056,6 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.ip6_xmit = ip6_xmit,
 };
 
-static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
-	.inet6_bind = __inet6_bind,
-	.udp6_lib_lookup = __udp6_lib_lookup,
-	.ipv6_setsockopt = do_ipv6_setsockopt,
-	.ipv6_getsockopt = do_ipv6_getsockopt,
-	.ipv6_dev_get_saddr = ipv6_dev_get_saddr,
-};
-
 static int __init inet6_init(void)
 {
 	struct list_head *r;
@@ -1227,7 +1225,6 @@ static int __init inet6_init(void)
 	/* ensure that ipv6 stubs are visible only after ipv6 is ready */
 	wmb();
 	ipv6_stub = &ipv6_stub_impl;
-	ipv6_bpf_stub = &ipv6_bpf_stub_impl;
 out:
 	return err;
 
-- 
2.53.0


