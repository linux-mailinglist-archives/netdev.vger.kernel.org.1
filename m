Return-Path: <netdev+bounces-221261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF4B4FEF4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F7B364394
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE6C352084;
	Tue,  9 Sep 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+mr/SXz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4535207F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427002; cv=none; b=LIGoyAFE/QzyjeXrYt1eWTo6Msyl+YtVwvDm4JtHLXu9WwXH4OczdBfcTPcqRIhD6CfVo0MXjUNqM9RZuyV2t3KJE6D3hD6vyWLLFCNkPQ+re8MnsZqxBoDCppc8cZ6hXnnGvDBrqHCHyPzNatvaXPYEZ1RRlTfW69I+BGIME0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427002; c=relaxed/simple;
	bh=HmYr/d2oRkMy9dODDXn23342HlRZSgE+1b7+publUlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jseekptjjF1kfNDVa0aGqpaqnkdDEubkdS91DgE5aJNgzuWjzokn0vwI1ZpQye6KtzhFzp4OR0whQBWSptL7F+w5M/QuwfURVg63jkWFygby8yHatY+H0r7uO3kQbVHPb5jhaovgOMxLJfrQl0dSIP4o93VmntfiAHujoU+SlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+mr/SXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33687C4CEF4;
	Tue,  9 Sep 2025 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757427002;
	bh=HmYr/d2oRkMy9dODDXn23342HlRZSgE+1b7+publUlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+mr/SXzZe332nW+Hq9CRzVUoLZIPrLnFtMHEa2EbtKYfxyc9Jja+L6aVwuRNQ62B
	 lhc2+EqY2YuedjHNQY94tTmEpoVo9ZZdOcx55/3u+/Q3PQ2O+9TRthBrUk3pv3LBd/
	 mQieRLDKkv55snrR4ccB05E/cL4HE6BOQiqdZl+iGei/hitb11pCv1hp/ZZdBNyWom
	 A94Yne8X/FijpNz++ERNecvKBcvY90tMPNjEKx4wn8iXVTDfjJfxOYZua/R8JJi0d+
	 NCKQ6urWae3H8USGiYqiZEot0uKEai4EwQm8vxyyBCmLJy78kHUrNrisJRV0eTAvC1
	 5fK7/V1WBDaew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC5383BF69;
	Tue,  9 Sep 2025 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: support persistent NAPI config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175742700550.692355.16451104453714222910.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 14:10:05 +0000
References: <20250905022254.2635707-1-kuba@kernel.org>
In-Reply-To: <20250905022254.2635707-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, joe@dama.to

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Sep 2025 19:22:54 -0700 you wrote:
> No shenanigans in this driver, AFAIU, pass the vector index to NAPI
> registration.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] eth: fbnic: support persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/0574c27cbe79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



