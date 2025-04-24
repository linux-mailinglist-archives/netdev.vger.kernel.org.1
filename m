Return-Path: <netdev+bounces-185451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2BA9A6BD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0581888B28
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697222069A;
	Thu, 24 Apr 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ge8iU2IE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W00kdO2d"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7191F75A9;
	Thu, 24 Apr 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484362; cv=fail; b=ab61nDQ6C0KGmHd05mJdTwxAiL8AoFLC5g66NyVPU6DdOrxrTkFq/aZ92aOpTHxeRz0UyW4ZQ7PRlifGcK1Kbym0iryRNobul+BQWCyD6s0ZQeDBHdK0zzw6rpzmNVDpvoy1fDVGH1HLc5l/m1jnA+KKGNL2AAnHA+0FvKnKcog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484362; c=relaxed/simple;
	bh=RVXWt7SJd9mWC+G1C8mli7yLzp0dQt46UfApbR43F3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pYZs0gKY9TUiQdyO5XwIi3kGPRKOKTHkgUpEGscQDx7QFGV9eCDKL2HpIDyDrCWStK20ibZUrXuJ2Y9IcTkSMmEcSBXtHIu1QTJDGUceVzytTPpon5SGj23iYSGoSOSGwC4FuIau1nNlv1T0ibxl6RyA6lAJsOAbQJA4B5LKCzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ge8iU2IE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W00kdO2d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8R7Dg021558;
	Thu, 24 Apr 2025 08:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mYwytEw/HZ+RAPB+L4GtdLCtQ6AfPxVDK0gZpTpB/BA=; b=
	Ge8iU2IE4IeZpQgTHwuszwGoxTH1D7lfukpb5AQfYpdZhF+zZsoOv/DC4LCOdem/
	2UY+odBsKqqidH4l6tpG4Kfugyutj40bdjNeQtcs7qVK8PgBLap2g4DfVy7HfeMS
	PdPRXMrNq04iaAkgo0465nsUhRG8zxwHY+GlBzui7ihTAKEsUjyPUyBCp3AhpAqk
	H9ToRkG/bZrdLO0U0vuSToqZyHXke1wWREKR3mkoJed8Kzu0nbKl58ugELHRMaYl
	z0Pb6IB6f1KjYd1za5O2i+xYVHw5JmPLGALfDTDjPqpeL8iRHIR5Ee+zSHL1yTxz
	PrPXHsIXaDY8k72evLuUKA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467ht101vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:45:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8ZHbs028502;
	Thu, 24 Apr 2025 08:45:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx7809r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:45:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIfvz435SqFjRMlY8/9eUjwDgQLktqY8spQFcsGYksmR+BCe0YifPT5DkTwwHSrziGcu589jkZDFYOB2EvXh0kFWLfqfTbsM9h7CbpN7B0EtUeU7ja4fJtGGbNu/bEw58WqtyJE+cncoIkYvqeqEPxGz6wsIP0brkGNrAC3A74J25uNXV4f+cMViAcBVfmBT/zQMVvtCIeFPuO0npFB2t1UKe+yGTx3EB9sKoq+jbEoDNWNFQIxymZ56EFqHLG+Kvykc73UtHEmWaNn3c0w8nvvl++J9YGzLTzL9UXTMc8AXoYcjYdgolWVSgQ/2JNbSbFn4j6OkNpW85vy//zOMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYwytEw/HZ+RAPB+L4GtdLCtQ6AfPxVDK0gZpTpB/BA=;
 b=W7Ge9GDHcUBTvBkj5L4ZNgWMybRB7zI4caJQPe5PiGm4ihTRl2hPWJPbBeJCCGugE/IvHQ0JsiGaLZSBxSy3iP0rAaZVyAlKlZF8h4pF3+NqYIJa25JFx9EAp44apNY9Iec0fFCXE5EavceB/hcrJ28DPDj55aApmRSt5s1M9OWLg25i9267DD+2SCQFKp5d3KoR1f2KmnMhnlrtubnCnH0EMXGqOUDBalR/mxAvV0eigiaJFA1B+/iok2+J8jZu6Zh0Ll3WfNAib7IQGpAIoYzGP1V1cpxekUFZKUr6ah5ZDzbHfwnM9JWyaEawspvctORj+qNgbMBFoq2WoJSgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYwytEw/HZ+RAPB+L4GtdLCtQ6AfPxVDK0gZpTpB/BA=;
 b=W00kdO2dEL643hlThO3MraU1ndV6AbPLlLeRArJZJszJMcZ/pnSn1XTIL9RUkq0pVkZrR+L5oJUH53S7sOYZ9Svc1YfgdiPcUuYBFkSK83QNLAdqczFmMSCSiMhD6eIQ5calaxD/U3/X77L32XZgd2o2+pw1HrvmSgl/SsF2Rt0=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by SJ5PPF61CA724C7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Thu, 24 Apr
 2025 08:45:51 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:45:51 +0000
