Return-Path: <netdev+bounces-183656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2CA916DE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0253D1784BC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8E218845;
	Thu, 17 Apr 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7cMblum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0D42A97
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879804; cv=none; b=hBrE70kJmoiwZj9sqpeZK7bC830bhb0z7DQYP+eAv74aNLxLh8/Ktgt5PsDk5iPPb2ksa5i2K9/8UGS/OHxgf/ugFIJVCEtKs/2S6h1SaEU2J14f0mGjTdh1ed1JxDC2syduL7EFB1thYdeQZAYtyk6pfp4/Md7ekICvsZhls14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879804; c=relaxed/simple;
	bh=TF9L75xMsJl/rRW4x9jHA8OF3aCS+Rflmlav7hk7J34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LlvKOb6W7z0vZIXGXWX0NPqlBsa2XyqTUUMmCvJF5jijjstZrdwlhZet5PlP9DDSq5vGi1hL4/oQSA/JkxQ9hY1l+yzMUgNX6y2/1JRk/gcgcSHq8uPo2TnyhMZ7MQBPBenYe/9rdjFLro8yi0HsAJ/jYxrhT/6+QLMy9tWaUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7cMblum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51613C4CEE4;
	Thu, 17 Apr 2025 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744879803;
	bh=TF9L75xMsJl/rRW4x9jHA8OF3aCS+Rflmlav7hk7J34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d7cMblumKw5PUaAaELfYAtBpe1o4sOiT5AzMbq+sIInTgwhjBZTAl3MT1q3nibiAZ
	 SksU5Vc106vHExpdOFRylG/goTMWsYyisHBVxfScrPrv+cYEg5gQ5B5v7O4OPpgWHR
	 UA9sKhqhqJnWjElEA4EHeJni9CM3QipGdnjpfkYsd1A1i+F/cGHC96HiRqrrZgzCso
	 nxMNYM5A0LCYHB25By/8mbhxrN5ShPKUPRyJaI6BBZa4a4OsUIKrn3ddCXxHLuLVQd
	 zaBcKeUVdfVjDf1B2hSwTvzQjJjGhMH2axfKoaBRpdqzVuEjLQjWwgK+iTccXMixAw
	 x9QCvvkxjDWog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C043822D65;
	Thu, 17 Apr 2025 08:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: airoha: Add matchall filter offload
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174487984117.3994493.2854347625667503650.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 08:50:41 +0000
References: <20250415-airoha-hw-rx-ratelimit-v4-1-03458784fbc3@kernel.org>
In-Reply-To: <20250415-airoha-hw-rx-ratelimit-v4-1-03458784fbc3@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 dcaratti@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 09:14:34 +0200 you wrote:
> Introduce tc matchall filter offload support in airoha_eth driver.
> Matchall hw filter is used to implement hw rate policing via tc action
> police:
> 
> $tc qdisc add dev eth0 handle ffff: ingress
> $tc filter add dev eth0 parent ffff: matchall action police \
>  rate 100mbit burst 1000k drop
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: airoha: Add matchall filter offload support
    https://git.kernel.org/netdev/net-next/c/df8398fb7bb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



