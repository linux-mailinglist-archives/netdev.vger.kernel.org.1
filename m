Return-Path: <netdev+bounces-291595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCrZBMBgFWoiUwcAu9opvQ
	(envelope-from <netdev+bounces-291595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 638215D2D3B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D0993025C57
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57C35BDA8;
	Tue, 26 May 2026 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="SZgxtpoR"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021126.outbound.protection.outlook.com [52.101.65.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E633CDBA3;
	Tue, 26 May 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785873; cv=fail; b=b6HB8wDJlnSG+65Moq2gpG2SDNtqSSc3Ue/6h9san+9nrpYm+ABnlwt+H5RR+UUjx5i0zN1Qymamarol+Iu9IEU+6GZNv0eYON79b2n3XpllOzv6P8Ht4WPQp43puoBs3cH451sgEIzbO4oL53gPFjzotg+p47iAnIInlMMyyRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785873; c=relaxed/simple;
	bh=W/5fAprvjxWJbaJ6/q7egm91dPrMiYqBvGnz1PRGxL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPEwFF6Mgdqrm9aKUCO64iLvsgKsy0ij5+JU6xTMRtPk4v3etYffdphlVCEdpopGl8xjG6NbvxdfNs9AhwjvphnOSXy33y5UZ1xCRPePSPGzTCupAfkoe/H9O1pYJdHfMHOsbMeAN43nKNBpAOgXJoEGkpm8zA9Yp5EFSZzjQp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=SZgxtpoR; arc=fail smtp.client-ip=52.101.65.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvGvGj7PeOJIbh0Bb2Fgt5QivodY9WJPdOMc6bW2Pa3wzYlIJKHIp3oESCheL/ivPRVfSRowwyIJ0Nnt4aZ6Fi7am/053Ad4VwxwTDWNRcDgQzB8H8LO0nfyjYLPSZerwDvu0AHO9iJyHgM0dJFFKm1twgJtwA4MDKmnlHEw/vQlku3q9Df14VSD1b9HDg5hjToHKMqsF4eVtbLzrZwGEQBSUCq3WKW0tsGYFpvsY0ZFoqhBkcW1TZBnAPSWZ3Z0kPfu3AmB1/DyJCiiin4PM+1Ev7pZXVNuGBfmF8KHZQriM3C9uwDfGYapMQ2tGO8qSPcbWZ/u/+MajuS1TliuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL3BcfC6tuLd1Gq/faK9TImN5u1Q44Q5YWTGv0s3Hyw=;
 b=jAQK2DFGzzF3qIobHLX2xMPdFqVCUy4PZzhKyD5AIzSZnCJyiCIJp7yhAWIKakh5BS5bqL4f/NMs8o/IIQKmfHthyy3bMnO9eWa6/l+LDY3TS9qYxYXzRlyIlKZ8mJOirMWs/lKGGLAk2Gm1R8B8WPIncDi+9nethy1Y1laJU2iy4lL9fv3Z095tOoborNaCSJo/mWpFgPClXPiEbzQNgmRY9eN59Ve+RNTwfU8VNi8h9Y4sJhcDeO8k7D5e9S7k/CdpiMNPrRKGGD6sUA1Gf4mlV4Zmw3nEMwNcXPkmFRBYvkD1jgpuMtslkdJ9QaJcud4L6HzyE0dQZ9i6B8Ey7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL3BcfC6tuLd1Gq/faK9TImN5u1Q44Q5YWTGv0s3Hyw=;
 b=SZgxtpoRYhdxXsdrUzu4r599ew4rIZJghDznB+EDanoQhCoPU1kT7k99psWa9mSmYnX+xPHBLScsixkH213NKfErtmVnzshVQ0kQkOxfNCANxRfkXbHn5NUIKsJc2vFV4/t0Yln5wJWbRhDuNDY/3lNAkmMiU1TF9ee33ZLcJ9w=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by AS8P194MB1222.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:57:41 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:57:40 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: =?iso-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Thread-Topic: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Thread-Index: AQHc6dmt5l1bpLuqWUmMcXHCoW2cNLYefVgAgAGIU4Y=
Date: Tue, 26 May 2026 08:57:40 +0000
Message-ID:
 <PR3P194MB1505E044156B69D712744642EA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
 <nrymrthvic2co6g726qm2lb4hbsepjw3xmoh33eznmlumdcpb2@pwxvmsq5y67v>
In-Reply-To: <nrymrthvic2co6g726qm2lb4hbsepjw3xmoh33eznmlumdcpb2@pwxvmsq5y67v>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Enabled=True;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_SiteId=8ca3018c-58f1-4333-afa9-a8744cbe7fc2;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_SetDate=2026-05-26T08:57:40.196Z;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Name=All
 Employees
 (unrestricted);MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_ContentBits=1;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Method=Standard;
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|AS8P194MB1222:EE_
x-ms-office365-filtering-correlation-id: 52bd5dd4-c8b0-467d-15e4-08debb04d7d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021|4143699003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 v1WTbSxb/BWLV5i5z93GL7goumvnSFYYCsk3sppXPwneeScTVA7cStE1lkeZ3TiShfBPAXAvzbSsdUfGoTN1CZc3Is6HlObvWC0dY2o3Li/sNb/5kk/Oij7sjfIyverQN5sDO8Ap+LeYpzgflQfvydz71RlUWeB66muHYsXmFTiOLTxgCqoM3COsnvC6rQslbOocO11nTA2YKG9a2mbqEg8ZfLmQxOhKg1zpGT30kXXWAdghsD5POFCLjQPzx+qJiszV8lNKAUN4aURJyzecVeji7kL/NGAIAN0oXazy4VQw1lr9Ior96MakvyBPvcMGKkf3VR5A1Dc0MVPPxGhnajmdjlEb7JFzrkfpALByKObypm5oLPuL3+LSQDficaZoH87S/WFvKpmcGJ+VDaK6ppDJisH6ymYpOAqZ10DXZb0/Ul300Mec5DSLVovMhDRNf+5GWYC9YYG4OdupNct2yjivxBQZJElUIz7IupTxW5F7oi2+9EF3dKaM/sIpt29n5mAdpn0HsKiX5OwHoSCmssd4a+B+AhJs0cBPCv91QthPczWBJW9MLCGhx17BiLmgURB0RXJDLrc041yQgVyQpDzaELrdqYjpZOQBwaijuTCy39cx4KrynSrofSQAXAKINybQQwxKcWUpfFzBfP6Zh7d6yIFJox0uXzfVBK2cI0vvNSECtomjwTuk18EJfial09J5PeEHhRt1rM8D9LlL1i+o9+YnZ+d/SINnPiWyevo+Iudrnbrv2UMOhW57A3nS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ka6Zgy1ZOrlNY2q7ehW0xG4P95l8QR39cQ+InQRaP6+TRLQmnA+7kUkGbZ?=
 =?iso-8859-1?Q?frSJJ5HCBUGnv9JsymKCvTWWFEU5k/73DRtZG9Unj3plmEDqv1ARdkPFxB?=
 =?iso-8859-1?Q?/ENlBNit/p441n33VK3EUG+iI9N2+wIJJ/dcHrd5Nnok3cruThkuU2DnF/?=
 =?iso-8859-1?Q?LXoEgJaFt3w2Vy+sf0xARiZGs7gnvLuqQH+BPi2lD9Z9FIqqvBxwj7K8Nj?=
 =?iso-8859-1?Q?xi7puHvPxtvsGiIYid7flVORNFKVK/FG/+7+wqAJtTz/lY+wn0vbZWYjYL?=
 =?iso-8859-1?Q?3TbSaJlJA2pEHWC1tMCEeDH4HBmhhkqnX/Q3s/IsDL7R9BxxMze9qqqhC0?=
 =?iso-8859-1?Q?AlqH6mdCjJroKr2NlEjjsed8+Z6itdwQVAfz0eJxLaji3Bf030nkEcje2M?=
 =?iso-8859-1?Q?ZOzti8TZkSF1TNVh6J0NYf3E911o9tb6IgTo7+VN1r/W7dHS35EXBkAZNF?=
 =?iso-8859-1?Q?gs7EU/KC7MGp0nHtHkQifOQUo+gxw6uW+N4j6L00ihrBMrRDVcMZulR5OK?=
 =?iso-8859-1?Q?+xQQWhKOpwbM6khD+rsT3EjhITFXpANTInCVlL1vAeB97FWr3RcQrG+KSE?=
 =?iso-8859-1?Q?Lh2cLkeCktfV2xozJP/EQqXeq8KFYFuDotWf3Mm+aM+kPKc+2Uq+435H12?=
 =?iso-8859-1?Q?IXOiK7ern2Je/vFLKoSUo+SXsFMEfan4dKefI2Cmv/rketOZCH1PliDQhu?=
 =?iso-8859-1?Q?5cDJZJqcSl+bEhSk5rohQ9lccE3ZAO86I+EGcJgAbR5apphO8BL5HTb5Bm?=
 =?iso-8859-1?Q?NRXbXBOFqg0Fme3e4n3khXRkvBfo8C+LgSnDazNka6+E6uG/kjhfiAiuFq?=
 =?iso-8859-1?Q?iUPr42fUwZPl2owHisfDjeIkhzk4SkSN7bOrkU2UdR7x5MGDUG6tMkzywj?=
 =?iso-8859-1?Q?LNGWfsAD38ruqZ4AOHVMPk9UCKNioI/83prf/MKOZUeP9b2jiu93Qm+iR/?=
 =?iso-8859-1?Q?Igszn/oXFbw3b8Ky31afN8NfJzFXBlnZvH4gWZwr9lL2UJhAeaSbbyXjLc?=
 =?iso-8859-1?Q?DvrL6g4Qb9srEFZdtvBzmvm/hvQew67jqr07glbFi0NU0KPH/6czHeQDWd?=
 =?iso-8859-1?Q?sGNKF/jZVoOmOHLNBhYlahj0wvmtmk7EPQbqClr7o3777o/PFjKofCCGqj?=
 =?iso-8859-1?Q?K6TGL+dt+isOUJ+GtLtIZiGsQHaxLkwW9X6mvssNrNlfut8JmioGNg0vj7?=
 =?iso-8859-1?Q?CLWvw7+dTmaEqDL3/FayigFfrkUN3BOFPQ+nNgNZK9CMjhfldw01oS3Bag?=
 =?iso-8859-1?Q?hb3grRjElZT+zGzRyqfiQ5J/3Wubhs3MeMsySGe9uESsOXXJm/ughA4KrW?=
 =?iso-8859-1?Q?31dw7hb/vjeAwhq2d48fetScoqi+rY9aZSTo9+zTQTi8awgtRckhJiu6cM?=
 =?iso-8859-1?Q?WPX4zL3X5zXCP5NCQJn0laNW3zNcey7HgVAaoz85qyYZ+4YOU0OTJ0WZdW?=
 =?iso-8859-1?Q?wHvCqSoQWI/kwvTisqGr7TP8rrIJFTiWAfnBrhvsA10TVum3kzpVMYGRb/?=
 =?iso-8859-1?Q?1p4HBQ/5fsLn2tEtngY50xoObF33Z32dgLdmPdttXEkDxTyTn9+7VjygeQ?=
 =?iso-8859-1?Q?4Li9KZUWVSQKOW31J8FOTqKbmnR2XdWzZ05TRuyWJMetGuNSQToE58oRQW?=
 =?iso-8859-1?Q?CE5sab45vUKv4UkqzBcsqBfliP+YucZs247v4KJ1WYhOS/JhuZqj6GJ3AT?=
 =?iso-8859-1?Q?yJ8tCHaupgcmOvT23Qg7ESocxz+VeQEjTxSdLDhVvniA8UniTGnBhJjzD6?=
 =?iso-8859-1?Q?B554s/rW2S8P45ziI6ZhP9ETz6WOVYUuEacddGt3jVi2B+wWB13FFcHGIS?=
 =?iso-8859-1?Q?zgHVojrNIyHJw03EwSF6HDrRqsKi79Ox9C0C5GLASslzGFAzLRtYj8KDu4?=
 =?iso-8859-1?Q?+H?=
x-ms-exchange-antispam-messagedata-1: GKPomBwqxkUdpA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bd5dd4-c8b0-467d-15e4-08debb04d7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 08:57:40.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl/J81mzlSnXzAf1nsKdlDO9d8rR0SKugdIRZNaHy6fA0e2m+FQ71WBeqKQF77ATFEwe8UtzMDgDA68uF6b76hs9dx4H4T+w+xoi8fdRUCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB1222
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[luminex.be:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 638215D2D3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Marek Beh=FAn <kabel@kernel.org>=0A=
> Sent: Monday, May 25, 2026 11:26 AM=0A=
> To: Cedric Jehasse=0A=
> Cc: Andrew Lunn; Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Ki=
cinski; Paolo Abeni; Simon Horman; Russell King; netdev@vger.kernel.org; li=
nux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queu=
es=0A=
>=0A=
> Num tx queues for all devices:=0A=
>=0A=
> 88E6020         4=0A=
> 88E6071         4=0A=
> 88E6085         4=0A=
> 88E6095         4=0A=
> 88E6097         4=0A=
> 88E6123         4=0A=
> 88E6131         4=0A=
> 88E6141         4=0A=
> 88E6161         4=0A=
> 88E6165         4=0A=
> 88E6171         4=0A=
> 88E6172         4=0A=
> 88E6175         4=0A=
> 88E6176         4=0A=
> 88E6185         4=0A=
> 88E6190         8 from you=0A=
> 88E6190X        8 from you=0A=
> 88E6191         n/a can't find datasheet, does this even exist?=0A=
> 88E6191X        8 from you=0A=
> 88E6193X        8 from you=0A=
> 88E6220         4 from you=0A=
> 88E6240         4 from you=0A=
> 88E6250         4 from you=0A=
> 88E6290         8=0A=
> 88E6320         4 from you=0A=
> 88E6321         4 from you=0A=
> 88E6341         4=0A=
> 88E6350         4=0A=
> 88E6351         4=0A=
> 88E6352         4 from you=0A=
> 88E6361         8=0A=
> 88E6390         8 from you=0A=
> 88E6390X        8 from you=0A=
> 88E6393X        8 from you=0A=
>=0A=
> Marek=0A=
=0A=
These will be added in the next patch revision.=0A=
=0A=
Thanks,=0A=
Cedric=0A=
=0A=
=0A=

