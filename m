Return-Path: <netdev+bounces-286645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEX/LLvQAWrbkAEAu9opvQ
	(envelope-from <netdev+bounces-286645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641F50E39B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BA9330010D0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7E3A382F;
	Mon, 11 May 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBQUG3xA"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C338377553;
	Mon, 11 May 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503865; cv=fail; b=hVYM97ahIJ43j8H9soCpD8W3qgE4u1l/f0QPwZ1pZXPVjim7U96m86a0bl02smIF3eglnLF+nTtuTVADeTWz57hdTwaPpqJN4ynOvVWlAyBWacWECCQe2TsiRynkgmdPw/byeT4/F3ihOBCW/E48Q51mLre9ecW9IOriD1tYimg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503865; c=relaxed/simple;
	bh=5y3lzHRt05tEUBjQlZNX9QUTTaIv5BkliLHN8vpjEXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2HuDL3ccYROlLxyxYOAEORODvVmD/DaMv2OqsiLQUg91YddyKZtbOBheWamdItBtI0rdLGvO5bQ8hbpaXJcg2/0FHxztjtVA6YRl2NeQ/jGL7J1fULMnbCbfhl4MI3xirbv7HC8IbkZz7Ywu7MFFZ4PZGrPqkESFToYkyQ81wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBQUG3xA; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqqFyej1NW/yib/19ch1iwvutljtOKGn9byKpwBy/aQEI5z7V+l43/0rTvlYSUsE3hkPuHxop9rDnhMDeKCExukliGZJugu9bSU7kchzaS8Rv5NI58EKnA2M3FFv0g9PGtP5I9nUrZWZgUlPtSQHKtYCrufI4gSNL6SzZDy0gEz5eX2Mv59y/HG7tZmiZyKWGcdq1XUYkYc9OcvP6Enp72Dk4Bgwxl2Sgxcdps7ExYtL6EUdoFXuRdn4VUEUkbDFxpYilRP9BJp5l4dbpwBEbsVpBQIxdVxZX4TApHUGurNUpm8c3f9HkcSnk7xvQVoRv4EoET4cEsXWBkbhvxIQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNH8C5+7tOQxdAAZ6NTB7EyYpIAICvt/J0Rvst60lSE=;
 b=E4xXIN//yWb2SVAwebfH2tIOcxkel/u0tc5kMtH70K/JwNVx7eJWzL/c2VXgYm822RtCRB2tRL46XnsmE0EjASYdgu+XUnbZY9zNehiqfPTvoZso+gvOgzRDoEDLsQaK3//eaftF+Zay/U2ZCFNmeTWDtKU0E1/tG+jD+rJcuVObuE7Fu+WyOihz3vuF8iKn0IbEWivfMZNOgXF6g4RUUa3uvzp7rHn1O7GHypHkXKW09xXRoAVdbLDo7BydsHsroN+NE1ri6jLYjMFn7+ooUH9cdeYNwIfhsEXyAbkGmx3HBA/GQRT0vWvk5bgols75bjvy307ZcCAW9jCjD4ZFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNH8C5+7tOQxdAAZ6NTB7EyYpIAICvt/J0Rvst60lSE=;
 b=gBQUG3xAcbzgTw036USBo9EiKWLsRbymkgHK5LNmeK2PmEDJPmazuKlzs5rmb5WbL+vRTarnpB9jewnPR+Glt3blijA0tAWf8NM3jgFKdgEDao6O2r34h6SfWf/FDCPR2YszMkNYEre94gZxzk2BRhRlrnw9Ig8TevMk3h+SPHKAxfSKBJ/xrwsIWw+7Ylg9fckalbuPeXO4bvFMR09VghBrSmi3Q2VMOXKDrZBMc1ixz/R26kzZGp9Ho37viM6+0BGUK1nTHBjhi9OPdO4WGRIK5j9lqpV1ofp63x78pnBtStEsT2//Zk33FjfMY8530xJgnZ5yetQCjK4p6WPmrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9646.eurprd04.prod.outlook.com (2603:10a6:10:30a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 12:50:58 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 12:50:58 +0000
Date: Mon, 11 May 2026 15:50:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Message-ID: <20260511125053.xgzqic62zhhdjyn5@skbuf>
References: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511112438.4fxvhelf242emzft@skbuf>
 <f0fdea25-6b2d-4b64-b925-a3f30c8e044c@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0fdea25-6b2d-4b64-b925-a3f30c8e044c@solid-run.com>
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5a6d92-81d5-4c2d-bcc6-08deaf5bf2a6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|19092799006|11063799003|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
 CzJu/bxZgM8UDsww5CkPWcDZ5HcVngSmRMfScpEsSxQcrmWGHZZUVSFyMtyY+zy6hmZj3pwBCc8cDtREtbOEzx83z+3v+98KwMAVVz1sRtRR0qFTDjJDwlmaIP9AittndKKjdy6UZpktJXwIUCPoBRY9QdcOnYN9QFD1koSObWtXF6zlAIpEi7/drNRAVI5zwSanVuWt9HfxIwodkOIhXIG3aQveT4YKouENOGvsQkllKBqSb6y3TadrU5FxbJCjziIDmz7do1g1usIfHRmpL+I4xSKVihC3VgRCQpdWAJRrVlvoGhkqcI0mlNRn3q/Vm06iL7XEZXyAVPObGEYXy75/rokhSaewF3+3oZJnoooxDvCZRR3LmyKA6SZOOM3AsXxcIoOiunPP7naSxiyW2ejTC0Fdjjt69yuFjY/0odAKiONebVUwkfGp7X7UXrhi28J1/SBwrPAFJBADGbpuUKE2sAEri8bANfvYrwHuGQ4ITyEqGLgSxO68lcAQN5YBd70T2J+j9X/pPINCly9dw2kNyg9DJVoRI2atMxsM4uOxzTCDNqpvRuj+0CY+KLAY9XFCDoIEm+3v0K0G1u9lc52NO4ecN3hXBRxGpRTk2AJUxfiPrsgVuxQ/kMRF+S6TkDn61+KII8wtOunlNXDLNq4AJv5/9+iiRoGjSz19v0zFRRGuXfXrlEOJxWeFGo15
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(19092799006)(11063799003)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NM9A1a63lomkvlsrU/qi5RoI5ojLJpC0FivAqKiYMmNTXpOPlVtkT47FPVb4?=
 =?us-ascii?Q?UzExAVyj9nK1LU3/p9WNecjQ1H4xTqotm0D3j2o8iYuRznpnPRhFxJibw0Y/?=
 =?us-ascii?Q?9uH4K/D/LIrdlnTR8goUl+2lKSqsYn72w5YqyjqNjjq1o0lHBVRoiyJjzjmN?=
 =?us-ascii?Q?Huz0lE+GaSauIpnSpJRFNngE68ap74Ur2roEyRE87JjHlpHDZqOKcEboo+QU?=
 =?us-ascii?Q?IVU0tmw/5bfOlrYP9TibsIee43ebYuM8mKy1LPJGjv25v00OFfEOVu8Mwl0R?=
 =?us-ascii?Q?aRtB+3dMg4FDh/sJ4Pu+J1q25uVI8u7/Bj/5Bih4e3PoDG/gA2RMsjqQKW0e?=
 =?us-ascii?Q?sF4ue/SJwnrtumiZIX3ITkMTZfVLy4C/V/Y4Hsag+4LAexvwxRPWn0woJzJi?=
 =?us-ascii?Q?Jn4vEG/QqyGzB3fjXFjXI4CrDYYxGBQJLcBpVBeRLNMehJZBzSxR2jW4ktNT?=
 =?us-ascii?Q?ZDrDV4IqEA0VjhYCNRqrvGbJBHjySe0K8EX20Q/1wAC7EJP34jxvmDYxajyr?=
 =?us-ascii?Q?19g+usHbauf7G8cF7xEf37UxmTrr2Jva1Q04I3rr9hTA34i4xOvy4a0eOodS?=
 =?us-ascii?Q?E2hV+UiMDn9f4iXcYCiezn7LYQnzAveBRH37T7zK2aaIi6pqGruzsm6um+QZ?=
 =?us-ascii?Q?e/3CKAeBo2Gr+4vDU+UU4B6nXERtDgZWAWj60M13aCKSDpzesmDN0jzg7+12?=
 =?us-ascii?Q?i2GzBaDQEU3ifzCb58ShKTv0Y+Ohk7rPBoNGa2Oyse8lfLXroe3WpbJanS6l?=
 =?us-ascii?Q?AuWb0L6ux6M1DPnlJL1ty4G7+fVlADK0MCQP+Igbm9pTNNxNqYrENWiykh5r?=
 =?us-ascii?Q?ZUHWfhyfChW55RzYOPUuU71iu+B5GcEjMNdN3IhJDrpUR7tYS8IDA+Uu0630?=
 =?us-ascii?Q?U0s+I0GtXydGe6pzEVxHknS/sc/4u29bkk8BY4/c5pguURj/8WrpMIMX42if?=
 =?us-ascii?Q?NurarRz2NqKAXFwaKx61UN3/Q2/9DH7sCNa2RgeeGbre0JqOFrpR1BaiWI9V?=
 =?us-ascii?Q?2IGQafTzNpUqglhxkSyPjV8Vvo9j9pCWwov4Si6cWdtg2If4XHwdMow1LIeD?=
 =?us-ascii?Q?Wkxvidfx0KZC8YBJO+DHwjXyagaFYaVIn/K1U+Dgv1FDcvR/JsD0MGh77YVa?=
 =?us-ascii?Q?fhdAg7rKVrG1XWg6nMJ5Pi7Hd76F9TuvrebHQKDZSRsTxm0qj1i8aEnKaZIj?=
 =?us-ascii?Q?is3dF5WBGi5nxk3NRBwH2hanPQWiDGUm9wUKbsNYZ+T+8iTXrXdSx0Xq1ZpD?=
 =?us-ascii?Q?+bb2TsSbJGJnPqnYAOvf6SPqxwnvR2x3xMRCfPtw/Eu2gWWnalbZbdQv0Wew?=
 =?us-ascii?Q?v6LZUXOBOldsHCDxAb5nBXETVIG8+zGk5hn38I1IZ5p2BuazC8NiJEAOMNNe?=
 =?us-ascii?Q?nZEHJY5I8iO/m7JcoY2bSyO3gMC//c7UFAcfuKCHdFRWpR7kXoJ2QN3UzcPM?=
 =?us-ascii?Q?CqUEHDOgbKSRWn0U9OgVMabLbpDoS0K2ZXXFSQxks1mep1IkUvJ9h/SfH4Mh?=
 =?us-ascii?Q?oCf+dFVNBqKGjVk5A0MKFFaANZjFceeMc8RlVSPPBb7fz129ikL9U+TfZGU7?=
 =?us-ascii?Q?3d0ZMiXq4SU2XoFePMKB6Ulw270suWVLnuQZA2krxLnjOWAi/dhytPee/cIP?=
 =?us-ascii?Q?NVDyHBdZsGkKV6U9LeZqZbGcNoEnrOwqz/43vsuADOZB8hjYNBlxwnYMVtXX?=
 =?us-ascii?Q?a8l1gYI1orjEcK0bxIk+Cbb1S/U5l/ENOQx0DFO4vybiFSNazWvd6rXdHpc/?=
 =?us-ascii?Q?mpwom3gKmtckCaVKarCBlCv2fWHOS1QRp++l//kw7CLPgpY0DBU5LcicRRgs?=
X-MS-Exchange-AntiSpam-MessageData-1: Z9LN23+HzOF0cXQJOoJJkbmojUzQV19aRFs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5a6d92-81d5-4c2d-bcc6-08deaf5bf2a6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:50:58.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niRrvrxzOika5EOtvT8M2xQiR1wpKHThAuchkfwLFwHz/nqvffnWt5pxXFuwaPYWGY11AET8tl1iVKBmej3Tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9646
X-Rspamd-Queue-Id: 5641F50E39B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	TAGGED_FROM(0.00)[bounces-286645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,n:email,0.0.0.1:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:30:35PM +0000, Josua Mayer wrote:
> I had the reverse understanding, the switch port specifies rgmii-id,
> and the cpu port specifies "rgmii".
> 
> The switch port has mode rgmii-id, indicating that someone should add delays.

Yes, but my understanding is that it is out of scope for the phy-mode = "rgmii-id"
to decide who. It just means that there are no PCB delays.

> It is a fixed link without PHY, so switch must add the delays.

This is an obsolete interpretation of phy-mode. sja1105_parse_rgmii_delays()
explains that in the new interpretation, 'rgmii' or 'rgmii-id' doesn't
indicate anything. The switch inserts the delays because of the
"rx-internal-delay-ps" and "tx-internal-delay-ps" properties.

> From the cpu (eqos) perspcetive it is also a fixed link without phy,
> so I specify rgmii indicating nobody should add delays.
> 
> Is this correct?

My understanding may be wrong, but I directly quote:
- If the PCB does not add these delays via extra long traces,
  'rgmii-id' should be used. Here, 'id' refers to 'internal delay',
  where either the MAC or PHY adds the delay.
- When the PCB does not implement the delays, the MAC or PHY must.
  As such, this is software configuration, and so not described in
  Device Tree.

> >
> >> +	pinctrl-0 = <&eqos_pins>;
> >> +	pinctrl-names = "default";
> >> +	status = "okay";
> >> +
> >> +	fixed-link {
> >> +		full-duplex;
> >> +		speed = <1000>;
> >> +	};
> >> +};
> >> +
> >> +&lpspi0 {
> >> +	cs-gpios = <&lsio_gpio1 8 GPIO_ACTIVE_LOW>, <&lsio_gpio1 7 GPIO_ACTIVE_LOW>;
> >> +	pinctrl-0 = <&lpspi0_pins>, <&switch_pins>;
> >> +	pinctrl-names = "default";
> >> +	status = "okay";
> >> +
> >> +	ethernet-switch@0 {
> >> +		compatible = "nxp,sja1110a";
> >> +		reg = <0>;
> >> +		reset-gpios = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> >> +		spi-max-frequency = <4000000>;
> >> +
> >> +		ethernet-ports {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +
> >> +			/* 100Base-TX on connector J26 */
> >> +			port@1 {
> > Some people might prefer seeing ethernet-port@N instead of port@N, to
> > fully avoid confusion with dtschema/schemas/graph.yaml (although, the
> > container node being ethernet-ports now, the confusion should be
> > avoidable).
> >
> > Also, if you ever perform device tree fixups from the bootloader (like
> > for setting status = "disabled" to status = "okay" for the ports that go
> > to addon boards), please never hardcode fixup paths,
> 
> I was expecting device-tree overlays to be used, in which case aliases
> are not needed.

Ok, what do you need for device tree overlays to reference these nodes?
Don't you need a label for them to appear in /__symbols__? Or do you
reference by "&{/absolute/path}" (still bad)?

> > but always use eth
> > aliases to get to them.
> However if it is okay to add eth[0-9]+ aliases also for switch ports, I'll add them.

Absolutely ok.

> > This is in case the port node names ever change,
> > to avoid bootloader regressions.
> Good point!

I don't think there's any downside to adding aliases, so please do, in
case anyone needs them, they should be there.

