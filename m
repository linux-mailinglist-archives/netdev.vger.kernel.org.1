Return-Path: <netdev+bounces-20729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278EA760C9E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8EC1C20DF2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD582134CE;
	Tue, 25 Jul 2023 08:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA4125A5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:06:15 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE331E5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:06:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 42CAB3200910;
	Tue, 25 Jul 2023 04:06:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 25 Jul 2023 04:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690272366; x=1690358766; bh=d8UgxDMApZMQg
	ejxMufhY4/d4FqjWsPgqnNtYvmfTOU=; b=0b+XFz1Tu3SA+XHcphH4PvVAYe1HT
	Ty327CRSuOSMKT1xsHiLKf1Ktlm5BrUKEHwhqrsukQfuzR5z60l9HYlLlVc1ctbT
	VKvhxIgoHXsgfBDkwz+wZoy3IiJ7kyI00S2G/ChqXATmcPfbA8b2kwbunhQ645wL
	y3KbPbfrxbEX284jCFXd+7ucqAwe8SLqi242sZVq8RjapJ7eVbOpzcgFn2UZlCvi
	rq1NNZA+QosdsiZA4bIeWKCv/LRayeGk7LjXWhcHHt7YG4LHC/2h22F5XONGMwTN
	2fSCE4wQoJ1XkhSd3GOadKi7RQB5ul1P1ygOzvhZwoB+k5xDZadvra78Q==
X-ME-Sender: <xms:boK_ZFacLw806Z6yQH286HmrESHBTvYWEH9brEjdpDDyUpeddb_lpQ>
    <xme:boK_ZMbw-DhuhAOjmb3x7ARqAhySknEYBOk2hDkWYTZRn2VrjFoYrQIM_7cepwxUM
    IK8Wpw7aYFvbyU>
X-ME-Received: <xmr:boK_ZH_AOIyMkdMUlBY4a2nMN3BawCAFB8jAGyy35_wgvzfSU_I0Z7EQocKAKXUmUU14j94LuYrr88QZ8LaapuWAbsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:boK_ZDp8E40-lC5cBdfNEvzYPLyW-y3ErW1BrTJFYKc8G_5Sjo_hzw>
    <xmx:boK_ZArFo6CK5M5qXI7MmmhI39vtDIOgINCAifQx6xSVG4E1KmDj4w>
    <xmx:boK_ZJR94FoCs6a2STzQKfKRux_HmZW-zCNEnSESHZ6UbKogxYqRyA>
    <xmx:boK_ZFBY8auE83rz1D1Lch7q-zdJV6Y3Yyo5kHFoWMmdv37pvkHF4A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 04:06:05 -0400 (EDT)
Date: Tue, 25 Jul 2023 11:06:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZL+CarW9SMFYsx/d@shredder>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
 <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1>
 <ZLzhMDIayD2z4szG@shredder>
 <ZL5HijWsqLgVMHav@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL5HijWsqLgVMHav@Laptop-X1>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 05:42:34PM +0800, Hangbin Liu wrote:
> On Sun, Jul 23, 2023 at 11:13:36AM +0300, Ido Schimmel wrote:
> > > BTW, to fix it, how about check if the IPv6 addr still exist. e.g.
> > > 
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -4590,10 +4590,11 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
> > >         struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
> > >         struct net *net = ((struct arg_dev_net_ip *)arg)->net;
> > >         struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> > > +       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> > > 
> > > -       if (!rt->nh &&
> > > -           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> > > -           rt != net->ipv6.fib6_null_entry &&
> > > +       if (rt != net->ipv6.fib6_null_entry &&
> > > +           rt->fib6_table->tb6_id == tb6_id &&
> > > +           !ipv6_chk_addr_and_flags(net, addr, NULL, true, 0, IFA_F_TENTATIVE) &&
> > >             ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> > 
> > ipv6_chk_addr_and_flags() is more expensive than ipv6_addr_equal() so
> > better to first check that route indeed uses the address as the
> > preferred source address and only then check if it exists.
> 
> OK.
> > 
> > Maybe you can even do it in rt6_remove_prefsrc(). That would be similar
> > to what IPv4 is doing.
> 
> Do you mean call ipv6_chk_addr_and_flags() in rt6_remove_prefsrc()?

Yes.

