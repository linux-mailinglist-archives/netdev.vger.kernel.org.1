Return-Path: <netdev+bounces-202849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33EAEF588
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A107AC2FE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7212701D2;
	Tue,  1 Jul 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgL/bBOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F126FDA9;
	Tue,  1 Jul 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366982; cv=none; b=lERmfJXHiG+guPjq+SorfP6BqWoP/qeaL7hJPvwVZCpVXkZJjdeI5yZuyybCKrljVxzRD45EYmSmG1BWe8x6KXuUO0VzIdxUjwGjVGgxF07rgNspP+H3sbcNzNagZ50BNWXj+eHJOKRobVjJAnWzrcIcZZl+lusw/Mehob4lPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366982; c=relaxed/simple;
	bh=K72GTE7UBORgAxUCCriBJHYOJ+/xnWxxgAX8Kp6b374=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gVZhdsxBxkEBRj5roUDU8REPqNvknL2C722Ax8oszaijY6pe3WJCsHPQZnFqd6TLxU2+uUvb2E795dUKObqb3+vp58OzEU2ikcfAueBb2/1AizaE8dl1fpFj1JMU9Fcds7Ybbm0akcK/M8wGbCR1br1pFqSF62C4oqSLCdc5kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgL/bBOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38BDC4CEEB;
	Tue,  1 Jul 2025 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751366981;
	bh=K72GTE7UBORgAxUCCriBJHYOJ+/xnWxxgAX8Kp6b374=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dgL/bBObBmCeQLd6NcVrjT7ixPxxPTuxFeUsg3mSuYSdLEUbLk/hEhRUtrgVsaHb6
	 prYMs6cUfcm1yLA3dvfEDSVqEEBgHJz26/HzlPLka9191yt7fClSQVhmqxFQqpk/zJ
	 nZgVqAi9SQfvO3j5/tJtj53uffUFg3sVL2Y5PF9wO5uRYMvUlYDs4RDvWdoHK4K1y9
	 Cz3g+vF9QoX+BmUJKlpxKKHy14VFcym+driJN9fqxNIFFHpL7jb+hOwjIuWUlv96Ux
	 N9KVBMHMVCAngjuSUSCaQ3caSA8U7YB6b8ctP1lG/sh6zmJ2ylQbgoi8aymM5y8OF8
	 s61WIn15XIzJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7B38111CE;
	Tue,  1 Jul 2025 10:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: fix possible NULL
 pointer
 dereference in lan78xx_phy_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175136700676.4114988.13242683891063263726.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 10:50:06 +0000
References: <20250626103731.3986545-1-o.rempel@pengutronix.de>
In-Reply-To: <20250626103731.3986545-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 rmk+kernel@armlinux.org.uk, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, dan.carpenter@linaro.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org,
 maxime.chevallier@bootlin.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Jun 2025 12:37:31 +0200 you wrote:
> If no PHY device is found (e.g., for LAN7801 in fixed-link mode),
> lan78xx_phy_init() may proceed to dereference a NULL phydev pointer,
> leading to a crash.
> 
> Update the logic to perform MAC configuration first, then check for the presence
> of a PHY. For the fixed-link case, set up the fixed link and return early,
> bypassing any code that assumes a valid phydev pointer.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: usb: lan78xx: fix possible NULL pointer dereference in lan78xx_phy_init()
    https://git.kernel.org/netdev/net-next/c/c22f056e49d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



