Return-Path: <netdev+bounces-261381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEfMEMhVoGlLiQQAu9opvQ
	(envelope-from <netdev+bounces-261381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:16:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13531A7570
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C74DE305A4BA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB23ACF07;
	Thu, 26 Feb 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ay7wu46r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R0sV5nLO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD943ACEE9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115323; cv=fail; b=jtslqweELdSe5CoUyuuDXKJ5Fthrr6uRkQxZ/FWaSt7EQ3iinhvNz7axGxXmaT2l3RDXclp1oOPY+QmOOa7lk9FC17khwG/6yq6IVmwRckF5hF9st68PdBTN2jJ/qAL0LYgLbH+Sy2pj/cfJZgGn8gypsF5SyyZXrncv2MUp3TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115323; c=relaxed/simple;
	bh=DzvZSgfCNS2xgTYRqPy1gUHeW7pvRAfql5CJAyDLHAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z26RH6IBN9LUrGhbNvdXgO/lNJd4pWJ/57kThUreTvHXxUy3sI7ZeS6wvM97jZJtyk3mOqjria5xq+n2HFeOw5Hze4vjdZkhslW3NKeeqVGBHsReD40DrWQvla9+cqCh/5/4Hep4vWr1TUgGWIkx3jmAYDLZG4RHrH7ArsCwADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ay7wu46r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R0sV5nLO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNA7E669799;
	Thu, 26 Feb 2026 14:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qUBoEfMNh35kuu+MUm5B5XEN9s3ezCfuFAacuUL+uNo=; b=
	Ay7wu46rD+J7LbSY22xNCy2T3DWt4+hHFBprPHeOmuuT+35Z2OjMVKM1qaFdz4wN
	h+aRn2R1UJcVqV+dOJZKCgmB5UiIaRexMbHkDOJTU73HvC9d8imaBy8EqAVmu/HA
	EEv1pTSx7bEBMUR1KbRaOipZxd72BFYFV8x8JU8Ylmn8Wj4rxrkVYlpzlbwkdB81
	g+57Rdb/AEQY3TbVk+8lZrfKrL0UsB5LnpCq1/PGy1c6OZTo2hor/MaYVrGEUPT8
	c6QENYG6815oCPQif1RW5ewv66JtEDj5UpxyB3EYAZ2ACGCh+ZCPuThKQgJrxmiJ
	4Xsd6P10wH97eVb12ADabw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m80a2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 14:15:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QDqhik012522;
	Thu, 26 Feb 2026 14:15:03 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35gsr76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 14:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe4xa4JLwBdNotzJYf7fqH7M9FJRyhyeH7rb6WOzfhxdR/BoxJre4Zqr49v543NiMiIHfU5htY2KG7MKYyp/1MU64mVhBctKOlE156pxJ0AcB59zwGrz55sXGCotl+w3jDxyO4kxb6e5irTI5WdRqTu1NW7UHxAHU21WLEa2/+INoXpbIOVJV8tuNDVEQKn0Se1DmWtdXZ2Tq6Tw5/ul4Bq+OdWxEXHODrcO9K0b3x5KCKrQFdYPbnfjXUc0WOLFMcCpJjn/IluAbPNX54QPb7joLftF6Cfpqquy4DSzYujAIM9tsv1DioXLAttwdzXxcc5WQfzhXDyGq1OdeI1s5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUBoEfMNh35kuu+MUm5B5XEN9s3ezCfuFAacuUL+uNo=;
 b=bDL6WwTMEtn+zH1PnypOT02tdNhmcrX1MrM9rZAwsMANXOLf7W+lCew33LBrkVgADeHNdcVae6w9EsoqdBcUZGg89DFg/tc6NBVgRQwbgWf40ptjoZAX5FWKrdwG2yTiCTOiSbaYqeKqtRHBgxcU2FcCTeIjT1ev5Naxo2RHBGCCYg/oj/EaK87pRkbBffXSX2l6hWL526awDqvhgPgsv9d708qZw6luI3Iw94tYxKWQyRO1LiA8ujD0idfj9TjGbQj2EJraQM7CDst539YEVtz4JlnUipWANdwOnAFV8/NJUlSxMfbbQCRNusWiHVhgAf4ZEYNO/kIMK/v6v/gskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUBoEfMNh35kuu+MUm5B5XEN9s3ezCfuFAacuUL+uNo=;
 b=R0sV5nLOgfCPsvMlZ64xw36Xev5jtNV8hxzdFA+zAeO1eVj7pvyPu4EReJRcxetn8OviptXFS0izr2yfO1C5GAk6C3X4FRM5cYoLu/vzPQAsdfiyA0EmVZIJncx7g68slegucvDQY4C5GevItwSr6DVfxNr/04C6isp9TV452BY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 14:14:59 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 14:14:59 +0000
Message-ID: <d824c0b3-32cf-4c56-9999-82e1014a810f@oracle.com>
Date: Thu, 26 Feb 2026 19:44:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ntb_netdev: Fix NULL check ordering in TX
 handler
To: Jakub Kicinski <kuba@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
        andrew+netdev@lunn.ch, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, ntb@lists.linux.dev, netdev@vger.kernel.org,
        alok.a.tiwarilinux@gmail.com
References: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
 <20260225192211.7a8e1be8@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260225192211.7a8e1be8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: f55c0adc-30e3-4d0a-392f-08de75416ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	S0F484t+iHQTZ+JuQLsAduDWTjdSN7nAR3FEemgnGd27xvoTN0T23lHs+a1HVSfdcLWpAvH5t4aSioEayXL/q9u3gDoLtwDhJ7rqi2kpshEDsMN+tbCU3pobYEsjqyqaAmKYKAuZ7WG1S/WlnhG1d4MHQhUpVOMAzuUAuDo7bVVkMt7gO7JxcrmfI6O7vca8LOCS/tNKdK9mBzp6/zbIpS/BEKflZefTNqn4eQ4whhHoWNHkGXGuF4Vj7parLJh/FSRZLjpTO6eGG1/pxc5qdJ+k3k0fXKV2jahHu+2urnHc4Wk4se4rd+AgoL24PSO4NmRMHBmNU2YvlVP/9ur0DonJn8PLo4xjAYeWe3tQVJq7k544iyZ6b9xeNI/mCfjpP4iKKvEjQxQv5B56fRPdTqnuaYWH7LlO4TNwYOmlRwiv3/7kHU9EAYDShohrUjcFnfJgB4mG0jrDmkaQkUN9oXCom5ouKE+gxhURpPBXcQ8grWjM7CRt96GoedYDoJez1Gw1D2xnMe9+glbFGlXY62vYkC6tUlYshQc6SVWC2ZFWqKNmZzckNofhPfFJwfdyJjS+SCZUz1e2+WeIN3/KcWfumEvq9vwnvrOAA9p+3F3ofrWB3Fiz8DR1Cq2CX3bUjrTQyE9xPNDXMjp3kiOWsNqnpaU3o9BbR3yHmVgeMbvCUCsfFw0yNKVn4jM23kgu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emplMHZYYklRMEE0SmxQOGtuSEdKLzI0U1AvUGRyQ3YxVGRCQlpCblJvQ2VL?=
 =?utf-8?B?NHIzeU9hSFBxMFY5ajNwZjBFN1I4NjFPMnVOazJCYXg3WjlSVUFsdnBBaGl6?=
 =?utf-8?B?WnVMQ3I3RHRuZDl6MFh2OFdQUzArUVpYNjB1S0IrNjRxS2doeGNubUtIbkJo?=
 =?utf-8?B?dHdqNk1UYzE1cjVIQzhwV25haU91OXdMK0ZtaW1ETnYwUmNHc01IK2lzQmlC?=
 =?utf-8?B?NDliYkd6L2JVaHZ3UVhwV0dINVAxU0RqZWFWaHZkbGZPSFYxQVc2YlpNNWh6?=
 =?utf-8?B?L1JxSjl6aTNoY3lKaURteFJSUURTQlo0NlpuTDR3Y3Z2dGo5dUxvNU1xQ3Jz?=
 =?utf-8?B?bFlJMnlUWmpqaDZ6N3A0bVJLa1BNUWZaNHJpYWVMVWpXMzZudXcvbHpwYXdF?=
 =?utf-8?B?aXZTZGovVW1LblcrdjRwaEtyNHdkWC93OUordXZmOTc2ZDI5RUhyQU4xVm5i?=
 =?utf-8?B?d04zWkVvcU9qMXRZOWtDVk5NK1p1TGdxOHdLZ3A4cmp4aVBQN3ZkWG8xY2xq?=
 =?utf-8?B?OTFoemRnZm5QTmR3SkZkbm9kMi9YSDRTOU03WCt4elgrUmNQSUwzRUxjeGdO?=
 =?utf-8?B?bUllOGpVODJzZUdxZ25Ma2d0bWxWdlFDd05KcXd6NXQ4R0JOR2JtK0FMZ24y?=
 =?utf-8?B?UXk5Y3NoclI4WmtxZ2EyMURncEVVL3NWY0F6VzIzVms3UXBueTI1YXY2SlBn?=
 =?utf-8?B?b0dCejN0eTc3SnpqZ0JLekVrSm9wQ0FmeW9pL2toakhtcEJCOFJuOUZiZW4z?=
 =?utf-8?B?VUpDUmwzLy9yRDZ4VFhDdDd3UkJmNkVFSjVIa2F0eVFaVzhSdklDWDV1VHRh?=
 =?utf-8?B?N3hjVVlEVHk5RDhtTUpYbHVtWGE3VmtaVEZlRU9EUHliZDc2RHlodGRHa0dK?=
 =?utf-8?B?YUZXc2UrS1o3Wm5ZSWRiU01hYzljSWRrU01pU1JtdlZpaE1hK2FZb092UFNr?=
 =?utf-8?B?VCtkWnppV3FOMzJRTmJMQlJkZHh5Y2Y0cUxFeUQ1SnBhU2VWVmU2OUxBdmhB?=
 =?utf-8?B?ZjdDaEwyTUtBU0VoZXB6WTVUWEZNSDF6bDEycVlZb1lSNHJ5VjkxMmhHWDlZ?=
 =?utf-8?B?a2dmUThteC9xWGVEVEkxREV4MkFJRCt3N1N3Tk1peDdueFMzZmxFM3djOXY2?=
 =?utf-8?B?blIwNXZ0ajFGTmxzK0ZVMDBKZHVWai9TdGNxSlRVa3dKTCtiaWhtNFMzNHk4?=
 =?utf-8?B?bmZrUHdqU04wSUY3RTdVNFRsUzlXOWRkbVVSWWhFTjZkYXAvYjUyK2hDOTJK?=
 =?utf-8?B?Z0ExdnYrSnhELzhGUG1EbHBzQUZ4dkNWbkhFQnlFd1dTcng4OWtDMmhzWklt?=
 =?utf-8?B?WlVaUng4a3BBdm44N1REaGtybklYUWcxNHQ2bGNCMDZuM242YVR5QTUzQVc3?=
 =?utf-8?B?UFhCOHBlWFlmYWROWEFJaFhmYW1ZbGpWb3VjOWIrMjlVWFhwT2Z3SVFCcm0w?=
 =?utf-8?B?R3pkc0FrTk9hQTBRNU5IaHNBMXRrTE5idmYzcGgrOXhFYnN6YnVCcForbDBa?=
 =?utf-8?B?MXA3VE9MK0hSQUdSWjlGNzVmTitmWXlVelV5OTNGUklpWEdpWTJ1ZTBUV3k3?=
 =?utf-8?B?L1p3V09oeFRZcVl3dmZTMXFPdjcxSkJLM3h5dVdTbStDT1JtYklhMTQ3Z1hZ?=
 =?utf-8?B?Q01LUzJNd1ZmQ3ZQcDgvNTVIOWhIWW1HbGFYUFp4Y3VQME9VTll3WjUyVVZr?=
 =?utf-8?B?V0lpWThDaThvOURFZlFVSnJHVHZlUzdEaVZUMXlTVkdTVWlWcVB4R3FLM05x?=
 =?utf-8?B?WlF0RlFUU2NKejd6bmUvLzJyZm1CbWxVZTdzMWN5V2NsYjMxUXdOTVdMKyti?=
 =?utf-8?B?L016NDdtamhHZVRTT1ltUEpXVWcyVE9xSStlQ1plaGUwWUNvOHpWUDVqSFd6?=
 =?utf-8?B?eVNvaU1hcjJwZGdEUGozQmM0WHN3STJsT0NQK0t0RW1rcFJJbHVmWkZuQlhs?=
 =?utf-8?B?Qlo1TmIxZzJIYmJGb0hCWFlTZ3hxQS9tWlRnYWd2cW5MVDNsRGlIYWVLcGNT?=
 =?utf-8?B?N3F6T3VJcDBjekVXN2lodDA2cmFmL21aSisyc3pGNGtQS1dFNUJRaUhGSEd6?=
 =?utf-8?B?bklmL09XTUoycXhSTVRCUWJKZWUyeTMxcng3N21LMVBnOXZlblB5bEsySjEy?=
 =?utf-8?B?dXN3Q3lpL1NVbk5kN212NnF3OXdLcjhVQzA2S3lFbGl1d2FiYXJndHhSa21U?=
 =?utf-8?B?cnh1ZXVhc0pmZ3hYSWUrenRmbnR2bXhWRFRPUzZldTVoUVFCNGZCNzhnN2li?=
 =?utf-8?B?Szd0Z0phMHZBUXkvdmZMWmc1T3dZdk9GME5iRkFZNTJWYkk0T0hPRXFka3Nm?=
 =?utf-8?B?RCtVVU5hMVoxNm9ra0JHUkJLL00ycldrSjBoQW9uVDRkSXl6dUp3dzlnREpQ?=
 =?utf-8?Q?zkNYc9X5yi8EmprI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RmlSeHkBzjm38KmYpqwkX6ohKGLzq5w5faWdtf52qQZzMFld9eokipGpR07StR0pdGzJYEi7ixU/9y0RnfUCVkl64YsHw1jvuaqRVCTjv2IMDveACRdOiBH6COo9iE0OqJtAL7h1DmYdJDa9aRPg0c522ccgT5AdvxT+VhWwI7GddLvNg+4i7nl5Vq7TgknyYuv1zMysy0ZrTEuO9nF57LLhaaq9L+0/yXQm7nwQ49qKzXAX5JgqdIVU/lMWY44L0nO5awmSOICEMxT32DRvQRvqYdaPNVRxapT2xQVIYvpSrTL9tM64YInMRSXLT3MOLQhi+5mwz0cJttc8jFAueiR1QBlrSvuKMYUEh+7ff4JfPKyAmWyvoYTU6gmuuq9b6zyrYUGI152R8qVlhBKWvsaIszptlole1xWPmpDN8+B4VJj/M9ZJhqmWh9RO/VxGzEaLR2kgWmkNBjRpB5IdVst6Lm6fK9iTlUABhbcwb0b8aRRm3Cnu1yj1+G+3VItWoihVGcZvt9Pfx1guRdTIwXL0uXiomKBASagaUvAZ+YHWFALJAyFW1ag74OujAKCJOXDGAr2ISyhzKyIU9nDlh6fUUj3ujJ93xNfOsOXapcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55c0adc-30e3-4d0a-392f-08de75416ca3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:14:59.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMjD++wFDBXb8hHuLutdbnuo4+lTLd58EwuP+zvUS3ITCo2Nuh0OupNzCHaCLZQ/pj06tI5qrSJyJoI5u1xBe47I/N8SABLcJVlqyEwnmnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602260128
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a05568 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=ytRBNnUUJJjLX2u3_DUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf
 awl=host:13810
X-Proofpoint-GUID: S9MwZHqJlb0t1O7Z-Va-89BSOiQxVe5T
X-Proofpoint-ORIG-GUID: S9MwZHqJlb0t1O7Z-Va-89BSOiQxVe5T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyOCBTYWx0ZWRfX5h9mriKpOeBa
 JELvkRgBGf2CG7dgQ7SydSHEwvctfgoyPfOAu4nUqZUDXrquRbSZ0Vgw3l8bxV4VMELYuO1lLpL
 0lejH/nvi+ZAygDxlUHqCVhiMRpGu6ppPH4iu2rp+17Vb6XDGblf2vNO+/Z7ho7MXYoUWP1EHpC
 +VyjxrGdAHmEwWsag6Dq7vhW3IeIYbQA1fyX8tm/A46HCKJiGdNPm+CZXc5J7xL841i75NaEr4Z
 OM85q12kjGM8sIoHYEnhleQRFoKrd/Oa92jUuz9JgnJMyieg9DNL4zcUJe5+LPrh4fHdyJiVOL7
 zHLr3nNSNgaZCZipHEOphiFkXiL07osM9U4GENgNsmP13HZNXjR0QgPPQNXfHME+ZHeccYu43d6
 SQfZD0K7rwxGero7RouiUsL44Av/+TGQKKOLAUHQZSG1kwiKhsyFwrkHwxLsUOoWJtbVNXgjVd7
 jiQYvKv1xXw4bJlBdXBaA1syavj1KazLPrMhwZNI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261381-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,google.com,davemloft.net,lunn.ch,kudzu.us,intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A13531A7570
X-Rspamd-Action: no action



On 2/26/2026 8:52 AM, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 05:04:47 -0800 Alok Tiwari wrote:
>> ntb_netdev_tx_handler() calls netdev_priv(ndev) before checking
>> whether ndev is NULL. Although qp_data is expected to always be
>> valid in normal operation,
> Right. Can we delete the seemingly pointless null check instead?
> Defensive programming is discouraged in the kernel..
> 
>> dereferencing the pointer before the
>> NULL check is logically incorrect.
> If you strongly prefer to keep the patch as is maybe say "valid
> but surprising" rather than "logically incorrect"

Thanks Jakub, it seems these changes have now been superseded by 
Koichiro's patch series.

> 
>> Move netdev_priv() after validating ndev.
>>
>> No functional change intended.
> -- pw-bot: cr


https://lore.kernel.org/all/u6k7xyjkqdn5xsgderrxi5yw6mhwtl3srfeefagp44jco7jc44@c7f4tzlaem2l/


Thanks,
Alok

