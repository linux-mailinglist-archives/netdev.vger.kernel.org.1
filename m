Return-Path: <netdev+bounces-284260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ow1F2Wr+Wky+wIAu9opvQ
	(envelope-from <netdev+bounces-284260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6C4C8B4D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9DCD3003D27
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE4239E9A;
	Tue,  5 May 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="aJmZDI/R"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB621018A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970018; cv=fail; b=OMI2sKixCqtzTNdyo/bs1vMj5z/J1aQH/r43uDDc/ae8+G/T85nzYlyVNx0jx8o4LNl3E55WrjHPmDwUeq8OZTTreBNFbtyJKDWlNbKPQ1K5QSgNsN+vWGEkKYP7RybCEh8c1L7IwUkIzvgLhRN0E88dSVzt76eUONr9aiSquXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970018; c=relaxed/simple;
	bh=i4ieHg+OORAxScwLSNolgtDng0VaZDB+HfkTXUGXT04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNxMUmBm6SAjbNGCdOlPGy5rFRsG2uhEtd8hrYE0EMnAN7EE2o/rcbHP67j3FNpsRiVeYjzIAy9WFlkZn6knUq+VgdJkR71rFlHNPo2pqrw81QDVFabcMiPnzchw/3AOMkUWa2pNFChZpKcqJ5NjYbjEg6InoBIspyNV9K+gy7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=aJmZDI/R; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFhdnMyGr2fe6RYG2PqmfgjLgAw5UxY4geib/dvSCmcwO47a/ZFyxzZALj3pHeIXGyk4POSsTidIsLe064hKehk/+UfzJ4MClvyR1ZiVR8gxSpQhLgUHWbLHLO9kLeO+GnazBcZ7e88vZGNo1GvlLy86fzwb/GI/wZ0Y7i9Pz3tlNlagqTe1NPYq3rjcROmXJutibBW0JGpdm8SG8DEn2ybOgEz65gove77sMq7ZkmgGMj5xV0+fb6aVBPR0rlbw7q3o135KxK2QczN85bIRXwLwo9C4GtO2jN2/Thzbu30pdxEIqzWEGpYiFkNmB+HG6780Afv72fpcfaGtQsQ7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9nKivciaRUziGk20N7Bd6TmSicGqlJiKzVSJ033QBg=;
 b=U/4ulPKjNgrS+Tkui8B28vDMDbAeN5VJnPAtygNjumue4kyCHiuy/hzmsVV9wID8ASrKMaBnxggUukIsmdOs+4xaC2kb4SeZdd8//lLF/FDEFL5255vYB2M0ZRzQEaf5gVHXwCN31hWjmwSBzAUyYLVNSe1Pv/Ez1PDUOt1KhvV88xYVSLIZYcVzbGQqBE14s5CMNNib//83V8SYuXctB4IKyN6DRri10gzwO76IGs4LZiaaRD7AmvVnUdrqjHxqilmXFjxJLr/YTvPdGBanjPE9a5HfudW6+H/5l9iEpSx0DMhI+ZVYrwx1EL9WYd/ScyHLIgUtjwiEgFt7XBa3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9nKivciaRUziGk20N7Bd6TmSicGqlJiKzVSJ033QBg=;
 b=aJmZDI/RVmUihYCAl8/If1viHdVfognqG2m31swUlp9A+wrNG0s5Lg/T6NwLf/Va+gQd0ufdUvSPgb2db06ifhdBHMjhxFpdDvfyD9RBP1dI9TCUJ4Vs+uAzBGCQo4YXCY469xC75VSfGX5mBAeG3eQzrJESSLP3KBE0f8stbXUOTQ0usfjTw7gvo7DIKvhbacLUZT1moFjtppwNZgmogDRw3cZED02ypJ4pOmVN+yo24cszNGxH5NHIClRoUjim/5zU8bguX+I2Hi5Bhwncrcte21UAtD2D88DkbNM89/gzYhaPihFiZoqw4takxYBiOe+VCx2BGa6On9ZgAVdu4g==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AM9PR06MB7330.eurprd06.prod.outlook.com (2603:10a6:20b:2d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:33:34 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:33:34 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
	<qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Thread-Topic: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Thread-Index: AQHc2+C9zkursVznM0ykjVaFtNrz0rX+6qiAgAAws/A=
Date: Tue, 5 May 2026 08:33:34 +0000
Message-ID:
 <AM0PR06MB103966EF99B706158C49CB3EAF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
 <3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
In-Reply-To: <3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AM9PR06MB7330:EE_
x-ms-office365-filtering-correlation-id: bbc9aa4f-1310-4adf-7ab1-08deaa80ff17
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 QLCnHEBj2zJqQsITzzjy47Wm2Wxi4r9NzEx9y9XiAZsCjNjyEeUqY4S9GiBzP1Xo/2LCcMUTJ7d5zbXxxXlOdgbN0U6oBlZTDJNq1A3G8EyMHW105++3GUx4NcIe16vNk+/BWFhwnDlRBlfeF07qucUJWH4Qq7TN7VZs5O2vy2GIaJ3shBtWSMcio6VGzs8mB/973Sx9Phr8lSRucCEKEIHDUWW6eN2LvcvIWmPbNrWGDyZf3mpGMkY/gY6sME5a83gGFoTC/Y7WLYTZhTLLwXG3+b+I4KkqHYt5PFaINZO7GMRKChEZALNSOmCzlX5IOhtzluR1YJ5Q+2kdbsxdJCP7uOMx29sMSHDAq9o4tFifNRHqWIPJqTeMWhT+AhDSqugL0kNI9f+T47bWNGg5Tq++t8epwMuPxNlVIp5VPPSYGCrbernG7wla3wOWdLv7+S2/+iaEGsaR5OURDknsc/43VJ/GXXYs+oanod0YPFlDvjVZjMrcezPR2BwZ1XrOUNPAH2TmWS8RzvrkwyBAACnFr/vcME+JXldmtOoTSpmhh21LICSGI3/w7/g67B7JCR6MpTgk0RavcMEBkSXHo79GvdKo0RFwGs1iNZibZO0HrO4bNjTLGIM6FqG9Vug0AjXxzmTSOwbNzvnwrSdrZEaW9mc7Cx19LY/UDLVnavF0UHuRQ4/9/LmpdW9G7m4Q0XM3IKGGoiWDbGxqN6dbx9D7h30purGgHaxmIUZWsrpaSd3kK26c0FTzVrShrU4g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dyubrUH/WZcCHjraKJ+Ja18ojDUeXAU8EekDVEjpY/lM8EAelHcscvU1y+?=
 =?iso-8859-1?Q?ijPowqH5WQwPBDA6edEw5y+3Ba4TppuqrUkRpYTLFwdZ6UFAD0x9gqZieC?=
 =?iso-8859-1?Q?H1yG5uzkWgWSj6eq9p7qtaoiCC2iPIM7dsTea2vQAf4cUQLPU8aux+5oaZ?=
 =?iso-8859-1?Q?UvNhqUpGAXqa6M4pdpSenESMDpmqnZQ//OrZ59YlRETg4s06tLDMcnxzJr?=
 =?iso-8859-1?Q?drb/PZ4qlAS9KyB2bJ/f772+jIBuNQepjP/8/duBjmsJo4DRx6GYIEJhlK?=
 =?iso-8859-1?Q?YBvwgWVuJ6LDXByDLURkjL76CO2vZHCYEIJGcl7WfFbp+SbxgCihFf8XEY?=
 =?iso-8859-1?Q?F185uIbVWsM82F/Z4DX0Nz+r1hBRbYGv45zSTO1e4g1bcYkRD6Yvp5vP9l?=
 =?iso-8859-1?Q?y3YOO54zrgGyx8y5z4TgN/KhQB/0lCgSoLTQiRVtSSkgHp5sasBAEzu8+9?=
 =?iso-8859-1?Q?ieNtUgJs1jjoyX1J1XDuDaqIwBKhANTMuExczbZ4BK2TysK8ou2XLY6QYS?=
 =?iso-8859-1?Q?pcXfft8DrqEn/LpZdLsd15TdBysvqe2J/+/meJBmOBEb+u9mKqH1yrK47x?=
 =?iso-8859-1?Q?R1w6NJ58IkGC0Cjxq9osRIAG6V2+49bRVqlDvvGWeggiVFiH8iwXwE9KlX?=
 =?iso-8859-1?Q?CvW8kbLnNx5K1BQ+T0cKWUyjV6vRhwkl8DguiVN2xUlfYtSH1SoKPrSlLJ?=
 =?iso-8859-1?Q?gOuF0x5rIicHOd713MIcSO/FqYRK9XZ1Frf5zz58UpQaHuYAVdM5RF9pvu?=
 =?iso-8859-1?Q?Z0tDCBaoQRMr86goQ68ITE28/G/FWUn82I1xRMrmavruw6Owo4QLYbMEE6?=
 =?iso-8859-1?Q?nIIJZLt21yGnOed9SM2NpXDdtxCDQTbbCv/mudFEdVGNlfT2d7KfpTtI/j?=
 =?iso-8859-1?Q?vF0ESevhmdzozrVKUdzoJ9qKVJhdwhGhksMYbxmRt/ucaxMVekqSmzRab/?=
 =?iso-8859-1?Q?vTIJw7T3I6j2q6WKUjEMlMpabeUjmBpmz6wUvDrakMml5I7wIKgpLoLeDR?=
 =?iso-8859-1?Q?V4bRTJwJxrMMCFWD9CFjVWM5kgHGQS5gY0oYcILyxNbUH6FcZ6yzyH8Lj/?=
 =?iso-8859-1?Q?k2G/+Uhc4Pclg/ic+HoCSruSH/nDPU/MNYVhbXpbBiAtNU/u1AoRPvgqsw?=
 =?iso-8859-1?Q?dFbWKpMph2LxebFl7DmrWPkfCii4ITA7t/S96G9Xw8WQnTSkRH6Z67pjYJ?=
 =?iso-8859-1?Q?Z2tjLLvZGdQb9aP2VenVMvVoKUxBdt2068vH1f5eBRJC8YS/eQRJjHCKLG?=
 =?iso-8859-1?Q?pv11Tuqom+habJhVNwRsKYUmcAE+7pbDC/EweG5fAQ0De45CgvcT1Nx665?=
 =?iso-8859-1?Q?cl7+cR+dk7qNj9kvNTKHZ1dW0Z6BJl5VnM/pxMy09ZN49UzuktcLQMGrlV?=
 =?iso-8859-1?Q?vFewlZw/RX3KKFujZoqWYiSwQ1zMzzdPRjQQyJmSffzbKPp6bdY2KQpBLP?=
 =?iso-8859-1?Q?DjBVED4mkQUXIRpX/qPIMHgiwqSE9NfOObMKZLcjVsL/fmSfvgLcTNcjgo?=
 =?iso-8859-1?Q?WckCKe7R/mrNPrJx368xK8VjbJ/uttdaElsFAud/Ipz7SqzOdBkuX/OL56?=
 =?iso-8859-1?Q?XV4q90tjXdZx7S+zSRcO3F76nSKPhS+OrWnv02gCDYoebUitxtI60bnA0E?=
 =?iso-8859-1?Q?CDrcHlLNIpy6BVQ61YApZiQWS0B7Tg2wg+mrDAvH+ZQqck8HJSBUSW7Asq?=
 =?iso-8859-1?Q?JAKifHBKz+yGuZNFhGNCbu5hAc3e7aL2Y5sUMsiQG9VYveiZ+fsBD1DRd6?=
 =?iso-8859-1?Q?yTZxEwgz0KTIFGVm7i4ZZNnIYX/Igkkjj+cXsK14wQ4WEc8hE/9QqAu1PC?=
 =?iso-8859-1?Q?J0sM19V8cUI+BWVGU0HzH/uiacfA9vY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc9aa4f-1310-4adf-7ab1-08deaa80ff17
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:33:34.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZiMmhLNGh8y+Ag9wugV7lqUMrjdQUmUCLSp5GkHzsikZnjZ6WMPi5TPhEdJL5G2YX0+FalzsXBXmxtRQtBvWRCMTema/u9zyMjsOGjoeCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7330
X-Rspamd-Queue-Id: F3C6C4C8B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284260-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[hitachienergy.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AM0PR06MB10396.eurprd06.prod.outlook.com:mid,hitachienergy.com:dkim,hitachienergy.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

>=20
> Le 04/05/2026 =E0 18:11, Holger Brunck a =E9crit :
> > When cleaning up the resources we need to iterate over the tx_skbuf
> > array to free pending TX messages.
> >
> > Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> > Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> > ---
> >   drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/wan/fsl_ucc_hdlc.c
> > b/drivers/net/wan/fsl_ucc_hdlc.c index adf3863463f5..68f78aeabdc3
> > 100644
> > --- a/drivers/net/wan/fsl_ucc_hdlc.c
> > +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> > @@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
> >
> >   static void uhdlc_memclean(struct ucc_hdlc_private *priv)
> >   {
> > +     int i;
> > +
> >       qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
> >       qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
> >
> > @@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private
> *priv)
> >       kfree(priv->rx_skbuff);
> >       priv->rx_skbuff =3D NULL;
> >
> > +     for (i =3D 0; i < TX_BD_RING_LEN) {
> > +             kfree(priv->tx_skbuff[i]);
>=20
> I don't think you can just kfree() an skb like this.
>=20
> I think you have to call dev_kfree_skb_any() instead.
>=20

yes you are right or at least dev_kfree_skb() as the error handling code in
ucc_hdlc_tx does.

Thanks
Holger


