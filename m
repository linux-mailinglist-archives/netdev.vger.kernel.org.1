Return-Path: <netdev+bounces-273989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPXaCwfczGmQXAYAu9opvQ
	(envelope-from <netdev+bounces-273989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:49:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C764537712B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D7DA3004DFC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C83AA19D;
	Wed,  1 Apr 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvxoOrtQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C51396D2B;
	Wed,  1 Apr 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033348; cv=fail; b=s675TuI0EaCqr9wMp10oNMt2oXkyBCecljv8clntOGa0XnYugl107uI75ILFtfl9z77UnB5oQdPDwTk2BUWZhsQsZEaPgUJv1bQWZ0q9mZ23/GWmHUGI90bkoU9+3zbrFZOIcgiQdJsx02Cf8LciLrXAyYqxVpVGbOZddHbdZfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033348; c=relaxed/simple;
	bh=IHMNKRfDcXZtkf/9nyT+Jr33UmONLlGHYvNMda2S8Bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDDntGHXcjW740JUjqCjuE+HbvlvVOtPS35o1G5KJsF0aEIPTagjHED9ESPlHJAjpHdYG4EdakHDpJyFyA37ritZH4Fq8+aF7ZJTtRtEauefu8MDMScQ04dOBoC3CS5G3LAW2teSBcvaYUh8ehgzWfY6c0NDCXwZ2X41bf6EvS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvxoOrtQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775033346; x=1806569346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IHMNKRfDcXZtkf/9nyT+Jr33UmONLlGHYvNMda2S8Bo=;
  b=fvxoOrtQ9NSh7SG15yIs97wLrOTLuyaepwrt/pnFcFC9b11l8wuE+Dxv
   vAcU0ycFJDanmJdOKzYEEEzb+XPotj9JwtRy/dIPwdSNZIUq9mz7KgMBE
   MpDA2Grl5ZkssFNHVLpF86Khiax9JAVa+bKTsLblTyhD0Pf1A4wWR4Qxy
   54/MVD52A5V/T6ssfxqXn8FQZVWPA5EmhpP5EK9AIVUvuWZvOzA+yBAzs
   ZshbNRxIVqZE/mZ5wXiAlddrMVDjo9BqvpoJmNPRkuQxuTaboeGXVi2y6
   6VcMwRvvTwUIObFQU8uWYwkNSGDTuaC6ZTyrHSPgYlv7lSp4oh7ZZj5PJ
   g==;
X-CSE-ConnectionGUID: G6G3y6HHRhC/vraO69+VuQ==
X-CSE-MsgGUID: b89DLb3lT+uJ1G83NY5gSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75957889"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75957889"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:49:05 -0700
X-CSE-ConnectionGUID: pJX1vNTpSJC2UVqQ1cmYGQ==
X-CSE-MsgGUID: 45pX4oyzTieSGuaYH+JMBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221762860"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:49:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:49:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 01:49:04 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGjJSZdcDy9jqTEohH1bI8ig2kqcreYt+CZtTxWSedrntbUeIx+mGpPwwdwSvjiNhxytcKn4V+m42DKmWI0ZYnoybobnWYYkAwvbKc8HY/A9RzdIayRTtYOhsosWJ/Xff/1sfIR9fzmJBjm+2bMTHyw2DYS7EF+D6YE/n5OgBAOuasDRXY64OGMI8vtoK/OCeY4ODxZUeF9oFte15suSksmowAfgPjXu+JUX+eJ6L9pSNmWEh0BQB32atNBlA1xTU9DC40G11WgY4+QjXvjuHwS74168wjFbdRkVB6CrgxW81nNNdvF4z5yFHtnGRn1kf5h5ubj/NoRIEMnp+rDFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amiOCIM9pJvLzTiijLYmPMV0GDD5qK4T6a+pHlk05qI=;
 b=I31QDE4cH79xfneqkZhWLJkxRbv4RdzcTAtuKhbHJVieHxRBUf9tmBEXpeZMaBuRnxZSaIEXyXIfSHAp1GN+tYoKB8YsAAanS2lHR4ijxHopb+kleG4+ODvKYA8mS98hiMp8O4qAJVysuqKtVsHZMdZjkEr9vIcRaO/vFFNv/uZxo+Uj6vfD9sYN23qTC/wwyRMGnhQInj7xhVlgUJ5Vth+Dy+AcS+lWK40eK1wl6yWgZ/hdM6KHmlWa0MB+bnqPxh02XGpS2T45X5Ykwut1fPpEDP9Ffx0y3eTAza+vm60+rGxKSlOJ/QMZrQDgZ38R9lyEXoqhsk0KBo9VZ502ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 08:48:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Wed, 1 Apr 2026
 08:48:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matteo Croce <technoboy85@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic XDP
 support
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic XDP
 support
Thread-Index: AQHcuvL2ls/Zpu65nU2IEljeWVhcO7XJ8hGQ
Date: Wed, 1 Apr 2026 08:48:55 +0000
Message-ID: <IA3PR11MB898682FCECE3DC4FD301A922E550A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323182823.5813-1-teknoraver@meta.com>
 <20260323182823.5813-2-teknoraver@meta.com>
In-Reply-To: <20260323182823.5813-2-teknoraver@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4683:EE_
x-ms-office365-filtering-correlation-id: 3a55f9fe-85da-463d-28f5-08de8fcb8225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: R7b0sLEKpXoKj+EkIV6zo9pfNnESHGlYCf+jH4K7PAsN/7KTgIwBhnSUrNLuKJpJCIC+NxqRWqQkyeoEdUPapJMSA3FxEsbxPolaHe3UnvgpzRPK9STyziZ7fL8DWYYLRFXnU6McvpXq+qX/lzY0VhXE8u5vNrWeTDKr5ktf0oINwYb+aPfkqksJ9z/LWDvBIp8XwuXJ6WgMCEleYll2U8rYFUojUVYAs1W2TCB6tWF1RNKiir5lHlYTfsHZHd6e2zRtNRxBmSUe2v+TR9P+Y3tvD8+6r0ZMwIy+JZGD2cMQTSsYdRSESN7RlaQesEkC26ymrOADAKIuFGf/fabb9l/OFFPiaQNZD37JchAD27xSI3WaHluV8d3rrn8xahg/4dHVgy5YxtceeJWCwxfwjvsDjnxQPqKRXYi2pGiWukFgwGqj6eTvRSy59kGM5ypVbSfJqSecEGZWVzcG8csAzYu+sdnjEbjNrkFF6O82Kn391COWkprnlQn5uJL3rWMv6y8nRcBeKZLteo896DUPHCeV29lVY+/eLlmiaIE6+QwFcRjwr3J8cYSLl47q3GZMEpOxkqxLdj2RJydkNcoeXhZnbq3jc9ObkvxLuy0ItQm69cRrlTf5p49ljN0llloVbZqizWcLAeL2ncCS9nHlJWJW0jdyyXOVLkKS7ShC/ZmNCb1QzuYYEUUZO3gGXqN3DyXowr2vaoSkMAzpKKWVpRCbztyOaQWM9WuY9mOFwtwy8izW8oOYMVBwfCVX66WbtKp1VJuGcOxDH2mLGnrH4gsauCmU4Uy2RCG8pz4TbJcGsz+93IeuEDGqCcf4y8g2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nA9StDbxyAAotTfN3TWak4x7dErod0JpYZNI+C2M6EuBEw2GfnSyveI4QdPi?=
 =?us-ascii?Q?kkAy6oP1+76D5Szfu6kE4McbmizTQJppHnCk0OMxLO76tsDXRnhBdH0spVbi?=
 =?us-ascii?Q?ZQbf4WvSggew2naO7hr4yVG8sPCAZrHC2jzus+Urw3VgVa3DZvj1V+lJdQOd?=
 =?us-ascii?Q?/4AFxQLQ45bjxlf6bErU3TqB5/XloRq7YIhmO8UMRJA88YWPP/0AeiGP1PeV?=
 =?us-ascii?Q?212JpZaALGc5d4p6rhoBu1C+ZCDGzeDUQA2Y55EX81SkkUc+VpSs0irGBqd2?=
 =?us-ascii?Q?AVxgP3u+yaRxNWXWyACnjs9sqWQN3mNWWgxy/t+ZJpTYiE2Z2o/of197swb7?=
 =?us-ascii?Q?pi6x9HZ0NGLjtZ3iNdCWWtaxcAvG2WhtmYmZ6i1BeP3utnRowyByY9HqqFzt?=
 =?us-ascii?Q?DThDFaxCANctIj2ciZJws4BdPUA8y7bdeHnRt7H46DOR4pD9Fuh2SHBg/b94?=
 =?us-ascii?Q?oZZpF4QWmUSyVEZS5o4bYxj6tf/78bPjnDwkdGj5BqWEECFGrJhKAWUIhscR?=
 =?us-ascii?Q?5YMTTRAxu+CSgRj+mRDG6UTrg75tRyUPFe4BwQvlsdaBVlgTuFOqdltfj0os?=
 =?us-ascii?Q?Nl7krUt3YT8AHnmzPYQlUfX43qm1S9KIR1duzhCYwh/fdP0b+f1GM5DI7hxk?=
 =?us-ascii?Q?EY7EgMR2UcI0Hnz8oSlIwNBAb7D0f3/DIu2j/x7115TKmaPdg+BrOfbI4Fal?=
 =?us-ascii?Q?Lrc1YAHYEtmYCE5bGWxtvwg1RcT6xmk4uFC4XHVbQaFE/2tHeq1ZFwhntxNY?=
 =?us-ascii?Q?6eFlIjTbBKdx6F/Ve7EsLI/zcapuHDezMFGxlPFHR3vjgCKTFtDJ5Lcopk+a?=
 =?us-ascii?Q?nMEyYTfZIMS2w/2vVkLFS5IuvFjtbFg/sRXiM0zUJwmgDoOO5bW/Nt79XPTx?=
 =?us-ascii?Q?fOX1rhF4LELyxPcDs2ckpncRSm049xE+c9FFGjLrEj4ksif87U9+IUYGaYIa?=
 =?us-ascii?Q?OEocUZRLmjnuGJphUS+7q8rBwYHjhY/k+vpZaneXPxth6vrTPPIdYrIr/TL6?=
 =?us-ascii?Q?U8VWYnepdl4rZe9XGlLJLBdGQk/yftzRysc4yaRGVCBYNd+yJGSPOC+O24jt?=
 =?us-ascii?Q?JD+wWuH91VlVEocUXXC3tr9QaSLxy//HIwNd7DlSUdWE+4glbNLTg9sCye/+?=
 =?us-ascii?Q?tBO4XoWWxW3EBFs/dW2sAy7LbAqdL12h+C6p2vmrKkl1Hf94BfOu/SpEPjeZ?=
 =?us-ascii?Q?5BZheI8WH9XxVNnHBMOgaUFEaIZ2tmrI/fs9xKkqs7luTs7hUVoj+SY4CIL8?=
 =?us-ascii?Q?Zv5TcXQV47UjqRsR3J6bMNvZpiJ55qAXK1QJsjKXANH6GindO0XPzBXkiiJ5?=
 =?us-ascii?Q?tzrPaS39PQ2LRcmDUo5rV+X/gfA7Qe81NCZIeRWM9GHMVKZuQR7xg4GrPV7K?=
 =?us-ascii?Q?9s1cBPieJBVLm+NLL1CzUHbO6cek3UJmI50QN1vkj39npGBI9A/6rXnMPE1J?=
 =?us-ascii?Q?25qgaNbNDTwBBne97Gj4APcLDdlbhO0vQxHWcmS1HRvbFMQ6LLcZG0xNKLBy?=
 =?us-ascii?Q?eKrf7kkzXN8r38c34VKAkTPs5n4exFZoCvy9zLDvtiYMJ0eF+LVBBMIpSoWa?=
 =?us-ascii?Q?ylYGsoLwRSPtK3gTzvuO3yuueToSugejaXW2ZJzpv/cm4mpmMZvV65LwS9qX?=
 =?us-ascii?Q?mnnywbi1kkbqhxuz//HelBmhF9Agr2UckIERYv79k/t9tVQJlIXEUBYSTk/Y?=
 =?us-ascii?Q?OGTOPPXj2tGsZduD1Ij8fwLEhJniE4/SBQg2KQbkaZLINMj8Rl9z7s933iiZ?=
 =?us-ascii?Q?yYeRpIFZnO2vzmVAuUix05XThm0o1+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uv8mN8Gf0BKlYU1Pc56hXaVeB0IP7qFjxsMxpQ2GPIlVOUOl4U1IcMs++eHk5C3cImYS7ZaBURMzrfb/TrPhIVFxGp3QrhQA4LQ9/eaEij1lhNTWc8AL84liWumaslEpOisFE4Crw5EV/ZgtR54tcOS0UVfrtMDbXvw7CXo7iJ2rKFIfYCRX8u/x++ZEPufNgGq2IHMQxi3azvtpWFIfuAX1ooDc6V5+Z4XuNlgF0bqSeOXqYFbRIBBfnZqqmppnWbgTMNQ0p2gOnkwjxVHCMYcu8hIHE7QG8qePw9TiTkPw1lsTV93o6AP3NRpnNpv/f5SE0kEw4oQGGG1zpQW6FQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a55f9fe-85da-463d-28f5-08de8fcb8225
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 08:48:55.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvUIoUBzTAFJdWEqGNheLc4KAzIZruNeFRd2JS33NtFoJzD1f12Kylimntg+V0VTLAr4Ttvz4yWSjgKCJ+IQE2pYBUehgissn/GM4OLRSck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273989-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davemloft.net:email];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C764537712B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matteo Croce
> Sent: Monday, March 23, 2026 7:28 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> Bashir <mohsin.bashr@gmail.com>
> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic
> XDP support
>=20
> Add XDP support to the e1000e driver covering the actions defined by
> NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.
>=20
> Infrastructure:

