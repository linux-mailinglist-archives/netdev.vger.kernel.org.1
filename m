Return-Path: <netdev+bounces-109099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5C926DE7
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF951C20FE5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 03:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8C17C67;
	Thu,  4 Jul 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mMFIrqeN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X3bmJCP/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B01DA334;
	Thu,  4 Jul 2024 03:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062489; cv=fail; b=e7KRXx0raoAzcCODzew4x9jTj06QNwQlqTpwazy256LFlCEo1xUF5+w5Fu1ieotnXwWNihps/QwKeAsi/12lropYGBYnH2s8Qpoq0SmO9XrrlCsDOWqnRhncf4daOjET8dsHCsjRMAUcu1Cq2apV8RE+RaU/ogVWi6UNb3kQcpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062489; c=relaxed/simple;
	bh=GPiPJt3FvSMHk+srnAH8VXoySP6eDFrnzx/rI9Hp/BY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRoTuPVYjywyYef/l0RbSJTVDACdAyE0faQOma9B3H7PQFA7rXuC4SG+zeg6WYmtML+VCEHKod4bAaNWqVcyq6qOEoj/6r62S8ocORyi7ZfEJd8bWsgQ3Npocp+fr+GQIDUGhk2KiDikk64Tta+TIFgj/4Kzgjo6xnvjj/V/2ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mMFIrqeN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X3bmJCP/; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720062486; x=1751598486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GPiPJt3FvSMHk+srnAH8VXoySP6eDFrnzx/rI9Hp/BY=;
  b=mMFIrqeNrAGFT8YhHQQy3fRh/2HMD5Wxh71Ueelwmw7sxGCeoNPatEWg
   YVpVBzBV7T2hYVOHfqSGlVA6bgXFr19/bP8o1LBewYiJ3EzBpsY3cLUj3
   jlz5EXQJmdH8ud0L2jr/YoJEgbNtBtvN5/WlxE9nUglm73RC6LyMaWPz/
   onHO7Rv2+f3XlV4SlMEjBzUSdV3sLQp8Kh4/d2e7+jI5fFKHzC+yeJ0vp
   4FtQF+ZXVuudwxU5MYBZ2iPUl3EK8fGytBVDsgKDYA/NgefABAf03Rsd3
   tUm4hLcBjc4arK/O8lzqsPSPnQRRIpmdRbPr3hM8Mi8GIg2rHPNiwpm5s
   Q==;
