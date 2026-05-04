Return-Path: <netdev+bounces-284052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kw9HKgU+WkY5QIAu9opvQ
	(envelope-from <netdev+bounces-284052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E34C43AA
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1503530069BC
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3436EA98;
	Mon,  4 May 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHJwWQCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C736E47A;
	Mon,  4 May 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931424; cv=none; b=pIy/ZtQ+Td8u7eXEDI6YRn0UnRAWk5x4G4zcKChivxE1SiCU9fTatjhmcJ6WsahYA34+AIMHZ459lkJ0c/pCgNKj0w1aQETuLaqAa/dagej17pWo4tLc+SCUoxoJvCm2wgGPHcZAry4acVr7MciLytZWpgxl42B+ve+PCF5jpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931424; c=relaxed/simple;
	bh=FmK10/+ipLRQv3vVu5kjbdbxEcWPXkjzomIWzmxkkGQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=izy21z6l3gd1+QrFEP3tGaT+BqA9gzPa8dSKTouplIWZ30p1zquSwt99By66xKInv/ob618iup1T77zvADH+EUhvGREnfaS8rUSZLvW9icMA5L+8PdXQUwLT+r88s3mVznHMZQ1axkoEeFKPK6gEJ1Sb2P6m2gX+94oNpexvCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHJwWQCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4C0C2BCB8;
	Mon,  4 May 2026 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777931424;
	bh=FmK10/+ipLRQv3vVu5kjbdbxEcWPXkjzomIWzmxkkGQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CHJwWQCF54nhQOLn/SJxDPFTuMH+F56TLIpvh/6rmq0BeODWnymObs0iNt0JkQ5i1
	 zHTdeYlyuSjR/QHA16w9nMgy6k6+rUoXggY2XBOY0PJzk+lW5NibMgMs0zOrQEvRAo
	 a/Zw3nQONSIMspah4kR6PZ5p8+pYjlCEFu0l9tIn3KWgfIuyyVJyMVbTZtAwR8a5bm
	 8gcoOoXRBPQyzHasFESxI/lO9q3kvaXSjYNBA4ah7zqNwqauQE1dlvx7i2wvgkIJq5
	 NNMHr7wz80kYhMUwOyrlF9XnCg2qn1D208b/zBDszc9GbLszsiA0MUTZsL/K4ykTLq
	 QGwMhuTEm5chQ==
Content-Type: multipart/mixed; boundary="===============6308584774407186442=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f3fb214ed73246731c525dfdccdcd379bd6d4f1e4570eba0cd19d56f888f9b0a@mail.kernel.org>
In-Reply-To: <20260504210610.180150-2-kuniyu@google.com>
References: <20260504210610.180150-2-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf 1/6] bpf: tcp: Fix type confusion in bpf_tcp_sock().
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,martin.lau@linux.dev,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: john.fastabend@gmail.com,sdf@fomichev.me,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,edumazet@google.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,melotti@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  4 May 2026 21:50:22 +0000 (UTC)
X-Rspamd-Queue-Id: 6F6E34C43AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284052-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[google.com,linux.dev,iogearbox.net,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

--===============6308584774407186442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc96c18df4e0..cd88633f8dc1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
>
>  BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
>  {
> -	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
> +	if (sk_fullsock(sk) && sk_is_tcp(sk))
>  		return (unsigned long)sk;
>
>  	return (unsigned long)NULL;

While this patch fixes bpf_tcp_sock(), does sol_tcp_sockopt() remain
vulnerable? Since ctx->sk evaluates to PTR_TO_SOCKET in a CGROUP_SOCKOPT
program and is directly accepted by bpf_setsockopt() and bpf_getsockopt()
via ARG_PTR_TO_BTF_ID_SOCK_COMMON, can a user create a RAW socket with
IPPROTO_TCP and directly pass ctx->sk to bpf_setsockopt(), bypassing
bpf_tcp_sock() entirely?

Looking at sol_tcp_sockopt():

static int sol_tcp_sockopt(struct sock *sk, int optname,
			   char *optval, int *optlen,
			   bool getopt)
{
	if (sk->sk_protocol != IPPROTO_TCP)
		return -EINVAL;

This appears to only check sk->sk_protocol == IPPROTO_TCP without verifying
sk->sk_type == SOCK_STREAM, which would allow the same slab out-of-bounds
access through a different code path.

Additionally, do bpf_skc_to_tcp_sock() and bpf_skc_to_tcp6_sock() suffer
from the same type confusion? They appear to check sk->sk_protocol ==
IPPROTO_TCP without verifying sk->sk_type == SOCK_STREAM.

Could a BPF program pass a RAW socket with IPPROTO_TCP to these helpers
and receive a valid BTF pointer to struct tcp_sock, allowing out-of-bounds
slab reads?

Looking at bpf_skc_to_tcp_sock():

BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
{
	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
		return (unsigned long)sk;

	return (unsigned long)NULL;
}

And bpf_skc_to_tcp6_sock():

BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
{
	/* tcp6_sock type is not generated in dwarf and hence btf,
	 * trigger an explicit type generation here.
	 */
	BTF_TYPE_EMIT(struct tcp6_sock);
	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
	    sk->sk_family == AF_INET6)
		return (unsigned long)sk;

Finally, does bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c also need
a similar update? It checks sk->sk_protocol == IPPROTO_TCP and immediately
evaluates sk_is_mptcp(sk).

Since sk_is_mptcp() indiscriminately casts the socket to struct tcp_sock
and accesses tcp_sk(sk)->is_mptcp, passing a RAW socket could trigger an
immediate out-of-bounds slab read. If this memory happens to be non-zero,
it might proceed to call mptcp_subflow_ctx(sk)->conn, which would read a
garbage pointer from out-of-bounds memory:

struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
{
	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);

	return NULL;
}

These issues were raised by sashiko-bot@kernel.org in v1:
https://lore.kernel.org/bpf/20260501184452.7F46FC2BCB4@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25344293379
--===============6308584774407186442==--

