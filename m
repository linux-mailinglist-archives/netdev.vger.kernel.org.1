Return-Path: <netdev+bounces-288155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAbPJweCBmrnkAIAu9opvQ
	(envelope-from <netdev+bounces-288155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0272548AE1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7516F3065700
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813A3B994A;
	Fri, 15 May 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxun+qJe"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBC3B841C;
	Fri, 15 May 2026 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811344; cv=fail; b=Sexq45W4+2rM2PEkOeqUCNKLb8Vl1z4tbVOkzFfkzYuEbYRPj3DuK5t9np0Ydm7ZFBUuH7hfbBqDFyEpC3immuMySQrswGNyR0aN7MOhY7r0qZWlDBWva2bu1rvyOWYK8zYFrtLqfi+owFlkv7mF6nPr5WVExXGEjl7qtQVsd8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811344; c=relaxed/simple;
	bh=0iqLO8MU5RsqZU6n185uffguoF0u6ewGv41SM4a6Lxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DCuj+/4l79i/3QN1JJ91euACiouRNHEyqq5JfBR9Y8sExrWrSrihPVSvQ76zq04MPWn5xCvibvS1TqpBOfvhaucE2TLO9cs9Wb1/noog+Qv/6L/bo76t1EOUJrhwAFNBnUZKIz1c2FFrU9mkjukL3e9lZRCnEHCBsB/AkL85pd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxun+qJe; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ku0rrDmTPQER9zTZ3cNCfeHQKZ91dllajaHmfSUnzkMcIh3SLFBifuW3S4FpLFf5QKAT7iCezHWb92vg+ZbTuei4h5R/BL53Z7SN2unqNlAm7+tBjQ0lgGZG6xbNoxmc9gLsJdPvxaGZXnYgsqt9Z3WwpYW8pWbDuglfv5uJtucDOEwkOm//AOm5SILwE/GyuDUjBMAzk2gexx5rmso/AFgBZ6Zbes/k/94LOToq2AvH6JJ11SiD2x9FvBteFD19MCS8UmSe2ZJwcmlDAuthXGVbZ5T5PFHAFu4Hp51t6urXGIZC5I+kmwLPGbtkk+DnaF5wKr9ODUa0ArAWvz6fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2171cLCZGoVkUbTfm0oB0VhJ23AittkgWVlQV0tw2I=;
 b=dV5sc+gmsbojc3GRQViHqZFvXZ+WPLGH1myOUSlT3/BfJkwb3X2lRAOX+RxpgVbxyIgxjqgQ1unT8ckFBSTNJ5tuMMhBESg6YiDYB2+FkZpAGMqMcN7Er6kmu91DXxG2DF7F6v2VUTwc6OHGcc3GL7CqYy1cMCx4n/M4mml3jNXUBojfML5Iphcz4iTKo0XKNWK9neb3ViQhw+r6RZkq+juqbln8fMPHHgwMrkVihmd1WXrvYfREutblb06dspf6FM97gs8HTzt5J7oDd6n74fsRwoCOPNcvmD3EkqOSADDdM0yApNLcheuFVsOJh25WzBg7NAJLVcy6SrPPf+0KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2171cLCZGoVkUbTfm0oB0VhJ23AittkgWVlQV0tw2I=;
 b=kxun+qJeP496I5PEQ8nBf6TEQltnXWoa8Yieuiol4k7B6t9MrBPmfhKnLtnTAe6kI50PBVmC3Q2muIwh34N6e9afuxTOnJ0miC2wr0pT+uOi/ou3+erEFaM5RNTqW6UXAkw+5KmqlOA5el6lGdrufD80AA7xgIquuTN6c8FjQDATeevRlT0sGD50rchB9F1Nyx67X78AT/Ap7MC/ztlJNqQe1K1o58xKKO4YLSN7BmLdaB3yTCFSovGsR50R5/peMuQvvLURrmIi0q+o3V3mPlrPTQpyhVJiD76oKUKBAPWwHzVohF13RsHTgjnHaJ+WJFpWz1kFdF8WjOJKXEnh9Q==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV2PR04MB12607.eurprd04.prod.outlook.com (2603:10a6:150:366::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 02:15:38 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 02:15:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.horghidan@nxp.com"
	<catalin.horghidan@nxp.com>
Subject: RE: [PATCH net 1/6] net: enetc: validate VF primary MAC address
 before configuration
Thread-Topic: [PATCH net 1/6] net: enetc: validate VF primary MAC address
 before configuration
Thread-Index: AQHc4sc1mZ05bNCMQkSf6MPOYD33ULYOWptA
Date: Fri, 15 May 2026 02:15:38 +0000
Message-ID:
 <DBBPR04MB750086F8025E47A09DD46CF788042@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260513103021.2190593-1-wei.fang@nxp.com>
 <20260513103021.2190593-2-wei.fang@nxp.com>
In-Reply-To: <20260513103021.2190593-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|GV2PR04MB12607:EE_
x-ms-office365-filtering-correlation-id: d6db56d4-cffa-469d-6541-08deb227db4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|4143699003|38070700021|18002099003|22082099003|11063799003|56012099003;
x-microsoft-antispam-message-info:
 9vrelbyUZ34wgUYbE5FA3+07K6LnZmKNCgUOM4BT8BsjfDmXKh/8POojWqDKwYkLpHs9Uam/XllSLOD3AZm0jEfenUBPHJWyaatD5fZ9GCIn1SDwwIs4TRiB4/yyg/rUdG3/Uzg8R2xx/ECymyHOKWQni6VdHo6wfjYv6qPaJLboGAlbuav76GjaPNU9AEbZCodQbDikg99qP2HEchP4Gyxw8sKsWt6qQIWXlzornvkHKbmNLURb+eyxwSZj3+wmtENDfuSOmZVH+IYjyNN5/6j7okPsqacis/6z/SSU6Yy78dY7sqQJQ7WQqJThyGdLrm8jltpsE3E7Ta9GI33G3PsOWJYxiQOmTVNVYmpB6y+npTttWLfCtxbUYcDN3ilz76osBh/5S4MVas4lp2RAYAAnQN8IwPL9jhr03GjK2VLpuwiB2gFKHitiy34xt9hGc6AG6HYFoJUjo+g7n6IWNcYbtzdXe1g3DUV3MrTrBPuNdog8qZC5nVUwCfix2+xLFGgao+NqDwnY9nPV4XH3TEbP2MsR5fz91qAj5ywKbDAYRXG4cGG66ShX3QGMVOLGtdw2QHkS3t9+T1Q0PPuifUiUZW4G0O6YPzHw+hY5ESWL++oYQ1uJIbv34nHJY39l/Z6ygye2ilF5VO264udJy1uCk26wIllo/mhS/+ddddXnGQ43KBmS7uq4iLGNBidR9PQ/e6zGpgl9rew/GRqIbxzcxBBfopsdypedIWS7LiAEj5BYOkRVkRTax7dD0Fue
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(4143699003)(38070700021)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kOTSBOwX1mhVKut+XWhtT0xbYAQfxdw3ijsOHXzeLlKawDG95XB+DisDc6Uw?=
 =?us-ascii?Q?wKD9MR9Y+D631sCOJYl6PXf+g5EB+9sevTWnFwQSxkyWaDvDlglfMr7CpcQG?=
 =?us-ascii?Q?G3FYHB8fmiPxg6ntLk5DHOlelr5W2O0cuT/10k1o94wi1eeo9aFo2UBp2zUU?=
 =?us-ascii?Q?I+CJ/vUlJuxOytgWvlFOMeF1epT/ZCFJR54WrT0kqsoS0jFW3noIpxSFpdeN?=
 =?us-ascii?Q?cm2K/zVSOeXiezoSNcPdCRouf3RHHZpP6mr3yKq5tFhfkDqHWfDvDY0gkvHw?=
 =?us-ascii?Q?sKth9e6p24ojzyVjn4bHy720KguaOsMUNQlVpstRewVgeLDJmf9rp/iLtryJ?=
 =?us-ascii?Q?upwm0y3JQptu7jpjxEceFqa7FMpIClX8r+2u2v8w5EMvGZn96Qxqq9lm1U9Y?=
 =?us-ascii?Q?huc/HY5T9MO1w0qcqrrjhW4j5pmcWHSgw3ytv4hGj7BzBD72O5h2FVVtF0dt?=
 =?us-ascii?Q?/q1Qpu3p0rsN0FTlDgr74LhB6aIUU9LoFwSczsnh1FnGuQI3zTeWQHmOuSbQ?=
 =?us-ascii?Q?QPurEy1CjwEyrw/+K1A0C1Ft/0x3WHBE3z4cS4QIKsxLn33avYSNLZ38U/9t?=
 =?us-ascii?Q?7OEyHQtIXyspXiBvqKs+BGN9kP+61eW31mcFS3Pngib+v+CFQglbroSDRVd9?=
 =?us-ascii?Q?UzoJQ8bIDTHePIqE3k8nm950WvpONOYXjJ2fSnJUqg/4ne2toLGMsJGdohSb?=
 =?us-ascii?Q?JgM88SCPATYRxb4+DYkVhm5YXQL/8S3qSVazK1RE4H54i3OWgEPejECdGHVv?=
 =?us-ascii?Q?A9wiOWjVSf1BRLiIu+JbQ+ljiapLRNwcMsIPf0FWPdAh0cOkHD49tb70mnKL?=
 =?us-ascii?Q?Y+GFRMjxE36cG4fq9ooBmVVVHwzYouETYwnvMbNIgjwyT/3XUi42srEqLkyi?=
 =?us-ascii?Q?MdY3PdbvC74zIpolEftI6fpPJN539sABdHLkMGs5udkwDQGp9ONo+hS34aLm?=
 =?us-ascii?Q?fBX/7NAcbEHWMCs634VjhLo6QvYsWxXhGeQD/Euf523ZzV9w0fBmHOEcvBoa?=
 =?us-ascii?Q?eq18CUbb1ZqZuN7eKsTrExiPZXgcbyiWCU1eGUtNaG79kLrOrEnZ2F30+F31?=
 =?us-ascii?Q?Uu/3tvgVmn66f8DysGzz6WX8Fw7cMfEyzA3CnjUCMdNeAaOxtQt0+Jm33pO7?=
 =?us-ascii?Q?F+LWa+23zQpWe3bw43iVfDCoOWBiQd8imH6Q/Y1DUe3jnUgwx4Ko/dbRkcGX?=
 =?us-ascii?Q?LiDUvpOUdYVJlKe0XvpDt9xnK5/LgzP0kMV88VDxrrskO0Hxe8C1tYy5rDPX?=
 =?us-ascii?Q?QV78De+LKDBp/yEHbPbA0IQ8WZMPLvg+TNa5dQvvpjsgBJ7QPhBaikgxCjs1?=
 =?us-ascii?Q?Lt/H6JwaaeIBtQYiqUDU02v7SC0gyFQDDad+KqpPU4AeT94XiPz6gKMn4CkF?=
 =?us-ascii?Q?Y4DXMUq934Wu/jhw0rCDIQS4a6moPFlj+MU3TibJqLo/W8HCYcEjwey+LOHH?=
 =?us-ascii?Q?xo/nd4vQJt/HJNRld/u9bqz2/a7Nqgel0i9v68KvpCzbOJqUzjOOlKEPMD91?=
 =?us-ascii?Q?Bf+zv2EqJ4dwZOMvgF4YUMkxe+IBrFwyUsV/OoPjs3YRSOSTNrycmL8C3l/6?=
 =?us-ascii?Q?/WjwWzqd8Y7Y4VfJT2Yh2DA1Yu+A+nS6YtldqhHeguw3x7KWJZz/opzzWAn9?=
 =?us-ascii?Q?UwLnhouFYhWQXFX+eT9vJgmXsN1UDZTCcVgfg6W11RdeRDu2YYIdWVCqtKDb?=
 =?us-ascii?Q?byF9Nz+Cybtz01CXl8tse0fY5QAnDonu8zIUZ8Qcy873X8aC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6db56d4-cffa-469d-6541-08deb227db4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 02:15:38.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyT1VlLpTSp/jIM6wURooLlS1B7+ZcUeB0lpV1L+NF/wtE2gTjKUAVY+TKeNSvBU/CFfmvwaibjndjWpZbYQCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12607
X-Rspamd-Queue-Id: F0272548AE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288155-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

>  	addr =3D cmd->mac.sa_data;
> +	if (!is_valid_ether_addr(addr)) {
> +		dev_warn_ratelimited(dev, "VF%d attempted to set invalid MAC",
> +				     vf_id);

Sashiko reported that the string was missing a newline character '\n' at
the end.

I will fix this issue in v2.

--
pw-bot: cr

