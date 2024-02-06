Return-Path: <netdev+bounces-69572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74884BB52
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F691F27356
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DAB3FEF;
	Tue,  6 Feb 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O7tZNhXB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z2ZHD3Id"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D696FA9
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238044; cv=fail; b=IG49StDdHm+3iSsamJ2Ax+wQrA+feRoicf6GrfKhPX+0grDb9kWvSyIYG8iC3VoWNmRleIAAyFDLf8FKvwd4gsWfxKbGS3+zcnXibETKVX4xBBgTnlopNSTW0u3q5R+nt1D7lnXWVedIEUfnYIcOt/aXRMrmIYTX6G8/3A6pDGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238044; c=relaxed/simple;
	bh=1PB62JcCvmMG7DUYOrM+0QoWSHrsH6haX+tOJc/cPpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nmDuf81l5Cf8gvgOh3+LPsv1GloXxEfZoG0OwBtti1xkea186zEpHstHT76VqpuEQweTs7uwcaff5rgpQI7PkUGmKVNkGoCWlBpHkda1hYJiOzoIAAz/Cgd702/s6pZ3BMjGy9FUMLhPPftuGdI6/ww6SD26n5E9oX/vOWeMUaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O7tZNhXB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z2ZHD3Id; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416GFSn6031190;
	Tue, 6 Feb 2024 16:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=BeuQz/aLTW6po5z6A1YR7u7VXb6CcbJ6bfs6PbQImBg=;
 b=O7tZNhXBHDatlmUNRxpPmchh6fOKmxeKb+/jHVo3ka+VpMl9PmEFN4vjvS5f9D3kT46u
 Jjgh67boYEPwWRd7d2Fz47wowTgLg+immu2XZ/DjYyxFNrnFJf9UjiqSF4vx615SS9nb
 jkIQ9xsoDZJn/4ZVblpHeU6oLcrMASNOxVrtwNZy8SJOOapfmRL9lFNxlrS4ky6dk6W/
 UffIs424I9KtnSX7Ke7ruQhM6PV0nIa/a/UQyM6Qj026psJOyGPidKLDU1YC/4qQQ7As
 Z8G1FkmqQcJdwasw/QkdH/ChLu+2kqXcb2sq/HU1GQikpQcDs9Yo0bTFkC6F/E470106 yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbf8rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 16:47:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416Faj1K036804;
	Tue, 6 Feb 2024 16:47:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7kgdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 16:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0JHcY9WYITdBt9dvlemV4eX3sV84Ei+87tu1D3Va+QrqOX/5oytQAroFBocHVVxpuM+Hm8UodCaL1e3blLsKgAAIet2dxbVU/H3acHlcv6W9wk5OhlLZnGVjqf9Y9sG5v4oP5PM8Hpt4jaKOA8FYgiFLSs/hcYmQ7MYQC2w+/GOdUa2XGVztoowg5QkTGr/l/ALyCGa2Xn1nZbZfHR1sPSlRenRcdF5o+BaaHdLHtu1ueJcteqZycz8E9M5mBFIwxgoX1EQW/E81qa/K+KIsxGZx7ZWzC15jHwTfNeW9R4qPiK3iLeUhjiZvi4vkBrsTt8un+66WRx8ezPh1RvYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeuQz/aLTW6po5z6A1YR7u7VXb6CcbJ6bfs6PbQImBg=;
 b=Nzm8c620zuZsPMMsgyI+/uT4Lu+Rca6pzOc+5WvC6fBnD04Aj97veYeISAwLlRWw/mqNp5ThCqsdpgepMNhgtREE2Z0WRsLbDIrV/rXBH2EG9XFBWcEDdAILDFXMDZjqVTNYbRjJNXShZ4AC3de0bq65LAW0O4o/vGqt4fCoVdnJwB1GF+hjlzOubUqmlmSWzlp+C7rGAMo5r0U4OT9etuHGS5EhnPFTtQgTAviQ2VN8peVZzSCli5Z3Clo1BWCOJkHN/wHNfzRfR1PSppkncGsxEI3tyqykXSatDp3f1RCQuzl7i0VpRRUkOWHghlxnEfdGbjNvVzCR0QsBcKce7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeuQz/aLTW6po5z6A1YR7u7VXb6CcbJ6bfs6PbQImBg=;
 b=Z2ZHD3IdoQ9OskggyboW1aHEsaWSBc2+94daayt6VVlab8HGrEDKci53/8tOPfyjZBH4t4BddtoVJoBLNLWl1bA+W9wL4hy4mUctCQ06OMyPsiyH3Nt0cxw+3E23u+X9XPe20eS4IiU6h9bo1ZFTQCrfMIULUow6+xPsrkJSts4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5237.namprd10.prod.outlook.com (2603:10b6:408:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 16:47:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 16:47:03 +0000
Date: Tue, 6 Feb 2024 11:47:00 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Persistent problem with handshake unit tests
Message-ID: <ZcJihCDh30LD4NPy@tissot.1015granger.net>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b292036-ca82-4e44-9252-08dc27333f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cB3DTktV/FBcuHkQHDAnvTj6ChfcyYPwpAr4Dm1ohnElMhtczO72s2mRPUrLC+/c76M57F1/IYnzbN6sEv6R9j6T1agOqDIBAMDV4JNjhqSVUb7Xav220Vh4wfKHklP1ZQkSsBvSW+FhXb5MYC6mAVLv6aLwGJYsDnB1MOrxWzXYbE2xQpBnJTN1hWa9jQw8qW1PEMX6a+OpoX8IvqWmH9eF/TNazkv8ISX/dS1XHFwpdgOTmpNqSjDaPx79Ub/PZYS24KdB2AKFLjG0df8xAG+P2rcDMYhsTeWgFzG22oOIug/TCeHcxSHDdJwWmO1MEMC8S0PZW1LHS6R20AV76rQ7opfEhdF/no2mBL5rexG8XoUGmhuH+CiK1aTrBaiEE5613tqDvUwF/BR+HJ01cJgZz0g5BTEPlhu1SpPONFOSsU5QMz8gNqih5DFhL4r1eX74FKEZ1aig0c73atufWqM7iHs1vo5Oz1/d/pOxrq8xO7MqUWru0K4vLW51YBUBSeQfzF/5aU9rNIlqTKi37dl21WwYKeptY3xhhLiY8EJHzeEcHS6GKoWoO+GPvUJz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(86362001)(41300700001)(478600001)(6486002)(2906002)(5660300002)(44832011)(66556008)(316002)(66946007)(66476007)(6916009)(8676002)(4326008)(26005)(8936002)(9686003)(6512007)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?33BOLFm6MuOzPYnx8wIF5zBDd79DC3ANPDK+PrepLqC6dhbCfhkzPoBDkEiv?=
 =?us-ascii?Q?l4ynl1DKYj5Z+s0gFrKSRcPEs7FTKBmKJL6VOL9CvQVzKhEnAC4tHSd3P1Sb?=
 =?us-ascii?Q?r07T3sJsR3lcpuCGzYtOCstft8R2oUqnHeD7WVxGMpq2viL3Wg9Tpzhp+Xzd?=
 =?us-ascii?Q?HwOlcFk/7azMgV9Ei9iozuIN/iaj2opDKwOFq7TZyWlTfC7WNDdoWRh2lE4s?=
 =?us-ascii?Q?EvxSewi6zbIeFrPq+S8NnaQY06ittjJBJgTp673cWfIRVJ/P5DA5POGfWqC8?=
 =?us-ascii?Q?VHNCs+5iH5rTrPKkdXJO6jrI1dVYdXNXDs16W/i9lyEx6iNhKW0X5Qp4G12H?=
 =?us-ascii?Q?rGFOg0EAXu2HGsxfSe2hIKRU9wzQdoozBZsXKeBplvEDUnHcocM0OAK6HYia?=
 =?us-ascii?Q?vlCRlIE6byPd4FdJU63yM+PWG38VIR/Pxi0RvxZV5xEhXWooFIMBkFgRP4P1?=
 =?us-ascii?Q?JVcJ/vaPKjOijpkS7PPj4GbXE3yE26GiQKFyEGw/IuqIIpPgby9fQHCFdhEK?=
 =?us-ascii?Q?WJB3xWvqBchphLvZDo3VEvVtlPIxBXjqC3GQ6qZriLN7hQ0Bl6V1SHBpkwbc?=
 =?us-ascii?Q?YLC0w5wnwKFT3mXnpZ2JqTSIJky9/kSg6OTRo/QnfA5DUE3VDiHPWmDGY7Em?=
 =?us-ascii?Q?XlvnEYSGoVxsmJVGnM9RXMZbH0hMEChm3hzXAXAKcD6dj4W/2Gh9HE6T9day?=
 =?us-ascii?Q?vzRIy9Bvwk2jNEiXRLQOITAvT9niLwS1Pz1pl96fDbiclKJDyu2EwNIzNlr0?=
 =?us-ascii?Q?gXTbfB5DiZJTuKV69u+XL9qKHb4iM6AHIt/hSXA5LlzI/5qsT39VF3mGu1+n?=
 =?us-ascii?Q?t2PHWCYPN8lSRNHRSc7xV8hOnpjRNM2ItZAeykFP+aQTYfdPfA9C3LjKwTjO?=
 =?us-ascii?Q?FqfclN8ZWqfpgUDivdJKAwCtks1yonFWqCb3tWFTR5g08B+teYZC+KFHUK7W?=
 =?us-ascii?Q?y1T3CxK6xqGlDzCDucJPhqtiPITjS+ALl5qams+sORFFtG+j5XZMBtMJpVYI?=
 =?us-ascii?Q?Yc+4AN6WxJxfM+wmpyVmt0p9G3sFVYzOj6HW5QegWVxDpY5JRj41k81GnWGv?=
 =?us-ascii?Q?aBRh0gs7wy2rJlGn7bowgPCibnEwE4lmvxC7ayW8ziLSo3NgG4C80oaV3Mxy?=
 =?us-ascii?Q?o9ruBNs6PDkMj0ST+qLo35t/6Dbp5fxqXuD+WkNw3CIrtziiFqsU+p/QOr1o?=
 =?us-ascii?Q?X8bY/zYkB0xT+WPrWnnLByH5jTRKWGfEDXHmM7yfVjGyjnBL7u8R5tdYnVTO?=
 =?us-ascii?Q?6AA2kFxWQp5sJ67RvuRntCAvzPNHrrS89xaKX9zQg6WxWfR5UF5dOhnHzVDl?=
 =?us-ascii?Q?jYLgWvgL3AFw5SGbuHjc3d5wEIAAGlYgdC8kJM5/VtOZAYN+e/0kE8PhOBh6?=
 =?us-ascii?Q?Z8RcTvWc5IQj3UwbDRhNc6QZ54WZlnBidzC+QWPzU46xqMVp11rrkj937n+N?=
 =?us-ascii?Q?tB696uvEsZgwfXf7v7zQFJcrUOjraEqtbxP+hzsxDvF6IvPYz5v1jcnTCcv5?=
 =?us-ascii?Q?8RRvMDbtDIEYX79H+a6/kKt60PMH/mhXL/G4/9jW29cKR8DnmcZnDrf97iLQ?=
 =?us-ascii?Q?XexV4wI8x9uywJIPqUWUP9DwxQZoFi1eJ5ylTIk40T5XIuu0q2s3HwLVE2cY?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZMujx/CWxhGb5rUtHgzZ+OQWWF4/iJiXcKMfiGLzSsJMDGDNNad/kH98LUCKbSNbzDUFmEFnp0wmq6iauMZnnnN0Ls4mstX2Ch8PSAKOFh2G2hRIae/uLz0XhjcKbfhg+IkB4qgUVtZWcjvt9Ob7Prq3lY9Cy4wPPatVx+CgTB4NfIotQZI82wpQl+4snCuI2ShRzUaB3wSWyFmxNaPMtdhP1lee8ce9kExuYMmDCluCT2imcTNC6VICbuecoKKuTo5WEBZmstLKc2ii3rmf5nayziFLeQ0uwxk4e0CG21A4a+eOoGBMSERujwvhtieNWJxMak3/mODpx0bYE2mCxQj6ZUQJpqhrV+HR6Uz/HXauQlO9KaB3Ubc+mYRTyRncSq+zGL5E9O4RJX7P2ZikpjWGjbuugOu8xmJMFW8e1c9oqo/gmLCwQJA/DmLOf8pyJqccBcEltGkbJJ8zJhSpTidBB531vlyW2shfNpeCwskHe1lKxOHtBj9Q6OykbNLfLCJT3dAx9hwohG4SeG0Fdv2F6hxDqT6ifJ7U5Zx0ZgqDv6fj6prxo7cxYVimbkKNRbKjuVR5YRh0hy+dmnT7RLd7CYTJvuvwaexw7ZUYA2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b292036-ca82-4e44-9252-08dc27333f22
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 16:47:03.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYp1BnH77zrdSL/CAiCqGKTtW5D7EZlHUEE+zHrOhvABQJ8ep5U+LzmFom78MvUynn05j6OepAGeP5xmOboBww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060117
X-Proofpoint-GUID: pjewVlODWFobyW3jv1wb69nvrDNpnB2C
X-Proofpoint-ORIG-GUID: pjewVlODWFobyW3jv1wb69nvrDNpnB2C

On Fri, Feb 02, 2024 at 09:21:22AM -0800, Guenter Roeck wrote:
> Hi,
> 
> when running handshake kunit tests in qemu, I always get the following
> failure.
> 
>     KTAP version 1
>     # Subtest: Handshake API tests
>     1..11
>         KTAP version 1
>         # Subtest: req_alloc API fuzzing
>         ok 1 handshake_req_alloc NULL proto
>         ok 2 handshake_req_alloc CLASS_NONE
>         ok 3 handshake_req_alloc CLASS_MAX
>         ok 4 handshake_req_alloc no callbacks
>         ok 5 handshake_req_alloc no done callback
>         ok 6 handshake_req_alloc excessive privsize
>         ok 7 handshake_req_alloc all good
>     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
>     ok 1 req_alloc API fuzzing
>     ok 2 req_submit NULL req arg
>     ok 3 req_submit NULL sock arg
>     ok 4 req_submit NULL sock->file
>     ok 5 req_lookup works
>     ok 6 req_submit max pending
>     ok 7 req_submit multiple
>     ok 8 req_cancel before accept
>     ok 9 req_cancel after accept
>     ok 10 req_cancel after done
>     # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:478
>     Expected handshake_req_destroy_test == req, but
>         handshake_req_destroy_test == 00000000
>         req == c5080280
>     not ok 11 req_destroy works
> # Handshake API tests: pass:10 fail:1 skip:0 total:11
> # Totals: pass:16 fail:1 skip:0 total:17
> not ok 31 Handshake API tests
> ############## destroy 0xc5080280
> ...
> 
> The line starting with "#######" is from added debug information.
> 
> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
> index 16ed7bfd29e4..a2417c56fe15 100644
> --- a/net/handshake/handshake-test.c
> +++ b/net/handshake/handshake-test.c
> @@ -434,6 +434,7 @@ static struct handshake_req *handshake_req_destroy_test;
> 
>  static void test_destroy_func(struct handshake_req *req)
>  {
> +       pr_info("############## destroy 0x%px\n", req);
>         handshake_req_destroy_test = req;
>  }
> 
> It appears that the destroy function works, but is delayed. Unfortunately,
> I don't know enough about the network subsystem and/or the handshake
> protocol to suggest a fix. I'd be happy to submit a fix if you let me know
> how that should look like.
> 
> Thanks,
> Guenter

I am able to reproduce the test failure at boot:

[  125.404130]     KTAP version 1
[  125.404690]     # Subtest: Handshake API tests
[  125.405540]     1..11
[  125.405966]         KTAP version 1
[  125.406623]         # Subtest: req_alloc API fuzzing
[  125.406971]         ok 1 handshake_req_alloc NULL proto
[  125.408275]         ok 2 handshake_req_alloc CLASS_NONE
[  125.409599]         ok 3 handshake_req_alloc CLASS_MAX
[  125.410879]         ok 4 handshake_req_alloc no callbacks
[  125.412200]         ok 5 handshake_req_alloc no done callback
[  125.413525]         ok 6 handshake_req_alloc excessive privsize
[  125.414896]         ok 7 handshake_req_alloc all good
[  125.416036]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
[  125.416891]     ok 1 req_alloc API fuzzing
[  125.418439]     ok 2 req_submit NULL req arg
[  125.419399]     ok 3 req_submit NULL sock arg
[  125.420925]     ok 4 req_submit NULL sock->file
[  125.422305]     ok 5 req_lookup works
[  125.423667]     ok 6 req_submit max pending
[  125.425061]     ok 7 req_submit multiple
[  125.426151]     ok 8 req_cancel before accept
[  125.427225]     ok 9 req_cancel after accept
[  125.428318]     ok 10 req_cancel after done
[  125.429424]     # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477
[  125.429424]     Expected handshake_req_destroy_test == req, but
[  125.429424]         handshake_req_destroy_test == 0000000000000000
[  125.429424]         req == ffff88802c5e6900
[  125.430479]     not ok 11 req_destroy works
[  125.435215] # Handshake API tests: pass:10 fail:1 skip:0 total:11
[  125.435858] # Totals: pass:16 fail:1 skip:0 total:17
[  125.437224] not ok 69 Handshake API tests

I'll have a look.


-- 
Chuck Lever

