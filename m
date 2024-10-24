Return-Path: <netdev+bounces-138868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B89AF418
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440642863F1
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677A216A2B;
	Thu, 24 Oct 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HEUtSm5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXckzagp"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A032010FA
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803159; cv=none; b=cfJXyEEJw1tDnVFL8e/1FJIZHtHJfhl1+FMcqxFYKqHuVHl0kOCnz3K0VT0yIw98lPEEgDmNaxIjjYaZBISM4ai/+y082yr6ZjrN8NI6dIdDJBc33lY7xSlfaGzda+DTp7uIgoqHWSbMRwLS2CAAV7zAa19AI85ImoglezGT79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803159; c=relaxed/simple;
	bh=nKIaKjicHh5rCYKnuAK53u16avKUwGAhk2M6RDVaUJ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d0Fd0futMJQ6NZkCl51ARozthr+xW/+2rTn9TEm/VBSrKZcvImvXEam9jeCKi45m/kyY3IXR/cDBwkmowsiMk1RHxX1b5VunJythCn8fx7e9phuZliR3CVW8ijJGu8cebq0D2SE8ilDSh9Eo8KmvwdfI06LmVb9WeqXRKoutAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HEUtSm5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXckzagp; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 90D5A11400C6;
	Thu, 24 Oct 2024 16:52:35 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 16:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729803155;
	 x=1729889555; bh=UKn55uvk0sOz7SFf9yxH7bM2PKhy4vrcSTmpE2pr/gM=; b=
	HEUtSm5alih4H7mrp0WTqBFGVcT59t+qwRCmtwvxS9HbsJzTapsRziWnWGkiKceK
	cc+fKsjKO6EWL7QDeCuzv0vOoMUG9bnOlRdVHPcmv5KfwBf6UkmptXxhpZf1oz9C
	O0NA3rjRvooFIrJvytFmMtNRdlt1iIU86zWNH75581JQGFPbbc/cxFoBx5n1vJn3
	ez8QGHpt1lAsWIkSaTMmfWuEHrsCjnDMnrdi8xlgDpTtg8SstZM/z22Ce3f6Eofw
	Q1p2PPt/ZPYCJbPlVVr/a5RV3om+cc4ZSNdM3si8B2T3UrtrbW69pHZDhmVZdpkN
	gBdnPcQpR6x/fYTrUrXSww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729803155; x=
	1729889555; bh=UKn55uvk0sOz7SFf9yxH7bM2PKhy4vrcSTmpE2pr/gM=; b=L
	XckzagpFfo3syOomtaBU5XNNzHyaah74gPYMcG9Ro3vphq0JqlrJcmdm4ibCEWm5
	215nWblDp/+thcQotqP7n1inxb+P/j9LrsAt+5xh0DANgVmBsEvS66AyxX2g9DJ1
	dq/mNgsMObK9DBfbEIOZDy25oZ8nkCLc+cjxA+XbuBf9c/uKPlItsib64D9VsLlL
	PktuCKVQs+l0chwOVEY+Jtms0a57zSA3dXONFtW2AAyClv5AiIulvT6gBiAE+yao
	4OrkbBUyGbEd2Cspv4GlLnhlZ73bDqvJ+RLNTqsB6iBPXdFiPIgTnTYExYAYLfQa
	NqsOua422cScRNtfGwX0g==
X-ME-Sender: <xms:k7MaZ8m0l9TPIVDPv_3BOXaq6Pzfje8DREdKPpbU9mysxA63hDFxMA>
    <xme:k7MaZ72rRhD3cDAuk1B743-M7D5nrtftkRP4khPAlHDAeCbJrg47ZDDJBWE32XEW8
    xKWmXvnE_hTooSINA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculddvfedmnecujfgurhepofggfffhvfev
    kfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceoug
    iguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteeiveeiudefiedvvdff
    udekvddvheefudeivdffhfeiheetheetffdukeelteeknecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghdpgidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopeelpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgt
    ohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopehlrghorghrrdhshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopehmvghnghhl
    ohhnghekrdguohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvth
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k7MaZ6pF_5vDkeJL6Dys8mspJUVpFtLRlAlJOVgGup8yxwfDYY_x2A>
    <xmx:k7MaZ4nR4q3AAcaqZfoSS3-HmPdL1lyJGj_W8d4g9rmH0_CTZdGi-w>
    <xmx:k7MaZ60RZAbtjygFwvbhNDxY_QGPm5iwd1_472u4AALWSm_1B18exA>
    <xmx:k7MaZ_uQ33IKKAjkEB9Zu7FVuR6J6SrJquPd5SUWeHvEvPg5fFPMhw>
    <xmx:k7MaZ7LsEiO43Mlngx63rhkEOfe4u9WbpeNVdi9le5FSMKki6WeumZsT>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 022CF18A0065; Thu, 24 Oct 2024 16:52:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 13:52:06 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Kuniyuki Iwashima" <kuniyu@amazon.com>, laoar.shao@gmail.com
Cc: "David Miller" <davem@davemloft.net>, dsahern@kernel.org,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 menglong8.dong@gmail.com, netdev@vger.kernel.org,
 "Paolo Abeni" <pabeni@redhat.com>
Message-Id: <b2e2b3e0-7190-43e5-963d-fc291bba6f81@app.fastmail.com>
In-Reply-To: <20241024191356.38734-1-kuniyu@amazon.com>
References: <20241024093742.87681-3-laoar.shao@gmail.com>
 <20241024191356.38734-1-kuniyu@amazon.com>
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for
 tcp_drop_reason()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On Thu, Oct 24, 2024, at 12:13 PM, Kuniyuki Iwashima wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> Date: Thu, 24 Oct 2024 17:37:42 +0800
>> We previously hooked the tcp_drop_reason() function using BPF to monitor
>> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
>> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
>> To address this, it would be beneficial to make noinline explicitly for
>> tracing.
>> 
>> Link: https://lore.kernel.org/netdev/CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com/
>> Suggested-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Menglong Dong <menglong8.dong@gmail.com>
>
> I saw a somewhat related post yesterday.
> https://x.com/__dxu/status/1849271647989068107

Glad to hear you're interested!

>
> Daniel, could we apply your approach to this issue in the near future ?
>

I suppose that depends on how you define "near". I'm being vague
in that thread b/c we're still experimenting and have a couple things
to look at still. But eventually, hopefully yes. Perhaps some time
within a year if you had to press me.

> Thread link: 
> https://lore.kernel.org/netdev/20241024093742.87681-1-laoar.shao@gmail.com/
>
>
>> ---
>>  net/ipv4/tcp_input.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index cc05ec1faac8..cf1e2e3a7407 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4894,8 +4894,8 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
>>  	return res;
>>  }
>>  
>> -static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
>> -			    enum skb_drop_reason reason)
>> +noinline_for_tracing static void
>> +tcp_drop_reason(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
>>  {
>>  	sk_drops_add(sk, skb);
>>  	sk_skb_reason_drop(sk, skb, reason);
>> -- 
>> 2.43.5
>>

