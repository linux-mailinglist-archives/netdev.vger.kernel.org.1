Return-Path: <netdev+bounces-292010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBHNA2U7FmpCjgcAu9opvQ
	(envelope-from <netdev+bounces-292010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:31:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2014B5DDF70
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6086B30158A8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6A2EF652;
	Wed, 27 May 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NshWSS4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF32DB7B4;
	Wed, 27 May 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841807; cv=none; b=gOnXd2HyQEfR/If7grJN8+5FC8vb6o37cYr0/qbNLuYfat30zD+hOv9KzDxL8YVVdss9DmfD1Q81ZDw+JEqurd/QFq53DdG0cfq93cChO6P0iPpA6fPabCuL5ekNUldKOhv6xqtsThoPsoScgfN/Zat9QqzP3rs+2VGWtTHY6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841807; c=relaxed/simple;
	bh=wp3Tl5CZ+2Ak2nsfCtU4+boSUsUxsqPfF9/tXoZCZ9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CqYKdn2/QuQVd/eSsef9f9gfhuxLbUNO40y2GSg7BmRPPmRanDTmHwYWifNFN6jTDZFSaLyvR+rrcCoHE1yEnmA0W9uy4Ec3gi5QKs5IVzSUvfqq7c5SlAwfe9ItBnWp0R6fIWrFyKu0bfHBlE8GMYTqtiDIQ8F798OPsnBQTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NshWSS4r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613481F000E9;
	Wed, 27 May 2026 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841806;
	bh=1Z60F6cDVz3kodQ30SO9yMH87eRiv640ER6fhZmMojY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NshWSS4rinS2kuC7P2tPqV3mbRosme42bFKpCOjYrcCIqRwZp4CZijKvGc6J365ys
	 JuNmiteSLhoAc16OE71ttAuYcvh1rZHJ461dmPipvfl+fJ4fEcDLvuP2kDJbAU0V2P
	 En7qCh08cm/zvBg3usEtMaW+Cqqs4zeF7RtFZGDLdCOeycRb2ld6rpCLfRby8LAAUU
	 mL7d/U7CAr/s2H1PrdQItBXvXBlgL58BNaRfuJWnP58/loAVgLQunULHZbrYcEpWAb
	 cuRHuhac/TKrxI+rKV7aex2CgIbGiXWv8FX6ksD/J1YE6jHC8kZwev3pgEjXXD8Ff7
	 NRnpD7+1WuYHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3F380CEED;
	Wed, 27 May 2026 00:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] Add OVS packet family YNL spec and
 unicast
 notification support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984181194.4027067.4872626990615141837.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 00:30:11 +0000
References: <20260522174154.720293-1-houminxi@gmail.com>
In-Reply-To: <20260522174154.720293-1-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aconole@redhat.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292010-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2014B5DDF70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 01:41:52 +0800 you wrote:
> This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
> family and a bind-only ntf_bind() helper for receiving unicast
> notifications.
> 
> Changes in v5:
> - rebase on net-next to resolve conflict with Ilya Maximets'
>   ntf_listen_all_nsid() (requested by Jakub Kicinski)
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] netlink: specs: add OVS packet family specification
    https://git.kernel.org/netdev/net-next/c/b82bfddc46e2
  - [net-next,v5,2/2] tools: ynl: add unicast notification receive support
    https://git.kernel.org/netdev/net-next/c/b74e71b6a986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



