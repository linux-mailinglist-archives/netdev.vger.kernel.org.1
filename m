Return-Path: <netdev+bounces-206188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72FBB01F52
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA04587532
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510612D3EC5;
	Fri, 11 Jul 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV0ltgCR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1562D29B7
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244798; cv=none; b=sAHisHVIBsYAfy8raVgeifXAY82+Upf4RFIyVtrEJ0bXCZaQexYR95xndHYtExqFdmsJAte1K8Q3QPEQ7AzxRFM5SAMkTGkic4pSGw2Gl/DhZxWg7J76WKJbz6uiNI/r0ev8OZo0TJIGPn+YL1D8eEUtvZhXEEYcag/asXan+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244798; c=relaxed/simple;
	bh=kad+v9J4FH6elNxVSBr0XoMu6mSIi7I/jDSY+/O9Cn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bLa/PTZ+9p9HGiP4XSiL3nr/RGV0ZYyhC6Wi6s9xgWO+YtDtTzp0dwQB3bwI3y9qC1QZVRjtFpcaAFYYV+SZoYavwUfE5jnFonlFFpemNIQW0HJ1vqk2NZncFoaAQgod63FRJhLcYLwxjLEd8SqwkGr/WdRzw12PJRsoPVxU4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV0ltgCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0309DC4CEF0;
	Fri, 11 Jul 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244798;
	bh=kad+v9J4FH6elNxVSBr0XoMu6mSIi7I/jDSY+/O9Cn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NV0ltgCRMg2Xz1mTbynXcZD4M1N2re4TjfNiLdVrskl6Ql288785FMYc+dNTSbXmT
	 iYBpheve5iHCpxDXmwCXrd9pPsSKsxxMqfGXSPezNVzpRzOQSbQbnc1IvqTlYXtWBn
	 /AGIsDJRV1CiNcoGjk565YD/6pbgaEQ2DPKQqV6Gve81k5sBmgahUXZnFfPXrSNHVA
	 G+jrjdp93OOhrneS9X2P4gEQbjrIom4yMlh7BtMjh0RJU7CgIujHq/SGq6w48ZL5mj
	 i7eHNVuyHtYvb2V/QTbwWjnBQUjTxjwROXQE/KxVZ2S1kMhqBgoyoZGpL4suGgkvpk
	 EkAYziQJsAfCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B57383B275;
	Fri, 11 Jul 2025 14:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] netlink: Fix rmem check in
 netlink_broadcast_deliver().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175224482000.2294782.15684889497718774088.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 14:40:20 +0000
References: <20250711053208.2965945-1-kuniyu@google.com>
In-Reply-To: <20250711053208.2965945-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 05:32:07 +0000 you wrote:
> We need to allow queuing at least one skb even when skb is
> larger than sk->sk_rcvbuf.
> 
> The cited commit made a mistake while converting a condition
> in netlink_broadcast_deliver().
> 
> Let's correct the rmem check for the allow-one-skb rule.
> 
> [...]

Here is the summary with links:
  - [v1,net] netlink: Fix rmem check in netlink_broadcast_deliver().
    https://git.kernel.org/netdev/net/c/a3c4a125ec72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



