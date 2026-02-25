Return-Path: <netdev+bounces-261025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PaVIEYln2mPZAQAu9opvQ
	(envelope-from <netdev+bounces-261025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:37:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B819AC47
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C953330F3A92
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B23D647A;
	Wed, 25 Feb 2026 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VKyRtSkl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EB3D904B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037195; cv=fail; b=j5xurOnGyvIGuDqCNjiVwFuWm1RsVqdEl3eMEUCvZAaw6YxC+OXsDu7zmp0h/HFFY8W4itvhaaCSDwO4S8WVBrQolQlGvQ0uxUuX+21eXM+e6wlOu91dc8BVoZg3pCAEP5ez3OBAfN6C8q42pvaxAK1gnnSgqjUWkjaHQ1FodIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037195; c=relaxed/simple;
	bh=tC5zd+NkYKTMCUX+Ykqzt/QD1ByD4EL/LSMNnhFFOBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DoiL4pFceiBGDSJIHGN8iubzmdLWbh3TBKuhKU8Eu/HzJ2Ple0NvK5yXuyqdhOzQhhhUilOq7AwxydSGDLeE/neL4mygoQzDzutmf81MbSiwKkOP7kjrE7T6DNaAYLmw5pMSDMpnE6WGX3u4qHBDEoH0Mb2RSRt3hNQ53Ilcjfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VKyRtSkl; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PGTs7x3039280;
	Wed, 25 Feb 2026 08:32:34 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022098.outbound.protection.outlook.com [52.101.48.98])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chmmna81j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 08:32:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyLHwuDaKQcCNnGCiDuqeOOdp3/jfN+EHalmHcEX9pVBlcMRlkH/ocTg2jhp7bXNf/PYwTerxCEPzkD9VnIzp1yZuCC7D63IVFsth2iq6Uej6c4l4J6/+r/aJt6XW4+4240xA0PI5e8S9s6BorMhYQ++KjgyPzUVn+6OuTGrbqM2r1tWhkZgvdjSaN0zlNjeIIxM23YoElZmijyMDAt2Q/AUP80tsb/hK6jxBh3pFrBV5+thGZzLLQnanTd7VNyngvBz3zwFDoNWbeNBaP12oAYnLCJxK26o7/hdD4+pQI5DcALaevgf1hheQAF9tRhdcGpQSeVHC3za9Zp5MfF54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN60iuRs/0i8F+dBe/wB0W6v/pv4snRXUuR4wHg5tdw=;
 b=MayqgPx3INaqYQjqWeytYrNeIz9RXhkMyxOFdMnYaI2T+YSNIU5AMgUmqdawYDWc5C4/g/YZs/j1O4KnK/S7XiOM0THnyk8UZHwCmB0BrrA9Re55xixv5Vgpc5s48/kl/rZpyzdOQ6xUuU762stLBJ3ZEfaXJsH87hI2ULDMNWumxNMsf9WuQBn+e1oRN/VT1gT8eeYn7mbWAna9ArpyqdnNZwytWWkuWf9VAhnZXRSxnkXoJJyWU5i9pEdzlKQh7zEOwy1GqdUn+P3mXwWDVSsKtFwWp5/OogocuxZVhbBny3LJDX7FaN9/3qga8nxJf47qDfAuHX2juLMp53FqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN60iuRs/0i8F+dBe/wB0W6v/pv4snRXUuR4wHg5tdw=;
 b=VKyRtSklhuuNXOIXL8agFdBUTTHhZU8bUA7yz1J1mPhJK3CuFJDcgubiHrzzgXyFaNubBVpl2i/pXoihEuflr7rQD0Sac1EvyNcKxzk+n1Pytl9y/EV5P0S9QS8xUfW2B+/9QPnJVnOfjof8GSdg6NZjSOvGC3Xkay1/Upu6UF0=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by SJ0PR18MB4512.namprd18.prod.outlook.com (2603:10b6:a03:3ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 16:32:29 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 16:32:29 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Maciek Machnikowski <maciek@machnikowski.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "milena.olech@intel.com"
	<milena.olech@intel.com>,
        "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
Thread-Topic: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
Thread-Index: AQHcpnRVYPxeWX4kv0GxqoALlQ5+uA==
Date: Wed, 25 Feb 2026 16:32:28 +0000
Message-ID:
 <BYAPR18MB3735A66C2DBE753E332E865DA075A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-3-maciek@machnikowski.net>
In-Reply-To: <20260225153858.29486-3-maciek@machnikowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|SJ0PR18MB4512:EE_
x-ms-office365-filtering-correlation-id: 510ec13a-f2e7-494f-7f6f-08de748b77b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 F73YWdO4giMZR85w7WSVxhmXw4yWhm0SCyBiDBglA7iqgahfQGh2wjh/p8BPtoAvQ3iewqFxY0YHqbMYNxWHrt2KcyopCSrF0SDAriJFIfGoNpwrsdXOFv+f5XTEfPY/QQfCjUGt7m7mKtLCk0MN3cj62L3tzcc9xyWMXCR0usSWw1seV8PuJAOUkjNMv279f6cQU7BBl5yORxi2khS+81oUUyAJHpUzOrpCuXQ3TFyMvC+wa12lCu2poZ/yZI1Epxs1/o1PFTIxsbQ6TjPy3vVO1ZIC9WNp5lLGtPWhfLdSSeQihWEdeEDKIJKwtdtAKCJJPgRmQqhKXoUY7PvrmHcn6VSN/o23nIJh/lU09AlPF8UTR2RK47K8IiOFaFOZIdUzKwGbRIB4dRSvqJQRZkorkUgeZ3YtgnvF6occ1TkQitvcaVpS3NRixkgGBVSGBEA9KNfDprUKsf6SP/EqdJSMd91yUkgWJcWIwFCZNcHDouL9r4zH7voYCPtpJN8iS5bEAA2AlUut0UbU4p6GIMLH9mxZ9cVRdmDj3Hqp6HTxgGES4eBwKXC/Va0A5wVrMYwJ8vuk37pfgDs0tappZA7C+trg2UmGv8xJasyLXAnbj3tkwvCVOwgaEzPYUy4S1Ow8td+gi1sfNGds9/qK82NR20Xne5tgHFKimDxP0yPNB1ep+U59BxnzU0Dx4XhhoWHMTX4eUuKo1e9AoiBJJAfDpCOmx/kKWnYFykUU1pWRbPfO4oSX/G31M7qF8uo4flsjOC86RXMOU5/c/bY5JyIWmO14ao4P+fQknMa7yRI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qvTQG44CSDsUjo+f4WFBnSxsCIcUaVdsft5ond9Um/v/InDl/yo8r/WRAx3N?=
 =?us-ascii?Q?QN3bcrcbrAm2lK7Xt36jO612F7H+f932gh6Tk5BuVg3AMY/TYu3BceJ1EE58?=
 =?us-ascii?Q?4+YfYxdW5vuQE9jdCkCq1/pJEVPpKhcuJAu1sA8SvfsE6XguPJSItm2igN2O?=
 =?us-ascii?Q?lPTjS3/PXaViQiMUTSVx/1tw8hdHYzTq0Bbz+xR4YOaInLi+XeElWK7Dp5mO?=
 =?us-ascii?Q?rLw2sKY+YAgU2lVABxj1EdoAqqO0NaN+PAS/TPsViml3Dn9PqExeHn+inkwL?=
 =?us-ascii?Q?L8HIbxquHe0vsA/sL657O0b0v/k1wF4oRoseDUIBAg08dmrZsYP8Xyq204k1?=
 =?us-ascii?Q?u3sliTA9P8kBOGUlWo4Y/RPxdNRB2/9Pue39Oo6XgxFjYclx/Hm0LlIfHMTZ?=
 =?us-ascii?Q?ctNC5pwTbOqUK6ehBXJwQdKSXlBCxFT8/JmPXC15oDPKkRvCV1zd9GlX0/2v?=
 =?us-ascii?Q?wpRK57FPu5U7bYmRrEFu80M+oSUbfyzccrYTy9Rw89kfNXjRtY8dDTZRAU8+?=
 =?us-ascii?Q?8Wax7RTsZGDk7pcE3gY7fMCd/nSqYPgiaWJmTqtDYP2EsylDcQwv7byPTE9s?=
 =?us-ascii?Q?IsT1g2xY2HPbXGRnp9tN4jl0c71Fm0tsKYnVfWUXTIF+29tSuh1A53//CVlO?=
 =?us-ascii?Q?O5z7Rqro6StQ01qSFyNiAB4rZySU30HliTxW1BVUjd04RHMKhZVvSkkKzpl1?=
 =?us-ascii?Q?4St099b8gH/xYOOlGEwNUxKTol/hfpVOtZoiYDbSnrjC6V8v+IhVHMWMLzb1?=
 =?us-ascii?Q?/FdrGiJYpCQjqPD7Z3iEMUiVJLvDIUFyEM0W9snnz9veXSGadQpl+7Ka3pxn?=
 =?us-ascii?Q?Pxw/RPUXgH2ztLccxkhdpqUGniaglsfRRjZcJEyuy30m2t1/+E4B5qatMpA1?=
 =?us-ascii?Q?nICczDUM/KEEwzIj3bO4LdU5m4h9JNhGoQMivHMi20Ia5SilPiafG3abCZV/?=
 =?us-ascii?Q?1uSj1+0atXOn4ontpXBKdf+eagJJNyJJzLt+RdRsxNUdxL5enw9GPSt3elp3?=
 =?us-ascii?Q?EJPp1FjbvfEKuSDEUI+TeJ1CgTnx9TzSaiIzSm8BnI86LQoZX9SfWanABY9l?=
 =?us-ascii?Q?ld0B63C/oKZfHLRLdGt7jclM6LE8yGIelU5viYajqHAjPuTQ30ebyfCiSso/?=
 =?us-ascii?Q?81mvvdy9VghXtHI2prD6QN5k2TTTuFHonqzC0JyckNW3PDCBZvy19t8lyK9z?=
 =?us-ascii?Q?ULgFl094P3vrAhy6golm98DlZ1xBMNPD6H1izC/siHcF4N192hsIAZXOAl8W?=
 =?us-ascii?Q?BYPCNYaCnjqlL11b2uETU9M1U8aQh6l565qHkDqq8/jqf0HGJggcYIbux/G0?=
 =?us-ascii?Q?/9hX+4WaAmdVkKN97LAbQrVdLt1vw3dgldNCyp0Iez6HJv03PKfDevXcCtRW?=
 =?us-ascii?Q?qpLpYyGLXBm6+PeB/HsWUUGQTdaXp9d57yUOQB89WW0FDqGqiPP3G4JU/Ude?=
 =?us-ascii?Q?IsePnkZYuA4so80LXEvXuplWBwJAgtAo8FMmDi+6jYEJ0q4V+Q4gpQW1CoZD?=
 =?us-ascii?Q?FX4TY3Fekr7mLG5j9Y4V/3duxZVPXj4eWxEzgVSMTaROtc24byOfQh9gL2Vu?=
 =?us-ascii?Q?Xp/css4/bQAytYLUriHngpOosFcu5GBBj9MTY3OTLw0CzjhMF3YFOOzSa5nv?=
 =?us-ascii?Q?tZAdxrgjbuT7Vh5MHbxMIYS1aqwH7vsYhv7USISxsE/jarF8fHwRMcDZKWAH?=
 =?us-ascii?Q?H9pjas3/en+RD8QW9tiL9269CaaFKdXsY44/GFfjgfIZkfczrOmfdMX3UdA5?=
 =?us-ascii?Q?ApL4lfcBIA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ec13a-f2e7-494f-7f6f-08de748b77b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 16:32:29.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+nIWmEzYUJIGNIA2JjxYP2lPxMEZ6beXJ2lgJpet8Rm2eEDa6/RnXuCROmQr6tGTsSLy1xQ8J3ztLU2wh7PQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4512
X-Authority-Analysis: v=2.4 cv=KrJAGGWN c=1 sm=1 tr=0 ts=699f2421 cx=c_pps
 a=JnPQUT+nmGgr9A6OKrSlWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=6gHIKlzYAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8
 a=yUa1Dcc-lVl861-skqgA:9 a=CjuIK1q_8ugA:10 a=IZuCIVfSzXAHSwQMVxNu:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ayAIAV2AICBrkGIaUAYbIDpUA3OPxY5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1OCBTYWx0ZWRfX/NeH5H0r26Ij
 cU0QwiJPCJHc1AW+qiKkgBk1mbYH723gXm8U/5rw0JbvUWfyMxS0ulLu2LFusNZEiMs+fC4pWnW
 wTuW1GeaIz75pEL1Mff81yQJMsBjFxRDasrG8BXzgnj4EJTGVTcZ4cEmke+y/0+lhakrzDEfv0A
 spkZF2sq728M6EkhsClqetmzEycRc5ZqJCg9u0pxk0JSvXhtMkifiFkbTgF33ONd1LsxLJzSk4K
 PIh62ulvSDs4In4lyVeSrdHar29cpaopesCoX8yCWTl86mRZj5naJspPRFN3Q05GIk/2rv8BB7W
 un7n6arII+CGABcc1yFhFW+A99SGv9s3sbYG95F3N6IMkThl2xM8OPVZrnSVbBVTxFVWIWnOhXC
 qKSw3j2zeAAawSV1ZTbGWC+E6WULzUvZc3xdaIoyL3CG7ghg1yKq5V52vYzZIRHOiMtohoqpITy
 eRztV/Du2N0vu8c/UiA==
X-Proofpoint-ORIG-GUID: ayAIAV2AICBrkGIaUAYbIDpUA3OPxY5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261025-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,marvell.com:email,marvell.com:dkim,intel.com:email,BYAPR18MB3735.namprd18.prod.outlook.com:mid,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saikrishnag@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BB1B819AC47
X-Rspamd-Action: no action

> -----Original Message-----
> From: Maciek Machnikowski <maciek@machnikowski.net>
> Sent: Wednesday, February 25, 2026 9:09 PM
> To: netdev@vger.kernel.org
> Cc: kuba@kernel.org; maciek@machnikowski.net;
> richardcochran@gmail.com; milena.olech@intel.com;
> willemdebruijn.kernel@gmail.com; andrew@lunn.ch;
> vadim.fedorenko@linux.dev; horms@kernel.org
> Subject: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp
> support
>=20
> Add support for virtual timestamping inside the netdevsim driver. The
> implementation uses two attached ptp_mock clocks, reads the timestamps of
> the ones attached either to the netdevsim or its peer and returns timesta=
mps
> using standard timestamps=20
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the
> timestamps of the ones attached either to the netdevsim or its peer and
> returns timestamps using standard timestamps APIs.
>=20
> This implementation enables running ptp4l on netdevsim adapters and
> introduces a new ptp selftest.
>=20
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  drivers/net/netdevsim/ethtool.c   | 11 ++++
>  drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  3 files changed, 102 insertions(+)
>=20
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/etht=
ool.c
> index 36a201533..5b709033c 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -200,7 +200,18 @@ static int nsim_get_ts_info(struct net_device *dev, =
 {
>  	struct netdevsim *ns =3D netdev_priv(dev);
>=20
> +	ethtool_op_get_ts_info(dev, info);
> +
>  	info->phc_index =3D mock_phc_index(ns->phc);
> +	if (info->phc_index < 0)
> +		return 0;
> +
> +	info->so_timestamping |=3D SOF_TIMESTAMPING_TX_HARDWARE |
> +				 SOF_TIMESTAMPING_RX_HARDWARE |
> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	info->tx_types =3D BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +	info->rx_filters =3D BIT(HWTSTAMP_FILTER_NONE) |
> +BIT(HWTSTAMP_FILTER_ALL);
>=20
>  	return 0;
>  }
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 6285fbefe..b1161c1ca 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -30,6 +30,8 @@
>  #include <net/rtnetlink.h>
>  #include <net/udp_tunnel.h>
>  #include <net/busy_poll.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/timecounter.h>
>=20
>  #include "netdevsim.h"
>=20
> @@ -119,12 +121,17 @@ static int nsim_forward_skb(struct net_device
> *tx_dev,
>=20
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_devic=
e
> *dev)  {
> +	struct skb_shared_hwtstamps shhwtstamps =3D {};
>  	struct netdevsim *ns =3D netdev_priv(dev);
> +	struct ptp_clock_info *ptp_info;
> +	struct timespec64 tx_ts, rx_ts;
> +	struct sk_buff *skb_orig =3D skb;
>  	struct skb_ext *psp_ext =3D NULL;
>  	struct net_device *peer_dev;
>  	unsigned int len =3D skb->len;
>  	struct netdevsim *peer_ns;
>  	struct netdev_config *cfg;
> +	bool gen_tx_tstamp =3D false;
>  	struct nsim_rq *rq;
>  	int rxq;
>  	int dr;
> @@ -161,6 +168,27 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>  		skb_linearize(skb);
>=20
>  	skb_tx_timestamp(skb);
> +	gen_tx_tstamp =3D skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
> +	if (gen_tx_tstamp) {
> +		ptp_info =3D mock_phc_get_ptp_info(ns->phc);
> +
> +		/* Create a copy of tx skb to keep the tx reference */
> +		skb_orig =3D skb;
> +		skb =3D skb_copy(skb_orig, GFP_ATOMIC);
Minor nit, check for failure condition.
skb =3D skb_copy(skb_orig, GFP_ATOMIC);
if (!skb) {
    dev_kfree_skb_any(skb_orig);
    ...
    return NETDEV_TX_OK;
}
> +		skb_shinfo(skb_orig)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +
> +		/* Timestamp as late as possible */
> +		if (ptp_info)
> +			ptp_info->gettime64(ptp_info, &tx_ts);
> +	}
> +
> +	/* Generate Rx tstamp based on the peer clock */
> +	ptp_info =3D mock_phc_get_ptp_info(peer_ns->phc);
> +	if (ptp_info) {
> +		ptp_info->gettime64(ptp_info, &rx_ts);
> +		skb_hwtstamps(skb)->hwtstamp =3D
> timespec64_to_ktime(rx_ts);
> +	}
> +
>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) =3D=3D NET_RX_DROP))
>  		goto out_drop_cnt;
> @@ -168,6 +196,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>  	if (!hrtimer_active(&rq->napi_timer))
>  		hrtimer_start(&rq->napi_timer, us_to_ktime(5),
> HRTIMER_MODE_REL);
>=20
> +	/* only timestamp the outbound packet if user requested it */
> +	if (gen_tx_tstamp) {
> +		shhwtstamps.hwtstamp =3D timespec64_to_ktime(tx_ts);
> +		skb_tstamp_tx(skb_orig, &shhwtstamps);
> +		dev_kfree_skb_any(skb_orig);
> +	}
> +
>  	rcu_read_unlock();
>  	dev_dstats_tx_add(dev, len);
>  	return NETDEV_TX_OK;
> @@ -182,6 +217,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>=20
> +static int nsim_set_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack) {
> +	struct netdevsim *ns =3D netdev_priv(netdev);
> +
> +	if (!ns->phc)
> +		return -EOPNOTSUPP;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		ns->tstamp_config.tx_type =3D HWTSTAMP_TX_OFF;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		ns->tstamp_config.tx_type =3D HWTSTAMP_TX_ON;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		ns->tstamp_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +	case HWTSTAMP_FILTER_ALL:
> +		ns->tstamp_config.rx_filter =3D HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nsim_get_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config) {
> +	struct netdevsim *ns =3D netdev_priv(netdev);
> +
> +	*config =3D ns->tstamp_config;
> +	return 0;
> +}
> +
>  static void nsim_set_rx_mode(struct net_device *dev)  {  } @@ -660,6 +74=
8,8
> @@ static const struct net_device_ops nsim_netdev_ops =3D {
>  	.ndo_open		=3D nsim_open,
>  	.ndo_stop		=3D nsim_stop,
>  	.net_shaper_ops		=3D &nsim_shaper_ops,
> +	.ndo_hwtstamp_get	=3D nsim_get_ts_config,
> +	.ndo_hwtstamp_set	=3D nsim_set_ts_config,
>  };
>=20
>  static const struct net_device_ops nsim_vf_netdev_ops =3D { diff --git
> a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index f767fc8a7..6d3e8700c 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -103,6 +103,7 @@ struct netdevsim {
>  	struct net_device *netdev;
>  	struct nsim_dev *nsim_dev;
>  	struct nsim_dev_port *nsim_dev_port;
> +	struct kernel_hwtstamp_config tstamp_config;
>  	struct mock_phc *phc;
>  	struct nsim_rq **rq;
>=20
> --
> 2.53.0
>=20
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

