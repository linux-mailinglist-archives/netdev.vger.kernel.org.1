Return-Path: <netdev+bounces-294176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZcrDRDIHmo5VAAAu9opvQ
	(envelope-from <netdev+bounces-294176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEB62DDD5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=uQOqzQcI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294176-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294176-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0073030CE9E8
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14B3A8734;
	Tue,  2 Jun 2026 12:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B13382F7;
	Tue,  2 Jun 2026 12:02:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401763; cv=fail; b=fClQYHBXqwAzUcf9blfL22jw+SLbdv7DCzOJcxUip7TXFVFFsifJeIa442iDTSlNTUhN0WcHjkAnJLnV4JHkQU0d6pJT5vqC1Uen+msYtPPMsQVi3HA1KqMi02UVzIQntJ46FjlbJPwgAiBJmhFyw1/bftghW8QvT2w5CtWMxsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401763; c=relaxed/simple;
	bh=Wi+pGhLrOyxLs8xa2TXNcYErZbjCiH/HM5v+S/MtPRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TLTzsIMa2cfYceptuR6X08SU2O5GDoyma9V1Uq7K/vUB41m9nyAoTOpeoLX8Gs/1py74iEOZNd9zdfF+DkHKS8EzdQlV+I4DqRfhTJwXqJGna/xip1BouVhiCLU5QiwXgBq6RRFcNgjxY4KjYRYOMU2eRheHzSrE3wvqv+lq/rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uQOqzQcI; arc=fail smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6526RGik2042511;
	Tue, 2 Jun 2026 05:02:09 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022132.outbound.protection.outlook.com [52.101.48.132])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehswn8ydr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 05:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUxXb7/nB2CZCkdiRKZqueDWj0xtaugmBvzsfAdBKaZbPqYJ58fCoiWqZaob23z/yXWTlnOCeCQlU7P6gbYAvTBVZjd4r2kT7vym5REu3XKns2/0pVirhx9FRUXtfZisyvING08fvgh9SUqK6h3CCD95fftzroQAIFrn2sDRk14JeEla+vKkEMY3W52S0LY2B+2H8T5EuxC/xSCwROQKoziosfC0bWcZdqm/0tIxAElEjsDu2JANDP7Dt+Ghbxoq1heE5L2l4u6qLrbctKjgFF+/3/ZC0no0TDiyVVcHFQwm9UbJTmdU9fi/baifeqLg4sDBOBrVaqn/7za83J5u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55ez2DJ+tRbtrtQWsUXxyIkuCi6wKAuo65NBPLRcYqQ=;
 b=gxAkKZ6YBQff0zq7fDGo0MXDbuzzxCWdimft2FbOxZTO0GXaufIk3tdINIRIgxQy4GkMIZeUCrTK4sV2dhzidGKXJe0f1Em58eIzxVf2N6EoquilMKipM7rt2fO/DdTPTm6FsuhWe7eiP82lUX8RTmnNNf1M8gtwlLfzde3UvbhWmBU7DiPjaAFq7AcfMRpPqQYGUKvshxGaKJSp1OLQzbC/hzBbeSPXwzUUNSh+uU7nVe7729u6b+4Y7pogdUZRRl1A0AvtEbnnFVOk6RqRZxuXb35SRHdzaRMMQivp8To+EmqqemSOhM+y1GT5kMhKkyILmEyRuGsqXIOJg1MPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55ez2DJ+tRbtrtQWsUXxyIkuCi6wKAuo65NBPLRcYqQ=;
 b=uQOqzQcIHtUvAEBoJ0vwoaH/SNF8nkTg+D2ndkmCq3uZjNIC1rcegeGYNAa3IiYsB+WzxHmtgtprTXuMmzaK8GptXgmwadMYIGkEOgHfdPFK41xRCQdi39UAsSgkU74belFhIS+zTtLHB6FxzS/1jIEGt2Ba4n1ChE68dZnvSIg=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by LV8PR18MB5711.namprd18.prod.outlook.com (2603:10b6:408:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:02:03 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 12:02:03 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH net-next v3 11/12] net: atlantic: add
 AQC113 TX timestamp polling and PTP TX classification
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v3 11/12] net: atlantic: add
 AQC113 TX timestamp polling and PTP TX classification
Thread-Index: AQHc6GLJmDddWZgR/0mDyzRQjCUOdrYa1TUAgBBlMAA=
Date: Tue, 2 Jun 2026 12:02:03 +0000
Message-ID:
 <SA1PR18MB46002A08652C3B915C455744BA122@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260520141046.2151-12-sukhdeeps@marvell.com>
 <20260523012507.1823651-2-kuba@kernel.org>
