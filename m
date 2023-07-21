Return-Path: <netdev+bounces-20049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72075D7E1
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E25D282457
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDB920F97;
	Fri, 21 Jul 2023 23:27:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8F1ED44
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:27:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF31BE2
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT5qoLJtJs7EkVtOGRDJB7WSxR0OUt/ILpKTRzILYFgxGy5gN/ROL8YubKdbjyf7D4pIzaKKR9OeppXRLpYi2CXpq9gLx/ceNnOxvd7yVrW093uGA7kUsvSt8chDrPQTEJYPJu++WoQ6aiFeyESdZ1Y+HnpgZX3QLfuKsehmpgnt7VyEKJRYzGWGPAxXFzpYQx6UUjTFyjc0Vd5JuNcyjvb9ut0Mg/TJY4A5K8t1b4nEWP9Cj5qYvEg37rw9J9VBl1xYuz7AUk1uXMkNzfLIi+APwK9kyDMMVsL6oVJXF/8jLfOh8a1Jb2DpQzLg5cCd/6FiAINnVmYlQAXtPy8SoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBkKV+PGvtGxey+dYQxAj4Rdj/hsYnIIFCZ6pDK5j9M=;
 b=KVSqLVCSA9sHBVQUL/EBIlWmlXfvbdcebt55VeMjYPFjWtUF1d2nmrg+MmhrFQJGWaRuRL3hPUqX8JAVRKXKweSUQN349PU1y8LRPQvSK51JO9gOkr/9Y1S8CR5bLI1fEz+AzC0r12sQhMqdcCEsdBWGVc2DrgIVz9WFGhFOhnmwR3O21ydKWn9PcXWUjybOOtoY3mP64vLvfr+HgEl931P2qc7Ua8xBChQcap5cFerk2S2gLP4R/a3ROdn2WAYdQtowK6GfmZIJntvGul++vBL9Ljj4cAcdbkmNDqA8QdAqM0VEzlBgoGxxIZ9GatvJP82cx53maXUf3TMcJGaXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBkKV+PGvtGxey+dYQxAj4Rdj/hsYnIIFCZ6pDK5j9M=;
 b=n0H8tfFpn4LHClvEKFJmgl5vLKlC0XuPOhlSwR8P31ZpJV3HRjhMq5c+E5GiLlq9XAz8gdMfXFNZtt9qTZq+I4lHLQ4MmDvWzs9bp0ZBByuy2PGMdvVhpzkBfjPWCYR88N5G2gfh564JnKVEqb5NPiuSUB6SybErdCrExOyVsRDIkPpaUT9nooivq/xJ2IRDQEFsIIifrteAO/Li3uBPAwQkoIESL/IgGdyjcFTUkshoyR9bUDVUz13MevD+a0cW3W8ghVLRotTVOGx7CgoKxUVvieewAkUUT5Y6XCRpoDuHnI/WIq3qR/foP0F3syq33z+VG0QpIYkdpL7JQPL9Pg==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 23:27:11 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25%7]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 23:27:11 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sridhar.samudrala@intel.com"
	<sridhar.samudrala@intel.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Topic: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Index: AQHZu95yT+g5xckp7kqGosWbtpbJ16/EUPJfgABDz1CAADoBAIAADvUA
Date: Fri, 21 Jul 2023 23:27:10 +0000
Message-ID:
 <CH2PR12MB38953C0288EB343ABC8B250ED73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721150212.h4vg6ueugifnfss6@skbuf>
 <CH2PR12MB3895C55CC77385622898BCADD73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
 <20230721223236.kgdjzl7unfbuenzm@skbuf>
