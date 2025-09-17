Return-Path: <netdev+bounces-224180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65876B81BCF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCDB1C26FD0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491524678A;
	Wed, 17 Sep 2025 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="obnjQzDK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mrWu9e7C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0E4690;
	Wed, 17 Sep 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140331; cv=fail; b=f1lJNfLqhs4UHT1tURrFABXPh+33jAoufsKDorMilBakYVXQNo0aUV+Ppeh+U6ZDwLid9U6bLSiKGwGGIv//+7qMWCZCbYq9sgZBV3gcGrCbv0sBiW0K7cryDHSZPMjTyYlrPOccOvKVVF7OiwdWqaZ0s0IBvQpyp71WllXXfSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140331; c=relaxed/simple;
	bh=/LaWmI12A4l4MH7KCKmxYYr1Vts4/OFlaTFLy9IODNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FPRmA94z6PZMAOrMrlbsxgODkhVKDP8xnmSYU82RnxcKYPn7Mrcb1Tk6ma2+VnRERVinJoZ3GkvqoHtHpRIEYPnEcJ/xNORq34kvqcSYKFYnlo6u8MSTDBtjBnrjnIg55p2q6naWyOqDgGI0L1P4DTWypU8Fok0UsoqVfZH4WHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=obnjQzDK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mrWu9e7C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIbBk014322;
	Wed, 17 Sep 2025 20:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c4cOL/Bwwii/NCH3+TW/k1MMH/a6FcLdGhLN6ASmMH8=; b=
	obnjQzDKrppio5s91rATUx+BHiBDjE8tQJJi90jhoNcxiOT5pz7hBJbbrXBamp0p
	deQRR9OhOeDTULmjN+SWuMf00gme3zhbKWFM05SNpgnws5r5SKrc2FrmUPvbFbCg
	qkpIzlXiOp+ejfj7d3/GIsnNd2LW5XlHy/AmCPw+GQqFBPKTlY6XRiFX77/u+9/2
	Wq9D3iAfwpZCiHu8I5IlvExFK3INAeTByna/IV+sY/A1PTuj3S8Frd0S78i2RHtX
	qK0Iv853tpFJdUpQqO5N+ZK7ls/bNdJBbRsBfQ5AQC4bgdY8OMkIzYtpICN1wvA9
	MeeWffXNOaplfuIBbPEGxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0ka6ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 20:18:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HJI6Av033687;
	Wed, 17 Sep 2025 20:18:40 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e7kab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 20:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tgb/liVy0NKz0pWN0jMDZHCsDz/f2FFPHQVcxhNxiOOomulsB32kL4YfZHb5JxT9ia7kzZ9K/pm6eAbHiIQrBiqyc2ieeRZ1ITyczXRKapkaovZvXCTN8nbKA/PmnI50tCjqDfphS/wER9KYeff8Seq6k0TMNW7cdhEhD21jf8/JNPevwfZvug8VHy0YERZpizKBflpagSG11F/t+8SsVN/tEF6dIPvwcfVzaXlGKRKYZBOoo0G5Qw9Tg97fTnClMV5BQHbTa4uDb9YPTicVuFfDLCIbm2mWdZVRwqm4Sl/e6oSgiZ4iNC+eUWxxz8ny7oUjpbIugoccz5OKojYHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4cOL/Bwwii/NCH3+TW/k1MMH/a6FcLdGhLN6ASmMH8=;
 b=PX4Ft+L1Fi3I91pApalTF0TqksAmPlHeVTwdT8LCYFrr/FtRVkq3+f+u6jgnDf71V7CC846my1w9wrJfeK9uRMdrjoXQyUlzjHc0GiuZzF5FuELifRzzdmR3+gsxIooEMtWDrVJIrk5TTVhAMfH0bp2oz0ys2p44FsmZBdqBIS5b/aSyXGEmOt2kJQXISkXxuSOdt7OmulUi1T1L52YDqOQ1JfBXdzlhQ1SLlomEACOvoNdpLACrNXsmN0yUY5/vn7Rv2q3BLOvvtViMkF7U8C44sPjweyWBepcGKBCo3OMzwRHGZBA+HCBRfmSZW2SQTZpDZUeh/JK7oBNMoYVZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4cOL/Bwwii/NCH3+TW/k1MMH/a6FcLdGhLN6ASmMH8=;
 b=mrWu9e7CAXoe5aVSFyFfNyy5wztpZOaslPS6jahUw+QrpjiqrHz8q4jZsquDN6bvxn9/zPjoQORICmOO/ZusBwL+4m7xHVJfeiZlFwBUtn/Jfw+KtblljnOF7DUadhen3IbGHAgKasInNgWcaXCMfKy39qbI2uwWmzAEGiCNZhc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 20:18:37 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 20:18:36 +0000
