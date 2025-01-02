Return-Path: <netdev+bounces-154690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817A9FF780
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E153B160B63
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6F1991CD;
	Thu,  2 Jan 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="uHFU3LnW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE01195FE8
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810573; cv=fail; b=qjiUeM/Y9ggWUSn7QA7HkpTLogdgN19UYLQr58TG5ApMtH1kWJlkxU8eW2hb4Z/Dmu+6V5vG/Y2CXaeP3w5gwOpnRIK14yOq0moAdEbl2mW7UvdX0rkgC85YFVr6iZa6xE/sU74kzzu4tEYy4Usbwgp6xnMbuPZ307LRitgsIb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810573; c=relaxed/simple;
	bh=lYXIjcws8Q3Uyhyamt0NV+WSLJDXNk50ax4reRF2pbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l6yLvPHN8dT0KULNmOU6EkNrNYYEe9MHrAiLU23TwnltOWPtskQrJJGaU5Z2nRPFKZnZvaGIaOCxg0vwBR1dcUS5lP/4drzI8R8kUTGuuIbwGUi+i1/HitQSpixJ/M/CvyxEyDYeWEX5Cc9EiD38GbYTEVkh+uf6JCxfyMEs200=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uHFU3LnW; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5028CrpF009271;
	Thu, 2 Jan 2025 01:35:49 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43wq3e03xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 01:35:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSX17TeTjtpuPvUG6mhDzHwJLdnKSdLXojACzn+q+0qG10KLi7HfTU42V03K/AFdwlABBtDqOrV9dXg3vlHMA263uEz0jO4K+fmz+UlZUYtcFhAjsAKWEH4dCySnkzp+b2OIGeSV0qEZla3CjDfejJ3HSwlWFJywZ/TZD9AKGQyj7B5KAbxKGg5CHIrahsNZWXHSOWsbYh7aIOtiH08l3CuWOk+WPwjQ17wI/9nmzc7qijyLGzT2m7mPOQPLyGRRqFE4SfG/dCqxjOpGX153/zLBsbwgqWL59Ipgq/hjkxtxiE3gwOPHyhjbnXhui5a/7W1fGKlwf2d3Fo4hLo5QPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwJ9JxMo1HG2yJoSGqzurZbsFfaPmR7AYghqLZqecQY=;
 b=QMdA+96yn/av89B0lIAM5crga8R4jeiXErVfFeO5qFwTEPNJqeKetPotx+o8VxcC1kWD5G8au5qyWd8Flc5tKxl84jTZrFG2Uxnsq+4Mn+RzxX/tPmAe4TtrWDj8j8Gee1TpNuxuw3LOof8H5L2vZ8hnz2Np4lf6yGTlTKNjEBRNb+gWl7XooCnCaAEZ+MuMzumc1VwUifeLQUuzOUZyGHj88Ha1op2YEKiJSMBUYR5jYaDAZuYMLLQ3p4G+q1J+1WHghYzUZ0Dv8bEOd5ZpWJ6UVaxy7zZJZdThVVmMyx6zx5hkoBGHJClYG1MJrBR8+dHrksrUx//5N5cNfn0ApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwJ9JxMo1HG2yJoSGqzurZbsFfaPmR7AYghqLZqecQY=;
 b=uHFU3LnWWUMMf10M1Y1Drlghab/XTw0UwPA9DPayH4FpevvMpKFg+x24V/pKQma/Ehmzum1pshQantx+BEV6D8ggfcNkzdniof2MDHiggESCB48UQ61Tdc1EXgfiRjfn2ozbm+abNkQbNfa/jj6kJSAbeD4iDhwVtSrWSumlfpY=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH8PR18MB5359.namprd18.prod.outlook.com (2603:10b6:510:253::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Thu, 2 Jan
 2025 09:35:41 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 09:35:41 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Francesco Valla <francesco@valla.it>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Russell King
	<linux@armlinux.org.uk>
Subject: RE: [EXTERNAL] [PATCH] net: phy: don't issue a module request if a
 driver is available
Thread-Topic: [EXTERNAL] [PATCH] net: phy: don't issue a module request if a
 driver is available
Thread-Index: AQHbXKg8H7jgrRampkW8GAv8A6L2K7MDOUkg
Date: Thu, 2 Jan 2025 09:35:40 +0000
Message-ID:
 <SJ0PR18MB5216590A9FD664CF63993E95DB142@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250101235122.704012-1-francesco@valla.it>
In-Reply-To: <20250101235122.704012-1-francesco@valla.it>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH8PR18MB5359:EE_
x-ms-office365-filtering-correlation-id: d0bc2ad6-cbbd-4b83-4e85-08dd2b10d2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xKswwjxTR4sIOHIwQ17+8HZWVVsMD1IRsIQBlO9C1pcWnJ6Zq2nnjrK+fn5l?=
 =?us-ascii?Q?mF3vzz02N03+LU/qquAwy4ap+8wWjM8YcmnJq8KQ+nfU5GAEuKJUtKFZUzQC?=
 =?us-ascii?Q?t3SUWhs+Mm1n1klLoZg+cM1JqHOYpqqL0P85NA8Pg2/HyT1JK9ZQcaieHw6d?=
 =?us-ascii?Q?PB6+5gXS0Wyx/SeS4JB+lVU5aGw2t2RMDOgzws6gClkMd1J2rZOzi6m/qDJY?=
 =?us-ascii?Q?d34pIS+m1hlKugywDRMXrCRHsLLrFOZaXENyEBsfa2Wzw6NFhWL66dbSOKWs?=
 =?us-ascii?Q?FZPIS5KkBtZIEObMxMO9U2IIS+4V6YYvAW72rexpJVnQTxNCKcvnktbLfJB/?=
 =?us-ascii?Q?SUNIlqBAM/uctKXyrzWoXhkoPSJMwKBtK+3Wl511/ShhRW4AFdLA9/FvcYFg?=
 =?us-ascii?Q?7IsLkcCa5vBMbzHKhGfwxmi2lRwBFM8JLQYxPjO8iS21PhF8bzsX7vWdHBma?=
 =?us-ascii?Q?HYmU/NugnejCFjuVGJ1Hux56EvDtwEiPcFohoI/iihO8Ne+AcmuOi8zU9dtr?=
 =?us-ascii?Q?ev7/XtVgy4FeyMyhxFaONaJzI73pmw5NZGi6fgYjv/MYaIrW5tFJjYqy6fbS?=
 =?us-ascii?Q?uwxeImJEQwi0triybXdGkYkt1OIfGJIB1moNVIkbj+IUEHT8+W/lQUm+STpc?=
 =?us-ascii?Q?WWLO5gw46lLaeCZr3tOYI6PoJA36Bw0XX3GQqW6rZ3s7gl3ViAOdEHJ74bbW?=
 =?us-ascii?Q?WTmPLV9NlyCKMp8F1USqYLyhnIhstnbz30JXvpVSgQQ7u+OBblAyxphZIqvA?=
 =?us-ascii?Q?Z+19sQ9pfMNdu2KiRbmHAoD/O+5G3puxeGLS+CObmFmKVrJnlnzPZxHkDqoQ?=
 =?us-ascii?Q?r1omoo9weXs+I7xbD0XiA2DwdseDzLKVpF3WgOrNpjwscHfEu9ofMTkiLzAY?=
 =?us-ascii?Q?Ar7t7SK0a+RBUAnMZ7WyMQo8c+LV8NfnQyxV3T8cNDd3KY44axVz8TtjTHBG?=
 =?us-ascii?Q?eHabUaAieEU+VnhVI98dPwGmAkC/xQms6KYy/NOTCt0G62uSE02lejRy4IAo?=
 =?us-ascii?Q?7fOXvTLWPBFu/eayPhYp99koVih4Tivppq2N1OEsqTYAWM7sdQQbCsarNJUY?=
 =?us-ascii?Q?OW6Ee6OagpwvvYNZSnzz/7n0JNiYqK+75vq7vCq+ZynEQYKiYiof99knMN68?=
 =?us-ascii?Q?JYDqKuPneM0cZ7Hk95n/2Ab4S3T2WGfTAVv6wwLu15wvAPxxvHpch7YEKxyF?=
 =?us-ascii?Q?QX91viImWRt8X8ZAg+UOIxu+UWNKnfhSmp4E0HEzIJS8cZPnPVz3+llA7ED+?=
 =?us-ascii?Q?VviBylQKnUb3tbzh02n3LgjYLt+/Kg1rdHZE/t4qu020mTrMUvaglo458Olf?=
 =?us-ascii?Q?kTo76/twd6SCO2Zw9pJHy0CSWnQYRbeZMytWH+We7aHxFlmP6rT5DnWaRUe+?=
 =?us-ascii?Q?fJj/BvRG3lPV0Ny4WfNZ7X3dYl0403DDCOL64mkRXsJBRsIfCtvUGl4AnOZ1?=
 =?us-ascii?Q?hT98kuSlYKwfDGOqTYm2MEDy+MaE/e0x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yWh65FaxwkKR6Ol9DyrXc5PVs5Z5Ga+IJeZ+hH8NwrkfcmKHmKqoABE6d5bm?=
 =?us-ascii?Q?+MdlJPd6VvljYtT7lVa0okRLrKIP6QHWh0TnnMtQAvM7MFKVx5RCcU3fBAkb?=
 =?us-ascii?Q?bLAPdSI+sO6d79MO5VYTturtn4YUdq+dxtIKg9Dd+muKz+0i4TRSaQZRPiG6?=
 =?us-ascii?Q?N8jmJf1k7mWRYCZHzwGLuZWC2Y8f99UhzWfxMngaQDaZN1XjsOe3/f7NbZsq?=
 =?us-ascii?Q?mopEVt0dpbM8/p5RKx+qltviKlJdbs7Xx5sehSXX3K79mz/lbU5ZQSdR02b1?=
 =?us-ascii?Q?30dk9Wwmo2btQV4KaRcZnZuyEE/XfM2+ZeyNJw7x+aU4WRtxyJcaOFattiYt?=
 =?us-ascii?Q?i37D3tnILw56D1pEFfUwP56H3vDRNVKPRfankEJpY+Jlhi4O4rJ50wxzSZG/?=
 =?us-ascii?Q?2hEZiI4cEmMsMNTmkhc/ApuSuprsOxW5XBnVbA26evauVN2SpROifFp4Pk3l?=
 =?us-ascii?Q?94DOPQAtYF49X4n7ihATzRmGKa6WkzD/hcN/7/QbG+ymdsYLo2LBIxUlfSiV?=
 =?us-ascii?Q?1YG5a6vvEYqB13oA/F7gO75xUG08mzT/uJ0vx456USXpgBmzeaRQrCbrQHI+?=
 =?us-ascii?Q?iH5FslNXFUmpp3V1JnLEbb5qpxEzPBPcaznKqbOiSd6ObgSBaSiumb+pbtsM?=
 =?us-ascii?Q?CgvJiAdOsXNVK9jHhAxVCvTAA7ctZbw7s5PmiBJ72qRR/Da4xkxe69kVZLSO?=
 =?us-ascii?Q?meb2AZGlrfYO8Dv9x2oMHTgvLvh2r9qaL6XMfxyO5fjn+Falv2VAKmq1EEUO?=
 =?us-ascii?Q?KBWhdM2sSTlyfLLFWtQwipXjbRQNyQsFzYiYK/2RYQDgNlXxtz4WLiJtCa2S?=
 =?us-ascii?Q?Ts5sd0I7GbpwId97RYq+PUVAnaDAfrYIcTrsltkG9UJkiH+L1m5KPVW+2/+g?=
 =?us-ascii?Q?MXCz6P7Ozggqz+LXkU7QgYlJY1ypBe4kVxwMnuLBnamnUrKzeogwaVpNruBt?=
 =?us-ascii?Q?nrsdQxXOb/oSavsXKyj6/klLykMRzcV5jX5iD4fmBvB2P0hsL97x8BSNDTl7?=
 =?us-ascii?Q?y0nldNpGqgKaQfBuoC/nugi3Dp57CS03W0XR2Z1ihQ9S7bC3ifCqpFg+EmnW?=
 =?us-ascii?Q?wGwEeNUuljaFw6Q/V7HBxKugm4ohcK8omBiFFmNCesBpHvSYPNTDvWR2kz+6?=
 =?us-ascii?Q?ftIhy46KavBNM54+pJj3V5LyYhoj85fC77tRsu7MfuwnAlNhoXnPrD9G2oat?=
 =?us-ascii?Q?Usa6eKFzLXbyewwau5+MGx0UCZVlswa4UnUnAUWoSpebQJckVfGgK1S7QrwQ?=
 =?us-ascii?Q?0fSwfggyfyix8lzGzsNhaIITDw76P3DUi556t+Rf/cYQxufFCIAn+7CHgLYd?=
 =?us-ascii?Q?TnWbpCZPOJxTa1nJ1cBHoiHEUVNwKycquxWiEGxGxWduaT7+kfDKL7ayHRda?=
 =?us-ascii?Q?2spao0/fi3+rdjyjS+7F92+PyaWB24dc9r4pEAg3RBO58OvO5HbaTSBwA8WZ?=
 =?us-ascii?Q?n95GaxewjJlqXhBl11AX1Kjs1Z3hAZTxjButfgFmU30mbPk4IWAQXPLXGM8+?=
 =?us-ascii?Q?S3gqBag8lMm6wn1kpXBcOGTLA5YASRscbqeGjmqTJ4Z1P9BHj1S+5trY05jl?=
 =?us-ascii?Q?jkzRVFE+4yn7RD9I1uU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bc2ad6-cbbd-4b83-4e85-08dd2b10d2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 09:35:41.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdFoFApZf3ord7ncI8jb0J8xo3yDH4oKHt8+0t7nQZ9c1mT+CG35/8tZViaa0LDexf516geSenRVnzxfFtw3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5359
X-Proofpoint-GUID: vLl2pFJjVvHB94DdKN7Ld_ALDv-891dU
X-Proofpoint-ORIG-GUID: vLl2pFJjVvHB94DdKN7Ld_ALDv-891dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

> 	mutex_init(&dev->lock);
> 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
>
>-	/* Request the appropriate module unconditionally; don't
>-	 * bother trying to do so only if it isn't already loaded,
>-	 * because that gets complicated. A hotplug event would have
>-	 * done an unconditional modprobe anyway.
>-	 * We don't do normal hotplug because it won't work for MDIO
>+	/* We don't do normal hotplug because it won't work for MDIO
> 	 * -- because it relies on the device staying around for long
> 	 * enough for the driver to get loaded. With MDIO, the NIC
> 	 * driver will get bored and give up as soon as it finds that @@ -
>724,7 +745,8 @@ struct phy_device *phy_device_create(struct mii_bus
>*bus, int addr, u32 phy_id,
> 		int i;
>
> 		for (i =3D 1; i < num_ids; i++) {
>-			if (c45_ids->device_ids[i] =3D=3D 0xffffffff)
>+			if (c45_ids->device_ids[i] =3D=3D 0xffffffff ||
>+			    phy_driver_exists(c45_ids->device_ids[i]))
> 				continue;
>
> 			ret =3D phy_request_driver_module(dev, @@ -732,7 +754,7 @@
>struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32
>phy_id,
> 			if (ret)
> 				break;
> 		}
>-	} else {
>+	} else if (!phy_driver_exists(phy_id)) {
[Suman] Can we add this phy_driver_exists() API call before the if/else che=
ck?

> 		ret =3D phy_request_driver_module(dev, phy_id);
> 	}
>

