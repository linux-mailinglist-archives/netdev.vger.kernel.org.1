Return-Path: <netdev+bounces-245204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CFCC8A82
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 17:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1339E3130203
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C53446A6;
	Wed, 17 Dec 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZaCbGwm+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZ1i06km"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884E20FAB2;
	Wed, 17 Dec 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985924; cv=fail; b=kRB5oAEXvSc3yx1uFw5U64XifPfkm2IF1KoBDBp0Poi88lkWmCwCV7zrhXOBEpaUGN094hIbsYrL8T8kL6oMdBChZDfg7RRdoY2KVirrx2raZ6pudAeJiTp0sNifmAt7YjFM30wCCkYDePhgpkKTk9Ch5gDFCFGxGne3Fd4iaZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985924; c=relaxed/simple;
	bh=rs1VjV33zpJ68SEFNJzcQDW230Wbxb/Yf6CftuJVAHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+/LvA+F+3bq1U0KeqDrNPqEZAt0tvm3NG0jmB7l7EUrbx1GwcjMtlsqnCGpEs2jp5mCgYcyvW6BKGamSzAFt6cGgfGQvN5xaRby9DayTpBSZTD5WYORIybDYGUNn4ZuVqamwFJwYlb5mwv8Kwxxp7wyH+wr2jZW8vdnOLQB4GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZaCbGwm+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZ1i06km; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFEF9g3228018;
	Wed, 17 Dec 2025 15:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XLrBpmn9TvCRWcEoKYmlPNC8qi6f68FpVDxGgrgiI34=; b=
	ZaCbGwm+pxN+zu5tDmm5/VPt+XVVxLTtEatVe3yvdhom7H5hsJIX7hcEhPIfNt/k
	B/SQLo5sHM/KLZrDDZpNh8qqJWCnrj6HI4QrcKEbTDXx7ehqMkTeOo7kIu5JKVcX
	WJ++PI2UK18qcvf0wvoL3J29peL0c8UnhPhhyB6TwdXCHS4UCBZdffsa4G71N00a
	n9B4XQtv8ZC7kDXLE9EHfwwLmR/XDzTl4qIElScjqNE+Y6+AIqV0TcZ0rxl81w7/
	g6Incd7CVFDM0ATwskw2pgVQmKaPgHMyYQbAz8PxrAMt3GfCZpZLE400BEfs60Cn
	TXR4TGwMNRiW4K9cYgeKyw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106ce36q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:38:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHEN1Dx025249;
	Wed, 17 Dec 2025 15:38:34 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkbxat7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USqUvOTD9kME25C06KDbpiC0Zd6PshRt8rGUg7hX9qlEyp1a8fuPlTxOpZnZgwJuM5UmMepmx86kv08riItA+Ep4yQePCV7rrJh796/ymxNcbbbFxtK4O98W3uTk3g9W0azJmObvahBukRGJNb8MU5aSO1BRmE67SjowOSjk4Q5A58b40/5aQCPuPJCaJCBxmBMuz4J+oDHZggSysCl5BKV8Pn1clT+HfvCc0BKcFyj8+5XAzYXC6tnxeQdK2wpJQzxaIbANtmBaeNcxFqXBwnExIZpWY+H0D3HDMTYC/qrPnTiZyJyx8SdZsPAfIJiUFZuzBeNa7Dl967BfIwcrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLrBpmn9TvCRWcEoKYmlPNC8qi6f68FpVDxGgrgiI34=;
 b=YN3AEXYD62CuWxxXfloCvv3z5ViVdwRWPDyqAYIyXb4zR7DFnVWtXWHSSrm/NKx/+9aIKEAFjE4Kk+Nbet86/HQRnbbwqSQhxpNGroq40ueRNoSMtU6PCUqLLT3/qqkW1Zakm4KEIEbUlqZU/g0JNNvfNE3Zjj3RvLRrAAxdmHYwnvS+0gzlc8jTr5NgUVvGNRdl2PXD7GSzengNIdHrs9SqXkgBSgYbhsZk1BP7fgey/f6fIJAiB+bfc+38vTFDKJJLL0SuKa7agjNfxi3OOK5Srq5RjMCc3/UsOn6tixJOjZ/SoGfcHd11XPSxb1OUCAKfHqBIq/GMPB0IuZ3HeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLrBpmn9TvCRWcEoKYmlPNC8qi6f68FpVDxGgrgiI34=;
 b=qZ1i06kmgQMTO/s9u/9zrBMp1FAWjXtJ9GW6PnZ+gZlkmPxcxz3qkol+xgVJJ27YKgTful/JM9SwXCSpqwuM5BTJwah3y/zkrDbcakILQLyJAe+hPh4hxUWtmRKTmSWS02dR527TS/yU62EGYmgfaITIIQs0QkFpLpudKxTc4AE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 15:38:30 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:38:30 +0000
