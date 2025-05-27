Return-Path: <netdev+bounces-193568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A477AAC486E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8063A35F2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932CC1F09B2;
	Tue, 27 May 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgxTFf4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEC1E51E1;
	Tue, 27 May 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748327394; cv=none; b=ZzIXJ3At6x8UWVrwNRkcyO3WhlE7H/dWQ0zmbYYic7gc9GZ65ZDahX3P33qJruyyr+NBd307fs4FnaAWojZkquSCv6lZb3X4Fk1x7o9gqgGTklNmjnvfkEoxy6mFtnFzbEJ8t/0AiD3049c32zor0polDvW3rkDqdihIoLx1QeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748327394; c=relaxed/simple;
	bh=j4lf4jCkvu/xgxJtOXNOG+vFtHlCvFWj59WF2/DGwE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PhhwCZvrwtq5rMKTdvuUe7590u3l0VCKRsU24NIjhsNdvJ5Rdg0xEiQ3d/Up0qhD5klCMoAm75GQVTf/whZ4OzHryiptpP7GV+RSPAuR5z3O4w3OZIcrrkPW2TybTdVnYkkLpY//Ct7EQIOQGIH64bTV2RZvABxJYMJfmfhpbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgxTFf4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB132C4CEEA;
	Tue, 27 May 2025 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748327393;
	bh=j4lf4jCkvu/xgxJtOXNOG+vFtHlCvFWj59WF2/DGwE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fgxTFf4W2QKNuqEjxCZ3vcDQAw/YlAyIkEETdinVLn5hAC+S4UYByDJzMWqTNpUFu
	 vg3mKo51V7fF3DHIBIsNyRFeVY4Q4bbNQIplJkducPOFAESJvadUwLePt1nqm+2EgX
	 x5HNjW7joxvPwUQ2qI1uwqhm5SCydOzUOnVLbuzduHnw9klu6cSjK6WQDZauAvZwtn
	 3IOhN8F5OM9WTbQTYRjBLM4ttWtgc97es8KLXA/cu6zGF53g9rgw27QCrlcZEQCWIH
	 Bhhs2dGayCsY1P5Bx5gtCW0tuwFZ3rQEfU+PdxUTCHGOAJyausFp0BGyDvDrD5lmu+
	 kdkdXy/IEs0iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF7380AAE2;
	Tue, 27 May 2025 06:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: xilinx: axienet: Fix Tx skb circular buffer
 occupancy check in dmaengine xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174832742825.1178251.17763156769981181807.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 06:30:28 +0000
References: <20250521181608.669554-1-suraj.gupta2@amd.com>
In-Reply-To: <20250521181608.669554-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 sean.anderson@linux.dev, radhey.shyam.pandey@amd.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 23:46:08 +0530 you wrote:
> In Dmaengine flow, driver maintains struct skbuf_dma_descriptor rings each
> element of which corresponds to a skb. In Tx datapath, compare available
> space in skb ring with number of skbs instead of skb fragments.
> Replace x * (MAX_SKB_FRAGS) in netif_txq_completed_wake() and
> netif_txq_maybe_stop() with x * (1 skb) to fix the comparison.
> 
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] net: xilinx: axienet: Fix Tx skb circular buffer occupancy check in dmaengine xmit
    https://git.kernel.org/netdev/net/c/32374234ab01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



