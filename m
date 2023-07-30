Return-Path: <netdev+bounces-22611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6683A7684D0
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C2F281839
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5F17C9;
	Sun, 30 Jul 2023 10:29:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70434137A
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 10:29:21 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94962E56
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 03:29:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 5391B32008FE;
	Sun, 30 Jul 2023 06:29:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 30 Jul 2023 06:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690712955; x=1690799355; bh=jrckBkZuEPUVp
	6zPKNYYZfvxLIewqYQ/NgiNsuVwrIA=; b=KyOYBED0wC2H6sekrTRpmRxeud6HJ
	HPoAfPtMmvbRbglR8TEI0ugL310NKM9b1LO4bdMtjBVTBJoCChqeHL6jc9vJ853M
	RCedlkklkZMvmOqLbbuWgUfBelyQUXyMqrGZwy7Nf8AvAb05TMOgduiK+6V5jk0r
	aknt5pbJ4OTdfp7+4+XiX+HSPmBzHvehXc02gPn6ZOuMsgG1Z6maDUmWpF19qc/y
	2Xi9xSzC/xhXCu+9lsu68h+Bv1Bxpk9BofeTIJXINWug1Jye7cM724f1uLMzbXni
	m3r0mbeSvBrm55p6wGYgpDqn3CIcH8Oo6p9DX/XjcYskZHwZd2B5VXjrg==
X-ME-Sender: <xms:ezvGZFSkkPdzcudiKvahuOC2HcsrgoX2FK9GLj0S2OdI6oVReoL0Ug>
    <xme:ezvGZOyLn_l7zB9VqBpOm5Ro0TDmwROFfm8epWpTwssUKN0n72zewMXLMUwhKvbBp
    C65guXS7WAHUlo>
X-ME-Received: <xmr:ezvGZK3zlD0v8VMnVa7D-gTqUbg1ew6cBBOQy4UFh_KwdAQcFh2Um3qj5IBd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:ezvGZNCauPlyRloQnoZA1-oNk3joih9YqaTKAaeJY_G763GVOb_RfA>
    <xmx:ezvGZOiOtILws3nVkuZHpsjEoACm_mvTavGtyPzN9At6hm9rM0k91Q>
    <xmx:ezvGZBrlC06NPXWFIOpj0cIbDfWQbw0K9ud5bmUIWqI2hIdm9t8Pyg>
    <xmx:ezvGZGL52Ub8XC8z0nJ_8ePi5kDNWo9td-QCwA7o-G8CJkRsjS-a2Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 06:29:14 -0400 (EDT)
Date: Sun, 30 Jul 2023 13:29:11 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
Subject: Re: [iproute2] man: bridge: update bridge link show
Message-ID: <ZMY7dzm1Sd/Htg9c@shredder>
References: <20230727172208.2494176-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727172208.2494176-1-nico.escande@gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the patch

On Thu, Jul 27, 2023 at 07:22:08PM +0200, Nicolas Escande wrote:
> This adds the missing [ master DEVICE ] in the synopsis part and the detailed
> usage/effects of [ dev DEV ] & [ master DEVICE ] int the detailed syntax part

Please use imperative mood [1] in the commit message. Something like:

"
Add missing man page documentation for the feature added in commit
13a5d8fcb41b ("bridge: link: allow filtering on bridge name").
"

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  man/man8/bridge.8 | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index e0552819..4e7371fc 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -66,7 +66,10 @@ bridge \- show / manipulate bridge addresses and devices
>  .ti -8
>  .BR "bridge link" " [ " show " ] [ "
>  .B dev
> -.IR DEV " ]"
> +.IR DEV " ] ["
> +.B master
> +.IR DEVICE " ]"
> +
>  

It doesn't affect the output, but you have a double blank line here.

>  .ti -8
>  .BR "bridge fdb" " { " add " | " append " | " del " | " replace " } "
> @@ -661,9 +664,15 @@ display current time when using monitor option.
>  
>  .SS bridge link show - list ports configuration for all bridges.
>  
> -This command displays port configuration and flags for all bridges.
> +This command displays ports configuration and flags for all bridges by default.
>  
> -To display port configuration and flags for a specific bridge, use the
> +.TP
> +.BI dev " DEV"
> +only display the specific bridge port named DEV.
> +
> +.TP
> +.BI master " DEVICE"
> +only display ports of the bridge named DEVICE. This is quite similar to

I would drop the "quite" and just say "similar".

>  "ip link show master <bridge_device>" command.
>  
>  .SH bridge fdb - forwarding database management
> -- 
> 2.41.0
> 
> 

