Return-Path: <netdev+bounces-189407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78CAB2057
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FE21BC6B31
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D02641FC;
	Fri,  9 May 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqi+tNgw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC820C492
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834602; cv=none; b=KUbqodL+zlC8kTowyPbUKmcEXqmb40DbaYZKpm+x+fo9S3G0JfguqmHoIob6+NvrxM0GXz1hU/RNm8crARBLin56JnlI2tvfydbefvgQtMOr5eG/jSRT8ezPs4jTOSdASg/GX4tjw8GZowYht3xX4c/eX9yXHPa/Y0HFmvr0oH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834602; c=relaxed/simple;
	bh=PmAUb3RSGlIBEOYXBDwonQRf65lEnWdbHT32ZjGT6RM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EtqT1za5WFE55q76AbI3c8P1mANHaOg3FvsiMYEt1QNQ4JB05pHHnEIcc+ZTuGTjqbEZxNRkVf1DOsdBwVVQLt8Yijcksvx/1B9+Bx4qPJ1PzZPxHSQZMrZv0zomZebfBMZzvpasV+pgkyDEGImSi1LlUyGUfXQ96KK87gZdW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqi+tNgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9547C4CEE4;
	Fri,  9 May 2025 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834601;
	bh=PmAUb3RSGlIBEOYXBDwonQRf65lEnWdbHT32ZjGT6RM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cqi+tNgwaKmvEDUV3syMqCLv6wR3kbpd3JtEvXG0wWWbtZOOHQaqXtxl03eC2G6CD
	 +3L0uMm2KV7wV3dI7Lwb/idV/DRKAzD4eam0GvNZD6IqHXyDc7k0IFqv596lacyDji
	 jpJJiCjnL+PBqJAValIQjmeThcSPMueCMZdCMwSKC2r87UvnKGhWyCEi+USmP2do+l
	 ZLptj7H0DYAlkEjTAJwni7Gf+RM+a15Dy9uf0JpKtIzsP18QudWMpJnjFXvcE51hL3
	 84h/v9GPpIUOgV2FDOFj456+RPtEGbrAa1Hg/RMCkeSKayd51HY/RT0Zd8RuGiCe65
	 dgZvsBYXKDBZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C85381091A;
	Fri,  9 May 2025 23:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: thunder: make tx software timestamp
 independent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683464026.3845363.2664384903307721092.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:50:40 +0000
References: <20250508034433.14408-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250508034433.14408-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, willemb@google.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 11:44:33 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> skb_tx_timestamp() is used for tx software timestamp enabled by
> SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is used for
> SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are different
> timestamps in two dimensions, it's not appropriate to group these two
> together in the if-statement.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: thunder: make tx software timestamp independent
    https://git.kernel.org/netdev/net-next/c/179542a98730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