In-Reply-To: <20260523012507.1823651-2-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|LV8PR18MB5711:EE_
x-ms-office365-filtering-correlation-id: 001ad547-9117-4bb1-69fa-08dec09ec2b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 zJf0vb23HYDDZLI9VNRA9FEPss+0qQbBFhDgLas+hQWvs8L6HKjlTeVbr3M4EHHtI0eC3pD+i9BcfakeKN50ioUCHGkXjFCsbaSQtdwPRTvBveb5XKpnZItswe1DNBr1fM5WfslTqYsVBtXohXz0IQ6SEj8asOZNhArDiWA/fbJ69guIGADkAH0efV9I/sB8eDPVpPPk9dH5I7nV7VeJ5mumNSvsLaqDTaNe31X/Hxs6r9xty53UnN1AxQHQw3sRT3MXW6iGL1UUxuKNBJyov8GQFTMFrLUjsN7qdTL/toan9daFil18mbxWhL30dQ1soCmfKZIW/VU1VYnWX36RbaGYQXo4qXfWUCCMKEOFfV+hTW4yqIhB7jG/N9BMLcFx8L/amr0z9mvtS/jpFdntxjNyymS6IGgFXevpuWzgcREu1M4nvlDiXx0XzxcvtA1T49BIZ5QA/3e64VB0wfD57umhUFg2j1bHOKZbRR9Rb2mMM3sDygsRL7UK3Eyx7gkz8R5a1hbjjcX+inpfG/h74mPyQG/yRfIMWVQWipDA5tR03Nb0lhqxdRYYjUte5VxTuetajnwGTPo123QdccEWH2dKVDo1Vqq+ni5MSBso0aDgFZaof7iFYOvS8lONiODlqqy5g+MBK+b7H5gpLy27GJtQccRn2TgPUwrES8JDOm3wR3yWEcUJohENcmm+v762EqwV2++14Lv1sRB1LdXcIF6dVFvy7H8Jp3wRe4MnrH4hMugDGavvMhTsSZURDp0a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/YAgShiTQn/c4p1T/562wsEAJSHscp2GQjRtg6a0nWOUO5r3W4zIomUQu3bu?=
 =?us-ascii?Q?bPuBZd2DxPqN2NmuhYOdC41VuZgb2evAAhR3x/0pXCH5+fdfSM0GnaaClQ+V?=
 =?us-ascii?Q?oifKCXsRBOSIdlm3/xprh2AKkljS/X5zsB0b5WQF3QEl39CF8DsU70i5Rmp7?=
 =?us-ascii?Q?P8W7pCHIqErgUeRHSDTvmr209cjLFJe2VeDw/5tVzUZq+YXfyndJ526zFuIe?=
 =?us-ascii?Q?4LptOIsE/5okxLI+t0eIHXTzxNEt6nRI+w+3+Dgh4PH2Qa98EnvDfMKyIm6O?=
 =?us-ascii?Q?EN2zIpwKB5ms5WUhIL9zYY6CoutqeBaQHEZ54UoG8Iu4wWd+7YNDeatBMWkM?=
 =?us-ascii?Q?IHKaN0VMxQgWwksDaDCtwoj9Qd3Nr4dZqfSQXeeSZwKkfbOvCvchaXXeW2Ed?=
 =?us-ascii?Q?NwAYiC+FXMdXarDwqbOg+TyBElBCTsqAl7JFESH7g+1RkH53yhTQ1qWCe6D/?=
 =?us-ascii?Q?1iJVGZpG0Bjn2lT7ice7nrg3jYI0EvoE4CTROo4GhSMRXa0g6UgvZOpsoawL?=
 =?us-ascii?Q?2qTLr0Ai8+QPf0C5po353AdWM6MzDAzylraur1Bns9wByHv2n8fbJ3YUGzLr?=
 =?us-ascii?Q?Ll3y4xpN1mPLIzeF88qu8PL3TLyUqT5wCgDuHv3HeoyR7HdxQ/o5Q70obfzk?=
 =?us-ascii?Q?8iULaH7yP7yIMFHJZpSTw4Isr8siY15RIXYDb77gp/qhY0wtNLTJLlXflGlD?=
 =?us-ascii?Q?6XJPJlSatGaoxMzOXGk4UqCiaAtPHynoVH137GDgfyQyvmrAHdFjvu+AsmNA?=
 =?us-ascii?Q?K6hG/TEtfE0KkAUlfZFsLfJKfvxsHZUxY1n60+UEHi/yiNWQjF6hiH2lfyjn?=
 =?us-ascii?Q?ax+Z0XTQDrAYZFgrSjsCf5qsY7DOzExvVul8l4C87ujFQtde3vCgRPc9kumd?=
 =?us-ascii?Q?RfJgqR/Zb6YIE55H2UzFIT5QRf00DzC3m2d3YhwdW2v51sgJoo4zRL/uW2Gx?=
 =?us-ascii?Q?vFxqBRlOZllGTDjEvoZWkwGok17R+nhTcSPLEiqGNK7oaAqAo5D7ZSeVedTN?=
 =?us-ascii?Q?Li1qg3UNLSTz8MbL6cVmYugjkTEyscdVBq/9xO/YaX2LH46ENzmEbDVTUgrd?=
 =?us-ascii?Q?4w66XKetqH7ZGqFZmFkozfxwxSt9CtbcZwzElZb3nSIDFX5idW69prleSc40?=
 =?us-ascii?Q?rc6rZnU02tWoBU0SVUhWHfPqebzPFjpf/i5Ry4DzHpqGDVlWEqywzRLCcJCr?=
 =?us-ascii?Q?o7H2gqCupITaxYY4RZpD+KycAtmpH+NlfMAMyIAhcz6J3MC2rvneWVsKJLmC?=
 =?us-ascii?Q?VXaZU7uEtddixfsVanX+N7AVe8/wU2ENZPvFVxVnnjUycEWDcj9szymsN7ww?=
 =?us-ascii?Q?DvbzscQBA0CdmghgGQdbFhlO6JbCU7MIsFjtljyj/8env3/LLL8/fYGIeq0D?=
 =?us-ascii?Q?nfsylHYLmuvvoKly6Onqq8AbEMsgHdLZo83/75MFbUDiDWK1r6ahSU5/cWpO?=
 =?us-ascii?Q?oAWN7gAmHfx0/rswOJBsmEK9pA5M+oZCnNpYIimBeZoqQ6kZn1qVkWEFsU7X?=
 =?us-ascii?Q?C6SLHI9CdVVCNLROfWZPoFbvX0pmLLK+uDfIpzDD0ThcMvAJa0MB2vjH/LyR?=
 =?us-ascii?Q?u2kNtqNvnSutjftszZ59IWqVSxRTMoJL4mjOFur9nUefA8+HpBzFBnyR7Dse?=
 =?us-ascii?Q?Oh+t5SzXSJeHLDLTz45ZuwBvBj6rQ5ApUNyv2hfJZmchTRUQjw717M4ntJ0W?=
 =?us-ascii?Q?2ng8W3SjBo20//DEc3rA9rxYkl9GJnUULJHD3g4EnbSKQDwb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GyOOin22qIaqv/tWejB92voRMBibGRnEIAagGugD68l2PlwvNSUuiE1V/ClX4lgngJX0ETzmuQko9ZMvR0ID96dFt5i9O3XWltnaZ3YsSFyB6aC8nUlxFMkZyvGl0SixZt2qhvJam5TzoP3Qf8UG7S9H8OVi5Sg3smkStnIL6fNq7vN+6qeIWeR9geZ6fjN+PxGWNTcmT1gDprpHOGEhrpBVpbR9P5MCdBQ5v6RWCpQAfXqnzMsbx+CyYjvEVXBwNMv6YDwsJ+oZWcHRWX4Vkz8pxqTpwmGIcBh422yciCEkIL7IpsAyIaXVq8WlE9mMITRdDUGTRevzzyDz+WEy4Q==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ad547-9117-4bb1-69fa-08dec09ec2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:02:03.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOtshoj/F9BWQqL8XKTGBy0HeOhoFg5MlMiIdozd3srZjeUmiwcGePQxp91zH1ty32V/qZqcJ6p0MINBjDWBaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5711
