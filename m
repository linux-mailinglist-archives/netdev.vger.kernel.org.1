Return-Path: <netdev+bounces-291607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN4CKqJrFWoBVAcAu9opvQ
	(envelope-from <netdev+bounces-291607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD35D39A2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC2D300AB0F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700B3CD8D3;
	Tue, 26 May 2026 09:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2139.outbound.protection.partner.outlook.cn [139.219.146.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905612C181;
	Tue, 26 May 2026 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788310; cv=fail; b=M7bGxYkOEH9BbbSVhIRt3vmqXwpKbn99d+jfsku1+YdVVxVcBNwZCQpCwuDkdOyFVyRxNjGGkU/LMvXLU7jtorYcQ9EEm4j07pkl+gWSKqojiqQncmGSDtBXdRfGVATo1NKqivx3FA+ZYvAps9Rhg98AZH5ZX1r9TBLok7nGg94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788310; c=relaxed/simple;
	bh=s5oaSmxiv0LG+nWSCPEvXWI0AxXUu8722II6+I0DiJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/fQgPN8n0D1LOHiLVrrD+d1uQahANuouKp48EXEsgJV1yKNtvWe7rIRGD7fiICFa18unRZKkkdPgJp/7Qux2wAjhBtgoaWsxDs0Nkvm3RULP8zLCCW/jTuppdo/kwggaPajQ/Ce2FzqcPcL1f7nmXcImodJxCdkBjAay0NhtJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMRH2oSfyLziL8SJklI/ZhXYKQQdr5iCtab5Q5qjU7fcsmx+Pml1w8h3hVF+kNMEHiZ9PbJ8VU17x3QqtATMZ6YkntX7LSwcN//yqRAxX+Jffhskx8jeeCQF5zOGvBeIxHPPrA8Gs/8U71/7VFocr5MCcKl7P8oDRmKLfP1IZVAu0ki32y5A3yBIimSY4FCw91Tl6J1TsCVR4kFbDuCKeKDgq1Z5VUeMtpSMCDBwtrzhWeLDnxrLWYjCYrDJSacXjO5Cml45Tdng4FmERc5paFE8Joag/dxBMDgKdjm5qAZu9m8b21USNf88D1PFTIDFGTMhtkt899YIo1KdlrAOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QzOmntjXo0luRwOiCWhQUn/P+tfa2o8yxVfFo185/M=;
 b=BaT72eDBRWDQcdgfUQKwEJPk7tASTv1PgzBNZ6gi9VLIxx82Xqvs/BDCDNNXUHGlgXK6RllLCHvRKtq47JnfiprLAxMHDmxPXXRGCpEz5fqSOwU7hr2laHz7q11VSHpKzIvCkvqeUWPVEQ/gTxBjkxWG6Va2TEvJq8e/Y8vkdP36DO++AFDjy4pO1UEl4tmyTScp4sANFSioHJ/SuY/ttiBDKTeakPVdUaxPIad/59qKlFX6zQVWHlldvXPFcRjIsTBZdvNs1J3ShzugF/7voKIwlY8/pi70/j/EqFA35uBzG/tbp5WItVm/mYUnXNYDWsjMJVBEhOTUL0VfozuL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0560.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:38:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Tue, 26 May 2026 09:38:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v4 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
Thread-Topic: [net-next v4 2/3] net: motorcomm: phy: set drive strength in
 YT8531s RGMII
Thread-Index: AQHc6EFJdBtYdKxmfkK4UCfcD0QtybYXBu6AgAkPUyA=
Date: Tue, 26 May 2026 09:38:19 +0000
Message-ID:
 <SHXPR01MB08639269933F699218A18B33E60B2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
 <20260520101310.128969-3-minda.chen@starfivetech.com>
 <c7314c0e-fcb6-4484-9144-57e44a42f270@lunn.ch>
In-Reply-To: <c7314c0e-fcb6-4484-9144-57e44a42f270@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0560:EE_
x-ms-office365-filtering-correlation-id: 6c02ace1-81a1-4574-be2c-08debb0a857e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 biDqQjWh6pkl91V+1Sm6Tpt88q7JUoZVt4G8dcotxTUP+0MMe6tv0FVh2q5o6nY+kVPCR5hpWi7Puz4AvYv53fwK/AiJXke5qUkvNTNfo3UeIhvFAQ+M0sCGVPPPLU9J1BHGW5s9ZgYBoF+11lgv7F+544Tf80lR1+lUbvdR/frh0L9EheQvgOjoVXrvKS32KvaE7e+T8/saaYhytsq8f3h4cBFEFq3wcuHzcNa6kNnrjhMGJHA4ERqVitJM/VrbAHe8a5bYs6OqaeXjZkCLHy0rHX/Dn++mpRWqRWF6BhD5TPo+yzbEfGCAUxGT64AP9e2RFMmH/w8hNr71qWr/Saqcw+riaJabcJDcMvucbVJLleRteLeAL7qhCguJbADbDYc1EIYLEB4Qvb7RtEOhAGfQLKsHLy8EYsYgr07HnS1/0M6nJbi6McHckWzyLvJ8toyEv4M4cCTynIs8vOj30fSFUXSN4mBGmbkTjISjB/lybTA8/NyroABAV1KShCjByhyvUlNNe3KW0JgGBszQqiG661sK1krrfVFaeTeiQL/qwfWJjo73txjXfCo6R2Sh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wa9rN2xW+/ChoHjoUJMAMu11pIhKm91O3pM+NYH+kmjvdosMlaG4GTGGFSVU?=
 =?us-ascii?Q?FsO7BOEIonr/6fgmN+ZRSLWe9woLnZqK/S91HzfAHHsYt8H5eHWZ4Wk1sdRk?=
 =?us-ascii?Q?ZP7UJUB5dL++ZtcAm0OYhPIlPmvwM34vaPXAbxxyAutoLv17JFg/GWylKq/y?=
 =?us-ascii?Q?tuIyrLRG8J3oj1aavGMm0Q8paBtrqgWgI9Y+hU5fDHGtfP6OSiNcdGYA16zM?=
 =?us-ascii?Q?Tek2NBlW4LP0JTbXZYtWSzfePzrkvitXhrdFx77YcqVFJqC3Pbx6LPmOunrQ?=
 =?us-ascii?Q?EC5WtGRY6g/2uM1hTzOQJxD/jKFSjeXM6E31vIdApasxakxsdMpzIzTN4NWb?=
 =?us-ascii?Q?bJ0trmHraA/m8kq8SYefntR7PcDyOwn8HJuaISxseL/Cz6QLNdzRB7Zc7Blq?=
 =?us-ascii?Q?7uNjwpptfuZjzDMsd8ULprup/8TJdnxmTlUVRhNEYkOYATD7acss3NnhSdJe?=
 =?us-ascii?Q?UK/ZQfGv2+UGzdxvwT7Alca3e7uUJSCUvptp9qqONf0Fj4oDMxZz8ay6s6wX?=
 =?us-ascii?Q?SRWwP8VMM7fd1waweZkofICrzJaxI/wkxex35dSQoDizQLUugYufuf+L/DJt?=
 =?us-ascii?Q?ZZwMe/ymULo+tW3cEX3/AFfFKgU3sTGAxU2pSCPLUb50rlIh655d9grL8ls6?=
 =?us-ascii?Q?6iaUwzUCzu+IenTCp0enk0RYHlYt6WY4wtXz2a1dmzkNbHjpw7xoxEW5zZfq?=
 =?us-ascii?Q?VBEXkr7nnhh2bQzKWSdMKjR6itPJcgA2UXoNXaMxoVgDz2JxsmsdL5NLoCFd?=
 =?us-ascii?Q?uVcDalh1Zrj6x8MXBzwenL4PGOcpQ3Vj6O3Q1Nfj1vSlV5lE2ld63xS8og/e?=
 =?us-ascii?Q?cTmkUT4DUVshELMMq9lVtCtTNMkkrroaq3/tWO0wZ/2UkZm5lCMxS8sOiojZ?=
 =?us-ascii?Q?smWddbe3uM+/L1vTIKF/K0Z3lePHa+rBrMXo24s7mAacf08UDL7YAzeHxp9Q?=
 =?us-ascii?Q?u0sb6C9b0TPrbVz0V3RyfyCFHQPo/wKTVP6M656F25/mIJekabUu8IyiB8EW?=
 =?us-ascii?Q?HA9nFfuQbP7MErx1GlU94YhEi8pVn/BvxRTZN+1Z3ZtZjeDlYmYRLYBeo/S7?=
 =?us-ascii?Q?cO11+Qo2D5ykGe6mwjgGq3VRWey+ZRCbJr1rM7sAFXaxwy6KO3/hQvuSSrcy?=
 =?us-ascii?Q?vJHv3Q2fXydxuhHV44qyRBOf2uEhv1cgLbCCSkCDKX5exnAYIwWl3VN72G5l?=
 =?us-ascii?Q?xaASkeSeitxzYNvZVAZ0AS4fVOzvLLNX9hHs98ekr7D5wrMY3q6w6WYFs30A?=
 =?us-ascii?Q?CjwCOL/ZkGPnBH0lVnaANmYb04D5RgySymUKrJL/IdFRefttp2Et7fF/Oh74?=
 =?us-ascii?Q?sVDNlr92muQIExxg6OFkJywK3nqi/QrCoGWvSBqftNCCIN88B5s/S0KN2H2t?=
 =?us-ascii?Q?9eofZ+OKICqEPygUKylHU+mmymQJCubSUezxJGynZv4NCVSKxrMLMGdbgizS?=
 =?us-ascii?Q?T98pHtKUBNJd34E9TVATOAIohymhSTobF6U3jRfms6FkG1cpJHhcP6S3lnWC?=
 =?us-ascii?Q?LzT4TcDcgaR7JzLhYj0xurGq7dvHBdgpufNZezjlylOwqYKqWCNyCjSYhy2d?=
 =?us-ascii?Q?zl256y0xFYyV48ud6gOdxqp2a2KxHvzH0pPpmPUsfGPc14q2ycJk5InRyYXA?=
 =?us-ascii?Q?XHx6a7wt83Hf+J9kglwQgEbbdNxwhbZWhkjpqTDhhssTY2QC/pUiA3gA7/t+?=
 =?us-ascii?Q?SYLYF5Guy5a8a0MEGUvwXUZnATaf8S0irx3nzG5KIK0Y1BNYEtDzztUPWdOk?=
 =?us-ascii?Q?+zXWY4TXfg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c02ace1-81a1-4574-be2c-08debb0a857e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 09:38:19.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuC0eDjjNc1l3VhXni5WnOovERDb0UZfPvRi7+JXBsAT8wYQflg9Hbjv9ZzHkeWP2VnpNdsaisqLWFqb5HXIvkE8QN4eOtIiJvya4G5Mr3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0560
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291607-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:email]
X-Rspamd-Queue-Id: 33CD35D39A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>=20
> On Wed, May 20, 2026 at 06:13:09PM +0800, Minda Chen wrote:
> > Set RXD and RX CLK pin drive strength while in YT8531s connect with
> > RGMII. Need to check 8531s PHY ID because 8521 and 8531s pin drive
> > strength is different, 8521 can not call yt8531_set_ds().
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > ---
> >  drivers/net/phy/motorcomm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> > index 688679457ef9..3977ec5e45f7 100644
> > --- a/drivers/net/phy/motorcomm.c
> > +++ b/drivers/net/phy/motorcomm.c
> > @@ -1697,6 +1697,11 @@ static int yt8521_config_init(struct phy_device
> *phydev)
> >  		if (ret < 0)
> >  			goto err_restore_page;
> >  	}
> > +
> > +	if (phy_interface_is_rgmii(phydev) &&
> > +	    (phydev->drv->phy_id =3D=3D PHY_ID_YT8531S))
>=20
> phydev_id_compare() is probably better, since it takes into account the m=
ask of
> how many bits are the version. The PHY_ID_YT8531S has 0 bits, but i did n=
ot
> know that until i looked it up to see if this actually works. phydev_id_c=
ompare() i
> would be more likely to just trust is correct.
>=20
> 	Andrew

I think is Okay. The phy id mask is GENMASK(31, 0), can match exactly.=20

