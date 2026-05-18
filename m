Return-Path: <netdev+bounces-288845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKrXExiTCmrL3gQAu9opvQ
	(envelope-from <netdev+bounces-288845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3B5659B8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF39A300D610
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB037C10C;
	Mon, 18 May 2026 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GoYg8uOc"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572BE329E47;
	Mon, 18 May 2026 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779077908; cv=fail; b=n5uhDLnNSDVsJMbtlWppsGyz2PA0xVwR3tJeyh+BdtjMkr/LIWVPFi86eGuYi5KpXvoFxu9mYGTlY3jcmMTK1ErHAp5//f0osGVrh5Oz7ksASLj17Te72pwzOE0aEWu804qyBai2gxpUfK9POwx6MdVPAG8PtoQQQegA3d6hND0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779077908; c=relaxed/simple;
	bh=eKX1Ut4IU/I/BdqvCtHx0/G+/zVozbb55fOEI9w9m1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nt2Wala2Hl2xv98QCtqWWgMuOYnbOhjG6Ipk42go9r6riWTbfeIBCxsUBt5THYRpbwFj4isGPhexJ8tNFyCbyjqSP5OlcrcGOWmz7DqsmFiN8BVbxbYnLCkizSq0xb+g6dF0uu2E3AG6/BzlmKfPPtzjYVRqDSN0OniI9ByIJOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GoYg8uOc; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUjyWGUpP/dP3AaTqNLe7b7yo7nNr7p5yYdHfzJqIdLfXqnJZL4u8Qk2FRI496woLuGTKKCU9hs003qAqt3HKUD9EZJZ+h9TkTVTuhHJy+/pM4FgfAsUwEiNIJTQcdq3Rg4lbsF73KtEEdwlfjZ8TztlP76sreDice2Wau6STZeAi+n7hPkenh9LFTE/7NL5McYQy8uJuqIxXt1QHdSTkJOho1ccyOtltVeAD2zJ+gkJIIceOvaCp1XImlVljTWGBSHKnAFL6eUkkSUdTsLvfuBWCnE4UxDhH98b+yB/TABNCJ1qN++nv9/BJNxm4Y7VM4/fAxVzUg/o5p7ZHzh/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8294AAmZ2mwx/twnl+CYNuXaaudWodRTyj5V3karIdI=;
 b=fCKDksgZuVgTfIG3yPHxGmoqeSAO/AcY03NMcELZDvcPqummRVYWV1+bw74iivaWJfJ/q7Ri0GkdW4XHnzAeniK7gkhdzyH0QykukDbtOBnhvC4SDxeh/isooMM8pmtR4DlrpGnbXDaz+Ax+zZWL6aaz3NxdWBnw/aU5Ck6BfQKpR5gk9dhMRLcpHOCSV6pWWjoeDyyj5QGgn5Gm+KBvOTEVvM6POVkjV6wQUa6fgi58e3l59DIf+T0FU1UC1kyS7V/DdkN20DkC58TuFPzEiZvuIiQNXbkaa23ECQMWHByPcgGkkvNdZDFCoOjecvMtLofKRDrin3QdOPUrlMZeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8294AAmZ2mwx/twnl+CYNuXaaudWodRTyj5V3karIdI=;
 b=GoYg8uOc4u8ZV0w1Q3GFF+HBzMM/m7IxLNeiS5gV5cHzN7uAw9VU2Iqe48UlwkCPu1ODZLId4VhQITs5yYiooyhF0jia9WyqIbqzWnwiRSLnZJAiS5LBvnDEH7byYU36AUF8Uil4Tmx8ct+6CciKUF2SmLxexkap/RMWV5QYkUlZLTe8Nx64tVcWDiN9k2f5i8o91Rm/aCclOdhvi971yNzNoYnsoYv7lT05eSGJr75PooHttK+lXHUM6Yq8zlb66rJ7h58lEbJiTxqpb5sjOOTat0KHlR2XMT/lm3bylb6RTEk+mo1dEhbJMy8d8CYhI1SBF+d1VEkflNlFKqGZ0A==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 04:18:21 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 04:18:21 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 3/5] net: lan743x: Add support to
 software-nodes for SFP
