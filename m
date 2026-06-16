Return-Path: <netdev+bounces-299679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kFZChyZMGqFUwUAu9opvQ
	(envelope-from <netdev+bounces-299679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:30:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D368AF0A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:30:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZB4XjQzH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299679-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FF1F3019383
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37C18C933;
	Tue, 16 Jun 2026 00:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB7184524;
	Tue, 16 Jun 2026 00:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569817; cv=none; b=NfsT9P2WXynZAiT53VcFT6xHCvom+TQbpIIIj7LdF3rrJ9wZ74fpF54/Ef6KDo7liLphWNRQxYA8obZ0xG4khOLz5tDkDkDJ2fvQ7eMucOL1f6e2paQg9ESEuZSccceNqH5U2z5MDAxBNjwd835IILussYHBwSaFTTQ2OVwNj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569817; c=relaxed/simple;
	bh=/RCce7VVBj2CMcDSw4BGLuewoLeUagVkD00GojLaUZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IOEfQxx/7QYq9rUKyKg9B1xY4ROJdEEV1ORM4Rzsqq6lCRdzgzhAvBQFdvAndFQJibYt60Jy8grgBpJZHcl3Il5cQLRGcIHJcyyPP7BGvSrkvw89PREB2dC5tlQGwxqJXEzrELgSFiydMD7ejdrVg1Cr7btT/WP9QcvDcnZbRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB4XjQzH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C421F000E9;
	Tue, 16 Jun 2026 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569816;
	bh=Im5+CB+xSylCzgvpEjwkFEG6wXdFKCGk6Uf4BUFQh7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZB4XjQzHowl0yBjSZCaKwPMwbj+bo+dRD9ahPJ+izOVM4bo2RWcBFdusOrM9Yv2wC
	 sdDNhsfR0z0fdMiAnSBXRf4DDwv8hCeCot8ysP9wUiwELySIyhMLW/VqDARcTRQ+kf
	 26togSnwpDjRzFC2R3kUyiz9srImyrIm7AAmtk+1fLxAZwYNUEEmvdJADxZmr5XfTT
	 7uxOYGaVnAwfUnILhI0E9/HnxmT3wUAdj3iJukJngfOcu3iJQRCPYxPFkyh2rsJhCm
	 T7gxoCPDvUnpKWaBLwRmLUGimFic2NqYFU+yCkkFqATwfEV75MFjWzP7vws6ncq8L3
	 +qu795R0+BnbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9394A3839A26;
	Tue, 16 Jun 2026 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/4] net: dsa: mxl862xx: SerDes ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156981114.355428.9587351171109026263.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 00:30:11 +0000
References: <cover.1781319534.git.daniel@makrotopia.org>
In-Reply-To: <cover.1781319534.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299679-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 847D368AF0A

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 04:07:02 +0100 you wrote:
> Add support for the two SerDes PCS interfaces of the MxL862xx switch
> ICs, which can both either be used to connect PHYs or SFP cages, or as
> CPU port(s). 1000Base-X, 2500Base-X, 10GBase-R, 10GBase-KR, SGMII,
> QSGMII and USXGMII (single 10G or quad 2.5G) are supported.
> 
> The firmware only added the API to directly control the PCS as of
> version 1.0.84, so the PCS features are gated behind a version check.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] net: dsa: mxl862xx: store firmware version for feature gating
    https://git.kernel.org/netdev/net-next/c/937137db7914
  - [net-next,v6,2/4] net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
    https://git.kernel.org/netdev/net-next/c/c1034332003f
  - [net-next,v6,3/4] net: dsa: mxl862xx: move API macros to mxl862xx-host.h
    https://git.kernel.org/netdev/net-next/c/7dab839724ed
  - [net-next,v6,4/4] net: dsa: mxl862xx: add support for SerDes ports
    https://git.kernel.org/netdev/net-next/c/13ea4d4888c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



