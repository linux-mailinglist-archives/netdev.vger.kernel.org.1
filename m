Return-Path: <netdev+bounces-61520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A4824276
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4513A28781D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF521372;
	Thu,  4 Jan 2024 13:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2038.outbound.protection.outlook.com [40.92.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07082230C
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGeJ56HBeQA78oouWezRjRd+G//+gHP1Y0UoxfMGScKZxlwhcqH7d5jpAV6nNgHTLeTBvK2OIwL7eDHt6gLocwq/gQQHELxEhvI2mmubqdfA4viwy+cO0TszC9IolY/bueYJZ+OC9ZFlV+N1pZlK5T35yIyYkRXdBI/+YMaV4RBk4PYOqe65ZeYkPCAIXxfbiRz0v4pzgaGAHqCN1xcvkDcgRAbZjUeOizS7aUIDZODPMnQ6mXAhxqMJI2lDEf8D0cU7MDiDOwk305Tmr+DYjlJMH0S1w5MVNQO1DT/JUOS27WHi64Vp2G/KjC9M5bBGzzlRYINvH00MHok4aS0+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGswr07bHLOa1Au6tth3qD9xtTA71JVQjfvo5pZxFoM=;
 b=hxI+DxAed3/ODGORSZ53Dtm8KKiY7+ohxxKDEo/KtSQV0dNybSrIU3Fed+g4+3CRGb4et6dK8VWvozGMKmimDhyicEaQwoVllX+lerltOIH+YR7rzm86jLWseDiF5RvaNPi/6vUJhiQuj/dP7ZsFsfOErNmsxDvcbE2grfugIzb9c/LSBvYv5RkFtxnBTd8xnklWZ3D22mPCSs6zZ/P4yV6OSlVAvKwchCdPhqjUzM2XJNLqKeBxfVDqTwvNXPl/IENfV5We1/Ug41OERMAfWfbIQ6TmxHbdzj5IffPRqhPfrW9ev1q06XiW+bvXesISJHO1xKMNliUxbGLXuKwOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by PA4PR03MB7215.eurprd03.prod.outlook.com (2603:10a6:102:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Thu, 4 Jan
 2024 13:11:01 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 13:11:01 +0000
From: Sergio Palumbo <palumbo.ser@outlook.it>
To: netdev@vger.kernel.org
Subject: sfp module DFP-34X-2C2 at 2500
Date: Thu,  4 Jan 2024 14:10:43 +0100
Message-ID:
 <AS1PR03MB8189F6C1F7DF7907E38198D382672@AS1PR03MB8189.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN: [1W3VLKyOVHvg6EisrWrHv941phlR9qoM]
X-ClientProxiedBy: ZR0P278CA0210.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::17) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <20240104131043.5469-1-palumbo.ser@outlook.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|PA4PR03MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f303f37-cebf-4de0-2cd9-08dc0d2698fc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A2EN7pPv4w/ieumCdPqNxfMnWJIT5pKJ2s9dIKcCO1EzXtPVv3iHvf2snuihmZqOnq7HpAIGcBjegbfdQCpienNd5myfcVPTywFGIagtrfiZDOfH3lYzI/vPjkcHjbX9M8D6fU3Oo+ZraViNn4NsJIwWK0RgbkNUgZqMmjt6XdXHunOAqHLvDk2Yfu/H52TPYkBgWmcsDrkHC509knc/Q+g2SDmMdPmqDt6E99+zaCsn4szrLlsvNU+jbQTQHxFYSxjt53fiH40yi+v9fcd0NkldnrglJugi9H4TYkMXe8puhkMGCY9G7tRPpyA5Vrpl3a1tN41OhrppljJPtfVCoa5cmhUESmaXZxkhPlbNLqequO3TKFXqSYJvotYEPGpyewXAsXsZfBzQYLhVJiRP+eMjr0yyhP4Xv3zHC6zA3Cc369So/yfz5+Mycm6cIBjhVzzm2egx7p49zB/tzkCrFpnz3FWshLCvoipq4Z2tm2S4Q02CG6G4p054jsGfZHDtndDoYOeJ+4IrKyq5mpJzxoLQ5k8J9/2XfGoCUbHT/VVuPRzPzcZSuFKjpyzdhwhW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBZOA2ySz3YgGSMT6is0KK1FBlZLrhzseSgZdnAiG6OQDjRhVP8SwFq8/itZ?=
 =?us-ascii?Q?YKFSeQq0K3FW174JoPHAiXPZf+JMH9Qy2yfCT+zPEbNV8WMJa2jIF9Rl8YR0?=
 =?us-ascii?Q?9oXf0sH1bzdCMYbME75jU410uu8nwfOzqQ6WtvBXD8PHJhi0vstdD+5uhDn3?=
 =?us-ascii?Q?v9ZK71nj5tbZJKPZqkySRq7HthLuOrW+qFy92YK/urJUbGgbCuXxFdXj70rY?=
 =?us-ascii?Q?cS7kHLFQJikm53zcIjdVs7w55G1Ygg4m4svhNJ23Fn77RLEksXtsBDuXyWFu?=
 =?us-ascii?Q?OX/zLYeAUYitb1XPU6qKg/EGYqq9oMXfMS4SQyRHsYY3YzKTeUHIYJ7FgXKu?=
 =?us-ascii?Q?VfzIjROXrRAH/cBw/PIO67ZkQDXan+AT7jqbcXCwy+CseTPUvAt5kKSlIjXV?=
 =?us-ascii?Q?cIZxMwDSNa/kixyRR+z7ONwtdVSbUJERmA7A7Abc5S5AH8puKfAOVu+viYB4?=
 =?us-ascii?Q?zWLFznS/FAPpK73Et+eaYumUigVdVzbcwD9iL8hdyCyEF6Lu17JvXiM482VL?=
 =?us-ascii?Q?54N+l/jFEVJZBksGYVAQnDAi6qPP6qQgcUhgL9t9v1Wrs5K/toxYfNAYzPs4?=
 =?us-ascii?Q?ERkKdOFKTNTaQu5hRfiV2DHp6d0QWW2ZqMGFE0rudS+F32LHpqkXot2z7qQL?=
 =?us-ascii?Q?peWqoEZ2LP8vbWe5pKs7LXays9u2k1aDvcTxn3O/7LQ0lNlaImRCShPJrYE8?=
 =?us-ascii?Q?84zl6B9VQODXiIyExYJdz/a6cxJLhugBiamN8O5bboXer24YPeOVupCByjJ0?=
 =?us-ascii?Q?XeB3/jijcfpt6oCOGX5fqgYh13eJrL90SKE7TOFhnzHsMNPFk4vH0789BFzq?=
 =?us-ascii?Q?b6c8+SnBuCD7D8wHyVu30/q7bDXzoJvqiTet6iHz1lffu2AxjssKVB27p3dh?=
 =?us-ascii?Q?+ukfBma/nJXt2k+SQVzvUrjd/h2XSFpfixwZYJyqTbSHXxqO7uxk2CPF0xZj?=
 =?us-ascii?Q?ulQN8kPtLMRXiXo/QS8VAYwN5MGFW67i5QpdZyrHagMQQmwFNb2z8UtEyUMd?=
 =?us-ascii?Q?z14oJowTJJdYqUgHUnxDvQy3i2UVAkFYTDnJpBYsit0qwZS8IEFPxrEy9SG8?=
 =?us-ascii?Q?bXir7iaodJJroQB455a0/DmalCs++ik41Hs7PN5S0dr3HiD7ccZ6J8tdRkG7?=
 =?us-ascii?Q?WOxCFkzWT4u6+1k8a0N8+lsnoOqXSY7Aft/5yhQKgq5yIHEtMQnZ3HUd2jIT?=
 =?us-ascii?Q?7L0jbvEAbkjtt1rLlYwwq1L3X3cIv2PHhCAh80iVDd2/w9aggAIBmjDJsd8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-10f0b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f303f37-cebf-4de0-2cd9-08dc0d2698fc
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:11:00.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7215

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c=0D
index 2abc155dc5cf8..a14f61bab256f 100644=0D
--- a/drivers/net/phy/sfp.c=0D
+++ b/drivers/net/phy/sfp.c=0D
@@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] =3D {=0D
        // 2500MBd NRZ in their EEPROM=0D
        SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),=0D
 =0D
+       // DFP-34X-2C2 GPON ONU supports 2500base-X=0D
+       SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),=0D
+=0D
        SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),=0D
 =0D
        // Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the=0D

