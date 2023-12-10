Return-Path: <netdev+bounces-55640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90580BC7F
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454181F20F39
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D419BDE;
	Sun, 10 Dec 2023 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjtbjOdc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0957083
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 10:01:32 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d9d0f4478so10341905ab.1
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702231291; x=1702836091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPL4XM2T1rPiNu0SkiWlWwV4Fu63GWve0kUvhEK/oaY=;
        b=gjtbjOdcYc4gKYP4UXlCFbbQkT7Moo8vq9RPqSOZCm2W4QQ/FYVCix+fbAlxBko3/f
         ANu59nSH14TRqp3nf1TCja/GcKk9RVigsKvd9q67JWZPvtV3lKF/xnYFZuhY2MNcHRaw
         OGIUafX/JETPsfjbvW1zIEfYUo8QXIGS2gbI4JZutb8Ck8cPxUrj51DapsSq9L9+H9vb
         7jyYUffwA2S5CPmFSVEkIqT6wU+rURsw/QFGFJ4t2e7phZg5dluKQkGcdqLPgxIY84nY
         VbBePsJYx2IWAbSs9bgcGp/Tn36AAm/kgsNxmtRJZan+qMD88hnd5u+VIsUQk2maxRvL
         jKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702231291; x=1702836091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPL4XM2T1rPiNu0SkiWlWwV4Fu63GWve0kUvhEK/oaY=;
        b=M2Z7rwk8K8Ny/pkvvhVxhgW9k2MXqvD7oPrikwDN1CHzuihu2/xL7e/M+YJAU4ANMR
         J26QM8NiEVbWFEOXDbMIC4uN7nj4JbTpKalHI5q4KGyvVRnraMatvFXJqI6tfxcmcljV
         nTpOpvX5YZUetSRHGMcmAQ3CCaQWaGBw7wr+N7vDEDm3P9hRO4un0qNDsEwpOoSDYldy
         M+wC+HfdYY+OsA/1b3lwL4Redl9As54fND0x6JhyvVdCn+5+PWA7lf+ruh6DK4cz/Fbk
         /zXfrlLOXwU/C7DOrKkjnjQlEBjatPAA7VWCRoRnBUVaf1J1CKQ5igtCfabbiWnm2kpf
         gBcQ==
X-Gm-Message-State: AOJu0YwRtEEQdO8Asbb13v6+OREeaT0nWLzSPCauXHP9FResqoNLsFJp
	3RWRsvuwWDS48LvY244djVE=
X-Google-Smtp-Source: AGHT+IHe67a1q8wXj+y0SkFLQAzSdaKyjE/NOHMEPvvsLnEV1K4JApObf1/8eTR/GEYadY1n8heElA==
X-Received: by 2002:a05:6e02:b44:b0:359:6e32:70ae with SMTP id f4-20020a056e020b4400b003596e3270aemr2875878ilu.4.1702231291128;
        Sun, 10 Dec 2023 10:01:31 -0800 (PST)
Received: from jimi.lan (076-088-114-163.res.spectrum.com. [76.88.114.163])
        by smtp.gmail.com with ESMTPSA id e19-20020a63e013000000b00578b40a4903sm4944863pgh.22.2023.12.10.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 10:01:30 -0800 (PST)
From: Eyal Birger <eyal.birger@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	pablo@netfilter.org,
	paul@nohats.ca,
	nharold@google.com
Cc: devel@linux-ipsec.org,
	netdev@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec-next,v2] xfrm: support sending NAT keepalives in ESP in UDP states
Date: Sun, 10 Dec 2023 10:01:16 -0800
Message-Id: <20231210180116.1737411-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ability to send out RFC-3948 NAT keepalives from the xfrm stack.

To use, Userspace sets an XFRM_NAT_KEEPALIVE_INTERVAL integer property when
creating XFRM outbound states which denotes the number of seconds between
keepalive messages.

Keepalive messages are sent from a per net delayed work which iterates over
the xfrm states. The logic is guarded by the xfrm state spinlock due to the
xfrm state walk iterator.

Possible future enhancements:

- Adding counters to keep track of sent keepalives.
- deduplicate NAT keepalives between states sharing the same nat keepalive
  parameters.
- provisioning hardware offloads for devices capable of implementing this.
- revise xfrm state list to use an rcu list in order to avoid running this
  under spinlock.

