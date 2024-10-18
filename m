Return-Path: <netdev+bounces-136828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25459A32DC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6685F1F2173E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7A381C4;
	Fri, 18 Oct 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMcv/Oko"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0441E493
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218628; cv=none; b=n3XGnM6LKfvC8oEfRxATCMV9+VxnMRe8hl32+5JOq5qW1eZWR163vRSs0c8vXgpAz+7lyOjqfpXPuElMAxg3Oe0n6HfM3+Z8vJ+glDWi9OLrwbknQKpdNsAnNsYysD1xbiQwlgL3yXV/qg6HhkUDh2qAHndbDr9A3XC8JhgjgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218628; c=relaxed/simple;
	bh=QKyNlKQnhBsnQ6UTGK2ulbcGhSutWd6umKY6q41gegY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gWDikihbO4odC4NzPWxiQ8RsqtUx7Syprxh3PdiM6zFNBUB58jpv2zDu0Fa9NG9EsXnf8yj6NDS079LwdGvD/ZhyGGOCzfLMOQdJynU8AVRWBDCO1UDVDVXpP3TgLhX9AmUDxFe5q6HQiG6eDXZrFfb1DcI9dqRTGVnSlg9b2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMcv/Oko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F228DC4CEC3;
	Fri, 18 Oct 2024 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729218627;
	bh=QKyNlKQnhBsnQ6UTGK2ulbcGhSutWd6umKY6q41gegY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XMcv/Okoqg63cTV/2rg0uMSjnqyCbNKKwIK/1jAtogfWt+cJOq5KQ70JgYapaHqCG
	 qtHLUKjbOqnUZWfRDt2i2mGcwKjSt+9OXKi4X9aELwvauBefSGlEtNga5Zr63MRa28
	 ieNBv721e9SQXHfZDlmgBSxjLPt/5U96moUy62cjKonST/A72K7g9MrOYQrYTjl7bY
	 h4SIdBHerwj8nlcQuGccADwimBk2oClWIxD6MSkDT9dEUv1KWd/GjdVlHnoQdyqwku
	 yAPp4ihXwZHx6Uq74FSL8bVFMG8uzqckTV/truFQkUovxl4GzU21TeBgEOGCvHjRx2
	 Lex8bdW8/GymA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB33809A8A;
	Fri, 18 Oct 2024 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] Removing more phylink cruft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172921863250.2663866.6892868823954938606.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 02:30:32 +0000
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
In-Reply-To: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 10:57:29 +0100 you wrote:
> Hi,
> 
> Continuing on with the cleanups, this patch series removes
> dsa_port_phylink_mac_select_pcs() which is no longer required. This
> will have no functional effect as phylink does this:
> 
>         bool using_mac_select_pcs = false;
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: remove dsa_port_phylink_mac_select_pcs()
    https://git.kernel.org/netdev/net-next/c/ecb595ebba0e
  - [net-next,v2,2/5] net: dsa: mv88e6xxx: return NULL when no PCS is present
    https://git.kernel.org/netdev/net-next/c/14ca726ada7f
  - [net-next,v2,3/5] net: phylink: allow mac_select_pcs() to remove a PCS
    https://git.kernel.org/netdev/net-next/c/486dc391ef43
  - [net-next,v2,4/5] net: phylink: remove use of pl->pcs in phylink_validate_mac_and_pcs()
    https://git.kernel.org/netdev/net-next/c/6c48cd044cc8
  - [net-next,v2,5/5] net: phylink: remove "using_mac_select_pcs"
    https://git.kernel.org/netdev/net-next/c/7530ea26c810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



