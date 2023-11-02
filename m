Return-Path: <netdev+bounces-45674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18457DEF3C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C51C20EB7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B211CBD;
	Thu,  2 Nov 2023 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjkmLpkI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013B11CB9
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:53:04 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76659112
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 02:52:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E607C5C011B;
	Thu,  2 Nov 2023 05:52:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Nov 2023 05:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698918775; x=1699005175; bh=+SXwx2GINUbqH
	/xqub7nVpg9eKQQWaR/PXsEI5wkKnc=; b=JjkmLpkIvHaVGRq5HLfOKx45vv1nT
	AIXweloGC4ZtcgqqHf1g9FrWFjHMb3SMwM918NNurXd3YteADT9hknHE/fVn59c9
	2nSdgrN1YlPuuQhRE5qG3bdN7YCepr39+DLLAo6IqPDYa/MvY/x66wtG7N/miqYF
	foExCAO4sq1lrl8GierDDVVzRiTw0MJRqak24ABlarYXZBE+uV+Hf0BFnmw80Bw0
	/zskBLK+tKHtiENma/OZv2zWV4qjIidcz+ujd5P4BiaR+pTVDeyR+KAkXm92XUu/
	yDrCdQuECFeLs4FPYS/dJ2Ywt2PFsqZDSw5MKOBmK6ZvkRXxI0cHGMx6Q==
X-ME-Sender: <xms:d3FDZQdtF5EEv0aJ-4YyvEtjsO7DBS5Lkpa2ZiQ84XsV-vFxCfLlIw>
    <xme:d3FDZSPSV6_E3ux3VXBlxJ-xWk2ESo5A48eNNCr70bT44ktYX52Xkri4ixCnlQH92
    T2NvJnvcLhjemU>
X-ME-Received: <xmr:d3FDZRhD1JgO30tUsuIVR2UVCi52h6csnmHD5ij-uKTtqe5SvtqLReUyT45T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegte
    eiieeguefgudffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:d3FDZV-Nq7Vpw7CEORjfGbElSvP7Gckym1S0bbmfw92i0V9KmSmpZg>
    <xmx:d3FDZctP5mwwyow7I2CSqoEOk0jYvAy8TxfnM8UHjWhMpScX2X4_eA>
    <xmx:d3FDZcH3ymP9wr78j6rPUi9Mx-i2CY98cLUEPzMPwwL1_wa2TXV8sQ>
    <xmx:d3FDZWWwEtcOeD7VERvzLQ-nhAdT10RvP0OInr7UKjJ88UTau_Hn6w>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 05:52:54 -0400 (EDT)
Date: Thu, 2 Nov 2023 11:52:51 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Yang Sun <sunytt@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net: ipmr_base: Check iif when returning a (*, G) MFC
Message-ID: <ZUNxcxMq8EW0cVUT@shredder>
References: <20231031015756.1843599-1-sunytt@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031015756.1843599-1-sunytt@google.com>

+ Nicolas

On Tue, Oct 31, 2023 at 09:57:56AM +0800, Yang Sun wrote:
> Looking for a (*, G) MFC returns the first match without checking
> the iif. This can return a MFC not intended for a packet's iif and
> forwarding the packet with this MFC will not work correctly.
> 
> When looking up for a (*, G) MFC, check that the MFC's iif is
> the same as the packet's iif.

Is this a regression (doesn't seem that way)? If not, the change should
be targeted at net-next which is closed right now:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> 
> Signed-off-by: Yang Sun <sunytt@google.com>
> ---
>  net/ipv4/ipmr_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> index 271dc03fc6db..5cf7c7088dfe 100644
> --- a/net/ipv4/ipmr_base.c
> +++ b/net/ipv4/ipmr_base.c
> @@ -97,7 +97,7 @@ void *mr_mfc_find_any(struct mr_table *mrt, int vifi, void *hasharg)
>  
>  	list = rhltable_lookup(&mrt->mfc_hash, hasharg, *mrt->ops.rht_params);
>  	rhl_for_each_entry_rcu(c, tmp, list, mnode) {
> -		if (c->mfc_un.res.ttls[vifi] < 255)
> +		if (c->mfc_parent == vifi && c->mfc_un.res.ttls[vifi] < 255)

What happens if the route doesn't have an iif (-1)? It won't match
anymore?

>  			return c;
>  
>  		/* It's ok if the vifi is part of the static tree */
> -- 
> 2.42.0.820.g83a721a137-goog
> 
> 

