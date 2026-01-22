Return-Path: <netdev+bounces-252275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH9wHQEGcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:12:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013B65C5B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70C384F51CD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F23EDAA4;
	Thu, 22 Jan 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UiKHBziX"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249413C1982;
	Thu, 22 Jan 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079440; cv=fail; b=OnyOjfrazhqVev9JHlVwLv9u3lo98iX4Y2MNlU00l3n85vKGzEiTqfjZAYHGrDuBPe3WGkO1/aXbG4MccJ5scLXvjWhZNoSjq6ubxi99AOTDsgyHBkEYjOiNfs/nsEn8Y36/ihFPb7iKZ822NeIQ9q9TdjF7fplyB2ZtEeHvKF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079440; c=relaxed/simple;
	bh=BGzDx7BFHsfHXR0fYbugM/K/15JLt/uHm9UcJ+XoRUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwX0zJ03msfQi6Ot/Mp2u69Own0HkNSkT0Mn9aUKSBBDc8xfGAOCouiyxWgxevMP55iX+LHoW9QWlkOkQ/OUumMyJ5WWkgkb1XtVEYsY0e2ei7qsB16FPpvQwfCeBzAECwS1D987e4d4PFdYZdC6+fOPFQZzw/3/CVL1tJDrQnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UiKHBziX; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K596FQ3lCwi6fmlP5W0ABULH4FLUsLs21TUHr1yxA2Xi7/1cqbU7B4nOrnH8xCGiHskokHzJeDoKrblJXkiyaaAJqs9gEfhSEbkNRFzzLqiWuk8YXN8XI2LQULMkDgO4YuCpxhEAuct+wXf04u1s5kVV0LXjcSvKVIdBcfFNIMCyqcrOtqbwf4azpddyb6xAcDCzs1fN5jtcU1yaPmIYZquRYMbofGrFqCLpWp+zwY8woZZQk7tlHy7W+yDioMJFaT5ZChq00DAYN3H9LhAZd0uIZsUpyvX0rK9+HeW8FOugPq/GSjI4sOoJAP6qooGO+5fCtMPQw/CO8B9zuCnucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HukDWN9q0nEzGTQh+dJ9zTAyRb0UhRs7F4lqES+wHGc=;
 b=ypbGWR6lV/glwF+y3bAU6rhyqxV0wwdET4nAsbjvTldgzAhq7W0xGTssYq/+zO6ip39mxLrYuQqU7bbSheS9Lx/4Jubn/IabsJx9d8DMVisFWg/LdM1pTgsxitq01VdqNyUje35uozr0Ecvg3+mctsV0RwMRURRrvz3Kz/cxVe9AsSUBVa34N7ykoY2r4ZBgwgVF4cRDvXajTwi7X3sNzvsBCMd0bAgcEBFDTlGEMipVGo/KBb5sBsrQGdNTURb+XNWQAWNmQFejylwLp9vjv4gv8hltiprx2VYM6QtvlA+ApkTRwpDf/VmYtd5A2AGJ8+L7tFoAUzZlDFR2RuoesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HukDWN9q0nEzGTQh+dJ9zTAyRb0UhRs7F4lqES+wHGc=;
 b=UiKHBziXUPGhVJab1A8BprKc3qUyGv3i1vVERx6l2yIH96SnsrtUn+1ukxu17Fz6ePUWzeAU1/rd9uUnCBYza7DnCzp1LXJwc2AsUJKM/xGIye00SiJUPj4M1F7raXrMr4CR6xgCP9KvnwtKWYsCGcTWwAYubFcmZgKpFBfEsD7Ezb9qaBhi2hGy21CIu5FGcEIBbF80X9qaMq29Q+VqVlnhK8wEvX2d8jN8SaF8vGsHsGVp0ByZfLoncwM67m0Q69fBCYxoaJgukTS0WxB5R+ofdL6fmFU5+t1+RRB5OR86VcMXTp98I9Z+WG4ZA9db9HcToak6aRr9ISH/MrlGWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:11 +0000
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
Subject: [PATCH v2 net-next 02/15] net: mdio: add driver for NXP SJA1110 100BASE-T1 embedded PHYs
Date: Thu, 22 Jan 2026 12:56:41 +0200
Message-Id: <20260122105654.105600-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6e6bca3-9075-4128-9874-08de59a4fe63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ULSBXqF7hNLPNxpHlUGn2ZCoMw1CVOe9yzVfZZe6vw9iwjPDrZCHLlnom85R?=
 =?us-ascii?Q?cdeInzIP40w2y3Ma25pk6oT0BkbrKvS5/Oz+ohM82RZT/H3ZcVMUKCBc+4iC?=
 =?us-ascii?Q?TbIX8OkFu0YtUCnNnXAFHjo+nnLGPcPuvDPfgcJ98hyJBBoNU5Rs/IkVKycM?=
 =?us-ascii?Q?UGIpkhIN6voYK9F6O9Q1KJeYnNhU4HrPaW1bsnUguUrK7ftf229vcBQZBts2?=
 =?us-ascii?Q?SUT41NPgOO2pKkRCMvO6B8Y9lt+y5I0CUJgBnWwmyvmZYr4JWjVYDKoC3rev?=
 =?us-ascii?Q?E+cI6DOMz5TgsSCXbd9JrsvFmfG1K4AIXCCX7HV6vpXeuGTQfdbegUK2xitR?=
 =?us-ascii?Q?yWf8for/Hphy2ioQFNp6Y+im9OJlFtLzd2Szt3lxUFnQvYgkHcafQYdo821c?=
 =?us-ascii?Q?K3tEPCZKxjCYMDBJCWYV/Ds5RVd0wHmkbrBMk4fKE2rL0ecX6mXltUj4P+Wl?=
 =?us-ascii?Q?xSqFgyGofKUjkEgC7Fq9xGJVQ/rZm0kB0mzdhmR5b3VZ8uC2eUBX+YJCdPjl?=
 =?us-ascii?Q?tWTL3Ro+6nlG0KRhGyRUCxu6eAeO31hGG9kXdueMLe9B2XQbK8HnKW1f5o1+?=
 =?us-ascii?Q?f1yuiE1kL2qTneEoUuWnrXTTeXTpVP5zxf8RfhIHHE0FMEk5c0Y1DC7MioI7?=
 =?us-ascii?Q?KPUxdCM+YbZEz/qsSwH4w+LFkQ5PlVMMToK4ursH2g13uxKH6k62xmXXmHpP?=
 =?us-ascii?Q?p6x8RosLmXQurylBeKOnUjc8LLGS4o4TB2hyMJ4kp9H1A7Wh++CThD0T26LD?=
 =?us-ascii?Q?aL4+RKvB8XJ9UQ57pyCIdsCCC5T8RUOBtLQEo9SXxVbPbZ/L73iWOqGYBaAX?=
 =?us-ascii?Q?eClMuD1xhVQYXwYxzA8ZUUkSItbOKDC8YhEgrrLfZFSCm2ODgZGnuAHwGEcK?=
 =?us-ascii?Q?WYz0uVxL9KbuTH6HnD+gPyOP0Rcg6jNVxraTlh8Ume7vU868VZviPVcQEzSy?=
 =?us-ascii?Q?ExR+17+MzX8XlBqVI/44m/XAd8OQ5VuCNZiZ5qSEImHBaLEyrQzTa7qSxrQh?=
 =?us-ascii?Q?HFDp9szaVOVIBYgVySD1w0Ntn1cgt5wbFhZxMTdeusvT0ho9lr3afVmK8fQz?=
 =?us-ascii?Q?P+KiiHZxIc/3HqFxvNqqJHG8bZJWaadgSL5EzD8PB09zCthE1HKucjvaGMMC?=
 =?us-ascii?Q?wtr3SSNm3rNkaqwHMnX44d7Y+qmdx7eo5XVIRvMW3Ng/cf3fs0PfjlCtMOUV?=
 =?us-ascii?Q?dBW6nJkBASsmecf3BeWDoTGBHT4XxAlqlN+mFVS1/2q+fjJkzYNcY6jvlrIQ?=
 =?us-ascii?Q?tffOZbs3ACbbLO5bBlXxGudsj7SP5o+6+2bNTZnlgoRizAZdoc2I+eQw01cN?=
 =?us-ascii?Q?kp0fRKSOyyDltpuHNa8jlJu48/SpAsclMSfD1AXugdw0bvdtHxFUjp2AhG3J?=
 =?us-ascii?Q?x16HAJqi0niGsdAqD6O3U3MnJI21t6cmlKl2Rf7AErOAPg9nRoobTEfhk4cs?=
 =?us-ascii?Q?GBwbRh0QDThEXTUjGCrTNF2niBqiaxC5bUzY4LShsEuDcC68CHWj5mBCZBIX?=
 =?us-ascii?Q?cIaOnIEXVWCCGPuWHDP8VHm+oPeTKJc9rwON+0mquach5cyLNi7GaTQgaOLv?=
 =?us-ascii?Q?o15Ien9aZqhFXgRiYKaRxCLH/ltDq7AortgDO2YREy5dGEECsGy2CHUsE6w3?=
 =?us-ascii?Q?Bc391HUlFV+/TJcuc+XAACc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PlnwOsCqtvQu8ak6A/771K2hWz7sUkqZi2Jnvhhdu06jhY6c8RnUbzDH82Dm?=
 =?us-ascii?Q?RAD5N4bcYf1O/6WCNIgGClThBo5kUzxqSwYb9kHYFU3mYe7ikjYMkUpQgK74?=
 =?us-ascii?Q?azRpgNsK1+50KCmfkZAmv2pd8trI/sgPxfSK8Zzz5pPrm5qbt2zCTlRXqmc5?=
 =?us-ascii?Q?BcuVeiC8PKnZ0oZON8KykV+coBx42TcZwtB8YXqHy/XiYsdu2fhU5QhCz6Q2?=
 =?us-ascii?Q?wWr2PQyE+pM9ZLQz4iTB119cOir3c5T2wj3wiB1gwSYJCoBlBqZzpIq7jdvF?=
 =?us-ascii?Q?iPB3G+4K6WQRhbMqZGv8MB6LH5R6zzNXYI/e+wQSA39XOjev03qWm+0uhQsO?=
 =?us-ascii?Q?OxAIcI9Be936owgulLFn3qFOFE+6JUebPUmVaDuLTQMV3DhIpDPx863NfW2v?=
 =?us-ascii?Q?bu5VR0csIliBFqz02sBrZ88ePHIhKpONSYFfewAnk/it2jLCbEnSzbC8mJvv?=
 =?us-ascii?Q?v74u6EYIQTRGE5DctevagZEeMEwxf2dr92VZe5mv8Sv1C8imQxbWxBZYpBQm?=
 =?us-ascii?Q?oHLePoSjxxyZgd+h3UDGooeA/+XbEdNwL+6gPQF87bDxqpNT/62cpLxw3Z5u?=
 =?us-ascii?Q?/qKjC9za98o1Mw6WbLAcTPX6sez/2xGBX+TqJ1t8NS1QGtiJR682mzqb6BFC?=
 =?us-ascii?Q?RgyNsXX2L3HNF+PH616UDr7NyhMF+8WRJqTVUK1ggD+fTNoVSeNdlPwleiCt?=
 =?us-ascii?Q?8lIcvL3gNF+DVmkS0+NVczqrfDgKIt+gAvykrVn/4UXaeoCdw+Sut+zUKoMd?=
 =?us-ascii?Q?JYNGpNjwuZ4WEpN+6VJUMbFZkDXJ2GKhQMm+J+V9C05a+Vr4zdB0Vwq07CjY?=
 =?us-ascii?Q?wCMpX+48f3VZGj4fvmVFueGWBd499TRweFMlq/oyS7F8Cas/6nLPXlgW4eZA?=
 =?us-ascii?Q?6umGbv6pqJs+Kq45t7jIwyxrBMytr4XfiUlVvluewW4lK4uqKpaobtqBUvaF?=
 =?us-ascii?Q?qJJUh3Z3FtZPhCAw70cbA4V1kx5rFiIoqtgVZrhfN+mByyVSvysi2yWcwEaV?=
 =?us-ascii?Q?i5rM1JOqgfQHz2TpCoav739GkMzuXY+9wl73ykR/zjh7G/h7uegRvfoYHgAM?=
 =?us-ascii?Q?Ya2XxL5aq24tjSt9zghcMoEefIZcoWKSoco32CmdSKlKjGun/KuKJlMTOziD?=
 =?us-ascii?Q?lJ/fv7nrrR9Yu32sKIgSRWzFAyIOU+vcLs+qKfnf4y5mBhhloxD4Zr41zmBZ?=
 =?us-ascii?Q?lKtUZ64OOOpKXMoABGDdqId18DleuFJXkXemYXBJJ+6WV0FKKw0zgX6g94kF?=
 =?us-ascii?Q?yutBVSduc4rJr40r2u++GmLQp555jE4R6kUCuaR46qFHCEdbdk/f5pJrh6hi?=
 =?us-ascii?Q?fVcV3wUyez/Zq5vd30QNCBiA3AuypBTZSFUr31ZwjQLnfb2i8nxgsT0epm/Q?=
 =?us-ascii?Q?9Ff7FG07lx4Hm6lzMNr9udufrQoPhjDaA0Smm9czsojKbDmePnIFFM+3yNA0?=
 =?us-ascii?Q?yftRqsyfdeRGTSLH0Nheu4xc5QsVH4FDX45qrYz3o9gKaK91fVCYNNZu7hFW?=
 =?us-ascii?Q?g+GOmNF7yM0RuNoF6M+ZpS/O9SDNDIwo78fCjEmxhxH1XlV2CxdLJb9F7cqP?=
 =?us-ascii?Q?JrpIyYrfY+Cg3KbzOneWjZNkfw/efxiFCKQKociMe+k6FhqCRYdIxYwbRnab?=
 =?us-ascii?Q?qgjru2XNXXDGq6Ht6/5GV0KZuwNGZVX37vFsiqYc8NhNizIaI4IMO1B4hZSE?=
 =?us-ascii?Q?7KliJc6RBjDej1lF/14VsPhBZvWWULrWSmojPlemvSRIi8liTmOIEvGHQ9L3?=
 =?us-ascii?Q?WjnV6WT3eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e6bca3-9075-4128-9874-08de59a4fe63
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:11.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJa5Z9jPlVkflVZmkcrQc6fLDGyQbNDRytVlwubKVlldSRGAjYYX1FgVDvwCreC+UyQ+uATI95KPHX++eJiANA==
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
	TAGGED_FROM(0.00)[bounces-252275-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 1013B65C5B
X-Rspamd-Action: no action

This driver is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
In terms of differences:

- this one uses regmaps provided by the parent as a method to abstract
  away the sja1105_xfer_u32() calls for register access
- the driver prefix has been changed from sja1105 to sja1110 (this MDIO
  controller is not present on the older SJA1105 family)
- in the sja1105 driver, each memory word has 32 bits, so addresses as
  seen by regmap need to be multiplied by 4. This affects what
  sja1110_base_t1_encode_addr() returns, and is different compared to
  sja1105_base_t1_encode_addr().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: use FIELD_PREP()

 MAINTAINERS                          |   1 +
 drivers/net/mdio/Kconfig             |   7 ++
 drivers/net/mdio/Makefile            |   1 +
 drivers/net/mdio/mdio-sja1110-cbt1.c | 179 +++++++++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-sja1110-cbt1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 92768bceb929..d3fec699c577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18948,6 +18948,7 @@ M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/sja1105
+F:	drivers/net/mdio/mdio-sja1110-cbt1.c
 F:	drivers/net/pcs/pcs-xpcs-nxp.c
 
 NXP TDA998X DRM DRIVER
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 44380378911b..9819d1dc18de 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -136,6 +136,13 @@ config MDIO_MOXART
 	  This driver supports the MDIO interface found in the network
 	  interface units of the MOXA ART SoC
 
+config MDIO_SJA1110_CBT1
+	tristate "NXP SJA1110 100BASE-T1 MDIO bus"
+	help
+	  This driver supports the MDIO controller embedded in the NXP SJA1110
+	  automotive Ethernet switches, which is used to access the internal
+	  100BASE-T1 PHYs over SPI.
+
 config MDIO_OCTEON
 	tristate "Octeon and some ThunderX SOCs MDIO buses"
 	depends on (64BIT && OF_MDIO) || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index fbec636700e7..9abf20d1b030 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
 obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
+obj-$(CONFIG_MDIO_SJA1110_CBT1)		+= mdio-sja1110-cbt1.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
 obj-$(CONFIG_MDIO_XGENE)		+= mdio-xgene.o
diff --git a/drivers/net/mdio/mdio-sja1110-cbt1.c b/drivers/net/mdio/mdio-sja1110-cbt1.c
new file mode 100644
index 000000000000..f170b63c7f69
--- /dev/null
+++ b/drivers/net/mdio/mdio-sja1110-cbt1.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2022-2026 NXP
+ *
+ * NXP SJA1110 100BASE-T1 MDIO bus driver
+ */
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct sja1110_base_t1_private {
+	struct regmap *regmap;
+	struct mii_bus *bus;
+	unsigned int base;
+};
+
+enum sja1110_mdio_opcode {
+	SJA1110_C45_ADDR = 0,
+	SJA1110_C22 = 1,
+	SJA1110_C45_DATA = 2,
+	SJA1110_C45_DATA_AUTOINC = 3,
+};
+
+#define SJA1110_PHYADDR		GENMASK(11, 9)
+#define SJA1110_OPCODE		GENMASK(8, 7)
+#define SJA1110_XAD		GENMASK(6, 2)
+
+static unsigned int sja1110_base_t1_encode_addr(unsigned int phy,
+						enum sja1110_mdio_opcode op,
+						unsigned int xad)
+{
+	return FIELD_PREP(SJA1110_PHYADDR, phy) |
+	       FIELD_PREP(SJA1110_OPCODE, op) |
+	       FIELD_PREP(SJA1110_XAD, xad);
+}
+
+static int sja1110_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr, val;
+	int err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
+
+	err = regmap_read(regmap, priv->base + addr, &val);
+	if (err)
+		return err;
+
+	return val & 0xffff;
+}
+
+static int sja1110_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
+					 int mmd, int reg)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr, val;
+	int err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
+	err = regmap_write(regmap, priv->base + addr, reg);
+	if (err)
+		return err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
+	err = regmap_read(regmap, priv->base + addr, &val);
+	if (err)
+		return err;
+
+	return val & 0xffff;
+}
+
+static int sja1110_base_t1_mdio_write_c22(struct mii_bus *bus, int phy, int reg,
+					  u16 val)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
+	return regmap_write(regmap, priv->base + addr, val & 0xffff);
+}
+
+static int sja1110_base_t1_mdio_write_c45(struct mii_bus *bus, int phy,
+					  int mmd, int reg, u16 val)
+{
+	struct sja1110_base_t1_private *priv = bus->priv;
+	struct regmap *regmap = priv->regmap;
+	unsigned int addr;
+	int err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
+	err = regmap_write(regmap, priv->base + addr, reg);
+	if (err)
+		return err;
+
+	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
+	return regmap_write(regmap, priv->base + addr, val & 0xffff);
+}
+
+static int sja1110_base_t1_mdio_probe(struct platform_device *pdev)
+{
+	struct sja1110_base_t1_private *priv;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct resource *res;
+	struct mii_bus *bus;
+	int err;
+
+	if (!dev->of_node || !dev->parent)
+		return -ENODEV;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	bus = mdiobus_alloc_size(sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "SJA1110 100base-T1 MDIO bus";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->read = sja1110_base_t1_mdio_read_c22;
+	bus->write = sja1110_base_t1_mdio_write_c22;
+	bus->read_c45 = sja1110_base_t1_mdio_read_c45;
+	bus->write_c45 = sja1110_base_t1_mdio_write_c45;
+	bus->parent = dev;
+	priv = bus->priv;
+	priv->regmap = regmap;
+
+	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (res)
+		priv->base = res->start;
+
+	err = of_mdiobus_register(bus, dev->of_node);
+	if (err)
+		goto err_free_bus;
+
+	priv->bus = bus;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_free_bus:
+	mdiobus_free(bus);
+
+	return err;
+}
+
+static void sja1110_base_t1_mdio_remove(struct platform_device *pdev)
+{
+	struct sja1110_base_t1_private *priv = platform_get_drvdata(pdev);
+
+	mdiobus_unregister(priv->bus);
+	mdiobus_free(priv->bus);
+}
+
+static const struct of_device_id sja1110_base_t1_mdio_match[] = {
+	{ .compatible = "nxp,sja1110-base-t1-mdio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sja1110_base_t1_mdio_match);
+
+static struct platform_driver sja1110_base_t1_mdio_driver = {
+	.probe = sja1110_base_t1_mdio_probe,
+	.remove = sja1110_base_t1_mdio_remove,
+	.driver = {
+		.name = "sja1110-base-t1-mdio",
+		.of_match_table = sja1110_base_t1_mdio_match,
+	},
+};
+
+module_platform_driver(sja1110_base_t1_mdio_driver);
+
+MODULE_DESCRIPTION("NXP SJA1110 100BASE-T1 MDIO bus driver");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


