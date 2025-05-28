Return-Path: <netdev+bounces-193786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A0AC5E91
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09BC7B2BA2
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775A1531E3;
	Wed, 28 May 2025 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5ijp5Dr"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2D1F5FD
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393518; cv=none; b=KhsuB8AiRK8VC46RD4gXdV0QdQ8cp/sfCc07GuBdU46cfbKR0yf8mgBokpQ1DHedp0O3pme4skCGzNJ/j/4F8q/088GOWx0GY1qApmoxVi0MvccM9qytJfMSxcC9ZUnVv3MTp6KK4Llr9SSYJDGcvw1teWQpd9r3Pfea8Lc9eL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393518; c=relaxed/simple;
	bh=y1Qc0jlp3fdwyFuV0NrLUuBSYuWf0x9TB/LFDTST/hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIfKkg3VB4PNi0bt0I72lTpR8sbDgN8vBr31o6tuLDc5RagAh5Y2/9MGN8xAW+yWnK2M3sxbve7dHryTeE7yHGDKHQG8FBjDdI4vNAZ2uxOI72rHNtsv7la8N3SMJny+n0/kAkB0leHW1IxmiZpTMb2xb8yzMjSMDiDBRXytFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5ijp5Dr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae95a774-2218-4ddc-b2e0-d7bac2b731fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748393503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLTryZpTrEZX2okYPkBiKM780EpNO+m0WRb1dWRiQDw=;
	b=Y5ijp5Dr3Gg/95eVcckDjPIxuWR5SMaiZLb+vAGmRDzWth8akC17umLKRz+hdxWbRKzJ7s
	3yduGwBZzg3mHLJYpAj551Avq8d0HW0En3Ieb8rS+JMlpTJuqp6B1NltkSvpapD8SpyDm+
	bBtuuIotmzt38CdtAA/ozElE0EMeBRU=
Date: Tue, 27 May 2025 17:51:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 10/10] selftests/bpf: Add tests for bucket
 resume logic in established sockets
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250520145059.1773738-1-jordan@jrife.io>
 <20250520145059.1773738-11-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250520145059.1773738-11-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/20/25 7:50 AM, Jordan Rife wrote:
> +static bool close_and_wait(int fd, struct bpf_link *link)
> +{
> +	static const int us_per_ms = 1000;
> +	__u64 cookie = socket_cookie(fd);
> +	struct iter_out out;
> +	bool exists = true;
> +	int iter_fd, nread;
> +	int waits = 20; /* 2 seconds */
> +
> +	close(fd);
> +
> +	/* Wait for socket to disappear from the ehash table. */
> +	while (waits--) {
> +		iter_fd = bpf_iter_create(bpf_link__fd(link));
> +		if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
> +			return false;
> +
> +		/* Is it still there? */
> +		do {
> +			nread = read(iter_fd, &out, sizeof(out));
> +			if (!ASSERT_GE(nread, 0, "nread")) {
> +				close(iter_fd);
> +				return false;
> +			}
> +			exists = nread && cookie == out.cookie;
> +		} while (!exists && nread);
> +
> +		close(iter_fd);
> +
> +		if (!exists)
> +			break;
> +
> +		usleep(100 * us_per_ms);

Instead of retrying with the bpf_iter_tcp to confirm the sk is gone from the 
ehash table, I think the bpf_sock_destroy() can help here.

> +	}
> +
> +	return !exists;
> +}
> +
>   static int get_seen_count(int fd, struct sock_count counts[], int n)
>   {
>   	__u64 cookie = socket_cookie(fd);
> @@ -241,6 +279,43 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
>   			       counts_len);
>   }
>   
> +static void remove_seen_established(int family, int sock_type, const char *addr,
> +				    __u16 port, int *listen_socks,
> +				    int listen_socks_len, int *established_socks,
> +				    int established_socks_len,
> +				    struct sock_count *counts, int counts_len,
> +				    struct bpf_link *link, int iter_fd)
> +{
> +	int close_idx;
> +
> +	/* Iterate through all listening sockets. */
> +	read_n(iter_fd, listen_socks_len, counts, counts_len);
> +
> +	/* Make sure we saw all listening sockets exactly once. */
> +	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
> +			       counts, counts_len);
> +
> +	/* Leave one established socket. */
> +	read_n(iter_fd, established_socks_len - 1, counts, counts_len);

hmm... In the "SEC("iter/tcp") int iter_tcp_soreuse(...)" bpf prog, there is a 
"sk->sk_state != TCP_LISTEN" check and the established sk should have been 
skipped. Does it have an existing bug? I suspect it is missing a "()" around
"sk->sk_family == AF_INET6 ? !ipv6_addr_loopback(...) : ...".


