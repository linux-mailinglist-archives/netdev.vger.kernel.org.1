Return-Path: <netdev+bounces-251758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFv4GhxLcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:42:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C815083C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC304E915C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588963A1CEA;
	Wed, 21 Jan 2026 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bo0y3rRJ"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177313559CD;
	Wed, 21 Jan 2026 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966522; cv=fail; b=UsOyJeGeqJNqTEhdx52YPU8D9kVprWIjn34D6d3SHJBhNHXP+NwZ2YHALYH6n7ML7ZdHWuns4IVE3/FTcef7G5WE4d4dHhdE28l1dgpXWBLpHEoUydl8GVTzNK7R1AQRrR7j8Iw/Vx111xunyTJx4t3UPk32AyQgnjTLUk5xgsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966522; c=relaxed/simple;
	bh=nSDtGiwZtiWt4XlsRkXdMs4ugbK+/fSBNdbRTMgQyj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWbf+ca9a1omVjuFBTIbLCqHxQ7JRWzb6Z4Rs9c4w0CIKJbEsHrr9cYrHEdBcpf6H4fkPkfHTX/hnqraIhbOs+aDuuioa9k2V5KYCY7+oE6McD/JofVScW0w/YDMRwLfrDxyff46VWJmcPEPWxSdyoWyXgz9LciHqfaR1c85U1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bo0y3rRJ; arc=fail smtp.client-ip=40.107.130.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylYMtddsxTC/Zp6lkdNmwPMnoLaOv/7eicSsjVvx4j6iCRXVk2Pya/WF3ps+0T0GRKSQwayP5jh86ajMBUkoi+6m6Oht6uo1uO0q5BKtjEa9AeTWfPTZqknaQsVWqg3xnqwOaHZk3BENbW8UBPzmoKaaxVyDdF+rBZeOsvS6GQnUnkxrdByosWXw6isNP89tycpssOejwb8gMBi9eolACQWQgRXYXYOYhrRqO6mmCzbSJpnUfLLl6uoQNfAwseR87Dm1jNK76USGCSeYYtZnkB7ikzw4X7d8W1PhrZBJRnlDTaxiFT0cEQbZ+6z0LdOTVJ6FcgymkC6NLN8TcReeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/WrXf0og4/kfdb4R/Ivl9gmKrUA0yRsBrvVZOc3ZUk=;
 b=WUBt+mBEL1xNKm/deiRErp+dKB5aPfZ4MjtUyl8Y1zQxarCCVQ+PuoH01S97/KnhO5LfSAmPbQarU9AldqSoTv8FZ4Fvob8FVyccQ+lHZjVxJhltkLpDemVhzwnh9ToUfB2IdYn08yWWzaUsGVT609rcF6jZTqJu4SyEFcGa4LPSS8W0iKzmITL8Sx6sZF4sq518jnhY7HLNSfRtv9byusd1YE93IkCRXy4AbrhbE4WhvQ1eKcm9gl513pDbe16cCBn8zuucdB56RTZDENar0kqVHRCORzNicQhbZ8NbCiSfLMs2MAIjabyF+v5wc9W6OZfrLSB3r6BSm48SWUyvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/WrXf0og4/kfdb4R/Ivl9gmKrUA0yRsBrvVZOc3ZUk=;
 b=bo0y3rRJi023OACPN0Ko8mUcsKC3nDySeArVB4D89PfCSwsstraNnSAnleT6T2JiNIuHOjFwo+YNjEvsqOhpxSlmJYSA2iIjQkjs7MzXoRjJ2VkeKSwCazJcVlFqFqvyDUu2PCxMSj8aMv2fsPcqtsK7Dr4IxpXnhZ5yb27N5mEu0B/y6lO1d+nHhZk0Vo/AaoiiGt3fXXfDcASF1DheIvQ+xGuR+8PNVFRi3qtFYujnQp6AOaRoktQCAw9DjoHNg1+mjgS/EEUwW9GfA6eDlmb11fOkewMg4xik5b2TRDLNAZAefGbc22VanL1C++mH5g+AP1IZ187nvjgilgd6jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:35:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:35:15 +0000
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
Subject: [PATCH v3 net-next 12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Wed, 21 Jan 2026 11:33:54 +0800
Message-Id: <20260121033357.3261464-13-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7044177-bfdc-4b10-1568-08de589e1782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZ3f5bRDIovYZmlzhhixNMHdKVl2EYoJ4U88mhGMpNoWbZK6jpxiRGQX6E/x?=
 =?us-ascii?Q?BRbfDo9HRkWaMzMbv0OpuC7Xl9pVgqrvGWeC98OnpBzP3NV6Vpbbtsr9ymZP?=
 =?us-ascii?Q?EIEKHURKu8ZkWXbyZO8T56NZEj+eQbUvzQpdw3qFtLVEYmfUI5Ea2tB3w1r0?=
 =?us-ascii?Q?8yU9oam6Ag6VGIl4khYsFbo2io8rqzjAXqHFFSFV/1S6zpyRROAvxrk7l3R5?=
 =?us-ascii?Q?74lrPTCnMoUnAU6PyQ7FuIB3lRGcTvmYgZe4yO622eoKPVEwOgXKpuUbVSQT?=
 =?us-ascii?Q?YZuyivHJXbcjBuwlmo/F1sH8WyVr6eKk5De05QfOWW53glPXWCIINN5XoiQh?=
 =?us-ascii?Q?U3vnPHVoofvtMBIBmQCDJUKxN8MkOTvH3RbCbtQN9zqv5XaqO9Xhnv/wtd0g?=
 =?us-ascii?Q?9UCzMvcoiujOVb24R0n2Tw4nQ5EjihpZ1gypEoWph796I47Zji9I5I6+7gzt?=
 =?us-ascii?Q?isvsuIBhFeYRzNu5t2wp7d68dkVyjSciRxOUJOxapXcloO64GXRnDA8hOpQn?=
 =?us-ascii?Q?8dM2i2KiEVr3pn8HxgQE2TlL5W5YuYruSeGfJdg5Y2Hqk3Iy15wwTo1moVzW?=
 =?us-ascii?Q?P2Lyal7Un7zlBIjCoc4Efp1A1ZjfQ3Aio5yHu7G60NG8zXY/0YUNzvVY2AW3?=
 =?us-ascii?Q?7Wlhapu4OQZD5r2ZExnFvDPfaLrONDxFfHB6Td8ASAJdkJmGfdBo3uwMQT9A?=
 =?us-ascii?Q?IIMQe0UgfTqZpafLh7elY0+td2hyDU6X/ieid7HnfKew3frwEJMVf9HH1DR1?=
 =?us-ascii?Q?/NLrHlFNC+zimL6o2N+TzhS7iON4UBskQYoS1xo/JFlhtmK99nZC+7ktaxrd?=
 =?us-ascii?Q?ERJDwg2kE3PexNhkOM8GZ1hx+MiHXlcua/kVdMkDZJGr6mVa72gcUNHR53ic?=
 =?us-ascii?Q?NBAl1ERXnZfXPEZnVnm5XTPYWIwfAKhEJW3wJB27oHBloOsqUEoeSm7lTeKC?=
 =?us-ascii?Q?b/wBUUxG6Gya9LwtlAn0YVfx0kzTIq5G+NHifPyozL2WBdXyk30MYJVMRj7T?=
 =?us-ascii?Q?A0LIKI9Q24MbOKES/ApSpaOPUDvsdTQfL1G5m1X+3Pk/iU2bRPeTnjni2MIk?=
 =?us-ascii?Q?Nc6Tp17avAiqvOWAGzSD/G+l92Ks3yvNNE5mY2cyIP237T5KP3mBHF1Yue2S?=
 =?us-ascii?Q?Kv2UItXnKnwQYmgR/v+eML/DWUy9aJsX+OuL4RRZ0kq/gm+v6C2wPEAYXdCo?=
 =?us-ascii?Q?8twQZ9Eml0vIQy/ZhMrnToodY5ygvrQ8sChs/vZY6NoJQ2qnDTCMqf5gALn4?=
 =?us-ascii?Q?C07v0NHHTIIa1KzThs0yKY4MUNBvnaZQcJbNSWvU1pErkBtQ6SF27Qr0c+5a?=
 =?us-ascii?Q?mejhRqdpo59oPY3l06JzacncHaKLnzgR5LoCQXbxUhhJJc3ESBYdyjn1YtGG?=
 =?us-ascii?Q?Ui7THSooJXNXXnBDYEWn9xCNuE2Vq3KG27EATGaYTKAhQhUNEUiLQOafNoLn?=
 =?us-ascii?Q?fDn7mVO+7I4mFSv06Bp0sa4gB4iR9c0AbkjFWC1xgQye0X/R2CUsewE14pyS?=
 =?us-ascii?Q?nfymyRjUedS5pVfwHnQ0GnDL6V+X2tuRp26qxbuVGDLcuuTku3yYmqOWtnuZ?=
 =?us-ascii?Q?3e8ruhztZ2rKc2F6GcP3DjKUmCCHR8+6qA1kDKC/bY6guICKyJgqDsZJM+Eo?=
 =?us-ascii?Q?nFVvWpSKZKylK2P//McIZyhhpgulk6KffwaVeM1cEMFF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0PHCFNsQ26CcuzIZ4ZoXMZKSFH0RwXLp2VcfZeBPj6Bz0JdlUD5o6GjjgKt?=
 =?us-ascii?Q?UuahnsxobmMB2ZqXVAESavBcaK6MjlfAEoPx7FsViiFdsfmMLBVCwDkej0SL?=
 =?us-ascii?Q?rcPJGC+Sq2utunVDLA+4X8Hiwt8BTn6R3VCwbPmwsvMkdlfuzzn/6Lqdles8?=
 =?us-ascii?Q?/fY7OEaMv4NT2wpDCbbBetUktTcDRQK6sK18o1VsflUj0wwNLBkb5UM1XZp7?=
 =?us-ascii?Q?zmFZD5ZsdD6BylcSRhB3X4HEaFubUgJOJ+SggbvG5teh4Ci2GakWIous7P/i?=
 =?us-ascii?Q?7okzwi9DAWPVxwITQh61h7DNRI5qO1HSD2pOu8nQVyIBcSvDRC87qUegygoB?=
 =?us-ascii?Q?vCPVP+7umD8Khl2yJ8++5pjQAFonK3UWlkGrx15DyTMiM/pJB3HCbhVJhifJ?=
 =?us-ascii?Q?/OBHoZGt09IE7FpcAvspzzurahlxxAVY4wQbJFslxDZ4wxS0bt1KzaQNAEgf?=
 =?us-ascii?Q?ur2WCgQfbbvYkmbRIwCiCP8mg1z6sAYt9/mW5YR725EpFM4zFQSNlAiqiOgT?=
 =?us-ascii?Q?3zhq9TxDbiFjYNSV3qEOqWvaQIQq5KN8TCyrTL9XGRQ8hdP8vTgaAyBJcO8S?=
 =?us-ascii?Q?ph6JPFB1mxyiLCcueafe2aEsW7zmScWKhAvj8nsqzh25u6VYXc4JUzcZorA2?=
 =?us-ascii?Q?QwMlSi11zVZcQIfbEasYAHhNhGn8xJjHCb4R8orzzgs8O1oMx/Cso9+xRTV9?=
 =?us-ascii?Q?5vMCqgXLYPCkAz+6R6mzWv2RRZe/BVzMYEeArzf+emukVBW5/M/GDfN1g81e?=
 =?us-ascii?Q?lfVH7wAdI2NIWpgTPIp/PA1/Fpe+dj5BwzAbzwSy04PndLBEjYdB+Lc39Cls?=
 =?us-ascii?Q?ugdSl/be9DVIliCQwVX07ieyef2PrK2w0jSERQQmjj7UQbpojx80qq7BGCdA?=
 =?us-ascii?Q?CQmy6xHuUXK6XZg5Odxt5kFM66sQ4QqKxnwAas+XGovsNbnnRDz2S3pq56J1?=
 =?us-ascii?Q?3vYjmHucs2KTCQ1Ydm2kWI3Sp6tCGY5w2Qgd8mPLEMMUz1BSkimOe4Vm9VX6?=
 =?us-ascii?Q?YqzurqMMlctsas7Za+GJ/PK1qRvauw3Fl06AQdCWbd/pTfWkehhUGVNOEdiJ?=
 =?us-ascii?Q?CRh7Mh5x6hGkdWDAsHZxyk3SeHpdnZdVzVKqIqogB2Fl6QmklOrPM7kgUJmB?=
 =?us-ascii?Q?Pm9BXFCGtgZwWBcDTu+oJ/f8AcjtE9vIPNx2sAjS2czxzecvm2ysUjdCT9ps?=
 =?us-ascii?Q?3wUPcSsVIYfrXzweBRGh9ZqdG1iti8qRSC9Vza17JJIuD2WNwEPP1HeTDEy2?=
 =?us-ascii?Q?l2GeWIBDVotVTn459P/+hxTeujS3d8Yk9Vn0PM37bhQV+fH8P5a0P6hnEZyc?=
 =?us-ascii?Q?zoUXXmDWLJ+axclDiZU+JNZqeRfgT9uNDCfPkWEh48nXlfF67aNm4Vh7K4zn?=
 =?us-ascii?Q?ucN4WKHyg8mLHtm467Pp3S70e/8uNQ+L2jk++yIFMd4kK15kTWLLaOApl4yX?=
 =?us-ascii?Q?MbR9f+H0aQMY0aI0hYM+8DbdPpNp7jwWNJrnq4Ijd1n81rPjKoUxAE8vtzEU?=
 =?us-ascii?Q?ykn0sAAJJuEpwI1WHw2Ybe31+hGbytlrVVFqRclB8AjHw+BzFO+FQb9IwDlz?=
 =?us-ascii?Q?7Ft53oEzU/jEULGbsoEqrDMgM7iI7Zex3T8Q452szvDuBq1w5udcfJS8e3tk?=
 =?us-ascii?Q?01DP1M6+lrSni58T2sZ1lVPil8n7uuvmeJx1VodTCFvBpdW2uyyLh0QDkE52?=
 =?us-ascii?Q?iM+2aiyBMErEYC4h0ded9WGNdBCZAF7rkyI6AM7iQGKebFQU0Lwij704ULmT?=
 =?us-ascii?Q?4b9dMMlt+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7044177-bfdc-4b10-1568-08de589e1782
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:35:15.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUgyaiGDppLlXBQKGTHC266ZNkHL/N+JO4pjQBRxhkDbVkKQXCilIyubq1Hd1HkDb2l7vEtwb1JyIyFbXWhJXA==
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
	TAGGED_FROM(0.00)[bounces-251758-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D2C815083C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 742786a4010f..44a3a6d1ded1 100644
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


