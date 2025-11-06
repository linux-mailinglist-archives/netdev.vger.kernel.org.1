Return-Path: <netdev+bounces-236116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F75C38A1F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22D21A277A9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858211DF751;
	Thu,  6 Nov 2025 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukGoIO9s"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6713D521
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390682; cv=none; b=O3pqTSTBvgJ617RhSyXye6PT8DPQZ9RyqSctX4DbGnqDe2lTNRUHA9qYODWaRlt6qPdYjVXZ2MNqGKZQWDByWPFPUhP6HxLBFx/GrOPhNS3fPLuspPeNVXdhhpLjrMj9UbIPxii18ET8Ofu4FzFN8AmJvvSlMJj1M16MHNjv1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390682; c=relaxed/simple;
	bh=H3QB6kjLBSpceMpK4HiAOOF0i90i/Arc7vId4svXPK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCWpFnklWnhqKh8DlwEsfvGBMqvqKoUZJMTjsv5smCUzzT6yvL1BirCQesHuIpMtXU86DOdKUFaUPmUou0yduNiPpyL8b8KkI5nYr798VuawsTPpSy5T6PfD4k459C0s/E4QmqEh9FNT7olNRxYP6f+3LcfpOFdfN489o6CwKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukGoIO9s; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d44b770-6fca-4b8d-a650-2680a977d2b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762390669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/O3/eOJofXFxWDMFHzK/GYzfCaJ87kThBhBxV9N39s=;
	b=ukGoIO9sLdtdFTrfJXV2Lqh+bwb2RgRlXw6lt+tNnvOe97mWJ2C+IZpr0J46a71oM0zSkr
	yLioZDtdW6m3pt8PM2277c2XTxeUzsO+e2AmZrpki6u15goWtjsKubLdEPNAZuUxZyhboT
	xpjmS7ROKRpYoW4jC/gLqcpKQWAjX04=
Date: Wed, 5 Nov 2025 16:57:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with
 struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251104172652.1746988-1-ameryhung@gmail.com>
 <20251104172652.1746988-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251104172652.1746988-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/4/25 9:26 AM, Amery Hung wrote:
> +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
> +{
> +	struct bpf_map *st_ops_assoc = READ_ONCE(aux->st_ops_assoc);
> +	struct bpf_struct_ops_map *st_map;
> +
> +	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
> +		return NULL;
> +
> +	st_map = (struct bpf_struct_ops_map *)st_ops_assoc;
> +
> +	if (smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_INIT) {
> +		bpf_map_put(st_ops_assoc);

hmm... why bpf_map_put is needed?

Should the state be checked only once during assoc time instead of 
checking it every time bpf_prog_get_assoc_struct_ops is called?

> +		return NULL;
> +	}
> +
> +	return &st_map->kvalue.data;
> +}


