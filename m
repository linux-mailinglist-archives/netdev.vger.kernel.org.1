Return-Path: <netdev+bounces-298854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hBPUEk2sLGqkVAQAu9opvQ
	(envelope-from <netdev+bounces-298854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:03:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683B67D62A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:03:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nmXQMyub;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A9831CA93A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98F261B8A;
	Sat, 13 Jun 2026 01:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5725B0BD;
	Sat, 13 Jun 2026 01:00:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312435; cv=none; b=G37siGx6NaFGtBW1Vb93FmpMzh3qLA+um1seHbhYGWufrCWAe8Bgahb6bmmIv4wzPJwky1zz/X53t+V5yGxABkk9Szy/fJYhuWEvDvCJeTofW+GcmKRCR+WrYuvIytfVrZ7OwjYpdLa7cT5eQfh10UCY8P1g0KFupKqjsWmRB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312435; c=relaxed/simple;
	bh=O8ZjG3UYjvHj3UQL+e8lo264bPpxq6p7N+WMEtpPJUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgOsgiUmxREthNMCpLDnLjXZPgbp5LBERsis1GCCGQNrohLb3jWyefehvWnWiPyyBfidF0vK9WUFLeJgVRPr7uj4Q0JoIQ0lrCYAoCIyAQPBgK9WIBMekKTUN73U+OuVKCbLPRlotOpVbGZIuqZSQIZitlJ4bJapyOneSYf+SY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmXQMyub; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0769C1F000E9;
	Sat, 13 Jun 2026 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312434;
	bh=SQ5Sv/fIee07wFz+XPjtuOc2QBdnHwVx44qJs3Gf8s8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nmXQMyubPjxH7x9m18F3RJ3Uv2WTqJbCUiFJ/VXGq99dHLPf8nG9d/PI8eiRwYV8+
	 z6WYTlNQINbqyiSc7KKkMa0ogiFPlCKLoNL4ytjvt2bxpaATGLNkHnWbcrv5l75wVb
	 C20rcMlk+WiuBirpErLj1LNfV72M5BuGGCRtByvwAWCya2mgSL0sf5EzBxKhlZsSST
	 r9DTYS3cD4/1r4pzN4lCOEka6IJSJvcB657+3zDJciIf6KyidRN32EFfqlh0/kk3yp
	 vJMQWAcUgrKk0YWPQjKPv3uHSfo/dxUfec8h4RaI5xrKC9LPC2Ea9wJJxkxE6WM0g4
	 tsCGgjUfoXxOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2439E9607;
	Sat, 13 Jun 2026 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netconsole: clear cached dev_name on
 resume-window cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131243063.1315131.4483049658366327192.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:30 +0000
References: <20260610-netconsole_fix_more-v1-1-a18652c47cef@debian.org>
In-Reply-To: <20260610-netconsole_fix_more-v1-1-a18652c47cef@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298854-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9683B67D62A

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 07:26:04 -0700 you wrote:
> When process_resume_target() catches a device that was unregistered
> while the target was off target_list, it calls do_netpoll_cleanup() to
> release the reference but leaves the cached np.dev_name in place. The
> other cleanup path, netconsole_process_cleanups_core(), already wipes
> dev_name for MAC-bound targets because the name was only a cache of the
> device that last carried the MAC and may no longer match.
> 
> [...]

Here is the summary with links:
  - [net-next] netconsole: clear cached dev_name on resume-window cleanup
    https://git.kernel.org/netdev/net-next/c/02a61d2018c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



