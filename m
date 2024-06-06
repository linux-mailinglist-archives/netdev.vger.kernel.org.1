Return-Path: <netdev+bounces-101310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF68FE1B8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DFA2816B9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A50F13FD8C;
	Thu,  6 Jun 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Nk+7os+4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D813E8B6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664060; cv=fail; b=VEuVca61EMoHa2A+LVcKIesgEOmxVoUVVFWQLJ98JPkIlKwP2hLqeLzh40leltyrIfnnoPTd1J9u1shusO4bU1JtuhyEaFv9HFpzpdmYVtthNqTfKQf8wRlvCP/ha0q+dwtx2cCNAWENiWxESy8EJGLhtSOjVuW+WkxwMDhOyFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664060; c=relaxed/simple;
	bh=tNqV0T/r5mq4cn870eViZZMNa5EEuFxquzRiW/SoSDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixssVkSm8BcJ6ZX3hb1S+VDnJEyMxo/vmA+udYlV8y1P0JpxodkzI3ioMLwywn4VPoNoOOASf5+MR4jhoLiQs+2UGqnsjKbiscbgwkNFxuXVjPIe0obSRCP5WIpo+mthqXv4Rc4vjqnyJQiFWPg7DFwgyUaKRngdrpwaZJJdMgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nk+7os+4; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4567vZTe002853;
	Thu, 6 Jun 2024 01:53:45 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yk963864g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 01:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ismy+jnzr45EiKjavqP36DAub5bfMIgoKjbBfDgK9CNKtdj75fi6PT3EDgQFbjuSKTGDoBL7xTUp23JXKaK6A+nvyACtYdjf/DWAXlnI//GzDmY/G1G1owHetMv/KIlCdbfj/DlnXvS8q83x9chbCVveq1Hech2aYuuKD5xvqQpbjMMb0rSj95vR6VVb7dFNX5JBEi0AxWoNns3m1lA4PRdVWEE+3sif5ab3P+eJtbGqA6ycZk2G2wtOWhMVMkxvkeg0F97THUWOULrzrbDDX/IrKJZIuc43agT683hcBqMo8Dx3rcK4VdNomXgHzknWuxs0eismKkvgZyc7468Dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZpuxYn62zjAZ9z5apNHVXergh41R8LTnCl5GxcW/tc=;
 b=gC0gDqRwSdkHvdCGjW2BJokyHg3ozSG8gMiu2yb5RMZmrLg9XZlRjjDlo04DmOfN44Km8SnHA3JiuhDkAOwSiZopvbg81/XuVlbARDDb0uZALqwyXUAFyLknRH8DucMum0b3r9WiAunjKH5x0PdmCZ7inT5Osw8kt8pHvbZhhwG6xosUM8SCupFI/5KmQgMJqnjkZGkom8IUEy/CqNb22rO8/Z1Dg5Pjp9g7L4HWAkvC24a/4NUj7xk6Mz+WxaR2ErwbtwHNScVZJ96Q6CnNB/gRXyLO9Cz855+g4jkn8Q7x/0kG0GLs4KtylGFsGxZSfi2cyB8Y5zSaF0mkEH7l1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZpuxYn62zjAZ9z5apNHVXergh41R8LTnCl5GxcW/tc=;
 b=Nk+7os+4DSdkYLuEIQPSe7WK2bl3Df4xwVQ1aXVLXTo+30PxLuxhcf8Qtxzjc1DY/V3ajMdQSJi11LJ3n+iNWWNmcp8fSe7FoqnU3gO+1S87jDuceuM2cM5xUl2Yi+aQCEXgydhiSQTS4vUeNboeeafL8M20oIwBHf4ac2dbicw=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by IA3PR18MB6285.namprd18.prod.outlook.com (2603:10b6:208:528::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:53:41 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 08:53:41 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 2/3] net: txgbe: support Flow Director perfect
 filters
Thread-Topic: [PATCH net-next v2 2/3] net: txgbe: support Flow Director
 perfect filters
Thread-Index: AQHat+8HeDrCN35A2UCaxDBaNLEvfQ==
Date: Thu, 6 Jun 2024 08:53:40 +0000
Message-ID: 
 <PH0PR18MB44741630B62B890E39814445DEFA2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com>
 <20240605020852.24144-3-jiawenwu@trustnetic.com>
