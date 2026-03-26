Return-Path: <netdev+bounces-272265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E2vHXSrxWlUAQUAu9opvQ
	(envelope-from <netdev+bounces-272265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:56:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB333C27F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DF373021EA9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33130F94D;
	Thu, 26 Mar 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSudzmwN"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1E29BDAD;
	Thu, 26 Mar 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562055; cv=fail; b=XtXixMHQu5Mw6IbDwF0HD6Q+5qeO0W4hRAzbKxE0m74Cp4CWa39RxU9MjYczDgnsO2yBiCrgcPH46yWhTwcQ/Rw1CP2/HYUTj0AvHxGUcMdYohJWyhhquJWQ5NwEjkPfQYxktSoxKacuXN7ziZi4s6cjonimw+NdWiBUqhGcN4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562055; c=relaxed/simple;
	bh=BFn/FkRjV7IA99X169mV+6xHoy2Fg4i6xbEaS/NhKXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O6O/xHjCFEdaPBD1Tp/NUeau+R3+5vXGIkHSmoT5AlSZscMHFjigmTNkveMFJNLVnZGOvkTfYS54LG62CgvJw14ZOqimEywBPtsiM8aQBx9gMDqt9CtncLeRWLcGddRGXDqI91VAVDOU+o8QUbii72hWppEji5xLyhuT30+k8c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HSudzmwN; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nibjQg+wWG2E8Om3EpmoCRCsyKAGNstEGAjbfSehg9DImR2erfc1hP3n0flXfwA8sxkA50h4sKpO0OiJvTpFRB0xx5XdII8Zr6e9PyjMFyngQNaaC8H1lke7yKr8oivsEpcfRCFYkJufyAfT8q1y5xa94DXVJKFVv+BNo99zbf00vmFcEoi8JAjDQl3gA7ZUQ4m69JgswybiIbL9IKY+haGb/W9QeMmOs3zIJZzyCPpNyxPip9rtxUlibOUpyoqZ88rryIU0KsOfM+6DUZQ7ie9TDPiHbXqY4qZXtILBuTd4rkqlSgnoArZf4Tq3bfQvtddWF101X0kbW7BRXuMtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZaLPvZG6R5rfRR/YNCKC1qgD9NyoG/5cZsd6UwEWRM=;
 b=QyGu0/25BJfDcLxomCsmUfSBZ3hi46VNT9l0lBFuBrOQDxBPLfzigFBf0CTif3Up/7k1km6NCmzzrhFDXEvM4Tc7v1/McNF6TSpxFN0lSOR/rS53ddwFf9RU+AOTesLy+J/1Xvmf7qhY5WFmgBXydGDSWC82vfl8jlnVPk1y06LKzm98a3zByhZ8wqaazHTDx8PPvuxa49mxPP4qTuynBYtmyvpIOs1O5JMvrjHTgCzzZ4olokBbpT03AxNjViQcIB0GSJ7uQw9CrDMQKm0hzeedMsEfgPk8lqhiuVXA9hYRdw0YQFCz3ZTc5mZ8Lmh5k36jowFVGjchvwj0GpxLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZaLPvZG6R5rfRR/YNCKC1qgD9NyoG/5cZsd6UwEWRM=;
 b=HSudzmwNGT/wuGEWCoFlvPHfjnttfXzeT2Y1O1oDtOC83umO51tVPdV5ro6IvKfASrQH5+mgvPoYrbk/jxlIT6Bchfr6n7CeF7XaW3ROmmHbP4e4p6nSQ0Pd4TW0wQkibePF7SRWS/RvWQQMqEoCvGpky/S1U6cGx9ygryWtJ2pKGcH3sSEJ4KWaQzlVtVupyVFHfWW1jEdmSrO648Q9/wXLqjbwDZduleDa03jZvsa+Qy7pNLLVIEwJeJ5OL9m77P0MTd2dQhnIHxOhUX18I2/h/d5MAqlIM2wCfkLbbdUhLRGtg3U/0JWAOruz5TPPGODHcWlPTLdzfOZEbhO2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10080.eurprd04.prod.outlook.com (2603:10a6:150:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 21:54:09 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 21:54:09 +0000
Date: Thu, 26 Mar 2026 23:54:04 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Frank Wunderlich <frank.wunderlich@linux.dev>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?B?QmriiJriiI9ybg==?= Mork <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 net-next 5/5] net: pcs: pcs-mtk-lynxi: deprecate
 "mediatek,pnswap"
Message-ID: <20260326215404.krh6v3mmnqdlndli@skbuf>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
 <20260119091220.1493761-6-vladimir.oltean@nxp.com>
 <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10080:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ff0fc0-7bd8-4bf1-db20-08de8b823557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|7416014|1800799024|19092799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gc1YnjdFA+o/jcU7ZUb4Cuz2x2CaVhGwd6P6NLmDTXTUqjuevvuFZOatmjddrL2KM4Woz+iThmOZqq6ivAHFPDXWDBbsg8paOVbAvupJSKdXYi7O9pyyxuyLKJZcwBFKjQM3vnmYD8Iyp6mN+kCDmjZqh4AzGDJ/Y9xEws8ai8RjUxRwJZiNcoEQ95rhxThkEzys099scZ2q5FZ8RXd6XNQwmf8BjCV/lS9KXV8wOu6B/g/7RwqmoqQf2lQfCvlO7RETRRR/6POusB0uOZwS4uX+belhQlTo8S7ehQZbOSJ/cjA0EfLHJ26OwxMviZkuK5VmFuBtLDShE9YbfLBuCMksNgx5giKzFJPSGF6Dnuo2S9p2VyeMFYOYJDDmcpvrTYiYaMMhH7ZIaIvj9KGidEJmwrD58Y+2QPCS1nPB30hpQQGFK36g8cqsy87mqcNEOXNTWVw2p+wEn87oqWXlLQWE5CJG7DUgYka+a5pd0QcQ/GGEqG8oM6fN2ODgRYKW+uu/sBcclbzYI9f76ChzTpMaA4uICuu1tpQJZaEtF7zlzMgS5an4O/U+6EpY+BVYxU+ocEkVdsFviHMxLEJ52MT3v5qOSAMjLnOhsVnfzUhjcEI6E7A+eQCs9ah88vTPUrfzXy1Jw1U3zVVzVMz7fJaPnNrNBO8pcNTgIfNKsvG8VPM3ZHbWu4vqmLdN7Ima7Dpg05CE02nnKxRpcL2XcC87XRQxYja808Y9jPV5q38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxS72Kgp9yZJc0cs7zIyzeXDHx4q34JLGUOy8bjJbjd0pBELUZQZWTqI75f7?=
 =?us-ascii?Q?oh88HvL1uA3M2kTgQiALfnCTel5GZj7rGiEkmOakY8s6+RRExxo9T4T8iG9b?=
 =?us-ascii?Q?XH+eKgPG4g9GexnALQPzI8LPRD9n32tSjwRIl/bQ+bM7K8aciivohQ5U78Ob?=
 =?us-ascii?Q?ERZWP5nWxoB5W8t/6/d3kYfrJPK7gzS1b+6j2H9XexaDHTQGf3bFReC/hbls?=
 =?us-ascii?Q?sSFrcTlZkBxGWyMN4uKH6yLarab+sah1TefiaYADdhhR7kHU38dQkbAUHeso?=
 =?us-ascii?Q?+rR5duknHbvaHuYLb463gYi3AOSYZoOKmVtPBo1/ME5PJDYQpQOpZspjmbph?=
 =?us-ascii?Q?NxjeeafJ3hBARnWbphv9W2CJumFQDEATKNGhUw0qxRPQETupar39mzbKo0Cc?=
 =?us-ascii?Q?kmR/yOo+/AjfM1pS8n6PnDejSqfSI4L/3kUtz20AJRQSwLHP9IZVsHlexCyf?=
 =?us-ascii?Q?koJgx03SMJtwYUeWFtDt/17kWw462rOzgmO3o1IR60pInujiRJhUs1zPljpG?=
 =?us-ascii?Q?zWfPR5YSi/QccTZDBmmuj8QQR9jrDQeHRJqMbV9O02rGHQjpVXs6PkR6wOVM?=
 =?us-ascii?Q?fe30To3CpADLgsli6T07DYC8gt1hyJibGyOs25ugUm5TJQPxGvs74fzIOSCf?=
 =?us-ascii?Q?wC9XPZDqwwn6emkv818KzVXE/5gK8YeXPsnyQNWMdRJogU/Ze13XqcFPcQ3m?=
 =?us-ascii?Q?vqwsESFI5ZRqOLByoc4ylpROiunZjW7p0I7+DZcTxJSpaQBuN0Ov1Zhz+MT/?=
 =?us-ascii?Q?Ba9rh0ouspZhhe2ecrfGB7ov9/p0cY9WAUvc30FV+77S2WILNgFtMNq3pdNf?=
 =?us-ascii?Q?RETN9vXaRy4Tg/pui5t4ma76/IgWYdR0sdsEEptwmeDVZ6km3yNXMUenrrc9?=
 =?us-ascii?Q?M1xEq3q8qrp/W4kI4Rryn11+FX27aGAqys1uIYOGsTUi69kfoooJxOJnI1Oq?=
 =?us-ascii?Q?JjOWQmFL5Y5NSuvTQtewDcSozXytkT0ASb3G+ZK8ijcjysjwGdzYIlQ4NdE1?=
 =?us-ascii?Q?w/pLxsr1mo+pVhuRteiGH3jOBLn3MYMD56cidwgeKzqngu/DZBbnYEMFNZDk?=
 =?us-ascii?Q?l7erigsS34lcMyvMlrmmDLKbS03wBiHU3nQw9NZViWfoPQCPb6g4xKlYoj7m?=
 =?us-ascii?Q?kZGOuyVoYKnMNB9pie3RzxhCn/aZbyq8nzJV93FywFkUHh3QEA0HfnCdnWso?=
 =?us-ascii?Q?/FbtScF6QlY8eCNrL8vlHjSN8Wuk8llfvYESqw8cbAACPufmCCaSMjLOo27Y?=
 =?us-ascii?Q?japv45pae0TKVb+83/iinnDNlRvxaIL728Qjd9tTqnjp0VMpAsN1IWd5pgoN?=
 =?us-ascii?Q?zq+WiEiwNtL87Je5TbQzA/ayttpUf28k7l1oNd6F8VD2HzHDsnBnr165asyJ?=
 =?us-ascii?Q?5Utrc+559ZoG8zJFwfumg640v+rXc077JyH86LFXW2IvNr56J+naRV68aBlC?=
 =?us-ascii?Q?8jMDUKwxLFZXeTl+O2odmkZTvNdEaxbTfRkZnkzMCysgZMAgb00hCJtwAdGm?=
 =?us-ascii?Q?5lWNjfClvswsChkbMUgMdL1noq7KIL8p54AaTBA+/lo+Tfj+35uTzcjKeta7?=
 =?us-ascii?Q?3D8XKzNJsrwkeJ6yAh3pJpmGsf3f3kgsnhyD4OdElKbnlbXJhIl7rJ1eWu2B?=
 =?us-ascii?Q?2Fwmq6TfCyxGkInikG598r2AX/JcOoO8TVwouhr7iz3gnMHEs0W0uWhqtnDK?=
 =?us-ascii?Q?lQcQ5fQSbqpc/TTcK/sccM6FkylIcJTQzvHa3b5s+cHa4mb/AoAvcr32RDuP?=
 =?us-ascii?Q?9Qn7LYy9LnOziRZ5iXiE7P7HneLvt7+4DGz7HE0EcVFNY7jpen+5vPU7mxZu?=
X-MS-Exchange-AntiSpam-MessageData-1: AotF6XBevjHxzj4uaU9G2m2il2xzD0OsNmY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ff0fc0-7bd8-4bf1-db20-08de8b823557
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:54:09.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WXMUM1LIN3MHeRBRr32H33f8WkDWJN+chE1qiJzXAEVdxIQA/a6nUf3O+WLD9qkveBOWe91UlnAENGAlDSL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10080
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,fe80.eu,arinc9.com,mediatek.com,nbd.name];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 01BB333C27F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Frank,

