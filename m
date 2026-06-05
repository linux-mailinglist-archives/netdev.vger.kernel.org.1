Return-Path: <netdev+bounces-295872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t3qVIeLuImqSfQEAu9opvQ
	(envelope-from <netdev+bounces-295872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C946F6496A1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:44:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GGTEaJWB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295872-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295872-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C328D3053EB2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398C4192F2;
	Fri,  5 Jun 2026 15:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82383E4C65;
	Fri,  5 Jun 2026 15:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673409; cv=none; b=KGCPLu8GYJUJge/SXmtcLQMTqJt/jD4aQZWAKBlXJcb0pMbGoOGZHZsJCNQuhljxZVZHaata36le4K8EbvPi3HvGKo73D5maoNfanyP7JgRwdd8zS8wcrX/2N5jRuVKzHglE5n3XGAJojEk0HQp6OX3nbcGvnBsp8P1Pb2OYHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673409; c=relaxed/simple;
	bh=C1xtfUG0N5An2pmcMOU3sBP+r3o1WVlAapOlrsAjkgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6aB5IzPLHbjNMBEflyPD+wAhC+rOxIKvto764wTdLdIlCQvQK51B8kfcBUSWJk7uwneCtPixShMa/UAipOhwUI44HW8CkelnbGn6BqU2xBL8P9GJYbR4KoX7P9n+9o9h1a175mzfaS0PFua33kfwAkgH3OL00VuHJc9QaeOuf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGTEaJWB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCA1F00898;
	Fri,  5 Jun 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673408;
	bh=htU68yBnR6ThA/0S5lSqWG9Jdr22od7ZJqdXDvMAz+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GGTEaJWBmhmoFNdtSnabN4ffLhxoZ3IDy06FpCysYQZOjc76TlFx0WEDSuzpGQSWB
	 8VYqEh0eVKit7uHu9bVyHxnz5hBrPLpujo9uzjTKrQ+himWZXCus2rNiThi6gK3cyu
	 8KkO21KiFytirc3WbAxJSS0MQfxMx47w2ISHPflwhfveq7Z2iVn4F3oKfv07fUJU0s
	 E16/lCCSlq07o4zoZutEqAVuOsHNQZTzPRypLkyWJ/3mgj58/uaorWH2UawFOCVLcV
	 KszQlTkieQZWB95qtexKsow8wMlRLS5rxeCzyI8dS4Or9GTzs4bYJghi42up979NMr
	 bjnyq6dDzvRDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A833930BA5;
	Fri,  5 Jun 2026 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based
 broadcasts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067340889.3804693.6720254457883948615.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:30:08 +0000
References: 
 <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
In-Reply-To: 
 <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, toke@redhat.com,
 liuhangbin@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, zzhan461@ucr.edu
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295872-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,redhat.com,lzu.edu.cn,ucr.edu];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:toke@redhat.com,m:liuhangbin@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:zzhan461@ucr.edu,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucr.edu:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C946F6496A1

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jun 2026 16:43:33 +0800 you wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
> 
> Devmap broadcast redirects clone the packet for all but the last
> destination.
> 
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: devmap: reject fragmented frames in clone-based broadcasts
    https://git.kernel.org/bpf/bpf-next/c/aa496720618f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



