Return-Path: <netdev+bounces-301815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rW+OLCeAPGo1owgAu9opvQ
	(envelope-from <netdev+bounces-301815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:11:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094BB6C2153
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MHIdDMcG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301815-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCEA30A6AB4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992936A36C;
	Thu, 25 Jun 2026 01:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA3368296;
	Thu, 25 Jun 2026 01:09:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349757; cv=none; b=dN8va5CMcA+xBW8EZ0FS1e3MWvRPBsqzrdqRXkd219Hwwb9l4TT5zwboOGtO2EUX2/JoNpA/pMUfEEQLJ6W21bH9YbwkZ8i1YUli+9iMKeM8lQ/3IHgFLu5WYGkHUy3hCgmcjEcY6qXRH6K7bnUOSdt9OZniX6JlcJmGoLk97wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349757; c=relaxed/simple;
	bh=fuTFkVyS3OF/WN/Q34+waGSmg3FQhJJ6T3aBWUi6dVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CWXkMCcj4plzIDfV/fysu7Z9LPYmUO1rGVNELHaYxDeroMAj/8DFyGr4HOZknfN8aPLXQJlAmiL4vlx3sl8p6Bk3U8BERE0ydPn4YC5xXuP0895cIR1CIrOW/CKEdMNeA+V2xlUA0qk42mPBTbDAZExWNt5s25a+q3RCL0kT0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHIdDMcG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A6E1F000E9;
	Thu, 25 Jun 2026 01:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349752;
	bh=Nj25xJQtIXZclHFrcwxFe9gDkwAEVgsPYTZ0/bIje5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MHIdDMcGjczjGaNDmgRo1k4Bmpk/FhjcFglfxPIfdhm14x9vyMlD7snKM+bDppshA
	 G21Ghk2rogNEWHPHhPyq3nlWWSK/krBG/sNukjLVKJdGVRJ4omPwAVigni23WZC4No
	 wiReTRQ+kZnZCR/DJyseGHlf4khI7xjdW6g8EM6uAmuguXvjI5pfAtCzshRY8ASuKJ
	 Zcui5dyDjW2qEKu6mHG9wrD4/XMjgjE43pKcbt2iqTwuwjosUQqwREcG7sfSsI60yg
	 h20+RjooonRgcFJJRLCx7H3MWY8pudktyzCghwfrNc1JVTH+F3Wu6NvRo9pbhenUp4
	 iE7sERjQuX19A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197B03AAA0F5;
	Thu, 25 Jun 2026 01:09:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: realtek: fix memory leak in
 rtl8366rb_setup_led()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178234974075.3045401.10753543727590918296.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:09:00 +0000
References: <20260618140200.1888707-1-mmyangfl@gmail.com>
In-Reply-To: <20260618140200.1888707-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, linusw@kernel.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, luizluca@gmail.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301815-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 094BB6C2153

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 22:01:55 +0800 you wrote:
> led_classdev_register_ext() only reads init_data.devicename - it never
> stores the pointer. However, the caller allocated devicename with
> kasprintf() but never freed it, leaking the string memory.
> 
> Fix it with a stack buffer to avoid dynamic buffers completely.
> 
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()
    https://git.kernel.org/netdev/net/c/056a5087d87e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



