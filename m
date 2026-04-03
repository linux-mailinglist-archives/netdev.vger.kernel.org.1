Return-Path: <netdev+bounces-274989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhOLpmgz2nDyAYAu9opvQ
	(envelope-from <netdev+bounces-274989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:12:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B439390F
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC462301E96D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D63AB29E;
	Fri,  3 Apr 2026 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="TRHmots2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B64315D53;
	Fri,  3 Apr 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214553; cv=fail; b=JcLwMnEhAI8gMJUmN1XGxhblbOyiDQv3EgydIE7ziNuIBIBPdn3TLUrsL2Vwld0ax3kZcatriKZu5PAA2g5/2txSJkhZfEs8ppu0Bm7wv7KSppRM1M1Dlxs3TzhSrWYJ9Bib8n1KJOgGiSxyVmh0PyHz+l/9tBJTTsrTt8NaMFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214553; c=relaxed/simple;
	bh=rjU3bede83HnXeUYPZTBMoEeYNhAxkZgtRUCCre4Sjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uktJbCgSiqouWUmIoAyRyU+1pHGrXfUI0dml/CTP9OFU18KIXFvGD1eMhrYGWnY0tO0T0kvEtux/niT0y//ikAi+wFh8G3CjD0LS0eIKBc8MlJRk4y7+ZQamP+DVAscSOQKCb2r0GQ/bGZYLTpBZr0P9fRm7DUPtWlr80BQc9Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=TRHmots2; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63389Zaf2358182;
	Fri, 3 Apr 2026 04:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=NKW4YXePASihFkJQEfxQNi+JrqF1QBcSER2IBWYJ1XM=; b=
	TRHmots2HaMJ1r5Bhnnu80RWt0LVRS3jyDNHtn2JOI4IwN8yhIBD7gYUHaz0a59L
	uiiThSW1BzuacUQcpoX5JSdr/24u/h1b36+BzwypEo1Dqrlzid/vcVNTvWIcZ25s
	kwIiamkg9g34YEVTIBMTvFuP2PGlkT1Bt/m2Aik54cJqNcuwJU3a10MjghUHw0Mc
	JugBcDyzi+q5lBm5vxL/2rlTKbnd0ZnuJ14biObs72YJgj6dQJXm7YpqJkH39xVn
	wkC76PAnlOJK2kxeK8OmQ2XG9hZPq8bC9AD67lnstYMApkdAN7Pns2QnSvUZoQWv
	xzU4aCXdqE1xmu6myBBR1g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vh1n6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 04:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FK7Qs/YkILPA9VJZ7BQvONBUQBvTNZDdKzzKAap/gdUfLTLfc+TDZfq26pG5VPudlMH9pSjwwrunLlrAwuJOUFotraVKoUTL8Ptzi6Wg8PJIX0fXTOgsX5JG9D2mNougxivEm7qPlAzxIWz5LMVhJ0a1gXE9rFjzvQRaHsdKeXbJbBXb6jmGC43CnSEt/990nbAhT2FVOlDYHLkBGzU0DDPltIz+GOy34KCJhZBy22uMCSJiF3GXvTlJkgGzE+RM1YiRO8rv+Lxes2/WdZEPK6mGtT2yW/jWLSl/KvBLU3BP/CIw9vulweinUcCqLyz8xt9u5GsI23cXbSqgeB3lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKW4YXePASihFkJQEfxQNi+JrqF1QBcSER2IBWYJ1XM=;
 b=nz6sNi+/4Zvn0+ClnwNCaczuVVyd2wewvuTMIjtmd9RQ14kGfh7+gR+1Ml+q+WFh8ScjUEBiDB1i0nxGZfv5K69Px4wBTWGfzVaR63n0Sntb3z6EQzi+ila6rh5W+y0SDE0oXhwrLAQlTBSEtLgNt2d+N8PtoNIIWXeiYTBS/2WMRAT/Jt6O00MakI2tXxzm6HgAr6FUSMJHEy7Ec5ibOr2m/3Oc1hv484cmYBCXodxVrAzfuO/eD5Pphwj+98CVygHAJbGO+xoeyf1F9kJIipHBNi4GLeSqqZTHSfCjvSaqdEzW1CDtjfiJbfuteX5PQC+HKILoJBY8YlFsIGOEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 11:08:46 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%4]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 11:08:46 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
