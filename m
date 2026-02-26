Return-Path: <netdev+bounces-261399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOSfC8BpoGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:41:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8371A8F75
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D56831286A0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B83ED121;
	Thu, 26 Feb 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h9zmMPOH"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334C3D6470;
	Thu, 26 Feb 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119284; cv=fail; b=C5UiLyglA04NbUdpGvhlUG7M1nprLEh0m9qVUWBkEgLLmMXRifqzm4lAzOez4soBObGcIvYxjyqCKRUzla0+xs4uhLFLfXudsgDch4ctuaoRdWh5H0Z5hP0N0IX0SUT3NBL+3o7j+ygPGUQcLGpMAlFgFnYesJOaOyjU0X/EHqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119284; c=relaxed/simple;
	bh=MD6jkIcz5Osrw+SEoNIZqUv71CRIslDz6T/cXBSV8zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RMZ98n5InhKLhXHr7mbbZwoQtCxIxwVXKPpU+38O9P3uYie0efOw0ZjIBkLfj8WB4c0hXKknSDu+viaPKy/PWXnsEp85FaerLy+TmgZ55bUFhCLbn2DbLUW0ldVZz+102SZac7pmp9O+QMuFQWtHQ+5kZNvF0TZZRrcu5yYzF0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h9zmMPOH; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkh2UB5ry4tesRCkvlkZu8gcdWi6lEJ3BgFBYYrjRUuLaVDYEv5EHoetkzD2jFaMBFPHs3CQ72gDL0YNBhi2nIuk95YgNYMJFTYfFWwo9xBEiFz1M3poXl8f0yFxf+Xl6uRA0Gug+p3UpE5BrshxJSdLd1mfz7TPU4dVleBUrBot+iJUB91gFn4F1j1Y9sES9Ok8F8/Ajh6mtQQwvSv46L7phlcMsuHYl9h7nllHbdogcIHQzpwLEQUKmPNZyNW3Ii8WcZHnWIlnYR6IlVdGXIWJ1S0EgvY27HN38Yz29FCG1vEqhaz2bICarVP3+CK2rCIIT6qvBaZrCWpRAT+7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4wCEKw0Nt9I7N3arAqX3iSp8OwAWsyE+JK61yKbXB4=;
 b=oj3sglAqfi1xps/5TDNujClGRxhsTmznfi17r/zRHlzvVGvB5lKFobg75H07SLK5DemuS9RHfkm1C1BmbyanEJXF9t8PVkhukh6PTkFqaEkvL2HYDwabM/jxsvy2/Ci2OhjKpHB7ZIgNN5ZlXvRoPs5cd3wSg/be8dJkOHW2oRQy0CBFabZP7HPZm9rBCBpxmYCcn5v6kTOTn5iMhmLKiEqma3S2h5euMpcttktz2dDdKsT6+Vu/nhqmVLFk4/zfHdQRN2/5pFLy1gyznkvSaWvgtJf06bJXvDoHvw7fpOJ9jGOxg+DTsg+hinUfkRu5AhFvXqi7jTGGGXJl/LePlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4wCEKw0Nt9I7N3arAqX3iSp8OwAWsyE+JK61yKbXB4=;
 b=h9zmMPOH7ro/CT7af2u9Xoay1fcQKmDd3trEPBmnj8y8wHBeVq2iAuqnBJiWR2q8VImnIKiWhMks60WUl3W7O2Ryf37X9TLHCNZ3K2DxPmvmXjbcy8Hx4WafjU7+j9a+gfZQ/ZXbyQcmevdYwkjau1NrGpeHNNock1huxblbyCCH7KyivLnUMKHb/5Wkh9pFwFoDLzbo5hEYW+zTMVx7T4f4DEzgqmA4M7EJ0YRQffIVvXfUxGwArqMea7WXQ9bgehloz1wgLUMyHZA+uB7mkvhsSQRPRKOpr6FN7cEeXTjsbVdNDGnKN7Y9TWg7Q/Nj2WhbuzSQC37CC1aLJzs99A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 15:21:19 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:21:19 +0000
Date: Thu, 26 Feb 2026 17:21:15 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20260226152115.pwizozoapudgvmgl@skbuf>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com>
 <20260226151036.x4z4bdlxwgsqlkhs@skbuf>
 <CAMuHMdXKbiKUkP=+FDA_-Kd_qx1X6vzSuyPU+Tdd9MgR=Q5WMw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXKbiKUkP=+FDA_-Kd_qx1X6vzSuyPU+Tdd9MgR=Q5WMw@mail.gmail.com>
