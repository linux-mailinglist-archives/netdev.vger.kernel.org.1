Return-Path: <netdev+bounces-294343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TAD6HBskH2omiAAAu9opvQ
	(envelope-from <netdev+bounces-294343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7986312BA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:42:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wut2fUV3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294343-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F19D30234EA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AA395AE1;
	Tue,  2 Jun 2026 18:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC973394464
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:40:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425605; cv=none; b=rFqJoZr6JLQsaUGfsKn5sv8aWzoAZ1/A0GsENZbQK3ns3sCL5YdxJ2X+1Z5kWuKg9iQ+d7FdbtXsIyKH6JyWejxVdFciIqPpILYrHy+c9a9Wql/Y9hwuL9gom575SbX4UugSHDcoy+51YvJIjKA+ihhwcFfO32R3r6dHwmQFbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425605; c=relaxed/simple;
	bh=8M8Q0Li5FIHV/6PSPWoVEoBJpuKvr9z2v901B0jn7Yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=std9aUeOLRxmgL7C+gXQwdtaDrL/Njbunlewt3v4zMjQvpQq31Ss+SOI2l+3/Qdu8bsh9Fq1L/u1i5iAWMdm6GiNiY4NaSCLcMp6JfkvK3pXl4MN7HMTHuIJ2dn+eXUa30WALcfW+M5U1QqAU5i9o/7SkN5m6o0enRVZSA3b7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wut2fUV3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD71F00893;
	Tue,  2 Jun 2026 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780425604;
	bh=6Ur6CjCoSIvmft0BHxLHcPnMMVlpfcDath+nGhigIvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wut2fUV3SbQ+WcVbzOg29q/YoLDvYU03POuWr9TgwWlvpc59wjvviku3/NCrQ4fgT
	 KI4iUozdLa0d5VJmsqyq270nW6Iweb0IGGczOYU/j3PTnv+JiDCljiE2m/PMjvtZMm
	 XBP2fnGm6uQJAEov6uaQr9+eV5rWqntwvdoUm8OCxSoIUxKILSblPggLP8YkjFFQ0g
	 z59+QD26mng7wtb8s/9M/cjHAkj3hA2gJgmbsRVphoQPIvsYsAm6XM2ZbHdRzFfx3K
	 S+9uI2jhnG0yi9MfdjrDtLYVqGfO28Ilv5IsUFF0KKKI77v/JV9wyKAx93RO9mjaTn
	 GpgrBECiNI78w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B123811A6C;
	Tue,  2 Jun 2026 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042560607.1000369.13107757515393374597.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 18:40:06 +0000
References: <20260528140320.5556-1-oscmaes92@gmail.com>
In-Reply-To: <20260528140320.5556-1-oscmaes92@gmail.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294343-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oscmaes92@gmail.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD7986312BA

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 16:03:20 +0200 you wrote:
> napi_complete_done may call gro_flush_normal (though not currently, as GRO
> is unsupported at the moment), which may result in packet TX. This will
> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> while trying to re-acquire the already locked spin lock.
> 
> It is safe to split the spinlock block into two, because the hardware
> registers are still protected from concurrent access, and the two blocks
> perform unrelated operations that don't need to happen atomically.
> 
> [...]

Here is the summary with links:
  - [net] pcnet32: stop holding device spin lock during napi_complete_done
    https://git.kernel.org/netdev/net/c/73bf3cca7de6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



