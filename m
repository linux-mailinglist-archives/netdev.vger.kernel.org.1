Return-Path: <netdev+bounces-236941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C571CC42556
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DB264E633B
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BE2D0292;
	Sat,  8 Nov 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrXYuzHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEC2C3277
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570855; cv=none; b=MlXx/dFpAoP1Bd/52sARuQ7dx03Y+eAuCY9QG2ckfjHXjFSs22gYDN/GI8N1YkfumBkWIxs7kowuyYiSWTLwmeWUimndm9cbKo29PRxD4QdyuPM0WmalhhDjUlS9dM29mrNyZcxw7PShoq4lq0XdfO5Nra3wM3kN4MJOQ1rFtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570855; c=relaxed/simple;
	bh=00lq9mTgEdaXm1TiWcCpC7BbocJlckplKnaVhHwJplM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRzRYa+XPWj8P5uBf+V9Vh21qzAbtZM3cBEE1niXuOIH6mYunoh8A4f541bJQEuf6xH+aHX4dFNvCCjaNooPxKkVNL//FvI71Ma/ODpLTYrK5hdj0foKRyQ7zhK7C7MbU9I2UOtWHNWN7TJPBqU/QapGI09HoSoR/7wm1DiCfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrXYuzHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FB7C116C6;
	Sat,  8 Nov 2025 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570855;
	bh=00lq9mTgEdaXm1TiWcCpC7BbocJlckplKnaVhHwJplM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WrXYuzHz+2VPuTxZOOasO4YmKvVFeGcQqABRgyeUpsFxX6T9r8WvQHxpZmMS7CyQh
	 2TLiKu467MaK6QgEzctbpSOlWVBO6EGWdfkfFVlsBNaFACW8fbN4OlKeQi4ITKSlbn
	 xiZCDO0urPGyDRtNhiI5xB8Q24JdTflW12qzWzFyN4kO1bevBTJnTZMweSjLDDW0yR
	 zbpYtAyu/S3g5YteRfxNhk/dCry4xNSnJAxC1wCWzOndoo/SlaAGKESpUvKH8tdXyr
	 2108EsZJP+FW7HfytpBtcB3avviqe085krqJ4+BiqRlSQnIp2oi6eNZ9aEnD2FpPq9
	 6Gr7wTk2+DeJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCDC3A40FCA;
	Sat,  8 Nov 2025 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Add the capability to consume
 out-of-order DMA tx descriptors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257082729.1232193.2974398557983419520.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:27 +0000
References: <20251106-airoha-tx-linked-list-v2-1-0706d4a322bd@kernel.org>
In-Reply-To: <20251106-airoha-tx-linked-list-v2-1-0706d4a322bd@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 xuegang.lu@airoha.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Nov 2025 13:53:23 +0100 you wrote:
> EN7581 and AN7583 SoCs are capable of DMA mapping non-linear tx skbs on
> non-consecutive DMA descriptors. This feature is useful when multiple
> flows are queued on the same hw tx queue since it allows to fully utilize
> the available tx DMA descriptors and to avoid the starvation of
> high-priority flow we have in the current codebase due to head-of-line
> blocking introduced by low-priority flows.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Add the capability to consume out-of-order DMA tx descriptors
    https://git.kernel.org/netdev/net-next/c/3f47e67dff1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



