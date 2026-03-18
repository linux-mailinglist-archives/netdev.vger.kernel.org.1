Return-Path: <netdev+bounces-268952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF+hNHZ4ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:03:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C72B99CC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A16530BD4A0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411133A874A;
	Wed, 18 Mar 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZQ2IV8R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061E29D273;
	Wed, 18 Mar 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828136; cv=fail; b=QcLaV1cJcHadR8cmseLRAGfwIWNbUOWAuQKnqejxAaCcG1A1WbcLuFvFR9g50jXS/wXt8dlnv5CqkhB4dfBGU6X8WPqtYITE9NYfDF7P3IRgYAuEco3L8VFGv04FITB7DGv9aMYLGsnWN25Z3pti+q+p8v8xuA34TfzAazdBnYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828136; c=relaxed/simple;
	bh=ccYnUUo8LnhHUUrjnPJApi0WWsFHseLGrmHuMPvoNMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BfadzSkcJyWSNdlx3U0an9RD+jKeZiknKr/7VjMmYzKIr5SwG+x4XmRJPlSNfd3i21+Wyjerbd34DhshGthZ/IvaOmJhXevvPqAXckkviHBRsEEOhHCtLN4ew4ZIModDUUxiMqpT6/7AUncC+BgWIHpZFNsz//iMekQW6xyJZ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZQ2IV8R; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773828129; x=1805364129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ccYnUUo8LnhHUUrjnPJApi0WWsFHseLGrmHuMPvoNMQ=;
  b=AZQ2IV8RPYETHQIxBJl+S2hkyBMii5qxDlVtPNzoPH19XegSLbyndFbG
   XY+5K6T2YQ+6utzwVmpra3VcLg36Dgm2aVWucZi5dsorpy5MNUuGR2WDn
   TkYMNo9LWYokGx+8G9zrZzZkOQloR3pLeGzpUOTre5BsCwx5h83jUn9Zk
   xKFSxShONW4kidACij1PXjYk+08EiHHQFNIoHMharEbnfmM8ypANlsAPK
   8XkzoVXeCppEnRATMoO84rEaCMwCYSSLPPGz3Rq1eCKGowht794RlduLT
   /4LwnRbpDpW1/zA3nSAsgutdFLcsmFeaN+CF851uxF3h+fXKmrMUJyStM
   w==;
X-CSE-ConnectionGUID: VRkSqK3USvGwRkAQbw8rXw==
X-CSE-MsgGUID: A8yuG0XOQwOANDrQ/4DZMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92259531"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92259531"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 03:02:08 -0700
X-CSE-ConnectionGUID: GSAwOA+2Rbect30edeJ4Fw==
X-CSE-MsgGUID: n/kKJeQcQA6RnRrS+akFdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221812525"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 03:02:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 03:02:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 03:02:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 03:02:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4Z81aIV7+P9JWEkwdEVep848eRj4xLEn2C9yDgMSyKVy+JUtNES02szjlYlYPzq1J0IxR/S1RUeXOyVdobespnZLyWCjCqgnbfi2VJpQq8A/xwrdPpJXwzVzjyRior8AKX7BXfey4Y/Xbcs/nXXQ5Z88X928EmDBpXeo0LeQQTXN8dHgW5aqB3hMfn/qq22tej3tk1syB5M7lWmJMwl8D6NhjEDW9Q3BSNX0dc2LaI7JYG/P9RsUKShFx5sQ3H1a+gaEErYlthiRiIGYZLm10+Ft9yzRm6Pn0mk1GaV0krRr4zEcEPtCejpNE/OFZxLfgcuFfYa/Rzp5Wwp7U9mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7dbzR7QtmACasPgBEnAgRVUYLNNPq01j+e9E9cOp18=;
 b=UQo9RFX03MrQRic+zpBuA3kz+5jApWd7/tWrgCiHcy2wolXPUKG0zVf4S2Dd/rFI1cMObGU98rpAVKHpk7npSfO3o9ja5m6CevUyR6Maw37lM6OoIx7rDnid2h/D/uXJDPc/Qe7LYgI11JPLriUrAxNNIuxCRgJM880+ue/r4sZv7VquDc1TCVurlHOsUXutquwbZt8RnMuB/Hh/fnVFBe7eoC4xT3tcnS4GQ3TkMcALnMGf3j+qY6IAOEQ80W71YSByh+aRdX4LAVU0yYVtz0zMqjKiT1tpyol3jYtErn8nrOsgtftDTP78/mzM6GaDnvAFeU61WIOo4zbcjJ1nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 10:02:04 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 10:02:04 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next 7/8] ice: add Tx reference
 clock index handling to AN restart command
