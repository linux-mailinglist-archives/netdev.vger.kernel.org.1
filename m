Return-Path: <netdev+bounces-294076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3+xOEXyOHmpHlAkAu9opvQ
	(envelope-from <netdev+bounces-294076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51A62A179
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DBCE3053BEC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6CA395AF6;
	Tue,  2 Jun 2026 07:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2132.outbound.protection.partner.outlook.cn [139.219.17.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBD372060;
	Tue,  2 Jun 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386852; cv=fail; b=DveYm6MFmbIyEIX2rSMR2vhp0y9Cc7B82fsD+M0CXJ4goNCgEIZk/rdKfAhe87sutSVNNo7Adu7muc6pxV95knSn39PgWTCaKQQ/QKq9WljtXu5ZOBPdsfD1dPLOwNIwZAMrKRiFm8tuXAt+CLImI3/mryNI4o4mNioSA/cgQBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386852; c=relaxed/simple;
	bh=JzUzjHRtiz9EtGngGMh09CX5i/kw6pD2E+Gh4eT2wFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQcEYgTrSss9fEt2Nxve5H7r0UzE02J5bQ9OxlMeLELPw3fqB7u31hyW/5KZOU/p7CAMBfuS9AvppnVSlKVuyJZ4B7hsEPKfW4CYCoNpQvU8fOxNxK3NZ8kuRQiqv7FH5+3yiYDOP93fKRV+tBrL0oAZTZV7y8qZjz295zOoems=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hdxx9fCZmONX/TrRczfHiuPqLI7sp+NuMVM5gEwAp31hsSUEeF1dcXspfmwtyygoDvB9a82fC0sAOJWDazpaeO3KhA+Q/Xba6RyqQsG88nngfPk9D6q4t67TNmzZKQlHKlI51Jov4AE68P30wxrxPZ1HNIM4L1SVlP87wL9G/PSGZtTIjRZ2eq97oDX2CnFU1cdhKchzDancgiRbjxobPM+9lHyJ6gZLeru/ndQwU5M5ygVPSYIaxqSKdIHe1lvYtyMMQXgZaogYxyAaaUI+wkOle8Y3dAkhqaZCPuvBeEV4qX+52bepP15IX1nR8rLhbG0t7eV/2rv567R+H6+1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3mevj0wkzdwzydZBh2PncwK5aAQtxo9Ah9Wn1BkkYY=;
 b=QEUv/8mB2gYIb8I+KFMysQXAQdDrErxglL+ekvHy5C/ZUOZndsSZYhiVAye7M+wfA58sN3IB/PZH7PVQ0VMp6XQgBfVlZVhV2/CcoRrFO5l0XdfVFpi4TuxjyhwP9Pn7xS1T1UDyOzFPorunDieZZJdUrUBlxyrqGTZOojhIcQiq011dGacyr7zdw8pwckpqQxXhO0dxJde3hhfAw4kVnU1InL4Mz8f9p+vQMHiNgcf7aZUILBsvUpASnkz/XBeT3mTRDh/bt9+DL6H75mrwp9T25xF/nXexedgyZkLNF43v7GADJ+ablFB748AtcWGL16lvC7sHPOjYSg8TXTPr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0718.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.18; Tue, 2 Jun 2026
 05:19:23 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Tue, 2 Jun 2026 05:19:22 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY
 support
Thread-Topic: [net-next v5 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY
 support
Thread-Index: AQHc7w+mH9U4hq4iQ02b/QTmPjv+rrYqwJ0w
Date: Tue, 2 Jun 2026 05:19:22 +0000
Message-ID:
 <SHXPR01MB08633585004218C86DD44D27E6122@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260529020530.16856-1-minda.chen@starfivetech.com>
 <20260529020530.16856-4-minda.chen@starfivetech.com>
In-Reply-To: <20260529020530.16856-4-minda.chen@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0718:EE_
x-ms-office365-filtering-correlation-id: 7edf5915-43f7-49ec-6818-08dec06681b5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 yyZ4ys9tPuvHGPShNfy9VsotiKa+B/EmKT5LTgSCsjfdo+EmUWM5pnIT0Ql1y4Htvf4dQuRvXi1+Cgcem3UW15D+4e1S1MFkuLdadsrCchuzZTscKmVNI+ez65iJ7GnCCijEjM09V3qQn3vhOKneTkRj65KDVOzS0U3qWsLMh74SA9K/FavzDRRWcwXPv+zBjpaUuqaAJl6YGmKMLIrDNw3jps5lHFq3UK6gRsVDdhFPLWPYWfBbYhyWEU22QB3e2yRYNXlfGtj/Tbx2s/8QVlekYxxumkjfP6liJ+dSZzXY2VYNtDJuV5HgjmeQVH16BN19VyFRoaKh0E5RrC4k6m9Zbv7LlzihQmjAWiNvDje1ANsGyGzviDfhGJK77EbllPZlY02LqZQ5rPclMarbjRWnBLXj+EWeU6CRvlH1JNBOOdtUViGvRNbou3TclnqA7JmfRTq4Y1RKmitDIcNdyv9QS5rlIqTAELYVNFU0VE4XAC/tgt3x1+0NwqxIGh0EQ1b8UrI7yUJyINCNRYxgK8H4otFrtN+wN/5MQJuwf/8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zt3aNP0GW5M/NpvNLhltp8YaWTnwqG2vgY6g3+jLQtLgyR9kMkayPAU1SS3U?=
 =?us-ascii?Q?H6xJSKVL30i74NZBewqVZbtkGL8ZwGFPwmwYWEHN0MRyY0bh4FDhZiPwjxX6?=
 =?us-ascii?Q?PiBTIiOu2WV4ghj57zt/pjF9GqzmAyd3cz6e6j5BpXoWRn6ZmEDOiYqiLBjr?=
 =?us-ascii?Q?SMFuN3bo87TcvMPHza8eGJI3Z7gAJupvhQejri+MWyrou/NkRS6DzLYroQI6?=
 =?us-ascii?Q?PkXRaTLTqr+n6TQQzOcpbaeOzCNQBIK6A/FuiHDI2V2tUEvAvHI+K4UKUZ68?=
 =?us-ascii?Q?G2M+7GWFwjmyWFZN50bL4b6fOTBEETcR7KOrpePGJpsCsLkTB5V9m8ZTqcQT?=
 =?us-ascii?Q?QNcilXbQ+PbsWWuaSIpPav8E+euABowF2dlEd+bcskDyZIWKSChBsC8tkgqg?=
 =?us-ascii?Q?O8IQQ9gfhRxefu3RLG0C/NfGh+TbdnwdjB38GIJdfjYjAwh3e6tWmDI4qm4x?=
 =?us-ascii?Q?M86Uz6J3a01skI+s/W3YDLAslMYHSLOhwk+CQuDVwXIgBQ5XL8dFDK86Lfdk?=
 =?us-ascii?Q?UB8P3M20QjweglTmJafw1F1d2UK5yhtqWae0K7SsYVXFeL5MIaq9vI3ZR0BU?=
 =?us-ascii?Q?vci4qKYX4hxF9rI9EWHG3nwuANLq+gTqg3Slf3prZyTAxvhqwFsYMZabW0qw?=
 =?us-ascii?Q?3zKANJ0xBpbz20oPFWkmTCW+WTWm1o2HAi1TM3DAbvHwlyg97Vbp0fCAarLE?=
 =?us-ascii?Q?LAY0qlF5KgEKr6T5DB8TrBalFNP1S+i3QJeH+UutuVHA4mJ9tZMy86bYABxO?=
 =?us-ascii?Q?mXAt0OnwI+JZphdqJH2UWK8nKni2Q3joiQAgQRQCOe5MxrKKrKic1w6EHFVZ?=
 =?us-ascii?Q?jBfbvVWqvGqv43dwtvpz4+F5jPZDAkteeqNg7BG4YvA9So2Nqh3ILbxqU5ia?=
 =?us-ascii?Q?/O2tClnbHyMbrcZxVQ7LZbuv2PPOGtg1OZOFJv96hqqfREuY2SAr2Q7rplxn?=
 =?us-ascii?Q?FnC087Zg+ZQEFaRUeReZgKCii4popoNfKyMCtxN/xN/hmZB8wDbmZdc79XbK?=
 =?us-ascii?Q?FJ5fP+HXZVKG455SmyaDHxHgYhUKvhLDdo2UNM13tqQW31KOdBW0n3tvj9vL?=
 =?us-ascii?Q?LC69TA0Iqa8NwLB+VhkNdwodk8k++Hp6FHSH/PXqrMhfuHYyPSfBDVwHLslA?=
 =?us-ascii?Q?v6jUv3LsdK/+tsdyI3KFij5EhxUabrkygEz8QPYoo7SKjYSb/yrlhY6dtR4g?=
 =?us-ascii?Q?mqYqEnF45gw0tV5oq9D3yEdG9BgC6L5YMpS9dKQG03wFn6Xaof+8k/aTy1OL?=
 =?us-ascii?Q?i6nSvlH6t9cQHj+qjA8j6QL3nOC2rceUeRdQsAKWfsEFNsBmCZAG0cY2U3oh?=
 =?us-ascii?Q?GXHhTAXZhQISApvKEUF7ti7m2TLIQmvwBhB94tZIMyeavdgaaZuPvv/k1ZS4?=
 =?us-ascii?Q?JwqIT5aelWH/sWDIcPbloBtFpofV5dQvcuvhBmSceNl3nywYYuVCli/xv70F?=
 =?us-ascii?Q?4w3Rzo09lyJlMYi/aAAsVl2w4DqwQtaWPaLk/duTr8XAj+7BZ7GG5G6fQ/BE?=
 =?us-ascii?Q?QhfSAQN6sQ23MBAKlW+/sEOezBpiC2JSh+cLP+wLcye+/Uw9OMJTM9nTvPYx?=
 =?us-ascii?Q?BfOMS+K81nbn/of2L0ZhHbApeTO5YXH5HJJWrvZAynguILGT0Td0LMrlOD5+?=
 =?us-ascii?Q?Tl20YufKbzid+BA5wq33IV3YhuQS/fDQkmApr+g8deGxSALynolFmlCawL7N?=
 =?us-ascii?Q?r1n+xP/cVJt8aWfEnXoY4HlDVugRpQpk5JhbqOIugmjiCZRJPwjwuY7uGzuk?=
 =?us-ascii?Q?vJj9V6VPPQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edf5915-43f7-49ec-6818-08dec06681b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:19:22.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWzgaII9kL7kdRiXXsvgfi+c5Dll2ZdzQWk0fs8hTp0rY3CkQmM1ui0pFyMcgakDqlpR+3eH6hSeT/qz117eTas+svIYGaLWLVGSkiOe2BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0718
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[motor-comm.com:email,SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn:mid,lunn.ch:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,starfivetech.com:email]
X-Rspamd-Queue-Id: 3F51A62A179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> Add YT8522 100M RMII ethernet PHY base driver support, including PHY ID a=
nd
> base config init function.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/motorcomm.c | 49
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index dcba50007451..a202015d3869 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
> + * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
>   *
>   * Author: Peter Geis <pgwipeout@gmail.com>
>   * Author: Frank <Frank.Sae@motor-comm.com> @@ -14,6 +14,7 @@
>=20
>  #define PHY_ID_YT8511		0x0000010a
>  #define PHY_ID_YT8521		0x0000011a
> +#define PHY_ID_YT8522		0x4f51e928
>  #define PHY_ID_YT8531		0x4f51e91b
>  #define PHY_ID_YT8531S		0x4f51e91a
>  #define PHY_ID_YT8821		0x4f51ea19
> @@ -227,6 +228,13 @@
>  #define YT8521_LED_100_ON_EN			BIT(5)
>  #define YT8521_LED_10_ON_EN			BIT(4)
>=20
> +#define YT8522_EXTREG_SLEEP_CONTROL		0x2027
> +#define YT8522_EN_SLEEP_SW			15
> +

Thanks for the checking script, This should be BIT(15). I am sorry about th=
is.
I will send v6 in next week.=20

Hi Andrew
  Do you have any comment to patch 2?


