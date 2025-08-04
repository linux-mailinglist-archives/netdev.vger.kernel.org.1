Return-Path: <netdev+bounces-211501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460DB19B80
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 08:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE3618973A2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897F22A4FC;
	Mon,  4 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="tKdzh1vh";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="i5D4b79c"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD42BAF9;
	Mon,  4 Aug 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288305; cv=fail; b=QMifu7RMri2L5wRM5qNglTUOIj/IQLZ5iIowP3XmZ58ISQ+gF0uKYcztJLWacji1kxrRmpME+6WTPBfJDXqt2Mv9r53inGzzVyA1P/i05pzqE6rgLBkxpu3Mch+RbIXVw8Q5k8cAdTIwkjb1H0cvFAkDy4i9LjP5AxCFmmWLxI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288305; c=relaxed/simple;
	bh=TNUY+y8zg3+dLuYMJon6UOc2uf/2nS0P9aKY1bgFfmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QM9mjxwoNLhYXzv1RQ7YObwlr5CWeOjk+6zNhT7nlC2j5rVodZ4XWfofZV4Peg5YQzm/mmnfnhjPZSz08kMoVo+Aw+fC3r5jUyyxqmOVmpsLi7sFo3MgdPe1WzLQjmWb+iThJJP0YWEp7lxGA8G6NeXRZDC0iVWBe1FnjzXDUfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=tKdzh1vh; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=i5D4b79c; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5744YdWW1042071;
	Mon, 4 Aug 2025 08:17:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=nRLR0AqM83QRXEgHS80fACD2
	sjFrk2GlH76s/vNLwc8=; b=tKdzh1vh5h9OeUxOuTUcXx5bt0czhJ7pJtWPgwVt
	i+2PuOZBWTYTmgGqLK7U1RRom4USZB/n9PGM1arQl5LfzW+s+tvoO1csi5vTMhWi
	R2mZmXdF0FE2r0ZaUh0oCzaEINbgsFOpAccbqBldgonn7OwRRgXe9cpV1esA2cis
	PbemPCCy67pxsUg7Tq7ny5dRiLLBVZ2YPWa+yrrSeQ1mYpdU0pHOwziNZYnwkgMV
	+h1e7R7jZnyXQAyRz6QLkfwaDk0kbCg0OckekDpJFJ5V/+93dN9mMl+vO0NdUHAB
	yNOxhjqssRCkGtWH7FFxNqPfPeUKG74caY08Wm8gkXlSqQ==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2111.outbound.protection.outlook.com [40.107.20.111])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4896p1sctr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 08:17:54 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuexuFBGStRiTy6Qq5K3PSrYESYXXWgR7RMI76I0tqzSBbV9RXe/701mE+FLvVCVGO1HlbY2BosZEkyxiaNfeGlZBWqZf1kxokNgtGn3zX9qune0JIbtf1n+yWiFWua05M/BGLBkFhLu7nYWNU8LMgv9pcbQVPd+wTTcIDuxFzm7V5xPMaoj3aH4WoEOrm+D5OdB/4u5QtgTtFIfoOCFbryb9ndZFXWjAbSH0zxeuRDaPEsEicBduzKVSdpPoUdgGlPMPKeOAQGe50BZ+a1/OdBUzl3I+I6GwpTwXpvGZ0gXFOagC49rWUh8e1w4t0FtrUWwdG7jNVAzI5FLZFhOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRLR0AqM83QRXEgHS80fACD2sjFrk2GlH76s/vNLwc8=;
 b=ub2Hbc+lXAy7MIG1n9sVB4WO7LhtA6pMBeJWPxsAD6O/hNuxdmciqtfQ0PIGPCBqvv6oubKenBQvQxv3wm07Bhcvv+JQ5oqySIwijrXwLg4sxF9sivxNRVUQE3c1fUf/4tqz12qCleQ2fuyWT/ivZG7iZqNNtLJ6qaM4PH9np8twoEtCjgIfGxfwVIXUM8sAnUQTPCcsqohe9pE3gyQhxgXCXLY1o44xMO3uhAv+JDXl+BoTHpFb9nqzTSMMBPcR+QWivnPux0Mpbum9al/jFUrQrsPm0YCrqXy2tH0a/QW8zXxdn2U2x7Q5eR3x+Ei+MQbP6FwF53ZiBQeLVD4vyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRLR0AqM83QRXEgHS80fACD2sjFrk2GlH76s/vNLwc8=;
 b=i5D4b79cNw39KkRt3p/c3TJDPG+ZDAgyYdg8OxjUjRn2jpQWtK6HQ0D7JJJwkkxzABBCzJmXYYLOP9J1OIr0zmQrHjRfg/jEQsIGijF+xoV1jD+ErFnBJDKepg65/EDSS62D2EWiSs+5cV0wZUOq9Y/7bGhAQq1UHrjN3DZwK4g=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PA3P192MB3014.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Mon, 4 Aug
 2025 06:17:51 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.011; Mon, 4 Aug 2025
 06:17:51 +0000
