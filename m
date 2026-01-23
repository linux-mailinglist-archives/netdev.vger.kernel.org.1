Return-Path: <netdev+bounces-252600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DkeOHDbcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:22:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DFD6F8F2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2316C300443E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957F3148AF;
	Fri, 23 Jan 2026 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gq8wZPQQ"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABE338910;
	Fri, 23 Jan 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134950; cv=fail; b=LPqtB40X+ESG79WF8p07ePY2KXLCMsW+BQvfeIX5/boUIaZMh5mxCHfo99B/9qLc91GEXqkCNak2diSiaMeEr+QOdfCvd5uK2tss2E9MGqi2mACSJ0kU7BDkCQe320Kfg4osk9hS1jDn9MbMlyCgjloVS/4++t7KwHPT/vYj0VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134950; c=relaxed/simple;
	bh=U0A+x8QYh9ktZt48s4Xj/yNkUNriyCjzn/YD/YzIGus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdRHvJERkvSMfqqDjuxXRTlQ90IBqxWQPqx4y0w8QSmROb4i2pQ9iXr7dv4+oiWmqR0nbsv5YNkUEEy3efvBWe60nNpMB+j/UJG2Lju2bRSYKscc52ck5JR9lWfNtWhAVveR75NFvmyOvTWUHP4nFr6+5LMe/xjGdZ0AgE5cECI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gq8wZPQQ; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+3d5GO3V2LIlU7udrLjGfEL5V7/+6kMlGFsXFLGXE4Gjwwbm3QhKsD4hd0VCGVzggXbNqknoJb8S+obM0oTFAkFsX3VnwDiGdF0+T3iB6Blpr3dxco/jYg1RcPrUe1h7oaTZz93I/l3TbO3/rkhVv17G1OGM8MAOdCPHbNUpSOfek/NNhLhv4ddUoBTqMmniuEgMfxxwktYwe1By50AShWTxp7CGMNPZ0pKUKEMMD7xRXi/3vx6qj/IicaPZFAnAsopzw/QoujW5PuwXCKe6DcV8WssjZVoIqrqmtJXGHtyZwmXircrcPvGx5HwpbOk0KdvI9Axy4jlbGgaHKg+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJth/+o77dQ5OhWnXLUdF+IpIMi1Eyqp6UHQhKEdstE=;
 b=MzkWXc+eOSznQnhNd6Jac5klh5MqvTqsxXFJIHID16yXs3s2uwtm2U0QsmafNnA6aP4yApbl/EaSpKuLEMD3oc9ZJwlX4Q5oeTSHqtdxBngXstfTRn1HcvzPuL9MNC8WHEtg4patmJnWxAx5HCkcd+cuCTr/sHrLU7YWXsTn8Ey0LYOGL8SKTpdxN/0qu7N/Qd9Oec7F5zUsKSEIC8lrqPWcrey9oJJtLj0xFKi3eve34shg/xZd4wSm2gid2yxB/PFeByBQtWcMco+1muw1GP607OnYILLyjALSVP0SQcD2Qn8euDaX9Vb6FWkPsD8f/A98CgyDMwnK332N8UnGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJth/+o77dQ5OhWnXLUdF+IpIMi1Eyqp6UHQhKEdstE=;
 b=gq8wZPQQPr8u+xMsAp0ahPmjUi7Dbn8PoZ5mCJSNAii4HqwNtLDH9h0bE3No3GfEFvQHouXRTHK/IuvKdZ0z5CPOpdRo0fczbiDo+1R/xwscBfIlu6YAhcexKRp5C7SSzkEu7U86RWN2gQnwwc8GalWzcdfQ2f9giiRBp2jCAF32ohDTMM4UL+kW6xUW3Rm7zTwyhCgZLw1mrUT/iCo2ZirgGYP2Aix6L6Sn/XU3af7sYazrDACvsx8upLMxCRyfvo6NYX5L6Zsk7AXvCAGbFx21K+3P+rsg1iIAVy3S9EdCCgBOKeTKGvzQcKQR2mpwPMk4SG6/mHZEsnaStlZiHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 01/15] net: fec: add fec_txq_trigger_xmit() helper
