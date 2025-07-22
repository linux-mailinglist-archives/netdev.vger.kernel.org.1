Return-Path: <netdev+bounces-208742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29DDB0CEE2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563AB6C786D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8019ABDE;
	Tue, 22 Jul 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANvOkAkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A71624C0;
	Tue, 22 Jul 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145393; cv=none; b=Ij/azCKbDHjz5oSyy94ouipUpJATZqDXFgWf14/mOgiUTB7Zwl25P1V57oLi2YkamC3CDSu2Px3ebrnCVeGjJaMMlc3Ei9H9M0Z5hXwCcORDovoPBBDSH71379TSVGGVZH1xt4801stZUz9F6crFbxAczubkOQ7741qduJmb4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145393; c=relaxed/simple;
	bh=Rintk8p+QWVFS44yRmEWgxkYxlizz2pX+UPGMDe+X/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VcrqlcOlca9P5hyViDYVkBO88oPi0A7v4pktbB7tVBL7vwhSxNmb4sGDy6sjvW7g4GfqQ+0xxT6gBjzWOia+wF3aSEHaOujxYwR86CuLjqcV5EkrmSit9oPkfghHq6yqWCUMLx9FhyD86flhA/X9kmMTMkuU54wk0Z62WtU+K/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANvOkAkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD8BC4CEED;
	Tue, 22 Jul 2025 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753145393;
	bh=Rintk8p+QWVFS44yRmEWgxkYxlizz2pX+UPGMDe+X/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ANvOkAkhNhGB8Eek/OpGmmeqnewdROAmxERz1lzyQi0NguhRLaeMFz6pm+jqgJark
	 +ZF6LH6xZTkOBbcqk8eZVk/34nrmFB6OcJmOlgDhFJBQGJqh+5ZeNZprZAHXMAzk7O
	 jBC+Czo2zlUDnI0w4OTBCStSshb8nrhZyZNNTecydsD95ux2ZUGpmR8KhmNeUbdxWE
	 hDuyqlSCuK5JnodlQisIqeRRa6i71P/GuYNVhB+sPQDavkF5rkwu8IvIJbETV/fcro
	 85mFdsJr5RN2lPq143UBl+yy0oJAwhSTmDZv7Y0fXys68bqu9aiAZqMSLQ6nG7rlNq
	 XgY8fT6B3+8ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB8383B267;
	Tue, 22 Jul 2025 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: usb: smsc95xx: add support for
 ethtool
 pause parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314541150.247888.9267793850029224418.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:50:11 +0000
References: <20250718075157.297923-1-o.rempel@pengutronix.de>
In-Reply-To: <20250718075157.297923-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: steve.glendinning@shawell.net, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Jul 2025 09:51:56 +0200 you wrote:
> Implement ethtool .get_pauseparam and .set_pauseparam handlers for
> configuring flow control on smsc95xx. The driver now supports enabling
> or disabling transmit and receive pause frames, with or without
> autonegotiation. Pause settings are applied during link-up based on
> current PHY state and user configuration.
> 
> Previously, the driver used phy_get_pause() during link-up handling,
> but lacked initialization and an ethtool interface to configure pause
> modes. As a result, flow control support was effectively non-functional.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: usb: smsc95xx: add support for ethtool pause parameters
    https://git.kernel.org/netdev/net-next/c/c521b8c9f212

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



