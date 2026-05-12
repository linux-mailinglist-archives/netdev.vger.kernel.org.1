Return-Path: <netdev+bounces-286880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIE0M0xyAmowtAEAu9opvQ
	(envelope-from <netdev+bounces-286880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:20:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61639517D3D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BCCD301601A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ACC1F3BAC;
	Tue, 12 May 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwSypuB0"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3413AD05;
	Tue, 12 May 2026 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545224; cv=none; b=rGgY4+mAlXjAKl1ww2MLs3g/yIux7KpESuzKsNbE27OCna+tZTAc/FSs7JXyEZ2qWTmxRUop75S3OLhNiXSAbsXq0iAtAcw37IazuJPFDHJ5I4I5wSnAfx88fz7Aameh2etVL2V5bWTnzdRXdTlpy/Ohx9eUeq/ABjxGnq0jLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545224; c=relaxed/simple;
	bh=lfYQGESk1pYjERlvde7/XCo/qKCsCSf/aFieokQBwLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEsOrG9NS7eqqLiVIYnw3Pr7UWWF1XuAH6XtRj7xFcp5R7fqjHgBtBwMshU1AtbdZiwiDkuCyuU9MrZM/GT3V1xiQG3a+OVWtymupgLY1QjSD4cV9q23egr2je2AowNUbCOZ2vZkvOFGygLTJZTAk9Ppr6J0FxYiPGnipIZLJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwSypuB0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abe0ffb6-0c46-4e6f-87e6-bd8be1407469@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778545210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBaPVTjD3puxjgiW7Y9T4J5M3RK9VooXxh/buPzfQ94=;
	b=lwSypuB0ep7PiRQwW6z5Ne89pZZHtvi92mljIsMUDARYzVFkv+DS9wyzs5P55sbNJwcShX
	KX69vQlmB8tIdIqFNGJ0d6HgPI3war5r/Txg02KLh6VqG9/N0rRVSOyFMj+nRBYANMzzGS
	JBD1Qp3+y15QDJYJGRPa8fl65QlCg48=
Date: Mon, 11 May 2026 17:20:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming
 broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length
 adjustment with GSO_PARTIAL")
To: Gal Pressman <gal@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <980382a2-3b8c-4da1-ac9b-efd8c0d2c1be@nvidia.com>
 <F03BE787-07D1-440C-81FD-F7B4D5F1E0C6@linux.dev>
 <9f601313-cade-4bd8-8e38-3777139de46d@nvidia.com>
 <677976cf-d438-4997-bfc6-2691e5579d2c@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <677976cf-d438-4997-bfc6-2691e5579d2c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 61639517D3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286880-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lizardbyte.dev:url]
X-Rspamd-Action: no action

On 5/10/26 5:38 AM, Gal Pressman wrote:
> On 06/05/2026 17:20, Gal Pressman wrote:
>> On 06/05/2026 10:49, Matthew Schwartz wrote:
>>>
>>>
>>>> On May 5, 2026, at 8:05 AM, Gal Pressman <gal@nvidia.com> wrote:
>>>>
>>>> ﻿On 27/04/2026 21:26, Matthew Schwartz wrote:
>>>>>> On 4/27/26 11:09 AM, Gal Pressman wrote:
>>>>>> Hello Matthew,
>>>>>>
>>>>>> On 27/04/2026 2:20, Matthew Schwartz wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.
>>>>>>>
>>>>>>> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.
>>>>>>>
>>>>>>> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.
>>>>>>>
>>>>>>> Please let me know if there's any additional info I can provide.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Matt
>>>>>>>
>>>>>>> #regzbot introduced: 5b4015ad833c
>>>>>>
>>>>>> Thank you for the report and the bisect!
>>>>>>
>>>>>> I will take a look and try to figure out what's wrong (though I don't
>>>>>> have real hardware to test on).
>>>>>> Is the userspace app open source? can I see its code and try to run it
>>>>>> myself?
>>>>>
>>>>> Thanks for the reply. The code for Sunshine is available here: https://github.com/LizardByte/Sunshine and the code for Moonlight is here: https://github.com/moonlight-stream/moonlight-qt.
>>>>>
>>>>> I have been using the Arch Linux Sunshine package which I installed by following the Linux instructions here: https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2getting__started.html, but there are also binaries for other distros or it's buildable from source. For Moonlight, I have been using the Flatpak distributed on Flathub because the client device runs an atomic rootfs, but you can also use any other device that Moonlight supports.
>>>>>
>>>>>>
>>>>>> I will be OOO for the rest of the week, hope to have some meaningful
>>>>>> reply by the end of next week.
>>>>>
>>>>
>>>> I think I see the issue, do you mind testing the following diff?
>>>
>>> Sorry for the delay. I applied this diff and I’m able to stream from my host to clients again without any issues.
>>>
>>> If you send this version upstream, feel free to add my Tested-by to it.
>>
>> Thanks for verifying!
>>
>> I will finalize this and submit a proper patch soon.
> 
> Hey Matthew,
> 
> I made a small change to the patch, can you please verify it still fixes
> the issue?

Yes, this diff also fixes the issue.

> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index a0813d425b71..71df45f9488a 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		       seg->data_len);
>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
> 
> -	uh->len = newlen;
> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>  	uh->check = check;
> 
>  	if (seg->ip_summed == CHECKSUM_PARTIAL)