Date: Fri, 23 Jan 2026 10:21:29 +0800
Message-Id: <20260123022143.4121797-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4247c4-777b-49fa-9221-08de5a2634d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0C+QCa0HR/VlDEXklMzbZh+Qm9IAlUqwT334WAGsJV2jFbeUkjMcCGq/LQAA?=
 =?us-ascii?Q?cWMxDuKxc34bhJPDB63MDwfWxJcZdaY6L687x3UduzfYszBXRc5l3WK+akQ0?=
 =?us-ascii?Q?z0cCOv8Hu5IIUgLhTNzDeMa807/oMYXiZszH3HH0P6ewdc7wV68KEUj14hQ3?=
 =?us-ascii?Q?sbV9oL4TzPq3jYljLDc2vldGcBSWTvc0ih+6hwgG2WRoNDnh471HPJkaSmr6?=
 =?us-ascii?Q?mZX84H6OZWa46WsATob/uq95fRcmdfBhb+Ic8LWT+XltnxvP0vSQdWc5Jkto?=
 =?us-ascii?Q?V0O1KFFPIje6fmZkF1OAQhNMadh6MrxRnigsjXI0GDxnXzZfcwShHMYyabo2?=
 =?us-ascii?Q?1qGzY6g6odyJlDbzXnIc/8t/76uJTpKOdoZtNBzzKCMZ4ccfuvUtrJp6yd+1?=
 =?us-ascii?Q?/5y+OrdyHBwjaE/IB0HpJEDx1rZ+G+h2yNrB5AXXQDPEmv+wK0u1GVxbNmqB?=
 =?us-ascii?Q?p4vxIV/Ze4op5PKh0SiMl9t4RxAcrXUQEP/h0WK4FcVzOkaFpA/Xo8niAQ0S?=
 =?us-ascii?Q?6nE5lxzDe00Tp3ay0JvEiL7xmufWuSufLGQXjYCeJ88/Eio2NUAn2h+diQe6?=
 =?us-ascii?Q?I0YMutCXs2MDQklL0ph/xZajWiZwMZYd31HGbJuuTCI/5XZrbjIOBQbZxP0G?=
 =?us-ascii?Q?/QnCJ5txK7cOsDOqxahO6yltLiIl01LZ3i8crTYJyEauw36T3WwdDVmBN0IV?=
 =?us-ascii?Q?WhJ4b2o27TTo42L+ObJHO/TbKqrAs0rGepZ5bZe6WZTWOJOSwGMb79uqQ/8v?=
 =?us-ascii?Q?d3HENf7bdhSEA+940dPFk4J0t0fwfm249oOkBcFqCVsm7WsLXMDsh7YsH5wr?=
 =?us-ascii?Q?rfCr92/J/J1PY7WNKO5TB/FJVo56qz06/SxFXwFFcnDXMiJuOMdF/pF6RMYL?=
 =?us-ascii?Q?blgfcJHWjUqZbGBRVmg4CKEAM4bL9rhfm93BomtbyTaYW142KgX4mohB9+sr?=
 =?us-ascii?Q?V1cHwrwFblzrewGCeWMN5S19VuY6ZIFvs5egD06wWYLBljYicSNx6hq0QUIl?=
 =?us-ascii?Q?Vb7Vci8SpujfEGP2nrGEmhHlbLcl1EbvbTC3R/092eO1IlLLhCdLxn0ptqfq?=
 =?us-ascii?Q?FWYwcjnDPw0kt/+grxsVjiPGzle3goI34Rnfwu+DNhuEYwsPSjRMcvI6xXB3?=
 =?us-ascii?Q?oZQ2G5lW5Hd9Tm0VpOw6DTqEZs0Nv3/W5tI48f1m7YUsBCQdMmA6K30kcaGO?=
 =?us-ascii?Q?vcctYy7SDOQDmRbzNLjH8Xrq9yth+0NNn2cKxprGAsJMW/S7gNHGipbR0jAC?=
 =?us-ascii?Q?fi6DTAd0D4r94ujyQacGYxc45DW+uw4YXKTOqdZ6Hy3CWHMEcqPpb5f9+pba?=
 =?us-ascii?Q?XcxK1QpWB6M4bmqEETwUfZfHDtNaKBUu0TtnpZazFu8eGjuyQFVBnOIIGsj/?=
 =?us-ascii?Q?3e8I0e4UFx6u+UgGYoZm2ztdn6cy6c8hrqmmU+BkyJehSsM/wQx+SvqkyTrA?=
 =?us-ascii?Q?KBpPkRZ+TZAR2FtAEmyvGbgwm/Q6Ny/c4KEL6VDZx96btBSnp76XZYMmu7dA?=
 =?us-ascii?Q?r+a8ohQ0a4DksmP/w/vNaJQv4LWQjkG92CpYeOlFgK+Bho/ul8wO4ZSycO0p?=
 =?us-ascii?Q?X3hZgIVvR3BXL8HHYIu+DGUxL1MsIIf6gqnDHJpSqqic2aUvfQqQpKnyYYEq?=
 =?us-ascii?Q?cgD8+erF1v6FE4fNoC/Ua5GI9p+YLaX446vAcqA56+EJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JO/N4HsOZl8GfkWhxoqcKplN/eeKJT/kjtIBIsDXXZG/+0MHtDaALYXo5ZdB?=
 =?us-ascii?Q?rf7s2cVHq5bXvh9o+4DXg30dkB1G+kjTWpJT/J1mnXFfzHGtgesqx3yKjro9?=
 =?us-ascii?Q?ez7I3ToGJApxK7AeIBcMdJbCpe2Z9ujJRIh0HkWeoCCvjo317xRg1Ao03Ygz?=
 =?us-ascii?Q?MF2xBgsOR/OduaIRwaWwepBelETTwmFZTemtVN2iNhnUjvfZSrepaZJf6Usz?=
 =?us-ascii?Q?ByiyQjOwvtcdYsWZFHg3L7rY6JpsSp4bvQ9lZX2HR8CxRMeJKr4LKdckgL3H?=
 =?us-ascii?Q?bUz6+n+vY1KgrxDwcya0beWiUAS5M4jIPzcDEV+2gic6HNbqBHNGWYnQnTOZ?=
 =?us-ascii?Q?bmHn5gU5L5u1ClB4j2kGsNPxEf2Jz10slbhwdq9ZNalHiXT0LMouxfeio61K?=
 =?us-ascii?Q?mlXmfkI5jekdvXdb08KHoFTgmNo6svGgApbBSiIHxA1v0a9FCa1wHVVAFjTX?=
 =?us-ascii?Q?mSkNXnFQaNQAsCNcEwsabdSGV1TO0CrVl3zmByNB/K9ppFGWF6VtVWrFLnG7?=
 =?us-ascii?Q?7psmLfkcN3seXjb1/hmsM+jxg0XFy+tTSlqEopkUY3DmaKcAsRYGvuzobOOe?=
 =?us-ascii?Q?6kXabYHgob64r0H+zka+2XyTtlRdfS01P1oytgg3Z7VRO3eC/kkxVCB9BQT8?=
 =?us-ascii?Q?0Th9l+8SYvk61ROGAV5So33k+raBGoIqEyNRdkzkxnkQiHe+ci+RRd0AKfTb?=
 =?us-ascii?Q?d9dJqxdhwvOfNTrcLfzcKsoWllDMtfZpZssDd4qRx1rMSAXbzg9yrePJLcKc?=
 =?us-ascii?Q?wJTBEdM4iTtB0uJT2PuyRKUBGoTjVvsl6Iebg3eol6hik+0EYw/wu3hSIifx?=
 =?us-ascii?Q?5BSEfEqwsIowvM63/pQMaEohxne0yNNNcySbhQVVMZk6VfDFE971nMNYLcEa?=
 =?us-ascii?Q?ChsaND4kxtTh48K2taXNkeiZZC69xnL+8tL6A4zz5fKFrYuKAQf+YZ6ZOPGm?=
 =?us-ascii?Q?g7MJ8LHZIEKUne4Zb+9F/ybb8TP4Yjf2yNDQ6YUjomTUBE33+qZqI5Zf12jA?=
 =?us-ascii?Q?fCcxTykxpl+82zMtkvf+X+B1NgCPYEYf6iguBovpPBBvEH0Iht8NZV5jqdpe?=
 =?us-ascii?Q?iFS4UkRQuhgNI06W/M9IhFWpqV6LPVfqIwHBoj6iZ5Br4WrvXl6WOg5sTEbd?=
 =?us-ascii?Q?28enoTJcKKwq5uhySoBe8clUc0MBW5Er98WrJC8RRxE//JjEyB7tns6ST5oF?=
 =?us-ascii?Q?GrXi82U5eUX++iJvCmI7pp2EwXyNScAnrSMH6f4DQ8TugbOOM7rRmV+Q+INU?=
 =?us-ascii?Q?iRwV3s8YFi2QPlWH6tGFmN4L6E5VVK6p0SPJOlTDDtiWexd/dGK9DJvgwrmd?=
 =?us-ascii?Q?aamXgZ+XoJufMgXVY3emqsYaSLBZ3JLrdWoeTEQdWgI9S7Zx2jtmMGAC1rs0?=
 =?us-ascii?Q?q+/DCJzPbZ67qYLf2ib1f2amn3YBZiulI9JrxCjfmq6SWvgjgtBCj5sqV1Pq?=
 =?us-ascii?Q?LUC7k5q/LZFlDpjtY6ByfTmN0p7mQ8aNzK6mvT5eRnYfDtFMs6fjnSHPx53P?=
 =?us-ascii?Q?1vXBnJgzcU+ckNGhRkYun9TXIm8PaL4d8+K5zU2iSSW/+whWKrCAPXv3k8ch?=
 =?us-ascii?Q?W6IqaZB+9SBxeIpY2NzKYQoj8+3l5CeSrMQyPVsry8Ebfwai/gnrMVqjSlfY?=
 =?us-ascii?Q?6r68BHD/Zr1036T7gr8e4iYApN15xa2CSPSgry+zhTN0brPnsTIFAHE6k680?=
 =?us-ascii?Q?1GfkGiGyLYNclWqeoY5EuuXHK4l9/mf2hnaWnDgxjOWQg9+x0vJNeZdd0MKX?=
 =?us-ascii?Q?oVLz8yO51w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4247c4-777b-49fa-9221-08de5a2634d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:07.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNEZhWXtWAk9VyAQuHmTriedf/UujwqnVVla9H1/iZuVsGcdqlUHjlEpykdAz08e29yxR1PGoTc7/G2buDyU9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252600-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 36DFD6F8F2
X-Rspamd-Action: no action

Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
so add the helper fec_txq_trigger_xmit() to make the code more concise
and reusable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cfb56bf0e361..85bcca932fd2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -508,6 +508,17 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	return err;
 }
 
+static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
+				 struct fec_enet_priv_tx_q *txq)
+{
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
+}
+
 static struct bufdesc *
 fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 			     struct sk_buff *skb,
@@ -717,12 +728,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
@@ -913,12 +919,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 
@@ -3935,12 +3936,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
-- 
2.34.1


