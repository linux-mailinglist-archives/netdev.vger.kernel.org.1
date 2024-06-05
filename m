Return-Path: <netdev+bounces-100844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53B8FC40C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897321F26762
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6514A60E;
	Wed,  5 Jun 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aB1KD2Au"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEE7346E;
	Wed,  5 Jun 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570880; cv=fail; b=aNw9r8+D2dp9A0UeO0z+t9PI3lwngJUN9B8Yn64EviqCYltrlRsRnf4ca4sw7+4Z6uKDRBHL7rUXKTf55PfWmQ3mxPmr+AtomQ5QgTv6orifG/ztOgDK5ZEdNlJcXVb+ENybTHYz8Z647gYBwqFbgCdI0dmWA8fsbZgoE5RwBHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570880; c=relaxed/simple;
	bh=BAMN4489cndOrxoKYWkJeAdSrTrv5XetF6vAYTeHxgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHao+Z7J0E9rMy7sBnlkG4BgyNhD02DoFm61F9svu/1cFvuJxWvz6BciKiCr4SSAw9wPtDf2VPDDPwvwIEGLWrfENMF3ZxbDxmkFczQs4js4kOZf4KGQiRgC6MzAW+sYxqaz2DbhLZ5go5OkwBvWPr4Ekeix+72aHRzUZphTqm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aB1KD2Au; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454KRqR6004139;
	Wed, 5 Jun 2024 00:00:42 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yj167c7r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 00:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnPpNZhlQnnS2dZQBXlPbnoszGbOYKlIM+B2h8AmEgcrjnnXY4rywSDThNTAIY4pbKGPOg+9JpCPbF0rztGMsMBCi4JOlaPiUe1b6oYZo/j9TMm8OZ0SfPRrgl9ywjYJQSShRvjIBRzAEkMvlDREPU5/uczAIG1HN3R4bZaLycy1PP737gkUxOSTrqV9/DPnHyRYHIprhr6uz00YTrjSJERM+zrSBw9SRwosTI5ien5v83ovpHlNahCxMGHsVvP8LpGBkV/ZuAg/dpkbcjkqW86BnJIN7BbSoYN11x19jg9KebElbHRggf8ZiYEFQ4Jy3IDA73XWbdtkaEeDJLkI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvstH8AtHu9Vbf5GktQaC4OtwqIMvso0tnNR8lsV7KY=;
 b=a1tEYCdzRNlhd+Qu4XvjyW678UbfkhwwTNvl0ei3lds26g2lqq3JGV3CFht251xwkAHpte2R1oVQpiowrDiySmuPVCzRPhpwscZKI9HyEmTyAuBIx0kJkuXfJ85HW0/TQCdF8OPS5to1qt9oTEAI0ZaR5uw600mDJO49Z+LCy4ZDcJDSpJgtMeelX8eTQkWhILJm9YLxcaeC8j5JEBqnyfE0ZVUkBaFYMPc5wCDq4YfaMfZp0riRfPRXUt5P16IExmRxR+0X5e39OY7x9GWw7le0sd+2VK3s0ixAqluHdv2zXnWrlqr/eepPKbZvgNwAlE/IQdB4+4Vxmoehfs3f+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvstH8AtHu9Vbf5GktQaC4OtwqIMvso0tnNR8lsV7KY=;
 b=aB1KD2AuRluCJj3cGIpdD2C9Ccp3+SEdaODYbM2wTbmUm04onnS1+kSpNVEszTbJQIONCC4IlgqlSrVnMCv1rE0FBqSuiYjmmkEKNN8n0CqYVyMW4kDjZW2eogO64JuSRGHI/6muRUPSG7s1VPgdqkPg27FYfCHs6Py6/cGHzX8=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by PH0PR18MB5210.namprd18.prod.outlook.com (2603:10b6:510:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 5 Jun
 2024 07:00:38 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:00:38 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Su Hui <suhui@nfschina.com>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com"
	<ndesaulniers@google.com>,
        "morbo@google.com" <morbo@google.com>,
        "justinstitt@google.com" <justinstitt@google.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "ahmed.zaki@intel.com"
	<ahmed.zaki@intel.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "justin.chen@broadcom.com" <justin.chen@broadcom.com>,
        "jdamato@fastly.com"
	<jdamato@fastly.com>,
        "gerhard@engleder-embedded.com"
	<gerhard@engleder-embedded.com>,
        "d-tatianin@yandex-team.ru"
	<d-tatianin@yandex-team.ru>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: net: ethtool: fix the error condition in
 ethtool_get_phy_stats_ethtool()
Thread-Topic: net: ethtool: fix the error condition in
 ethtool_get_phy_stats_ethtool()
Thread-Index: AQHatxYSXfoPHCepTkml03iA540XAw==
Date: Wed, 5 Jun 2024 07:00:38 +0000
Message-ID: 
 <PH0PR18MB4474096265EED015A2A7FBE0DEF92@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240605034742.921751-1-suhui@nfschina.com>
In-Reply-To: <20240605034742.921751-1-suhui@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|PH0PR18MB5210:EE_
x-ms-office365-filtering-correlation-id: 4fa3abc5-4b01-47b4-fd3e-08dc852d34b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?kT+jg6iNqMihmQZkwfBivYNRC+Ua+G/zwE9QLMPtjW4lDKwAGGE39vttb5Ps?=
 =?us-ascii?Q?0AZ1YLIiE5k98weeXkQ3BtHC8jirDCitv6j1P63DE/Foks4CFXZ0fSwg5Z4U?=
 =?us-ascii?Q?7WJ4EpBCwRL3+XTJ4U13rFiCfjrPxJ0oBA9eK/f9p0N1mJTPTlNHaE+Oa2sD?=
 =?us-ascii?Q?lS7F5dahJWYqPDBIDoD16w3ijzUsftMZYTCbPkGg1ySmKvki5ferEFl6K+Ip?=
 =?us-ascii?Q?zd2EGsqngvR8efTFUulJjjhPujEWA8RnDbbJihaSOKyGhpp49vsJq1fXAzwX?=
 =?us-ascii?Q?c+x+ivU24jYrZ1X7lktMAJcTOEtIhIKMn/tB4qMnFU7hd7oXToUjIp+L5KMR?=
 =?us-ascii?Q?8uE3mvlv67Ap9iqokXzh53DsC7qx7YrsOLYsjwwAubhpoYghn4RT/kxjf0/8?=
 =?us-ascii?Q?TD80xDwtzTiTDAmPKnF4qlJYzGMaawfjPd66+QsnWsGychCVX+KA2+i3nuk+?=
 =?us-ascii?Q?QOe0xJhGO4Y1TeS4ozBEmnKg3GlHgQaMraOrdfEzl2rgmDMBUm7GuWBXxhJS?=
 =?us-ascii?Q?qP2EzvV+Bcp9uFkVXOMLUg7Lya1YWgV8ybFeTKQdf+RiwdLy0jAd2VP5WVXE?=
 =?us-ascii?Q?lcB3yJL/FbWgiFa/XLjH9048bmfIQfUEMvdJP/FD85fMkx123uhpFvrFzzLb?=
 =?us-ascii?Q?hK4U67Ff9z+XqrmfhNWGerlTsE5E09liPVH7tZvGVqr/oou8bhYOx3FtWjQP?=
 =?us-ascii?Q?68gDK+BSd50/RaWlbcwyWRudZNuKPuRVbvaQ+awEbWnj6cTEoPOMtQzMeBYX?=
 =?us-ascii?Q?tAF//5QD8sOQpRXO92sKQLn5nBrIkaWOi9VQR+NStydP+6xsBEwO0IhtGSW9?=
 =?us-ascii?Q?4wzTbRfQNCFHoTZOQ/QznIVV0MCa45Gi5Uh1COAZ9XheVLahXr1zOTcV267r?=
 =?us-ascii?Q?kCyPccCgbnVYeyOgweo3MUFajCz/RWDwMmZcPiDFFJxmW4WFemoiC3MVahNk?=
 =?us-ascii?Q?6Hko1PKiMSTSKskuC5XNBINPDoTWD1SM0QC9sQUwMdUeWfFR/4P8YiNDLeHH?=
 =?us-ascii?Q?FF9Uiik2gxuBPNXGeEBIBE9wgZCVQaDTElHjv3ecTIQRPIjv60JbETPZrkIL?=
 =?us-ascii?Q?9U0dkVxzTyW6tfdiJK8ejUKRwrj+m+aKeD9Ui3GkPc7tpUXep/Wja8WMyyBR?=
 =?us-ascii?Q?H+Db3gTAX+g3hHN5ll2NfIA76XQygF38EyrfJgIKS7rX709+hcGARqdrFfCs?=
 =?us-ascii?Q?yMlu95Xh9PczFGtzoQD7M6kFyCQJjqYLwYyO0sDxvfjWa9vzfKRdzObyjZg5?=
 =?us-ascii?Q?vuJkLOluRBmcJ1WR1my4YyQF0CYZzIGOU2AW7jPSu1agfNw9P/nDL+XCqSki?=
 =?us-ascii?Q?+vjZezo1jgW8gcjPzKpSgNqRG8Cw9SSqUhCfbcTsyK0Q7FuIqFzFxjzTSYWj?=
 =?us-ascii?Q?n6WElIM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4lJ4Q2PGCEPueivPBIPvgQYGx+30ehwnJK/f+1ah8qyTJZKwk3kWvilgWnOg?=
 =?us-ascii?Q?WpWAxlJ78ZgICz4mQBBIh5YXzBsnLRQ6ddi4bqm7XxU6wXNSEa1pw0i0hN1F?=
 =?us-ascii?Q?LqHs7lhjQkjz3yhPuY9KA5EWfKe2YYYeYLtuxlTO6eq0JfT6e3tULXHjHJUv?=
 =?us-ascii?Q?JgM+5UN/NEcNrM+Iq5ix1/i4Z9NWoaKACzzgsR40sc6mdwInCXmRxK9IhPXw?=
 =?us-ascii?Q?7479Xi1HpK+61YsEAQGfq6yEj6UYM3x90zM8F9fLkAr9isG4vvz0noDKGzAj?=
 =?us-ascii?Q?KbKqfmeIZ7mI/S1c2Xg0hBn+0WooPCNB/R75NcySdUWMiHKwG6vqz4xIIwbM?=
 =?us-ascii?Q?7EYsE1+uLlAG6V5SHqnFWbThJRbUgEuIV9V0Syze119dy+0GipNforyoWcCL?=
 =?us-ascii?Q?DCZAcMKqATA3ixRbzzVWZX6IS8bJN2mf0f+odqh0yIlM/AKWgTSLm1mMN9MK?=
 =?us-ascii?Q?T7yHK56HFiu5wZf6sJRxPTq8LG7gqBx2w2eSN2F5Oi6WArRg/59yBKGnK2Xj?=
 =?us-ascii?Q?J8CvwN1L5QIEsmmgGPTfHCDpwt8Rv2cbQBjx/i6c+OoEHe/1St5Z8CIilGYm?=
 =?us-ascii?Q?IUyBH1fluuwTM37LcX1GuR+T6CHeQtTgG1q2QFzFF3SHzZ30DsX2L1Nl5Grd?=
 =?us-ascii?Q?lNVaWEoou7LnU08LEFn3CIRugLNmF3DhwuGAZfkXqb6H7XEm7XOtXVJdbREg?=
 =?us-ascii?Q?H66MlUAUgiB6+Xz7COLyhB7BIpCnhcI1SZfVzhn35Beo6oU7AVWjQVCwvcdL?=
 =?us-ascii?Q?d9Npa6PZf8gN65Z9aigrAupngz5LFOpGXNjYa6v1RBEDXdQ0efbZ4DXv1iZw?=
 =?us-ascii?Q?i4Nudm9cHACxefWMBjEVvTvLnpwIKRiuRbpVA9YB97q0mtkUzQX0NAEpMDLP?=
 =?us-ascii?Q?RP4Scuuc5h/O9Pfd36VpQtH3soZv87/xW6tewxABuzn7UxbjjQ5SZD5xxan4?=
 =?us-ascii?Q?dGXENwpQjONR2lp13yAz5rGPyVPPJmyZ/pPta0ekiZPeZ2NXqyihzAuuwUrn?=
 =?us-ascii?Q?l46rH4EUr6LMbjity0r57Cq1Xib0aQNG3bay1IH2D2Ap3rD53AI9IGjWvowy?=
 =?us-ascii?Q?Eq36E5j9MJ3Ax95kJgIzdpLtow2a/zqnSsI9SqP8roc+rAjT/0NK8CuL+NfW?=
 =?us-ascii?Q?mKm8zICGd7WrazbKsVIvu4w3B6jpqelCV5TbWKkrnIkJyVD6n3+AVbkcG39N?=
 =?us-ascii?Q?wwSMNjgRMpl6JeixllHijaMVbGAs662lQKUje9er1uhWRIEsZEwNPNtnP2fu?=
 =?us-ascii?Q?omvwDx3lRrqSAS0Xjouad/uI2jASEDV0FgfDjZiMgpQhnROk99PZr0dmzxFj?=
 =?us-ascii?Q?2ibRDWiWFE+PnmwuXg8bEvPQvU+H4OesyUpSaGlMpc+DMHnLZ2wwWycAeyw1?=
 =?us-ascii?Q?L90cnPLcmKj8K0TEjape07acgsgXvSMaoQdSxsE+QuiOTI0xjFcq5bknL3Kb?=
 =?us-ascii?Q?qt8M0oAPWqwAQM/8DRFugARuXEqi7h8HNY1w+W9fRJ7RBRtbkHyv5yHVIszH?=
 =?us-ascii?Q?cPlLJrGFRXhxkFti5IH8qv+g0CxjXq6jKNL8FjF1ge5xY/dnMWDvhXblDVJn?=
 =?us-ascii?Q?V8DxZYyE6WqYxIm/Rt4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa3abc5-4b01-47b4-fd3e-08dc852d34b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:00:38.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGbls36K8j3JbOvXt+JjEeI02o8YK9zIqSF2LpEawvmFAzAA27Viyo/7gRXCNuVscDbB4OeXOcw1PR9hxD3g8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5210
X-Proofpoint-ORIG-GUID: bOU1_Y3k0uGnyvPzksPpn52BoZZNAaEK
X-Proofpoint-GUID: bOU1_Y3k0uGnyvPzksPpn52BoZZNAaEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01


> Clang static checker (scan-build) warning:
> net/ethtool/ioctl.c:line 2233, column 2
> Called function pointer is null (null dereference).
>=20
> Return '-EOPNOTSUPP' when 'ops->get_ethtool_phy_stats' is NULL to fix thi=
s
> typo error.
>=20
> Fixes: 201ed315f967 ("net/ethtool/ioctl: split ethtool_get_phy_stats into
> multiple helpers")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  net/ethtool/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c index
> 5a55270aa86e..e645d751a5e8 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -2220,7 +2220,7 @@ static int ethtool_get_phy_stats_ethtool(struct
> net_device *dev,
>  	const struct ethtool_ops *ops =3D dev->ethtool_ops;
>  	int n_stats, ret;
>=20
> -	if (!ops || !ops->get_sset_count || ops->get_ethtool_phy_stats)
> +	if (!ops || !ops->get_sset_count || !ops->get_ethtool_phy_stats)
>  		return -EOPNOTSUPP;
>=20
>  	n_stats =3D ops->get_sset_count(dev, ETH_SS_PHY_STATS);
> --
> 2.30.2
>=20
Good catch!!

Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>


