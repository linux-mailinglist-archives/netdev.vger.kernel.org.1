Return-Path: <netdev+bounces-291076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFwgGIJxEWq5mAYAu9opvQ
	(envelope-from <netdev+bounces-291076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 640CB5BE2C3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 299633004427
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA5385D76;
	Sat, 23 May 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoPZGhYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275983859CC;
	Sat, 23 May 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528052; cv=none; b=X2XH4aNI+TGWeQKE0zwlO01ijbEZ7KSf/Gwug+itEsdR4LPnxnUy0l8F++6J2ouxrQASBSaPeRLySYR6+3xWM9q6nTnVT/uW0PtxiY6eOZX5L2Od/XhUuwQe4xHIP4CHVuwIA/YtbApxtSDhXkJwFHnbz/eVTall/fs+gi4wXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528052; c=relaxed/simple;
	bh=QT89pMaBKJ/oMg93LOYboh5nOdm1mkvWqSuyltJVksM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GoSqCfzPrp/6zJUt0Jmuowx21CoCdNc2YrsrtxqtfNUVSKPdTUSNUwTx+XEG1bm0Bgt92jZ56i6CEtjF+E5Qlen3ERwdz9i/DKkYquZ6/CQ5P39J5+abfMlc8whB4N66Hs7PQ/eWibKB9Y4lYuU2JyB7ORxgREP9x5duSzfOClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoPZGhYD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A81F00A3A;
	Sat, 23 May 2026 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779528049;
	bh=Lny4NBZ8fefIG+ZrC6fYgCVOIOdB3NPJC+bmy9Z1p3s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DoPZGhYDMN9RZRY5AKisFsBxijKmHYPw9rWESci+A388a4pXBvOJh/mGdcpxxypX9
	 BO+MBXfjngEeZTqNh/g9Mhp73FvnbSUkyZRO9jriElod8eiZzLGkNxcIr77kmzvqry
	 P7nbRGfTzkn8FQa8OyYUg2WVu4ThL1Fc4dIh/SdhzunGc6SFi4Drnr+/iPZ+Nj5Q3K
	 cEPCsngCW7vCsjw2urZzxS15XXk8oM2TBgWDDxmRyUkgx82OdY831lmSkRr8YF/FYr
	 GAI1+aV5o/Lj+uzhLm20fopsEJjOIb4d7JXc4FaLOp2B35BypVb166uklZ38wJWf+y
	 hZuIqUH4rcUvA==
Content-Type: multipart/mixed; boundary="===============6361821700103742778=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f7f313051e697158ce96e5d9cc5c49bae934655e982d10f58230dfd5b5c1084@mail.kernel.org>
In-Reply-To: <20260523083001.2911931-12-kuniyu@google.com>
References: <20260523083001.2911931-12-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 09:20:49 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291076-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,iogearbox.net,linux.dev,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 640CB5BE2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6361821700103742778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -64,6 +64,10 @@
>  extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *sk,
>  				   struct bpf_tcp_req_attrs *attrs, int attrs__sz) __ksym;
>
> +struct bpf_sock_ops_kern;
> +extern int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops_kern,
> +					 int rcvlowat) __ksym;
> +
>  void *bpf_cast_to_kern_ctx(void *) __ksym;
>
>  extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -74,6 +74,8 @@ #define ETH_P_IPV6		0x86DD
>
>  #define NEXTHDR_TCP		6
>
> +#define TCPHDR_FIN		0x01
> +
>  #define TCPOPT_NOP		1
>  #define TCPOPT_EOL		0
>  #define TCPOPT_MSS		2

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> @@ -0,0 +1,350 @@

[ ... ]

> +		.event = {
> +			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
> +			/* The first descriptor is partial. */
> +			{.type = RPC_EVENT_SEND,	.len = 1},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE},
> +			/* The first descriptor is available. */
> +			{.type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE - 1},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
> +			/* The first header is ready. */
> +			{.type = RPC_EVENT_SEND,	.len = 100},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
> +			/* skb has the first payload and 1 byte of the next descriptor. */
> +			{.type = RPC_EVENT_SEND,	.len = 150 + 1},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
> +			/* After reading the first RPC message, SO_RCVLOWAT should be RPC_DESC_SIZE. */
> +			{.type = RPC_EVENT_RECV,	.len = RPC_DESC_SIZE + 150 + 100},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE},

Does calling recv() actually trigger the BPF program to update SO_RCVLOWAT?

