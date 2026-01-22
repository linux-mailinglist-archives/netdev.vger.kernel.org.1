Return-Path: <netdev+bounces-252281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U4cyH5AGcmlgagAAu9opvQ
	(envelope-from <netdev+bounces-252281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93265CEF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26998A9234
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A842DFFE;
	Thu, 22 Jan 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I8oyvwGk"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472D2C3261;
	Thu, 22 Jan 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079452; cv=fail; b=ql8tGgQ/mGP1p03t/4jZRZ/TtAeVCFjPAwKIhcThxp3edyMzWJD9fcqF6YsDwLG9mOO3CX6XjumtKT6amrCPzdqNKjpMMKZ6mja0PsISqHAXaKA3l6/SSZeK+qYRxR/kcP3+e/ozu+JnGtssZiUnJ0HHcZB39BmEZ/+Czw2+b+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079452; c=relaxed/simple;
	bh=+BZjEaP4Sa5Vy874mvISKIcq/VQVBa852ufPrg9/4H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CyXeyigUL4r9hnUKwA07Pi7Fd1GtKjS/AMxDJABrdQwr7qGXV9UCg1BdthKQhfl8Szks8MPOEnGJ2WV4ZPs3uexPuh3EqADYnEMA2EHDZ1HKXycPjXYf9GhVPKokZoyup9zO4khaQpCLX5DEJLKbHSgoGRjCxXGJJQ93FjlEh7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I8oyvwGk; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCgyFShQ8QU5IfVk05IO5q9lhVQ70qaaGIYV3HMIdYe+rGZVjHWa3snF5er/PY7z2RshlfctmXEO+XhrI1qldgTaOM03iIVD2c5DBFA5YbPHYLWowymf1XZj8vKBAyIh93jxJaTkBPl2Og5ifemKvbO5T33NJ6oqpWfcOEGC6d8rZs+0xmRiTz/GqE88+lGm/LJxpsWP4icBU9QxLhCGXsC/XF5o7eQETUh09V1CfqAV3JKWn23dPfNUFRPY9x1eXvMNZljE8KAJPf5TY9Dtg7q9G8Dj8UxYlIPpn/czBMWy7F5soJ5EtGOEhTikoEvLVYG6XPT6arGBWKwg3V8G6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzeredkJvU140/y5aT0fVCXmmvy8OG6LP3thF81BaMk=;
 b=HPV+/TCjtAyS7PqEI7BE7g1eOnj1iriUHVN8WcQQUNlb/9Rfjl3Cxg5iaVqAmdc1kPu+uubanH1wO3C1KHlFNX+BsxE05VJJ4zxAOIjIfzpOUUH/Vc4uRYsN4d2FgHNbd4cIxXInOXbnwBrjZvBMPVzDRmrUJYdkzcnw/5HHSMu+UqdEY+RmmiIgBKr9IJfIuB3BlIwCuULdCDPtrl/UDMMWzCINgUepLKo4QmDAjE6s3QY2lvF0octDla5zDm9DVCGAZHo+AhrlGcWryhqceGhcK86PseciWtzgPY81vqcU+rvxJRKC63MPwGgrPF42xL9ChtGyU7ZqPRtd+OIN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzeredkJvU140/y5aT0fVCXmmvy8OG6LP3thF81BaMk=;
 b=I8oyvwGk9XxwWSwkX5ODi/4ve2lqeUQQPiWc0Z+3aWR23w+Th2Fc+lQH2A+9xPWFLEkojTdXSeaxD0R6JDvZwFgniJlGkePOKL/LNfUJR56fQzUUXDZxU5wn6LmylWeq52m87oD66yLxCSmRVB5xQxCOIvPfTr1R27wEnQAzwWWbs8wdrjwRkNuHx+BzVrvuUvMMUHw5bgO2vpsqHGX1f8Jx5rQvzhlBdk/v5Oj0gyTlCtV2E3np1f4rINzn5GsqTg1pO5F37EYRmMiJ6u++8MfJI3MdnYhuMN8GggwxzKrystZJZz47l3GwhwEVW3g7EN095Bhlx7teK6w0xzZXKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:21 +0000
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
Subject: [PATCH v2 net-next 08/15] net: pcs: xpcs-plat: convert to regmap
Date: Thu, 22 Jan 2026 12:56:47 +0200
Message-Id: <20260122105654.105600-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eef4d2ac-f6a4-4cbe-be5b-08de59a5048a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvCloOWwRL8NrzuVDlj8Hew747esmnXIq54CyGR17Y/4W8wSPaOfsCtyO2x4?=
 =?us-ascii?Q?yIUKe0xvPAtd6UcP1oIEryHC20Sg4Z+gAY5G2TR5cuJc4qZ3H7KIQXjjsVAy?=
 =?us-ascii?Q?9VMQ2g/BmNs3OEHQp89Xq2oq2OBFOkSjC/T7BD4WmcigxJlp8TnkM2isqYTh?=
 =?us-ascii?Q?1QID0k0sqlfdPhO4wGNPoao2o2F/Ce7wx8wEYsBqym0+cCJUW+oPJ2oC7m1d?=
 =?us-ascii?Q?jIJlXaHYvI3+XEzxbANDRFEvKr17us5pAnDRaF5mK5KedGktia0634L7dnZu?=
 =?us-ascii?Q?Ucnq1c1o8IMdrmdh76XB6EH/vtcLrkGqXfastLWLNlhag4siS2HgSoq0nWQR?=
 =?us-ascii?Q?bcng57it1R21dTP8J+x+WUWPi/MnSCTh26iuBRrdj5JFm3Oy+1hg9+VMFOyQ?=
 =?us-ascii?Q?FzeOOcd4dCJv2QvJD8mkd/mFs//DuEs0DpaesStLGm7ctqaoEFYv/710A+j7?=
 =?us-ascii?Q?cxP/XqnIFu6h42eqFnFTHZ8sUzcGgGa6Mxg4kvFzh0i4NMvKA5rMfNAWEYGv?=
 =?us-ascii?Q?9RKMgbvneZISVggKezcRg7xINqszkNz+WWC09qBd3qJwtI9L4QeHOLGXese3?=
 =?us-ascii?Q?8z7T5Z8bQi17o/L05km2NVxkkOFxZrskMgrUqJVMpEwgJw5TgtBTn88c8DaO?=
 =?us-ascii?Q?sqjKiWjaq54wSCS2khqqJwAA+55FnFiUTZ7T05XkV+V3u9/Qz0AsX2gnX/k/?=
 =?us-ascii?Q?dN5oN/XVRajOlkFdzlAP0E6GGGXFDxPytCyzBcrn2fYpAoVv6ALbrLU6div4?=
 =?us-ascii?Q?tUhvRA0B2MEASlLZniFfeUleDbBvcSKBuxKhN+yVBOV0SRqbZakx8YYtHyjg?=
 =?us-ascii?Q?UsspIqQq1Z1KpDYUdYiZXyhsF19kVu7XhV6osvOtt5LlftiExlQ1w/0Kzat+?=
 =?us-ascii?Q?IBHJqNBp1Fs+mQcAVqD5A8ijo6gafHhr7UjOCzMtCanZ35As4ETfVSXlNi7n?=
 =?us-ascii?Q?2O5QNeu2b9t8GHFNL7UEeXHVILOyvCDlH+WXztSUlsI7LJhQ7DlsLzXVn1Cr?=
 =?us-ascii?Q?xFOfLb2X6jM9pgt5Hh5A06+BDok5VeaGXgdCbLF50Wd1huzElFr6A8cEVYTW?=
 =?us-ascii?Q?LNZHKm6fyxCloS6cmip/L1VSp81dMcTsW7wVcdslJSW8KTqtWd2b5/AwKX8b?=
 =?us-ascii?Q?yTi+OfmMyc54UCRGJ0QCXF7sQKU9/D/rZdTZqlMDfqR87lYJ9jdU4s2n6eP3?=
 =?us-ascii?Q?SjLvJUejnPmbFCPtHF71M6EGJt6H840VPevcQfeQIx3+fUQkaba9nxNLe4Hr?=
 =?us-ascii?Q?PlJYYPG36mj2MYV/yq4c0ZrPDJKdcN7kqd4PighYjcdHc80KQvyNMY/GlVf6?=
 =?us-ascii?Q?t5MwMIirx5EMGpAvPo1qJ87PvtHLdLRy4Uf5A51UQlEyc/UiBx9ebFzL9Dgc?=
 =?us-ascii?Q?FHtjm79ecVTrlZhvU6eOCyPzG9msQjWl7aaEIhwBWW2XLr2oROhxX1stNVWX?=
 =?us-ascii?Q?K9GJA0vrxyhLmMuS1lDUsAn4mOeNaaCWgBay2mLTpbg5+sCI9no86ITPSbco?=
 =?us-ascii?Q?UTWJoYG79fZntsAjCxoj18Z3KAMyrJV3qE9yEGK0UCkkgTEv/oF0ck9Z+p7/?=
 =?us-ascii?Q?fh1pKrmz4+Hv29x6utAK7hs2TZcOEY4Xn5k0buvoZwKj73K7wGLaD7ltC/Ye?=
 =?us-ascii?Q?Wayoqo+hVIMkdXtd/TAtfgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZN1naQu/uPWfLTg4Via7plwtldh0krNR7IKjIGnNsKFCyC8EKBdqfGJgum4?=
 =?us-ascii?Q?g5XN4ubHgFBLZk4K6Cn7U47Ji4T61crTTwr04QiXq6G6HoycAT2VjgpFkcX5?=
 =?us-ascii?Q?roX+mit5k2vr6TzbY/jzHY5azhNOgLX+Y9Zp9uf0bhX5w48MBbfOmIstrVPW?=
 =?us-ascii?Q?2LyjWB5USp2HNf10gxrMz0JVUawP6wMn9tMflj7C6yXo8XMIE42zGA1Nd/dh?=
 =?us-ascii?Q?M7ogNWL1nf2PrjdfZ05sxUa64uX4PLtvHb2cibaCms17RGiBYXE4AcyzMIoM?=
 =?us-ascii?Q?JK3CD1A54RgvynMEg+08kPBabXf1qBAYldqumE7+9bD1mFDKkwqdOi+D0wA5?=
 =?us-ascii?Q?LgzKTjSqaEei0HwIj1x8Alm+SNjEwXJ5EY627O3Thn3Vmwal0Jj4ILDygyE2?=
 =?us-ascii?Q?DjVzlm/kgo7kFdig18LE2ChGTWfJI6nTD3GOPhq3a0/7n7g0+ctFgIYjgUrs?=
 =?us-ascii?Q?3/8yB7VSi6UV2fxaKFSpXaeV+xKe8RMSrqrwHBC1Bw4yiTTkj5UI7pyUunlK?=
 =?us-ascii?Q?787ogbBydYomSXV5fNpWwxVKVxpKKZsDetYSdsgC9oWZ72pmEhZdXxYq+wWo?=
 =?us-ascii?Q?P6vAIX6BLFGXgY2Ngq2JmoFJ7xoIcNwV+pTRR6sXygiAgQ0kced+qv3pwho/?=
 =?us-ascii?Q?2HpBuRlvM7qVIJjSnUGGNWVNIDU9Ud55H+xpE6zkZ7TG8L60S2qxGXOMVefY?=
 =?us-ascii?Q?XV/WJi41I8H6LeeP93IqCd4MFQufkCykMB4FkE41iVJoyTpjoQ04JNe1GYUS?=
 =?us-ascii?Q?74OeguGgRlFO9kz4wodGcd27MskTMZrFOeeH37Aoaq3BzvI3fUBt2ACu4USE?=
 =?us-ascii?Q?gBjX3OE69g6q1PucbpLMU6mBgTrmsKM3HWV97fpXYGnZ8IO0OcPQ+r1+22vN?=
 =?us-ascii?Q?2pilxJ5YyT2s/JUpVN9vtE90pm3GzSBlYj/aoedCyWySHUzLHmoB4ik/2xko?=
 =?us-ascii?Q?YHuEMmCVS8OHnGuBYdrMlmIR6xk819I5lKEUOrYQlY96/Wkve18Aa72BmqtW?=
 =?us-ascii?Q?iW7hBvDfqKJMOPgP3MjEDLNveqXQO4k0aq+xH6D+CUxGT34q2K4ZcEXjGKvT?=
 =?us-ascii?Q?U21oBNMgRqJwefIJgXxznss5rXItHU8qgCMplDJqRJTXXV+JUOmo0JYJSynL?=
 =?us-ascii?Q?6qhBDvjf9cQfHC89uYz3fWO8Ph/Ui64Pe8Q6Uh0RoBqK2z8hi2kSCy2WITEI?=
 =?us-ascii?Q?AwrfZFAPn++Rp4EBkAoGfVQwPmWNuJbVYvUS+kbhOP/sHoXUoDlMK05h7mEj?=
 =?us-ascii?Q?PTkUjWpMdAQHK6nzLCh6tCP3mrRqmVlKhmBORa4ucXA+vP5HXZeFEIxxUjV1?=
 =?us-ascii?Q?guH1Jq666QcJIaU5yOwHxrmI0Q7IuM+3MuH+6p6Ww+4iKKlIiNpbMVd68uNS?=
 =?us-ascii?Q?8w+Isqn1Kn8fkhJYW9FU/2q98sK4jUwjgmirvmm5i+TNiihmrc0+ijK/Z1EK?=
 =?us-ascii?Q?XF7YAqBaIGZvlWCexI84+jJjjdi88sBawSuZIQ63gZYIOC2i7jWvNQYyxM6L?=
 =?us-ascii?Q?wgs8sEcoEnCfJlpYAPZMzh9Wfkkjk8flsXAu9js7m87sPYb96V+TcDsquI53?=
 =?us-ascii?Q?KF/KPMF5dAwSJmTUbOVTEw7Hytzk2yyQwL6dh5tMlOSYFkKoSzSj6YVifNy+?=
 =?us-ascii?Q?N0pAmFJde5MfQ1dzj5RDqpCPlkjgEQupnz+pFut4Zk39IJe+IRltquDj9A4A?=
 =?us-ascii?Q?LwO0dPTIqf6SFDVdIWGCHNAQ9Tkhfio444Ym+1cmqGIT85xQ7jlfes2pO9Za?=
 =?us-ascii?Q?KeNkpuLY6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef4d2ac-f6a4-4cbe-be5b-08de59a5048a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:21.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+01GrXkWOQfXynHPNcjk44D2nuK8FJ3hI5y1GxU3xlP3kPOxTcrjEhqy0pFKAdAH65gtS6G/l9hQPyHBvsPlA==
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
	TAGGED_FROM(0.00)[bounces-252281-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 1D93265CEF
X-Rspamd-Action: no action

Generalize the MDIO buses for accessing memory-mapped XPCS devices
(through direct or indirect I/O) to also cover the case where the CSR is
behind an SPI bus. This is the case when accessing the embedded XPCS
from the NXP SJA1105/SJA1110 DSA switches.

Cc: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 drivers/net/pcs/pcs-xpcs-plat.c | 142 +++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 47 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index b8c48f9effbf..2bc0afe2bbb4 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 #include <linux/sizes.h>
 
 #include "pcs-xpcs.h"
@@ -29,7 +30,8 @@ struct dw_xpcs_plat {
 	struct mii_bus *bus;
 	bool reg_indir;
 	int reg_width;
-	void __iomem *reg_base;
+	unsigned int base;
+	struct regmap *regmap;
 	struct clk *cclk;
 };
 
@@ -52,7 +54,9 @@ static int xpcs_mmio_read_reg_indirect(struct dw_xpcs_plat *pxpcs,
 				       int dev, int reg)
 {
 	ptrdiff_t csr, ofs;
+	unsigned int addr;
 	u16 page;
+	u32 val;
 	int ret;
 
 	csr = xpcs_mmio_addr_format(dev, reg);
@@ -63,19 +67,21 @@ static int xpcs_mmio_read_reg_indirect(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		writel(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 2));
-		ret = readl(pxpcs->reg_base + (ofs << 2)) & 0xffff;
-		break;
-	default:
-		writew(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 1));
-		ret = readw(pxpcs->reg_base + (ofs << 1));
-		break;
-	}
+	addr = pxpcs->base + (DW_VR_CSR_VIEWPORT * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, page);
+	if (ret)
+		goto err_put;
+
+	addr = pxpcs->base + (ofs * pxpcs->reg_width);
+	ret = regmap_read(pxpcs->regmap, addr, &val);
+	if (ret)
+		goto err_put;
 
 	pm_runtime_put(&pxpcs->pdev->dev);
+	return val & 0xffff;
 
+err_put:
+	pm_runtime_put(&pxpcs->pdev->dev);
 	return ret;
 }
 
