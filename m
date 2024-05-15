Return-Path: <netdev+bounces-96529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CC8C6524
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777A61C20A38
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C2B5EE67;
	Wed, 15 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbw2GKK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A55A0E1;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770230; cv=none; b=Pt4jeRalZ2q42eEJ3jMVOTK7Tjc8dGgHTg7mLY2WZtcXthxPPWy1Ok7sXkactqqTwiBdSK5xIIKyX2ZH3eHBZ3I4Wo/1XrWhjeSn/o+TAdhv1dY4xUrAVC1P1R2wfLK+Zhb5u200S9hOWvbcq3RdmSt0dA8AP3ecZaoB8EoRs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770230; c=relaxed/simple;
	bh=eYiAvt81Ifc4i08Fxt8B3PLugWWqn76VxBHBJToJ99k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ddbtdGwf8vyi2j86JYeDMdiDSfpKrxbifE0i6JZ2FsHo7urLskjqprixPU/U4UU/Gm+spJ+sPoTM093t90QQ9vUKF14ipX4MR/wA3UkOX7W9bE81IdPNVUEGxM7bJaHz8NLIglRHH0TDhKPXyOXh2Rf9/lz+mS17iOGjosblGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbw2GKK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAC71C4AF09;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770229;
	bh=eYiAvt81Ifc4i08Fxt8B3PLugWWqn76VxBHBJToJ99k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zbw2GKK74LlQcx1v1+qnrQTzJgQZ2pUcUbCmpTXX6gqcAFAWvv5EvC+rZBPXhFDuh
	 r52ezM6TzCAtu7HbYP/VIQxaYuRhLn76s3lIJyJCqXEBsccaJ3UUiU8+NeiCMG8uRy
	 HxTZZ3G7ZRGF8aEE8UotTLIn9YmTfwOQzdaANWm3PnF6+lbVq1GUgWoDS8vQxbeYO3
	 cZksOvnYOG3Elni6wbTKmlZT+pVME/+Pq2O//hSiemjZp4hMNmyIid2aSP9ffioSt1
	 vhBed/lNtqULGnq1Lqt76PDeYtuciEX0yesjtQcGSjq/LoiHKz3+f5lIgBxC8tikGy
	 X5MvyuOeW+9EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFC36C54BDC;
	Wed, 15 May 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: xmit: make sure we have at least eth header
 len bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171577022971.14646.4487627386797578993.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 10:50:29 +0000
References: <20240513103419.768040-1-razor@blackwall.org>
In-Reply-To: <20240513103419.768040-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, bridge@lists.linux.dev,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 May 2024 13:34:19 +0300 you wrote:
> syzbot triggered an uninit value[1] error in bridge device's xmit path
> by sending a short (less than ETH_HLEN bytes) skb. To fix it check if
> we can actually pull that amount instead of assuming.
> 
> Tested with dropwatch:
>  drop at: br_dev_xmit+0xb93/0x12d0 [bridge] (0xffffffffc06739b3)
>  origin: software
>  timestamp: Mon May 13 11:31:53 2024 778214037 nsec
>  protocol: 0x88a8
>  length: 2
>  original length: 2
>  drop reason: PKT_TOO_SMALL
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: xmit: make sure we have at least eth header len bytes
    https://git.kernel.org/netdev/net/c/8bd67ebb50c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



