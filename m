Return-Path: <netdev+bounces-305355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wJDeFW3ATGqtpAEAu9opvQ
	(envelope-from <netdev+bounces-305355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:01:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D318719762
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:01:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DMOa9ITv;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305355-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B2BC30391ED
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78396390CAB;
	Tue,  7 Jul 2026 09:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F938F935
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414830; cv=none; b=Ttw4yWn2aE8UmfGgNaayZmSlo/kXmYf1y5HD9oC8kG/JfokLPv1MO9x2cqEmekNu1PB3BvBDumkied6pD/+w0qKWXc4e4ypVQzPPhbapZpXGWfrJFqoIdI35t/ER9jAmYOOzAMLOQVyunk8rhqX4WiLb+olxAy+T4tCfO505k2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414830; c=relaxed/simple;
	bh=WD38vU9qj6RE7Qw4d6wBHckhc78/BF58mYwrqiklAUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=buSzRRJLKn3r87KuZ+BvFW49LvaIr+0qNOjPT9x+BazmEqCSppnJjzC0nFCdH7wCfO4shFvz4KFkmM9SQuIzQ4o/YxiMDSKDdF6mGlHxk1BqmLPwKZPBu2cgwjIagYoWDLNn/TSt1RW8PGqB+ydw2f7IaRZkPw0x4zgmerb1PPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMOa9ITv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DBE1F00AC4;
	Tue,  7 Jul 2026 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414828;
	bh=IQtBSMcTFTA73Mwq5MrR9mMYhZkGbcqBX2BlopJrNFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DMOa9ITvuLkC3kaKJdYU0GQBeVzFG8hqHIpenlzE6qJYnPX6YZysKK3L4RCcpdaxS
	 QZwTFLcOMQwxroPUDN48f7djrvoUCHbmbUawmI10mLKxvJd4zbaRF1VggYzMZ+0vT8
	 JJL148ZOX2E3EgPuk9nGvRy7FzuV8UXRYhJUBvsnRqA7VC0it0l21MhPtYlqvnDMux
	 5acSHisWxZVahfe4kVdfezCopKftAmLxIf+NwGzWNwAsHRL54tSChZFnZBuhpYXUkI
	 kEeE9AabB2xXUjonQYCfxYtctxyDkdtotDbEcGe//I4k1J9bVn0fCFdMwOOIA5sTn3
	 q8x9mrqStDatw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996B3925466;
	Tue,  7 Jul 2026 09:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] net: Misc follow-up on RTNL-less
 fib_rules
 series.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341480863.1439689.8864452646287174123.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 09:00:08 +0000
References: <20260702044437.591864-1-kuniyu@google.com>
In-Reply-To: <20260702044437.591864-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305355-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[patchwork-bot@kernel.org:query timed out];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D318719762

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 04:44:13 +0000 you wrote:
> Patch 1 moves net->ipv4.fib_table_hash_lock under
> CONFIG_IP_MULTIPLE_TABLES.
> 
> Patch 2 adds mutex_destroy() for fib_rules_ops.lock.
> 
> 
> Kuniyuki Iwashima (2):
>   ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
>   net: fib_rules: Destroy ops->lock in fib_rules_unregister().
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
    https://git.kernel.org/netdev/net-next/c/6041421dd087
  - [v1,net-next,2/2] net: fib_rules: Destroy ops->lock in fib_rules_unregister().
    https://git.kernel.org/netdev/net-next/c/99c13f8020df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



