Return-Path: <netdev+bounces-70110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCF84DABF
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 08:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA0FB2252F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103836930E;
	Thu,  8 Feb 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="FtdRRkY3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317A6930A
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377824; cv=fail; b=YzjCEDZnq4q/whsh9eHcg72e5bBjK7Bvw5xZ6eWzNv3yRWnnTy/6nCT/0G8uRmvSa7Ahrf4XrDGj0OWtpzFJdG7QXm9jv9MKaGUfhVMZOeEUw67tmF+VIQuH0xfiaPH/iOPISGtdo5t6iLf+/AUIE3danYAk6h25/8gBmNOuut8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377824; c=relaxed/simple;
	bh=lmyW3eSFnEiqUGjjr3j1bqUzLziyfjWHo8GkkqUirgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tzhPFq61tIbEf2SkxgPsfDcPT4TI/pvlqT+DNiLFhURQc1foYXwXK9VmYRCfOvFVn3CSE2y0R4qi0YFgOoUOdWCV2A6vXnKzYHXc1KC6xrONAwJ1P5TD25k48XeFPdPWZpev/mdn/5VUqoITralXiMWr2ZzfA2QLUfnnQamnvzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=FtdRRkY3; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417Jm1dv001478;
	Wed, 7 Feb 2024 23:36:57 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w46k7wa52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 23:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WalpukAx/bMyiSyYa3Qt6XfZQxwVrFYOip9sOEuhKPkLYavBThpx4r1EvWqGU4jsn3S6OA5QzEuW0liyIZ/POpXi2ewmw9+dTGQj7zDlBVZjKhOAy97SLyWglzn64EFMD/beaRyJc0jET5pp5MsVJcw6NGhKSj7j5jeuZv1A8f8oNvBiFiZARnJO9ag6pgztkB4vv7Y+b2djH7KhuFVsrfJlqtsjoNKRLKGfP2HibGQHaM1OojVPqSs4JvfceHamb/L7HdhFwJpmNhX1+WwulBQrZ2U1FpaQS4LnaFLgcC3Jk1bKnWkx4j9qhiCMilljhNKPmmmPw5oFIGdubRsF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmyW3eSFnEiqUGjjr3j1bqUzLziyfjWHo8GkkqUirgA=;
 b=WQmIHWDONoY2aHCdXAGYMkzCYKuL9xuwCo1nBhYEqltsesPg4GknqQ2jYDGKigmn4tP3lpsC11TkzwSl4tHIRgfwVq7y42LIR1ZE08jUPYNUXUwl27Z9o83bGFhBxiYVAWs3ovCx5ggzMOxPKKwfY9gzil/rBRI1/U54GfFzBh7bufiRMdMfo3YifTg+C9IcU2WtKLbblWG+Gyv14CWCm0UyLSTuNUP73jolIGqFCkeI1qCZGeTYXi7So/UEzCu4NASs15PLfC7LKfWn8DyxyVaUQNyZd/DNAJkZO5jwKQ3DbKQGhBDpJDJOOh/scfGOco/7uUvZ4Dd9bPp7otk0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmyW3eSFnEiqUGjjr3j1bqUzLziyfjWHo8GkkqUirgA=;
 b=FtdRRkY3OmD47/diBiTf5J/OIjQAr8qpqrsDkVTIsmeU91qmkjClqbvS6MzLDsXtNkHKYs8X0NzK/e405cOhPzZn9JKQafTpz3YOiKfOQIXQJUhC7GlI7vev6DKDaM8WZeyeGM0DO6dIgRgqqm59MC1zmcVDZ0TYuLcCSMxxHUw=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by DM4PR18MB5145.namprd18.prod.outlook.com (2603:10b6:8:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 07:36:54 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::9b7a:456c:8794:2cae%4]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 07:36:54 +0000
From: Elad Nachman <enachman@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: =?iso-8859-1?Q?K=F6ry_Maincent?= <kory.maincent@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Taras Chornyi
	<taras.chornyi@plvision.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: RE: [EXT] Prestera driver fail to probe twice
Thread-Topic: [EXT] Prestera driver fail to probe twice
Thread-Index: 
 AQHaWRTVYbeYsqk58kW66MDvCmD52rD9oddwgAELHICAAAjz0IAACYYAgAAPF/CAACQIAIAACMZggAA6R4CAANs2EA==
