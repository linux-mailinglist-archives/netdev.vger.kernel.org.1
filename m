Return-Path: <netdev+bounces-297008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EOdMKk3sJ2r15AIAu9opvQ
	(envelope-from <netdev+bounces-297008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00865EFB0
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:34:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=m3DTe6L8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297008-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17B85302D302
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DA378D76;
	Tue,  9 Jun 2026 10:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3B215075
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:25:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000716; cv=none; b=nytXVBMYONsBz3MixmKQkjB+Qj/I/E7RGv9bkZHpC/QqF52EraW7pO+Vx7kQTekvcRCN+3l0y20tT9Vk3Qb7Nin49GEeOsAaFhwZhvYxphXXD2XQWoA7KNKGXKwsheJovaLNMyC9nGUQQExFUYRWYKEqP9xSpQQCWh1U6lK0npQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000716; c=relaxed/simple;
	bh=HmV9PN+Xoys8KUjTyWPoNDvsxkzG/AwM6lFM1ni+rro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbG3uaWzHO8Ej60HTHVDT/qCYMsvGcH/m1dIfPh/BVLy/UPzHzpoCG4kFr+erZUGG4OJZ8TOfioYsO17SgAqCz/5hJfp9TU4mvtwf9NAwCaeP/G6WUBE8oCM6+Ox/QlU2hN4RSzMZks8swxHqfgCEBxQQMLRkl94udvvojAqLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3DTe6L8; arc=none smtp.client-ip=91.218.175.170
Message-ID: <b8e9aaed-3256-4501-a164-19a00f03d296@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781000711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHP9STYuApztcYR4EQHJ4/WZi2PkNPsO7JDes4+ASs0=;
	b=m3DTe6L86yPrOwJEWhjtjhyV29EI6PjmRc0MWFEYgHumMmqrp/uhz0IcqtFDNwpeS3Fa71
	sQG0KPpRtqQtbnaXzlOqq+IHZY7IgjIrC0hViUMy+NbjWJwIyBzd+Pv3LRC9pFlW8NG6z9
	28Y9eoAOCmvtYqd441U/HSG672y00FY=
Date: Tue, 9 Jun 2026 11:24:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
 <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
 <20260604081649.1ae5302d@kernel.org>
 <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
 <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
 <9b493ce2-6213-4a29-aeee-b473b6b16fa1@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9b493ce2-6213-4a29-aeee-b473b6b16fa1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297008-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:kuba@kernel.org,m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,resnulli.us,redhat.com,microchip.com,kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D00865EFB0

On 08/06/2026 16:30, Ivan Vecera wrote:
> On 6/8/26 1:33 PM, Vadim Fedorenko wrote:
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
> 
> The NCO pin is only one per device... When it is connected, then the
> device the pin is connected to is switched to NCO mode. In this mode
> the device is not locked to any input reference and the driver allows
> tuning of the DPLL frequency manually via PTP interface.
> 
> Such tuning is applied only to output pins associated with this device
> but not on others.
> 
> Examples:
> DPLL0 is driving output 0-3 and DPLL1 is driving output 4-7.
> Then if you switch the DPLL0 to NCO mode (makes NCO pin connected to it)
> then frequency tuning (via PTP) has only influence on output 0-3 (the
> same tuning is applied). Outputs 4-7 are not touched as they are driven
> by DPLL1 (that can be locked to some input reference).
> 
> If you switch both DPLLs to NCO, then frequency tuning for DPLL0 affects
> output 0-3 and tuning for DPLL1 output 4-7.

Technically speaking you have described per-device behavior. And NCO pin
can technically be virtual, just a configuration option via normal
device communication channel. Doesn't feel like pin's attribute. Back in
a days of DPLL RFC patches we have discussed the option with Arkadiusz,
AFAIR we were leaning towards per-DPLL state for this case.