@@ -83,6 +89,7 @@ static int xpcs_mmio_write_reg_indirect(struct dw_xpcs_plat *pxpcs,
 					int dev, int reg, u16 val)
 {
 	ptrdiff_t csr, ofs;
+	unsigned int addr;
 	u16 page;
 	int ret;
 
@@ -94,26 +101,25 @@ static int xpcs_mmio_write_reg_indirect(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		writel(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 2));
-		writel(val, pxpcs->reg_base + (ofs << 2));
-		break;
-	default:
-		writew(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 1));
-		writew(val, pxpcs->reg_base + (ofs << 1));
-		break;
-	}
+	addr = pxpcs->base + (DW_VR_CSR_VIEWPORT * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, page);
+	if (ret)
+		goto err_put;
 
-	pm_runtime_put(&pxpcs->pdev->dev);
+	addr = pxpcs->base + (ofs * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, val);
 
-	return 0;
+err_put:
+	pm_runtime_put(&pxpcs->pdev->dev);
+	return ret;
 }
 
 static int xpcs_mmio_read_reg_direct(struct dw_xpcs_plat *pxpcs,
 				     int dev, int reg)
 {
+	unsigned int addr;
 	ptrdiff_t csr;
+	u32 val;
 	int ret;
 
 	csr = xpcs_mmio_addr_format(dev, reg);
@@ -122,23 +128,23 @@ static int xpcs_mmio_read_reg_direct(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		ret = readl(pxpcs->reg_base + (csr << 2)) & 0xffff;
-		break;
-	default:
-		ret = readw(pxpcs->reg_base + (csr << 1));
-		break;
-	}
+	addr = pxpcs->base + (csr * pxpcs->reg_width);
+	ret = regmap_read(pxpcs->regmap, addr, &val);
+	if (ret)
+		goto err_put;
 
 	pm_runtime_put(&pxpcs->pdev->dev);
+	return val & 0xffff;
 
+err_put:
+	pm_runtime_put(&pxpcs->pdev->dev);
 	return ret;
 }
 
 static int xpcs_mmio_write_reg_direct(struct dw_xpcs_plat *pxpcs,
 				      int dev, int reg, u16 val)
 {
+	unsigned int addr;
 	ptrdiff_t csr;
 	int ret;
 
@@ -148,18 +154,11 @@ static int xpcs_mmio_write_reg_direct(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		writel(val, pxpcs->reg_base + (csr << 2));
-		break;
-	default:
-		writew(val, pxpcs->reg_base + (csr << 1));
-		break;
-	}
+	addr = pxpcs->base + (csr * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, val);
 
 	pm_runtime_put(&pxpcs->pdev->dev);
-
-	return 0;
+	return ret;
 }
 
 static int xpcs_mmio_read_c22(struct mii_bus *bus, int addr, int reg)
