Return-Path: <netdev+bounces-257741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FqEJaTLhmnGQwQAu9opvQ
	(envelope-from <netdev+bounces-257741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:20:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09933105009
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 06:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF53E30157C3
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 05:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375DD2BEFFF;
	Sat,  7 Feb 2026 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIUnBlUB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E482866
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441634; cv=none; b=C90QiXKc6utbXJ7NAJNQFVSQVxrkzGayId+5mwISjkIkSz8+w5xG2yj5viaipyzkcl2lWcdo8dE5fzbPxaTM/9Mr9VfnlS+2bQOFMqmgwZSIHid/YuR42g1tSnQJMgCB4Ig7DXCXtNJkJ68uay5eJqfrJujP+YAPOGY5Giff2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441634; c=relaxed/simple;
	bh=9x+/NyzfUO8QVEd8MJRCJXQ42tHjEEkzkQoT5p5Ok6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WIMz7e+BXAUI4cOkA7DB3+o+XJcOJ2d0OMM2k9yaey46n4e3RH5UByL9zEOSIm3FkMoI0K/k1p2x0JZJ/KejludW9Oa5/5jDgFitwoPK9ehPL06q3zW0soJ4pXLNYQnUSQfpPA04NWnVNgdKAWAhAiIsm2idGVj+BaYhP/m+ITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIUnBlUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C3C116D0;
	Sat,  7 Feb 2026 05:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770441633;
	bh=9x+/NyzfUO8QVEd8MJRCJXQ42tHjEEkzkQoT5p5Ok6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JIUnBlUBkhC032kolSndWpEyasdXRDfMzK5xbEV24dRHzsZRz+sL7gR15fDL1L2I6
	 E4UZhcltlVoxa3UybHCVBcNHHtP0TwtGdim05Wl7fzyRe8LzBzKPNO9GZbcmElbXaz
	 ALrv6dee6DOkeZDdgW3vTEfjWbe6Ou9JR2U4OY1xz1wqY+ZFnEECyZ64+TkeoAiY6B
	 vwPsaMPoHdZ4Li+Ym1P9AFF2YHU2rq6wubA4oVQBUGB64xAS23ubTNlpAmq/QhfvAi
	 tKqvK6jk5XYXmp4KPJhQGp4itg9DbT37/veC6PrfHcYRNnKTYv+WJIOJbv8wCG4bfl
	 nEGVTHUGFB52g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C25823809A1A;
	Sat,  7 Feb 2026 05:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/12] BIG TCP without HBH in IPv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177044163058.1196512.18350050007978328024.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 05:20:30 +0000
References: <20260205133925.526371-1-alice.kernel@fastmail.im>
In-Reply-To: <20260205133925.526371-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org, razor@blackwall.org,
 shuah@kernel.org, stfomichev@gmail.com, netdev@vger.kernel.org,
 alice@isovalent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257741-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,vger.kernel.org,isovalent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 09933105009
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 15:39:13 +0200 you wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Resubmitting after the grace period.
> 
> This series is part 1 of "BIG TCP for UDP tunnels". Due to the number of
> patches, I'm splitting it into two logical parts:
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/12] net/ipv6: Introduce payload_len helpers
    https://git.kernel.org/netdev/net-next/c/b2936b4fd562
  - [net-next,v5,02/12] net/ipv6: Drop HBH for BIG TCP on TX side
    https://git.kernel.org/netdev/net-next/c/741d069aa488
  - [net-next,v5,03/12] net/ipv6: Drop HBH for BIG TCP on RX side
    https://git.kernel.org/netdev/net-next/c/81be30c1f5f2
  - [net-next,v5,04/12] net/ipv6: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/1676ebba391d
  - [net-next,v5,05/12] net/mlx5e: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/bda5896e469c
  - [net-next,v5,06/12] net/mlx4: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/94379a588037
  - [net-next,v5,07/12] ice: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/8b76102c5e00
  - [net-next,v5,08/12] bnxt_en: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/3f1bff1d7fd2
  - [net-next,v5,09/12] gve: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/275da93ce2b8
  - [net-next,v5,10/12] net: mana: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/c0165fcb8d9f
  - [net-next,v5,11/12] bng_en: Remove jumbo_remove step from TX path
    https://git.kernel.org/netdev/net-next/c/28df1c69271c
  - [net-next,v5,12/12] net/ipv6: Remove HBH helpers
    https://git.kernel.org/netdev/net-next/c/35f66ce90037

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



