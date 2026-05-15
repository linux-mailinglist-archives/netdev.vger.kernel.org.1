Return-Path: <netdev+bounces-288257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA/wLLjqBmqCowIAu9opvQ
	(envelope-from <netdev+bounces-288257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE154CA67
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33CF730BEA6A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DF402450;
	Fri, 15 May 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4D6PHH8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV4GVdWO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D413FFAA2
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837049; cv=none; b=E89fRonzNQogpbIlRBOjc2ohcPy9U24+NMDH5cebv7BYcfcC/9+/Z1aNEO+qoc5Xs6c5C8rID/+1q1YsMa20gssRqMCGCQGpOfEY9D6OAIBo50WS4TyV5GwoBVD3zoVqqimUOhxK45aNEzOCzZ4m4311rXC7EM+YdKsrBLRUwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837049; c=relaxed/simple;
	bh=Bp6CWGsou7BAV6pGfQtdLnSzoLmHA716Y07kxD7QWvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF9qIqy3ZJI7bE6vaVVpfFT4sZt4bM1EPXpRxvw/6RRmNH1BmPuc+FECkZC2+C/ivnv1gw6MHedbr1hqW/wie84HJVWRgSrSH0hg9Glmj+KLi5HteHMRVoFMtXpuZxTn4yAcYkROVyQqfncD3jubLZVbgWws8LN/S6JxS30OCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4D6PHH8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VV4GVdWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778837047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Jiq1OelULddFb2fRbTl+saaV/R1Ybw5/2bXhzK6jPA=;
	b=T4D6PHH8ssRRfysYMyCwTdv2lNzmuyz6O7Ybx/Njhwn1q4S1oZvsAUocX/ubIxKoFRgLDi
	YVC1k362jLBGhETNvFzbp28h9AVGZ8JBY5pn9gnR2egP9YfKIn2FcPUnSxwUeO5fh1VBy0
	4CzdkP+BWHbJ7DuJBavstSUhQIMpNHw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Z3h9zIeoPz-77fkQyKHH0g-1; Fri, 15 May 2026 05:24:05 -0400
X-MC-Unique: Z3h9zIeoPz-77fkQyKHH0g-1
X-Mimecast-MFC-AGG-ID: Z3h9zIeoPz-77fkQyKHH0g_1778837044
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fdacff6d2so13157035e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778837044; x=1779441844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Jiq1OelULddFb2fRbTl+saaV/R1Ybw5/2bXhzK6jPA=;
        b=VV4GVdWO9LUcEI19YKVBSvQxPcP5fW0dDTLlP7DAIpK6wuuLUNIo59uZVlNcsoM+SN
         8w6kWCOon9R68xmSKGG+lHxXGu5FhrPWcruwOpaU/S/GPGKFoygcBg6oCXpTeFLa5KKs
         8TXPEWCNAlt658ymntf+lA0eoAtUSEavzOTk+bNendokUjoU7gzhgfTaVk5DMab5Juux
         GNugVtOUEvplP4Xx7gSLUaZpOK7sjODR9mXvRqcLph/nRNsaGr+GLpQZJwSmcAojxBmD
         Gbv9vSf/hYPds66DjS4UszCV76F+cQKzabSYJQ4tMIOMAuVr7+U6XbrHa5EfT0Ag9Qj8
         qPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837044; x=1779441844;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Jiq1OelULddFb2fRbTl+saaV/R1Ybw5/2bXhzK6jPA=;
        b=crCA1w3tFcecd8r87xYkYWllhFIRIRvwjnazFNtJz6HvovngGjKPQ0GN7drQQO6Nvx
         N/u8FzbnE+DR+8dW2JfPpF4goz5k38lTKRSg/rFr4JtSEYc+m3p9E59pF9D38f2AhXFv
         1mo9SB18YhqEG5/eDuP7g1Ft/VpO65AWiF6In82maGtsRr3ThQUYE7bBXXIswBfvKyZV
         0MBxSYROCP2hP+xr2T988+0ouJ7DLl0Zfi3B2ECjRGh4BUbEo7JOx0zOv3bCzylyTurX
         8N8MZxjtL+Pfc8/Q3cMNNMPZHt5ZnwIRx0jrMDSQ3AUxvXMndpX31QTFq0KRPXTPZebv
         r4rg==
X-Gm-Message-State: AOJu0YyiUjCPV9O+t1TNpiRzZY8UlUetkzySEZPmrbBsW89hhKNl3mAx
	ILRI8ugtYS7/+sxxPSr3lWcGqpjqfGC9R2e6fcJVJCDTMcaFeeyWzHpfYRzXkyLW8cLiHkvL346
	Gd7Pm4F3AqcpNGr3bOdjqwvTIcCt8qSQ6SPNPWOw1/xthZRuZXuCOKMesBQ==
X-Gm-Gg: Acq92OF2JmUgkot9ArVm3Youu+0j7JmUsmVc4g0iHdI35DJdx+A7/b+XuZfWIZ3N08R
	JBtw6DdmYHDNYXO4hmZ7XzX59rHtQeOxm9D/LmocPdCYmwOsK/QqWIHq4v6mD7HwVoLR/hdIle6
	0vppsH7sVZHAKtLLC1tovjJqxeBxdaH/ff5ROow9ySnAijMUq7/doAyBZ5YH0tGw0h/PcGwIfbg
	qASMcogitHqLJwyvPGs5LCPaWjA7cQzcUCcyeXeHhr88E7QBDdQ2/hKxV5lTnzmXdAIBCbWNlGr
	E2+iQtwsU6oOg62i+WhM9L/7oYLtY0+PihyWjn5DcwVWxPqyu8dF5TzAwJPhklQOJeSWVF0GBnB
	ZZpNUQomuGT67mz8mxNXunBq6uKDS6hT2TF7pZIPzHwd8BfRBwUjJ1BoAwg==
X-Received: by 2002:a05:600c:a00f:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48fe63263eamr42397785e9.18.1778837044047;
        Fri, 15 May 2026 02:24:04 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48fe63263eamr42397425e9.18.1778837043649;
        Fri, 15 May 2026 02:24:03 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm56922025e9.7.2026.05.15.02.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:24:03 -0700 (PDT)
Message-ID: <36ffcd43-ebda-44d8-9e32-4268826deb49@redhat.com>
Date: Fri, 15 May 2026 11:24:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/stmmac: Fix free-after-use panic when interface
 goes does with XDP
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 k.domagalski@samsung.com, k.tegowski@samsung.com,
 Chang-Sub Lee <cs0617.lee@samsung.com>
References: <CGME20260511165107eucas1p1882391435991ffc19670a60a43bbde01@eucas1p1.samsung.com>
 <20260511165045.3091475-1-j.raczynski@samsung.com>
 <4ca19ae1-6606-433b-9860-0a8cce12f80f@redhat.com>
 <agbZXcsn9CAlofe4@AMDC4622.eu.corp.samsungelectronics.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <agbZXcsn9CAlofe4@AMDC4622.eu.corp.samsungelectronics.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B8AE154CA67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-288257-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/15/26 10:29 AM, Jakub Raczynski wrote:
> On Thu, May 14, 2026 at 02:01:20PM +0200, Paolo Abeni wrote:
>>>
>>> Fix this by following:
>>> - Set STMMAC_DOWN flag before stopping DMA to signal XDP to stop
>>> - Call synchronize_rcu() after stopping DMA but before freeing resources to
>>>   ensure all ongoing NAPI operations complete
>>> - Add STMMAC_DOWN flag checks in XDP code paths (XDP_TX and XDP_REDIRECT) to
>>>   drop packets when interface is going down. This has already been done for
>>>   stmmac_xdp_xmit() so make it consistent
>>> - Clear STMMAC_DOWN flag in __stmmac_open() to restore normal operation.
>>>   This was only done for stmmac_reset_subtask() during abnormal operation,
>>>   which is not enough. This does not affect normal operation as this flag is
>>>   used only for XDP apps
>>
>> The above looks racy. I think instead you should just use
>> napi_synchronize() in __stmmac_release.
>>
> You put this after whole section, but I assume you are talking about
> synchronize_rcu()? Because currently there are 0 checks and it is pure race
> condition. synchronize_rcu() does secure it in some way, but you are correct,
> proper ensuring that napi has finished is napi_synchronize().
> Will fix in v2.
>>
>>> @@ -5267,6 +5279,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
>>>  	if (unlikely(!xdpf))
>>>  		return STMMAC_XDP_CONSUMED;
>>>  
>>> +	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
>>> +		return -ENETDOWN;
>>
>> Sashiko noted here you should return STMMAC_XDP_CONSUMED
>>
>> /P
> Seems good, will fix in v2.

If you use napi_synchronize(), I think you can avoid setting STMMAC_DOWN
and testing it in the fast path: the run-to-completion after irq
disabling should ensure that no tx could happen after that
napi_synchronize() completes.

Side note: it's not clear to me where/when irq disabling take place?!?

/P


