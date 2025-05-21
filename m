Return-Path: <netdev+bounces-192145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16AABEA37
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AF83AFC57
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2E22D7B7;
	Wed, 21 May 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEEKNSg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403622D7A7
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797013; cv=none; b=a/C1Hf5dQDT+Ebb+1LmgF8Wx9K5qNKG0ndZ63y9zz4+ASZF6UT++tuOtRQum8CHPKG6L9BL0ByV1/9Rpw1qspAo18cBYkJsTjN+92MnoBz0nJ3KZnaxlvLFgn409GeP5XP1ioM3st/w6YEUHEAsOb+imCkuuhEQlnqyCWGsEq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797013; c=relaxed/simple;
	bh=mYCeKj/h9aqZRfQODr/Jf6KORjUNey+07JyzmQoYe04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Veyu1iCl7BRiVnxs1UMGonIzL17ja86fbK82hh7KzhtDOl3f63ww+U4B1hYSU6o6MGnq8oSSzwU9ZBiOlLRb5Q5Sm/+3nr5jlp9YpOfCLlOMnssE3X2Qwueozdjnq6/0+SbbI0WQXWYHUmq3+Z7/woE9GuWSTB4aRN/warLNQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEEKNSg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B7AC4CEED;
	Wed, 21 May 2025 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747797013;
	bh=mYCeKj/h9aqZRfQODr/Jf6KORjUNey+07JyzmQoYe04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cEEKNSg50kKzC0Wjgu2BSkgq2kF9AiUexsiOvxG5UVZ+2eFXaNuiM5aCOvaGSwzFi
	 76JHYgTVT/1egl0JCMKuehDIcoj0rSn1fEVOdQ2An5lTSMosK/fghzskP2jzP5mf48
	 t4bHFaYSopbNH4Q1Anobd/eTjvFAC3fYXRTKp0fbDVl6v4nDvyk3NFt8ukP9Dt7wss
	 0seO9quZ8iccQYbHrU5KRqVlxNVM20dcuhrxV9fJ8s7h3or+QHViu9iGXxn85eGtCM
	 ojWWgWbv+6V4C7mc07RgkJZ5r1wNQbtpnpyXJkPVKMiIVZaCiQ0AM2p7CYXtRy+VF9
	 +XTFs0u2ek7DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7E380CEEF;
	Wed, 21 May 2025 03:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: airoha: Add per-flow stats support to
 hw flowtable offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779704873.1552321.963690772773932988.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 03:10:48 +0000
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
In-Reply-To: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 09:59:58 +0200 you wrote:
> Introduce per-flow stats accounting to the flowtable hw offload in the
> airoha_eth driver. Flow stats are split in the PPE and NPU modules:
> - PPE: accounts for high 32bit of per-flow stats
> - NPU: accounts for low 32bit of per-flow stats
> 
> ---
> Changes in v2:
> - fix memory leaks in airoha_npu_stats_setup() and in
>   airoha_npu_foe_commit_entry()
> - disable hw keepalive
> - fix sparse warnings
> - Link to v1: https://lore.kernel.org/r/20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: airoha: npu: Move memory allocation in airoha_npu_send_msg() caller
    https://git.kernel.org/netdev/net-next/c/c52918744ee1
  - [net-next,v2,2/3] net: airoha: Add FLOW_CLS_STATS callback support
    https://git.kernel.org/netdev/net-next/c/b81e0f2b58be
  - [net-next,v2,3/3] net: airoha: ppe: Disable packet keepalive
    https://git.kernel.org/netdev/net-next/c/a98326c151ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



