Return-Path: <netdev+bounces-226635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F9BA34AF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFDF6252EE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D472DBF52;
	Fri, 26 Sep 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBLw1wsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8532DD5F3;
	Fri, 26 Sep 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881243; cv=none; b=jrRz/v1knIl7gH9lVG4P5/i22YHn59BhORfyM/txVjVDeG54c0snLrna75pblYtsOEwoNZ5cRjSgPOJldS/e8hjYQ6uHkKQwwRblkp78jBYKKcdbDiPLunL+Th63m+gI7L97JCo9uI4OuGWQO9zpCkI1oeNLo6nZdAYTQ424mYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881243; c=relaxed/simple;
	bh=6YieKR4J8Mbw3Ba1vqnkJZjydC2nKoRKIxkjkQBOsi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWpmiR7ViMIg3NZRlp56Jn19xKEhYHBIwLwZM8z24/FEbs5FdO5BpUg9CaC5E/Kh4cbYvn1I0EC6npseFbb5BRFL4xJUvt4DvmQysLPnVAD+lNrTEBIgv2ulGzH5VqhkNFf82BwfQ95zcYXy1lsfkhuRG2kqd64RGmunyAW5mUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBLw1wsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D22C4CEF5;
	Fri, 26 Sep 2025 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758881241;
	bh=6YieKR4J8Mbw3Ba1vqnkJZjydC2nKoRKIxkjkQBOsi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBLw1wsFzxMY1khHmSG+/vURGkS0u3lGnJbzteonxV2jH5WWV+3fsKl1aI5E6VofR
	 4XlGLP7YzuzF9oUnPbgvWdKQMyuXfXcvXi5eOzDB7BOezD5vYrit1JoQTUIQMu832l
	 Aw3Lk5j0/+S2rfTO4I2unfOgJnhYEiEXbeo4BUBYE9KwsI/pi5EJeVLwyH/iAXYIoV
	 E3fsMgAa7rsuOD3BzD+nx3JGYuPToMmn4njTedMVDAgqLdBoM7bozvyIvsSDFLWLG8
	 VwablPukTOB884RYsY/gYqbO2VIuHZRaKZUR9mrMybVlCkqkp1OlnFVJ+sfIvQAHVG
	 tdQn0zHM0XIEg==
Date: Fri, 26 Sep 2025 11:07:16 +0100
From: Simon Horman <horms@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Fix lan8814_config_init
Message-ID: <aNZl1NxC3OAUPS7A@horms.kernel.org>
References: <20250925064702.3906950-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925064702.3906950-1-horatiu.vultur@microchip.com>

On Thu, Sep 25, 2025 at 08:47:02AM +0200, Horatiu Vultur wrote:
> The blamed commit introduced the function lanphy_modify_page_reg which
> as name suggests it, it modifies the registers. In the same commit we
> have started to use this function inside the drivers. The problem is
> that in the function lan8814_config_init we passed the wrong page number
> when disabling the aneg towards host side. We passed extended page number
> 4(LAN8814_PAGE_COMMON_REGS) instead of extended page
> 5(LAN8814_PAGE_PORT_REGS)
> 
> Fixes: a0de636ed7a264 ("net: phy: micrel: Introduce lanphy_modify_page_reg")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> this is targeting net-next and not net because the blamed commit doesn't
> exist on net

Thanks, I agree that the page was changed in the cited commit.
And it seems to me that it wasn't an intentional change.

Reviewed-by: Simon Horman <horms@kernel.org>

