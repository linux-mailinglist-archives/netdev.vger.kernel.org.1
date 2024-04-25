Return-Path: <netdev+bounces-91364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB528B2519
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D171C1C20944
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65514AD36;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCakQBQZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DC14A633
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059034; cv=none; b=YftFdLDkpJLtf2ETMUyyhqsTzQtjSDnfjQhY9kLLhtBy6scv0dcn8PpC2S7jy7Hb62NaPB4pGgqlpAlBhjjX5GwpEstFxKIVbDUH7FEapjdYM5V0iHEO2Tai8GeJZAl/w9d7fECEbhJaT76PYRYqAs+DjKjDJc7EbhQUzhdey6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059034; c=relaxed/simple;
	bh=VTSSHD4/85d4JjFy6I51WBIIQVRls4UCHjS6vWrDCho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=blpv+GjM6H7k68hHFxJQiIQTcBB4XU1BWdttYTK/HTLH+R69yIzsUedCQkxpfeUSs8Q1QGYZ9VEv44XjKmvL1K8VqaO5uMduK0jMs+xA6tRFa+uaOPJr6GXfnMS6EGniLCXfVmy9SZj2twI9poeLa7IAP/lNmGyfcjVOzPypWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCakQBQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C557C2BD10;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059034;
	bh=VTSSHD4/85d4JjFy6I51WBIIQVRls4UCHjS6vWrDCho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sCakQBQZor99Tanhs/iHVgw9lbz1VoGpg2jx6nnMlGs+U6fzF0FDEFK6i+NVzac8X
	 pcrvFdXwp6xCZCrwYm+yrAezWDP7c0mz+iTfsGjJW/eiwu4cf6qUfb6sa5Kz7ll2r1
	 T4TKlmwaTOSNvGJckJAFjSrWmtKBdXezlTMjfxh5kAM0WlxsCJc/o1cw4xqacTBQJa
	 Hz3lNryp00znlvL0K0tot/ijQxjQEj2FoD6rH57EtW9NronXB0snbE2ugUEwPpeHwN
	 TsqQtVdSceCypcAbQOpS6y4HUcq1V6c7/Pqn1hwVnYr/RHXuBQpLese+G1urZHd9sq
	 1Tmc6lAsHkSOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AAF6C595C5;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-04-23 (i40e, iavf, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405903410.5824.18116289504884714487.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:30:34 +0000
References: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 11:27:16 -0700 you wrote:
> This series contains updates to i40e, iavf, and ice drivers.
> 
> Sindhu removes WQ_MEM_RECLAIM flag from workqueue for i40e.
> 
> Erwan Velu adjusts message to avoid confusion on base being reported on
> i40e.
> 
> [...]

Here is the summary with links:
  - [net,1/4] i40e: Do not use WQ_MEM_RECLAIM flag for workqueue
    https://git.kernel.org/netdev/net/c/2cc7d150550c
  - [net,2/4] i40e: Report MFS in decimal base instead of hex
    https://git.kernel.org/netdev/net/c/ef3c313119ea
  - [net,3/4] iavf: Fix TC config comparison with existing adapter TC config
    https://git.kernel.org/netdev/net/c/54976cf58d61
  - [net,4/4] ice: fix LAG and VF lock dependency in ice_reset_vf()
    https://git.kernel.org/netdev/net/c/96fdd1f6b4ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



