Return-Path: <netdev+bounces-280441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPycLf3e6GlDRAIAu9opvQ
	(envelope-from <netdev+bounces-280441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7DE4476C9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A2B3021E50
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D003ED5DD;
	Wed, 22 Apr 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maQMtoBB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45453ED5CD
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868849; cv=none; b=ESxzP3jmh6TDSsGJ9SU0cgyTl8xUK6btMat77MUOtQqusI2NTey3WqMD2KlrSJp6RidoSxGn4DivmuS7vjRITUjZI8XOal9skUjpm+36vwGVbXWT+37j/gK4a6bs78AiwyceWCZrJQ4HYMC7FJKOnYboDRKbvvB2QimvtJPCFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868849; c=relaxed/simple;
	bh=J21LH+Dp+zybi9ZNroCMtjrrLJ0ZBG03uhOHh7zzmmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NoQMw4iKuEOtlTMDvCVcKLZNmBTtZXZKT0OoO/5xrkyI8atG1rcTJIib0s4tnmX9ppaUHzTy3wcypcAEgP/2w3WE2wRm9KjvG9M9Ps1K3yeiAC27YdfybHBrd07tTYIPHCBWRAJJTldPtNg9avSXtoKQ7SmTgY4sLbPfzkD8Sqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maQMtoBB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2333015a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868848; x=1777473648; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J21LH+Dp+zybi9ZNroCMtjrrLJ0ZBG03uhOHh7zzmmw=;
        b=maQMtoBBkNNYO9S6MIvaTza00WIZ1O2ZrIAz3EqANrIJFkQs06+1/Kl4LdG87GChgF
         RE0uX7Xlf7P1aqzgW1RQyvzTI+R7kmTIw0vFzO7uo2zU1u7+XkfDfDWLlrp1VTq3oIrA
         EGnt8Nk/47SCBUFvaY7WJkwHuSnO0bYK6X2JkfNo5r4k54lUqB2zClE54QdDE/d6JbHC
         lXa18xJgQFtJROXkjmThGgTyWg5qvfedgDm5RdkhmPOiGAV3pguLx1V4gqrIl1CU7NVO
         1HF9RzCYd64FLu/Xw+g8TAis2Sn/eLsBDqjNEifoyU3uPVSTJFzipb8jrflkaNKviCbl
         BCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868848; x=1777473648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J21LH+Dp+zybi9ZNroCMtjrrLJ0ZBG03uhOHh7zzmmw=;
        b=ZeK8uDxaHoPttcUEECW0yKzYdsJROaBB/J6HfblLrCug1qFS2aaSplaP29sxBzy20i
         x9IZ/UlAHuDWr94k8RcpYtNEfjTe7/V/3lav4cMWxdan8aNVkIP8b/qaht/WQwM0aaIt
         IGuo/9mkKx1i/Zjb+8rgMxGj9TFK3aGaTObc8ogeDNzOGJb1h0+ouOwFKr3616v5aoZc
         miXWhiR4hsSgP/B0gxaV5XOa/oWSgAeNm517utzz2Gf6jgthoxeh/fgbZ/guCNTCY0Av
         ppLEIAhiVxQReLvATcHMW0n/F+h2LeThcOLzcDxKn1uEXSBtAfOeSo8VOu82yi9+GZ6C
         wCEg==
X-Forwarded-Encrypted: i=1; AFNElJ+Jz8Trw5ige0PUMm/vgRojp08dkxRJyjEprS1WaAQIGfSsp1/y5oTvzIKsDsc+X8nfu+OLaV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQxsOjdnLzR+kepzHve97hUs2cDmvftDtZWV55dhac2b60TMo
	0QioV2z1ew2Zp/0tkc9N+AEuxb9m6L9fMswaV3VxUnR9r2LGMYO6P/hq
X-Gm-Gg: AeBDieskMG23mHMVa40VFo3awXww2idxKyPgRKzys+3GwWXWm6u5auFTWM7ORsqHA2E
	w6wnVjNxTfeMygh8PxOVGzxHM7NsHt5uLAbcPVU0nMixHKfpg7KeHG3shPEuoRhfcS+7UyGzfVX
	TVor+TKaXu3muuX3EgnbOZPPxvp/eooeuUWNEFs4zyFB2D5/scHlpj7YnEIYImJk6EU39XsoTBy
	xMxiIy9ZusEyhBy08P9SHILwljtDJydIJ6J20Ln4ZgFEnN1nQo3MudkNWjSmSyWrpmTW55KXOpg
	uLfp7H0l3HtzKLR5sQTbrO2dR29P+kXV1qLvwsyK3XxL+7M2XHbiqAfJPgH+0t6jHbCBDzfiSDG
	mAKmNEt1JuWC1r732u8xAQO9Optu9R6j0wbv8Rao/HhTEgGbZoh1mLHVtOuZL91NES9DnqJZ+CY
	eulHt/6n4PrIcg1mF6VFZE0D4zYHt+hvJr1URAFw==
X-Received: by 2002:a05:6a20:3c89:b0:3a2:d976:2210 with SMTP id adf61e73a8af0-3a2d97637dbmr12095114637.8.1776868847905;
        Wed, 22 Apr 2026 07:40:47 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f4e8sm13072359a12.1.2026.04.22.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:40:47 -0700 (PDT)
Message-ID: <dfbb7837823c2ffe0f6b1bdbfbaae71164cd7ba6.camel@gmail.com>
Subject: Re: [PATCH] mptcp: do not drop partial packets
From: Shardul Bankar <shardulsb08@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, matttbe@kernel.org, martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev,  linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com
Date: Wed, 22 Apr 2026 20:10:42 +0530
In-Reply-To: <fc2ca10a-1fa8-48f8-b140-6c59595fc08b@redhat.com>
References: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
	 <fc2ca10a-1fa8-48f8-b140-6c59595fc08b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F7DE4476C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDE1OjUxICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToKPiBP
biA0LzIyLzI2IDI6MDkgUE0sIFNoYXJkdWwgQmFua2FyIHdyb3RlOgo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgLyogUGFydGlhbCBwYWNrZXQ6IG1hcF9zZXEgPCBhY2tfc2VxIDwgZW5kX3NlcS4K
PiA+ICvCoMKgwqDCoMKgwqDCoCAqIFNraXAgdGhlIGFscmVhZHktYWNrZWQgYnl0ZXMgYW5kIGVu
cXVldWUgdGhlIG5ldyBkYXRhLgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gLcKgwqDCoMKg
wqDCoMKgTVBUQ1BfSU5DX1NUQVRTKHNvY2tfbmV0KHNrKSwgTVBUQ1BfTUlCX0RVUERBVEEpOwo+
ID4gLcKgwqDCoMKgwqDCoMKgbXB0Y3BfZHJvcChzaywgc2tiKTsKPiA+IC3CoMKgwqDCoMKgwqDC
oHJldHVybiBmYWxzZTsKPiA+ICvCoMKgwqDCoMKgwqDCoGNvcHlfbGVuID0gTVBUQ1BfU0tCX0NC
KHNrYiktPmVuZF9zZXEgLSBtc2stPmFja19zZXE7Cj4gPiArwqDCoMKgwqDCoMKgwqBNUFRDUF9T
S0JfQ0Ioc2tiKS0+b2Zmc2V0ICs9IG1zay0+YWNrX3NlcSAtCj4gPiBNUFRDUF9TS0JfQ0Ioc2ti
KS0+bWFwX3NlcTsKPiAKPiBoZXJlIE1QVENQX1NLQl9DQihza2IpLT5vZmZzZXQgaXMgYWx3YXlz
ICE9IDAgLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBtc2stPmJ5dGVzX3JlY2VpdmVkICs9IGNv
cHlfbGVuOwo+ID4gK8KgwqDCoMKgwqDCoMKgV1JJVEVfT05DRShtc2stPmFja19zZXEsIG1zay0+
YWNrX3NlcSArIGNvcHlfbGVuKTsKPiA+ICvCoMKgwqDCoMKgwqDCoHRhaWwgPSBza2JfcGVla190
YWlsKCZzay0+c2tfcmVjZWl2ZV9xdWV1ZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAodGFpbCAm
JiBtcHRjcF90cnlfY29hbGVzY2Uoc2ssIHRhaWwsIHNrYikpCj4gCj4gLi4uIHNvIG1wdGNwX3Ry
eV9jb2FsZXNjZSgpIHdpbGwgYWx3YXlzIGZhaWwuCgpUaGFua3MsIGdvb2QgY2F0Y2guIEZpeGVk
IGluIHYyLgoKUmVnYXJkcywKU2hhcmR1bAo=


