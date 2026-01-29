Return-Path: <netdev+bounces-254724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG09FM85e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:43:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7AAEFED
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B8B730FBDDA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2BA38758C;
	Thu, 29 Jan 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MeJl5Ice"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0E38757A;
	Thu, 29 Jan 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682934; cv=fail; b=tIK++0my4Lo1odJxusQLlgQMK93jbswUfrRJcoOdxon0W5Uc5/XhLMFdtozGC4A+HCx8EUsXoy6k5mhd9V3SnOayAbaNujzH3iCvN0uoEneqkpz8j+55RYJNlbfLj08mEi22q3BuixDrDanz08/hBXXEty5LdmOWQ6OvbfN3gyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682934; c=relaxed/simple;
	bh=g1tpGud9ARagXiTSxvxU0kUOZsdNCHT+0CKsbfiTcfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bh5sKYb39d+GnSjWPKXh0SVrumrK0Rm7Qy7411+7VdPOnU3FKeNXlJIa3jNjvEiaFmcJ7EJPUAV0SgAprYZUyXWB4qcrbrrG7R9STv0tTBGdsnh0V17ZoWqhFPI3gvY/ZwverIqHeqF2F1lhVqG5bbdSc+xltMpgUUwIhun2hI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MeJl5Ice; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ihp2+tTdMN56s1qwBWmJIQwuemSL5Uz+jb5cD5wCvQ8xpSn3w/1gJG0olh/8G4Gv91o1MEZEHGPDj7EV/ifA37jpH2W/L+JNvSo0Y1OSMGyaiCND7/2DSSQ3sWSX7Uo2vE6BZekpdFrxIuCcBcGBvEkzfHIDzOHQi6M3jDt+Qr3akDqg/1AiG2zTiqTixYv+40BuGDYqiYwnJzKm3vntvW6XUY7KXiKb5a0eVZBEAQx00S+vXJcUz2szDzw/2Gzikzn3KTT3+Jq1pgwGt4+/DRW/UBVpmtMCYP6UEQqPB1AuolB7r6vfGinjGfBLthqcsHQq+GOfjxCgvKaxxn/qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBQ/+hmEcus96caIYymCPz23xVwqbN7FAi7bqk0mUeU=;
 b=zQrnUzuyfGxRHTVyrlJbhNOkEwGeqB7JjKjhYhu9s62SSGHMX8CjDVhZXicYla9tMV3cXrn01JK6+iL7BO6eXyl5UZNvsCoKOagPTym+uzsoBKQ2Y+RMGoE0TLH7M2SoUXcbY6I9yH4hgEqTKx8ET5RZWNfYMiGP/SRnfW+mg2fdiohlNuc8ZU1iziRY3B+ky/PnNcLjHi+tQy0cGe/Bcoi7duf1aB7OhYnsrD0dorFubR1wCfS26KorT87FXMET33PNMm1Dn0k6GNSjFfLSEl26ej6TAzhg/g/Wpt6gXQA8x+DsmAM+OHYdTgZ2Juc2nmNLx4RilAybJqVFPtb3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBQ/+hmEcus96caIYymCPz23xVwqbN7FAi7bqk0mUeU=;
 b=MeJl5Icec2pR6OrEmVBFCc7fyGowPwKHQXXyf8W1YT6Dt1N/0ITofzUCxEIiKEiGKmaSbnG9dkoAMCafyqfCqtA7Cqry1+65Oszy4bqW8TK3BwaDjOpI1QUD4u9Rv1Uo+3Bvz1B+ok2sol6y92oqft8d+1xKQFR+IW+gs6OKb0avE3ZC1yG1ebfB7I4OkbhN4LzSoa9fjOMVlkI9yD/olNFIuSmo+Nb14h0BPYzUGUMUhzPmmyGFVf/pDjspMcaohu51Mt/7LBq8YSRiZNF6DdHJGvxwxgD6rrtp44Sh9GL15Lh03tIZ6lpaubTyGECJukdt8UHNx3J3+qIwjDRy1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:28 +0000
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
Subject: [PATCH v5 net-next 05/15] net: fec: improve fec_enet_rx_queue()
Date: Thu, 29 Jan 2026 18:34:37 +0800
Message-Id: <20260129103447.1893129-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef0cfa7-7691-4748-acdf-08de5f221e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4z+KHPqu5SSSIUD2q8rzX10uCG6M+hITrd0o/6EiJN+WOsRelBDqWsq7T4zx?=
 =?us-ascii?Q?1kd0PiHolgxzyZ/fM9/Ho9U0T1shahBnJx7sPh9TUyGZzkoOu8PHNO1G6n19?=
 =?us-ascii?Q?BkW54Q9OcFORbfyt3x/5cK8TlK4Qkiwcb7Io4lStNJHtEz9ZhaMC6aJ1jobL?=
 =?us-ascii?Q?u42FogmZW8Ru+tgA5DpiSZqqQb3xb2OLPwPaubdC0sOAnJOQFkzL7qeA4u6L?=
 =?us-ascii?Q?L5OTnP5kaQ00FRrch/ePcyAxFK0QoNAQ7/HEkzV5bXupISbuGz3xw5pN0sUf?=
 =?us-ascii?Q?ceducsPu69b+9DPf4j5XxB/syDq1WeaRbjjd2RZkp4E9Be/O0/8dgr64sYFS?=
 =?us-ascii?Q?dQX9gZUfwMoMawHGhZykM9n/ioTPGql63GA4IjhjR6+nQPOrEqLP+pLYnEBL?=
 =?us-ascii?Q?tmPDvxsVhPVkhX7VJy3hNC3uyRNnoFi+cLJttRIyuWmTmjdwU6kURcLahF4S?=
 =?us-ascii?Q?zgYI2RwBaPu6T0I0KE/zMEeSBoFixqLM2aIZPU7WmLWJW71vcZfSdXIBR2um?=
 =?us-ascii?Q?LLynjNQRSL+fFFqtjWnqInecQLB7cR4Z1gAniUEGbwAhtq3hwesjTH58JT6F?=
 =?us-ascii?Q?/eO4n6MhvwOIuG7Cf5lgzoJfoXubFwHByzCIIR/CSSVNh7cYJt0PgMx7IO9U?=
 =?us-ascii?Q?uRAPEMbSaw/67VP+t7LGli92PcJz4h9xI/kyKq7xI3tHNWQ0RY1TC19CceTV?=
 =?us-ascii?Q?MxNUMVCQAPyTuzuDNg+ci3gSI5ahBnO1UDZDecuwOXVET3iA6ztjM7LvNMbb?=
 =?us-ascii?Q?163wXj091ThdDbryJgOMDNXve7vlmizsG6frx7pYEMY+n/VJ3cDSJKZn138m?=
 =?us-ascii?Q?CAh1fP9vR+B4pRCAhiMS8XOXT4GautUGQK+zRou/uMbl6+VF8bSk6Agc/Wp6?=
 =?us-ascii?Q?AhXKloBaVyVxUbowDXA0PzYcgYNax7CaiMxjgr7KI23d434d78VdysgcziI4?=
 =?us-ascii?Q?ofGe/AO7J/Euy8lTuAPMEvlIkAT6FbPyg7Ny1cSI3IXqlV1aYJPjYe67zdZP?=
 =?us-ascii?Q?wQ+s+ZZ/qrnz6Qg1WtYIEqLCvxjE8vnnMB2+/A6qrxF9VP+pLlJL277ADfQ8?=
 =?us-ascii?Q?1ZLgc9FsCVtghzXVdjDpJ36/8/5ac4jQ+KGeMahyacBOHouxOEeEX0xaylu/?=
 =?us-ascii?Q?qs6N1VUH1o0IrxaTn0CONf8ZV27M/G4MeD2tyCQfnhr5sIVBCTTYebLoeVPs?=
 =?us-ascii?Q?AJ581J7iym8CX1LkaWzEHbSX93TidnwJIt35ZelQRXJIWvT6yr7dWwysPYxQ?=
 =?us-ascii?Q?H3VwWegPo1EboyoNQiMWHNdUyrEWlvA+4gPS5ng/qUxTpvmeS1lj0Dwk9le9?=
 =?us-ascii?Q?nVIxW1526hHtaBEWUae0lJRXe/tSh06aaDkjDJdfVI7I3f/rf2qMPfh8gwqp?=
 =?us-ascii?Q?ZfBMqzqExoXxFTwrdgj1XIDMgABWGhwcAXz5UjH0w4DLX8ouxPMkFyRofQjx?=
 =?us-ascii?Q?zJ9x6fP8u9utYKGEU6rhVZzjrhmhtEghrJ7e4ONhPbSHVsGBezZngLAHVJQH?=
 =?us-ascii?Q?ml0V0WQdZhB7ObdExOuISUn1jfDuoJRIu0S1p1MDDMbP20hZIlxfPhtSHOSt?=
 =?us-ascii?Q?e3j8Y4rsCvu1yo7xXrKH+N3pOP8c167IYNRyU38KcXnbzf+sYaPZuDHkXppW?=
 =?us-ascii?Q?KSysyb1HsyW7Dxn4vWWxqgBsp+k3yV1SNIq/l+MwU9V7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WagC+znq0iRieS9DHi5+/IdIIE7i6Er1XXaoPoAOK2VYmtVvZr59qrEYeQV1?=
 =?us-ascii?Q?onP6tvj6hIByj8BYZaYhj2xfIlUtcZrW0xVtA0dzlQcOPwZpOJfQfQUpFoR1?=
 =?us-ascii?Q?SvWY51FDOsjc9g4B4/nV3xDdMCZEFTZPtQQ/MsPq1gfPn+w5G31KVdy7dMrm?=
 =?us-ascii?Q?ekncTjREYmHP39xezRWn1cWXP1HpD3/gihX8M9Zv0mUjHsjjRP67SjSfrzMg?=
 =?us-ascii?Q?lrCSCukCq4giTRsLMYzgTPoDaWFSjP52hGCJ7SShCseb05CP9F1cY/9An4nt?=
 =?us-ascii?Q?ZZd68aqNNb5xIsMJY//bxDE0UHHCD9FFE/qrM8CtOjEZtQcRSxdbP1mFmYIH?=
 =?us-ascii?Q?24oVuu0X+tZipaOHhDeglm00HkH9WdA0fkFae3VOfqevTLoYWPc72GkrZEt0?=
 =?us-ascii?Q?2Ww4ci3KWgw2jr9U4iIvrLBQcbKinFhcEMivBs10CdN2LFjoX2oLLMFk+nDO?=
 =?us-ascii?Q?doDIPwVV2+4Zw2fy/tTUJuotCzuqM09qH/dZeMbOQy8mjhabMPXztatE0mB2?=
 =?us-ascii?Q?+vOrr7n5AxGcIRJg7vHy0uJ0rFaHUZlG7tqK4D77QvY/p9t+Xfh15bBAEfkU?=
 =?us-ascii?Q?rGaaqcNpnJE6OL9uQZ3kiEmNF1wS2uJjTHLc+X75N7S0mgtl8p9n06k79jzW?=
 =?us-ascii?Q?KYfnhqdRkAACt9St55rpVCXwyFibCUhKgn8s/Fpni2SSkpwlGxQMfEoHei48?=
 =?us-ascii?Q?K4ATz575temvNMr08Lzrh7ogV54BrFq5CDzjY6L3F+Ad6ZBJkjUD0j/9jcpv?=
 =?us-ascii?Q?EzygS3mDxFTIlUJ6clSO28tTQgSB6cZFCRLQlpkrqn/zvqMamB/E53Tu8/GH?=
 =?us-ascii?Q?IWN8Xuuvbg4jkr3KdmZjmfmUjcAXBhkpjJ8OAPDYZb0Omo++QMRRTKF8HOdq?=
 =?us-ascii?Q?60gSfdZHnIWO15ynEJxC3Wkj2zH1IggpFct+3k/ijZm99v2sdo7QMdOikCpO?=
 =?us-ascii?Q?2NQdt3soYngq6VYP2HUapvrg3TmiNUBRvGftGeESKnZaM3DP+rX9da6xBU26?=
 =?us-ascii?Q?xSpa6gDePpQtUTkXZdi6SVaxtTO59MI1WzoeY8EMaRlsUJvmcuWmjUVdSXeE?=
 =?us-ascii?Q?QSTO6XeiPD9HEmR16H8jnbWF+eceArFAlm69cE9o1hNoqTtbcJwaTD8Hgrfj?=
 =?us-ascii?Q?L+i9/y11XF/h+t9ztLvzDMqs1SWqnrnXXhFogpZeht70/5lRqIJM92+V1v8b?=
 =?us-ascii?Q?L5e+hyPCCyCuYT2mArhWUmvBh8ksKgLAhRYeHlEavEIhSCMORbrg4uPy1Gfv?=
 =?us-ascii?Q?ZgY5ULxeXmQ/jrPN66Gq9EH3Azm/liZzaihb/sYvhLt8NPgf7i4fFClraC24?=
 =?us-ascii?Q?73PG1hjDQjP5Wx7W353uzug0ZrEbwNewFFcORhe8t6Cx/2EZIbERTI/d9QoM?=
 =?us-ascii?Q?Mf+qbUG4GVcpFi54xXMIoGOegnn3+Pj/90y1xV2g8zdtKieFdjqpDe5Ot2GL?=
 =?us-ascii?Q?QEV1BOvi85U5pX2o3hQxd8WhFaCdMan7zmdUSef0E5jgxs1h83xC6QW8jjP4?=
 =?us-ascii?Q?ZtTGOSpoRR3izD6VY2+ulfm1qHJVQjDvPJuz0xU1diJseU6Iyq7LF+/joITg?=
 =?us-ascii?Q?vwySfb17wKlhasQBEyd7l42ccMogKWSJkDLE7/K0sxMjIR0KIuiO9qzEqkwJ?=
 =?us-ascii?Q?wuJSjuPOKi4CNVhB8B2gdgh3llyTtGiuA5wiuywG836aBNN83J6mWxn7TFrx?=
 =?us-ascii?Q?3/7EoGzE+Tr76gezLvXwtaql0mW5m993wic7Nc6pdKtqHLCHHVU9GYNzE89E?=
 =?us-ascii?Q?dmj9QWRVXA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef0cfa7-7691-4748-acdf-08de5f221e46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:27.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iLa9iz/Kb8VkSF2RA8JQy84upj3R8rZ6BNOhd15KL7c7UdYonvxaiH+SCfQk5o5Z+Ax00po+64m6a3wRvsvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254724-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: DCE7AAEFED
