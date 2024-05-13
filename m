Return-Path: <netdev+bounces-96192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A028C49E7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792BD2855D1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44CD84E1F;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG+SSw5O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD884E16;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641829; cv=none; b=Qqf7HFJ4xGfK6qWngRFB+ZyxNvyA1PByJ6UPfyfZK0PmmG2NUB4gx/YYgbxtrOVGMX5Gwxrwygu3kNAh/A9nqNALSjymcuFqqEwZMsn29sP8W/rzm2Mt7zM3YDo8bOmgycEaowuMsVgf3EuZynTL9YWyE7UEX1Dxm7+5ckM+Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641829; c=relaxed/simple;
	bh=kBfrvkC4Nfu1O/h58EqzJ1eVxKwitgoqpwlJCpxJWvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P+o/c4vfp8iosrH4QJLTVbwJLT7mZBKhgGsV++zWemk3kdHqjJ/cd+ks1OW8iKbWcGD7A5syKHAgKBmzPI8aHm59kt8vRYDjF5DqmUbR+p584ozF1Ul9O7xtyCQym6psT3eO7xQa816LIFpxOWVYJMRg3cZNmtwnILR6V6X7j4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG+SSw5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D708C32782;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641829;
	bh=kBfrvkC4Nfu1O/h58EqzJ1eVxKwitgoqpwlJCpxJWvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZG+SSw5OG70srWUzIOA0vgtSa6kCf/fMJQJFfdRLOgzoUQ/nazPy5FQYpFTelNjo+
	 qQrmmKMyNe9/Vk7Z3yANf/XnWV0ohuljdQmCfdeswoOV77djAdRuZ0V9Ua5twhaY1g
	 cji+KSQ6ax36x2dBNYg0PqEi13VnKud58XotKf3PdCjNQireiRDbz8CDjT5FBBCXTN
	 WaJfn9CcugGboIOoMViBa+XcEyeB3cDgaxXRX5BteZFCze4R6d7BzWmw6IyZJ6/y6F
	 xubAzQW7tYlkicxK/WOtCVv8FLSB3xSc8WBBimXfjOp48vdPuTjTM1544o0I8Tc7fB
	 QUlb9w2hxBk/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19F3FC433F2;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: dsa: microchip: DCB fixes 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564182910.6706.3839750330592512641.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 23:10:29 +0000
References: <20240510053828.2412516-1-o.rempel@pengutronix.de>
In-Reply-To: <20240510053828.2412516-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com, san@skov.dk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 07:38:25 +0200 you wrote:
> This patch series address recommendation to rename IPV to IPM to avoid
> confusion with IPV name used in 802.1Qci PSFP. And restores default "PCP
> only" configuration as source of priorities to avoid possible
> regressions.
> 
> change logs are in separate patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: dsa: microchip: dcb: rename IPV to IPM
    https://git.kernel.org/netdev/net-next/c/2ccb1ac2d018
  - [net-next,v3,2/3] net: dsa: microchip: dcb: add comments for DSCP related functions
    https://git.kernel.org/netdev/net-next/c/593d6ad1ef43
  - [net-next,v3,3/3] net: dsa: microchip: dcb: set default apptrust to PCP only
    https://git.kernel.org/netdev/net-next/c/01e400f29c91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



