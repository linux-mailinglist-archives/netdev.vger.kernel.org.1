Return-Path: <netdev+bounces-94639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620268C0089
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFAB1F21E11
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3B8664A;
	Wed,  8 May 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X34HmSTo";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A3/K6rdp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F61A2C0B;
	Wed,  8 May 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180332; cv=fail; b=SRHuGFyQWuLMZA3g2u/lw5tKu08KNK2vDUkG6A868Fagk/DnePVwOnVESEshhRDkhpTySTnbKEg5iOj6de3pMNfEZh+dPE8jCdF6PIo1aJX8ooX0LzcJP/q0rd9CYa2FNx2LIuCnp10E7sTY5I1I5uXawu+1KZCs4JTQ9LAaEaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180332; c=relaxed/simple;
	bh=XZBSxu1pzaC0rWBDWVWMlNgtm96KvbjpiSBr7rVf9t4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N0jjgZZgH3i9RR2mmCMOd7k3lgIskP+7ATU40lj7EV5ZkIjeqbzui6UI7Fx8BORMCmTSBhelpa3jxcTC0cF19eh9RH9NkYZO1/fCbqwtOOFobYoghvVQvmkJEePQL3AC/1HXUSnOtOPRWBtRl6HhVjOihz9M3ODGxm1sLIsEh24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X34HmSTo; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A3/K6rdp; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715180330; x=1746716330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XZBSxu1pzaC0rWBDWVWMlNgtm96KvbjpiSBr7rVf9t4=;
  b=X34HmSTog5Oy7aECbLFoTkBibHes7KxMKEYTskNrBrmTcpptL+jIrN5z
   YY5v4rqC32K17IQ3OD1S0hEVooMHX1BmcwRAJANgSeXmPq6HvSdYbO+iQ
   KAvBtzfRUk6UHfCevf+TSRt1nrW5bADUjfCBzWqWDvUGNi9T8jt4aqpWQ
   Csy5U2A3sN/GAOMXcUc0NfabPYbSmKDE6EKCWnFu81bFwRjNeoArqDx0C
   YTIL7gliL/7RA4rStd1wztBaKv/omieaDLr/bQ4GzdHVc1th8e13Gsbiu
   yLov9U78I7S0nxzD0EfSuDxJOeJAtpwM7uCrXMh4jzzp8jSbM0SjBoZjq
   Q==;
X-CSE-ConnectionGUID: GZ2/P7r+TiCFqxezHkbccQ==
X-CSE-MsgGUID: I/vzgPCMSUueOk9RAg/eIw==
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="24130634"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 07:58:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:58:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 07:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTz/HctKGZZYuPiJDn+WArcv3Ikis3WPZDoI+NGZETVIVfXGsM/uJJ9RfA1Dhg2Nx/sQpISqBro+YZ6z6tKRFOMcNfEQV3kOIrfkb/BuMd6AppCcgmH4FtmXRfg6BdSRXUzJQf6afqpAVTq6PHZHhF9rSjlq/tWZ00sQuYySSgFqJsQDW8zGSI4VmGqF1v7Xtrr4Xpxg847U8fafACeh4mn7lq/ogC+lHb1yJWKnGKshWKqtICw9o09/+tTbCPCZTa8YokOTFaa7Gyn/hm4ehud3uPGogYUWwIIGioD32MODUnR+Rz2tY4giiNluTj+EQDw57lw4R4xkh7Flfdl4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZBSxu1pzaC0rWBDWVWMlNgtm96KvbjpiSBr7rVf9t4=;
 b=dqxw+yyRn6RKbXxIEUoG9Y9dJavVVNQIB5f3bcdSfIws0UMwBdmbwxfMwoJALgiNumUJErDNcRrDkmC92Qyv9/JonjOo4wOtMWsyOV3a0QbVmRM7Mkkh4td+Wcqgi74Ih25996ZA/Nv8M6DMYT5fDeUrTWl36ydoJqApx6fry0VcO7GhAW/2WZV7QyDn7ct3ww7oufc7dz++KVx11yWjDSTyhvgoF1h6PicR60wZBgq5lc6z+MRr4YSpdug+FAIrVmU3RzS+iBq918QUipgp0HqYAY2J0t4MAebwwciMBJyTqfjcHtKnRmeaHr7Nfv0OOZeBW1i/6bFLeS/S6D7sIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZBSxu1pzaC0rWBDWVWMlNgtm96KvbjpiSBr7rVf9t4=;
 b=A3/K6rdpEFniPkXqK+22AVC8Jlr/0pACPtQiwb7JskJV0atxurnyDjAG6Co4HWtKFxFhoj+nYmDwt7meVX7UNr34zxzfgko1efKvZi2ceJQSvhnX1OGS4/G8ij5SGiurh9qYQKD7k3hb6qtwAF2jEeudAwrO8HWR3+auU+K1qc3b08xrDrlQEpFU3HsH2f8zNOQwXfop/KcIu4Bp6EgR4HeVvPAihCRpOOIH9E8dQGWkYCI6+Vx9D2cxA/3Ke0171TmQ5AFXG3fs4EuKxoQgEqBFfXSUe55pZ2n5gpWjEovBonqJY8MJE9DoMDQOZJVQdmPTBlpkSwWCrWLqrS5yeA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 14:58:43 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 14:58:43 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/3] net: dsa: microchip: dcb: add comments
 for DSCP related functions
