Return-Path: <netdev+bounces-233861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6116C197D2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D1A403894
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356242EC0A1;
	Wed, 29 Oct 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGrPit9/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BDA223DF6
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731098; cv=fail; b=aFbUn5HWX6jaOYk8VaaJsPqRRTeuLjRMPZ/UyZ1T9JzuSSi8YsM203ZUEErDdWQOlyJKMjyCYblb1T8md5FbIbhYxt2WfPUPZKevKAnaJgs7k39gwCHUO+wUcxwpuHyCEV1N2StdYBGVnN/WVjLUT6SRfZZxzjrKjv4E76+lUHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731098; c=relaxed/simple;
	bh=le5kAJ3OEkyjRdAVzheLEwcLMi81s65afP1zfDx+3vc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eBrXOOTL2jFdxdCQGBtmH0jUBECaaTsnwDsiTiesyKFcB9trwO4vZANWi/EXsILA062xu0nwYRFDK2WFy+JfI8ixq2VmwnibrlC3EPyloZ7/qOg9zPbNBVGy/QvvyewKzap3d+IKNz45qhtY78CC4b0DokeuQEY04+0Kb94afWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGrPit9/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761731096; x=1793267096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=le5kAJ3OEkyjRdAVzheLEwcLMi81s65afP1zfDx+3vc=;
  b=TGrPit9/UWFkmH8tK37X5KyNrAdxywKWzpm7YRFTCIx+TCfbCvC2Dzw8
   jMRhiE86enpIHLSHeUjJ4De51PB5Rd86ruufDboChqreXcj34rOkFsMvp
   btICRSUb08KoQyYSoldhXkUeqH6vAzSfQyiKLQ8AzA+nrfR6qLcSRDlDG
   Tq0zoGmGf6unWThfdDbSBXIgMtGKqj0/MpuPm+h9auhquHSwPyVoK4CQC
   j8XjT94NwcgJ1iw7/qcwDDxtrDEazTJ/lqu9UqS7+aHeBwuOXqhCckkJe
   JcElnGlwsgMWVH/QnOzrkxlyQ8MyYChD15uNs7cpvLSTjiWSTtWSWQhDU
   A==;
X-CSE-ConnectionGUID: XSFL366sR6SbrN61Npwr4Q==
X-CSE-MsgGUID: VCq41U64RH6Dy8+qYKLdYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63054203"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63054203"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:44:55 -0700
X-CSE-ConnectionGUID: Gx9G/LKFQ3qZxUs3AaVl5w==
X-CSE-MsgGUID: cJsDUZiTQiixy7sO7Ub6Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="222824542"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:44:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:44:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 02:44:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQEeg4uC1JVVQ5R8UrV6FQ4IEqAcn2enkSDxfeg5etXSWSV2g3WKS9lf8xFXCc/HoTuSVOtT+XSGrJwpxIXFfCLd2IXlFCNcpOQXXsU49sLG4ttpli6kD8ukcPkxBx5CbnN6LZWFg5F2qqrht/CYJI1jieCKwc76AdawZEFMFwkCmYgvhKQVpo4qOo6U+QFFlG53r4cLnNgMK1KonBZ+ktwso0PlBbYUqhhmilhn0ZsZcoo5I76JJDq70a4a3mfa8H23Dka7rWYX5DK/6RlauLzUguX/Vn2ND/GrYRJCtRK2+lAtFJ/lcptTlPp5mNT9K5eiXIwJzhcWI6qY39Jkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWh90wlOoBNZlpDvehdC7VDnHhXo5UEd67Ab4j8reww=;
 b=tEkKQWV3OIQ66YiY4gcxtbZg+r2jLW7A6HlHEIeVi0EROUE7jYxfvrKtBO7lN96SY24a1nJlibd11GKMylCe9j42KwhqrKAVxH5gF8gWeC8iLA6zqmXBDpiFSUclaCd/I80N9C4NUB2nWgyBSd3+s0StfkEqe+EvenHOS+ubBXvtpGv8M8Px5IIl3x2RXHCPx38PxEUGOPvc4byrMsUjLtcvx0P29LHXwxP6HJSIv8Fy7c9hGvQLpY4pgOLH2TT2n7+2sN6XeA4/KiKjYt99IpYFLc2nRkSPCMdBHagqF4fN2h/zq5mIT55ilZrFihAd5uVskBUeFkCs83X5bf0a/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Wed, 29 Oct 2025 09:44:52 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 09:44:52 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Robert Malz <robert.malz@canonical.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jamie Bainbridge <jamie.bainbridge@gmail.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Dennis Chen <dechen@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Czapnik, Lukasz"
	<lukasz.czapnik@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v2] i40e: avoid redundant VF link state
 updates
