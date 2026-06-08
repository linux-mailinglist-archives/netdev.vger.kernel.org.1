Return-Path: <netdev+bounces-296424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k1NXE1KFJmr6XwIAu9opvQ
	(envelope-from <netdev+bounces-296424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:03:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A73654577
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:03:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BHKX89OG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296424-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D7AB30B4575
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FB3AFD1A;
	Mon,  8 Jun 2026 08:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124B2C11F9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:47:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908455; cv=fail; b=N7eLo9AS3860P3DitPb2XbIDvombr/E5LAgebxlOxtiQOKaKHJc0NK9sJIEqTXWtr6A9FfFDRfZxLziou6pvHPeCy9Fft72Jaw0PsHwRDiPBuodJarpKwUHZnKxFL7B7sfjBjOTshHA5zshL95ELAaVdOXr93twIemSz+prci0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908455; c=relaxed/simple;
	bh=K3DayKl2nprgrBwGiV6KSNUuY0rEzeMchUqSBcsKq8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ci6EWZpFlhnLBuLDmubyHK0Uof0nf1uqUQJgDv39eERBqPCkT+Gri5Xet7WLDR4e/vBilLCBP6w4MQhZEB5XKvWcVaBsXh2xXCVATFBpyeHMlUV4lEN/NlmoD2cT4nQkwsDANLyyiSSEGTeRSdDhWyk6jNELEv/Ve2057+cOR0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHKX89OG; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780908453; x=1812444453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K3DayKl2nprgrBwGiV6KSNUuY0rEzeMchUqSBcsKq8M=;
  b=BHKX89OG79J465tYveudZ8tbx8LNUfLneT5Q+twtqLD/fCc3V4VD3Hdq
   JKrlXRQfPUwnnyyOLi4IlFHXZsnLy/vTt+uzUmlHCT7nsenh/eFszNOlD
   W1OgGzJzrAnxAYx30RlPq79VkckbIO4QlAobFNrSabIuFnAnsLyqM8oBB
   iWBmAIQWM2gr5Qd9NLjUjm9mxzl5bcCO4Dec51bYRfZ/omoOAIQk/Zgjp
   UeKxZ2jU3RrWQLKLqiuQi8xk18F+1LEr1Egn+juoUx5CTWwii1YgKmLEZ
   n5pLmS/qgsJzKvoa+78eZ+vw5Si3olnyUjLvU5SD1MCdotnrSn7NywbyT
   g==;
X-CSE-ConnectionGUID: JrJ/xoW4Rla6gBMGQXDxDg==
X-CSE-MsgGUID: rVPFV40jSiiMaVNKcAK+zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81759739"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81759739"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:47:32 -0700
X-CSE-ConnectionGUID: qvILWFnSRvWTp985MHNrlA==
X-CSE-MsgGUID: rBYZQXB9TpmbORhyQ86KHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="239140522"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:47:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 01:47:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 01:47:31 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 01:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8Zwm8TY75g2GwNysHg9bxR0+SrMe4D4Qu7YygKi1WyVvI99lWw0bqKyu1xfzA2Ulrxe/5RFC2/TFdWr+pqMWLGl4iBJG54uElnERBl0+vxYc9IkneyVhZQmBlRF3XpjdEU2u4rwQA11tt9Ojnv5phfavbz2e3ytFsXPwjwOefLl43nL/jONk97XJHLbwnQXS7EwC2FUEp6Fl8TWUV91aEIkoWC9cMqJqwi1plOiLkr9W+flrg3ZcwP5wJb7gn0cOHBaXMGt+dF/cxTE82X0HODGQ5FhRJ7QrhQF4LKnnuZtPWP5sN6L3OmKnQk8TO29logdEcDyuOsqblHyltLT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY7SfHXKrWsNXjDmbStc6XfqbUJX6Meq1ja3RqBeBfU=;
 b=iQtBflaMZIcuBrrOeVllAjsJOmGUv+Vt6n+6xP1Elpra0d2vdSR9rNUgsK7gNZGsMZw72lD/lJu1+hs0fOodFQanbWbiIkSMO7G0hJ5xq2TNdEiskAg8THsTOkssI588vNlqcDC7XzbOJf+zBAbUSir9NGVQr5j8mQVlyJBl2SsX0f62dCcHqUCV3CjHP4fJgaUlCF2qNv2cXN1Nrs+ZPg1K1O19WZqtg3xxjv9Ein3/HrMC9J2xaUYxYTMwkAcdzqoJ7cBt1B9heS5EjcuKs5e6kkE5csd8796Oh2l/n0UjC+WVOW3J/oDQDheU6j+2J1UxLWzamG+HpxoaERn5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Mon, 8 Jun 2026 08:47:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:47:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>, Breno Leitao
	<leitao@debian.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH net-next v5 1/5] net: ngbe: implement libwx reset ops