Suggested-by: Paul Wouters <paul@nohats.ca>
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

---

v2: change xfrm compat to include the new attribute
---
 include/net/ipv6_stubs.h      |   3 +
 include/net/netns/xfrm.h      |   1 +
 include/net/xfrm.h            |  10 ++
 include/uapi/linux/xfrm.h     |   1 +
 net/ipv6/af_inet6.c           |   1 +
 net/ipv6/xfrm6_policy.c       |   7 +
 net/xfrm/Makefile             |   3 +-
 net/xfrm/xfrm_compat.c        |   6 +-
 net/xfrm/xfrm_nat_keepalive.c | 291 ++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_policy.c        |   8 +
 net/xfrm/xfrm_state.c         |   9 ++
 net/xfrm/xfrm_user.c          |  20 ++-
 12 files changed, 356 insertions(+), 4 deletions(-)
 create mode 100644 net/xfrm/xfrm_nat_keepalive.c

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 485c39a89866..11cefd50704d 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -9,6 +9,7 @@
 #include <net/flow.h>
 #include <net/neighbour.h>
 #include <net/sock.h>
+#include <net/ipv6.h>
 
 /* structs from net/ip6_fib.h */
 struct fib6_info;
@@ -72,6 +73,8 @@ struct ipv6_stub {
 			     int (*output)(struct net *, struct sock *, struct sk_buff *));
 	struct net_device *(*ipv6_dev_find)(struct net *net, const struct in6_addr *addr,
 					    struct net_device *dev);
+	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
+			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 423b52eca908..d489d9250bff 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -83,6 +83,7 @@ struct netns_xfrm {
 
 	spinlock_t xfrm_policy_lock;
 	struct mutex xfrm_cfg_mutex;
+	struct delayed_work	nat_keepalive_work;
 };
 
 #endif
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index c9bb0f892f55..0699d64d47e3 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -227,6 +227,10 @@ struct xfrm_state {
 	struct xfrm_encap_tmpl	*encap;
 	struct sock __rcu	*encap_sk;
 
+	/* NAT keepalive */
+	u32			nat_keepalive_interval; /* seconds */
+	time64_t		nat_keepalive_expiration;
+
 	/* Data for care-of address */
 	xfrm_address_t	*coaddr;
 
@@ -2190,4 +2194,10 @@ static inline int register_xfrm_interface_bpf(void)
 
 #endif
 
+int xfrm_nat_keepalive_init(unsigned short family);
+void xfrm_nat_keepalive_fini(unsigned short family);
+int xfrm_nat_keepalive_net_init(struct net *net);
+int xfrm_nat_keepalive_net_fini(struct net *net);
+void xfrm_nat_keepalive_state_updated(struct xfrm_state *x);
+
 #endif	/* _NET_XFRM_H */
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..438478209229 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -315,6 +315,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_NAT_KEEPALIVE_INTERVAL,	/* __u32 in seconds for NAT keepalive */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 13a1833a4df5..c3ce88a50578 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1056,6 +1056,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.nd_tbl	= &nd_tbl,
 	.ipv6_fragment = ip6_fragment,
 	.ipv6_dev_find = ipv6_dev_find,
+	.ip6_xmit = ip6_xmit,
 };
 
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 42fb6996b077..f03dbc011e65 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -285,8 +285,14 @@ int __init xfrm6_init(void)
 	ret = register_pernet_subsys(&xfrm6_net_ops);
 	if (ret)
 		goto out_protocol;
+
+	ret = xfrm_nat_keepalive_init(AF_INET6);
+	if (ret)
+		goto out_nat_keepalive;
 out:
 	return ret;
+out_nat_keepalive:
+	unregister_pernet_subsys(&xfrm6_net_ops);
 out_protocol:
 	xfrm6_protocol_fini();
 out_state:
