Return-Path: <netdev+bounces-102459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3890317D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2F01C20C34
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB342A93;
	Tue, 11 Jun 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ssMbNhiX"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547468488
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084785; cv=none; b=b+O48vbB/KP6GK929zGMxoEgLk+C4Y0P6zBmwrrikhxuo2Ifn7AOy68LxWvSCVx83xC97FaESWlzTT192R3s4CcQPB7bB6auZXfwkN5tuv0H39i/rCYXeyMOlX5Kf3l/hIt51LsD3b9XiKpnM/SzU897UM6ICy1hhZEIbNSeBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084785; c=relaxed/simple;
	bh=BCAR8qa4aqSUblrje24sS8JyUG69JqxxEU5k8Pf1oYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G19Jff1uHp2QuXI3A57+o67NDftSrEi6m9Nikn74J0JpSG4Q13xwdcYQ8NaFMANz9U1x14uQ/qv5m/2XnmYw11t8vMwi2VDn7DPK1bN8NfoasaOzQVeURNQUWw7MecYDy7RCr5QXeFjiObrp6bEZAV5JF736U/u5/jSMDfsWNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=ssMbNhiX; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: c38d994c-27b5-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c38d994c-27b5-11ef-836c-005056aba152;
	Tue, 11 Jun 2024 07:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=XJ9ngfkiEWblxCMpMpal0PcBiLHFxLBvHFlQjujKUpQ=;
	b=ssMbNhiX7LxPJNVXICv2mi5KTAWXalntaBhk79vpgLS4ntzZZQ8iSjvEXrd5/JZQPjmNtl7MwfHzo
	 wdlewO0YepmrgoKWxCCOuA13iaej5p3lsqAAOkHMAg9t/FYTIDMVLZt1Rv8ms/BxtfFizYd9OtT3s1
	 Io9DCK4lmwXINTeg=
X-KPN-MID: 33|CbKvWLdAU5MYXMnhTQhyOLckropd7cs4RfAm6yZs1fYEHGDELG5wbgaM/aN94Uy
 9jojJNs1AJE01M3wcK40ChnRmLgcKU4DgmiwCGjOImwI=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|pKTOit7lOSJy0Sbc7clalCZtMOprjpsNfVpgfSktJGxHx+0R9l7k2Yr5Ao0qAb5
 fpESLgXIhzW2tVvo27rxqbA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c2fdeec9-27b5-11ef-a091-005056abf0db;
	Tue, 11 Jun 2024 07:45:09 +0200 (CEST)
Date: Tue, 11 Jun 2024 07:45:08 +0200
From: Antony Antony <antony@phenome.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, pablo@netfilter.org,
	paul.wouters@aiven.io, nharold@google.com, mcr@sandelman.ca,
	devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next,v4] xfrm: support sending NAT keepalives in
 ESP in UDP states
Message-ID: <ZmfkZLBpWmv20hGE@Antony2201.local>
References: <20240528032914.2551267-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528032914.2551267-1-eyal.birger@gmail.com>

Hi Eyal,

