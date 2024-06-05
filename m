Return-Path: <netdev+bounces-100958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E317F8FCA79
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD732822A1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11BA14D456;
	Wed,  5 Jun 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3tjA3Hn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388A49622;
	Wed,  5 Jun 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587028; cv=none; b=CKL0EhUjhhmcD5vkujXMB7dH4OvOyy0s/oRJoGewX8LHLS0h7HqPnJHdLrHC+iUGL4RIDQSzPDlEQYCt8jU1R3LmWWmMufhMHFlPh0q7L3BUyuLWMDVyXcb4QhABEdUNAv8iIpzt9iVUkKDkbrHHOmJPv/+lvrUVYuG84zc+7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587028; c=relaxed/simple;
	bh=ohU8eFMsKrVEuiqcNPZaUDhVqxquhRY+n4mV8mf7Tn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YABuXps5XOK6rk9bidsYlMGSmGctAVd/dWIXQhw93g4k3YX+A9hTPz7hxs0NNrDmt6F4JYr/I0BVhQGhRVw0bYkuJCuCAbg6g2xAOq8g2mK9Rjd5CjkwHiiuC8HQ2gmMc1cGMwxmkEEtT7MX+p4NvtcEwzsSF9Rkx6xoUcwEukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3tjA3Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6137CC32781;
	Wed,  5 Jun 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587028;
	bh=ohU8eFMsKrVEuiqcNPZaUDhVqxquhRY+n4mV8mf7Tn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p3tjA3HnNR3e4CoON75PPSDNbs8Xb36O5ba3BkodERo8dj5+iMAaxGd2wfE1cGX5H
	 w8xysI43tMn0A7Vkf0IA7CleygNo98eyoooBUqzPg2Q9LdDkUjz7mJcMTtpIJ3YZDw
	 2ha+jN4S2yOY1PfXjvKgNlu94nXX5eLPkZJB+sLGmfrVNqr5xnnAj55qk8AXSf7sUV
	 RH+MHhHX8+346Dv23FzbDF0vEETBbf58XpeWUhl+3OEK+bf+K7xPHHY3LpuIDS0tdp
	 PdwNfOl6h09lpLAWhmW0IW+hbOIPTUW7uzhIfdrIRpX/HhuQfkiq3LtKF/jTL1i7tp
	 Ld6hgX1fmaxrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FABAD3E996;
	Wed,  5 Jun 2024 11:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] octeontx2-af: Add debugfs support to dump NIX TM
 topology
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758702832.15938.14799291870880574957.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 11:30:28 +0000
References: <20240603112249.6403-1-agaur@marvell.com>
In-Reply-To: <20240603112249.6403-1-agaur@marvell.com>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 3 Jun 2024 16:52:48 +0530 you wrote:
> This patch adds support to dump NIX transmit queue topology.
> There are multiple levels of scheduling/shaping supported by
> NIX and a packet traverses through multiple levels before sending
> the packet out. At each level, there are set of scheduling/shaping
> rules applied to a packet flow.
> 
> Each packet traverses through multiple levels
> SQ->SMQ->TL4->TL3->TL2->TL1 and these levels are mapped in a parent-child
> relationship.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] octeontx2-af: Add debugfs support to dump NIX TM topology
    https://git.kernel.org/netdev/net-next/c/b907194a5d5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



