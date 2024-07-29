Return-Path: <netdev+bounces-113501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C293ED32
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C231B20CFD
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0077A82C60;
	Mon, 29 Jul 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qlgv1bjG";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gliVPuYw"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D387E1;
	Mon, 29 Jul 2024 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233454; cv=fail; b=NvxtTYfGavHARFsUOrlhg/6dSAEDIyfqNUfjHm/hXWw463mYXVTXYl/dwxpo74ZLEIC00FIyJbPCLZet1/95b5ZWB3BsD8BebYC6S5p/3T0ZBE0WhsSJBSJIZbxzNc2vmUzNd1H/JoOgi4S770PpKMBRiHwulWj2zNHdKl0nWlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233454; c=relaxed/simple;
	bh=miWdGxOFaRLxaSDqZRvSpIc7wsMlPpNN8jk8SbNRWBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/oqrMwpcYKMZJmb4UzwMLACXPajolDjrpdEkKoMpvToq3G94DPvLePFhJm0JzpRzg97JhjIudPHmKsqekFaS6IIAOt/Jmi3J8ozYc7iAeK06mn6IAbr+Bb+0vzMlhVrWvYvXUml6DFKgLV+9a9SHHKp4AcGgbc8gO4YBkp4vbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qlgv1bjG; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gliVPuYw; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722233453; x=1753769453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=miWdGxOFaRLxaSDqZRvSpIc7wsMlPpNN8jk8SbNRWBk=;
  b=Qlgv1bjGU2/LSNQtpMhz4pAioBx5/51RW7x+qtbbST0hWuJ1HB6j9E0a
   q5rjTnrClfOKrhUIXe/hD6G2zC9nJtbymu0QHQZtIRKmNpW0eyq4Vx0yZ
   OoPOh0Wro6AIcE8eN9pUsSMLpzsrph9sWmEcE4Mtjz+dDJ0K4iQDjGuXu
   l92yJd8kKRX5mzuRKi7ABmAgPVbeOw9ijKdrJeRH/89PFuqUQCOu41HBG
   iGQBb7QrsngI0XcCRi7SzseqRj/4gk/5iJQyUsj0LDttqjsfZoozKsbTy
   P9d2F8LudHNQI4ornNmiDTHM3c1LGlR47q5FghqQiKFaM/tXeI04iDXIo
   g==;
X-CSE-ConnectionGUID: grWoXVXTQVy6ypbN3FljCQ==
X-CSE-MsgGUID: kzLDl4BoRiKTolKkcBRnsA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="260696447"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 23:10:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jul 2024 23:10:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jul 2024 23:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctbUR7100V16RUTq5P565uscURqCdy5aGTZOwmCU3QKioIY9brXhccBoy4dN7i+wdKtWAMOzY+JynfIkBZ2ZWmWc4ZUMGg7qKZEewhYs3WcrL94SCmrA32ciLVgbhjob6B1biPfu2EDfyRM9fSfO9yWC04b33ftNqCj7YwpIPxmEpg1KneLqvn262Jf1IHsOTrnxqjfxbUnTdX3m82EhPHE17rfJef44IE8pTx8w1GOV4j9vvQn7Na39ddxQK+0nqsER00KSp9HpASxAhtEnkaNVy8Bc/4HUbWl+fiNH6DiQtMwJhJSjE/IkWxF0bSTfTH4YXDrnSJCa0DQcAoQjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miWdGxOFaRLxaSDqZRvSpIc7wsMlPpNN8jk8SbNRWBk=;
 b=w9j6thHE7Zhk0pUHGtDTks0Zn2H2BpgLUOcfY5F3bxI1QtEgr6AA/W5mWYOdZb7IkisvdV0avteZ7U7RF7A7lqM3ogh7PF7QuCpGFQ8OhSZyMIKWyWKz8n3JgT5jatGnKsDHx6rcleplsMI+ldBMelr+KW7ZnLcxHLg5vNR6pkbsLm53zJ821BZolmis+lblPCKKrQJ95uFWbQGJTeIFNQaK8egYnEuwDbeduCXWZoZi4dmcY//XTj2+UO+OzWgfDxQcaxOC5NcRN0HXkEDL5PJvPvOuGf4R/ZKs69301PfUTTvxMfHKzpJKKm75t+oQNnxHmtuKB5hQBuhvsq0bsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miWdGxOFaRLxaSDqZRvSpIc7wsMlPpNN8jk8SbNRWBk=;
 b=gliVPuYwQy0GAArtT0xAwL4kDMxulHeeya6CRm41Db9FEZrG+xen+dnIkZhI2Yr49jvthnU/6nXUCU4vybZOfwz6uWODknQU65fxObyFWDy4HBPG+mXQk6HY+gRvkMsiEqd/x9Q8+q5m/NDOksDb25FOm0zJ54zM3UToMc1IgOM6JUvv2Ucu7Z7MMj+2WWAUnUEuCPdOle63mjesjYh+nKxPPsxpIhLPcTyrpQbxOXzZCV+Z/QFTKngWQmUhmuS7YcqGRRAsI8GKjLDTybE8NdoIMbdHQqHfTKiU4QaEyVl6wv1uDhtQQFFEoZMfeuTjzIv0AJbGkEEpI4wLB/kZJQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:10:37 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 06:10:37 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <robh@kernel.org>
