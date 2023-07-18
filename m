Return-Path: <netdev+bounces-18547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CEE757949
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396AF281511
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D930A945;
	Tue, 18 Jul 2023 10:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181FFC15
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:32:25 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63248E4C
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:32:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4454A32002F9;
	Tue, 18 Jul 2023 06:32:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 Jul 2023 06:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689676342; x=1689762742; bh=AT4+qPytjC5U8
	SKl/B31tXQN3r3W0JfcCHcfgVdzut4=; b=LnWRjWvx7ScgKU8Db/OXeh+wZksIZ
	D7nSQe7nnGGxMOY2N+zN1D9U8T0lVPoxZh5ZbXoadhqbOJyX+dIa9ZpO3hATnivx
	JdJkpMFUXEcmmJas70Uww1khsH84JjtdxWbBfq3TFngHxnWfmaVWUwgloKTcQK3t
	PUFkhGm5ndnykZVyFKWB6a2akUi/VeMzJJTz7qZ1brkiGbfEqB15WmtzC+fFxO7W
	9eR6Ck5pkwETjbF1Fis4s6Om472PuzFFD48BeFqRYQRf1hlttKgHovZsC626rr+S
	0bRteD1zsx/HJg/9CPeYu6c90/Eu9b0e/BqmSP+VAlUIRDsKg/z+bT+aw==
X-ME-Sender: <xms:Nmq2ZPMnelqu_kYWIFt4m989VGZI2ntErprKbsr6XbpF71AdeAdWQg>
    <xme:Nmq2ZJ9w4RvwiXcQKfIek-_aHHakAZDFqmYBGk0Gi0wHHgOlDTzgTHuw3qh_ngyLP
    iUY1eSQgWOBFmw>
X-ME-Received: <xmr:Nmq2ZOQlIBal4Lw8CUDGhojbS64F8kdFzUfk-cCA3EznS1EKE_UK5sH53fOvIFHxWGSTbc9WQU0lmmkOWfpr-DTwVD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:Nmq2ZDtmzjgdl06JfeyJatKUtGcqZRzzeCoM1hcjPg6DEkH1liVACA>
    <xmx:Nmq2ZHdNYkRfsnRm2awUcNaELmvGJRa14f-V6LNZZ1_bX05WJfcODA>
    <xmx:Nmq2ZP2BDozR_187Z3RlM9bchGZvX9kW48eEF4iRaLshkMZoDdz7Cg>
    <xmx:Nmq2ZIHyENETpsIVGiH3Vgo33iV7N54kEf7kA9rLbYYJr1470JKP-Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 06:32:21 -0400 (EDT)
Date: Tue, 18 Jul 2023 13:32:19 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZLZqMw/wOjwtQg+K@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLZnGkMxI+T8gFQK@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 01:19:13PM +0300, Ido Schimmel wrote:
> On Tue, Jul 18, 2023 at 04:00:44PM +0800, Hangbin Liu wrote:
> > After deleting an interface address in fib_del_ifaddr(), the function
> > scans the fib_info list for stray entries and calls fib_flush.
> > Then the stray entries will be deleted silently and no RTM_DELROUTE
> > notification will be sent.
> 
> [...]
> 
> > diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> > index 74d403dbd2b4..1a88013f6a5b 100644
> > --- a/net/ipv4/fib_trie.c
> > +++ b/net/ipv4/fib_trie.c
> > @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
> >  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> >  {
> >  	struct trie *t = (struct trie *)tb->tb_data;
> > +	struct nl_info info = { .nl_net = net };
> >  	struct key_vector *pn = t->kv;
> >  	unsigned long cindex = 1;
> >  	struct hlist_node *tmp;
> > @@ -2088,6 +2089,8 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> >  
> >  			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
> >  						NULL);
> > +			rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> > +				  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> 
> fib_table_flush() isn't only called when an address is deleted, but also
> when an interface is deleted or put down. The lack of notification in
> these cases is deliberate. Commit 7c6bb7d2faaf ("net/ipv6: Add knob to
> skip DELROUTE message on device down") introduced a sysctl to make IPv6
> behave like IPv4 in this regard, but this patch breaks it.
> 
> IMO, the number of routes being flushed because a preferred source
> address is deleted is significantly lower compared to interface down /
> deletion, so generating notifications in this case is probably OK. It
> also seems to be consistent with IPv6 given that rt6_remove_prefsrc()
> calls fib6_clean_all() and not fib6_clean_all_skip_notify().

Actually, looking closer at IPv6, it seems that routes are not deleted,
but instead the preferred source address is simply removed from them
(w/o a notification).

Anyway, my point is that a RTM_DELROUTE notification should not be
emitted for routes that are deleted because of interface down /
deletion.

> 
> >  			hlist_del_rcu(&fa->fa_list);
> >  			fib_release_info(fa->fa_info);
> >  			alias_free_mem_rcu(fa);
> > -- 
> > 2.38.1
> > 
> > 