X-Authority-Analysis: v=2.4 cv=GaInWwXL c=1 sm=1 tr=0 ts=6a1ec640 cx=c_pps
 a=D7hViFZnkHkNtnby+5Sw9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=jCny10SMBwHXEXDXiBsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: dMbC_WQOuoIks2rikEfW7EXdoxM-Aeac
X-Proofpoint-GUID: dMbC_WQOuoIks2rikEfW7EXdoxM-Aeac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNCBTYWx0ZWRfX72SBn6sB/qnk
 8UwQxGboCIrVh3IE12UN/kcWzGQ2pcfTWTmXM/wPlACFghWGA0xz1RR6HwMnawlF5oGLpLY2gkM
 Sr3aBCN3+SvceZB2jQyzujk2caWTgQSf8hlZ+H4m8/RTJHfisPxrpOZrImhTNnWlPYh9cjGt++Y
 CU2zVopriFaXqF8iwAiNAIjHl63Dl59mlPFx+yKMNFMC53aQm26IQCEJP8qU/fUGSHC5shqi4Y8
 iGXZTEBg2jmSvcmQqh8C+sY9XxDcQlLdnCkbBDbYXNDBzndHt+Yu4pnFlUD0R7YonXbLdwS0XS2
 xjSNksDtod9Su0+mB1felvCJKk95Me8qjWmwbeXIwqL7yBGeJC2mKOlXYzZBO0Iq3OEIbqrXdcZ
 DNjJImLLg0o6ZhY2UYWw1PpHr32vgp0tYxH/fz5T5NJuoAukwrVedsuoOKOX65miL6dXt9322f0
 3w4UlVHNevWzJdPDoAg==
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
	TAGGED_FROM(0.00)[bounces-294176-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR18MB4600.namprd18.prod.outlook.com:mid,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:dkim];
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
X-Rspamd-Queue-Id: 77AEB62DDD5

