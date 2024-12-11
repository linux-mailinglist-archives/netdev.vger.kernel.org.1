Return-Path: <netdev+bounces-150935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD39EC21F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE61B283BC5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADC1FCCE7;
	Wed, 11 Dec 2024 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo8Ha9AM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2F1FC7F7;
	Wed, 11 Dec 2024 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884222; cv=none; b=FPXGtDtsdXJyBF1gMvDVmzNb5auzGocWZiuwEbaVVEHO+DmYPZA/2eGT7MOYCxMOvFxMdHpiiDx6LF5d+iMDpMOQns8ksf317/dy/4iBa5QNEyH/c1vltb1Yd/huWESgIjtxNQ9XnlUR0Pnfb7Ld6EE/L8kvyAEf/5k2nz50+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884222; c=relaxed/simple;
	bh=y9rtjkxbnTlOCutyUOOiDTGb+6al6ycCqwU8ocBVdzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TDu4JqJz7RmSVbUve4OqfH1tAwlWPmxawp4m2GWuwBjk2aCXDL0sSaeXK6wpNrpDyccJ0pnsRQBhFHOJ215Sk8ofQGyoKfO2gNzlVVuac+Wp6d92W2QswXc/Td4UcqcJtRfw16t2kHjfc6h1LIBliT2Cf0xpEsyv8w9MK6dKWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo8Ha9AM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53049C4CEDD;
	Wed, 11 Dec 2024 02:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884222;
	bh=y9rtjkxbnTlOCutyUOOiDTGb+6al6ycCqwU8ocBVdzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uo8Ha9AM7fvVhmBPtoowkrzIhRuXaYM05R4DUeirANT5z9tJBiJgkIWHpBOLmXU2K
	 4Uhz1imZ8YTs3Ip84tPWSy1NZmv0M5RxR9mnrr+cDlACWhO/gU4xPa6Of0GCCC1s0q
	 MA25s6i/Ih1CQeRngG+NG6KK7uYS4wWJn1KlSkSg8t4rMNLjug75pOfbi0PWgLL+pW
	 TnaMxE3wTYlhcNfcg360nQgR1xz8olgjJBKqFA38Z7bw/8uC56WGpMeu9PgzOPuQ8F
	 sk2DH2PJeH6o6gXtvgzYi11AKsQHa2EeY8on1XMHbDtB6PEvnDOYhzhouddFsyGzrb
	 jjtozLougI9dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E08380A954;
	Wed, 11 Dec 2024 02:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: stmmac: Relocate extern declarations in
 common.h and hwif.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388423806.1090195.16162842583087657883.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:30:38 +0000
References: <20241208070202.203931-1-0x1207@gmail.com>
In-Reply-To: <20241208070202.203931-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com, rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Dec 2024 15:02:02 +0800 you wrote:
> The extern declarations should be in a header file that corresponds to
> their definition, move these extern declarations to its header file.
> Some of them have nowhere to go, so move them to hwif.h since they are
> referenced in hwif.c only.
> 
> dwmac100_* dwmac1000_* dwmac4_* dwmac410_* dwmac510_* stay in hwif.h,
> otherwise you will be flooded with name conflicts from dwmac100.h,
> dwmac1000.h and dwmac4.h if hwif.c try to #include these .h files.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: stmmac: Relocate extern declarations in common.h and hwif.h
    https://git.kernel.org/netdev/net-next/c/46afe345ff18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



