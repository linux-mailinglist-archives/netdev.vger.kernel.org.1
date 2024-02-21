Return-Path: <netdev+bounces-73629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DE85D64C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2FAB2429D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35E3F8C0;
	Wed, 21 Feb 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="UdwMckWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHo+6gFc"
X-Original-To: netdev@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8613F9C0
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513209; cv=none; b=Q+YvxnaTQtyn5xxp5U6WQsmQImBYNat60CRED8d0AWIgIni/4eM1JGGK1J7y9Wr+TKRCbcrmzZstO6xpmFLjmRsSAukZMwGZfSby8dEU1xkcMux0llQ86Q/pSFVuIvxb3hyhrLyOoM+j7gVYdR2obdUnkJfbCvCDs+vYCODwjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513209; c=relaxed/simple;
	bh=TydYPIf//i8Ms4PKZDeaEwsKoxhsB0maNbKFkZQUdzM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GMDI91tuOP1UusgcbSLXYApp+pQAcNkZB+mp8+Z6Gxq93b27U8ZfzTW8NOG2a3Rulb2Kjo3e9Abd5L5JYliOauSWJlJdV4zn8Ryy8KjpjfsjBQyEwR/9jXVL/GgfT/BkExGn1BzMK8DU2xzfLo6gH269mc8aOzKiEdOqARV9NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=UdwMckWV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHo+6gFc; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id BF1F6200112;
	Wed, 21 Feb 2024 06:00:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 21 Feb 2024 06:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1708513204;
	 x=1708516804; bh=2l0m6SK9ZhUyeKd+2ZK7kYzAYlHJHLYEHIbWiRk/RTo=; b=
	UdwMckWVfcTLSWo6qzvvboDkwC7cLnMOxwbOaOwhCo6spL94ODP/+kQfh20COjLK
	27RItzVDE1lgRIrvC30P4o/q11GmroqieWNwOcHlVCTHUsLvJwW9yFhOAvfd03Ak
	w3u3hqtii3T0gZsKCz7e+zfqXsgS1APHz6qJq0jq2k62FXNrKJ0wVmi65Ip46Ok0
	mqDz/8mxLZPmL+1a1Qpnta9GFrR5xAutehSL5Is1NYEzS1tKTlP7D+aDhTuULwhJ
	Ty7UZ6D6zEPy3mXnhLPVrCyBmWI3N/HSoDz03T97N1IcwSI4tFMp93V70Y2mkabR
	l9OIVISGttN+Wy3LOgleow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708513204; x=
	1708516804; bh=2l0m6SK9ZhUyeKd+2ZK7kYzAYlHJHLYEHIbWiRk/RTo=; b=n
	Ho+6gFcEwj+3ea2IERCLWcUDsl0sl1T/DdCMofTaSXfZ0CFUN3xvQwVhl0pBc4K8
	sTBY9Ry4oLshU85qnFHzbZYElj2ifxD0Vl68TMUSnUPvxbI4vQxrfuwUvxE5nHLS
	D/FYy/tPOWzqYZg1Q1bWVaeMLVvA9nx14mg9MCQPp/590bqeEB44AiVI764MQ1u6
	02dkmBC9H5Oy/eKQqgwUDBtjsnXNGxRiA+pszmzlpGtvEE9/UhaiKkBVE+HlBKGK
	AVSeS3b1kUKC8eBbSZo5VLUHQ1U33qOVz767Lihd3MuqzFOYt8DqfCdqtyGXCvKQ
	/X0roZJ6zbQELkdb1Yquw==
X-ME-Sender: <xms:s9fVZT-2BZLEbgDdT1fXgwPS_b81qh6zJOhBhIP4k32cA-FbwOrtiw>
    <xme:s9fVZftONTpKks3CskByEtvuMIIzCEf3hnJVUy-0Xhv_vwWoI-M32erNpzvPgmytr
    jGjupYAWkLS2DS_gQg>
