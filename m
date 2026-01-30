Return-Path: <netdev+bounces-254988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIMeGJ4cfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:51:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B71B6924
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8A93010508
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A3332ED3;
	Fri, 30 Jan 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKyTj6OU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884B332EC1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741418; cv=none; b=PjKTFnaJ0Bo5nfxDhZU2clpAMq0M1Q2+WnWbEuD88PhzJG3pnmcvyZ/woKkyXHO00f2xmKGW5+sRZOkLMXqixqXevv8/aqdghQyxjTYZFTE8ODxQHNeI57xDhy9P99ZNmsqCDsZYtH3FFVcT9GaXhRpmDArwUTWRQ+LtLjZkd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741418; c=relaxed/simple;
	bh=yUqlSmNESA9Ay45gsaugssFFEUHO6tjSddLgRx9CGZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kTHevmdH9Kucu081LW3dbW1/3qc87VeP2BIrlUP1CKM/XsAeLxBtbaKJY7eqOCGhbtp6jjnkt4xpWsqu/sEiKqPb4ZLV0LwvqfGbSutKXpDSUy3+wFn/Mj5EFUmk275ikLU4x2amZLAolT5hQxQzCTYXGZSq16zUnecGSrnTdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKyTj6OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68206C19422;
	Fri, 30 Jan 2026 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741418;
	bh=yUqlSmNESA9Ay45gsaugssFFEUHO6tjSddLgRx9CGZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKyTj6OURO5O+0MLCYhYqcyTsGmWp/9cjpCruhwLSReco7pzE7lgcQY4fCZdgdlEB
	 4RK+uYwHP+CQ2H6SlSseckXAlSPaQ71pmrGNk2/ogI7E1uZszzuFllpOJELuc7uG//
	 SuctNS58ZX8UlGD3cRXYflMxi9J2GRLsOVT+g8wsCmTe/PPq8L/CztXUj41AV5uMe/
	 EZf4hznEye6DMBQQj53H96AXdOfgFLzp8zgV76nPOSVoCgkAKFo904Q9Rq1w7A1jwc
	 st1nXSd1/6UUJ5kPw20DJnPN6IWNN+7D0a/oZD5EQLuysMEFebNwW2387dcl0p5DWV
	 JVKrjK4E3DXcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA47380CEE0;
	Fri, 30 Jan 2026 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: fix potential crash in
 net/sched/cls_u32.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974141110.3149010.14820684978131291126.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:11 +0000
References: <20260128141539.3404400-1-edumazet@google.com>
In-Reply-To: <20260128141539.3404400-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 km.kim1503@gmail.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254988-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7B71B6924
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 14:15:37 +0000 you wrote:
> GangMin Kim provided a report and a repro fooling u32_classify().
> 
> Add skb_header_pointer_careful() variant of skb_header_pointer()
> and use it in net/sched/cls_u32.c.
> 
> Later we can also use it in net/sched/act_pedit.c
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: add skb_header_pointer_careful() helper
    https://git.kernel.org/netdev/net/c/13e00fdc9236
  - [v2,net,2/2] net/sched: cls_u32: use skb_header_pointer_careful()
    https://git.kernel.org/netdev/net/c/cabd1a976375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



