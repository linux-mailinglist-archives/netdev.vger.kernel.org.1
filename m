Return-Path: <netdev+bounces-254175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC0mIOHYeWlI0AEAu9opvQ
	(envelope-from <netdev+bounces-254175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:37:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0A9EE30
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A10A2304800E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767A346FA0;
	Wed, 28 Jan 2026 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="djsLdXw+"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319534A773;
	Wed, 28 Jan 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592991; cv=fail; b=pAjKe+4AjIlh3OgD5VEXicrSCXeKvlMVd3QfX0ZvnSL8gF6Ck91vHtbSW9bZf6qzm/mgdVdEpkY8PKaVf7GQpscxQUk0vzAXI6eRmkKyDmMA0NFz0lnAPrb4nP4lg2BQQrHtwAWkxZFJN1+xcUwUDLAoxS7UdpGzKGaytInIAvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592991; c=relaxed/simple;
	bh=b/E0NHqp0x31RUIfwvpIuDlVD1poSe5p4Pk4ywFrmNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iV0ikt6GEk3zKz7kizY4sZ2a0G1j9DrP9oGhuK/oS4VWzoNqpD2xZbqfUVoS7PtYMKbSF0zJA4KlpRZ0kgqkF8HJhXGcxx/ISnbvm4OzyW3HY9Sl322cgO+RxavAOTxSYN+NmA3CJx3OvF7xVdvTKIPeIHkK2XackUjKojNlsGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=djsLdXw+; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmNklQuZGHgfApbM5lY80bWHQaKYUw3dqG9SCPM+u6mKcrO4RgK42NsqiTU0bJ2cR3CaCVmMpS+v/3StGT+I6ewW8D5xoIcEyh/qpzTZnDXfcS3Arro2tDd3kzpqYn/UXgwBGS/ejqyAlvtYxQwwKVl3jYfpmS0nLIPziaF8HxjLtBP9WrNuf6s6wizfsChds8ZK9CnVKB1ZncsQZ5IqoLbC+jGggb6sb3l44zqMPYBy/6HoQdYcJW3m3RFyyT59IWKPopfr2LQMz6AaJrleXBMTkE10QoJn3sot3A0aTAEJXuxdzuN3vWTmHGqQxdd0OcHK6xZQiUZep2xGKb8zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQFzVruX/vMkfUBOZlVeWqe+O1hXVPkoJjTwWR/sKT0=;
 b=e5fGz1ZJjHX80moCiELnublnrnqaMHVFVeIzQlVm9/3rkVMmcoTvclsYHDfS6Unu50ZvWcXAvKYaoxGsnD4MvrZBb1J3HrI+11SBkeXd9OSldPGW9JCeiNve0M+lVcqDg36z/3R87o7K23YSYSgd1/yi9bfNVWsF6fFlfgFmsdnTOmAwTHyqoP3xtbpTv+VIV2Y/g7xV0t3qEvG6jLvKRGyU+u5Qv/wFXMO0yQ6MkwXxbxsYJvp5U4a3zxG5lkWqZ6tB1GiXVbBSNSdnDoQLKSqdon3c0LSnkVwhn5jSHe5Z3I3SE1Hqh2joJQfM47eUo5tMW2KzkvmcL5c7TYKSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQFzVruX/vMkfUBOZlVeWqe+O1hXVPkoJjTwWR/sKT0=;
 b=djsLdXw+ylK64HX2IoBOSWPz88OZi+sZFNcG0Onz8U+ab+O1/3wiBMD096Dtxhtt6yhETyhkKmczRtPKTENZ64nAmIdevtZHNzKxxqDrQP6OygkCHnGiIcECnhJ7Q7YA7xATzgVvhpK3KKOMHNozxUNFXSOBO7/WmYC7YdRayfLIVPJCAsqrG8f81IP+DUALpEDPbxK1qARoPXpvmtX2QwF5c+pzxy8qcRRtBdpPmm5uiGXUR5jRoP12Kx9eqdbPZzi9D7HAhLK75GGVFdjW/P0PNvHpyhfhvWdX8Uhk7s70IzSN2cmLtnEhs4DAJbRIbtc1si61ULOLlRrohfJu1w==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AS5PR04MB11394.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 09:36:24 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 09:36:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
Thread-Topic: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
Thread-Index: AQHcjpwDS84Xw0yFx0WqOjcxpgF66LVmFjyAgAE4ozA=
Date: Wed, 28 Jan 2026 09:36:24 +0000
Message-ID:
 <AM9PR04MB8505744A93921B488AD9505C8891A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20260126081544.983517-1-wei.fang@nxp.com>
 <13f1599a-afd7-4350-a395-83c57ab91f18@bootlin.com>
In-Reply-To: <13f1599a-afd7-4350-a395-83c57ab91f18@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|AS5PR04MB11394:EE_
x-ms-office365-filtering-correlation-id: db3a7af7-60e2-4494-bf87-08de5e50b437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hoda4V0fBEwpMvdsfszGh/qZaapWSg4a3QJadmn0cF76hYfVMnqVVcNd0ufs?=
 =?us-ascii?Q?RNAUyDUjpbwJKcv4kfVGjQiHU0Rp9N3+HFSEpmbk1U2pZFFUr51GVCaM2BGt?=
 =?us-ascii?Q?GkV8J6MnFaKBxjQiMGQ0naDHZqq9fRtjECbDrLsHlWcgFWK0x3ze0/OtzxK/?=
 =?us-ascii?Q?XMidei7kPjWagHVNTSeTTLalCn7+Wchs+Xv4LrDkX5xf3pdEEX53ctWT8VDd?=
 =?us-ascii?Q?4WCA+TDQKlqPRJ+ajiVKoZN4OGlhn41e2PqARZE6ZQrLbsPVAIdSDnkaH64V?=
 =?us-ascii?Q?YRGQhAfma9JnzBJf56vFOu4uPXBhYZQXMn24rma1+eOMImNSEsO1DNsaYfUA?=
 =?us-ascii?Q?5TSSw5VLDQgOCVEv6rszVB2PzYA0Y9+qUWVgEEGRXlnDXqZlF0AI1q6wygVX?=
 =?us-ascii?Q?xzkmB8tMlVzkH3L789xck3epPDgcXyYtk+/IFLux/1sm9/mkWHg+EcCjEHEk?=
 =?us-ascii?Q?19e1qPuYq4umSv/fmMpbJIJfJzqKMiaacVE07n64OYyx8KudBj6mL5R/wCiM?=
 =?us-ascii?Q?Y8Yh8PweEhVZQBzGX2xmaqvi7oLfd6Y8Yiss6lU3u9arApDAPM/syrJvamOw?=
 =?us-ascii?Q?Jo7esw66f55FHsEuiR36i+uFwwXwVzewnPSbXYkQmfEzq6ylA5ao5dR4+y1+?=
 =?us-ascii?Q?rWCLpywlzTJZD+cIe8zfRFVYfr02NjVlpaQPbiOzsr/F05abrp+sqv10Z03X?=
 =?us-ascii?Q?ZXSwYivPAUbA29S2hWMaQVZLW/7/+f4Tn6a5MptSwyf07ZrpDN8JZJn+asUh?=
 =?us-ascii?Q?37Ifpqu3n7tqebk0wKa3ioGE9BOi16eIk097LMq3v2v7sIBGCfJGLvAtDIAn?=
 =?us-ascii?Q?TLTWF5d18SOneo1FBzdmE6TQ+JeIvd0T6hrg0BLoCHT98iMeQBC/QYXQYH76?=
 =?us-ascii?Q?WLlaQ3PmJlijHAX6p12TsYtOCFV2S4nFST+dcBr3iifWVjDm7KvZqfbReFq4?=
 =?us-ascii?Q?D87MEObQfy275iGE2rWQNimO5n/m8Nm/niPqx5slrvGu2dEgRC5PvdVyl89D?=
 =?us-ascii?Q?0GH+tlAvcd8YgTWtlS1qURdcpB686NeiGhPr935nYhfD+sBTtz+oIMVFXeDH?=
 =?us-ascii?Q?iFteJ7Q6wxb9Mi3knIh/u/s0VdCPYb/aai2n3KnCzfR1NBw3nQunp4UE55Rv?=
 =?us-ascii?Q?/xI8RycUlwyU3oxKncjGIlkD2rLM5U6qELp9f+Pd+/n0SOhUAKsKK5Ob1oRF?=
 =?us-ascii?Q?LkJoGieH7h6TBhj5dAHmVKC+uRany6xWq9ryAJmPA5F9BkLIgC5u5YhpNvGM?=
 =?us-ascii?Q?GHa4Xx31kUq6Ewm8zuHpIl1o3+a5BZYOjEwt5puu0ngQsCBHM3ssgTb4dvki?=
 =?us-ascii?Q?8cDHKFgzsEJMBuwSos5Ew7EjK5gtkM6AGLSbVoYMttL0hyalMSiSNzD0jnLT?=
 =?us-ascii?Q?uDDpTdVzhsMzIP+akfOLbsTJSX5RXwhUJzXnd9OSRgaXqMMjDr3RehDbsWQB?=
 =?us-ascii?Q?vO4A2xz9zjVJ147t6M4fKKYeYWqIpv9SP39Glz9ZcwzzbIT31UnaeLyl+0bA?=
 =?us-ascii?Q?iUbDr9vuiFy0jNwdZ+3D01SOV4Ga9hnoItNRNo72rztYe25clrA5hnrrCCaC?=
 =?us-ascii?Q?SM74lE5oQlPkM0FImobtjFJWDerhMsDNixhx17jgoXqbjD39jRFXxDcqcmzC?=
 =?us-ascii?Q?eYnTdYXuGX7ggqqsszIeGpE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CqO+GOOA52JeRpTB3tShDhNJbD/S7gUqC3GrY4NIhEDSwUINzSbMogN7rMwd?=
 =?us-ascii?Q?VmFXP+y1PQBlebbXDIZYFQPeVNpNvKqBLX49fNM3FvpQ1hqZvMEmWFPrkCEl?=
 =?us-ascii?Q?FrKcFwZ72a70WKz4+d6AZ5SGbDubTCk9fpD13BITbKqVOib7J3frRQmpjVBt?=
 =?us-ascii?Q?1U4fFj05Dl9p6tai8rYB+23fDxiagpV2qeZ+BasUn8O33YHY2Xorv6h7XkuE?=
 =?us-ascii?Q?a97p4FrijfMmP9xbdlcqjNhXIRL/qdGqLamu82t9TgE7BZoIjEml6bckRxj1?=
 =?us-ascii?Q?LpIwUWMlMe2KyNX5Yoxl3Oi2SC0sAYq3PsjBqFjn3uuNLshMryvh4wnRowB0?=
 =?us-ascii?Q?UkohB8qObTrvn1K+HuhKBaEjwg+3OEqUkCp1U/UOb3uQ268W5QCzfKZ+8uw2?=
 =?us-ascii?Q?/j1Kxc+gWX7ApvXoVJYoWRjm8OJrs44SD3g/Tc6+5JlgUFjAj89Z8ANw9/HY?=
 =?us-ascii?Q?KBMZZWDuo1g8QiLg8lNdjVzbEmE2FHP7THyNA8IE1g+NR3pH6E9Fe2QaNSVD?=
 =?us-ascii?Q?6zM4Ht+X0NEr2La4SoIuPmuWGRcmVrRqfJvnBYFTylD5eM4altVuNRPXlPMi?=
 =?us-ascii?Q?JAcB6Z1qRRTdXmD6OJal0MuwiMcvsdb+ppwdmxH85VL9JYTIxn8F0uDc+5+W?=
 =?us-ascii?Q?hmWSGlD197m0Oq5OQxfXBI0e2UBwUy+2NKG91Ep7kIzzG4RvwKCaEZpFNzVG?=
 =?us-ascii?Q?Chi5GN0vl4xaHxMwkN539bI+O1EsZoVMvhpaHKUK1d24sSLsLk8i5fJgwz+P?=
 =?us-ascii?Q?PA+R383MNs2Ood2cdT7GasjzgmuLXXlj0XCDOyVqPubY3uJm3A5Jpja86zmK?=
 =?us-ascii?Q?9aJcxPYaLH9J2IzF2avCbXrJFYPwIsDyIXYBN5eSpX2SWQ7RfeMOqn61LTqD?=
 =?us-ascii?Q?GI+L0EYtDJJxskuh/7HdwPGhoczieCBZlRj5//hl9IgoFj9B9KD4eI+7ucc2?=
 =?us-ascii?Q?BcCriBiWXbSOnPlNoNxxsOaZ9y3fgDXNuk0gIlwg0W91r/LC+fu353c85cwH?=
 =?us-ascii?Q?DvD+U7pIYAM0ACQKgzQXpd07rLGiJJu/qkfbgAJ/BJJFAWO/5brnzpKRpCwh?=
 =?us-ascii?Q?ma41alVxd4GzT85H0Y0RES50F1ClKtyc7QDF00VjNJd/boiTGBhFRoJRQZKz?=
 =?us-ascii?Q?Z/xZXGLFigMQBZ5Ydlke7ESyahJ4dVOU38juQCOdz0Y5f+nzOMJVhrYPwUJT?=
 =?us-ascii?Q?ATlmTPwwwdOhJ4KXspMob2WRHuqVX2p+OFC0l/Vd2oP7abxV+P+oyNuByuNT?=
 =?us-ascii?Q?robohe/FZeOS9TOspHwpPvFeJpiYvcvXZyJYOJg/QcfVfmMzJ/dcz6mXmEjf?=
 =?us-ascii?Q?r/HxiJwKnx6yIAameE327VRSaYA84lPK5g6RruszLkXh+gtP7vndRnwBSMws?=
 =?us-ascii?Q?l/eaXVv7jYxrBoFxsL2Lwfi81laGoe8PcxJ58NsxulFrrLaDBsP9gqbrLM6C?=
 =?us-ascii?Q?k2Q9TOhd1d3sG/LEP6hS4UNE6ETukXjv9PB0qrjkwQaesb3JVVVfP9fpEqwK?=
 =?us-ascii?Q?KzVF6ixwbHY9PB1ZEsBQ1+U4O4FHMi8G3BceXvd0CtXV6USIgK9jsBr1qyho?=
 =?us-ascii?Q?L+Hy/ePWkI/8TQc4vF8E06YvKHT8C7vXEbNKril3JgbQ13rrnHZEYw9WHRo5?=
 =?us-ascii?Q?tsWkPOL9lxthKSjqzJ+MLIR89utLtFxQB2mEV/WWWuJCyvaMliL0lBkLztxe?=
 =?us-ascii?Q?BBj06eDxDqzPqs31EjGoo4n7z21DoB6aiNiLeaYU9Wkn73Kp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3a7af7-60e2-4494-bf87-08de5e50b437
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 09:36:24.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqYTY6jmE/RWrTlxY/xvKnPixO2b+G+DvvOW5yV66iIJMaiykhlYA1Z1QLKhkSIOL8lyk0RmhQ9mwgckbyAvTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11394
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,AM9PR04MB8505.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 0CD0A9EE30
X-Rspamd-Action: no action

> On 26/01/2026 09:15, Wei Fang wrote:
> > Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
> > external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
> > by phy_driver::resume() and disabled by phy_driver::suspend(). However,
> > devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
> > will automatically be disabled when the device is unbound from the bus.
> > Therefore, this could cause the clock to be disabled twice, resulting
> > in clk driver warnings.
> >
> > For example, this issue can be reproduced on i.MX6ULL platform, and we
> > can see the following logs when removing the FEC MAC drivers.
> >
> > $ echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind
> > $ echo 20b4000.ethernet > /sys/bus/platform/drivers/fec/unbind
> > [  109.758207] ------------[ cut here ]------------
> > [  109.758240] WARNING: drivers/clk/clk.c:1188 at
> clk_core_disable+0xb4/0xd0, CPU#0: sh/639
> > [  109.771011] enet2_ref already disabled
> > [  109.793359] Call trace:
> > [  109.822006]  clk_core_disable from clk_disable+0x28/0x34
> > [  109.827340]  clk_disable from clk_disable_unprepare+0xc/0x18
> > [  109.833029]  clk_disable_unprepare from devm_clk_release+0x1c/0x28
> > [  109.839241]  devm_clk_release from devres_release_all+0x98/0x100
> > [  109.845278]  devres_release_all from device_unbind_cleanup+0xc/0x70
> > [  109.851571]  device_unbind_cleanup from
> device_release_driver_internal+0x1a4/0x1f4
> > [  109.859170]  device_release_driver_internal from
> bus_remove_device+0xbc/0xe4
> > [  109.866243]  bus_remove_device from device_del+0x140/0x458
> > [  109.871757]  device_del from phy_mdio_device_remove+0xc/0x24
> > [  109.877452]  phy_mdio_device_remove from
> mdiobus_unregister+0x40/0xac
> > [  109.883918]  mdiobus_unregister from
> fec_enet_mii_remove+0x40/0x78
> > [  109.890125]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
> > [  109.896076]  fec_drv_remove from
> device_release_driver_internal+0x17c/0x1f4
> > [  109.962748] WARNING: drivers/clk/clk.c:1047 at
> clk_core_unprepare+0xfc/0x13c, CPU#0: sh/639
> > [  109.975805] enet2_ref already unprepared
> > [  110.002866] Call trace:
> > [  110.031758]  clk_core_unprepare from clk_unprepare+0x24/0x2c
> > [  110.037440]  clk_unprepare from devm_clk_release+0x1c/0x28
> > [  110.042957]  devm_clk_release from devres_release_all+0x98/0x100
> > [  110.048989]  devres_release_all from device_unbind_cleanup+0xc/0x70
> > [  110.055280]  device_unbind_cleanup from
> device_release_driver_internal+0x1a4/0x1f4
> > [  110.062877]  device_release_driver_internal from
> bus_remove_device+0xbc/0xe4
> > [  110.069950]  bus_remove_device from device_del+0x140/0x458
> > [  110.075469]  device_del from phy_mdio_device_remove+0xc/0x24
> > [  110.081165]  phy_mdio_device_remove from
> mdiobus_unregister+0x40/0xac
> > [  110.087632]  mdiobus_unregister from
> fec_enet_mii_remove+0x40/0x78
> > [  110.093836]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
> > [  110.099782]  fec_drv_remove from
> device_release_driver_internal+0x17c/0x1f4
> >
> > After analyzing the process of removing the FEC driver, as shown below,
> > it can be seen that the clock was disabled twice by the PHY driver.
> >
> > fec_drv_remove()
> >   --> fec_enet_close()
> >     --> phy_stop()
> >       --> phy_suspend()
> >         --> kszphy_suspend() #1 The clock is disabled
> >   --> fec_enet_mii_remove()
> >     --> mdiobus_unregister()
> >       --> phy_mdio_device_remove()
> >         --> device_del()
> >           --> devm_clk_release() #2 The clock is disabled again
> >
> > Therefore, devm_clk_get_optional() is used to fix the above issue. And
> > to avoid the issue mentioned by the commit 985329462723 ("net: phy:
> > micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> > clock is enabled by clk_prepare_enable() to get the correct clock rate.
> >
> > Fixes: 25c6a5ab151f ("net: phy: micrel: Dynamically control external cl=
ock of
> KSZ PHY")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
>=20
> This should fix the issue indeed. The dance of enabling/disabling then
> re-enabling at resume() again feels odd, but at least it's balanced.
>=20
> We may be able to avoid that entirely by dealing with the ref_mii_clk
> selection only in the .resume() path, as it's also called no long after
> config_init(). That would mean reading the clock rate in
> kszphy_config_reset(), then performing the kszphy_rmii_clk_sel()
> accordingly.
>=20

It seems rather strange to get the clock rate every time the .resume()
is called. Otherwise, we would need to add some additional logic to=20
kszphy_rmii_clk_sel() to ensure that the clock rate is only obtained
once. IMO, it would be more reasonable to only get the clock rate in
the .probe() during the lifetime of the PHY driver.

Furthermore, this seems to break the previous logic: when the clock
rate is incorrect, the .probe() will return an error, meaning the PHY
driver will not be loaded.


