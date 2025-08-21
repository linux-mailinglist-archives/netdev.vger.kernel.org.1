Return-Path: <netdev+bounces-215683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63706B2FE21
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494887B839A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619F275AE1;
	Thu, 21 Aug 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4b4U6R2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA127587C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789610; cv=none; b=WsGycfbdAkiH7BA4F4vMNgXQPnIv+K1iRa8tdq/ERhyAWnuCKzOYGsu9pGCbtU6nNsgD0+LOnW3Vzu3oND3m8TfqPFtfxGvZRBQJM0Yt+1LQiFQsmplQZhY4+cuJFyxscV4aNDjRqfzqjMKvbHkqSu4Btr2UTb01W9fZIQ2fg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789610; c=relaxed/simple;
	bh=oE3VemkLJKDAtiQ/Ohy9XNC7q1TcksVYQUMlWWacL+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1EoYSM4Z3WlU+pmz6yr7TxmtptisHf0sxnY9pK2NQeT8GWpIaxgLXBuVTfTMvRMeXlEAdJFVnuX48Rcf8PPUoG8cfjqkWmSVoxNgHV279auSN387TG846GJZ66OFjzSLrvk4a+Fml1nY9mE9gK72qmT1KB5YiUyXCyuE0dqhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4b4U6R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E890FC4CEF4;
	Thu, 21 Aug 2025 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789610;
	bh=oE3VemkLJKDAtiQ/Ohy9XNC7q1TcksVYQUMlWWacL+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A4b4U6R2iz0tsAmFuTqIqMm+o5vJcBhKP2yxWx5uRtTyi3Rj2/Czwq/o/nOiCdF+X
	 AOw5SDret+H6Gf/fu/CiPOzB9ZAlmPy0NaBgRXwX31o15lA8vuhu7fs1dWFHcfymnN
	 WJNFKyJlIDPzJj+fNodFiJNQPFWdxWtV5MWk5gS7AxDZpGEsGH/VsBn/ZYCgXImbtE
	 nvz0Nm2b04qaFflmvHI5DCSu83Y2zPOirGE4vKu94qocUL+3ByDZDjxbONNnw3VOUt
	 js6BlGY2R3hj2UZh0IYqf0yYYBiin93MqqlHIbuYIQBldMRhe+8c7/txI8PVJiGZud
	 +dNhYyaVyQs3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B09383BF5B;
	Thu, 21 Aug 2025 15:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175578961923.1082285.15946086223627370332.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 15:20:19 +0000
References: <20250820025704.166248-1-kuba@kernel.org>
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, michael.chan@broadcom.com, tariqt@nvidia.com,
 dtatulea@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 alexanderduyck@fb.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 19:56:49 -0700 you wrote:
> Add support for queue API to fbnic, enable zero-copy Rx.
> 
> The first patch adds page_pool_get(), I alluded to this
> new helper when dicussing commit 64fdaa94bfe0 ("net: page_pool:
> allow enabling recycling late, fix false positive warning").
> For page pool-oriented reviewers another patch of interest
> is patch 11, which adds a helper to test whether rxq wants
> to create a unreadable page pool. mlx5 already has this
> sort of a check, we said we will add a helper when more
> drivers need it (IIRC), so I guess now is the time.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net: page_pool: add page_pool_get()
    https://git.kernel.org/netdev/net-next/c/07cf71bf25cd
  - [net-next,02/15] eth: fbnic: move page pool pointer from NAPI to the ring struct
    (no matching commit)
  - [net-next,03/15] eth: fbnic: move xdp_rxq_info_reg() to resource alloc
    (no matching commit)
  - [net-next,04/15] eth: fbnic: move page pool alloc to fbnic_alloc_rx_qt_resources()
    (no matching commit)
  - [net-next,05/15] eth: fbnic: use netmem_ref where applicable
    (no matching commit)
  - [net-next,06/15] eth: fbnic: request ops lock
    (no matching commit)
  - [net-next,07/15] eth: fbnic: split fbnic_disable()
    (no matching commit)
  - [net-next,08/15] eth: fbnic: split fbnic_flush()
    (no matching commit)
  - [net-next,09/15] eth: fbnic: split fbnic_enable()
    (no matching commit)
  - [net-next,10/15] eth: fbnic: split fbnic_fill()
    (no matching commit)
  - [net-next,11/15] net: page_pool: add helper to pre-check if PP will be unreadable
    (no matching commit)
  - [net-next,12/15] eth: fbnic: allocate unreadable page pool for the payloads
    (no matching commit)
  - [net-next,13/15] eth: fbnic: defer page pool recycling activation to queue start
    (no matching commit)
  - [net-next,14/15] eth: fbnic: don't pass NAPI into pp alloc
    (no matching commit)
  - [net-next,15/15] eth: fbnic: support queue ops / zero-copy Rx
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



