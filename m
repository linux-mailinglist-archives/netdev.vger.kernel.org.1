Return-Path: <netdev+bounces-31079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DC78B42F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9532E1C20937
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D98134AC;
	Mon, 28 Aug 2023 15:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4912B95
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:16:24 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECBAFC;
	Mon, 28 Aug 2023 08:16:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 280B25C00C5;
	Mon, 28 Aug 2023 11:16:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Aug 2023 11:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1693235780; x=1693322180; bh=izccesX1vfQwV
	GzCTI5YaDS3c9nr+xW6WfChf1mUIfw=; b=Ka5poLSMA14cEaOBl0EChO8g6+JDM
	o6HwF5z7dvfAWg/GTS4ExtAQK7h1ZfxfgtarcqoIhU84QbULVlIhqoHKLbLqAAny
	ID1iEh36AGm5N9YzXN23q6rPUsUhTQyfXRBaCv+tpHNqQQuqg/PBDYZPsHZ1vlcH
	48C4Y3pbfVRzr9Fo8UQrYoujhFCgr2LNJkEc637fPXJjUJxvamDumYb+u3O+GYbS
	oJCc1+wfYQH1BD9aeQ35kT6O4umMxWrngKd5WWnaYFvLK/pbk1AFdY+7qNGU8HVj
	/m/+JBJnK4M+YuH1mQHRL/i05MQnVOtE11ROcr02edaSCemEhaLevD31w==
X-ME-Sender: <xms:Q7rsZFy2F8OQ6qv0akLpQpb1ghce4vHVN9k4Omae5YcymezTygjfPA>
    <xme:Q7rsZFRptYscaDITz3k7CXdegYeXNQ3HxXgzjFYQRsnP8G-xoxHWIQfnNknylSFQG
    iOox-qZPkDIEUo>
X-ME-Received: <xmr:Q7rsZPWor2GV65xwcW2rGF6Ug-LM4YPCUF06WGwoaIg4Zyi4nc-kgvVANy7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:RLrsZHh6VuaN4QOWOu4zZUyuU8xn8GtFz0CgIKZ14vSKM1rnTodciA>
    <xmx:RLrsZHC5vfcIeos6lM4Niob7qfchKrsu9YADl0gvrM2beBW22DtHcQ>
    <xmx:RLrsZAIxiYRxxjzFCcm_HYhZe7KHj7ugaTXJcEZ-hobBgTo_Rt_Hsw>
    <xmx:RLrsZL24ntPLbTj-YJZl3BA0fCibbkowQ5jNJMzHsA2CiJcR9Oh30Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 11:16:19 -0400 (EDT)
Date: Mon, 28 Aug 2023 18:16:17 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v3 2/3] ipv6: ignore dst hint for multipath routes
Message-ID: <ZOy6QfalXBa6AvOT@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-3-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828113221.20123-3-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 01:32:20PM +0200, Sriram Yagnaraman wrote:
> Route hints when the nexthop is part of a multipath group causes packets
> in the same receive batch to be sent to the same nexthop irrespective of
> the multipath hash of the packet. So, do not extract route hint for
> packets whose destination is part of a multipath group.
> 
> A new SKB flag IP6SKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in fib6_select_path() and use it in
> ip6_can_use_hint() to check for the existence of the flag.
> 
> Fixes: 197dbf24e360 ("ipv6: introduce and uses route look hints for list input.")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

