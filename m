Return-Path: <netdev+bounces-298874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyFBF7OyLGpLVgQAu9opvQ
	(envelope-from <netdev+bounces-298874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E567D725
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="TYp6/NL1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298874-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298874-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C219323CA33
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E8F39283C;
	Sat, 13 Jun 2026 01:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA78391E57;
	Sat, 13 Jun 2026 01:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314213; cv=none; b=Z4ne7CP+Ua8tm5zVhlqV+PeuhJPdw92Yv8LiYG5Rq3bUiOWfqabz80TwAV6NeiLl9jHYTtHzjOzD3qWwPea1oXQzY430+4gmTFrS6imb/grXD6f68DGaLp92PtD3jETowdgumuyBdj3Hs9atJITaaTxyW9ftQJPxbN6z3qZvCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314213; c=relaxed/simple;
	bh=3upDyn5RhcofBT2froWXmIYYJa39rXG8LBPHUpHv3oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DMcXjiGDVOueAY85U9Fxa8cUnocz8Z51E95ROS433qscukXHF57t1hBR4Erlz53CmwAbwxtjKuHiG401GDXdQfw5WWGg1H+5VnnAFufHMkLvPo4htWJNiPM7CW7IZmRWR1liV7NEpH7Vkr5hQMK1MH3vKPfOZtkYWwHSw+0nudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYp6/NL1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42811F000E9;
	Sat, 13 Jun 2026 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781314211;
	bh=5pcfRNmimPChlCbZjWnbiudfie8PBLs0TM/PI/AZ7NA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYp6/NL1QCXWddtrd7pYD4KAGRSTgs4BPqNcBpAN6U0ygphNkvxJNX3r7Qdsnzyd2
	 sRMYW+0/KoRRVRaLENCm+mpjKMFoK7mdHF+tBmqmkDCWnutpLwhkWDlpUlGngsMlbu
	 IWx5Ts3NQrA3ibE3npyJZc50UTgK1UHACiGii0AEZBK6ZgTXcqtX5LVNCuKj/UDsOo
	 QyIIZyDB69Uf1KroYrcW+SrkeqBWWjQvIlIfQj/zB62N+aDyMCabVL1di1NXKZJS9j
	 wUIC+hGtdTIKTOHIlFI+mOcBcbuLkbFvQ3LUveu8oGzIJX3WPGlOyvilVAGKkaNanH
	 0GL4MYpGabroA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A3439E9607;
	Sat, 13 Jun 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/2] bpf: Fix generic devmap egress skb sharing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131420839.1324271.17087407155107747116.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:30:08 +0000
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, jiayuan.chen@linux.dev, toke@redhat.com,
 menglong.dong@linux.dev, emil@etsalapatis.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298874-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A65E567D725

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 12 Jun 2026 19:40:30 +0800 you wrote:
> Generic XDP devmap multi redirect can leave cloned skbs sharing packet
> data. When a devmap egress program mutates packet data, another
> destination sharing the same data may observe that mutation.
> 
> Fix this by making cloned skbs private before running the generic devmap
> egress program. The private copy is made in dev_map_generic_redirect()
> so dev_map_bpf_prog_run_skb() can keep returning the XDP action directly.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] bpf: Run generic devmap egress prog on private skb
    https://git.kernel.org/bpf/bpf-next/c/6001896f0098
  - [bpf,v5,2/2] selftests/bpf: Cover generic devmap egress last-dst rewrite
    https://git.kernel.org/bpf/bpf-next/c/f0eff94d07cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



