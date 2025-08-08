Return-Path: <netdev+bounces-212287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5FB1EF46
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEFD1C26DB0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC60155A4D;
	Fri,  8 Aug 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsxPMHNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D11EA91
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683795; cv=none; b=ZC1MCqlqEBtq99wczN09PBl4TATQxx73oPV7mSHlG7ibAIo46q7FyIA62aerUZG9Cdqjr7U4qzJfqWjoG03b+YSVPG1rjh227g+zB6BS5JYXJkigVttv4JhgDcJLk1ZPKa1QuX15q6s2VpYNZ1Wui1eiIOd53FYsnyKwGNfw9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683795; c=relaxed/simple;
	bh=R9ARUg6hADbe4gWjEj8z9gYzk+3IYd7xP8j1sB2nbkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Acwct6VTmQYK907ptXWJcQWswfePW6KtKkqFWhyITGnEggj6K4NCplmnlpwguaUB0oZ6zVoUgnNOtgQcIXIy7tk2HeQ1IzuLXcvYdZW1XYS+LSNBixiNfLSASTjV8agDU0u5XjuRhP7ROr/7O4NEi0hCxpvt9qMuNk1KvwGUCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsxPMHNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2373C4CEED;
	Fri,  8 Aug 2025 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754683795;
	bh=R9ARUg6hADbe4gWjEj8z9gYzk+3IYd7xP8j1sB2nbkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsxPMHNs3VwJpBNrpHFo8Y2qZEXE39NmuGsMnHns61vPS7j7BLfDbMD376xTbscYo
	 CgltIAjwxC1mLQN6ga8l72KUshxWyYwyr1YwUO1MV3WlblyT7f4UADbElLpmLlSnQR
	 USA9i3KQuH72E9KzluxlHS4CF44xqRrZOyFYma4rnxo60IubDxwxRGoKPQD0UKiaDx
	 MyRgb+XExAnHreTLSJ4f8Ul1Nx7xqeLKCtVLdYElZMQwf5kENIbuIoa9rxetmGf78L
	 P3mm9/yA0BX3tHnvqod6Hf5lJmE5bbkziXZUM8QWnDjaaCvrG+RGMtSAnLz842X0gD
	 ZCGyHIMvwSX5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71036383BF5A;
	Fri,  8 Aug 2025 20:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icss-iep: Fix incorrect type for return
 value in
 extts_enable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468380825.252401.12949749636646106003.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:10:08 +0000
References: <20250805142323.1949406-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250805142323.1949406-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, m-malladi@ti.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Aug 2025 07:23:18 -0700 you wrote:
> The variable ret in icss_iep_extts_enable() was incorrectly declared
> as u32, while the function returns int and may return negative error
> codes. This will cause sign extension issues and incorrect error
> propagation. Update ret to be int to fix error handling.
> 
> This change corrects the declaration to avoid potential type mismatch.
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icss-iep: Fix incorrect type for return value in extts_enable()
    https://git.kernel.org/netdev/net/c/5f1d1d14db7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