Thread-Topic: [Intel-wired-lan] [PATCH net-next 7/8] ice: add Tx reference
 clock index handling to AN restart command
Thread-Index: AQHctrdDZQWZrdHOOU2Eg3dsQdBx37W0DwLg
Date: Wed, 18 Mar 2026 10:02:04 +0000
Message-ID: <IA3PR11MB898675A56BEBCD559D2FEB4DE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318090654.611349-1-grzegorz.nitka@intel.com>
 <20260318090654.611349-8-grzegorz.nitka@intel.com>
In-Reply-To: <20260318090654.611349-8-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB7293:EE_
x-ms-office365-filtering-correlation-id: 6edd1f45-b916-4746-b01d-08de84d567f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 0sNHK3YPBwU26hlqwbMGatSZIWgmRh4aUjNSAzVhQ0ZSVK3hlPMPePg8d4NLrJzil1eB2z6qAHB4kq5DgYIA+sRjgzIHniSzBL3jNxVyG2NUESAYWF9tpPc1dXGu2RlSZ5O8KKG34LT2UjkNpvdGklrmeX6jrBvo2xge1e9EdQFXFeo7Sm/uQfBJwhcicJ1UOglhtPo2Nu7iUytB88NA9DLW69sQ73V4j0qVLZW3tsNskPUEatfFuEJ4ALr6tKwYL0dm3GGjxcmu8z2Natfuy43B3vCoR0hPNX3vxBCczJiRyNQnO6dpOGs/GPk1mGtt3E+DgOyGVkNTadcYZavNz7AtS3szDUMfkyfAXjXT5MC3esuMLb8agIjQY1vZOie4lExNe1FygkQvQ5zlpKOEJ/2Xe1WMhLx//ncPSnw7QlnQZHgmhaf8cfT/dWIPXqvzC6no0XTgJF4NWQ/ygrND2d5zNWSsJM614uUEkjtJtY97LVsPGmTcbBAxZYpbvpSmGCP3O8CHfihWLBgK6vjjAuwBQ4P2Mhl2iZf1LItJaNLpdwP7rR3VkGPttcOhxCw0Lzybqjxf/De+J2TEXo4d+MNekLiktGiArOAfJcuMwM1hcfoGAtBOLPVsmHDUKUvIH9xR28YuSQdtvsQ0JExn4rficHfGcoSD/KgZIRMbF1CTE5lOlfUwXr9BU2vOVlV/87QvhvwmGClZIwbtmG4m4PTCNVgePGjpvXMvn/gX3RnBwKBJ3XgyttQJ3df7XIRCHoxOeL+uwrjjJ3l5jWUrZCRYPob/GNZjk5eUxFmihik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eoqOIuEdixvVBoMQsdNJgg+dyqUE15+gr9KIW471TdHKCPNq6fWNUlgHEftY?=
 =?us-ascii?Q?/aYZ/TCOkahSoizidwsBQTPjMM+0mXeJkIi/tsR0AvvVR8tiz/dCJq958e3I?=
 =?us-ascii?Q?HkCexJ8iad9suSZKmq7gdhWgp9HgdVpijUHXLZQf5Z3p7GLIzjaDs0Z+feZ3?=
 =?us-ascii?Q?lzK9oIzPPwAf92lwuLgUqtjystKt86PfrEL8SnLEY6MneQiK+RcwETF5o6P/?=
 =?us-ascii?Q?nXPqcfx3FAnXc3KOANNdRxO/kuFnRn5Ms06TxBwkM3dt4d1IFDcbpJQmTkDT?=
 =?us-ascii?Q?5eeUqwYF2USNIFqChSdebFuG877umM850nxpRxmjWXjFMhUuADQuIKtmH10V?=
 =?us-ascii?Q?EOmcBXZGwXv+os/jOaiFeeBbloQzrc0tFdtrcH5qtURqK4lUGhrcoU+xrh+u?=
 =?us-ascii?Q?8RhqAb+Tp+ynb2HL/JiKc7CK0EBlAK6w+PXgbiYVcbhIQijhhwfgsjdNhwbK?=
 =?us-ascii?Q?A3For+XFAlkn0xJ+HQWfG16Hg9Yf/CkGZZErMv2woCF+I3M8FhnuZOjq/Kkf?=
 =?us-ascii?Q?WVyLeJDztZo4NHH4neI9A8g1dhSgYcPq22oxLoYoF+0TKNoCCWTHqepvdCdR?=
 =?us-ascii?Q?qfwwhN2ZRwHFZFMUvZLeu3Rq4Ulwkj2Cf7KYgqFqCzgjeAAFY4slOVnYVar6?=
 =?us-ascii?Q?fjGXM3+X6NmsyQ3PFe8nhG4zmEG+gGJtMCrdqK0rFsqiei4NeG/wsniyWTDy?=
 =?us-ascii?Q?RhsYDutPbbFvtyRfw6qz1SwttFRhmSYY+OxmkRaz/cf8HoVhLeUi5jBVzxzd?=
 =?us-ascii?Q?y5KgGS62yzcxms3KKMhbyA7rx9Ht2BrXAfS02P3sn31CIvlCEoFb19RdWT7T?=
 =?us-ascii?Q?N/LyyYN2PzNqHIIghtY+kzwAaWRe1NDDFlIfnFmmAax+bUQCkmTULEy40Z+b?=
 =?us-ascii?Q?PHRcof/570NxWuB4+gEuQF7E3DJwR0bpXKHJxRnhaIW8XbeAoFaoVppViWUP?=
 =?us-ascii?Q?e5eWz4vnmVsDvwei8DqhKc1fOLnWFWmwvi87gfWK2gocKv3E87HC1e/YyArY?=
 =?us-ascii?Q?YbWCX1S19SJ8RxGVwIxk28V9VK//msTdBUt3Mt9tT72+gqt3FSFTkl0SuGvj?=
 =?us-ascii?Q?oNVFmsrSKY+TupuSVLp82wY0q25nzck2bROIXdEVya5fbwimcVgtPd9qb6yG?=
 =?us-ascii?Q?VFTkc2+LsSOJYOv7oojfgcLYsmySa3xSnDn3hcNzoN71i1sOsmWwInvWuWDj?=
 =?us-ascii?Q?LiFPdvvbXZ62GUH17/Sp2WYKQU72UkcR6uNnphQSslx/q/qNjOKe4xEVTI4G?=
 =?us-ascii?Q?PElwEtE7WEdmxuN4YVcFBQEkQrrh45LQ6RaEANM2z8P2s8j10EDe30EQLl+Q?=
 =?us-ascii?Q?8jYDcjXkSK1uBkGZ+816fBkg6I9LntxVpQl7kH5IXSPzF0WaLHjx1l4ad/V6?=
 =?us-ascii?Q?uP5jtgqIWL08QOdv4n4DyrQWgyWmk2Hx5ptIrLxLRzk0OsOMTQdS0sSZgj+0?=
 =?us-ascii?Q?s/eUIjH7KPcV1L0cUdAAWQJbvs1BtEuPiVn99P2ICIcjeTGUEYz4vZHf0GuZ?=
 =?us-ascii?Q?0Qg8/BtYtqjTsXjPRe2GHjFB2wgFO+TSCSoSQ6LgFhWZKSjdC8qzEBZl97Mo?=
 =?us-ascii?Q?Lbwpw0DB/Dn99tIqd832yOhqmeF2gOLb/7NIQaj582RXau10OIXNsRHwtw0N?=
 =?us-ascii?Q?x9UPX+J3WxOvHsDNgFfQhPxwHvtMRDp2hO+RQRwPG8xK57T4c8pdSByzBo8Z?=
 =?us-ascii?Q?ggPfxRZvK08c7GoO6vJLP9tsiTB9cLcOIoK7Sd00zoC3Y415YXhGfBh4G09C?=
 =?us-ascii?Q?s9FLxX6QB2a2oj6jwfNPjui0S0GBTAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R/hvUsaqyDW7PLGERhMoj1/aZJTQar+3HW6+08tHDm1HCsZTnMReIVBGfSR9F00hkKXPO/wDknqGsYSJ336t3c59affS0F1Y+2KdWHtCxW7Qb9QrfcIeYeCPByHlHAKCtXLilWxIebm4S0LLFSArNRerBlXrnehZ5RQmHv8mmZPFJzv6oiW23SPnCpGtbsgmdxrFOufzGGrsWaq5RZYHLJ1hxGpt6O5VKAyEeUUYOQSTrA6vfsnU5wRtxguOxZDSi4JXQn/JkRUkIf/D3uoyk5KNOS92e4EpaZVRJbtJw5J9o1yZ0XNzd3R8LRvMBZFQjU3ijnuHeTHNLT9KXkgoCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edd1f45-b916-4746-b01d-08de84d567f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 10:02:04.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joxLD/jdVOwro7UHBdhdFsbx4sIE4hEOnyiUz6hT5cbG0VOE0w4syKrvojmmlFTOmeoLomchZfUoVDNIy44J4cZHK1xRiWZXVjRpo7k7fho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268952-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0A3C72B99CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Wednesday, March 18, 2026 10:07 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next 7/8] ice: add Tx reference
