Return-Path: <netdev+bounces-252285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APe0K4gGcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AFD65CD9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F47868B53A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B5744105A;
	Thu, 22 Jan 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RXjFUClQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464A43CEF4;
	Thu, 22 Jan 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079462; cv=fail; b=hUrZ1qgIF3+EqNVKOT1esQ7XtwUcNv0owdtORDRyJtcO4WGiR7IS/HkVNk5VyOrd8guLLGgrC9Wcnr970DRTpkGqQhPILyxCIAYNmDcsNqaraeA0tyum+ELvBAxNrzFRVmy6lCA0dIl+T+G29DhAYFmqm/z7C1LFPK4OKgcbEXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079462; c=relaxed/simple;
	bh=sVfqghP17ZiKYE9PpPjx61rzUBSSbS9E9h5FGLS8gbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qjlb9hKDusLM+jD0bqq6dfnVlzRloeX7/gpJIR1T+BIex4JIoLMGHMUMBrRpYsn0nYExtqpZuKs7v+KSgQhH8moxJ8sFTiGsW5tREst0wV3Zcq9zZgh3w9KLnd1bDwBMZtvHGx+4H60g1fttvx0nd5MuUVz7fXPILboJYH4xUAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RXjFUClQ; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAMJcScOvMT/qP/nQxeTgbRPteqxEL2NLxZKi4UBXnFGiS+miQBEn63RWPbqBEmSIVOyQhPeZ0iDftun8QuT0VC/u7WVMWi5Qak4kkWjbLLV/TwSAd44LzrGp7YUciJZN4HiNuacK1+ruFOEqju6Mfeedpa3jJrebuUUV9xYh3qQeqo856CJX4uC+QDq65yaWD0LOsjBnjAXPRYA3ZmniBDYVYrgbykGgUWKpSlXVX0h4LoN1iwLv4Xd3SJ8/o4iHYlGFxccCgCn5eXf+ttWAB7nezK8OrKpQfzwLC+do2kSBR4md07mykELNoizx0UrV/oJ0v3nLEfx6FkvIE34xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd4P7ZxYctpDdmM1dcVt7pvHcn5i5ElKe60umCQfiAc=;
 b=CZg+iIByA2rQTptbf5ER2/Nt5p0S3jk/qp/fpG4er/aEiyWUwl3CdN62fp+lmimHKMTcjbpjjibY+IFTwkEExn6MaexilAbOdUqg1hSDVIvWZ5XCbP9KWvSfFY68JXburTQSUXY72iSPTMfAeYLSZLIPwiGnP9oBvjlbJu5nxGH5Bl3Te8HLumjItnMEDOePkBWGcVFVCDbVLskaCty1WG3xaxfxfB4gijjCv5/uKPRzl/q22SVRozic5Y/ZANtZLj5/x7rBX/z/TK5JHi3dK6+sh84dCwmarnG4fzLMr5/hYLRlO4uxiAVPby7Bqbkmju3LTrOxpcE3BPk1gM/kLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd4P7ZxYctpDdmM1dcVt7pvHcn5i5ElKe60umCQfiAc=;
 b=RXjFUClQBhvb43v0YYklMuGp+AniY+CafWo03VqZfsRiIaePo5RUaz4Qb3/pqtZNHEkv3jwOy13AluS4QrG0TirFmuG82tWKkJ1CaGIOu3GSyofZsZKRMJ8LlDSsMDDJ1lbZDqsTA9Gyaoh/I/LXO8svWmB3JotE7erjS8Ie6IjXQRK6pNdJq/9rwJYwFjPxf8rFbeL6+kyKfZweIww+1EZ7re07y6bWetc4EAVGDtSUTbDFbW6cwlTZ6wtYd2dsoBY1yQAEqJPnpqA2pASBIo4C1p7KGmcTc3KKo6THPwGxX/ekzlDeCFr4f65aTfWg/eBUZd2V6pQbZ1m49vNMNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 net-next 12/15] net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
