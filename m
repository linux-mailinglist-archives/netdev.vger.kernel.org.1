Return-Path: <netdev+bounces-252282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGkXLe0FcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:11:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D27865C43
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85F038C0038
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A543C061;
	Thu, 22 Jan 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DybhCqbp"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D142E00D;
	Thu, 22 Jan 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079456; cv=fail; b=Y37igdgDwbK3DE7IdxNPhAhkDw/i0oFxoPOcQJlDMoIre5uWr4Pvx/EywFlVSF5Tz/aeBl0b4NtkXXFfdoYwVOzFuEw7Rnap3EVnKDtIIMmuB1XsT9XNYMtuIcrLkAHcgsx2PUvfG11XpjB8d7nRicPKJrF7bhnXROhtc04O2Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079456; c=relaxed/simple;
	bh=vvGIbjLA1X9Gwbc8kPXoLUDdHHKb5xKXbcQ+TuymKfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dRH371cSzGmG8Ts1JW/RY5DmES71fICxSJ5B5AkDfWPiKpaglVm/tuaGwQ2xxe3F/7x1DOazwICS/SG4xOwm3TxA9L6Czd1133s+zRD+YeaRLN7KJfGAEFGm9vqtclg70nmIh+Xo9ZQzbv6BdcOAPheDcv1av10g+FT2KQY7oCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DybhCqbp; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3FdhxiVqmj5oP4q+mhVvrxbs/TraQhShVMVRNt44LuVbOop4SJweHAsCDAQo7ZDj9RzB3xloproDYR+JiR6t2aYccLkku2Bglf2Cd2dqm30QU908rbejjnKfGDdz8jzsFrC+a79Kl9raauNEWFs4v7nfAwzcloqwFJb0n1QhtXq/0oZUtuExH81f80MM7Y1seXuIA4RV/VqYdIUy53495EKW6nZO943azpc3TGNQrLnW3XXqNPDm4VyP3vOQY47Z5ifWFDsyr3lSNRT5lGC/MKjS54hjO0myBshD44HMtE7fapGH10tDE+HAp61UnnnpxYz/CK8ZyTnYfA846dvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZuSq7P55xRHlzYPvIlN5IVdF3QJa5H4o8vX8ObCgnw=;
 b=qs4ID5KG9fnKHARkjdUCtdchQhyzThH1EXEaeaObXGht26dh/UwZi70U5OGUaPeYK61uj1SJsZvG/qHvfqU8ii0dxchdIyXl6FRD9NhkuQYHp7F329YS/ftQj+V2kU/oP/hjRlzEshMtWTjAfxmjThVBAo4utRgNs5fxA//GHE+NJcLbQ+MRsSJhhwntY6bStnY5X1rvLLzu6KujkWTOaoGdWJDj/IMOU8bJ0mlHUBOsIkJErJEZJyOxaaobIZjsUFWc00dPid+4cT5qtgOXokF1LweFCZzV0rS/UNxqPq2zP7MZ9JkD4WS51YlG2+yBh5zz6mRqy8kvuEpR4HcuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZuSq7P55xRHlzYPvIlN5IVdF3QJa5H4o8vX8ObCgnw=;
 b=DybhCqbpBt2v7K2XyJ5bgfqjkAQWFpniz6UmLJFGwRhVE/qhfX0GB5O9UTlBm61+R8IjqOZXdCoSTZRNde8sGZ29GI0hNxESRRSh+/6rkA2LAZA+/TAkZiuZNJrQNOsdK+0dE6B9y6VTHjfXb1f0IclVW+csDDPoLOtDHS4/eDP0JNLCHPHxymAfWO82lME15OYLgZTHvxb1t2bKzmkn9dey2GoLv7/FX3PPlyYRUZERl4oVzP8orraYTQYnvDdwltY9BdEpYF/spWFxj1t8WRnFtXe1Yey1krSKNkxqiV2CV/Skxoaa88Ijka0A0bV9pfoDp35aA/PVOjS1rS5gMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:23 +0000
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
Subject: [PATCH v2 net-next 09/15] dt-bindings: net: dsa: sja1105: document the PCS nodes
Date: Thu, 22 Jan 2026 12:56:48 +0200
Message-Id: <20260122105654.105600-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa0a32ce-b92d-4ccc-63a9-08de59a50578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRAvWchPD0XHZhLR34jz3YK1vAnSEMXA9buNp6a6T+c+PjiLKsyxeYqqxWOA?=
 =?us-ascii?Q?F/YweDeD2jAcszmqyKdq3eLA1M9qwxndXAVOVtyHEUZQkxw/2gKW3N8GR0Id?=
 =?us-ascii?Q?KVsyysBmSXj72N1fxzy4Jnxkq01OBDUwwIG2kL/wzaeXk523KgzYwRmjP+5N?=
 =?us-ascii?Q?CH8FBoqApUPl/hzdpDEeLBh8lZfC4FR+IgPrrCk70BxTdxSAyEJBzcqkaUhP?=
 =?us-ascii?Q?SVNkdxzBi2eX7qaDT/BzUIXbFhttZUwMwAPeyviZJ7ZySoPkzPMuu7tfC/YL?=
 =?us-ascii?Q?6xZhrqIDhJ6/mseKCFUjnGybNIsEQtwqZ+Tskk4PAS2iksAQCEbmO2xreGor?=
 =?us-ascii?Q?cryVugk/ltK8tEZzNbjBJ3nJwyrgKPJMqwur3cEcrKigJb2PU9zFskZfH6W1?=
 =?us-ascii?Q?S3EiHBC/ICsHls/dIBiFaBU/Cu97KdIHxvIHFgAJyysZjpQR9qARu1JC9+fb?=
 =?us-ascii?Q?Vk6G8UCx71Egj/znsOzlGemqBeQ+KKHI4CFprrpvbpenmvJqt/XRw3F+hxjN?=
 =?us-ascii?Q?OAXw7OIbDNhyreWWmIUfc3xaA+R1Z5Mpwrn2NOGl8xsdksV+aRpFpzzPlzNu?=
 =?us-ascii?Q?NOnvRWpeEQ0ki4ec5chZCxAUwSbrcQQeQ4lW8djKqF3wOrXlolZskTm3Mvtk?=
 =?us-ascii?Q?mVV99MBee4ikwXcjxDQ9uWBIZrpvdmrqMQgzsFCZtT2wxPrV7hLcsslkQoTI?=
 =?us-ascii?Q?xDHKl2e/zvy3O7unKLazPiDKSEvXjDlngiuqB1NxAbazeeI+dXxyXVWT4Nuy?=
 =?us-ascii?Q?9wJXcXmnAciHjUUJfTdqxRMyJFzGH8zL29Cn5r9e/bcdMBYxQG/gEQ6TTqq/?=
 =?us-ascii?Q?h7zy0l7g8VEZEZjYPFjlg1vhBHorefh8+HAzflq/+LcDB6aplHvfKN/dLuid?=
 =?us-ascii?Q?7b1lBgt+hg8Ebfc/7BYbJ17NmowPNjDC6zXs1s2FSSKKMu80tdJBvDmeYEOp?=
 =?us-ascii?Q?EFyWpBI35TFplGV29rRZ4uW/UNRCxCcOOyyxVt4VXuRRnWpK8uuKTd4YVsbq?=
 =?us-ascii?Q?l+HPw4EevYAaf6/ghbunhI/o1ZUHXzrKD+D3UxmNiMKCT/oxfVn8dyAFhLuI?=
 =?us-ascii?Q?2K+o6Ew3RUNa8dDiC+YBVMTBKkkskLQ0Pf1cRVHBzHMlwrK2iPAXIWwUa5O8?=
 =?us-ascii?Q?kWdvaIsr4839k4lrn3ORTBMu4xWzp0WJdVqYltvgGoIfSXdSKmfL+EuIgz3x?=
 =?us-ascii?Q?nbi3qMrD8kFZr4Qwe5nHznqdi4d+KoZwgQVbxMkg0ZuHlUiSV6S4f53Aeofo?=
 =?us-ascii?Q?l2LsFj6tHmUu/fg3tdX1xCLdidc1vTvvhBrtXSxm0nc8GfGATSnuYQn4YyA4?=
 =?us-ascii?Q?ViLLcqHy3Az0RBtLF1yTZIKjIZlfx1gYwWyOGzfcNRzzPivjeZH9NuSjZzs3?=
 =?us-ascii?Q?1DS0beRQuLi3dSpZww94CeZC8RS6Ag89HtsRv/ucQJ8CJLkn4CkF3LzFRLjE?=
 =?us-ascii?Q?yuDp0l8HHaMug6yhZpJ4T7O/9TbsObM4YPID2oyH8xn2ezG8hzgvaVhc8Rhb?=
 =?us-ascii?Q?FqeIn7deW1s1OJ/LzUyy0jaR0nJhtd7boKLSFpxWq9/tVerEkLTdTlQgqxNW?=
 =?us-ascii?Q?XSTd5UfHa4OHlt6AVU4R/7Q0c5HjHJy/P8q+N8cP6HckZ4EN+uKL5aLxoPEj?=
 =?us-ascii?Q?NsgoXV6UNxcRXVK8NOG2WH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qknF+vFdFAMG4lWX//Ffy6tNlC4JFnEIgHwgsBvW3/jmioR5kNFmqlM2mH+h?=
 =?us-ascii?Q?qaCP/Sa4QdaCySEKPfZ8B9XjqMU0oQzFFuiMkUmHcseLZ+Wp6NVz1bP27Nsn?=
 =?us-ascii?Q?uvj0yLn1TVSAiqUzVHCYsNPMKeVLue1HQVWU67dvXWntVygfup/svlVFFKNB?=
 =?us-ascii?Q?ACE6FP8MTSWQ+b8r/uZUNVj0vgYmaeVbxBCeLqby5NxPlVf5j6ju6udeh4ih?=
 =?us-ascii?Q?djsZr9uVz6m81Rp/2P4/LH6+K8RaTCSF18OZFhwaaw9eRMEBihewFLTE2L3b?=
 =?us-ascii?Q?uobpcqOt2yfhnwV12FLPjuqEx6IhoVDOSol8tK+/ZsJDZtj3cH+tTDYng3bo?=
 =?us-ascii?Q?dzHxdlsXzsuOo7NHMEuBq2NNj17oD4sR1S7arm4EZsLsvmfzhIoNAXQDTjBY?=
 =?us-ascii?Q?EywHRvgDKap2E0YC/hAyCLIYIM/9Gn/wze2b895N9JALmM/K9o+WeIcbx11L?=
 =?us-ascii?Q?M/sOap1xQ0kNkB/DQNdxCMx3cn3onl4DaFBfO4p1sfjpy9pcpfUpG7C84tCw?=
 =?us-ascii?Q?pyyYnxdmvjMUm+umPA43aZM9omGXFQWm+CruFUiqMSz4lHLSmWcyAUka/Aaj?=
 =?us-ascii?Q?WmovHFketeESFi4+yQSMV82cvyjf4wxEBZUkB0O2W7NgL/rRANIbJzgi5vqR?=
 =?us-ascii?Q?elM5CZVi+hHXj5OizmEYF/FpkhMBU5AQeZFAhzKbAPma1Ub6iMfovYUf8jOj?=
 =?us-ascii?Q?pSphnF3NEB5mPB40vrHt98OqPwveL6Ruj5Jm7bXxNKKrWFZcxooDpBJR6c2A?=
 =?us-ascii?Q?jhFZz7qF+AZ7Hdb5igqSUHhXde0V1iIuwmRn8YwAOjYOLgdXTuzZa8t3/L0r?=
 =?us-ascii?Q?zVypOcogDCgfllY2kSbryZ23LXEL0KzEw3G5ad7HRSQmtXGItOBP9dOoM2i5?=
 =?us-ascii?Q?YWdxEfZfiLuZkr8qixLOTazWYElStenA2RxwWszkdc4r9G2eaZUQ0tQsKiAe?=
 =?us-ascii?Q?ORnWup8NzXwhKARUvg+mkoWbVriA9ehi91c2BEuskHXgql4PIdoBLwCBkmYp?=
 =?us-ascii?Q?NQGLh0iKojq/eEKD7FD6e/h4+StM/QtBjFwKGOVTX4ROL1LDLSkW3MNPsMwt?=
 =?us-ascii?Q?aNrySE2zhnQ9AoYSKN/qABk4LPj3YvnuT0gCV3ZaWMG5bu0tQvhT0gva4c8Z?=
 =?us-ascii?Q?kE7P+Ae66b0Su9Mp/VRWVXiR79zmou4Wo2K9O6rePUXG3JkL+fA/sj6NqQ/y?=
 =?us-ascii?Q?pIkK0GV5BDBgpELtePw7dZhnFVbOg6ikIaskrJb9Z5PJpbRLEmhX+0Sx5Jym?=
 =?us-ascii?Q?oAzyS+KOOHsDbPyMPvmz3NGR3KDsg0tihxsTuHtNHMogChSMHUepABlMNQQn?=
 =?us-ascii?Q?qA6J6vtifujSmovT2LpFMwRlWfZHZSxrOPUTtt8Ppn0+IpdYWHkEvazmv+A+?=
 =?us-ascii?Q?2RmKHdG/HNOcNEAV7RSXUm/PpICLW0gL0SKAvqhMsIEHSFw1QCoO2Bg09mYH?=
 =?us-ascii?Q?gRCwJyUWvoYASt6PNGiDJ9tDt2dI7HYaW+eHOeNtrnPHiEQLG4fcaLS2GXNa?=
 =?us-ascii?Q?kY6vAVqVTnn3EdXaGNAoVqPHu0K3zeD5yORob8Goe/mqIDmq1GOU6sZviesG?=
 =?us-ascii?Q?k/byvP0OTj/nXgxcNaUhgkAhGedNdOqvofCgB8gqgcFKIfZU6pTJZQtbLoK5?=
 =?us-ascii?Q?Xg6qcs1Ewso5KR1v0QkTRDKJytppDzze2ucFStSF5G5rtQD/u33bisM1q4yu?=
 =?us-ascii?Q?HroCjGxYgOtGXjsG/zCfGF+jEwXQCi5PF3HcckI5K7Cr+i1C4WHPHcI7wbvt?=
 =?us-ascii?Q?sLoGmtAMvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a32ce-b92d-4ccc-63a9-08de59a50578
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:23.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8BzOnYN4jTbEtUZBNf0pKVi04RgEq/r+kThAV0F5/MBZ2UoCC3Lux6TcAaQwp624XX2sfd7Sb/TzgUerT4taA==
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
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252282-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_PROHIBIT(0.00)[0.10.201.184:email];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,0.10.197.208:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,0.10.205.160:email,0.0.0.0:email,0.10.193.232:email]
X-Rspamd-Queue-Id: 2D27865C43
X-Rspamd-Action: no action

