Return-Path: <netdev+bounces-251750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLQyM9pJcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:36:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 402745077F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C43677C2502
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E436B06A;
	Wed, 21 Jan 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYfifkwO"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE5365A0F;
	Wed, 21 Jan 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966481; cv=fail; b=iqlel+BNAGcGQ7V7Z2Sor9M9FZYJBQGouK7vq0FCj/5/fySnyKPdQ3Lb5dfM1GNsklH80dR2YJfpo4nxALHAypwEtrlrm6rrVXxf2py1zX11ii0NYEeNnx8u6U2/Cxu78qAkmClkHIjUlhzL86jmd+jqeylYIMnLdDHTtp/uX1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966481; c=relaxed/simple;
	bh=fCBpTFMXDGCp+w5Gla4zwAqz7Q7C4omwxEXy3xX5jv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ts2HgueNzYhP72XhjBRYpq0ZLuAVuv8hUykOzt8VPnCQ+hDBK+ys83nAU/5zRAQDVcYaXcM0D7Zd4VhZpdiLuLIfz+o/CB8LxabHE9itj+ocniMX192whlpRiXWQOrqRQI4BNQPnzUGIdox3n8xqFIn7cRHkSMXMkTOBner/0G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYfifkwO; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlrD7rTajQQ6tZ8UWX/vRylj+zktj3CauarYV99w5eLbHl733uqsZLI9S5wmSekSrl08rSP+Ns4E6hBkJSdPX832XDhuwY1gax5V0xV/8LWqqUHJikI/j3Z3qnFdbQDkpBW4u0rbCZGIBE9Mhj4ge8ss0XSFCSji+ESxLiSs4j1mtpQRBgVd3Jzc1gjaebACFnOg8/DbyDvJVL/IHTsMAX1vBlN+TjGfgBU0R0/OElirW+Alo7O6wfPfRofzZm3FrgKfrYTTKJJBS1w8v28xROMcmRM/tIXjbcetLfoZMgkMONYdmPU7jxZjE5fradTBO7MYzujiHkNPxQFKHFMZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d9WkCqdg7LMSVp1VUabUHYeMpgZtSC/5qmDRiHfrCo=;
 b=vuvOvev8M5dkrugceLlVYRPzyAMjqV5xyt+pT4RX5wuyOvGuiQXCKRZNZrx2dFmsZlAwFQEcKSHnGhZRI4AyIDRG57/t1SBRKVGZ+TzhSDZjlf+s3nyEADQV6Ejw3ySSQd1gVkQvlIe0gt6vOoRCvKztfkru0U9SyxrRW7h7/d7rWcmdylgnuGLuOIKK5Aeu7H+hWkZMtaD6Ichl81NDYS1w32gxGkkJWq/rZloEv8QxtLDLTKOst99e1prBodPSk1gQyZWkbyOdMW/2ZpWYyZgvU/HomZ1nb8MM0HR/TgQBj868g3Odlac08uw6US8Y1x40BLJuYNO6rE0Z/uc2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d9WkCqdg7LMSVp1VUabUHYeMpgZtSC/5qmDRiHfrCo=;
 b=KYfifkwO7U8kbyvG8dXGiYpBHEDnj8ozsh4rz8eglAzheSJIowQozmgLFz/x/EWsEFZd5X7h/nXdZaGhE06jNEm9RoqPFJN/kzsUFGKxIJatk2K+4CzN+PLjDyMSwxWkqLpszYjoq4SkdNqvqgxD1qKqgvQrvCQKKqDUNqfui8Yve/EFAwDkl8TI8YKu/2mFM51XX5LkV6vQdM6LhlCGwUGOWKtQVeoY6ABTnmfMeUNCRr+jgQtso9uoTgU+hLbPgkq0g1FaielSXIPLWfDnbskV5YlqvkdwBnpmXZkeoAXAZh3crhzeHLZ6vbnrVx+ZEZTk0wY1sTGvSon522GVEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:37 +0000
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
Subject: [PATCH v3 net-next 04/15] net: fec: add fec_build_skb() to build a skb
Date: Wed, 21 Jan 2026 11:33:46 +0800
Message-Id: <20260121033357.3261464-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: a25842a3-3f9a-4263-67b2-08de589e0087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v7B7IUf6KSb9ZTbp+uLsnMvT4+LjJ+NeI7kjDxiGTLZeCn8mcn/xoKLNaAsA?=
 =?us-ascii?Q?AbGyX7qjdUiCIDuawHCaNievwSMcfgLqH9pJb/SdR/f4S2LYbYoQK/TKGtAP?=
 =?us-ascii?Q?ay+mfcNYueS1PM3C/YFOFORuvSRKhPzc01U3SPCXwyEHgyv+MluYNV3oQprf?=
 =?us-ascii?Q?D2vpCWnex+alK4GBEqzxpSLxv0dXDpTAauf58E0Aaiy4PTr62HEvw8HkGOTj?=
 =?us-ascii?Q?FI+3JhneqzHl+eSKQUaJBfMuuE5VoCq10C9KyTMMXOoSxWzJG/Ky2qagZDes?=
 =?us-ascii?Q?ZD/XU6t3OhV/aD5unLK62+0nmy+sj9zIBzXpJSJZ/pO4xhKnmk4mOS44besh?=
 =?us-ascii?Q?zhjnIb5P5R+bEwVUCNdshMCNZrrZf91zQKpgOayaflFqMc/bcKk5bQz1icz4?=
 =?us-ascii?Q?mELqaTbb/nYbBjw9ExhhigsRY1bkqEh/HzUnQvjWA/k8svu5Np4lZuniuL4z?=
 =?us-ascii?Q?szOAHnwn9c8YQof3p8A0rxpUjomssG31WiHEZrJctbTuTjWFr+ZK6bLQd3a7?=
 =?us-ascii?Q?A4zcbmUHbhkaRkQ0KUeyp75V45E5cWwzGeBzmk8wLFL+QFR4vagXU8QQy30P?=
 =?us-ascii?Q?55lUYlcwfLmhOlYW+PUCPUBLChnx27EcW5CXGffaCy4fesT3+n/c4Qo+CjXv?=
 =?us-ascii?Q?ItvP2UWKIAsZwwj8l1Es9R8KadCTjunAy2R1vrqD1XYk3MclYys/k0BIEURf?=
 =?us-ascii?Q?ytyAzAA6Pw7okCS59jBkAPdd7fl9Cm1zErOg5S9ID/uoOf6oIJI+soRC+SIV?=
 =?us-ascii?Q?/L++/Gjy7T1JYclkdYP87JC5hque6Tq1vta+PEmMB9g6Nu2upUmt+W0wilrv?=
 =?us-ascii?Q?AWrn7YGJPIMPoid+vzl7i7PDu8eoenT0yKPC6wbcgxyv9mDOkE3KWQuK0C4X?=
 =?us-ascii?Q?ChL4blUTCundaG/7cqfgJkAchPYMR/O71/IP13ugfoWGz/xQLAEiGdbQ4fcp?=
 =?us-ascii?Q?TNXNLokDSlIx8dLYCj5zoXJ3So37W/ypddnyIssKEEDu3RIPkAq7l0LEUC2M?=
 =?us-ascii?Q?T7GUnwyjzTVAYiMVYvf3rHrX7+WT1glS9vXIUK3XoH0rI1v37Ebr3EjkD3XM?=
 =?us-ascii?Q?4akTfM7NPs3ChBB6wtnAiBxM48upTupzGjcDavFf/7cnSlsT5opkY8BvutyG?=
 =?us-ascii?Q?FKeFmjFVnCUTTRk7fc4OaP2Kxl/MfeEN76pqM5/cNSy4zI+CtZAaIFUmrceA?=
 =?us-ascii?Q?6AsKX2zLeHOFNASg9zQkl4H/U4Zko7yzyrkA+PkhqpzaoAaHj+k403WPDQrv?=
 =?us-ascii?Q?mtTtEXpduMAreG25Tr52EWvCpMvg1unS86rqMVOOTF4QbI1FOAloO/iFtS5I?=
 =?us-ascii?Q?1zEXtzkJbJVMQ5y23A1hqb2QsudiSSRqmidI9xUpChMlePI9OyX7EESXcO9L?=
 =?us-ascii?Q?7e1KBca6XTw2+0zp2oQ47ZVDv7FGZosiCg7Kk6q9fbgfrMcc/nhFRnUIZMnV?=
 =?us-ascii?Q?a9ZdekGhQWWvNLWvbOf8cwFr7GlFuHYQRJq/HJDyZak8myoGiYjTe3hG6yU9?=
 =?us-ascii?Q?MZbesrVLLJCscNkyi4FozMGrx23YHT5t3h7fGi7JT8iKXeSKID7ves5tNTLB?=
 =?us-ascii?Q?fSmqDUgQGeMqId3VvOIlFT/APV88TWrJU90WM9JD9k/odcmQlm6r7Emkrt3x?=
 =?us-ascii?Q?EJSwhRhJb2mxWCoZeK8rF3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uVgCghKkOSwXRI54/ibTYs31scs+nRSx/zXboH798c24UvfI+SI7yXjyCKOJ?=
 =?us-ascii?Q?Lwc8vx5HIDcDIKDtjuhVaEWOIeOUYjcjSZ5SSn7oPWiCabovTHl490Gc62Bg?=
 =?us-ascii?Q?3MD63WNs4CiaEOfGpxN2BMc8t2/ZIdwaUvodGLe4L7NMNgbPe7y94789BJ/G?=
 =?us-ascii?Q?0HqMJrGRijzYsZrO2R4YFP093i47mDNczgpZLmoeyAO9KTZEFpPMsRb5qYjY?=
 =?us-ascii?Q?dNMJrVOSnG6Dy/yE54QgK+5km+fnBHg4lfA9bVDZiCCPDSSSwYhyA/drvl+2?=
 =?us-ascii?Q?5fM6MX+aHB3Rl2Li6mhvbd6xIG8KJkvxwnjmXuy5/mDgzpXHXXgCRp8YQZa1?=
 =?us-ascii?Q?OMa6I8WmxkLs/bjU6jIb0H6w/+ChfHNoQfZ7Ko9N9e7P6dvymkPiOrpKYdoW?=
 =?us-ascii?Q?SPw3Fw6xJVLz/bqHMSBcbxUr9uH1Hx4vzIovJzitE2AlleS7KVKiGzK3y6h7?=
 =?us-ascii?Q?1LWa+1aijv619Fnb6tKbSg9kJ5IaWVT+jwkAR9TV+HXOk7Ew/WZmESdaj7Rz?=
 =?us-ascii?Q?3FIZ2p95ObK072uPgo6e2uf7Pc4+VBXbwnW8wOt5/F9AU6pEjWkrgdG5Sk/m?=
 =?us-ascii?Q?ZtENuk1TSOmCu+W2bGPPPLFZCmHvTjZingch72Fs5T3ahTlYdTDR3dNfN0do?=
 =?us-ascii?Q?HGUFEdn1GR3V6v7vosJUaof/519tMX1MoCxz6sPCvucvssUeOB651e0Ayzov?=
 =?us-ascii?Q?vgY9jtkWaAvagqBIiLDb+t2URa0XbU/4m7uUjizgo78TjzZ1z6XW2kZPdJuq?=
 =?us-ascii?Q?mUTzEdfTNksiDyUdexGSUCNxztvE0k7jBJiBEmawrTHVz/eJcIzKfTsgaOB+?=
 =?us-ascii?Q?IB09qhi5X4H/qoaboB0hs6MeoDfjOBvMYsK8a4G4II4f1UnvoiGDRRANr2Je?=
 =?us-ascii?Q?V/N++r2953XlREAKAzr2QU0z895oNCKUWClCyp75KV3UR23tlrlzX+gO428B?=
 =?us-ascii?Q?qTqtV5BKsfol5k+ID8qeqDdZhzArekvtRb6wY9TKk9CjyAwLOUpWtoX1nTLN?=
 =?us-ascii?Q?Jdd7sKtQWV7pCjw9xNse7sJODR0RbREiwh6A5+brhmvOs5Md1ypN74H4AJcP?=
 =?us-ascii?Q?lXg0PL6jbSjN9PGR91Rli5aHypQukH+4DrBU8hCsRto+eWmNL3tpUPmNTXah?=
 =?us-ascii?Q?bIUqsW9gKZQbuFDnRmorbogbcopNuLcIg18mHH3oU50DgR0xFcBh0N2Sr5qY?=
 =?us-ascii?Q?jbGfpFE5zBe0CGkWDTMKqmUvF+L9tJbEL0qmoUFgVMclxIs/BhNOJGk5IINC?=
 =?us-ascii?Q?JHS6O513w3y1v63d87mrhizm6UQc/e5u9siRCWvgmq2GMXNyiZcr9ENvN415?=
 =?us-ascii?Q?vPbqbseFTuPcG89IgPrb+s7EWgRREOj58XCOKoc+6/s57LTkEoXy5CyVl2mk?=
 =?us-ascii?Q?8p7zcwa8WW1PzSB3JS6tX7Vy2QAih/nSQxhRY316sPOH0r3NLFZXX7qtNeXC?=
 =?us-ascii?Q?p0CcOB9q/WcOM/YDljHCMjhEB2PV7tgfFexu1WdVhzceyCJu4q8o3UjJoTpD?=
 =?us-ascii?Q?kzrfD7QYzVbtKoRh2yM1NRoBSUysLLX+tsHnc1FPLhP9oUtn46UK/lXcMMqM?=
 =?us-ascii?Q?FRSpj5lRTyYGecoDdwemQ8/QkmU9+WrmYPCczcI/fKdOc03Rjr4i4BM8Ihu+?=
 =?us-ascii?Q?Cu7ccIUOJCI6+bWw3EZ85QPx6ukn9QhZR5O644sgYKYpLQkb/VsivvAYJcoQ?=
 =?us-ascii?Q?fks5BmJ5LUTzLGVuQNzRLYZATMHXL6kp7M0gb2fRCJ/70TJeO1J9bkNa4o7E?=
 =?us-ascii?Q?RAixIvrraQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25842a3-3f9a-4263-67b2-08de589e0087
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:37.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHPoFXHLJ0fxAIDxWCKZ+D9R2lmailo5CY8Z+jsPsX3EUrpi9cFj9iZj9ds7p/A92HedZjCE86E1ZqAg9v/WTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251750-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 402745077F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68410cb3ef0a..7e8ac9d2a5ff 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1781,6 +1781,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
 	return 0;
 }
 
