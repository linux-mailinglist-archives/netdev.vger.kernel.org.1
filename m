Return-Path: <netdev+bounces-212863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E02B224C2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F31B63C33
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B312ECD08;
	Tue, 12 Aug 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8b/53IB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F362ECD03;
	Tue, 12 Aug 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995197; cv=none; b=pJDJho1/LNmNwmTowXf7B6eHWSEC4smJlbJotcTVXh+bkM7cLoP0Y9Yb476/Lwbr2hE2tvU+KRs3d2h99OZQocD5BRbHztY6OP3TCJQaPprAfnzrytH0XX9yBmZY0pqRBbtNGdzL2xAb4lMy5POMZB3CzDGU1C4MeVNrirBmm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995197; c=relaxed/simple;
	bh=2SgQnZNyP1tlzw1lJcOt2S6ffYu7OSaBmmpCdXTJHr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4Vz/4H513RPnQTnSDWuLTrC8JVBadyef1flJWbr4XBH3tF/7T/QLWyvliqW0qcQP17GvBpRCCQHvnsM8ihBDrqnQAI5bshen3pv07kYtOvAEeSA7AeLuayljesDVkUP9w5PehuKuETy5XD/S9daogBrgZsSDLvQm5U7fxfJdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8b/53IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA08C4CEF9;
	Tue, 12 Aug 2025 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995197;
	bh=2SgQnZNyP1tlzw1lJcOt2S6ffYu7OSaBmmpCdXTJHr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8b/53IB165Bta6tIw1wOlGBWP4Olyw4+LkPwFlQE9U7tXHJosO2MLoZ/Wb8EgLKl
	 26HHQ7QF0K44mRfrJWc+YOqMIwVjX78XeOnELqChSPsTsusEJL2pLIQDi1v2AYaezL
	 STQ54q+WznpcCWHWj64P1hFH4y3ofMk+uRJHY3my7pN6BtLTu2bypNAZvHPdalt2X0
	 xBOYLFJvT05eHfwECkE5KMG2fz1+gnLbX+0U0wjFlqhmC/AJ0IEh5QtTh6LHvcLyw4
	 a2dAC65ROAGm3oierDJuBy77w+jFn6ucy0F4sTMOB0CYMsJIDMPxEg9xrPeXWM0wrL
	 FEJIguGZSLSTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 51133383BF51;
	Tue, 12 Aug 2025 10:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mdiobus: release reset_gpio in
 mdiobus_unregister_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175499520897.2526251.3672901808475265988.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 10:40:08 +0000
References: <20250807135449.254254-2-csokas.bence@prolan.hu>
In-Reply-To: <20250807135449.254254-2-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: robh@kernel.org, geert+renesas@glider.be, davem@davemloft.net,
 sergei.shtylyov@cogentembedded.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buday.csaba@prolan.hu, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 7 Aug 2025 15:54:49 +0200 you wrote:
> From: Buday Csaba <buday.csaba@prolan.hu>
> 
> reset_gpio is claimed in mdiobus_register_device(), but it is not
> released in mdiobus_unregister_device(). It is instead only
> released when the whole MDIO bus is unregistered.
> When a device uses the reset_gpio property, it becomes impossible
> to unregister it and register it again, because the GPIO remains
> claimed.
> This patch resolves that issue.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mdiobus: release reset_gpio in mdiobus_unregister_device()
    https://git.kernel.org/netdev/net/c/8ea25274ebaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



