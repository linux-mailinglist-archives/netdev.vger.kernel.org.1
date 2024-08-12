Return-Path: <netdev+bounces-117604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85794E7E2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3F9B215FF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF114F138;
	Mon, 12 Aug 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG8ElC2Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62212136328
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448004; cv=none; b=mjb73kv2ke8T7SRDKMGROV2H5wYg4VJdrSoZ2xM0byY3y1x4BfQ2wMyljKYWjAZNZABhAZy4Vy8mHwemYrNvPa0VAkc3BLJjyQ7sFzs6wTmuODpdNq5AciQFURI5FZgTcHiSQyOp6xvKa5FGPv4PNIfVRh9Dfa0L1nPqQTj1HBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448004; c=relaxed/simple;
	bh=Kb6aYdGXYBie73PgQFQL4UaNW82u/uD1GS76tQrlfWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2H7DrNlQfGp+4xMBwUj/QFPsMNMU+Ws0rZ1M3dfOywykwgfpCR9dsBnzkDB0YQJPgq3VP91ay2eoOxqFBSNM2AGsKD4/49logGLQ4uP8FF+VwMAC4OdDBVBtxjprGVMh5Li6j9SWFGECBYdl6WGBPbnLvwtylKBCknb7ud/Aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG8ElC2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5D3C32782;
	Mon, 12 Aug 2024 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723448003;
	bh=Kb6aYdGXYBie73PgQFQL4UaNW82u/uD1GS76tQrlfWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BG8ElC2YkVrvK+mLb+08gsgWD7dSjVGWY0JcvMva0xtDuctDz7zG1LviCXbKtABF+
	 qy3rGQEDrgb6LFUHlsCUtC+scc12/lpP/OtOCv+qQ7fyxycLExfo8gzqQCcCMznFUq
	 Ie1BYvgL9JNS+NaSl0FQ/KnQd/4CLS/kDLuJpMLUzpjDp96R10fuF195R37x/dfAyM
	 GM8G4ubpeOlxUDcVbk7RChVuCU/oz0jirDVTDvvbpBohtSlcuuZyT70+0s5Z0GsPma
	 +jDdEEFwNWvNICU5RKiwsp6IIQ1VoZYqDIFKHQYrQ/ERBDeO6ASaMGx7yLs6eBU0nr
	 Bp3R9bjuQ7dag==
Date: Mon, 12 Aug 2024 10:33:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute] man/ip-xfrm: fix dangling quote
Message-ID: <20240812073320.GA12060@unreal>
References: <20240811164455.5984-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811164455.5984-1-stephen@networkplumber.org>

On Sun, Aug 11, 2024 at 09:44:46AM -0700, Stephen Hemminger wrote:
> The man page had a dangling quote character in the usage.

I run "man -l man/man8/ip-xfrm.8" before and after that patch and I
don't see any difference. Can you please provide more details?

Thanks

> 
> Fixes: bdd19b1edec4 ("xfrm: prepare state offload logic to set mode")
> Cc: leonro@nvidia.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/ip-xfrm.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man/man8/ip-xfrm.8 b/man/man8/ip-xfrm.8
> index 960779dd..3efd6172 100644
> --- a/man/man8/ip-xfrm.8
> +++ b/man/man8/ip-xfrm.8
> @@ -71,7 +71,7 @@ ip-xfrm \- transform configuration
>  .RB "[ " offload
>  .RB "[ " crypto | packet " ]"
>  .RB dev
> -.IR DEV "
> +.I DEV
>  .RB dir
>  .IR DIR " ]"
>  .RB "[ " tfcpad
> -- 
> 2.43.0
> 
> 

