Return-Path: <netdev+bounces-92353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D88B6C9A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000CAB2238E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75654905;
	Tue, 30 Apr 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KiHuGkNL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jmP1awT2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB33F9FC
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464996; cv=fail; b=IolZ+ta4TNJtP10nr3G+3HUUmBmIcLwsri4zGlrG2U12z6iIAymfNxYGxe4CObNPZu/BnbNCCRiTDVKzNYDiW6mu0As7Y0+k228hM7+iT73kv9NAD4e3urOaFnBWrURaal1WgqrYGN21vqapnaCvCVxE/BtUJgq0NGbrFlCbHM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464996; c=relaxed/simple;
	bh=7TQw3Efg1mOQZtd0RHvpTXNa76QUPUFMkGNLU8JrzGM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=H3dWeTFoTVCRox0YBdEuu1uk9gYEKivKZNA75DSryPuc/EJUURGmu+PKsDQPItuATo850aaWcjsHQDwu+jO+KBTjdSeRruB7TK5ET2AQwiUOLW2pO3rsREg74KjvLQzr9VLSCrSo2jkWvWhcoa1Y63bkDPwtguRMRcr0noZuFoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KiHuGkNL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jmP1awT2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43U1hp5t006293;
	Tue, 30 Apr 2024 08:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=seAz3XXYfqooEZLp5W6pvaXV+vGljZ3hZsv+pXnF2VY=;
 b=KiHuGkNLKrH24KhiPK/X/V42jPmkTqWUxWEpVMQKKV49yxk9Z9KpAre8Cpx2jcmYCTMY
 JLUlERMC85VKtv11cumvhF8veAWbo89tRQ5I8p/DYyhTQ54INtXHArnSJXfSHhWLn/sC
 4yvhVArL1GEBjvSDvDGdWNld7mYpZ3YwZdBNZ5uaXFNe/sq4XV4J0d5CJpnJuze09Zpy
 KWipwkyP75+u0Me0wtN+37kmINXnFXf2Qd6R0fYZbRn+6WEaivF0mX4X1zwy4ApdWYJM
 5FQKBZPFLkU354frezm5sLCMgOMzjVXmqyBxuQT06OJg6wRXiBTuApV2y1a1d+xHLxT9 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54ce68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:16:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43U81nN1005005;
	Tue, 30 Apr 2024 08:16:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt72fe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qte7+DrqRROR3eAGgJPeGht1fi/pjE+DfUoGA8qo77SRnqG1G7MlWc076btWNWKX7Lm5VPDoVqN/SkHjI/mPhlOXVUUgXcCZQvsEy0oPnMBj3dYyi1B7iJnzXYPFO0w+00nLCz6a236a0EshLzEfaJrFQLrYUtEf2hQ+ccH0OX0AxutCjS8EgHwrK8ky2xapzB4Lerr74I/tRmXUXEd8Dnz6YsuOZAQZ17E1VcbTewuMmJyI7zzbAUx+xzncovyrlpjtHbGAVQbvzDjRd+j7xyPq+Eylcnr3jcvIt0Y4WuUMbilI83UM9TLaz1U1YDiSrcXkzu9thWDCBSMWB3Crwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seAz3XXYfqooEZLp5W6pvaXV+vGljZ3hZsv+pXnF2VY=;
 b=iUPXBuG6rG7bZT1r8oT8Qp3Qa9bSK/P/q97jzCL7O+chQo9+E668O28w8YdrV2aOOoMbJwBhcyZg6GaIPAy9PIeJwVOuL9Z6nyLbh8xIX2BpudR7wOERFBUiGJFzQ1Z316huATMclb6lWh9DgW7OYHkOtiZ1lOnXa5+zaxkjKjcZDXeQnoXsmID2ApRpzax1rFqnRD9+zk+D/MD3VonJIBX5qOVuICET2gV9HmgHOs3/ORQfDcVf8z0SVPl5G9AqE5HuQXJoQSDQDpq3iqD/zme3ZT3ncnaBby9YyE1btsLFuHrM8iE8qeSjb2i1P9Th0GPoSGoFKlyUuzPGhTYGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seAz3XXYfqooEZLp5W6pvaXV+vGljZ3hZsv+pXnF2VY=;
 b=jmP1awT2E2oJ0LtGWjx+SIHeW3ew9RyUYU639Eq5X5gQXxk0yASpNH3+JVF50dAPrpFjlH3syllnULpnhwmEIpWzpCGLe7LblN3vYxl+iu9LonihiireGQ69w8EWkDSUtvDfoAciuSOqZnYHC+Ry69BW3dbLYfDv6B9Qo8wUR30=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by BN0PR10MB5047.namprd10.prod.outlook.com (2603:10b6:408:12a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 08:16:16 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:16:16 +0000
Date: Tue, 30 Apr 2024 01:16:13 -0700
From: Rao Shoaib <Rao.Shoaib@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kuniyu@amazon.com, netdev@vger.kernel.org
Subject: [PATCH net v4] af_unix: Read with MSG_PEEK loops if the first unread
 byte is OOB
Message-ID: <ZjCozXP/DBt/C8WZ@shoaib-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|BN0PR10MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b8a058-af32-44ca-e9a4-08dc68edcee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lnr955H/wgdms6IhjCu4x6/mTxpOcn5EKxtO3IPLPSZy/VvwmLp4AlxVIocV?=
 =?us-ascii?Q?ODBbehjs6alYRNO0XOOcD4zk+CX0KwoRrL9367niODvXjZmomtBvssRGGsv/?=
 =?us-ascii?Q?CVXa1VbD+DxG9y9Us1BjMZgL/WhbQKfWdAZA8a3qJ9CBuYYpeW1YRxPQzr2Y?=
 =?us-ascii?Q?jMxQq5LJDome0pC1CAtsjlH+AcsdXumK5idMLQp0snt/AfCBTrFD9QWlTxGr?=
 =?us-ascii?Q?S7ySUlqlujY7r6g92iAuIlwBYA8gYBQf62LEpOzUbzrEPdSrEtGa9jFL6eI4?=
 =?us-ascii?Q?iKmZih6RlPTb6NPPJhA14dTkk5U1Gko7+oaBcHPppg2Qng8UHj2nunhPppcL?=
 =?us-ascii?Q?vNvr6jCvB/5S7GyOj0mBFEaCtrwe4q+d1S1zSp5Idt9c59omVvmk0vKX5NO+?=
 =?us-ascii?Q?bN5vJ2T4mCEEfc/6BYHXsAc1EJxi4mNm7+tcdL7sjlr3cYmskWpAc6Eoz3vU?=
 =?us-ascii?Q?tL8YR+/9QTLphQ8psEmanFMr6cHP7im9Q6FeMv5AJvfGwhtUSr/vpaA84Ijd?=
 =?us-ascii?Q?/nGdIJLyfaayeCO+cfx8naLwA1HtJCiwaZmGFHrn4/M/juK1/2EVx5AcOUZ2?=
 =?us-ascii?Q?xPvuRvs1EyteqfpqrlF6hWN59wMEoC4L32OOnHUZUR/IroMEfRMr+iO+2d0i?=
 =?us-ascii?Q?JLJF3AKLFKn8YH/baHIbIGcE1D/7YAg5bICMDS3Yru+EFZUfiaFhk/YZSPSB?=
 =?us-ascii?Q?6k5+znJDCJ/exqe5P8To40SY1Dp5ZqdIlmSFH/6j4cjWPIFvvrrVDraKhBA1?=
 =?us-ascii?Q?dPHSZ1P6YhL5lSJza6HqSp8sTauOGu6A16qF+8Cjd0nXMFOF8JeF10pvFr7H?=
 =?us-ascii?Q?AU/g8+XaIMh0puZfMY3vDhzUqYR2yg4UbO7GTVhZbFtKPniSJzcyg/5je4jX?=
 =?us-ascii?Q?7fT1RG8JjAW96Z8fgqdjkq4693xBObZtyMFJsTgEmxcC5CjgbnWK9FJ+fcko?=
 =?us-ascii?Q?d9bCXePVAEnT78yYgZhbAy41Qt4l/vSEuPDavaJJ+a8sJe/DOrBLJaAymGVP?=
 =?us-ascii?Q?vEiJmdBhAPwFdhrsdy5TdvF1tq1OEErShq2xGeNoLFalexXUc0VM2OqAc4XD?=
 =?us-ascii?Q?lU96GsusdSMBlBfT8aTpVdpIBP8Q8iC1NgnTZ9k1Ycy9syG2axlEzo+GTgYG?=
 =?us-ascii?Q?gYNtjxoSpTW7mzlGAH2hFR6lB4C8hY0f/sWIG1vJfhLhcqzPN1dHzhm4FGHa?=
 =?us-ascii?Q?pUHR9Jx0OR0FqBJTU8+Go2yiCRR3X2buSckfksV0Ab++ZJeqOI1rTvIyU6vC?=
 =?us-ascii?Q?lt4Oz+mJ4OkhIzeCsaW723yVQqbaVvLsRQrlRTCZlw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cr/hPkVkXvLgW10EOWjJj6a8tOW15qmY3PYNj+yD0mn3ustNrSG8feZnikZH?=
 =?us-ascii?Q?u5jbkIeMarlzgDZhvFPpmO0mlEgwcLMF8zGdxp9OBJr/bV6G4O967KccVmYm?=
 =?us-ascii?Q?equ3Bw/2za3RTVFl/PhN4d3LNKbnU02s16Ou7VagTpRq2vBYWtHn7rUz2w/D?=
 =?us-ascii?Q?5aaGhLbgT0c9A31yuAz7atDC7zuYXcZMZ7Ush5EbGoMeLTarisAe27XLOgtp?=
 =?us-ascii?Q?Wy94fnaLTEXROApEELQ1G5lzZ0N0tOyHmdMtwmXK1vkiV0fpvOuY503BRb9B?=
 =?us-ascii?Q?PQD94636I2GzDuR9l2Soa1RggxzUKIQR6RKP7VhlmPAxeV13A7QvP16cHK4P?=
 =?us-ascii?Q?IAld9kxiE/ePil+F/d3i7l8WgW1vf8ic+4qJIAb5Hi6gTiW4gjF4XzVoPBx1?=
 =?us-ascii?Q?S537KUAOwm1Z7Tvu3mSS/edZ5rqVFz0QFUV0WTBq1zcGtgJWMnZ2Af7qbBfF?=
 =?us-ascii?Q?73ag1HNRVYER4LIR59bBC95s6LulOg/E11X1JbEGougeauoV3VQwIXPwkaOj?=
 =?us-ascii?Q?TWw4Hyw+17j4An36oSM5x0Xkc7Qo6rI+uP9U0YGc/m9TzT59ss9aBbXRfFRd?=
 =?us-ascii?Q?EDzx0W+q+LjEsXKWVDmIMnOLtAJokmkCSBakdhYGZdTOxo+GL5AUz0wpul2J?=
 =?us-ascii?Q?fLWoZbCP5pXuXlBg8n56SB+rwb+F+UYiYXHOJfnsdTAMLjfWjhfrFSSqMvp/?=
 =?us-ascii?Q?nHjLZ8sALw0mPl2ed58MRHqW1SirJX/EY3RWwIbyBxDsbtl8QUAiEQHnX2Su?=
 =?us-ascii?Q?ySdYEzd9Ml2i50zVDQh5g0Xli5SgDwoc/7vpy4Of4r1hN2aSvPw+9n7BD2P5?=
 =?us-ascii?Q?92QrnTf2RJREWsWWsW64PoRbW87/AQAbPSQ+D/n3Zqr3mZrH4WijRgBa+lfm?=
 =?us-ascii?Q?Uf27jYxBLhvpv3xWvQwIU1Vk2y8TpFlwyd7Hl4xfk7Mzjib4nQ96bSy6dBka?=
 =?us-ascii?Q?i4uvk2mTE7/wmEOFCigI69jI4WfxVuwW1FFgzd1i0svJwmWD1/QcaL99HzDq?=
 =?us-ascii?Q?XSnFkV9iutbI5ZbbxlVPP9ILpByc2Hc0nhSWxBiJmR7BrZ9D/0bdR63dWNzf?=
 =?us-ascii?Q?quQZYZeQgLM0vnMCPlLLnWlvTvFjxBTyGf0gx0EGNi9a8S7/YOZOOuw7Ejas?=
 =?us-ascii?Q?LyCV2LapvaZnThssWetnb+Gn9emB9szkIFzLn/UyE05GyYd+jGrhiCktPma+?=
 =?us-ascii?Q?pu7RLSCJsOt7nmp3YXPQ19+Tjl6YKjxjFO/bJV5wp63eF+nIVR6XdrfaHUcX?=
 =?us-ascii?Q?4xW03i/Hwh3Whq8fYTzUgtu49ERZ0vS2g9euCuFt6i7CM3SMHIQ4/Yzvdiiq?=
 =?us-ascii?Q?08M5E4v/45wlyoaGOg8FD5UdbYZ+rJBVGuhVnXydm9sybyOkEUOFOP8N7VIx?=
 =?us-ascii?Q?fOMAu+JSro8R8WwBCNdUoQv0UxgqzeNiV1uVEm0V+QUX1DqYlXH0/nqj6cI/?=
 =?us-ascii?Q?THY1Wga64zt4o/wLzrOgTN85IhPDXPMqGZsBNPJ1Cet/aNBm66T8l68vAUAH?=
 =?us-ascii?Q?BA032Wl6D5iRgAJSvdI3/7/mRpqsmPx/WOhcrJmkvtsBNyu5xQLWsXWyPfG2?=
 =?us-ascii?Q?MhOxRLjx39ZN9QD0VxRLhIa83qB0UeqQVt33dFVJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nkKonaxqe4t3qPqPr1TFrExC8AVACmcAWaWe1o4d+NiC+SI/p3l5/vawZW5/jvz5zOCXafvEVxoft7p3ORov7AhL7WEbC2h+1qK8Qg0f6MDeGwU7gzbe18fDXIkzOr+47zx/sfFJ9Ghu6ECNg8cosqYCz0GP6MC9ictDgzt623XNgSnwTvRKUcSiqfeyUFuKED1LBbmdO96i6d65SR45JK4iNvcbErI6UG7yD/gyY5x6mZn2XIFCVcfVcK1Ets01ivWsUu0CzvdJ7+0xWoE8Le9DKRubJqsQytc1pbuZM5vNx5GRqOWNpALpY5YMn/gyda3JCZiVyVNRWcVHxUKqQR0tZxUBHttr6pGW9WTZZYB8D5rbZbk1ZL9XKfrAuPnlsHmpgPRluS9Cu+GmfHj+/g2esnkj3JlEhSQeBE+tlxNj+9vw4O/mDvVBjpTJplbbaHBnvJBj01+DFcewUer+2Ivd1HZegqV/kwUyPW/sayufVWeInmg+Cf3uweQuF+ikSD9GDHcAKnYP+0pKvD5PhIgqOhh+6hXufJQJUMaVQZfQj9eW6Nl+9TPM0bXHMnA+t4ARSXN1VqzWAhTAtQWkx/o/pF3Fm/fSYas/k5wFs7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b8a058-af32-44ca-e9a4-08dc68edcee7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:16:16.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Qw8yLzLPenk4BpJh5CCT2t8QtnbSogWIo4z8XqclOfzKvwrTKtEAUZ5G0bZ1J2IN4PF8NaslgxASkR3AJtdfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300058
X-Proofpoint-ORIG-GUID: ZiWqX65rinsqnDCS0O2O601ZPaoGp80p
X-Proofpoint-GUID: ZiWqX65rinsqnDCS0O2O601ZPaoGp80p

Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
addresses the loop issue but does not address the issue that no data
beyond OOB byte can be read.

>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>> c1.send(b'a', MSG_OOB)
1
>>> c1.send(b'b')
1
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'b'

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---
 net/unix/af_unix.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..e88ec8744329 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
-			} else if (sock_flag(sk, SOCK_URGINLINE)) {
-				if (!(flags & MSG_PEEK)) {
+			} else if (!(flags & MSG_PEEK)) {
+				if (sock_flag(sk, SOCK_URGINLINE)) {
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
+				} else {
+					skb_unlink(skb, &sk->sk_receive_queue);
+					WRITE_ONCE(u->oob_skb, NULL);
+					if (!WARN_ON_ONCE(skb_unref(skb)))
+						kfree_skb(skb);
+					skb = skb_peek(&sk->sk_receive_queue);
 				}
-			} else if (flags & MSG_PEEK) {
-				skb = NULL;
-			} else {
-				skb_unlink(skb, &sk->sk_receive_queue);
-				WRITE_ONCE(u->oob_skb, NULL);
-				if (!WARN_ON_ONCE(skb_unref(skb)))
-					kfree_skb(skb);
-				skb = skb_peek(&sk->sk_receive_queue);
+			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			}
 		}
 	}
@@ -2747,9 +2747,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
-			if (!skb && copied) {
+			if (!skb) {
 				unix_state_unlock(sk);
-				break;
+				if (copied || (flags & MSG_PEEK))
+					break;
 			}
 		}
 #endif
-- 
2.39.3


