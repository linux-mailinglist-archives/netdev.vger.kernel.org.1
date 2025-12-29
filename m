Return-Path: <netdev+bounces-246241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F1CE7430
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E244B300CCC8
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971F30F95B;
	Mon, 29 Dec 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfH9Epdb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727882153D8;
	Mon, 29 Dec 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023603; cv=none; b=DOQ39U2yHpp7wQ11vJCxZiTNaGxmkfPcHLJO+tg6yZwNTUFP2CpH8NkSC5Fz+c8nicmn7uPrynmvYC2BzvLFKPLG6uxu7MU6g7UCIA6BgKfYcyNhaikKyeLzAJxc3cEP/vU34viGPpH5qQWUMedn/kSzvZziMO/ozW+e2COqmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023603; c=relaxed/simple;
	bh=KPWml/VUDOnIn0GIRc4syhqCF7Z3lSzX3O1sp64ODPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jdmFsBfNnDD0CqSEYx6fIRGHRySuPFs50iZcM4cI19cOgJ2HiVEon+odrK2z6BweiVYkfEzxUVKPa0Jeh5cXCafN14Lhfem8O7+8djq841dEfWj02ly9SNlvLDxBZebYyNFVeZ7hMRwfqlVgxHWyr3aN2SP7Dx6r48T0n8FpuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfH9Epdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67FC4CEF7;
	Mon, 29 Dec 2025 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767023603;
	bh=KPWml/VUDOnIn0GIRc4syhqCF7Z3lSzX3O1sp64ODPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dfH9Epdb4gT8RNOnVsXtiMOD0b4QHx/+t+0S9uF3vAdB5OFiq1yXuKOVujU9xlN48
	 sm/Y4PeKHf3ipyIUoJUYxip0VDZq5BN/RUHCEbMRJxg391+EPL40eGctoP+uXkWdTg
	 CTxETCR1pmKXBjADoutFe23kvNaSy2ersVeJAqOAaWpmjijmoh0T8+loIOjOXYHZnC
	 MOZlYpPMRkNiaXGE3N4RQXrLItJCzW3eN+CPutVFs1JfRQXWYV86s209K4HEoCjyCO
	 ofGrnXAOmdIIYU3zMWbu1OH6KYfrc/v2pQOpBA6JVgvpKM1xLv/7K5yS/vHeQhn9uU
	 xuAkVGMefel2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B8D3808200;
	Mon, 29 Dec 2025 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176702340579.2992682.18342792256047599136.git-patchwork-notify@kernel.org>
Date: Mon, 29 Dec 2025 15:50:05 +0000
References: <20251219062226.524844-1-agaur@marvell.com>
In-Reply-To: <20251219062226.524844-1-agaur@marvell.com>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cjacob@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Dec 2025 11:52:26 +0530 you wrote:
> This patch ensures that the RX ring size (rx_pending) is not
> set below the permitted length. This avoids UBSAN
> shift-out-of-bounds errors when users passes small or zero
> ring sizes via ethtool -G.
> 
> Fixes: d45d8979840d ("octeontx2-pf: Add basic ethtool support")
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> Change-Id: I6de6770dbc0dd952725ccd71ce521f801bc7b15b
> 
> [...]

Here is the summary with links:
  - octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
    https://git.kernel.org/netdev/net/c/85f4b0c650d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



