Return-Path: <netdev+bounces-151695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B199F0A2E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D695188CB1F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498571C3BF6;
	Fri, 13 Dec 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="SlDfjK+7"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69B1C3BF3
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087459; cv=none; b=YyqDFqizr3VJrHldAgyVj1KOOYhdrd4M0a7XuI2ULGgFe5hNgc4+lbk7/J0GF+IuOPOb/27xJcOS+Jr/zaEaoWav6tvOovk6BzNldDS66Pi5neEaYY/1HNh4/cghs/WmvEJbpTO0+vTOm60k44RVS9HdtH/bduyGivUhJGaWfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087459; c=relaxed/simple;
	bh=z+o/Zz7krE43eRXV97sp4NU1krgfzZkKBi/loEK2Lrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDBQ7W6Rg+g1pbTlRz7WLNzsAxsDM9eqoJZnXAoGGcpb2M1n84sxRl6+8qvvzQA3VsS1jHCZGn2g23C2uoQBdToQNODJqFLXIEl9Ett3Cj/uahRFFwksBtGX8J8fKdMN+NrGLzTaIB16R6nDZXHyQqZEMMNw1DWWwUaVlr1F7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=SlDfjK+7; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734087457;
	bh=00fZ8KH7ULyifEqPcXVN839tg77V4BOPE7wEvL/fgSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=SlDfjK+75cmB6VBxQUjzutgAasTq0XyHEZXuRQTMYANATZx80PokrHArSuUU1ZOzF
	 8X3sfeGtQLu25CEgKou2az31SskKfKFymKuuK7TdGfiE3BFmQYmEkMQ3PgjAJ2UXxi
	 YcheOvkpH9ggPo0gE8/pAaLPh7LXPBg5vZypQuqz3mDWsLop4V1oc3vzE4RZy1j9s4
	 30JGRNTkvEiz4oRm+96fF2LGcy2So864ES8uPr/LrEC7Qjk2ZkoOaR4LhFdtElUmdh
	 atzemgctHVG+7tfh6exPJZG9bEqxPr0kfuJ+Sg+sgazEKSP34Jrn9Z9ji/iqntcqM7
	 9+JdJov1FP8eg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 315A34A031F;
	Fri, 13 Dec 2024 10:57:31 +0000 (UTC)
Message-ID: <692ac4bc-aa97-4fea-9f40-bad7339e9474@icloud.com>
Date: Fri, 13 Dec 2024 18:57:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: wan: framer: Simplify API
 framer_provider_simple_of_xlate() implementation
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241211-framer-core-fix-v1-1-0688c6905a0b@quicinc.com>
 <20241212164149.GB73795@kernel.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241212164149.GB73795@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2hmm-zXKEQIQuq-czsvIVfPnznAF18RJ
X-Proofpoint-ORIG-GUID: 2hmm-zXKEQIQuq-czsvIVfPnznAF18RJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=667 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412130076

On 2024/12/13 00:41, Simon Horman wrote:
>>  struct framer *framer_provider_simple_of_xlate(struct device *dev,
>>  					       const struct of_phandle_args *args)
>>  {
>> -	struct class_dev_iter iter;
>> -	struct framer *framer;
>> -
>> -	class_dev_iter_init(&iter, &framer_class, NULL, NULL);
>> -	while ((dev = class_dev_iter_next(&iter))) {
>> -		framer = dev_to_framer(dev);
>> -		if (args->np != framer->dev.of_node)
>> -			continue;
>> +	struct device *target_dev;
>>  
>> -		class_dev_iter_exit(&iter);
>> -		return framer;
>> +	target_dev = class_find_device_by_of_node(&framer_class, args->np);
>> +	if (target_dev) {
>> +		put_device(target_dev);
>> +		return dev_to_framer(target_dev);
>>  	}
>>  
>> -	class_dev_iter_exit(&iter);
>>  	return ERR_PTR(-ENODEV);
> Hi Zijun Hu,
> 
> FWIIW, I think it would be more idiomatic to have the non-error path in the
> main flow of execution, something like this (completely untested!):
> 
> 	target_dev = class_find_device_by_of_node(&framer_class, args->np);
> 	if (!target_dev)
> 		return ERR_PTR(-ENODEV);
> 
> 	put_device(target_dev);
> 	return dev_to_framer(target_dev);
> 
thank you Simon for code review.
good suggestion. let me take it in v2.

> Also, is it safe to put_device(target_dev) before
> passing target_dev to dev_to_framer() ?

Successful class_find_device_by_of_node() invocation will increase the
refcount of @target_dev, so i put_device() here to keep the same logic
as original.

thank you.



