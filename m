Return-Path: <netdev+bounces-73906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECB85F3C3
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE391F21C01
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994B364C2;
	Thu, 22 Feb 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S8QLlWON";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pQ9Tndqq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42809364B3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592478; cv=fail; b=B3GXMPN4dEJuNAZYO7PEfxcaXf8rSYxxIc+PJe7fWCrkWrvnCMGE5rjrm24sgj+tIXHy/ccNbfZpbLMcyLOgA15MtpZFpoh5WD6g0Ar8l8U7Ll+9vEwWLByolDJ+vu3PfvCVobhbJaonBSbArpKlQYkEkKYiBwcbmPhTxnKIseI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592478; c=relaxed/simple;
	bh=UzvHJfpAAuiF6ckqg/mrF+kc8gv60eMFAbVZ1zbtUww=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CmXBP5/NzRnDKQS4m32d3mPYE+4zOCRDueqO+n22kI8jZxRsJMbFZ1YT7d4BGOZMixQrZzX1e7mVXmRI5fh8O5uKJOj89YCudqIY2Pnbl9PjTnOogidWX09KVD+mU8e47gFPQKHmTcs9f2z2hrvkmSGvDMJN05gBZBboWdbKo4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S8QLlWON; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pQ9Tndqq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3TVdV020363;
	Thu, 22 Feb 2024 09:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2XVubcGDpvjkCaFFw9d+M3dw/HtGztmJIWScAX719CA=;
 b=S8QLlWONRB8JfyCu0elpjnbUtBcaSPT7h/V63ukaft0aNu8oHD2yMbKvMdVouOV8nYWy
 KMh2/E6AXmHr4H7h6UElL3OXcdxVE3miPPhBCpZ34c4zRLxL9KvP9oxd/DCQJ1NOUFrL
 6+OlaXm2Z0acyYX8LJhZnLK/74IZnKlT2Fym15sTrgD31o8Fu3Z+zcbFURwKB5PlTaNV
 WARytFxLATUk0JWVP+YICU4B46rATgTR8TltOwSQn+W2CUeaLIb38Ydo6c04iXaz1Ayd
 HcPQANHZnD0tMuWtpESk3podJ6kNKu/4hn4BkziY4P7gG8NkcqEt5aNmCYf1pS37RNO7 XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud43d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M7V0eY039841;
	Thu, 22 Feb 2024 09:01:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8abenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPsxUxkAzFqtJlkSUEa2H4mQ/zGlgTN3+bGL7qizpcENxu9z7fB5Qgaliw0c2onIy4SguRwq7WJMfn3EJvv9O8X8NdsSfBccbr4CsTkZXk7mGzOeF5V2pJ/iwVXj0tdexdP5rB+VLWvW9DUc42ehkMckoDILNQVV/weGvqa6/APHna+x0GKymAyBNApfDe4w307O23jkWC1Gzizhx4lrjlczu/P8Enn23kGpnfFpVWlPjwIK2gAR8Z+bBtDcHPO1lBIsEDgHCU1+7Lvpsij8mWvVbw4sgoOdq3TI28IRW/P1bO67VFNd2LKdMbDeLGRZpD7mppQnHkCFt5XcWufhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XVubcGDpvjkCaFFw9d+M3dw/HtGztmJIWScAX719CA=;
 b=IjBPh0MsykuLVLnutNicReUWzDyoc8wqZd3Mm3SdAaaKRofzZ6xSoPAxUDGJMdS2TLcaa8sQDRq/j/b8gSg4HAIri2Fb86MfENCWFyw1fj2GscJTDqbB6kIuhEVyNIuzldZnGa+V7sPy+3zpdr5AjY0YFK3xKWCo5fFWIveEXNkCvxi5sPdGSfLAXsHgfyIvuiwm1wEAWDpifYm2Fk2Al5hh3lxQIKGykzMR6DwEjg4mvGplAtV8N3K9iLvGmw9gIuEOkF8yp5WSinPWQpW7cy5iu3fFyI81gRd1/QKVdmywoSCyBvDWnStKITn8IV/uH8TFYQ6wRwVmvswrykgmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XVubcGDpvjkCaFFw9d+M3dw/HtGztmJIWScAX719CA=;
 b=pQ9TndqqzeWUsyNg6q6kWEdinREo0G9tEhMgY+GG3976LQ2CLasSZJZ3lbfgEIWNBxl5gJKgyQoCZXOE1DD1m2mzZFG5zAR/niqPzFjeG32lCawlbdYhMKLiy8gX1VA/YzsZkYq/UatDopFVTTuVMJCLFGsyTz+N9PHUvAJVd7M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 22 Feb
 2024 09:01:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 09:01:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        masahiroy@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH net-next 0/3] net/staging: Don't bother filling in ethtool driver version