X-ME-Received: <xmr:s9fVZRB7bB7nMQeZcV9fP5PJTHIWvqwfdBaxv1EmH8XQxTD0SZSrWfWrnKnwyygWIE9TV0LZf4GFds6XHpV5iVcgTeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuhffvvehfjggtgfesthekredttddvjeenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepkedujeekveeileduffeghffhudfhjeegjedtjeevfeetvdfhffeljeekjeef
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqh
    guvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:tNfVZfcxZALK8RrRj8Sc0aqS5UmP_EwpLrlp0TyiUoLcirpZx-mV0Q>
    <xmx:tNfVZYP0hIe6rWI69cM-xoTTwFdZ5F5gIWQ0GXkMUjMfwsBt17D-WQ>
    <xmx:tNfVZRlq9KrNr_ADBjli91-xuAfg_URmczQx5k91GMzwU-h-kMA7mg>
    <xmx:tNfVZX2xZc2wqHJ3UEPQ3wNvQzr2m5IYzbGyBRrMVZaCVXQVM-VsOBK5U-0>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 06:00:02 -0500 (EST)
Message-ID: <9610f33d-ee98-4b95-a776-a203d83401bf@naccy.de>
Date: Wed, 21 Feb 2024 12:00:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2 v8 1/3] ss: add support for BPF socket-local
 storage
Content-Language: en-US
From: Quentin Deslandes <qde@naccy.de>
To: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kernel-team@meta.com,
 Matthieu Baerts <matttbe@kernel.org>
References: <20240214084235.25618-1-qde@naccy.de>
 <20240214084235.25618-2-qde@naccy.de>
 <576ebc9e-4307-4e01-9b41-12aaac83b14a@gmail.com>
 <5615212b-736d-4a91-8951-ddb9bc90049b@naccy.de>
In-Reply-To: <5615212b-736d-4a91-8951-ddb9bc90049b@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-02-21 10:51, Quentin Deslandes wrote:
> On 2024-02-18 18:39, David Ahern wrote:
>> On 2/14/24 1:42 AM, Quentin Deslandes wrote:
>>> +	if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
>>> +		fprintf(stderr, "ss: BPF map with ID %s has type '%s', expecting 'sk_storage'\n",
>>> +			optarg, libbpf_bpf_map_type_str(info.type));
>>> +		close(fd);
>>> +		return -1;
>>> +	}
>>
>> ss.c: In function ‘bpf_map_opts_load_info’:
>> ss.c:3448:33: warning: implicit declaration of function
>> ‘libbpf_bpf_map_type_str’ [-Wimplicit-function-declaration]
>>  3448 |                         optarg, libbpf_bpf_map_type_str(info.type));
>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> ss.c:3447:68: warning: format ‘%s’ expects argument of type ‘char *’,
>> but argument 4 has type ‘int’ [-Wformat=]
>>  3447 |                 fprintf(stderr, "ss: BPF map with ID %s has type
>> '%s', expecting 'sk_storage'\n",
>>       |                                                                   ~^
>>       |                                                                    |
>>       |
>>   char *
>>       |                                                                   %d
>>  3448 |                         optarg, libbpf_bpf_map_type_str(info.type));
>>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                                 |
>>       |                                 int
>>     CC       lnstat_util.o
>>     LINK     lnstat
>>     LINK     ss
>> /usr/bin/ld: ss.o: in function `main':
>>
>>
>> Ubuntu 22.04 has libbpf-0.5 installed. I suspect version hook is needed.
>> e.g., something like this (but with the relevant version numbers):
>>
>> #if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> 
> After checking, all the libbpf symbols I use require at least libbpf-0.5, except
> for this one which was introduced in libbpf-1.0. Hence, I will print the type ID
> instead of the string. IMO printing the string representation of the type doesn't
> add enough value to justify adding a version hook.
> 
> However, I see the minimum required version for libbpf is 0.1, but this
> series requires 0.5. I would check the version in ss and #error if
> the requirements are not met, but I'm not sure this is the right way to do it.
> What do you think?

I've settled on a slightly different solution: the BPF socket-local code is gated
by ENABLE_BPF_SKSTORAGE_SUPPORT instead of HAVE_LIBBPF. If libbpf-0.5+ is available,
and HAVE_LIBBPF is defined, ENABLE_BPF_SKSTORAGE_SUPPORT will be defined in ss,
enabling this feature. If HAVE_LIBBPF is defined but libbpf-0.5+ is not available,
a compile warning will be printed, ENABLE_BPF_SKSTORAGE_SUPPORT won't be defined in
ss, and ss will be compiled without socket-local storage support.

This will ensure that:
- Features relying on HAVE_LIBBPF in ss don't have to comply with the same requirements
  as the BPF socket-local storage support (because iproute2 only requires libbpf-0.1+).
- This change won't prevent iproute2 as a whole from being compiled.

This seems much more reasonable than using #error and failing the whole build. I'll
send a v9 with these changes.

Regards,
Quentin Deslandes


