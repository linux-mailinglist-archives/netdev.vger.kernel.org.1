Return-Path: <netdev+bounces-47948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C517EC11E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD1E280C9F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF21156D4;
	Wed, 15 Nov 2023 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLoI1oaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D09154B7
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BB97C433C8;
	Wed, 15 Nov 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700046624;
	bh=4tv/8UtHJeCxbW/EYknsGQZkjizlyk9fcepibNrC+NE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bLoI1oaG30QwJ17ZTNSFlkGi/y4ARSdvUrMz8FcCcaxjytz/IYGfpS0CAtsGlBVHj
	 UfWN04apI5jRK6gBkGRHHqXMLuIHNR6W2wSJLESM25HSuZ2dpguZFXyvwnzy6vu3px
	 LpjTGrcSpbBLG4k7MjG1powv19iX+y3W5Xz6ev61D33tKqV4aqOBYvAW69KM14Tdtu
	 NPgrzREvpZ/pGAkzrtdKGecutnmTnfPWYBSiK9bbkmBXJNWMKz1nAA4mav8R0Ou8L9
	 AIyvsLqYLWUvTwpOPHPE1kq/HWUgsP8nXiZ5FbO+038fhu5kTujyG7fnj1sUg9R/FJ
	 FAIOdD7Hhrr/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3433AE1F670;
	Wed, 15 Nov 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: Fix undefined behavior in netdev name allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170004662421.29267.17413794298247399121.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 11:10:24 +0000
References: <20231114075618.1698547-1-gal@nvidia.com>
In-Reply-To: <20231114075618.1698547-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
 horms@kernel.org, vladbu@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 09:56:18 +0200 you wrote:
> Cited commit removed the strscpy() call and kept the snprintf() only.
> 
> It is common to use 'dev->name' as the format string before a netdev is
> registered, this results in 'res' and 'name' pointers being equal.
> According to POSIX, if copying takes place between objects that overlap
> as a result of a call to sprintf() or snprintf(), the results are
> undefined.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: Fix undefined behavior in netdev name allocation
    https://git.kernel.org/netdev/net/c/674e31808946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



