Return-Path: <netdev+bounces-275883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BqbHMS01GnvwQcAu9opvQ
	(envelope-from <netdev+bounces-275883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:39:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9D3AADA0
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C2CB3004928
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2536396578;
	Tue,  7 Apr 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF3LWp9Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q6jTP4bB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920021FF7C7
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547584; cv=none; b=uWF+qmjDUMgqMppCqshBy7WjnvgMKQOJ6Kf7uGb4Uv2T+2J8K7ick8ihKUc/XktHbXi1t/7bQ5mdNCssNtUarVTsC5fBgrkLRJ7Ef3PFxhDiHaCW7shvtjVkVBgY8GLALGcfcphJPDFG0/LI1qDTxaOe9FH6DaaqHI01Y4UtAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547584; c=relaxed/simple;
	bh=cPsWVGJL91FOqVZKuMWRjh5dQAInBzIlViEXFFbP/U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LawfzC8cQCqDJnqCuJcWfeUoLFVVGl/5Q+d3NuHBp6RcwByfKtOX2MPA+W4WOvOaGmZEKH35J194Kcy9mH5/oiCr6W/Gqdkgq8n7+/oRe4WVbiP1g5CSIE5P+9fz6AG6eN0Q4BhqU1Mes5ykrVXAj7BfdKzc7qtaR5ZYvj3IpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF3LWp9Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q6jTP4bB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775547582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxu8wHUEuKFQbfI/u2QXamS7QchNDC4ISphJlVmW50s=;
	b=JF3LWp9YaK70UNDrhY0jzmJb3eYczBbSTHX7p7IfyK4C26dn5rWavM8zOrBCtUW5v4YLE2
	Lq3nnhXj1oRTYp+qPeXHgH2CobOl5UbX8/+7FZZHEQi9OKnq6tHq6VIHjjapo0Fvzd6U/e
	9k/+vX0KY9WaGSkxMZRfpQRTH9MjgSo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-peqJwPGpOvSEXsQXFreabg-1; Tue, 07 Apr 2026 03:39:39 -0400
X-MC-Unique: peqJwPGpOvSEXsQXFreabg-1
X-Mimecast-MFC-AGG-ID: peqJwPGpOvSEXsQXFreabg_1775547578
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d15f2e0f4so4249614f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775547578; x=1776152378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxu8wHUEuKFQbfI/u2QXamS7QchNDC4ISphJlVmW50s=;
        b=q6jTP4bBKH/8lAF3aSHiF09ZV/Mr9CqmFDUY1sN7bq7LA5z5wt12mSRcWgW7mAiZ7l
         vvOdLsFZeZVm/DkOTRGvlbhqexfDC8MAGE4K236kKtVZ+PKX7z/DS5eI32a+SVyghh5Y
         O71z1vu23Vm04eG5IxOJLQ2VeI/4kmrHUfyNxHwWcRIE99M+A1JpZOEeQxMyvi7v/5Z3
         FnUzwBjPclF552bkeJIi6iZZfGAN2zgskHPRbnZ8zM8p55u6EBSVv4c4+O91fE3z34eX
         rV5quPyuHcKquoMAgPrlYJSPjj4rH1eOhgD0KC1OYgrVpL4hF6UvddqD6SvM3KImeNtG
         sJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775547578; x=1776152378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxu8wHUEuKFQbfI/u2QXamS7QchNDC4ISphJlVmW50s=;
        b=rH9DrmcIGE4RKaHP6ZRMlos2PIvT5N7c7aklVRiH5rhZAD1LF98QWCuZc+23faCDIw
         F10ZZH2qzDAfVTa1PKTQc8s0yhC8Cs9VxlPwfZrbV4Ayd5S6AuFyNO29IsoKV8sSc3/i
         r/gJPtDRLZ3AsJduviUoZlNBUaAyZmaI55tm0/iIb88lp9TNmhhj3eTvV79TZFlV1LiZ
         4T+llz3s9M2Y/I6kaS/p7JVKntn7S49yqPqizcac1oof+h6msjVX9XEGw9pUUqrDoVku
         ZvI57Yf+Cila6HVmRRUehgtIX++m+FUBizKpjx7adjyQEmu+rpGClCcLV9LPOYTApMsm
         TGYg==
X-Forwarded-Encrypted: i=1; AJvYcCWcDszSXbnIN/S7/TX3dwEH/z/UpTULTualiUoVV956EQK/8z1I93oqTw3gzxh5RBFa3Z5PwNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1NqthbGDSd4K4H2ktliAtjeSrEEVLMluUw6mV68IY0oFbVW+7
	MwaaKe8Wr7FkiwrjmYRn2Tub865wtQ24PP6FgkiUM5n6moYi1BgAuNiNsPcMticdHYUObkbvGCa
	rbi699bquayWI/UtZN56W9lfPdgujvQjWaaTLAAHf5CfKFwumGnTwcsLbYA==
X-Gm-Gg: AeBDiev57Ll6soH/qqseOThnOl3L/kvhucPzK3nrZEc9gcQs9RTTvGslkGTQBhXGBmC
	r/lwd9FIDGpUyNBeIDEpjiorQZW4kdkPVloI2CxCV2IkQyeLNo325llTP42MFIiysjTBdwvP9tH
	u/IrHskLM0hOqX/oW6pzSdk0au0/2Sf060qIEkP8/4zofr+O27P1/iWypk+QXY/XGbJU2TAeifn
	PWvq6I/zuoRVzMVzDKUQTjFHA7ir4L7ENiHkEtoOqvoc/e7i21cklS4qwoO1SKSAVaCIVymbyjs
	Fziv5U0rJHgufSjNK2W48xO1dW5p+R6rqh6TJyAJwp+NlZxEJu09mp9RWz130eEwkLwfSrfBp+G
	s3y40c0AFPm8R0s9frFqi867+/At9l7nnp3EAK7OzJfy23SotB6N9p9Kqwg==
X-Received: by 2002:a05:600c:8b84:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-4889978c50bmr226111505e9.16.1775547578132;
        Tue, 07 Apr 2026 00:39:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b84:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-4889978c50bmr226111065e9.16.1775547577605;
        Tue, 07 Apr 2026 00:39:37 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c1c5291esm4013165e9.15.2026.04.07.00.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 00:39:37 -0700 (PDT)
Message-ID: <7c32d1c0-563f-41d4-8698-92ffc7682a4f@redhat.com>
Date: Tue, 7 Apr 2026 09:39:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/11] net: tunnel: introduce noref xmit flows
 for tunnels
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260312155657.25676-1-mmietus97.ref@yahoo.com>
 <20260312155657.25676-1-mmietus97@yahoo.com>
 <726e1d40-6a29-4e6f-964c-1a4d0cf7d4eb@redhat.com>
 <bbb2b833-a9a9-4558-8d4b-1b041f6706d7@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bbb2b833-a9a9-4558-8d4b-1b041f6706d7@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275883-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,vger.kernel.org,queasysnail.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11F9D3AADA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 9:58 AM, Marek Mietus wrote:
