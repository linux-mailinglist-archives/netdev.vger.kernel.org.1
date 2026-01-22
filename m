Return-Path: <netdev+bounces-252274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIVeJ7oFcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD965C02
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C783C886110
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A093ACEF8;
	Thu, 22 Jan 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITbLeqfr"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF83806D3;
	Thu, 22 Jan 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079436; cv=fail; b=pMaWW5SJIXQ/GPLkXKHgNJgREUfSITv6HW7Ds07eUhmf+RqlPjHYrX9bRa5fAuIq0gTfqntskb8UVY0OvLYI92tSsvSOerg7xOe7g/I9UGAOJ/kE1jpqxAPXghTarQRpTPDXrE3VicjX/y6bu4IVnjXSzljx3IVkoupbcycyK70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079436; c=relaxed/simple;
	bh=1qlUz3DJDZxtG8+KMQk6Z2PaJR9+8br9YMRcoshitys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDE7jMoSFw/nB5PQy93AW5lveVLuxoNaLI9tzEic/tEUOgBqn5/HvmWEmokDAUTcoCijxbNrSa00YHgUNu0g3FXX20KZx5/vdrfc5Ych4ZWkhSCWImcx3VlY8wtwnBema9yKrZcYJesO7zVPxR4IJYWT5kXn3ZopARsGChwPCIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ITbLeqfr; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEVmZy4iqDiJO6J3XdgmSEQ7BglN7bT8ALADJKzKE7SwGhDhNMYWIP3SUHAPWlO7ZTpqq4xq8DDHTfT5pd0LOpuKdgzmhaNo/i+J3lpEaom1a5Fxt9U9+SwOb9EviIBCLpz80WgkaWsPncnZHyvKFMwY3CGf8D5dtkJqp9rd4ZxXqVQ/yy13aooGN2T64RtvR0eR+MxKV31tUXcsPzIXf2OES3VNMrtTsWXSxXjlpFnP2j1wBu2n1TRoXdbo2iX2fGY0MvzzuqJnSGQf5vR+aSq2+a5khnHz9LWf//oFdpMGLd4+GTSB0g8HBUqXLh51D7JI3tikAlz191QgEI6c4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1szSnQyAQrKnC//QeHrVaVSU6d0qWqEKFhwQRDQxImc=;
 b=HSgy0BHGOMwoR2Miu/oh0rNWRu3gSm+7bh92kzET9az7yq8k0CTGR38PuWegAHDKTQZMu1kEnA6W8zABVz8DuroqgWBhtsvd6pQYz7osbT2j9AJYgXF4wPJuBviSZB/c+BYd4/jahvRm6dq86vH1KxbHJHRgI+bcjO/OhNFNUrw7wat/FwJQRKgtHmPOhMQpXkLKIAUFO1bQ2P3C3SPkK8GlX8tJ88FaJ3TVOH+vbXz7jhJVPL1Jv3ii1WF7zdRhlyK7ZB7Bf5ZqTrObg0R1FRIPQjeU3cwpV5QrxSSadBarAZfi3fOA9tfs49z5wXyiEFkVUrxVqC7kd+MYfcoK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1szSnQyAQrKnC//QeHrVaVSU6d0qWqEKFhwQRDQxImc=;
 b=ITbLeqfrZY7QvUCF/cEMX/Q/5EW8Yc9nqTlh0g0AzVgrykT1m6dHREfzmUng43fZksh99yhPK4AYkvf8zPtjM0QozS8t8ThWNd2zLmJTwr9WpQ01h9q27odI24QyQKsFOWuE2j0uIGSOX8TKbReUE99jqG3t2zA7XIzfsu4iN/aCvv83ExAEZ5ST9BDG2gpvnW5HVkbg2F9jBEaPq3imfPUGJYnpDMLVhb0Y2/1zZmmX6XoVyXRXEzYMOQalRdSXVeJRzs2MtdiseuV0SN2g+ROW9mrm8784QxlPLTstHVGBIdLsTzB9lM6RC+kv5Iaex1pHodmIxMdN0LzDdGf6fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:09 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:09 +0000
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
Subject: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with non-MMIO regmaps
Date: Thu, 22 Jan 2026 12:56:40 +0200
Message-Id: <20260122105654.105600-2-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f21ffd6-4003-40df-0797-08de59a4fd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWQCewFP61OowOqHSTsua7H55WArcwY2J7rr+UzYWizvHpb7hat2x9L573Sa?=
 =?us-ascii?Q?LPtwb6kIHR31W509j5qrfUFUFLrid4brmWyUdrAmJgM8T9ozrPOGrjanxsfr?=
 =?us-ascii?Q?udUNP7WC72OKoAqHtcrKjM8z04MQNuoCYjPe5pbBW2Hua40xjpS0tBMALZ4o?=
 =?us-ascii?Q?6nyZ6aJSsdwGOtEzio4Z6rcdsfvoVm49rvzWsqRx/+NDa0XrfVQyB9E7XY6Q?=
 =?us-ascii?Q?4etCww9BuQpPDzzCocmcakSvFL21d6tnZjim1S42nVy3BDBM54At6Q5ukZbo?=
 =?us-ascii?Q?uuhNmrlwy+Ss7SaTMIo7H3iacIQVl0ze3rl+s7ZJr5/KoweMKrGT+r5H3jlA?=
 =?us-ascii?Q?zYHKk8OCIys2l9vPoYYdBjizUcPdfdqRAqD8do+PdrSUlzYHtHPxaFEx6eqe?=
 =?us-ascii?Q?kmqqER0IWFhC/m98T9wo8a4V7RUxiota+ZJRvF9Qx367z26pe91SEywQXTq/?=
 =?us-ascii?Q?NEoX/3lJG1a6ptU9CttlAwLStps2tzKDMUJNXzqRPH6qITElCzvG05QhZmqu?=
 =?us-ascii?Q?p3PQod72qSPWIyMaJVCySPvvXPo2JK0wzsf7yzGDzqUkgZOzIse9E0DEAWgZ?=
 =?us-ascii?Q?T/2yBzXRnG3ZDyRTZejJGrhRKnQdHy8/DaQPWrBIVRSevejnTubwZVM17XWg?=
 =?us-ascii?Q?qi9btESsYQ+5xG7F6Ypi0ae/AulKRbKfeL0l7uk+5UTeq7bB8MZc90tgh4EG?=
 =?us-ascii?Q?Q6UqwhBChbEBpJ9yfM++EnyxCKjiax6NsjpNzN9xDWGl7dvBWw7iDJsV+uv7?=
 =?us-ascii?Q?mM213S/SdUqocHgbcllPKCotXcuCTsfx3zN1YQGOF/MEVcFlBZgE7NyxqPIP?=
 =?us-ascii?Q?GiGyFemYYUfSwGyVf24cvVyQ1Vnsf6i3x/Lk1Y+Pgy/uZP0ZWJ6JnDg2SOak?=
 =?us-ascii?Q?t9rV4dCzCOAOkdD7zlloIxio1fu3gshD9lYJ3Bou17DlRktg6osyWrP+T6zh?=
 =?us-ascii?Q?D/dfR3nqf9uAYzkVOeZkirwDzHMnwBCHdwBB7mLKzWb9HPcnWLexg2XYlnkd?=
 =?us-ascii?Q?dunoxT57ygASLYZWb1rSUWvhAbPN27e0qLnqY2QALQ+8daXawofBY18eMpUO?=
 =?us-ascii?Q?YBIBV4tSVbFsU77ujgXVcMrYLWMT8zIOuxDIroNP7xByxwp75QvSu4OkXqn6?=
 =?us-ascii?Q?gFO+M+owofxnIOnfNjU6+xjsHKLiHhlpbKYNCf/KO9D08T+mPOUSVykkYVfk?=
 =?us-ascii?Q?ODq+SyTkDX9vSqVDMq9JA3RziJhhUuO619/W0mQftkudOuio1TPa4MGdzLab?=
 =?us-ascii?Q?EVkOYYo3reNZPk6Bc03sWt/HrN7Z14kR/pSUaMXr6IUlYL9MtyQmSJl+S0SN?=
 =?us-ascii?Q?1mUmizQORVUmlcdLqz2oQUP9gY3ypWHkHCEPRIx4QQjs2XMZED9lrVOhvs/3?=
 =?us-ascii?Q?St+uUr94cLLMNthG7aCEZuo1xLTVdZfPPqQXTC58ap+0+G6KK7VJMbx3CgI6?=
 =?us-ascii?Q?FYX08bqzFuEQctdmgD6/e7eMYDEjcIcJfiwHVNgiEolDhvZBUIc982jWtsH3?=
 =?us-ascii?Q?0DuvBeugoClzoLlXrJUheu13l4aSVEwNydQJztkw7NzKdK21MbORROz9l13I?=
 =?us-ascii?Q?gJC1O0ThdiC8uEFDTRdr6jS+QkH1VssRQ5b9brdm/I6Ib7dmLL72sLEJ27Wi?=
 =?us-ascii?Q?Wfh80pVJqM/yV4zmsTPl5tA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WhfD9foNqARBM2D55O3Q0LPkRmBpn2DW3UpJTKptdggfU7RyMcrorNRJXiX?=
 =?us-ascii?Q?Yd/xe6Emv5/dhs7RN0HSYT3SSgAXal/i9LfgtiHNjDcZvGcabW3hvxn4Iy9z?=
 =?us-ascii?Q?tikBHJs1pnUMPJbt0qKbZk7sR1tMXwgBFiYYoRraECib7jAE7npkH2d8fbDg?=
 =?us-ascii?Q?pw9I4FJ38abLOsjK9uu2E0JlrmSD+Gj0wf500Ata/lOSRnuh5Tg6zRPMtws/?=
 =?us-ascii?Q?9bffqNW6H6GsmLRAiSO4xw1enQob90XpFdd9qo1FwggcXYsQMRzflDpGeLGM?=
 =?us-ascii?Q?ByX71FDhpG6n1sR6KAdkNcAKk2JIaFEW0I+dmF+MU1neo3AVOz0knL86ZOD6?=
 =?us-ascii?Q?VKA0uZzzWBbFfJBW+EHNGDO4OaXD6WGdEXZH3qgi/cGNJcQIoZowNne/b8RS?=
 =?us-ascii?Q?/T9YIC7AwycC+2DeO7/OYXlviHCrqod8BINXZkzOPQDYC4C+JLGg3aYuDYf+?=
 =?us-ascii?Q?u84h1lou7+s20x/ZX847v97JdfuMTbd55uJE++7SHkr+T08vsyEDzqq1GgY0?=
 =?us-ascii?Q?2gCFG5SrNwcYnUKAuCiyxzMPq4ldu9xC7IlAC5lIUXqR3Ld+D8N0BnRwNrKF?=
 =?us-ascii?Q?vokDYgYuV2fCi2NAUPMDqe4BGKt0+SO3WmgpFY6rOsvRTXzNOibhjlePGY4/?=
 =?us-ascii?Q?d1CQFdBrjHfcROSAq2v/BKGz4taG6IS7Pl2W0Dh1TL2byQcbNPpU+aEIbo77?=
 =?us-ascii?Q?fURqq3zqlvm2ImVA7aWiiGyRda7OeOxRgBvyL1Ft7vDurPfvflzcQr0/d845?=
 =?us-ascii?Q?sJsWBXydOxabQnO3MPmltD6lVUI4ye1SLzMKmn0stXOq4+bChHZyiEmsh+H1?=
 =?us-ascii?Q?CrAH5GiDUszS1IMVG7XmYPU23F/SIBsQbFVzjabbtKSjpPil94iyF8ONhhCe?=
 =?us-ascii?Q?Y9oalou5ZbpbLM5iw9wjkaYUBeul+dlInCTj6E89XL4EMudr2Qoe8v3eb9NM?=
 =?us-ascii?Q?rMkZue9X775BBdqjESgWCPVuh935zgRqVwxuXWZsWaFm4U7Iz/t5wUF9/cQR?=
 =?us-ascii?Q?HVdl+l2s5/nWCxLBBGoF91fVbhj6newuRAHqzy7IVdXKf27BtpzFf4Gyvhm6?=
 =?us-ascii?Q?sjAPyNMsA47kXJbK9oVHo2Jfjv78hjQcVGdn0/IwAesUeQWO5OkEnDAojpzx?=
 =?us-ascii?Q?lc1eNkxhtiGn9peI3dbgHpNxPaT0A2JRZBuITLPKEoW3jMWIUCjkmbsvyA7j?=
 =?us-ascii?Q?2a5B+QejMxleP3lO4KmEnVBgXixBn1he94QKelwfORypdj51wDsA9SCzNK0u?=
 =?us-ascii?Q?PpPUUXJ1qtW5A0c9MR+BhQ4WbhE5z5n/XADwthL1uEuWkMVsHC5qhtZcmoYb?=
 =?us-ascii?Q?XC1gXeSfrqwmndt8oV/hu2HqdzpEHYGR8r5h0uu5iuO/q5txBurloB/+eTRA?=
 =?us-ascii?Q?ZuoeXlRYtRGXYgrmdEx6i49JQJi9tV8ldvSwvfVB64QZFWYXhvlcKM0l7Bgg?=
 =?us-ascii?Q?LU7UGTEMx33lycOiPPjBOFowz/fOT019t6XEQnq3ZlntYc0dtHIff7FaQO3F?=
 =?us-ascii?Q?l0lgzT/9a0vm0DXyXSoq+/FdBehXZLXrAMwHO7IgDTXU+Qqigjr3Csi+ocvO?=
 =?us-ascii?Q?gf8iZu19BI4l9zuWf/hHBgsB0Ds5/tI3kd01nFAxyxCNIQV46PAFCage1JWo?=
 =?us-ascii?Q?tXMdQJ/apWxEDJXhFmIt/7Y6ohTELBRNVs5PWuI9oXFokbollro9iIVkxdPF?=
 =?us-ascii?Q?Bpn8u4CXMx2kpBjQHbBAXDXmH075NxO0IStvXpug96GLVOAhV4Qd5IWfcrSV?=
 =?us-ascii?Q?JXeQXcHXag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f21ffd6-4003-40df-0797-08de59a4fd1e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:09.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmWTswMNQGL/cwf7X23MNnpF84QmD4+8rCG+cLcoPTDCMxbe0SupvWstkLAeucdtrZUxOO2aC0x4UwZrjDMETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902
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
	TAGGED_FROM(0.00)[bounces-252274-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,bootlin.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 19DD965C02
X-Rspamd-Action: no action

The regmap world is seemingly split into two groups which attempt to
solve different problems. Effectively, this means that not all regmap
providers are compatible with all regmap consumers.

First, we have the group where the current mdio-regmap users fit:
altera_tse_main.c and dwmac-socfpga.c use devm_regmap_init_mmio() to
ioremap their pcs_base and obtain a regmap where address zero is the
first PCS register.

Second, we have the group where MFD parent drivers call
mfd_add_devices(), having previously initialized a non-MMIO (SPI, I2C)
regmap and added it to their devres list, and MFD child drivers use
dev_get_regmap(dev->parent, NULL) in their probe function, to find the
first (and single) regmap of the MFD parent. The address zero of this
regmap is global to the entire parent, so the children need to be
parent-aware and add their own offsets for the registers that they
should manage. This is essentially because MFD is seemingly coming from
a world where peripheral registers are all entangled with each other.

What I'm trying to support are potentially multiple instances of the
same kind of device, at well separated address space regions.

To provide isolated regmaps for each child device would essentially mean
solving the problem of how would each child device needs to find the
correct regmap. This further means that "dev_get_regmap(dev->parent,
NULL)" transforms either in:
- dev_get_regmap(dev, NULL): search in the child device's devres list,
  not in the parent's. This means adding the regmap in between
  platform_device_alloc() and platform_device_add(), but is
  structurally impossible because &dev->devres_head is initialized way
  too late, in device_initialize().
