Return-Path: <netdev+bounces-304618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5kEHSDpR2rbhQAAu9opvQ
	(envelope-from <netdev+bounces-304618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71E7046E2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:53:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ZuF1S/Nq";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304618-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304618-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69426302AE1F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B246305047;
	Fri,  3 Jul 2026 16:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03472E542C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:50:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097434; cv=none; b=Ou/v4pk2WiPNrE11kDDO8JPhIIiJtOnrs76rtJMmLaHJlbIvI1W4I85uqxxvyRm1dKBIhMCwhB1Ey0WAn68wsKB/RuahuTzJFpo05fQM1m6a3+wZfeIbsVt/+rZ+ep3JqixKGVHz2jk8EB1XpuONuDF5nJ46s4XJUD0OB7dXbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097434; c=relaxed/simple;
	bh=JIQUjt3S7+YB0FzPt5VEq0f9aVEvS0xnobxdpTDN9bA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Frq+nx7Z8DWT7elSHyv/UIqHGuabJVl6T4ekaJoCZwwv/iZjyd9EYwxlA0BGwWWGN3LeIwhUwo3OIRErXO+jeCn91FWgh2aYMm5gH4KsnSw+AR3sOqNS5buCdoOOSHVux2T2xzgKgRly39ZB38Vy5FlIThQhM1WisLec/K6ki0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuF1S/Nq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE91F000E9;
	Fri,  3 Jul 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783097431;
	bh=0qH8rEh+l3GjUTgMfTCZKgAE36ueMmwrHG2H14CpK1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZuF1S/NqVo5v4rt75MSOUDQXDGI7eHedaXmmdbqYfoD6krrrqn+D+RIAQpJVx7sfl
	 6PTTlleyYXlkCLw8D1LQFZPOIOYhpZXbkThzXWiNmVXjRdS2gBwBEdDUZrz/ID3XS7
	 CjEOx5T8lwZ/JNNvqKiLIdbVuqbNlsMI2qgcys2UM43DieNoabBA9oNDTFKQ3QJTC1
	 w+TqzSQPypDC6UMDCRACyi36d0GvCcaWU/txp+X5xGqqKAEFsac31s1wNwwQRTyRkV
	 /GmE0vvSEiq6bHYnP4yrVbRikQuCPCypVzbY7b7VuB0OcsqOTbyYc5Aappx62IhzTO
	 uM6nY+myqEt0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 312B23939356;
	Fri,  3 Jul 2026 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] macsec: no longer rely on RTNL in
 macsec_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178309741388.3239271.4567949142803609843.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 16:50:13 +0000
References: <20260701094341.3218199-1-edumazet@google.com>
In-Reply-To: <20260701094341.3218199-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 sd@queasysnail.net, andrew+netdev@lunn.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,queasysnail.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-304618-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA71E7046E2

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 09:43:41 +0000 you wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on fields that can be
> changed concurrently in macsec_changelink() and macsec_update_offload():
> 
> - secy->key_len
> - secy->xpn
> - tx_sc->encoding_sa
> - tx_sc->encrypt
> - secy->protect_frames
> - tx_sc->send_sci
> - tx_sc->end_station
> - tx_sc->scb
> - secy->replay_protect
> - secy->validate_frames
> - secy->replay_window
> - macsec->offload
> 
> [...]

Here is the summary with links:
  - [net-next] macsec: no longer rely on RTNL in macsec_fill_info()
    https://git.kernel.org/netdev/net-next/c/5a5ebefdab9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