Some (not all) use cases are in dire need of describing the XPCS blocks
embedded in the NXP SJA1105 and SJA1110 switches in the device tree.
The use case driving this effort is specifying custom 'rx-polarity' or
'tx-polarity' property values.

These PCS blocks follow the same bindings as the other instances which
are memory-mapped using an APB3 or MCI interface.

Since the SJA1105 applies the
Documentation/devicetree/bindings/net/ethernet-switch.yaml schema
directly on the SPI device OF node, its bindings are incompatible with
describing address space regions where sub-devices like the XPCS exist.
Namely, ethernet-switch.yaml wants #address-cells and #size-cells = <0>
to satisfy the unit-address-less '^(ethernet-)?ports$' child node.
But the XPCS sub-devices want their unit address to be the start
of their "reg" region in the switch address space, and that
requires #address-cells and #size-cells = <1>.

If the SPI device OF node had an MFD-style schema, i.e. "(1)" from here:
https://lore.kernel.org/netdev/20260109121432.lu2o22iijd4i57qq@skbuf/
things would have been simpler. But that ship has sailed and we need to
continue supporting the direction in which the SJA1105 bindings have
started already.

The retrofit-ready compromise solution is for the ethernet-switch to
define a custom "regs" sub-node with #address-cells and #size-cells = <1>,
and this will hold any memory-mapped sub-devices, like the XPCS in this
case.

