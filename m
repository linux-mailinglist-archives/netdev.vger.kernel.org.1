Return-Path: <netdev+bounces-239253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77DC664AD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3AE4E038D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE730ACF4;
	Mon, 17 Nov 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qcg86rnt"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D52D7DC7
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415605; cv=none; b=uOBZ3/bojOhRELhrRFyhIwljxKxb794CySdCl1oc0cm7Udlh1gJi0m31krGgX7dwB0Yuq5P3rv4T7FwEWLWhrJs0irHNrkk6Tt+MTdM/NqkCYnNRcAy2SeP+ytwChnujV9vAMQP9G3VluBI4UPWWHIXEvL1RYeT/8s00cvl8B4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415605; c=relaxed/simple;
	bh=6vnEE9ump1OA/j67GsUhl/mp3FIXpsw3Aw0nK/AW9OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvbyR8+ouZ3iY/uSiGvTOEKydipArv4+G/PNaAn0W//yO6fEUMCkHA9THFioPtUFCqH2YgKpg4MxPV4Q9HnULmrVaiB4QtEkS36S8HaNgEfzwbcY5+Kmveg012zh9rMJv09hRZIIlXu+PH4aUxzKD/neFL6soWyG4QMrS1eqEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qcg86rnt; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c891d752-33cc-413d-8311-dcf8afbf339d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763415598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3psy+YMGd649VQ8h9SgRyQqGiP9VgpHxVPEjHcJMhgk=;
	b=Qcg86rntG8F+eD2cBwMrRokeWNQoE9MJiverjUZdcdVzmYdVv82HCRSktyGrpF52lSABh8
	VsZvQrzINkYiUMpcU+1ddS0I/m+6OPJ8BuQJ+aOPEF0u9tNDbhqFCKB4xOVtwNnSuZ/Jvo
	9ExOLsMIGF640CGHxi7QMy1jpAyI3yg=
Date: Mon, 17 Nov 2025 13:39:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Support associating BPF program with
 struct_ops
To: ameryhung@gmail.com
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, bot+bpf-ci@kernel.org
References: <20251114221741.317631-3-ameryhung@gmail.com>
 <16d43cdc90504cad5143df62b3d40f325a271aeca0adc521c6fef711023f90ef@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <16d43cdc90504cad5143df62b3d40f325a271aeca0adc521c6fef711023f90ef@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/14/25 2:51 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index a41e6730e..626aa9197 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
> 
> [ ... ]
> 
>> @@ -811,6 +822,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>>   		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
>>   			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
>>   		*plink++ = &link->link;
>> +
>> +		err = bpf_prog_assoc_struct_ops(prog, &st_map->map);
>> +		if (err) {
>> +			bpf_prog_put(prog);
>> +			goto reset_unlock;
>> +		}
> 
> Can this double-put the prog reference? In bpf_struct_ops_map_update_elem:
> 
>    prog = bpf_prog_get(prog_fd);              // refcnt = 1
>    bpf_link_init(..., prog, ...);             // link takes ownership
>    *plink++ = &link->link;                    // link stored in st_map
>    err = bpf_prog_assoc_struct_ops(prog, ...);
>    if (err) {
>      bpf_prog_put(prog);                      // refcnt = 0, prog freed
>      goto reset_unlock;
>    }
> 
> Then at reset_unlock:
> 
>    bpf_struct_ops_map_put_progs(st_map);      // calls bpf_link_put(link)
> 
> The bpf_link_put will eventually call bpf_link_dealloc()->bpf_prog_put(link->prog),
> attempting to put the already-freed prog reference. This looks like a use-after-free
> if bpf_prog_assoc_struct_ops fails (which can happen when a non-struct_ops program
> is already associated and returns -EBUSY).

The ai-review should be correct in general on the double bpf_prog_put.

> 
> Should the error path skip the bpf_prog_put and let bpf_struct_ops_map_put_progs
> handle the cleanup via the link?

bpf_prog_assoc_struct_ops will never return error for 
BPF_PROG_TYPE_STRUCT_OPS. If that is the case, maybe completely remove 
the err check.


