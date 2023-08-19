Return-Path: <netdev+bounces-29112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16777781A4F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26461C20982
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84A125A6;
	Sat, 19 Aug 2023 15:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7D6110
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 15:14:20 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68D5582
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 08:14:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id EED855C00BB;
	Sat, 19 Aug 2023 11:14:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 19 Aug 2023 11:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692458055; x=1692544455; bh=jHZV5IXlDFPvc
	AxlRffTArKHnxDXxFc8qkJM+sIMiJY=; b=ZhJCEv+BETMXC1+zocQ9lyfq8r0ZJ
	rhEuty+XK512G7kL+iwTnSffCNH/4c7XZSt97e2acQTD60X/MPK76dVb0LKyZAjf
	dsJvAyjwQjY1Bov8eyxWyfFFeGYj1qBkbJXN8B/USOFC00Qbu5Y1xM3u9iZynWWr
	9euYH8pxNgrLFpaD4HicSK08Fb/i8P/SOVarWw9OtqmwVzlBpNv8CGXYbl1AZobF
	HeOaXtRZBtf+LM3DPHG7kFc4pODAdPh6XMWFb5AXECzKife3HPYV7gQ9t7xCiKvb
	gy697N/rOWV/wlaOz0k1BGjQLwPyoIhP11ZYGPmO8uMbExPVP9vM9rFUA==
X-ME-Sender: <xms:R9zgZF5_kcK0asq_GVy9v5rhnIIi-IuZcxAXx_jZksdyzvckaqxFcw>
    <xme:R9zgZC7L_8Zhe0s_-kKgF44mURF9kFa73LsX_LGq5G8kG8bvtYFPorJfxenX-RgJe
    tnCXVQp_mqWdfc>
X-ME-Received: <xmr:R9zgZMcuPbXttlEdDj65m962H3DlzZRWUi-U8U-Fb28WdMAgO71QPYIkRqqyjmJzQCE1eKRT0nuuecqeh6ng8u54rx0IVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:R9zgZOIgaxlv2nMAca0tqnOEUuwQYtagaCvlNNFmM6M9dHcPfJzs6w>
    <xmx:R9zgZJLQw5rUjzuH-dz9cdSXfV0Vsuhe1ilbhx8fanZkJ4HL0s5eQg>
    <xmx:R9zgZHyWQTZKPA2rK-Bt3PuecJSXhYsAol2p7Pi976BHXzl4RskRGQ>
    <xmx:R9zgZGETQgL2-XhdJcYo5gKm36c8oDwxOsN_V93Cw5Q7bbXBQIb9Xg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Aug 2023 11:14:15 -0400 (EDT)
Date: Sat, 19 Aug 2023 18:14:10 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCHv7 net-next 2/2] selftests: fib_test: add a test case for
 IPv6 source address delete
Message-ID: <ZODcQgeILLD51Vf4@shredder>
References: <20230818082902.1972738-1-liuhangbin@gmail.com>
 <20230818082902.1972738-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818082902.1972738-3-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 04:29:02PM +0800, Hangbin Liu wrote:
> Add a test case for IPv6 source address delete.
> 
> As David suggested, add tests:
> - Single device using src address
> - Two devices with the same source address
> - VRF with single device using src address
> - VRF with two devices using src address
> 
> As Ido points out, in IPv6, the preferred source address is looked up in
> the same VRF as the first nexthop device. This will give us similar results
> to IPv4 if the route is installed in the same VRF as the nexthop device, but
> not when the nexthop device is enslaved to a different VRF. So add tests:
> - src address and nexthop dev in same VR
> - src address and nexthop device in different VRF
> 
> The link local address delete logic is different from the global address.
> It should only affect the associate device it bonds to. So add tests cases
> for link local address testing.
> 
> Here is the test result:
> 
> IPv6 delete address route tests
>     Single device using src address
>     TEST: Prefsrc removed when src address removed on other device      [ OK ]
>     Two devices with the same source address
>     TEST: Prefsrc not removed when src address exist on other device    [ OK ]
>     TEST: Prefsrc removed when src address removed on all devices       [ OK ]
>     VRF with single device using src address
>     TEST: Prefsrc removed when src address removed on other device      [ OK ]
>     VRF with two devices using src address
>     TEST: Prefsrc not removed when src address exist on other device    [ OK ]
>     TEST: Prefsrc removed when src address removed on all devices       [ OK ]
>     src address and nexthop dev in same VRF
>     TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
>     TEST: Prefsrc in default VRF not removed                            [ OK ]
>     TEST: Prefsrc not removed from VRF when source address exist        [ OK ]
>     TEST: Prefsrc in default VRF removed                                [ OK ]
>     src address and nexthop device in different VRF
>     TEST: Prefsrc not removed from VRF when nexthop dev in diff VRF     [ OK ]
>     TEST: Prefsrc not removed in default VRF                            [ OK ]
>     TEST: Prefsrc removed from VRF when nexthop dev in diff VRF         [ OK ]
>     TEST: Prefsrc removed in default VRF                                [ OK ]
>     Table ID 0
>     TEST: Prefsrc removed from default VRF when source address deleted  [ OK ]
>     Link local source route
>     TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
>     TEST: Prefsrc removed when delete ll addr                           [ OK ]
>     TEST: Prefsrc not removed when delete ll addr from other dev        [ OK ]
>     TEST: Prefsrc removed even ll addr still exist on other dev         [ OK ]
> 
> Tests passed:  19
> Tests failed:   0
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

