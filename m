Return-Path: <netdev+bounces-267636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLS1KVqXtGluqwAAu9opvQ
	(envelope-from <netdev+bounces-267636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:01:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AFF28A91F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF25530A4740
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC93822B1;
	Fri, 13 Mar 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DJNbOBtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935034DB74
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442901; cv=none; b=CnEPz7ktcSxDj87wHSNkdB5LEIqBTp32b5qOjv1krCWdDG8kkmAxIsg9aTZX7iMhcvfCcQKTWsfjuYV7Aa02cF/nWKM34PGL6jPC16fk9a45yH0MyXRfLIV0NCNLmVd+SJL3UwtYepwG/qOaozj99O1H48b151auYpGZ2/oAIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442901; c=relaxed/simple;
	bh=7SMNboWR/j0cymyIrPPcyWtbzuKx8Ba/8gHfSqMT2E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYapboJzvwe8mpOA6zSl7ZTjGX8J3JH1efBQvKYeOTGnJULS8BxrpTepqqlyUN0nGlG8YwAXOLhfTIDXiJrMykbLhL48EEkwffbbgKdquxANwU/mGEmt8ESiI94zb7ZDe7HCeS9usybS9kz10ah/RiZAS6DKG0aE7DRrg6SGkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DJNbOBtJ; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-56b1b9899d2so2245316e0c.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442898; x=1774047698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMulMmXSixwpfrBnFM+KvWC268VUN5S7cA68yHQsSWY=;
        b=m36CTGRvFNmsP67/4hosJeyMIMh+cnw5Ywty832d2o0+nSso6Q05M36DJVPGUCr9Jg
         +oVr3nbbGZx0nJTCspWVLK4fan8p2yijrLG/j9LDKscf9p0cVepwkCfioHivFW1R2BXw
         jTzMlQao7EWVMwzu3RlpMm5ddrhbOvvDAaBjvUBSsqmFuvJXZe6XfO9ZxRCY8TY5u0Cm
         TXTG8utWBrwWDrtGebM3hvN2l7UNURsYdNaCsAYYH8DnqvD/0biKvWHp6BxWF9GUPbjO
         nAJFxFbqHVOvQH81bDnko7iBX4ApyXnFpCjJayK9BEOAPsFHNSvLNVMdU79MM95VvfYQ
         KsmA==
X-Forwarded-Encrypted: i=1; AJvYcCXxDuK5at4/fbdgBdSUEvk90/+QhWWrDJoWfKFArlAw43DIdaXP9L63ODQz5F7IUzf5Cmgu108=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznw/iFK0ZDDF9+rYx1P6TzFoGpz5+rsD0dXriUNNFfViV2n3CK
	N1jkGFkSdpa1MdVwriO66rEQY7+H9LagvayeU+wCwRx7caRKZf8RaYFoptwDhi13aAj1I+0FF8l
	l/j/vEd22cBp/kDuUGXZy0rqLw1GJOeWWxhjyfWfIvnmlEpMa5PyjLG+Hij233Xaxsgvcg6AKlb
	zYReqmMEQN8Bw4Sosn/ZyLJ/T6t9jj+i+W/RVbx95kAmY3xyOzhlavOUfBCk/EAv9JKBZe/Agaq
	zPKdeF/+6mU4sDG
X-Gm-Gg: ATEYQzwdvisoZWu6rvbiGoWoCjiL5dYlstna8IiNk7Cnj5ITupZo/X7w1xED9jLR/u7
	E8taykanMqZH6me5QkGFd3NhqvVSWTqudv1O0Yb3jv+AUBO3xMr/fjBOAR3rM2p2XWvQ5ULOWe1
	equOlsPixCWtWTl3ToP78uZPjRX0jVMZfcYQ1neeqsXIFqdA2fz7sl9igYASAK+5WrbIXDSIN3H
	1Er5Fg8zAd1vBNka4WkQbbxWuNg8/3ndOkYj8wj+dcyUa/clMYoOvzbimmd4tSuWm2conYsjiCe
	m9oS3mhx5UDTY7rQmukkSN92CuPG2dDowXYCEvxoL+9yv7vJHQ83xGu6j7alGvlPU0HcWBCKobN
	hcuGOvwVOCeJEHed5Y8n7H7zAdlzptc2Cu79wZyxaNv8tq7gC5ZA5IAwf2ZhiSlq1C8cZ1A/8L+
	wjd1iA+/BKSj1uSMl9FtpKCge2vIM/Y+/ZUlwLJyaWrPEJByj4k8QA/6t3JEFXdg==
X-Received: by 2002:a05:6122:3d15:b0:56a:8c20:2d9b with SMTP id 71dfb90a1353d-56b626c7cedmr2303001e0c.0.1773442898546;
        Fri, 13 Mar 2026 16:01:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56b464712fbsm1044891e0c.8.2026.03.13.16.01.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2026 16:01:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-509162597f9so202921101cf.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773442897; x=1774047697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bMulMmXSixwpfrBnFM+KvWC268VUN5S7cA68yHQsSWY=;
        b=DJNbOBtJZ+ktu6uQBfaWJ6jinZitOOYxEyDM7cVHVOov9WZzvWBEyK1zytS26mLaj2
         e6AYPVVzrEcoLjHYB5S6CI0dJKQMLechFl5q+KQ2UShR8MloTDBKbyo8u6pvZEI7Amhd
         6fuaNAjM9htu0ejseIqijASwLeQ4pMo8xdxr8=
X-Forwarded-Encrypted: i=1; AJvYcCUpBLSjdcP5PgpY1MQUM4ytpRgRZzDg8ihzGqA6+GR/dXa5UL0tWmTevvguq0m+AVEqBIxaa1U=@vger.kernel.org
X-Received: by 2002:ac8:7f8b:0:b0:509:3c8c:23f7 with SMTP id d75a77b69052e-50957d5b09bmr65069181cf.30.1773442897007;
        Fri, 13 Mar 2026 16:01:37 -0700 (PDT)
X-Received: by 2002:ac8:7f8b:0:b0:509:3c8c:23f7 with SMTP id d75a77b69052e-50957d5b09bmr65068721cf.30.1773442896532;
        Fri, 13 Mar 2026 16:01:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm75536546d6.19.2026.03.13.16.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 16:01:35 -0700 (PDT)
Message-ID: <f7e184fa-ba8c-4a95-9f08-626f81263669@broadcom.com>
Date: Fri, 13 Mar 2026 16:01:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: bcmgenet: add XDP support
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
In-Reply-To: <20260313092101.1344954-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267636-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[tipi-net.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[192.19.223.252:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09AFF28A91F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 02:20, Nicolai Buchwitz wrote:
> Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
> XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.
> 
> The first patch converts the RX path from the existing kmalloc-based
> allocation to page_pool, which is a prerequisite for XDP. The remaining
> patches incrementally add XDP functionality and per-action statistics.
> 
> Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
> - XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
> - XDP_PASS latency: 0.164ms avg, 0% packet loss
> - XDP_DROP: all inbound traffic blocked as expected
> - XDP_TX: TX counter increments (packet reflection working)
> - Link flap with XDP attached: no errors
> - Program swap under iperf3 load: no errors

This is very nice, thanks for doing that work! If the network is brought 
up and there is a background iperf3 client transmitting data, and then 
you issue "reboot -f", you will see the following NPD:

[  176.531216] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000010
[  176.540052] Mem abort info:
[  176.542854]   ESR = 0x0000000096000004
[  176.546614]   EC = 0x25: DABT (current EL), IL = 32 bits
[  176.551938]   SET = 0, FnV = 0
[  176.555000]   EA = 0, S1PTW = 0
[  176.558149]   FSC = 0x04: level 0 translation fault
[  176.563037] Data abort info:
[  176.565924]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  176.571421]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  176.576489]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  176.581813] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000044d02000
[  176.588286] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
[  176.595101] Internal error: Oops: 0000000096000004 [#1]  SMP
[  176.600774] Modules linked in: bdc udc_core
[  176.604976] CPU: 3 UID: 0 PID: 1575 Comm: reboot Not tainted 
7.0.0-rc3-g08ac0b907060 #2 PREEMPTLAZY
[  176.614124] Hardware name: BCM972180HB_V20 (DT)
[  176.618662] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  176.625636] pc : bcmgenet_free_rx_buffers+0x78/0x148
[  176.630618] lr : bcmgenet_fini_dma+0x104/0x180
[  176.635071] sp : ffff8000836d3910
[  5]  95.00-96.00  sec  98.4 MB[  176.638390] x29: ffff8000836d3910 
x28: 0000000000000000 x27: 0000000000000038
ytes   826 Mbits/sec    0    819[  176.648318] x26: 0000000000000001 
x25: 0000000000000010 x24: 00000000000003c0
  KBytes
