Return-Path: <netdev+bounces-299817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ZKIAlcvMWr8dQUAu9opvQ
	(envelope-from <netdev+bounces-299817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:11:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C768EAAF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=cwDgQc48;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299817-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299817-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96E07303C4EE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C242DFF2;
	Tue, 16 Jun 2026 11:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B0369965;
	Tue, 16 Jun 2026 11:11:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608273; cv=fail; b=VbvtsGaMfYy90QxgogL4/F3e4+OUyEA1KIMrvpvXPwPEEzF7D2z90jhM3DKvAu3bEWvq/kkiTDQhq2WpZ647ZxqgePvNP14bdLVgFcS5bNtdGj+gURzwPNjGDmtcHuhBjnsP+DYcbwhzuvO6wrelRxhIJ+5aUl2R4Eh2F1zsY5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608273; c=relaxed/simple;
	bh=55znOYGsRqslWUPQV52B/T7hBbYextIzfitEW/7H7R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tL95W7WLWFJfwYDQ1Xi1TDCNT22vKVYbxQ2QBGoTmpmFFzGvaAgCjd6cVEL9+jelbjxB5Um66Ss0LZDN1W7ayyrTvqXFz7kWy4jzzik6i6fJIOkVq+qqNHHTxLwFVRGQ+8Jn2xn6S1orH6AstrLbepRsflsbJf0gDdRUO0M2D8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cwDgQc48; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWLiHuLKAhGKbGnm2ZVxjLfP2psm+CnpLGaxMcMjYfP5KJihaqt26ifX8rJsm4msXFdMvte5d0L7jldDpFm3Z1zo1ZcnksZWoX2+MsQSQEzrylJtR96NwtNToZmm9x6tv2eRAWBU4LoVS7mVMrlY1KOnEsX09AesvEQig96CASR8jT6QBNksHGNopGPH5GfcvB4feVPbEG4xnn1stddO1MbpNKSVrwj1Rw75JriicXDF7Xop+5AUwz7qlXqL3SX92OePc2G9OPzccVwUQW9Yjupej6dH9UIX5pP+Q7WA7756GOT5kgcNh3hULc4gL5Bb3Y9YosK/cRSo1arMY0O4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrXdi6srfp0Ao/tvJZ9Wyvr5NlHDCnKq/XdFuOkOCfU=;
 b=Cywj/EXb9ZGRIIFCZYaXOXMoeJlRAh+aJ+9EO/S/gI/mlp+ZAmCKw1IEADT+9w13cB3VgWs9lgOoJz0eMbDV9ofXoGTU0N+1BcdH5qrAPgUjm0mKs/VLXJcAYGYuiO92WWW8sHAOjMww/Xy+lsi1PS+YTvxnewx/nm0IgxHtorshZGrqYk4I+u+uZPcu+12oshU0O1KKIy0LZQxn1UEpb4D7S2FWZaqg6HBfkyyb3cYNmnxSv2X+XrbCxedbQTiTfMfE4dhPt/KwfKR6vMgypgVhmCOCUFPQZUccKUgwXCyaWwPZcCXiEzAkqL6IHp53vLVd3BVWHtr/l05/JEJeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrXdi6srfp0Ao/tvJZ9Wyvr5NlHDCnKq/XdFuOkOCfU=;
 b=cwDgQc48CHXNO66E5eJI7LdzNl61cUyVOEYPxErj12FZ2d+WWxwVjcqylA3HeK8kMk/0EWSju7PZJuvQuVAGyCnTNACcDXgNG7aHoY2+tc4/l782DgZJZPqNa7DHFYWI+e8DOTwj38mlHytjQzo2mgz2QBF/xaXddoI7MTEoOK0=
Received: from CYZPR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:8e::28)
 by CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:11:08 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:930:8e:cafe::1d) by CYZPR19CA0019.outlook.office365.com
 (2603:10b6:930:8e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:11:08 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 06:11:07 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 06:11:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 06:11:07 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65GBB03k3480225;
	Tue, 16 Jun 2026 06:11:01 -0500
Message-ID: <ed0bc332-0196-4613-8066-9b94f8ed0013@ti.com>
Date: Tue, 16 Jun 2026 16:41:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net: ti: icssg: Fix XSK zero copy TX during
 application wakeup
To: Jakub Kicinski <kuba@kernel.org>
CC: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
	<hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20260611185744.2498070-1-m-malladi@ti.com>
 <20260611185744.2498070-5-m-malladi@ti.com>
 <20260615162157.3748bcda@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260615162157.3748bcda@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CY8PR10MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 149d6917-7978-4d46-e157-08decb97f738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|23010399003|376014|82310400026|1800799024|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wdG9YScI2ByOTzBg8XFkctAIV8akMtbj2ZiCVP0UB1kgquAMvsGjYjcdEFUw4sCP+qMZmOjKgjeWjlyAiSracSXro/Au1V1aBm2TT8d9egku/x9g0yvUlMgCf3eVvip6DY5Lk7EZb+aiNwyFB2T4rcVD//S3uJTdKkJMbN7mmtFyfWXeLOVokcw3RUKAnk9/owl6/24TR0qMG2J4Wl6qxKpccJ2PI5Nzheu3cIYlwWoUkSFnbV9i+ZpA4OlmU1o/TmzNAUKJ2QN9bN7/O+C8xEOex4f43VN/cAEMQFyvi/lVOnoHsAlcDTblkucXebPddeGeLVDVYCqP1GJyUIBj+I4BshaTgGDdjU7qCfeTYsFh+XVbbcDd97kK4yAO5F7RnDjdoxx/gaitvWk7gry99nj3Rh8xXrp8WAso4Hmgrl+V4AYBrPK2IMHNJfwyEDQ65ZgVbPMu5fn3P/LqnT+Acs2s87CoWsBqwl26vSngT+QjdBKnul5gI0SAvYmHZ5k/E9dkg9YyapG3+wk2KAKHBDFaJNse3w3XxhSEMgp7B6RlBUZE1ljcZqRrRXieoXKuyQXnNy1fmng8vKqhHwqAETwW5u+dJkFnd9JtKpdr8Y7+1hUoWqFSHfNvaNknxY7RKz0Q82/MreCX40muTIOG4dpOEfqzz1IL4AQNCwd08ik4T/p5mSOxc7ybjsKvBz0JrpSiaB7MevS4qhWmHjsq42OLjLi44saeEITgko9RWQI=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CUVkqNsLYvV/rBPD9VHoduBxEYhuM0QyNikvvJSSTDXZri2tcM2jy5CvS+mg2CMD0B18Q8vWWdhbGnqz0TJdM0PgZmlSWL5tcI9wyU3xWccHiu89zQDUE3/lXgWwelu8ulqHyj2kxHklWYf8ey7bIR5Tw2EKC5GwHFCYl4J7YL79KUAsHS0M5S8QGvQDlmd+eKV3YccLslNxytHupiRxlf0PTaGmb+Yj+NGTjDaki3/4v0pn8xe6+Inn+us7SRF4NznTEUbTO43ppKmTkRPET73gu2Z4TWfXukFxbT9ggmTvDXUFU2QG4lpvjKNB5ueLGNdrPd4lQZKWH60RdPVE/8o3+vbu8KJWzn6Sw8ARkzpVxmSh287Yw4O6HmIf9kqJ0b9VmyI76sclPwCvPVgKICONxmFLrwZKEnG59j35S6QR2n5vnLq1WCBVmnzXofUn
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:11:08.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149d6917-7978-4d46-e157-08decb97f738
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299817-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org,lists.infradead.org,ti.com];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 181C768EAAF

