Return-Path: <netdev+bounces-294202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s0mmJl/NHmo0VQAAu9opvQ
	(envelope-from <netdev+bounces-294202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D495462E0B6
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:32:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=GDxbDCbS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294202-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B3D300B62D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9A2F8E9E;
	Tue,  2 Jun 2026 12:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66022DF3EA;
	Tue,  2 Jun 2026 12:31:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403507; cv=fail; b=fFcI/cekZXQgNzA86Ek/GhsjzDb+LZpIzB78Yxw2t/uBinuP3qiHDD4AwY4oPzxwJmcTPlfvrnlUD8RBn33e3/NatvFhp6+xMvFXig+3fsm7gSTtHvMVTB7szgYFJASplVCK04EDeixGaU5zaVsBotKCFmDS+LQKW7YAX5uirng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403507; c=relaxed/simple;
	bh=3Xa76qrI6NBTuWu9jRNPfY6hQVMjGoeXbqEw/a1wSWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xy2rfzFp0LmTlUPW9RdGgIJofnA6+jEtvEQs/wnZYimecARPGrJMm21b7wAz1HaAUdwqUA5f3vXdX0UC4nEouEZGdomAzB8e29eX99okoTbXIg5Hn21bcBKpEdyNO1bC3Lkc0fmI3ZHs0wuHmkgbC61DPCLKcGX2uElYZwQlPPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=GDxbDCbS; arc=fail smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6529nDfD2859173;
	Tue, 2 Jun 2026 05:31:22 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023094.outbound.protection.outlook.com [40.93.196.94])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxrbn06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 05:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENqP/ARrOnZsvLlzT/ga1OXQuk8GL9Sv0TAzlc6sqKkTnYNCYKFOcYlXBQFnwdrsEsnyWv1Ii7e5+7LG4b0IEWLjZ+w2k2lZgDPmHjEv8f40TCF2SeAa8GWuaIRUURYfqXDzeVah77ayJN/SCF4bC90d6Wfr9IUFOGjKh9w7CLsVHeYs60yhyd2tzPP421H0kNxv3813hKxrUyGsHyTAD303rJIG80zbe+D05wmEDbRB4mV83TrNEZDMPixbNvW0R7TLkUVEXM6IKFqOgctVxXW3IH4GMnSr6zgxbKYF/t2R0Y/8YxtBEFGwC6CRjfNb4A6YSJWhNLSxyAzh8ir3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQpuUi2ipLU+5S0CEyKzkAjvuN+aE/xhHrgxrcdN45E=;
 b=sEHVjYzGqo48pBhgsDvzXKBHAAE2H0oTpTBvRsxYdLG1aUB2SGw9KdvM5IVAFTK4qXazOKVTosuod6WQVosa0CUW9L5PeDScwhSu9xXrwllMvsAPoDI7StWCO+RFLJKTNYIK8vx1uUtOXkHqEJ4prACE5P5HQ/PFI1sr5K/Z8gbK/bdCjD+gztD3TDsLS5msFqRYGluH8So9zTCiGAR8roJJncwKeMV35WU0r0Tbm6TbhUv9X949+XxnHPKwSPmnO/xa9n9a8lBBxjG0CWinyGQeXCL86ULFqjmYo7X7A+xhMhdgl3xd5xNxoQLCTpWiHNhmz2fGdlKKN42Kbqt0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQpuUi2ipLU+5S0CEyKzkAjvuN+aE/xhHrgxrcdN45E=;
 b=GDxbDCbSg6Azy/UJkvg2TQrdCRyEQ+5tLz8VzXnlAp4WwJwiim0cm+KsuBQXZDQ+tIFt1Wh3FRxyTIZTbhw7K4IhBSX8YhzxQpW3M3TASIi9qSJInQb6j8KeY0lP1xZBCvKWw8QfUjRoFMo7S6LoQyB7HeI52PTkRhuzNA9au70=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by SA3PR18MB5274.namprd18.prod.outlook.com (2603:10b6:806:2fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:31:18 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 12:31:18 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 12/12] net: atlantic: add
 AQC113 PTP support in aq_ptp and driver core
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 12/12] net: atlantic: add
 AQC113 PTP support in aq_ptp and driver core
