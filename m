Return-Path: <netdev+bounces-44872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E47DA302
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D602825CD
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8E3FE5C;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIWh/3Ax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F23FE48
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09F14C433C9;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698444024;
	bh=atrewqFUK3stD0W1xGokIhevKa6SmZtk1OuAzEK29Aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EIWh/3AxxOBPDIliJqgGK5nJZ2BxTsvWvdriqgoLnvOD3LX8x/Sdaz57JUFzDHxqE
	 2NYPotM4H1//hBjM7gkQKnMgg0+B0qLrXfeDUU+9zkTQnNFi4DjLRCt2xRpQEc5bZu
	 c2Pi6tp6EpCNZ6vAV8a35cq7PoEh+zP97EbU/1OXf1J5v/Y4B/g2ybvK/e6/oilUP6
	 u/0/9LajDB+zSn0UKbwk1e8ck+y7iyp9GiyjjqpF94C7ls0gH3gHce5lZ1pm7WvekY
	 iXKXA2pWcMc8Eu1WnNhA3Xpcoqg7Y9YJttnAfech4mpsnihZF63A2Ae33vu00vuT/n
	 j9YuRdqNAy8sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E11B2C41620;
	Fri, 27 Oct 2023 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] nfp: using napi_build_skb() to replace
 build_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844402391.23229.15405557252041699793.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:00:23 +0000
References: <20231026080058.22810-1-louis.peens@corigine.com>
In-Reply-To: <20231026080058.22810-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, fei.qin@corigine.com, netdev@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Oct 2023 10:00:58 +0200 you wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> The napi_build_skb() can reuse the skb in skb cache per CPU or
> can allocate skbs in bulk, which helps improve the performance.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] nfp: using napi_build_skb() to replace build_skb()
    https://git.kernel.org/netdev/net-next/c/1a86a77a2328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



