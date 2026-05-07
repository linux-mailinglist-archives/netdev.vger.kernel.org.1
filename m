Return-Path: <netdev+bounces-285481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HsuKM3x/GlmVgAAu9opvQ
	(envelope-from <netdev+bounces-285481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E9C4EE42E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CA13034B27
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F236998C;
	Thu,  7 May 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="JNKDeMXB"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023101.outbound.protection.outlook.com [40.93.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1535F60F;
	Thu,  7 May 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184650; cv=fail; b=Wp/U4iFnz7bnuOexzC94X+T9USthTFGZHyb8zuNvJaQ2M0cvBcwMrSGcl9eTmK9Jlw5MrLITIl/Ux4gWpb/0faNv09MiZ43icDB3A8QFrR0Fc+KuHDuxJD7YYqAsm9c3wZsK991rSIdguJT0ZxgzvimVJ1BiPX2G4Au2WcwjR0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184650; c=relaxed/simple;
	bh=PbBTlsbFKBHJPRtr/WMt2DzLZyeg6cqZlZ0YV0Nory4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1RzqHBcU3Tq33qI/CXIKGRZ4p5GHdCUdjPxyg446C+5Q+rTeYmB2psiM3qd9zUcjGWTBuBh5Yiv7ioTZSARwcaZft99uS2PWd0GQUFn2a+gMqFx+KVaPnezrP02lPWrQFTLakzbnJ6nd56VBLMZfozxn65jq+B705yX42zeXi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=JNKDeMXB reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP/Ix+srZZXJHPjm9eAymVZ99eMc5u9ECtBfPzwwuXF1YlByCwtZg9efCOqRb3P5Oc5rSY61Z2ZWyf5/I8oDb+B8arn7N8lEBQQcHASsqrbxRPqkvUptLQCxOV0+PRI4PnSov4RvQmn42QT73wzSCDxgINQg7IwkuY94zo7sWEuRCTjX6pWUKgVRAELz3rYmD+WiKX2C6/BFKhT5PjBVBf75ODf92V/I029kvF2spkmpMSVy75ThwXxQBCiiViYNm8WVLAOUOrtsEUxu6XvRcEr3fcq/xXs81YOpi2IuWZXgILFvbYwdTkSrBZNmlFMMdW2P1fLXNENvRIpPFyPEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5++0U4+fwgm7kErpRLiEgslAcdcEZzLBg9T3Lt2RV2U=;
 b=cTvK3QCYNdoWuQYO3W5bjsekwwnki87AMVE8Dcmab6QqljxVtcWxYdjPf/EiaiGEw1XbNzwO5Mf8R0y+5vBwY6zmVfs08HfX54x2d7pxJxxlKSpSxC14VNbeT5x+iAau2tJcbiOM4cSHYtZu1+lV+VWdq5XO9yZ2fYivDhv4sksWv21aFjfA+vncMbmcnKn8ZTaKfjUCN54AYK1AkmkH1FsIb2vLwHwLexkqAmFDz2WMJD4rQ1YpvpvTN+u+B4jJxzJY+FJdaevn9gPwnOi0imu++fwoTxjr77D+MWJyhFZBuXDKJueG7qNhfbynWaT6Kk5NRI4eqHJ/+j4wI9Of4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5++0U4+fwgm7kErpRLiEgslAcdcEZzLBg9T3Lt2RV2U=;
 b=JNKDeMXBdk5uMiFOlmA/bvsf5B0OsVQ3UFK7NE/tzZnQS46qJ8Dmd+4VDxADGfhcrx+vRJ1JVjP6ak82HxvxEEsldFWWgqyKmoqE6EZCc+w7de4E9pG0iMA8rUWcrXqhU51L4XFMNUpMPNf4oT0UGWkM3s2w43vIaQwMfRE8Mf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7490.prod.exchangelabs.com (2603:10b6:510:f1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.17; Thu, 7 May 2026 20:10:43 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 20:10:42 +0000
Message-ID: <9b8f8cbd-9b94-47f0-a4af-713060d9aef1@amperemail.onmicrosoft.com>
Date: Thu, 7 May 2026 16:10:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] mctp: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>, Martin Schiller <ms@dev.tdt.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
References: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
 <20260507-getsock_two-v2-1-5873111d9c12@debian.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260507-getsock_two-v2-1-5873111d9c12@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5f6fcd-bbda-403a-1173-08deac74b759
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UQOT8sE7D1WUArX6XpblECH3CHIoQvr2UQTUargmjZOqw2a/vSZxSvyUPpQS3CYqKAjMKCHssDjrc5sqXnOTerIV1U8WdV+Yn9z/i0motPmWe/YQPQOAAr2u+waFvbpEF8yQ+sDIC+aIAQJ04svd27r1Qze66YLYXx5TS4thOHT2L1/E1Dna0TU+CXxfC12p7utRpsev569AwM0Gvjlzg5K3JpgcYUVYgwp4Z3zD40rkJT0po53RVWY3ralEgJxzYsFhP5ee4esbvCGsApuFXyRTwPM17FCGBvL6Mf3GGsy5GbU9brY8OFaUg6yPLZME4oLMTQRM8ajpQm77xw9cLlreRRZKNaH/3d8PGFIiA1uDU1ojWbMyv05xYM9osfds9RCaCZx47Cha1MVZA7RiNI580EDfcRiZHwX2DDiwA6mS5XYexBYtN4n9X/d+0BdxPHx/MS+G9GHnK5jYsdeM37DTOLcLy3hFKg/W40WHu/KWJxZCdKk/LsqNiha0F+9QubgAmehjtwiV3ied/godfbfhUHA8PotvavHanxFlTJEKDqDFL+hJwJUK7Mlzj0JPlhLrpxkQzqQegvtUxXp3TK4Fj+V4Ww6mExeSfoKq5HqzpqEEyHq2JJBgH7doRgOC03NLHrQ+SsszsBju4FH6jaWpttuS7HkvpV2MxYHrpmFsJUH8G4CF87SdEfl8VroID1Mp/9yz5uSPV+gEmVIp+Qscb47eEpqRwYaE0/i23E8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHF2YVRHNGpSS0RRdGZKVmEvcTBMamcxay9wb3h0UzBYS2tvUVVhd1hNUmNQ?=
 =?utf-8?B?ZGs3T3JzRi83R241cThGMWxSeFBkdU5ReGEwTUdjcnJ1SVZsQmFFcjN1bldF?=
 =?utf-8?B?ZlpPQ2szYXA2R0xsdExTTUVzTE9Eb3RxZ2RrVFJzNytDaDUyLzZzMWV1blY4?=
 =?utf-8?B?eW1CbEx3OC85YWh3QUtMUWIzNW1XZlVrT2NOd2FhVlRQdVBnUjhTRnE3Tkxl?=
 =?utf-8?B?WjJKYTBsL3JFVCtzcTEyZkZyUUZERlpCcU8wZEY5REdTbXRxZDFnWXdlRVAx?=
 =?utf-8?B?UnJyaGhJSUd3WndCL0RBMThvTEhoNVlGZFRzR3JuMXo4RlhKelBLaUlWb3Z2?=
 =?utf-8?B?M3gwUkNIV0Z1cEZ5WEFXK01xRlEvdVMyRTRvNGZBUFF4bFBuZ0k1d3lLSWpj?=
 =?utf-8?B?eFJlOXlmbmxJTkU3Z1VmR092MkdKT0QvSjUxUGxOSFNnSG50bkJyK0N2K1dL?=
 =?utf-8?B?UTlLU2lUU2kxcmM2VC9JUUJvazFaOEIxOVM5STQ1VnhaNkdhbVJIWXJqTVZp?=
 =?utf-8?B?MXkvNFBiS3lUNXlqaGN0ODcyZlJpRERhMXRoVTBZTG52eXV3OEx3cmQxdTlL?=
 =?utf-8?B?aUJtQkxoK1hYcGtReVZld0FneW9vTjBrby9heGJaa0ttbmp5dk1jMjIzYkpL?=
 =?utf-8?B?QmcwY3ZIektrUFNhMmhHRVJFZnhCNmMzaU1qYzFBWUdTcUhNajFLR0kvbGhQ?=
 =?utf-8?B?ZzJ2V2hZS3hpRG5zaEpiU1Z5TWJJRUJKUmRSdnZQQUY0VnhlRVR4VXhFRlo3?=
 =?utf-8?B?dWtwdDJBWG5TVDd1d1ArQnNGR1hvQjlFbE5CS1hEZjlId0JSRzJYV2VKREZh?=
 =?utf-8?B?ZDUweTZLRVVwWVBzZk1iVzJFcCtqamE4RGVFUndwUmp6MHBTOXpXTTljN0Rz?=
 =?utf-8?B?cmNmTnFheFJBRERjV0M3U0NKLzN3WWhjVnc4cHBHR043YTVQbXE2K3Y3VG9r?=
 =?utf-8?B?aDY0UWJiWnE2eWV4YUI0Qy8veko0N3haclpQekF4V2NLOTBPYXVmaXZONk1S?=
 =?utf-8?B?V3Y2anZLdDlQdm5XejVPRjdPQkdUNi95K295SEJPcCtyVFpINUttKzRuSzRh?=
 =?utf-8?B?eko5Y2RZV09XNkxaTXRZMlZLZnhWM3dwR1N5aGpBcHc2MG01L2U3Ny9kcjBz?=
 =?utf-8?B?b3drSnVCbEV0S1hsNUdPS2tQSm1IckhXV2F4QTlPcXNGejAwOFRKNnpvT2x0?=
 =?utf-8?B?NCtuMGVraHlrajFEN3oyLzUrZTVpbC9pOUVnQTEyMzRRNGkvWlluQi9sZEg5?=
 =?utf-8?B?dkVIS2VBOFpCT0VKaGtSaFRUano2WXljVEtVZWU3SEVPVGRGWE1hQnY2R1NQ?=
 =?utf-8?B?NXR2UVpOdzZramNHb1RxN1k1L2VrQU1OMUFPR2ZEc3dpVUZuaFBKN2lpY2hN?=
 =?utf-8?B?Qkg2T1Zid0N3T2g1bm9MVGw1ZXdQZkNkMDA3Vk41cG9rK04wU3JPOWZNTHRv?=
 =?utf-8?B?Ymd2SE1IVURmVC9Vc0srN0JuLzhWOWtWb29XNFU0R1cwczNzMmd3NnFZbk44?=
 =?utf-8?B?WEM3aFFaYlB0SkZCOXpROTJ4RVYyVmJOd3hrSWtyZHA1UlFkUlFOQktoMS9m?=
 =?utf-8?B?SzRHNEVqTFZodHg2R2RFWEE1U05pRUY3SnFucjgwV2FqSlQ4blJKby9Zcllp?=
 =?utf-8?B?c0hjNldmY0lReU9SWms4WGFlWG4rcjl1RFhCUlVQRy9Tc3dhWlFOV2F4NEdB?=
 =?utf-8?B?VUdFODRpUWxIdDZLY3J6SWRESjFHeXFZTGxnTUlKalBJajZ0UXprd2lTYjVP?=
 =?utf-8?B?UFVkeC9SWE4vRnlHa21XVnFPYUVTSHQ0R2FMdDRCYnlvRG5zdG9yOUNrc3p0?=
 =?utf-8?B?T0dDbFhvNjIyY0tTMzJFakdSRUdJc3NPYktrZUVYZ1liTWMzbktEQ1BqVXRa?=
 =?utf-8?B?ZHZMdk9QeGUydDFyZ056QlEvNjVqY2d1eTBBbkdneVdyTjZJMG5ORWxWd0F2?=
 =?utf-8?B?bEI1QU51dUdGQk9xcmJrejFwbi9JZHBlRXRyMnJZd3B0aWxpMVRncy9KeGQ0?=
 =?utf-8?B?U3B3TDhlYnh0UzdORE4wdHd0dnpJNHRmQkdsTU94WnZGSzFrRkxTanJ1Mzdj?=
 =?utf-8?B?Z0F5elkzbW84NWZYYXFnbTMyV0RZeVpOOENoalJpaGFyR0hnU2FmbDIwU3lE?=
 =?utf-8?B?Q2dWUElkemYzMVlXZGpQQlNuVG1mZURNSC9INU5BUjVwbkZrcXVQL0s1MCtP?=
 =?utf-8?B?VGR3VHZUQy9oN2dQTnN6bzE2aWUwOXB4WmtjeDRBckZTS3RFMGZ6ZzlvU0FW?=
 =?utf-8?B?UzFiS2YyalJNb1hZQWp5cE5mVlN4STg3RTlranpDVW1iUUdJRXJmSUVnQ1or?=
 =?utf-8?B?ekdTVHUwZE9XSlNSK3RUSDRqYmlSQlJHenlvYzViYnBBN0FRNS9aSXlyenlJ?=
 =?utf-8?Q?rEwJNLY0gHsnrEfjmndRsm/3Sv4BA6v4IgVLI/p9vDsj4?=
X-MS-Exchange-AntiSpam-MessageData-1:
	9b+6gwuqJN15V2uYmwv4gEDZjjt2GfJeG5XtaDx/0H/n0iVn5EOm9RQk
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5f6fcd-bbda-403a-1173-08deac74b759
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 20:10:42.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/U6QnLa90M637M/o75KLocz5lp82Dv3QQoOVEklvgaV8ajTcVTSUQZofEVJShimccgUEeUjKx/2Pjj/XdDKL0xz/BKm07aVDi0bC/7LCACWOiBhN5de433G3EIPK1Dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7490
X-Rspamd-Queue-Id: 10E9C4EE42E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.919];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_NA(0.00)[onmicrosoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-285481-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~]
X-Rspamd-Action: no action

Why is this 1/5 and where are the other 4?

On 5/7/26 06:57, Breno Leitao wrote:
> Convert MCTP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
>
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input)
> - Use copy_to_iter() instead of copy_to_user()
> - Add linux/uio.h for copy_to_iter()
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/mctp/af_mctp.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
> index 209a963112e3a..8af5e2b3c8d12 100644
> --- a/net/mctp/af_mctp.c
> +++ b/net/mctp/af_mctp.c
> @@ -12,6 +12,7 @@
>   #include <linux/mctp.h>
>   #include <linux/module.h>
>   #include <linux/socket.h>
> +#include <linux/uio.h>
>   
>   #include <net/mctp.h>
>   #include <net/mctpdevice.h>
> @@ -405,7 +406,7 @@ static int mctp_setsockopt(struct socket *sock, int level, int optname,
>   }
>   
>   static int mctp_getsockopt(struct socket *sock, int level, int optname,
> -			   char __user *optval, int __user *optlen)
> +			   sockopt_t *opt)
>   {
>   	struct mctp_sock *msk = container_of(sock->sk, struct mctp_sock, sk);
>   	int len, val;
> @@ -413,14 +414,13 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
>   	if (level != SOL_MCTP)
>   		return -EINVAL;
>   
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> +	len = opt->optlen;
>   
>   	if (optname == MCTP_OPT_ADDR_EXT) {
>   		if (len != sizeof(int))
>   			return -EINVAL;
>   		val = !!msk->addr_ext;
> -		if (copy_to_user(optval, &val, len))
> +		if (copy_to_iter(&val, len, &opt->iter_out) != len)
>   			return -EFAULT;
>   		return 0;
>   	}
> @@ -639,7 +639,7 @@ static const struct proto_ops mctp_dgram_ops = {
>   	.listen		= sock_no_listen,
>   	.shutdown	= sock_no_shutdown,
>   	.setsockopt	= mctp_setsockopt,
> -	.getsockopt	= mctp_getsockopt,
> +	.getsockopt_iter = mctp_getsockopt,
>   	.sendmsg	= mctp_sendmsg,
>   	.recvmsg	= mctp_recvmsg,
>   	.mmap		= sock_no_mmap,
>

