Return-Path: <netdev+bounces-268130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN4oNpXrt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:37:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 803DA298CBA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8FC63004D30
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC35286410;
	Mon, 16 Mar 2026 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEJJUjiU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934125228D;
	Mon, 16 Mar 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661073; cv=fail; b=ASo9lKEkgRPg15DEY3ye5lnrOirIqXy0XFj6DjQTiV0Nx8Pu89oaMQzzSnabvbaTHvTC/JuQ9JdS49PCOA/5erPUW0MT2TNYo/XTOEq1RAOteRGrCX87CYkw3fjFK1tIxF0rjWJhM49PZfW4WjEz74+QzMJki84vtidk2mj4Ads=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661073; c=relaxed/simple;
	bh=90fYtbzVq/cBlTU0RBGY49MhV6P/FtLIMK+ias974e0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DopfjqxdMfp/C3FrpT+joNDrAcQU2Mo7HpzsU6m6ytyP+AJWf9qv8rtoBi7pDtTi1Mnl6rL5RFwkHAD1f403+lqwcZbOAdchmhxNqc7k2JB6NLof2QfyHVQX1TQnKN8pSmYLVDDQyuPaCAeiPrNfHEcEgPqOUWwEAjXJI9F/6Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEJJUjiU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773661072; x=1805197072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=90fYtbzVq/cBlTU0RBGY49MhV6P/FtLIMK+ias974e0=;
  b=lEJJUjiUW6RvG9XcBlupydeKxJ/To3bR30SvzX755iZZewuHvnwq8Twn
   Dszi/IvzzZENMzh/I/gFrb9DmEqkuP+jHYaVAcw9PABd8Pjk0WazZmfYi
   3DL5bM1MbmfPxiE08rgQrRQGByBmyFiGbIgBcFNLj5ksuHXjkj7IF90QR
   cNHHV+i8kKVqcFbqdL//XqCVpRCGvpaA/TFoGbPi3lzfwyZU8SY/JYx1k
   Xdb9ZliNWk4MHgLhRO7hBNDPj3IgCHWJphNHQNWi8G4Zhylc1hQabUoyE
   XRS/+v3lIH1++FHwAdzQ2BPxF5EqLU9b3JjNlOdr0vEl71elHL3zJF7iT
   A==;
