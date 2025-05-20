Return-Path: <netdev+bounces-191886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B070AABD98F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFDA7AC636
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06742242D70;
	Tue, 20 May 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sOD8L20y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qKVrCPsz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0E2417F8;
	Tue, 20 May 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748096; cv=fail; b=LCY8YFGsIvyhoNofzw7VYAtaFVddItix6uNdGUlJGXvTnkRYGbVT925/jPtRpHLDsofntW6/xHJm2b03CTHp6lXe+ZYheab2/h1eNzWBs+/v/e8vkUqgRuMQGugSl4tALc9hl4vTU4PSuTNrBJIWaj6/xRRls3QsFuBDv2tbYu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748096; c=relaxed/simple;
	bh=M6WcbTLZ2zi4kC9ns72BkE1te8TPgcy+NGqMU2zL+3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxjQqhYDpu3s6wyj2szclv4i1hg+LQq1zVcMzYqde8zpPVzbk4u+YtbNyACFMR673jS7NOdBXSjAeGQXcEJlloxySIXvIK367tIogtvdwx0qBlBELGCDVnlosJO0GGzI08t6SUnfohLxC+dhjPtpTdUrUyxPm/3KplW6DTbE2UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sOD8L20y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qKVrCPsz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCtsPr028687;
	Tue, 20 May 2025 13:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dDsDGcT8+MUwUUvtwi5zZDo+ywvE2fTB1SN6+4vWMOQ=; b=
	sOD8L20y2QB8W2/VTTs0qF4coFelKhVMhvIOLzD5sfgvGFBYO+/wkq8LMOCDwPub
	i1ikT0Rq15Bf5jGl8vejrT8/4DtwQAiB5uD3uYSYt+ddEzxEdh4SpHLSb2dveDB7
	JMKJHmiNFDtA96HfjCm+3KiR9I/b0LxNq7Vrmfia1TfQy4LA7TvWsU0EmkPYcaVf
	W1JgarsGDZxMxHixfhR+2FXfqNKUGV5XpIjTkWyxIMldxHZ17wK262raFwHiy/lR
	Pnvu58cNGRLA7tAKL9nNlslXY1CQf93SLCwR8wIF9jY2pMf3GbTl0/s7Z0tfIx3i
	QDVspL077dG+q+njVeFvVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge5gbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:34:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCiGqO029257;
	Tue, 20 May 2025 13:34:01 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw80bum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxMKE1J2cSlx7+hgDrhjoPd4ZI6WrVCRo7QlYmJ1ACBgh4NdPcE69cPPVtk6JO29j/3FN4hUTmzRP9EhJZ83AYbgdPHleK24Eiuhz9yCLWMOKP3UK4ubTa0M10IKJf2Dr+kbVSMeqYuTTGjHRfPmj0GTeh0Ztzu4sMWQIDJxKbdB8spqjzBvijGa8tOUzZzPdwDCkf3Lj5wLKfbiaYlhwpJKegiyRmMH2BwnXYfPgJkkOnzyBKnSDWPqZ2KaSExBGWdUfT2BQt01pyerazvGcKoW1HiR7LU3rLpGGxmmCljDgO8FNfM1Yz0rcfzyxcOluyQMdftrsKo1ZcM7aQbyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDsDGcT8+MUwUUvtwi5zZDo+ywvE2fTB1SN6+4vWMOQ=;
 b=U0YtGlq780/Fvqj1oUPIoh2I4r2kBe4ull13sgGB+uA32a/Si2f5kigrwrUS/lEu6insxzXWbCIssNleWT43wT5S8rvHkIfL320vh57Au3QwUTMQWfrC6e/fNFdwwQ4JJZ6av9Pm6NH6Gwcwcy8foVSVB9qXodGZr8OjpRoUYE/+Bxug6BgIJuTZshpguF2nLNTrwGxh4ZAMYwAiQENvwSdboAYfiBg0I/UM1rwU1GOBkS1QaYVFmKvfoCq2kJj//7HZieOujRBhhr+SMOBkGojHiAex48tTfdPRSlWvNuYaj4+L0R0rAvfn6mObGGQ7oxyHWjrpQWIDUJ4cBxdKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsDGcT8+MUwUUvtwi5zZDo+ywvE2fTB1SN6+4vWMOQ=;
 b=qKVrCPsznOL01cVNu8Id32gp7UbY8GVpEUPu9xd7PB/U00xUWEHW5U3wLc26Xo6fFEeZPR24vR+ujAtRPuYnbWEeZXqfOnJ4CrgH+pN7gz5ai9Xxlm+1VHR/OmKIhoQakDBkHMsmtRTmtTg9LgMxZ+n5BUsotl8yktD6BzJZjBY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH3PR10MB7564.namprd10.prod.outlook.com (2603:10b6:610:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 13:33:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Tue, 20 May 2025
 13:33:58 +0000
Message-ID: <53e692f9-296c-4f4b-8593-058fa6cfaa13@oracle.com>
Date: Tue, 20 May 2025 19:03:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: phy: add driver for MaxLinear MxL86110
 PHY
To: stefano.radaelli21@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
References: <20250520124521.440639-1-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250520124521.440639-1-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH3PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ba0d78-2bca-46a5-3dec-08dd97a2f97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFAvVTVOZjBBeGRrUjhsYWlBZDBvZHlGQXIzYVRGakNWRWphREFtNmtidmJW?=
 =?utf-8?B?WDFJSHBic0Z2VUoyMWw5YnZON2oxamlwZXdnNEViTGcwUkdEWTlMbURlMkNF?=
 =?utf-8?B?RWhzMzR6V0V1K3ozSUZXQlQvWml3WGphSTNwbkJtWTN1YUJIRURKNmJaS0hh?=
 =?utf-8?B?bGcxd2E5WEdpeEloclJzb3NOb2NUb20zK3pHRHUzVlUxSGVySHdaRmFRME1u?=
 =?utf-8?B?VkVQV3JhSGgrRHJidm5PQ0EwMmZmUUNHOStpcVhvc0VZcVh6TFk3UWF6Nmhw?=
 =?utf-8?B?MTkvSHB1NDY0T2ZZSm11ckszQ1g3NWUvV2pEc1BoSGRyTnJ2V0l6eFdGWklP?=
 =?utf-8?B?bUxvbFVBd3V6WnNWRFREaW5lNHJscHhUeW1STEFSMzR6ZWJJeWN3YlFueU01?=
 =?utf-8?B?UEY0ek5SeGlCaFFRclVpaWFtNzRWWWM4Vkg2aFdlWWgxYnNmamwxNkY4OGJU?=
 =?utf-8?B?YlJOakVMcm8rZGtvcjA2dUVkQjRScU9QSGRzSlJtbUprSjFJdnNXbDZBWnho?=
 =?utf-8?B?WmhNei9UR2gyM3VWalVhS2hrakw2NWRaUlFvUXlMUkJaQXd1aG5yYm90QXlK?=
 =?utf-8?B?WnRSMGxDSzN5V3FyK21KV1AxYlc2b3UyOGJJbytWNFRyTVBUWFRnTzh0OW9S?=
 =?utf-8?B?TWtXaklLOWsraHBwYzNMRzR3cUVkcW1sNUtidTdsZUZNcVR1ZWFpTDl0UVAw?=
 =?utf-8?B?OERHeHdzbXpaM0tXMldaUjhlTklGalNsS3Y5ZUpDREpBaVRmVmdSa1RmQVR3?=
 =?utf-8?B?RzNqYkVPa3EzV1Y4UXNWenVSSlZDTERNY3RYZVpGZHpXdkVoYkRvVStLR2ty?=
 =?utf-8?B?ZnlJaFNCL29laHc3eXU0NTdJWGtYblBSOFpkY2kxUXVVcVVTcmorOVRGaDNH?=
 =?utf-8?B?MnhoMElKdTB4Wko4WE1aMlA1K2NDT1ZKdTZNN3hRdHMyb0ZIanZoZVUvZVo3?=
 =?utf-8?B?MGlwWldlN3hxcTNzZHZjN1lzVURuV0RzZVdqWkZmZnc0OVpBV241bmRpWFE0?=
 =?utf-8?B?QWpBYWpkYVh3ZE9wak9paTYzbTJHRitpVmF2UHFJdWNNbG5kbHZWd1JJUzVn?=
 =?utf-8?B?VE9NWEZJRjV5amQ2YUE0cXpSODdXa2JxTXp5NTcwOXYwaFVjelI2eFBPYitw?=
 =?utf-8?B?QXpXTWtxa0FHcXl0Mmk1UGN2WjNBRGE2b3FDc2Z0dkdBTW1DcERhVHBpS2p1?=
 =?utf-8?B?NHhXR2g5VmpCZlNkM25OcHpFSlhGYUxEL0dwWEJ1eE1qbERWMjBMYTRtTU0r?=
 =?utf-8?B?OWZ6MlNtMlFSS1d3M2UwQ2ZSUnZEUGNwNE9KWDg5WWdIRHdZaEl0Q01teExj?=
 =?utf-8?B?MmdlT2dVaE02cy9YKzlQR3pQL3ZVQ0EvWjlkSWNQclRSM2tMYVY4RE9kdWVh?=
 =?utf-8?B?YS9mOHE5a0RPR1hMa0ZkQy9lb3hncDBCV2lBSktKUk54OEFqUkd2SmFqQmtC?=
 =?utf-8?B?MlBpZXFER0lTd01zU3Q5QXhTQmtKTlRlZzEvZEVmakU5NGsvUlY0YTJBT21Q?=
 =?utf-8?B?TTlBNkdMditYZDAvQ2dDaUMxbW1idE1LeXdyQVZndGFHeUNGZDUrdmFGTjI5?=
 =?utf-8?B?aDdTdXNNUGhOcjJMdkxsbVRKQWlmdTVjMzlWRGpnUjhabk5zSktNOUF0cVov?=
 =?utf-8?B?eXRlTTFXWkJ6ZXNlb2RsR3BlbzM4ZmhkYkw2aEhNTUJpK2U1d2oyVTlEOE8v?=
 =?utf-8?B?U2xrSGtlZS9BWE9SMU5xZXdURmdvcjVYV0ZhU1hLYUhwM0hsWnV3eHZDbzlt?=
 =?utf-8?B?TENrbW9JUjkwamdVNDVvYXdhRjdHUFpYSGd5YVJRR3l3QTBNUzhOYmNhNnJi?=
 =?utf-8?B?T1RpNFN0VnVTNmw0c3QyblRsYTY4VVJ1aThweGJIRjNHVnhqV3k0d2ZVM1hJ?=
 =?utf-8?B?ZzVoR1hxVWpaMnI0R0QwY2JCN0xPSnZHWWwyUFdsUm9GNmNtYmViTGRTaGh1?=
 =?utf-8?Q?vqADgOx71pY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sjc0M0l5K0lrV292MjI4ZGtESmpxZXZvN0tIUGlWSTRRSWdkeXQ0VERuSER3?=
 =?utf-8?B?OW5odWE5Mmk3RnBzcmJCQVIxSHZ5cnJ1TU1SampzM2NsVi96VE4ydGo5a25P?=
 =?utf-8?B?Tmo2NStsdGczWUd5Uk5YVUtJSGFjelpmMExuYk5Md2l5OTdPR2xtZU1wM041?=
 =?utf-8?B?VUJNT1cveGJLYzRVbFJobjE2Rkc5N0x3Q0dxTm5iUzVYQWYwbWlEeEVUektF?=
 =?utf-8?B?RmRwUmlHcVlDcEM1RXhpbzdXS1I2SEd2b1hVblhuZGZrQ2VUc3RkSEpDVVFD?=
 =?utf-8?B?SlpxTy9pdVdaenVUcDRzK2xJY21xc0lhVnl4RVBQSEY2NVMrcUZTUE9DTytw?=
 =?utf-8?B?RFpobjVBVVI1WVBaUm1PZE9HVTlCb013bEVwNDhXcUE3eDhqeXZRVzJBNExX?=
 =?utf-8?B?SWhUc2QxcFI5WncyZXNPV3ArUk1zeVpnVG9mOXRPMys5cndsMW1Bc0FKOVBi?=
 =?utf-8?B?QnJtQmxFY0NsVHozeXdZK0swR0xZeU4xbmdMc3g4UGp2QzY2NkdtWlp2czlj?=
 =?utf-8?B?cnRweGVBV1ZSa2h0L3g3UitjVzBoZkFrR1I1NnVRQ3pRQ1hpZ2N3R2FDVEpC?=
 =?utf-8?B?TEJSMGJ1WVdYUXROOXZqVks2ZEFkVytJZW9ST3JrNnNjYXAycmJBVE1KVk5P?=
 =?utf-8?B?dWJDQ1A5c1J2aTFYbklmUFkvRnB3YlNkZ0haaW9FbUYxT1h1UXlkaDVOS2h5?=
 =?utf-8?B?MjBvQmc1cEIzemxEdm1MdTNJS2NFUEVic2U0QnEwTGRqczBsYWxlYTBhRlk0?=
 =?utf-8?B?dGdsK1NzWkVhUEVMOVN0UXdvTmdBTWFITW40REQ4M0dIL0liL2NyL3U3bUdF?=
 =?utf-8?B?YWxYdzJBQkZVbVRydWIrd0hRTDdMTklxK2xhYS9UQUpla0ExK2Z1OG00bURL?=
 =?utf-8?B?c0V3VTB6RkRLU0JadmJybGc1MGJ6UlVYTVZCSFBGa3J6ZzFueTNqQTFyMWxZ?=
 =?utf-8?B?dDVQWjVVVjMwRUxzVWZUQkttdXA2dnYrZjdlYlUwQUl5NGpXMi8rdVdjOWpF?=
 =?utf-8?B?YVkwMEtqNkRVME91V2Z2THRzeHRDZDZEc05BVlh4eFNRZmFRblZERFA4U1o4?=
 =?utf-8?B?SEZuaUdhZzZaQ1M0bUhtdTBmSm05QWx5NFp1TFZqNmFvMmNRdmxubDZsd1RB?=
 =?utf-8?B?UFFzdkhuSUF5djVEeGtQN0ZOSkh1WFNyNyswVFM0ZW1CK2FIbXZ6eTFSZ3NT?=
 =?utf-8?B?eHFiNWo1cFRMb08vaDE4ZGQzOThGU3RJblM4ayt3NVhreTlNdUI0cTNkZGlQ?=
 =?utf-8?B?dHptMlBtNkdFQnVkSDc2d0hRZFg0Qlptb08vQ1EydUdQbDhrN3lIODAyYWNS?=
 =?utf-8?B?bmhzV2U0UG9FNU55dkJXTStBczhpMG5jaHhpVXpRWjVoNklzZm44VUpGR0xH?=
 =?utf-8?B?cHFvVTFvcjlSNGM0UGJPNFlNbFB3eDNVUnAwQXRrS3FDNTRHWjQvb2ptOHRH?=
 =?utf-8?B?cWlBcmM2bjRiVGhseDdtbzhRdzdWNnhaUGdIOFFQZTZmdjVJWDJjVUtIWjhN?=
 =?utf-8?B?Y1ZPallQak1ZdnEvNFNhM0tDM3N4VmMzbUhiUE1qZHlNczlJSkprcWFMOFVV?=
 =?utf-8?B?RVRyOFBBRXlSRXFwRityT2ttQ3ZIMzNraU1LN2dyQklyVXRXaWpoeGtxRWU0?=
 =?utf-8?B?dmVESzRjelVUbWJCbWU5VVkvaXV4VjVuS2wwMDUrTkxVeXN1RnRERUhaZkFp?=
 =?utf-8?B?UENPcmtwQ2tMU2hSamhqVTJqTVpXT0dYYzF6SmNCU2VGZzhTUTMxWXlMNnpW?=
 =?utf-8?B?NThGTzJ0cnlzTzRqRzM5a0RTcVJVR1NaSHB6bWRMVGl4NUdHdEtONTZRandm?=
 =?utf-8?B?djNTZklmaSt5eXU0eU1MeDljZERVTFEyQlgyS2xWQllkVUVPajVmS2lBWnJ6?=
 =?utf-8?B?Y3dvcC9nV1BnN0lrSFYrM0ROc3ZsMEozY0MvZ3p6QndwT1JXNnhPd0VWWjNP?=
 =?utf-8?B?UTNIMHdyblNlL2g1dzVuK3BlaHY0UnM0TzVRMEc3QmN1bmY2a2dQTWxoZEZW?=
 =?utf-8?B?NklJWEQ2aEVXaVVnbG5FZVJ1YVFyc1BrU0FKb29YTkQxZSs0ZjJRK01JR2pM?=
 =?utf-8?B?QXFFUHFSZkxVYzA4N1BvNllWRC9ZQW5rWXRNSkw3NlJwa1JHZjJSVytkZWNZ?=
 =?utf-8?B?NTRHMlJyREhzVEYwZmFkMHA2VkNSQTR4ekVUVG1oZVgxNDFwN1Y4K3Z5Nm9x?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xmraCLuyIKKxIs4wIstbJ9h4wu6w/RSntYszMTlI0D8kN6iS6Yom7ryegViFlckA6vN1ho1Zfrv6GXuVSPURLGPpZJ7kYhj6Pn9Myn7+EVe2vBecqT8HawtlLmsttNtbpG4ofMUDg3kEpQfXmXluvB1iY03pMdxs/EFs/QjIOq19qypxDcRts4upp5CI8HjGBrLbcli2ixEK4FTCUNmZj+VsMKeGeJ9Z3xFJqHMjepgAQM6rttRiI73DxPrsKll8QqfOdlYGuB16evug7oaIJUG8moPoJIf94N6JBqYlBlwz+goAdfedx/Etn2WxvibJgQJan8eJOSRxGOBqPbmigx21aIbZN0ysZKUUvBIfXcWTH9bGOhruYo5eScJ5v+KX+j4J1hCoW44IGCffxiFKLekk0nlG3dl/dwXSek+f3JbcPCHA09/s4IEDYAw4E1UKfGOWsHuhYdoHrVfo37DzXQYjKebcKpgV4Amd8zwy4eNJjWPZeKFOFy8agh33FIiJeAmRiRm9Xna4cZidih7WUK4Taldt2m6H/gqJ9clsdycB6UHkDj7Te2EIeus8ba5/fegeRODDk6N6uOG+VQZYRsr+Le6Js44ILQn+Xp+prSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ba0d78-2bca-46a5-3dec-08dd97a2f97b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:33:58.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdev3OADqRmSZrO+ReWoIyUlTqt5YJZDQlFdHorN1Ls+gBKR4O+B0aSKyysGb7QmxHqFCgd2+2xDMJikZLBvtJmGY/QUf517kYNUBEai668=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200109
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682c84ca b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=sNdkZwqNwaVHzQMhbA4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwOCBTYWx0ZWRfX6V3PSZpAQEAp 2AA+rWuGsrIqxPJGpEBclcixZmBbzpGh79XhYduY0sPL0tMsx9bA05oFm9CBztDdMu2aQEjiQgr 55QXGh+FgOltIX5Ey3HNDG+63X28AbFu1G+SKgJx64Ec9j1CzClpiBqvIHV4kAHGKCsOe+wLcxR
 vuL787R06Gyp9O2Mt5/QdokjLUXw628RwmpcNQBqSMRkiqDyNc3SnJR25HC6GYRa5irAMGDN3Qj QmyBeMIqVBJvrQWj6+Ur2embWscy9WAt950xFhGtEcEQdOZYCMH2yGrMh09MIX9u2m7PS6fs8Dz YaVZU+pI79AwVT2O4c7V39DjKGUX/BryzqOdNa11I9QFcvW3LQeXdWCkK54fyvIoCnnl4GyN69e
 +N2x+ZQnESkG9nj0TXNDPLPx9dh8gi0ROc1x8S1mqU9e05tr6K3jolUSuj5W3mFS+IGjhAe0
X-Proofpoint-ORIG-GUID: hGp1thjPa1Vgfcdm9KzA5Z0u4aU4CvUP
X-Proofpoint-GUID: hGp1thjPa1Vgfcdm9KzA5Z0u4aU4CvUP


[snip]
> +#define PHY_ID_MXL86110		0xc1335580
> +
> +/* required to access extended registers */
> +#define MXL86110_EXTD_REG_ADDR_OFFSET			0x1E
> +#define MXL86110_EXTD_REG_ADDR_DATA			0x1F
> +#define PHY_IRQ_ENABLE_REG				0x12
> +#define PHY_IRQ_ENABLE_REG_WOL				BIT(6)
> +
> +/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
> +#define MXL86110_EXT_SYNCE_CFG_REG			0xA012
> +#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL		BIT(4)
> +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN	BIT(5)
> +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E		BIT(6)
> +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK		GENMASK(3, 1)
> +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL	0
> +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M		4
> +
> +/* MAC Address registers */
> +#define MXL86110_EXT_MAC_ADDR_CFG1			0xA007
> +#define MXL86110_EXT_MAC_ADDR_CFG2			0xA008
> +#define MXL86110_EXT_MAC_ADDR_CFG3			0xA009
> +
> +#define MXL86110_EXT_WOL_CFG_REG			0xA00A
> +#define MXL86110_WOL_CFG_WOLE_MASK			BIT(3)
> +#define MXL86110_EXT_WOL_CFG_WOLE			BIT(3)

seems Redundant since MXL86110_WOL_CFG_WOLE_MASK is defined

> +
> +/* RGMII register */
> +#define MXL86110_EXT_RGMII_CFG1_REG			0xA003
> +/* delay can be adjusted in steps of about 150ps */
> +#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY		(0x0 << 10)
> +/* Closest value to 2000 ps */
> +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS		(0xD << 10)
> +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK		GENMASK(13, 10)
> +
> +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS	(0xD << 0)
> +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK	GENMASK(3, 0)
> +
> +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS	(0xD << 4)
> +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK	GENMASK(7, 4)
> +
> +#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
> +			((MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK) | \
> +			(MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK) | \
> +			(MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK))
> +
> +/* EXT Sleep Control register */
> +#define MXL86110_UTP_EXT_SLEEP_CTRL_REG			0x27
> +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_OFF	0
> +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_MASK	BIT(15)
> +
> +/* RGMII In-Band Status and MDIO Configuration Register */
> +#define MXL86110_EXT_RGMII_MDIO_CFG			0xA005
> +#define MXL86110_RGMII_MDIO_CFG_EPA0_MASK		GENMASK(6, 6)
> +#define MXL86110_EXT_RGMII_MDIO_CFG_EBA_MASK		GENMASK(5, 5)
> +#define MXL86110_EXT_RGMII_MDIO_CFG_BA_MASK		GENMASK(4, 0)
> +
> +#define MXL86110_MAX_LEDS	3
> +/* LED registers and defines */
> +#define MXL86110_LED0_CFG_REG 0xA00C
> +#define MXL86110_LED1_CFG_REG 0xA00D
> +#define MXL86110_LED2_CFG_REG 0xA00E
> +
> +#define MXL86110_LEDX_CFG_LAB_BLINK			BIT(13)
> +#define MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON	BIT(12)
> +#define MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON	BIT(11)
> +#define MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON		BIT(10)
> +#define MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON		BIT(9)
> +#define MXL86110_LEDX_CFG_LINK_UP_TX_ON			BIT(8)
> +#define MXL86110_LEDX_CFG_LINK_UP_RX_ON			BIT(7)
> +#define MXL86110_LEDX_CFG_LINK_UP_1GB_ON		BIT(6)
> +#define MXL86110_LEDX_CFG_LINK_UP_100MB_ON		BIT(5)
> +#define MXL86110_LEDX_CFG_LINK_UP_10MB_ON		BIT(4)
> +#define MXL86110_LEDX_CFG_LINK_UP_COLLISION		BIT(3)
> +#define MXL86110_LEDX_CFG_LINK_UP_1GB_BLINK		BIT(2)
> +#define MXL86110_LEDX_CFG_LINK_UP_100MB_BLINK		BIT(1)
> +#define MXL86110_LEDX_CFG_LINK_UP_10MB_BLINK		BIT(0)
> +
> +#define MXL86110_LED_BLINK_CFG_REG			0xA00F
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_2HZ		0
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_4HZ		BIT(0)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_8HZ		BIT(1)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_16HZ		(BIT(1) | BIT(0))
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_2HZ		0
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_4HZ		BIT(2)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_8HZ		BIT(3)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_16HZ		(BIT(3) | BIT(2))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_ON		0
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_67_ON		(BIT(4))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_75_ON		(BIT(5))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_83_ON		(BIT(5) | BIT(4))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_OFF	(BIT(6))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_33_ON		(BIT(6) | BIT(4))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_25_ON		(BIT(6) | BIT(5))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_17_ON	(BIT(6) | BIT(5) | BIT(4))
> +
> +/* Chip Configuration Register - COM_EXT_CHIP_CFG */
> +#define MXL86110_EXT_CHIP_CFG_REG			0xA001
> +#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE		BIT(8)
> +#define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE		BIT(15)
> +
> +/**
> + * mxl86110_write_extended_reg() - write to a PHY's extended register
> + * @phydev: pointer to a &struct phy_device
> + * @regnum: register number to write
> + * @val: value to write to @regnum
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 or negative error code
> + */
> +static int mxl86110_write_extended_reg(struct phy_device *phydev,
> +				       u16 regnum, u16 val)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
> +}
> +
> +/**
> + * mxl86110_read_extended_reg - Read a PHY's extended register
> + * @phydev: Pointer to the PHY device structure
> + * @regnum: Extended register number to read (address written to reg 30)
> + *
> + * Reads the content of a PHY extended register using the MaxLinear
> + * 2-step access mechanism: write the register address to reg 30 (0x1E),
> + * then read the value from reg 31 (0x1F).
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 16-bit register value on success, or negative errno code on failure.
> + */
> +static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +	return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_DATA);
> +}
> +
> +/**
> + * mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
> + * @phydev: pointer to the phy_device
> + * @regnum: register number to write
> + * @mask: bit mask of bits to clear
> + * @set: bit mask of bits to set
> + *
> + * Note: register value = (old register value & ~mask) | set.
> + * This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 or negative error code
> + */
> +static int mxl86110_modify_extended_reg(struct phy_device *phydev,
> +					u16 regnum, u16 mask, u16 set)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_modify(phydev, MXL86110_EXTD_REG_ADDR_DATA, mask, set);
> +}
> +
> +/**
> + * mxl86110_get_wol() - report if wake-on-lan is enabled
> + * @phydev: pointer to the phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + */
> +static void mxl86110_get_wol(struct phy_device *phydev,
> +			     struct ethtool_wolinfo *wol)
> +{
> +	int value;
> +
> +	wol->supported = WAKE_MAGIC;
> +	wol->wolopts = 0;
> +	phy_lock_mdio_bus(phydev);
> +	value = mxl86110_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
> +	phy_unlock_mdio_bus(phydev);
> +	if (value >= 0 && (value & MXL86110_WOL_CFG_WOLE_MASK))
> +		wol->wolopts |= WAKE_MAGIC;
> +}
> +
> +/**
> + * mxl86110_set_wol() - enable/disable wake-on-lan
> + * @phydev: pointer to the phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + *
> + * Configures the WOL Magic Packet MAC
> + *
> + * Return: 0 or negative errno code
> + */
> +static int mxl86110_set_wol(struct phy_device *phydev,
> +			    struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *netdev;
> +	const u8 *mac;
> +	int ret = 0;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		netdev = phydev->attached_dev;
> +		if (!netdev) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +
> +		/* Configure the MAC address of the WOL magic packet */
> +		mac = (const u8 *)netdev->dev_addr;

is netdev->dev_addr not already of type u8 * ?

> +		ret = mxl86110_write_extended_reg(phydev,
> +						  MXL86110_EXT_MAC_ADDR_CFG1,
> +						  ((mac[0] << 8) | mac[1]));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = mxl86110_write_extended_reg(phydev,
> +						  MXL86110_EXT_MAC_ADDR_CFG2,
> +						  ((mac[2] << 8) | mac[3]));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = mxl86110_write_extended_reg(phydev,
> +						  MXL86110_EXT_MAC_ADDR_CFG3,
> +						  ((mac[4] << 8) | mac[5]));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = mxl86110_modify_extended_reg(phydev,
> +						   MXL86110_EXT_WOL_CFG_REG,
> +						   MXL86110_WOL_CFG_WOLE_MASK,
> +						   MXL86110_EXT_WOL_CFG_WOLE);
> +		if (ret < 0)
> +			goto out;
> +
> +		/* Enables Wake-on-LAN interrupt in the PHY. */
> +		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
> +				   PHY_IRQ_ENABLE_REG_WOL);
> +		if (ret < 0)
> +			goto out;
> +
> +		phydev_dbg(phydev,
> +			   "%s, MAC Addr: %02X:%02X:%02X:%02X:%02X:%02X\n",
> +			   __func__,
> +			   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> +	} else {
> +		ret = mxl86110_modify_extended_reg(phydev,
> +						   MXL86110_EXT_WOL_CFG_REG,
> +						   MXL86110_WOL_CFG_WOLE_MASK,
> +						   0);
> +		if (ret < 0)
> +			goto out;
> +
> +		/* Disables Wake-on-LAN interrupt in the PHY. */
> +		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
> +				   PHY_IRQ_ENABLE_REG_WOL, 0);
> +	}
> +
> +out:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +static const unsigned long supported_trgs = (BIT(TRIGGER_NETDEV_LINK_10) |
> +					      BIT(TRIGGER_NETDEV_LINK_100) |
> +					      BIT(TRIGGER_NETDEV_LINK_1000) |
> +					      BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +					      BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +					      BIT(TRIGGER_NETDEV_TX) |
> +					      BIT(TRIGGER_NETDEV_RX));
> +
> +static int mxl86110_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +					unsigned long rules)
> +{
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	/* All combinations of the supported triggers are allowed */
> +	if (rules & ~supported_trgs)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	int val;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	phy_lock_mdio_bus(phydev);
> +	val = mxl86110_read_extended_reg(phydev,
> +					 MXL86110_LED0_CFG_REG + index);
> +	phy_unlock_mdio_bus(phydev);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_TX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_RX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_10MB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_100MB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_1GB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
> +
> +	return 0;
> +};

extra ;

> +
> +static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	u16 val = 0;
> +	int ret;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_10))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_10MB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_100))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_100MB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_1GB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_RX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX) ||
> +	    rules & BIT(TRIGGER_NETDEV_RX))
> +		val |= MXL86110_LEDX_CFG_LAB_BLINK;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = mxl86110_write_extended_reg(phydev,
> +					  MXL86110_LED0_CFG_REG + index, val);
> +	phy_unlock_mdio_bus(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +};

extra ;

> +
> +/**
> + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> + * @phydev: pointer to the phy_device
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 or negative errno code
> + */
> +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> +{
> +	u16 mask = 0, val = 0;
> +	int ret;
> +
> +	/*
> +	 * Configures the clock output to its default
> +	 * setting as per the datasheet.
> +	 * This results in a 25MHz clock output being selected in the
> +	 * COM_EXT_SYNCE_CFG register for SyncE configuration.
> +	 */
> +	val = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +			FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> +				   MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> +	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> +
> +	/* Write clock output configuration */
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
> +					   mask, val);
> +
> +	return ret;
> +}
> +

Thanks,
Alok

