Return-Path: <netdev+bounces-20166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05E75E04E
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 09:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4D21C209CA
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80022ED0;
	Sun, 23 Jul 2023 07:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CEEBD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 07:38:19 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E511BD8
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 00:38:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 2C3B73200488;
	Sun, 23 Jul 2023 03:38:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 23 Jul 2023 03:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690097895; x=1690184295; bh=xW0pmkNY0zExI
	JV6PID0EkDW2L21Z+0Rf9bCLmOJwsQ=; b=Cdyy6iydfUGwq8nXSFOmccw1Da1Rw
	jn2UYZsHcv5Za2aEUgWZ0xNj0gjcOlonsRfIsZigkXAFQK6QOnv4zeWUryPrXbPU
	OocSMinVnOrElilyPzoeNthbtAtqIdM6vN+rt9ssgE7QOK93EdSyxr9VcvgY1L9X
	+8F4MGn74gXtEDX19doYMSYcKirNB/Tbc9OZJGaFDD+jH+tFnYpDrn9dXemIqOl7
	6GjuK93L0bBVrOOO3NHCPb66bP0RUGdQt/1CPQBV7ooxvPM7FkOMGZo6eBFmdwFl
	FivmMI2GB8tiGOeuvLN1F112R70Hc6EONOIXaCslLsjBqUi13EIgo6U/w==
X-ME-Sender: <xms:59i8ZKtNy_r9D4w53DdoKkhg9FyVrBm5oO9Xa2oXuVkFONzmNW6XLw>
    <xme:59i8ZPfP8ZtoCCTrbbrdARCr8a467F1UqGrcsufYkmYt-9AcS8K3fjC7U5FfJqKOv
    FwxNSeWuuF1uvw>
X-ME-Received: <xmr:59i8ZFzO4YdTY_qXziEVs4bPI1od2c-4NVgHl_vJYntIUnDv9TNvTbQlPDWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheehgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:59i8ZFPxPgSQAfRX5gnKdp4bkJnP7N7fvnyxVfQprFRUu743XgD4mg>
    <xmx:59i8ZK8WZQrbU1v93U-b5pgZDY0Evc-Buq794r4mGc1VMdYeE060XA>
    <xmx:59i8ZNV-pmuyeS-JdNVMDgdyB996xKv-dXdVRzLsflvj2qzLovdZXA>
    <xmx:59i8ZKxzI0FY8NJN05WivER7v3gVdVvsqQZdeu2RqjMzqXM8dJxbBA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jul 2023 03:38:14 -0400 (EDT)
Date: Sun, 23 Jul 2023 10:38:11 +0300
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
Message-ID: <ZLzY42I/GjWCJ5Do@shredder>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
 <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLobpQ7jELvCeuoD@Laptop-X1>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 01:46:13PM +0800, Hangbin Liu wrote:
> On Thu, Jul 20, 2023 at 10:01:06PM -0600, David Ahern wrote:
> > >>> How about ignore route deletion for link down? e.g.
> > >>>
> > >>> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> > >>> index 74d403dbd2b4..11c0f325e887 100644
> > >>> --- a/net/ipv4/fib_trie.c
> > >>> +++ b/net/ipv4/fib_trie.c
> > >>> @@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
> > >>>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> > >>>  {
> > >>>         struct trie *t = (struct trie *)tb->tb_data;
> > >>> +       struct nl_info info = { .nl_net = net };
> > >>>         struct key_vector *pn = t->kv;
> > >>>         unsigned long cindex = 1;
> > >>>         struct hlist_node *tmp;
> > >>> @@ -2088,6 +2089,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
> > >>>
> > >>>                         fib_notify_alias_delete(net, n->key, &n->leaf, fa,
> > >>>                                                 NULL);
> > >>> +                       if (!(fi->fib_flags & RTNH_F_LINKDOWN)) {
> > >>> +                               rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
> > >>> +                                         KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
> > >>> +                       }
> > >>
> > >> Will you get a notification in this case for 198.51.100.0/24?
> > > 
> > > No. Do you think it is expected with this patch or not?
> > 
> > The intent is that notifications are sent for link events but not route
> > events which are easily deduced from the link events.
> 
> Sorry, I didn't get what you mean. The link events should be notified to user
> via rtmsg_ifinfo_event()? So I think here we ignore the route events caused by
> link down looks reasonable.

The route in the scenario I mentioned wasn't deleted because of a link
event, but because the source address was deleted yet no notification
was emitted. IMO, this is wrong given the description of the patch.

I assume NetworkManager already knows how to delete routes given
RTM_DELLINK events. Can't it be taught to react to RTM_DELADDR events as
well? Then this functionality will always work, regardless of the kernel
version being used.

