Return-Path: <netdev+bounces-208535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EFB0C095
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA60E3A2901
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFEE2882C0;
	Mon, 21 Jul 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8h/VVPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BB285C87
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091203; cv=fail; b=SvqjZnhpKeOmexTCfMGhXemxB0st2loxPU0268XPlBaGsvJVKIkqmes9ADIZ0tcoszJ5X6mhCD8mha7y5iSJEH0tnfjrJAulBsy1qbHyf4OvQifdRtMdDCwmWNE4TIi11VXhJFeqaYwAV+gbaxdMEpTOLuzB4xyGxPY3b6N4FrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091203; c=relaxed/simple;
	bh=sSg1aCnoI6J6BBHZm41ztfkLykaubdUTxRKuSZsolGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bRt3jD+5U2f6YLaD2TuC/U3umU54fsxT/GXZj8XS6OdF/lF90Zzl/D5bTN7RSXFxgNXhpemQ3GnzlwDVyUN1lgBrKy058cHmHiVr7B1C6E4mwQvrXt7L7dvI/7wnsKsamgNBXxgDru1Yx4l0v+iLrKinrbYhcqyD7+wZdl0R/Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8h/VVPZ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753091202; x=1784627202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSg1aCnoI6J6BBHZm41ztfkLykaubdUTxRKuSZsolGc=;
  b=f8h/VVPZStIkJL5Um1wyFZU2QwYCFuqHJuDXmv1mOf6i1GbCUEOBEHTI
   58nw2wKuglF1h7PUmmyeI2mrxcvJqbCzBPqno8B7N16Ijrppj0LM76bg8
   NEMEgfcXAlgN3KTkYrZuZ+9eG8brs5PyQPzDLYzmpQGI6VHsEqPe0m1wc
   aVWT4wY4pXXHI5He/Ne38gKFbStIau+9X+EKFBodHjHJQGWmhV2ggrj7h
   Gnbg7dwhH053d8IaG9+3R2ARacnkM034NnIZ0ALuAbkIC1qnKAxAcj4PT
   xkcQZiKGsj5/Eaw54L1CYr0aRfHuhdHrK2hoB84nXQWfPhC0xFt4peo0V
   Q==;
X-CSE-ConnectionGUID: G4AY2c6vRymbN6vAVdYcFw==
X-CSE-MsgGUID: pLdS2sRPTfG070/SGsLeIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55450778"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55450778"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:46:41 -0700
X-CSE-ConnectionGUID: Q+BqeLsoQkewEGCYVEQ4Pw==
X-CSE-MsgGUID: Al5FGEH1TzmXBgUtLOhxUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="159326437"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:46:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:46:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 02:46:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfHk62xzCBvmZ5zccBtJwqdNuVKAFOVziCOqVnvd81Nu/1X2AyMJ2GIvc7DLG8xN7qUKWBZkVHC4FAxheiV1cGiK0nkOR9qDUMph6gb6z2w5njVaZru5Movvs1XAuJo+5vQPwpwRWFxpl9dOxpD+CqW9BIjx8YIXa24bQeoHnxbng4zsetSCL8oLRD+C8oL6Hht8fFgsLimRejsRdzZlIkapXGIy/a9/q766SSa0uDJ7+5ngAn7BvU8YDibYXiHIAoPjyEYTGBCEi6HDwHLUSJm3yxvcVsgvd5eRgyppAOe26/IlIpcI6jgR3BeN7/+GOh6uPdcYj02qDFKDtbaiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+aTiiyIWDRtJHSmeFUIsfTXGlyvAgcqFZwf7NCa1EM=;
 b=SIcf276Ci2iEJcDY7WXm/dGypcLccISFaeNhEPPOcyZGInpw6yiGQBXdxm9DlO/ISp8WU2buwCDNRCzh7tKoZ2FTYek5jFZYC4k+PY1Pt3Q4fYhybhXUNMMhWFhAj/UjAiheO9gc66209DKZK4UX7AwOwgdRo7yU8xZ5aGlXalWA6Vq/7IAUcU5AK8/TtmFVYgw5E23ElO6djXNYmLL+7U4iOyurVkW/QxS3JlJ0HWRfhCgO8V7fRkXtFH2SaBVPna2X4sOVHhxKFVr3YROSPRr983qJKzkzYSyrYsArsqWD8auPSWAPTFvSyEakCzU0aKLNkBtKxy2sgtbyA+GJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 09:46:08 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 09:46:08 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Dennis Chen <dechen@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: report VF tx_dropped with
 tx_errors instead of tx_discards
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: report VF tx_dropped with
 tx_errors instead of tx_discards