Thread-Topic: [PATCH net-next v1 1/3] net: dsa: microchip: dcb: add comments
 for DSCP related functions
Thread-Index: AQHaoTQEsCLVCJmyKEKJ4iKr3fPmjbGNboiA
Date: Wed, 8 May 2024 14:58:42 +0000
Message-ID: <d2c74dca0fb8d5c2d0467f34bae891d3ca7b3521.camel@microchip.com>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
	 <20240508103902.4134098-2-o.rempel@pengutronix.de>
In-Reply-To: <20240508103902.4134098-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CH0PR11MB8236:EE_
x-ms-office365-filtering-correlation-id: 6ff6ef46-f17c-4210-74d6-08dc6f6f5a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L0srOWdPcW9lbFJKMUNSZEZ4NGNSeWVOaEM0SFlqUmhkUm82T1ZFN1V4M0hN?=
 =?utf-8?B?S1cwSWd3V2U5MXN1eFozNEdZL0pNTVNFUmtyeVNFaXJCc1JWakJEZTg4YjFI?=
 =?utf-8?B?bTN3Vm1oVExoTEVscXdYMkZ5RjZ2eWRQNGZxL1hRQ1pWUWx2b0ZIY1dSSzNF?=
 =?utf-8?B?T2JVVVpTWHA1azJZNlRKbjhmUm9SdnlwRFdpSGpsR29DZGpjdWE2NldTR1Rr?=
 =?utf-8?B?eXFjbERYaTFoL2ovZWtjeWFIR3VXVWQ4eEVGVDl1Y3pydmMzLzJSMVI4ekhE?=
 =?utf-8?B?RTNuU0tpZGVaSyttOWk3K3JLNHZuaDVlL2xTb2VIbHpZVXVuQUxDdXMzQnM5?=
 =?utf-8?B?enpFSThmR0xoNXhQWElVeTZGczUxSENsR1hVc3NKWFpmWVMvT3FnSHh6YzRR?=
 =?utf-8?B?OExTYjh1aEJDS2hGbWZ0aEx5aFVnQ0tXNnVKN1ZOUjFtNkx2Y1pKMHBSRFJ1?=
 =?utf-8?B?bGNiU2NnSDZrdjg0QjgwNWtJc3FzWWx6THJZMVVpU2xJOHl0VXlCNEZZdzVo?=
 =?utf-8?B?VlFtVFpnRWh4dWNrTy9YZm53K1JlMHpmUVdiQS9PcnR1TlRVRFp5cGJXM2w2?=
 =?utf-8?B?aXNhL09uM0YwYXdqbzBDUklHMnZCcmZ5UHZTaVE1RXpNdEJCRlBUM2k5RE1Y?=
 =?utf-8?B?STBBL0xFeG1pemJ4c01XdGJWd1dmMzNIYnVGaXlJdUNTTnppZ2JpeDZtMkdB?=
 =?utf-8?B?Z1Y5U2Y0UG9maTJHVzBvSmVnSmlkcVFaNi9DUzVXTWtEamJuaW1GWG1TR2RN?=
 =?utf-8?B?blNNVGZlRldXaUlVaHROS3lXN3VQcW1LemNLR2hwSjZacnFPV3FmVHI2RGk3?=
 =?utf-8?B?clBJUVZId3EvOVBHczBBSEY5a1BoeTJUamttRnI1czJta3pGWEZZaTdQV2Zj?=
 =?utf-8?B?UE1uRjZvSG54d2RLVFVISFFmcm94Nlo5c0JNQVVxZDA3SlZ2c1Qxd3gxL3FN?=
 =?utf-8?B?SmI1aWptSjFEZnRxNVZnVFRYL0FHcWlXcENKMkxQczZMZHlUbGFvZitLTUpW?=
 =?utf-8?B?ZUcrN2VWQjQyc2J5SVN1STNvVzZyM21NSW5rdU00MkovWHRxclFGbmdUOUU5?=
 =?utf-8?B?TlFlaStQQ3J5dm5ranNVYkhFUlVIRlUxNnZYWlZCcXVhblQyK1hiNWp3UjNs?=
 =?utf-8?B?YlVxcmdFWWN6U3hCZ0laNmlxMjMxT3N0RGJ6ZWNXckVoWUtzbmF3bS9TUjRF?=
 =?utf-8?B?MnZEQkFpbmJucGxuYUNvSzBUeUJLejBQWm50SVc5c25NVDROUHRxdzY3UU0w?=
 =?utf-8?B?N1gvT2RNSFlncjFsUjNWWDkydkpmby9LWngvemQ0NWVSYzcxVVgxRXV0YUQx?=
 =?utf-8?B?Y2dwVXpZSU13N24wODdyVURGQXIxRXlFZVdpK2c3NnN6L0VlREIvclFYVWgx?=
 =?utf-8?B?enpiWUR6NUZzVFFnenJhbWRqUVp3a1QyekJGbHNUb3NRVlVNUWVCQlp4eWZP?=
 =?utf-8?B?VHJudEZ4TjVlZ1VrZndoNnErQ0Z1VmYxRTZ3Yno4NXo2L091Z0o1K1NOM001?=
 =?utf-8?B?VGpyS2FLQUwzUXZoVHNuVzg4bGZKZjlyd3RxMW9tRk1BZXlUallCbmxveWU3?=
 =?utf-8?B?Uzd4eWhVcGN3bnVjRkErRWNWaldFRlp5d3d5NTRKbm5QVTFGdFZBb0pxd0Jp?=
 =?utf-8?B?ano2Qm9LdEM4M3pObjRBc2JDUUhycG5SUGlrMjFVS0VZdmZydDU4b1NSM3Nr?=
 =?utf-8?B?R2JHMzJKTjFGU0Nua0xoUXpYK0hzU2wyMTgxRldFU2cyU0t0MGxxcjRNNjRk?=
 =?utf-8?B?VjV1bjlBMFp1RzlRc20zMU1OZW5kRUJlbTViM1FTaVkyV2NqdkVaalJqNEVN?=
 =?utf-8?B?VUJpUkFCNGI5WklCM25hZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNFZm8ydkdmSkNHSjUwVTd0U0U4Vm45TzFqRXdvY0hWTGJVanJEZ3U1Z0ta?=
 =?utf-8?B?aEtqSUd6WjFSL1Q2aHExOXRXUlk2MzFNbU5McVo3cEdUcS8ydzEzQ2d1N2py?=
 =?utf-8?B?SERzSkoxZzJTRU5FTUlBSFFtOGxEbDYxNzU2VGMrNnNTYnpBVVZSWDJUME1Z?=
 =?utf-8?B?WUM3bENvV2R4UStnUHVtSUYzRUQzb1VlcmMzY3JQeFdJUUpUb3VEOFNrS1pv?=
 =?utf-8?B?OVRtdjc2anVQdVRUQktxSkVQY2IzTVhGVFM3djlCZUxkUmFhdGRTK3FjVS9C?=
 =?utf-8?B?SWpqZEU1b1dzTVBoQ2krbHhWSGhTZmdJZkJlU0pTZlM3S3loMjBSUzZMRytE?=
 =?utf-8?B?UlJ0YlFicERnT1BpTmNXdkZoZExhU01YcjNhNnBkaVAzZDBKak5BajJVMWpR?=
 =?utf-8?B?RFcrczZ4WGY2UTBjNlZ4c0FuNEZBZGQwVFJubmUrNXorWVBJcUxscG5QeFNS?=
 =?utf-8?B?THYvSDJOYU92WXU3YnllWWs2Mm5TZXE0aTNGZkNEMm1ZZWlGZ0hZYlpBUk40?=
 =?utf-8?B?Z1A3d2U1VmNwbWtEd1FRRklFUXVMNG5nQ3lFNDR1aFp0OHJRSno4blQzN2ll?=
 =?utf-8?B?NENseXA5SVhpWXQwUDVTR2NmVkRIY0xNUHJNdWhtYWNnQnBMSUVkT2hNUGZ1?=
 =?utf-8?B?ckxldE9tRnJ2OWxxTTAwRzhOdklyZTRrUUhPbnNzajF1SThEQWlBU3paNlZn?=
 =?utf-8?B?VER0WGlpTU5nTkNsbVo3T3IrK0dVR0RuVWt2RUpTaU0xUndUT1ZIaE9NbW4z?=
 =?utf-8?B?Uk1xR1c5a2VBMFpQLzZoUmpVV0VWZW5DVjg2Zk5WU3l4dmZJaUJVYVhBcWZC?=
 =?utf-8?B?bWtMNGlCOGVaVUxlVzRFaGoyWWw2SzlZZXFUek5oKzNKYUFuSmx4dm8yQ3Qw?=
 =?utf-8?B?ZUh5cE5JSDVDL2hxc1dEOFJEeHhHMEtJM09WWVFaU0hXczhWT0RDTWYyUXEv?=
 =?utf-8?B?OElrL1RDSjJCR1hqcmhiUzRmbW1sWUVOWkpXTEJaa2MyQUNrR2gxam45aGho?=
 =?utf-8?B?NVM2QThaZHlSckNPY3ROak5ZVzh3Y2FFakttN3doUjZHR3lHRVBIMnpVWDZl?=
 =?utf-8?B?dmx0cXVCQWtuVDNETEIzU21maEJTVWRoT1dzVVIyRkI4T1F6U1FrRXUzcWtq?=
 =?utf-8?B?TmF2SDRTdVNlUDNHaFEwYWp4a0I2dFcvUWIzdmlSaUgzS0Y1SFZZK1AyVWRF?=
 =?utf-8?B?NUt3VGlyQTZsdlZwZjJObzlTR096Q1lubDJvYVpLamZtTXNOZkttdnpCZXoy?=
 =?utf-8?B?RTJYay8wQkVVV2VrSkE2dkJkVm9pc010OEdsSHNXOTM0V2ExTU1NZ083R1Js?=
 =?utf-8?B?L3J1WmRTOGlEQ3hCek5yVzYxVTVUT1d1elhKYXBtSXhJdXNwenI4N2doMmZF?=
 =?utf-8?B?TDE3VTd3NlRLSEdwVE9VdTM4MUszTFZhSFRDV2UrbmJiZzNUTHJxcldyT0hx?=
 =?utf-8?B?Nmhub0pqeCtMeXVWRmpGM3pPLzVMOW9aaUFFRTZvbXF3VzBqUDlwWU1KQTk5?=
 =?utf-8?B?TDYxOUZ6d0ljeTIvQUJoeFBybi9lR1Iycit4eFhzNUpHK3BSQTltY25xUjZR?=
 =?utf-8?B?WXVsMmI5cmNuQVB4SUJibUNkQVpFa2RZemVPU0k2WGQzS2RudHNoRjlja3FE?=
 =?utf-8?B?ZWlJYWJBM1BWK1huMWVGTk9qNnFqeVdZUk8xdXg0aVBrV3FNU1dGdVkxRVBV?=
 =?utf-8?B?MDFoTXpMQTRXeFBQdE4remsrT3RGL0FPTEEyY0NYU3REZDM4WmE4ZXZqTi9j?=
 =?utf-8?B?UERDSE5nc0lGbG42MWVhN2tMZXZoMWltQ2U3N1dXSE40RkE1NHVJOUYvRjZZ?=
 =?utf-8?B?aUtSajQxRVJ3NDl5QlZZb0NyL0xjYjFrZFJXOHZPbVlzUmJKSjJNdGo3dXpk?=
 =?utf-8?B?TDVCUXI5dm9Xd05iN1FXMVVJcjdIanEyd0lwcnVkeE9Ma3crOVNHSmQvOERO?=
 =?utf-8?B?M1FOU1BwOUxTMFRrUGZRTGNCaXFvTVlFMmZiOWFIZFBwTGp3UmpybzlyV1pR?=
 =?utf-8?B?aTZzVUc4Q3Z3d0J2K2JBaDY0eVlFRTMwL2JKdlJXWEdzSlhPVlUrZnFDY3RV?=
 =?utf-8?B?WVFSVFRSdjRBRTQ2V3kyZnB3REZRMS9reEpwditYVnhzZUY2RklpTWpuS2lU?=
 =?utf-8?B?UG9HR3ByR2FEbmdXam00bTJucFNFNGZxazRGUFNOM2xjSlRrc0ZIeE14VzBQ?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B117BFD60C7A9749B248EC4BB86C91CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff6ef46-f17c-4210-74d6-08dc6f6f5a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 14:58:42.8675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdN4gNZ9qi9Hzd+8BHkdnr2JBEePq+ui6SzOdJ4lpM5Pk7JRH/WMD2P3GJxV/UV25pJD8SlLuESruXP7J4S4xCA8ldTeqFYmrBr+thmWWF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236

