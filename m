Return-Path: <netdev+bounces-198285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC2ADBCA2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9792D1734C0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BA225408;
	Mon, 16 Jun 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbgP+hzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B5224B05
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111809; cv=none; b=HCnqH1gh1FztosTeclKfNGUn1Qxaqro5XS87de0eYJH/G5u8M+GUQAZq3XU5UwTnVnCkeo7R7QlAYloxNKF8Q9Zea7R7UsAAK48UwYAneDVHPJ5W4XQiuOMTqYY0GJ/QDhgSA8tq6HyMP0cPSPeDqLliJGX9tgo2pmgDueXLKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111809; c=relaxed/simple;
	bh=BMyJEqIXakUu8Q/coxq6kmO0L2hveQX8mNILFSh4PbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EFwIOOqDPfTI3Z+JBVMFIO7s2FtHkaK2Wi/F1TNXYPdMfofl7w0mtAHXsGNNIzTRdJGdQx1IRkqBgx58zaMbZjY3ScC14E24XWkxRtZqP68xnMHwQ8GnoW/BzAoOGaKJicjsDPxbDWIdv0jyRvrrSoV0UG1SYse19QCxoAt/jzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbgP+hzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD9C4CEEE;
	Mon, 16 Jun 2025 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111809;
	bh=BMyJEqIXakUu8Q/coxq6kmO0L2hveQX8mNILFSh4PbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jbgP+hzOemklZH/U/OZ92sg+8eipjkq6+P+29+RCAk8JWiX9BkK75uXwPSY7uj4wm
	 FzuRjW85xJhtppKC7oGCqEkh0nPq8bNX86HjvnZVxRZU+gaQGx3JEcfZSvxmLDS/Qt
	 Q7Jtt0jD9aPsKR6NGRee0/kwUhuokf6NYT6gcD8u4QZoZfV29/4n+W3N5tJzu4Lz4v
	 xvF9RlyTRdIuRGBNWOheZ3UAw/FGvvOUgv99QCxxBioU+GiBXun02mO1L+z9kp1M3f
	 gHzUnN2lEq06LnJKAPbENWAqM7U579ZRG5QFaBcmQEo0rI+fbU7HOLta5x836fXUWf
	 RFx5fHfEOBeYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6A38111D8;
	Mon, 16 Jun 2025 22:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove pcs_get_adv_lp() support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011183824.2530350.4880030632930663714.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:10:38 +0000
References: <E1uPkbT-004EyG-OQ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uPkbT-004EyG-OQ@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 17:16:35 +0100 you wrote:
> It appears that the GMAC_ANE_ADV and GMAC_ANE_LPA registers are only
> available for TBI and RTBI PHY interfaces. In commit 482b3c3ba757
> ("net: stmmac: Drop TBI/RTBI PCS flags") support for these was dropped,
> and thus it no longer makes sense to access these registers.
> 
> Remove the *_get_adv_lp() functions, and the now redundant struct
> rgmii_adv and STMMAC_PCS_* definitions.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: remove pcs_get_adv_lp() support
    https://git.kernel.org/netdev/net-next/c/883af78926c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



