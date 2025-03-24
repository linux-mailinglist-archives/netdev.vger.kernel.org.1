Return-Path: <netdev+bounces-177030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE877A6D631
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2378D3AD2B2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEF7DA6A;
	Mon, 24 Mar 2025 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hpTF+sh7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1532E3383;
	Mon, 24 Mar 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805125; cv=fail; b=Syq0JaIWiAPUcJXsIOTKOuzFOcKdcU7kJZrwOIc/I8ZMRrycRPZUMd75VPHjpAjvAx4fHOLbu04/OY0gXLNnvwvRafceTZ64OFWX5OlGRXWWkYLMByhpR5QT9a/NF9G1HlqkocftrUMQ/CUtbtiTdzoojGRXt+vPzoAntcGwww8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805125; c=relaxed/simple;
	bh=l+RtAMGa7SCz0pg5VjIM404HjZ8c3weUdCLHaukYDvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h3TM9p+IWnOpI0skwTxDyAqemPaOwKrQ89ohxhEtSGhkOhkv6m4vrBcLvskj6G/6ui7tq/++imZKEK9JimhfDfrDyblUZjB1nVuFheSKGTkltDb1U0z1LrZtAAPy8ELIcmF02vLAP+Pity3uzESSVaHVXgVaDpg14AIJBu97/vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hpTF+sh7; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O1RGx4013662;
	Mon, 24 Mar 2025 01:31:44 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45jhfbhdg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 01:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqxE8ZvQwp386KPboVzyXM0DKkWJmEsKM+MOcyWnpdO2k4Nbvw3kpwmqi43hgQr6jCcGp27Q14Bd3sa8Odh5uuPCr6mD62cOYNNto6FrXaIsaZIurzHSCv/ShpgCbqs69y8miMN87HTe5XX8BF6I0bdhJkOGc2GW43TOoEGI4HckWuDDISCofEPDbiJTqQHcM/YCVjoUHeFNG+BS22cWb3ZzlZl59Z+1Fc7N1HYpbIaANsxM7B4GrqZz8tewv+oDqd2sxY8DITLUD66j+NQ6e5FV8db1Na9dSBcO65LwBtyBDLVUhpCjQqsM22+sbr/Uz1ZHB53olZPA/Zbn9GWm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2kWfV0gvO+fo2JzGe0RP9a6CNRWGk9lEDDSnKV9SZs=;
 b=Ks6pwH2rECoX98vN3kriOhuZaYTpu24RSkRVDdrIvAqMK308OWTYoVI/GSpmy7LhiLFwejecHh2Ga3TUuIgzjq9OnxDdidmIxf00a+2HK5eatqZFmYGHKeHc9adxytlUaW35J0QltKbXKnqM1Wt0CamPpfUYgseim7eYEumB56fGOZCYS6mAYDInFD7wNVFIQjOPQy4vk6G8I62Eh3r6tqCsLN1BVgG178e0DtLuk7jcx2yQoHomxClOY0dnElwA4XEMzlpGjuPhaGG7IOGciwNKCkH9EH9cjn0e5+cPPR6/D6JN1eHfsTu84/2TcmZ/nkwJG2lQLXGHb9rMiEjDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2kWfV0gvO+fo2JzGe0RP9a6CNRWGk9lEDDSnKV9SZs=;
 b=hpTF+sh70nMBFB59Z87mqB7gYuGv/emWOrX3pGQ2/lUAkHrVBqJo+pkoK25ppK0Pn8qTD+Bt9IAsY7MQrJ8F94DxVITvb6xpTxlopKCydyr0dBSpdPR4JX18qrNJASU1ubVM86soxd9XpJ8EhrgTK5Sx1s/BvWL1bt+raXR/q0o=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM8PR18MB4487.namprd18.prod.outlook.com (2603:10b6:8:37::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 08:31:41 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:31:41 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Chen Ni <nichen@iscas.ac.cn>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob
	<jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] octeontx2-af: mcs: Remove redundant
 'flush_workqueue()' calls