Date: Thu, 22 Jan 2026 12:56:51 +0200
Message-Id: <20260122105654.105600-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122105654.105600-1-vladimir.oltean@nxp.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: 94505272-e544-424c-78b2-08de59a50822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9FoS41f4LdRB638aPCSJdSnbILFXTJ1tdQVAhNdI2RdxCmEOhTXZIO38bKGk?=
 =?us-ascii?Q?AI8U3sCh0d13/uMBFfNtkrTxfdY8LxrRd+GdsWY/cGnZMwT0acv4qZREdC91?=
 =?us-ascii?Q?WvzceKxouH/b+78jn1PQaYqqI+R7PFiqNoQt3R3GtVQTbJEiqD76aOP+gGa8?=
 =?us-ascii?Q?bEZjlwBO0syA+dGWJLk0TLD9X8n7FV23FMeoKvEmzEYagExRYYlo8ul/U+ZD?=
 =?us-ascii?Q?gcx4niXLcQppHxmsfSxa1FyNJcPRAdbN+6ZzIeK3dKnXq9DFlI3cOUMQ9PXQ?=
 =?us-ascii?Q?riz6IZcUJif6wzYODuDGpSwWzFFP9UXv4ck0jqwQsEOA6BjSSIz/UXLogeD3?=
 =?us-ascii?Q?W8ladnwUqdz9LnN5ShJFHcK79AYn5D2W+SstSOVqlXkA0hLsnGs1VlA/WgXu?=
 =?us-ascii?Q?9B/SDe12T5mpMIDiFM977Y1tUee01LXWJyB4K+x6ZLDLxzgCCuofr7uNrBGQ?=
 =?us-ascii?Q?1ejyN82vD7AZVeYHpo6L1MoATrT/YW8tkxpYh7JK57wJ0cKSQfphGK0xgyNG?=
 =?us-ascii?Q?KqdqAZT7SWlnaIS01ehkd8WhM3cv8sWGzupE5hJPxamFzffTsyl/VLqFWRXZ?=
 =?us-ascii?Q?b13XPHJnzaSBvmSN93mC1RBGkDlFbA+Sf78L9q1LdYg7DcPr4IppI3hmyBdJ?=
 =?us-ascii?Q?ivSaU/0tcTXd1Rujsi7aU3/Rl+nUiYHVWxOqM628qJIp/Nj03F9vQh++hYs8?=
 =?us-ascii?Q?UPj3vk2hxiVgAF2JHM+EozFiN6oovNz8IDXTPtGWNirdBP2UwXE17eI/H9lN?=
 =?us-ascii?Q?caGH2oCVcqve6Vyh38gUN1I75AcKSRS02e5E4CYs+QV88m0hqt48wnqJs8hv?=
 =?us-ascii?Q?v4owpKLKJuAjg97SL65KxYseukEGebxm+19Aw9CEG6iAO8Ge90MEtCjXjh77?=
 =?us-ascii?Q?F/pcuuOEWYTiQCJyA9EG7sIgr4WcCndIzyQugrYLaMp1gwp93s7QYNJ+OIkO?=
 =?us-ascii?Q?+GKiIUqkprqRdQw6EaZ9KaWTkrVWccxIMyGEfiqanH40/2RmrJHuO4WHLmRy?=
 =?us-ascii?Q?EwhnuAIM7BS1PUvDq4BWGEHXV6cDrLq8RXy2n+Osu9qioZ9D7NZMQ7WIxh1o?=
 =?us-ascii?Q?9HhwAZjxz2MOi+I8G9xE+2VRxt30oVUOAGqQ2/T1/Q3AGNZ8y9fLHjc7LN+z?=
 =?us-ascii?Q?uq4rnexmKpGC+YmulJbTBR6Guot/WLXsej5uE7orcIiDgoK53Vvd9dWSZvNy?=
 =?us-ascii?Q?77Vok1lItMLYx9TLatwe1nPnsSIgK/BFRkyBK+o0Ed+ehJRIGQCm1z/C+DS3?=
 =?us-ascii?Q?bq2yzFbVkAGlaaJC6b4yU87/qdmFqae+dnmOVq0wFzipdYuiabZr1yuAiMh1?=
 =?us-ascii?Q?Op8YosxLTzL4gu25Qb8WwPtFmr1Yfd+eTTypqn6kkXl6aMGEsfaNK8FAFOWw?=
 =?us-ascii?Q?9a1bR/c22/h0KjmsVdPP4gbswtymqjO4bqI21nC8EioLl67hdSLOKA2d5lOI?=
 =?us-ascii?Q?dvBXeCVZqRCm2i6gG7tHdRDTNHc9iPL85hdFKRXndN3zm8WkwI7cvujcumMr?=
 =?us-ascii?Q?wskk7VYHvaWus4jjxluNiansvfXHZFF9UV3IOf2zwWIv674m2+0D5Ys3X307?=
 =?us-ascii?Q?B29ii4ugIyJf+6+rVm0QQRpn5VpxvtSHKRHCmhl/CUJVwNzS14HeWFJGVZ+T?=
 =?us-ascii?Q?WS23aeNigYytWuUeybY2QaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X91P1dfKqg+8Ilrjw7sRDR9MXITzheHhVMpDHiY87EW8Nzl+0hra954QwCPW?=
 =?us-ascii?Q?jHbCVQs47zpyqPwa8NVBI+boi5+zvM0iq8UbGvj34OV72JKsy1vTgXYg67vJ?=
 =?us-ascii?Q?4cntBQDXCQRIYwlYxS6DVFSBEGD5nH6bDnbWi+Lxef1/JBri/vGR1+Yfgpal?=
 =?us-ascii?Q?DIfEyfGeIo8uK6V/3guhMwnNguwbv28oIAgVyHX4/iwRU8wloSZp7FG/zyz6?=
 =?us-ascii?Q?eVdk5g5+SpzgOet0RC6FkLDMG5OYLwiq9gzexXT3wMUZ4RiXxH00M5Q7jxhn?=
 =?us-ascii?Q?L01VmmnmM4s2KHxeUfElrNPWQbuPOG//g3kwtZc08dCN5+Dc/9lGR2leeQX9?=
 =?us-ascii?Q?Ky+K/DRv1Jv/GezDT9bJUPCUm9i2vcDe0Shm/4I0cPhwI2xxIocwgLTQhSi/?=
 =?us-ascii?Q?0xUOz/+4O+GoVorHQkj8/BEQYS7KsO84tYhgtlWjzc3QLR0uZZFbDJOtTD04?=
 =?us-ascii?Q?kmeSvAyTb4GKBmg4lZK2rFAbM0wienH0QSzabQj3Xg90dGT+qy0/YBo5osO+?=
 =?us-ascii?Q?XCNtPyER6qPfJIcxjg5EoBSy6WwgmawoMdztgPyQ7Ri1UEywffl56YDZrVAx?=
 =?us-ascii?Q?orMhdk+919MchVKJQrROum2JnHGCDhFCi2cIJRwxdX8rjdlqxu9GQW5e6pc8?=
 =?us-ascii?Q?QixM/qXmEWBOT1ybgQqmQqTg+nrvfeMCTHlCUAOb8i1FjRYQoPXWkTOdz/F2?=
 =?us-ascii?Q?pJYe2PcOYlpouwvLNceD4QNRsviDCPk9j0jiauSrViqMx/NtaVSftyvSiQZN?=
 =?us-ascii?Q?fJaHSQIRqnoXGGgZPCpsCgK23rM4Bpo93iJNXFYc+GF7OipvGhGoOrD4aW15?=
 =?us-ascii?Q?XaTr1u4tbbT6GbFMp7+HZioc5wFJtp2OUNfq+JpjaFQHaujcdX6wp+Q3rvOa?=
 =?us-ascii?Q?pI6JOnM2mSPnaMDmhpc13/ts/m7thg7es1DBn3vkzRaJP8i/CIoJ5T2HLOsR?=
 =?us-ascii?Q?E2AkauWp913ebVGIZeOYgBlQcR7/sCA3qU4JS8mrDj2+O637QRZELARE2sJr?=
 =?us-ascii?Q?FxNNaIBmTFGmqNZl+mLSg5eaqril64uN4nxxO7Di6+awPsoPFHeuHniHDUMJ?=
 =?us-ascii?Q?7+hu4qHHZpDe+GDuH+qd4vMaZ6D9CfabqJZ6r1SgTgMbkfkl7ZhM6BHTWClQ?=
 =?us-ascii?Q?MnOoMRRpdnD9E90BVuOO1/hwk65SbLIhmNRCdTaE/RueWcsfXT3ETbzp6//D?=
 =?us-ascii?Q?aEfHSzy5N6ZnfuR4eH7W7Uw2czz2STv9JAMRjPStJIStoa7VRoE9G7trAJnk?=
 =?us-ascii?Q?833dWQrXJZ1GQr0fcpt+kawnaBnVFANka5wLndLp129t/N5U8az/U8GIwA5V?=
 =?us-ascii?Q?Agsia8B3KbsWsuMez5qx2xzlqGrCEgEjCjgik7roCcGXaR2rCA+vtK3iivq/?=
 =?us-ascii?Q?bWUpH16GzdWtFdnUwevK/44QjMuviaq9v7hapZFeTP6CEiOdYZI6vGNwv6Ko?=
 =?us-ascii?Q?qmgkrfC9clNvpU1HTUWGZLMlPnirxBZ+ADzJFScO9uZy+uF9QyyXPTLb61I7?=
 =?us-ascii?Q?mVL4ukzpZxNEVcp5YOsTSqiJCK8Ux7VZY0PHJ3wjvD2JXx7Kmr8VDpYfpTT3?=
 =?us-ascii?Q?NQxk2YUKDushlWgVUd5hpsVT5Plbc+M6XMVd2uBMB8BZhFBdsQN+TCtWmRYm?=
 =?us-ascii?Q?Yg70lTOzDdoNsjf7pU/VcbuuIQQm01JXAGuXdYgHGHjoKdZPGNGfwVhpzwlA?=
 =?us-ascii?Q?IR7/zcs78BGp5H/E5VmwQAI5GC4Sc3V0pScifAq6c5H7eSo8yEDbswBTVDGU?=
 =?us-ascii?Q?CMQfibpCkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94505272-e544-424c-78b2-08de59a50822
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:28.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecNyuN8AZ3i03iO0YYxK5iS0XNiodoRLBpUO0SVJl/HWaJJljNlWE32esKV3paJHl2J9acSHFuNP8ovE0SsWww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252285-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,bootlin.com:email,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 90AFD65CD9
X-Rspamd-Action: no action

