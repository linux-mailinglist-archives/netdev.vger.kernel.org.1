Return-Path: <netdev+bounces-93456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BC08BBDFD
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442351F2186A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020C83CDA;
	Sat,  4 May 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e06MpcWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5B1BF3F;
	Sat,  4 May 2024 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714853863; cv=none; b=SlkW6A8i5R+RcpU66miT/3GKffGj2V8LqrUoV/NzbJmw/35w0P1FFt2nckLPgSFglMGdzcPhSTU1Jo3t2jvSJVucniZmNgv258Ft9w4o+99NLiVkxHmaTqjkSyAg9ry0cNLxliEu0WFkLLTpWjZL6Ud3/VdMtnaMFaVzmyTOCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714853863; c=relaxed/simple;
	bh=S7FTYcnhSj3UJkYyuYb6sPZpihdcm5gOjX8Oss6SzmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7l0cE1IrzqitrXRWGNShmiwAP31/HsNhO0SfqwN+wWV6frKdohWtW9haJtyHMPMD6YsxV5L4lF1gtvjgHXHtz1Bentray11+Altw+8VXFEfp5WvnL+me1uAcj35tmhgP7q2CorQEPvMDrLLSMFJTyE6UJ6kZK36FBFcR+P+ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e06MpcWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7760C072AA;
	Sat,  4 May 2024 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714853862;
	bh=S7FTYcnhSj3UJkYyuYb6sPZpihdcm5gOjX8Oss6SzmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e06MpcWjt3OAfVFB3793pMU6WPfPlcYWFM1pxTTwLY9Y2qRO8ySfu/24EaSkxznJ+
	 lYgTOqG1nFXqvQc2VREARpFu8juJhNd6EB4RW4S6lGGyMEWnp1ahUcWqriWvPe2j+a
	 EVJymBBx1EQk8SkfSWJ7IfmmGxk9/LRnJV7KS/ORL1IznmzHHOQirPsPsCKCG2voU0
	 YAZTfpWRo5E2dOK56X7ymcpNr03Akra4rV9Hf4eLj+3uNLavNmtrQbYWbBdG/BKDZ/
	 rBlcsSTp7eN/N6dk+KWCX9M11mn1/TlVUCavVRZ0vuh4KsBpQPwUhoD+EEouCHd6yV
	 li++2WaYZw4Zg==
Date: Sat, 4 May 2024 21:16:08 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jgg@nvidia.com,
	leonro@nvidia.com, Andrew Morton <akpm@linux-foundation.org>,
	Tal Gilboa <talgi@nvidia.com>,
	"open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] lib: Allow for the DIM library to be modular
Message-ID: <20240504201608.GJ2279@kernel.org>
References: <20240503002540.7154-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503002540.7154-1-florian.fainelli@broadcom.com>

On Thu, May 02, 2024 at 05:25:40PM -0700, Florian Fainelli wrote:
> Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
> module. This is particularly useful in an Android GKI (Google Kernel
> Image) configuration where everything is built as a module, including
> Ethernet controller drivers. Having to build DIMLIB into the kernel
> image with potentially no user is wasteful.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  lib/Kconfig      | 2 +-
>  lib/dim/Makefile | 4 ++--
>  lib/dim/dim.c    | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4557bb8a5256..d33a268bc256 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -628,7 +628,7 @@ config SIGNATURE
>  	  Implementation is done using GnuPG MPI library
>  
>  config DIMLIB
> -	bool
> +	tristate
>  	help
>  	  Dynamic Interrupt Moderation library.
>  	  Implements an algorithm for dynamically changing CQ moderation values
> diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> index 1d6858a108cb..c4cc4026c451 100644
> --- a/lib/dim/Makefile
> +++ b/lib/dim/Makefile
> @@ -2,6 +2,6 @@
>  # DIM Dynamic Interrupt Moderation library
>  #
>  
> -obj-$(CONFIG_DIMLIB) += dim.o
> +obj-$(CONFIG_DIMLIB) += dimlib.o
>  
> -dim-y := dim.o net_dim.o rdma_dim.o
> +dimlib-objs := dim.o net_dim.o rdma_dim.o
> diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> index e89aaf07bde5..c50e5b4dc46e 100644
> --- a/lib/dim/dim.c
> +++ b/lib/dim/dim.c
> @@ -82,3 +82,5 @@ bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
>  	return true;
>  }
>  EXPORT_SYMBOL(dim_calc_stats);
> +
> +MODULE_LICENSE("Dual BSD/GPL");

nit: If we follow this route then MODULE_DESCRIPTION should be added too,
     right?

