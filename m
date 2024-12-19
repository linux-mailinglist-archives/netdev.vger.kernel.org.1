Return-Path: <netdev+bounces-153526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C449F8831
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 23:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B170B169908
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBE1D2B2A;
	Thu, 19 Dec 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pTHkA93C"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1B78F4A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649170; cv=none; b=ce05fm3I7Pws7s/Dmglv8q6MC6d7mBwmACaOPhuO6Dlj1jPR11CSLLFStuT8WUEUjmWCnOsiaO7hnUW1BJZWZwAWYU8ctdAPHDb7i4NSVp2OfDist8w90ohnC38g99laEl13xpb2kAOC/tR/0VEFZwl1Sv5YJaBPy5HqOp/nIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649170; c=relaxed/simple;
	bh=hlg8xwkylNI5eAv8KQzJt8kXxJW9Zb549XA7kLLl+i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfRczJkg2XUIavMZTcyqfqtRnVzHZ9rC9HjI5+GpH2SVE9dbPccThhzyL/41tRJIrDSXSPVG/Gi7c/4o/Kl+Qcqj/TgeGA3UHNt6Jd/aJKxFg2X1brjwPcD3/37xVjYXO0YxgK1T2nv1WxOu4mg0q2UAbmOgp/n/kY87gglBJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pTHkA93C; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3bf6bf6-5e81-4b6b-a9cd-40476cff67df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734649164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhXQOLtk7dKTmN52PYjr4l//xRRdGTGNVljbAp+LMuQ=;
	b=pTHkA93CLNr7gPLJS8+OkIAh4fP5+3TQ0a8bkD3WTAtQci6/BqQkCHjE69xFVEtEcRRqhD
	57YQiXJGXm9z29MWyLwektE+NnbKNsndiBzCOImSMyQSekGIdwQzgLm9rZPioo9IP/AiS2
	oikpjouDIbPjUilemOqugGqetV4nfPI=
Date: Thu, 19 Dec 2024 14:59:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/5] bpf/selftests: add selftest for
 bpf_smc_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-6-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241218024422.23423-6-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/17/24 6:44 PM, D. Wythe wrote:
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_tracing_net.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct smc_sock {

I suspect this should be "smc_sock___local". Otherwise, it can't compile if the 
same type is found in vmlinux.h.

I only looked at the high level of prog_tests/test_bpf_smc.c. A few comments,

Try to reuse the helpers in network_helpers.c and test_progs.c, e.g. netns 
creation helpers, start_server, ...etc. There are many examples in 
selftests/bpf/prog_tests using them.

I see 1s timeout everywhere. BPF CI could be slow some time. Please consider how 
reliable the multi-thread test is. If the test is too flaky, it will be put in 
the selftests/bpf/DENYLIST.

> +	struct sock sk;
> +	struct smc_sock *listen_smc;
> +	bool use_fallback;
> +} __attribute__((preserve_access_index));
> +


