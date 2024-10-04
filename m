Return-Path: <netdev+bounces-132165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC2F9909D1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7741F22276
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79831156872;
	Fri,  4 Oct 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivZ8PcPc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539091E3787
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061228; cv=none; b=f00BCKV87F7FFqaPT3xvuCrCFMtXx92ABOvqnrFwk84YdPs+hcWN9PrdRqcQELt2NNKAprJpnwldqWH+8B6/pq3T7bWvRYev0K8pqO1KGQhLGwwbXsPCaxX/d30GcoB9YAXEXXUrKZvy3ppuZBtq8SpQjyaoJ6aAQf/yZ76EM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061228; c=relaxed/simple;
	bh=RFsARZ0zk68ctW4vdVH4KIUXSCfgAXntavNjMmvHP48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L+Qg1YRlbYAjrdFfTwaqgYIH2alSPpWSjx5mGXDH58do1/Prs55G1n2MWfhvNYl4hcQs/DJJEhLHWxI6hMOEobw8fZJIxv6lXcQKgOC3E3ll0RFA4SlJDyP8AXk2ulIjd4JHIOkDMt1nYDSAXzQzRp/0bo3VTIdahNfgAOLuI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivZ8PcPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27D3C4CEC6;
	Fri,  4 Oct 2024 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728061227;
	bh=RFsARZ0zk68ctW4vdVH4KIUXSCfgAXntavNjMmvHP48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ivZ8PcPcf6nMId2MrNs/qEqsQpiyMbusXcaW3K2yvjBA0vCHpNuRZHgPaIZQx/rhd
	 jd7GIOysi0++tfEC6wmoSOMmqFwUqhFhPYUl110jhJLebKwYUPegLKj7yHzZi8anCg
	 MWsytlW71p/GBvWnbwi6pm7UZR4luDh1Kdqd8urrFz3VibzYgDOgdHKqoJ1qLnDNJQ
	 mBY+SXTN31qs6gQWlU2brax8YUJaaNB0hZevKvCW6sq3PYUNCZ6AWC/iGiORY3zpRT
	 ttmwpjCakX6SHB1RLiSbPU7xeqHNOeXKijEGC46UdXNY4L6qd8oAOZvDJo9n4pDrPp
	 Z+r3pfPjJUfcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE08E39F76FF;
	Fri,  4 Oct 2024 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: airoha: Fix PSE memory configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806123129.2661344.16262857869293942023.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 17:00:31 +0000
References: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
In-Reply-To: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, horms@kernel.org, upstream@airoha.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Oct 2024 12:10:23 +0200 you wrote:
> Align PSE memory configuration to vendor SDK.
> Increase initial value of PSE reserved memory in
> airoha_fe_pse_ports_init() by the value used for the second Packet
> Processor Engine (PPE2).
> Do not overwrite the default value for the number of PSE reserved pages
> in airoha_fe_set_pse_oq_rsv().
> Post this series to net-next since these are not issues visible to the
> user.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: airoha: read default PSE reserved pages value before updating
    https://git.kernel.org/netdev/net-next/c/1f3e7ff4f296
  - [net-next,v2,2/2] net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()
    https://git.kernel.org/netdev/net-next/c/8e38e08f2c56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



