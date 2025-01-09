Return-Path: <netdev+bounces-156894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC6A08397
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F56A188B8B4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B676205E31;
	Thu,  9 Jan 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I0rjcB3B"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41131FBEB5
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465836; cv=none; b=OuC6wOA52c+Jwk691wYQ52tKvS+AomJ5a7IKjr1uAaJUiPJJl4CBh6WEFCrFM051wWEv1EMdqY8byhzVneOuIbok5ZsC1ebx0a/kdtz0yWMhGb6XR/LFDDjPDkiJDr1C+P3Vx7amSSqHaJQTW+I4xCT1En/XYW+1Zb075Wnaj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465836; c=relaxed/simple;
	bh=QvZh8+uwOygqGUsQfDl0XhOQqjMItbMziEWN5dg6bTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quUXlYqiluDqldY4sgAKseQRqhjdfljla3IKrWebKyS2M2S6o/baCXDd36jSYqmO/6Dtm4Z0z5D4O3huG0znnnE/uRTAMIaMADE51T2y5t52Ip7IM/zgcUiUE88KaAOYOz755M/V+3+7SP/JPX3ZIdmFBYIseM1AsI8eEcZl1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I0rjcB3B; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17f37206-942a-4db4-99c2-a43412a08d33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736465831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iahp7MQcHeHM9uYQmXpPSBAMNaWbgTcbfIopaPB2/Jc=;
	b=I0rjcB3B7Bt5MCJkDst3G1agPTy58b1IQSjBQjJ3PtZAzi8fpqyGb4x+I947RUR+xB8gNo
	XavMgLkhjc7TneKNM4/NPBKlVT9a1Nq5nLNOef8/wATz6qpcPFGKLmCGIAodaL1q17DSVi
	66cdhIBNjIHUgwuhrfSYhK69LI+PLAk=
Date: Thu, 9 Jan 2025 15:36:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 14/14] selftests: Add a bpf fq qdisc to
 selftest
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 amery.hung@bytedance.com
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-15-amery.hung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241220195619.2022866-15-amery.hung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 11:55 AM, Amery Hung wrote:
> +static int fq_new_flow(void *flow_map, struct fq_stashed_flow **sflow, u64 hash)
> +{
> +	struct fq_stashed_flow tmp = {};
> +	struct fq_flow_node *flow;
> +	int ret;
> +
> +	flow = bpf_obj_new(typeof(*flow));
> +	if (!flow)
> +		return -ENOMEM;
> +
> +	flow->credit = q.initial_quantum,
> +	flow->qlen = 0,
> +	flow->age = 1,
> +	flow->time_next_packet = 0,
> +
> +	ret = bpf_map_update_elem(flow_map, &hash, &tmp, 0);
> +	if (ret == -ENOMEM) {

-E2BIG needs to be checked also to handle the flow_map is full case.

> +		fq_gc();
> +		bpf_map_update_elem(&fq_nonprio_flows, &hash, &tmp, 0);
> +	}
> +
> +	*sflow = bpf_map_lookup_elem(flow_map, &hash);
> +	if (!*sflow) {
> +		bpf_obj_drop(flow);
> +		return -ENOMEM;
> +	}
> +
> +	bpf_kptr_xchg_back(&(*sflow)->flow, flow);
> +	return 0;
> +}

[ ... ]

> +static int
> +fq_remove_flows(struct bpf_map *flow_map, u64 *hash,
> +		struct fq_stashed_flow *sflow, struct remove_flows_ctx *ctx)
> +{
> +	struct fq_flow_node *flow = NULL;
> +
> +	flow = bpf_kptr_xchg(&sflow->flow, flow);
> +	if (flow) {
> +		if (!ctx->gc_only || fq_gc_candidate(flow)) {
> +			bpf_obj_drop(flow);

afaik, the hash value (i.e. sflow here) is still in the flow_map.

Instead of xchg and then drop, I think this should be 
bpf_map_delete_elem(flow_map, hash) which deletes the sflow value from the 
flow_map and also takes care of the bpf_obj_drop() also.

> +			ctx->reset_cnt++;
> +		} else {
> +			bpf_kptr_xchg_back(&sflow->flow, flow);
> +		}
> +	}
> +
> +	return ctx->reset_cnt < ctx->reset_max ? 0 : 1;
> +}
> +
> +static void fq_gc(void)
> +{
> +	struct remove_flows_ctx cb_ctx = {
> +		.gc_only = true,
> +		.reset_cnt = 0,
> +		.reset_max = FQ_GC_MAX,
> +	};
> +
> +	bpf_for_each_map_elem(&fq_nonprio_flows, fq_remove_flows, &cb_ctx, 0);
> +}
> +
> +SEC("struct_ops/bpf_fq_reset")
> +void BPF_PROG(bpf_fq_reset, struct Qdisc *sch)
> +{
> +	struct unset_throttled_flows_ctx utf_ctx = {
> +		.unset_all = true,
> +	};
> +	struct remove_flows_ctx rf_ctx = {
> +		.gc_only = false,
> +		.reset_cnt = 0,
> +		.reset_max = NUM_QUEUE,
> +	};
> +	struct fq_stashed_flow *sflow;
> +	u64 hash = 0;
> +
> +	sch->q.qlen = 0;
> +	sch->qstats.backlog = 0;
> +
> +	bpf_for_each_map_elem(&fq_nonprio_flows, fq_remove_flows, &rf_ctx, 0);
> +
> +	rf_ctx.reset_cnt = 0;
> +	bpf_for_each_map_elem(&fq_prio_flows, fq_remove_flows, &rf_ctx, 0);
> +	fq_new_flow(&fq_prio_flows, &sflow, hash);
> +
> +	bpf_loop(NUM_QUEUE, fq_remove_flows_in_list, NULL, 0);
> +	q.new_flow_cnt = 0;
> +	q.old_flow_cnt = 0;
> +
> +	bpf_loop(NUM_QUEUE, fq_unset_throttled_flows, &utf_ctx, 0);
> +
> +	return;
> +}

