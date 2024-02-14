Return-Path: <netdev+bounces-71595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B678541A1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494941F22395
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F28467;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRVjLxbk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A27493
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879030; cv=none; b=cvByFYibeNFkJhHeR9/H8QnjfflNqmE7D6YZ5kSDzP+kqNZmrcCC/grmLqPFcrlQO2GISO4tLdC4L3ee0y82ww5dw0OrAuL2lMTTWX3O9HZQhVYXuXEOPXOQh6UkJgBWPI6PJ0X85TA81ZWh+5Zmkn9GOqhotPSAGPZn8M1dUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879030; c=relaxed/simple;
	bh=qmQgvwEbUruMVF894qSDQqWrobhgeE1QUMrpPXfQZkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ie1r8W5LxkP1jASiu/buYKiLhVW7MRmMlPXbstW0DpkYXzeKAcHW92Bz4IgPrDKlfqN9oymwE2U0pnFixv3nNNeuFXCcPmfO7ezIcrASYHrgmICNyDwxzrg1Eaht0A7nu1HLrnmRz5HhYVD7duipAlaSHtbVKxyZFavAyTF8o5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRVjLxbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36DE5C433B2;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879030;
	bh=qmQgvwEbUruMVF894qSDQqWrobhgeE1QUMrpPXfQZkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRVjLxbkcNZ19Cu1r3Nral/RrH+7A/yZ4d0tEQSru6ArvvXlFWk+CdrzLVr5W6mcX
	 tUS+QywXTBU/GN/xfozRG9+08Lh/r39/iS11h5G3VEQhfJt3zag7oDxIC5ZvvCVN6+
	 g7EgY4qVIcEp+qygcGyH/hrZxUJab4vz9i/mMAiPMKzov8IZkW6zV6i4I5C9iShxpM
	 Q1XKau666avIAb/aY+olWWL2rNcJfl8in6KeGGOMFwSj7nafY8XIvXirYVGWTZBSg+
	 0yxdf/Osy/BHhbG7nnlwhzEzlKV5vLz2GcZwPSES8FsLvPcQNzg/CDQx/RPtjDpnAP
	 7JszFZHb+dzGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D6D6D84BCF;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] net: use net->dev_by_index in two places
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787903011.13249.14481317448658195771.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 02:50:30 +0000
References: <20240211214404.1882191-1-edumazet@google.com>
In-Reply-To: <20240211214404.1882191-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Feb 2024 21:44:02 +0000 you wrote:
> Bring "ip link" ordering to /proc/net/dev one (by ifindexes).
> 
> Do the same for /proc/net/vlan/config
> 
> v2: added suggestions from Jakub Kicinski and Ido Schimmel, thanks !
>   Link: https://lore.kernel.org/all/20240209142441.6c56435b@kernel.org/
>   Link: https://lore.kernel.org/all/ZckR-XOsULLI9EHc@shredder/
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] vlan: use xarray iterator to implement /proc/net/vlan/config
    https://git.kernel.org/netdev/net-next/c/f383ced24d6a
  - [v2,net-next,2/2] rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()
    https://git.kernel.org/netdev/net-next/c/3e41af90767d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



