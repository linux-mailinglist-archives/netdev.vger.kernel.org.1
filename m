Return-Path: <netdev+bounces-257065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBzJKjRdhGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:04:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B9F0413
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54829302DE3F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B049238F93D;
	Thu,  5 Feb 2026 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CantAfNf"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3A374160;
	Thu,  5 Feb 2026 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281839; cv=fail; b=GQfXLZROoEn2+or3l3VeXP3jS+Qa4P9zs/x5tji55SmmY6/FJl2xcssC+bE/jqjCB3SMVua9TmHpoM3VNWvRkaIhcnxgcyu+QFNj0v79whMsHACcAeSZxTnS2Q/Qw/saSBJ4KeB0vgauHhHAIrJzhdoNbzIJS6bQVrgdgUfmKTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281839; c=relaxed/simple;
	bh=7baunNL7EIZn1O7CQG9FxPXcmpHyCeXiNzLgU7yx58Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPo86g+LF8d4E80Tc8VtsWeCAJMk9SxkY/lGk8bLYr0R5Tesz5HjFWS4198qbBiK0eJfzb6aeLaifvfG4rUN+ZTy3Me9mRvHtg811N821gRU/3C9JsaRP0gqDMtbLHiKG1Uui5Ss2cP6YHl8V6oRULkKNNyQMRW5YtBDkTD/0jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CantAfNf; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMEddDPSo6K+iorBYN5h+7M5KB+fXLerDbbEO9idelEz3n/x/u8tznSnROQUBUzY2n/FTedRrJ7L6Ht9HNABu9p+jiHGql+m4NDn7d2n1okgIZBPrXtdgfCyec2cgDUUTsEqpXm794J6dH7Msi4HMk2dtlWJ3dr0XBpCuFzs/x+4lsVedpGIbyKgGOXWCBDmB3nav3NkTjqNYIuDBcS+8L/BvtNRTClE32Y8Rz/zwvNy88c/UOSrDcJe0tf3aLlsnIMnmnlmlE0DO1ksAThswxYvlBVMSrsLv2QgsquMEmGZCeCmFTKhp/ExGFOCedffAyrMo/Z+AAfES/dYq5RmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxItYxZN2WyrVH2MaRMG5cxpd5c+hogKvy3nRQfvtx0=;
 b=eHLqhh0bDQu96ZRkiFNYYr41+nOFyoGlDTgahETTRJW9T/vXa6G/XBFP0UIi1Ot63kr6pXSFH3DS+R9ur7rIQqkvnGwLR5KOTK+SU5C/vmjwyAI/ATMSkUbuaas6g+GPMksAwoxA3kdB5myw4Nwv0irsuZy4s/KWCQszK5w8qS64clMGYxaJxtEIckfn1+wLtjHfkBBd+nHhrRJFUKKc9KAopQpr7Lg1wdFC3+uDJub0fT8Z7F8zzjArLk6a70j1XmGXtEI41XOuGCxK9SxT+G6Zrw56tLcALc5stmavHfLxHm3DkR4mopDP6icJPbtYI/OnqDdPSn02sCfnCd4YqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxItYxZN2WyrVH2MaRMG5cxpd5c+hogKvy3nRQfvtx0=;
 b=CantAfNfvmtFpZWXvcqBlxMyRjh7NVmEJv/KJPfOpqfIF+prWNsuTvdLgXwFQS2QNyy/vq+/nMgls9+Ev4TcaYUaJOopd7c6kxbIaKHwq+AXlGjgI6eKIRHGwESaT7UrkeIg681ooB590EFg5LjpconwzK4MQpQJKjtoTMSag8CllKNZtSdW8cm5xJw263cnizAfb8cBRytko2GpEVS/jHQwkLhMIcAVphtRjbXREs07mzWipm7iRdnWNsSoV19JntgTMzQCfNWvUv/6s32gnAPoFknUWAvQmR6vSDCVWU99yW63Io4hHtwGG3uDizWgRGdmeRDqMlmo5I7O4olXnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:57:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:57:15 +0000
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
Subject: [PATCH v7 net-next 12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Thu,  5 Feb 2026 16:57:39 +0800
Message-Id: <20260205085742.2685134-13-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8a87a8-bc0c-4fb7-e980-08de64948f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uiJoSA6tBlxhGfgjcbRvH+qdQBdyoQmwUFz/ZQoaBhmz1hTQzX0sNxuozqP9?=
 =?us-ascii?Q?kLO8RssJWG8uSyRzSNecILVz9xTqr0MEqkta6diMzmMwRIT12RYFWZ20INGt?=
 =?us-ascii?Q?QkgiVIOl8MH27TAFRbDt018C5zEL3tB9RG89XfuTPvTLiVQP1p7yG2GoAy5d?=
 =?us-ascii?Q?DvOKKhJmlK83uSxAOuN0GyGtFHaKdWR9vh7QQVyQOTMdaxdhvxyBm3OC9FjZ?=
 =?us-ascii?Q?GlyvVs9JLNm1vhpWRoIWbBlyWayNf+o45PRpY6Q/19DYJ9tsmmevKJUV8b8m?=
 =?us-ascii?Q?9yJxu3qgq42AuURZgA85S3pMoK5SogTzUI5oskeJBG5E1Lbm+w0jXuiZ4eTu?=
 =?us-ascii?Q?/GRz/KGAJ9htlD3vzV5GgmftGoCaqbXIuXwOwgHP7A2Grm2k0jdXvcdQJces?=
 =?us-ascii?Q?PNIeKmVhrXF5zxr945EXL36S5LtnHqAGk7W4zPN6mJacRUG/onnRFyc6qCdX?=
 =?us-ascii?Q?kBaAQe0k9Dv3v46WOKBy72AWJCjGQPKOEegZMEPc4wUnmDYYNPIxDu+MF3j4?=
 =?us-ascii?Q?OlXVRC6adIU6SYZ/wCedX+PPco2l6EUNNSiEDvqDFwes78TQikifvP8JPgRY?=
 =?us-ascii?Q?Ss2bnq12jCLbOWcHLoIXnptiY7mCSeJpQV7vJyIiVwHYOr/PltCvz2JTQifj?=
 =?us-ascii?Q?m1ImOL9YNWG2nEIna+DYow5voNpJO2/FEwzkSf5hOoty1P4Y7j4+PRBQLhZE?=
 =?us-ascii?Q?YXaicy/78hl0bxbZWSYMBmj3/SZLwEg6m038Bayqs7s+tAeisk8YCna1a8pv?=
 =?us-ascii?Q?5FkBgj8B2BtUyw1pZ5q/g9E9gg9PeiIDYrOFbDsyUe4kE3ObfCoWdE89tosH?=
 =?us-ascii?Q?E9V4Uyd4o7XYBr/0hroOwF7hDD5Dqh17NCuXmRZ4VPa/z/yq9mr6oXeYgcbQ?=
 =?us-ascii?Q?nzww9VuHj7awg0nSZuVSGbLrocpcbDKJj0junCQvmlRscLGFjyXu8NVi2DFO?=
 =?us-ascii?Q?vZKiS4oy19rQIOCJQ67bXIJNPV1bNraVx3sFtIyO1mmBvnmdy92Xy2rykr3R?=
 =?us-ascii?Q?ggSkGlijjzMaCUQj0iW1mJooTiPgyU6cKvqfEUZIsWDza7hOTjSko0Vat5ON?=
 =?us-ascii?Q?VrmM6pJ/If7jCO9bnXk61eBePUbJ5ZHV+6jcXEK/40JSsWXza36I31XBHbWZ?=
 =?us-ascii?Q?uSOrHam6aLiEJnpN6VpPGna4EM+jTzdEpLN12KEiOPpzY+hwXs8w+xkbDKED?=
 =?us-ascii?Q?TT/IKPW0bGKLMWRTB7Cyw2GehWNUB0nPSgz2hZpS9fJbhsRgGnR4BjzejB04?=
 =?us-ascii?Q?+kDcxXtce3uPJeSTFrAVZwWScZ1aRDZAfOADO+sC/rXVhzOq+GMxaWdBBWPX?=
 =?us-ascii?Q?htjYDLZyi5CawJ8g/vYimyiqVhg0KXSlfXGvUdgxceptIZXbSzEnYVcQBakO?=
 =?us-ascii?Q?UxhAz0cnudXSJEg0RyV6d4MPF/d+YH9SEB1RpM7D66JHUBg5I/+LsuEtyEyX?=
 =?us-ascii?Q?9c6rxE1E7seuqnpAIQ1qYco7LUa1eWs/tHY7X4Q7A6snof6hbCfAQHhVGWlY?=
 =?us-ascii?Q?7Rrt4+s0pgxqLBCuDgNfMG3pKVbcktoHvDItE98+Uv2hDmuOE6OTcwR9ShJS?=
 =?us-ascii?Q?XazXbtQiW+Aq7LIr9QITpBhT4vRquKjfgrKaBtnrZ/2KqQp5S3LWI00KNcg/?=
 =?us-ascii?Q?H6h+GSYfDnwsqpKlcp0P1rr7Wr+Pb8Owg4YnPIhHaUr5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8Z3Rg8VqZeRkd/Q/mlCnnPq7A+9RSpGm+fspuMCMSrg/Ray0ToOx21EDlWu?=
 =?us-ascii?Q?Vbt48hUZVOOSfGaPVsV67hxvmGHOvfXmCWJigTgHE+7JopJcawBlXeHSQmmd?=
 =?us-ascii?Q?bX7QNSJzI2cL9AsfbjFIB7XML9oVyLMkJGIcUBRQL4ip4l1AqmFaCFhgJt2t?=
 =?us-ascii?Q?TA7c5GzfO3wk9PqXJDJE+ZttjIMqfPeVcII15qDmegKk3iqTf+UhbRo5NO1Y?=
 =?us-ascii?Q?myRs0IV8cJrIVuFwj0wMzD7h9Sp8iv+karApZugF9CQi/OzKXunpSpspYkI4?=
 =?us-ascii?Q?fk00dNvJqIFU5to/oqPyhL5tcCEU3+tiGICixJXcU9emip5UPiSrthZUfJya?=
 =?us-ascii?Q?gSh/fT3YVTqbMu55rZTeegZF9otMAKHJEIYifaCDUC4H1YRZ+bLtMmR+XrUp?=
 =?us-ascii?Q?wiyd9uEeEwkbFzooUdQSPtnKry6c7vDEkmAGXxPqVA7/MIUvfBnH5snuBEnX?=
 =?us-ascii?Q?jWqSgTPHmMTtg59qdEyCpir1JmPrxrONFT3GG0jwFUTrOTa0IlRNvBg26GPu?=
 =?us-ascii?Q?gk60/zWvvH5z0X6pG28bYPv2KNjpNiO0ifCPNZclP4g76ESxZpSv5lyBN1Nb?=
 =?us-ascii?Q?PNY7vo4Cjq8ytkwp/eIUq6JKe0eKFcVYJs+gY6Sl56MX3tk/vIhofNvvy6qe?=
 =?us-ascii?Q?eMb6WOWdUPxr0eQGbIJqV22HWe9CTSc4NB4KvcWpAHF+6fkuadt+xZU4u/ii?=
 =?us-ascii?Q?Bj4a3zOlDmSCl3bqbIXkBpL1ICIVJjoi0Lvq/xIdp74rRC/jzyzHv6AtipZa?=
 =?us-ascii?Q?Hboh2RQco8HXiFcoLpsX2/EhXhkdJkGsR5vvw0wJD71oldGb0JW7U2HDekGS?=
 =?us-ascii?Q?yxWsp76ctnM2vSkvFfDKyNkxdtMllY5Mrg3kG2gPN2LMM0jrCmf+YJPTsFzu?=
 =?us-ascii?Q?e9wp7+fhhK7foSEmHxjX1/EgA4+8TMp096cLcEc+yXfEXZCX0KizQgniOzuX?=
 =?us-ascii?Q?VxYbWt578Utw0uyj7asDoarfAQr3Amzq6o6XQgMGxAmH3x/FzGz65o7PAmPc?=
 =?us-ascii?Q?fMAgEkYpIJ7/Y7bqLcKPa/iow6jmS7NzIslpCJhYkuyFLAhdtXHr8pP8cnrI?=
 =?us-ascii?Q?iN/kx4UbCinznhzZI5yBgpdsmNy/gqrfzA7bqmDaOEF1I+3VKRou1rK32Rgn?=
 =?us-ascii?Q?zHaXnk7wmKu1hYFm2EkOGxPrlAjciAtzVxUNjEXKy77Ch4/V65meOM3c4Fkd?=
 =?us-ascii?Q?WU2BLGZQtvxG3swSZQ3PtFFKSwZwuCmeKZUbjBEnVuu3/WOfJu+KZzQWgg4j?=
 =?us-ascii?Q?8NDLJb7IzY8LrgjfY2TewtK1Pyy4H1chzCAsWDthOaaJPfNjKMHCGvvk0QdC?=
 =?us-ascii?Q?K2O7NmnUCC4eT2XijAXnAJDVb4fPWCoK/isthTM2MQgdlFWMU2ptgRy/z6zs?=
 =?us-ascii?Q?kwipLjeOAG4k4OMFoK7Ju8UnOBWZ5tsbaCoTETPD/ihGt294+mPIy+AmHnmb?=
 =?us-ascii?Q?a9aBM83NUrtxhiSiFiEc0HlF6QK64PA289VCHNoRJdjJrmRdARWmEJDMX4jQ?=
 =?us-ascii?Q?mnofKaZT9YwnADQKX69/sUG5/EO/vgzqiqlar1z/MhHUZFv9BEc4cORc37rx?=
 =?us-ascii?Q?s6B3UK5LsA3iE1TXEs2RomMcFgHoFUy1hJJYY0bRYpxSd9dOu8xDc1AaCFLN?=
 =?us-ascii?Q?9e0BItX2d/PWYlUZkBgcZJxoPMIQKE3fYORAXxJkC2ao+2AWZriDajAsgURf?=
 =?us-ascii?Q?0IOmivaAzrolPLvA1TWG94rMeCxcgUVWY8NvsUf7Sf9TKOtDHFh+VtLsPGsr?=
 =?us-ascii?Q?U0/1kJJj8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8a87a8-bc0c-4fb7-e980-08de64948f5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:57:15.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8a401LODVwMDTc4DR5mcb51nmEFpgdKaYb4a7dy0EKLtM/gisqF5SSVrSUJfxEC9DnjiEfbndIp41XNKwSMQ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257065-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 884B9F0413
X-Rspamd-Action: no action

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d7a92ff25cfe..312d9b87e615 100644
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
@@ -3420,6 +3404,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
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
@@ -3431,6 +3447,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
+
+		fec_xdp_rxq_info_unreg(rxq);
+
 		for (i = 0; i < rxq->bd.ring_size; i++)
 			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
 						false);
@@ -3438,8 +3457,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
 
-		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
-			xdp_rxq_info_unreg(&rxq->xdp_rxq);
 		page_pool_destroy(rxq->page_pool);
 		rxq->page_pool = NULL;
 	}
@@ -3594,6 +3611,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
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


