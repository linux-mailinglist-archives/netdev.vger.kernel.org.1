Return-Path: <netdev+bounces-249192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B2D155F8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D653D3029553
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B1A364036;
	Mon, 12 Jan 2026 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1BpcZu0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77814341642
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251673; cv=none; b=pW0AIZAO18ZNmJRFV2VsbI0xC/MfDNak/jBSWOMlbR0c+DaNSt+gLXo1Sg16q76a/B/89A475qzRnq3VHc1fjbJlMRcI+xalaGzWn0nwUE4+0dSre4u0vLL2yPG4PKiV5E4BjRi/FfVvwmEItXvVwIG3i8lT5L2wXDaJnpR5O1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251673; c=relaxed/simple;
	bh=scsPQpuTFl0Eannt7keu6YNXFL4J15YDV4qWU3+o+ew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=McrgwYZ5Pcc9dSRiQqXe48xtdIVv5/dW65/VSqoUWTCegxi9z0LzqPkMZgcslpalYYp+lHpPNkMQgNyPIKHHp+X0IfBc1EedEjmBuQJe6+QR63gqUA+JcTogb9qjidwMQdAyTalkFink3mf+AglxccEH0rNKuVocCzKtNPUiUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1BpcZu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C976C19422;
	Mon, 12 Jan 2026 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251673;
	bh=scsPQpuTFl0Eannt7keu6YNXFL4J15YDV4qWU3+o+ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a1BpcZu0SO1HfRdUAmYgmqX8P7QQLHJFxAXVcku1J3jc25uYziwklOTPH3q/uBW0+
	 /bxpx1RMDXjSX9cpo97ixIumrLkiMyLeeU65xgZq//FRiCiOMfZgbR6qeht5CX+SOv
	 vBWml3tGKTgWB6YpDLKd/s7/Xq9GKEBRU2I5nWlIxV9IEky7oaG9uBUWRAtaHUvyyg
	 1e02kakJGVHGtIJmnxewIJRYP9PkUMOVOXdUosMTNeBNnPlfY/bQoakEgOYLBmUB7h
	 QhJsW7hYriHwHQEWP57m2x8oWfWiRdvIkLJnHDMhV7e/1Zr3rcZYpa9fgBMbWQGX79
	 GeNlRRLGXbuOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787EE380CFD5;
	Mon, 12 Jan 2026 20:57:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: parametrise iou-zcrx.py with
 ksft_variants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825146703.1092878.2826169412101289918.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:47 +0000
References: <20260108234521.3619621-1-dw@davidwei.uk>
In-Reply-To: <20260108234521.3619621-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jdamato@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 15:45:21 -0800 you wrote:
> Use ksft_variants to parametrise tests in iou-zcrx.py to either use
> single queues or RSS contexts, reducing duplication.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/hw/iou-zcrx.py      | 162 ++++++++----------
>  1 file changed, 73 insertions(+), 89 deletions(-)

Here is the summary with links:
  - [net-next] selftests/net: parametrise iou-zcrx.py with ksft_variants
    https://git.kernel.org/netdev/net-next/c/de7c600e2d5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



