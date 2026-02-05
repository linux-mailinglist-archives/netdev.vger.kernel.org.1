Return-Path: <netdev+bounces-257059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD2QHIpdhGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB49F045F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F08307D4D0
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37E395D9E;
	Thu,  5 Feb 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QYHKbOKN"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5D395D8D;
	Thu,  5 Feb 2026 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281809; cv=fail; b=rn/hNkLoYJCY3VBsvcScAbTwmcb+Y7etuoGSlXOzNuPGWymVZg2rsXJjtdcbNh3RGWbZsBBg8MmTwFAhDVaa/Wp24zHZRiwsWW7O+OXylnMzs09TPvb5zcJrlUZ8AaQ5yK9KfGOijwSQWkIODPpfVQ5htlNsVM/SJIHimD643Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281809; c=relaxed/simple;
	bh=ltsb+Wy6SdhnHsiZX6Upifza4KClFlploeA4WILtpQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRzNxJvCLUFxuYDmiK4OFrstBO6DKkf/6GwPzWncBRUs6Zrb3ZAK0CbXBQoLMP/VTTBACv2aaMyXp/kqaTKPvTOymCC4p26ERl9FSMStsn2S1KB9Jo5hn3oaoGSa10hvFzUdo0fcEqTcwaQ6kPOjuwXritQmsPaeUVsrtsRpmzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QYHKbOKN; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl5z5KI/IA0RCtTKN7EODLmOqwQNp6Imr9eVqVdJNAbzRLwDkqZV7oTT1mTa51UjC+EPFK6KBDTwL9WMDdF+QwhnYfZmtVgNucssxB8Q1BFHAhjVhszezWdBXDpc7hSlhlMa6Tmgi/zUCgsG551RiRvwlHXPPvH4JVbUMNsGAebMXFRAaPDHDbEsvJioq/WSSqpMySCZBcA/O9RsAM2q/OnfZbRtjOTxSTK/bQO9CaIT+tI7sV2AmnIAnGOqBubuxvJdYnYB7amlvJ4MR+zxAvlHZtDfLs/LbKF2jw4vJSdg2ZfyM4BPzBz5N8RpbbEuhoIkAayDSinCqTpfSecoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JhDO+xRPNNf949k3NA1XrwrMKtgPEaWjh5byZmMZQg=;
 b=OFNif0F3oIKYtSROKeYxuil0wU627Cpe+wen7gZUNCogkEGtwTkJCPWxx6YQ/C3Pb9Ig2TPwV67OwNVo7d3waSNa2JEM+uI6z+u8VKt8ACIlM519/SK/BOxh1S98y/XsPaRn+fnK49UE2F+z2xvwc8D1GvDkdbPFUasV+58Ey6HhJeoaluIiZ+geNn23+xs50XLS2/Tw6pEb2ovW1BmH0iBGpdlDvtNbPAkWqYP9/vudNQgFxOZXL9a8E0NBX41msg+sqqUcVZENvw5OXgbB4L1coNozjVuaA2a5OQVXpwk+lET8oTp36lFg6zNKNnq+NG6RHcII6LcZVlrWGRCFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JhDO+xRPNNf949k3NA1XrwrMKtgPEaWjh5byZmMZQg=;
 b=QYHKbOKNF7QrVl6eoVPJp+2V29oEpVEcN1S1cwunJxG6nwAZxWdGx5g3z64o0Z0Qjrw5jzE/vUK4CwnmPiA+m+SBAEb1jd65+n7mXgVCZ7MbxPB425tBM6G1SRluVcyHkX/pR3yNA1ytMnd44Sy3vWkb3ngMfmfQ18kGgEKd40ULOR/aaSmz0Jvw+MYu1OqPPXGraHNk4QjpjvCQl6RYucbA/GqzDN9T4sM90dVgdAT0eQCNmpjGbFss5ekXnFSuVIgXamySHHWK/FYn/cGTXNJHllEtlvQk8baaUxixMWRIt5SqEFJXp6bbp+m5V38NTGbkxwjZifye3z9ToWCJPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:46 +0000
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
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v7 net-next 06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Thu,  5 Feb 2026 16:57:33 +0800
Message-Id: <20260205085742.2685134-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 86118875-7ea1-4da5-d2cd-08de64947da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hvlIWBFCP/D5vkwCTBhapPpOv3bQyvtiJfmW5kXUTG6JE/C86773QVXcAA1?=
 =?us-ascii?Q?uc0fYDVPAEZTclTqhODhiaVwpaVdsWbXAZXDgjRjCGP5F/Kf8CFTQakLUvkc?=
 =?us-ascii?Q?AGIAGSuHfdjuiF83We+uuUy89wk6vI0UHV7PaPNR+/DaAb33f60ljzrIfArH?=
 =?us-ascii?Q?fo6zBi6RSATuewu5dwNeljVhIHuoJZQkdD5lw/uuJRUf9Ta5SsI+NJKaraDW?=
 =?us-ascii?Q?uoaf3Mj+28VTrutsZRlkqUp8nxYBGFz8uvP7yt4z6tzBl+X97RoRAxVq9bj5?=
 =?us-ascii?Q?RfIrgmEYC6vIFRQ8uOGXFnT39/YlR8OJS9coqHtNy8kh43NtX1AKE642c0ba?=
 =?us-ascii?Q?0QtbyRLjsBOARvDBk6hVbEQnB8RTzuwzbvvtkOZ9D4DiaP2cOceHtVXVM92j?=
 =?us-ascii?Q?VCi+LBKa7mPCC6OncwPhsz8nooQ8zssjlQp+iI/HaKKM2JCNtwM0Skok8eCv?=
 =?us-ascii?Q?AhozrfVjluqbQ+1t8ud8QwzMYmQlq9yWvrmXB7U67E3Gn+cG5dcHWdpwsAcN?=
 =?us-ascii?Q?OB+tB23zY3PAyFVlwAZ9CjFTfFoYWt6Yp5N90ouxlOEgYME1YCNpbU0bwj7w?=
 =?us-ascii?Q?0D34Cs5yNLF9rXJM5J3zdcI2juNNLVvIgyhZWxaNu6v1taAKghVA/Kcs/gKP?=
 =?us-ascii?Q?xuRerPszxSeQ3TPtKbIMo6f4kmOSfacMmwE9+4L+6pRHOwtq2gjq81gUai4F?=
 =?us-ascii?Q?ZBidhREASTjK4R5wtOExOFfwUwXnpkornupRcp7WhwgAIQDjPwDcBE8TCu+s?=
 =?us-ascii?Q?1SjsDCo5zOPBA6BFRH7BaSoY95Jx1K+qZaMlclzbALa285BHnTn+U9Bu5SXw?=
 =?us-ascii?Q?VIubl4i4o5YgV2HSKSqOC6xzUaMbqCTuDT+1tjNkEBIlWQyXaHB0EGQzzOry?=
 =?us-ascii?Q?GMC/xNTsxc5Sx1RaeVHkg2i2HBG9fG1Vr1bNLDASMnU/7OLXziSgkNMZ7mlP?=
 =?us-ascii?Q?SuBdjIALbsyotW/MSeI5/aumg/XBzBOFKV7bRzhDZeTu+mHdFU3emmTRglPe?=
 =?us-ascii?Q?S22sdYbgsVHmMj6Vz5/5oq/Xvtq4F0Z9t8xd3SohcHE6StDj6jWsBZeYBbN2?=
 =?us-ascii?Q?I0ho6C2cXE3GZ19uYtxP99enoJDsEMtStuWTWD9ci1CClcWt7VeEqeohnmu+?=
 =?us-ascii?Q?kylmwBiotYWgZOfIxaG4+M/3zdcMXwz9irnZX3+FfDaXyn3miK56/VDjyYmo?=
 =?us-ascii?Q?Hbi8B7Xrn0DCNKSK/JsRLIbdznxZWprX5QsbVdk9AaahBC33kC7zqYb4kfEL?=
 =?us-ascii?Q?H5LB84oyCAGXCy+6KJE7upeA1bYKsdrHun2u91aRVs1mQ/EjrCaLmtmepsR5?=
 =?us-ascii?Q?vSRLvpfbICB/3y4wKlGi2nDZWP2/yKS3apWBz0Gd0DMPqTWnefgayNyuzESX?=
 =?us-ascii?Q?aM3ek7wTW+fffiD4BxjAIsCN8Wque8qjBdrDB/kiwZ7Q7egCdE9ijtL3CzCd?=
 =?us-ascii?Q?zEk4hAZ794prymjhVte0fdt3vvjrfBdL6NCcyeohbu/lnkGF7KW59DcCMPHw?=
 =?us-ascii?Q?8wt8c/rEhWrcb4/A1YsseFVMWf23wybsHgcVb0J5qzdpNFd2cqiCK2hfWPJO?=
 =?us-ascii?Q?PatOdD1Oxug92X2Qy1yiz3El9z2pPjaweWVeLBIUECSB8j7qp2+yD84mmbA/?=
 =?us-ascii?Q?i/vuX/2ySAElj3AB+cuxFBfLP/0fszfYO0UWcdd5Rr7N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gsKDKPfOsfqnZBBX7zcleEF4CX05VrEEnMlPm+WJ5wOvQT4ZKuLl6zQB5LZc?=
 =?us-ascii?Q?EtKJGbo1Oi4T6FY7AMwdmOxDIs6IVJfwsWETG8A1ZjP6aHHsaoKBReRVzeli?=
 =?us-ascii?Q?UTr7zqUJhbBlwImyEwGCPyCS9uYPrTbHrO9QtodHLrePpYmocjCpLempULGw?=
 =?us-ascii?Q?J9KtVMlfDKslUL7N9bkRrPsFDOc8Gah6Fyjyn6B6D9z4MfgP5cxUAs3df4tP?=
 =?us-ascii?Q?RFLdEsVsicg7ey5M7Lu7xie5iIf0Ualx09lvEahagB1E1fOo1l664c0QbDWJ?=
 =?us-ascii?Q?SoXjnTP8w84yUAWqTgVMs7oTSBKpjgt5wWb3RPCvrOTl/7yIqryKSjvxIQP3?=
 =?us-ascii?Q?ze+eFNKfMvcFktqGt5YUTNaNvWlNtsWl2jqQ+z9wHJf1v0KnJqhuni8sSIL2?=
 =?us-ascii?Q?KYc+BNaU8qmSw5KottTzTedTBigaGdeexEK6qfCPrPaB6Sjvtsa39eAzRH5T?=
 =?us-ascii?Q?r+mhY+c96XjeDejViT77WSeaNXwITe1MDKCIdftX/ksWtAHfGLA8c03fZBl/?=
 =?us-ascii?Q?QOmQx3YGVzGIaBlt9Vz75obOwirX+0caP4pv16QBVTAugwyl/dkA+j42s6OW?=
 =?us-ascii?Q?Fspd0F5AiQ/Ku0cwX508q0k3AeMGohT7tHsKbhKntIvsNI96bn2Y+qeSvNsE?=
 =?us-ascii?Q?II06vMhrFTxvKBfVvBZPW2K3WlzQq63y14fi2Rd9tstoDcJKPKn1sIkDB1fD?=
 =?us-ascii?Q?AC0RS6ozHPbDtof1Q+mWJAe2RZpIv41QLXNqIW0fpoRdXLMs2u4ffLuyHJBL?=
 =?us-ascii?Q?eyZ6LE429lwQJbbv2IngFMJqpi+hWDrJTSPvHyJzZr6Wj4DJRZC+K/a0x2Nr?=
 =?us-ascii?Q?xiqEECjqckaJFqChDmT2vbBRC8e+ER6rLNhTPFrUIr0BTbT181aNBoE54+s8?=
 =?us-ascii?Q?P0kX2gB4zvtAS63dwXYUz438JbHkhlk5YBdTFie6LcoRM1rKrr0dhF2Rx7pd?=
 =?us-ascii?Q?xjbgdr/b2kLsL3VJMNPBIrlAnjo2rhMmuszH1f9b0tIWLrb7NFROV4uFNR7J?=
 =?us-ascii?Q?BPULfUlt5vPDZ8N0GaiqKGluM2AnNBMZ04L2qLRTpdHnCtvCVEPY+7MVXiK/?=
 =?us-ascii?Q?tek4LXMMdv2P670nOTGzBn1Fp9A5Sf0+CH/UpgSDEduMdGGxWr8sIlo+6woR?=
 =?us-ascii?Q?toTS+p5RkanCQ44O+z4pwSsC06565iaQVmPXhzZ/QqGanIrqivtZM8mG/J0K?=
 =?us-ascii?Q?NtPOEl5duWcRsMw2rubxz6v7SO9I2xRzY44iVyP3zpPsNu7FFgl37aaurwB5?=
 =?us-ascii?Q?bKe15Ei17BTRhbNyLq3i0q/Qcc/JXhL8AIQ5riAemh2pHtH6YFWf/79T/5En?=
 =?us-ascii?Q?DWwAZnU9DK+Op+FzvgwZgSNPpSHZxZf7NmtsHmNJTNzfIB9YPD4cNpIH6ElQ?=
 =?us-ascii?Q?J6JXfgp66ACzw8VHgQx3cEyxkjpA4nsfmpIJXz8ry6PzDPUNc3d1d7lADkRx?=
 =?us-ascii?Q?CKBHQj09GycLAr7cNH1fOc8dCaP54gcLK5wdR5Z6pNf+Sh0j7W6G1ONkfc0J?=
 =?us-ascii?Q?vx6dRBEPUAVHQ1QsoT0HHO1xoOOUmC0ZYvMOursNOaTGdlnA/JkwK/5R+dvH?=
 =?us-ascii?Q?XgXRkPjx9Ta6WmsY4vVSqHHJJAr/p7en1DDFWncxZrszvvj1CAfUMRh52sNm?=
 =?us-ascii?Q?rSlXfQJtJKxcQruO1kv0BleCdgBdxInTXbSv/XFuaMivMUDBSltAzfXiHioa?=
 =?us-ascii?Q?pHRnAM7GsPyGP1Bvx22YbgfqYAP/zhTGDVZMfZ85WrmfOH9p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86118875-7ea1-4da5-d2cd-08de64947da0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:46.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpnDPbL/UEQ42K2vbxqDik4iiMp9J2HOLHh1foHGd7Siy/odS9O1r/1WEKY1NsE1onjX7GONrKcfwNHFvj92Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257059-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EAB49F045F
X-Rspamd-Action: no action

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. Such as the kernel path does not need to call
xdp_init_buff(), XDP path does not support swap_buffer(), because
fec_enet_bpf() returns "-EOPNOTSUPP" for those platforms which need
swap_buffer()), and so on. This prevents XDP from achieving its maximum
performance. Therefore, XDP path packets processing has been separated
from fec_enet_rx_queue() by adding the fec_enet_rx_queue_xdp() function
to optimize XDP path logic and improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After the patch is applied:
xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 256 ++++++++++++++--------
 1 file changed, 170 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7bc2eac01e6e..75971b39fc44 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1666,71 +1666,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1843,19 +1778,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
 static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			     u16 queue, int budget)
 {
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	struct net_device *ndev = fep->netdev;
 	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
 	int pkt_received = 0;
 	u16 status, pkt_len;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	struct page *page;
 	dma_addr_t dma;
 	int index;
@@ -1871,8 +1801,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
@@ -1903,17 +1831,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1962,7 +1879,168 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	}
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb)
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			else
+				napi_gro_receive(&fep->napi, skb);
+
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(ndev, prog, act);
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1971,11 +2049,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(fep, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
-- 
2.34.1


