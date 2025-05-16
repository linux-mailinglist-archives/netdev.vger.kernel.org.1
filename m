Return-Path: <netdev+bounces-191183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EEABA56B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E66F7B3B5E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1FC280039;
	Fri, 16 May 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFZcAuhL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="roUToZG1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0C247295;
	Fri, 16 May 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431546; cv=fail; b=LZ3HZF5RWhcLOJ+rzmrFhJRwCdHV9xXMgqQIG/WWA/zpz9VOECwTB/pOETdyyMafhQGdPksP9jHbqoUbgRq9Qk9VAe9/JuYWNHXC39xnDQ8bnnMp+1YnhJaU5tpwEFLiD1wFAoXL9+426VB/780mCTxkq8YGLVwLztRx06vSVNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431546; c=relaxed/simple;
	bh=QObl+4gB0BJ1HrwGuN4x3fj31M6sS8pIjPRF41V9pN4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQLSkBroStzYGhyFbwOyJErKpScUt+YcwjrPj/cYqA6eR5xj+02JfCuJGPsazvqal36XhUbpgv8Vetfzjm9SyKNba/TgeadCzFrL81GA1rN4fgMrRW5+dSj/IXrLQKIo8T5CPuS0tmI5js8lTF/KAnplwXhMWyM6z7X2wCrMrz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZFZcAuhL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=roUToZG1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GKAYD3029444;
	Fri, 16 May 2025 21:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dYhPnxUNnURmYyWaQeHWK4ZrjmpxLUeuo5EI25kJN6s=; b=
	ZFZcAuhLMUP5dWxwZ2fShhRAR4M6prhuD9fow3TYDWK5KKKpfFqd+//slHF9I/xY
	1LK3KICv82mEM/hYGq0HkHqWFOszY/SSk8wgwJjH9ZWZI7F9PH/ohjqK8zSMmsAC
	DIWz5/mZ/8ZJXC23pm3n4GJcZuRomIBIB+4BY82gWhxa8XrLT3gScdK2sBnknG09
	nNmX0EvxP08t413U2sdeZlvCuFNITr1nCJz/NcsgCKH2bSqiiD91HOa+HPM0pGUz
	wy62gOcgWY5YINzlC21mHv2GgXdqiHfTQlyV+lKFouGX1kkEUwgYEfQngFuqV8v5
	1Wck/21uGtLq7EmrLRNTig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbjt9qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 21:38:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GJuRh9026491;
	Fri, 16 May 2025 21:38:40 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbtb2peq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 21:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFvGhFZPudnN/IrEtoA3ZotPFXyBIhMuHBGFoLd90RFHHbY8R+r5R8ysj8bUrPKAorle5X2ajq+1BJxM/bqlFH4ouU1HgfOpg+xtxZMMA90EH+MRq4rOL92PH5hsJzKKmJqT5TNdcyMQOyjFoFzh3W3rGHN6NutkfWcLk78P1FEwSMUS4LZf8PO7y1UemP3TP9SFVN1+U3Dffcwj/ZZrZ4+/agdNAdGmLnQ0DQwYZWaZLjZH8+5RNWEVjw2ph4eRWSw32cXUb/ErO7JcX6cgaOk5/9q9uqaEYH2CX6orzVM9eQo6SazcqgYHSpmmyoduG6m16Jkrd5F30rD7A3ty+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYhPnxUNnURmYyWaQeHWK4ZrjmpxLUeuo5EI25kJN6s=;
 b=rIbo3MH8PtH7NGIReNkS3b16krrADidRLS0KRv71uaqO//Py1Oc+XBhaa5x4sRlKro3HGABlTX48YRAOqNBcavKF9imoRJhx4MbwgI2w54SGQfNrAb0IALDN/1/zYvWcH6Si4ZN6BfJH57raA4G96SoDO2jTilA7wVpikCml1+mydzdVjQ5zlB+DalZ7NdQptXoi1/7Hq1YYainrJIZxTOHEaT+Iq5g0R6iRz2c3l6/S2OprdZ37r5f284TkdRd0a3XUBAQqpqcauyMCM0eYxzB8rxIdGn/bBGk3JFhjlk2VInCfx9+7sx6CKZftXv9n3dphtcCTSm1S7j+8z6Kmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYhPnxUNnURmYyWaQeHWK4ZrjmpxLUeuo5EI25kJN6s=;
 b=roUToZG1SN/xrobwjWpDXtVcdv5BSPSBbGhC0WfWt1bc/ae9WASAHbzR8jOp5UpjWbfJtJG/+7au7reYzCszDoghXLqbLKC+V2h90KBpgGS1tExckDfFQTnXSKqHl6BaOVWqZ0ta18+aruTycOdWBRaDGS1zTTuDLG0DnDRrMXM=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA2PR10MB4410.namprd10.prod.outlook.com (2603:10b6:806:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 16 May
 2025 21:38:37 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 21:38:36 +0000
Message-ID: <8f58ea85-de40-476a-bc2f-d3f2414a065c@oracle.com>
Date: Sat, 17 May 2025 03:08:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
To: Piotr Kubik <piotr.kubik@adtran.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
 <584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <584b7975-1544-4833-8f8a-00a8769a80c2@adtran.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA2PR10MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: e28f8e22-10fd-4235-d046-08dd94c203e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVkRUFWVy9mTm5wWlNLS2ZlNW9ibW1LUGRXamZQWDBZY1NNQmx0ZDVzQ1RJ?=
 =?utf-8?B?NVY0c3FoOFJxdlVvdmpHcXpPQVczbEc3b0pVbE1JZDdLdXlxZVR1SEtEUHA1?=
 =?utf-8?B?Y0JkSlRoWXVlZzNqVGhaU29rM09rZjdQeTlHbFNQeExXZ0ZTVGI0bnNxcDBV?=
 =?utf-8?B?Z1l5bkREdkxORG9aSW5aME84Rm9UMytBZjNMSllNNFFrZXU5NWV6QzhVVXov?=
 =?utf-8?B?ZlgvU3hZdnRsUDhXS1lnTlJtRXFaaVI2eSttNlgvV3QwZ2JKRVJxbGtRQ0tR?=
 =?utf-8?B?L3FuaSt3S1NFSjVYMDNySDFZT2pEdFhWWnJTRUJ0WmtCcUJNd3MwSGRqbEtx?=
 =?utf-8?B?UjNmZVJVZjFuNjBxenZnWElEdElWWWdkRTc3ekhQNk1MMkVEbXA5b0FqbEhr?=
 =?utf-8?B?Z1dNUTZWdWlOSVliTFFZMDRpV2xYUVF3RUs5RWY2NUJ4OXBPZ2NxTDNJVFNz?=
 =?utf-8?B?bkgzRnI5Ti9rYy9TWU9qUXNMVjFveHlBQ1RLSW5XYXB4M3pDaklvZ3pWU3Zw?=
 =?utf-8?B?cThpV2xZelFRdFJReXhRdERlOTN6YlpqV2kvdVpSaFFmdGRCbW5qcStBamN3?=
 =?utf-8?B?amJ6Nk51S1VoT3o2TXhNdVo1ZWttaWtuSWhqSnROZE5NaEY5Y0NVMnBraU1m?=
 =?utf-8?B?aTJqY3l3ZFQ2WUlzVWtvMjFTKzVWdEVmRHpmVlZCTFFHaVVaNWQyRXZ4eDcw?=
 =?utf-8?B?L3J2Zy9PR20zbU5FNzEwQi9mKzNPN2tpTEs5Q0hyeWw2YnhVak5laEVCUzdM?=
 =?utf-8?B?V1hrWkptYWdaczV6MFpQVXlaTWR2NVBSQW5LM3JRWWtFbDNZdFRuYWExMmdJ?=
 =?utf-8?B?VjAwbmR3RzFOZmlTejF5WTRQWTU3S2EyeU1WZGFaTVNpVGJnMXpJdENtdXBX?=
 =?utf-8?B?eDFIQ2JIQjJxNDJzQ0dBK0RmNE9jWkwvdXVsSGY1cVRVMWIyRzlSQ0luVkVL?=
 =?utf-8?B?bXY0T3krOGEzM29vN1RFbTB4ckl1VWVablFlbk9jNGF3UUEwSXhrdUFrb1BN?=
 =?utf-8?B?eVFua1hHVFFNcDQ0MktTZjhRYWd1aTNweVZHczdjelRWNFRPNk1UT3NGQ2hs?=
 =?utf-8?B?b2NJVUtweEVaL1NHY3ZJSGxLYTh6SFlPMVAzNExGQ0xicUtsMlRYUjBhVTd6?=
 =?utf-8?B?RGtOamhZcFY3blcwaEJjb0xFa3RJMGc1V2w3b2doc0FqNjBZUGNQWFlZaGVH?=
 =?utf-8?B?MW54aEZlZWlacjJMTDB0Qks5SnBkRS9ta2J5SWxqYnE3djBZbStoTlBxb1kv?=
 =?utf-8?B?TVZST1doKzRzNUd4QnpQb3dpVTFITGhWRkNUTlp0VGFIMXNHenUxZmFpV3ZH?=
 =?utf-8?B?ajZPRDhBRFQ1TW9YU0VTRjJ2TEYwVk5MYUtrM2llR0hTd05CcjVRcUUxNDlY?=
 =?utf-8?B?a3ZRT0lmblBmRzV5Wnk1SU5nZGkyMXVLRkwxU0IzN2dCaWVZb1hqT3B5NHVq?=
 =?utf-8?B?R2VLNzJWN3RYbW0wT1hnaFRnV1ZWaklMaE5WNnljUnhJdnRnYWE3TzR6TW10?=
 =?utf-8?B?dERBODhOUGJJZzBOZkJGbHIraUJPY1dibWJzNEV2UDhBVVRGV0lBUTMraHc4?=
 =?utf-8?B?LzhhYkxXMG5lQno0cllwcVQweHA5c1dyMlU1Ty9EU2JqaEpmZjdPaTB5SjVC?=
 =?utf-8?B?WnZHalVLOVg3REt5bkFzZjkvTENROGsxajJFMi8zemI4Q3pHUmh5TExyNC9E?=
 =?utf-8?B?UjFXYUZsL1JTVUF1K2hNZlpSbXE3SGtPa1Jhd3JIM05BVkVUam1oMkQ3UDJ3?=
 =?utf-8?B?ZVNLajVsWDNPZ3MrME9nNUNNeVdzS1FWNVB4RnZVWDc5a1BXVEcrc2JkQnYz?=
 =?utf-8?B?QUlnYjdTdlFWdnNNbHQ2OW4yMllyQnBkdFJuVHVGaGdZU0ZvYjVUMFRVYzZU?=
 =?utf-8?B?aXJvTURNSUkvNURwT0dXK3dlbGZ0Ni94djBVMzduVEVKUEJmQ2lTK215M0ZX?=
 =?utf-8?B?eDRoZ0JnRDl3SGF5SllxWU5scHkrbE1FNU1KV3FUMWxRUnVqQ3g4THhaT1Rw?=
 =?utf-8?B?cWhIYXZzWjZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekJOMFE0Z2xNajVqeDBocDJwNDlwVDFCelk3MHpFZ1c3VklVa3dKcnJjaHVG?=
 =?utf-8?B?dDhaY2JDdVJIZUVseCt0bTZjajdFL1J6MzJ3T0J2clJTR2s0VTl4SEFnSVdY?=
 =?utf-8?B?ODdhdkMwVW1ydFhUNU43TS9XWWg2NzhlN2dCQ3VqSzQ5NHJlRGo1eEs5cXNu?=
 =?utf-8?B?MUR0REZBNERCMFBiNXpRS1k5ZnpVYXNteldPMGZhbDNNSUpxQStteGpmSzI0?=
 =?utf-8?B?dlVqOFNScG1tYVI5b3VLeHMzT0NiQjRZL0g2amtUUHNPSjQ2bytCNjJCdEE1?=
 =?utf-8?B?UkxrelV1TDFUUXlwVkNjMnZXbkJpYmxtUDdzSUhEZTNjZnBndUMwa3B3OG5X?=
 =?utf-8?B?YWJLVFRXN05LZk1CMWhUdVRaVCt6eXBBT0RkQmF5SzU5dU0yWWFwdkNTUUww?=
 =?utf-8?B?NWxhU0hvcnVqeDRTWUxsT2JVbmFlbHpySnVQVENubittNWEwNHlYcFNCN0dQ?=
 =?utf-8?B?Q0JKSkV3UXVsUTVybmZBdkNOSTAzalVUT1JiZk9EaWJFelk4eENVeUU4K1Nz?=
 =?utf-8?B?UTU3RTdqaklsOGM3Z0grbUJ1aldmaUl5WVFHcTNHY0VQek1hOTRLTFB2TWtM?=
 =?utf-8?B?REVFTElHQXpGakRSbGpUKzFWWk5yOEc1YkdVWGg2OUFWejBnNHI4bmdTSytL?=
 =?utf-8?B?elR1c042SEVka0lDS2MrMUdmbzNDamY5ZkFGWEVaMGgwZnJoWmExRW85Wlpr?=
 =?utf-8?B?NkxKMlhtbkhyQXg2Tm5Rd01RVkZPQSswa21nZTd6azF4SGQ2dnBLQnQrZENm?=
 =?utf-8?B?MlRjcHZEZU1qVDFPb2Z0dDlwSTNuWTI4MnB5YWhqc05jSjFSTHVQaHIzRE41?=
 =?utf-8?B?eHB0TzRwTTd4MmNNSGtXemdyZkpOM0hjZDRoakNiQzdHZ3QvaE1xS00zQVoy?=
 =?utf-8?B?Z2MrbHdGc1pJRitKcUh1TEx6djVSSitkWlJQUkNUTHZNeUpxYXJKN3gyUmJT?=
 =?utf-8?B?RjBRMENkUm4yQVJNa0Jhd25rR1VEWkZsUVl3ZDZTeUowTlZYbU42TnV6WWFt?=
 =?utf-8?B?c0tXUE11Rkl4UExpMUl1UUhXeDlvMUZlTUxvT0VnK2xrdlRNQ3JVMndZdFg3?=
 =?utf-8?B?R1plTjBBTzhHVUFZcjBFU3owaUZsSk1GZVFYWTN4QnpiUVNaaUZLcmlHQ2hW?=
 =?utf-8?B?bi9BTE9URWpyQjBGcFpXd0M2VGRLalo1S2N3aitCam11YklMVGE5L1R2RThk?=
 =?utf-8?B?QkdScWs3U0w0UkVKa29Zb3dpSzZzc3N5YUVXbG5WaU1QcW0veWIrZHlwU1VD?=
 =?utf-8?B?OXF5NWh5bmJyLzg2NGpTTEpxQ0hLYTdqUVJmZ2VzWHBLSFMvYnRYNWt3WVYv?=
 =?utf-8?B?N2pBNEFSNk9PVWhDcXprWjErY2F1MGNCYjFRb05sREhIcS9JS08yTFlTNE9P?=
 =?utf-8?B?VVc2dE9WbjEyc2pLOXNjdmFQcWxQU2VwMy9LTkQ1QUQvTFZYQXB5QVhmeUp6?=
 =?utf-8?B?NEtzWmpPdkdXU3kzTklzR1pzaDVpZHBHdDIyYU1wU21FMks5TTNUK1NucG1Z?=
 =?utf-8?B?WTh1WE9hZG1JTlE0K3RJNGFzWXpsSXpoa1I1ZGJPdUF2ZFVKRXpyUVBjSDg2?=
 =?utf-8?B?WnY3K2ZtNnlLcmxQMUt2ZHAwRGttM1Z3MWZMNEZNSWdTN0Q5eDNEZ3A0SmRY?=
 =?utf-8?B?Rys2MlAvY0xwV2NkdjJsS3oxUUdORXk0Vkp2eEpsRTBsUUVRSXo5MGx2dmdn?=
 =?utf-8?B?eG14dlJ1RWwxRWMxSzRKSU1EWng4MHA3TGdodzFGdHIrWDBPT2NZYVRaOTBI?=
 =?utf-8?B?OFFVRzBWb29yTVNLSzVtMHF1aHN3T2JjczQySUc3eWtVVitURzV6Ymt6MDBj?=
 =?utf-8?B?RmZYa0dCS0VMeXlLcTJ6U0VETWRZemFZMlptY0FWRElrUmVRODdwWTArU0FY?=
 =?utf-8?B?SVd2VWd6VzFiU1pRQWJQSFUrUE5YVUZxVzZFQVNISVA0R3IzS2FjSGJESm5K?=
 =?utf-8?B?ZGJ5dEJYbWRPQjFaSXlNRzZWaXhyZVo3TzBNTEJaN1lYYkx5S2czaGc2RTBk?=
 =?utf-8?B?Wm5ob3JjUG5wQ1dKOG1BdjJaZVl2YlAyb2oxcHF4QUovNnh6Zm5lRTgwaHNF?=
 =?utf-8?B?Zm0xbFNFdDlFeFYzWHBuMHpLdEk4UjlORmFSbDVLYndBczN1bHNtMlFjVWZs?=
 =?utf-8?B?cjNodlRWU0p5eXNuaWhNcEdvZ1JaLzlON0REMmZYTW9DWGk3WldsdHFxdHBS?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dTI8n81I49i4RwUVMzVaRPyloYMLhkioQRaKUUWDgiDp7zlUu9kjgo1H6Fh6KjIH25CbeXwvi+p5dAukhPnOk88mmXmDItst8pPN5leiouz1Ol37gzfT4296lw22F+Hdgb7Lft5sS0joC8fMaOc0cdcDUhuL6TxmE/3o9vvq31tRpyRICt06wzmWezkltZxgWoA0g4M1SAGlgI5F086MLwzbzRgiV8l8BhFNbnA/wZo9dq5x7YZ7leENIUAqCZvOTc9yIZ7gFNgL2o1+s9fDIkoYuvw10KazsAP40oLBOY4FwBg8MAjrqTkJEapMzkcqrjfpAtD1MCUx+LCQ+KX7DRAqdbs0EhT82HxuktPm+E+Bjgoani/gYBcCfpbZhe2QIYCSmLRHHLbFXmviNZX6pK2fD7nA0jQfPhvi9IuuSrGN01p96TDpSYqEqZ6dPmUVh+V6nobgVRJk30tax30yk/VY2OKImNYBCM2lro6OY8tcZnQsmrHfni+KQIzDuWK3hLd2eXkTvP+HqiUnlHSeGzB81N47vh9uw17Z9buzykDS4WU2wiq8mEeBJDJXcwDjs2DYIoEvFzHVoxzauP64giQW1apR2gXFxRZ5DeMSx94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28f8e22-10fd-4235-d046-08dd94c203e1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 21:38:36.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbNSolltR8cbcQV+FshnfgtzXjMVknAxR9Pl7Mh6zM+l5iqDuJtcPiNMPE5NY1xbWT0AZgy98Md79rQxxWr997nJO8U0aqO0a2Yd+TrwBIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160211
X-Proofpoint-ORIG-GUID: qEFihfWWwrtHqP0BrxVqNK8Hf7wYeNaN
X-Proofpoint-GUID: qEFihfWWwrtHqP0BrxVqNK8Hf7wYeNaN
X-Authority-Analysis: v=2.4 cv=aYxhnQot c=1 sm=1 tr=0 ts=6827b061 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=eJNrpioGAAAA:8 a=ScFIWEJ0MQZZgqo7N_QA:9 a=QEXdDO2ut3YA:10 a=lGWzi0NnWLiY2xPCY--v:22 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIxMiBTYWx0ZWRfXw0RYXecJALou nAmOs05CCmjdBwGKp2mvQn/4jlxRd7ySph2Tr+jsKkJhS63p3YxVXEK3bZ6sulgHsxckT/HyTd7 L1IE5FMEPEqUl4qrRuAD5/kv+4cmbF2X6WVf3KCteUEXrWZYhKOKz6DN6I8Uwm8J+0IDIU8TJHV
 qsfZ2O/mTrN38TkhrD+l5K4C2eEzvCXwfhY1Jm5u2kihe9YYocr+lcehe4VUo3N2IXWakSC8itP 6YIrXL1ni5iNAqAQQ/8goplW4Dc9RCMtKe7NU+kQkW358zeyv3cVGETxKxWYlkao7jFG8wNV1S+ B3GFBzy3VhTcefZN1IyGNe4v9ftlcprfW3bPoUX2yb0xNB4dVy4/f8eBpfNNuJhTETtQnISAYsI
 yrdz+t3BKP+0ROLtuFOsA15gDFzguB+ZNmnBOHEBraes0a5LR7p1/EUjJ012pcW0ahglaTbh



On 16-05-2025 18:37, Piotr Kubik wrote:
> From: Piotr Kubik <piotr.kubik@adtran.com>
> 
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
> 
> Based on the TPS23881 driver code.
> 
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
> 
> Only 4p configurations are supported at this moment.
> 
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
> ---
>   drivers/net/pse-pd/Kconfig  |  10 +
>   drivers/net/pse-pd/Makefile |   1 +
>   drivers/net/pse-pd/si3474.c | 649 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 660 insertions(+)
>   create mode 100644 drivers/net/pse-pd/si3474.c
> 
> diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
> index 7fab916a7f46..d1b100eb8c52 100644
> --- a/drivers/net/pse-pd/Kconfig
> +++ b/drivers/net/pse-pd/Kconfig
> @@ -32,6 +32,16 @@ config PSE_PD692X0
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called pd692x0.
>   
> +config PSE_SI3474
> +	tristate "Si3474 PSE controller"
> +	depends on I2C
> +	help
> +	  This module provides support for Si3474 regulator based Ethernet
> +	  Power Sourcing Equipment.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called si3474.
> +
>   config PSE_TPS23881
>   	tristate "TPS23881 PSE controller"
>   	depends on I2C
> diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
> index 9d2898b36737..cc78f7ea7f5f 100644
> --- a/drivers/net/pse-pd/Makefile
> +++ b/drivers/net/pse-pd/Makefile
> @@ -5,4 +5,5 @@ obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
>   
>   obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
>   obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
> +obj-$(CONFIG_PSE_SI3474) += si3474.o
>   obj-$(CONFIG_PSE_TPS23881) += tps23881.o
> diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
> new file mode 100644
> index 000000000000..7c21b475ca1a
> --- /dev/null
> +++ b/drivers/net/pse-pd/si3474.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the Skyworks Si3474 PoE PSE Controller
> + *
> + * Chip Architecture & Terminology:
> + *
> + * The Si3474 is a single-chip PoE PSE controller managing 8 physical power
> + * delivery channels. Internally, it's structured into two logical "Quads".
> + *
> + * Quad 0: Manages physical channels ('ports' in datasheet) 0, 1, 2, 3
> + * Quad 1: Manages physical channels ('ports' in datasheet) 4, 5, 6, 7
> + *
> + * Each Quad is accessed via a separate I2C address. The base address range is
> + * set by hardware pins A1-A4, and the specific address selects Quad 0 (usually
> + * the lower/even address) or Quad 1 (usually the higher/odd address).
> + * See datasheet Table 2.2 for the address mapping.
> + *
> + * While the Quads manage channel-specific operations, the Si3474 package has
> + * several resources shared across the entire chip:
> + * - Single RESETb input pin.
> + * - Single INTb output pin (signals interrupts from *either* Quad).
> + * - Single OSS input pin (Emergency Shutdown).
> + * - Global I2C Address (0x7F) used for firmware updates.
> + * - Global status monitoring (Temperature, VDD/VPWR Undervoltage Lockout).
> + *
> + * Driver Architecture:
> + *
> + * To handle the mix of per-Quad access and shared resources correctly, this
> + * driver treats the entire Si3474 package as one logical device. The driver
> + * instance associated with the primary I2C address (Quad 0) takes ownership.
> + * It discovers and manages the I2C client for the secondary address (Quad 1).
> + * This primary instance handles shared resources like IRQ management and
> + * registers a single PSE controller device representing all logical PIs.
> + * Internal functions route I2C commands to the appropriate Quad's i2c_client
> + * based on the target channel or PI.
> + *
> + * Terminology Mapping:
> + *
> + * - "PI" (Power Interface): Refers to the logical PSE port as defined by
> + * IEEE 802.3 (typically corresponds to an RJ45 connector). This is the
> + * `id` (0-7) used in the pse_controller_ops.
> + * - "Channel": Refers to one of the 8 physical power control paths within
> + * the Si3474 chip itself (hardware channels 0-7). This terminology is
> + * used internally within the driver to avoid confusion with 'ports'.
> + * - "Quad": One of the two internal 4-channel management units within the
> + * Si3474, each accessed via its own I2C address.
> + *
> + * Relationship:
> + * - A 2-Pair PoE PI uses 1 Channel.
> + * - A 4-Pair PoE PI uses 2 Channels.
> + *
> + * ASCII Schematic:
> + *
> + * +-----------------------------------------------------+
> + * |                    Si3474 Chip                      |
> + * |                                                     |
> + * | +---------------------+     +---------------------+ |
> + * | |      Quad 0         |     |      Quad 1         | |
> + * | | Channels 0, 1, 2, 3 |     | Channels 4, 5, 6, 7 | |
> + * | +----------^----------+     +-------^-------------+ |
> + * | I2C Addr 0 |                        | I2C Addr 1    |
> + * |            +------------------------+               |
> + * | (Primary Driver Instance) (Managed by Primary)      |
> + * |                                                     |
> + * | Shared Resources (affect whole chip):               |
> + * |  - Single INTb Output -> Handled by Primary         |
> + * |  - Single RESETb Input                              |
> + * |  - Single OSS Input   -> Handled by Primary         |
> + * |  - Global I2C Addr (0x7F) for Firmware Update       |
> + * |  - Global Status (Temp, VDD/VPWR UVLO)              |
> + * +-----------------------------------------------------+
> + *        |   |   |   |        |   |   |   |
> + *        Ch0 Ch1 Ch2 Ch3      Ch4 Ch5 Ch6 Ch7  (Physical Channels)
> + *
> + * Example Mapping (Logical PI to Physical Channel(s)):
> + * * 2-Pair Mode (8 PIs):
> + * PI 0 -> Ch 0
> + * PI 1 -> Ch 1
> + * ...
> + * PI 7 -> Ch 7
> + * * 4-Pair Mode (4 PIs):
> + * PI 0 -> Ch 0 + Ch 1  (Managed via Quad 0 Addr)
> + * PI 1 -> Ch 2 + Ch 3  (Managed via Quad 0 Addr)
> + * PI 2 -> Ch 4 + Ch 5  (Managed via Quad 1 Addr)
> + * PI 3 -> Ch 6 + Ch 7  (Managed via Quad 1 Addr)
> + * (Note: Actual mapping depends on Device Tree and PORT_REMAP config)
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pse-pd/pse.h>
> +
> +#define SI3474_MAX_CHANS 8

SI3474_MAX_CHANS, this could be sound like changes or chance

> +
> +#define MANUFACTURER_ID 0x08
> +#define IC_ID 0x05
> +#define SI3474_DEVICE_ID (MANUFACTURER_ID << 3 | IC_ID)
> +
> +/* Misc registers */
> +#define VENDOR_IC_ID_REG 0x1B
> +#define TEMPERATURE_REG 0x2C
> +#define FIRMWARE_REVISION_REG 0x41
> +#define CHIP_REVISION_REG 0x43
> +
> +/* Main status registers */
> +#define POWER_STATUS_REG 0x10
> +#define PORT_MODE_REG 0x12
> +#define PB_POWER_ENABLE_REG 0x19
> +
> +/* PORTn Current */
> +#define PORT1_CURRENT_LSB_REG 0x30
> +
> +/* PORTn Current [mA], return in [nA] */
> +/* 1000 * ((PORTn_CURRENT_MSB << 8) + PORTn_CURRENT_LSB) / 16384 */
> +#define SI3474_NA_STEP (1000 * 1000 * 1000 / 16384)
> +
> +/* VPWR Voltage */
> +#define VPWR_LSB_REG 0x2E
> +#define VPWR_MSB_REG 0x2F
> +
> +/* PORTn Voltage */
> +#define PORT1_VOLTAGE_LSB_REG 0x32
> +
> +/* VPWR Voltage [V], return in [uV] */
> +/* 60 * (( VPWR_MSB << 8) + VPWR_LSB) / 16384 */
> +#define SI3474_UV_STEP (1000 * 1000 * 60 / 16384)
> +
> +struct si3474_pi_desc {
> +	u8 chan[2];

here chan does not sound smooth -> channels[] ?
especially for an array or list

> +	bool is_4p;
> +};
> +
> +struct si3474_priv {
> +	struct i2c_client *client[2];
> +	struct pse_controller_dev pcdev;
> +	struct device_node *np;
> +	struct si3474_pi_desc pi[SI3474_MAX_CHANS];
> +};

Thanks,
Alok