Date: Thu, 22 Feb 2024 09:00:39 +0000
Message-Id: <20240222090042.12609-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 036d0b05-6ca4-4a3b-7b2b-08dc3384cab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iivvUlUzQKNDWKaiGnLtuvhvL5mbmOe/KfWaJSIdJsRO1455aQ+Cuch4qCJynoF6XG1xi7qBi5GX8DgsXLw1cxxHpftzksHq/uGKGpY212wSrWQavZR3kAai9QZ2oThB5TiW/Pq+0Pq1sPpa9YEindvBxsmjSgSzHvvbVaRW2H5W10E2bsL6ahQ0KtNatmAL6u2aiHZzOzciBmkxXGowueqgasKSSnnLJRwScSpgMPNwADWutmUiSo5TU0kBgoCshCqYPwSylf96TYDWNZKk2tozjQusvndzUoXhV55uSFpbX+tjC6OAmJ1aoAb2bHorYPX7hPr73ev86NrPgP4KF2/9YNeVo5OAE8dRSEETlpBlH26M43khwg/LITSMtFq4grfVnRREdzvdpafx1y0G7hlQjOjX6O1iKYhzQlL4xeI6OWsT/aAEbICmPbyrdLU2CZ3sInYCTXbGJepqVKJHcwTWt+Q7XOFk6lYIMFjsekqy4yXfAQ/daOv2QOzaaQ2JwKPqIr3bedfrqUTXKS9njQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MVdzfwPtwbN7KDnP9CcXH5IclTnv6zkcDLj8pt22WzEODry6riSF/7XtUEzL?=
 =?us-ascii?Q?HaH9FtOcwPOg8kYGFhZmHdGZZhayILCkBu2wkUYgUEeVkEWTyl5KMj6QpBXu?=
 =?us-ascii?Q?9YmeztlU+Ng+JA4en7sDagGHEbgPF4JVUy4GQPigB32EKAbne7uwO2bXbtem?=
 =?us-ascii?Q?GT7eKKrkKlLhe+k6ufZx9W1ctXbV2ghZewU+GqqzP26XYRLyLr33lcMBKwa0?=
 =?us-ascii?Q?1pTR0PQGdFNGck0nZ5qHfzWhPwEPYPMNM+FR31S3aGGQ3+e3o3HNgR/cxg7J?=
 =?us-ascii?Q?NQ1U7ToXY0zHwLKqnBMOsr2xT1/ekJeEfS0d/vThqkQxUg9nHZzgunBMF1sJ?=
 =?us-ascii?Q?IKOqJrIYGgXxAt2TPafTJRBBIR15D6pK9fL/U/YMeaTfphncikTg3CGDpNG6?=
 =?us-ascii?Q?A0ryP4BaXP/cuBlATdAfbvgShuoVwWysrtoDpQrsA2vdFKlgZgXR8vN/RwGg?=
 =?us-ascii?Q?hd+qat2O6+6ssiyZw79/VcVZ2n5fBz6yQWI780WEFUmUlTujXf4VmPFYA8Ip?=
 =?us-ascii?Q?CWoqGiRqUOKyx7qy+Xn0xu1aPgUtq5+Xju31ljWcutxF1sHyTl6VCVli2OES?=
 =?us-ascii?Q?MvEtp9T2ZQFKSUCP0Ns7jTd2P96eXhV24DRfg3vyG5bXt/JOFlPwJFbJiE/o?=
 =?us-ascii?Q?yV/SaeXHgffophCdig2jq49o36yJxCc3dJ6uGz1tkyQ8/tetq+QcIeoOHXey?=
 =?us-ascii?Q?xubq03ixOm4LQFITtzrpniT7Eg+7i9nTkM/I0pZ8UWka/FP/VPGsziygSpqY?=
 =?us-ascii?Q?bkV5nGaIlUbLn1YFxnQYsIYw1mMFvzQlDfV+zf31DR0ys9xaEmBjGfgq3dyI?=
 =?us-ascii?Q?JGFgo9Wa+6sBjgqLjNocso9fxX4kwTewWR7IphPX2ZjB1jQwpButixnfjS7+?=
 =?us-ascii?Q?I5RR7pmkF/rDZBjJowQE5o/JL5z1uAwKNOs5/rWTzHddtKJFyvdIw/kTrbm0?=
 =?us-ascii?Q?92VjlPewOwpePHI4PB3VhebwFG0Vck9VTHsVqzzXfveSZw4/RJnOCLcGPGlP?=
 =?us-ascii?Q?yYzmv4uL74dpE8osHghTVvECfLtuM0fM3WlmA3+xeHiAcKQ2ALeEMPYrZCj8?=
 =?us-ascii?Q?ibd8vGAfMZYNz2hMiHqyZRElPf8GqMGtDK6GJUiEozf8ANMaC+wJWuSqtETF?=
 =?us-ascii?Q?MWZ0oy0sp/ZQlY+FCtKiuEfu3cQrtdXnlV8GnpuWMRcRWOXkhRYTAUdfAEWO?=
 =?us-ascii?Q?iqpLDxj7AqoIupmebdei9UnFSRmJDYJ1W2YdX1wAulSLq+Yk65t6KYPlDYsp?=
 =?us-ascii?Q?EQVpupq5BpASSdcP2fDpxPv+14aIcpf6NiiohlQaqUXD9Vw218c15+6cPhfz?=
 =?us-ascii?Q?YgBEheyJY4C7GupCrPjLx+vCo2mZpR+IHyRfAo/ZnUkORnE4k3zhVlQoOeIy?=
 =?us-ascii?Q?9l1A9rJDp7ZmcK0Oo6pmLyaz1Fg7G/TB5JzSuwfLYe5lA7xQZlUBDucNxyR/?=
 =?us-ascii?Q?AwlOX8bN88gVVZlWQquw2gkUPQ3YRXgu17Dp08ACYJciElPA8kQ3CCpd/o55?=
 =?us-ascii?Q?XootgOWVpxViiYseeeUkAcyeceQVBDv6PbxnyetfCgPlM1dhRh7r1zLU9/bv?=
 =?us-ascii?Q?dH2thkuxSqBeea3/nJFVktdHhzCrAyOCHoSy4urDT33Enx4sVl7nxaIPzHd3?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	81eAuq3+gkSsOAlFvdvAQxwP8ZbsTVV9hS+pcj6/pgaLKTB8BcCvd1O4noZnBwo1sb1O2vnnmkhy7roTVjl7Hy6XnWEJhLC4ITCdTOC7DGeyBzDOL7W/obKLx5FkbMeaNvqszDL7iayRZlY5uw+kRx1BdYaXIb8V3SF1Hl13VZdREMPegeVvuoiPYTx4tZ5hlqJk15rAa6zGGuwZdtah1SAv/vFeAa3Km3cXVQFKdaL8AWlkSNU9R0bgN8+bJNQ/mpppek0pEqLMeT9ziTuhr4D1R77L/bNQgPz+8SLoyh8OTu9IKFierHwQQADiCmF4W5oFukTl+8gZWc2IJJYwh7ucJNYc5UGMTxzVFWjrKVjL+v5f/NGgZkzb2UiZy8L3JkBjl25BEY3zv2caDGNLjsQPdM4KiTt0sWX5GVdPSYnaPDZ4PiIRUGhKxDfHVO3edibm2YYJHOlNElbxtRcKcefvrn67qS7Kh8KbYwYfAzZ8MW/AwB+uCq94ozx3ZiSI2T75o11VmWkCBjeg4ZnxqIrfx7u85iNeFKBwkdwvKpPJwWzTmaqcpAeeEE6XDIblfcOPC6l87a+y6rwHoOq41sSTolZkEe6X+gcLEVLcMj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036d0b05-6ca4-4a3b-7b2b-08dc3384cab5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:01:01.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAhW1mS275wLrzgXtfiVYwW/pgpP0rCo/UTe6qjRVqXatc0ZE+wowpCXxkZtfQUhtpnmpAsyB0yZMkSWwSHopg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220071
X-Proofpoint-GUID: 1KaEigiYNXyrMbOCsI8GOY_pNOPpFuSm
X-Proofpoint-ORIG-GUID: 1KaEigiYNXyrMbOCsI8GOY_pNOPpFuSm

The drivers included in this series set the ethtool driver version to the
same as the default, UTS_RELEASE, so don't both doing this.

As noted by Masahiro in [0], with CONFIG_MODVERSIONS=y, some drivers could
be built as modules against a different kernel tree with differing
UTS_RELEASE. As such, these changes could lead to a change in behaviour.
However, defaulting to the core kernel UTS_RELEASE would be expected
behaviour.

These patches are for netdev and staging trees, and I hope that the
respective maintainers can pick up the patches separately.

[0] https://lore.kernel.org/all/CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com/

John Garry (3):
  rocker: Don't bother filling in ethtool driver version
  net: team: Don't bother filling in ethtool driver version
  staging: octeon: Don't bother filling in ethtool driver version

 drivers/net/ethernet/rocker/rocker_main.c | 2 --
 drivers/net/team/team.c                   | 2 --
 drivers/staging/octeon/ethernet-mdio.c    | 2 --
 3 files changed, 6 deletions(-)

-- 
2.31.1


