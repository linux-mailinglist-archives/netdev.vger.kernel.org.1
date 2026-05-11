Return-Path: <netdev+bounces-286682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ck/yEwXmAWqemAEAu9opvQ
	(envelope-from <netdev+bounces-286682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A917E510030
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9599130F0BF3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A63F7A89;
	Mon, 11 May 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXdEph2Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405753FA5CC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508797; cv=none; b=GA3052+XBy4xCIRPH/fBjvIkmjvM8OrqO6Z2wtpW7YZbREzNtRQX06X8zUC94GelJ7KlRguqZ0nYBsEByBghG1//41ys+SYrWUmuKlDX1aOKL8ENToZsPY6Gb4ys5BEhfBGH/HDvSwANE0pNXRJCYon6Al07XZrNnA+znMm0XOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508797; c=relaxed/simple;
	bh=2uDaZAnoc1mZPaST/NJPg23YufmGrPRpbXql74Q7jD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEYhPzGFV4856URp9YB1d2HXNzQhA28q6qkUVyAstLUMeIg1wgiZUcKAPc/6y2vaoJvndSJgZzLLdms/fi3f4dIyMciJ7+OcxKRGqvvCla7EK4f2bLcdkE2R5pZQJFbms3jwlRyHdDUX9fN+qxNaq+f3I4/Dxzqvtup875FCHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cXdEph2Q; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac03371e-4183-4ac5-aad5-0c7370c37ecc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778508793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBuWaYHhzQ1vdCuoFs55bvi5uBD2eoGuOUdaBdvgMsE=;
	b=cXdEph2Qjs5+OW+FtVSx3Ai9A/QtA1oFs4OJj7rrYmZb6O7f0XXfp5koS+p5SeKEGoiUl+
	ptu3SukZN5xm2NlgxLqTQX87Px0y8yt8IkRbjoeDkGTo6kGF8+6RFvw65APvG55CxwCJpe
	/HrPen8m/MxDZqkyhYVJNd+dZ6MisLc=
Date: Mon, 11 May 2026 22:13:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] selftests: bpf: add test for KTLS+sockmap
 reverse-order UAF
To: Xingwang Xiang <v3rdant.xiang@gmail.com>, john.fastabend@gmail.com
Cc: kuba@kernel.org, jakub@cloudflare.com, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20260511124149.14834-1-v3rdant.xiang@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260511124149.14834-1-v3rdant.xiang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A917E510030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/11/26 8:41 PM, Xingwang Xiang wrote:
> Add a selftest that reproduces the use-after-free triggered when a TCP
> socket is inserted into a sockmap *before* TLS RX is configured on it
> (the reverse of the order that is already blocked by the kernel).
>
> Vulnerable sequence:
>
>    1. bpf_map_update_elem(sockmap, server_fd)
>       -> sk->sk_data_ready = sk_psock_verdict_data_ready
>
>    2. setsockopt(server_fd, SOL_TLS, TLS_RX, ...)
>       -> tls_sw_strparser_arm() saves sk_psock_verdict_data_ready as
>          rx_ctx->saved_data_ready, then sets
>          sk->sk_data_ready = tls_data_ready
>
> When data arrives:
>    tls_data_ready -> tls_strp_data_ready -> tls_rx_msg_ready ->
>    saved_data_ready() [= sk_psock_verdict_data_ready] ->
>    tcp_read_skb() drains sk_receive_queue via __skb_unlink() without
>    calling tcp_eat_skb(), so copied_seq is never advanced.
>
>    tls_strp_msg_load() then finds tcp_inq() >= full_len (stale), calls
>    tcp_recv_skb() on an empty queue, hits WARN_ON_ONCE(!first), and
>    returns with frag_list still pointing at the now psock-owned (or
>    already freed) skb.  tls_decrypt_sg() subsequently walks that stale
>    frag_list: a use-after-free.


Hi Xingwang,

Thanks for your selftest.


I think sockmap + TLS_RX has no useful semantics(fix me if i'm wrong).
sk_skb sees ciphertext and the TLS keys are pinned to this socket, so
redirect is meaningless. And both sides racing on sk_receive_queue is
what produces the UAF.

The fix should be to reject TLS_RX when the socket is already in a sockmap.

Note TLS_TX + sockmap remains useful and unaffected.


---
Please don't send this as a standalone selftest [1]. Without the kernel 
fix, this
patch just lands a reproducer for an exploitable UAF in the tree.
Please send fix + selftest together as a 2-patch series with a proper
cover letter. Also, LLM will give you more details.

[1]: https://docs.kernel.org/process/submitting-patches.html


Thanks.

