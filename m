Return-Path: <netdev+bounces-256141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IGsIxyHgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:26:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EDED4AC4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B02C303B17E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95B369975;
	Tue,  3 Feb 2026 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b435MSnz"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD4367F21;
	Tue,  3 Feb 2026 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096266; cv=fail; b=eByd57c3/JomLY6XKHI5I+1PCFXw6WNgiw0mFG+p2qmMh13eyvnPCu9GsUL0zOI2hj6HsTT+8Ge+o31qF2aNLAvFNXlOWfkiTcNBjYlmcfhubtNYYQyyFV8ALzS/71Kj1f0nRy7qHeQslSUHf0C23n+gB0Idi5lt9DdxjiQopn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096266; c=relaxed/simple;
	bh=2CZEytUGKpOUmJSOERkQgF6qKJTlTG44/K38P1knhEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ur9/UzfeGAWcrAMlrHAY/4Z3GCD4m5h8pi9sg+ymB3E5jI/20HWdeAVd3Dewv//h0nii7pxXbRdzHRiWuVOdmBe/NIDUtBHraJ9O8L+VeocDBPSxpDD3Vc0nGG7/90S98C4P8rYy5JH76i15aln1OMoSZeUsAdf3mGfUEU4jCBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b435MSnz; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEx6b1t5Zx9qJZGzTAP8R+tPC/2oQf+avE4VZoYR9f1A4pMVl4IEEs9Hu6VFlFRAuaIx2ETSsWAVE6/lhpECM4So89WTyHUI7Hp/Ar+GmRVlRJcjbai6VBMLXDzFw9l1RFm0/+4CrzwmWWditKwi6YRdtcUNCLmtdxpuZS2yniWWwRP9LEzsiw4zS1dNlEfW/jPBvRuvmkOAwDuCyX3sdgY0sdAPWkgOyebJ1boeDZ4zZ4TTANBHEwU/3nG1cn7VvYAj+sjQ9bG6HmdKW4OLBivi1iuYLfE/jQ877/xOCp47eD7C3Ex0Cl2BG1FE8sXQP8oRzJP1R2XWSDQJPATaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li3V//MWC+wAZ4z+0sJjZSbpjtj4ieyMWBaivU793EY=;
 b=wOfhDOaeBAqYXoTzYbXB3we1zpbE7P42w9gdDfptxKrAeoKnHwx3VB0Ipddu09DWiWg4HUCSJAd86idzx+AiFgrUv6Gr6Yea+e6FDQLg17cXU/eKGyyNwSAhua17S11UMAh1saMPutrxvosFRX7mZn8RMi5xwE8rOZ2bf/EodLXbHMgt6UETwNFBJm+PxsJJE6Aa2E+IA5xXQcIsUQt/VBAY5DrzYMraLf7f/izlnOXCFh6uWB9SE9JJa9iWMHfN9jqyW/VV9aw+9eImv7xlP/b9Z6SrBczsu1BjIsT6xLph5on/47eQ+yzReQoGGg5Zky/lNyrimO7FRyfBGYoahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li3V//MWC+wAZ4z+0sJjZSbpjtj4ieyMWBaivU793EY=;
 b=b435MSnzLNVVmc0dgMElV4ZAMravGpf09/A/KW1fkErAEu5KUbtoFKy7jBiYEQZrMxXSVdikLOkzE7Row6GZpGFQzk2JCAYozZ7RAXvR8WJGPgmXuf0bRAE/e7nQm6REpTFrpY+aBryPMA1vMUX8x19f4UvgOPcJuRAlKETZ1j2uf+Ll2QyN3yDagVsCOsRUBqLxBgMqA34zWcfd4Lzv8uhc+d32abVptkD7Pq9z4AV0SSqsLdyoBBjr2ChT62sOoYhLIJqsdgtlhrMy2tD3xdE5Hl8NHzTkjcK2SVAHpX8fK7ysVGJrZerLtmaRJoBYdVbr2x1i2PkjrTDxWEAyWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:25 +0000
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
Subject: [PATCH v6 net-next 14/15] net: fec: improve fec_enet_tx_queue()
Date: Tue,  3 Feb 2026 13:23:28 +0800
Message-Id: <20260203052329.1085444-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 3282e5cd-9666-4f4a-5ba3-08de62e45ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pLOOnU2jAfjYbmIsayE7GQctYeEyKc6odZiGr7Wo9jvHOa0Y5XkzlfU2Hdb0?=
 =?us-ascii?Q?CIU5nvs20SQGZ/NEmtbzbDl1zhTuljx4vYQqi7X5n1STp7lmAVhphBQ23jv5?=
 =?us-ascii?Q?IrkkgXBSyB2v0JmY6IUNvVzNqziFEgcyuYRUv2K4C8R04u4mzZE368hl3cWH?=
 =?us-ascii?Q?2BXiRcRt1EkLoWbDn/+FyCEG7QRyn1tvRzfOqA5i0qbgR8F0uZ7h6n2m8rOm?=
 =?us-ascii?Q?9PJrw7cCp7hsM+wuLa64cVxK5bax8E7TbNu0UghCUdqrkm0RxDmIQL89u/vF?=
 =?us-ascii?Q?0AONay1UbPcmZEbJdnLkuDYAQyZJc6mQKlQK7n92ZY4RBG+tceFT9UjH6f+5?=
 =?us-ascii?Q?+iMSLyeG6YbE6xDjcCfPTAUaSPesmgual+cp43qsOxhxO7y98Sm96SwmipwY?=
 =?us-ascii?Q?yjx/rXRvWWwjq2qAuWmXbgO9QgYem3c95Ld1dqEjl03IVWjdHkLXdZN+jG0O?=
 =?us-ascii?Q?nGeIL55VcQMEfD5rlViZclNA01A//pSd39yVSNBGb1GIucx6hhmEVmbL+uwe?=
 =?us-ascii?Q?EPc5yMuwxp6GD+RbonggpMw+7/Mqztocy4F3SZXKy3/0xBMFZX1UUDjAHVqa?=
 =?us-ascii?Q?bg48HQXqbd/Ri2vMfntfSvRy16k1SWt+rsN2K858uByefLnYIIIEBTn09bXm?=
 =?us-ascii?Q?BJwISFlno2LoSbW6f5ULnRKyKNSQ0lGjIN2PpLcrCXswk0JyjJ1CJ/nyaezu?=
 =?us-ascii?Q?G0GLSZb1DNGVwdk4Ja8mt0nu3YgoGTTffH9o5mcgUcWXQAgFk0ROivF7LMkQ?=
 =?us-ascii?Q?nfUxZvRUOWZKBINXTCnfE+OzrtMX2ICAFSW2u5/Bimq9XuqPAuxximpcaVyb?=
 =?us-ascii?Q?GsrufsRwb1IX2oUljSikMeRDAXvJCuvjN3JXQBFP0HIgAMAOuRCUtsdcgCv5?=
 =?us-ascii?Q?OU/XrGSz0vuKAECDGlnru9kzL7eBOk0svEDLgKBNgV6q7atYQdF1yfJUvwvH?=
 =?us-ascii?Q?WQkaG+/h8CTmTDlCuU4/1Xs+kOkwPEBdqWlpFe75BUjjwrEKqatBls3aS4oE?=
 =?us-ascii?Q?wXKI4BErknlouT5mzE5JXyGoOFsgDESmcuhg5DrKuWdt8ooF+O5SxsIpKx4b?=
 =?us-ascii?Q?KZosezG2iNoaa+cfmuHt+lKrdT0dCOE5hM0CoeTMOE9/QYs/QVGHcpIvSJZw?=
 =?us-ascii?Q?n1odMyMpAaYACUQcFayw1UJPnQTWU8Oeu0ZI1IKixyJt+2pG7WP171mE6Mg0?=
 =?us-ascii?Q?Bz96yPFOyvgTr1LPyGTs7CPJVzd/16onHOnIyekNmRKO2jcnoYvQysi9gbOM?=
 =?us-ascii?Q?o60MUwbZITccR67/Z9hcuxwPlu0CnIvzNjIscJoRlw8dUJ5a2Eh3EEIpyLLv?=
 =?us-ascii?Q?UHAAK7GyR7mB2usWfb3jC8jG1bdLBP5rJhw2NJw+uP8GZNg11O+kizFHXpBN?=
 =?us-ascii?Q?YdFiobObMSQdzkfFTrZZogINIFitn2PogmSB+cD6Ecciki5u7HTR18IPvpRL?=
 =?us-ascii?Q?1GSaIJR8CPGlwCbPptlabeKOepfNfKDqxXwFnIq2BYy1uTcrIXmZH82VrfSK?=
 =?us-ascii?Q?ikSQwO8YEt7ffWHIE43IB8upBXcTMWvZuniHchdzyr1cPTpVGTlR++DWW5un?=
 =?us-ascii?Q?Vm0Vv+GKcBG9y+oQxCIU2cq+VsQhgXNz8wn0xthYs0+B0kbrDlGMos9KYqYh?=
 =?us-ascii?Q?Ct2RkteCUVVxCmrTLIj9keL9RWicSgom6Vzr4kRfoFvF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jzbtAm7+LnMAQA8PHhAB3MBSZbKoSKn85iVlK1z1WUdFZTkuW/MKURaEkjr?=
 =?us-ascii?Q?LNejYfInETpQzCuYR+1Giyr1mhxJbt7VayX7WtOp1qWREjHoya+zhg6VADYd?=
 =?us-ascii?Q?ADbgS0nZiGKoJuq0yabzbvUlC5c6M0l9LVClG0wf22sK6S8vjT15PBZOZsEN?=
 =?us-ascii?Q?YH/+K0Ua5evXCGLMZ30qSv1jPjmfnENXS27WUPcUZFbnYaF99kZlf+dmXrgR?=
 =?us-ascii?Q?Lm/KtTEPVn8i7Ls+Yw75smstRyr6nzjp086M5HCQCPtQI+FJhPE3xwzXZ3py?=
 =?us-ascii?Q?/+SsHA5ICEpUBJc5DYGIw+QDbFxG08FHi9sPTFIF0oKuNq2jjGpMDj88swvQ?=
 =?us-ascii?Q?MMnOKgFxqVLzTS6AlF/Hr6SnJgSajvd5sZNy6uPziWo+D/T8d2WKsX8eg4Qb?=
 =?us-ascii?Q?oj4bPjKHo1pe9KD1LoSA+RjrxaTnfWWhePLUnJEySLOpdLUfdFnigwV1hLx0?=
 =?us-ascii?Q?w/3K9oseMn8M6Rdclg+8YDof4gyofkQUyeH5TjUD7UN2wkDj4Y5mEI92WaR+?=
 =?us-ascii?Q?IigywHCz1dsJd84reBYU+8ifuWTzgt7I/ZqNTDhzmNUcoq1wRVfnsRnbnHPc?=
 =?us-ascii?Q?WKBRtC0DgBuinNGSm1DxUWnsVL46uro7U+mOrYVfUUN0CvbyOFv73xI0UrqP?=
 =?us-ascii?Q?n7436kOgIiahAxBZXzO18XWsMSrMffj3WgF3ul4kowkSBngwbKXN/6STXPNW?=
 =?us-ascii?Q?Q0UIgGekw3WJ0Y8wAhpcebdz7QqpWsDflt/HJEl7r0w1uM2Wt9uxEzjvVlRW?=
 =?us-ascii?Q?3obo9sWVdNapUDryo/039WWhol80FAvvFwGXDVuwavUtETYFOCLXOzLQxmrP?=
 =?us-ascii?Q?oNgB9eHECII4GId9MK2DtO2JfHX0UnwS9mwmQKprTmegU1/HdP98TKQ2bK6C?=
 =?us-ascii?Q?m97Ln0xEa/2P2Mbqq7XlH5CqV/iRqLL7kgi8naw6v38F9m3KKBYn/XR6oZwt?=
 =?us-ascii?Q?yymqO8/AJ6FMzGziaqBA3dFYi7yOqK319fMOObeNH6wB3227sreUkrW7+Y3F?=
 =?us-ascii?Q?I8OFpji+a6nkwR8hK3+lgq09X0/SAN/3dnkI8PZEHpd8NMPfm23oYTesbbtG?=
 =?us-ascii?Q?4MTuoVROge9FhmR/abE3Pc1f/Fv2cRRnKGg3fnclp9pF0bLe2SvtUUvcoAAg?=
 =?us-ascii?Q?vZ064f46pHyPlqI4cmuYxdRVy7Cfm069MitzwkUkXWmRRKtQoMoYy2ilIaYf?=
 =?us-ascii?Q?tXb66jV2WBBfMnLxGYFv5gCdXXJ4us/O318y5XTar0HQkNyvUa/PdrUvZbq2?=
 =?us-ascii?Q?0m710DNwfSPS0NIWVrLzZiOGrcqGBWgLR3BkLDrws0Gjl+kC/ABStfSnJ+ml?=
 =?us-ascii?Q?7mFG9cTDL7lRM5Xg/d2ftfhumjxw+qYr8x2VQ0a2GuHgpFc342Sy1fcoQu9T?=
 =?us-ascii?Q?wo5G2dTtS4CYcFZUvvtKRA83jJDGMtKcHYTVENokPG3p+9IlUfMFXMwYStQC?=
 =?us-ascii?Q?POkkc/jItskM5yj2i7O96v+/oYB7sF1G2XZ693qYZ1Jer9Lpr0LgRPEnbWS+?=
 =?us-ascii?Q?bEnU51sLyrUJuN3UZDWdW1kHhlmIx1lcSCFGsZOLndVDNmeG1aQ05mZX/8/k?=
 =?us-ascii?Q?RszoEu6nbMMJsVSS/hzpLFStq78+ECngmrxzvtdSr1s6XPMHKCvLWiWr/xFx?=
 =?us-ascii?Q?ow+cmlkjwP201pZFV5cC1fTVKMwca6dWpmxttgnZRxY8WJyn/yZeKqNdy0wb?=
 =?us-ascii?Q?ictebc4dmd6JQMwEwxFfm2dEJGxKBAPbGPJBJLUnLoQDDbieumX3yji5x1AU?=
 =?us-ascii?Q?h9AwdBAOpg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3282e5cd-9666-4f4a-5ba3-08de62e45ae7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:25.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdKCYhWWzCgA7zAb5IV1C426E9N2C7DOYZKCm3PHCXKtMjYY3TmSfWVNNJHoURBxhPANJjj3VZ88bYMnDzSRSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256141-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 79EDED4AC4
X-Rspamd-Action: no action

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
index cb03b45b7951..7aeaa055c2cd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1475,27 +1475,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
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
@@ -1508,9 +1499,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		tx_buf = &txq->tx_buf[index];
 		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		switch (txq->tx_buf[index].type) {
+		switch (tx_buf->type) {
 		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
@@ -1519,7 +1511,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 						 frame_len, DMA_TO_DEVICE);
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			skb = txq->tx_buf[index].buf_p;
+			skb = tx_buf->buf_p;
 			if (!skb)
 				goto tx_buf_done;
 
@@ -1550,19 +1542,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
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
@@ -1599,9 +1590,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		txq->tx_buf[index].buf_p = NULL;
+		tx_buf->buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		tx_buf->type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
@@ -1637,7 +1628,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i, budget);
+		fec_enet_tx_queue(fep, i, budget);
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-- 
2.34.1


