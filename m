Return-Path: <netdev+bounces-117627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902A94EA0B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9F01F221FF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823416DC27;
	Mon, 12 Aug 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Az40gebn";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qCeG07Lj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658516D9D8;
	Mon, 12 Aug 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455601; cv=fail; b=YHDWspXhFknVcBNZE4KqT0XilFlSWosNvo6djfkEg8n7vLHhkC5fqygTzULzqmSkmtsSgUxVfS9FEDwniPzkEf1LPOP2MhT/7BoAfnHlfwjbBw7apDqB9oTC5PDk4bXCpUza+NBTloHDfQ4Iy5+UnZ7yov7flIXhkLIlrA989uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455601; c=relaxed/simple;
	bh=A243SVPe0/3FX6P/pnJfOmbSPLI5KuGOSZ02qvesulI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjqfJqeG8EOWUIJh9OAi9uuFDQscLd9Xmj5Oo8CsnzJg0nW5XJh8haeE91GRV0jdKqNXulO+gopnFaT00PkF1UigZba/fEAyrkpL+5arE8fz/ClDEpSbY3WSL/XXk2+H4rkACUgUJfRPAr8Z9MKqf/POsTi93UXKW3Zb4DGOkM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Az40gebn; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qCeG07Lj; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723455599; x=1754991599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A243SVPe0/3FX6P/pnJfOmbSPLI5KuGOSZ02qvesulI=;
  b=Az40gebnc69R3LkJwG9yJ6ni1inCRxtl8zRINXAO/Qze30/Ajz2xwavR
   nqlW3lW4bs5FG87mHGAHdAdwj5tohNKMwS2McW9hatHkaLDmPCrg5WqWz
   sW+loawTzQMa2CSAESD7PquHTD5IxaMq4Wrt10kdUx6QiRmpHZCfgtLwR
   3YOGLmYGUSNTZdGFjZ0L3bmjLkxPBSfK8UTdqzyFNWC2wo4jZ1m3lzV41
   EOhYd8jVK4X+sZ1wJg1JcW3YjYCNIupIYKeXpDlXlcrRQvT2hGowvqk9J
   ACvO818DVThbgcHA6Rj582f6WzSdtqO/XT9O+VDdG3sMmS3fUODBV2qyI
   Q==;
X-CSE-ConnectionGUID: X9BD1URLSV+3WbSst+8SPQ==
X-CSE-MsgGUID: IBE7kIIIRdSJX1flVGidQQ==
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="261287988"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 02:39:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 02:39:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 02:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9een9Uh+iRu9T7lrsS1S1GwS3lbbZ2WwI9zkr66h4PmzrY5EXjzUvUQJCyjjrgan+yyuAkhl9LENF7hM03PRN6w2pS2iUkNNHCOc/j9dRkOcIR8GPkAAxPlN8H/HYqtUaFp2zQQGKdSXbPPD8e1OHeGxKuRzU6LTL57B9QzmKxJLZ/xMrCmRb3+wOLwaGmJPNnhC5LxJW2AkZM3brvFxH0ZI+2Da3PyBlXiIu9yknBMkKYnebkoVT7qSHYYMVuLxAIwaKWN6clga1DRuQPZfZeMD4nwZH9DQZnDPkUVS6uDcJD3nKSBP0h6d5P8n5XSj5cKltkT8M2BGsXGyfeDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A243SVPe0/3FX6P/pnJfOmbSPLI5KuGOSZ02qvesulI=;
 b=ACoYRPF9DzxUVvaTWw7nB6WwT2+pVJqdhkg8l6Qima++2OhICk4OeAyw0hgW/IJ+iXlTDFmtVU5g/ApIwZYMaFlEexloT5akgRV4/Y28ok9z6P3MQeMZX5pY55bc9GKd7EREhkZmb1KAXgxPCS8pDUORdQcURr8zbB8aDWCF8XtDAgypuHp5MZHNWVlBP4WV2c48TXepNjFv7hzpo9nk27+oK36HljAUIvVW2+aHcRVCEaufC9T1VdUKJsxJzoFE4CBKxPqkuUPCNlJs969Uyv9wn1BBSea5uI6nLutoCQUSIB8M7EhufIUsLn57KK/5UsxhYolkRsIeNeFtOdYUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A243SVPe0/3FX6P/pnJfOmbSPLI5KuGOSZ02qvesulI=;
 b=qCeG07LjAqjP+5b2ArzK5THEPXL7LRjyklsNoQTrTTZDI2F94HgMzPuXnx7y1EnPRQ3J3ngo1pe66Y9pjJdi0DPj2sq53zYA3iZheIPO8CUyw2B6oyTlAB2F7DEAn6DxD/dAR1Fl+V5EegwZ3FMahc4yG3vSW4yHf55zd85F0bj9xnwDd/dM388Rre2JyhoT4IR+tDhsLV5EdjIQ1wpX/YQpaUyI6DQGxwT2eVmTQU7Sb0ZsR3f9WfwX5nXGHmrTAof4chowAYCb/CigdjACNaWpsaOWJqs/5eTFbffBaG3U8K7GeakygqoMqw6XcxCKdciL+iI3NMVnZsjGna0cPA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 12 Aug
 2024 09:39:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7828.029; Mon, 12 Aug 2024
 09:39:09 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>
