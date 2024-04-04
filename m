Return-Path: <netdev+bounces-84910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC7898A24
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC450283C2F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570D129A99;
	Thu,  4 Apr 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wPRu8YRm";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a8HHcgvq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2395129A7D
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240994; cv=fail; b=rpWwTZGa8+2uOTg3JdeO0dOd0ZH8K6V1TJOvnUJJyUaDm07YewRu98AIwCgER5bG/13zCEv02CTkGN7+umym48wu8WYKqfFJoyfGWzM11zZ8gZLNXTAyFjxjlKWBEcYuYVngtNC+7WQ8EjHsvgaWT2f1/o8RsomiUbXd+1qRXr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240994; c=relaxed/simple;
	bh=NR9u4Nc1R4SfJtvJX4hYH3jS9DpDt4BVlI6759ai5Nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQ+H/AYlk7DenQQdWwi5IXG9QVNoSMUHvppld9c3B4brEnaDokUkrC/CBUZfRVIQchyZgiFZP56WUu34UWPM9VVMYYxrZOJ0Z6eK0UsDpdTXlZo56oN/T9Q6Yg3FOuHYrTNQX0WYlOYDyZM3jicbUTsRXxqLdb0BtvvPXNvjTgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wPRu8YRm; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a8HHcgvq; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712240993; x=1743776993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NR9u4Nc1R4SfJtvJX4hYH3jS9DpDt4BVlI6759ai5Nw=;
  b=wPRu8YRmjbg/htM6/RiVXpalJ80U7DT0Z/C1MfVvjgPF9bgJW8N11C74
   of1G5BHNrua/9F+hOkdo8Vy+4dmlTJQGuauFr6l063XvyC+t73MapfiXz
   +BQXRMzaJE8I+FxuRE7c5BAr4qXS0VADUTsau1WmJHma3mGrGxVoKG6w7
   PCa35v/a/wUjc9J/TZagmtgxhQd4G92ZC9OFAyDvYzv8I79iEuYNJ6IPX
   MUgkX/hr6n5VkfzRzoUOXCQn5GzWC1JfkXOOMVfJ4LmKira9cirn4Wuu2
   oVSEadIqtssZKUsDyMTKQSBtF6TKOaEB5ZrLr+74PzUYNWLSLF80FFTSX
   Q==;
X-CSE-ConnectionGUID: RpukmcF7TEWoV3rMO29S/w==
X-CSE-MsgGUID: arWH6mxNReCuJBUjnEnTtg==
X-IronPort-AV: E=Sophos;i="6.07,179,1708412400"; 
   d="scan'208";a="19499995"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 07:29:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 07:29:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 07:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T535SNBQlzn8ZCdNOHZSx5uaUSAlwul41B9KaMAUd3vTWEJSSwlVLZDow4KY3gzwn1qHq69EwfgCr4XF7b9GvgmHEreeZipATwbJ34E6x0Eu+OCWDF7gtL8f8UtT3ayvJ5JnvDpoSiGzAOjBhZDqtJuiadt8c7PtmV/PTEHcfEaGMTgaxVkGFh5IBA0YVgjOJN/zikWI5H1jz6tR97ZtR7ODY4G89DRJfGj34NT7OmvR4CZcRA2vZGJIkwk6Ix+2vEBYmiLpKQE+XIgrBnfBnAGo6IPR00pnBn+X/3gVjV074dVPXSpbxSVl5A0Kc2+bf7+03aUZubtldIN2Q9q+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR9u4Nc1R4SfJtvJX4hYH3jS9DpDt4BVlI6759ai5Nw=;
 b=faNMym4ea+TM52u3d0ou/0/VuB/4CwKf+MsQA+S/Xw3rClxjoFxorZPtnS7YetiubL1eeqkeaF5utulrMGKYWyTx+TGGVEGImpzCbeK3S22H6Vi3F5Zp9EKKMVG9w4ASRJDQgyju7o7+98qpN/yDlO9z7F1DE/y+iNr55CD2LlZAdA5GlUjIeDzKEp0sJjzp5NVJQ5v3K1vQRswqhFZ7YMNFl1eUeRNCaOYRsA+t95ICjXHJW17V7rf5+aAwnQ5+KZvPO3YtdC2cLmcyLUYk3y6eIksbkEICiLq0f2BABP1YRrWGqiINmpbI3JNQUQ6Jl0hnkm9riN+N2hUrRD9OLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR9u4Nc1R4SfJtvJX4hYH3jS9DpDt4BVlI6759ai5Nw=;
 b=a8HHcgvqKFbxDIgizmcbsPQq8LkPOIJ1D+9XE3cnmzqBu5tCfCV3c9lz89XTd/ZfS4+wUVID2ds404rCYWjxklQNwOp4G4VPd2uvXhCOL+DYbf0fQk907cC2am/p2ReBDcClOyl8wax+a9i1K1umC76fFqADA+qPkhGtyGZBUP8or/Z5z2obQ6mEwKUdirlKBbJRYJhXYlHnpxihvojGQ/38EeA8v45EqR3o4mSADmaVXt2bMPZSzliJdxp4T4cMvTF4X4JhjIXVgfZgLJByXywQIvOhX0v1i+0I+CmkMdKnxD4nmrBd0nevoHRpOQ+A+6npFiNx7H6iOIygFA+tCQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 4 Apr
 2024 14:29:33 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 14:29:30 +0000
