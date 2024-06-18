Return-Path: <netdev+bounces-104424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85390C790
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827FE1F23C78
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4342155356;
	Tue, 18 Jun 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hkOfehrF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2413E409;
	Tue, 18 Jun 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701448; cv=fail; b=mXia2jM32uGmyItSsD01ZIgR4fPT+9C5GDCPfCU+y2fs3YZjS+iTDHY0PfAXYt8yOgsGdzY2mYSAfFoTmJGdMiSaLL8L3vOX5QVsnCKyQC6wmtdwlUWTm/hfwQeYm3GRJ+W5HiD9/n3z2T8NeoRUujhe1zrmHLkDjYewaMMHKj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701448; c=relaxed/simple;
	bh=HYwujwSgaRlvsmy9wSWjcrtkYsDGWtxXqNjEcRx3xvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLSofkNj5Yl/da0M2SI3xWkJq83lvpdYRYaO/e27DkZzDlDKtUcb2Cwy0LeMLUy8Ny1Q3GNCk67TZ4FnSkQJGspRPlyfzQJ3WUAA37ig7dV+o5C5iH0ziM+M+Ee0mqwHdlOCNAlcDjpiQhTy3s18AqjVCjv167c64a1wW166UMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hkOfehrF; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6LSnS017844;
	Tue, 18 Jun 2024 02:03:59 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ysafh8xpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 02:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf/lrSFVPFjiV1qd87yAMCKIJjeqOElUtQzb/EwF3ZTbYsSi9O0GrRMIUW1c69D0O2MvsReqriOTmMbWl1HtrkNBzEHunbyOaq1N5xdY8Bdf2y00CZejY43vdq3DMDak5FHCzMgzs5HALi98WdJ40AjFdNbzqp0OOTQgZ5EMhFpsyVX/Co/jgTPoozW2IQpuZ1euwEP0Hm1jrOU5pKDYyy+4VD39xuMSKmDmiLEPJUoxtZ9YC2pKQPBlQRNNVo5AM0aF2tMMDUicqAa+4+3SHRLlSsQgPWau77HtS91b/YGVUUUSf17s40cAHMicou7VqNuZLyJTDkwmmszPx9ciFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ8X2B3ZP1tcx9ntvv/0Wi3HGEzxAuMQ7F4Dc8ooeeA=;
 b=bN3ln5+d9mPFNGbr44cOuIGmeQMqaTHbcHah80aMjvR4cUqqko3SdOPd0+3+JUoeoPwIc+qLG+OOOFJtm7YrZ8ikpyRcqsXWZ1JlBYLnZU1go4UZNTaMLM/DL3VcCviCqdW7LPPZiQjNOIKMYE7olRaACBZZWht+lreTuSzidjZ2crlSvBe5RNWug6+7oZEGMVy1VDuuBvKV4Uxtj9x1mjYsYfY6/nMeNR33zlHDtm77dKcgkLdauZJv0BBnu6QNlnc6Glud3MS+CnRnG+uyiuTK/5LHrNYSpWRSPrDMTo1RMw1vvLBblaQhDkkEifNRN1Pv59ahUkCay4QkcfQZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ8X2B3ZP1tcx9ntvv/0Wi3HGEzxAuMQ7F4Dc8ooeeA=;
 b=hkOfehrFe+1C33P9BG+xTLcOQ2nWFf2d35273X7Qpe7NywhaI2lGbH8UsN5ysghjNxOhieYZ3RsMRkkUw/t7gp2l6nDglQm3mulYgVquynejAUl84kuJAdB0ipmteSNtqh+8zI84fBd80zTp3k0Y026JDCWCe/2v2adal9uC6wQ=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SJ0PR18MB4883.namprd18.prod.outlook.com (2603:10b6:a03:40a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 09:03:55 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 09:03:55 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v5 01/10] octeontx2-pf:
 Refactoring RVU driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 01/10] octeontx2-pf:
 Refactoring RVU driver
Thread-Index: AQHavBuNXlzMG7MvKkmt+IHL28PMc7HIsnwAgASPyxQ=
Date: Tue, 18 Jun 2024 09:03:55 +0000
Message-ID: 
 <CH0PR18MB4339625085013AAC5E89B16ECDCE2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240611162213.22213-2-gakula@marvell.com>
 <98cf0387-eb8e-492b-a78b-b21e3f6dd7e3@web.de>
