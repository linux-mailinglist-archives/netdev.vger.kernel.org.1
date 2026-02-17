Return-Path: <netdev+bounces-259135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME7TEmS6lGmKHQIAu9opvQ
	(envelope-from <netdev+bounces-259135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:58:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F914F6A7
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F47B3008232
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D2374194;
	Tue, 17 Feb 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jS5N2Atl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K8VuSFyf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5129B8E8;
	Tue, 17 Feb 2026 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354721; cv=fail; b=WeKzyD9CsZ8MXfkpgqpEsZg7hWkAlyN60U3ZPrKLCW55mBKDKHNusbiXiiH545nq5AIFcTMsO1n5ffOat0j+Y1wt0K++rNP8iGiXmMgpiet8dWQg0sTXEJjxJ8cP5Qo5PjxKFtcpvoHFIKumBFPdcpi53xy0NWprdqIxnGyTe5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354721; c=relaxed/simple;
	bh=1W8TC5VuUHOGMYArQVpiFQGiYCuRac4MEY2E/2v1OaM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ROHQ4C8b78mQz4EEUd5EnjyV6eJEwfrHGbR8QjOLv/SKI/i+e+LyX8B6iak/ZNKD9Rl5gKsNUh1cJOLMwBY5/BKUKPhIkR1MeKNyBXzOg4ZAN4hHnOWkITlHG5Djrq5z1KKAjaOiZ5azH82SIlfh2/fJg7ham7EiNUlJUJCnKyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jS5N2Atl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K8VuSFyf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNTGh3789122;
	Tue, 17 Feb 2026 18:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ODZKMPTW3RVUqf/v2t6+KVeGV4P59l+3LhBXLdCy9DE=; b=
	jS5N2AtlnzKrtv9e1Lxt8YgSkGrHGKmc2sTMxKganS/z7kbRKq0+sdSFyjZNB3Qw
	OPBIH3t4jgS12S/VDteXzNK8lAFluGD3A3e4HvAGJwoU/ofMogpJukdtH2CRIROn
	L4o+xK6qSWU6BywD6f6/K+DNQuTf3uwA/+YV2xe118YodaFVsoIgf85VdOnQJzZF
	OniehTTKI/L5Zsefm6lsc2EBtOy5tIHSOxj+U7TtB5CC0s2ehF1BcNpqGFAYflnj
	Krx0hdQcQOlYoRh0x7rioM8i03fvouzMXL6my1pQ85B0Da8HVaryWbVfw4SQaQmF
	pyrZRPnH4izKKuaLR5HRqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj5r48b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:58:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HI8hZJ009997;
	Tue, 17 Feb 2026 18:58:28 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb293y0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yuh6iPaZq9/S8sQU8tnjNpy30xk7dmcd9ZmkD039N+BIX9paIYhE0FjB3dO2yP3MiRQPhs3Jzv9LTLO/ziUFP4rwEnGEjKqVM4VLOlVLPDNx2MPxDguREWuKHvlNiBxYebhRh09P1rAImcbi+oxtxjuTg9/k8olum2C5UbLdAYyWCWmy8RCgm5H5OoZC6eJW/dxx2F8HhfKo0bUXd3Io+aKLa0yxVCiGCw8q/urn4OuDAFSFCnS6tSxLKj4CRU3acq0IvUi83YyR2NKHr383eQ8V5788+Tj1Qysy49VQ+bCFGQUGDZFQ049/vXfICxrjZV2AXsHGFKmAtWRJ03/pRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODZKMPTW3RVUqf/v2t6+KVeGV4P59l+3LhBXLdCy9DE=;
 b=BNtA3mxzNWk9+znOYCWcji0etigM7fqQxTK0TDaL/ljZtkNYxCbLJxTf2aQzxz3fC6ujYSw98HXzNXV/JaJ0Ij3R/1FOwiCOdnzxB4rzmSyjNh76DC9+J+PDQhuO3bJusZfbo1Q3Fo9dTBcCYhAz8cGERAamTcSEBCGbotb8VdHwL3mC3cY3rFsvDA2E3fzoG9iQCLEdG4s5A42WFEOX2ovvpkcBgmzKiPQuTmPM0tCHPUrLzL1ZfTFUh2E88qrh85dVti04Zq2mmFxck6RGTER8G8LEAZyu72YHSzUbhewCfA8Pb7i3NsIWHBtIuH4hpeOONrbqB4uC3zFO3TOBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODZKMPTW3RVUqf/v2t6+KVeGV4P59l+3LhBXLdCy9DE=;
 b=K8VuSFyfr2EWMIoP1KPpcgQwMlA68nZ1K1xl1nwdiNvDSRuICzYhy9GOOb27kfMd3+bn47a7dxOJb6pTk0LwVUCezDXcx19e4269oN+pyKsa6cfM3hQFxY1bju7chSdcTwgow+I+MJQH3tZZncvR8CzLMUGTptMGRN6v6QwUzfY=
Received: from IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16)
 by DS0PR10MB6223.namprd10.prod.outlook.com (2603:10b6:8:d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 18:58:20 +0000
Received: from IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f]) by IA1PR10MB6050.namprd10.prod.outlook.com
 ([fe80::645a:f184:3a35:ef9f%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 18:58:20 +0000
Message-ID: <6d46a465-0f1f-48a3-8b4d-da063f6c45f3@oracle.com>
Date: Tue, 17 Feb 2026 10:58:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
Content-Language: en-US
From: Gerd Rausch <gerd.rausch@oracle.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>,
        Allison Henderson <allison.henderson@oracle.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
 <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
 <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
 <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
 <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
 <2677c7cb-efb7-4f19-8000-4ed127f33847@suse.de>
 <4acdfdf8-a69c-4020-8a8c-2edccd482a6b@oracle.com>
In-Reply-To: <4acdfdf8-a69c-4020-8a8c-2edccd482a6b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To IA1PR10MB6050.namprd10.prod.outlook.com
 (2603:10b6:208:38a::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6050:EE_|DS0PR10MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: dec910a6-8cfb-43b5-a483-08de6e568498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3hWSExVWWVjMm1uZnpKNFd3eDdlM0VFRTJxMlhmUG5lNDlHV0dxSlphUU9E?=
 =?utf-8?B?RERsSUtFbVhEcm9WVUJmZmJNMVlEdHZ3cWNVUkpIa3ZoM1hJUm50c1VoOTM4?=
 =?utf-8?B?S2htYjJJZVJoU3ExMy9TMURQK01vcjQwNnQzTjVqeEdVZTgwR1Q3cTkxT2hL?=
 =?utf-8?B?MG9yOWJOajRBOVBDQWdwRmlwajQySEp0dEZRK2p6Z05BTGtpRFkrZzZNbkMy?=
 =?utf-8?B?SFM5bUM2aE9aSWJYRFEzOWdTSGVOWHZWait6VS82NmU2ci9mYzFnb0QxQjVm?=
 =?utf-8?B?YkpaUWcwWHJhUm4rRGZFanR2MmZTUkNEQkJZZjNmOXJ1MlM2TmNlcElJWE5F?=
 =?utf-8?B?b3lsdHI3aURPT1FRWUdRaEJxRjY3djVCd0J1VFExS2drcFNGKzA2U0ZjaExJ?=
 =?utf-8?B?eTNvSUJmVktQT3RtU2dRTFRVSkZnRWJMbnNOK2xHTWNxUnRxbE1kZ01WbFUz?=
 =?utf-8?B?aDF1aS83aC9ZLzdOeUxHMm1iVXFaTXRJSnAwNDlFalhDNnRlUWNCZ1ZmWllH?=
 =?utf-8?B?ZXJFQkkwODE5NDJpbTRwaEROSVBjcGo3YmFBYmZkWi84dEM0K1c1RFFmc0VP?=
 =?utf-8?B?WHFQdzlMc09xbUhkUGZvQVE1bFJkSm9PTWJHZlNYV3JKb2dvT1d0eGk0a285?=
 =?utf-8?B?bk5pendPdWp5bWdZQVZIUTFkN2lLZEVMVFlQekNQUkJiNGpmckI5d3U0VHVk?=
 =?utf-8?B?azlXUkFMTU5EYVdhT0RHL0dXUENnT1ZmNXJQNUZ5Q0xRZmZhS2VtckY4UCtu?=
 =?utf-8?B?YUFpcjJ3OXJSRWZnZmRuRk0yTTBtL2hHdllIWW5EM2tlaDJVNGxBM2JqelRM?=
 =?utf-8?B?ZEw0ZnRvOFFlYzZ5QmttK3N0YVNvVTJJQmZGZEx5TW1lc1FodW1hOU5ib1lw?=
 =?utf-8?B?TmxVZUdJenhpbWVoVi9GdTNjM3ZaZmw2WjRNbXR3R1RqQ1d0K1RPeGJVWGFF?=
 =?utf-8?B?NmIrSlZialBuWG54M212ZTIvY2txTk9XV2pPbHI4a2dDRXBLR2RDS1o4MW9P?=
 =?utf-8?B?aGsxNCtkWFBSTG40ZzE0bENSL0Jwd0VrTm93MzQzNWFQRlQ5U0lqLy9GdndR?=
 =?utf-8?B?bTVuV2tyTXAwOHRqeC91K2I4NlFSYVhvNEpubUhCQTRlTHcyeVNvYnd0WXZB?=
 =?utf-8?B?UXVPNWI0TGlFZGFWVU9iMERzeCtDeHB6SXlnc0RldzBhbEZQcTRmTzQ5VTNs?=
 =?utf-8?B?WnNZc1h2cjVuTVgvMUpUeDFTK0Q0eVZydW1OOHdXNVQzcG00V0pSL1dETjZL?=
 =?utf-8?B?Y21zb3k3K3RQWWhEeFZ1b05Mdnl3a2xXMjg0ZW02WXI3aW0zM0lhOFdvc2lN?=
 =?utf-8?B?dFgxakswdFlHWHVqQ1pjK2JMZmI2TUhrZG1BTVJFZ2Nvbks4elFxQ082M2NX?=
 =?utf-8?B?KzIzQXBMUWZxQzZVQkpUQ2N6Ry9JVXBBL25BclFZa3lFcWh5NEJWMFo1Z09x?=
 =?utf-8?B?VEVRZjBEb0cxOEYrWW1mZnBrd1Jtc1NCTW1uajdMZDAybkpjbGZ2d2NoZXVr?=
 =?utf-8?B?Y1FJcURSeDRyZXR6WHNLejVVK2MrV0VTelgxZm1uVnlEbVJHR01YYndmWjR5?=
 =?utf-8?B?ekpjYWpDRE1tc1kvTUoya1VDQzZNdVhZaGpIM0FoZWxvcEZSbS9OTlBxODU0?=
 =?utf-8?B?RUJyWkVCdU1hcktKazNLbThnaHdIcy9OeXNVb1RjSzF0T3MvNWw3bVp5V09Q?=
 =?utf-8?B?ZklEQzVCa3paVTJTaXJrUkx5OVc1R3lsTTl5Z1Q3QVdzaW5aZDU2V2JpQlJ1?=
 =?utf-8?B?R2dXZ3FuZ21XaXc2dXJXZHRGSWFpSG5UeGtqOHlUdHZNUDUrSDR6Yyt5SUY0?=
 =?utf-8?B?MEkzL09uNWxzdDVVM3g0K0JWTjBPRVhwd29vTnl0WmRKd1daYkN3RUU5SGhx?=
 =?utf-8?B?aThQS1IwZFp3Z1FrdWdYNGZYL1JDUGxSVUYweklpT09XM3NwcUZtczhoQWpx?=
 =?utf-8?B?Z1pFRktMQmc0STI3c3hyekpyTHdzWmpGWWFNOEZvWW1NakFxMmRYZ3Y0cU5p?=
 =?utf-8?B?eUpGZWE1WTdFL05RcTVtSDNuWjhhSVlwL2FwWE0zNnhZTkkzWkxmNm5aWURt?=
 =?utf-8?B?ZHdUTGxVUE9abUJsYjQrc3FhQVBMaHg5S3J3dXVYRkZ3QmVTcWxJZDRzWjg1?=
 =?utf-8?Q?G8XlBqt3tRNBU7wgAwKuhDYBc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6050.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGgwdklKNVZiazFKWlRJWDJkandzUzlXMEZ3RTljd2k5eHpURm0vbU5BT2R3?=
 =?utf-8?B?ckUrRWZUVjZGbVBkTFllTWlpRVJDT3M3VXFxY1VxN2QxWlRpLzdkUXNmbm9L?=
 =?utf-8?B?d01vTGRlMHJHK1B2RUhWaTd0T1NHY2tZWVo4T2tsMGdXUmRQWEE0TnpSSjhy?=
 =?utf-8?B?NlVLK2xDblRxNDZFaFBpSDdmakE3bk56R0pRMERWei9Sc2xpeDFDdGRVSFE3?=
 =?utf-8?B?em1qd1JvUlppa0VOZXA2S1ArVWpZSG0xOExFamhtV3Y1akNZTjVleklSNDB6?=
 =?utf-8?B?MGpJeVVuUVptSURSdHJxTHdaUU1PbE1hblNWajl1aGM1VXFxZnBkb0UrOTgv?=
 =?utf-8?B?cnh2TS80OFg3a0dpZXFSRzNSdlNFQ0g4UTBzd2lJQ3ZZRW1uUUNZRU9wUUFm?=
 =?utf-8?B?VWVxblNVQmEwK0tMS0JuSnNpZ0lUM3BWbGFKY1RJYS91dTFsMEd4OXhnL3Vr?=
 =?utf-8?B?MXpPN0dZcE1rclRiS0NhVHorTmFFaVZoNWxOcUJEYll5MW5UNWdyaGNHWGVX?=
 =?utf-8?B?cVF6dlFKUURHdnpMaXZDeG9hNXR3OUp1enE1cnpad1RWWXhsTnJuM0MrV1Fr?=
 =?utf-8?B?MVpyYmtQekhQUmdLMG1NajI2L3dSOG1yaTRVbmw3djE4cXNuVXh0QUFLREo1?=
 =?utf-8?B?TDVLakk0ZXhFWXdUWUFqYjFmMmRtbFBRNEN3UytSZmduc3AxS2F4Y2dQQWNv?=
 =?utf-8?B?bi83dnQ3QktEQUpLbTd6ZTQvQzh6RUFUWElza2hKV2tpQlFKZTdhUGtNazdB?=
 =?utf-8?B?SzJtK0FRd1VRbTJwYTBydGYxL0J6a0NWU2s3WGJlYXhHcGk0YXY3TEZTMmFD?=
 =?utf-8?B?eFA0cTRtUjRsRVJHZ3dXdnp2dGNmaVJYb0s1OTU2eEdzcnN4czNMbzhsRExu?=
 =?utf-8?B?Y2puSXlXcUVsZ0FFWGRNdlJXc2VDMkJZb2NKZ1BZTFBBRVk0eTJUZ2dkSE1a?=
 =?utf-8?B?YitGWFFVTm1GclZzeG4ydWwvWXB1V0xOOTZMMTA3cEFxZ1ord0ZlalZIYlZq?=
 =?utf-8?B?UzdaU3FDcU9nVi9FK0RNQmhSdFR5bWlWY2tqbDNLbEtFYmlQdWVVZVZqMDVy?=
 =?utf-8?B?OUhwQW1CYUE3bTU3d3hCeW1iUVpMTkVuaE5Fa3RORlcxakFHbDV4OFpXdE1u?=
 =?utf-8?B?eWcxMTE1S1R4RlVQSDB0QWJuNC9WYVpNdGwybG4zQXlQRXdNZWxrK24vYnla?=
 =?utf-8?B?VkNWVzVuUlhnQVN0dGVkYlBRaU10bnRRQkVTVEJtMGducVdwb0tCQjBROVFh?=
 =?utf-8?B?NkJZWUhTSUVhK3NYY0V4MVVCMmdyWDhCbmJQVWZralN0bzc1US9lSld4QlRt?=
 =?utf-8?B?MHJKZWlvN3liS1JQckNlZGcyRVVQTEd3SVhybGVQZ29uU0ZHZ2o1ZnI1TzNX?=
 =?utf-8?B?OGhrenJtdzB2YTRVODVLKzBNSmh3UmpvSXhPYWxhWjdJaEtUSnhpV0tjalVS?=
 =?utf-8?B?QThPY1RQUUFsUm1TZFdmZjl6TFQwUjE2MWRhQjViWjRZZjVzeTZBWG94MzUx?=
 =?utf-8?B?K0hJMlNsaDlmdTdFbFUyM0E0UGRYL0ZJcHJ6dXpsMlpUa3dzVzU1ajNYejFl?=
 =?utf-8?B?eEFBWXI0SkM2emZEcGpiRVZIeHRZay9qdExDTVBzRW4vNitNdWFHbHRLYlVH?=
 =?utf-8?B?VlNqSklzUitWSnVqTGxJbTFmd0NjdzJkamNuLzFpR1VhcHVTNG54WTN0MEZu?=
 =?utf-8?B?bE9oMjRsemM0K2NmVWV0Ri85ZGNCdnJXM3FRTjhiSDAyZEJla09DS01SYzVX?=
 =?utf-8?B?N0U0b2xJZXhKTzZNdjFYOENMaXhDSEM1NUdSTFlHYmNLeUxUbThjeHlSTTYx?=
 =?utf-8?B?eHJXRUNRbGhweFdDQ2hJcXlkd1Vka0ozRjZHalNsT2l4SUl3WkRpMUw0OW8r?=
 =?utf-8?B?bkQ1UzY5RjRQcnZNQk51R213MVZuTnRKSFBpYUpCSmdRNnFMZUJjbTZMRkMr?=
 =?utf-8?B?RFdhTjI1dFlER0ZWOW4yMmtVOUNaSDB2TEZ1UVFiOGp1Y0RLVCtpZ0NpbXh0?=
 =?utf-8?B?RDVJcEhHWVdEdWphcEdiWSs4ZWZkazNUbTV6VkdiWXErdGQ1WTJoclRxOWNw?=
 =?utf-8?B?UGpsa0N1cVRkYXlDOTlEVWdLMTNUYXoydnJxTi9Rc0I2Q2hEKzg5eU5mVmZJ?=
 =?utf-8?B?akhtSWlQOStHUjdxZHgycUVBNTdKVXQwODZtSnhYa0pnZDVZenBQdUEzd0dP?=
 =?utf-8?B?MGhHVEt0S2N3VjFuVWk3WjV5OUI0YUJ3Um1xZ0dadmRHb1ZjbmUvWHdvSTAr?=
 =?utf-8?B?NmRIeXUrcHdpZ1dKQWdwSGdFM2NON0MxeFZzc3hPTWgyQ3JxZTNSKzQ3OGMv?=
 =?utf-8?B?NVBMZElTZUpqWUNuWk9KOVQxQ09BVzlVL3dnaVlmK0pKekF0SzNtZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cOoqaFbis5bLUagqrIPupOUK/0T/5udFSlbOWhGRVUMS6HIptvzyG7IdZ87QBg8QOuEc9wTBEFVdX8Dzj9Yi6Xt9EoNJfIv9TYP8L17AjBIZaPtTqnf/8I33YE7DwYz91g+4ApBD3Rs9y3i5WV/+ZJzriO1UBDocp4SJamLdI2UNVfAUGoqNZ5in4VZghIIAF1l2ZDDRdsoqyABWLVYMDFk5GPxgORKQgsQ042YB9jNAL6maXs/NwzXGo57c8Z/Z34oWrzQjHfq14JMPVuXRAxcCuzz8845HZ2i7CHecgrhmBqSG8fOxNadgTxsR3a4ehJnlmRCoY7MEkbbIkv+WQHKw5dG6/XCFCiO/qOE4qwkuCt0G2jE2hgYxh3j90uBe7hAplMDQCjTE2RRmRfPZdGEQL8xQTcr3NR+x2o6Arg0g46E7tFjJay4HsD3mkhGrmfY0RIe8RPlv15J6yaAliKJPkLTl+sTcXMc/UZYfZny+5TAmckQ46KUDYbQYkClGGdFMM5BLpAo+jUZ06QU7LDsJLnHp1cieIWD+SiTKa1V3uQ4thXUjg7jvi7w/TkOxc6FhKb+wECfuRmKDbI9lskXt77RV0cVD0dqVb1WCSIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec910a6-8cfb-43b5-a483-08de6e568498
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6050.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 18:58:20.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBnvNNnCtvs4MC79CIVI9Th89d7Cwa1mMmUEahjnr0BCUzh1Ql4nImNn30jH/TKm5i6vnxprYFjUz7H9nIxfCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602170155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1NSBTYWx0ZWRfXz6XiIRcleDvu
 80Jy6CwVuH3RCmtq7Fc4B3tDe1fuv0IpsCWr8cGyA87CwU8D7qHmwJtPiNiAbKXTRAQEgWgd9+r
 uqP6NJQbvWCea1FV66vS23LWFq7rLbEGdJCOS+AcFDC9R07+R7lEWLspE1LQWkxX32v5P/1c1pu
 4y45q8HEBlySdLr73I1y2bNsye/VJ4Q3brjYnoSx8XT69CPGkJF5ygmQlfV2vJxVBsyPfYBuyB7
 sjCobsHsUcGJNiyZazqY816nRyNI8tI95BFjvcCvHCBFdZa9Tux6m/arz0MvUlopmr8PG/MVh0u
 Txxl/pfPMBItenG8eJZ1aJQwplY7nBSjHn6KzgDNXDkAIMiNjs73jm6JvV/IfuFmGOrwPsqwyjt
 b8ney5RQJfDOB/Ko5SD0OyUT2j8Jo3SHzQVeqGPHu3Lgqmg3LZZrA9ldtGZdcaD9mf+R/qBz74D
 dnhmMi4SZWclt6Rj0egWZSu6XH6GkBjDuzDaXKkY=
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6994ba55 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=cXLrKWlJMmZIQjdm21wA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13801
X-Proofpoint-GUID: aRLM7ZhNdjn5_QCVqUHjvmHE7nZx94nw
X-Proofpoint-ORIG-GUID: aRLM7ZhNdjn5_QCVqUHjvmHE7nZx94nw
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259135-lists,netdev=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerd.rausch@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9E9F914F6A7
X-Rspamd-Action: no action

Hi,

+Allison

On 2026-02-17 09:28, Gerd Rausch wrote:
> On 2026-02-17 09:19, Fernando Fernandez Mancera wrote:
>> On 2/17/26 6:13 PM, Gerd Rausch wrote:
>>> If someone were to change the code to pass in "fan_out == true"
>>> from a context not already holding a socket lock,
>>> would they remember to change rds_tcp_conn_slots_available()
>>> to acquire that lock?
>>>
>>
>> Usually kernel requires the developer to understand when do they need to acquire a lock or not.
>> Anyway, what would you suggest? To check whether we have acquired the lock or not and do it conditionally?> 
> 
> Something along those lines.
> 
> Either a "_locked" version of "conn_slots_available" function pointer,
> a parameter, or a check.
> 
> What you suggested is fine though for the immediate syzbot need.
> 

FWIW, in UEK (the modified Linux kernel that Oracle uses),
this issue reported by syzbot was addressed differently:

https://github.com/oracle/linux-uek/commit/a94abc444c487

The commit under discussion here originally came from:
https://github.com/oracle/linux-uek/commit/ebf71f5b6c29c

and pre-dates:
9dfc685e0262 ("inet: remove races in inet{6}_getname()")

which is why UEK didn't have this deadlock issue reported by syszbot.

If the objective is to keep divergence of UEK and Upstream to a minimum,
it may be worthwhile to consider adopting the same fix we carry in UEK.

Thanks,

   Gerd