@@ -298,6 +304,7 @@ int __init xfrm6_init(void)
 
 void xfrm6_fini(void)
 {
+	xfrm_nat_keepalive_fini(AF_INET6);
 	unregister_pernet_subsys(&xfrm6_net_ops);
 	xfrm6_protocol_fini();
 	xfrm6_policy_fini();
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index cd47f88921f5..656a29f025c6 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -13,7 +13,8 @@ endif
 
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
 		      xfrm_input.o xfrm_output.o \
-		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o
+		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o \
+		      xfrm_nat_keepalive.o
 obj-$(CONFIG_XFRM_STATISTICS) += xfrm_proc.o
 obj-$(CONFIG_XFRM_ALGO) += xfrm_algo.o
 obj-$(CONFIG_XFRM_USER) += xfrm_user.o
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 655fe4ff8621..5ad309683689 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -129,6 +129,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
+	[XFRMA_NAT_KEEPALIVE_INTERVAL]	= { .type = NLA_U32 },
 };
 
 static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
@@ -277,9 +278,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_SET_MARK_MASK:
 	case XFRMA_IF_ID:
 	case XFRMA_MTIMER_THRESH:
+	case XFRMA_NAT_KEEPALIVE_INTERVAL:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -434,7 +436,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;
 
 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
new file mode 100644
index 000000000000..71dba27752a4
--- /dev/null
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xfrm_nat_keepalive.c
+ *
+ * (c) 2023 Eyal Birger <eyal.birger@gmail.com>
+ */
+
+#include <net/inet_common.h>
+#include <net/xfrm.h>
+
+static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv4);
+#if IS_ENABLED(CONFIG_IPV6)
+static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv6);
+#endif
+
+struct nat_keepalive {
+	struct net *net;
+	u16 family;
+	xfrm_address_t saddr;
+	xfrm_address_t daddr;
+	__be16 encap_sport;
+	__be16 encap_dport;
+	__u32 smark;
+};
+
+static void nat_keepalive_init(struct nat_keepalive *ka, struct xfrm_state *x)
+{
+	ka->net = xs_net(x);
+	ka->family = x->props.family;
+	ka->saddr = x->props.saddr;
+	ka->daddr = x->id.daddr;
+	ka->encap_sport = x->encap->encap_sport;
+	ka->encap_dport = x->encap->encap_dport;
+	ka->smark = xfrm_smark_get(0, x);
+}
+
+static int nat_keepalive_send_ipv4(struct sk_buff *skb,
+				   struct nat_keepalive *ka)
+{
+	struct net *net = ka->net;
+	struct flowi4 fl4;
+	struct rtable *rt;
+	struct sock *sk;
+	__u8 tos = 0;
+	int err;
+
+	flowi4_init_output(&fl4, 0 /* oif */, skb->mark, tos,
+			   RT_SCOPE_UNIVERSE, IPPROTO_UDP, 0,
+			   ka->daddr.a4, ka->saddr.a4, ka->encap_dport,
+			   ka->encap_sport, sock_net_uid(net, NULL));
+
+	rt = ip_route_output_key(net, &fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+
+	skb_dst_set(skb, &rt->dst);
+
+	sk = *this_cpu_ptr(&nat_keepalive_sk_ipv4);
+	sock_net_set(sk, net);
+	err = ip_build_and_send_pkt(skb, sk, fl4.saddr, fl4.daddr, NULL, tos);
+	sock_net_set(sk, &init_net);
+	return err;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int nat_keepalive_send_ipv6(struct sk_buff *skb,
+				   struct nat_keepalive *ka,
+				   struct udphdr *uh)
+{
+	struct net *net = ka->net;
+	struct dst_entry *dst;
+	struct flowi6 fl6;
+	struct sock *sk;
+	__wsum csum;
+	int err;
+
+	csum = skb_checksum(skb, 0, skb->len, 0);
+	uh->check = csum_ipv6_magic(&ka->saddr.in6, &ka->daddr.in6,
+				    skb->len, IPPROTO_UDP, csum);
+	if (uh->check == 0)
+		uh->check = CSUM_MANGLED_0;
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_mark = skb->mark;
+	fl6.saddr = ka->saddr.in6;
+	fl6.daddr = ka->daddr.in6;
+	fl6.flowi6_proto = IPPROTO_UDP;
+	fl6.fl6_sport = ka->encap_sport;
+	fl6.fl6_dport = ka->encap_dport;
+
+	sk = *this_cpu_ptr(&nat_keepalive_sk_ipv6);
+	sock_net_set(sk, net);
+	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
+	if (IS_ERR(dst))
+		return PTR_ERR(dst);
+
+	skb_dst_set(skb, dst);
+	err = ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
+	sock_net_set(sk, &init_net);
+	return err;
+}
+#endif
+
+static void nat_keepalive_send(struct nat_keepalive *ka)
+{
+	const int nat_ka_hdrs_len = max(sizeof(struct iphdr),
+					sizeof(struct ipv6hdr)) +
+				    sizeof(struct udphdr);
+	const u8 nat_ka_payload = 0xFF;
+	int err = -EAFNOSUPPORT;
+	struct sk_buff *skb;
+	struct udphdr *uh;
+
+	skb = alloc_skb(nat_ka_hdrs_len + sizeof(nat_ka_payload), GFP_ATOMIC);
+	if (unlikely(!skb))
+		return;
+
+	skb_reserve(skb, nat_ka_hdrs_len);
+
+	skb_put_u8(skb, nat_ka_payload);
+
+	uh = skb_push(skb, sizeof(*uh));
+	uh->source = ka->encap_sport;
+	uh->dest = ka->encap_dport;
+	uh->len = htons(skb->len);
+	uh->check = 0;
+
+	skb->mark = ka->smark;
+
+	switch (ka->family) {
+	case AF_INET:
+		err = nat_keepalive_send_ipv4(skb, ka);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		err = nat_keepalive_send_ipv6(skb, ka, uh);
+		break;
+#endif
+	}
+	if (err)
+		kfree_skb(skb);
+}
+
+struct nat_keepalive_work_ctx {
+	time64_t next_run;
+	time64_t now;
+};
+
+static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
+{
+	struct nat_keepalive_work_ctx *ctx = ptr;
+	bool send_keepalive = false;
+	struct nat_keepalive ka;
+	time64_t next_run;
+	u32 interval;
+	int delta;
+
+	interval = x->nat_keepalive_interval;
+	if (!interval)
+		return 0;
+
+	spin_lock(&x->lock);
+
+	delta = (int)(ctx->now - x->lastused);
+	if (delta < interval) {
+		x->nat_keepalive_expiration = ctx->now + interval - delta;
+		next_run = x->nat_keepalive_expiration;
+	} else if (x->nat_keepalive_expiration > ctx->now) {
+		next_run = x->nat_keepalive_expiration;
+	} else {
+		next_run = ctx->now + interval;
+		nat_keepalive_init(&ka, x);
+		send_keepalive = true;
+	}
+
+	spin_unlock(&x->lock);
+
+	if (send_keepalive)
+		nat_keepalive_send(&ka);
+
+	if (!ctx->next_run || next_run < ctx->next_run)
+		ctx->next_run = next_run;
+	return 0;
+}
+
+static void nat_keepalive_work(struct work_struct *work)
+{
+	struct nat_keepalive_work_ctx ctx;
+	struct xfrm_state_walk walk;
+	struct net *net;
+
+	ctx.next_run = 0;
+	ctx.now = ktime_get_real_seconds();
+
+	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
+	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
+	xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
+	xfrm_state_walk_done(&walk, net);
+	if (ctx.next_run)
+		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
+				      (ctx.next_run - ctx.now) * HZ);
+}
+
+static int nat_keepalive_sk_init(struct sock * __percpu *socks,
+				 unsigned short family)
+{
+	struct sock *sk;
+	int err, i;
+
+	for_each_possible_cpu(i) {
+		err = inet_ctl_sock_create(&sk, family, SOCK_RAW, IPPROTO_UDP,
+					   &init_net);
+		if (err < 0)
+			goto err;
+
+		*per_cpu_ptr(socks, i) = sk;
+	}
+
+	return 0;
+err:
+	for_each_possible_cpu(i)
+		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
+	return err;
+}
+
+static void nat_keepalive_sk_fini(struct sock * __percpu *socks)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
+}
+
+void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
+{
+	struct net *net;
+
+	if (!x->nat_keepalive_interval)
+		return;
+
+	net = xs_net(x);
+	schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
+}
+
+int __net_init xfrm_nat_keepalive_net_init(struct net *net)
+{
+	INIT_DELAYED_WORK(&net->xfrm.nat_keepalive_work, nat_keepalive_work);
+	return 0;
+}
+
+int xfrm_nat_keepalive_net_fini(struct net *net)
+{
+	cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
+	return 0;
+}
+
+int xfrm_nat_keepalive_init(unsigned short family)
+{
+	int err = -EAFNOSUPPORT;
+
+	switch (family) {
+	case AF_INET:
+		err = nat_keepalive_sk_init(&nat_keepalive_sk_ipv4, PF_INET);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		err = nat_keepalive_sk_init(&nat_keepalive_sk_ipv6, PF_INET6);
+		break;
+#endif
+	}
+
+	if (err)
+		pr_err("xfrm nat keepalive init: failed to init err:%d\n", err);
+	return err;
+}
+EXPORT_SYMBOL_GPL(xfrm_nat_keepalive_init);
+
+void xfrm_nat_keepalive_fini(unsigned short family)
+{
+	switch (family) {
+	case AF_INET:
+		nat_keepalive_sk_fini(&nat_keepalive_sk_ipv4);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		nat_keepalive_sk_fini(&nat_keepalive_sk_ipv6);
+		break;
+#endif
+	}
+}
+EXPORT_SYMBOL_GPL(xfrm_nat_keepalive_fini);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef7910..f62dcab1d717 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4145,8 +4145,14 @@ static int __net_init xfrm_net_init(struct net *net)
 	if (rv < 0)
 		goto out_sysctl;
 
