Return-Path: <netdev+bounces-107445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF291B01A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FAD283E16
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC119B3D8;
	Thu, 27 Jun 2024 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JaLAWwjB";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="MlP8Vhuv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE045BE4;
	Thu, 27 Jun 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518896; cv=fail; b=XhKJUHJAo8c+N+R949Ooif/n+Ujma5YwmzOmcXkXFGGEdDtv4Z5RkZwZ8CTViF1vP+RwlEInBbGxPJAB9hui4xMokrwjG2i/bq9XcwDpiKNJoVs/GmP+HXqlfn90ODJHWPABMrrQyubhazr1hjSLbeGw/ocXXtrLlBU/rkRjaPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518896; c=relaxed/simple;
	bh=aelTB9qzqPODZijT4xEWFVNlW+7SQ6XHWzhCbDHCDo4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EGP3CC60RcivP3BLqcf6fBL7ZSxtPDUr6zPM+1S20skm4gYaeWP8eaNiGZt/bVOOEBwjGFW3vuwYMJ0UWHVuNm4LW7BfFWPX+jZN9pyI3ofnNXlGqUf19wZIeBcEFKkibtH8RFKlbLk0FV8pMJPeF0pb30wLgOtT9GQUXjZpl5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JaLAWwjB; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=MlP8Vhuv; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RJ0Vlc001099;
	Thu, 27 Jun 2024 13:07:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=mDrrpsiglw1+M
	/W6v3lMsUXW2e8/GEeEayJKF4YmtdY=; b=JaLAWwjB8HCJMrQoNAl3Qddw3RcDN
	cfowEOXqGG/BGx542Ql0JkW/SMSH22kXcwu/+k3m2lK/cR/HrlJs3zXSzAoXGVra
	Nz52eahcMer2+qpaImcwYEAzETtOpwJL7dNwc6rZ/zIQnaCyMcVl2tbPCVlmIByn
	4a8cbsqO1cKJ6EdwxFod0Phekzb6D78LiLxiGvMOL7wyw8Fe3dBuCyJEgolKOs86
	Y6qvpuouS6D3MoB6B2pG+9k4635JqyReldQSTjQoJJ6EnPhJTm6YMY2eufxSgFQw
	1pH18m4uCmoVajVfVJdcg42wsWeyHdP8ULobWB0/oTl1RtuURMP1gO9bQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 401duy84f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4LSMXqOKUxDoYFlCAeA5+WfyWV6h897npxqS0Oh5gSQdF3u5sNX4XZ+YkhcXYNS5gKrJ0vTQOENoWfmbtC7Gym6RtK9ma3eyavK2gA9XnpemHFP7cGyKZ9rcnoBlr6rafn+G/4ivUvCKw46Paru48dbU6HXKAjfkdJjwbzvxsP16kHMGXCj4KlsK/Fu84YduB6R1hJyJQT4xyVrwO2WzwFdyN43T8/WI3oMjK5Aw1h2DFU8X+ztY3yeW70M0/BFySYVk6xWSb22DCoQFV74rgzcUyYHhcJZwN3Z0+bgaPt3FPvNf8Y/95fDbDHxr50ULINgAWTYH3G+3p5tshX9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDrrpsiglw1+M/W6v3lMsUXW2e8/GEeEayJKF4YmtdY=;
 b=h/fvsgnXaQvrFB3yzV5appnYQNDLDITO24BvIN4VkQ3DRqQ2gADA7OpEYXdc+6dJwk4aWOCoXeGiAd+X/xiqGpO/ufmN86ciDXmekxd0IDwFCx9dOp5NLqJRI9vObUtoq04gmmbITBluRPt+Z5yJnNBoqSf3KgicWWDjU6W1jojOahP3WwsxQHFBVgKcOV560cwAkU+wUh842S7lxNLpWfHpeIubnTfHd5J9KsjPk5LhjiTj3ohpNYbYjfVl5oaDiA66Dqs+dUq1m/POAKegp5i/hoIp+0PVkcJlBRE/Eiy8sRKnbI9QHftwQrWgdCtZm/kuHm2vKzC+V2bVenAanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDrrpsiglw1+M/W6v3lMsUXW2e8/GEeEayJKF4YmtdY=;
 b=MlP8VhuvhtZNHAmAZ9ZS9Xe1XIsAjPNWiV/3FrodN4mqYOD1OtwaSESV2fbEYlsjnSJ/NZKap0kXpq53VGbz+IqJB0JWTrR2Vhsp8LMVFJ74pLRQncMyhV3ViM0eml8rY4bfyuCwnTH3TCK+5kyJsD7Qi0HFCdh5IbK8ooSQNWj9kgj685FuYoOMbLwq2mQFTrpKkzUJkdGXgAC1k1E9fn8JmO6fG/iTCa2wqqFxS4kA+jOIf/q+BarPqBGd8ZfIFpwGO12KdJ/tiRq4dx++mw5uF9n8YK1pwbuBqEPUonnBCRTLyXgQ71gsGeeFSkPXvlrFxqvO9YlanAKxuYKIeQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH2PR02MB7047.namprd02.prod.outlook.com
 (2603:10b6:610:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 20:07:49 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 20:07:49 +0000
From: Jon Kohler <jon@nutanix.com>
To: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v4] enic: add ethtool get_channel support
Date: Thu, 27 Jun 2024 13:20:13 -0700
Message-ID: <20240627202013.2398217-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|CH2PR02MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 5660a7ef-1548-4b11-e887-08dc96e4d15d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rsWfuSG8xahzmzFibqHwLkM947ny5sEJtPjp+kMNblZuRAGhszobBwv7ZcZk?=
 =?us-ascii?Q?oCqMtzEMFFv92W477u5i/OnvrCMcihtkWGlSxaU2FBQpTxyCSW95cnA9BDi7?=
 =?us-ascii?Q?Q5LU1pKSUB2bAaYcX9vQBbCA/WZ5b2m89hQFZXNBpYjbUt6LM4FV/9wubMu0?=
 =?us-ascii?Q?JkftbVW1mUwYzXrP67UPuCwhDnsomW1FmapE5+MWa9kaqxm4lPDx5tPh/hE6?=
 =?us-ascii?Q?ZEl2EDk8wJuWWMybLINFzefEScGrJxw0b6C6iDqVfasO2naDBL+N0uemNt/M?=
 =?us-ascii?Q?btaLdVO2mY4IMkMK37sjwFXxNA62B0JHIlPbz/0YhQQNBt/Ez5pGrWXqxj0K?=
 =?us-ascii?Q?SmcaViBTO9GD2yRBrZ80mScnkSSKMa5bLt/ksfB/Yu71hDuiaQMJ68HVY3SR?=
 =?us-ascii?Q?vLlzWQc0Idcy3jxXAyiFgxwigZ4LUYks2TW1vkcBMnsM42ivy7uj/Lb44Ff3?=
 =?us-ascii?Q?da52Mb7oG21tNy26sDCPh1pAaUsDTMvmOAFL/M4w+kSOv39S46OqA8YOmM7Q?=
 =?us-ascii?Q?KtXedrEAr7a05BK/e7LbPP1NcFP5bCFI/eQMjYGpsqTSNOu++xpq+ZBSErrL?=
 =?us-ascii?Q?wYiD1wz1zMOE3yWvJWOcnQp+rF3PvfzraFDD1+xrjwgys4ME2CJ7Nh9STQHq?=
 =?us-ascii?Q?2z0JM3qPN+kGVrbVY8yEsDL3Z+RVgxHzAWKMhXFwvDqxnsXKbInvNYY8lRba?=
 =?us-ascii?Q?bbv1180lA73L9fdzulNV+DCX8LnjZTeiBqi5pLTZVd3w8e9Zzn4yibIqCwxo?=
 =?us-ascii?Q?n2VXoAnGq9UTbLCABJA9WUmIlADT9Arxav2qya4PBomLB/FQnu1+ykVTtA7B?=
 =?us-ascii?Q?MVnBW8/L6Rz4KVSzoyXC1+8+HM+qQRqI41UO0hW9Boqi7uXeKT5rGeii1Ovr?=
 =?us-ascii?Q?kNcIQYvIpAhcTrp6KNXmaH24HlzH7N7i11cQqgQ2zG5sfShKQP6E3ikbuKEx?=
 =?us-ascii?Q?8jrc/tTYtzjp8Sz7RxfS2Qh3yNM0BVZQq2ZXm30gSK1u/J0G9Un2ib2K7UiR?=
 =?us-ascii?Q?3ZYtX1zLFLpTt7cyPwYH6wxePzU7qOd+2bu61gImZBkVG9GnXHQ3Um/grfPw?=
 =?us-ascii?Q?KeojneLWr71ut7nPf5eZr8hlmD18EKHbdO+el/a12aH0LtzSZW5fzKGE91HF?=
 =?us-ascii?Q?sPa7dCvb4qs3ruAxkNb/sEja2yD0EPAusB349al19ezzjqi+SDAcs17INgWO?=
 =?us-ascii?Q?sR56zWSSEaKlsBzP1hKqt3EvE5mi7sQUXhTz2HPvK3bGYcSXfht+VI9vkUBT?=
 =?us-ascii?Q?+NTZivE1X/MfQlzR3F9ODOvJRGFl9/GxOys2QdR7WDcgaDRhUY4WAMQ7FCo9?=
 =?us-ascii?Q?4LcaneuclGhz6Ne0rSxvKF60CgX/whCjqWpwzo2RVY38zkDeoxqRuXdZH4OT?=
 =?us-ascii?Q?RQa+wqs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Shpi85Ghb5baKT2Z6o4CYX+GIw6r7mI/YLL7rRk1cwxCtx1mlaVS+JxMefeW?=
 =?us-ascii?Q?Q4l+fbWxEKU2sQaHL/vGLG/ev/RWJVwMwjapgtWNjqSPn/N4gCFKwPErs0J/?=
 =?us-ascii?Q?+1mU8DGYOkLoQG2E7Ef+LLoMheIziV4G+6VjPSu5lreoTOvTZUh1SD9xHIFp?=
 =?us-ascii?Q?UNbuRrDeOeeMxUTEvz5f4bH4yDkpZw8g6Me8fOAKSQ8g+wRHCBSnoprMoRzV?=
 =?us-ascii?Q?f+X+bh6jv+c29HJwyeE8AXr+OYKsHQCt7/UuP8edAyTEBc5KNXJBDbODoC2k?=
 =?us-ascii?Q?GKfX+84wDCgGIISqE8Ox66nKbCJc7l1Ylz+OmqBeh6XQBrsAB7JMp8yBk51v?=
 =?us-ascii?Q?WxY8qWo7EoJUoZX9+yDBoaLrRhg2wDyjcbsNoGYsWjk8i1VeE415kedulUAC?=
 =?us-ascii?Q?4Zz/RyP5obBvOPwFqSC5qLy+cFcznatUYYFK2ft70hOIdMT8XXWw7hzjozOW?=
 =?us-ascii?Q?j0U6PyvIa1lS2i6k5+cH9qQLvrJvVZFYalaUCVyiDV+8qrSipuawe4DgnNKY?=
 =?us-ascii?Q?53gQeCV8QVdCUM5/dm7dhfYJbECNzqIvBrFgKDYTXZmsDkdMc5LJewOsv67n?=
 =?us-ascii?Q?n5JIU3Gd+A7QdQ25pRqZn5uF1CZIMfFj6vySNVWA8yQKd11HVYRNakEBWo9R?=
 =?us-ascii?Q?4wqeLKF04zk4kI2+tqvHMxyI0yB8345cGfVKuSfkyeWo1BAwzJ3rGQdSRD1y?=
 =?us-ascii?Q?kbIpH4oVQ0HlS33qLADeDVDo8G/+YZ501elM5iLkAi8s+jtRzvLvFpM36hgA?=
 =?us-ascii?Q?QUhmcmrXIJSvClzEc4aQX5kBgXlF6jD7PmzHvnEXiMP/bSuktc+3IaDMEYJO?=
 =?us-ascii?Q?KT2Zgyxxn84W+yh24J9Ng7UTpY2Jmqk4naor+oFLM0gSYRQBaF4j5/t6EUzX?=
 =?us-ascii?Q?VE47bubYESs72vtzPMOc/koVVZgO1eganQwZscCkqbJpHVFAcyJEsDHWALf3?=
 =?us-ascii?Q?CofZSFGoDjLry2Gzza7vznGw5fQ/4OH9WQ1yWZrNEELS4mMQWlt9xrEFV8MD?=
 =?us-ascii?Q?OkBCrgb8NureZev6DBlVjGt1Km13DZctCT0w4ziE6ubZF6bc5lDWiOuwshd9?=
 =?us-ascii?Q?IjHV6+zTGPztc1lmtW5VCnRXe0pWYYKCxV8NnRCH8deQisGCnZEEKTE899xT?=
 =?us-ascii?Q?6TyMtw5aJWdf69n8RbsDkybY0PnARgaNRWZJelRASHvv2nrfBrlRbw8POvvk?=
 =?us-ascii?Q?6DEk2UUAsqJqHSis3B5e5mGyNQ9giCuugkpidRO6H9vCw6/JahL2VuPu72nB?=
 =?us-ascii?Q?KaoCZTBHtvWN/V2fOFz0ZjkRMAGtbwdikh3nIOKGFPQPRi9rV3oE9Whh/CBf?=
 =?us-ascii?Q?kFj9zr3v0rBcsiGdWIQafEFtofVo53fTmjdVUl0JiqIkd5Ejm1+6YkZy4jSK?=
 =?us-ascii?Q?oSnacC82j0ad3COB4xco9ibi0WWDyTk9IJr0Tcp8kGkfsFYyc5YckNcsMe6f?=
 =?us-ascii?Q?0aDDVoV+mnYEu19n2AEOeziAja7DZMcEX6I/pcAHgAJiMuuu4tPQuHTNTJil?=
 =?us-ascii?Q?x9QghP8K0eqTi0K/7wgoIpIeOcpl8uzpwAOns5BMlKkqlMFlyaGJ9fRSJgJs?=
 =?us-ascii?Q?6NDDtpJgm25kzLN3S0RNVaMzAIu/3sYLwowd+FEEpXWk82Xg6ldIBsrOv3Ce?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5660a7ef-1548-4b11-e887-08dc96e4d15d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 20:07:49.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiTWoxsxOvc5Gez05126ivF0KS9Ilj0FYRTisJsJIS4ChboxV0t972PzqjuBRMi8Wn3h6IdSl6s0Ihsh4syosoLb25VUKqR3kTDPvEH1evU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7047
