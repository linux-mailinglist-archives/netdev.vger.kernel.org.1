Return-Path: <netdev+bounces-170353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4865CA484CB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AE3A6B11
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4B1B21B5;
	Thu, 27 Feb 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+8iK5uw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1F1B21B4;
	Thu, 27 Feb 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673203; cv=none; b=GsC1FRmtSFdbwNUFkbu7vYAn68gkuYZy/E4Jmv1bU40FKsqlja4mLMOiXAvjh73VayKfEaa77FAK4XyQ2qV6bztRO3/Qi26rWmJQuCAsMaEoC1z4t0U6jOPW4j9Sb80wmDtBLdHHRhMqF6+JieOF3ouDy7dBT+OprDd1vgJaKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673203; c=relaxed/simple;
	bh=VpDZza7QXbnhces+of61OvEOBdzoZhLzbcuTIudJynw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z20Qx2kMac6Px4XK94FKKoYNdVBCoSn3iSap2GJrk9ae1KrAUMVJJ9bp57Aehf02ChDJtkSvSAQyLO0WJXVirG3tPdmAqA33Nrra3KoXloPyJsNmHxr0B3knT6C6aiztBKUqEAH9kW4ssmusjEsuqZfPfxTV9R5NVUvgRW8ZVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8iK5uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1A2C4CEE6;
	Thu, 27 Feb 2025 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673202;
	bh=VpDZza7QXbnhces+of61OvEOBdzoZhLzbcuTIudJynw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i+8iK5uwh70kd0GxxW6snP2DPzw8Mq3aSRuYooC4m0M52JYgVJ7M5sG/J9xnyBCB5
	 R61VgB7uv1EaFEEuNs9QHJl2QFanAEN8WpPWvZbnhBzh0SVmfamOsaKL3XxRIkTIJG
	 knVOMemJjTh2fz02wv/7AODLLsBShcs7xFQPRekGBGpvhJYDsnfiQ+j4DqgG0il76P
	 MvyK8pMpc2DT66QbOnEnkIGWxUD4IBbNkTbA8Je09TVlYYr/OA0PXUSlBkKx6elL8m
	 GddSaEd3zYIjLfYMqfaRMpee6NkwRfxIMphjYgnPHm11pd/mLUcr6mgqBDq3hiFFPn
	 8U1nC5nR30eyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB540380AACB;
	Thu, 27 Feb 2025 16:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icss-iep: Reject perout generation request
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174067323473.1484560.3837727172875875732.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 16:20:34 +0000
References: <20250227092441.1848419-1-m-malladi@ti.com>
In-Reply-To: <20250227092441.1848419-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, horms@kernel.org, richardcochran@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, rogerq@kernel.org,
 danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 14:54:41 +0530 you wrote:
> IEP driver supports both perout and pps signal generation
> but perout feature is faulty with half-cooked support
> due to some missing configuration. Remove perout
> support from the driver and reject perout requests with
> "not supported" error code.
> 
> Fixes: c1e0230eeaab2 ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icss-iep: Reject perout generation request
    https://git.kernel.org/netdev/net/c/54e1b4becf5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



