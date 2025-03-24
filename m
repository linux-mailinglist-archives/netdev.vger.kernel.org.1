Return-Path: <netdev+bounces-177216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E5A6E4AD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563537A5B73
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2B1E7C24;
	Mon, 24 Mar 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCJ47wN1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231F1E5B9E;
	Mon, 24 Mar 2025 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849408; cv=none; b=RrMD3cV3VfWJp9Vg0/V7PYVF7laElaHdlbWFR/xvybFw/epCalXe2Pd6Uw5TxfRg65lRXfPoBYIwRir1KLQBXtKUN6/xAqkhIiVZ4xJyu+0CAdzaebxZqi3ynnt3KPtWzW1XUT/MwQGpK57RD9zM+bhmQZMA8x6D3xe0S49JkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849408; c=relaxed/simple;
	bh=+ou0UbncUs03M6sufG6N3xTDsMBOOlOxZOY7cw8WuOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcHsJvGJ7DMQU9HbIUJav0AMjEsoZRxMaTJmmGgzOjPHjMq9pjLVPODzponfGVKEceP/qhnLYUvoLhDkGgx03Dc4RDEZ457UL2wwU/8HkApKeYl6US45ColxuX2BoLriNNDaJpEsvIyiQF62NUbexrP7QC1AcDIr/c4BLEddD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCJ47wN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBADEC4CEDD;
	Mon, 24 Mar 2025 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849407;
	bh=+ou0UbncUs03M6sufG6N3xTDsMBOOlOxZOY7cw8WuOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fCJ47wN1+6+QohEGuqVMAAGxKIxnmr77Sz6Lx5TpDQX+4kl3ZcS1W7ZYR/KIoIGWo
	 Qc8FVEBTEFp6FlYB2AD6znBsWXDAaXtUFFk5R3uR+6JkMMmX4g4i4NLr+W2gdhH0Ru
	 NEsIkcdrUlbQnoKgCWLs8vPaqCf3BsqbqniTpdR/N9eD42A+8wwOQf1fMZ7a3JoJZn
	 /s/G3/AYQEorFapa+7V9PwohFTJ7lDuuN6AME9/Pm8+9Tj8LjsK1XguSvqJ6S3cnLB
	 Eh5/USzW7nZ1GAW88iH8WPMX0ThF8XUUcodgNHmIaoOXLE/HoYgrMw1Lz6CS63qFja
	 stHr7WqJHlzLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F0E380664D;
	Mon, 24 Mar 2025 20:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: Call xpcs_config_eee_mult_fact() only
 when xpcs is present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284944375.4167801.10275229682419761555.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 20:50:43 +0000
References: <20250321103502.1303539-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250321103502.1303539-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com, horms@kernel.org,
 alexis.lothore@bootlin.com, alexandre.torgue@foss.st.com,
 mcoquelin.stm32@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 11:35:01 +0100 you wrote:
> Some dwmac variants such as dwmac_socfpga don't use xpcs but lynx_pcs.
> 
> Don't call xpcs_config_eee_mult_fact() in this case, as this causes a
> crash at init :
> 
>  Unable to handle kernel NULL pointer dereference at virtual address 00000039 when write
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: Call xpcs_config_eee_mult_fact() only when xpcs is present
    https://git.kernel.org/netdev/net-next/c/53cd6820f5a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