Hi Jakub,

On 6/16/26 04:51, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 00:27:44 +0530 Meghana Malladi wrote:
>> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
>>   
>>   		num_tx++;
>>   	}
>> -
>> -	xsk_tx_release(tx_chn->xsk_pool);
>> -	return num_tx;
> 
> Why are you deleting this?
> 

xsk_sendmsg() also calls this without an rcu-lock when transmitting the 
packets if the xmit was successful, so I was assuming it is not required 
and I removed this.

>>   }
>>   
>>   void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>   		num_tx++;
>>   	}
>>   
>> -	if (!num_tx)
>> -		return 0;
> 
> Does something prevent us from running all this code if budget is 0?
> If budget is 0 we can complete normal Tx with skbs but we must
> not touch any AF-XDP related state.
> 

Can you elaborate more, I couldn't interpret your comment here

>>   	netif_txq = netdev_get_tx_queue(ndev, chn);
>>   	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
>>   
>> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>   
>>   		netif_txq = netdev_get_tx_queue(ndev, chn);
>>   		txq_trans_cond_update(netif_txq);
> 
> This looks misplaced, now we will hit it even if we didn't complete
> or submit any Tx.
> 

This code needs to be hit for packet transmission in zero copy mode.
emac_xsk_xmit_zc() submits the packets to the DMA in NAPI context,
when application wakes up the driver and triggers NAPI. Once DMA 
transfer is done, irq gets triggered NAPI gets called which will handle 
the tx packet completion + submit next Tx batch packets to the DMA.

if (tx_chn->xsk_pool) -> check ensure this hits and runs for zero copy 
only. Also above check (!num_tx) returns early during the application 
wakeup (where budget is zero), hence it is removed.

>> +		__netif_tx_lock(netif_txq, smp_processor_id());
>>   		emac_xsk_xmit_zc(emac, chn);
>> +		__netif_tx_unlock(netif_txq);
>>   	}


