Return-Path: <netdev+bounces-261599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC4SEPa6oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:28:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957861AFCAA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C128D30465E9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB544BC8E;
	Thu, 26 Feb 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P8/lBZii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE4428463
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141173; cv=none; b=blqSfO2TUOO/lpqQybZTyND7IeINJoJv/JOyfDlT24k0xqTbA8ZYqUGWLogtB13TJbCAOjf7djcwieBY41YORWxZDIdJ+1uDF7nvqvccMjhROfDkHhsAYr0P9xOO5TirwT8j4NWvPvP4XDbwQSsS2GntTDX+b69pyEK1EEMaig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141173; c=relaxed/simple;
	bh=W2+6q35FY5OiABA/Ce6GwXS7eXYXfn7QjI9DrEPc7mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIZy2RgDGqt7Ei4D8CcT94GZpAIoQ2P3KxWgXu+voblzSpyclFgAf+lGA+q+2eZ3TZO84i7cBvxSvzVabS00TJYRUvXq9GHXlNWkaTPBKMkK5qMwlFq79ISln+vt2ApBXqk/gJmHEGknucYlBwbYmgAePmkS4+gaNkKwor2Gakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P8/lBZii; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2aaf9191da3so8027485ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141171; x=1772745971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oaGm5OWIX8fCRKDUcvGx1IkCPkexsdhy4XeOTZzomI=;
        b=qNS4NhebJu4bohnlkkYyj1NwEoBwPeBwoU9RCX8Aqz+UGYA0U5EqrncW3SWnubK3O6
         Gxya/B3efuDxklpoZmnA/ChJmd2bCnpx6RgBCGO14EaSoj2ySDEpdpNebR8tQorct8vb
         VBk9OubGmOkclPkHjZgtAv7LadzNyKn/uPz6fpmlHsOiw2nmNL+o0UXY8uLAl6h90KDW
         UPFp3RT/AOraJt7H3aNGGnv9dQkB7/4jBJWStGiD9KqoAYYmzY64hBoHKS8BPiXu4U38
         KLSWhTQR58CWXYH5uRUrgFVv66a6EGKg5s+HFDoIJ5E5roTwhIQvRqS3PbevfjcxGwxW
         0lzA==
X-Forwarded-Encrypted: i=1; AJvYcCXUdefY4LncgXBzjlC902CAmY8K2HQ84DU5RmqpNCgH4qIwkxLu77diwgibs2F9olhW5E7g9Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aUC4sefPrqoyb07Y1g/1f1as+JNGt/XGHUgRi7BGIeZK8yBG
	BFnTFKFeqO4tkYsrmrDJ8yxb9x8nGLn5Kf99afr4ROm6nxgmrUUFAbjrxIAR5oL0jWAVb3P9tSR
	/zyPtQBf94pVAOuJWiB5Yo0k0K+NbjZpyGS97Xl4GRFrqgtrEs8c4anYskPxt6AcscHPObeIWju
	S8w5+PJQdSmDi1W8iFWflz/TjTgpEL4nS2ZZmn+/qsNd/7rSB5ANpgdW173EoUUxLdgIQE3qQvb
	496ERKfnGj8cjGi
X-Gm-Gg: ATEYQzxUuHpSgBg7at4y2KD2y90ZCEw7lJFAKZP9PblZsBkwGRbY8T5NbcmdQ2H+jaI
	IGFYYtFzGUkbo86AOPpFPLLaxyj1KPI3nzu3hItbpLwXV3ErWgwrr+QrrQVA2bY4W30FQh7F088
	5oJmedlkiz/kFeUsAHVnObWqwCLj7nEk0UBkQ0A6wUtL/M6Q4GwXZ9IaZ4w1A/3dZtxENnRdoej
	wK8BW3S0lG9FiQfuhFwafDVOcDmUVewlbWUQ/ElaaYCtLTqZtFL2ha5+yT6pwjsk7l1UuatCGqL
	+qnpP7tebI32MCReEmwaZa71qpK1qQnbgi7JgUgDrzqe9IQS3f3o2iRZPIYFA/OS3tR/zzMutT0
	+9PeF153hnbR/7L7B1ARN6aANoQ/sFcf3xjLr0pTaT43FxY+JBn1SGlXAlCrPPB2tUFPgBDPp07
	M96aRgDN9agvDApVT/ZlZ49qhYTUnt5ilklGefkp7R+jlysPk7b6fGhdzr5FTyIEA0
