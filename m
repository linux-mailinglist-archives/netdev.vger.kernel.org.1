Return-Path: <netdev+bounces-120399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A743959230
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B524A284E1C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07B73446;
	Wed, 21 Aug 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GswjOhcQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625C6F06B;
	Wed, 21 Aug 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203838; cv=none; b=dM80v0vNjBBw5gtQ+alrNOlCmurcxWR37wNUnY5L+ZKseNLKLOUXC0wFXQmwE2jPDb4zRVsd7BDMvJFmhuJ//VOT7DbJjgUJuVQQUJvIAeIdDPX2HMXISZhqpzm/lTxfTOx0AAgnxNLtf7zpUUBgjjgpAfPLDKgvVEw+POJ7XUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203838; c=relaxed/simple;
	bh=Zl7rEQ2CkJpwL0c9uZHzxyh2hwJaAk4wRJP/Rmh6LrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+/SzXFajl+kJm5tQXCxw5MLozGeXeSovdKI52G4OmqKDf0CAHJ/zDiqikmUMCq7zEWLps34AiQe8m2QWVvSqKpoB/UCwbeNQxvjRTN58sZlPBg9Xp5Ffp7WqFacwrT+7ENFQp3SFe8nfrEfMvPMjFtW5J07DPauT1AayqLVzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GswjOhcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E3DC4AF09;
	Wed, 21 Aug 2024 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724203837;
	bh=Zl7rEQ2CkJpwL0c9uZHzxyh2hwJaAk4wRJP/Rmh6LrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GswjOhcQQP+QWhZUYZmGYQuD4yYaqJA3NeUNkqk75ObkJeeDlSVxjckxYMSzHCGmv
	 zIQxeJZbpC47k/AfHBwDg6UVKsay02/tqnMWsHy+vU14qfyxd5sZPuiDVDHS/Yitus
	 tkGcuaRUtlT9lQjHhe2v2z2aRG4jQVDVP6nPmgK2EAa04D8H+Yr6xOMrqnTZLcIPPW
	 Ex/PAedIWUIOutAQDg8iq1wj0PwQUdNfzojFjosCvrA97EbBoEv3u4ZTEZGJ16tkbd
	 kUyiHpJVrz8RjmNgIX1l2gwABJ6mTr0ZI6ExidTt9z9svPKoiIg4z2MGO5W9OMBwf7
	 xtc+i2MulbPYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1F3804CB6;
	Wed, 21 Aug 2024 01:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: b53: Use dev_err_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172420383699.1291081.5830444832362646792.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 01:30:36 +0000
References: <20240820004436.224603-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240820004436.224603-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, robimarko@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 17:44:35 -0700 you wrote:
> Rather than print an error even when we get -EPROBE_DEFER, use
> dev_err_probe() to filter out those messages.
> 
> Link: https://github.com/openwrt/openwrt/pull/11680
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/dsa/b53/b53_mdio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: b53: Use dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/4d36b2b1dea4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



