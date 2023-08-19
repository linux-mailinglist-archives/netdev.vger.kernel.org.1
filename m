Return-Path: <netdev+bounces-29113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B477781A50
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3851C209CF
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75411CA6;
	Sat, 19 Aug 2023 15:15:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2467A57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 15:15:40 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD622A14
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 08:15:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id F259E5C00B6;
	Sat, 19 Aug 2023 11:15:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 19 Aug 2023 11:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692458138; x=1692544538; bh=4hM+z4NmquVIU
	oT37ltvxp64SoZbDPKTRRtnlHd9DcQ=; b=bHxnliSE1wlrlnnm57UPEd9lkIl9A
	1oy2TuZMG5GpgKy8kL5DRmzOj1CvhwFjxHC58E3MSAEgPmSbF1n2XIlRDvhBDs9h
	SyeJPCJV0C6HxM5HpfHuzYM3lM2m0HuwGniClWXGJks7oZ2QRZ7KkwOCAyE4syee
	+tfNPmCvl5EECKW7jXdc3tLqUyDjNpvOYidNRxDkbk2mLoq9v+4VfxRmf1w8O7Kl
	Kf+BtvZO+45MJuejJEk+Qhp9mFGNdgyC2aiVrlBzJnqXFZiMJs11lwe0UJeS3aQL
	8+o+cK9ACntyQA1TewP7KBzwxv32Rv4zkh0BfXTUEdwLNB3lcVPW5mp+A==
X-ME-Sender: <xms:mtzgZKn36KSk3UwXDx93ehsr_2BqMWTVrX5s32zkAjwpQJ8YI7XlpQ>
    <xme:mtzgZB1ldasysrMflY79PJN-VpmmhqLqQOniw4TR0zllVcv8zpH3x7jeBI8wh-Hmi
    wmhjmhKZNWA3zA>
X-ME-Received: <xmr:mtzgZIpz8M0SpD-bmw9Rr7PiTAhHVUVEkDMpBar6mpiYKCmlRMkDXgxhdW1dfqQ-lJq-AAw5r2swGMuQSAbk06f2-wLxJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:mtzgZOmZSiuUf3yiPYQXcdnvZ2IX1gfLWOEZTifJBBcDnxNKcs7EbQ>
    <xmx:mtzgZI2iGqLzIcQokR2cft7iQ-yJsXaUlnYDVFXDjr1VMSAggFbneA>
    <xmx:mtzgZFuARJTfWicSwPZc8tu3T7f7VZd-WTmCEVmt9gFdhgsjvcDf0Q>
    <xmx:mtzgZLSsGBeBL3igiX2Mtoz57gPdrBkFrmjfv2C3XmoAZNpLceglYQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Aug 2023 11:15:38 -0400 (EDT)
Date: Sat, 19 Aug 2023 18:15:35 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCHv2 net-next] IPv4: add extack info for IPv4 address
 add/delete
Message-ID: <ZODcl1dMd0/lteOe@shredder>
References: <20230818082523.1972307-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818082523.1972307-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 04:25:23PM +0800, Hangbin Liu wrote:
> Add extack info for IPv4 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> No extack message for the ifa_local checking in __inet_insert_ifa() as
> it has been checked in find_matching_ifa().
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

