Return-Path: <netdev+bounces-65707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFFB83B687
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6DE282562
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D497E1;
	Thu, 25 Jan 2024 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yzh7DPss"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52256FAD
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145995; cv=none; b=RQZr7V+svKQ+YK88fEna3bOVWNK0EYPxsqKgUfjHLHvDBBS0QsxxX2kFVZD3knL8g7GCInSBtIFbZKNFYwzV/hEsGpglxFM2BoWViyihMiATkLY9q1OgjSuMp83d30dnspOJ49ZImTOAgiDO0U4anV6oOxyh+D2DILfWtRizKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145995; c=relaxed/simple;
	bh=/bG04frI+8AEtX1UkmXUckcVaY83ebVSVcY77KIMgF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx9Ye8sL6u+2BOpzoai5Kjf4lANdAB0BqS51Ls8ax+1uILdfV0Eg8Ij01s0dpCemlRGD+eGHQh+KbIEU+sFUhZZ6wXQJj+uRwQoFzwgb/KVr9lvUw0EtJPI57dCoIgLKqv0ZtpRvyLp6Nu7PeiCJ4Dbdw5bNh0wx9IbRM1B9DFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yzh7DPss; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca2ca170-b76c-4fc3-aa44-cae4a1e25aa4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706145991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALoEZM9RVE/tOlWK9AF2LXEypS3Bld3Rxux5elBLvf8=;
	b=Yzh7DPss9iVKI7RV511dKJG2UWex+qR0YNUkFdNKTW6lvW9w+8xGoCD3U7bRfq+3aklkgl
	VQRDF4Hl/dgEekNxkIbCM5CM41FImyn14RD/mHrrcFOgsESJ58Wa+KJYjNY7rzAvOTtQXX
	SIIPQT1meee/i7A/TlSCgOqebv7N63g=
Date: Wed, 24 Jan 2024 17:26:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/3] selftests: bpf: crypto skcipher algo
 selftests
Content-Language: en-US
To: Vadim Fedorenko <vadfed@meta.com>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Victor Stewart <v@nametag.social>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20240115220803.1973440-1-vadfed@meta.com>
 <20240115220803.1973440-3-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240115220803.1973440-3-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/24 2:08 PM, Vadim Fedorenko wrote:
> +static void deinit_afalg(void)
> +{
> +	if (tfmfd)

The test should be (tfmfd != -1) ?

> +		close(tfmfd);
> +	if (opfd)

Same here.

> +		close(opfd);
> +}

[ ... ]

> +SEC("?fentry.s/bpf_fentry_test1")
> +__failure __msg("Unreleased reference")

The error message is not checked. Take a look at how other tests use RUN_TESTS.

> +int BPF_PROG(crypto_acquire)
> +{
> +	struct bpf_crypto_ctx *cctx;
> +	struct bpf_dynptr key = {};
> +	int err = 0;
> +
> +	status = 0;
> +
> +	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
> +	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
> +
> +	if (!cctx) {
> +		status = err;
> +		return 0;
> +	}
> +
> +	cctx = bpf_crypto_ctx_acquire(cctx);
> +	if (!cctx)
> +		return -EINVAL;
> +
> +	bpf_crypto_ctx_release(cctx);
> +
> +	return 0;
> +}
> +
> +SEC("tc")
> +int decrypt_sanity(struct __sk_buff *skb)
> +{
> +	struct __crypto_ctx_value *v;
> +	struct bpf_crypto_ctx *ctx;
> +	struct bpf_dynptr psrc, pdst, iv;
> +	int err;
> +
> +	err = skb_dynptr_validate(skb, &psrc);
> +	if (err < 0) {
> +		status = err;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	v = crypto_ctx_value_lookup();
> +	if (!v) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ctx = v->ctx;
> +	if (!ctx) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
> +	/* iv dynptr has to be initialized with 0 size, but proper memory region
> +	 * has to be provided anyway
> +	 */
> +	bpf_dynptr_from_mem(dst, 0, 0, &iv);

It would be nice to allow passing NULL as an optional "iv" arg. It could be a 
future improvement.

Overall lgtm. Please add a cover letter in v4 and also the benchmark test that 
was brought up a while back.

> +
> +	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
> +
> +	return TC_ACT_SHOT;
> +}
> +
> +SEC("tc")
> +int encrypt_sanity(struct __sk_buff *skb)
> +{
> +	struct __crypto_ctx_value *v;
> +	struct bpf_crypto_ctx *ctx;
> +	struct bpf_dynptr psrc, pdst, iv;
> +	int err;
> +
> +	status = 0;
> +
> +	err = skb_dynptr_validate(skb, &psrc);
> +	if (err < 0) {
> +		status = err;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	v = crypto_ctx_value_lookup();
> +	if (!v) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ctx = v->ctx;
> +	if (!ctx) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
> +	/* iv dynptr has to be initialized with 0 size, but proper memory region
> +	 * has to be provided anyway
> +	 */
> +	bpf_dynptr_from_mem(dst, 0, 0, &iv);
> +
> +	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
> +
> +	return TC_ACT_SHOT;
> +}
> +
> +char __license[] SEC("license") = "GPL";


