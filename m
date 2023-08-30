Return-Path: <netdev+bounces-31431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1C78D72E
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A721C20803
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2566FDD;
	Wed, 30 Aug 2023 15:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132E6AB2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:42:13 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D40122;
	Wed, 30 Aug 2023 08:42:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B75585C0056;
	Wed, 30 Aug 2023 11:42:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Aug 2023 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1693410131; x=1693496531; bh=Af9RLeZAlBuc5
	gc2kiqVFlBa+yCpdvEQfwKLpsa17Gk=; b=uSWomlpkiybUlQfu311Q6zBNpw3BK
	HYGxFNxHKoZT3+WX+BuFxmbjl5YqFNPXtnUJ0IyZdSj73eAl585roI/26yD9Tva5
	QK0CSlelyX5Dvq8fqaFx7wotFrVHSSIpm9GaODi/i5Sb0kqibKjx8l39WsCME8Ui
	uFLRQoEAtu2i2NOb0K1xxn8fYRi6EayxQCep4QXSjprRu7NInL2RPCxKiM41j0IW
	VW3dEtkP8KfgeG2hgSfE1U/ymimSHQoKXWrMSYuHa1dNoHsh4th26ZN0Bj/4bjFb
	zCVOhCveqH3YXOvek90FE3fXZM0vW8HD2GNA4tzHhzTuBvibeN/HMMHQA==
X-ME-Sender: <xms:U2PvZGBp0mRlulxHqJkriewTcLCa6Y1JgiKqSe7HAS9qjN4IimAj2A>
    <xme:U2PvZAg6uaQCiC7Y6YmzcW2VKBHUJL8D9Awzl7plKP8HOdXP1SI67E8qKghhyCY1j
    WC9PM2v6B5v15Q>
X-ME-Received: <xmr:U2PvZJk9wfMQPCqeKEGd40yBwnE5reP4cRTptRXzR8mGzDqWa9G1LPnI3jBeXNpWpinhO7sDcNUgX_aqryGbbqsyvZN3JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:U2PvZEwcjiL7qY3pmRLwCS8h5zB76B3XlIoPkM-GLRgirKEDUGE25w>
    <xmx:U2PvZLQYQp6QOFQ6XVsbRaa3FDGbBdsFMQbSqYka0SdSyvrWS3_gzw>
    <xmx:U2PvZPbYLCOcrxO-rhA2sQcS-Qlro7JVLFd2rjoD6vp9BLKG9e-5Xw>
    <xmx:U2PvZGG-juercc-TGWOc83z_nd_9VS6w6ZBUpLaZq6Xpca-KEb-KXg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 11:42:10 -0400 (EDT)
Date: Wed, 30 Aug 2023 18:42:08 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Message-ID: <ZO9jUL1gdTtlXU/y@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-4-sriram.yagnaraman@est.tech>
 <ZOy8JOjw9W4g8fYa@shredder>
 <DBBP189MB1433991FA2FC288F7274193995E6A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBP189MB1433991FA2FC288F7274193995E6A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 09:17:22AM +0000, Sriram Yagnaraman wrote:
> If it is OK with all of you here, should I try to improve this test to verify TCP resets don't happen when the nexthop is in a multipath group, perhaps using iperf3? I can send another patch if/when I get something working.

Yes, just make sure it's stable. That is, the test reliably fails
without the fixes and reliably passes with the fixes.

