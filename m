Return-Path: <netdev+bounces-177220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25719A6E4D9
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C0D16E062
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075A1DF72C;
	Mon, 24 Mar 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzXj/fhd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF41DEFD7;
	Mon, 24 Mar 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849999; cv=none; b=jBUoLcpnmh2T2ptZia+kqFtK+j+B5nDbhyyQtdfhI3mOsKP1RWYBUAbLBFbIGL1/1vQIY1YnwG9UXTvxqA/80Z2hmV5RCduAhz2Eez30mkxKjfClOgr15A2lkUvDmcLMMZ4l1isPUGCwEd4Qilu8YaEwtzU4aOXUPWtW1HyGRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849999; c=relaxed/simple;
	bh=GGMBDJY6SvgbvByr7GollhePLTL/SiptTTpr/p1Y/fY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LpqyNfI3uwzyS+2beIOm9iitIikRrjoC4pVhhF00t8+lvTMxp6AyNqRnsBQ4GpSidB6SHyczozHhcuYAftVIJxxurrhAo4hFAygY8Q9QaDwd/TQU2YrqTwY50a2Xd+hGCIBsHRA8cAYndj9r7X7BoxXnEeIJa2gaGI8gmXkfxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzXj/fhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87DDC4CEE4;
	Mon, 24 Mar 2025 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849998;
	bh=GGMBDJY6SvgbvByr7GollhePLTL/SiptTTpr/p1Y/fY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UzXj/fhdGjGTQ8aAPOjcdmUEo7GwgExwEGcw2oxdTtyJn0o7b09993Q6MRn+47Oh5
	 jV7JqViL9sOIG9ew9Md2SuaVz0fS7bgb8XENZU4CcfcPV3k+5ciOlCOxwvokJafuTU
	 s5jSokhCg8N64eP5muYmdOeROc0yv+yoRZ4sKucwDWCFrMGIuZNtr80R44SiQsZ8Ke
	 o9DOQg3Vp1lj8thBCSOhez4wnhjOjucLsA4opAwb3eVfPoePlkA9i8LRsDFd6zB418
	 Wk6YrsTy+sSiCVtA8k+0twGuJxBNFikesBaLnC3s4Sl91D5c5L/s0oiYaVR8Y9Ds7s
	 phC5975mYhouw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38101380664D;
	Mon, 24 Mar 2025 21:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] net: phy: fixed_phy: transition to the faux device
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285003475.4171308.4781336832128708063.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 21:00:34 +0000
References: <20250319135209.2734594-1-sudeep.holla@arm.com>
In-Reply-To: <20250319135209.2734594-1-sudeep.holla@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 gregkh@linuxfoundation.org, andrew@lunn.ch, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 13:52:09 +0000 you wrote:
> The net fixed phy driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the device to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will get rid of the fake platform device.
> 
> [...]

Here is the summary with links:
  - [RESEND] net: phy: fixed_phy: transition to the faux device interface
    https://git.kernel.org/netdev/net-next/c/c4ebde35085e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