Thread-Topic: [EXTERNAL] [PATCH net-next] octeontx2-af: mcs: Remove redundant
 'flush_workqueue()' calls
Thread-Index: AQHbnJQk73dv/z71NkSx57C/aRkm07OB84mg
Date: Mon, 24 Mar 2025 08:31:41 +0000
Message-ID:
 <CH0PR18MB4339D4D8F38B3A70909B9329CDA42@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250324080854.408188-1-nichen@iscas.ac.cn>
In-Reply-To: <20250324080854.408188-1-nichen@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM8PR18MB4487:EE_
x-ms-office365-filtering-correlation-id: a8104718-9e3b-41e9-cb2f-08dd6aae4d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eaBmyPz6oEsqBkWpV0LDih5mjhvw6NQ+JGUTj0M3E2pp6mvNPRAqdbiZDvAS?=
 =?us-ascii?Q?0D7QIq1tktMA5RfZJjslFKXBKAEtoXpe6EMn3719AW6dq5A4CQ9t9daLXlXW?=
 =?us-ascii?Q?Np0NU76iu/vCJm4cyZ+eBpkUzuGmFp9COlawyE/gS9eCHcUaJfAZTudfMLNa?=
 =?us-ascii?Q?sOcX7PG9ThOez4lSAluVZmAMXNlWP+87TnK+q+dsh3IBazdXR4wK/cvTVCP7?=
 =?us-ascii?Q?5OzujXWCTfDYTpVEyvQXSOEf/hl4ABkiSoF2g7i7sJXBPbonq3x9c/P2Y8vz?=
 =?us-ascii?Q?WY/Gi1ibX7NLXqeEnE/mWvycPeRJKIFQrUKJqF2EJZSRRLMWAmNqt9invizg?=
 =?us-ascii?Q?kTGHSPuzzGhW+A7vIC/Z5PIexPXTHlG0WBO++EBiW8Yttqz462JzC9RMRmNz?=
 =?us-ascii?Q?scRAx1HEawY1C81jddqUarJK1wGymSmVkMlv1KcgN9Yx/7NBdy6/oskaEheB?=
 =?us-ascii?Q?r+o9qIc3+DT1ZpjNJZIibPM8BRpKlMQKL9ixCNTrEg0f+1M0TDnpwkohjK3U?=
 =?us-ascii?Q?JnjTpm91167LefnDjVkdJTgkt6JjgUPHn9UHEXm95nmB7uIO6ONDQNDG9oFz?=
 =?us-ascii?Q?GymsVgVce1CrJDQ8Wdf1LIW7D7t7obljvd5ushrbFSK++vJ9tvgNwF+qQRUt?=
 =?us-ascii?Q?hdNx5Wn2hBmCg9/m/ZLlT0R027el8vZ0qb6QjVE795ccKHOS1xcZecsZnq90?=
 =?us-ascii?Q?fIrf0xHh7LooiFbYJxHOa44tRb87Bno7ldPs/LtcgR3g6v4EmZPfo1RKWuCP?=
 =?us-ascii?Q?It8/baiUUh1plpKTuAYRcCN9Wl2FaezCpEY+MP4Z94TAuKIk0FM8e4Ln0bM/?=
 =?us-ascii?Q?0NeXllXNUgyTyd858LoPRIlPRjojoOYPkaNb7SjOvXQjuDrN8LAVL2KualOg?=
 =?us-ascii?Q?gBTtG6eJc7eoWEVZOQQ+NPvcR+Z4ZKiCI74eV6F7AUD2EAiwG9fcJEo1mCJH?=
 =?us-ascii?Q?NNfy+jLoVIaLaIlB3bGZkH/q8as55UkBndqmCGkqyggHccpsrgshnC+CPohI?=
 =?us-ascii?Q?u4s7NPqR7wexbO1kQ1efVSGVdnX1KiHRSp8iTkS7HN7ceYsm1JCm23crRa8h?=
 =?us-ascii?Q?+IXwYRK0qSxuO1JAMuXsS24f+K1Dm+vaGFeVWTcG6ci+5hz02G0tpYnH0Yqa?=
 =?us-ascii?Q?v+Ph6Oa5ibcF6nhQB2vQjBeb/+BQdIPI+t/9+F/JFdJeYc122B1/V4feDxTn?=
 =?us-ascii?Q?imO5dr0l+COSmHX6E6mBWO+551mBVKz+6JYI+wVcSQi6TST5Z3qpPZLV+Abg?=
 =?us-ascii?Q?9PztWXV9KjRoWIAnS3IRzmseuwsboJTBeYYS1dzAv3qv4JYXWcadCXJHp9cv?=
 =?us-ascii?Q?OAr+Yx0R4MVsPAWZC6ViTfQHAMZTn9itZaa9ZiaWXIgrr/SgtLM0uiobrRnp?=
 =?us-ascii?Q?z22AaabeNuwxwrSfyfqtdHfAJg/UXpww3aU/b+jBsG+TLcOLQxpfc56i2BPp?=
 =?us-ascii?Q?WQLTAYP/QFjJewVRszA6Mpr2Mi+JAp3vO8cnlKFUImINmeKqIjNLbQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zlmbpP78f1vCGY4ifrkAe5/Se/HVqirdtUjqX9qHXdGsiqhpkV7fsulmWA1a?=
 =?us-ascii?Q?mwb+hUv/V/zTMesTv1H74uBaAkCDUP5c0NVrsdmU+3wIUcDr0V90/V2Tpi6W?=
 =?us-ascii?Q?GKqpKofCMsP2RPqWRnSwtaEE01bInHNtGV/6b7VFF+bRjzOyOCQfcmQxOLIb?=
 =?us-ascii?Q?zHSDfhgWX68F6PlMtnV8Nxny0pGYlBEBg4d6w3WZxkjYNt0eMUkLn9c7og83?=
 =?us-ascii?Q?vcQdTYNGPDD2BZme3wfON4BQNwtTJGYFWMA1eii0ciq8b/Pe6ppY3m1fak4Z?=
 =?us-ascii?Q?GPzBDd4NhBncgzsreArSkG2+xXD//EzxcVHQMPf3OuiQIWmAuPsebqo+s+ku?=
 =?us-ascii?Q?AUFf0Bf/IXGjOCxzSqWjcOrfc/8Fh/nCY/PH1+KoCLiHD9Mt0XUVsXPLRMiS?=
 =?us-ascii?Q?YwLkbxqKIC3udv0lYDq0YYNlf5ScESDAQbzm8xmeNSFCivOBObaEj+lPvF5l?=
 =?us-ascii?Q?kdwKQRSpaB/O/vI8k9dNcSpvosQQGxmy6qvzdGM3yOn2lwj2j4C/FjpaPoSs?=
 =?us-ascii?Q?dLXgqmO5YArA2+839w6aRbIk6eIElJAb/+O4Jft+71R7eYBRV1RS7ESpQLYD?=
 =?us-ascii?Q?wKdQvZZLBtEKMHw8W/W1AYcekXIUh99iz4zEGoZO689BMYN9ouzzs7/EjTTf?=
 =?us-ascii?Q?+knv5pSdV/NrNvh6NJihJCFuOW2pYIY+wWGEF8n8s+2r2r42Wq3EJE/AmWXf?=
 =?us-ascii?Q?1qGkqDMlFY65NX2yH/COZiNhsVMBTkT6LDd4DIaGRSHPQVH48cQlvNGzVkJc?=
 =?us-ascii?Q?fdgCH3V2NTGPkVLX6BiN/6KCZ2Qq+7DCoWHQMqSk00flomd5iasL+LOJaPw0?=
 =?us-ascii?Q?80sTy6s1VrWENeVSTw2If3HzxvtnZ2c6B1vHNaGBsrTURf2Wd2mdRDMamHvn?=
 =?us-ascii?Q?1Uw4wi3sygKAZ396IC9ddXvHE+5dgtl7aU567f022rNGP2NIgIRKEaWnaOKm?=
 =?us-ascii?Q?QzcVxBYIeOH+cDLvpQ5JNO0D76OUu7cDZ+QTDdJcZnhasMo3YyBsdSmhdsWy?=
 =?us-ascii?Q?Q5o2WBzM4XWyAJHKjySWYC2KAaG/I7kYMQnmKgoCo9rFb/sH2nX05p7qa5Ru?=
 =?us-ascii?Q?/GaRfcWsr1GAhlZDmh2pQW3A95BFBAsR8l0BBIOQvjGALzgCY5CIqoVxxU4T?=
 =?us-ascii?Q?apOEoF6zssFgC2FyAKe5Ldoz824fgY53ikwJEO3BD0jt4+znc67RGYAlmtN5?=
 =?us-ascii?Q?kSVYes+ypV4Xcf7wveftNB8LXhADrSedIz0n2j3XF2yYvpmxM5vUMVm2i5qq?=
 =?us-ascii?Q?uLIbscKNrV6KrYgVajIojP3Y4eAdcMsGOBAIrNkDWuDdawcaxaBXaHwvbtY9?=
 =?us-ascii?Q?69r2VNuTREn37pH/p8G3AZBZd82cCcvZinvGNFedhTx5PbMFR85/RzIw/JMe?=
 =?us-ascii?Q?Q40sLx4P4g21SG/4WFuoeiBxV2dYbDYHioQEZ9IMil0AuIOLSNkY9BjkHzfJ?=
 =?us-ascii?Q?8ZDjmAym6CE1I7dLWxR5TyHWwYPWiss/xEeunKwJq0JOklXm0/Sqjhe5SMwh?=
 =?us-ascii?Q?2NGef7AN3jPQP3V4iKY9O8M0tiIzESrxkEyqcrFt1HJz45iMLfFjJe9lBbwa?=
 =?us-ascii?Q?KNxYjO9Pc0gXeHy0v/0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8104718-9e3b-41e9-cb2f-08dd6aae4d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:31:41.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVrSPNphUE/QrpO2rs6EUzPGX984afaDXBRXmvPS79Jt/ivcynv3Pmi0AXGus1h4sYmVIWnZvWcI/wYeuB++zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4487
