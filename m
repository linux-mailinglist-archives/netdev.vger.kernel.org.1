Return-Path: <netdev+bounces-261028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KOoJfAnn2nmZAQAu9opvQ
	(envelope-from <netdev+bounces-261028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:48:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9052119AF45
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6CF330046A8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A23D7D89;
	Wed, 25 Feb 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="j5gatyMu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E056332909
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037962; cv=fail; b=VbvJuTsA5EAODLLY5uyfEkZXhFeGBZJf10pzKG6yzcpVZLvICXtPiBWfTksZaeUTw1ECGCBY3z/HAa+dU2Va4PHmvzEr8PEKatW4YLXCM1XRtgdz4Vzf4BT296e1fQGa/vV49eSrWX4Dfm0r8hVwQl/f5JzTYGVnxC6q4HmFSI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037962; c=relaxed/simple;
	bh=1FgRn9iavnBqEg4BwAlT2j0Y/I3DxNIZG2uXKeZEuPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOsiI2bb113CY7Ln13lqwsDHzIN2v4t2zvKvs69i1neXmHXBILmIWr0m3gaSze6zKtOIBKd6p0LREPJ4ZAKfPP+m2Gy2Ckk+JHrWOfQ72HRlFpILjXqA96y8bouX9iBRm7dCnqspgN5Mi02QZIh/Xid3MetoLtzN8rRwzw6779M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=j5gatyMu; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PGTEv71363425;
	Wed, 25 Feb 2026 08:45:41 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022140.outbound.protection.outlook.com [52.101.48.140])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcysxht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 08:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIah8LfE2QM+zilrc2neVkSE+GLuvCEsqEOgl8F3UC16wKO0ENQJsbqmC3DFUq1wjY6WvOdP14bOkIiK0qSKmrPDwlzr2sZFr0cqgJ/IZMqyHbMgfUjl7EhLw2WnGKT0pDg2d63d/ZSMmkkAtFG/gLvD1raTiv1L9/1eOlefauG+2wjYQaSw3GbrfcDG5yUcXaokz6Dnj+OYH8ouIfvzGXl7VVUmkNY2Smnj5DMMf+M2LWC1B/RxxSh3qX/11KinOCdI9GQ8oV8TJvR00MOeNFy5+TqloRItsE17xhXij8JG0OpW0p3HvOIeX209Ng3ArvUojKZSHyfNPnuJrbpvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFKi38YOKZ9sisHL+mHYqao454oPWSmWYSe4zMHkL80=;
 b=E80UgxEXWPIyRatCqL9EEK6t5M3DWt7HUFfG+vh69fhNxUmK2oQ5MmIWDUr0oLAhXmqwONGMkaP5VGPmV5tNGgA92dAGpOgSKecF4y2yhdCzSq3ulcqFGopWl+/s75Kquz2gs08REnxoKl2RttPwH2aU6YJLdG/kcWklNbdVXNJNr6/5hlgB9m4C9s1/75p2GwbTe7BKfpJyX8e0NMp3dr9dtqoEh3DPnP/8RR5/DbLJcgG8eg9oJBsaWhsXn2j5CitVL1xmPi6ke7z5iJf6HLXwwAdQLj078TvkYIum3ocd9YG6kAHnyjJssC24seoF3dpm/Z5bc0Rml07HL1zZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFKi38YOKZ9sisHL+mHYqao454oPWSmWYSe4zMHkL80=;
 b=j5gatyMuOEnTgvZZGp351WG/nqk5kEQR6ED9BRPTTMkhE+vFzsN6ihIhnDmBS97jc5y6ZhT7doccGTilGI66pDNAME6u/iuRHeAU5BX8ILXO4zk9gFyNqJNPY1Nc0XkXiMVs4KNhZhpOZF6D834IxxjrmqCnGZv8aOPUf9zKhLA=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by CO1PR18MB4633.namprd18.prod.outlook.com (2603:10b6:303:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 16:45:37 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 16:45:37 +0000
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
Subject: RE: [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Thread-Topic: [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Thread-Index: AQHcpnYrJujnvnukwUmOcYIC7m4HOQ==
Date: Wed, 25 Feb 2026 16:45:37 +0000
Message-ID:
 <BYAPR18MB373527B461555491BBA10FF1A075A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-4-maciek@machnikowski.net>
In-Reply-To: <20260225153858.29486-4-maciek@machnikowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|CO1PR18MB4633:EE_
x-ms-office365-filtering-correlation-id: 0507ce08-5e25-4876-91bb-08de748d4da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 sgs4ITaKRo9LxJ10Jj97kYqWbyCi3YDdXy5/Yjac8GoWdGrhqnp3UlcLUc1/WHs1B15C7gXdmUSsVFPi7xYudAKpltGAKFDCTdP6EMoVAibb+bA4kpVQ1zJuwVXSd1coRB/MMp2fYMnvvYIqNbVWlFzUsn5Gkpjud6jvUbENCpjMuum3dcXJvQutBorbo8re4lnXq6XpSlAI6eccZ8UbfFkyrXRjRXWNNe8BiWO+bwnxdS6+VcRrXqtNv483VWqk7qMUpQ5BKqJeW2E9AdAynuIbnc4atnOr3zHBoNgRufCA5jAb79WdtwHFSFMp5rx8dgTg67E+CqMFTfdjZFa3exGEheYSiSUHG5Ccp1PEYmBSUS6TEERQWT9GO+bxIm55Fr9q/UHJOqiU5iiwtQeysX1162OR1vmtGUBhq4nVRL1AY++tWYRHjbMXhSWPIAtmd0p0BbualSd5rHuRKnDz4+9OkrLFlWJjfnkYi2XaQnrl2qSJh/Qwow6OVdPJRxFdCweha6mw6xOx9RXrC++hfulwzYp7fZgo+zJB56cEdk4j1ABUfl4T2I9hmU0NGAjzSQIu4eO6pCMUiEKdjm1LBnvy0Q+XZxYaRjNhb7zDkMNUv93NfkLfsyt/f0sLLWc1tD5qJIEYBSOSYk1Lf/7IEyX5jS9O0d3hWRTWeARHYW81NvLJu0dORPRjItaUObA6to1/8usNMZFN7tiTcd52Kp/48l3VSUYgR/3EYwqOvyBObCTQKNtxFCiprv4q61OP5ERHqIMuFmbexcMTFph33tFAvc6M44025olBd8/F6YQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MkrzOWnehDDDXpenEGqkvTwodK/BwLqm+rwIy/wqvqwUDgv3cG4tXTAO1P9A?=
 =?us-ascii?Q?gYFwIoOMDUm+la73lKZsfRlNWHwoDP8M0z9iir9bZme5LxKtEdar5qL6BO+O?=
 =?us-ascii?Q?qbGyy5pZ/ygea/gmk0Oume1ep8wYvOVvytmL3EUiWi4snxtHiCxlfnbOteT/?=
 =?us-ascii?Q?C9itvcwYHxaSfvSXOkirTYLOv6y6rj+6RUL1YJWhtVyYnSnvDAP5DPHWOqTA?=
 =?us-ascii?Q?YvkgyM04hTY/bbmnNkwaHZrkkNWN63+gwVKdtvqDbmPGD5zaGhYcXEM+5hLu?=
 =?us-ascii?Q?px+RSVXZ+c1miH7L6hrU1jCxuQ1RWT6jPBk3R+xWXVr88VYGMzirlcaDmjYq?=
 =?us-ascii?Q?l0Vo8et8DsigoqKm49Nsd2E+8Z7HduS5JxgTwHhMLPLrQ3m4N0ev1KWd9XIa?=
 =?us-ascii?Q?aqKY6QCA7q/eQ82areLjpFp9p7kE3m41HYQjubQpHqDNEDwRwOF+1qBTeLtF?=
 =?us-ascii?Q?l4iRGxmFH/gSN6EUIiW5I8R0L3ph+Ux2zvUddFpab+4LI5eN91pI73dW4VOE?=
 =?us-ascii?Q?qJss1c68kNBVIYzkoFRiMDfpW2dmQZ0aRpTlGB2xVEWnioq853d4Wui7bwL7?=
 =?us-ascii?Q?mem539ANsx4S9SOPtBpk/F2NYs5zC1fOdyDrJ7fuO7xQr0XpPP2Z8Rg4O3sg?=
 =?us-ascii?Q?209j5b+0RHTa6nisRgPqyXozoudlTmxVMcD/cbX4qnMUBcsdeQPJ7LRUPwpJ?=
 =?us-ascii?Q?wrUwbaNHVGQI00kabn0HYddWl3y93+Z8t1LmdrhqRbjMHnXI74FB47Hvgmmu?=
 =?us-ascii?Q?tMGA6zKoLHsmNNF2KO/2Y25/sGu8Fgty0K1pIYUJlItT22Ei7VI3zbLTGzYv?=
 =?us-ascii?Q?tyFbCRKjHXRhGBZLhLO0EjzFkf0/OIH+8ubjOlR7oGX8fsT7t1cvIJA8ebQK?=
 =?us-ascii?Q?FUT2s2Zw6dvjz86UIEnx9Pa47bElXk4UT7kE46mW6SMjorH4IokSIFmAoH+q?=
 =?us-ascii?Q?KCy22s/c70x17iVcaDvcnAI+AjzXVm55lObGUmTxzoJtCbTiKCoQSvIPJzcL?=
 =?us-ascii?Q?XgcITdIhvY6MyFniW4E5F6UkDPTt8YRNbsYTMX5l6NByWRFHdfBZws43I2l6?=
 =?us-ascii?Q?e0ruFOd2OboyGlh74N45M+U8uqBELKx8svZMCbIiHTblQBi2oK7BswR4WSgN?=
 =?us-ascii?Q?twvVSOM0wL0L/F4Znrwi1m5S+yh9XY3ytFgcpXdWuavUn6riPrNh3dJ3tiMv?=
 =?us-ascii?Q?cL3g4n7i+yrS368NLUJa286f1iH431W7xMkrTPtrSoylFjJuVY5Vz+qNlYrF?=
 =?us-ascii?Q?YDZetmmtgL0+I5CiOq4NBhXg0x1Bn4RUmtqd1sFp7DTPbnHRQz9WAC1u6/Wr?=
 =?us-ascii?Q?RNTHR0tulCYP+BBz48etXZQBj8+8ReE7VMuVD4U13izABivUrOCEkR9/Xi7L?=
 =?us-ascii?Q?aLkAGQ5nbsnUeYMaBy7oD82plRsq3Snc1Dl/5tbZxKJ1PKuMUol1IaYeNTQt?=
 =?us-ascii?Q?CoX+FYkjp/rqF6k3vdYaLP1l8D2bsK9Gvm6C2bbWWGZkSP8EwQiYyGSEuvLz?=
 =?us-ascii?Q?oWRJ4ipXF+sqrSrxXcbp7EzhmhiuYWeXAqy912NgEXiFXNt4evXkANO98zBD?=
 =?us-ascii?Q?5fCP1exLP4dyIoxceHO1cUN2Pg3Zf82zg69e0WZ1SCVi3MsE/vZYc9wU1Tr7?=
 =?us-ascii?Q?8Goodmq+PrTQy/8REAb3VtGt+41QDDk86DjHgPMwHYEx0bYgqZ5dND9RsA6x?=
 =?us-ascii?Q?8vuZ00SWEbR+aAtvTYK+2GdX2g45hjsxNb4vCgKUDIaa7otv9wSMGbI4DNKy?=
 =?us-ascii?Q?8p3s3tWqUA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0507ce08-5e25-4876-91bb-08de748d4da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 16:45:37.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXwoe5vBaSk5GhEzrFeHJsLIc21v2Ta0KMRdrCIvSL9UfkbinGKxsttGhpzd03tMlK+hNtDLDowHUoibv+snCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4633
X-Proofpoint-GUID: 5YcJvnySYNTSgIKgvLhHC0L1Byr2SY5i
X-Proofpoint-ORIG-GUID: 5YcJvnySYNTSgIKgvLhHC0L1Byr2SY5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2MSBTYWx0ZWRfXy59GRUzKZ2OS
 nfy6fbHulzHngwsf9TzHySqagMkw77GN2EXc9QilsGwFUIsdr+kVQ0qmofem89bwSr4xjzhDOKy
 R90E8N7E9kdCTpJMzRRE6qqdLynqOZLSNLrkLRYJtKdl/RtBaRzDqUbUAjZ9uW/djIVjGVmlMdZ
 C/k3KGfnTGP7maqaVIroO9ciOotXp+mH6j0EVayhQSzVoO6AeLKtymZq6gwAlcZ7imItJQMMxYy
 gwPSIOnkUp38EIiSFkhv4aPXuXOtaKXm8rtEmHyuIl4dXvG0kEueOdIZQRv4CqWIfOWkvFcAdlq
 dPcn5wg5nSl/gtmAGvGtmwETo18/oh3RiOLiWpgPQQgvXrkQPVpc4Q9pmmzvY0YMJIl3UUdh8dA
 28vTABgjAlKzlk7lqR4bkCcb/ddVToAiPcfnElgSRsh9bKGh2KEonpi7jGA2oH82LU3UynOn9or
 qzE7zurlXJgBO7Get8g==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=699f2735 cx=c_pps
 a=j1s/UBwfdopMoDbT8vzgZA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=6gHIKlzYAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8
 a=W1b5NI9UyvRFvDWWSvIA:9 a=CjuIK1q_8ugA:10 a=IZuCIVfSzXAHSwQMVxNu:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261028-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,lunn.ch,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9052119AF45
X-Rspamd-Action: no action

> -----Original Message-----
> From: Maciek Machnikowski <maciek@machnikowski.net>
> Sent: Wednesday, February 25, 2026 9:09 PM
> To: netdev@vger.kernel.org
> Cc: kuba@kernel.org; maciek@machnikowski.net;
> richardcochran@gmail.com; milena.olech@intel.com;
> willemdebruijn.kernel@gmail.com; andrew@lunn.ch;
> vadim.fedorenko@linux.dev; horms@kernel.org
> Subject:  [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l
> sync test using netdevsim
>=20
> Add PTP synchronization test using ptp4l and netdevsim. The test creates =
two
> netdevsim adapters, links them together and runs the ptp4l leader and ptp=
4l
> follower on two ends of the netdevsim link and waits for the follower to
> report the synchronized=20
> Add PTP synchronization test using ptp4l and netdevsim.
>=20
> The test creates two netdevsim adapters, links them together and runs the
> ptp4l leader and ptp4l follower on two ends of the netdevsim link and wai=
ts
> for the follower to report the synchronized state (s2) in its output log.
>=20
> This implementation runs the test runs over IPv4 link.
>=20
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  tools/testing/selftests/net/Makefile |   1 +
>  tools/testing/selftests/net/ptp.sh   | 105 +++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100755 tools/testing/selftests/net/ptp.sh
>=20
> diff --git a/tools/testing/selftests/net/Makefile
> b/tools/testing/selftests/net/Makefile
> index afdea6d95..db576ea96 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -64,6 +64,7 @@ TEST_PROGS :=3D \
>  	nl_netdev.py \
>  	pmtu.sh \
>  	psock_snd.sh \
> +	ptp.sh \
>  	reuseaddr_ports_exhausted.sh \
>  	reuseport_addr_any.sh \
>  	route_hint.sh \
> diff --git a/tools/testing/selftests/net/ptp.sh
> b/tools/testing/selftests/net/ptp.sh
> new file mode 100755
> index 000000000..8e5b3e1e4
> --- /dev/null
> +++ b/tools/testing/selftests/net/ptp.sh
> @@ -0,0 +1,105 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only # shellcheck disable=3DSC2329 # =
#
> +By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026, # #
> +Self-tests for HW timestamping and 1588 synchronization on the
> +netdevsim # emulation with ptp_mock.
> +#
> +# This test:
> +# - Creates two netdevsim instances in two separate namespaces # -
> +Assigns IPv4 addresses to those instances # - Runs ptp4l leader in the
> +nssv namespace using IPv4 traffic # - Runs ptp4l follower in the nscl
> +namespace using IPv4 traffic # - Waits for the follower to reach
> +synchronized state (s2) or the timeout
> +
> +source lib.sh
> +
> +NSIM_DEV_1_ID=3D$((256 + RANDOM % 256))
> +NSIM_DEV_2_ID=3D$((512 + RANDOM % 256))
> +
> +NSIM_DEV_SYS_LINK=3D/sys/bus/netdevsim/link_device
> +NSIM_DEV_SYS_UNLINK=3D/sys/bus/netdevsim/unlink_device
> +PTP4L_SYNC_TIMEOUT=3D20
> +
> +setup_netdevsim()
> +{
> +	set -e
> +	ip netns add nssv
> +	ip netns add nscl
> +
> +	NSIM_DEV_1_NAME=3D$(create_netdevsim "$NSIM_DEV_1_ID" "nssv")
> +	NSIM_DEV_2_NAME=3D$(create_netdevsim "$NSIM_DEV_2_ID" "nscl")
> +
> +	ip netns exec nssv ip addr add '192.168.1.1/24' dev
> "$NSIM_DEV_1_NAME"
> +	ip netns exec nscl ip addr add '192.168.1.2/24' dev
> "$NSIM_DEV_2_NAME"
> +
> +	set +e
> +}
> +
> +cleanup()
> +{
> +	[ -n "${PTP4L_LEADER_PID-}" ] && {
> +		kill "$PTP4L_LEADER_PID" "$PTP4L_FOLLOWER_PID"
> 2>/dev/null
> +		wait "$PTP4L_LEADER_PID" "$PTP4L_FOLLOWER_PID"
> 2>/dev/null
> +		rm -f "$PTP4L_LEADER_LOG" "$PTP4L_FOLLOWER_LOG"
> +	}
> +
> +	[ -n "${NSIM_DEV_1_FD-}" ] && [ -n "${NSIM_DEV_1_IFIDX-}" ] && \
> +		echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" >
> "$NSIM_DEV_SYS_UNLINK" 2>/dev/null
> +	cleanup_netdevsim "${NSIM_DEV_2_ID-}" 2>/dev/null
> +	cleanup_netdevsim "${NSIM_DEV_1_ID-}" 2>/dev/null
> +
> +	ip netns del nscl 2>/dev/null
> +	ip netns del nssv 2>/dev/null
> +
> +	modprobe -r netdevsim 2>/dev/null
> +}
> +
> +if [ ! -x "$(command -v ptp4l)" ]; then
> +	echo "ptp4l command not found. Skipping PTP sync test"
> +	exit 4
> +fi
> +
> +trap cleanup EXIT
> +
> +setup_netdevsim
> +
> +# Link netdevsim1 with netdevsim2
> +NSIM_DEV_1_FD=3D$((256 + RANDOM % 256))
> +exec {NSIM_DEV_1_FD}</var/run/netns/nssv
> +NSIM_DEV_1_IFIDX=3D$(ip netns exec nssv cat
> +"/sys/class/net/$NSIM_DEV_1_NAME/ifindex")
> +
> +NSIM_DEV_2_FD=3D$((512 + RANDOM % 256))
> +exec {NSIM_DEV_2_FD}</var/run/netns/nscl
> +NSIM_DEV_2_IFIDX=3D$(ip netns exec nscl cat
> +"/sys/class/net/$NSIM_DEV_2_NAME/ifindex")
> +
> +if ! echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" \
> +	  "$NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > "$NSIM_DEV_SYS_LINK";
> then
> +	echo "linking netdevsim1 with netdevsim2 failed"
> +	exit 1
> +fi
> +
> +# PTP synchronization test: run ptp4l leader in nssv and follower in
> +nscl, # then parse follower output to verify they synchronized (servo st=
ate s2
> =3D locked).
> +PTP4L_LEADER_LOG=3D$(mktemp)
> +PTP4L_FOLLOWER_LOG=3D$(mktemp)
> +ip netns exec nssv ptp4l -i "$NSIM_DEV_1_NAME" -m -4 -P \
> +	> "$PTP4L_LEADER_LOG" 2>&1 &
> +PTP4L_LEADER_PID=3D$!
> +
> +ip netns exec nscl ptp4l -i "$NSIM_DEV_2_NAME" -s -m -4 -P \
> +	> "$PTP4L_FOLLOWER_LOG" 2>&1 &
> +PTP4L_FOLLOWER_PID=3D$!
Minor nit, =20
ptp4l master, ptp4l slave started back-to-back. =20
Better practice is to=20
Start master
Sleep 1
Then start follower

Otherwise initial announce might be missed, causing unnecessary delay.
> +
> +
> +for _ in $(seq 1 "$PTP4L_SYNC_TIMEOUT"); do
> +	if grep -q ' s2 ' "$PTP4L_FOLLOWER_LOG" 2>/dev/null; then
> +		exit 0
> +	fi
> +	sleep 1
> +done
> +
> +echo "ptp4l follower did not reach locked state (s2) within
> ${PTP4L_SYNC_TIMEOUT}s"
> +exit 1
> --
> 2.53.0
>=20
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

