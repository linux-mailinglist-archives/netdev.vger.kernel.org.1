Return-Path: <netdev+bounces-254255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id alkyBK0Lemlo2AEAu9opvQ
	(envelope-from <netdev+bounces-254255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:14:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9FA1DEF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD01300B9F3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97EF32BF42;
	Wed, 28 Jan 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TyeBeTDC"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06066137923;
	Wed, 28 Jan 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606057; cv=fail; b=SaOmcmkx04aoEcR/TL4wQgJx5Q1k4GNbZ3Lg/WlT5E21YCbZs6lGBf96yK6hv3wZPhSuMsfDYY8bPwDySm7V4e76Jubc/XNPoN1RQyp3iKXK11FmgGCSjLLV8xD47tHB2NcBqtdaLEhaHJ0D4NOse62olUtrfyyhpg/dOWAkErk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606057; c=relaxed/simple;
	bh=Zd2i8Q6C0Gg2cnsRmSZAwKB7SSUpPZ5BfHGemr46wpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ohydawobil1OX02AYuS6bAnYE3oYh2IvrIbgyNEg5GFKDa+if4sXGOV6JKahQLmnHdRFxZLvC4oSc04TAT+XukOlu8SEjIW2jCzDHfOK/aqWqxyNEcX+cw8JncmHiyMNdU5HOptegQD+qrbEsV5r8D5biShGB8AJUXtRHOTPtjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TyeBeTDC; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLptPFuTmBYT0S/lK90NFenQvocqco66LIkPHyopeMjF7Wz45IHwf438ZE/DvsfmGY1RMSLyVdW3FSFm7xLDMcyP1N82ce3mgbPBcB3RgBWVewUM3QZxqvRgx/NMSBwd2W4iBpgD/6Kxr61bL4/EjH8agOeYvzNkzQNFD2UvAb1PRIdgJq76w8CO+IEBqUTtiZDgyd+XPDjmmaeS3bzv9u3H/OxjsR3sWGd5kZuq/9nz1iRxZmSwRzLipwe2NuZBwouEDbU20wd27MjCYws/6mSVavPa+a+DcHOk1d+iVHVhXnuHqgHMVfeWwU9tdmHcgz3ESoqLK+a7afyF5ZgDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9u3Q5Z41Dz7dplKmi42lTe+fp6KTmSeoXgeuWZDyP8=;
 b=cONkZ7DAfYEy78swaA2yQykmkWBKbtKSty3T3CdT20aOuRn6n6d/5gU/vN9CWnXD8VoHtnsFUiWF+5atA4Sr2AfWZibKngKKhmxIS03EcU9SuvjNW2+Pfhk0rn1vq60yiYI2cW+T333t6zX5cMO2HM/PufSRGz2ugA5e4VlQMFAjwktm2usUTcWrLUVp8nxFe/6kHcFYKeI8RHpacdYqJ1WTQjJgdLweO4RydZNgQmu2WxJXNBD2VmcC3wbPZ28T4x568q+pN0cVK9WTxNOqIPmwJCyNL5GB1AVVHrqHML0XeVu8pUC8ZWM0tvjPdqKo/7W70+Fza6OX/eSHck/RqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9u3Q5Z41Dz7dplKmi42lTe+fp6KTmSeoXgeuWZDyP8=;
 b=TyeBeTDCuvDKXvGRJMXgnN5+9y5NISJQwvV8kaK09dZ6eo/V7Ysa/ZnRb0l5OKzIzoQCJpwQHrD3ZdumTdUpr/5IhBDufJS/d6CbSEKok5NKTRL6xHFpNRMCn1wTuiulRp26W0vxlF1fizc73PjtQyuipbWOwJidCRD5mwQFnEQE/FVE1FeQpcpYrSMutjtRPZ5XcEGTv3ebD7X7ScyDS3KDqQAoft56+5jvR++P5PkPmsV/W49AdyduDYAqvO8bYqoxZCfR7ujvz6RnfdVtkYYe63eZLU9+AjmFpy37STQsVpMydySnvsqvCR/MGZHTDAG5q2WppMi3PwsNwNPF1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 13:14:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 13:14:13 +0000
Date: Wed, 28 Jan 2026 15:14:09 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: vadim.fedorenko@linux.dev, horms@kernel.org, jacob.e.keller@intel.com,
	afd@ti.com, pmohan@couthit.com, basharath@couthit.com,
	rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool ops for
 Frame Preemption MAC Merge
Message-ID: <20260128131409.wesidsk3z7ixptyg@skbuf>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260107125111.2372254-3-m-malladi@ti.com>
 <20260112181436.4s5ceywwembn674r@skbuf>
 <931bb43b-fbba-4423-9a20-122602b3b630@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931bb43b-fbba-4423-9a20-122602b3b630@ti.com>
X-ClientProxiedBy: VI1PR04CA0073.eurprd04.prod.outlook.com
 (2603:10a6:802:2::44) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f7fa4b-05ba-48e6-4ff3-08de5e6f215c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBTHajYr0dIv6k8LTmsm0NLT0cG8QhTPbyYA0EL/GLqP7eotLCnoDGTBUsmD?=
 =?us-ascii?Q?QfJWWap6SPN2JyigRHBgBUaLuNlGjD+/NKHOyxotFtY3oTGZSDKbzHSOLU+j?=
 =?us-ascii?Q?UNkY1RmlmfgdCM3JNGw8RGWXoMPofwZsmb+f5mnmCdUcbspagz4rfkmrB4fN?=
 =?us-ascii?Q?yNsZtEmNNFCXKQ5VLHeC6EHl6vTZKha33F6DGhTPwg0xw2HSl6mGf0jNNE9I?=
 =?us-ascii?Q?h0IVWqSdFsvdDL7FsGyHAyN0qMoTiGG7TeweaPEQ5fqB/iUoZi7udvveZKnu?=
 =?us-ascii?Q?vrHjMLIZuZFzSPThnuJ5VKtAld8KLqdJsXp+RneXBsZq+MLX+dSaqTnvjV+b?=
 =?us-ascii?Q?v1+6tEBnEJOpzwRg+adKCEiV6CSF8qQGrdVtO88REfGdxkMmiAFBwVzFlO3s?=
 =?us-ascii?Q?LH5x0XsVkwVey48/pHv4Kvvp32+/IciFlWU3Gj1LsA0MGXhAAB07Qtc2k8oQ?=
 =?us-ascii?Q?US6DBaFh/lCgHGCZn4EP87/oOmTpgq5qL7Dq/dG24P+zayU1q46f/Y5Cuovd?=
 =?us-ascii?Q?c5LGqVSEw4aUr+KbklkPhAMpxBKlCLoOqTQ7GhYK/szdwxOBf38ODv5Ll78M?=
 =?us-ascii?Q?9pp+1C2/x/wtr9gdLtYDHLc+/187CAoPYTw9WHLvGXq9Iji03YmjgU+2wHi0?=
 =?us-ascii?Q?P94TbOAzTLjxN2w3H0YHC7XSmUhA5+oTkgOj+MgM3GeDckrCpwLdorJzb+9z?=
 =?us-ascii?Q?qGDqYSB1fqtdDrcfvQPBdsTBHw3oeZEtnc7i0XYQRqvHiluS1LIlW6b41P1W?=
 =?us-ascii?Q?UXojMX/zapP9rdm+34CU/joxBF3fMozabB2wxIbaasCXWtEPm22ihyuVCmQk?=
 =?us-ascii?Q?RWEAl0FwpSMvHi8B1rZSCvnfFXeAz5PXyvl9dn06INzWTTbqMYwknxP8i5QF?=
 =?us-ascii?Q?fUJS+dGZcVk7St3ibDK8zdpAZt1kxM7+C+GvPlJIZDFtS40CTS9uHOmhSeQG?=
 =?us-ascii?Q?0pp9kvHN+C1wMxLdJ3PmWrC+E7PcUKA5kgilW1e5Lt9lmTtevhT57umqrN7t?=
 =?us-ascii?Q?vSPCZ+4+cllEjkUhl6EfuHEpn9mCVgdchOF+Zon/Bt5n3KpRoOfX8H89bijN?=
 =?us-ascii?Q?XSkWBA1ehujRdSszc/yC+5kKFPvywgzx8KgNiN52p0oVDCWK4NmNdDUby0Au?=
 =?us-ascii?Q?Gj6/UxW5qn+ynYCv89U0MTjXj3ip6yhHPcbDTxD6v0rmATSP6Dtm8T91FJnr?=
 =?us-ascii?Q?0yCScRxblQ6ZTQxytik9Sb5ljtDXNT0d7bogZfsq8aiQx8liBdQ7lxXYQE+a?=
 =?us-ascii?Q?q/3RwLdGqyu9WB6ORPAwUVknDyIlE98AAI8uJZU79LSC3C9/rd0Q7tbFEbQb?=
 =?us-ascii?Q?6xkZwPgHed0yjT22pZOFri4duPq2Z4MkHv1pzP0b6DGR0LfABCUr6TnlhAgg?=
 =?us-ascii?Q?rRpCc+UZovjSXz0Eni/Umkr28dKwwnNo99f3i5x00a+UAC0vUyAFBUTK6ULu?=
 =?us-ascii?Q?GGVshRTqD1y3yTFj3/Xz8khsWsJFQt5C0qr4K9nBVjbjHN1/bkCNfmb2DrRD?=
 =?us-ascii?Q?o8uwaRS/fNipsUMYs59A7URxG8LWYEXTP+MN83xIaT2mGJnMcjEY3eFL6yjC?=
 =?us-ascii?Q?AVz2dpYU0QcnZuGcWLqw8SEbEmX3XpcP0BhAxHQg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IueQJvj4aGSeJGtu3unCEt/EViMN4hOSQGWwXMH2bUzrAWtU6hGxpmkbbure?=
 =?us-ascii?Q?04GIRq8HmppPtD4IGCQLDRbji63p8VRAG/SJJiFHNmxcec6SfjZLOikv/HcE?=
 =?us-ascii?Q?eKC7PLTfEwlJn8qYFWYCM6K9ortwLdfm+w3LuGNaxSdG8mNkQApkvi3Rfqtl?=
 =?us-ascii?Q?zceMW4CnumcHUrVtiaV+zHEK7rXcVl4cYZMtRRfoJQNQ7Iz8VT7Ch8+I2K4O?=
 =?us-ascii?Q?IXmIfTw/vHNPYlbhVGNddVLprRyE39jzOHalxAZuHBx5WD+6frUIoZLCzkkn?=
 =?us-ascii?Q?KDaeAuT0IN79j9lmNAxpLsvZav0n6VfRdjh55uSdeUlb3IVcLDgERmYIVTTX?=
 =?us-ascii?Q?6KVslExFgiUG2Tz5ONvL1FlY71u+kRb4ridEmfoiKDrAO65RDGZypIbHR0YD?=
 =?us-ascii?Q?lyoPZks5a8ICOn1DydKBJmqf9cKH1n1AE9Ik7/40DuBjy/V9WTJUIaHDPBqo?=
 =?us-ascii?Q?vK2uJt7rivt7+xlLnwkIrujGMEk3+gHWb/Uaj4mfd2FR4GfI4zAFxbPL4V1E?=
 =?us-ascii?Q?HQIxG1FUAkwZ34EE0XjQvmNhmrp8lq/8wv0rTQZ676tmPYtZYQgUd9wYl0V5?=
 =?us-ascii?Q?L+vxlgcvc4NJwjlbyjzOaImnSu8FVUjrMWMODp22eySyuaTvxvDQJ0ngQvDp?=
 =?us-ascii?Q?q+WRf5J3RdlaBJ4VzzQFo1fy3n3E8zhfohPTh1l1jidNqf/YVjfXzDo/rZBr?=
 =?us-ascii?Q?JxPV6BJJ3hP+vie88xnz6UN2wyILhvOK94aR5K8+uD8HWEt3aDgXJx5M/mRX?=
 =?us-ascii?Q?bIji8uaCxz5iReTXRcdMa4iORZjiYUg7NgI1beVOS51F89E98GI00HZGqXyj?=
 =?us-ascii?Q?0dgybw5lScRgYTGIn4fJiDBD/lr6e6/4itibo7J/9Op8TwvD1ZN+WVRMupOK?=
 =?us-ascii?Q?MtmT6WOSbtIR/QuRJF5lhOwT9Ij1EwD5ZOhSktEsVn/2viUhTHenqwgXDxur?=
 =?us-ascii?Q?mndSipGsDMC4uRtfAy5g/kU0khhy80VDGnLGFu7d4dLyxTzwgN38MWNShHNJ?=
 =?us-ascii?Q?pmH7AnsLVql/RcvCd6agJ3BMv48LCsGGrqxjPKk/LE6BCHZ20XILMv60CXzs?=
 =?us-ascii?Q?0LUekJtBqJyLw67h2jxkpdEbdDqlbpiYHGy30gNlHm0ZFSADH4qm/2Fx7KGy?=
 =?us-ascii?Q?pFPZlpDNp0fEYcdDNFYGddmCn99tItWL5jStwFB9uipcuT9o61bpK6ctUT3Z?=
 =?us-ascii?Q?2hsEhxbECJXSIAjWfn1QGwFGsj8FcQ8DK1hwREDgcRqbZyPkAx6UafnVqmdf?=
 =?us-ascii?Q?w/m9jnsY0WcY/c9gHVERzKo05dT2dAn+RlJi8+6XP8g3Ass03m0T5RXNWYgP?=
 =?us-ascii?Q?UJFOqd5FwcMbL3VX8NdXqScO754aTVxOd3cm0ypMpmed0DHTpsX3JqLMdL12?=
 =?us-ascii?Q?wF+7CFvpggli4qS8/tyxKXDmpDkjtq1Uq2FT1wHgbp5KNB91Exima3eQMmSt?=
 =?us-ascii?Q?ZcqdcJ4AbV8bTsBPpvjFIZbzwmkyyf0cADeAs2wfeX6yLsiBXxwYgD7w29P2?=
 =?us-ascii?Q?Y5//zKsp4gGlYL/Mx+LPh8iYNBL8eEEg9TT6rCpvCzSctX2JbBBxggWgrjYo?=
 =?us-ascii?Q?8EkExOZpO6NMG7aKqR17SHoefVJf57A6vZgv/zNzT8w3tjj5qtIjGy1WtULa?=
 =?us-ascii?Q?+ZIvbYajx0NyCUNKJW/4R1DkKTbspoRslKl/1Bs28XtvnL5fUlizL0wa2MOi?=
 =?us-ascii?Q?y65+5/IBMv6/eOMITTKHXTkrM4HuKGe2COtjSWX+7SLGne1+aL36rBFEFe3D?=
 =?us-ascii?Q?Uh8HXN5sBKObBpVEfitWwazzl4gnoEQvOnP8MZbfgzZ5EevB1RrqR+NBvoWl?=
X-MS-Exchange-AntiSpam-MessageData-1: 8WLe3Gy0Qa5DJA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f7fa4b-05ba-48e6-4ff3-08de5e6f215c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:14:13.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IhY/BItANBu+O//HIE80reAbgHqogaYfKrMT9gMVcNI427INpGfGH/epJ6+6eBKnVrl2E5wc3mNRIaDN7+ugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254255-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64C9FA1DEF
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 06:32:05PM +0530, Malladi, Meghana wrote:
> > > diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> > > index b715af21d23a..ceca6d6ec0f4 100644
> > > --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> > > +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> > > @@ -294,6 +294,61 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
> > >   	return 0;
> > >   }
> > > +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> > > +{
> > > +	struct prueth_emac *emac = netdev_priv(ndev);
> > > +	struct prueth_qos_iet *iet = &emac->qos.iet;
> > > +	void __iomem *config;
> > > +
> > > +	config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> > > +
> > > +	state->tx_enabled = iet->fpe_enabled;
> > 
> > I would expect state->tx_enabled to be returned from
> > iet->fpe_configured, aka from the same variable in which tx_enabled was
> > saved in emac_set_mm(). In case it's not clear, ethtool saves state in
> > the device driver and expects that state to be later returned in the
> > get() callback.
> 
> Ok got it, will fix it in v2. I am aware that ethtool saves state in the
> device driver which will be returned in the get() callback but didn't know
> that should be the case every time.

Driver, hardware or firmware. But certainly the state returned in get()
must have some relationship with the state previously set in set().
iet->fpe_enabled has no relationship with state->tx_enabled; it
represents more or less the "tx_active" state.

> > > +	state->tx_active = readb(config + PRE_EMPTION_ACTIVE_TX) ? true : false;
> > > +	state->verify_enabled = readb(config + PRE_EMPTION_ENABLE_VERIFY) ? true : false;
> > > +	state->verify_time = iet->verify_time_ms;
> > 
> > Why are some values returned from firmware and others from driver memory?
> 
> Sure, I will store all the values in the driver memory and return from them.
> But should that be the case all the time ?

Not necessarily, this implementation is just very inconsistent overall
and that raised the question whether there's any reason behind it.

> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> > > +		       struct netlink_ext_ack *extack)
> > > +{
> > > +	struct prueth_emac *emac = netdev_priv(ndev);
> > > +	struct prueth_qos_iet *iet = &emac->qos.iet;
> > > +
> > > +	if (!cfg->pmac_enabled)
> > > +		netdev_err(ndev, "preemptible MAC is always enabled");
> > 
> > missing \n, OR use NL_SET_ERR_MSG_MOD(extack) which doesn't need \n.
> > Doing the latter is preferable, because the driver still accepts the
> > command while not modifying its internal state, and ethtool prints the
> > extack as warning if the return code was 0.
> > The catch is that openlldp sets pmac_enabled=false on exit, and that
> > would otherwise generate a noisy netdev_err() in your proposal (but
> > would be silent with the extack):
> > https://github.com/intel/openlldp/blob/master/lldp_8023.c#L443-L444
> > 
> 
> Ok makes sense, thanks for pointing this out.
> 
> > > +
> > > +	iet->verify_time_ms = cfg->verify_time;
> > > +	iet->tx_min_frag_size = cfg->tx_min_frag_size;
> > > +
> > > +	iet->fpe_configured = cfg->tx_enabled;
> > > +	iet->mac_verify_configured = cfg->verify_enabled;
> > 
> > Changes to the verification parameters should retrigger the verification
> > state machine, even if the link did not flap. Also, changes to the
> > ENABLED state should similarly be applied right away.
> 
> .set_mm() will return -EBUSY if the interfaces are up.

So it won't work with the openlldp stack?
tools/testing/selftests/drivers/net/hw/ethtool_mm.sh won't pass either?
(see h1_create() and h2_create())

I think adding such limitation will put the icssg in a world of its own,
technically implementing the same API as other network controllers but
practically not usable with the same scripts and tools.

