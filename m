Return-Path: <netdev+bounces-231180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F15BF5FF8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A30018C89C9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990F2F5A12;
	Tue, 21 Oct 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW1znFsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE02F3C27;
	Tue, 21 Oct 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045640; cv=none; b=S7g2ng6zoXGxkCtFV30egj6L1orIuF6w+LpGb5mLI+e2o9RCutnLwXJZNuZzhxG9nbDUkJTo+S4isjJYCC30Pwn5K9sezZr6iUGXVEQS1OUv4uHIWUBqBwiLixDzYQMtd84BdRlAtUgPPOQoHUThhJTt5Mt8m5IFykALfyYKbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045640; c=relaxed/simple;
	bh=+VaSZVBmZz5ORjS1Wb6KdbQodfWLfvpUe4sWk4+bHv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b+D7Q4Xh9I6w4Cw/styGrHe8+vca61TOx1hFMFamRoHCrzX54ai7FSpgx4ch5Ks12lGGX40oxaQxejekAlHjsBp0umYy/erUms+YV5U3ZvM6BKvaXYV0kmAffrVvtKuEd16mo4W6lELfZEy01HL1W0tF3jldAbBolXEDTBNlneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW1znFsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4677C4CEF1;
	Tue, 21 Oct 2025 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761045639;
	bh=+VaSZVBmZz5ORjS1Wb6KdbQodfWLfvpUe4sWk4+bHv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YW1znFsumFVytyxSSC/x9NGDtSKDa95wxqD2GVitcp9zBDvj58z7i4UVfsYqyMESb
	 0756yvamIZ5JBhICt1yrOhmGulkkWKUjuXg9nEXtxL2d1R5NXWyktgM1ONo1BM3+9D
	 eM3u7SzC32ZvUTi8W9M9Npo2v2ZkjZ9NH1QfoVbSzjcBX6tRiUSkmRnEQsffdaiw0y
	 na/QZqlQUaeMUVNggBSrFzt607Gl9yD8TApx2OmB/txPEG33msJMaGvo4oi432rB/6
	 EsFxp0BhffTuDlM20IErb2ih6IgyYqB8TfoMmyUlMdQAgug5V45/0r9BQMV4F9FUx1
	 C9mqq2/7zXWdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3A3A55ED9;
	Tue, 21 Oct 2025 11:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/13] net: airoha: Add AN7583 ethernet
 controller support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176104562151.1030909.1115814969731162849.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 11:20:21 +0000
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, horms@kernel.org,
 ansuelsmth@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Oct 2025 11:06:09 +0200 you wrote:
> Introduce support for AN7583 ethernet controller to airoha-eth dirver.
> The main differences between EN7581 and AN7583 is the latter runs a
> single PPE module while EN7581 runs two of them. Moreover PPE SRAM in
> AN7583 SoC is reduced to 8K (while SRAM is 16K on EN7581).
> 
> ---
> Changes in v3:
> - improve device-tree binding
> - rebase on top of net-next main branch
> - Link to v2: https://lore.kernel.org/r/20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/13] dt-bindings: net: airoha: Add AN7583 support
    https://git.kernel.org/netdev/net-next/c/51538c0c9d8c
  - [net-next,v3,02/13] net: airoha: ppe: Dynamically allocate foe_check_time array in airoha_ppe struct
    https://git.kernel.org/netdev/net-next/c/6d5b601d52a2
  - [net-next,v3,03/13] net: airoha: Add airoha_ppe_get_num_stats_entries() and airoha_ppe_get_num_total_stats_entries()
    https://git.kernel.org/netdev/net-next/c/15f357cd4581
  - [net-next,v3,04/13] net: airoha: Add airoha_eth_soc_data struct
    https://git.kernel.org/netdev/net-next/c/5863b4e065e2
  - [net-next,v3,05/13] net: airoha: Generalize airoha_ppe2_is_enabled routine
    https://git.kernel.org/netdev/net-next/c/ef9449f080b6
  - [net-next,v3,06/13] net: airoha: ppe: Move PPE memory info in airoha_eth_soc_data struct
    https://git.kernel.org/netdev/net-next/c/5bd1d1fd48ea
  - [net-next,v3,07/13] net: airoha: ppe: Remove airoha_ppe_is_enabled() where not necessary
    https://git.kernel.org/netdev/net-next/c/41139125f5c7
  - [net-next,v3,08/13] net: airoha: ppe: Configure SRAM PPE entries via the cpu
    https://git.kernel.org/netdev/net-next/c/306b78f5035a
  - [net-next,v3,09/13] net: airoha: ppe: Flush PPE SRAM table during PPE setup
    https://git.kernel.org/netdev/net-next/c/620d7b91aadb
  - [net-next,v3,10/13] net: airoha: Select default ppe cpu port in airoha_dev_init()
    https://git.kernel.org/netdev/net-next/c/c71a7a861ef0
  - [net-next,v3,11/13] net: airoha: Refactor src port configuration in airhoha_set_gdm2_loopback
    https://git.kernel.org/netdev/net-next/c/9d5b5219f672
  - [net-next,v3,12/13] net: airoha: ppe: Do not use magic numbers in airoha_ppe_foe_get_entry_locked()
    https://git.kernel.org/netdev/net-next/c/63f283d36b1f
  - [net-next,v3,13/13] net: airoha: Add AN7583 SoC support
    https://git.kernel.org/netdev/net-next/c/e4e5ce823bdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



