Return-Path: <netdev+bounces-62146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26100825E22
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE61C23774
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 03:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423315B1;
	Sat,  6 Jan 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYDBtT3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25A15AC
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 03:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFAEAC433C9;
	Sat,  6 Jan 2024 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704512424;
	bh=cSKjihochozhE6zb6HuAybgq7cP6pr9X+3krGHf9xi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYDBtT3D/VEANMj36wOyPaK4ODhQZ4dbgauICsFbkhteOGMQ2yykiNoa8plJcN72+
	 EHUMMv4pKCP3aEm0DrbFhTDYh3q2bQjMwMTsrWSdBL4cDhMfWV7DGijvEd+xzwhPs7
	 kFp58l/cPpNL48kg5nfHD3j/jiZOh9UYAHCOSnbtoM/VG7QbPt8CpWSKtN3B/WNa3I
	 +eFKGAfHasU+p4jLM0TNCyZ4BrxzlfL3fA4YTFOHKNJ1lCiOsWzmzK9NT2H36lASlU
	 qgPkpJe5Rd+bofr7OIrynEbRWdE1s0/eeGdMYSPKPtw39z0ytAG5PuUcyHr93xJH2L
	 kBG84uTmkm8zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0101C41606;
	Sat,  6 Jan 2024 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: ethtool: reject unsupported RSS input xfrm
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170451242471.27125.5648643145157016821.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jan 2024 03:40:24 +0000
References: <20240104212653.394424-1-ahmed.zaki@intel.com>
In-Reply-To: <20240104212653.394424-1-ahmed.zaki@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch,
 horms@kernel.org, mkubecek@suse.cz

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 14:26:53 -0700 you wrote:
> RXFH input_xfrm currently has three supported values: 0 (clear all),
> symmetric_xor and NO_CHANGE.
> 
> Reject any other value sent from user-space.
> 
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: ethtool: reject unsupported RSS input xfrm values
    https://git.kernel.org/netdev/net-next/c/948f97f9d8d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