X-CSE-ConnectionGUID: q0CGWWFEQiOL8LCN4hoUOQ==
X-CSE-MsgGUID: K3+4UkDbQxSmUwNV0js2FA==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="196231763"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 20:08:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 20:08:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 20:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr/wFJqhiAR+mD9Wh1y9nbOtaelhC0ghI+4k5bb/z1CsWkKEVzKaobi0NS2zjuZcFE00BuanmVwz2EDgXxYWnPW5+3TIrr7XUve5ZI8vQamn8/nrRLls01EfiMRpS4txXOYiS8RJ8N6ORTXb0B5OfbV65UoXo+mWTkbbEbgZU/AhZYdBjsKZRiL8HY6gX662x64ScmjV+3NVfGBMRovOeyZB2BViOggAl7BO1bCofsUuTc0ju+sYQItFebxSsNrkCjw1JDhTap9WqTs6ZYCsOX8smA83RpSlA4iNkeXmYBt59nRPNKn1iZ94t0M31iEkuSGhEfUm813lNjCkTfglRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPiPJt3FvSMHk+srnAH8VXoySP6eDFrnzx/rI9Hp/BY=;
 b=iGt5aO6E72jYbR6DSLlimDLsgupLCjG21m4AgGu1K06/3ppyRrvD4s/IiEOUNRVVPliYh3obr0RbnYWHtarmQIjxIZgHJNsiB0fWPRQqFPZNd/96TeQp2T+G/exOQO3la35XrIOj45uziQnpqC0IM2zPGZHn294xjw5ct+O9EgjNP6uniQ2sT3QlWkbE+FvQyVMbGXpGG2yGgyM5qoY0Ue0AjeMPvsvzVDM59YpHEowEWGvplRRGOzr/GIW8S86aCSxi04Jd+mW2Q6xzNPbtcG0co8TzkoyAFtfmGq0nSG7UeY3JqST8dxgZwOrij32IgSbEZyaNqsHYEd+gI8SgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPiPJt3FvSMHk+srnAH8VXoySP6eDFrnzx/rI9Hp/BY=;
 b=X3bmJCP/uztIZxxmprHEWxAn+DctoTko8k4JGtXu6/vtayCrFwhDcpIzvsOgBquMg2+ewVIeoiHlTxM2+YdEdH8/KjacnvIYGZWXIaymAMLnUyat7MMH02nztBTf1/ZDByKVM0fZ9VEvExm/5YG0LarT5HzqoFopJuXF5OmhpT7UnGaogUfH86tLhHrJT1TxWeYZs9uhPsa2CQL2RUCtTFtpCPqhZhT4FM3V+3/hmwhj5uGPmiG4RBwJ0bklmLGxlPRT3JihUgSKH++ffqEb45HhNA3tt+JmnbKnb3d94XlLYjAy7TKjVm14hGWW1L/W64LJ5XiFYf1bJFuaUdrtLg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 03:07:58 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 03:07:57 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: lan937x: Add error
 handling in lan937x_setup
Thread-Topic: [PATCH net-next v1 1/1] net: dsa: microchip: lan937x: Add error
 handling in lan937x_setup
