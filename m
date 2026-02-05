Return-Path: <netdev+bounces-257057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML1XLu5chGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:03:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30AF03E0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE31330078DD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FAC38F945;
	Thu,  5 Feb 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C3izY8mz"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7C36F40F;
	Thu,  5 Feb 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281799; cv=fail; b=tvesDUYyEcBW0zoJQippMgu8xPqkzRzipvoGMFQWzSGdvj09ZoPRL+pAKf4tW0V0zA4TWI9hNLi3H0TpHDk2fwumm4+vPOqUdsDbZaY7W+7iQLJGcnOTNKv4Xs5qM/rCZBhUYPijYiruTNLk4nYVS2WgfpcYmUqv8SnUol/zLew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281799; c=relaxed/simple;
	bh=xdG5pfEBCJMeWqKCay7/HwCZKDqtrffdQOUV735Oz8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVUG/0aZvVipgj0zW2TgVl+tmfKtZ/BraRxSuUZOi/pXYF89Cxe5ukJll9xmGyw23s0zDgZSUzbwN6mt2XQuhPWby3FM9fIniMYh35fHL99ZJKh601dM+o2NJPs9VPaAq22LzjXe2f3AIbkkzqnD5vnMsZo0sufl2SCErsI10as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C3izY8mz; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOx6VaPoJ3r8q+DBHZos1xMLN3qzrfPvLd3nMDN6jKPpA4WtxQwfujYFBiUu9leJfTSGfl17a2k5v9JPdBkjf+AB1Q89C6Bv/9d0xCPR+XtIpgOiDeLj2ON03FmTkHjbGu2h8lxzYhRm89KXBe/+hVc3zcXlnxhClpci+34ynP+Ms04Qn/CNxYiLQyOcT5tihIfdd+OTaXyBTQtoQ1XOIcWbEYr2PZMWSHnG3tq1kr+CmRmDgWCfAby0lJqkDzOb23iQHjahMcyGfs/cZcQAvANVl3UrbHYbDdR3F0vaPWcxitOgYKGLLsobVnx4M8dzw+teWbWbgUF2+UEho4sOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aybAXKhP676j4z3Cx/OGyzy3DO/e3lwPwEw0FVULR0k=;
 b=zN80w9q/akiX/kLFZWfdBHXqnj4lQdhvY8CZGBSk17i9ckKXzYUK4GlBgMKonNu0dbKX1fnuHU6D1Eey2cwkKLKddRNDBc5AZJgW1ODhsLrWzZ142/dbgOs/WMW4udjnVmSaE4JKpg/GjDFf/PMLHsMnynqM/ruz2P8eI/Q5ULgQeb4O0F6IxQqtOFTmJwebyzELTBSBiX0juz5h0ENmeQiSY4BZDO6aF1e3S6DAJeK4amBNZ2S6xjk845jp33GOUuDz6+JDWjANMi/DWFYDr6ulLmyIoEmZ+GRI6MTEvD2iQkt+QKS/xorqKqHT+8YtoViT48WBClXp/o7pMyEynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aybAXKhP676j4z3Cx/OGyzy3DO/e3lwPwEw0FVULR0k=;
 b=C3izY8mzIOe4FU0qPzDs4Ln7MN4WaYoFoWR2e1LI259Xz5Fb1yL84mKvzMXUvf2g6QVL6rAvKSKGTLDdZiFlv4rKsvZ5N8FaVfL7oh2vhWXgLqUnfETAI4MiD+Rqq5yjFOThW4AOdpNFNAmIJChcEzKqx2RVKWVjvasn1UCp6YeVhJZzvR/Hlq4hz3uMBe9Ggkf/nQ0DGGB2aIcrejcAEPTUwDBRySh9URc5dYBs4C9jubxoumx8ivSoLFI51Q/bWl/1FYRdNJcBZIx5L7rRLq4upbp+57HCs1ilOCj04IJKuEIK8jo8NQLIAk4AHBVGM25lhWiNEPjjIueieNytZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:36 +0000
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
Subject: [PATCH v7 net-next 04/15] net: fec: add fec_build_skb() to build a skb
Date: Thu,  5 Feb 2026 16:57:31 +0800
Message-Id: <20260205085742.2685134-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b87937ae-1f0b-4d1b-2190-08de649477c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XrmuYkovK2CvS+UpEvI+DOaLporTGoSIrcdLz5jkrSVi1KPpNqqcoo1QgT/y?=
 =?us-ascii?Q?14ksuTEhB4y+GBnsQX867fS6Aw5NX80WsE9arrrr4kytdC9XFpb+2Hi8IXCi?=
 =?us-ascii?Q?YdvpxZFq1wqBZfyXN4zQoGvTgp7Hl2zLgdBLmYR/4Sji9CtDO7Jo2p4+PL4p?=
 =?us-ascii?Q?G9cHn00N474mES/Va4LCwWJbrAlnnOtbMAy7EwPXsOyFhPoknZGjDbeXH0b1?=
 =?us-ascii?Q?qcJDnU1ftOen6g+6eQ00ijH19hELjTKyan5+bsFohqSbBmzBU+gxMfY0NYcj?=
 =?us-ascii?Q?BC6sRbULyjlNJNHXYDeJREAnOs5XZQpigsOI3ZxlPLSDxZgW5h3JfKFhpz/C?=
 =?us-ascii?Q?roH7glWKLRR+TocfCBYIG3PvtQ5UdR0UrbRaecHevmWX6sB+zoMnY/1ln+xr?=
 =?us-ascii?Q?v0QeNAKx8xjObqddFEArfNqhFiFna7ts1i9rBm5NiR8/5reoH8bBfWHke701?=
 =?us-ascii?Q?mTvykposArFOTPHWxQWM0FxuKURGKdYeulneIKlEDi4M7GnxNOGj+6f/kGxL?=
 =?us-ascii?Q?CnwzSdM6ZWHAMm1zEwPl8EvHaPzWT4GqTYMPV0TcnwXkasWgLqrhBRuqWAPm?=
 =?us-ascii?Q?KApRzUBiYGcmGj2m5ZE17mf84d3wV+UXbLI2umPicbMEAlLEL7ZKWj1kZ9Ey?=
 =?us-ascii?Q?YcZ6ZQgkPoD+j5zrywus6DPgotrAXnIC50YF0regedF9xaH/scY0CJ4IQDpf?=
 =?us-ascii?Q?vrJ6BGDbccoUI6Qi6IcYZXCqX9rgqUFFw1bWPFjM2BTmYMf5m6AW0YSiFftR?=
 =?us-ascii?Q?gD9T6XTyhayVMePZ4S/Zxv7VpBam2CVFGK5WE6dkkpqbByf+dsg+XGEvmrim?=
 =?us-ascii?Q?oJHZRwKwPjaXSVhzwOXrITLDsVvAGA0KH4ps9s4n5KdfWxlh63kLlbqpIN7f?=
 =?us-ascii?Q?AfpdySbfik5qOb7kQuNj5Io45vBBWqN8di70TbYA0g+pRcfSwa8AjPMDIX0s?=
 =?us-ascii?Q?97Uk8GZ4zQXGh8NWlq2hrGDrUgSGu5GLQVu530GSlCuepXLuKk8feHFoJ8+X?=
 =?us-ascii?Q?ENbuaxdo2Usl6dJX5ZxJdmLOSeW8tflrBd7mmbKPBlyaVyZLKORnkyR3r3Js?=
 =?us-ascii?Q?gBnGWmmMSDU+0HunfHmRmHcEw4pUiryFzI8nsEdL7qitXXCUQhjHpdwj4Gdn?=
 =?us-ascii?Q?SV24WYBDuWj6C3edoDZJ6ML1843rIQVmZ//Lst9Zr2k9L4c7EbLVOjirRgS5?=
 =?us-ascii?Q?4zIwPCQAlmZy5j65qtoTSpht7VHI0mNTSndUTOvkgiJNXWxRbxtlD9+ukWCH?=
 =?us-ascii?Q?JM7Z+41iBCTA3keCG8DAJJPBZsz6aZbURXkHPDkKcwuaci9orJ/KPX5yGqzK?=
 =?us-ascii?Q?LDRoCEtVrrWYmHYhdX0woZeWRU8Ssu01P1ItfajTsf+jKV2Bw3NIdiGZ2fAO?=
 =?us-ascii?Q?Mf0TxSEGJpldIuZmiffl1KEEz5ow1y05LlDL+88mjqUYO64xwCBkaq6vo+0F?=
 =?us-ascii?Q?17BbX35tFHpZFX2OT/yo5kuuCnE9dlWc6t1LSCdb3o2XDiWEK4facSk/IrRt?=
 =?us-ascii?Q?Auv51YwtJ8owtd9J+w2JQ9GWIslQUghP4nMEPCe1Gxmibgx1c3PtkkjY6snf?=
 =?us-ascii?Q?lQSlPhOX5wJmVUfaec2vnq4Br3+Kl6DuP8Eyt32Qs5EbMRlInW5sW7tL5etu?=
 =?us-ascii?Q?O69+kKgs1/kJNG/0WpNPr3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IIwHYnJrGzXH6NZ1cSEYsXG65P3JBxQIm0EmGH6aZDoROuZouTkDFJ4E1CX1?=
 =?us-ascii?Q?sV97GJ33hlPVXr+Sd+PQu/VQgtT8/ZQjwwmO99NYvPeIuaIsH3KXbyh8LzSw?=
 =?us-ascii?Q?K7oJKlKuXEZq9XZr7lPTn7qhjjPuJ48oCmh9GC80s679Ftrw1vWBBNbjW9xW?=
 =?us-ascii?Q?XoC4bmPLN8zN6l89+7plKvJRYz0Py+ag5Jo9t5+SIpQSq/MI6+BlnlevQhsS?=
 =?us-ascii?Q?aXAobjGEjWAwXKkpNrJn0JcY4mkWF7Nqg918kIbLa1LPU88RfUbMI+0qxFo8?=
 =?us-ascii?Q?zVZXAwDZMtNGIajJ4/mscbBBTr9mfDfSNfqi28VLsXPXpZaRIH840YpHXOqy?=
 =?us-ascii?Q?/ZyL7WPm+XdEaxsjoTuQGoeBfVp2KHEjRmr1ECGM9OHd7B32IEkbvLl4FFwN?=
 =?us-ascii?Q?fXoMgI7vwKxVLYvV40vSD9JR6CWiDXHOCyaCaFG7CRR3n2cUSAZNiwlLR8Q5?=
 =?us-ascii?Q?arxD8pOoo4d9Di7om7PxvXRj17e0dgv9mGR8pcBn1xlYSlCzhn4qDVi8VyBG?=
 =?us-ascii?Q?qqG6JEI+0rvMJemYDiAuACtkAZ7sKagPu1+z3J4HXdA2BmwFcYlxGUBIyZ60?=
 =?us-ascii?Q?KyRO4Ye+9iwyNIu9n1a6S9eej7J6MSJlD8Ocf1tTusoKieRJYgtVfKQxxeRe?=
 =?us-ascii?Q?cNXXp5Dl08dSOo1Xvy30ImeONzXbJiTTK45hlIcl5WJbgOt/+Sok0dMrl2GY?=
 =?us-ascii?Q?cafdBOLM8UAnvywhx5ora9JFMhNJipsBRmNZY9XjseMnymIZITEJraHTzep0?=
 =?us-ascii?Q?RQBbmbk3tVwG+TgVS3oZqomFOvljFdhGq3NnmxvQsyQfqUed6AkMldyCCsMK?=
 =?us-ascii?Q?IE3XYqgdO6JAaYJ5cBSCFS0wTx8RSDRLTYDuckquOfD+fk+4mvr1PYHmMXh7?=
 =?us-ascii?Q?HsLipgWNFFPIQ2vWhU4eJyRSHBwgVpmTreezd3yoe1kE7+t+6pISsCh0K7OY?=
 =?us-ascii?Q?b6qDi5wKovK1XQJlPlY3dKil52M7zhVpOn2DjTmI4wz03HReCMBit+x54cL7?=
 =?us-ascii?Q?7xzLX13aOoczYglYIPizphii0/91eFhtIsl+hgl6N9xeYGv/vct1TqekaDFO?=
 =?us-ascii?Q?jUm9a9sML1yXgTplhG/s7BXSXZsRFilHtqcMZ4JpTeEJ9KTpb7YZtDC2YfX8?=
 =?us-ascii?Q?ve7acGNc/I0Kp/80UjbSSimTlFO1bglCUTNwYUor5s195tv8v51ZW7XSsfbo?=
 =?us-ascii?Q?qKPsLX/FSJb//LbGVLbXZ+x+Y1bVylJHoIp2JCZK1uxiKTea0JoGHPKzKfHr?=
 =?us-ascii?Q?z1ipehB0uQYYsv+a91DcRsabe5IF1T+yERp/gtWX+uaPcaMBUptxPZ9AxcDr?=
 =?us-ascii?Q?l5zuC7PIPdQtJkbOd9XNAFwKNyXg1m9Offqpo2rlGu1Y3PcK2J4+6jUktlE/?=
 =?us-ascii?Q?2AwEbLshdXHT/91JDwO+v44UUZNZYrJHPEqrsGSEXyFo9jp0ZllB5eRXEv+K?=
 =?us-ascii?Q?0ut1AleyS1t3ak6SB/bbilHxNodaiXR3IXyqktuPgEiDk1X+YwPx/I9SECwW?=
 =?us-ascii?Q?jP0olgezkkmLZGJD8OyzBf+HvhzmYLUN84qDx1JJF9wK+Kqk89l6f65cX12t?=
 =?us-ascii?Q?56EbbZT32ebNl7iecgi5HYrnwh8AshkU9m7a96Io9pKlC6T8b4FSZrF4xpEL?=
 =?us-ascii?Q?P7ibi8NHa2B+UgYofQX1xbKoWBBA1IZzKIP61eCdb/JZja/USz9s4t9u2zhk?=
 =?us-ascii?Q?m7XgDUXqRpwmbPdLypR9SqGj4/e96Ot510Nr3aCfTdA5eNG2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87937ae-1f0b-4d1b-2190-08de649477c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:36.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyTwVuXU/Yivc+QsHRxBQglrPJmswqxmK5ZPgAsPM27X8y5ZlI1JozZfTGWX8Rsh+dM2O6HbeIcSGT2zTw8QRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257057-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1C30AF03E0
X-Rspamd-Action: no action

Extract the helper fec_build_skb() from fec_enet_rx_queue(), so that the
code for building a skb is centralized in fec_build_skb(), which makes
the code of fec_enet_rx_queue() more concise and readable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 106 ++++++++++++----------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c5d303f2aaed..851608d04084 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1782,6 +1782,59 @@ static int fec_rx_error_check(struct net_device *ndev, u16 status)
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
@@ -1797,7 +1850,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct  sk_buff *skb;
 	ushort	pkt_len;
 	int	pkt_received = 0;
-	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
@@ -1867,24 +1919,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
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
 
@@ -1892,34 +1926,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
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