X-ClientProxiedBy: VI1PR0102CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: b055fcec-1338-462f-bb97-08de754ab126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	yCTu7NqRjOcSyfuz8akNiR7s9YrEgBQSVhdnlSBxACX2Dv/X+kLsOYkZCf7L1HZsAd+YfFL4r+H5WfXwYjFJPgm1fw3lG9MLU5Ze+fdg5QZ7bEP2HAKAs7cwTFflEyJ/RqcS/hJOiEgvqWZ01z3zLfOeKggQCFgm5iYoRI2fUlNMyN4mPS43Bz3lIwcqGzq86y4mN4R9PlyMsNAHRjzoV6KgwPqWwmSic9PsHGiqH17NTaZsq6QTAZwn6vFJAiQU07cMMfRdkRxOHEBuzYWSsGOUBebL0GTigiLgd2Tj0llHIgrP/YQZiMao0BxtLH2FpUH6MqLZLp3ZhjDyzFFJdovHkb+AlNz6qswOW/TLk6cYcUGjxAFf7E0DOnmvR7URGBg7205lIreFDg+vAZgK+ITlTsdRr0IHg8dSxdGkpwZLiUuKIStnztl0EilTdDHwfEwtF36czBdhVSO35LH9iAIclIb9InQflxYK7T4D+bZZbdohBn5pqj1phZVmE1+kxyooySgwRAY9aGl0MZo8x3seIzH5eInWM3jTBq6dG0eUkTDvtv2gllv2oOpK2wF/gg26vcND/JfRNCp3BzGPuMYRA00ClRLU8iYx4MML0rCeXTjSq0A2ZZJCPGIxThAgIwY+a5j5sRDQc0yStIgt2zGck+X2yN26/8yHGLyCxPflJgnrP4NyfyU2hTKe8kvlkY5YxZrsgqHhf4Pk0LNhVpup6+n7AlEQ3mETt709EF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?698eYqcizXUElIsFaOD3UJEhPiwyrjuVQPcIaZtH7v1EIXwgsG5UtweF+xOH?=
 =?us-ascii?Q?qAmn1b7VBj6FBoJi75woP2kmGNfZ0OJU4SmySTf9MGB/lDlYwP44ROAo1NeL?=
 =?us-ascii?Q?gWOVeXdYyqt95mXtEAW20bVD/2mzeCWy9FPRdnWJ5HzRh1lNWc9MmWmT6NU5?=
 =?us-ascii?Q?4uhLtGumsHQtBB7qWw2/j9ZtCCtf54fKglGVLGFtrSjcQtoQSuQ9FJAH2IQj?=
 =?us-ascii?Q?5azbpAFMP5/Qmo+kpSJZToc/t4qonYZiExmwfXvCqXU1f9BdX0QkU0dkJICG?=
 =?us-ascii?Q?l9wybXXi+8GgfjPgJ09WvPNkk2e+Krgjo0qtSJpaJV1tUZ8psZ7I7Qb51gh5?=
 =?us-ascii?Q?6zbHHgJUp0HbjzGrO8Rk2yLjuaRq6yrnqJT9ySRoY1z/YTWw2WjBWByc99rY?=
 =?us-ascii?Q?EtlbRTGluv6uWKzqQVWsj5dFraeCnQNUINXOSiJ6TpsaUXh25uty7wlncafP?=
 =?us-ascii?Q?rbcpAt5CpGpsn7fW9SxhH35p8fevlPJhPSEaCvO6h+xHlCEWJHrXWnPJgSnu?=
 =?us-ascii?Q?UYET5pETZjeFfRqK1uZMCwxlYOKbSzzk1dl3Wvv+tKoQe2zrAvG2cWSqP8kl?=
 =?us-ascii?Q?1AAkg68DnVA5ILN2ndw16Erjp50z4RbuTVV75Cw5fv+LrawuMXfHBGb/Lg0m?=
 =?us-ascii?Q?/vxT6cFuSta/xxQ8WrpI6HIsgxjY3dUGrjmngwXyRFCl1xwT45x7sytfhhuA?=
 =?us-ascii?Q?xMa/Qt3z6X+MYuhItJe64DOLRmmQPxYZMHG0avAQ4OdmIsHeyEO/oJ5duo1T?=
 =?us-ascii?Q?oseZRLWKVBptwPltHz3i62T3ph3ju8iUAGuSRmROq7VC2vXQj843K5Aafccu?=
 =?us-ascii?Q?cKzg/Nqlgf++/4s1SyR62WpOtSLqbXnwO2iTpAy1FKPqI4N1Gzrt6df1xwOW?=
 =?us-ascii?Q?r4JiRfxmE7lp9op0yVxU1fuJMg0AqLiG/wHawe679TGj3TxjYlPjKhmexa3u?=
 =?us-ascii?Q?k76mOsEcKSviF7eu+xoxYERhAUHP9adndC/5BTFRsmnjX8f2aTO1nvzXHK6A?=
 =?us-ascii?Q?9AlT05xiok5eZWJqg6leS+7jdmP6f4wj8E7upUxXNJKH2UzATBgTtR9RbR6S?=
 =?us-ascii?Q?8A1MU+S3992l94HDV5IL+HHOhETbI3cAFyIJq55OHH8a6wKk4+r3EUROcb5a?=
 =?us-ascii?Q?GHzdE/cSZd1vnjooEUY1+V0GEBINrw4+CFjzaVw2YOehOnm6spWQd7pTK3YB?=
 =?us-ascii?Q?s5sxKZrN11kC4/bhlRtv/aSrRnwC2wwtCAcf0286P+KnwmQVCY6H500gfs1h?=
 =?us-ascii?Q?joOqDNeqJn7lgc/IZXeCllQuqmn7HTpmyRJMOo6Sy+0DjeVYXGjLzynZ9wLa?=
 =?us-ascii?Q?6XAZBmId4egeb8oeoBI35Y2DTQze4YHoNMXcmdu/3Llhgemr0kpQ2bXyL0dt?=
 =?us-ascii?Q?XbPv/fx+fk7FSM6SN7jRttD7QffvrFfZczUIXuBRmltTXTioRItndClBD/xZ?=
 =?us-ascii?Q?8eCksSpU3ObV8n5az4oQPryUCArYDbTxl6SP8rUpuS01SYP2rYuD4jeUwQM5?=
 =?us-ascii?Q?fiKTbH+FLygKjg2tlGnuJUXibfntFwcy8Lvyds6fImn73a/9t4SEUeyKE2yy?=
 =?us-ascii?Q?6iNP/WKSAGZM+QXvmdIYOdoMa9JtPxF+X4gSmzB9lnnqGKyWNHIe/gEBlPoZ?=
 =?us-ascii?Q?xA990DtNv1c1cmMeEHjEZK8DOE8l1bGuO0RCz31wNA9pSKt6co6kmzCjQNpD?=
 =?us-ascii?Q?T4YnsiT0YFpX0vhIKINolbGcF1++BYgDASjFqffFTYPRc10JPFOg12KWGsuq?=
 =?us-ascii?Q?h5UDR35nHpTs6Es1Rv6PuS0+x7GjwF+ZxHVQkPTLDsKZz5tKscZ+Bk2Z0k1b?=