Thread-Topic: [PATCH net-next v3 3/5] net: lan743x: Add support to
 software-nodes for SFP
Thread-Index: AQHc3qrFMIeD3OYEpUCNQHbYRVtoSLYJqzQAgAIHDoA=
Date: Mon, 18 May 2026 04:18:21 +0000
Message-ID:
 <DSWPR11MB9715211955B46EFB14AE697AEC032@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260508052150.11852-4-thangaraj.s@microchip.com>
 <20260512020848.839006-1-kuba@kernel.org>
In-Reply-To: <20260512020848.839006-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|PH7PR11MB7025:EE_
x-ms-office365-filtering-correlation-id: c64fa906-13e5-46d6-a6cb-08deb4947f0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info:
 JUAITnQfvhVoFSYUtJYm55p/GQpuw3je0JA7rk+ZQLEbwKFPalf073b7CjsxlNPf51/IlrYS/NjwKXNQZBq81qm/r5Av4YeYEWYPIk8UsfIXjvBGp20Jg2PxYkB58cMhV2YLH3JPCPBaMFfIne2uEGU2IFofcRBfXfeSElpJiz/NzU4O9oHUxdvgdIbUpiApl3+rg8KAizCDvJ2vl1SqkX0Vx9UnjTKp5OZMtET7bPCC0B4SyavXoKUgNR8Xn7cSAUaztHg+By90gvKYb1fJkLHQj/5SjSvoVEumze1l6lomD71RinYitToVgq6t+ExI8BbBwQCdF8i8RjgwnD0Amj7jbfJ28srI2nuSGekhf/G4VALFLAx9Xhb8WMQxngTmmA9lJhlSXyDsZYJ85NHboQ0fT5wxyYeY5o0ome/Eq/Da3RQRRmslAl38ACvsGW9DNI0Ip2MyW0NuUQVCd3MUR/nqAiJ/v3BM6SO50wTmMoZEnIdwVD6wLoMgG0PLOIyMrl4/XM1ZeLPS/aWfYrwoUcqwU3sW3NQni9zcZVu5fh5r5JCB8YF4DXT+5kmu/Y3ZENQWk+nbxdD/QKzDE4Z1uQU4qyvzbqkpuKcfGYK3h2bJUlkeWjUYw8hp95u88NqMNuXqa2J+26YM/Z9pzxmE5zYbNNL3sfry62dqH3XgJ7CY613LvAVE3vtP/8Y8KLDhIKHQPWDPMVrDidlx40ElO4qf4U1hbcNEkgrkfW+x5wkHV4cJGKeNUDzHaIipe+Bv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vLRCqC/Ti90rpcqd11totS8CH5En1RDFPtp0vVsGf42kXDV9jG1toec9fYXX?=
 =?us-ascii?Q?8AI/MuhWSpjPDsMeJ2pZ9KBkzm92L+uh1dQgjUf4YaDKCTd2u0dsDPGVrDct?=
 =?us-ascii?Q?ySo+DDPioLal7nim3e3R9nnmS2YVWSS99Tln6A6fWrqIaOngP2zzA7ffkLSh?=
 =?us-ascii?Q?EsULAKBehOEKSrEw7zKGJzeRJvoYnddIOaEtM/emRLWP6pWeu0Ht1kgN7h5a?=
 =?us-ascii?Q?Vf6J/9PiQnjxjth8dh800DBlfnkvX5nqxW05t5cch8ZIve2Jv67Hu/RcDTrr?=
 =?us-ascii?Q?THY2Q7k8jqziZ39PUjx+jTKAVsY6EKT+4B5ecse5pXc672ufRF7qOci0yAD9?=
 =?us-ascii?Q?03uCRaGH155i5A0HHqBl2kpGNC18p1w8LFnIapRWYbDXFaE3JuJKzF3jbXw5?=
 =?us-ascii?Q?ELCxjuaOh5QpVuTH+MVHc7pr7Ta/6AyGLgCA46GjJkRiDWSXrbOR69V2Ogwi?=
 =?us-ascii?Q?a8N0iFJS8VO2U2zErwgE+2Oa71FO2CWPma2Ch41wTTNJVKj2kgQXUyEn/kUp?=
 =?us-ascii?Q?NIHbNrsz8DMXSsvOuk2Z3jtFNuMibnsfCqyYPFg5ZL0fxW+4sotTG7VboMds?=
 =?us-ascii?Q?dGU+uVAaCUw/Ss3tLGL8XccSYE+9DUxgSAOmunNMl1hM8Ldt/U1YUKNJ6Kex?=
 =?us-ascii?Q?L0GY5er13OBHNFZbY+lakO7R5fnauTjeiY/dDGoookJnW0mkG61RH+bHYYp6?=
 =?us-ascii?Q?b1MiIicAzKF3ivwkwMRkT0BQoE69LWEkLs7OuooDh+DuFJ55Oyt5FUtCU0zx?=
 =?us-ascii?Q?cGpDN5ZtdSpWINrNo4tOZKzJ3Ex5PoLbHYGvtNrcvv0DGyAKNLsDb5zRSc7/?=
 =?us-ascii?Q?vH3oAkptm250DCDI0oDcym/WlGW+VMDTAqU+WO1iP0dMlkmJnChtvEdpaDCZ?=
 =?us-ascii?Q?1gcEdhGr0zlASLffm694AvJDW+XfRoubPFl90ekOV6KzDY1SCAOwB7INipHj?=
 =?us-ascii?Q?Ijhze3rrYAd+k8sOcqnz6xRUgAPpe3qA81fsG4N27IL32Ae3pf2bJgYN10pe?=
 =?us-ascii?Q?8I8PRhdAY2PzkzrQYBw/EuTf9BwKzqr21d2/MdWES4ayL6ysq4skB4QThOkK?=
 =?us-ascii?Q?lr/Ud7LqP896FS8FdmUR3b8GEwv6+iYCpUen3V2m5JkF9R7S1337JwZAfj7r?=
 =?us-ascii?Q?WtSqgyz+1ruw8sjQE5YtrNxOAiC8Y9/V2D3K7x43qGRSGIBmhu7Kpy39zCEu?=
 =?us-ascii?Q?CQk8Ig2xhKlWvOdoN/EsVAkoAQsfKvEQAm5UZDuA+w1sKV2aO3319XUpdXvx?=
 =?us-ascii?Q?lUQQ+Ye3i/+FMuya0Nnwww7TqLukY6oJ8I12Q6h2X0EMFmrIVp7ZLltYmm4R?=
 =?us-ascii?Q?RSgQGry6Uwmy3iX/7Herj4ttrSR7f1bY9WpK1w1bvbwLDkk1vsPCTR8wrNxY?=
 =?us-ascii?Q?ZJpBrdCQZNWS+Vk62f3I4dPMnFaAnZo2FO+c4f5oDFFHxhTnet33YkHrJEut?=
 =?us-ascii?Q?aYLc48/6+ydw6VS5qo/QoaDpBHV1To6If3GiuWuU3lAK+52V7l6sClAwfv7s?=
 =?us-ascii?Q?Xs821c3trJQgGAd1cgPxbsjsBXu+GQfEiu0MnoOMNZCgGQWxXJze0x+dEsUr?=
 =?us-ascii?Q?7VRPmn3aY2u+OJn+cq3fbuX8KHU/elBKA4KTrSd9Qnc+9qZQHfth9153klG+?=
 =?us-ascii?Q?nJVmxcRCUMlQOarYf6blKzdktbcebXPGQXUvHqlvwB6xfqtgdXbkaDds0QkO?=
 =?us-ascii?Q?Tn1O4RM00UBMRT6qWknAs0eYknne7BL5i+dWn0dfuRO0wlyfm724jGnOzych?=
 =?us-ascii?Q?7q10UalErQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64fa906-13e5-46d6-a6cb-08deb4947f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 04:18:21.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NkeYFPp8q7mPNo1U2ayBWFt5/K/TEHwSjk1w0DLjcJtIPjLgZRjezWEHGZhJPgF58VIy1LJ72lwaxzbZ26xA2tyQzSUjWn3Djr2TXoXCcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-Rspamd-Queue-Id: B6C3B5659B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-288845-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,microchip.com:email,microchip.com:dkim,aux_dev.name:url]
