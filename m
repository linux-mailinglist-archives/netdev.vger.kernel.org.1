Return-Path: <netdev+bounces-275321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 76ByEHyd0GmA9wYAu9opvQ
	(envelope-from <netdev+bounces-275321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 07:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BF399FA0
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 07:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A97A301A7F8
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B036D51E;
	Sat,  4 Apr 2026 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="wo4k5ivH"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023107.outbound.protection.outlook.com [40.93.196.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB27277C88;
	Sat,  4 Apr 2026 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279427; cv=fail; b=WIbOQPvV0I7adOZpEEeZ7boqpxcY5NzmH2N9oX66iRknlxQ3YeWSSbDW8MmPMoUMlcz8xVxB5TNnGI0PYQQCdlK2V4sLMioUdjBi+HcRU56i+R4YznOZ8ei4cratkh1hW/ojq8zjRCMwXuN6a7hfkbbm61kDyfrJs0etYzDCpVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279427; c=relaxed/simple;
	bh=Him/9SYNxf3704/xmsMq8EBc3b4+Anw+TCRxNjrDIUQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ByRWkf2ugH6OLQudiL7J5VT+bFUbYlcrVmWrbxRNv8734dsAXdKLsLPeRd/H53EtoA6SfT+v9w9hchGvRwW3yBeYIL+y9SPMbRBcEpARwObtu4jKi7q0MJ6BFK7nbjZ1F3HclsIxFEuZqMCpj/ef8bsu5Ir9YW6e4DspafV2Zrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=wo4k5ivH reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC3YZ482HjQ2NHr0VZHDlrd1yfquKEh38DKRI/ivoX27vMI9t6RvTG9uxiR6CAB3spVpCrFfgu2z6ii3NpuDPJhc1SJVVFujwK28qOR6GvFH0xxrmIn8Q+EhUVE0+sHdYNweA/kbH9o6lMKqBEwa23mOMnyAM4KjRi7atfii0xdz5nOujtSAOyCARFnQIej90o45Tcj+y7BMHEUZuZ/07iCsUPP3OJaeyGfn3A8sU6TuWJSKlbxuDihaxsadhRmUGMg60QrOurMqpKNLQe1Pots4HkfO89aBE6El/2y7PcU0l9L+EcBuOblv61jGNDG8SlmaGtzEWLKwuOAqUoGehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5ExwzkJJQn03TnGfoQdu3neRGWh0ULPm1Z4eYdpCjg=;
 b=XsFNZ9HebN2cWcynx/nkqasSrGnTJF9ZD9XTlbKKJIbJ8lHWXvnlIzpnf/BbelCaIimDGheV4VMU6tHVcpRX5PRAs8aFxMrAUDGJEmFRtCGDI7MxcxGNMV9x+Vmh/F61O7sTvmHekzBYAypyDfBvDYWL4RzJwnGYNQYIpoJpbB/7yXnRvLxVVRloAAEeCfFJ0t76bCr6MHpvOlAJz8scDYi7E5ay2syVvQqKaJ/AWNmXDKNDrvu5SzPJLhP6sdmc/u1k8zWab6WsLWW3yng1rJAepsiSZS+PyMWEnjY09Yn+sSXqIt/rNBA9vOCjoAlJ31/m8x3sKpYp7icbjf1E7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5ExwzkJJQn03TnGfoQdu3neRGWh0ULPm1Z4eYdpCjg=;
 b=wo4k5ivH9VosD8c4q89P2xGIK5N5Xvq0j1fOQwqvpWYEkodgJeLdIUPJBIIMlHcROi4PyIEgWEa/pamU4PC8/B361A08LY016rEy64Xg++66zyNTO2VdHw7N9O0SHxsDl5p/POx4vBhYsIWBMOhuAA0VsFh0aNxHdGsPG1RsZ44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BY3PR01MB6626.prod.exchangelabs.com (2603:10b6:a03:360::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Sat, 4 Apr 2026 05:10:22 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 05:10:22 +0000
Message-ID: <95ea2125-77c0-483d-9411-0606b5b98a43@amperemail.onmicrosoft.com>
Date: Sat, 4 Apr 2026 01:10:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260330175455.1189845-1-admiyo@os.amperecomputing.com>
 <4349e9f1668e443f49f193e1ab69cef669941c61.camel@codeconstruct.com.au>
 <0eb9a307-78fb-4a4c-9e63-fb53295b6f4b@amperemail.onmicrosoft.com>
 <13161369c80209db129c45b6d45fe121f86ad6ad.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <13161369c80209db129c45b6d45fe121f86ad6ad.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0257.namprd15.prod.outlook.com
 (2603:10b6:930:66::21) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BY3PR01MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bef2d3-3437-44bc-4020-08de92087947
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9eIj6Aw1sXWjRUn4ZlRdgRNnGZybWv1SIz221wvV3gHBuld5f2goyXTajKYBiy3Ex1aYnrVheyYKGj65Vz9Hb1izU4JQFEevfkeVps/UXAu/nP/2DsUghLPzshJt53zOtalZP3BkCe00qMjcyszdBiZAgVbQei2HWHixP4zwWgYLARpiGOS8bCaVspng3Jks+8SqTJbJNUQ8FzS8/n97mRi+LIydYfD6wy5f+JD7MXRk8H+bTYpNNlrbgwyAlajbMnehxlAXs81g8OMghZI4W95SSQP6kVRO0GiOrubzOr32KCcR5O1+f/26UoaQrhU+MinaaT+xm9N8/CY009GEwQ/E00BF8TRiq7loaLlTuMv2a0E/6Xf1MuJy70sHNl1rxLxE5MbL05Ia33md8rBedQFcH2PNUiJWZ0YW0jDIFNN85LNyzCGmgl44uTAWNibIXDMY+x1pUVphdueAbgxPDhelzGvRUBPNyb775mOkA6tre5sar8YoorhZpW3hV+wA5k6y+3XetpTsrh76o+p8sTfzojJKOcXns8eVSwS1yUzrXoo2Gbxt6FifaKDw2ivPjX7DCZiQjBdOimYeTAo9FG72G5ELOR5M7IDGN62Phc5I0Y5YC6OWwCFKqn4Uq7WQLfZ8eSWGej4An+C1yEP8e551JtHA7KoMtnQcetECiN3os+Eky4lqVe05N8C9suTP1heeDwXsop5VwGB0JuBGd3ExO44jEtBuvKRo0dH38bk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEV3c2UxbG1RbHJwSTA2VmNwVDdCc0ZYWlhHU0VnM1cxL2ZaS0RTS1JVNTFw?=
 =?utf-8?B?T3pvZ3IwdlFKM2VDdUhhcDQrNTgwb2QyQi9TVzQ2WU9iWVhmRS9YeXV3ZUFx?=
 =?utf-8?B?a0tzMkpORWVrMFBBVWZ6VFRrVm5jOGZNbTBVSmRrNEo5QVZvUHcwL2szbysw?=
 =?utf-8?B?ZHpSK0E3R3FnZWxHU3U5TDdkQ3czRy9sTkhsekxwV1Z1YU9PRXh5Y0Z0Mjcr?=
 =?utf-8?B?VWJxa1FVSGY5ODNMVzgxT1cvM1JDTWxKR0VKYjdRUk4wVXFBanZxSVFtZlV0?=
 =?utf-8?B?ZHN5SForSUluODZuWXAwZHVjaW1rdU5xS3E4S3ZtVnhLemZEVEduOWJIYWpJ?=
 =?utf-8?B?ekdzd0lKQjRaNHdnRmhpUU9nSzUzWDU3clJRRmtvaDBRWmhZdWNUN29CYzBp?=
 =?utf-8?B?eWJLaEJNSGExOUJPTkljTENzWlBKQS8zeE5nTmxKTVIvOTQrK0xiR09CSWF4?=
 =?utf-8?B?Y3EvOVVhV1JnRENBSXVnTkk4b3I5UFJZcDNuaHlhVngzd0R3YS9vU2tRa3U5?=
 =?utf-8?B?QVRaZllMMFM2bE9yaXJXUXhMMW1QKzZ4akF2allJWFRDNHFpVGlrdE1Ed2p1?=
 =?utf-8?B?STVEOEVvWndkVUMyMVZabzhyZTlFNHpabFl3MkR0ZnE4VDBDZ0hmYnFXY0V6?=
 =?utf-8?B?M1g2WlA3VUxwK3VBREcyVzVVbTQwZ3REZGsrWEo0M25jbHhRU1NBZjkzdDRL?=
 =?utf-8?B?cnZKUVlyaVh2RG9MbGlKRlRyVkZ4S3pyVVJ2UzY5UXhLcWlNcTFROFRzLzE5?=
 =?utf-8?B?OHVuVERoSFNZRHZhbE5Gc3FNcTJtcUJ1VmxTTTJySS9MWTA1MDAxL3Q0NW8v?=
 =?utf-8?B?OTk1Y1puaXNYRndCOU5GK0xzVnZSVmJDdG5oc3RDTlp4T1c1R0FiRWdXTUFY?=
 =?utf-8?B?eklyck5RVjNlVFpNa0J6U052VkhERkRDeWJIazlwS0pjUW10MnJId1UvVlVy?=
 =?utf-8?B?U05pUTFDVGpXVHdobWwyWXh2Qlk4NU5MQkJTSFlTNk1IRU9KWEJNaWI0ZGhY?=
 =?utf-8?B?M1FPbnRFTUFIbnNMN2s0V0JzNnBvWlovWUZTRkVUYjFBVXBjQVIycXp0M1cr?=
 =?utf-8?B?WnhqdG92YTNNNlU1YVdhOWhkMi9TRlRoZ0MyZUhOb21yTXFOdFk0OGVpRFFi?=
 =?utf-8?B?cFNUdFdFcWVXQ1hkVk41RGJaWnlhdDhvdTJ6U0R3cWVKRVM1ellEbGNWWFhk?=
 =?utf-8?B?bHl4RHFyb3dzVTV1RXpJMmtrK0hDaFZWVDZnN29RVDV5dFRzSDBiSGJJMTI2?=
 =?utf-8?B?eVpibkJ4S2FzM0g0TGdkTzZwVWpWUStpRWNoYjQyZlZFZjZFU2VwaFBWU2Ja?=
 =?utf-8?B?OGNydVVrNmxJb0xhVUtHUWtXR3hKa29QVFpELzVhazBKVUpWcFZpVFBmK2ZH?=
 =?utf-8?B?WHNwYm50cFB6eXMzU2lyZFJFWldRUHdmNFpLOGh6NFJYSjk0Tzc1QU9XcVB4?=
 =?utf-8?B?ZTQzRjJWaFZhd2tzZTRKU3dmU3ZmanpQTWc4VERhQjQxc2ZWZnlseVBTMUNq?=
 =?utf-8?B?YUpGTlNWaFFTdWoyZUEwSy9kQXBJZEtBeDN0QlRBcGVUK05DRUhOVW5zNnoy?=
 =?utf-8?B?Q3NXbW85THk5amJxWnJIZUQycWJ4eUFWMDhMQnNEUWFRU3pJa0lTQjhwTGdm?=
 =?utf-8?B?K0ZwM2VwTlBiTWxBd0s5TDFXeXJUbW1yY1gxWWFib1dnemZYVjFIQXcwbXIz?=
 =?utf-8?B?RnFhd2NZTUVGaHBLMW1MN0lYcy9KMGh0cFRCaXNCK016STNFZXFXVk52WXE3?=
 =?utf-8?B?RmRKNU9vOVBqREc2L2d2emxSZ2pHWDAwdUFrbHdmVDZBMkxYRmNUYkZ5TzI0?=
 =?utf-8?B?YjY3RUVrRWxTdDZVTTNWZXYrVHlDSGdENEtSV2lVQWxUOEJQODg1UjR1Q00r?=
 =?utf-8?B?THBBSldlSXlEM3pSaWg2d2dLUW5MR0NQR0pkTXZqU0dBUEFpZk9iMDdqVTBz?=
 =?utf-8?B?aEpqN0dvWDY3WXp6aCt2azNvNkhWR1pvb0EzelJEQ3k3eVVvcXRnb1dxTkxI?=
 =?utf-8?B?S2k1MkEvVnhFMXVSSjR6enpMMGx0aWJXTnBmZ2tKYnlMUEgzais3TFJ6aXlL?=
 =?utf-8?B?Yk5MNzFkT2YwTS9kQm5TcFVaVGFuTjZaeDRUeG1KSDhOaDR0RjNyNFpkNmh0?=
 =?utf-8?B?eFNpL0k1VEl2aHlJaEtocE5Idll2bVpKT0Z3VFd2cUEra1FvcHVpYlFGSnU3?=
 =?utf-8?B?K0dEQnFHQlRaSDhLc2pvYzR2OUVIOFRYUFRZMFVmUTZmYTdsRWRNQmNCVTc0?=
 =?utf-8?B?ODJWUXVHbTBTK2ZPQXNnZFY5MXUrei9mRk1sTUd2YnFMUFNYOFZlUloxZUdJ?=
 =?utf-8?B?U1ZCelBicGx6S05XbDdzV0M0ZkZvUjIzQldidTNpYXpUNDNRcGRtTzVpZkpP?=
 =?utf-8?Q?3+Mxtqb4AynjVarJQ42d33G/k39qAK/qVEouoo/kHfLsw?=
X-MS-Exchange-AntiSpam-MessageData-1:
	6FEAt/vgddkX6S0JuZCak3dE++ajwmaEcvbzl8gFszYUZCejUBYNc830
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bef2d3-3437-44bc-4020-08de92087947
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 05:10:22.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxwOQuGsWrAIcV+H8ZG9oAH8RsbQU+zPOeYvc18NOS9djIY7a/T3ht5EyC4jleoft3+y4ibmGroeHsffEbGe/NHFXI8I5q4C/7xHoMQB/rZbp75xIOdsyActGwp/sanf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6626
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275321-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.934];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 9B5BF399FA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/2/26 21:30, Jeremy Kerr wrote:
> Hi Adam,
>
>>> On the latter, could you expand on what happens on close? Does the PCC
>>> channel end up calling tx_done() on each pending TX during the channel
>>> free? I'm not familiar with the PCC paths, but it doesn't look like it
>>> (or the mailbox core) has a case to deal with this on free.
>>>
>>> Maybe I am missing something, but could this leak skbs?
>> Yes, it could, but since they are held by another subsystem, and there
>> is no way to access them, it is safer to leak than to free. The Ring
>> Buffer in the Mailbox layer is not accessable from the MCTP Client.
>> Additionally, there is no way to force a flush of ring buffer.
> Sure, but it looks like the messages are essentially lost on
> free; a re-bind will clear the mailbox channel's msg buf.
>
> Without a mechanism to purge the message queue on free, it looks like
> the only leak-less way to handle this is to keep track of the pending
> skbs manually.
>
>> There is a potential for this kind of leak even if we were to transfer
>> the data out of SKB:  the two options are to either leave it in the ring
>> buffer or risk a use-after-free event.
> Neither of those are good.
>
> Where is the use-after-free here? Once the pcc_mbox_free_channel()
> returns, the pending message buf seems to be forgotten, and so I can't
> see how any pending skb gets referenced.
>
>> Bringing the link back up would immediately send the
>> remaining skbs and cause them to be free, so they are not frozen in
>> perpetuity with no chance of being sent.
> Same here - the mbox message queue looks to be reset on client bind, so
> it appears that they wouldn't get sent?
>
> If you do need to track the skbs yourself, that could be fairly simple:
> keep a sk_buff_head of pending skbs, remove from the list on tx
> completion, and skb_queue_purge on ndo_close.

OK, I can manually traverse the ring buffer and free the skbuffs.  The 
ring buffer and associated fields are in the mbox_channel, which I have 
access to.



>
>> Whether the backend could handle this is a different story.
> A cancellation callback would be handy, yeah.
>
> Cheers,
>
>
> Jeremy