CC: <Steen.Hegelund@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<andrew@lunn.ch>, <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <Pier.Beruto@onsemi.com>,
	<davem@davemloft.net>, <conor+dt@kernel.org>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <saeedm@nvidia.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <anthony.l.nguyen@intel.com>,
	<devicetree@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<benjamin.bigler@bernformulastudent.ch>, <ruanjinjie@huawei.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux@bigler.io>, <horms@kernel.org>,
	<vladimir.oltean@nxp.com>, <linux-doc@vger.kernel.org>,
	<Horatiu.Vultur@microchip.com>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHa31kbt6C35mOdzUWLJWMcrZ9WrbII/s8AgAQ+xQA=
Date: Mon, 29 Jul 2024 06:10:37 +0000
Message-ID: <da9a4f05-7cee-437c-8c00-9ac0c14eb175@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
 <20240726123907.566348-15-Parthiban.Veerasooran@microchip.com>
 <172200010240.1530361.10067496666538570000.robh@kernel.org>
In-Reply-To: <172200010240.1530361.10067496666538570000.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: 982d50cf-f89a-4dd3-b961-08dcaf952a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3hSV0N4aVBIOEVjamRhdStXbE5GdWRNRC9GQW5laTVGWm9jV0w0SnNmOUNT?=
 =?utf-8?B?SkRGZFVKNjlpbHNTc3FEa3Jyb1dia2FJWXovV0E5VUduQmc0aVZFazJ6NUYx?=
 =?utf-8?B?U01ET0F6SFpYTGdPY3B1MEMrbEdRVkhGdEdjZTF3NmE4c0dvVDJTb3VQQVE3?=
 =?utf-8?B?L0VZTEcyTXUzdXJoNUxYajBEQk1oQW01R2krRVpndmovR2xmTERZcENiN3M3?=
 =?utf-8?B?Q3ZxMWhFV2JsK2RUN3ZaTFk0U2kvZ0pYMERDV1BtTTlZcks5Y1pwaFRORDZP?=
 =?utf-8?B?OUQwUSsxTzY1akFJa0JwWmxqYm5zVkN4cTdyMWFuOGtXcXNGU3luZEFHV3NE?=
 =?utf-8?B?Rk9tcTFwQ0M5VnBaVEt2aitzVjVOVy9SK1BuZUR5alZIR1ZKTXg1MkE0NHJF?=
 =?utf-8?B?dk9nUlVaczRaVDFZWi9XY3daTWk3c2FzSi81MGREVFU0ZllIdGZFZXQyZ2la?=
 =?utf-8?B?b090Vk93USs3cXIrcFlhNk8rWm4xbjhIVHJIL1pxS0N3cTlYV0oxckI1VUt4?=
 =?utf-8?B?aVh2UGRmRjZydkpnV3lsQkpJZExpWmlMSFlBckxUcDlDQTRPYVJ5NEVDZlds?=
 =?utf-8?B?MXNJSWhrbjROMU0zSW9SKzdnZ2t3b3NMU1FtVDVxTUxLckwzWm11Qk5HWG1l?=
 =?utf-8?B?VVNhdXhvR2dnUkZnZGY2d2pBdXZiT0xHTyttVFU5dGdaaGs3OExibFpQYm5P?=
 =?utf-8?B?dGt2Z2VRK1hMQkxMK2l6ektYOExkTVdGWVdHc1JYRmlqcHVEQWxOdm1uVFVp?=
 =?utf-8?B?WG1ScjI4emFsbzBtNnh5c29sQTBHc2ppbW1sazFNNHZOdzRYZVpSOC9zVERU?=
 =?utf-8?B?NElDQ1g5SllqU0tKM21BR00xTDhRdTJtMWhwaTNJWS9XVFQ0SXE4N3lVdkhP?=
 =?utf-8?B?OERQd1ZiRXJ4aGVIOHNJWFF6NmhGQmRQYVRVOHFzVy9BTzN0SG1IQUd5QytM?=
 =?utf-8?B?MUJCSWNQS0xQZk1qdzk2UE1VTFRYR1dPUER5Q21CNjZ5V3Z6NW9UUHNEZU1Y?=
 =?utf-8?B?ZXYxdnZDTUNMWm9DTzl4QXNuZ01CMHZPMTdtcE1hWmJ0ZWhWdUVkdUd5ajc1?=
 =?utf-8?B?enJqcC8zbHlXVGhoTy91MnM5bWhnOVBacHFMSlpUeTcyVzc0MmphdG1uRHdm?=
 =?utf-8?B?T3JVeDhvK296dTdEV21aMXVOWWtkWHdubTZvTS9weURuUWY3K08vbUVzSFln?=
 =?utf-8?B?Z2MyMFlUY3E2VGdCT1BmL1AyL0VrT2ovYXAvTWNOMGl4OTZtUjBoa1V2bDMr?=
 =?utf-8?B?RWNKRHg2NXlVdU5rZmlFc2pLcmRmQUJCeWFhS0Fyb1dKYkVPSTZwNTUvakNl?=
 =?utf-8?B?aVdIRURZRzkrd1M3VStIVHFBaFBUMVA3Nno4M2JSS2g2WDc2dkVtUkFYU1h2?=
 =?utf-8?B?K1p6MlZzU3YxRklBbURQNkpCUlkzZEZ0clNPT1BJQ0Y2RFdaQll3R2JYeERY?=
 =?utf-8?B?WGlSaHR4ZzVVcWE5QXJkR1RabWw5L0lycU1uTVE4em1UZklpMmw3YW9aNWty?=
 =?utf-8?B?R0EwaUY0QXZGWGNOZVZjNWtuME9neFk4OExHTTl2SFlScXpVMUk0RVJySXNn?=
 =?utf-8?B?QUNVZWhVWUtTVXNkTzFMSy9TblJCeDhMQS9jMjRSelFxUmlEcExMOWZRL3Mw?=
 =?utf-8?B?SnlBaFhZTUNxYzVOWW9DYldMZk5XaWNXUFJOWFY0dTFVem1uK01kbm5iTkNW?=
 =?utf-8?B?QjFuOHhSdkVGVEpMbGZhKzFUTHR4TEQ5VW5CT0dIdzBzdzBlbnp0WmFRMHBt?=
 =?utf-8?B?c0h2YVNQbkdUVHhtTGlIeVB0NTd6WldvenhNUFhqbytQOTl0TFRRS0ZiVkVN?=
 =?utf-8?Q?w43MNrZfk5linaMylWU0q8ztHNY6FvhbbBaeY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkNQb1FiSlFJazhtRlRERW53KzNIWmVYVHpibWlvbFZURnc1WFZCYUg0NHY4?=
 =?utf-8?B?b0xSRng2VW1VMFhSTlNoc0Q2b240L2ZVUnVuVENXbXdpeHRYMHdlZjNZZkQ3?=
 =?utf-8?B?M0VkYVZQMklNdEM3dC9GVWlLcW5tLzVPanpSZFRSZ1poa3JGN1FwR1ZYWGJY?=
 =?utf-8?B?dElCYnFMVDB6bE5HUUExU2hSN0NSUFgzUWEvMnpZWDJPTkxZMFYzb0U2M3Z5?=
 =?utf-8?B?bnc2ZDlFSTBYWW8vN3RTMkt4TjN2dThndzBZWTZLYTVOc3ZpMzJlMCtlOWY3?=
 =?utf-8?B?YlJqTXhoemZncElCN01XaEdKaGJERVB3eGR5bUlJZ0IwS3FadFhyek83NzFT?=
 =?utf-8?B?Z25wWGJhTW9ybzdHTDdXWFErRys4L2ZIbGdDbWFkckZxZjFRQUJlUGM2cURO?=
 =?utf-8?B?NjQ2T0RwZ2F5SFB5eUtPd3hBaWF3MlBTOGYyUzlCZy8vcU1xTDVOU3hHTXN5?=
 =?utf-8?B?eEhUdktNeFRLL1lxTzhHdkJWempZZmg0bmFxNDJoRnE0Q2JLL25XL3Q5WXQw?=
 =?utf-8?B?anBxL2lVNjVIbzBmWDN1bDZDdDY4MzkzL0NabE5UV1U0bmliN1g3UmhqU1RJ?=
 =?utf-8?B?WW9pTGJBbUthRUZwTnBLaVNEWTZtSzBiMmRmQkNwWHJDcTR4a0p6ZzBZcXVM?=
 =?utf-8?B?WHRrTHIzaGJRRFMwNE14azVGRjh0b0NvWlYzeTU3WnZaSitaREovUENQRmNM?=
 =?utf-8?B?b3BGQngvZEgrRExiLzVWRlRwYWVMY1VUNVlPV1RWUCt4U29qeGZ5SzdpU1Ju?=
 =?utf-8?B?UUN0ek5aUXMwSm1iQUE0SlgzdXVaY0ttL2k2Q0ZMZkNwbkhMSFJjbGt5VDBp?=
 =?utf-8?B?NkhiYjdhU0R0bTc0VmRRUXZVQTNvbWk4dzRYenNTZy9oWVNFYzBzUzdzVkRa?=
 =?utf-8?B?ZlhrN2drYmlmbmd0cFU1THVQZ1QzUEFWRUVVbC85S0dtTU52ZW9QSHlHMG1v?=
 =?utf-8?B?d0d6R3E5TGUzR0cxZzllTUNySFlZcDZsaGNvbDVMdnZoV3JyWE02aHZUN1hM?=
 =?utf-8?B?NGNYK3NZekpHZk9oSzEwbG51STVXa0s0NXR4Tk1TZmlkelBCTCtybU9Pc01Q?=
 =?utf-8?B?THNyUG1SNTlYMVFqS1lTend0dHIzOGc0RW1aaFEvQ2pwRGJqQ0pBZzkrZ1gx?=
 =?utf-8?B?RnpaWEFMcmRqc2dVZ1NOclg3cXpIU2k4WmRDMWxSMXhVc2xVd0RDTHpMS3h3?=
 =?utf-8?B?RmFVRmlTNkxxZTVIK3lzQW9USngwblN3N0ZIVVc4aTlJQUZMWi9ocXZEY3VC?=
 =?utf-8?B?NTVtdDBXeXpGbURmT3ZZS0hnQXNTd05EK21OUUJuRG05dlZvZzZZcXFZYVJl?=
 =?utf-8?B?MkI5aVpucXNDS1ZScTRmYlp1MlVCdThnSkcrSy9reVMvdy8vaFpZV1Y2R2ZW?=
 =?utf-8?B?R2RQOXFYcmJXTWJGL2dFTG1PdWY1K3RzUE8rTFJtckQ5QjFYS2NXckVITENn?=
 =?utf-8?B?b2VBaVYrREMzVGloSmVvdXI0d25mYnllVkFkNEQxY3MyYStLdEEzQUxZald4?=
 =?utf-8?B?VGU1WnVSU3BJYlAza3pJZ2RCNDY0Rlo1V05jclFkWlRyRzZmU3hnK0ZhUFNH?=
 =?utf-8?B?cy9mVzNwNDZlNllqSHlHTmtibWRMN3dLTUR0bEw2TGlLNlRhK2NzU1JkVzV3?=
 =?utf-8?B?VGhKUW52dDZIbi9QcVVsU3BjVzQyWktGR2NCOXFCK0s2cE1STmlLclV0UWRy?=
 =?utf-8?B?TXdlSDZ0cmk5UWxCc1JCMldNamp0UmNnRW1ERkEzV3BFZ0ZYQU5CSVh4anRW?=
 =?utf-8?B?amk3c2J1WHVSdjh2RVhueHZ1R1RzNkU4enBKMXVLUEtYVkNuSXcvT0NmUTBR?=
 =?utf-8?B?NG5jNmFENENkTTB6SUhaTHZZYzEzbGFCa2lqNS82ZzhiU1pVajZYaitUYXJv?=
 =?utf-8?B?NmJ3Zy9kQ0FBQ1pZbVN1QUJ4ZHJaRmRPRGkrQ0krVmpsQmpyWVVFZmF5UHZ5?=
 =?utf-8?B?MWczR3llRFJKTjBmbnFaVkJaUUNaR1BqQVMrbW1KODhjclo0Skd0d3ZyL2ZV?=
 =?utf-8?B?bW1uamZHVTZtK0Z6VlcwWWszbHUvQWV2RFNKbFdVMVB2WW45QzZLL3kvZk9m?=
 =?utf-8?B?TXBZRHQ3M2tLTUZ3dnQ4UkdtTDdqc3hlUjYvb3JrQnFaR3lzbkhseE9qRVB0?=
 =?utf-8?B?L2tpb3BVTlc0THF0Zkt3aSsrZFdudEtCWmcydmQ1VkZBNjAzSDAxSWZQQnBL?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <691720BAD403344CB2F461D0AB5896EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982d50cf-f89a-4dd3-b961-08dcaf952a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 06:10:37.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIMbuV5s4cyLcNGoyNZkA7DVAgichnumZEZihxHz1pbLb8gZWGqWToglnNISV0UoiCB4HrcbAWQP6grJC3TScZfqOZp2gtUmhUzDiqEFYxZIvTSzodDKy6LBB0mIor6f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170

