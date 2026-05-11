Return-Path: <netdev+bounces-286437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ypu4EwZOAWr5UQEAu9opvQ
	(envelope-from <netdev+bounces-286437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:33:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE9507A32
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E8933007662
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840836CE14;
	Mon, 11 May 2026 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k4MWLbJG"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790761E0B9C;
	Mon, 11 May 2026 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470402; cv=fail; b=cG2VUxHJUv5TsCqSo3ZpIX+zbN5qZ0haQU9vIq9KlujWGyO2SkN+Jn3QPeW05y5ZQjg42TKvkE4iHybfiWvlLFPI6BweaBumP+aJJxxXeI++6k4/WQAzz5IkaKe00Hefkg+4hZKGZnWbr0+36bdrxYINmGqNopmVBhfoyvej+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470402; c=relaxed/simple;
	bh=jrCOX66ASyzT4E0NmRJL4DXGgPBEXoBb7sQm2jj59C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcRIHAUMCHpGq9v3qAURLcZ8iKRwTHz6hb+ije26247r9XLliKiD0DoUE1Omo08YEYPcBFMaGMYVik1a1z1XQk4RbuYzfXjVP03rni2H9q3ZOGsUHGlDhff+mgl+MytP09TiOIXJhopOa/9MiMZstAH1H2W9c12wOK3wxHCcqlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k4MWLbJG; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqlUZSoTbhVJ90e+cHSuOo18WftLtK45S3jUBjAgmHIygMt6KY2KacvaGmNWmWSbLsyOHhg2crKJDYYL6xI3CsKmzn1JffCudMD4R+5FKdL6SgPdlv+aIgKNvp9RQ3i/MUUjtNn0eMfz6m/fd5ZfzVEJwdhbdj0cdPF0xZWMEAHIejHUppW09fey+aBvCPM4dYmIDbsvvynnVjWZEWlv45y+oLJkAftqH+9s8Km4qzk+DxBMHOSmZ6ev04jbERbjtoqw1WUrf0ngqeyzAA04h647HsFy17nhJ7pboFRsGZw+TARidtPWyEj/pQCZVCV8xEUOS/hVtOZrZ3xhEPk89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoCwGTuZ5izd4dV8zT3hbqZgDUVP/sWXJeV0G0dmAj4=;
 b=X5Tu7qd1+HG6ESd1mkvF0uTMThCIso1wKfSihH7sfXUe5ir284D4RkNHl4g0QBG5ES8LzUiwd/TnOgvdostQwNViRGdOUXGsZEgLQe/prfRaSXAAoaJQLUQlqq8J7Pk6Lp2ay/mjizbPtziroNvPV4zzRZ419SuU9y4Ex1LbiAzshi972CPeoCteQvQl5Qa9lRHMc06d4+r50UNK9mzWg8LWyyTIuE3lnJtwEVHtWkaOBAQ9c05HBysS7VzVQIUxoceqxGh7sPMpb7y/+SSVRuPbLtknAObCS19fioLlECy8iTR4qck33uCSNrLQ6s1giQSW9V1pNHcT4HM93khW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoCwGTuZ5izd4dV8zT3hbqZgDUVP/sWXJeV0G0dmAj4=;
 b=k4MWLbJG91QVzkgU00uwFS1Woy2yMyUFpXuE74XkCQfc9exgWEsxstAs/p8Gjrj+76W6skUUOCidLZ1xzu7GLAOWRp6yVtvZuvg4CUOEL7NwfV8dHI0w7L+mALD/EqnSslYXHW2mYJid9cH3SHSPnieLteLpZlF/1glCPfc8r4tOomc6hzlqkBp90w0N0BYrl5WPCw4cseaT4CkOBvqUKFSmkGhJFqa4s3uy6MySohrbeMu1+0CohDWT12M9kZutEJqHmJSeMQMsrneCRyFkBVznoUIiaoTEnzsHF35E22w3oBheZcjB+oorw2XEwBXFeSHVXgPRPJ13D8vVchnpSA==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 03:33:18 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 03:33:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Thread-Topic: [PATCH v6 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Thread-Index: AQHc355/3TS9YPjPiUaiT3oExn+47bYHFdiAgAEW7JA=
Date: Mon, 11 May 2026 03:33:18 +0000
Message-ID:
 <DBBPR04MB7500661393F2BEFE98A0363B88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-3-wei.fang@nxp.com>
 <20260510104832.7061EC2BCB8@smtp.kernel.org>
In-Reply-To: <20260510104832.7061EC2BCB8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AM9PR04MB8857:EE_
x-ms-office365-filtering-correlation-id: 40037c0b-b2d8-4ee4-e141-08deaf0e0b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|18002099003|56012099003|22082099003|3023799003|38070700021;
x-microsoft-antispam-message-info:
 0XxKFJz8hl/53YH0dl1FvCyCgUo+NFJdBLdakZTctobguGd2Dl7T6gBr5EezMjyLzNU5ZLoyMiLIPnlmrR0pdy2DJzsqRwY1GugIyi1e0N5fcYUbIZS/nEzlslmWN3gmkawxElM70o7/HB9YvqvYpq5lyRaXieNj5k6TcwGxLVXXCafB06CLPXx5mp51EOwN9WS5zPmTQ9oyukUug+3TApu5mf7tuu9Pg4ATn6fbEAHEzfxDV8C544QlIsD6G6zfUaq8uiiZWBjQty8cmsqH7ZBMJW5lpVm+Zz/RYTaDVvXCbOQBC9m21CMWBU6+mIxrqKT9bii3pr0pB5K3ijQiTIbxPNB8D61/65UuJw7JmNtmR5yQDQWVBZvpghPhvWELi19gI6vTVMxpSeLCO3n/SnjAxNU6pdnobfGOuPAhEzBIy5IJaGo+Yl+bBr4Dz6YM+GHsQMJFzo2WUpYZm42MOZuaCl997xrpXU7+HKVIzzkkrjBdu10SyfUKgyFm85agAyzz02s3yNfIbqi4fzHH7VB190jvKBlCPjEjJGbLVsZ8mtMh7whory5z2/vDrHz2vKTILFQVk3l9EDg3GkLahWYRjkxZcWbdOG5ND/sjkE0g9nUPJgjsyv/h4SfgTKrrz85T6VuD2RRwbmIWfWc7wJxrQq0qIwLPpCGPMvDf+W53l1yKtaZjry5PKShhphOmkuZKFUbFGIYdUtK7LMAywbeJOu2mm/K/qrK9Oy0AbwKZPgs2u6XtpbmpDf3DGe7s
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(3023799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6/pNI+kHqchUh2/AG3URL1bxZLE6JSK3khNGXfqVICCxUhAcnODGjfyiGvAm?=
 =?us-ascii?Q?Ce8I2Fh7MM848P039b9ITXgtqn8ocmv3bIEhGagxTzfeQjuYvoO9KiPKTnhq?=
 =?us-ascii?Q?xX049N42UAhUL1+UOQnBGPlrSSIG/rS+9tPUIFGRwqqfi+5F0WUjh5Tyf44W?=
 =?us-ascii?Q?ZnrYFkDCjJ40slWp26NY/2GyMqhhc+xESUGQfn7tg2wSP6om+dDeTcR32s4h?=
 =?us-ascii?Q?omNEBtIpUrmO5qHHP7YMaTqeDTzoC7YCa8iC8YraejfE81xtJrZnFaEZg4gl?=
 =?us-ascii?Q?iArc/jgaS/wXaWuOaQO8fpRwh7+GyHDoR7nJ8KwjjCMdlK1Fk7h1usmDtUQm?=
 =?us-ascii?Q?i6N79/4jJDiim6/cQZ6coT+HFA+uqVLxbdteur+s7A0azmkNQ2KzbudD4Mid?=
 =?us-ascii?Q?eGb7ENPad/R5Jr6e5jcih8gnDav+qYSXCarLscSB/Cl0Ap7d+6yi4ykwrVKi?=
 =?us-ascii?Q?cB6HikBSwvNTsjOyP0aGZfrMe9LjEpF3IbJxJniT3kYk19FYUlba2a9G3YK/?=
 =?us-ascii?Q?htNnBJPpmhLk1FXBTwJ95KQx9dc9YWOyyv3+ulCDsxtSKnDXXD7RkNa4fiwK?=
 =?us-ascii?Q?Chh50sk9Zkaraw3dVPN1QSyOlZ6+/ZLfX9JVXYm1FwSaaJQt8SkQaE6S+I7e?=
 =?us-ascii?Q?s2TLmwq8S0TDMXsXUvh52AAkDFKRFhKwejr1uVe9EHXzHogWZzRJ3fG/pt/+?=
 =?us-ascii?Q?cm3JDnTipDtt7JAvdhKRgMlnE0LkrD+UFMBcJQTa5QLACMr+DBdBkRbrnK0g?=
 =?us-ascii?Q?r6APSOMJpWyJQmTANTGdX86VfIpMyAsLZbDI+eKaviPIPj0oQYhvnjyoIQ/o?=
 =?us-ascii?Q?XdKTsPSdFAOgjZ/5JecKoO0/0N4S7i5ZSHBH4SSkfYar1eApMlBDD3kvXjvX?=
 =?us-ascii?Q?RDUHR5QWQfZE/0HRUVaJhNivCpe6AYkPhsQs4afrUA5hwMhbMQovQHgIJTcX?=
 =?us-ascii?Q?+7wSEFfgsV1mkdNVBB/T49E/smqPVKlJgV3+ACx4XquUChyL8VCbXFhjC/P9?=
 =?us-ascii?Q?3nqBfyfrXVwGvW4UJ9gVvYy/nsbodBge1nbLN5yil+oBMxQAVMyEoh/G5D2Q?=
 =?us-ascii?Q?h1wSP2/wGk3ANUDZskdeFPu4Ql6gZEtaxanUgXf9fuG11d/o16XNG/2d4JVO?=
 =?us-ascii?Q?WrRlcr4l5KgmoIl1VBwPWBGZKMqACbLy+xmlmknAUT6GGuFenXIEkT6T/CXr?=
 =?us-ascii?Q?5ztssti4P4oraroaLJpve4zQxy7sdG3F+OF/fbUZBe3LB5o8oBAv9IrJjulQ?=
 =?us-ascii?Q?rctlAyEJLbiSSmWFGEKbhteD2Imlx8IF9LbtEh3h/ZOx3r2AeVkw3ZXhpj4r?=
 =?us-ascii?Q?5HpP+M+KCDYIcOYzcg6dXHQMN6Jl2SwxLXR90Zt1ER2X53bhfUtEEE75Qwey?=
 =?us-ascii?Q?iSfCCWn57cFJIiIMLp12Y2bOITd6udVZohkK9eH9k64MRgwj5dSY4UCbh6gF?=
 =?us-ascii?Q?qU9zFCxKedGpyhYrBdyJUVBcgs88QJZMo9h3fwp7rW5hS4W4Fs35Bhp0togn?=
 =?us-ascii?Q?1FLkIAnu3Rci+tX4/Oec1N8yfEsaFqYxfqyF2IiLwlHwLbC4pxdxYQswQ3Hf?=
 =?us-ascii?Q?jv61HeYR3RxrbwglMoG31xSp8uVnKMXBVGli0vnrjvnFjLLFWNmrbN2w8eGG?=
 =?us-ascii?Q?FPXM43MeBABaFoEBZtiwgwyk/I70AtSSAX8xYUMRdBWj6GZsi82kX4qOnJgQ?=
 =?us-ascii?Q?G0HDCivf47l68bo0lLvjz6UNcAtaopkFldMVBUFgvAf2Y6SW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40037c0b-b2d8-4ee4-e141-08deaf0e0b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 03:33:18.4358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eV5MGTzSvmSTNXZR1QwE0+4zPxTSCHHhgh5uk66+Lfndoj5pHy6mypaoSUJ+48AmpkhEj5JnHMnfAT/R3qa+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857
X-Rspamd-Queue-Id: AFCE9507A32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DBBPR04MB7500.eurprd04.prod.outlook.com:mid,nxp.com:email,nxp.com:dkim,0.0.0.1:email]
X-Rspamd-Action: no action

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to
> consider:
> - [Low] The `dsa,member` property lacks validation constraints for the sw=
itch
> index.
> - [Low] The `patternProperties` regex for ethernet ports is overly restri=
ctive and
> diverges from standard DSA bindings.
> --
>=20
> commit 8c698895982ff77d4bd027af7fa3d21f57f09eba
> Author: Wei Fang <wei.fang@nxp.com>
>=20
> dt-bindings: net: dsa: add NETC switch
>=20
> This commit adds the device tree bindings for the NETC switch. It is a PC=
Ie
> function of the NETC IP that supports advanced QoS and TSN capabilities. =
The
> switch connects to an internal ENETC port via a light-weight pseudo MAC.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.=
yaml
> b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> > new file mode 100644
> > index 0000000000000..988688bf4467d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
>=20
> [ ... ]
>=20
> > +  reg:
> > +    maxItems: 1
> > +
> > +  dsa,member:
> > +    description: >
> > +      The property indicates DSA cluster and switch index. For NETC sw=
itch,
> > +      the valid range of the switch index is 1 ~ 7, the index is refle=
cted
> > +      in the switch tag as an indication of the switch ID where the fr=
ame
> > +      originated. The value 0 is reserved for ENETC VEPA switch, whose=
 ID
> > +      is hardwired to zero.
>=20
> The description mentions that the valid range of the switch index is 1 to=
 7
> and that 0 is reserved, but there do not appear to be any constraints
> enforcing this restriction in the schema definition.
>=20
> Should an items array constraint be added here with a minimum of 1 and
> maximum of 7 for the second element to ensure invalid configurations like
> <0 0> are caught during schema validation?

I have added the check in the driver, I can add the following the check in
next version if no more comments.

  dsa,member:
    description: >
      The property indicates DSA cluster and switch index. For NETC switch,
      the valid range of the switch index is 1 ~ 7, the index is reflected
      in the switch tag as an indication of the switch ID where the frame
      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
      is hardwired to zero.
    items:
      - true
      - minimum: 1
       maximum: 7

>=20
> > +
> > +  ethernet-ports:
> > +    type: object
> > +    patternProperties:
> > +      "^ethernet-port@[0-9a-f]$":
>=20
> Is this regex intentionally more restrictive than the standard DSA bindin=
gs?
>=20

'ethernet-ports' for new bindings. See https://lore.kernel.org/imx/20260408=
134331.GA1954185-robh@kernel.org/

> The standard DSA schema in dsa.yaml allows ^(ethernet-)?port@[0-9a-f]+$.
> Because this binding sets unevaluatedProperties to false for the
> ethernet-ports node, if a device tree author uses the standard port@1
> naming convention, the binding will reject it.
>=20
> Additionally, the single hex digit restriction would prevent port numbers
> from exceeding 15. Could this be aligned with the standard pattern?

Currently, the i.MX94 NETC switch only has 4 ports, a single hex digit is
enough, and this is consistent with the definition in dsa.yaml. please
ignore this warning.


