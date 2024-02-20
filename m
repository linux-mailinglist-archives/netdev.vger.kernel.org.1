Return-Path: <netdev+bounces-73272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F392A85BA98
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39575B20E20
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13BB664B9;
	Tue, 20 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IreG2oJg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67865BBA
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428627; cv=none; b=MaMrJIYx8oqBgv0m8JuQKFSaDSx+seO90XDwd73kvmal0FABvASKp3cMsrl1CQ0LIETFSYfax1yZhbV5wN/1vo5k1t9LxRfhxIf1HG0fNd443Bdf9gsdHMeiq50EKQVBG52sasonJ0dlTR5KD2wPxYyCNmOToPySsswAdSmLr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428627; c=relaxed/simple;
	bh=u0nvoMRpNWkHAViYzDULLJqt3QAYTCtft+kke5UdF1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VcQNEJPlYTxPGVJUIO7/iRqJcpArJjxZK+E1lFpOmJuU5PrIchDcZk1MFOwXb6AUliIFRiUPA5maMT1FEz+ZZf0emKbfKT1nOz580JPPJK6Q6MP8tKNlxkCF87Hd/BeDdMLYQdstYcKckF4HircS2PIlOXaGDum5QQYW4kvFQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IreG2oJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67249C43390;
	Tue, 20 Feb 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428627;
	bh=u0nvoMRpNWkHAViYzDULLJqt3QAYTCtft+kke5UdF1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IreG2oJgBctAI7Vn9txe+B+xwwywmFY/XMr9pududhQpjLZOwXScUIInou20XrH60
	 raOxRDmBP3OUvMHEcqCNTQ9BqK1uOLWuFYB9wlwuQY+hM9mBbe3AEXfAS7rq75TQrv
	 aOqqVutd4HgpRU4zTfXzcLczZUfEz9f+v6OoaFSdgLEnncvyN9Vu2jBz+NSbyrHdiO
	 /hEJSWyTbtAzWfKwHZQP7ZmVs2lOlAmdaB6DyW+1UyOFzPQ9kRYdWLTxL1bwqNiug6
	 2lUfbwgsoZtSpzdSpFY5GdhCkzzGH816Vhe5wL/P8MOMAdSHZcl2JFhv/XonUR67ui
	 DK2/yTuAp/uTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FD6DC04E32;
	Tue, 20 Feb 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: skbuff: add overflow debug check to pull/push
 helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170842862732.17793.14949923129555017762.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 11:30:27 +0000
References: <20240216113700.23013-1-fw@strlen.de>
In-Reply-To: <20240216113700.23013-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Feb 2024 12:36:57 +0100 you wrote:
> syzbot managed to trigger following splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x4a3b/0x5e50
> Read of size 1 at addr ffff888208a4000e by task a.out/2313
> [..]
>   __skb_flow_dissect+0x4a3b/0x5e50
>   __skb_get_hash+0xb4/0x400
>   ip_tunnel_xmit+0x77e/0x26f0
>   ipip_tunnel_xmit+0x298/0x410
>   ..
> 
> [...]

Here is the summary with links:
  - [net] net: skbuff: add overflow debug check to pull/push helpers
    https://git.kernel.org/netdev/net-next/c/219eee9c0d16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



