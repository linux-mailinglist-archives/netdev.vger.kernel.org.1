Return-Path: <netdev+bounces-114395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A494257D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692BA285D53
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C01BC20;
	Wed, 31 Jul 2024 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G0XSCFCE";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dgcT6LRr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996542905;
	Wed, 31 Jul 2024 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400786; cv=fail; b=ruPefkobCHeMBEAIqE3S/LExnpsS64HUsLy+WOrB+4s66pFZauVJmjWdGAv3T/a6WhQbaEwpwPDHFEmoQNJKcg4T/2EBQ5lEP3l0voVFr+6DN6o0qjiffE7VW90RhGcYJrWsN3p2mscsJtUHo4yv2mKwH4u4wTPjRSUEMK9gsVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400786; c=relaxed/simple;
	bh=BozueTC5MvVx0j1+XIIPCBPorhbXEqzFxvp18lV1tls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T4kwIDRXr+U5B7eWHEaRYYRfB/IFgfZ+1fAVK6bm481pwoB47OfsvGoP9MpLCooL5Ro93N2DIdwBBwBx9tyMDYWpBmPMytgXdgQPEgtI4Fzd+bc2ixAxjUS0PFwbFShUsy3Rk3VkQTp0zhc3qzfjlE98HUtFXisKVXI8UwoEDHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G0XSCFCE; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dgcT6LRr; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722400785; x=1753936785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BozueTC5MvVx0j1+XIIPCBPorhbXEqzFxvp18lV1tls=;
  b=G0XSCFCEpd+mjWRG4UFsp59GD00VseYjzc7+7b+WeV18OF8fHMvtmT++
   JXsCFtDRczd09TzFT2sd5COP1wgTTROO2PTqvf6C4iYi2STwZiaGZmQ3s
   iPRJpuC1kLG4tCDk+tbp05DyYAdYeEf0dqHASiRISP78IqATjq6j6dqAZ
   R7olVo3HzKSIKTvp632xckSafAvQum/DcQxm3utiC8ROcbtbZ3hdT1QGe
   haOYfw1PoJkdhHA+Dt730ts3JDrF3VRmKiKX9sr1fQiwlaCRtGvtaoNxW
   Ntk00GBoL/MK7DtY2/yuuj+Hx8LPYe0ooy/uh7s0fyCdYkvsOBGg2csi+
   g==;
