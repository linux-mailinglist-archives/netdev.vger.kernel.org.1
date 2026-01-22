Return-Path: <netdev+bounces-252284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GYQOKcGcmlgagAAu9opvQ
	(envelope-from <netdev+bounces-252284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C065CFE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30A608C223D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6EC43D51F;
	Thu, 22 Jan 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ID9NlobN"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46543C059;
	Thu, 22 Jan 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079460; cv=fail; b=m/aRUgdNI938QEDSyH3A85wcGdKdq69yEBbY0erlWazKvr1mHx376+BVCuHf3ZX1GB5CoM61NvY23d0rM9oSPH/SBcUiVo86S3DbI8lmrwOwJ3HVDawhx41cte0/iNlBiYuHKOaJwmh2ibLlG5LdYW9EHToGF3cSMGi8RWXKUSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079460; c=relaxed/simple;
	bh=PF3MxbY2BII5HS3KV7ybjKb8Xs7fWwFU8YjQIPE/93w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nw56APdRaXxYVG3FE9d9EJtMprCR45fuyd1hxLAoKXxfuMjMiscwz9IYgFMdYE3dsc4Kfe/encgr7aqQjlefZp2xfYC7kqS/ilHIeBDEgzwpVVuH2sCsUdxP2U1QuegoZZsATj4/aJ9VAB5fjaNKQJOxbxNsAXSBMCft3aW7ZrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ID9NlobN; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIUoWhAzmaF/vA5Q9iqBVKJF4UYDnqE1+2teNnJrwDyWxJcoCzMd2a7CRcLVrjS8QkJS1j0a+56YnnbUCU6QMQXuCo8NHUCCxBM6clsi9gGssBQhsW4WN9lsX5iit2Y8BEGpNiigJ1aNdKgMsY/E1c2jKZzIWj08GSYl2Gvp9eVORG90BJfMX2kSGFiiKc3q3byOvqbGk4RtdwtnG98ha2oWsmkfmJ3W8268o4YMlmW9LxyHAMZVhRPhk4kKtwHmSd1r+C8ZPJB5oTAfLGzfVSF64zwd4sN5n3xXUy9gls1tzlyYB+PunJigG96ZKfWzE7hE+pGruAzW4LYvP2HG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t4kI/6aRFvkhEnJNKIeFR+2yioDgPwzLEqshDLxR64=;
 b=vNaMEqcWfidSL/6BRfguFRoYKj5sorHByT41KgkGKcVaMz81Q8aL6efa+bTRXF9mDcHhrBpjU4HakFGN+PwXDlgojkP8Zm0Jl79YyM2iGmrA6ejAJjidI4mkNGR3RWESNfNRcc3J61GXg+w2549x9t+XMx1eG3jJUnket9BkQQZ5fPDtpXGSmecEOazgfYTNEGWj9nGp63Jq6GBqq0nAiQJAGln2xPwrtvtEouAmqY+IO6ITLZt6CSFA9ROw/0YQHwPTXQpx4xxgw8WYb32WrM82zxHZFCISbIh4MzeHPh8brxtdYVjCdx2TfGWJ01XpMRSNU2Z0zqlOdctDnpw0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t4kI/6aRFvkhEnJNKIeFR+2yioDgPwzLEqshDLxR64=;
 b=ID9NlobNjG5AzWJdcrul9vtox8a4sZty28AQazqJ4AAq5+wWu/mmNNOh/2MlgdjxVr0h847lqQmOrv38RPOPhqtnoeRe/t7PR7cU1nX8wJruCkWV62OP/MWiYNnBME6fQjugaGwiGSUNIlJKTYtBFDV6nC+Tnn34l8rfZIkNhza7F0oRDqFuqV7UKxbgYeFjgvp+FSRhAe7TYsEwwNXrn5eEUjJtX8MuT+VpSyJiLH9dzzTYp8ydWRdzEOTo5pLwQrrtHGERA7bEn9/AlLY8cHEh7ScFrMVIIF8EgRnfsyXhg2HBOBZXgctqtcXILG13D7iwEMpLvFyHtTOHCVML7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:26 +0000
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
Subject: [PATCH v2 net-next 11/15] net: dsa: sja1105: fill device tree with ethernet-pcs sub-devices under "regs" node
Date: Thu, 22 Jan 2026 12:56:50 +0200
Message-Id: <20260122105654.105600-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122105654.105600-1-vladimir.oltean@nxp.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: 515782fc-4447-41d0-d2b3-08de59a5072f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0xZaGxjQXVmNjFSd0l3UlJxSWdQTXR6cDdkcGpoWUZaZTl2VktvcmV4ZWt3?=
 =?utf-8?B?NXNncWQyRzlUZTR1NHZkRG9NbEI3VTMyNkxIQmlpV2w0aGtXWEpzWWh1UDRD?=
 =?utf-8?B?b2tabnYwaXo5dGZSanEvTnhtKzFjSXhjOXp6T1hYeUZ0NWJMSzdaZTZrQ3RI?=
 =?utf-8?B?NHYrZ0l4NUdTTnNxWVMrWEVKeDlVYXFwU2ZoS0JTZHNvRFFuNVJUK2JRajJS?=
 =?utf-8?B?RExyOWcrK1p1NVVaZnNLc0dlY2pQL1JZWDcwY1ZTQ2lUOHcxQjdBaC82bm01?=
 =?utf-8?B?OVBDbWtndGNaRFdvZnFMd1VzMDl0a042RHpjRnlpdTNMU25ia09zUjVMam14?=
 =?utf-8?B?bkNoUW9IazlxaGZqMnVkc1hYemhrSG8zd053K1VVdTc1ZFZLMjR4NkIvRWhP?=
 =?utf-8?B?ZUpjTVl4cUdOenp3ai9mdGR3Y3g1TTMycWNnNXBQRlJLM2Z2cVNnKzRuYVZl?=
 =?utf-8?B?SjR3NWZVY0tWY1BzZ1RUTDJRZk1rMDk0UWlNWU1HUTMrdGhjUjllTlRUeVVr?=
 =?utf-8?B?Q1kzbG1tMFAwVVpBSVlUWDBnVVV4bExUOGlPSnJFQkY3OC9mbHJtVWNKYzBH?=
 =?utf-8?B?ZllUZlFZZ2JpLyttYUkxVHZBanBEelNZWW55N0dHeWhiY1VGWmFhMithakxs?=
 =?utf-8?B?Y3JnYXJPMlA2akFNRGNoSzdEWVNhZHVLbVNPZ0RxS0t2NFVTY3hhZ3BlNVBq?=
 =?utf-8?B?REdML20yVmdOcDNIZGtuSytYdExuUTh4RTBqOTYzc3Z6Q0JzM1FxVklKSGJK?=
 =?utf-8?B?WXhOdU1zRXZzb29LMG5WQkZuT1hxcnFoOUZDSmxSOEtFdm94MFhENGJVaUps?=
 =?utf-8?B?V3Y4akVQZ20wYWRYSkE0emhtZ0lNSVdmN1llYzRIZVpsV0JlYjlhSVpRUEtm?=
 =?utf-8?B?VWdISHhNNXdZUlkwYW5HNitjOFc3Z2xoUzlZYVRHRXpjL2k3VGhKT01YZnNM?=
 =?utf-8?B?eXBhc2ZJVlZlWlUrL2cvS1JySlNLYkZ6QTc1SjRROHA4Y0lnRENGZHE2OGoy?=
 =?utf-8?B?S2ZWOXB1eTJyRGs2aVM0YXBHUWlvVldEVDcrbEI0U0ZCMEYzVTgzWGkrMjNs?=
 =?utf-8?B?SURDY3NCWHNNYmpFRytpMkJIYWR5MWx6QktBTENDL20vWHMreHlKelRhTHh1?=
 =?utf-8?B?STJRMGhFc1BEK3lPZWt6Y2gzNFZqZjFmTEtZaWRrNUhrSisvN3NmeVlLaWVU?=
 =?utf-8?B?WC9jc0NkNjlaUGJ4NzZiYU01ZFNoWnprN29CWUZFc2hpYXNPaWVncUwrV1Q5?=
 =?utf-8?B?a0Z4NU5TUmZIb09GdlpPemxCa241bEJTOXNRUHl0WUJxVWpJSDhkcGZNK3pk?=
 =?utf-8?B?SE9rYkxmclFBb0M3cGI2WmN2ZkI1YlBJVHNkdHZUOTdEcUZUSFlPYUVwSGI3?=
 =?utf-8?B?ZGRyOXNwT0lRRzF6VHE3Y2pxZC94TGtIVjNKbVQydm83NXBsaHYwRDhGditz?=
 =?utf-8?B?S05EUGQ3K1R6NUtMdFJiUndKblNWSGJLV2J1aE9aL1pOSkllVEZvU3FoK1I4?=
 =?utf-8?B?Z3dPaFZwbHBKa0ZtSHdBb3h4bk15T1RvbWRGYmpKZWVVZGFDSVh0UElmcmhG?=
 =?utf-8?B?alVRZFRpMWpTVzFhMmY1NTE4cHMxWFNWMzZ3bDJkZGxIVXY5K2lpYTB1QzVt?=
 =?utf-8?B?S3RqNnVLZkc1YTI5UGZJUWdhdEpIUllhUE9EZHo4V1Q0bDdEUlczSXZQWTdo?=
 =?utf-8?B?blNmTnN0OE5aYS9tODk2WkpZRzhXRUxsWFFadjVMTTQ1R2VUa29kaHRxYnN2?=
 =?utf-8?B?Skx6cjRkcUJUVnNWL3k0VDZ6dHVVdG11a0YveHhJT0sva05xcHV5MzRzSURQ?=
 =?utf-8?B?bjN3VCtHdjdQTmIxWEpvRnAyNVRuZ1piOHBkWGZWVDVwaXM4QlBJVFNQLzUy?=
 =?utf-8?B?Q1F2ZWJ2Um5mWE1IVkc5VUo4cDhKREhXeXp3VGRxSjMycnRGMXZBRkRXWTF6?=
 =?utf-8?B?ZlNVdzRuaW4yZHptUnZkTVFaM25LaVdwZFdPTENxckNEZXpSLzlNUitHcTBP?=
 =?utf-8?B?Z1pQSlJCVzBIKzhsS1NvWlUxOWpIM0Nrbjc5YkI5bHBjdjhKaXo2S1hNWUpC?=
 =?utf-8?B?NUlqTkNacHhNTUhFaGxvVGV4M2RXRDRENFN6RkQzRkV5dTZzSFUrelpXcDYx?=
 =?utf-8?B?TkZJM3N0bVpGQy8vdHZrM0xLa2YvRzJuRkg5VlhRUGJkdTIzSGZ3bHBMR1Iz?=
 =?utf-8?Q?Y3ikaL+njPRN43Le8QUmUBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uys4QkxvbW5JdUEvdlpIdXlCNlFjU2hBeGhQNUwzZmZZTER6MGc2SjdqNGtB?=
 =?utf-8?B?NkI5MmgyNFhzNlFYUE1laU5DTTlIc1N5TzZZQTQ0djBQWDQxUHN1ZDQycVpj?=
 =?utf-8?B?bjZtQ09salFoS3V2VklMSkdhbi96TExrdlUzbndlNmtwQnJBeHVteHcrZWk1?=
 =?utf-8?B?WG9DaFkwaC82UmxUZWM1SEhtRUFUbFE1RlU1UWlvSXlRVlcrZ1d0ZkVRZzJv?=
 =?utf-8?B?dEVWbU5INWlnd1dPK0FJODB4YlhJNlpmRDFuMHhNUkNweFI5ZmZjMlEvOXBi?=
 =?utf-8?B?dGRCeU5pbEhONWRNZ0tCVmtxbVlWaUV1VEdlMFExUUNxTkFBWnhlektLWUZN?=
 =?utf-8?B?R0lyLzIzVzU3WnJmcGZKTW9mQ2h2OEZEa3NzMlBqRUI3eGhPTnhNSi9QaHVq?=
 =?utf-8?B?Z3hpN04vUUJRUUVidzMvK2FxMDl6Yk13U29McnhnOHpDeS9HSEU4S2syQm53?=
 =?utf-8?B?ZERtTGwxZVg3bURJSGtJNmM5amRPOUxvczAybGQ5OGtJUjNwQUpXai9FSW1R?=
 =?utf-8?B?anlTek5VdHdyK0ZxVmVINjhobDBzbzZRUUlKak9uTXZTK2lnVUJVTlpDa1ho?=
 =?utf-8?B?NU9vS0RyeDZLVHdnVnNGY0xzSllEdWNsUlIvQXR0TUNBNXkzbG1JK0t5R2E3?=
 =?utf-8?B?S1liZUw3Uy84cHdIQUxDK0RtaGZTNDN1QjlTZTc1dC9CQ09MTDVDRHhiSnVl?=
 =?utf-8?B?T2taL0lhaGY1WTIxbXhaNytvRyt6UnRVRVdDMnl3OXlJN2xzOEdkYnNHMjBR?=
 =?utf-8?B?TU9od01TeEwya2ZGV01nczYwT29aZXhrd2ZSVDRvWUM3U2hCNVBQd0kwWTA1?=
 =?utf-8?B?R2F4K3o3d0t1Nys2N2g5YVN3dGxmVWhkMHlzRnhwZURVN0lSVGplY2tvRzNx?=
 =?utf-8?B?dmQ4MEFVT1BrbEc2K25uQStHb2VNU0xJQytpZlFJOURCeGx5bk9DS2w3QnBR?=
 =?utf-8?B?NDVRL1pZUnZIZnhmZDBCeWl6bE01aHI0dFRxS04wanNrYjQxZ3czb0c4ZVcz?=
 =?utf-8?B?MFE0Q1dqUm1uNjgydjZiT21lRnpodzRLd2lxYmhuRUVLc2llWDdEVERYZGI3?=
 =?utf-8?B?aEZVM0ZjMFJwd0UxWEhZRFBLb0huT1VpQWYwemFPMGk4cCtCakxCbHVhU01C?=
 =?utf-8?B?L1JvTUd0ZGVNY0xMVWRiLzNMK3NyUHIwUlhJUG5UZ3Bma3p1Wm1XcllueFUy?=
 =?utf-8?B?QXhYd1FmWjlPMkdwQVBzS3pwYUMxTGpJM3VqZ3d6eHo5Z0RqbW9FUnhESjRK?=
 =?utf-8?B?aklOZHRRenBJQXRtU0RxSmFnaXFGc2V2Tm5mUTVqaEs2SGhwK3habmFhZnVq?=
 =?utf-8?B?SFZnN3VBS3dpMFVaYU1DVEp3U1ZZOWtUNXpkdEpRRVg1akJuQTQ5ZlZkOFVS?=
 =?utf-8?B?dHg3RXJFTUliVVJTaUN4YkZ1TUNOUGN5YUI5eXMwRU90d1BGOENSZmtYVlMr?=
 =?utf-8?B?Rk1vSnFocFgxd2NKNmpIUnFPaktVY1lMTGdram9KMVFQVUYrTE1FdkxHYmtj?=
 =?utf-8?B?dVdVY0p0Y29IM205dDk1STJ0RHlLNnBrRzlUS05tRnpjQmlRQzFvZzR2dlpO?=
 =?utf-8?B?MWFqRkd5dGx2NlV4T0diQWFVbWE2cjlqeE1SbDNwdUdHTmZvN0FpZ1dQQWJx?=
 =?utf-8?B?aE1URVRCMXF4RW9vNFpzaTdHZHRzTnVqenA0NE9UdHByaFdRQ1pERmNpTlJH?=
 =?utf-8?B?MFM4RlhsRjFBQWhhSFVmMVU3NDRMcHlFQlpOT2VKdXJWMU5RVVU4REhmWnNV?=
 =?utf-8?B?S08yeVlpVVh0OXUxTDlvbjgrajZ4M2J4UDg2Z3ZQZzlGamJsWVJmdGZQY0dW?=
 =?utf-8?B?K1FqMXBSTlJINUpIeXp3end5M2UwNVhMaS9kaG1KazFXd094T1F4WlpQRDBr?=
 =?utf-8?B?blJ5ckpZSm9SaC9FYTl4ZXY1dXBSblljY2dySTh3TTNCVDlwMUxpbVExT0Q2?=
 =?utf-8?B?dXB1SUNrM25EdllrWDlOWC9UM01GT3ZhcFU2cTFFdk80R1ZLZkhIZ014RmRW?=
 =?utf-8?B?QUtzSlVybWF4THhQOWVvSnVjbzRTREtCLzBoUWJPa3hlRUJuV3ROMVJXa2ds?=
 =?utf-8?B?ZSs3Z1duTmM3SFRMWmhlQm9UNDhUM3VhL1loY0srRFp1cyt4dlBkV0t3dGty?=
 =?utf-8?B?RVVpY3pKRkY5cEUzVmFqbnhrejcyRFZuTVZQNS9SYWhnMGxpZHZWVk5SVUVT?=
 =?utf-8?B?WFU5dWlIeTYzYnN4WTlobmQvbVFWMWd4UERjZWdLclhVd29oL2J6QXFQclpv?=
 =?utf-8?B?c0dqbVBPRWh5WDlONStETWNjSTNMejN3TlJISW5UK0d1OXgvTkJxTjNSWmpp?=
 =?utf-8?B?L1ZhWXQ2USsySDN0VTRsQzZhS01vaVNTNmdtTHVwc0lzdHVBaC9GUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515782fc-4447-41d0-d2b3-08de59a5072f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:26.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10kDha2eH5fQRZsp6hUSJsKixHNmqAW8BAfswFUvWCuMdH94Q+4J7yeEumVSuYa0VINAy6dEFJYFrHBaR9sOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252284-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,bootlin.com:email,intel.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D6C065CFE
X-Rspamd-Action: no action

The code in sja1105_mdio.c does the same thing as the one added by Serge
Semin in drivers/net/pcs/pcs-xpcs-plat.c (implements a virtual MDIO bus,
backed by either a direct or an indirect register access method), except
the latter is generic after the conversion to regmap.

The SJA1105 binding now has a way of specifying sub-devices in the
switch's address space, using the 'regs' container node. However,
specifying the XPCS in the device tree is optional, yet it is a critical
component for the SGMII protocol (which is supported as of today). So we
must continue to instantiate the pcs-xpcs-plat.c driver somehow.

I've tried various ways of using that driver while avoiding major DT
bindings changes for this switch, like fwnode_create_software_node() and
custom platform data. Platform data was ugly and software nodes didn't
work at all, for reasons explained here:
https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/

I have to give huge credits to Andy Shevchenko, who after more than one
year remembered the discussion and referenced Hervé Codina's work on PCI
DT overlays, as well as a presentation from Lizhi Hou and Rob Herring.

I think I found the compromise solution that allows me to make progress,
which is to create a dynamic OF changeset that attaches the PCS node to
the live device tree, if it wasn't described already in the DTS, or use
the one from the DTS if it's already there. With a proper OF node, the
xpcs-plat driver probes just fine.

There also exists a use case where the XPCS is manually described
in the device tree, and that is when the board author needs to describe
SGMII lane polarity inversion via 'rx-polarity' or 'tx-polarity'. In
that case, sja1105_fill_device_tree() detects which PCS nodes are
present and fills in default descriptions only for the rest.

Nobody probes these ethernet-pcs devices just yet, because the custom
bus code is missing. SGMII continues to be supported through the
sja1105_mdiobus_pcs_register() and sja1105_mdiobus_pcs_unregister() code
path.

Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- use devres for sja1105_fill_device_tree()
- fill correct default tx-polarity in ethernet-pcs node rather than
  expect XPCS driver to have SJA1105-specific correct default value
- drop cell_name from struct sja1105_pcs_resource after no longer making
  use of MFD
- rewrite of_child_node_exists() using of_node_full_name()
- print phys_addr_t using unsigned long long and %llx

 drivers/net/dsa/sja1105/Kconfig          |   1 +
 drivers/net/dsa/sja1105/sja1105.h        |  11 ++
 drivers/net/dsa/sja1105/sja1105_main.c   |   7 +
 drivers/net/dsa/sja1105/sja1105_spi.c    |  37 ++++-
 drivers/net/dsa/sja1105/sja1105_subdev.c | 190 +++++++++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_subdev.h |   1 +
 6 files changed, 246 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/Kconfig b/drivers/net/dsa/sja1105/Kconfig
index 1291bba3f3b6..55ce8f6a2758 100644
--- a/drivers/net/dsa/sja1105/Kconfig
+++ b/drivers/net/dsa/sja1105/Kconfig
@@ -7,6 +7,7 @@ tristate "NXP SJA1105 Ethernet switch family support"
 	select PCS_XPCS
 	select PACKING
 	select CRC32
+	select OF_DYNAMIC
 	help
 	  This is the driver for the NXP SJA1105 (5-port) and SJA1110 (10-port)
 	  automotive Ethernet switch family. These are managed over an SPI
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index cf718e7c2b7b..1b52beba62d4 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -113,6 +113,13 @@ enum sja1105_internal_phy_t {
 	SJA1105_PHY_BASE_T1,
 };
 
+struct sja1105_pcs_resource {
+	struct resource res;
+	int port;
+	u32 tx_polarity;
+	const char *compatible;
+};
+
 struct sja1105_info {
 	u64 device_id;
 	/* Needed for distinction between P and R, and between Q and S
@@ -165,6 +172,8 @@ struct sja1105_info {
 	bool supports_2500basex[SJA1105_MAX_NUM_PORTS];
 	enum sja1105_internal_phy_t internal_phy[SJA1105_MAX_NUM_PORTS];
 	const u64 port_speed[SJA1105_SPEED_MAX];
+	const struct sja1105_pcs_resource *pcs_resources;
+	size_t num_pcs_resources;
 };
 
 enum sja1105_key_type {
@@ -278,6 +287,8 @@ struct sja1105_private {
 	struct sja1105_cbs_entry *cbs;
 	struct mii_bus *mdio_pcs;
 	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
+	struct fwnode_handle *pcs_fwnode[SJA1105_MAX_NUM_PORTS];
+	struct of_changeset of_cs;
 	struct sja1105_ptp_data ptp_data;
 	struct sja1105_tas_data tas_data;
 };
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index d3fb42772071..84c0f7c676e2 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3330,6 +3330,13 @@ static int sja1105_probe(struct spi_device *spi)
 		return rc;
 	}
 
+	rc = devm_sja1105_fill_device_tree(ds);
+	if (rc) {
+		dev_err(ds->dev, "Failed to fill device tree: %pe\n",
+			ERR_PTR(rc));
+		return rc;
+	}
+
 	rc = devm_sja1105_add_subdevs(ds);
 	if (rc) {
 		dev_err(ds->dev, "Failed to create child devices: %pe\n",
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 20757e166b08..4d4da69b3c30 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: BSD-3-Clause
-/* Copyright 2016-2018 NXP
+/* Copyright 2016-2018, 2026 NXP
  * Copyright (c) 2018, Sensor-Technik Wiedemann GmbH
  * Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
  */
+#include <linux/phy/phy-common-props.h>
 #include <linux/spi/spi.h>
 #include <linux/packing.h>
 #include "sja1105.h"
@@ -619,6 +620,28 @@ static const struct sja1105_regs sja1110_regs = {
 		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR},
 };
 
+/* See port compatibility matrix in Documentation/networking/dsa/sja1105.rst */
+static const struct sja1105_pcs_resource sja1105rs_pcs_resources[] = {
+	{ DEFINE_RES_REG_NAMED(0x0, 0x800000, "direct"), 4,
+	  PHY_POL_INVERT, "nxp,sja1105-pcs"
+	},
+};
+
+static const struct sja1105_pcs_resource sja1110_pcs_resources[] = {
+	{ DEFINE_RES_REG_NAMED(0x705000, 0x1000, "indirect"), 1,
+	  PHY_POL_NORMAL, "nxp,sja1110-pcs"
+	},
+	{ DEFINE_RES_REG_NAMED(0x706000, 0x1000, "indirect"), 2,
+	  PHY_POL_NORMAL, "nxp,sja1110-pcs"
+	},
+	{ DEFINE_RES_REG_NAMED(0x707000, 0x1000, "indirect"), 3,
+	  PHY_POL_NORMAL, "nxp,sja1110-pcs"
+	},
+	{ DEFINE_RES_REG_NAMED(0x708000, 0x1000, "indirect"), 4,
+	  PHY_POL_NORMAL, "nxp,sja1110-pcs"
+	},
+};
+
 const struct sja1105_info sja1105e_info = {
 	.device_id		= SJA1105E_DEVICE_ID,
 	.part_no		= SJA1105ET_PART_NO,
@@ -782,6 +805,8 @@ const struct sja1105_info sja1105r_info = {
 	.supports_rmii		= {true, true, true, true, true},
 	.supports_rgmii		= {true, true, true, true, true},
 	.supports_sgmii		= {false, false, false, false, true},
+	.pcs_resources		= sja1105rs_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1105rs_pcs_resources),
 	.name			= "SJA1105R",
 };
 
@@ -818,6 +843,8 @@ const struct sja1105_info sja1105s_info = {
 	.supports_rmii		= {true, true, true, true, true},
 	.supports_rgmii		= {true, true, true, true, true},
 	.supports_sgmii		= {false, false, false, false, true},
+	.pcs_resources		= sja1105rs_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1105rs_pcs_resources),
 	.name			= "SJA1105S",
 };
 
