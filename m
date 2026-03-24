Return-Path: <netdev+bounces-271050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPKoEtSHwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:47:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC7308933
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 351D030BC1B6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D73FA5EF;
	Tue, 24 Mar 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAuix5sD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmQoqJsv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2843FA5F2
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355732; cv=none; b=WI2WKWjB02mxsNjMlu3dGhSq4RGw91yxMf2Eg9fhCAR9clVGVgPDm7/Id+kRb33G111m0snpqjfhjgxrhg+OokgkztOliMTxK/n9hAdk8EsfXH5WIMmBFI0tQdsjkkbD1A36T0cjXf5HSG63zwraHzeApXcO7xxdU0vGc1VkyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355732; c=relaxed/simple;
	bh=NBMwAFXGrzfWxo2rKM1L+KlTdhNaCvCR/vg0rPS4Crw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l55GeaXetemdPXv6g/piqJuoOa/H3gT+rcYNMkIb64csvVPdLMcOLQK7MctQIKhRRVNe7U/mrpc7vRF0pFWOIYSYsvZdR69G7Ss5sQJaDXLqZz2u7S2/hJAKzVksqcuW13mp7G5j72Fuu/g4CWOOhcXL1F4dxWscxoXVQXt9yNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAuix5sD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmQoqJsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774355730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MwMKjcJPosCxD/VlpcS37/E9OBSvowsgq2ia8asyjs=;
	b=eAuix5sDftkoQm59C+wuZ005tlezK37ej2K7tFJesUOMLjKgsV340R5q4eAadxh5yt4zXD
	r9IdE3saVCh4tZ5vNFMj5dQFqQdzJZ4dFiVdl0xP2P+80820/d9J4T+rVMf0gQviIQ3RvT
	XSZ4WKUw0vt0pISlLvRiFTJMJUnmRf8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-BytMPQW2MTaTrvrZ0FwW5Q-1; Tue, 24 Mar 2026 08:35:29 -0400
X-MC-Unique: BytMPQW2MTaTrvrZ0FwW5Q-1
X-Mimecast-MFC-AGG-ID: BytMPQW2MTaTrvrZ0FwW5Q_1774355728
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486ff4498b2so32771595e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774355727; x=1774960527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MwMKjcJPosCxD/VlpcS37/E9OBSvowsgq2ia8asyjs=;
        b=hmQoqJsvLO7hV0Bi0lLoNuKTaiYczM/O7eilpDBtrdaAz1zD9EUbmB69dDuqYluGnt
         nOxil2hypvVkBK+/A2kLnWTR4W6TTHUl7tPhCEtTFU/nDecfeVx7kxeAaoq1MWFFo87W
         QTDwjj4BjKiRdFQDnhL9XHdcLtKEEQMf3NP9iJihmhj61lRWf4UXBQfhYGW0kS6YZK5P
         xlm6qAADEimUpbFolb7TLA1WvTtz5eX1ZeITbaWK1Ca5E8ao7T8m3z2VhmqLA0pg5G2A
         yyyImm/WrELc06Y+clpkyGXP33YHfG8DnQ9n4vIgRAw9kuZgHkVFM0HyNakd91DwQwm0
         apRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355727; x=1774960527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MwMKjcJPosCxD/VlpcS37/E9OBSvowsgq2ia8asyjs=;
        b=P2SLxCWPwFOZJBOLIhTd7bgA8b0I+ysw8LTiyb/NlI84LSFvFwMn/XZ5PMyrdrkEbK
         cMspt9lrLgX7pcHxprCeilspFVWDeRYYFeunrqF++c0BaGNIR9JPIRRTUIyFRhZvr8KN
         r/tiV7p2KsSZXdjcG8NL77Qp5GhhvHDszMcmeiJwl95DcCxtjegMLsvZZ1q+XO/TZ1sx
         KQB3hmbr0LenDzxeLzMsqYvgY/9I+iLpZ3mX9FIiAXGYn/DcfPpaJBDDk54qVTxMBPSF
         gJ6KGxPU80Ooevygkr+2Ie2fBT2oTRxdp9QBE4QBEUqbXvYbcr1gDfpj+gZirh+KWWOp
         uE3w==
