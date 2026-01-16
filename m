Return-Path: <netdev+bounces-250420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E9D2AE92
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C7A3041018
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560603431F5;
	Fri, 16 Jan 2026 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur7ou9TV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A1342CBD;
	Fri, 16 Jan 2026 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535032; cv=none; b=graxmuW3ve67qX8j33Vh9qu+f6uQjqlk10tbJ4RAPPqxRuD1fULEzkJJQBsrKug37rlr/QoSsSPtyGSoXFLaOnGXabez6kSHs4KNMhNcMLtP5P16jzWt98Iu1wxFEQ3mgA+wG3IzZWRFR6rWDWoW/dDDYErtkjSUxamFC5cxvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535032; c=relaxed/simple;
	bh=Rk7ul3+7Pd2L2LKtycBrWaYq9U5m4oqexjF0isWTsys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4nj57jotZcJFMMhB5M6pBc5+lmn7pUW/gR2yxkrkfL8Q7V0wWDwZUeMBQqZaoVXUhazfAhkyruF0T4+lAI/876rpY2mpz5MZMTCZYd1RrsYe4vu9hR65r09ND3pTDQ3XsJ5TVErUTHqZ9v4tKAoO7uchTn7lDgAxmchivwZ46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur7ou9TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB3FC116D0;
	Fri, 16 Jan 2026 03:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535031;
	bh=Rk7ul3+7Pd2L2LKtycBrWaYq9U5m4oqexjF0isWTsys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ur7ou9TVo1Wkks1IlPV3IoVZDFs90ZBFQ9xfnfHgHr/GgEGqm8PAr9kL+Hsu2C60L
	 zPP9c0xe0EfsfPUHW8o/kW1aL5dFzsGNYuJXiWXpeGOudoAYN1TBsIWsCvAs8sxawy
	 qcKI0oWPXc0hw8RaKO9QRYtBTRDpFgiOTQeHjS2q/SYoi9DftkutaofhoqhbyyYISU
	 Rcps+E1ceyw40H2zSR50kWbdimDVpahi8M0RK2IzxzYbpsy68D2pQ8Npcmm4nVBVt+
	 GO0KOPNtN7XalXX981ewAP0GnkqVbDcfLRFTu/cMTykqxQkVTXzP+aeXL0TbqFNAZr
	 oYMmKKr8XVuWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7894F380AA4B;
	Fri, 16 Jan 2026 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: airoha: Init Block Ack memory region
 for MT7996 NPU offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853482227.70930.3785577053167700341.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:40:22 +0000
References: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
In-Reply-To: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Jan 2026 16:05:06 +0100 you wrote:
> This is a preliminary series in order to enable NPU offloading for
> MT7996 (Eagle) chipset.
> 
> ---
> Changes in v3:
> - Add missing minItems for memory-region-names in airoha,en7581-npu.yaml
> - Link to v2: https://lore.kernel.org/r/20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: airoha: npu: Add BA memory region
    https://git.kernel.org/netdev/net-next/c/40f9e446033e
  - [net-next,v3,2/2] net: airoha: npu: Init BA memory region if provided via DTS
    https://git.kernel.org/netdev/net-next/c/875a59c9a9e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



