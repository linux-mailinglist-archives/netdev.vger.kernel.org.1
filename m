Return-Path: <netdev+bounces-287990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPqSGgXbBWrAcQIAu9opvQ
	(envelope-from <netdev+bounces-287990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A09E543089
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2717830817DC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C5E3DDDC2;
	Thu, 14 May 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oHcE4wn4"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F2428837
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767776; cv=none; b=Fq6AwQscdcmiZZNP972UzCpPFmHu0bsTU4A0yPdDcHfoB87mjB06HNWrijFyHUlxdi2xh13K9Z6R72d6Rr6MvNtm/RUvnDtPC3VUBA5ndIfziLw/fsyMLOsAphj/ZNMtocVRrqegRsns4kBfjZEEi96zEVrQuJhuJ+RgXy+QUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767776; c=relaxed/simple;
	bh=VZe7viTjyyuvoeg4TEvS6pWNba6qbS1ennxYCshmPbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWwnkoiYJoePbYjOU0HsjsGdCVtTwSeq5SJ4doP3/ezS0KGUakWpdPcQrllQgiUffSyyFZ9P2qXz7zILZ/ANVoKWiOCuFhX08vfH5r5N/05i5oBYd8xVGKJu8pggdtChYQFSP+yVaCjMSgd06s1OqH9a5cqVfzguM3/C2zy5QrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oHcE4wn4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <174e2370-959e-4b41-ab55-8058b84a12f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778767760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3/oAeJ+mSCafBgEIshGhkz6UcGuH8qgDexlJq8w9tQ=;
	b=oHcE4wn4DtcHOwgvBlagGPKGttGhrqPo4VMPj8SWZo/8qKwNP15R1GalXVb5uMhVUKhv1a
	P5tPEqidchyWXU5eUYwY4jZrQ9+q9cqGi98/iimdeKQrypeMKvlmD/EaXCV68bx7CX9lx7
	sOpdy9555Iv+bHCf0l2eEggvn5hMLAc=
Date: Thu, 14 May 2026 15:09:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] pps: make number of PPS devices configurable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
 <20260514065526.2ed937dc@kernel.org>
 <65a3d091-0648-4c6c-8062-869d0fcec8dc@linux.dev>
 <20260514070804.7cbb6181@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260514070804.7cbb6181@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6A09E543089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-287990-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 14/05/2026 15:08, Jakub Kicinski wrote:
> On Thu, 14 May 2026 15:03:03 +0100 Vadim Fedorenko wrote:
>> On 14/05/2026 14:55, Jakub Kicinski wrote:
>>> On Thu, 14 May 2026 11:26:14 +0000 Vadim Fedorenko wrote:
>>>> Modern systems may have more than 16 PPS sources and current hard-coded
>>>> limit breaks registration of some devices. Make the limit configurable
>>>> via Kconfig, keep default value of 16 devices. UAPI has to be changed to
>>>> support maximum possible number.
>>>
>>> Hm, since this is effectively just sizing an IDR maybe we should just
>>> bump it to 64? It appears to cost nothing if not used.
>>
>> Just bump to 64, but keep it constant? In this case maybe 256 just to
>> align with the max minor value for chardev (in compat mode)?
> 
> That's fine too (the value is the count right? It's not the max id?
> Cause 256 would spill out of u8)

It's the count. Max id will be 255.

