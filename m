Return-Path: <netdev+bounces-160892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE6BA1C043
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 02:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904AD7A1011
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537D2AF00;
	Sat, 25 Jan 2025 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FldzSzpc"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C312EB10
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768620; cv=none; b=Cmi/nk3heqbqaUSWLDepT2B53q2tVAAoqXilzEVZpKv5/hU1lt+FIPOR3ksNVI0+jkl3/5dzzhy1TtgcV05ZGAFg08ZiqalwRq6G3Tm/C9dTre3skobZo99X5sjf/ONJ/25B9wbfpHaPARn8ngnPHePowzxpwqSSNAFc0v/lLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768620; c=relaxed/simple;
	bh=xlHDRH4aaaT8Wv9ZFtcEzP8l9Qw4wlzmBeiEmdFXPSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgW4XhDDSkczAj2DMvAiDrEJDbq8J/dqfn4MagqFt0HCWZNdziowz1H6vvHd7nlX901HFvUCsGmcvJ/bJ1ZBirAWR757uab+390tJrsfN2qlAG9mxCpGMT480/WoJ8T+kjT8C30x6u7YMTFd7c7HER+YOiSUHhQkLwZtpUI8lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FldzSzpc; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a91d654-0e61-4da0-9d09-66a82a24012a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teYSIs7Uiq6eKAUNKYGoAGcgJDlbw620Kr/OGdj12KE=;
	b=FldzSzpcs2rIsQkTD+gjS8VpgHiZChpU1Kpq4ot89/E80N3UHcuYBS3KCZwX/2PNKkng8D
	yjByuD2F8ImU0ICfEym3AExbjRlZZz9auavcL6aN1ilsJwQHMmgOviR4mNG+R914HYAytF
	E70ZzC9voQ4BWNkQdi7JUfxCXpQC184=
Date: Fri, 24 Jan 2025 17:29:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-9-kerneljasonxing@gmail.com>
 <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
 <CAL+tcoCzH2t0Zcn++j_w7s2C1AncczR1oe9RwqzTqBMd4zMNmg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoCzH2t0Zcn++j_w7s2C1AncczR1oe9RwqzTqBMd4zMNmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/24/25 5:18 PM, Jason Xing wrote:
>>> @@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
>>>                op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>>>                break;
>>>        case SCM_TSTAMP_SND:
>>> +             op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
>>>                if (!sw)
>>> -                     return;
>>> -             op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>>> +                     *skb_hwtstamps(skb) = *hwtstamps;
>> hwtstamps may still be NULL, no?
> Right, it can be zero if something wrong happens.

Then it needs a NULL check, no?

