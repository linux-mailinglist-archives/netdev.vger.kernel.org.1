Return-Path: <netdev+bounces-62656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17B8285AE
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE4DB21612
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFA374E7;
	Tue,  9 Jan 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RkacDmka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4A381A4
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a29058bb2ceso310216766b.0
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1704801724; x=1705406524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCsIbJ94tWG7KLA7p8rGY90hQyIqWfBskPgdkZb/meQ=;
        b=RkacDmkaycNGNG7Gu4k0+o0+UL3ycrRju/kPqeFo6yBwYBANXeoaQQ82lFI9JGkvK1
         fAEBK1OUEWXBUMDBtVzuXRJphBrZZnkyov6RQY4cq8BER6uwKz71/HzsL2DHbUXwvjl4
         KJhddWjFNGPRRZ+AY+lyK3Uk4NU5GPmz/4K68oyV57pjOuEhoVSxLFwTH45FfT7oJUNI
         XfczGijwYBmYTdzBKNasOIoFENQRJyOHPs65hxtQcWM9WYWzVg4Na031F/8gTE4MhUu4
         wcON+AKnMKD/4sr3iuSw4HskoPmQfRzwzmz120DMAORMEb9NkMl4/BV/SfvZyW8VVOE8
         botQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801724; x=1705406524;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCsIbJ94tWG7KLA7p8rGY90hQyIqWfBskPgdkZb/meQ=;
        b=FuZ7AJB6EnfHCmI/Rou2dP05dT014wxgFHgmOAapT659G5VHVr/8xnjscrpDA7eclg
         MOm9ZoZxuH3DdzIHepoHaEh0kb7RPmuBqwhQ+GUV8BRJfCIB3EksPkX0PL87Nzbt6ZlE
         2ffhXcxGP8PWSYDnu7GXZyyYjLlvH4Dpa6XBcfVlQbraDPGlfGcPKs1CLh8ubVhJc2I2
         b7JO0dhnETAcgxpVQWD/mNsaAixveW0wQGtmJ4q+p7RfrOxusWrge7TU0lgYHKdRwVB3
         CDpGQZBpoAAV903fjBgM0Xiczmi5nztYu1JCc30SJr9w+OMvKTVt+2lrvct8svHEC9mX
         mpzA==
X-Gm-Message-State: AOJu0Yxp/NG4HB0d9Gf4o22S9cg5X6XFJqd3YJUe5DecAp+qCS0+Z2Bj
	wm7PRGYpCf6XYzqzrBZGNafAbcwr4axOp+dcQnhVN0QdwB8=
X-Google-Smtp-Source: AGHT+IEHrHDTFjqKEjl3/ON0yVtkeqbZsmIb5v1irr2dJwG57uIL6t6TscxG4c1ipg51ztC1bbcR9Q==
X-Received: by 2002:a17:906:1691:b0:a19:a19b:423b with SMTP id s17-20020a170906169100b00a19a19b423bmr304423ejd.166.1704801723807;
        Tue, 09 Jan 2024 04:02:03 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906305000b00a277dd88764sm963640ejd.85.2024.01.09.04.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 04:02:03 -0800 (PST)
Message-ID: <2b3bbe3a-6796-458c-88f9-1458a449d79c@blackwall.org>
Date: Tue, 9 Jan 2024 14:02:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: do not send arp replies if src and
 target hw addr is the same
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240104142501.81092-1-nbd@nbd.name>
 <6b43ec63a2bbb91e78f7ea7954f6d5148a33df00.camel@redhat.com>
 <e5d1e7da-0b90-45d7-b7ab-75ce2ef79208@nbd.name>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e5d1e7da-0b90-45d7-b7ab-75ce2ef79208@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 13:58, Felix Fietkau wrote:
> On 09.01.24 12:36, Paolo Abeni wrote:
>> On Thu, 2024-01-04 at 15:25 +0100, Felix Fietkau wrote:
>>> There are broken devices in the wild that handle duplicate IP address
>>> detection by sending out ARP requests for the IP that they received from a
>>> DHCP server and refuse the address if they get a reply.
>>> When proxyarp is enabled, they would go into a loop of requesting an address
>>> and then NAKing it again.
>>
>> Can you instead provide the same functionality with some nft/tc
>> ingress/ebpf filter?
>>
>> I feel uneasy to hard code this kind of policy, even if it looks
>> sensible. I suspect it could break some other currently working weird
>> device behavior.
>>
>> Otherwise it could be nice provide some arpfilter flag to
>> enable/disable this kind filtering.
> 
> I don't see how it could break anything, because it wouldn't suppress non-proxied responses. nft/arpfilter is just too expensive, and I don't think it makes sense to force the use of tc filters to suppress nonsensical responses generated by the bridge layer.
> 
> - Felix
> 

I also share Paolo's concerns, and I don't think such specific policy
should be hardcoded in the bridge. It can already be achieved via tc/nft/ebpf
as mentioned. Also please CC bridge maintainers for bridge patches, I saw this
one because of Paolo's earlier reply.

Thanks,
 Nik


