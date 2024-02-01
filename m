Return-Path: <netdev+bounces-68143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3BD845E86
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B3B2F180
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766A63CB0;
	Thu,  1 Feb 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t624OMvH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5963C85
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808626; cv=none; b=SP6ND/+A4tSsgW5U7QS4hlgW0nRtRZZRulwjqjByj0yaCGAXt57TUhx3tarKelv6rlZSPM01AJ4lAY0txUZfdIUTp9fAfz3uWrCf62Y1UBByUSztZdju/efMc5jLxQTRSuaKkFGYPKyvLjeXAMMQ0igJ2eOlaYh/xTbBJPOEM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808626; c=relaxed/simple;
	bh=rj39GmVf5Um4yqY9ZyFiUDJf88cI4LWBo8tDH09V1Nc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oksmfKxS2lTbIWrCcrrXjSx+oMaKw9M8CEKWdJmUWLXflHeolu1Ja+dr1YVlxrL7LwhT8lz55sIhiYc+H/4XOdulmmkxDxokbLuUQq2qGtSF47+2DvcGYH1IaFuI6D9LIFC+z/hUGePOOraHXhQjsUs6FODVn9sLu2z8i6ggjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t624OMvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB975C43390;
	Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808625;
	bh=rj39GmVf5Um4yqY9ZyFiUDJf88cI4LWBo8tDH09V1Nc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t624OMvHM5t3nP0q7msJYOP2JdkHubzWMm/Sw2VIX5AtF5RMXOVtCE7wUFXZRxos3
	 hZELeXDdXu7nHfulfdgdXx6H8Gps2sxfkglX2qZebW0u5R2181J3qDezjxrVcl+0ES
	 jHGCNRHnf6FHRu9EQuZ40pj6M+zdqXVLP1046rMrH6DPioPke9r5IMaaCO7ID649bH
	 dl2m6PuBZ6gV02nojGBoYa38kKG5+jjWfvF2pCr8Q1qnaO3HsQj4NRC/DWTn6p/HK2
	 HISQgJqePnk6Dp+7nKgNsKSRvNyNqzf61wlmz1fFhNaHrU3qsP0nyfCqFU631uAJh6
	 r6hM1alB+3VBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2F04C0C40E;
	Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] batman-adv: mcast: fix mcast packet type counter on
 timeouted nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680862572.30194.1130104142363817483.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 17:30:25 +0000
References: <20240201110110.29129-2-sw@simonwunderlich.de>
In-Reply-To: <20240201110110.29129-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, linus.luessing@c0d3.blue, sven@narfation.org

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Thu,  1 Feb 2024 12:01:09 +0100 you wrote:
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> When a node which does not have the new batman-adv multicast packet type
> capability vanishes then the according, global counter erroneously would
> not be reduced in response on other nodes. Which in turn leads to the mesh
> never switching back to sending with the new multicast packet type.
> 
> [...]

Here is the summary with links:
  - [1/2] batman-adv: mcast: fix mcast packet type counter on timeouted nodes
    https://git.kernel.org/netdev/net/c/59f7ea703c38
  - [2/2] batman-adv: mcast: fix memory leak on deleting a batman-adv interface
    https://git.kernel.org/netdev/net/c/0a186b49bba5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