SGkgUm9iIEhlcnJpbmcsDQoNCk9uIDI2LzA3LzI0IDY6NTEgcG0sIFJvYiBIZXJyaW5nIChBcm0p
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZy
aSwgMjYgSnVsIDIwMjQgMTg6MDk6MDcgKzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90
ZToNCj4+IFRoZSBMQU44NjUwLzEgY29tYmluZXMgYSBNZWRpYSBBY2Nlc3MgQ29udHJvbGxlciAo
TUFDKSBhbmQgYW4gRXRoZXJuZXQNCj4+IFBIWSB0byBlbmFibGUgMTBCQVNFLVQxUyBuZXR3b3Jr
cy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2VzcyBDb250cm9sbGVyDQo+PiAoTUFDKSBtb2R1bGUg
aW1wbGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFDLCBjb21wYXRpYmxl
DQo+PiB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2lj
YWwgbGF5ZXIgdHJhbnNjZWl2ZXINCj4+IGludGVncmF0ZWQgaW50byB0aGUgTEFOODY1MC8xLiBU
aGUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIHRoZSBIb3N0IGFuZCB0aGUNCj4+IE1BQy1QSFkgaXMg
c3BlY2lmaWVkIGluIHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbA0K
Pj4gSW50ZXJmYWNlIChUQzYpLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXk8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVl
cmFzb29yYW4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+
PiAgIC4uLi9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NTAueWFtbCAgICAgICB8IDgwICsr
KysrKysrKysrKysrKysrKysNCj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDgxIGluc2VydGlvbnMo
KykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NTAueWFtbA0KPj4NCj4gDQo+IE15IGJvdCBmb3VuZCBl
cnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiAN
Cj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdz
L2Vycm9yczoNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51eC9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjUwLnlhbWw6ICRp
ZDogQ2Fubm90IGRldGVybWluZSBiYXNlIHBhdGggZnJvbSAkaWQsIHJlbGF0aXZlIHBhdGgvZmls
ZW5hbWUgZG9lc24ndCBtYXRjaCBhY3R1YWwgcGF0aCBvciBmaWxlbmFtZQ0KPiAgICAgICAgICAg
JGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQvbWljcm9jaGlwLGxhbjg2NXgu
eWFtbA0KPiAgICAgICAgICBmaWxlOiAvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xp
bnV4L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2
NTAueWFtbA0KPiANClNvcnJ5LCBzb21laG93IEkgbWlzc2VkIGl0LiBUaGFua3MgZm9yIGxldHRp
bmcgbWUga25vdy4gV2lsbCBmaXggaXQgDQp3aGlsZSByZXBvc3RpbmcgdGhlIHBhdGNoIHNlcmll
cyBhcyB0aGUgd2luZG93cyBpcyBjbG9zZWQgbm93Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGli
YW4gVg0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0KPiANCj4g
U2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9kZXZpY2V0cmVlLWJpbmRp
bmdzL3BhdGNoLzIwMjQwNzI2MTIzOTA3LjU2NjM0OC0xNS1QYXJ0aGliYW4uVmVlcmFzb29yYW5A
bWljcm9jaGlwLmNvbQ0KPiANCj4gVGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2VuZXJhbGx5
IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudCBkZXBlbmRlbmN5DQo+IHNob3VsZCBiZSBub3Rl
ZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmlu
ZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1h
a2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+
IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVh
c2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlv
dXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBz
Y2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwg
aXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2NoZW1hLg0K
PiANCg0K