This solution could have been used for the "nxp,sja1110-base-t1-mdio"
and "nxp,sja1110-base-tx-mdio" sub-devices too (although that ship has
also sailed), and is further extensible for other SJA1110 sub-devices
not yet supported (GPIO controller, cascaded IRQ controller).

Document the XPCS integration-specific compatible string, positioning in
the switch's "regs" subnode, and the pcs-handle to them.

The "type: object" addition in the ethernet-port node is to suppress
a dt_binding_check warning that states "node schemas must have a type
or $ref". Rob Herring explains why this started being required just now:
https://lore.kernel.org/netdev/20251120173012.GA1563834-robh@kernel.org/

Because the regs and ethernet-pcs nodes are optional, I don't want to
pollute the example with them. However, I think I can add them to the
commit message:

compatible = "nxp,sja1105s";
...
regs {
	#address-cells = <0x01>;
	#size-cells = <0x01>;

	ethernet-pcs@0 {
		compatible = "nxp,sja1105-pcs";
		reg = <0x00 0x800000>;
		reg-names = "direct";
		reg-io-width = <0x04>;
		tx-polarity = <PHY_POL_INVERTED>;
	};
};

compatible = "nxp,sja1110a";
...
regs {
	#address-cells = <0x01>;
	#size-cells = <0x01>;

	ethernet-pcs@705000 {
		compatible = "nxp,sja1110-pcs";
		reg = <0x705000 0x1000>;
		reg-names = "indirect";
		reg-io-width = <0x04>;
		tx-polarity = <PHY_POL_NORMAL>;
	};

	ethernet-pcs@706000 {
		compatible = "nxp,sja1110-pcs";
		reg = <0x706000 0x1000>;
		reg-names = "indirect";
		reg-io-width = <0x04>;
		tx-polarity = <PHY_POL_NORMAL>;
	};

	ethernet-pcs@707000 {
		compatible = "nxp,sja1110-pcs";
		reg = <0x707000 0x1000>;
		reg-names = "indirect";
		reg-io-width = <0x04>;
		tx-polarity = <PHY_POL_NORMAL>;
	};

	ethernet-pcs@708000 {
		compatible = "nxp,sja1110-pcs";
		reg = <0x708000 0x1000>;
		reg-names = "indirect";
		reg-io-width = <0x04>;
		tx-polarity = <PHY_POL_NORMAL>;
	};
};

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: rewrite commit message

 .../bindings/net/dsa/nxp,sja1105.yaml         | 27 +++++++++++++++++++
 .../bindings/net/pcs/snps,dw-xpcs.yaml        |  8 ++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 607b7fe8d28e..af86e425cd9a 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -85,11 +85,31 @@ properties:
           - compatible
           - reg
 
