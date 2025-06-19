Return-Path: <netdev+bounces-199554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE94AE0AE0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700D91893E82
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F728B4EC;
	Thu, 19 Jun 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNBRpC2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E4286D47
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348193; cv=none; b=Tge9DTzXZ5Ls4B3rzWDLWaX9EROQ3EvcJl6nQBu6GlgnRQR+Zo/7TuYM9jVeseTJDtajQgXgATO2TYavs4LTHZrp4Kys0bFdnXHdAVv5SN5y38cFQfCsoV2G0a1FfdyOKnZh4oWV3Se5kLkgz8H/KqdAORuZ5xQBEapVl/b2oGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348193; c=relaxed/simple;
	bh=uDshXZbmAr/TJK7xktqLJGVw1ctH6vb0ZJmX6Cflkj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IzJU6q8gpkMMKii9BfUN/P+3hDEGk1XnZ/ggZ0stUXW+91ZNSzdNNdd/FuPCvDsX5FDxFmQNG4vPjy1am1baC3e0k3lQCtUxTwRiVQu2g6RP+KWE0tV12L2pHVcYNWCMvilA8ZqqpaiANlgNBNU4FzAa109rcJHerW2z9lYlUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNBRpC2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D727C4CEEA;
	Thu, 19 Jun 2025 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750348193;
	bh=uDshXZbmAr/TJK7xktqLJGVw1ctH6vb0ZJmX6Cflkj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fNBRpC2sA0l7+2/B0aZ49Y9iXjGV9gKWeuRyrFvZTK99A14+HJ4zFj4sQRm6aiVzR
	 zPulwdP8JIxdSuKViFYWJCY63HYWC22PvIG1Dow0dgv4fHe26CLbR65QvMXDiH+h2f
	 hfVDzidaU8SbjGKaFFjZPELH/yckDnOS/x08yBfiprZlHE2/t35weKGOOQcGQGC0gU
	 EpUAboIuNSDGwIdlj0gvquaj3mW51WxiVkwk1/S7Ce9pbyN36MO8B1Ca/7QrdoetQN
	 JrZ6JS/aqjQvivId9aurx+iZhz94vUsde6zCYwTULdsPbT/wmCvqwxJnm/wL6iSUL3
	 RjwdgPaCfyrtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2538111DD;
	Thu, 19 Jun 2025 15:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: airoha: Improve hwfd buffer/descriptor
 queues setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034822148.909907.3251330823470236604.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:50:21 +0000
References: <20250619-airoha-hw-num-desc-v4-0-49600a9b319a@kernel.org>
In-Reply-To: <20250619-airoha-hw-num-desc-v4-0-49600a9b319a@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 09:07:23 +0200 you wrote:
> Compute the number of hwfd buffers/descriptors according to the reserved
> memory size if provided via DTS.
> Reduce the required hwfd buffers queue size for QDMA1.
> 
> ---
> Changes in v4:
> - Fix commit log for patch 2/2
> - Link to v3: https://lore.kernel.org/r/20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: airoha: Compute number of descriptors according to reserved memory size
    https://git.kernel.org/netdev/net/c/edf8afeecfbb
  - [net,v4,2/2] net: airoha: Differentiate hwfd buffer size for QDMA0 and QDMA1
    https://git.kernel.org/netdev/net/c/7b46bdaec00a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