X-Rspamd-Action: no action

Hi Jakub,
Thanks for reviewing the patch.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, May 12, 2026 7:39 AM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; netdev@vger.kernel.org;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v3 3/5] net: lan743x: Add support to softwar=
e-
> nodes for SFP
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> ---
> Subject: net: lan743x: Add support to software-nodes for SFP
>=20
> This change registers a software-node hierarchy (GPIO/I2C/SFP/phylink) fo=
r
> the LAN743x so that SFP cages on PCI11x1x devices can be described to
> phylink/sfp. It wires the lan743x probe to the sibling pci1xxxx I2C and G=
PIO
> peripheral drivers by walking the PCIe topology and dereferencing their
> drvdata.
>=20
> A few questions on the patch below.
>=20
> > diff --git a/drivers/net/ethernet/microchip/Kconfig
> > b/drivers/net/ethernet/microchip/Kconfig
> > index ee046468652c..a83db3c7404f 100644
> > --- a/drivers/net/ethernet/microchip/Kconfig
> > +++ b/drivers/net/ethernet/microchip/Kconfig
> > @@ -50,6 +50,8 @@ config LAN743X
> >       select CRC16
> >       select CRC32
> >       select PHYLINK
> > +     select I2C_PCI1XXXX
> > +     select GP_PCI1XXXX
> >       help
> >         Support for the Microchip LAN743x and PCI11x1x families of PCI
> >         Express Ethernet devices
>=20
> [High]
> Should LAN743X inherit the dependencies of the symbols it now selects?
>=20
> GP_PCI1XXXX in drivers/misc/mchp_pci1xxxx/Kconfig carries:
>=20
>     depends on PCI
>     depends on GPIOLIB
>     depends on NVMEM_SYSFS
>=20
> and I2C_PCI1XXXX is sourced inside an "if I2C" block in drivers/i2c/Kconf=
ig, so
> it has an implicit depends on I2C. The LAN743X entry here does not depend
> on I2C, GPIOLIB, or NVMEM_SYSFS. On configurations where any of those are
> disabled (randconfig, allmodconfig variants), would this produce unmet-di=
rect-
> dependency warnings from sym_warn_unmet_dep() and potentially fail to lin=
k
> because the selected drivers' helpers are not built?
>=20
> Would adding "depends on I2C && GPIOLIB && NVMEM_SYSFS" (or gating the
> SFP glue behind a nested Kconfig symbol) be appropriate here?

