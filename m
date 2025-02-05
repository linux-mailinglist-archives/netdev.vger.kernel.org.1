Return-Path: <netdev+bounces-162828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A71A281B1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584DB1883FBE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F49212B3C;
	Wed,  5 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfd8BPH3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29C2116FD
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722011; cv=none; b=ux112net0mO0jP2CDVG+S/75dCDaEttKzeoQBZsefd3xOqexZRMq75TJoilaNgvnZf6g72BybIgh9gTRCrU1HqXMC8urOsO83YRTiMquUe5C1BfE8mIU/Ok244ZsDqF3+x5eOhVRh0jkxdAmGkWs3yWlvGpq2+ERY5zKCqXXvTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722011; c=relaxed/simple;
	bh=OSqZTew45pSGnkoviwFsLES5mDg6AZrvh2reDgD8Xjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lgeKg3SVzUTfAMwt4NAEBWzUPvlCUwvvE+4lpf/t5dNaAUkJw6NbLHLmfjbJYjF+z2Khzm3YsN3fgcyLqS05gK1Ftx0pWT9gbvnr5WrsoplJ5pIfb1uxkEV0JXakDE3zSrfVHaMpQijcyuuEvHzbRq9OxFBOCfes3AM7L5zWBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfd8BPH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E641FC4CEE4;
	Wed,  5 Feb 2025 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722011;
	bh=OSqZTew45pSGnkoviwFsLES5mDg6AZrvh2reDgD8Xjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tfd8BPH3FjLwuihcbOBTptFQSJb2kK8c7uWxOaKs9AzCkO5RDl7rYTqqlwu0Lqiqi
	 4fMGT+l5SIsRtydwqajMCXPHROw0Vpgg/geHb+0z0rSrjQCSn0FhyaBq+RoJ+ZrC2v
	 H3BJoH5bjJ86PwziXJENa8+t3Ri2AE3YM9HK2E09iXnWjJwtIDTRiv3TnlEW/vFTl2
	 yXBmXiZ/iQw4qFcPjzcw45KpiPFWA491TvmU69iDQA9fDG5VkoQu2cV9a4uJs5X2rx
	 JAwHEm0nUKT8k/IMgAV9Z/9LESk1tzKKmqpauNCJdqw59Y33/yB/t1+hTHcfYeNRgd
	 Ca5lpBs6bum5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71315380AA7E;
	Wed,  5 Feb 2025 02:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: warn if NAPI instance wasn't shut down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173872203801.246239.8857480782202116521.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 02:20:38 +0000
References: <20250203215816.1294081-1-kuba@kernel.org>
In-Reply-To: <20250203215816.1294081-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 13:58:16 -0800 you wrote:
> Drivers should always disable a NAPI instance before removing it.
> If they don't the instance may be queued for polling.
> Since commit 86e25f40aa1e ("net: napi: Add napi_config")
> we also remove the NAPI from the busy polling hash table
> in napi_disable(), so not disabling would leave a stale
> entry there.
> 
> [...]

Here is the summary with links:
  - [net-next] net: warn if NAPI instance wasn't shut down
    https://git.kernel.org/netdev/net-next/c/9dd05df8403b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



