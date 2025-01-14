Return-Path: <netdev+bounces-157964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE4A0FF36
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47481887F41
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD4233524;
	Tue, 14 Jan 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnSWgNeg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242A231A4C;
	Tue, 14 Jan 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825423; cv=none; b=WiLnhTZyMN7mbHKLAgiCqyT3s8m5QmENZdsmXW9UPiHK8euVLNpVZRtgQG4oPQ75BkhMMqGT6XtKeDCKYg8Bp2uKiw9P7lsFhLdqwfseKLfcsRvkYkz3PCvklbl7uxLlZH/loS/QxL5qKrAKTgci74GJwKDV+PdtzP369uTKOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825423; c=relaxed/simple;
	bh=m1AUXznxW/r7RpgC0yJzNyqk0JjitqV65Xxqie244Ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hhDmsBuu6RdnF/aFGlyz3vTds1ndtdY59ipzYx1bSX6NejsIpZZcYs6JxumVyCtZkLg6o7I2DJXSFLiTDfhIZrr8LoCh2MIXP7iKtZ6aAAg10KAU525CorRKA95XfaPmaenEl02ZOdrzCglM5aWofykL9c5BlO+yr6mUrlsgu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnSWgNeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ED3C4CEDF;
	Tue, 14 Jan 2025 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825423;
	bh=m1AUXznxW/r7RpgC0yJzNyqk0JjitqV65Xxqie244Ic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PnSWgNegHMhk7SUXrPAQNEko41g5drV5Gx/0wEorpi13+V6fWJSllR3LbGCILmtna
	 X+8d1b0Ap/YatKfYeOqOtdHgrk+wb/C932YAMZF3/mMymylTxiqctt14ene+caO35M
	 t2M5LYusXjxx7+0/9sp4im05Ct63nI53uLjYprz4IpcxG212je8KiRzM9jqqAtykUW
	 Tyl32a8P84Qbp7Q/F07VbLJ3var5jtXSvOKS9etQ/c85wM0jiFJ5hzaMmpd8u0v+7+
	 s5uJZ6rqSsJargJIdKwVSu8+6jYh+sQHc8Xmpo5II9eQ4jZhUYyDlTfz+YbLsgHXVm
	 KlUvUhseTJ7Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CDE380AA5F;
	Tue, 14 Jan 2025 03:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: remove init_dummy_netdev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682544574.3721274.3029516655477525168.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:30:45 +0000
References: <20250113003456.3904110-1-kuba@kernel.org>
In-Reply-To: <20250113003456.3904110-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jan 2025 16:34:55 -0800 you wrote:
> init_dummy_netdev() can initialize statically declared or embedded
> net_devices. Such netdevs did not come from alloc_netdev_mqs().
> After recent work by Breno, there are the only two cases where
> we have do that.
> 
> Switch those cases to alloc_netdev_mqs() and delete init_dummy_netdev().
> Dealing with static netdevs is not worth the maintenance burden.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: remove init_dummy_netdev()
    https://git.kernel.org/netdev/net-next/c/f835bdae7167
  - [net-next,v2,2/2] net: cleanup init_dummy_netdev_core()
    https://git.kernel.org/netdev/net-next/c/37adf101f6f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