+static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
+				     struct fec_enet_priv_rx_q *rxq,
+				     struct bufdesc *bdp,
+				     struct page *page, u32 len)
+{
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc_ex *ebdp;
+	struct sk_buff *skb;
+
+	skb = build_skb(page_address(page),
+			PAGE_SIZE << fep->pagepool_order);
+	if (unlikely(!skb)) {
+		page_pool_recycle_direct(rxq->page_pool, page);
+		ndev->stats.rx_dropped++;
+		if (net_ratelimit())
+			netdev_err(ndev, "build_skb failed\n");
+
+		return NULL;
+	}
+
+	skb_reserve(skb, FEC_ENET_XDP_HEADROOM + fep->rx_shift);
+	skb_put(skb, len);
+	skb_mark_for_recycle(skb);
+
+	/* Get offloads from the enhanced buffer descriptor */
+	if (fep->bufdesc_ex) {
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		if (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))
+			fec_enet_rx_vlan(ndev, skb);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+			if (!(ebdp->cbd_esc &
+			      cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			else
+				skb_checksum_none_assert(skb);
+		}
+	}
+
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_record_rx_queue(skb, rxq->bd.qid);
+
+	return skb;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1796,7 +1849,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1866,24 +1918,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				goto rx_processing_done;
 		}
 
