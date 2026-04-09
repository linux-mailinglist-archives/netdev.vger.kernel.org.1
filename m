Return-Path: <netdev+bounces-277069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCSoNrHY12n4TggAu9opvQ
	(envelope-from <netdev+bounces-277069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:49:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820713CDCB2
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE0AD3008995
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BD3E122A;
	Thu,  9 Apr 2026 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QBaXTQPT"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14437B40E;
	Thu,  9 Apr 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753391; cv=fail; b=gkoPQU35DAx1cgcaZemCfZ89eSVMt85kUHbNJwTtKwszCsnAnXWnqQKTe0umQmhsuY0cT7TPmw7CFkVFVqz89m2rJrf1r4ffrQAlOg+kZFmLGDCl4/kzShHTe4+R4E1cTKBZL7PFHmUAjNqHPKuH4Iu/opdJqMBcHSvbsP9ygLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753391; c=relaxed/simple;
	bh=f6uQ9hUGdRSYBqkGAKQgCRxAdQD23FWyRDZNjY5iI4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4heIgrzp3dQy+QULdA6lf9U+7t+AyiuCJKuFTkZyDW31SmTI0o6QNdw9mZlY7UQr9whcyO/w6BCmuQ5iBgy1YpxoHI3AnftmyqZlOXczN10h30quJ/CwJYz756+Zf57NFHW67CXJ6nMD9byQFysMb6N0lJKB50B4gl0aCsZux4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QBaXTQPT; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBEpLWoVKnD84wvEEksHW+CY7yrarKGpnbHN9wLqOT4bXpIdWbFFc2EIpjIcjXOWGBNbp5sYNuK07sMeHCc4ptStxNBcP+ywdDcEZ+1rTYIwKe3scMNkpKtgWLUxyxlmD98KrXoAkY74fOoBY0fQw1pX0dikXzmG57yThAHV+M7UpoaPKFuJWdxwCRNCyx4JN9hGmMGi6fYPzK1R8+mVDtOhFpeNYCf0FXsPxy9ZpBV6pCarhBgWLekW+KzZwLxhTLtrFerJRUepKJnqIoeNzuxmWFzxCs+W/49Mf2fZ/xMLBZ2qUHq3tvCv8k+BTmM/JXIqXyo+tfMR+a5nMTvXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MPz/Ds/m/pi4Erp8U/4iENSHTjV/2od/D+QL9LG2t8=;
 b=MCKgz+lDu2l7uKRLYmMEFteTOQJOXVCyN0kFjI4k3enBgqAuvK70uhatFuCWRvtRrtyy0KFAv7H41U/cQQQoiPPSvuHrJK48OxpQHaW7sdqQ8Bs696ngdVEiWK/+jyt+wbx26E9bxz1OKhPxcDNGAsklgyEHM7g5Jgjk7vbEXE3nywoJY+P/+TKk1Nl33On8Xq/QyqRPs71YFUXiJOd0I9/xujyGpJ9+XRUrmlON4Rimusv3sJWKUjxrLb2AzUYgmbGpdBlCuaekfinGVvaBTyxT/Ecdj1PR9fFC6G+wtbphd/Dc/ry+bx+t6CwOX/7UVVkAbFaDQOeD1ng/t0+CPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MPz/Ds/m/pi4Erp8U/4iENSHTjV/2od/D+QL9LG2t8=;
 b=QBaXTQPT8DO4I6xpJzAf9eqjicZHW4C++ThAAdp9zikzLRK9xs6FWmQh45b7E8cHgzjFxydUDNx6bucUvoxoYH2TTt2IN3vVvzJyDD85N46emCQfjjruUW3Kq9fuWHwZaRMJXyGiBSAYp8HmUvL4tYv3QxZ4O3H4nBvluAzeZ1wxcKXjOYbLnvLLr++yBxFMGt4INNniXfeyatVUHJCcFOBvYs0ZTcKj3JlcEJZhdDitqJMQd7NcoZxOXVrB/ioLTWK3aNHLWKcqCBwc8Tvx0b6MRZeRJDVG/b+OY0wkN/ZFWXqzd2cULbuHqz7/0UpiV2v+4E22lXEAWbXVWSQVtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0032.eurprd04.prod.outlook.com (2603:10a6:102:2bd::8)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 16:49:46 +0000
Received: from PAXSPRMB0032.eurprd04.prod.outlook.com
 ([fe80::901f:47ae:dfc9:2499]) by PAXSPRMB0032.eurprd04.prod.outlook.com
 ([fe80::901f:47ae:dfc9:2499%5]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 16:49:46 +0000
Date: Thu, 9 Apr 2026 19:49:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Frank Wunderlich <linux@fw-web.de>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC net PATCH v1] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes
 configuration
Message-ID: <20260409164942.wbmwtkpd5d5zibyy@skbuf>
References: <20260409133344.129620-1-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409133344.129620-1-linux@fw-web.de>
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To PAXSPRMB0032.eurprd04.prod.outlook.com
 (2603:10a6:102:2bd::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0032:EE_|AS8PR04MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecbdfa1-8eda-4e83-6d87-08de9658019e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ec13hwYI4yedeMVgel60oBlc8N6qmdgmxe5eOOioPIlwoZGRZIuGWzUZMdUOg1IwStfv4vkMpCPbIcFggWXA1XOb7MFlpXLK7hD2tsituKSLXE6p4yICzUIy5HzRMqiM9U3+p/K4eaJUr4e8BZWpJed0bTboybhihX/IIgb6iTzIlOSF6XaFtFuU0M93pqn1l9o3bu9XIstNnnR1D8lwTQDL/arcSLaK3NV6/BXDO5vmminit607cDRMe+xzSuQtFrtdyk0Bs55JXfuzojzRC0fesYjQlb+kMoIl783rVuRysptvEbX2xnC3Pj/G/9FDWvzJ86A9eCfnWZI91egXcCfcT37BOwvaNeMpytA4MD57b3y1DZDcEptUZmKCG+dyVyYqLfFutADCWAGldnSriXFj1t0u1e/Y8wBD+G4XF6boVl93TzbUutdUjsZ8BWP6v8wNTSwAL3+XvyuMRPjJYAONhIBDMRObRusdZwpFnvf2nc6OLWT8O7PqcJlmo3phGEc7n4rKlNbSERaCy2MbJllo0NhC+UHqF4ALuUibNlD35GG0Vn6M/mj6gEaJBiFDuFHF4QEUJUzRMrN/+xlQdT4dt3pKfAAGlR0OltRkTpUd8Ub7dzguaMLAGUZsBUO98TB6OX/87cFyKKnY6HB9S2mBl48ANPux2WbjuYhJDduODJleNO7M/9Sa6dPhpVi6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0032.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21oUlZpSzZ2SkVqd3U5clZ3SGFTN0phVmc1T3BFMXlUNHdZVXhjc1BvMkNv?=
 =?utf-8?B?eCtOQU9zYkNiQ1oxcDMzQys4RzBRQUk4OHIrZ2ZJeEYrZmIxK3BPcmVWN2RO?=
 =?utf-8?B?U3R2dHFjRkM0UmxhUFgwaWZWSHFSdU5QMURVTFBUaFozdmkvd0VlUmx6Rk1E?=
 =?utf-8?B?dm9vVmVPaUhqM0wxbzRVOC9pekY5a3U3RHpCMTdkVXBaamZRS2pWc2Q0dlBo?=
 =?utf-8?B?aWRId1VIZlB4Y2NjR3NEbms3TWNEbUtIb1YrVDY3cUYrQllWUGhEdkx1RjZJ?=
 =?utf-8?B?VCtrRU1CaFFkYzlHalJqcStlSUptRFY5MmlsMXE3SXNvdWd4UzNEcFBDcVdJ?=
 =?utf-8?B?ZWtjbHJCcXJsNzRDVDJNTnZrU1o5LzFEandMaGZMS1czbzRYelgwYlptWWd1?=
 =?utf-8?B?Q3ZhOG5iNEdieUhpNXBHSXBadFd0M3ZFRklmK3M5Q1FDak5acTNBR0V1bGxP?=
 =?utf-8?B?NkFzRnQxaVJLY0VXWXdWWkxjV1oyNVo0VVJqdHlUbU5DM1Y0MjdCdGJsNUFo?=
 =?utf-8?B?U0VBdzZuNlBYVWFna0EvY2FxRno3WEFlQVNIYkJvMWFoVHFHZ25oOHVTWTRQ?=
 =?utf-8?B?N1RRdWUwb2NTamtvUTFjcjlhbllCNER1WlNVbE9ndGpzK2tKUUFwY0RSY1dU?=
 =?utf-8?B?ckRiM3VJV0JHazB3ZHRCM1ZFcjFOWkZxKzR5eFV5WHpvVStFcjBMUHlMdHV5?=
 =?utf-8?B?QTBqRUp2cWN0WnVUTmJ0S1B4RUY1MGlxNmhHZGdtdFI5bjdJSUxVRXNTM2Ev?=
 =?utf-8?B?QWxRNHBjbmorc2hndEhZdUdkdEpiSnlCYXZFZkViMzAvMmROZ1p0Z1lqajN0?=
 =?utf-8?B?dG5GS25ZYURuUkpXZ1kwZ29qOEZPbkwvOFVSWVNrS3lrdTJXdURkNEVUMHVN?=
 =?utf-8?B?TGJCbHNjamNRSzBjNThyOFlyUWZISnlCMFpGUG8yT0dIQkVGMk1IMERlalYx?=
 =?utf-8?B?bXlCNlJmV3F2amNhQ3RHTCtGTDU1L2xBbTNDVzlZSFZVRFFrSnBZM0F5aUpp?=
 =?utf-8?B?aFVJRDN6OVZxRUJCUnR4c3FYRXg4NHk5bjh0aDBucmRXdWpYdkI4UDM5c1o3?=
 =?utf-8?B?bklZTkMvUGF1S0RVUllpT25GaW85eEZOTG9nMUYxQTZIblZBSU5PbEoyQlcv?=
 =?utf-8?B?bTU2TTlUdUsvbENaQ1FqaTY1bTlaaThIOTAzSzB1U0dhUmdjb1RCazY4MS94?=
 =?utf-8?B?VTFtaTk4MmEzWDl1NlVYWW8wMlB3cm0xbG9kelNsZmRKeGxPSkdIKzNuRGhx?=
 =?utf-8?B?eDFKRXJ4ck9YNktBVXpaM0JDdjFsSXVJdDQ2ZlNyZ1k1ZEJGZ0Jhd2pBeUc0?=
 =?utf-8?B?UU1Vbm95ZW1kTG93cVRmKzlFWGxZMzNETnhHbDlHTytRSXZiTHViODlyU0VY?=
 =?utf-8?B?Z0JoMUVvUWlyWlgwUVk1Mkc1eUsvMkVGdDZnM2o3cWs0UkRzME5saXNneWVO?=
 =?utf-8?B?Wnp0Qk16RWxyOWYrVEdCM3JFbEpEczh2cnEreno4Y1VjK2VuMTdwRGorRlFx?=
 =?utf-8?B?WUpmRjZndDd6WkpMZVRyWUNqS0RTQnV1eGhWbGpTY2NHbExKK0p5R1ZUV0Zk?=
 =?utf-8?B?TnhDTzViYkloNVpyMm9yV1o2Z2E1Z3BpbmFsVGhmRGJoK3dyeXpnK3RVMUU4?=
 =?utf-8?B?TS9tRVZrTjBHS0lZNzdrNGF2blNTeU45ZWlFZmhuNWJUc2JzcXRqTXFOTUpS?=
 =?utf-8?B?OVFmcFZpelc4ai9QVG1RMGdSZTdQQWhOMFFUUkpJa2lPaGUrZ1dyQktEVGJo?=
 =?utf-8?B?SXd0eG1ZdTZJZ3BHUmYzVUFWM1k0QWFlend1Q1FsMVJYOGFCTVpYT0RDRU9x?=
 =?utf-8?B?Snk3TUFSeTBqeUpSeUJ4d2prbjVqWE42blZGd2V5MXFqWXVlTTdOZ2k4dFZz?=
 =?utf-8?B?SExiSk9tMDBHVi80M0RUYmE1ZFVRQ1NFN0o0dEQwYzVaNW14NTBVbG9NeUlj?=
 =?utf-8?B?eUx1UDFteTJGSjMrNGZUbEpIODE2YlR6T1dDRkdqMkxXWEZBREVWa1J2WHFx?=
 =?utf-8?B?RnRkNmo2RnBqek1EUlVUK2JUU04zREY4NmNORnBqcGtWY3JoZTRuTy9MZy9v?=
 =?utf-8?B?bk14WS84dGVSaUM4NWJsU1NBa2haemYwU3dBSzkvTmdUSG1yZWNzV3RGV1Fn?=
 =?utf-8?B?elFVVE5mcDVlVVJZMTh6ZVVncHFNQytGTER4aDQ2ejgrRytudXhNTFk2clpG?=
 =?utf-8?B?Q2w0M2VwYU9sS2FENmhZQlh5eWxTUlRJSndtSXM5UCtka0ZhSjB4K05lTWdp?=
 =?utf-8?B?VEw3cnNRY0VuQ0VjcWU0eU9Gc3p4Y081MjlUbklaOFhreWREOUlMTDExOXgw?=
 =?utf-8?B?UVAyZXZMcW05N3l2TFROaW9CZ1FkYmRHYlMrenFPZk5EdkJ2VTB1RU1MVFd2?=
 =?utf-8?Q?Rm+fyVUG+3kwVeLeSnJqwCE+bIx6A/RiYF076F3hPxVRO?=
X-MS-Exchange-AntiSpam-MessageData-1: Sinpm0E6GktVGgvgPyZqiF35Y17MRbPtWWc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecbdfa1-8eda-4e83-6d87-08de9658019e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0032.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:49:46.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BndVgIIyuHHJLe5skoRAcJR9ydiyMRKwvr+igs0L8szOAtjWm0RH04yAzIVZPBcPzoaayMX1aLwKi0JJ6SVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[fe80.eu,makrotopia.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,public-files.de,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 820713CDCB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 03:33:42PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Commit 8871389da151 introduces common pcs dts properties which writes
> rx=normal,tx=normal polarity to register SGMSYS_QPHY_WRAP_CTRL of switch.
> This is initialized with tx-bit set and so change inverts polarity
> compared to before.
> 
> It looks like mt7531 has tx polarity inverted in hardware and set tx-bit
> by default to restore the normal polarity.
> 
> Till this patch the register write was only called when mediatek,pnswap
> property was set which cannot be done for switch because the fw-node param
> was always NULL from switch driver in the mtk_pcs_lynxi_create call.
> 
> Do not configure switch side like it's done before.
> 
> Fixes: 8871389da151 ("net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/pcs/pcs-mtk-lynxi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> index c12f8087af9b..a753bd88cbc2 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -129,6 +129,9 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
>         unsigned int val = 0;
>         int ret;
> 
> +       if (!fwnode)
> +               return 0;
> +
>         if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
>                 default_pol = PHY_POL_INVERT;
> 
> --
> 2.43.0
>

I notice Arınc, listed by ./scripts/get_maintainer.pl drivers/net/dsa/mt7530.c,
and Felix, listed by ./scripts/get_maintainer.pl drivers/net/ethernet/mediatek/mtk_eth_soc.c,
are not on CC. Maybe they have more info.

Only the switch port has a chance of having a non-zero default polarity
setting? (coming from the efuse, if I understood this discussion properly)
https://lore.kernel.org/netdev/C59EED96-3973-4074-A4D8-C264949D447E@linux.dev/
The GMAC doesn't?

