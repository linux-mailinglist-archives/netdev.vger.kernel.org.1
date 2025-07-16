Return-Path: <netdev+bounces-207517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1127B07A6D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523411894082
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECC2F3C2F;
	Wed, 16 Jul 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f359YEDD"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DC2F3C1D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681342; cv=none; b=DzDb8ebFdi+9O8tncEBUynNcDJDdYyX5CbjwBlzbrQz0j1vuoWAxSvvlF73iomsrZcT6zg/Sfj++AXi4vDW0vSUhHZeE0TiqnLLFlpLKW8mEYUDDuNHnhZU8WTCZ5lgeIUt3oZkxuve3k9fTXiWQ3qeMYshNFu3kTgzQ79Lsgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681342; c=relaxed/simple;
	bh=Gfq0RN8nx4eBZsOJksZpCTB/HLpQ7B1znLA6eT7xYdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtuS2rkmQcAAxrvAGDZIcOoQ/2PbAHgW8W5oRnlVbW1m/koUmiO7SIa5Ricc7FRrfc1Wlyt9T3s1LCFJHBJa4Af++Ngk6Jyqp9Y0y3X/zD2LWINZC3ex3FCjkV3Wsr92xLR4Hj2b/roF3FHPmTuKfwI6KVkhTPlLEh07Svyyitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f359YEDD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3300af59-741d-495a-b2bb-255989aa16c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752681336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiXIy7sVTXVx65SuyVLUmcYFjGQ7qw41XvKHBEyEtQI=;
	b=f359YEDDd/ckKl0IYjzVXc/zgMPG/MBuabLqs+IPF64+7Iqvf13vNUqL7r1AxW9dwUzITV
	VH5EtGTWAOj+VX14WHr82q0jExrPSKYnJa/NSw7fJfizRGdIQr1KZkM4lhjxwepLsDZ0qf
	UD/yi3ReoXC4kEYwvxJm3/XtF2n7JOA=
Date: Wed, 16 Jul 2025 08:55:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Subject: [RFC PATCH 0/1] bpf: Add helper to mark xdp_buff->data
 as PTR_TO_PACKET for tracing
Content-Language: en-GB
To: Vijay Nag <nagvijay@microsoft.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <KUZP153MB1371D7C7160643B3FC965E6CC456A@KUZP153MB1371.APCP153.PROD.OUTLOOK.COM>
 <KUZP153MB137161E2B4EC720F933B7F95C456A@KUZP153MB1371.APCP153.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <KUZP153MB137161E2B4EC720F933B7F95C456A@KUZP153MB1371.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/15/25 11:34 PM, Vijay Nag wrote:
> Hi BPF maintainers,
>
> This is an RFC to propose  new BPF helper that will enable tracing programs attached to XDP entry points, such as __xdp_dispatch, to safely parse packet headers using xdp_buff->data with native pointer semantics.
>
> Currently, the verifier treats xdp_buff->data and xdp_buff->data_end as generic PTR_TO_MEM. Consequently, even with proper bounds checks, attempts to access header fields using pointer arithmetic (e.g., eth+1) fail verification. This forces users to revert to bpf_probe_read_kernel() even when the packet data is safely readable in memory.
>
> ## Motivation
>
> There are several valid scenarios where tracing or instrumentation tools (e.g., xdpdump, latency profilers) need to inspect packet headers at XDP hook points without writing or maintaining full XDP programs. These scenarios include:
>
> - Conditional flow capture based on IP/TCP header fields
> - Per-packet metadata collection (e.g., timestamp, RSS queue, etc.)
> - Passive flow observation from fentry to existing XDP functions
>
> In these cases, users often write tracing programs that receive a struct xdp_buff * context and want to treat xdp->data as the start of the packet, similar to how XDP programs can with xdp_md->data.
>
> ## Proposal
>
> I propose introducing a new BPF helper:
>
> void *bpf_pkt_ptr_from_xdp_buff(struct xdp_buff *xdp);

You cannot introduce bpf helper any more. If really necessary, kfunc is the
only option now.

>
> This helper would:
>
> - Return xdp->data
> - Mark the pointer as PTR_TO_PACKET in verifier metadata
> - Allow safe pointer arithmetic and field access (e.g., eth+1, iph->saddr)
> - Maintain strict bounds checking via xdp->data_end
>
> This approach allows safe, verifier-friendly packet parsing logic in fentry/kprobe programs that work on struct xdp_buff *.
>
> ## Example Usage
>
> SEC("fentry/__xdp_dispatch")
> int BPF_PROG(trace_xdp_entry, struct xdp_buff *xdp)
> {
>      void *data = bpf_pkt_ptr_from_xdp_buff(xdp);
>      void *data_end = xdp->data_end;
>      struct ethhdr *eth = data;
>      if ((void *)(eth + 1) > data_end)
>          return 0;
>      if (eth->h_proto == bpf_htons(ETH_P_IP))
>          bpf_printk("Captured IPv4 packet\n");
>      return 0;
> }

In the above, do not use helper and direct use
   void *data = xdp->data;

With latest bpf-next, your code will succeed with
verification due to the following recent verifier change:
   https://lore.kernel.org/all/20250704230354.1323244-1-eddyz87@gmail.com/

Previously, 'data/data_end' will become a scalar after xdp->{data,data_end}.
But with the above patch set, 'data/data_end' will become
rdonly_untrusted_mem, which allows further dereference.

>
> ## Alternatives Considered
>
> - Using bpf_probe_read_kernel() for each header:
>    - Works, but incurs copy overhead
>    - Prevents natural packet pointer-based idioms
>    - Not ideal for frequent filtered tracing
>
> - Teaching the verifier to infer packet provenance on raw PTR_TO_MEM:
>    - Complex, error-prone, and hard to generalize
>
> ## Security Considerations
>
> - The helper is read-only and does not modify xdp_buff or data
> - The returned pointer would follow the same bounds logic as xdp_md->data
> - Maintains safety via verifier checks against data_end
> - Pattern is similar to existing helpers like bpf_xdp_load_bytes()
>
> ## Open Questions
>
> - Would this helper be preferred over modifying verifier logic?
> - Is this useful for skb- or tc_buff-based tracing too?
> - Should there be constraints on program type or attachment points?
>
> I am eagerly looking forward to your feedback. If the idea is acceptable, I would be happy to submit a working implementation and documentation update.
>
> Thanks,
> Vijay Nag
>
>


