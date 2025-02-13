Return-Path: <netdev+bounces-166233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3743A351B7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80190188F6DA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A65275401;
	Thu, 13 Feb 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="B3SbRHb0"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0C2753E9
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487482; cv=none; b=NaWBML3FSS94CXtfM5e9FNErvbqINT8ASUZfsD4HV5+elqmlwVnpltz8G+cH+JeFZ3YkKHlJ7JumoRTGkEQPMoxW4m6p7r6aAGaO5mBD6TbcKoTE+2qdGfrTFVV5YkLFrzfOPrSukYrjKkOYLYMS8ot1Y90NGPYWFm97+i1A3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487482; c=relaxed/simple;
	bh=hOkcymzifOW+LcwUuISCfUyRkuevObnwB7RCKwYXv5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1QJuMVOg/n0XNPq3gth0epSmIUvzieRGgFvaG3E90QTbxqgy67tW2Hv74KKhEcG2JQ+aWn2LHcDrshy1lZC192wv8kUHF8PLc5Hq+Pj7LLiD6fCfQXJzzHJeTuPSfSaOaBeUSdb9FRYGrqFHDx8uGuf0l0rsYmocwGmtbi2vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=B3SbRHb0; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.136.6.34] (unknown [213.221.151.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id E439B200E1DC;
	Thu, 13 Feb 2025 23:57:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be E439B200E1DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739487478;
	bh=bIquwMcCJQuP1gBaOjF0UYzCXiJRgVcFheIQwRprq5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B3SbRHb0yXMZIA8ZikAwCzqKeYdrVD+g0WiDy81ikwrHbk95JVF1+sOv/XMnnWyug
	 H4DWdwH2zgOyxYhavXwvEAJmdSQjETSi2nooSv+QQuga8QFTd3/LuwHcFQRxk7qXok
	 Am6D/eoOpWexZDCLlaNAb/9dSqDQgJjCpyfrZzPzGm6ZzfYi0MpYnwVG2216GPOQG7
	 G55uhQDCh2Nv1eVF5YSD1kIHRCjmP+9KjcIZ74H4w7aHeh29Pbft+CfmT8plo5pAXg
	 q6f8Mw3k9ChEdY7GW+Fbhx53Q+mRb7oBCFMznbOuqJMafV5qA81MFvZWv7Gr1zgD1B
	 hpUo43rZ1TRzg==
Message-ID: <e5d30bbd-4dfc-4a97-9eaf-39e0dfe51826@uliege.be>
Date: Thu, 13 Feb 2025 23:57:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: ipv6: fix consecutive input and output
 transformation in lwtunnels
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-4-justin.iurman@uliege.be>
 <231856f0-deb8-4550-bdf3-b0ef065f7b7b@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <231856f0-deb8-4550-bdf3-b0ef065f7b7b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/13/25 15:33, Paolo Abeni wrote:
> On 2/11/25 11:16 PM, Justin Iurman wrote:
>> Some lwtunnel users implement both lwt input and output handlers. If the
>> post-transformation destination on input is the same, the output handler
>> is also called and the same transformation is applied (again). Here are
>> the users: ila, bpf, rpl, seg6. The first one (ila) does not need this
>> fix, since it already implements a check to avoid such a duplicate. The
>> second (bpf) may need this fix, but I'm not familiar with that code path
>> and will keep it out of this patch. The two others (rpl and seg6) do
>> need this patch.
>>
>> Due to the ila implementation (as an example), we cannot fix the issue
>> in lwtunnel_input() and lwtunnel_output() directly. Instead, we need to
>> do it on a case-by-case basis. This patch fixes both rpl_iptunnel and
>> seg6_iptunnel users. The fix re-uses skb->redirected in input handlers
>> to notify corresponding output handlers that the transformation was
>> already applied and to skip it. The "redirected" field seems safe to be
>> used here.
>>
>> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
>> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
>> ---
>>   net/ipv6/rpl_iptunnel.c  | 14 ++++++++++++--
>>   net/ipv6/seg6_iptunnel.c | 16 +++++++++++++---
>>   2 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
>> index dc004e9aa649..2dc1f2297e39 100644
>> --- a/net/ipv6/rpl_iptunnel.c
>> +++ b/net/ipv6/rpl_iptunnel.c
>> @@ -208,6 +208,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>   	struct rpl_lwt *rlwt;
>>   	int err;
>>   
>> +	/* Don't re-apply the transformation when rpl_input() already did it */
>> +	if (skb_is_redirected(skb)) {
> 
> This check looks false-positive prone, i.e. if packet lands on an LWT
> tunnel due to an tc redirect from another non lwt device.

True, it was indeed a trade-off solution :-/

> On the flip side I don't see any good method to propagate the relevant
> information. A skb ext would work, but I would not call that a good method.

Agree :-( Did not check but maybe we could also look at 
skb->tc_at_ingress in that case? Not sure it'd help though. Or... any 
chance we could find a hole in sk_buff for a new :1 field?