On 22nd May 2026, Jakub Kicinski wrote:

> net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
>
> This commit adds PTP TX classification for IPv4 and IPv6 packets. It also
> introduces a polling mechanism for hardware TX timestamps in the driver's
> ring cleanup path.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_main.c
> index 4ef4fe64b8ac1..1da14786fe5cc 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
[ ... ]
> @@ -68,14 +70,6 @@ int aq_ndev_open(struct net_device *ndev)
>  	if (err < 0)
>  		goto err_exit;
> =20
> -	err =3D aq_reapply_rxnfc_all_rules(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
> -	err =3D aq_filters_vlans_update(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
>
> [Severity: High]
> The commit message mentions removing a stale PTP call, but doesn't this
> remove the restoration of RX flow rules and VLAN filters when the device =
is
> brought up? It doesn't look like these were moved to aq_nic_start().

Both aq_reapply_rxnfc_all_rules() and aq_filters_vlans_update() will be
moved to aq_nic_start() (called by aq_ndev_open()), where they already
appear. The removal from aq_ndev_open() eliminates the duplicate
calls, not the calls themselves.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd8..87d680590ef2f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> [ ... ]
> @@ -311,6 +311,26 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  		if (likely(!buff->is_eop))
>  			goto out;
> =20
> +		if (unlikely(buff->request_ts) &&
> +		    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
> +			u64 ts =3D self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
> +
> +			if (!ts) {
> +				if (time_after(jiffies,
> +					       self->ptp_ts_deadline)) {
>
> [Severity: High]
> Where is self->ptp_ts_deadline initialized?
>
> If it is never initialized and defaults to 0, will this condition always
> evaluate to true on the very first poll since jiffies is typically greate=
r
> than 0, causing all PTP packets to immediately time out and be dropped?

ptp_ts_deadline is declared in patch 11 and initialized to jiffies + HZ in
patch 12, in the same hunk that sets request_ts =3D 1U. Across the applied
series there is no window where request_ts=3D1 with ptp_ts_deadline uniniti=
alized.
The field's zero-initialized default is never observed since ptp_ts_deadlin=
e is
only read when request_ts is true.

> +					/* Timeout: free skb, unblock ring */
> +					buff->request_ts =3D 0;
> +					dev_kfree_skb_any(buff->skb);
> +					buff->skb =3D NULL;
>
> [Severity: High]
> If a timeout occurs, buff->skb is freed and set to NULL, but there is no
> break or continue here. Doesn't execution then fall through to calling
> aq_ptp_tx_hwtstamp() while the SKB is already freed, leading to a
> use-after-free when the PTP logic attempts to access the SKB to report
> the timeout?
>
> Additionally, since buff->skb is now NULL, won't this skip the subsequent
> transmission statistics update block?

Both concerns are valid and will be addressed in the code. A goto out is ad=
ded immediately
after buff->skb =3D NULL on the timeout path, so execution never falls thro=
ugh to aq_ptp_tx_hwtstamp().
The stats update block below is also protected by if (buff->skb), so a NULL=
 skb there is safe regardless.
The timeout path now correctly skips both the timestamp reporting and the s=
tats update.

> +				} else {
> +					buff->is_mapped =3D 0;
> +					buff->pa =3D 0U;
> +					break;
> +				}
> +			}
> +
> +			aq_ptp_tx_hwtstamp(self->aq_nic, ts);
> +		}