On Tue, Mar 24, 2026 at 06:36:44AM +0000, Frank Wunderlich wrote:
> Hi,
> 
> looks like this patch breaks BPI-R3 serdes between mt7986 SoC and mt7531 switch in 7.0 (6.19 is ok).
> in ethtool i see only tx on mac but no rx. if i revert this patch i can ping through dsa-ports again.
> 
> i did not completely understanding the code with the default-pol as it is now splitted between rx and tx.
> 
> mt7986 and this board does not have mediatek,pnswap set, so the final  regmap_update_bits writes val=0,
> before there was only write to this register on invert mode...but i guess this should not break. Maybe some
> kind of timing issue between mac and switch?
> 
> maybe reverting this patch skips changes made here:
> bde1ae2d52ab 2026-01-19 net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
> 
> I resend as last try was sending as html (option "always send as text" in webmailer seems to be ignored
> somehow, had to choose "unformatted" in this response too).
> 
> regards Frank

Sorry for the delay.

If writing val=0 breaks the link, I'm curious
(a) whether it still breaks if we don't write anything at all
(b) what was the register value originally

Could you please test the patch below and let me know what it prints,
and whether traffic passes with it applied?

-- >8 --
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index c12f8087af9b..5c5f45b93b82 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -126,7 +126,7 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 {
 	struct fwnode_handle *fwnode = mpcs->fwnode, *pcs_fwnode;
 	unsigned int pol, default_pol = PHY_POL_NORMAL;
-	unsigned int val = 0;
+	unsigned int val = 0, tmp;
 	int ret;
 
 	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
@@ -153,8 +153,14 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 	if (pol == PHY_POL_INVERT)
 		val |= SGMII_PN_SWAP_TX;
 
-	return regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
-				  SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX, val);
+	ret = regmap_read(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL, &tmp);
+	if (ret)
+		return ret;
+
+	pr_err("SGMSYS_QPHY_WRAP_CTRL = 0x%x, intending to write 0x%lx\n",
+	       tmp, (tmp & ~(SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX)) | val);
+
+	return 0;
 }
 
 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
-- >8 --

