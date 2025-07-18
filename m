Return-Path: <netdev+bounces-208100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA6B09D6B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 10:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0917B7D20
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 08:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA92264D2;
	Fri, 18 Jul 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="Ms8UgGYP";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=anthoine.bourgeois@vates.tech header.b="Dvgz0M3q"
X-Original-To: netdev@vger.kernel.org
Received: from mail132-21.atl131.mandrillapp.com (mail132-21.atl131.mandrillapp.com [198.2.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1F220F34
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826232; cv=none; b=lzqQ1xB3ChlequLv/t3x3p3MkTFOPZ+xVygTxDft5CTZJD+BAVP4EXvYbwO2KPUnUZOsYKrrTP9y7Q3tpqEHaHJ0FsnWL5p97UTqaXewgq2CPQpcY2RwpAZJ5OGDXp4kz/ihI/s1HzvVrUAhj3BnYnBHgtkm6jmwk+woKmnB310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826232; c=relaxed/simple;
	bh=1d3PpO0q077xRQs9WQqLKRGtVTC/vWISiu3MTSGnUzw=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=FDNKkCJMcPt2zIhiDTrSnvbU4U2zSnZhY4wXGPuz26Y43ovHO2wCEmVhAcJlaI178OJOj90+UR0O/8zJUMyFjDHOgvoqG3KW3Q2U0o/m16bREsiOf3IVW7CiM19QwGty5iapOfsbPcypRULVz3Bz3ukfTXV4jlLje463gkvW3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=Ms8UgGYP; dkim=pass (2048-bit key) header.d=vates.tech header.i=anthoine.bourgeois@vates.tech header.b=Dvgz0M3q; arc=none smtp.client-ip=198.2.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1752826229; x=1753096229;
	bh=9v3RvNn3og/vnGMjRNCHbK2EsjnkNsgZix1oMc/Rcns=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=Ms8UgGYPKIWHXIgawYLIOUOGw3+mP+x1OP6dEPonV0fgHt34+8Mbs/fPwjcm8zBJz
	 xVxhhdMLyaZZ9kXucXjjmmXpl9e9FN5p25ZX77lZz+L8AUC+bs/p50x4KqRhiDq5Ss
	 7rKSTyKO/4rEXtuQ8okU0qmv4blTlWsW76Y0vidxBc54ZqOMQso9IIN8pCfgg0knpd
	 vskyg4m8I4n/R784yCU91p4Hv56FARToVLWBCOoEi1ZPJ6iUQvt2J3ayUf6Ke8jmWX
	 FMCMZ52F2CP8f8ToQOVndjp6bpcVKgvmdkNfZWOtG2GFgGfttDQRVzv+s5T3+oTtD/
	 HQ/7le80XOROg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1752826229; x=1753086729; i=anthoine.bourgeois@vates.tech;
	bh=9v3RvNn3og/vnGMjRNCHbK2EsjnkNsgZix1oMc/Rcns=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=Dvgz0M3qc4LbJ8GzauIZmGqjpLj0CCAAX8UoAV1e/OgdP+SeuMaASAIc+xreRTfSL
	 5Lh6dTsV9d+lqOs6CnyQ6Y65mr0bFW/n325SRdBdlU3VKtNQLT6uFk6hdc5daCuoT8
	 7TVjDUUYswne5oC8L5Dx1GxC97WSDGWxdMjIIFnuFUc4vLGEYUvMRtSIYWdgJhnRfJ
	 4Fg+BU60PuyPEBTG+7KIq/Giui63iUI7ltnFaO4D9z0hiVkvmspVR/GGPAwko6UXMh
	 jDfahwuWUffynsHhAPXMz2z6pNQ86H/QUVlVWf5KAI0hiCfFcGGVoow4ojJh4hE8Cf
	 nGdhQVxWnIoOQ==
Received: from pmta09.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail132-21.atl131.mandrillapp.com (Mailchimp) with ESMTP id 4bk2Xj1Jppz1XLF4g
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 08:10:29 +0000 (GMT)
From: "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v2]=20xen/netfront:=20Fix=20TX=20response=20spurious=20interrupts?=
Received: from [37.26.189.201] by mandrillapp.com id 65a60f28e7d441048fd4f1adbe603a61; Fri, 18 Jul 2025 08:10:29 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1752826227429
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Wei Liu" <wei.liu@kernel.org>, "Paul Durrant" <paul@xen.org>, xen-devel@lists.xenproject.org, netdev@vger.kernel.org, "Elliott Mitchell" <ehem+xen@m5p.com>
Message-Id: <aHoBcULQVVsbx6XO@mail.vates.tech>
References: <20250715160902.578844-2-anthoine.bourgeois@vates.tech> <20250717072951.3bc2122c@kernel.org>
In-Reply-To: <20250717072951.3bc2122c@kernel.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.65a60f28e7d441048fd4f1adbe603a61?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250718:md
Date: Fri, 18 Jul 2025 08:10:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On Thu, Jul 17, 2025 at 07:29:51AM -0700, Jakub Kicinski wrote:
>On Tue, 15 Jul 2025 16:11:29 +0000 Anthoine Bourgeois wrote:
>> Fixes: b27d47950e48 ("xen/netfront: harden netfront against event channel storms")
>
>Not entirely sure who you expect to apply this patch, but if networking
>then I wouldn't classify this is a fix. The "regression" happened 4
>years ago. And this patch doesn't seem to be tuning the logic added by
>the cited commit. I think this is an optimization, -next material, and
>therefore there should be no Fixes tag here. You can refer to the commit
>without the tag.

Ok, you're right the cited commit exacerbates a problem that was already
there before.
I will change this in v3.

>> @@ -849,9 +847,6 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
>>  	tx_stats->packets++;
>>  	u64_stats_update_end(&tx_stats->syncp);
>>
>> -	/* Note: It is not safe to access skb after xennet_tx_buf_gc()! */
>> -	xennet_tx_buf_gc(queue);
>> -
>>  	if (!netfront_tx_slot_available(queue))
>>  		netif_tx_stop_queue(netdev_get_tx_queue(dev, queue->id));
>
>I thought normally reaping completions from the Tx path is done
>to prevent the queue from filling up, when the device-generated
>completions are slow or the queue is short. I say "normally" but
>this is relatively a uncommon thing to do in networking.
>Maybe it's my lack of Xen knowledge but it would be good to add to
>the commit message why these calls where here in the first place.

Good to know how it should "normally" works, I'm not an expert.
The patch also has the advantage of standardizing the network driver
with other Xen PV drivers that do not have this reponse collection
outside of the interrupt handler.

As this part of the code is here since the driver was upsteamed and the
author no longer works on xen, I will do my best to add my guess on why
this code was there.

Regards,
Anthoine


Anthoine Bourgeois | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


