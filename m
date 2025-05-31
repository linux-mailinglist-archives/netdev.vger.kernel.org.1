Return-Path: <netdev+bounces-194464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59EAC9951
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 07:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454BD1BA40D1
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 05:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8428D841;
	Sat, 31 May 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChbudPE6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAC28CF59;
	Sat, 31 May 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668213; cv=none; b=uROFDq+kesNM7LPv3MM+13z9lbUHMKpjEemYMFRoY3d526182eMLpasLL3UBenL51rERvZURpl7D8X5JIETSdb6OD/HO8ryN2TUS54QvOo40kH9xKi9KRmCqJl8ICd8PaVoZDY4+prKeTTPtPMzCPnvhd8LQwU1q3xs6o17NWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668213; c=relaxed/simple;
	bh=uL+BKZu6kDrl8m5sy72o33sP2MBjksLZumY0/hHgMps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hG0IonEbazqO4IJO6E86yjhBAfUWCaeho6zOEhiMYLdXAUVS6y2Ft8L6z3BjD5fBxjObxqetc1cyDBI5Wla8M70tp5tGG8LaDdGLSPyrGyRCZ8HThZTKrg37nXr229KAlidDTTCuWS1QvZ/NrwYBvH+mEnIc8Lno57uWt5sN6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChbudPE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70119C4CEE3;
	Sat, 31 May 2025 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748668213;
	bh=uL+BKZu6kDrl8m5sy72o33sP2MBjksLZumY0/hHgMps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ChbudPE6kmY4/3YOEolvt7DlvOHxpw6Tt6E9jnB8i0Lb7bhRG15EJiN9qjaVSskzh
	 rshvnh2rjKhodkAhJKN7McTm5buTU9yh+2JzQoP0AaNwzR+cyp4BcUF+hH9PQJC2a+
	 kO7iXg21mW+k/4NQ364m2fi+lZr9qUg9ExlnC5PeFnnlSptnqS91d8Yzs9pt/YktAG
	 zd71IWbc5keU8SImNDd0am3g4HwepyowevzjB7W05wj0b0qfvC5Wxvih8myur58VGy
	 IZWtD2ZPSg+FdSAr9RtB33SyX/KUVXXMKm4kGmjgyEvzBZ1z81ecVgK/CH/DMYqAh5
	 9ACVpTobtCgdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB09D39F1DF3;
	Sat, 31 May 2025 05:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] net: stmmac: prevent div by 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174866824674.44670.9404709509125224265.git-patchwork-notify@kernel.org>
Date: Sat, 31 May 2025 05:10:46 +0000
References: <20250529-stmmac_tstamp_div-v4-0-d73340a794d5@bootlin.com>
In-Reply-To: <20250529-stmmac_tstamp_div-v4-0-d73340a794d5@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com, preid@electromag.com.au,
 thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jose.Abreu@synopsys.com, si.yanteng@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 May 2025 11:07:22 +0200 you wrote:
> Hello,
> this small series aims to fix a small splat I am observing on a STM32MP157
> platform at boot (see commit 1) due to a division by 0.
> There is no functional change in this revision, this has just been
> rebased on top of net/main.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [v4,1/2] net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping
    https://git.kernel.org/netdev/net/c/030ce919e114
  - [v4,2/2] net: stmmac: make sure that ptp_rate is not 0 before configuring EST
    https://git.kernel.org/netdev/net/c/cbefe2ffa778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



