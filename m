Return-Path: <netdev+bounces-290022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULVaIvPzDWoF5AUAu9opvQ
	(envelope-from <netdev+bounces-290022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB935949F0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2634A305C9F8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404783F44C9;
	Wed, 20 May 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt4uN8yV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095C36A352
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296359; cv=none; b=uBsbl2J+drlcA9MOSb3b8coNUJhc/vHhPuj93eWsSuS5bVc0LoL0n37BEQQeZdpZHQW14kAVvzuYj3/bY+NPEIqvR7KkjvLe85T1sKnvVHg7CYzj6fFFPCb2YKe5mB67rfLw3nhxobHv+dWoc5slOvSc7S0Zs6dQguizcLSQbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296359; c=relaxed/simple;
	bh=AIhvkw0yBDgtvPsGE5h15ItzE0NtmWKsmKdeIQzLbpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOasv0JHlry6vikOAEzJQqDdX2KrBpGtQ6Jxboy/Rf77eofczmF7GdKvno5EC1FlnvXcZqzUo1MOqiWyfNc0XF1vlOnlOT+32pR/ADoMAv4o+Mi12FJlhvTiTbMq0W1icmkFz//eJAKaZIoFu244Ttl0BvoCiAKtEfallNBdA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt4uN8yV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bc763e2ba8so24613885ad.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296357; x=1779901157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7TAEp9q//rixySKUh0Tspzo/0EDR88Kz9RGYRdINGA=;
        b=Xt4uN8yVvxa9hVN1z29L2KOGHYh0NsE3A3GRJA6naizfc37eEDzZZcDfObA2CAmq1U
         c3yjUmA949D1gkGyQznm1dxzWbOFwLJ36DE1/y443cxHxgJLF7kuLyuJBOIA1d6edNiq
         kmKlb5QdIa7rNNz8+vqcxMvgQQzGlzYWTpCFJm7nMd4L8WyV34Nv1NUfQP5YHbo8WDJD
         iy1u2Kv5HSwjIFryNxaYYp3td+hJUTSpz7KUYUGU0z31aeoGD5j2kLr0mm23NIvlfm9j
         U3gJw5OutCbGYYSJyAyyFP/hSjwHWAmFU/sV+d+Q8IAnDLiCkIyXkCcJi0c4SVDJji4S
         8RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296357; x=1779901157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7TAEp9q//rixySKUh0Tspzo/0EDR88Kz9RGYRdINGA=;
        b=a6ottPkcN/zi88pEteANF1K2jbZf+dkTI8LIkhC1FEv/SErSaJU7tTnqaUVrRqBGRw
         s2Aag6zmqWaJ0sMLyydXb6F3X2NtJzIzBOHBNUpDm6xS11e4UEBEyxmF8np7DjrHu1Ht
         9QA0X5DxKqeoP4xEWGVYrnUOHPvwbbJhbwyp7tl23mMwB4vZicugGjEDCzYni/WTkNlx
         eHnN9EZKXMTMSI/UQiaCtks0u7BexwuM+AtL9RnvJh5Ydg+BK29eRAsssb8ESY93mI6g
         D9POQHYtMCKZZHurdSd+CsQPFAeZLqB4IijJXqAXRo9A53MLtvXHAeaq7hxQCCiZq/VF
         V+2w==
X-Forwarded-Encrypted: i=1; AFNElJ8m945t4lhkHKg4EePSv49yPgyiEJ1VFucl1iqpSy15ZyOE3MmjZ4qd/oOXVTzpNadCvtMKP0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOgbpx40IWSuLXtwWPbg/neeRFm9+sPCybgRCF11vIdSD8dU3
	4uK+EAiqe4Dk5/WfLEZiS50HIpt5AcCcyaGsg0+MswXJCv6x8w4PWgpq
X-Gm-Gg: Acq92OEcG6HkQF89gcK5+W2DSgzmYPS5wxZe0kKkbPA4/5/jqYJkZ6vhrU4+9m7S0eM
	wD3ADJg2F8JpvUO0IhS3RQgenxYrX+Z2vNPBkNK0FEdaxrQQch/UVtJff8h8tL1Ygn7dorgkCpw
	o7vdnym1ayFHgcALufWpfcqhDUIEAHInwP81QqkdJaexUPaNBzorb1hKRkYpv052dYN4YxF6LYX
	/hLqrCjgBleJ7NQ/zrQrNIIcJBkRhHVdtBvdrfYxK0JK7nQ04bDtxOVv1Wxs1U+cgkP2isSnhtO
	Kbdh/V5cxzbPMpb6TJreK4FmqePvj4t/ZMvFCSPSw5bEF4JzfMCUlVl+IS2JQ8xj72G5GNyTn78
	8geZPyuW4LC8qU/MLHxc7GbhUni8Mx1DaPVp+mkjo7xud9rJFdvtlvHSzZFawkSEAziamxEAMC0
	GLghZBQiMy3hgVuVJTowoU
X-Received: by 2002:a17:902:f987:b0:2bd:2430:eb7b with SMTP id d9443c01a7336-2bd7e8cbdf8mr183864475ad.12.1779296356690;
        Wed, 20 May 2026 09:59:16 -0700 (PDT)
Received: from john-p8 ([98.97.43.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm234935005ad.69.2026.05.20.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:59:16 -0700 (PDT)
Date: Wed, 20 May 2026 09:59:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: rollkingzzc@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, jakub@cloudflare.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com, 
	stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <ds3zog2r7avfbiu6je6v24oevvg3ogaegkrjdv3w7ibm5eb7hy@unozyvsnb2ou>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
 <646104384170b8d95ce979ba3d0bd87a808e5dd2a1f6b2bc4e0a346ca38e654d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <646104384170b8d95ce979ba3d0bd87a808e5dd2a1f6b2bc4e0a346ca38e654d@mail.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290022-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EB935949F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:09:36AM +0000, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 9590877b0714..223d78708486 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>
>[ ... ]
>
>> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>>  {
>>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
>> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
>> +	bool rsge_copy = false;
>>  	u8 *raw, *to, *from;
>>  	struct page *page;
>>
>> @@ -2866,6 +2909,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>>  			sk_msg_iter_var_prev(i);
>>  		psge = sk_msg_elem(msg, i);
>>  		rsge = sk_msg_elem_cpy(msg, i);
>> +		rsge_copy = sk_msg_elem_is_copy(msg, i);
>>
>>  		psge->length = start - offset;
>>  		rsge.length -= psge->length;

Zhang,

Did you want to push two smallish patches to fix these two? I have had
similar patches on my test system for a few days so they LGTM. These
two fixes

>
>    page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC |
>                       __GFP_COMP | __GFP_ZERO,
>                       get_order(copy + len));
>

and

>
>    rsge.offset += start - offset;
>

bot must be reading reviews because I called that out in v2.

[...]

>
>Could the ring buffer state become corrupted when data is appended exactly
>at the end of the message and the ring buffer is full?
>
>If data is appended exactly at the end of the message (start == offset +
>l), the loop finishes with i pointing to the unused slot msg->sg.end. If
>the ring buffer is full (!space), the coalescing fallback logic reads:
>
>    copy = msg->sg.data[i].length
>
>Because i points to an unused slot, its length is 0, making copy == 0, and
>the fallback coalescing block is bypassed. The function then
>unconditionally calls:
>
>    sk_msg_iter_next(msg, end)
>
>which increments msg->sg.end. Since the ring buffer was already full,
>advancing msg->sg.end causes it to wrap around and equal msg->sg.start.
>This could corrupt the ring buffer state and overwrite the first element
>without calling put_page(), leading to page leaks.

^^^

This one I haven't looked into yet. Let me know if you have time to get
to above two issues this week would be great to get a v1 out at least.

Thanks,
John

