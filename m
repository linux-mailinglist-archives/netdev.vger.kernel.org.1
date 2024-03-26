Return-Path: <netdev+bounces-82272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A688D051
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E3CB20ABD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775BA13D896;
	Tue, 26 Mar 2024 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKwhpSej"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45B13D617
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489911; cv=none; b=dzjgfL2oKzPtfzZlY+uDyZMWvph9AjTXoGD8k3vyh3zkCgSFGSsBEqUrLlhvJR9za+7SyAx/xrVEH2sgJMwdoQHXMzkaaACTL4R0b8hr6cUXg/IX7S38pr0Y+x3JU39AKnNbYK3KVgxbbRM7Kcz16vsBmrBnMptPmEesHK1/F0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489911; c=relaxed/simple;
	bh=vYxmHLyzfgtwnYesg1Ae5G7k1t36YsDNaDLGLfhJRh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkiswkK3MGoMqSgSYBO1Q5sUT7Z3OB1KiUEm7/5RexfroxrDj/Qe2yjvPmHDWZ/M/+ffB3e4DinYMvo/mb95WnA34Rx/KuMexoifA/J7xrtOyyhqyQsDeCwOQe7fVL6P1j9pWMMk4jQIxaEEWEFvgqTeRBQEeKmF2OsA7BLJzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKwhpSej; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e5e51fb-b36e-4dae-b4b4-32ab5e05f303@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711489907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k2u73YWr6uRihPOmodZIT3QRs4S+EKNrKvoI6HO22U=;
	b=fKwhpSejIsW52GDmecKgU36vV9Xc94+/+ArHT2XYaxqBncCKZ+kme8eC3gqJeF8HkPsSjs
	lp/3k2V6manen8+N3oG/in6Bj7SRYg1RPkd713zSHrL9SjgnT1su/E1PLXkdnzfoapo8Kq
	hnJKj61yiQRk2FLL72+o3L3KjLqmNJc=
Date: Tue, 26 Mar 2024 14:51:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/3] selftests/bpf: Add BPF_FIB_LOOKUP_MARK
 tests
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
 Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240326101742.17421-1-aspsk@isovalent.com>
 <20240326101742.17421-3-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240326101742.17421-3-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/24 3:17 AM, Anton Protopopov wrote:
> +	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
> +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV4_GW1,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },

[ ... ]

> +	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
> +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> +	  .expected_dst = IPV6_GW1,
> +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> +	  .mark = MARK, },
>   };

[ ... ]

> @@ -159,6 +221,9 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
>   	params->ifindex = ifindex;
>   	params->tbid = test->tbid;
>   
> +	if (test->lookup_flags & BPF_FIB_LOOKUP_MARK)

Removed this "& BPF_FIB_LOOKUP_MARK" test. Always set the params->mark 
regardless of test->lookup_flags. This should be the intention of the above "... 
mark points to a policy, but no flag" tests.

Applied. Thanks.

> +		params->mark = test->mark;
> +