Message-ID: <5da37621-279f-46ea-94e7-b766a6e601f3@oracle.com>
Date: Wed, 17 Dec 2025 21:08:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REPORT] Null pointer deref in net/core/dev.c on
 PowerPC
To: Eric Dumazet <edumazet@google.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
 <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
 <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
 <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
 <6d508d6a-6d4f-4b78-96e0-65e5dfe4e8f0@oracle.com>
 <CANn89iKjJ-P0YR-oGzEd+EvrFAQA=0LsjsYHUDpFNRHCDwXeWA@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CANn89iKjJ-P0YR-oGzEd+EvrFAQA=0LsjsYHUDpFNRHCDwXeWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dd7190-1125-4bce-d91d-08de3d825465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxvUHVWMFYzN0EvcGh0bnBxSlFEUmRFWmNDVVBUdExkT0t6Qkw4NkMrYXlN?=
 =?utf-8?B?T28rSlovSERZTGxDczBicmRFVjlCdjRma090SFVWbUluVHhTMllEb05HU0ND?=
 =?utf-8?B?T0l0eUdtNm91K0c4OGFET0ZhR1VXTmt3L1QwZTBpT3lLcEdpSW9hSTBWS3NE?=
 =?utf-8?B?MCtRT2UyMkFnTEQ0RldjT0Z0RExZVTBMckRId3NmYU5XQmtXMEtyQndnTVlr?=
 =?utf-8?B?cXhLRm94bGRER1U5dThkZEZJQTY0dzArN3dQU3NuTERrWWNxSk9Fd0ZDbEhH?=
 =?utf-8?B?MWlXaG9IbmlLemtDY1lZWFJ5VXJaNE0vL0IzTlAvakhoMlNvcjI0aUppVy9P?=
 =?utf-8?B?RHNxWUw4L0JxUGlxSzVRZkJtbXBmNDdjWVZ2S2ZKQzZ3dE1vYjFyUDBlc0xl?=
 =?utf-8?B?YythNlNmeVh5c0c1QldSRkVlZS9NaG5HRldITGFRcXpabTdoQ2FXcW1YQzM1?=
 =?utf-8?B?c2lGcGtobnRPVFA1VUk0Y2pQbnE4Z01JNTg0YWlmdDJEL2t6cWRkSjdOUkVW?=
 =?utf-8?B?NUh0aUgyUjQ4ZFlFeVBSa25HcHBFdEYvekN6Z21FWTNpcHJSSndkL0NCaHZN?=
 =?utf-8?B?aDdGY2RZWDVSM1RqdUVlOGlZYlNaRzNiVzRVdEI5eFRLOHZlQldDeEo3cDVE?=
 =?utf-8?B?RUl5a0NodXkvOTB3T21tQTJGeDhYbVJxbElhNFA0OVdnQmZJTHdwQjZMRDVV?=
 =?utf-8?B?aXhjU0hBMm1VOE5iTVdnTXhMdGxMSkRMMzFZM2JxMDViZUNZaVVxUVVHblB1?=
 =?utf-8?B?YUk5d2xXQUFBVm9GRnNlZFNQYUhZaXlCUlJEZlhkTmY4QWFkdEdkdFdiUGJW?=
 =?utf-8?B?ZWkrKzN0cG5iS05zNEExTTBXQWVlQVpxRDB6WktFWTdFNXRLYmJYZldNWXRF?=
 =?utf-8?B?T00zZERwM2wwcVFjY3RMdG1sMGxVQ2F6MXA2QUlUL3pzZVZNODkvRWo5dFFW?=
 =?utf-8?B?SllUUVc3b3JRYnY4N2ltc1F3VmV6MW52bzB1L2ZBTG1GZ0N2SnMyM3FUUHZX?=
 =?utf-8?B?ZUFhLy91emh1Nll6bGhDak5NeGROdzdNS2hKejQwOGRWMzBySWFnK0c0Mllp?=
 =?utf-8?B?WUVVNEVZTkR6czVJdDhkUlY0dld1NzZ2RU1yU0FmdklYQ2lwKytYa2JaUFNH?=
 =?utf-8?B?NVJ0TDQvK3lURnlyUGQ2M0NiNDlDbU9GSDBYYW1sbmJyRmZ3RnVZQlp5S00r?=
 =?utf-8?B?TlhibE8wa3ZpL1NYU0N1dUFBZEwxU3hoU3lsaGhma1p5cGJJMG9XcUNxdG1k?=
 =?utf-8?B?bGd4QkVEa2hmS2twZmNENWpwbDliQ2FUOWh0bU94ZUZIaVNGdGgyRE1odzRY?=
 =?utf-8?B?SVJzUCtiSUNiNjdlYzI2R0NoTFJKR3ZKMzJvNnJqSC8zcWF6V2kzb05ZMXBz?=
 =?utf-8?B?YWNFRDRLcE5vZThBZ0x0amMvdHBvMThmekNSOTBRYTlQbzYyeHVSWGRIMld6?=
 =?utf-8?B?cEt0TFlrOUdwYVRMMGozckVJT0RlRkNqcnNRUU9tK21jaHNUQm9RaWpzczhy?=
 =?utf-8?B?QkJWdC9VajV0cnViUjJLTmhtcUFxeVI2NUlUSmg3MlVsNWZJRFhFT3dwenNW?=
 =?utf-8?B?Z3pOSlVZL21jMWdSWU9qeHBONUhGYkM3eHo5WGxsZkZBRFVRVitabVVsWnVl?=
 =?utf-8?B?VjRteHRHOHE5aXJRTFRPam1kUUZXdWJoN1pEUy8zcVFBckhTak82RzB1dmJo?=
 =?utf-8?B?TjNVK0Z0N0VqQ0wvSVdneDF6eERMRFhiT3M2Uk4rbkNaT3V6WmZXNUQ4cEZl?=
 =?utf-8?B?M1RyVVlFK1FuNGtUTGZCZDBYbjFHNDI1YXcvZjVUK2lWMi9aL1ZYS2RrSVJ3?=
 =?utf-8?B?WGIyUWtUV2xIRGdPOUo2WVZGV3cxbmtNajdXRE43YU5TK0ZCVndDMFRCcmhw?=
 =?utf-8?B?bVJJbnJKY2tpVUFtSll4WGFNV2ZGS2pZelBteG5JeEplRUc1N016ekhaTm1t?=
 =?utf-8?Q?l6suOFdqcdtoUgxf3i7iNhsiQHktKuyW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L29tMi9PV3ROS3pnOVJXRmhqU0N6c3ByVGVFQVNDSkxPOVJSclhxRXh1TWZ0?=
 =?utf-8?B?Y2Nlb2VwNWIxb0ovczZnUy8zWUtmZSs1Z0srUDFDQkRyQy9jOVh3TlhPQXJS?=
 =?utf-8?B?Szc4QW1aeVVVNDErWEdoNDBhSWxtWUgrSEs3bDM0VkRPVjJWbEZWNUZsaFlq?=
 =?utf-8?B?QkNrZG5CRWJrN1ZtaHpTOGM4L05YS0xFVi9NQndWRFEzUmtJM1lvalFmb1Z3?=
 =?utf-8?B?aGJiUlEzK3dYUmk4dVp2d1k3RTVDVm5kUXlmTDd2TVR5TkxnZ09XUXFlVzlz?=
 =?utf-8?B?WS9wWjF1aGcxZW5zbnlrRDBrdXB2MWRlbEFhcENWYlp4K1JvNVVKTGs5RE04?=
 =?utf-8?B?Ni9qdjdyQmNuZktaM0o1Tnh5Yy8wQ3RFZjNyejFIc2kwZFJiNWgvckh2d2cy?=
 =?utf-8?B?Y1F4L0Z4WkpYQ0JFS0JURzFoNkk0d0Z4cVdYd3dOK3VyaHN2TW52bEgxblRw?=
 =?utf-8?B?MzBOc0pWR21pNDNNOUQ4Zm9MOStWZlRXaXVTVTNSWEFHMksrUk5JRFFqWWNR?=
 =?utf-8?B?OVlERlFzMUxpS1hrNTlPcVZMTWlZTzBpUWVCYklxZllwUkZPY2RoSXI0OGZH?=
 =?utf-8?B?QnZWWUliWTNaWWtCdC9wa05CZ2hhQXF2R3RQUGc3bE1GMFp0dzdZZ1k5dnNn?=
 =?utf-8?B?NUs1Q2N5c0RJMzg1aVJqNUhWR3lIUHh3NlFDSWw1VzUwalpBYU80M1NROS9Z?=
 =?utf-8?B?bi9iUko3UmcvcjBrekVNRjIyRGwzeFJaSzRybjlJdVlNQzhTTnRqQ3p6clU1?=
 =?utf-8?B?ODM1OEdYR1VNS3ZudHJnTlZTMlRBUHhTaEdvSzlGT3F1b2daSE4zQm1SMGk5?=
 =?utf-8?B?NmRDeHNPSWxldkRpVWNZR3ZjZ0VGZ21FV1FZU0srSjc3d3o4aXd2NUdtQnZv?=
 =?utf-8?B?NDVwWno1aDFHcW5YRkVIUWtJUkpxTW00VE9LSnlrSS84cTNFNmJ3aTFieFp5?=
 =?utf-8?B?aEE0SVRtZldQdmRTUzJKVnIyUTNkQzJ2RjMrRHlhRGVHYWJvUThFQ1FtQlZF?=
 =?utf-8?B?bFl0NVVhSW9xUWRjekUycDI0eWR0Z2hvQWJsVU9pcjU1UUhiZUc0dXp2Y0NY?=
 =?utf-8?B?dTZGUFRRYmhxTmNtWkRLMk1hc2Y0UGxTaE1JYW5MMVQyUkRyT2VyTDZpc01l?=
 =?utf-8?B?RDNRcmh1aEtQQkVkNFBhVXRmQzdMVDJWeis1aE1COE9zclREcHFHbURiZXBW?=
 =?utf-8?B?Y2RQNHh6MktJTm92Um9DODBUVmx6VWdqZzFOZXc3UzgzTzg3TnVxQ2hacEdp?=
 =?utf-8?B?K3lGODNTcnM0L21QN2ZDZDRPcy9sMi92cWI3aTU4aU5mOUxpUWNZaGhpUHpU?=
 =?utf-8?B?ZnQyZHYybHpHU2x2QWpBaG1jb3VvZHJDQjdmREV6ckd5c09ZNEZPaFZDTm9H?=
 =?utf-8?B?T3c3d21Ec1VEblNYbnNRVjZRQmNqYkhDRmg1ZHlWME9XZFhvdUtoem1hdVNk?=
 =?utf-8?B?NEVuVVMwTFlTcXMrc0VZTmdzL0Nlem5QZWpxVDYvdzl6azlpRFpUTFgxLzlw?=
 =?utf-8?B?S3dFek1vcmFpclBndmcrQTN6ZlZhZ2dUaC8vUDBWWTBJeEZMUFBQOWdObDk4?=
 =?utf-8?B?M0R2TzNIc0FRNlVENFFzdXBCeXB6V0FrYm9scFhyMnRnMm5NbE9SYWtxOUda?=
 =?utf-8?B?QmtOdW9Vb0tXUVhtSTZTWHRzUW9xODdOaXpCekFEdU9ObHlQczAwYjhHdHQ2?=
 =?utf-8?B?NzBIQXdsaEROMk9uZkx6MUpzVjZUazBKTFlDTlA3ekNGWjFONVZyQ3NUYVZD?=
 =?utf-8?B?YlZlWDNyNUJ3YTFGY29vVmdPU2M3clRuam1nOHdpVU1QS0lrY0l1ekFvVFFx?=
 =?utf-8?B?amtCTk1HWENHWnpUeVBQSXJFOHRCUjc2RisxTEQ5VVAwaXlOdGszVlF4TTJl?=
 =?utf-8?B?M3BLU2NRZlEvYnJYR2crVFRxZHNZbWVoNVhrRGx3eDhSaWhqZjNxMC9IOEw1?=
 =?utf-8?B?Z0FXNXZ6OEgvSnlQUUpZa1M3U2hJWUhxemxyaHNaN1BORGV5NHE4QkpEYkpm?=
 =?utf-8?B?MndGT3FNRXhBbGwzQnBPRmo5cjBjK3NEcGFtejIvc08ycytaWWZ4VnByY3Ex?=
 =?utf-8?B?T28zZkE4eHEzMnZOYUV1ZzM4OGpKd2ZFSkFsaTdGVDA3WWhYN1Z6QmRQK1lL?=
 =?utf-8?B?RGZraFYvQXFSZ1RCYlJ4NmJVNUpOQlA1OEV3MTREVzc5Um55TFg1TzByS2dB?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WfkaCAdL1U1dpYxo3m0SESMXXNkFMdO0TMjVyieufxVuoJ/Cfjvt2FS8bTBRc2Vd40MWN2ME3r8mvOPEpAPJIhc6Yc8GeOO+YvrtOSWKKA2KNnQSzkSW+y8xCFdoq/zrAZWEchVLVixHl6J/OhUCAxd6kFKpNi3ujy01HGCVLb6e5Zc7rwUW9zSd0ZGNNe0g3re61KXAul+lz5S7QYNWKq9z20hVZac33/8YgnI9bJ/HDDsvM08+HLubIC00fS1XBw4ZTcRLp0mA/8OQHVyq9c7WG7du1iKtHtRXUN2al0yzgI7qHu/BmYGTVS110yYfHBEINkft3cB+H10hnXHIzxD1geud04Y/kiZcj9Fjk2cgxj5lav9yHKITzqplkNkGJrYYzM/42+trOaTW+YG46WSSSJPlIZekTDgdW3aBoiVqsiqnSIaMfNX3e3n7MrgzHA14YUj5JxZ4b957v6tm3C484nqRBxjpPfzitCosyyrucmlEPRHa80tR/HRnzcjsqXYkfdrrLilplX0lMKXb9ifTPzS9ybTzE8CAi8YYKsBjxEeW4uoDI+RJglVlo18ZBzQGZ9azb3bofH2Czfa4OwTiMKyHVhVUr0lnwvauQJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dd7190-1125-4bce-d91d-08de3d825465
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:38:30.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfwaonHF2JUxdOXJ5OyJuKTni3WWky/nAMUbcKdGhcinXv1r8voeNma/YNJL3OM8JdiI0OFZbb7tS7v9wsWI919r7yEfEGMb2u/Twg9MwWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170122
X-Proofpoint-ORIG-GUID: 9Scu2wUzbSzkIh4WniV2XMQeDtsEX6mv
X-Proofpoint-GUID: 9Scu2wUzbSzkIh4WniV2XMQeDtsEX6mv
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=6942ce7b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jZjIeYec7x8TmS5EasMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfX+sDgdhEm1Yxw
 Yhmxer3BG6r3XUCnQvMZgaiazwp048aKo2GNmd+V86aiYx4qlAL3rNDTVEj+o6agshP2dUX08VP
 Kptj3dynJfNKm7rAHtHG9zB7gcHIVJ2HzeF1ugJoiTgY6lG9Awxmlrn6n6gSJ0lpsyfZhr5VXtS
 +nev7gQJfqOg8f1wnXuQHucbbHbLlRBpRPO/GS1tpbVHgfwmuIU/CI42ltZHyqK+DbZH4mdIiCz
 iUw/l+FSAH1MdEaR3p9zgeiRFqVElH9GiqxnySHzz4Xw/WWk+pNHLgjVdmWv8gJBQFDzLdl0hUn
 WwEUEx1gZ4B+qcTwAkK8gwQSHX7N3kWO5DEC6E5TvQHHasM7QdQnxdhMpbSeJmt3JMEhzIyXImL
 ajCm9IL4fip2zNG8pKsOH6rgL8kq6g==



On 12/17/2025 8:52 PM, Eric Dumazet wrote:
>>> I will send the following fix, thanks.
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 9094c0fb8c68..36dc5199037e 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buff
>>> *skb, struct Qdisc *q,
>>>                   int count = 0;
>>>
>>>                   llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
>>> -                       prefetch(next);
>>> -                       prefetch(&next->priority);
>>> -                       skb_mark_not_on_list(skb);
>>> +                       if (next) {
>>> +                               prefetch(next);
>>> +                               prefetch(&next->priority);
>>> +                               skb_mark_not_on_list(skb);
>>> +                       }
>>>                           rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
>>>                           count++;
>>>                   }
>>>
>> why not only ?
>> if (likely(next)) {
>>       prefetch(next);
>>       prefetch(&next->priority);
>> }
> Because we also can avoid clearing skb->next, we know it is already NULL.
> 
> Since we pay the price of a conditional, let's amortize its cost :/

Thanks a lot for the explanation, I understand the goal of amortizing 
the cost and avoiding unnecessary writes to skb->next.
Would it make sense to add if (likely(next)) around the prefetch?

Thanks,
Alok

