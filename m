Return-Path: <netdev+bounces-252610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBW6KXzdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:31:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 310C46FA3D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DFCF303911A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE138B7BA;
	Fri, 23 Jan 2026 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LjuLfUWf"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559A3815CE;
	Fri, 23 Jan 2026 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135071; cv=fail; b=AYLwAOZpOltiNGnFBTn+tuv25y5orpYvsNPh5Z3kD/R5i0P1lLBg9UIPZ9u2JnVjVSfA5MxxqgOTMe7/1gYCtjpq6Gbqd4ysJ/DnB2m0ho27YMwe+GVplArJQfq5QDwBKD257m8/YYID6TBIvQe/tEsdWddYWspj3St5286heN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135071; c=relaxed/simple;
	bh=XToXUv6+7fRNWVsxauLxdB+/pSrRn9eJw1kMrpSyDBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nt2ok8sScyRiSOvGGQItqemtwAakjdqcM4oC1WublMrhuYMB2hUExKmgEfFOS9baukC+HO9YgDNMEgqC6a9K9N5/1rya50eeTPknZj51bsRuMbiCjneHt5sAoRQ07Itvd/XYSEJISagn+NDmjE/sluO9hu7Ci/S09Yzq+0Ly1dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LjuLfUWf; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn6u1bfDlgVPfBBzOmHwQW1Og7VXHQfm8jVo9Ggd43hMgOYuLzP6qGm8Kr/Sdnoq4ZNMUnXdABJsuccQ8p2yhzx10XlpgQ22qq1sBSgRz9KWjxw9IqJ5WZ6KwGCtCubZ3cav5QzmL0/h4hEJCjvVy/sD16vE5+dyMOhLIEIteUrHKpEkf+A/jw079SrGH6OvAJCcPHuwr5Zdh9OQHjcEDdh4IJ4F6VAV3ZjV6zNjwaVyFrd6lKTW5CNgQ7NU6Hko4FRSbmFm+caedij26FQZT1z8QvvBfQEi5kgHmQBw/t3GNy4FXNUVbtHvAoSmy3pVPdIiiP5df6EF9E+RdnvT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pem+p0+oliZmpq7NgnSirf9vUCptK54CY7bOxy1cRo=;
 b=s5jfWuPAjfDXn/E+78142TuimGI7ZPnvni+6/zZ6mMYl5MehUy+CtXq/goq2Jjyg4x2IQcjHsII01HCIfuXcV8nwTPS/XITDBal/ohqlDM4dprYrpVy+eDgZtcpKNVZFiEakEu/xKWSbWI11VVOXLZoGqXjKhD6UiPZEBT+6zaesK2qu5IVKfigywaISYyxEpFyuyvgitCIGTT8+U7LbOpibwmMwWsmOqnUkiBvqTGTin1QkF989E0CN3sGeGj+naCMAztHKxeAtP1ek6ckeUen4I8ZlaXHzeln172wzkrvXFvQXoAMulIe8YlB5OID+31oNxfXdFyML41Gz5IhZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pem+p0+oliZmpq7NgnSirf9vUCptK54CY7bOxy1cRo=;
 b=LjuLfUWfXEAKV4WgRE/ptSLcebv5vKBNnLVwcKP8b9R4/yCauEpWk4Jl8Ist0Bkdus0eS1fLSvS/QCyl9N/5Chn8msPloWX9cDhfwRoShIaYcb/WrfLFEvu7kTRygF6bpd+N1DeBQVzCpNoddaABMHFemV3k2hWUy5g3xthpoS3F1oOks5ewnyYhJ+zFhQWAxc56lDNNCpq0/C10ZHqAZ6HLKM651qHsJnamwg98ESbbDZODn8Imvg2AIGOGPC4MTNalFujuMv3OMrlI+f6qj18AdoBOZZyC6PJYEhkdV+CyfxErRkVzTn00SATE8lPzr+yl1OyUY/1aAJT8TdYMgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Fri, 23 Jan 2026 10:21:40 +0800
