Return-Path: <netdev+bounces-174188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1EA5DCCB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61073A4E5A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03901241C8B;
	Wed, 12 Mar 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="OvjoI5yQ"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD689198E76
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783107; cv=none; b=hgwHyx4+qZ498xlnxSFMkDz2/bpz7HpHcBw23tKXWvDKYTGQfWWiHEYg9DM92Cn5eyP+mlyfuTSaPLBPNvqLPWavxQb6MGhysQ5o93tqR3LLhOpUHL0jBKINUGiadf7jp3xLWopocDNV7EvXewhDAY/B2oeOzjisQj6EeU9RIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783107; c=relaxed/simple;
	bh=elabBGfPslTiWVgALdBxEz64Dt+ILrUC0ir1Nno6THk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1XrUf2eevLPdFR2OPKK5XkCLwhx2nn62+875zQnNh3ip4YLcjXnrB0+gnFfURKCFznkp4UZvprfKxzqBgM/9ogGjg1dbATO1I6nth7chFvLiqrI33TYgYyn0V8fmSlnCoOcl4uEH/y48XPdAuxsmyLxYjN+t+j78Y0Q9GCRLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=OvjoI5yQ; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.0.223] (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BA228200E1F2;
	Wed, 12 Mar 2025 13:38:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BA228200E1F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741783104;
	bh=ailD8zUIoYw0yJTJWzeuUBkOVZRNayAffcXojvC4wVA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OvjoI5yQGzZ277s576nwfWKnzl8FGxQ/T+VozztR5hD39htDQI/4BtPvT36fSbD8x
	 ObYpXG9cFTMeT1EiGsrBfSJpfVDItaSYI17v0z8h1etBN+SXitswlUdKxWLxvfONX2
	 aYsx8QoQRwuDnrn5LE2rCxQ+cZ9RkU5ND84iB6FAEkfELd2ckAVeoQ11rhbepwQUex
	 VNut5h5sRzdRZKp2FUYmh/vgnPRfNszAseswAYu/n2Iyj2/eCMxZ5f5sU9z76ojB52
	 oEZdp2aa7r/kRyvQZoLBOwfxYRStowyqSMDgxC7IBAhuH5cYo3X8TyBCcIhBHMjQye
	 F+oriTOWENaeQ==
Message-ID: <b976de06-2db0-443c-b504-77d3078bc022@uliege.be>
Date: Wed, 12 Mar 2025 13:38:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: fix recursion loops
From: Justin Iurman <justin.iurman@uliege.be>
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250312103246.16206-1-justin.iurman@uliege.be>
 <fb9aec0e-0d95-4ca3-8174-32174551ece3@uliege.be> <87y0xah1ol.fsf@toke.dk>
 <1c585bdf-ebcc-40db-bd36-81d008cf6827@uliege.be>
Content-Language: en-US
In-Reply-To: <1c585bdf-ebcc-40db-bd36-81d008cf6827@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/25 13:32, Justin Iurman wrote:
> On 3/12/25 13:29, Toke Høiland-Jørgensen wrote:
>> Justin Iurman <justin.iurman@uliege.be> writes:
>>
>>>> --- /dev/null
>>>> +++ b/net/core/lwtunnel.h
>>>> @@ -0,0 +1,42 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>> +#ifndef _NET_CORE_LWTUNNEL_H
>>>> +#define _NET_CORE_LWTUNNEL_H
>>>> +
>>>> +#include <linux/netdevice.h>
>>>> +
>>>> +#define LWTUNNEL_RECURSION_LIMIT 8
>>>> +
>>>> +#ifndef CONFIG_PREEMPT_RT
>>>> +static inline bool lwtunnel_recursion(void)
>>>> +{
>>>> +    return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
>>>> +            LWTUNNEL_RECURSION_LIMIT);
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_inc(void)
>>>> +{
>>>> +    __this_cpu_inc(softnet_data.xmit.recursion);
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_dec(void)
>>>> +{
>>>> +    __this_cpu_dec(softnet_data.xmit.recursion);
>>>> +}
>>>> +#else
>>>> +static inline bool lwtunnel_recursion(void)
>>>> +{
>>>> +    return unlikely(current->net_xmit.recursion > 
>>>> LWTUNNEL_RECURSION_LIMIT);
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_inc(void)
>>>> +{
>>>> +    current->net_xmit.recursion++;
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_dec(void)
>>>> +{
>>>> +    current->net_xmit.recursion--;
>>>> +}
>>>> +#endif
>>>> +
>>>> +#endif /* _NET_CORE_LWTUNNEL_H */
>>>
>>> Wondering what folks think about the above idea to reuse fields that
>>> dev_xmit_recursion() currently uses. IMO, it seems OK considering the
>>> use case and context. If not, I guess we'd need to add a new field to
>>> both softnet_data and task_struct.
>>
>> Why not just reuse the dev_xmit_recursion*() helpers directly?
>>
>> -Toke
>>
> 
> It was my initial idea, but I'm not sure I can. Looks like they're not 
> exposed (it's a local .h in net/core/).

Sorry, forget what I just said. We could indeed reuse it directly by 
including "dev.h" in lwtunnel.c.

