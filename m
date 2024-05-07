Return-Path: <netdev+bounces-94090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB18BE171
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9042B221FD
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D396156885;
	Tue,  7 May 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y1ma+QBL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349961509B0;
	Tue,  7 May 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082952; cv=fail; b=ApqoajlHbW6XhVFlfg7qn5yrJrJjrqvbyI8Bj+87QuITuMrUwLfzsarpdh4qFchx0fepOMgxnFOJ1sq6zaqsuO+Eb1hz/tXZ0QOwWqKiR4Z+XJZoDJDFf0ToWaONSjLHCOqL0mWL7T74R0f/RtYnP5JuYlO7hKIDxkS8VIsyHj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082952; c=relaxed/simple;
	bh=KkMyAS5agXlMrlhaWz/n41UbmBShJ3JNmBe2JwUfwMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsGc6bG33XaeY47rx0UDxNzXGXqUTjB0plt1ucKJb2YBF+20HODRCat6gfudrmmn6QJevUIe2KFx49Qz7C/wxwgBxbTLT+xWaogYopB6BEs3JZHgvNDNc5xN78BIQhPGzKuqi8AgmmfRyD/57ZrCyjrNoH/Q2ntfpNIBjxqskGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y1ma+QBL; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4479NCVW007125;
	Tue, 7 May 2024 04:55:27 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhggd96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpJAYp/gZ8V2IKKlfTc0ZWHmaiwPcEH8KcLuzUMyJhumdRbPWrsJdwVXkTxkMI3QVEFRZrTgMwIeTbgBgp9F3QphmdqeAQc9i/i8ihkEk4FQM5zf3CHAiz0R+RdJii6lhuDvRHYxShByKJLGzf9CRYYCDxM4vYttaDqBmhbNR4slxJu5MFWQIdHFocgfEpSifzrI0aX5TkMt2ZeWjEzenuOCaADRmmwLo9arnIHlko+jKU5UrP0rFT5Dy97Hp5LDy3mKhu6J95LiZbAJdCoSTHPMUR2v0VuKrM0IYZt2wo7bDkDrPtPSoZuJkDQI58Q93GD9E3UDu39mrag9CZbvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG5Yi+W7GlyCFmV7lXKZYidGndKfDWn4NGjjvHoKhYg=;
 b=dTmylTXxUTKHlXWRtDFnC0l75Yj+N3eDlewO6J3Ihi+fh8OAUJx8PAm2e1LI1rTfQAEOEC6XRIuvdofZA+GO1OHkIrKlCnymb3njkjOMax8WWB9frbkFStShmD4r5QV8ansfBRcEC2Z591hZJ5XB4YnopoA57XaOklPBT/lRLe9xfAFonuToTM8iivOTVa2kKxUbXmfLg74pqgFDLdB0OmigwhUxB+ttz14BwceWSJe7c9fNCnQlKSBhq99EDaQqZfgAJApelRIHpx93/diXH38wb52RTRB+9mRcLyBqfWqIixWUKOqFggzzfjqHHD8D21cP2/b7cIWDoTYSVpohsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG5Yi+W7GlyCFmV7lXKZYidGndKfDWn4NGjjvHoKhYg=;
 b=Y1ma+QBLuQLNr8cLKZTXDEiwxpwZilEXbUiA8cq3sZ2XiBttyCHmC/YMgCY92f6yD2AFQMoHPzhtBQhaR0zfhe3xPyOLgjbJ+b3BIxQp1Hcn+IgNbPPKyPqowq8Ki44mkbJqSIW+6k+e4f2swddGKtA5KAqMIAtqgao8mSM+Wkw=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DM4PR18MB4304.namprd18.prod.outlook.com (2603:10b6:5:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 11:55:23 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:55:23 +0000
From: Suman Ghosh <sumang@marvell.com>
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
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH net-next] net: fec: Convert fec driver to use
 lock guards
Thread-Topic: [EXTERNAL] [PATCH net-next] net: fec: Convert fec driver to use
 lock guards
