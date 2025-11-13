Return-Path: <netdev+bounces-238178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF08C55623
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DE2334750F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462926CE04;
	Thu, 13 Nov 2025 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8NdlU4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564720F09C
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999836; cv=none; b=DMxmCFiL+9SBtLGvNnjMkFgvfGxBndbZ59wHONpDe8Y+WymdCtZY5J8yqYPEwJu66oHaRCFA493GS3jIUO02XIELxXWXtgIjQY3GU9FWTuspLZD2k85m4LUrl8421iLN5o9NsJ/Tr471A3NzbXpQpp72Zu0Mil5hc5ObvDgA38k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999836; c=relaxed/simple;
	bh=WhC7Tzg1qC6hA86k7FYBABA78aFlt9CZlFsOC9GA/iM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHNDBuSxYLkKQr5rLmoBbDXDey8Bvi+NsCLBmSm2EvD84gX2rv/Md4hKhtZ+njbK9JpiQFOO7Rx9M4NhL7rkguKqfNg9HUgtROLfoX7ip8H+h8oXZL1t3SlrdxcdHDSOH/zJwCeP/LGP/bfJt2f4F6smlThkW3o+dzbz6NQb7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8NdlU4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EC7C4CEF5;
	Thu, 13 Nov 2025 02:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762999836;
	bh=WhC7Tzg1qC6hA86k7FYBABA78aFlt9CZlFsOC9GA/iM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8NdlU4Wc3T4pEYe6shBcK+PCTw9//GTkAEHcllSI4IY6/JuyQ6t8P8ziOn/7bX5g
	 O22ZslU0fNIMke36KXH1sDqq2TV3E+nks6Tta2bS8X4DN7pZkmljO2O6TJ3AW84rWn
	 hsmZhIb2CNNnKCF+i6nQRHeL7+OfRmxf6ecR/8J+6AN2PuFmTvjRFuYt223d/35LOi
	 KnJtA2brM3yU6ypBBMbYQZ3ih12cQw/7WOksshz4zHxjtohd+8i/gP5QEGbExhFIvK
	 DQgJFjiVg343uGf4iqqiT6MMMK2SfNCmrdWUzzbHXNmERiyIc97K7TpNsD6DyYqOm4
	 OpKFzbjb8dOHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFFE3A40FD0;
	Thu, 13 Nov 2025 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: Limit the max number of
 queues
 in procfs_downup_hammer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176299980575.283263.10279512603610923655.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 02:10:05 +0000
References: <20251111225319.3019542-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20251111225319.3019542-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 14:53:19 -0800 you wrote:
> For NICs with a large (1024+) number of queues, this test can cause
> excessive memory fragmentation. This results in OOM errors, and in the
> worst case driver/kernel crashes. We don't need to test with the max number
> of queues, just enough to create a high likelihood of races between
> reconfiguration and stats getting read.
> 
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: Limit the max number of queues in procfs_downup_hammer
    https://git.kernel.org/netdev/net-next/c/f766f8cdde01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



