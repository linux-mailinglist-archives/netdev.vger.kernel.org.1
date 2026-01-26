Return-Path: <netdev+bounces-253310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDQ4HlTTdmlsXQEAu9opvQ
	(envelope-from <netdev+bounces-253310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:37:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE683838BD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40B1A3003EC3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1C1E1E12;
	Mon, 26 Jan 2026 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UHbGAAzh"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CA38D;
	Mon, 26 Jan 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769395025; cv=fail; b=IJIAFPukL8ubisJ0Iv9vro4w03B8uttqWfAFQoKJdAt/YvCLDDpscwst04AHui0pm1HjSgLWMyqqXr54UqdKMe4P6d/j2MAAlBEYyLSc5MFMLHHwyEhRje+EA+PCYUqCRE+EOBJqlWtp8yngGogbicZE7f4BMabn3SGEQ1lOr4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769395025; c=relaxed/simple;
	bh=RNM0oJwOGP/Gmq5fZu/Lz3E3m40/FPFN95+NfcHEjcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vsd7yjpJO0dyUdFbUOrt8+S/eIgDAFwjqSpDgYZraaxEzDz02j8jmx+SI1B/PPBJuE4LFpU9BJncyPB8Oz0NI6bMMCE3sFv4/F1eF13Ckyg9kdUMS/U7ji9btBO3OKFyK4MB+zw0CUwGPQkqlQR6TmryJE7UYZxg1oAcM/+YQ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UHbGAAzh; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnnfFGBJF5pTNA8No88MZ+SD5lHZmuc8O+vpF3Vxi+lVV31VU277MYS4aqs4Ea4J37tam7DwYO6/3Pw7jHBKzUKcKCZMmFN6SFdlaSchIQ25fpn7KfEe2r4kkxBPQTas1NIzk8t6xA4fNU7s64UAC+5C+LQAjt9B+yQRqMruzUSU7Gi9fVtitC9Ldghyqni1p3qIRaySUztTwZnWnnhJNRBV1jIKAIYLvHd2CpLm38mCre0s6m5VPqkSB6l/0loLJoNHB9/dZhZ+yZq3Jct52fw8HRp5AtGTNe2dJoTaxi+4mYDr5pkopf0ZjLzsY1ZEwLFHOY5VQjZndcAo4hsPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyyh27f9i11UQm1D3TW9E4DoTlqpQo0W3uNtSCU75c0=;
 b=YZBXnMxIppmzDFNAEvqwa8T+tttv3lhC4ACtndcQjCTDIrxECyeyMR8Dhe9f7G+v3Z+tiS5qv2JYv1e3vpZ7y2xtTLTIrs0bMK+pd270aHSBz8DmXIOWf7r1ZSZUSTey5xEnYrY4qR7qC68yxAqMAuzyz0jDxZL2GTK5NK9xojwEzUPW7v+O8mwdF6zLzDMQPSu9hxu3hdj7HB9ewu+/PLncf6yn9hYv8mBcr4slX6B2BBK0MmwnLZd+HJS9+He93mBnbIP2pYaIdN+Hma3hhEruWBx80pWV4WhY+H5loOmeSZZgJFXi78AFuPC5hcU5fxoEpyz7Q71hlCMkWhBk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyyh27f9i11UQm1D3TW9E4DoTlqpQo0W3uNtSCU75c0=;
 b=UHbGAAzh2PfPfokdhuVee7uEqqLtyXq0WDtAhuh+HT+EG78lh2lB5sJC7FFF2G/TO3EzoXD4YIOYnY9rR5NLD3X3uA0o9GVNzifyXvtlKtNmNrzq8ZlpHQqY+omPEGOdEyZ87aYMAby8xQYKxLvUxRbtpocC27CilPrkBVWm1odhWN4c/hFwn+rAQUHVUjRcxXqV753/8WTsdq94c2R70TESwCvsO9K2OE7b8jYQBH6jbKjNuGwpwNOYTL0y3GpBgKZ8exaAA9xlGaGu/eQ/6e50XGfZdVpm8hRilH1AO90178E9Tai1fsC8TRQr6XaKNAOhctTTRsx91NK3BmYtOA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 02:37:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Mon, 26 Jan 2026
 02:37:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Frank
 Li <frank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [v4,net-next,13/15] net: fec: add fec_alloc_rxq_buffers_pp() to
 allocate buffers from page pool
Thread-Topic: [v4,net-next,13/15] net: fec: add fec_alloc_rxq_buffers_pp() to
 allocate buffers from page pool
Thread-Index: AQHcjkPqe+m8Nrdjo0aq7BSdlPYWvrVju4rA
Date: Mon, 26 Jan 2026 02:37:01 +0000
Message-ID:
 <PAXPR04MB85104AD2673A1D58131CEBD48893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260123022143.4121797-14-wei.fang@nxp.com>
 <20260125214519.3384279-1-kuba@kernel.org>
In-Reply-To: <20260125214519.3384279-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB12302:EE_
x-ms-office365-filtering-correlation-id: c69d9571-3e9f-48d1-65a3-08de5c83c8ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dWRHKnESGNkMXdp9+q57T9LAdDO8Y1DfV6gY2DllKfpIN75QAVM6JvCeWkIW?=
 =?us-ascii?Q?DDR3fcf0ZfYNDW0N6UozNpo2po3u+0sLrC9wO2rbUNEWWUNA30vn1qsmlpGq?=
 =?us-ascii?Q?SFTh4tc45iPx6LhaSQ/y99sdveGvAezWuFomqQmgltMGSnIKe6Q6VoJ02msG?=
 =?us-ascii?Q?9YhkCrcOSFp2xI4qn4eHEtozJ18np1DU4RQFf7V0MLZpxYqq0OE2Qu+w1Woz?=
 =?us-ascii?Q?f7dLl1jjmlSPRLogMtiUWbRGVzONuPZBgA+UHB9D4j9HORYEl8KpL4JeBMqj?=
 =?us-ascii?Q?4GzD0mQ/u3Tkn7HxjUa/j2iDgzTBgRtbgvyn9BCTpdN38Mjwmi3Qp75c7tut?=
 =?us-ascii?Q?7duZAsCvzlS9OWYyFfwDFJOtjpxzml+DnKXECFqKxBctTXBY+/GRMaOxj8Ga?=
 =?us-ascii?Q?d2nJTrYiso4Im03TXgIBVAYNxCY9ncg/S9NS3eSNmO70WlGIXRbUMtQHkaQW?=
 =?us-ascii?Q?wrN2Y9EKMoEffz3UTBXbeObvRxaxCS7UU1MrVj5CZMvawP1t7bACoS0IZ0Mh?=
 =?us-ascii?Q?HjV15hP99U5HsebrIwFLGIcLDKHGQdfhJS2sSTZeFKbzAPd4NAwuA8OkwGgp?=
 =?us-ascii?Q?inaKnAKfksQ0UlJjBU/GcRDp27vvCKoF9fLMzh/OMpjE2lhwsS34OV7u+9ml?=
 =?us-ascii?Q?7Ar8KdOsJyOuMx17T2w/NNGZ2HQKVvBCX+Mo6dtJ9Y1v/GxDCqMh3xZkPIIB?=
 =?us-ascii?Q?tlvj46a/rg8jg4EMavw6OaiBepvxtu9bmFsK8NJvoDESvD03BRYoXhspLfo+?=
 =?us-ascii?Q?dmWqXWDKQjdzOEQ8GEeyV3NZvyMJj5TxUfsq8kIYGk3CWrXg+0CvhrYf7W9a?=
 =?us-ascii?Q?1a+Cte8s/bLWu/eGz3CmJmWQEQqs/WjKU/iQKb9++sPhSkZIyAfZ+Fh0SJZe?=
 =?us-ascii?Q?+UYFvn6Me6D936u5gQqOtqTqO46VVZI8jLJRHybh2+vyzuJHgHR3QGqDA9q1?=
 =?us-ascii?Q?6UFvpawpe2GRQBMWSfO2Q+dePaB+gPyNdZsJRS3NeJ5MYvor4SruHw9WW6K3?=
 =?us-ascii?Q?/CRC21wuKirfahi+pVL3D02RbzbI4qzj8AdTvaKixdLvdbnAoLlh+WR3R9nU?=
 =?us-ascii?Q?iCzNYXTtkxA+J76BBjnehP5sS+Pyy7djQPdC/CoIra+fjLnU21BukDyuMJkz?=
 =?us-ascii?Q?taqvYRgRGwi0ImQhrI3yVIxo34CY17vZYVbQXvqlroBFWlvYFPEa+t+h4e0G?=
 =?us-ascii?Q?b1khRBPbr4pG01vMeNVhkB1NCeT0WlRerhkk5p2j9NtFY0ozAdrJJtaNC24D?=
 =?us-ascii?Q?wHUW82hHwlmOHJtX42cMSPMNa8GPGRkDIivp0pLN4wHxm9Qb5hB6+WPEvTrz?=
 =?us-ascii?Q?3nBtWDiDnhIg8usy7QTOM4YxeMRT81O5qqfv/V46vmhj3ZOBmy3P5cRlBcV3?=
 =?us-ascii?Q?0Mun7GWVhCcgINuT658HpGntBomJrGgmHEkUYYVyj0V1ykxB4wVd95vpyiA5?=
 =?us-ascii?Q?A6ZYdK7ItmvqX8a9AipGfEB+Wj8jd9WLp4RvmFxHW7iI4ALWXWhuXM+5Watf?=
 =?us-ascii?Q?EzggOkf1Dl557m4biYbmIu2I1vyBsxLnVYxfIJfl7hOgUyE4XLI1/5NJYrI7?=
 =?us-ascii?Q?sDZethorFTfO7wwrylN7JkfodP+o1KB6d1dmlKA5SWBcTnDG7hThn94QDTO0?=
 =?us-ascii?Q?9/z5R6VpyOrmNicb/cLOdKQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jh0Ml3BK4Tg1ph/NP8z4FSokZyOhu2lTxWmeRz1+PtV+IlFYt5816Ew4AM39?=
 =?us-ascii?Q?hSOsVOZh5bG4CLq0reZbFZ3K1dHAbzjkyjhLnhcRpcMjNZ4t9lGoEwW4NC+y?=
 =?us-ascii?Q?x3AosZBo3Xu5ggJpr3rnKBnUBHvtV0rYj4TWSwuosGMflkthxuiLksFY/N4R?=
 =?us-ascii?Q?UuJGA/GRBIGRCQLe/RWgxxMHuaQmtuuqU26aj3ThECwkAhWtVOsknGBok4RX?=
 =?us-ascii?Q?8mbUnVPejQlFUGjzMZgE8sw6Trp4QMo/xSyEWLNafqk0yvJfN6UbWV7mAsnf?=
 =?us-ascii?Q?6OOnHoZvVzTntvMrsjtQe7TBclW87vjuhVxE6f/lWBFajCdY17Stwm5HkSBS?=
 =?us-ascii?Q?LMYtHTG1nQ6Fd0yfDLIlROhvxq22EZeeWo8SykHQHH+cMJtLYYWrANWcQgbU?=
 =?us-ascii?Q?ZFkviWo1O9jXPAReXyF/4PQ/U0RUl26ecr3WihWdvvU8mPU05oQ6YpxG4tze?=
 =?us-ascii?Q?vF4mscG2s1nmz9wMup48QBJR/uDb44SWpqaetVcW+b/N9m+kz/fJqFdswo5z?=
 =?us-ascii?Q?b6gULFuvyDLSaKPPmufCK2rBpg7cCC1OlVf0s13ui97opRBcj1pp3uBOXIUt?=
 =?us-ascii?Q?f+7HAI/9QxEeA+pVdlzKK5ZfUPHWI3LfPezwB2EEUljDtzLkvfzqxdnFs/47?=
 =?us-ascii?Q?hJSfwgDKYEXvfEZOLtZOs6UyLb0+WK5c6RET5mvIuEQDH41fsqGbwb/QcFWg?=
 =?us-ascii?Q?lG9Xx2JsRQKl6V3s4aU5kXLxciaoEWDUcgRZPKJf+xYv7Bfi3WATA93Uckvr?=
 =?us-ascii?Q?qgsbTV/hVpYioNnT7aDOJxiJrqqk0UN/xO7A8CrdWothXEs59TeS40HsUPDY?=
 =?us-ascii?Q?WyH9SJrjclIglF+XNpwklzy2J/Fkm9e9iWUYiz/fPOYwDE3l0k9cy81wS5iT?=
 =?us-ascii?Q?kDZIQQi7cS9V8N8ICbLI5JKOktxVSy/z4AxfIzYi1+W2gsISBjQ2h0dKiQeF?=
 =?us-ascii?Q?p6ohqX4g249PYSSEZVc1V0yotdd14UoMVkS2+qf8soqh4QmeKtIQO435Qs1g?=
 =?us-ascii?Q?P9J2Xh3efPqSl8FrokAycLbwhZCv7foB6QfRxJLk+qHRl5DGqVA8eub8i7tW?=
 =?us-ascii?Q?JJK0QApGL6ALOzvkXpEZqnm1LrDZ4sxoRnuKNke1/0Mt3kM2+oNHW+O5pL2a?=
 =?us-ascii?Q?cHgCbPBFAQbKKmo+yYKZg1fBhPAqGd8F91I0UdojWaFTVCLuSLy+wNL+cE0S?=
 =?us-ascii?Q?IP8rc35J2v3MZQ+3Tt3h/+6jGO9kIavKt6bI5BvQxtXd89E4dW/ujiHBDTcs?=
 =?us-ascii?Q?ssz/oSj3tDTPM3g4VqjS1tfyG/LAjujRDW4pOrwNBljWD2EWQB5c1qWwL+NK?=
 =?us-ascii?Q?0RsyDj4HIp4M5iw3QXu/0E20gmY1fLCDO49U23nH72qudTrThkjDFiGWP0l/?=
 =?us-ascii?Q?j/k8q50w5WLxp+3472xBAyH58RcnvbvuSqjCdCLoVS+uFKeshU3Ztf+bVXFZ?=
 =?us-ascii?Q?ajCIYBl3WKAMGWWZEf1AyObHQlfVCaVNboulZ8hiu6+XxTOY63DyNkmYrW/D?=
 =?us-ascii?Q?hXarxBqbJF5q5EzrhfEM3sxfcIUZDVjfh5VAe7bA4OEZsHDja+vmyqgmUmSu?=
 =?us-ascii?Q?KHb5ONWM2O/4b/RDFfF99hoEWVSnLu8qrG/Fld1U1cMRnK9qS3C33RdnUv4z?=
 =?us-ascii?Q?KA9DL+sQPrDOE2RAnqpkovvniOIxTViIn68jMirFAQI1vcB2x8ZDGn+W+YH8?=
 =?us-ascii?Q?sXqFR/dCt0aF3n4A2yR0TCx0HiuB7OxN3w7R3NCYTsgFVcrH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c69d9571-3e9f-48d1-65a3-08de5c83c8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 02:37:01.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8Ne3olumHmQX6MuxsssBjP1+/zWefiW5ORGql2qBPlmQugcyiiJN6fccviC2Qvbxf/7j7k222YqESCCRngbdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12302
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253310-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nxp.com,iogearbox.net,kernel.org,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE683838BD
X-Rspamd-Action: no action

> net: fec: add AF_XDP zero-copy support
>=20
> This patch adds AF_XDP zero-copy support for both TX and RX on the FEC
> ethernet driver. RX buffers are allocated from the XSK pool instead of
> the page pool, and TX supports both frames from AF_XDP sockets and
> XDP_TX action.
>=20
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> > index c19ae60b04d7..d3e54dcf6a4c 100644
>=20
> [ ... ]
>=20
> > +static int fec_setup_xsk_pool(struct net_device *ndev,
> > +			      struct xsk_buff_pool *pool,
> > +			      u16 queue)
> > +{
> > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +	bool is_run =3D netif_running(ndev);
> > +	struct fec_enet_priv_rx_q *rxq;
> > +	struct fec_enet_priv_tx_q *txq;
> > +	bool enable =3D !!pool;
> > +	int err;
> > +
> > +	if (queue >=3D fep->num_rx_queues || queue >=3D fep->num_tx_queues)
> > +		return -ERANGE;
> > +
> > +	if (is_run) {
> > +		napi_disable(&fep->napi);
> > +		netif_tx_disable(ndev);
> > +		synchronize_rcu();
> > +		fec_enet_free_buffers(ndev);
> > +	}
> > +
> > +	rxq =3D fep->rx_queue[queue];
> > +	txq =3D fep->tx_queue[queue];
> > +
> > +	if (enable) {
> > +		err =3D xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
> > +		if (err) {
> > +			netdev_err(ndev, "Failed to map xsk pool\n");
> > +			return err;
> > +		}
>=20
> If xsk_pool_dma_map() fails here when is_run was true, NAPI has already
> been disabled, TX has been disabled, and buffers have been freed. The
> early return leaves the device in a non-functional state with no way to
> recover except manually bringing the interface down and up.
>=20
> Should this error path restore the device state by calling fec_restart(),
> napi_enable(), and netif_tx_start_all_queues() before returning, similar
> to what is done after fec_enet_alloc_buffers() succeeds?

I will fix this issue, thanks.

>=20
> > +
> > +		rxq->xsk_pool =3D pool;
> > +		txq->xsk_pool =3D pool;
> > +	} else {
> > +		xsk_pool_dma_unmap(rxq->xsk_pool, 0);
> > +		rxq->xsk_pool =3D NULL;
> > +		txq->xsk_pool =3D NULL;
> > +	}
> > +
> > +	if (is_run) {
> > +		err =3D fec_enet_alloc_buffers(ndev);
> > +		if (err) {
> > +			netdev_err(ndev, "Failed to alloc buffers\n");
> > +			goto err_alloc_buffers;
> > +		}
> > +
> > +		fec_restart(ndev);
> > +		napi_enable(&fep->napi);
> > +		netif_tx_start_all_queues(ndev);
> > +	}
> > +
> > +	return 0;
> > +
> > +err_alloc_buffers:
> > +	if (enable) {
> > +		xsk_pool_dma_unmap(pool, 0);
> > +		rxq->xsk_pool =3D NULL;
> > +		txq->xsk_pool =3D NULL;
> > +	}
> > +
> > +	return err;
>=20
> Similarly, the err_alloc_buffers path cleans up the XSK pool state but
> does not restore NAPI/TX or restart the device when is_run was true.
> Does this leave the device in the same non-functional state?
>=20

The current driver does not support allocating the buffers first and then
replacing the old buffers, so calling fec_enet_alloc_buffers() again in the
err_alloc_buffers path may still fail and potentially make the device
unusable. I will think about how to change this situation. Thanks.