Message-ID: <aa898848-810e-4a6f-9fcf-0289e620229d@oracle.com>
Date: Thu, 18 Sep 2025 01:48:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v7, net-next 09/10] bng_en: Register default VNIC
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-10-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250911193505.24068-10-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 877564bc-ecfc-4302-b34d-08ddf6276223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFZhK1FUMFFnYTlRUnp6MFhETUM2WGg5eEtacnRTcEFHOHBRdno4dkZvcVp2?=
 =?utf-8?B?eFNtWE9DMm52NEppS0NGaHladkZPdWpETDFta0lzUkFTRzNGS3lsS2kwSmcr?=
 =?utf-8?B?SCs5aWtheUgrNXpWSW5sVlU2ak1LK2FkY0NmYTJUdHhxLzRKTG44dVRRZ2dS?=
 =?utf-8?B?aGRDempCMFZIdWdBNEsxOEVPcDhwNTR1S1lHY1djam9iM0NTZ0ZITGM2TkZW?=
 =?utf-8?B?Y2ZEWkNVak5JMVI4TEU1ekx4TzlSdmIyM0hzNnkvZnFlTTVSMi94QzdycWVu?=
 =?utf-8?B?aVV3QU90U25IR3NYWVRnU0hzbDVrZlU2TFhvOGxSVjlpQ0pkR0NZV1owbWt5?=
 =?utf-8?B?SUd0OS9WZ2EzNVBHejh1eFlralJzZTVqallmZ0NiMkFyakwwSDdjRVloQ2Jx?=
 =?utf-8?B?Z1I3YlQ3NkdLTHVHQklJWVVmMis3YzJCUWhTdWpiaXlSYnNJbGxNWVFIbFIr?=
 =?utf-8?B?dzBicFNMRDBNVWVlNHZkZHVWVEhkaSs2QnBTZHB0SW15QjdpT2RBalBCV3RP?=
 =?utf-8?B?dmlSYWlTbC9uOHdKSnF2MlgrSGp4UVRLZkI0bytzVUZUMWhXZTZnblIwOVRn?=
 =?utf-8?B?WXZqUGNkMTd4NWhZY0hSVTBLMmlPZHVSSllyeHpQSmtWYkY1eWg1V3NpQnQ3?=
 =?utf-8?B?TE1sYTRNY2JOOThoSWpQZU1XUWFwaXFYaHBSQkg2TG1TSk05blpaWjVPR0c5?=
 =?utf-8?B?K3dsME9HdmlVZnlFdWg4aVlQMC9XMEh6RG1QK2ZackV2OXJaSndGVTlROXF6?=
 =?utf-8?B?T0RtaXVuQmdMTzhKKzNOWGZzbE82Z2R4Sko0U1JsbEp4bzU0Tk95Y2prbXpq?=
 =?utf-8?B?WGVJZlZ2cmwwMUpLd3BieEtvRnFmYUgyU0I1ckZ4TUpHZXpiUGl0d3RjZWxZ?=
 =?utf-8?B?emorV242WGNrSjA4UkJWOUZhOUlmMGRtdEl2NGg5bjJwSTZGUGxLWUtHMlh6?=
 =?utf-8?B?RUNoYzY4bjRaVGgvdytwL0VqYzFrNWh5cXBVQTYwNjcwY00vT1FjS2xoZ2NO?=
 =?utf-8?B?RVJWQmVjcytDSU1IcE1zYUFDVysreFpXT29nekZtNUxrU3RVNGRpeDNjdE1J?=
 =?utf-8?B?NmtrOVRBREdtbUt5WjVzTzloUTdpTDNHaElGMmdLQTk3eFY2N04rblJIVG5Z?=
 =?utf-8?B?MjZ0UnRHOVZDamI4UjdiOGk4UDZaN2JueHhVeDE0MHhlWU55bFhwTGt0MUxV?=
 =?utf-8?B?UkZ1eEtVQkhRSk9Yc0VOWUVEbnJmc2xyMU1aUEpFa2lGSHlncCtpcGVUamEy?=
 =?utf-8?B?YVhVa08zOTBTNE5PN3B1dDZiVDFYdEg3VVJqODI5QWtoS2RUSHhFM2tXdEtH?=
 =?utf-8?B?L0VkeEtiR0NmdU5GVExQdGJ4SnoxMVhxNFM5OEY4TzA0dFZaZGJ2K0JwYXM1?=
 =?utf-8?B?aGFVQTNpditwbjZ5N1F2eEU0ZCs0S3J4V2hVWGVJUnU2R2pHeWlqeGxYQXVU?=
 =?utf-8?B?TzdMUVVUU0NXUXdsMGFwNkFqTGNOVlR4cFFjV24yYTRlTWFRNXAweExtNjR0?=
 =?utf-8?B?WVMySno4TGU1REZraFJUYkthVDNRSU9JNXZtK0NBalgxa1N0TjdUYjFsejFI?=
 =?utf-8?B?VmY1NWQ1T2tjRWhFODc5V3FCT2JmL0Vxa3pWWU9IaWtQZWhkczVLR2ZKSDV3?=
 =?utf-8?B?cm93SWNnRGU2Rk5qQ3gzRkY3d2hSdVpPS3dHZDFvNWFMTk1nTHhKK1ByWHA3?=
 =?utf-8?B?bVhmcFkxbmE1dlh3VW8xakNpbFZDdTV1d3B6dzlpUjZxTkJ4dDZ1S29Dd1M4?=
 =?utf-8?B?L1FMNGNtaEVuT3kxTE9NYnF1ODdQdTE2cXZtVzNZOGhrMTlrSUdhREYvcmZK?=
 =?utf-8?B?eFVORW5zWElrc0V6b1gvRUx0Rnh1RHNIU3FyU2E1cXl6UVZKdFh1Yml5OWlG?=
 =?utf-8?B?ZWNLWXZKb1FNLzBWeVBSWkVUckIyM3VBQzZiblJqODNXSjVORFRCb1NGeFU5?=
 =?utf-8?Q?CPDLAIr7EHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlkwQmxhbVZiRU1BcjcwVlBTTFh1enV5dDhDanBENXFOMFdYeXRzZ09RZkN2?=
 =?utf-8?B?WFJtQzlMNmhuN3RMaHBKZkNvYnNGbTZ1S3U1Ykg0dSthYnI4ZldZdWgwWjM1?=
 =?utf-8?B?bDdmS1dZd00zbkhOV1d0cjc2Vy8wTk5xWDgyY3F5aDdrcVp1TFJWZVpDaXBF?=
 =?utf-8?B?Rk5ZVHc1S1I5Qm4zRThWWmhKZjdkbFZ6TXlJSHl5eGFsR3BDSnJnbXY1dWRF?=
 =?utf-8?B?SmxvM1VGSmw1V3R4aHVDQ3d0Ukt1d3c1RFpyMDFMeFhXRzUzSDdiQ1M3R1JW?=
 =?utf-8?B?Y2JHTG1ZcDBNVlZaUWFjNE5RRG5CQ095cXhFcS9UNHVwd2M2S242Q2FDR0Fh?=
 =?utf-8?B?ZmVPKzIvV2Z0aUc1QnZoZi84cVJwSTZDbWtUOUlQQlV3bG5GUlRNYm9pUyt0?=
 =?utf-8?B?NXE4N3l6ZHNOMlRuNTdNWXoyTkJlUmt5S0w4TTAyV3hyTURNdUd4L0RiT0Zx?=
 =?utf-8?B?ZjJSV3hiYVIvWTdKNmw4TFJhM2hrc3lxZzlUc1NBcVBRZ2htZDhldC9yYmZ1?=
 =?utf-8?B?MS9YRWlEWTF4Z0dSdDg0M2xmTFFrV081MDQ4b1ZKV0FKR3p4U3J3RjJHYlh3?=
 =?utf-8?B?aXdsNG45T3B5NW94NGNpb0t3eloxZTZIVTFUeXM0NVRUZFhYMm1rMkh5eTBI?=
 =?utf-8?B?YWFiZEZSZ29RTDFwczhOSDYrTk5DTktzVGVWMkZTS0JJdVg1NHZaU1VqbkE1?=
 =?utf-8?B?THc3a3ZTZ044UUNZVmFzRUFnT3BXbUMzcFZJaEV1Mzh2ZVN2VnZJWG83bG13?=
 =?utf-8?B?ZGsyNmpMWG1hTUNzVmNyYlUxU3JVZ3pxaDFkR3IxU2tMV1FaREhXVkFzNnBy?=
 =?utf-8?B?VHY2QjgwbThuM2I1VW9KOXZhWWVhcHBTdGt5Y1dyYkVHZTAwS2dMWmVqSS9K?=
 =?utf-8?B?NDNVVzFXcS9MajZMNnV1MHJ4Q2phWnNlMWFsVkx1YmFmQWtLM2RIdXh5RkNI?=
 =?utf-8?B?aW1VK09LMkJLTzFGU1ZTTWpWVk5vNmp5K0FaekRCalZnMzJSb0hpZWFMcUJl?=
 =?utf-8?B?UStVUW16Y2hBTTdxcWxBc1BtK0k4UE9TaDkrRE9WSCtjeVg5cDl3dGVBMVVv?=
 =?utf-8?B?MHBjdHVJWXFqWXMyS2xJTmo0OS9KNDlQSjFtQ1hZR0ZJTzVhYndGR2VZNno4?=
 =?utf-8?B?UXRUcnRrenh3cUNyb3ZvbDVXdUhqR1I0TkhHL3ZwZW55d09nNmpkalpVWS92?=
 =?utf-8?B?N2cxNWZoTjFtd2FiMmVHbC9sR1FoNGlJbWtVV2cwNk45NkkreXYvN0VoenRk?=
 =?utf-8?B?cnRWOHNVVlFGQ2FKUmVzY2FCQVJRVEJRNnJ5TXdMWHNPMTF5eEF3NzFiZUVJ?=
 =?utf-8?B?VHNGbm9XRitXV0ZKOEIrV09heTcyVmJJYy9SQmlic1RwaVdHUnZrbHk3L2s5?=
 =?utf-8?B?ME04akR5bjBUb2MzdWIxZUx6WXo1OVM4Z0J5MXljZlJVWVp0U3lWQ1lwU3JW?=
 =?utf-8?B?K3ZYUnZCdzd0WmpOK3pjVFpZSmxOUi9ZN0ZVV0RoLzBSS1pXOTdpL2c3LzEy?=
 =?utf-8?B?bjVCOXNkdTNWVTBhZTZwUXZFZTdBRG5UaThTNkFkbVlydVBjcTVWby9BOGJw?=
 =?utf-8?B?aSs5R0RNUWRXT2prd1JiWjdMU3F5eDhaN3pKREtOWVBLRWNMZGVYL3VTYU9h?=
 =?utf-8?B?MXM5RW1nQllQMi9vWlFIZjFXakRpWGp6azJUQ0ZCRkk0cmlEb0E3eWt6ZE5m?=
 =?utf-8?B?ZkpsZzVKbzE4RFV1UWJ6d2Z3L3VPcDRyVUZsbmYxQnVydXNiblhoMGlPeUZr?=
 =?utf-8?B?d3VkSFhFMU4vRnlxOWlrMHk5MkZUeTlmOGF5cEdxRUI1RWxObXJNa21vcUpB?=
 =?utf-8?B?bnRIU1hvMUw3dGtDSEhkWW0wT3hCR1NxQlpuTFNpRFdUMVFTcWpaZUxsYXBU?=
 =?utf-8?B?eE1TNWxLTGRHWEFXNE9LZGRwRlQ0OXB1eE95NTU0SVNzd2w2NFI4MW5yanhG?=
 =?utf-8?B?aUlWdTI4aXdYNzBHMEMvUXJSTEpNdmRrdFhhY05ORHYyeXQvalJXSkpOTUQx?=
 =?utf-8?B?WDlXN29TOUkxbktaMytYT3VWNkp6VHkxRDRuU0VYeXFVODF0dUxTazFBQTdk?=
 =?utf-8?B?TFdIcVNVT0tOWUlQdC82aE5KVjRUc0IxNi9KYVMwamhmTEpaVGFWcXhJVzVj?=
 =?utf-8?B?YWJzckl3QTRoT25zZVBUanpTUkRJd2MyRlZpcUVST0xJSkxVdGpYRHd6SWF1?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RCpvdnx0H3128znwmJgZt+bSHo/or469iK4iZVOjiYJ/+Pl0253KhSUkGnnTZhCEut0t15BKrOpE346uCZvhXmwfEbnfo6OEKcI+6QVlJT1rEzy8p9UB7VSElmwAnUCHnnJH4Pwra2rzWilzUMhzFk0eijFhcvlf3U96Pk91h6PkmOTBMgEDC6pvqwr3k8Mp9w3xGmaQDIcCAabvoQXZjgdnBGoVarMX7sNifWZoErI2xRy9tk/UAHfZF7AsOVeo4CbBza/0wx+scUGUloZAx2J5Piscptuwp6QsKZXQsu4Oi8KQFJMyDWo8wQMZ10FG5kxMtmXF3Vlk+n1i4JhREqnoAA/8RgX3VcXsa7e1VJm2CY71DcyjvF94oXFuwEjg4Li7+jV1ZH+DZAzH+Af+BHz8g7cIxyT3NDddJeYZOcKF8WglOEmVG1hkq15BYuIUzY5KMl2+bjQgEooFKFjWdTRGaBMdLiEg5Xu4qpbR7ApgNsqgH6sZcuUQwXldla8YUPltrG1BDg217MwxxTB5Fvg/HsvwL3nKorBwdSqtfig1GzKkhNOex7WQnnwVxfF6f7+uzbwbUKsGdHBeB0gxlnNsUXVXSnTlJuqPS8tASRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877564bc-ecfc-4302-b34d-08ddf6276223
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 20:18:36.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mun3o4GSh3iqr11iMiddl2MMzWkvM6OThGxZWtc5HtEAz98GAc6JXdZlOLgdp7WEf4NpK6+6OePoQQ2ucQmrHw/awiwzXZUw8o64C7p4B7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170198
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cb17a0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uAHIfnhhP9HKLC8aBGMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: E1aks1ve8Sj0nfi1x8bvgYSZNUG7LP35
X-Proofpoint-ORIG-GUID: E1aks1ve8Sj0nfi1x8bvgYSZNUG7LP35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX4Fljq8a2KwPT
 FKZ6fLqnfllQjRraPzKBTst+YA4tuHrrUFbGC82nWkTiWSuLE9nL6DhbiElkWIZIgesHPHnv3pM
 ujREWVRg86hzfiwXcv11Iw118o9tGCnXpK+IQhrFlG4D+OpptUxO7o8tFYjaa7a2A9/K64+zuIN
 6Kr494FDXCTgnpRH/seizNeTo1dfJyu4nPPbmhsD8tqBnoG1QccpecfjTZ9h4kdQOSeAktTw0WU
 ZORcRry2Jl0fYFlGB3Gk25bzvh+PmESNCCBm1vcCpopoKp4ei4YwtqwuKejLA/dL3kODmAuYDQ0
 glfJRu2E2Gk/qhwFzsdNKqS0103yMczgZczKvE2fMmF153iQ1iGnMW3gpvy4USiUu5x+2CUJrbz
 /29T6eBK



