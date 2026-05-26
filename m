Return-Path: <netdev+bounces-291664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNtYKAN+FWpEVwcAu9opvQ
	(envelope-from <netdev+bounces-291664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:03:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6775D4956
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86246300E00A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D63DCDAA;
	Tue, 26 May 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cet1simn"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4039733E;
	Tue, 26 May 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793409; cv=fail; b=nDaDTbBm8WcCh11PIo0p0+d7qbiLhC1jCeIRBV/sBdwTwafKMBOuVH9DC7HYWRK3Meg34Vf+2z/XEGeYqKTFvfvIcJjSCNSyLh+lRWkFI4KLHoqNFAEi8Ip/9EncYlEXUPB5zZkCSdj9NOtpo28hmnDOpsgn8A+5WakEjFcjUo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793409; c=relaxed/simple;
	bh=vGESvY4H+Ut4KC/4km3NuRMwuQIwPJ2aKx8V6aaK1fQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPumRCy7e7JxWjXi2nFdeCFfN6vYd8nOYVqT6IW8UusMlW1liEAKvwM2en3/3PY1O4jV8L24iT4RhZt0t/voooCQUMqIDOdltzhq1FVMnWz+N8VVYLH9sXsuZAFQX0MXs9ureQ/hVSsMj3ce9i/ZLPk4Wk4+tS3WLEVMmL3I+zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cet1simn; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpK35PKglT8IJri5N63yX02kT96M3Jxci9z3a6z3WWJv3u5adhqLXXDyFE+gzWpPkT0g8dALu5mwuk0/Kl9A9POMOeA9l/BwuLItFswkOvnUCqWI8IystUNO2msSGmBNaCQdCz+L1GIqFeUAgDqJ7SB8DJ7htwF2HZHLjv8ENCe7gObJtJv+xOl6AKypgNsuLFltOjH6foPdQEhMC3gqdgxJuVeki38H5kLUFUb9TBY71yPTcxUp5Crg0S7PKkq2cP33LAQhYao6IXkbqzKqtMe13+WnCiRyrm8QCXs5wfNYJe9YntcpG4RDEPEnaKvfomIQ9ZcpbGc+oKDWKU96Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGESvY4H+Ut4KC/4km3NuRMwuQIwPJ2aKx8V6aaK1fQ=;
 b=gck15Yy1UvaZw7mibVU9UPtZrCzxLEoSDj63l9VcX+Xn2eQZGWCH8VH2WyfxhIGfC6BCKKdh2mqHstCqXYDdjJ1eowoVh1DwOMVzON5PzEDkn0l7MQs853Yuq3s0QmK9L31Rpb0lzBmtxO6veA8ZNZXHITn5OPJAcRpRd6EbGfKGe5GmL0lWDFC5vPLUCSeJa3B2yItWmX+VHTgKe2v0sDZ6QCCrAS1tdWOyjD3J/BK6Yrwnx/ldhzUpOrJ+64mHV3t9Z9dFqPRNMpli6qr/GBGVTfCPIFl8EC2Y0E/9CI7yYxbMJs4+5dGW8MMV3g0pxI/Xef76YyWyPAEBlP08GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGESvY4H+Ut4KC/4km3NuRMwuQIwPJ2aKx8V6aaK1fQ=;
 b=cet1simnXISTFa+jilVK0ZEEhmdpMxi2/j4ok81n1Zkv6P5v5P9M6ImwuPNIUZQLagdhz/qx8oN6Zocz1aG6A+tnSDU3n8s1tiktdudXwT6UVnKyUt8VnnEaDZWZNhFHU/8Z9iFSZjXwQuMXH5n0yFAyQnbs5AoEp+Irdkx0lc1W9uw5R30MbQnBEjBupcZDtAO6mv8W6EDh2oSQebbwqbjjrMBOAySHicGpcj5OeSQ5P8Gg3n/oevVIjR+TDk8Sydq9WFwDLw/J87dj0Bi/7DdnpVetfkHKnN9rFRqKMWgFn5t32Kyah68aOtv0uPGP5Z8itz8mIvbm+MKYodQBig==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB8PR04MB7194.eurprd04.prod.outlook.com (2603:10a6:10:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:03:24 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 11:03:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Thread-Topic: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Thread-Index: AQHc7PpN5+QO0dxQGEmzQ8bYQ25kWbYgIojg
Date: Tue, 26 May 2026 11:03:24 +0000
Message-ID:
 <DBBPR04MB7500D92831D793CDD1D562E2880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260526102708.2837129-1-arnd@kernel.org>
In-Reply-To: <20260526102708.2837129-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DB8PR04MB7194:EE_
x-ms-office365-filtering-correlation-id: 47fa9dba-ff5f-4285-5a04-08debb16684a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|56012099003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 fF/UluNUQeUzcpSM7Y9303W1u7Md3H4fJhwv34L1C+DPDj6iE5Ka32zRCX6oNSh6QiOjU72w9oY3ELH+PW35rXAQHMPFZKJQxCiZwfv/fhgbSgAmi0QH7YOBDP6hSTyZHED6i/Rphsw6WXXeadrwqbrBuSx2LQaXs3YhXf4tvIXclJKHumGtVYMW7Zgnoq7qmMOJx3aoEH6Ts1xxV6eMmus3prdOJJskwhQWUXGMxfXbDrj/EZvAp0BZfVV/PHqUvlw5j0or5Bq7xnH1X2UNhsGA6drzsEa/XHg32U/VnqdAW/PPNSItqk84ASCmmxiic3Cfjinfe3Sm8pv16rsSwggHQ7pFWlSj207zJENJdwACnLxLxN5susdhXYInOidgtMV26Ih8SCFFmTh3WOjsnFAAgPAbeS3qshpi0unQYhIv7NPbWiFq4phzp6JscDWoz/ZiYbtUta1qvpgA1JLFE4V1wLn/BJoUiwIYlV1kybepHTvNRQWTdI65mUWGqz8a/o065yJ0TOXALDXkZudr0zas9Gf7g1+M+1eQwSpVP+G5LYm4dmCKlmbEqXQjXQ//l/aDpO+3ysU3B4EdDvVYvdkMA65+P4Vj8uFsl9W9uVK0iyYCNyRsx07qVKt6Fpb/pKvdwecYLxdQvS0AetonTZUZ67k3f6MBYBtP/rPxe5Qkdjr1KAJhv9kszsjCi4hepeeCEOcpLGItEyhluW53HQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(56012099003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+L0DLO15AQwMx/fkkpildy7lJdOU/LygYJn8GxB08o+JCrH8syAdCufj+IEH?=
 =?us-ascii?Q?ANcJwQyqzwAMIlDQPHVyN+b2CCixOTusZBnbO6Zhj0cukXvasPDt5mgO8GTe?=
 =?us-ascii?Q?6wi3NVCyK7vXFEeyXnKLBIZFwt12gHtVk8ZF1j1100jwQAR2N9zE6C2pjN+9?=
 =?us-ascii?Q?rnYoB6qAT8JcRE8phwccYN6ormkAhA5wqkbaoLUCMDu24M265cwckN3eHxAE?=
 =?us-ascii?Q?4Sa5TMf77hOS9LphHYMJ4MZ5LHv9VHsGl/1MYmAFPyscWAeyM/zPy8StpcdV?=
 =?us-ascii?Q?+GC89a0n7DWp27WkfbdaqVhYffQfoxHD/soGmIFFd1KavgliWU77u8k3HUR5?=
 =?us-ascii?Q?RDflijYCBHH4AClCF/u1ZVaSKRzIknreIiUjRdNAKw6ayFaMeJf9mPDiAKfv?=
 =?us-ascii?Q?HuTBxdDTnOKZENLW+D6A69lxb5UuUSyXX2gWedZBuL14KIEAWMkZFOZoB6hK?=
 =?us-ascii?Q?A/e4vMBbO4fbD1NriOuJOIHdgQjum1nuJvNZxv+FN0GkIC1xvv+iTh101aP7?=
 =?us-ascii?Q?jjvAeW/+qG+X0J/rSEoDu4m4xgwlz9sFKjI9AMy6aDV8Ut6lR+85JMjWikcq?=
 =?us-ascii?Q?5SFKYmM5zFW0IEYqelE5Dlute+3igdmo4hC3tFVIaRoBsadU8GxNJ3WzL2/i?=
 =?us-ascii?Q?u6NKNlgk8OI46Ubiip1sFzlNneuMRa/3jUHQLVNaPTsUIerWWCl6OOsdj+GX?=
 =?us-ascii?Q?ccHVYqHyviSSZzY57OGUgy2HmTPUfGxZ2potO4ukY1GZtFheTzk7ziWihcvc?=
 =?us-ascii?Q?ic9wdGAfyoQkykYJSu+58VY/s4mq2CXOqIbZVv/rU5dRzSAk0XLb7DK72SvY?=
 =?us-ascii?Q?CLS+0qfSVYtCGCwRjyjvBgB0E6xdk4ns8Plg6ERrc7TNE9DOHF5YJF3dhL5X?=
 =?us-ascii?Q?pl46kG39i75qu6kSrTkB90xWfpqmleh4rmxCYB88oaMBroYHY0bwgyiUq4Cc?=
 =?us-ascii?Q?PVnQlDuo5ymVw6C+riV+DVAdyfE5q1xYZDZxWHsvWScSuMUGzUVsJw/Xh80S?=
 =?us-ascii?Q?n41080SjhylbhS+xmoGBUos7tJbgQjHedEHiHkmv9y+LaF5wdCLi8AIKxA41?=
 =?us-ascii?Q?u/O4WE6++Gk91dCMHtalk89gkTg0rYRTABVZG4M1nBrLjiZ/mwKaDdZENj2u?=
 =?us-ascii?Q?jObrju/9T317b1+1AJ4/e69wp0r6w/UDua1k41Ft9/9EaHuVvnQZ94mKSMXy?=
 =?us-ascii?Q?imxq6piQ/dtZLtV4okGrk8387e9OBXXJIQsMWf9cUlyRPCFHVUZgcDVYcK/m?=
 =?us-ascii?Q?/Q2BncjubSXxH6DsXnVFlGiOXAx2h0dMETnaq98T2JbdP9oILI1luxynDp1a?=
 =?us-ascii?Q?wGojZ3bhuHJj9w5lNlOYPDYGtgj8HDdNdIFahHFwZkiHVUtaN/Y9OHTfoOAC?=
 =?us-ascii?Q?f8K/ViqvdXk7IPZ4+lnh+vbN3UY7wfm2IrsYmVVcwdg2KxIKacxaA/Ua+zi4?=
 =?us-ascii?Q?e4tOlTipk0zc1Fls8r/cwDguJmALrPCJNweLnQypbleQdHaA3kW5Fn9HbGVb?=
 =?us-ascii?Q?sYqdbEkrG6mWkiw7m2I/GFAKXTS9dIHF76AQSynhpp9SphTzN4PT9Rh5A2SD?=
 =?us-ascii?Q?HnXu+se0tYCdcsXxuHClX6P6StiU28RI/KEygng8QUj97/fHGcH/Kf+u6XHU?=
 =?us-ascii?Q?uhW2sZgZ4E0P9a9ActRaqObY4EdfZb7oA545kF7IxV7HeQtND+RSZPl5Nbvt?=
 =?us-ascii?Q?+UzW7iE5evDX4MiLMBCDOu1K9A7qrtpUvIF6gDCGBwbLubiT?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fa9dba-ff5f-4285-5a04-08debb16684a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 11:03:24.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub3q1cb/1D6mkYxNeToKb9Us/m1VYNYRFQjWo00nYcWF8v3kqOMFjkH8z4DipYCa4++7p8wxlDkAFbfvmzDREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7194
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-291664-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 3D6775D4956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Add the required 'NET_VENDOR_FREESCALE' dependency to make it possible
> to select both the PHY and NTMP library modules. Originally this was
> meant to be done through an 'IS_REACHABLE' check in the header file,
> but that did not work because the drivers/net/ethernet/freescale
> directory is not even entered in this case. IS_REACHABLE() is generally
> counterproductive because even when it works as intended, it turns
> a helpful link-time error into a silent runtime failure that is
> harder to debug. In this case, it clearly did not even do anything.
>=20

Hi Arnd,

Thanks for fix this issue, I have sent a patch last Sunday.
Link: https://lore.kernel.org/netdev/20260524070310.2429819-1-wei.fang@nxp.=
com/

I think the solution should simply be to add
"depends on NET_VENDOR_FREESCALE", right? The changes in
enetc_mdio.h seem more like improvements to me.