CC: "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        Friend
	<netdev@vger.kernel.org>,
        Linux kernel regressions list
	<regressions@lists.linux.dev>
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Topic: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Index: AQHcwOon+EXpRGfVfkKIJTxR0EbLd7XJePpigAICbwCAAaZzGQ==
Date: Fri, 3 Apr 2026 11:08:46 +0000
Message-ID:
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
References:
 <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
In-Reply-To: <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-04-03T11:08:45.763Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|DM4PR11MB6213:EE_
x-ms-office365-filtering-correlation-id: 75e5ba8f-cb1a-475e-41d5-08de9171603d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 R0/ncSWOzFAQqVPPwX4+uR5z3N2dQvi8HQyeBQK8Y5fyDZuQjaUqTTusKhVGMtueeOfLxZ4lpzh0Ny9634gEiBGAy6+aETOrtPQL4dvIRodKia8O1KlqvJxmwcFeVREV80qgQ92WvhAK3/QKk7kmZ793FGKXWChcprsi8s+VZa+PQeLGIHN0fgvfRcu3SJP6y35PTHbL1KHN46NR8nE8eB4ieiooY3xLpIJJ+2rAurRc06yuKhd+JVAe3+aIR6xbWtZWsE+RPpAQsGVPbcTFcwLsjBjhn8VY4PQoCQ63xRqqLJ/vcYnVxllr8+J4H8UuxEDIwTiZeIPSiq7V3BsN5POqDkPkcbpVguU6SeTw8R0a3gmhd+JbErcx+RQW7OFEkXxVYuY0JOeIosaV1Y0GzG4lM2nvcSuu/+86ZrtqcDHJ2QbZyfUMz/pQrzxahJmDvrfTkhKRmomX+asZPxoecHXODRdRxk9NaMLmq8IVehb14bBuf1j1v1gEwjOcSTDKCrBm9heZnlHwfolEI+Qgcm2oh9r7I2CkDVjWKW+UXEXcHf9Ht0ADFPq3g6SOGpAetWuSMRhAalZcOUxIPuMmcomJwF0AW83LdCEC+E1zkBb5Oe5PDtkUnpadtRjg7ap0WM9bNQ1nl1lztSnUt7UuEiaTkoUJa5OtrkA4my3AVGkxuc16g2HjWJ9dRmwvCapTZw8pHUUMyF7ckboGDh372gP+Rptpmg0zwQL+6ULILDenU9g9sy1HkJQ9cn74Ez0WaCpHvC8MYb9OOi7MeIxcregVL/f/wvSl3jPblqwrTP0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?exwBgL4Kw8DZpJes+9jwFvpd3yhHAwEpChMTJHYdSMJdB9A4WmcTNvBqOlLY?=
 =?us-ascii?Q?y4NUBmCS0VnNcrdxkODPZKpqh/s/Sorsa9C6SckaYLmEqBiHMipX9rzfOri6?=
 =?us-ascii?Q?Ey6kjecYmNLXx3tJZx8xTRu+YHAuVPXRlNc8xRfDFTO144a55QuE7qMSip/K?=
 =?us-ascii?Q?TTTWEDLcLUdmGzifhyOBEjJhmls60RXzB8VwBsTPEQyIToC2vD79wI/5hz3I?=
 =?us-ascii?Q?rcjY8KDqqW39mXYwftb1N37+pLydem857rFnZY5D16XZyUmALB4CiMGoV3Sg?=
 =?us-ascii?Q?L5WYWCUkyYfCbtwq260oqJkjnTDIV8UyWGqrzxSdRLo/jWwcaxEr5x9r1knt?=
 =?us-ascii?Q?GpvlhDtaB6Mknq5gU425eqxCuzK7ZEFVlzXqQ4Ee6iGRPcPuccXHX8XXNTLj?=
 =?us-ascii?Q?EULe6yadeSS6ocrFO8xPKfXvDbgOV87Ufza+b2OtH8xS7mffDFGmk+5izfnI?=
 =?us-ascii?Q?sjNIY8Pvym4ASr+81OSuYYa9VDGiGzq8rUbIK2eqsuok6lo8CX8zjmEZHFMU?=
 =?us-ascii?Q?nMj8m9zLf1W9D2RuNUuzaKtaCB93vWR3MD0t9ONB89VrNuIpt2KtoCsXIscW?=
 =?us-ascii?Q?3zbRInexio95xgZb09kvphBopA2ceNK2ytMrJe4YuXOmf/WFFcmR1+8XpESn?=
 =?us-ascii?Q?JrotTbCwwSMBzwODvko7sF86uSBECI2XOOLdebgoGAma1LXO9RNynP9Xoq7f?=
 =?us-ascii?Q?eXSrOACmKpsXlqvKaXl3IvNNeDbDf8tPulcLEZS276EZEh7U80bU79J2TExR?=
 =?us-ascii?Q?44iMTQ9TRJ60VnPTqddw42QleESQvJ7+H5xfdnfvkgwbL4IfgkpS8nPauJg7?=
 =?us-ascii?Q?cSdgy6vDGexjZqSqdiDxBkNXWN8Paz1Pd5fAE40EeVqorvd3qjXNaVFDWC5b?=
 =?us-ascii?Q?TpPDAnWbXdj5TZzuvrsLXIRwEvVwBF/uNx2DXqShcnePtIJiQ6yIHyuzbV3I?=
 =?us-ascii?Q?9zVPMz6Vc2m6dyIEiWcMjWIbj/FJsVJsOFh6E19tSHVEcOtwvrz+QmgMaReN?=
 =?us-ascii?Q?e19nwkAxN+dF25uoPV89CQhmQ8m7+E2E6DtpQTK/SdeNoyctxpUVkeDsbQ9K?=
 =?us-ascii?Q?UAh2+abuVuX1Ek3F80+Bfjzvtay81rKm6lcGI3JkBDrGoLUgf8iCbnp6mxfX?=
 =?us-ascii?Q?g/jF4ufSUaUTcPVota8DwlQUxGaZdCbDsRgFvEUxIDXN0Vi9zU5cFlkvGAmf?=
 =?us-ascii?Q?S5ftr9jKEt+ids35PBw8trMl0lpMh7SlyyioslBZOYV1EZ/bMM8lqXzWAvXK?=
 =?us-ascii?Q?xtgXYXO9iLv4YDydZKcB8s6PzePxSMgakN8v0SLzjjrLfMGuYd+8nEHTb9D2?=
 =?us-ascii?Q?iHZPwwQHhXJXCE3JyWBsV3HwIONU0nNg7kZfmle2H929ZrgO3YI/Rqmdyc6+?=
 =?us-ascii?Q?g4o47C8z2ftgSw7xXk+aP0sdE8m/qYPvBZSPpzg7/MRyCE0qdVICosUIrZSN?=
 =?us-ascii?Q?dabfDZ5+XBjQfiECeq6m5H1kcLKx4xqkP6n9cXKUCijn4CQKrO9YvN/mXVEA?=
 =?us-ascii?Q?n9e8b2PXEdxI+9+CS25TvwxoKohhF1cuby0foDAaD9MrX4dCbefWqEgzjBSC?=
 =?us-ascii?Q?ek5ItoW2UZtDNNY1ANxkfvG1SGVsnOvn1F82xRL79PDERWQIN3/xXz6zd3mC?=
 =?us-ascii?Q?/p4b4YwZzfu0t/zepOLtcZuvbEeC2gNRnhMtsMahAIad1TovIv9Qsp1a/8Lw?=
 =?us-ascii?Q?iEQNR0+MvqWpLqKIL02rrYBqqsGFU/eRP6SkK0KtZv/3VVhB06C2RocOsqcW?=
 =?us-ascii?Q?AL03TGB0UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	buckBhu/196lSyLs502q55LNDUpLzaIF9PiAyuKSAMrYlXtv+Lhc7Cfi7pg1xPe7ajwt/Xdi5ErjztWNZRy3DLgR2hH5RqHIgYFd3+smyGFMjxBJOFPWReHhHgi3C07V3ybUcayrypuHy8BWJQjYpNME+LuNBikwpGHoYx5a3a79kuseMRluIu9i8oaNHeeJDcP9K99Dfr8oCSyQRIOYrFetPyhusT6DJy2Rm3efRybE3p80QG9fGBf/gdGzyhF6vVOSNuxowlBKLQJHOWybYU0xIPuGHhQ1Q+ktxAM0NwJ+ppkXi22CBJdh16nNx3LNikmLhdGO7qREUwk+hYIehw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e5ba8f-cb1a-475e-41d5-08de9171603d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 11:08:46.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVYmKeF8CJC2KbuYjtptumJn5U0b8LpglvIbEOcAxPJOPkVqxIPKgxOWgY9F3w+Ry+RFxQZvtIigLAAwTbWfDUZFzmzU+PuHONThfQ3/ZTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-Proofpoint-GUID: 0BH69ldN8N2tr1y62BCCBTS0FgzOTu6T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA5OSBTYWx0ZWRfX3bgmh2kEa8U7
 2Z2VZGIsl1Zp1oyxWvl21pm0zfdV9KzkkHbzM2puKR+mRduXAySQX05HLXEVd8cE2FEkWKo80Jr
 tnB2M42r3IL8/GW/CwIfCNAEY5hoBI4ZAClEUXD1s2BdG//E5l+icXIdwRKx6gncLd3UiYUh6OZ
 KiYhZoGBgxLLKS2L8bwoQdsFKM0K8JW/WC8PJAwhe99BAt17qqAjIn7djePs1G7IfkURSMc3uRP
 7mdcvCCuahw6UIwt4RGYxw3ku3bhB/WgwViEKsJIQraVHyLDIrPZ3gPFRMnPISg5StrDbyoWEyA
 NZo9jrWygjr8z29uNG5BcVUocD6aG0yjbWLQzoOgBOPN0TLARvvxJIsWTDlFHJzNBn8QOc7ZWlk
 50J7fhGCGqHwlSWd3jYzmOS8VgLDo9uNO9FvRt4EDoDlYp3RhOSNM86Ew3hieISZTTUz5OhQ8yn
 d3vY37WsNefWNNcEc5Q==
