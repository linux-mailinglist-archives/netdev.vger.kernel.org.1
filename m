Return-Path: <netdev+bounces-256699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODHjCD1Fg2nqkgMAu9opvQ
	(envelope-from <netdev+bounces-256699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:10:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA67E6379
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76FE304DEA1
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7D40B6C0;
	Wed,  4 Feb 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8dukxSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157821D3F3;
	Wed,  4 Feb 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210296; cv=none; b=hOF3I4zvDSYKuoyLQNNmgSS/auB3qL4+I045OKMYmANPvj1jw0yK7Y7MFeY8IO+NsJ3hOuRmU0PxKwx+uPuw9JPC49D/ObtPbeOaWV6R6pKUS44F31hJ+UJT94Rx0nyVpqHViu4X2BBarJcbMkY5ZF42px5XJeQPelbaA67Pl28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210296; c=relaxed/simple;
	bh=t5rwIpvTwqvo+MrjZpxhrJz32tY2+75WSQEZtzqs8Ak=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pMK2Vvdx2SRcZoAfKDbaF65lP8clh7CXKx3XIm2MBbqblKmp+sdxdo0vikZgFG48iTdO9oLZwPKFYH3wsXcmw+EUztD1/URn2/+BGKcmOhJJeE7DniEJF5aXdclpc3VFAe8xhMN2cp1+rK6LByat+y4hu/XEU+tRz+4BTpQjmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8dukxSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB88AC4CEF7;
	Wed,  4 Feb 2026 13:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770210296;
	bh=t5rwIpvTwqvo+MrjZpxhrJz32tY2+75WSQEZtzqs8Ak=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=K8dukxSvFphRFOzEdLJvrMAzBBhVEXqTjvKAPjYj7AMGCEl/cQfYTp067nQkPMADL
	 CR/WJu3tLRUds/H4yfwn7EUv0c7/hDQIJ7F2WmlFLI4n686pkduj87Cl/f4r7Yuao9
	 h5nK6dAr2swO4uHqoie3yURdA9QSSVXvzKH8/WY92xQCneLnA7fDSHC0XYyPvZlRi3
	 SZCCgXyOzMCUtfAj1nV9H2WBEAjFTXhp7uIWyHYpQhRpvOGWqWJ7Z0Wd64TaZgOITz
	 +DkggZ1KJ5Jj/jtBkYWWJDqUpYxPOvsCEVs8jRqOtP7dzahiwslIXPvHKaGhn2hkbX
	 7DlpGqKuDtw9w==
Content-Type: multipart/mixed; boundary="===============1159060639630682925=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org>
In-Reply-To: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
References: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
From: bot+bpf-ci@kernel.org
To: afabre@cloudflare.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@cloudflare.com,wferguson@cloudflare.com,afabre@cloudflare.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 13:04:55 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-256699-lists,netdev=lfdr.de,bpf-ci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[cloudflare.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32]
X-Rspamd-Queue-Id: 7CA67E6379
X-Rspamd-Action: no action

--===============1159060639630682925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     But the TCP TIME-WAIT state needs special handling for this: packets
>     received for a TIME-WAIT socket can either belong to the current
>     incarnation of the connection, or a new incarnation. The only way to
>     determine this is to compare the sequence numbers.
>
>     Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
>     numbers to be read.

Can this approach work for TIME-WAIT sockets? Looking at bpf_tcp_sock() in
net/core/filter.c:

    if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
        return (unsigned long)sk;
    return (unsigned long)NULL;

And sk_fullsock() in include/net/sock.h:

    static inline bool sk_fullsock(const struct sock *sk)
    {
        return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
    }

TIME-WAIT sockets are explicitly excluded by sk_fullsock(), so bpf_tcp_sock()
returns NULL for them. The sequence numbers stored in TIME-WAIT sockets
(skc_tw_rcv_nxt and skc_tw_snd_nxt in sock_common) would not be accessible
through this helper.

The change itself is useful for accessing tcp_sock fields from established
connections in XDP, but the commit message implies this solves the TIME-WAIT
sequence number problem described, which doesn't appear to be the case.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21671977729

AI-authorship-score: low
AI-authorship-explanation: The commit message style is consistent with human-written kernel patches, with natural technical language and standard formatting; the technical error is more likely human oversight than AI hallucination.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The issue is a misleading commit message that claims the change enables TIME-WAIT socket sequence number reading, but the bpf_tcp_sock() helper explicitly returns NULL for TIME-WAIT sockets.

--===============1159060639630682925==--