In-Reply-To: <20240605020852.24144-3-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|IA3PR18MB6285:EE_
x-ms-office365-filtering-correlation-id: b1f2362e-6d93-475c-6ef4-08dc860629e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?DuYM1N+Iv4isPfB1LV9pPDakCBM//OMy88cuZ79wkNnS4XfdwwnX/H36QZNP?=
 =?us-ascii?Q?uUJwsFkHwk7ziQCGtt4hP1ebUm1IQ1bwY8S5ElqaGnPAcfdnuLzOYaWG16XS?=
 =?us-ascii?Q?5zeozAC45ZhF+IQVKAwE/Igh1BiCyl+AdwfGMQjduhCXS1ovXP7f0c4bMurW?=
 =?us-ascii?Q?b6f9hqZWTxLlTmE+lJuXfnlIQ48qee8x2F+XjUsENWRD8yRKdnXhz5KUFpoJ?=
 =?us-ascii?Q?5H+4chXlcIVjG9A2h0aUxWA8ODSw8YhZd2yFgsLcJKb2vnl5iWOAvSWlrwBJ?=
 =?us-ascii?Q?BBrtMuW+lwr9cRrzWEPfkekQuW51CqgZ7P2eZ8woiNtBUL8b+xLScwmmbVVV?=
 =?us-ascii?Q?oKtHsd7vev1aJ8ngyiFsRZXxKIEyIrz28YjRk/SL1zBmxCRBMsxkUxv1XyWy?=
 =?us-ascii?Q?qeh31vh4Ww8XQ2IJmJ93AMpZ04HqT/SNoWvUHZxUCiFmpj1KE1MDHdTWPD8i?=
 =?us-ascii?Q?Hll+wQ+jpo+0kAeiOwtut9+xA4f9wkp44g0mpsW8joBqph1Pnwt3zYJskiiy?=
 =?us-ascii?Q?yYw0+3Zptl3jAvWegODOPJyCPDSg9RrTc3uiW5Ps5I1W9nUm8rq69Hk+DK+t?=
 =?us-ascii?Q?iqz43ElB7h6ywKTt+4GH4JsCDv3KONfZOiqybZSoCwA98ZQGPoUzo2yQgy+a?=
 =?us-ascii?Q?GwnXhg1o3IQMlqv9KQwam3n6GFpYl4mZp3Lp16Vy3BPv1LQjFIjGDHMF7BlW?=
 =?us-ascii?Q?5stjdps0bInUvvhCECu3r9k1x8iVSFuGueWy39GIK/wZzL1fOvn6gJvjuluY?=
 =?us-ascii?Q?ceMh4NEyMEGAYBUjvnAFFIAfZNkSn4cFshq/dKPY3tqG0xESnwV9e+1DHSm1?=
 =?us-ascii?Q?Lf+PGHAalJUKHz6T/DPKEMrInILj7ISTnabdmBRZb29+x6JhzwR9IqS0Ji4Z?=
 =?us-ascii?Q?+hOUCTYeASyhy2Fx6xeZvBCK7mxW3qUUlbUbk8UO/YxK15iiEIz6HpkquvPC?=
 =?us-ascii?Q?F+jjV5Ei4yRjvC3dnuI8qc8hlOLaWy8hAaeg64BikbJKzAISL2w7ZFKLi923?=
 =?us-ascii?Q?X9TFub7bytuBiRlf3lh4ajVEWDq4dOFixjwnlePoEY03QJcaAsa6+BK6nKM4?=
 =?us-ascii?Q?ZoYFCo7YU7klfWV1oWHQikskfoPIZvdRXpaTZs+0jfAHVuUS4shbVjLXv/ud?=
 =?us-ascii?Q?iA+q/AXLB755BK9NlDxKZq64JKDC62hfZaBYqINUPwac7ihe9IsAn0P3vtY8?=
 =?us-ascii?Q?8yipUITXWhIRYJPv5n9G1AJqw42zeFdP2KZuLcftfylOomETUQ8DopEdhtuj?=
 =?us-ascii?Q?rGCH3mq5mddmJ6HlnJTSKtCpwaJdFmqii5tP5Ug68t1+O4zMVh5Ebom4ooSr?=
 =?us-ascii?Q?FgqO6DxwKMtBlpZZ0a4q6QIyeQB/looRP39lNS0GXsW0ZK7RY18eZs+bQfJ2?=
 =?us-ascii?Q?D1n67zU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4mYNCrGqqW9QnDtTt540H5uextRQkJ9pawurebSJDQiDy7uLZKlG1Bzv7csk?=
 =?us-ascii?Q?gVvpqYs3Zxh+iXOOjsn2giVLRbi86x91x6EQqXynb3azrlvibhyVEGbdq8Nk?=
 =?us-ascii?Q?WBKITo24PuCM/wP1pUPsheCwTj/dvNu+Z2eKR+gRnuREOCHQ9hS6+Hjhs6jH?=
 =?us-ascii?Q?kPApQCFJP7jQQWwIhFPig3J0Xkd0LH3BF5W5LswHRZuhFzXw8CKuHbcTbwdQ?=
 =?us-ascii?Q?RjqpbFxtKhFvaNQNoOjejTQf0qZojPjoYegZzc9TmEG1R8ZjyEXF5uVzHsvB?=
 =?us-ascii?Q?7LYj/UHMhIXuApOe2RSnzAOmGrdr8IbU/6GUrifaFLzn5U3fR6AopFQlak0L?=
 =?us-ascii?Q?riLnzWZeohdw8qAI4pUQASmGaZIJulxZ4HYIZBtjKUkcSX4WzuN+8IINlmMl?=
 =?us-ascii?Q?ncsPVr+EewyiCB6SAvnCdo0em8RbKbJBYvkbF/fj8RlpYhj3UNjP7hRz+uYU?=
 =?us-ascii?Q?knuj02ffsp/Hfc8NUqdauHnSqJJasWrwhBRMEGjstkNihRV5NWtVgXcpGJxq?=
 =?us-ascii?Q?gohgIZBwX+rLc+BAi3RhYEIV47BHUqfrXFdXxiz19jjQC4nUz5BkYEpPkDCa?=
 =?us-ascii?Q?iWapgJ6y6k0GGzoLLl2CZC8P8N4TpXkwuoO0BtiOZcjx9LDfKt0i/DR6lU4K?=
 =?us-ascii?Q?PYZbWziz6Sqn+HV7J3XnFGsmvQuj/U6CTvYte7NexAXuOBJnD/diRvjFVQtZ?=
 =?us-ascii?Q?ovxLO2NuBleC7C12DbONioi/r3d/Qji/vjvvg2fc4ntUEHO/WhIwXnKCXXLJ?=
 =?us-ascii?Q?l+IUji3COHiINv0LYzEPaNrLKIa6pHlOsa4SK/J2Lou0UNt4dicGC7BwjXpv?=
 =?us-ascii?Q?BukxTHPHe1yaKXidDEqki4cvOe1RTm0sFV7YLmbZsyfCLX07jnry0W2l0CWp?=
 =?us-ascii?Q?Ehl507+T3iCc9LvL+KdTMQsxKyXVc6z40gGLTiFw2x4719UbSGY2otHi4Vz3?=
 =?us-ascii?Q?HMp7obkP3WobglQQc8LizMnzKSViU5DQf1xESoq5Ff+n4o9Q/n2hc8Q+6oHH?=
 =?us-ascii?Q?yKCkStF5UhVYSA+YS7RWEJU33Hc3+lWUk9jZtUJGcBQK3OzklNLWTaP/gdR5?=
 =?us-ascii?Q?T+5IbBohFXtEC1DHosJPbgrDFdg2j5f7pbF3SKFLe5uq0b4V7IpKo/FU3QJK?=
 =?us-ascii?Q?840xrFI5/5NLJWJYyncqTd/Csv8MZyvSELBGjVqApGzhfpbkWypPYeys6JkY?=
 =?us-ascii?Q?MiO2Z4UQPDA7A6Dd5s7YvbPylxQeA1l2ISyETBm4aMfggeM9Emc2aXx6H6uF?=
 =?us-ascii?Q?3WKTIxeyrLL5FbUJojwKlmXKkBHMOGqcg/iCL3E0Rk1jMegX9QvryMNZK5+j?=
 =?us-ascii?Q?Q9HgWU/THDc/F612Pck8KHnu0/Zw1l2ARglYqQ0lGrn7/mton/NTaqTWl8MI?=
 =?us-ascii?Q?mlCeX0DGEDb4bTsU51kITCY1jPspYvaGDW3OaVxi6le4gw/eRFyaTn7/rXDH?=
 =?us-ascii?Q?Sx98cQ0gENzIxJETOdZH1oz1CR6Qmw0hnl5hkMbmYGGdUXVXJoN+Z4EW8gCs?=
 =?us-ascii?Q?Tbsla6Kb+pgS2o/bjA6wJe4JErvGot1nxdnI2JsEiFmaw8rLL2cxSiFIiFZY?=
 =?us-ascii?Q?MB+xbQpYipKeqWXmtfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f2362e-6d93-475c-6ef4-08dc860629e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:53:41.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuaZeHssu189RhSu3biVwq0zUbW3qGHc44pKGBQ1oZQrdyYCDxiNXhGJtE6LkHB6EfbjQT2/dE0P/AYKbbAisw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6285
X-Proofpoint-ORIG-GUID: Sbi8Uq3RCg_MMUIzEDie242zMYI4ax8i
X-Proofpoint-GUID: Sbi8Uq3RCg_MMUIzEDie242zMYI4ax8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01



