Return-Path: <netdev+bounces-146239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C689D2665
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EFA1F21AA2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D771CC8BF;
	Tue, 19 Nov 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="OkihF1ok"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C481C2454;
	Tue, 19 Nov 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021636; cv=none; b=qne1cL0YfNPtwnVP65y2WLOlPneWRZWzsoqWE6xRA+X33632BM6jCNSB4SMqsEc8mLeiJxw/rhbmzezvmSJ3qGDe35zpcDQ9AHDa3iUv7i5ir1KpPTOCSXYCTrdXTdff/D0ISzppsGZgsO3ECuCHPwGIR7oeD1zf0Gvj4pf3cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021636; c=relaxed/simple;
	bh=SsiCOVO5mQfIQwSzilGE2YcyuA4VintjVTNzkDhYpks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqPGqLAKniir38Qk/vw+hVMk39Ri9OFzlEstww6cQMk+RWTx25RJt7+aLUM+79qaiW5LCzLOKz6kXPn1NSOi33+Fw5GLe5fDVcnjm98ZP1MT1odNaRynRP77kvW+xO60rRW623cmSnJoM9+z9WkC7q/LfV8APnqcuK2W2AdEG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=OkihF1ok; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B31B6200C98E;
	Tue, 19 Nov 2024 14:07:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B31B6200C98E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1732021631;
	bh=Uqcai8z7umCh/fVHnhTiNiSQIyclO6o+UNDsLjV2Wa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OkihF1okPbqbcf886xH++FISvOmgQxH3U37DmQyJEAf2rMKXcRGI9qUjTWAblaplb
	 Kg+Urmgp28m3SfSyO2j4Xa61+OXwS1HdeI3tWq7MUmzQ9fWJfjXn8Xe/ZHkrWi+Q72
	 +pGzQYwkN6Dg2/N+JMYjuJqEULoIaGan+E9++kQRqnUCIFZfev4DKDNlwPjKf7o/Vq
	 Zn2xWbrzDhobt8xlDJ83NxKgRwNhAdCmyWo4G4m3tksnY39nJ7Ct6IN6nxinW860/i
	 cTQjC663QbuVtQ72j2h5Yh/rNq5JOA6sOOgB7qZDJOIUa9HHooXh5bZbFojhJf8llq
	 vCVS2xlIsal5A==
Message-ID: <5dfc336e-d7e0-4219-af1e-6284facbdd94@uliege.be>
Date: Tue, 19 Nov 2024 14:07:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: ipv6: seg6_iptunnel: mitigate
 2-realloc issue
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 David Lebrun <dlebrun@google.com>
References: <20241118131502.10077-1-justin.iurman@uliege.be>
 <20241118131502.10077-4-justin.iurman@uliege.be>
 <1bc6fbd9-aa04-4bed-b435-262edd8f2d37@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <1bc6fbd9-aa04-4bed-b435-262edd8f2d37@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 11:47, Paolo Abeni wrote:
> On 11/18/24 14:15, Justin Iurman wrote:
> [...]
>>   /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
>>   static int seg6_do_srh_encap_red(struct sk_buff *skb,
>> -				 struct ipv6_sr_hdr *osrh, int proto)
>> +				 struct ipv6_sr_hdr *osrh, int proto,
>> +				 struct dst_entry *dst)
>>   {
>>   	__u8 first_seg = osrh->first_segment;
>> -	struct dst_entry *dst = skb_dst(skb);
>> -	struct net *net = dev_net(dst->dev);
>> +	struct net *net = dev_net(skb_dst(skb)->dev);
>>   	struct ipv6hdr *hdr, *inner_hdr;
>>   	int hdrlen = ipv6_optlen(osrh);
>>   	int red_tlv_offset, tlv_offset;
> 
> 
> Minor nit: please respect the reverse x-mas tree order above.

Oopsie, forgot to move the old one on top. Will do, thanks!

> Also the code would probably be more readable with:
> 
> 	struct dst_entry *old_dst = skb_dst(skb);
> 
> and using 'old_dst' instead of 'skb_dst(skb)'

Ack. How about "dst" instead of "old_dst" (since it's the current 
dst_entry), and "cache_dst" instead of "dst"?

> Cheers,
> 
> Paolo
> 

