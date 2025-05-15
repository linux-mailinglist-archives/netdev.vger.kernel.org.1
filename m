Return-Path: <netdev+bounces-190749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69319AB898D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8465D4E5450
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA46B1FFC77;
	Thu, 15 May 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsbXAxuR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QYj5VOgw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9801FCFFC
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319772; cv=fail; b=CktrYRWxK+P1gc8XmqnancUdupfTs8qqS+9SReMbIRj//rrXlVutpHGV6qUWLQF8Uq84as9QH95qtok+XIRVAeaktXfSZYXsJhcGT36S3dzzVZzJtpE/ukRViWX73Dn5HxDlTkwebcMN7cTpD6JonjzWWSjuKljj3No61GCfxKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319772; c=relaxed/simple;
	bh=JU0G8IgV0MtSkUYGbg7xCvmrObtlsShrX2NxLCTZp7k=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=lxU5Qu/kvTCsIXeQzxTHa1HrjcyJ24Sy1kl7pblw/cdh5jO1O79Erlupa3OqASJ7TqlFo/hCJhSx1ajNM6xhdRorEJUvI7wY68i1iaSF/yZzpsr4j72ScTV9bCU53jMlQt8Dx1Wzuv9HeJbZA+fMU3Ic9qqTgx+ldWALe1UBqqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gsbXAxuR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QYj5VOgw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7BsTG011747;
	Thu, 15 May 2025 14:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=qgPGwSR5hU/ClXbH
	EvwFcg8CRlcOTqid1xH/a1M5L+I=; b=gsbXAxuRSiQZyb64cx0JWCMqdF6ewNjx
	/Utm0KNhT3L5Cjc9NrTruIJKqv9vEpoYo6RemXDZRN11XPJyV5MiwuzkXMGNfqVo
	jOG29259ENik+B8sFqxyMWei8XM8zfBC2pC/tUQzrnJUtFQ/KGV6vyNC+/kg4NPP
	I9aRqe/iVLbQrmLELN9bmwXRq0TSY813PaAmpqjGH3fTLHdZ5T7J/Mwyl5qLeBDC
	P4/P9SZSpWtykGd1t1RBVeKMPjuN2NBBNfrHvIOOxfIw+HP8ZGkOomEcqQqWh144
	Qk91mwbccx9VFZc/Q4wExDIAR1kmOuCapi6Zebqmzq4NlpieW4/uJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcmm8ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:36:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDFnh2026750;
	Thu, 15 May 2025 14:36:01 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt9dr66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwmLPp/1IcUL2y62XXRTKFCnCpnaOk2guTKjVGfSsNTkWvDc1Q8T4RIW0tx0dYPKozctYX7ZPXjqoym8+jTx3HuNLHswN7CN2W+YtObaoYlbqMVU8c9exrpkN1oMpIwFL/O0W4ZL2u4NuhLAqiKQ0V2gptfX7gn02bQcNRzfId9/MMbP9LzraOqm2iIJ4PhHT4tvputo6fDAhyhORsd/DJSM4AnmZ0zDHUkTf24AjnbaVrpV4+nAVE95TwtgtJOBN1Gf1KfqJ90ZBn10vEUriVrhPprsHN5PaPyMA+BbNu4FrCsuMZAiSbzEJUvaAjtfrXF3KZm4ARhjiJpMbjCHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgPGwSR5hU/ClXbHEvwFcg8CRlcOTqid1xH/a1M5L+I=;
 b=ckPkXZRvjfjxh1nxTPCsJgHLYEI+0j03l1gNcKlHI8fmq2ioIVjGyzx0Sp7C/KIPl4EFKh5ASmLt5mHR6wIVS/xv6hBRR6yLjfJ3Q3jEEEdS740l5n7VIGigE3BzRXXr1UUooLTmwp0DmGdEB+PkIp1GqVir1OFPNcgW0yGaQuO5+LHjuuJZN0QHxY3wRYl45MxwUFqy8SzLrsDiwvm8HfPgdjrrB67xzaYvYwq0ORYIkzF5Dt7KhQxAo7VaDzC71UbyvNP6Q8UlnohVALxDVPifu7IQjZaQERkIkPQ3aYrLEqC4g1Ocpu/mB7AXYTlwWwlLIHsy6kae5lFV/B1FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgPGwSR5hU/ClXbHEvwFcg8CRlcOTqid1xH/a1M5L+I=;
 b=QYj5VOgwZ0o4yfR2GYAWxzhQsOddrr5kfD/FAy6VMHw495V/9ZQQ6/gApLcDmNPSDJ+lus5sRGyhvazRFXR8MfdPZlBZq3ctwqp/VG/2BSwcpopmRKs8Yi5XH0ir7Ql7UdemQoYG87JjCUbAR+Ndb9o102StE4VfCz7Cg3WnK+Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8205.namprd10.prod.outlook.com (2603:10b6:806:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 14:35:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 14:35:58 +0000
Message-ID: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
Date: Thu, 15 May 2025 10:35:57 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>,
        Thomas Haynes <loghyr@hammerspace.com>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: RPC-with-TLS client does not receive traffic
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:610:55::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bce61b-3b63-469d-7f3b-08dd93bdcee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHI0WFVsMms2cFRXd2tEODlVWUxSOEhUV3dCZCtXMHpmYWhmUWEvWXBZS1Nv?=
 =?utf-8?B?TDU3c05jaTdpRjdJS0dJSmFJYmh2SGYzOE9IVGErRGlrdUVLb2o5dUR4QVFh?=
 =?utf-8?B?OVVmaHRBRXVBeXlaY0NQVmd1bG9lVS9LTEk0S3FZU29ZU0lnQWJTcjlnYy9I?=
 =?utf-8?B?N0FMc2pnMXQvU2xiSWo2QU44WnJ4aVQ5UGR1ZjBqNW1NRFZkQW1iSzRPUitv?=
 =?utf-8?B?SE56bC94RzM5WS9yMFdnVTBUUEk5OGFTNEFRWGZMZWJ6dWlWWlF3L3Uwam4y?=
 =?utf-8?B?cjllRzlteUsvblY5Ny9Zc2VFeHdWcC9KWnBhUEtWbFpzbWwzSEIyZlVtTkxQ?=
 =?utf-8?B?RXVOU1hFeTIybmxKRFhSM1FCYlNVMFlwRUVKQjRsYVVxeTNVMlFvOEY4ZHQ1?=
 =?utf-8?B?dXpOcUpDRVpTanNqaFAvQURKVkxxRDduWlhxdTczNy92WUlqcFNCdklodVBC?=
 =?utf-8?B?dWtHYThsdnhLdFJCY3pVMFdOWHEycEJlVHhQVkVFNkRqWGMzdER2K2pDWDZH?=
 =?utf-8?B?V2Q0TDN4TmhYTWhHejVpUE9oeDBYTVpsd0FTOVRIdjlVc25qWFR3bElCaG1E?=
 =?utf-8?B?aXpwcTNJMDMxais2RUcrRE5lNGlGL1BLdjM0OHRaOWwzVmF4cXJBMzg3bHM2?=
 =?utf-8?B?eGprb3cwcjUzTDJia0QrMGp5ZDlBWUxHV2E5ejRMOWxuMzJZdnRIOXZMTzlv?=
 =?utf-8?B?b3lsSTBkdW1wRjRXeXlpU1FUM2lWQW1xTks2RmVwTHRCSWNtbW5nVmJ1NlEz?=
 =?utf-8?B?MFRySWZTWnlZYTFEaklWbnI2MzAzYkFmejBweVVaTnFZNk5Pd3RLdGxONEZY?=
 =?utf-8?B?Q05SdmJXSnFHblFMQVhTY29KdXhvbHJIa3ozWUJuMWpUYy8vWnc1d2hZRVJ4?=
 =?utf-8?B?dHF0QVI1K0J4blR5YVRRU2ZvQy9oc1hCZU9WUnBPdnlwTTFqSmU2bWphSDBX?=
 =?utf-8?B?QUJWalhmWVp0ZERuUzBEWG95S3FhM2ZIVUpORWw3MHhYS1NINTFYWitKbDRP?=
 =?utf-8?B?c1R6RGFVaFZ3VFd6NEFYUnd4Q0ptak0wMnBjbG9NZE9kNDBGMWFZZFNYYXFu?=
 =?utf-8?B?cjBOa1hDemhqWFdPdHdxcklCUEVRMmIxclJWNkpud1dPOVRRaVNBTXVFZlg3?=
 =?utf-8?B?eUNvZ3BwcklldXhHdG1TT0tOWmZwdXdrK2ExWk1KdHJXWGJzc2xhZ2g2M2Uw?=
 =?utf-8?B?VXBnYVVET0xLejIwUC8yUW1mN1RnR2VHMExQMjUwSFYrTHVoVkpxV2Jpamxl?=
 =?utf-8?B?bkxmOWNEZW9ZRmxqZVEyTXE3Z1doeWRqZGI0MU00VlZkdzhCaU5uM2RKODRo?=
 =?utf-8?B?VnlpZXRSV3IvUXFscklFdGh5ZWV0MkFqbzlGNmdQeTN0clpGZmI4bGpndFJS?=
 =?utf-8?B?enQyTDdObEJ4a2xZaEtWYTgrTDNCSFkrbFFWcXBPaS9ETkhBbEpmUXc0YW5s?=
 =?utf-8?B?MmNpVmRkZ3QvaWh5elBTU1JHaFpTV0liU25UY2hjRzg4eFRrVForb3F2WTJt?=
 =?utf-8?B?djcyRnpubUR5eE9scUpqR1pOc0VuZUJ6TWxLSWxjdDhidXA3T0JBOGJwaE9S?=
 =?utf-8?B?eDJiemFoK0lja0J5S2VaQ0RMeU9UcS9yejh0b1dLNGlGT1c5SFkxcXYxbXFm?=
 =?utf-8?B?MmkxL21OamE3c1FtN0M1ZWVLZW9Md21DWktBZk10cnYwclVsM1VPUml0cWlw?=
 =?utf-8?B?aW1MZzJkb3lTazFwbWhpYzdxc2JEaDJnL0lyb0lrZmFKR1BjbllyQTc0cjU0?=
 =?utf-8?B?elNhUXBpUGhpdExOaFB4SFZKd3E1S2JxalRIU21vV0VrMjlOUTZRY3JmTlRo?=
 =?utf-8?B?c2o1VEJBM2xZVUZFSkNXdDhFQkl0ZFd6L0crcG5xYTRoc3QraS9NOGhWRlB3?=
 =?utf-8?B?aGZOQThYRFZkWTRsa1dEbnM3SXBmbFdrdGVQbEZEL01XTDdwUzI1RDRPcDJW?=
 =?utf-8?Q?NdnZ+31EW90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dktMMEtVdjNMdXhnZXQ1U1BEK2VscDZIWmxvbURYWXdRYldHbHl6dG1ucExv?=
 =?utf-8?B?cVAvY0lITFhNVUVSTkFSOTllZWNkeGJEdVd2L3pLbmRMc1A5bS9DcnYrVlVU?=
 =?utf-8?B?djRSM0N4WDBFWnBlL2QrNzd5bXdJc2pXYy9XSndlV3VDa0lVSHVxQUdGbEF5?=
 =?utf-8?B?aW8zSUE0TW5aVmthL296bitxUGIwWU4rVzRDUzBTRkltK2cvb3Zob21YU0V1?=
 =?utf-8?B?Z0ZYWk91YkRKOEp3b1ZHZk5QV2FwMnphT2pKdmZHelhxZE5oMVJaYjNwNmhB?=
 =?utf-8?B?VWxtT0ZBSDFSWTlHZmVDNzU1TDJnZkhabC9rSm1qWEU5SUt2VlJ3VXZIbi96?=
 =?utf-8?B?aTRDcGZSYjZxVFpyblNRTGh5YmF3d2VwbHB4Q2g2bEpreVRIR1RCNUdaUnZO?=
 =?utf-8?B?V3ZIYnliU25BTkJERDEyRkhYZjJ5U3huc1YzQjRSdEZlaHMvK1ZBcTA2aWY5?=
 =?utf-8?B?aEdnYW5JOWJjMDRyVVlUWEVkd2hEczBSbDF6d1BaTXRWNFdPOU5manpDaVp3?=
 =?utf-8?B?S2xpckFIRW1VTG81d1d6bnQzWmo3TWVBMnc3cWoxSmJadGpSclFRS2hNZjk1?=
 =?utf-8?B?c0tqTWptRWFYWGVDU3d5VXRmcnZXdTIyUFdIWE1NYUVhWHIwZVlnQXZMU0VO?=
 =?utf-8?B?Z285ODhTZGJaV0dJRVRyTnZ6c1RPdFZRa0lFY3hJNXFYMm41dHB5aHQ4Qmlp?=
 =?utf-8?B?MitzR21Eb1daS0dGSFcvS0JTTlpZS0YyUzcveUovTDVyVFZwY3RkZGFYUGhT?=
 =?utf-8?B?eFdIVUZURnE4Y29PZllyQ1VYMnorV0hOUEF4clFXbWdOTFdub1h0VHkrRS94?=
 =?utf-8?B?SlhFSVNPV3dNdTB0dHlJTURFUE5UMGlCRDhPZklGT3c3M29IdzRVWEdBZnUr?=
 =?utf-8?B?Y3B3QmR2cGZzVS9xTWQ2blJGUXA3M0ZlZk9qOHRLdGhac0dJR2hXZGxxZFFQ?=
 =?utf-8?B?QUd2a3VSbk1UV3g2NmloRjZoSUx4cUZOOHRmTWtpU3VJQzNKN0t0NTkwWjR6?=
 =?utf-8?B?N09GTDhtbVBKQVNBVGR1Wk8zY2d1M2FlMWU1RmMzVEhrRWZ4RkIxaW9vMU5r?=
 =?utf-8?B?cW50QXBDb3ZxUVl0akJYSk5WYXF4cm4ySUJmRDVCd01NdThEY202Zmx5Qkw1?=
 =?utf-8?B?dzZxRjZLNUVKWHRvVkZGYXZqTVJJVkFZNGVBTWtIdkVSQnVESm4xa1BmR044?=
 =?utf-8?B?aFJTK0lLQ1laYlVMbXNONWRYNXZ3MUpnb1JpMTdUVG52ZXRmUWZJWDQ1TENq?=
 =?utf-8?B?WUR6dk5VVUR4cW5RRXJQbTVteXNZUUNCV240NFhjWk1DOXprV3RISFVsRUpC?=
 =?utf-8?B?dHZwQUQ0YVg4MkFBYkNBNTJuT0FHUGdGc3Y2L0VOQ0dNS1BpU1AxSG96Rk11?=
 =?utf-8?B?SXBpaURHVU91d3ZDeDluZ0NNSWVNbU94WVA3NWlSZFFFVGlzVlVzN0NiVHM3?=
 =?utf-8?B?R1VFamtOcVAzWjFvTDcvaElKVktHWkc0R3JBV2hoVWlmcUp2MXJLT0JHYzBl?=
 =?utf-8?B?VDFXdWlqNHJkUFpxdkN1Sy83YXhFL1Bha1drZzBBSXhCdUZha3BZdTdtL0NC?=
 =?utf-8?B?eEVkRi9vWTRxNFdNMnJsdWZPVzNkVGdJSW1iOHIvaGNYaGRKRVJVVjIvSmZt?=
 =?utf-8?B?Yk5NZ2NuVUlaMUtQa2MvdEhObm5RazMrbUZIbGRzVHB4b3FzNVlpUlJlRGNx?=
 =?utf-8?B?UXVDb3FOZkQxS2pFcHlNaGVWUEQ1Uy85Q3VwSXVZT1FwY2EyQlhNaDJaMC9C?=
 =?utf-8?B?TnBaUkx0d2JyRjdmUGRTWEc0NXZIZ05aUTJUeVBNcDYxUkVsYXZRd2ZMSEFL?=
 =?utf-8?B?MjNWUHF1Z0l2Y09KRTQ3ZE1VUm9WS3VoYVV5OEhHRDk5T3VkalptSDJ6bEk3?=
 =?utf-8?B?eFROR2NCaDRFSFpLRmU5Zmx1ekpXS09NMUNLSVpQbkgyaWJqMENXQ2QreDMr?=
 =?utf-8?B?aUpVTU9uNEZrNTRxdmVhTHJvUEwvc01NQ21uL3JCbkp4QnVLTVpudUpwYlBS?=
 =?utf-8?B?K0tTTURGS3o2RzNVMHFIK3htQjBtQ24xMWpYUGVVamtCZmwxQi9aakZBSU5F?=
 =?utf-8?B?djQ0Y2ZwOWRiNS9EOFZObG84NE11VU9PRk03Qk0xOStXR1dIbGFSTjdqZm9u?=
 =?utf-8?B?SFIyQzVJODIra0VsWjRGaGp6dnlreVpkNkpWMTlncm9aK0dhRVV5ZW1xSEl0?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3henXoif49Yw0Vtc80hWCi4udBuBqwC3/VGsipumAoVA8dYrgHh8XBOm8IKBH117IFqQPHiiZfJrLjHZP0/7l/4236tS+FKtyQCkB+uuVzgW6vLmUTzAicBc6qfn0ONU5Qfe8oe23u40/UQrGwiActjU66yOQFEETVYdMv2Q98c5v+QML32x9DK457uyag6LeQ5TmY0ZtOi9gUYKeQxyvjbGsMS+2SGYdRMvTnYLilEHpm+IXFQQZcUzOvBPmgw4ivYBQWzCVkN9C559yPfAFb/yTqhoJhfO7LI+rLpNza0xEpfAhYcht/JtpVbIAlHWMtbIyljBBZLFciFQsm6P23lgfjo9tmr/Pi/SlwnpOj/oI5aYp7PE+jOAlz3PVFddtd5nnOdZZZefR+XUtXVXAMUK+Of8f9tkWuMfeaIWbwtvcxzleHQDz0Q1Pz0BTcPmNQ1Azvk0bsDfQ2CeL9rGUFeTikThsRkN7yR3BzyguIsu10yZxcrLWNSPXxNlPy3tWnAsna9C/D4/RgkMNAyAmji98/+orG7D6q/3virZiicrQqT/kTWZDwCT+LijhP57C3GHlshXKpb33idTy2FfCELOBY6C8seAXmicr7fqz1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bce61b-3b63-469d-7f3b-08dd93bdcee9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:35:58.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bONc5X8xE27jari9NmL2HGIzF6KxG53teBICma/73Xmg5zMGIL85fizk4iw/EzWEkvwXFCiNo9quVkFmVuzS8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150144
X-Proofpoint-ORIG-GUID: OyB2dRbYVe8GELJ0jcbNAIo80s8lFMVl
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=6825fbd2 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=doZkEM9yemDsRH_qg8AA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE0NCBTYWx0ZWRfX7aHx0yLdBwbB vcATfkMlORnixkQDgoJmypvcFk6nmEkfqk6x+Pn3Cpzx/xhNJoy9KpVUk1SmRWCaii+uXII01IG qhTmchLyxHqFAq3MXG5eqF37LeKr+5RMMm+vX4FhbM+OZ0b1MlN4lle5l3EiFzj9orftKYOJSlK
 AkSW430K8KeRbQTMXH8sAC3DHSuKtv+gZxBS4zhD7CpMYu/sbcGFU3s/jBwzpTYwJpH1rXQC+Cd vwvZz25sjAPdXH6NJKsVQkMvNnG9E/snx8906EvdXR9wGb5F888Fe4yxVEeCIBoVeaN1enJr9em GKWwQPn4jGKN5TTfA512uuwKeF9Rx6YA49eroP3c6NOsSPL+uHoS/XKUz2nWf7KGCkL/enLc5jV
 UvUwhigyAGeoMJs6BFA1LAEmLMcaC5fI97A4nFnPF4XepM6/qyMBvBtjmIAApgA2NHGXXhsK
X-Proofpoint-GUID: OyB2dRbYVe8GELJ0jcbNAIo80s8lFMVl

Hi -

I'm troubleshooting an issue where, after a successful handshake, the
kernel TLS socket's data_ready callback is never invoked. I'm able to
reproduce this 100% on an Atom-based system with a Realtek Ethernet
device. But on many other systems, the problem is intermittent or not
reproducible.

The problem seems to be that strp->msg_ready is already set when
tls_data_ready is called, and that prevents any further processing. I
see that msg_ready is set when the handshake daemon sets the ktls
security parameters, and is then never cleared.

function:             tls_setsockopt
function:                do_tls_setsockopt_conf
function:                   tls_set_device_offload_rx
function:                   tls_set_sw_offload
function:                      init_prot_info
function:                      tls_strp_init
function:                   tls_sw_strparser_arm
function:                   tls_strp_check_rcv
function:                      tls_strp_read_sock
function:                         tls_strp_load_anchor_with_queue
function:                         tls_rx_msg_size
function:                            tls_device_rx_resync_new_rec
function:                         tls_rx_msg_ready

For a working system (a VMware guest using a VMXNet device), setsockopt
leaves msg_ready set to zero:

function:             tls_setsockopt
function:                do_tls_setsockopt_conf
function:                   tls_set_device_offload_rx
function:                   tls_set_sw_offload
function:                      init_prot_info
function:                      tls_strp_init
function:                   tls_sw_strparser_arm
function:                   tls_strp_check_rcv

The first tls_data_ready call then handles the waiting ingress data as
expected.

Any advice is appreciated.

-- 
Chuck Lever


