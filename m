Return-Path: <netdev+bounces-226806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70CBA54F4
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDE4E1947
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBF32BD5AD;
	Fri, 26 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqq2zPpW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635192BCF4C;
	Fri, 26 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925213; cv=none; b=reF2wHdp4nzvkelEgBloEhKOsI0/ihY4ZgEipIEka+iadHQUSNYEG6eYbLlbBFnCzMqLf8ZzalsF5OYqqVSZhqtQanLfWbiZOiFHt9D0bwse7Sw/M8/UKVS1RtfesvjiNsyfH8B4sPhtBbXk1pOV4VyNKZyR0BLmFxy2ev2F4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925213; c=relaxed/simple;
	bh=SKOH/WVgfGEs9IGZxC/aPLizzJJmWJs8ehDW/5dRvd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KJHefoVBo4Uz95MP6grK3omBI1FyOSCcZH9I2UEODg8p+nCxfwH8knT/wvchUo9b2jMTniDBB1BpZUdZ0Qt5hi4pdVPZ2xw1Is9Y6gBh9oaf1DFMASAicdrRKx661imTsutWv7cVByR/chVEtFpjo5a/ff/Pvz3s4K3arhaAqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqq2zPpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C2FC4CEF4;
	Fri, 26 Sep 2025 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925213;
	bh=SKOH/WVgfGEs9IGZxC/aPLizzJJmWJs8ehDW/5dRvd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bqq2zPpWVAoQxzrXkdOQUt+0rWR2t7DqLIvT0mpKn/G3rhn/dEKWKrNH/5yMFRPux
	 Wgnxy/A/URET6FvbEZn2SfPCBunXmZzqaE8BIKkc+Cp13KeheQFZ9f6PI+OpoeElzL
	 aPCUm/2oB5bng93xmfvfQgGlw4rvea2/97yC2YCD/Q1rckOl+6h1U0zQ49BYqeiQt6
	 qnxDYvca2G9YoutN4QuigAeToeIrc4Zwe2zPKUQ5GEyodZwjjQWgtb8wKtrGIrDXUU
	 7xAUNDKkxtRnRtjHpc1B2GxboViQZ0e23zDxHZx4So6Sabz0r0/4bfO/xwZyTee2fx
	 +EY+CGgKW4LoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4A39D0C3F;
	Fri, 26 Sep 2025 22:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: Fix probing error message typo for the
 ENETCv4 PF driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892520824.77570.5375385275136011763.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:20:08 +0000
References: <20250924082755.1984798-1-wei.fang@nxp.com>
In-Reply-To: <20250924082755.1984798-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 16:27:55 +0800 you wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> Blamed commit wrongly indicates VF error in case of PF probing error.
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: Fix probing error message typo for the ENETCv4 PF driver
    https://git.kernel.org/netdev/net/c/c35cf24a69b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