@@ -230,11 +229,48 @@ static struct dw_xpcs_plat *xpcs_plat_create_data(struct platform_device *pdev)
 	return pxpcs;
 }
 
+static struct regmap *xpcs_plat_create_regmap(struct dw_xpcs_plat *pxpcs,
+					      const struct resource *res)
+{
+	struct platform_device *pdev = pxpcs->pdev;
+	struct regmap_config config = {};
+	struct device *dev = &pdev->dev;
+	void __iomem *reg_base;
+
+	reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg_base)) {
+		dev_err(dev, "Failed to map reg-space\n");
+		return ERR_CAST(reg_base);
+	}
+
+	if (pxpcs->reg_width == 2) {
+		config.reg_bits = 16;
+		config.val_bits = 16;
+		config.reg_stride = 2;
+	} else {
+		config.reg_bits = 32;
+		config.val_bits = 32;
+		config.reg_stride = 4;
+	}
+
+	if (pxpcs->reg_indir)
+		config.max_register = 0xff * pxpcs->reg_width;
+	else
+		config.max_register = 0x1fffff * pxpcs->reg_width;
+
+	config.reg_format_endian = REGMAP_ENDIAN_NATIVE;
+	config.val_format_endian = REGMAP_ENDIAN_NATIVE;
+
+	return devm_regmap_init_mmio(dev, reg_base, &config);
+}
+
 static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 {
 	struct platform_device *pdev = pxpcs->pdev;
 	struct device *dev = &pdev->dev;
+	bool have_reg_resource = false;
 	resource_size_t spc_size;
+	struct regmap *regmap;
 	struct resource *res;
 
 	if (!device_property_read_u32(dev, "reg-io-width", &pxpcs->reg_width)) {
@@ -246,8 +282,14 @@ static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 		pxpcs->reg_width = 2;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "direct") ?:
-	      platform_get_resource_byname(pdev, IORESOURCE_MEM, "indirect");
+	res = platform_get_resource_byname(pdev, IORESOURCE_REG, "direct") ?:
+	      platform_get_resource_byname(pdev, IORESOURCE_REG, "indirect");
+	if (res) {
+		have_reg_resource = true;
+	} else {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "direct") ?:
+		      platform_get_resource_byname(pdev, IORESOURCE_MEM, "indirect");
+	}
 	if (!res) {
 		dev_err(dev, "No reg-space found\n");
 		return -EINVAL;
@@ -266,10 +308,16 @@ static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 		return -EINVAL;
 	}
 
-	pxpcs->reg_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pxpcs->reg_base)) {
-		dev_err(dev, "Failed to map reg-space\n");
-		return PTR_ERR(pxpcs->reg_base);
+	if (have_reg_resource) {
+		regmap = dev_get_regmap(dev->parent, NULL);
+		pxpcs->base = res->start;
+	} else {
+		regmap = xpcs_plat_create_regmap(pxpcs, res);
+	}
+	pxpcs->regmap = regmap;
+	if (!pxpcs->regmap) {
+		dev_err(dev, "No regmap available\n");
+		return -ENODEV;
 	}
 
 	return 0;
-- 
2.34.1


