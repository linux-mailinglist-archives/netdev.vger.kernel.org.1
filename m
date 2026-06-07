Return-Path: <netdev+bounces-296242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0bWQD0l3JWq0IQIAu9opvQ
	(envelope-from <netdev+bounces-296242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:51:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6D650AC4
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E0hw2Dgl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296242-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17C58302E914
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92313A7D6F;
	Sun,  7 Jun 2026 13:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3F3A168B
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 13:50:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840209; cv=none; b=Lnyq7Y7yNqTxXiAdBTTPM+xhnCmxNyV1nnKV9x5vmRxzYg4LkeEabwbkzG9Pa5MjTlbAcihhck0o1Ne6Dfhq9drMvkD3iNXrfUyk2SmOhXqZiMcazBxDYj+zv4AmX9ga2Egi7bGik13rqAwWZxx79OhuVPJZoeMiQRRDEf799wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840209; c=relaxed/simple;
	bh=9GLr3W/C27l7wi3jTPscT0oA+dWVBMWxpCbt5ct0aFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AIpsm1jvyClxWUcBgCvz25/WC0v/x7q4dimRADIT7p8XAdjzSLKFO2obGmwMh8zXCrK0IKcwVCyZWqaBR9aNLWBpNcPn1vLWBdMV6dx6Kz1Q9qPDqPzPCZDUX2iewHS4Kl0yPVz9A5kYtYXwlSosGGGnL+JmsYcDVQRJAsV2oFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0hw2Dgl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9381F00893;
	Sun,  7 Jun 2026 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780840208;
	bh=EYNTsZO0HL50h/LfAV4ZCo+aZEgVrWuydy2okdvrwUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E0hw2DglEZwWsT+2TfS1IZYCS558C311C2+RwniWszo1a1AJTS1rttC9+6bj18vu2
	 qH/z0mQoRLDbGKV3BTzFemnAY36RwggL8SfaaWw+4seYloXg7iR1d/Z+Kv0eTj2+1a
	 B+E7PAFVnebP0Qe0ZD4fthbjQIFU+X0vC6Hlz15bhnPsc9Eae11T/f6HXIkL1WAcrB
	 iionbG7i+qsOL7qq6zetv7uHJkK+3rj+xvmx28LYB/uQse1V4ZNUGeiawTJ7dTYLxv
	 +sSysSjqNbZUgkQ4PNpjLG8sHDARzlUF8zSrfqX34XiufP0AH3QRHfn06InERvggCl
	 BkyCVu+Yy1HvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567D83930C8E;
	Sun,  7 Jun 2026 13:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 iproute2-next] man: iplink: fix indentation level
 after
 inet parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178084020790.216406.14685803948534975500.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jun 2026 13:50:07 +0000
References: <20260607065715.4573-1-fmancera@suse.de>
In-Reply-To: <20260607065715.4573-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-296242-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79E6D650AC4

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun,  7 Jun 2026 08:57:14 +0200 you wrote:
> The indentation for inet block opens with +8 but closes with -10. Fix
> the imbalance.
> 
> Fixes: fdb064bf64e5 ("iplink: add support for setting IPv4 devconf parameters")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  man/man8/ip-link.8.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/2,iproute2-next] man: iplink: fix indentation level after inet parameter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=6592993853c0
  - [2/2,iproute2-next] iplink: set NLA_F_NESTED for IPv4 devconf attributes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7340b539841d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



