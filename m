Return-Path: <netdev+bounces-231490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BD9BF99C9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDFC3A7C0A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5411993B9;
	Wed, 22 Oct 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri1SLeDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09D85626;
	Wed, 22 Oct 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096634; cv=none; b=L5LW6+T/p3Yxs59Iq0iPQxpkQt/RHmz/edq7rW/mbfgDiBNjfLd4//S12SnuiAx/yPNkvLCbytAxxV1EcBwEoHb6HmxLS5TOpaKvUQmj5b86OdOfy6ppt2o+Ej8uc13PgeB1fV3ZzeV/9uUZX9vzjZ44FfQTLAiiCqUgpJOr7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096634; c=relaxed/simple;
	bh=7eZIMqPq5f3rCxeFrzv7o3fi3T6SWZbfIloE1KdQ96E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqf6U0MO9UvxotRInR69dS1n3HRooT7NBsWMX14qAYuSYRjzL2isFNdw2bfM5dTkErc11DuglK4KmE09TzCF/Mte4ZeJsBlwNdqhEk6jUeHj/QONRHYiAfje0Q//xP/sc76pJL06Gwq5i/kS/hvRTsuYXRwS9ajs8vnTxmP2AjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri1SLeDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322FBC4CEF1;
	Wed, 22 Oct 2025 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761096634;
	bh=7eZIMqPq5f3rCxeFrzv7o3fi3T6SWZbfIloE1KdQ96E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ri1SLeDWHob7Jb6l2QXqT+L/mhX1EPJqi4kYG2KApagTO/dZUXjWgY67r7ftuq9DS
	 +9u8hAu+F+4u4Q3mwvbHMv4uCsS0W+0bw/dmnWVEcsUnHGrzLj9i9Qn1ZukEktGIZV
	 epp+Y/LcEEWeAUeJRYgjIZMGo2pYIP06i+po8yDNTN/qOk/nAILupdqYdO+xGVhXd1
	 Oj4dgkDBkM0ePZMOUgmpOvHg3bz9nIPJYrBzRx+fcFYsXgPviBChM+9kGOR3pf/tmg
	 Js719Ef7lFu/nX+Xx8HkBcw483DGe+4rfH2yzRmfmltNkaZ5QY8KBYluEgoKMaj34y
	 +2/R/yU0/U0eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAD3A55FAA;
	Wed, 22 Oct 2025 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv6 net-next 0/4] net: common feature compute for upper
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109661524.1300441.954767233093800273.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:30:15 +0000
References: <20251017034155.61990-1-liuhangbin@gmail.com>
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sdubroca@redhat.com, jiri@resnulli.us, horms@kernel.org, idosch@nvidia.com,
 shuah@kernel.org, sdf@fomichev.me, stfomichev@gmail.com, kuniyu@google.com,
 aleksander.lobakin@intel.com, bridge@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 03:41:51 +0000 you wrote:
> Some high-level virtual drivers need to compute features from their
> lower devices, but each currently has its own implementation and may
> miss some feature computations. This patch set introduces a common function
> to compute features for such devices.
> 
> Currently, bonding, team, and bridge have been updated to use the new
> helper.
> 
> [...]

Here is the summary with links:
  - [PATCHv6,net-next,1/4] net: add a common function to compute features for upper devices
    https://git.kernel.org/netdev/net-next/c/28098defc79f
  - [PATCHv6,net-next,2/4] bonding: use common function to compute the features
    https://git.kernel.org/netdev/net-next/c/d4fde269a970
  - [PATCHv6,net-next,3/4] team: use common function to compute the features
    https://git.kernel.org/netdev/net-next/c/745cd46c2a47
  - [PATCHv6,net-next,4/4] net: bridge: use common function to compute the features
    https://git.kernel.org/netdev/net-next/c/0152747a528a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



