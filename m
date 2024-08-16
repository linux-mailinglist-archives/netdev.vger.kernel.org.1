Return-Path: <netdev+bounces-119242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADD954F51
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F95AB211AD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D8E1C0DE1;
	Fri, 16 Aug 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbsJ5saB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xaLcOmhL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6931BF337
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827093; cv=fail; b=IVfJucki/yGkcpgpwIdxnih+0oBDtmCTLSplpEggO9HN7f9qYhogFoNZMoWR6EcMP0/CdyLK4rpla6tOalOYPGvCcLA+KFqLxuVkHWgTpG1pG5FG4kdblrPJd2m4dEOJytaM2ovXwG/jjfiNgSfFpV0nudSr/RY4YEqpW+NS7PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827093; c=relaxed/simple;
	bh=fcOd1AzcAk7HnB4pFtMPokPCyKRq3Y6G0G/dawP9xY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWKNSgDIi0VB0TSfSRnDv4duBJ0Yfk8mXSmSzVf8PerDnGoRCedMJzjQgt3fw5qWvD1UFn4umrsb4uuU7vdEQkXThTQxkoNH2i0xiLYJRJMYHVun6hKKykobgeUDzyy6u/eer4TOg62On4bjZ/FYVd+kRszu1JSIuWgNi90vpYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VbsJ5saB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xaLcOmhL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GFiTwk030748;
	Fri, 16 Aug 2024 16:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=oAzCtXsZxHyy1FFzH+yle0agtmNOjwl2+uGbxHNFlFQ=; b=
	VbsJ5saBmZ3LtlbD3+skSgu5XPXosnwsIzl69S6dsnF+S9Um6Xh/YBTfLOcTMRfK
	zKNpFl2Gkwtp6Km51L07e9RIeVCnOZitEzZ4cD6AOY8ni/nJ07JCx0MlTVIPiy0f
	VZEjuQTB95ZXdEL8RgOvNE/mjxQK3A7hkLx3fqgZdOYGVWv9wysH94dLWRid71x0
	R65/2gL2R+GxTwxomUb0xO+R45Uw2bVrHaTy44iSdvE/ZRW1VIR7r5gf7Yfw6vLP
	R71bUD5uYm/yKjmsrqs0CYffjFfDU688QmLe0oeKPt2fouAFZZRf42eGmls625Bx
	CvQbSQVVuhDZJh5hY5t0ug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x039cr04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 16:51:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GFnu5Q017737;
	Fri, 16 Aug 2024 16:51:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxndq0tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 16:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5xH22g1k7XzxP9o+N7d+lSA/tfsGkU8mCii1sIgtkjzRE6LDkfnsywXuzmGrBUZSrpxsdj9jFFMYOLHbHSjFU/1t7+vHIrBWcuyptr/bYjpBfxWY1Y/sAKJ3ovy/wafytcISa/A0HDr+YdTSXy4oiw3Y3c6KB/g4lfzlYJImPwAsjBr/onhe7YI0m22tYZQvPaeCtGSialyMyqZ4D1QUVivim2RTzB6+hGuP3zQfp6HcM3N3X4qx8+1w7vFlvxCTsQZQGH0i1Ky7+kb46RJKM//2LPbNrhhv/H9jzQhJ9FVRsIBGrYRWIBrw12IJXwODGi03oe1VvmGAGjhK/A5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAzCtXsZxHyy1FFzH+yle0agtmNOjwl2+uGbxHNFlFQ=;
 b=DZp9V/KELu0VugSXkAqa3FTOKZV9KG8Pbi9WbzvkevUtZ52Iz641HOukdk/Sho320OGRcOLhwLXqnF6cOQPoeBNX5tefGBk9sLRg8XDMbea2v0lJ8I3uQz4HdOrIui47SCyNVVQNDo3TsqlmdJToX4LPyQmtikEox3Krrqw6MgEc23pdtKHrq1x92CeFyZmVcPcTmpV+vVpI3bjsqVNiMNTSGbJcu9xl3ZI/Kvp/zPNre/FdP01/iSHwd64REdEVKJ8/cgNF4EQjVUYIrigEcUBlrZIxXLxzJhvwFAiYuY2CZXnuQ6LZ3xG/b7Eq9PZBdEb2MMkKGRLNAtPiF9vsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAzCtXsZxHyy1FFzH+yle0agtmNOjwl2+uGbxHNFlFQ=;
 b=xaLcOmhLyVHimQQx+rQshttcoVpPZM20uitD1datoAKyqTaBK0OtP2ulCGp6cFIRXRQxgP9yFAEH0/w9stjbnI25v1EKc61mm6R5Cx9IrMvQEKzkljtIsniFvIfj1De+po45yn7Qy62NWUOtcKdjBa4W2JXhsbP8wmHpCSFJpJ4=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DM6PR10MB4219.namprd10.prod.outlook.com (2603:10b6:5:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Fri, 16 Aug
 2024 16:51:26 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 16:51:26 +0000
Message-ID: <6c3c2b2e-4fd4-498c-8347-1a82b0b770a6@oracle.com>
Date: Fri, 16 Aug 2024 09:50:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] af_unix: Add OOB support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
References: <44c91443-3ac0-4e67-8a56-57ae9e21d7db@stanley.mountain>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <44c91443-3ac0-4e67-8a56-57ae9e21d7db@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DM6PR10MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e5204d-a874-41da-87a7-08dcbe13aaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yzk1MXplQTh2NjJPSEt5bHJZRnMxUExEUmFGdUNFVnFrQ09tS21BUkxpZ2tN?=
 =?utf-8?B?VDhraEEwc2U0OHVYK2xaMmJGWkQwSjZ1dkNWRUI0elZHN3c5OXJqYVVLTXVX?=
 =?utf-8?B?QlJWYVMvT2tvTXhQcmMrN3RwYjB2M3F4Q1lkY3ArVXBpUVpINHJOUEZCdHpK?=
 =?utf-8?B?SmE1bUZYd0VzTEJUS21PZGhtZFM5ZjV2NU1jTTd1VmFIa05ucEsyYlRYK3Z6?=
 =?utf-8?B?d1U4eFk0QUQyVGVJWWV4MU5VLzNHSmxBODhEUWVPb3g4cS9ZQXVNZlVqVjM1?=
 =?utf-8?B?K2N1UTF3MXhZcUpFWFUvbmxEKzBxMWZhd010VDJLaDBaTE1PbjFyY0RRT3BF?=
 =?utf-8?B?emZvL1QvSjd2R0lpSGswa0Z0aFd0WERqT2lYL29Hbmt3cW1hdXRhckh2L0Jy?=
 =?utf-8?B?cGRiWTZ1Q05QRFQ3Rmg4d1BpT0huMkMycnBwOVpxamx5enF5bWFDWkdFeDcr?=
 =?utf-8?B?RnJ1bUc1R1Nsc3dUdDlzWW9MN0l6MG9rS1pxYlZRbnVEVTR3aGVLR3pxV0xi?=
 =?utf-8?B?ZFJmU0xRVTVUdGJ0M1Mwc3BBcmRwK2tnNThXWDUxbUVTYkFGSkU3ZFBRdE1h?=
 =?utf-8?B?bUI3eTJLd2lxQ2twdnh3NjRrWTNycTVrVFNvbWxEbW4yWmR5YytIU1pnWU5m?=
 =?utf-8?B?enhwUWQvaHNGa0VmbjdaZWhvVnlhSkVEQUltSzZCT3lqNW4zM0JEa01Bb0dC?=
 =?utf-8?B?OCswcFFFZEN1WUFhUXIybUUrQWhLa2VKaDdHZ1c3T0N5RTVWTGtUOEVuR0Jz?=
 =?utf-8?B?Vk9FVXZ3ZkFVYUJPOGFKaTdUMUVkQmlLVFF6cXJ0aWJWMGx1U3JlVEkzZG95?=
 =?utf-8?B?bVZ6azVPclFCMHFxZzYra3I1TUh3V3F3SnhlcFBORGxPWlRIVUIzalVuMFBm?=
 =?utf-8?B?NzY5ZmdIN1V4b00rVlE4VlhJVDJFdjhqdUlVVnhUbkN3cjYwWVhYTDFxSDdp?=
 =?utf-8?B?b1J5dXNkTnRqdVFkTGdoeDFiV3l2bGFDd2lWNXJZd21DYjVDbEhiNzUvWUJn?=
 =?utf-8?B?Wm9hMnFTK09BNjVhdFlGTWh3dGNORFh3NEEwS1pGWmpDNk1CNUlpNlN1Ulpi?=
 =?utf-8?B?bVU0bHVhbkVRUjQ5cWk4RUNEZ3dmd0ZkaVNVbXZaYm5uQmFsZU5OVXQ2R2NU?=
 =?utf-8?B?MHFpdTIyTmhxYlBVTjBGL2NNdnhrN0k3b2IyaUc5dWUwQ3ArNHk3amFuVXpk?=
 =?utf-8?B?TmNuOHJHOE5IcEIrWGwvRm1DczVRc21STzZtd3dnQW9GL1ZSL0VJOUFUR2Ez?=
 =?utf-8?B?SXE2WVVERmhZamVJWDVlbmdJeUtsQUZZMlo2ajVCT212M0pwd0pvQllQQnEv?=
 =?utf-8?B?TUpMRGdSekw0ckJOMG9wV2FYak1KbVJ4Ukl0bWZUeTFTMEV1eitTaUNZdjdn?=
 =?utf-8?B?RWlVM0YwZjVwU1FESCt2eDVIeWFxZHEyZnNUN2wvcEJOSm43VmdTRHpNZklw?=
 =?utf-8?B?alEvOVZEQUlES1hrMlNjTmZySEs1TzNPMnR4MmJpc0Yxc3cyendtanprME1H?=
 =?utf-8?B?SmhTRkdXUkZENldKZGZMQnBidzFKTmE3ZW5XN1NlNTJhbnBZKy9sWnBDVTBI?=
 =?utf-8?B?VlhUTUVqZTdzMmpaOEQya0dsZFA0YjJsK0YrcXJuZ1ZvV2RjRTl6WnU3cyta?=
 =?utf-8?B?emIrdWoyeXh5TzZtWHlpbzczMDRMNjVDbXU0Y1ExM21kOWY1bXJIRGNkN2ha?=
 =?utf-8?B?VkVMOTJxa01ZWDhTYnZYb0QvT3RJY0JzZEtlNGVjdFFOOGtUVkN6bFd4Y2ll?=
 =?utf-8?B?R1pSTUpFbisxZUwxZ29nd3ZrbkhXSHpwQzNmdzNPRjdsczVpUk1JOS9KcU0r?=
 =?utf-8?B?L2VKVW0wWXcxN25BVjBMUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkJiK1FnY3l6aE1TT1ltSkZ5SGhZWC9NS1hRb2VWQ09hTUdBaFpac2UyL2Vj?=
 =?utf-8?B?OTRaNjV0MmtWWHJYcG1qeFRPVlVQUCtNYUhMN0x3aUlPZUpaQUhxbjVrWnMy?=
 =?utf-8?B?Y1luZW16QmVudnR3YTY3ZmpwUUJjNGRDc291VmlpamtVZVF3MHE3cmM3S3NG?=
 =?utf-8?B?ZnNjUm9Nd2NNakJKSHg3S2FaVVBOWVkrVkw1N2luTG9NR25Dbk1KWGhDT1Nz?=
 =?utf-8?B?RXBtanRvUzZtSEM1YU5rK1hkUHRRYmVZM3Z6SjNjMjlmcjIxZk1FVXZvcUo3?=
 =?utf-8?B?clk5NFlIMkYrSW5QWUhJaGYrSHdOTW10Zk9JeHhJVjhMa3BJZ3cyeVA0Ri9W?=
 =?utf-8?B?UHBIcWcvajZTZktBdEFyQXQxYmVkK284RDkwUVhiKzJ2MzhtVVJSdFdyQThl?=
 =?utf-8?B?TFk4SHpVQlBSMmRBcjl5OFVUTUZqRVBmRmUzZklZSmxXZm5NUHRiVnBWUmFj?=
 =?utf-8?B?VGFMSmFIb2JiYWJ5bHBoVEJpeDgrRTduWnRUTUVLNHdWUHBEQVQwaWRxQ2xs?=
 =?utf-8?B?UnNqbllYVDN6cHl3cXZuZW83cUhDaHcydW9sTzRiWExUQTA2Ni9ra25Halh0?=
 =?utf-8?B?akVia3RLbkpLbzBTUjh4Y1dtMTBOaHVMQWxaT0NNTzVaOUQ0Q0hQQmFpSUR3?=
 =?utf-8?B?SFBQMW80Q2VNR05xSElhVmd3dTltY3pScW9sN2lwSis0R2tmd3FVdkl5VHls?=
 =?utf-8?B?SGY5VmN6aUJyRTNxUzNsekRSN1FYWmhIR2FiNDRmTEhmUW9uZ2FGS1FGemF5?=
 =?utf-8?B?bGMrejViZkVOTGwyVlFKdDc0eHNsTXRMLzI5WENZcFI1d1VaNjAxQ1lRMW80?=
 =?utf-8?B?eXBzZXFBQ0hqazEzVmJoc05uTm53THUwSEJFUnpKRWlSNEdvZGZKNURuNXJu?=
 =?utf-8?B?S3QwbXhJUTVHdlBBK2Rodk1RT1NBSzU1OGZDdzBXVmhHdUliOUNTWENrdURr?=
 =?utf-8?B?d3krUFIyTW9DL0w5RmFQekhkQUtZTW5RcFFBZHVOejJWbEZGVnl2WWpMUDlz?=
 =?utf-8?B?MVZRUm40a2ttWk4yN2NSTGtaRFJ3Z1p6OXRLOWhwREJUOUdmci9iYUE5RWxH?=
 =?utf-8?B?TktKdi96eC9ISVNkczVWQ3owNG1NcmFXR1pMZlF1T29FUks1RE92MVhIV3Vi?=
 =?utf-8?B?R2JhdlRqQmoxR2JtQ002aTQ4VGEyZW55dW15c3lkZi9kVmNBbjlVazdScWph?=
 =?utf-8?B?c1BkTEZ2OVpxN2MzSThhVGZSRzNkTmtDaVV4YmVyZDBuamUxSmVYWitrNFpL?=
 =?utf-8?B?d21sTGVGUDlvQkNUTHlpOThGT1RxUTRBakgwRVFaSWFyOE5pY3k2SGJsK3M4?=
 =?utf-8?B?V2RsUExSOVhjbmJ4TkJScGMvWGhqQXh1b2FPM1VkTnlNMm9VYVJMR1lZNnpo?=
 =?utf-8?B?T0cwa2ZQV0I1bGlRWXVSWFFuWnV4b0dFdElSb0RvMzJqeWR1WlFnQzFhZWRC?=
 =?utf-8?B?czVtYUl0OTNIeFlQODAwQUZwLzNNUnBOSm5ya08zN3lVdDFHWCtQWW9xK0xu?=
 =?utf-8?B?UmlRQVNmSGhPOHhRTXdBZkdDUzJFQUh6SHlDaTdsM29LSnBtbW5KUFRmZDg1?=
 =?utf-8?B?Tjc2T3NQSTV4Y3FFeFpybzRjT1FmZlB3ZW0xQUtZOTl5amhOWjhnWFlQTVBN?=
 =?utf-8?B?bVdTR1FDbGhYYmJmc2MrOXBjdWl6bFNTTUx0eDNqQiswRmlaOWZvQUVqYmo1?=
 =?utf-8?B?QStLRGlCbmVEWmN4bTJGUE5vV1VIRVYreElSeEVoWTZPZjhGRW85Zk5yS0ds?=
 =?utf-8?B?VTkySjNhZEVsWEZyMCtpQ1FZbjMwRGNrQ1kwSUpld1JTRTllWm0rbjk2WlMy?=
 =?utf-8?B?UFBhc0JwWDRwSkNBQnVJcmlpNjF6MWFCbytyVWE2OU53K3FiVkdmOFl3ci9q?=
 =?utf-8?B?amFRdlQvcmorQXFkSEZPZE5jVDg5aUNTc3Vnd2RXcHIzZk1zL3h2YUFGZUNE?=
 =?utf-8?B?L3RkZGhnWTdaaDR6OVNmcm1uTngyRHRGcnhMbytCODFDUXZQbmFQaXpYSVdW?=
 =?utf-8?B?YURFeU9sWVoxWWlDSDM2OWRYN1AvdmNwKyt1R05OdTJETkxGTmRVaU53NE9l?=
 =?utf-8?B?Z1pMWXpMMGhFbldwR3lKREZ4WkVuZkFMRzM2SmpEbDF1U29KeEgvaUhKbUxR?=
 =?utf-8?Q?ZUbYwWzYIwWSfbbtuTHtktJNs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SfJzFbgd3cgn3rEbIXj/FP2mukpI8YMn/oAeg1w3CPa0GIYaekB07HmkHOztht9PaSIvASBNFNNqSg7HSLSfMH1UnRvS4EnapNDYHtKuYfRceyXHBFwfuK0gUSDQvfV2ALac60SYs6BnYpKMtcD9MRBUoluK6xCyIeubw5IiMjVY8rHL1jCTck02Dj7lIcxWJq4jmnkoiLHtTe8Mta5j2o34LIcMMi0WN9krPp5kmjumBS5PmCRBOLrWHEY5TjCd7H6ZSrEPk16/eTiis5aLliL4PDq6j2HDKP18BD0/3+6ELwhIsMnE7ok4wVgJVVR8ZqsOXdbBbsMu6L4hj9I+Z+jHoBlHdodP9BS6csC7fKy0Vhs6jfYiuKg3cGMvOP6aX4LzUp6paHL40f+htaHQFhedhWB2fkmkI5kUVLWOBOkJvlit/BkhvwTAesjcwn2YbrFoEuxD74NaVWijW4pjufgyZvIuHyUpPkmahamdZftwRkQSQQKAxX+ntKaON0Py4aSRBZjCH64ocHsrnxdCJhBRL/1dqgs/GOcSwnYcOYcbWWTaWhMab/ew5GTEVUNsRmJukUy5TLPirV/WisfiAyU/kENDNF5ErCbEjrE/3WM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e5204d-a874-41da-87a7-08dcbe13aaf8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:51:26.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfCibEpi+ni6y8vCxNuWFXQ+9bRvlLhpuvL6ly9yTE86Juoj2hphZ8aPhcGw2uYTfEvGxZ+4tAK7xLFXo3YC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_11,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160119