The following switches supported by the driver have at least one XPCS
sub-device:
- "nxp,sja1105r"
- "nxp,sja1105s"
- "nxp,sja1110a"
- "nxp,sja1110b"
- "nxp,sja1110c"
- "nxp,sja1110d"

For these switches, it is guaranteed that the XPCS blocks is described
in the "regs" OF subnode of the switch, either manually by the board DT
author or by sja1105_fill_device_tree().

So we can write some custom "bus" code to probe platform devices for
each child OF node of "regs", and that completely replaces the need for
the code in sja1105_mdio.c.

There were discussions about how to instantiate the XPCS sub-devices and
the MFD maintainer doesn't consider mfd_add_devices() to be used
canonically for this use case:
https://lore.kernel.org/netdev/20260116132345.GA882947@google.com/

So I am rolling my own custom code on top of devm_of_subdev_add() ->
platform_device_register_full() that is also used for the MDIO
sub-devices, but this time, instead of manually picking the MDIO nodes
and registering them one by one, the PCS nodes (as well as anything
else under "regs") will be automatically be picked up by the new
devm_of_subdevs_populate() method. The critical difference is that the
XPCS device tree binding is sufficiently detailed to be able to extract
the address space resources from its "reg" properties, whereas the MDIO
nodes were not (and had to be manually associated with resources).

