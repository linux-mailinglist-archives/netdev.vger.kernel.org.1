Return-Path: <netdev+bounces-281514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMMdJ1Ti72kHHQEAu9opvQ
	(envelope-from <netdev+bounces-281514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F2F47B68A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 488153019526
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48003A1A4D;
	Mon, 27 Apr 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V2iIAmwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34884346AFD
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328592; cv=none; b=lIaVcg+SZW+CBw+RrIC6YiYjj+x2qdiy+foNKcMDyVLKtigomp3pGVA2+Upc86fEKHfLuuyoZTk8M+tGPPDaZmK4YfI1o2wxifofFpZbEF4lKCZ8YLDxTTLZ2uU9VgIuluTOkmVdqRGNBw1zVkGzG8EBzq1aKYNW/tkCuJqnJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328592; c=relaxed/simple;
	bh=bq+hxJNmv5+Vx6zRLS3YMDO4N8SViOW8PurvhIIsR5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqj2DSU4BVEl2TEiw7knSjiJIJ0pkyEHvhlumdtuDT0/c8OVwstinX0B6lEnBJRI3CvQl5nDNjTSli9SLG01b8pZazlS7pJYOASZSKCPxV1/FbaXUegkE0MbXGri8CBUwacgFSAFXO9h73EYvY5rsgkBlDmSOTmRIhddL7iTbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V2iIAmwa; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79db5e18ac6so124425617b3.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777328590; x=1777933390;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqRpHZiFAqmQxe465X740X4bBc+25OV3oIArZNr6a3s=;
        b=nOmOFFSlA2+MonTsKikI8XJXbC+jVBWE8GDZxl3/zpJ1EJr8x/XOMFGgMQDMY4+4zt
         GNRJKjDMxc7iFLhaTeitgUcgyAdFZRNR3y9beuxmwXo2ZxEoL7wKz00Q1hJOxO4JoqED
         7W7OLq6QY/+GD7eGP2qvjOFA2f5H0Ffr7nxtUhlkkik79hn+vqDLvB+NI1EeP3mK6jfU
         +IloWZDuJfuSKAK3EIpRjyl74Y8gxmuDAlyYuZM42FQYZCruJE9GlNS1aDbWviNf1FHo
         pO+nDfpFPywNTj67+NyRMist25BLetJzDddqntKSI3XmLpgFsJlVskb5n1yqOJh4jHRR
         Zupw==
X-Forwarded-Encrypted: i=1; AFNElJ+w6sG/F4Jty3A8+7ba5eq7w+wR0Hjo/GBCiCsHEke5+fiumP4ElQxdonSUMg8yeL4mYhumOEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wAHh1oIgKP5aDePkoh4/4r0yYZW2a23ekVtYshicsEZo3XkE
	kIxbkmk/bfOQWF7/P6txoU8YSbEYmnweVdy4/Z8/XoQOT2jMrB6S2YdlaT6pVJtyNPTBjnUvc3P
	MAu0iFcCaGZTF8twRBcUnbH0PlIbOJ4Xp8WqIah70EN7JnVYuHF+7Y2OsffMhWgndmGD6fY8TBC
	9N3PlItGNvnZ5Pzz2UGMTJL2fSlky2LaOxHKmrojqCvpefldEeKtrOncivR4od2D54MemvYizPb
	uKvHiusbwcxXJe5
X-Gm-Gg: AeBDietq/HPqV6Qer1vQ3aQXNMrsVPiqL4hD1wVNu1Nj6oDukifu70cgQ6ISqrigwf6
	unqY0+HnVRbqcUISRLRcYxBFfcUgSTcW9+rprTrcoo+/awgQe/9QpIzdsOwxPQ9EM0RRmLi/VRY
	GBQJXqmSrRQXIxSRmuHaYnlX57k3uyay+qoGrA4+g/qqrD44GzXhTUO10dWVRFYbfhzbPv8ssBj
	87FbdtTCnVe/xgvp+g2FRqI/4r7mFTFsXthdEWJlJYvifY1Tr1tKIE2OA+fYO30ym/S04V8E33L
	o2xHFcIF1134NJsiVg68X5a3LQOTtJiJmLAaRq/2IEHvUXee3RjT/2C+iuqtUUZhK2BJ3MFksWZ
	t4+McOq7EJYa+ancQzmNX9GWE9xxc4YOEadSgTzgejZQbfRRsP1rPVZnx4CcRNzylvCd3XBBbrv
	ydTYtnGUP9ha77NxvvJYE1OaYmOtELpiXnmuXFSsYWY3zSSbMVvltyACm7YIJqMjcj67maOVHL
X-Received: by 2002:a05:690e:12cc:b0:651:d0a5:cd8 with SMTP id 956f58d0204a3-65bee77aed9mr490399d50.16.1777328590161;
        Mon, 27 Apr 2026 15:23:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65bee2ddbebsm30028d50.11.2026.04.27.15.23.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2026 15:23:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12dd33dc337so1186461c88.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777328589; x=1777933389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vqRpHZiFAqmQxe465X740X4bBc+25OV3oIArZNr6a3s=;
        b=V2iIAmwaLeo3tRv8f7PIKrkFcLokbBTKkiyvpMmLnCTp5wwhZoqfmeIUGuXaSRZGLB
         +oVLoDNxatBOklRCEqB0wEcuFBt43CQqU7KSHPbi+3/yvbAo3BkDyabujrqgS4bK+f/J
         FqfiOcMevr+PvpAQQIx3IlkzlSd0g8Id0Wsm4=
X-Forwarded-Encrypted: i=1; AFNElJ+zrXvLR9ayPGiLPcOFr/67kWrGkuBZ4b4+qOsYx/h+mP0cFiQAM1G505ZqoqV87KMj+A4CQxg=@vger.kernel.org
X-Received: by 2002:a05:7022:4389:b0:12d:c9b6:bbe2 with SMTP id a92af1059eb24-12dddb2c78emr213836c88.2.1777328588841;
        Mon, 27 Apr 2026 15:23:08 -0700 (PDT)
X-Received: by 2002:a05:7022:4389:b0:12d:c9b6:bbe2 with SMTP id a92af1059eb24-12dddb2c78emr213818c88.2.1777328588211;
        Mon, 27 Apr 2026 15:23:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9b1e3bsm635498c88.13.2026.04.27.15.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 15:23:07 -0700 (PDT)
Message-ID: <10bd7851-e9dd-486c-9ae0-e8750167c7b7@broadcom.com>
Date: Mon, 27 Apr 2026 15:23:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dsa: b53: hide legacy gpiolib usage on non-mips
To: Arnd Bergmann <arnd@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Roja?=
 =?UTF-8?Q?s?= <noltari@gmail.com>, Kyle Hendry <kylehendrydev@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260427143020.2800317-1-arnd@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260427143020.2800317-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 22F2F47B68A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,broadcom.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/27/26 07:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The MIPS bcm53xx platform still uses the legacy gpiolib interfaces based
> on gpio numbers, but other platforms do not.
> 
> Hide these interfaces inside of the existing #ifdef block and use the
> modern interfaces in the common parts of the driver to allow building
> it when the gpio_set_value() is left out of the kernel.
> 
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Small nit: subject should be prefix with "net: ", and a target tree, 
like net-next. Since net-next is currently closed, you will have to 
resubmit.
-- 
Florian