X-Received: by 2002:a17:902:db11:b0:2aa:cfee:a47c with SMTP id d9443c01a7336-2ae2e4134demr2525355ad.52.1772141170882;
        Thu, 26 Feb 2026 13:26:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5dba8esm3658415ad.33.2026.02.26.13.26.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 13:26:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdbe1bd565so1691106eec.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772141169; x=1772745969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4oaGm5OWIX8fCRKDUcvGx1IkCPkexsdhy4XeOTZzomI=;
        b=P8/lBZiiGgYvg2JMGJUjTfKwaWvdEeuLjgi0+TU3ULLWxYTFdxxCg05qYGPUHI3cgB
         Z01HIloR4DpmvxZkJF5YTlUMVGxEFPgjBZ00ID+KZ/vqJENxF7mo7tMeH497LpuhfW0Q
         dTgqiEipEkdFckxNvJeD//DAIy7MTNH6MriuA=
X-Forwarded-Encrypted: i=1; AJvYcCUiGI01h1if7PiE0M7tfEw54CpKiqIlUftevboifRsrcFwJqUt8N8vxqYl2A7mLB8LwHqxMB7o=@vger.kernel.org
X-Received: by 2002:a05:7301:608d:b0:2ba:a075:5423 with SMTP id 5a478bee46e88-2bde1d6b0fcmr228796eec.30.1772141168977;
        Thu, 26 Feb 2026 13:26:08 -0800 (PST)
X-Received: by 2002:a05:7301:608d:b0:2ba:a075:5423 with SMTP id 5a478bee46e88-2bde1d6b0fcmr228780eec.30.1772141168311;
        Thu, 26 Feb 2026 13:26:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f81be1sm2559836eec.33.2026.02.26.13.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 13:26:07 -0800 (PST)
Message-ID: <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
Date: Thu, 26 Feb 2026 13:26:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com>
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
In-Reply-To: <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261599-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 957861AFCAA
X-Rspamd-Action: no action

On 2/26/26 12:24, Rafał Miłecki wrote:
> W dniu 8.05.2025 o 11:14, Jonas Gorski pisze:
>> When bridged ports and standalone ports share a VLAN, e.g. via VLAN
>> uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
>> still try to forward traffic to known FDB entries on standalone ports.
>> But since the port VLAN masks prevent forwarding to bridged ports, this
>> traffic will be dropped.
>>
>> This e.g. can be observed in the bridge_vlan_unaware ping tests, where
>> this breaks pinging with learning on.
>>
>> Work around this by enabling the simplified EAP mode on switches
>> supporting it for standalone ports, which causes the ASIC to redirect
>> traffic of unknown source MAC addresses to the CPU port.
>>
>> Since standalone ports do not learn, there are no known source MAC
>> addresses, so effectively this redirects all incoming traffic to the CPU
>> port.
> 
> This change broke standalone ports (those not being part of bridge) on 
> Northstar (BCM5301X) devices. We got reports from users about WAN ports 
> on routers not working anymore:
> https://github.com/openwrt/openwrt/issues/21187
> https://github.com/openwrt/openwrt/issues/21349
> 
> Can you take another look at those changes, see if something me be 
> wrong / missing?

Checking the BCM5301X datasheet, the register definitions look correct.

The first report appears to be for a Netgear R7000 which AFAICT would 
utilize port 8 of the switch as the CPU port, which would be correct.

The other report is for a Netgear R6250 where port 5 would be acting as 
the CPU port, that could be an issue unless the switch is also 
programmed to use port 5 as the IMP port.

Could you try to program GMNGCFG (page 0x02, offset 0) bits 7:6 to have 
the value 0b11 which is dual IMP port (IMPO is port 8 and IMP1 is port 
5) and see if that helps?
-- 
Florian