> clock index handling to AN restart command
>=20
> Extend the Restart Auto-Negotiation (AN) AdminQ command with a new
> parameter allowing software to specify the Tx reference clock index to
> be used during link restart.
>=20
> This patch:
>  - adds REFCLK field definitions to ice_aqc_restart_an
>  - updates ice_aq_set_link_restart_an() to take a new refclk parameter
>    and properly encode it into the command
>  - keeps legacy behavior by passing REFCLK_NOCHANGE where appropriate
>=20
> This prepares the driver for configurations requiring dynamic
> selection of the Tx reference clock as part of the AN flow.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 ++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 5 ++++-
>  drivers/net/ethernet/intel/ice/ice_common.h     | 2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c        | 3 ++-
>  4 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 859e9c66f3e7..a24a0613d887 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1169,6 +1169,8 @@ struct ice_aqc_restart_an {
>  	u8 cmd_flags;
>  #define ICE_AQC_RESTART_AN_LINK_RESTART	BIT(1)
>  #define ICE_AQC_RESTART_AN_LINK_ENABLE	BIT(2)
> +#define ICE_AQC_RESTART_AN_REFCLK_M	GENMASK(4, 3)
> +#define ICE_AQC_RESTART_AN_REFCLK_NOCHANGE 0
>  	u8 reserved2[13];
>  };
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index ce11fea122d0..de88aec9137c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -4126,12 +4126,13 @@ int ice_get_link_status(struct ice_port_info
> *pi, bool *link_up)
>   * @pi: pointer to the port information structure
>   * @ena_link: if true: enable link, if false: disable link
>   * @cd: pointer to command details structure or NULL
> + * @refclk: the new TX reference clock, 0 if no change
>   *
>   * Sets up the link and restarts the Auto-Negotiation over the link.
>   */
>  int
>  ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
> -			   struct ice_sq_cd *cd)
> +			   struct ice_sq_cd *cd,  u8 refclk)
>  {
>  	struct ice_aqc_restart_an *cmd;
>  	struct libie_aq_desc desc;
> @@ -4147,6 +4148,8 @@ ice_aq_set_link_restart_an(struct ice_port_info
> *pi, bool ena_link,
>  	else
>  		cmd->cmd_flags &=3D ~ICE_AQC_RESTART_AN_LINK_ENABLE;
>=20
> +	cmd->cmd_flags |=3D FIELD_PREP(ICE_AQC_RESTART_AN_REFCLK_M,
> refclk);
> +
>  	return ice_aq_send_cmd(pi->hw, &desc, NULL, 0, cd);  }
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h
> b/drivers/net/ethernet/intel/ice/ice_common.h
> index e700ac0dc347..9f5344212195 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -215,7 +215,7 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct
> ice_aqc_set_phy_cfg_data *cfg,
>  		enum ice_fec_mode fec);
>  int
>  ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
> -			   struct ice_sq_cd *cd);
> +			   struct ice_sq_cd *cd, u8 refclk);
>  int
>  ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, struct
> ice_sq_cd *cd);  int diff --git
> a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 689c6025ea82..c2c7f186bcc7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3769,7 +3769,8 @@ int ice_set_link(struct ice_vsi *vsi, bool ena)
>  	if (vsi->type !=3D ICE_VSI_PF)
>  		return -EINVAL;
>=20
> -	status =3D ice_aq_set_link_restart_an(pi, ena, NULL);
> +	status =3D ice_aq_set_link_restart_an(pi, ena, NULL,
> +
> ICE_AQC_RESTART_AN_REFCLK_NOCHANGE);
>=20
>  	/* if link is owned by manageability, FW will return
> LIBIE_AQ_RC_EMODE.
>  	 * this is not a fatal error, so print a warning message and
> return
> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


