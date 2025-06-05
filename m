Return-Path: <netdev+bounces-195198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D17ACECB7
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29A0174640
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0820298D;
	Thu,  5 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHBeN4Du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4D1F3BAC;
	Thu,  5 Jun 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115204; cv=none; b=S4znFscEwiKrXfcaqLD7w7xgiF9FBY/5EYMlqK/+MW6UTsPs+YgCoh265I7lQXVSRMm4UBvINgmxzbTqlpjFt0z8DfOEqjLb/5kd8AU3Aj0XYAcJPj5ZrIjrTLsDxHnYna19yeiE4aHUPTPzUq/J/bXmgqLDmtXwLrQb/Hx/80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115204; c=relaxed/simple;
	bh=bxSszqCY4xmaDu2tu6silJ/hIywxNqPKgWYAeibw1NI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UKWSMq8NwV/uCQ6GwQHZA1fmPLk9uTOpCKX1gmR2Tk0V29/PrcyjJwadxUprx8IKhAa3eLvSYwBpumddkEaKXP6lpkTrQqWYOgmswlaGQUB07ht86Ru3Fq+HO3xcuDi7aQPe5Q6jk60I/knWNpUj3kMxel2RZyZP8sRs4oIvv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHBeN4Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F72C4CEE7;
	Thu,  5 Jun 2025 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749115203;
	bh=bxSszqCY4xmaDu2tu6silJ/hIywxNqPKgWYAeibw1NI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHBeN4DukePjKZuSv0HMdiaazIYR1/eUvuHOYTH7zM2onyBPcSooWG30xgFYgTQZ8
	 cQf3NoZqlj1434mGX/OYvm9f0ZGzsyQ04xcKMXvqR5v+i8oGrqic52ssHR8tku/lVj
	 PhebGglA737r1I2MzeFOB3kH/6pqRVHFnFyD+1Il9r1eiwiTgPq0ZiObFvICOtDAZ5
	 0Cv5DZ/xzWwhvgLEYlwxTDX2mZg877UNXTlHzUMbbbU7uKnXpAKkPQXUQMx8zkNm2W
	 YeQ3zLsX3ua/qYEbbvHTmjEKIMz3M8jMpTaXpZoBoVjHby/in0wxzHJNLSicO6khKV
	 N8Ugi3njgJSNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06338111D8;
	Thu,  5 Jun 2025 09:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] net: dsa: b53: fix RGMII ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174911523575.2996043.13505986466451734784.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 09:20:35 +0000
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
In-Reply-To: <20250602193953.1010487-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vivien.didelot@gmail.com, noltari@gmail.com, f.fainelli@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Jun 2025 21:39:48 +0200 you wrote:
> RGMII ports on BCM63xx were not really working, especially with PHYs
> that support EEE and are capable of configuring their own RGMII delays.
> 
> So let's make them work, and fix additional minor rgmii related issues
> found while working on it.
> 
> With a BCM96328BU-P300:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] net: dsa: b53: do not enable EEE on bcm63xx
    https://git.kernel.org/netdev/net/c/1237c2d4a8db
  - [net,v2,2/5] net: dsa: b53: do not enable RGMII delay on bcm63xx
    https://git.kernel.org/netdev/net/c/4af523551d87
  - [net,v2,3/5] net: dsa: b53: do not configure bcm63xx's IMP port interface
    https://git.kernel.org/netdev/net/c/75f4f7b2b130
  - [net,v2,4/5] net: dsa: b53: allow RGMII for bcm63xx RGMII ports
    https://git.kernel.org/netdev/net/c/5ea0d42c1980
  - [net,v2,5/5] net: dsa: b53: do not touch DLL_IQQD on bcm53115
    https://git.kernel.org/netdev/net/c/bc1a65eb81a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



