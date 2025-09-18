Return-Path: <netdev+bounces-224643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F4B874A4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC913AC103
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAD301492;
	Thu, 18 Sep 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ1yXKCX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF32FFDCA;
	Thu, 18 Sep 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235809; cv=none; b=YLrS+9Dp3i1FkSVevxFgLPEh68aEYFBuaFFq4hLPyK+7JR0wAZ7LBsviO86ey470nPfkzjKSTbwvoatfPYDMOEvplW8iMVqH1uxWqo6ZJ9Bzq3dTNmg8rHqmVK6pzADFAN7PH/PB35DODIAcycxMo5XlCW1c36SBrMRBQ2g6JC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235809; c=relaxed/simple;
	bh=O88eiwU36K4o19101rI3QeMamB5WmmKF7Jx+0MWAW/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lbFhIOl/ZjMH0L4CXBHLR10NFDxTJrKOa/Lr1sBdgRQc3slNjLg2FCLkSHtejqSFB9FnFnykd0cfU4sWmn9KxLjqblxGJceccHpOTPM65OLILx+TmDYPfiEVoumbNmeZPU7oqzUS18NW8xJUgcBsrPhZbcsGhohjybSp1U+EqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ1yXKCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC959C4CEE7;
	Thu, 18 Sep 2025 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758235808;
	bh=O88eiwU36K4o19101rI3QeMamB5WmmKF7Jx+0MWAW/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dQ1yXKCXTojgSystid/o3hPHYP1to+/cIgNQbyXwlHOiBesdeI+BWGFxgdKlQ427D
	 YenZaY0RU3eqKtsYUH9To3ONrW0WW3v5dv8BsyYANOeZzdxfNjtd5WyQ8StRBiePW3
	 rTPI3Rt3jz4DW71XH8Uppqf2HmloSg8ks+LmGWFrlfDXd658WfYSld4/Av50+4LCD8
	 8BAom2dXyVfBRt1lQOjjybtb3ESsY/VVHz2jA7/FqiYZMKjzlr3/w+Gq2wFoBASOz6
	 AKJILpk+HtpifcpRSll05H7qByUO40b07cfTJx04gvvzAkUhITZu3lxGKBxjhAyliH
	 YgJldYxA4wgZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3239D0C20;
	Thu, 18 Sep 2025 22:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] net: phy: clear link parameters on admin
 link
 down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823580849.2978091.6744082824236788481.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 22:50:08 +0000
References: <20250917094751.2101285-1-o.rempel@pengutronix.de>
In-Reply-To: <20250917094751.2101285-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 11:47:51 +0200 you wrote:
> When a PHY is halted (e.g. `ip link set dev lan2 down`), several
> fields in struct phy_device may still reflect the last active
> connection. This leads to ethtool showing stale values even though
> the link is down.
> 
> Reset selected fields in _phy_state_machine() when transitioning
> to PHY_HALTED and the link was previously up:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] net: phy: clear link parameters on admin link down
    https://git.kernel.org/netdev/net-next/c/60f887b1290b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



