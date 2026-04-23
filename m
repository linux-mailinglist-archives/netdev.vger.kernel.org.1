Return-Path: <netdev+bounces-280598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JETHr2i6WnafwIAu9opvQ
	(envelope-from <netdev+bounces-280598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE42044CFED
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEFE3086D9C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5337E2FC;
	Thu, 23 Apr 2026 04:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7/m/Cps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CC37700B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918650; cv=none; b=QAEYnKby6SSzqw+KWZlhmALVed0yeOdCkm0lTiZQJzWO4At4OIRxJEWWLWI1TI8z8axsDGZtXUIbPPYEwc7IaBTRGRYYIL9iWkwevh1offawE4HbDO/pfauLDRSzz9ONDrLE2XGQJJd52F4YxX+HKld+ZfAvndsMXbie3OB1mtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918650; c=relaxed/simple;
	bh=MUzdvRcQlxZKs+j0OYwVwbOu6RCyKF/FjrcFXwQ+pjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K/LsJ1tjmIrudG0iYtWo45EBnfsUS2OyuZ5oTUBI+Mph45pRZWnlSVEwkGEb3ZezH+TJHl79l3X6tSK99H3H2xbJVACinJhOBGWJSY1PugxGpfKhtZFdXMfKjekPSzqVEYUHy1dCWnKAKRiA3akUab0gBuz4lsbpPyMgwyQYQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7/m/Cps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC28C2BCB2;
	Thu, 23 Apr 2026 04:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918650;
	bh=MUzdvRcQlxZKs+j0OYwVwbOu6RCyKF/FjrcFXwQ+pjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E7/m/CpsvT1+6zLcQOFTWJTEs0Y4Q0tqQ3l+ml30CHxt+SPjWlYmnjEUdb9JZGpuj
	 GaCDOifHNvlUXojZDl4M9C+yMMLD1Wq6CsMSjru9VE4FrsPCAalqZ13e4Z5w0FKGK7
	 Ukl6JohC0qvblPr5311czLs4BkIcqAstXcGGqi00KIG6mJFlZAowvOXF1f+sodboq9
	 h0EqE2VYMibB9+p3x8lP8p7k1AaZFr9B8lWe4yY5K3YBwytx+rmSDxbwkaUX5LU0Bs
	 SzbLLU5zqxFk6+hShsRcP1po9tcr3UrpsHb+15PWqqoiAMPLewQn7d8J43lisxnC/J
	 2YY8uY//KBR1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9CEF3809A86;
	Thu, 23 Apr 2026 04:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_hhf: annotate data-races in
 hhf_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691861229.4157517.4102123607384919335.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:30:12 +0000
References: <20260421143349.4052215-1-edumazet@google.com>
In-Reply-To: <20260421143349.4052215-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280598-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: CE42044CFED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 14:33:49 +0000 you wrote:
> hhf_dump_stats() only runs with RTNL held,
> reading fields that can be changed in qdisc fast path.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
    https://git.kernel.org/netdev/net/c/a6edf2cd4156

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