+	rv = xfrm_nat_keepalive_net_init(net);
+	if (rv < 0)
+		goto out_nat_keepalive;
+
 	return 0;
 
+out_nat_keepalive:
+	xfrm_sysctl_fini(net);
 out_sysctl:
 	xfrm_policy_fini(net);
 out_policy:
@@ -4159,6 +4165,7 @@ static int __net_init xfrm_net_init(struct net *net)
 
 static void __net_exit xfrm_net_exit(struct net *net)
 {
+	xfrm_nat_keepalive_net_fini(net);
 	xfrm_sysctl_fini(net);
 	xfrm_policy_fini(net);
 	xfrm_state_fini(net);
@@ -4218,6 +4225,7 @@ void __init xfrm_init(void)
 #ifdef CONFIG_XFRM_ESPINTCP
 	espintcp_init();
 #endif
+	xfrm_nat_keepalive_init(AF_INET);
 }
 
 #ifdef CONFIG_AUDITSYSCALL
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bda5327bf34d..3bd767e13dba 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -715,6 +715,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		if (x->id.spi)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
+		xfrm_nat_keepalive_state_updated(x);
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
 		if (x->encap_sk)
@@ -1452,6 +1453,7 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 	net->xfrm.state_num++;
 
 	xfrm_hash_grow_check(net, x->bydst.next != NULL);
