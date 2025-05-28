Return-Path: <netdev+bounces-194006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF89AC6C6F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B24F4E47DB
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D12777FE;
	Wed, 28 May 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya26x63T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7531A9B3D
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444620; cv=none; b=GvYXlY/jkwIZRM/ZBs2eT8jh600zuQF46TPhhRHzU5p5Zd36csMpI+riCM6TvKBBAAYhHbCi77dWqC6OuYIta3fq+K4IehU0w+Fjg9vwr3D0glDDkUaLn0P498D9PsmYK8qDBs7V/9b8YlfWZHl3GCHS796HWP+jQN0BYpzzmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444620; c=relaxed/simple;
	bh=cINxRnPIQRvAss7ru+/AoBwsNu4vLI533kOegPG2Ay0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFtjSBl3YcUJQnnD7GfTSWkOAdXYZQdhXpPmwCdROwYaF8yv/eq7Je63QfXm4RCs9FADM4YPUh3iEJRRZlp7ilC+mM2KbR+1jyauR3FpShKuDuWU/6osZtcEEZyNjjf7Ogp5AeFRQ0D5klt9hMzaEMKocR9pCIIebYdrHf9NX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya26x63T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE7CC4CEE3;
	Wed, 28 May 2025 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748444619;
	bh=cINxRnPIQRvAss7ru+/AoBwsNu4vLI533kOegPG2Ay0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ya26x63TEUKLj2PUv5P4jJ/PjYFQHdr8nvnb7tWLPq0grv8PvcursUUqYFxpiZwld
	 yrGxjGw6/sMuM4ZLJTQGIcm2g4vqg+FFvn9f65etKnSexRxnYsj8UsaGPiW2hq6fax
	 INUsVudyHY+tku86E+i7jjdnx9MtPJov6W7v8Mar5xluUP32SrrkQgnB3cI2XuI1B2
	 Xbflr8k/M/7IkrLKuazoaoFXMt77CN5l+zslrt0kdeZ54Ba2HL2Lq6VLa/7xAJ9H00
	 3ovL3QU/KzJ24VVHydRUn4D+pFGfb7Kt8FPLwIMpEYLsMTXWIBP67jXiBHQ1KIk3/i
	 02BgY8Xo4yEaA==
Date: Wed, 28 May 2025 16:03:33 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saikrishnag@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [net v3 PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
Message-ID: <20250528150333.GB1484967@horms.kernel.org>
References: <1748407242-21290-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748407242-21290-1-git-send-email-sbhatta@marvell.com>

On Wed, May 28, 2025 at 10:10:42AM +0530, Subbaraya Sundeep wrote:
> Just because otx2_atomic64_add is using u64 pointer as argument
> all callers has to typecast __iomem void pointers which inturn
> causing sparse warnings. Fix those by changing otx2_atomic64_add
> argument to void pointer.
> 
> Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>  Make otx2_atomic64_add as nop for architectures other than ARM64
>  to fix sparse warnings
> v2:
>  Fixed x86 build error of void pointer dereference reported by
>  kernel test robot

Sorry, I seem to have made some some comments on v2 after v3 was posted.

1) I'm wondering if you considered changing the type of the 2nd parameter
   of otx2_atomic64_add to u64 __iomem * and, correspondingly, the type of
   the local variables updated by this patch. Perhaps that isn't so clean
   for some reason. But if it can be done cleanly it does seem slightly
   nicer to me.

2) I wonder if this is more of a clean-up for net-next (once it re-opens,
   no Fixes tag) than a fix.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

...

> @@ -747,7 +748,11 @@ static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
>  
>  #else
>  #define otx2_write128(lo, hi, addr)		writeq((hi) | (lo), addr)
> -#define otx2_atomic64_add(incr, ptr)		({ *ptr += incr; })
> +
> +static inline u64 otx2_atomic64_add(u64 incr, void __iomem *addr)
> +{
> +	return 0;

Is it intentional that no increment is occurring here,
whereas there was one in the macro version this replaces?

> +}
>  #endif

...

