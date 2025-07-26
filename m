Return-Path: <netdev+bounces-210312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18FB12BE5
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2C7179353
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4A28A1D7;
	Sat, 26 Jul 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTQaIJPs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3928A1D2;
	Sat, 26 Jul 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555211; cv=none; b=YuRpnAWlaRqPS7RtYvgb2p5yjspC1g0GZqYvGjj26qglI9WzxuUDYdvhuPrMF/HEE6h116d4Nu4W3t5w5HS1CdYkjQmJBbv+IktxyaVqpyvoeRKb7wCKHx4hrShJDFA8kI4QJKM6X12dspuXodgRhx6hS4SnC+2E5eYcTyoYHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555211; c=relaxed/simple;
	bh=jvrPGKTUvVArH86W4xWz6q6UsG6SrpfAbNFhpLXMRh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FcSG2/xufbU5WtLFd1QRKahC8ziKwVwl/Hq0eeTLX/L3Vy0hHwpaSJKTUT2Ve2MrijfZdvhL8L4OtTV81QGjfCamobtEzL/8WJkwlPlo0ciPthT97LOzIL9+8zuPzMmhp4gBMicSGjh8oG7VcqnCPOILnEnvqf99+c4XcR7JKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTQaIJPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE597C4CEF1;
	Sat, 26 Jul 2025 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555211;
	bh=jvrPGKTUvVArH86W4xWz6q6UsG6SrpfAbNFhpLXMRh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dTQaIJPs2JDAsnYExKnzPuYISsk8TGEhp2RmehaZA8ajZK5gVdkCPpHe6VKFMC/NA
	 8690unpEvrmj2jBgoHxwg2UF9VCIUa6ZgmA0qpzDOV9BbeWw1auj3ZpHnyIxmSMtv3
	 nzoTla48J5TmHDsIEb1KZ1NOFaTdWGbKsa8hlLQtbt9768kuWbGR/tIARl8O9OFn28
	 d4a6O9rDe/vUGsKH/rymAm0LXm8cdrKMBUwP5+1n2LcPRdrsgL+F3NXmfB6DohnobX
	 nP5NXGl2O6gdaAl4py5DRZb1pNCSLLNTNiHdPsiZrrUvRk+atVd+qZpe6dKsWyKIn7
	 DagiwiDzGTgpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8B383BF4E;
	Sat, 26 Jul 2025 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: fsl_pq_mdio: use dev_err_probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355522800.3664802.5999368346638667870.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:28 +0000
References: <20250725055615.259945-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250725055615.259945-1-alexander.stein@ew.tq-group.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 07:56:13 +0200 you wrote:
> Silence deferred probes using dev_err_probe(). This can happen when
> the ethernet PHY uses an IRQ line attached to a i2c GPIO expander. If the
> i2c bus is not yet ready, a probe deferral can occur.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/net/ethernet/freescale/fsl_pq_mdio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/1] net: fsl_pq_mdio: use dev_err_probe
    https://git.kernel.org/netdev/net-next/c/5737383faea3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



