Return-Path: <netdev+bounces-295307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQrnCxufIWqDKAEAu9opvQ
	(envelope-from <netdev+bounces-295307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B5641965
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:51:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="iykPeG/d";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295307-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FE2330A88EF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F93655F3;
	Thu,  4 Jun 2026 15:40:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDF356765;
	Thu,  4 Jun 2026 15:40:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587612; cv=none; b=ZqveKE550+XqN4CXUHS4RzqQWvyQGSL/K0Wf1MKgUPDGW+giECBVTqelOzRph5eXHiuSeKH9eojpur11fWcXrArkFS+Hw/b5nAUrq10NuvgG4Xsf6hGyk0d1fpaPlCHSh+YKfUcnXOwTUWq6W1itXmzZVNqWPKUg7sU2qads8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587612; c=relaxed/simple;
	bh=I+zXD3fCsou6wp205kAa2H7w5pkxVHw6Gc5PQPzJJ/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PlzZS8SDhys8xuEUo+4KSxU6n2I+5jyr8bdqdZJ0e+BcMDHcR9pmXx47lZiRRONjJck+loCOz9EB/PG2VVye0hmqqTe6A3T1FCe4yu2CxXDMjllcCm4fio3CBB+P5guPLokrLKEbEhiQawRKvfBPsgdGqqiCmZdhdbi+T2UekT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iykPeG/d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB91F00893;
	Thu,  4 Jun 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587609;
	bh=nNvEQY7/ZanMRiYKcGjHR08scMy0tMkJfWg1swlQF3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iykPeG/dx49r+oBr2Q69SXiT7xB3uA5oAJzYci4zAzPZUQ1+xFedQ396JvAm0RaSi
	 9MD6jzGiJe5lAlcJeaaGJfZJmjOEigQrwk8WAib1LL6sG5+NRQnrwblIyGUXeKrEhQ
	 cgXgQ8YMK51NGZhMYiDrumh8jsfGbeNKfgdQf8Z86wqoq083EoVTVN8SLYJV/xd4bp
	 ZV7fe6pwVV4ctKxu6AigpbTfj2a7RBlhfMk7B1/pyPKjEdnL6MJZzpU1Vp9XKqM7wT
	 6fhkkfGf/mxQ922gWo1ttxiX04+auZ+85y6i28IgHL/GEGj/rPaQhml6fXgA0N9kE3
	 919bqd3NaQ9PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2E39309B7;
	Thu,  4 Jun 2026 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page
 cache corruption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058760965.2484354.17011007371452142706.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:40:09 +0000
References: <20260531123221.48732-1-jhs@mojatatu.com>
In-Reply-To: <20260531123221.48732-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com,
 toke@redhat.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org, rajat.gupta@oss.qualcomm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295307-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:david.laight.linux@gmail.com,m:yimingqian591@gmail.com,m:keenanat2000@gmail.com,m:2045gemini@gmail.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:dcaratti@redhat.com,m:security@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 882B5641965

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 08:32:21 -0400 you wrote:
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> 
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/1] net/sched: fix pedit partial COW leading to page cache corruption
    https://git.kernel.org/netdev/net/c/899ee91156e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