X-Proofpoint-ORIG-GUID: 0BH69ldN8N2tr1y62BCCBTS0FgzOTu6T
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69cf9fc5 cx=c_pps
 a=jolozQ03zpjfpn/maDJ7eQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8 a=lAgNKBcoAAAA:8 a=QyXUC8HyAAAA:8
 a=yj-aMKAYKbz0kkd27lYA:9 a=CjuIK1q_8ugA:10 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030099
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274989-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,leemhuis.info:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Guocai.He.CN@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B39B439390F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

No, The mainline have no this issue.
The changes of 0c4f1c02d27a880b is not in mainline.


Thanks
Guocai




________________________________________
From: Thorsten Leemhuis <regressions@leemhuis.info>
Sent: Thursday, April 2, 2026 4:56 PM
To: He, Guocai (CN)
Cc: miriam.rachel.korenblit@intel.com; johannes.berg@intel.com; Friend; Lin=
ux kernel regressions list
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On 4/1/26 04:28, He, Guocai (CN) wrote:
> Johannes and Miriam and all:
>
> when we test on kernel 6.1.166, find a deadlock caused by commit
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
id=3D0c4f1c02d27a880b10b58c63f574f13bed4f711d

Does this problem happen with 6.19/7.0-rc6 as well? That is an important
detail to know if this is a general problem (that needs to be fixed in
mainline) or something the backport caused (which mainline developers
might not care about, as that is the domain of the stable team).

Ciao, Thorsten

> test by command "rtcwake -m mem -s 10"
> It will hang (detail please see the attached test.log file )
>
> I revert this commit and it works.
>
> #my analysis:
>
> This creates the following call chain:
> wiphy_suspend()
> cfg80211_leave_all()
> cfg80211_leave() # takes wdev->mtx <- LOCK #1
> __cfg80211_leave()
> cfg80211_stop_p2p_device() # <-  NEW from 0c4f1c02d27a
> ieee80211_stop_p2p_device() # mac80211 callback
> ieee80211_sdata_stop()
> ieee80211_do_stop()
> sdata_lock(sdata) # =3D mutex_lock(&sdata->wdev.mtx)
>                                    <- LOCK #2, SAME mutex!
>                                         DEADLOCK
>
>
> In 6.1.x:
> cfg80211_leave define as:
>       wdev_lock(wdev);
>       __cfg80211_leave(rdev, wdev);
>       wdev_unlock(wdev);
>
> but upstream, __cfg80211_leave is renamed to cfg80211_leave.
> call cfg80211_leave directly. so have no this issue.
>
> Do anybody meets this issue too?
>
>
> Thanks very much.
>
> Guocai


