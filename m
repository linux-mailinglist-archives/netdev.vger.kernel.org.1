Return-Path: <netdev+bounces-264181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NRhuL3oKqWme0gAAu9opvQ
	(envelope-from <netdev+bounces-264181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:45:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C920AE33
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB7A3304436E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6213AD05;
	Thu,  5 Mar 2026 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Sw3rYgGG"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022107.outbound.protection.outlook.com [52.101.126.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013211CAF;
	Thu,  5 Mar 2026 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685941; cv=fail; b=k0vmLUXcn1S3JC5MXbrWfwHI+twoXtMLItMISXj3bkLIC1MCOveb7BJhz0fTIFWg8wdOg8cTploufH/zPor27rAnFjydIgmHhSVgl83GXPE9c87cBfixfGUiN+UN/UZKt+XUbWptSaz7hfQ/09TYSyz8Aws68sW6h0zGuGjKHV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685941; c=relaxed/simple;
	bh=lL+04A7+pM95dirU+T76ZQf2oVHoDEWwKPrgJ1ofUhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPzPGgj6B4USa5eBCy7hwRzXqzhUSSAqK+IsgYHdw0hKDCqpuY69nWRC8HrRBblBi8K5GyiEusqWSfUHGTl2B9Sr0HQtuXNubKUbG2UbUwSbwouHjWKMKO7rhRA0TvRXmcLpeO8NNQFJjW/YLqaxgzUYOYezGk5lTvKLwetzbFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Sw3rYgGG; arc=fail smtp.client-ip=52.101.126.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMpRsMBp9OXpkw0XIzIRqY24xO5jvTdWJgnVx5JzuyOWSvsI/OSxVj4UYwULSzWj4hGG+vrrhwaFRneXzcNEm+iYANWgaqXyvZAAjfPE9rEXzDFwo7BTFVPG8PE0mXy4PkDHi9JVQLRdTZSASX6CqXzicq8HqQ1Vqh1mwxd9fuJCzdXLgvJQJSNXU0peZpHsAD+qHqMCfLQIf+FrzMTyRHXW5W9TR51397Ug9D/aFlFklJc4+jAJDUoupUh2LZfAvnlVPIaSqC6G+S/y8BKnB6wLkVLqe4aHefa6U7NJHeJa7fEWI4T3ozsqCByzuyYwkvy1U8OCOYsIOEpig+0IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xdaQdTlScqCNl5J94ZPpW0D7lEg9vlDkB0jY50nr5Q=;
 b=i5zx3eLQVkxgFpA581Kghv6SCmYa9wWYw+YnK1Nr2FIpUDLArkKsu36TkdC1RlV7FJn6lcdchc78MssAnpxlIXP1C3I/hsg9eD3IpTDW4TRaizyJJqKRiotjKqhXEGLIvh+4CYPCmadhfV6udEtsUBmFMiFTU6Ztc7d5ZUvXVxXArgZ6jyD2WQTsM3abS9tVHUQ03i0sboI82D8TSRHmihHh6wCYSABuBnBvMfzjTUAygNIRqtlcfl/X5Ky7QrcS8uvrRZ9Z/2XdROG5ahhKJ1NnN9DyI9TBjpu2BU1j6BiY0XBkRLhIdsYBrwmib5lVu9AOveq+XElf4bSZt00Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xdaQdTlScqCNl5J94ZPpW0D7lEg9vlDkB0jY50nr5Q=;
 b=Sw3rYgGGUvqs0K+R1b93pUKLVhzu7RKkuv8HO4YW98M/y4U8HFEbxynrAu73gd8Ty1yPI6isSRnwUV6GbK3LpG9qTvmJxomeBEfTORSFSa2Us/qr7Wqyx2gmzgsPeb82nsFuklsQiyH0Awet+0a1zyPYshxwHDebQ5qz1C3ijFjbEr73eryS58qtznsTGhZJ7gKcmjhLO2O8WpaWMCNQ5dl86c+kf0H6int/OBATwWxO7qdSq3ixOP/zUSHFh/Nx3Jz3GnCyDp/oA5rlP4s3Byiu6hAttwdgyYtEAYwn1YDDqzTEKqDuXXnRe38XuGf9teJLfNPsydwasIQeV2hvew==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 04:45:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 04:45:34 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcrFrnevl6+hCpUU2aPeSuExnKlA==
Date: Thu, 5 Mar 2026 04:45:34 +0000
Message-ID:
 <SEYPR06MB5134315F4EEE77ABEECF7AAD9D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
 <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
 <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8b1e64cd-b48c-43c4-a184-82a6297f273b@lunn.ch>
In-Reply-To: <8b1e64cd-b48c-43c4-a184-82a6297f273b@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB6081:EE_
x-ms-office365-filtering-correlation-id: 540babdd-6695-411b-895c-08de7a7209b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 UNOg4FlDTw610N3V1S+SAEKfzbrMz9BhIM7x5Ws09KXFMjm0zSaAu4eD0b0HcQbBDd1uTgCbe9/DwTylw7qopewfjEB8AJ5wUrkoZEeoS/Nq9pREiSB7zQe8M5kPLihvQ8ewQMhjmXjU35RACM41bSYkYgJlJ7RSK23sERVAxjnj3c7FuOvMfExe4MTPYNVBpKv3I0lGJSYP6sa7IF7jQt2PRU3KX/j2G9CU4ZOm2wUkwF+cGduvDuVx5MvL6oOZUDfDHBmkBpC4s7pd0RkngQoFnU/WWtBHVl4R7TeERQ+MCzDnuqhjuL3+qat786EU47TolVesbWu3UVTHrL0bQtgEIrmyx0zV5Q/yoBHo9KwSR7LNVxPMdze77zYbSwToSz8JRVyajsBfq7rZbJJr7IQbVKGuR9JAWr9brTiZyQciJiUPFblWtT+GNSX8YwA/7SjJnli23xKMoPM+zbwV/V5wYr8Mp5WhXjAgCtDhGGN/5iQ00ao3T5LloOaG8B0l/Uz8nhtN8hhYPUgHsuuZxCOwfHHBIe3LYsn/L/6dRlNrLs9XTm0c9eUxpWTDclaqe0R2R+T4E/oKW3+Lza/E9CGAsvTx+R1FpheixfaQz3sAPW6F4SpIGE3+8hDneAlTZoBAZAL5/UvuJPND7VvizjytjHWDLfurFQw3MtqYdICtZuOpnt/zyj89lAivWeMEeX8MZbm4Q4kLjTKqg3I8zgvwj2yJ7AlNnav8eq96rJLTizALAgbQUXRQUz2Gkql6pjcELGlt1Z9rbA5yBGenXHRmo47oN9TISkQ+xew/7iE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YqWl1SnrhYNRwSdYs9UE+utMx81Re1HwsK5antCcqdygyYfjspVep7APqbwO?=
 =?us-ascii?Q?pzBAEyI5kMmS9C8dPE1r+D1XCWM59212t8+ZaXd6jcYo5oDyuHuqW7A4TW5M?=
 =?us-ascii?Q?rrK5nJqBTg56fRArDOaFat/wofJziDkdexgMQ34nj3Y30CIUx0E6L38P0IE+?=
 =?us-ascii?Q?64CJexzqSahipCZ+Sr6XNpoIVvN7L8M1NtU+pG8wyKcxMJupgBEiRfUxnYk8?=
 =?us-ascii?Q?shQR3xlc7JoQk/YuBg9SVpz2Fx5GCSAvcjjFt4rVSfHCuodOisD5O+1huF1F?=
 =?us-ascii?Q?fkgehX54h/NxXVsZOyeAwgujc7h514BRZTGGFQ9vnvkEvqJD3LDT0Z/DxslA?=
 =?us-ascii?Q?iv/BPbjB/H6R+GO2U/PXY8FEvLCzqYZch3+uq5Qd8t6xNnJglMheK2MepZsH?=
 =?us-ascii?Q?mcKLhkRkl4eD7ucAifZapygKdL1WptjAOwCoD2XDzwGQLK58/XVxKDA+Yw62?=
 =?us-ascii?Q?AnQBO/V+5nfk0ONIs5iztPGgnEIo7bMt5Th7BDSUP9IEp088h+ulwA1jjw02?=
 =?us-ascii?Q?IhWDnihg7BUPRWBOLZz9RZutYdek5OSD2efknlgE8H5Gb9dU1hahrKVQnFbw?=
 =?us-ascii?Q?jVF+D09GitwNhPXl1gy+ZCXC5rwHiIuuK2lJ/xOxnSJnuR7k2+xYuvfqzK97?=
 =?us-ascii?Q?UnfmQ8kkaIty5rvEvQf/s3TOIquiX+mpVL1RHFHa82ptaFERpoti3XJoWFga?=
 =?us-ascii?Q?ETD2zVxxi6Q4sd3unUEQJ7iWYLrZ5rer7SnmAAYH9/PhWtngHnN2Comd0AC/?=
 =?us-ascii?Q?Rc14J4JW+Clyzt11iq3uKB1FMhVL+zM4jCnjOimzxkegNYoadKTrakXGJmFO?=
 =?us-ascii?Q?rK6LF+8Gjw5vbS4YwI2OZKxIU0EM2VapbAhXrtHkR7owO3FSu6WUn2DSu4hx?=
 =?us-ascii?Q?un/ZxPIPmQIiobFTLXiuG/nposdlzKy5bM8T1o7Gxr8zARbhPfdDTd+ZxWFT?=
 =?us-ascii?Q?M+R9CmcKhxVDq05lT3TXBnmB06BpRtF8XmSiKwYnxRgv5Zb+MS7Mlq1ejQ7D?=
 =?us-ascii?Q?bXqv5T5eCFzABxL/1ttgijK17MMddXliHow2bbIhJJNyxTS/7OPdGASwjWCi?=
 =?us-ascii?Q?S9ZeuJ7guMX6bjERx36slCPLpptjUZnP+EXrw4p4UBD3G8p4195a6wlnu6Y0?=
 =?us-ascii?Q?vbTII7Fr5czaP099SZeXnIV6QrqE6EuQ/szMBA7Rzxt6ejqVyVooIidnyGyk?=
 =?us-ascii?Q?biGzCOWllsPsWsIv+GkGcB5i6qvO1SVVdOFXGWb00ZNvMkD7eRtuoFWj/J9r?=
 =?us-ascii?Q?+7ECM9iwj/29YqHoOK6+evcIX7dx5Z9gs1r+yevCSH1vA0tsDd5whMn0L+lt?=
 =?us-ascii?Q?/9xjDdhltzFZ2PWYO68kz9DAmsP2LGP4mZwUj4CJtoo2rYU0PwK2VXcRfTUK?=
 =?us-ascii?Q?DxapmjWKaaSfWv+59C/pxPTZndpagVimuNxGWlN86nSByddDs+BeMZJz5W3L?=
 =?us-ascii?Q?ReZThra7e1ni+5m6eMexiHcOmruuV6WP1tATgJ75v/eck4wYBuoExdOS3K87?=
 =?us-ascii?Q?lFncwVN8jOf7zGPj10DOH6fQCiTh/8zZJ0tROIhGz2w5OkvvvqkJQWYURYro?=
 =?us-ascii?Q?FzHjTqx4zy8E79ncx9Zf/eefmgvIWqEBMxtHgFMgwroj5XzAlFj4RQTeHSM3?=
 =?us-ascii?Q?Z26bDZHRwbG8T6W7DHM/l8diGkdsNbgQaQpohPouhfgD3YBf+wt89ae7plmQ?=
 =?us-ascii?Q?p+f/Zb3YyF0AjO5wN8Bgze4lY3fCSYWrLO7bcW8Ddt8Nj78RhpT7uPbjmSW0?=
 =?us-ascii?Q?cf2o63gH1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540babdd-6695-411b-895c-08de7a7209b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 04:45:34.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6OqBQwFIW4dx8S3GSQx4uBInNbcDee4IbOK+fbuosXJGkuTwDkJs7kyvrQRCs6U7gbE/XQjAwZAzewgEsuOnjlSGnhoRhTNrWYzw6MMnEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Rspamd-Queue-Id: F16C920AE33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264181-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > > > Therefore, we calculate the delay stage from the
> > > > rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel to
> > > > or bigger than 32, the delay stage will be mask 0x1f to get the cor=
rect
> setting.
> > >
> > > Please return -EINVAL. Asking for more than 7.75ns is clearly broken.
> >
> > ...
> > 	tx_delay_index =3D DIV_ROUND_CLOSEST(rgmii_tx_delay,
> rgmii_delay_unit);
> > 	if (tx_delay_index >=3D 32) {
> > 		dev_err(dev, "The %u ps of TX delay is out of range\n",
> > 			rgmii_tx_delay);
> > 		return -EINVAL;
> > 	}
> >
> > 	rx_delay_index =3D DIV_ROUND_CLOSEST(rgmii_rx_delay,
> rgmii_delay_unit);
> > 	if (rx_delay_index >=3D 32) {
> > 		dev_err(dev, "The %u ps of RX delay is out of range\n",
> > 			rgmii_rx_delay);
> > 		return -EINVAL;
> > 	}
> > ...
> >
> > These codes will calculate the ns delay to MAC delay index.
> > (rgmii_delay_unit is 250 ps on MAC2/3) If set tx delay to 8 ns on MAC2
> > or MAC3, it will get index is 32.
> > It is over the delay configuration range, here will return -EINVAL.
>=20
> So is the comment wrong? No masking is actually done?
>=20

Yes. I will update the comment in next version.
Thank you for reminding me.

Thanks,
Jacky


