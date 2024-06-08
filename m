Return-Path: <netdev+bounces-102008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B741901175
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9360C1F21D6C
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC271411D7;
	Sat,  8 Jun 2024 12:33:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824B2206E;
	Sat,  8 Jun 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717850008; cv=fail; b=ga+eJPlb2jLCcnO6Ovf3AowQVMGC+4Bci9WIBXAsuLIky7Ewv3nLV0711X1ahgyAo5BJ5kKHpmwCH8z6Qc9slyLBY+DQY2mD9+7awkIEnWb7RO9JZROT0ldY4XdwkZlXnvC5LmCgI7i7VOT3MtdKIVlrC0QtyJvOWiD5ST8+rtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717850008; c=relaxed/simple;
	bh=77NqC2JvO94Of5OqjtrFes3i9BrflKaGffwKs8P4v1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SNHTxSBM0xPwfpnhvY/+HwrJ9LuExwwq4vIGuZG7MB6m8JXonEzRURa4q1Sk5EK+Lg8lwj7hCecSVnH2krlbfLT+5K/AiKUwW0vEapIkeZnJT0LdhLFKU7rK6JpbZPzRcMG8MXDrgbTuNL1faB9D7sj5X7sfQ3IrUtxVDPH4/j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458CUTdH024420;
	Sat, 8 Jun 2024 05:32:53 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymjk284p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 05:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM2dWBvLkb9TNV3/QBVXJ9P01ic8EwrmKb1+Vx/YOVTkMBbphKNpIoM9/1a6zNt4vwhlcOmzhYBhM9lvRxnzQ77L3VxM5of0e34afE1xGE9ShaQmSDDEmALZTgzJfiJFAkDFUiIjth3rJsaMH4OHIwiJzBEdDoA26xRJX4bMQJp4wlpYj3lG2j9CFpW9zmqfMKPqN5Ha27I2kw6ROWrB1ZH0XLbq1Q83lo/LfhcFalBfUc1Bvq8bWpBBY4MYSvluSdfaMEenPmp9xVcCT3JdiNs/cw6p/3q8yvIKv54P713USYbh3gUAeP9vJreR1r62y2MIELK/y2nFGSVMfXFakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKMDv2/lvezgtQB/YMLRWs20JmVbgiIsl5tCv2/RYso=;
 b=kTngjQGZOFRRgHUxQ87oKmlQ9oBQ8yz6akW3K7QQmsKMUw6OM/EkZjCWEzul01nGB83L4oC7/Ctl0ZekYLzYH8q6WhsN+VyXFVk1Mcjm5wEzh26IOQQ4LjKa31K2/WLBlouxnkca1WIrsDMIlaRbFzFkaAnzcH2KdJH5GWMXqzMLwPxByU5T1DaI66VwoWDi181qhuyZp4Okqg9NLuIp6PS4G9VxHhm9NHUS7TyKPouA7vL9zaJx8cZA92F6BO5bNywL9XorpVDLcRmVbPUhqmSmvW6I5sxc4d7cHGowVkw+9E1FJ+Y1Ix5yDqFfipeVTLXOcCOVgl62AyernnC9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sat, 8 Jun
 2024 12:32:48 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 12:32:47 +0000