Date: Thu, 8 Feb 2024 07:36:54 +0000
Message-ID: 
 <BN9PR18MB4251BC09AAD68BDA10AD4C9FDB442@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207122838.382fd1b2@kmaincent-XPS-13-7390>
	<BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207153136.761ef376@kmaincent-XPS-13-7390>
	<BN9PR18MB42516CB6F1DA53D8BAD47B17DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240207103135.33e01d2d@kernel.org>
In-Reply-To: <20240207103135.33e01d2d@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|DM4PR18MB5145:EE_
x-ms-office365-filtering-correlation-id: 09aea3dd-570d-405b-9e42-08dc2878b8fa
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8KFihe0KQ5hwrX+LwwOsxIIwl1uE0jsjVvfMc1mrTmv4TKutFyW0XbmDmI6zUaLVrwli+ddwbjXv6gQXwbHpZW+C0hGOCy6+Vb9c4t8RZeOwUmE1SHbixN7FeiYWi5IT5yr8F7BERY4cCmMO5MJRmJz7kvwyAoreLrprjbqqiMkJJKtne+otxR3bP0yeX5KYJc4XFWGh7/aDaGZcOe4K7+EqXG5WTYxooTv5LboEmG24TslQfmW0DrxtjTjnYjVzqmsCxrbafhlm4xUTaW7rggmCxuZpGk1YXwSiMyoPQu1LtzrrrT8/9r11xxhHc7T1T8MpXupnCRONMcvYMyT4kJ0U9i6VlTBzE5ZldpQQFCGnLVB50rDEeyVDm3p2XxuGP/u7IDnRWylsLo+elg4I0er+ht1bwVqr71hxTAPaJSB1RozZbDUlUxdXrua3kvoo6ihdqQd169lHazdGFxQC+DukC5fdGywhyL5zcMR7GHs1hiQMYJtvMB4cTbx+49ojSH7/wzGLgRj7Y1unU3FDdkF47AwLMgL79+Nd0Evy/LjGpyqs1xNiXh8SUmzFP9D+RPap9z6wUUuWbpWv/MuE1fsh+Im/pjdzGDTnhJ0FNpGi/t8BRvU0dffM1Kv00mEI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(71200400001)(7696005)(55016003)(2906002)(54906003)(52536014)(5660300002)(316002)(41300700001)(66446008)(64756008)(66476007)(66556008)(66946007)(53546011)(6506007)(9686003)(478600001)(76116006)(8936002)(8676002)(6916009)(4326008)(38070700009)(83380400001)(86362001)(38100700002)(26005)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?bdu7FJAOPpQL8FHp/R7flvX0tdqci6Dk9tBKCDJKF+x7oRPR8E90keuZEV?=
 =?iso-8859-1?Q?QXF47lKvRgszOJAtBteLShY9l2szrwbFfEMw1or4nq2yF25e6KFFcvmRsF?=
 =?iso-8859-1?Q?d1khMqdE5oxmFvo7nsCdB5iatIt1hZ4WDARhcFUahO7AHak3+r1Zp+I/WY?=
 =?iso-8859-1?Q?zAYH/qqv7Pg+ktxmUCQR7QftO4BT4osgNOhCbsgecqqSOw8bc7qlyeiH9U?=
 =?iso-8859-1?Q?AxLuQafNw54IvH/I5drfFQ3tC25w6cs192KSyic7LWUXEWpdn7wkTwETDv?=
 =?iso-8859-1?Q?gt5Gcm+TTBPkXhtslrLLcP8taSuVf91pKKnmCwab7kit9y8S1Bs2mnI57l?=
 =?iso-8859-1?Q?B3yxSqgNRPlD8VtE872zw/vYTOj42bh6cau+K18SAOTP2C0xHQKSjI4BD0?=
 =?iso-8859-1?Q?Aa1PaEbC4gcjwW+eGausRnO7mqgR7NLvn+aShTHgMD+o1D6VXcen4HOq8W?=
 =?iso-8859-1?Q?mdVHTsYw8+AqgR3ZYUluwU9Q/0miz+JH1+YKUDh6CXeaqzNVUkUJaMm3/P?=
 =?iso-8859-1?Q?iHFWYdlKr2Hf5BPaKb1oLKoYOggVvPHCBghnkOEfcFW1dCpBVfICxHpOmL?=
 =?iso-8859-1?Q?lOG56+YLoAmHPGdk1cjoiqrzFPJG0qEqSxKInXFZoCVYWT88Spfv04hSxu?=
 =?iso-8859-1?Q?tdD1v+ZgtaXFMz14IOcdFkC3BLFSWnN2V1TXEqW7uKIvB1tehNo61TIDAG?=
 =?iso-8859-1?Q?+YN0UNYlxQ79A3zpYkAEWgIJDtNs9di4HC/Bn+9iwSbra2eFcIHEu/0a3A?=
 =?iso-8859-1?Q?s62OcWjA5JS5xA4WycI55VYNNDm8ENZVUvnm3XFoZkVlUSa5iLmSjQck/R?=
 =?iso-8859-1?Q?HhR6X2wW2G27pIAD8jqKV8PeV65E7nNsZbliD3EsVh5h78ChPOB7J3YH64?=
 =?iso-8859-1?Q?OgX69EicJ4Xeu0gXXKQS9I2Xah0O46YsCER7Zdy8tKU91Rb7qLyYCY4Yy0?=
 =?iso-8859-1?Q?h1HvtAOaCD0Dq1HfKP9Pv8C8vo77IpbM8mECKFIZxLcAF+1lNSWCX3kX9Q?=
 =?iso-8859-1?Q?yHNWRoqsgsH3TEkxmL22yBxpXFQm3DB7nIm8tlYdYhAYcDjYC4IahmzUvJ?=
 =?iso-8859-1?Q?Ynu8eNzoAN+k1Yq47iLw8U585c8kez30f8gWrlZiVg5gfSXC+M9nMt0Qby?=
 =?iso-8859-1?Q?we0CP9HiPbN1Saoq78glUl/FXx891QcDHAz4om723O+vAnu0SnxXoP8moF?=
 =?iso-8859-1?Q?OmaKH7TEQXnOs2YfyASbfeojxxcybrHGB/9jqsN8/gdhhjiS0OyB8oFwby?=
 =?iso-8859-1?Q?jeD9r7Lw9bzkSNhdSV2GhOBIKrChhf/xL8N9he66kF4cAmNl5WiVBsfjCO?=
 =?iso-8859-1?Q?uGfZ6hbk+wreWlQIxNJdiXEBIVnxCUntPtAeSIIA/kOKKeeRxM1MuW8f/6?=
 =?iso-8859-1?Q?7fUSJ/cmLq42lyiLnubTrPB+L+IOC/KUHi6WCca3254AQM6Jkr0Lpmof+k?=
 =?iso-8859-1?Q?66jIArdZ7VgbbsgK7TUHj1jatVQ5Eglxo5wkqzcu613WpqnDOeZfKuG8kJ?=
 =?iso-8859-1?Q?+rHuXMySAkRFXQnCTp/EDOzqkR/sHwU5P4CPjuOWuhndGvEM+PvOXv3qv+?=
 =?iso-8859-1?Q?WsgV/mW4eOw/lBPCbRL7FOPrJ0E26oEEWoS/74diUPexrs83jl3gFQXWKR?=
 =?iso-8859-1?Q?3mVdIVUzRWqiNVg0Mc4rK02bqFqlE45ma9?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aea3dd-570d-405b-9e42-08dc2878b8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 07:36:54.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqq9zXX01SHQ3Ui/2hokT9FaLFF131CzCfw/+yk5QTI/iKVyHZ04M23xucuL2+DAH70ZHkXXU5a0tL9vfClgLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5145
