Return-Path: <netdev+bounces-290933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJhhBQLXEGrYeQYAu9opvQ
	(envelope-from <netdev+bounces-290933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:21:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F98B5BB189
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC50630053CA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F6363095;
	Fri, 22 May 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="newq1qcJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B533C1B4
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488401; cv=none; b=FpQbmm5gL6Bb9BDnPjoNsoH0OaClwgNHdWYJLH4ZPfm2hQmO+E2JBSIZ85Y52+3yFYFG9W8ZYN5jS8oooT8jmmnwSRF0e8XEOUHQEZyHYt6gNUoXUHmLCiDdu0L2MVFF/dlRxBovF95KsF67wOc+kS55vSgR3CYl41Y3yvUZbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488401; c=relaxed/simple;
	bh=l77Z+Cg1pcOf1lPAvAgHycPTcYyDFe8u8yOPxp+wLO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uYJD/btEx09LtZTU2aJ2fmWzECWArP6Tss7OoWuH0bsJG94JGtk4FfaeaZOI+eZMofnaJDYAwTeoylE0VHHTWIXj3AjZhL98NybiwjR0kafhQU3Ksqrnd490+z+D8h27nR6JI5JROuqZvD/o2kqBivsiNpSNEdu1nC/tyUu8DnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=newq1qcJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A191E1F000E9;
	Fri, 22 May 2026 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488399;
	bh=lHXVDkkUx3LuoszodFrrMpYeTcoEPpacoX7Mb55E3Ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=newq1qcJfYjV7c7HHP4IJ2U3YvIS+yD9IW9RSpT/68TqOSOWOzjphAnK7GG4XBnRV
	 LAlz0GRNsf4wBBmoxiKubNLtVEVeCKgE3wrfNj7AOILb2esPyb0AW5mhOwePtnkv//
	 8S6mQD4IzzZuJOs91esH+mTYTUshQBKfEpUY/ZYCHYXglLanqMF7SeEvJjbOhXmNVP
	 uDbozAHQs3XcTriILCJowdL+WKcV8LHz+LE3r3ctbI5GBUwbqFVcHqCJcz4vSwTH9L
	 04tAKTPjtXTLQoa0n3w2WG/yOFPEkSlDkgYUGs5Gcx/j/sLkUYLwBu42UA0kaFOO3r
	 1ZawbS8nx5abA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E8B393100E;
	Fri, 22 May 2026 22:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ll_map: add RTEXT_FILTER_NAME_ONLY to
 ll_link_get() and ll_init_map()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177948840844.1388561.2773222852653465091.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 22:20:08 +0000
References: <20260520103043.1131213-1-edumazet@google.com>
In-Reply-To: <20260520103043.1131213-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290933-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F98B5BB189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 20 May 2026 10:30:43 +0000 you wrote:
> iproute2 can spend considerable amount of time in ll_init_map()
> or ll_link_get() to dump verbose netdev attributes, contributing
> to RTNL pressure.
> 
> Add RTEXT_FILTER_NAME_ONLY new flag so that rtnl_fill_ifinfo()
> limits its output to:
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ll_map: add RTEXT_FILTER_NAME_ONLY to ll_link_get() and ll_init_map()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=de91e928ff57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



