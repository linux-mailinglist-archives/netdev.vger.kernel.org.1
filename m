Return-Path: <netdev+bounces-296877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NkSINneIJ2qEygIAu9opvQ
	(envelope-from <netdev+bounces-296877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:28:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4EF65C0B9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:28:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=u38V00pY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296877-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296877-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F1D930A32F0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 03:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41C367F22;
	Tue,  9 Jun 2026 03:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF933367B86;
	Tue,  9 Jun 2026 03:26:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975616; cv=fail; b=bDnuV/jcr1UM1jxoikXrAShQsXgUlTVkRHQVQkQ8R8bDUq47CvSbYRgWb1YO7myhSBCtVJq4PKiaaTJKf1g8tizCrzwPjsyrjYg2SX9ycPuhCaPpddbE9Wjpcnhdmm/TJ6oMU+UjKhp41eaCU3zPHIC3Js3ytHzE7gksWnOAsrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975616; c=relaxed/simple;
	bh=s/7KQT+ll0owEDsLB1eMkaXfhdELOMvy/LFWK/A+nSA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eZkbsMPJ5VjitSmQxKh3Pf/7kQ5EqwMM+vrZj+lh+rmMaESE99CRuvStND9JEB0rR6kFCo1f2Xqu2haIks7zUJR7s75EKPDXqJ8Av5ZYlgdOhOtmNPkgDRK8pz815zCW6kgAlncbZxScv6LxWSXKSQZ37Lu33exN30hdBaoMFQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=u38V00pY; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3tdxf/uwbwoUvQf+HgNB8opF4OKqtJKW+OJjaXZ7s5+MJeLa1X9woeQDmkxekO1rK7T6F1ra5706eMrOUOLnYHs3BpZTdcW4NvVvTddPnnbhd5dl8zpj+DUTkd1jGluh3BLdgqMvEANCTPvHfXB6EzYF3J/iUDa6zh1dNRlzHFYuN1klATy1Bx7erOxhbL53hMGYQl3yIJauOmmhNEv7koyA93uHpq0SKGsiallh4HqKISpJw04FiJE3GOVYfH/3DZkDyAGIRfQbqvo45k5AWbstGUkRun09bG+wAWLm7BOcAU37/Bjmx5uarCV47XGUrDQmkGxxnuQ0vI//q6WmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7+1Ifb/yk/Q+Vv2B+gcY3f4zNLrT1QBQ8JWHf+4xiE=;
 b=WCNrBgLKT310v3HMxqHJ0vq5JfttI0eJtBcVZj35UOANYFZ0J67TcLaSAeRhpXvKO0YKPlkPwkG05tH+1ZHhmrnxIV8+Jcqg9X1jtAAIq+sE/tzfkgP3e4ZhVef6hED1qF9OOTdAJ44tdrlGLliiwmZwzDfMVjSnNI6p+MuoyPMPeQqZlGZ1tpZO9ahzF68OFwzpZxv+Oas0sKi4QJeyLNJzup2XygYKX0hWHw7twpJ0PPt6O82mUlkbldzduL6Wk5Qz/IDCq/78nvvGtUjIsMNfOkXGQn2oAdDKL/arKoJAPpK72Krf+8bxLA5p5z8cw7rCMEhuF+k71oCNbF7bTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7+1Ifb/yk/Q+Vv2B+gcY3f4zNLrT1QBQ8JWHf+4xiE=;
 b=u38V00pYS49GbWFuzsKoWWM//ZGF1VyrTJU0+7q5h6Fhp59gs3Hhp6fV8K9tmRMEh0eFW98rtSMgsPNMtKuUDVlA4vrwosZIQg3s6lrYpGmm5/dt8Jd2lAK+QiG7SDMXADopkJnckAhf7YgBah06sEmvmBbshzcUM1zbTRKv50fEDoIHYu4OoWWwu4TKdOnoO26QLgjzjZqSG3yZxp5+MsbeV56OqdBVu2xENUEd0H1YNTZO265X1WahFaUP6Ab4muWQRHKKdJ/VVATCAJzSQPCtSNlxOTibpBYx/9SGX4rA8jT0Qpo7+5EEClsXZu2SFuGMf9xMtU//aoRcy9alkw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:26:51 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:26:51 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 0/9] net: dsa: netc: add bridge mode support
Date: Tue,  9 Jun 2026 11:29:46 +0800
Message-Id: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: c85ae239-1e7c-46d0-bdd3-08dec5d6f227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cPSGW+GmgV/LwHUWHjXbtJCJLYN0o2AipS0l6oWG6Wvj8FQDSJNz8yfBZmewKy6OuncoxBgDyeQX4Gu94Imy9uBB1VRouHNOPks6wPlyzz1d1gu6leoRl3JpnSofYlysz7s8gAqVdGiePqFuhCgWEAe+fR1AfJ5XibdUQPXCufg4XIsCSUHYRLnIXKma/OdQqSySuURlYW+G1Xp4hgPYF64zofOyffctm4oh0xH2SFkEi76R18dUfiki4Gukz2ptQXnBQp1b6gz9NmfXd7K+zgL7xnpFsOsZwMLwP0AnYe4s/XcmqNufuv3fDbameidEFWh/DUt4NwrEZn8PkSnKX371DYRAjul/4szJLVmxKtbhDx2ex2nOm2IdSDVwaXJ5WgaOed9P2LY47hNUOS8Er9HmU3R6XpmBgb2jj3ZFvBWuGYsakMy7m43JdSU4xUSXFNKojtZK+pEBWb2t6vf2dV77a3GkA9lxlkV2erDTwEgZAgzjjciI4FoTLOb1TGh+EiDbY7+mZ2DhO8BYdFrq/xNOG5q8nh5JPSAAKpiiAZTR4Wfb2/XGjeF6oDqvmGUGzozQi6Hyv37cvacTn8zZHGxBWyH7g/Fgof3P4jf7cjaCuH5sZaZs+R6onmDgJnujawF0THpjt5HHGaz34Kw/T3TXTlbr24uj0iNhX79AGjHJLZz+UlbwQ+qIeUA9XSXH5cSla92JyzOQt/NtRdDoHZKTcGaMOiC+UNN1HMFlV77XIO0VzF5eIugX5T7TI37H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mX/iOq48/3ze75JoSV07tJKlPpM3k62qGncDuLo6dfQS9hpmBc0rdgAolDoq?=
 =?us-ascii?Q?VRD2Oml+GAWwXkJ7Dl7H9Ig5mpm++drtj8rtwtidU93d6PiFWc/ZHLHxWHjj?=
 =?us-ascii?Q?OvEIPB4nNNwVvhOM2+VFTJZgWN8yA6m0ENSazo4Ko0Oh1t2/+vfTnMLGs04D?=
 =?us-ascii?Q?V55+4uykb76ENoe8Ru3oo09RjyAUzVE0FtXC+yctJVZIhobXHlO0LvEr5gwd?=
 =?us-ascii?Q?TFT6Z/H55phQMb7nT67KIYh6KtDnI5Itju6XXz2WWRiDc9k0HO6pMbQ23i4y?=
 =?us-ascii?Q?iGqfOJKxtAWYkaydU+yE0MUufonJ/xuEdhLO80XiBYYGj7KS3gLa9atMY7Ez?=
 =?us-ascii?Q?LRI8vSD+l/pkMZvSQnSaicVgSzcqCsl6O4HCQJqBE+r7w/hXn5F2GUkJE77L?=
 =?us-ascii?Q?eUPiJADTYxXwSdvM9VSrgnR1xrUNUKQj7kYCd+REwbztNOMWlL/M+jOmsEhZ?=
 =?us-ascii?Q?zVgogZpjSl2Ueg0ZQlwbdlqHejiW3y8v6CNZmSKGRnRfd2Bdf1pXMqOQv5q1?=
 =?us-ascii?Q?1WYr8rB1jZZHHDBtGRgc2iaHYbQGfAt1PTr7BhEs3xPGmIGwqz1EEirjVePZ?=
 =?us-ascii?Q?UitxLe4XCsjDJkK6LxlAUJCS/TnB99nhSuOEUwR9QNh8Y/QSEHpngvtLL+ng?=
 =?us-ascii?Q?Yyb6tbsom61ckFyF9k6DK55hkA1TWx3VDQVBsng8/WsdQhkNH3g4+kBSD+bW?=
 =?us-ascii?Q?bQPbqpSkhfkdGww8Z2p3DZmR1ugEJFuq4FctWw6Py+22yecBELIBLfdHUbvA?=
 =?us-ascii?Q?qN/ip/N7uhNANbp0N+rgk4FayFphKG8vFp60kou7AgyJvFrNpMXWbzR+xIZY?=
 =?us-ascii?Q?8i55c3RfH7wxFs8+PxBQVV4zBI0Ou7ohzFYwjIPXF185D1AxI8OYYIWqyJjv?=
 =?us-ascii?Q?KNxWEb8QM4TC+2dYqD9fx/qq0Q9YZiCRLIHTsvZVUM2JTYl7yAe/Ojx/idan?=
 =?us-ascii?Q?/JFOZ3xUJlVdp+CZ4GISpHCFgMTuf/qfP+/VtI/NtNLE2T7zDvVmannwqbr5?=
 =?us-ascii?Q?W9T1gv8SPthwJvFw5/siu0zLdHYcpN6HeBdtwaRx705zWbM9QmJ7nL5kbK7u?=
 =?us-ascii?Q?q+Iq6wlSH+iNOpQoOi9cUSWuRbUILqhIGsePt0vGQzxoHFZwaJPWxNwD2OdB?=
 =?us-ascii?Q?vs2qsPVQ8fmoOjyzbf0SAEnremMo9vl0tAxLXlisbgPgkpLDs++r4B5Lhlg2?=
 =?us-ascii?Q?zmmewRrkExVOKLLYX3p3RldWx5jEI/3gvTXQ2pzwEm0BzsDm7AI9In3aEHDi?=
 =?us-ascii?Q?Z112nL5e2KclTUG6i/e1tijdo5wGAGAFBkwxwZupGEWD3AKpPAEwckAKT8Bk?=
 =?us-ascii?Q?kQR7j6HrTaF1cmVb7tXsqKl9MfHbDCMdS0k3SXjfJrLdgpSjkqB1Vu0BwkFO?=
 =?us-ascii?Q?srDkLF8Xz+ABRsh2p/sj8iO4n4vR4b3isfDPcHBdOZGz7l/8zGZ/uCWqtZTT?=
 =?us-ascii?Q?R6s8dPa+GxzHogvgrTmwvH7BShWGc+vxQdNGN31qBbN4YaneCw+9XuD3bPyB?=
 =?us-ascii?Q?1iR8O9dzCEhTVTcwJhY8A15lGuaolA9fX3QAMwU/PNgd/IhnodQMIeGmzsV7?=
 =?us-ascii?Q?1fkiF72di36ZHU4lJNh36nWFOeLjj6iSY1e56aL6g9xBSrBonumWtlVdSw/r?=
 =?us-ascii?Q?KiCXQIZ1gIHY9n8j+cdZwEPYLc/MaOBcPV3X9UZSjQ0BzfFZE1SIpKpUEXxM?=
 =?us-ascii?Q?dlc6PNM3vTxpDttGZYyy5rNmyY08VyeBm37g114L9lElt0QZjgzBjSUri+F/?=
 =?us-ascii?Q?xuDlxj5h9YyWzlzbv0yQUhiBJ2D029aDtWUPgJk9Qvtz3acw8Yoq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ae239-1e7c-46d0-bdd3-08dec5d6f227
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:26:51.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT4OxKCHZDYl0LH6oklTG5F9JVt3uMWD3Z+aHUUVbOibwBsOvnNn2CMRvtl0z9uzuzrYLR0awBU73h4TmsJWmLJd2wQ0O8yv45F7ZqPScOG5mDWmdFpxmkmVtWv84P92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296877-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B4EF65C0B9

From: Wei Fang <wei.fang@nxp.com>

This series adds bridge mode support to the NETC DSA switch driver,
covering both VLAN-aware and VLAN-unaware operation.

The NETC switch manages forwarding through a set of hardware tables
accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
treatment table (ETT), and egress count table (ECT). The series extends
the NTMP layer with the operations required for bridging, then builds the
DSA bridge callbacks on top.

Since all switch ports share the VFT, so only one VLAN-aware bridge is
supported.

FDB aging is managed in software. A periodic delayed work sweeps the
table using the hardware activity element mechanism, with a default aging
time of 300 seconds matching the IEEE 802.1Q standard. Per-port entries
are also flushed immediately on bridge leave and link-down events.

---
v4:
1. Set ect_eid before calling netc_update_ett_entry() in
   netc_port_update_vlan_egress_rule()
2. Improve netc_vlan_unaware_pvid(), use "struct dsa_bridge *bridge" as
   its parameter
3. Add comments in netc_port_vlan_filtering() and
   netc_port_bridge_leave()
4. Add vid check in netc_port_vlan_del()
v3 link: https://lore.kernel.org/imx/20260605014808.686024-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260602072313.3162120-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260527100217.794987-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  net: enetc: add interfaces to manage dynamic FDB entries
  net: enetc: add "Update" and "Delete" operations to VLAN filter table
  net: enetc: add interfaces to manage egress treatment table
  net: enetc: add "Update" operation to the egress count table
  net: dsa: netc: initialize the group bitmap of ETT and ECT
  net: enetc: add helpers to set/clear table bitmap
  net: dsa: netc: add VLAN filter table and egress treatment management
  net: dsa: netc: add bridge mode support
  net: dsa: netc: implement dynamic FDB entry ageing

 drivers/net/dsa/netc/netc_main.c              | 965 +++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h            |  33 +
 drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 440 +++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  18 +-
 include/linux/fsl/ntmp.h                      |  55 +
 6 files changed, 1495 insertions(+), 22 deletions(-)

-- 
2.34.1