Thread-Index: AQHb4KFPgqZZVZVCPECLNvSN/WS5vbQb/MCAgCCKbvA=
Date: Mon, 21 Jul 2025 09:46:08 +0000
Message-ID: <IA3PR11MB8985803B020C69688F642F1A8F5DA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250618195240.95454-1-dechen@redhat.com>
 <20250630164955.GK41770@horms.kernel.org>
In-Reply-To: <20250630164955.GK41770@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SN7PR11MB6900:EE_
x-ms-office365-filtering-correlation-id: 5727c96a-1c76-409e-ed7e-08ddc83b6b64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AlCnrUdLIK/Bgj2qE8ClfSgYCHAX7Ys+Bs2zp0brI2GVR+qvoB5lmKIVdPko?=
 =?us-ascii?Q?gGkTP3jiVyMEWaTbDeqekeXoYuNvZYuesgj4hfm8n1QpTjSx7gvKveLatNOe?=
 =?us-ascii?Q?jEl4AsZBb2PaAj9Ct+Rm98886rxOeh0gDygpdaFGip6OeL1/zNu+JWqFF70E?=
 =?us-ascii?Q?2h6MAAq9ak86NdAcfJpPVUOOeqalZEh735ekam0fqiv10PgbRcjNnTXhnCTH?=
 =?us-ascii?Q?wpCFG1kq/fr0yYVb6N7Sg7wne6LdeFjaVwhjZ4B5xMAeUFK+XxtjoHtnDHUe?=
 =?us-ascii?Q?Y3gd/6L4suNAN008FWhjdrxQJIqmGYRLe6advM0rwbliN/HfZabct1tOIcl+?=
 =?us-ascii?Q?nDWzzrBTf0Q8bbUbNeyUbWSYKGQIvvIQ1A1y9o2MbsQG8PqPjppdarBSsMqx?=
 =?us-ascii?Q?HcAr1sfclNVt+L1onRSTXkSJpzpK2XLkYb4S45srEOdkM3ZAKNFvr/Nbk/eA?=
 =?us-ascii?Q?Gzdz0oQUeloq73c+8Xt+HWQLQKiG3AFzLAYH303CjZT8vpR4cuuIRvU2GN/B?=
 =?us-ascii?Q?QgSnAqwtNdtkvwCJ9GiqXWxyZPiiqrTtG58wHUEyH9B/oEmGgbjWzum7Pv8x?=
 =?us-ascii?Q?taqhEShOmpyrURRuj0CyQ53ujeWB0al+tZNotzuXSawoj0uWzn1u7hg66FDh?=
 =?us-ascii?Q?i0XhluhVVl6uVdd4YisAk2/nQkCqafwPRk0mnGj0HvSZ2UHi1JV0PA80Pi+5?=
 =?us-ascii?Q?IGRYO1SHKdjizB6l2dMJA2awYRPWpVdyBCPfhkYkBS0XpJZA31u6FJevLOdd?=
 =?us-ascii?Q?JYSB7YUb35NbLuuB6NIr4EMxRizhAYH7ig5TdRiKfsMFY/z13ETiQjar2yp6?=
 =?us-ascii?Q?K0w/xeX0qzB/jS1FFjQ2cy8w9BQ6hJI2tLOXnJ6Bh/nE+O8LiTPE8PziHb+4?=
 =?us-ascii?Q?OoDOqwE45Gbkh1LS70FCNEVyIr/74C1h7MZXzGAu+q1QR0egeYY4yqZobxGx?=
 =?us-ascii?Q?KDbBLIckj5A7Ds3EfNxZPd4wPh2DsINBKXdel5nf7YdsJS+XL3zMBiO0cCfp?=
 =?us-ascii?Q?IY5UAYRgIt/mNMYyYgMZRAn1XbSkiM4Cc2HgaCZwEDrJwQGuZ43VAOOiLD3d?=
 =?us-ascii?Q?hjiIc5728wTBW0HEZpiDNkv6DOJQovOyYqrn7PVRVmtd7BM6lQyK8Gmrt/Em?=
 =?us-ascii?Q?d6/YSFlBnx7l3mThpkv2iAV8q1IaogrRv+zT/ViVpRWLb8b/+lWVMULl3SaG?=
 =?us-ascii?Q?jm4+2H70D+3lwEXYDtidNO2BmvTz2IId1h5zrbeKaRpRsomSQK6qa6GwIQ46?=
 =?us-ascii?Q?en4G5UAR4fOXKIaKw0RW1Zpur+EPXiOnisbxp0ykppgN9HP2xpgQWCb4e5ut?=
 =?us-ascii?Q?EN5RMVd6NfXjzQtytJ8k9nwnm+aQKsZ6hA18rESHRabZYQJahwn59BcwSAwX?=
 =?us-ascii?Q?nW0V8X/MUdq6Pxg0LLvlAJ5/CEiePXV97bs1mfb+++ysYPvM41M/ii9FQkiY?=
 =?us-ascii?Q?dRBMpv6r5AJ0aFJLopVAcQ16ay1J/AuDhCj7Tm0+7pIgT9smeEYnu2xw8b/B?=
 =?us-ascii?Q?+nuY1qo1CNt7foY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRg0RZm/uW4iNsWPfHxOz19ISwdaX0l/Xwv9pdeYxJVVmeTgRaXpfvVR+uXn?=
 =?us-ascii?Q?aLvIgPfevwDsiaYGBK7tfHgXMOEEQgts+6auKyaBd/5XpjIuFfw3G4SHUups?=
 =?us-ascii?Q?3S6Xje+Ad+4YNOfOTrp9MTdy83GpVBcpMRZjD5FwtG2oz/hSxgQeZ1lwlAEk?=
 =?us-ascii?Q?enxVIrA/exjXK8+UfuByL6gVApo2w1LZi5NkGdPJ/1Q5M0rsOLc/2q2GjhKa?=
 =?us-ascii?Q?D+ucyujG46gDhCB3Ep1MW5zyQCwMGjoh7vE+9+eld/VlW2RGWFWek0MNu7TU?=
 =?us-ascii?Q?ea8U24FMmirW32LvFjjs17YcKM+giSvMwQ2dSVVJgWHNVfbTuiXBUvufpEks?=
 =?us-ascii?Q?Rc3sNbOjsmn32meNKgZggdfDz0Y88wb5FgyWwisVEmRpQyn2jvKGdF1zR2bB?=
 =?us-ascii?Q?VGzWqLdIUdnwODuzWL5kl3FymzZzrYRysYI25eiYYVzPNmkm2pareKCGOnUx?=
 =?us-ascii?Q?/ua+TGV9oIyFdD+o+eBMJCUbmTjjjCqL2MOw6QacmrdHnMGf/89vjKzOTreY?=
 =?us-ascii?Q?m6Q0/nt1DOBo7RIRs1TIN8wiom1G31jfA4xNrOP2QE61c6pAaQFBbxTG1j+B?=
 =?us-ascii?Q?lpidrk0WMClvRCgNQkyVLcO21gbg2Ibxs0TzripVnZpcCphKIo6Plq4yGSaU?=
 =?us-ascii?Q?CZ5GQ/Env6hvd2AqGDiLmTTb1oF65LNObnyKHfnFvVnr0KH9vKCFHaXvfyKB?=
 =?us-ascii?Q?SAFy1Moo3DBckISKoek7ER32QzwX+9ERlzIcCngIiIZQzjJ3cK5m1nyCzcPo?=
 =?us-ascii?Q?74X7i/CjtasLppcGVQ0W1k3GADnDsiV2/7ZFMwQGyjCH1KG5erjkhDtV/58w?=
 =?us-ascii?Q?UhWGuwvuJI44vAn+j9Rm+EQRTZlClWbS7sAHHDVu07ufyf1t/4wRkmDBJl9o?=
 =?us-ascii?Q?hQkVKquHK3e5taKelF1XP9+z5TxHL2vo2HxjyVngFV5J4U/EWmDmrcowcciu?=
 =?us-ascii?Q?7l/avWYc4QRR4j/vHu51x0iLUbYDSNJyag9hEBp1RVFpGSyL/uR84HRpnOIl?=
 =?us-ascii?Q?3W26puc+EvhktlWxJ1GaHTiRHSTwb3w/U6eJFLGOmV8e+5XE8ubSIr/z9xNx?=
 =?us-ascii?Q?kAGw1t7xGYPVx/LgycwmiAK9C+cOgO8Tc9jnHBd7oUEmVhFTLuix3nad6q5D?=
 =?us-ascii?Q?UsluvjeZopKJ2if3eogSDtk8NCzsqzUoDvqDNUeca5pDWHiAdL/JRYPjZpne?=
 =?us-ascii?Q?8SiAsCWa+FWhqvpXg6tH7epdUHA16ODYIQs7ysvUZRcYlE5aHDY9kC8yCJlP?=
 =?us-ascii?Q?Jw0tWb5mrR9KI9w8NUMDxnrH8sgkgzCAXyOl7UJ9G64DN/7AiycxCAY9FTsm?=
 =?us-ascii?Q?z7kHrOA6GWThOdoKdPeJf6J8/Le+WFQOdgIBR2VuufUrsgpCdLJbtk4SNmHD?=
 =?us-ascii?Q?/SadNBYchXcvh0pc6m60bXhhUx3CX2lPD+Zi3ZQechLxdus5UaRWDDVjWT4h?=
 =?us-ascii?Q?fR88/xkVk+/KF4rVgjfUaTIi5XeDMpsTk9DQwbNZIo3xAEv5wA2Mn3teIX1n?=
 =?us-ascii?Q?r7h6AeEyr1/Refs7DXYToXSS+wlzZO6Rn3EImeOA6eQBlVmSCI0mtzgCVxjl?=
 =?us-ascii?Q?JNa6ywpc1PUFF45o/fZpvoecpJb6UM4fa0kZ4QTkF4qwpVZYwIquaK4ktPrS?=
 =?us-ascii?Q?Lw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5727c96a-1c76-409e-ed7e-08ddc83b6b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 09:46:08.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZ6jsVtUFfiSqVTpTalEd+uVnvn2v/5o5E69B5oPdYMf9FrAgvu/c5S00sOQSMG7/2HiGlJI+kdZMP4VUbmuxa3Y1fTV/+eUj/oluegSjQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Monday, June 30, 2025 6:50 PM
