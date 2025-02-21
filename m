Return-Path: <netdev+bounces-168371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2316A3EAAB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4146A19C5C98
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B01E1A05;
	Fri, 21 Feb 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqypkQ2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC551DF751;
	Fri, 21 Feb 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104217; cv=none; b=CphW2KbNH0oIM2/IT2w5X3CQb7OtEEKXOBpLIEB+mC5/0HYqlHGClssdbUmmA2ur53yL/9saTrk7Y1rBSj979cRxxL8Hi8oVzphL7gXpXu9JJN/QLYrY9D2CpXTnAxteCM/YHRUmkKAAzJgtw0xsZUase6WpPBsxLHqpY1KY7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104217; c=relaxed/simple;
	bh=7a8knPkOhFr6cHhvuytLC0QSHkxRP+zRqx4LPcIjRNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0OKY7qvRWobaNkLFH5c30TWpEbYDQIAxyCn8ilQ/TKVcdxozZwWCldca+vCvo28jg1mPHbD/ES567aCISCuu8jlFgAs8yLZ4BrpUNVPCsNC6kMWEffFC773h7CgPgmQcrzxrQM77IS/faiwdbU26+2UtNfk6tpRET62tt9KeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqypkQ2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14E3C4CED1;
	Fri, 21 Feb 2025 02:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104216;
	bh=7a8knPkOhFr6cHhvuytLC0QSHkxRP+zRqx4LPcIjRNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aqypkQ2nglW/Va73AUqKnBjrOjnm/zabgempsOuSySmALNrf81KD+YKOSPxbTX2/5
	 CWkX81xtdaf8L0pBlDPKT4QoIjoPJWG5oAs2bwagT3PzlEhVbTHsycnFMmZqDiwqsp
	 LXi3+t6b22OkNoSqt6dMM2ml28/ykyo8Wm+9dkBF02q+r8yUXV9Al9/6B/ymXkJ58S
	 W6volLwmelA00cSIh0Mr1r0V03leknnQ2dl07gz24BZfIUPjYtT2LDMAQ1SDoE3Wzc
	 SmP32G7DKy2oED7uX54EkNOTT8k1L8N9Tn9HsmQ+SSfItlwJ+4YgqC9zBpbgjvjaMc
	 F2I/ZFimY7iTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB23806641;
	Fri, 21 Feb 2025 02:17:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: qt2025: Fix hardware revision check
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010424774.1545236.14600610160946307263.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:17:27 +0000
References: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
In-Reply-To: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 12:41:55 +0000 you wrote:
> Correct the hardware revision check comment in the QT2025 driver. The
> revision value was documented as 0x3b instead of the correct 0xb3,
> which matches the actual comparison logic in the code.
> 
> Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: qt2025: Fix hardware revision check comment
    https://git.kernel.org/netdev/net-next/c/8279a8dacf9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



