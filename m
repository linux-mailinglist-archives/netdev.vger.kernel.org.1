Return-Path: <netdev+bounces-105555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C0911A2F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F37C1F21598
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E512D1EB;
	Fri, 21 Jun 2024 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="R5J9ZmBj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBC762C1;
	Fri, 21 Jun 2024 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946718; cv=fail; b=fwImzL73IyThY/A6xxQEqt/G/OuAHhyKMQ8MhpENW7N0V91ykzMMgwD8QqFCuZIeK+fAQ0hIGpDKIS0Q6ELAYs3G07ok6fbIvEhdwH1uxW4goTncvNu/AFw9HrIVBAbOO0eO0W4hp6mZEqpGesl4AJAKlYa/u/wdtfbeTtnREsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946718; c=relaxed/simple;
	bh=NcgNhEQ5EkLgwZBHuCbua/9zGlVAWc2o9ZYGTS16wwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMFQTQKzNU0vTGHC3G4LMYdQAWvq/6jAWm+n7EM7vePhzXEyNDQC0jdqG1H1YIGr9HjsMlXlfrSoj78bP/d1SVpHrcucCB1sp4u9+4mJ1ZVjH+EAH0Bci+gQyY+ACOXDRkMrjNuvDZ2rABa3DHuCvRjAPNjyfIZWAmXsPv1Dg30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=R5J9ZmBj; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L34ZKG024687;
	Thu, 20 Jun 2024 22:11:43 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yvrj7adta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlJALCJfP/ooG8uE557sxlN2+NMXGKPILLweKxLx4dQG29EvRXiRqkdac/NdOp1I7/Tpd1PQMo468gcLe2dVqp/0PS9ZM0yg9/5tza/3fWm51FxltyYqbUgwbUfCTz5ntk64Z/GwQiN0gy9tFHtvXMb2Hff6L5udTY2Be4hmwO9JiPVmQ50apj40ocZYFtLGjV5DkpZ1vMxdJBSlO4CNYn/G3cyPAObLqKY8YalUH2U32M8FdxvC0CBwmJl8K9TnUOb9AotZv9QxRrRRyDVLQbekhjSvf2E8zokcEemeEUn/Z9RN5M+dw87ZZG69q+QMZXPlQX+m5x5SumsOvaGBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHcVrKMskrWQJ0rgP8/NvrIfWT4dD29qXpbpIaoGbRM=;
 b=Xmr3aU+Wu0O0ge1/nIS2aLCbrzMimcAB6rr1+jVp4BJ8TI4GkRqxLqGH7w3Ks92qsWk/VVUvacD849w3mr5sFq1FbhwDtBq6R7JCpq4JHlvXKKFO/40a11S0bDkbIt2QWVnn78sfMt9AHrkdwwbIaiqgtnoA9brtZ6r7SqYT5QkNIBAqoKCB2v0kPAFUZcgbpgy57IQdKJ9nJp+KwuJ0RQRDR23ttMXdMVteA7kyglEVHD2duWweq6c5hQw2CHfivKxmCz3eyUAPvtUchWRaGUI1W5kk8IDl8bgRbBO7US02Wm4/TbaKgaQY7DWBX4XqzHdbzDKsBRB/tQm1xAKMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHcVrKMskrWQJ0rgP8/NvrIfWT4dD29qXpbpIaoGbRM=;
 b=R5J9ZmBjA4QqKkBKSsuBBPyE5oTNUy+qSjD570SWRI+d8M5ICFIuRjz1G+ygwc5QBhZM9xPOtwhQUsbAkESR0HoG2IZ1aVIAVG9NNW8lml0sxP44RS6m6IAdevjtr9irArOhAdCti/pYeX9Q60X7QMDKMXcjiv7cUfzZffFNibw=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by DS0PR18MB5523.namprd18.prod.outlook.com (2603:10b6:8:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 05:11:41 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:11:41 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Huai-Yuan Liu <qq810974084@gmail.com>,
        "jes@trained-monkey.org"
	<jes@trained-monkey.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-hippi@sunsite.dk" <linux-hippi@sunsite.dk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: RE: [PATCH V2] hippi: fix possible buffer overflow caused by bad DMA
 value in rr_start_xmit()
Thread-Topic: [PATCH V2] hippi: fix possible buffer overflow caused by bad DMA
 value in rr_start_xmit()
Thread-Index: AQHaw5mAhppg0aEcrk+X5BO1h+mf8A==
Date: Fri, 21 Jun 2024 05:11:41 +0000
Message-ID: 
 <BY3PR18MB47379D136DE21EDB8C1741CAC6C92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240620122311.424811-1-qq810974084@gmail.com>
In-Reply-To: <20240620122311.424811-1-qq810974084@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|DS0PR18MB5523:EE_
x-ms-office365-filtering-correlation-id: 4d5faa40-12ab-45ec-d257-08dc91b0a2e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|7416011|376011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?XLeDdgr5CkAF4RQ2MMX/1r9jXGFNXgLDoKB+4ipbuPXugljPiC8SJmwy5Zms?=
 =?us-ascii?Q?aU6RQx6Hdc4iYw9wLGRFy8l30+tU9E1AsXHmjRphMysYpjKeufMhR0j2CPn0?=
 =?us-ascii?Q?ORxNhESE1njqWIfGapu47ptyCPT4fHbqr5oDdYGfiVI8FlmwjJN+Xm2A4w9Y?=
 =?us-ascii?Q?t9038gS2W+1vJO2XilmjoJl7MzdIkzFFmPLOS9X+Fhip1ZjbHzLr+zraa0XS?=
 =?us-ascii?Q?kfQyY9Xr1z94BIrX9pLsEvVgj7WU2thCrHzR9arvTjE5v2Tbi02ZtH1UCBk6?=
 =?us-ascii?Q?PJ9wDkkAeVMLgAKcK6rCu0FPZ7pAzj1cjBGc4A+maxE/CIsF5kO9ZseBqQ4M?=
 =?us-ascii?Q?DZEQNKYdicvlxik8dlOg8rlpBR5UUnRuHP0mk3CzOW/lm6Y/sgVvzyew/7RR?=
 =?us-ascii?Q?aKTX9bl9Hy2dzXqgl1G5YdcKax9jUKQa74pWXbBSVFqiezBisOj+eXMT/3EF?=
 =?us-ascii?Q?dhO9V+RlMNL0KS2yQ1Htfrw4woQ5TYUHRpncSy25Ob+qcgL8pV+FIY1JrPvF?=
 =?us-ascii?Q?zhvqU2moVxCDFOXCpqcHKb3Q3urKwUQdRcNn0L/ghWD5aQ9kJvKllRzjE1yz?=
 =?us-ascii?Q?GHv7q7GwuwJ0ukPCDOl0oItsKndMG756HIIe+TiAAUmhZynEdpXWfPcScOqn?=
 =?us-ascii?Q?x1OV8cuAKgWgLucS9mOYQ+67YOHTT4+6wrGsCstCMMRVkSpbQuwE9AMrXcgu?=
 =?us-ascii?Q?TFB1103RgKpSSICC1Z+WG4khnc9rl1BoRLulpErkMtouzAXrQRe2GMjeAjbd?=
 =?us-ascii?Q?WiBCLbQHrEwTg6Bemcyzf2ognW4GFeVj4AFGN/05uU930xlBGFBlbyN01xuK?=
 =?us-ascii?Q?VcKTPw+L4am0avm7uZ26/Z9UnNjJilySeMv0/JVUFcElw+ZcSrFCCfap2IEV?=
 =?us-ascii?Q?j256IJ35xi+2DWG1WPFP0auUUX3O2M1onN5ZMldUJAlmnvJgLt+WnxdBAVdN?=
 =?us-ascii?Q?q1FwDRuM3ntBKRd2VASFrMGgHjV9twyvEmkfYm3Vk1a38bcrcXAr6DnxfWhP?=
 =?us-ascii?Q?2SJRRSAqUlm9IAuTXqi6SaFDTCJzZKJgNUFvp4F5QfIBCp+vAxfWWozj2H3a?=
 =?us-ascii?Q?z29TdRs+PoQnC/LK8vbveP6uOnfKisFrJjN2h814AyWkeRH/lPKOYeA1Y7x3?=
 =?us-ascii?Q?cr+5vKX2Rq0/3aqLK5aVmak/7BEMqeAutaIOVoxe42LltMbVWfYIwUzJpSKx?=
 =?us-ascii?Q?od7epmYowcjTnDHNzIubVn14VdOFlYKbBmRvfLtE4x6j3DGZStmBJ5Z1rQ1F?=
 =?us-ascii?Q?YJ9eIXdOO/8cVWU9yxxa25NgJVcRMbycPjEumXwVoDKKRQW2qiENUqk/gnjY?=
 =?us-ascii?Q?O4prECdzy6ZoZ7j7QKzhNLjdhW2y7OuR8BJyvWcvZ82otxGpC1ZZBsQ7KcKP?=
 =?us-ascii?Q?xFUBgv4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1X996++7+8/POaJ5jwBYuSHiO51FmAbSF/eAPYjVg4B8wkWgmAAJfu43itP0?=
 =?us-ascii?Q?OjNNvGnRbOp1//rtaAB/FGFsqgqYTx6axwKSpaqRb5KzOI/Ri32H8v19+U2S?=
 =?us-ascii?Q?FjT+sU7s/MN/3w5I9sWqcT8xrSmseh2aCHs3TRTmXb3SEgsBw96S8XG1W8Bf?=
 =?us-ascii?Q?8g964YN8IUC4THJLQZ2cBoQPwEyubDnm4ZuK5p6Lzf3rlaoHom22t+pJA1jY?=
 =?us-ascii?Q?NUwPrT/5WtD7LbbNoObHQvJLwXdlXTLDVk0QIt9h0pheZJOiXv0NKNtPdAox?=
 =?us-ascii?Q?U1NK4S+y5pPwd8mQ9w7BD+IYpZj9NAzQ8IVG50M8O+YempP5oyWpDYTJjZrC?=
 =?us-ascii?Q?RHm+ZDGCncyUFf0BJs9z+Mrc/DNUiunGqH5DdmYAwkM/RIa/4yokaMQ/rQrV?=
 =?us-ascii?Q?My069qarpb9i667JfivpPY8lzngtnVa9CpheO9VZCuqkPCmgndYPUHa+lEmF?=
 =?us-ascii?Q?ubLeL8KqRPw5gjqRLP39e/J+AwEr8FahokJcB7mCL+W4EpxGNiHEiS8zrP0n?=
 =?us-ascii?Q?6ePKxWzskEzSBDs9Awj0Irz0T5sxoZoqiecVhWh3vz9JHLG+gfjY1siJYcXi?=
 =?us-ascii?Q?bH5uwLkJJw1YwanqvkYG+5sXyqmKIpwRBn3+vl8h9vSm+rKmOQEFfN0/CTvg?=
 =?us-ascii?Q?uzoS/uOfJ2iCCXuaAZ7COTmLp/VSFa/Z4PnMWKPKgy3vHLWaNclP7XVgKVhP?=
 =?us-ascii?Q?R4GmmpwGKGN1ruk8GRweRKtvTbrlwlKyOOfEG36MgReOCKnUQejcq+1oHeiQ?=
 =?us-ascii?Q?xZ4XOOGoc2JDg2TSXKnYFzaGJm9EGNLA6lzuhtjxSpqFpVEXzfpvRfY+FBnv?=
 =?us-ascii?Q?G0+mi++h5f5EA7XNfuPcNbGbppSmQ7APRgirv0hCi+7+H5nzDFGZufs2d7XY?=
 =?us-ascii?Q?er+E5JcGwLW8R9AQ0EZ7Zo99/CjSP5Pbtt24usVPzfEWz1LtxzHkoK8u5kX/?=
 =?us-ascii?Q?FbIM0ZNZQOsiJRxqwDVjLG0wcAuepgClXlJxPsYouIe9igOUXiBI/WjY7pQy?=
 =?us-ascii?Q?4BYF7x28yKPZ9uxKM89vkL6O4STOCd0d7UkbHc+atTVB2J9NxyeiWlIGgXAG?=
 =?us-ascii?Q?GiwjTSAkkQVVEtKZBJ+NNdN5kkroud6MEXcetQR6pabQ5/M/WwOoBPNDiurY?=
 =?us-ascii?Q?YSWAWVRGvVoYrjLFoTgZ7AKZG2ISbk9oPsmLbRbJaTYIH5BU7pjczARY5W8F?=
 =?us-ascii?Q?+nWfw62OPCmLHDY2WjoWrL9nTpWOXUeaq4q8qDPEWqAxLwpcd7YPF5qGyxfW?=
 =?us-ascii?Q?HK7CjS7w5wCQQgdUNIE2lAM2phn+I4fX3vvLylvGrIvqUFDmwiwpTQeNM+K0?=
 =?us-ascii?Q?CnGxRBlPHRdbIqMC5b5lBXvfMROArbM24B68g+uk4/bVnAy2/FJF1+f7EeCi?=
 =?us-ascii?Q?LTrqarnhXxkMKwyLlG4HB7nZuAP5I1+0dvSZI7+klEROtB/9uQumXs3xFrk6?=
 =?us-ascii?Q?Ki9f0rGK5nGtlgs8v/2uf+F+TUAN8E44+bbyr+QBmavgAKIgQdIOk2+5/wbX?=
 =?us-ascii?Q?Hl22JPJQyPHkksdmCX579mmHjmvHuikwckwYo9SMNzVy/8q+UFnDEOun5hjB?=
 =?us-ascii?Q?9AmJsFnV7J73OB+i4IzmgvnqA3nYkaHvq5UEOki+?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5faa40-12ab-45ec-d257-08dc91b0a2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:11:41.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeQ24T7v/ONHRERu6kyccTmKIuAPud4hJzhjwQXbYD4Fa1mq9FjkkKtP5BU/GAZpsvS3v2zUzf/u+RP+qIKTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5523
X-Proofpoint-GUID: 2uB_PrWhIPniFUv3EMkYoC9k9yuot2iL
X-Proofpoint-ORIG-GUID: 2uB_PrWhIPniFUv3EMkYoC9k9yuot2iL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01

>The value rrpriv->info->tx_ctrl is stored in DMA memory, and it is assigne=
d to txctrl,
>so txctrl->pi can be modified at any time by malicious hardware. Becausetx=
ctrl->pi is
>assigned to index, buffer overflow may occur when the code "rrpriv-
>>tx_skbuff[index]" is executed.
>
>To address this issue, the index should be checked.
>
>Fixes: f33a7251c825 ("hippi: switch from 'pci_' to 'dma_' API")
>Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
>---
>V2:
>* In patch V2, we remove the first condition in if statement and use
>  netdev_err() instead of printk().
>  Thanks Paolo Abeni for helpful advice.
>---
> drivers/net/hippi/rrunner.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c ind=
ex
>aa8f828a0ae7..6b0056ced922 100644
>--- a/drivers/net/hippi/rrunner.c
>+++ b/drivers/net/hippi/rrunner.c
>@@ -1440,6 +1440,11 @@ static netdev_tx_t rr_start_xmit(struct sk_buff *sk=
b,
> 	txctrl =3D &rrpriv->info->tx_ctrl;
>
> 	index =3D txctrl->pi;
>+	if (index >=3D TX_RING_ENTRIES) {
>+		netdev_err(dev, "invalid index value %02x\n", index);

Much better would be to use netif_msg_tx_err which can be enabled/disabled =
instead of dumping on console,
which would be annoying if there are many errors.

Thanks,
Sunil.


