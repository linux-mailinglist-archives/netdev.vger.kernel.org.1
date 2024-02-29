Return-Path: <netdev+bounces-76122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4D86C6B1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9912C1F21D96
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5389062808;
	Thu, 29 Feb 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAyTUF6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7E6214D
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202028; cv=none; b=dH52Kbip3Iw2hDtKHjYBUqhXR9Y3JJdpH0mMe4qYKB5F2N8JVm9rikG2cNm35KfSACArJzorI6a88BktzdU9zMDHEQF2nxTFiwy0/O3DrefmVZaEwruUTZN2rOhXQxYR8ZsnNOPEFqoOU/x2j666/fDehIrg8Nv432TvJAdLWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202028; c=relaxed/simple;
	bh=sOCRQYJkrZw9xvsJ9noJk1UbG92PjiCY1u1QbR57MaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BMerKL/4xF85tjvh9IF3O1A6jru+CsoER+A41YVjb/gJSGxQZjzF4PZy1BIGDtFeNB0yhb8Db2kTDr2uUWF9TDK0IgGZTLbs4HQ7DZuc25GK7lEyoYXss+sLBUP1PgC1cC3K5y/KPQH9hxuMbwMePg0fnGW5Ep66rr1xlw+DZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAyTUF6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00284C43390;
	Thu, 29 Feb 2024 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709202028;
	bh=sOCRQYJkrZw9xvsJ9noJk1UbG92PjiCY1u1QbR57MaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pAyTUF6msSFeZ5XeUasofBCSQspVA6txUSk0PfooNQAgTvs5VIdGi8f8QqSZTA98R
	 N8koUzqis2uWPfy4w8NvkjaWR1yhhwXWAL0rwKPQtKJcigwnNoANM0Hn2DBc6Q2e3u
	 5ls1Kn+uwN1szh39jGo5gq2HjnYDc8sWaLCpVu68IEIKwsnYvD9jxk90swh3SuVh12
	 McoHDAXTXtD5UtnVMdUMs9x/ua863fuO3ac6tMv4Wv+Xlfpe+RU1Qfy4tDkZlRFdm3
	 eI2fqzTOeUSvKVQY6LUKmMmYiQ9eN6gv4htwxXsij8pcTQ9sXjC5EkRe5SqvowQ5tF
	 vmAiQTq6Hm7fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF325C3274B;
	Thu, 29 Feb 2024 10:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: hsr: Use correct offset for HSR TLV values in
 supervisory HSR frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170920202791.27512.14273215717177660905.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 10:20:27 +0000
References: <20240228085644.3618044-1-lukma@denx.de>
In-Reply-To: <20240228085644.3618044-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: o.rempel@pengutronix.de, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, Tristram.Ha@microchip.com,
 bigeasy@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Feb 2024 09:56:44 +0100 you wrote:
> Current HSR implementation uses following supervisory frame (even for
> HSRv1 the HSR tag is not is not present):
> 
> 00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
> 00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
> 00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00000030: 00 00 00 00 00 00 00 00 00 00 00 00
> 
> [...]

Here is the summary with links:
  - [v2] net: hsr: Use correct offset for HSR TLV values in supervisory HSR frames
    https://git.kernel.org/netdev/net/c/51dd4ee03722

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



