Return-Path: <netdev+bounces-300216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wgc5H+jSMmqh5wUAu9opvQ
	(envelope-from <netdev+bounces-300216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:01:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECD69B8D4
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XFqs8fIg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300216-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300216-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090C932097D4
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE813FAE0A;
	Wed, 17 Jun 2026 16:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8044C9548
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 16:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715024; cv=none; b=Ks8RpZY45xOYD700QMx+m3vksdOdpBDUAMgWZZxhtKXTrcl0LVGuanxMg9A73OXI8xuVR4TIEQOsGq3Q2bgjZB3Qw+qEGEAvMaTX+i+DKyjNIfn0cORC603Z6NR2H/YazfcRaDojKMhzKgumz174v1XrKa0uo8HCV+6GnQGD9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715024; c=relaxed/simple;
	bh=5W4cmUnSvJebGgX72dxHH5s93z4uEUUxOsLpxpGk1xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVqYW5FjOKSLm3xXwZ52jl2a1H2ix2UmPiv+jlZKWxnFGbxDriMVd4sg5r7qcolgncfxiCCITKyuwPpKZOP0tWG8UkH5XtA4A9lO3jf4szhxsKwwz4evlMqc+Bhad2Q839hETUsPtrQuHkOEKmBABKtc119RHRBaga+BOUahjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFqs8fIg; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4631679f204so427287f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781715019; x=1782319819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCkh90iozDZAIJLETl4lX/v4w123Ar9P2GbA4NwH8eY=;
        b=XFqs8fIg+p4a+MRvs0UPlLKRwooPqXTv/9MA1VLLmn0rK2tF7ui6CT7GKNMF+U0dQ6
         +4Dl9AJNU6Ps0y2FbePqxwwnw4W/tP24wnHFpNRHdLNCTtVR6UFYlx21bedxzWmG8T3y
         2jjUtP1G3VUiJSDe1fvjXN5JFo7rnRzqMqmWbQm7HH0GEQCFWapnWXsMXo4yiMzv1mRO
         3LCc5PtumkRANjPTn6V5InzYQ1+jccvq+2ObXyewoChwC+Stfg/w+bHt6pX2s6BW+dSf
         YXk9ZrWx7AOaU3Fv6xKU8yNVaVXJ/38JXQb19B3y2DU0kg3fi4lxdfh8EICoV0jmb0Wn
         3v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715019; x=1782319819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCkh90iozDZAIJLETl4lX/v4w123Ar9P2GbA4NwH8eY=;
        b=dSEvwcWNpoqHUWhQQAxXS5Plv9vFl+ATfwhbhixRYjITzKJty7fCEevv8R7XYVLjOy
         0t1DTx6CG2OB8tlwm438yuawhMyQYBGXvEqVJvRPpoYE/QUFejHM7SmIGWdUGF/j0cgO
         v9BGPOwQikXSMDCiDzfVVNKm5Ehp8pCqU/BilFQA/jb26MdSjF87H4J3LH6n1ILHm/GE
         DEKb1D/XZ/bcVEoLNbmOVu1c8pVf1jkkIopN011KqJNoz+fxKKgsAhamxt6Jv62r46Oy
         5wnSdlp6H9cYIf3LK3MDJ6uV3jOsADGCMrbCEBBCo2iTMHi6cZO9el78G3qOHNI3LmLN
         JFMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/04sz7im1zVjQ9ZNKvx2zLCaomsIzbcpW8YfKOJ5gdSSBYRdCa2cJxt9+bggatuY0qc2jvEck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9L8h3KTq3NhXy6gvJwJFP19V88RWvAcHqSWAnfMgdlkdijxS
	gFwN36ZF4gmP2HNlyFIquUjDO5IAW6nhm56+egsiduDp5bj1M6fLHYhF
X-Gm-Gg: AfdE7cnm6V/qv5QjKwxYemIXGmD7QxPWseuHwi3ND/RDG95H/ecDQDdmoueVq2CPvut
	MPNA8Dwg4Th2G9N+qPOWhC0lfh+z2owbUooypcNuGPc3sn30rt4iDfyqQlrJU79OV50P9FUUy3a
	1bqTCtY3F+HA+FggdPw/XWEEJckyG/7s149B3CUKejQvXcu8ptekTHXobjOmR0hvXKSZ6cknZCs
	bBfT4r9fBsir9YtHNmNiFeXtXTm8gnjuzjCeD5367NysZYB19iQPz3mRORYUowD5bPyYfDI4kct
	1fVoZGjIUDRH6+zFlnAx4yMrjL4aTzH6YxhFggpvPNZsfER7v6tDjsIvhU8lRiBYdNiy2DwKAeW
	eOl14rH7OGEWbcW9eoRfHbcrCRkls1cCTIW+wTXgSCWGqECtkzn7Z8m0dUC2kbvuFTdJSqYBGLc
	l/rKOMyIX3lVj9u4DvnreUsiDMTkgAS/sLOLH/aautQkJVTwkiikALDeWWTPYZaVXI1HiVgB1g2
	O6AxeIq3VYxSGGIT9W15M1+UKlJQM8YyXVpud8vhcVS+2mqSlNnI+rSEjzv/Zbodw==
X-Received: by 2002:a05:6000:4712:b0:45e:f295:33cd with SMTP id ffacd0b85a97d-46396f127b6mr529875f8f.11.1781715019243;
        Wed, 17 Jun 2026 09:50:19 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:8700:58d1:af07:762f:9d17? (p200300ea8f4a870058d1af07762f9d17.dip0.t-ipconnect.de. [2003:ea:8f4a:8700:58d1:af07:762f:9d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26393asm58463363f8f.5.2026.06.17.09.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:50:18 -0700 (PDT)
Message-ID: <7fe74f0d-b81b-4bde-bdb6-97932a1bdb79@gmail.com>
Date: Wed, 17 Jun 2026 18:50:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: migrate Rx path to page_pool
To: Atharva Potdar <atharvapotdar07@gmail.com>,
 Francois Romieu <romieu@fr.zoreil.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260614054137.32181-1-atharvapotdar07@gmail.com>
 <20260614220934.GA3575431@electric-eye.fr.zoreil.com>
 <CAF9AHva0TSFz5tedMEgJTkhThzDGqmW7MJshAtf3ULbLY4wd=w@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAF9AHva0TSFz5tedMEgJTkhThzDGqmW7MJshAtf3ULbLY4wd=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:romieu@fr.zoreil.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,fr.zoreil.com];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[hkallweit1@gmail.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23ECD69B8D4

On 17.06.2026 05:28, Atharva Potdar wrote:
> Hi Heiner, Francois,
> Thank you for reviewing this patch.
> 
> Francois:
>> You may consider fdd7b4c3302c93f6833e338903ea77245eb510b4 and some related
>> changes around that time.
> 
> I am sorry but I don't fully understand the context of this commit or
> the behaviour it addresses. Could you please help me regarding what I
> need to watch out for this change?
> 
> Heiner:
>> Assuming your link speed is 1Gbps, 470Mbps is quite low.
> 
> I apologize, that was my benchmark figure when I passed my NIC via
> VFIO to a VM for testing. When I tested it bare metal again with
> iperf3, I hit line rates of 941 Mbps.
> 

OK, I see. 1Gbps isn't really a challenge, the same at 10Gbps with
a RTL8127 may be more telling.

>> If I read this correctly, max_mtu may be lower with this patch.
>> This may cause a regression for existing users.
> 
> My main intention for restricting to order-0 pages is to prepare the
> driver for XDP support in the subsequent patches. I understand this
> causes a regression but I am not sure of another way to tackle it. How
> do you prefer I handle this to avoid breaking current setups while
> still having the driver be ready for XDP?
> 
Is XDP in general not supported with bigger jumbo packets?
You should find a way to avoid the regression. Intentionally introducing
a regression I don't think is acceptable.

>> Did you test also on non-x86 architectures? We had DMA-related regressions
>> in the past which showed up on certain non-x86 architectures only.
> 
> Unfortunately, I currently only have access to x86 hardware. I cannot
> test this on a bare-metal ARM machine, only an ARM VM - which may not
> show those hardware issues. How is the testing typically handled for
> other architectures in a situation like this?
> 
> Thanks,
> Atharva.