Thread-Index: AQHc6GLHInXw/V9yoUe8cEBe4kRW0LYa1V+AgBBr0xA=
Date: Tue, 2 Jun 2026 12:31:18 +0000
Message-ID:
 <SA1PR18MB460038DDE57F555A019D67F1BA122@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260520141046.2151-13-sukhdeeps@marvell.com>
 <20260523012542.1823843-2-kuba@kernel.org>
In-Reply-To: <20260523012542.1823843-2-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|SA3PR18MB5274:EE_
x-ms-office365-filtering-correlation-id: e44c7911-be52-4eef-35c9-08dec0a2d89d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 qZrnbTO0DWM112J/qW7rxxMEd6Gs1GON3Q9VrCEK+SGkkRtOFZDBkmLGkjfRh8n5GeIrCbXbZM8/DqskwBVF4KTe6BQAODcQxTb8OlfnZqr0TCIDLZ+bXhDeXNKVxubbchJ7vgf323PSns9ASQqGnKwuCd3fCEbLJRlpjzj0rJ7zGO7atMMU//5LPw9i6XpdJDJMIyiQ+wzwrqu3ogqNVXFEoMou3/yO9Hh8nhGUFU6srL0iVDqwCSgjElXVkkN5erqSZ43VNvTAgrqn+hiBPp8vgS6FGg4881I7UNuGA0xt978dS4EOvC64OmZFWWQepDuudHZwW06zJqRv70PEcFYuxCFdcv1BOm22ymstqHY/XT6qyo9I/biXT0UiNWq8WcGhk+8TXpIa9L6GlyT/8g9x5wj5RtRmXEd78RJiI/8HO6ZpEj6LmJnzrDaeuQDVPjufm3ZUag7OmmWkBF/VdkX9WYBHCWlLJJnXmXb+SCyZcl/g0nb55rasSCrJZBk6f+fTmQKl26O0tmaSPLfcCElY2E7Sh35OwHnlH4vplNTKZ3MmFZYbyG+ydw1l3tF3oJ9tavhHOacmOOvtDaAe5yffKp6iPKEKU5w688AkAMLRb7Vp/6dTAmne+LSuUux5QR4Vorw8yYnjtKV55JTwyY+02coG/TTYuV2I/AD1xdHcyJLHuNNJx3PgdvLDsiOzPK8MYrIqh19/h0vpQhl8Bf9XVkkzkbZhHsNw4cyCjdaFp7HJ+Z2OoT14mfS2h/gA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VXJKam1GVEJha01EWFhGTU9DRjkrV0p3ZTZWeVNxTTIvSy9sbXdMVnZO?=
 =?iso-2022-jp?B?WksvdVl5cVhHQ1ZRTHJuUWl2cTlYY3BSS3c3NXA2Z0FwcXJueXRMb1Jq?=
 =?iso-2022-jp?B?Yy9VQnJJRCs5U0RsWmpxcXd5d050VVR0YXlWbFp2UWpoQXJXRE41bWpp?=
 =?iso-2022-jp?B?NUoxSm1jMjI0a2lKOU4xaVdGVCtGVEJGVGduUnhVSFdSdUxVcUFXTnZO?=
 =?iso-2022-jp?B?dkdUS3FhTXU0aEFiUitDUUM1MjNlcDhDOXNrWFdKb1FacHVkOVlTenFN?=
 =?iso-2022-jp?B?SXNxRmhWejQ2ektRRXhzYklqblRaU0ZnM3htWE15NWtid1pEanJBaDJL?=
 =?iso-2022-jp?B?V0dNSGhBUGUrVk1YcjA0eXQxWHJqbTUxRjZHV092VFBKbVMrY0owVXZI?=
 =?iso-2022-jp?B?dHlLTXlCQ1JRb2ZDV0V2alIxR1Z2M2xLSzN4UzJnSkk0SHBNUFZjcnhI?=
 =?iso-2022-jp?B?Q0xvdDNtaUdVaGVpMldxdlFOaFlpY0MvQ2NnVmc4cUtxOFNOOVd4eEda?=
 =?iso-2022-jp?B?TUhTdlZKbzhTMWlFUnFyWjR0d2NRMmRjeW1TRVc4ZHNrOFZ2MGFKM0tq?=
 =?iso-2022-jp?B?OENhbG8ydk5oMlBMQ2FPeTFRZjhCNzFCOHh6QVhvRGFkckFUbWdFNnpt?=
 =?iso-2022-jp?B?RXVTRU5BUVJPMXJEZGltVTFLa0RJODB6bFVqcmhYaTVXMXVMazlsQTVl?=
 =?iso-2022-jp?B?eEMxM2FndHB6YWVGenlnUllUZTNiV1lFT2pPaFMweTYwQks2UmpBdXp5?=
 =?iso-2022-jp?B?OUJMNmNVVjV1TVZGTGpWQWpPWkpEQTNNZWdaclBudUVybVpFVGUzOFF0?=
 =?iso-2022-jp?B?QVFBV0phUWQ0dVlJN1ZGWjJwZ1l1YWZsMmJxMnlJcUF3ci81bVZkdzVp?=
 =?iso-2022-jp?B?SVIyN1Vuc3RoS1VDT3hJR2FsVXZHdkxmRFFOL2Q1ejZXR1B1N2RId0lV?=
 =?iso-2022-jp?B?TTIvcTcydW9jT1FpRTBoUzhaeW52aTB4TjRHNGhOeVNIMG1PUXkvZFJs?=
 =?iso-2022-jp?B?K1RPdzVSQnRMeTdkTlF1SUZoVFVuRERZZVI2UXNjS2Q1Zmk1S0h6ejBT?=
 =?iso-2022-jp?B?bXdqMFJhdU01TGtqeVF3WlRyb2s0eko0TDBUeDc3QXJXbzRpSldKam1W?=
 =?iso-2022-jp?B?allCWC80UXBKU2hWSGMzbTJOc3BlR0lLQWNkaGxyTWFPeHFlWEF0TitI?=
 =?iso-2022-jp?B?c3lZcWxYZFRKTXVlQ05KRlc2Uk96cWJsS016SkpvSGhuTkhSTGhRN01T?=
 =?iso-2022-jp?B?TXRrKzQ3TEp6UnpUN3VSSVd2dExNTUFtWWluc0YzRm1qVWtoS0l3SW9l?=
 =?iso-2022-jp?B?VWZ6TTBlUmFIVERFRjFWRzJLazVCVlJxT1lieURaK2R2d3ZhZ0laL0Ju?=
 =?iso-2022-jp?B?M1VGRVBzcG01NW93bkl3d3hVM3h1cTlkcUh2ZFAyWHltRTArZzNNa2Z1?=
 =?iso-2022-jp?B?OGN5TGtpWUJMT3JZRTBRV1BWOUdjck5POVJINVFEY0JxSWFNUFBwVFI5?=
 =?iso-2022-jp?B?eFBxZW1raDF6b1pHcHpycXVnUkVkQUNkaGxreElnemxGczBwL1lwZGRB?=
 =?iso-2022-jp?B?R2RoUlFMOENsVnFvdVcya1VPakp3RU5aWjJaTnZRc2FuUGE0ZktSUVhC?=
 =?iso-2022-jp?B?QS82WGE1OWpPUm12UFppc0poK0lXaWNVNDZyK2ZYRE0wa3F5S2tPdGpD?=
 =?iso-2022-jp?B?NndRcFQwbkFCWDNjek1NWlJiZnU0bFREU1Vyd3RZL2kwMTA0Vm9kRTg0?=
 =?iso-2022-jp?B?OGNzK0R5N3ZPK2ZCZEwrL3VaNlRwb2hNZlY1cXZ4ejNESFYreHVZQWdX?=
 =?iso-2022-jp?B?QjNva1JCRUYzcllDTE9yc1VVOGJkSkp1ejhITUZjV2gxZVpMY1RaV00x?=
 =?iso-2022-jp?B?S2VYVGl3QWlJQ3pSRFBDWFBNSWJicTZ3Vjk0OGNPZklJU3BuQk42Ykpl?=
 =?iso-2022-jp?B?eDNuRWk5SlRzU1pSYU5LVGdGVE9XVTZTbzc1MHpCUmgydGdFamRwamZl?=
 =?iso-2022-jp?B?ZUw4UVRGaFJmNDhDWGg2aDhpZzBDQ0xyNU5vMlBXeFJRWDg3VFFyMlJP?=
 =?iso-2022-jp?B?dEVYS2xpVy85bk10Vi9Rc0tPazJSLzJ4Szk5YUVBaG9LWW1LM1dRNXB1?=
 =?iso-2022-jp?B?VzZpcnVCUkZJdlNjK1JFVC9XYUwreHRaOW04R3lXM2YzNG01M1VEc2pW?=
 =?iso-2022-jp?B?VVVKcjJvYVY4M0U0VWxmNmVVbG1OL2hJTFZRWExqYk1vVTRMVjZMOWMz?=
 =?iso-2022-jp?B?YjJnTGdzMXBzbmJ3cUtPWFFjbHNPVnJGc0wyNDhmMXRYRUlsVVpZTVNS?=
 =?iso-2022-jp?B?bWFrN0dFanAvVjJ2N2pRUFBkVXVETEoyaGMzeE9JcmY5V3lQdzArTGw4?=
 =?iso-2022-jp?B?b0Y3QnVNVE93ckMyTVFrNEtINjI2bVlSTzNNNkJWVjBDT1p5eWFJK1Vk?=
 =?iso-2022-jp?B?RnpmOFBhTFl2bGNQdzQ3ODVxNWZPekNrM3VseUFwb3NHMC9ZdFE0MU1k?=
 =?iso-2022-jp?B?Y1dmeVpR?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CxcOhud/jGW/CRxBbJdy40CQYeYgGKSSMUBlG8Qovk5gSSroy7q2/wtaVoMETUA+fReu8zWeg4KnoPgF/nJmOPAEONxwUDhxNT7v0HzGvy062kBMiE3oZSE1c1JPxJ8KhQJ4HVBgayYzqOQ3Z8Rm+UW32tTVBbWefynhHu+qNML755+aYNRsIKZX7PEL7iL5dBt76hpo68wnJ4Be7coXLWQQca1/2PQmLEkxnH6lCdRsQZXewXz+XkoVSwD55wC2O6gRaLXuNV4SRKbq9Zul6ZGkjPuIAttcThK5toghXh/23W53ZPkqZUttZBbO28B4YO8uYjgCwSH408d3my28fw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44c7911-be52-4eef-35c9-08dec0a2d89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:31:18.4184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMGSPSesvMZNYbXzWVjHghuyxZm3lA8z2A+hDHbcjOXZHBskgG67s6jf0aE0SNM8VSSlm0ds9mp/yTIQQ7WoVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5274
