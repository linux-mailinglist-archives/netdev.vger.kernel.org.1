Return-Path: <netdev+bounces-267545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFYnHJtJtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:30:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82332881DF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B55C2300F18A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354D23CCA0F;
	Fri, 13 Mar 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ia2/P3sr"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3C3C5DD2;
	Fri, 13 Mar 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422999; cv=fail; b=NIyqY/EbJHG1YmUY93r4AVrhbhUthcIXP9YaHH3VInk/juIw+RAL5RraYm38aQCjitLhqCZBl7SIVNwxYegIKmC6UUI6XUEzGlPixSP7/a5y5SccHxeenpfDTLSNCFskos5y/MJI+iDp/tA9X2EDg9c2f2bjvqpuHFTMis7I1cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422999; c=relaxed/simple;
	bh=V6R9clg6lFTGakkCkQflKaACZHqp8701DI8slaO4Xt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JE1AuD8A7LOGjPydiXguqSOa8Fm4jyq/IBh2vE/+zwJBouR6fWaqANvhAdEFG+iw9IsxXFhoGL/7YnnOmx/YzBnD/+JT+0r4Cz0tWUfezJEtkLBXog7tCSiIpXViOSdOEXEDLSJt+bE8TyfRnPQqNlJ3afknf51Fa1COyJ07ouk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ia2/P3sr; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7N/2x9yK+ckPXoa6UrEAC8Y4fWNDOCIiEX72q8eh9OfhRGJk/eB8Mm1TxBk4OJ4JilRUFOEB4meV49PaIwqUgPfSDcsVCz3W5fgRjzlpWf/KqyVfWl6PGX2z7PlAXZtosmNU18KuyB4iZnJh2sAoeWO4k1FrGgGWOuqxWAYClDC++hKUJfVK9a8nKViummiVQo93zWuc6SiMD7XoLfSyaTeCXSHJwr033VAGefWSiy7jhIdCaQyMa2nYMcA49hxPCWEwEFhI+63OSLWnF/TopLdjaK5TF7RpmAW7cB805mvhP8/Rk3x0pfjCKI2V9U9mHfRUBBB91uuayVmxGAz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03UEfYA8g4GdKDcYm/27xVnJw4FX/GP/4lxCVPizuus=;
 b=O28qFgaZN9sZe1uXCEFgu4WdCPZrUfVailpkf+UR2hmd02ZVIx6iNzWq0G+9wi3DyBMkcZlqPTJkL8aJlBwP6sazYQWlQaovuxNr2GjcT/NDIOeCpJrrhQE0kMLrlbi5YghPSWsqOsaeJyrEcbA7vF0beYk/tvXBxsvDO38xMGI4wU62nx1o4xFmtDtNwykwJnAKufYIkd2RlVIifQ5BaOay0h+g9QwR2A0LdGyMarS4AihWMs4BcUDZOIYYEt2m0KgluSdTa862JxLWw32eHj5W1HolycdjP34jGrziapadsntO0UUD5D5fsgy4XbiEPUnw8yC04ZxR4yED65tj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03UEfYA8g4GdKDcYm/27xVnJw4FX/GP/4lxCVPizuus=;
 b=Ia2/P3srq6L5wfpFp3jfq75ybT4sJjgY1TZ+y5BdHBg/+ioLFGjH6ALgRiBgMuMxMjpHmNFHnJjmNoEGtBh+PMqf2NNTFDlSCLGkzUTldTtWFMPuemWeIeiJX4pgqwAe+VQVe7QKPNmIVIYq8XVMpIWIgzONHOpRQleEkicNu8w0hxY/c7WmW+ZnACjxC5doznwnAgsgKdgNLoh8+l5J/16DDWGB6Hd3TcmkygGaZdWFQ/Sp4JPaNHFKXz9vWDbJBLoAVfd130q0I3DCPK+0n3im+YU2pnambIuAyRRhMi5E9RG6d54O4hE0jk1Z2KOWWyyG6w2uVpJInx2b1Kg2kw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 PH8PR11MB6926.namprd11.prod.outlook.com (2603:10b6:510:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 17:29:52 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%4]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 17:29:52 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>, <bastien.curutchet@bootlin.com>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <pascal.eberhard@se.com>, <miquel.raynal@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Topic: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Index:
 AQHcq8BZxyCiqHlsBEeDQ14VW7yu3LWftUwAgAAtaoCAAANygIAAH+SAgACs27CABX1SAIAAhfyAgAJuqICAAB8cAIAAEK4AgAAReQCAADL0AIAAeQwggADjVQCAAbIDgIAAHqFw
Date: Fri, 13 Mar 2026 17:29:52 +0000
Message-ID:
 <DM3PR11MB8736ECCCE15258C04287889EEC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
References:
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20260312134526.3lnifstvb5dpghrg@skbuf>
 <20260313153849.qkfzv5c2u6fepjku@skbuf>