SGkgT2xla3NpaiwNCk9uIFdlZCwgMjAyNC0wNS0wOCBhdCAxMjozOSArMDIwMCwgT2xla3NpaiBS
ZW1wZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gQWxsIG90aGVyIGZ1bmN0aW9ucyBhcmUgY29tbWVudGVkLiBBZGQgbWlzc2luZyBjb21tZW50
cyB0byBmb2xsb3dpbmcNCj4gZnVuY3Rpb25zOg0KPiBrc3pfc2V0X2dsb2JhbF9kc2NwX2VudHJ5
KCkNCj4ga3N6X3BvcnRfYWRkX2RzY3BfcHJpbygpDQo+IGtzel9wb3J0X2RlbF9kc2NwX3ByaW8o
KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJv
bml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2RjYi5jIHwg
MzMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfZGNiLmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzel9kY2IuYw0KPiBpbmRleCA1ZTUyMGMwMmFmZDcyLi44Nzk0NzFjZjgxNWUzIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9kY2IuYw0KPiArKysgYi9k
cml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9kY2IuYw0KPiBAQCAtMzEwLDcgKzMxMCwxOCBA
QCBpbnQga3N6X3BvcnRfZ2V0X2RzY3BfcHJpbyhzdHJ1Y3QgZHNhX3N3aXRjaA0KPiAqZHMsIGlu
dCBwb3J0LCB1OCBkc2NwKQ0KPiAgICAgICAgIHJldHVybiAoZGF0YSA+PiBzaGlmdCkgJiBtYXNr
Ow0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQga3N6X3NldF9nbG9iYWxfZHNjcF9lbnRyeShzdHJ1
Y3Qga3N6X2RldmljZSAqZGV2LCB1OA0KPiBkc2NwLCB1OCBpcHYpDQoNCm5pdHBpY2s6IFdoZXRo
ZXIgYWRkaW5nIGNvbW1lbnRzIHNob3VsZCBiZSBsYXN0IHBhdGNoIG9mIHNlcmllcywgc2luY2UN
CmluIHRoaXMgcGF0Y2ggeW91IGFyZSByZW5hbWluZyBwYXJhbWV0ZXIgYWxzbyBmcm9tIGlwdiB0
byBpcG0uDQoNCk90aGVyd2lzZToNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFk
b3NzQG1pY3JvY2hpcC5jb20+DQo=

