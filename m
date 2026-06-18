Return-Path: <netdev+bounces-300367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kiAYCtK0M2oqFQYAu9opvQ
	(envelope-from <netdev+bounces-300367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:05:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7969EB16
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:05:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=QjHEszM7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300367-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300367-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E183C301530E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D557385D98;
	Thu, 18 Jun 2026 09:05:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA2384CFE;
	Thu, 18 Jun 2026 09:05:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773519; cv=fail; b=ZFnI8n/6xlVo6px7r7/+reTAX5STaxkk3A1ZRK7M+uQsh+/8UKAtRLwDHSy5D3o4DNNFNlR1zrz75D9hM0LEfggIgpZgo9vxUwxTwIQLPgkScq5s8siN4OiJ8Iq/ZscEZP62dcw1I4o/KzfK5T/TMbwKlJUFHLSDWxZkEecv1ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773519; c=relaxed/simple;
	bh=HxyHXFhkuZdnBUax5uV3noz4xDYiQqJsr0va4SrT3uk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rL0/GXJoUil1inwO1/MKN44hDfnDSgbaF0hGHQkRJIP+GwtS1UpF/CLSohaXCq6EY0I8bGgMckJlt7OqKX/YHqmjLN4Rq/WvUGCzEqglAxiITyksMB/RlvQYIFfWHQZauNncnNY3/tTl12el33QyMfX/YqRjMLmTnIj9HUJSYAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QjHEszM7; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8bT9f3942942;
	Thu, 18 Jun 2026 02:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/S9RJPDGoUeAcK7VgugBVXWO8uHbbBfDuXubyTM4rvk=; b=
	QjHEszM7VtL6EDstjhLvJTmT0vKx4BOHVehxJ6C8s6r/eUlPox29GBkytDQeAXKH
	b0AgNOk/WWVVx/wzQHJyvhN6ETI1VwagUKpnoTO5PRM+ALAE2QnhXkw/z+pjEbch
	fVI/1E6ntFuoyA+vg1MsfdKsCQHn/LHlpmc9C1t8qKJGVdRoqgLf5snKE/h7rjoD
	fBJDcIc44XfsZYIacU7f4ioIqWOHQosRhcV5+uHrU3MyVbu7M91V5HZHWB4MlqIl
	AZQpHC3oZoXo5fphq9goiszySSgtW+WUq1fcWhZtTJ3YBlSlj5XfgYGl8MaEd4Uk
	CuJbrhrD4YuRID3jJ2Wqug==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbtd82-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvHO9nhTDUQQ1f9r5dgGYmRbBoV1FtEYwA/Y2ApLbzVPp0ZPdKBDPHKkhQYxhfSFG93uivlq6fSYlcLxIhwQ+vUbiDYmjL2hlkMwsN37htp6PufTntDEbzWQy3P0AW2Q8a2YHfU6ByNkpsLIJiTROwpWg1v3hsRUbseheKNE3tJQRns8DgngoraDOaDgYsTqlxKgqJzo006BinVCYtaLgD6kdoptNb2JMo9uMm///Ip2ZU+u1cYMmlSL4tfJug0/oYiLgqVqIjtSqSItfkg2Y9eWyx+yZaMQjz+B80q9O+oq7gdrbiC/cozNdGKiKjvNSYm9GjdAq6XkAGyI5lbExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S9RJPDGoUeAcK7VgugBVXWO8uHbbBfDuXubyTM4rvk=;
 b=IsC9b3rOPVfeiNhj2GEkdfcPBDY25LuROnx2BHgZQZA4/A9EceSoOEn7fkQP0rtd6obl6e1o8MJHuKF+YprGH9u5jcbB03iGCD1sv+9FBh/Dh0KyphWEQtzb58G4JnCS90hYK0Lg8k+/mEH0bgQcJl/zpu+J0WCx7Yzbij7BTQqpYz4l8IZfqK9XyekUoKEfAIpf+k1XNClrnsKQh3psEh+jAVwR8GAQfAKukoqylTH26m0nIomgoEdoz9Yyn8bFtB0MOXfdBdH6/sN5gKLTITE/SfkQLLw7VnHxA3ocYEnaiGZSULaYSQxbDq28rGNL0catj+35RZwcM1Aay3KyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:03:54 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 09:03:54 +0000
Message-ID: <f8e05c90-fcab-4ee9-9595-1c8150a1a747@windriver.com>
Date: Thu, 18 Jun 2026 17:03:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
 <95249596-5f05-421c-9c8a-693c7b26c4f6@bootlin.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <95249596-5f05-421c-9c8a-693c7b26c4f6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0048.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::14) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e00e6da-2eb9-4047-fc02-08decd1885d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|11063799006|921020|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5MbLujimEOmkVGtlhj8ZAVj6ILNGFrU/4OEUwKyMzFyEDbBTUJmZF17bTGjNyOhiklQWBe147Sf1We/eksMRYA11kOQtsI6AlvNx8oI+oJJ8KO0nAE7De52HBlwwyUuy90iQMxW38TPbpHi1FW/G+EqJwDjg4clHXtTlw0X2Om7QUX8+4fDUVXbjYze2/rjxO/A9e5BSiyI2CBANnMPpeIXThrFed20LMzvgy+BTaIXYRKZ7FkKiav7yVMs2RT8SV7AuIEv3eUi9eL3NdlvZYvjpsc0GSM4PwT4pTFSGRpTkN5v2x3Ig0KD6QVn9x5giYcX8dtpx1PYWnyTs517Y+pSc3/2TBckFxKZ4dO6ArNZSNkeRzcgkZ2rnOr+wy1lcap+f4pUkSGzHodCo06CGRVb+p+TxIb02jQ5TNCKU2jm432zO8S5YDVqJRWbUwZiji84J2RFJUSR+ZlqM6NR02ESpsk4e6e5GJr4QWdN2emeBnDkuGXZKl4uaCHx+OolzKjHuwar9oHHKOgLVx2DbyWKALVpgIiIPrXYueIxsNSti4+JSVo6yJ037g7GkYWxZQBfzpRljx17Xq2yRDA37By0ax7qGM+WuDldaKr5+xn3q8ztymqfD+C3RFi23EiDKXG+doZHf4eLC10WDjdbZe++5bFcILJUUGGKRKRS/oDTeDcK4hDvZ58nbBHAFjML4i8kg1r/5cFz/gsVKioDYTq2bI86GqrjSBQ5wPd74FN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(11063799006)(921020)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm1HR2JTM2d1ZmxDeDdEM2JMb25NSkRObVNYYnhmcnZ6U0hKVWVpRGJhZXBa?=
 =?utf-8?B?TndoYWUxSm9tdkZYUE1BUGw1d1hPWWZ1M3h6cHZEQWR2Nyt1ZmhjVGZHUkx5?=
 =?utf-8?B?Y3VlNmNpc0tGWW1NMFVLV3QwUE9yMkxIQWhuRHBDcEJNRk5OUGRqYVFuRlY0?=
 =?utf-8?B?T2lGaHRveVJkYmN6Q1FQcTlOWmZiYll4ZnhBVGdSdkZ2L0crditORzZwSmZn?=
 =?utf-8?B?NEdJZmhPV0RCc1JnaG5XYkJ5dCsrNW1pVXlvVitSR0dzY1pqdzgyRE5RSUV2?=
 =?utf-8?B?M3B3ZFAwMFhoUnJOWndWNWR6MzRRMUpBM2JEUE56VmE2NXFRanhYKzhOZFA3?=
 =?utf-8?B?YkNGME5pOFRnRXNmaitnOE1DUjJabHQvL1U3dWtkM2JjK1dTVnhXNUFrNkJl?=
 =?utf-8?B?WHh6cW5IamY0Sy9OVXlBbDNpUWlKcVQwNkpURDVuZ0RkS0RPTm9kWCthdjR1?=
 =?utf-8?B?V0l6SE1GUUFqRUxGaUtPMGNLV2swS01WOGx3WVRGZWJnbjlDZ3RsWFUrdzJQ?=
 =?utf-8?B?SWtKZGtxSUNhaE44VG5CNUtGMjNSUkFOeDR6eUZub3dhZEFxZ1B0ZzZGVjU0?=
 =?utf-8?B?RnlPUmxSK2M1TzRFS0tKalFUdGFMQzU2NkNFUTJSQWxaUnpBQmZ2VHoyMURy?=
 =?utf-8?B?ZjVCbVFOYU00VmpxcGhRTEZDQUpDSDFlbHdGQWl2TkZsZm9uQzBzbDZocDFa?=
 =?utf-8?B?dDhzSUdScU1jR09JVm1JUEdVeEplbnFDek1ibXIyM25KbjBzS214ajZubjdR?=
 =?utf-8?B?TjZ1WlYrRU1DWTlpK1llQUNpdGNuRmkxSWJLYzNubk1sZUJBV0VWc1NkQm5h?=
 =?utf-8?B?V2s4Vk9aODRZTWgwWk5GVUM3MnU2SHFsbHJsdE9xalZ3Zm9tS1JiYkdKV3Qr?=
 =?utf-8?B?WUFkd2JWM2pyR0V4MFBwT1p2RVNMRGlFSzNmQytnSmM1TW9QeUhxVHlmcGhJ?=
 =?utf-8?B?QmRIQU9JS09TL25xcFdMbVNDV2N0TTZqZUhvc0ZvOXBYM2h1cFhpSm55Qy8z?=
 =?utf-8?B?TnhDMUZBdkZ0ck40NWNuWm1rNURaNGQ2dkt1WXRKd0xMUG0wbzE0azFFTlZN?=
 =?utf-8?B?dCttbitJTUJWaTZFR2FsNFdEK25tK1NCOVRnc3JJWUREb1U3VGRUNERlUWZv?=
 =?utf-8?B?VjdGVVJqQnZ2U0dWTFVsS0VmVyttMCsyemJpNzdFVXhVVjBqcE9PTVlUSnNF?=
 =?utf-8?B?dlN6ZXZLOERDNUUzaHo3bG1WSkx6T2RVd09hUGFJQTE5R3FEUVVibkpTRERK?=
 =?utf-8?B?VU1CS1pWTkhxaURSQnhNazI3Y2V2UVdUMm4remRFRlNVWHUzRWZBQmxPb1Zw?=
 =?utf-8?B?Mi9WRWJVS1ZCRDRJS1FVZU1rNGgreWhqQ3NxdTgzeUFuT01uUHVHT0RhUVVJ?=
 =?utf-8?B?ZFU1YTBnWXRDR0NBTy9Wa0NGM0c5UmsvVHZ5bWlYWitWTnRZRzdNQlFSd0Yz?=
 =?utf-8?B?ZXhvbGNZOURKV1pnVkRoVUNKL3M1ZE52RTg2VVdvdHY5eTBRMlZ5dldMRjRY?=
 =?utf-8?B?QVpmcllGL3hWNjE1K2FXS2k0ejBVeDJYQitXYzdCbEwycDhCM2pBRG1tb1kx?=
 =?utf-8?B?c2lGb2ZsRWtxaHZmeDVSbVhWWjNhOWw4eXZPdHBJbzhRUW5OVW9IVDR2N1hs?=
 =?utf-8?B?bVM0bnAzRzF0NTFEdXBEMDNFUGs5SUhwbXREMGx5NWtTQ3ltTnU0SVJhQWJK?=
 =?utf-8?B?TVcxWEliYW1UeUlXQ2FjNmxqbmx3M2hxd3EvNVN2bmhoTnZRcXRzVHg1eWVp?=
 =?utf-8?B?SnpVVHNlbWFBenQya2RDaFdGdWh1WHAzcDdNbGRDTXZmc1pOOVcvMnJkVnRI?=
 =?utf-8?B?bVBqckhSQlZGdmZmeEExc1EyejdaUFFzSDNCRkM1VXpkWUwzTWdudXRrUWll?=
 =?utf-8?B?eTZvYzFieDFBdGp2VVhiREFLejZjTUs4ZDlOVFJBMmJtUjV6SDZsZmRib3hT?=
 =?utf-8?B?UGZmZ2RVSjhxRDNIbmlpRUFtbzRwaDdtZnJ4Q2EvTWlkK2lFY0phZ2FqcS9q?=
 =?utf-8?B?aWpzSkVHdEtoWEZRbUlpQUxNbG1NSkxnZmhZQUR1bGhoSEM3bUtqc1huY042?=
 =?utf-8?B?ek9hVG1YYUhHU1lNMkhNc2FTTlJsMlduakJwVU5IRFZMRGlCSFpQMDV0SmtZ?=
 =?utf-8?B?eWxFZi9JSWk0ajNPTFRYM1BEb2RHZkVucEhwQk5wLzRkb2Q2M051NkszK0Z3?=
 =?utf-8?B?MHRtOEp4VU56TXZFVWlLZC9FeVkwdnNtYWNhcTVMWDR3NTYwRWxZZXBESWZz?=
 =?utf-8?B?YTdDZUxEUE1zTkxIV1ZMSDc3ZzQ3K1FiSjlxZGdTUWlMZVZiU3BvdkpFcWcz?=
 =?utf-8?B?MThKUkZsSlFvbzZBcys1dTlTY1kwUllSMVFaNkpTeWRNMm54a015UT09?=
