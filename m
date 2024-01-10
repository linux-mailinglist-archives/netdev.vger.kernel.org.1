Return-Path: <netdev+bounces-62798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273182941D
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 08:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B01B1C25640
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774A381C6;
	Wed, 10 Jan 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gBN3jwlz"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2148.outbound.protection.outlook.com [40.92.63.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F43F8E2
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISMGOiFpgV/NDh1wkVaTjF+31td/viVy+Dva6qZ3YV6ryn/LxmoZht/RDUx2ato9ECcFG1HLA3tcy3MfoEebiCInUIaLhjVFQerapsEFKkNQ+WpgP+GzGjK7yEASzC54AyRk+/wP7Bz/G31GMvOtSbkPjIYMBxYQ29/kZmUcvFXHm0mXgK4jCC2HtRgqpnKpL1eVN6vse4QRbITTFcKJgVvkdgTXG/1IRwMP6Dd2UM6PtZmizfttCSN585uhgP5CWh01YW+xK60WoXjgTN7/TFcIKqYaewD6stKK51x30wrKv0D+5TG33pEfqQ70KE7gHsC3UYH+cbEYmXDgjdhDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUQrTOxu+TMhSerUYxDzkLjSQ54KrvA2YOH907wBuPg=;
 b=h4idOrTe1WoHWrSv92KIbycw+aRXwsN/ISgpYdbwZ8yKpuvb4uYx9YGmet/e8IAGDXj51rn19BUl7K4uHXA0ygLYjDLUST+2zx2Kq34UKfHclVILC5ZWhhSxVACqycjvwDgAOJlkOBZQckN29CWwkyDWluWPuFk/Na3kSqBZRbQlFOBy3CxAJION9x4WF0OfV2EwPT015pgAPNIP0moqTPn0+eMgMADcMQ09hshei6pXUDMp5euMc81RAo4u/HKXg6kYJxYMTYrM858f7NNR6EyAwNKDMhtO7wKl/L3zMdFHugsU68BafXTYs6mb8oVeHDVmqMMWi8OcyRSp14MdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUQrTOxu+TMhSerUYxDzkLjSQ54KrvA2YOH907wBuPg=;
 b=gBN3jwlzEyI/QCnlQtmWE+6kYayERWKMuu2ndb/deutsbG+RIg6G54eYPfPxwDugcV1Pdd3lALKdgSCfPB8LbIAYxuuY0kUA7F64Kf8LwDExkw3KjroNHOSfDGLp5o6FWFKUTp1u1c3/KH21TBfng041XaLC/o3GdAEeXD6WWgrqpYhlS0ry5x/9NQtms5FpegBbYAlvfDrqBZYUz6UWiDrWddQpx4f0UuG7jlR7g1saqLR+KDVgBDMasSCytK6Gj7t5npMCtZ/G79HwRCMJDlUhWB3VduVvfiVGFJZi1jmTTM6qw9g/41cEou3luGV//KJjGcSGRTFcHTtFhaelDg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY7P282MB3772.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 07:15:48 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 07:15:48 +0000
From: Jinjian Song <SongJinJian@hotmail.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chandrashekar.devegowda@intel.com" <chandrashekar.devegowda@intel.com>,
	"chiranjeevi.rapolu@linux.intel.com" <chiranjeevi.rapolu@linux.intel.com>,
	"haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
	"m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
	"ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
	"loic.poulain@linaro.org" <loic.poulain@linaro.org>, "ryazanov.s.a@gmail.com"
	<ryazanov.s.a@gmail.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.com"
	<linux-kernel@vger.kernel.com>, "vsankar@lenovo.com" <vsankar@lenovo.com>,
	"danielwinkler@google.com" <danielwinkler@google.com>, "nmarupaka@google.com"
	<nmarupaka@google.com>, "joey.zhao@fibocom.com" <joey.zhao@fibocom.com>,
	"liuqf@fibocom.com" <liuqf@fibocom.com>, "felix.yan@fibocom.com"
	<felix.yan@fibocom.com>, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for device
 state machine
