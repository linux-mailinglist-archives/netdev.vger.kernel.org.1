Return-Path: <netdev+bounces-181865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8BA86A88
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 05:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4647B4426
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9D13AA3C;
	Sat, 12 Apr 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUBK7eIi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9F195
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744428011; cv=none; b=m4XXcQeBj9nGLe/VbsSTD/P5FuaT3EQRT1D3T25R74oxSoySkcpjVK+gCBjqYtrjuD7/BVDdY1eGcqQ2fUlQlfhu/KZTVFCrX/e+2HFnciBVLJJAcjm0hydp7yTE2AKLXGZ/OAEmu81IbDSPmWAm2wIglulJwdme7D8LgOIoMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744428011; c=relaxed/simple;
	bh=P3eMMMTOhVSL/2Y5KGfLC91c7e0DuqVcE96h8ZWmHXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MgTXuGOZ7ixpkI+GHmgqXW/cuAKjE+FTMWQ8VKDWb0nzrQMEq2t+rY3sLXjlVwvJu7zc22ST5T9dqtTRhWDPkPlQh1Y5iasiIjKMg2Q4z4Vsl0He9qWadu/RhZ9O4skerl65PtnVUszEXFy+d0JhE2yNO1RrwDEjASvIaIPuCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUBK7eIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA5C4CEE2;
	Sat, 12 Apr 2025 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744428011;
	bh=P3eMMMTOhVSL/2Y5KGfLC91c7e0DuqVcE96h8ZWmHXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qUBK7eIinygyDSEvh3NpnYPLwHiF/j/LT0mloVxEiaBVKqwKQz9pYkzOvLtvrl3g/
	 Vwv3BLtKuM5pMwNGRTBQaTwZwdb4aUAbdkdRPx57x/HdvuWX6SDwrRFzfC2/Jg0Sje
	 rDECheOpooP9UeWHrcgWaWnWxCd21XYmCQyJvuhdZpJ0B//tSgfOY/AltCBWoDxlAr
	 yr3aQhFmRA9ebBJnvh5EzZQ9KqTwMhYJ1Yd9UMN3MT5VqoQn735ASvlBL9EcH7Hja8
	 Ry1Zdv00O3R+WjIbXGIrqdos7NX5WLO30pyobpgdCdZENIV6iawAtgNcJJ60L60byN
	 sjyXGfFjD0t6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1F38111DD;
	Sat, 12 Apr 2025 03:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Add L2 hw acceleration for airoha_eth
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442804876.562152.332810337107180556.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 03:20:48 +0000
References: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
In-Reply-To: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 michal.kubiak@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Apr 2025 11:47:13 +0200 you wrote:
> Introduce the capability to offload L2 traffic defining flower rules in
> the PSE/PPE engine available on EN7581 SoC.
> Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
> sharing the same L2 info (with different L3/L4 info) in the L2 subflows
> list of a given L2 PPE entry.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: airoha: Add l2_flows rhashtable
    https://git.kernel.org/netdev/net-next/c/b4916f67902e
  - [net-next,v2,2/2] net: airoha: Add L2 hw acceleration support
    https://git.kernel.org/netdev/net-next/c/cd53f622611f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



