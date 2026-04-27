Return-Path: <netdev+bounces-281238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AQbK4oJ72n14QAAu9opvQ
	(envelope-from <netdev+bounces-281238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172946DF5F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F5430414B3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7533386C18;
	Mon, 27 Apr 2026 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="uVLEOktU"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19238F92A;
	Mon, 27 Apr 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272972; cv=none; b=K3kMrSud34UMbadLiW3PhNj16eohNWZzDLDL1lGRy6aHIIAJgZFkM6zhZSPBlkfEgdihnYFb8qgPEYLcR/v9TjVzDmtLe+dScPiAI1WhGUluDsrZKXXfMOY4RTZ7i9E8kOz0rWHA6994MDEk+HTtBDdqj06uN3Y5xjgqB7tLQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272972; c=relaxed/simple;
	bh=7RP8Mg990g5c5EkbLxkMX6Yqm+3OI/fSsM9PChWXejY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8J9FVclksRE9GWYgbE8uWgvwPDICsdwyy+wOStm8qcxF+HjP6xYgsIceQ4tTqMRK8irseXZXbQAh/65Rm+8yX0zn88Ii+61hezUR+ZG1kKnFwJEpMa5d0ZLniG3O4CwysBwquEqQxD+sXjPi4BqFmvrp+iNVTZDRtmdBc98mwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=uVLEOktU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63R6tkcS73573191, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777272946;
	bh=AER0ET8ff4x9M+H5SyGinfYoXoQmV4ui+eKR/hLZdXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uVLEOktU2b8vVDpwveswbHGGwCDIFs0aQajkHpHqTtZ6Lj4RCKFtuyPRhFGA7q2KE
	 nxV/nmut/eqng/ldZldj7Kmx7AUqx7l+JtA2A3bG1ibDqPjQHt42a9Qlwg1KYDPDN5
	 v3nuVMtBnjqMit5I03yEx+Tr/ypbSPs8/J9nmdHNgBaTnOX2rxzlczVor1LJ+7+DKK
	 nusv1JdOU+lumTGgRCLDHTJtZYGWEiBPG7VetLH9vALIh8f8BNYCSaKGZKUaqlEAc5
	 sIEYZBvzC6DTjEG6nbpJ7ifn6r9P+kIpzluGsmBDYxQn1eLDLWHxEgy54uW2iXH49E
	 jhIHmRj4uuXzw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63R6tkcS73573191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Apr 2026 14:55:46 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Apr 2026 14:55:46 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 27 Apr 2026 14:55:46 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch net-next v1 0/9] r8169: add RSS support for RTL8127
Thread-Topic: [RFC Patch net-next v1 0/9] r8169: add RSS support for RTL8127
Thread-Index: AQHc0Gw4VGXlOJjkc0CYGLbAqTrfdbXv5KsAgAKSdXA=
Date: Mon, 27 Apr 2026 06:55:46 +0000
Message-ID: <ef0af92f796b4c81b02a438ac47228af@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <39a35232-479f-4390-9957-dbafc3f3c468@gmail.com>
In-Reply-To: <39a35232-479f-4390-9957-dbafc3f3c468@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1172946DF5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281238-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

>On 20.04.2026 04:19, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> This series patch adds RSS support for RTL8127 in the r8169 driver.
>>
>> Currently, without RSS support, a single CPU core handles all incoming
>> traffic. Under heavy loads, this single core becomes a bottleneck,
>> causing high softirq usage and leading to unstable and degraded network
>throughput.
>>
>> As a result, we add rss support for RTL8127. This RFC patch is just
>> for discussing. And we do some experiments on AMD platform. Below is
>> the result.
>>
>> Platform: AMD Ryzen Embedded R2514 with Radeon Graphics(4 Cores/8
>> Threads)
>
>An older embedded CPU (AFAICS from 2019, refreshed in 2022) in reality is
>unlikely to be used with sustained 10GBit traffic. It would be too weak to
>handle userspace apps making use of this high throughput. This hw edge cas=
e
>IMO isn't really an argument for adding 1.000 LoC, blowing up driver struc=
ts,
>and adding the complexity of dealing with a register layout changing every=
 two