Thread-Index: AQHaoF9GY7NoN4l0BUeo+37vLMNQnLGLptEg
Date: Tue, 7 May 2024 11:55:23 +0000
Message-ID: 
 <SJ0PR18MB521656F021A8A9BECD0CE105DBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240507090520.284821-1-wei.fang@nxp.com>
In-Reply-To: <20240507090520.284821-1-wei.fang@nxp.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DM4PR18MB4304:EE_
x-ms-office365-filtering-correlation-id: 88b4171f-bbd4-4ec4-4289-08dc6e8c93ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Q9EDm6k6KrnCpjkMJcYQM972LmXzRf2e5PJpp/kVx11/Md3xdDOE38L9p16P?=
 =?us-ascii?Q?esw7RXD7ykp5+yRy+3PIbXV0wa3pTwWd1a84K/kDFFU9VCfvMidTU3ZF0X3x?=
 =?us-ascii?Q?9C91tqY418IVF1zrjxUTIAEbs8M16saDAFb8jgXHkJBHcvGoB/UnMB6yH4Mk?=
 =?us-ascii?Q?fm0nzCivDgKzUpyzRyHBPKwSCY7+YPpFvxoYtalnTfDiZUhwklr7mLPyF7n6?=
 =?us-ascii?Q?iHQvo84cnJBFolXhu/vFtGn/wW5pspVgQ8U8KvS4NXyvIWorfbJI7GnYS/9U?=
 =?us-ascii?Q?GNWWoNNuD1woK/xgEzzcjjRSZDGJKjf9VCU3/edzEplLli/vKycCa1ukZEha?=
 =?us-ascii?Q?20VdA5Wm2xaJsKJ61juQyNiEOBx9wzo6iuD+5Zt7iOYHjlLIpq2rHYiXKNtm?=
 =?us-ascii?Q?ezw2USXHbBQM2dC9yZcETf/dLbq/XaFLqUa75/Gb102ujueLW0rVfrHU42Nk?=
 =?us-ascii?Q?AAARuNohsTGiCngTkBJRpudZiF9TCpjQ/15ONbVkB4NR4ySqi1k/TbsL/7VR?=
 =?us-ascii?Q?19tHD+figsn/+PocRmSHVf4uYu/VgU9FlID234gFuTtjQHd68S21xs77Ciun?=
 =?us-ascii?Q?6oSAlYUB3ef+HJASZj5+/fpugyrG+gCPnlb6qdNvnqhM0eiQyKVtEfN1vihx?=
 =?us-ascii?Q?4PQbCQH8azo5wvnhzNvhNcXDud/1SLIK1QlZ+S8d2GrLSoTlaV3TTb4leFjq?=
 =?us-ascii?Q?Vq/B1BpFx1JIi6CnXNq8xP5x4sxbS1vkYnri+kcgxeP2mnfa9fo83LUBqhty?=
 =?us-ascii?Q?5YwOMmQEX25xvUSltL9ktfSdzotbgoMIO5Lfj9EOOBgIdFoYCMeD/AAY7Qz2?=
 =?us-ascii?Q?7zSAf0F8FtEyaiqY2A3qMB8I8SyOGLf/Gc0DeazQAOCtJAo5v670W03jV1Np?=
 =?us-ascii?Q?B46wCB8kAAeZx2Xi+pMJMz3BRczKLUFvzrAh7PHZH6M55yhnB/2zblKNtHfY?=
 =?us-ascii?Q?KBg6Rv7kjot6afFUbyP+OR5/OxCA26/NTZwfPZaBFIEKPJIZPG3goKJtL8KF?=
 =?us-ascii?Q?j7RcMRaC5iHWPIUGjauE7McY9zuDaMKCLQPoqDjK9CjiuCfck5BdvP4S+7bx?=
 =?us-ascii?Q?mzUFtc7jOqYiwwVRuiwFGkAO6hPboMmhxiS3n8UtMkh4sJCLZcBstYWIhTLu?=
 =?us-ascii?Q?0CvZbxyqC66DiYadKzpV0ThBGz1+kfT+Y3GooadYIbYFXmb1fr2EBHjnn+pI?=
 =?us-ascii?Q?y3pxH/QfhWZpY0teuu9+qvFbzZ4jszrs18/IPrsFjCTnYhN1KrRnK+xCW3Ma?=
 =?us-ascii?Q?A8uUOkQAS867Lk3gYdbkzCN44jAl532Irk9TjeLK6Ag3eAye+sVMxwD4UTeN?=
 =?us-ascii?Q?Y1XdubDyqdbFAJxN2ySR9IMGMqhREd0Yy4XdgSvL9/nO8Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?r61w+5aSL4uALALghIgvQ1WBGS8xvmv1UKhwnIQTIFhl4GW5CSUt9P/RJf1h?=
 =?us-ascii?Q?H5JiZYESUvpIz1KHysI95RocJTWw/bO355hf2fOX/fUHzeM+DC1NMjSupnjq?=
 =?us-ascii?Q?mHbS/eo/WaDd1ycpzCsIycV+d9hlvy91ROL43gfl20a2i1J28c02AlONs8Iw?=
 =?us-ascii?Q?zpN4YAwlrTSypfemzPnC4z9i9b9U+8FPP6vgSV2lgNp5+eIwf1J/B/6RsUw1?=
 =?us-ascii?Q?VRUGNIasuV03f7uFQB9d7QCjkhSRDcjdp5STYypfHsHbRB3LlgbMlkfa5sBa?=
 =?us-ascii?Q?RIE5LiOIF1NaSZJgnOfwUYAzCrOrWNxo0uMlH0lAQx4dU+QxM4+q/am9URJT?=
 =?us-ascii?Q?omE6bsJTf5BmOKD5ROZOMEhNK0ltmitwz2SU3dBFwLOi5gjfXcoy9vZYx5mG?=
 =?us-ascii?Q?owO1yw3viBBOu4pzNnuS/IXxqCMwMqsoJe4fDrZ/hVC4nKlt1e0ZAyITTLak?=
 =?us-ascii?Q?aap0yHaEwgC4mn8SFRhHyvvNb4SER0NCwKVo4yPw0pXDhKSX9YskG4BB241l?=
 =?us-ascii?Q?MB134KBUPy40zaEIpVTKNRNEjbjXfPEH/iEw1Kbf4qV15rBe55nBq4DfDblt?=
 =?us-ascii?Q?o6iyx1laqJfjUdg1tRwflsWWGtFas8m5uvcFlt+C8gl48EvLh6n7FGZz8WLH?=
 =?us-ascii?Q?y2HZBuMxidHRI3Oka3fBBqqEdwA8iKUPl2hztFPuh7etwlj9zvFnEpnwHEqo?=
 =?us-ascii?Q?1/OdQotDQx0Ce4HJWQIBTg3VtpJ4EwTuiRIQ+tE5EJtIzjvjc+uiUC2yyL8K?=
 =?us-ascii?Q?yACMAE94xvmOnUf44b/bSRD2K6MOIOEcMII9P0+x/lWUSQLEcFsSPj3KsUj5?=
 =?us-ascii?Q?2FWU9OOPDMEc3TizwgSbZWc8xZP4vSsFgnj+vOOQoqk81YdTVg50HSxr1c0T?=
 =?us-ascii?Q?GF2/ntEalMeiiwqcx3sC9EQXoc+JS6PbYCDRa2BpXaKaT50oCHra+JEt20EJ?=
 =?us-ascii?Q?Lk5KAeicfLWaJeIYpNZvywtCvCxaNYJWL4ja7FsESGq7jDrDohItEnGPL4NZ?=
 =?us-ascii?Q?KhwkVNBrGsGACz+TQbWg4IfUA2h2Hqa5oGxepxWAM+rYanumT13FN9wCujnt?=
 =?us-ascii?Q?H5Z30p71+grickwZ/v6OyDZoBwAOcokJ4dEXB6I0KpwPkeMCdbj62eKTAiUe?=
 =?us-ascii?Q?nD+d2PvuFSTcYVwh2rWW0w8ZKb1vriZv4gi86QtXC7BU8trClsgCHN20eh2l?=
 =?us-ascii?Q?1k4L871UGxLbiFFkRgFujalAzZRT0I+/vkDpr9GJPP9XnxgAgy1ehbOuFIHS?=
 =?us-ascii?Q?ez7GIh5UUHHaSBiS587D7NOTx1E0CsEAfXP5sl6OfjGCrX2FKqkIrsXZtUCm?=
 =?us-ascii?Q?iy5sb5N3Qe1oqZ6j0AmaAh7sbhQc+6I2MZirzkBq1WByX2a/D6HFyrg9BpIN?=
 =?us-ascii?Q?6suZwJdoSX/SfvXwXrUVqhloiOPI+aJPyO0FwIqQwOEafq/yI9ItwAdKAcUK?=
 =?us-ascii?Q?geOpBfb95kqkYXrXcMSY5VO03AY9yfhHYhxkUkPcJL/Z/RvSzDvJaMlPI8jm?=
 =?us-ascii?Q?i29MC3PdKkoCSphXYoI2ctmr6QU29pon0Dgyjm8dhh/GcjUuMoZ4S+ePFFh7?=
 =?us-ascii?Q?JdCvB1UkxMyM5QeYFQjGkbGuzv422ZhrFLJ2NJqP?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b4171f-bbd4-4ec4-4289-08dc6e8c93ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 11:55:23.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sys3QEj1ELckrz6Qi70dDyyi3otoyBRqd1vHsThp7n6AUVs2bmGWFAy072lcomOP2dAVwxpnKbz+8A8XJlVJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4304