Subject: Re: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHa4jaTAREq0XzH102IOZrpnjB75bIiTSSAgAElXYA=
Date: Mon, 12 Aug 2024 09:39:09 +0000
Message-ID: <1b509f07-d8e3-46ec-a0ef-79976a91fdb4@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
 <0451de33-3256-4c6b-a6ac-ca99b946fb15@lunn.ch>
In-Reply-To: <0451de33-3256-4c6b-a6ac-ca99b946fb15@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH8PR11MB6973:EE_
x-ms-office365-filtering-correlation-id: b30281c4-2308-40d2-2b8c-08dcbab29dfc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RE1sUVV6dUNkaGY3UEx4TDFYQ29oUEptYUk2cktSU0N0dWtuVXUvTjBqQjYz?=
 =?utf-8?B?bkgzbDZ3RVhzVXN3Wk5OUGthUnR3ZHBZLzFNblBtZWUwcmIxRFhrZWRoVkdC?=
 =?utf-8?B?TElWSmpUZFFUZ1owZkozN2FjTEgwNXFRVWFXVmlNR054QTVnWDFLcWJkSVcz?=
 =?utf-8?B?bEJIOEQzSWlFdm94V2pOUURQaFRrME9QNkh6ZDAxUmExWmpaUG5TTytrendB?=
 =?utf-8?B?b0NXK1dJeVlSem1FWStqZEUyQjZ1cE9VZmNuNHJQa0c3dmNoOHFvYms2eUFL?=
 =?utf-8?B?eGhvRnVyclpGTVpwNE82YjF0NDhHMHFUVEV0RjhxRnBYa085TDh4UDZCRE9h?=
 =?utf-8?B?ZmY4MEtJWUtYVDFMVWVWS3E5K2lDVlVSZVRwYm9rZ3BtRm5Mb2pjMTRlaS9w?=
 =?utf-8?B?Y2svSHQyYkpVVFpmTnYxTVpNMUpIc1hEaktyY0ZTOE5RZUt0LzF6Q2YzTmVJ?=
 =?utf-8?B?TlVsQkVQS1NoZHYwZFRiRkpCV0RiZTVQd2M4VVRudjdKMUp5aDNLTys5Ulhy?=
 =?utf-8?B?U0FqSnlxdUNRSnl1RllxdC9DMnJTbCtHb3BwMjRENmR1Mk50UFNGL1U1ZUND?=
 =?utf-8?B?T3hRMDA5ZWV3S0M3enlPQWdDalRjR2lUMVNiWlNHWGdvVGROdHVTMzg2dVFF?=
 =?utf-8?B?MWlGVlYzRUhHYlRXcjAzRy9LeWdYU2Z2UGVJUzFJV3RqMzE0SU54ZHYzcXE5?=
 =?utf-8?B?VTI2OTNOUDhsRDhZRFo4SFdVTkpReVNpSEo1Z1BuZmNtTTE4UUdYOE04MVBo?=
 =?utf-8?B?ZzkrM3YzMFN0bk5ybWtVVloza2RjSTNYWUx4VkhYbXNSbTA3dk5mNTJROURz?=
 =?utf-8?B?Rm1QSFZjdWdHNlhZYVpBZUlqeVlUbUJ0bkpnNUtNNGRvV2Ntc01KWkhzSElm?=
 =?utf-8?B?R2ZQdXQvSmVveThMOHJ3L1ZaZWd0Tjl2QVoxQy9Vam11cTFQMTAyTVBteU9t?=
 =?utf-8?B?S2JpNlBkY2Q5K2NTYWZCQnRNYm1xVjRNeFBuZmVuNTRqR1QzbVdubDVZRjE3?=
 =?utf-8?B?L0FPRDdJdG9yZ0p4OHlGcTVMbFFSSS80bVZ6aXEzbks1NUkyZlFzdGgzdW5G?=
 =?utf-8?B?MEozMk53SjJGQkdhR3BmU3NxdkNsSjVhQzFSWXBjYTJRcWJJUjNmMkZDbnVH?=
 =?utf-8?B?ODdTRE1sdk94bTd5eFJVSHJYSVdBZVpCS2hGeDVZUXlOS1k5MjYzbmVoZFNo?=
 =?utf-8?B?TDdiNXphTXo3M0w4cTBDM1ZqK0x0WkFyZVpUZ0w0U2ZCSmtSMktVLzI4UUF4?=
 =?utf-8?B?SEFRb1A5U0w4cmNOeFpwblpscEUvd0dvWjJJanUyeEJmdk9LcE5XbkYxY3Qr?=
 =?utf-8?B?OWEwUmpiMlJ2U0ZBdGZNTUUxNnoyRTlrVlVkMFBDYU1KcFRTVDlGM25XcVJP?=
 =?utf-8?B?TzB5dEg5bkFUWUg4L1U5V1hHQ3ozcjNvcnY4a2sxK1ArSktQTzhlM0lQb1lv?=
 =?utf-8?B?RUlKdlBjTVVjWnhIWkdlK3J6WGplUEdyTXh4djlSMXpnQnZFRUF6NnY2MzEw?=
 =?utf-8?B?YnZhWVBCc0dCcWY5cGV4L2Vqd2NaOVZvZ0p0UnRsM2lscXdjNDRSekRSZUFa?=
 =?utf-8?B?ZUJxZXpGa0YrTGRSa3VQMENQT0FzSVpFR1JwOXR5MllmZC9mSTlhT0VnKy90?=
 =?utf-8?B?eTJ4c0NLbjNEeVZuNERpK2UrS3VFbEM4MDRvdzE2UnhZRG0vRjZGbXFNZHl6?=
 =?utf-8?B?TU5XUUl3YzRSSE43YXpaZjkrTnRIcVAyR2x0QkptNWY4R21yQi9UYVpyZGg0?=
 =?utf-8?B?REdpN08yZXhaN25SUzg5WHEzV3F1MHFLSExXeWxCY0laZ2ViNXpJVEltVTFW?=
 =?utf-8?B?QXp6UXo2WXg5eXYzRGNjdEpQK0t0Nk9CSGt5U0MwMDZxRW1VOHZUSU1kSlYx?=
 =?utf-8?B?U0VOWHpUVVBrWEVQaUdxbFh5RkZ2TjJ0eVB0Rjc3bTFKTnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3M0SGRET2RubmFPT2RPNEoxdWJ5R0tCNDFTUENMMXJSZWdnSUFJQVNJV1J6?=
 =?utf-8?B?UzNsTkQ4ekZ6ZkJHNXo3ZkdMZGV6K3VjTnYrRUxRN1oyOWl4bS83QUh3SHFa?=
 =?utf-8?B?SWJ6ZGpNeGJlMTFrYXhnZjJOYWt0Sm14Y01nWFI4bWJxc0YzUndSaENzRk1G?=
 =?utf-8?B?TUVrQVdsSS9hMjY1Rk1ydDFRN1h0TW9QTE56WC9jdWprd1J0c2dVRmNOV29p?=
 =?utf-8?B?anIxTENlaFhLcmd1UGh5QURFSDZqM29GQ3dyUXFiZGpqUGIvOVM1c1o1bU1k?=
 =?utf-8?B?T3NwdmZnQ3l3MjBDNG43dXJnK09Hd1dJYVo4LysyNldzVVhMWDB1MTI3Vk9I?=
 =?utf-8?B?TUR6Q2xrN2RINUx1ZWh0NGZYZmVCYkFKQmdPamhqc3lyNVdyTlFoaTA5aTI4?=
 =?utf-8?B?am54bTg3Z0ZJdDZiRk8xL2VPUnNSV09rMnJiQjhHU0tDS2Mwd0xnN29kWDgw?=
 =?utf-8?B?RnhqKzZmNkdvNURKZ3dHQy84Rm9xM1QyT0F6bUtvMDZ6ek1Cd2RYTHpvMEJa?=
 =?utf-8?B?SytHSWl2WVZsbmh5ZVNrTko0Z2JjakxKd1ppV3BVdVk2M1dQKzE0b1pmK2ox?=
 =?utf-8?B?dlhpSk1ybmZ2a3R5TXlXVWkxZWZsNkZHdndtd3RINURVUWNPK2NGMWtreHd2?=
 =?utf-8?B?NVNrU2F6UkFMcWZjL3gvSmJxZmNzQXBubVYvMmxVVzE5TVI4VjY4dTRZdkZl?=
 =?utf-8?B?Z3Eyb2tmMVNFVCt6d1VaUHNVUlZKemMzSmw5VzBpMzM1TGc2K1YvNGk1ZG1J?=
 =?utf-8?B?WURWZ1M4VGlLdjZTaSs3WmdiVTFPMmVlaHJZMGFkM1J0Uk84UEh6QThwT1Ey?=
 =?utf-8?B?UVBucDNnQ1FPdUZCMHR1YXgxU1hkL1JYWUg1c2l6SGxmUDBWSXltK3BBNTI4?=
 =?utf-8?B?K3orcDl5cWVVL0JaSy9WV1lOZzdMV2dpYnlaUlFTN01QUEMrRFJKMmdnaG1C?=
 =?utf-8?B?VmVPTkIvT3JlSmhNSWxaczk2OUZaYjJ5cXZhYmp2M1ZBWkhvdXZRRFhGZHZH?=
 =?utf-8?B?NGFKQ3RRdWNpNEh1MjArZ3QwWmpUMG1nN1kwZGR4T1BiZGc5VW5zVkhYbllK?=
 =?utf-8?B?WWl3YmJXMGlaTnJqTUN4NUFpYXdTK3FvbTBBKzlmTVZMaUJOVVpDMTRkR3oz?=
 =?utf-8?B?dDlwTTdua05peUsrZVE1aGhvRFhYTE10WnJEaXUzTmdFYzltMjJOWjNNVnI3?=
 =?utf-8?B?a1dnVlFsclE2RnBST3lzMDZQWDZ2TlZIVG4yekN2NXdZeE9MNUhPc1ZOY214?=
 =?utf-8?B?K3VWSDF6MjBkM3dPR2I5MEpSOGVvL016SnFyVUNDeWVuQ0FoTmtVYTZjRUFm?=
 =?utf-8?B?cUtqekNtbUZGZ1Q5Szk2bmZEZk1yNUFCQ3hQa2l1RjNITDArS1NVVVU3ZTVs?=
 =?utf-8?B?QlNoL1ZOS2JpcTYwcmJXM2t2d09rR1VURU5MS3FYd1AxRzhwU1RxUVJZK1ZK?=
 =?utf-8?B?aVowTk12UmxWeHk4eE0wcTUvNTg0L1BzTFpjb0R6ZnNRZzRQRWlrcStnMDFv?=
 =?utf-8?B?RmZCYW9EcXFMUzEybUkvNTJzRjRnYUU0TG1wN3dVQ3QzT0diellJUi9IWXFS?=
 =?utf-8?B?Rk1UNmkxUGRPMW5VTDI1QlFPSDF6blZQeXpSWlFFcHE4MjkwRURobG03TFJF?=
 =?utf-8?B?T0NVMTkzekhrNVhqRys2S0RqbDF4cmI1ZnlFN0lUQ0ZOUHUzQW83cDZFMmlC?=
 =?utf-8?B?Tzk5ZkVrSEFMSEVaN3JWajQxRXd2VnF0c0NmUVJ2UHJZeUYwRUh5RkRhS01N?=
 =?utf-8?B?UlBkWTR0WlllVW93VnIyY2Y1eDYxbHFpMisrL1BSenlvTjdjaFBFUUsrdjEw?=
 =?utf-8?B?UjBYOThzMTBtR0hKNVcwd3pRV056Y2ZJMGxtdEwvUWQyYVhKc29YNldGd2N4?=
 =?utf-8?B?VWJ4MVc4cUFOaCtWenpGM0Q4MmxQVHdhMUFzTUM1VTRBcUVJYUVLZ1Rhd29H?=
 =?utf-8?B?NGJwY2NMS1N0czFINU81WXlGL2dYbXpVSm54em4xWHFXSXBRR3hpWGM0Ym5F?=
 =?utf-8?B?VElqei9sQVdEc1o1WXRSOVpkd2xpazFxTXZEUmNtWUdZY2pnTDd4aHhXeStq?=
 =?utf-8?B?UGFRWTdFbWFTQ3FrQ0ZqaHRLaXhtUkNLZDIrVVhHRFRneDJXbVNaQ3o1ZWNj?=
 =?utf-8?B?V2puLzYxUU1ZMU56bkgzSVpTWTYxMXU0YjlMRUt4akUvQ3hSNkRjaUlqUzE3?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C51D6CEF6FEBF44A3283FB719EC9FB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30281c4-2308-40d2-2b8c-08dcbab29dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 09:39:09.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYHU3+SezPM7bcKmHHUEHANg7IgGqkgAPcrE1n53QRZiFVAz+KEdGdpps6HN8JYHAynbDrLcB/RmFeIWMDON5b5OfE0Ba/oWbEFW4HozvrBnyc3gp8/H6ZwUSk72iNwW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973

