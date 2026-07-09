Return-Path: <netdev+bounces-306110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eaaeMzloT2qWgAIAu9opvQ
	(envelope-from <netdev+bounces-306110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452172EDAC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:22:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=aaEyokIC;
	dmarc=pass (policy=reject) header.from=windriver.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306110-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306110-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD632300DEC3
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2AD4028D6;
	Thu,  9 Jul 2026 09:18:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248D3FC5CF;
	Thu,  9 Jul 2026 09:18:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588730; cv=fail; b=uiJN/k60z2F42faLRf8+Ke8+4JZXj5qnAdbxCi1fD/zTKUc02poClR19eyrAw8i1GNiCfoRPFGZQgE5RmXnhaJmd4mWauor0eB5/HmSdXLF4bXe1c4QwKAICfOKzF2J7qxXw3wtIKt6MUOqbDy900RLQBdEB2zHTCS2HdbmLX/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588730; c=relaxed/simple;
	bh=wxrtzpdxDBr5QQ9/Fjs5MpebNnqikoxY0IjGHKc/XKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVApmYBhp0f9cQOp0yicyhK03U1Z4rrNdukaUlXtkqg9QPiDwEABnUxGyl2fJAMoM/8pC/xzPIMD1ntheQxNBAnFRoCr/3g1ljVB82YA5VTIfC0BDUrmT2GTvQMqEl0aWwuWZXWBvsCQenr933ZmRqE+vniC97sriRRrF8LR7ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=aaEyokIC; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960uG81727367;
	Thu, 9 Jul 2026 02:18:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=gZpSTu/EPoAuBDy9YQDCjQIzl/dR9UPS0/HY4HDm3dU=; b=
	aaEyokICaZSMU4AsCMPjJDHR2wAQJcXhp3zbDlhFQG1BhDK5Atr5lICYpcxRUmkK
	k5V06KpNlbq3pJxugFgOlty+rgVAXQREUaDcrTD21EPYHlM4cNUTsWg0V0l8fkcZ
	8LwAVv35qxgSVU42sMgJ+Vg6J3K7CSTYJOsXzJoAzWmDlXizMCiTPBBeJX+7Y7iI
	qqU79To9BLjOMbwniewN+S2fuGeSeOGs2xgLMXFFQ9kYE/k6lUrpr3y2wg5TNkST
	bIZORuFgcbVN4V/hJG8Csj5fmLLhgeVywD423HPcAIMqY0RPUIp7FbKBY4+PMwX4
	S+vyZu92egw62M+9yrd8Dw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1gy8jax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 02:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGGZlHE4/MPqUWFMppdtAeB20FipKGCKScO5EQ5bGU3INQ1iN/kbU8yYMksd+CCvePlZjOIrlMmZRAFb34rFWqKbkSLYyP8DgjPuZUApxZ8Rc757R2IbfY4j71mlEfEWJODwRdSKpadzG4e0iXMeAsSs62MJhhMfPS0ojeqUgtDpSFT9jyoD7fewTre1wyTSOuEw4tCarR+h3/qXBfkwI/FKvymxank9L8OGFSmDv/RERffO74c7gGo5cKOE00fy28DAEignh1Tgcyf7m4Aj0P4X0LBkI5Gukc8pG2DQB4uGU9sn5Yoz1wf4ngtzGsxzqcu8jZY0HmfhhCwveGasdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZpSTu/EPoAuBDy9YQDCjQIzl/dR9UPS0/HY4HDm3dU=;
 b=hFx+MzgflGP1vj4NyAudjwC0GCEllx+LaafTl/iPjP/JXw/VamkoeBmarUzmvVVlJ32Bm61l6WE0AcYoSjzc3FLo4nyRhiBPvKLhLBPQZnnk3xshXBEosJPc9nBR18aBbtHl7Gn4G4c/b2n7CjC0giDkjJN0oPSIBlp/p0rJFiTBoSHMFu0BMfUQ6ul2I9EUBJqIOAswJP9l0pMfaMl03U2ICPYBcoGiBctvBm55SyZz7WT+OkAriU8oLcexbQ7Rmew0dKTGjw92bn5+gVcEjcLSkFcRJIysWOUX97TZJIBunWtLjGmp1YG+uDNEYDKo/uvELr7iyHiGQJcNlps0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DS4PPFA424F92C2.namprd11.prod.outlook.com (2603:10b6:f:fc02::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 09:18:29 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:18:29 +0000
Message-ID: <c58de90a-0ba8-45aa-a9ce-37d996ac0173@windriver.com>
Date: Thu, 9 Jul 2026 17:18:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock
To: Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709065631.3488067-1-yun.zhou@windriver.com>
 <695fc2fb-606e-4d5a-a4d6-41ba5d1cfadb@redhat.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <695fc2fb-606e-4d5a-a4d6-41ba5d1cfadb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0026.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::10) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DS4PPFA424F92C2:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b88611a-310b-402d-46d4-08dedd9b0a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fxkxDQiOQQM3JfFQkdo1ALG2y8U0D/xWsFzJlTeTsUjKD50qBG9D9qWg80as6kY3u37YOT4P8Swu9Mux4Ucf8EemMXm/ru+xb5lyQyPTywXOUEkfxHf4/kBzMb8OGln6YLpm/kvLWTHXqN7ur/OoS5cICWdlz+fm+umiacnD/4VDkauoJ9OqklQ+pv6KWnfLA+I2Emvd4XUlmWejSeQbczzSUmTNUDwiBcjfvsdk5+3Y38HAfO/rQ3AVOnK6+oGiH0pzIiyHp1xvlBpWBqKx0JLq4nFh6y9G6yWMW8/u8e87/sfqbSkd/1H9kpB1c7ptCPPwXyZXNhKTAMyp88s39GZ08H5XNlDFE14SzjeKyZZrzo5hBnndsUqmmm/IbEqvN6FYs9lofH6CBqD5gF1klmeNaKOMbP29LF5+0ImFHFRh3zdE8mJzjv82DSBM+V0y9gVbyjMfmx8g/A8NWKK9BYjRJpxsUp56cJrF7Fg19OfBqRN2Kjzf6160mPJAf01wylNKafsrSXCG+oeeZCwYfSI8o1yNHLw7V9aWSOAk7X7KHmxkPdhGeL158V8OzTMs6BQxBajx69IGNXrdQtgHpp+cOirooTtQa2yAxs8vKrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHBSYU1Gc3o4Nkt1NnkvdExTMFdJdHFtRzJlK0dTYnk3RWNBN016TlZ3ZDFl?=
 =?utf-8?B?L29QZm1kNkZjSTRzUnR1bzlINEIvclVYRTA2OGNDd1dNUWZuYk5HUzRVUERE?=
 =?utf-8?B?bFUxTlVJQ09MNVRjZUxxWjlGWk90REl3UW1UaTZqNUpZMVNiam5Sc2pnSUlP?=
 =?utf-8?B?aWhlcDdqZ29sOVdvWEZocVFBLy9YUWJmTU9XQ21KZm9NUXQzOUZXR2FlQW1n?=
 =?utf-8?B?TDFYbmxad1lNdktMRC9kQTNsSU9sdFJKcVFMY3d4UEdIUkFUenI0VXp4M3Bm?=
 =?utf-8?B?SVJLYVlzM0ZUMFNxZlR0Sm54MC9jUEZ2UDlLcURlcEtiYkpnSTBRRXgzMzI5?=
 =?utf-8?B?SFUrRjVCUitYZkJvM25hbU9oTE8rcUlTY3JhSGh3YVF6M21PV2drNFB0eTVO?=
 =?utf-8?B?bTZYVjZaR2dWV21EZUZUdWxVR2ZiL3hpcndSbGFoUjBTSW43V2VWQ0JlVGtn?=
 =?utf-8?B?cTRHSEk1Q0lIQXhONE5SbDhSUnlGem44M3YrNjJ4WjJlb1ZINk40TzJvQjhO?=
 =?utf-8?B?bGgxNUI1all6MmhQSlpWUlFOaFEzMVFBZXRUUUFtK2hyQUl6QVg5VUVkZkRG?=
 =?utf-8?B?elUyRVpXcXQ2akkwRUdHRy9sdXpDLyt6V2F5dkN2ZmRQeXlGVSsvaWR6Q0g4?=
 =?utf-8?B?WndsVDRrWlFDcGRNdUFsSTNoYkV6cWhSWlJrZm9wd2dvRTFnRUJHdWVXQm80?=
 =?utf-8?B?WVVtT3hXaTltUHZqaSs1THNwRG80QWh5VUl5T2NVY0VKa1kxNFZLbW0vMUxZ?=
 =?utf-8?B?L0JpTXdwU1MvejlBWEVQUGZ5bnZxMGdoUzlrUVNBTitzT2srZWF3MDJGNlAw?=
 =?utf-8?B?WkROank5am5ob05GUjBDNzMwQlJDNlhKUVZiaHlEVXdQTXFvQnRFd20rQzJj?=
 =?utf-8?B?aGdlUlRoMzRaR09JSDgyY2hoMnFCUEt1N21HdVNuYVJVQUY4WUp3MHE2a2R3?=
 =?utf-8?B?Y3FCRy9DR01YbjVnY1RLV3RYdkZoWERaWUN2OERLQ2x5U01taHFVL0xZU05H?=
 =?utf-8?B?Q2s3UFVYRjNuZjZTM1NmaEQ1SnpqcWtYSnhtMHpxMU1jSVRyZWpkYm82VnNK?=
 =?utf-8?B?eERYMFZXM2NsRnNTWmNZc1VIVTVqUUxHZk1NU0xia0hiZW5SN2F1YUJ1eldk?=
 =?utf-8?B?RDhrSjJ3QnFxRGJWd2wwd21jM21udnVsNmhaYkxERXhIU1l0SHNmS3ZVa2RC?=
 =?utf-8?B?M3pyZTQrNDg4eDMrdHBlZ3NPKzNaUjIxL3BucTNNWkxjRWZqZlc5dlVZWmFk?=
 =?utf-8?B?bERpejR5cFExenNRb3pUYzk1MjZ6ZkhjZXJlOHlBZUx2ZFYvNk95TU5tVkhZ?=
 =?utf-8?B?T3Z6eDQzZ1U5WCtieG1Nck1wRnFGOFQzZGdOY0ZadWc4NEdsZnB6TWxYZFN6?=
 =?utf-8?B?WmJlMDNhQzVBRUNmbTVISW4zcm1icVNaUU43dlpPa1EvcGthcHR3d2g5SnZh?=
 =?utf-8?B?YzBRcUNhL2JqSm4wN3o3V09FWlk1K2NGalZnQm1od2ZZWDhlcVF1WUVHenEr?=
 =?utf-8?B?OTRlRmFrbTN6WEEvazJGL05SaVNvNUpsNnNKWGV6T2ZGZGs4Z0JCc0JGRTVn?=
 =?utf-8?B?cUg3UlRSek9EMXdxa0dpb2c3ZkdLRXhGQW1PNUIwdlVKa01ZV254SnBwYTRr?=
 =?utf-8?B?WmltTjZ1aFFTSjZjMXVDVU1PekdFS2dvei9qYTVmQW9paFBMS0ZCRFkxWnlS?=
 =?utf-8?B?WUlnc2ZGYStrN3VhNXBYNFBMVXZlelErNStKOWppSThad2NUcklVU2dYVUxn?=
 =?utf-8?B?NGlEeTlYRGJVVldEbHZFYStEQmlyT00rQlNZYTRuVnJTUmRiSmNPcmVNVzVh?=
 =?utf-8?B?RTJyN0VHd1p1UldDVkZxN2ZIL1hzelk5c0pFSmpEaXVyV3hYZ1Avb1pRTmVv?=
 =?utf-8?B?NEIzN3ZSblMwRzVwVVhNbWFtMUI3VFErTUY1WlJpUS9PTVllYVFHYW5GTWI3?=
 =?utf-8?B?TG1vcG1ZYXhXZGdwTjRjN2FjWFVncEpnUk8veEdGVmtlWm1IOFNUNHlYeWlM?=
 =?utf-8?B?YkNRK09LaUJIMG53RWI4VEQyV0JlU24xZDhCaFNWTm5RWHkxU3FWOEg5VFY1?=
 =?utf-8?B?SEdmekNVTmRZM29va3dhZEN0bkNiQjlFb015MGZkdVhKNUlCaWtRQlJEZUx4?=
 =?utf-8?B?T2NSc3QyaVBpMCtuN0hRcW1EZlZ0bk5OMEwwSll5ZlZaOUNDSW5kYjlsNndH?=
 =?utf-8?B?aE1ScjE3eWdxSnJ5Z1FIcGMwcVk1d1Y0Y0NTQkgrRFZGZ2tCL2NVNEFZUEdk?=
 =?utf-8?B?ejNJb2g3WmhYVTJibXRyVGdwSFFqai9SRmFKYUR0Q0pQNGplQ1FGaEJyVHND?=
 =?utf-8?B?VTdsMU5WYkRTK3FvdE83aUZQQ2pYQnIwLzFieU1mb1hyMzJGT3Zldz09?=
X-Exchange-RoutingPolicyChecked:
	tDpSMGuTZTthyazbLOQ78f9rQVZYbgkxM5l2fp0qJKaf9sudCjahVbQ05PbtRtQS7xSfUwLpXwkNKanTrQughS486xe79san0TnXmlMVz3m640uOi7mm9L0hyTXgRo/tMLZs36Re64N6Rhb3wvuY0oJlYkpTrMb/FLfn96Rv8b59eS89/AaO35p9B60z4F3cGPLcuL5A5VjgKqY3yqWBL8HQdq1+VujiEZaIT1vnjZGEU90EkW+wuGCyxWL/z+rHq0ww/flGIEbHY4zP0pw8LxG5Kui5OiM9P2/emmdgySQQ7aYoDVisDWaf6qlpK/YoiuOQvuXkJZOhtsbz2WQfWg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88611a-310b-402d-46d4-08dedd9b0a0a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:18:29.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSPV1oIcdT+dOumghnslHnD3v9s0ekh22Aylni8O9ko8S+QGhuGciTmhPN4ucKcrzhor6cqKEZf+61X6G9JOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA424F92C2
X-Proofpoint-ORIG-GUID: 9OmhQz2V5pHhaU_ia8-wCm_tu8Ryc2l5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OCBTYWx0ZWRfX7QQjkGUwNn9R
 kQ6sh57fVBkig07vJmYdRSnO/a8+3sLXbS8/gX6aAAxBEKgwnpn2rFtnX6MzmrHTZ6sTkjZ8hqa
 qQpjKITimmRZikxwGkjvBezjlcQx/1hnkJC3RmesbjXObqVKbdV2
X-Proofpoint-GUID: 9OmhQz2V5pHhaU_ia8-wCm_tu8Ryc2l5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OCBTYWx0ZWRfXynFOWB2S+429
 JyW28NBNbN83ZED+eZl4/pMsAzPicbwhexmdkD412yy0VZDySzEvPkwY5pXEh3LkhtzO/8Xrkp3
 XvL4Hc6fQxXc8/kbbT94YoF9nnPyWckI8pBNDuwuaLX5HhlJhx5eoWpPPee/a3oa9yxnEMUD4m0
 hSbLs3wW6us9WL0eywo/5snWTnZg7EOOzhC631LqmgAFHWoAM43uxZtb4o9jficiimfI2UVlMkE
 mj7lcQPQZqzzqi0yyRUwZ48LYOGYpatmc+v9Vmina0U3Fcll+lnXKbNzdPpfdn6i65For19y0bU
 94d2tVwSiwvYPNq3YYqm4PshDTWOJ/6kBnZ/1C8jpMB4z0d+ehCMOgdaYODrQjQWHG9YNXVcGj4
 Wr4pD/AKi/9ahATHXM8AmRCkgXJq/kqFU7Ty9C6uu12Jh7RtqIuF/uyAHN3mdVYMrhE2ih1n3mC
 UZE8BgCwVrKHCmxQcyg==
X-Authority-Analysis: v=2.4 cv=P7IKQCAu c=1 sm=1 tr=0 ts=6a4f6769 cx=c_pps
 a=la37NW5KtsdugurppmDlYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=pGLkceISAAAA:8 a=W_0iRrS7nssJa3E9ULoA:9 a=QEXdDO2ut3YA:10 a=VJtZ6omjavAA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090088
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306110-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,windriver.com:from_mime,windriver.com:email,windriver.com:mid,windriver.com:dkim,bootlin.com:url];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0452172EDAC



On 7/9/26 16:16, Paolo Abeni wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On 7/9/26 8:56 AM, Yun Zhou wrote:
>> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
>> nested acquisition of _xmit_lock on the underlay device while already
>> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
>> the same lockdep class, creating an ABBA deadlock:
>>
>>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
>>
>> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
>> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
>> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
>> the sibling device with identical xmit structure, already sets lltx.
>>
>> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
>> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
>> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
>> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> So this is actually a v2 of:
> 
> 20260630183702.170798-2-hemendranaik@gmail.com/20260630183702.170798-2-hemendranaik@gmail.com/
> 
> right?
> 
> please have a look at:
> 
> https://elixir.bootlin.com/linux/v7.1/source/Documentation/process/maintainer-netdev.rst#L434
> 
> any kind of re-submission matters, no matter how trivial is the reason.
> 
> /P
> 

I sincerely apologize for the duplicate patch submission. It was a minor 
oversight caused by a misconfigured Git in my new environment. However, 
it seems this email was sent to hemendranaik@gmail.com, right?

BR,
Yun

