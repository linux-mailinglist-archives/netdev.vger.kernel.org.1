Return-Path: <netdev+bounces-146238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE69D2643
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6486D1F21D4F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E391CC8B4;
	Tue, 19 Nov 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="lvM61Has"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6761CC179;
	Tue, 19 Nov 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021175; cv=none; b=HzMKO6O/qJYQk9IGDFyO0J1nDJ9TAeJjg/Ca9ZPjO6Y9qMbZXeymfOUGVmjzwkfF4C9Eqtyy05G11il2jNuCBMmLTKdvtD9BligwMtVRWWmZxxjzYoMPkz7X4OROYG/tA9dgGiUmk+WqxKETs9oo4Sr0ea6quvTohxH6txCA7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021175; c=relaxed/simple;
	bh=1llduVjy5PWJgEMuLEm7/tO60PRg+sUawsb8yextbYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d66B7ULZjTEgIevZFia+ijYwurR7yb06mv3/fRfyd4XUT4R/K00YWfZI7ppQnMVRNU9Ve09+qyjEvG4nBIPJcVoQRE9R702ORsOetwGc7TXdFFFtjN9IhyN5LSsr0yIHsSnCU7PqpOE3hipE1rqrjMjBSPVDQHEZcCuLX4IvGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=lvM61Has; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 9AD64200CCE8;
	Tue, 19 Nov 2024 13:59:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 9AD64200CCE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1732021169;
	bh=JLDdrf8H0z05a38SAQyVdrEI6mT9UJG9ydDumM/8tNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lvM61Hash7jKUhhtemEq6q3BwBbWmPn3n6ock+2jZj6O6qG02tPvFcdVkolIrfuMc
	 3R5EomY0eANtaQW+XNNaskb2uxihbsQouLJmovV7liK4Xyi6LGcGU4SfwmaTRLscB5
	 5zpVahU4SQymUOOORgi6KBnjb+6aMpW5VpPIwyvHReDAh+6hauK/3khELnlDVSrn+A
	 16r7+N47lPMkl1UQi0vSSEChltSZKx8lYjbtcwygyPZgjtxy0CsKinWLVv/DhlmFtD
	 r3f0qRk1PfXkAqfnpr8HR1eniAOERRIfeI83eNcYCoY49SSO7KrEJaM5QtActWEzjd
	 npRUqOPLE6Kkg==
Message-ID: <4634a4eb-6be5-4b10-bd22-d95e1970ed42@uliege.be>
Date: Tue, 19 Nov 2024 13:59:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/4] net: ipv6: ioam6_iptunnel: mitigate
 2-realloc issue
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20241118131502.10077-1-justin.iurman@uliege.be>
 <20241118131502.10077-3-justin.iurman@uliege.be>
 <82c02bbc-5d64-464d-83c1-66f1d71a1a44@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <82c02bbc-5d64-464d-83c1-66f1d71a1a44@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 11:42, Paolo Abeni wrote>> -		skb_dst_drop(skb);
>> -		skb_dst_set(skb, dst);
>> +	skb_dst_drop(skb);
>> +	skb_dst_set(skb, dst);
> 
> Why the above 2 statements are not done only in case of ip address
> match, as in the existing code?

I guess you meant "when they do *not* match", right?

>>   
>> +	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr))
>>   		return dst_output(net, sk, skb);
>> -	}

Good catch. Initially, the only reason was to be on the safe side. Will 
change it to:

	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
		skb_dst_drop(skb);
		skb_dst_set(skb, dst);
		return dst_output(net, sk, skb);
	}

Thanks Paolo!

Cheers,
Justin