- dev_get_regmap(dev->parent, "unique-regmap-name"): now the child
  device needs to know, in case there are multiple instances of it,
  which one is it, to ask for the right one. I've seen
  drivers/mfd/ocelot-core.c work around this rather elegantly, providing
  a resource to the child, and then the child uses resource->name to
  find the regmap of the same name in the parent. But then I also
  stumbled upon drivers/net/pcs/pcs-xpcs-plat.c which I need to support
  as a child platform device, and that superimposes its own naming
  scheme for the resources: "direct" or "indirect" - scheme which is
  obviously incompatible with namespacing per instance.

So a parent device needs to decide whether it is in the boat that
provides one isolated regmap for each child, or one big regmap for all.
The "one big regmap" is the lowest common denominator when considering
children like pcs-xpcs-plat.c.

This means that from mdio-regmap's perspective, it needs to deal with
regmaps coming from both kinds of providers, as neither of them is going
away.

Users who provide a big regmap but want to access only a window into it
should provide as a struct mdio_regmap_config field a resource that
describes the start and end of that window. Currently we only use the
start as an offset into the regmap, and hope that MDIO reads and writes
won't go past the end.

Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v1->v2: add Maxime's review tag

 drivers/net/mdio/mdio-regmap.c   | 7 +++++--
 include/linux/mdio/mdio-regmap.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 8a742a8d6387..2a0e9c519fa3 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -19,6 +19,7 @@
 
 struct mdio_regmap_priv {
 	struct regmap *regmap;
+	unsigned int base;
 	u8 valid_addr;
 };
 