Since the kernel only invokes BPF_SOCK_OPS_RCVQ_CB when a new skb is added
to the receive queue, and not when data is dequeued via recv(), the BPF
program doesn't seem to run here.

Could this cause the test to fail unconditionally because sk_rcvlowat
retains its previous value?

Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.kernel.org/
Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)

[ ... ]

> +static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *cb,
> +				       struct rpc_test_case *test_case)
> +{
> +	struct rpc_event *event = test_case->event;
> +	char *ptr = test_case->data;
> +	struct epoll_event ev;
> +	socklen_t optlen;
> +	int err, optval;
> +	char buf[4096];
> +
> +	if (tcp_autolowat_build_data(test_case))
> +		return;
> +
> +	while (1) {
> +		switch (event->type) {
> +		case RPC_EVENT_END:
> +			return;
> +		case RPC_EVENT_AUTOLOWAT:
> +			err = setsockopt(cb->child, SOL_BPF, BPF_TCP_AUTOLOWAT,
> +					 &event->val, sizeof(event->val));
> +			if (!ASSERT_OK(err, "setsockopt"))
> +				return;
> +			break;
> +		case RPC_EVENT_SEND:
> +			err = send(cb->client, ptr, event->len, 0);
> +			if (!ASSERT_EQ(err, event->len, "send"))
> +				return;
> +
> +			ptr += event->len;
> +			break;

Could this lead to race conditions causing flaky tests?

The test calls send() to transmit data and immediately executes the next
event. Because network transmission over the loopback interface involves
asynchronous softirq processing, send() might return before the packet is
fully processed by the receiving socket.

If the next event is RPC_EVENT_EPOLL with a timeout of 0, could
epoll_wait() prematurely return 0? Similarly, for RPC_EVENT_RCVLOWAT,
could getsockopt() read a stale sk_rcvlowat value before the TCP stack and
BPF program have finished processing the packet?

Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.kernel.org/
Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> @@ -0,0 +1,326 @@

[ ... ]

> +static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
> +				struct tcp_autolowat_cb *cb,
> +				u32 seq, u32 end_seq)
> +{
> +	struct rpc_descriptor *rpc_desc;
> +	u32 rpc_copied_seq;
> +	u64 copy_len; /* u32 should work, but not for no_alu32 :/ */
> +	u64 rpc_len;
> +	int err;
> +
> +	rpc_copied_seq = cb->rpc_desc_seq + cb->rpc_desc_buff_len;
> +
> +	if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> +		copy_len = RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> +	else
> +		copy_len = end_seq - rpc_copied_seq;
> +
> +	/* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> +	 * clang omits the "copy_len == 0" check below, which is necessary
> +	 * to satisfy the BPF verifier's range check for bpf_skb_load_bytes().
> +	 */

This isn't a bug, but multi-line comments in the BPF subsystem are
expected to have the opening '/*' on its own line:

	/*
	 * Since LLVM commit ...
	 * ...
	 */

Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.kernel.org/
Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)

[ ... ]

> +static void tcp_set_autolowat(struct bpf_sock_ops_kern *skops_kern,
> +			      struct tcp_autolowat_cb *cb,
> +			      struct tcp_sock *tp)
> +{
> +	/* To handle wraparound. */
> +	u32 val = 0;
> +
> +	LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_end_seq: %u, rpc_desc_buff_len: %u",
> +	    TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
> +
> +	if (before(tp->copied_seq, cb->rpc_desc_seq))
> +		val = cb->rpc_desc_seq - tp->copied_seq;
> +	else if (cb->rpc_desc_buff_len != RPC_DESC_SIZE)
> +		val = RPC_DESC_SIZE;
> +	else
> +		val = cb->rpc_end_seq - tp->copied_seq;

Does this code incorrectly set SO_RCVLOWAT to the total combined size of
all unread frames when multiple RPC frames are received in a single skb?

If multiple complete frames arrive in the same skb, the parsing loop in
tcp_do_autolowat() parses all of them and advances cb->rpc_desc_seq to the
end of the last parsed frame. This sets:

val = cb->rpc_desc_seq - tp->copied_seq

which evaluates to the length of all unread frames combined.

If an application sequentially reads one frame at a time, tp->copied_seq
advances and the queue size decreases, but sk_rcvlowat is not updated
because BPF_SOCK_OPS_RCVQ_CB only fires on packet enqueue.

The remaining queue size will then be strictly less than sk_rcvlowat,
causing epoll_wait to block and trapping the remaining fully-received
frames in the receive queue.

Could this hang applications that rely on epoll to read one message at a
time?

Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.kernel.org/
Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26328541814
--===============6361821700103742778==--

