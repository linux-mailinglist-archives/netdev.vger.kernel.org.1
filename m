Return-Path: <netdev+bounces-242476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A9C909E8
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9AB9349FF2
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224627B4F9;
	Fri, 28 Nov 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEVaiao8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47527B352
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296602; cv=none; b=iaLJquLoC8gH0K11TUVBZGtK9sostmv/8emqnc5ZKRtOkMsJ/aJSYtccSSFB8uLMey2+DPC97FtV73LkoRwdxqkTWyen+VxUrWlfKMuHmeP3XM9N+v8kFLxz8LY2Tp2tMh02KRP6JEBgt80YoLo49WOtO9cEs4ohQkt8HaTCgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296602; c=relaxed/simple;
	bh=eY8nRjO7+gQpKkawYbDT43b5nlNygOVyVL1okNdRg7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uDbE1Vtqndhn3LqewAHSuHDLGYJTJV6zQa5wPLLRDXxggrUwkVbKT//m+H5MendPBKvCDv1SiJwhljCTpIUDjaJUyyCac0NpxfV+iIdeGk7uMVxGo1q6R4Kd2q4YvixZVuyA6oeR2F5UVw2pj4vrAOaLo9ITBSY6ESHa/tz1MYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEVaiao8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1167C116D0;
	Fri, 28 Nov 2025 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296602;
	bh=eY8nRjO7+gQpKkawYbDT43b5nlNygOVyVL1okNdRg7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FEVaiao8q/zm+5Hu4Joo1cbXPlmdZ/TQHUuU8zW3h6FQfgB3O8fAGgTyvw7FXQBsH
	 4vaHdbeMH5LltWN1XzXqoGVLzTVOxFSIaCst/gEKX3LbnFOaQXJ3iR28XXuwQu5b1+
	 Vxo43kMdGGx0d67egdM0gtCNLw2qAn9eoQYgcgcrbYciiBifJ5EVLX9JUmh8UdoMwK
	 5ejjtHsEmKX5x+y/5sJkFYIoopdyWfsvI789lfVhurRCMWPAw6CR/tgcbQTB75vMW4
	 cRcxsY9NfxkEY/BZhAZJrUqaNtpNgK9x0CtIw6c6nCO8uVOT5hcRQzShkPDsSDPiju
	 hNwbKtFO1A2jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789193808204;
	Fri, 28 Nov 2025 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] if_ether.h: Clarify ethertype validity for
 gsw1xx
 dsa
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642402.114872.17810001754416637371.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:24 +0000
References: <20251126135405.58119-1-Peter.Enderborg@axis.com>
In-Reply-To: <20251126135405.58119-1-Peter.Enderborg@axis.com>
To: Peter Enderborg <Peter.Enderborg@axis.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 daniel@makrotopia.org, peterend@axis.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 14:54:06 +0100 you wrote:
> From: Peter Enderborg <peterend@axis.com>
> 
> This 0x88C3 is registered to Infineon Technologies Corporate Research ST
> and are used by MaxLinear.
> Infineon made a spin off called Lantiq.
> Lantiq was acquired by Intel
> MaxLinear acquired Intels Connected Home division.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] if_ether.h: Clarify ethertype validity for gsw1xx dsa
    https://git.kernel.org/netdev/net-next/c/6557cae0a2a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



