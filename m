Return-Path: <netdev+bounces-222218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D6B53957
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983605A05B0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7B33A03D;
	Thu, 11 Sep 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h7KXfySA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dH1Q55f6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1A34F476
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608357; cv=fail; b=NUSQlgwLVi+jXX5Xa23vV2H3rvqAJvaPSm0fnOso82LImFA2GK405CC4vrbqSsZ51JxY6Bdop/+EfmXfjIA5lyXc9mJm0x5+s+yp4qSwguSJg4Vvm+OrLZagYZZtfBWC9eYxF2MT6P6LrkGTbizQKJ/Ft/lJIWfwVaZhv0acwLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608357; c=relaxed/simple;
	bh=qeMqCZ3e25hdUVTUpfBbwWXflCl6q+YAEzFXcNd3XsE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXvWXpa/mi3PAp9sT8gPlgSQtPvquhmCCzMN5epE3auEx1y/9V2zj3SP7vY9FhA1iZQAtBZCA01IX8+BNvFtvfNmjzGW7ldJQd58V81oUh7akfWwiovkuVWxM30y1TKL1kkUZeCbobDf3exGCZqzCqfh5algA+PF3lNMoY7lhcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h7KXfySA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dH1Q55f6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFtsCM019091;
	Thu, 11 Sep 2025 16:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=182EDYwksUfK+ccdOmwn0UP9TpwMSNx4SuSMKStIR/A=; b=
	h7KXfySAr21lBlfbac6kvle1Py/2ZUtHxVAwCUX6jaPSFxQiCgb4m0Xiq7Q1sixH
	vNzw0P+FzBF07hJsQOr3QNWJltubDj53FXH5L4phhJ4t1jyR5Vcgnmvi1MoTVGW9
	KLpAPVroltzH6PVwJMxg2AF+jRyL+8wXpfULx/URske2fkhxXpgqfpIcN9Ap5sab
	/61lsarDuYYK1yYZxFil6V1200ir7zjfMlT6J+i7SVAYWLNFZ+uMJ2TqqLFgFgcT
	5MHhqy6YXast55p5LvqPKsQFcq7iPb8TwzsGqw3jbFE8padH8OunIA+4uXorUmV6
	0Z1T2t4WMjDIut23WDp9/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x96kjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:32:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFR3qs038735;
	Thu, 11 Sep 2025 16:32:23 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcpbsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/JFwCgHaUd1TuVuXyGE0ZiKNU7Ot3Pdg11gK+3p1rmBpRKdaju+KyfOEPlKOSkU92irvFIid0gEP04oZ05z6KcxKerjzd7XR7UAy+vKHKwyJzKgtMVSQRuN0YPCf5FwpOA/r8O/JltBHnXsmVmv35mJzvDyBcyiySf2qJmRdOmTDeDmivSUvQc57YHgADALV/7GibY/NU89zBNwl/TKfmm2p7SwXvZRwPJE6eqRAAEy3sre30H4aRbUjwTobLy5l8vwO7ZcDjjYSBdijN11b0FOS0R9WkaGF65tcG/wr8VtFvLJE8MO/yiLIaZU9E+tcRKL4vdPdK0sVpofK+iVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=182EDYwksUfK+ccdOmwn0UP9TpwMSNx4SuSMKStIR/A=;
 b=Bi73Nr/8kGVX0/XN1DTb7DHJHBa+ltYg76vpafA//0xIf1g5K1YbkM5pk+8q3IfRs3DUQPO3zQ8VNL1FZTgMsMLM4IfgTmsyyUF0q4vgFyDtT0hJLZpdCLk6ZQ4rc5hVoRdv2SpbL+1UfQB1VsLBPiNZBbeDUN85nK/hh+BQfTLWcNF/NuxjJ74/cCo59krA12GKf+IRNjYyum3yd5TZYr6FypchJWodNv97SVGQlJGZjSCW6xiMn7Mo14ZS7dJBIV5d1D9mzlx6rGU//NQBu8KQJT1axvGUrj7Nl5oFvkMk0JxP7F8oHOAcCAqKnNsIrGNahPelmCiVWHBpZ5cIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=182EDYwksUfK+ccdOmwn0UP9TpwMSNx4SuSMKStIR/A=;
 b=dH1Q55f6+92gd7hpXRmWWFS1mSW8bQkhVOQEhqrbJdyr4MF+A9L9QelOfi6NI++CGQCA3uCeN/ScohqUC9S1jEtO2gZfup/h5HBC4/9VPhZ2veFS8IKCTwMLMxRI1gUGAHUpCyd5aoyhTkK6sM858qZGX7Kjy9/wmr/plJz9r3A=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA4PR10MB8730.namprd10.prod.outlook.com (2603:10b6:208:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:32:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:32:20 +0000
Message-ID: <bfaed66b-6396-4cef-9111-37a074c210de@oracle.com>
Date: Thu, 11 Sep 2025 22:02:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net] ionic: use int type for err in
 ionic_get_module_eeprom_by_page
