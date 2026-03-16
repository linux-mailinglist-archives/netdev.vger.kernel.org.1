Return-Path: <netdev+bounces-268038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCoWFGWxt2m9UQEAu9opvQ
	(envelope-from <netdev+bounces-268038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:29:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA12959BD
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E40A30071FB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA934EF15;
	Mon, 16 Mar 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmDWe+aI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A334EF10;
	Mon, 16 Mar 2026 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646179; cv=fail; b=qt8CIF4B9KUIGUO5IVD/n+krEbIPeM6owwp2L4cC09CZNNxkDrIS5HDXANgmhxLO33Q6/KdHlgQDbLUWAyyROUbB+io54E1GYe7DfcX9+0HTOt7gRPfexa7wSoxbV27zby8aQx0E82rrEuOXaud8eIeT+Xsj3qOQ1zH3/KjZwCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646179; c=relaxed/simple;
	bh=uoPlVxirncNVZPLBBxahnmIKF66jaXQoGXC4hv5vQlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uca+UphF06o6WpL1q4e9zx5CqShJvPJal6VKutDKAkL5C4tSr4I+HqPA87SMh4fk+bvPgb1Oy0L5J5F/rIeKJQfjQxDSoktEvJS9SgdTWZA0792Oi/269CbdlMHsk2J931tHPTwgxrykTxMmvjmnbPSnBIwOtLOY8QR1mv8ac4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmDWe+aI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646178; x=1805182178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uoPlVxirncNVZPLBBxahnmIKF66jaXQoGXC4hv5vQlU=;
  b=RmDWe+aIf2FaeV574x+sJkpfveUVmscIA19OodoOUYC9sO0f+tzXomf5
   VIO6GaCQNnI99qTJ8nRt2zx9P5/CNyGKwEugkhETK8UqXS2gejVKFzwqu
   jz2WbcQcAnSXNX4ruD8qAeG4a1+bxTapqQRyjorbLWBiPtKSttW3E9xVo
   AS3qexnzNzATeuzRDVHkT4rK7zTSoQW6nMsEXGzqomon85FJWkwwttIrj
   uMvK861MqaudPAV4lwyYHgIdji/GpvXRUag/C0D1ZyoJ78PnNVLbczaD1
   s5sv1dsuUv3LPLXiZxRT6xrWTnvIGXTfFy/VcTH+zoGi/Bx2AP1p2wqU6
   A==;
X-CSE-ConnectionGUID: NLNxSKDyTwqdXk9CzB2JrA==
X-CSE-MsgGUID: TneoQ7ttTp+YvW+KttHKFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85355924"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="85355924"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:29:37 -0700
X-CSE-ConnectionGUID: 2P/FXl5IQ86onFmHdCLFJQ==
X-CSE-MsgGUID: Bya5xwgBRLuVy0k+nLKZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="221060260"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:29:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:29:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:29:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:29:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUPlKKiQu00sX2gVkIxhuu9jYE2RW3Abz5cnY25K7/Uymhcug+1F9TWVFDbf9Ww7Ry20h9k2ksTsNWBx06vQCUDyUF3kATSBKu2aAkC8heVhcOCCRSWJWvVf8mko/HDH5bamvZIs82/WBuEVF9gq/bs8vP6fDHtq0gd7RzRzxo/47ibBi2qlbAfPV7v47KpB6ifgWI8B7zyIZoViHPWlOzjU7y6Zu7Dw9wJSyxzfblnCPhVhltC/njzYt9g948kizoKcjntv/aXMnKbZ0fZo+dQpgrVJTQ5UvtQcnW1lq91tZTVupSfLE0Dx9B/0/tO8C9UPPYcVF+bWk4TO1UoZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn1JPh1Lw93byd8AX2fJxIdjhuAj17IXBHwxU8lzXjo=;
 b=irGiodNdItnq5Pe/Oxs49wr0XaR4kODPbo3h1XX4eNSULPOKvLOm0iwQHINNS2KkmxnImXtsf99Ux2dCPbNhMKD8n2ZrKmVLGT/UIZthsIXE0pPJDwmq+oaQTJVS4Aiu970sIFPBNtQQqS4JbjXcgMzZNtFAs1WcoLy0DBZxsBZaqZqBgm0dm+yISFILvtH29A5APGbZ6TguKIvLBjO8D2JpJTK5ohHriK637LmTQ8M1eUvzLXodwDFyrfAFiMt05MyJ13cbnSzlnMxNPEFxyb2lMYDMS3mwJxzjPhAnyuIqe/0pUpZb8CxYaq35cNnTSlGZjCGeCYZ6kKOVsJPoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 07:29:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 07:29:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: I Viswanath <viswanathiyyappan@gmail.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "ronak.doshi@broadcom.com"
	<ronak.doshi@broadcom.com>, "pcnet32@frontier.com" <pcnet32@frontier.com>
CC: "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 2/7] net: core: Introduce
 callback ndo_set_rx_mode_async
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 2/7] net: core: Introduce
 callback ndo_set_rx_mode_async
