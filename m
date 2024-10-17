Return-Path: <netdev+bounces-136605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA869A249F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8568B1C25596
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047C1DE4CA;
	Thu, 17 Oct 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfWEeMq4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED161DDA39
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174226; cv=none; b=YxTlgeX7fb7KxEvxxc6TnUBw8DzOqQDZ1SDwVY44FMcsSngNt2b8TFHMPRrwxEpTD56suP1xvedDZO8T3NwpSCWcn6n940N8m2OJE5MPJi9nLOiD1jKKEv04VhAFbldrtxBGdGyoPLSMiAjUMgjmPpBRdY+bE57hzev5uI21UhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174226; c=relaxed/simple;
	bh=48mkEYsKPXARWbX5mxqgcg6pF32D4Igwmby21c8YqX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YVTBIVFttZ37byTQbQyPp+TiQ/SiXJq2vc7sJyeD6sGorSOvFijJBckFAq2jyE+aloao8BRZ6+S2qZwZJdZIOwk7fExgr9kEzH6MCDYz85uVyjPKpaxcPoDTPD6JzFjkVgFdwzj5iAQRTPDFDtH1T1KTARGwGKgKYw9LR5pyUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfWEeMq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F2CC4CEC7;
	Thu, 17 Oct 2024 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174225;
	bh=48mkEYsKPXARWbX5mxqgcg6pF32D4Igwmby21c8YqX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KfWEeMq4dUAF6gIGcBHXLYSg15JyJpouL0uhqF9Ns4CDxk7/DJD6jdtJ2PWgFnx1H
	 o1nptMpIFypeZ2ftAWpcjurYGMmTVbkz8ArYsgeNX3BnTgGczZwh2c41EGWUe6owfJ
	 9fFKlM4pj6eAr0r73pnu6CABC4/2uGzIqkrHXMPzfitaxKPxNEChOfxUMp6s3ftHJp
	 IN26kgd3YtFTBUD9Kpj6ejTYGztSIuv4k08jDXcCnSkTWFwTvjxjldwe5UoOimPY1O
	 rvsZrZai+aLa3JRK7iLapE+0ll1dSsfMjeNeXsL19FuFoLltaihn+ZUzNFQdDH2GrZ
	 phSYId5wyJCYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF03809A8A;
	Thu, 17 Oct 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: merge the drivers for internal
 NBase-T PHY's
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172917423052.2482559.8249995086553964074.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 14:10:30 +0000
References: <c57081a6-811f-4571-ab35-34f4ca6de9af@gmail.com>
In-Reply-To: <c57081a6-811f-4571-ab35-34f4ca6de9af@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 07:47:14 +0200 you wrote:
> The Realtek RTL8125/RTL8126 NBase-T MAC/PHY chips have internal PHY's
> which are register-compatible, at least for the registers we use here.
> So let's use just one PHY driver to support all of them.
> These internal PHY's exist also as external C45 PHY's, but on the
> internal PHY's no access to MMD registers is possible. This can be
> used to differentiate between the internal and external version.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: merge the drivers for internal NBase-T PHY's
    https://git.kernel.org/netdev/net-next/c/f87a17ed3b51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



