Return-Path: <netdev+bounces-224604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C028B86D3F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FCF3A8CED
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD02D878C;
	Thu, 18 Sep 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQhyUiQ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DZ5UKnyl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B029A9FA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225921; cv=fail; b=WbBFzu/fM/6nGHQp4WXaH+lqS8PBcCcLIFLVSHjYWiH1aaH670YgOxSte96vIP4aQ17c3c/p/ONXNu9/J1jqPONunKSLF4B+r82aX4bNgsgYHOBW1xcwxDPE2vvNM8Of31SiY9ZZpwOqAiymZFLDJ7WQNY4bhZHk8KICUOoBapc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225921; c=relaxed/simple;
	bh=TOjbCJTE8IAtX+hKIMBUzRXZqLryJ+jgPXuwT0LHLiA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVvdh4qPhDj8WwegflF5apSVNxrVGppjwBotcHqPmjTHUgLNVkWLSIeTaKTiKTKQF0Qe3ETGDFEkJ2zX0BdfjnYwVF9mF9CVsX20stP/3LPbl/NfE9/v3M4+FsTpcburr7mT/XBazkuHP9EKKz5fzx9SjsnRYVYdmmOxrvXtpeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQhyUiQ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DZ5UKnyl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG1n4D009110;
	Thu, 18 Sep 2025 20:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=reMkx36YNIEH9Afjr+feuJ87oindhjZBNzRN3lovLIo=; b=
	lQhyUiQ4E5+OiXB+IAHUEAWV22WEOG3Fu/viCDcvCH0FKWGRoYM+dkEUkEK9ZKy3
	B/r7iG7MwWnvYFwshBjLPpzhYI+BBXSslmTNt7GRbeCAfnDUUnCnz38zakQNKTXY
	yLwNjzSJ3npao7rjt3LJ51M8NDdfYy9ilu3nGsDHSR54kenP8hAUH29UhhlK3Y0/
	oOO/T19pJkmrIfsnBBCIjwgk/Rrygq9xYNS0LPLZskz3Xx7xIRnq/PZlcNsmDjnD
	+OfV/ANRJfU6eIgOkrnSkTBAWTjHPcGrv1kU1STc/BQXXnWfuTiPBDwXhzqL3Bsu
	3eJ41Alc/rMks9uUkpcLBQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbva1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:05:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIax8J028785;
	Thu, 18 Sep 2025 20:05:05 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fngrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB0BuD4U7o1UVrIKPbvqfqucq6ycGlcKe6ED2TH/6A1Zn0R9UOJ3DeciwcaI4Lyfc8wriPcPS91eo31bAwPfGNNk4wTPoIT5evVjBGb/cWc8h4N2wgsyiwHfSeJoWwDe+5q+7aSvEcPuuvYPMiNODdhOL8TbHphpOA1rltjEZ+2hGZ3OColFuW3qUMdDtCGAOqwUPToGr8QfPcHoCAGWsY6frBs7tzOiBQhEtxMpwzZsV891HHUaHEvvWtHNkBHwfSEzgdOLk6V/fiIC2ZpWI2srpXfAuqiT5lmqFLCbrFzcyUpIZHbDbcikucMRfiQwdJ5vijbo2hvoX9BWPp4ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reMkx36YNIEH9Afjr+feuJ87oindhjZBNzRN3lovLIo=;
 b=NN33rYgvSUrlHDcLeyOAUa2a/ZOUjP9xTLB5KaVo8A2id9mEYpy4RrDyNrjvtUHLfVT5lUAx0ZSscE1CFm9iPONeawJPSub5wt1BFvpMvCZxK5ZRY7YFgZriMPiTimHGuHYCLyIrq4zY1nzrBMNXkql9dwsROmtwp47fuaD0e9jBCsFbVyn1pAmt7281mFZoVEQYq1e4y2P3puG4XNtMpLf+QnArXbz3aPN2Ll1SqnH4VLaUBrb0fvZPNXhrKCggqcWxEtKE2BQpH86ZjmOCAtTs7ACieJUrw98BIZGb6UoZn/bX8ngtCCf6zFcYJr1bZESsn23RsOve+4zRTwxxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reMkx36YNIEH9Afjr+feuJ87oindhjZBNzRN3lovLIo=;
 b=DZ5UKnylD+k/CrFyySwTnoq0mSiJarP9PwHZY5+JpRcAJW9dY4w2cRamFtnzH+a0+YwBbf4kJLMfhGdC6Y8ft/2HuksBMUvRY/DImYIe9VC2JdHyj8Zf9hHQjTg08k5W43T+iFtbHixoE28u7PNJ+qf7Xn1hqKslVO+kVQjWjOA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA4PR10MB8254.namprd10.prod.outlook.com (2603:10b6:208:568::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 20:05:01 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 20:04:59 +0000
Message-ID: <5db1336e-3ef0-4258-acc6-0581b881c074@oracle.com>
Date: Fri, 19 Sep 2025 01:34:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vmxnet3: remove incorrect register dump of RX data
 ring
To: sankararaman.jayaraman@broadcom.com, ajay.kaher@broadcom.com,
        ronak.doshi@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
References: <20250918194844.1946640-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250918194844.1946640-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA4PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f51641-84b0-490e-4228-08ddf6eea578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdhSll2Sy9IcFVNRXNTQ1BjN2xMeGxFQUtpZGR0Y0xYTm16VVRrS3ozVU1i?=
 =?utf-8?B?Vnk4Qlo1SGx0d043bWRFYWdiaUlMb0hNZ1I1aHNLdFZWMkVIays1YlNPTm1k?=
 =?utf-8?B?OEVaWklXYmQyYmlNVmFSZWN4QUxJSzlGdnl6dG9aUnNQTFJIZVV2cW1EU0hX?=
 =?utf-8?B?UDI4N0VEb21ucVhURlg5VGhUWDNwYWVLNUdRZzV4N0ZSVGN4Tk1mN2dSVEJq?=
 =?utf-8?B?U0xjajNkNlZadU0xZ1ZkeHovb0JNdHVqdHJEczBKSGhNMEpHclBVUUhJS0RC?=
 =?utf-8?B?NXNORjRsdFNjaENrK1ZCY2ErZ3c1Rm9wdlE5eE42LzkwV3hIUmMvZDhSZEMw?=
 =?utf-8?B?OERVYlF4L0VBQnpOZzhjQXF5RWk5cHBKK202UWNSTlNYV2w1aXFmRjExc3pv?=
 =?utf-8?B?WHB1TG9RcWdFQ21JTWVoOGEvVVNlMnR2UGVMZndtRER0Q25TRkVVM1BUMlBS?=
 =?utf-8?B?dG1MMWhsZWl0RUtOK1Mrd2h1RUhYM2xNN01FdWhUc1ZtQjlZWlhuWmdYaVJa?=
 =?utf-8?B?TWJMWmNHZGp5a0FhQTl4UUE2NEE0Qk0vd2RiQy80NVdZbDJmZk1rMkVTNG4x?=
 =?utf-8?B?VWZ2ZklURkNhaUIxVmJ3enNEZUpSd3B6enVQUktZbFFNdGY3dll0akFtMUd5?=
 =?utf-8?B?NFBuTHlLSmVUeVRSeU9qNlVpM3I2QUdvZW9wY3A0cjBQbkxWK3UxZ2wyS0o2?=
 =?utf-8?B?b05UbGo1b3RvQ1NlL3ozdXNBV0hXdjd5a1F5dTIwbXpnaEE3TnRYNlBRM3Zu?=
 =?utf-8?B?U21EaHoyWitvMnBzZ0U4aVUwaEdCcnBpcGZMT2dyV0h1ZTBvSVllTkZiUGFQ?=
 =?utf-8?B?ZHRGdk1hZUdDS2ltbkUyWFE1Q3FzdllaVTdTTURmUCtsQVBpK1NWeFRWRmZE?=
 =?utf-8?B?SG14SmQ4WlVUN1F0R2NMK0Y0empiaFlkVnZIUFBRa1lIbzNEbUV4NFNCTjVa?=
 =?utf-8?B?R2hNVkRmSUo1eFJRTVc0TmFXdHJ2STZYUzFTYkl5dnZoblNIM3NibWErMWRZ?=
 =?utf-8?B?OFRYUEtXS3FWS21zelVBb1RzZDNsT3o0eUFuQVlFNVpPcDExYmVSUzg0WURL?=
 =?utf-8?B?R1NtNTFaZ0hkMVRCeXNxTUNQN3JsSDFIblRrNkphUWEwVWpkZ3FiQnNRa2hH?=
 =?utf-8?B?TzRybkpGNlo2Sld0MGdmM0lNaFQ5UkQ1aVZlSVFvZUxGR1lZZFRGdmdPSVk3?=
 =?utf-8?B?M3AxTXNvZnZHWVY5K0JuMEc5MUNNVHlaRkZRMCtTeHhWaTV0YUZvODJyUTdQ?=
 =?utf-8?B?ZlBXczZXM2tyZDRXaGlIRHg3d2JMNVBxZHJhT2ZKRGJ4T2VrZENDUHMyUFRm?=
 =?utf-8?B?NE5BWUtRcC82LzlRbFZvRHl5VldtSGNidjVGUHM2MnQ5THk3alI1emV0VmlN?=
 =?utf-8?B?bjVTaC81ZmRSU3RVWFdhaWJVRjg4THVyNWo2ZTZwT093ajMzbEI0eU9wOTBm?=
 =?utf-8?B?aGozTVpabi9sZzhPTk5WeVVLREtCRDVxNUxkTFh4bSt6ZlViSjJ2ZFd6VG12?=
 =?utf-8?B?WllHdjRNMGVjOEg1VjdsYnZWN2Yxdm93cVVFNEllbWRwWnBOcGlKSGk4OGdm?=
 =?utf-8?B?eXhIK1JuNnRaTDMyQlBGZ2kyNW4yU1h1MVpYS1hvSnUxMG5lMGdXTnVob2lh?=
 =?utf-8?B?TGwzZ3ZVSEN2Y3lKaDFzQ0N5bDg2akFBem1acFV0S2ZtYnNPK0ZjUUJnb3Bz?=
 =?utf-8?B?QkYxQ3NJQ1d4eTZxNTZPOC95WWVoR21hdFBQaTJsZUVEYkJkdzAvTGt4czNi?=
 =?utf-8?B?RGszM096WHhVMXNFU3Z2MWVjZjVlaFBZREtQbHJvaWltM20xenJlOUVoSmNM?=
 =?utf-8?B?K1JKNGFqc2p1Q3U1QzNzMzFVSGFSZlYvMUJtZEhZNDNteG4vYkNwZDh5QStm?=
 =?utf-8?B?NVF5YUhhMVFBVEs4dXNmMjNaMGZvTTFZMlRhMG42alRmNXc3VkdrcUlwSU56?=
 =?utf-8?B?blQwU0xrWmJ2anFQRkVDanE2STc5QkxBUWlxcS9hdmt2NXFHdkNNTDFtbHZ5?=
 =?utf-8?B?ekR1WFB2SExBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjlZVEZza2JLbytwVzFGaXc5dzZ2OGNSdUdiOGtoMWtpNGY4REU0U2Z4MFJy?=
 =?utf-8?B?bnVOVzJLbkhtOGJSdno1eEhKLzE4ekd4RkJyelIxZS8yUDlrWkljTDBNc2FO?=
 =?utf-8?B?YVg3c25wYnVPZmdXMHNVT0JVcmF1ek9ENU9ib0FDYWUvS2VXd1Z6K1hmQzZF?=
 =?utf-8?B?UzVXdnlrUE04NWJOclRDeCs0ZE1aRGlrSWhQTDBiVGUzc3ZuY0Jlc1JheERj?=
 =?utf-8?B?S3FGTjBsbG9EMzZmYi9UUDJMWndSbE1KOVQzbG9rMXRWd09TaVZEYnczMGV2?=
 =?utf-8?B?aGkwQnVPeTdXdTJpZzBVNnFLUkJGMEtSMFhXMVcyUndaTmRJWERNdDJubk9a?=
 =?utf-8?B?U1FFdWY0VFAwNHl2WXQ4bHFXdEdtYmtUc1NuWEVvdXNVL0VidGZ4aXdTZER2?=
 =?utf-8?B?dHN5WmVhRmI4SFlKekJmbE5SS2xBMHZCQisvem1RcldTdTJxWGhnbkROWGR6?=
 =?utf-8?B?UWxLcTFPN0RKVmhodU0vc2FNSFhKVVl6RVFLZGFmdVAxamNJTi95dDYrUUw2?=
 =?utf-8?B?THZtM2E2Q2Fla2lQdS9OWHl3UTBXRnZjb09FZWhVbWltTS85MjhlUDRCNGdz?=
 =?utf-8?B?b3VOb1RCa0ZqOGppa3M1c2lyVWxnSVRyWHJmTkozVy91aXR4Uko3VytwRWo5?=
 =?utf-8?B?U1ZHTlJDMHBNTzY5czArUnYwTGVGRFJta1EzZ3dzcXBidVQ5ME1vdkhTQWU0?=
 =?utf-8?B?L2V2UEQ3aWp0TFJBVkcyb0ZGSllvckM3aWZVM29VejFxWSt6WXdRK2dRMXEx?=
 =?utf-8?B?RG5WT0JHMi9LU3VxRnRrUUlvcHYrTWUzZDByTXZ6clRvL0gxQi9KdDhBcWNx?=
 =?utf-8?B?Y1plQ0g0RFcwandMQzgyVUkvcG9mRzBrdXNDU20wbFR2QjdHcWlyWWpucW9o?=
 =?utf-8?B?UWZkODh0RDhSRGwzVEN3TDl6TVpvc2wzV1RzRFJpN25rYnV6eXpxR09BaDZO?=
 =?utf-8?B?SmdjWkdsQ0dQcTRvNXVKMW9hUXNYTXR0WUF6RG1JQWdlNGRCUWFQYmdvVlN2?=
 =?utf-8?B?OXlzbWhDb2xxdXBqMWRwSFhyck9XeFZJbkk4N1FaVjg0bXVIREVyZFhQbUJ4?=
 =?utf-8?B?NDc2aCtKczdkU04zeEo3SCtKNDJzYVpCRVBocURHelNGakx0b2J4Uk1PdzRC?=
 =?utf-8?B?SW5JeGEyQUV0M05Ta0U2Um1wNU04Q1hweDI1dzZFUnQ3c2RPbHhPWko2T21k?=
 =?utf-8?B?RXVCR28yRlVzdjV5dyt3ckxCN3AyanFUeGZMUWtHRTFpbDN3R092YU0zaEJO?=
 =?utf-8?B?cUhqaGFSWkhGSllXaHBqY29KTjY3WUVpZnlhMi9TbHU3Q2ZGbjdtSDZxQzNX?=
 =?utf-8?B?UWY2OFRYQkNvU09QYWk3ak5BNzhHbTRuSEh0U242VmVSQnArKzNBN3BmUkR4?=
 =?utf-8?B?c0M5SWtjdE8zRTA3QVUwZTlNSUdEaHpsaDJ2d2VBUWtlQThiTlpSYmhPdGV2?=
 =?utf-8?B?WTErYzdDVVVyZG9YL0NNTlVmWkRMUnNES3FaSXBCZEJDeXA3VlFqM2k5UFNw?=
 =?utf-8?B?QjA4YTF2YUY1cmYwL0hNUHBQdE5sMWhoTmRSaitnTE13T3Y5SDZKaWgzeGRF?=
 =?utf-8?B?S0FWZVIxSUJ0dzl4ZUtwNnVPS0ltTDlzdC9LSUM2MzFDYXdyQUd2SmVjakNB?=
 =?utf-8?B?YlZOeHQyVUhYbmxzMVk3YU8yQys4VFhyakpRaUMvZDJVRmhheUdyVC82dU5O?=
 =?utf-8?B?VzI2NGdNMHlHc3Z3M2FNZ3BIWTBtaEpiTEM2STRwT0NCK1RoZTNSN25LSllN?=
 =?utf-8?B?aVBmcjdMMENZMitKRG9CZ2dTTmxmWUYwbW81b0JXS0ladGV6UUtNbVdET3o5?=
 =?utf-8?B?eTlOZ3RzQVk0eXZkV2haZzYxWlUvYU1uMHZEMUVtYmc1U0kvWVZqcVhKaG8v?=
 =?utf-8?B?QnZ2UzRKdzE0ZnRmZHBsRk9xVVdNMTQ4ODBJYy9EbHFMZHhVRHRlc2VTa05Z?=
 =?utf-8?B?cERkTnlXM25jNUJQU3NEOWd0aU1tTjFta0I3VjQvMHExdkpPaDkvejFPVDQ0?=
 =?utf-8?B?N2pJdnREY3BOS2hmRnlBYStUVWpJSkFOdzJCUEI0Nm5CVzNSR2RxR0pjU0FY?=
 =?utf-8?B?Q0t6d3ZyZ3Yrb3VFS0dkeFQybTBad0tpa0xrOXlGR2NiWjZHdlZyaDRwQ0tX?=
 =?utf-8?B?QzJ5aVR5TVNGemFIL2J3TForZWt0UDdqMVoxUktUUlY3b0I1R1FvSXBacEhX?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cb7+sQ+Q/Rwamm4HpPoTps6xmZZUV7H+U0ju7BFm9w5Vln/XB1S1hV8E8SwUs7aJ3Jeo52rQukJ/+3hw0+fTSIHewWJ/Nn/RY5oGnxj/1yuq3bvmWWG4FbSzf267Zu3DMKBMXF5Iza6Ycy2W7L8+yViVE7GRp3RbavD7lJgHHGRIk559AAGd8Ir7hwtDR4E9ESCm8dz3OHc+gpNgV3jfu+yaWA0CR8Qss8jpNHJETab0mMeC+Ko4DqvRG278FgNuig6LZhzkRCEegrNhfzIozBbRqdYHWrMgjlxSGzSl8hpiGo13XW8c7kLgrN62uNVYCfu2zJalPYgo9XwCE0UT0I8xtxzV9VpIOV9ZUbGPmmZuLteJi3zhCdnkTwm2XKxifWLavD1U/Ljq3+raLkw21cgfArNFjaiQF6nZoErqgW2DFEfB84QY4mU+mVeEZ1I34ytPIMsjpRZWv/2zLdAGM6cQ4EcQGzxzRGIZeJ9LDxwBl7kvqWyfhDKnXH6q7JIzGkdzYzXQq9HyxM8YsoB3U5rPpFbu+2vvxUwCcLCNoqfRSFZDY52OjWwQ97lFcXx9rNQvLn5nD2hJOXbZBQ3lwdM21Bd+JgLmBkGtQ9eUPDY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f51641-84b0-490e-4228-08ddf6eea578
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:04:59.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ltz2v1C3IAef+CzjwobZ8RSh7FG4Vg2ZdTPDSBJZGTgUONKGq3b+eEviM3p9/Vnr3l9Vt8Vufl7bb/Q864NIMVPsj8IlXYUUdcPNStYZcmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=881 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2IZWZxrbIS/i
 81xp40eWPCGn2lazE3II/4fc4Z0mjERrF7D1auWElBHIhhIDuC1Cy0t+ImUqgLXNJypFpUqorFS
 uD9wfZ/auHyyMFsX8krelF4amRDunbEzo6r6lrikvmY0X8Z3aXLv/Ko5ngPakvl3MZNQ6lYjaI4
 L4W0uENmAx5qlbqOMu3BJPqBX7kECx54b5rzcoKzfB/PuIj0gLPF7G4E/owp5NQGmvjrdsKcqaO
 KWR97U6pua8zC4jzuY8pzTdM0E3WFjkBxMiuP0HMwQp64dcYOOPH/9oS/NQ9+guGvW7M4SbDs5w
 Dk5DyvqMZl6rjHC44x3mnlptuxv/V9dKRqA+jF4jLt5jcg8bPp9IIElvR3uENtvG0KSqMZmujYq
 n2BPWhcq
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cc65f2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ZOFQqeefFqHwAfW-k54A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: bRGVdbeJS1MDyMfyD-1rcbf3wmp903zY
X-Proofpoint-ORIG-GUID: bRGVdbeJS1MDyMfyD-1rcbf3wmp903zY



On 9/19/2025 1:16 AM, Alok Tiwari wrote:
> The ethtool get_regs() implementation incorrectly dumps
> rq->rx_ring[0].size in the RX data ring section. rq->rx_ring[0].size
> belongs to the RX descriptor ring, not the data ring, and is already
> reported earlier. The RX data ring only defines desc_size, which is
> already exported.
> 
> Remove the redundant and invalid rq->rx_ring[0].size dump to avoid
> confusing or misleading ethtool -d output.
> 
> Fixes: b6bd9b5448a9 ("Driver: Vmxnet3: Extend register dump support")
> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>

The wrong Fixes: tag was added in this patch. I will correct it.
Fixes: 50a5ce3e7116 ("vmxnet3: add receive data ring support")

Thanks,
Alok

