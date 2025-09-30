Return-Path: <netdev+bounces-227287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F6BABF1C
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B693A17FD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28482D2390;
	Tue, 30 Sep 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWKt/7Zm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB252BE02D;
	Tue, 30 Sep 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219215; cv=none; b=bJzcWp7i73ZhSx724ygdSxiJyVl2/3TxkrSOpO2Oif3yQ3+Zacn9ghEKAaBaHub6U3PCDClY6+sSYWsD0KTMxfR+UX3N5sqkPsvSYFDed/+tOpTJiAoGhxCB7cFqxwhHsMRq5Btv5RlVSO6HZuk0RSRVyeLGa0ikU/ePp286mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219215; c=relaxed/simple;
	bh=zG9qfsVVo81au4JBV44ET3CSYRwfxfbh6yvOOusU0BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrxljKlZj72AlEa0+NL40ngx9yfW4F5THjqvDanieE+6QJoINoNns0CJB5La9ci4bCmJpycvLTt93iP1u7Kk9SjYTMEbUFR6juhPdz2pKcr4lqB+/K4mregfOnrLAVYIDHPYnNu4tTZlCVW8BXJumyusxCXKMI+Z9lYTdWZj4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWKt/7Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E2AC4CEF0;
	Tue, 30 Sep 2025 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759219213;
	bh=zG9qfsVVo81au4JBV44ET3CSYRwfxfbh6yvOOusU0BM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jWKt/7ZmeH2xcwe6K2lJnWu6GKxrzEXRAfLHoPhgOzRVweVnec8JujNIoLgQTf2+/
	 8Qqwz1uwI1K1JWEcjlrKv4YiA2Ex0dmkswmOyBHWhG8Gha9o2hyI4A16b4CxbIBDEO
	 TozIF/vP6KfrZi+zkiKLXQpOJ/DcrHF4gKFX0Qu0Z09cOiS5iWOXzpipYt6md+ELXF
	 U0KVDhVO34Fs95V2eRwhntUATxRxi0AcIRyaNKGbSqNgXw/K9odSKDQ/s1gAJvBnNK
	 4ORS4hrp6FZ0Rw3YRDuEwFCEM7MBAuQfAxjwI8tS16fGivlKh/g3MU7MYICf7qA/gH
	 yD01tbkNGKzzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAC39D0C1A;
	Tue, 30 Sep 2025 08:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 1/1] Documentation: net: add flow control
 guide
 and document ethtool API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175921920651.1883014.4986159833879484611.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 08:00:06 +0000
References: <20250924120241.724850-1-o.rempel@pengutronix.de>
In-Reply-To: <20250924120241.724850-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, f.fainelli@gmail.com, maxime.chevallier@bootlin.com,
 kory.maincent@bootlin.com, lukma@denx.de, corbet@lwn.net,
 donald.hunter@gmail.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 vladimir.oltean@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux@armlinux.org.uk,
 Divya.Koppera@microchip.com, sd@queasysnail.net, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 Sep 2025 14:02:41 +0200 you wrote:
> Introduce a new document, flow_control.rst, to provide a comprehensive
> guide on Ethernet Flow Control in Linux. The guide explains how flow
> control works, how autonegotiation resolves pause capabilities, and how
> to configure it using ethtool and Netlink.
> 
> In parallel, document the pause and pause-stat attributes in the
> ethtool.yaml netlink spec. This enables the ynl tool to generate
> kernel-doc comments for the corresponding enums in the UAPI header,
> making the C interface self-documenting.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/1] Documentation: net: add flow control guide and document ethtool API
    https://git.kernel.org/netdev/net-next/c/7bd80ed89d72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



