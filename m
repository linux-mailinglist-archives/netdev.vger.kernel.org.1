Return-Path: <netdev+bounces-236146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C89C38D84
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32432188B3BC
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D81CAA6C;
	Thu,  6 Nov 2025 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VNAKcMxG"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0629A1
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395473; cv=none; b=tb8tGyjBh/uI0odMS3dxrL5tMQThGvwsM4pT7lK36fA3OdnNhhIioEQ7qTCYR//8iaeubDM5oFuGjqa9B3NpOVPfS3Ya9yOrBtW4+Kbku8L+kfu3769vtxUb56jjF2ZD3hVIQo2W896rxvc6pd3+sg3urnNk29qmlpqPidPo4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395473; c=relaxed/simple;
	bh=FCgKQ56mjn5dTIHZPT8pNgwH5Em4CSqunkdpm0PLda4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYEuH+tFXGUzGPlUcyvVBEzI9EPohVzrLr/Bn+/LwK7lYIbEygyWBapKiKX/q+sUvgR3Hr0J2KfZjo3LkNgPXVGFjr80MN9k8zQuXpZIOW+qU63OZxRFDljT//wQUlArC8uDxga6qRTT7/foIcIGrCJVAJH3nI5diIqlIOV8XQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VNAKcMxG; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24956178-c806-4bf1-8442-73ceda725b8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762395469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIUCjU75fFXHLmA9m2LCnW9ToYG068qlHCH3j6DpAz0=;
	b=VNAKcMxG3+HSx77TEywwRmzGjtGAnAVAphnLlA/CH0y7q/w92ZgUh3ehsA2z0q3uquoqKk
	7VnTJnuaBqTbEShG3o+LODbhGaJBDTC99qpZSx1h7mA/pfKG2r7MumooQXyaDH2SFmd7+E
	Cau6aad1chCgRNML6snXaSuYTEZtts0=
Date: Wed, 5 Nov 2025 18:17:44 -0800
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
 <3d44b770-6fca-4b8d-a650-2680a977d2b7@linux.dev>
 <CAMB2axP7z6xWs_YuLDEKi1ciz0QE9b507nDf5FcydNjWq8MogA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axP7z6xWs_YuLDEKi1ciz0QE9b507nDf5FcydNjWq8MogA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/5/25 5:01 PM, Amery Hung wrote:
> On Wed, Nov 5, 2025 at 4:57 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>>
>>
>> On 11/4/25 9:26 AM, Amery Hung wrote:
>>> +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
>>> +{
>>> +     struct bpf_map *st_ops_assoc = READ_ONCE(aux->st_ops_assoc);
>>> +     struct bpf_struct_ops_map *st_map;
>>> +
>>> +     if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
>>> +             return NULL;
>>> +
>>> +     st_map = (struct bpf_struct_ops_map *)st_ops_assoc;
>>> +
>>> +     if (smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_INIT) {
>>> +             bpf_map_put(st_ops_assoc);
>>
>> hmm... why bpf_map_put is needed?
>>
> 
> AI also caught this. This is not needed. I overlooked it when changing
> from v4, where bpf_prog_get_assoc_struct_ops() used to first bump the
> refcount.

ah. My bad for the noise. Fixed my mail client. Somehow only that one 
email got filtered.

> 
>> Should the state be checked only once during assoc time instead of
>> checking it every time bpf_prog_get_assoc_struct_ops is called?
>>
>>> +             return NULL;
>>> +     }
>>> +
>>> +     return &st_map->kvalue.data;
>>> +}
>>