X-Proofpoint-GUID: -UP03MDVF-_VroPMKrxyWcVIw9ww_NH9
X-Proofpoint-ORIG-GUID: -UP03MDVF-_VroPMKrxyWcVIw9ww_NH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
support to get the current channel configuration.

Note that the driver does not support dynamically changing queue
configuration, so .set_channel is intentionally unused. Instead, users
should use Cisco's hardware management tools (UCSM/IMC) to modify
virtual interface card configuration out of band.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v1
- https://lore.kernel.org/netdev/20240618160146.3900470-1-jon@nutanix.com/T/
v1 -> v2:
- https://lore.kernel.org/netdev/20240624184900.3998084-1-jon@nutanix.com/T/
- Addressed comments from Przemek and Jakub
- Reviewed-by tag for Sai Krishna
v2 -> v3:
- https://lore.kernel.org/netdev/20240626191014.25b9b352@kernel.org/T/#m17016f5f4cde7ed145393773fd8c7a0850860fae
- Addressed comment from Jakub to combine MSI and INTX cases
v3 -> v4:
- Added missing break
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 241906697019..a42f3f280f3e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -608,6 +608,28 @@ static int enic_get_ts_info(struct net_device *netdev,
 	return 0;
 }
 
+static void enic_get_channels(struct net_device *netdev,
+			      struct ethtool_channels *channels)
+{
+	struct enic *enic = netdev_priv(netdev);
+
+	switch (vnic_dev_get_intr_mode(enic->vdev)) {
+	case VNIC_DEV_INTR_MODE_MSIX:
+		channels->max_rx = ENIC_RQ_MAX;
+		channels->max_tx = ENIC_WQ_MAX;
+		channels->rx_count = enic->rq_count;
+		channels->tx_count = enic->wq_count;
+		break;
+	case VNIC_DEV_INTR_MODE_MSI:
+	case VNIC_DEV_INTR_MODE_INTX:
+		channels->max_combined = 1;
+		channels->combined_count = 1;
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct ethtool_ops enic_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
@@ -632,6 +654,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.set_rxfh = enic_set_rxfh,
 	.get_link_ksettings = enic_get_ksettings,
 	.get_ts_info = enic_get_ts_info,
+	.get_channels = enic_get_channels,
 };
 
 void enic_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0