Thread-Index: AQHcs+B6WrE5DQUtb0GPC6zWAtr0kbWwxNow
Date: Mon, 16 Mar 2026 07:29:32 +0000
Message-ID: <IA3PR11MB898648FEF177CC255829CCFAE540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
 <20260314182809.362808-3-viswanathiyyappan@gmail.com>
In-Reply-To: <20260314182809.362808-3-viswanathiyyappan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8560:EE_
x-ms-office365-filtering-correlation-id: 6ab1fd55-2cf8-4162-1efe-08de832dc458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Cj52HB/W0obBZvuMFxgoIiWB+8dvEgE8jWns4l8g6R1raa1PuKL7QzQprVh8uVU7k3cm2bHV9yjc5lIVX/L31rTrtdIhNVoJrxpuHW26k/TZatfIEIpgu4eSRjMx/fsHBGlNtWq1MxjWP7/Jeja5kJjKSXNg1GC+Eivtjn3SzNSKHNMUVuDhYnUXaTCCS8EeGh0YRYT7ezm9lREJUkBRKfiv3YzskQXyxC1fQ3AHPJay5lZj8uD2GA2n7lsHZlvVKWlAPDDhdJaIYqs363hbdTNUuwHpDoqVpmwtiugdP47QHFU5GUQ2pVd03uJAyRdxrlGBkA1V5+JYHf6GicmnZcf7KkiHnCgRVNGmM4ynBWAVFJAdxvIz1DHj+HhAy+oClLBxOh0UMBddmqLhtmgh5xpN9w16qbZytwD3vosrTFQVBxICqeXDozQBBYQc2w63M4/AeN/HinEU1aS1YJb4m6ouQK8g7LY+7rFQFlITCsxpWqAzG345OQBjxP0Ny9YHfSEyRyP0abIqamXZelOf4Usj0qGZ6Kr9Mrm2uIbVBoKhe5i4f5w4jncI5Nw+o8x5MrGIjmw1FAuqzO+VaWojGNuIIIewLh9xuSCZEqaQNQG1KloAKW3YqbkAj18x45G5aMIDjc4v2XjVeaZ/0drnCqXsnlVdRY/BKW0ImRS0SYGFglRmScpsOMHAdmMuxsDmod8o3xrwODj/GsGDKFMDsbwfvmAi8GM3Q7rVSx93mzCGXQ5AIRd9020dXLO+GOLgwa9dg3HoCgJyLTxl/FiRG1OwLmgqTFWFE2997vVGhDSy6yraG1+ngNmUWKWeITx9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b2sbiYQluYu9uqq59WWCdYv099iuN1DroMzxQCPu54UOVGQQOmcQ8AZTJoB1?=
 =?us-ascii?Q?3aQu2LhKBLou1A23ZoivnUFXVSEAuFO8o6W1cuzVS1PpBadHTo8OdovaYBE7?=
 =?us-ascii?Q?Jy8rvwROKng2exDjEj5ElacCFZ4mExI/OBAB9IijvDVFIFjzNajzMjPbkx70?=
 =?us-ascii?Q?VDAwLQ1pUaJrcVVKAe682+0LME5pEFMIWwQqAlh6j+zRD9Eqok6UnjskFPNJ?=
 =?us-ascii?Q?I4l6NSA79pw6OoYI3NEb6oHJaGamVOUxu1SwrmRxe83kNA6Hz2nNz74B8z2b?=
 =?us-ascii?Q?hcyLkTlvIfCCa9Xk41WaYNR84hdPzwCUdfHUxSTwnTTL1KGbSwUZYO580Ulq?=
 =?us-ascii?Q?JZTTSpGspn3NFvSx/0DBzcpC9eH1h97pksMkc6+ba0err8xbZWGtx34acFXP?=
 =?us-ascii?Q?FC4sitsRcU2N4e4UHJr741tlK88CV80cnjTzziVVYwk5bJrXF1vVkitC6Vgh?=
 =?us-ascii?Q?XwueW5u3oMglIbXo1+dy8pUPCMmh04u4KYQ1F+5haAYwraiQ6tP7fT293R5q?=
 =?us-ascii?Q?bHb+P4tC4TScnuhlnc3aSjzlbB0op68xJ4bgapcORVE8ZSDhvxQe7gPnbhxb?=
 =?us-ascii?Q?WDS6o/Rxy9XH3oOALFLKWhvxYi5S/AaYM3KgsskwMVMBeYHOypmIgWeOk2lL?=
 =?us-ascii?Q?9fpx+t2e3+BOzvzZuiFF6wYqyunoLCeLAo5/qdifVvkF2Vjj3KeQWEkmTWIp?=
 =?us-ascii?Q?9EesYdsv9dIEwxbpN8Z+3qLQOO8Py8i0bO9ORq69SRcSYpuGNZDDu5yx8kxV?=
 =?us-ascii?Q?gVSaidQGrRIPYR6RhfDtlpHBu114l1VeEaAnj0JxXbhjlYcX3pf9s5p2xBXL?=
 =?us-ascii?Q?Snyyu6iZFtkkuIauRttQ/ThgIX04upnr2nQBabrQJ6CZsyAvoDxBLVYPSw0l?=
 =?us-ascii?Q?RwxWFm5eylaaJTABLVmsNBVtwtQxp4vUga2sn/gQUjNf4xo/kgZ7rvs+wqOy?=
 =?us-ascii?Q?LHbDKw2/kN/adfxCfCqcqOYcvcR04/OyftsezNsFrXhrd63trpATtemfSDKw?=
 =?us-ascii?Q?F0DqnOEuIKmhbC9zyWYYFKSzTNGHmUHKA7zcBDCiw1cJjch3yI3sEUtCuuQe?=
 =?us-ascii?Q?YtdwBQxig8Ob61ME4aTLuc03PerhEXURc8XaMdOWbtuO7aC+C6IT4g9wEeIk?=
 =?us-ascii?Q?jqqxsN8EBPbsfYHSmhixEUG+Yudc7nxNk1AxpR3iQDC/Dc0SJoEt/hfDwYGq?=
 =?us-ascii?Q?zghwyQ6ynUoDCFybdjUkjlsmuHlHZCSFXNURyM85OtP8QZcMICKa7NrhSvB8?=
 =?us-ascii?Q?rq5ICFuck66CU3feyqdxbSU1M3PmAGyGhu+2d/nVEpAv7dFp/xEUWauY3vrD?=
 =?us-ascii?Q?kqMtm4upatKeZRQn0i6gIzrm2BSBquDFX5KvFwbC8KUtdSAWH9y2pVFOQ4jB?=
 =?us-ascii?Q?pTOJN9wm04tsZSydgrpdaEbawoewfvAmjOOWj57gRCFp7v3ac2usQbvqOudU?=
 =?us-ascii?Q?802lvYTigZiYRnj9+hfVv3GaXC3vasH0eeLQRyXrDavrnAWt00UypVTzz7e6?=
 =?us-ascii?Q?eo8fE4fu3JysDQ8cU4598wGEQxHNwCCzPxL8Ldv/k/aXrRJSVHLu+TiZmUVJ?=
 =?us-ascii?Q?JYgqHIrqKeBkO6qLIx4iG8GQzsBXgBLsNWp+al2l7lypoqaq2CTwaD/2vb2n?=
 =?us-ascii?Q?sF8uDvaItGCq+RNj7x51333S3ARxzSw9iy5+xdqmQN+52J0GXUerjIPCXx4R?=
 =?us-ascii?Q?Phr/EnI1QPJkwQEmrZBkBuEpGLijnjnYIaXKBTUHIrj/7nocp6pt56tXaOXx?=
 =?us-ascii?Q?vXqkK+4+q/tHtNgNVMrJWzCoH7ydoTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kuwv/v6VSo4DNUg5l9ETBVm/AxyQ5a9k22N2Cju31hkrE4l4Vz/y+Qu/+X+m8nVb582aPopS9r4WBJvOJJg01NEB+rE/0Pmoik8sUDX2DL2ore1V6ejIi0oTQuT38TLbfWb47msI11jvtKqXs79lHaxIMzV7/rP1cwXCwnDwk1VH3Qu4c2rjQcK8kecC543tVpkJpK6XOHHl7aqjnfZSQJizgsC8tvsKJl0cTY1nbuOpK5xSyiWW0KurYh8S9/KLpCQVmZYnzop9nL+1+Jg2NRLFvAUMYDcPd1laqN0YTy1SgrLxOxQF+M8fFxMoFm1KBl7eqZ17zhRoTFtxxxa8Nw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab1fd55-2cf8-4162-1efe-08de832dc458
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:29:32.3547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHGAyYrwUI/zHTXvvqXzmng99X+EKasgVBx0Bnr0vdskytsJtsjsm1jI3DHxRX8ZK2UGfO5RXKbK+hHchsDzBHN17dRI6tMdY9oZAwTSbS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268038-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2ABA12959BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of I Viswanath
> Sent: Saturday, March 14, 2026 7:28 PM
> To: stfomichev@gmail.com; horms@kernel.org; edumazet@google.com;
> pabeni@redhat.com; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; eperezma@redhat.com; xuanzhuo@linux.alibaba.com;
> jasowang@redhat.com; mst@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; ronak.doshi@broadcom.com;
> pcnet32@frontier.com
> Cc: bcm-kernel-feedback-list@broadcom.com; netdev@vger.kernel.org;
> virtualization@lists.linux.dev; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; I Viswanath
> <viswanathiyyappan@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net-next v9 2/7] net: core:
> Introduce callback ndo_set_rx_mode_async
>=20
> The set_rx_mode callback is invoked under the addr_lock spinlock which
> makes it illegal to sleep. This means set_rx_mode is prone to sleep-
> in-atomic bugs as drivers have a tendency to do the I/O directly in
> the callback.
>=20
> This problem can be avoided if set_rx_mode were done in 2 stages:
> snapshot and commit. A handful of drivers implement this idea by
> implementing the rx_mode update as work and scheduling it in the
> set_rx_mode callback.
>=20
> Implement this idea in net/core as this is not driver specific. To
> facilitate this transition, a new async callback set_rx_mode_async is
> introduced.
>=20
> When this callback is provided, the set_rx_mode callback customizes
> the snapshot creation and the work behaviour as required while the
> set_rx_mode_async callback is run async as work and commits the
> prepared snapshot.
>=20
> Apart from this, the drivers need to be updated to have all the RX
> mode updates pass through the netif_set_rx_mode helper to ensure
> correctness.
>=20
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>  include/linux/netdevice.h |  94 +++++++++++++-
>  include/net/netdev_lock.h |   8 ++
>  net/core/dev.c            | 251
> +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 347 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 6d426dc66af9..a69377068f4a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1068,7 +1068,36 @@ enum netif_async_state {
>  	NETIF_ASYNC_INACTIVE
>  };

...

> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