From: <Arun.Ramadoss@microchip.com>
To: <l.stach@pengutronix.de>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <f.fainelli@gmail.com>
CC: <kernel@pengutronix.de>, <patchwork-lst@pengutronix.de>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: dsa: microchip: lan937x: disable VPHY output
Thread-Topic: [PATCH 3/3] net: dsa: microchip: lan937x: disable VPHY output
Thread-Index: AQHahfE4BX6Sg0d2FE6wm3qPP07P+bFYLX8A
Date: Thu, 4 Apr 2024 14:29:30 +0000
Message-ID: <4285527b93a7e5b2221f1680e9e1cc36cf128558.camel@microchip.com>
References: <20240403180226.1641383-1-l.stach@pengutronix.de>
	 <20240403180226.1641383-3-l.stach@pengutronix.de>
In-Reply-To: <20240403180226.1641383-3-l.stach@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CH3PR11MB7865:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/ztPTyeUzXEnEbW+YL0k1Mx8uC+3fJiKtNPAO3qtwSnv7yTeKhpNWzKTAeKYewJsLiyMvUPrXK0S8lZUqrSt/imrOeeUAcdU3hUFzCO/X/4CbUSH7OTmYmW4GzuEoR99u9ZUfAWbFE1R4XGLNDI5lt/jEWWJ0sI5wTT9g1xZp6b3+nmuAr/U2mq0FCEUBWioTER/HUAgmJX/LAkyb25lDUnHDewF8hVzvf7cUqOk50V57jkryu4AMKEIopPCV5I7sYQrtrNiNjRSZf+6emRt+MkBkrUwyqeoCUxSAV4hmgkB8Gh/MpIgHOJnDx/IaNH8ErtBzG9PjR+quVwmOF3FQh3zIZapSNoq8zHi/mZpGAryM880HIKXi1QGx5K4YAx0oio8joV3bX6eAoMZDKav4XELJXnPLmWjgq2gezGywesarF0pAXaxSywATM+3RZUb8Ww8y4ufnsutTm/Q7x6icnniuRBVJX1U+HXAkKuR4th1Rc32oGU9uYbjZzQq/LAOqwyoYlVFAC61yyaoI1GwKMs5uzq2brw7C+O1aqSC89JwTt9ISridOhWObn/hTf+xRQJJID6nSVnkpd78TGIgiALj/9+muUUA+EONDn8sOdbSLhcZaDo0Dl9cC/U/G0l5+ROjnhpdH1W3GYcxT7+oc0eTH4dXait24T564kz/W4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFAyWmplNjNHc1dNM2ltZkV1aDY5MC9kRHByaGFMNzNma0RER0tDMWM2Qi84?=
 =?utf-8?B?ZU5pbHFaSEIxbzJvUnBROEJiK0NQc0Z1T2M2RjRHNjJDSEVrVmt2RzVvWkZz?=
 =?utf-8?B?Z1g5WHhBbitXK1VsQnpob0k1VzJBWVpTTWpZYnV1dGsxelFoRW5MUDhiSEwz?=
 =?utf-8?B?Ri9MdWcyY05jS1NoTlF3eUdJd3FraGNSVjVyaU5CcThjUC80eDZMMkJGR0hE?=
 =?utf-8?B?ZGZZRk1HTmRGeHZtRmM0S2FBWnltdWJXSmNNRDA4TTJESlJ5d0VhZkl6QjdV?=
 =?utf-8?B?dXY0bDAxQ245aFpUelRnMTRRbDVRZVU5d0dnWEU2NlBXNld4YTJlZ0paNUsy?=
 =?utf-8?B?NTNlYjRKMDNKYkNtVlZLTTdCSlZJeXZtWFZFSDUrNjE1ekFGZ2RHcXQvR3ht?=
 =?utf-8?B?R1NBL0g5dVN0aU5sYTRsQ2FOcXltaE1RZ3VDSXpUdFAzSkcrVXRWaEJ6QTR4?=
 =?utf-8?B?NUQxZU8rQmRUZTdSa1NFWHVxNUdzZjBpdjlQTXRBSUhZbHUySmh1VTB1SFZZ?=
 =?utf-8?B?eHlhakc5ejdOZ05kd1BwZ3hQc2V2WEtBY1Q3TTMyZ2VOWTloQUJqd3NqVzFE?=
 =?utf-8?B?SkRqemFVTk1neGVVMUNiYTFFR2hiOC9MSllvNXJ6Rjh3L3YvWXYySnBFNGdm?=
 =?utf-8?B?Wk9IcERWODlRalVtanc3VGxGSU01VW9JYmNFditHZVpBV2dLTjFidHhoU2FT?=
 =?utf-8?B?aGdSWkxjQnhrVXBzRFFUWElsMytjUE1DNFg2bXBoMnpja1RVeHF1Ny9TeFFn?=
 =?utf-8?B?Qi9WWWtGeks5cWMwdzVkNGlvazVTaCthdlhCa2o1dXlBcjAydjdBTWlac1R0?=
 =?utf-8?B?Y2dVZTYwVllSSmp5R1BrdWIyYmgvQ0xCSFE2ZmcvcnhtUGVsMHZ0c0doNC84?=
 =?utf-8?B?S1gxNmhiNGtnUk94NXZ2MkEyeUtOaGg5S25TcVAwZDZXc2g5TWxhd3BKZVBS?=
 =?utf-8?B?YnBNRU5Fd3hUZjNpNXkvcGFQdkFxckVsY3JEYndVMkFyZFZWY1A2K1dJTFBo?=
 =?utf-8?B?WEk2ampnN2hubFEyWG5zbU50akQwWlV2WVFGeFFGY2dhMVlPbU5FM3lTL0h0?=
 =?utf-8?B?aFQ5bEJqRU1YWXJ4SG1YZ1kwS2QwY0xFVUptOW9JRHFtdXJGVXRiY2FqUmlS?=
 =?utf-8?B?MlJ3c1Z2czE5R1Nhak9DYzZMWVlqK1RRVGVKdS9JZzBPT0lhQ25BdklMODdS?=
 =?utf-8?B?MnVsOEJ5M0dlb0JWVFV2SlF6L0JnVGtBSkpoR2hCdUhJajFVZVpMREREOXhm?=
 =?utf-8?B?a0RCcForL1lBb1VheStsMnllS2d5Wk1GOVh6K2lxOUxRbkkyTzlnY3MzVDM0?=
 =?utf-8?B?cGRJZUN1YmhtNzFaMzk5Uzcya1pEZEZmTWlDTTdLOHBBUlRNbUdvZjFtTU5x?=
 =?utf-8?B?RkZIVFZMdTQ1L3NlVjlxY0NDdmRJQWdIQU50aFFZcmJPSlRjLzg1TkNxZm96?=
 =?utf-8?B?RTVubHFlcnZkSlo0UUIyQVM1cGVvOTNGWmwveFFBZk5KWDA0K0J2dzdxRnJi?=
 =?utf-8?B?UjkwVFRKR0QyTTRweXdHTVNHNURVYi96QUc3Z1JBMHRzREMwdzhGSHRqakNJ?=
 =?utf-8?B?WTkxaUUrNlBWNjVJT0p2WTU5VW50ZGNJQVRNdktzVmNZS2I0SjYxYjhZaVd3?=
 =?utf-8?B?RjJEUHcvZC96b0xuQ3dWWDFnbW9EUkFQZVhDRmQwbHFneUVEYnJIbWFKZ1A3?=
 =?utf-8?B?Znp6cm1ETFdHY1VwWjFEcjlQek85aWNHVVJkS1l0SFNaUWdxeElhbWJ6TlFI?=
 =?utf-8?B?SmhyaFczRkZkdVR6SG9RVFd4WHJva0FOVGVrREhVcFNrTXNqdUZ1Y3o4WGN1?=
 =?utf-8?B?RE8zVmtIeU50OE8rS1hQZjZzUkR4ZmJpdnI5OGxmTUxuYXVDNXJkM0pxdWpk?=
 =?utf-8?B?azhWa2toL3Y1VU5OcVNuOXVrVHV1MEtqNnBtUFFyUTBYRmgxeHpaSWgvMXlU?=
 =?utf-8?B?bXkvMThtVHdsdUR2dm82RTVUby9vNStYMnhyZjJyaE1KaEtXOUp6R21MN1Np?=
 =?utf-8?B?b1dSUi9mc0toY1Q3N3BtN24xaTBZZVNOTUJxTXVkMnc4LysrNTJIUlJMd3Bp?=
 =?utf-8?B?SzEwR29rYjFJcFZWMm5mazhuY09EUUlGaDRwbnM5NWh2TXdhaTUvZWVnMjF4?=
 =?utf-8?B?b1RMWnV2SXBqRk1qOEpmVlhjTjRaMVh3V05yVFhjcmNHQ3hoWFkrUGhoUkJF?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3068DFEE30BA1144BDE5CBCACC397D3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6bf0fd-266d-44e3-1f6c-08dc54b3a3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 14:29:30.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GagCGh/EZcIkl7GpjSMqRw3Psy3GWPqk72Atps1AW3BbZQ7Ej9kRFBuNhXez9P9fK0nYnkOj+rkOmkGl1fIbsSdMxieMen+XvYnElNFuNqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7865