Message-ID: <1394b6f3-b9cc-4526-94da-a1edc361eaf7@windriver.com>
Date: Sat, 8 Jun 2024 20:32:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net v4 PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
To: Vladimir Oltean <olteanv@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        wojciech.drewek@intel.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240608044557.1380550-1-xiaolei.wang@windriver.com>
 <20240608111621.oasttwwkhsmpcl4y@skbuf>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <20240608111621.oasttwwkhsmpcl4y@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e81c7d-09b2-429a-55c8-08dc87b71a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c01pdGRSR09XVlNPVzNRbVptMXVja0FNa2hKaFNnYTRIUEw1WVpwL3hkT2NJ?=
 =?utf-8?B?QURPRXlEc2Y5dmpRVXpucExGdHJwbmhDN2I4VllyZUdYTStBd3Fsd1g0eHRR?=
 =?utf-8?B?S2hUdTFUVkNiaUpwUFdBeis4aVY5Y25ybkFWblVEaFo4VVlHYnVsempkb2JS?=
 =?utf-8?B?bkhXVGVEeGlHTFEycUIzNENob2dxRkozSk0zUzlmOXlSUi9hVXcvTzI3aFJY?=
 =?utf-8?B?QTdrcitMU2RmblBud2E2V0o1RmVGVlBSU3A5WlgwS2pyd0RycEQ2QVBSclpF?=
 =?utf-8?B?UVFkTUlEN2RBa3dyZHlRcCt4Qi9zU3F4MmVueHVGdm93aEcxTEl3OTZTL2J1?=
 =?utf-8?B?clcvN1Z1VTV4V1YvUTZIQXUwYUtGU1BYVGFsdWpQRkF6ZHEyalZldDRqV2p2?=
 =?utf-8?B?WWh1ZUVrQXZKeEpPd3gxUGJ6ajAwTE0wM3VZdGM4NzFnK2V1V2ZwTlJneDl4?=
 =?utf-8?B?dWpFY2ZkS3ZvQkNCWWdKd3V0VmhncmVFWEJQSkFJbnRSbG83TlRpR3AyWU1Z?=
 =?utf-8?B?SGIzTVVQRkJhR2JTUVk2OW9GdmdnTDhuT0J6Z0V6WHNqdUpPeU1NREdKRE1i?=
 =?utf-8?B?TXg1K0o2N0lJTE1hZ1kwTFlURUw5L0Nnc0FyMkd2NVphTGQybXdCbS9HNkNs?=
 =?utf-8?B?N0poR0dlL3paMS9LRkZvM09sdERKNzlGdWcyRVB6ZTIrSTFjTWk0dHAyYnNG?=
 =?utf-8?B?Z3c0VWgwTGhGcnJmaVFERXZXVXBtcVIxYTN1bS82TzRFSE1WcTI0cmd1Um9w?=
 =?utf-8?B?Y3lNTmtpN0F2MUh6SlB1Nm1iNzAvSWNvWDc2UytCN2lhWkNUSlkxaGphZHAy?=
 =?utf-8?B?UDVKR21uVm9NZjNxN2tZM041RytBdkRsKzN0bXJSOFYxSjFPWTJ5WFFkY2tB?=
 =?utf-8?B?M1ppSXVqcG9FakJZQnlsamZlR0FQOWlRT01QSkVFS3BCUncwQWdKL2JUQ2Fh?=
 =?utf-8?B?OUdQVllDL2lKekJCaHpNcU5nOXhyMTFWMzhHaDlreHZNUFloNjVFZkx4T2Rk?=
 =?utf-8?B?QUFIdFBaeW1wdStzSmdZOFhKREZ6VGdRbEtvWXNmRDdpeTdXTVIvSUhJSXha?=
 =?utf-8?B?SVkxRFZjdk05UWc0bUxJSFVoYTQ4aytHQUNYUWpwdWMzcXJEcmdDRXdNWlBB?=
 =?utf-8?B?cVRub2lZVmV0SWpTWVE2ZmQ3OVhnQ0JDUGsza0owSW56WTFESUEyNG9VblZH?=
 =?utf-8?B?anBOR2xPODVoM1FkekxRY3NRUEZvZDBXWmdxSzRGZnlaUGI1YldhRGdmWHdI?=
 =?utf-8?B?V05qSTlXMWozRkkreXUzb2xFS3BkUGxiblJEcHNHMEtRbnd1c2FuZU1PN2ht?=
 =?utf-8?B?TWRhWXM1WEtCang4d2lISGRwSXp5VGJPSWFXSm13L2lIYVdIaTE1ajQ4SmNY?=
 =?utf-8?B?MjhpcmJsdWFLMzNXaDhMK2tCclE5YjBIN25XT1NHTXB0RUlWdG0vNUFlc0p6?=
 =?utf-8?B?cHNGV1QxWTBVbnZ2SDlOWE9jOGhxbXRyYlBqVU1MS2JweVpwYXhJd3pPWDgw?=
 =?utf-8?B?TDMrRlBsUWpKSHlCMDFBZ1lWa1IzN0s2cWRVVmZ5bFNMVVRodGc5anF1dkJw?=
 =?utf-8?B?Q25mcllEbzBNTERZVDd4ZEtDdVNpV3JGKzRlcUhmRFdxc3VhaStkZWwrZzNV?=
 =?utf-8?B?STdWb3F1MXZxaC9zWUREb2syeE45V1hnU0JjVXBsMDM4eUF4WXhiVE9ubUVx?=
 =?utf-8?Q?LGLYXzjie4j4efDKoYSB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFA5bHR1d2x0LzlOdHp5akw1MUhyeDhzbmNPemtYQ1F2aks0UHJOcGt2RFE0?=
 =?utf-8?B?dGNNYlBKZFJ5d2hpYVlQRHBTMWJBM0FhQkhPVTBDWlhXR2JnRkZUeW5lckpD?=
 =?utf-8?B?RkwzQnhGSVE2OHhCdDRhQzViL1JraG1JQ1JHV1krQ29jbHVLN0w1WlRCaUMr?=
 =?utf-8?B?Ty9TNGdMOWJJdld2WGFZN0RBRzh6VDBSUXdpTFlCK1ZPOUZMVVVyU1dmNGpD?=
 =?utf-8?B?bHNVUngzSjNIVGg0dFJLeUc5YkpHb2FQQSs0cVRvanR4NWNnZTRjV0lITktt?=
 =?utf-8?B?bUxLWXUwaS9LWmg5aGFsOVUwWStiZEpXK0hTVXBRM2Y0YUl2N0FKWTl4SzQz?=
 =?utf-8?B?VU4wQnBQTVNlRDBnK0wwVmQwQ3FadUJTS0tJaE94eStJbERSeXJnSUlreVlH?=
 =?utf-8?B?Zmt3cU9pd0VSd1VXczFhYWpkUjRES0t0VDZPdHU1OWVEZFkzcTA5LzJRMjJp?=
 =?utf-8?B?N2NSTDltampsLytmLzRTNUVBamM1MjB0S3ZjWUdCbldxVjZJNXZoV3ppWFNa?=
 =?utf-8?B?TnYvVUxGRUJsNENONXdxc0k2b3psYXEyTnRrUUVZL2FwSHpVNjVCaXl2aEo0?=
 =?utf-8?B?ajRtNjJTemZUcHI3ZWo2bndrN3NpYWV5REhnc0FmRW1heHg4alhiM1Y1aU9j?=
 =?utf-8?B?VnB3NVVQeE03QU56UG84RDFTYTFzSitDMlFDSnI4MFFORHdybUVSNVNWVmpl?=
 =?utf-8?B?bVFqbXg5Wk9YR0pqMExGb0ZpS1pHQXgzUHllWldqeVNWbWNVWWZsNjlTVEZE?=
 =?utf-8?B?NE42U2FUVkFpbUZJYVpiNENocElpOTJJV2RWZnlsTUpxa2psTFRFNjNjcjdr?=
 =?utf-8?B?djFWbGlpMEo4SGVMczkySENGZ3ljRC9IWm5udlFuQjJYcFJ3S1dBcHZSbFZ4?=
 =?utf-8?B?Ym5pK2NqVnRsaU5welltYVpEZENHNmNpWklQajFwN1c1dFVYV29JYlNHNkhh?=
 =?utf-8?B?Z2V5ZDhpWWt5MHRVbXVqZCt3WWhsZFQ2M2ZXTkJiWEcxUkRVWEIvNjZEMmwy?=
 =?utf-8?B?d3VySWoveUNCaFIvVzZNOEJmUi8zWTFXZ2dJUkY4MnluK3U3T3RmN05DSjhr?=
 =?utf-8?B?V0FSOTIzNW9weThPUGF5SFdRSEFzSWZoU1pIWm0yQnd2RXl6eGxJVW4wZWdU?=
 =?utf-8?B?S042Q20xRzFRZmZyeFkwTmVkWFZoRXk1eWxDNFpsQUhDUHZjZnBuNXlLU21n?=
 =?utf-8?B?d29PNmlXWElQRnBRdTV0dkpsWVJueWU4VWpkdGNaME1VM3JLOWdSbzhPZUJn?=
 =?utf-8?B?OVErajdFVjI4YUdva0F0TWpWRk5wVE81MmpHcVl6V0tOcVBRNUZuV25OZGps?=
 =?utf-8?B?T2MwcEpaZkNNcnhBenBUKzZKOUIwUkNqc0RGanNqOUJrak5QczFHK0t5V1dY?=
 =?utf-8?B?YVJ2NG1pOXdpcjhEbFdXdWVESlRRMFhzUml5YWsvbXQxbGt4UUNqM1dyUmJP?=
 =?utf-8?B?NzhreUFETTVtczl5NW4vWjZUMDlJcDRjMklsUk1odFdKTWs0Y2lXM29DYWpl?=
 =?utf-8?B?dzkrU0l0QUxyRHVSK3pDSUh3UXpiN0xDT3hITERFV3JpVHdENDN2ZjBSNmgw?=
 =?utf-8?B?aFpCekVHUXd4Q0M0dENzOG9oZXZPVy9vcy9VSWtHeFpOTmthN2d5SndYbTVh?=
 =?utf-8?B?Z2htRHd1cG9CS0liL3UvOTNYYUx0cnBWdUphOGxhUjZGbzNnV0lUdFFlaTZF?=
 =?utf-8?B?Zm9DYVh4TXdaTW1keEhHZXBpQVVaMEtiS1VPR0xCODNIQWdMWG1aSkxEVHVw?=
 =?utf-8?B?SURXZGFJRndhSVlWYXQrbUxlaWYvSisrTDZZUXFHakxMakJ2cTcrL2N3NEdi?=
 =?utf-8?B?dzhnNC9FcnlqRktkTitqMzlLY1c3Q1FUOVhsdmF5ajZIZXVEaHZBYS84U1Av?=
 =?utf-8?B?SmthSVJxVFVyY0xXZWtPRWxZYUxuNzAyZm9GS1dpQXRTYmZyQ2ZuSVo0MXlu?=
 =?utf-8?B?M24xS3pmM0s3UFdmbHN6RUlKZ2Q5WXdtMmViaDN3cERPTC85TjhYaFR0M0Qx?=
 =?utf-8?B?Z3MvRC9jNGhzU2ZkejlkTVgxSHVHUjcwVTdvd3g0YXE1M0M2clgxUGxwS08w?=
 =?utf-8?B?eDhLRlg3d0R4UGRpdk81bjVKYUUwOFgrWmhWNG55ZXVqZGk4aDlYSnZiaHlO?=
 =?utf-8?B?aVlTZ0o0WW9BNm9wWkNRTGJmbndYZ3Q5M0dWYkNvK2hzWUl2U1poZkJMSUVm?=
 =?utf-8?B?SllVT3ZlT0ZUbWlaTXh5NTRwL25waVZHWm9xZ0ZvK0U2dXJMdmNXb2x1NmJZ?=
 =?utf-8?B?cnZBQWx3ZVQ3WExBb3gxUlViOU5RPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e81c7d-09b2-429a-55c8-08dc87b71a1f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 12:32:47.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VGajBKzxTvlTgw1v/LXMyLjr7NzCZ+ewSm1qGcsiPGpVPssuVtPrvuNqbsS3OiFwUuJs4YT3hVC3HqctKwvY0LdlZvticimvpbCPEarAZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-Proofpoint-ORIG-GUID: ug162Y2Dl3m3JFnScRQyZKiTyfw26ISi
