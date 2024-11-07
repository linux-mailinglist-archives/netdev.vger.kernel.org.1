Return-Path: <netdev+bounces-142654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C469E9BFDB6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D961F22345
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8F191F98;
	Thu,  7 Nov 2024 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="T8oOw8V5"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483B10F9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958011; cv=fail; b=NMQMh86McXIp6nj5NiQM+tLybljZWYoR9ELZ8IRTzJ+Fp6BpLFGud0b91gVqWPiyuhKbStIx2uFM4af+ZpLgYefKSxuLDOqXNSjTOPbIKel90ro3f/jAOnd0bO5YnO65VPPae7RhxpA4D0jIhoIFylDEx1zS/wefPA3pE7ZLOqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958011; c=relaxed/simple;
	bh=dVG0AdV4owdqGpZBTdSE5gp4yI47lCP7lgZum0JTeeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4YxfytguEtHSjQvosikFo6iD9s9gjCfStXv6nGU7Wu0PKgfKUJp4B2cI8XXYc7m8l6+nL+4q3cY0Dj11lIXeoXcUGyBBWNC8Ycp+9ZTYGbXfCbncnAl75zgaIwOPydXnWB8ad3DT3RuIatZrr4/je10x+YXl7xJoGIHb8kDLfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=T8oOw8V5; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 247FC1C0056;
	Thu,  7 Nov 2024 05:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/cQ7+Ax/9F9O0cXP/cb5bmFkHM0D2i+8wtBqrhicD91ZsTMnxsg1gVPtbKoufVPDG6uQ2X1hzPjcDRReveTPz/akNQ47HHCitrKUYoFqC4T1fnuY61NyntCBjMOhnYh0ysmpBD0N3F3m6a3Vz4z5NSN9+yOoj1s9TIdWqdU8JyFraKy1tWeEJINUVUC/k3KPcX27+RfM6uWwaYwHSmXwfjgTu4UxF6D4PzM7mtf+X1J6aF8/VbgpdCnScCDX2yDCVmnvT8uDMeQyeMuLaD9v3QphmGnHZOEwn9mGwxKBfEjFq1Qe8jJqDJPsksPE1UELQg0j21KK3cB2T6cZYrMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmO7yto1fJFsUq3Ylh6nDQUvL1ISOIcGzuyh08K0y/U=;
 b=Iqkz0jzQoCWn3saqw21n6e5TC6mwYrqbHCIV05VGNbh/zk85oiMJ8J5Qul8LNPli0ySidEYsOUGx7O68WgoZHbgpLaVZ1x4Q5IHtZnjxUuRMVB14QA1AU1CJHbzcZZE8wVfmlPQtc0Z2IrvdnxQDCBmyUUluDIqZtGt83VIkvpLc45LnVY6fcZFEBGtq//qpK8dOLQXKu65A8YrofxIdKY+/48Rn0p/4KV887X4xJTo0EUnynF2sVKdzSEbmpJWYFriJjhIygfTLUkzpuqSXD+nS3xmQwvG5wnpRrDSa+VePAYzzDLSP8r0VXDmihnvISBWwqVszgnEwBsaG4HtkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmO7yto1fJFsUq3Ylh6nDQUvL1ISOIcGzuyh08K0y/U=;
 b=T8oOw8V5s/Dn++nn9/7JJCnw7X7vl24olnqYHyxMVllrjjMnay+BDp+TdZ8et6qCTM/kLya/uHgEhsDmvzh7tJBqlWFxrRpecVRTuM0BQsDVh9cVy6cEyUf2unH9/80L66qFIDgJOR93TJp+v6Vfx9LQJVRRwPgu7IRIDHpcODc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PR3PR08MB5817.eurprd08.prod.outlook.com (2603:10a6:102:82::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 05:39:59 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 05:39:59 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v8 4/6] neighbour: Convert iteration to use hlist+macro
