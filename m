Return-Path: <netdev+bounces-181485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70124A8520A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB088C1EF0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218E1DAC95;
	Fri, 11 Apr 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aif91Mnz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB871624D0
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342202; cv=none; b=O7HDIIB47Er9JFPPOCs5qbogkY4ST/R5ZWIViVGAfuCna49U0Yg7ZYmI1FLS7a2uRPPO7LQJzjBsDbEwgpqitTe/9xb58/6fAD1gDgbL0IZZKU7R5P9w69NjGnDhafGokv2D4i9w+DAmJKUY2Jj31U2zx/jlu+xMtWe0Mer3CCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342202; c=relaxed/simple;
	bh=xqPGLRHbI7S48Taajl1ecRTrXhMzTjGpVEYKaKg4pXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RUsf2GBo8VSGTRFqc3axZ0o9yjTUZa+EoD8B+P5bALsM/6cIeenSzNu59+7nwgtAptRKRjXqLqVOQ3ClAeBdLNsmmyJ1/pcSpZbanoVL7pnmTYO/uRsO3tV7WehAvaiXqgLkyHvdGNX5RykYOLoKm+DPmq60io03xPlRj57gI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aif91Mnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329ECC4CEE2;
	Fri, 11 Apr 2025 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744342202;
	bh=xqPGLRHbI7S48Taajl1ecRTrXhMzTjGpVEYKaKg4pXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aif91MnzXrGdcn4WLzVLfih5hsxnG3hYfYXpPhgpgWzEK3dUHieECFR8Rc8DEfUwY
	 pW1bNwUBEnkDG5N3BRXnnW1dXb8Gx+OhsR+TwkuyehASBBDN6suo8i20TM+OCSfE0s
	 f8dz3bw6BUzAgXSwQDLGpHS2bO20eUgyjerd+EXlfmqwEZK11GZRXSsMcLlsFlJ+GE
	 n7dkK7DE6rL5LGQwWrTyEFRMuKesbICvZIC9iNUw7WdfiRUf/v5qHQCjPFDuQOUA6H
	 qWYKC0tOaux8T45rZK3QA40KdPvs8TqUDtXuBkhQlkdW10a47A9MyitDj39aBF1UvU
	 IVE38JFfWEqSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC74D380CEF4;
	Fri, 11 Apr 2025 03:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add helper rtl8125_phy_param
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174434223975.3945310.5226439891230474477.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 03:30:39 +0000
References: <847b7356-12d6-441b-ade9-4b6e1539b84a@gmail.com>
In-Reply-To: <847b7356-12d6-441b-ade9-4b6e1539b84a@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Apr 2025 21:14:47 +0200 you wrote:
> The integrated PHY's of RTL8125/8126 have an own mechanism to access
> PHY parameters, similar to what r8168g_phy_param does on earlier PHY
> versions. Add helper rtl8125_phy_param to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../net/ethernet/realtek/r8169_phy_config.c   | 36 +++++++++----------
>  1 file changed, 16 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [net-next] r8169: add helper rtl8125_phy_param
    https://git.kernel.org/netdev/net-next/c/0c49baf099ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



