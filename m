Return-Path: <netdev+bounces-110989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E69F92F342
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAB9283499
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57C61FBA;
	Fri, 12 Jul 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0nM5zJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B161FAA
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746032; cv=none; b=SQmiO3ymw91FNCBSx1qwM6FuqC+0VQYqnaDwcbJi+PwVkM/92TL0OQNlmqaHm3eHtmKMx7ZWhzHMbmSuu1t/qYOFBd73HPXpAA0zCIf54yGkN7PzY0UheR7xUhDtXFUsn7pAJTktCoNxjdYngYyD1drz1+wSqN/i9i/LKvYZUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746032; c=relaxed/simple;
	bh=SjPvuwZj7Ug28KQRU6A/hsWKwC3uZkVGNwoJvfalUSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L6BqPL/xNFwwdgm/vnPGLm8/JEL+yjx0p1Nu7tqq3prLaOW5VbsgAdxOUs42zZabxHkob+HLjsi/D/ZswF9B1iutNFfmQDWawh3Y6aQ0iCwBHnwrOlb83yKf03hBorYEbibjkoUdxUvGLRarY/GATmEIADJty+N3LvTkxRpa+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0nM5zJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43B1AC32782;
	Fri, 12 Jul 2024 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720746032;
	bh=SjPvuwZj7Ug28KQRU6A/hsWKwC3uZkVGNwoJvfalUSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0nM5zJKzBDLbkKsHtvGKzDu6asy1ojxShHoLK7CiMXZ0bKN48Ycgg/SCKLkV+gnE
	 Clz11qHkC8iMYGzAH/hnrHR+Dn+3oifv7JbY8bvz9+Jeqd29jzSt/SsR/ieBralBvH
	 ZselVotOYKO7G4FrSy/L9PCWIuY1xC/tCWtBTSVk1VnfVy+7GnPfuHJuXjlo02v7ko
	 GYrxZQ6sWqK4nom3iTsBiZQqVhmNnQpRe3+kPq2eYPrBW21+0STteySxG/LiXyuxUg
	 kp88ltCWw9Ikb6vq+Knp+Qeqs1B31RDAFJLdrG0VsPN6ULe7hCSiNN9uOhD00uPMJa
	 ok0OH02H/llig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F384C43468;
	Fri, 12 Jul 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bna: adjust 'name' buf size of bna_tcb and
 bna_ccb structures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074603218.14405.11096863256299217513.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 01:00:32 +0000
References: <20240708105008.12022-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20240708105008.12022-1-aleksei.kodanev@bell-sw.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, rmody@marvell.com, skalluru@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ddutt@brocade.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  8 Jul 2024 10:50:08 +0000 you wrote:
> To have enough space to write all possible sprintf() args. Currently
> 'name' size is 16, but the first '%s' specifier may already need at
> least 16 characters, since 'bnad->netdev->name' is used there.
> 
> For '%d' specifiers, assume that they require:
>  * 1 char for 'tx_id + tx_info->tcb[i]->id' sum, BNAD_MAX_TXQ_PER_TX is 8
>  * 2 chars for 'rx_id + rx_info->rx_ctrl[i].ccb->id', BNAD_MAX_RXP_PER_RX
>    is 16
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bna: adjust 'name' buf size of bna_tcb and bna_ccb structures
    https://git.kernel.org/netdev/net-next/c/c9741a03dc8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



