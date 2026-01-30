Return-Path: <netdev+bounces-254976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDaSIJUWfGkeKgIAu9opvQ
	(envelope-from <netdev+bounces-254976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:25:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2AEB666E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF96130166EA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAC329C57;
	Fri, 30 Jan 2026 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CSO4NP8+"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B530F93A;
	Fri, 30 Jan 2026 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739921; cv=fail; b=YBeIIkDv+mAyHFEV1ELGsUDbdgFTnvZcUkwAvU2v3TCb61Uq6iZ+L1vsXvkbZ9qpwzyu4l8voQknNb7zWIoRrMvS62EXPz/oa9oZAoX2hd22nHymjMyXTdZhC0N5H+gMgvtF4NCAmv13jjvqT2BMN0KA8bAgzSJFSjiQmYV2bV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739921; c=relaxed/simple;
	bh=hChrxOrU1PaI/VmTo9LFrnePbeTw24+f6ARWLciP3k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+uzsNChmZ1x3RrGoom0bz+7XwLBNTXz71AraVx5VUZnwmoo/uyWcnDTX+UAWOeAZDPhnFKV9+3Y2ACgdArxwLKuJrQVBgQMnBs74fDaRMcD2HhWtZyRjnY9j34JN/JYo2x7LEoVyejrC8vwStj+iNtZbYwiWj/E7xlmP4GNaFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CSO4NP8+; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcN7Jp8SdjWepPdJ1eaiVWnKrmY+z8uf4735rxyUrsTkqWS4bEJl6m93a5qitFpEAOcQ/i1+Ffjq7c9K+XFkp1erqmcM4q95BdrEQ3z8kFGb3qKp60HeqPS3PtXJ9K4131yj2NZ7AkMCPmUduYaV7cFEGUmtgRImG92sk4KSQgRU/HTAzHZOQ3bMEGRVpa8+ddP2LbBWL38oseKwIbZeRCBGWdLQbcN6iw5eqdGtuZuyRVqoSy4kB5cfL8/gMMq9TwKIjp7slQ83Ik/IJRHzTDvGU/eEYbGlCcKIX1aHtV6SDUdnNw4euWkWr/QVN8NOFG9o1cdMBazWHBmGTfZ9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hChrxOrU1PaI/VmTo9LFrnePbeTw24+f6ARWLciP3k0=;
 b=TXGUqGttW+JGF5XChPSBKrSmsV8PGUNHTHIqNVyrkGpLcGrLjDVWMiUrlfuXFLyAIopZH002GScYmCxg+bEnwS0GT6jR+G7kyrZePAACX0U2K/+CB+Yx7UAF6lG1WB8TuYSN98p3Navh2dgXpc2cAjUyMCqK/KXWF61gJCQdVVm1NUOF7mtGLBvdsyVghCMZ4i61rCzOgD/YXnJVgFnDOHUOvZ/H9SG0AFTE4S9WP0IzMYaDiAI1l7PeKn4IDeGjWcGq8q+Zk5tvytHH1YYR4iiHQ+cZGrrZO99oRrLRR1KX5/mzvHkqwaBFn6iLtrrXy/sMPrR+chvE/R4j2cftnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hChrxOrU1PaI/VmTo9LFrnePbeTw24+f6ARWLciP3k0=;
 b=CSO4NP8+dXNGswVPTb0Obf+QJN5zzCeCwS2pe39lpvZKTZ3omzKru2a6ZVvXe34XQ1ekoNKAYxzGIIGG6rNkIQevpA7nFL4ethzUBJMJ4Yg6nABmY1rbEoYU5hBgFBlwG6mr+8Y0KKIcdGg15KhrBxZ2UvqmqMz31QLkNKo8LMGVNGfd5gkTEXkGi8EDiKEEHh0sevEJaxQcTm6VkIQRIV47UyvKM+SkcP/7hlFXruS+rdu7EL90qVmHR/a9nGEbwsj+KRD2ymifQJ5HT7/rQSN4TJs4MavQge7tkO6Wk3YB0/NJ64Y2L26JT8An6hcpmFnfZ1T21VbH4Rhc7wSuow==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 02:25:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 02:25:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
CC: "open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>, "open
 list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "open
 list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>, "open
 list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Thread-Topic: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Thread-Index: AQHckDsKb6XN63S+BU2zpU+5sv8m0bVp+9HA
Date: Fri, 30 Jan 2026 02:25:16 +0000
Message-ID:
 <PAXPR04MB8510831BD69AA3BE71E03472889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
In-Reply-To: <20260128094644.302313-1-michael@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB12026:EE_
x-ms-office365-filtering-correlation-id: 49d67486-c16a-443c-9a0c-08de5fa6ce46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ECjTcCwZRHEgVcuBvlE3+iyoXTOmAdTlYjJvP66KvFSROo8sNfJ23cPN8cAl?=
 =?us-ascii?Q?zyv16+ny8FqsybLTdT38r+dSJNHnmAm6w/PZF/T37Qm7bqgdsMMwI8Q4cg7+?=
 =?us-ascii?Q?rtCKkvzucHRVTLvDiyHA3Q+N+hoSA6M2PCILHox5fY30toUSCkFLRIsOMpR6?=
 =?us-ascii?Q?01iupmG5wGkiqZpaUDV21WrlaO0OmGzuvGe/d5cOxSED9WosSXLvTZeN8MF8?=
 =?us-ascii?Q?45dsWkkc5iCOD9gDFuiDKjq3X5A/KvRYZ//cLB4NrUsJHq6rZ0YdeErFYHAY?=
 =?us-ascii?Q?wIjHnFCTlX73D0EwnZ+CtI4GpizUxeOaDTC8c5GvBWbdf72IIj6Vl/MU8rMD?=
 =?us-ascii?Q?U8EdRAujwuaJh8gCyjRQ9ECl6xwMNIt86o4FpOaz41kyNoYc/RT8S6RJ7Fle?=
 =?us-ascii?Q?eyeAzLGFkmhK7Lrkr4fjxswChixwC8YT9IpVBX8QTJ1Mwe5lg3cX0tWKdkbr?=
 =?us-ascii?Q?gw2mkw4axB/DbbEW4Yx9egieQuVHZKjUEN2/1t89ddgsELX/JzIghmOlKswm?=
 =?us-ascii?Q?ZsKa2je7+POYTkEHN7kb6/rHOtToCjTt8WpTBkAA0ig/8DwiRbO2M0Tj67NN?=
 =?us-ascii?Q?F0RKNlaPSJX7GWZHoNRv04IFtYATydxMmGDvCnfp1tF6wdfEdRsFoAICbixk?=
 =?us-ascii?Q?xJm8NaVIYY4ScAb5At5FM7OlsBAGxoKLZvqewokbDMfbMVsRt4c4jVa1NXch?=
 =?us-ascii?Q?4MLe0UFKZ85EejN6diqbV9HrlnyJaCkyI+y8i4NcZtWZbyNvCL+ibfg8xUeg?=
 =?us-ascii?Q?lemsUy8sjQjkN1qEQC4DVxVKCGfrEAtLnK7vRrjDTHVUQIkoa7AfRP0Xis6w?=
 =?us-ascii?Q?irWKOc7MzvBnLtXeUYWGxlGgYjeiX2NiXuBdoNVD1i4LNByqatBsl2tRTR6a?=
 =?us-ascii?Q?vhEEkLIJiFMrBt+HP6ESrrnU2u4SK9wUbgTUQPDGFdHcGNB9IZkHukn6kU4D?=
 =?us-ascii?Q?lk5d4HtOQqtvZrjWXfukqiC6YaPswI9LEw25Sk30F7y8DP26ZuSDQkvJou5q?=
 =?us-ascii?Q?bxmKy7aCnV747xXJamb/sF+My1R2rHij4XmaqrIYBctwp4mpxkfpKs4HQMdK?=
 =?us-ascii?Q?c0CcTSGq97zUP+WdUhBUVv3ey4EkcWv1XG/ZzDLkl4PgZORDmfsszetcwtzh?=
 =?us-ascii?Q?OhvDnF9kLgk1gAuZcWscCu6I+BXvkK/WuPu7gA0Ty132osRtM9auFNIAnmOd?=
 =?us-ascii?Q?eEogObRff8kcqNaQ6Tn2xz2NC1wb1780gZanrYlSgwHRKMeQChDX3PImbyJc?=
 =?us-ascii?Q?Vuz0oMadkLQ2MuhIJiOTDhSh5/X5Q53LCQpuCZoTcPLE9+agQNo/yXZMd+zZ?=
 =?us-ascii?Q?42q19swwzmJqMhZZIY4ITBpeed6PRS8Lj4Cw5l1Se27q09IJuHF6jNGlRE39?=
 =?us-ascii?Q?6N2L066LUgMpMSxB5y8nw+cZ0L/I6CTul7LlKuCE62hpOW+BxOW/eM80H219?=
 =?us-ascii?Q?LMsSn+/ZdTYdsj+jWrnD64y9w1LJFLB0kM4lZgppstydxKPksafHKPv9pRf8?=
 =?us-ascii?Q?OvOH82HiOz5eoa8iFJwwe96fntFJUU/OlVh9giI0tiuftmnPhii8e61AwZN6?=
 =?us-ascii?Q?Xz0rr0tVXC1/AJ6zh3v8AcI0A/n5GMRyjUB/08AYFtzLVenwRUSPF0DtVtcd?=
 =?us-ascii?Q?OYVq9btfxANd17r6IYOng4E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DLmt5D1Mv4U0/Py4SVg1IJcrzYCkRmpBlajTOzNM/+bBeeJVDnx4rP1GhFzP?=
 =?us-ascii?Q?gB46xs5dk6ocyoavyK0W0G+eylALUle2T5hVxyfKPr37iQdB4FvTkxbjKntG?=
 =?us-ascii?Q?f6r+9D9VSksYci8kaZnS7VkAviHI+pRBQmk86YpW0Ek4kn4776P7wbKbD0JY?=
 =?us-ascii?Q?+7S28D6ysEbSvup2EqoAYGztVHyOvm5LdcEibErnPkfrl5EeFrCg2Vn67m5n?=
 =?us-ascii?Q?hfgkB9zAfLoE+OqsQIF5rXrqiic4RBd5ptUKtmSqCzG6DKTL7wM06+OhBqQw?=
 =?us-ascii?Q?9b4HO1OV3jh1B3panVxx19yzxhcqVzRchwDLNbNkdUrp89bxMNNBSABcUcK1?=
 =?us-ascii?Q?xuj0oqKq9LD+UXZhVde5w2044Q6JQvxWVA0SopjNKje0wIvRJj2NvrzF/3fH?=
 =?us-ascii?Q?FKMOF6Uel3xgxrVuL2xNVTOT+XUp86+jrTNyKoWhPIgIKNB+s4xKIjYkVncS?=
 =?us-ascii?Q?OJQQ96bN8sdP7b0D8sfLTcZEwsKxxvudeFg8oFzMoFnL5bGqsJ5tOoO4LirD?=
 =?us-ascii?Q?aSLv4QqdPXzqwHWtBrAhF6aXPM/IY13F9BDj5d54d6FcBoXVx48xkIq7YfQJ?=
 =?us-ascii?Q?gGV1FLwEL6uEueyyGG6FLxZBWNrSm2qbRVnK1FITCPsbwSNyHn23lfTdFGPY?=
 =?us-ascii?Q?T4ny4vSLRCfYYNihAVNe58/PAOY+aEsBpxdeoMnCKDz3vRYkeashfQcR6VFV?=
 =?us-ascii?Q?hLW5VyQyk+u2Vee3lVRV3RWdi/S9lGBt2US7HkxfFePID1GxR+td3mFDrJyu?=
 =?us-ascii?Q?ZHrrNB86FkZl3b8JFpQ4wWQ4ppIsPJblKMRo6MgeRw/Qisouj/14Go/M7Jl+?=
 =?us-ascii?Q?YEGipAsSK0GDXnN1olU+4IwjFJTOVXdw28k2YVkdzKIhyR1m+Dmzlj/TH5mm?=
 =?us-ascii?Q?MG3+RJF7KZrNO2sb6+HD09cseWBV5KH9BHJXdNW33ElOYPBGkGqZNhi7Qnt/?=
 =?us-ascii?Q?hT9WJYZFAiDRHuD8AKJIIpB+ybrJT7frX2r4p2ihIAvwqOhcF2aw4EykMv9E?=
 =?us-ascii?Q?XbygySMLyTDSBvAYNyP/UdXpdFuxMJvn+lBldYIfrQyY32N8vvY5byycmEiG?=
 =?us-ascii?Q?HpVzV4WskEM+tYjlCJWUXNt9r5Z4RPgk1rVJ/x8Tdb70Kd8cGixHIoc1adcb?=
 =?us-ascii?Q?axevQlPNVpUySDCh7CFOlNjDwAokfZfrz/q/3S3/fb4l2X4t/shGq3ErDf1t?=
 =?us-ascii?Q?jmtiwMYPCUMyALQE/MtpqaThkPxxiDOy2jH+0dKTFGiyoLMdkdF6TEvujK9j?=
 =?us-ascii?Q?FhCNZ2Kestz8dDtY7+493NETvXAnQ3TBlyP+rmsxVbGW7uDNn8r9mV2HQYjt?=
 =?us-ascii?Q?6zl9d/Cu+elrKd5GqjEP2wuq9G2iMItwECmVtFL8f0uzqoshKkl563Eif0K2?=
 =?us-ascii?Q?c9B1vN47TcOItt2PZxybXTp/wpIJUkiQWtt9BCepdLdvMKqNGYBbBGkixobf?=
 =?us-ascii?Q?N9JuKUzzASq9xa7nNcMLTxCCDB/cscykYqg/W42xw+rUsuxEMmQ+VJc7h8Ud?=
 =?us-ascii?Q?1hGAAskB76RRRRQ9nrZclR3T92Icf6e2JK4BoU8SzFEleQkewGgXyAxAdoh7?=
 =?us-ascii?Q?5VrckV1YHwQgK0NTIjSyK9UVfPcSfIJFrq2+Tk1Y/md7ttC2bVBY+yoRsW6g?=
 =?us-ascii?Q?2L0m25Csckc8pRHVJlC1oIOX/co4DeRnXLHQ3wFPj4AgmS9hqq628Gad/4hc?=
 =?us-ascii?Q?KZI4qGkF0GDH/TgtxPpzCK1JbP57gsATJqi+2UbHO3WhZyCI?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d67486-c16a-443c-9a0c-08de5fa6ce46
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 02:25:16.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVXYAYl+T2RrNS3rf/ncmqdmDgzpaKDLFNZYMXKlQ+Kj3YzFzYwyzFoeE6RnxHG0SLY6MZh6dl+3YqlzEx85IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,i.mx:url]
X-Rspamd-Queue-Id: EE2AEB666E
X-Rspamd-Action: no action

> The current implementation of phy_reset_after_clk_enable requires MAC
> drivers
> (like fec_main.c) to manually track PHY probing states and trigger resets
> at specific points in their clock management flow and was created just fo=
r a SoC
> vendor. This leads to fragile code in the Ethernet driver, involving comp=
lex
> checks to see if the PHY device is bound.
>=20
> This patch proposes moving the handling of the PHY_RST_AFTER_CLK_EN flag
> directly
> into the generic phy_init_hw() function.
>=20
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>=20
> I need to test better some boards that need this reset, but
> I need to confirm if the general approach is ok

This patch looks good to me, it is more generic than the previous
solution. I do not have a board that uses SMSC LAN8710/LAN8720
or other PHYs, so I can not help verify the solution, but I think it
should fix the issue that reported on the i.MX platform. Thanks.

Acked-by: Wei Fang <wei.fang@nxp.com>


