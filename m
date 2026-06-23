Return-Path: <netdev+bounces-301468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R5EaEeDfOmquJggAu9opvQ
	(envelope-from <netdev+bounces-301468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B96B9BBA
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mjZcuymf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301468-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301468-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EF63032815
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421FC39281F;
	Tue, 23 Jun 2026 19:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9826056C;
	Tue, 23 Jun 2026 19:32:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243170; cv=none; b=UhEvVu/hCSYIOJgFrEKyXd2PauRKgZkdtA4QVO0/6YqcC0F28+zzsPwwDb8Tg+yvoyjfhwRFIFai9dSzaIiRdeqMiknOv95bk0y19HVyPFxlqSv/bC/oAVn+RJE5T/wWhgGYIKpiFxCQVs+RPlSR1fVm7RW5XQ4AuUU4h6l7gdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243170; c=relaxed/simple;
	bh=ZhyYAv1LAk9Fd5ym1hfpDchpJgpRnThHsYVxslIz6hY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UP+o9NAPTdnT4e8WMdqVMHAop44SIvTZNdpPapjEQz+yKl32FDNfrd4ndmeNV3MBiEol8wk/6XSQumCNd0Vm5ctxFzRTr+XAdOSVIRdC1qLZkQ05qd10XSpWlx5tEWLTEJOIHTdHkGw/IY4ivJXpd9AzajOG52KSM7VcQWL2XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjZcuymf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB4F1F000E9;
	Tue, 23 Jun 2026 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782243168;
	bh=zjmjqIXfFLoKYyECjDc2KJQLsVIQCOnpPpM/XShRwso=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mjZcuymftxtlGpBNIhpghDdGRjBp2Eocq6XDg2sUogJ5H12rH/9wPJIj51NyxiRty
	 MmJYyVZa8F6XcHJojx4R/eiGCIaHwlGWPt3Peol7oZfFWEqstXUy+5d6rLplPRhr2L
	 ouAGTytVdpp/nAuUGB6ToqvwiPfnFgN36fw7dJW7uMsBXPtAdeugUHQeLD4m9kQ78T
	 jPHxM8Qm4KrG3G5NfLYt6tRGkb4a664RHOc7+Wrem1wupP81L0ZVjgr/z53szr5FIE
	 oxKkYHI3zjDH2H06WGC/EpZEYecx3MtdtpM+FVhlqjnM9ND2BojWej+bBmWPWogsXA
	 VZt+QDy6qH0Hw==
Content-Type: multipart/mixed; boundary="===============8256220830597851060=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd4abd3f584c38f1fc512a9d3ae1f90c2a374588fa23529b32b7f1aed6ab2ead@mail.kernel.org>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
References: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,cong.wang@bytedance.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mhal@rbox.co,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 19:32:47 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-301468-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,rbox.co,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 851B96B9BBA

--===============8256220830597851060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
>
>     Setup and join a cgroup, then attach a cgroup/connect4 program that runs
>
>        sk = bpf_map_lookup_elem(sockmap, 0)
>        bpf_bind(ctx, sa, sizeof(sa))
>        bpf_sk_release(sk)
>
>     Unpatched kernel leaks the socket.
>
>     Signed-off-by: Michal Luczaj <mhal@rbox.co>

This test reproduces a UDP socket leak across sockmap lookup-bind-release,
but there is no Fixes: tag.

The sibling fix commit a2510dc351c5 ("bpf, sockmap: Don't leak UDP socks on
lookup-bind-release") carries a Fixes: tag pointing at the commit that lifted
the socket-state restriction allowing unbound UDP sockets into sockmap.

Should this test carry the same tag so it stays backportable alongside the
fix?

  Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28049771327
--===============8256220830597851060==--

