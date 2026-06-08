Return-Path: <netdev+bounces-296340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zlh/KnAkJmrcSgIAu9opvQ
	(envelope-from <netdev+bounces-296340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2A6522D6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=ChQky+je;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296340-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296340-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 687C33007ADA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB2308F38;
	Mon,  8 Jun 2026 02:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926112F872;
	Mon,  8 Jun 2026 02:07:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884454; cv=fail; b=Z8EspMudrckfwooVHrKlghRpg1jBK/hIGF9NkJb1dOhVIqO+wM5y4uaExRhwG3RcBP7u1KK+snBeFckNxLwqdQf4AHldUDgXGB5oigXpliV5gPDMUr/umy9BGQMwyGNG8k5uhxfPa4xJCmmx0l/eajSIUxEwMuLXE75j3cQgx0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884454; c=relaxed/simple;
	bh=ZTuDq+LJ2dTro4hL5oqAqOH18z8gG38sGzirpSVXf8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CC6DULonrt9AoHL2FMRufOk7UbrnzKknUHEVhKWX7oUmPP2cvgYn42GplKlWQXR1h2gGMoaZJjVizPA0xkxiQwvLuArjAT81EzBlXSX1Rve9fbxxmQHEQsaeghQ1bNQEFeph/V4N9YiXI6M++GFvwTaOYpf0+Qi4rIgTB9S31bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ChQky+je; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580vTXx2923799;
	Mon, 8 Jun 2026 01:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=D2/6yVRWoUdPmtwDc2Z/tDtqjjkVKDdiecYCrsHgQQw=; b=
	ChQky+jehcCMyst91WB1xxRsNH0rRn9+71PKQz3zcqhhpkM57DL4eccBjeCV9tqn
	71Y4KTJFu91BaAjDoNyIJ87u6EAOdwuEdBm8WfYqM18V1JbrOuTnujYXkvlwkfpL
	s75X7A/hAnQWk7KVV5dYVrbF9jGRPNXIPUajM6pMdekTzhBzIgczVkg4XCljOAqE
	0OFyUZC2oP97iqDSvLJfV+c8uGe5njWcVTRCHWPhmQg6f0G5UAz/WbRnPA70hbeX
	N2QlhdHp/GFvEK7IB9rh4mF+3uqu6JhwI1nP2CRqZmkKkWrJAcvcbSBXDbiv2+dy
	ji3ghQionQp/3xuRK2CBzg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4emah7a07u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 01:30:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl0k7brp96vPP+I1aHCF0g8ohVxt5LwUhu/bot09ikZd4sAXuJrFNche23PHHcb5KnOdiaOeQ6He9grisjAkfQtxnW33UmfkM8+W/21j2f5GjuPG1X4Up5nm89Vaiz/yDq+mt5eeT9c8UVUGgDNBU0N9/x0QN6XJ+I8FOXx9jdNVQozWCNb7q1uLA1ExEJF7maGms6IoxubVXYymTVPgj+67N6IlPOPfanZUAq6BUkiTqtNFtdaYUodz+ylWoCz49d1/d2ohG5lm4t5fZ8Lf0swVJ/u7JdRkLi7JO1k7vXT2cLQcuDfEiA6YHtk1qWVXDlG745rfPLXgRej89tEJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2/6yVRWoUdPmtwDc2Z/tDtqjjkVKDdiecYCrsHgQQw=;
 b=riOilFD9KME4d8iOuzcScU7WiB0YlnEHAWbrqeMxaRtxpywvL8l6UedqGQVQ2eTI7W+KT2nFxOriE5tHr+IqvX8BOmSYqp+PDOEXVoC3QQkm92c+QFIhryCmrK9jRZW3/k62zBW5S4PWk3Ha/k49QFdMR73GuWgaTrQ8ovE9l7KNV2cDOS/Je6RyD4YLrs3GXNFY6C+/kAuiBJTm5T9midJlax7oyN0BgLh+QAFXoG9dryBmhwql4uY1LRSIpgBu6iMlPg84T3E19xRsWUEfUbb/z+0kbRu+Qn3x92NLEqIy9FQpMcJiTRM286Ry2vJ9ZKOita7xx47kbGyt8yTSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by CHXPR11MB9649.namprd11.prod.outlook.com (2603:10b6:610:2fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:30:20 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:30:19 +0000
Message-ID: <08433245-f57b-472b-96b4-7db28e1a3ab2@windriver.com>
Date: Mon, 8 Jun 2026 09:30:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect()
 for ETH_ADDRS
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
        horms@kernel.org
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260603030810.3593625-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::19) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|CHXPR11MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 04de749d-d7e0-4ffa-ab09-08dec4fd8050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eazAQkFXqgfFLAdHoALBcQAPpY+HyMU1TBbTZ/1L9PEm9zAKfe+i33auwH4+Q/PSEKKoFGwQ4RX2GdQKutgV9TvjZD514M+ZmOxnKVE/A5rXQ7KyzcBe9tf3944lSE9H9qa7IKJXIxpqX3kZFehZ5F4lk2w8UlsSBf0uBMoMQWfjSrd+qMcOgC1T5geTgwXF1SYchyRaQvmUmlpZMft8nY01hc/0KxdoLaWeZRq0tKtN1Y3eVluG2BRaLhP5TjRwljCbYpN2QhUIAc+OOMcHZINsj9r1mdR/gdqQt2m+xXLYxmwM+eJsNWxw8EmC7eWNwDXSvO0S+vzkbADdOh7dn3TGTWK4sx2/rFXRi7MpBRixINA2BcJmUEHpo9o3aNlE5xKn7sQVplSKuiq2PY7MWqIgxuf87yxXoHk0072vMC9/7GY4ejmWfHIQinRiWhdCNbYbJ8k+3jz1rayuzAs707VpkCiO/15s6nxdeca15FhdiliNTAm1IlILZELqgRq6/HUvEO3SgdbYBIV2A3bjSyIcV1AqZVfB/koHEV6bewBITQm2tZKX6E31rhUoeojxxMe1V/ZtXSD9w8eAsuoMGSLiuqtK4Mn9E7E0oCtPwEnyttCSljOyIiGnxq+ceMe7VnY/sZDUMs/nS1Az/lj60JTjGZ+d/sySQwDEoVHztQj9T/7oyxbab1SEc4rXxLdj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkNxZE1kd0g4c013T29CLzBvZ1hOMXFYMzFuTmtkWFdpcWlTcmQxaUdBSG92?=
 =?utf-8?B?UGdnSXhPY2RIUW02blllWWlpMVU4WCtndUNzaklHbzVSejNlMHhKNjJNenBI?=
 =?utf-8?B?ZjBPWUdyWTFDTFh6bEN2UTlIK0xFcWdWekJhYWxKdlFFQUg3Z1ZQUTBLUDNZ?=
 =?utf-8?B?bEhUNjRVUkJSZkFWc3IwSlcxVG02U2NBZDZ6WndSc3JuUFNwZHpBZTBoOUQz?=
 =?utf-8?B?S1dXajh5UFhkLzRJellnblZoNi9WVmtxM3hiQWNQOTRuRlVSRnhkaisxcEJB?=
 =?utf-8?B?eWgvVXNIUDBJdGpwZVdWelN0R2VPdzBDdWc5dWN6Q3pEaXZrdTNMUnhCZUh4?=
 =?utf-8?B?ZTdQd0RlYXJVT2IzRTgwaWdQa05aRHpoVzlQSktoVnhlMFFjSTRIajByWmZQ?=
 =?utf-8?B?UU1wNGpGRDgvYW1Rbi82KzBEMzJYQlQrcGtiSldwS2MzTklnVXRHQ0U5MU9o?=
 =?utf-8?B?SlVCREdCbXl4dTZscU1mYkQrVG9xYlYrUXZuMzRKZC9ScDlWM1FFS2dudnd6?=
 =?utf-8?B?U2dSeGNsMkRBbUh3KzUxMlB2dmh2SkdOL2ttMWlZZGwzbnp6bFFVUTB2bklJ?=
 =?utf-8?B?TUYzVFVOOERGOWNJZTlIUi9TL3NOM1M2TkZWZVV6WFJEQ3p3aFV4MkhqKzB0?=
 =?utf-8?B?ckZRN1U2R0RaYXNPV2RIVlNITUZoM1prSjVFS1ZvczNFclVpeWFoSVY0YTFq?=
 =?utf-8?B?cm40OTdUUDRsNFRWUUcwcFFxYmY4akhNT3B3amZMRlR5UmVqVzZ3S0YwYk1Y?=
 =?utf-8?B?cEx1cmZtOEcrZEpjVGhGQ0wxOC83dEJ3OFl6dHFwN0VpNVFINnhIMnZBdHN2?=
 =?utf-8?B?UEZTczA3bUMrZUNpNjFhZ2xIbmI1OGhYTmpqUUkwM2ZNOUxTRnVRMHFPQ3FP?=
 =?utf-8?B?dzR2a0htZ1dBbk1nWjVMb2tpbkE0U2p0a0FaMVdraUpPKzNMbUNzZ0tRRXpI?=
 =?utf-8?B?NjZUcWhZOTFnY3dxUDI4bU55c25iVG93VzlUM0V4SlNLT0wwYnZhb0IxK3ZQ?=
 =?utf-8?B?UHc1c2hsUU1ucHVPc0V4YitIdWhHL3FGZU1KeEV0V0xIVCswUHpuNzFUeGpm?=
 =?utf-8?B?amFnRnpSQ2dVUzEraGF0aHNRWXo5S2g5ZmxSSU9JRHEvUExFYmFzZnVETVZq?=
 =?utf-8?B?R3hLNmtnTHV1WG0vQ2I0bHpMcXQxWnJzUWdCdWFxRnJqRHZCR2NhcDZ2dGpF?=
 =?utf-8?B?WkFycjJjRzBCekVrWkc1ekkxYVdES1hYZkY5aC9selE0L2RaeWg5SzZSTTRh?=
 =?utf-8?B?Qzc2WktJS1BZVHd5cHlsdG84TGlhL09vcUlXRkxnQlliTE9oUmYybE5BbnVu?=
 =?utf-8?B?K0E1cnBrNERUQkY0YTd2U3dud25xMGdxUWltMnJPWFNhNi96eVFvVTU0RVpX?=
 =?utf-8?B?SnlHalRzNU1HNWFBUXZBd09yUjVaZ3dQZ1AybWtCTjFYbE5sU2liWUZKaXRt?=
 =?utf-8?B?WmRtN1RjS21zTXRUWmdxTjl6cDhTaVViazNjM1M1TWNrMHNUeU5kTVZjK2tz?=
 =?utf-8?B?Q3ZzZmk3cWc5VjRmdFdOZk1QZG5IVnp2cWwwemI0TU9oWUlHVUQ5eGtUclVK?=
 =?utf-8?B?OEQxc0xYR0RveFBmdmhrL1VScnpPUEZBZ0ltcnlCbHRWN2E3dmRwbWJocE1r?=
 =?utf-8?B?alJ1YzVMQmtrUXI4ZVZFcU5BMFJLOWxPOUZXUnN5b3pyTnFLVy9OemVvRGtO?=
 =?utf-8?B?OHJGZVdCL1RSbWNvWERRajlGREx4a1ZpUnlXSmtTcER3N3ZEVFZXM1JlN3li?=
 =?utf-8?B?eitnUEd5RDEvUU9DYnNZUjY1TDNNZDhGWU5kR3cvRXIzazNESzVWbHlkOVVE?=
 =?utf-8?B?SXVoakxMMHFnMWRlNEVYaUUzWjczMWVhSGlOWmFqNHlBU3gveis1RXVEdm1Z?=
 =?utf-8?B?b0ZXTjVTYUl1WkhEYUxPSHNsTFRZTk03RUFsL3gzUFc5QW4xVVRmZmljVkg3?=
 =?utf-8?B?VDBTZlJwRUR2OS9VODRGNEFMR3R1VnNMT3M3eVcyYVFEL1JmS0RNd3V4b3Jk?=
 =?utf-8?B?V25oSnhDVS8raGR4VlExVFRpWmFrMnpXVDg2TlIxV2NXT0F0YTFUQmFJTzBQ?=
 =?utf-8?B?RDZQa29maGhaQ1hIV3B2RzZrME94M2o4RkNXaUk2L3ExRThaWUlmSnJuRVpV?=
 =?utf-8?B?MkFuRHFaL1NrQWpRS0Z5c2VMUWFnVGx4WlJjRTFpUTF0UlQvejBsaFVMQ3VD?=
 =?utf-8?B?WGpxUFgxc2gzaUlrYkVyd0lVZTEvNkR3UFUySUVFQlR5amtVTjJESDh2VVlm?=
 =?utf-8?B?NHEyaHY1UVJEOTNqbjBUL3hhVk1PRkxXMG8xeTB4V2pZSXBlNTFUOTYzTDBR?=
 =?utf-8?B?Wks0VjBsSExlNjJ5L0ZoaEZ3RjFyekxJdE9GRVV6QnJOOVFPT21nUT09?=
X-Exchange-RoutingPolicyChecked:
	X0wnUnF0fG5lkZ+ya6G6/yB5tHDlBLzZG4Yz+aYh3Zeo9ZekwxkGZsF228VpA+YDjp+MkvbQLYkdFtVr098Rp9mmz28XwcSLvjvMEuxqo1nQjfraM6eSGC9+5NMuFQTh79tYRQLu9hhHqVJz0Qoyp+iGWxKCQxYpreJyxWkAa113RGfwmo+zT3N3GlrH3gFnS3Z2+5GRq8EfW8Ku3gNiskpttsFennHuB9Wt1krzFyKktiP02VI9iog61h/y9XZzYtgkll4WGEVNXu1XUpe2kKDFACtN5Br8tqwTZoybNfm4B392PhnF4ScML1Jjpkh/ArMsXg6m+3KZtGM+8J08Xw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04de749d-d7e0-4ffa-ab09-08dec4fd8050
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:30:19.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+vtrrDtxXXPBSLbpF9XVsKzaEpxpB8JEA5kceHbckbd5n9IxsttQQU1gdy5jReDHD5FNuSt4cNlM1sjKL1pNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9649
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAwOSBTYWx0ZWRfX7Et6Vro9dLqN
 vraSc1SfIr7dEEEF5xhGnK1mAstVi8xCB+n2ilN7G1hnPZUuMvwaYe9uJORndd4+1Q3R97gAYmJ
 grOQc/6L/zRo44gdPQAXNjS/yV66VFmANZYRXebmbL1XEk3dig3+ThjpZRRrHgfLBoWbEBsonMj
 EyOGiDW3K9Wk1xKAykC6Sd1Y17YhGwL+Sk2u8Py7Oyp+45rZNJ58mtnPtPWTzr/AA/zsKBH1Z2B
 exCK53w89N9vyey1wPb5cvWPdsBsIo2Eg/ZTruezshw8RXC3WiIhT044T4GAjnWm6k+b6aDcuOL
 MnjewaOw9jjg0AZIu/3zMxGOPdva+3xr4KN25Xlq3t79fxJzMDieDWbEnJBg9HYOChFIUaZwPFy
 02PabpfaZhI+o93ROdRqtWEmWb3GPbtK9zcx1tW4Xjrq1jHAOqTkH5xphc4WjdFbPPr5Kk8/eOp
 CmBOTNMWX7/VxrXVluw==
X-Proofpoint-GUID: zKbuttTUsfGnJ_z80kLyvVvttwXr5tTJ
X-Authority-Analysis: v=2.4 cv=NbDWEWD4 c=1 sm=1 tr=0 ts=6a261b2f cx=c_pps
 a=yHj7y5KTVbbUXXBv8k4PkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=jVBKmSDLlb3BJgi0O9EA:9 a=QEXdDO2ut3YA:10
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: zKbuttTUsfGnJ_z80kLyvVvttwXr5tTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080009
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296340-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,windriver.com:mid,windriver.com:dkim,windriver.com:from_mime,windriver.com:email];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1F2A6522D6