Thread-Index: AQHazSRyI/0uk4LKmkK0IUgGElAnTbHl5Q4A
Date: Thu, 4 Jul 2024 03:07:57 +0000
Message-ID: <74983a1fd88f548c159213a495273c4aa171c1ca.camel@microchip.com>
References: <20240703083820.3152100-1-o.rempel@pengutronix.de>
In-Reply-To: <20240703083820.3152100-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|BL1PR11MB6050:EE_
x-ms-office365-filtering-correlation-id: fd4668d4-a1bf-4886-0817-08dc9bd68187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXl3L21mQjFkSGwzNmJpNldZRDFnZ21ScXdYb09yWVNUQ1VBV1oxNzZmMDJu?=
 =?utf-8?B?NFR2YkZlaVJ6Z0t4c2dZMFNwQjBYUWlKb2xydnVNQ25NMUFpVThsWjkyeng3?=
 =?utf-8?B?bXg4U0hEcVlnb0d4NjRQb202M3RxUWFZWGNBZWVrUExFU0F5OHovSGdWVVJJ?=
 =?utf-8?B?TGFHMHkrT1JiYzBRTmRUa2pWYWRlZmhXSUx4SzJ5U01JL0ZSVGcyVDZsc3Rw?=
 =?utf-8?B?cHlmSlkySmZsS1dTUVRZZFhKSjI3N1JCMzllbEwxdCtDeG5hV2xVWTZZVkFZ?=
 =?utf-8?B?TzVMbVNWYzhyOGdoeE5LRkVlVU1zZTV3dEhJdWZVeUt4UWg2Z2NnRUQzMlVj?=
 =?utf-8?B?Um9rR2YyZ3NHekliUWZJZ2h4Y29QVXJVT3liTjQ2eXVaVnFEV25hSFR4emdo?=
 =?utf-8?B?ZjI2WXdaS2dSeUs3QmlDRCtKYTVuekg3eUVyWGovNUZBV3dtSEVDYWh6RVVu?=
 =?utf-8?B?bjhLaHp6RXE1YkRiMVppMTRibzc2eXJmbUVvNC95bUZXTExzTWVDZExmWmtI?=
 =?utf-8?B?SHdwVTV5YzFoNjZ3ejk2Z0FLQ0VZMWNMNHJzcUprVXRDNCtDVkdJTGMvcmtZ?=
 =?utf-8?B?ZU82cTdERzMxMUNKMWx2SEJzUmFhMmRHZFQ4c0NQcjdxMEFGQzFKbkxURnNB?=
 =?utf-8?B?cGdpSCsrcWRXbHFHbHRMVktwaldweGt1alFONWhiUG4vTDI2TTF0TzJEWnEz?=
 =?utf-8?B?YWtuenlnU2xKTy9KTzV0dmhBdjQ3ZlZQVDVXNCtUdVZnOTUrYlRqMzB1S3Jy?=
 =?utf-8?B?TjhFVWs3b25yd0tRR3FUS2NuUXY2bVhZMWUwQTF6Qy9aei9GZHI2alViWDJH?=
 =?utf-8?B?d2NuZUNiL2RQRVcwU3lhS0VWV3FrcU4zUGVPMkJoTGFsRWNiWkI4RjkzeHB6?=
 =?utf-8?B?aWpDUG5rTlNxV0hvQjVnOXhEei9pWm1SYXBndXNUNlRoZWtreUtrSzg3OHNq?=
 =?utf-8?B?bnNsNklzVGlRQ1BqUEh4dlpMY0QwbnFpOW9mRlVJZXJVL0lXZXg0N0thcXAr?=
 =?utf-8?B?NVlnRmdKMEdpT2p2aVhROVJJNWZTODFXS2NsWE9WdnpVckRPUFNhVlV2U3BQ?=
 =?utf-8?B?QmlqYWcraFVpb0RXZjVrL25sOC9LcXpObS9KQzZ5RkphQUJwZDF0Q0hDWjA1?=
 =?utf-8?B?Y2w3T3oxVkZmVHZQNGJlbWZXcFp0Qm84UDNQYWlYc2s3RlNNdTBEZkM0czZ2?=
 =?utf-8?B?SnpCUXE2VllmRzU5Q2kwZFVXNWI1YjQ0V2l6NFoxTlVSNUxZamdBNkM0Vnlh?=
 =?utf-8?B?TW4vQVQ4cG5qV0ZzakRVVTNiN2hzczc0LzM1cU15LzZjUWR6WDhMWHVWTEZW?=
 =?utf-8?B?YXVMR2I3MVRSbHN2TXVVN21GdUpqT2VjMjN1ZUxDUkplYXFuVGh5c2JLTnRr?=
 =?utf-8?B?UWlwUHZMSVdZNkZZZDUwWXkrR3owUnlTQk5ETUpVcFc4c2lyUm42NnFZYjdK?=
 =?utf-8?B?MWdKSXZ4dVI4YUNmaHdiSXZjV0ZaR0FaNFZ4Yk5QTmxyOXVKcDZ1ejZhQjUy?=
 =?utf-8?B?ZkVUcndaYjhGN3VCWVFGR0F3L3J5UWM1bzJuclp6Rm9PNHpidDh0eUEwdHpN?=
 =?utf-8?B?bTkwWHpHUWxJUDJIUExVMEVoc0tVZVQ4MlQ1MU1YdjFpbDM2NUhZeW4wbTFN?=
 =?utf-8?B?MC9GTFJUc09RbHdPaDJLVXlPZ1BEbVJVdWVKWWRqWnVzeTlDSzFKYmRaL083?=
 =?utf-8?B?OXZyRWJMcElCejFpTzhBd3RhYWdQRWh3L1pSVTArSmNpd0RYSlgwRjFEdDAy?=
 =?utf-8?B?UzRUaUJuQzlMRnRzOEVuUUk1bUtLUjBqOFRNZ3lQbHZ0SXV3ZjZYTTQ4V2dF?=
 =?utf-8?B?YlNIbnRvSExESDh3VUoxUGt4clF0UCsvemlBSXNyVHBPdXg1UHNOK2czRHds?=
 =?utf-8?B?cU9mNy81UWZQSVowcXR0OGZEYnU2aFYyMVZVK3VDb1pURUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0EvWldjOGx1dlk4NUNQOFRIMm5XV1d1S3picnJ5U0YwbXo2OUsveTBjRWk2?=
 =?utf-8?B?UGR3MUJFTSszcU5OeTlmMXo4ZTNXc3RucGJVYi9UMkZlZHZORkQxMnlmdUp2?=
 =?utf-8?B?ZFNPaXd5MjFxcTJsUS9EQzA1djJ3RU5oWWswZlphYS91VzF4ZnFIeFh2Rnpx?=
 =?utf-8?B?QXJmV050S00yUG9WcFNvZXRud1dSV1dtc2J2VUVuOGx0QkpqRXVZa09hZmJF?=
 =?utf-8?B?M2tIL1NtdkNaOXFqaU5sbTdYMG4xS2RDZTBCajcyZUp5dUFjdmNRdzE2UU5q?=
 =?utf-8?B?TFQ4aUtBREF3eWdtajUwQy9yNUx4Sk9ic2ZKaHBQVkd3ZFBCSTRYRjJJVnBN?=
 =?utf-8?B?cGcvZjVRNUtRY1NHaWJIbVViTnhvaXhYcjdZdWNpMjhMZVo1RHRYSFFINXJS?=
 =?utf-8?B?bUlyYU5tWG5lZjQzM0dRVzdPN080OGxBVlJFUE5EZ1VvN3hJcVlWaVRsSE93?=
 =?utf-8?B?VEF2ckV6NlFWdG5kdHUvTVFoMy96S0dPUW1XWU1lL0tjcHA5cUFka2xPdXRv?=
 =?utf-8?B?Vnl1TWR3VWN0c0l2Wk1QNnFuRU9RQWIwNnpDQ2tneC9leXJYbEhwb3loYTg4?=
 =?utf-8?B?eEZPY1dRdnV4TXFJb0kveUZwY0xuakFzcCthckNDbko3bFl4VmVWVlR4SFdi?=
 =?utf-8?B?cm1QSi9aOU1ERnJ3S0dEZ2tlcWRReDNvYUR4OE5mSUZJUktWNnNwQXJEM2tt?=
 =?utf-8?B?ZlJWZFY1Yi8rdEk5RTEyc1AwU3BLZk5JdU52MDZsb09CZFYwcjJ0dGI0SHRJ?=
 =?utf-8?B?Z01PdFFBOWZLYjR6RTJrUWVNMFUxOGJkZG5DY1hva2l4bjh3Z2J5Q1J6N0N2?=
 =?utf-8?B?WERraUNjVEs2L0F2aW9lM3lqdkJabGo4L0F6QTRSRzVEQ0RyWWF1dld4aG5j?=
 =?utf-8?B?RU5tSi9aOEY1dEpPa29VRytjU0gxY3JkRGxBN2FIS21KTDNwRUlubjdjSmQr?=
 =?utf-8?B?L2pBQk5vSm45cXJWa0FWQW9HYTFYVE9UVDhmdEFWRTFCQmlZZVhWb0h5U0Z0?=
 =?utf-8?B?WXI3bjc4NkhDblpnVEx0YUR5VXo0V3UrYmpyeUpqSUpFSThHeS81empZeWow?=
 =?utf-8?B?dmxUYzF0cW85dk9INkV2djRndUNvaXc4RnVXYjh3bGFES1B2c252QnM4dkN5?=
 =?utf-8?B?VTFOUGxlR3pSVGNCUFVKVWorbTBmUmwxTU1hOUw5QVViUnlqaGNjZDUvR1Ju?=
 =?utf-8?B?VDFvMHg1VGt0eHJnS1pOcUJDN0hqYStrT1lCSXFUVmpTVjVGRkk0VEFHamVW?=
 =?utf-8?B?cXpFWDZuMXBmL3Q2L2RBYnBXMTBRR1dTeW9xK1NLTWdLaHp4cDJpWG5zUVRp?=
 =?utf-8?B?NFJxbHZQVTZlQzNJRzFmRmlZRWR6RVRCS1Y2UkJDc2tXWUVYM1ZVT0NoSkxD?=
 =?utf-8?B?MURCYjBwVWZOeVVaczJNWjVTSmNxYUtUdDFxTCsvaE1JbzRXZFNmQlI0UGZv?=
 =?utf-8?B?cHM5RndiL2dGT0hlbUlFMk42dHZsZFppYU1HT3AxTjJYWHdYS1l1WkE2dVV6?=
 =?utf-8?B?aHpuNTZtamxucElmVStobHdGNTVBcUJqLzZlWHA0VGVBTEhNQ2l5bW1IZU5Y?=
 =?utf-8?B?M2k1NWNXUTVvSjNSbzZNbGRDdVdOWXlzVzlKRzl0eHZLTUxxR2JnNFNQSjBK?=
 =?utf-8?B?c0JvTHRTTHczWkxmTnRxWDFLampYTjdicXJ1Nlo4VGF5RmV6dHV3cDVnQlZ1?=
 =?utf-8?B?VHhHUzBUN2tHakg4dXpmSHlnVnBjTGF1TlE0ZGQzbSt5M2ZKa3QvNVZKSkVw?=
 =?utf-8?B?M0hxMkh5VFRGQ2Z4djRCMVBLQmsrOUh4aWlQTk9kWkFXbzdUbzdiU2l1NHRw?=
 =?utf-8?B?VGNRaG0yRkhScE9KcFd3ODBrTEFZMmxCZzBNNERzM1BOU3dXbjExaDRsWWlG?=
 =?utf-8?B?YXdxdGV1dWJKUTA0SzNDcnRYb3A2NHhmMkhxeVJQUm9wcExldDRJYjJQV2ts?=
 =?utf-8?B?bTdKK2VmT0pUamtJQjNtOEQrMmROWkpwOGoxczU0aVZaNWNZWSt4UDBrQUN5?=
 =?utf-8?B?bzdraURxTlRGUVJCNkdneWt0dEJuMEpPMFlKSXI0b2hZaDNLbHYrMG96bFlS?=
 =?utf-8?B?VjJWMExrZmNkbERBSHhwM294Yk5nYU1jc2x2Tnh3Ni9iaVIvaXEySVA4WXRx?=
 =?utf-8?B?UlZleXpYQ0dJL3E2L3M0OVNHS1N6OERUcnI1QU5Qc0l1UlVCcjhSYzNRTHR6?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F5698103F9C47459C0998040A9AB99A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4668d4-a1bf-4886-0817-08dc9bd68187
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 03:07:57.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSEaGM6eu1pkgFK896Hfnb2fKlUHCLQQ+J+1eT8/XyMB2OQhcS9wK1ryzUTR3bReg75pjyD3H5WefMtUGTZzXlqqSVmc/tD5F1Jox/Agkk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050

T24gV2VkLCAyMDI0LTA3LTAzIGF0IDEwOjM4ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbnRyb2R1Y2Ug
ZXJyb3IgaGFuZGxpbmcgZm9yIGxhbjkzN3hfY2ZnIGZ1bmN0aW9uIGNhbGxzIGluDQo+IGxhbjkz
N3hfc2V0dXAuDQo+IFRoaXMgY2hhbmdlIGVuc3VyZXMgdGhhdCBpZiBhbnkgbGFuOTM3eF9jZmcg
b3Iga3N6X3JtdzMyIGNhbGxzIGZhaWxzLA0KPiB0aGUNCj4gZnVuY3Rpb24gd2lsbCByZXR1cm4g
dGhlIGFwcHJvcHJpYXRlIGVycm9yIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lq
IFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFk
b3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQoNCg==

