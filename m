Return-Path: <netdev+bounces-185334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3695A99C94
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFBA19406A7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A019A;
	Thu, 24 Apr 2025 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRSK+CAu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC2E552
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453406; cv=none; b=kDyn0PDQ1KQ7KJVrBN0/wUQz++spTkTKvDQrTq4+DwGNGI+vnlD16NRf6F5INWWm+N1X4Bg7t/ewZboqxf2JeQdMvNTvz4q18EsAOn9jvIp1/73Qe8v4Zoae6AKtV6WxkqlCR/zVwXtkyYSiA9V2wPPZZU8tDRmrhM7hpcu/fkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453406; c=relaxed/simple;
	bh=LIcJuKcLSFMwWwK0K57akxCwak3xHUtHAfNpIjxi9kw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iTgXHgXT5V5/qTbx2J6Zp33LT+wKfHD06E2HRT893eOGSrQd9l2ysGXNVAqZ3sor2NcWvIcza0JV8zP+Sn7FDUn6YkFmCTS4ti0GWX5D1IuSS+ROvQM4omSD/AUXoyjEjIZVNkdBEaOcaVmVanrGNKIPJEjkQCsxFY2MjJkWxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRSK+CAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACD7C4CEE2;
	Thu, 24 Apr 2025 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745453406;
	bh=LIcJuKcLSFMwWwK0K57akxCwak3xHUtHAfNpIjxi9kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hRSK+CAuSHHDidtxKazU0Nda3DiBQCkNWSvyuQcTxspecpuEILvrHMEOc2ygr4h9h
	 b3I/yA3A5th5Iphh5SUFBmphi0geUY6Vizu+5BQdjvEePzwUvg1YKMtFFr6ZXKT3ew
	 YpQrUXd3Pv1oNbFDkJRb7i+qHFiVr1SqHSzcSKJ8qoea6WOsXZUDmx9j+o2rV1KiEq
	 50ck2onBdl06ze94mMPex7YbX6MvO87hYKq/lg5FgeghCMDPiqPNLhnSoUb00mQwqc
	 bIKQJt9RHl0u/Bze9DlhfnaDVLRZYJPbrZk0KxYg+4wGwIszoCWixY9CAK4a3KD1uE
	 wJybajCdlGwxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCED380CED9;
	Thu, 24 Apr 2025 00:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] r8169: merge chip versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545344448.2807189.16358341392946662274.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 00:10:44 +0000
References: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
In-Reply-To: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 11:22:54 +0200 you wrote:
> After 2b065c098c37 ("r8169: refactor chip version detection") we can
> merge handling of few chip versions.
> 
> Heiner Kallweit (3):
>   r8169: merge chip versions 70 and 71 (RTL8126A)
>   r8169: merge chip versions 64 and 65 (RTL8125D)
>   r8169: merge chip versions 52 and 53 (RTL8117)
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] r8169: merge chip versions 70 and 71 (RTL8126A)
    https://git.kernel.org/netdev/net-next/c/4dec0702b862
  - [net-next,2/3] r8169: merge chip versions 64 and 65 (RTL8125D)
    https://git.kernel.org/netdev/net-next/c/f372ef6ed5a6
  - [net-next,3/3] r8169: merge chip versions 52 and 53 (RTL8117)
    https://git.kernel.org/netdev/net-next/c/4f51e7d370a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



