Return-Path: <netdev+bounces-267648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B4YJi+otGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:13:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1E28ADC1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16D493043AE5
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D0242925;
	Sat, 14 Mar 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DsY1vZSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC81233722
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447212; cv=none; b=lZ6g3gvqjAXUORwGV+AUS+g0KL/SlYWLuVjT+AAnWovw0P+zmPn4nre/AIaqBWPyfBW3KR+dPtMpHjb6KJoJXbpUTzx5Kk74aRma7Y2+ankeXkDjytRa2MoquIVSWpM+QB+eYIEOKxYJy9VIpAUupGkC0J5yq8M0eCtFMy/cVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447212; c=relaxed/simple;
	bh=0OKLs8RaOuBfKdDfUIjYP1voL73M0j/TyswSNi3onII=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lsZpGTOWg0zDKJopZ7tyIf9MddDJf0rEHukXbyoLpkKlhoMPgSA2xgr+1J9F8KVIuTrb0PybDZLWlDrt5pooyHufSBON64xjMmyUpjkrJe4VtPVx4R2LJJFrY6mX9nmP2qXUoDj4gbzQ+T55esW1iFk1th+zvoTc45eRBJ5WTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DsY1vZSg; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so1758877a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773447211; x=1774052011;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcmI79LUGb4F4pYtHY9fjav81qn2V8ZW+5bs35sjg0o=;
        b=rPGQZWiIQvcyayWtFvB9lg2BbnPX/EaLY4nLTmD1M9/JLAXQpPUFOkBrYr+AzLT7Ih
         qg6fdVTTdk3ASJbr3CdVx1sLmPjWu8mHWI5srj1VrCbPkYm/woRcBtrgWxCWKP4YvDde
         aFMbxkDrs40teINLf7qkXV2pQo0Qa+SzfgOtB4+foYnB4IUkCoozYjZzk/xnGeK0KAC9
         ekOtdL8JHKLELl7nA/Jy474zld3ngtqQQhQkn7dpEVrz+8aMueW/kpkhYdZ+HfhUodgT
         +MUzTZ03t/daqqMmTPrXCwv3wQQAFTgiTX6+oUL3pVb1WKQHg/nNhTNm+rDNi+e1x76z
         sdlg==
X-Forwarded-Encrypted: i=1; AJvYcCX4BXcNOp1fFei0UPn0LtEwfEanvaXyNIQUc0SGm6AojmY3X6F4ggRZTyRglpQBVYkMeI5UhmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0RxTLTYuQVeXfULUD8nIC9ldU3YN5oPZWeMJLqTNkUZnpoAZ7
	8KKF4mXjvETpPESvXHAuQtTpFXmcJEBQiKWyOHV3voZec0eQZ6uIXn0/l3P4BrqVSxLow1qe9sY
	ieeGs23mYcpDeUiKQ05I/xwBX0mqssW8hREh3/aBJmNuJFT1C051GIFoK6MQ1alfM5/ybfaV7TQ
	FqPLU35klHQX3Ql77dJ4JbXAkon4CXTl+KjCIEGguogbUD7hWUFWeNt98Ae8VMdDmXnhD2+J3P8
	3+Ww7aje8/GGKHa
X-Gm-Gg: ATEYQzwWoJkCKaoYMGsHBGprd2BeJ0RLQBCF1uaHST1z5OHaXC8nxMAlkJHVi469V1t
	14zHkVr1MihJBgeuFhoqy3TMGeIDPbMlwqrxG+MgNMZH4IKXnwKCIvvBOYa5u4XdYeXc0vFkBoo
	Z0vxQA5fLjpW7o6xWUlb4stOJisLiPDHK+/hDp076c5GVuyZI5L2uYy7ZWn1mjHZZXueCvlALJj
	LHBeB8fnkRyU26wl7bm+MU+xFi0RODYiu8ZdgmPH9TepnY832kDWORt2Xqj0GYCiLvO6b0gXccl
	/IT1Wvdh2YG1h/7urbFowlHJKqe52IYkXS7Wnr+szZNMLyGuN+MyyfrJZQX/s8wVPORJFX0WCRv
	fdRCb0V5UtzdxMyNRFT500f9TRact5MJs2sIB36+KdB4MFxA3PCeiNX5Oi8iRZsohTy7niG/9xO
	rHN35Eo6AH6k1VUJCcrxZqxbRYPZpwJQxb7Y7RnXLgrdkosA4aGdptzcjA8GoCXFzL