> To: Dennis Chen <dechen@redhat.com>
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch=
;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; intel-wired-lan@lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net] i40e: report VF tx_dropped wit=
h
> tx_errors instead of tx_discards
>=20
> On Wed, Jun 18, 2025 at 03:52:40PM -0400, Dennis Chen wrote:
> > Currently the tx_dropped field in VF stats is not updated correctly
> > when reading stats from the PF. This is because it reads from
> > i40e_eth_stats.tx_discards which seems to be unused for per VSI stats,
> > as it is not updated by i40e_update_eth_stats() and the corresponding
> > register, GLV_TDPC, is not implemented[1].
> >
> > Use i40e_eth_stats.tx_errors instead, which is actually updated by
> > i40e_update_eth_stats() by reading from GLV_TEPC.
>=20
> ...
>=20
> > Fixes: dc645daef9af5bcbd9c ("i40e: implement VF stats NDO")
> > Signed-off-by: Dennis Chen <dechen@redhat.com>
> >     Link:
> > https://www.intel.com/content/www/us/en/content-details/596333/intel-e
> > thernet-controller-x710-tm4-at2-carlsville-datasheet.html
>=20
> Hi Dennis,
>=20
> Thanks for the detailed explanation, it's very much appreciated.
>=20
> One minor nit, is that there are some leading spaces before "Link: "
> a few lines above. But I suspect you don't need to repost just to address=
 that.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