@@ -869,6 +896,8 @@ const struct sja1105_info sja1110a_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_PHY_BASE_T1},
+	.pcs_resources		= sja1110_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources),
 	.name			= "SJA1110A",
 };
 
@@ -920,6 +949,8 @@ const struct sja1105_info sja1110b_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_NO_PHY},
+	.pcs_resources		= &sja1110_pcs_resources[2], /* ports 3 and 4 */
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources) - 2,
 	.name			= "SJA1110B",
 };
 
@@ -971,6 +1002,8 @@ const struct sja1105_info sja1110c_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_NO_PHY, SJA1105_NO_PHY,
 				   SJA1105_NO_PHY},
+	.pcs_resources		= &sja1110_pcs_resources[3], /* port 4 */
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources) - 3,
 	.name			= "SJA1110C",
 };
 
@@ -1022,5 +1055,7 @@ const struct sja1105_info sja1110d_info = {
 				   SJA1105_PHY_BASE_T1, SJA1105_PHY_BASE_T1,
 				   SJA1105_NO_PHY, SJA1105_NO_PHY,
 				   SJA1105_NO_PHY},
+	.pcs_resources		= sja1110_pcs_resources,
+	.num_pcs_resources	= ARRAY_SIZE(sja1110_pcs_resources),
 	.name			= "SJA1110D",
 };
