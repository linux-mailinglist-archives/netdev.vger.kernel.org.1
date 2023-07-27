Return-Path: <netdev+bounces-21944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46176562E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9D41C21688
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7C168BC;
	Thu, 27 Jul 2023 14:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C30FBEF
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 14:45:11 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0230D2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:45:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 03FCC5C0167;
	Thu, 27 Jul 2023 10:45:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jul 2023 10:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690469107; x=1690555507; bh=k+eZTz0o8P+6i
	UZcKSKnIpwL6uic784O/D5m1QU8uoo=; b=bBgZ5Z3l0IuMpMJKZo4rvn6y9zZm3
	AylH92/c+0nHWdsKq+o5P4yonU9Iz2K35/gDVtsFTvEsFFuLnYkUQvPk+sQcK3lw
	OtBsH+lqXzspyUpU7H16SUv0l5MpEMWpc35hB7aQ+8IOxniMkCNx/wsz7K5U7bth
	k5kvbW9vyCaupBaKZ+94qa8faTH7Wfrst5XC8FTdQAcLpYvtt4YmKspgjwn6FBMr
	2Da8zkUj0CvSixtUgqC8NwsSwiya3E/ZC3X90bLCnVelwzHMJqUtIlW6a/RpyUZV
	+Jz/7R711J2njw/UxGwN68VzNlk7dIq5h5g9mBdUpX7hSLLldbZb9kK8A==
X-ME-Sender: <xms:8oLCZHVnDtaDV4rfnLhGU6QWq46yiGmQ_lyDxxXaZ5APG2n8-2Axpw>
    <xme:8oLCZPlG5zLz9m1DZNsjHQRpE7whKNI5nAOMWXKGak0gBlkCpFnVJg_AJWDY7bmYn
    M8rIBDVansYjWA>
X-ME-Received: <xmr:8oLCZDZGKcnVLvgevENP4-LOkJVgHR5MZNsqr9CczHD1MsRRxtfnACIQCZvkifEoG1hT4OGYjuGDHeRywSv6BrX6S5BCDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:8oLCZCXVUo6kpcJh7wXA96Ynsgro7ruVUTl4elgG9KaJzF8FG6vQwA>
    <xmx:8oLCZBnDI9WwOhXjE93_K7mnxnVfalGws__FLdJFZUa4M03a4jeeiA>
    <xmx:8oLCZPcjdevrEid-RxS8UfFaUSCc3zR9U4FgqWrVb1t0mZC8KUL0IQ>
    <xmx:84LCZPaT6OLFwoBl2gpXeQqxMbDD1hcXJHqTZsdl8zxi6f5cc-xUdg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 10:45:05 -0400 (EDT)
Date: Thu, 27 Jul 2023 17:45:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route (was Re:
 [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush fib)
Message-ID: <ZMKC7jTVF38JAeNb@shredder>
References: <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMDyoRzngXVESEd1@Laptop-X1>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 06:17:05PM +0800, Hangbin Liu wrote:
> Hi Stephen, Ido, David,
> On Mon, Jul 24, 2023 at 08:48:20AM -0700, Stephen Hemminger wrote:
> > On Mon, 24 Jul 2023 16:56:37 +0800
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> > 
> > > The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
> > > the cache becomes inconsistent. The IPv4 will not send src route delete info
> > > if it's bond to other device. While IPv6 only modify the src route instead of
> > > delete it, and also no notify. So NetworkManager developers complained and
> > > hope to have a consistent and clear notification about route modify/delete.
> > 
> > Read FRR they get it right. The routing daemons have to track kernel,
> > and the semantics have been worked out for years.
> 
> Since we are talking about whether we should fix the issues or doc them. I
> have some other route issues reported by NetworkManager developers. And want
> discuss with you.
> 
> For IPv4, we add new route instead append the nexthop to same dest(or do I
> miss something?).

The append / prepend trick to create a multipath route is an IPv6 hack.
The correct way to install a multipath route is to add it in one go like
in the IPv4 implementation (which predates the IPv6 implementation) or
use the nexthop API.

> Since the route are not merged, the nexthop weight is not shown, which
> make them look like the same for users. For IPv4, the scope is also
> not shown, which look like the same for users.

The routes are the same, but separate. They do not form a multipath
route. Weight is meaningless for a non-multipath route.

> 
> While IPv6 will append another nexthop to the route if dest is same.

Yes, that's a hack.

> But there are 2 issues here:
> 1. the *type* and *protocol* field are actally ignored
> 2. when do `ip monitor route`, the info dumpped in fib6_add_rt2node()
>    use the config info from user space. When means `ip monitor` show the
>    incorrect type and protocol
> 
> So my questions are, should we show weight/scope for IPv4? How to deal the
> type/proto info missing for IPv6? How to deal with the difference of merging
> policy for IPv4/IPv6?

In my opinion, if you want consistent behavior between IPv4 and IPv6 for
multipath routes, then I suggest using the nexthop API. It was merged in
5.3 (IIRC) and FRR started using it by default a few years ago. Other
than a few bugs that were fixed, I don't remember many complaints. Also,
any nexthop-related features will only be implemented in the nexthop
API, not in the legacy API. Resilient nexthop groups is one example.

