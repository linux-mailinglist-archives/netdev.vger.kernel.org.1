Return-Path: <netdev+bounces-141325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1979BA79B
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1178281845
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1918A6B0;
	Sun,  3 Nov 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q13aoZBS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44501189F48;
	Sun,  3 Nov 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730661622; cv=none; b=A6gFHuR9T+Le5nb/Pd20cdpqpcLfZwhV8bB0tSAVU5vdRpYtbKnlTA/wNzHr8IZN0WM6qpuOXNzhV9ShHRQE3zU4OPlJy3P1uhxF10ml1ryEICNwX/MW4XU9oCc3OsO97VsYV9AQ+kzSLHhTlf783Dvek48tQR8pzTnsEBTe/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730661622; c=relaxed/simple;
	bh=+SzG39M2jVZpdLMuDmKwxnI/V/yP9sxbrZFvVZCLlTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ayDgTCieGoEI4YKxzjW1bAV1byJNx7XSr1XzTpYvMJtLFEkciXWM/bpfzQ5OYEO7tDvsEwtEGtumEX20D++eiGp6dZTGmNhNtkVvMQ2FT1ZjQcm+p0U52ywuJfbEweET34vOhvd0Q6awGi29nT2XZRNQbkVnie7101tUeABBaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q13aoZBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF32C4AF09;
	Sun,  3 Nov 2024 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730661621;
	bh=+SzG39M2jVZpdLMuDmKwxnI/V/yP9sxbrZFvVZCLlTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q13aoZBS9AGtdfuBbyo8Q+abhoZ4nd8Q9FG2Rde4ggC4i7c6XaWGXYV45OOYYXbUp
	 pdgVM3ltO59GjVGVVhm67WYCulVa9T95KHeZsDoDoRwps5XlyJlpjTKo2HFRBBFP1O
	 4Z1ZA9GYfk3bGEwJiTKsU+OjNfgrTIVRRdd+sVb4i2qLfE24Sq2oGuyqKI6D8zegRa
	 iB1AaUxAPRs4bvqRud4BAN/lPXJUwST0+AAVgRgTipVk2exzFWVJxqnuiCmxHM6kmu
	 hdGhay11Fv6Kk+7+s+/y7gGAg9/qDGMyKvFJ5Ph0s8GQ7q6jkERnnvfppXKu8mTX2a
	 vcxNA/EgvqAHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4138363C3;
	Sun,  3 Nov 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2][next] UAPI: net/ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066163000.3236514.15893944925080913506.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 19:20:30 +0000
References: <cover.1730238285.git.gustavoars@kernel.org>
In-Reply-To: <cover.1730238285.git.gustavoars@kernel.org>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: michael.chan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bharat@chelsio.com,
 benve@cisco.com, satishkh@cisco.com, manishc@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 15:55:02 -0600 you wrote:
> Small patch series aimed at fixing thousands of -Wflex-array-member-not-at-end
> warnings by creating a new tagged struct within a flexible structure. We then
> use this new struct type to fix problematic middle-flex-array declarations in
> multiple composite structs, as well as to update the type of some variables in
> various functions.
> 
> Changes in v2:
>  - Update changelog text in patch 2/2 to better reflect the changes
>    made. (Jakub)
>  - Adjust variable declarations to follow the reverse xmas tree
>    convention. (Jakub)
> 
> [...]

Here is the summary with links:
  - [v2,1/2,next] UAPI: ethtool: Use __struct_group() in struct ethtool_link_settings
    https://git.kernel.org/netdev/net-next/c/43d3487035e9
  - [v2,2/2,next] net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/3bd9b9abdf15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