Thread-Topic: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for
 device state machine
Thread-Index: AdpDk8NXZPXakNO8SDSvU25jM++YEw==
Date: Wed, 10 Jan 2024 07:15:48 +0000
Message-ID:
 <MEYP282MB2697C5EE3F941651ED59AA5FBB692@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [76Gk4AJYzTDqZ2+20rggACXhQkmlJy5u]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2697:EE_|SY7P282MB3772:EE_
x-ms-office365-filtering-correlation-id: 5d9cc93f-03cc-4f5d-a31d-08dc11abf834
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZA3RyOrBMnkzqR33TsLbBtgcpIaMCHdjVMV/DtqlBr1YRrPl4CvKOCrmWQQloHIMx0pbgbZnoCWVnAlL4IcEcfJtJt+KAMiwULfjoCv2DjyGZJQec8J+CKRADJpEBi7JMDC/N6hhozBKsPiur/2yB5iINv7brYBizMD0rD8q1d6zS2XTazHV+R1MtwIFfBkvH2DVIcgZ0FrqNnOaVIDQCKJc+NSqdzuLnwOSoA6JWa+FclsLN/qKCtJVuxPgb3RjgtUvhMecJquJDb9aT7DsGQrk9OB3voTSoCXWLi2eZJ/VJRbfNCQtcTY0CSGj7riG/c6wWYAIag5CCac9sTNCeEI/pwgAgKuzdzLum8QmHriE+9g+Bp4BP9IoWnT3Nnnx0BQUDMK6y5SninTKjrK+8j8CcgLeOwre2x1C3ENHLvazL+CQ56hzgcvWQK5/usQiKC9bgE/PFfnmep3Qu1nmGGoJpPXp1s3kRGfV15gMkgJLvhj0/OkEhGGZerFXfUx2k3ej1aaG4FyOw2Wu1HDoW6bN2iAcnQeX85iePaTOr2WJi6z0NYHHRV4BtAswqP4S
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e84EfqJ9xA6WBSDyLcT7yqdg5XXXjCk3rp2bBSm0f3EC7enoAQtkm40DKbdp?=
 =?us-ascii?Q?+H0M6EzaH+4xHQulkox0Gv/zEyvRrR0mwMnpXwfRH1wIu7WsyUEQuTD3WC1Q?=
 =?us-ascii?Q?RkkBq6P/ylBlws1BzP8WlIzOoanDH4K44/318HZRx6TMlfMtpTTpdksJT/D3?=
 =?us-ascii?Q?smNhsWOWfNdkIIlqpAowBNQHzjQL2wgF333Vzo79wER5W3e4hS48jDhUf1vb?=
 =?us-ascii?Q?bdJb3us+olzyouU9aRRf74tUWqZCX0fY6Hdz6SXE+vyVIIiyibB5F/cs8tOW?=
 =?us-ascii?Q?n+XLzBkwBj2d5J5BkyWPQ3cMGCpzIdvAqHftHzhuxSXNUwdCOwFywv+ecG1P?=
 =?us-ascii?Q?TZahaalyhStbBc24p49LSjEExtgQY2k0kCScBdk5l05rUd7RWjtC5nUkhMZr?=
 =?us-ascii?Q?G27pO8YrfdqqT9MoKHkv94TVRj544mueDqfeXgYaK/ztOBHAkpsrObUO8QyC?=
 =?us-ascii?Q?VA/11KoXA2BChHc3tpPqrtCLa9P72w0jetxxWq6p1NKk8dEyPpu9L2tCg651?=
 =?us-ascii?Q?uILmbhxMs5fNbUKVS08hIr0HkEFaO/3kdShEPMollTQ94uYpWhPurE+J1GjX?=
 =?us-ascii?Q?aK6fguDwpkSvgPG+StB29RTQcwYbXyzqkGoL+TvoTC/qtS8dE4TjbCsBrRM+?=
 =?us-ascii?Q?zsur4b46K8vB5GnqY6sU80bo+ILVPQAXVtyWlWsbl22UZdoh6/GFAt+cyLHb?=
 =?us-ascii?Q?d5fkGyoaKVuRNC2HhYFMc34tRUbx4qDAG+64FskqFbCFUhhKob0QdO2wh1EB?=
 =?us-ascii?Q?m7MGm7VloDaqa3TVGj85A2Q5/K8wfO1amdGRrQyJx8bZVz+uuuPpetDUkHtX?=
 =?us-ascii?Q?aBhpUq1B7J/8/sTwmK7uGfTdm1fhldfB6h2IvOAZMQoJwgHwyM3DkxjnTXVD?=
 =?us-ascii?Q?q5ZiB+foDycbwle4PndgNBObRTW1HPdY8RrdZ0YeEHlf9remaekDjovu6n4b?=
 =?us-ascii?Q?iEsHPWSZWbYhpkFl5bRmsBJriU2BaACifLFeyBOAbHk4hbvrGTZBuNrPC/sU?=
 =?us-ascii?Q?tDYORiD12ZNJWAPeP0UhbjbK7ggyRNyIGaURXE7Gx8c0MgfQTYrxWaSu4WzY?=
 =?us-ascii?Q?Lei5J3bHAYJnz585DRUNRcFafOv6Qpps9DXaiMgY5woyTgv6GTr8XAcFvN9a?=
 =?us-ascii?Q?9GwrL/iVnN/ZcP5kk3FTFjf5Xf2vEI/5hfiPKURQkpY4X10rfQch6ooxuWsU?=
 =?us-ascii?Q?hWyEpb9PIhLS5TU9BEDcmGV0nFJ4sdE6cJImkw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9cc93f-03cc-4f5d-a31d-08dc11abf834
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 07:15:48.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3772


