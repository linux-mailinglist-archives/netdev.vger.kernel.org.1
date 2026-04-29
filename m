Return-Path: <netdev+bounces-282147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA/rL0xL8Wn5fgEAu9opvQ
	(envelope-from <netdev+bounces-282147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417648DB2E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED40D3003343
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C4173;
	Wed, 29 Apr 2026 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="9lM05fuY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23C4A02;
	Wed, 29 Apr 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421129; cv=fail; b=AVsBAON7fS8mMtuQBQrGImKMkp0+xLtrF/+4qtvT6eN7yis8P45gDkY5va5zt6oDQoaCCVJFZqXO/ZQF9U9GLvazXGeTHb6Ye7qPrSHphWric6mZWhfwR7/ijhRJJZ+jMqrz7p6eWoclju/rHJqYWsZTgneZy0LK4uc64xTnHh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421129; c=relaxed/simple;
	bh=M1yXHtmS08NAItPK2uRZ0T6X9eMYUD0K9VUP9kYt2aM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5fG03ezLS9KFtKIWWDCkmF+0YIoF/inJr0bDkgzeVeSTV/1HSbU5wJVizsH1IfO/Dve8NjJxyIz/l2Wprmq4vr4kefqUR+d+c/ifJE9MYkgEGQb00pFJe9PIvf2/kKmr1yJ92b3B4z61sjeDGyhzhUcn/ommOlz53ucCZAXSrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=9lM05fuY; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1777421128; x=1808957128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1yXHtmS08NAItPK2uRZ0T6X9eMYUD0K9VUP9kYt2aM=;
  b=9lM05fuY+YBWIdOUFRH7wFaKSiYC5al2HPcqTGTm/OuJaE6Jd4IAyEi0
   Np9BrHvwmzornk90cC2suHrG7dQKYYqZ2PRrf9GfcltEmUihfVtbUHAnz
   lkZxdNCqmfH14oN2B4gh7BWyWifXUcqVWI6PmltGB7a73bhKO/Jk4E3m9
   8=;
X-CSE-ConnectionGUID: XK3L96MWQv6pBh6lfeZL6Q==
X-CSE-MsgGUID: G1eXcE2lSMG9MbNFfPW8Vw==
X-Talos-CUID: =?us-ascii?q?9a23=3A8zSo8mu/wTOVl76iZzK5Egjw6IsVUSb5nSn1HHa?=
 =?us-ascii?q?mV35DSOORR1Ki3P1dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A3gU0yAyfqyWJRmjrQ6tq7+r0g/CaqIv3BXAGvM8?=
 =?us-ascii?q?CgOyrZAl6HRmTtAvnfJByfw=3D=3D?=
Received: from mail-canadacentralazon11020106.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([52.101.189.106])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 20:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC0x0VYIbYmQ5PtNK2JMb+TLh0mwhvkrGBEtqubl0zdMRlDBPZX2Rh1hlOHvLXg/HVAAjx3/bcJALKJoezqK0cf/fU+p4HYRtA28pNyl79DRWzv2WLnkY07e7RNpHnbg6KywzKFMlfaZHHRdAuKO1JM/XNORqy1Ro/U9Ec8u8+eVGO/3VH2TVW/wnKsGQKk/3kiL6105Vmyh491ljWlFoFY1qEbslMnfaLZucfPf9Dwd9GTCN11noEc3nmZ/b2WibmpmEDxrgDfPIXxA64Pb3dKrLxYk4OsLR4cIGR9AiShYrxfl2iZjtW5D9vSWUGwNxiokyjgfRkhfDYyeiaeYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsmg4lK0FdrPtXpy7wT4Sw8F6pAnIxxSnssUSeO75eA=;
 b=vC9G5e/7GtVUtYh7jA7ELXdV5yWRlPae8A6Vc1xnn/VlNZKf9p6GGww/o/7WtcJWET80inU5nc+/7VOe9phxMXsl4T7/X/cYQoMMfdiNyGpSqmRmbyQGBR61ZI8Swab5TPw56jvJnVfJlaWKNNifl9++x6O/nWayW2CWYByXd+Riq99qhQACiU2llkFuURW83uNZhuakx0/nbEJ08SEzSMHsmLYYs2GXdFjJifuKCBQjLafOUMWSinC8uEyGWCKkN8AJocJwy6O4Zke5Fg3zEvbLSUhvvpuomK/JuoNs7VtAw6I+2z9ycaY9ScJWa8Jy87KgVDSoMzjeAKmSelK/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:70::22)
 by YQBPR0101MB8272.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.27; Wed, 29 Apr
 2026 00:04:17 +0000
