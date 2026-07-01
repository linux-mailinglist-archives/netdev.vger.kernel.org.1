Return-Path: <netdev+bounces-303429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C+4tH7JtRGr+ugoAu9opvQ
	(envelope-from <netdev+bounces-303429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:30:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C053B6E9101
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R+g3eJj6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303429-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303429-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AEA7301F190
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326731E830;
	Wed,  1 Jul 2026 01:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531D219FC;
	Wed,  1 Jul 2026 01:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782869423; cv=none; b=XG4FCFG6xg5Zsq5DKJ6I/UldAO4HRUdb9eDN7ufgJWofOpDsW0gANGAB3c1TY0oMbv83LQfqn87mbAwXB0NlXPynLGSTw8YW0JQ5zhlkxmVqFWgbnzc8QlCHns9S4i23/+oeP3VlqsYo0X00FPQOh0ILUH8/iJuqlvHyC8Rc9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782869423; c=relaxed/simple;
	bh=/gtJdKvYgbzRj2+uqGEETzTMoRBRDQDKx2iYQsbAUEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SwseYwMQyRg0DZK1K9jG/W9JJLGO5ygewLmS0ez2GvItL+XlkbMxA6JXjm124msPkDg/2Liv+5uU+Up+yl3eOk/M93fb1Rgx7ErS21Ssp7qpdx+oa9bUXz3WYmyVEyiHrUujg9EnewPdkCppvQYatHCeVlo4rPud5ncKU+vaOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+g3eJj6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574061F000E9;
	Wed,  1 Jul 2026 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782869422;
	bh=ZwEtI25Be4x8jFHmzmuzNGcOJgHpbFrTly80xZQwmtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R+g3eJj6DolaGvkdDHNA8GOieVPVRCIChwxzzxv8VvvpsTyhInCNkbSOdhoM2HMQH
	 wWDy/wA7srtDBAisdU/7Y5iwFSHu1DDkLMvrG3zDpbR2HlTCHbyYDbAdPtI8lPkvOo
	 1kgT8T2iJOHa5sAFxG/gdatAoIWIj6wyJGX5rWwX9n0od1sHI5/HOq2vqr/vc1l2yX
	 ovvZGVKn2d0ghoVqVnLZP5EJdfhzkPsXlAvo8jYMz1jwv67ZtWUwiUVU38yL9oL/LR
	 Jpbr1EJnlT4uTox1CmxncDt76/FYrVNu4eWcxkQREV86wIx+7Qg8/U/E0Axt2se45M
	 VfsqEIB4PoJ0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56727393A964;
	Wed,  1 Jul 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: tso: don't touch dangerous
 feature
 bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286940589.367336.12422566739924603469.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 01:30:05 +0000
References: <20260629233923.2151144-1-kuba@kernel.org>
In-Reply-To: <20260629233923.2151144-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 daniel.zahka@gmail.com, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-303429-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:daniel.zahka@gmail.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C053B6E9101

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 16:39:23 -0700 you wrote:
> query_nic_features() detects which offloads depend on tx-gso-partial
> by enabling everything, turning tx-gso-partial off, and seeing which
> active features drop out. Enabling all hw features is dangerous:
> we may end up enabling rx-fcs and loopback for example. For the
> ice driver we end up getting into problems with feature dependencies
> so the cleanup isn't successful either, and the test exits with
> rx-fcs and loopback enabled.
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: tso: don't touch dangerous feature bits
    https://git.kernel.org/netdev/net/c/2f7f2e311106

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



