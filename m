Return-Path: <netdev+bounces-300406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HF3CCKnNM2ojGgYAu9opvQ
	(envelope-from <netdev+bounces-300406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45369F80E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:51:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=VJct+FmF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300406-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300406-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6D6A300729E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276A390204;
	Thu, 18 Jun 2026 10:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544239D6E7
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779868; cv=none; b=djTzq99KdL9a/7rfPDsd+q93IiB0pysYggagLeKXofaJbJf03bV1UHIgEgyYQC3R+qdcpPfY4wSx3yHbjek+GVODnwBxpRdld9PVvtvM4MZmQPpnByv4O0H1e8n1BdGTw4qtD1xFyA2S3fcNwJkosV6CtzV3STosxgo/pCi2OsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779868; c=relaxed/simple;
	bh=cmuTSsCgNAJE4B9L+eGkzn08EDZSleRnAL/KhaOgNic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F37pn7FtR30cQcCpTX53dd5DaDkOtVkzmVqIJOH5NU1bhqfWI742WzqDelrSVes4uujR6JP0QAlD9B5Qs2IeviDiFRsVtthNeRr9ofy9BqU4ZP1tc+s9JZDZI3dtpoRhVlxkDNS+8gaRwCDbCFUQow/W3uf3VDr6qRk1bJWcDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VJct+FmF; arc=none smtp.client-ip=209.85.222.228
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-91591f19716so100905485a.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779862; x=1782384662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+MRDwuUQuk4HJCf9ITWIh7vsEHgsSIvVGf6giRg95o=;
        b=XJBy5vcV69L+UgnJq1oEQ+5/3z1ny7ZGNV6f09AUnds7haDdwily03rYO8Cb2L/FPL
         FuTrJt9WeDJmKlD+qjFYOWQnwvpnYTxnikBDDg8enuzyaKygcLAwRSNx5LDVxJutLfI3
         naQacGFjhsoPl+5PeLuDkEZYRw4AyTLA0V1Tec3mfrGFL/zYvW5wKuBNP07EJHYJPQac
         Tw1DSZYinEeH68c6Oz6uRffchhrP9ET3v+ay3WZ4v0UD5nt9ZI2ZIHURJaiijtyhG0Fi
         eqwMATUriTzNymWwV/yuAIPJcKFrKob19HBUHYQx8OeLc5mfGyChZEd6Em1gwBtMeCNJ
         BiUw==
X-Forwarded-Encrypted: i=1; AFNElJ8eV6+LK0YQSKFRVYAa2frbOw3pBAdUZzF3w+jf54P3gfBJ9duYzoqs11vjek+u3Hw+7L2AKtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGiiK1CDV8pLKvbazi6AfH6+dhdsXncahapnLLY05E4rc/o5aV
	JahtZFtI/6/Z/auQtR/wWj1Y6EnPzYfxclLtYdNqVAzDy1UnglXwHE9lFoNrSfJpJqmGDisg0PK
	jEc1ar4Vng/1hk1OAF5biu076rwuHDAe7drcCYYNdBUuejaHhIHDQobCgkIfvbWhDRA4pjwjUKo
	09BZI7i2wA2Dx2BMMSm9MyLJiloBTTXds5df2ati0mrzZhgqmMShhLv0mGa2i1zUnAy7+FCUdlz
	C4dTni+d4QfnK+zYsw=
X-Gm-Gg: Acq92OHSr3WHLnHZ5hI62vZBOw4PL8+W1WvfGTgImGUdRVb9jBExiKBdQFCyXOKgj9s
	H2QTvmiXrOHElDUsFR/O7FqV8NpcndkOh/QjtwQQE9rLmxADvc82oP8Q8HtvQAdbwC2mAGGghJV
	u0TaBPwBvC0VOzSbMRJM+2VMGuwu9BUAYxRE0oxCeB6PgJ5gYi4flcueGILudyAOqvDROU0fecR
	lV/kc+N8+yTmRlD/Kxwlv80KcTnPBZ02zNeDKKBYrJgkk/6ejOWBjInJQpeueMOfjUuXPxQnc2m
	KD18KMuIFA3tkcol3RJdIy3bbHmdkpALzuhSJaLDd3qn8lCwS36GxhDB5Ch68+xZsX7tCJzr5Te
	HDAtg9nZT1oj5+1/3zZ86qeOLD9HP9samiKETeH5ArOpYnpFb2lal75Dn61XqTOOjRw0tHJgFgV
	kcAkxLbBSoJNJTmEHvDCb8ICHjXUQmVCfxpu0PuxLZoPo5myZUmuI=
X-Received: by 2002:a05:620a:410a:b0:915:8594:68dc with SMTP id af79cd13be357-91dbdaef0e2mr1149674185a.55.1781779862107;
        Thu, 18 Jun 2026 03:51:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-91619fd8f21sm60912385a.8.2026.06.18.03.51.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:51:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso6871445e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781779860; x=1782384660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b+MRDwuUQuk4HJCf9ITWIh7vsEHgsSIvVGf6giRg95o=;
        b=VJct+FmFT/Zlv3JxVIZ5t4nzU/NUZahmsszY07Hj5KkAOsqmuBXKUNT5ts9rJQiJRV
         hircs/g71IqCLimId/x0gS4vf6wZbXQgFP3BQEMl9V1DIes/+W6y7D5RTHezg+IAkawB
         lZIVAmzxK4RI6/ItCl345lwur/8/pZ3CIyebA=
X-Forwarded-Encrypted: i=1; AFNElJ9PT4v/u6YH0NXEVgBtWAMrQK5wUKyL1JU3BhOxQV+0nDSSvg4o+YNMAxAKvi0UexMVc7p1xbg=@vger.kernel.org
X-Received: by 2002:a05:600c:34c9:b0:492:3346:e2c with SMTP id 5b1f17b1804b1-492341275d8mr107419045e9.23.1781779859684;
        Thu, 18 Jun 2026 03:50:59 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:492:3346:e2c with SMTP id 5b1f17b1804b1-492341275d8mr107418695e9.23.1781779859274;
        Thu, 18 Jun 2026 03:50:59 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619fb12edbsm25700899f8f.17.2026.06.18.03.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:50:57 -0700 (PDT)
Message-ID: <48910e5e-f694-4db4-87ea-da322b915b34@broadcom.com>
Date: Thu, 18 Jun 2026 11:50:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bcmgenet: collapse TX priority queues
 to a single queue
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260612205915.3156127-2-nb@tipi-net.de>
Content-Language: en-US
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
In-Reply-To: <20260612205915.3156127-2-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300406-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:opendmb@gmail.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D45369F80E



On 6/12/2026 1:59 PM, Nicolai Buchwitz wrote:
> The strict-priority TX queues can starve under multi-queue load and
> trip NETDEV_WATCHDOG. Justin's earlier series [1] worked around the
> symptom but kept the design.
> 
> The multi-queue design was originally used for STB use cases that are
> no longer needed, as confirmed by Justin. v1 hw_params already
> exercises a single-queue path. Point v2-v4 at the same configuration:
> ring 0 takes the full BD pool, every per-ring loop collapses to one
> iteration, and netif_set_real_num_tx_queues drops to 1 via the
> existing tx_queues + 1 arithmetic.
> 
> Tested on Raspberry Pi CM4 (BCM2711). The baseline kernel trips
> NETDEV_WATCHDOG within seconds under iperf3 UDP saturation
> (-u -b0 -P16 -t60). After the change the same test completes
> without a watchdog, and a single-stream 60 s UDP run sustains
> 956 Mbit/s with 0/4952890 datagrams lost. Single-stream TCP
> throughput is unchanged at 943 Mbit/s.
> 
> [1] https://lore.kernel.org/netdev/20260406175756.134567-1-justin.chen@broadcom.com/
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


