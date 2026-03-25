Return-Path: <netdev+bounces-271635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJVnB2sLxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:20:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9D328DC4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F05E324BC8E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB513BE156;
	Wed, 25 Mar 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oaFg8W4G"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6793E4C7F
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454198; cv=none; b=VaEjHuPjtiS/ASDnEz3/XwnLYhaz84XDUvPx3a1MWJPnB6hgPvTBggNj8/XPkLuC++firjVA/0N3tl7AGfYG8n6GQY1Zzpm94wrh8jZzNDQ7CLDXc//w9/39P+vimBSxgYa7oebk5oWh+v4EGDlpmo8EB1DhfZcL44e9o/pvrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454198; c=relaxed/simple;
	bh=MnLF2BW092870m8JOS99TONuPLd/v+VfS+gOcj7gBh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtBRa+SD7/mIjjkchxhD61ALeRR6TXe8y3c0ha1YmXYsKoQCdoqeTTv/AduEaxjtjVaeE7wSg2wXJCocBu+9U0O2JKdtNU7t6u/0xFLouKLa+eg2dGoS9gaVlboZWn2/VT9CB0OrTkeyaTpmDT+mE7pVL9XuoOcmG53O6b2Z2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oaFg8W4G; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ea6547d-aa47-4333-b569-3a10a8fa9988@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774454185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQbS9O4uUPm842EFQgAPtKP3lK4OJ+Bqn+4TFNMt+zw=;
	b=oaFg8W4GdtE6xdQxNy3f73/+QiRIMGb5MowHLggo6ur5z7y6QZZkrrNayjoC30urQrwCsA
	1mM4OijQKW1DugI8WQA9D9MUHETAM0XkFoLJvIqQoVELmrLwmHoQOqWJ6e3Pp9pEWnCTeL
	az7N+FGjS9BtehgeMk7MlcE83BxSdAo=
Date: Wed, 25 Mar 2026 15:56:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Simon Horman <horms@kernel.org>, Guenter Roeck <linux@roeck-us.net>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
 <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
 <20260323154825.1a2320c4@kernel.org>
 <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
 <6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
 <8486ce6e-ad2a-493d-b734-b40e8db9213e@redhat.com>
 <20260324143654.4dcec5a0@kernel.org>
 <9f169bf2-1d1f-4f7f-9f9f-0b90d06673e0@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9f169bf2-1d1f-4f7f-9f9f-0b90d06673e0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271635-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EF9D328DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/2026 11:19, Ivan Vecera wrote:
> 
> 
> On 3/24/26 10:36 PM, Jakub Kicinski wrote:
>> On Tue, 24 Mar 2026 13:59:19 +0100 Ivan Vecera wrote:
>>>>> In the hardware monitoring world one would have min/max attributes and
>>>>> one or more alarm attributes. I never heard about the idea of 
>>>>> reporting
>>>>> deviations, and for typical hardware monitoring attributes it does not
>>>>> really make sense. What would be a "deviation" of a temperature/
>>>>> voltage/current/power/humidity sensor ? Such attributes typically have
>>>>> an operational range, and they are allowed and even expected to
>>>>> fluctuate within that range.
>>>>
>>>> Ivan, my take on all the above is that using the HWmon interface 
>>>> here is
>>>> stretching it too much. I think it would be better to move debugfs
>>>> and/or netlink events.
>>>
>>> I'd rather avoid debugfs... My proposal is to expose absolute measured
>>> frequency attribute of dpll-pin and follow phase-offset-monitor
>>> functionality:
>>>
>>> So:
>>> * add real-frequency attribute to dpll pin
>>> * add real-frequency-monitor attribute dpll device
>>> * user will be able to enable/disable monitoring by enabling/disabling
>>>     real-frequency-monitor feature (similarly to phase-offset-monitor)
>>>
>>> Thoughts?
>>
>> I don't have a strong opinion. IDK where to draw the line between DPLL
>> and "random functionality some devices may have". We have 3 DPLL
>> maintainers, let's see what their majority opinion is..
> 
> I think that line has already been crossed by temperature reporting,
> which has been there since the beginning. Actual frequency measurement
> is, in my opinion, much closer to the DPLL world than temperature 
> reporting. :-)

Frequency measurements are DPLL-world properties indeed. Temperature
reporting was added as it has some influence on the stability of DPLL 
devices as well as on any oscillators.

> Anyway, I have the relevant patch-set already prepared, so I can submit
> it if you want to see it.
Feel free to submit, I'll be happy to review it.

