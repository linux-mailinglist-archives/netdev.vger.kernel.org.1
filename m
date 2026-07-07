Return-Path: <netdev+bounces-305333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mfvRJ1S8TGq+owEAu9opvQ
	(envelope-from <netdev+bounces-305333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C2D71946A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NqCum4IJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305333-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305333-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA1D3007AEB
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612FD3264FC;
	Tue,  7 Jul 2026 08:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3C2459E5;
	Tue,  7 Jul 2026 08:40:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413627; cv=none; b=nkX8aWqSGOTUvt+QiyePXHlQqrDY7ZWX6GzbSdLn/FvWnRDidagc0D3IiQlPNHR46SILhaRNTq1veE0t6G3iugP7sCE30bGdOw96yp8tUx5N4sj4nk8jyJMwyZSL4wQFy6VNjvsWMmWDtA909WihideWK4byACjTuIIssP1SUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413627; c=relaxed/simple;
	bh=KQte1xYYXSlk71R+by2fCp6liTq7fRmyqHlxw6SQvvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fuaY6q49aLMHTzD8RbokdraQxvTaQ87Xrt0tR+cD1r7UCUfNKCKr1T4l2XF6ClsWYHAmI4x8eaFpt+vVIbVGs0SwpGOkZyITE8tQITyKhBrrVmp8lSZfzIx6OT/SYOb9uQDpz19f27W2STxW5bRrhzMyFFzkPANdXxQdE6VijaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqCum4IJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D263F1F00A3A;
	Tue,  7 Jul 2026 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783413625;
	bh=6pPjjJWgI4QmgLZ+t0RAIIz/DKF1BXp4p7v//2iLbnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NqCum4IJ6b0EY2vskmseepw8EDbH1VJs3jybVnAdBXN+OBvZvL4d+hFlPD6/RSDAp
	 KTrg1bhxjP+Dn1DK34id6JaXUwJnA7wezGasfjOxfZ4ebYpZ1C5yezSXuwJp6GVk+F
	 7QE9Vg1KQmvPAcIDsbWuxOaGYNos3LVouKviGvUSd2mgj0qRUeB+5iuDFdQ8WdAh4N
	 5pEHO87bXUaUAuomBMAbheTIM+c007Nde1cuMEZ5XKoprF06HbT7TVsjoBumlyUNJu
	 XaOspb4IMJpvKFrQDaOSx7VInSbkJrNRQA80vsUiWVT8GpCD+PFBiyLP/IG6bc1CV6
	 HY2pgW9yRUlZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198283925461;
	Tue,  7 Jul 2026 08:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf,
 sockmap: disallow sockmap mutation from tc, xdp,
 socket_filter and flow_dissector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341360589.1430372.1113135547618558255.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 08:40:05 +0000
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, shuah@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, sdf@fomichev.me,
 jiayuan.chen@linux.dev, varunrmallya@gmail.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
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
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,linux.dev,etsalapatis.com,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305333-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0C2D71946A

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jun 2026 14:54:04 +0000 you wrote:
> A tc, xdp, socket_filter or flow_dissector program updating or deleting
> a sockmap deadlocks on stab->lock vs sk_callback_lock and has no reason
> to. Patch 1 disallows it in may_update_sockmap(); patch 2 drops the
> selftests that exercised it.
> 
> v4:
>  - also drop BPF_PROG_TYPE_SOCKET_FILTER (John Fastabend)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf, sockmap: disallow update and delete from tc, xdp, socket_filter and flow_dissector
    https://git.kernel.org/bpf/bpf-next/c/7fb52b3bd3a3
  - [bpf-next,v4,2/2] selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



