Return-Path: <netdev+bounces-104832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E2790E905
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE481C212F6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966C82495;
	Wed, 19 Jun 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAm6EF6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C475817
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795429; cv=none; b=TbI1K913gM7SqsU2prVT8n3waodM/z2jLAKc8UAwhm+lbXWpP3vznPfbBjue9p/STAjwS4nTCAajSOXvP0BWk9b8AjquhxC+DvqvQn3o4EvbVpbbPjw+mrpHX1n5p/wPsMSq0fzcLbEG9xHdDPivHYXsND3VN/mC+fmQ4a6jt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795429; c=relaxed/simple;
	bh=wKpejeYsyo3qvHm56DsCwlMqnSht5mSus9iVil1aqrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=igFYUKF79n/mKvJh7t67Jf23qbPAzEb/91dc+9P9SXKz3osCWWzzMkAjmIR/BfBfWMMPoerOTZMakWpTPvnnwjbAKXhZFwRV8o5p21AKdr4yEfdBTILi0oswfz2DH80O23bvsFZAcwMlxCsoyPCzrsegSGSY3pV7F4c+zN/e56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAm6EF6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97DF7C4AF1A;
	Wed, 19 Jun 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795429;
	bh=wKpejeYsyo3qvHm56DsCwlMqnSht5mSus9iVil1aqrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GAm6EF6k+jk6Y5WEFpykYabUzAZZmJftwEtWxk4qTDzQYJca5FFYZnFiWJZH6rD0g
	 rqDvLY4quO5iZI5qMTi7AC+7i9w4DdtQeyyOX3ebLX8FvEx2L/f6o/AuwH9FQHHAHg
	 GiUB8pFHajHcLoXKXf3ssiWgJx3B4tcRJ/mAG/eJSfkj5YiBmRLZ6ji+PhsakQ4XdI
	 4bscYs9l++/+OumOQ1N4x7HIYdcxvDHFvaSQUWI9s9IwkpbQ2kvf4TdRKqWvnO6fQ/
	 t9HPU0SXLeRmGYTcGXrrx9l2P0Dh3HiSyCZJE5pNxlAHDKNV12HuhEoL+vTgY5nqoU
	 z5G1GEWsjEzQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77884C4361A;
	Wed, 19 Jun 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Add error handling to VLAN unoffload
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879542947.8917.3149188437526710433.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 11:10:29 +0000
References: <20240617-otx2-vlan-push-v1-1-5cf20a70570e@kernel.org>
In-Reply-To: <20240617-otx2-vlan-push-v1-1-5cf20a70570e@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, naveenm@marvell.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jun 2024 17:50:26 +0100 you wrote:
> otx2_sq_append_skb makes used of __vlan_hwaccel_push_inside()
> to unoffload VLANs - push them from skb meta data into skb data.
> However, it omitts a check for __vlan_hwaccel_push_inside()
> returning NULL.
> 
> Found by inspection based on [1] and [2].
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Add error handling to VLAN unoffload handling
    https://git.kernel.org/netdev/net/c/b95a4afe2def

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



