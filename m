Return-Path: <netdev+bounces-302566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+6HH8tOQmod4gkAu9opvQ
	(envelope-from <netdev+bounces-302566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A81F6D914C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:54:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=itRtvG7z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302566-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302566-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E32B301A7F0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75970364E89;
	Mon, 29 Jun 2026 10:54:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE8352C52
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:53:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730440; cv=none; b=aVU/UdwQfzwDOOeOkK6iahXf0x8pn/vB9VxW0lk6Ie6KSkALS2WdmK/7F+s8RholGZh5Q24kpzR/vbNijGB6cs4lyfIabODpLdlOhXTH6sdRG11m9/Jub7SZw9JUMVdKDpICWVsPPV/I1CntkoCL5yNOkj4qM6hJKNSQRLJtN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730440; c=relaxed/simple;
	bh=udyCZGNKqOQAWVNVNHMzg8tGuxWgDsieM7QYxqo7QUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef09BPHwGif5jBAo53mbNPTrsqVMxO2ujWUmeWyIAhfnNUTMpx9d3QIQzOAplhll+Q9eHhp5EosbMBI7+g89BMi5SMnr7A1dxfsNPveBGCKQ7qnq4ZJZgpLdNrizBM4JHQG1wUHCYPQHkjJqRqZT+noFH6XnIrTyv1iMVq7+hcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itRtvG7z; arc=none smtp.client-ip=91.218.175.182
Message-ID: <ad2b814e-d9f3-45db-8a3d-953b96f6c6cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782730435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haX9RCflfTGHuwSZYRJAFHPwWCml2J3/1/qlRjiXNuU=;
	b=itRtvG7zwfVSQ+mzbSnn0mJDQjPDbcgnHI2sfcWykQjRD2PTKAtPLF4dGpeRx2rDbRxIpq
	IziaPTzGJLyYMF4qGvCiP6VIpl6DXBRd+Ke0N1wZIYTG+PdfhnUD2mVl4CQzQC2xaeCCtO
	N7jQZgHCXHOgw+i0rOLKnwBjmuZJaI8=
Date: Mon, 29 Jun 2026 11:53:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
 <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
 <20260604081649.1ae5302d@kernel.org>
 <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
 <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
 <aiftnkuT9IP31qUm@FV6GYCPJ69>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aiftnkuT9IP31qUm@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302566-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:kuba@kernel.org,m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,intel.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A81F6D914C

On 09/06/2026 12:06, Jiri Pirko wrote:
> Mon, Jun 08, 2026 at 01:33:56PM +0200, vadim.fedorenko@linux.dev wrote:
>> On 04/06/2026 17:42, Ivan Vecera wrote:
>>> On 6/4/26 5:16 PM, Jakub Kicinski wrote:
>>>> On Thu, 4 Jun 2026 17:01:36 +0200 Ivan Vecera wrote:
>>>>>> Purely going on intuition here but feels like NCO should be a mode
>>>>>> (enum dpll_mode) rather than one of the input pins?
>>>>>>
>>>>>> More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?
>>>>>
>>>>> I had a long discussion with Jiri about this and we agreed finally
>>>>> that dpll_mode represents a reference (input pin) selection strategy
>>>>> mode and not a DPLL device running mode.
>>>>
>>>> Long discussion? I see 2 emails ;) Let's hear from others.
>>>> (thanks for the link BTW, _if_ there's a v6 please put it in the cover
>>>> letter)
>>>
>>> I called him... he explained me 'why?' in detail.
>>> I also appreciate others' opinion.
>>
>> Well, NCO mode means manual operation of frequency tuning. Does it mean
>> that different tunings may be applied to different out pins of DPLL
>> device? My assumption that it's not possible, and in this case NCO is
>> property/mode of DPLL device rather than single pin.
>>
>> @Jiri could you please share your detailed explanation on "why"?
> 
> Since the "why a pin and not a new dpll_mode?" question keeps coming up,
> let me try to describe why I believe that modelling NCO as an input pin
> (DPLL_PIN_TYPE_INT_NCO) is the right thing to do.
> 
> In the DPLL UAPI, 'mode' only describes the *input selection policy*:
> MANUAL means userspace picks which input the loop locks to, AUTOMATIC
> means the DPLL auto-selects the highest-priority input. I know there was
> some fuzz about this semantics in the early stages of upstreaming DPLL
> subsystem, but eventually this became very clear both in code and in
> kdoc:
> 
> <qoute>
>   * enum dpll_mode - working modes a dpll can support, differentiates if and how
>   *   dpll selects one of its inputs to syntonize with it, valid values for
>   *   DPLL_A_MODE attribute
> </quote>
> 
> NCO *is not* a third selection policy - it is just another *source* the
> loop is disciplined from. Except the source is steered by the host
> (via the PHC .adjfine() path) instead of being an external reference.
> Think of it as a virtual pin of some sort.
> 
> The object we already use for "a source the DPLL can lock to" is a pin,
> so an internal NCO belongs right next to DPLL_PIN_TYPE_INT_OSCILLATOR,
> which is already existing example of a similar virtual pin.
> 
> By having NCO as an input pin we reuse the existing model instead of
> inventing a parallel one. "Run as NCO" becomes "connect the NCO input"
> using the same connect/disconnect, pin state and pin-dump infrastructure
> as any other input. No new control surface, and it stays orthogonal to
> mode: we don't have to define what AUTOMATIC+NCO or pin priorities
> mean, and we don't grow enum dpll_mode and the supported-modes
> bitmask that every mode-aware consumer would then have to relearn.
> 
> For the pin info uAPI exposure we reuse the attributes pins already have
> - the output frequency offset from nominal is reported via the pin's
> fractional-frequency-offset / -ppt. A new device mode would need
> brand new device-level attributes for the same information.
> 
> Having said that, I think it's a perfect fit. The only "real" pull
> towards a new mode is that vendor datasheets call this NCO/DCO a "mode".
> But that is HW register terminology and we learned many times in
> the past that may be more or less misleading/incorrect wrt the uAPI.
> 
> Therefore my strong preference is DPLL_PIN_TYPE_INT_NCO, no new mode.
> Honestly, I don't really understand why it would make even little sense
> to have this as new mode. Perhaps I'm missing something, if you can
> describe it, that would be awesome.

Ok, I see your point. Even though the pin UAPI fits the model, I still
have some concerns:

1. I cannot really imagine AUTOMATIC mode selecting NCO pin by priority
in case other pins are gone somehow. It doesn't make sense without
steering SW running on the host. And the other way around - switching to
a higher priority pin while SW is keep "steering" DPLL. But looks like
we have discussed it in the other thread. Adding DPLL mode restrictions
based on pin selection/connection breaks the model, I think...

2. SW steering cannot be pure SW. Every disciplining algorithm relies on
measurements, the product of phase comparators. That technically means
the device has to have other inputs configure as monitor, which can be 
configured in AUTO mode with priorities. How will we model it then?

Thanks,
Vadim


