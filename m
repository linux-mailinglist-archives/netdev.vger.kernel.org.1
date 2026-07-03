Return-Path: <netdev+bounces-304381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bBaONc9eR2quXAAAu9opvQ
	(envelope-from <netdev+bounces-304381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:03:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F76FF57D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:03:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hj8fxU4d;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304381-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304381-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE7C303299C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739F38236F;
	Fri,  3 Jul 2026 07:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1E3019AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:00:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062033; cv=none; b=nGqJ6nXnoYN0nTFukGtHYc7vZunCjdNsuZx/vszyW0C5NcQtGTkuSxXQxAE4TwceyT+r/lXN7qu9Hd+f7KmvxCwk2lHMbUwdubpjJgQ+U5VMTjPhxmvbBGCBrXVqyQbAcDUPnXB6MDqIqizybMoOQqJYUVwjhlsJxi7SBf4uYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062033; c=relaxed/simple;
	bh=rDFHXovI5GyEhpGC7BOc4i9681Eak9dN2KYfxvpHfeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VWCvDhoo9JPaacOROp7KB7JBad483yYfQ7CYfKTTpDH48TEqofncrFIikP3CZ+BqVKGbS6qdGxJRJ7YiqFOXZPaxUXk9MmalJ44J23WzkRGTWizUUgKZqcmPE7VEHtznEIT/h12KtHswqYXf/sRk1LF5JREvhGtyGT3wY1hKX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj8fxU4d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16351F000E9;
	Fri,  3 Jul 2026 07:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062032;
	bh=HwjSLkg6dq1xBRa5cpngJvR4yv+DbxeaHFre7noC71E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hj8fxU4dXq4yY7/57RmgbmK/Wa4CVT+LuGT1q2gUcIbopllqmCI8tJd/pUzkpgAY5
	 ewHYfPeynP8nIIlEpr09VTDKbQsNTgqFCj1EkqjnblCmZfGoyZdvmR+KFOFYL9m4wh
	 oi6WhCnThdMx9CxyZYuesgKAZxRE+Plcg0ffm4GH7mhDTTFx5F32LqYhn2Wpjl2P2N
	 gh367h1YC6fKtiC0bJQe1Ngtwwiw1jIWwi0P6So/b5jxtok9tQvCl9nF25Y8DIFxwZ
	 KzkucUQ+q4Rms4zujV3mhD+dbYf7W6yw9CfJWtPBECdyJtc/PNI6CNYiYsd0n5VA3e
	 VlAWB/h4ALlfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ACCE739387AF;
	Fri,  3 Jul 2026 07:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] tools: ynl: pyynl: pull the --family
 resolution logic into the lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306201441.2494164.5489624175962014946.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 07:00:14 +0000
References: <20260701021751.3234681-1-kuba@kernel.org>
In-Reply-To: <20260701021751.3234681-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, gal@nvidia.com,
 jstancek@redhat.com, ast@fiberby.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com,fiberby.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304381-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:jstancek@redhat.com,m:ast@fiberby.net,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 238F76FF57D

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 19:17:49 -0700 you wrote:
> When packaging YNL as a system level utility we added a --family
> argument which auto-resolves the full spec path from a well known
> path in /usr/share. Spelling out full YAML spec files is at this
> point only done in-tree, for example in the selftests which need
> the very latest YAML. But the selftests have their own wrapping
> classes for each family so test authors aren't really bothered
> by having to spell the paths out.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tools: ynl: pyynl: re-export the library API from the package root
    https://git.kernel.org/netdev/net-next/c/df87e5c4e94e
  - [net-next,v2,2/2] tools: ynl: pyynl: pull the --family resolution logic into the lib
    https://git.kernel.org/netdev/net-next/c/10c90f1bba3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



