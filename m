Return-Path: <netdev+bounces-31879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1C791132
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 07:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EA01C2035A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856FA34;
	Mon,  4 Sep 2023 05:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CD80D
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72288C433C9;
	Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693807094;
	bh=SgIn6RAMMzxG+nORZBY3486Gk4Quh8zKvDulJ9O7aSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8yeEmzXly5KLRZbQwD50R1GWeYsB/lsQu4Pvg4Q1D0ESLNsSnfWs8IMIknXZ4cmu
	 XALwxhWEKU0lHYl2uJ9owpDrAe5GXeU7GT9jJESzUpjNFdGJDzh6Ah9dYxlbxqxvec
	 PjTuP/IC14+OPzlihHA6hUv6nOlUyvrAmvI1kzTo+m51WnzfQp6igwyBcLdebSJkwi
	 dSwlcDI3ENyy9Fl55/Flx8Uj6ygIoT5GmMPoar1Cyk0AsMjVETd3NCjQxJGyGln+F2
	 XC1Ded9oKdJo+kv/Oap6f7gNawHn1JK9QHlDshxRHkks/udl/rFAnqYHjA0ENlj0Uq
	 m4QGbK/kTmKOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5216EC04E25;
	Mon,  4 Sep 2023 05:58:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] veth: Fixing transmit return status for dropped
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169380709433.30982.11277881859787581776.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 05:58:14 +0000
References: <20230901040921.13645-1-liangchen.linux@gmail.com>
In-Reply-To: <20230901040921.13645-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  1 Sep 2023 12:09:21 +0800 you wrote:
> The veth_xmit function returns NETDEV_TX_OK even when packets are dropped.
> This behavior leads to incorrect calculations of statistics counts, as
> well as things like txq->trans_start updates.
> 
> Fixes: e314dbdc1c0d ("[NET]: Virtual ethernet device driver.")
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] veth: Fixing transmit return status for dropped packets
    https://git.kernel.org/netdev/net/c/151e887d8ff9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