+	xfrm_nat_keepalive_state_updated(x);
 }
 
 /* net->xfrm.xfrm_state_lock is held */
@@ -2850,6 +2852,13 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
 			goto error;
 	}
 
+	if (x->nat_keepalive_interval &&
+	    (!x->encap || x->encap->encap_type != UDP_ENCAP_ESPINUDP)) {
+		NL_SET_ERR_MSG(extack, "NAT keepalive only supported for UDP encapsulation");
+		err = -EINVAL;
+		goto error;
+	}
+
 error:
 	return err;
 }
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..de31df7b0d4e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -734,6 +734,10 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if (attrs[XFRMA_IF_ID])
 		x->if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
 
+	if (attrs[XFRMA_NAT_KEEPALIVE_INTERVAL])
+		x->nat_keepalive_interval =
+			nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]);
+
 	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
 	if (err)
 		goto error;
@@ -1182,8 +1186,17 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
-	if (x->mapping_maxage)
+	if (x->mapping_maxage) {
 		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
+		if (ret)
+			goto out;
+	}
+	if (x->nat_keepalive_interval) {
+		ret = nla_put_u32(skb, XFRMA_NAT_KEEPALIVE_INTERVAL,
+				  x->nat_keepalive_interval);
+		if (ret)
+			goto out;
+	}
 out:
 	return ret;
 }
@@ -3015,6 +3028,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
 #undef XMSGSIZE
 
 const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_NAT_KEEPALIVE_INTERVAL },
 	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -3046,6 +3060,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_NAT_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
@@ -3321,6 +3336,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));
 
+	if (x->nat_keepalive_interval)
+		l += nla_total_size(sizeof(x->nat_keepalive_interval));
+
 	return l;
 }
 
-- 
2.40.1