diff --git a/drivers/net/dsa/sja1105/sja1105_subdev.c b/drivers/net/dsa/sja1105/sja1105_subdev.c
index 06957d44f084..085d77947dc3 100644
--- a/drivers/net/dsa/sja1105/sja1105_subdev.c
+++ b/drivers/net/dsa/sja1105/sja1105_subdev.c
@@ -152,3 +152,193 @@ int devm_sja1105_add_subdevs(struct dsa_switch *ds)
 
 	return 0;
 }
+
+static bool of_child_node_exists(struct device_node *np, const char *name)
+{
+	for_each_child_of_node_scoped(np, child)
+		if (!strcmp(of_node_full_name(child), name))
+			return true;
+
+	return false;
+}
+
+static int sja1105_create_pcs_nodes(struct sja1105_private *priv,
+				    struct device_node *regs_node)
+{
+	struct dsa_switch *ds = priv->ds;
+	struct device *dev = ds->dev;
+	struct device_node *pcs_node;
+	char node_name[32];
+	u32 reg_props[2];
+	int rc;
+
+	for (int i = 0; i < priv->info->num_pcs_resources; i++) {
+		const struct sja1105_pcs_resource *pcs_res;
+
+		pcs_res = &priv->info->pcs_resources[i];
+
+		/* phys_addr_t has variable size depending on the value of
+		 * CONFIG_PHYS_ADDR_T_64BIT, cast to the larger unsigned long
+		 * long type for printf.
+		 */
+		snprintf(node_name, sizeof(node_name), "ethernet-pcs@%llx",
+			 (unsigned long long)pcs_res->res.start);
+
+		if (of_child_node_exists(regs_node, node_name))
+			continue;
+
+		pcs_node = of_changeset_create_node(&priv->of_cs, regs_node,
+						    node_name);
+		if (!pcs_node) {
+			dev_err(dev, "Failed to create PCS node %s\n", node_name);
+			return -ENOMEM;
+		}
+
+		rc = of_changeset_add_prop_string(&priv->of_cs, pcs_node,
+						  "compatible",
+						  pcs_res->compatible);
+		if (rc) {
+			dev_err(dev, "Failed to add compatible property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		reg_props[0] = pcs_res->res.start;
+		reg_props[1] = resource_size(&pcs_res->res);
+		rc = of_changeset_add_prop_u32_array(&priv->of_cs, pcs_node,
+						     "reg", reg_props, 2);
+		if (rc) {
+			dev_err(dev, "Failed to add reg property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		rc = of_changeset_add_prop_string(&priv->of_cs, pcs_node,
+						  "reg-names",
+						  pcs_res->res.name);
+		if (rc) {
+			dev_err(dev, "Failed to add reg-names property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		rc = of_changeset_add_prop_u32(&priv->of_cs, pcs_node,
+					       "reg-io-width", 4);
+		if (rc) {
+			dev_err(dev, "Failed to add reg-io-width property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		/* The SJA1105 XPCS is integrated with a TX-inverting custom
+		 * PMA. We need to invert the polarity in the PCS to obtain a
+		 * non-inverted signal at the pins.
+		 */
+		rc = of_changeset_add_prop_u32(&priv->of_cs, pcs_node, "tx-polarity",
+					       pcs_res->tx_polarity);
+		if (rc) {
+			dev_err(dev, "Failed to add tx-polarity property to %s: %pe\n",
+				node_name, ERR_PTR(rc));
+			return rc;
+		}
+
+		dev_dbg(dev, "Created OF node %pOF\n", pcs_node);
+		priv->pcs_fwnode[pcs_res->port] = of_fwnode_handle(pcs_node);
+	}
+
+	return 0;
+}
+
+static struct device_node *sja1105_create_regs_node(struct sja1105_private *priv,
+						    struct device_node *switch_node)
+{
+	struct device *dev = priv->ds->dev;
+	struct device_node *regs_node;
+	int rc;
+
+	regs_node = of_changeset_create_node(&priv->of_cs, switch_node, "regs");
+	if (!regs_node) {
+		dev_err(dev, "Failed to create 'regs' device tree node\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rc = of_changeset_add_prop_u32(&priv->of_cs, regs_node, "#address-cells", 1);
+	if (rc) {
+		dev_err(dev, "Failed to add #address-cells property: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
+	rc = of_changeset_add_prop_u32(&priv->of_cs, regs_node, "#size-cells", 1);
+	if (rc) {
+		dev_err(dev, "Failed to add #size-cells property: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
+	return regs_node;
+}
+
+static void sja1105_restore_device_tree(void *data)
+{
+	struct sja1105_private *priv = data;
+	struct device *dev = priv->ds->dev;
+	int rc;
+
+	rc = of_changeset_revert(&priv->of_cs);
+	if (rc) {
+		dev_err(dev, "Failed to revert device tree changeset: %pe\n",
+			ERR_PTR(rc));
+	}
+
+	of_changeset_destroy(&priv->of_cs);
+}
+
+int devm_sja1105_fill_device_tree(struct dsa_switch *ds)
+{
+	struct device_node *switch_node, *regs_node;
+	struct sja1105_private *priv = ds->priv;
+	bool regs_node_created = false;
+	struct device *dev = ds->dev;
+	int rc;
+
+	if (!priv->info->num_pcs_resources)
+		return 0;
+
+	switch_node = dev_of_node(dev);
+	of_changeset_init(&priv->of_cs);
+
+	regs_node = of_get_child_by_name(switch_node, "regs");
+	if (!regs_node) {
+		regs_node = sja1105_create_regs_node(priv, switch_node);
+		if (IS_ERR(regs_node)) {
+			rc = PTR_ERR(regs_node);
+			goto out_destroy_changeset;
+		}
+
+		regs_node_created = true;
+		dev_dbg(dev, "Created OF node %pOF\n", regs_node);
+	}
+
+	rc = sja1105_create_pcs_nodes(priv, regs_node);
+	if (rc)
+		goto out_destroy_changeset;
+
+	rc = of_changeset_apply(&priv->of_cs);
+	if (rc) {
+		dev_err(dev, "Failed to apply device tree changeset: %pe\n",
+			ERR_PTR(rc));
+		goto out_destroy_changeset;
+	}
+
+	rc = devm_add_action_or_reset(dev, sja1105_restore_device_tree, priv);
+	goto out_put_regs_node;
+
+out_destroy_changeset:
+	of_changeset_destroy(&priv->of_cs);
+out_put_regs_node:
+	if (!regs_node_created)
+		of_node_put(regs_node);
+
+	return rc;
+}
diff --git a/drivers/net/dsa/sja1105/sja1105_subdev.h b/drivers/net/dsa/sja1105/sja1105_subdev.h
index 9b5a02401399..1507ff3c44d1 100644
--- a/drivers/net/dsa/sja1105/sja1105_subdev.h
+++ b/drivers/net/dsa/sja1105/sja1105_subdev.h
@@ -5,5 +5,6 @@
 #define _SJA1105_SUBDEV_H
 
 int devm_sja1105_add_subdevs(struct dsa_switch *ds);
+int devm_sja1105_fill_device_tree(struct dsa_switch *ds);
 
 #endif
-- 
2.34.1