On Mon, May 27, 2024 at 08:29:14PM -0700, Eyal Birger wrote:
> Add the ability to send out RFC-3948 NAT keepalives from the xfrm stack.
> 
> To use, Userspace sets an XFRM_NAT_KEEPALIVE_INTERVAL integer property when
> creating XFRM outbound states which denotes the number of seconds between
> keepalive messages.
> 
> Keepalive messages are sent from a per net delayed work which iterates over
> the xfrm states. The logic is guarded by the xfrm state spinlock due to the
> xfrm state walk iterator.
> 
> Possible future enhancements:
> 
> - Adding counters to keep track of sent keepalives.
> - deduplicate NAT keepalives between states sharing the same nat keepalive
>   parameters.
> - provisioning hardware offloads for devices capable of implementing this.
> - revise xfrm state list to use an rcu list in order to avoid running this
>   under spinlock.
> 
> Suggested-by: Paul Wouters <paul.wouters@aiven.io>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> ---
> v4: rebase and explicitly check that keepalive is only configured on
>     outbound SAs
> v3: add missing ip6_checksum header
> v2: change xfrm compat to include the new attribute
> ---
>  include/net/ipv6_stubs.h      |   3 +
>  include/net/netns/xfrm.h      |   1 +
>  include/net/xfrm.h            |  10 ++
>  include/uapi/linux/xfrm.h     |   1 +
>  net/ipv6/af_inet6.c           |   1 +
>  net/ipv6/xfrm6_policy.c       |   7 +
>  net/xfrm/Makefile             |   3 +-
>  net/xfrm/xfrm_compat.c        |   6 +-
>  net/xfrm/xfrm_nat_keepalive.c | 292 ++++++++++++++++++++++++++++++++++
>  net/xfrm/xfrm_policy.c        |   8 +
>  net/xfrm/xfrm_state.c         |  17 ++
>  net/xfrm/xfrm_user.c          |  15 ++
>  12 files changed, 361 insertions(+), 3 deletions(-)
>  create mode 100644 net/xfrm/xfrm_nat_keepalive.c
> 
> diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
> index 485c39a89866..11cefd50704d 100644
> --- a/include/net/ipv6_stubs.h
> +++ b/include/net/ipv6_stubs.h
> @@ -9,6 +9,7 @@
>  #include <net/flow.h>
>  #include <net/neighbour.h>
>  #include <net/sock.h>
> +#include <net/ipv6.h>
>  
>  /* structs from net/ip6_fib.h */
>  struct fib6_info;
> @@ -72,6 +73,8 @@ struct ipv6_stub {
>  			     int (*output)(struct net *, struct sock *, struct sk_buff *));
>  	struct net_device *(*ipv6_dev_find)(struct net *net, const struct in6_addr *addr,
>  					    struct net_device *dev);
> +	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
> +			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
>  };
>  extern const struct ipv6_stub *ipv6_stub __read_mostly;
>  
> diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
> index 423b52eca908..d489d9250bff 100644
> --- a/include/net/netns/xfrm.h
> +++ b/include/net/netns/xfrm.h
> @@ -83,6 +83,7 @@ struct netns_xfrm {
>  
>  	spinlock_t xfrm_policy_lock;
>  	struct mutex xfrm_cfg_mutex;
> +	struct delayed_work	nat_keepalive_work;
>  };
>  
>  #endif
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 7c9be06f8302..e208907b1a00 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -229,6 +229,10 @@ struct xfrm_state {
>  	struct xfrm_encap_tmpl	*encap;
>  	struct sock __rcu	*encap_sk;
>  
> +	/* NAT keepalive */
> +	u32			nat_keepalive_interval; /* seconds */
> +	time64_t		nat_keepalive_expiration;
> +
>  	/* Data for care-of address */
>  	xfrm_address_t	*coaddr;
>  
> @@ -2200,4 +2204,10 @@ static inline int register_xfrm_state_bpf(void)
>  }
>  #endif
>  
> +int xfrm_nat_keepalive_init(unsigned short family);
> +void xfrm_nat_keepalive_fini(unsigned short family);
> +int xfrm_nat_keepalive_net_init(struct net *net);
> +int xfrm_nat_keepalive_net_fini(struct net *net);
> +void xfrm_nat_keepalive_state_updated(struct xfrm_state *x);
> +
>  #endif	/* _NET_XFRM_H */
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index 18ceaba8486e..7744441c8d5f 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -321,6 +321,7 @@ enum xfrm_attr_type_t {
>  	XFRMA_IF_ID,		/* __u32 */
>  	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
>  	XFRMA_SA_DIR,		/* __u8 */
> +	XFRMA_NAT_KEEPALIVE_INTERVAL,	/* __u32 in seconds for NAT keepalive */
>  	__XFRMA_MAX
>  
>  #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 8041dc181bd4..2b893858b9a9 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -1060,6 +1060,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
>  	.nd_tbl	= &nd_tbl,
>  	.ipv6_fragment = ip6_fragment,
>  	.ipv6_dev_find = ipv6_dev_find,
> +	.ip6_xmit = ip6_xmit,
>  };
>  
>  static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index 42fb6996b077..f03dbc011e65 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -285,8 +285,14 @@ int __init xfrm6_init(void)
>  	ret = register_pernet_subsys(&xfrm6_net_ops);
>  	if (ret)
>  		goto out_protocol;
> +
> +	ret = xfrm_nat_keepalive_init(AF_INET6);
> +	if (ret)
> +		goto out_nat_keepalive;
>  out:
>  	return ret;
> +out_nat_keepalive:
> +	unregister_pernet_subsys(&xfrm6_net_ops);
>  out_protocol:
>  	xfrm6_protocol_fini();
>  out_state:
> @@ -298,6 +304,7 @@ int __init xfrm6_init(void)
>  
>  void xfrm6_fini(void)
>  {
> +	xfrm_nat_keepalive_fini(AF_INET6);
>  	unregister_pernet_subsys(&xfrm6_net_ops);
>  	xfrm6_protocol_fini();
>  	xfrm6_policy_fini();
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index 547cec77ba03..512e0b2f8514 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -13,7 +13,8 @@ endif
>  
>  obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
>  		      xfrm_input.o xfrm_output.o \
> -		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o
> +		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o \
> +		      xfrm_nat_keepalive.o
>  obj-$(CONFIG_XFRM_STATISTICS) += xfrm_proc.o
>  obj-$(CONFIG_XFRM_ALGO) += xfrm_algo.o
>  obj-$(CONFIG_XFRM_USER) += xfrm_user.o
> diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> index 703d4172c7d7..91357ccaf4af 100644
> --- a/net/xfrm/xfrm_compat.c
> +++ b/net/xfrm/xfrm_compat.c
> @@ -131,6 +131,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
>  	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
>  	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
> +	[XFRMA_NAT_KEEPALIVE_INTERVAL]	= { .type = NLA_U32 },
>  };
>  
>  static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
> @@ -280,9 +281,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
>  	case XFRMA_IF_ID:
>  	case XFRMA_MTIMER_THRESH:
>  	case XFRMA_SA_DIR:
> +	case XFRMA_NAT_KEEPALIVE_INTERVAL:
>  		return xfrm_nla_cpy(dst, src, nla_len(src));
>  	default:
> -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
> +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
>  		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
>  		return -EOPNOTSUPP;
>  	}
> @@ -437,7 +439,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
>  	int err;
>  
>  	if (type > XFRMA_MAX) {
> -		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
> +		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);
>  		NL_SET_ERR_MSG(extack, "Bad attribute");
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
> new file mode 100644
> index 000000000000..82f0a301683f
> --- /dev/null
> +++ b/net/xfrm/xfrm_nat_keepalive.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * xfrm_nat_keepalive.c
> + *
> + * (c) 2024 Eyal Birger <eyal.birger@gmail.com>
> + */
> +
> +#include <net/inet_common.h>
> +#include <net/ip6_checksum.h>
> +#include <net/xfrm.h>
> +
> +static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv4);
> +#if IS_ENABLED(CONFIG_IPV6)
> +static DEFINE_PER_CPU(struct sock *, nat_keepalive_sk_ipv6);
> +#endif
> +
> +struct nat_keepalive {
> +	struct net *net;
> +	u16 family;
> +	xfrm_address_t saddr;
> +	xfrm_address_t daddr;
> +	__be16 encap_sport;
> +	__be16 encap_dport;
> +	__u32 smark;
> +};
> +
> +static void nat_keepalive_init(struct nat_keepalive *ka, struct xfrm_state *x)
> +{
> +	ka->net = xs_net(x);
> +	ka->family = x->props.family;
> +	ka->saddr = x->props.saddr;
> +	ka->daddr = x->id.daddr;
> +	ka->encap_sport = x->encap->encap_sport;
> +	ka->encap_dport = x->encap->encap_dport;
> +	ka->smark = xfrm_smark_get(0, x);
> +}
> +
> +static int nat_keepalive_send_ipv4(struct sk_buff *skb,
> +				   struct nat_keepalive *ka)
> +{
> +	struct net *net = ka->net;
> +	struct flowi4 fl4;
> +	struct rtable *rt;
> +	struct sock *sk;
> +	__u8 tos = 0;
> +	int err;
> +
> +	flowi4_init_output(&fl4, 0 /* oif */, skb->mark, tos,
> +			   RT_SCOPE_UNIVERSE, IPPROTO_UDP, 0,
> +			   ka->daddr.a4, ka->saddr.a4, ka->encap_dport,
> +			   ka->encap_sport, sock_net_uid(net, NULL));
> +
> +	rt = ip_route_output_key(net, &fl4);
> +	if (IS_ERR(rt))
> +		return PTR_ERR(rt);
> +
> +	skb_dst_set(skb, &rt->dst);
> +
> +	sk = *this_cpu_ptr(&nat_keepalive_sk_ipv4);
> +	sock_net_set(sk, net);
> +	err = ip_build_and_send_pkt(skb, sk, fl4.saddr, fl4.daddr, NULL, tos);
> +	sock_net_set(sk, &init_net);
> +	return err;
> +}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +static int nat_keepalive_send_ipv6(struct sk_buff *skb,
> +				   struct nat_keepalive *ka,
> +				   struct udphdr *uh)
> +{
> +	struct net *net = ka->net;
> +	struct dst_entry *dst;
> +	struct flowi6 fl6;
> +	struct sock *sk;
> +	__wsum csum;
> +	int err;
> +
> +	csum = skb_checksum(skb, 0, skb->len, 0);
> +	uh->check = csum_ipv6_magic(&ka->saddr.in6, &ka->daddr.in6,
> +				    skb->len, IPPROTO_UDP, csum);
> +	if (uh->check == 0)
> +		uh->check = CSUM_MANGLED_0;
> +
> +	memset(&fl6, 0, sizeof(fl6));
> +	fl6.flowi6_mark = skb->mark;
> +	fl6.saddr = ka->saddr.in6;
> +	fl6.daddr = ka->daddr.in6;
> +	fl6.flowi6_proto = IPPROTO_UDP;
> +	fl6.fl6_sport = ka->encap_sport;
> +	fl6.fl6_dport = ka->encap_dport;
> +
> +	sk = *this_cpu_ptr(&nat_keepalive_sk_ipv6);
> +	sock_net_set(sk, net);
> +	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
> +	if (IS_ERR(dst))
> +		return PTR_ERR(dst);
> +
> +	skb_dst_set(skb, dst);
> +	err = ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
> +	sock_net_set(sk, &init_net);
> +	return err;
> +}
> +#endif
> +
> +static void nat_keepalive_send(struct nat_keepalive *ka)
> +{
> +	const int nat_ka_hdrs_len = max(sizeof(struct iphdr),
> +					sizeof(struct ipv6hdr)) +
> +				    sizeof(struct udphdr);
> +	const u8 nat_ka_payload = 0xFF;
> +	int err = -EAFNOSUPPORT;
> +	struct sk_buff *skb;
> +	struct udphdr *uh;
> +
> +	skb = alloc_skb(nat_ka_hdrs_len + sizeof(nat_ka_payload), GFP_ATOMIC);
> +	if (unlikely(!skb))
> +		return;
> +
> +	skb_reserve(skb, nat_ka_hdrs_len);
> +
> +	skb_put_u8(skb, nat_ka_payload);
> +
> +	uh = skb_push(skb, sizeof(*uh));
> +	uh->source = ka->encap_sport;
> +	uh->dest = ka->encap_dport;
> +	uh->len = htons(skb->len);
> +	uh->check = 0;
> +
> +	skb->mark = ka->smark;
> +
> +	switch (ka->family) {
> +	case AF_INET:
> +		err = nat_keepalive_send_ipv4(skb, ka);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		err = nat_keepalive_send_ipv6(skb, ka, uh);
> +		break;
> +#endif
> +	}
> +	if (err)
> +		kfree_skb(skb);
> +}
> +
> +struct nat_keepalive_work_ctx {
> +	time64_t next_run;
> +	time64_t now;
> +};
> +
> +static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
> +{
> +	struct nat_keepalive_work_ctx *ctx = ptr;
> +	bool send_keepalive = false;
> +	struct nat_keepalive ka;
> +	time64_t next_run;
> +	u32 interval;
> +	int delta;
> +
> +	interval = x->nat_keepalive_interval;
> +	if (!interval)
> +		return 0;
> +
> +	spin_lock(&x->lock);
> +
> +	delta = (int)(ctx->now - x->lastused);
> +	if (delta < interval) {
> +		x->nat_keepalive_expiration = ctx->now + interval - delta;
> +		next_run = x->nat_keepalive_expiration;
> +	} else if (x->nat_keepalive_expiration > ctx->now) {
> +		next_run = x->nat_keepalive_expiration;
> +	} else {
> +		next_run = ctx->now + interval;
> +		nat_keepalive_init(&ka, x);
> +		send_keepalive = true;
> +	}
> +
> +	spin_unlock(&x->lock);
> +
> +	if (send_keepalive)
> +		nat_keepalive_send(&ka);
> +
> +	if (!ctx->next_run || next_run < ctx->next_run)
> +		ctx->next_run = next_run;
> +	return 0;
> +}
> +
> +static void nat_keepalive_work(struct work_struct *work)
> +{
> +	struct nat_keepalive_work_ctx ctx;
> +	struct xfrm_state_walk walk;
> +	struct net *net;
> +
> +	ctx.next_run = 0;
> +	ctx.now = ktime_get_real_seconds();
> +
> +	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
> +	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
> +	xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
> +	xfrm_state_walk_done(&walk, net);
> +	if (ctx.next_run)
> +		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
> +				      (ctx.next_run - ctx.now) * HZ);
> +}
> +
> +static int nat_keepalive_sk_init(struct sock * __percpu *socks,
> +				 unsigned short family)
> +{
> +	struct sock *sk;
> +	int err, i;
> +
> +	for_each_possible_cpu(i) {
> +		err = inet_ctl_sock_create(&sk, family, SOCK_RAW, IPPROTO_UDP,
> +					   &init_net);
> +		if (err < 0)
> +			goto err;
> +
> +		*per_cpu_ptr(socks, i) = sk;
> +	}
> +
> +	return 0;
> +err:
> +	for_each_possible_cpu(i)
> +		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
> +	return err;
> +}
> +
> +static void nat_keepalive_sk_fini(struct sock * __percpu *socks)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i)
> +		inet_ctl_sock_destroy(*per_cpu_ptr(socks, i));
> +}
> +
> +void xfrm_nat_keepalive_state_updated(struct xfrm_state *x)
> +{
> +	struct net *net;
> +
> +	if (!x->nat_keepalive_interval)
> +		return;
> +
> +	net = xs_net(x);
> +	schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
> +}
> +
> +int __net_init xfrm_nat_keepalive_net_init(struct net *net)
> +{
> +	INIT_DELAYED_WORK(&net->xfrm.nat_keepalive_work, nat_keepalive_work);
> +	return 0;
> +}
> +
> +int xfrm_nat_keepalive_net_fini(struct net *net)
> +{
> +	cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
> +	return 0;
> +}
> +
> +int xfrm_nat_keepalive_init(unsigned short family)
> +{
> +	int err = -EAFNOSUPPORT;
> +
> +	switch (family) {
> +	case AF_INET:
> +		err = nat_keepalive_sk_init(&nat_keepalive_sk_ipv4, PF_INET);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		err = nat_keepalive_sk_init(&nat_keepalive_sk_ipv6, PF_INET6);
> +		break;
> +#endif
> +	}
> +
> +	if (err)
> +		pr_err("xfrm nat keepalive init: failed to init err:%d\n", err);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(xfrm_nat_keepalive_init);
> +
> +void xfrm_nat_keepalive_fini(unsigned short family)
> +{
> +	switch (family) {
> +	case AF_INET:
> +		nat_keepalive_sk_fini(&nat_keepalive_sk_ipv4);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		nat_keepalive_sk_fini(&nat_keepalive_sk_ipv6);
> +		break;
> +#endif
> +	}
> +}
> +EXPORT_SYMBOL_GPL(xfrm_nat_keepalive_fini);
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 298b3a9eb48d..580c27ac7778 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4288,8 +4288,14 @@ static int __net_init xfrm_net_init(struct net *net)
>  	if (rv < 0)
>  		goto out_sysctl;
>  
> +	rv = xfrm_nat_keepalive_net_init(net);
> +	if (rv < 0)
> +		goto out_nat_keepalive;
> +
>  	return 0;
>  
> +out_nat_keepalive:
> +	xfrm_sysctl_fini(net);
>  out_sysctl:
>  	xfrm_policy_fini(net);
>  out_policy:
> @@ -4302,6 +4308,7 @@ static int __net_init xfrm_net_init(struct net *net)
>  
>  static void __net_exit xfrm_net_exit(struct net *net)
>  {
> +	xfrm_nat_keepalive_net_fini(net);
>  	xfrm_sysctl_fini(net);
>  	xfrm_policy_fini(net);
>  	xfrm_state_fini(net);
> @@ -4363,6 +4370,7 @@ void __init xfrm_init(void)
>  #endif
>  
>  	register_xfrm_state_bpf();
> +	xfrm_nat_keepalive_init(AF_INET);
>  }
>  
>  #ifdef CONFIG_AUDITSYSCALL
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 649bb739df0d..abadc857cd45 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -715,6 +715,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
>  		if (x->id.spi)
>  			hlist_del_rcu(&x->byspi);
>  		net->xfrm.state_num--;
> +		xfrm_nat_keepalive_state_updated(x);
>  		spin_unlock(&net->xfrm.xfrm_state_lock);
>  
>  		if (x->encap_sk)
> @@ -1453,6 +1454,7 @@ static void __xfrm_state_insert(struct xfrm_state *x)
>  	net->xfrm.state_num++;
>  
>  	xfrm_hash_grow_check(net, x->bydst.next != NULL);
> +	xfrm_nat_keepalive_state_updated(x);
>  }
>  
>  /* net->xfrm.xfrm_state_lock is held */
> @@ -2871,6 +2873,21 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
>  			goto error;
>  	}
>  
> +	if (x->nat_keepalive_interval) {
> +		if (x->dir != XFRM_SA_DIR_OUT) {
> +			NL_SET_ERR_MSG(extack, "NAT keepalive is only supported for outbound SAs");
> +			err = -EINVAL;
> +			goto error;
> +		}
> +
> +		if (!x->encap || x->encap->encap_type != UDP_ENCAP_ESPINUDP) {
> +			NL_SET_ERR_MSG(extack,
> +				       "NAT keepalive is only supported for UDP encapsulation");
> +			err = -EINVAL;
> +			goto error;
> +		}
> +	}
> +
>  error:
>  	return err;
>  }
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index e83c687bd64e..a552cfa623ea 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -833,6 +833,10 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
>  	if (attrs[XFRMA_SA_DIR])
>  		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
>  
> +	if (attrs[XFRMA_NAT_KEEPALIVE_INTERVAL])
> +		x->nat_keepalive_interval =
> +			nla_get_u32(attrs[XFRMA_NAT_KEEPALIVE_INTERVAL]);
> +
>  	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
>  	if (err)
>  		goto error;
> @@ -1288,6 +1292,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
>  	}
>  	if (x->dir)
>  		ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
> +
> +	if (x->nat_keepalive_interval) {
> +		ret = nla_put_u32(skb, XFRMA_NAT_KEEPALIVE_INTERVAL,
> +				  x->nat_keepalive_interval);
> +		if (ret)
> +			goto out;
> +	}
>  out:
>  	return ret;
>  }
> @@ -3165,6 +3176,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
>  	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
>  	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
> +	[XFRMA_NAT_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },

