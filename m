Return-Path: <netdev+bounces-213916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE8B274B9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF05AA0BC4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E11A5B8B;
	Fri, 15 Aug 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrFm1/ho"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B718A6AD;
	Fri, 15 Aug 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221405; cv=none; b=apy77B5lDfub24iYourD1T+q7W28iDFovA7IsmDJOE2UjhbnPdrZAEdckWsuhrqJO0xaEjR2dr6Sz46puFlQoxEELZUuZlxsxVA5w1S4uHA67hX2jcZiV3VV9pJBrHUhOezPMCvaTSrD5WkoH5C/ja+Mdha3WDgXrFO6a2ULF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221405; c=relaxed/simple;
	bh=AHO+2MBXdGYg5pxuPHn8BStrfgcsmQI4GBuw11/g/mU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sZkfBjsm8mRtLPtNtEW25D4vvRclLq14Aj8wYg6uNKvqnfBKwkmg1eabNK37LT6kfn2MIHjQxmTTJcCBXEw2mbw0SAeq5rONY/hsF4Em7zcbLw2mBpvqoKGqfHjlvN7xTA/ptvM6d9NMITLGeyMn+KDLjZNAkHFS2ZDmJuCkm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrFm1/ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB821C4CEED;
	Fri, 15 Aug 2025 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755221405;
	bh=AHO+2MBXdGYg5pxuPHn8BStrfgcsmQI4GBuw11/g/mU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NrFm1/ho9IZAkf9bb5jCAejVTNpxD56dc/cYhqiZtWY5yM/UFlNj2klusOCxRRfyy
	 m7ttb8KvfsL8Xnfl14N/1UJapjBeX176aMfLzJ2N41j/tGO4kEvHi7jdXjAEcr8T/j
	 hlpkMw9chgDh/zf8swFSs2iklbw7dutmPI45RU0soU61SrSr49btVvg4a/YFaIhSKw
	 kJf00w0JC2uQzNHsZlZ+dd/EM3/fIVqNoZFDeqvGtz5pit5TIafay080a/6oUwfegN
	 PgPCZwljLoNs780kfKZr4MVIYT+fiidS47KFsHRmOv0kxm7VSPUueTiZuYGKRSvq2Q
	 vy1hXEDBdH/uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3539D0C3E;
	Fri, 15 Aug 2025 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next 0/2] net: dsa: b53: mmap: Add bcm63268
 GPHY
 power control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175522141623.510661.3222510491838583574.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 01:30:16 +0000
References: <20250814002530.5866-1-kylehendrydev@gmail.com>
In-Reply-To: <20250814002530.5866-1-kylehendrydev@gmail.com>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 17:25:26 -0700 you wrote:
> The gpio controller on the bcm63268 has a register for
> controlling the gigabit phy power. These patches disable
> low power mode when enabling the gphy port.
> 
> This is based on an earlier patch series here:
> https://lore.kernel.org/netdev/20250306053105.41677-1-kylehendrydev@gmail.com/
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,1/2] net: dsa: b53: mmap: Add gphy port to phy info for bcm63268
    https://git.kernel.org/netdev/net-next/c/7f95f04fe190
  - [RESEND,net-next,2/2] net: dsa: b53: mmap: Implement bcm63268 gphy power control
    https://git.kernel.org/netdev/net-next/c/61730ac10ba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



