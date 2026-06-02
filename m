Return-Path: <netdev+bounces-293953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEjtC8o8HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:15:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADD627236
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E394E302E30C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724A343899;
	Tue,  2 Jun 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK/UA0w3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1E29BD9A;
	Tue,  2 Jun 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366212; cv=none; b=dieR8AG/0mcy3H9a+fUaix6zifLn6rKcATYVudLGdUyP3/Tno4VEjZLNEqs/+GzL2r/bGwZ3Clgj0TUdtIwRIgvbIomUmAhLt3WZ2iv0en50aeN6tmooHDpgtdySZOpNIuKUY31tEieVZ7Femp4oRpKnmAQWXcIu4CJJho5KCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366212; c=relaxed/simple;
	bh=AMoajZE73YqwLv4ndzVWFvhCs3otHeg+OTc2qzqZnjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HbS69T3d5T7d+12XsV3kAzOePrEMwjOm+el+x5ozfNQ4/dz0OTACimsIw2cfnFaLZXcda+FaDgDwvfz3K61f1NBkVXy6KA5tZVr8QdXqwNBX0X+x9Qo3+vMDIljdfP1ITvC4UY3Ltn+EG/uSR+lqSkxwNTVydYdsvJfnER7FSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK/UA0w3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB641F00893;
	Tue,  2 Jun 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366210;
	bh=GffbgE9ImjIz7Fcf0+2uSe9JZW9Fg9VMzfRDR9fOFxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RK/UA0w3/2WKAr2fRmwLO1iLQ/Ln/qXv07xXsbssQEIxyQH+3qQbEwuDdqkIgZWX7
	 GvRo+HFuSOetnYnGtDgjX4ZFrclvTVn6lfa9/ezsOZFcqsXsslrj7mbx0R6vnM74zT
	 5OOMmwUMZSTNBO7q8yHAKzyKFfgIAcjPP5gq96jajoGuAcMOBuCfaLcCtzFvoKcHLq
	 sOOQ9tpkwNC7NWlBYfHvv5mGlQhLub7YoLKzx4Wr86+ksLB4LRCaDLQjsQdh3nyMy7
	 FX3rxmEF2YK2VRqTktj+5E+kKzemVrpuJOciKtfFWrPIZE4i8iHIpB/qb1RhybWucg
	 qhKu7zEzVM47Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B5638119F9;
	Tue,  2 Jun 2026 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: Remove orphaned ax25_ptr references
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036621315.206391.609120386736941722.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:10:13 +0000
References: <20260531134837.4111349-1-costa.shul@redhat.com>
In-Reply-To: <20260531134837.4111349-1-costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293953-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80ADD627236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 16:48:36 +0300 you wrote:
> The AX.25 subsystem was removed in commit dd8d4bc28ad7
> ("net: remove ax25 and amateur radio (hamradio) subsystem"),
> which removed the ax25_ptr field from struct net_device but
> left behind the kdoc comment and documentation.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v1] net: Remove orphaned ax25_ptr references
    https://git.kernel.org/netdev/net-next/c/7745f1978a0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



