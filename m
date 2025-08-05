Return-Path: <netdev+bounces-211637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA96B1ABBD
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22018180992
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBEB1BC9E2;
	Tue,  5 Aug 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRWxj3J+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FA1AA782
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353806; cv=none; b=S2155FviMZoYWs/eehFUTJzP14MA+n/PDO6ALJS3HgGmvY7P6jYLIFSb501cm29adkgi+Ummb3AxMQpmIRMH24H2egaqrVzVSVZEUpk1Usjj7SqazY6wfvmJttOy03H01d+EVoDsptMfrfB48Rg6gKzC+yHrYeAc3JKonW1YQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353806; c=relaxed/simple;
	bh=fKvxZcfVZrgBb+Pc1yoIKzuXZevNbI/9BGrxb/fzvws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRnzF3MT2CJeqMo+zGzMLC/obLxTAEzaOUWWeAk11B20/sH+KCTtph/Nw8SiTJtlrM7tahVWkETXDfv1zV/lbNvZ6hIm7vx8nomZIhoZiQtGkCBnDf3l/Krr22TpC5eAqqOlsCO3wUzCUnmb6UUeGAmmfFlqbMFDTwEHtuOM0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRWxj3J+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B58C4CEE7;
	Tue,  5 Aug 2025 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353806;
	bh=fKvxZcfVZrgBb+Pc1yoIKzuXZevNbI/9BGrxb/fzvws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rRWxj3J+MapslYLsP4HWazmOQR9sD3c8sPSPzx3EFuo6nUPD720KZmgPvpi61DBXv
	 nbem0zKLA5wN75wIHRQTNA8ZTEey4BNM0/xioKxY+s/ZwRM+1ljmPqb1y3AV13E1De
	 g/RPOl7hfCG8KX+tcsh7fDxGypwLsFtyg6Lj3Lzu6YPfI90ybM8Z96TwtcMqd6ZVOE
	 CPbpCt3e9enXB+C/s9msQwFo7z/clVTED7kCv5XXQQEGukN8Nf75jeh7aKb/e+ryXf
	 WuJAW5puLMobg5UmdpoZYjgrBVRF6YbUGnm+Ohhed+G5Lk2nzik0vGfUNoeIrDE/Ok
	 emrtLMF6OvO1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF5383BF62;
	Tue,  5 Aug 2025 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: npu: Add missing MODULE_FIRMWARE
 macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435382075.1400451.14706979312090764224.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:20 +0000
References: 
 <20250801-airoha-npu-missing-module-firmware-v2-1-e860c824d515@kernel.org>
In-Reply-To: 
 <20250801-airoha-npu-missing-module-firmware-v2-1-e860c824d515@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 Aug 2025 09:12:25 +0200 you wrote:
> Introduce missing MODULE_FIRMWARE definitions for firmware autoload.
> 
> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Add missing Fixes tag
> - Link to v1: https://lore.kernel.org/r/20250731-airoha-npu-missing-module-firmware-v1-1-450c6cc50ce6@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: npu: Add missing MODULE_FIRMWARE macros
    https://git.kernel.org/netdev/net/c/4e7e471e2e3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



