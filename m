Return-Path: <netdev+bounces-229732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19FBE04E4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31C3434DD5A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BE2FFFA9;
	Wed, 15 Oct 2025 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5+qCEZN"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44530147D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555281; cv=none; b=SyT6HghXkGu9Y5/xb3JseVqxCoKueZqZonXt7sEIXAjQOpJVKzFs05VDST0aviRKsam/g4KP8vs5pWPEVaU23rRvcva0c/v+BiTTaAZjR1DECvIGpWaSjSFeHrAiZ9ku5bwabHHQiLaviPRDU9/dBIqvPKqIKmKguUUgX6hZ6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555281; c=relaxed/simple;
	bh=V5o7oTzOVcQJ/Gas3z9lx3yHQO2sMAoJQxu+rRpX9VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJyEcRHN+/6DscMfEFuQtKG+eNw05NC3HnGKP22Mr+rzfGsybD2rqmpg1syzxUXobJBoxlngUg7FAFjXwYzX8oxJoRtmS8VVKVqQVBzCYbqZmuHa38GUaT6ekkgsgrw4A1z4SfAHsPjoc++rkWhgVBNzuOwuseJgC2nim2loywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5+qCEZN; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa80d5a7-790d-4f10-bef3-f5c708218f83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760555267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TI4ZvsdGzDFEn+JWtlN+CHhtrYWknXZWp4+S+IvRVA=;
	b=R5+qCEZNax7d7nBIspj7fyDmCarIU2s/nhVV5lZs4tYs9yHs1uk+F0fFCub1DIksxaqrRl
	XTZatvuEE5CIG5YcXULxbXtq6MwyMa/IJ8ky9s+tGEaAu+ehdf73Lq0LoXAY0EpHV0FvZ6
	AtSaAEiQGUPM8KhfJG9vVMJg/vq6Fes=
Date: Wed, 15 Oct 2025 12:07:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next/net 6/6] selftest: bpf: Add test for
 sk->sk_bypass_prot_mem.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20251014235604.3057003-1-kuniyu@google.com>
 <20251014235604.3057003-7-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251014235604.3057003-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/14/25 4:54 PM, Kuniyuki Iwashima wrote:
> +static int tcp_create_sockets(struct test_case *test_case, int sk[], int len)
> +{
> +	int server, i, err = 0;
> +
> +	server = start_server(test_case->family, test_case->type, NULL, 0, 0);
> +	if (!ASSERT_GE(server, 0, "start_server_str"))
> +		return server;
> +
> +	/* Keep for-loop so we can change NR_SOCKETS easily. */
> +	for (i = 0; i < len; i += 2) {
> +		sk[i] = connect_to_fd(server, 0);
> +		if (sk[i] < 0) {
> +			ASSERT_GE(sk[i], 0, "connect_to_fd");
> +			err = sk[i];
> +			break;
> +		}
> +
> +		sk[i + 1] = accept(server, NULL, NULL);
> +		if (sk[i + 1] < 0) {
> +			ASSERT_GE(sk[i + 1], 0, "accept");
> +			err = sk[i + 1];
> +			break;
> +		}
> +	}
> +
> +	close(server);
> +
> +	return err;
> +}
> +

> +static int check_bypass(struct test_case *test_case,
> +			struct sk_bypass_prot_mem *skel, bool bypass)
> +{
> +	char buf[BUF_SINGLE] = {};
> +	long memory_allocated[2];
> +	int sk[NR_SOCKETS] = {};
> +	int err, i, j;
> +
> +	err = test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
> +	if (err)
> +		goto close;
> +
> +	memory_allocated[0] = test_case->get_memory_allocated(test_case, skel);
> +
> +	/* allocate pages >= NR_PAGES */
> +	for (i = 0; i < ARRAY_SIZE(sk); i++) {
> +		for (j = 0; j < NR_SEND; j++) {
> +			int bytes = send(sk[i], buf, sizeof(buf), 0);
> +
> +			/* Avoid too noisy logs when something failed. */
> +			if (bytes != sizeof(buf)) {
> +				ASSERT_EQ(bytes, sizeof(buf), "send");
> +				if (bytes < 0) {
> +					err = bytes;
> +					goto drain;
> +				}
> +			}
> +		}
> +	}
> +
> +	memory_allocated[1] = test_case->get_memory_allocated(test_case, skel);
> +
> +	if (bypass)
> +		ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, "bypass");
> +	else
> +		ASSERT_GT(memory_allocated[1], memory_allocated[0] + NR_PAGES, "no bypass");
> +
> +drain:
> +	if (test_case->type == SOCK_DGRAM) {
> +		/* UDP starts purging sk->sk_receive_queue after one RCU
> +		 * grace period, then udp_memory_allocated goes down,
> +		 * so drain the queue before close().
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(sk); i++) {
> +			for (j = 0; j < NR_SEND; j++) {
> +				int bytes = recv(sk[i], buf, 1, MSG_DONTWAIT | MSG_TRUNC);
> +
> +				if (bytes == sizeof(buf))
> +					continue;
> +				if (bytes != -1 || errno != EAGAIN)
> +					PRINT_FAIL("bytes: %d, errno: %s\n", bytes, strerror(errno));
> +				break;
> +			}
> +		}
> +	}
> +
> +close:
> +	for (i = 0; i < ARRAY_SIZE(sk); i++) {
> +		if (sk[i] <= 0)

Theoretically, 0 is a legit fd. The tcp_create_sockets above is also testing 
ASSERT_GE(sk[i], 0, ...). I changed to test "< 0" here and initialize all sk[] 
to -1 at the beginning of this function.

> +			break;
> +
> +		close(sk[i]);
> +	}
> +
> +	return err;
> +}
> +


> +struct test_case test_cases[] = {

Added static.

Applied. Thanks.


