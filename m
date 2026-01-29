Return-Path: <netdev+bounces-254727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFdmDkg6e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:45:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1572AF067
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59FD8307E325
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C08389440;
	Thu, 29 Jan 2026 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kpByHMd0"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20060387560;
	Thu, 29 Jan 2026 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682947; cv=fail; b=LDhPEj2tEVsc9+1QJLiCr1QFnP0o9UlREtm3n+5JIN+g5V/6PIRjd43vXCBTobQJxD5HXm83LqkvboZ3fC/1KFnQl7Jza3Tk86fsgIw5mebNvWKtm2LghI8Hlt+6DmrBNAwBymBblcfftN/g79oh5+LLn+SCuhEoDvhKhR9OcrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682947; c=relaxed/simple;
	bh=Hga26JghDVVVL8OVSOnbdcR9RmDZQTDWAQF6EFqYauQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9RrkE85B3lXzWNl3iCFHFpkvC60n3KUvmeL8HHHja03y9H38kQ3ZTFNlWY3BhBuM5z3czKzRKSJWh8bqtv7Y+meEuEj2kShTwvcnUFEy0Ky6fYgZbrUuUgIYjtaCNRCvpkKOs3gV+7hS4+k3X3nPrLlXvhZ4ZMcK4FtVEtvN6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kpByHMd0; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBpbUB1ut2uEjQ6bWyCdUJ/5yNora1DRf4kOV4AYValueovtqhCJ/yD1IPzRqvG7F9KndU6ti/ABvBQJyORpmjQqYn6bmLZZ7BG0XcQtU0oLBIzJMGCqXKgxYTWDCNJTm6kI0cFmaRv8qIjJulvM0RIY7OQ9o+prRRyIYEXswHhh5RTFtmMbN3hFcFViRKg/huvzCadAOtubxaWZh/LIUwS0vB/Dx+jRpBFLOtnmbzKYXHNFLL5UxQdxJLk4EWEncsn4omoPzZD4UnU/ZrFrhqmA4EaPiNjOLZubwm32KLdf7r5V4izwEPTrl+bO8jY/JEJi/IBdTX7ncUPEx4EkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwwVSSuQM2e0aBpaVj0w37vFfW3O53Ps8S9gEL+o3fE=;
 b=NF9qr0KOKLC6FzXFFU/GsZP2a6amG8g9BdBwSMmZGBD+zvzUTGhtTrYu72Gn681EJlcg1Dyy5gnhnPYqGHl1HhSjYaAtQ6XoKcPpWW+4RtOTWodv4WvXMa8gkA0abAW/wnLYvj/lWWcpaOoU34jbTkHfpXkUa59OeQwlE8x9QZoWvrTSJFUsQ852Aci/clPSb/D1kJ+7o9/6vVYyKqIzxcp3Hvzf1bWIXFTXYngN8qFBt4e0QhUPmnPSc1P4uvMxn47bEappPE8C/bWbPFHvpd5ZW9beM+uPnWA/oPwlCsCwI/OQrKlF2M7+aVUDgW3uxQ4mq8Ha0OErMWZ34q6tgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwwVSSuQM2e0aBpaVj0w37vFfW3O53Ps8S9gEL+o3fE=;
 b=kpByHMd0mhalej8p1m3rAQ6m7fD5GIcyCrNdRUO2xdAIbqyQi1rdxYRffK5vv/DeRBI6gzOAGRAPgsM6WbSJQx4UFuR9p8p+izpxulMZHI+vfi7tM2h3L007Uo64H4yjN8x4SDaBDW5w0hPsWuSWUryhdzJgkJRJBKuC3ANpFXIks4TbFZttW9EpA05REPGlp9cZFbGwq49DZ80VQwAcK/L+yHlIicV+jw4ggmOipXPxK0kfHpvSGtq1fdOi2eBlZ3Jdm3PH+Eoafu5pbambpLo2wo+YGWkm79UtJLjMVKXWdvY7sRkwDcz1GMdIxXkEoJwE8ZlIss8XDmncNtDuJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:42 +0000
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
Subject: [PATCH v5 net-next 08/15] net: fec: transmit XDP frames in bulk
Date: Thu, 29 Jan 2026 18:34:40 +0800
Message-Id: <20260129103447.1893129-9-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6ea06b-acdd-4f84-b1fd-08de5f2226f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VW/CtAfwutY/PyNtv0y0zR/bXohraQENaGYo6mqjTOhk1Cxp8exOuQo609r+?=
 =?us-ascii?Q?kuC5iuwLAs/jRwtucuCu31AnA44VhAYHOA7b4B4W/+Wm7t0aeG/hy5us78Zc?=
 =?us-ascii?Q?pvQk9xpJN1/Odpg/d/MFfTpg77kVByxH3Trl/pD3IhLqCByttjGcEaJBBt2X?=
 =?us-ascii?Q?ppVZL40zq6vODryiYIyqjYwzZeW9XQ8RcIa4NFwBrf46dZeIyCj0pn2Fz+tE?=
 =?us-ascii?Q?EpEZONjiTyRgyKSwjOq1Z6ul4s48Kc/BqMVBYo5lF7OUEp/pC8nEgy9zDtMw?=
 =?us-ascii?Q?lpJo8v6TctcwH3bWTBuVFWjsr4GAQ8fMnNSdzzU7EhVgAZ6jxWoGMvNGLTkc?=
 =?us-ascii?Q?qwvS18uB+fq8NIyA1q5omOpp0jinb7oX36guG1hCkSAGETT5RFFFvfoYmELL?=
 =?us-ascii?Q?3GMjnRkbUv4Me+UEEu1G760zh0mp+5JSg5ZIjvLsMxc7Y5Cz2DaguXfmkY9Q?=
 =?us-ascii?Q?uccjYDVMSxcgurGj/ZcPgAvuwgMVBROFl+r7Dp8X2hcLNx+kWW60lZVg6yi0?=
 =?us-ascii?Q?LVBpT2ewzPFEbhGwnCzBiBmjEkQU/uB72jtR6s7riD6TKNToizcewibQciMZ?=
 =?us-ascii?Q?hKpibKZzlHLFImHafAhLk/tAu0N/Hk7ml04LgnQYNuqOK2zyfREg4uVTvfeI?=
 =?us-ascii?Q?bEh69qqiLpIBWin2P+sQh2dVd8f9HKHF9v6YVZCl/1LPoQASGSFPE/3jIwgo?=
 =?us-ascii?Q?OJBgFzCLIb6p0fYGgXGLapr3FbPLs3N4yiQtUEiIyC7Elsqek21SXuJBRSWe?=
 =?us-ascii?Q?ToOsm5spAnXCwB5fHGHlfABNmD9/KhRDU97WndJ0wJwcvOqJVmRuNBmSOBzP?=
 =?us-ascii?Q?/h0XX03HdhVomm+ZXbB9la1G3nqSqHe95e3hyhmlAzmyhoP+ZkQHDlaapBJj?=
 =?us-ascii?Q?FJOF79r4oZXFmeB75ARET1Wm9PB9QyKE+xBiPRaFrrMm+YQIj5zoBKaE0smW?=
 =?us-ascii?Q?SAmljvgi/D+vI0Eng39E7Ofryxivops8zPA4+djxqGv3cX3yKVZiHlhIMH5D?=
 =?us-ascii?Q?0/lD5GDmQKCffVKXRvhX2XwdNijQ7QWUAvD48ayBFEqjq4ggOz5oAu8OFPx4?=
 =?us-ascii?Q?AMy0ZK8OyYnqRIvaySTbWpvrWVeQ1P0AKIZrXZCPJPSq6RJXtZDL8x/JyU3j?=
 =?us-ascii?Q?kRVuQBX96vG7hCrG3+PbYLmYsG4hBeaozqr0KXOtf+fdOy4C8I+sj0hllg/3?=
 =?us-ascii?Q?ksfP7Rbg4czllwyW7MtR6kdoAm+w5DYIU16MAas0icpeyCkLNs9w4/oFvpSU?=
 =?us-ascii?Q?m6tyb7raBv0uy8dHOlpbFve7TsAZDs3BkQX5EtYjhbpAee7QnVCpdkDUrzLO?=
 =?us-ascii?Q?PmYYTBInLv6wg30E25/ZStgi0veJyYTpMuebiMb82jOQ03Ru/Tv2AQj1dHri?=
 =?us-ascii?Q?LctrfETormf2RuDtHF5xr4xNr/mpYa4TD9LKluDGmxFmYS3Drg0HscpXy20C?=
 =?us-ascii?Q?QPH3vOqbDKESc8KEsowoVrlCNqf8PV3xWRoi999HgupTg/YmPukSnHSZODoi?=
 =?us-ascii?Q?uSh61iPTCZcFeJDajOs6Efw3H3kxH8JSnUS8GRH6cRsbTzAchvC847+2ymZE?=
 =?us-ascii?Q?7KTUFRXP7HxHArRVC5IBPS0WqQBEb8mdMIlQ79hZXIk7jW8pVGvn9EYnx7E2?=
 =?us-ascii?Q?voHNYKE7y3HC/yGLBRhM/UOkACn2/NRzEFIP4AgbcMzh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKTmKxsUPDP8ht5qAcUsosn3VMFoCEUFPP2SnmIYayJnqRZzYrMh0AUOYS+x?=
 =?us-ascii?Q?ny5ZXcLrRwS4hGIJm5ofSHC/0Fu2NDorIqs69uVp/I6XEjkYuuJa/cjY/Wvp?=
 =?us-ascii?Q?2SJY9AxUVY2do4SWF8idLZ9Zax9E1jur1GKkP+JzejZyDP8VQJWxvl++ZJJC?=
 =?us-ascii?Q?ipwXNmtcFSURbLk1kSqCyrImzGeTljD8DrcURfx9i6pan/A3eFVtGfkJO+yf?=
 =?us-ascii?Q?6HQdlzAAuVZpxKbvZFNKBfz33Nwdo4wo4go0okr9B4NIimFmc32bTKcdVcR+?=
 =?us-ascii?Q?v0DvboD2RZIhhdu4Hos10ycjEHUyTcFR4FXgL9a+gFmPFcPEc364bNQAeAmu?=
 =?us-ascii?Q?n/yeR6jbgeGPHH0zhtkKkMKuLcWZXHM3wrA31GjLIYRYWOFY5lBetzH7DYag?=
 =?us-ascii?Q?0kGxPnVBq4AK2XdM0GkLkwalWFRQQ6JaIBoguaejX3uwToKFKUc8x5N+zyYz?=
 =?us-ascii?Q?r3gAmCy7KFJsK02WZRYcSqfANMbgMHJOTStF6fiBAXtqra3aM3Ph7nIysHYx?=
 =?us-ascii?Q?SZNSUSOG2y01R91unjZIkBQSpDaMltPJkZsivorEeV7IRkAYlSofSfZmJ/+3?=
 =?us-ascii?Q?mqxpo2vBz5cjOmGMrBlBE69gAfm1MHHBmd1og8WWPMoRAZzaY065DRAHnWmm?=
 =?us-ascii?Q?m643Qo7yBIUgf4pjTpO51xqd3yr+i4kjPGjZFufnKM+uQ7hhSCTqfOVx0tae?=
 =?us-ascii?Q?pwJ1siSdghIpEiw8tgtpAU6denAsHRvikjmJpOD/IownlDBXQc/8U3WTtF/p?=
 =?us-ascii?Q?F+HssQEW5QzFIYp111PIZiA/GKwmEFkohJZcW5mL8mWo80jwJqLxM8kBnqpq?=
 =?us-ascii?Q?rp/DyWeiLd97PnlmxF1a8GsASouNv4VJzqH9KD5kC4KKOGVR1PgVadu3cTRi?=
 =?us-ascii?Q?/ok5wZHE4kGU5e4DphwqCspr0iuMu8inf7tpZc1blL7NIoFHu5yuMQILLP/q?=
 =?us-ascii?Q?Jw3sahMIoDOXRlpdFkZCuJd/YZy/nUaO+Ofivc4eEfCI6YHTb68PjQxFOldw?=
 =?us-ascii?Q?t/VToGH48eFClcn2gXPn3mjjQd5N74PFilMYMRa97VJ8Bs77M8/BdAbIkKHl?=
 =?us-ascii?Q?1aqX8xgGWgFEdLzx2jWWuiU+QQv+eaS1gpwhOhugANyJURzQpFqu/+JA2Fjp?=
 =?us-ascii?Q?yazSK7UbvKTZZspjReeH0hhDX0qDwRKnki/HUUb/1cqvGVNBNtizXr/0J3Pm?=
 =?us-ascii?Q?ji+oH5OT4kupQLZHbH1BPBYBcVFIMGZtgwFsRXjRw/7mriVk45yTGKFwWM+G?=
 =?us-ascii?Q?7obYPXSbtlZNGXmU+a3mqjancvPq1pYrFmfq161hC9+RzsuPtsbrmtRyTp2i?=
 =?us-ascii?Q?yiX6sgggT70iVADi5QbkIUwQCdmbxkAveb/Zg93I1RgEoOvQZG5zsj3sfHhe?=
 =?us-ascii?Q?NQiNdN8Yr81vLx0Tn/SIatns6G8/vxAyEjgfv8he1VgVhEEiMdkEMd3qGgPC?=
 =?us-ascii?Q?BvzecilkSzywyFZxfhmwhZrygSaBE8Qe+TblWXfH8wGtoiMB4XG4MZqu97QQ?=
 =?us-ascii?Q?c4v/n3SGOPydxSPxcZSocuwmS4Q/OBhDU2fwJaLE2GDKIeigowPAC/JNRwqw?=
 =?us-ascii?Q?Nfa7NupqBt0ygfALuNqhQP5yAiFHpo50BzZk/IIOnIKcscX3ngqSLPT+GZFk?=
 =?us-ascii?Q?PHZvj7q4Ot3/qy2/hJ95wHqQlWdd7d2bG9xRtrs6Dt4XQK2+ZRW4XLGdz0gg?=
 =?us-ascii?Q?9U/TWwFsse2dflDSVKzcsEyjQKd28bMYUP91l6BduHJZgNze5DeGCmukh0BT?=
 =?us-ascii?Q?tbohb4vPgA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6ea06b-acdd-4f84-b1fd-08de5f2226f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:42.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkOTef/gYajIWJY//Edi6vJHpbGF/Hx/gjnBQ13eNSUPZh1WKtcH2Hnk36rudRyvFTfH+ubEZ6O+hgrRXxnJmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254727-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1572AF067
X-Rspamd-Action: no action

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 38f831da78de..2e822acc9782 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2007,6 +2007,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2056,6 +2058,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
+
 	return pkt_received;
 }
 
@@ -4037,9 +4043,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4089,6 +4092,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1