What would happen if the value is set to 0? Should it be allowed? I don't 
see any use for it. If not, should we make the range from 1 to UINT32_MAX? 
This way, we can avoid any potential issues with the value 0, ensuring 
proper functionality.

I also wonder about limiting the maxium value to x->lft.hard_add_expires_seconds.
Adding XFRMA_NAT_KEEPALIVE_INTERVAL > x->lft.hard_add_expires_seconds does 
not make sesne to me. Just another sanity check.

>  };
>  EXPORT_SYMBOL_GPL(xfrma_policy);
>  
> @@ -3474,6 +3486,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
>  	if (x->dir)
>  		l += nla_total_size(sizeof(x->dir));
>  
> +	if (x->nat_keepalive_interval)
> +		l += nla_total_size(sizeof(x->nat_keepalive_interval));
> +
>  	return l;
>  }
>  
> -- 
> 2.34.1

One curious question: What happens if the NAT gateway in between returns an 
ICMP unreachable error as a response? If the IKE daemon was sending it,  
IKEd would notice the ICMP errors and possibly take action. This is 
something to consider. For example, this might be important to handle when 
offloading on an Android phone use case. Somehow, the IKE daemon should be 
woken up to handle these errors; otherwise, you risk unnecessary battery 
drain. Or if you are server, flodding lot of nat-keep-alive.

07:33:30.839377 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 29)
    192.1.3.33.4500 > 192.1.2.23.4500: [no cksum] isakmp-nat-keep-alive
07:33:30.840014 IP (tos 0xc0, ttl 63, id 17350, offset 0, flags [none], proto ICMP (1), length 57)
    192.1.2.23 > 192.1.3.33: ICMP 192.1.2.23 udp port 4500 unreachable, length 37
	IP (tos 0x0, ttl 63, id 0, offset 0, flags [DF], proto UDP (17), length 29)
    192.1.3.33.4500 > 192.1.2.23.4500: [no cksum] isakmp-nat-keep-alive

I ran a few quick tests and the patch works well.

thanks,
-antony

