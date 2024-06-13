Return-Path: <netdev+bounces-103318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E396F907867
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED32AB215B3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE930130E40;
	Thu, 13 Jun 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Hu4jwN8o";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XTQ5KOVG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16112F386
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296583; cv=fail; b=U1q5gjAuDHGHkohWBFV834hkT87qBz4J8lTbf+zmiZtfkyhnV+qDcExXlh8y+xnRCevAYKa+5A0rGqUKYcr1xZL6fGKXQAbkWw2r3x8DRP98VaAnsm76Pp0uklk77uCAktcco34LUW20JFVqFm5yaOuR1d0gBLXOu0dqtogNv/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296583; c=relaxed/simple;
	bh=6MxbznLmq1lXJJVLK9IPBzAGm5zVMoLkM7atSmRKjj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZPQrH85b86Np9NHKRqZoIHTNb1mJ5yDuveQaK58oFg7hL/ddyZQd5taqEh+JsHfVywD1lYSk7h9TnYMi2NVW+WuKV2aqXjckIUiHOlVa7RAFzNmJ5MUvcGgcCrYw/qqLpetseVqYrvg89RDzhrVsFrKtgqAJyuz6MW581KL6ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Hu4jwN8o; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XTQ5KOVG; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718296580; x=1749832580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6MxbznLmq1lXJJVLK9IPBzAGm5zVMoLkM7atSmRKjj8=;
  b=Hu4jwN8o0QviamNmMeGMeb2d3bufcOyY+hY8j07gwBA4GNfvV+cEvdob
   o7wQ1v10R4CxywjJtZ6/5/ACF4d+AbaXg1QLdEisNvEp4B9feRjOOf3Le
   souaD2Ps4NwNyCJhs80jjTZm4Z7xc6vJ0relLPfLVNikGzovUzxs0HwZf
   KEYyi9nuR0jf6K80N2J/1V41YBoHoHjxnZuJV4m3YRuQZaU9/gchSkeDU
   +SW+n5t+2f7Q69FyfyCGjvLe10DNM4khjh51Xs/QN2APS68P5goDrRWxq
   fl3otRYrqE9TSh2AkY3Omcb1w2t3ckRGAuww6lX99H4WU6EEsMi4Wc6fp
   w==;
X-CSE-ConnectionGUID: XL7aYE5xSQOz3+1gMzaytA==
X-CSE-MsgGUID: 2XOxyj/VRGSSqBEqF3cl3A==
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="28052071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 09:36:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 09:35:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 13 Jun 2024 09:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtSADKxcp575lFFbbCW9kdYgmRpIvbSAJYjPp6DMzwxyH//1ydoBdBDCgzRskoX+ZGCZOdFMnwa0SRVG622guSMm/wPNvdZVUCkBEg3f1KcdkzQ/2dtVbE/BYsyKIWyDuoEEnd91i8HvqrDT24bShM2hZO3jEWqlrwcg1xevKSAF8psZ5IfeMxWaAypasFVT7OhN16cTWH0LTPDGZMN9ZF3IdfMiSGaYZzxBXyOgknS8tsN/uNmDetMo9QIQUBBQ29WDRSGLeregZwv4ga0RNy1+5sr+tKUBAASrNnfGm/aeYyb2ayXUq/JaqO8CQwB6hKYnYTtudegj8+YW0FyEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MxbznLmq1lXJJVLK9IPBzAGm5zVMoLkM7atSmRKjj8=;
 b=Qju/EChl3X/+WvaccN0m90cPSmBrjpG2IGLc2vb2Dp5WMkxuIh9ihhpe4FGKwCtC9kUca5GL6RjzUQSLRB7sATiwwlehaVdB/6HZs026L1Gpb3lbhI8w43GmAvPleseSkZGcKOjuFowebM7gGo9rodAq/2Ix+GqJZPk9cKDMv0/fuJN90j+nsLnzZLVltwP3PheNplWRGyuFa3+YIRnXgjStPYnfSLP11gDRbUMcAf8+qFCsGqSs5TdBXcdgwLE39D27QodfI9IHeDEeVLjrCGBxIIJpf5AOPif52syt7KA4lVznOsPc4HGAB5ASkG/Pz3vPE7mwLDsbes4jG9elCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MxbznLmq1lXJJVLK9IPBzAGm5zVMoLkM7atSmRKjj8=;
 b=XTQ5KOVGT3CBZGu5CsxrEzh0+05O+SUtfeeRQl1kh1MvhGFC9eRziU2N0uo0CMMuQCYVma1MzKyUkLQbiG2pTtK578tY+OE4qngffi3um51RpLvE1DzzkTMVQg7Dlbosvsntg0ndjyz6fO7UsPTEHtg5yeBhnMpkUa/0yioHpy+koKJuQ4JRR7F3L4x33pdxBon99nU87JUAP6V5tTgoMZqJb0IoXH6KSLpqjr1vLe+AIKvz1tLB2cUrPcc0HyQAaDoM3KNWlKutp065CJrzi+7s3KmrPF7Yq2xvjWP16cu6z/CaJq7hUHc3viYMMVruECC41Rx+57cPsekeDccc+w==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 16:35:39 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 16:35:39 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>
