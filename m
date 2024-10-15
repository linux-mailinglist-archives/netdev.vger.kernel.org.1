Return-Path: <netdev+bounces-135390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693E99DB07
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3AB1C2105A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F7137930;
	Tue, 15 Oct 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpUutky2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AF82890;
	Tue, 15 Oct 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954029; cv=none; b=oDA8FUgWXo9QKEZSuAPy6ZH/u1WuvloSqUZc7QkeE+Aij43m2IkSuv1dIlIhhKvuABLi/cVCoormfDhvzDsveD/vBREo4eCqMiyCOLkVByV+flS+Hg8/QI+mO80BKgO1a6LyIITbJRZ5NQY4CHkwFaqZdMzFMBgPEjDF5bL2B/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954029; c=relaxed/simple;
	bh=42wffo6qGa2SWLlTs+IerfpB4RLgbVUVGQLnBJr2Qoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uhs+LIUo4GS1KrnkZ9sq6+jv7DI2djKzz1Kkcg/m+SMReOSuyEsBLxaVSAaavQgW73itm9alL40LbrT/G57/WSuQOy2AsPBOxoSEg2jMcS0U1J16DBRYQ2wtcxWBgBplof3ZaXnn3BVS2nuWl/tHGevkOHlo41bpvnFxrfgHWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpUutky2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC55DC4CEC3;
	Tue, 15 Oct 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954028;
	bh=42wffo6qGa2SWLlTs+IerfpB4RLgbVUVGQLnBJr2Qoc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BpUutky2Wgt1KPEFOhWFvqcd2k1tIWvnitpSnYhaUCt9yCC8x8Wm33ohzPG0l2eE3
	 vSyzJVGv4lEpRgUkDhKBOspYh3yQSI+k3H2IYfNvBWXDp5uX7bjpEnJwFBXShGnziw
	 d6uE33iiiSnp+YQlhsCuuzYdBETuoFmuEJ5SBrHpFLMmEXARaAu9COZjYuhYAN5jNf
	 gjIsscgPt+BAfKWgm3I5Sd8YUywBrS17XXnKCAGsFuy08gF7/+K0/9ze9z3Lr5Wdtd
	 ab2dWu2pZoWNxB8OK7eQmOharA3pqH/NzBaW+H9Xs9ytXb6KEDYOAGTvk+I1q6IS1A
	 YeXHI5OPPE/Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2B3822E4C;
	Tue, 15 Oct 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phylink: allow half-duplex modes with
 RATE_MATCH_PAUSE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895403399.684316.9071978412353184742.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:00:33 +0000
References: <b157c0c289cfba024039a96e635d037f9d946745.1728617993.git.daniel@makrotopia.org>
In-Reply-To: <b157c0c289cfba024039a96e635d037f9d946745.1728617993.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 04:40:39 +0100 you wrote:
> PHYs performing rate-matching using MAC-side flow-control always
> perform duplex-matching as well in case they are supporting
> half-duplex modes at all.
> No longer remove half-duplex modes from their capabilities.
> 
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phylink: allow half-duplex modes with RATE_MATCH_PAUSE
    https://git.kernel.org/netdev/net-next/c/ff1585e97139

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