This of_subdev_* "bus" code lives in the sja1105 driver for lack of a
better home, but can easily be moved to a more generic location, and is
written to permit that.

A small implementation note: priv->pcs_fwnode[] exists because
currently, the of_changeset API doesn't support creating phandles.
Thus, instead of also filling in 'pcs-handle' properties from ports to
the dynamic 'ethernet-pcs' OF nodes, the driver just saves them for
later use in sja1105_create_pcs().

This implies that when the PCS nodes do exist in DT, priv->pcs_fwnode[]
will be NULL. This is fine - xpcs_create_fwnode() is NULL-tolerant via
fwnode_device_is_available(), and this case currently returns -ENODEV
and will be handled by the next change.

Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- mfd_add_devices() has been replaced with a completely new approach in
  the form of devm_of_subdevs_populate()

 drivers/net/dsa/sja1105/Makefile         |   1 -
 drivers/net/dsa/sja1105/sja1105.h        |  20 --
 drivers/net/dsa/sja1105/sja1105_main.c   |  53 +++--
 drivers/net/dsa/sja1105/sja1105_mdio.c   | 239 -----------------------
 drivers/net/dsa/sja1105/sja1105_spi.c    |  15 --
 drivers/net/dsa/sja1105/sja1105_subdev.c | 171 +++++++++++++++-
 6 files changed, 212 insertions(+), 287 deletions(-)
 delete mode 100644 drivers/net/dsa/sja1105/sja1105_mdio.c

diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
index 7b5537d67072..049d198f681e 100644
--- a/drivers/net/dsa/sja1105/Makefile
+++ b/drivers/net/dsa/sja1105/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
 sja1105-objs := \
     sja1105_spi.o \
     sja1105_main.o \
-    sja1105_mdio.o \
     sja1105_subdev.o \
     sja1105_flower.o \
     sja1105_ethtool.o \
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 1b52beba62d4..7fce1507eb12 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -91,11 +91,6 @@ struct sja1105_regs {
 	u64 rmii_ref_clk[SJA1105_MAX_NUM_PORTS];
 	u64 rmii_ext_tx_clk[SJA1105_MAX_NUM_PORTS];
 	u64 stats[__MAX_SJA1105_STATS_AREA][SJA1105_MAX_NUM_PORTS];
-	u64 pcs_base[SJA1105_MAX_NUM_PORTS];
-};
-
-struct sja1105_mdio_private {
-	struct sja1105_private *priv;
 };
 
 enum {
@@ -159,10 +154,6 @@ struct sja1105_info {
 	bool (*rxtstamp)(struct dsa_switch *ds, int port, struct sk_buff *skb);
 	void (*txtstamp)(struct dsa_switch *ds, int port, struct sk_buff *skb);
 	int (*clocking_setup)(struct sja1105_private *priv);
-	int (*pcs_mdio_read_c45)(struct mii_bus *bus, int phy, int mmd,
-				 int reg);
-	int (*pcs_mdio_write_c45)(struct mii_bus *bus, int phy, int mmd,
-				  int reg, u16 val);
 	int (*disable_microcontroller)(struct sja1105_private *priv);
 	const char *name;
 	bool supports_mii[SJA1105_MAX_NUM_PORTS];
@@ -285,7 +276,6 @@ struct sja1105_private {
 	struct mutex dynamic_config_lock;
 	struct devlink_region **regions;
 	struct sja1105_cbs_entry *cbs;
-	struct mii_bus *mdio_pcs;
 	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
 	struct fwnode_handle *pcs_fwnode[SJA1105_MAX_NUM_PORTS];
 	struct of_changeset of_cs;
@@ -316,16 +306,6 @@ int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
 			   struct netlink_ext_ack *extack);
 void sja1105_frame_memory_partitioning(struct sja1105_private *priv);
 
-/* From sja1105_mdio.c */
-int sja1105_mdiobus_register(struct dsa_switch *ds);
-void sja1105_mdiobus_unregister(struct dsa_switch *ds);
-int sja1105_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg);
-int sja1105_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
-			       u16 val);
-int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg);
-int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
-			       u16 val);
-
 /* From sja1105_devlink.c */
 int sja1105_devlink_setup(struct dsa_switch *ds);
 void sja1105_devlink_teardown(struct dsa_switch *ds);
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 84c0f7c676e2..b60a890ba416 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/netdev_features.h>
 #include <linux/netdevice.h>
 #include <linux/if_bridge.h>