Subject: RE: KSZ9897 RMII ports support
Thread-Topic: KSZ9897 RMII ports support
Thread-Index: AQHauOKWABCBqyY9kUOyhBXqEndhr7G8YIUggAlogICAABPpUA==
Date: Thu, 13 Jun 2024 16:35:38 +0000
Message-ID: <BL0PR11MB2913CE140EC9B807BD8CBBE2E7C12@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <21cd1015-dae8-414e-84d3-a250247a0b51@savoirfairelinux.com>
 <BL0PR11MB291351263F7C03607F84F965E7FB2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <6972b36e-2ee2-4b8b-9a35-147fe842a8cd@savoirfairelinux.com>
In-Reply-To: <6972b36e-2ee2-4b8b-9a35-147fe842a8cd@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SA1PR11MB8393:EE_
x-ms-office365-filtering-correlation-id: ea49c16b-920f-4024-679d-08dc8bc6dc04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?V2orM3RqQnRERmdxM1NWNThqT2JsRTZCMnBHd1l2QnVoMFBIQkdXQlJuQVpO?=
 =?utf-8?B?T2szb3AydkE3TUdOKy9KeHc0Rmk4ZnJSNVhxaHBYTlhDVEY3d1VuTVZ0VnRD?=
 =?utf-8?B?S0xaQUxkN3VwRmRuRFhjWDRKK05kUTVGMC9nTHVWa2xadGk1blBHeWYwMyto?=
 =?utf-8?B?K2VpMWJQQWF1ZjB2UGxMQnowT2VUcWRnZ2VlVER2ZTFGb3JadVdWUitnVGJ0?=
 =?utf-8?B?SXBmVElJVktFUEd3TzFOdXFaT3RHRFEwU2RMTGs0RmNvQVlDYklTNkp6SHM1?=
 =?utf-8?B?cy83d2RwaDhFUitoQmlRSFlkWU9jMmZXR1gzelpwYzJ3QWF3by9wQXRpSFYx?=
 =?utf-8?B?UmdCa1p1bktnL0luN2NWcVM3QWQ1U1Nab3RxOHViNW4rQXp1ZUJYOTl1em8y?=
 =?utf-8?B?ZjkyTkxPM0lPeDBpanVaOHZUZXhxMFcrWEg2QnhaaVdZQ3ZmTVgvcUQ0eVJK?=
 =?utf-8?B?SnUzbWVUL3l0aURCSFk2bmxtZVpDTUJObWY3UW02ZXJqZmxLWFE2dHozZ1Bs?=
 =?utf-8?B?REVuZWVsb2JiN29DeFArbHJOWXB2S0RGRnBxM2pqbFZidllZNW5LU1pjRDBM?=
 =?utf-8?B?cEhMU3V4bnNzcllZRlM5YWFkK2hoMVYwbnUySmdKamdGS1BSNVd0TkNLM29M?=
 =?utf-8?B?eTJ0UlRkbmF4TzNkVTJHRStXd1dLenFrUmppbURuUnJwdkM4SUZ5YlNYdHZD?=
 =?utf-8?B?d0NjU3BVbXJoMzhKYkZ6b2ZoMURhUCs3TXRFWUkySDFKQ05SR1VlN2o5RzFO?=
 =?utf-8?B?NDNITFdpcGRVYXVwWXo2Z3lOLzlXcWxBUVp5U2N5SG1WR05vK3dJUGpnZFR4?=
 =?utf-8?B?R2JKV0lUL1FGWUJKeEpURk94cXd4aDQzcS9jak1yUDU4cFROQ3pwRzE0a3BN?=
 =?utf-8?B?NFpnTEFhcFRKdG5kMDMyK0R3NzN5Zno0aCs2aE9CeUpKL1BxNnhKUXlwOVFY?=
 =?utf-8?B?TnlOZE5PSTJMak1yUXE1bzRsYUJ6cXlSOTJjK3NyMnRMYUkwK0FFT09UZUVL?=
 =?utf-8?B?bWRHNUM3TWFqeXVUTmxaOXRBMDZsaEFBUlhGL0NMK3JocjFacWRwdm9GTTRk?=
 =?utf-8?B?YUR5Ui93cndGWUI0YS9Ua24rcEVTbjFPNXNSMnpBM3BtYTFGZEVGN3l0WVJJ?=
 =?utf-8?B?WE1ZcVVwQ2YyUjNpbTZHcVRlMDBqUW1pN29HS1JVWnhtaUxKWWI0K0gzTXRP?=
 =?utf-8?B?N3h1L0M5Y0V3Ry9ydzl6emxSZFJJRElnSUVPRGY3L2x6ek5tcnQ5aXRaY0NN?=
 =?utf-8?B?M0NrTFd1ekk2aHYzM20xQzZMNlJmdFF5ckdsYi9vak15bW1tK21LMUFGOTBU?=
 =?utf-8?B?dTErTVNIVm0za0ZDNEttdnh5V0tneHhQSE8zRnovVC9tTkV4MDR6VmRjY3Rr?=
 =?utf-8?B?ZEtYOXVyRVh1NGpLaHVkdVJydFhTb2d6Ukd0L1l4NDhXZ1pNRW5hUWFjQ1A0?=
 =?utf-8?B?NmkyYlNEelplbWIxYzNpMnBLRXZhZTk1MDRSR3BLWXJOd3RwdDAwZXJKclZ3?=
 =?utf-8?B?M0RhT2NML20xazByMWFweHpWWnN3a1gvN204R0xlT2l4a2tPZkZLVWlzUWd1?=
 =?utf-8?B?ZWk3NUJxanBGdlhobzI4S1IyK0JXdzUzRTdOWC9sSlJML29WM1V5dHkyaTNQ?=
 =?utf-8?B?ZDlPSTdiUDIyaXo0TEZQRzR3WVFMM3psOG9MK2JyZ2VQTTlTdEM5RGNzOHp4?=
 =?utf-8?B?OVVRWi81Q0tiOEI1REl4cExwQ3V5UnQ4VUNzUEdscEd5SklETmtOa2o2QXYw?=
 =?utf-8?Q?TMNvdrolsvO3kOjGOl3o2kM8C8VNYsSrw+kWgEh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVc3RUZoTTFTekYzVHJ5T2R6V0lQb3MrSDNBeStrSEtTZkxQZ2tJUVlSaUp0?=
 =?utf-8?B?UVZKL3dYeEZ2M0RRQmJIRVNRLzc4QWhIQld1aHU5T0ppc2JTV3hmNWJsMFhQ?=
 =?utf-8?B?dGYvR0tzREtMODlCNCtFRCttbE1Nd0ZseUhlUnJXNWNBaEM1WUhaU3pmcUpy?=
 =?utf-8?B?RVBZbyt6MFRaWFZUMzc1YURRbGh4R0dWRWFwS1JTd3J4YnE1Sm5GblBkbmdr?=
 =?utf-8?B?cGZWeVVqMklmSnVPczAwZWMyQmRrcFFMc1RFb3JJVEJicEViMTF3alVxQ1Vl?=
 =?utf-8?B?ajBuT011WDlhUWNsT1BYNkh0RjlLdlZlaHlPWnhTTzlqZEpkOWJSc2M1V3RM?=
 =?utf-8?B?TlE2VVpIRWR3d1VmSUQvajM5bWk1M3VsN0h4K3JqYjA4RWV6dkd5WWtuMG5V?=
 =?utf-8?B?VEN2cmRyNWl0VUdZZGhnSVd4ZnRYUFBkZ2lSMDRvZUFFVFo4dUN5ZVZIeEtR?=
 =?utf-8?B?ZVBmNDN2M2sxUTFBTzFoNnVIZnFxSnM5dWFueEh0d0xFS3FkUTZtVDRaR2pZ?=
 =?utf-8?B?dFVLM1RmaHlZMERFUVY5WlRDZFRCYys1ekcxVVQ1SjhtZmp2VkFzQ09VN2V5?=
 =?utf-8?B?by9sZmFoYW85eUJSbjZ3TE82NXkvZXo1TDJnV3RDdXZZMHB6T2FBUlMxVGVL?=
 =?utf-8?B?TlJWUHlSN0UzRElNRmdLczh5M1UweGoxQ25tTlVnaGlFaDRvUTlQMzNjZjkv?=
 =?utf-8?B?bTkyeWRjSU5rNkhxc2VMZkxhYi9nNkVSK1ZKZ0w5bkVsZ1ZnRjlvMDduVTlZ?=
 =?utf-8?B?dVlWYXFvMjREaUVCOFdlT2svL1p3Ym94SklHcFcrejJuaW5tbXhpUVl4aURo?=
 =?utf-8?B?di9LTE1jWDVMYkxHblFOelNDdkN2ZDI2a3MrQjFYTVBzN0Z4YlFNalZtOWR6?=
 =?utf-8?B?elNFaE5YSjhVTVdpcFBSSUJzcU15blVpeVFNUy93L3ZUY3EzWkpZZk54MG53?=
 =?utf-8?B?MGNGaGpCcDk0NnRuaXRlSTVsRlJ4NXJUL1lUWXFnZHdHcU9mOU1mYVpFMWhG?=
 =?utf-8?B?bEFabjF2SHFYSlozVTNtQm9hc1FISS9pNkVQTmlKTEJCcGt1b3d4VTRkbm1M?=
 =?utf-8?B?TFBCL2Y4RGlqdCtVTDgzWEl6aXorWitrRE1FYjQ5V3VoR0ZkR0dscVFmZkpI?=
 =?utf-8?B?YzBtUHFmOUIvcHdUb3ZldTRWV25PaDdkMjQ1NFJubUlqeVBEay9jOW9GMmZG?=
 =?utf-8?B?dmduM3dieUtCTlB5NW16UXZxWFVOWmlzaldxbUR6a21NMkE2NkVQMmNFSzZI?=
 =?utf-8?B?eHR4eXpoelJWS3RZSVVwTmgvMjNSYnBVR3F1MFBzVmxOZE9jYXlWMVR6QTNQ?=
 =?utf-8?B?a3pROXhGSHJ6VDNBMjZOSWV3Ukd6bGpuSnQ2TXdrOC9iRUxHQm8xVXV3ZGFx?=
 =?utf-8?B?dE9XVEhNczBVdUpzTHNmaFBDa1ZLU210OUlIQ1N6UitKcHVnd2s0RXU3MHRn?=
 =?utf-8?B?YjBiVVVrZXhnLy92Q0k4NE1pM3VzM25PZzIzb1RQdVVieFZLQ0c4aW1oTVg5?=
 =?utf-8?B?RjhIQkVUYjZOU2sxMVo4WlRRRHpVUHRTSjlkSEozNkpUbUNXRHk5UlFYejdC?=
 =?utf-8?B?enN2S3A1ZWY5VzI2L2hGbzVwdkJqMzNLeDJvTnhnbmxVc2xHQmt2c0s3ZDFJ?=
 =?utf-8?B?bzhYMHlDLzZGK2p0a0pOUHN1dUxYZXJ3QlUrWkxNelIrSUE2UVA0Q25LSXZY?=
 =?utf-8?B?L2g3OUF0blpNRUNUTEVoQ1E0cW5qSDFZaExhWVFsRVFKaHZLVWVSUHM2Zm5x?=
 =?utf-8?B?L0lmMHRlajZZK3dSbkpmOVhYMjl6aWdPdjJucHJrL0o1VkJoMzdDaUlBOTQ4?=
 =?utf-8?B?cHRMSWZ2bU9LcUZHWlU3YXVxTmdwMVZUbjVHZksrRzQ2YmJwdUo0M0wrQWhC?=
 =?utf-8?B?dUNKMm9iSUgybklWRUE1bEhQTi9oUWErZkFJc1loajdvcnBtc25TYmlXUHJo?=
 =?utf-8?B?Szg0TVdVNGZHdmxEZVNrSzA2YjVLWlY3SlFUYUlDRG5UYThadHljcU1hbXBj?=
 =?utf-8?B?U1lwOHRYL0JHMStoeXJrNm1aVVFlSlU0enphQTNjMEU2RTRLRjhwT0d1dERl?=
 =?utf-8?B?WDVuMGdoVy9FRU1MRjljbWcrdHIzUjNPdW55dkE2RU1DWFA3czJPamQ3VGEr?=
 =?utf-8?Q?GUuOiM9dyGsQUnD+L5kj4D3JA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea49c16b-920f-4024-679d-08dc8bc6dc04
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 16:35:39.0264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foVcb+KV3YOYW143fxTvxnHJufloLhzEMd5b060kCw17p4my1i+CEtUGtdDlA9GmoB6kdnTGlVwdS3KikHJJtAETGl++TeW+F+e6Cvc4Jd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393