X-CSE-ConnectionGUID: KkMM5YtlSamVtcnm9A/+VA==
X-CSE-MsgGUID: Vkw9TtzOTMKlk0zu23uzfw==
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="260802555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2024 21:39:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jul 2024 21:39:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jul 2024 21:39:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSdizqRNci8fxiFc/CHDrS1lsytf6oQ/2I3E3BHS9AlmHA2npUstJ99Xch0KkKicwNLHMXEOOU0qks+s057xrpWVEUpOk7Ab0K/jCclnrBG4Tcsa5iRQBE29J0d3xkXE4MoekJkn5imLmL1ovQa4lBNatHcJyZ6+AjWGH9uGDxAWHaH6hzTqPaZkOQeTHWBQw2J5G+ErgFWRYxMh6UqeB5hDgrjjrdywiCd99erNniFed/3hC+9iEFHj+rUaZHiFqdheeD+vLna7Ra6hfzVzYgYqshqECjDtoy4hDmkBWazhXR0Za2uZePTeeZCNmX+R8apk7Fi/vEipyOQtSnAXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BozueTC5MvVx0j1+XIIPCBPorhbXEqzFxvp18lV1tls=;
 b=kK4894fra8tUvQXgPcyi0tmmZd4OokEgJDsi2/LzpJWB24oUit1GOODzJqnjbsQcd2LHRyQfJq2NVGIJtPT69knTGbFyYp3kfNcYWRX6PS0+l/+5d94JCFYGnt2XONJk3jV0m4/KuPVZ9BRwlRmXi0Mqm3+wjdOR8a3Lp9ZrtLx4vyAPg4i5e8Nkh7p6QI8l/ePDfVttqYL0cLnCG6pc/sdwwWdkJzcSbUl+9/rB815eEtQkLs6EXiO6VAyogbjfvca9rntTYBoi3ImPl/DbagiS4rEA4tCOfhTtGYiTnMhOxXb76Gcp/2DfGdvk5G9vP/LD06j4v3y11xXkzRweuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BozueTC5MvVx0j1+XIIPCBPorhbXEqzFxvp18lV1tls=;
 b=dgcT6LRr5WwKaKvHZdqmrrlzonW7MU/9hPpZosGHjVF5B7MwWMu/iqJzBtrNJabwKAEnEdevkHM47BN+taYAlhybYFrsFRaGjuKwGvyReNVb6wa3w3PjsXwxpjdooLzcpYQCehIPtE1xeP/XSUW92NXalzJ/SSkqNH4dtiJlg2chJDLD1kGOEHdG3YEjdz0qcsTCbK3EinaCCx0gsl762qkxOJqf8AWFLvEvn6wRcNTvKuqE6iATLCu19l/sNHeY+JMfrFUerOZoqqr/R5HWwRV/73C3cv5aN8eyMVJlk8Hbl+JdKM6KwZwYB066vxieV/WMn+dM/9Cq7+TbUi1HWA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 04:39:24 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:39:24 +0000
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
Subject: Re: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHa4jYoQi7UR4YEek2xaercqJQ567IPudUAgACI7AA=
Date: Wed, 31 Jul 2024 04:39:24 +0000
Message-ID: <2b98fb5f-a5e8-4db8-ba5c-4cec9b5dfd63@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <c9627346-9a04-4626-9970-ae5b2fe257da@lunn.ch>
In-Reply-To: <c9627346-9a04-4626-9970-ae5b2fe257da@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|BL1PR11MB5224:EE_
x-ms-office365-filtering-correlation-id: fbbd4ea2-4d26-4c2c-e21e-08dcb11ac0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVhrbkRaeUxpaWhuSjZmeTk0UkxLZ1Q2bDlOSVJSY2tmWnFJSEdOMWMvOXFH?=
 =?utf-8?B?RDdmZnZHMG43SDBONXMwV3JaV0NEMHRJcVlsSWRhZEljTER6Sm85cTlYYlBF?=
 =?utf-8?B?dklsUE81UWQyKzZRTmdNbkUrRVozR09tbzRBQzl4RVpZU1Q5RnplbFZJUDFJ?=
 =?utf-8?B?OWFYbEhWbThSSTN1aFZBc2JFdHRzT0xyRkFjMXFFYkYxV1lkTWdSeUVYMDJI?=
 =?utf-8?B?OXcwcHlQVWFpaWlGV0ZPWGw0a2IvTm9GaEVTaHNaNDhER0pENW5EWnJqb0gx?=
 =?utf-8?B?azQxc0RmelB4eElnUHhIYk03cm85cDY4Ym9tMHQvRmFKSFdVZmRRTGpqdDlx?=
 =?utf-8?B?K2NCOURycWM3dkZGcFYyQUl6dUptZHFTZGN2K1dLMHcxRUxzTVRhZGpXV2Jp?=
 =?utf-8?B?ZTZycHVRVGU0cWNiQzZ4V01pb2Q1V1ovNkNKNGJmLzZLamcybUhWeTQ4U2Vj?=
 =?utf-8?B?V2xFam10YUw0TmVDcFQ4STVtTzVWMVR0MUFHWHc0aTdOQmJYOElsV1RKSk9k?=
 =?utf-8?B?ODVFeWM0d2NNNDBTbUxadnRVcXU3c21jNFhrQXE2QlIzSVRaRS9tUjM4LzJ3?=
 =?utf-8?B?ektRMDRRT2ZBeS8vSWpuTkVKeXkxbm4xVk5NKzExNXc3WlNYRzZFNHFlMHN2?=
 =?utf-8?B?K29Fbi9wcEhOTzBGTjFSbndSak1tVHhFMmsrTGgvNWdLM1VldWZDaEVHSTYx?=
 =?utf-8?B?L0lLQ2pCUDRZMnZJQVEyRlJXclRaaS8vUkZ3ajJRMGM1L1UxTXc5Q1VLQ1py?=
 =?utf-8?B?dkRKZ2J2UFhWUklTY2o4eUxSTUxLZnpJOGVwNXZlNCtWZU5JZTNKd0xiTGxU?=
 =?utf-8?B?LzZaQVJ5UEx0VnAwa0tONW5oMGxWZHlVSWtvYUQ4TlJYWXBDS2NKUlRDSmI2?=
 =?utf-8?B?cWh1dWZyWEszY2hYV3pieGlobER5RGJXN3Y0ZkhKc25rQW1TaUtsYURjOWpx?=
 =?utf-8?B?RnFzcFVYSDlLRDE0dHlJRWNuRzdFN1puaGExV24zVW13aWFCQUR4Q2pvc0lq?=
 =?utf-8?B?OHNob1Rad1c5aGJmZDFxeFhKNFQ4bzVRNEpEY2w1V3RJaXl6ejAzVDBzeFRY?=
 =?utf-8?B?endYKzNUaWkyTHVYQ3F6TFRmWmg0QlM3ZENxSUFJZ292cEowWWdTdnd1YnNl?=
 =?utf-8?B?QWFqQ0IvdjJLVnNwcVFNTmlqZERtVlpKVEUwSzZTVytpY04wQnJ5VzlTOG5r?=
 =?utf-8?B?SHlJUzBnNE8wUzhsck56NDN3RUFuNnNaZVVZK2picm5zWjRkazFFSGwwYUth?=
 =?utf-8?B?MzA4bnpuUWNmVTFURTMvemxtZXkwN3VDYzNROWtJdTlrMVh5eHAyZXdtZElh?=
 =?utf-8?B?VG5CdzlGN1BWdlI4akdERzJ4Z04rNGRwYU1XTzlwRXV5SVdSa2dCZWN2MGg4?=
 =?utf-8?B?ditySmtpV0RLc0JjbHR0T3lUVmY2OUdQNGxhS0ZCb1A0N2NHVnJCQTVMVVMy?=
 =?utf-8?B?YWFQNDIyLzFLMjQvcW5TV1J0MFFtcnlQR2dXNE5lRE1mVWFqYVo0dDFRUTVa?=
 =?utf-8?B?VzdOTzNLNWlNd3BRanlmQTAzMG5hVi9FVERtc0FIUGsvdUExUVluSWJzcWlx?=
 =?utf-8?B?K2Fzd0V0S2dpQ2pQYzBvZWp2NWpxN29XVWFrYlppNnYxaTZyeDUwNnRtcGtB?=
 =?utf-8?B?K0JaTHdDb3pneEtDWUNFTTdKbTNvVlhrNklmd2FyczlUOGNYVDYyL0FLa0xx?=
 =?utf-8?B?bGhYN3Nlak81N3o3QUV5UEhrVmd0NGpaSVpYaHZYQWN3NHJWOXFXdEsrUnBi?=
 =?utf-8?B?UmRoQkh3TUlZRjZwN1FMWHRETDYxUUxaNmhOVkgxY1dFQzFIVWYyaUF4Lzkx?=
 =?utf-8?Q?tJYuJbxE6avEdvp/tE1gdMIzq+GDbfI9smDew=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFaUDdLajZkSDZQZDcrL0JsNWtoTm5aVHFJZ1pmY1d5dGo2YXh1U2txT3Av?=
 =?utf-8?B?NUNHejZRMXV2c1hLKy9SbktNWDVkSU44Qm5mQjFjM0IrTlJ3dUtGc2haK1p0?=
 =?utf-8?B?b2xkTUFTbnFxaUp0R0NnRU5RaWJoRytlZTdmczlNSVdkM00yem9UK2xFWjls?=
 =?utf-8?B?VnZBUFNMSE1ZT0laRlNoNFRwNFNTaVNPQUpKdXpVMEJoUkVBQndmc2JnRUhX?=
 =?utf-8?B?MG5UVEJZNTNJSXpVeGdqRGczTU00SFF2T1pseklLNE1udEM0Szg3Vkt6akN3?=
 =?utf-8?B?MG5UWnYrOFhYaFpRNzZ4OFRoZWVramJjeEhFS3ZWbVpVM21NR1ozb0xkdWoy?=
 =?utf-8?B?aHl6RUlqbEl1RzdlZ0kzdVhDdXA1amJ3YzZJMXhmWStlMG9iU25abG1Wc2F0?=
 =?utf-8?B?cTlUV3VIemN6c1ZtdjdiNXlBOU1UOWpoSTd0dmhibXFaZkgyaWYxbUMxUXN3?=
 =?utf-8?B?eGpuZ2c3OC8wdjZNNkZWOU1PeEdYaEFqVDR0ZlVFaWJoQ3VFN0RjTnlGWWIv?=
 =?utf-8?B?eHNkeTkyYWwxWk9lMTIxbTFkdENlR0dseUJzU3g2NWNOaHBRaHNVRHQrcUdk?=
 =?utf-8?B?V0Y3WmozR3ZOV2lwMlBrRkxWUnZBUjBHRGR0dzVtZmJBQllhTXNPcm9yTEdq?=
 =?utf-8?B?SHVCSVlwMGlUd0VmWVJzL0lNNTh3SDVabm5ZNGtzNTFGRWFnRC9kUHVmanEz?=
 =?utf-8?B?VjkrdkxIY3g4VzJKbXJGV2NtUWZXUXFOaFUvQnNrVTlWS3J1VTRBclJ0NkZv?=
 =?utf-8?B?eHVVN1FwVUhQdm85dkV4ZW9vdUltTjlGN0dKOXg5SDBpdEhaak1odXJIdVQ3?=
 =?utf-8?B?Rk9Tekw3VFBjZWY4TkpLOUY5Y05FV3lYMGxMNmZhQW0zUVUrTlRWRWhlM2xO?=
 =?utf-8?B?NWFPNE9sc210engxWTRTZmJyZytkNnZ4TURZRDZmQVNjd0lKbG5NWWdNa21J?=
 =?utf-8?B?U2dmN2NFemxCaGhRd2diSGJmOGFIZkI1V0xGRnZVNitjb2YwLzYzQzVJa0JP?=
 =?utf-8?B?bVZVL3kwQkFNUGxxbFRSVk5HRDByejVSYVM1N2M0UFM1RzNoQnRvWDVXZzdl?=
 =?utf-8?B?RVZ3a0hWek5RbzNBenRKdGkybVlhK0FZOEZORzNzUU9rT2JteDRTU0VINWEx?=
 =?utf-8?B?RFl4WXYyRUFkN1dTcnEvUVgyMitZWnZiTWdKaVVQVTRnZE0yM1NIWUhmQzF3?=
 =?utf-8?B?cGtsZytTVk5xWTJuZHM1KzdYWlFwZ3VYM01CUDNnWGtVWXhKaXhGYXJMcExy?=
 =?utf-8?B?TUNvSHNMUFhpY3hhcW12Qis5R2xXR2EyN1pGZ2tVUUYwVlVSTll3ekdWRnlX?=
 =?utf-8?B?cnJ5dzNZb090NERybkxpUEFhRDB1eGZ3Z1ZFeW91bW5SL1hFZnE2VmI3UG9T?=
 =?utf-8?B?QXo0aEJXTU1udXhGQnVCSEdBOUdWbk1kUys5NVpKa0VpMHBGRVlaVkZ0czc1?=
 =?utf-8?B?ZDRJWGVZeGd5enc2OXoyRDY1VmxHNUV6YUhqMks3YnNETUYrRzY3S0FPSDJx?=
 =?utf-8?B?cGs5Q3JkODU0NHhNUndGc0JhSVpVL0kzajBnOXpuWlk2Rzk0OWE3bzVpRFQr?=
 =?utf-8?B?WDhVS3VWMEpGcDJLdzRLZEdVMnFobllGZVM5bE0wZmNPRTdjTmZrRmNPWjcw?=
 =?utf-8?B?ME9tT2JTNm5vc1pZNVRqWEdCNHU0Uzc0NVk4aXFZQ2VVc2o5eDJFS0xCT2M3?=
 =?utf-8?B?VWNlVWxaZ1ZQdkdtY3dWbDJyTFJjaEZnZUhsQktDMmZ6VzY3Qkxzc1JLZWQv?=
 =?utf-8?B?R3pjdkczZyttRlJsTWs0MHhENGRZeUZodkVDdkNzYm5Qek5meHZHVlJYYkZR?=
 =?utf-8?B?Tm44eGZ2RkJxSXRRMFhZNm1hWDVNTVh1L21zTStHek1xNWhYdFBEREFvdm5S?=
 =?utf-8?B?SzFRaXJDUGJUTkQ1RTVsVExCbmdCa2VmbWVDVHJhUXRucXZJenR4VjVVc0l3?=
 =?utf-8?B?TDY3dE9sWStuUGoxOFJWWktPc0FRckZvMk1WdytiTGJOYWVNcFg5MjdQOGU2?=
 =?utf-8?B?Um04R1NXc2ZtcExzTW96QWdXQnNUTkZ4VDBpeHdCOVhmd2NLdGtXeHVrYmJK?=
 =?utf-8?B?c3NvNW4rdWlvenhyUGN2SUdDb2xwcWxpRkVIam9DSUN6THdvZ1VNTVFvZ21p?=
 =?utf-8?B?cldVS0NMT2JscnNqYmVKcXBOVEdsSXZqSElsMlJzT0FTL0o3OVNMci82RVFX?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DCEFBD298EF154C99C555DA3BAD6CDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbd4ea2-4d26-4c2c-e21e-08dcb11ac0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 04:39:24.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtayZM+gM8GaeE3Rm6QBXCSD/gIefg/5xfatzlsLZbAp1XkcWd9HysFPBiOv3uCiuwzh9GCVzmTMBM1eks/eIbYi94rzUpfcM1gAy6WljW+kf9oBapdWwUfEhMJFzGCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224

