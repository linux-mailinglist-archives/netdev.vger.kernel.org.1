Return-Path: <netdev+bounces-295694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eelYO+t7ImocYQEAu9opvQ
	(envelope-from <netdev+bounces-295694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF56646071
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=JYTCZtev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295694-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 129493099F64
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B047D938;
	Fri,  5 Jun 2026 07:24:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEC478842;
	Fri,  5 Jun 2026 07:24:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644256; cv=fail; b=LCZ/LZXArxHQ2fsQPEOcyVWC9jomnvYeIq7fVLEDGQOZXahnyggozOlJ5wgFj5QGPvW0oCvSjOPJ/LICe+3eND2ACHkui6K1j/swngJ+6x2yWH1ZNKo04GjDemv9EnAsLbCjR7lVHJQTde90IuBxr6SUuHgXHCbs2JSJxHVTVbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644256; c=relaxed/simple;
	bh=ckl+oYCgIHoDzIZpu4nMfCRfQfi/F7Sa1kaxctMVKvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjYAs3Ai/iyz9NH3RHfu187nX+cDI5G+55xBkRSVy5S4jtYJfMMtiAwzLAZfdjHtOc3Q1qPZLeovknu1TMy2Dr2vOaS8bVMa1q85oDyeeMMdFbVosac0IPMRnHecABm49II3OSMalpL17nk88lBkrioTGfdRtCkRYvJJVU3luSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JYTCZtev; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIjDHx24EoiOjHYvZbP+z0TduRH0a9t42QfQbLE+eLCI+sVWOmwwbN2M3qrUI6rGZldcxPmjuPpR4P8ueNC5KE9xbHHIenCM4hCLPBVIo8uoLtoxZqAfi/lPZ40lZsYBpWrltHzX7lzc/duQPsgYCf/lPX7EIofKJDp+ONy6uVghsXXdfXOcXTFhUAcQqMtWjqrdDp/wRH2XfRoCuoAZXZOSh7S+Mb69P4rXujDsBmoaMqgQbzHozgLjrBx8ywuLsz7+Q/gmSSZMenOwO85f74CuY0vUL0VqL0YDGRRIlqqimauO81NcIL7g/R0zgs1yHSJakjjmdqG96Ou9kQ1okQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0UTfPREncnjtEMgWUMGZYDqzTlqtxc/Gzw9JDzqo4s=;
 b=tdgbQ9GSK+VmkN3bDw/qAzWDCzivC/7L67Ei3G61lsJYW/VHZvtc/qrwYyJzDxGpk4CFnm7Ii/GqmPTh6QO9/312ywrz9HliPJ2QzthHOERGecFOfeF1hNuybxXRYU99nMzuaH3KVYHk/ZlRCLFopZAuUk2RPqRejJ5WPnvDtOQFrl0verQYBf6uKeH644dcEEZ40Ebxs4qgObWtG94JuUsxdWb5yIa+Fg1/md5yj7h+oLH0tYyJToEtuDJFwgZ/fZ2nbF5pCwuYXfof8qRqwFBKxmIg7KgbwN984enKgROg02GOKkEGhH6zGmUzP7H/fqig+MhacRE5fuPyidMKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0UTfPREncnjtEMgWUMGZYDqzTlqtxc/Gzw9JDzqo4s=;
 b=JYTCZtev7OSX4ykh2B4lBQprIfkR6iUSJL+X9DOWjrwQe2NRszrljiKmDLcpJMvVxOVfuB3ncaMbC84AfxK9VKj79uM3l2o8RTFJ9uZN09B7DcD4bzjH0LLpOyNV3xg95+74JW+w7wgpKTc3dVO+SccUL2QL0+a+IHL9wlK7zVs3U4hy9FLFTckLEooDRcEOmY3bPUFy0mkofy9QyuEeRECkKvBQQxDlu93nfiJw0qxkdXHePzsb38URSiNaAGLVG8L06RITlNgxxcDqsjJUf1f4NLrXMNrE8O7MVK9dBLyZ//QdTe+QiB6YkZLmkW5VKDNg0y30fpIwZPZ3J6+hvg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:24:11 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:24:11 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/15] net: enetc: add VF support for i.MX94 and i.MX95
Date: Fri,  5 Jun 2026 14:55:47 +0800
Message-Id: <20260605065550.3038579-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e0c715-a7ec-4d1b-89a1-08dec2d37042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PhBYZmWl7UOP4M9e8XkdDqtR/4slbWceHxNE6ZIvIsRA0nKWzbSUywNgm5hbuK14AzZJ2ocrY1SlGBeGzwnL23xzRuAkHdaWBA68YcwxmeaPM/i9vdTRvUvqxqJhl7ff/if0ejitJA3aP4DM4yBXG8IOY0Hl/QTWh1k8ok+fCJcK1rpyfexpvU1G+15dPlHp38ny4N1LUG5mVq7bdjn9XcXUwazF15ET/rSPLcGs1PVtJzMlkMJ8i9ZI7DkUv0zIZ3BFO5ny/Sy+Pb7xzPEX0ksMQoGeB2eHqNeaEGKM//w6CPuQG4IR2WX1ImelvbLkoV+Dt8fEkv6V1vi/HvC9H3JZCm2I4mVkP6Rj/HsZARM40BRHPRyZZb7NEZeStWcaG6pA0j2i4VRqbLQBHVKhU2Rvp3/NWokoWhX3dZfOkJmuljvDYGxKkhH2w/whMP/W07ekt0yCeLFRFzx8jF+EjCLF2ZUCQbt1w9+A8uKkrQSNoKZ81UQjNltFe01ImIp/NvQEqSynQKrRO9LiXCRyfWnhRGZYHFz+9FU1jHWJTbKuQD78PgCFKEGMg9Kkn2Z9HKtfYl/egTYNYCzyLiyieOkn5fB4j/h2ACG46WYOkt66sbvTjHUsuyeZ/rQRPPfgJBuepITq9iU5ZkA82Okd/gi7KoMkpdYni0eLuh1NpbmT26lyF9rfvbSSDbdqL6nFqte2/YyNcJg77KgN2FAUwdws4iGLyTuhJlaWkksz/NU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIqqOVjGVMDFTx3Rn70lHKDSO2yLdMXa/a+/9I6up9ozRa1OXiLPdS8AuUxe?=
 =?us-ascii?Q?ddb2WSowMMEQxTEja/QhJvSB/VvNGvTK5JOAGq6QKdng0ehjRW8Jjg4aXDP7?=
 =?us-ascii?Q?W3EYwQV0uaAks5d+uT2iSgQr3bRDZJ0vAQp5k7mdG3+GMsbHMWnnTiT/zLSt?=
 =?us-ascii?Q?xCLug4aeitXQCs3N03pAJQ2wiLHm1qQcNr2D2J5okDzhlRgKHs/ld3QwjALa?=
 =?us-ascii?Q?urT4e4M9jL2OGe/I4VjnsvBlLd5xsknB5vNxzKXzSX5TDTGgRA8EZ2f+RU+W?=
 =?us-ascii?Q?eg+HYR9A7LjjFJ4rLUGc/lc8OY+B9NrQJCdCo2wXrmXxynt672MVqkydwuNK?=
 =?us-ascii?Q?hnfOr6YgwhCSaR7tNbcspMzs/tN6CSeQzR9n96DTntQZPPy+GCdO1M6l5mm+?=
 =?us-ascii?Q?x1FlrI2uoMlLeqm/tiviWVHT5yqU39rs5zZ/9EVMP5WkZ0k1r+xnirv56bMh?=
 =?us-ascii?Q?G3nAzEkf2g7aonNKP51b7zmm/IhQeaqnNUvBTaSyWN1svy9NQcfx4ifi/qqP?=
 =?us-ascii?Q?4n7QImi53Q8PYLH/wXbB41QvIAEKL2Zzu13Cvgv1wH4/hiSxm1mc3glCWO1t?=
 =?us-ascii?Q?9J3emkCACBGFCMhH4LP7YzEPQA7y3fyL2sI1NbwRvksdBH/REpKZsaTaFHxM?=
 =?us-ascii?Q?WwrJGgX76yccBHc4/oit09VNyyBbWUZQofHsGfTICrg+AbnXQKLKEItdXPxD?=
 =?us-ascii?Q?vn+q00QtIgQB2y60eHczchb7IDmSefTuMae/OJ8BZqhHnGindUnKHwXmIkJn?=
 =?us-ascii?Q?eUcH/6K+uIIYsgAvtAURuH6+VY90rBQtzgHD4XIc8JoH7lsY63PwrS3KvHmr?=
 =?us-ascii?Q?0lzLrZCHxsAMIy8CHI9BdJwcR3uzJnVD1WpUGp7JiPRcuEVEz2jbb0q6GVZE?=
 =?us-ascii?Q?Ho7JbQOiv2et2tHSW0u12nG4mzh8oHIdjWtTo+ye4BUKiu4WLhXvLf3sdjMj?=
 =?us-ascii?Q?Bm8xdrBhW/bwi2MYkachvV1784Hw2eLj/tObD51IL1w1rGA6g8BSz5taLDE9?=
 =?us-ascii?Q?o2Qq2V66GTtVg+9G7y87UaZVAjBi9+jOs7IV7KL9XsKCenElUtaStMVXbOlk?=
 =?us-ascii?Q?nGAfnDB3OBrKEQbCbxQ9nD/VxWv0pUCIm5sm5wJySK+Y/MELxNZFqc3UYCSD?=
 =?us-ascii?Q?/NmqVsuhX9PUenbTc/1HDOYBxQbODQp10uI69Ax08ppquXtGtJHKYdMyJYWy?=
 =?us-ascii?Q?UPqMw95hk88XcX1gGiSydDeKQ632MnGLFyxB1jla19yrzkRRaicnIha+jvGa?=
 =?us-ascii?Q?e2O+XqFnCQ/mjTjw5/UeH9kMJsauC/RUp56Llao1iGn3fzKet5FoXMDqjXhc?=
 =?us-ascii?Q?3oAeZPL42xfsqAk1xhxY3mKJlVd7yFpw5czhrGmp7S3gAeizWs16wUzjJ2ji?=
 =?us-ascii?Q?YEe6t+2RygpUt+r2plCZ+A5K2diuPjciUtpAqGKzj/t9hPXK2YEjV4GxvwwO?=
 =?us-ascii?Q?WwwT6g7sYp/ZZX9zogItC8VePIEDsn9uop3OCtrwVWf3A1igVmLBzim0xSpK?=
 =?us-ascii?Q?z04pebYJY8cwLZWR4IQkP27o1drer0VY5OEwGXZS5RjI9dEea6oF3a27pflR?=
 =?us-ascii?Q?xj6Uf6+18C6a5ww6u9jyy9G4SAqVeOuLSBC6FUbTJ+Wuy/tqdV/e/ptp4kwk?=
 =?us-ascii?Q?3oMkRTeVKBUrtDmqrn504Czo87z3VnMyK71E0JZ94go67ov3RomYtDDzdxKd?=
 =?us-ascii?Q?HnOLoFkk833NTOkmXlFtzt6qmk04dJR7WGXAF1YG6wrFVG466FkiZ1wmAFHN?=
 =?us-ascii?Q?+PToZ/00ko8FIdFx40G+5L09Fj2N8B5KpI0/XSe4qXjoP7JgZhir?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e0c715-a7ec-4d1b-89a1-08dec2d37042
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:24:11.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dDwQyHifklPf2Wrovbc4miFfBdYgLrVcIWVmKLmERhY19uYI2ZP8O5hUulH5bQPANKJv0eE5l2dk+8d7YhWfcYwemQcjqg8dfD3v/ftpGD1/kV8ARfJE8Ytdae72Xj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295694-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EF56646071

From: Wei Fang <wei.fang@nxp.com>

This patch adds VF support for i.MX94 and i.MX95 platforms.  Compared to
the LS1028A ENETC, the VF device ID has been updated to 0xef00.

On i.MX95 (v4.1), each ENETC instance supports 2 VFs.

The i.MX94 (v4.3) has two types of ENETC with different VF capabilities:
 - standalone ENETC (same as i.MX95): does not support VFs
 - internal ENETC connected to the CPU port of NETC switch: supports 3
   VFs

The driver is updated to recognize these SoC-specific VF capabilities
and handle each ENETC instance accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 15 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 10 +++++++++-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  6 ++++++
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 20 ++++++++++++++++++-
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index db5c17a44613..f425f82a6213 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -69,6 +69,7 @@ config FSL_ENETC_VF
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
+	select NXP_NTMP
 	select PHYLINK
 	select DIMLIB
 	select CRC_ITU_T
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aa8a87124b10..fdceaf36daa7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3745,6 +3745,13 @@ static const struct enetc_drvdata enetc_vf_data = {
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_vf_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc_vf_ethtool_ops,
+};
+
 static const struct enetc_platform_info enetc_info[] = {
 	{ .revision = ENETC_REV_1_0,
 	  .dev_id = ENETC_DEV_ID_PF,
@@ -3758,6 +3765,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = ENETC_DEV_ID_VF,
 	  .data = &enetc_vf_data,
 	},
+	{ .revision = ENETC_REV_4_1,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 	{
 	  .revision = ENETC_REV_4_3,
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
@@ -3767,6 +3778,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PF_DEV_ID,
 	  .data = &enetc4_pf_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..7595c7d80d0d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,7 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 #define NXP_ENETC_PPM_DEV_ID		0xe110
+#define NXP_ENETC_VF_DEV_ID		0xef00
 
 /**********************Station interface registers************************/
 /* Station interface LSO segmentation flag mask register 0/1 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 15c8b704b2b7..868ed694e120 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -314,11 +314,15 @@ static const struct enetc_pf_ops enetc4_pf_ops = {
 static int enetc4_pf_struct_init(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
 
 	pf->si = si;
-	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
 	pf->ops = &enetc4_pf_ops;
 
+	err = enetc_init_sriov_resources(pf);
+	if (err)
+		return err;
+
 	enetc4_get_port_caps(pf);
 	enetc4_get_psi_hw_features(si);
 
@@ -1208,6 +1212,9 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	if (pf->num_vfs)
+		enetc_sriov_configure(pdev, 0);
+
 	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
@@ -1225,6 +1232,7 @@ static struct pci_driver enetc4_pf_driver = {
 	.id_table = enetc4_pf_id_table,
 	.probe = enetc4_pf_probe,
 	.remove = enetc4_pf_remove,
+	.sriov_configure = enetc_sriov_configure,
 };
 module_pci_driver(enetc4_pf_driver);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..246852e453a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -859,6 +859,9 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i, j;
 
+	if (!is_enetc_rev1(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_GRXCLSRLCNT:
 		/* total number of entries */
@@ -903,6 +906,9 @@ static int enetc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err;
 
+	if (!is_enetc_rev1(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		if (rxnfc->fs.location >= priv->si->num_fs_entries)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..9b16226602aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -281,6 +281,12 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->features |= NETIF_F_RXHASH;
 	}
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
@@ -292,6 +298,13 @@ static const struct enetc_si_ops enetc_vsi_ops = {
 	.teardown_cbdr = enetc_teardown_cbdr,
 };
 
+static const struct enetc_si_ops enetc4_vsi_ops = {
+	.get_rss_table = enetc4_get_rss_table,
+	.set_rss_table = enetc4_set_rss_table,
+	.setup_cbdr = enetc4_setup_cbdr,
+	.teardown_cbdr = enetc4_teardown_cbdr,
+};
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -307,7 +320,11 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	si = pci_get_drvdata(pdev);
 	enetc_vf_get_revision(si);
-	si->ops = &enetc_vsi_ops;
+	if (is_enetc_rev1(si))
+		si->ops = &enetc_vsi_ops;
+	else
+		si->ops = &enetc4_vsi_ops;
+
 	err = enetc_get_driver_data(si);
 	if (err) {
 		dev_err_probe(&pdev->dev, err,
@@ -402,6 +419,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_vf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_VF) },
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_VF_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_vf_id_table);
-- 
2.34.1