[Thangaraj Samynathan]  Gating the SFP behind a nested symbol should be the=
 clean
good solution. Will implement the same in next revision.

>=20
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index 867310dbe9ba..b90b35cef2e6 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -112,6 +113,91 @@ static void lan743x_pci_cleanup(struct
> > lan743x_adapter *adapter)
> > +static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapte=
r,
> > +                                     u16 perif_id) {
> > +     struct pci_dev *pdev =3D adapter->pdev;
> > +     struct pci_bus *perif_bus;
> > +     struct pci_dev *perif_dev;
> > +     struct pci_dev *br_dev;
> > +     struct pci_bus *br_bus;
> > +     struct pci_dev *dev;
> [ ... ]
> > +     br_bus =3D br_dev->bus;
> > +     list_for_each_entry(dev, &br_bus->devices, bus_list) {
> > +             if (dev->vendor =3D=3D PCI1XXXX_VENDOR_ID &&
> > +                 (dev->device & ~PCI1XXXX_DEV_MASK) =3D=3D
> PCI1XXXX_BR_PERIF_ID) {
> > +                     perif_bus =3D dev->subordinate;
> > +                     list_for_each_entry(perif_dev, &perif_bus->device=
s,
> > +                                         bus_list) {
> > +                             if (perif_dev->vendor =3D=3D PCI1XXXX_VEN=
DOR_ID &&
> > +                                 (perif_dev->device & ~PCI1XXXX_DEV_MA=
SK) =3D=3D
> > +                                  perif_id)
> > +                                     return pci_get_drvdata(perif_dev)=
;
> > +                     }
> > +             }
> > +     }
>=20
> [High]
> Is it safe to walk br_bus->devices and perif_bus->devices without holding
> pci_bus_sem?
>=20
> Both pci_device_add() and pci_destroy_dev() take
> down_write(&pci_bus_sem) when mutating pci_bus->devices, and
> pci_walk_bus() / other in-tree consumers either wrap the iteration in
> down_read(&pci_bus_sem) or assert lockdep_assert_held(&pci_bus_sem). If
> a PCI hotplug or sibling bind/unbind happens concurrently here, could the
> traversal corrupt, loop, or step through a pci_dev that is being freed?
>=20
> Relatedly, pci_get_drvdata(perif_dev) is returned directly with no refere=
nce
> acquired on the peer device or its driver. Can the following sequence occ=
ur?
>=20
>     lan743x probe stores adapter->i2c_adap =3D &i2c_drvdata->adap
>     user unbinds i2c-mchp-pci1xxxx via sysfs
>     i2c_drvdata (and its embedded i2c_adapter) is freed
>     SFP EEPROM access via the software-node fwnode still dereferences it
>=20
> Would using pci_get_device() (or pci_dev_get() under pci_bus_sem) plus a
> device_link_add() from the peer device to the lan743x consumer be a more
> robust pairing, or alternatively routing this coupling through the auxili=
ary bus?
>=20
[Thangaraj Samynathan] Agreed. Will be fixed in next revision.
=20
> > +static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
> > +{
> > +     struct pci1xxxx_i2c *i2c_drvdata;
> > +
> > +     i2c_drvdata =3D pci1xxxx_perif_drvdata_get(adapter,
> PCI1XXXX_PERIF_I2C_ID);
> > +     if (!i2c_drvdata)
> > +             return -EPROBE_DEFER;
> > +
> > +     adapter->i2c_adap =3D &i2c_drvdata->adap;
>=20
> [Medium]
> The cast here relies on struct pci1xxxx_i2c being textually redeclared in
> lan743x_main.h, identical to the authoritative definition in
> drivers/i2c/busses/i2c-mchp-pci1xxxx.c. Nothing ties the two copies toget=
her
> at build time (no shared header, no BUILD_BUG_ON on sizeof or offsetof), =
and
> there is no runtime check that perif_dev->driver is the expected pci_driv=
er
> before the drvdata is cast.
>=20
> If the i2c driver later reorders or resizes a field, would &i2c_drvdata->=
adap
> silently read from a wrong offset? And if the peer PCI function is bound =
to vfio-
> pci or any other driver,
> pci_get_drvdata() returns an unrelated pointer which is then dereferenced=
 as
> struct pci1xxxx_i2c. Would it make sense to add a narrow accessor exporte=
d
> by the peripheral driver, e.g. something like pci1xxxx_i2c_get_adapter(pd=
ev),
> so the layout is not duplicated across subsystems?
>=20
> The same question applies to the redeclarations of struct
> auxiliary_device_wrapper, struct gp_aux_data_type and struct
> aux_bus_device in lan743x_main.h.

  Thanks for the review comment. This will be fixed in the next revision.

  The redeclared structs will be removed from lan743x_main.h. Instead of
  casting pci_get_drvdata() to private peripheral structs, we will use
  standard kernel subsystem APIs.

  For the I2C adapter, device_find_child() with i2c_verify_adapter() as
  the match function will be used to locate the registered struct i2c_adapt=
er
  without needing struct pci1xxxx_i2c layout knowledge. This pattern is
  already used in drivers/media/pci/mgb4/mgb4_core.c.

  For the GPIO aux device, device_find_child() with a match on
  to_auxiliary_dev(dev)->name =3D=3D "gp_gpio" will replace the magic [1]
  index, avoiding the need for struct aux_bus_device layout knowledge.
>=20
> > +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter) {
> > +     struct aux_bus_device *aux_bus;
> > +     struct device *gpio_dev;
> > +
> > +     aux_bus =3D pci1xxxx_perif_drvdata_get(adapter,
> PCI1XXXX_PERIF_GPIO_ID);
> > +     if (!aux_bus)
> > +             return -EPROBE_DEFER;
> > +
> > +     gpio_dev =3D &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
>=20
> [Medium]
> Is the hardcoded index [1] here guaranteed by anything?
>=20
> In drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c the wrapper array has
> slot 0 =3D gp_otp_e2p and slot 1 =3D gp_gpio today, but that ordering is =
an internal
> detail of the GP driver and is not enforced by a shared type, a name chec=
k, or
> a documented contract. If the GP driver ever reorders the registration, f=
ails
> partway so slot 1 is unpopulated, or adds a new slot, would this derefere=
nce
> pick up the wrong aux_dev (or a NULL)?
>=20
> Would it be preferable to look up the GPIO aux device by name (e.g.
> matching aux_dev.name =3D=3D "gp_gpio") or expose a named accessor from t=
he
> GP driver?

Agreed, Will be fixed in next revision
>=20
> > @@ -2890,6 +2976,96 @@ static int lan743x_rx_open(struct lan743x_rx
> > *rx)
> > +static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
> > +{
> > +     struct pci_dev *pdev =3D adapter->pdev;
> > +     struct lan743x_sw_nodes *nodes;
> > +     struct software_node *swnodes;
> > +     int ret;
> > +     u32 id;
> > +
> > +     nodes =3D kzalloc_obj(*nodes);
> > +     if (!nodes)
> > +             return -ENOMEM;
> > +
> > +     adapter->nodes =3D nodes;
> > +
> > +     ret =3D pci1xxxx_gpio_dev_get(adapter);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D pci1xxxx_i2c_adapter_get(adapter);
> > +     if (ret < 0)
> > +             return ret;
>=20
> [High]
> Does this leak the lan743x_sw_nodes allocation on error?
>=20
> adapter->nodes is set unconditionally before the two peripheral lookups,
> both of which commonly return -EPROBE_DEFER while the sibling pci1xxxx
> drivers are still probing. On that error, lan743x_swnodes_register() retu=
rns
> without freeing nodes and without clearing adapter->nodes.
>=20
> The caller in lan743x_phylink_create() handles the failure as:
>=20
>     ret =3D lan743x_swnodes_register(adapter);
>     if (ret) {
>         netdev_err(netdev, "failed to register software nodes\n");
>         return ret;
>     }
>=20
> without calling lan743x_swnodes_unregister(). The probe error path
> (lan743x_pcidev_probe) then jumps to cleanup_mdiobus, which does not
> reach lan743x_destroy_phylink() (the only caller of
> lan743x_swnodes_unregister). Each -EPROBE_DEFER retry would allocate a
> fresh struct and discard the previous one.
>=20
> The same concern applies to the software_node_register_node_group()
> return at the end of this function: its failure is returned to a caller t=
hat does
> not call lan743x_swnodes_unregister().
>=20
> Would cleaning up in lan743x_swnodes_register() itself on every error pat=
h
> (kfree(nodes); adapter->nodes =3D NULL) be appropriate?

Agreed. Will be fixed in next revision.
>=20
> > +     nodes->gpio_props[0] =3D PROPERTY_ENTRY_STRING("pinctrl-names",
> "default");
> > +     swnodes[SWNODE_GPIO] =3D NODE_PROP(nodes->gpio_name,
> > + nodes->gpio_props);
> [ ... ]
> > +     nodes->i2c_props[0] =3D PROPERTY_ENTRY_STRING("pinctrl-names",
> "default");
> > +     swnodes[SWNODE_I2C] =3D NODE_PROP(nodes->i2c_name,
> > + nodes->i2c_props);
> [ ... ]
> > +     nodes->phylink_props[0] =3D PROPERTY_ENTRY_STRING("managed",
> > +                                                     "in-band-status")=
;
> > +     nodes->phylink_props[1] =3D PROPERTY_ENTRY_REF_ARRAY("sfp",
> > +                                                        nodes->sfp_ref=
);
> > +     swnodes[SWNODE_PHYLINK] =3D NODE_PROP(nodes->phylink_name,
> > +                                         nodes->phylink_props);
>=20
> [High]
> Do the property_entry arrays need a trailing NULL sentinel?
>=20
> The struct definition in lan743x_main.h sizes them to the exact number of
> used entries:
>=20
>     struct property_entry gpio_props[1];
>     struct property_entry i2c_props[1];
>     struct property_entry sfp_props[8];    /* 7 used + terminator */
>     struct property_entry phylink_props[2];
>=20
> The swnode code in drivers/base/swnode.c iterates with
>=20
>     for (; prop->name; prop++)
>=20
> in property_entry_get() and property_entries_dup(), which relies on a zer=
oed
> terminator. Only sfp_props[8] includes such a slot.
>=20
> Because gpio_props, i2c_props, sfp_props and phylink_props are laid out
> contiguously in struct lan743x_sw_nodes, when iteration walks past
> gpio_props[0] or i2c_props[0] it would land on the next array's entries (=
for
> example i2c_props[0].name =3D "pinctrl-names", then sfp_props entries
> "compatible"/"sff,sfp", "i2c-bus", ...), only terminating at sfp_props[7]=
. The
> GPIO and I2C software nodes could silently acquire SFP properties.
>=20
> For phylink_props[2], iteration would continue into i2c_ref[0], whose fir=
st field
> swnode is a non-NULL pointer; would that pointer then be interpreted as
> prop->name and passed to strcmp() during lookups for names other than
> "managed"/"sfp", producing an out-of-bounds read of kernel memory?
>=20
> Would sizing each array with +1 for a zero terminator address this?

Agreed. Will be fixed in next revision.

>=20
> > @@ -3134,7 +3310,9 @@ static const struct phylink_mac_ops
> > lan743x_phylink_mac_ops =3D {  static int lan743x_phylink_create(struct
> > lan743x_adapter *adapter)  {
> >       struct net_device *netdev =3D adapter->netdev;
> > +     struct fwnode_handle *fwnode =3D NULL;
> >       struct phylink *pl;
> > +     int ret;
> [ ... ]
> > +     if (adapter->is_sfp_support_en) {
> > +             ret =3D lan743x_swnodes_register(adapter);
> > +             if (ret) {
> > +                     netdev_err(netdev, "failed to register software n=
odes\n");
> > +                     return ret;
> > +             }
> > +             fwnode =3D software_node_fwnode(adapter->nodes-
> >group[SWNODE_PHYLINK]);
> > +             if (!fwnode) {
> > +                     lan743x_swnodes_unregister(adapter);
> > +                     return -ENODEV;
> > +             }
> > +     }
> >
> > +     pl =3D phylink_create(&adapter->phylink_config, fwnode,
> > +                         adapter->phy_interface,
> > + &lan743x_phylink_mac_ops);
> >       if (IS_ERR(pl)) {
> >               netdev_err(netdev, "Could not create phylink (%pe)\n",
> > pl);
> > +             lan743x_swnodes_unregister(adapter);
> >               return PTR_ERR(pl);
> >       }
>=20
> Thanks for reading.
Thanks,
Thangaraj Samynathan