On 6/3/26 11:08, Yun Zhou wrote:
> When dissecting FLOW_DISSECTOR_KEY_ETH_ADDRS, the code unconditionally
> copies sizeof(flow_dissector_key_eth_addrs) (12 bytes) from eth_hdr(skb).
> However, if the packet is too short (e.g., a 1-byte packet sent via
> AF_PACKET on a TUN device), eth_hdr(skb) points to uninitialized skb
> memory beyond the actual packet data.
>
> This causes KMSAN to report uninit-value in __fl_lookup() when the
> uninitialized eth addresses are used as rhashtable lookup key in
> cls_flower.
>
> Fix by checking that sufficient data exists from mac_header to skb tail
> before copying. If not enough data, zero the key to ensure deterministic
> behavior (no false matches).
>
> Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   net/core/flow_dissector.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 2a98f5fa74eb..d5817b800079 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1173,13 +1173,19 @@ bool __skb_flow_dissect(const struct net *net,
>   
>   	if (dissector_uses_key(flow_dissector,
>   			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> -		struct ethhdr *eth = eth_hdr(skb);
>   		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>   
>   		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
>   							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
>   							  target_container);
> -		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
> +		/* Ensure the skb has enough data at mac_header to cover
> +		 * both src and dst Ethernet addresses.
> +		 */
> +		if (skb_mac_header_was_set(skb) &&
> +		    skb_tail_pointer(skb) - skb_mac_header(skb) >= sizeof(*key_eth_addrs))
> +			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
> +		else
> +			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
>   	}
>   
>   	if (dissector_uses_key(flow_dissector,
Hi Jakub,

What is your opinion on this fix method?