X-CSE-ConnectionGUID: AZVUlcWBTS+vDQkSnaOkoA==
X-CSE-MsgGUID: c2KSD3xpQiighyp9fd8aFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92056532"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92056532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:37:52 -0700
X-CSE-ConnectionGUID: 8Vc6a4/ZTAO+B5LzaLpNNA==
X-CSE-MsgGUID: 1HPHminrSIqfloI+YHrEug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226348739"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:37:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:37:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:37:50 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CChZoxdl0FHNh3x+SYrE0HxqRc8igSC42z4Q1+Hs+QKOX2iqrPmOXAp/kA3SaACzQyctIPA6S1P9BFvEIMI851cA9YO3GUgLJjlspsfx9mfyV5OHfheqNR5OQDZltdEYD1Duoh1PP8aC4saKxQr3dtPb+y0e39eOd4C0pNnQknt19MgFhXMPPMjxc39klczHjDR/To+KngWB55Vga8cclNpyB+xJS6hNZHE1BNgM8D24BAfg4YG/nmNEo5MHpLTV4v5kbAzA3DR11gXcTIxMP5yp6YoPaVkWgDj9u8AMLYr7WwGBrF6zjnWAriZaCx6o/RjvjdaLSLUK/N+tEMn5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1rj+uDUOZ4HnWQO2o+3CQl+aTjeubVbdoaW8IrcYDM=;
 b=aYIkW3Ec990Le+NqyWvKVeMAmKrcP8/aC997fTZNwBw95nFsBkrYdTVwAWfKzen/OSzfmDLA57vTGEys2QgEGuTAUV5Ohp3fY7GNzuXtEKweNh/E5IgzepsyuO0z3TcZYvuGMi5KZYsrwysZwF8MB6BYpMRuQFveqosqpGSagll9Z7/r/Y+Ehm4sZyVw47vWtkXdNbzeOXYm90udqrSfIP0E+DLwiT3fo7DaMGfcEiMoINkn/EIW++3+XuMZQwPk7xuXgmlxKfpiw613Sjk1BO5i78TFCHguwaW3yuRQ6jvJJdTY5ocqzfz1GvXYwpIzBD4FVLvHp+wXiGWUcdGOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8352.namprd11.prod.outlook.com (2603:10b6:806:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:37:39 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 11:37:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN filter
 state machine race handling
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN filter
 state machine race handling
Thread-Index: AQHctTGrXfoByy9hzkqvbSrmcyPpk7WxCCgA
Date: Mon, 16 Mar 2026 11:37:38 +0000
Message-ID: <IA3PR11MB8986FA7536046A7AE5C98D96E540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260316104209.1285962-1-poros@redhat.com>
 <20260316104209.1285962-5-poros@redhat.com>
In-Reply-To: <20260316104209.1285962-5-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8352:EE_
x-ms-office365-filtering-correlation-id: 9fa0b45d-3aaa-4f52-baaa-08de83506d66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: sENonxSIFieZNIgtS13cQ+jN9zuNfPwF6HnA9vouyOurIw6TFeeMMFp9N3nYzcMTaW6rUFCXrqWNlzEhy6ayJkDuosN9gPQ2C4S2ANFxM/+VyxOwAaSojs4VkRgNsdUq+aHntOSKl4dFovWL4MpUp6Si+u4czpPYUtiT0VLzXmci9myhmexv3ku3kK0wHeEJ6uZxakUG87UoCtymEVP4e5E+FyHLMhx0ueJWt/u7qGVjzvfSU8GkXqpgZI7dthEBJ83IyITxX1+pxmOEsZOv+nt3ZWIjfKrSnsl9onfLmpzSuTh8K07Q/t5Opd0EWiUWWsnqs5rBOv2CHGxS6yUBXVpvL01NF1eGJBLENpFrV5hjso+RHAWRCcvtPmA3pZMOPbTaCaWix/Lp4ffbK69RpINGwI2VOiuxQPBJq8t0Wf9Gv9rCobzW0qAvIzfXotmyjeamhcBXgOa/7BBBf9d41jVFQkoxT1WrB+FsnRrWMo5SoiV/SnlhSV1xdNludYVh98fs3CIpRcJXz6/yQecVTJBU3dXw5NzAcCFAfWIvmLMKlP+w9dJ4QFRL3xYRGnUrroYQmtfbnA3mphV4jStfQDw4/EAgPgXp/GdBCNcQ2y63j5Wfh7IJ5quPesoAtum5P174MA1g+SXQWCXoGyknKcMxryXsgEUqdvn3w322neVSoZ/yk1V+o4nBFV7jN4o07miBSsQ+GPLEL+f6+MYjqTtwe+5vNQfwpgW8kxMTOrcfV7d+ouZ7BQa0vA6R3tLVkwvKfvEESM1GCaIihY9XdCutNFAfA+njWsaJGV7M9OE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6u0/RxRW4TYk7Y8yu/Rf0ngRfmeYaluFoxYe7+lLNGXlQIHqWwQQdlTzmY0u?=
 =?us-ascii?Q?2/TcyE4ZWGqrOmIvcs79eRMobPZ5rI0cJDrFFH+hC4vxFuvpwCyoeM75aPch?=
 =?us-ascii?Q?wfGGyryCU64un43GpP88vvL5AV+/s/vacWdwLTu7UaWOwfs5F4by+U6xuwxK?=
 =?us-ascii?Q?J9tLGBy05V0IEljLOG+ZxfyyiWIDvU9gVAA8O6fENxsLK8dzF4eCn/9FUz/b?=
 =?us-ascii?Q?ehbT3zmx2jF6/cbdpuF2zit1MkFTXJJMBZNBlpD4bZcdT3QOxnnFDF2h9Y/Z?=
 =?us-ascii?Q?HY0i4HuVF4+HArLH1GudDxb3glQMHrJssf0qW7DG6SLECUYHqvMSksLtMpXZ?=
 =?us-ascii?Q?fiWgJjBeM/AbqrvaWTZWMRn4H0nzTZewy5V6wk/q0/wP1w72D/9OCabZKmjl?=
 =?us-ascii?Q?7qvmkQzK/ATaNnUJx8Rfor2EPK2o8+fifqgezloOx8ZiQnmM3X6B3NUvfPlM?=
 =?us-ascii?Q?YzuOwphGB1Ep8Eio2IAHrwoXuP7b5y3VsBMG2xXTd5YEBVKz58dLFd/SYSdI?=
 =?us-ascii?Q?j5KpUZn1uJh40BNzxLWQ3y7Eq2wf4mYzCSJuYGGBNXOfQR/m97xQJmT1VdLq?=
 =?us-ascii?Q?HhD8UXqfMMRepCDOKGmRN8ADa8Dvol1JD4eB2aTZgxTuyV8Uc4Iu4YZbq1NT?=
 =?us-ascii?Q?L5isQTU4zI65+TBEJndNVsxT2LD4U0bmy0D6Uzak+Q85fug1/XLhobBUICBR?=
 =?us-ascii?Q?6JAm3R3xYWFS4E/qtOdYzGDi0FDOJ8vWJYkkuI9V69ZGTtmYo1FeVC0cRdHA?=
 =?us-ascii?Q?OApEJiGTsyxuxtxrthy45trzZbGS/UziN64IZr4j8pM5WyWd/3xhjYL9JGSl?=
 =?us-ascii?Q?nNwMk2PAJWXSY3IvStoaMB7NJDwyB5ZwlL5L8AWe+28iC7XIBj3JoNnU2IdS?=
 =?us-ascii?Q?ReW+tTHK/OmCpQK2l8QyuLBdZ8IfsglJI26v1p+UgQS+uWlikeAzWkoQjpW8?=
 =?us-ascii?Q?1MIq48BeHIMItDGFjlqdOv250jnC/P/HwqG+DK3QkH0P7IMYzpNM+Ee6cdq4?=
 =?us-ascii?Q?OtC2nvZC7eUSPoGqyxZgQGlDTSxqh2mkoVwiDHIou+4yUE/rqQq+daGsKi4L?=
 =?us-ascii?Q?g/uZH+UvBsZaBE4xnJNvh2eBK/mTzeKGwTH/ohPC7EhrISSYClEdJu8xBuHd?=
 =?us-ascii?Q?t3p8ACE4LB3FS1mkgUzyV7khkKea8vLWyCIH2DQg+Ack37pRVT00ROJnMGWt?=
 =?us-ascii?Q?AUTYCfOZaggHykNh6Eok33oqikChvFbqXn1tJcsuD8MDlBJAwCuWXYl4XhzU?=
 =?us-ascii?Q?KrgYGlAadrPRFJ8ImAirFRi+ecLtPckzWuG8cW5Q02+DehzxPvTVQr+yNz2U?=
 =?us-ascii?Q?RMIaiSI0rS79/R3hLKfFs9tBZfKkcWL/Pm7rZctnFuFLNWhjluDneBE/AWxZ?=
 =?us-ascii?Q?ATqMBrwTLL3lzakUz8iwurW9kqRlyK9EYnidfgnMYjgRTJss1K5+g9OUZXnQ?=
 =?us-ascii?Q?6KD5OmYAzYypr0BwrZ8rQhiNzqF/XgjBALMBy7BPeIZYv+F/8bNotNJw28Li?=
 =?us-ascii?Q?Sw3666MlgKtMAIMgByRqYt3tCg+s47ifAUHrv+cJNJ/v5Xp0ikf1DUJywJSz?=
 =?us-ascii?Q?yi/ZlhdYPT3o9fWTEDga0AZrkhaL5zhgyFq2IyKZJLBFBqMnfiTjBnceHdB+?=
 =?us-ascii?Q?cNuS7f9iQQV5n+rWH1dhsgRmtUbv6A4ERow3l/27FwVg4pJ9ZDpcA43GOf2D?=
 =?us-ascii?Q?tBJflsRlGNFM4PFg5bzxB9FigHbW4UV1c/KyX5Tr6vNG2TQvVBHKuZVBlffO?=
 =?us-ascii?Q?Ub5a9Lul/gWpiZ/+C5B3v+HLD4WzXKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vJpStBa8DQfWz7DxBHfp59PVLROMMcDMXojewL/MlyAKJeRTnZBCtLnGz8vO/AOHQQ4ndLQXxW312YxFhqmXuBVC7KagqJpSXFY7L10uWCTvP9xi0wZ2tYwmgJa/YkZ7TVOdRGXBWMm4gpT1CXn3qOE6aVmdzwvB5xgqdhOF4ECQhOfp1yRq2NX3GZQn2EFiloGSolRE4CAvL1bGyuOsM4cdmWOrGF6McwDyLD70bz8EFsIKw+KzzGUggXzAgcbf1e9veHo41ookKuJGR6KDhKwaFKETycN2HpEsU8jPCtqE7HaQmuZmP9IzXk4uDxCIuunpuXS+vbT17Ycv/6QfpA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa0b45d-3aaa-4f52-baaa-08de83506d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 11:37:38.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8RgQRKNEVoE15ncXpbPaG/VRavYReV4jsGkHBouEGPzxVCrfxXMRxBI1RF5FuSDNWCeX4re64hgMfF1D6TDYsCMJSpcQc0zzCbN4QfqsK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8352
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
	TAGGED_FROM(0.00)[bounces-268130-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,lunn.ch:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 803DA298CBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Monday, March 16, 2026 11:42 AM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> <edumazet@google.com>; linux-kernel@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan@lists.osuosl.org;
> Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN
> filter state machine race handling
>=20
> Address remaining race windows in the VLAN filter state machine that
> were identified during cross-state analysis of ADD and DEL paths.
>=20
> 1. Add VIRTCHNL_OP_ADD_VLAN to the success completion handler.
>=20
>    The V1 ADD_VLAN opcode had no success handler -- filters sent via
> V1
>    stayed in ADDING state permanently.  Add a fallthrough case so V1
>    filters also transition ADDING -> ACTIVE on PF confirmation.
>=20
>    Critically, add an `if (v_retval) break` guard: the error switch
>    in iavf_virtchnl_completion() does NOT return after handling
> errors,
>    it falls through to the success switch.  Without this guard, a
>    PF-rejected ADD would incorrectly mark ADDING filters as ACTIVE,
>    creating a driver/HW mismatch where the driver believes the filter
>    is installed but the PF never accepted it.
>=20
>    For V2, this is harmless: iavf_vlan_add_reject() in the error
>    block already kfree'd all ADDING filters, so the success handler
>    finds nothing to transition.
>=20
> 2. Skip DEL on filters already in REMOVING state.
>=20
>    In iavf_del_vlan(), if a filter is in IAVF_VLAN_REMOVING (DEL
>    already sent to PF, waiting for response), do not overwrite to
>    REMOVE and schedule a redundant DEL.  The pending DEL's
>    completion handler will either kfree the filter (PF confirms)
>    or revert to ACTIVE (PF rejects).
>=20
>    Without this, the sequence DEL(pending) -> user-del -> second DEL
>    could result in PF returning an error for the second DEL (filter
>    already gone), causing the completion handler to incorrectly revert
>    a deleted filter back to ACTIVE.
>=20
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 5 ++++-
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 89e5aae20d5573..1ffc0ce3f35602 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -816,11 +816,14 @@ static void iavf_del_vlan(struct iavf_adapter
> *adapter, struct iavf_vlan vlan)
>  			list_del(&f->list);
>  			kfree(f);
>  			adapter->num_vlan_filters--;
> -		} else {
> +		} else if (f->state !=3D IAVF_VLAN_REMOVING) {
>  			f->state =3D IAVF_VLAN_REMOVE;
>  			iavf_schedule_aq_request(adapter,
>=20
> IAVF_FLAG_AQ_DEL_VLAN_FILTER);
>  		}
> +		/* If REMOVING, DEL is already sent to PF; completion
> +		 * handler will free the filter when PF confirms.
> +		 */
>  	}
>=20
>  	spin_unlock_bh(&adapter->mac_vlan_list_lock);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index d0b7b810679399..147adb76f64141 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -2877,9 +2877,13 @@ void iavf_virtchnl_completion(struct
> iavf_adapter *adapter,
>  		spin_unlock_bh(&adapter->adv_rss_lock);
>  		}
>  		break;
> +	case VIRTCHNL_OP_ADD_VLAN:
>  	case VIRTCHNL_OP_ADD_VLAN_V2: {
>  		struct iavf_vlan_filter *f;
>=20
> +		if (v_retval)
> +			break;
> +
>  		spin_lock_bh(&adapter->mac_vlan_list_lock);
>  		list_for_each_entry(f, &adapter->vlan_filter_list, list)
> {
>  			if (f->state =3D=3D IAVF_VLAN_ADDING)
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

