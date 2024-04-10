Return-Path: <netdev+bounces-86782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED68A0400
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1DE1F21A92
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515A376FE;
	Wed, 10 Apr 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Va+Qlm+5"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDA29CFE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791571; cv=none; b=rd9Msflfl4urvLtEM4+69vFlwOBHNVDAEWmr50xl3IcMrA4WsoL6IVg3wSzVDOF4yCdeZnFsPo69X9QPmbD6fK7z9uCfEdKxU9d4hBOwfwCegfMSjEmeITOWa+udq6DwU4v/sTo61/LE8fwcEq9dqu3II8kpzdbh29yXhh0KwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791571; c=relaxed/simple;
	bh=6bECfZivveGXwjc0wz2UlMqxN5Fu6aMgKDLIjMEVkeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkmOBEk1BwB+/8BkTbarUHA3mlwnwvuMOcgp/P+V84s6o9HvGFPiocfHvUmfh+7VptCcAkzt2nQw1CvBNLDLW63IQ0YgiAKSebX+uCc2MvkdGTb4in5IyMXz22RljslkaByEOAA4M+XkH5MGmyuU26dnaHBR6r1OWb1FduCqMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Va+Qlm+5; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fcdf6dc6-81ff-48b8-822b-80c097efc07d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712791564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRA6/DFmK/DJmNTAFNW2xE1W38sOhbq7XMudIRt8ihs=;
	b=Va+Qlm+515KjcFBzYljKyDI9a7OtxhslpQ7SCXUQrXWPNmJ2MeRhfsO4Y1YG9QWHJwkl5T
	YjvrFFXb5n5JQj/wScwLuRr7vpe9OqGLs2TdrTzYZkxU5LECaqHEzoNuOqXIbjBjKdLFav
	DnKEyl/TQyRlVIkVNoRbmSsz9FOINjM=
Date: Wed, 10 Apr 2024 16:25:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v1 3/3] net: Add additional bit to support
 userspace timestamp type
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-4-quic_abchauha@quicinc.com>
 <6616b3587520_2a98a5294db@willemb.c.googlers.com.notmuch>
 <f28de1e7-4a9b-4a97-b4f9-723425725b58@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <f28de1e7-4a9b-4a97-b4f9-723425725b58@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/10/24 1:25 PM, Abhishek Chauhan (ABC) wrote:
>>> @@ -830,6 +833,9 @@ enum skb_tstamp_type {
>>>    *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>>    *		skb->tstamp has the (rcv) timestamp at ingress and
>>>    *		delivery_time at egress.
>>> + *		delivery_time in mono clock base (i.e., EDT) or a clock base chosen
>>> + *		by SO_TXTIME. If zero, skb->tstamp has the (rcv) timestamp at
>>> + *		ingress.
>>>    *	@napi_id: id of the NAPI struct this skb came from
>>>    *	@sender_cpu: (aka @napi_id) source CPU in XPS
>>>    *	@alloc_cpu: CPU which did the skb allocation.
>>> @@ -960,7 +966,7 @@ struct sk_buff {
>>>   	/* private: */
>>>   	__u8			__mono_tc_offset[0];
>>>   	/* public: */
>>> -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>>> +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>>>   #ifdef CONFIG_NET_XGRESS
>>>   	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */

The above "tstamp_type:2" change shifted the tc_at_ingress bit.
TC_AT_INGRESS_MASK needs to be adjusted.

>>>   	__u8			tc_skip_classify:1;
>>
>> With pahole, does this have an effect on sk_buff layout?
>>
> I think it does and it also impacts BPF testing. Hence in my cover letter i have mentioned that these
> changes will impact BPF. My level of expertise is very limited to BPF hence the reason for RFC.
> That being said i am actually trying to understand/learn BPF instructions to know things better.
> I think we need to also change the offset SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK
> 
> 
> #ifdef __BIG_ENDIAN_BITFIELD
> #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7) //Suspecting changes here too
> #define TC_AT_INGRESS_MASK		(1 << 6) // and here
> #else
> #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> #define TC_AT_INGRESS_MASK		(1 << 1) (this might have to change to 1<<2 )

This should be (1 << 2) now. Similar adjustment for the big endian.

> #endif
> #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
> 
> Also i suspect i change in /selftests/bpf/prog_tests/ctx_rewrite.c

ctx_rewrite.c tests the bpf ctx rewrite code. In this particular case, it tests
the bpf_convert_tstamp_read() and bpf_convert_tstamp_write() generate the
correct bpf instructions.
e.g. "w11 &= 3;" is testing the following in bpf_convert_tstamp_read():
		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
	 				TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);

The existing "TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK" is 0x3
and it should become 0x5 if my hand counts correctly.

The patch set cannot be applied to the bpf-next:
https://patchwork.kernel.org/project/netdevbpf/patch/20240409210547.3815806-4-quic_abchauha@quicinc.com/
, so bpf CI cannot run to reproduce the issue.


