Return-Path: <netdev+bounces-300935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pW2xKJmLOGocdgcAu9opvQ
	(envelope-from <netdev+bounces-300935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:10:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44936ABE87
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:10:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nHuGrUFY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300935-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44F0230074C2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174923EA84;
	Mon, 22 Jun 2026 01:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E25233956;
	Mon, 22 Jun 2026 01:10:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090626; cv=none; b=M3OuWV6IJT2ExHZCDDMrd24b8RzU13gJnsgC8EIGeik8eJyj+eCMSTWVQWsOG+NhBAm8PWuxXoGg7qLsTbYSA7caCjwC7v2M/bhHulDa9ITRDwKNEA3CwAy/KNQbF5cl+F5yruwD72P6JzbaQ+ylT+aSlKXNDLHwB4DvEZoQQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090626; c=relaxed/simple;
	bh=ldwlr7j7awykPM5jHEO3J6l0X4aRtpKKOGFcCdrn/uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XJnKcAKQuqtlRWmB23J5ewQ/NZJ8/OnXklqgsA5z3wqmr5nKffG8BjVWYsPWoDZ/QUcUg7CeD43BddZ01R7vBCF39GSvS74dV5Y/3opRrI+ss4567rZrT3F477ABV7eJy49mSXSJSUdwp5M1k5PPuYpv7ueieaP4ZMNI954NXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHuGrUFY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736511F00A3A;
	Mon, 22 Jun 2026 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090625;
	bh=N5ftLIZ4H3VywEcUWAkrBpNNtsOsJd6nhX7Tsb1yFxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nHuGrUFYwSVZDciri8Jdml4FIHIXPVRSeVCgS3jIFwrfl5Unzl3B6UoWSgrHsnoGX
	 dcVBL9FOpLWeZz1GJXksuMZB7fOWetAdHgqvXkABPQVC+W5caWxmfYn9GzkRR0wp30
	 jQiMHdZZeWOBy9unqbZijKaZpGAsAF+qt3q1bb4KiB1KcmypNL+SQyXkbnefnFxhwo
	 jqzvUYAYzhgZvw2zZPeDeNfrafVnbT8w7rDzJ07DbfwGm8Fb6QwcYNW92FBwCKtGTD
	 TTA9jSj2QTb6XivWDrum1zJDnNMhdhvGArgcWC40MAjKEeQxSJGLzrR4HFaaf2DXPI
	 8YODnQjcJ2K/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EA3AAA6EF;
	Mon, 22 Jun 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: zero-initialize the fib lookup flow struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209061631.558026.5043530435386557482.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:10:16 +0000
References: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 eddyz87@gmail.com, edumazet@google.com, emil@etsalapatis.com,
 horms@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 song@kernel.org, toke@redhat.com, yonghong.song@linux.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,davemloft.net,gmail.com,google.com,etsalapatis.com,linux.dev,redhat.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300935-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sdf@fomichev.me,m:song@kernel.org,m:toke@redhat.com,m:yonghong.song@linux.dev,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A44936ABE87

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 04:17:19 +0530 you wrote:
> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
> the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
> fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.
> 
> On the non-DIRECT path the lookup goes through the fib rules whenever the
> netns has custom rules, which a VRF installs:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: zero-initialize the fib lookup flow struct
    https://git.kernel.org/bpf/bpf/c/0dfcb68a6a5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