To: Brett Creeley <bcreeley@amd.com>, shannon.nelson@amd.com,
        brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
References: <20250911042351.3833648-1-alok.a.tiwari@oracle.com>
 <e6f5e027-db2a-40d0-a585-af1c8a0ed00d@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <e6f5e027-db2a-40d0-a585-af1c8a0ed00d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0123.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA4PR10MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: da1aa498-e490-4110-1d28-08ddf150c764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWRLcGlQRmEydVNCa0ZBVGZWZVJJZWNQQkNrb1JmUWlRQlJyVmlZNk41RHVR?=
 =?utf-8?B?YjdlQjB0ZXUrZm9mWGlMZ0hNSWJOaFd5VU9MQUtJU3gvZ0pzd281NmpzWGZF?=
 =?utf-8?B?ZlQwbXdFaGQ0RllLUTAxQzZuNEVYNFUyYjNMWjByOG5nT1Q1bk1xanhEb09p?=
 =?utf-8?B?N3lLb0hDSUxmZkY0QXJJSUtLOGllZkpLWFVnd1RFbnc0VmpOSFNDVG51OVA2?=
 =?utf-8?B?OGNBenJFTDJraGlleGxqeTdYaFNwOFpLNjVrWm9NSU0zTkxRWjI1bkNESmN3?=
 =?utf-8?B?K01iQmVQZWJFdUNuaktldDNGUVZhdG8vZmhSeUUzQ2RYSGt1WWtZU3p2NllM?=
 =?utf-8?B?ZnUvdU5iWXQrNk5ackVmd1BXV2toSjIvNlp2WlRXTytVQUVQb0dUVGp6alh1?=
 =?utf-8?B?YnpKM3cxc0VPbXAwVkp1TkN6bmpLRmZXcGE3Zm5uZ1E4a2JabVJiSWNtNzgw?=
 =?utf-8?B?T2hjTndQZ2gyNmpKUSsvSUt6c2xBMlF4RkMzaDRKVTNjTHJvdjFFYjFNN0xR?=
 =?utf-8?B?U0dPNVBrVnRIRThUUm1tamlwMWJKRWw3alN0aGdnY2JiWlRyQnRRU1BpdGFy?=
 =?utf-8?B?bDNwS0Y2QmhNazIrVDl1ZTVDaXdrY0xTSW9xWFNMTFNJbFhoNUdFNkNLVWJl?=
 =?utf-8?B?blBlbzY5USsreGYxV3ptYnloNldEaWNVMGJCN3RDR2hGZzZNaXd6MXEyN2xQ?=
 =?utf-8?B?dkxvS3ZMdG9EVHlUUkFnbXFmWGFnbXNTdzNET0ZKbHdLdzZ1YzRWbGp6MGdk?=
 =?utf-8?B?TWVQNXVoZGsydE5yTy8zdzg1aTB2MHVhM2FqRU5EM2J3eTFpSDM3cXR5eDBJ?=
 =?utf-8?B?M3dPVmo0NVo0dnlnTG1kVHpsazZBVE1ZMVdHVGo1TnU5bmZLSytpT0ZKb2c3?=
 =?utf-8?B?QmRrR0hmUG9BS0plRjA1cC9zUkd2ZEs1ZlVxQVg5VlZiQi9PTXZ0cEIwaktk?=
 =?utf-8?B?cDdCQTR6Y2F2blJUdjJqS29zbk9HNGJXZTdmZGE4K3BOcXpCbm5sYXB0Q2s5?=
 =?utf-8?B?TnVpWGJhby8wcFh1b2lyajJzTSs1QnI0UUF1OTdRQ0dKTU5VWURUL3EwQ2tZ?=
 =?utf-8?B?NXpEYjBzbHAxb1dZZUtEQ0hkMUdlQWp6a21aT0VlbnZOTHFjKzZwS0ovUytO?=
 =?utf-8?B?TWdtT0RLWGFCRWQ2SEdwaGQ4WlYvM1Q1Y1piU0V1NGUrdkJIV1NBK3VDSWNM?=
 =?utf-8?B?Wm40QXJkV0MvVU5HTFkwVXR6a2R0VGorMXl5ankxcS9HZ1FnZWhwYnpqUHl0?=
 =?utf-8?B?bkkwdFAxWmJiSnoyakt4VjkycW5RVW1LTGN3enlEZENHa3Bac3ZraU1xQlJY?=
 =?utf-8?B?RDVRZGYwS1dVMGtCQTc2Wk4wR1RJeGw5WDVvSXFOZkUwYUxieFIvbFRtVDdI?=
 =?utf-8?B?YjZVQ1NDbjBHVzk3Mm9PQlZJaWJUOGZHM3RaODdZVURNc0MzdTljcGFnZ0RZ?=
 =?utf-8?B?d1hEVDcvcFE4a1hCenlaREZoeEpqb2pMWFdtYk9oU1NCaWQzZnJrS1FPSWJP?=
 =?utf-8?B?dFppV211Q0FHVExEZ2IrUkdUbUpWVDlXbTUyQmpvSWRPdk9lNmErckNVNmg3?=
 =?utf-8?B?anYxTy9EeU5lUmpBRmxkVCs2MjhPelY1MlpKWnVqMzg1bVpHN3pIaFJsZDRR?=
 =?utf-8?B?bDArUHIraWpLZExBZGNvUTZINCtsY2h0V3hGOTNLRFJsZk1wOFpZZUk3YmNL?=
 =?utf-8?B?T1ExTGpSODFYZ2VZY29DdFRHY1E4US9keHo4WFdvd2hKZE9DR1BoZmQvQWZr?=
 =?utf-8?B?aE52bU1hVGRuOVJvc3Z5cW8vTis3K05SRXJ5LzhRNEZNUGkvbDAwNnBnMlI5?=
 =?utf-8?B?MU13V0kyRVVrR3F2ZElrTVdNejQ3Um1VM3JuZWw3ZzcyWUI3V3RTejRMQkNm?=
 =?utf-8?B?eFBheG9ybUlzMU1hTUxvTE9IM3hJWGJMVFlQUW05YVFxT2E4Y3QvWU1wTVJF?=
 =?utf-8?B?VXB3cmI0OG9nazdZV3hPNlpUV1FGQTBzZnJpWGdrSmlXb1JpdFljSXdsZUww?=
 =?utf-8?B?VGEvWWsycU53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTRCUlRaTHFzT3F0MGo1MHZvbnFHSDhjNWROaUpDSWtGNWk1SXVYcmR4V3lt?=
 =?utf-8?B?YWhjNUFIMW5kcUY0Qkg1UUdiVk4zdmt0SUloK0h3SFlUa1lMR2pzTzRzYTBJ?=
 =?utf-8?B?Y0VaK0xyL0laOFk3Smc2VmxXNDZkSUQ0dWVGTzJEckRQZkpZbTgwbFhDaGh1?=
 =?utf-8?B?SjVHMm9abzgyTEdiYWJIMzVKL0puYVdFNzZnc2NQdWU0citPcGpvSnRGT3FP?=
 =?utf-8?B?RVQxS25IaVpxNTRDYTk4T3pRV0V3eUkxcTl3UDdWMUpQMjFZYlErR2ZXN0p6?=
 =?utf-8?B?V3RJMEYrQThtZXNxbHFhZkRQZjNWZC9OQ1RpOStkdkxQdm02Yy9hZDQycTl6?=
 =?utf-8?B?SkJneGN2QTd1T1JYRFozVXg3QXFKTnN1SGJYMG82M1llOWtjYzBXZThUWFBy?=
 =?utf-8?B?OEVjSy9pN3p2V2wyRmNBVzBsTmk0TE94bVByNTJPK2FpSW5hS2VTQTRwWkV3?=
 =?utf-8?B?amJzMGtMUjQ4aE1KcTY1bWVjblRTWDlwMUhwSUFoY3Flc2dBZG5IczhoOEMy?=
 =?utf-8?B?Z2NEUkFrby84NUVieDZ5Q04vUDUyb1YvQkZodk5vVGdFOExQL29UR0svcVp4?=
 =?utf-8?B?VzZRcisvWUFyVVE1RWd4M0hDSUVwZHNucXBaajNNWDg2YXljZzVycUwyZjI2?=
 =?utf-8?B?VkVEZ1IxKy8ramVyNUdQMmhCbytmOUgzeHZ6M29iRi9OOFI2WnVXR1lKeDVo?=
 =?utf-8?B?VTIvalVSMEl4azlEZ05kd1lhd1hzcnU5TVhleTJqVFN6WUhvTjZhUXowYXRQ?=
 =?utf-8?B?U01QY2h2K3p1ZnpTRG80Z1pzN0k2bmJtNERFNzA1Z1FqUkJJN2Ywd0w3SWFr?=
 =?utf-8?B?bmxEdXI5VmRLd0hmQkNjL1p6ZkZqcmVlRU1zRG1MaUhEN3VVNm9za0Vzb2dm?=
 =?utf-8?B?RkZHZUEvbDhIdjUrVmc3bG4rVHJpQW1sSU1uWnBhZDJrV1dObjRuL1hEOWdo?=
 =?utf-8?B?cDRVeVdPNk1RaGgwbXdJSDdheldNakJGZU5oYWZhbzZEbEVpYlpOem1Ia1J2?=
 =?utf-8?B?RGRGTFVSVk9RRStxR1pKOElaR0dkSkw3c2x1cmx3Snc3OVNMRGI3Mk9YMndt?=
 =?utf-8?B?SldQbmhoeHpENGlLSlRmUXJUaml1cmtERWJscndFZEVPRFR3d3VDQkdmQ3pl?=
 =?utf-8?B?cXpPWjhIMGU1NVJ5NEpIbXlDNVM4MHhYZTEwN1hxTithQk52SXlVcHdra25Y?=
 =?utf-8?B?aGxqNmpNcXA3Nm4vQWtPVFM4YXZOUFBGZW5nWDhlbW43VzRzcW5sc1NVclJG?=
 =?utf-8?B?WXFLZVZEWCszemNhQnNhN3R3azU4R0VWZzh6M3RKR2trdTh6alZIbVFuRUU1?=
 =?utf-8?B?NXQ4M0Q3R010anNJTVN4bDVKaEx2OTNGa0phN3UxSjZlWW1KNStSSU9GYm9Y?=
 =?utf-8?B?K3VYT1h5REpQMk5zcXV5aFAwOW53ZWorSGJvTENLSTFVYWl2MG9DZUVqNFVy?=
 =?utf-8?B?SzA4bjNkdHh6OExZRGRVbUt3cGNrcEdoZGFJcW9QVnB3U0twUUdJZEVTaG5W?=
 =?utf-8?B?K3VBbTZiY2YrdlpseFhieWR4NEFPdGtsaWtYbzF1WmZXZWR5VTROckgrZkpl?=
 =?utf-8?B?cEt4NFJpWkVPMG9jRWk5eHRzblhVQU9LelZrNUtvaWZCQ0lWWE41bXpiU0Z3?=
 =?utf-8?B?OVNwNDNDV2R0VEU1UUVhWHNGZldiMjdNUnd4L1U3dkdacnRIclNPUDZaeVo1?=
 =?utf-8?B?U0VBUExHdVE1VnNHZEF0b21kakVLakFkYW9zNEExLzY1Z29mU0FDNkdDUzFj?=
 =?utf-8?B?YlM2dzE2UUIxcEtGazk5aDF1R0Y5K0tZaDZVZkV4OVJXVjhRdjd4VDNPUWtu?=
 =?utf-8?B?ZzJoYVA0aUdtT0NaYmJkdWgvOG5QMTI5d0lIV2p3Nml5NlFzYk84TDI2L1pl?=
 =?utf-8?B?T0JJeVJjZkpQUTlkeDZnRGUvWTlDZ3h3bE5MOWVzakFkMXlvNitLRGxjYUY0?=
 =?utf-8?B?SDJCUno3b1NpS2hrMWRpcW5WSWZ0ZUJHYlliZ1dZVUI1MWljblVuMXR6NUwr?=
 =?utf-8?B?TzkrSkVMMFlNT2FOS0tEOFl3RDRxMVBYUFZFak96VFh3N0J0WldDVHgzNm4v?=
 =?utf-8?B?YU1UNXo4QURxQlpVN2gzRHFtazMzWmUyc0l5VHlwQnhVMWRISUc4RHoxSXV2?=
 =?utf-8?B?ZFpyTTZlako0T2xPZGdGTkhZc1U0SEJlQXp6dWNlV1lxK0hUWGdTQWd0VHl1?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0C/+A8BCXabcCsY1Xf57E7V1ufGW6jH9fszIe0ftXEg0G+qXyqkhya4I0dx4cmUWUZjFVmmTXJ5Nk9XKvRTP8L0rJhTyHbEbZJmR8DW++rW2HgCAuLpZ5mqlcmXylNpzNGlz1GSdpdW2tAIxgl3CpN0DEKFq7txCmu0B9i+YebkUCuzMdzZqEK3JyQU2WxuSF+O+XD3uv06HgJWjSJ1RA75x7zGzVB4oBLWjAO8dF7T3hcpyHXlP8/XXLXDCyH/ZBVQy8OaKsuRrclWGUyVhB2O5dmrcrbdRd5LE3C9Qxt1XRkl/pmBT3MRh/PMkuWC8HX7j7yqhK/5lVZqC5DepLAvK4H2srvV/dlH6d+jXKLacmlNwWp5uuTAzXcH5c1BhW5TFq6yQlR8FKByhbIZe7L60GPWoVx7ptPuSWmxRuPRhpr1bclyThDS7uPpjCQasiS7rG7lgYfJGDQ/wlKh7aatRq32V+hFjd3F5sHbhcxVnVVGdCrw3d0RLfXGNpQXGWzT5Aj6SXJeH6oHN61HbdELwwgdR4/lTsyXRWWX7+wVAWKgfmD5t37BNoFMNfD8hRBENH68eknbAfGHfC+FaKy6Mti7H1wGU3N4pkHA61kI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1aa498-e490-4110-1d28-08ddf150c764
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:32:20.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LM923G43NSWus/C36TiguOfYED02C6z7nFbnWjRIcYYd4hWp9RrWaNtsWbai5lPN6XLXipVrMS/5ffppLCGw/YHz7we3Z+wqHziNzp3Q5yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX57o+DoX95dqt
 iMt7OBHul8w5ioou1//NXHIjge26mZvI5Epi6xEnRudOmyB8A1thfBvmegeNEhM/lz5d8D0wqof
 jRtHPHgNFasLiPE+GhE1FMiGfaTkPtcQLPPVMr6aJRtsJgEKVlm1jv/yVZQsjIgO5eKhpE1HrdU
 0njBapq8hCP/a7teMtrheqzYUKvax4xHq2vPYXwPotyFZja+R3hvDHBX/ps2bbd9Eou9ZM2YKp6
 opOqvLA6gXfLU1Gg6zuB7/5toJrt1DREoeByFlqIm6wTPlBK2bgMd+hmF/BsBADpq3H39dSCyTQ
 QWxApfR59hGm5ptF0+WAAav7RMWBel2oVYzQKt35eaR/4PxP2QQrtq/ZgFMBv0wibdKbZMzyJrX
 xxiBcrIsWKYT64GC3X2XjCmfa13nrw==
X-Proofpoint-GUID: tyOtGz4srrWYqgvQdkpcFqW-s-1i1nNg
X-Proofpoint-ORIG-GUID: tyOtGz4srrWYqgvQdkpcFqW-s-1i1nNg
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c2f999 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=mQt2siYc7du0hSp4KvcA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083



On 9/11/2025 9:52 PM, Brett Creeley wrote:
> 
> Thanks for catching this.
> 
> Minor nit, we don't need to initialize err because it's set before being 
> used.
> 
> Thanks,
> 
> Brett


Thanks Brett,
Shall I send v2 patch with only "int err;"

Thanks,
Alok