> W dniu 17.03.2026 o 12:37, Paolo Abeni pisze:
>> On 3/12/26 4:56 PM, Marek Mietus wrote:
>>> Currently, tunnel xmit flows always take a reference on the dst_entry
>>> for each xmitted packet. These atomic operations are redundant in some
>>> flows.
>>>
>>> This patchset introduces the infrastructure required for converting
>>> the tunnel xmit flows to noref, and converts them where possible.
>>>
>>> These changes improve tunnel performance, since less atomic operations
>>> are used.
>>>
>>> There are already noref optimizations in both ipv4 and ip6.
>>> (See __ip_queue_xmit, inet6_csk_xmit)
>>> This patchset implements similar optimizations in ip and udp tunnels.
>>>
>>> Benchmarks:
>>> I used a vxlan tunnel over a pair of veth peers and measured the average
>>> throughput over multiple samples.
>>>
>>> I ran 100 samples on a clean build, and another 100 on a patched
>>> build. Each sample ran for 120 seconds. These were my results:
>>>
>>> clean:      72.52 gb/sec, stddev = 1.39
>>> patched:    75.39 gb/sec, stddev = 0.94
>>>
>>> TL;DR - This patchset results in a 4% improvement in throughput for
>>> vxlan. It's safe to assume that we might see similar results when testing
>>> other tunnels.
>>
>> Sabrina noted I wrongly replied on an old revision. Reporting my
>> statements here for completeness.
>>
>> IMHO this performance delta is not enough to justify this amount of changes.
>>
>> Additionally, the measured impact of removing the dst_hold/dst_release
>> does not fit with my direct experience on the same matter: it should be
>> below noise level in practice, as dst are per-cpu and and no
>> contention/false sharing is expected in a good setup.
>>
>> I think you are observing larger impact because in the veth test
>> dst_release can happen on a remote CPU. Note that this setup (vxlan over
>> veth) is not very relevant in practice.
>>
>> I'm sorry I'm not applying this series.
>>
>> Side note: if you are interested into improving (UDP) tunnel
>> performances have a look to big TCP support work from Alice Mikityanska:
>>
>> https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/
>>
>> /P
>>
>>
> 
> Hi Paolo,
> 
> Could you clarify what would be a more realistic test setup? I'm assuming using physical interfaces would yield more realistic results.
> Also, what performance benefit would be worth this kind of "code churn"? What kind of margins were you looking for?

veth devices hides a significant part of the memory buffer lifecycles,
as there is a single allocation/free for both sender and receiver. Using
reasonably fast/recent H/W NICs would make the figures much more relevant.

Given the amount of changes included in this series, I think that a
performance improvement well above the noise range in a relevant test
case would be needed to justify it. If you really want a figure, I would
say 5%. Note that the main difference WRT your testing is the setup itself.

To be completely open, I don't see how the refcount change could come
near such figure, as in my testing on H/W NICs the total reference
counting cost is usually well below noise level.

/P


