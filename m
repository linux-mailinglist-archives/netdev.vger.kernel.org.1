Return-Path: <netdev+bounces-276036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OaRChEe1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:09:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3D3B0AB3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86225302478B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E636164A;
	Tue,  7 Apr 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajdUazK6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEnpfCeW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B533D505
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574523; cv=none; b=Ty6UEoWKRHV3qMBcjPBXpEmRvysOGf+fTCLMChDd1Bt0w00ppLBmTQeOhyXWlBycSpYDvl4FvGZJXG4b6ftkedpc6zLkxwfDA1EAQ0DOuxczlM3mTL7EusDMdtP0zkgeVAY/cAlK6L1EqMnmKl3xI6SvRYm7YpL5BXUXkAxG/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574523; c=relaxed/simple;
	bh=VlgZuFoA41N6b+uIUL8xQeE8lG2lfFpQ4V4mxepHdbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWh1eowDvMN21p8+5U2zrw8k8yhAw4Rmxf/nH9JghYP4PO4nV9cDrDaPgfoy4t/tQB4ms3qowGbk2HDLSs3UqgeMwb+HJ7cGj5D+UA3YCeJZJ72NbTyCXGPV4yZu2BpJim5B3Xw/vvmQg2chIz7SJ7wM/KWYH8hYGIAVEtmec1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajdUazK6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEnpfCeW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775574521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xs6yuSGRNfvLfIBgRPbdoLF38/rCeJEsqxdvs7jbVJw=;
	b=ajdUazK6evDLxSHACSKHZ/uItE6zHt3y9t+aAQb1qCmnPeb/YPJyXCEyQqZooBWz12bFND
	8FA4G1ms9c/8nDk04BugQb2U0IlnIqn11/UzrBEpdemSRZPS+JgJyq9j2TJXmJtc4i02Bf
	DylBUAf/1LJ5vYCJiVFa/zpfzQVG7lA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-VZrxJQbzPcaGz7wC49M-cg-1; Tue, 07 Apr 2026 11:08:40 -0400
X-MC-Unique: VZrxJQbzPcaGz7wC49M-cg-1
X-Mimecast-MFC-AGG-ID: VZrxJQbzPcaGz7wC49M-cg_1775574519
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d00dd913cso6256356f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775574518; x=1776179318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs6yuSGRNfvLfIBgRPbdoLF38/rCeJEsqxdvs7jbVJw=;
        b=iEnpfCeWc4zQabV6h/vW0OtVvgW1TEejSl1Bv4/ZUQ4hQ62KbxruD4XUfotjWD6Hdd
         QkF+sj4upLtfDXcE/ufFSu+lzwNauXWACiIkJ4cGAXzwM+pR6+F4pcom3jmdf5CcF0mF
         49qRuhIPbWRE2FeizGYMBVuGp+6rSIufTwyXZUXfvsqZwdyIL1jB9WgSb8qQ8ayXXnNP
         1NNhBw+LNqO9Dmigz3QHsDo1aaP3sdMOnKXojwwOgHkJeJr1qJM3W0r5JCPC+0fuIOle
         /JCyKBuD5fvNLHS0d7OCMnCaj90G9y3XoIs5HeHphPG+4+YgGCw3IgSSLppz/xYfnc6+
         0//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574518; x=1776179318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs6yuSGRNfvLfIBgRPbdoLF38/rCeJEsqxdvs7jbVJw=;
        b=dpYn+hGN5EhHWZuMuXObPHYMAQmVArlc+oeH8FYAkuP6YNar+ia8aaeRoT8zShE276
         MH1eWfFRbby04BKOXK1mTjG+mfRZiA5g5xeIiyV46kwkTn3MdnQw2uKVYqE36hMRn3K6
         UhzvnSMUf1kYtBpzNDZPGbqGGtrvB+SrBzXytEGbaHXS0EOH6V+DzXS0XGwDS+sQmWJO
         9oLaWLadQo2lqwIVpWdmDupmN5IYoNbRbOrqaKMHk13On166+lf+pCGS8ldxnLM/l618
         U1AB2vJ3BN7/UwKS9Q5lmmb7iryNZEfL+mZscMtp6x3dEC8ia5dHiZHkV34MS4iNheiB
         AIjw==
