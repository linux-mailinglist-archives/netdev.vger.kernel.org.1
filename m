Return-Path: <netdev+bounces-261394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGqCBQtjoGk0jAQAu9opvQ
	(envelope-from <netdev+bounces-261394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:13:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24D1A8571
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3B13027326
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF83E9587;
	Thu, 26 Feb 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mf4hKO0J"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB3275AE8;
	Thu, 26 Feb 2026 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118644; cv=fail; b=nCu+bzUz0U/xH3IpPVEY4SfD0oGwRfmOMrzXUc55sWIJh4STuiUEUQvVGWSW+O7JJ3AhTqRaixcLK0CfehCz69mmMwcT55hs/U7Bq4t076rSIwSvvLBESdEG3UpO92VGzJDTOlm7GMIpLPuso3B/mr6uj3ab8docvjQBD5+DU8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118644; c=relaxed/simple;
	bh=vr56DpbClWGB5KLNpbW34XiB2nx6rFy52VcOmngQIGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eR+0oJSf/dsslxiGwHPN2U2XjiWsQRI8gj0GoQ6GPtOwZeQitaLcGfKq5lW0mOKCale+fuHVLpTMtffewOajDvhWu/PrnCCE6SbiZTK5qNFNJYjw+0KOqTALvrY+V2QVnQj4AXjrczmmqFJqfHqImgh63OyYW5GYeFgS8vHGBLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mf4hKO0J; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEvfEw5h4Uunc9xu2icnAXctbbCdMjyt7ixHAbuRUnXVq0SGyNQ0ylm4z9SMe8JlD99xyXB7sbMzl8s3cEMkoDokoYKSxppvulcgNh2oNH2rLWINycOc+5Vo22Kz+R30RiUXHOOx65UBMzhppt9iY4azZlu3iL9kuasorppdOIICc3UF7KDJX+SkvI13EDMSiOHqIr7LnDngkgn9pWmziHfB83w6fs5b+FSLruo4cUmCm9DPCEVr8dfI+ydGStZC/K2zAbfdbcmhrIT4aOvPOzt7fSLQSfr8jMxHPuGz1Zd7w5rTbWzZhZmzBbAdDlvBVW6X7BjKfMQ+g9EZt3Z5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nONTDWkgchCtFH0DK+TEo2OO7Tk2Ldh3zyG9EuOoyM=;
 b=jGmj+vzwVDRK3hN9anzCWdyvtL5wFaBpX6joHpXVfjSztI8iBqS06KQ4w8NcdkvQkXSkRptnvhURmleY5yLyCdo2l+mQdUW8hrjZuM5ci/lsELO0z4l228hU0X1JqFaS5ZbWmD7efTT0N80wh0vuAQB7DBgAAcOrf6DcXdkAgNw2PZr7Boi5804YCHdAoANqFgDbBmL3k5/M0ngAJ5wbRl+nt2a3z+Z3Cg/3v023zXUQgyqoa2myt+NZPq4CzCiqy8kM5pX6yHyDVKd8uVJAuCuQ/pLRvsY8NvNVgI6GbFg4tBTZ6NDcpXmOlMsufLDhjWg9O54jldYBIiFgGwlC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nONTDWkgchCtFH0DK+TEo2OO7Tk2Ldh3zyG9EuOoyM=;
 b=Mf4hKO0JvHRRHM5iJ9lZPqRfxUqYEzjpmwR6AEg06XOPaTszFGbgnHWG0fGno80WGZrkoHeuKkAN2d0o3Kj+Idxzjbhb1Z1LE766QDq18F0Dx1E/gTTLkVYZPVquJP7gt3azI+c7pqh6Q9JgB+DjmWONOWCVqVCtQCRG5rmet9Et9KZyZXrUJbb7ClU/OWWHBI51DfJTsHA7CROReK7XpOgsNBYeQjkuAv/Cv8rOUDPGvdjo/9P2Lp3UytTJYPjo3twHeJSsDI2IqM95yi5aHCxnZX4vho1pd5fM6LgSNOwX0g6X4fYOMTGsWlSBhs6jmLZz3NDZ5LdKA8kEnTpChg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB10119.eurprd04.prod.outlook.com (2603:10a6:102:45d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 15:10:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:10:40 +0000
Date: Thu, 26 Feb 2026 17:10:36 +0200
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
Message-ID: <20260226151036.x4z4bdlxwgsqlkhs@skbuf>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com>
X-ClientProxiedBy: VIYP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB10119:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d513477-067e-41ba-c0e1-08de754933e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	qS70icsTNhbhgDokLJN5HHBj01Ol/q7jzHbR797oCpS6NG0acpXssdNptcJ0JD6WqksVNeyXmzWLLnGXd6LL+inPkYf7QXP3uGyT8jU98bMYweZD6oyPdE4orzK4Zp5acbJTjB1FTZ8wQbC7jWbgKo5LjMH9cQ1l17CDvRInZfqecGKdLvab58kMArjV4UiipKMzwJapxuJz6qOFLgiNOAQPQkv2A+8Vm4hCqemPKAihPqfBIjKSV+4XWiMfRE1PdJ2lZEcEnGrAFhxlBCj7pyzRm+0Aqj2tr+OlMF8TDogNRFlV4AQH9InotS0rlKbm28MtoW2YEB9Dmyp0ch6NKiZS7X3f/i59+5wMacsq9BhuF98lfMbT8FIs7FncLPfh0s7NvHHuxVc5FHb0Owwq/0i3Zm9sxoZeafg3hFzGqtutUKV8NErcGnz9Z+dg4thcAlZU5jBWIikZp6QH2+IrgSQC+W7z36vT/xttN3p0aK5VScXw8rOMSv5E6FGZPgsed/pTi0z1jh0Fxp5rTjz2EuO/nSz+XdLluku/liIO2/YLnxkbzh3vIOeb3SHNx5Je7TgfB8J8UzIuMhFm6yqMv8EEsTvA0/M1pM32tYRQQLyWgPIgEsJAKKD6Nl3BgMs9oEwQynWsQCy65UxJv238Sk1PW+FztQUYRaP1Sg+S6JKHPVl4EI5rnHedigkOyXMpMZGWD64GrLsM90LRTO+gFynevHVGNcCHXCDN9w6sLCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuvQTPKvFv4PxIpRPaHpzxhg8hxe/CixpDxwMAVCW3+BvJLs9dWuxfCN/YNT?=
 =?us-ascii?Q?2pfyY6Z9S0G0oSzoAa3LUdJvCETGGeNAri+RIMMv5OW3D7jfQ8zgM5dnAMHm?=
 =?us-ascii?Q?6+CHFzod7HGaOFO7MZ7O7LsF2Tn9E6nUHqTN8QPJpZZzu1/1LMr2LHRNNZ/B?=
 =?us-ascii?Q?sjnKpQ1XyRwiccLe5RJgKQLmd8JmbNQc3GOrlGcmFB81fMgpyZzMK0w1utXe?=
 =?us-ascii?Q?DIjlx+GFFJzOxm4rsB7evotW6qbZAOq4YoreiNcNJP31A/+TeYRCpk1OEElm?=
 =?us-ascii?Q?ayidT07zhy/O3wTfIaa1et4vKtikpjkAXlVxoSPAabNBg+7qbXVEQwmAGiRY?=
 =?us-ascii?Q?EBhr9abye5EsI8eraCvozGyCUFLE/eIHLOjGiV+JXNuzghuJEDpZ/d/6mSYB?=
 =?us-ascii?Q?VRNI0cyvupopxvZM3o6s4ZoYMj294g4R7zXChmsXVNUMnv8DnunuXm6IJpAK?=
 =?us-ascii?Q?CyICL3h65VnCUkhQFeBtSNRfgCVpcs3fEognU4uonD1n8GD8U0rN3JdC3VME?=
 =?us-ascii?Q?a05hu1gqPFRkbhQoboIBpiWCsmXekLrm6A1K6gBmDc9M88h2/v0yDccYU66F?=
 =?us-ascii?Q?ZoRu6+Ucup8XHYkqvi+ljWCGSceAaZ7jY+RTWnT4tQNqRC8l4CmF2DQYwg2J?=
 =?us-ascii?Q?wFaJPaB7pvKxCBREj67wmS5ZUMC3Q/0EzWSYcLnAOxuBv7TT3q7IakwYsrB3?=
 =?us-ascii?Q?NHQwqhsJC7tOV5T46ZRuCAV9mrl7YMsEsB0zfb2sKk3H8c9kEZfaI4rI+84b?=
 =?us-ascii?Q?ynKqL0OSIqJ0nziY6XpeUxNReRI8TbsT/xHeEq1qJkq8lq/tHSWP8QPdVofs?=
 =?us-ascii?Q?lU6R3Qn6mvTGbD6w8uc+IOqMTmaDFZRqRqYVEtpybxlsymLptDssmDJLDJsG?=
 =?us-ascii?Q?PSX57Zbvi7Kts8F04SUL5JmmVwjnKJhKM/Om13kbgktXJ6V3W5J8qlGO2SaV?=
 =?us-ascii?Q?pn4MjfxkDHPE0dNjhhJ5iber4zhY2lhvuKfP4+Y6PPF+eBFSpVbc2qrazr/f?=
 =?us-ascii?Q?n6XOhUrUSxTsl1duQPhkMqs21CPdFvYknLmrISZ6IQN9Z++RFd4XbQXLLE2R?=
 =?us-ascii?Q?h+17WWYK+ms5wZgoZu1eOs4qdMw271coZMgUl2K9Cr7KQ7Vns+hnbIc64rWp?=
 =?us-ascii?Q?4Blj6sR9n383zG86+bspouhrRiUdgfmLITrnaskFqEGVJeVB4Dg2bagTNOht?=
 =?us-ascii?Q?L3GTozJm97S1HwiDU3mFG3oIprXjlXnVXkT3ZnE5K8UI1Y+6OGYOLAIPNS7Y?=
 =?us-ascii?Q?mXDB6ztfbp3FO46LvRMIMfI8Z/b3w6/oTsbnQUp67ApGs0ABiYTh/ZsW8Ac0?=
 =?us-ascii?Q?9Yjyu9K+iH53qEji1SEfEihoyklYbhTcSOn3oHk5pTKFkyzKKjPP/6CIbljQ?=
 =?us-ascii?Q?bbvlmuD5Re8yyXHE+cM5tCv95hNeKIJlXuE7Wysr5w89KtwifmkThE5wWGXx?=
 =?us-ascii?Q?LzV0aLCZ40nuVTJWCZtsZ5Uu5YyIoj81SNC8Y8OPuqr6wzoGO1ACJR65vkGn?=
 =?us-ascii?Q?TdmqtawB67ZKbYdILwK1ssYjSwicbXhpZ0bpvgbdmmLLTC6ryzXIDjZ3GEOW?=
 =?us-ascii?Q?lRLdKrKKw0dKL9+EKeM3vb38sQQJmclDBRJUl34K+OSC1IJiAmvcj36tIaod?=
 =?us-ascii?Q?3zY9wicHwhtY7Q3JE1R6I4J9WRx3zNebNhzWVlqhjzF2QPDTdzgDy9rwN6TY?=
 =?us-ascii?Q?O7rHpUGxumdbqwRx54GhE4WhSJNPionuAhYRBWwfPdgUFqJG9RhT/V8jpNWH?=
 =?us-ascii?Q?pESC3P2iJ3Z4bgb8ipHW9ehRX3zUNbLMhrhwhW1KwIzNffLHN/5Mn7Egwh9S?=
X-MS-Exchange-AntiSpam-MessageData-1: bfb1JofLkcM1XSZxKYvlEG/kuNCKHuNLSg0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d513477-067e-41ba-c0e1-08de754933e7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:10:39.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzIwM/b233988glJu+0mQAbNrpPMNSw8SI1bjMPRt1dxxgN3eBvXhW7Fw4EK8JDB3yk+GZz3o9cyq8qdTkIIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261394-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C24D1A8571
X-Rspamd-Action: no action

Hi Geert,

On Thu, Feb 26, 2026 at 02:22:29PM +0100, Geert Uytterhoeven wrote:
> > +config PHY_COMMON_PROPS
> > +       bool
> > +       help
> > +         This parses properties common between generic PHYs and Ethernet PHYs.
> > +
> > +         Select this from consumer drivers to gain access to helpers for
> > +         parsing properties from the
> > +         Documentation/devicetree/bindings/phy/phy-common-props.yaml schema.
> > +
> > +config PHY_COMMON_PROPS_TEST
> > +       tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
> > +       select PHY_COMMON_PROPS
> 
> This select means that enabling KUNIT_ALL_TESTS also enables extra
> functionality, which may not be desirable in a production system.
> As PHY_COMMON_PROPS is bool, this extra functionality is even part of
> the base kernel if KUNIT_ALL_TESTS=m.  Unfortunately PHY_COMMON_PROPS is
> invisible, so this cannot just be changed from "select" to "depends on".
> But perhaps PHY_COMMON_PROPS can be made visible if KUNIT_ALL_TESTS,
> so the select can be turned into a dependency?

Is this what you're asking for?

-- >8 --
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 02467dfd4fb0..1875d5b784f6 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -6,7 +6,7 @@
 menu "PHY Subsystem"
 
 config PHY_COMMON_PROPS
-	bool
+	bool "PHY common properties" if KUNIT_ALL_TESTS
 	help
 	  This parses properties common between generic PHYs and Ethernet PHYs.
 
@@ -16,8 +16,7 @@ config PHY_COMMON_PROPS
 
 config PHY_COMMON_PROPS_TEST
 	tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
-	select PHY_COMMON_PROPS
-	depends on KUNIT
+	depends on KUNIT && PHY_COMMON_PROPS
 	default KUNIT_ALL_TESTS
 	help
 	  This builds KUnit tests for the PHY common property API.
-- >8 --

