Return-Path: <netdev+bounces-278426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLO8FCYp3mmSoQkAu9opvQ
	(envelope-from <netdev+bounces-278426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:46:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32A3F990A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64551301061F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23E3E2747;
	Tue, 14 Apr 2026 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO24tvhD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB73E1217
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167204; cv=fail; b=UnCHHhzlmVaA9rKYSfsAqCJZ1qj3VvVQsdOII0rOCXifn2FqnKdtJxTsYxQFlOmW8k5JcrYEj4+h9iGA4EgK0LDYtOfW0OQ5ZOU1F1YCnjBqN5mpHA4DwHawwe7LpygL22Tj1VWca1jRmYuMkfpkQqCQ8ICeLIWPUDhZnPoR6j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167204; c=relaxed/simple;
	bh=JT33SW75v7tkdEOU6HRmnmMsIBpIyb9sz1tOdfc+2+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aq6QSIy1dJskXJgnKm9DUY10YYHvir6x3Dq9Buo0dDZ5OwWMCHsKn91sA5zPLdfg7sG8/zvDMHZ31uD8hnupPpfQ/taYpVbhTD+EmsfuPmtgk1wxO3m2Vk19f82gfkpprmfWKHbWRTmkN5jOycEUqjpsJQXt4ZAE5s1/niLcLu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO24tvhD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776167200; x=1807703200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JT33SW75v7tkdEOU6HRmnmMsIBpIyb9sz1tOdfc+2+k=;
  b=gO24tvhDjqqq4WptzzSlWgL1faNYBJAO8WgZUgOqlm8XZCrOVH9UNo0e
   LrFu+p7SAxpu14PV9iU2KseGA2P9gSjQ8t6pNqjHufeg3UzmXtJsbaCmp
   MeUtgEBWengKwUmSvKGBYYrY0x97UXPcUPZomPKdZi2tnICttwAQSGpSa
   vTISaNq+UZXjOpupdZRXgJhEyfg7V9Ej46tX7GcbsY4obVlJqgEWkv6P+
   fBE/BxdFnIApFSPpLaLh5NRf9MY0YKuDfmVprDHqkO+vGw0uhwwTPxVRu
   GbBLKAk5JsIXfMnaYdinEmruOYO3JwMBusJiB/kJ3ZifbwDBhxTvOzueN
   g==;
X-CSE-ConnectionGUID: cMQLDn9/SNytB3D2hMo26g==
X-CSE-MsgGUID: qPphVKN1SWqCyFV/s3uerg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="99765496"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99765496"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:46:39 -0700
X-CSE-ConnectionGUID: AgGJ+7QfRPqcZPRj2suKDQ==
X-CSE-MsgGUID: j/d8ihy6TWy1BJh4opIpLg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:46:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:46:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:46:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqiDacssz9HKS8wqsiqGaGnQvER+br+2m0RsiEnlRdi96WQL6DpLUUafecgz+lazqLMFHYWC+qM80us8EUE1AU1yQOg8lV4wfrX8r9/O0xCJStiRvPoEuUWNfHBZ+YZOBKiEr26AYgsLR3R5v6s7tpHHWLGc0iVIm4rdWviLj8GpaQOyt9GTCueGs6tZsrErSn4cDXdzkxJRM3sBY/UJbHdibJubK1Y/c7FQHAUcTsb/hbUBVMpwhWEj6BF5cp1iJvhGn6WFoKj0zIfiktT+V20vf/Nc9Osvkvc9NmAXT6F2BmSl5nRSHBoovNT5PwA2ACdwMpwcllF+PBCIhKuO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pxlh+EiamFTcP7r85z0ZZjP8F6/jzHu6+LYnt4NV40=;
 b=G1P5QX96/K/cOsSVEG9m08fCEeJwM4KzKkmk1CB+WxV3mnjzjEJs76aT44aW1Tkte8qSfZixU/1J8RLPFusPWpQJkE8KgxgqKMmjSMIm6N2N0gWulbSNxBUHm+Zrxf7/zd4IELQXp+iPW1y+Wxdv8Q8zx2EoBRUOm6KQrJEmjBYC0kJQJY7H8ni+qJR7fiKc76y4EO/cl5fQq/rZ7UErg7tag4b+TAXNUeG5luqPwReogI19MxLdLPWvtY3z0HXvf5ljQFQUKeljdjv3gHqhoJKvKs/hGVxjxLozN8KYfXJmFb790kCFd4oIihCULFrf0+MfAEE/ysgwVqz1xtvBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by DS7PR11MB7929.namprd11.prod.outlook.com (2603:10b6:8:e5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 11:46:36 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9745.019; Tue, 14 Apr 2026
 11:46:36 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Joe Damato <joe@dama.to>, Kohei Enju <kohei@enjuk.jp>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 0/3] i40e: support XDP
 metadata ops (RX
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 0/3] i40e: support XDP
 metadata ops (RX
Thread-Index: AQHct8RJGRg8tYZBxUO2BQZ5okygMrW4DbsAgCaLXHA=
Date: Tue, 14 Apr 2026 11:46:36 +0000
Message-ID: <IA3PR11MB9301A5C16F0303E07B565DAC8A252@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260319171650.5815-1-kohei@enjuk.jp>
 <ab3TtpEKY5Pg+uQt@devvm20253.cco0.facebook.com>
In-Reply-To: <ab3TtpEKY5Pg+uQt@devvm20253.cco0.facebook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|DS7PR11MB7929:EE_
x-ms-office365-filtering-correlation-id: 267d06d9-1a53-496a-1f99-08de9a1b7b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6VoDe2qRwvazoniCNOkIWoGnCsM3Dl1otk02gUFQypcdwk8rf3NxgheDcM/DGCntHTchxb64AgTMI10APZf7OPvC+fpo0b0gwjIKPmqyQXWXGBsxKVftcU8tRtWlj+Z5WjMTtd6VGdu4jAHKI+s6sO+kwKCMyiFT1YmVkqnzge26KOohH2ajqxV0KwMdtOuIe4AezNoVrar8F9/ToG/kEmF89MOjSGa2V8W6M5mEvMHnTgiAoBxIqn41rNKCcqeVfgQNuMXkL1sl5jaYoNZXft/rslweDBiLIX63jPNBIApMCs17zy4MlSuAAsAZsohUzG62GN1E0GInjF+pDBndRN6a7rMTthZ4KLuF/n7xOqdvF/pYS3wBAlk0QJEGrBvfroHgy37yBmJvWjXUCQNxzN4p9YiFq8bRVtzCIxy4RM43sRHcB9qXIVZBop82ZibZqCn+bOsbLsHE6PAgd7pqIQ4mN12466NhGWq/1sRMXKluFxgjee8fWDeyGbIqtAnPts6+6HaYla/O4GHLaDqkKSexQyFUa22wmHTlhezK8MRUtZQv5GVJayg4wAWGe0wDt/3pauagRhTe8YlsO+jftNKBl9l8uPVmbc3gHsXX6fLFroCw+4Tz3pxwWJuLG7eSSXsTfpbYDI/SC86aTcvwuX2x28/rapkErIAX7ImhfYXfsA02vcbrtGiztzjDJkABcauMu1Q6fo6etG608STR8Z0HTXrCIuETWwJKsanzyQ/AyurbjiowdEPteTT0PvadRnu4qcDzqIHgD9RiFaHb8ZZqPPy9F+4MxB8bZTHdbiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OksSL5gk5hTovONTst6NkeOxhP2sW0b88I6ojb+IoZzOsuWj6iFKFukGGr?=
 =?iso-8859-1?Q?iDIKljxD89LpruDfGQVfL+52Ya3SP0GAXdHxCjwSY4e7qVMtIF/hi+51io?=
 =?iso-8859-1?Q?V0hCVX1CKVoG7brcH/4Uw15C/wu68pibdbpVU0vdx1eymb8xvI4L++KctZ?=
 =?iso-8859-1?Q?rEj0tz85cmKC+KNUNZ2YQTiwV45FuXAYozzQM4+gd43z0wUvXmQz0nEbhg?=
 =?iso-8859-1?Q?P8KHL5YPXjsBhdHyrbRbcHt6u3vVYk1xRvmyfzssQbOtkZhIUN4R4VFvHN?=
 =?iso-8859-1?Q?vRr3PkJsTeL2AVaecCUUQ4JPWnJCpDrR+42bEbaKoOIwWKvUNl6iEZQGXd?=
 =?iso-8859-1?Q?Ha/6JY6CKxAv87h3Dr976QZ9bW/4qRrQVO5fkvwDSRHu1O/9MO2tayCIbO?=
 =?iso-8859-1?Q?zHH7T/xi3IdVSDrhjHDGUJuz7rN8LzJEl+9m4XUdWiCOERtBH7wBanLmD7?=
 =?iso-8859-1?Q?Uswh7SPfECarmEXIXN/xOjnhQYxHaNMNzsfOpcsrWXLwOvXphwN+QUXwS2?=
 =?iso-8859-1?Q?RQ32+2Q9+Vdb4ebekMMpiuBaxZJkFH1XmR6a7Qoz557ivLWUPkGhU+8CcY?=
 =?iso-8859-1?Q?jJ2R9j6BlSEwmez+/IMZsLQOzg2Rc5LRAdYhGcmq90wEdN8KZWlSx14ZKs?=
 =?iso-8859-1?Q?OkcPn4NOTUd55SEw9iz8zX3xCiOMkobCq3XZMnj75o1MqDPiprhcK0eXl3?=
 =?iso-8859-1?Q?2yIuWouK+4HkAduDX6M4flTL4uipLhq3IBB7VRiJI5ekNLl2DX3rV9oIcq?=
 =?iso-8859-1?Q?ShL89bDK36CQX+iUjlbzfeMBN/tysXruqHNmdYNtBEIQ5tvsrwom9xOac4?=
 =?iso-8859-1?Q?wc5sLAz6K+0UWHQQ85r1PR/6I+3VfGN+hR4Iy4AvL6MGe9hBgEgKjUXMMu?=
 =?iso-8859-1?Q?D82Rd1J/iSNA+xFpDOUUb+OR76xaof+fGit2+Qa6zByR7GN8GDodJlKzx5?=
 =?iso-8859-1?Q?Bmi06HRjwGT+wIqbUhadFAj3KPgwE2GoftLg6R+fqziXh/HZACkH+TEJra?=
 =?iso-8859-1?Q?cYHVW92ak/HdbKwohLADcw9ePX+pXVFn6Ihpp5vpz3whWLy+FVgdXyYegb?=
 =?iso-8859-1?Q?iUIHsjtHvTd41+dgQLycXFk019CmH4YL2GyJ+OrDn4fQAe3eylvpvp60EX?=
 =?iso-8859-1?Q?Dj43hBuIzBXbzQt+ydIw05x4G43bie2MOKDiljCKrKWNlVqFiC7v2ZR6mU?=
 =?iso-8859-1?Q?cywo5Eyyt2t41WcACTAS6LP+QRmr87Up0MJDTjU1BG7fu6q90ay6cdff1q?=
 =?iso-8859-1?Q?5OGahHFOGO6XqvcWZ2iPE+5raF65ZNBulm3JiCkkvNRv2Siy2G0Y0SlBio?=
 =?iso-8859-1?Q?LSD6l/6a3g1HyfFb0f1vsD5wnOl8PRwp7jydSPErVcDo0oirQ3bWy/TFBD?=
 =?iso-8859-1?Q?eafxg1vAA+HYsixdYdYohQq7gEhqms2lj7/ntZAFotTGfUaV8eIyNcThq3?=
 =?iso-8859-1?Q?c50O3LPjxfE2j2PtPrfAAlX4ZKlb4gDXGzsfVCzQ+PFxz91Dgdmc5KEAcT?=
 =?iso-8859-1?Q?hyomGNlqFTRlijd2M/gFlZR4y27hLedqFqLUSAPOZkpNWJ/6RnBE2w9F8g?=
 =?iso-8859-1?Q?RhYQAiaR1yx8zn/SmENu34+3BfNCBSD8VTt5BBNmOWJ4DVRxx3slCZGNVn?=
 =?iso-8859-1?Q?J90gLNwucmtbFceOLzVXzq0imYXU6u0ZnmzE3xhrjV6l6huxl2zkMfge+N?=
 =?iso-8859-1?Q?/EAv6+Lj4Pp3AU5sASmrmTniExTJ64PRbXO9/nxUOV7VK9/TuCoO+NerbK?=
 =?iso-8859-1?Q?nln72e2humOIB//tgMM24kuv5AASnjQ/x/VbKAv74qxTcz38Sc1iOO7L2S?=
 =?iso-8859-1?Q?3Bhk1/kzIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CVJWUDPWBe0dxKHn6xC7s8uHqxzfloezQUSI9W1O7D9eNHvEGpFpuB+buj57Trh60B7G/sLrx/3JkB7XcwO+hS3TJ1Wces1H+PP2aVZ9I85ui33iRp0Ow5KIQiTyWWoPAkpuOZWF8iLIvT53qkcEjPffP06TSvio/MTKu3EpxH37CaQuwcQa+PRnT2w+OdoKQpnT8Fveknsnb4lqP4K6QD9yu+I3YjHE6aV7hziMceS9Ig3PTjKDfHE0fw7VuYs5x8a6GdM9mP6Pp9RL5GSuGDXhQpLuBubNfKyHPynWznl5aDT7b91IyRCyd7A7KYJrdnuwHoEd78R891gI1N3Dnw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267d06d9-1a53-496a-1f99-08de9a1b7b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:46:36.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9bhEPxa4NKNozRcfbKCcVZPZtG2W02YEkmQdcAQrcUI71JJ1lutu4pnBNdd0QI3NaWlHae5Vn7PFUZISzUhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7929
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278426-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB9301.namprd11.prod.outlook.com:mid,osuosl.org:email,lunn.ch:email,davemloft.net:email,dama.to:email,enjuk.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EB32A3F990A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joe Damato
> Sent: Saturday, March 21, 2026 12:10 AM
> To: Kohei Enju <kohei@enjuk.jp>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; kohei.enju@gmail.com
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 0/3] i40e: support XDP
> metadata ops (RX
>=20
> On Thu, Mar 19, 2026 at 05:16:41PM +0000, Kohei Enju wrote:
> > This series adds support for XDP metadata ops. Since the i40e RX
> > timestamps are not available from the RX descriptor in the XDP path,
> > this series doesn't implement bpf_xdp_metadata_rx_timestamp().
> >
> > Patch 1/3 prepares i40e_xdp_buff for subsequent patches.
> > Patch 2/3 and 3/3 introduce bpf_xdp_metadata_rx_hash() and
> > bpf_xdp_metadata_rx_vlan_tag() respectively.
> >
> > Tested on Intel Corporation Ethernet Controller X710 for 10GbE SFP+
> > with ./tools/testing/selftests/bpf/xdp_hw_metadata.
> > Since i40e doesn't support HWTSTAMP_FILTER_ALL as an rx_filter, I
> > locally changed the selftest to use HWTSTAMP_FILTER_NONE instead.
> >
> > Kohei Enju (3):
> >   i40e: prepare for XDP metadata ops support
> >   i40e: add support for bpf_xdp_metadata_rx_hash()
> >   i40e: add support for bpf_xdp_metadata_rx_vlan_tag()
> >
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 51
> > ++++++++++++++++++++-  drivers/net/ethernet/intel/i40e/i40e_txrx.c |
> > 5 +-  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++-
> > drivers/net/ethernet/intel/i40e/i40e_type.h |  5 ++
> > drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 +++++
> >  5 files changed, 77 insertions(+), 3 deletions(-)
>=20
> For the series:
>=20
> Reviewed-by: Joe Damato <joe@dama.to>

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0



