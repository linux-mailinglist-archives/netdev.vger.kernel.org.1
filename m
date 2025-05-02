Return-Path: <netdev+bounces-187518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF654AA7A35
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 21:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FD53A45BD
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73AD1EEA4B;
	Fri,  2 May 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="as9CrXay"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF1185B73
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214059; cv=none; b=VIMn6BWOwnNnJf1EMRE74M57HyR0YMNRnSddHGwasB18ud+L1ECaoxJelfYJ6btqCP7pmn/0boi8zsLHsVPQf5/+irA55Bxp83CEGPKjVhKAm5IktS2Cx0jmEPStSTB1MwZ8mDLf/fHll1kyycumDMGS8/eDHzsKLMWeZ15PEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214059; c=relaxed/simple;
	bh=m5FsUSrgqJnJFyAJzio3wLwFf348gmKj5VWnE5R+NNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuJTclmix9KT9VM3crsskTjicdoGyKEycmtY4okZzTHLqF26+qYhY6hEB1t+NN6BpevdUjiInTCl6XLrQ/eU8EMjuglXrSkeZzEaNhfGGV/J84ZYoWR7wk5pPv2ZvCykFDd2lPBnLZkM9Mn9awdL5ZfqxFQO5UuUOtfm8X3ufPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=as9CrXay; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ec91dcac-d2d0-4705-aca1-8cdc1954aa11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746214045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU9YI+kwmmrvaRkJDXEgoYcoQAkayKzj4/4m5F6kUMI=;
	b=as9CrXayscBUB5dUnza31hDRWYt6QiLEeCKvmo16By9vRl+wWh4E4XV2WH+8TXPXCtwosT
	Cx931JbpQ40nIgU4TUq9sZ5MIcYCHPPVMMb9PePGz0knBC3gdyG3bZBNDqmEUhHecTGucA
	xUB0G4SwxlotLJvrzcNF5o0+zSbqTQo=
Date: Fri, 2 May 2025 12:27:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v1 2/5] selftests/bpf: Test setting and
 creating bpf qdisc as default qdisc
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250501223025.569020-1-ameryhung@gmail.com>
 <20250501223025.569020-3-ameryhung@gmail.com>
 <83c8f387-c4a9-4293-9996-fec285d34c94@linux.dev>
 <CAMB2axO2Jkc4Ec051+BYhju2Vr_GwzZL6yhHGuohMdg2q6WLRQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axO2Jkc4Ec051+BYhju2Vr_GwzZL6yhHGuohMdg2q6WLRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/2/25 10:52 AM, Amery Hung wrote:
>>> +static void test_default_qdisc_attach_to_mq(void)
>>> +{
>>> +     struct bpf_qdisc_fifo *fifo_skel;
>>> +     char default_qdisc[IFNAMSIZ];
>>> +     struct netns_obj *netns;
>>> +     char tc_qdisc_show[64];
>>> +     struct bpf_link *link;
>>> +     char *str_ret;
>>> +     FILE *tc;
>>> +     int err;
>>> +
>>> +     fifo_skel = bpf_qdisc_fifo__open_and_load();
>>> +     if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
>>> +             return;
>>> +
>>> +     link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
>>
>>          fifo_skel->links.fifo = bpf_map__attach_struct_ops(....);
>>
>> Then no need to bpf_link__destroy(link). bpf_qdisc_fifo__destroy() should do.
>>
> 
> I see. I assume it will also be okay to set autoattach and call
> bpf_qdisc_fifo__attach()?

Good point. bpf_qdisc_fifo__attach() will be even simpler. I thought the 
autoattach is true by default. Please check.


