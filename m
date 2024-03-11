Return-Path: <netdev+bounces-79306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B67878AF0
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9426A1C2163F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEE5823A;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrGdQM4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064F5822B
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197437; cv=none; b=k+7zYs0iB7yYuMB8+jpJJ5uwNKQqVPh4T4BzBqywmoITYEHDdn00fowCuYA96n7UqaibijC+KWAjAdhkojVmHKvs77Lf238p96d7jLssXOG4fxV+hIIYTQCACQIDMPCQk/OarqPaA2UZHnIHoA3UlWDdFVn02ceIKA2k7nGQscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197437; c=relaxed/simple;
	bh=rQYxrp74iW2nt9pneSXMtBJi7rC6uNCFfKUW+AdIM2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HW3ul+JWJB7+OTaWcoMBiOEOwEgG4JyL1lb4e82Z2CzZ02isKEDSpo09iD3gvXeGG0MLyUZeTByGuxf8WkHnWTyDr30dDrY/S4G+PAVFhUUWav1XN5lWvYv5kbYU3QTXza2Z1rsJ2cA6r1OcHgkmy8X0HHwn/im3DX/nhDTpP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrGdQM4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A55BC43609;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197437;
	bh=rQYxrp74iW2nt9pneSXMtBJi7rC6uNCFfKUW+AdIM2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SrGdQM4wECgPRD3mkN7Uz7l4Xbh53i44X7hK6c8tLMAUPQwarbK49mx4jiXLEm6RV
	 InDsy3zgIL0sKTsWxfpaSMjg4t1aab5J93VAZzBgA45UqARFyX0eps1ZBo4nZrX3eG
	 yiVuyPQPJC1rKQsXbkt5yV6NPzoItwp5NkY0nT6JCZ/aivSlBeteX2qSdE7lTd2t2n
	 aFd3q0UF/EdJ7ssGZfFux0fdGyV2qfvyZ8bDWBlFDtnAg7k8qi52YhRL8w9KR7SDxB
	 Xmn6UO5u9PzhquSIoLYhKNWjx2VpJ+7G8nTX/WZ9MDIlSEx4i5kCOQskhSnffwV131
	 O6ClY5FucVR7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 218E4C39563;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: support generating code for genl
 socket priv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019743713.8733.2200498901225714219.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:50:37 +0000
References: <20240308190319.2523704-1-kuba@kernel.org>
In-Reply-To: <20240308190319.2523704-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, donald.hunter@gmail.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 11:03:19 -0800 you wrote:
> The family struct is auto-generated for new families, support
> use of the sock_priv_* mechanism added in commit a731132424ad
> ("genetlink: introduce per-sock family private storage").
> 
> For example if the family wants to use struct sk_buff as its
> private struct (unrealistic but just for illustration), it would
> add to its spec:
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: support generating code for genl socket priv
    https://git.kernel.org/netdev/net-next/c/ba980f8dff54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



