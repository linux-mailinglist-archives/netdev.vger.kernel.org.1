Return-Path: <netdev+bounces-298828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ILUL96dLGppTwQAu9opvQ
	(envelope-from <netdev+bounces-298828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:01:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C167D1F3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VHBS9vVP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298828-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 763FF31A4DD4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9B125AA;
	Sat, 13 Jun 2026 00:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E709AD24
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:00:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308824; cv=none; b=JLD6980u2JyH2kLsNzyEWY/32fhKpzz5lGd2dDk/ivOX42phvJ6gDZUcIvyfDkfssuONaieQSnqfZKftsfmuSpkjPvhed7TJSYsnIkmZwsNCT/WNWiXSAZYfG6dT+2AiqHou5dlCdiGXuQtalvtFa9hmf395BFTW3L3do3l4ySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308824; c=relaxed/simple;
	bh=pAbKAP/ca37DsM05SLHhwqp5LgoV87Ua3r0Lm8/21YU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E3zscGV+EgM6C8s2hWG9/pH53pgUkzXXkZ6mht+YwAghETclmeFZNheUVAKt77sXcTgNFscGWpbRwhn/xq6I7/ocv2ESkANDT0PDRgq3xQQfC9RXwOTJWytEPAJbZPn/7hZGsUwqdejwITnHo0jAzGxSNrz/BZZLEGWa8YqiZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHBS9vVP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DA91F000E9;
	Sat, 13 Jun 2026 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308823;
	bh=5ipQ/0rqX8qisOPGqgfsHe084NKL9wUTaaPjES2+AcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VHBS9vVPYJKs1zuBgegtuKkj6PGi4rchcluCi2vk1mrpit2N+lkhPWikjGxXLnWRN
	 6ys+C17R/cZ9GOE8oBf86B0GExbSOSDy7BW686uBUrHJC3CmlfZmQtU6uJvDJYXf8N
	 CH5dS+mclPLMCRrBvJRJzvyfGc1lVgIHf+IoNE26OkGg3EDz0Ulna3+YDfov/CO/23
	 2HZ6kPwApKe8N5ru6fGFFRnqKq2NYYVKF7k7x4mxHLCjxj6vuU0NrOLboyWBnSe1VD
	 uDUEcOZ09e86kO/MBvvyllXEuFfYmev3qt/V7lZdgvdJ6uvXSW/AWkxr8ZzyY4An7b
	 K4gs32mBtS9vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C139E9605;
	Sat, 13 Jun 2026 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: remove tls_toe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130881937.1297459.5702308942363851080.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:00:19 +0000
References: <cover.1781165969.git.sd@queasysnail.net>
In-Reply-To: <cover.1781165969.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, ayush.sawal@chelsio.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,chelsio.com,gmail.com,kernel.org,davemloft.net,lunn.ch,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-298828-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:ayush.sawal@chelsio.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 125C167D1F3

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 12:21:32 +0200 you wrote:
> This series removes the tls_toe feature, its single user (chtls), and
> cleans up the EXPORT_SYMBOL()s that no other module requires.
> 
> Driver changes only compile-tested.
> 
> v2:
>  - fix small issues in the docs clean up
>  - also remove NETIF_F_HW_TLS_RECORD (Sashiko)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tls: remove tls_toe and the related driver
    https://git.kernel.org/netdev/net-next/c/cdae65fc43f2
  - [net-next,v2,2/2] net: remove some unused EXPORT_SYMBOL()s
    https://git.kernel.org/netdev/net-next/c/f51a442dc15a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