In-Reply-To: <20230721223236.kgdjzl7unfbuenzm@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|IA1PR12MB7735:EE_
x-ms-office365-filtering-correlation-id: 2a0ac9df-35ce-4e5d-a16a-08db8a42020d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aNrgs1hAuJFFc3ZYW4D0V6Dln3//shAIY2rJIevOaNePWAwfbcXJtqgypXMnrDYQsQvsP096OjwxoeDkOYYWekISoUGEErA6vtGd81KCEm7P10SSq+mjpnwiBeV7x0BsByeXqwzxd5taVvykB6nD0uWupPR5Fje6dIMuwd7YeLep6+7aMNHM+TyQjUgkNxtjDNrrSb9X/D7XEnFMbMxuKg/83xxu8npsHa3ohHt1rDXmE9+KOC8cmArqSIheP4kswe0qF785wfYtH7sMlIpME/FBCuOOmMKIehmCFXuV6Z+JT9rDRSj3BL9GtoUmgXUiIaFAFt2ms1wp9Ii26fR/XVhHLaRp7wFnb3+wlFTwTlloWX7XweG/1EXGFs+xZibP9LzlTRfk9hw0Uc7n3pP5KmcdZxN6mIxUgNef1t99E+UBuTAqKKQIsXZGGx5uddLmz2rid9ww2+7S2g22q5Yrlo3Xg2HOhD/wbgm8UbbIjNrFUhFMS/f8gkgnWURQwGJZnyWihy+CrRIlG/Vq6SncdKQUjOJbOgs3KeZQykXSOdknKVf0is8uQrXycHGLogACqoYnPdUeC1oh8ayzmK+HMqIih8z0I25c+RcI5luIPyJfMwMOfU9PJadvR5pMgoXr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(38100700002)(8676002)(52536014)(5660300002)(38070700005)(66446008)(66556008)(316002)(64756008)(8936002)(4326008)(6916009)(66476007)(76116006)(66946007)(83380400001)(2906002)(41300700001)(33656002)(478600001)(9686003)(7696005)(54906003)(107886003)(6506007)(26005)(186003)(86362001)(71200400001)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lfrIqxbBTEKRAdywy/3tuLgSuJK8SQz/lAKbsC+XhmnSsg+Bvu5am1fjvrYH?=
 =?us-ascii?Q?QcIph1QYe04DbezDj9KQt7jXJpv6i4ihx4ik2mQ4E/5gLK+te7DWxBuilWeI?=
 =?us-ascii?Q?ZW8B0i41nTwUwy7uXAIBZEeVa3F5Uet68pHUTaoZ1CQwbhe33Dx1TaWB628I?=
 =?us-ascii?Q?U7bys2hpRDnV2X2TCm6c28S55zLhkn7H2KEl4zqIHFevE95hyMcFRBp/dcqC?=
 =?us-ascii?Q?bD6UhRNWbqwzltQG81/QIAmbLYUDk02VnxZ0pPMsPDdDXiEj2o+V9/1VUkSF?=
 =?us-ascii?Q?CdsgN25Q1pI9rcSXaKx16fkDr/+P412REZnHYhRQ+8s78hC1r5lelI4PJgcJ?=
 =?us-ascii?Q?mdg1fMVyhPooL69wrtyVWeYxesMRWL0KTLnWqHA7w7/D5P4dW0nM6KYpdO7L?=
 =?us-ascii?Q?zV1RWu3ZSns21ptLSzuX4VGkrSHyZRcpgQMoAKTRZ950Elr5LrxBPEHLacu0?=
 =?us-ascii?Q?EqhpHRSNjqjZficskno0n0qscdmOiXtk2KGmlJwbn08KC4tXXp6d0f0n1+63?=
 =?us-ascii?Q?+xUUW8wLYCJCMFzhxqvSutXX5aTjBV2i6l8pYrB4QsIUBBY7S0DPNv8IV76A?=
 =?us-ascii?Q?fvTztz1f/seNl1x7EGl5RCHPXlJda2li8W0AqL3NYn0A3A+7GDFB49Fe4TBj?=
 =?us-ascii?Q?BTc3d8Qb96DQLecL0463ni7lboAl+eeHJ3JK5X+P5vOHALulW3LN/y/MdhoP?=
 =?us-ascii?Q?BEjwJXQqRIi/zJfYQawSOeokWA6WUllohIyEFr0Z2ZxrnoZmLcP0RxuAV74P?=
 =?us-ascii?Q?19fHWrwkQEA2noR0q1CboAdoH6RLkSNH5SO7th5IShIMvphYA1TaHOXk/J1u?=
 =?us-ascii?Q?BDSTE1/x1cK58LbYlc9HoivrGRkSUNt67hXl8hoznpN10PtdMMHQt6Tb86hB?=
 =?us-ascii?Q?QyK5VTSJqUi5sDjpiPDkk8dk/m6Jry/8IoqgFA8kOijbPtcMh9ze5105A84x?=
 =?us-ascii?Q?pheN074bd8WPqgtIuWzw48odRvIr0kgW/c2rcWoDSextETw/3gm8LS+Y3avV?=
 =?us-ascii?Q?5mYJTa5AquWbLyi0FnDJGk/LCmiyHhyhqFHM+vAailLrHhvuhCjCjhx79WpI?=
 =?us-ascii?Q?KES9LaVLgFmEkEDUsryCDhFIC4AkZwYkMe3/VMGd8mu5LNLv5TWcvLlnVS0n?=
 =?us-ascii?Q?jIavfXfn8HjkchP6fZiTqoLm/ZNB/7peu0Xn/meLoYF+rTpflOTZ+yeIqjHn?=
 =?us-ascii?Q?W3hcmDzu4JyNCsKhchenL2ZpVQa+A6oe+vAJtX9ZhHk9lfa2tgihIQeHgjG2?=
 =?us-ascii?Q?3uc6vLyqvki1XvnbUDEkdIJ9qu6nFiOGIKWn+EkKFMs2vpWGMamYLAY9GU6N?=
 =?us-ascii?Q?wCQ/UmYNl+9leH9LWcg59mvELXyEVeGJrMu9yMGB1Hn4VjZxcpSYtxZ8MHwK?=
 =?us-ascii?Q?Hcp32JRwIl3likPgJOF6qxt7xVM+XJ3ZC8cO1nX7TnB5U+Ba95Or/qvld4ke?=
 =?us-ascii?Q?dCBjYWOjMEReRNPGVUELglmWnbhK6NCAKIYxbCrriLTpbuzbFvgoo/D7vDz6?=
 =?us-ascii?Q?h3STz/tGzsVw9nM8v3Te6Nio6qqZF2eq6q0YFBqaC/Uctf5Az278cfkZs7bf?=
 =?us-ascii?Q?DKBT9wK6FHykAR9nqn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0ac9df-35ce-4e5d-a16a-08db8a42020d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 23:27:10.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92qUwV5UvrJPTIjJDT1v6henLP4Ala5hByu1nMP2kjGEx0WP7EKhTReke2j3ayKLZbkn1+01QwIaumBPjhHXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > [  285.126250] mlxbf_gige MLNXBF17:00: shutdown [  285.130669] Unable
