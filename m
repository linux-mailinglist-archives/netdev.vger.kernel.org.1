Return-Path: <netdev+bounces-256135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7uacA+SIgWnuGwMAu9opvQ
	(envelope-from <netdev+bounces-256135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:34:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4950ED4BD4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B38C31539AE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760B369975;
	Tue,  3 Feb 2026 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0k7i2RH"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA02F12C9;
	Tue,  3 Feb 2026 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096179; cv=fail; b=TiM+8woab/dDc814Oi7Eq2gKH7sVxDNje6jULJ39P06QyighmI0YuKoeSK4nNtscIKB96k+mLtNvDXcTNok3TdEhIalodsxWksgPZCBdTSGo5H8GMBz2mzYPKhML5s96KCBRZe2UZHmM8SQNwoRm+/SwXuMffAq/f2wOmXcSAvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096179; c=relaxed/simple;
	bh=6GGNzcJCtx4eQR70jjsWxs6oqEz1Hlw+LueYuHy4nbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUhSCX1zJq1O/T03WZmoS3A1zLssW8t8saa0kU54XmI8fCvo/iscOibIP1XVXWIXfVwLJ3L4xHKf2gEwyA/71pJUPn0lSbG2eFwPx5h6JClJHbA681Djr1EZ1+G9lci4HaVxLAiHzc32h/AMRdRtACLW7bJnyurixRKl3J5/NOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0k7i2RH; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD22OkX+12ZQBVfsBJe6qL3AVIVyQ4eazkK4iDe44B1mKP7RmSd55XPsvJZuL7LZIW4ltN1Zx9Y5Li+iq4ePHF+sw2K9QUB24Y9ws3V54ZKm3n0fUmaeG2II6iG7+McMfb0NNJYqPXLlqO+YIzihtA9TcwS1PZ8Cjur/N/RDbWJ39TR5Tslq4il0Ab6gkIxWQCgNmBfmM5yliTvZhVIKPP7mVCOp4SCkM/D3WwbgMmdgEYf0JG1gml2ooVxk87sfmTvJR3o8Uy5t+szf9TjvDHhQDnOQ3AWA8UgjygLsnju+Kabn1+FJ0xksAySMYeoPrTvwmgkS/ZqOun2d014Ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf8+469aQwIBpn++iBYSiQNm0wYcS82qoYzRsrcUtFk=;
 b=eYYKpMqaV9KRhXCK58d5eaOlBuCsFMYESz1lNjdvNnnfNQ3HjaFZjKR28SEuYG3FLIyey07YSTnswMhjjQPjzEGpMhRptGmICWiL+LJpXse5hoEEKXmq+PCCuHqTeqVXLlv693w3iJjae2tjsWb1mqrI8jMSbVFrWko8drV93vPk8/9dDaUJWX7vGP9aLTvPq6Yiu1Tvf6XwvGdwPJ+Jdrc03GuluHSVkHOrgYM9VGXeP41q0i0E7IT+uJ2OSEUQov7EZ7o9gBjKVXdflmE+EFZJq/SBGh8lUz1ufxc3q1yKa6HDaQk7b9LL51t1cwIRSndx85H9+JE4FJpRBN1zCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf8+469aQwIBpn++iBYSiQNm0wYcS82qoYzRsrcUtFk=;
 b=m0k7i2RHAa+cDU7tcSKXrz2xAAhuD7vFRYJnwVfpJ8BsIivEnE7laMapt3jdw6W9/T8LQmY/XxLky1CNXweJEMcWasxT1Z1byRw/ZeUSwfbZMLGHdv4Hf9Ifi0B7/IEAHi5isz3wcVDn0nNZdNN9LocicLbTl5gJ048BxkJYw/YXjheLo82+8WbAIG1RAaKR4dx0YLuJKX2GezV4FAwsb6KhLE5A8Vl9g+b/UltrnE7tVkwMMYyO1S7IJFPrz+duACDcDsLETfqEGpdNdldSJSXaJkE9/pCphhd/XR/lIrf8r5Jwb0ZSS23Q5SREiBg453/AyIGwla5mMlwUlIg1jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:55 +0000
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
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 08/15] net: fec: transmit XDP frames in bulk
Date: Tue,  3 Feb 2026 13:23:22 +0800
Message-Id: <20260203052329.1085444-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dc532f-75aa-45c5-9f28-08de62e448e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Og3s6dgzAmeae3Hr/fp7xAJKQyCWaXIJhJdbVfnjkdNlI3ZezjMqZ7+nVMm?=
 =?us-ascii?Q?snBt25AKGvmhLGZVYJdGt8UM1SMN2Lyg0nd0OrAx1OJqYOT+pN+Lo0HM6YyO?=
 =?us-ascii?Q?XK25EbIRQtGy9Mz65zIFRpo3PRay9n6A2yxa2zo/wojSnFG824hVuOPVvXpd?=
 =?us-ascii?Q?v+zev/1UVh7QZJucbTo4e4rSh/hoGJ6dpuvSIrQadezXI/HyxRZNZWJ/c2BX?=
 =?us-ascii?Q?Qnzy/wSDjHu58EEFG97Zz/ejqTz9+1rRog8xqbtxe+XITs2O0fljS0lgoitb?=
 =?us-ascii?Q?q1ny95U7fkClk1aqp0Fuh2p5B4qVXabSBAObzmq6fycCYW2vXIkflQgBD2vs?=
 =?us-ascii?Q?ElnVWrB2Z28yuFN0lll5uHxIkI63SX6yL9OwaKdbsm0/DhyY1Ta+4Ro1I5H2?=
 =?us-ascii?Q?Cw31qv41V50Jluzjmh6gcrvmzrTPofJ3eyknl7uUqxiWH+QVeoil+O+z/TBh?=
 =?us-ascii?Q?lahjymq7o9cJGL62CA8mLvPcvSgMNH72+llvXHmnjP/VuRiWyap/bpQovfha?=
 =?us-ascii?Q?S/+QFyNQceJQTCSdedfcPOy8o+UjJf46p4/iBKgXBSS3mp0RFPXzU/NCpDag?=
 =?us-ascii?Q?z4hzlAIe5EYhbp8ddHPAc711N51oQhliq9uE8O9bnQNgI4LACzZXtHCMj5pt?=
 =?us-ascii?Q?82IccOjYussRF3LocaeG711tcaaIRC+eYdURU1Sf+8jJ+O+oljoES27qpo8p?=
 =?us-ascii?Q?Ayag3FDHm1Lgp28H9XzNbSkHFWgW/NePIDHlTin6lV1/KhfczfHeuUCcNXzi?=
 =?us-ascii?Q?OI6aAxOxjTjMxqfSZpcQ+joogFoHXLyp8x5weA/PPxNdI2lbv9iXZ6cptVqT?=
 =?us-ascii?Q?QsCMr/RRq888ZRUxLQolJ7SJN4v1+Atm0WogXSH3Pr4cWxjboLhSO5MOUJ++?=
 =?us-ascii?Q?vZt6W5rkudAGIF0iqmUFd77oW31fJ9wZd9oZJ5D/lZnGjfUBlaiwduHY+Jmt?=
 =?us-ascii?Q?C4bnfQ/ejktC/iMG85dvB13bLw0g88ljMjRMzGMpRdrdURPjeYan6Ap2lQnb?=
 =?us-ascii?Q?P51BpdhvyJtIhR1h1NEKVb+8etcGbG6ZCxpqfjnhtsD+NFTZJxcECeX9Qwar?=
 =?us-ascii?Q?+7uJSsF94hjlUjCy2LQPu84xIrmhd7du5rIlS87K9qgaKcCz3sUfZBCI+x2s?=
 =?us-ascii?Q?EjnK0HOpie0s3RQATTjRuVRfZvAGFPlWddvs9Qn7IJ8Kp7Lk7EnPgvkAKmw4?=
 =?us-ascii?Q?EzsNVqpYu5ViiqFkuUwMupON4TXSPvQMy3xhn4Nx4LdGNrMxUVjdPpa907kb?=
 =?us-ascii?Q?O64HJ/KXGBZ+L02sypLSYHDq/dz2/V2igUV6G54oVaMxrmNFJrJeSxUZhIzL?=
 =?us-ascii?Q?wu2Ha/pu/nd5KTIaIRdundbK7VgMpp61JcUF+Zyxa9OZa++niEKEMY+AXXcw?=
 =?us-ascii?Q?g4PV0e9PveT0Xf5VTjU1hwSWEJjM/8MkdTdyKFgnqxwE4LbZpf/LUTBE3lDS?=
 =?us-ascii?Q?RfoNPoenrc1vp53lJVFwMUV06UPD5rmNo506Usu6lC8KpdGpB1ckWw2rDR6S?=
 =?us-ascii?Q?6JMDLCZetjphWI/9ziyhJ/O2BNpVohKgUZTZbudl0txnoGk6c5Ad7izn8RPZ?=
 =?us-ascii?Q?YT0qBA9Dc/55ft83EzVmYkNt1GnG2QCyo1PyQEpQGrBuI1cDHqe7anWt9EbP?=
 =?us-ascii?Q?GD0Q296ilxbOP3hTvV5mxU9anSYp7u8ivBAnP3DE11Db?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UE7NzyaXxY1IZ72TWLXXBDwPlLwFaQGl6GcUZENJAED3hw8mAkHpAzr4m/80?=
 =?us-ascii?Q?laEJc79UxGvH7uwHQe2/g0gz8CIHpXz6flIDWc+qk3iLagULSyLOeC/k/fqH?=
 =?us-ascii?Q?uK6B62WuG6S+bZPONuMbv+vKHD6XcoUuy5aQ9oJirKWeB1q/YpblerMjuwfQ?=
 =?us-ascii?Q?6RgXcTacgPHz+7LAUJ6otTQaW98WZtfumhZ9z8xelFaW/z/8q6A6JgX2rKVg?=
 =?us-ascii?Q?a/v9UOQ5fcs7bJUuttoUjAa/YrsT5BqPHOPw02PlJs3ITi4YK2Cik8Dg85fh?=
 =?us-ascii?Q?b+bePlcQfQOibJxA6ThVVQjObLKMhB3wODtgN/jYspGiaoRqeIwNw+aIzkp2?=
 =?us-ascii?Q?0fKB6VRtdsZkbfjKb8oQmaYdCVWEKKFj+RLgTR0UPPag2qqZVQoliTPd9xGr?=
 =?us-ascii?Q?M5MC5srnMPqz9MZTXGMCQNH0JnrbGbHmUEWbypEVixAoMWFJoM36fDSU3LsI?=
 =?us-ascii?Q?wuEH3Ze8aohAYhc5wRMmuTMRTkNYeH1VDWadFpU8z4prRlK3LdqleyCPaZ43?=
 =?us-ascii?Q?JsxicKD+911PUeCkdTYLu+Z0W+MRGlQZv6JVuP+82UhvmRT2fNSBkK0X4FAU?=
 =?us-ascii?Q?G2bJHZmD0IJz04WEyh6P6c9+urqiHIAOAimbVOzbSbiSpYuZlKlgSVbEGrnF?=
 =?us-ascii?Q?w/78bo/LjWXVjE4qUKvnfIxnccXYIRFgk/oqfZ2OtYlWoPdxu8dIhnuBuS+a?=
 =?us-ascii?Q?juW+pcNYB0hvtUW50ktxdldIu4fHhD2GYJBMxzQwKKFT4XbQGmez2Z63bLx1?=
 =?us-ascii?Q?ZjIHbLOA/n8NYZO75tqBkkfNtlu/traZ1/lgny8MY8v9el2CaPhHVziPhyJN?=
 =?us-ascii?Q?n7531GmV791JLRp1PyGuZ5bxRrFJCtnuw8EIX4V1k55n8OKeTvwYpgqLAgbl?=
 =?us-ascii?Q?eHdzuGE7GqPv8CmLLZpkl7Qcg+5Dj/oEn/lgPPE1fPNN00oddpCrvbug4Job?=
 =?us-ascii?Q?NtBNTSdzZqKpeQwPG4DnrsyGc1UAWKjExLWqfVYPeINB0KVN8yv6yeBHkcuV?=
 =?us-ascii?Q?A0ZALXruJvXxKab4e7OZA3Fm9diU+Ze+fMOskqRujr8hJNQcUPrFfgqJgpwO?=
 =?us-ascii?Q?VxbZTbu7RlimusKtXdopLCJ61JuoSFVLtRJNK1tpUAh0Pe/IdDdxExBUvF44?=
 =?us-ascii?Q?VH70Tjeag5HIRnXZL+UleKQKAp+XaSnqziB9TcvSwyDzHw/AlFtO61DZmSy1?=
 =?us-ascii?Q?NC4ncQj0rPIZ4+5s4BBM7McN9R4+IMbmS+1gDTXEKwJtZFUGPVAlUVcyiKl0?=
 =?us-ascii?Q?u2qSD2Y8mS5RTSnDNBp7GkfTNkjY5UZvck93/BCmU99NjVwG+5i9PCNKD3WV?=
 =?us-ascii?Q?x2QSCE/V8vXvvM0RG5Lxdml4QnSZ/n3yYqCppEQ/2OLxTeEBWNPPVQxzjtnL?=
 =?us-ascii?Q?pG4QHgdorgVGewln7w0Cmd6XcOUZQ7ssvLpPoDz800iqeVELhsklgzV6elR+?=
 =?us-ascii?Q?BD6ngmerKdk/BwDX3yajaALmFgpwb9hscEj4xF63nfPZC1b9hAdZnP3kbfms?=
 =?us-ascii?Q?wVVnvkzv/TmDYohC5YP7mDIjOvKBxh9o55BDcatCXc82QieOIg6T5Je75xCD?=
 =?us-ascii?Q?45FDOGID2pmaLAy2mxo5coPNNIS/JLczVrb4LAep+twG0zOd3Y+7ms5okjdQ?=
 =?us-ascii?Q?qYSBceEYNWfmn6Uf5w5zh9O4gpRSwI9048AAhjjBUNzxQKryB1NJZXj9Za7Z?=
 =?us-ascii?Q?EgUpje3doHHScmguaY/qAoRxiCXEnDq+qk7ZwepaNcuN6erfM3bSWaR3Q1lY?=
 =?us-ascii?Q?Zy4zwKc5eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dc532f-75aa-45c5-9f28-08de62e448e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:55.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QGtvHr1AuiqS3n5Yoq/twolpO+KKvE+UWNSXX9V4y3h0k4nVmQqIo7Jp+NnGpKNdlePD/TTxOD0YsoyE+1PWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256135-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4950ED4BD4
X-Rspamd-Action: no action

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0c1806a46fcd..e0cea2efb6da 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2006,6 +2006,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2055,6 +2057,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
+
 	return pkt_received;
 }
 
@@ -4036,9 +4042,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4088,6 +4091,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1


