Return-Path: <netdev+bounces-144176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07579C5E89
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A545D281BD9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA5212D37;
	Tue, 12 Nov 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOW/S0Zx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50371FC7C9;
	Tue, 12 Nov 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431299; cv=none; b=HymFZHwoyRaEJdMDQcjEf0u7vkcK57hu4i7Pn4FowFo0xsnIzB65iZW4Nk0uCB5ELEMQMQ0BhNz+OY5jdTSSVRG/5r1h28VPT469kkHI4tILhYOlP4IJmFgTUXgzhzvRKcIsDUjz5jn1NNztkNpHlbnjEct3hEKG6pauUz64Icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431299; c=relaxed/simple;
	bh=dwmNeo+TpPs5k1Z5HQ0kcwDKmihQfyb2xjMEnkttJAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkK4/OXS73IgUr62mVmc8vBpPkkX7VrCBVqeyRE27ogA07uy/QloRSBGXIi8Ky3s2UIp1L3bvQNnaLEhTomtIZshgb0Kz0B3LpW6MexpADpCbLXOptO3ErF/UdjX0tR6DliGaIwrpsbGgzahAryzU8b/QN+z8jEeSnxrXkyoWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOW/S0Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF56C4CECD;
	Tue, 12 Nov 2024 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731431298;
	bh=dwmNeo+TpPs5k1Z5HQ0kcwDKmihQfyb2xjMEnkttJAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOW/S0Zx0MvsLGPcJohR/ODEXmbpbfxHkd/sFs8DEb0UOAd5bMm2XzGLijA8NtnDO
	 It77jEjw8Wtov+aAsOh8eDjWzZ5ZSrD/YS4PkGi3+5b/FHiYQuRWLYafeDtnp6/Qhi
	 esDVI28op8Lp5Au65/PxJCeBv1G6KZZd9bQ4jPSU592ktYmTVaQ1/W6Senq3LiW+Cr
	 GZFPFxqL4PGQO0DYel2nsf6bS/8mUHEhJf5u+f2/mY3VE7+riSPCG26XiyjVQ82ryd
	 98nx2wNpz+tWudbE67qKz8VhP4ZLP8arGXdXdu6BzTS7vV+7cUSySU9AbtbdXVtAZA
	 5Bn3tJZ7hJGpg==
Date: Tue, 12 Nov 2024 17:08:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	salil.mehta@huawei.com, liuyonglong@huawei.com,
	wangpeiyang1@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net 0/7] There are some bugfix for the HNS3
 ethernet driver
Message-ID: <20241112170813.GS4507@kernel.org>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107133023.3813095-1-shaojijie@huawei.com>

On Thu, Nov 07, 2024 at 09:30:16PM +0800, Jijie Shao wrote:
> There's a series of bugfix that's been accepted:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=d80a3091308491455b6501b1c4b68698c4a7cd24
> 
> However, The series is making the driver poke into IOMMU internals instead of
> implementing appropriate IOMMU workarounds. After discussion, the series was reverted:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568
> 
> But only two patches are related to the IOMMU.
> Other patches involve only the modification of the driver.
> This series resends other patches.

Hi Jijie Shao,

Cover letters for patch-sets for Networking do make it into git history,
e.g. This cover letter [1] became this commit [2]. So please consider a
subject that will be more meaningful there.

e.g. [PATCH net v2 0/7] net: hns3: implement IOMMU workarounds

Thanks!

[1] [PATCH net v2 0/3] virtio/vsock: Fix memory leaks
    https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
[2] 20bbe5b80249 ("Merge branch 'virtio-vsock-fix-memory-leaks'")
    https://git.kernel.org/netdev/net/c/20bbe5b80249

...