X-Authority-Analysis: v=2.4 cv=TrPmhCXh c=1 sm=1 tr=0 ts=67e1186f cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=4wpwnmTNOxbYWQqihbIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: MvhHKddAK3Fp0NWnhN1lEVSIZ-n4ZZ3X
X-Proofpoint-ORIG-GUID: MvhHKddAK3Fp0NWnhN1lEVSIZ-n4ZZ3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01



>-----Original Message-----
>From: Chen Ni <nichen@iscas.ac.cn>
>Sent: Monday, March 24, 2025 1:39 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Linu Cherian
><lcherian@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>; Jerin
>Jacob <jerinj@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
>Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; andrew+netdev@lunn.ch;
>davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Chen Ni
><nichen@iscas.ac.cn>
>Subject: [EXTERNAL] [PATCH net-next] octeontx2-af: mcs: Remove redundant
>'flush_workqueue()' calls
>
>'destroy_workqueue()' already drains the queue before destroying it, so th=
ere is
>no need to flush it explicitly.
>
>Remove the redundant 'flush_workqueue()' calls.
>
>This was generated with coccinelle:
>
>@@
>expression E;
>@@
>
>- flush_workqueue(E);
>  destroy_workqueue(E);
>
>Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>---
> drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>index d39d86e694cc..655dd4726d36 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
>@@ -925,7 +925,6 @@ void rvu_mcs_exit(struct rvu *rvu)
> 	if (!rvu->mcs_intr_wq)
> 		return;
>
>-	flush_workqueue(rvu->mcs_intr_wq);
> 	destroy_workqueue(rvu->mcs_intr_wq);
> 	rvu->mcs_intr_wq =3D NULL;
> }
>--
>2.25.1
Thanks for the fix.
Reviewed-by: Geetha sowjanya <gakula@marvell.com>


