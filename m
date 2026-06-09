Return-Path: <netdev+bounces-296863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yCv9DtB4J2p1xwIAu9opvQ
	(envelope-from <netdev+bounces-296863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:22:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E465BD70
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XRJeQupd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296863-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296863-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7941302C0E1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DC344D82;
	Tue,  9 Jun 2026 02:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A68264A97;
	Tue,  9 Jun 2026 02:20:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971608; cv=none; b=r38XAMBtmVkBAaABKEYPY13yswp+uNDCPNgKg0yzCZ6AcVtPAfGSON33SLsqOz/ttXnK2zt74jrmM51PwB5IaGC8dUklDd3/Ys8MQdi6JA5VVOS0uWbgv3peJk8MCViZ5JClvLI2JXgecoe+Wn4hK2MzIq1wkYINTfDlwJ4R8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971608; c=relaxed/simple;
	bh=jqvRudi4RLNY5qbeW9/jRuDC4CtIydMsORGJnAxYdQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1rk2ZK72y6b4yPYXo+Mr2yoBGWs2+8P6kYBb2644XYdTC+3H1/1T8y7TeRc/3pacmlAVqcy8IIPqsYpor95Qz/cqAcFdi1N+5630AtY9xQWO5NP7m636mOJ07mIG0Zdnl7KxwL35GdzCIyLC7zXwmlZLMXSxjyjw+bxSEXx8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRJeQupd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBFD1F00898;
	Tue,  9 Jun 2026 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971607;
	bh=+hquM/O+ouF28xu+c1My6bqiYrCd2e1RnMMOHXkbssQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XRJeQupdyr+K4UhTt0XWaS5hD9tM4BNDA3q21qcoWQPHWlCW6UJgTyc/V0MrT0AKz
	 9q1KxhvGvupyfDtUhhgumBP8Rl02R2SjcjRIOedMy+HCdIkmolNGho49EuIL/AYU38
	 53CnAJlcgAgYiCHshAU1GPxXRJfn685u/wcCTrdJfdcVWXmgxykm3XV8HAMyKqcNQC
	 1peqJoV8IU/Dlkz8ss5UfNajXCnPU7T68tCwaNoBi/nBXfjiA7aDC9Q1tlSq9MLVx7
	 A6wWyfcXAWNU2IFlUtDipwrfpRD4rWBajRo+OjAcFxzcLx02ug6NvoMSCOHH6YlJYV
	 NctdMDmzuonjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B023822D43;
	Tue,  9 Jun 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: garp: reload skb header pointers after
 pskb_may_pull()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097160539.1758231.18195055123313838139.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:20:05 +0000
References: <20260604141925.237746-1-devnexen@gmail.com>
In-Reply-To: <20260604141925.237746-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, noreply@anthropic.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, tglx@kernel.org, zhaoyz24@mails.tsinghua.edu.cn,
 mingo@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296863-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:noreply@anthropic.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:tglx@kernel.org,m:zhaoyz24@mails.tsinghua.edu.cn,m:mingo@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B1E465BD70

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 15:19:22 +0100 you wrote:
> garp_pdu_parse_attr() keeps a pointer into the skb linear area across
> pskb_may_pull(skb, ga->len), and garp_pdu_parse_msg() dereferences gm
> on every loop iteration even though the nested parse may pull again.
> pskb_may_pull() can reallocate the skb head, which would leave those
> pointers stale.
> 
> This is not reachable today: GARP PDUs arrive via the 802.2 LLC SAP
> path, where llc_fixup_skb() already pulls and trims the whole payload
> into the linear area, so the inner pulls never reallocate. Reload ga
> after the pull and snapshot gm->attrtype into a local anyway, to harden
> the parser and match the skb_header_pointer() discipline used by mrp.c.
> 
> [...]

Here is the summary with links:
  - net: garp: reload skb header pointers after pskb_may_pull()
    https://git.kernel.org/netdev/net-next/c/ab71cf79e2f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