X-Proofpoint-ORIG-GUID: JTU2Jl-SnVxdswLO0zl9sWJ18LGMl8hl
X-Proofpoint-GUID: JTU2Jl-SnVxdswLO0zl9sWJ18LGMl8hl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

> drivers/net/ethernet/freescale/fec_main.c |  37 ++++----
>drivers/net/ethernet/freescale/fec_ptp.c  | 104 +++++++++-------------
> 2 files changed, 58 insertions(+), 83 deletions(-)
>
>diff --git a/drivers/net/ethernet/freescale/fec_main.c
>b/drivers/net/ethernet/freescale/fec_main.c
>index 8bd213da8fb6..5f98c0615115 100644
>--- a/drivers/net/ethernet/freescale/fec_main.c
>+++ b/drivers/net/ethernet/freescale/fec_main.c
>@@ -1397,12 +1397,11 @@ static void
> fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
> 	struct skb_shared_hwtstamps *hwtstamps)  {
>-	unsigned long flags;
> 	u64 ns;
>
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>-	ns =3D timecounter_cyc2time(&fep->tc, ts);
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>+	scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
>+		ns =3D timecounter_cyc2time(&fep->tc, ts);
>+	}
>
> 	memset(hwtstamps, 0, sizeof(*hwtstamps));
> 	hwtstamps->hwtstamp =3D ns_to_ktime(ns); @@ -2313,15 +2312,13 @@ static
>int fec_enet_clk_enable(struct net_device *ndev, bool enable)
> 			return ret;
>
> 		if (fep->clk_ptp) {
>-			mutex_lock(&fep->ptp_clk_mutex);
>-			ret =3D clk_prepare_enable(fep->clk_ptp);
>-			if (ret) {
>-				mutex_unlock(&fep->ptp_clk_mutex);
>-				goto failed_clk_ptp;
>-			} else {
>-				fep->ptp_clk_on =3D true;
>+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
>+				ret =3D clk_prepare_enable(fep->clk_ptp);
>+				if (ret)
>+					goto failed_clk_ptp;
>+				else
>+					fep->ptp_clk_on =3D true;
> 			}
>-			mutex_unlock(&fep->ptp_clk_mutex);
> 		}
>
> 		ret =3D clk_prepare_enable(fep->clk_ref); @@ -2336,10 +2333,10 @@
>static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
> 	} else {
> 		clk_disable_unprepare(fep->clk_enet_out);
> 		if (fep->clk_ptp) {
>-			mutex_lock(&fep->ptp_clk_mutex);
>-			clk_disable_unprepare(fep->clk_ptp);
>-			fep->ptp_clk_on =3D false;
>-			mutex_unlock(&fep->ptp_clk_mutex);
>+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
>+				clk_disable_unprepare(fep->clk_ptp);
>+				fep->ptp_clk_on =3D false;
>+			}
> 		}
> 		clk_disable_unprepare(fep->clk_ref);
> 		clk_disable_unprepare(fep->clk_2x_txclk);
>@@ -2352,10 +2349,10 @@ static int fec_enet_clk_enable(struct net_device
>*ndev, bool enable)
> 		clk_disable_unprepare(fep->clk_ref);
> failed_clk_ref:
> 	if (fep->clk_ptp) {
>-		mutex_lock(&fep->ptp_clk_mutex);
>-		clk_disable_unprepare(fep->clk_ptp);
>-		fep->ptp_clk_on =3D false;
>-		mutex_unlock(&fep->ptp_clk_mutex);
>+		scoped_guard(mutex, &fep->ptp_clk_mutex) {
[Suman] Hi Wei,
I am new to the use of scoped_guard() and have a confusion here. Above, "go=
to failed_clk_ref" is getting called after scoped_guard() declaration and y=
ou are again doing scoped_guard() inside the goto label failed_clk_ref. Why=
 is this double declaration needed?
>+			clk_disable_unprepare(fep->clk_ptp);
>+			fep->ptp_clk_on =3D false;
>+		}
> 	}
> failed_clk_ptp:
> 	clk_disable_unprepare(fep->clk_enet_out);
>diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
>b/drivers/net/ethernet/freescale/fec_ptp.c
>index 181d9bfbee22..ed64e077a64a 100644
>--- a/drivers/net/ethernet/freescale/fec_ptp.c
>+++ b/drivers/net/ethernet/freescale/fec_ptp.c
>@@ -99,18 +99,17 @@
>  */
> static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>{
>-	unsigned long flags;
> 	u32 val, tempval;
> 	struct timespec64 ts;
> 	u64 ns;
>
>-	if (fep->pps_enable =3D=3D enable)
>-		return 0;
>-
> 	fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
> 	fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
>
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>+	guard(spinlock_irqsave)(&fep->tmreg_lock);
>+
>+	if (fep->pps_enable =3D=3D enable)
>+		return 0;
>
> 	if (enable) {
> 		/* clear capture or output compare interrupt status if have.
>@@ -195,7 +194,6 @@ static int fec_ptp_enable_pps(struct fec_enet_private
>*fep, uint enable)
> 	}
>
> 	fep->pps_enable =3D enable;
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>
> 	return 0;
> }
>@@ -204,9 +202,8 @@ static int fec_ptp_pps_perout(struct fec_enet_private
>*fep)  {
> 	u32 compare_val, ptp_hc, temp_val;
> 	u64 curr_time;
>-	unsigned long flags;
>
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>+	guard(spinlock_irqsave)(&fep->tmreg_lock);
>
> 	/* Update time counter */
> 	timecounter_read(&fep->tc);
>@@ -229,7 +226,6 @@ static int fec_ptp_pps_perout(struct fec_enet_private
>*fep)
> 	 */
> 	if (fep->perout_stime < curr_time + 100 * NSEC_PER_MSEC) {
> 		dev_err(&fep->pdev->dev, "Current time is too close to the start
>time!\n");
>-		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> 		return -1;
> 	}
>
>@@ -257,7 +253,6 @@ static int fec_ptp_pps_perout(struct fec_enet_private
>*fep)
> 	 */
> 	writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
> 	fep->next_counter =3D (fep->next_counter + fep->reload_period) & fep-
>>cc.mask;
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>
> 	return 0;
> }
>@@ -307,13 +302,12 @@ static u64 fec_ptp_read(const struct cyclecounter
>*cc)  void fec_ptp_start_cyclecounter(struct net_device *ndev)  {
> 	struct fec_enet_private *fep =3D netdev_priv(ndev);
>-	unsigned long flags;
> 	int inc;
>
> 	inc =3D 1000000000 / fep->cycle_speed;
>
> 	/* grab the ptp lock */
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>+	guard(spinlock_irqsave)(&fep->tmreg_lock);
>
> 	/* 1ns counter */
> 	writel(inc << FEC_T_INC_OFFSET, fep->hwp + FEC_ATIME_INC); @@ -332,8
>+326,6 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
>
> 	/* reset the ns time counter */
> 	timecounter_init(&fep->tc, &fep->cc, 0);
>-
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> }
>
> /**
>@@ -352,7 +344,6 @@ void fec_ptp_start_cyclecounter(struct net_device
>*ndev)  static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long
>scaled_ppm)  {
> 	s32 ppb =3D scaled_ppm_to_ppb(scaled_ppm);
>-	unsigned long flags;
> 	int neg_adj =3D 0;
> 	u32 i, tmp;
> 	u32 corr_inc, corr_period;
>@@ -397,7 +388,7 @@ static int fec_ptp_adjfine(struct ptp_clock_info *ptp,
>long scaled_ppm)
> 	else
> 		corr_ns =3D fep->ptp_inc + corr_inc;
>
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>+	guard(spinlock_irqsave)(&fep->tmreg_lock);
>
> 	tmp =3D readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
> 	tmp |=3D corr_ns << FEC_T_INC_CORR_OFFSET; @@ -407,8 +398,6 @@ static
>int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> 	/* dummy read to update the timer. */
> 	timecounter_read(&fep->tc);
>
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>-
> 	return 0;
> }
>
>@@ -423,11 +412,9 @@ static int fec_ptp_adjtime(struct ptp_clock_info *ptp=
,
>s64 delta)  {
> 	struct fec_enet_private *fep =3D
> 	    container_of(ptp, struct fec_enet_private, ptp_caps);
>-	unsigned long flags;
>
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>+	guard(spinlock_irqsave)(&fep->tmreg_lock);
> 	timecounter_adjtime(&fep->tc, delta);
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>
> 	return 0;
> }
>@@ -445,18 +432,16 @@ static int fec_ptp_gettime(struct ptp_clock_info
>*ptp, struct timespec64 *ts)
> 	struct fec_enet_private *fep =3D
> 	    container_of(ptp, struct fec_enet_private, ptp_caps);
> 	u64 ns;
>-	unsigned long flags;
>
>-	mutex_lock(&fep->ptp_clk_mutex);
>-	/* Check the ptp clock */
>-	if (!fep->ptp_clk_on) {
>-		mutex_unlock(&fep->ptp_clk_mutex);
>-		return -EINVAL;
>+	scoped_guard(mutex, &fep->ptp_clk_mutex) {
>+		/* Check the ptp clock */
>+		if (!fep->ptp_clk_on)
>+			return -EINVAL;
>+
>+		scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
>+			ns =3D timecounter_read(&fep->tc);
>+		}
> 	}
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>-	ns =3D timecounter_read(&fep->tc);
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>-	mutex_unlock(&fep->ptp_clk_mutex);
>
> 	*ts =3D ns_to_timespec64(ns);
>
>@@ -478,15 +463,12 @@ static int fec_ptp_settime(struct ptp_clock_info
>*ptp,
> 	    container_of(ptp, struct fec_enet_private, ptp_caps);
>
> 	u64 ns;
>-	unsigned long flags;
> 	u32 counter;
>
>-	mutex_lock(&fep->ptp_clk_mutex);
>+	guard(mutex)(&fep->ptp_clk_mutex);
> 	/* Check the ptp clock */
>-	if (!fep->ptp_clk_on) {
>-		mutex_unlock(&fep->ptp_clk_mutex);
>+	if (!fep->ptp_clk_on)
> 		return -EINVAL;
>-	}
>
> 	ns =3D timespec64_to_ns(ts);
> 	/* Get the timer value based on timestamp.
>@@ -494,21 +476,18 @@ static int fec_ptp_settime(struct ptp_clock_info
>*ptp,
> 	 */
> 	counter =3D ns & fep->cc.mask;
>
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>-	writel(counter, fep->hwp + FEC_ATIME);
>-	timecounter_init(&fep->tc, &fep->cc, ns);
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>-	mutex_unlock(&fep->ptp_clk_mutex);
>+	scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
>+		writel(counter, fep->hwp + FEC_ATIME);
>+		timecounter_init(&fep->tc, &fep->cc, ns);
>+	}
>+
> 	return 0;
> }
>
> static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel=
)
>{
>-	unsigned long flags;
>-
>-	spin_lock_irqsave(&fep->tmreg_lock, flags);
>+	guard(spinlock_irqsave)(&fep->tmreg_lock);
> 	writel(0, fep->hwp + FEC_TCSR(channel));
>-	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>
> 	return 0;
> }
>@@ -528,7 +507,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
> 	ktime_t timeout;
> 	struct timespec64 start_time, period;
> 	u64 curr_time, delta, period_ns;
>-	unsigned long flags;
> 	int ret =3D 0;
>
> 	if (rq->type =3D=3D PTP_CLK_REQ_PPS) {
>@@ -563,17 +541,18 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp=
,
> 			start_time.tv_nsec =3D rq->perout.start.nsec;
> 			fep->perout_stime =3D timespec64_to_ns(&start_time);
>
>-			mutex_lock(&fep->ptp_clk_mutex);
>-			if (!fep->ptp_clk_on) {
>-				dev_err(&fep->pdev->dev, "Error: PTP clock is
>closed!\n");
>-				mutex_unlock(&fep->ptp_clk_mutex);
>-				return -EOPNOTSUPP;
>+			scoped_guard(mutex, &fep->ptp_clk_mutex) {
>+				if (!fep->ptp_clk_on) {
>+					dev_err(&fep->pdev->dev,
>+						"Error: PTP clock is closed!\n");
>+					return -EOPNOTSUPP;
>+				}
>+
>+				scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
>+					/* Read current timestamp */
>+					curr_time =3D timecounter_read(&fep->tc);
>+				}
> 			}
>-			spin_lock_irqsave(&fep->tmreg_lock, flags);
>-			/* Read current timestamp */
>-			curr_time =3D timecounter_read(&fep->tc);
>-			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>-			mutex_unlock(&fep->ptp_clk_mutex);
>
> 			/* Calculate time difference */
> 			delta =3D fep->perout_stime - curr_time; @@ -653,15 +632,14 @@
>static void fec_time_keep(struct work_struct *work)  {
> 	struct delayed_work *dwork =3D to_delayed_work(work);
> 	struct fec_enet_private *fep =3D container_of(dwork, struct
>fec_enet_private, time_keep);
>-	unsigned long flags;
>
>-	mutex_lock(&fep->ptp_clk_mutex);
>-	if (fep->ptp_clk_on) {
>-		spin_lock_irqsave(&fep->tmreg_lock, flags);
>-		timecounter_read(&fep->tc);
>-		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>+	scoped_guard(mutex, &fep->ptp_clk_mutex) {
>+		if (fep->ptp_clk_on) {
>+			scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
>+				timecounter_read(&fep->tc);
>+			}
>+		}
> 	}
>-	mutex_unlock(&fep->ptp_clk_mutex);
>
> 	schedule_delayed_work(&fep->time_keep, HZ);  }
>--
>2.34.1
>


