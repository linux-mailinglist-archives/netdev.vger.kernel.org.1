Return-Path: <netdev+bounces-177515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E86A706A6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0884B3A8CFA
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E925D8E8;
	Tue, 25 Mar 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXjSTghr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB925D209;
	Tue, 25 Mar 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919603; cv=none; b=Y4fIx8bJmN91aEsidC9me2bKdhdkZ39MV+KVFlkNXMjw3XPYhx58nV1ElxUSuelHY5Ue9Eqyz3nxDG7GvWEvk6CJQ1WuFDTOmOcDgOV9F/ALIP9+r7oUR5OfAYCNEMFjoVuBogAX1KAELnG4LTHTLZzrrJf60mJaiNUqGUYjNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919603; c=relaxed/simple;
	bh=vxNsvgah3Tm83JRm6jzxLyV5ZdTn3MR3BvLqQ84PSVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eILW4lFf2X94IH76yxVYNlTzU1i3812kIf9CgoxLtA3dyWDmXoSbIl12r17cr/Nrlxtd7CLe9TRWSVfKgDls9hs5am1XAwMQIMlKPNVKtRfyrgKb7XaJEJPM/7mai3AMgx1oHp4yv/a4liPBkvKQk4CIYH8ubmuuuBb+k1S5UQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXjSTghr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D21C4CEEE;
	Tue, 25 Mar 2025 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919602;
	bh=vxNsvgah3Tm83JRm6jzxLyV5ZdTn3MR3BvLqQ84PSVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXjSTghriEanB4dmjfNUiDkPRdB/TCcVUUz+as7FQFAoYjQ8xhxf1taKcXzKCb1yN
	 gU9n7eJU0LhItRHzWt30di3PqRThkgGSA5j/WqaiXuFY0zUPny8kF5+QCFwno1xpg6
	 K9fHEjbBqkGyHMWH2E3j7xu8RgeUs2ont3uthuRhZY7IsxEJP4bccMdmRHAbMtEzVh
	 6IWHcGePvGI2y6Q42DouC5+Jzy3/roAh7o249cKFi0hxmsmpjmVZIZJ5YTGY75Rkrc
	 i6TqyViD3SWUpWZaGLSDyKuBYAOQdmTIXZf4KrohuxcwqN/d/KkpLV7k/7adEXTwXf
	 CT0oSq77BV28A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB286380CFE7;
	Tue, 25 Mar 2025 16:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2]  net: phy: sfp: Add single-byte SMBus SFP
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291963875.636425.6944279499482792334.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 16:20:38 +0000
References: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, f.fainelli@gmail.com,
 kory.maincent@bootlin.com, horms@kernel.org, romain.gantois@bootlin.com,
 atenart@kernel.org, kabel@kernel.org, sean.anderson@linux.dev, bjorn@mork.no

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Mar 2025 08:57:43 +0100 you wrote:
> Hello everyone,
> 
> This is V4 for the single-byte SMBus support for SFP cages as well as
> embedded PHYs accessed over mdio-i2c.
> 
> V4: Cosmetic cleanups reported by Paolo :
>  - xmas tree in patch 1
>  - Extra parenthesis in patch 2
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: phy: sfp: Add support for SMBus module access
    https://git.kernel.org/netdev/net-next/c/7662abf4db94
  - [net-next,v4,2/2] net: mdio: mdio-i2c: Add support for single-byte SMBus operations
    https://git.kernel.org/netdev/net-next/c/d4bd3aca33c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