Received: from YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4837:6b4a:2a3e:174f]) by YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4837:6b4a:2a3e:174f%4]) with mapi id 15.20.9846.026; Wed, 29 Apr 2026
 00:04:16 +0000
Message-ID: <4c45f423-ea41-4ae8-9cb0-7aca9157d8a4@uwaterloo.ca>
Date: Tue, 28 Apr 2026 20:04:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
To: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Joe Damato <joe@dama.to>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-3-dtatulea@nvidia.com>
 <20260428164004.1f6902ac@kernel.org>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20260428164004.1f6902ac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::8) To YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:70::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB6565:EE_|YQBPR0101MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d33211e-a84a-4891-a0e9-08dea582da69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c6A5jMN4Fx/MB3y7F72VQyWrczZzKQySYf1C5YCjQHXUBKexIqbTsDCasmaxC+y3PGMyEJQJ2kmqAmnGK9celi9WpFjz9+raSqDibdpb7Manz9eWC8JXsLLa24jFguLSGCnq9sMkuQ4pIXvB8p8QNlgJxTUyPKc22ziiKcxEjuYrAhjyuQWdEXOInm0gMcaGcd3W1XrGw0GBHBH3ExvmhQuYozWyZ2wUqCc4suQBZvBjhoIOvGWfNmBPo5xGMqkvfR4sKpIlbZSL6J8cQSQhFF/fu3MWDIDQngb+veNmhuNc6F0HIg+RqaHUznbjcssZt78nYpplcGyhBl//PWpW4W7D2crEkgSuJVgB0r6Kt+kQGc0I9cSDWEr3wEniAPcIrfj5ileO/f+3Bl1bOgU9JfXelDCMqQRiIApihF7yXp2SwpqXnxRquO80AGLDNag3GeHqIngIA5LMCXJCNnPNKkwvDI1Ez+nB6hbADBSDs/xP/G37TIy612jAk1bLs3YCrBeENOco/DusprSYs7nr7HfxXVOM+BL3QL/cXib751VFkoVfuxWNbOCm+A5kLAMthIO1OgKmNldUxKmEI0jBqfl6lkJ0sSLPs6XnpbFuWr5TDqITuSoT37MqQQFgL68T4X9BZ0b8U6hbBT/KVhJuXEqlLuDyTqhNuwIANirjOsjsbflDragQO0zXKRxkwFenZ87Xn6du0b0nS0VWddjmMXmsel3SJcp+6sVb829Xo4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9pRjgzelRzOVk3S2xKV1ZIdmxxWDB5V2NGMFpEcU9TL3RxOTIyR0RSZWdO?=
 =?utf-8?B?b05hdGpKdkZTSlRyS3o4VVgyQTZqbnJWeEo4UHVqNi92V0RLY1JzMStwYjFU?=
 =?utf-8?B?UzUxNTZtbnZURG93eWJIa05NdFVnTzdtWHkvUnptendmc08vdjJLU3BZbTBO?=
 =?utf-8?B?NFcwNjZPTGNWT3hsUUk4NlY5aTY0b1IwdDFnOGhJRDBqaHQ0aFRBaHhUbjd0?=
 =?utf-8?B?eGVZaWtpWFlSQXBvbHd2UW53TDNPUENadW1jaXkwYlBhVXZpWS9oTS9TUE4x?=
 =?utf-8?B?aURqTFBjRmhhQjlIWWJpY1B5RGQ3OTRPVGFTZGJHTjlDWmU0Rm5UcXZDcVds?=
 =?utf-8?B?cUxQNjNMSjNTNnVlOW9RaHUxQzRtdURCNzg2Z05GWnpleVFncUdFTGxaVnl3?=
 =?utf-8?B?YlJxSS9iV2IxWVRvVnUxc2s2YlQwMjFtZFdqWnBGVlAxZWxMVWREY044QU1Q?=
 =?utf-8?B?OWJvTlZxckRCSUo1cnBNcFFmYnFhSTZ6K0VGUUNuUVE1MkxSL3RmTmROMjFt?=
 =?utf-8?B?Uyt5VXF2cUNPcnU4ZE1vVDFkVWs3RUNBbEhIaWNIK0JmMFVnOWhzV2R4WFRy?=
 =?utf-8?B?UGEzL1l5R0xOOUtUdU5OcldXcGVNd0xaVjVJTFdBYTJpVjdiWlNEcVI3M3Bp?=
 =?utf-8?B?TXpFTlhTMng1bmhTK2pZNm4yRkMzNVpsdGlKSHljUGJqazBOSlVBcU1QWjQx?=
 =?utf-8?B?eTFMakUzckVPdk5yVmxQYlhxaEdvUUVMQk9iSldQTFF2NXlEK1RJMDlzTnlr?=
 =?utf-8?B?TGY5eWR2aXZNaC83UUlMblh4WEZkM0hBZUVXSUhPRExsK25HaytwNjRISXg4?=
 =?utf-8?B?am1GUjlNSjRreitJbTRSaXprU1JrckJMOHFzZkpnWjN1bDFRN1pXSFErZzU5?=
 =?utf-8?B?b0JlL29WaWtFWHNzMHpMSzRheWhjOW84VXZEV2tlM2s2cEZjQmdGdmxjRjhL?=
 =?utf-8?B?Lzg2M1hYSzJzS1NOREpMS1NIZ2ZzRHg1VHBMcVExVVdPTUN5T2QxYlFCb1da?=
 =?utf-8?B?ZXhhTnJRMENuQmI3RzIvL1E5Q1NxUDZJMEN3QVBJNWVzNTNzTWxEUmtIS2FW?=
 =?utf-8?B?YnowMGlhdlkzUjFkYkFOTkpqclFQZ3F5eE9HaGtkZFZrQkw0anFpelN5VDV5?=
 =?utf-8?B?akFjcHU0WlJqRGo4M000b3FBRXRxZndHaGZQMG5GMVlJOW9QQTRkN2JMZjRI?=
 =?utf-8?B?ZXplR0tlcUprUjJoZEUrZUZKQ0lVakJDTWRZcGZubDllUWFVRkE4Nlhhd1pF?=
 =?utf-8?B?N1R6b1VJRjNKSFp4WktJY0NEQkRoT2M4RkxoWHZUdG9aTlh4TXlPMVlqRk9Y?=
 =?utf-8?B?MU1ZRmh6UGhzUzkrVUZTSjMyQWk0SEVyejUrVW52L29yZmtvczkxSHhmQnBK?=
 =?utf-8?B?OHVBUWtNZ0oycU0zN0Frd1Y5M3VTb1NyeFU0cE1HcWphYzI2MmpiamxhUUhp?=
 =?utf-8?B?VE50akpsUHR5RnR2OFdsa3l4a0FvWG8zNjBQWWk1WFZIcXpBaTRxL3o5VDEy?=
 =?utf-8?B?K1p4ZWNTQ3JKbjRaQWdyd3JiTUN6WVFmcHB1RWpuVlV3ZzRkdWUxYzRyRXE4?=
 =?utf-8?B?eW94Y2d0a3g4VVZuMURYSG8wUC91elZDbUpRNndITkdnUTA5cldNZzJrdkgv?=
 =?utf-8?B?c2VkaHVhV2tzTHhmbWd0eCtXeXpORXJ2QjBJQmpCeTZ3YWsyZmxDVTNpSkl0?=
 =?utf-8?B?cnRxWHRrOUN6OGtZbFlWaGQzcW5yQzZqeDhtVkUzQUlwZEYvU1kvTGdqSjFC?=
 =?utf-8?B?TTJ1NFdveDBqcnByTDN4ZndLRHJ0TXNLK0JNYkx1cjIzTHZRZ05pWVN5Y1J0?=
 =?utf-8?B?VFBwdzNOaDN0UEtpcWp4Z2FMMEsrRU95ZVhsanY4ZGU1alIvNlJlZld0V2cr?=
 =?utf-8?B?NUVab2xneHpmbFh6MWIvUmx2enRSb3dHQk9vVTBXVjAwTGkrdGNHVURMWjZO?=
 =?utf-8?B?TVlGdmxmeEFFdTlrQmFjZmRkb09qaVNoakk3Skh6aC9wM0ZhbmgvT2YzajFE?=
 =?utf-8?B?OXVVTVRDMWFaU0dOUGNEYkZhRHVqTjVCRWZwZ3JwWllBQm1SWWpWdHFVbnpo?=
 =?utf-8?B?U3BTL0YvbkUyZ2xaUEZXWU1qWERBVlkyRkFKSDREL0xGa3RXSGNnbGhPaHNr?=
 =?utf-8?B?SEtNNU5TeERUTFVTRTkxOW9icVZZbDlkS2RTUXlBSHUvK3BPVGcvelk3RFdy?=
 =?utf-8?B?VjY5ZkFnRjFXZVJPQ3RtQzYvTllqTC9McjM2TmIwQ2ozOGNORTJnNVY4ZUNr?=
 =?utf-8?B?NEJQRCtPL3pzRGxFUEliNEEvcjF2em9sMktac2xIbUJZdVFaSU95WlVPdkly?=
 =?utf-8?B?UkxtODV0Z1NpQm1OMExCQ2NWYXpoRGQ5QXlucjFwbHNxRlo2aUl4UT09?=