SGkgQW5kcmV3LA0KDQpPbiAzMS8wNy8yNCAxOjU5IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIEp1bCAzMCwg
MjAyNCBhdCAwOTozODo1MkFNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBUaGlzIHBhdGNoIHNlcmllcyBjb250YWluIHRoZSBiZWxvdyB1cGRhdGVzLA0KPj4gLSBBZGRz
IHN1cHBvcnQgZm9yIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVy
ZmFjZSBpbiB0aGUNCj4+ICAgIG5ldC9ldGhlcm5ldC9vYV90YzYuYy4NCj4+ICAgIExpbmsgdG8g
dGhlIHNwZWM6DQo+PiAgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAgaHR0cHM6Ly9vcGVuc2ln
Lm9yZy9kb3dubG9hZC9kb2N1bWVudC9PUEVOX0FsbGlhbmNlXzEwQkFTRVQxeF9NQUMtUEhZX1Nl
cmlhbF9JbnRlcmZhY2VfVjEuMS5wZGYNCj4+DQo+PiAtIEFkZHMgZHJpdmVyIHN1cHBvcnQgZm9y
IE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2LkIxIDEwQkFTRS1UMVMgTUFDUEhZDQo+PiAgICBFdGhl
cm5ldCBkcml2ZXIgaW4gdGhlIG5ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC9sYW44NjV4
LmMuDQo+PiAgICBMaW5rIHRvIHRoZSBwcm9kdWN0Og0KPj4gICAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+ICAgIGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4tdXMvcHJvZHVjdC9sYW44NjUw
DQo+IA0KPiBGWUk6IFRoaXMgaXMgb24gbXkgUkFEQVIsIGJ1dCBsb3cgcHJpb3JpdHksIHByb2Jh
Ymx5IG5vdCB1bnRpbCBpIGdldA0KPiBiYWNrIGZyb20gdmFjYXRpb24uIEdpdmVuIHRoZSB2ZXJ5
IGxvbmcgdGltZXIgYmV0d2VlbiByZXZpc2lvbnMsIGkNCj4gZG9uJ3Qgc2VlIHRoaXMgZGVsYXkg
YmVpbmcgYSBwcm9ibGVtLg0KVGhhbmtzIGZvciB0aGUgaW5mby4gVGhlcmUgd2FzIGEgY29uZnVz
aW9uIGJldHdlZW4gcGF0Y2hlcywgY3JlYXRlZCB0aGlzIA0KbXVjaCBkZWxheSBpbiBwb3N0aW5n
IHRoZSBuZXh0IHZlcnNpb24uIFN1cmVseSBuZXh0IHRpbWUgd2lsbCB0YWtlIGNhcmUgDQpvZiB0
aGUgdGltZWxpbmUuIFNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4gRWFnZXJseSB3YWl0aW5n
IGZvciB5b3VyIA0KcmV2aWV3IGZlZWRiYWNrLiBXZSByZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIHN1
cHBvcnQgb24gdGhpcy4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAg
ICBBbmRyZXcNCj4gDQoNCg==