In-Reply-To: <98cf0387-eb8e-492b-a78b-b21e3f6dd7e3@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SJ0PR18MB4883:EE_
x-ms-office365-filtering-correlation-id: 4f80d8c5-e168-445c-b0b9-08dc8f759512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?P668X6WwJeqilXyJ7t3UceAjBnFijY/JhaN9xMcaScCfLrI8YcLgiSc/?=
 =?Windows-1252?Q?lFpq07Tvah7jUBG9imLJLAykW9bQT3axwvailxmAmkreO0Un7Wm4CEC2?=
 =?Windows-1252?Q?NMFphg+O0lWuDwMDSoO6+XgiNSGecZrtWUVlqvho2nfZAuW6WYzs96hy?=
 =?Windows-1252?Q?1geRoMY8SY/J0hpY4N6vh+jUr+Z+Vwuat7eaS9ZAcVVvHml5drNqkuUA?=
 =?Windows-1252?Q?72IRHexcETreMDv2lAFJFZQKNwFtr1JQhI3DMtoXG0aqHu2QTGV1/Jzg?=
 =?Windows-1252?Q?fdtRTRNGTlJMwSf4vK4+iV6ijjbV5k9M7/x4XuzooBt4kRAShVUgnuzd?=
 =?Windows-1252?Q?9pLZus8u0GOPKt8sIlKKQUGQ9nNeCNpPaGNShysoAhjYMJSEk+i8n829?=
 =?Windows-1252?Q?6PC080BVqrQmg6EVb/FjJpxipCOri7YjzfBcBkxagZqmv2zKi1wk+nuf?=
 =?Windows-1252?Q?UWa7Wh1QhYHArarRS5goOtQXNaQt05ygEFzt6tW+itH9yqW3Do9EWSLJ?=
 =?Windows-1252?Q?fTNe0MtbhMq54JMioerCrUwH6ayk/HlcXrf/LpSD92F8a1z7JmcyqLfM?=
 =?Windows-1252?Q?KTKGb2x05wwf9qMHDjJi6yZ4ph4Py1nPXE7hUe1t6w5Dee96Dmy/2xRm?=
 =?Windows-1252?Q?Uug6PL3h79bFu9BccjRFrRmiUxNlBBodw6Sq76w6KopQJryLYsTLT7zu?=
 =?Windows-1252?Q?L2XoqGC5KlZd8PtI/cC3P/1Nh3/CoQfs/t908uIkY/oNUYTS2MpbTiuo?=
 =?Windows-1252?Q?+ktJl8v/OC3oZ7b6Cg3lWdiPLEG22l8BZqgN4NRQsnsrkbU7MFBcoHTz?=
 =?Windows-1252?Q?sdkdQoj4ufB8zPOzvzZvBN5cJ9kjtSj8xr34J9y6HVG40AANZVBpBz6f?=
 =?Windows-1252?Q?oIcyfyqRxDj9TNqrDOuZG9mRudUXECX7+hFaTLb7LvJ7qFEtpWUmyAfw?=
 =?Windows-1252?Q?j4HWeK9jkt+UHEmnOnhWgjAaOue2lWuH47Y02Te8mItkLmiqReiXY1HZ?=
 =?Windows-1252?Q?h10HboludBgbepefrrFElgYbpIQ6cWtNUlS8IM59953NfYg67+P8WPyc?=
 =?Windows-1252?Q?KOvNGxje/a8z/mccOhSnaNRU80ttIKJDlGLlNhCJfB60hh072pFEB51v?=
 =?Windows-1252?Q?CWz5SRYv+cuhxjWGmWL5zVoV7ypdOWti8tlVa+nswM1+27r3AruVJ+3t?=
 =?Windows-1252?Q?3Mjk0aFr27ySC9nfda4ubHmzFMbDTwgWaZKqAtyBzsVaL4eBPoYes1UH?=
 =?Windows-1252?Q?+0OkHQC+mgcrrpi+uF5gfR53Kxq3HPjNkOqASl6+TogjGKYpEfbbvnol?=
 =?Windows-1252?Q?zlTB36drfFcWIK+cs4YkQqAUMoJTjBwqpcGwHRdk76LHScXzI9MdDOIS?=
 =?Windows-1252?Q?cp6QRXY76HycXu7ydkZyB3J/6GHTbyvCGR1RUlRR91+8eahJq+8i933B?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?mBEC5hOTLoYep/fIQMddUIvhDMMrSxZyPcpQ4JxurpLQPfab9Wop5hhj?=
 =?Windows-1252?Q?VM9PCla4b7i9eCC5AaWjKuF5l38+KLxa3mYRJEgbjj2byyoTM3CYwWn6?=
 =?Windows-1252?Q?O29CIAH3TdATCdAgTq7qT7yXhhkc8vZvn7jztOhi5kO1rH031Rmjv7xk?=
 =?Windows-1252?Q?4D+KgzC1H0OC7CRRxfVmfBChr9fm6FrRU5AMNMGWr+/LjgI3VEIDUwWc?=
 =?Windows-1252?Q?RM4M4RFWWXJxly/WK+3FUCHfs5D2u8T8leXZxhqgeM9aeMW14IPfr8Cn?=
 =?Windows-1252?Q?tdPevQYW7j0ZJw3Fwi5MjM4VPfbrrInCyTmbrTQzmM/yUZEkVkz2T4Ae?=
 =?Windows-1252?Q?7lUabZnp8kjIlR37txWPMnjmcX+6AKSSlyS31a+ZClVmtNqADjZmakdi?=
 =?Windows-1252?Q?CV/K8kom9k3NTp2G06+Qb1WEiZgg66w3elErb9+uWWs5dhmEx7xHgV3o?=
 =?Windows-1252?Q?I8/wcry5LwN35CPRfdxKbctdTNApnOZyJABKVqex+TzYz9f88KOKWW70?=
 =?Windows-1252?Q?ZuO5LJFZemnjBg3my64Z5VT8CJwTDB+eyOymkqYETbI2IJ1hkT1grLdV?=
 =?Windows-1252?Q?Bot+Ys07FRL+pL6IEWaoxs60vK0Bbp+zvJLUnr0VR8AjiSEL9G5jcrQg?=
 =?Windows-1252?Q?fYmXs+nugy9wam0j+QH6fk8ftOblJccYuJX/bUtCQ6dPZm8WOYuFCNWd?=
 =?Windows-1252?Q?x4pDTVE23A5totasKflBsnNnGRt54lxTL2FWqleBAQoBpMWJKunJevgj?=
 =?Windows-1252?Q?af2zmmUjo+wbJ0zNphzSqsatygK/5BYGol35WgVZeQ3NYuBU5Q1yzgdl?=
 =?Windows-1252?Q?jvvkSgrX+82EJG2eVTYX9KYYYZpYgyIeeYToTlFI5WCzI1koYTiL2RZt?=
 =?Windows-1252?Q?4m21L1MfHluleUOyDoBP8OsZdx1ehMmTQVRZiFJR/WNk/tfUDoZQ+J5m?=
 =?Windows-1252?Q?kOFLo8q9pGjJsoid4E5z/Ge62am4mw12YtHE7L6hnUZuZ7SO2zm8T39H?=
 =?Windows-1252?Q?Hre/ZJiFRGFJuXa7/u+7LNW6rHGAVDBY0UA+RBg+fNBdVb2lCBHshiDO?=
 =?Windows-1252?Q?jE/XLWn0cNxSBt+cLQ5Ex/sjlnOYnaUOsb2ynucbm0Xj6/1J8VKh53x4?=
 =?Windows-1252?Q?3Llxs/ngHf2mh/jWMKulCGSjG6Ri2AuIfTBakb5m9ivKFczMfrg7CSSi?=
 =?Windows-1252?Q?2N3xOVvL5E5FqSjcJibs/RnpDOgIiOsrwfs6dyf5yBqMW74gKg1EMS99?=
 =?Windows-1252?Q?/DZlYh5EwVUo+JqZMQFx0II3utT2E8UvJcw8bd/Ir9IXTd+8Dlft2VLN?=
 =?Windows-1252?Q?dJpF8HcbQp2PQ7NJ3UUrctsnLdJ+ypBh38DtRLEc4tlsjUErwpinqG3w?=
 =?Windows-1252?Q?+v6GnoC4qRXdj3DyvYuuWHsnvSQv5j7ETvyUSk4G/p1SQjIDXUVt3qR6?=
 =?Windows-1252?Q?WjjwjHG2gOrQIUXI2+hlf0k0Av/4c3JZ4y0Z0RJWxtL5LbT4Sx8UlH3e?=
 =?Windows-1252?Q?p3mydIYItVJOktluVmGCNxmroMt8saHbn8XlminxLapguvutHGzFQB6f?=
 =?Windows-1252?Q?Buk/UckILkkFWfMlqSAumrfHF7ew7Wqc/TISiX2Had5clS7bECPi3fb3?=
 =?Windows-1252?Q?CdsI7V+kUS3EJoSAIxYWB6ekBImcOdD1kQ90SPv+Cq916NYO3s7UdhQ0?=
 =?Windows-1252?Q?TYh3WAgkrS4=3D?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f80d8c5-e168-445c-b0b9-08dc8f759512
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 09:03:55.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzsMRUpuEeH/Aaaqu9LB7MNzU+s6S/ps1qgQvJJSEO6Y1OJeDnhX2Njs8Aeiaj8wRIDQTaYN1jWIT3bRvHZFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4883
X-Proofpoint-ORIG-GUID: kJnvfRhjNZ7Fld_Drw6gJxVc4KUrcOGj
X-Proofpoint-GUID: kJnvfRhjNZ7Fld_Drw6gJxVc4KUrcOGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