X-Exchange-RoutingPolicyChecked:
	lxzOu5hsRbzwqU7Vy/+t8ee/C0SgPWPGi82OIKNFtDQ1M40H7vDfSWlAAXUsyGsuA/47eC6/SR3xYlwPjicbTGrZVJo93w2Pp4XuImf6wroe3GT+cxS0MBSZgPfI7uXIht1h3krdN2bSpsRMcQm5sawvmw3JYTDrG07uHr/Bh/e0L+d7+m4vKAysSOg+YSWrWjnJnn/LNmwVOErHgcX5hGYeNgdSfgpq8voVjZru/tO23NuOJvRl6tFrUfgzdb/hQiBcOPV4Q0i1+V/7zqlFRehvk9sKta2BRoSkeFOaJb2czv5vdFoh6KElq9emCr6yCi9l7klcY3lMuGv7PgrIFA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e00e6da-2eb9-4047-fc02-08decd1885d8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:03:54.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5r687ArBXOl1M4Vr61RJkP64rydMkcNQqg0/kwQpvlDtdw9c7hQ+GH7NY+UvrFlnGOZtVY9nLNL+yjjzdi++g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-Proofpoint-GUID: Y19BrNgZDetV33KyHdxRKTKG33aBnYSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MiBTYWx0ZWRfX7C0BW0JdkJq8
 COLWdhBq4pfCzXmRSKSFgntHXw7be5GPkiPrbaxxcio+ucjhFyJAKfC39VMGkcNvLvE4uE7CqM7
 v03uNDdc97C+iKlFDsjbv0VF7K4TgzvUCU/by+ezx5TyoXQAfIJl+NRFxQ4LbfSfK5jMuQR0BtJ
 tXbhNYv1gAw8DN00rKan1EiK8V9QEktKEtV6avMVCu4y4IsHXcgTB9los5w89tn4DnjFvkR23FI
 Utk5oSwAKdaC++afyWwNoqgAPyAmg86usojs7eSGKTXwHWhBlLQEMksBNljDD/Oi6ImNwu3zudD
 FAkATbaPeqvs6ygXjq/fm/qT0F7SsPZVOWvuvl3njIm663jQbFyS3bFQcrDFtv/bkI8vJT0TtiQ
 N26BeF/5wngNrq53ADZg4cI2O40esGo6vRe25dLsJFqDGDLpHAFG7bKEahz6PD3TsMh38ZUqeNl
 e6GiC05xZNbZsSxShtw==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a33b482 cx=c_pps
 a=YK1kdmGH7fNv6t6SzNeZuQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=ElefQwueulpuwU34Wu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y19BrNgZDetV33KyHdxRKTKG33aBnYSm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MiBTYWx0ZWRfXxgZENBefXULV
 SAPobjdGhNTKzhhJMfB1GrTZmFAxoN5MXzbIm3xWubPfBXAxohUk+tltGORsvou7UfUfVe4cr0r
 VviZf3i5XjGua39VUpbH180FKp9+k6CXpuJ7zC3Li33DeEiVLZPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300367-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,goodmis.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,windriver.com:dkim,windriver.com:mid,windriver.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FF7969EB16