Message-ID: <8781b7c9-65e4-47c1-8f1a-5cbc7a975128@oracle.com>
Date: Thu, 24 Apr 2025 14:15:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-49995: tipc: guard against string buffer overrun
To: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman
 <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
        linux-cve-announce@vger.kernel.org,
        Simon Horman
 <simon.horman@corigine.com>,
        Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org
References: <2024102138-CVE-2024-49995-ec59@gregkh>
 <1eb55d16-071a-4e86-9038-31c9bb3f23ed@oracle.com>
 <1cc70ad0-4fa7-422f-ade4-b19a19ce3b61@stanley.mountain>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <1cc70ad0-4fa7-422f-ade4-b19a19ce3b61@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::12) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|SJ5PPF61CA724C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7c345d-7c0c-4ed3-331b-08dd830c6ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkFweHJUNVp6aTNRZkdhOEpUVWJHMjJWYnY3UUtwRWova1F3amdybWtJZHZ6?=
 =?utf-8?B?NmkvM1RSZEtrRnJDczNnUFFjVU1IbEhmUU95a25SRWNFRVdGNzVGNHhwejNO?=
 =?utf-8?B?VGFseU1YMG5hZWNhaWhyK1dsWlVLRmRDa252ZVk1ZUp2T05zeGZFS3JMOWgw?=
 =?utf-8?B?Z3hBS3JRYUhJNm9XbVdTZlpUYnovcmMxNDZhZG42bjZNc0IrelVpOW9WTklp?=
 =?utf-8?B?UWs3dXZKU01tK1dUaFZ2QnFZb0ZBeFEvUXdabnJJdWh6K1FiMEJlbWM1R20z?=
 =?utf-8?B?eXB0N0xDY0FjL0JGQWZ5MG9FdGQrVVVadFJXUk5FVUFjN1lUZW4xczg3cW84?=
 =?utf-8?B?TTNMeVNhMUFvYk9YZDM2dTRpaW9ES2NodEVyWTJhNGlaMWNjUlNERXIvRmdp?=
 =?utf-8?B?dno2QTg5NXVVK1pTcVNoaXhZeFFrbzFNYWVjaHhVMmJmMDRORWNCd2hBQWRM?=
 =?utf-8?B?dm54MTNTR2lVSVpySmNORmM5QlR1SjBUWG44V3B4T3BzRGxpWENrZmlweExh?=
 =?utf-8?B?SytUa3Fyd29iUUQ4L250b0hxd0orRWw2SGQ0ZE12WGRoV0NDNm9BODVoanVU?=
 =?utf-8?B?cWxCNzZsNFhSQTdjMW9JL1ZiVjhiL0ZaMk9WSGdMWGNQVm93MXpLTmVSb1Z0?=
 =?utf-8?B?YjBIaXFyRk05K0dNbDNvcEw3VG9UaktkbWJNbEI4VVZQS0FRRTFoNWUrVjZY?=
 =?utf-8?B?MDJ1Rm8vTHltRGN1cUd2cHVZYWNvNC9Pa3l3NWVqQjVvZFpiWnhVT285ZjEv?=
 =?utf-8?B?VWdFV2ZQeTI3cGNsY2N0TW0vazVTcmFLcllxdWduUE80Y3BxUzd3S3FkNDhn?=
 =?utf-8?B?c0hwc1hFOHVMV0xLQVR0ZkxhWCthU3RrOU0xdU5HSVMxdU9vTXQ5RTd1S2xZ?=
 =?utf-8?B?UlU4dXBpOWpmVkdFUUpLWGdoSzBwSkorSFphbWFPV3R5Q0tPVDh6Sk5WRXc2?=
 =?utf-8?B?Rmc1UFJocXhWMEJrNjJsSW0rcEJXTW5Wa2VJclJrdlJyQ3oyUEY4MVZKZ1RX?=
 =?utf-8?B?VnQwVy84MVRlVmZuSFltRG1vbXVPTm5BQUtWdWtwa2UyRUlNcmdpNEt3L0dZ?=
 =?utf-8?B?OTFxcVAxR3ZBa2RKUDNxcXZUMHlvSDU1bzBvMUNZZU5YR29GNFY5NG9ycWFI?=
 =?utf-8?B?Y3ZOblpYQm13MHoxbTczL3l1c2FqUUYrc0JjbVNneGdXdE0yOG5KSllGMStT?=
 =?utf-8?B?UVJkNzRYWDA3akJySk5TNkJ5a2JhVkFtaC9tc3kydWZpV3E3RTd5ZFk0cFZU?=
 =?utf-8?B?KzRGRHBJY1QwRkZ5YmxGcFBlbnBqU0J2b094VGZyVkFhRlZnR1dqNUtFTldl?=
 =?utf-8?B?cFh2bDJXdnJYV0ttM3pXY1Y2aFYrbmxaUDFZNzc2QWFOdSttZEdsSU9CSjkv?=
 =?utf-8?B?bzhtbnVra0tHUjYyVGV4c2s5b2k5ek91NVJNRFUvRzh4bm9qNGt2YXpzMEJp?=
 =?utf-8?B?dG9vbVhJa1NXUytEUzBlOHdlQUcvTnlOeUh0bzBBRTRnb00zYnBHN3NVWnB0?=
 =?utf-8?B?YnJkNGdSWU5zRjg4bVQyYWNsWmRUU1puVjNhcVJGQjdTR0p2bTZxUXFIL29r?=
 =?utf-8?B?ZHhrTGtLUStJOW1qWWtTUEZjYkZBby9DeXB1YlVvSGpMa2NlSVZLZVR5c0Ft?=
 =?utf-8?B?M0xmVXZnQjdsY2FQdlF1MHAzYTlmaFpNc3ZFdXRUOVRTQWhYRzIvT2FBczFv?=
 =?utf-8?B?WTdGTGFlMzFGYW14eTBSTjZ0NTEwNENFbHNiNzZNVmZkUW0wUGd6bkhGWkUy?=
 =?utf-8?B?RC85TEozQkQ1YlQwc0ZMaW9MQk9GOVVrRDhpeFY3ZktnR1hSaFBYdFhKeGV3?=
 =?utf-8?B?NjhHR2FuV3FKRnVQRGgwaHZEZzZZSlgwUlZZVjZxZnhDaDNScEUyMXdTbzhL?=
 =?utf-8?B?MW0yVkNRaTBKLzNjOVQ5MVIzMDM2RFVvMVNsSWdPK1VIMy9uSTBjeDBHSUdp?=
 =?utf-8?Q?OHS/moCkLCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUFmVzcyeHJ5ZmVzTzA2L0ZmSldYRWYrNlVFZUhiVHZ4cTk3SlBkeDJQVGlZ?=
 =?utf-8?B?dldhRFNETm9ucU13M2piVmFtM3UxTTNiZkxUa0lHeW80by94MUdoREFnSmM3?=
 =?utf-8?B?RVNraHlNR1ZRMFBCampWTU5PdUtIdldnc2ppYWxzdEVWUzloVlpwMjhHVjJH?=
 =?utf-8?B?Z3BpdHpMTnVqb1BjSWszNXRvUmVhT1RDaDAzbjlyM1FUREdHM0FFRFA4TEM0?=
 =?utf-8?B?VlczSVZlY3c0ZDJTZVZ3alpQOGxqcVRZd2dVckh3Q0dyYWUxcU40ZFduNHVq?=
 =?utf-8?B?V0c3NEtFUVFycExTWFRqYS9iMnZlNzdaRGVVTkR3L1ZLQlVUMmNjeHI4TWFH?=
 =?utf-8?B?QVVsMDBMRTZQZzZaM0JsWGdrNHRZd2FyZTB5aHFzVUs1enh0ckRyYzAxY3R1?=
 =?utf-8?B?UGkybFl4cTkzaVpVSlRWcTc2S29ycVp6WDlZWUZjdHlaZ1JLbDhYMzBLU2hx?=
 =?utf-8?B?NE5ZbFhBd1c5Nlk1NUxHMDRtcDVJa1REbGlCZ09HdWlyV0ljUFpqeE42R1Vt?=
 =?utf-8?B?RHlQU2dBN2F5STRMeHd2N2Q1aU51NDcyYUd4bzYrNDFlLzlqT0ZzUzV0bU1s?=
 =?utf-8?B?MWx3dC9yYXlDQkRRQmZVczA1OGZQTFJtRVh0YmpNamptZFc2TldETE85NE8x?=
 =?utf-8?B?MGVNc0xPUlpmYU10K2tQaDhJQTNmTis2S2JlbUFPSXFNT21raXNUOUc0YlJH?=
 =?utf-8?B?eGd5UUpHck45UWN1Ujg1MWpSU0ZkRTN1SUszNFh1bi9DeDV6d1U2SGNjQy9B?=
 =?utf-8?B?Y3BDMnhNcGVFclRDbkw4V2YwVnNsWUErTFdzWmoxdERaQ0FwNEQwb25GbEhQ?=
 =?utf-8?B?L0l1a2krNi9UUkl3WnRrcHIyZTc1bk9mbnpDb1VQVDFwbEVSalJHZTA4c0M3?=
 =?utf-8?B?Nm50QVVocDFsU2hEZ2pQTmIwZjg2RmRaUXhocjd6OFV4MTNlTG5iOWE0cG05?=
 =?utf-8?B?QlVBMER3a04wVDg1cjg2a1BEODYrL2pZaTkvYnpiVks1S0tnMEl2a2RXWnk1?=
 =?utf-8?B?OUF4RjJJeUhvVVAzOVFoRnlSL0RuZ2UwU1YvUmhBUEhpa0g2bFBXM3NWMjRO?=
 =?utf-8?B?ZEJVNHUwMElsRTJxM21nTGwzNHRIbEwvblViRGpsNktpYmJGNnFDR3dRSEhH?=
 =?utf-8?B?c3EyeHVGdHNRZWtUUHl2Um94ZE1NSHlWNENtdTF3dHV6cEFOUFpEelpsMGdC?=
 =?utf-8?B?T001aS8xaDJZRVNqbVdSUnZBYjJGT3FRVXRMQTN4cFZ4UFl2NnEwV3oxZDN2?=
 =?utf-8?B?ZGRlSkplMW9McE41am5aN1RPVW1uVlIxN1NpaVY1ZDV4aE4rN1lOYkJrQi9t?=
 =?utf-8?B?MFNsUWRON3VSc3hXMVc0cWs2eStXTmpOckI2YjlZLzhXeHZZbmgvVzJIT01P?=
 =?utf-8?B?b0xkYXZFeEYxVW9JdVVUdUNoYm1QZUM5OStNVkVmdUp2OGliczN1NlBJbFI5?=
 =?utf-8?B?OVQrN1VpTDl2UmRVeUNUN016ZTFTTUpieWR5N0FYSXJ2aERzb292Z1A5QW82?=
 =?utf-8?B?V3ZXbXJ0Z2JSUndyU2dpV2x0TzNhbXZxWkJ1dm1hSDd5QzV4c1YyTGgvdnVW?=
 =?utf-8?B?cmZ3dk41MnBKbEZBR1RyOTBtUTlGSFlKbkgvNDFtbTVqYlp0Umx0YXhsVlRI?=
 =?utf-8?B?WnlWTGdCZGRzcGc2RG1oTW9PbHNxY1R2QVdmeHhCci9DWE0xQVY0TVJYR09C?=
 =?utf-8?B?RUFQNU9hQnBURmhyeFFsTG5WeXEyWCtvZUVBbXFPSTBTV2RMOGVJaTk4S0pN?=
 =?utf-8?B?Z1g5S2lEZ1lHTlIyOFZHRnRBbEpRcEU1MUQ1MWhSa2QwZXdPbnV2Y1NNcjl6?=
 =?utf-8?B?bzZWdi84ZVl4TmpxMHRGVkdDSWdaMWFZWjFtSmdCWDJmZHVvVkVFRFNvcE1X?=
 =?utf-8?B?UmxsOFpwWFdNaWl5VFVwZjczYkZEVm0vbWp5bHZJQUhrV1Nzc0srbWxJNTlB?=
 =?utf-8?B?NFhDNWc5MUM3V0RSS0hBOHdZUi83N0JrazNNUkZSOHJOWlNkclN2aERzbXZ0?=
 =?utf-8?B?L09aK0pFbWh0TWE5SHpNKzZqMUhUeFJwbUtienFFbzBUR0svOHpycjN6YUZK?=
 =?utf-8?B?WUdxK2lsVkFRVEpXNUJMNGpJeEIwdHVvc2dpRWF2RUpEWldJeUtLWTg3TWV6?=
 =?utf-8?B?bzFSTDdKSWlNVW9Qa3Z1ZUFmeEdoYzdYd2FaT2J5N2pkV3ZmbWcvdlJOdEJs?=
 =?utf-8?Q?GJsXBOxkOfvRJvcwXqtbOPY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GgVqceOsSKVj3/IQ2/crrAVqBkXWs3mrfouqOvmOfg5v4OMMcg3vXodpmjJn2R6Tn8A3Gi7WB49d2ld+TyCGpzhobj1A9XwfrjoWd05vQMChP7ODGXpQVpNLz1//6Vwv9/Ifnbd5MV87+If4sgRc0D41K7r8dIQasPKweS13s3j9mJXfWdvVGhIJiS1pDT1i1MWGKUbvGjWRIx//ffFwCDBuoYHyQWmVmPTcT02GHMwvIV/2VGnYdLVtDofqMqENFF+LdRGUPa9YtC5onanV/K887YIDiwLhpxrMYefWr5sSGUq6Aral/5XjCYiv9QhWVvH+pqeA1uu5w1/sahzMx4DNxLpRO1wm2OEV6H3Bt5Caqek1kVSjJYJDk4dOnX7sY3C/PTKKoxKbG2mfog8OpgiFRFaOGsVbzy9SQSNwpEtoWYGT5adyY0b/Jd2bSV7DnfMQvNw19I9CfhsPyWUo17Gw4/yIl8aoDllwLw/6h57q/qqWFULs+NFcI6e8z3zAqBrbzKEona/zZ/BIc0CHuwTjZB1aYZK3H+X/y/OP1C8VKdB+/HfNDoS6Yf6unJDlqGcjWMnkklBGMcql8ZEaU7xUVf1I8fHhnkdtOAA6keQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7c345d-7c0c-4ed3-331b-08dd830c6ac0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:45:51.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up0smyyHsqxkZUzwWrYMZ/l+qqu7Wc8nuBpzNbsox1ijmFXktheVOphrlHbhmeyHgDnkw+HXJ+ZFxs7TDQMRJRrFeXJEUv5sr3TfC/G+J22/2+kOH9KMl8KFsMZhwqKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF61CA724C7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240057
