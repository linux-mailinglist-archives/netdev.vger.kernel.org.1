Return-Path: <netdev+bounces-304958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l7myLTOAS2rZSQEAu9opvQ
	(envelope-from <netdev+bounces-304958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4654B70EFF1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:15:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q5vTVgZX;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304958-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74240301D61F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07BF442117;
	Mon,  6 Jul 2026 10:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF28442101;
	Mon,  6 Jul 2026 10:10:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332625; cv=none; b=N3Oyo/oG15P1bu+h+RCVQche7XZ/Eso1bNN/T6xCwGd62/7zmI5ndvdryERou/j6nZYQljLc4kAhHZQH/PVdeUUKMUW+9Jw7ZuzQSDiaLu1RcZk1EjA+3dmTwxpNxHRk+VRAb2ruknaQqn3TVFOtDW2Pc3Z0wpI+9UJBv86dOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332625; c=relaxed/simple;
	bh=ULpJKK3kasidvzMp0YKddxDBK4Fug7wAZV3CDP3H25Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPyVT04H4Np64xxAHiUOG3gE7KIxsbC8ZfBkkKTtiDk+UttFmg7OZexkXdOhgCSolK+O5mSp2FbppshSKpb0zsbPJfhHCukqwUD8bMw7SG5jVF5QoK01r5qGJlI1lICshPoTW7LhE+RtPQBPneRPvgt1o2gI3DQixgsCJXuVNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5vTVgZX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F00B1F000E9;
	Mon,  6 Jul 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332624;
	bh=qMbOGNXzEFrpIDZTZIODDwW/jF3aOiZ7lLkdfUV5tQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q5vTVgZXHDdRhkpHWZL5CN51oUP50VZd4wMroOjQ0QQyHSR/AlqeuW70b6cP1KQRm
	 03qpsI5CV+O5gMTbbs3x+bXmTUdsmQlGKaklgqXvk6ScA0XWJJigsyyBywlz/YcAGz
	 n46fcbbk2cmk4rFuESeU5GM8rAWcxc5K9023SxLsgFZpGq2DFKufXC19PtNbCnt3mv
	 9RdXwIHqf27njN0zKymSWIYjhhDlxNbiqqEFrQCvtqB0dbDS8K2FAJqnpR6uP+3Ne5
	 1t8p+duWOcOhBHZSMxSLSO5RKUW/UcVJZWnOw02iyUSxlgO6piS0rbVeXbOHomUFup
	 99gRUD2VMmlHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CA3AB1391;
	Mon,  6 Jul 2026 10:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] qede: fix off-by-one in BD ring consumption on
 build_skb
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333260514.479270.2191423022943795278.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:10:05 +0000
References: <20260630164623.3152625-1-syoshida@redhat.com>
In-Reply-To: <20260630164623.3152625-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matvey.kovalev@ispras.ru,
 Pavel.Zhigulin@kaspersky.com, jamie.bainbridge@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ispras.ru,kaspersky.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304958-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:syoshida@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matvey.kovalev@ispras.ru,m:Pavel.Zhigulin@kaspersky.com,m:jamie.bainbridge@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:jamiebainbridge@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4654B70EFF1

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 01:46:20 +0900 you wrote:
> qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
> NULL return from qede_build_skb(). When it returns NULL under memory
> pressure, the functions still consume a BD from the ring before
> returning NULL. The callers then recycle additional BDs, resulting in
> one extra BD being consumed (off-by-one). This desynchronizes the BD
> ring, which can corrupt DMA page reference counts and lead to SLUB
> freelist corruption.
> 
> [...]

Here is the summary with links:
  - [net] qede: fix off-by-one in BD ring consumption on build_skb failure
    https://git.kernel.org/netdev/net/c/a0a558ca7e75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



