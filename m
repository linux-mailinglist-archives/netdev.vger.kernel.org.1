Return-Path: <netdev+bounces-182542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFBA890AB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B9A3B7228
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C691552FD;
	Tue, 15 Apr 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVnKbR/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8018BB8E
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677004; cv=none; b=BEFIAj2/wDO3ZO1Nhe2M+arhAs0uRBCAej1DU7bhXX8TF0Io414NC14QtnQJudUO2T5R3oc/8atrC4PQcUmzf2yIi9BMw4igg6eQR4kF/e4m0W3EQFn5hh8ZuEdbsRX/iM0fvFNSnEiOfvdrvXA1Y5Rk732O5+MVyc/jG6EILBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677004; c=relaxed/simple;
	bh=lvVB8ERFZF5P+Vc1ZYUKv0U8Xf3EsqYUSGwIpyLcSlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/8rek3ntSXRTtwxqvDpOPQao/CbYWmsSjdEiSqGJipqRGXLd9yxK+2cB8GNmoWsYYnBVCeDgYZXmqRN1MTA3UJA7QYXW2Kvcgj/NRrvX03Z0TmEgZbq5WNazYTpoGDiNvsWbmOe0foqpa+mvuTbWq8mz6haj0qegbG3tHWD1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVnKbR/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE2AC4CEEA;
	Tue, 15 Apr 2025 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677004;
	bh=lvVB8ERFZF5P+Vc1ZYUKv0U8Xf3EsqYUSGwIpyLcSlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eVnKbR/wmZ/qMYv8q9uYAsrG5Tj0yeVXQTBMUyyi/NNBXl0g9duf4Ty4Keh5k18gw
	 dVDd1ZQWhHYJot0Zr9MbRKVAYVuWVV86JlmxgpAGoTwuxCtcR4CrJeD615HfkySwv4
	 Jyqe6CjFKoP9BNAT7aqYGxhMw5a8P8uT4+5acLkh4/Ogz30xzruuiCFTI018Lrgy3G
	 +LeW0crF9ycXT7SNchL64pytzFEMZXtnCwLfSb3H21gdZqPThhOLZbBTL4exDE1G/h
	 p4Pa8HjROkX/l/VMGlwSxqQb4lJn8ZeyWnX9KOsDfFP+VcCnJiRCW5JguZ6YU0Vi+K
	 Ijs+EtiH7Ogrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C703822D1A;
	Tue, 15 Apr 2025 00:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: fix get_ts_stats() documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467704177.2083973.3122568646546461923.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 00:30:41 +0000
References: <E1u3MTz-000Crx-IW@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u3MTz-000Crx-IW@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, rrameshbabu@nvidia.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Apr 2025 23:04:19 +0100 you wrote:
> Commit 0e9c127729be ("ethtool: add interface to read Tx hardware
> timestamping statistics") added documentation for timestamping
> statistics, but added the detailed explanation for this method to
> the get_ts_info() rather than get_ts_stats(). Move it to the correct
> entry.
> 
> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: fix get_ts_stats() documentation
    https://git.kernel.org/netdev/net-next/c/ceaceaf79ea0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