X-Forwarded-Encrypted: i=1; AJvYcCXfYjwRug96yHGwflVEfX5Ni8+7ggaA3POWCVTOho66IwYHAIeL5fATiEpxBqtQfer0uSYMmDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFd9HWOIeIwJ04lph+0pIGCD6RIYZFM12Q0+GuVBVK7KVdLZv
	7BawLtR+Y+bKRe7oFi8aD8klvfArmPaP/kedpZhPUg4yw1OUjVGwXiSzjgkPZMsj65SOHnu9Xnn
	zMnpVyWFJDtDcLwRrg6/TQm2Yy3sikcDBr6RD6QDEBcKY608iplYjTDXg0CdwfbAz2w==
X-Gm-Gg: AeBDiesn7n94TjPVIjfCDurm/jBigTVFwiZ6X1gqxkMV9WWZ1wTsqzhra6EtLNhhS0L
	MKNlcnzBMn/cqLJ8eZwCxcmfQvE7SeZMU7+1HrvNge7EcmfAzo9E/bIdfmfl9qJRlvOUwmrkBJT
	J/pyUBfKvxhkBNwP+4xOBLhQnWFWFpEqaqnI62L1wBNZuo9/eisSlDQKLPHEDe5pLntyLRA42Bh
	5Lrl74WRxmY3n6kxUh36YqzLu6X/AVr56kGLHtGF2SxkG2FY7dAW9arCxLQw/dffCXD/RSFf0i0
	xP1f3VP2QMCxerE49ZQg81vW4NUMMHKDKLsXi3mHGW3VHaby0mcze2l8Ko+Wqqth0YjLJJUBJlC
	gZEtcYsqfo23PDA6pKVqhkO6fQSa+nyOsOY/18zqcAW8R6ewrB/1pELGyCg==
X-Received: by 2002:a05:6000:2885:b0:43b:86f7:2ed1 with SMTP id ffacd0b85a97d-43d2926ace3mr23090201f8f.8.1775574518129;
        Tue, 07 Apr 2026 08:08:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2885:b0:43b:86f7:2ed1 with SMTP id ffacd0b85a97d-43d2926ace3mr23090098f8f.8.1775574517183;
        Tue, 07 Apr 2026 08:08:37 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a71f7sm53175290f8f.1.2026.04.07.08.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 08:08:36 -0700 (PDT)
Message-ID: <af5e660a-579c-4a24-98c7-aed1953fd421@redhat.com>
Date: Tue, 7 Apr 2026 17:08:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hsr: emit notification for PRP slave2
 changed hw addr on port deletion
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: acsjakub@amazon.de, liuhangbin@gmail.com, kees@kernel.org,
 horms@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 fmaurer@redhat.com, Luka Gejak <luka.gejak@linux.dev>
References: <20260403123928.4249-2-fmancera@suse.de>
 <756852a4-b589-4eeb-81bf-963fa2e71821@redhat.com>
 <d38ea95d-98d2-42ab-aea0-3099ab05082d@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d38ea95d-98d2-42ab-aea0-3099ab05082d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[amazon.de,gmail.com,kernel.org,google.com,davemloft.net,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276036-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: BDC3D3B0AB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 3:37 PM, Fernando Fernandez Mancera wrote:
> On 4/7/26 3:29 PM, Paolo Abeni wrote:
>> On 4/3/26 2:39 PM, Fernando Fernandez Mancera wrote:
>>> On PRP protocol, when deleting the port the MAC address change
>>> notification was missing. In addition to that, make sure to only perform
>>> the MAC address change on slave2 deletion and PRP protocol as the
>>> operation isn't necessary for HSR nor slave1.
>>>
>>> Note that the eth_hw_addr_set() is correct on PRP context as the slaves
>>> are either in promiscuous mode or forward offload enabled.
>>>
>>> Fixes: b65999e7238e ("net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP")
>>> Reported-by: Luka Gejak <luka.gejak@linux.dev>
>>> Closes: https://lore.kernel.org/netdev/DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev/
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>> ---
>>> Note: routed through net-next tree as the next net tree as rc6 batch is
>>> already out and I do not think this is worth to be included in a last
>>> call batch. Anyway, if maintainer thinks it is, feel free to apply it to
>>> net tree.
>>
>> The general guidance is to avoid fixes tag for net-next patches that do
>> not fix net-next specific code. In this case I assume you want the patch
>> landing into stable right?
>>
> 
> Hi Paolo,
> 
> Noted. I wanted to reduce the number of patches on net tree given we are 
> at the end of the development cycle. To be honest, the stable backport 
> isn't that important here, this is a trivial fix that I doubt it was 
> breaking anyone.
> 
> Maybe drop Fixes tag and get it into net-next then? Fine for me anyway, 
> I trust your judgement on this.

I'm seconding such option, as I think too much stuff is already landing
into stable.

/P