X-Received: by 2002:a17:903:ac7:b0:2ae:414c:d0a8 with SMTP id d9443c01a7336-2aecac8782bmr49085745ad.48.1773447210610;
        Fri, 13 Mar 2026 17:13:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aece81cc9fsm4119945ad.50.2026.03.13.17.13.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2026 17:13:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd7d4cc049so2735465885a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773447209; x=1774052009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hcmI79LUGb4F4pYtHY9fjav81qn2V8ZW+5bs35sjg0o=;
        b=DsY1vZSgmcnD2nzz/Spf52rIRfuf1MKGRWL7EAJ57Ukk3qyGx1Y5gcWkLpn86dk68+
         eVluK4iO/J9SDACSof90jgUEKkBFTByKjLE/7Q2t3+05sVlha6u5DhCjTTXTyWeRtktz
         TwAJvrgZxQmtBluAzjYTf+tiRK0LCkzpNnXUg=
X-Forwarded-Encrypted: i=1; AJvYcCXn13hale8tA9Q4e7zvPyvYVPQZUX/jDKAHDKmGPuECQ7Gj6OZ5N8X5FkVenmyzka3coJcWD2A=@vger.kernel.org
X-Received: by 2002:a05:620a:29cd:b0:8cb:4059:a908 with SMTP id af79cd13be357-8cdb5a7e4c7mr781020885a.22.1773447209456;
        Fri, 13 Mar 2026 17:13:29 -0700 (PDT)
X-Received: by 2002:a05:620a:29cd:b0:8cb:4059:a908 with SMTP id af79cd13be357-8cdb5a7e4c7mr781018885a.22.1773447209050;
        Fri, 13 Mar 2026 17:13:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100cfsm678567385a.24.2026.03.13.17.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 17:13:28 -0700 (PDT)
Message-ID: <0b72dcba-f41b-413d-8673-97ccccab2262@broadcom.com>
Date: Fri, 13 Mar 2026 17:13:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: bcmgenet: add XDP support
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Doug Berger <opendmb@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Eric Biggers <ebiggers@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <f7e184fa-ba8c-4a95-9f08-626f81263669@broadcom.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <f7e184fa-ba8c-4a95-9f08-626f81263669@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17B1E28ADC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 16:01, Florian Fainelli wrote:
> On 3/13/26 02:20, Nicolai Buchwitz wrote:
>> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
>> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
>>
>> The first patch converts the RX path from the existing kmalloc-based
>> allocation to page_pool, which is a prerequisite for XDP. The remaining
>> patches incrementally add XDP functionality and per-action statistics.
>>
>> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
>> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
>> - XDP_PASS latency: 0.164ms avg, 0% packet loss
>> - XDP_DROP: all inbound traffic blocked as expected
>> - XDP_TX: TX counter increments (packet reflection working)
>> - Link flap with XDP attached: no errors
>> - Program swap under iperf3 load: no errors
> 
> This is very nice, thanks for doing that work! If the network is brought 
> up and there is a background iperf3 client transmitting data, and then 
> you issue "reboot -f", you will see the following NPD:

Sorry to flood you with more messages, after a little while I see those 
showing up on the console, is that intended?

# [ 4322.017024] page_pool_release_retry() stalled pool shutdown: id 5, 
256 inflight 4289 sec
[ 4331.297004] page_pool_release_retry() stalled pool shutdown: id 6, 
256 inflight 60 sec
-- 
Florian