-		/* The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = build_skb(page_address(page),
-				PAGE_SIZE << fep->pagepool_order);
-		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
-			ndev->stats.rx_dropped++;
-
-			netdev_err_once(ndev, "build_skb failed!\n");
-			goto rx_processing_done;
-		}
-
-		skb_reserve(skb, data_start);
-		skb_put(skb, pkt_len - sub_len);
-		skb_mark_for_recycle(skb);
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1891,34 +1925,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			swap_buffer(data, pkt_len);
 		}
 
-		/* Extract the enhanced buffer descriptor */
-		ebdp = NULL;
-		if (fep->bufdesc_ex)
-			ebdp = (struct bufdesc_ex *)bdp;
-
-		/* If this is a VLAN packet remove the VLAN Tag */
-		if (fep->bufdesc_ex &&
-		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN)))
-			fec_enet_rx_vlan(ndev, skb);
-
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		/* Get receive timestamp from the skb */
-		if (fep->hwts_rx_en && fep->bufdesc_ex)
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
-					  skb_hwtstamps(skb));
-
-		if (fep->bufdesc_ex &&
-		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
-			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
-				/* don't check it */
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			} else {
-				skb_checksum_none_assert(skb);
-			}
-		}
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		skb = fec_build_skb(fep, rxq, bdp, page, pkt_len - sub_len);
+		if (!skb)
+			goto rx_processing_done;
 
-		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 
 rx_processing_done:
-- 
2.34.1