X-Forwarded-Encrypted: i=1; AJvYcCUEbOwSZ3r+rw8M9ZV4m/c/TZRrEDnBX0JEXt+SwVsAj3NbQKXFVClkmbkUjSYGcTsKnKZmFuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0h82N/GooOZ/wB08DBDEsoapF5BIUliENet/8PcNW9NZPWPZg
	a4G7HPIJKnB/AZWXObHuRX6eFM/xgX/goQyihntLGvsYwuW4oS+CtlwrQ/85rPuyDVxjowtxGV+
	xMhYxnxQFfnSmN7nrPiAhX4hYp8qJ0KrRU/kqJTDSZwAZfBlVhG02UYcmWNEa2uCm6w==
X-Gm-Gg: ATEYQzw7IMKtO8zGgwEPl0IkyfeYZ9jFPTeEr+IFWJN1GQqei+xLdMRF5jcczZDc1hQ
	Z63T5iWfRoD38EUKagLDQ2vATYY4bLPdfGlG3SpPJmYjvK0typfvfUPfABDeqhrCqyIX8yT/nyb
	dUfPkx0yVrJfQ4rG6rKh4i1UIyJ+naWzcuTyQi//KslJWv49GiHQoycm+hgoteZ6h0KXeGd/UHC
	qIQwizCnkNO+bEqWUbCMFEpVfjKBZu8LlSR/iqCSDiJOJY67yhmWYM/ZGO07q2X0s8Vv3R7iJSG
	PDsZb26qOZFfZRq/OLAwuG5I+mn0mPqQlNZKDIvnvy7P9Ri0RwANQqyGsVuH+JkpMHT36r5xyHH
	e3QvEBEi6Fdq+2rUI8PG4jsjsCuobyTTLo/Vbi+u99p+9T0YiuxyI6QV5
X-Received: by 2002:a05:600c:a55:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-486ff0479ffmr222177325e9.29.1774355727304;
        Tue, 24 Mar 2026 05:35:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a55:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-486ff0479ffmr222176925e9.29.1774355726843;
        Tue, 24 Mar 2026 05:35:26 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fe6f86sm23443595e9.6.2026.03.24.05.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:35:26 -0700 (PDT)
Message-ID: <75af5781-0ed2-4b05-879f-db6628af0692@redhat.com>
Date: Tue, 24 Mar 2026 13:35:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] xfrm: iptfs: only publish mode_data after clone
 setup
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
 <20260323083440.2741292-21-steffen.klassert@secunet.com>
 <4cc9cb27-90b9-45fb-8d90-28cca9e12b96@redhat.com>
 <acJ66ndBOEs7d-1D@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <acJ66ndBOEs7d-1D@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271050-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,1g4.org:email,secunet.com:email]
X-Rspamd-Queue-Id: 17DC7308933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 12:52 PM, Steffen Klassert wrote:
> On Tue, Mar 24, 2026 at 12:33:15PM +0100, Paolo Abeni wrote:
>> On 3/23/26 9:34 AM, Steffen Klassert wrote:
>>> From: Paul Moses <p@1g4.org>
>>>
>>> iptfs_clone_state() stores x->mode_data before allocating the reorder
>>> window. If that allocation fails, the code frees the cloned state and
>>> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
>>>
>>> The xfrm clone unwind later runs destroy_state() through x->mode_data,
>>> so the failed clone path tears down IPTFS state that clone_state()
>>> already freed.
>>>
>>> Keep the cloned IPTFS state private until all allocations succeed so
>>> failed clones leave x->mode_data unset. The destroy path already
>>> handles a NULL mode_data pointer.
>>>
>>> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Paul Moses <p@1g4.org>
>>> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
>>
>> While applying this series to verify the PR, I get the following error:
>>
>> Applying: xfrm: iptfs: only publish mode_data after clone setup
>> error: sha1 information is lacking or useless (net/xfrm/xfrm_iptfs.c).
>> error: could not build fake ancestor
>> Patch failed at 0020 xfrm: iptfs: only publish mode_data after clone setup
>>
>> The above also prevents the CI from testing the series. Steffen, could
>> you please have a look? Possibly a repost could be needed.
> 
> I guess this is due to a merge conflict with:
> 
> 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> 
> Repost will not help in that case. Not sure what to do
> here. The only thing that would fix it is a forced rebase
> of the ipsec tree onto the net tree.

Out of blatant naiveness on my side, how much of a pain would be that
option? If more than negligible, I guess we should avoid it.

/P


