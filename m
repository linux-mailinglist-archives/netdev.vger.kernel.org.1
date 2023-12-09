Return-Path: <netdev+bounces-55514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B037780B186
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6532F1F21344
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46171810;
	Sat,  9 Dec 2023 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKhMBsjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524C7F8
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC10FC433C7;
	Sat,  9 Dec 2023 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702086024;
	bh=CGkcfWZEhlwCmXtLHwbXozC7xiHcycaFzPE/cPhI2sQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SKhMBsjn78pTyBZNXTVGhaIcgJyOFb1YHN52xU7tG1hc+8tT0ni1BYuyE2zZF5cHh
	 E/v1Kgy7XgnW6AuuceGwRvAAURbu79p+HxoD6Fy2Bk87j5GsEvU5LdgDp17MTyxPvL
	 +v5LVCyD6w0bL8etVtcsZQQt3/MlyOGZJZ+topBWRTgkMQq6ptvQPeTtWValxEYKOK
	 rQtm8bcqhKH0YK2XnlaTMwFDtwEZj3OF8tue7J56e48mA4wCCoxw08a2UyFyF+RIk8
	 /Mex8gcXWhcpVSpGjhvm7k/Zz7s9ySinUq47WZYu7QHJQkJS0DCDVNYmMLLr5uoqYG
	 zbeZNjtD9EuMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B171DD4F1E;
	Sat,  9 Dec 2023 01:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] bnxt_en: Misc. fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208602456.28253.18241308082183590091.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 01:40:24 +0000
References: <20231208001658.14230-1-michael.chan@broadcom.com>
In-Reply-To: <20231208001658.14230-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 16:16:54 -0800 you wrote:
> 4 miscellaneous driver fixes covering PM resume, SKB recycling,
> wrong return value check, and PTP HWTSTAMP_FILTER_ALL.
> 
> v3: Fix Fixes tag in patch 1 and improve patch 3.
> v2: Fix SOB tags in patch 1 and 3.
> 
> Kalesh AP (1):
>   bnxt_en: Fix wrong return value check in bnxt_close_nic()
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] bnxt_en: Clear resource reservation during resume
    https://git.kernel.org/netdev/net/c/9ef7c58f5abe
  - [net,v3,2/4] bnxt_en: Fix skb recycling logic in bnxt_deliver_skb()
    https://git.kernel.org/netdev/net/c/aded5d1feb08
  - [net,v3,3/4] bnxt_en: Fix wrong return value check in bnxt_close_nic()
    https://git.kernel.org/netdev/net/c/bd6781c18cb5
  - [net,v3,4/4] bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic
    https://git.kernel.org/netdev/net/c/c13e268c0768

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



