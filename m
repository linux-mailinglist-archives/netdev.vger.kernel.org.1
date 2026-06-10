Return-Path: <netdev+bounces-297732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBufKz6DKWpoYQMAu9opvQ
	(envelope-from <netdev+bounces-297732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1666ACB5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ihtP6AcR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297732-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAA8A32254D3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ECE43CEF9;
	Wed, 10 Jun 2026 15:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58198426D02
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:20:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104814; cv=none; b=iz/N1dSPZKDaER1U9Dja/MhRh1wr2aF55y1ioIPbQ8WBO4QNDQ1f241ID/z+83BBN9Evwhk70VBiHdybf3A1Seir9KLV5817BqzKnfNUGnG1wf64FsM8VvAX9oUJzh8Xc3o5gQCAgZkkl4BuYg/Oq3mS1MwQceaizPRF8rKHeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104814; c=relaxed/simple;
	bh=ilLw4OUtaGj/HXnK57a3F4bdsEzoFRGwCcG/UTnv8/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KXtHOt09tFflbvUGELk1Pd+UK5iLds3S5uiKLbhl7gm/8NIVERrnqHt5CfGtaFnduVeX5GyE9rnfBtCMpdbUOPlVCrBtc8h6DK2AHoI9bSBXFZntTuPwXwZZ5hpG72BHu39RDi3kfRJF6rHF2DibCcrfQwLEwD+ZDHLLdXHRWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihtP6AcR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060211F00893;
	Wed, 10 Jun 2026 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104813;
	bh=LvszZUmEcxZvYKkemMwL6DwPV+e5WnyC4a9T2we0kfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ihtP6AcR9KH8vEa3psU01Z7tiaGClAk2AX71w0I0+v1+pD7azbfO1fBocxFMI5ZFW
	 5bRgI9a5jPnzTmT2lpxXSYCJFWMhRYzZC0kF2fICjj30Ew5OnoZPLPHHWVomsFyQBh
	 TN8Sfe5Byut7nbylf0Ce7U+k5Ocw9IJ78aumWKdmAT3bIVN549cCVzLfiNa1XlHBzl
	 3Hq747GHvROL+AHBQWdjc1TetjCCBJ5pMqH+oa2K3P8gF++80V7lJALkjnVgf3FPM8
	 y7kwl8E6/j+1bFs6p/BZeOtw82WZZWgDwYmO7i1aBGWOV6DtScf+r+AZucfa8x4SXW
	 qV8Diui3D21Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1972A3930D5F;
	Wed, 10 Jun 2026 15:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_vti: fix incorrect tunnel matching in
 vti6_tnl_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110481063.3089075.2309365792457220990.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:20:10 +0000
References: <20260608164613.933023-1-edumazet@google.com>
In-Reply-To: <20260608164613.933023-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, steffen.klassert@secunet.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com,secunet.com];
	TAGGED_FROM(0.00)[bounces-297732-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:steffen.klassert@secunet.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDB1666ACB5

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 16:46:13 +0000 you wrote:
> In vti6_tnl_lookup(), when an exact match for a tunnel fails,
> the code falls back to searching for wildcard tunnels:
> 
> - Tunnels matching the packet's local address, with any remote address
>   wildcard remote).
> 
> - Tunnels matching the packet's remote address, with any local address
>   (wildcard local).
> 
> [...]

Here is the summary with links:
  - [net] ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
    https://git.kernel.org/netdev/net/c/a5c0359f5cbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



