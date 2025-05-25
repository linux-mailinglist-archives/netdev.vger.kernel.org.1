Return-Path: <netdev+bounces-193267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0108AC35B4
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F6B1891EF3
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99E1EF397;
	Sun, 25 May 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7T/G7zw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAD155C97
	for <netdev@vger.kernel.org>; Sun, 25 May 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748190593; cv=none; b=Rvv7Ykyyx0We6hZrois/Ui/zwSX5MNHNq8tEacFtDBox7XTy+C3zDjMr7ghSbj3b56n7FD8gQmBdZDJ1ZA+mVQMLuArq7n2U0lOcu2RRCYapNzlQpvoyAI7zBQE+Ww8U8n9AQmhn/nRl8iPKNIsVK1UCB7C4N8dsc16y3sd1/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748190593; c=relaxed/simple;
	bh=buKQ91DVa6mfMekbfV41GafTrSLBNM6MUcueVdughRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eykf06e6aYCpH0i1XM86igFQfLYHiDLMEYoB9N+NLa0muimCOonrHPeLoI6bqX0oy3vV+pVlg9bLr78GtuoLVu30QlXYQZWe/9GTv4X8ksmxtKOrjQ8l0QsBZKbBsK9Mo9k9utFJfn/9cjfBWCtY00L0aqUmiBshy6j9nw0Mmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7T/G7zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031A8C4CEEA;
	Sun, 25 May 2025 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748190593;
	bh=buKQ91DVa6mfMekbfV41GafTrSLBNM6MUcueVdughRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p7T/G7zwCDsndiskqcvoaytbaSmt2B+NWbUXhf85yhNnpPLSt9Xqb2WG+z9ELvVSU
	 nKp2nA1Hd209lMJIdorz3BStIlT1XoFgE/XtN9Acajx9k+tCBZbVlz7yU9KyRlMRby
	 D6tshsfLuALmOtJBA0dWI9IG2skNwwm5HESqOOibG1vESbzxnr6tNovHJLXQh2/vwc
	 zdDXxW8ZFSaH2BZFFkLK0qhBpC/JYfh3bMgL6jn1E/rHyLS1fqgrgnudOa8nkpt4hN
	 T+46AKJXHOr7hTI4lYtNG3R0bypyfHX3mELgXtZUchIp3R49udt31xffRXe1++Gj5n
	 9IYg5q8BQoBtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF83380AAFA;
	Sun, 25 May 2025 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: Correct spelling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174819062775.4171016.10242834560334242547.git-patchwork-notify@kernel.org>
Date: Sun, 25 May 2025 16:30:27 +0000
References: <20250520-mtk-spell-v1-1-2b0d5b4a4528@kernel.org>
In-Reply-To: <20250520-mtk-spell-v1-1-2b0d5b4a4528@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 20 May 2025 15:33:33 +0100 you wrote:
> Correct spelling of platforms, various, and initial.
> As flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h | 4 ++--
>  drivers/net/ethernet/mediatek/mtk_wed.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: Correct spelling
    https://git.kernel.org/netdev/net-next/c/d09a8a4ab578

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



