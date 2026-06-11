Return-Path: <netdev+bounces-298094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRqFGR+aKmp8tQMAu9opvQ
	(envelope-from <netdev+bounces-298094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE74671438
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:21:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oeHU5Lji;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298094-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E75CF3012E4A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3135C3DE434;
	Thu, 11 Jun 2026 11:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264573AC0C0;
	Thu, 11 Jun 2026 11:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176810; cv=none; b=AYDSZvfVv4OUkhQMe4WpktWckMNWPPvgUceQ+6GIb3L0S3y/7DYGEHICSxuQNp4ZOI2BaisVPZ5MlVqC8uHkLfzOBHuj+ZM0+HIaLHXm1jCzVVNZSoEHxehsdSqcKkzfOmH5uy/9oTV0i2nu11l4O+WRfReDoFAUGfgn6KqyTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176810; c=relaxed/simple;
	bh=g3JgkfXBMwpC18V6g6fDnwfCNtQ6vzyJMSGyqSOOr64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k/zEoUkd20NrAjJidRGK0KcQ5sMEukYzN4Keg6qFliZfglDy5xgDTMpf4xP0raG/l8hj7D0ZswUqL5S9z/tYoJ678PJJ/jrCgsdcMDx9mIsOPVkwFB9bUXI+Ck+m9S0S2Wroas6cUhy7qsZQcWWwVW0Jsrs2ignlSTFSwogjPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeHU5Lji; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99A91F00893;
	Thu, 11 Jun 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176808;
	bh=YoGEhcljlTisdlPc7HQjkmQ11dvcikGiFBdlVDn4BMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oeHU5LjiLy9rRJ0e69xvgnMYM8BldE/6ipTIB/7zBnrYhEAkOFIaMZa+FjXypd0g2
	 9MMMI5ZjaVTgBbOA2j0GPrjJEweEv/lbisqSKCz6yAuAlng82OUw0K1kwnCE10QT66
	 HygrEXTIafSzPgwcN6GepPwgFR4RJcA5nSvnfRqA0bUy4wQ4HOk3gHNobN24cklR0Z
	 Eq8Tkl5It1/xwtCcuFGk3sJn48mkbY3uay2YXAtpEGJTjJjzAYmJDMOlRJEwcmHInc
	 6bQFkVXPAKJXR3ucGM1DX8k/hYbuveSzr6CIOvUU58a642yipTvAosrSUYlfMoO6hz
	 dgDGmjtpYnCNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E93930E4C;
	Thu, 11 Jun 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix IP fragment flag corruption on
 custom
 KPU profile load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117680589.3906453.14413268313223181159.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 11:20:05 +0000
References: <20260608095455.1499203-1-nshettyj@marvell.com>
In-Reply-To: <20260608095455.1499203-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rkannoth@marvell.com, sumang@marvell.com, kirankumark@marvell.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298094-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rkannoth@marvell.com,m:sumang@marvell.com,m:kirankumark@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FE74671438

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 Jun 2026 15:24:55 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> npc_cn20k_apply_custom_kpu() overwrites KPU profile entries with custom
> firmware values and then calls npc_cn20k_update_action_entries_n_flags()
> over all entries.  Since the same function already ran during default
> profile initialisation, entries not overridden by the custom firmware
> get their flags translated twice, corrupting the CN20K-specific values.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix IP fragment flag corruption on custom KPU profile load
    https://git.kernel.org/netdev/net/c/7360b9609980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



