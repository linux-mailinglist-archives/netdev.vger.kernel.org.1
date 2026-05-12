Return-Path: <netdev+bounces-287226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHbIAh9TA2pq4gEAu9opvQ
	(envelope-from <netdev+bounces-287226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:19:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64003524882
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91EC3131AA4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882AC3C5835;
	Tue, 12 May 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="dRSWC7b4"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DD3C2BB4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601333; cv=none; b=XGSJz6SFNbtxa9Qoka+rBq9K12QCALTGT+y+47hPvE8kjlGiAormKWBeFtIYY+ptQmD5SpDtqIFzJ3qJa8bG5AYSXLCfMPrG5Xj2SqFQxNDyAD9V2SCq/3PN+j04EHJuWpHRh1iSr8DKGgS7ZsLhV48wgCaQISanlIqqPRs+eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601333; c=relaxed/simple;
	bh=xe2g8s1o2WapCZpSrDK0PGf6EBH3dmNrzJFhbGlHJq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AnpF6aAC98aaiVzW8GcQbWy+Vrhp8keJuFLiEd0dhtUePTqlNBBAYOnw6EvKMYIL9Mm+x6wNEjvGdz0mbbMWUC5oU2Q0vd1nmPRRaZhmdt1JkCFBPnIt92QA9FHh0IXo/wCzI3uwlSYJ+/wr8fZZDjpuPnq7gY587ArrtuHSOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=dRSWC7b4; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778601331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xe2g8s1o2WapCZpSrDK0PGf6EBH3dmNrzJFhbGlHJq8=;
	b=dRSWC7b4TzREfEvRjvRFvA3hXEXN19MZPvEgmaF6+t/H0VZXWv2GuX5PO28NKLcEfogyJr
	gBnvEY3G9s/zo8yioV1NC5gr41BXfnqukjUu6FVrTSYnfIcyv+MAMLhLasn/erUWBwNU3c
	IyE1mvF2FDjcObZxWOEVAtZ7Jn96EOm4RGMXEG6uLOw1BeLuSnpNCXF15f3wIW+CAKzcJO
	OO4Y1XYpsPIRorpjUNpYi4kJj1Bu8BeZEMjV5VxiKe6zfgLzEShBUWqoWVZzPPYHQ8YfHv
	eyLob9elzpT7Yx7PrxgHaOe8cYL33QkyoxcajYzheCSmbZ5fSLvvvVs96Dg8Aw==
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-13-_9CgpwEaO-aChZm1441aEA-1; Tue, 12 May 2026 08:55:27 -0700
X-MC-Unique: _9CgpwEaO-aChZm1441aEA-1
X-Mimecast-MFC-AGG-ID: _9CgpwEaO-aChZm1441aEA_1778601324
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB9102.namprd02.prod.outlook.com (2603:10b6:8:132::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:55:20 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:55:20 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Thread-Topic: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Thread-Index: AdzhcNrMIlF1yVpURhiYlSATodqMaQACw4oAAABKvUAAAfpCgAAoqFHQ
Date: Tue, 12 May 2026 15:55:20 +0000
Message-ID: <CY8PR02MB9249E8896247662F5214B46B83392@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249195FE5BD6D7FA31F4D1B83382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <b6af67df-1217-411c-ad47-f9c3e556d345@lunn.ch>
 <CY8PR02MB92493D7EA2E83DA6FE73B10583382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <954b5b1e-2850-48ac-97f0-f9ac6e52d461@lunn.ch>
In-Reply-To: <954b5b1e-2850-48ac-97f0-f9ac6e52d461@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB9102:EE_
x-ms-office365-filtering-correlation-id: 0769525e-ba1d-48ae-a8c2-08deb03edef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|11063799003|22082099003|18002099003|56012099003
x-microsoft-antispam-message-info: anGKBkcXqbkA/NjptqJ0yNnNvZ8FyWbYmw5f1/JpH+Xro/eIV9EmIIaltE0c5XE2wrd6zdm3n/gK/tISpVcBn+vji8/UZt2BV0GQULl+MQykGZOYaRD4Ixa7OLErnxhDAB1FhwaH3DUZH67qSBGDUpQy1byRcm1lxs+f+/ICyXMHx8WDcmf2PrjPkZZr9txgclxxpmO3w6agouLO7GU9gJC61CRTsCymATviTQIgm6GJ8at6FnJpAOv9ofiPgVb/bbgsNtL/y9D5qodZ8J00LsAqa7G+IsXXftm9FYJn1DuDMuie3CEfFcYtCYlFxZ3/iHclTPUj6Le5WV08Z6ZhS4ApSuL4CZ0h+aU6sru1vsc1taEFvzdzb0XdpzX8Wu6scNac4iFfnZQkmNlidAvSzWLvbq3WcSIWYKl9kij8WPwHFxoXdfhkSW3woc1qOD4I/qQCduExi6sg8Cxq8m1EWdnZs5QPcLlbxEMBx1jVJ7ZJUwohTg1veWLW2pfhWE7RRporqIWgueL4kZJI3bCBHKnHTziupjFig8SXBGfxyn/qFEj1NF4bwCYllSkZch46Uxzr7OAHTfo6QpfFgraI5Jt/A08uYRS1oIj0S0XDvJS+Eu0kSYuPY41kwINO9ZSjep4lAuPYkAZjDnGLcbKxV7pob8Sc+78IFYRINO2GHDiJ3yZ5H4lBOlshTK1yDcRPLmRrux7jQWJJUyHkCO865IkyGIBB7JjUOVJv/th2VWKDM+EQ/wQaNeEgeTx6I+8R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vic5pYFNUM8qhien1PL4QQpBr4RSGNvryvXSnoTIU6wEW1WmhhvPIYM0OoA9?=
 =?us-ascii?Q?IK+AoDI53R4L5dwgv5M957SjOcPMipY30FtxCNEyAZj57yp5AAsETps87Yu4?=
 =?us-ascii?Q?WcjeSKO58tPez/qXdfszX/stIyDABiLWG60Xb0FeQjnTbQTVh0D45VPDwqyh?=
 =?us-ascii?Q?Q/UfOHy8pxMleet41YayGkEfsXpgL1MWgyKOdnH8ANrwuw0orKveNfFJKJLk?=
 =?us-ascii?Q?Mt3XjMzgi7xgi0fgVRak2ZDBYrO/9pRCUEAW//bDNIn5YgabigPRTML/kplt?=
 =?us-ascii?Q?2bmTuIQDSwFRScpXecHEnGOKOfM38qE//i27ZOfGm7FFERs4R5defZV5GTY/?=
 =?us-ascii?Q?tHCiS/g2S6Zoue0usET3jSUAI9inx3+VNxl8r5p4N2siy5sNsHuSpK0sD/Dw?=
 =?us-ascii?Q?dwfw4dVUE7lB+RRYIlh6JJHI0M82uWhjk8bsLvvDyRXt4GrZpjQsktkThAxn?=
 =?us-ascii?Q?uApSpfaqR34Bpd5RQNlgCXWnFph/eGHGCZMPobQUeEFGdmMwfgpddUqdOCfw?=
 =?us-ascii?Q?G0EC51A8iuZ7N+8V3bxGbdqkoT0r+ibORZ1aWDrFIID7/AZLF8r0CbQwl9Pj?=
 =?us-ascii?Q?6Pb6g8HT/3JDu4zeNTmi3u1xxpCaWReaKndbuJN+/Q3ibXn1LRkzmOYPDc6e?=
 =?us-ascii?Q?rfxcN7WOLuMZRoa+uIenXk4qZBWGe29nA9Pb2tvtQ1ljcaXnfPYSQiD4arGC?=
 =?us-ascii?Q?BjBTp7dBSy6VZwYKJbdRQ43yaFdkaeW9HVTYyB5cm55j4c0VSNJE/bezIAGl?=
 =?us-ascii?Q?6MKKQP8aPtLYsc1XeaqmpJDW9Rv1dIfCTDwRRy9jZdVludFwhtvfTqdEFCtC?=
 =?us-ascii?Q?Vdd9zvAcHbX2s+DLwQ3K2Bjd/FIdRszA/wPLZdmME5tiu/+2pRAqJC+2xZPl?=
 =?us-ascii?Q?84/MpVjsmzj1AQm61Izm+RxtR0clrSQA7l1ekXCDeIds6mgDM6vCWMg5soIq?=
 =?us-ascii?Q?rH5DXZR1jSdJ1saMeGcbvUqIU4Pel6veOO83904+TCPc7DJOafncZ7G10oCA?=
 =?us-ascii?Q?fEYuMGTCP6NLo8EtUNsazFex5NyFXTUlT87HUSejKU8LoVqR93r1WiYRtkVg?=
 =?us-ascii?Q?pCjTO5R2p7MafKwSbmzEohNjy2jdZXgTrfJtFvDH5YeBn/itPuXW7hNzZDr8?=
 =?us-ascii?Q?iKLSG8aNvFUOin+gqxX1PyIQL6jETmGgRb9CvuGE+5xfoqCYNF36+sdvh3P2?=
 =?us-ascii?Q?H+b5kGUo4Y+MOWLP0EwukUiwgj4cNnvHug2jy1+f+JFE9FuzuwSKv4PtkvTY?=
 =?us-ascii?Q?LQswF0EuIVN/KkEGZm9d6Q68CQz9guiqOayRq2JtC2DzPH9c2bhNuF4QcBdi?=
 =?us-ascii?Q?kBO5tmUAhwlV9MUjGkxWhL65Z6LTPmfjoEPTiHK6D6ZsDnmgCjNz50q0m6wk?=
 =?us-ascii?Q?9BqJKcTInpYGr4col2A5nyfwwXnB7LKMZMPcQvMAQIeyaMUc2FBN89i1I8vJ?=
 =?us-ascii?Q?StlqpaQtBd07BZiKYTTxNKaWIDpDIJlBuMJGdJbVq4+khzaXW7On4KoUmRJ5?=
 =?us-ascii?Q?KBxDk6SHtxiir93/DiLOpTbPy88zR2xHTCROslQJh2ZkYJV8m+X8olan+jCM?=
 =?us-ascii?Q?hW9ShyPpy2UZRfZqvFpnnNtsegeu3lfSLcRO1pZqbOHRYdcjU/89K8DBfA0p?=
 =?us-ascii?Q?It1qsbk/n0jIlYGRpNg6IsITwdJsGfLUD2z4A0ezSqs4PyTzo9PbtDD7juPo?=
 =?us-ascii?Q?qjaRXH5szF3YZvHVPkImlqUgSaqL2sNq0/7y1MioOftTo9ceLmTM45Y5RNQ/?=
 =?us-ascii?Q?MvBeMSUX2K1WP5Ghfq4qzS5UeD5/es8=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DaInFGUA9O0MECSH7LSII4A0MZFeCiCn2qNHXlchOvVjOvFdblUF2CLeh5GE5N93DbrMYypIhTzc/L96n1fjHfv1pSXGKFfWLWoee6BpR23okuNBa6XDp3rQLVCM2AIMoDwgL20BHzYduJZlJIff8N/0dSuZciQOJu503VE0japeHe/5omvkk7YPRD7To7UqP4xgXPHbGFjz4lseBKmiTfJXqm64C+cVUay7hgb0noyemTWfqKnll2zxc3xLQvvXrIg+U1n6y/PSxiIvQmLImpFvNcF7TzWeV3i3viIRXwVqOUFIwcqKiTtyP1eNbGR04zPgJDwbT8x742Z29hxGsg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0769525e-ba1d-48ae-a8c2-08deb03edef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 15:55:20.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiP0tQTEPn4OicUaV+3PO6MhAHo0LSIHBebfd5aVLwBuIMnXw9+wdIduqgr7MVmQuzYr6S5fMgopClXcWI7y7WkIX4shFvzpNwo0Hb75I6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9102
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ff6nsRZpuEVLBojxM2Z6qj4CrzOYPHPqS3BM2vObzPM_1778601324
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 64003524882
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	TAGGED_FROM(0.00)[bounces-287226-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action


> > >
> > > This Message Is From an External Sender
> > > This message came from outside your organization.
> > >
> > > > @@ -163,7 +166,7 @@ static int ncn26000_config_intr(struct phy_devi=
ce *phydev)
> > > > }
> > > >
> > > > /* Directly accessing via Clause 45 read avoids the extra
> > > > - * SPI accesses required by indirect access.
> > > > + * SPI transactions required by indirect access.
> > > > */
> > >
> > > Please don't change things you added in the previous patch.
> >
> > I thought v1 is abandoned once v2 is submitted. Didn't realized we diff=
 v1 -> v2 too. Will
> be careful in avoiding it in future.
>=20
> Wasn't this line added in a previous patch in this series? Patch 3/9 ?

Yes. Sorry about that.=20

>=20
> Andrew


