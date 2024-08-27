Return-Path: <netdev+bounces-122377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C251960DFF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC9D1C23269
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7211C4EF1;
	Tue, 27 Aug 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxrGJOsE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565C1C4ED8
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769831; cv=none; b=HLyeD+kI4SVwATfy9SFJkCmj850iCj7fEuPczs6uBkRtZRtb4xCe1K0dyrzK2EbS8OWOtE+w05RouL5i2euI49RHctSWiQ29MI9S5lbTLnhpef04obcgwcL8w5Zs18sb8scNWYxyBBsSY2YrWMpA3WFNfggkt3y9ASr/kFH846A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769831; c=relaxed/simple;
	bh=vO3s05HUoi9EfRPSo/wafbjNTc5Q3P/jsT6x1gOhdxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbB3jeePHz3oP4023IeT3YzaXSCuWQhnJRHvIO0n8fqnaQBRyQ7ctKtsQm8Y7jZZ2xsD2zCLyWoRfa0PiWaObnYvD+8gcequrvCdWIOWeowA298vx07cl9CclHNToiouU1bY0j3V17oI1UBGt0k+0DYZfOcYzGGL2N68PGnR4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxrGJOsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA524C61053;
	Tue, 27 Aug 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769830;
	bh=vO3s05HUoi9EfRPSo/wafbjNTc5Q3P/jsT6x1gOhdxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxrGJOsEpx+295/dl09GetEgheM0tBMI1xcKX2CLWNcv9tyP0OwfZPslbjy/UEszC
	 lIXF6fIEnpaQkkv2tW2uE9SdxjHYL4VVqCgaaPEbnLH03Y34YNGhSM+AkDnCD0j8JQ
	 As1an2+enNwHefMG2MZ9oiY/DPL2e8p8Jeg4yo09tHpvJYP5NaCrC0GR/7vQMrEHfL
	 9NINnkw7eR8CQlbLfTAmJQHsEkkWd09AvnDmJMY+5myRTyhVBVOf0e6EULUWymd5iY
	 Jwvet9GBoyRqgrsJoGlGP/W7R45A62CZDiNfjxkVNFOzgQ59/D91Ivqi+TgNJZ+vTL
	 S98XOIsopBr2A==
Date: Tue, 27 Aug 2024 15:43:47 +0100
From: Simon Horman <horms@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: Remove obsoleted declaration for
 mv64340_irq_init
Message-ID: <20240827144347.GG1368797@kernel.org>
References: <20240826032344.4012452-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826032344.4012452-1-cuigaosheng1@huawei.com>

On Mon, Aug 26, 2024 at 11:23:44AM +0800, Gaosheng Cui wrote:
> The mv64340_irq_init() have been removed since
> commit 688b3d720820 ("[MIPS] Delete Ocelot 3 support."), and now
> it is useless, so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Thanks,

I agree that the mv64340_irq_init declaration is dangling since
the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