In-Reply-To: <20260313153849.qkfzv5c2u6fepjku@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|PH8PR11MB6926:EE_
x-ms-office365-filtering-correlation-id: 4a4b052c-0bb4-44fb-e183-08de81262299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 FH11qHjLBvKfPAZXHlh+tM/+itdsNYgHxDVfW63IirOQvB6JOyeOCnRtCRdO/Dx4UbEJV0EixvNc+BHCNh8lIYUknYllnCTKGw7S9JRDj3RxOvhHUwlIkDCZ2XNIXxU76nPKGvzdmJjap7s69vj7rpn0JOcym8QWzUkn8sobPQrgTGfIVKWgs3jrRQRDzGoTMsKI5I555EBHuSWuziK4aZTLeiKNoUfo0nol6BULheLJfeB/ePwoL/mxrukjMCkmSrcXcNjm/i5iPiahpDkLyFRDOKqK91JOJX8ZzM+o+CKy4MIlgNJAvNPDPXeDOQSqPvzCU+FDs48UBJzolpVrPhw1wFH6okbHk1+emfQWI6ysW15M8spJ+jNbbgnm19KzqlBFpPW7sx1qN3p6AsHe9Hk7jL4CAdI+B7tphN+kJMJUvqLxpW1Pnb97iF+yH2Co1NjGFcnSAJXF2uSDVzXMMiL/wzpmUL2f5wrO6q9vaEaT3zHNZOis2oOVZAY/0kMsCNOU0JmZRm8mOErZXwB0B+s3Q14rkIkzK0aZQwQmr86iRrjTo50RSmich/NZR5JIxWrN9sdSCjNbNbU07I6IXquj2AwKGSWkpfqclMXCkdz+rWjVMVOPhn0Ci+lfMB2NPoV0uUPGl2x5VEooP80ozMKtlmmN5Xpi05Qr4wdf5AhFGL3ftdXBL/kZAzR9o5IQHPBpYuG2m3BDudN5qd1JzebBuVS4cVTELmoRrrBAIv+Va8KzUgmRsItIPMXJTB8Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8jGzdfY823XlbqKFuhGlWuO7yO+Co9MOiHAFseB6OQJDY2eavw1B7GhSKNAN?=
 =?us-ascii?Q?TWmYZ2dOQdsOB/nmEylgftKga/zYxdmb9rSH7FyxdFSGqyS/w6gpgTvHn+F8?=
 =?us-ascii?Q?w9jfotZPHpuT2qL1hjLzDhLTCdaluat0lvoZ1XMzcMf+YrokZNjIkjZSczCf?=
 =?us-ascii?Q?1SK8m4vlceOyxQusuiub1Q2dLu4GxcxifVVG8qKOXjNvaiVd7ZNvAKQZkZqA?=
 =?us-ascii?Q?9DcBYv/2l3rPo6EfPvo09186v0SjNZCuLg+i6TxPwbBGT1iWt0l/T4SqrPE9?=
 =?us-ascii?Q?p/P+vW+Uay0AYg/S52T4Ws0leGdx6dxBGVxGTHOss5VM3k1Ynof4WsXcd28C?=
 =?us-ascii?Q?t+JTwQFUPUwLuMbOIpsGucUPPXqpYNFpS1Rqft/+ckoQzpUvP6rsoJ6Rfyig?=
 =?us-ascii?Q?kujNu3yD1ypY93W/9ZktImMFYUYxO/qD8NTPs90X5/N5uC4dDI83s9ktvFGh?=
 =?us-ascii?Q?SJJMSKAf6U9KmCVG944CV3jJ2dhAmIEsODb6tWWJn5gBHsYN5BKsmFElwFns?=
 =?us-ascii?Q?aRPUIMcHMH8/fO5C4fL6eSxj2eW3h/Vf9flp0uX0xP7TOEYk/K/DToxjHnMd?=
 =?us-ascii?Q?g7ogdZJ3oBd6h/zlj7gsLw6afwwEAGSQ5IBpsNNRMp3Uqd+0PHssJbf2E8Rh?=
 =?us-ascii?Q?is67emOpY4Ixlgi4pse7sS0f1oVlswrdzmoyOPvp+OuvWLJNjRCUSyN9JKLl?=
 =?us-ascii?Q?ThjifhuExP20ssHkYrK4luqWpS1BjRKIAoudRUGtzBQ3v3CPSPXJ20S2Nx2x?=
 =?us-ascii?Q?u96pfaOgE1zU3vrMal/fnykMRnhPQQqXX9iR4JSzkucWMl60pDp6yapVBkAY?=
 =?us-ascii?Q?jkGDXFzs5Xgte4S91RA3edBRkBZWWXt2hrcqoA4QcMRUFf6O7EbTcDdR3ljs?=
 =?us-ascii?Q?5t5sHLZEIs4v6GjU4oWBv5tEfM2tdSKjwnp6C39kY5cW0v8R1QBtSabcuw78?=
 =?us-ascii?Q?xSnw9cl36X0RRJ3JdPRhizNSkNIudfgIZ3w7bZZVKgCScXvBxwVcFt5wz4Y7?=
 =?us-ascii?Q?+9+9e7IL2wrwP6px4acgDNt45Y50H6QjQ1WBVnJ6Z6tA23xvRL5OKG1DBk/f?=
 =?us-ascii?Q?D9jEhYddAHQ11I0l9aYxSsizGW8e/AmmOwfws0VtGClNUkTvKbARZxigzK2W?=
 =?us-ascii?Q?bonH+f7SwSH69BCSRK4J1aLtDdS3hBloqzhOeuqJOiaPDYV+fvs+yXX9riVR?=
 =?us-ascii?Q?21SDKEiMlxj2QRh7Kw5HatvnxdQ6NUh9zEGRd2gSa75VPEAzelWOv/DxpVIp?=
 =?us-ascii?Q?JWihb9osSjNfIt7E0SkK4GupkJVE9GfMVvwo4+vJ0iPAQZUdoezxCT3OaYvO?=
 =?us-ascii?Q?U28MSbnKk0+xPhlTUYOvePgVmQuuV5nF51PsYAMpVSwCy2Qkx5icgnPv1H1A?=
 =?us-ascii?Q?zbJqOCRdNv5qF3PafUMY1DZ99z591X3uFZKOcsBCfYaMLqC8pWAND8TFc8DT?=
 =?us-ascii?Q?oKCzrLFav7JnWDI5jSsa+z6eb1UBOZb/9Lqp+zcYFvVZyPjCl/6O33EY++y8?=
 =?us-ascii?Q?iRE1VSU5diyeDHCIDge00qNhK21pgPKotZVDylxI6WgvnMEiyd6Lnu6Ua8UG?=
 =?us-ascii?Q?f3H9emEE8pDCV/wODoT0e/jfDSbBiV0sUWg2vESgW/ecPMmLSuokh8rQb7tc?=
 =?us-ascii?Q?pA6zG3qq8IdUxdYih6PLMuwlrAyGs04Tc4YXPXsHUXrbpmCDrfCHh7vVxhLg?=
 =?us-ascii?Q?f7sm74fGJv5uaRWnxCuREJJnyooC64B34bIM+nEe3/bRydS+pOrcaeymVGpF?=
 =?us-ascii?Q?vLqYV+8PlA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4b052c-0bb4-44fb-e183-08de81262299
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 17:29:52.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG+rq7LhTytpCxTrQQC5zilnjlePjnVkUClO9oB+o/hMgXb5b6WNPbnSdX2nK9nuKAoYiVaYzxh7oj4XDMxKSE8zYedGj++5AbqCinyCSIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6926
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267545-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Queue-Id: C82332881DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu, Mar 12, 2026 at 03:45:26PM +0200, Vladimir Oltean wrote:
> > Thanks for the comment. I took a deeper look at the ksz_switch common
> > driver and I've started working on some patches. I'll return when
> > they're more or less ready.
>=20
> So if the common ksz_switch were to remain preferable, we still have the
> problem that it's very cluttered/abstract and impossible to follow and
> ensure correctness/lack of regressions for other hardware.
>=20
> Bastien, Tristram, I've tried to address that very particular issue by
> giving KSZ8463 its very own dsa_switch_ops structure, which it doesn't
> have to share with anyone else.
>=20
> I have no hardware to test, but some patches are here:
> https://github.com/vladimiroltean/linux/tree/ksz_separate_dsa_switch_ops
>=20
> Do you think this would be useful? For now I've created a common ksz8_set=
up(),
> but it can be further split into whatever granularity is required for
> ksz8463 to have its own IRQ domain operations.
>=20
> One could conceivable walk this alternative route of having independent
> per-family dsa_switch_ops and only call ksz_common.c when something is
> truly common ad infinitum. We could use it to get rid of dev->info->regs[=
],
> dev->info->xmii_ctrl1, etc. We could further give ksz8463 a separate
> ksz_ptp_clock_register() implementation with different PTP operations,
> to address Bastien's concern. I stopped at only 19 patches though :-/
>=20
> What do you think, is this direction something worth exploring? Does it
> help with the PTP IRQ differences here?

What I did was to simulate the port interrupt mechanism used by KSZ9477
and LAN937X switch families.  I think that does minimum disruption to the
original code.  That new interrupt code also allows interrupt use for
KSZ8863, KSZ8895, and KSZ8795.  I provided that code to Bastien to test.

KSZ8463, KSZ8863, KSZ8895, and KSZ8795 all have minor register differences
so I never did a single driver to support them all.  In the original there
were separate KSZ8863, KSZ8795, and KSZ9477 driver code.  But Linux
developers generally like to have one big driver and so eventually they
were merged.


