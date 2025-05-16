Return-Path: <netdev+bounces-191226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E19BABA6C5
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6861BA23B28
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C27280CE4;
	Fri, 16 May 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="oAil7imi";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="nhi9N5vy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CC231856
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439759; cv=none; b=LMqbXrV3X1+HQU4EIIOmkJdlFD/IcKtRftepvrVG6IDwNEZF1mSqAnkzqM6tlhfhYY3ow/nQRnPczernGHK71nRubLuf4fF11USb945DYAHyvh536AtSIGpWynVKRZiMoV0wBT5Z/WHr6GXb3uXymYws9FrfgsldjHquirh2Iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439759; c=relaxed/simple;
	bh=EufAfJqm0pMz0K/Z5Mq5mBGalNCwCgRsBFQ0MTjK0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2YqpYvBjVQGjYIglEEGcERJsMgYQVVszDyFscz3yK1XBoJf/SDBCSKc7BoVaKRbIFdv/pJjKfffZeWbyNgmJz7k2cpb/+wuqI4i0KDd0Zfjh58G/7QJIByLpfP8VND2glsCAegESmbX84qiBAyTpOLtwBwh7mcg2H0pRRta1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=oAil7imi; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=nhi9N5vy; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 48CD360273; Sat, 17 May 2025 01:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747439747;
	bh=s4MLl8BZyMf/gXInxet0dsYr6y/8baeq4mQfN2URMqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAil7imiaBU4KATYSXBXFSPQ7dNsGm1sy53rVxp/YfxWf0btJ33s9qk8npY6KokK3
	 /HIvuNAaqDHe5AHRKLCST2b8WMQrpfja46zQXxQUALoOui3SUrk7jgXStJ95KxylKh
	 PkaPrP/yuW3R2P7sUb3GovXFD+OtBjEaNQWkQZDiQwXS/P4rrxAz+iRznmJ7T5kubX
	 +fdDxL0ynhtcj2DWs0RPzEP1v1710zy488oO77Eiqc8ioDFKs0m7Z9grU9IzlXPoDz
	 Wk15n0NGTK294sm2XnolbqCOw/BNhd6+5A9wT6hBKWWc3GMVQlVWbylrMD3tApYo1f
	 z3pq+xwZ9rauA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E245560254;
	Sat, 17 May 2025 01:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747439745;
	bh=s4MLl8BZyMf/gXInxet0dsYr6y/8baeq4mQfN2URMqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhi9N5vyrGGNgXAjEW8Xp1OD9LnrSJFG1Z9s0QuBgqzc9bKkUCRFhBVFue/il8bW3
	 X236BhWVoZJ+CGADdzOJ/Q2dV4sqozjkxlf3IQsj2HrepDJLMOBRHQ33ZaO4yqv5gw
	 bIafvshgR95vhlMQrg3kLfhNvwTZFkydF/T9OyQ22Ye02myxkvWQoSdcwlP7yqXJk/
	 olJam/0UaiYGyJBHwE/mWXzFaO7ykCiHhm/VVBZOJQaFSUqmviIw4mgN6mWMH5iJKo
	 OOY6S3th9A+jWb+CdcH6IdSAYgZjC+mrqHAw2pa25GTL2uwDxf4QZdHPk1zCcEXHTc
	 s+mJp7DgMXV4g==
Date: Sat, 17 May 2025 01:55:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	razor@blackwall.org, venkat.x.venkatsubra@oracle.com,
	horms@kernel.org, fw@strlen.de
Subject: Re: [PATCH net] bridge: netfilter: Fix forwarding of fragmented
 packets
Message-ID: <aCfQfq_FEwa98RCw@calendula>
References: <20250515084848.727706-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515084848.727706-1-idosch@nvidia.com>

On Thu, May 15, 2025 at 11:48:48AM +0300, Ido Schimmel wrote:
[...]
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d5b3c5936a79..4715a8d6dc32 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -505,6 +505,7 @@ struct net_bridge {
>  		struct rtable		fake_rtable;
>  		struct rt6_info		fake_rt6_info;
>  	};

This is missing #ifdef to restrict it to bridge netfilter.

> +	u32				metrics[RTAX_MAX];
>  #endif
>  	u16				group_fwd_mask;
>  	u16				group_fwd_mask_required;
> -- 
> 2.49.0
> 

