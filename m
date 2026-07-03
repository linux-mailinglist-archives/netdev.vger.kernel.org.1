Return-Path: <netdev+bounces-304658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N8S+JKsUSGqpmAAAu9opvQ
	(envelope-from <netdev+bounces-304658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 21:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD070572F
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 21:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IfOY1Zgu;
	dkim=pass header.d=redhat.com header.s=google header.b=EyHuTGpD;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304658-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304658-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690883017B80
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A2346771;
	Fri,  3 Jul 2026 19:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03607345CBC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 19:59:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783108775; cv=none; b=QNLjYNsF/P0FDZiCNd+DRx1n/ktiaJhrz2G5P1nC3KxbjiPqcE4C6UUpCcuoFSgKXnpJPtaK+x5PfyP84AXM6m9gYvzAjp4sKa/8eNAcceUWBEywL4XpkGRx8N2i27Nkzl8QF56Rz09iQfEPo+RXw7nTLFCFoz874Dji/CfCEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783108775; c=relaxed/simple;
	bh=2aYDZM6lYTfGT6BwqqoFiONE+cTXM8g6TG2Du8NB/d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/D7U7uNbw1+Rv1hyMRI+WGTgN74G7b+nUA9Tm8EkeZZUEyOZDVHu6fqlHK1paknljfUHCRZfhk16Y2S3yS0E/wkPhGS5WiQ/RyEWglj+GaDaFZ6oUl9ivYzuTNKjn+rTZyPDyasTcaB11jSWLvCZ2VL5jlndEeF6Dht6RALFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfOY1Zgu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyHuTGpD; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783108771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3+fkFqbL+y07nPa6LA75Hnt5NAmG/dS2fgU2WFQxqE=;
	b=IfOY1ZgulnX7ZpZiN1b6bbIIuSW7WSKfoFF44hJQAgxYkwH7oYs+FUFmPp4SXZ9jIZYcLR
	XIvqMQIw0aH9Q0LslmOW4yqH291jakxznzM7f/a9uqoEl2TpfsG00fIJ3Fxi8lKn6OFSSB
	j3VOvNu3VlG5jiMdZ6JbCnphONEnrVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-vnF2RLKmMj2ECFUscuz_sA-1; Fri, 03 Jul 2026 15:59:30 -0400
X-MC-Unique: vnF2RLKmMj2ECFUscuz_sA-1
X-Mimecast-MFC-AGG-ID: vnF2RLKmMj2ECFUscuz_sA_1783108769
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-474170b59dfso873429f8f.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783108769; x=1783713569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3+fkFqbL+y07nPa6LA75Hnt5NAmG/dS2fgU2WFQxqE=;
        b=EyHuTGpD4D8a8FQ0Vstb72umWJ1CgBkgE5nZapbkXSt2uFaKEdtTBwWsDNVtfnBtbY
         GaXMN0V672rVefvWf4cURbOr3sZHJoX8bYIjKUz272paxDsaAjRYr4mNEMWf3tD+VVtb
         noGy5z1O/n9Sh/a1GbaJw7Twj0fI1pPAvecULDOs1PkMQU29nQhqHIIwnySYZASAxF2G
         DG0dkHRa14vtohWgrOf72AUvv64K0G0yxCr2VwGTrzgRM9oY93en+VnFBKH3bHQi3z3A
         e0e0fV2S2vZ6Arwy2d6WQHrCVMrZw9Hdhi89NXjMrCD4UM/p5a9tf5jPHwCTg0VYfO3O
         JGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108769; x=1783713569;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3+fkFqbL+y07nPa6LA75Hnt5NAmG/dS2fgU2WFQxqE=;
        b=FZchR1P+0eGMfAhQLMbV7Jy/nfHPlKLGxYK5krh/5cBjyrwqZmQU+zIANDydwnxVjm
         tFamRjPVbXq4gDz/bGMEtfkm0y4tYxBFIq7WLNY1WImDi8n5URibyodOoDp+oDjCin1Z
         Tx4glhFtY3c+Ao/UeEV/qCTIm4FqUNqOhezePws7rkHaJko85JTf4nKvsYDRnOqkjf7A
         nqGGshFqXtcxJdUuRamU8YPEbIbo0aWPmE1HK0wEy1Pa3xtRRWoSMUUqPqhTax7niCP8
         W/LCLTb0Cc70PVJ3haqWl/MeRku9/YCy0X3QMuQPdG3fqj2tevgghWi59ZeEL7HxfAhX
         azPw==
X-Forwarded-Encrypted: i=1; AHgh+RqPZxDz6sCEK0gnJtxC7C2aIsQCOSk52E2sp5YoMGFMNvgqWFpHapuBrG4ynK5dGTxW6EpyCCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fVqb+lEKvvINfwtxXp1aHe/5pWxx7xS+KeCiuKLA0O7YNlcK
	XpjpncgUC9cksEXoj9DqRFDvaN5PXMqJkrW5AejZzTKW/9Fq8zrU7nj7SxMD9rF3rSo2U4mzWV7
	pSHFsVxOAlkJgdcY/7F1k3YIp6lC2325RDZzT2f3elFLCfTcl86UI9QR7yA==
X-Gm-Gg: AfdE7clDuyb5M5cfTznQo5PT51JlGSVmJPIGMmClBJJOu75Ruaerm2a9hYLDM+ueqBS
	htvmT0NzT77mrxy2h1OFBgz5wlvw7HBMAUcqVROuHRgsqJTJixigAvkKQQyW8lEijYOdREd9h4K
	j81x8l+LP9FlALe4+yS6o9RUA5QSReuoq+qVcTVbRB8TVGQZnEXhhgaimZwUQ0+X7I4nHShgqmK
	UEuYHmbP0Tn/hylymydlcktg6tCZPSurvar2UD08K8NYocv3BRoWAOuIwOxGJuF/wqWnXxqJQpN
	dwFH9ImIPSKQ3V4pkOdqrvBqvW5qtHzgMZSvWL7zxYeYTKf39REGw8HTEeaK7dImyBtnb3TloOm
	axJM1DZOlI0UrAD493tpRPNu+AxzsFZPc1njbr/jAZ9w4GmA2Fpre/acjGNRSNVdsb6jm2vZqkm
	vX+eU/
X-Received: by 2002:a05:6000:41f0:b0:473:53b7:e390 with SMTP id ffacd0b85a97d-47aa96997f9mr844529f8f.11.1783108768891;
        Fri, 03 Jul 2026 12:59:28 -0700 (PDT)
X-Received: by 2002:a05:6000:41f0:b0:473:53b7:e390 with SMTP id ffacd0b85a97d-47aa96997f9mr844513f8f.11.1783108768507;
        Fri, 03 Jul 2026 12:59:28 -0700 (PDT)
Received: from [192.168.0.115] (ip90-44-231-195.pool-bba.aruba.it. [195.231.44.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm1613520f8f.35.2026.07.03.12.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 12:59:27 -0700 (PDT)
Message-ID: <5439da45-f8f5-4fea-a21f-580c753a188c@redhat.com>
Date: Fri, 3 Jul 2026 21:59:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] netfilter: updates for net-next
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
References: <20260702105003.13550-1-fw@strlen.de>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702105003.13550-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02AD070572F

On 7/2/26 12:49 PM, Florian Westphal wrote:
> The following patchset contains Netfilter updates for *net-next*.
> 
> 1) Update nfnetlink_hook to dump the individual NAT type chains
> instead of the nat base chains to userspace. From Phil Sutter.
> 
> 2) Replace strlcpy/strlcat() with snprintf() in x_tables, from Ian Bridges.
> 
> 3) Start replacing u_int8_t and u_int16t with u8 and u16 in netfilter.
> From Carlos Grillet.
> 
> 4) Replace strcpy() with strscpy() in netfilter, from David Laight.
> 
> 5) Remove redundant NULL check before kvfree().
> 
> 6) Add parameter validation to xt_tcpmss. Ensure mss_min <= mss_max and
> invert <= 1.  From Feng Wu.
> 
> 7) Add checkentry for xt_dscp 'tos' match. Implement tos_mt_check() to reject
> invalid invert values.  Also from Feng Wu.
> 
> 8) Stop hashing nf_conntrack_helper by tuple. Switch to hashing by name and
> L4 protocol.
> 
> 9) Remove tuples from conntrack helper definitions and port usage from
> broadcast helpers. Add netlink policy validation to prevent protocol
> number truncation.
> 
> 10) Remove obsolete netfilter conntrack module parameters.
> 
> 11) Bound num_counters in ebtables: do_replace() by MAX_EBT_ENTRIES to prevent
> oversized vmalloc_array() allocations.  From Jiayuan Chen.
> 
> 12) Make expectations created via nft_ct rules work with NAT.

Sashiko gemini says that patch 1 may require a follow-up:

https://sashiko.dev/#/patchset/20260702105003.13550-2-fw%40strlen.de

/P


