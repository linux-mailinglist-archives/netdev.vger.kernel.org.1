Return-Path: <netdev+bounces-284273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F1QBX6x+Wld/AIAu9opvQ
	(envelope-from <netdev+bounces-284273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:59:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD44C906A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75F04300A318
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F23A5E92;
	Tue,  5 May 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PY5lqTci"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025739DBC4;
	Tue,  5 May 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971576; cv=fail; b=L0i118hIw7h2yDHiompx1yqJrE9aeraYxUg8wGOj0YQqTarVo149qaqblaReFEH8DSW+hUYP8X0hTVia8fULI7A97wGV3OGCqfniUFQJhS9Fvd0nMug0pj6GSy1H6ojFoGQOOGeCdWrRXLd3h5QFoIDoOBEfHIQJt/h4zPA84BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971576; c=relaxed/simple;
	bh=WlBCqvmUw00y+PrzKwbcYEztTgScHoS92rM/TmfF7Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUnw0EQfK8G8tiTkPgwNbYEotPHrTbyduktRMqUu6xY+w6t+IpvQJ4nZPato9a+3KIGYGtrd1G69NQqTNYdQwjAG+17bjqs02uht3X9SR6lLvgtmKT5H3Peg50NFhy/hbgNDR0nVlJTlBV9RrwWloNqj6WvlxmL2nCfQ8UcYPLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PY5lqTci; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777971576; x=1809507576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WlBCqvmUw00y+PrzKwbcYEztTgScHoS92rM/TmfF7Co=;
  b=PY5lqTcitGiIg66YqGusrpoGWgXlFcekCK6s2OiOB5DfPcXjI0HOFNhF
   3CjLYYCia++rViu127OcbYawodi2R4RxcResGQ14VRWWMpZDvdGie7cRu
   CVNPbkq3dxDx0y9qW78OiJIuU1UaF9Eu07mLuhcyYtRHXe4A3BwV1dZMB
   wztvdsjZYuzsuILnfFCTki2X8XapdL4ngZHAtknlflrmTC96UprpNyYE6
   eVahk0Z5o3DfQx0990yNF9z14yv/WPH0V9xkxyn72IJVvVo43ewEKlUjE
   QwiooW8i5pfyueNDJzCRz7KhxHppjvKyIyDup0AlkOvvEzx3LnX/oorOq
   g==;
X-CSE-ConnectionGUID: 5ICVO5TwSvORZsetCFP9ig==
X-CSE-MsgGUID: MR3be/1QQcOQCM8VH9GIPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78827900"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78827900"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:59:35 -0700
X-CSE-ConnectionGUID: MVkJL7btR+KOl9svnjdkjw==
X-CSE-MsgGUID: MoxVAP7fRCylAYx6IbRyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="236010355"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:59:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 01:59:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 01:59:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 01:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyI9WFldnOt4HtsTMZmBX1uv04ZMtGDIHIX8cmby5DLaKQMiuIHEWSI/wij0HokdGoTrC4SI+CCv10lgJsX0bKL3u5solb4W3NW6eT7/5dBTQ0WWXPObZADQKl7Gci6TVBZIowmBH34Qi5pug8Fg5k1APxJWwpufoF9KHY+w2ALUYCBQtQQt7zf+TlGzpl7Z70LcrznfOJ71lpc17lxERYGl+mDFXlMz43R7GvIy9KaU089CioFtA6dK1PaTTjerjGzARu2m9hLb9qGB/dmoezNmEJgIq2n04LI1rTsww3KvGAlnZVJ836K4vbbbUUk6KEAnQu+S54pYo+o+TYuE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlBCqvmUw00y+PrzKwbcYEztTgScHoS92rM/TmfF7Co=;
 b=QCkmjGyGvL81ArDxzKP4RURF7rIe6O05s7qZSXeNm+U3WapeRpAtMOknsOxxRdppha2zcdT4NsEkesFnpyYIRwqsf6QUyxtA89hU9NNNgbGBl15OYGC4FyXv6CMhMdYA5rPgy1ASIUlKJtSErv/Jiysflxvy20LH0FIcVP/7FPho9nyhqY7N9m0njjvLkq4hIqxDEvWrKpoGVNKlGOsZ80iFqd5JYo9rN6NpdGBH7OnhjVHgEVIR1+xnjT+XtoUMlw2JQ7c9nfmfilApmcRKC39OI3AQymnRlYmo9ya8aaugRgI/Wu9EYzxgQqCDkBymb6j00d7dQjXlSNX8gCwN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Tue, 5 May
 2026 08:59:28 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:59:28 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "Jiri
 Pirko" <jiri@nvidia.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH v7 net-next 2/8] dpll: allow registering FW-identified pin
 with a different DPLL
Thread-Topic: [PATCH v7 net-next 2/8] dpll: allow registering FW-identified
 pin with a different DPLL
Thread-Index: AQHc2IZMIwdV95zAPkGtI8wojrwNebX7AMmAgAQoicA=
Date: Tue, 5 May 2026 08:59:28 +0000
Message-ID: <IA1PR11MB6219071C2FB56C76584316CF923E2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
	<20260430094238.987976-3-grzegorz.nitka@intel.com>
 <20260502102715.2ac364c8@kernel.org>
In-Reply-To: <20260502102715.2ac364c8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SA3PR11MB7582:EE_
x-ms-office365-filtering-correlation-id: 1246fea7-54ca-4cea-1b28-08deaa849d14
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Nsslpct2+8b8P9/GRRl/9zhFyLJzf/qOOcHdhM/ohvZJvRAOL1TVrpEC0plvjgHzcHvtaAIUGMa75+vVlrlci3bPhNmuIp75dacCdxQanJVciiaYsZucY9dm7+jj803NiY0Z6PEC/Vvhsh6lLGttSazKejndJUmqU4GUdvfyqD40fdPuHApx0sutW7D1E6mIcjFSHxHCqeeJT99Zhc0pHNNvWVXVxj1azSJpY8T5CwMzdDHLbvHLNaKu7t9pXktiTRLloWwEPEwzg/1j8g/zfU49XHE1y5RIridMHifwzOfkQrhbuBRuZQMV/3mqkQYY/H+u6kxo3HPNB3/EvdTrX6PhIDAg5Q/OkkW2gL9132iWIoGarvItfrFfoBHqLXK/O6CZ1I807Fw/P2MHEJ0FJ8kNMU0p1f46ri1aixJxWmmuYofEm0qhPnK7T5xleB6W3zn2oBPFJ/WOEn5ox0UuEQB7icMv4RKNVHP57a1ywvy7C2xUTRBil7IynRA/M/MGiictoILDs0jxEiG8iOAP8V1V3eCgGVU2FwVU+9Oo4THlgP3vuxoffckpaZCgMWcrgM0Ap8VHmQYKYIFcmjsK9F1DA3lPIf4U6pUwH+WI0YIllAgStpTKFXAmpUcrqE6FQ4dFNrH+4U84LqyNEApcB29nNmG1bt4sTpo5UK1LOsb9pF5i9B+upofVMiuf7n4+bPYuoTYjcBCP/COFwr4l4fhXgjAnGF/TxoMHWxIBA2+Rntk74CvGOcqf/VWIiC/H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2MJeHuWOC2ZBFwJJpClfXikNfuuqPlSHDzGqulQT9xtRzOk8XXiFx1QNScVV?=
 =?us-ascii?Q?brg3jPD90Xcm/3fyGaRADJjUOANN0ysQwOO5RA0qCf9CvTNGi5RwvgHMypOH?=
 =?us-ascii?Q?rdoJ8LqaVcV6rOIO3dX6GD/DSM5uUMp0ORkziVr4Y9vKoqPs8LbBh3ePce7y?=
 =?us-ascii?Q?OMsDFvJAv1TYk8SRE/+l/CKHV3JU2yyZ3eEuFec8+RjzKTpB6Z8e8hLS3irq?=
 =?us-ascii?Q?DTzgzMfUP5TouxHDFJ7jiDijW+4g43Z0Kub1Cmi2J+XKMDoMqrEEwa2CiyA+?=
 =?us-ascii?Q?SE8no9WhKRJAesRsjEh1GSlvydZeuhuTwJwyE9lrP1414zmRo6ik8sxrbBRB?=
 =?us-ascii?Q?9iD2B//0BldgPDAD53+yepg2nNRLgV5Fdn92VKV7+hFYVBZnBcwRqstkX6/l?=
 =?us-ascii?Q?uuKZCOfNE+ilyFcLIeh8IenKLbmfdUAGq8saIpUu+2a8tmMCkJq3wqqchJPv?=
 =?us-ascii?Q?3emcLv11u0Zy766jBYSrBKosg+aNAiFESBf+/2u8EkJbVekesUjrdXWAd6kN?=
 =?us-ascii?Q?S714OO2xDdl8FZIIXLQ+5uhfNkL9WTGJarxDRC+UcMuhrv1j1TSeNSw/CtYV?=
 =?us-ascii?Q?UFaK9VSUSJYMCySNDM0++aHhfCc5O3oufMN4FOp9HQ7ExUcu2Ubu5Y7ZIZEs?=
 =?us-ascii?Q?9XZdiME7BhP5ELoott1dW3r1hcmsMaLKpgiocU1iLgK3/qjldkjXPb9CsmWe?=
 =?us-ascii?Q?HhE6vaMMnOrAEry5Ar1WdR94OU7HIc0HtBDsd5SpqRn58vkKqU3JTmdA7XSl?=
 =?us-ascii?Q?2c/RotIa0BxdGf14U2gz97K9OIEDRECDiMk631gi1bRwjXgUlssA8BnraGbf?=
 =?us-ascii?Q?DI+r66490C09uBKQPyExACtTOinTBa9od5wJkydtC4+UolJnxY8M9W/uevVz?=
 =?us-ascii?Q?nQHRHlBpmFRQTFTlYdpmMrnZFzjwNGduixdK7gGshP/IQrLATt17o8zCG7XR?=
 =?us-ascii?Q?H7Sdl853g4T8Ni4qf4oo2vMH7c8akqc8/cXEAjIxvyBEYuutt0vSmpsJEqMN?=
 =?us-ascii?Q?VICAAmSoIzQgoKCCWFMsqRwbwE2yoJINJom91TA1EMkHABHJSbxIV2pBI2qo?=
 =?us-ascii?Q?xugL54VvBavthyYHeFKyrP3WHvIyQjb1/pbN9Y41ayxp4rpzf193v2PeKyaa?=
 =?us-ascii?Q?4GuPcyTz2K57/uqMJbwyuxyyfWatC6Bz9RCuJgmcwz0XOjLM5U0QsuOgkOV6?=
 =?us-ascii?Q?Ofl92+uOwnvd5+EyGaT6nDJPhMXAUXvL9ZzDTJsBgn1lLEfEoc3EQpF0UWUr?=
 =?us-ascii?Q?RuQiKO3gxPUusBxg0rrrG0nhwIRGZeVPu/5AJ57Mw2Z7S6Jbmhos7DMlQSxh?=
 =?us-ascii?Q?gpycFLabX7uwgPnZ3pEMsJLXDNT2vfq3jRtXSNxvvjQ5K/SUL/kZ18u2JdYP?=
 =?us-ascii?Q?ljoJx2d6R+gmnRF5qqwcNkvJ93jn1i1/H1KmPX1zg6ujbVDQ+OydC6jbYImB?=
 =?us-ascii?Q?JTydiUqIFgV7OIFNqdiZDFWPMrBTM4nioV+Eh+I4bWOzQ/i6kCDqpZxoN1Mh?=
 =?us-ascii?Q?75x/wjRkBeojwUFA1hcuGvJYnftxRt93nSRjg+ZTUm4Jzu+BcD230ccgig86?=
 =?us-ascii?Q?vy146L4h5nJ9HvdgOfvuJMFiZvVeeVRS6EwM1YUbdW/SEA4QCOtd2utAqb1p?=
 =?us-ascii?Q?nkrSXAAeP0njs3K5vgMzZ4lZWAwozkZ8CFT+Fpv/TAkhjDd65viVXkI/8K8Q?=
 =?us-ascii?Q?NCoMRDnSOV1F5I+lLrz5WSh2FyJinYDwstectW2z5NF6rOkpgf9yAdTMk5sX?=
 =?us-ascii?Q?jXGWH6zzBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p8ux6Q2cSXIqUXqiJnqd8QMLkQx0/B258gidMfSK61vFiQCXvKHZiPQIm9T7fPJO24T0ieQ8D8beTCA8pV3JetdYSddCNu95VEJ8fxsyUv0rx16WRpwDyihNy1VZJ+WLhjx/HbPweEb8/ZKC2mJDUXt2Ohvtmtt4yL3im3ezI7Y0pFNIuwTNXVn1AxE0nIJdHbgo/dsML4BBP685O2tXTFM5O/4489syDnI6KhH3vQQuAtTYIYM3V3ygHSqZVgLSMQmqxfxSi+E7hBR3zWufUlFcaC7fKyR9+HpG5F1TA2icY5JeUUSLWYp/q1ndjNlbagbGFTFdocDUUfureJBfsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246fea7-54ca-4cea-1b28-08deaa849d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:59:28.0871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwQBNrfqHvl+nuUJBDDcdpzXdLeqTy66T61tiFI/Uyn+TTcZquKMyJlOysEVvmnTshZwJR/3IM81U60qp/MrRcjJemc12AvFknEqNOkYo8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AADD44C906A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-284273-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, May 2, 2026 7:27 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; edumazet@google.com; Jiri Pirko <jiri@nvidia.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: Re: [PATCH v7 net-next 2/8] dpll: allow registering FW-identifie=
d pin
> with a different DPLL
>=20
> On Thu, 30 Apr 2026 11:42:32 +0200 Grzegorz Nitka wrote:
> > Relax the (module, clock_id) equality requirement when registering a
> > pin identified by firmware (pin->fwnode). Some platforms associate a
> > FW-described pin with a DPLL instance that differs from the pin's
> > (module, clock_id) tuple. For such pins, permit registration without
> > requiring the strict match. Non-FW pins still require equality.
>=20
> AI asks what prevents the modules from disappearing:
>=20
> Does this relaxed check expose pin->module to a use-after-free during
> netlink queries?
> If module A registers a firmware-described pin allocated by module B,
> they will have different module pointers.
> Because fwnode_dpll_pin_find() increases the pin's refcount but does
> not take a reference to module B via try_module_get(), it appears module =
B
> could be unloaded while module A still holds an active reference to the p=
in.
> When module B unloads, its struct module memory is freed, leaving
> pin->module as a dangling pointer.
> A subsequent user-space Netlink query using DPLL_CMD_PIN_GET iterates
> over
> the registered pins and calls nla_put_string() with module_name(pin-
> >module),
> which would dereference the freed module memory.

This AI review comment is a valid concern.
I'm going, of course, to address it in the next iteration.

Thanks

Grzegorz

