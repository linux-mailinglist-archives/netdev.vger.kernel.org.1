Return-Path: <netdev+bounces-161572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA7A22728
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D62D1884701
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A4611E;
	Thu, 30 Jan 2025 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="PbStmRJn"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A98F5C
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196645; cv=none; b=uAeJ5ie+zEUEEC8YusdjlWLMwCOrLeB6iYI+mJt03tv3GzpdiHtdG80I+3SX/nd72dKtyAp2x3v4BxyShtICEjtG8GCgdd6LGa9hCzeCjJ5pDAEcxtQuNGf0Uvql2Hnn3CyzfLQUWySYpXzoaK32PoZaF/V5MlgegurpO4vWOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196645; c=relaxed/simple;
	bh=fhH1K3s7XEW+gmNI94YuegWyeVjbwv5/n+2zCHM1o2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7yHLUUFn0XcvsxGNkcH7SolH49jJX9w3/VD4ebGlN8dlv5LjHwTZC82wRTGY4AGAo+/SlYUs4gXpyjhMXgDkZZ+sncmNYIGXmF7Wc0YMRgSHnvA8VyvnlONjfx+axKXUaBaZu8Hpt03jstrnnhJ/1wcLv3jlZgEhpDNbKzyIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=PbStmRJn; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.27] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 27C0E200DF94;
	Thu, 30 Jan 2025 01:24:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 27C0E200DF94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738196641;
	bh=ZPhjQ+sGzzsjqCiS4v/CDcOTnBxLV6K9eR4go8Q1wzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PbStmRJntB//esaLs7Wz/QlpKpFy/v9NykmGe+VnK14y+YGKhCa/+l3qbGiQ1EN89
	 hVQoCN9nyk0vGJUm8aZm11d0iQaoR3GDE6KiuPI8Qy1uAbygXDNuLeqx2F3qqGKp3i
	 1lbtR7L3zmzeCIEiTrW2EmHT2z/4FDD/HeuUngH/No7L7pwLCG5KAvwLZF3X96a1Pt
	 oRjr+CmIglIt+W2GRSQefpysapjlmtYIFjs2+Wnvyg4QpURyaHRs4r9iOzOUbD3UW3
	 6RMXmf9NMaaCpjU8uQcSmI5s72Vt7Pz5WUEmiG/DzXFXzxn7dxn/mAJL4eWbsten1B
	 r5uxQXFNNfUPw==
Message-ID: <4dd86c71-b6b7-483d-abe4-0fc40c51bc5e@uliege.be>
Date: Thu, 30 Jan 2025 01:24:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org
References: <20250129021346.2333089-1-kuba@kernel.org>
 <20250129021346.2333089-2-kuba@kernel.org>
 <4a30a0aa-2893-4f6a-a858-61e51b2430b2@uliege.be>
 <20250129121408.0fe5d481@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250129121408.0fe5d481@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 21:14, Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 17:50:14 +0100 Justin Iurman wrote:
>>> +		if (dst->lwtstate != cache_dst->lwtstate) {
>>> +			local_bh_disable();
>>> +			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
>>> +			local_bh_enable();
>>> +		}
>>
>> I agree the above patch fixes what kmemleak reported. However, I think
>> it'd bring the double-reallocation issue back when the packet
>> destination did not change (i.e., cache will always be empty). I'll try
>> to come up with a solution...
> 
> True, dunno enough about use cases so I may be missing the point.

Possible use cases: (i) with inline mode, or (ii) with encap mode using 
the same destination address. For (ii), the egress node of the IOAM 
domain also happens to be the actual destination of the packet, but it's 
not "your" packet... so you use a tunnel to stay compliant with RFC8200.

> But the naive solution would be to remember that the tunnel "doesn't
> re-route" and use dst directly, instead of cache_dst?

Correct, that'd work.

