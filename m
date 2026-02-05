Return-Path: <netdev+bounces-257113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIosIO51hGkM3AMAu9opvQ
	(envelope-from <netdev+bounces-257113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:50:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DDBF1764
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 123E53008508
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08515396D38;
	Thu,  5 Feb 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="BJT7HtN7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BC3A7833
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288614; cv=fail; b=C3zQUfgLASS0xrW6XEt6w7xC3IAX+W+eK5q0IBFWFl7ih8XugQfIdaLP9Cb7U8xaQwH5ANzOy96EksZIHo4mj8sBkjWuRViTfc6vjiATE9t3DJwGYDWtfV0kX7zUPCL3i93pXn0+Dr2CuR46zPBo2UtRWzZhXIaFkCzJim11n3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288614; c=relaxed/simple;
	bh=17wh6C9nNk8bGq5aAkC3h6PyA6ZiGeGQcjoHkgvXNe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vibe9FH4JUU89Bje3B2Enjq3fceFifcdcjATqTsq2YjG49em5rKYaCiBhiRvxuLnWcm6qMOTmPx9zraqiug/HxcxlZWNkiCvKdnWE0tVrZnuxXWTGepL8C2OwurddwQw6WCSxNJrqBlouXPBDZST6yBAE8BFSIc67WHzSQL3imc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=BJT7HtN7; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614MDxK83893352;
	Thu, 5 Feb 2026 02:49:53 -0800
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022075.outbound.protection.outlook.com [52.101.43.75])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c4eqf1g73-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 02:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYqkZq0TOKHL9dSP2TJQpb/wyBnDBy2pdTTLMkfZlB8bXsdzNGbTOeRz4VDTpuFJFNKqv2abKqpmx8Zw64iVJJWpAaIJI+Nz55wIiFJwcx1Ax5NmOmMdznkGy9rIZgVfjRxP6J4ryipcQgw/deViBXhXYITs5SGPAbmiJussOu5YYBnXLdnWUWci3/o/SgnhBGdaRkbfFHOcKjlIk9xqIU62KPlt80aPCh9AGCFZ/LZSUL5ksVs9yzMHIELGuv/cdr/TNR32QxLmyExm88LqME2RBfQIfa2EGlcm5GkypmcQB6bQLx/ts6SQ9g0HEoxlCg9xQFbiQbg2n2PHzQm0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EDkSziDgY1KjYJ2T/E9RigwtYPNNHEfwmdCMRki3PY=;
 b=PiJK3+332HwLlvSi5I5H2NGlXq/X96X8/1aCZEslqNY4kLrfBeWkMbNBC0ZI2/jyTsopCkn8gk39QQxDP24dDUjxIMSaWPRuIudR44SR1ua8CXPRqpQTwLBA3fOPQgAUt7sjz2q/sscEzNL2xYXjYjIUE/qFlksq8aVayx1bWfMlEHD4KDyWxqqCJt7SCgXaP+Wk2qpriEV4Sqc3VGUneQ3uAqOEGn42EA9SAaOYrFahSGO8uwhl7xB0Ffa+na7UNjcBmLXa81yDPwVyDO89Jy3riz24oPvJtOffORP/QqWCGNSU7qqXsSphGocTErT1gbVbtkpcNKxiWsgXTE+Q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EDkSziDgY1KjYJ2T/E9RigwtYPNNHEfwmdCMRki3PY=;
 b=BJT7HtN7fMTLrO3On+6LX6mLr2WzRLssv59ZcACmS9m1gSdwzVdWFDe9FO9b3vYUFTGVbKNAXgV6OWZnyRiaJ5v4j3+sQmWKMlVSktAp60G2DKjboKcf1C+0/r+DMD5y1WwgmW211FLscr6ZF4IaEgFAzZYwJlE2pY0JqIxK8sA=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by LV5PR18MB927633.namprd18.prod.outlook.com (2603:10b6:408:360::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 10:49:49 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 10:49:49 +0000
From: Elad Nachman <enachman@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>,
        "Taras Chornyi [C]"
	<tchornyi@marvell.com>,
        "Volodymyr Mytnyk [C]" <vmytnyk@marvell.com>,
        "Vadym
 Kochan [C]" <vkochan@marvell.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v2 net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
Thread-Topic: [EXTERNAL] [PATCH v2 net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
Thread-Index: AQHcloC1rfh6Zeqv5UO2/tWwk3SB27Vz7Nig
Date: Thu, 5 Feb 2026 10:49:49 +0000
Message-ID:
 <BN9PR18MB425184A7FABBF691E4C99DAFDB99A@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20260205091958.231413-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260205091958.231413-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|LV5PR18MB927633:EE_
x-ms-office365-filtering-correlation-id: 380f7de5-7820-4b64-f12c-08de64a448c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|921020|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X5joGHyHt21pzA99MrKaQchCAnr0V1H6HCxwnWLXTrFVNZx6stQRFMnRSImz?=
 =?us-ascii?Q?d6nrXAD66yB0u7r+JOuhrIRdmUWVx1Qtc6sE0XayRT8f0/jz1vQx6Ql7coeI?=
 =?us-ascii?Q?NI0ZfRQsnKnh0jECqLIVAbR3loAIfPQB7fuYn6HezYiNPLa4LOXzGTctf2DC?=
 =?us-ascii?Q?R/bsm2DvQcP/H6xTT0XA39qZ2plIjGwUKz4PajlQtu/74oIBN/PtVC45BWnS?=
 =?us-ascii?Q?jcbJbEIb+H7uZa+kSgrqftEUZmLQzX6K2fjSCzsZZ7e3dfrJFSZ5kzU766ih?=
 =?us-ascii?Q?2yU1krPZfCjWZXrwXV5mI/LSYbG5HH2IAlGb9aSY3sAblrYkVrCti4ISt5uV?=
 =?us-ascii?Q?5u5z+sqMmAoCZK6OfmPFG+FDaYqZtgjPRxsWd0HUobS01mvNAGm66xaIn62p?=
 =?us-ascii?Q?hUWlNR3IFAOPnNrhD6jSqvmG+7FZ0l7LNbwwnkfIdlup1dIUtu7rDaG/YnaY?=
 =?us-ascii?Q?37OPy4r7c4BEIAiWEwuWet0Cu7gghTH+CPz/wY+QiL1d/cT+OYaJKmTrRsku?=
 =?us-ascii?Q?XqPwpTLVGmvSd4tPqzXMOP8UR10eFJ8doyx9G268EZVFhFCkBqf80Y09VKFk?=
 =?us-ascii?Q?WHgal6nTdkuufw3hw8pOT2o/hyZCP8VpeR3rtjyUYNCAPpoJhb0jXa0PxNi2?=
 =?us-ascii?Q?U4WGRzegsbB8I6m96RgF8vVK18joUc2dRz1sFqkxOCSy5kX6PSdHEjzwvG+B?=
 =?us-ascii?Q?6rDenXy84VVerg2bfHfMFqC2ATnVVtCK+3Opa9nDKn9tBtrb6EgU64QNoRDm?=
 =?us-ascii?Q?ZJOiJc5u45xxOd2zBTw30stpiRwKTIi9cbgxfrFsSZjF5AW76mGWRzhfJWbM?=
 =?us-ascii?Q?SoOzc3L9eTacXkMOyrgw4VsxbVUD9EWyE870wtu4JqHL1BF1C12wtUq54y1E?=
 =?us-ascii?Q?SjsFVVSRHujRTh6ogpXRB0J/jI6R/XkRuYyqfzjGSihSz6DVqsbS73VGHPzo?=
 =?us-ascii?Q?MSlihH1Yj/oCfF+8yAFzoPN2pQgVVSsJrxmwU5KwwzCWSBxCpV0A2S6Vy9IC?=
 =?us-ascii?Q?j7qq8WPeH/W8r1cG6jTjyeEXGtbbSaRR2PrpHv2EECe0V0wyGkU66YmyOMcu?=
 =?us-ascii?Q?ea0Y4hjhnwKILk/f1DJDCxo0xC+b3pxmZOgycCePMvCG3WZaVsrahvT24rZT?=
 =?us-ascii?Q?vriYoDsgrE+P9t3TRdZUNpgQV/Ugk32kXXODtBywc9BRocLM8J3uu3EpYZEq?=
 =?us-ascii?Q?GtSjO0yjb6LSoBLEOyLu2gQtMPqXNXRGetAJqLj1lINX18YNaYmNUYYdcG1g?=
 =?us-ascii?Q?0tzSaFsXwqz70qwstRTPrwdYiadrqfqWlIkk8ALkYwRZNQEMVnM/+CwK59uM?=
 =?us-ascii?Q?OvMBjJOirXKYvpGyP/9yxXKKjWKmdyqTQWO3i28pQrOeI3DdE7MAdD6I6MTG?=
 =?us-ascii?Q?DjyBHDDIJF3ORdck0Xg9zSeu98xdMxSF2MsEP0EhVm6tU8c72vmSF+VgbQZ5?=
 =?us-ascii?Q?Nf+uIZ2FioRhgmiqh9XOMluphAcFC42GszeRD+YiuUqusenTyn/RvfwCyr3u?=
 =?us-ascii?Q?dRz0KDCgM863nc1v9aHi6hbMj7mfpvsD4cj/QOv7+7v3x6PPklABKQXCokY3?=
 =?us-ascii?Q?Fy8pj785MGgG5ncujQf61qNSu8ZKh86jgTD7v4PHHyKKtX4xfi3pjKntYzNC?=
 =?us-ascii?Q?aD0FYw7P0wiZ+jIgHhZOXfE08u0WBppL/2SqigxCxEMX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aDorZRRaFDDgUy8Gy6mcqngSFlOOQ3ZF8Pt9ikOvCb47KE94UJCnCBHgN/2U?=
 =?us-ascii?Q?IDv7HbkBnre/S6q9Mn3jLFEGqc1seHQQI/3wv9AUAlIRRaA8qPBUfB57zWKk?=
 =?us-ascii?Q?YCTaXzjejhzy6ua8fKiiEbPqK2R91y3Y6DOF2FJovMyE1WBaQPKb5Agvf3KU?=
 =?us-ascii?Q?hGl3f2TNtgFSNoam0nEMg1/RHvJ+PPXWG2+K2lO0VrX6DhyjBEkangc+kGQx?=
 =?us-ascii?Q?Gdzrft7BfS8D59Q2g8SOZgg9XKiUKy81qTC/xHhWPPPFc/I6jPG2L4f95/yZ?=
 =?us-ascii?Q?/Ca+npVq72tqpTtQzCNjBPw+tP9J8Tf0THz950nFTh1YJa/myCwKIbx11OjB?=
 =?us-ascii?Q?h5p8sR+SLIGVEihyj/4KCZG5wlzIqu1fbYJjq4/60mMoUlgxh5XsWXk6ctmv?=
 =?us-ascii?Q?hEP0xbPCRQlS3hIOrV4foAeeAih2Mc7Xu2tqbDfIbvuEFrzLwGDUOdrOnzat?=
 =?us-ascii?Q?YoeHmJQtRBlJkLNntVVbw9NDbSjIfnsL/0/w37okl1z98Vi9At0tfPHDSND/?=
 =?us-ascii?Q?Gdn84guyG8o87HCK8Q3TlU5qaDdQknmBgK1AjHnDyut+F4/cseBDxXHZdmsP?=
 =?us-ascii?Q?D+TP9G4q5xFecHwMVpypMVN1NnooP+XN9UO2cAhoZskf/7XLLmXuXA5qrDbv?=
 =?us-ascii?Q?/rViCEoh+GcphQCkTqCQ/xfAz9h63Zb91aLA/nOywcyN9vq+zVr0u9BdmSV9?=
 =?us-ascii?Q?6ZFa1Jo4RkFIL8HG7aQuljenPUGTWwI+fmZZi5dc0N32GPBwR2fgu7vKvSJ8?=
 =?us-ascii?Q?UoSJHE9LXbEc5tJn45e1igm4mkqpBBTLhzGI4eHckNBYYm9Axjb/dtYBsJeg?=
 =?us-ascii?Q?JlMFqXBZmK8AMO2NZh4nGc8ZkGg30roZmzLOK8wu09pXefbyn762yJHJiXpA?=
 =?us-ascii?Q?9hdKwGJCGrXMOJAwQ9dIUuhAjDreLJpeDowDfbFercTy7ih28Jz2vIDZte9n?=
 =?us-ascii?Q?ETfkyiZBq1DFiJqOgg1bGfKEbZuUlafRaWkdN8Bz9cLHxL/AVHhr/19vUkJ2?=
 =?us-ascii?Q?ab7UkTA7ZXz8AmC9gSZe0TYRjZ5v165g3gvTz4bMz0ynm2QeQ3+ZIj3VnyH5?=
 =?us-ascii?Q?A+5xpHMS2OPclSwqaLW4WPqT2VBo8NN+SZGodOJoRjHlZ1qPZX+MmktUtNvZ?=
 =?us-ascii?Q?cPgYFiA7fRLWZ22vS2EOti7EOamHKwhhrbCFEFCVplH+rpXUiGlTPeDeysbd?=
 =?us-ascii?Q?eM7Kqda2VcjtsZAvOmm7dZEb5RIYDaqXV5x2lt2dkNqial2kxQPf/z+VwzNj?=
 =?us-ascii?Q?tkNtwyu3o2AW8L9z9qAPVceQgGxUw2jFkjjg3fGPv/GDsyMPbXbd1+oJ6Tgi?=
 =?us-ascii?Q?jGe+YV6C/jxNn0A5jXkXOUjmexzSsEMdFiHlNWs16AQoKj5OdOmko6EV3zDk?=
 =?us-ascii?Q?5w46BvO3BjdEhQsth7wHEitDmJwEHdxT82csw2PzcI0vb7TszEnQMqWl5CVE?=
 =?us-ascii?Q?UyuISr2rr3bFrYo/mWgZCpp5H+nGao44ioNrSdqRHip5H1C+DkTIs34yTSqT?=
 =?us-ascii?Q?c1Hf5B3M63BG8bsX5bPDhXYB7EedQcRKpZR6NfOVCXrnZsP4JQ0vvMgRpGNu?=
 =?us-ascii?Q?EXW/2n/n8m9Kp7nxP5KD1LWaWh+cz8hW1lPc8OvJInwdXn8P9VKr0P8VQi5Q?=
 =?us-ascii?Q?gcEJVZ4+BpZhaM7nBFmGb3Ww7bQEJd8RxqykbXiwrlZ5WUlTqhxLzOt/4wfI?=
 =?us-ascii?Q?9uEvZV1qDf8xcy0zmyI4Szs+eSRxIGLycK5TRVxygEvQUWcrp7gSmAFLMoU8?=
 =?us-ascii?Q?YgjXaAf19Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380f7de5-7820-4b64-f12c-08de64a448c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 10:49:49.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEC6HJne6XINSbopM6yfWB7V1PIOa3NcHXpwftLh2JzVPZko592Pu70Kh0S6bGfea+KYpu4zBvwujawRh+W0/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR18MB927633
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 24H4mHMYPiSOwKEJ6WH2g5o6GhpeTvTz
X-Authority-Analysis: v=2.4 cv=Da8aa/tW c=1 sm=1 tr=0 ts=698475d0 cx=c_pps
 a=7tpojskyxclYbGypRN9vEg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=pGLkceISAAAA:8 a=FSZRMB09xS8aK3MWgVEA:9
 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: ft6Esezd747Ad8Ygwi_QFu2WgI8viQHn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA3OSBTYWx0ZWRfX3zm0QeKp4kY2
 0zSoisqwZLtiOxbkOCQx94thsxe4T7qfKtTGC3Bi3itnEnxFUhPpF2nsyvc31foY28lEVhe04Ga
 rFzs8QL3ktrt7eiXsPMNMRdS1iHpWxvFFzqlxG2iCafJqPIu6CYJ6DRD77v74fyTVoIgq7EAq3c
 c6VWofP/TtMqIg0yaAup+S9eWt6QTmKs1SQK9S7iibSXLafcKP+TFvwta2DXUbliK6cp/JlhoxE
 xdjdm0Mm4CsWdLK+3ZljFrYmoTeLxvF6GGpABlWus+OF2Q8kN7fBsHacyzKksEgNNXwcipnvvMO
 pJbRJCyxhMiRL0CeJORWDJGjRlzpJZoUl1799ImErjzYsoY9PkzRrSU5V3cj/otS2Qqj1AuZX2s
 JuZDhfdxelWE6nilaelQLn45VtiGWJM0ne6IFeXEVnphtK+Yi1I2dvXh5MNnezEDM9Bge0kNIl1
 rVvaVXe+LP9EyMU6f8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-257113-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,marvell.com:email,marvell.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MSBL_EBL_FAIL(0.00)[alokatiwarilinux@gmail.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[enachman@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	BLOCKLISTDE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37DDBF1764
X-Rspamd-Action: no action

>=20
>=20
> From: Alok Tiwari <alok.a.tiwari@oracle.com>
> Sent: Thursday, February 5, 2026 11:20 AM
> To: Elad Nachman <enachman@marvell.com>; Taras Chornyi [C] <tchornyi@marv=
ell.com>; Volodymyr Mytnyk [C] <vmytnyk@marvell.com>; Vadym Kochan [C] <vko=
chan@marvell.com>; pabeni@redhat.com; kuba@kernel.org; edumazet@google.com;=
 davem@davemloft.net; andrew+netdev@lunn.ch; netdev@vger.kernel.org
> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> Subject: [EXTERNAL] [PATCH v2 net-next] net: marvell: prestera: fix FEC e=
rror message for SFP ports
>=20
> In prestera_ethtool_set_fecparam(), the error message is opposite of
> the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
> not allowed on SFP ports, but the message says "non-SFP ports", which
> does not match the condition. However, FEC may be required depending on
> the transceiver, cable, or mode, and firmware already validates invalid
> combinations.
>=20
> Remove the SFP transceiver check and let firmware handle validation.
>=20
> Signed-off-by: Alok Tiwari <mailto:alok.a.tiwari@oracle.com>
> ---
> v1 -> v2
> remove condition of if (port->caps.transceiver =3D=3D
> PRESTERA_PORT_TCVR_SFP)  check instead of error message correction
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_ethtool.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c b/d=
rivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> index 2f52daba58e6..750c72f628e5 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> @@ -717,11 +717,6 @@ static int prestera_ethtool_set_fecparam(struct net_=
device *dev,
>  		return -EINVAL;
>  	}
>=20
> -	if (port->caps.transceiver =3D=3D PRESTERA_PORT_TCVR_SFP) {
> -		netdev_err(dev, "FEC set is not allowed on non-SFP ports\n");
> -		return -EINVAL;
> -	}
> -
>  	fec =3D PRESTERA_PORT_FEC_MAX;
>  	for (mode =3D 0; mode < PRESTERA_PORT_FEC_MAX; mode++) {
>  		if ((port_fec_caps[mode].eth_fec & fecparam->fec) &&
> --
> 2.50.1
>

Acked-by: Elad Nachman <enachman@marvell.com>

