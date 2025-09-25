Return-Path: <netdev+bounces-226130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77000B9CD2E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FC816329E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06B610D;
	Thu, 25 Sep 2025 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjKwCQPt"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF67524F
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759023; cv=none; b=OEyY9nQzbMZAMQfnmsK9bSPNn5YtNC+SG9WraMoVA4y+g62jOPnIBk4QQ2y4hQ0yCxCNOplgy5li89G4vTmkwnvSCQ0yl9amYtteVnkmsEtHi8BwFwv5MKLb1hW6RcugARQoCqRrAQKgv3tVPLQt3nht34yBXb3uALD6B0AIoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759023; c=relaxed/simple;
	bh=YgaEvb15XATMWEWb8eFnC4+mYJrUt6v4HCkUTqs3tI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8MwQ7cr7k9oDR7ppWb37Bvuq95wa9Xpha0r2aPrZqFQr0DQg5iv11dBE8NA+pxwlMt7ojMjuuhDVRTZzwbuRfuQHbQKpKGpvn+dzJPLL5oWK/JUZzRqawr8FwzF9UL92e4/GQsnzAVVv8796gYQ4QrcPDlAhsm65S2IbYC6XVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjKwCQPt; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35282ea2-7ccb-450a-aa78-491f2e84cbf3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758759006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJdDPbXNYlA68LqQTvJeCr8VzpFVGdGvQUcuCZnkd1s=;
	b=wjKwCQPtWTBxhzv7Fct/aG+wbdTmCxS+FOU/Mal75njJ4Udg+RB5uv6O57m/xPemepmwpZ
	tvDqZqedwDHnyQMzhWkPE+ZvhOZcr9dqr0v6Ea7W1MFkW2Lfk0AesFvel1NebLJ91iIIuD
	F3UihIZxxwz9SFeQxI+x40A0pdL6y2s=
Date: Wed, 24 Sep 2025 17:09:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: pull-request: bpf-next 2025-09-23
To: Jakub Kicinski <kuba@kernel.org>, Amery Hung <ameryhung@gmail.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250924050303.2466356-1-martin.lau@linux.dev>
 <20250924151831.66c38c74@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250924151831.66c38c74@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/24/25 3:18 PM, Jakub Kicinski wrote:
> 74: (15) if r1 == 0x20 goto pc+309 384: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=32 R2=0xfffffeff R3=scalar(smin=0xffffffff80000000,smax=0x7fffffff) R4=16 R5=1 R6=2 R7=ctx() R8=pkt(off=34,r=42) R9=scalar() R10=fp0 fp-336=mmmmmmmm
> ; switch (*val) { @ xdp_native.bpf.c:594
> 384: (b7) r4 = 32                     ; frame1: R4_w=32
> 385: (05) goto pc+1
> 387: (7b) *(u64 *)(r10 -352) = r5     ; frame1: R5=1 R10=fp0 fp-352_w=1
> 388: (1f) r8 -= r9

The "hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);" calculation 
needs to reload the ctx->data after filter_udphdr(). Amery will send a fix.

