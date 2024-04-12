Return-Path: <netdev+bounces-87338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A947A8A2BFE
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F53C1F22701
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E40535B7;
	Fri, 12 Apr 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWh1RPrj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B253384
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916635; cv=none; b=QF1ps2xJWHtPlqOoJkiFcm1Y4x3vTD/NtcwPXv+oTlMQISpeROIAIHL2/ghiZS95KA3yiqSDKTSc2F/PiDyjCaUDHGgxDQWefmHjdojS47M6Otp62ZxPhY7p9uPULi0ti0UVSEhRZJjYL4Pwi3vdDU9J2v5TpkVIXaR5QVnMpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916635; c=relaxed/simple;
	bh=1h6hVrQOLP7BunZWYLycwOgzqnnoIKhsdNjhsMpNJ9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GK85q+Jln1DznxO2gTPTyNVBvvPEuvWXEOEUoR0PKcXJcAGB5vE44xd8bGgm3jvGIvDF1QHkfQjCIiyowWJaDtgHRk3hEgcH8wKMqMqCDlqx14zoysPVvhj2XkAZTJisoy3FffJw/401ZMJbfXvi3M8p77bOLGraZOdx/CqklJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWh1RPrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EE9DC113CD;
	Fri, 12 Apr 2024 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712916635;
	bh=1h6hVrQOLP7BunZWYLycwOgzqnnoIKhsdNjhsMpNJ9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWh1RPrjW0ZJwd20IM2VrMG0XSOL9ajEiawxFmxIc/6tPP/WQ+Jz46IKC+pmx773E
	 PsrRQQzqoxJNrx8PZRPageqBpHxas/8HYsqGWdJPwpYq4I6vYd0Bci2tA5mUPow56n
	 TxMGBjx4HhywTGwOSAnnZUmHF/9cxn+cfai2fAANy+9QY7zgGM3WzNGg4zeY+aqs+f
	 pivnW6Nn6hkl3gtDM/ODJTlnTUwo6gd1vmIMzGx7EOBpn04p3PhOWda+xlnehEgn5d
	 lmVs33IiSJBgBaGyudoT01xNwjIdscPgHEkx2tGjV1jEYeYx7CojeHE/D/udF6M4dV
	 f5s5YZeXBLAwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10B88DF7855;
	Fri, 12 Apr 2024 10:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tcp: increase the default TCP scaling ratio
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171291663506.22467.14336127401186077552.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 10:10:35 +0000
References: <20240409164355.1721078-1-hli@netflix.com>
In-Reply-To: <20240409164355.1721078-1-hli@netflix.com>
To: Hechao Li <hli@netflix.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, soheil@google.com, netdev@vger.kernel.org,
 tycho@tycho.pizza

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 Apr 2024 09:43:55 -0700 you wrote:
> After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
> we noticed an application-level timeout due to reduced throughput.
> 
> Before the commit, for a client that sets SO_RCVBUF to 65k, it takes
> around 22 seconds to transfer 10M data. After the commit, it takes 40
> seconds. Because our application has a 30-second timeout, this
> regression broke the application.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: increase the default TCP scaling ratio
    https://git.kernel.org/netdev/net-next/c/697a6c8cec03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



