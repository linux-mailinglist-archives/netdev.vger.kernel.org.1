Return-Path: <netdev+bounces-216748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE613B3507C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E252242D07
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52B1BE23F;
	Tue, 26 Aug 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcoSPHfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48694482EB
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169402; cv=none; b=iEqKocGUpI/Ps76In1UxEthiao47IjC7TkIIJnmXokXUe6mpGwLwc0ctxpP0f2bRLeaZ4WkCdw8fdIEWNkKVTf1HXYOIl6lFeBBmaAWNiitObxujkCNZL6POG6itB8ZQH4RoxFKrE0AiYK15viHGeUSxyHViLcjcCQMKS3/450s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169402; c=relaxed/simple;
	bh=nDRA1Tds71oq7lboJgaRNpeXobXorqZWQAvxAvuigEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=phddzcTUAGumzOOYuImG8jepkhV2hk9ZnA3cGyMA1Xs87k4QegmIVjOGeX8llPn9L26n/Vwb4GK7MKzdr/v/WaeuocUxlkq5HkC7Z2d6oBFPitf4+arAMcebnLi4+XyFSG6aAUSPRLomHF51+fRkDRWJ/QZWD+1oUgO+G3C9cU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcoSPHfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC85DC4CEED;
	Tue, 26 Aug 2025 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756169401;
	bh=nDRA1Tds71oq7lboJgaRNpeXobXorqZWQAvxAvuigEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcoSPHfIUBQl1xIRHVsfjzVLMeBmlwrSw2M72DHtRntuR55A/fglMAL/P3jtCWzxQ
	 Z2HsvCnspVf67NJfcoF1ez4WWwyZJHUYKK4gamEOKHp6JrJ2WDnCnXaSNTzyQw04w2
	 XOn4ArDBxO/rndR26G+Dwum8jUnIJFu0+RBWM0llQyJf5G/0D0ZbX4xnDdE18UGeG9
	 iwZqLMOUUWIuTuJ/FN0a4OTPLbKY5PdRdurORn15q49APCu5lfrfxht5fgtOm/WHbg
	 vWoScC5/UvND+wSVyZQiLHbw1e72ZCnP720xt6r/By44hvBAdfb6mk4d1Q3i/EcncM
	 lhUTrhKiFAY0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1C0383BF70;
	Tue, 26 Aug 2025 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: airoha: Add PPE support for RX wlan
 offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616940975.3610531.11567535063308274967.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 00:50:09 +0000
References: 
 <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
In-Reply-To: 
 <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 Aug 2025 09:56:01 +0200 you wrote:
> Introduce the missing bits to airoha ppe driver to offload traffic received
> by the MT76 driver (wireless NIC) and forwarded by the Packet Processor
> Engine (PPE) to the ethernet interface.
> 
> ---
> Changes in v3:
> - Fix compilation error when CONFIG_NET_AIROHA is not enabled
> - Link to v2: https://lore.kernel.org/r/20250822-airoha-en7581-wlan-rx-offload-v2-0-8a76e1d3fec2@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: airoha: Rely on airoha_eth struct in airoha_ppe_flow_offload_cmd signature
    https://git.kernel.org/netdev/net-next/c/524a43c3a0c1
  - [net-next,v3,2/3] net: airoha: Add airoha_ppe_dev struct definition
    https://git.kernel.org/netdev/net-next/c/f45fc18b6de0
  - [net-next,v3,3/3] net: airoha: Introduce check_skb callback in ppe_dev ops
    https://git.kernel.org/netdev/net-next/c/a7cc1aa151e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



