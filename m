Return-Path: <netdev+bounces-19521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C993D75B139
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060251C2136A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B42171D8;
	Thu, 20 Jul 2023 14:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5A18AE4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:30:07 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A226AC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:30:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 08FEC5C0164;
	Thu, 20 Jul 2023 10:30:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 Jul 2023 10:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689863404; x=1689949804; bh=G28ztcwxXvYY8
	15WD0xa53mgcjBJ7lHeHtHv/vF+qDk=; b=aoy5Bx49PmhaXbe5mKI7cxVzcgKxe
	0gANdHjopAaaRiwgqHCGj+ex85SeQuBbaXhI5MlWwggJJdebW0W1vmsr9/e8xDX0
	U8Bu8FAs1LVcdzi7FGaMOJIzJmQoBrJHvYn+Y/7WIBMBJ/snCp7B/6JCJUKDDE5f
	iTImOkUhMJ/Wv835ppMNHbA2GhWFogV6poshz/akScMlp2Po3UN7WP5x8u/FuXyg
	XFjQ0AxU1LalQhRR/y6q6qrxmnc3WRnZwt4RsvGvha/gdu9eNsXTBi/qOV5UECOr
	FRRXj+LWgXc2Al9axlCxVt3x+xKxDYZDllfrpbc7M5/IUxgRZp62Zm2Tw==
X-ME-Sender: <xms:60S5ZLSV9dfXZQla_sfS0guxtHVFHu504c2oFdXkFipNR-GXDqz9MA>
    <xme:60S5ZMyR9vm5eGsoyHmvjLC34f1GlRUo4b4F-yctbuR-3cf5k4sDaAj_KnfeFr0Mj
    SP9IXryytlSo38>
X-ME-Received: <xmr:60S5ZA20aTyZNPaYdggmVTOFOh5j38RVSHWml_Y5dLd9GU3XaxSuyVC9HT9H2J6eX6jfG6WBm3-PZaW5CvbCr7zNeQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:60S5ZLDDpDehMRJuXYUA1RZDcWswxSfNvsV9EI5SoNSzu8WIpjMM4w>
    <xmx:60S5ZEg2e_vCwrBypTK0Xq3fF1KuSy411SLcknllxw_uEyEXNT9Nxw>
    <xmx:60S5ZPpogcHB6KtqqFKK9Hh1kxTPoGOcakO9HziycSW7SVNVRf3aEA>
    <xmx:7ES5ZPXPg8Ea_lWfoF4bNyWN3-CgLpbb3c8iWhzDTax9VQs8bS8eqw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 10:30:02 -0400 (EDT)
Date: Thu, 20 Jul 2023 17:29:58 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZLlE5of1Sw1pMPlM@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLjncWOL+FvtaHcP@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:51:13PM +0800, Hangbin Liu wrote:
> On Tue, Jul 18, 2023 at 08:58:14AM -0700, Stephen Hemminger wrote:
> > On Tue, 18 Jul 2023 13:19:06 +0300
> > Ido Schimmel <idosch@idosch.org> wrote:
> > 
> > > fib_table_flush() isn't only called when an address is deleted, but also
> > > when an interface is deleted or put down. The lack of notification in
> > > these cases is deliberate. Commit 7c6bb7d2faaf ("net/ipv6: Add knob to
> > > skip DELROUTE message on device down") introduced a sysctl to make IPv6
> > > behave like IPv4 in this regard, but this patch breaks it.
> > > 
> > > IMO, the number of routes being flushed because a preferred source
> > > address is deleted is significantly lower compared to interface down /
> > > deletion, so generating notifications in this case is probably OK. It
> 
> How about ignore route deletion for link down? e.g.
> 
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 74d403dbd2b4..11c0f325e887 100644
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
> +                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
> +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> +                       }

Will you get a notification in this case for 198.51.100.0/24?

# ip link add name dummy1 up type dummy
# ip link add name dummy2 up type dummy
# ip address add 192.0.2.1/24 dev dummy1
# ip route add 198.51.100.0/24 dev dummy2 src 192.0.2.1
# ip link set dev dummy2 carrier off
# ip -4 r s
192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
198.51.100.0/24 dev dummy2 scope link src 192.0.2.1 linkdown 
# ip address del 192.0.2.1/24 dev dummy1
# ip -4 r s

>                         hlist_del_rcu(&fa->fa_list);
>                         fib_release_info(fa->fa_info);
>                         alias_free_mem_rcu(fa);
> 
> > > also seems to be consistent with IPv6 given that rt6_remove_prefsrc()
> > > calls fib6_clean_all() and not fib6_clean_all_skip_notify().
> > 
> > Agree. Imagine the case of 3 million routes and device goes down.
> > There is a reason IPv4 behaves the way it does.

