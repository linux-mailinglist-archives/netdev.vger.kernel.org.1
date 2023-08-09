Return-Path: <netdev+bounces-25712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D4A775395
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A1B281AC2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D346112;
	Wed,  9 Aug 2023 07:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7E6110
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:06:24 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276A210A
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:06:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id D9EEB5C00F3;
	Wed,  9 Aug 2023 03:06:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 09 Aug 2023 03:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691564772; x=1691651172; bh=lEIVIdiadlMOQ
	znaYEIr+e2Jc/zCgbo4ipBOCBnglh4=; b=MzJB1xrr9O3tKuwzwry8M9bZpzRl9
	Lwl+2Pp0XnKqEMhuJPLXDVryq7wjXUq8DMHSLSdcstcq4winqROMySq07Uqn/wSB
	7c8ZhaMhk0Eto/U5iA2Y35zEfOe1TPMfp8/8pQJmjIrMrQ2KkoQbNILvz5vwR9bU
	LOHIOfZbrZZ+rtFvTWX/zWXmQrnWc+EzpR5RM2gp4qlXxTnwAT0HQQA9MDvkAJgd
	zgAv8R9i3AfJ5eBuK2PAcqEnZ8wd0Qhz7xcevEN8yIjsczzGqjYsEDXe5WqQz+ta
	9iT2Sdr04EXbzUL6Df2QVDp7eDf3k2KeDnH9Qi7T77oVvOc4GzB9IXPgQ==
X-ME-Sender: <xms:5DrTZKJZZfiUnNPITanO8nNgMEtx0z9nWj6KLu9Y5FcBr3bV1iaLUA>
    <xme:5DrTZCLS_DahnrliIDTcuhTPNwROJIne28Zk8y_vdHZDAsHMSfM--d4u6mY2OwYeN
    eI4iJ_YDFZtBp4>
X-ME-Received: <xmr:5DrTZKtcKLmPX6Pc7GaS33lqlHiUf0o-D3mUk6iPGDEjuwRYR_Q-0WS_j7qS3gQd1BFIZ7mwog0WR5WB469eSYKaNk98hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:5DrTZPaC-BWusZHF9lis75n-E1-KnvW2Ngk3YudNocyuDSP-f9SsKQ>
    <xmx:5DrTZBaLhOtpZrc18ic1OM0cKphUY7cscmvAH1myDOL0gd2rhenMhg>
    <xmx:5DrTZLCYkyn4srpmVSO-h_wUFbgFsfaQJsq8i3LUadKcSmwiUC80ug>
    <xmx:5DrTZGNrROWoRKBA5yBmN1Jl93cP8e18wfA9brQh7eguMPfyTlaTVw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 03:06:11 -0400 (EDT)
