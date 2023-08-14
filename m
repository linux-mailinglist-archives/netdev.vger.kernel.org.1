Return-Path: <netdev+bounces-27414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B1A77BDCF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BFA281194
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423ECC8DD;
	Mon, 14 Aug 2023 16:20:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620AC139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 16:20:34 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B74F1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 09:20:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 419023200928;
	Mon, 14 Aug 2023 12:20:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 14 Aug 2023 12:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692030031; x=1692116431; bh=wM1fHPx8XExjo
	TqHktlrXh5pfaB7rRKBytCe/u/jb/M=; b=vzl5sV9jpCszK01Fbd0lQQ181lutk
	/rmbKDl7m0expN3R/k95e1R9Ml3EEjtxILlMl6tH6wD5UVWbuLaCXC399SEzcZj7
	LEUwF6jtYZ2dpFvleCNRDYj4H3iDimz+Yc82L3Ca3hfA5l3aQ7oXZCKT2TRYKaiC
	0YTTpkdeSwLbNAfevvHBcxt8Pj0l19XVaZ7PGOF7rl26ErKCEVNv3fJMwA7z0oVs
	U0r48wFNWFIhy/vuA/DVKNSbfeCtug5qj3RND5bPvf190n0TUOhTU7BSMsNfjEIS
	oz8VyrC+YNQB+29bKfDhJ1ScDy65G+fMtKp/hZHpvFNrXSHf6hjRLS2DQ==
X-ME-Sender: <xms:T1TaZAqIv0sdPmyHObSTglwKuMfytIZmz4MlmdH-f82nnKFIV_UlMg>
    <xme:T1TaZGoE9LFSx6dqHgHkYzkxg0RAjEFKX7JTgY0ZOVsbaLZ-e7JEt5qNt7hNTVsRf
    UaUy4zvOIwHAOQ>
X-ME-Received: <xmr:T1TaZFN19fVBohESyU98Xj5NBKO0XrV4LhmcgsV-lPwHVNZG2jNSSO5Fmf56>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:T1TaZH7yUqghvzm0tijBF0j45HHccaTWCALcbFv-gEikHkFTzESzWg>
    <xmx:T1TaZP43mj3tc-AXw4lCs7En4oYuw45L8zRxNFRwwzzrNks4AdRIqg>
    <xmx:T1TaZHinBiwohEqQrxBTt3HNRa6r0wPql7OEQLrp1FqudsxsiD_6Zw>
    <xmx:T1TaZFQ7DjJ0-vfNUwvuktOuSgiI2Mr1KFu_BsP0yfcpbrdR4nbkyg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 12:20:30 -0400 (EDT)
Date: Mon, 14 Aug 2023 19:20:28 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv5 net-next] ipv6: do not match device when remove source
 route
Message-ID: <ZNpUTLvUqtp5rEzR@shredder>
References: <20230811095308.242489-1-liuhangbin@gmail.com>
 <ZNkASnjqmAVg2vBg@shredder>
 <ZNnm4UOszRN6TOHJ@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNnm4UOszRN6TOHJ@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 04:33:37PM +0800, Hangbin Liu wrote:
> I will remove the tb id checking in next version. Another thing to confirm.
> We need remove the "!rt->nh" checking, right. Because I saw you kept it in you
> reply.

My understanding is that when the route uses a nexthop object (i.e.,
rt->nh is not NULL), then rt->fib6_nh is invalid. So I think we need the
check for now. Maybe it can be removed once the function learns to use
nexthop_fib6_nh() for routes with a nexthop object, but that's another
patch. Let's finish with the current problem first.