X-Proofpoint-ORIG-GUID: I_D1FJzgVyUPhckjAC8H64e2tgD2-DDj
X-Proofpoint-GUID: I_D1FJzgVyUPhckjAC8H64e2tgD2-DDj



On 8/16/24 07:22, Dan Carpenter wrote:
> Hello Rao Shoaib,
> 
> Commit 314001f0bf92 ("af_unix: Add OOB support") from Aug 1, 2021
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	net/unix/af_unix.c:2718 manage_oob()
> 	warn: 'skb' was already freed. (line 2699)
> 
> net/unix/af_unix.c
>     2665 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>     2666                                   int flags, int copied)
>     2667 {
>     2668         struct unix_sock *u = unix_sk(sk);
>     2669 
>     2670         if (!unix_skb_len(skb)) {
>     2671                 struct sk_buff *unlinked_skb = NULL;
>     2672 
>     2673                 spin_lock(&sk->sk_receive_queue.lock);
>     2674 
>     2675                 if (copied && (!u->oob_skb || skb == u->oob_skb)) {
>     2676                         skb = NULL;
>     2677                 } else if (flags & MSG_PEEK) {
>     2678                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
>     2679                 } else {
>     2680                         unlinked_skb = skb;
>     2681                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
>     2682                         __skb_unlink(unlinked_skb, &sk->sk_receive_queue);
>     2683                 }
>     2684 
>     2685                 spin_unlock(&sk->sk_receive_queue.lock);
>     2686 
>     2687                 consume_skb(unlinked_skb);
>     2688         } else {
>     2689                 struct sk_buff *unlinked_skb = NULL;
>     2690 
>     2691                 spin_lock(&sk->sk_receive_queue.lock);
>     2692 
>     2693                 if (skb == u->oob_skb) {
>     2694                         if (copied) {
>     2695                                 skb = NULL;
>     2696                         } else if (!(flags & MSG_PEEK)) {
>     2697                                 if (sock_flag(sk, SOCK_URGINLINE)) {
>     2698                                         WRITE_ONCE(u->oob_skb, NULL);
>     2699                                         consume_skb(skb);
> 
> Why are we returning this freed skb?  It feels like we should return NULL.

Hi Dan,

manage_oob is called from the following code segment

#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
                if (skb) {
                        skb = manage_oob(skb, sk, flags, copied);
                        if (!skb && copied) {
                                unix_state_unlock(sk);
                                break;
                        }
                }
#endif

So skb can not be NULL when manage_oob is called. The code that you
pointed out may free the skb (if the refcnts were incorrect) but skb
would not be NULL. It seems to me that the checker is incorrect or maybe
there is a way that skb maybe NULL and I am just not seeing it.

If you can explain to me how skb can be NULL, I will be happy to fix the
issue.

Thanks for reporting.

Shoaib
 		
> 
>     2700                                 } else {
>     2701                                         __skb_unlink(skb, &sk->sk_receive_queue);
>     2702                                         WRITE_ONCE(u->oob_skb, NULL);
>     2703                                         unlinked_skb = skb;
>     2704                                         skb = skb_peek(&sk->sk_receive_queue);
>     2705                                 }
>     2706                         } else if (!sock_flag(sk, SOCK_URGINLINE)) {
>     2707                                 skb = skb_peek_next(skb, &sk->sk_receive_queue);
>     2708                         }
>     2709                 }
>     2710 
>     2711                 spin_unlock(&sk->sk_receive_queue.lock);
>     2712 
>     2713                 if (unlinked_skb) {
>     2714                         WARN_ON_ONCE(skb_unref(unlinked_skb));
>     2715                         kfree_skb(unlinked_skb);
>     2716                 }
>     2717         }
> --> 2718         return skb;
>                         ^^^
> 
>     2719 }
> 
> regards,
> dan carpenter