Thread-Topic: [PATCH net-next v5 1/5] net: ngbe: implement libwx reset ops
Thread-Index: AQHc9ABSaGnt7mmfbEa4diijO4WGSbY0Xr5A
Date: Mon, 8 Jun 2026 08:47:17 +0000
Message-ID: <IA3PR11MB898650C89C7F737A3B8367EBE51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260604085631.12720-1-jiawenwu@trustnetic.com>
 <20260604085631.12720-2-jiawenwu@trustnetic.com>
In-Reply-To: <20260604085631.12720-2-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6501:EE_
x-ms-office365-filtering-correlation-id: 27113159-d7f0-4936-c637-08dec53a8b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|5023799004|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: dXIbqqMlKVqcdWseqdyrvKJoAMHsdxR7PZPRp9W+7pWzIb11fmyChD7msyWt+bgZ8dleNoJIaOHsN393B5YKFwuLfxwP40M7iXm45iFGLgrBl9xwTeCq+i6PSz/EK432CQ/rxZg8I1IagRENjpqKwE6jk1vSN+266yJ/pGd5m26o1uZAijT8TnDE67X9pGP9ZfuW8bVnQmmIqUnwAsladY5X9SQIPLT2eeXxqT5QJLAgcdvaoZpDiXhoYMNbpHzG5bBX2kUFd6Y44faPJ6ZwO+WmyVEhKzjy7fMdIw19Dstjvwuc+XKqQwqY62tDQz0GfvG4VstLctdHwHOI1nm7Aim0+5wk/IhEOzTHkszJbesGRQ/MnEQxkxsmiJA2VpZdC4s4PazGnTNBokYJ3Bk4yshIro11PLri7xaM2ELyNQRprqSmkdgdo91JhvXL8UVUEoUeKfwXKfMa0LWm1zNiIotaXyV95Fz0e3NCTfk9WD8dPBjLta28OwrghEbuTiFTXd5O3hAXir05iJEvoSojJs6COA9JkEyPfKMBKwed7pehX1LLZ1gKpFhDU3iUqs9aumDF7Dp/M9Lt6Ya9MkvbOWwcl8I9UmddrzwIiI06Vo05Ca9B0Hd5OQGcDD0HKpDo+if5uiJ/eCOHS4GLQZDjfHf98MrrYz7SCoRMxa3VubZqxFzJbg4OTZ5hoBO189xGjMuuOb29+nZJFpv5zwu6L8nKa9K8N+RxL5THVdR/6yTxcmEs8s5/vkba48MunJWq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(5023799004)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WXYBY43+oQHtOpmOcpp/9B8kgaB58gFsrYoKlfZlNkYktxoafgZyjnawsA?=
 =?iso-8859-1?Q?enan4ifBQYJ68zv0pzDcxpUeHMgzrMT2FJ+7J/0eUjAf+IBOEORVVf3E2H?=
 =?iso-8859-1?Q?geRIrGtArdjb3z7T1Y8k/yya2c7Sd2D5ZDGY71mZdkKYjVsyCZcxWun7ns?=
 =?iso-8859-1?Q?0n7suAoaLDRrYWasbqDYoyUhbdQ14HmtEf6mNefXpvKEfZh1P6/i7Uep/g?=
 =?iso-8859-1?Q?xHJbNnuvuHwcUh/wPtYfAgawSMRNGp/J7RORCktkllKo42U4rzT0lOBv7X?=
 =?iso-8859-1?Q?66b6cB5b3qDCv1BDMmazhFf9FW6slZvYLioCGp0qkrubx3EqsTVxjbtKdn?=
 =?iso-8859-1?Q?j6kgHvoInOp+DX2Lhy5ezj7f1XMmofMUHrdef5cGWdLT0WlSLPeS2Kiz49?=
 =?iso-8859-1?Q?328MpS2Arudqez/KgixgvJYk899sStUX9wNGe8kNoBIoYOuvkoM5sqR3eP?=
 =?iso-8859-1?Q?qmVJSGM/GTio50KhbeaBWsFS0QiKDS9x0GTosgpaFM1iqzYQzlRwdOAGYP?=
 =?iso-8859-1?Q?AHjMAzmg6ajls5mx6/DAcQrWEOXrhOyh3VEh8ODvrYmnn98b/zBeol4Zb2?=
 =?iso-8859-1?Q?LiDuISnJYCsoGUinl3FjTmK5EKD3Ct0JT0pzusiqDrOzVh6RdyVpC2XIWf?=
 =?iso-8859-1?Q?AK8I0ksxuImsEXA812Chf7sx23JLxoxbkAaBDpF4gI9/6ysudF4S9+HGRx?=
 =?iso-8859-1?Q?TzisxVVM1KzuhPpiP5uO9Ne8n9S/V/18Py53i3ZM474T7QHxAxQQ8mNuVV?=
 =?iso-8859-1?Q?SkzEDaAGdXTS2GzrnQmyuLvUraXOf4pl4XDmLrY83D4dB1I0Lgwlz+ybg/?=
 =?iso-8859-1?Q?ZWlC3kSorZnaZyBqfiIJh5PkfFJfydBAUtsgtLjDJpyvYY3Lsra6xY0Wzs?=
 =?iso-8859-1?Q?DI/Q6VbB3wUakYsy945v5R/Iqys5pqtWz92k+kAnXxdDyv0YYcs5ZVkTIb?=
 =?iso-8859-1?Q?HkxeWo67+GMZdWquWxli0jd7bFdMgrQQHZM3Bm7SaDK6wnE8sSE03rWXM+?=
 =?iso-8859-1?Q?yuRJV9pEFMYp564akGjbMR0CD+UUxxG6d//1rzsl6vyGwqhvbVj9LAmE77?=
 =?iso-8859-1?Q?f0HkU/ii84H3N54qwnne+RlKBktHuwrt41VPA6oUXxWK3zKphEaSu2/qbu?=
 =?iso-8859-1?Q?0y110OYS1sgMNngkP36fBtVMqQaprt0xB1TVAxID65KeVmaa5+a1lB3vwE?=
 =?iso-8859-1?Q?HoFy+EXHKAtCUs36eMzJZaQlab/Zm6jvgPUW0Ii2LUMPf5xldqtxDDfVzx?=
 =?iso-8859-1?Q?YnZzzJYmG+atXgr+DTyNI56aOo7t5+r3pT3ncEX7PBv7H4osa6ZfHAnxMx?=
 =?iso-8859-1?Q?gBeUokVixZuIl70p7Xbd226PF4m5LmdZAYhOyMUmyuyULseyXm+GU8YgJj?=
 =?iso-8859-1?Q?ijxDgfX9CYcuG+Gse8detr0CFToixz33183do8Hnxw5tW8foHWhJaEL7H/?=
 =?iso-8859-1?Q?B9ceN9G1HvnpTJwKMPTtky1ZR7pN3feNWZYrfm02j2NTOf6VDPBvmXIKgs?=
 =?iso-8859-1?Q?wmVhybCYahU+au61uGIUcL/xwXTHoUmWpzBjOBfqD/36LSUoCAh4m/8AOv?=
 =?iso-8859-1?Q?dprkvK8LamkmcQG4cIP1K+4eVBcVdVSOIEA0xf1XD8UXoSsNBPDo93wLQt?=
 =?iso-8859-1?Q?DvozV9rNy1BUYiotRjpPlPB4+911b3iQQedJ5VxI7PwFZrJQ+XyFq3fTB6?=
 =?iso-8859-1?Q?RM4HfGj19qDm/9lBAcAwb8pnF3cbcAstIHLQn16HWQhODR/Wbny/UXruaV?=
 =?iso-8859-1?Q?rlFoBE2R/qgRH+haV9EnPTyID5mxL3o+CyfUc6w8fpK85pTvH0UCs0Q//v?=
 =?iso-8859-1?Q?4vNELk9p+XLiHETOHv0GvuylTLt797U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZYunjNECygdF3EiP0q8K1+l/oTz4IczZUTMfFsmReQcJGovTHLiQwwFEn7vDK9I2KNHyuF8qon9u4a9OpF2mDGV2VrkUZTPHVbxfW25Z0my66nQ5fvdZNRqmfMkZOJ9YkZ/Foz/4d55ooHPUPApT22GqPPGteC+dMzwNhpNdBNBxuyQAW5cd2VI7bTntxYTcwWRQSE0vbD77PZjaIufC4iAwWnE/VyPsks4HXqQGDcwyuExTP3Q9wfzN3S/SZ5nl7Zfs9D8NdgqZmyUV6XgdAyphrs7Qk1Ms78Fv1lGvyJKGao/I30r1Ud0/w3RT6UEMaFjo4NA5ghvjxeCexL/7Zw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27113159-d7f0-4936-c637-08dec53a8b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 08:47:17.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /j7+6jQUInwNQVF1LMq7wgdXweV2I3Xiywl4Oxl6Udipt/4h8Gal3O6PxArt0QVnsruPGRhO4uM7OAnUGk2l1IW9OWFXAIGmxMqTg2hbldQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93A73654577



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Thursday, June 4, 2026 10:56 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Kees Cook <kees@kernel.org>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Joe Damato <joe@dama.to>; Breno Leitao
> <leitao@debian.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Thomas Gleixner <tglx@kernel.org>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jiawen Wu
> <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next v5 1/5] net: ngbe: implement libwx reset ops
>=20
> Implement wx->do_reset() for library module calling.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 37 ++++++++++++++++++-
> drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
>  3 files changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index b2e191982803..1960f7154151 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -59,7 +59,6 @@ static int ngbe_set_ringparam(struct net_device
> *netdev,
>  	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
>  	kvfree(temp_ring);
>=20
> -	wx_configure(wx);
>  	ngbe_up(wx);
>=20
>  clear_reset:
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 8678c49b892a..dea6dfb043f3 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
>=20
>  	wx->mbx.size =3D WX_VXMAILBOX_SIZE;
>  	wx->setup_tc =3D ngbe_setup_tc;
> +	wx->do_reset =3D ngbe_do_reset;
>  	set_bit(0, &wx->fwd_bitmask);
>=20
>  	return 0;
> @@ -423,7 +424,7 @@ void ngbe_down(struct wx *wx)
>  	wx_clean_all_rx_rings(wx);
>  }
>=20
> -void ngbe_up(struct wx *wx)
> +static void ngbe_up_complete(struct wx *wx)
>  {
>  	wx_configure_vectors(wx);
>=20
> @@ -490,7 +491,7 @@ static int ngbe_open(struct net_device *netdev)
>=20
>  	wx_ptp_init(wx);
>=20
> -	ngbe_up(wx);
> +	ngbe_up_complete(wx);
>=20
>  	return 0;
>  err_dis_phy:
> @@ -503,6 +504,12 @@ static int ngbe_open(struct net_device *netdev)
>  	return err;
>  }
>=20
> +void ngbe_up(struct wx *wx)
> +{
> +	wx_configure(wx);
> +	ngbe_up_complete(wx);
> +}
> +
>  /**
>   * ngbe_close - Disables a network interface
>   * @netdev: network interface device structure @@ -590,6 +597,8 @@
> int ngbe_setup_tc(struct net_device *dev, u8 tc)
>  	 */
>  	if (netif_running(dev))
>  		ngbe_close(dev);
> +	else
> +		ngbe_reset(wx);
>=20
>  	wx_clear_interrupt_scheme(wx);
>=20
> @@ -606,6 +615,30 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
>  	return 0;
>  }
>=20
> +static void ngbe_reinit_locked(struct wx *wx) {
> +	netif_trans_update(wx->netdev);
> +
> +	mutex_lock(&wx->reset_lock);
> +	set_bit(WX_STATE_RESETTING, wx->state);
> +
> +	ngbe_down(wx);
> +	ngbe_up(wx);
> +
> +	clear_bit(WX_STATE_RESETTING, wx->state);
> +	mutex_unlock(&wx->reset_lock);
> +}
> +
> +void ngbe_do_reset(struct net_device *netdev) {
> +	struct wx *wx =3D netdev_priv(netdev);
> +
> +	if (netif_running(netdev))
> +		ngbe_reinit_locked(wx);
> +	else
> +		ngbe_reset(wx);
> +}
> +
>  static const struct net_device_ops ngbe_netdev_ops =3D {
>  	.ndo_open               =3D ngbe_open,
>  	.ndo_stop               =3D ngbe_close,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index 7077a0da4c98..4f648f272c08 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -125,5 +125,6 @@ extern char ngbe_driver_name[];  void
> ngbe_down(struct wx *wx);  void ngbe_up(struct wx *wx);  int
> ngbe_setup_tc(struct net_device *dev, u8 tc);
> +void ngbe_do_reset(struct net_device *netdev);
>=20
>  #endif /* _NGBE_TYPE_H_ */
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