=0A=
________________________________________=0A=
>From: Markus Elfring <Markus.Elfring@web.de>=0A=
>Sent: Saturday, June 15, 2024 4:45 PM=0A=
>To: Geethasowjanya Akula; netdev@vger.kernel.org; David S. Miller; Eric Du=
mazet; Jakub Kicinski; Paolo Abeni=0A=
>Cc: LKML; Hariprasad Kelam; Subbaraya Sundeep Bhatta; Sunil Kovvuri Goutha=
m=0A=
>Subject: [EXTERNAL] Re: [net-next PATCH v5 01/10] octeontx2-pf: Refactorin=
g RVU driver=0A=
=0A=
=0A=
=85=0A=
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c=0A=
=85=0A=
>> +void otx2_disable_napi(struct otx2_nic *pf)=0A=
>>  {=0A=
=85=0A=
>> -             cancel_work_sync(&cq_poll->dim.work);=0A=
>> +             work =3D &cq_poll->dim.work;=0A=
>> +             if (work->func)=0A=
> +                     cancel_work_sync(&cq_poll->dim.work);=0A=
=85=0A=
=0A=
>I suggest to use the shown local variable once more.=0A=
=0A=
>+                       cancel_work_sync(work);=0A=
=0A=
Will fix in the next version.=0A=
=85=0A=
>> +int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)=0A=
>> +{=0A=
=85=0A=
>> +     return 0;=0A=
>> +=0A=
>> +err_detach_rsrc:=0A=
>> +     if (pf->hw.lmt_info)=0A=
>> +             free_percpu(pf->hw.lmt_info);=0A=
>> +     if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))=0A=
>> +             qmem_free(pf->dev, pf->dync_lmt);=0A=
>> +     otx2_detach_resources(&pf->mbox);=0A=
>> +err_disable_mbox_intr:=0A=
>> +     otx2_disable_mbox_intr(pf);=0A=
>> +err_mbox_destroy:=0A=
>>+     otx2_pfaf_mbox_destroy(pf);=0A=
>> +err_free_irq_vectors:=0A=
>> +     pci_free_irq_vectors(hw->pdev);=0A=
>> +=0A=
>> +     return err;=0A=
>> +}=0A=
=85=0A=
=0A=
>Would you become interested to convert any usages of goto chains=0A=
>into applications of scope-based resource management?=0A=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootlin.com_=
linux_v6.10->2Drc3_source_include_linux_cleanup.h->23L8&d=3DDwIFaQ&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DUiEt_nUeYFctu7JVLXVlXDhTmq_EAfooaZEYInfGuEQ&m=3DWq9Y=
J>y75Hspwe2mx3fN8YFPaAxSUtmgM0Q8XVmIg9whiPwJenparsxf0LX9-xCkV&s=3DRv72FUI-w=
GHavNlkfj->jThXTxMciifdWbwE9njT5PtY&e=3D=0A=
=0A=
Regards,=0A=
Markus=0A=
=0A=