...

> +/**
> + * e1000_xdp_setup - add/remove an XDP program
> + * @netdev: network interface device structure
> + * @bpf: XDP program setup structure
> + **/
> +static int e1000_xdp_setup(struct net_device *netdev, struct
> netdev_bpf
> +*bpf) {
> +	struct e1000_adapter *adapter =3D netdev_priv(netdev);
> +	struct bpf_prog *prog =3D bpf->prog, *old_prog;
> +	bool running =3D netif_running(netdev);
> +	bool need_reset;
> +
> +	/* XDP is incompatible with jumbo frames */
> +	if (prog && netdev->mtu > ETH_DATA_LEN) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "XDP is not supported with jumbo
> frames");
> +		return -EINVAL;
> +	}
> +
> +	/* Validate frame fits in a single page with XDP headroom */
> +	if (prog && netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN +
> +	    XDP_PACKET_HEADROOM > PAGE_SIZE) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "Frame size too large for XDP");
> +		return -EINVAL;
> +	}
> +
> +	old_prog =3D xchg(&adapter->xdp_prog, prog);
> +	need_reset =3D (!!prog !=3D !!old_prog);
> +
> +	/* Transition between XDP and non-XDP requires ring
> reconfiguration */
> +	if (need_reset && running)
> +		e1000e_close(netdev);
> +
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	if (!need_reset)
> +		return 0;
> +
> +	if (running) {
> +		int err =3D e1000e_open(netdev);
> +
> +		if (err) {
> +			/* Remove the XDP program since interface is down
> */
> +			xchg(&adapter->xdp_prog, NULL);
> +			if (prog)
> +				bpf_prog_put(prog);
I'm afraid the reference is owned by the BPF infrastructure, and you will d=
rop refcount to 0.

> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}

...

>  	kfree(adapter->tx_ring);
>  	kfree(adapter->rx_ring);
>=20
> --
> 2.53.0