X-Proofpoint-ORIG-GUID: _CNxv0CA3UgwPKbzfYql0L-NB2hMw5Ie
X-Proofpoint-GUID: _CNxv0CA3UgwPKbzfYql0L-NB2hMw5Ie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02

Once again, existing deployed firmware does not check the enum below , so t=
his does not ensure backward compatibility.

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Wednesday, February 7, 2024 8:32 PM
To: Elad Nachman <enachman@marvell.com>
Cc: K=F6ry Maincent <kory.maincent@bootlin.com>; netdev@vger.kernel.org; Ta=
ras Chornyi <taras.chornyi@plvision.eu>; Thomas Petazzoni <thomas.petazzoni=
@bootlin.com>; Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice

On Wed, 7 Feb 2024 15:06:34 +0000 Elad Nachman wrote:
> MAGIC value is cleared after FW is downloaded to RAM, just before it is e=
xecuted.
> So checking the MAGIC value to determine if the firmware is running is us=
eless.
>=20
> You will get the MAGIC value read correctly only when firmware is=20
> during the download process, which does not help you implementing the=20
> logic you want.

I'm not aware of other networking drivers which cannot be reloaded / reboun=
d. I think it's part of base expectations for upstream drivers.
Could you work on fixing this?

IIRC we have enum devlink_param_reset_dev_on_drv_probe_value to control whe=
ther device is always reset on driver load. You can make resetting an opt-i=
n if you're concerned about backward compatibility.

