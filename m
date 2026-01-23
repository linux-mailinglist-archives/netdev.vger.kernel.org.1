Return-Path: <netdev+bounces-252619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COUeK6jfcmntqwAAu9opvQ
	(envelope-from <netdev+bounces-252619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:40:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE16FBED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1460B301D048
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F03491C7;
	Fri, 23 Jan 2026 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPkrj5xN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFE2D839F
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136024; cv=none; b=DWtd41zHnqZKMMoFcAnGRk5oFDwuefFrN2olnGdnywgzDdgr08rxTXFvxuKhi3cfLOHTfZNKyB4wdByjwuOQFzSuUAnZvf9miqPnWgtP55ogKSHM3hIZa26zmuMkye+8EvPbOIZzblAGSQw9k8Adevvn9rk3EJ6BRKfqTmEsL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136024; c=relaxed/simple;
	bh=e/0SO5+V5elqkfaYz4c6oULJ1oNG1X0Q/ZtHydH+R8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qgKcvA2Z6Ikd6AfKNme9kexK8UGLvUdKyynoYclHG0ro3ic9jBhufUihtE6xll9Quue3yv9xGObCAKIav0FYWqmtYv/1abVWsTI/k4ruGom+vP76QJw8fFxWAtUechW+QWvviUhmfmsWKw2LuGN5itECjd4HN2I7e0x8PCQmKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPkrj5xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E838C16AAE;
	Fri, 23 Jan 2026 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769136022;
	bh=e/0SO5+V5elqkfaYz4c6oULJ1oNG1X0Q/ZtHydH+R8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MPkrj5xNTgr/fa83Opz8M/Q/PEVFptOr/gjXeX+26mlD5UPRXdcTgZi1bmWI+x7Wr
	 5zCbzGsuaFsmLImBDHKSyMsAgGI1rIc+125F/rQRUu9ulOGHzSZ161j+g42OpU7dV3
	 RMrdNKc5dE0293H9me+gXhvFS51lCY3AAUcr7Iy4vVpURD4vCfzi6OMDIgowEHaatx
	 /R1hFSCiKwbiW2/DT8SyS9sKTu2C5D4y9QzD+y9FCbbbDU2Tq+XLdgSxN5unmZN0u5
	 /orH5I3ylUtwls3rvRZs+NvbbGyQLBkAjnec8OOs7XPIY9vhjajlp9nzEkshc5zhCd
	 oktKrGSAADBig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B823808200;
	Fri, 23 Jan 2026 02:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: Grammar update for comment in
 genphy_update_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176913601835.2368645.17164444937232706182.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 02:40:18 +0000
References: <20260121-phy-gra-v1-1-8b4d178939de@kernel.org>
In-Reply-To: <20260121-phy-gra-v1-1-8b4d178939de@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252619-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0BE16FBED
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 19:49:52 +0000 you wrote:
> Enhance the grammar of the comment in genphy_update_link()
> describing momentary link drop handling.
> 
> Found by inspection.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - net: phy: Grammar update for comment in genphy_update_link
    https://git.kernel.org/netdev/net-next/c/0b87bbf65d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



