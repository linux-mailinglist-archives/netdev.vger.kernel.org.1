Return-Path: <netdev+bounces-120763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927C895A8E0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F41C20DF1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDDDF6C;
	Thu, 22 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoKxTxUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990312E48;
	Thu, 22 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286634; cv=none; b=Zs2eOGtiUcWOdM6dBgTs6Xv7gubZUHh6wtaqMgbbNOanRLCiDCWayXC9If1rYPwK9wvxOaiJ1fGBNfSucII/c3swVtboeszHKtieKZmg1j0aFE/tN2T+Ie8EMifyxXJYzLp2UlNaXcNRp3+4JxsVpguINEBwon1DJdib2Ij4ylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286634; c=relaxed/simple;
	bh=IqoC72Hdty+mXlENYG5wrCP5xdQldE5+V56YmOf4hCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V7sGPgxvRFeayg1cutNnJPkqQiwBthmVM3SXRTtUxIAXIBdM85iEYzff3TJCmpN0QAYgr5x+Lc1GQdO/7rgbvQYLZV3RIt6MsdL2wFp1IjiTg/tLzRocgEjW6FZbiBGGbRYZ9H+mXuKi0dPUNkCy9Smob4a3YuWS17ljK88nczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoKxTxUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AD4C32782;
	Thu, 22 Aug 2024 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286633;
	bh=IqoC72Hdty+mXlENYG5wrCP5xdQldE5+V56YmOf4hCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UoKxTxUIBvdtN2b/z4f/K4pvIOxMYIdhruLTp6huuQBszz8BSEjNQ8Ae9hI7RbFtl
	 CWSZEEqMyzD85kysJ/iUwasYpv7Dny/zybf3N6TsFUzAMtx2y/qnfWflR0hIHeCVOR
	 JKFuw56tRrMlASgPJJ9hyPu3qIUwA/MY3N9/Pltyn+TtUxTLGbfbHCfP4qJkqk9pgr
	 XY5bIDoAqE8XTkadj/yg6LLE7GGkD6pllVARervJfZzcpiSi+uvsaGIRnxMyHSim4o
	 P2qHYAp/9PolYwnABttDL50iKM3TO2bg1LTutzvwhTS/qlUiZsRP27PYCGgi6ZEA67
	 434QwTkr8n4Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD713804CAB;
	Thu, 22 Aug 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: dsa: sja1105: Simplify with scoped for each OF
 child loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428663323.1870122.9401782494977212325.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:30:33 +0000
References: <20240820075047.681223-1-ruanjinjie@huawei.com>
In-Reply-To: <20240820075047.681223-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: olteanv@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 15:50:47 +0800 you wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_main.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [-next] net: dsa: sja1105: Simplify with scoped for each OF child loop
    https://git.kernel.org/netdev/net-next/c/2d86ecb64b51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



