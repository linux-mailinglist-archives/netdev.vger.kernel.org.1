Return-Path: <netdev+bounces-29288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2B782804
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389C71C20441
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A25255;
	Mon, 21 Aug 2023 11:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3164A3B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 11:34:45 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5DDC;
	Mon, 21 Aug 2023 04:34:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 55BA55C261E;
	Mon, 21 Aug 2023 07:34:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Aug 2023 07:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692617684; x=1692704084; bh=d9ur8nZhHGPYN
	lNZZr8e+NyS1wGTtgBr6uaH9qP+sp8=; b=aEBtMGPfMjRCvzEhvoH5k69DUdD4N
	qkB/ZLTTDVcsRDGf6hDG46DIEpmPQ6ODJCJRUgQ1M2VQtEQRBglG3NFVrI+dUxzQ
	o5Ddr1F0UNY1FLCeuIpFOcRaHudZbiP3e5JTmbeVqG99gyCzqTfq6aDiwssBiIeY
	9vYuKpYqPWDuGIhxLR2V2uCbxYJg5dRPv1xUhJS1dnC6qs+qhqKAKLLdWwX+0h8j
	4ngiK0phf/9KFpRdPZR2b3z5PNEWVrfXnZLQAdBrtOrmoLfAZ/uVZbC/wgTcORJO
	XxmpwzLx24OzYfTcgzfVqOa2F97qBvPHqLenqNDWoKZzYoqj8nmZtVVsg==
X-ME-Sender: <xms:00vjZPcvwQgGB8CzIRCvTKS_XvOMka0TyepjjEsfdYLEzXz0NWNa9g>
    <xme:00vjZFNyA_32NIODRpbqITzPNdp7VM6_JNZaK2kNuoCKKA5Ji-c_RzpOqWr4hbsOL
    H3EeFQyKkbMRgI>
X-ME-Received: <xmr:00vjZIiXEinzZKspUrSbcXDXR9hyyqsWxL5bej4xvugNNEQTi9B9c5qia-Kv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:1EvjZA8hUhfZVAwND5gaZTlCZ6Z6tfHNxAKVa7fg-Iqp2iWPL22TIg>
    <xmx:1EvjZLtRw28OcUQDTeN3SIp0Rm3ZzWXTbAu7HZ7Xn7TwWHPEMDgTeQ>
    <xmx:1EvjZPFq4hQWzB0Sb-DdxldVzjIRNBGSadttPiWcMZJH62NEwMsh0g>
    <xmx:1EvjZE83yiQGWOUrwer61EhIR_4liLd-znxI08wfWKndeQMnrKp2Tw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Aug 2023 07:34:43 -0400 (EDT)
Date: Mon, 21 Aug 2023 14:34:39 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 3/3] selftests: forwarding: Add test for load-balancing
 between multiple servers
Message-ID: <ZONLz5IyaG+XnUSJ@shredder>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
 <20230819114825.30867-4-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819114825.30867-4-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 01:48:25PM +0200, Sriram Yagnaraman wrote:
> Create a topology with 3 hosts, a router each in it's own network
> namespace. Test IPv4 and IPv6 multipath routing from h1 to h2/h3 via
> router r1 where a multipath route is setup to load-balance between h2
> and h3.
> 
> See diagram in the test for more information.

How are you running this test? At least with veth pairs it is passing
both before and after the patches. I didn't look into the veth driver,
it might not even use the listified path.

Also, I'm seeing the following errors during the test:

sysctl: setting key "net.ipv4.fib_multipath_hash_policy": Invalid argument
sysctl: setting key "net.ipv6.fib_multipath_hash_policy": Invalid argument

