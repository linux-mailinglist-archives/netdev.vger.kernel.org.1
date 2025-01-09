Return-Path: <netdev+bounces-156865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA1A08119
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 21:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890AD167834
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379EA18EFD4;
	Thu,  9 Jan 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toKB7s9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A8B677;
	Thu,  9 Jan 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452973; cv=none; b=WQhvEa8CAWlpBRwXakjF3gOHpNRuvwQDqcrJgdVPgNW5oThZMYp0jeoi4tSqTe+FgjIR/KmcwSETapbpzzjv2n6qjLJdMFUe/w9TC9j5Fx2d3vr6EnefOZUz4kARKr8rGGQ8fPS64qOBFIYN7dwm79fBG6F0Ftnh3O9V1xBYLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452973; c=relaxed/simple;
	bh=xhITiGNW0w7CtQVtgtjX4dQRvwS1bcH2km6k9wqjuEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quKGuhv86g/rXInxUZjNOQhOhmCDrUHNcumzg79Zs4Oau9Oz52CaEGdDVezeH4WuF/7rSpZQQUppL5T4AvB8UshCwrZuftXaNu0jlCz4V2eQO6HfZ9CXIw56Xe6AVrJsWb34tFAMwsLUiyEpZ/SR6SuwzFw3tlq02dNdNBjmxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toKB7s9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB8C4CED2;
	Thu,  9 Jan 2025 20:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736452972;
	bh=xhITiGNW0w7CtQVtgtjX4dQRvwS1bcH2km6k9wqjuEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toKB7s9vslTiWOs7O3qMR7VxiCpLqxN8SFSd6itWHt1eJd5C8O2iRMnlmMC1WeJLT
	 oY0tObmN9udf+eKCMx2LBTSmDvVkMr+PwALZH34L8OrVlUvpzvaP3GqUAjy95HBH3q
	 /1CAnFlF4wR+7Z5LrsASoygpEk/WQRkuS6qpNEhA5qcYvqwiXW+l+66BYBqSWBCKrs
	 /m3sXpfJvRBc9Khdahg3UZOgEdDicOsFB4gU0SwjzdkxNO/nNUkKHgPG/bLo515Oqr
	 3esUHxP2cmyl9P8b2nc8Pta5IQJaIknY2Qcb2Z7WwPfxT9J1HAwVjtdZAtI5qA9szy
	 2nbtCqWj1jA+Q==
Date: Thu, 9 Jan 2025 20:02:47 +0000
From: Simon Horman <horms@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: andrew@lunn.ch, arun.ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net] net: phy: Kconfig: Fix error related to undefined
 reference
Message-ID: <20250109200247.GR7706@kernel.org>
References: <20250109121432.12664-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109121432.12664-1-divya.koppera@microchip.com>

On Thu, Jan 09, 2025 at 05:44:32PM +0530, Divya Koppera wrote:
> When microchip_t1_phy is built in and phyptp is module
> facing undefined reference issue. This get fixed when
> microchip_t1_phy made dependent on PTP_1588_CLOCK_OPTIONAL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202501090604.YEoJXCXi-lkp@intel.com
> Fixes: fa51199c5f34 ("net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys")
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>

Hi Divya,

I think that this patch should be targeted at net-next, where
the problem seems to manifest, rather than net where it does not.
Likewise, this patch applies to net-next, but not net.

Also, I think the prefix for the patch should be "net: phy: microchip_t1".
And perhaps the following subject is a bit more descriptive.

	[PATCH net-next] net: phy: microchip_t1: depend on PTP_1588_CLOCK_OPTIONAL

As for the code change itself, it looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

-- 
pw-bot: changes-requested