SGkgQW5kcmV3LA0KDQpPbiAxMS8wOC8yNCA5OjM5IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIEp1bCAzMCwg
MjAyNCBhdCAwOTozOTowNUFNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBUaGUgTEFOODY1MC8xIGlzIGRlc2lnbmVkIHRvIGNvbmZvcm0gdG8gdGhlIE9QRU4gQWxsaWFu
Y2UgMTBCQVNFLVQxeA0KPj4gTUFDLVBIWSBTZXJpYWwgSW50ZXJmYWNlIHNwZWNpZmljYXRpb24s
IFZlcnNpb24gMS4xLiBUaGUgSUVFRSBDbGF1c2UgNA0KPj4gTUFDIGludGVncmF0aW9uIHByb3Zp
ZGVzIHRoZSBsb3cgcGluIGNvdW50IHN0YW5kYXJkIFNQSSBpbnRlcmZhY2UgdG8gYW55DQo+PiBt
aWNyb2NvbnRyb2xsZXIgdGhlcmVmb3JlIHByb3ZpZGluZyBFdGhlcm5ldCBmdW5jdGlvbmFsaXR5
IHdpdGhvdXQNCj4+IHJlcXVpcmluZyBNQUMgaW50ZWdyYXRpb24gd2l0aGluIHRoZSBtaWNyb2Nv
bnRyb2xsZXIuIFRoZSBMQU44NjUwLzENCj4+IG9wZXJhdGVzIGFzIGFuIFNQSSBjbGllbnQgc3Vw
cG9ydGluZyBTQ0xLIGNsb2NrIHJhdGVzIHVwIHRvIGEgbWF4aW11bSBvZg0KPj4gMjUgTUh6LiBU
aGlzIFNQSSBpbnRlcmZhY2Ugc3VwcG9ydHMgdGhlIHRyYW5zZmVyIG9mIGJvdGggZGF0YSAoRXRo
ZXJuZXQNCj4+IGZyYW1lcykgYW5kIGNvbnRyb2wgKHJlZ2lzdGVyIGFjY2VzcykuDQo+Pg0KPj4g
QnkgZGVmYXVsdCwgdGhlIGNodW5rIGRhdGEgcGF5bG9hZCBpcyA2NCBieXRlcyBpbiBzaXplLiBU
aGUgRXRoZXJuZXQNCj4+IE1lZGlhIEFjY2VzcyBDb250cm9sbGVyIChNQUMpIG1vZHVsZSBpbXBs
ZW1lbnRzIGEgMTAgTWJwcyBoYWxmIGR1cGxleA0KPj4gRXRoZXJuZXQgTUFDLCBjb21wYXRpYmxl
IHdpdGggdGhlIElFRUUgODAyLjMgc3RhbmRhcmQuIDEwQkFTRS1UMVMNCj4+IHBoeXNpY2FsIGxh
eWVyIHRyYW5zY2VpdmVyIGludGVncmF0ZWQgaXMgaW50byB0aGUgTEFOODY1MC8xLiBUaGUgUEhZ
IGFuZA0KPj4gTUFDIGFyZSBjb25uZWN0ZWQgdmlhIGFuIGludGVybmFsIE1lZGlhIEluZGVwZW5k
ZW50IEludGVyZmFjZSAoTUlJKS4NCj4gDQo+IEkgc2VlIHRoZXJlIGFyZSBzb21lIGZpeGVzIG5l
ZWRlZCBmb3IgTXVsdGljYXN0LCBidXQgb3RoZXJ3aXNlIHRoaXMNCj4gbG9va3MgTy5LLg0KU3Vy
ZSwgd2lsbCBmaXggdGhlbS4NCj4gDQo+IFBsZWFzZSBzZW5kIGEgbmV3IHZlcnNpb24gd2l0aCB0
aGUgZml4ZXMsIGFuZCB0aGVuIGkgdGhpbmsgd2UgYXJlDQo+IHJlYWR5IGZvciB0aGlzIHRvIGJl
IG1lcmdlZC4NCk8uSy4gVGhhbmtzIGEgbG90IEFuZHJldyBmb3IgcmV2aWV3aW5nIGFsbCB0aGUg
cGF0Y2hlcy4gSSB3aWxsIGZpeCB0aGUgDQphYm92ZSBwYXRjaCBhbmQgc2VuZCB2NiBwYXRjaCBz
ZXJpZXMgbm93Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAg
QW5kcmV3DQo+IA0KPiANCg0K

