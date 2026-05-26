Return-Path: <netdev+bounces-291927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNamHGkKFmpNhAcAu9opvQ
	(envelope-from <netdev+bounces-291927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:02:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC545DC91B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CC530125D3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFE3BD646;
	Tue, 26 May 2026 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZkRa4uX"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584023C276F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829322; cv=none; b=pGCkMni4Z0JeUy20cDsgA+qZsgaXGQQneg5D7yr1z9A1DgepixQsjKeYDB3FwuNYDswUdtbUFjHE4cdLcGwY29kmYHmY854k+GKw7hiVtPihvW5HfEvieBAuFQ+JwE20d4leUfwn71Nvn87EDQBVUy3EbqCvSX1t7JgrSisqRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829322; c=relaxed/simple;
	bh=/7gxm0ztRnL4VuNYQ5xyhxMZvgVwQzORjO023WXMEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y93fOWPDUuKNP9qX1EK1odqOnTLyefOqfkTcum4LfEu3infrVKcz/oJ41xcm0XccIQnqED+yogRxuLsozRtEwSBaG5dqgzs/OOZzWdnuaeEWC9ZWwqDXuUtyFf1MXSDTifM/KXQQyxdK0wZIjG96pe5RjFTCFfqoTgVccFAqwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZkRa4uX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 May 2026 14:01:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779829308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tU6iIA1AHS++grQa49/VChzcNhRWRhTecBu3tlxsvGw=;
	b=hZkRa4uXrVppnjhxzAayd/BJtN3jysuXFZ6KiVG0e8it1mhjEWqdhjyy/tMwv+TCacvGHa
	8RWpUT2KaR3twHCDny6bJ5wC/jHAwc/mocLd+ZkNAVPDtxGTycK+01VUWhprZCce4CQV5a
	D9tEGF5WQHyctCJOHw5MV+8FdwYTJEM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVQ_CB.
Message-ID: <202652620533.bfqf.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-12-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523083001.2911931-12-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291927-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CFC545DC91B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 08:29:40AM +0000, Kuniyuki Iwashima wrote:
> +static void tcp_do_autolowat(struct bpf_sock_ops *skops,
> +			     struct tcp_autolowat_cb *cb,
> +			     struct tcp_sock *tp)
> +{
> +	struct bpf_sock_ops_kern *skops_kern;
> +	struct tcp_skb_cb *tcb;
> +	struct sk_buff *skb;
> +	u32 seq, end_seq;
> +	int ret = 0, i;
> +
> +	skops_kern = bpf_cast_to_kern_ctx(skops);
> +	skb = skops_kern->skb;
> +
> +	if (!skb)
> +		goto update;
> +
> +	tcb = bpf_core_cast(skb->cb, struct tcp_skb_cb);
> +	seq = tcb->seq;
> +	end_seq = tcb->end_seq - !!(tcb->tcp_flags & TCPHDR_FIN);
> +
> +	LOG("Start parsing skb: seq: %u, end_seq: %u, len: %u, "
> +	    "rpc_desc_seq: %u, rpc_end_seq: %u, rpc_buff_len: %u",
> +	    SEQ(seq), SEQ(end_seq), end_seq - seq,
> +	    CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
> +
> +	if (cb->rpc_desc_buff_len != RPC_DESC_SIZE) {
> +		ret = tcp_parse_descriptor(skops, cb, seq, end_seq);
> +		if (ret)
> +			goto update;
> +	}
> +
> +	i = 0;
> +
> +	while (1) {

A nit. It may be useful to take a look at progs/arena_htab.c or
rbtree_search.c on the 'for (i = zero; i < xyz && can_loop; i++)' usage.

#> ./veristat tcp_autolowat.bpf.o
Processing 'tcp_autolowat.bpf.o'...
File                 Program                   Verdict  Duration (us)  Insns  States  Program size  Jited size
-------------------  ------------------------  -------  -------------  -----  ------  ------------  ----------
tcp_autolowat.bpf.o  tcp_autolowat             success         245961  12624     338           141         939

The "Insns" could likely be reduced to ~1000s level.