On 6/17/26 20:49, Maxime Chevallier wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi,
>
> On 6/17/26 11:20, Yun Zhou wrote:
>> On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high
>> network traffic, the IRQ can enter suspend with desc->depth == 1
>> (masked by the oneshot mechanism between handler invocations).
>>
>> During suspend, the kernel increments depth to 2 and masks the
>> interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
>> due to IRQCHIP_MASK_ON_SUSPEND). On resume, depth is decremented
>> back to 1, but since it does not reach 0, the unmask is never
>> called. The MPIC CPU routing remains cleared, permanently disabling
>> interrupt delivery.
>>
>> Fix by freeing the IRQ in suspend and re-requesting it in resume.
>> This ensures a clean IRQ state (depth=0, proper hardware routing)
>> on every resume cycle, regardless of the pre-suspend depth. This
>> follows the approach used by other drivers (e.g. igb).
> This description makes it sound like it's not really a mvneta problem,
> but rather a broader effect from  preempt-rt / irq management / suspend
> interactions.
>
> Is this the expected way to deal with that ?
>
You were right to question this. After deeper investigation, I found
that the original analysis was incorrect.

The real root cause is entirely within the mvneta driver:

mvneta_percpu_isr() calls disable_percpu_irq() to mask the MPIC percpu
IRQ before scheduling NAPI. The corresponding enable_percpu_irq() is
called in napi_complete_done(). If suspend occurs during active NAPI
polling (between disable and enable), the MPIC percpu IRQ remains
masked after resume — mvneta_start_dev() only restores the NIC-level
INTR_NEW_MASK register, not the irqchip-level per-CPU mask.

The fix is a one-liner: call on_each_cpu(mvneta_percpu_enable) in the
resume path to ensure the MPIC percpu IRQ is unmasked. I will send a
v3 with the correct fix and updated description.

The previous free_irq/request_irq approach happened to work as a
side-effect (request_percpu_irq → enable_percpu_irq restores the mask),
but it was fixing the symptom rather than the actual cause.

Thank you very much for your rigorous review,
Yun





