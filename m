Return-Path: <netdev+bounces-299591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ijh1Jp9XMGqHRwUAu9opvQ
	(envelope-from <netdev+bounces-299591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A0689940
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fGUYKvVo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299591-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE34F3015C10
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DA3B6366;
	Mon, 15 Jun 2026 19:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA83B530D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:50:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553037; cv=none; b=QIIQRVENFjwbWdwM3cLS2aoVKMs+u1XkhGTwD6ftCpz07S43ZtkKl7dWYSYlKHAR+Iy1NeeCroArTrrlrHPWyAh88WjG5+3B9uIqNSST38MRfHmPDr0odG8gsQdNgkVaCWUVqI7EOjFYJi17/7WNJ25xsQcoOH9Vjo4rpY46NE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553037; c=relaxed/simple;
	bh=26TukVbLG29rKT/ZGTbe03pFiFw9n88YYkgOf86J+0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bz2zB+IgXlGKUxwvLws6JHsiZr7Kpj1yelV5ImwxUvkmA1efW3T7AxpXCQvBTouL0ynW9GR/m5p/lDt8JsoAepzhdPu+eI/pXnAyGwLI+WbuvV7aXlWLVw2Sgh7OqIbgqxah5hX9VtLUY88tbR0E1AS35Z5mLdYmh2i6+pYW0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGUYKvVo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BCB1F000E9;
	Mon, 15 Jun 2026 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553036;
	bh=Y9XOi9qTrmbwbiT8v+AtP/gm0n9V1iHHZRKPg8j/3K4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fGUYKvVoayRxwytGWq6Z4+FtcJawYR18i82H38zDVJ2LPaUiaK7DOy2GmAFTl6Q+o
	 NLlvwxe9ZvZWZiX+BpQOTqGWcgpjWDtd1VgljcQGPaJ81xPDO/pSG1HZUoU1EDOLGT
	 xlgbW8bc+4eBPOLHYkkqBFZcptSZaxmAMFJTYOxG411PI895MIrXmStSrYq9r8o8VF
	 HPn4FEd4A15vh0vQjv0iZRSwX9lXpII68oI55nAjTicUrKNtvv5KrqWto5BEAOZUru
	 47u8qGsQYiKcuWXqN0spjD+D12spCwEzyzEb03tTtvuvG9mk+a3p0/hfsoVRok42u8
	 nG3X3oBw93YLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0B3839A06;
	Mon, 15 Jun 2026 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/5] ipv4: fib: Remove RTNL in
 fib_net_exit_batch().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155303138.269508.18385193981213232628.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:31 +0000
References: <20260612063225.455191-1-kuniyu@google.com>
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299591-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C6A0689940

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 06:32:03 +0000 you wrote:
> Currently, we flush all IPv4 routes at ->exit_batch() during
> netns dismantle, which requires an extra RTNL.
> 
> IPv4 routes are not added from the fast path unlike IPv6, so
> we can flush routes before default_device_exit_batch().
> 
> However, there is implicit ordering between ip_fib_net_exit()
> and default_device_exit_batch().
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/5] ipv4: fib: Flush all fib_info in fib_table_flush() during netns dismantle.
    https://git.kernel.org/netdev/net-next/c/64587e936b65
  - [v1,net-next,2/5] ipv4: fib: Call fib_proc_exit() and nl_fib_lookup_exit() at ->pre_exit().
    https://git.kernel.org/netdev/net-next/c/c993bd0102aa
  - [v1,net-next,3/5] ipv4: fib: Free net->ipv4.{fib_table_hash,notifier_ops} without RTNL.
    https://git.kernel.org/netdev/net-next/c/49374d87e839
  - [v1,net-next,4/5] ipv4: fib: Avoid calling fib_trie_table() in fib_new_table() for dying net.
    https://git.kernel.org/netdev/net-next/c/5a7fef12d931
  - [v1,net-next,5/5] ipv4: fib: Convert fib_net_exit_batch() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/759923cf03b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



