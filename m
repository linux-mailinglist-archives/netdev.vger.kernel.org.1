Return-Path: <netdev+bounces-270536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFutIAA5wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:58:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6D2F2592
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF14B3056652
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F373A3E6C;
	Mon, 23 Mar 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JGhelRkK"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535B3A963C;
	Mon, 23 Mar 2026 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270525; cv=fail; b=hh1QZavC+ghGGLzSRz5bh7aPch58rX3mlV2dwdlRJpvdCrDmnZPnMNnqx/c82Zlm9mDAYW4Ypi6sRQgJeyjFldTYlRyUeIRLeJQNUWOd3nAMjgaWoVmrtUKbvbPUukihhQMLdj01Lf0vRpOcmkRHxZHGkD64NUU9XoK5A1ZxkUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270525; c=relaxed/simple;
	bh=v7wg0iztE88yUG792lc60yaTLWpSMDqZN3re59pqwtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TV8v65PuGbl4ZtZQbKR9QR6tyr8Jtr66FXTpDu1B4O/Y/ns8kPJq9rtUebib5lTVvsjsyOpPyyvXRgbFBbxQZQYFvejf5WZaOQM9QzCkZJXpfziOxZFkeO8zkEpCkraZLU4T8uLCafSdEYcxVF33aydpTBwGzduSqG6hYF1MPBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JGhelRkK; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHdQ8HULZ3rR4g7F0bkfSZM10rROvRD54jDZr5oJ28OY5JIDeE5YJZ7CkvkpwvjCjSrbqzLxkEASwN95Sep2oD70A9SLGa57df4L76IdjtxMj5VxpWoHjbS2GkxuS1aD45TmvUTsnDgyk3kdnwWJE3ELkUVo63LaHJXrFi1mssNbokVqayVEDfmqUBjVyhY6dWEwGt6GaSKJmnU1GACC3ud1DQMfzxEt39z4yMJi5oBu/zmnBV1d8X3sMWgBuehuTZPFJS5OzeKTDqkvN3gtYnRyohNp76JDPOnJZC61oTluPqa8eOHyhqWlHG9cIE28xF0MlDj/L9t/aDbKwTCV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gME/0buQlKuCAh/rh73KKoJGEq20p5WAPk9tZvT2YpU=;
 b=aZidFbPWq3y9hWD8U1p51SDVSiLCvVMww381gXIZHdkaMNu4YpVnCf5NniHP5EX9Dmy9FT9pNyJ79nOQheAuMWQERyFUarqFBIysGPPapu0FBWprDiY8eB64xt5Ju9dCPU0ASG64/mAqVhjJhqmZpmEmP4LB4z1QD6No+ke24XXxgThcJNKwMvkxDQhfE9boCkDCn5jitNGqdIM8yKOK47cuOBqmjE9ysumIymrGaiUOPbthtck3N4eztRqBx2SAT1rVR/BUpRfzVzqlHjLjBLQkcstPkTutI5wuJT4DVx5wOlLD67OM/+MUk8UoEdsPJTXW+44SdXrFMIyj5v5VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gME/0buQlKuCAh/rh73KKoJGEq20p5WAPk9tZvT2YpU=;
 b=JGhelRkKged6U0ZyUZy1oJwxTSrhyr7k45ZE0r85VVMy3lbEbem0b2TcbMqUqvSpx5Irc6F/7JqI7ATHGL1iFktpIktWMaILmbx1qI2IMFx9/w3ikewc1JhN+vUvKNOjV84z/v2tVjsLbBn7zzcfFUc1AhETprd9mWTUXWLNYsVumS9GWcwiXdwHiJvbusLwoyPsP1PrugyEgRTKMw6QrfhVx+qfIS5d07BPHM6PdR2QC+kIzxoCnE3eHFL8jy5pQLhDgPNigS+dmg2Fo9k3dAJAPfDzYNaVJGSJita+eOEEHAB6FJKdlghUuZFCdPXf7RLGEKV86wnFqqyArV4RiQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10300.eurprd04.prod.outlook.com (2603:10a6:800:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 12:54:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 12:54:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Buday Csaba <buday.csaba@prolan.hu>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?Bence_Cs=F3k=E1s?= <bence98@sch.bme.hu>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Topic: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Index: AQHct7lhfXWJmdf5eEKPBwB60hlOFrW8GKlQ
Date: Mon, 23 Mar 2026 12:54:46 +0000
Message-ID:
 <PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
In-Reply-To:
 <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10300:EE_
x-ms-office365-filtering-correlation-id: 1c5840a9-5991-42ed-eac2-08de88db5cb4
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 fr3P/J/HYZuocDZwRarQ6mMymBbVw6I3GCMNtFrOATSaOI7UIhp7Oh88CsqQDPFLongs5PHO3aBiSpdkmOWSBWGuTtqPLV9fQexQ2t45VBc9G276NWVB7wYjP9yDPvNCm5Wr+WyFNak/4/f/6a02q16QWWjXF/ptSh8vXTM1mHk2HbAaWxuDWJDhQGG+aQNHu4x4jQERefOI5szcFiiK6y/0WwJ9OdGU0LYeubQUmm/HVlWlMFJcMQ9a4LqInLyPa0LLmRocbgpHq7Upv+98RfSY+Ivclxa9aUEV44m4KiUDSuVjO0de0Jo+5YKpykvlweZR6TrhiBm59e9vgLu5W/uDeJIFqBV4vNdzC87atiRM1p4hk36njnzxrTshtwCsHWmGC2duPr7eCb/TzGEY3VkFvDo8XccnYJX9GGDahOiF2DL/b+I1n0U7v5gyKXBzVb03I+HlSg8aUpjHJu2QOxUUS5JC5g0ni8YYKj/RywlS/qwBdy1rSVsEPOYQwiZb0KIORcZBmNbt82xKMrmVwllKKICABiQEBhzjKt74Ax1pbxkStMqjX4s5cEF5tMN/N6Kt+NKKinL3UMHWTYEodd+cnAfiYLvOG2Rs5AD0CvASZC2Kgujo9OYZ9852qopg48Aze7xFcyJJRTCXEHqoTO6K4S/HG/VfvGj4KXWN+h5UVFZMKh+oy1je4Zul3VW+hiYIWeZDe88sdqG1kFgg0p2yWEgFaSktQnhJk3neE0uqgAjxzd9NgGDpUEa9bU4Jnxhqe3PhuPiL6yFjnrVa43a2Uv/RF/hROp2yZL9389w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bXjQvh4hJ7umGhBpT93NxuwR3IPrDFVMkJvbNfTYp24mUohR27zVoLksGd?=
 =?iso-8859-1?Q?wlLLImqsyjMdZ2tqqmsecL+3Uduf+tacQFlCps+J2u+GhMf0bniYn4I1cF?=
 =?iso-8859-1?Q?ANW9e2kGS+qtkKs2BnxEUnNoi7GwXcKpGjimjnqcPMZ5NvWYNsVnCY+wzr?=
 =?iso-8859-1?Q?5ewU5VjtZuKsk918oGM+9TYEE+pYUeVeoPorhosDq+mGPf9V1dmJkg1yId?=
 =?iso-8859-1?Q?oYOFn0QeJoh06JUQLVsHy5rQsoGiaf51dacDrjXi9FjCasrPdQcjOJrfHG?=
 =?iso-8859-1?Q?4s/kbSjLlplnqgDNb5RQn57tf8Ex3jUC/E8A4dMoHWLHwY3IJR1jMH8mSG?=
 =?iso-8859-1?Q?7P/ERAGHXB779pj6REyBhOE8gQjXuguOPfVojG2cdQovQ8eNbLI9+vcLfn?=
 =?iso-8859-1?Q?Ew2g6VKztxjZDIhdlHbZGFPqAuW9xNNkwChGkf+LQfRfCa2aeDZV5X/5YX?=
 =?iso-8859-1?Q?PF3uxcT7+j7R9i1l85NfGeKjKkv7YicNFrPvTU17fche6jjwudTQEYBsbG?=
 =?iso-8859-1?Q?q9lLQSLZbnUwaiqSrCOngSbZ5StDAaXP8yWoy3RYraPj03gCkbJQ0V2o00?=
 =?iso-8859-1?Q?sknwyjF++O5l6SmNMN/+CpSMMP9ONLMQKOX7N76YheJFGx4Gn+EImR7Ye9?=
 =?iso-8859-1?Q?ZSrWt+u3wjNP553Ce4fWYxqfjN8ylerIukn6RsKyzw+yD65vt4LoIgxM0f?=
 =?iso-8859-1?Q?nb446bNn1M+amYLqwsAPP3qwAi8mw6I044TEQERvTiRmA6e1PAzPo3uHgx?=
 =?iso-8859-1?Q?C0W8hoyIBeRtcFpxgWO3EEl2/a3Wf0VH0yZhQWOiFsRyxa/0cJEKALMZOq?=
 =?iso-8859-1?Q?joTFN0Wi8GDgqFFuZZQLXYreU8MfZxvu5S156QV1GcfQjU74SZ9e34kOou?=
 =?iso-8859-1?Q?oS1F4JKlFtk1ITEQYYPPL34TUDq/7YyJty5OY1L9pf64qIVjeTjmpaoHvq?=
 =?iso-8859-1?Q?JE1MAN0TADb+4dVu3SMLvQg2bjPKsXhXTetv0UDNSCZvhaLw7NKiqM6Gq7?=
 =?iso-8859-1?Q?2KT2wnh1d+NhYwPcHPESw4MsRFUab6JqQ4h1qsiqj98PNfTm1fIkT0mjEG?=
 =?iso-8859-1?Q?aAIFG+02rk+6s4ux0l47GwGbMm7l92crISUBH5Q0OsN+PQOV8JedeSsJZf?=
 =?iso-8859-1?Q?nMfM48XDpF7MRR8fLzmw3eXEPN84MsQqQBz+fb2E4Z2FrbqwUShOXLUcOZ?=
 =?iso-8859-1?Q?sQMgKKxAfbbC1HaGnvDeAHFMEFAMsHtrW1hEl+Fco/NInE49PgPDEXJQ6V?=
 =?iso-8859-1?Q?NOeuM/clUZENKEjXj6jmoPcozOr2/maJKFXKndj0M9FZy14W4JE/HpysGq?=
 =?iso-8859-1?Q?f341JtGxQYAEZ5B/R2xhhu+ZhzzUhfGxujTuYtgkpzxJM4Je7StGhAkJEz?=
 =?iso-8859-1?Q?Jr196oS4jPMYdjeSOeP10v8wOeFBrj1NVzPSQzME3gPWai6QfodsN5VZbl?=
 =?iso-8859-1?Q?eS9lLjC390BwlRwzc24ztEPppQTXJJE9msEGjcryqnuRQ4qKti40OFznKb?=
 =?iso-8859-1?Q?wOsPkV6Y37knCmd3rj4t1z2S5ms1P3VpeOLBBmmnVkybNpfsdYtZVsGzE3?=
 =?iso-8859-1?Q?Owk6jAbqPB8IwTZGAkD2YLpaJo7NrmlIQJyo3eJ7K5qWLj3XdI+JOR/3r9?=
 =?iso-8859-1?Q?SwJ1wzTx14qI0bsCwCS5WI5h4+LioZpBxw/Kd5qte2QPDHjiCVAmXpVJJY?=
 =?iso-8859-1?Q?UZ1o/aJ9K2qk8ELnC1fotEZjtRt4fIaUZyUZr+HxvJhFvCV4kr10ZRvkGd?=
 =?iso-8859-1?Q?MmHY/LITBsjv4EndExdZ//WfAN+ozZqr+oglTWl9s4vu1f?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5840a9-5991-42ed-eac2-08de88db5cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 12:54:46.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKygurFswTsL4EAEBl7Ry5R4239IbjfbjBsbz3GowhI/+VlxhvxYv9pTmMuoi5eLWZzD5oPRAEmoLvkIEfVeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10300
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270536-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sch.bme.hu,toradex.com,lists.linux.dev,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PAXPR04MB8510.eurprd04.prod.outlook.com:mid,nxp.com:dkim,nxp.com:email,prolan.hu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2C6D2F2592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> When the PPS channel configuration was implemented, the number of
> supported periodic outputs (`n_per_out`) was left at 1.
>=20
> This prohibits using channels 1..3 from the sysfs interface, since
> period_store() rejects channel numbers greater than `n_per_out`.
>=20
> Fix by increasing `n_per_out` to the number of channels supported
> by the hardware.
>=20
> Fixes: 566c2d83887f ("net: fec: make PPS channel configurable")
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> b/drivers/net/ethernet/freescale/fec_ptp.c
> index 4b7bad9a485d..1a7aa280e7f6 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, int
> irq_idx)
>  	fep->ptp_caps.max_adj =3D 250000000;
>  	fep->ptp_caps.n_alarm =3D 0;
>  	fep->ptp_caps.n_ext_ts =3D 0;
> -	fep->ptp_caps.n_per_out =3D 1;
> +	fep->ptp_caps.n_per_out =3D 4;
>  	fep->ptp_caps.n_pins =3D 0;
>  	fep->ptp_caps.pps =3D 1;
>  	fep->ptp_caps.adjfine =3D fec_ptp_adjfine;
>=20
> base-commit: 8a63baadf08453f66eb582fdb6dd234f72024723
> --
> 2.39.5
>=20

Reviewed-by: Wei Fang <wei.fang@nxp.com>


