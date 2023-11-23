Return-Path: <netdev+bounces-50586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D867F63B2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F521C20363
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46B3C06A;
	Thu, 23 Nov 2023 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NXfSfNiZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="guj6wM4E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE1FD65
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:12:51 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANFsRIq017036;
	Thu, 23 Nov 2023 16:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=9thngANmVjYgsttrvaMptYLM3AI4+mhxAcEJrVOCrwY=;
 b=NXfSfNiZ+7q+ZanAFYm8POZJ5QaU+73ushHw7Itl9wdabUcsA2M/7hodcp49+h4UReD6
 TwY9QMNuQy/9rFXSVXAJIG7ANP5m+XHIo6zEeHGoojdwg4UJATu5E+SfCbvNwDmHfEuV
 vT2Xmn6r54Mt9ttij2pASM/dBUIhARBkl4Nn5HNvDX9pdkYaNgLbOUsvGCq0NOi/P4/E
 VghsCODrSrb4p/3IcYgNWnN1IzZAlsDiomwx3kDA35pKK8jGGtOTpdT75KLe3wG0hIfq
 8zOqd28cshPd5iHk6/T97Yom9KHj8Jj0xV6o7Sz8qLv+yJlA1svPe5cw8jMzTlrg5a+U Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bhw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 16:12:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANEpssg022969;
	Thu, 23 Nov 2023 16:12:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uj3y5pcww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 16:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmMgk22f/wuHrSAgNnSNkRsRHothDqc3/Uhjh+ABRzjtL2E0vVIpc49oesMkYHXdCD/wl6hgFmydAypbEI4uKWUlJ07cfirR3KGskr+YuV7NJtoCgYs8Btg3yGN9AyKLF6AQHJyfYunZPPb0clfGbTGL8rz3tBDWLDSH/09mTj9wcYNtVk71LkdoV1/GHfcelMMMm/JBBmhUMwQxqM3/S4FXq+zM9a/XfXhh7uYRqySA+9HKvBTLkYkU8jDkvN66Ak5tYxzLussT+tYaHI1+4+VmDUDB7rsOp2nF7z/Qhr5yd1dd4RLsm9uGAQUt44lY2jXk4jeA62XMZwJfHPNPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9thngANmVjYgsttrvaMptYLM3AI4+mhxAcEJrVOCrwY=;
 b=W5rfjebeXXwEv5GqtFPcVO1VoOBpYk8N5LkKGvfWc6iLZ1VdxrrYNZAW2Mr5UKkJyiqb8xQwHJhgAeRbDlA55S/4bsq45esTg5/zhgJggguFdSCsLHQcR1ridLdW8IduoQvWksSGR0G6HovWibfBuvtH3V0wdWUtKlLai4KpLmGA5L3VRYfklwCGJzAhM4MlgIsS0rPBKyQujMfWGfiIJjKGjt9N+Y5yUUibHfsFsVXd/5HLnhQyWDqdJkGYLAo7Bk1L6DwrMVdNSLirYRqf0v9MHWLZ1WbY4KDehOydjytd2be8/hZQCo1LD5UW7GsMmnL5RNGe9DZMKQE4Fy2uXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9thngANmVjYgsttrvaMptYLM3AI4+mhxAcEJrVOCrwY=;
 b=guj6wM4Eqw9ohRr6Xmcc96l8X03E3dzithk6aE/ZggsbQEjvKtWMixOIq5UDB4/uDImVS4f6/ZJHd2xH18l+X70kcRgtBMr7r5Pfe5H0raG5OCgtAnXMySoz2MiyV/r5FPwYE9FcI/+VJ6C19CVRuRJ3T1UJb2yZxSPqiwchPN8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6358.namprd10.prod.outlook.com (2603:10b6:510:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 16:12:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 16:12:32 +0000
Date: Thu, 23 Nov 2023 11:12:29 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com
Subject: Re: [PATCH net] tools: ynl: fix header path for nfsd
Message-ID: <ZV957X3Z4tvWPu83@tissot.1015granger.net>
References: <20231123030624.1611925-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123030624.1611925-1-kuba@kernel.org>
X-ClientProxiedBy: CH0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:610:b1::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 002554b7-d746-4278-ef39-08dbec3eff86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GwKDCLFh3MhIBXAlpVLzCb2ZYGapHyWAfUA9/tZ9fdny299VcZRx+JPY6Zt83HgfuCKMm4WTq0a50J+hPDlk/9r9oUscXnaNvq3H/QI+Cnj3kxnN16cmJ9hz0Kw9F9O3an1Sfh7m1jHPztKLumzQ6drPFgejHFABTDpudWgdofm5msJNrJ2pt2oiCu9UptAQHEeNpl+UKJ2R3ZBpYrPcZfd8CfcyXu6ThK92ELh5b38qXTir2OW66QvRDAC9EibwdWoAGqsHGCzTqup013bI+O8t+rKfrZLQqJOw6299vPjDQy981EIp/h2sfvCcDOI3/vfpGiLsnEEOOnNDnDgBkslyKOY2t9PdKpjVj750VtM4rFiGoEV//GYJ4nSshU/xcn2W2xLdTLL0DPM8iFJ0MSlxNVNJ4zuQZOKS2sNa+FjnP7Id0P4JNTvKNzFq+/62+yV0CjcfFBKmSbdCV8WJLqacvrA1ut2vbxv8bn4P30giDf26Zr88OvPU7m6DqWQaLy0XE0Jdywp0Ee64Yvr3Yor0HhWopZO59LrXfceWpTi13g8puCpSSpGIMeyE0cww
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(38100700002)(86362001)(316002)(8936002)(66556008)(66476007)(8676002)(4326008)(41300700001)(5660300002)(6666004)(2906002)(44832011)(6916009)(66946007)(26005)(6512007)(9686003)(6486002)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TMcdmOb9YDwKw5Enf49F/zQV7njZQMn9nnhl5LNFaKsWGy9XwkmOj470O8jX?=
 =?us-ascii?Q?g38B4MlvArfyRH+ep5qWbfwTfVU/qmmNNHQbr2V8H+HDC8uOK9nhks1i5YZv?=
 =?us-ascii?Q?b+gNXBMba4gTjeId0J4Cdj94IVNZowssAKV0/oTB8AHVgyKQz6tMJqYKQ5QR?=
 =?us-ascii?Q?x39ynNWWg3aCbxBTd5LHO5yJfhpAM2tZrqkSplfu4DDeqGJwAh14xxQW00Ip?=
 =?us-ascii?Q?OXyQLrjdbg24ZlM403s4+EoXUMrRVv58LTqjot0fGx6w4/Id9EUYe6sftZBh?=
 =?us-ascii?Q?5IZLC/zrUIDPXMCI1ErKlU41luh5yhuW713WKLlbQi/HXvo/jtbgiTJvgDWV?=
 =?us-ascii?Q?f/eip94GQ9pXffFhuKToJdu7S+5qVSVjityDv2+pIcaHWt/3U8088qCyItGw?=
 =?us-ascii?Q?vxf22FJUiI5Z26SWWZH6qvOI5CvTkGOQyz5LcPBJT7fOnVbqoR6uDZJY03UC?=
 =?us-ascii?Q?XPxHWZd5S+eluZjeEat8quc59+7bwIHvjApH4ywAFgT+pAgTXeWCUskd5GhB?=
 =?us-ascii?Q?e9aAkdkAyJ1z4Ue/i67Inuo7phDCZxCmu+Ue1wJvcXtst/eRqTJuTz/S7258?=
 =?us-ascii?Q?jV5eWDzcBZ3W7X5kWTZos5oYAl1t4jEI/Sm1TLNYbFtgry+N1RQwD+91SXWC?=
 =?us-ascii?Q?mBZd8CRUPgkH6mL2A+fwDT0CccwIMBtsH8t/vGAqRzXf/mp5KOFpHiuAblAM?=
 =?us-ascii?Q?ov/a3FJSP18ZkLG/r/bpZW1UCezx4Zngi/v7U1drrkTxYG+nrqy6wJ0Yktdw?=
 =?us-ascii?Q?CDdWH4cdqo+2VvzLq4+m5I2/xDIFG07n63DeHWNUMPOiyBS8Yj431iAFxyHB?=
 =?us-ascii?Q?sz6VLuegDJGBzqgJRYKErAWoka2F3GzuBp3/MmwsOHWQL4z6/xX9htwRMqUg?=
 =?us-ascii?Q?8K0+1A+7fTQ+4i5O39ihqkoNPg34ZmY77fp61q83VplnAqRWdfKI7rMxMdSr?=
 =?us-ascii?Q?wSHKygyu9Z2a7Ln338kDl8zTZBt6UjpY20eACe819/mUBCaGr6J9Snq+K+2C?=
 =?us-ascii?Q?fSZ+am95dZjn6ScaCxffbwbzu4Pn5j3ihxDUdEQns0zienSEHkvI2sEBD1j2?=
 =?us-ascii?Q?ONpUN+W9/QmV9slgYca4SJOQwVca/s4hNVcZpZ/hQLASkmWatWsYqEIOzNKz?=
 =?us-ascii?Q?cX9zGubFGliu0jAV7jrytSQpXCklOmBzDU1ysqIuUa/PgZQl2TrVkFeQppBJ?=
 =?us-ascii?Q?DjpGNoMP8vGOrv0NPOjC/9HupYjtH0f7w2bt3U0N/9e3mOLn3h8dnXqp6xUU?=
 =?us-ascii?Q?dkivQ6OClkwFLmgL6U0mz/xhKAB81GLTTwaTGTJVtZrYiWwL9KXD8TgxUO5Y?=
 =?us-ascii?Q?QpGhtb+4+wESOXhvJxA1IkZOOtEvkg4oxyJHfwljsv7UfCXYhWb/6UBBwD1v?=
 =?us-ascii?Q?T7elm5gB+FfC++C3BpVbj2+LBF/BsJuoYnvbGGz6BD95jEFsKhdX2E2BoHuG?=
 =?us-ascii?Q?dpLShCJk7VsNIno+UwoiluDBWXOS1Jke6PFrI88gLm1Rvtu2ZEjHeDJXT6Sz?=
 =?us-ascii?Q?lz/0NCdfbdLuULK9SaJWCjFBpIm+Qw4RqZX8GRDUGqlIeSyNVdhWxb5ak1Cf?=
 =?us-ascii?Q?iKiLTG1bVYhYXaPpJab58mJBhUbRFYEWKsww9w/II6IaEk0w1vDHmhQ2hOHz?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bo368x3foNH7ZCYkoewG46wRcmhuGytGBpd9+ZY/hogXj+pGTSBqRTDXzM8p1zTJKtoddPpJcWFr5D31Y+NALTHJvDEg9PLO/8o0CyDoLjsWlASp4uFLFn/3L6oV1GkjGoXl4QVCQ2g+x8pEScKzNiqQ5Mo4cUDeC8LbOnJCSL9fMwUsP5fzBY8jn4U1Itgvi5DqbBuRpDWLQS64VFqQyE2vQrWgFHydUzrjDjt4nnWgJoxC2NxJkRdRIkyJYRgWpWCeYVHAGpcF8xX9igxDsmkWciSCrP4BbrX4CPNEm5xdZbRJMcigCa7aNGZU4S9oRLKxw9dN9s2EOWVkhEBQdBlkA4NNLHzSpJvsGbUz2gHSgTWYClTHagMgUqZcWn9xTClslpOgeWtc0TL0riTXE5L0WG/Mg5biQulgGr05nJT//V/iZkUsgHdHG0ZceongGPTW7WRnMc7dlMDTYEdxhVqmfOeLdKQ+4KySrBmsv82ZrbRQsqXRJ6fEW0jdudMAa0FJRmxtrydPX9mSYmO2dPHUQboy7OmbuyPL8r1LrGYDJwfSnbcntYhH7njxU9SyBtCLvlRXZvp8SROl3oeBICOlx3zeJSGb9KiRZZtO1c7aTgwSCevwOeBGEsmf2Ojglc7NWho6VHmnBrggre1YPy7INUEbzf2I2IIeCdibAd5ypZcE0twhU4/BAUvdnSz9jGB3Xfk1KZOxnIK77TqYVBfCzRvqATkupdIxEyajRlP5nrADynFazKwLAR292i30UgqDWv4NKL6y+laQd1N03c1R509KHnA+TS5DOLm42lW7/pzX5HTPbys9wai/ryigLcRJeRkuLywYnudUIpglMKae86bmVbkEZLhPyeRdulfeFxOn7S1l3zW5i98vygQWDep3UoNOPleKdCZNYJHP3g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002554b7-d746-4278-ef39-08dbec3eff86
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:12:32.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eo2k2F9YboAseReSw8cdYtZAR9CNI50FH/eeiHUts2avB3Zz3XUqiEOrigjp4/u4ZWNp2/Ckc1Mhfevr0/K9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=770 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230118
X-Proofpoint-GUID: KuNTCkYA1-JZFljuYg8I2apixXheHdUE
X-Proofpoint-ORIG-GUID: KuNTCkYA1-JZFljuYg8I2apixXheHdUE

On Wed, Nov 22, 2023 at 07:06:24PM -0800, Jakub Kicinski wrote:
> The makefile dependency is trying to include the wrong header:
> 
> <command-line>: fatal error: ../../../../include/uapi//linux/nfsd.h: No such file or directory
> 
> The guard also looks wrong.
> 
> Fixes: f14122b2c2ac ("tools: ynl: Add source files for nfsd netlink protocol")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: chuck.lever@oracle.com

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

With apologies.

> ---
>  tools/net/ynl/Makefile.deps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 64d139400db1..3110f84dd029 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -18,4 +18,4 @@ CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
>  CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
>  CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
>  CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
> -CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_H,nfsd.h)
> +CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
> -- 
> 2.42.0
> 

-- 
Chuck Lever

