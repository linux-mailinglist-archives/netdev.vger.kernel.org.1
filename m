Return-Path: <netdev+bounces-205188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E6AFDBE5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62F35628AB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87DE236A79;
	Tue,  8 Jul 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUWylyJt"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C31990A7
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017993; cv=none; b=SHGr19XGdLeLA2YuqAtyCRmHIsDdtD5N2xQY3MhLnTY/gMH80OAAz2RJCrYhfb3tkLup04K3ItSrMAN9a54TpCIxTbyf7CUH/PfzbajPRlUQzqx4uOK7HSKEneOQsMY51pq7UOh1Fgo79+E9pyaVypEAikpBudYWXq/2xtABUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017993; c=relaxed/simple;
	bh=kPlcl0UL1/YHn8lVBNf78f8iM01u/eqDoYJib+acUWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odF9nH5JChmhhom9ewUytfus/iUhGCslQzJXtdorIi3vr/MwKJof76RPWLShwt4MY+Z8y0yPkTiHDxobuOU2AVrtDTV79bDHIfDEaSNuuk5xNOutkobzBjaIiB9zZyDIL26whcqGtezwiaLpuRU82X7oYNPn0EgrYs/y37A7Qts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUWylyJt; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca23af7b-28cf-4453-bd53-c0507b3b4e8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752017989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gzvTyswj6fAUCWbrWxlcdNwIKwGy7exrEHiNNMIq0c=;
	b=QUWylyJtlQrI6jhfv2y66UeWYfk3XGZ88eHBLLAfYamdRkXOW/8cVEFXoHIlXbeBJ6n1kM
	a+zpdPHvh70dHlYyAzcKF53cPaZ/YJ65tJAdUtkB4o1UnJKJqh2ft5hpXoGw+ujmYKNLJs
	GkqIdNMaPTV0bVzWkYg7olB2WVvCm8I=
Date: Tue, 8 Jul 2025 16:39:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy
 test program
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-12-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250707155102.672692-12-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/25 8:50 AM, Jordan Rife wrote:
> Prepare for bucket resume tests for established TCP sockets by creating
> a program to immediately destroy and remove sockets from the TCP ehash
> table, since close() is not deterministic.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   .../selftests/bpf/progs/sock_iter_batch.c     | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> index a36361e4a5de..14513aa77800 100644
> --- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> +++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
> @@ -70,6 +70,28 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
>   	return 0;
>   }
>   
> +int bpf_sock_destroy(struct sock_common *sk) __ksym;

A nit.

The kfunc declaration should be already in the vmlinux.h, so this line is no 
longer needed. The bpf CI has the new pahole for this.

> +volatile const __u64 destroy_cookie;
> +
> +SEC("iter/tcp")
> +int iter_tcp_destroy(struct bpf_iter__tcp *ctx)
> +{
> +	struct sock_common *sk_common = (struct sock_common *)ctx->sk_common;
> +	__u64 sock_cookie;
> +
> +	if (!sk_common)
> +		return 0;
> +
> +	sock_cookie = bpf_get_socket_cookie(sk_common);
> +	if (sock_cookie != destroy_cookie)
> +		return 0;
> +
> +	bpf_sock_destroy(sk_common);
> +	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
> +
> +	return 0;
> +}
> +
>   #define udp_sk(ptr) container_of(ptr, struct udp_sock, inet.sk)
>   
>   SEC("iter/udp")