>chip versions.
>
>It's really a problem that Realtek frequently changes register layout and/=
or
>register semantics in a not backward-compatible way (and doesn't provide
>documentation), resulting in ugly versioned stuff like the following.
>
>IMR_V2_SET_REG_8125     =3D 0x0d0c,
>IMR_V2_CLEAR_REG_8125   =3D 0x0d00,
>IMR_V4_L2_CLEAR_REG_8125 =3D 0x0d10,
>ISR_V2_8125             =3D 0x0d04,
>ISR_V4_L2_8125          =3D 0x0d14,
>
>case RTL_GIGA_MAC_VER_80:
>        tp->HwSuppIsrVer =3D 6;
>default:
>        tp->HwSuppIsrVer =3D 1;
>
>This messy hw design makes it hard to develop maintainable drivers.
>This is underlined by the fact that Realtek has separate r8125, r8126,
>r8127 drivers, even though they share most of the code.
>
>> Arch: x86_64
>> Test command:
>>   Server: iperf3 -s
>>   Client: iperf3 -c 192.168.2.1 -P 20 -t 3600
>> Monitor: mpstat -P ALL 1
>>
>> Before this patch (Without RSS):
>>   Throughput: Unstable, fluctuating between 3.76 Gbits/sec and
>>   8.2 Gbits/sec.
>>   CPU Usage: A single CPU core is fully occupied with softirq reaching
>>   up to 96%.
>>
>> After this patch (With RSS enabled):
>>   Throughput: Stable at 9.42 Gbits/sec.
>>   CPU Usage: The traffic load is evenly distributed across multiple CPU
>>   cores. The maximum softirq on a single core dropped to 63%.
>>
>> Patch summary:
>>   Patch 1: Adds necessary macro and register definitions for RSS.
>>   Patch 2-4: Support NAPI and multi RX/TX queues.
>
>Driver supports NAPI already.
>
>>   Patch 5-6: Support MSI-X and enables it specifically for RTL8127.
>
>Also MSI-X is used already.
>
>>   Patch 7: Enables RSS for RTL8127.
>>   Patch 8-9: Adds ethtool support to configure the number of RX queues.
>>
>> Javen Xu (9):
>>   r8169: add some register definitions
>>   r8169: add napi and irq support
>>   r8169: add support for multi tx queues
>>   r8169: add support for multi rx queues
>>   r8169: add support for msix
>>   r8169: enable msix for RTL8127
>>   r8169: add support and enable rss
>>   r8169: move struct ethtool_ops
>>   r8169: add support for ethtool
>>
>>  drivers/net/ethernet/realtek/r8169_main.c | 1437
>> ++++++++++++++++++---
>>  1 file changed, 1238 insertions(+), 199 deletions(-)
>>
>
>Series includes functions like rtl8169_desc_quirk() indicating a need to w=
ork
>around hw errata. Would be helpful to add comments describing the hw
>erratum, best with a link to documentation.

This is a workaround for a hardware erratum on RTL8127.
The hardware cannot guarantee that the descriptor OwnBit is fully written t=
o host memory before interrupt is triggered. If the CPU handles the interru=
pt very quickly, it might read stale descriptor data where DescOwn is still=
 set, causing it to incorrectly skip the packet.
The recheck_desc_ownbit flag and the subsequent rtl8127_desc_quirk() are in=
troduced to wait for the descriptor write to complete and check it one last=
 time.


Thanks for your review and suggestions.

Summary of changes in upcoming v2:
- remove multi tx queue patch
- rename some macro definitions, such as RXS_8125B_RSS_UDP_V4
- convert enum rtl8127_rss_register_content to #define and use BIT() macro
- run checkpatch, explain the usage of dma_wmb() etc.
- fix typo errors (e.g., DEAFULT)

BRs,
Javen