X-MS-Exchange-AntiSpam-MessageData-1: jiCcLuiNKnAZkMrKFxoRRzF9Xj0pKy207bQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b055fcec-1338-462f-bb97-08de754ab126
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:21:19.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ1fSJqX/vs0rJlre7s93hjhSGKe7CefqdZ2ZUYwz67DBPjglzgpB4/ZSLpk250A7bP8qmRpIMmaPoFJUh4Nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,collabora.com,foss.st.com,googlegroups.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 4D8371A8F75
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 04:13:59PM +0100, Geert Uytterhoeven wrote:
> Hi Vladimir,
> 
> On Thu, 26 Feb 2026 at 16:10, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > On Thu, Feb 26, 2026 at 02:22:29PM +0100, Geert Uytterhoeven wrote:
> > > > +config PHY_COMMON_PROPS
> > > > +       bool
> > > > +       help
> > > > +         This parses properties common between generic PHYs and Ethernet PHYs.
> > > > +
> > > > +         Select this from consumer drivers to gain access to helpers for
> > > > +         parsing properties from the
> > > > +         Documentation/devicetree/bindings/phy/phy-common-props.yaml schema.
> > > > +
> > > > +config PHY_COMMON_PROPS_TEST
> > > > +       tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
> > > > +       select PHY_COMMON_PROPS
> > >
> > > This select means that enabling KUNIT_ALL_TESTS also enables extra
> > > functionality, which may not be desirable in a production system.
> > > As PHY_COMMON_PROPS is bool, this extra functionality is even part of
> > > the base kernel if KUNIT_ALL_TESTS=m.  Unfortunately PHY_COMMON_PROPS is
> > > invisible, so this cannot just be changed from "select" to "depends on".
> > > But perhaps PHY_COMMON_PROPS can be made visible if KUNIT_ALL_TESTS,
> > > so the select can be turned into a dependency?
> >
> > Is this what you're asking for?
> >
> > -- >8 --
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 02467dfd4fb0..1875d5b784f6 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -6,7 +6,7 @@
> >  menu "PHY Subsystem"
> >
> >  config PHY_COMMON_PROPS
> > -       bool
> > +       bool "PHY common properties" if KUNIT_ALL_TESTS
> >         help
> >           This parses properties common between generic PHYs and Ethernet PHYs.
> >
> > @@ -16,8 +16,7 @@ config PHY_COMMON_PROPS
> >
> >  config PHY_COMMON_PROPS_TEST
> >         tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
> > -       select PHY_COMMON_PROPS
> > -       depends on KUNIT
> > +       depends on KUNIT && PHY_COMMON_PROPS
> >         default KUNIT_ALL_TESTS
> >         help
> >           This builds KUnit tests for the PHY common property API.
> > -- >8 --
> 
> Yes, that would work.  Do you think it is acceptable?
> Thanks!

Yes, I think it's fine. I misinterpreted what kunit_"all"_tests means,
then read its prompt which says "All KUnit tests with satisfied dependencies".

I'll send a patch.