Date: Mon, 4 Aug 2025 08:17:47 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
 <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
 <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
 <20250801130420.m3fbqlvtzbdo5e5d@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801130420.m3fbqlvtzbdo5e5d@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVZP280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::9) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PA3P192MB3014:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9fcb32-cf0a-4431-0913-08ddd31ea422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ah6H6XeAvMF15GQGI1mZOw7qpVhJ+eKxPFRasEsRYgT2+hEAJyzbN5kgbksX?=
 =?us-ascii?Q?LgiWgVkMhihAkPD+Fwy0mN3LvxECZe4xWQ+RtUyttDTd3g02cyi5j3OqxmlC?=
 =?us-ascii?Q?NPGJ7kwU8hdKFlwz05ESzbg0zoPF4lsUsGiWdCbHVX36sZ91bTlqVXYJDm4Q?=
 =?us-ascii?Q?9w9T/65Q2+VtizKqCdyqZQA9oLoFoXyKiLkJqU3iq+ZZYP8Os3REFrgtIKxy?=
 =?us-ascii?Q?99v3gFWzSgaPmbiXFhsdAiqwojOomlHy9Blh0cNMHGYHo/l/pQ6zLCBTcihC?=
 =?us-ascii?Q?cljRUpltN/1PNMtUc0lxMuY/Hnlnf+cBY5CfVSX48/dMAo2EeICO9VQRiYo1?=
 =?us-ascii?Q?rdriovKmPblZQPiRsjTs+dZMyGGfZUNcUqeWsPEGxjMjCBlhAlLWHetRI5hI?=
 =?us-ascii?Q?NNAZ9LTo6mYLgxXhJhlyLy/i7oOp9B5YnPqd7gT8q+O833ihxZqamz2mcO86?=
 =?us-ascii?Q?4cVVxkL16BPuvYE7xrweg1h5mdG3pI4UPUsmwX4N7o332ruP7vJxlsASr2Dt?=
 =?us-ascii?Q?6Hq1J6QorUZ4v/I0QZcsvP0QF92aNCGt8+AQlnW6aL1PFv/butCUpcY99ohl?=
 =?us-ascii?Q?GDw1T9JC/YoJf4B6Ay7iivhxdB57IpIKXrohSt7RfLDnKQnLn3agal02m7OW?=
 =?us-ascii?Q?8qDbeb+ixzjoDRFskWY/eJymnZIaHcWdkkFdcuz6wPQfMLPLkNV6CXsSuE/G?=
 =?us-ascii?Q?FXvYuwC2DHmNulPXvWXFeDiPAeX3OxPu/QKQR8P16Mm6mQOcExxSwnNGEWSi?=
 =?us-ascii?Q?QcV/Qh2MMKwzdGSQSp7HKK3fENlucTNEJBkyQ1NpbazKaaAjGjxDlaBBX/E7?=
 =?us-ascii?Q?UgLvUVpW7xEzFHAbV5ZtgpuFtgrpLjRpZj65NYlMpzkevcRTVUaDJqiVwdih?=
 =?us-ascii?Q?EczSWHhpJD+8rxAdTMNvlmCFNQrHOpj2frSf1AsUhaZwEGZ+ppirU4JytZku?=
 =?us-ascii?Q?LpcxtJZKLrzHKVPT4ZoQukuxluBNapLb6tEy+ZTnv8pdYMv2Hx2MfuSe7ikY?=
 =?us-ascii?Q?hNiQ+QrK6KUrh0MMozCVE5ASIivq+3aRoDpXYPsU+I9MoUdFrpnexoGApkpr?=
 =?us-ascii?Q?W2vnCmqg0cVFB80YVr44dsuHO/N6EsOj/zE8Fp73hf3zpK/FS9Zzxjpoiwlt?=
 =?us-ascii?Q?Us8AHf0GpPm0qjDKnDsB1ncvZUU0AuYnwLVWLmNciXQFroiAqsRVN7e1y+3Y?=
 =?us-ascii?Q?LoXqduAa7lQ9q2oLGauVHRXRwD9rosePFGjqHe0J6Dm2/SpkAu5cxIfx5+Rx?=
 =?us-ascii?Q?nAVC/R0IZ+2pw7U3Fgs2gvCPgM+4nsbv2RXZKRha48YWrQxcO/qZsroCPNmE?=
 =?us-ascii?Q?1Ymt/NNqgUCrR3ep6RhO5gYeQoyAYC2jJiPi0oXdhaX+EaIWRx8dQCVVecS4?=
 =?us-ascii?Q?qRdT/GPJ0jj3iXVbMmm1vNN/V6VkLncMNRzK3H2pnjmgDu2FXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ucWmPthV0n6P5KoNwEvwBnFW3cQM2qyBv5FJNlCNTegni+Qwa37Rwtwxb8rR?=
 =?us-ascii?Q?TrSj9vKrDl+HgAltFcDwZWxwk06FwsIcuT240NwVr4Yal68NG5OXKaNASK2/?=
 =?us-ascii?Q?XQ9k7K3svjD7scz/JcdQm2+Ern9LsSDapkWGkPzwmx6Lh13+qJ2EuhvUQYab?=
 =?us-ascii?Q?FARhjltTNSCM1wnjSI730evuxfdFJQHXEOef2sSzIq2DZxk1vuM+9ryFEagG?=
 =?us-ascii?Q?KPY4Ns28dNzttLha1zLsmoXavwPDqUQGtMLInLNM+aRpa9sZoUx0ZA5vkVQO?=
 =?us-ascii?Q?hbVlcj2nSLZKLpVJbGS5FekOmY4GWHj/hrTW8p51/Yl7X+AjYJs71ODEFeo/?=
 =?us-ascii?Q?nL3CVTndXqlHGdHoKF4susRKRMmmRpF8a9xFyC6ZK/76sktCTXtzWGZgcyjB?=
 =?us-ascii?Q?aH4TDx0g0HYixkzYBgAHnysVKYs21ejG2i9LabFRuZfabxBVFRgKb/rYmKBJ?=
 =?us-ascii?Q?70dvzMXfAQX43N99E9rFyV1iYf9Yjrfh1SVaj88685VO0D+Q1CW4FRfRPKXq?=
 =?us-ascii?Q?wH9Cg8mqZWWat1X5amc2Fz4a3kD8gw80b+4ed8J89KG/Y3sdCNwMl6jF9ZCk?=
 =?us-ascii?Q?AFNbCeOpYY5+8OqfelGuoi6He3O7BNdoJUskxSIyM3Mmi0Piim/95AZWPwzk?=
 =?us-ascii?Q?umfl0UHze/Iz3KS6POh9OZ3LW0Wr/fLwA/W3FdQBSN9RcEG6bjsoHO8OxcMR?=
 =?us-ascii?Q?rRXyMTXAGTTfrWzNtzCVcVXWJS2l4IpHg79jLPQbTpSzoqCY88LXm3OjkAVL?=
 =?us-ascii?Q?whWatRQzxjnL5lNf1JdnfVVnKRqoAhaft7PYLxSRY3qfZGfsbv4VpXLBv+BF?=
 =?us-ascii?Q?ZRBJr2puuTHmrDtzlZE4OnWYOF0ojyupSwl3Yzcj/evwo6pAgfQdCcz0h/Nq?=
 =?us-ascii?Q?WegIZuh6t2wREeaw4xEJSZtenPSJI8cBFYOGdH/gT8HqyFtRlR8bDq1dV72W?=
 =?us-ascii?Q?N6AltFLelcdMqHkt7/VqLvi2sCc6mxvE1dpM5KDTK5QR5hn4ljPvpPLr0Oql?=
 =?us-ascii?Q?9Nth42fgoIg4AaJbUw0FaENFXe1bQ1RfMosyKMY3/IluI/uhKgapOeWdZL/s?=
 =?us-ascii?Q?BPQ+MaP0NLs/ZIL+MjNKBBtxIDmLna+MTdG0uBPzyKXQHG08XhAChqScRbTr?=
 =?us-ascii?Q?pUFtb7GPKEExsqyGNeutSG/CZKV4K+opcTl1XDme/ShiovTcDZmOCW7fVHuA?=
 =?us-ascii?Q?3buwCO9ZEL4Nme8yBs6jSjpUBB+DRjE9k/N6poFpepHsGI7VXsAhUzYwBmXy?=
 =?us-ascii?Q?1wAw4fdKTH2P/lKQZtxvMwdEtwB9XnqVi/zmlPLC7uD4znp0JRCfH4xDA29u?=
 =?us-ascii?Q?JmkrP+PYhsfr3FNJrvtxyRAAjOKfCUum+sXK4o4ZbihY4ltgw6zpI+0Owpy4?=
 =?us-ascii?Q?Vf4eJFkd1k2+pY4YcTfKzjFvUZDMIvNfRRmCD2fonwoIf6uWuPZtw7GhaLKZ?=
 =?us-ascii?Q?5NE9ehs91UyNVxcgfcs/dGq1FqkukVqrYRg/G9vV/yh9dWl2c7bfkRdhmVSH?=
 =?us-ascii?Q?/CRLe7gqaNC3nBayBtHzvSl9ZhxPS09+KPf5BISCgUcU0Le4VooQ3nDqIv4K?=
 =?us-ascii?Q?jrvM8O+K9v5VReWXsiMjvhEUhevoI/TqfBEsgXM1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0paCOBb8SjoSNBJGgwnkGIrpfTKVIDtJ27oqKCrFqrKIXz4Wy6uvcBiUqqpFaFwK0W1zlc7hOz4TFb8u7Q7EIAesO3GPrkPqpTLiKf8LT2aeQ8trt9HpN8zCF0fD+r3gXW6KEFoNF+2+wfa0EcpJ+UDlJJgaEqUFEBOgJsVUTnV87OkxmJ3iCbzrXbi3XMafzwdYtlM/rbSwc0YKbiC+dsvNzptGKZRTSgLEKfnGvmy7rcN7+BCHAPkCRfeOWDBBJdNKBvVD5fQBnki80R2PbM1yzVuI7x3NbtKHg7XNVuIYlzOvFj/n44Ov1DhP0KbHT6irYD13PDkquUnVxTvn97zMv60bwivB9sxCHPD745ElHQXC2Jja+TMZbSG4I1dgDVg+o6ZXl3j60AmWvVkxlXSPUwtU5tGsPUloboJR2knGGtbhQW8dEGId/pj/794YAcRmKheGLEVXXGOcehnTWt2XBY80rx2I0BegTYjnANyVjAGyEhfg4djn2Z7ytA0R6en3QHz6dPbG44elJHooTMxOuV/FSVfgUOr6MUJ2WlYuDXhINNK5ibzOVq4N8e9URaKDg/Y0ozvciySVHwEFXQflZ1qOadUUgvaKuNKMQ9Z/+PosohQqeKhkcPjZouHf
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9fcb32-cf0a-4431-0913-08ddd31ea422
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 06:17:51.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kr5NQIz6kx2sY38nUCapp1trgqOcQ8UzfHZGJnNYt4tYv64nZdwHcL726hYPI/6PL3tMatGJ54YyHs+/N54MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P192MB3014
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PA3P192MB3014.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 6nomlsUi8sN5g8eoSbvtOJosPf9ITulw
X-Authority-Analysis: v=2.4 cv=O+I5vA9W c=1 sm=1 tr=0 ts=68905093 cx=c_pps
 a=25yvLdp/56i8tqU5tlvOKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=idKTThOK8e33A5pbh1AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMiBTYWx0ZWRfX25r39yIkDS91
 g3jroPqPVrAS393UDFY9Dn/TXoGUQohaCFYz9XouTKdy5AaRyRZwfon73kTlCTkQZ/dc/mtv+8m
 DiUFySi6FAECsn8fPCVmpFSTrcTjB4DcyaputpCyTQEZ4UUVHgssFAASFVLfk+zW0WOH01jj+7E
 NGZQ5yRkIl5tNzDxgTW05yQOSIs4N6SPCSOMK91S8LX9q0jzj3/arCPfX9t/9xZolJPZUM36lGK
 tIW6d7QN1G2M901NajcsD3nDUeKK3Mbxx5YFIkKoApMAobOWl1sSNDkULBic7KjcMmsspNOLEEi
 0uRWLHUtpj6x5Kaw35zro9oewxalcB5Le6/W/TIxA70hXqvRNaP2WM3BUx9+Ag=
X-Proofpoint-ORIG-GUID: 6nomlsUi8sN5g8eoSbvtOJosPf9ITulw

Am Fri, Aug 01, 2025 at 04:04:20PM +0300 schrieb Vladimir Oltean:
> On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> > It looks like memac_select_pcs() and memac_prepare() fail to
> > handle 2500BASEX despite memac_initialization() suggesting the
> > SGMII PCS supports 2500BASEX.
> 
> Thanks for pointing this out, it seems to be a regression introduced by
> commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
> 
> If there are no other volunteers, I can offer to submit a patch if
> Alexander confirms this fixes his setup.

I'd be happy to help by applying the patch on my system and running some tests.
Please let me know if there are any specific steps or scenarios you'd like me to
focus on.

Best regards
Alexander Wilhelm

