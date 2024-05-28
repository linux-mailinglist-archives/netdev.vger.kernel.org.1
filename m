Return-Path: <netdev+bounces-98581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2D8D1D41
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5171C21EA3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0316E86E;
	Tue, 28 May 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EirubJOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A1131E3C;
	Tue, 28 May 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903633; cv=none; b=jaUd9pBcYkAUQkuquo42blIqNRrOW3C8tKcEgLISaySmHUNeiyX/pfzawEAIqK6Q6gaTAk9xYnZOSkvjCN+luxLOwg2Ok3HsrVQXmpUcGFQkc78U8OnkSU5cSkIHkdNPvo7/a9qQC3M7VottHTMlmKHy2Xk0YjLIqumQycpf3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903633; c=relaxed/simple;
	bh=g3PZDtcn7m2wLPlmZwHCmUl5EUebXo1+SaotgCribQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tf+Fyeb7hAD4Tq+hQ5fLV9jvMc3ZgeRSyqeHGJAj9M0kT/J6Ugn7l/1PFqNYmUiYroVQDpVwCS/kBPqP/7Lgvufr9HzxT4DGuRTloOF+uWwP1doC2WHta/lG/VCCC3MCCBnbA++ZbtiU7sUcdUtKWQw/XDz87ujfW6DB2OtK0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EirubJOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A878C32786;
	Tue, 28 May 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903630;
	bh=g3PZDtcn7m2wLPlmZwHCmUl5EUebXo1+SaotgCribQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EirubJOS9d31fOjcD6cbEpXxvWlKSvYI4ecN9OIvR/bF8TGHNnj4tpCdbpVMz0R4T
	 8L8BYyIwIpMp6z8+aFQ95FqJBFaPJYPfHZiG5QBAJRCkFyOtBmkgLgaqk+RgK5eqcc
	 elT/mrxQdtpw2E8lbz/aupCuzKIeiHygwmA1eV6tPnHrVxFaXFc9t8r0aIdZBTWA3+
	 PW+ifr3ooqG4wIgak5dBCvgbZVPt/stzZQa/FNVOnSnfdQjz6+kwY7cc7daAZ2FkMv
	 sGpZ8Pn/SbrTw2dcXsdPi7R9oodForX/3oK7Xu7/mIQR0l6hNrWu+cgpjx1a2MtYGM
	 gCmebZBzgcuDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74C1CCF21F3;
	Tue, 28 May 2024 13:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix start counter for ft1
 filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171690363047.22539.6832314055763721476.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 13:40:30 +0000
References: <20240527063015.263748-1-danishanwar@ti.com>
In-Reply-To: <20240527063015.263748-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: diogo.ivo@siemens.com, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org, f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 May 2024 12:00:15 +0530 you wrote:
> The start counter for FT1 filter is wrongly set to 0 in the driver.
> FT1 is used for source address violation (SAV) check and source address
> starts at Byte 6 not Byte 0. Fix this by changing start counter to
> ETH_ALEN in icssg_ft1_set_mac_addr().
> 
> Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg-prueth: Fix start counter for ft1 filter
    https://git.kernel.org/netdev/net/c/56a5cf538c3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



