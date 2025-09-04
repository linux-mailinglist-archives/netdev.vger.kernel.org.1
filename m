Return-Path: <netdev+bounces-219963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09AB43ED1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359D5A430AA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2B3090DD;
	Thu,  4 Sep 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIWRYE8H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE02EE280;
	Thu,  4 Sep 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996203; cv=none; b=PXiL/EVy+V6Dif9tDCP1faux58PizhN0XfQOKxDI0RHZtIh8ffu5p/HV2Sh9lItWg+jJlxegJrcvmBTunxXWZaMbedoLU9xozp9qS3Fg6ImCuOhVLDO5TXiuFP7Mz/gtDlroOniuKyTIPh8sE44DX6xsFMvA2de/rAyOTZBi6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996203; c=relaxed/simple;
	bh=hfqUmxyvWjOpj/ppJISVApfcPDrvyLkYMG+I4BD2WTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awzn0Mxc93Wkdm8AH/qjiP+bs8TF/ROecWXwf0vVWfbQyJrqk6Kxw1DIkpKCOEf1LNnev2R22JWfL/H650wyJCZkKNhgOQjem7s1HBxoKhLn9TGFXbsd0fX/OPSd4Y1AA5oP3vO9aj4GTYm5GOh9kijmhVVqtfKPgfHo4ZD3Btk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIWRYE8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B0DC4CEF0;
	Thu,  4 Sep 2025 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996202;
	bh=hfqUmxyvWjOpj/ppJISVApfcPDrvyLkYMG+I4BD2WTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FIWRYE8H/axj6J2Cb1T1M1s0ntujCp1kvZq9x55Pdv+gOMoJWxQsWQPJiaNsa/yNw
	 9xWzSwxWsq0ASHmR4Gb7HCfot76KT2TQ/jj1zPLFC9TR4VRpG/gYhlv0E1CrS7PnXT
	 qUc4HyMlS05eyUTSJQtLWmchhjANigB/VNlri2BsjLaL0rbCux2om3RCg1lYT4KDfu
	 Bwx0/pppCdvWdPdJsTSlj1X8mcaTYVS9wat0mBC33qBvGpAQVwQAqoZAUnUwCCppwk
	 yAZ7F2SIUm4Ke/r9IKWDA5jV+5tjaovtOvD4hE0XxIbrbHxGWBh+4yr5GhIltHUSUT
	 8CaPbkhhc4sgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2790383BF69;
	Thu,  4 Sep 2025 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: sun4i-emac: add dma support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175699620753.1830074.1985525927961130750.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 14:30:07 +0000
References: <tencent_4E434174E9D516431365413D1B8047C6BB06@qq.com>
In-Reply-To: <tencent_4E434174E9D516431365413D1B8047C6BB06@qq.com>
To: Conley Lee <conleylee@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, wens@csie.org, mripard@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 16:22:38 +0800 you wrote:
> The sun4i EMAC supports DMA for data transmission,
> so it is necessary to add DMA options to the device tree bindings.
> 
> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  .../bindings/net/allwinner,sun4i-a10-emac.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)

Here is the summary with links:
  - dt-bindings: net: sun4i-emac: add dma support
    https://git.kernel.org/netdev/net-next/c/3cd4c4f3955b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