X-Authority-Analysis: v=2.4 cv=RMaD2Yi+ c=1 sm=1 tr=0 ts=6a1ecd19 cx=c_pps
 a=/amG0fyRPKkAi6MGe1IgeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=lRQUk3TTQcJaUSSj:21 a=xqWC_Br6kY4A:10
 a=ZPSk82zQDygA:10 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22
 a=8NexQkqkvfV0iI9TptcA:9 a=UAVRJdkkkM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEyMCBTYWx0ZWRfX+tWCMzftPZsf
 5UL7i+y/RVq/2eLe1GpV/W0dqV7fUG2EW62YUBmEr6SymGeVXwEYurinV5FTIEN1CxFkgwwQDd6
 9zCUgXKKgdPUFu4ZkesbxPZ2ha8C7wMXFeu00Z2lPhhKBTB3wqAvJsZ3gcVn+E3BLYvuEkEB6vb
 yJdbCaIGWoCbawRvpYTCBSFHs2DmR3Nybgx6r2WdT0QAXVvYVWVTNeTW1b97si/5x0/BbyBKvbu
 lwFvmBJBVUn/7KjA3a0OhOuWuSy+kbdIrOXUB3J335fUTTmuHgsieY6iUJBwtMEfG4lZLCb53ql
 LDfAhFDNWDeXxms5iaP50fBIiBu02+VW13M/D6rFDVftIqUwmep3N+0Fa779lLv4x1w8IvMzOjt
 KPjWNJgG2zvo8yMmOVU/hCVthT/tocDg/DN2XsMSPpel+rN6EZvZeifDUYy6dddCcsh0W2Q1Sv8
 VP+Z70jg0HHRFPLEc+g==
