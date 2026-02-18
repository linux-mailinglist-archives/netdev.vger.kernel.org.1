Return-Path: <netdev+bounces-259330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKyMCMPrlWkXWgIAu9opvQ
	(envelope-from <netdev+bounces-259330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:41:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D661157D1A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D23C300C916
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19033E345;
	Wed, 18 Feb 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLgmp/aI"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A96322753;
	Wed, 18 Feb 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432800; cv=fail; b=GfT37RpBTjV0jQvZTP2qZOdcKnTfiVPV44DGrPpg1JvFz1xZEqder/LsixMl8nGBaK/uxPpYpufq7+u34VWvs4tkK/r7GLhnoRDwXFi61XDF9GaZEtSLZA1a9OFBEbDbl+pT9vRkOInBURYVY7fZ6ZdI+d9xTlBRDJ8JemvUWAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432800; c=relaxed/simple;
	bh=9E/z7xNGys+SPhwyhjH8hIAfM4JLmPda1EnoqLCFxjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ixDZB39ltMWmKtFNAQ3rmxFE43UQ5dyfT63cyFJGfd9hQao8GEXcge0EKfjt81+e6Gb2y//11BCqLtBeGY0rwD9gYvJpGKeLxrTb2YiTdpsGcqJnEg6g01UvRNWR+RdmuEBxcBiSvOKHCWmsnUeBe/delq2fUa8fRlxWa+VAsoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLgmp/aI; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVf8xNEDi0LhGcDFJcVjZW0Sme9qONQyjN66Uq2YNUg7LfWZKGv3Nybc6oJZVKPKB4SrI05KL4MyKxDRSh+5zNDDPVzG66iSMthO6ytKfYh+/yHmpxZS7NiD1LYkAD0e6/ZAn8cS8xZrlh4IN/Ih39qnULtti71+k69g6hqwo3SBVjU84IOBOXcU1KNtOj3GNYc1IblHLFGSEWMnYoYNOWg1i2wtT4ksHM+rL36/fc+2dWMZK3QtgouO1N0ywINzUP1KyqA6zyqKhuN7ar4TZ65/lJy4lpE1okX+cW8WMM66IHGWVAscaRfR+fKbJLEAFx3/1lzAiZ2fS4SnnwumUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OpNnD6ykTsw1XrOedPa47LigioWGNObSdHz6mSf0Zo=;
 b=QQzViIQ+4FZcWZsV1mohRimarf0ThfNAPc8vsy946ECRj/jddZ7BLg77DSqkg2RHImLfIUkOqkYBan1Jj6eqm3m5q0gspAGnqEcRRRdOCIqWB6uPKZYoQCq7T40g8IzOEpMCiiPXJH9ism60uRRqhQvtVurx+M3o3T0BwVYM5LWH0EoDTucJRhCocxhVFoSdz39muqAkNmW72BKK/ys2h3qicAFukbtCFZ6YB1GncaSklOhjmwWbe6hs4RV8bkL4siyynUG4moRab6uQX4oOejF/BHA2FdIzu/X0gqD/C9zNsbkE/rX4XRKVVj+gtghyQZf1V+MEpVGHWn7aNrAQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OpNnD6ykTsw1XrOedPa47LigioWGNObSdHz6mSf0Zo=;
 b=HLgmp/aIB8hQytpquUuCQyudiwW16Y+/9L5eDyt2vJ/rCnPfHHshHWKkM1Ng8q1ntW2M2M3vkYcHk+Jin5pimk1pRHH1ZPpTv4Atsv7f+vCMSKKDeyBhdc1X/6rAGGv/CGc8jnWoRj4CtSjUh7IKyWAfRsjNERb96EXH+i6t6ClvTJDPx6kLFGdRUcE91ad3oEtaRyQwJVlkzpNNWpt9BAL2pw57thabryOqzNrC7GdJEqLT1iFwBh5OhZ5Bw5m0eMdfNvuiIMmp/TA37KqaG/cVEyPq+JLUMS8D55dAhr4cKUw+e8OKOPzg9waLRyqR+ZeTJytUmRq8HY45gotDQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:39:55 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 16:39:55 +0000
Date: Wed, 18 Feb 2026 18:39:52 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers
 against NULL phylink instance
Message-ID: <20260218163952.angk7v7ubvhnyksj@skbuf>
References: <20260218160551.194782-1-vladimir.oltean@nxp.com>
 <20260218160551.194782-1-vladimir.oltean@nxp.com>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
 <aZXj8QbM5-0tpl4s@shell.armlinux.org.uk>
 <20260218161037.a4uyxtku2hbsnfzx@skbuf>
 <aZXnIVpaetfHn0Nv@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXnIVpaetfHn0Nv@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR0102CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c5782b-fe51-47a5-6afb-08de6f0c58d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tohqn6QjdGOK/xG3Vry2otZYKd76kiYvNYQnnTto8kt+pBO0HAzMGBH7Yj9J?=
 =?us-ascii?Q?BrTOmI0y3ZVPQ6VPO7hDCxIsnhj/DE+QDg6psqDzM2/NFtfJTqmYTRBLXRc1?=
 =?us-ascii?Q?ZuNtD6LmEDtfWiv5bsipEs8hOGzP9rK1V5/8IKJkWJktt/WlxhRPrbD/67A+?=
 =?us-ascii?Q?IYp9d0fOK+Q3Okp1EhyLJvDEr1fGIiZC0doHtz/6YeG/UrXGLuNbTRMyDdOj?=
 =?us-ascii?Q?GIjBHuekgEPwJmEhJ2xGEXVynX21TJfNfgfddm/vbTxY2ztOfTrQjEk6Qf8V?=
 =?us-ascii?Q?yKKVH8+6rr+1UCy8xM4qyFWnk9w4PnJSPqzWS0EMtsyN6Rjvs3bo/NYWNxa1?=
 =?us-ascii?Q?MaZkPwKgNlUMgJlFhOFc6wdw21M4e+xdazp8jlQzuvpblJR7dlU5E0KuhYEv?=
 =?us-ascii?Q?AUvbVzYDD8aMWMnSFBpyls/9bjnrH/Yl2n0S/lBbV9AGe05Lx78/aptRreQR?=
 =?us-ascii?Q?ed+rrWX9X6wdwikrFIJGEORKmKvH7Lx1VlIwD4vXNSNE21Kayx+siqr01deX?=
 =?us-ascii?Q?eWs6lQ+vdcuT1fFLEzyKFROipBgWf9BH2kdoe8ioLy2NA9kCiiAQOPFyOIJq?=
 =?us-ascii?Q?EMc+5nafg7IqGqaPT4LyHD42wV3yqm1kYo4eByso0aUX8C7UYEELKIKghYzD?=
 =?us-ascii?Q?6g9Q++S6RddZV3xybYpPwtVUps70KuQdrToSsC/mMcy4BkKzuErq7sOwLbmd?=
 =?us-ascii?Q?ZOmnL47zfjTLjt+nsvjNLd4EnwORxvMOh3C7msJskE5y5FyjqS9UJRp5a6Qg?=
 =?us-ascii?Q?hzfgH6B1WQJ1RhKJ7EshWjvvzQG8wvL2caEM7C8DZrcRCh4+zb4E8tF5crZm?=
 =?us-ascii?Q?1Je9W4XjsEexhZvhc38DmsL0+sm9eE80llmc2k+YXhgI7Ks78DIHGtIYrzEc?=
 =?us-ascii?Q?wDC1JczMfUUv0wPFShPDJFQLzCV2ZMiGnalQHCaWkT5hsyV5EhrWG/3aLqeP?=
 =?us-ascii?Q?QlUQnaWhw+6XAkaRdSmty6IlT1c9W7optpHfhNu/QFREbj5ZwcbjQbACGle8?=
 =?us-ascii?Q?ODqG5aVVglvPvISOznN/FwTBAfbKQ9WU+5lSstwW3zH6JwW/KQ3Cd5gOeFJJ?=
 =?us-ascii?Q?oqb8HDwyNR8mQRVHdqDDuvDMoQLJWG7KF3D+wDGCFp+R+cGTO+uxu6HfhViF?=
 =?us-ascii?Q?aLTl/L421ZbbpB3XuZj5gWfMYYbLeLE9b298kXSY9H3mRDT9+e903xC3o5O3?=
 =?us-ascii?Q?+9JFBW9UJSQREdIfUcCEN36CRuQNE1Y8XrNaJgM6lUoHblFeqLouU1gliR5e?=
 =?us-ascii?Q?UwradE538noat54RIjRfSTFACKaxefHfQURjzHdOOZmQpstGDB8IHUtzXztM?=
 =?us-ascii?Q?oDj3TgIvDjtfebrAnI9k4EB3kuv4w2v4XS5FmoEsvEPHl/BiuVOEv/pSEvzu?=
 =?us-ascii?Q?1L9BzWqcp/z1ndl8XR9zB2X6spjMwVWNtrgSujUmsLZptTitIpAXJ+f8fa0f?=
 =?us-ascii?Q?nni7kGpMSSYd1QW8P72HMqBrI4DaBjk0k+wD5xTZU2ze7XzsJOY/33zD/xXH?=
 =?us-ascii?Q?4eDOWb3L8C+6UDixvYYyMbVAI7lxj7A8x0hopFCig4KRIXm7vTYPsfcKlA8K?=
 =?us-ascii?Q?ZJ0BOVZI1kJsvVLgm0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?szEnUQzl5cVzPSjEZtBcL/fSSoLq+b2Bmnbmz52JvrwcTf+OB/X3JzKW+qfA?=
 =?us-ascii?Q?+6LLzLEiB1ZJXVusaxDkqbCRltwGWb7Zq0LkZu41A862/86gm/sXOHt9QhDg?=
 =?us-ascii?Q?X8SAt6NJ/ASCEvwKiWlJoHrCsH0s5b+xvy+r0kXRJz187LKVU7zuJjAdm6fO?=
 =?us-ascii?Q?jWBJyARtULgklnHGHPPTg9A5uhCqlO8V0es4+Wup3VD2Q/EFhr4/Zm4Dv0xu?=
 =?us-ascii?Q?WKrbi/gEQq5JtQbzJKbs6funyD+S6CK91vQZJZG/qKTBU2hvFbSE6CSH/olA?=
 =?us-ascii?Q?h2kzynd32/GeSrxvZtmCqqEP9RH00vIJERmJDYsFOn3C9ef2VezRyjOr5v/2?=
 =?us-ascii?Q?nGLrlxzb6+spgKDXwsmJfi7qi72cQox24p75vBVa7rV9zczfJHT7YnezCPsX?=
 =?us-ascii?Q?eSIm+O6CsWQKbQMWs0oHh/exw9Zb+FAPPFomhNAhbk/1ITFloTzTdzsiUrnu?=
 =?us-ascii?Q?/GHmmMXn3lS6vG1N4/8C5X5Ss/EcRkzX5hK6z9Oxb+r6d8wFkT0VG31hxyVJ?=
 =?us-ascii?Q?gb+xdPvJpI/715eZCSqtosJNYUwWUXQY22vwul4NS+M6aUF9dFTpBmNmybdS?=
 =?us-ascii?Q?O3w94jw7tqTZewZ7I5DUMs4lFqyJJF2x8UmcnZubIz0bdRBxf+ghAvUanWsJ?=
 =?us-ascii?Q?tmS5pd5cC7/aOwUEpcVsYibbxCSQEK5h2SQ5tqEyOcpGR1kFxskfi3mu6JBU?=
 =?us-ascii?Q?DBESSRK5q6X6KD0nAE1dC8MvrduDae3LNQ/7WH/YImVXufeDPfFJOfzcqERL?=
 =?us-ascii?Q?YErygGaJAUsu3tPsRKhjXdcM+S2bBa1VgSRwVYYSwVy1ANK91W95WEGsUHWE?=
 =?us-ascii?Q?SEM36jQ6iZGNZKtS5JySNoaI76UKbFZXerhDwk05XTES4IUKPSgAua6/fctz?=
 =?us-ascii?Q?ddQIzsYbioGjsrK8X+Th2cr4/OAAxEU5FDGDyd8QY7QPA9AwnsOE5GyzbC88?=
 =?us-ascii?Q?x6+HYb4GCN2UT3O8G5AdC1ZuuXuOgmzw6fCBl1JdnqBw7h0zG03Rw3WMnbib?=
 =?us-ascii?Q?HYH+G/TkdkaS6H7g/XFD/xiQmCRUbi4BKQeO/itSGCuofu7ZakwAJcImcA9U?=
 =?us-ascii?Q?qXHL+jGGuLCq2hups02Na7Zic3EYyY1BA0CauW1YR8OxVDvi4qWXZF+vtnov?=
 =?us-ascii?Q?rz1/Zu2caLxF9f3ucRgHQv8A+yAfoFrLow7qT4bRivvOWojVo9wo+JVvimu/?=
 =?us-ascii?Q?pnnQbqYdQNhkPbuTfF/ypvSBV0qkne6e4qqVSGwlcjl9F14TPMakquluc8iV?=
 =?us-ascii?Q?PFgc0Q9Te5pluvobUwEXVCP+9x2sqk1S1UvDPgxykFXBJ36fBqCtO0hSPP40?=
 =?us-ascii?Q?WWckwfCKPb8GY3j4U8zDv+VwktyJIXg8+LIYPf7OEqFkcFaqC0yNaMdSR2ah?=
 =?us-ascii?Q?JdxywoFIW8aR2X5t5Snirdhmj1V1HkK/UmJXxJHQ2z2A7qrN4zGdY0mMFE7k?=
 =?us-ascii?Q?calvHTGJWJ+ov0qBufPwEAisEPywyUgzlWfJllUiDhdxI/0Wp3/MuGGG9Zn8?=
 =?us-ascii?Q?/Ca+U/BEcWgFEEdFujzmUuVlv4NqOHhOIb/h/4Mvh+gy/pD04pT28PoshPQp?=
 =?us-ascii?Q?mAX/RgHJdfdT6/ZKU6YLkCG5ULP+USdXnJF4cpaos01qMQZPfxLFRhs6oEWv?=
 =?us-ascii?Q?lckvOFtuSZi6sH/CB05ODUgAPrjiXM6wa1aRLkFdFlkjTn+zvvhqnzb6XK8O?=
 =?us-ascii?Q?oPyFYCtKEFdkaTjbtj2Dw5TCbuyKuiNVKIvcVYpc7REKVLNdhP3uxjkGcUH+?=
 =?us-ascii?Q?Hc5CJX7UzLpfRswbpZopMP/s7m3uH7HHyRInfNCcR/llFJDCAYEMF4FPziDe?=
X-MS-Exchange-AntiSpam-MessageData-1: 9BCoDrM7FuWSs/uicUnUEEndZmEZqyNiAjM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5782b-fe51-47a5-6afb-08de6f0c58d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:39:55.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Rhj7ECW8kR6qYQWQPZXqWyvpRgNA+e5c2oEY5JH+HpXeZ5fY0KRclmBAGf/hlcL18VI4ntdgaHsax70ronxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259330-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 8D661157D1A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:21:53PM +0000, Russell King (Oracle) wrote:
> > > > v1->v2: select option 1 instead of 2
> > > 
> > > Given this, I think the paragraph above needs updating.
> > 
> > Sorry, I don't understand what needs updating.
> 
> Oh, you rearranged the options, which makes this changelog comment
> wrong. You're still going with option 1, but you've swapped what was
> option 1 and option 2.
> 
> So, the changelog comment should be:
> 
> v1->v2: implement option 2 in the original submission, swapping their
>   order so it becomes option 1.
> 
> since "select option 1 instead of 2" is ambiguous (obviously) because
> it doesn't state whether these refer to the initial patch or this
> patch. I assumed they were referring to the options on this patch,
> that the options hadn't changed, and thus "So, I went with option 1"
> was an error.

I didn't rearrange the options... They are still the same in v1 as well.
Why would have Andrew said "I prefer option 1", and you as well?
https://lore.kernel.org/netdev/877b4780-9f99-478c-82fa-a32817d72004@lunn.ch/

