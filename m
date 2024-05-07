Return-Path: <netdev+bounces-94282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B38BEFC9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10F42866DD
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33967D3F1;
	Tue,  7 May 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiB1X+wH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3678C7B;
	Tue,  7 May 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121031; cv=none; b=Pu39XU3a4jiwICvAKRU6LdDvEoyWUqTNuZAPSdjjkDGLrl82DwhLkCzdMJjwmssNu4wwUDCEEOlES6Igw5vTJdoiULa4LkTnigx59/EIMMx9jD2tq4rX5M1Kyqmg9YIo71VLDIpNGZifQ/UrxwHjYJ6xkqU0jnq7aRi5zNki10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121031; c=relaxed/simple;
	bh=y+fWU2hleFYspt3ddxjI88RKw/5aLuy6zTfsmA3wggw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZl4P8quAgX058LjxuOhhURh4dD8Dlqer3lA5oykM5c13mKRj2iw6toYIYu01RuBmYHVPZo6kibbk2JiFwa/07d6JiEv7TWdaA+64/WoYAxPHLJ0tLQSDkud/pnOeOz2yOsWQk5kkky+2sY0PVhnylxhaekkmNpCN9hrY8Po+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiB1X+wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB8BC4AF17;
	Tue,  7 May 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715121029;
	bh=y+fWU2hleFYspt3ddxjI88RKw/5aLuy6zTfsmA3wggw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EiB1X+wHlKFEGqrK937HgQlSMwaK1xYqi+avxaSfT7Kpg3jV30+Jsxhw8rE9rJf7y
	 KAE3zir4/mNsqqrhdfjUzCm+RFJB3VTfjAGIMX8po+osL3sStsm1AQEwqZl3F0TNEf
	 Bn95es5tlFuVZtYXVpA8OYcxyuOqbdZRPEnY18WsMljamlkhdU9xqJjGkwMyHJQUG6
	 MzyNfb9NHfAIzX05xg6GdeC2OR7YXrrS8ln05w4gptEMk2QwVLvLbQ6Z+r9d7/b8EC
	 lfI4vZxHPZgx60qmVKvc9lTvN5mCfauZUe29xjk8gEYFvhFnPnAK+6oN9U2jFtPhxR
	 Z0Ks7Ev0IAmQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2C8CC43614;
	Tue,  7 May 2024 22:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: phy: marvell: constify marvell_hw_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512102970.11788.7481249283521486733.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 22:30:29 +0000
References: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 13:13:00 +0200 you wrote:
> The list of stat registers is read-only, so we can declare it as const.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: New patch
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: marvell: constify marvell_hw_stats
    https://git.kernel.org/netdev/net-next/c/71dd027ab453
  - [net-next,v2,2/2] net: phy: marvell: add support for MV88E6250 family internal PHYs
    https://git.kernel.org/netdev/net-next/c/ecc2ae6176a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



