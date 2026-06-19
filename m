Return-Path: <netdev+bounces-300755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hn2wHaarNWqz2wYAu9opvQ
	(envelope-from <netdev+bounces-300755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:50:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C776F6A7B73
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T1i9wjCc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300755-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D68305A5E0
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEF3B7B8E;
	Fri, 19 Jun 2026 20:50:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733D3168E1;
	Fri, 19 Jun 2026 20:50:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902243; cv=none; b=ImDThkTLxrvGk1ApqlGbX51ndVl5Etcndh84l7p7hDU7YBG/3zaVldI4Mfodwa2epqx48FOLtO8WXKwo8kY3kQHVPv/MtcAohsFPTUS0SXl1ATvUKjxWn6pJK5lv4zkRk08Bkx3srU/48/CY5RqadCJJGga78nzC6G7bza5OJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902243; c=relaxed/simple;
	bh=8hWp383H20IPYVUxSk9jh3jSBzTnmAxeNn/+eU1iGjA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tkG6fzOwVl8h4SSP1h2M1law8N80Lg1McPhsBPN/cnV4h3EYsh2xcx7vsUUsJO4nZyPmdvxfa2FJCfErApD/5GaLMKs4R1ptyPBPat2FabSWR2/1WIei29sny5GUdQiJShRBeZ1YMDcO3oAQZDwoBsuQKPHEEipc1cD8j/SqhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1i9wjCc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059331F000E9;
	Fri, 19 Jun 2026 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902242;
	bh=ubdVkCBTxLsblQQGBqC3jnfb2D+Th5kU/3TXixs/ZmU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T1i9wjCc468MBpKbBtx6X6RTBeOrKW6N6/wyle0++wNabnRSP+mwT121yo+k0x3vj
	 1QhP4gkUN1+YGPDfakO9pAzMAC52MpcG7Ca3D9Oi/iksARIxj+f0msoAYQbqsyEz6K
	 DXUefK1mBHHHRAK3u5QxGaXIIUQ8fBjHx3NLKJNkAJJBUVd185iNe8gR/A6mhsf+3D
	 qkLF+LshsH3n2hKaTcs8vSsfCuOjium6q6y71Xhe7/LSEhg0nL4rM87Fpudiq+57kf
	 eLoxWe3l3xryuMIFwrD/c92fe/8szPWVSEzevc7zLDYq/3TFLd3z1rela5Cy4+nl+q
	 uwyBGYiBIKMJA==
Content-Type: multipart/mixed; boundary="===============5507353603011061172=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <035e07c85b038384c51d75e5c98b80b62ce272b43831f8fb3ed34a65c0da29b6@mail.kernel.org>
In-Reply-To: <20260619195759.41254-2-siddharthcibi@icloud.com>
References: <20260619195759.41254-2-siddharthcibi@icloud.com>
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
From: bot+bpf-ci@kernel.org
To: siddharthcibi@icloud.com,ast@kernel.org
Cc: siddharthcibi@icloud.com,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 20:50:42 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-300755-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[icloud.com,iogearbox.net,davemloft.net,kernel.org,gmail.com,fomichev.me,google.com,redhat.com,linux.dev,etsalapatis.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS(0.00)[m:siddharthcibi@icloud.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:email,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C776F6A7B73

--===============5507353603011061172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Store rx_queue_index in struct xdp_frame during xdp_buff to
> xdp_frame conversion and restore it when rebuilding xdp_rxq_info
> for cpumap and devmap execution paths.
> This preserves ingress RX queue information for XDP programs
> executed after redirect, allowing access to the original
> rx_queue_index instead of losing queue context.
> Also propagate rx_queue_index for zero-copy XDP frame conversion.
> Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>

This looks like a fix for the cpumap path, where the synthetic
xdp_rxq_info was previously built without a queue_index, leaving the
placeholder:

kernel/bpf/cpumap.c:cpu_map_bpf_prog_run_xdp() {
	rxq.dev = xdpf->dev_rx;
	rxq.mem.type = xdpf->mem_type;
	/* TODO: report queue_index to xdp_rxq_info */
	...
}

That synthetic xdp_rxq_info, with the missing queue_index and the TODO,
came in when cpu_map_bpf_prog_run_xdp() was added.  Should this carry:

  Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")

The devmap path (dev_map_bpf_prog_run) shares the same missing
queue_index, which was added in fbee97feed9b ("bpf: Add support to attach
bpf program to a devmap entry").


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27846609854
--===============5507353603011061172==--

