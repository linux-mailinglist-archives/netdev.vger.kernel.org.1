Return-Path: <netdev+bounces-301533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wa71K5Y/O2rfUQgAu9opvQ
	(envelope-from <netdev+bounces-301533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:23:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 027636BAEB2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mn8Bdgww;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301533-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301533-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3B530EAA4B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF692F3C3E;
	Wed, 24 Jun 2026 02:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B12F360A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:21:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267665; cv=none; b=cQY9WV/BKR4gKt2PcJLIDE4+OJOxqEG+RKKwtXL6FSnbFswuRkltAZST/D7jNflvHw7rCQtqhVuRc3EFqgtJQPRfGTeI+xu6Bes11jFDBT2osjBLrlwQ4+egAFcRV3RGcRAOMyR7fGGFyHX65m9jYahpbtOYL7eMyaSeiKFbiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267665; c=relaxed/simple;
	bh=9vK3ARYUswW0jK1n5qSYHa//Zy1lqRO6FU1yh3x2qhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NuyPJQ7oeG9UTlUnLgaVqrxda6FIuFmg+Hkyi+I2iz5Dsyv+yqC/Rzm/2F6Va+yLFIYeWNoi6NJrBy0RravS5rDr2SJaqy45pNTrlGY0ZJnROVXoYhtvzXkty5F3OY/xcOR8ToC/njVOCoIfFHT3RTNsngONZPwqeicmdM84ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn8Bdgww; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69BE1F00A3A;
	Wed, 24 Jun 2026 02:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267662;
	bh=fk07/PL9n/7QLQndLdfQLuuvY5eviPEFkpY8fpfoE34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mn8BdgwwwRtogNF3BqyGxc42fEBpEN8M894TI09D21Hor0WeYWfHjfgbzds4h2vKm
	 zuUqD1Yu17ENaaW2dO4Giq9FOUb5IefAYBZUtJuVwtO3WDJnq5qb8ZUCuukvcQikxv
	 IZBBeCVeZbavCMygwDh8yZyXl0AEveE+R695sXDZvwSpDDfGheDozg7Sw/MSELTu29
	 1/Bdca7aCAVHiFbUQCk3KELXfk49ZKM+tvROC6dM2SIuG/mJ+H+3YPFRC2bk0mok1m
	 ijwb4dZcpvgS2wtOWkfLP0FefSbZS32I06zcVdavqtrPlNkvNOwzjipYsBSOC1+Mys
	 GS6BYYr/goUgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19778393102A;
	Wed, 24 Jun 2026 02:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: cls_api: Handle TC_ACT_CONSUMED in
 tcf_qevent_handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226765162.2513445.45924592615506529.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:51 +0000
References: <20260620130749.226642-1-jhs@mojatatu.com>
In-Reply-To: <20260620130749.226642-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, zdi-disclosures@trendmicro.c, security@kernel.org,
 zdi-disclosures@trendmicro.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301533-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:zdi-disclosures@trendmicro.c,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027636BAEB2

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 09:07:49 -0400 you wrote:
> tcf_classify() can return TC_ACT_CONSUMED while the skb is held by the
> defragmentation engine (e.g. act_ct on out-of-order fragments). When
> that happens the skb is no longer owned by the caller and must not be
> touched again.
> 
> tcf_qevent_handle() did not handle TC_ACT_CONSUMED: it fell through the
> switch and returned the skb to the caller as if classification had
> passed. The only qdisc that wires up qevents today is RED, via three call sites
> (qe_mark on RED_PROB_MARK/HARD_MARK, qe_early_drop on congestion_drop)
> red_enqueue() was continuing to operate on an skb it no longer owns  in this
> case -- enqueueing it, dropping it, or updating statistics. Resulting in a UAF.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
    https://git.kernel.org/netdev/net/c/a8a02897f2b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