On 9/12/2025 1:05 AM, Bhargava Marreddy wrote:
> +int bnge_hwrm_vnic_cfg(struct bnge_net *bn, struct bnge_vnic_info *vnic)
> +{
> +	struct bnge_rx_ring_info *rxr = &bn->rx_ring[0];
> +	struct hwrm_vnic_cfg_input *req;
> +	struct bnge_dev *bd = bn->bd;
> +	int rc;
> +
> +	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_CFG);
> +	if (rc)
> +		return rc;
> +
> +	req->default_rx_ring_id =
> +		cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
> +	req->default_cmpl_ring_id =
> +		cpu_to_le16(bnge_cp_ring_for_rx(rxr));
> +	req->enables =
> +		cpu_to_le32(VNIC_CFG_REQ_ENABLES_DEFAULT_RX_RING_ID |
> +			    VNIC_CFG_REQ_ENABLES_DEFAULT_CMPL_RING_ID);
> +	vnic->mru = bd->netdev->mtu + ETH_HLEN + VLAN_HLEN;

nit: does "struct bnge_dev" hold a netdev ?
if not should be bn->netdev->mtu.

> +	req->mru = cpu_to_le16(vnic->mru);
> +
> +	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
> +
> +	if (bd->flags & BNGE_EN_STRIP_VLAN)
> +		req->flags |= cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP_MODE);
> +	if (vnic->vnic_id == BNGE_VNIC_DEFAULT && bnge_aux_registered(bd))
> +		req->flags |= cpu_to_le32(BNGE_VNIC_CFG_ROCE_DUAL_MODE);
> +
> +	return bnge_hwrm_req_send(bd, req);
> +}


Thanks,
Alok

