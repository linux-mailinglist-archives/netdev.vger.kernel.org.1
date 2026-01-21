Return-Path: <netdev+bounces-251756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENNfHOBKcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:41:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E074D50817
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751667C5410
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D203876B3;
	Wed, 21 Jan 2026 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="if/isMl4"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F5361DA4;
	Wed, 21 Jan 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966511; cv=fail; b=EoU/BsvcufyfEP+W8lmgvc0Qpt9kz8WQcXw+if1ZjZAX+RgSxwEv3iNQx65AVESIA0Fxx6+ImLznfeR2nk38hFtbEAjpzlYQzY8NVTsfUk2PFP8V8rPwtiPO8+9RRJe1y33+326I0mrCj7H/TLCTIhYGBTToovof8yzVZBmwt1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966511; c=relaxed/simple;
	bh=KX/6dFJq8dNWjoqlTwlkXbIhcv8tySeqV1fFdBf4Lfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMq70DovWyPaaVSxPaoqzvw2e0e78IkM5FL//+0Z8DzckCZvGd5kmipU2N0pnsWaCTBXBJsmUdAAWdaFOT/yoUqgiwo7glTlzPTIVrVtCXqnsy6x+2kyW5FhH4pcWUg5Uc13ORVlNHJZzDaa6cBcdbCjcnFVtC+hC/P/LQotoO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=if/isMl4; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOK9fmPK3msIZSnOtx3fRE2Y1vMzZc67+qyrqf4hjPE5KKlPBNs2dlgmgi67+358TKpxdr+zREGZIBbX4g8n531MNsj4NQimUne5csHWvNdwmb7pwICnAa8fz8CQ2tfVV23HvwTIuZTBQg25qfHpI5Nn1WVCgwm5JA5RdrEruIHxA0eSPTMEpabJQGwfYCAon31KZ/AQ62Cjg9UkkEYN4WEmExtQbc+JEcI632bB5UEoGoGtWFbkXzwmDVQNdcxWHxSj3Owh2KC/BKPYrjYk9vmJFO5vtOxPSR/jm2L+jxyc2BO2iSARet84P74hyrohE/iwDxxbLWAKz4y23LgTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDq/O2OtJEdAJu279zwezyZejfWXvLkgh+/gRtunn44=;
 b=y++8kriaTiNftzDDSv4DI5wViW2tWpfCvsh5TrQXOwa1CcXBgPHDck0t7JQg8cBhb3YU2j9lS43+TeTR5SMx9+To7IgwZnj6yL+LeCXCfhCfh+MBAY9HCi0Z3QRrQXrYtx1eOJhPT04DF4pHCl3obwajIqILFYX2X2yjI/U7Jx6zvg/mhgP3tWzjEty5dYYQycCBwvFnQbM/FBsJN9fEPNYS2VQ5DVvrPj2WLiJtvmpn/kv9XE/CfSeVBQHzhfC+ZZKj6XdW5igm0LiaVRVV8X5pYE3QcxyId8YTD2txGQlxkATPr5TefN3RPujkPBAMZ083/sXBc6rwAtqy8EVluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDq/O2OtJEdAJu279zwezyZejfWXvLkgh+/gRtunn44=;
 b=if/isMl4+cNxS92W+Pme1pDjk1Ij5UWlr0NCScvsrtDZFV5RIphHBZ3b/lX9ZZ90ksf/QnZn0H4Zhw64IVyhwgdzM6LFyeEPGJkgUUV6caLiaKaYKtIijvVyENtu3SMtyuf5d9oQQbE2eQnryfdYW1YrJGXgOTbtpH3kHKZZHvAjzv8V8mQyhutfwQhkNKsSzJe9Ygv3Vhus+O6cWjOgdqytjydU6i7Ut4kk3NfhVdtnqqcLAXcEBrGkPMWD5Rh+QapUO4vlRr4WMBWu0YPVN5PO69pbS9ly9XDiiDCIPCjWVWdaAkaOjhFtU9bRMr5kU3at92GwZOK0AhF5FEQO+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:35:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:35:06 +0000
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
Subject: [PATCH v3 net-next 10/15] net: fec: use switch statement to check the type of tx_buf
Date: Wed, 21 Jan 2026 11:33:52 +0800
Message-Id: <20260121033357.3261464-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f387e7-2b1e-48f1-0c5b-08de589e11ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohE09SHu7WWWiikyFaLUDxQqr+YgQhnHYPkA8tsks4X2UcZSWZzeuoxVRIew?=
 =?us-ascii?Q?+WxSjXBhbu3LmkdX/l1E9Q5TqH3j9WT+Pfxas0VBE99XVwBzC27ftXVSmxS7?=
 =?us-ascii?Q?0GCno06s114Ae4r/EQB+m/x/b7SSWc2mMKToRY8jRTy5xff1bfBAWoINfU46?=
 =?us-ascii?Q?vKFxhitlXolp+ASN8oTo0RBBQInrN7yYQ/SXc3ZeaHuBGZbhHjqw2jHCW/Wk?=
 =?us-ascii?Q?YVov9NZ/FQY3+2sbL5BwMamEK/OLGNNp9GBNW0jcoH1e8VOD7SqfP7eZhP8z?=
 =?us-ascii?Q?8xHHU50TghxH1wPq8mfoSIc7BUxtgGU1byf08uty+75v52rCr6Z5tkCIfljq?=
 =?us-ascii?Q?5UoGSxeHGvJ+zclY/eQUDfVhiwJBxflEBGb5Ya7RpFaArUiKnKByLZ1H/k7o?=
 =?us-ascii?Q?KMnkstMm/gZ44cjgrQx0ovl6xAlxu+2TP1uChllpd4nJxw/xT+lxoXG2xS+v?=
 =?us-ascii?Q?i9q4cmfwyhKJMTn/gwWUKRXuvd748113d0SNG8QfeOEkicQ3cKJ4w+OIg9qw?=
 =?us-ascii?Q?58WTD7tOwKaOER3uenbO8f/Gd8xU6sNh9Wq97GUu4Kk3Azfq10kBJYFntxW+?=
 =?us-ascii?Q?Xhq1Q30kT4peSUBDVTCXMRyEAo+qi+anZ07maOic3yHDZyZIA5/bk63mg4cL?=
 =?us-ascii?Q?5LK0d9Vwp5mVsAb7A6WVAJu2oE9JQRyVTp/zbf8Gybs8/5hek1A5dRFAUf0R?=
 =?us-ascii?Q?yIJopiIyVRZMH2/1AxNh6bexny1liHMWRZFjy2yT6vYdN/wN9glbrT3xowLi?=
 =?us-ascii?Q?pXpyLOoWJ9Tgqr4rxxQ0aYmoZMao/uuhtd0QKGxVkpl2nzeCIks5h3uV2f5r?=
 =?us-ascii?Q?i4mHeF/TIho/yLR8ZY0Ec3VCkHZAW71xovlDRKi+TdjBCKvBb1MwB6QCCYKw?=
 =?us-ascii?Q?qd+hGCB1UvdAoxu3ON/GAjgNg9C8vzdM/ARwlTGs+jQkEpEDA3QS4rUYX3sT?=
 =?us-ascii?Q?asbjZsBPHdHoTO7iRUjEGEzkIi2UUzwfZaAgAlvmhnUpMw8GbsAf9WVyiUU4?=
 =?us-ascii?Q?lJRw4HKkGBdhSQZcYOFmxiCAMt1dUUOPuzPsJ3ZCEcbeoT+CPEEYliy/Tb+f?=
 =?us-ascii?Q?6HfHkJWBnPQ+EfP/oxKDXF5KTLdbIed68k0XjkqrI3atI8bQviyFeZ0yxhkm?=
 =?us-ascii?Q?IV37Xs5NO4DdUPB8xbQKnCltaxkJorHZWeI5wIGlTmvzYhFWERtoCSBRAa2Q?=
 =?us-ascii?Q?dMSuGcw/Zd1s0Ry/7FxMpQLSoi32/X8mHkgnl6wvow/i6GIny1bciF2mUvAV?=
 =?us-ascii?Q?4o/HrigqfhUOkvnMoFfJiyMZIViWL16J9iCrOCZCcFyTj+Irj2YD9kRyNviE?=
 =?us-ascii?Q?TsTXOC2me+K/OX4KPGI2xKins3owlNEl7/HgUcxTMRirrNmfk42M69dhJWqS?=
 =?us-ascii?Q?7h5iyU7mlE7r3EMyOBSHtDP+nTJUBVYTUlcn7z6yomllu8Q280oXIwhyRoBF?=
 =?us-ascii?Q?zlkCT8MOKIEfD8VpHeVbabgIlsMbo++Nxy7dKDMAp/7dFeiXksUaPJwtGjJa?=
 =?us-ascii?Q?mNGiJ7w/x7izEMqrc/3FHBVA3TX+aZ+z6OCJyXMYXAvHKSq31GB/er3JtuZn?=
 =?us-ascii?Q?q6yLgG5CT8cOuhlaHgwjNtE3RBdmdDSe8WG2Qz7ttvvMvNvt84op9YruqxbA?=
 =?us-ascii?Q?B/iDDiAaNgJ7NY1z1fs17bc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wH1LnFw3p+46QFmV0hotTqf6VPK4CqxX2HyI0HelRTWpYM6HzlLa1p0gy/Ph?=
 =?us-ascii?Q?D/rRxd1+S2awglH3myAvOCwX7HU4RDBxxEKVbzHH5j5lca1QxmsNfpd4J87m?=
 =?us-ascii?Q?rGKC3v/rfn+dydUpVaPy1sYNAUhueydQQzirId9f7ZVCZbgMjZsdxfm6IBwg?=
 =?us-ascii?Q?fHqJ7HFXjqXTeIwDgJHvlOrYGtD4ZciOguciAD+Ay+lWv6AiQlbv78bmEw2n?=
 =?us-ascii?Q?GLwBwxVsGWE7njGrZUtVw2mmMg6Jr8FcJ/TqoG6p61L/M1QJqlFqGqx7I6mp?=
 =?us-ascii?Q?/998WS2FCzB8cegoM+zJXj6uDuDcapfF0OdmMzG7cyHAbS+XJC31vKf04dh7?=
 =?us-ascii?Q?Q2YvUp7S1IjHUlsw21edMQNEzpR5UdrUvcWq1hW9WwI8HIrX5dxik/B+5FD4?=
 =?us-ascii?Q?bQBjgQvH+aYWrv8/D8HZFyi6FYuej/g6qCtDbweZBt2kKWOZp7+LM4S190Kg?=
 =?us-ascii?Q?dC1eTmSdO2u9b2+i9Kk4EjTRByJsEaKQ28lTngOzf876X7k4MJkERORMqyQK?=
 =?us-ascii?Q?lQZXj+7jlqm+UY7L7f56QpnsCavWH6cAUFVQ4ot/bMLURzGgxp6z0nx73pVQ?=
 =?us-ascii?Q?vw8CwJhbb4f7UJFnGBVTTiWPayRMThJjX1pIGeZfjOExsJcRry+oxket9Zjw?=
 =?us-ascii?Q?Cm3erWnd7Bki7RqEICvNp5u+ELIwtSdnS0mXc2o3DUBsCDGh0+MWcwH77Xdp?=
 =?us-ascii?Q?SWoPuzoOt8he+GdcYYOqB9sIvDuVt5Q1oJDPcTtNMXYlVgj42aRSjBotuhjS?=
 =?us-ascii?Q?yq+lwgKoj5uyWtqCdEblYiW3Cj/6CA1igcelAv/MgyEKCQEDq5kqW/SL77qU?=
 =?us-ascii?Q?OGTmv4QtBVXWdkzLqXfw9HWLLJ2+wbSDoo4PPB3aP/4q9sdA5vKhpkglWwB9?=
 =?us-ascii?Q?hMVctAVfPC44iA8lvxE9Cd/sTVofRDz0tn6IniSSlOHin1yIG4S55EN/QJ+u?=
 =?us-ascii?Q?u1zEC7ya2AUHKyDCOHH3/AImwQOZG/iF/3SK0+69L5XF9Ca1vw/6bvK6g2OQ?=
 =?us-ascii?Q?tlPRVTZtst2CVWpdFovAGgOKWqx+I3pb4grb3oezHQ7IWU5QLI6m4plDZbBl?=
 =?us-ascii?Q?6/45pv8a4F4j4n0j+c2Xkmxrs/zus0wahWVnNEJLFPkWX2ZfooC/neg3lsbn?=
 =?us-ascii?Q?lTt7z2LAxbdmWZpNyv9YCwwIA6/k0nLBLDXVEiS4oKrRMvIXVgb3IUxdlf6W?=
 =?us-ascii?Q?W1yo+FV/2tB7k9KpxzjzOaqKEAqo6afnTaMgorYtFSVMEyutjxLKoCtGYlHy?=
 =?us-ascii?Q?lV6yDfwt8e0q7yuQt7G6BWmhoyISChXNf1nvGVRRi14stsWKN4si7fQaHHwI?=
 =?us-ascii?Q?+BxhBi2TcWKYKvhXLR/2hIPaC7DtZC2lrksTpZWZ8PYa4CMCHDs0W8AMdcku?=
 =?us-ascii?Q?00uGAk8Cquq78UTyFE92SBRtcLj/FYnzZdGpKx2R1QeFeeNsuGyiTJL3gXLC?=
 =?us-ascii?Q?TIqx5YboAH85QxHHEh5b9/aer2JihtK0TzI1Z8GNHaVvlaNXJMF402/x+o1v?=
 =?us-ascii?Q?tWMWUqemXyH320zLNa+kCJJr4t8kECV2CvBClszqo4AVomuRTzxG4dGX8O/w?=
 =?us-ascii?Q?q2boKQ7BZelgn0ZsrK1prEmcyZPGxK8SJ9M3pEdOBC46r85qzH/rdlQToMqk?=
 =?us-ascii?Q?IYKBBgjEIGOqztUKllN1FXvRwNy+SdkjYSeCNT5fzG+Wmt6xFuRgg9Tpyh6G?=
 =?us-ascii?Q?OZR6525/JHkNZTnF3g8iKqYOYJavvHdEOUKtJ/C2h/iztqA7VJ0AyOqBMnhO?=
 =?us-ascii?Q?WQpIPPCS6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f387e7-2b1e-48f1-0c5b-08de589e11ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:35:06.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONvwpESdmyNLwItwBI2JNBtQjXPgtFE+miplUkvQmPEjWigWvTkq1+PjgdsZQ3OYfle4AO9jWVmAfYoMulWe4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
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
	TAGGED_FROM(0.00)[bounces-251756-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E074D50817
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. To support AF_XDP zero-copy mode, two
new types will be added in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 136 ++++++++++++----------
 1 file changed, 74 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2d486a62c178..1c3fbb6443bd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,9 +1023,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				if (bdp->cbd_bufaddr &&
 				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 					dma_unmap_single(&fep->pdev->dev,
@@ -1033,19 +1037,22 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
-
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
-			}
+				break;
+			default:
+				break;
+			};
 
 			txq->tx_buf[i].buf_p = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1509,39 +1516,69 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+						 frame_len, DMA_TO_DEVICE);
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1561,11 +1598,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1574,30 +1607,6 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
@@ -1621,6 +1630,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3414,6 +3425,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3437,20 +3449,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