>On Thu, 28 Dec 2023 17:44:10 +0800 Jinjian Song wrote:
>> From: Jinjian Song <jinjian.song@fibocom.com>
>>=20
>> Add support for userspace to get the device mode, e.g.,=20
>> reset/ready/fastboot mode.

>We need some info under Documentation/ describing the file / attr and how =
it's supposed to be used.

Yes, please let me add to the t7xx.rst document

>> diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c=20
>> b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>> index 24e7d491468e..ae4578905a8d 100644
>> --- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>> +++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>> @@ -192,6 +192,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq,=20
>> void *data)  {
>>  	struct t7xx_pci_dev *t7xx_dev =3D data;
>> =20
>> +	atomic_set(&t7xx_dev->mode, T7XX_RESET);

>Why is ->mode atomic? There seem to be no RMW operations on it.
>You can use READ_ONCE() / WRITE_ONCE() on a normal integer.

Please let me modify as suggested.

>>  	msleep(RGU_RESET_DELAY_MS);
>>  	t7xx_reset_device_via_pmic(t7xx_dev);
>>  	return IRQ_HANDLED;
>> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c=20
>> b/drivers/net/wwan/t7xx/t7xx_pci.c
>> index 91256e005b84..d5f6a8638aba 100644
>> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
>> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>> @@ -52,6 +52,68 @@
>>  #define PM_RESOURCE_POLL_TIMEOUT_US	10000
>>  #define PM_RESOURCE_POLL_STEP_US	100
>> =20
>> +static ssize_t t7xx_mode_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t count) {
>> +	struct pci_dev *pdev;
>> +	struct t7xx_pci_dev *t7xx_dev;
>> +
>> +	pdev =3D to_pci_dev(dev);
>> +	t7xx_dev =3D pci_get_drvdata(pdev);
>> +	if (!t7xx_dev)
>> +		return -ENODEV;
>> +
>> +	atomic_set(&t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);

>This function doesn't use @buf at all. So whenever user does write() to th=
e file we set to SWITCHING? Shouldn't we narrow down the set of accepted va=
lues to be able to add more functionality later?

Yes, it doesn't use buff, just now only allows user setting SWITCHING.
Please let me narrow down the set to be more functionality.

>> +	return count;
>> +};

>unnecessary semi-colon

Best Regards,
Jinjian

