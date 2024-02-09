Return-Path: <netdev+bounces-70427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1984EF47
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4441F29955
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951A125CB;
	Fri,  9 Feb 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4RyDntX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108F4C90
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448269; cv=none; b=Nl9hvLImIpEblpOMnkoJYLDG69s0HHJelQk5NiyEXsu0GYkyEuvguydf5S5xkhe6CPHf6xBLTCS2CQD/ouuG28BXYJcNWoUxrYtaOpcelBU4U/r71DE/jUYfMS4/fjJDb+vuyCeEa8geZve6wMBrsrtbG5Qgr3T2F3P4F5RRf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448269; c=relaxed/simple;
	bh=DhMWyrnwsxAvJtpSs9jMCf8u/GIkhgKmjB4L2I4MNPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JySbYPEwZj/r6W4AnhILACkoOD0xFn7vBOXHb46ZDHCpJ+mnLn71jLZK+0jayviuWNh6PRb4ldSPXWUp/dMuao2NN4VxiorhyVWj9O1TGxP3+1uOuxm051lSYw5bwiBCkDFe0AdaUCCnS4lAzYrVeBBYRYV1bab7cfAvupOwrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4RyDntX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A095C4166A;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=DhMWyrnwsxAvJtpSs9jMCf8u/GIkhgKmjB4L2I4MNPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q4RyDntXmPkhnB8LdqbtPgnixc7TqRGpesA0flqn/P4fU1BP7SKR7sRU99MccOkth
	 bWukwN43XpbI69f4x9vkRXMzkzjClaDfVrht9pQBonoHtK3hymnxbjDJLltlfDoLiT
	 hl6+CFgOzvHC0WyRJVYMuK1slF2Zvi2rVoQxlbK5EXJiC23R4UiWxqeV++U6zidjpb
	 MR1+nuzC25G4+EyjsQ38iL2g37cNek+iGsYRnA6BmNPkQrZZK7bF5iIQom1heodh7c
	 0rOtdxP+Ah6rZ5SESSuEAAKJ/HldtqTO31Zvw3VSIAjnDQn1JhS5dRezz08GGjEimU
	 +nrKHgheex3Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F910C395F1;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: dsa: remove "inline" from
 dsa_user_netpoll_send_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826838.23533.10102337486281499654.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 13:29:26 +0200 you wrote:
> The convention is to not use "inline" functions in C files, and let the
> compiler decide whether to inline or not.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/dsa/user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: dsa: remove "inline" from dsa_user_netpoll_send_skb()
    https://git.kernel.org/netdev/net-next/c/83acbb9d0716
  - [net-next,2/2] net: dsa: tag_sja1105: remove "inline" keyword
    https://git.kernel.org/netdev/net-next/c/36f75f74dc07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



