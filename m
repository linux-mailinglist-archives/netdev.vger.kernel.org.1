Return-Path: <netdev+bounces-143416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382639C25AD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C0A1C235C3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074B1AA1EF;
	Fri,  8 Nov 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5j3Zhn2"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17121C1F11
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094809; cv=none; b=IRabBoYuy2LmPzmK/DvsVx8PSrN3sO4PoG8w+bmE1K053KEV/UuppeQV0krfMWkYUZI+HMmfrjJh1gLDA0dUYLwC9Gn9RC8m2f3HeemmioCYBfPkKb6ZK+KsrA1Dua20gRb5lcFZuAwXXSYS3elu1CfameU3YhjFHsEoRNNQt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094809; c=relaxed/simple;
	bh=U6GqppO5h30LzkbdesIwC7AVuSxiPTkWg2MOhbNuwJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMjthwz2wc7qx+sdkifF5qJfjC4zrj+0fFIgSM09PjHX8YY1xVZwD0vWVnWebE+75HWAD6WFJiuMl60AE1EtMlgHPFUMMWBraLN6yTLDI6e3/fsLTKyCCwclDirHzCJfv9rCtzjK3lw7eNR+NJ7HwduiJZ+aJUvEIEEggalrSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5j3Zhn2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60a50f93-5416-4ee5-b34a-a1a88652dc82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731094804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAOI2LPYL9wEomc5SXhn83DASh1XX2UxQA82nGz7zuI=;
	b=T5j3Zhn2LKVDAOXz12rPWhhyKCk4MYFsdXeZfbCbk0lSW6EDjLLBQnhVxoWjmAXjBHV0DN
	lflh7LW/zXlg/B8qj8Nmtzcmip0wLxRIaw+Mc6HBk8BsHDTX7Yy0X1eEKRu/8MJRPmrvmx
	afGdWAjNtKTsKZnuBCafI04FzSyYNNI=
Date: Fri, 8 Nov 2024 11:39:56 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for struct_ops map
 release
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
 <20241108082633.2338543-3-xukuohai@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241108082633.2338543-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/8/24 12:26 AM, Xu Kuohai wrote:
> -static void bpf_testmod_test_2(int a, int b)
> +static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
>   {
> +	WRITE_ONCE(__bpf_dummy_ops, &__bpf_testmod_ops);
>   }

[ ... ]

> +static int run_struct_ops(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +	unsigned int repeat;
> +	struct bpf_testmod_ops *ops;
> +
> +	ret = kstrtouint(val, 10, &repeat);
> +	if (ret)
> +		return ret;
> +
> +	if (repeat > 10000)
> +		return -ERANGE;
> +
> +	while (repeat-- > 0) {
> +		ops = READ_ONCE(__bpf_dummy_ops);

I don't think it is the usual bpf_struct_ops implementation which only uses 
READ_ONCE and WRITE_ONCE to protect the registered ops. tcp-cc uses a 
refcnt+rcu. It seems hid uses synchronize_srcu(). sched_ext seems to also use 
kthread_flush_work() to wait for all ops calling finished. Meaning I don't think 
the current bpf_struct_ops unreg implementation will run into this issue for 
sleepable ops.

The current synchronize_rcu_mult(call_rcu, call_rcu_tasks) is only needed for 
the tcp-cc because a tcp-cc's ops (which uses refcnt+rcu) can decrement its own 
refcnt. Looking back, this was a mistake (mine). A new tcp-cc ops should have 
been introduced instead to return a new tcp-cc-ops to be used.

> +		if (ops->test_1)
> +			ops->test_1();
> +		if (ops->test_2)
> +			ops->test_2(0, 0);
> +	}
> +
> +	return 0;
> +}