> Support the addition and deletion of Flow Director filters.
>=20
> Supported fields: src-ip, dst-ip, src-port, dst-port Supported flow-types=
: tcp4,
> udp4, sctp4, ipv4
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  31 ++
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 417 ++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 334 +++++++++++++-
>  .../net/ethernet/wangxun/txgbe/txgbe_fdir.h   |   8 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   9 +
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  26 ++
>  6 files changed, 824 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 8774206ca496..59317a8a3320 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2705,6 +2705,7 @@ int wx_set_features(struct net_device *netdev,
> netdev_features_t features)  {
>  	netdev_features_t changed =3D netdev->features ^ features;
>  	struct wx *wx =3D netdev_priv(netdev);
> +	bool need_reset =3D false;
>=20
>  	if (features & NETIF_F_RXHASH) {
>  		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
> @@ -2722,6 +2723,36 @@ int wx_set_features(struct net_device *netdev,
> netdev_features_t features)
>  	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX |
> NETIF_F_HW_VLAN_CTAG_FILTER))
>  		wx_set_rx_mode(netdev);
>=20
> +	if (!(test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)))
> +		return 0;
> +
> +	/* Check if Flow Director n-tuple support was enabled or disabled.  If
> +	 * the state changed, we need to reset.
> +	 */
> +	switch (features & NETIF_F_NTUPLE) {
> +	case NETIF_F_NTUPLE:
> +		/* turn off ATR, enable perfect filters and reset */
> +		if (!(test_and_set_bit(WX_FLAG_FDIR_PERFECT, wx->flags)))
> +			need_reset =3D true;
> +
> +		clear_bit(WX_FLAG_FDIR_HASH, wx->flags);
> +		break;
> +	default:
> +		/* turn off perfect filters, enable ATR and reset */
> +		if (test_and_clear_bit(WX_FLAG_FDIR_PERFECT, wx->flags))
> +			need_reset =3D true;
> +
> +		/* We cannot enable ATR if RSS is disabled */
> +		if (wx->ring_feature[RING_F_RSS].limit <=3D 1)
> +			break;
> +
> +		set_bit(WX_FLAG_FDIR_HASH, wx->flags);
> +		break;
> +	}
> +
> +	if (need_reset)
> +		wx->do_reset(netdev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(wx_set_features);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index 31fde3fa7c6b..4aac64820eb3 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> @@ -9,6 +9,7 @@
>  #include "../libwx/wx_type.h"
>  #include "../libwx/wx_lib.h"
>  #include "txgbe_type.h"
> +#include "txgbe_fdir.h"
>  #include "txgbe_ethtool.h"
>=20
>  static int txgbe_set_ringparam(struct net_device *netdev, @@ -79,6 +80,4=
20
> @@ static int txgbe_set_channels(struct net_device *dev,
>  	return txgbe_setup_tc(dev, netdev_get_num_tc(dev));  }
>=20
> +static int txgbe_get_ethtool_fdir_entry(struct txgbe *txgbe,
> +					struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fsp =3D (struct ethtool_rx_flow_spec
> *)&cmd->fs;
> +	union txgbe_atr_input *mask =3D &txgbe->fdir_mask;
> +	struct txgbe_fdir_filter *rule =3D NULL;
> +	struct hlist_node *node;
> +
> +	/* report total rule count */
> +	cmd->data =3D (1024 << TXGBE_FDIR_PBALLOC_64K) - 2;
> +
> +	hlist_for_each_entry_safe(rule, node, &txgbe->fdir_filter_list,
> fdir_node) {
> +		if (fsp->location <=3D rule->sw_idx)
> +			break;
> +	}
> +
> +	if (!rule || fsp->location !=3D rule->sw_idx)
> +		return -EINVAL;
> +
> +	/* set flow type field */
> +	switch (rule->filter.formatted.flow_type) {
> +	case TXGBE_ATR_FLOW_TYPE_TCPV4:
> +		fsp->flow_type =3D TCP_V4_FLOW;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_UDPV4:
> +		fsp->flow_type =3D UDP_V4_FLOW;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_SCTPV4:
> +		fsp->flow_type =3D SCTP_V4_FLOW;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_IPV4:
> +		fsp->flow_type =3D IP_USER_FLOW;
> +		fsp->h_u.usr_ip4_spec.ip_ver =3D ETH_RX_NFC_IP4;
> +		fsp->h_u.usr_ip4_spec.proto =3D 0;
> +		fsp->m_u.usr_ip4_spec.proto =3D 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	fsp->h_u.tcp_ip4_spec.psrc =3D rule->filter.formatted.src_port;
> +	fsp->m_u.tcp_ip4_spec.psrc =3D mask->formatted.src_port;
> +	fsp->h_u.tcp_ip4_spec.pdst =3D rule->filter.formatted.dst_port;
> +	fsp->m_u.tcp_ip4_spec.pdst =3D mask->formatted.dst_port;
> +	fsp->h_u.tcp_ip4_spec.ip4src =3D rule->filter.formatted.src_ip[0];
> +	fsp->m_u.tcp_ip4_spec.ip4src =3D mask->formatted.src_ip[0];
> +	fsp->h_u.tcp_ip4_spec.ip4dst =3D rule->filter.formatted.dst_ip[0];
> +	fsp->m_u.tcp_ip4_spec.ip4dst =3D mask->formatted.dst_ip[0];
> +	fsp->h_ext.vlan_etype =3D rule->filter.formatted.flex_bytes;
> +	fsp->m_ext.vlan_etype =3D mask->formatted.flex_bytes;
> +	fsp->h_ext.data[1] =3D htonl(rule->filter.formatted.vm_pool);
> +	fsp->m_ext.data[1] =3D htonl(mask->formatted.vm_pool);
> +	fsp->flow_type |=3D FLOW_EXT;
> +
> +	/* record action */
> +	if (rule->action =3D=3D TXGBE_RDB_FDIR_DROP_QUEUE)
> +		fsp->ring_cookie =3D RX_CLS_FLOW_DISC;
> +	else
> +		fsp->ring_cookie =3D rule->action;
> +
> +	return 0;
> +}
> +
> +static int txgbe_get_ethtool_fdir_all(struct txgbe *txgbe,
> +				      struct ethtool_rxnfc *cmd,
> +				      u32 *rule_locs)
> +{
> +	struct txgbe_fdir_filter *rule;
> +	struct hlist_node *node;
> +	int cnt =3D 0;
> +
> +	/* report total rule count */
> +	cmd->data =3D (1024 << TXGBE_FDIR_PBALLOC_64K) - 2;
> +
> +	hlist_for_each_entry_safe(rule, node, &txgbe->fdir_filter_list,
> fdir_node) {
> +		if (cnt =3D=3D cmd->rule_cnt)
> +			return -EMSGSIZE;
> +		rule_locs[cnt] =3D rule->sw_idx;
> +		cnt++;
> +	}
> +
> +	cmd->rule_cnt =3D cnt;
> +
> +	return 0;
> +}
> +
> +static int txgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc =
*cmd,
> +			   u32 *rule_locs)
> +{
> +	struct wx *wx =3D netdev_priv(dev);
> +	struct txgbe *txgbe =3D wx->priv;
> +	int ret =3D -EOPNOTSUPP;
> +
> +	switch (cmd->cmd) {
> +	case ETHTOOL_GRXRINGS:
> +		cmd->data =3D wx->num_rx_queues;
> +		ret =3D 0;
> +		break;
> +	case ETHTOOL_GRXCLSRLCNT:
> +		cmd->rule_cnt =3D txgbe->fdir_filter_count;
> +		ret =3D 0;
> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		ret =3D txgbe_get_ethtool_fdir_entry(txgbe, cmd);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL:
> +		ret =3D txgbe_get_ethtool_fdir_all(txgbe, cmd, (u32 *)rule_locs);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int txgbe_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
> +				       u8 *flow_type)
> +{
> +	switch (fsp->flow_type & ~FLOW_EXT) {
> +	case TCP_V4_FLOW:
> +		*flow_type =3D TXGBE_ATR_FLOW_TYPE_TCPV4;
> +		break;
> +	case UDP_V4_FLOW:
> +		*flow_type =3D TXGBE_ATR_FLOW_TYPE_UDPV4;
> +		break;
> +	case SCTP_V4_FLOW:
> +		*flow_type =3D TXGBE_ATR_FLOW_TYPE_SCTPV4;
> +		break;
> +	case IP_USER_FLOW:
> +		switch (fsp->h_u.usr_ip4_spec.proto) {
> +		case IPPROTO_TCP:
> +			*flow_type =3D TXGBE_ATR_FLOW_TYPE_TCPV4;
> +			break;
> +		case IPPROTO_UDP:
> +			*flow_type =3D TXGBE_ATR_FLOW_TYPE_UDPV4;
> +			break;
> +		case IPPROTO_SCTP:
> +			*flow_type =3D TXGBE_ATR_FLOW_TYPE_SCTPV4;
> +			break;
> +		case 0:
> +			if (!fsp->m_u.usr_ip4_spec.proto) {
> +				*flow_type =3D TXGBE_ATR_FLOW_TYPE_IPV4;
> +				break;
> +			}
> +			fallthrough;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool txgbe_match_ethtool_fdir_entry(struct txgbe *txgbe,
> +					   struct txgbe_fdir_filter *input) {
> +	struct txgbe_fdir_filter *rule =3D NULL;
> +	struct hlist_node *node2;
> +
> +	hlist_for_each_entry_safe(rule, node2, &txgbe->fdir_filter_list,
> fdir_node) {
> +		if (rule->filter.formatted.bkt_hash =3D=3D
> +		    input->filter.formatted.bkt_hash &&
> +		    rule->action =3D=3D input->action) {
> +			wx_dbg(txgbe->wx, "FDIR entry already exist\n");
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +static int txgbe_update_ethtool_fdir_entry(struct txgbe *txgbe,
> +					   struct txgbe_fdir_filter *input,
> +					   u16 sw_idx)
> +{
> +	struct hlist_node *node =3D NULL, *parent =3D NULL;
> +	struct txgbe_fdir_filter *rule;
> +	struct wx *wx =3D txgbe->wx;
> +	bool deleted =3D false;
> +	int err;
> +
> +	hlist_for_each_entry_safe(rule, node, &txgbe->fdir_filter_list,
> fdir_node) {
> +		/* hash found, or no matching entry */
> +		if (rule->sw_idx >=3D sw_idx)
> +			break;
> +		parent =3D node;
> +	}
> +
> +	/* if there is an old rule occupying our place remove it */
> +	if (rule && rule->sw_idx =3D=3D sw_idx) {
> +		/* hardware filters are only configured when interface is up,
> +		 * and we should not issue filter commands while the
> interface
> +		 * is down
> +		 */
> +		if (netif_running(wx->netdev) &&
> +		    (!input || rule->filter.formatted.bkt_hash !=3D
> +		     input->filter.formatted.bkt_hash)) {
> +			err =3D txgbe_fdir_erase_perfect_filter(wx, &rule->filter,
> sw_idx);
> +			if (err)
> +				return -EINVAL;
> +		}
> +
> +		hlist_del(&rule->fdir_node);
> +		kfree(rule);
> +		txgbe->fdir_filter_count--;
> +		deleted =3D true;
> +	}
> +
> +	/* If we weren't given an input, then this was a request to delete a
> +	 * filter. We should return -EINVAL if the filter wasn't found, but
> +	 * return 0 if the rule was successfully deleted.
> +	 */
> +	if (!input)
> +		return deleted ? 0 : -EINVAL;
> +
> +	/* initialize node and set software index */
> +	INIT_HLIST_NODE(&input->fdir_node);
> +
> +	/* add filter to the list */
> +	if (parent)
> +		hlist_add_behind(&input->fdir_node, parent);
> +	else
> +		hlist_add_head(&input->fdir_node,
> +			       &txgbe->fdir_filter_list);
> +
> +	/* update counts */
> +	txgbe->fdir_filter_count++;
> +
> +	return 0;
> +}
> +
> +static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
> +					struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fsp =3D (struct ethtool_rx_flow_spec
> *)&cmd->fs;
> +	struct txgbe_fdir_filter *input;
> +	union txgbe_atr_input mask;
> +	struct wx *wx =3D txgbe->wx;
> +	u16 ptype =3D 0;
> +	u8 queue;
> +	int err;
> +
> +	if (!(test_bit(WX_FLAG_FDIR_PERFECT, wx->flags)))
> +		return -EOPNOTSUPP;
> +
> +	/* ring_cookie is a masked into a set of queues and txgbe pools or
> +	 * we use drop index
> +	 */
> +	if (fsp->ring_cookie =3D=3D RX_CLS_FLOW_DISC) {
> +		queue =3D TXGBE_RDB_FDIR_DROP_QUEUE;
> +	} else {
> +		u32 ring =3D ethtool_get_flow_spec_ring(fsp->ring_cookie);
> +
> +		if (ring >=3D wx->num_rx_queues)
> +			return -EINVAL;
> +
> +		/* Map the ring onto the absolute queue index */
> +		queue =3D wx->rx_ring[ring]->reg_idx;
> +	}
> +
> +	/* Don't allow indexes to exist outside of available space */
> +	if (fsp->location >=3D ((1024 << TXGBE_FDIR_PBALLOC_64K) - 2)) {
> +		wx_err(wx, "Location out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	input =3D kzalloc(sizeof(*input), GFP_ATOMIC);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	memset(&mask, 0, sizeof(union txgbe_atr_input));
> +
> +	/* set SW index */
> +	input->sw_idx =3D fsp->location;
> +
> +	/* record flow type */
> +	if (txgbe_flowspec_to_flow_type(fsp, &input-
> >filter.formatted.flow_type)) {
> +		wx_err(wx, "Unrecognized flow type\n");
> +		goto err_out;
> +	}
> +
> +	mask.formatted.flow_type =3D TXGBE_ATR_L4TYPE_IPV6_MASK |
> +				   TXGBE_ATR_L4TYPE_MASK;
> +
> +	if (input->filter.formatted.flow_type =3D=3D
> TXGBE_ATR_FLOW_TYPE_IPV4)
> +		mask.formatted.flow_type &=3D
> TXGBE_ATR_L4TYPE_IPV6_MASK;
> +
> +	/* Copy input into formatted structures */
> +	input->filter.formatted.src_ip[0] =3D fsp->h_u.tcp_ip4_spec.ip4src;
> +	mask.formatted.src_ip[0] =3D fsp->m_u.tcp_ip4_spec.ip4src;
> +	input->filter.formatted.dst_ip[0] =3D fsp->h_u.tcp_ip4_spec.ip4dst;
> +	mask.formatted.dst_ip[0] =3D fsp->m_u.tcp_ip4_spec.ip4dst;
> +	input->filter.formatted.src_port =3D fsp->h_u.tcp_ip4_spec.psrc;
> +	mask.formatted.src_port =3D fsp->m_u.tcp_ip4_spec.psrc;
> +	input->filter.formatted.dst_port =3D fsp->h_u.tcp_ip4_spec.pdst;
> +	mask.formatted.dst_port =3D fsp->m_u.tcp_ip4_spec.pdst;
> +
> +	if (fsp->flow_type & FLOW_EXT) {
> +		input->filter.formatted.vm_pool =3D
> +				(unsigned char)ntohl(fsp->h_ext.data[1]);
> +		mask.formatted.vm_pool =3D
> +				(unsigned char)ntohl(fsp->m_ext.data[1]);
> +		input->filter.formatted.flex_bytes =3D
> +						fsp->h_ext.vlan_etype;
> +		mask.formatted.flex_bytes =3D fsp->m_ext.vlan_etype;
> +	}
> +
> +	switch (input->filter.formatted.flow_type) {
> +	case TXGBE_ATR_FLOW_TYPE_TCPV4:
> +		ptype =3D WX_PTYPE_L2_IPV4_TCP;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_UDPV4:
> +		ptype =3D WX_PTYPE_L2_IPV4_UDP;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_SCTPV4:
> +		ptype =3D WX_PTYPE_L2_IPV4_SCTP;
> +		break;
> +	case TXGBE_ATR_FLOW_TYPE_IPV4:
> +		ptype =3D WX_PTYPE_L2_IPV4;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	input->filter.formatted.vlan_id =3D htons(ptype);
> +	if (mask.formatted.flow_type & TXGBE_ATR_L4TYPE_MASK)
> +		mask.formatted.vlan_id =3D htons(0xFFFF);
> +	else
> +		mask.formatted.vlan_id =3D htons(0xFFF8);
> +
> +	/* determine if we need to drop or route the packet */
> +	if (fsp->ring_cookie =3D=3D RX_CLS_FLOW_DISC)
> +		input->action =3D TXGBE_RDB_FDIR_DROP_QUEUE;
> +	else
> +		input->action =3D fsp->ring_cookie;
> +
> +	spin_lock(&txgbe->fdir_perfect_lock);

 ethtool ops is already protected with rtnl_lock , which can be confirmed b=
y calling ASSERT_RTNL().
 Why do we need a spin_lock here ?=20

Thanks
Hariprasad k
> +
> +	if (hlist_empty(&txgbe->fdir_filter_list)) {
> +		/* save mask and program input mask into HW */
> +		memcpy(&txgbe->fdir_mask, &mask, sizeof(mask));
> +		err =3D txgbe_fdir_set_input_mask(wx, &mask);
> +		if (err)
> +			goto err_unlock;
> +	} else if (memcmp(&txgbe->fdir_mask, &mask, sizeof(mask))) {
> +		wx_err(wx, "Hardware only supports one mask per port. To
> change the mask you must first delete all the rules.\n");
> +		goto err_unlock;
> +	}
> +
> +	/* apply mask and compute/store hash */
> +	txgbe_atr_compute_perfect_hash(&input->filter, &mask);
> +
> +	/* check if new entry does not exist on filter list */
> +	if (txgbe_match_ethtool_fdir_entry(txgbe, input))
> +		goto err_unlock;
> +
> +	/* only program filters to hardware if the net device is running, as
> +	 * we store the filters in the Rx buffer which is not allocated when
> +	 * the device is down
> +	 */
> +	if (netif_running(wx->netdev)) {
> +		err =3D txgbe_fdir_write_perfect_filter(wx, &input->filter,
> +						      input->sw_idx, queue);
> +		if (err)
> +			goto err_unlock;
> +	}
> +
> +	txgbe_update_ethtool_fdir_entry(txgbe, input, input->sw_idx);
> +
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +
> +	return err;
> +err_unlock:
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +err_out:
> +	kfree(input);
> +	return -EINVAL;
> +}
> +
> +static int txgbe_del_ethtool_fdir_entry(struct txgbe *txgbe,
> +					struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fsp =3D (struct ethtool_rx_flow_spec
> *)&cmd->fs;
> +	int err =3D 0;
> +
> +	spin_lock(&txgbe->fdir_perfect_lock);
> +	err =3D txgbe_update_ethtool_fdir_entry(txgbe, NULL, fsp->location);
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +
> +	return err;
> +}
> +
> +static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc
> +*cmd) {
> +	struct wx *wx =3D netdev_priv(dev);
> +	struct txgbe *txgbe =3D wx->priv;
> +	int ret =3D -EOPNOTSUPP;
> +
> +	switch (cmd->cmd) {
> +	case ETHTOOL_SRXCLSRLINS:
> +		ret =3D txgbe_add_ethtool_fdir_entry(txgbe, cmd);
> +		break;
> +	case ETHTOOL_SRXCLSRLDEL:
> +		ret =3D txgbe_del_ethtool_fdir_entry(txgbe, cmd);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct ethtool_ops txgbe_ethtool_ops =3D {
>  	.supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
>=20
> ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
> @@ -100,6 +515,8 @@ static const struct ethtool_ops txgbe_ethtool_ops =3D=
 {
>  	.set_coalesce		=3D wx_set_coalesce,
>  	.get_channels		=3D wx_get_channels,
>  	.set_channels		=3D txgbe_set_channels,
> +	.get_rxnfc		=3D txgbe_get_rxnfc,
> +	.set_rxnfc		=3D txgbe_set_rxnfc,
>  	.get_msglevel		=3D wx_get_msglevel,
>  	.set_msglevel		=3D wx_set_msglevel,
>  };
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> index b10676c00cea..ac6b690b6da6 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> @@ -90,6 +90,71 @@ static void txgbe_atr_compute_sig_hash(union
> txgbe_atr_hash_dword input,
>  	*hash =3D sig_hash ^ bucket_hash;
>  }
>=20
> +#define TXGBE_COMPUTE_BKT_HASH_ITERATION(_n) \ do { \
> +	u32 n =3D (_n); \
> +	if (TXGBE_ATR_BUCKET_HASH_KEY & (0x01 << n)) \
> +		bucket_hash ^=3D lo_hash_dword >> n; \
> +	if (TXGBE_ATR_BUCKET_HASH_KEY & (0x01 << (n + 16))) \
> +		bucket_hash ^=3D hi_hash_dword >> n; \
> +} while (0)
> +
> +/**
> + *  txgbe_atr_compute_perfect_hash - Compute the perfect filter hash
> + *  @input: input bitstream to compute the hash on
> + *  @input_mask: mask for the input bitstream
> + *
> + *  This function serves two main purposes.  First it applies the
> +input_mask
> + *  to the atr_input resulting in a cleaned up atr_input data stream.
> + *  Secondly it computes the hash and stores it in the bkt_hash field
> +at
> + *  the end of the input byte stream.  This way it will be available
> +for
> + *  future use without needing to recompute the hash.
> + **/
> +void txgbe_atr_compute_perfect_hash(union txgbe_atr_input *input,
> +				    union txgbe_atr_input *input_mask) {
> +	u32 hi_hash_dword, lo_hash_dword, flow_vm_vlan;
> +	u32 bucket_hash =3D 0;
> +	__be32 hi_dword =3D 0;
> +	u32 i =3D 0;
> +
> +	/* Apply masks to input data */
> +	for (i =3D 0; i < 11; i++)
> +		input->dword_stream[i] &=3D input_mask->dword_stream[i];
> +
> +	/* record the flow_vm_vlan bits as they are a key part to the hash */
> +	flow_vm_vlan =3D ntohl(input->dword_stream[0]);
> +
> +	/* generate common hash dword */
> +	for (i =3D 1; i <=3D 10; i++)
> +		hi_dword ^=3D input->dword_stream[i];
> +	hi_hash_dword =3D ntohl(hi_dword);
> +
> +	/* low dword is word swapped version of common */
> +	lo_hash_dword =3D (hi_hash_dword >> 16) | (hi_hash_dword << 16);
> +
> +	/* apply flow ID/VM pool/VLAN ID bits to hash words */
> +	hi_hash_dword ^=3D flow_vm_vlan ^ (flow_vm_vlan >> 16);
> +
> +	/* Process bits 0 and 16 */
> +	TXGBE_COMPUTE_BKT_HASH_ITERATION(0);
> +
> +	/* apply flow ID/VM pool/VLAN ID bits to lo hash dword, we had to
> +	 * delay this because bit 0 of the stream should not be processed
> +	 * so we do not add the VLAN until after bit 0 was processed
> +	 */
> +	lo_hash_dword ^=3D flow_vm_vlan ^ (flow_vm_vlan << 16);
> +
> +	/* Process remaining 30 bit of the key */
> +	for (i =3D 1; i <=3D 15; i++)
> +		TXGBE_COMPUTE_BKT_HASH_ITERATION(i);
> +
> +	/* Limit hash to 13 bits since max bucket count is 8K.
> +	 * Store result at the end of the input stream.
> +	 */
> +	input->formatted.bkt_hash =3D (__force __be16)(bucket_hash &
> 0x1FFF); }
> +
>  static int txgbe_fdir_check_cmd_complete(struct wx *wx)  {
>  	u32 val;
> @@ -236,6 +301,181 @@ void txgbe_atr(struct wx_ring *ring, struct
> wx_tx_buffer *first, u8 ptype)
>  					ring->queue_index);
>  }
>=20
> +int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input
> +*input_mask) {
> +	u32 fdirm =3D 0, fdirtcpm =3D 0, flex =3D 0;
> +
> +	/* Program the relevant mask registers.  If src/dst_port or
> src/dst_addr
> +	 * are zero, then assume a full mask for that field.  Also assume that
> +	 * a VLAN of 0 is unspecified, so mask that out as well.  L4type
> +	 * cannot be masked out in this implementation.
> +	 *
> +	 * This also assumes IPv4 only.  IPv6 masking isn't supported at this
> +	 * point in time.
> +	 */
> +
> +	/* verify bucket hash is cleared on hash generation */
> +	if (input_mask->formatted.bkt_hash)
> +		wx_dbg(wx, "bucket hash should always be 0 in mask\n");
> +
> +	/* Program FDIRM and verify partial masks */
> +	switch (input_mask->formatted.vm_pool & 0x7F) {
> +	case 0x0:
> +		fdirm |=3D TXGBE_RDB_FDIR_OTHER_MSK_POOL;
> +		break;
> +	case 0x7F:
> +		break;
> +	default:
> +		wx_err(wx, "Error on vm pool mask\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (input_mask->formatted.flow_type &
> TXGBE_ATR_L4TYPE_MASK) {
> +	case 0x0:
> +		fdirm |=3D TXGBE_RDB_FDIR_OTHER_MSK_L4P;
> +		if (input_mask->formatted.dst_port ||
> +		    input_mask->formatted.src_port) {
> +			wx_err(wx, "Error on src/dst port mask\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case TXGBE_ATR_L4TYPE_MASK:
> +		break;
> +	default:
> +		wx_err(wx, "Error on flow type mask\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
> +	wr32(wx, TXGBE_RDB_FDIR_OTHER_MSK, fdirm);
> +
> +	flex =3D rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
> +	flex &=3D ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
> +	flex |=3D (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
> +		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
> +
> +	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
> +	case 0x0000:
> +		/* Mask Flex Bytes */
> +		flex |=3D TXGBE_RDB_FDIR_FLEX_CFG_MSK;
> +		break;
> +	case 0xFFFF:
> +		break;
> +	default:
> +		wx_err(wx, "Error on flexible byte mask\n");
> +		return -EINVAL;
> +	}
> +	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
> +
> +	/* store the TCP/UDP port masks, bit reversed from port layout */
> +	fdirtcpm =3D ntohs(input_mask->formatted.dst_port);
> +	fdirtcpm <<=3D TXGBE_RDB_FDIR_PORT_DESTINATION_SHIFT;
> +	fdirtcpm |=3D ntohs(input_mask->formatted.src_port);
> +
> +	/* write both the same so that UDP and TCP use the same mask */
> +	wr32(wx, TXGBE_RDB_FDIR_TCP_MSK, ~fdirtcpm);
> +	wr32(wx, TXGBE_RDB_FDIR_UDP_MSK, ~fdirtcpm);
> +	wr32(wx, TXGBE_RDB_FDIR_SCTP_MSK, ~fdirtcpm);
> +
> +	/* store source and destination IP masks (little-enian) */
> +	wr32(wx, TXGBE_RDB_FDIR_SA4_MSK, ntohl(~input_mask-
> >formatted.src_ip[0]));
> +	wr32(wx, TXGBE_RDB_FDIR_DA4_MSK,
> +ntohl(~input_mask->formatted.dst_ip[0]));
> +
> +	return 0;
> +}
> +
> +int txgbe_fdir_write_perfect_filter(struct wx *wx, union txgbe_atr_input
> *input,
> +				    u16 soft_id, u8 queue)
> +{
> +	u32 fdirport, fdirvlan, fdirhash, fdircmd;
> +	int err =3D 0;
> +
> +	/* currently IPv6 is not supported, must be programmed with 0 */
> +	wr32(wx, TXGBE_RDB_FDIR_IP6(2), ntohl(input-
> >formatted.src_ip[0]));
> +	wr32(wx, TXGBE_RDB_FDIR_IP6(1), ntohl(input-
> >formatted.src_ip[1]));
> +	wr32(wx, TXGBE_RDB_FDIR_IP6(0), ntohl(input-
> >formatted.src_ip[2]));
> +
> +	/* record the source address (little-endian) */
> +	wr32(wx, TXGBE_RDB_FDIR_SA, ntohl(input->formatted.src_ip[0]));
> +
> +	/* record the first 32 bits of the destination address (little-endian) =
*/
> +	wr32(wx, TXGBE_RDB_FDIR_DA, ntohl(input->formatted.dst_ip[0]));
> +
> +	/* record source and destination port (little-endian)*/
> +	fdirport =3D ntohs(input->formatted.dst_port);
> +	fdirport <<=3D TXGBE_RDB_FDIR_PORT_DESTINATION_SHIFT;
> +	fdirport |=3D ntohs(input->formatted.src_port);
> +	wr32(wx, TXGBE_RDB_FDIR_PORT, fdirport);
> +
> +	/* record packet type and flex_bytes (little-endian) */
> +	fdirvlan =3D ntohs(input->formatted.flex_bytes);
> +	fdirvlan <<=3D TXGBE_RDB_FDIR_FLEX_FLEX_SHIFT;
> +	fdirvlan |=3D ntohs(input->formatted.vlan_id);
> +	wr32(wx, TXGBE_RDB_FDIR_FLEX, fdirvlan);
> +
> +	/* configure FDIRHASH register */
> +	fdirhash =3D (__force u32)input->formatted.bkt_hash |
> +		   TXGBE_RDB_FDIR_HASH_BUCKET_VALID |
> +		   TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(soft_id);
> +	wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhash);
> +
> +	/* flush all previous writes to make certain registers are
> +	 * programmed prior to issuing the command
> +	 */
> +	WX_WRITE_FLUSH(wx);
> +
> +	/* configure FDIRCMD register */
> +	fdircmd =3D TXGBE_RDB_FDIR_CMD_CMD_ADD_FLOW |
> +		  TXGBE_RDB_FDIR_CMD_FILTER_UPDATE |
> +		  TXGBE_RDB_FDIR_CMD_LAST |
> TXGBE_RDB_FDIR_CMD_QUEUE_EN;
> +	if (queue =3D=3D TXGBE_RDB_FDIR_DROP_QUEUE)
> +		fdircmd |=3D TXGBE_RDB_FDIR_CMD_DROP;
> +	fdircmd |=3D TXGBE_RDB_FDIR_CMD_FLOW_TYPE(input-
> >formatted.flow_type);
> +	fdircmd |=3D TXGBE_RDB_FDIR_CMD_RX_QUEUE(queue);
> +	fdircmd |=3D TXGBE_RDB_FDIR_CMD_VT_POOL(input-
> >formatted.vm_pool);
> +
> +	wr32(wx, TXGBE_RDB_FDIR_CMD, fdircmd);
> +	err =3D txgbe_fdir_check_cmd_complete(wx);
> +	if (err)
> +		wx_err(wx, "Flow Director command did not complete!\n");
> +
> +	return err;
> +}
> +
> +int txgbe_fdir_erase_perfect_filter(struct wx *wx, union txgbe_atr_input
> *input,
> +				    u16 soft_id)
> +{
> +	u32 fdirhash, fdircmd;
> +	int err =3D 0;
> +
> +	/* configure FDIRHASH register */
> +	fdirhash =3D (__force u32)input->formatted.bkt_hash;
> +	fdirhash |=3D TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(soft_id);
> +	wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhash);
> +
> +	/* flush hash to HW */
> +	WX_WRITE_FLUSH(wx);
> +
> +	/* Query if filter is present */
> +	wr32(wx, TXGBE_RDB_FDIR_CMD,
> TXGBE_RDB_FDIR_CMD_CMD_QUERY_REM_FILT);
> +
> +	err =3D txgbe_fdir_check_cmd_complete(wx);
> +	if (err) {
> +		wx_err(wx, "Flow Director command did not complete!\n");
> +		return err;
> +	}
> +
> +	fdircmd =3D rd32(wx, TXGBE_RDB_FDIR_CMD);
> +	/* if filter exists in hardware then remove it */
> +	if (fdircmd & TXGBE_RDB_FDIR_CMD_FILTER_VALID) {
> +		wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhash);
> +		WX_WRITE_FLUSH(wx);
> +		wr32(wx, TXGBE_RDB_FDIR_CMD,
> TXGBE_RDB_FDIR_CMD_CMD_REMOVE_FLOW);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   *  txgbe_fdir_enable - Initialize Flow Director control registers
>   *  @wx: pointer to hardware structure
> @@ -288,12 +528,104 @@ static void txgbe_init_fdir_signature(struct wx
> *wx)
>  	txgbe_fdir_enable(wx, fdirctrl);
>  }
>=20
> +/**
> + *  txgbe_init_fdir_perfect - Initialize Flow Director perfect filters
> + *  @wx: pointer to hardware structure
> + **/
> +static void txgbe_init_fdir_perfect(struct wx *wx) {
> +	u32 fdirctrl =3D TXGBE_FDIR_PBALLOC_64K;
> +
> +	/* Continue setup of fdirctrl register bits:
> +	 *  Turn perfect match filtering on
> +	 *  Report hash in RSS field of Rx wb descriptor
> +	 *  Initialize the drop queue
> +	 *  Move the flexible bytes to use the ethertype - shift 6 words
> +	 *  Set the maximum length per hash bucket to 0xA filters
> +	 *  Send interrupt when 64 (0x4 * 16) filters are left
> +	 */
> +	fdirctrl |=3D TXGBE_RDB_FDIR_CTL_PERFECT_MATCH |
> +
> TXGBE_RDB_FDIR_CTL_DROP_Q(TXGBE_RDB_FDIR_DROP_QUEUE) |
> +		    TXGBE_RDB_FDIR_CTL_HASH_BITS(0xF) |
> +		    TXGBE_RDB_FDIR_CTL_MAX_LENGTH(0xA) |
> +		    TXGBE_RDB_FDIR_CTL_FULL_THRESH(4);
> +
> +	/* write hashes and fdirctrl register, poll for completion */
> +	txgbe_fdir_enable(wx, fdirctrl);
> +}
> +
> +static void txgbe_fdir_filter_restore(struct wx *wx) {
> +	struct txgbe_fdir_filter *filter;
> +	struct txgbe *txgbe =3D wx->priv;
> +	struct hlist_node *node;
> +	u8 queue =3D 0;
> +	int ret =3D 0;
> +
> +	spin_lock(&txgbe->fdir_perfect_lock);
> +
> +	if (!hlist_empty(&txgbe->fdir_filter_list))
> +		ret =3D txgbe_fdir_set_input_mask(wx, &txgbe->fdir_mask);
> +
> +	if (ret)
> +		goto unlock;
> +
> +	hlist_for_each_entry_safe(filter, node,
> +				  &txgbe->fdir_filter_list, fdir_node) {
> +		if (filter->action =3D=3D TXGBE_RDB_FDIR_DROP_QUEUE) {
> +			queue =3D TXGBE_RDB_FDIR_DROP_QUEUE;
> +		} else {
> +			u32 ring =3D ethtool_get_flow_spec_ring(filter->action);
> +
> +			if (ring >=3D wx->num_rx_queues) {
> +				wx_err(wx, "FDIR restore failed, ring:%u\n",
> ring);
> +				continue;
> +			}
> +
> +			/* Map the ring onto the absolute queue index */
> +			queue =3D wx->rx_ring[ring]->reg_idx;
> +		}
> +
> +		ret =3D txgbe_fdir_write_perfect_filter(wx,
> +						      &filter->filter,
> +						      filter->sw_idx,
> +						      queue);
> +		if (ret)
> +			wx_err(wx, "FDIR restore failed, index:%u\n", filter-
> >sw_idx);
> +	}
> +
> +unlock:
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +}
> +
>  void txgbe_configure_fdir(struct wx *wx)  {
>  	wx_disable_sec_rx_path(wx);
>=20
> -	if (test_bit(WX_FLAG_FDIR_HASH, wx->flags))
> +	if (test_bit(WX_FLAG_FDIR_HASH, wx->flags)) {
>  		txgbe_init_fdir_signature(wx);
> +	} else if (test_bit(WX_FLAG_FDIR_PERFECT, wx->flags)) {
> +		txgbe_init_fdir_perfect(wx);
> +		txgbe_fdir_filter_restore(wx);
> +	}
>=20
>  	wx_enable_sec_rx_path(wx);
>  }
> +
> +void txgbe_fdir_filter_exit(struct wx *wx) {
> +	struct txgbe_fdir_filter *filter;
> +	struct txgbe *txgbe =3D wx->priv;
> +	struct hlist_node *node;
> +
> +	spin_lock(&txgbe->fdir_perfect_lock);
> +
> +	hlist_for_each_entry_safe(filter, node,
> +				  &txgbe->fdir_filter_list, fdir_node) {
> +		hlist_del(&filter->fdir_node);
> +		kfree(filter);
> +	}
> +	txgbe->fdir_filter_count =3D 0;
> +
> +	spin_unlock(&txgbe->fdir_perfect_lock);
> +}
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
> index ed245b66dc2a..ce89b54a44f7 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
> @@ -4,7 +4,15 @@
>  #ifndef _TXGBE_FDIR_H_
>  #define _TXGBE_FDIR_H_
>=20
> +void txgbe_atr_compute_perfect_hash(union txgbe_atr_input *input,
> +				    union txgbe_atr_input *input_mask);
>  void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptyp=
e);
> +int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input
> +*input_mask); int txgbe_fdir_write_perfect_filter(struct wx *wx, union
> txgbe_atr_input *input,
> +				    u16 soft_id, u8 queue);
> +int txgbe_fdir_erase_perfect_filter(struct wx *wx, union txgbe_atr_input
> *input,
> +				    u16 soft_id);
>  void txgbe_configure_fdir(struct wx *wx);
> +void txgbe_fdir_filter_exit(struct wx *wx);
>=20
>  #endif /* _TXGBE_FDIR_H_ */
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index ce49fb725541..41e9ebf11e41 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -283,6 +283,12 @@ static int txgbe_sw_init(struct wx *wx)
>  	return 0;
>  }
>=20
> +static void txgbe_init_fdir(struct txgbe *txgbe) {
> +	txgbe->fdir_filter_count =3D 0;
> +	spin_lock_init(&txgbe->fdir_perfect_lock);
> +}
> +
>  /**
>   * txgbe_open - Called when a network interface is made active
>   * @netdev: network interface device structure @@ -361,6 +367,7 @@ stati=
c
> int txgbe_close(struct net_device *netdev)
>  	txgbe_down(wx);
>  	wx_free_irq(wx);
>  	wx_free_resources(wx);
> +	txgbe_fdir_filter_exit(wx);
>  	wx_control_hw(wx, false);
>=20
>  	return 0;
> @@ -669,6 +676,8 @@ static int txgbe_probe(struct pci_dev *pdev,
>  	txgbe->wx =3D wx;
>  	wx->priv =3D txgbe;
>=20
> +	txgbe_init_fdir(txgbe);
> +
>  	err =3D txgbe_setup_misc_irq(txgbe);
>  	if (err)
>  		goto err_release_hw;
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 5b8c55df35fe..63bd034e0f0e 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -90,6 +90,7 @@
>  #define TXGBE_XPCS_IDA_DATA                     0x13004
>=20
>  /********************************* Flow Director
> *****************************/
> +#define TXGBE_RDB_FDIR_DROP_QUEUE               127
>  #define TXGBE_RDB_FDIR_CTL                      0x19500
>  #define TXGBE_RDB_FDIR_CTL_INIT_DONE            BIT(3)
>  #define TXGBE_RDB_FDIR_CTL_PERFECT_MATCH        BIT(4)
> @@ -97,6 +98,13 @@
>  #define TXGBE_RDB_FDIR_CTL_HASH_BITS(v)         FIELD_PREP(GENMASK(23,
> 20), v)
>  #define TXGBE_RDB_FDIR_CTL_MAX_LENGTH(v)
> FIELD_PREP(GENMASK(27, 24), v)
>  #define TXGBE_RDB_FDIR_CTL_FULL_THRESH(v)
> FIELD_PREP(GENMASK(31, 28), v)
> +#define TXGBE_RDB_FDIR_IP6(_i)                  (0x1950C + ((_i) * 4)) /=
* 0-2 */
> +#define TXGBE_RDB_FDIR_SA                       0x19518
> +#define TXGBE_RDB_FDIR_DA                       0x1951C
> +#define TXGBE_RDB_FDIR_PORT                     0x19520
> +#define TXGBE_RDB_FDIR_PORT_DESTINATION_SHIFT   16
> +#define TXGBE_RDB_FDIR_FLEX                     0x19524
> +#define TXGBE_RDB_FDIR_FLEX_FLEX_SHIFT          16
>  #define TXGBE_RDB_FDIR_HASH                     0x19528
>  #define TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(v)
> FIELD_PREP(GENMASK(31, 16), v)
>  #define TXGBE_RDB_FDIR_HASH_BUCKET_VALID        BIT(15)
> @@ -114,8 +122,16 @@
>  #define TXGBE_RDB_FDIR_CMD_QUEUE_EN             BIT(15)
>  #define TXGBE_RDB_FDIR_CMD_RX_QUEUE(v)
> FIELD_PREP(GENMASK(22, 16), v)
>  #define TXGBE_RDB_FDIR_CMD_VT_POOL(v)
> FIELD_PREP(GENMASK(29, 24), v)
> +#define TXGBE_RDB_FDIR_DA4_MSK                  0x1953C
> +#define TXGBE_RDB_FDIR_SA4_MSK                  0x19540
> +#define TXGBE_RDB_FDIR_TCP_MSK                  0x19544
> +#define TXGBE_RDB_FDIR_UDP_MSK                  0x19548
> +#define TXGBE_RDB_FDIR_SCTP_MSK                 0x19560
>  #define TXGBE_RDB_FDIR_HKEY                     0x19568
>  #define TXGBE_RDB_FDIR_SKEY                     0x1956C
> +#define TXGBE_RDB_FDIR_OTHER_MSK                0x19570
> +#define TXGBE_RDB_FDIR_OTHER_MSK_POOL           BIT(2)
> +#define TXGBE_RDB_FDIR_OTHER_MSK_L4P            BIT(3)
>  #define TXGBE_RDB_FDIR_FLEX_CFG(_i)             (0x19580 + ((_i) * 4))
>  #define TXGBE_RDB_FDIR_FLEX_CFG_FIELD0          GENMASK(7, 0)
>  #define TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC
> FIELD_PREP(GENMASK(1, 0), 0)
> @@ -230,6 +246,13 @@ enum txgbe_fdir_pballoc_type {
>  	TXGBE_FDIR_PBALLOC_256K =3D 3,
>  };
>=20
> +struct txgbe_fdir_filter {
> +	struct hlist_node fdir_node;
> +	union txgbe_atr_input filter;
> +	u16 sw_idx;
> +	u16 action;
> +};
> +
>  /* TX/RX descriptor defines */
>  #define TXGBE_DEFAULT_TXD               512
>  #define TXGBE_DEFAULT_TX_WORK           256
> @@ -316,7 +339,10 @@ struct txgbe {
>  	unsigned int link_irq;
>=20
>  	/* flow director */
> +	struct hlist_head fdir_filter_list;
>  	union txgbe_atr_input fdir_mask;
> +	int fdir_filter_count;
> +	spinlock_t fdir_perfect_lock; /*spinlock for FDIR */
>  };
>=20
>  #endif /* _TXGBE_TYPE_H_ */
> --
> 2.27.0
>=20


