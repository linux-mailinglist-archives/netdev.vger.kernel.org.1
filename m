Return-Path: <netdev+bounces-63385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A95E82C91A
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D401F24EA5
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1568618E03;
	Sat, 13 Jan 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGgjEh6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA911A703
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AAA3C43390;
	Sat, 13 Jan 2024 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705112426;
	bh=v9MN2Kg1SoIiXdnhf1rIIpOZR0XPGJz3dmUGWb0ngTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vGgjEh6RnYJHJ4qy031qGwV4A/cJxuXObsENpa9lBN9CgyOvYsDljBfG+dGyBe2bi
	 VQJYoXKYtYEOLRMhGDPOLiUNDGeA4Pyd+ztLreiHj9M937OuHOO4WJhHlsn6EUOJ9h
	 zS8p1yuQsxAzm4HPH6hllCO5I5KyqzCzuZ/RnHMbTEITMoofIkyaLRsjDeg7CAo6f7
	 lo3kVO/v5khMYTMGpMSXb8s0/VGCfoP3lz1E94OddT7OgtTZNi7fz07/U8KveVSeV+
	 AhcOhgdY+mPND8GC14edR7yLQFpc9+8xXFdq37M54kRGwF06rW3/YJVyg8MLdrX2Ve
	 5hMPjkIM3Wjkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60D87D8C96D;
	Sat, 13 Jan 2024 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: liquidio: fix clang-specific W=1 build warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170511242639.12065.15264121301786875771.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 02:20:26 +0000
References: <20240111162432.124014-1-dmantipov@yandex.ru>
In-Reply-To: <20240111162432.124014-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: dchickles@marvell.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jan 2024 19:24:29 +0300 you wrote:
> When compiling with clang-18 and W=1, I've noticed the following
> warnings:
> 
> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1493:16: warning: cast
> from 'void (*)(struct octeon_device *, struct octeon_mbox_cmd *, void *)' to
> 'octeon_mbox_callback_t' (aka 'void (*)(void *, void *, void *)') converts to
> incompatible function type [-Wcast-function-type-strict]
>  1493 |         mbox_cmd.fn = (octeon_mbox_callback_t)cn23xx_get_vf_stats_callback;
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - net: liquidio: fix clang-specific W=1 build warnings
    https://git.kernel.org/netdev/net/c/cbdd50ec8b1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



