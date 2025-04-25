Return-Path: <netdev+bounces-186074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F48A9CF70
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF479C42C6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FA1F8AC0;
	Fri, 25 Apr 2025 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfjQ2Kl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0040C1F76A8
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601709; cv=none; b=Esdwwz08tS2EWveDjdEqObZ5Avt6xxFiIRtQbKOBlNo+e0x28Iw0ybBy8mt82oBJ8LYvzDYjBKsuaEebLvSb8nypK3nVxu7FsZrGPQmdvFW5THc7KHhN/Jq1tlb74wZOBiVJ+wyBuWdSSCGEXR+HtNkULm1Nh0R2lUnO3uiPcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601709; c=relaxed/simple;
	bh=9/7AWfVS5lGrL4r+FMFVESzxn7KQVSBLHReKa4iL9UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwFs7Q5Ezxv2pl2+LVQ+3W2EmkSd86GxZMH04p4MtYRLToYJ9ie9HNEXLKtiee6jsM/xc+M5JCfaebvp+QXIQYMtmEs0CDj4rcvhqNcUR2enXWK1YEykAW+BSKEmagK+ozahy6yqEFoolJ9ysQ3nOBLEqHsz5wDNiDtsxYB3ZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfjQ2Kl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8244BC4CEE4;
	Fri, 25 Apr 2025 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601708;
	bh=9/7AWfVS5lGrL4r+FMFVESzxn7KQVSBLHReKa4iL9UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfjQ2Kl2GEV/nyp/oudA8IccQgiUJ5qq8qhF1P3FfPF/sSLWrBj7wpKxujuY2oAUg
	 0UO/FCETYLRGDvgddW5oK5xSAdTOu70NDN1xXZFyVGKbB3qqrI8enqrCVHFssdU3hU
	 /hBQLjvXzSWrgiE1n9Xep0i3CHZW9nUh1u1utYmuQ2oJZK1KrXGDSEmAX1mCPC8fFB
	 DjEqjXz0vaXPMjokMoyY2GT2CqBHHIlEDBQBj/vcXeR3CN+B0GspWdBYo7FG+C2U8R
	 O651TCWQbR1cOzn3rSfjwkJ/SC+lK3kw8p2xCHmbemnNaNbF7fBaAhkOY7Hk4dca4+
	 yCBotUU5X8kdg==
Date: Fri, 25 Apr 2025 18:21:44 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	jacob.e.keller@intel.com, sdf@fomichev.me, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 07/12] tools: ynl-gen: multi-attr: type gen
 for string
Message-ID: <20250425172144.GT3042781@horms.kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
 <20250425024311.1589323-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425024311.1589323-8-kuba@kernel.org>

On Thu, Apr 24, 2025 at 07:43:06PM -0700, Jakub Kicinski wrote:
> Add support for multi attr strings (needed for link alt_names).
> We record the length individual strings in a len member, to do
> the same for multi-attr create a struct ynl_string in ynl.h
> and use it as a layer holding both the string and its length.
> Since strings may be arbitrary length dynamically allocate each
> individual one.
> 
> Adjust arg_member and struct member to avoid spacing the double
> pointers to get "type **name;" rather than "type * *name;"
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl.h          | 13 +++++++++++++
>  tools/net/ynl/pyynl/ynl_gen_c.py | 29 +++++++++++++++++++++++++----
>  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
> index 59256e258130..0b4acc0d288a 100644
> --- a/tools/net/ynl/lib/ynl.h
> +++ b/tools/net/ynl/lib/ynl.h
> @@ -85,6 +85,19 @@ struct ynl_sock {
>  	unsigned char raw_buf[];
>  };
>  
> +/**
> + * struct ynl_string - parsed individual string
> + * @len: length of the string (excluding terminating character)
> + * @str: valud of the string

typo: value

...

