Return-Path: <netdev+bounces-300554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySUTG0GUNGrCbwYAu9opvQ
	(envelope-from <netdev+bounces-300554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:58:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2316A3795
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 02:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HSjAq2uB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300554-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300554-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388FB30835C8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B91F130B;
	Fri, 19 Jun 2026 00:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BC1D54FA;
	Fri, 19 Jun 2026 00:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830217; cv=none; b=dhPMIUgSeSU8NyKCp1Kn70iVtlLXyUon5ncAP8mWkDjkhdkKWtfEA9J4x3kpYiqdpHB7kSBR1lnE0uwPrVM9sv+hhhlR6HPn+vSGYqzhsQK4gAFsW8V7bNkXzG+zWMpFUiUpCPFU5mzUf30cAVJ+pofVUeNETAuu7ndPtUfprq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830217; c=relaxed/simple;
	bh=ljapTYUk+iI2916K4rVkMhaew5z1/Ryu8ZrZdApYIFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sLDgeMLZ34LNIrYAivHYRRQCbMoaTLteoowwhH7uFwogc2713ci/ZjHSjv4mGPTUGTtTbQtlEUzhrCSiY6kZU6pScG+1FW8ySNXT0unTzwD89ACeuNz93y0Euaqj338HO6chNMYYYPeUepB5RYJhgbeiiFVC1tZ9v8SWh3YF00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSjAq2uB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E721F000E9;
	Fri, 19 Jun 2026 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830216;
	bh=/Ee6UxM3eqdSKl8aP3jGS8jgNlHyeBntU9DGP47sSqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HSjAq2uBov88nWyM1Ism+6BsXH8WfDWKzCAtAHpS4GVb2C1qz5npyVYbWq2ddR41s
	 6b2HYhI0cgnBu12wMD3haT9Omm0bTs+GLRLGbpXcKnrobrAyTjeLXncqkouNg9af6e
	 gYsoGy+9W89asVKeXNM3myZyLVV1klsfCVBjKo1hkMNjWvOK9BIU6hJ0ESyp5pscs9
	 mMiTmtn5q6DOReK4KC7TSefqvAKKcESfjlgiXnKgD2FAIq+Kfxsy4d5z92MXTs3xcO
	 fq8PhmRiuc19G6o+ZzrkoJabd+iyfkH5/xvUz3j7MS790p0BqlOXaE7Es05e0HbNCN
	 rv99dW69pCslA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939983A78A7C;
	Fri, 19 Jun 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net/sched: act_ct: preserve tc_skb_cb across
 defragmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183020939.3143278.4950135322607643333.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 00:50:09 +0000
References: <cover.1781358691.git.xizh2024@lzu.edu.cn>
In-Reply-To: <cover.1781358691.git.xizh2024@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 kuba@kernel.org, paulb@nvidia.com, victor@mojatatu.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 xizh2024@lzu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300554-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,resnulli.us,kernel.org,nvidia.com,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:paulb@nvidia.com,m:victor@mojatatu.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:xizh2024@lzu.edu.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lzu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B2316A3795

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 01:42:38 +0800 you wrote:
> From: Zihan Xi <xizh2024@lzu.edu.cn>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/sched/act_ct.c. The bug is
> reachable when configuring TC with act_ct on a netdev (requires
> CAP_NET_ADMIN). We have tested it, and the fix should not affect
> other functionality.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: act_ct: preserve tc_skb_cb across defragmentation
    https://git.kernel.org/netdev/net/c/9092e15defbe
  - [net,v2,2/2] selftests/tc-testing: act_ct: add TDC test for skb cb preservation across defrag
    https://git.kernel.org/netdev/net/c/1fd8f80a199d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