X-Proofpoint-ORIG-GUID: kQey4M0NseZ9B1hLJ6pT9nH4un1b-zM8
X-Proofpoint-GUID: kQey4M0NseZ9B1hLJ6pT9nH4un1b-zM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,SA1PR18MB4600.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D495462E0B6

On 22nd May, 2026 Jakub Kicinski wrote:

> net: atlantic: add AQC113 PTP support in aq_ptp and driver core
>
> This commit adds PTP support for the AQC113 hardware. It updates PTP stat=
e
> initialization, refactors hardware filter configurations to support L3/L4=
 PTP
> multicast rules, and registers new per-instance offset tables.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_nic.c
> index ef94478100716..f1ce11c6a3d1e 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
>
> [ ... ]
>
> @@ -793,6 +822,17 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, s=
truct sk_buff *skb,
> =20
>  	first->eop_index =3D dx;
>  	dx_buff->is_eop =3D 1U;
> +	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
> +	    self->aq_hw_ops->enable_ptp &&
> +	    self->aq_hw_ops->hw_get_clk_sel &&
> +	    aq_ptp_ring(self, ring)) {
> +		clk_sel =3D (s32)self->aq_hw_ops->hw_get_clk_sel(self->aq_hw);
> +		if (clk_sel < 0)
> +			goto exit;
>
> [Severity: High]
> If hw_get_clk_sel() returns a negative value, this skips setting dx_buff-=
>skb
> and dx_buff->xdpf to NULL because of the early exit. Since the descriptor=
s
> are reused, dx_buff->skb might contain a stale pointer.
>
> Could this cause a use-after-free when aq_ring_tx_clean() tries to free t=
he
> stale skb? Also, does this leak the current skb since it was DMA mapped b=
ut
> not stored?

Valid observation ? this was a real bug and will be fixed in v4. dx_buff->s=
kb =3D skb
and dx_buff->xdpf =3D NULL are now set unconditionally before the PTP times=
tamp
block, so the goto exit on a negative clk_sel is safe: the skb is stored in=
 the descriptor
and aq_ring_tx_clean() will free it correctly. No stale pointer, no leak.

> +		dx_buff->request_ts =3D 1U;
> +		dx_buff->clk_sel =3D (u32)clk_sel;
> +		ring->ptp_ts_deadline =3D jiffies + HZ;
> +	}
>  	dx_buff->skb =3D skb;
>  	dx_buff->xdpf =3D NULL;
>  	goto exit;
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_ptp.c
> index 7486a28d7ff8f..31373c20782cc 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
>
> [ ... ]
>
> +static int aq_ptp_dpath_enable(struct aq_ptp_s *aq_ptp,
> +			       int enable_flags, u16 rx_queue)
> +{
>
> [ ... ]
>
> +	if (enable_flags) {
> +		if (enable_flags & (AQ_HW_PTP_L4_ENABLE)) {
> +			if (aq_ptp->a1_ptp) {
>
> [ ... ]
>
> +		if (enable_flags & AQ_HW_PTP_L2_ENABLE) {
> +			aq_ptp->eth_type_filter.ethertype =3D ETH_P_1588;
> +			aq_ptp->eth_type_filter.queue =3D rx_queue;
> +		}
> +
> +		if (hw_ops->hw_filter_l3l4_set) {
>
> [ ... ]
>
> +		if (!err && (enable_flags & AQ_HW_PTP_L2_ENABLE) &&
> +		    hw_ops->hw_filter_l2_set) {
>
> [Severity: Medium]
> If userspace initially requests both L2 and L4 filters, and later changes=
 the
> configuration to L2-only, the enable_flags will only have AQ_HW_PTP_L2_EN=
ABLE
> set.
>
> This executes the if (enable_flags) branch and updates the L2 filters, bu=
t
> skips clearing the L4 hardware filters.
>
> Will this leave stale L4 filters active in the hardware?

Valid concern ? this was a real bug and is already fixed. At the start of t=
he
if (enable_flags) block, all existing L4 filters are now explicitly cleared=
 in hardware
before applying the new configuration:
=20
  /* Clear all existing L4 filters before applying new config */
  for (i =3D 0; i < PTP_UDP_FILTERS_CNT; i++) {
      aq_ptp->udp_filter[i].cmd &=3D ~HW_ATL_RX_ENABLE_FLTR_L3L4;
      if (hw_ops->hw_filter_l3l4_set)
          err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
                                           &aq_ptp->udp_filter[i]);
  }
=20
This ensures an L2+L4 =1B$B"*=1B(B L2-only transition always clears the sta=
le L4 hardware
filters before setting the new ones.

> +			err =3D hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> +					&aq_ptp->eth_type_filter);
>
> [ ... ]
>
>  int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
>  			       struct kernel_hwtstamp_config *config)
>  {
> +	unsigned int ptp_en_flags =3D aq_ptp_parse_rx_filters(config->rx_filter=
);
>  	struct aq_nic_s *aq_nic =3D aq_ptp->aq_nic;
> -	const struct aq_hw_ops *hw_ops;
>  	int err =3D 0;
> =20
> -	hw_ops =3D aq_nic->aq_hw_ops;
> -	if (config->tx_type =3D=3D HWTSTAMP_TX_ON ||
> -	    config->rx_filter =3D=3D HWTSTAMP_FILTER_PTP_V2_EVENT) {
> -		aq_ptp_prepare_filters(aq_ptp);
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_set) {
> -			err =3D hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> -						       &aq_ptp->eth_type_filter);
> -		}
> +	if (aq_ptp->hwtstamp_config.rx_filter !=3D config->rx_filter) {
> +		mutex_lock(&aq_ptp->ptp_filter_lock);
>
> [Severity: Medium]
> Is it possible for the hardware and software states to become out of sync=
 here?
>
> The new ptp_filter_lock protects the hardware configuration, but the soft=
ware
> state (aq_ptp->hwtstamp_config.rx_filter) doesn't seem to be updated unde=
r this
> lock.
>
> If a link status change occurs concurrently:
>
> aq_ptp_clock_init() {
>    ...
>    aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
> }
>
> Could aq_ptp_clock_init() read the old software state and restore stale f=
ilters
> right after the ioctl configures the new ones?

Valid concern ? aq_ptp->hwtstamp_config is now updated
inside ptp_filter_lock, only on success:
=20
  mutex_lock(&aq_ptp->ptp_filter_lock);
  err =3D aq_ptp_dpath_enable(aq_ptp, ptp_en_flags, aq_ptp->ptp_rx.idx);
  if (!err)
      aq_ptp->hwtstamp_config =3D *config;
  mutex_unlock(&aq_ptp->ptp_filter_lock);
=20
The link-bounce path (aq_ptp_clock_init()) also holds ptp_filter_lock aroun=
d
its aq_ptp_dpath_enable() call, so it cannot race with the ioctl path ? it =
will
either see the old config before the lock or the fully updated config after=
 it.

> +		err =3D aq_ptp_dpath_enable(aq_ptp,
> +					  ptp_en_flags,
> +					  aq_ptp->ptp_rx.idx);
> +		mutex_unlock(&aq_ptp->ptp_filter_lock);
> +	}
> +
> +	if (ptp_en_flags !=3D AQ_HW_PTP_DISABLE)
>  		aq_utils_obj_set(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	} else {
>
> [Severity: High]
> Does this break TX hardware timestamping if RX filtering is disabled?
>
> If a user configures pure TX timestamping (tx_type =3D HWTSTAMP_TX_ON) bu=
t
> rx_filter =3D HWTSTAMP_FILTER_NONE, ptp_en_flags evaluates to AQ_HW_PTP_D=
ISABLE.
> This clears AQ_NIC_PTP_DPATH_UP, which will prevent the datapath from rou=
ting
> packets to the PTP TX ring.
>=20
> The old code correctly preserved this flag by checking
> config->tx_type =3D=3D HWTSTAMP_TX_ON.

The AQC113 hardware does not support isolated TX-only timestamping ? the
PTP datapath requires RX filters to be active for TX timestamping to functi=
on
correctly. Setting AQ_NIC_PTP_DPATH_UP based solely on ptp_en_flags (RX fil=
ter)
is intentional and matches the vendor reference driver behavior. A
tx_type=3DHWTSTAMP_TX_ON with rx_filter=3DHWTSTAMP_FILTER_NONE configuratio=
n
is not a valid use case for this hardware.

> -		aq_ptp->udp_filter.cmd &=3D ~HW_ATL_RX_ENABLE_FLTR_L3L4;
> -		if (hw_ops->hw_filter_l3l4_set) {
> -			err =3D hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> -							 &aq_ptp->udp_filter);
> -		}
> -		if (!err && hw_ops->hw_filter_l2_clear) {
> -			err =3D hw_ops->hw_filter_l2_clear(aq_nic->aq_hw,
> -							&aq_ptp->eth_type_filter);
> -		}
> +	else
>  		aq_utils_obj_clear(&aq_nic->flags, AQ_NIC_PTP_DPATH_UP);
> -	}