X-Exchange-RoutingPolicyChecked:
	M3Y1k5eFY9NLsjpoTy9U4udajb3BKKcBTD+UPFQGJXKZas98iWQQ4GejjPEBghVrCFJ7Xn37lQ/jZ5WLnGjrDxN7L8KIRVdMW5iXNM0EgR9ec7VXa5FJQQyt0fUddmRMSh7C3B4+BRm+pe7j092XVKAlJeNg5lU/UwKvSy0Dg+UoWP3Gbh/AXUKCtZzzNnvr7fM9w2Qn1HMQywFSY3li2xhPWqK73TGEL2e34mWUK7KHPGl6kdbvNwpIyZqLAuLd3+QYZb3lVn+P5lhJzPo9mgDInrsDjom11c+f65QSFqHJiUjCBnOA7W4/nGrWxYJAOchWWY+JncFg4J0/7afVcQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k2knm2tD9V/B52tsNSAvof3k2OpYSIyU3i8m9Zz4pkfebxaEoxIDytUPll6NqCypF39+oDu2yMm6aXmhR+zoqn6MuwPH5FdB7EXbfqmzJZ7oUUT2IIenbdW63K1huiNJOC43y0yspnfowbBuIxAqAKkxlnbOZipDx+goaToyUDvUR5NT6XOPkWby+6REfLMZDvwpgVCMuPcqQddIqpAZNjplvXIspUzK45fW2+EUrrE2ud6PczVcKW8ngBWfFyOY3z+y7oeMdDDL8ZbN9n7bolMKacU6+YV1izPyl7cceUbEx5LUfEMBsDxS3i5LDTnkjMLC++93eg13hs9OzRebYgZ4xdb4PRsjZa0HuOKlxN8OGWFoYvAyyc/nYV97EHO1XqJrA8j8QI+XPj9Vg7qLi6tEAKkWlOBy+7y7NG9C+3FOGL53TFF2wjl6l6F1KGxV6QAbYONnefZmV7rpLJqSlBNMR21827A2gDxNrGaxazI9WM5RfKfr80dh3cKipWCoBAscGPswqLf1PhnZCK376VdNmpkJCliZx+m3MdPZ5UAbU2GccPALvx3wVfnyZkCBMG2vVSglSeXmlRXgUPabxTWM1AeYP87Pg5QCSid5iYWx/RHTBCf9b/RgA40veiTs
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d33211e-a84a-4891-a0e9-08dea582da69
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6565.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 00:04:16.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqXlE4SKkhJMcQvECeAbB0hvXvWeXkB5SP2ToDbihetNfnTnTHeOiRq5hjCthQZobMJMRhLzomFPbrOk11qNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8272
X-Rspamd-Queue-Id: 1417648DB2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282147-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 2026-04-28 19:40, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
>> Under certain conditions a queue can be left out with interrupts
>> disabled and with the napi re-scheduling timer permanently stopped.
>> This behaviour is triggered by the napi busy poll path when
>> gro-flush-timeout and defer-hard-irq are set. Here's a sequence of
>> operations:
>>
>> 1. Busy poll starts, NAPI_STATE_SCHED is set to avoid rescheduling napi
>> from the timer.
>>
>> 2. During napi poll, driver disables interrupts due to being in poll
>> mode (napi_complete_done() returns false because napi->state has
>> NAPIF_STATE_IN_BUSY_POLL set).
> 
> Why does the driver have IRQs disabled in busy poll?

The problems occurs in irq deferral mode when both gro-flush-timeout and 
defer-hard-irqs are nonzero and NIC interrupts are disabled.

>> 3. At the end of the busy poll (busy_poll_stop()):
>>    3.1 napi timer is scheduled and skip_schedule is set (due to config)
>>    3.2 napi->poll() is called:
>>      - driver poll() processes exactly budget packets
>>        and exits early => napi not scheduled.
>>        (interrupts are still disabled at this point)
>>    3.3 Since napi poll processed budget packets, __busy_poll_stop()
>>      is called with skip_schedule set => napi is not scheduled here
>>      either.
> 
> with skip_schedule it calls:
> 
> 	clear_bit(NAPI_STATE_SCHED, &napi->state);
> 
>> 4. If the napi timer from 3.1 gets to be triggered due to slow napi poll
>> or some other reason, the timer will run with no effect (due to
>> NAPI_STATE_SCHED being set).
> 
> And here you claim STATE_SCHED is still set?

Labelling this with number 4. might be misleading, sorry! The concern is 
that a short enough timer (compared to the duration of the driver poll) 
can be triggered before the NAPI_STATE_SCHED bit is cleared at the end 
of Step 3.3.

Thanks,
Martin


