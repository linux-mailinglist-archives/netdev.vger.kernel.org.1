Return-Path: <netdev+bounces-60005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE981D0EE
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D4B237D6
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB83644;
	Sat, 23 Dec 2023 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf+65KSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A827EE
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 01:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F40CBC433C8;
	Sat, 23 Dec 2023 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703294426;
	bh=3KT4z6P+k4cbyPHeLfqKnZpGyq+T1W/gh+pKtYMsRqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gf+65KSXUJWRgubiALq4lJjVBPKSN1cUV3HdI0xrshpBLSaJzP68AeCIUAg1N5IWg
	 GaCJnHQyHxIO5Qrnj+FPic4j66NZztg7VUZd8m/fiTuK6MLzud5POrR10wwfT0BCSl
	 rMU+A1NSL96mHjtdu5RjYYyL9Gtz+gguJWao36eqLma0LkRkFao0ylzp3f+88EYA9T
	 UJiguPaN6Kp7mJzQZotpTf1ycY5cVxidXhx3aPuI1JsS8n2oUb3gtvL5MweQwGNiKo
	 2sVU9KfVtZzknzznxQcBXWbjYHUeB2Ew/49rA3ZVZpYllsZ1HCrRm+azLDpUGENEbu
	 gY8iS6mtWqaXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF161DD4EE1;
	Sat, 23 Dec 2023 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] dpaa2-switch: small improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170329442591.30372.5080492191593045266.git-patchwork-notify@kernel.org>
Date: Sat, 23 Dec 2023 01:20:25 +0000
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 13:59:25 +0200 you wrote:
> This patch set consists of a series of small improvements on the
> dpaa2-switch driver ranging from adding some more verbosity when
> encountering errors to reorganizing code to be easily extensible.
> 
> Changes in v3:
> - 4/8: removed the fixes tag and moved it to the commit message
> - 5/8: specified that there is no user-visible effect
> - 6/8: removed the initialization of the err variable
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] dpaa2-switch: set interface MAC address only on endpoint change
    https://git.kernel.org/netdev/net-next/c/365d0371a9ec
  - [net-next,v3,2/8] dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
    https://git.kernel.org/netdev/net-next/c/7218e963196e
  - [net-next,v3,3/8] dpaa2-switch: print an error when the vlan is already configured
    https://git.kernel.org/netdev/net-next/c/d50b1a8c3033
  - [net-next,v3,4/8] dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
    https://git.kernel.org/netdev/net-next/c/77c42a3b0a3a
  - [net-next,v3,5/8] dpaa2-switch: do not clear any interrupts automatically
    https://git.kernel.org/netdev/net-next/c/f6da276479c6
  - [net-next,v3,6/8] dpaa2-switch: reorganize the [pre]changeupper events
    https://git.kernel.org/netdev/net-next/c/a8150c9fb1d5
  - [net-next,v3,7/8] dpaa2-switch: move a check to the prechangeupper stage
    https://git.kernel.org/netdev/net-next/c/6d46a4f10532
  - [net-next,v3,8/8] dpaa2-switch: cleanup the egress flood of an unused FDB
    https://git.kernel.org/netdev/net-next/c/71150d9447c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



