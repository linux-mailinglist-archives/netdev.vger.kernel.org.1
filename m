Return-Path: <netdev+bounces-167130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BFA38FEE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4600218922A6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95418E20;
	Tue, 18 Feb 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im1MYjQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DF182CD;
	Tue, 18 Feb 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838603; cv=none; b=rV53QWZ3vFEjBTF7FV/t+sK6gAx2aRGUkA3+H78HCzts5OYrexnRC0hDGjqvqGA/G/4WNqv6SNXcfsbmid6WRRyt9IgVzK0jvnLB+0i55aUwqHTyBUKHiBEQ52Sn7KCKMUCkPs7in+IdLOX9RjfHTAY97AaqiCcw/2FIRk4EzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838603; c=relaxed/simple;
	bh=d6CWwgW19OdA/2Ji7FIZ+CWAq2AbqXRMXAygzlW8J8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZHdJKbHc1pBa7BTc9/kMaAtICoTqOAhPoot9CRSOmJOLbPcOup5AUVueBqxFEhw1NcFYw/62Kqbfwb1hIDTnhyglmBO81rJaKyNoQGbAcJWxZtouy6ek5pi+1F6ugYHIyeKYhj1oh4beqQLUUrjswIcJ+K+PcAQ51NNHBmn3X1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im1MYjQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14468C4CEE7;
	Tue, 18 Feb 2025 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739838603;
	bh=d6CWwgW19OdA/2Ji7FIZ+CWAq2AbqXRMXAygzlW8J8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=im1MYjQmyAtO7fQn6VjXNUjFYQ2QhbuAivdMVXl8TI6fAuzwPmTvY1YkeeHwlgB/c
	 QuN/Nczrc8peJ69yW5gtJao/krpdVfDSlpnQEthZFteXbwHm0mSfh9AJ59JzkpoiMt
	 vo9V8v9KtMdzqrJ/KU3/z4jAFRQlRRkh6GyCuSDX0bI4N8XPUzfYu4RRb2f7fiOQ/r
	 34SBT+FKp/l0lMatdaLGO3duX0GYFAbeCn5W44eLD3DbSpY5bw6/yREIgPUh8PJx8h
	 hKPDBTjOZUilbI13iyncqNj5xtOT8HOd2Ey5/o4PdS7ESduFpAVYmjbOs1r8dOMKO1
	 SnIRucQI2Chww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71762380CEE2;
	Tue, 18 Feb 2025 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: phy: mediatek: Add token-ring helper
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173983863299.3581223.1664796707026603430.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 00:30:32 +0000
References: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
To: =?utf-8?b?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSA8c2t5bGFrZS5odWFuZ0BtZWRpYXRl?=@codeaurora.org,
	=?utf-8?b?ay5jb20+?=@codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Steven.Liu@mediatek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 16:05:48 +0800 you wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> This patchset add token-ring helper functions and moves some macros from
> mtk-ge.c into mtk-phy-lib.c.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: phy: mediatek: Change to more meaningful macros
    https://git.kernel.org/netdev/net-next/c/2f435137a048
  - [net-next,v2,2/5] net: phy: mediatek: Add token ring access helper functions in mtk-phy-lib
    https://git.kernel.org/netdev/net-next/c/afa08fde7c47
  - [net-next,v2,3/5] net: phy: mediatek: Add token ring set bit operation support
    https://git.kernel.org/netdev/net-next/c/40d33d6d3c90
  - [net-next,v2,4/5] net: phy: mediatek: Add token ring clear bit operation support
    https://git.kernel.org/netdev/net-next/c/4786eff288bc
  - [net-next,v2,5/5] net: phy: mediatek: Move some macros to phy-lib for later use
    https://git.kernel.org/netdev/net-next/c/be378ebd6cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



