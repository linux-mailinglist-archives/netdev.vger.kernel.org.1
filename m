Return-Path: <netdev+bounces-251746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E03DEhJcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:34:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C447C50723
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408A54EE9A7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C235772F;
	Wed, 21 Jan 2026 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HqgXSrqN"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DD338907;
	Wed, 21 Jan 2026 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966464; cv=fail; b=NwcSNS1RL+cJ66B6czh31RT/RG+Ngk5NzE4zOwN/JIrPXxHYw2tvzZ6M1gXnWoVNEJN3H46FX3pw4pI2SdH7VRm7xsQGOeaAFBQetouP561zbLAlNC9W50xo5rpt3r0tbw+XiYEvX8qs7k5wY+Z/7ypu6Fr5ard/98tCzRExd5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966464; c=relaxed/simple;
	bh=0p7smzNxil5mYUVhyBO9d3VAQ+yx3aBrArqmmOSzNk8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V9tJrcy8Rv8dczD30lensuZ8RZ1k128fhsNqgLWn5GbHTFQHJ8xC12+b6nEAKi8oh9/TMyYNSToWw2eRP5eW2lR5DGTQjhY64XrjNulClUmUW0XkZh7De8NUmv6muoBT8hRR0ZwlboIRURhztKec7fMlKwBW4EWHEVXtDzIH+G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HqgXSrqN; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zuds5SBhGpakx7b0WELKZvixG9FSSPHEeHZhvJmYoYS5fzCBtlwmZ4/fAtRRrbkd5PpEZ+N8KzP2IyQ4uQ1Xy1JZD4x4l+rDcKdLg7ISC4jD+4FN8VX/6ygR4wqNgFGV5fonJwkaTZ+8cFkyZqULQw7olFy2QLzZ1jtB5VjUko9QNqtj6xcAXCtsaHU/rip4ePcxiugTRO/9rwCoqOa938Jz79i4Ke1/EbhJ6A7nswhdp84a7v7Tf27dl87Zs5H+rvqne1cgBCeKeZ4DMh2FzY+7zl3UdPljUVblTbG4BroXmucNM3msxhCNak4sijCh+JASwY97OInY6wXc0t5rTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdepfhXP2+dOzzQm/CzC0mwtjdcdyDnAaMcel6ts7oQ=;
 b=JfkCqWbsghPYvzhP52ZIMmLpazOVeVaftQRxgm1QH5gE1XollU79JdyWfm46VoTomcqC7Z2fhLlR0f3XWJORD4I6zZ5QaWey0WJu2swYZ/YJXrzNHRDyibh3X41VZaEFVMxn+d6sgNT+sRSgy+7VuGFOXwd4sHuqYaw13vZfdpFekxyfMWUdvBJgSG/TYS4RjuuVY7hKZO+Wj6tTkcV1yAyUyQt7hkPDt1EMm9wSZpy4DzxkzHHdykesquws50dUwbOZ0wzHnagqRpWnQiRZyS+wzHE4eRQUGtttoxFiwmN+ylcgJ+5LQpTTHb2fKajKcDMTSczRx/uTj70qgI9e5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdepfhXP2+dOzzQm/CzC0mwtjdcdyDnAaMcel6ts7oQ=;
 b=HqgXSrqN1BiaoNEShzwFEIlN0VnhiPPyTaI8M9c3gZazJa9A3pMNs+v8e2IjRjt2gGep/ebwKbddMk3001luZNFzGKNeI0cBnVo22Q86lFy9NG80XigcLCGD/o9R1YglQqlUbRgRVHdcOiucLgpunnX9RcbYHFfs/NyrRdcbAYrRo3Vu0nymPq4RLPipAjYmKD42FajGQLCTGMDXa6pdBDLcJeE9p6lcw0XDi5ZS49AXVwq3IRUT3CzjqH7rVHFIIth9nmsk1T1VqEij/cSwgapBuNaRvkInfiv+Yoj2q60BwBZwxqMEF994Ghvwz5DC8jDIV3dtjXUongajcX5A5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:34:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:18 +0000
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
Subject: [PATCH v3 net-next 00/15] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Wed, 21 Jan 2026 11:33:42 +0800
Message-Id: <20260121033357.3261464-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9e57da-f323-4cd4-b8c2-08de589df507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ow330/6Q/KQx4HTzC0593YphTNKXF2Fh8/7W0xvqBd610QDhEfKS/uTPqpQZ?=
 =?us-ascii?Q?8rrKbgtiCm5MlxT+o2rPkh6wYjzBY5zPRcys0SWxjNfKmwWtE37jZcwvHwOr?=
 =?us-ascii?Q?JJKS813nYXsPT3eDCTnUcHRcOjjciY50Boe6N4a5cO9toU1sTtqtbbvtpd0+?=
 =?us-ascii?Q?5JJPyc/h2fMpurjg9sBGsMxhfHi9MYXVZ8e1aqDLmKpUif42uRS/JvtNcXGx?=
 =?us-ascii?Q?3vnNdLqwgHibhZ/RAk84ho4MW8ExuLfF0Yhqsc8fRmR1zGYDe+YlbhpXqR4l?=
 =?us-ascii?Q?7DdBTjanohqbvDQ8Gb6jNZpU1tQ8PJn1UlfQUWX/VBk3vxmp9WPBPf4PQACp?=
 =?us-ascii?Q?zBNKLxU1JSSl8zI5Gkxr5ezKKgM7zJ6CWxJU9zMJwVSGkvnkDIQo6VxJ7PTm?=
 =?us-ascii?Q?mqCD2JVBOY58KkB6HlLWW9jf71qegmJ2AWNFc2hFPee0K2BpRjCn0pY9MX5k?=
 =?us-ascii?Q?HhRJqEYoKuYfu7T81ympHX1DNlVhcIrXkZeb2xmEef0SEsojM+luMBgCpq/6?=
 =?us-ascii?Q?V4VvWRa6Vq5DQbLzF3+uV/9feKY2NhwZC9N3stQDf/9doKqoESurI6mOs1EN?=
 =?us-ascii?Q?DRzF9/sN9NF/ZOc3lIo7tFNzxmSaMXlktvOkgZ3/2qeK/Azq834JrUExQenC?=
 =?us-ascii?Q?7msESr7ihUFNbpC0paJHqMnfsfPMQGLrrOe4UWpDmB35YS5xcmylL+Ul0pvP?=
 =?us-ascii?Q?xOz8bvC/1/xKhMxmdqGivCe1HpBW0Af9VzLtWMNRYHGHfIZCPLwpcBae04I9?=
 =?us-ascii?Q?6cXaw4DUjyi5WUO9btprOCJGHKpqLGaurd8Hjjkj0J++NbXg3Kp7IUVUllDv?=
 =?us-ascii?Q?l+O0IudUZt222TOl55bwaGH4FZRLFWRVAZKFTwKw3Mx3kZppyc/ruWwpUkQi?=
 =?us-ascii?Q?t5zE42ht2tf4QWcekNHTZC07pSe7hw124JJw65w8aw4WVtSeVb0kbG9Pv12/?=
 =?us-ascii?Q?AIXKmE9l6kHHTo+t+kh8wNNDbiwCPPf80niZnJnve4HxCi7fCQfpFvhn9ifx?=
 =?us-ascii?Q?GHxIiXGwP2I0JJ25NlKRbW8Fx0SSZxJ6kMJZr2Ad5sGkITWs3y5FebAwShNk?=
 =?us-ascii?Q?C8aW3YSOiktHdIBkXQuG9MmWgj1zO4l8SpERBJjuZddhGokfVGQYBZtJKFBM?=
 =?us-ascii?Q?z80JzxGFOvQqVFAy8E269Q1+p7jZVEzwdkzPopWaQMCaXd0YaUpVT+KnGaSR?=
 =?us-ascii?Q?b38VVP0+CpE/DFRbMsYZBEf2a3fOm4bSWpEWvXQMlF+bwXK3z4mieLUqDPm7?=
 =?us-ascii?Q?MVF7ZkUOgk5bH6juMZ8vfSg98X+CD4UtevWQoU+ml8EuAqqD3I9HHSrhS3ru?=
 =?us-ascii?Q?Da+S6nVzMVTLh0p/SwlkqfzaShPHnrfpf2Zr4uDBzf62fUSbxmGR+044GnRn?=
 =?us-ascii?Q?hA6YT2gxQi4Ft3yfH/z1P7hcWMAI008j9HzYYqGiWMrqxlzOVL8wGOks95pc?=
 =?us-ascii?Q?naTeU7iTPSsC2wPmr9dzu6Ji4tkOVZIu/aA63PIDLrSzmcqx4I1a7XFM6dcf?=
 =?us-ascii?Q?mreZF9v0hUG6YkizzQT1LUdkCvOG9gWGjQnXTWRTSHeKJR2gIL8pGxrxfmyQ?=
 =?us-ascii?Q?fP+mxw7NgwsUZBV4hFcbSYheoyPCMlNO2gXenwgnLiHKtCOUmVyc5l2QXRd/?=
 =?us-ascii?Q?XfOQwh3DCv5EZiOU0r/mEW3Og7YYeaUGtUGL+98w/EyB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wEeAaD1DeqhfJU4JB3dNsemfb0Eqy+h3+jVCA/ac3hEvyrn/S9PcnnzPELL?=
 =?us-ascii?Q?YzCCsARK052ubh8Cxq5hc8nIKom1iBbpU/vLKXeDsjevaT4bEd40zpZheNca?=
 =?us-ascii?Q?uxfD7UIwfjM81RiB8zf6q8M8BNIF36LAJsNWyGZel0dt7xYo6/vMSA3lKUEq?=
 =?us-ascii?Q?pQ+vsKpb+xtDMGBW0XTJL7j7zKHVNHVEcWwU6QZ4E+wdo5UhgcjyYHsQKpYe?=
 =?us-ascii?Q?1IS1BQvsxBWhS4E/lFGBmtu8GS1gEHd33mjsxo7yc3RzeiFrYXRvZKo5V4vN?=
 =?us-ascii?Q?zQtjfhrA29FH/Y4BEUETZjoJHDmO3RTCRJ2dYuAv2s7RXwsAojJDN70u6oiD?=
 =?us-ascii?Q?1WB98uOKO8sAJ8hQl9QQWBt5DZ/PnVHYsCWK/1gfRNiG5zyCcCA4WcrqpASh?=
 =?us-ascii?Q?JgBjYHRVh+nRiFVRDRVxDODzZGHrSAY2VeLEK3cugDsLiHjVe6sP8Ln1zS9k?=
 =?us-ascii?Q?JWXQcazVRkUUzPJYlOzybzvGNUgDJrokTYuqLzgRf6sWRw2/ppqhutDYsNPa?=
 =?us-ascii?Q?qVOhCl1G09CoqAcU2KRXXXOzC8RA/vzQL9OC5OGwg+udVk8W6n77QRT+fm0N?=
 =?us-ascii?Q?IKTX+kkQha8S0nL/7MU0OJXtQ9PhoKhTE9j0FXzd0YtbvOFNTKYF/aZ65Luh?=
 =?us-ascii?Q?Z6PG2zT7r2iGGmdVyp3Kh0sNwil2XPDeTcDNTz04MyRlfnJXuZx3f+buURIk?=
 =?us-ascii?Q?CKqKJGE8Ec/0hu6mbXrf1Qa8K7fTw7nYw7PeZmJbY+DxYlzCnlxgPrugRrqt?=
 =?us-ascii?Q?7Mwqh6fJ6QUa3Wfdy6sM5bLR+cyOHlyF5qS1pTB+QEvUXFBCeooALJU5LcWs?=
 =?us-ascii?Q?C++DEUPH60S1eqE62G4ezRckLhQbJWF/sEpSmqqh+HP5YpMmtsgbNVqERXbC?=
 =?us-ascii?Q?bZ+4YS/gyx2j5Z03xVdro98xKnO7t3cyvz2/bhRgW2/iw6ijzrhfPb43gzJN?=
 =?us-ascii?Q?4jpb+zxP4d1dumQgZDZsanbR4od8IOkpenj3g+/p2ei1fKTWL7ZkemDe/brd?=
 =?us-ascii?Q?Br5PFXZfL7KnadLCnL+xKLB7s05Ypx1aonrmniv2c9jM/vmTGIL3pMW42A9p?=
 =?us-ascii?Q?CsIAXCags3LFS4uWvJWZUHZkvWFQlnXYVD6ENhu8vIZ7wlL0wzxnl5XU5FaU?=
 =?us-ascii?Q?hWTe1jXmV9L+0f9UwecU+lEOK+6QfFip5OYffqfYP1zH1uXf1TMYuCwqW1Ro?=
 =?us-ascii?Q?9syyCTdXDWhPqqKid/zjMLMxkFPOCFKQa2T0kHQXxGykuTi3lsFULsVes/wB?=
 =?us-ascii?Q?S6g3bKpjIK7gCaAhyKAl1O1We2kAyPh1Vc/7iEZbimkjEiE0kCC08R2ALFxp?=
 =?us-ascii?Q?YOXEHnM2JodBLEh9wruWNhiWOkpcBTYWg/2qk12V15C6Nck61jrQsLssVSuc?=
 =?us-ascii?Q?RZ4yq9II8sGU0VDfBEdb1tH1yC50qr/0BeVft0oPYwYSo6MsG7aZWMvYawoQ?=
 =?us-ascii?Q?i1lIlUHeec44bbLNsLgVjrWYXQIPIe+lIJiVJZ5pjmDs/VHqWDceuElFSP1+?=
 =?us-ascii?Q?2LVDhbdVn7PoSsLwRQdvVuoTx0/Jg3yzUpCivDB0cAM0LZ+xyjtfy3T9GJc2?=
 =?us-ascii?Q?//iUb4ORDhQUjuAYXnJxTKkHSI581xm1v+vc4MPclgzFLzBzd/Hsn+EXZhGf?=
 =?us-ascii?Q?EEygAFK6JmGqMHa9Qf9D47JF68ktBj/WjQsq57+Ci/Zdu2SuE6Cq+v2wVfMY?=
 =?us-ascii?Q?zECHlJ7Y+wgxhV9OQUsVgjeDZ6BwXxdN4JhCVwX1x0k6mOb6vTmlDDej4xkK?=
 =?us-ascii?Q?66PuaKrBtw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e57da-f323-4cd4-b8c2-08de589df507
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:17.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CU6XCWG28wPzEL897uhuPKor/KoDWe6gw8PfiVVqVbZYK8JOzfOikGNXMacAuMXL0Hc9299zNcht9QYVLbYLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251746-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: C447C50723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

---
v3:
1. Fix build warning due to missing break for the FEC_TXBUF_T_XSK_TX
branch in fec_enet_bd_init().
2. Add new patch 7, which is separated from patch 6
3. Collect Reviewed-by tags.
v2 link: https://lore.kernel.org/imx/20260116074027.1603841-1-wei.fang@nxp.com/
v2:
1. Improve the commit message
2. Remove the unused variable dma from fec_enet_rx_queue_xsk() to fix
the build warning
3. Remove fec_txq_trigger_xmit() from fec_enet_xsk_tx_xmit()
4. Separate some new patches, patch 4, 8, 13.
5. Collect Reviewed-by tags.
vl link: https://lore.kernel.org/imx/20260113032939.3705137-1-wei.fang@nxp.com/
---

Wei Fang (15):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: improve fec_enet_rx_queue()
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
  net: fec: transmit XDP frames in bulk
  net: fec: remove unnecessary NULL pointer check when clearing TX BD
    ring
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: improve fec_enet_tx_queue()
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1456 +++++++++++++++------
 2 files changed, 1080 insertions(+), 390 deletions(-)

-- 
2.34.1