@@ -3005,6 +3006,44 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int sja1105_create_pcs(struct dsa_switch *ds, int port)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct phylink_pcs *pcs;
+
+	if (priv->phy_mode[port] != PHY_INTERFACE_MODE_SGMII &&
+	    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
+		return 0;
+
+	pcs = xpcs_create_pcs_fwnode(priv->pcs_fwnode[port]);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
+
+	priv->pcs[port] = pcs;
+
+	return 0;
+}
+
+static void sja1105_destroy_pcs(struct dsa_switch *ds, int port)
+{
+	struct sja1105_private *priv = ds->priv;
+
+	if (priv->pcs[port]) {
+		xpcs_destroy_pcs(priv->pcs[port]);
+		priv->pcs[port] = NULL;
+	}
+}
+
+static int sja1105_port_setup(struct dsa_switch *ds, int port)
+{
+	return sja1105_create_pcs(ds, port);
+}
+
+static void sja1105_port_teardown(struct dsa_switch *ds, int port)
+{
+	sja1105_destroy_pcs(ds, port);
+}
+
 /* The programming model for the SJA1105 switch is "all-at-once" via static
  * configuration tables. Some of these can be dynamically modified at runtime,
  * but not the xMII mode parameters table.
@@ -3059,16 +3098,9 @@ static int sja1105_setup(struct dsa_switch *ds)
 		goto out_flower_teardown;
 	}
 
-	rc = sja1105_mdiobus_register(ds);
-	if (rc < 0) {
-		dev_err(ds->dev, "Failed to register MDIO bus: %pe\n",
-			ERR_PTR(rc));
-		goto out_ptp_clock_unregister;
-	}
-
 	rc = sja1105_devlink_setup(ds);
 	if (rc < 0)
-		goto out_mdiobus_unregister;
+		goto out_ptp_clock_unregister;
 
 	rtnl_lock();
 	rc = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
@@ -3098,8 +3130,6 @@ static int sja1105_setup(struct dsa_switch *ds)
 
 out_devlink_teardown:
 	sja1105_devlink_teardown(ds);
-out_mdiobus_unregister:
-	sja1105_mdiobus_unregister(ds);
 out_ptp_clock_unregister:
 	sja1105_ptp_clock_unregister(ds);
 out_flower_teardown:
@@ -3120,7 +3150,6 @@ static void sja1105_teardown(struct dsa_switch *ds)
 	rtnl_unlock();
 
 	sja1105_devlink_teardown(ds);
-	sja1105_mdiobus_unregister(ds);
 	sja1105_ptp_clock_unregister(ds);
 	sja1105_flower_teardown(ds);
 	sja1105_tas_teardown(ds);
@@ -3139,6 +3168,8 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.connect_tag_protocol	= sja1105_connect_tag_protocol,
 	.setup			= sja1105_setup,
 	.teardown		= sja1105_teardown,
+	.port_setup		= sja1105_port_setup,
+	.port_teardown		= sja1105_port_teardown,
 	.set_ageing_time	= sja1105_set_ageing_time,
 	.port_change_mtu	= sja1105_change_mtu,
 	.port_max_mtu		= sja1105_get_max_mtu,
diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
deleted file mode 100644
index b803ce71f5cc..000000000000
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ /dev/null
@@ -1,239 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright 2021 NXP
- */
-#include <linux/pcs/pcs-xpcs.h>
-#include <linux/of_mdio.h>
-#include "sja1105.h"
-
-#define SJA1110_PCS_BANK_REG		SJA1110_SPI_ADDR(0x3fc)
-
-int sja1105_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = (mmd << 16) | reg;
-
-	if (mmd != MDIO_MMD_VEND1 && mmd != MDIO_MMD_VEND2)
-		return 0xffff;
-
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID1)
-		return NXP_SJA1105_XPCS_ID >> 16;
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID2)
-		return NXP_SJA1105_XPCS_ID & GENMASK(15, 0);
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-int sja1105_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd,
-			       int reg, u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-
-	addr = (mmd << 16) | reg;
-	tmp = val;
-
-	if (mmd != MDIO_MMD_VEND1 && mmd != MDIO_MMD_VEND2)
-		return -EINVAL;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, addr, &tmp, NULL);
-}
-
-int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	int offset, bank;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	if (regs->pcs_base[phy] == SJA1105_RSV_ADDR)
-		return -ENODEV;
-
-	addr = (mmd << 16) | reg;
-
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID1)
-		return NXP_SJA1110_XPCS_ID >> 16;
-	if (mmd == MDIO_MMD_VEND2 && (reg & GENMASK(15, 0)) == MII_PHYSID2)
-		return NXP_SJA1110_XPCS_ID & GENMASK(15, 0);
-
-	bank = addr >> 8;
-	offset = addr & GENMASK(7, 0);
-
-	/* This addressing scheme reserves register 0xff for the bank address
-	 * register, so that can never be addressed.
-	 */
-	if (WARN_ON(offset == 0xff))
-		return -ENODEV;
-
-	tmp = bank;
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE,
-			      regs->pcs_base[phy] + SJA1110_PCS_BANK_REG,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, regs->pcs_base[phy] + offset,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
-			       u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	int offset, bank;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	if (regs->pcs_base[phy] == SJA1105_RSV_ADDR)
-		return -ENODEV;
-
-	addr = (mmd << 16) | reg;
-
-	bank = addr >> 8;
-	offset = addr & GENMASK(7, 0);
-
-	/* This addressing scheme reserves register 0xff for the bank address
-	 * register, so that can never be addressed.
-	 */
-	if (WARN_ON(offset == 0xff))
-		return -ENODEV;
-
-	tmp = bank;
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE,
-			      regs->pcs_base[phy] + SJA1110_PCS_BANK_REG,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	tmp = val;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, regs->pcs_base[phy] + offset,
-				&tmp, NULL);
-}
-
-static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
-{
-	struct sja1105_mdio_private *mdio_priv;
-	struct dsa_switch *ds = priv->ds;
-	struct mii_bus *bus;
-	int rc = 0;
-	int port;
-
-	if (!priv->info->pcs_mdio_read_c45 || !priv->info->pcs_mdio_write_c45)
-		return 0;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "SJA1105 PCS MDIO bus";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-pcs",
-		 dev_name(ds->dev));
-	bus->read_c45 = priv->info->pcs_mdio_read_c45;
-	bus->write_c45 = priv->info->pcs_mdio_write_c45;
-	bus->parent = ds->dev;
-	/* There is no PHY on this MDIO bus => mask out all PHY addresses
-	 * from auto probing.
-	 */
-	bus->phy_mask = ~0;
-	mdio_priv = bus->priv;
-	mdio_priv->priv = priv;
-
-	rc = mdiobus_register(bus);
-	if (rc) {
-		mdiobus_free(bus);
-		return rc;
-	}
-
-	for (port = 0; port < ds->num_ports; port++) {
-		struct phylink_pcs *pcs;
-
-		if (dsa_is_unused_port(ds, port))
-			continue;
-
-		if (priv->phy_mode[port] != PHY_INTERFACE_MODE_SGMII &&
-		    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
-			continue;
-
-		pcs = xpcs_create_pcs_mdiodev(bus, port);
-		if (IS_ERR(pcs)) {
-			rc = PTR_ERR(pcs);
-			goto out_pcs_free;
-		}
-
-		priv->pcs[port] = pcs;
-	}
-
-	priv->mdio_pcs = bus;
-
-	return 0;
-
-out_pcs_free:
-	for (port = 0; port < ds->num_ports; port++) {
-		if (priv->pcs[port]) {
-			xpcs_destroy_pcs(priv->pcs[port]);
-			priv->pcs[port] = NULL;
-		}
-	}
-
-	mdiobus_unregister(bus);
-	mdiobus_free(bus);
-
-	return rc;
-}
-
-static void sja1105_mdiobus_pcs_unregister(struct sja1105_private *priv)
-{
-	struct dsa_switch *ds = priv->ds;
-	int port;
-
-	if (!priv->mdio_pcs)
-		return;
-
-	for (port = 0; port < ds->num_ports; port++) {
-		if (priv->pcs[port]) {
-			xpcs_destroy_pcs(priv->pcs[port]);
-			priv->pcs[port] = NULL;
-		}
-	}
-
-	mdiobus_unregister(priv->mdio_pcs);
-	mdiobus_free(priv->mdio_pcs);
-	priv->mdio_pcs = NULL;
-}
-
-int sja1105_mdiobus_register(struct dsa_switch *ds)
-{
-	struct sja1105_private *priv = ds->priv;
-
-	return sja1105_mdiobus_pcs_register(priv);
-}
-
-void sja1105_mdiobus_unregister(struct dsa_switch *ds)
-{
-	struct sja1105_private *priv = ds->priv;
-
-	sja1105_mdiobus_pcs_unregister(priv);
-}
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 4d4da69b3c30..27cac00eba32 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -615,9 +615,6 @@ static const struct sja1105_regs sja1110_regs = {
 	.ptpclkrate = SJA1110_SPI_ADDR(0x74),
 	.ptpclkcorp = SJA1110_SPI_ADDR(0x80),
 	.ptpsyncts = SJA1110_SPI_ADDR(0x84),
-	.pcs_base = {SJA1105_RSV_ADDR, 0x1c1400, 0x1c1800, 0x1c1c00, 0x1c2000,
-		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
-		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR},
 };
 
 /* See port compatibility matrix in Documentation/networking/dsa/sja1105.rst */