[  176.658238] x23: ffffffffffffffff x22: ffff0000086b4a00 x21: 
0000000000000000
[  176.666766] x20: ffff0000086b8600 x19: 0000000000000000 x18: 
0000000000000000
[  176.673917] x17: 000000000000fe88 x16: 00000000000733f0 x15: 
00000000000005a8
[  176.681067] x14: 000000291895b141 x13: 00000000000733f0 x12: 
0000000000000000
[  176.688218] x11: 00000000000000c0 x10: 0000000000000910 x9 : 
ffff8000809b4ecc
[  176.695368] x8 : ffff0000058531f0 x7 : 0000000000000000 x6 : 
0000000000000000
[  176.702518] x5 : 0000000000000000 x4 : ffffffff00000000 x3 : 
00000000fffe1db3
[  176.709669] x2 : 0000000000000001 x1 : ffff80008103a108 x0 : 
0000000000000001
[  176.716821] Call trace:
[  176.719271]  bcmgenet_free_rx_buffers+0x78/0x148 (P)
[  176.724247]  bcmgenet_fini_dma+0x104/0x180
[  176.728353]  bcmgenet_netif_stop+0x1b4/0x1f8
[  176.732633]  bcmgenet_close+0x38/0xd8
[  176.736304]  __dev_close_many+0xd4/0x1f8
[  176.740237]  netif_close_many+0x8c/0x140
[  176.744169]  unregister_netdevice_many_notify+0x210/0x998
[  176.749578]  unregister_netdevice_queue+0xa0/0xe8
[  176.754291]  unregister_netdev+0x28/0x50
[  176.758221]  bcmgenet_shutdown+0x24/0x48
[  176.762153]  platform_shutdown+0x28/0x40
[  176.766085]  device_shutdown+0x154/0x260
[  176.770015]  kernel_restart+0x48/0xc8
[  176.773688]  __do_sys_reboot+0x154/0x268
[  176.777620]  __arm64_sys_reboot+0x28/0x38
[  176.781638]  invoke_syscall+0x4c/0x118
[  176.785397]  el0_svc_common.constprop.0+0x44/0xe8
[  176.790110]  do_el0_svc+0x20/0x30
[  176.793433]  el0_svc+0x18/0x68
[  176.796495]  el0t_64_sync_handler+0x98/0xe0
[  176.800689]  el0t_64_sync+0x154/0x158
[  176.804362] Code: d280003a d503201f f94d2e93 9b3b4eb3 (f9400a61)
[  176.810467] ---[ end trace 0000000000000000 ]---

That does not happen if you do:

ip link set eth0 down

while there is transmission in progress, FWIW.

pw-bot: cr
-- 
Florian

