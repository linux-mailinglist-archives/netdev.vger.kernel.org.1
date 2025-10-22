Return-Path: <netdev+bounces-231487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA55ABF9990
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE2518C5765
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAD1E5213;
	Wed, 22 Oct 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbwlh1kF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB71DE3C7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096022; cv=none; b=rt5swygtyNJ1P5pso/tMxvA2dM7x6JnPeeVnquh86fSHGp4rhPStbN7ik5scCL1dk9afP9JAJPzLVcjHLpjZsfkQn4lmP6ESaLOyUtxRteWJqErEQ89e1rlXWlKFrANzpnYwxlwK0A06Emcpn0pI6sx6nxTWqipPE+ffIIhZoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096022; c=relaxed/simple;
	bh=pIDgtzEwzPd1YTTu7Y5hAjbvG9JdtLxyDVr5w0oGZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsTrleBvVs//Rhi5RYDrFrnutfgm/YpqC9SO4m7kHbar92kr6NlDkoFabsPuJbYexCIOooPzTRh8QhrZ9uVgAXiSrqfpMfVkbI/XTY0qpuXMihiobQhKQGUZET4299C8x2ollji0gQMKJKfGcK9VrQzXdGtzbHynJmq7RO9fIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbwlh1kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19ADC4CEF1;
	Wed, 22 Oct 2025 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761096022;
	bh=pIDgtzEwzPd1YTTu7Y5hAjbvG9JdtLxyDVr5w0oGZJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbwlh1kFnwz48KYp1LnlAH+jSo+fV5lgUsK8t7FSth31AnRVfr5PZPY+8rAE4TcQQ
	 P/InRvtew0eZ7vCkVt7/RtscjVX+MXNTNPM0ty3cjW76qzUHUjqx4TcntfM1QS4glO
	 UdEqundr30Q14jGZG0H9OfLxqzf1AvJ5Bp30ytB/BsQ744GORJjai7NV7LnkAOM2h7
	 HWtQd1olyMPsYbv9Nnm/qSOB6LP8OOFIejo4mi5XUzatG3a/0Qq1hvuRigEJph+JH/
	 BVQXlQ9QvSCoAtLYSiiqlUUuRx7A2QQUvFIewpZLKyloDIOKsvy26Yud0ymR3KHE6Q
	 odiMgglRM7hTw==
Date: Tue, 21 Oct 2025 18:20:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, David Miller <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
Message-ID: <20251021182021.15223c1e@kernel.org>
In-Reply-To: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 22:11:44 +0200 Heiner Kallweit wrote:
> In few places a 100FD fixed PHY is used. Create a helper so that users
> don't have to define the struct fixed_phy_status. First user is the
> dsa loop driver. A follow-up series will remove the usage of
> fixed_phy_add() from bcm47xx and coldfire/m5272, then this helper
> will be used too.

Not knowing the area too well it looks like struct fixed_phy_status
is an argument struct to make it easier to add / pass thru extra
attrs without having to modify all the callers. This series goes
in the opposite direction trying to make the callers not have to
declare the argument struct.

When reading the code it may also be easier to graps the code if 
the definition is local vs having to look at fixed_phy_register_100fd()
Granted the function name kinda makes it obvious what it does.

Lastly: 19 insertions(+), 6 deletions(-)

So the improvement here is not immediately obvious to me.
Maybe it'd be easier to appreciate this series if it was in one
piece with what you mentioned as a follow up?