Date: Wed, 9 Aug 2023 10:06:07 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZNM638Ypq7cgUB/k@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZMyyJKZDaR8zED8j@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMyyJKZDaR8zED8j@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 04:09:08PM +0800, Hangbin Liu wrote:
> I reconsidered this issue this week. As we can't get the device status in
> fib_table_flush(). How about adding another flag to track the deleted src
> entries. e.g. RTNH_F_UNRESOLVED. Which is only used in ipmr currently.
> When the src route address is deleted, the route entry also could be
> considered as unresolved. With this idea, the patch could be like:
> 
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 51c13cf9c5ae..5c41d34ab447 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -420,7 +420,7 @@ struct rtnexthop {
>  #define RTNH_F_ONLINK          4       /* Gateway is forced on link    */
>  #define RTNH_F_OFFLOAD         8       /* Nexthop is offloaded */
>  #define RTNH_F_LINKDOWN                16      /* carrier-down on nexthop */
> -#define RTNH_F_UNRESOLVED      32      /* The entry is unresolved (ipmr) */
> +#define RTNH_F_UNRESOLVED      32      /* The entry is unresolved (ipmr/dead src) */
>  #define RTNH_F_TRAP            64      /* Nexthop is trapping packets */
> 
>  #define RTNH_COMPARE_MASK      (RTNH_F_DEAD | RTNH_F_LINKDOWN | \

I'm not sure we need to reinterpret the meaning of this uAPI flag. The
FIB info structure currently looks like this:

struct fib_info {
        struct hlist_node          fib_hash;             /*     0    16 */
        struct hlist_node          fib_lhash;            /*    16    16 */
        struct list_head           nh_list;              /*    32    16 */
        struct net *               fib_net;              /*    48     8 */
        refcount_t                 fib_treeref;          /*    56     4 */
        refcount_t                 fib_clntref;          /*    60     4 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        unsigned int               fib_flags;            /*    64     4 */
        unsigned char              fib_dead;             /*    68     1 */
        unsigned char              fib_protocol;         /*    69     1 */
        unsigned char              fib_scope;            /*    70     1 */
        unsigned char              fib_type;             /*    71     1 */
        __be32                     fib_prefsrc;          /*    72     4 */
        u32                        fib_tb_id;            /*    76     4 */
        u32                        fib_priority;         /*    80     4 */

        /* XXX 4 bytes hole, try to pack */

        struct dst_metrics *       fib_metrics;          /*    88     8 */
        int                        fib_nhs;              /*    96     4 */
        bool                       fib_nh_is_v6;         /*   100     1 */
        bool                       nh_updated;           /*   101     1 */

        /* XXX 2 bytes hole, try to pack */

        struct nexthop *           nh;                   /*   104     8 */
        struct callback_head       rcu __attribute__((__aligned__(8))); /*   112    16 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct fib_nh              fib_nh[];             /*   128     0 */

        /* size: 128, cachelines: 2, members: 21 */
        /* sum members: 122, holes: 2, sum holes: 6 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

We can instead represent fib_nh_is_v6 and nh_updated using a single bit:

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a378eff827c7..a91f8a28689a 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -152,8 +152,8 @@ struct fib_info {
 #define fib_rtt fib_metrics->metrics[RTAX_RTT-1]
 #define fib_advmss fib_metrics->metrics[RTAX_ADVMSS-1]
        int                     fib_nhs;
-       bool                    fib_nh_is_v6;
-       bool                    nh_updated;
+       u8                      fib_nh_is_v6:1,
+                               nh_updated:1;
        struct nexthop          *nh;
        struct rcu_head         rcu;
        struct fib_nh           fib_nh[];

And then add another bit there to mark a FIB info that is deleted
because of preferred source address deletion.

I suggest testing with the FIB tests in tools/testing/selftests/net/.

> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 65ba18a91865..a7ef21a6d271 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -1883,7 +1883,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
>                     fi->fib_tb_id != tb_id)
>                         continue;
>                 if (fi->fib_prefsrc == local) {
> -                       fi->fib_flags |= RTNH_F_DEAD;
> +                       fi->fib_flags |= (RTNH_F_DEAD | RTNH_F_UNRESOLVED);
>                         ret++;
>                 }
>         }
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 74d403dbd2b4..88c593967063 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>  {
>         struct trie *t = (struct trie *)tb->tb_data;
> +       struct nl_info info = { .nl_net = net };
>         struct key_vector *pn = t->kv;
>         unsigned long cindex = 1;
>         struct hlist_node *tmp;
> @@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> 
>                         fib_notify_alias_delete(net, n->key, &n->leaf, fa,
>                                                 NULL);
> +                       if (fi->fib_flags & RTNH_F_UNRESOLVED) {
> +                               fi->fib_flags &= ~RTNH_F_UNRESOLVED;
> +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> +                       }
>                         hlist_del_rcu(&fa->fa_list);
>                         fib_release_info(fa->fa_info);
>                         alias_free_mem_rcu(fa);
> 
> Thanks
> Hangbin

