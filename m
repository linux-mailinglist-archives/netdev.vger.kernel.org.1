Return-Path: <netdev+bounces-152654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB29F50FC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C942169150
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C881F75A7;
	Tue, 17 Dec 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rsGNnJFy"
X-Original-To: netdev@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6091F63C6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452749; cv=none; b=Lnc4KTLsbjG/lYLTabB9IwmZ192V7b4pHjanDXfAZwQGM9LsO5rUpuRl22foXiEeYc7Z8NeWw1ubUylSL3dYu0Ltj5btuIqp1mLkoRcZE1tYCYf8afh02VAHJCI5/coMCj3Z1+0dsCwxMF1ybrtbo90tNx7l8qXa+B3u/S2uvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452749; c=relaxed/simple;
	bh=marL0g/AeC3kq0LTYdIstsHGV6iTl3SfJQRXW9FJp+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxJsJgO7v5zJ5DuKGgq64Z6ZJ9WrWRfNoSYXZ3QF72yJAHozOCzhBvvEzRwc704hCoOVn4uPDX2LqWfx0KA8MEUopT4pG2KpIBsqsP414ZDjplbOTPuR28R3PE26WLFuzxSlamaXSU7RWvpwPlD0dglqqS+qmTHjlfxp72jyFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=rsGNnJFy; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id NCZyt0TfunNFGNaOCtYcmd; Tue, 17 Dec 2024 16:25:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NaOBtdyTB65gFNaOBtgn4H; Tue, 17 Dec 2024 16:25:39 +0000
X-Authority-Analysis: v=2.4 cv=Z58nH2RA c=1 sm=1 tr=0 ts=6761a603
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=VwQbUJbxAAAA:8 a=47l3tzjqmLtwkH2Ukf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u1t2bCB/btS7LZ6d6eYaJLiS3EvRiz7HQNF2Ap5Ee1Q=; b=rsGNnJFyjhOM4Ewe65c1/Z/frN
	4K/jiR8E2M/JG8ES5cOdwq/Xj/RiTYCf5iRxvsdBN5yDPPlYb7ANGW6+h930neJ+AFfFwBuAy5u6q
	dBfH/CKamNFBni6BOy/shwWJpR29rIg61zu0AVr00nS/4YSOVzZ4cywODE/ndLi3mQaCLnmMrJWad
	4J8ZTIskmUQ8GqwVPHVVp7m04j5X9wp4P9+BfAB/32T8Pk4vP9+YsPwOdTmThHXYdKe+dTLXGNIR5
	tFy6rD0nD7vL5F4qVRlmdr1tcIIADYKhQVosNh0KCfL+YTMmrFkboOiGaPcKGk0FeUZ2lTi6LqpK5
	JecdV8AQ==;
Received: from [177.238.21.80] (port=38346 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tNaOA-004Mf9-16;
	Tue, 17 Dec 2024 10:25:38 -0600
Message-ID: <ff680866-b81f-48c1-8a59-1107b4ce14ff@embeddedor.com>
Date: Tue, 17 Dec 2024 10:25:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 cferris@google.com, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
 <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
 <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tNaOA-004Mf9-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:38346
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGPH5PZ+3bG29/vZFTyvKP4U/O5w+kpKfCcvBT0Uryb3ySddhV3QrS7D961AhjzrCiqkTebAy1HMlXPqRPZ5W8jVuW1Tki35BVK4dsz1gyhq/QNI4RMz
 IQs4vAKgHW7/4972kw/lskbcOvtfr5LrwvPPGkKeJuOAMMnBRYUeAbcIe6xKBOyBM6LR3HRgVpuCCUQGYsGl8iRfOEj/c6FiXXs=



On 17/12/24 10:04, Alexander Lobakin wrote:
> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Date: Tue, 17 Dec 2024 09:58:28 -0600
> 
>>
>>
>> On 17/12/24 08:55, Alexander Lobakin wrote:
>>> From: Kees Cook <kees@kernel.org>
>>> Date: Mon, 16 Dec 2024 18:59:55 -0800
>>>
>>>> This switches to using a manually constructed form of struct tagging
>>>> to avoid issues with C++ being unable to parse tagged structs within
>>>> anonymous unions, even under 'extern "C"':
>>>>
>>>>     ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct
>>>> tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous
>>>> union may only have public non-static data members [-fpermissive]
>>>
>>> I worked around that like this in the past: [0]
>>> As I'm not sure it would be fine to fix every such occurrence manually
>>> by open-coding.
>>> What do you think?
>>
>> The thing is that, in this particular case, we need a struct tag to change
>> the type of an object in another struct. See:
> 
> But the fix I mentioned still allows you to specify a tag in C code...
> cxgb4 is for sure not C++.


Oh yes, I see what you mean. If it works, then you should probably submit that
patch upstream. :)

Thanks
--
Gustavo

