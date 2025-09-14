Return-Path: <netdev+bounces-222886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A868DB56C96
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE603AC3EC
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E32E7646;
	Sun, 14 Sep 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihq52V/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D722E765C;
	Sun, 14 Sep 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757885415; cv=none; b=EX5l8k5KrvWfHvMT92mH+b1wGcW8KrVCSYV5l0E/bLCQuK+vZHmYyv8nn9riuQpDscbNwM72pfkUpbavr5TdHl8E5Gy40zkvC4VwZC1HoIpt7NdJEZGDQ8w2rvcKw3ZR+8RrAN4DuTLXcqku5LfJosbueZl9rWqZZ3vL5qlICcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757885415; c=relaxed/simple;
	bh=y1ScwfLNpQGdRhzR3jPC/JGvzbTPqjCZQN7mITZ15TQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GhjQQmnjSrBRJoQzpk4eVPmdT78PAQ0Y+lcalLde84zh/Zy15eVH52ceXRmZXp9J26R4uduHP4SCgKOsEpxyHgSbe9hXMEW8rQBhC16pMNAuWhqdBDHeBnGA9PyNn1REpNIv1AZZ4Gd5y9VNDliBa4JENtGwENuyu+Ur81DN4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihq52V/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F563C4CEF0;
	Sun, 14 Sep 2025 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757885414;
	bh=y1ScwfLNpQGdRhzR3jPC/JGvzbTPqjCZQN7mITZ15TQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ihq52V/GoW0kgMTeJMcAslwunXM1We8JC9V2UN0j8UTKPPSZ6fS218msCIW6WXQZO
	 7zb7flAMtw/MfV4VtWK1B20Chsd+vDrD/rNXUzOXT0UYGzAfKAtav0JsFDRRTpi1s2
	 PslzLrXlzCtjuSDaPEsXCA32qU8lsnk09ej5BAnnMKe2U49sgF/w46LCPD/Tu0q9Tb
	 ZviAi6Z2MInEB552NpPJXw+2RltVKDQ92HoBqBo3CN5d/Swc7tI+LOxmWz8mEdhJXC
	 D0sJll4eW1DNlsviOBJIJaMA4LYLy0XcspZXuHDJKugS2rK5cLkuGCeYFoprDVDiUX
	 s6qBYHSOMpj0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7159D39B167D;
	Sun, 14 Sep 2025 21:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 net-next 0/6] net: fec: add the Jumbo frame support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788541624.3556271.6428495484921450740.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 21:30:16 +0000
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: wei.fang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 xiaoning.wang@nxp.com, sdf@fomichev.me, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 13:52:05 -0500 you wrote:
> Changes in v7:
>  - replaced #ifdef with if statement per Jakub's suggestion.
> 
> Changes in v6:
>  - address the comments from Frank and Jakub.
>  - only allow changing mtu when the adaptor is not running, simplifying
>    the configuration logic.
> 
> [...]

Here is the summary with links:
  - [v7,net-next,1/6] net: fec: use a member variable for maximum buffer size
    https://git.kernel.org/netdev/net-next/c/ec2a1681ed4f
  - [v7,net-next,2/6] net: fec: add pagepool_order to support variable page size
    https://git.kernel.org/netdev/net-next/c/29e6d5f89e48
  - [v7,net-next,3/6] net: fec: update MAX_FL based on the current MTU
    https://git.kernel.org/netdev/net-next/c/62b5bb7be7bc
  - [v7,net-next,4/6] net: fec: add rx_frame_size to support configurable RX length
    (no matching commit)
  - [v7,net-next,5/6] net: fec: add change_mtu to support dynamic buffer allocation
    (no matching commit)
  - [v7,net-next,6/6] net: fec: enable the Jumbo frame support for i.MX8QM
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