> > to handle kernel NULL pointer dereference at virtual address
> > 0000000000000070 [  285.139447] Mem abort info:
> > [  285.142228]   ESR =3D 0x0000000096000004
> > [  285.145964]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [  285.151261]   SET =3D 0, FnV =3D 0
> > [  285.154303]   EA =3D 0, S1PTW =3D 0
> > [  285.157430]   FSC =3D 0x04: level 0 translation fault
> > [  285.162293] Data abort info:
> > [  285.165159]   ISV =3D 0, ISS =3D 0x00000004
> > [  285.168980]   CM =3D 0, WnR =3D 0
> > [  285.171932] user pgtable: 4k pages, 48-bit VAs,
> > pgdp=3D000000011d373000 [  285.178358] [0000000000000070]
> > pgd=3D0000000000000000, p4d=3D0000000000000000 [  285.185134] Internal
> > error: Oops: 96000004 [#1] SMP
>=20
> That is not a stack trace. The stack trace is what appears between the li=
nes "Call
> trace:" and "---[ end trace 0000000000000000 ]---", and it is missing fro=
m what
> you've posted.
>=20
> It would be nice if you could also post-process the stack trace you get t=
hrough
> the command below (run in a kernel tree):
>=20
> cat stack_trace | scripts/decode_stacktrace.sh path/to/vmlinux .
>=20
> so that we could see the actual C code line numbers, and not just the off=
sets
> within your particular binary image.

Hi Vladimir,

Do you want me to just send it as a reply or send a v5 and add it to the co=
mmit message?

