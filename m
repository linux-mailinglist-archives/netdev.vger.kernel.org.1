Return-Path: <netdev+bounces-90452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C948AE30F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207091C21279
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2C768EC;
	Tue, 23 Apr 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RWr5vjDB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F414691
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869373; cv=fail; b=XXhhldh3iYjxKvUlThOlvi/LL8Rik+/2H6jdzTkBZC4lXKNc89rgfkPjANDDY1Q/BCr1vjHgZZg2pumFs7J1NzrrYV2R2i+rlEPDzWKlg7jEHEfIDUU9cdziMwH6h7C5ZyuGoUd5q5V+Ic2BNBfvug87p+eNhAlHfeqnHKfqLjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869373; c=relaxed/simple;
	bh=w+6OJEJYwitkZyEi4/QTBEcHNmIY7E/J8JjwZxXbn8U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/8sX56OQzFr5hkEu/97ygfLcSNimlq34ygEKGJTwkz8/xjJgEIzHrnw3M4pb0uWTeUXKvAUp08ACLt8vmsRzhzBme89xUdd19GaX6/rjUB5XwSyCUTQDuPZkToWyLk9RLXTGNHJqmuPLQ5k3ZDF/VyJ4LlCZt3rc0ZKS8bZ5Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RWr5vjDB; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N7PYLo011793;
	Tue, 23 Apr 2024 03:49:26 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xnngcvqmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 03:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQv2CbLMO+Y6cme18mBRPf/lqV9C/0Aj9lrF98tlTMxYpsDDKK8dgOySB1T0zji8oQpCMcmVJ8U4jHK120YUhYUXUsaHEwaB7F7XOqP2ZvsvEyG6CKoQRBJvWEBLEGYj32KYAyXtnHaZpvGOy/kRGqHcxZSZzHXlhjFW7/w0wDrkwe3804SPuwdX8y2e58VFubajcjALl/4iMI0VyOL+zwyaHWpKThL8yDqHTTFOMLMPX/Tv8Kk2XhcLfSMHBNOvreLL4vTYRJfb1sr0c86Zt4h6aQao+undz3V8/rBeBcMRtsWd/nWiaLP7VD/MZmWd7GTfB1GYjq64Ig/KSK70Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqUJ+OLUrAwu16E0T/732QFnKrlGv/rigYirIxEoAGc=;
 b=JvfJftBAP8Ebeuc7OlK7aq0pKiP05/bif9k6caTW+h8y4jITmle/AQADSVyWrQ18tFKo29K3sae+d3TT33ZaytWLItdk7bFiCBGybqG+HJlubJi6qGEvZleC93o+72MAkqyCzXvaBfY/X/nwyTZZ25dgv5IUdjyVjpFi1t98HRA0xaZNsBP9qkQcTKkg5ZNFsk6nU4rMonz4BlXGKJ32WAwMcvakNLxkYdx1Ltp29QjngaTrfVyHcIimp4c1E1QIuaXLG5WLsJAS+ev3nA/YTF9KySkTDbPG7dg4YxaLdiCplcfwE14j2YSf+ygjQp2UXBP38x7tftgwaWLXexQOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqUJ+OLUrAwu16E0T/732QFnKrlGv/rigYirIxEoAGc=;
 b=RWr5vjDBu3GhOHtLaxSGLipmqTJz9zDvKE/KilihtUDrVD6sSumd+MrncDdIfoZYvJxv+vyUKy+yeRpekeFDgwBiq1uDk6h9u6DaKK7+1yKKMBZB+sGzpFe3UDGMzlCnCONKkt/b+2AP6mAxKC9JthY76aymaVKa+9xiGaqCXnE=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by CO3PR18MB4927.namprd18.prod.outlook.com (2603:10b6:303:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:49:23 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Tue, 23 Apr 2024
 10:49:23 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Corinna Vinschen <vinschen@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: [PATCH] igc: fix a log entry using uninitialized netdev
Thread-Topic: [PATCH] igc: fix a log entry using uninitialized netdev
Thread-Index: AQHalWvnYg/VMSvUH0KAzEPL27mRag==
Date: Tue, 23 Apr 2024 10:49:23 +0000
Message-ID: 
 <PH0PR18MB447404CC2066483CC449BB89DE112@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240423102455.901469-1-vinschen@redhat.com>
In-Reply-To: <20240423102455.901469-1-vinschen@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|CO3PR18MB4927:EE_
x-ms-office365-filtering-correlation-id: 2a0e7c84-6b5f-4d4b-ad2c-08dc638309ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?bXIutjnVlE8BhMeqO0Sl3zcXf3U2QaRK8W3BxaWNAK3XyPhnOQ34CrkOvNkg?=
 =?us-ascii?Q?fUIOZg5nqn9i8wgtKqnqSUYQKWI60QU27BhR4tukDAwMHr4/r0Sg/4fFI6fD?=
 =?us-ascii?Q?IcLOFh652qOzUtttEpik11waoJfF84fm+0VnykfOt3fCsVfIQmBKumLFDUQJ?=
 =?us-ascii?Q?+JnsFi0xcO4x2Zsom9evKEAsh2ivnLAfmaSwNzsdJfD0roZ8Nnt9+ANy2gQ/?=
 =?us-ascii?Q?3pG0lw76s8Al1k9bweBRTgUcmo0ZGmK50RtljrrIns0CvnhSfOLZdupYIIHm?=
 =?us-ascii?Q?aCAYzQcpfhz0XzJXCK4QHgP69WLh0ZSrVqCDS7Rt8gldBRArAFv5T3WQ32Iu?=
 =?us-ascii?Q?7f6+FgutD0U+yYU9zy5LzwqxRSgHvzSbeu/6xyC6os4Yia7UJQxLgKVpRM4x?=
 =?us-ascii?Q?+4cen8FHWbaMsSLb2SJxUvxW/dGB+I5khwzpfYz8LQdeT4cOb3I+AMjbgoDk?=
 =?us-ascii?Q?tGr7MG2tXxdsiEGaJXgpnb5v76hy4DencgW4e7O1/1Et0pNObbVWBBjep2r8?=
 =?us-ascii?Q?JxSX8dgN2kDGJHyjhy/j23wIwdGx0dtSERqJtaiZ4N6fKclUnJ6h33LyQ7HE?=
 =?us-ascii?Q?xng/+vxGol58g1rqvOn2887w9e9cPmsKXqYpQ88Zd6RkT44rHKLd9vwNIll7?=
 =?us-ascii?Q?demaq0jtRRcehWY7TCEIuw8D2ESB8p9gx6fl7zZ4cUzI1IR0ioE/FughJ1xs?=
 =?us-ascii?Q?KEYxwq/s+9eC8sm1GRfCqOhk/MEodYq26ZpcAiqr4FWlQdMDEJ62bUW8cRUm?=
 =?us-ascii?Q?UPMD0KnX17d8T0SGg2mbo2LGsXIAXLnCnr08LqGWhhszTPZNsJRIKL08F6lS?=
 =?us-ascii?Q?enVlZm/SGgeUp6oyDHer1rLUS+m2mSV6TTliI6gObbrReYzla14eQrZ8JdtV?=
 =?us-ascii?Q?WW1ijNwvNG7iya5mK/bqEow4k0fnUvwAJeNVieeNK6aWg5at8iPPZvs3cbHq?=
 =?us-ascii?Q?869fXLpK9QYbL9xY87PAurrgNFxFfyylzjPXVt0MvOVfN/2nE9mqMk2sqNQz?=
 =?us-ascii?Q?PnluX1hws/IKBZCq+3Tzsw5IcRj7g99DSVgN8SsTnxouC7NiBV5XAl2VOwHR?=
 =?us-ascii?Q?tLfI5KlxwkNW+bL/o/LZ6pXZzmeTRBG7CtaNPFLf+IjmfTLUrPA2UmxFMAHb?=
 =?us-ascii?Q?c5JT8nsf0l3UQK9t3P/AaGybqfZJWdI9Ki3KH3Uci9MlUs2nLV/PkMBiTVFU?=
 =?us-ascii?Q?yy6NkdoFJNDf2qOoOIblkSLdkDRbOf2oh23n9yUr7Bv2sJR2dlhnJOAx1bXA?=
 =?us-ascii?Q?C/+dvDc5yebqUC/OZUE13vGbAovgcETSXNJR+CWdIXlODcO01WLz6BLiGQlB?=
 =?us-ascii?Q?FxFBh8NCHpd3ioSwF8vEPVUG6h8qH2ehOH8IWpQjFAnb1Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0oubN0s1rcChRuW6657W9KevDaJVHFrqlMIoWDacGNHL1b37rwsKzprNbvth?=
 =?us-ascii?Q?duf1b94oOd6BuA43j6Tu/ArYhwv+m++MHeASHUCrXLhRpliMGLeT8ib7+G4f?=
 =?us-ascii?Q?CSQzFn22ooOKllykoSv7+ci8t6d74pclsgQ3fQXB6YB3fTetm4zYGTTmbLHX?=
 =?us-ascii?Q?puYdolm9VJalBzpcdnbHOeG5EEvPIjsbRhInl1LReX8Z/QUD9NSfi65xWVM2?=
 =?us-ascii?Q?oSxKHiVLjbGwo/P3PW32cTRJ5HeOTbCBrgvUMb2E29ViZiW7171BVDHXgBTM?=
 =?us-ascii?Q?+hwVXCSZ3v3vRnV0ZcFzb4WZL/IoAgT3SDfpor0i9Hi9q9PjCC6v1zS5mi4S?=
 =?us-ascii?Q?D+fGkczLGWg19NQwrQ4eTrDUmn6a53wVrTl5NvVWW52N9Eu2ad5c54lfCUgk?=
 =?us-ascii?Q?u+aAqH+OEjPZIeDroUNcvNdoA8OeOxQDJGFLQ/52oYJjITpf/7mFH71SvmH/?=
 =?us-ascii?Q?I4WPDhe0M+ZGYQEXSuAz7CWibjVtUk+4htK/wREEUeEqLpsgtF5qrMhRfB4H?=
 =?us-ascii?Q?GJRSGve6IndugusDLA67tjaZLeafR0/YfxXR4OihwMxHkfFakVy3VAjpVuyx?=
 =?us-ascii?Q?f5ERUM8R4J2OMu8O8KWPP/cuf2QkseyLLNyu+S879Z7j0DkYZhKZ4q8fqmkV?=
 =?us-ascii?Q?xhqKN64FyLAADrh2JJllznZ4StEOrKoQE1si4fQoTudLzwk4AjDP/NUU0yPa?=
 =?us-ascii?Q?xNRPtuVPYzS8M31FudVAIKABLOIg9fuffroqJ6qluRWayodgNBET1Fo64t/K?=
 =?us-ascii?Q?PHOZFKgUnT5HPfSRvgxMhidcL6f83XMqJGcJloCvFGmjfmWdpIMJI/yUdfAK?=
 =?us-ascii?Q?M3sb0w2LURgkIxZKmXdGm1rd6xkcQM7+BNoklGSkoaoBNU27YI1rnersSkd6?=
 =?us-ascii?Q?Ut8X36fceS6Lgn10uXsF78b+lSlgh2D4hgVQYnJpmT1Sd6ZjjEnbevbkIMK2?=
 =?us-ascii?Q?YJJMcfeFZjs/Mpr976U8ENCesGxw4cbUXCrsfM82yFWsYMuneVVM+cf5WHlM?=
 =?us-ascii?Q?annv6nHdNw3OWbTSSS4h2/+QnQZbsOGoTfQ2HQ3n6s88ZQ5JQ+Q7r7YoM9rc?=
 =?us-ascii?Q?FmaegUh22aDft5oNQrsIUdw8RoTRMKcMgYLVKX/8BK3+9WgkfayveKs548gD?=
 =?us-ascii?Q?ay+DNpNP+cTksKXjnjbvb/suZZcsmGpUBFFhVDqnKEfhjhAJqLp8HNRF2AHT?=
 =?us-ascii?Q?CBvJhRaykyWmJfGECuo9Od9FiIOD16xQjR6TOeu9eVvAS8/myo5rq/rKNwWW?=
 =?us-ascii?Q?d66BL3vIiYzee+PhQ5XGhDGwaITas6PTGHGrLkmz9P91JKgOtO/BjA7RzEeL?=
 =?us-ascii?Q?1bISYq+DMO51adTPfCJq5uLX1gTtgfhRHNUeuQJmLHmDgh4hUd5rO9eUgeyV?=
 =?us-ascii?Q?Imqch3ienySUnnfNayRcFzkYctL7q/S/qjTPRc3dW1CveOvy01f4A7cGPREc?=
 =?us-ascii?Q?da48TJ8A+bcfqzfZ4JN5xxq/X22C/7M/eGZqwrEggqERQ1LsTTv0SVCdb2tM?=
 =?us-ascii?Q?mC2aeVgS+B4d+6U5uB+Z6hRS4O22wxcs4uuuucxZ8JtE7tGLv1pDZC8nFFwx?=
 =?us-ascii?Q?/+pTWJe9QpWRUebTOVQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0e7c84-6b5f-4d4b-ad2c-08dc638309ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 10:49:23.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsnGAsoHOItXe297Zg/jqbAi+7LKKYZvZ4SR2Qo9mcyOfBRx1ip9oti+DHShBSAzBF+8NmfSwngXOoBOWWzwxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR18MB4927
X-Proofpoint-GUID: UML8oaHDY6FHFWIXPUk0FuO0hqESfcsd
X-Proofpoint-ORIG-GUID: UML8oaHDY6FHFWIXPUk0FuO0hqESfcsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02



> During successful probe, igc logs this:
>=20
> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC
> added
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The reason is that igc_ptp_init() is called very early, even before
> register_netdev() has been called. So the netdev_info() call works on a
> partially uninitialized netdev.
>=20
> Fix this by calling igc_ptp_init() after register_netdev(), right after t=
he media
> autosense check, just as in igb.  Add a comment, just as in igb.
>=20
> Now the log message is fine:
>=20
> [    5.200987] igc 0000:01:00.0 eth0: PHC added
>=20
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index d9bd001af7ba..e5900d004071 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6927,8 +6927,6 @@ static int igc_probe(struct pci_dev *pdev,
>  	device_set_wakeup_enable(&adapter->pdev->dev,
>  				 adapter->flags &
> IGC_FLAG_WOL_SUPPORTED);
>=20
> -	igc_ptp_init(adapter);
> -
>  	igc_tsn_clear_schedule(adapter);
>=20
>  	/* reset the hardware with the new settings */ @@ -6950,6 +6948,9
> @@ static int igc_probe(struct pci_dev *pdev,
>  	/* Check if Media Autosense is enabled */
>  	adapter->ei =3D *ei;
>=20
> +	/* do hw tstamp init after resetting */
> +	igc_ptp_init(adapter);
> +
>  	/* print pcie link status and MAC address */
>  	pcie_print_link_status(pdev);
>  	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
> --
> 2.44.0
>=20