@@ -31,7 +32,7 @@ static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
 	if (ctx->valid_addr != addr)
 		return -ENODEV;
 
-	ret = regmap_read(ctx->regmap, regnum, &val);
+	ret = regmap_read(ctx->regmap, ctx->base + regnum, &val);
 	if (ret < 0)
 		return ret;
 
@@ -46,7 +47,7 @@ static int mdio_regmap_write_c22(struct mii_bus *bus, int addr, int regnum,
 	if (ctx->valid_addr != addr)
 		return -ENODEV;
 
-	return regmap_write(ctx->regmap, regnum, val);
+	return regmap_write(ctx->regmap, ctx->base + regnum, val);
 }
 
 struct mii_bus *devm_mdio_regmap_register(struct device *dev,
@@ -66,6 +67,8 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	mr = mii->priv;
 	mr->regmap = config->regmap;
 	mr->valid_addr = config->valid_addr;
+	if (config->resource)
+		mr->base = config->resource->start;
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index 679d9069846b..441cead97936 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -11,10 +11,12 @@
 
 struct device;
 struct regmap;
+struct resource;
 
 struct mdio_regmap_config {
 	struct device *parent;
 	struct regmap *regmap;
+	const struct resource *resource;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
 	bool autoscan;
-- 
2.34.1