X-Proofpoint-ORIG-GUID: F0QNl_bYyUmmU2zV5dFAO_Fus0RjpvwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1NyBTYWx0ZWRfXxibWH3NuATlp In1aoG4IMjdaT5kuJO9nVLgY6MOuJGOueH5MAAj24WwjOfsOtZSHiBtVZBx5Afipt67IwpmMOu1 iOvncDCwgHTgGF3ul/7kPbBtbrU7we3UCi3qMQ2TS/k/mGSeD9c5m507LwE4RcFnxuyYDHnBF7T
 ye6tSpTrfN09iaL7UOKpMXRXljUniDnpXVjondfgidPxdNE7MiDEEE+ipJyGuciSlV8oZ4rNt1D hyW11AqfHqa34NsCt+RBahNDnXgFGVVFfRJ5kip9+YJg9TDe3lYDPKinxjlwgvLNFOwvz9O9ABR GKkhVQ8+Jb9Ym/iNcb6zN59lxk/L/mBMCz1pV3FakKx4mF8zk0zqkP6+TpcALJVRqeyzUFRnFBm dHyEVtsu
X-Proofpoint-GUID: F0QNl_bYyUmmU2zV5dFAO_Fus0RjpvwU

Hi,


On 24/04/25 13:47, Dan Carpenter wrote:
> On Thu, Apr 24, 2025 at 11:41:01AM +0530, Harshit Mogalapalli wrote:
...
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6555a2a9212be6983d2319d65276484f7c5f431a&context=30
>>
>>
>>   	/* validate component parts of bearer name */
>>   	if ((media_len <= 1) || (media_len > TIPC_MAX_MEDIA_NAME) ||
>>   	    (if_len <= 1) || (if_len > TIPC_MAX_IF_NAME))
>>   		return 0;
>>
>>   	/* return bearer name components, if necessary */
>>   	if (name_parts) {
>> -		strcpy(name_parts->media_name, media_name);
>> -		strcpy(name_parts->if_name, if_name);
>> +		if (strscpy(name_parts->media_name, media_name,
>> +			    TIPC_MAX_MEDIA_NAME) < 0)
>> +			return 0;
>> +		if (strscpy(name_parts->if_name, if_name,
>> +			    TIPC_MAX_IF_NAME) < 0)
>> +			return 0;
>>   	}
>>   	return 1;
>>
>>
>>
>> both media_len and if_len have validation checks above the if(name_parts)
>> check. So I think this patch just silences the static checker warnings.
>>
>> Simon/Dan , could you please help confirming that ?
> 
> Correct.  The "validate component parts of bearer name" checks are
> sufficient.  This will not affect runtime.
> 

Thanks a lot Dan and Simon for confirming this.

Greg: Should we get this CVE-2024-49995 revoked ?


Regards,
Harshit
> regards,
> dan carpenter
> 