@@ -791,8 +788,6 @@ const struct sja1105_info sja1105r_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1105_rxtstamp,
 	.clocking_setup		= sja1105_clocking_setup,
-	.pcs_mdio_read_c45	= sja1105_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1105_pcs_mdio_write_c45,
 	.regs			= &sja1105pqrs_regs,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
@@ -830,8 +825,6 @@ const struct sja1105_info sja1105s_info = {
 	.ptp_cmd_packing	= sja1105pqrs_ptp_cmd_packing,
 	.rxtstamp		= sja1105_rxtstamp,
 	.clocking_setup		= sja1105_clocking_setup,
-	.pcs_mdio_read_c45	= sja1105_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1105_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 3,
@@ -871,8 +864,6 @@ const struct sja1105_info sja1110a_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -924,8 +915,6 @@ const struct sja1105_info sja1110b_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -977,8 +966,6 @@ const struct sja1105_info sja1110c_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
@@ -1030,8 +1017,6 @@ const struct sja1105_info sja1110d_info = {
 	.rxtstamp		= sja1110_rxtstamp,
 	.txtstamp		= sja1110_txtstamp,
 	.disable_microcontroller = sja1110_disable_microcontroller,
-	.pcs_mdio_read_c45	= sja1110_pcs_mdio_read_c45,
-	.pcs_mdio_write_c45	= sja1110_pcs_mdio_write_c45,
 	.port_speed		= {
 		[SJA1105_SPEED_AUTO] = 0,
 		[SJA1105_SPEED_10MBPS] = 4,
diff --git a/drivers/net/dsa/sja1105/sja1105_subdev.c b/drivers/net/dsa/sja1105/sja1105_subdev.c
index 085d77947dc3..5ca613a4549d 100644
--- a/drivers/net/dsa/sja1105/sja1105_subdev.c
+++ b/drivers/net/dsa/sja1105/sja1105_subdev.c
@@ -78,6 +78,167 @@ static int devm_of_subdev_add(const struct platform_device_info *pdevinfo)
 	return devm_add_action_or_reset(parent, of_subdev_del, pdev);
 }
 
+static int of_subdev_collect_resources(struct device *parent, struct device_node *np,
+				       size_t address_cells, size_t size_cells,
+				       struct resource **res, size_t *num_res)
+{
+	size_t reg_len;
+	u32 *reg;
+	int err;
+
+	err = of_property_count_u32_elems(np, "reg");
+	if (!err)
+		err = -EINVAL;
+	if (err < 0) {
+		dev_err(parent, "Failed to read subdev %pOF \"reg\" property: %pe\n",
+			np, ERR_PTR(err));
+		return err;
+	}
+	reg_len = err;
+
+	if (reg_len % (address_cells + size_cells)) {
+		dev_err(parent, "Invalid \"reg\" specifier for %pOF\n", np);
+		return -EINVAL;
+	}
+
+	*num_res = reg_len / (address_cells + size_cells);
+	*res = kcalloc(*num_res, sizeof(**res), GFP_KERNEL);
+	if (!*res)
+		return -ENOMEM;
+
+	reg = kcalloc(reg_len, sizeof(*reg), GFP_KERNEL);
+	if (!reg) {
+		kfree(*res);
+		return -ENOMEM;
+	}
+
+	err = of_property_read_u32_array(np, "reg", reg, reg_len);
+	if (err) {
+		kfree(reg);
+		kfree(*res);
+		return err;
+	}
+
+	for (int cur_res = 0; cur_res < *num_res; cur_res++) {
+		int idx, address_cell, size_cell;
+		phys_addr_t start = 0, size = 0;
+
+		for (address_cell = 0; address_cell < address_cells; address_cell++) {
+			idx = cur_res * (address_cells + size_cells) + address_cell;
+			start = (unsigned long long)start << 32 | reg[idx];
+		}
+		for (size_cell = 0; size_cell < size_cells; size_cell++) {
+			idx = cur_res * (address_cells + size_cells) + address_cells + size_cell;
+			size = (unsigned long long)size << 32 | reg[idx];
+		}
+
+		(*res)[cur_res].start = start;
+		(*res)[cur_res].end = start + size - 1;
+		(*res)[cur_res].flags = IORESOURCE_REG;
+		of_property_read_string_index(np, "reg-names", cur_res, &(*res)[cur_res].name);
+	}
+
+	return 0;
+}
+
+/* Custom version of of_device_make_bus_id() which derives the name from the
+ * parent device plus the subdev name and untranslatable address.
+ * We don't set the resource address in the platform ID because that would
+ * print it as decimal rather than hex.
+ */
+static void of_subdev_make_bus_id(char *name, size_t name_len,
+				  const struct device *parent,
+				  struct device_node *child,
+				  const struct resource *res)
+{
+	if (res)
+		snprintf(name, name_len, "%s.%llx.%pOFn", dev_name(parent),
+			 (unsigned long long)res->start, child);
+	else
+		snprintf(name, name_len, "%s.%pOFn", dev_name(parent), child);
+}
+
+/**
+ * devm_of_subdevs_populate() - Populate platform sub-devices from device tree
+ * @parent: Parent device for all created sub-devices
+ * @np: Device tree node containing child nodes to be converted to sub-devices
+ *
+ * The device tree node @np describes the (MMIO-like but untranslatable) linear
+ * address space of device @parent, as can sometimes be found when such device
+ * is accessed through a SPI-to-AHB bridge.
+ *
+ * This function parses the device tree node @np and creates platform devices
+ * for each available child node. It reads the #address-cells and #size-cells
+ * properties to properly parse the "reg" properties of child nodes.
+ *
+ * For each child node, the function:
+ * - Creates a platform device with a name based on the parent and child node
+ * - Auto-detects and attaches resources to sub-devices based on parsed device
+ *   tree "reg" and "reg-names" properties
+ * - Uses the first resource's start address as the platform device ID
+ * - Registers the device with automatic cleanup via devres
+ *
+ * This is similar to of_platform_populate() except it expects to find
+ * IORESOURCE_REG resources rather than IORESOURCE_MEM/IORESOURCE_IO.
+ * It is also similar to mfd_add_devices() except we don't have to specify the
+ * mfd_cells[], but rather, the resources are embedded into the device tree.
+ * More importantly, this allows for the parent to have a hybrid function
+ * (MFD parent + the main function of the device) and a custom device tree
+ * binding, whereas MFD does not.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int devm_of_subdevs_populate(struct device *parent, struct device_node *np)
+{
+	u32 address_cells, size_cells;
+	int err;
+
+	err = of_property_read_u32(np, "#address-cells", &address_cells);
+	if (err)
+		return err;
+
+	err = of_property_read_u32(np, "#size-cells", &size_cells);
+	if (err)
+		return err;
+
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) ?
+	    (address_cells > 2 || size_cells > 2) :
+	    (address_cells > 1 || size_cells > 1)) {
+		dev_err(parent, "Subdev address space exceeds phys_addr_t possibilities\n");
+		return -EINVAL;
+	}
+
+	for_each_available_child_of_node_scoped(np, child) {
+		struct platform_device_info subdev;
+		struct resource *res;
+		size_t num_res;
+		char name[64];
+
+		err = of_subdev_collect_resources(parent, child, address_cells,
+						  size_cells, &res, &num_res);
+		if (err)
+			return err;
+
+		of_subdev_make_bus_id(name, sizeof(name), parent, child,
+				      num_res ? &res[0] : NULL);
+		subdev = (struct platform_device_info) {
+			.parent = parent,
+			.fwnode = of_fwnode_handle(child),
+			.name = name,
+			.id = PLATFORM_DEVID_NONE,
+			.res = res,
+			.num_res = num_res,
+		};
+
+		err = devm_of_subdev_add(&subdev);
+		kfree(res);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int devm_sja1105_add_mdio_subdev(struct device *parent,
 					struct device_node *np,
 					const struct resource *res,
@@ -139,9 +300,17 @@ static int devm_sja1105_add_mdio_subdevs(struct dsa_switch *ds,
 int devm_sja1105_add_subdevs(struct dsa_switch *ds)
 {
 	struct device_node *switch_node = dev_of_node(ds->dev);
-	struct device_node *mdio_node;
+	struct device_node *regs_node, *mdio_node;
 	int rc = 0;
 
+	regs_node = of_get_available_child_by_name(switch_node, "regs");
+	if (regs_node) {
+		rc = devm_of_subdevs_populate(ds->dev, regs_node);
+		of_node_put(regs_node);
+		if (rc)
+			return rc;
+	}
+
 	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
 	if (mdio_node) {
 		rc = devm_sja1105_add_mdio_subdevs(ds, mdio_node);
-- 
2.34.1


