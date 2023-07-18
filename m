Return-Path: <netdev+bounces-18565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70D757ABB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C3B281304
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A3C2F6;
	Tue, 18 Jul 2023 11:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A251FD8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:42:37 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F51BC9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:42:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 75A3E3200495;
	Tue, 18 Jul 2023 07:42:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 Jul 2023 07:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689680526; x=1689766926; bh=8XnIue2KWYD9y
	GtYbgfEyXJnQLvIA+2wERN/MRRoOnA=; b=Bb3bZFdALZnm+VjGvuygcNk0o2q/I
	s4vuDqBGnHEFRhoRAHhFQ8PHAJy5XLx65Gg2zNfLiFk3OmpTy37wnVCptnzSmz4o
	DApOr/1pSlntxYhR3zD3IRf3MV2NCY2U8rrrhCVZYEnTk4IBWZFyZytl3EwukS1b
	R/Bbp3PBJ8QhD1lKu5lrjvYU+WQjTxew7cPcGhBmRHHaaoT/TKeBgfyOU76AWxUb
	k5U6wu+2xcpDTT0+C6BtMcfal2eSEcp78C0omVfdMh5cQ2HKPp7FCkgwd57pwpfZ
	tV82BGns8JHouY9H+EnzAFcMMouohqgyccsf3SoqxzalyGldFvvZwm3ig==
X-ME-Sender: <xms:jnq2ZFr9VlAmSdCb7J1GZc8ELOG1AYnG0rJpWBuARkV0aMrZGjh5rQ>
    <xme:jnq2ZHrXlj8GJh_Sa6pqCcMXJKozSp3ni2a2ojpIY7xR8DMoPhGfDpyR811isD2vn
    a9zGx1k_AWCC1w>
X-ME-Received: <xmr:jnq2ZCOzqQC2M6mVS8484G5WYR2rVVwKyRYZjEoxEaB_jEkO2sObXVISGlJs7S4uFs-sUjudNiwDbO3dYsEvKuwhMFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeejgedtvdelgfehueffieelgfefhfetledvgffguddvleehgfdtudekledvveff
    leenucffohhmrghinhepshhhrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:jnq2ZA4kWoJATHmKZupfXTxTM1RpjSQ40FzDf1Bx6epuI6a0WxfebA>
    <xmx:jnq2ZE6y8Rk5x1yuEkCqUe6i9-6Fn3cvkdonRYfzEs6pNRNB-SG87A>
    <xmx:jnq2ZIib6bbWXoAMx7q1ufaKBI1MHYY8Pvj2hbtG7szoMD9gO6HjMw>
    <xmx:jnq2ZOS3Mx0EcB1qCC07H3qKeWMwMtFzIwoW5tUh3ZUMYMs2z1xdxQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 07:42:05 -0400 (EDT)
Date: Tue, 18 Jul 2023 14:42:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net] ipv6: do not match device when remove source route
Message-ID: <ZLZ6ipKWo1dSW8Xc@shredder>
References: <20230718065253.2730396-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718065253.2730396-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 02:52:53PM +0800, Hangbin Liu wrote:
> After deleting an IPv6 address on an interface and cleaning up the
> related preferred source entries, it is important to ensure that all
> routes associated with the deleted address are properly cleared. The
> current implementation of rt6_remove_prefsrc() only checks the preferred
> source addresses bound to the current device. However, there may be
> routes that are bound to other devices but still utilize the same
> preferred source address.
> 
> To address this issue, it is necessary to also delete entries that are
> bound to other interfaces but share the same source address with the
> current device. Failure to delete these entries would leave routes that
> are bound to the deleted address unclear. Here is an example reproducer
> (I have omitted unrelated routes):

[...]

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 64e873f5895f..ab8c364e323c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -4607,7 +4607,6 @@ void rt6_remove_prefsrc(struct inet6_ifaddr *ifp)
>  {
>  	struct net *net = dev_net(ifp->idev->dev);
>  	struct arg_dev_net_ip adni = {
> -		.dev = ifp->idev->dev,

Wouldn't this affect routes in different VRFs?

See commit 5a56a0b3a45d ("net: Don't delete routes in different VRFs")
and related fixes:

8a2618e14f81 ipv4: Fix incorrect table ID in IOCTL path
c0d999348e01 ipv4: Fix incorrect route flushing when table ID 0 is used
f96a3d74554d ipv4: Fix incorrect route flushing when source address is deleted
e0a312629fef ipv4: Fix table id reference in fib_sync_down_addr

Anyway, please add tests to tools/testing/selftests/net/fib_tests.sh

>  		.net = net,
>  		.addr = &ifp->addr,
>  	};
> -- 
> 2.38.1
> 
> 