SGkgRW5ndWVycmFuZCwNCg0KQmVjYXVzZSBpdCBpcyBub3cgZGVidWdnaW5nIGNvbmZpZ3VyYXRp
b24gYmV0d2VlbiBpLk1YNlVMTCBOSUMgYW5kIEtTWjk4OTcsDQpJIHdvdWxkIGxpa2UgdG8gcmVt
b3ZlIG5ldGRldkAuLiBmcm9tIGNjIGlmIHlvdSBhZ3JlZS4NCg0KQXMgbWVudGlvbmVkIGJlZm9y
ZSwgcGVyc29ucyB3aG8gY2FuIGRvIGhhbmRzLW9uIHdpdGggS1NaIHN3aXRjaCBhcmUgb3V0IGZv
cg0KdmFjYXRpb24gdW50aWwgZW5kIG9mIG5leHQgd2Vlay4gU29ycnkgdGhhdCBzdXBwb3J0IGNv
dWxkIGJlIGxpbWl0ZWQNCmJ5IHJlc291cmNlcyBhbmQga25vd2xlZGdlIGF0IHRoaXMgcG9pbnQg
ZXZlbiB0aG91Z2ggSSB0cnkgbXkgYmVzdC4NCg0KPiBSWCBwYWNrZXRzOjg2NiBlcnJvcnM6ODYy
IGRyb3BwZWQ6ODYyIG92ZXJydW5zOjAgZnJhbWU6MA0KSSBkb24ndCBrbm93IHRlc3QgZW52aXJv
bm1lbnQuIHN3MHAxIGlzIHRoZSBvbmx5IHBvcnQgY29ubmVjdGVkIGZyb20gc3dpdGNoIG9yIG5v
dC4NClBlciB0aGlzIHN0YXQsIG9ubHkgNCBwYWNrZXRzIGFyZSBOT1QgZHJvcHBlZCBhdCBzdzBw
MS4NCkJlY2F1c2UgYWxsIGVycm9yIGNvdW50IGlzIGRyb3AtY291bnQgKFJ4RHJvcFBhY2tldHMp
LCBzdXNwZWN0IHRoYXQgc3dpdGNoIHBhY2tldA0KYnVmZmVyIGdvdCBmdWxsIGFuZCBzdGFydGVk
IGRyb3BwaW5nIHRoZSBpbmNvbWluZyBwYWNrZXRzLg0KDQpCZWNhdXNlIHRoZXJlIGlzIG5vIFJY
IGNvdW50IG9uIGV0aDAsIGFzc3VtZSB0aGF0IENQVSBwb3J0IEtTWjk4OTcgY2FuJ3Qgc2VuZCBh
bnkNCnBhY2tldCBvdXQgdG8gaS5NWDZVTEwuDQoNCkNhbiB5b3UgcGxlYXNlIGNhcHR1cmUgKHdp
cmVzaGFyayBvciB0Y3BkdW1wKSBvdmVyIGJyMCBhbmQgZXRoMCBhbmQgc2hhcmUgZmlsZXMgd2l0
aCB1cz8NCkFuZCwgc3RhdHMgZnJvbSBldGgwIChpLmUuLCBldGh0b29sIC1TIGV0aDApIHRvbz8N
Cg0KQmVjYXVzZSBldGgwIHN0aWxsIHNob3dzIFR4IGNvdW50IGluY3JlYXNlLCBndWVzcyBldGgw
IHRoaW5rcyBsaW5rIGlzIHVwIGFuZA0Kc2VudCBvdXQgc29tZSBwYWNrZXRzIHRvIEtTWjk4OTcu
DQoNClRoYW5rcy4NCldvb2p1bmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291cnQgPGVuZ3VlcnJhbmQuZGUtDQo+IHJpYmF1Y291
cnRAc2F2b2lyZmFpcmVsaW51eC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEzLCAyMDI0
IDEwOjI0IEFNDQo+IFRvOiBXb29qdW5nIEh1aCAtIEMyMTY5OSA8V29vanVuZy5IdWhAbWljcm9j
aGlwLmNvbT4NCj4gQ2M6IFVOR0xpbnV4RHJpdmVyIDxVTkdMaW51eERyaXZlckBtaWNyb2NoaXAu
Y29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogS1NaOTg5NyBSTUlJ
IHBvcnRzIHN1cHBvcnQNCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2Fm
ZQ0KPiANCj4gSGVsbG8sDQo+IA0KPiBJJ3ZlIHNpbXBsaWZpZWQgbXkgZHRzIGFjY29yZGluZ2x5
IChzZWUgYmVsbG93KS4gSG93ZXZlciwgSSBubyBsb25nZXINCj4gcmVjZWl2ZSBwYWNrZXRzIG9u
IG15IGJyaWRnZSBpbnRlcmZhY2UuIEludGVyZmFjZXMgZXRoMCwgYnIwIGFuZA0KPiBleHRlcm5h
bCBwb3J0cyBwcm9wZXJseSByZXBvcnQgbGluayBVUCBhbmQgSSBjYW4gc2VlIFJYIGNvdW50ZXJz
IGdvaW5nDQo+IHVwIG9uIHRoZSBleHRlcm5hbCBwb3J0cyBpbnRlcmZhY2VzIChzdzBwKikuIFll
dCwgaWZjb25maWcgbm93IHJlcG9ydHMgMA0KPiBSWCBwYWNrZXRzIG9uIGV0aDAgYW5kIGJyMCBu
b3csIHdoaWxlIEkgc2VlIDAgVFggcGFja2V0cyBvbiBzdzBwKi4NCj4gDQo+IGBgYA0KPiAkIGlm
Y29uZmlnDQo+IGJyMA0KPiAgICAgICAgICAgIFVQIEJST0FEQ0FTVCBSVU5OSU5HIE1VTFRJQ0FT
VCAgTVRVOjE1MDAgIE1ldHJpYzoxDQo+ICAgICAgICAgICAgUlggcGFja2V0czowIGVycm9yczow
IGRyb3BwZWQ6MCBvdmVycnVuczowIGZyYW1lOjANCj4gICAgICAgICAgICBUWCBwYWNrZXRzOjI0
IGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczowIGNhcnJpZXI6MA0KPiANCj4gZXRoMA0KPiAg
ICAgICAgICAgIFVQIEJST0FEQ0FTVCBSVU5OSU5HIE1VTFRJQ0FTVCAgTVRVOjE1MDYgIE1ldHJp
YzoxDQo+ICAgICAgICAgICAgUlggcGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVu
czowIGZyYW1lOjANCj4gICAgICAgICAgICBUWCBwYWNrZXRzOjYyIGVycm9yczowIGRyb3BwZWQ6
MCBvdmVycnVuczowIGNhcnJpZXI6MA0KPiANCj4gc3cwcDENCj4gICAgICAgICAgICBVUCBCUk9B
RENBU1QgUlVOTklORyBNVUxUSUNBU1QgIE1UVToxNTAwICBNZXRyaWM6MQ0KPiAgICAgICAgICAg
IFJYIHBhY2tldHM6ODY2IGVycm9yczo4NjIgZHJvcHBlZDo4NjIgb3ZlcnJ1bnM6MCBmcmFtZTow
DQo+ICAgICAgICAgICAgVFggcGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczow
IGNhcnJpZXI6MA0KPiBgYGANCj4gDQo+IE15IGJyaWRnZSBjb25maWd1cmF0aW9uIGlzIGJhc2Vk
IG9uIHRoZSBkc2EgZG9jdW1lbnRhdGlvbjoNCj4gICAtDQo+IGh0dHBzOi8vZG9jcy5rZXJuZWwu
b3JnL25ldHdvcmtpbmcvZHNhL2NvbmZpZ3VyYXRpb24uaHRtbCNjb25maWd1cmF0aW9uLQ0KPiB3
aXRoLXRhZ2dpbmctc3VwcG9ydA0KPiANCj4gQ291bGQgeW91IGhlbHAgbWUgdW5kZXJzdGFuZCB3
aGF0J3MgbWlzc2luZyB0byBwcm9wZXJseSBleGNoYW5nZSBwYWNrZXRzDQo+IHRocm91Z2ggbXkg
YnJpZGdlIGludGVyZmFjZSB3aXRoIHRoZSBuZXcgUk1JSSBjb25maWd1cmF0aW9uPw0KPiANCj4g
SXQncyBwb3NzaWJsZSB0aGUgcHJldmlvdXMgcGh5X2lkIGJlaW5nIHJlYWQgY29ycmVzcG9uZGVk
IHRvIHRoZSBvdGhlcg0KPiBTT00ncyBFdGhlcm5ldCdzIFBIWSBzaW5jZSBpdCB1c2VkIHRoZSBz
YW1lIE1ESU8gYWRkcmVzcyBJIGhhZCBkZWNsYXJlZA0KPiBpbiB0aGUgRFRTLg0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIHN1cHBvcnQsDQo+IA0KPiBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291cnQNCj4g
U2F2b2lyLWZhaXJlIExpbnV4DQo+IA0KPiBgYGBjDQo+IGV0aGVybmV0QDIwYjQwMDAgew0KPiAg
ICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC1mZWNcMGZzbCxpbXg2cS1mZWMiOw0KPiAg
ICAgICAgIC4uLg0KPiAgICAgICAgIC9kZWxldGUtcHJvcGVydHkvIHBoeS1tb2RlOw0KPiAgICAg
ICAgIC9kZWxldGUtcHJvcGVydHkvIHBoeS1oYW5kbGU7DQo+ICAgICAgICAgcGhhbmRsZSA9IDww
eDBjPjsNCj4gICAgICAgICBmaXhlZC1saW5rIHsNCj4gICAgICAgICAgICAgICAgIHNwZWVkID0g
PDB4NjQ+Ow0KPiAgICAgICAgICAgICAgICAgZnVsbC1kdXBsZXg7DQo+ICAgICAgICAgfTsNCj4g
fTsNCj4gDQo+IHNwaUAyMDEwMDAwIHsNCj4gICAgICAgICBrc3o5ODk3QDAgew0KPiAgICAgICAg
ICAgICAgICAgcG9ydHMgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0QDUgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDA1PjsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJjcHUiOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGV0aGVybmV0ID0gPDB4MGM+Ow0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBoeS1tb2RlID0gInJtaWkiOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJ4LWludGVybmFsLWRlbGF5LXBzID0gPDB4NWRjPjsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmaXhlZC1saW5rIHsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNwZWVkID0gPDB4NjQ+Ow0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZnVsbC1kdXBsZXg7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAg
ICAgICAgIH07DQo+ICAgICAgICAgfTsNCj4gfTsNCj4gDQo+IGV0aGVybmV0QDIxODgwMDAgew0K
PiAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IH07DQo+IGBgYA0KPiANCj4gT24gMDcv
MDYvMjAyNCAxNzozOSwgV29vanVuZy5IdWhAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gPiBIaSBF
bmd1ZXJyYW5kLA0KPiA+DQo+ID4gVGhhbmtzIGZvciBjcmVhdGluZyBuZXcgdGhyZWFkLiBDb250
aW51ZSBmcm9tIFsxXS4NCj4gPg0KPiA+IFlvdSBjYW4gY2hlY2sgU0FNQTUgKyBLU1o5NDc3IEVW
QiBEVFMuDQo+ID4gWzJdIGlzIGhvc3QgTUFDIHNpZGUgc2V0dGluZyBhbmQNCj4gPiBbM10gaXMg
aG9zdCBwb3J0IHNldHRpbmcgb2YgS1NaIHN3aXRjaCBzaWRlLg0KPiA+DQo+ID4gWW91ciBldGhl
cm5ldEAyMGI0MDAwIGhhcyBwaHktaGFuZGxlIHdoaWNoIGlzIG5vdCBpbiBbMl0uDQo+ID4gInBo
eS1oYW5kbGUgPSA8MHgxNT4iIHNwZWNpZmllcyB0byAia3N6OTg5N3BvcnQ1QDEiIHVuZGVyICJt
ZGlvIi4NCj4gPiBJIHRoaW5rIHRoaXMgaXMgc2V0dGluZyB5b3UgZG9uJ3QgbmVlZCB0byBzcGVj
aWZ5Lg0KPiA+DQo+ID4gImZpeGVkLWxpbmsiIHVuZGVyICJldGhlcm5ldEAyMGI0MDAwIiBhbHJl
YWR5IHNwZWNpZmllZA0KPiA+IHRoZXJlIGlzIG5vIFBIWSAoZml4ZWQgcGh5KSBmb3IgImV0aGVy
bmV0QDIwYjQwMDAiIGFuZCBpdCBpcyBlbm91Z2guDQo+ID4NCj4gPiBLU1o5ODk3IHNoYXJlcyBh
IHBpbiBvbiBTREkvU0RBL01ESU8sIG5vIE1ESU8gaXMgYWN0aXZlIGluIHlvdXIgc2V0dXANCj4g
YmVjYXVzZQ0KPiA+IFNQSSBpcyBlbmFibGUgZm9yIEtTWiBzd2l0Y2ggY29udHJvbCBhY2Nlc3Mu
DQo+ID4gSSBndWVzcyAia3N6OTg5N3BvcnQ1QDEiIHVuZGVyICJtZGlvIiBjYXVzZXMgcGh5IHNj
YW5uaW5nIG9uIGhvc3QgTURJTyBidXMsDQo+ID4gYW5kIGFzc3VtZSB0aGF0IHRoZXJlIGlzIEtT
WjgwODEgUEhZIG9uIHRoZSBob3N0IHN5c3RlbSAocHJvYmFibHkgb24gTkVUMT8pDQo+ID4NCj4g
PiBQbGVhc2UgbGV0IG1lIGtub3cgbXkgYXNzZXNzbWVudCBpcyBub3QgY29ycmVjdC4gV2UgY2Fu
IGNvbnRpbnVlIHRvIGRlYnVnDQo+IHRoaXMgaXNzdWUuDQo+ID4NCj4gPj4gYGBgYw0KPiA+PiBl
dGhlcm5ldEAyMGI0MDAwIHsNCj4gPj4gICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14NnVsLWZl
Y1wwZnNsLGlteDZxLWZlYyI7DQo+ID4+ICAgICAgIC4uLg0KPiA+PiAgICAgICBwaHktbW9kZSA9
ICJybWlpIjsNCj4gPj4gICAgICAgcGh5LWhhbmRsZSA9IDwweDE1PjsNCj4gPj4gICAgICAgZml4
ZWQtbGluayB7DQo+ID4+ICAgICAgICAgICBzcGVlZCA9IDwweDY0PjsNCj4gPj4gICAgICAgICAg
IGZ1bGwtZHVwbGV4Ow0KPiA+PiAgICAgICB9Ow0KPiA+PiB9Ow0KPiA+Pg0KPiA+PiAvLyBNRElP
IGJ1cyBpcyBvbmx5IGRlZmluZWQgb24gZXRoMSBidXQgc2hhcmVkIHdpdGggZXRoMg0KPiA+PiBl
dGhlcm5ldEAyMTg4MDAwIHsNCj4gPj4gICAgICAgICAgIC4uLg0KPiA+PiAgICAgICBtZGlvIHsN
Cj4gPj4gICAgICAgICAgICAgICAgICAgLi4uDQo+ID4+ICAgICAgICAgICBrc3o5ODk3cG9ydDVA
MSB7DQo+ID4+ICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJldGhlcm5ldC1waHktaWVlZTgw
Mi4zLWMyMiI7DQo+ID4+ICAgICAgICAgICAgICAgLi4uDQo+ID4+ICAgICAgICAgICAgICAgY2xv
Y2stbmFtZXMgPSAicm1paS1yZWYiOw0KPiA+PiAgICAgICAgICAgICAgIHBoYW5kbGUgPSA8MHgx
NT47DQo+ID4+ICAgICAgICAgICB9Ow0KPiA+PiB9Ow0KPiA+Pg0KPiA+PiBzcGlAMjAxMDAwMCB7
DQo+ID4+ICAgICAgICAgICAuLi4NCj4gPj4gICAgICAga3N6OTg5N0AwIHsNCj4gPj4gICAgICAg
ICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLGtzejk4OTciOw0KPiA+PiAgICAgICAgICAgLi4u
DQo+ID4+ICAgICAgICAgICBwb3J0cyB7DQo+ID4+ICAgICAgICAgICAgICAgLi4uDQo+ID4+ICAg
ICAgICAgICAgICAgLy8gR01BQzYNCj4gPj4gICAgICAgICAgICAgICBwb3J0QDUgew0KPiA+PiAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgwNT47DQo+ID4+ICAgICAgICAgICAgICAgICAgIGxh
YmVsID0gImNwdSI7DQo+ID4+ICAgICAgICAgICAgICAgICAgIGV0aGVybmV0ID0gPDB4MGM+Ow0K
PiA+PiAgICAgICAgICAgICAgICAgICBwaHktbW9kZSA9ICJybWlpIjsNCj4gPj4gICAgICAgICAg
ICAgICAgICAgcngtaW50ZXJuYWwtZGVsYXktcHMgPSA8MHg1ZGM+Ow0KPiA+PiAgICAgICAgICAg
ICAgICAgICBmaXhlZC1saW5rIHsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgIHNwZWVkID0g
PDB4NjQ+Ow0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgZnVsbC1kdXBsZXg7DQo+ID4+ICAg
ICAgICAgICAgICAgICAgIH07DQo+ID4+ICAgICAgICAgICAgICAgfTsNCj4gPj4gICAgICAgICAg
IH07DQo+ID4+ICAgICAgIH07DQo+ID4+IH07DQo+ID4+IGBgYA0KPiA+DQo+ID4NCj4gPiBbMV0N
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L0JMMFBSMTFNQjI5MTNCQUJCMTMwREFC
MUU3Njg4MTBFRkU3RkIyQEJMMFBSMQ0KPiAxTUIyOTEzLm5hbXByZDExLnByb2Qub3V0bG9vay5j
b20vDQo+ID4gWzJdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L25ldGRldi9uZXQtDQo+IG5leHQuZ2l0L3RyZWUvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9j
aGlwL2F0OTEtc2FtYTVkM19rc3o5NDc3X2V2Yi5kdHMjbjUwDQo+ID4gWzNdIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQtDQo+IG5leHQu
Z2l0L3RyZWUvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2F0OTEtc2FtYTVkM19rc3o5NDc3
X2V2Yi5kdHMjbjE1MA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IEVuZ3VlcnJhbmQgZGUgUmliYXVjb3VydCA8ZW5ndWVycmFuZC5kZS0NCj4gPj4gcmli
YXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4LmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBKdW5lIDcs
IDIwMjQgOTo1NyBBTQ0KPiA+PiBUbzogV29vanVuZyBIdWggLSBDMjE2OTkgPFdvb2p1bmcuSHVo
QG1pY3JvY2hpcC5jb20+OyBuZXRkZXYNCj4gPj4gPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+DQo+
ID4+IENjOiBVTkdMaW51eERyaXZlciA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT4NCj4g
Pj4gU3ViamVjdDogS1NaOTg5NyBSTUlJIHBvcnRzIHN1cHBvcnQNCj4gPj4NCj4gPj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdw0KPiB0aGUNCj4gPj4gY29udGVudCBpcyBzYWZlDQo+ID4+DQo+ID4+IEhlbGxvLCB0
aGlzIGlzIGEgZm9sbG93IHVwIHRvOg0KPiA+Pg0KPiA+Pg0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvQkwwUFIxMU1CMjkxM0JBQkIxMzBEQUIxRTc2ODgxMEVGRTdGQjJAQkwwUFIx
DQo+ID4+IDFNQjI5MTMubmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8NCj4gPj4NCj4gPj4gSSBo
YXZlIHN1Ym1pdHRlZCBwYXRjaGVzIHRvIHN1cHBvcnQgdGhlIEtTWjk4OTcgUk1JSSBwb3J0IChH
TUFDNikNCj4gPj4gY29ubmVjdGVkIHRvIGFuIGkuTVg2VUxMIChTZWUgYWJvdmUgZGlzY3Vzc2lv
bikuIFRoZSBjdXJyZW50IHBhdGNoDQo+ID4+IGltcGxlbWVudHMgYSBwc2V1ZG8gUEhZLUlEIGJl
Y2F1c2UgdGhlIG9uZSBlbWl0dGVkIGJ5IEtTWjk4OTdSIGNvbGxpZGVzDQo+ID4+IHdpdGggS1Na
ODA4MS4NCj4gPj4NCj4gPj4gQXJlIHRoZXJlIG90aGVyIHdheXMgdG8gc3VwcG9ydCB0aGlzIFJN
SUkgY29ubmVjdGlvbiB0aGF0IHdlIHdhbnQgdG8NCj4gPj4gZXhwbG9yZT8NCj4gPj4NCj4gPj4g
QmVzdCBSZWdhcmRzLA0KPiA+Pg0KPiA+PiBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291cnQNCg==

