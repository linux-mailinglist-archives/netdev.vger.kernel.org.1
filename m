Return-Path: <netdev+bounces-18545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D926875792E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6745828145D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6868FFC04;
	Tue, 18 Jul 2023 10:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27BFBEE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:19:16 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3715B130
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:19:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 6B9813200319;
	Tue, 18 Jul 2023 06:19:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Jul 2023 06:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689675551; x=1689761951; bh=9tgTVmsEUDiQT
	ETcmS7Yz/FD1vCX5CpZklnaS32RnCU=; b=hjf0ughTtXYPO0z0kX+cC4SqDiEO1
	T8brhGisHfyoST84zxNfmUuY8hdpmKzOPkuYZrvPzuhRbFFBf8zuFvX2K2l2hgJi
	tUgaI1HUL/+FuPblyMGK3C9oNK2IdPLHewnkX844kZ0A4H8FY4gkN3dF33jYbeDB
	jTXlBgVWjU6UbmykzfgcgWbgvvCz5y9Tpfge79d5S1/9m5Xp0CHvvmPwAmew125g
	0lFcLSRoKNY99Equbd240OLk4BmMqzgADisixVvxqNB9a1s+MJ/4tg9MeDlXxmCW
	1HQtYTemO4UB7DUjU/YsO/8JK41lt/CNd1VLC61Tavamssh9boT9aG+3Q==
X-ME-Sender: <xms:H2e2ZArFINSFwDwDKwGTf1H9iF-tDyPyAItxVIBxwK8nqEXX97Ziyg>
    <xme:H2e2ZGr9KFzix_pV14haDvC6YL1la-nGA48MYR1W3PloYso3iy6GrhUvqvMgDa81F
    r96ZWL9g05XE-Y>
X-ME-Received: <xmr:H2e2ZFN6OZIqJ0OS27ilJqWmtu3IIcC1jXLAlO1dEZ6sZLPJJicGReG5Cg8SzkFQ6wxRSdtrkk27g8FgkiDw1HUQ0fM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:H2e2ZH4Tx-lCyvue6brGZqQc7cOkeNnv4kPmzW9m_UEfMTqcXxLaZQ>
    <xmx:H2e2ZP5Est119j2qeBeKiwRu3h4zS5vel0OS04LNMslEyXRvkp-jSA>
    <xmx:H2e2ZHgw8u0c3k94G1I9ojDjYrtcJPofcoRvbW_fdtJtEIAmqDOaLQ>
    <xmx:H2e2ZFSMGEwK-PheaT72mQUbachQ1wMf01OJmUpmEL_JgWD5ojpNRw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 06:19:10 -0400 (EDT)
Date: Tue, 18 Jul 2023 13:19:06 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZLZnGkMxI+T8gFQK@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718080044.2738833-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 04:00:44PM +0800, Hangbin Liu wrote:
> After deleting an interface address in fib_del_ifaddr(), the function
> scans the fib_info list for stray entries and calls fib_flush.
> Then the stray entries will be deleted silently and no RTM_DELROUTE
> notification will be sent.

[...]

> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 74d403dbd2b4..1a88013f6a5b 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>  {
>  	struct trie *t = (struct trie *)tb->tb_data;
> +	struct nl_info info = { .nl_net = net };
>  	struct key_vector *pn = t->kv;
>  	unsigned long cindex = 1;
>  	struct hlist_node *tmp;
> @@ -2088,6 +2089,8 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>  
>  			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
>  						NULL);
> +			rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> +				  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);

fib_table_flush() isn't only called when an address is deleted, but also
when an interface is deleted or put down. The lack of notification in
these cases is deliberate. Commit 7c6bb7d2faaf ("net/ipv6: Add knob to
skip DELROUTE message on device down") introduced a sysctl to make IPv6
behave like IPv4 in this regard, but this patch breaks it.

IMO, the number of routes being flushed because a preferred source
address is deleted is significantly lower compared to interface down /
deletion, so generating notifications in this case is probably OK. It
also seems to be consistent with IPv6 given that rt6_remove_prefsrc()
calls fib6_clean_all() and not fib6_clean_all_skip_notify().

>  			hlist_del_rcu(&fa->fa_list);
>  			fib_release_info(fa->fa_info);
>  			alias_free_mem_rcu(fa);
> -- 
> 2.38.1
> 
> 

