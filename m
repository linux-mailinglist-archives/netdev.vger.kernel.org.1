Return-Path: <netdev+bounces-93986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C38BDD5A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1011C215E3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043413D25E;
	Tue,  7 May 2024 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmsq7Mb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC84F889;
	Tue,  7 May 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071421; cv=none; b=oam4bvwcwVpfYZdlip+tcScdtVBcNbxVRYxzkGAJOddtrGooYCmnMRsqLL1nAWGCZwfwsDoSDqXhVDyzv9JT8VzJxqx6sUg/gm0LdSRwRpXXtXe2KDZHH771tEqZ7gdRo3xng88jkl/BHa2uBM7z8mTZil5MiwLZht/ECJoRvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071421; c=relaxed/simple;
	bh=6jrOGZZQleYQuLgxpnrxrMV+9qFCw9xht/C6Z2bXZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtdAMEQahAuwcIhFrRPaeTy2myifpJpwE6KjcZ9/6+edFjo+7CABUdWLlix+dPewVpLTLDzBHjTY6QZ8jSI6HmnsgwUjlPukoLO/TkwPk0ps2tPtcCPZZ4iOewAUfnq3ngLxf69v5QgiOKEDZwTqY73wcZurklWB3eI/Mh1Wzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmsq7Mb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D13C2BBFC;
	Tue,  7 May 2024 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715071420;
	bh=6jrOGZZQleYQuLgxpnrxrMV+9qFCw9xht/C6Z2bXZrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmsq7Mb3syIcNZOG/YFCtgCLmpBtt/aPq3LWZfqt06CLGUO0qvuBr52HJnr76RCBb
	 9pHneN025FgaF/nN1tjlOXqA+podWiFYcJXoJpcIEcyxck28fcneox6cMh7byfCSQg
	 Eh/KSz3dU/6wwkb50V+NKLDz4iEG6DV6IfpiU89A8UFEwaHjnuv7jBMed5OG9rgwzG
	 7B4kEGnI364EMBcOKzDF3rG4mVd3++fta/FKHPT5LEQTtRXGrF9stPkgf1DZD/5lCg
	 Ws79j9H5rAdkmStV8rdcs0tcLOADeRWwodJq9+MAS16RKkto+vozkceh1UImGox76T
	 px2eVWdSdJvXA==
Date: Tue, 7 May 2024 09:43:36 +0100
From: Lee Jones <lee@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: clockmatrix: Start comments with '/*'
Message-ID: <20240507084336.GX1227636@google.com>
References: <20240504-clockmatrix-kernel-doc-v1-1-acb07a33bb17@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240504-clockmatrix-kernel-doc-v1-1-acb07a33bb17@kernel.org>

Subject line should start with:

  "mfd: idt8a340_reg: "

On Sat, 04 May 2024, Simon Horman wrote:

> Several comments in idt8a340_reg.h start with '/**',
> which denotes the start of a Kernel doc,
> but are otherwise not Kernel docs.

Some very odd line breaking here.

> Resolve this conflict by starting these comments with '/*' instead.
> 
> Flagged by ./scripts/kernel-doc -none
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  include/linux/mfd/idt8a340_reg.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
> index 0c706085c205..53a222605526 100644
> --- a/include/linux/mfd/idt8a340_reg.h
> +++ b/include/linux/mfd/idt8a340_reg.h
> @@ -61,7 +61,7 @@
>  #define HW_Q8_CTRL_SPARE  (0xa7d4)
>  #define HW_Q11_CTRL_SPARE (0xa7ec)
>  
> -/**
> +/*
>   * Select FOD5 as sync_trigger for Q8 divider.
>   * Transition from logic zero to one
>   * sets trigger to sync Q8 divider.
> @@ -70,7 +70,7 @@
>   */
>  #define Q9_TO_Q8_SYNC_TRIG  BIT(1)
>  
> -/**
> +/*
>   * Enable FOD5 as driver for clock and sync for Q8 divider.
>   * Enable fanout buffer for FOD5.
>   *
> @@ -78,7 +78,7 @@
>   */
>  #define Q9_TO_Q8_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) | BIT(2))
>  
> -/**
> +/*
>   * Select FOD6 as sync_trigger for Q11 divider.
>   * Transition from logic zero to one
>   * sets trigger to sync Q11 divider.
> @@ -87,7 +87,7 @@
>   */
>  #define Q10_TO_Q11_SYNC_TRIG  BIT(1)
>  
> -/**
> +/*
>   * Enable FOD6 as driver for clock and sync for Q11 divider.
>   * Enable fanout buffer for FOD6.
>   *
> 

-- 
Lee Jones [李琼斯]

