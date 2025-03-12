Return-Path: <netdev+bounces-174185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55DA5DCBB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB273AC94A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0B243969;
	Wed, 12 Mar 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="zp4yLI8x"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880C1F949
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782739; cv=none; b=fHx3Y3Vz/DZHfL8LqduJhD5kxy8qPxeY9CIDasmOsoApFPdcaCCGHEr9aPSMrn9RFZ8fvrjsT6e5m1u3NRv7Z0u16oQMeTW0YOZuavGfGbqpmz6nUVf1eqZZwuFCOjD87hjsarrQTTIYPw1N6GZX5MM1RJn/XbmW0HQ7goweCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782739; c=relaxed/simple;
	bh=bsBprs+QrXYXvTFYFNv5PjeUFkEKtlBdy5crmEJcD8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3nlHo3KL+5JO4P4lL5IdegJU3/izToUj7ExX8ZhoUp/mQ5ENesFP5t1U4Lr+6DtxfhRNMOiKSZMMgYNlZio3DSEazLTwsfmv2Imj5gHxH8J1APnoxg44h9oqecUu/p3qfBN2BLwBoYwMBbLH+y8IvyoXlwvAwd4Xs2dQLJdies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=zp4yLI8x; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.0.223] (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 89F65200EEC2;
	Wed, 12 Mar 2025 13:32:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 89F65200EEC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741782734;
	bh=c2wryMfWs+1n980iE4u39zUMY1TL4q1m1nHgV+n7FaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zp4yLI8xqnmIV//V6KlM/tf4xPenghfkDo0GwuYG9W5vGciefZhsN5dnNv9bxtGOx
	 JUa9FwUKjgIJdcKg4DWU3aroqfcZPftxp8CyorD16LV2nFCXIPMLTWfGs3Qe+JuSZ/
	 frBK4JXM2bHeBCiDzICSdtKaedZFwRDL2UUP0OqAbbxjDBe5mueso29o4s9f5swGlG
	 Z/ZJk+0bltiFe0lM6gBrekAkSsuVyDHdWoJCHvmsTkWM0v6+XIHp2JPoUGfb2ZSf6y
	 52BpCT0iHnZSXtdOqO8Fgj/Og/j/a38Kgd+Cv2QkEdZHXz/biP0nl+pgGnpt9wqKyi
	 emTmzunknh1oQ==
Message-ID: <1c585bdf-ebcc-40db-bd36-81d008cf6827@uliege.be>
Date: Wed, 12 Mar 2025 13:32:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: fix recursion loops
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250312103246.16206-1-justin.iurman@uliege.be>
 <fb9aec0e-0d95-4ca3-8174-32174551ece3@uliege.be> <87y0xah1ol.fsf@toke.dk>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <87y0xah1ol.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/25 13:29, Toke Høiland-Jørgensen wrote:
> Justin Iurman <justin.iurman@uliege.be> writes:
> 
>>> --- /dev/null
>>> +++ b/net/core/lwtunnel.h
>>> @@ -0,0 +1,42 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>> +#ifndef _NET_CORE_LWTUNNEL_H
>>> +#define _NET_CORE_LWTUNNEL_H
>>> +
>>> +#include <linux/netdevice.h>
>>> +
>>> +#define LWTUNNEL_RECURSION_LIMIT 8
>>> +
>>> +#ifndef CONFIG_PREEMPT_RT
>>> +static inline bool lwtunnel_recursion(void)
>>> +{
>>> +	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
>>> +			LWTUNNEL_RECURSION_LIMIT);
>>> +}
>>> +
>>> +static inline void lwtunnel_recursion_inc(void)
>>> +{
>>> +	__this_cpu_inc(softnet_data.xmit.recursion);
>>> +}
>>> +
>>> +static inline void lwtunnel_recursion_dec(void)
>>> +{
>>> +	__this_cpu_dec(softnet_data.xmit.recursion);
>>> +}
>>> +#else
>>> +static inline bool lwtunnel_recursion(void)
>>> +{
>>> +	return unlikely(current->net_xmit.recursion > LWTUNNEL_RECURSION_LIMIT);
>>> +}
>>> +
>>> +static inline void lwtunnel_recursion_inc(void)
>>> +{
>>> +	current->net_xmit.recursion++;
>>> +}
>>> +
>>> +static inline void lwtunnel_recursion_dec(void)
>>> +{
>>> +	current->net_xmit.recursion--;
>>> +}
>>> +#endif
>>> +
>>> +#endif /* _NET_CORE_LWTUNNEL_H */
>>
>> Wondering what folks think about the above idea to reuse fields that
>> dev_xmit_recursion() currently uses. IMO, it seems OK considering the
>> use case and context. If not, I guess we'd need to add a new field to
>> both softnet_data and task_struct.
> 
> Why not just reuse the dev_xmit_recursion*() helpers directly?
> 
> -Toke
> 

It was my initial idea, but I'm not sure I can. Looks like they're not 
exposed (it's a local .h in net/core/).

