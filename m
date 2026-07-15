Return-Path: <netdev+bounces-307710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OlsLGo1HV2oqIgEAu9opvQ
	(envelope-from <netdev+bounces-307710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C595E75BF9A
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:40:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VQ3MIUm3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307710-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 385EA3017FAB
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA83C345C;
	Wed, 15 Jul 2026 08:40:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E330AAA9;
	Wed, 15 Jul 2026 08:40:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104840; cv=none; b=F395zsBGHSYnNfNGD2hUpSg6YEuJeJ1wd/KbIwbjnjy0Vq1W2ZaZDq02HzjcCQ9Ozl5lEn5YFamzfEVeBy2r/o9q6mzMuTUN+VMxeR3kGa/bwts4H83Bhuutx0FWm2ZnNgw+ZyXi+cPa2ZbmUFwGc8OPfYRyPagMSzKefLh0R2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104840; c=relaxed/simple;
	bh=XZ+UP6SL1gjTGREjGTlBL+zx0cwpy4UD3RrZUMJYC4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HAdInKOIBBZReHBMTwjkYiAdgwppI/CmC4xwjOf8RD93KKAPuoTeGMKBiM/JKBPDqzJlVFIe3IyTP6cCscsemdj9a6SAoqcLQqn9RjxJvuPp/OBKwzFeSyB55l+RkDzTnnwPWP4ZvDInKZj/3SZDfXyAJoHYludjGEUprM6xu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ3MIUm3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EAD1F000E9;
	Wed, 15 Jul 2026 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784104838;
	bh=zAjrGa64tqK/7nRkcEaSFxMhCRl3hQjTgA9NIHb98NE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQ3MIUm3hlselemW6SnktNAF6vZ4Za3/HscrWSRlRra1m+kUetXOhxxeu/cX8smhp
	 ApQe4Dj3lMTtSziawoOgL8c5dFJ8zNaEh/WkJC6TLMMjPRMZuJcxKgtaaVLsXU1i54
	 kJkmykmHz40LB0mgIEZ4NWkB23pwK6dm8MRx+Eel/B3XynyPDpOjzOtFhw3dznhT2L
	 fPsaqkCAdkSx+maf5PcbAM1zzQLKZSZ/wD2wsvzI6tCej4xMKz98GYleWeI1H1PLb/
	 CZE8gmkvDn1X92jt2xJEjJbIP8P2F9rDhhyYNrNLbm+Uqyn3W1nivD/XPU9NLlZRtu
	 Djy0QMIdKfOLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC03938C6F;
	Wed, 15 Jul 2026 08:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410481264.3960544.5024095828575176304.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 08:40:12 +0000
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
In-Reply-To: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, cong.wang@bytedance.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307710-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C595E75BF9A

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 07 Jul 2026 06:23:55 +0200 you wrote:
> Fix for UDP sockets getting leaked during sockmap lookup/release.
> Accompanied by selftests updates.
> 
> Two Sashiko's concerns to be addressed separately:
> https://lore.kernel.org/bpf/20260626205814.BAC3C1F000E9@smtp.kernel.org/
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/4] selftests/bpf: Ensure UDP sockets are bound
    https://git.kernel.org/bpf/bpf/c/fe3ff273767e
  - [bpf,v4,2/4] bpf, sockmap: Reject unhashed UDP sockets on sockmap update
    https://git.kernel.org/bpf/bpf/c/66efd3368ae1
  - [bpf,v4,3/4] selftests/bpf: Adapt sockmap update error handling
    https://git.kernel.org/bpf/bpf/c/30581eda4a07
  - [bpf,v4,4/4] selftests/bpf: Fail unbound UDP on sockmap update
    https://git.kernel.org/bpf/bpf/c/203b06932777

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



