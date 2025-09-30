Return-Path: <netdev+bounces-227262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F392BAAEAE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856511895418
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4E19CC3E;
	Tue, 30 Sep 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwiN6PP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847654654
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197014; cv=none; b=auGu6YHCQ8xgzxOTMaiG7L0Hs2kvJ96NX7IeGNi4atzG1P3cJtweCFhthmkSflHdzxPI7xM6KzhAlu/0JaVL775VbAowxhXWd8Fs14TEQa0DdcH69WsKd93s9SRuze5eACQYpnFznp9PJwSLN4etqtDY909bruP1kkpqtS3LKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197014; c=relaxed/simple;
	bh=+Py36Y93nGq7L75X4B119YbehcNG3WmE7GWwH80R0ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T0ebD1xHNq7mOuRJ2c1T8hWMpVbTn56ifQrD1sLQ2n8I1s1Vl5qRL5zqid7j1HqrWsUBv111KWpbvFhYH5D+MBDTRiS2totp+C+Tp7vHj3kZUR0j7I0MHuGXCyQS6nDzgw0k5kbekFvomX/HaIjXYX+QJfSLuNgqPkEYUp8fx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwiN6PP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DF2C4CEF4;
	Tue, 30 Sep 2025 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197014;
	bh=+Py36Y93nGq7L75X4B119YbehcNG3WmE7GWwH80R0ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OwiN6PP0VqsAMGpV1AWPU0vqLCaTLT3OKzS1KDHjv2rPjXKcPBogeiZO10hC2Vdmh
	 +GEjGgvSFP92GDUxl1Bxt+e58bPKq2ByslGW0eTtGuWBPSjy1sQuHdSK9ROgpoGdLQ
	 7lh6bX/EyUZN5phX1sa60cuTgUTLVbryt3BzbKCh2wF95wU7BoQIXva5ne9GmOBYCl
	 xn5i2Z/PbkPfJ+38FMrlLEJwfeZCaNg3QXxqKBy0ixGc7AwCyuUjugSj3Km7ZjsxA5
	 3nlRUepcsPbHPpBvW25BOC8nxk0KX7J66VTATBMNjSgmeMcT9Xm5EjZwJ64+8teF6A
	 yWdDbwtLtQWKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F9D39D0C1A;
	Tue, 30 Sep 2025 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: ena: return 0 in ena_get_rxfh_key_size() when
 RSS
 hash key is not configurable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919700725.1783832.7344252741569020332.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:50:07 +0000
References: <20250929050247.51680-1-enjuk@amazon.com>
In-Reply-To: <20250929050247.51680-1-enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: netdev@vger.kernel.org, shayagr@amazon.com, akiyano@amazon.com,
 darinzon@amazon.com, saeedb@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rosenp@gmail.com, sameehj@amazon.com, kohei.enju@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 14:02:22 +0900 you wrote:
> In EC2 instances where the RSS hash key is not configurable, ethtool
> shows bogus RSS hash key since ena_get_rxfh_key_size() unconditionally
> returns ENA_HASH_KEY_SIZE.
> 
> Commit 6a4f7dc82d1e ("net: ena: rss: do not allocate key when not
> supported") added proper handling for devices that don't support RSS
> hash key configuration, but ena_get_rxfh_key_size() has been unchanged.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable
    https://git.kernel.org/netdev/net/c/f017156aea60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



