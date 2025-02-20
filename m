Return-Path: <netdev+bounces-168209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D03BA3E1B5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1691889CCE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8583C20C028;
	Thu, 20 Feb 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxVln6Az"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964F1FFC6C;
	Thu, 20 Feb 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070715; cv=none; b=MrvRjfd9FrQm6tfVRzH8E6US9cDx6uPw1SaP0lxYmk4VLoj+Xp8Isn3B/Qcm8qA8uTpWogcZ/4g+uxynrEiLU0DA2UPRU09ZaIbOhfJuTCB+hWlxVoyd1JF7bxYFu8W5Q9crfJPTXK43zLLHXzwCl9xMTErNYkpZB6cCxrvRwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070715; c=relaxed/simple;
	bh=h5khnN9rm493Ud45EVpbRXLTxQI1CXCGiYSILzqJP+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMc6h6yjHjCwjqwyBd3i4N3/TGmxVZ7AaVtDF6xzBti5Mkv5uOeGx4fn2vTfYyWN5cxqt8vgNHZmHT6rZ8EZemiax7YGp4jeIfey1lD1q2HafgKLs0LAiXR3k54nm8aPVWugpkQNq2PPM2aEjA8uDX/M8/Qz35psa8cxiql8jXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxVln6Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C901C4CED1;
	Thu, 20 Feb 2025 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070714;
	bh=h5khnN9rm493Ud45EVpbRXLTxQI1CXCGiYSILzqJP+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxVln6Aznb5RQsZQWGqyUZKsy62IVbPzUmyFF5Xv0d2oL8d5lsa9g9ESOwJP4tRE4
	 1YCAM3Z5//VBMBMJevQJbFbtXyQIWcYHBYhDpbupMky7kCtCH1dHZWm+QGNmfamf0D
	 qiuNQZ0YNSBIn5j72WEFslJa9qqgYVg1wtsQ68yTIkxlw26oSIijgbOBfSrDJ1Y/i4
	 Nm93nt4OUpvoAtiaivQwKyxvssaGNqubqcYB3RIMG9YLFiSVivTIFfpZ3sElsb1JdP
	 PGPDmFFFJ9yQblFU7oIgQAdFUgoIT+TGnd1G02N8IcfahwQTNU2uyq1n523rNBPM6m
	 LsvWlBGvPSE0Q==
Date: Thu, 20 Feb 2025 08:58:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Michal
 Simek <michal.simek@amd.com>, Russell King <linux@armlinux.org.uk>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
Message-ID: <20250220085833.476b3f62@kernel.org>
In-Reply-To: <20250217055843.19799-1-nick.hu@sifive.com>
References: <20250217055843.19799-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 13:58:42 +0800 Nick Hu wrote:
> The external PHY will undergo a soft reset twice during the resume process
> when it wake up from suspend. The first reset occurs when the axienet
> driver calls phylink_of_phy_connect(), and the second occurs when
> mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of the
> external PHY does not reinitialize the internal PHY, which causes issues
> with the internal PHY, resulting in the PHY link being down. To prevent
> this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
> function.
> 
> Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and retain established link"")
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

Applied, thanks!