Date: Thu,  7 Nov 2024 05:39:46 +0000
Message-Id: <20241107053946.1252382-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106230703.48870-1-kuniyu@amazon.com>
References: <20241106230703.48870-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PR3PR08MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: a840c9ca-746f-49a5-2e31-08dcfeee9e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?crAO3rE47wZeI1VVruEV0d0FxV+Q3EAOQPZ175GIBNaDyJTfd5ejAkKvJCeR?=
 =?us-ascii?Q?xx7XERYoAZWjFkfRPpawmpbj07XNiJdjYRIN0aj3PKVXprvdjWwVrUAp7QAE?=
 =?us-ascii?Q?IREhMm2iu8Vx/jo7Ji8BmRcTIxl/bhuYy4SFl/+1+iOT4vVm9KXhNxPBPtMS?=
 =?us-ascii?Q?sPgYlnQzJlDBVGgzxkOrSpQG7DCGzhXCYnli+bp2xcph82HYDB3cBqvwYihf?=
 =?us-ascii?Q?EK+xFWBuzLMN7ryK0ONf4uEFqWkDk0AxbKGQLMoLzC82lq3vAEBR6ljUG/HM?=
 =?us-ascii?Q?/i2U1HW9YNwZSOqTg2zfWrQJayCNxxaGtAH1ft4HriczRmpH+psEAcVQkwUg?=
 =?us-ascii?Q?o5l1611wFeL8803pcLI67A0YSr8Q6Qn6VaLfOKOSFXavQYF8YOFfYzMhKDUZ?=
 =?us-ascii?Q?7Rb6D6bvifonMkVy+mmVfyp5riu+pS+5TkF21MSmeL9Io6yiC7cQpmvoqMDw?=
 =?us-ascii?Q?rxgUnxjszIaLXI1b4wrfMuUcKg1cdKkDJf3RqTqZYG7G3naMzgrGN4aOdAwa?=
 =?us-ascii?Q?GHFAtH1lG3qjNFSFUJ1eDuS4sJY3OTV1b3DRQM9gaRvJIliIrV6M9g2Jd3lB?=
 =?us-ascii?Q?V04OKE3NMQoX/ItqVWhWDFJrX8P/zF3UWs8q4OX0gqQWVOJ9n5JprDVhtvNn?=
 =?us-ascii?Q?wIVxeEis34DnZuiaIH9EvbAuAb4+uiLT1xpbkSXKr53xKfZphQKfYFfGzL81?=
 =?us-ascii?Q?V3E8rnnNHZP1OqqFDn5U+nHhlZsYE8R1ZB5QzyRCrN90KZtX3SmUMm1Dee3d?=
 =?us-ascii?Q?lhObLKhySm9EPJhlo3Opr0qYVvhQ8DXcNmBxyOT/+isZPgdS8h+71xwg1PuT?=
 =?us-ascii?Q?e0LUDfzEMI+bOFwI7iR71i+fWcoIKDtryJyRXsqRv+mVin17wP5LFXGn79zU?=
 =?us-ascii?Q?nV/1KhOvW+IL+3VTHT2xo5nrVDYCsckoR9KLV4Rp6JHPPxLLSim4gl6QgHUn?=
 =?us-ascii?Q?NcRmTfNQHn9AZoddzuQ7UU75GcSDWhPtxxb092rnnF7KkZydfUKv1cOBskND?=
 =?us-ascii?Q?5Z2v/764bK9vXRIaA+PJUWGtt/sxjaxwYCS6qM6DoKYLu7MoT8lpUzAtYfK9?=
 =?us-ascii?Q?X94js8m033m4VtEES+vpVL2X5pJbl+LJoAiFtbSkh+kOWyQAZx9GMx8YpP+3?=
 =?us-ascii?Q?vhtIxqD+YSjWLN8E7rgLCXK+IRMgvXEzZxi1psKDpGBzjlxdo6xWOu7Q3ZyO?=
 =?us-ascii?Q?J3A3sWx+pmecKrxB1oLbcJqAjK+OERINV+qP67ckC8eroXavWBLwNLqKyQmQ?=
 =?us-ascii?Q?q8O39roCAxRumFDojSQq0oZJ3rVPZLWebc+RLMd/m+SEKDdgDtSf0sC3tPBG?=
 =?us-ascii?Q?BqKem1lTI4892VZ1UsIXV/OiJdUxIcpJbgDZyIvHDXc2xg8E2yw1AExm5TY7?=
 =?us-ascii?Q?mVLxaEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tdMnSlpZ30nn3jaTEyNXuYYbL31EHss2wmjRzPZqaqrHJbz5cQUVPwHZkuB+?=
 =?us-ascii?Q?8vSGwxzO8ByFaaqUOgMmQxCtsBSo9QnaLopcQAvQ27AaM5r9VdkQpgkNBvIf?=
 =?us-ascii?Q?cHKCdx7DCoq0kS4AdORv32MOydHSrMDUGakWXnJ8jFf4ypU1pxqdfbLVu6Od?=
 =?us-ascii?Q?xiaRxt2NguFjKoxdUrNr5UTD4zqTDUHyH6GolONG89Sb/jKTck6SlbUxUGSM?=
 =?us-ascii?Q?mWMYYbKa3HWkZztzWixxORNTC6iOWN/4Tkml/5iCqtIv+1LOTQjaGnx1NBvl?=
 =?us-ascii?Q?g3B8qyYDbeO17t4268Hpv62sGykQmEsPgVPxMwqcbRvwbDsqj7UO2CPItI2a?=
 =?us-ascii?Q?o9BSZkym43tgHHOocuD17F3XZo4fmhFddPsV7aMvpzYuhW3SsEOne39QAyt+?=
 =?us-ascii?Q?pbUrae6qTA3duBjZ8uOLRlkUbxf92dxUK6nFVARqFXzskVC23dRzFj8npM06?=
 =?us-ascii?Q?HTnjt37rQ5HsgF0/dVYFrD9lceNcDByrYzr+3uwPpqVsJzTiuCYpIQJsCA4/?=
 =?us-ascii?Q?Q9KtbK1ODDdofordCge4gSuDvQBl8V2prOY1ztuUluvI1NTGXNszwt8S+uzj?=
 =?us-ascii?Q?mPpNfQF//a3HTlAYKgn7Qwj7ylPLpFkg1c3eyLN+0VfvAqAChf3+hI63laEg?=
 =?us-ascii?Q?FdtVGi6nNUmiszBV1T6hMyNuUz2zSbIyvFJe8Ft5gSEUy5tazM8eGF5/bSNK?=
 =?us-ascii?Q?01WjXH6XvQmXqniCFedcfBjbLKBuS3mYQWsd+XL7cVRpGb5lXzLSECn0kM1r?=
 =?us-ascii?Q?RmTkaIsgkOZmCySN77qSuuMsQa42xNwexUqExIMzscJf55tUyYCMV8fCaPhS?=
 =?us-ascii?Q?TSW9ZFBL7Fu8oYHREho/DaRRX6feC9X4NwK7PExeQAVZj214KdCsPuNWBXDn?=
 =?us-ascii?Q?U+Xf2QMBVjR5h7Ow2O5YGblHzrdteyMeSDoJrfpaoNBN0TKvz+JCkO09WCdl?=
 =?us-ascii?Q?vVdcYEMD9K3nw8NtWg++rwVzNvufE1Jnev89NiZB5WPLsSrG0/D6e+4ZdoQU?=
 =?us-ascii?Q?Ori3jg8C2KS2Y/Y1W73feh4v9+EqrHUNSgiC2vHuFWCms1Dkizv8V7T+rhGy?=
 =?us-ascii?Q?qT7IAQBMAuwHU4tMSkJol89CgSgi+FUEIMM9J/IbLctkeRxE2j3u5fyNhjPm?=
 =?us-ascii?Q?N1tUm6CS/DfSg5QF0IF6b/01TRF5gmlhdEwidxPoUyGBft3eo+VdhUkfB1Fz?=
 =?us-ascii?Q?P8vpIRGSZxBOqMPzxVJjdw4MY15aSpH/z/Dn9W48W1s9I32Z0bMjL1V8bPJz?=
 =?us-ascii?Q?lxlrWZXIXlkgVhg/Wu+zsS3bzVz42DnIuT0h5FdfGryIdYt4H43VJnxu12G/?=
 =?us-ascii?Q?BuMpMBN2CTMFzmQH2+1JbQaiy7TXziiEDWeOtlz6yEMJRRXJXRbiRH2AWrNI?=
 =?us-ascii?Q?UquA0kZ2bcAwu7QoIWT8SvCNl0aYClsRuvVDMKUhaMdAeA29Cod06xf2qeIF?=
 =?us-ascii?Q?+v7e+CJr61KOulemJy+CN4KeAr35HP2qYO2B7KCOOWr+pNgKdY6U29UPFKkF?=
 =?us-ascii?Q?hHNafmzUPqY6SdqLpw19QZHSOSXHqgM5boumi3izWBu04ThBggiHoED2gSIM?=
 =?us-ascii?Q?mQ56a5XTY2z2GNsXKUFa/8cZGGzgAkwpv2B36n7E966xGRSMYHl4ZVKfCOxI?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q6GhxQ3bo0IK8c39Aa9ffMx9C8RXkgi3yDbYdAAvKT2riwdat5krzPIde9O3Xv/ObKiw9rf8mNQV6cWdp8GQuGpwEMb0N17tIBDfWi3o69WP3DqUTDchm3tOfEht7Vp/NPd/7Hq/wUKMr7KyTTPF/8xYYS4cQIHMcMrEKhzjVqiBJWDhKl6KXh41hl/CxTiejPCQFLAqTnBX10sa+aS82nPZo0z/CE8jkgIekK8cg0BNYzBWGVkBh0ElegE4wQJtaTLNcwzFxBBFZ7EQ6H6V6w+0NLXAL02rGLedtq+waagT2XtUFYViL0VTYvKz8oAez+hpNn9+nlOUXJyCCaNaeHvMK6SKKMjTa3bmujtbFIfz8zXbgNW3kVsr2em8J2Sdv+rTi4AgQlHMJhRQGsbYMPyNqftdKtbcCSzd7RgN7zKqtHUP0Pg8xD18aSfI+cdFngWezrUBJ9+LFOjvW6d9pEt12NvcNk+7s31N3o13mZxQv/v4EVWVc4je9h2sUlFFlIjDwtjpxF89VS7tVKPB+GuEajJMaO/C4jikGK0OOcPkq5pZ9Wv483Jt/EVYJ0aNjAOEVvenwOX2sYjilGVp7nf0CyqodKqIAu2Uxgkr5X0Ff2885sN9JX/VLPcDZ6Qu
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a840c9ca-746f-49a5-2e31-08dcfeee9e0f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 05:39:58.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suVD/2bLeyAiyrpdOhfKwm5w4Z9wuRQqx7heH5qnl4VPDvvTNMolergn092gq+dyG7CbHHCApzpUeZ/6rG9yJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5817
X-MDID: 1730958002-hvU1Usv8Lrms
X-MDID-O:
 eu1;ams;1730958002;hvU1Usv8Lrms;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

> > diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> > index 69aaacd1419f..68b1970d9045 100644
> > --- a/include/net/neighbour.h
> > +++ b/include/net/neighbour.h
> > @@ -309,12 +309,9 @@ static inline struct neighbour *___neigh_lookup_noref(
> >  	u32 hash_val;
> >  
> >  	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
> > -	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
> > -	     n != NULL;
> > -	     n = rcu_dereference(n->next)) {
> > +	neigh_for_each_in_bucket(n, &nht->hash_heads[hash_val])
> 
> Sorry, I missed this part needs to be _rcu version.
> 
> You can keep my Reviewed-by tag in v9.
> 

No problem at all, will do.

Is it possible that the `_rcu` version will also be needed in `neigh_dump_table`?
It is called from an `rcu_read_lock`ed section, and it doesn't hold the table-lock.