X-Rspamd-Action: no action

This patch has made the following adjustments to fec_enet_rx_queue().

1. The function parameters are modified to maintain the same style as
subsequently added XDP-related interfaces.

2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.

3. Replace variable cbd_bufaddr with dma.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 851608d04084..7bc2eac01e6e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1840,26 +1840,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
  * not been given to the system, we just set the empty indicator,
  * effectively tossing the packet.
  */
-static int
-fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static int fec_enet_rx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct  sk_buff *skb;
-	ushort	pkt_len;
-	int	pkt_received = 0;
-	int	index = 0;
-	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
+	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	u16 status, pkt_len;
+	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	struct page *page;
-	__fec32 cbd_bufaddr;
+	dma_addr_t dma;
+	int index;
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1868,12 +1867,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 */
 	flush_cache_all();
 #endif
-	rxq = fep->rx_queue[queue_id];
 
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	bdp = rxq->bd.cur;
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1882,7 +1879,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1896,15 +1893,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
-		cbd_bufaddr = bdp->cbd_bufaddr;
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
 			goto rx_processing_done;
 		}
 
-		dma_sync_single_for_cpu(&fep->pdev->dev,
-					fec32_to_cpu(cbd_bufaddr),
-					pkt_len,
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
@@ -1980,7 +1975,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(ndev, i, budget - done);
+		done += fec_enet_rx_queue(fep, i, budget - done);
 
 	return done;
 }
-- 
2.34.1