+  regs:
+    type: object
+    description:
+      Optional container node for peripherals in the switch address space other
+      than the switching IP itself. This node and its children only need to be
+      described if board-specific properties need to be specified, like SerDes
+      lane polarity inversion. If absent, default descriptions are used.
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 1
+
+    patternProperties:
+      "^ethernet-pcs@[0-9a-f]+$":
+        $ref: /schemas/net/pcs/snps,dw-xpcs.yaml#
+
 patternProperties:
   "^(ethernet-)?ports$":
     additionalProperties: true
     patternProperties:
       "^(ethernet-)?port@[0-9]$":
+        type: object
         allOf:
           - if:
               properties:
@@ -107,6 +127,13 @@ patternProperties:
                 tx-internal-delay-ps:
                   $ref: "#/$defs/internal-delay-ps"
 
+        properties:
+          pcs-handle:
+            description:
+              Phandle to a PCS device node from the "regs" container.
+              Can be skipped if the PCS description is missing - in that case,
+              the connection is implicit.
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
index e77eec9ac9ee..46e4f611f714 100644
--- a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -25,6 +25,14 @@ description:
 properties:
   compatible:
     oneOf:
+      - description:
+          Synopsys DesignWare XPCS in NXP SJA1105 switch (direct APB3 access
+          via SPI) with custom PMA
+        const: nxp,sja1105-pcs
+      - description:
+          Synopsys DesignWare XPCS in NXP SJA1110 switch (indirect APB3 access
+          via SPI) with custom PMA
+        const: nxp,sja1110-pcs
       - description: Synopsys DesignWare XPCS with none or unknown PMA
         const: snps,dw-xpcs
       - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
-- 
2.34.1


