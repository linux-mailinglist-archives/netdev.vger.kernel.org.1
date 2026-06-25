Return-Path: <netdev+bounces-302057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZdGwGOdoPWoh2wgAu9opvQ
	(envelope-from <netdev+bounces-302057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F326C7F77
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:44:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Stdkh4aZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302057-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B448C31B5763
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B53F1650;
	Thu, 25 Jun 2026 17:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A03F0ABD
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:35:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408914; cv=none; b=S4pHd+nNW0x+U87VP56QaEOMuKZHTf3be1fP8bLbnSQx2lkRVz4ijzke+vTlgA3LqBlj21z7FLZtV2uPrHXKbDRbRZcNZ0jtxql42SZLfxSIG7wJz90wI9KCQI1mICJBoNpRkPy2GiipJIklvWQmEFp8OzHeqIL1DEFvqCnpiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408914; c=relaxed/simple;
	bh=CWcHyXL1nuFr2zBbxcD+I49gXR+BUjlAzdxCBWdkI8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYj/ZTrZsmChV6V/uQdv0TiLVn1PXLANKKQaowN65xOqDr8vhWUN6+gox0QBTeu/CHjYbGtIILlnUcjSju/JHM1fNpsYy1gEDnHRAwISqk98JWgoL1EN3paQhgaK+2QMRBtT+weeWVDQNeEVr7aEAZlQkxotbSMFJ8quYBii8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stdkh4aZ; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49240a58dc7so141215e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782408911; x=1783013711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfJs9w2lKJotpLjpMf0F1SfbJUWEBXoJkkJG2VjG/Js=;
        b=Stdkh4aZqRfpjEo20uwKLo9PSk7NjBdJNHDhqI7RfXNgpMJMHszH6ey6s+vMvevgEU
         FxecJgaftf9/fhtPN6St4eVRhStIQnKM0AGJZ21fO02zHgoeWBvyxIc0Cq7Pzyc8kMZN
         32rLAGP7+05pkOiuC+gAbR+tAHY4mDNzd+iDDqYy52rTJM6q9rSZzMPZeaWGUyT1Wfmg
         k3g7eZO7QypA0oXHk8ppmsOIhqnu055Mh0ykQnuApZs7nk2sZE8hC0p72rX+IEwpoFyB
         8wZcgufD7/uJ52OwLuyS0XD82OJlRT6IYAt2w1SyODb9TmepFeM0F8lCdAgYZjvKPSwZ
         4bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408911; x=1783013711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hfJs9w2lKJotpLjpMf0F1SfbJUWEBXoJkkJG2VjG/Js=;
        b=ZVi9f1wbteeR8dz1sEq8vt0/4aafK8SOmCNO4KgF+ASruq9lRxz15mL1G3swWxbZA+
         SMOV85uULXMI+8kBmtHs70x3HNnpyWrWDOvdKEs3qtTeImLl1Lyzw6OmbgiWEGaKM8Au
         hZ2rLo/jgLi8V91S0p8j2uNfxwA6stqyREo9QXF/u9WOZIfUDmyYoWTd8J65Kxyceus2
         MA3rN0CaKmbKfzJEE7lIJ2qc24L3ulzS9Bbu1JZ1115DSc0cN69JIAMivOONoyFQvvv7
         EPrib6otyEeqsjtvj56Kj8Qu855UgQghlr57LGfMjrCoVqQsLlZGd3wbj8eoUPp3+rKV
         xmmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbRRKNF3fYDeLXqyBU3AbBN60ow+ZcRg/2RyNhVkJDlQaZ9QP8TVylFiGnE6F5sG+Nhw9rHp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUTNTVj46nL/1MxLSvhcUASBu0fQTsrqqVlih6McHFR9J1m+f
	nK1QdyfbuRqoWKNRSfM/8ywK8HnpZf4YKnh5VGKkwdYAC4J38zuklyVZ
X-Gm-Gg: AfdE7cn5PCRbsecaq2kSR0idSp8YY7MObY1jmBnOo3ounD+arNgryEXi1cUTfQh4VGo
	9Ze/lWxefI+8+aspNpjT6dMzz/hcA3rteVMOWEB/CmbhUkxluI4xCXQC76qCX06KQA3bi7nZb8J
	wYepQmLAFylfjcR7Mpj/MFoSIeyXBMNK75xpOZlGnElWQoLCqA9w/hwL4d7vct+3KY5yw3qlclJ
	3oN14E30wpATIzc1tQZ2oEEkAoMEjaKOv0C9s6yk8qggFYDb/gCt1mVxwatQintad4+x8Gl2jJS
	wzlMxKJFqIRTCzv5/laWBwd5ke9VWWfKZpxy7p3KM+KmlLCIfsnSAoFDwyb1Lb/Yg15VOAFN+xJ
	GCplTivvkz+HqOB70LxIdW6Z2xNOeAih634nnJifYM1CLvrpLJgBsNWrqQcnF88PWhea8sMdC34
	0cwU++5rITwN4x8yq0TovcMR6FfpMVFQ==
X-Received: by 2002:a05:6000:2c08:b0:46a:8000:617a with SMTP id ffacd0b85a97d-46dc2733530mr2636381f8f.8.1782408911409;
        Thu, 25 Jun 2026 10:35:11 -0700 (PDT)
Received: from [192.168.1.135] ([165.50.1.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm18233741f8f.9.2026.06.25.10.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 10:35:10 -0700 (PDT)
Message-ID: <cb5c9a44-2b05-46a2-958b-cafe368c5576@gmail.com>
Date: Thu, 25 Jun 2026 19:35:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Siddharth C <siddharthcibi@icloud.com>
Cc: ast@kernel.org, hawk@kernel.org, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
 <20260620121321.45227-2-siddharthcibi@icloud.com>
 <20260624185432.32d90aa8@kernel.org> <DJIA58WBML8S.A897NKI06DV9@gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <DJIA58WBML8S.A897NKI06DV9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302057-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:kuba@kernel.org,m:siddharthcibi@icloud.com,m:ast@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mehdibenhadjkhelifa@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehdibenhadjkhelifa@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxq.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65F326C7F77

On 6/25/26 5:44 PM, Alexei Starovoitov wrote:
> On Wed Jun 24, 2026 at 6:54 PM PDT, Jakub Kicinski wrote:
>> On Sat, 20 Jun 2026 12:13:13 +0000 Siddharth C wrote:
>>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>>> index 5e59ab896f05..8f2d7013620f 100644
>>> --- a/kernel/bpf/cpumap.c
>>> +++ b/kernel/bpf/cpumap.c
>>> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>>>   
>>>   		rxq.dev = xdpf->dev_rx;
>>>   		rxq.mem.type = xdpf->mem_type;
>>> -		/* TODO: report queue_index to xdp_rxq_info */
>>> +		rxq.queue_index = xdpf->rx_queue_index;
>>
>> Do you actually need this or you're just trying to address the TODO?
> 
> It's a 3rd if not 4th attempt from various "people" to address this TODO.
> We should just remove this line instead.
> 

I was one of the people that tried this. And also I have already sent
a patch to address the misleading comment to prevent future wasted 
effort. My patch is still on hold (LINK: 
https://lore.kernel.org/all/20251021114714.1757372-1-mehdi.benhadjkhelifa@gmail.com/).

Best Regards,
Mehdi Ben Hadj Khelifa