X-Proofpoint-GUID: ug162Y2Dl3m3JFnScRQyZKiTyfw26ISi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_06,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406080093


On 6/8/24 19:16, Vladimir Oltean wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Sat, Jun 08, 2024 at 12:45:57PM +0800, Xiaolei Wang wrote:
>> The current cbs parameter depends on speed after uplinking,
>> which is not needed and will report a configuration error
>> if the port is not initially connected. The UAPI exposed by
>> tc-cbs requires userspace to recalculate the send slope anyway,
>> because the formula depends on port_transmit_rate (see man tc-cbs),
>> which is not an invariant from tc's perspective. Therefore, we
>> use offload->sendslope and offload->idleslope to derive the
>> original port_transmit_rate from the CBS formula.
>>
>> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> ---
>>
>> Change log:
>>
>> v1:
>>      https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240528092010.439089-1-xiaolei.wang@windriver.com/
>> v2:
>>      Update CBS parameters when speed changes after linking up
>>      https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240530061453.561708-1-xiaolei.wang@windriver.com/
>> v3:
>>      replace priv->speed with the  portTransmitRate from the tc-cbs parameters suggested by Vladimir Oltean
>>      link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240607103327.438455-1-xiaolei.wang@windriver.com/
>> v4:
>>      Delete speed_div variable, delete redundant port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope; and update commit log
>>
>>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 20 +++++++------------
>>   1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> index 222540b55480..87af129a6a1d 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> @@ -344,10 +344,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>>   {
>>        u32 tx_queues_count = priv->plat->tx_queues_to_use;
>>        u32 queue = qopt->queue;
>> -     u32 ptr, speed_div;
>> +     u32 ptr;
>>        u32 mode_to_use;
>>        u64 value;
>>        int ret;
>> +     s64 port_transmit_rate_kbps;
> The feedback that came along with Wojciech's review in v3 was to use
> reverse Christmas tree (RCT) variable ordering. That means to sort
> variable declarations from longest line to shortest. It is the de facto
> coding style standard for kernel networking code.

I will send a new version

thanks

xiaolei

>
> pw-bot: changes-requested

