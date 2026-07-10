Return-Path: <netdev+bounces-306586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e+TaG3P9UGqb9gIAu9opvQ
	(envelope-from <netdev+bounces-306586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:10:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEDB73BA38
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZFlJYMek;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306586-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306586-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E887300AC98
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27B31813A;
	Fri, 10 Jul 2026 14:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290E25228C;
	Fri, 10 Jul 2026 14:10:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692633; cv=none; b=Dqlu7Ne+h7+25oEe4We2mqfBVWuYaB06dQcRr///oa0dPHZGlo97fJVsYrvae7PlOvltYDEdgh5UUz5lbPwQni+CYXewhbyAF2ZNOKBmjlCtwx8U5qJJmWeWSGAcgXRpu1Gbv7SPUTD4dyJScNaXDdJP8f1CMM7ZuuQb/UvrbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692633; c=relaxed/simple;
	bh=TB6LVnogQ5WCudz4xcq7b0N9xJRjekuPV1SKqWMUQPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q5Bg/1FkoEKlA7IqAHldbQL9yIw1MXpFnH+D4Tv4jGMJwOnrx+04qQimfScAa3AB5ceYDArgUyfvyBJaWfxUM8/gR/aBV2t86yCVVYQ92Mgi9PZ7KX8eenItPCdc+/7iqleJGUn8aAMRsp9eEzeOt5v1L4MHATKF4giJjhCggas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFlJYMek; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859A41F00A3A;
	Fri, 10 Jul 2026 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692632;
	bh=N0Sm3pthzpHlYcy64+pRdWJ903nZpnSTlIILQ9Vexd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZFlJYMek6zuREhxcrBwJ4vpWEi7+aoAOK4OVpTCJA3x6qOr/IXHX6htkpRXTBWLuO
	 fYMXrqkLtR/SxjiirEJLC2U7oBrPdua1XgcbGxpXxOMZ0YIScSGWRKD78BNkGPaYer
	 Cing/yh3ZuYbrPIxJl9MQ95hfUQojDDKNj9pAjdaFwPAQZU1urhQAX3GaSXRjfPTeI
	 +jooqNCNIl64mV751oc7IZlqQhGhvoE57bDx8HpvvoeoO4sHCwQr8rw8skPpaCS6sN
	 ixD9826c0iRhuO8NI6ltKYzu2Jb+Ueigi/yygktNZOwBhxr3ZAxaYVPZ6D3Jnu5AEU
	 CxrYTtvWfvs1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B7A3924F95;
	Fri, 10 Jul 2026 14:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: fib: free fib_alias with kfree_rcu() on insert
 error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369261015.702516.15852641414111977103.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 14:10:10 +0000
References: <20260704171421.1786806-1-bestswngs@gmail.com>
In-Reply-To: <20260704171421.1786806-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 horms@kernel.org, xmei5@asu.edu, linux-kernel@vger.kernel.org
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306586-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BEDB73BA38

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  4 Jul 2026 10:14:21 -0700 you wrote:
> fib_table_insert() publishes new_fa into the leaf's fa_list with
> fib_insert_alias() before calling the fib entry notifiers. When a
> notifier fails, the error path removes new_fa with fib_remove_alias()
> (hlist_del_rcu) and frees it right away with kmem_cache_free().
> 
> fib_table_lookup() walks that list under rcu_read_lock() only, so a
> concurrent lookup that already reached new_fa keeps reading it after the
> free:
> 
> [...]

Here is the summary with links:
  - [net] ipv4: fib: free fib_alias with kfree_rcu() on insert error path
    https://git.kernel.org/netdev/net/c/f2f152e94a67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



