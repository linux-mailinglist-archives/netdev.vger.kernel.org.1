Return-Path: <netdev+bounces-305770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qHYcK1AwTmrJEwIAu9opvQ
	(envelope-from <netdev+bounces-305770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:11:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25F724B0A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:11:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CFIgjtoP;
	dkim=pass header.d=redhat.com header.s=google header.b="M9/aQY/D";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305770-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305770-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FBF53002930
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8DD3BF689;
	Wed,  8 Jul 2026 11:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A638837B
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509065; cv=none; b=tagaik5TWScfyK05VHKrs8eg/hsyUftNH+zMVCJi7XcsQxjRjuaLMzMHe5sTPHNjunc5PDIY1V0UdIdkBuQyVH/o8SatEzlSUWsYMRXYL8uIjndeSoYkUZamycgtnXwxK0IXEImYxwrtaKYF/Y1/4xXDfXtsemNs1MolH5rcRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509065; c=relaxed/simple;
	bh=n0OkkOmzJPAfgbOcvsqxZh0snn73P+M4j7p27YvFEWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LluJqL/riio4inN17BKXHbo1Ja5TVDYcH44CEnksMdhbGSOZYmHuIuoEUWnMJ4MkjD2+AemLAa9IDTuVtUbpsMp2Y0vNhRxFjf4QYd927y28spOmrAhr+RsjxIFdx/1U+9OrzI1jyZC8DhaKjPWo3ZTwRGJHWWBxsx7c8SjM5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFIgjtoP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9/aQY/D; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783509063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pESh/hqfKy3ZBCrzaDf99qD5EsUmEk/AYfZwryKhxdY=;
	b=CFIgjtoPI3k6VbuuicvZOahzctjB2k6h6KLfmQqLKUIt038w+6kNk21ivY6kQB43tbknBC
	cA+BKQ3tXFCyflJ4iYnoafZAH3gbw2bi8dAUw0zAE67Ob8rEasxTKjpbmZe95sKgvuGuab
	Yr51vHloLBG8rbZXQVhHe4kBVrONR6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-dXIfpOsiNZeFuMTbh2a9kQ-1; Wed, 08 Jul 2026 07:11:02 -0400
X-MC-Unique: dXIfpOsiNZeFuMTbh2a9kQ-1
X-Mimecast-MFC-AGG-ID: dXIfpOsiNZeFuMTbh2a9kQ_1783509061
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so4860465e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783509061; x=1784113861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pESh/hqfKy3ZBCrzaDf99qD5EsUmEk/AYfZwryKhxdY=;
        b=M9/aQY/DtxOkeyk1CUJ/zhBbU4bWwsDFONm5ZQgPegPnd1+Gj+jKRLEgOFyvcDmENt
         ad+JT4JG4xBI7y1wFAnSEmPaIaUXd8dwIU73Bqoza07GUSsVJRq46RNZVL0bqj2i0Wxx
         D99X+MORknJ5mzNMZL6zcreSpMDT5xuxfdqR1EWIUQtZFDVoxABeOhtxXftuQZAqZDty
         rtCFnEPZ8jL3+NF4+71uoguGFNfVOexmey1BucKOrFLk+MemDQi8VN+TPmrihqxBLwaa
         kv+RNXHnww7xtwkAziRTFPext2nQCq1dunKUR0pU2DxBHxR0+nc8bjIIzzW2XnCQdbzX
         XPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509061; x=1784113861;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pESh/hqfKy3ZBCrzaDf99qD5EsUmEk/AYfZwryKhxdY=;
        b=aL+6YvE77GaSWt4I4q04TVjskNEkgy04YiEfe/3yMN4JyxSqjU0J8Sla39PwGRCOVU
         spj7coQi2LKX0GGgSJ2jduWmFF8HPdwdimXV2YCWMhFmfTr7sxz7sGpIvjJ8ZK2SdUGE
         qcYl9Z9Q1nv2folWKKCCnWARL0m2IjDvJYnDbVZZNbLX12xx7fGo0JvAauL6HDwRohmP
         chDJQu8NENrN/gLFQH0ZusvhONakNvkiBVhVl73qm8m++BOQfmJz1BAl/CTMVyuerZXB
         LHUQn5ggZ1kXFn3CNzFUvLJer06gu7wjukjkRQv/z38Gkbi2SvZaWo79h1xGCXOvxVC7
         LL8g==
X-Forwarded-Encrypted: i=1; AHgh+Ros9x5mMWtQ0y1mG8xpuF0WlGFWaStAah6c9LngmJuhrnxhcDw5y/j846AR6gLFmjYXshJFXBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDY5iMYZLVt1YV5zlLVh+NJxxWngFtpeJs4fAtbgkSjUAR510
	FgupnfD46avRBz1OLYcfLVOXqd4ZlDfe6meotopLE9+PtfdGxa4oR+lQKPk/Myw847wOvFfcOEB
	v/0cb2ocMHKroHVmioy/bTAwHWMzp3k9vYpgOVwOvapWf8Is/bMAc21gPaQ==
X-Gm-Gg: AfdE7cl9iWeD+Q0sQsCVo3RbmWScH0vJGNK29n2Yc9tC4VYc9jquGVQbcoZB+ZVhkKd
	KNaR+gGEXmT0GdwrANuYaJTpPFGJc/h104DHKiUGO+TBT1/6UxRg31cqHgJpGpR4EKbdgkMvCq1
	+flMa16LgTBvlMdjJNOAi53wcKJ4biZoKu3ZZSZrGq0Fzij/KFuoY/V63wPbXdWmFxIQA4Oe0IB
	wRMrlQ5rzFmIDYz4x134Sq0Gx9I8SnqcdxCkETy5LcVZlkcqQdfy74alhuw5+q4Nucu3hSvZG9E
	ZXySMqPvXfBp8Z0pRUqTf4YBaj61SbJj4H9RbhetsMI5Mfdv6a4NOhxJZUAvBaQR1ge2E6JVIH3
	+fLZF4ZFsBAuW/fU4idoddZNqRgklTcTxlQpaN5bzEfIwCjJ4GN9UoKTJ7Gakgxf5HjPXBiPuJQ
	==
X-Received: by 2002:a05:600c:4f91:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-493e6859a48mr20208845e9.6.1783509060910;
        Wed, 08 Jul 2026 04:11:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4f91:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-493e6859a48mr20208335e9.6.1783509060414;
        Wed, 08 Jul 2026 04:11:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5ca1fsm140639445e9.15.2026.07.08.04.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 04:10:59 -0700 (PDT)
Message-ID: <8d5fe948-6979-46be-866a-69a98ee391d8@redhat.com>
Date: Wed, 8 Jul 2026 13:10:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
To: Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <20260707142820.GG1364329@horms.kernel.org> <ak0SYEOvw6K_8C_w@chamomile>
 <20260708103525.GJ1364329@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708103525.GJ1364329@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305770-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:pablo@netfilter.org,m:runyu.xiao@seu.edu.cn,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashko.dev:url,vger.kernel.org:from_smtp,seu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E25F724B0A

On 7/8/26 12:35 PM, Simon Horman wrote:
> On Tue, Jul 07, 2026 at 04:51:12PM +0200, Pablo Neira Ayuso wrote:
>> On Tue, Jul 07, 2026 at 03:28:20PM +0100, Simon Horman wrote:
>>> On Wed, Jul 01, 2026 at 08:39:25PM +0800, Runyu Xiao wrote:
>>>> The GTP PDP lookup helpers are shared by RCU-protected data and report
>>>> paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
>>>> helpers walk RCU hlists, but they do not currently pass the RTNL
>>>> condition for the control-path lookups.
>>>>
>>>> Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
>>>> RCU-reader callers remain valid because the RCU-list macros also accept
>>>> an active RCU read-side section; the added condition only documents the
>>>> non-RCU protection already used by RTNL control paths.
>>>>
>>>> This was found by our static analysis tool and then manually reviewed
>>>> against the current tree. The dynamic triage evidence is a
>>>> target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
>>>> to documenting the existing protection contract.
>>>>
>>>> This is a lockdep annotation cleanup. It does not change PDP lifetime or
>>>> hash updates.
>>>>
>>>> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>>
>>> There is an AI-generated review of this patch available on sashko.dev.
>>> While I don't believe that the issues raised there should impede progress
>>> of this patch you may want to look into them as possible follow-up.
>>
>> This patch refers to the rtnl_lock, but it is the genetlink mutex that
>> protects updates on the PDP context list.
>>
>> Then, from packet path, rcu lookups are performed.
>>
>> I think this patch is not correct.
> 
> Hi Pablo,
> 
> Of course you are correct.
> Sorry for not realising this earlier.

Human slop here made me wrongly apply this patch. Could either of you
please share a formal revert?

Thanks!

Paolo