Message-Id: <20260123022143.4121797-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c30f51-ff3b-4dba-0c87-08de5a265393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUasEhUN9VriPiZ3rLBdjM7ClGdv+GoL/x6ZgYvcyqADzpwPxQ33wWffwtJj?=
 =?us-ascii?Q?TpqNO9olXph0p3Ps6+zkMHtbpKMdmQ3zegxtyq1PxFRTH4JZQFmIN4DNuzVW?=
 =?us-ascii?Q?07P1C2f+4/fzGsP7EIQcq2I3XjVX1mIwy7Orb7pxw+Q7e7cZRBrOjfwvqiUI?=
 =?us-ascii?Q?uonaes0ukaMlHhEVsfAzdY2Qp9xVEc9/HG2WJ1PcPhk/cunD1s61yCD9Xq3u?=
 =?us-ascii?Q?/PVTE7s1IbL/zIOq/7CfF3spFrvl4fNugvtdoSfXlXn6IJLkGd7Bd5dDUHwJ?=
 =?us-ascii?Q?mCHE1gdZhYrogvGrUbiAAIVNZhU3R4agxD8oybp4NXsuVOlXmFArj3VZyo7N?=
 =?us-ascii?Q?BYwdCjNwFXXR35q1SMmH16PT1Ws9i7zbl4LECbPr+nUqhuXbAx6t0uQstFHm?=
 =?us-ascii?Q?d2iOVO+fa+aR/wqDPspOqexwsCGfRxgmxprsvpHdyLIAlFqZFUOaHl8vwvKX?=
 =?us-ascii?Q?QVWh/dHdm2O9mO018jDfRrmMXXyXZycgqr98Fa6RnmpGk+FvQwZeV0Ltbi0S?=
 =?us-ascii?Q?iziamDj2nS1zlAN7yIjNxu2DfJjVNT3MAhnYDUbOvO/oIy3zslRim8Re1q1e?=
 =?us-ascii?Q?lkaMP/AN6eOjwDz1Y4oJkAf2jtv0HRWn1cuiqCtwpMULbEsTS5Sh9sXww9qA?=
 =?us-ascii?Q?IYLbLWm56lkYqpWiqw++eGXqH7pjOf1qOCOf3fmYLPBaYe1D51dClCOYADHq?=
 =?us-ascii?Q?b5wL5ZFVEtSqWMNrEC9QCvLfxuD+7fDoU33nVdaUMd3wzRPYO/FP8dSKkRC4?=
 =?us-ascii?Q?DkYqyQDddh3fb+3i62rGeYd87JEhaDRVnkJoavp0D2pK9eaKnip8kYmvRd3+?=
 =?us-ascii?Q?JxqlbWkMuQC5LI4BK+bDVWYqiyn9+hWYc9n6NDA5zBMlKkmA2S/qsrFfpqNx?=
 =?us-ascii?Q?iMlOf2iykBrs0lso7o4vp8Ick0l6sry7fMoudZwfAltcePDOBq9avvMkldVp?=
 =?us-ascii?Q?28qYvBWrfCdnWMgilFeGKux9xQMHKXmKV7/7WCzQJFCe8nLg8/TvNe9oldbj?=
 =?us-ascii?Q?s8SLouqduVXkfz+5MrzEirMZQEw2cxn3IDSuKIGhO2TlT2/nx81H2XSNDK8n?=
 =?us-ascii?Q?45IUOJf47kc7FxQoM9U4pOFZZdKbiTQdJTyZf48Pgm9+LV9jYid68D9dIzB0?=
 =?us-ascii?Q?L+HFxn48ZB4Ns6klue+ekrM23JS83nJy6g9NmFrdVB0a/Rlnw+IIKA6il5g3?=
 =?us-ascii?Q?ae07pELYjYp7oAoqbklS04eKeG0Q+7X9h2jan/OD2BW8JuaUSOZ43XKFsZlA?=
 =?us-ascii?Q?9oZFwN3TETsPpG6FRpXP3+tS9vllws5DgfY9lJeGuykc1QnLa207IOP4r3JU?=
 =?us-ascii?Q?AHjPFN5QZSEwJycZQwLzBOj46QPyI5BJXsnx9F6m6nZMxK1OIv2l4YBZwPHo?=
 =?us-ascii?Q?3uybNW1VQU1AxAGoDdS3R2xWMWpKVz1H2gdFx7r/KXV0xcwF1P3DZguSdzgH?=
 =?us-ascii?Q?INxt1FcZ0cUEEGpwG6GWgIjJalpZZMUEf0jNJ+spOyCyds1bhfebvMUtUKxu?=
 =?us-ascii?Q?hUafWN4SDNU6OMMy88SYfEk1yrqB55gx3O1nx3deWmHJLDVNE9kQlSFHAwjc?=
 =?us-ascii?Q?UgRSxxNyDiZEmQyiM0nK9VcZdNbKzMUlcIbReRabzeHzhfRiGkyaeWLqpGAy?=
 =?us-ascii?Q?ys6SSYyCXg4J2UbEw0ZdjiqUQso1rrFVZG1BKQ8uQDRA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OuSRzP2Ckyr+4wv8u9jhOh9q+3Jr1Ec0v/CxkgfDFh3E3ZwDY81l5o5+s+FW?=
 =?us-ascii?Q?XydOZ9d+wWE6PmYRDrioCeGM/ZLDc9q2Qapgjr0s7KNIcCN1bakmjt6AJp60?=
 =?us-ascii?Q?SYQUgAx7yq1+s8RjGFIoxIeboRmK1TP/ENUWtuwe5xoitqOCv7+Ps1d8nG/j?=
 =?us-ascii?Q?9w5BzmNPEm92JBYBF8bnuPZuI0FlrjEDbLx0KSKZFBzErh96kG4Q72Llx+tZ?=
 =?us-ascii?Q?9ieGzufDhJC7wNIU3vtDP1sSCYnsYjQ6EOX1LGY7A5fryooeLZlxpFPKcZSn?=
 =?us-ascii?Q?CSKt44cGWR4TccgA3AcDsfkhuPt5zycbwIEnlzDf+4HHjaxprSc3npTvV8Wp?=
 =?us-ascii?Q?oKzOQSceqWPaKo+q390UBfRsZU5N1xAh87x4jGv8OVEmhJvMbo/uexaNi0sR?=
 =?us-ascii?Q?7sUa7qVrlKhXy+OyjwxR8KRB0gYBFvjl+KdZX5vxywunPW11itQ8sD70ZMbv?=
 =?us-ascii?Q?7FutUqh7NApBlEUH4pbEijOW0+n4ijwBu++6J8EYRB6r5bXakyQUtQx2/z35?=
 =?us-ascii?Q?vF9mhAGtNZtuRfqDfBRrmXL75B7A2e5K7ar4zDXPYwMxcqZeXseGD7ibzz/Y?=
 =?us-ascii?Q?jQttD3z+aG02UL/htDWjSCn1wZureoQRlx4bbWtcg/EuNmxzW2dnBKt9sXav?=
 =?us-ascii?Q?MTdPkcrxIxnxFNOtfZZCNa3EKl4bzD5jRGt3vy+EfoAP0ORlOvHhF39FID3y?=
 =?us-ascii?Q?V0LzRg28krZ8xrJgkG2uTuWmrSOVFKZjkcDofF+CgYNp2B2TEkc+48TM2GY1?=
 =?us-ascii?Q?kWp9ZPklMGC474lm1G8l8fu3bg+h+1PksLv1xn1slkCAK8wBErFfTKlDURJw?=
 =?us-ascii?Q?M1N+8JVlc+4oQAUayytbu76rW/IuazS2xmlz4N2Ab0C3C6ds1SWsAqq2Gy5K?=
 =?us-ascii?Q?po5sliMNHOopem0U7RafXXg1Ncypc170l/BjN/tDxds+/QqjufO/zKjXAKLE?=
 =?us-ascii?Q?GQNeyRWJ8y1r+2FHbk3rc95qJ4wz1maCFwVcOhV+9vjzZ9m+DRJYlb8s62nt?=
 =?us-ascii?Q?JRWglxpXJb95YvS2XDjRqcTG/IwpmRs7xqk7z0ngwVImoGT/qp53YVh8cggn?=
 =?us-ascii?Q?xfVDocWbwDmSh+Bj0JSKzRzmihP5rJJpFxV7bRkhHlhzgpgLI7Faz6VGG28V?=
 =?us-ascii?Q?8uiyTPTlZi2lSAmGZd1026dCi5EtJUBFdCPyJtJUP8AftzcrZBapHMnXYOBf?=
 =?us-ascii?Q?yYCdHUd8tp/WX524K5m1pZNm46NsUl022NUTYIVW0CJ5372gBbDFcLiJcE8w?=
 =?us-ascii?Q?yydXJMlD/LnEU1nrSJFaOgnO8EFIRslFdtBCYJe+XDsLLgf060fjmPU16NT8?=
 =?us-ascii?Q?M54g7klQp1esqaulzP1YLw6s9curm8r/n/rN8YRNURirid3lCxtzGYoyjfoc?=
 =?us-ascii?Q?dryQKqDUk7P5KVuDCCp0VMReygieekzOUZTRlF47luRhzXaqnmJzA8Ds1bJp?=
 =?us-ascii?Q?HSc/4g6b5NrWhHSJDoJRds/oOHRHr47he1mS1SLj03ShghV6x97HG/PFOVJx?=
 =?us-ascii?Q?xkXnVHkISFrNG/FzFJuJbbv8DrbUhHPWRRGIagU4NiL9fNYfAvdcUYy5fMK1?=
 =?us-ascii?Q?hb5QV695frSnSXfe6T37oHR1Hy03duR/HzwJirZDYoDGaBJW/cgwIyyNJeCC?=
 =?us-ascii?Q?XAKB6OzKGonwCCs8c4sUpILaBWpAjUvuuZ2zgfr2AN3VdUd7ondfQyGfVllZ?=
 =?us-ascii?Q?cB/MkPKz6AZ1T6W+TP/rWu7Jm7YMtw/f0L9qin8c4n7LhmDaElHyKhVFAYTg?=
 =?us-ascii?Q?SazHZgophw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c30f51-ff3b-4dba-0c87-08de5a265393
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:59.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTu60CDQfKG4bbXYXmsYu8wHtNKWEff2PrrSlwP+3q7iAdgjxBaWN+pm5GcTLY1QQCmwCxOI5dDMjLlr8r8lQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252610-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 310C46FA3D
X-Rspamd-Action: no action

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 4f230767dcfb..c5ba532e00a8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
-	if (err < 0)
-		goto err_free_pp;
-
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
-	if (err)
-		goto err_unregister_rxq;
-
 	return 0;
-
-err_unregister_rxq:
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
-err_free_pp:
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
-	return err;
 }
 
 static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
@@ -3419,6 +3403,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.self_test		= net_selftest,
 };
 
+static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
+				struct fec_enet_priv_rx_q *rxq)
+{
+	struct net_device *ndev = fep->netdev;
+	int err;
+
+	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
+	if (err) {
+		netdev_err(ndev, "Failed to register xdp rxq info\n");
+		return err;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 rxq->page_pool);
+	if (err) {
+		netdev_err(ndev, "Failed to register XDP mem model\n");
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
+{
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+	}
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3430,6 +3446,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
+
+		fec_xdp_rxq_info_unreg(rxq);
+
 		for (i = 0; i < rxq->bd.ring_size; i++)
 			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
 						false);
@@ -3437,8 +3456,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
 
-		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
-			xdp_rxq_info_unreg(&rxq->xdp_rxq);
 		page_pool_destroy(rxq->page_pool);
 		rxq->page_pool = NULL;
 	}
@@ -3593,6 +3610,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err)
+		goto err_alloc;
+
 	return 0;
 
  err_alloc:
-- 
2.34.1