SGkgTHVjYXMsDQoNCk9uIFdlZCwgMjAyNC0wNC0wMyBhdCAyMDowMiArMDIwMCwgTHVjYXMgU3Rh
Y2ggd3JvdGU6DQo+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tDQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGUuIExlYXJuIHdo
eSB0aGlzIGlzIGltcG9ydGFudCBhdCANCj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRl
cklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPiANCj4gV2hpbGUgdGhlIGRvY3VtZW50ZWQgVlBIWSBvdXQtb2YtcmVzZXQgY29uZmln
dXJhdGlvbiBzaG91bGQNCj4gYXV0b25lZ290aWF0ZQ0KPiB0aGUgbWF4aW11bSBzdXBwb3J0ZWQg
bGluayBzcGVlZCBvbiB0aGUgQ1BVIGludGVyZmFjZSwgdGhhdCBkb2Vzbid0DQo+IHdvcmsNCj4g
b24gUkdNSUkgbGlua3MsIHdoZXJlIHRoZSBWUEhZIG5lZ290aWF0ZXMgMTAwTUJpdCBzcGVlZC4g
VGhpcyBjYXVzZXMNCj4gdGhlDQo+IFJHTUlJIFRYIGludGVyZmFjZSB0byBydW4gd2l0aCBhIHdy
b25nIGNsb2NrIHJhdGUuDQo+IA0KPiBEaXNhYmxlIHRoZSBWUEhZIG91dHB1dCBhbHRvZ2V0aGVy
LCBzbyBpdCBkb2Vzbid0IGludGVyZmVyZSB3aXRoIHRoZQ0KPiBDUFUgaW50ZXJmYWNlIGNvbmZp
Z3VyYXRpb24gc2V0IHZpYSBmaXhlZC1saW5rLiBUaGUgVlBIWSBpcyBhDQo+IGNvbXBhdGliaWxp
dHkNCj4gZnVuY3Rpb25hbGl0eSB0byBiZSBhYmxlIHRvIGF0dGFjaCBuZXR3b3JrIGRyaXZlcnMg
d2l0aG91dCBmaXhlZC1saW5rDQo+IHN1cHBvcnQgdG8gdGhlIHN3aXRjaCwgd2hpY2ggZ2VuZXJh
bGx5IHNob3VsZCBub3QgYmUgbmVlZGVkIHdpdGgNCj4gbGludXgNCj4gbmV0d29yayBkcml2ZXJz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU+DQoNCkkgYmVsaWV2ZSwgaWYgdGFyZ2V0ZWQgdG8gbmV0LCBmaXhlcyB0YWcgaXMgcmVxdWly
ZWQuIA0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9sYW45Mzd4X21haW4u
YyB8IDMgKysrDQo+ICBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfcmVnLmggIHwg
NCArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9tYWluLmMNCj4gYi9kcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFpbi5jDQo+IGluZGV4IDA0ZmE3NGM3ZGNi
ZS4uOWRiMWQyNzhlZTliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlw
L2xhbjkzN3hfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3
eF9tYWluLmMNCj4gQEAgLTQwMCw2ICs0MDAsOSBAQCBpbnQgbGFuOTM3eF9zZXR1cChzdHJ1Y3Qg
ZHNhX3N3aXRjaCAqZHMpDQo+ICAgICAgICAgbGFuOTM3eF9jZmcoZGV2LCBSRUdfU1dfR0xPQkFM
X09VVFBVVF9DVFJMX18xLA0KPiAgICAgICAgICAgICAgICAgICAgIChTV19DTEsxMjVfRU5CIHwg
U1dfQ0xLMjVfRU5CKSwgdHJ1ZSk7DQo+IA0KPiArICAgICAgIC8qIGRpc2FibGUgVlBIWSBvdXRw
dXQqLw0KPiArICAgICAgIGtzel9ybXczMihkZXYsIFJFR19TV19DRkdfU1RSQVBfT1ZSLCBTV19W
UEhZX0RJU0FCTEUsDQo+IFNXX1ZQSFlfRElTQUJMRSk7DQoNCmtzel9ybXczMiByZXR1cm5zIHZh
bHVlLCBpdCBuZWVkcyB0byBiZSBoYW5kbGVkLiANCg0KPiArDQo+ICAgICAgICAgcmV0dXJuIDA7
DQo+ICB9DQo+IA0K

