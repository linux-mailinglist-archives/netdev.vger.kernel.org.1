Return-Path: <netdev+bounces-121713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A995E2A3
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 10:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDCAB217E6
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471E78283;
	Sun, 25 Aug 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKaKM3FY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9D77F13;
	Sun, 25 Aug 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573905; cv=none; b=NwfFmEu4e6vi+Y+lkHajF3UT8rEGut1WanOk5tVY+Mi1WQL6e2ncdcm/kWvgDrWN4SiiuQuAELV78P+vOgG6iWz2ZjltAY8RwE9ZsF6ntyMa6RHpJ1DoPNKn5qkUHU/OfJcIcthrCHmOWnfAsoJef1q8rudL0sAmhWg8jTJOmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573905; c=relaxed/simple;
	bh=aqz2VzjRBEP658PtcVmevB9Fzlw5r+BFBMq62WEp0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJliHS/eNi9ic4znuyYwFoUWfjom8E1zQpJwkyP/cg31TSUU/cMmT5Ci/nTGHg8DnD4ixlS521EiGopk3RE9/kH2IFGlhRamsn7EIOKTgwBMvMCFLd+xRpbndciMEjmLxe9fjcg98PXhXwkODb6OmaGGZeqcT7LESt8F6q3pI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKaKM3FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F58BC4AF0E;
	Sun, 25 Aug 2024 08:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724573903;
	bh=aqz2VzjRBEP658PtcVmevB9Fzlw5r+BFBMq62WEp0mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKaKM3FYTntOGynyrpvPrsCvozeawOw/grOpS/u9UwAcN5aR5NY6VHz6uhkID6yq3
	 0QsHlB8sccRE2w38+tQaWTj7vPMhKJRn85qvZeSr/3iQHw6c7tZsAfsFL6rt5k2kJd
	 T1CYBcEA3Xrbq6Pa9Ckaioec8zo80XIPyHB6WmZoT/wWAq749KQiWEBLMqoXoFz3HG
	 ySCjKwus4kSmK9C5tU4uSBeE/Ft2eLOPUu3zLJZRXjctWgEtgV2tPE6zN+qbTlUpQe
	 iQjRmkjlZMpwh5xT7dpEb/z1Jwxw7N3IzxJc3g/xvyVf8QrLvXMVRbrnaTbx7UqGHv
	 W/hYeYZ3PfuVg==
Date: Sun, 25 Aug 2024 09:18:20 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: liquidio: Remove unused declarations
Message-ID: <20240825081820.GW2164@kernel.org>
References: <20240824083107.3639602-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824083107.3639602-1-yuehaibing@huawei.com>

On Sat, Aug 24, 2024 at 04:31:07PM +0800, Yue Haibing wrote:
> Commit da15c78b5664 ("liquidio CN23XX: VF register access") declared
> cn23xx_dump_vf_initialized_regs() but never implemented it.
> 
> octeon_dump_soft_command() is never implemented and used since introduction in
> commit 35878618c92d ("liquidio: Added delayed work for periodically updating
> the link statistics.").
> 
> And finally, a few other declarations were never implenmented since introduction
> in commit f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks, I looked over the git history of this driver
and agree with the analysis above.

Reviewed-by: Simon Horman <horms@kernel.org>