Thread-Topic: [Intel-wired-lan] [PATCH v2] i40e: avoid redundant VF link state
 updates
Thread-Index: AQHcQ26h9HE/ii7wmkW3WCe6WtZe2LTY6mJA
Date: Wed, 29 Oct 2025 09:44:52 +0000
Message-ID: <IA3PR11MB898540B2805F5268F925A1B28FFAA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20251022161143.370040-1-robert.malz@canonical.com>
In-Reply-To: <20251022161143.370040-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DS0PR11MB7904:EE_
x-ms-office365-filtering-correlation-id: 68c9e126-cd74-4765-2564-08de16cfcf55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ns8PNIcc8l9BHpqcnYpGw/whoTTH2KQYS4NM8g3oTCQ9vEyyGcvIJk99m0CL?=
 =?us-ascii?Q?giZiDIToeAv7L8b65DHVj4nXTM3A5yAPTnGcP458eqW1yzxFsfz9uarKWPJq?=
 =?us-ascii?Q?gan7bIl64vnoZGqn/m050UDjyU0rLBcSaF7p9kCBSIsjLFsz4/nUAvBs9duL?=
 =?us-ascii?Q?5A2gGeJBeBY9ykQsRooDDGuQMRtYEA00nsoDK+lM26vRhBLnfpJzr/drrFq2?=
 =?us-ascii?Q?SeatXdk+qu6DCGr5p9SFTerFMgoQGQXmTYxPVkP6WwcTHPzBVOwOL2rGTQaN?=
 =?us-ascii?Q?v5WW58bGl/9C2wqoNcxhfpMwmwFZ9+dnLfVbi2FNafK8is0AGpo27VjNqSP3?=
 =?us-ascii?Q?sr1w4XD/w9GCimnugYvwpHoUBA4PLKdr9TpA9CmPcxuDr/ED0h597r0l65cn?=
 =?us-ascii?Q?ys/+GESUAGAUGK/CiUlTRVac1Q2JbFzWPW04lUXmU9hQWvfs8ayjavR+6bXA?=
 =?us-ascii?Q?uFCSavd5sBtfcysNa2qPsmZ01/t+J/R+/NHKfV3zC9WEX9HB26ikcr1ToVMG?=
 =?us-ascii?Q?3l3s00vBTRjg9Yc6G4jzdqATNwqMJ/1vHDX7dtYjNLEmN9Kd+7Q9cVKkf9o7?=
 =?us-ascii?Q?5YnQw4vjnxAQvpugGK2eOPVHrdIP/l3uNzRZ9YAdaNoGgbKnKxCzl+VNqLBh?=
 =?us-ascii?Q?3QHLgY0ylzu0SjsBmaUzt6rRn2GDzy9+ptE4BWqnwCVdO6lVbtlvIPGtklyN?=
 =?us-ascii?Q?FF2uR0zONm1IyniX7+eulwaBbs2jo7RN7w/QrF/QboI7S7dGLjUT+eKw+pn8?=
 =?us-ascii?Q?Zd37ADEGxGtD7lnutCTBAn+u65UbAQRywgxH017PZgmoRnsAjKHSbpbukoxT?=
 =?us-ascii?Q?cYCsdgu8NYXW+NXmfyqKKrFIwYIkWcGYd0xUmNCbqDtrgV/VYlIhnuTpGc7l?=
 =?us-ascii?Q?wDkbARdNjA4i29eAAx64uCfbxKFa9oPBUzq3frnS+VQN1typftW6hKFDX2UV?=
 =?us-ascii?Q?LVJVwj/343ppKYXzG6a7wFVD5hr3nfW/DFGj/MWDyvR3OJCvLTQ52GLOm0Kn?=
 =?us-ascii?Q?ZnbueYegBA1lyfrRi0PmqzXqJvNDUBfRKNkFDMU8B6i/x9BQf+9w/dOqeo8H?=
 =?us-ascii?Q?Tm8b+oNLGB6USG+Nm1NizUrSsXZhdIU/qoG4/GfglBJ3FOeHX7hgISckUhuJ?=
 =?us-ascii?Q?EYcbwTZJlyK5vGro2qViG6jt6z+XfHcoV4YJN/4/kLZnbfW9o+Pa08f9sM6R?=
 =?us-ascii?Q?OzcHfmrRStuqJLtga5MJ3ZaWR+WKckNY4BRSlzhiOvnvA96fV58k4J/U4ix1?=
 =?us-ascii?Q?oNUqW25a88rWY1urgCn7jW4qdNT8Sa/J7r+ZkVWJre84ko+E9auqWuA/TEs1?=
 =?us-ascii?Q?KovsO8z4Hqd/Lt7k2BwqUjp2Ppn7hCPluxgHflk0rHbRq8Vdyi4Zoocwm2Im?=
 =?us-ascii?Q?TIQLjYfrGAVDgXsgzFI/6pIJbtwS9czwQviHOURf4CJ9fali+e+m4ZD2g5tS?=
 =?us-ascii?Q?dftrMkCq5ZYy2QYjvcPvxPFGpmHZtEYom/XRCAzd1RxYSewnVP+86bfMCWZE?=
 =?us-ascii?Q?dwUccJKUuLV7jc1dQxz4wzmYpvd+I75auD9r?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H+VqxqBQ+ZxbUDwAB2VDE47wUxVtxfKv3ipItRX02ymBHuUuimFdFX4H/des?=
 =?us-ascii?Q?hA8Ny/qThneHQkY5z7sZoIs87BP7dGTmHRAIROnYvoCl7kN5sjY11Sn6+Uej?=
 =?us-ascii?Q?2Xe4sI7GBtCjybVJilbe18aLkyuqamhprhBeZA4J81VxoVUVG8zbEGrL/2kO?=
 =?us-ascii?Q?ec9zRtUHvu1xHWBKcURYdlaZZdKZfMlzP5Z/H0iHlk/ACmronwESbZPNfFVB?=
 =?us-ascii?Q?uNOmhss9KXuvSHNlMQ4vO9510HxJdHbbDAeUY14hnoSfYQUcune9swrrKwhg?=
 =?us-ascii?Q?oQcCPSmLOAt6tfhBp0mvMTH7xDsYGXF3h7/kNjH2EqRrpx9ntjP8sO6X1csW?=
 =?us-ascii?Q?XRnA1rHMMp5yMNrBMo//Kj/61QVO/L+bl+TYFAioQ2oQ5SJKYeP/gliQ2EEk?=
 =?us-ascii?Q?5TRq8D/DASUBT71GJ0O8Py2m1xPhoOR7pXbAugpPxyuHjnnmgPgY6p0FwfpA?=
 =?us-ascii?Q?aXTfmY7YynSVFa7Zq6FegiCNwi7pSreZbzNQdo4IQRwBJG5/QvCjWBlaiAY0?=
 =?us-ascii?Q?xOjlODx5ECcC5BIzdOnjKIST0NHSYP3Cn9zn73eVEIuH7M5f9arnPbamSIiO?=
 =?us-ascii?Q?TR8n39PDSM5woh/GINuqMnviDz+jIfNZMlf2BJNm3+8bfzIQvy+60vyQ7QQm?=
 =?us-ascii?Q?6zTEMKsMxSXB1cm8hs4geEatNSe6jOI3v6XVoWlHytSCZJsTKKUQzKn4zVBy?=
 =?us-ascii?Q?1FTCg3SfOdo/9v0y/dxe+i37SwqWXeVBR4EKjl+8hl4VYfkN7WonaufHYscw?=
 =?us-ascii?Q?JhjYmg49e6jIyIOkn37QKrbQJj+yyuVKPuyDtgD7/T6txm4g+kUJlZKarpRn?=
 =?us-ascii?Q?P6u/7PhGjQb9oygvBXgaXgrWvKXlA5yc3XwUzaEdoCi1q1f8CgeNeoLon3lZ?=
 =?us-ascii?Q?+oEHcQvS8VuNPgGD1OdYe7doIXppjUm4evU56XuyPFnY9OYFTruBtxB4Oa6y?=
 =?us-ascii?Q?TUjKrJVNpBSmJe6U7t4PLbx4tv28T+xkM9+Bu8kv7SH8vGAYoxJFuY9OAGX2?=
 =?us-ascii?Q?ebQWSyA3XyyBfdMsxyZWuWNAFxG0Wbaff6VAUHO7/cPdz3zDJewIoi/znMDn?=
 =?us-ascii?Q?z9B1pTNFOPgzntQJnPA7EchLAle7Y2lQoz9arryNUitv5oncJhjFSuV3STdA?=
 =?us-ascii?Q?/q/wen5OOkO6/ckOs+RU1L6GEJ2XoLwNWjvj7WjRZEhBnjQpgip939uGXnLM?=
 =?us-ascii?Q?mzRt5iFYoXRw6uClmP+s7pfDZZgdxfLSk+YRgCq0C7X91DcSyog4RdYilTTU?=
 =?us-ascii?Q?FLPOQ4g72Qt0h62hmPinXOrymcG1kXVCzJBO7IYJ+dbYkY7r+F3TA60UGflb?=
 =?us-ascii?Q?mEp2bDDGpcAnfodfE6JCZVWUUTan8tee7gfyyz7ouaU7qpKlm/yLU0bLWDss?=
 =?us-ascii?Q?/qDiJmPGUmKCDAVoyU/tsGOf16qWQ5gEMgkOE7oTNpJY+cVRnWJL7j+7DmKr?=
 =?us-ascii?Q?k/up7PPiF3Rk5/m1U15bQonCXZMYfXIxGFTEP4t9DyLgYuK/Dnwt2XTNLaHX?=
 =?us-ascii?Q?8DXFln/TUoRI2Kh6gycmf2uYAMy5fga/YoCv0jGrwj1gQnrQ7XHeIKhSnWsS?=
 =?us-ascii?Q?MGY4rp/zb78a1+1/ZE+gMkoxmY2KI9MdyaFs2d9hQ3u5ply/rsn4YUf9dYru?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c9e126-cd74-4765-2564-08de16cfcf55
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:44:52.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x20No+R4I0CdeGEz3q3tkCkNX0qwAgAjKwkWmZE4nXAvMggFRsbGoRMl3UuZf50ErEqOtXqQdfWztlJOn3yamXx/UmEoYWox4CrN6wmwj3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Robert Malz
> Sent: Wednesday, October 22, 2025 6:12 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Dennis Chen <dechen@redhat.com>;
> Robert Malz <robert.malz@canonical.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Keller,
> Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Pao=
lo
> Abeni <pabeni@redhat.com>; David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH v2] i40e: avoid redundant VF link state
> updates
>=20
> From: Jay Vosburgh <jay.vosburgh@canonical.com>
>=20
> Multiple sources can request VF link state changes with identical paramet=
ers.
> For example, OpenStack Neutron may request to set the VF link state to
> IFLA_VF_LINK_STATE_AUTO during every initialization or user can
> issue: `ip link set <ifname> vf 0 state auto` multiple times. Currently, =
the i40e
> driver processes each of these requests, even if the requested state is t=
he
> same as the current one. This leads to unnecessary VF resets and can caus=
e
> performance degradation or instability in the VF driver, particularly in
> environment using Data Plane Development Kit (DPDK).
>=20
> With this patch i40e will skip VF link state change requests when the des=
ired
> link state matches the current configuration. This prevents unnecessary V=
F
> resets and reduces PF-VF communication overhead.
>=20
> To reproduce the problem run following command multiple times on the same
> interface: 'ip link set <ifname> vf 0 state auto'
> Every time command is executed, PF driver will trigger VF reset.
>=20
> Co-developed-by: Robert Malz <robert.malz@canonical.com>
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>=20
> ---
> V1 -> V2: updated commit message, added information how to reproduce
>=20
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



