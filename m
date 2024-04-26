Return-Path: <netdev+bounces-91506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E98B2E84
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E891C22168
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AB17F7;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRi514n5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947517CD
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096828; cv=none; b=ik3/sofW2j1XfRovZfQPsYDmL0R77kVB8iKJaoB5r18INtkJLbXhRfAyV6cAGsWCemFVsFPLCzL0QApXPc/PCGOHGbjTNfyAi8AmTzzGp4tZNx2z01v7FdHWGdmo+A2RoHPRU8FFNDlz40S+ZRV3S9YBsEzdgUmW4DpCVv7QO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096828; c=relaxed/simple;
	bh=1B0NlGkg11nt5HwTfIFwwHwCE5TAgajwKdRahl1O1Uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mqx7706pRGRK5TuVWR3hwx5mUOpmnUiOVVH3t9mnoJYVj5r5xPvlNrE5VMbm6sWhR47vwrNgqHcrlbFgK7NHpWdae2cSMLOJ3ZZxG/esh7mSHlZiucGp9GRCpkXzJEcMhLlg162pDBsMzdbPj2LbGEgMONtBM6hjbFGLdJ2T9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRi514n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51E23C3277B;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714096828;
	bh=1B0NlGkg11nt5HwTfIFwwHwCE5TAgajwKdRahl1O1Uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRi514n5tec7uy+kw10Z74UUvRrDmrQxiQxMJxhqh8phZNAlpec3Ld+CM9F/ejw4b
	 jWpvU8+ou4n8fvNMP5sBhLAg5XUJp22Gco+W4prTwTRXWQcrzpriYgwT7uzOL6SSPA
	 6si05Pj92XxJ75NJiKC3NUHS3uIIDmCqFDXHxPWVTgj67Vw2srsowcWX5BR61yux5E
	 129O4WPQ5wVNOdk5oHwmVVfgusDiWc+8QvHEdFJPd5aLM4AcTrLgKLR01r+T1WZSdT
	 /seZYiDe7FHdOPNt1XjBmlnl3zHoaySrorKGeK2bWZ9bKIFlymCFTF4ktSAZC3o7ue
	 Pvhc4mTqOM6RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42BE7CF21C2;
	Fri, 26 Apr 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409682826.30663.9138924383243420845.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:00:28 +0000
References: <20240423090025.29231-1-kabel@kernel.org>
In-Reply-To: <20240423090025.29231-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, daniel@makrotopia.org,
 andrew@lunn.ch, hkallweit1@gmail.com, pepe.schlehofer@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 11:00:25 +0200 you wrote:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> Add quirk for ATS SFP-GE-T 1000Base-TX module.
> 
> This copper module comes with broken TX_FAULT indicator which must be
> ignored for it to work.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module
    https://git.kernel.org/netdev/net-next/c/0805d67bc0ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



