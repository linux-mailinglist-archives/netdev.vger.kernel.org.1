Return-Path: <netdev+bounces-300218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ggrSE5rSMmqT5wUAu9opvQ
	(envelope-from <netdev+bounces-300218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:00:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA6C69B8AA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:00:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C2rd8bzz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300218-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300218-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F6F8322B02A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C023955E8;
	Wed, 17 Jun 2026 16:52:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B9449ED6
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 16:52:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715168; cv=none; b=dZAbtOhf0RXF/gL9EyVPOen4NG7rt9oAtQhQcrx6DrnbkX4G7cIbcy73msV4ASy9xV/uZ2JewtWwqfjjEaNVSEEPxFJnBBrp1mXp2NoFfCbJuA3Gsoxz5dKw23TbFLRB0d4ydflDz6GpvJdY7OFKIDvXjqLyisY21jsxzHgQkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715168; c=relaxed/simple;
	bh=zEDi1BmmuWfX7SCwrFPimbgXnoqQsqr/HDk4ra8O6cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jO+2y+uFCSE/08PrCThBxzI93/aHvRIlHaQyrJ0Ld+1iaO9TPpXHBZJCn2zFPkQYlDXfQtz/ZH9ZYPCCLGYQOIyk9DZ5Co7b5L9qBnreHJ1oVXfwhJYGmvze3dPd9jTDXE2eOIOzWPMbdZSKI1NwmSV4V5HprRY7AM+ucjHPUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2rd8bzz; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4908b92904fso74545455e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781715165; x=1782319965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dawB8ClEsYJ7BN/4WM1+iyBptXo5GQTGjJVJ1vxum8=;
        b=C2rd8bzz1tSeODf/zcqiE9KNIneT8AtgV2T8Suh+dvK6WP4QtHrrMecuVKf9ux1wmV
         DRu1q/dCbegE7+ovNdbIwczPy/+LUnkT2HBbYBk8RKk0SPnzNSlH34N9yabq4BM9YS1l
         BwbCiIWQgBT81OUoaxbbzl7R+D/AYDd7rWRL082yt2mNImYj+BAIQ50Iz8FOWlHciiau
         IW+WW1GK7UFrO4hQvRfpyypqPnrlNIxqK/wW0xxavIZa8TaD3ReHLd2O6WI4h8RszxUR
         1Bgie2amH3iQZQevbQeNw/+JrX9CNSTui+WavPriLib7YHQq8Gk9cqj44ZX9SR4JTUxr
         nRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715165; x=1782319965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dawB8ClEsYJ7BN/4WM1+iyBptXo5GQTGjJVJ1vxum8=;
        b=oP64VHONqptYAp5KL3qP2hE4l/MVoTOpiDuJ4Nu8MfPqYQzNNdh7fStw+AeJnwwRqH
         yWfPCu67LgUXdS4PIvHFPim/z+Q00qv35VxVKZVasy+xJmeagkElRjOKOEZW22dW30Du
         /JZZWlmqHnvxIdE4ZLLflv2N/YJvi3Mn3nJou1VTlzN/x8fhXEa5+HR2Zkm/9Vb2ThS2
         6YvJ7eyKNx/cOjnWJBEd8LS+WKiHIH1SNRNSWuiB1Jl0AaLpzhlao7QWX8cTS6S6cMTm
         lEB5x1w7PR7CBsyXHea1Zotky3+pitqgGtAoI2+mr4afbJ+WoP+TcGBGD3MvlL2cpvm8
         YIjg==
X-Forwarded-Encrypted: i=1; AFNElJ/AaQ9TYBBKBOxxjLCZmtDBLwa5xFYRMBZWIquGDPAOuFlWUvdffkxjlPgD02D+tH/zmEMAEsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+H3vAQy5luV8PPhMaus8I9lQAQwU2MOOOJzueEfoXhNHR/eQD
	TmLLK4KV7aKhOcY3saRIyTngsK8+MEkDBCkRFSkzkdHrssn8yYVZGrvL
X-Gm-Gg: Acq92OEyalB4SMnuseDpfEk8fzCrHJOZ5jDgpTnYqwlhopYLNgagAGbBV0TwLO7ruF5
	E66EezjkUxyXkLpjxvdLc91EE9ti0lu03hRqAJKkJkzOJe/AZUOVk3Hh0L7cC0hlj8T3OPp5Hnv
	d7zMwpKdZgIIhu0Z5ZhjgG6i+kHsCKuDhrjy8jXe+TtmPhTHugE/WWWzcl/7SI/hJIylvqbNBTz
	KSFG4E6CemgA0Vs93HUpp2PDGS5yX3+t51rUqc9yyel+WxxyYa4GxAY/FUibSboHKbk6NgzFuVk
	YtAuAA6n7DMvwhahb8IzJ0wRrrq53utjTjJSB3MbkRFYT0AP4QtYrIfumFQca2DLzZfwD7Qin9Q
	tcIEi/UyVIIRrtFzfJNtOQIZiLqRH6QUYUTzTVjGUykxu7hLbnkX3h5U+VsL+pAZKLk+AXV6b0U
	ShCboDblQvOeXhG0HgXAf5ybDQeL3rMypnDaSwfvjazJRWjB4RPHlysEUjQGzzgFlYf9duoVSHT
	xxQu6sRmNv04dP8VbRBAlkZZRUMYmqaEDMqEHB+cPvbYkkapMyyUbQ=
X-Received: by 2002:a05:600c:6045:b0:490:7dfd:f7c2 with SMTP id 5b1f17b1804b1-49234104447mr54844075e9.11.1781715164547;
        Wed, 17 Jun 2026 09:52:44 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:8700:58d1:af07:762f:9d17? (p200300ea8f4a870058d1af07762f9d17.dip0.t-ipconnect.de. [2003:ea:8f4a:8700:58d1:af07:762f:9d17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a458f2sm168864385e9.3.2026.06.17.09.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:52:43 -0700 (PDT)
Message-ID: <523232c4-e2dd-4255-8611-119a504b47da@gmail.com>
Date: Wed, 17 Jun 2026 18:52:42 +0200
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fr.zoreil.com];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:romieu@fr.zoreil.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA6C69B8AA

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
>> If I read this correctly, max_mtu may be lower with this patch.
>> This may cause a regression for existing users.
> 
> My main intention for restricting to order-0 pages is to prepare the
> driver for XDP support in the subsequent patches. I understand this
> causes a regression but I am not sure of another way to tackle it. How
> do you prefer I handle this to avoid breaking current setups while
> still having the driver be ready for XDP?
> 
>> Did you test also on non-x86 architectures? We had DMA-related regressions
>> in the past which showed up on certain non-x86 architectures only.
> 
> Unfortunately, I currently only have access to x86 hardware. I cannot
> test this on a bare-metal ARM machine, only an ARM VM - which may not
> show those hardware issues. How is the testing typically handled for
> other architectures in a situation like this?
> 
It's not only about ARM, I'm aware of at least loongarch systems with
such Realtek NICs. If you can't test it, then you should at least
ensure that in theory the DMA-related flags are OK for basically
any architecture.

> Thanks,
> Atharva.


