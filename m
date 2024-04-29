Return-Path: <netdev+bounces-92196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBED8B5E9A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94668283A49
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409E839FF;
	Mon, 29 Apr 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qmnI8e8n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2974400
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406865; cv=fail; b=P18rDK+Q5+fZODDh/icFu4ucOpqYHft2BWULGh5MdoWyFWxLCEu0AT6Bo+O7CfKb4HyUKVd+/wj/LxXww6Gb7sIqPGmJBOSIapTZ1lNn5br0gG3wejnG0AJ0XRbwi94ucdqJlWJ71wt1167iaPmgRGsjCoEYvxyaGspnj2p8pKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406865; c=relaxed/simple;
	bh=Zo6xin+YMAPqDqnS2mMrEHAEN447Bpn8OBmgrIu6i5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIe/p80cECFS70plvhyzguYSWrXg62peGPOVuV17AE+uZyM703PQCmx2Z7rGwn2w0Nickz+gBurKLI0t/JYdQ3wDR8PWuFl7IOZ5qDHIPo4DJr5FRHwqCcSme6TSmzjZNV/VTGKPMdLm02wfg48tEDBFc/eLwXY72jrDRX02izw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qmnI8e8n; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3vubQ005525;
	Mon, 29 Apr 2024 09:07:17 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43av2km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/KEPj8liiqlYUjxKix3DWPNzo5XwaOQA4Yd0PPEIZO14m4vLMJsm1wlRhIuOU7CW4v45ZPrfISpJRXCJbhn6xSsC3aWDjB9uARu+k4a2BDxIasVznp2swbL6l4nDavMg3nxHZKKcevyvu5V3sYBVk2PcwYgFTxiWaEP04pBbH4u8cd0a41MUE8Vau5WfMu3Mrpl4HPnGt7SloizWJZ6NFCjzgp80RnyteJ0WgbHkpD6xtjD+NRKGHp/tLNOYEMHQbj07OZQyZUdVpeb4qZKObbTFg4Lam6AbvfMtL9BpfPM03Owc+0MWW0syAXNRXS6P4SYqFho2Vx6rBu1ATsuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDepZuBGAMAbacJyc2I6zbaopN7OaTizMf5NO1WSNwk=;
 b=HDEe1qyaDcrUU7WMlTf4my/r7VuBvjUrCvzkEzsRqDZXyqwwa6PX16NfvG10WtAf8AL4unnssEFCu75PzNxmbGewYFVVSTtM2uEvgH2cQhiEwet8XWsVauaXjdsL4HhzVRMsNvEFbspCFLWh6lvjwEXbkgSK4fE64qoOGFpg/39WIqoKcG5006zf0yv5kEavy6JWCCfc38vemuG7hDliTHoZrV5GWeRGDlvXE1VSmwMu/+xnvNdShxAg+wFB5tVfCX1V7LsUY47yCttfCMkGdlCmd11Gp8wrUJn1cTyjOf9WjM5dUmn1Gu1QmsgAspmwysTYUzn2ZE3M5383Zlcnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDepZuBGAMAbacJyc2I6zbaopN7OaTizMf5NO1WSNwk=;
 b=qmnI8e8nWHK8aihA50/ojE537mY1LF/3+mgKMbBnZaBM95twbaVTuA/FidfghoX99SuhJCU0ycdjVuT5k5TvTZSOFtbvLefErdRIt8mH1BaX21yhf1nvUlhgYkRcsf0kfMI0G6S12hM9R/Sz1yna1iWb1y7gGhVB8yqXdUgckMU=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SA1PR18MB4565.namprd18.prod.outlook.com (2603:10b6:806:1e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 16:07:14 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 16:07:14 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>,
        "duanqiangwen@net-swift.com" <duanqiangwen@net-swift.com>
Subject: RE: [PATCH net v2 3/4] net: wangxun: match VLAN CTAG and STAG
 features
Thread-Topic: [PATCH net v2 3/4] net: wangxun: match VLAN CTAG and STAG
 features
Thread-Index: AQHamk9NiyfbfFL78U2wK4Ha+AeJ1A==
Date: Mon, 29 Apr 2024 16:07:14 +0000
Message-ID: 
 <BY3PR18MB47078A957ED7320DC36B5F02A01B2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
 <20240429102519.25096-4-jiawenwu@trustnetic.com>
In-Reply-To: <20240429102519.25096-4-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SA1PR18MB4565:EE_
x-ms-office365-filtering-correlation-id: e8bd9340-217b-412f-82f5-08dc68666fa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?a9VWLgrh3O+SGdoXJlOj1u+LmP7q24vMjXi0fTld6dECaRZNWPp/pZutNWqq?=
 =?us-ascii?Q?8HJE+QrN7gXe9Iri+ikZnRReXdSSP93GqfZLBA0G6Hjjn6l5eaPlR14nmwOo?=
 =?us-ascii?Q?N7OTTFXTFB4t1e5RA9Tyh7W625IKZGWaBmHFZMIl2b7NUCN14OmpxoRCwuYZ?=
 =?us-ascii?Q?pdnUM9C88lhjmQXEGryajAful8V8PCCpDYYw7pCqit4rE3HVZPbBXgpKyxen?=
 =?us-ascii?Q?OVski+Aq6xTXgFA/CpTDw2iFeldUtsj1cOBYZ5N608+FMwNSo62Kxn713VvV?=
 =?us-ascii?Q?LGJe4Eoqwc+Qd7HZ9e85oaiQCObKkq/tY1VI/N1/T8XQF6hkPo+fAWP7hvQn?=
 =?us-ascii?Q?o22vg4huyW/qHA1euNCtqZ9KHAK3q6W/7wPVKJwn4Px00zD/6At+l5kKTVbr?=
 =?us-ascii?Q?f064cT6JmOb9D05VADtIRlyjFyA4bqmeaDueAgTrX1pXPaZCwvxy+oV4MeJY?=
 =?us-ascii?Q?qilKzrjAQ73Z77qhT+1fhBkTSxU3CSz5S7/cm/gaBHpJSOixHySUpKngujgS?=
 =?us-ascii?Q?XGKwk3RcCaE2ppsrUJVIdM+2Yi/KVhj6pz97gliKGfcG6JbToN1yPEgLCM5u?=
 =?us-ascii?Q?jV5+tk8uutZuAdhEWRiK+UtqcFX9mXTSvc7PUz3yMZqA94XVk76rEcmN5BpH?=
 =?us-ascii?Q?9R7+fsrZ0WNTRiWUK18wuQ2bGAKojIFxXLjq3zreV+9vToidMsxK11qt9Lq5?=
 =?us-ascii?Q?jM/Ys06mlYwUWnHR1tQsbPkexHQCXBRjF+ZiY9adPgCBoZvtAoTqA1AyKTgO?=
 =?us-ascii?Q?5YSYTwMxFtApGyrFmVEKUWM9bpOn0c/ylpzCxPZmZ2i1PNkGdPym95Sq+4ux?=
 =?us-ascii?Q?dzRyVESHP8dNS1GgUyTi0Eznwmn6Ngu36HbULzNviZ5wF5NvQdODO17zP6sR?=
 =?us-ascii?Q?omEni0oPC8PlAO9oKuJXOGsbQLZVMHyNF8H4PE+/N1aeVMx+tBYFO1UQI1su?=
 =?us-ascii?Q?/8wwOF5JhYqvySAaPx/DSQjsnb9JNg89MH+FwyAT1Vo1LRIuIessgfoBphQ9?=
 =?us-ascii?Q?+NIsJfeNgI/ykWcIk4RwTe2fIQoEf2X3NcjSRpV9sq2gkNGmIeQH7fquxP8T?=
 =?us-ascii?Q?QYRIIBmCr7mJnU+F6VvXl+9KK/Fz/x151Sm6xZyjorTipBY3AkZ8kpts5Db8?=
 =?us-ascii?Q?p6zg1X3MCH/eDqWn1PO4KZPaAJguwqYJscGD4V5RiMJ/RoA08Ouqfyd393VJ?=
 =?us-ascii?Q?Xb1XUkDubwjwv8pjlohWuu2e54M4UcJ8FarO+DqajJMtnCw+6VD1YatLMji+?=
 =?us-ascii?Q?t+lfFTMvCZwmHUu523c3jua4tXwTZz787kZb7+Lf6vrS5rCZPcAso1qNEnVP?=
 =?us-ascii?Q?okUwLne/51sxl7A9QjnB87TIhDRfR2iJjTQlPq8OiryxNg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?l8eqhbqHWXanuNKSu06JFwspgLoyV3P8RqMOVw+FiTZXoo/wm1EEltvhH14N?=
 =?us-ascii?Q?7jo6HNjbBkn6C5k/xWvYLskVDTKiBKgP71VhkgiKHcuzcG79/rz6SyXcSOKe?=
 =?us-ascii?Q?BZ6u+ztTe+k1eQikI/ITxrLGNXEsbvVdNP8RaUOoHyK9iPRXIDAIXz6ACgDJ?=
 =?us-ascii?Q?RM/ibzFVPAtFjrSyyQ3YZyJkvgouJUhZLyQzgm+5h3RwxiEz0suYRFfNgQ7u?=
 =?us-ascii?Q?68md2RN+4C4ccxJJrdQ7c6YbyonbZ2Kde+FyKXoESQz1JxYvXdGG5LWdX73C?=
 =?us-ascii?Q?h0rcp72l6hDfxJCVCw0awNy+H8c438D0W9vOejv6p6xoQRBRRFSqJ0qrgqAX?=
 =?us-ascii?Q?+JQArDZo5QY204H+GVSH0HkDuF0v52UMFMQa8cvukAqoyVIEVj3hOGRcML2o?=
 =?us-ascii?Q?6xPi3xzK4LUUEdnLeON2dvfVFO2IfcGU7WxaKJolTU1FU6gctiemSavUGCv3?=
 =?us-ascii?Q?7/hW3uruM7Poxc3C/6JhCX+uIVRPi6075zL6mV0fQowl/cNOUvY6ctBgphsd?=
 =?us-ascii?Q?95jVTo+RfYSf+DHVvbnCBglMCuNOxxRWC6LfyIJEKp6a31ifC743iwAcLgAx?=
 =?us-ascii?Q?aeb5kgI00wjHXuRQGErNtYAdoYV22Nn5RWIVZEKk0BcucdJdJzsVpmmHpb4f?=
 =?us-ascii?Q?ywDvfVeRSy21HBpF00sQo0No2xvmB5xBBPwtFOyT2L8g59vcgBBWED/YDGS0?=
 =?us-ascii?Q?zHfOkkqvCTK00zhM7dQrYXPZKJjxnmCW4zZfZVvNjMCnehQYfrCCC3vr470P?=
 =?us-ascii?Q?kP0HSTS1NcYwOlbl48EUgslpuALMIurHrtILaI/FPGbJzT8fjDRNEckXIejZ?=
 =?us-ascii?Q?JziRxjvkPAnjVyLqZqTmjXVKnijB41j5HlOHdePo5CSMt+VA1Y95rtzDfWPO?=
 =?us-ascii?Q?pRtjI5pIkfyYS0vcPj8BmNkpb3y/IJJV2KJ0GuDsR1sInA7ZS3LHDws33kqk?=
 =?us-ascii?Q?D4awYlcVgrIzY15Q9N3KkRg9TxHhzZlUdltCfTllrvn8zLS+ljpR063zXxcW?=
 =?us-ascii?Q?YKmsS+nOSi+/Y82Pe0ccA+ptscTF9wHNrqNrfkmdl2Lxda58NwHcYGFbFC6b?=
 =?us-ascii?Q?TzMNdoN8H+HAtCaq2DnCM/x+RnkbeP7WqPrDVzEFqUfrXijdaYVL4OObzRqN?=
 =?us-ascii?Q?aM8QIfrNWAK8xUUqbVspcbtgcxV6Bytcurav8l72l7cRKCqAqVQUkDsLpP/q?=
 =?us-ascii?Q?V8I3Z3Ec6rZwMzsJGv0mV9sHxx8mxRfQRAStQaD4u8CbHtFztH/OSi3TDMrZ?=
 =?us-ascii?Q?Kgp802VLPEaklVed03aQlOVDBvndsLu5m5VSSZ+1GZuy3XwUy2mejYrcwlrZ?=
 =?us-ascii?Q?ChGUO29cfGQ3E74fOhbe6PbsEsb6gPcNS95qUwEEEzBNNukMbn70wC8h0Vds?=
 =?us-ascii?Q?zNqpubsYheeZaCEk4K3QVaPnIUK3GIduXhiQlmwYt4IfyzZfq5JWDA2JT12j?=
 =?us-ascii?Q?HE9KaTgcnz5XkPwe08DF3gVYjMwrpeeTHT2Wjv5PuwQpJqn+0hvSUSmJxYLc?=
 =?us-ascii?Q?tu0FEfFbxEjrn1d9EPanAI0ejQ5ExeP4T+oS7MFD/Pk7MxnVxvrWF4jd43dm?=
 =?us-ascii?Q?XNCAxLZtjvB+HwAzrevvysItGX1hnKtHkwKt35Ua?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bd9340-217b-412f-82f5-08dc68666fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 16:07:14.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1r1fEOJ5NNldiN5/mX3Myk/kWPjy8vrQz/bBJBZaU4UOQ/xfj05TTEVVaz5F8N/5mwZaQ06fhOmNrpjH78Csw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4565
X-Proofpoint-ORIG-GUID: 8GWVb7sfon5anWW0m4Rcr8goie-m5WZO
X-Proofpoint-GUID: 8GWVb7sfon5anWW0m4Rcr8goie-m5WZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02

> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, April 29, 2024 3:55 PM
> To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; rmk+kernel@armlinux.org.uk; andrew@lunn.ch;
> netdev@vger.kernel.org
> Cc: mengyuanlou@net-swift.com; duanqiangwen@net-swift.com; Jiawen Wu
> <jiawenwu@trustnetic.com>
> Subject: [PATCH net v2 3/4] net: wangxun: match VLAN CTAG and
> STAG features
>=20
> Hardware requires VLAN CTAG and STAG configuration always matches. And
> whether VLAN CTAG or STAG changes, the configuration needs to be changed
> as well.
>=20
> Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 46 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
>  4 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 667a5675998c..aefd78455468 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2701,6 +2701,52 @@ int wx_set_features(struct net_device *netdev,
> netdev_features_t features)  }  EXPORT_SYMBOL(wx_set_features);
>=20
> +netdev_features_t wx_fix_features(struct net_device *netdev,
> +				  netdev_features_t features)
> +{
> +	netdev_features_t changed =3D netdev->features ^ features;
> +
> +	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
> +		if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +			features |=3D NETIF_F_HW_VLAN_STAG_FILTER;
> +		else
> +			features &=3D ~NETIF_F_HW_VLAN_STAG_FILTER;
> +	}
> +	if (changed & NETIF_F_HW_VLAN_STAG_FILTER) {
> +		if (features & NETIF_F_HW_VLAN_STAG_FILTER)
> +			features |=3D NETIF_F_HW_VLAN_CTAG_FILTER;
> +		else
> +			features &=3D ~NETIF_F_HW_VLAN_CTAG_FILTER;
> +	}
> +	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
> +		if (features & NETIF_F_HW_VLAN_CTAG_RX)
> +			features |=3D NETIF_F_HW_VLAN_STAG_RX;
> +		else
> +			features &=3D ~NETIF_F_HW_VLAN_STAG_RX;
> +	}
> +	if (changed & NETIF_F_HW_VLAN_STAG_RX) {
> +		if (features & NETIF_F_HW_VLAN_STAG_RX)
> +			features |=3D NETIF_F_HW_VLAN_CTAG_RX;
> +		else
> +			features &=3D ~NETIF_F_HW_VLAN_CTAG_RX;
> +	}
> +	if (changed & NETIF_F_HW_VLAN_CTAG_TX) {
> +		if (features & NETIF_F_HW_VLAN_CTAG_TX)
> +			features |=3D NETIF_F_HW_VLAN_STAG_TX;
> +		else
> +			features &=3D ~NETIF_F_HW_VLAN_STAG_TX;
> +	}
> +	if (changed & NETIF_F_HW_VLAN_STAG_TX) {
> +		if (features & NETIF_F_HW_VLAN_STAG_TX)
> +			features |=3D NETIF_F_HW_VLAN_CTAG_TX;
> +		else
> +			features &=3D ~NETIF_F_HW_VLAN_CTAG_TX;
> +	}
> +
> +	return features;
> +}
> +EXPORT_SYMBOL(wx_fix_features);
> +
>  void wx_set_ring(struct wx *wx, u32 new_tx_count,
>  		 u32 new_rx_count, struct wx_ring *temp_ring)  { diff --git
> a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> index ec909e876720..c41b29ea812f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> @@ -30,6 +30,8 @@ int wx_setup_resources(struct wx *wx);  void
> wx_get_stats64(struct net_device *netdev,
>  		    struct rtnl_link_stats64 *stats);  int wx_set_features(struct
> net_device *netdev, netdev_features_t features);
> +netdev_features_t wx_fix_features(struct net_device *netdev,
> +				  netdev_features_t features);
>  void wx_set_ring(struct wx *wx, u32 new_tx_count,
>  		 u32 new_rx_count, struct wx_ring *temp_ring);
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index fdd6b4f70b7a..e894e01d030d 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -499,6 +499,7 @@ static const struct net_device_ops ngbe_netdev_ops =
=3D
> {
>  	.ndo_start_xmit         =3D wx_xmit_frame,
>  	.ndo_set_rx_mode        =3D wx_set_rx_mode,
>  	.ndo_set_features       =3D wx_set_features,
> +	.ndo_fix_features       =3D wx_fix_features,
>  	.ndo_validate_addr      =3D eth_validate_addr,
>  	.ndo_set_mac_address    =3D wx_set_mac,
>  	.ndo_get_stats64        =3D wx_get_stats64,
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index bd4624d14ca0..b3c0058b045d 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -428,6 +428,7 @@ static const struct net_device_ops txgbe_netdev_ops
> =3D {
>  	.ndo_start_xmit         =3D wx_xmit_frame,
>  	.ndo_set_rx_mode        =3D wx_set_rx_mode,
>  	.ndo_set_features       =3D wx_set_features,
> +	.ndo_fix_features       =3D wx_fix_features,
>  	.ndo_validate_addr      =3D eth_validate_addr,
>  	.ndo_set_mac_address    =3D wx_set_mac,
>  	.ndo_get_stats64        =3D wx_get_stats64,
> --
> 2.27.0
>=20
Reviewed-by: Sai Krishna <saikrishnag@marvell.com

