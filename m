Return-Path: <netdev+bounces-95935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA798C3E1E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12DD1C21040
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A71487E4;
	Mon, 13 May 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HW45mSvP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629D1474B1;
	Mon, 13 May 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592477; cv=fail; b=fdEhFMTvsEHEE1rjDy/U/4daajD12exbcqZoOvDFmI+/ScenURUvAtapgN3uAk4IiuvLAZCr3GBekfPaSO7mCIrpxGGhVIGlJxtljsMGrWoCkm0MtqBDVX59p2l+WZIng4DfsZIzH2blq1yru1zpyMaAxBFaagf3d15OvG0t2Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592477; c=relaxed/simple;
	bh=pxxnxXt3r23JpMpHxJOcTBR/jOfbNPhelyHL+UlpFRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=auXFaaUEE8zhKOnD5/QLiaPqi27+4wVzblbSwkBbw4eEIO3bRy9qSkSv/CwOmSvZrWq1992u/gljrmI+VQeNdCp9KV4Kdf91d1+9lGyGZyj4UsL8jLLo1H/HtnvsnkEY6HqhBh4gvNMGzEZc6CZHLpJRPWP0XudhQMC2LsHMAJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HW45mSvP; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8X8GG002147;
	Mon, 13 May 2024 02:27:28 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jbs4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 02:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5nXjHPwt2zGF1ObpMmQghe0WBUKvjte/Kgim6yo8NBH7yBbS3ND3QA5vitGcUy9iMgGKC/JZbanLWDlozPwKsUNfrPqt9PPMeKPNDZ1u0hZxP+rQaMymkPk+aswHlpIv/6X3PHj/lCtrbnUfAu7GwggbMjW9704+hXdr27W5peataEEVIIgKfA/McxGiNBpeOypi42x+f7O1DIBybpxUl7zibhRx561/9WaAyOdVQEeDMJOPNJxy3boysJOvCf9yI3SntHInIHDMR+o3RFRxPXgiJwjegZQ0yUH8MSfcvh9hghlJxp3tNpV6dwh5Ycz2srIpt/naFV8ZdmggRzoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5xKqfd4GrY2bqBMnO4bjRqad/Xn/lbot9/cN3m3fmA=;
 b=Tb2qGF5DuLEOFAm6NIID6b2rbc1oudmjYcsiO51zPdAwaZaxf7AtYzBkYc8zfHczM8MmeAITcXrr16gIg2+zj7cnH2/hnM99P5rhi3zk964UOhz/PxqSdE/DST3V0YQP0mF2CoVHH5unmKsIXEeBaqm4wP5uzJwJDzmta8YWubdYcGSIxqTKKeeN7rt40iE/G4Y/mNntGNByN2jAJjvISfB+Rbn8F4ZpEDNrZrwDywmb8iHfsGvXRhP2XkZHcEFG1JFzTO20NUkZa6SryAFZKsr1Wiv/YH2zCPv9v0TumddlI5s0wSXV8NmlGMv7p545L8i/ikElqJz++PBG29huZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5xKqfd4GrY2bqBMnO4bjRqad/Xn/lbot9/cN3m3fmA=;
 b=HW45mSvPUkN8u08bFglfkuGenycOcF3W8s9tefMmUsSxb9zLSZQgqELW01oMt9jYpQCySC2mysEB7Jn2sZZ3fxlrODezC60djYSzkVDbanpHIC5qsOuZYt3TzfyB+rf6y8vpqTUFvo6RfBleXd+KTET5AzRuUTmYSm8AY3Fyvk8=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by MW3PR18MB3498.namprd18.prod.outlook.com (2603:10b6:303:5f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:27:24 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Mon, 13 May 2024
 09:27:23 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shenwei.wang@nxp.com" <shenwei.wang@nxp.com>,
        "xiaoning.wang@nxp.com"
	<xiaoning.wang@nxp.com>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Topic: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Index: AQHapRfDaiJFn1FWf0uT/Cuv3lOavw==
Date: Mon, 13 May 2024 09:27:23 +0000
Message-ID: 
 <PH0PR18MB4474D5050F6CBA0B2D4A6041DEE22@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240513015127.961360-1-wei.fang@nxp.com>
In-Reply-To: <20240513015127.961360-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|MW3PR18MB3498:EE_
x-ms-office365-filtering-correlation-id: 5aa0273c-b137-4435-6f39-08dc732ee5a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?tD+SyPAJAaX3Hgx9DwNMP+YZgKf1Rz0dREJXQKd3M/+OUJCiK5l7MbIOMqSR?=
 =?us-ascii?Q?UCmXtK9YNmWIAliSdHa5SEALAH7EoIxbP5eQmVAqqz0vyitokH34dcgbVV2z?=
 =?us-ascii?Q?3uR2KIlMI3AunCkC5eQi9kCSqUmKhu65ZGaTlLz7rzFoJMKHJrJ2RhE8l3Lv?=
 =?us-ascii?Q?GR2jVOviXxEbsLlE8btJ2yZgyNrCls7+6K3WhdmOH8WXPKG/q5r2axyGnU9F?=
 =?us-ascii?Q?NWCQoD1M2+g/N81oiBeqrBDimVbDaYsdRENfted243iKnu4wDY0xRy1v07+0?=
 =?us-ascii?Q?pOjMvcvVdr7DeC1Igu/z2cm4HAnYs/DdUgSfVAmCQq5aSrDBz96d2LTwsr6I?=
 =?us-ascii?Q?JJCO65YSKQ1STbczPsmIyT66xvJXQzrYgQkjAMa3d7LAyIFC+z61ZgOy0dOV?=
 =?us-ascii?Q?aRrjMpFBX9LGzDKam7U2WK1dZ7Kg0jRJdGu4PGfCb8GMd+jscai20IyVjLBh?=
 =?us-ascii?Q?mGBoZvH16DW+6VFqZ9TeUnfkj2ZVipB7hTE7p7PJ5Jkmx6r2y2dGiisZlB0p?=
 =?us-ascii?Q?Li3eAAryGdkHgDKxNJoH6YNAfkcy5/FfI0DrPT8+yYN+wVtpar7NOOPM5epm?=
 =?us-ascii?Q?jXmCIzY0fyaKB+P+CP1A4imh/XpmppPdPVTq8ByWLcU9YO/23n32juKtp3Ej?=
 =?us-ascii?Q?YVGpNXVRquUlIPMBB1rpKqAFewN5v7HDu4uTlmM+DvCnhwIhQGYaGWkDXo4k?=
 =?us-ascii?Q?KTRhnTDNxBjnXU1OQ4RmWYvSYlu+GeBWqOIPelVfS+JShYMT+AsydV97Z5Xv?=
 =?us-ascii?Q?KicT9A4aT0aMrjnRt10tnEZZDwc6jgytEqrMh615Zp6pIYiNIyuXmEnK4oO/?=
 =?us-ascii?Q?vpbqFL/eulb4V/PX8zcc+WdIdZHLs5ZiYXk+IholSHSGwBh4WuL5vPcJQZ0R?=
 =?us-ascii?Q?8Xge/ds0VNzLUXArYHEdXgda+iderJxvHceEts8vCNXqh9+hGZiE4DzNWXiB?=
 =?us-ascii?Q?806w+xCRN07W9qgHjHPVA5ZTJL8t+jlMwQz3TXv8GsODqQuSiiqarkXbZuTM?=
 =?us-ascii?Q?lXgoduWjgZpBHveXYDKvtJvGQ0g6/rptL0q+HVXv1QIkfMab+gOk9HOMTHYJ?=
 =?us-ascii?Q?ZgkOTA1qX9IrVIUlNIt8NMISVmRix8A8wvIRSaeJOZSteaFlpILR6pCgc9fG?=
 =?us-ascii?Q?cjuZkbVVLFScEwWjeBSD6GvuLnEQZ/jxEMXLELaHq9anOniE2nFsF9HspQoK?=
 =?us-ascii?Q?ceqMSv7sd6FbdX1aMLMpZRhUWY3Da6oWHnlXO6twEwI7Zo55gBxM+1ear3NL?=
 =?us-ascii?Q?uFjgSP9V/FxMTcWwFq6keFNM9O7vmmKTGNYgNQ1OGatEODS5JPTFI2+XaOKl?=
 =?us-ascii?Q?/O3wl4gVPqmougsXRRcG5vLsnUXBb5ET0L6fMBl8B8si/mDKvRZGPGdZA/g8?=
 =?us-ascii?Q?twwh6So=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6O7PsR0Lr3KhiHAhOj1FqDV3pd9Jhcyz4OB5y0Yfv3PNQ6FV3EfYDyEGkkzQ?=
 =?us-ascii?Q?/Ru8JjcksKlqUNR0qmFH1Lg0wAY8hIrT/fnGufmw0Bns1HC0ksb2zv04wq8U?=
 =?us-ascii?Q?24JLQfgocuzzLS32Uyb4kFWFSgI+WdGsnwYUK2isvbHtalXhz63GG4s7kD8g?=
 =?us-ascii?Q?qdpzmH4yjuU2ZNIBWUdPrc972z/VRHHy+9RvQsWI+Q2eYh3c1fVQX8EMaWfU?=
 =?us-ascii?Q?azSTjmRPWVO6C10UjgbVlrBOBx7MFwhH/AQAZWPer7r5aVN65HCqIuVUV/tf?=
 =?us-ascii?Q?3lMxA5/Y6vAd3LC7MCA6AszPF1q5KgNhEooyoj6B2eaqEvVNDLZ3hT+6/cs1?=
 =?us-ascii?Q?dTO3KFJRxQIA2qjzG6mDQEWvP50/AlDfE6vTg/pXZuiTZ12OYPFbBsozEEVW?=
 =?us-ascii?Q?HVrCQO0pugz+7nlv2HN3IfCvagNttO8l7wqgXDwdaI3QOLr/aiNDw5tAJeP9?=
 =?us-ascii?Q?iq5skixLlCACu1uEc/KxPeMsjZsVHUMxnQxlfZy+2O3POKrFMjAHDi+6wMzd?=
 =?us-ascii?Q?PhfY+N0FzQZXwnT19xAJVgZRqEjxva0fzLO1naEtlTl5RFFbXx88bv4dqENq?=
 =?us-ascii?Q?WUQLHumfl0pQZm7zc24fPHCzabpGg6Jjo7w00RUsy7q63c3VjqPxH8rY6Xsk?=
 =?us-ascii?Q?rRmizeIg4HVzaVFg2ku8R1vxqbn3Uu/JLcV3LzYkfG9NQHUNmTHJTL7P0Qah?=
 =?us-ascii?Q?vcjMTUdxMxkYzq1VOlKit8CnQBWQRI3ru7pI9IBBkgytxYMM11djJ7FD+OgY?=
 =?us-ascii?Q?GUep74b93T/t4kKHwF2VcC6hkCqA0ykV3nZP2O0jSCv5jZsoTFQXyZ3gMp5a?=
 =?us-ascii?Q?DBMtTYoQl1c4VvcJUf5ccQ/CcP0LeXlPXrMe8tB7rJKLXIE91Ibu3NlutdAA?=
 =?us-ascii?Q?2a9ns3rsKssyrnGEzVoZToFrq4AIDglNvYShnXYYyRrbH279bVcPsONMzTYR?=
 =?us-ascii?Q?qQCXPp5IF7cvEazAtSm2mldow31tZPh9AUuwLP4NueSHOJNYshcSp/yDaEYp?=
 =?us-ascii?Q?qcwMrNcXeSE/s0sKnyi43h93vzkcz+8OHTL8HFW/6e7Jhf7UglFY8MBaTJ95?=
 =?us-ascii?Q?RZYIEBzr4rOXCJLEVl9w0QlugO23kxsgRcFg2B5uG4GIqP0+C/yE2ztPSqKd?=
 =?us-ascii?Q?Rinl+H6vEicCpcu9m7UeJcWXmAgfMsdoTgwJ/NoGka7csrEm5+Awpsps/KIE?=
 =?us-ascii?Q?p/kXVhuhnQD5gGRg69BQqcfiTsuabNEDqnvkeoJJxUi+di3LK3XbW7sLtlYE?=
 =?us-ascii?Q?FhFbWoaKM8ga80ej6oJgHQRE8JY/KiccUk/Ft+Zfz/Z2u26tV2gmDR8GcvE8?=
 =?us-ascii?Q?8q96WGzjXzKFi7/ByGF/GLLbh9Hitg4OWBlL5C5G02Nj7pQ4YSTK6HaXTRIl?=
 =?us-ascii?Q?v+5SDVLtv6RMW5y8ERGYkAGe6T0N2VhTX/U13nRZgPdWuysDuMPMhg7VOCfk?=
 =?us-ascii?Q?a4HrKhlYTxoZ50LCPxK4oiSaO3aWIJKIjoOk53rbKiBQbTf1CVD/d7cqI+m9?=
 =?us-ascii?Q?dd+ugqkRFOWqFzfNr6LKT6m7gwciNp9TVYcbHR2jz757ysmOb9H2+AS2PDWK?=
 =?us-ascii?Q?sTs8UZ51m5QYbopZEpQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa0273c-b137-4435-6f39-08dc732ee5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 09:27:23.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McNWMuo77eaPrfQ9mattNy11SRgv9YowH+c2/sd5A2UzmhgfpYkeC4+3uuKEIrLzi2mSUjrg2UkzZHnXQQm/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3498
X-Proofpoint-GUID: qpw4X80iu3_doLr74ASfpbcj8y0IfHFh
X-Proofpoint-ORIG-GUID: qpw4X80iu3_doLr74ASfpbcj8y0IfHFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02

See inline,

> The assignment of pps_enable is protected by tmreg_lock, but the read
> operation of pps_enable is not. So the Coverity tool reports a lock evasi=
on
> warning which may cause data race to occur when running in a multithread
> environment. Although this issue is almost impossible to occur, we'd bett=
er fix
> it, at least it seems more logically reasonable, and it also prevents Cov=
erity
> from continuing to issue warnings.
>=20
> Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock=
")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> b/drivers/net/ethernet/freescale/fec_ptp.c
> index 181d9bfbee22..8d37274a3fb0 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -104,14 +104,16 @@ static int fec_ptp_enable_pps(struct
> fec_enet_private *fep, uint enable)
>  	struct timespec64 ts;
>  	u64 ns;
>=20
> -	if (fep->pps_enable =3D=3D enable)
> -		return 0;
> -
>  	fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
>  	fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
>=20
>  	spin_lock_irqsave(&fep->tmreg_lock, flags);
>=20
> +	if (fep->pps_enable =3D=3D enable) {

Can we atomic_set/get instead of spin_lock here.

Thanks,
Hariprasad k
> +		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +		return 0;
> +	}
> +
>  	if (enable) {
>  		/* clear capture or output compare interrupt status if have.
>  		 */
> --
> 2.34.1
>=20


