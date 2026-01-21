Return-Path: <netdev+bounces-251760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOI9AmxLcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:43:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E984750860
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E99C65A5543
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C93A7F7C;
	Wed, 21 Jan 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhDiGNJv"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502F3A35BE;
	Wed, 21 Jan 2026 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966530; cv=fail; b=RltIBIvvXxgF8XlHYHOBGGxXmRyZH3Jj73Uu4C7rppKi8ZPdaI+8xs0sK+ua00AvQ5daLyeD/gVJ+Y6h3iBUhpJ1eAjw1bQvxqE+bpnk7ennUAK3kKKASNfR9JmgihlROkgWEfkd2ngYxhyvIMmZHzE1/0uOmuC9GiitaY2q15o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966530; c=relaxed/simple;
	bh=oN4Dg+Z4uMjKu7Gs9gsqHfqQNJX1fpUves+0UsBFN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPVLKGzJ7asqCbE9fbOXeZjKEv35u6DIdEBKEYgw3tJeToBAe/VV3twwYYTNG6zd5aF8ij3f8NgCw5Ej+AZubDKulCk5X2FN9lPGzO7lHnNcdlRHq37XNevTBKjh2WnFCJ6uDo2twI0YkemSnBdftRaLLL7RJcODz3zQJaA+Yt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YhDiGNJv; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz+n0glwb8qOPH9DmMr6qS7f3qfFGEA0UK+nQQkuBPrMYiwmuR5xQ61aQteFrwkQBs4CAWJDhL3j3+D/j8D86UFGzBzSTcuFMuAt30Wm/z3ibltCaD/44rxAvKU/xup79u4BOSO7md56RLrEw1gKxDz3BMY9o7LX/WTUfGVdzu8op8TBNdA0SdmYsnRlTYXpKjbfpXKNEYN71GimY9vMiGGhey4b54trXC6YLwBhtjMt9bVSyqI5HTbHNr6cFo0Pwbo9CMEvfcHX/bU0NEnv1f17RUE1GttylqpqWyaFPTk7tXQikRTpj4cb7V07HAOwZ/HvcguosGGbL9PsY6K+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYutWB6rCmVLrHyxzEkkt1lXak6kaJvWoiifqg0cdQ4=;
 b=m/u7YXOSLBnxVUdT7e+9QYjtt5+UmbpUD+CZymLqspQ35Lrh9wUo7yH4FrS+vA+XE6yP+UIoJHSsJicF1F/tjZwFdJf06BVrujmFGbO5LhnEvsdfyzjgnOvAJepsiixrWCi0/kaHvkcAHj0UWoLuSLkAOCzXXOLZDM4zma9jqpBVMz4L8ITSNAypb3H35eT+1h1QAlG9qiKIlyIqZA+W59U8KdnJOl9wnNLNbvAIlaBxNEPkE2sqCrvsd7Ifr610wFAXzY6xwfGQRq7JcQjpEp0HkwYkyQdchgJ43sxpfYQskOUB1AY7hTGUPERdzC0TdwuAL4wUoAzo+X6uuPLATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYutWB6rCmVLrHyxzEkkt1lXak6kaJvWoiifqg0cdQ4=;
 b=YhDiGNJv1nV0eTkwPxlvQK42i9XJMmjWfv4y6EjUQcYndayYjtfI3eUAlnmTuLGRZhsYODfvG+iQ30L460fPFBQatu8m/8ElzJpmYTdf7lDzUUNi7b6NGP+Y19vrIlOsMOz0O86uLSNpqqUucyCjEwtUEWZ0jzbT7Znx5cpVdZThuPRQBmD8ZjIoFKCWfl3tjDbKXLsFPBxcQNjimB/79XljhFXhO3MF6/jIaeJLNGm3WRVXa+g6tjhRd+hQAQRgaww1JaHj/jM3N9VSjOhrcEapwpus5bOVwRzbze6FSPzZBnA507SKbBhH9mpIbzdsIMQgGVkIMNPK++wjXRfVlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:35:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:35:25 +0000
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
Subject: [PATCH v3 net-next 14/15] net: fec: improve fec_enet_tx_queue()
Date: Wed, 21 Jan 2026 11:33:56 +0800
Message-Id: <20260121033357.3261464-15-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e03f9c84-2b25-484f-b4d1-08de589e1d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s5TySa2SdyzrBju74EeCyPSobUToiHKxmDT3m4QsS9I1dq62zsw6djfzOn4T?=
 =?us-ascii?Q?ik2/AK5uCHXSOA7hno/PvqCjQKthn2T2v2ofexFxHTJw4erfhsZqqAazoJwk?=
 =?us-ascii?Q?ECikJPy0UuHIFNy8JqNp9Ex56U1Jefb0iT5rkhQ0oOtDvkBKpstnP0JkpAIp?=
 =?us-ascii?Q?0IdwOGLkFJwOhbZStW3EKbmUA/11/K5cuwrZOOpmMdQwIaNKjp1Ni3SSLgRV?=
 =?us-ascii?Q?+4UffdUeLAMgJbwjHJHZ/jzGzaw3fscOcX4nz8blE93H5e/2XFUZW/J2EvAy?=
 =?us-ascii?Q?CrkKEWSMmfNeEPa3H3Hx55lEPGGB2mePXcexC7XivJZxmDBGPBy7zseiZvHt?=
 =?us-ascii?Q?JSwBZEvtAaZ+rHLWpPiglHsoZRSQuZZziGFO1bR40JG80dqEU/x2N1IjQURl?=
 =?us-ascii?Q?MHnNF6KlgG1Ywr1udcjzrScYC57dQRamJxjgYyDBGQ/XhxoKVdLlCYaE8aUb?=
 =?us-ascii?Q?7LAb9Cl7+pM58Xf1k70MvG0mzkaQFfcpc3DnMqM+/ECDM8M0xQp+Yw4LlK/u?=
 =?us-ascii?Q?3eZXBEWZDvCJKI+bCQmvORv0h9k+0rGyoSMi9FatSEszn9eAvutH6X9VgPJ7?=
 =?us-ascii?Q?3pULuazJD8evAF3x/y+r/iy/jtZs79gycUlVu51o+8nthapAUueEfdkBB47v?=
 =?us-ascii?Q?0BAR0SUymMZr3FJYRmGJ0aubTtsu+wS+Zt2JAW465pInqFDz2v90HbsmUXNd?=
 =?us-ascii?Q?4wBm+BzvYHEJkO0W6R6NGpKC+UCRYc0T+eUlmh0Zt4gn5njJM+N/ejzr0Yl2?=
 =?us-ascii?Q?cOqqkKDJW34aM8OahjXS3v3NspdShtHTUOf9qbpehLkQSpQshSxoBTO4dHFj?=
 =?us-ascii?Q?yxzCfpd4K14WmUjjXXCD0w0/IF43DaCLB5/fLzhQBXHhCvIMMkgA6oEWT9qY?=
 =?us-ascii?Q?1vjfn8XnGQzmjUqWO1QTRuU2QSvy7zBXoZ7I9UzZTgwTu/uzG1QrGuP19WW4?=
 =?us-ascii?Q?EkAL2dXxhIkJeGMpxMZMjD0oA9pbyFSuOLMxGBdXkPrGM7fE9YKq0z25T2QV?=
 =?us-ascii?Q?eNXHNqMRJYJv9TfyYCPddZ/8dUEXQdZ+fFujvcKmqfvgpjWWomkuogYXUN/l?=
 =?us-ascii?Q?9is+XmPgggzsgySrIsRwhxeylVaajv6S1bSM2hSHS9km6ch+dQuaSa66cDRp?=
 =?us-ascii?Q?LEms2s1uXY4zlvfI9WTJJ5fUiLIeUMJjFMF75V17LvIgW+ELneZVspP3uLi9?=
 =?us-ascii?Q?RGhR0otUBYgcNAT18DdqCKLO/kLZQcIu+ean8ICB6VTkUV3rHnerYW4BEmZg?=
 =?us-ascii?Q?YeQwqQdRI5DcInWl3W0PHQjwJa1I4RmitO2Q3N17q8lH02e/SrnT+69Fb3a2?=
 =?us-ascii?Q?GT92GGuFVqRiW+fMl1nJouDJhKj1EdaGa1sduhgbDPMf7Rs99NBlai9mR6XY?=
 =?us-ascii?Q?GxNlkc8OHYKFfZEMfvEMbMLyI7+xN8ZpM68bVtnO3TYDjS5f5psXnuYes6xG?=
 =?us-ascii?Q?/GlsG577N2rmgdqIVb84gWTx6NiabSk8asBvVslFZskv4m3lC6D/2qdcnm4c?=
 =?us-ascii?Q?5Jr7tfO7cBprVL0PS2rhnb7NyamoRny/uDa+OANmuz4WgtRFKxCgL9RSjTiF?=
 =?us-ascii?Q?ormTqWOJS/D7wLw9ZeU/0t1BpizAn/IP6gFNWNkSvbgnDmr3voW7LTjMPUmn?=
 =?us-ascii?Q?R/HYbd8g71Bn0QCcByPCNfjv8rV05UI74A471ijGcH35?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cxajG7K2Qwv5kBitkXpPPJN9Z/kXWcazcjEs6vWX4O5/KMOI+iDecBT2+BkD?=
 =?us-ascii?Q?8tmE9FcddNii1ntD/Nx6k91q2OCR9hmFlJxrgSJLbVMuKZBLywhVq361Y4SM?=
 =?us-ascii?Q?kG8H8htVCiMWMXx/dbYIwlUkeBo3J89LcWvANqIVH24CtynNElG8BYtm5OCV?=
 =?us-ascii?Q?mXBsspMwTyjbqfSiuaRB5OaPcGudSQwCMM1NnqIKxLbvj07iW1w1sAvZWb2Z?=
 =?us-ascii?Q?aHdcTcsrjawnAo7GFbeLt4JHsuKUY9+7TPOQCOEFToFx1Wu4PjKZ9gGGHLZG?=
 =?us-ascii?Q?H9Q8jRXfNRypKKWqY8950SZIZ75VrAejxkz5mlH45OTUquyJcyZmMFabvXIe?=
 =?us-ascii?Q?C4PsY9UPrbH/JQO+lDSA/Kro+H58OumbQuQJOwR16xbarFuOR+YuLkLnDffI?=
 =?us-ascii?Q?jKllusT10GM4WFVD62GlxRt3JmeUYCjDkXOZeibVwxdS1p8IbJNIXKT2pCqI?=
 =?us-ascii?Q?8GUKrkNQA+EFNz6nQRYgE94gyem7ASMBOZtB/wRdSeC1ek2JuNl6cROIw/Z2?=
 =?us-ascii?Q?o7An8XLE+sL5q0mtcdBYmOq+ihXuV7cXtTzCllTWZnW7O9qpeG3h68yaK7yg?=
 =?us-ascii?Q?fGz9aiCLD10PoRVc5LKPJW6ZWa/QI3LPoMBVetu0lREQdH4rv6NexStcu72S?=
 =?us-ascii?Q?ILyp92ZIZyhZw9uP7rSj3glShqBOECsreBWdKONCGqEgJ7RfVCdsszwLvdDz?=
 =?us-ascii?Q?QR8y8u9FtDORFMHL6KKC8Cy+YlIstI0VvOTcwId7Se9NRM3VsQ77y6V+RCGy?=
 =?us-ascii?Q?LphA12vdPVjc+mrDbaX3zRiHTjK2LW1GoVZ67sjt8YHLCvmuN5wiVEFVgPCi?=
 =?us-ascii?Q?ww4cZAuOaWURtQyP3qxz/L5379hkWG2WxCVAtDZTkON0wLydtyIBIot8IRsh?=
 =?us-ascii?Q?zVlBbhN+eFUnHEp0KY9YNHLF/a8ItRDKShKj1uoaLWhOWXiUxwumWYvE+IrM?=
 =?us-ascii?Q?sN6tkthEAg7auSL51ZwXiD2w3N86f69xfLxl93txfBVQYRjPK1jaHksfOegy?=
 =?us-ascii?Q?0SpHAit3ACMk1RuWM0+D9lau2TupP4pl/aowFr0r4o+Zs0jwqCi+PDojXb1b?=
 =?us-ascii?Q?9YH3EN9dPLa1D5v9HgbQKNGmLboAD7V4DKmUE8zqYS9xeHBDdZSCGRBSP/If?=
 =?us-ascii?Q?JeJSCMnAZndzq0gXpMa78a1eVjEccjB+sGtRMXfuNBv2i4AxLZ2aH9TPqyl4?=
 =?us-ascii?Q?M9TUw/RKByRaqW1R4bDdPwK1D5H1UAHpOlY/8e0s9K22TMQTW2Cy2wWA49j2?=
 =?us-ascii?Q?Sj7FuHS+gLFAy28VN1pRwWi9F7JAhaVzL2nEsNa4HRLNhGdsgYfzDJaoi2xX?=
 =?us-ascii?Q?pYHjPzIoAnOuUrhrmUtkkSzi2preI/9A1+fBenH09/c7BXITlvvTxBUD07xw?=
 =?us-ascii?Q?Mh3KFjT/0mT30qsKRrtRMPKrmbqslUjkitc1hBAv+NGPzV+8fio5wCxawMMp?=
 =?us-ascii?Q?JKevCh9RksH382KRSbs5Q+lxhD7YKcNcArVwHkxj00FOZyrIYMNyRlSBrxA6?=
 =?us-ascii?Q?b1szOnRyI+t5xbtaOiOsIYgQB+c40Zm47un2SELT36+VA6th5yHgt7/1InSF?=
 =?us-ascii?Q?QBZY187o7qmVtBTqb589n/WNqNPbOYYIdjGhOP4YcRsJXibf6xuz7qsdxTT9?=
 =?us-ascii?Q?Eu4NZK7hak1zSRECiB0482nZfeaJAREfndWm67KxmJahVo8Bl7hCgPXSr2xM?=
 =?us-ascii?Q?Hg3wnHH1opkTYvyQ4cbdWxaoNRAMkW3lUfe35nzfkWCMpx2CCUzveFJktWYV?=
 =?us-ascii?Q?FfTVIpJ1GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03f9c84-2b25-484f-b4d1-08de589e1d4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:35:25.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xjt1uVFR1+7qF7W+tGTZW+nSdqUbvxStETysK34pablP1WaGmZCbzp+cyFbbb4lPLNBdxlSwSae+utZyU1/lCw==
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
	TAGGED_FROM(0.00)[bounces-251760-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: E984750860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To support AF_XDP zero-copy mode in the subsequent patch, the following
adjustments have been made to fec_tx_queue().

1. Change the parameters of fec_tx_queue().
2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.
3. Remove the variable xdpf and add the variable tx_buf.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 79ab45ed6fa1..273d40027015 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1467,27 +1467,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static void fec_enet_tx_queue(struct fec_enet_private *fep,
+			      u16 queue, int budget)
 {
-	struct	fec_enet_private *fep;
-	struct xdp_frame *xdpf;
-	struct bufdesc *bdp;
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = txq->dirty_tx;
+	int index, frame_len, entries_free;
+	struct fec_tx_buffer *tx_buf;
 	unsigned short status;
-	struct	sk_buff	*skb;
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int	index = 0;
-	int	entries_free;
+	struct sk_buff *skb;
 	struct page *page;
-	int frame_len;
-
-	fep = netdev_priv(ndev);
-
-	txq = fep->tx_queue[queue_id];
-	/* get next bdp of dirty_tx */
-	nq = netdev_get_tx_queue(ndev, queue_id);
-	bdp = txq->dirty_tx;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1500,9 +1491,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		tx_buf = &txq->tx_buf[index];
 		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		switch (txq->tx_buf[index].type) {
+		switch (tx_buf->type) {
 		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
@@ -1511,7 +1503,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 						 frame_len, DMA_TO_DEVICE);
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			skb = txq->tx_buf[index].buf_p;
+			skb = tx_buf->buf_p;
 			if (!skb)
 				goto tx_buf_done;
 
@@ -1542,19 +1534,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (unlikely(!budget))
 				goto out;
 
-			xdpf = txq->tx_buf[index].buf_p;
 			dma_unmap_single(&fep->pdev->dev,
 					 fec32_to_cpu(bdp->cbd_bufaddr),
 					 frame_len,  DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			xdp_return_frame_rx_napi(xdpf);
+			xdp_return_frame_rx_napi(tx_buf->buf_p);
 			break;
 		case FEC_TXBUF_T_XDP_TX:
 			if (unlikely(!budget))
 				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			page = txq->tx_buf[index].buf_p;
+			page = tx_buf->buf_p;
 			/* The dma_sync_size = 0 as XDP_TX has already synced
 			 * DMA for_device
 			 */
@@ -1591,9 +1582,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		txq->tx_buf[index].buf_p = NULL;
+		tx_buf->buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		tx_buf->type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
@@ -1629,7 +1620,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i, budget);
+		fec_enet_tx_queue(fep, i, budget);
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-- 
2.34.1


