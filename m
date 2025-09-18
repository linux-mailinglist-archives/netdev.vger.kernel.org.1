Return-Path: <netdev+bounces-224308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007FB83AD6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4491E4E04D9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47242EBDE6;
	Thu, 18 Sep 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gmeh1+oP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DAB2EBDCF
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186254; cv=fail; b=Xuft9VsLaHdbGwzCDG5YvlPho6HwctPCE37ixfg1HmFG98/QT7l9BKEEpnW4FUgDZYkFLoKmjr2V7uThLmugLEqL+WGGILxgxqVij8wGKytPc6HASl4o1Zx+yJBIdpRT+MbQZR6LSay9F+Mzuui7sy5mJutYeN7QEGZ3nh+5DlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186254; c=relaxed/simple;
	bh=WqFPca2Vx8N2zGJGapevoaT8Z2WOKmIyFn5H/3zwuiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTiWe03YctRwV3erod3ZRPgJLs6620wfx0b8PS7Ufr1scANC1uGyBpYu1C/CXG13a60w//G1ex3oyEbK05ZZYF49cpx/WQA37/bX/ubtaKboo94VSo4Yye934buc3Of0EALS+V9WaAYMGwrZ3VPBEPsMNdQxL8T1Qeu92Cvm/YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gmeh1+oP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758186253; x=1789722253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqFPca2Vx8N2zGJGapevoaT8Z2WOKmIyFn5H/3zwuiY=;
  b=Gmeh1+oPqowCuckxuUm7JHPdCIDUr3Ftx0khNBJ+SWP4xNHhaXe4kAe1
   5CmUVCF0nBhlzJigM/6N/6LZMazQffqYjOqiKN4MpV8qofM/MCfMpl29K
   1wqmyo2kOvO0E2elbn2+BXvB9cBCIoLwyFfC/06GoyVxH0Yd9hg8+7MZa
   k/x0TtaWZXf5sSAi8Aq2JT5tItM7reSgNJ1D2D7XQOnXPJr/p52VHyOn1
   WyhQJPfZN8576inKs+yF+U+pUDL8mf+J5oSntXSf/Tr7JXye0lQqt8HAW
   vg4ZFAuxtwI1ewNM9GVBBsUwt6NimG/j/fCDyPWr5dMJVX4Iz7/Qc0eHG
   A==;
X-CSE-ConnectionGUID: SCgQm7t2QLy/wab0MCqJ9w==
X-CSE-MsgGUID: fpGibjIRTP2oJpSAo9yFXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71190787"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="71190787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:04:11 -0700
X-CSE-ConnectionGUID: i4wqGRZKSvmkM6pVYojE8w==
X-CSE-MsgGUID: Fh49dVQlSz6m7gLNOG5g7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180763754"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:04:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:04:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:04:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii6ZT82GpV1HxjqxgDUNxStmbGyAKzhygg50l5232pHV95MNkY3ldItVw8orGq7NAy3bjat3ARqUBlk2GujB5wCG+o4Yfv2hlOPVVKWRPdsQKMpGGykth6zwDKgzlrVATW8T7hyY+vAHVgLLV/XN+i3sECbbjzpfEyEboHdZbk2eIzEWNjCDQ4mHDZn18oQqXfbNuRPbg9IUMnzd81JXB6XajyAzpg58KHcEOW4y22iVlM2SxI/ca9pp64df70VGuzATyw0qjawBI+Y1toOm4eaCmDI0USrQV7l/wxkoFCf9PC7Clm534ltsPGxJ+y2puQ8qUPCxqWvQgyLNSwjyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqFPca2Vx8N2zGJGapevoaT8Z2WOKmIyFn5H/3zwuiY=;
 b=mo5Vv1NsHmLHRf89rcnl4o9xTVWZnLUY2aKuW+fnNRU3NLPvBx62NrNFjkM3NUXiVDT/3hu0wuxeoTTfVpGaIS9VX39K2SKaYZOSxSychRQKe8hCDorBtNJgwtJ5kPbA4N40i919tZ39q0AMlebsA6I5cwSoX18KNQFY7ZSbiiuTX6Nt9TiWcXGoWOcoDzc4WPvQ+qbCjtYK4LKzBHp3fkdUanDqqXt10jkep/1CkHpI0tQ+dhkH636jUFiT7zgVyeYbSMbvlx5Slk5dTV4nSseW8eoWdDxCEpxp7moPM9UgnHfOinZy7zaC8Lo+JrhZSz4ipXsRg7g+vtJo8V8FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:03:55 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 09:03:55 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Kyle,
 Jeremiah" <jeremiah.kyle@intel.com>, "Pepiak, Leszek"
	<leszek.pepiak@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 6/8] i40e: add max boundary
 check for VF filters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 6/8] i40e: add max boundary
 check for VF filters
Thread-Index: AQHcDD+FtID196lAuEuNRHp/2Me0QLR1Nq2AgCOnG7A=
Date: Thu, 18 Sep 2025 09:03:55 +0000
Message-ID: <IA3PR11MB898500B58347714B6F4F85848F16A@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-7-przemyslaw.kitszel@intel.com>
 <20250826163635.GK5892@horms.kernel.org>
In-Reply-To: <20250826163635.GK5892@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: be4f1940-4ee4-4e58-42c3-08ddf6924ba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PwbPD1oDbTV/W8wceQj1q4WScpS54tig4ZNGYhxhPnX3luCaLIFfi01mhxuR?=
 =?us-ascii?Q?4n9DlTTFVYUDEI3txKfc3cO8LKc/xWKN3np+BseePNe6tX4xJgxQrge4CIoj?=
 =?us-ascii?Q?7Krmvswk7+TLuVydNnSMjKLbIUxx2BVIzTWkEtOKXA6k6VH+n+f4jhnGyKmo?=
 =?us-ascii?Q?zeu1QlYmE15rOTT2X9cPGs7nmUNm6C7FkjSIVbcl9GlKxHnPY0N4lNbbIUz5?=
 =?us-ascii?Q?cRjwG8ZZgZpP84QC60IOeKR//ebJ+4DE0mVzOYY3DN9iV3XOXpSRxytSvFXS?=
 =?us-ascii?Q?F/dnPgPX44cy9BfFDofJWHsxEdmUWbDoSVzlQpEKcmGqaNTzkuiqOLLcGpQ7?=
 =?us-ascii?Q?X3zmWBXNpbVGSpSgvVKfeKtfb5wS3HVnadOuV1PW/0pk6IEmqgRkW4Pl8vWf?=
 =?us-ascii?Q?Ws/DsVJLMUEMIx+IKB2YQMEYkNk3CREM47+mUhIa+MKCZxGnpgB7XBiIpAB0?=
 =?us-ascii?Q?u3zzPL/90aDgZX3yN+UIyxzFPp7C9ds7f6L0S59SHmfcXic8QxqzNtIo4mRb?=
 =?us-ascii?Q?ca37b18OQik4zd3+EsXJiK1clcRWWmsjh+/0wJP9H10zMgAQR9zkjyOxSykZ?=
 =?us-ascii?Q?/TbtJgevhVFbB+1E/tRX+s6GYDs4hRw86DFjOEljkDe8mG8Gkny7MrqQTCY4?=
 =?us-ascii?Q?MTrWCi6wt4waF85rp3lER2wE5slBNNmR2XmDylVxdQo/aOhJ7DO5c3bWoYQc?=
 =?us-ascii?Q?CJvbGA5DYARU3xII2DVpWsqVA9pFudW4aqsVe2KOi4FTDX3TajiHc/GF7iHQ?=
 =?us-ascii?Q?B1z3kly3ktY5GzsuaNk5e12t2VVrXFTlR9hWM7NKdFCQ7Dh7VH59SP+ul/+H?=
 =?us-ascii?Q?vKV8fO0UKbbSiPGK1u8oo0szFGiAcY65sEYX2RgXamghjDLouWQq4DaZ5Qgz?=
 =?us-ascii?Q?82Utu8IlJ8EIH79aaxj14Z+PmIzHbD/Dtjq1jYZ2rlFR+DtR7y0rMMjVFz7l?=
 =?us-ascii?Q?+u8zl0MFeGOhbLasCbKHqUb3E0o1336sdQCQN+OOwyxUHsQ2E+27+cdlVNtX?=
 =?us-ascii?Q?2cTvIn+5DeraLiXVYSAY5141pMKSgq87v85oJgufMwlBa+3X6qN7ex/eG3VY?=
 =?us-ascii?Q?rIvgkqDBIFuuW31Cj0cvW046kB48tXHty0Io6LPcAcOpaSZ6ptIz81snRGMW?=
 =?us-ascii?Q?PIkbRD06kb46peMVz+DSIaNMw0q26MctFCvGYc0uHMg4fHQDtxh1PmYSbuK8?=
 =?us-ascii?Q?RkNWBd2Gwo+tX+T/UajYWIUY6eAytpsqcBVDhqqdDmfghPVZIQol+Kv8mzJj?=
 =?us-ascii?Q?tQJKOjyU4lT2B5phjEnt5hqp4CIf32nt0eLwze7fN86JF3wBZ7aonzjSnrz3?=
 =?us-ascii?Q?hdsvw/Wi7apNFoU30DNZPR39GzZtuWoe6gzcn6H74i0yARowKRUl/4L18IXz?=
 =?us-ascii?Q?CkMU8s7kJs878MVLxKDndxf3W0xDXsTFu/sTuMhwz1YQkYhjsfDeHyOJjwGH?=
 =?us-ascii?Q?BLaw3VNzy6kauiO14egxRJqiCArT0B2MwoCBVcKDy/2adKHdTLiTIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lr7RFs4/QEMHkOEidtGwfLDfxfc/9IofIoLJGidPowHy9mj3vkl7rzEs6Snx?=
 =?us-ascii?Q?1QY5XQF7z4xbuIbGdYn6OlhAeIbeD3n/uMiIuKjTtbFIKkW8RcorayC9SefR?=
 =?us-ascii?Q?mkC0L9iS97Qq7EloQ04VQMsiHFIn9DoFIlTTlg58slvHQgQGKE/00s138wle?=
 =?us-ascii?Q?zQ7ALVMOcHHRf27U8A9zk7+TNbqRQxXruvWimpZOcrGivuowWefOp+LRkP/L?=
 =?us-ascii?Q?krZLNCpNVdXOrbIiOaWAf599P5SpWSPGc4MNVp5g2yGHBv35yLAtZZ/IJ2Rj?=
 =?us-ascii?Q?NaDJCdjw+UeF6hHu+GFmxvZ3YD3E0/hKzsIpiIFqCrjUOg9M85mk7u75wJdJ?=
 =?us-ascii?Q?j5CXzF+9fFvFdzfF5FFgbYCJDePjAelmPxmoWnu9aPN4rN+18JqoeVEW+aXo?=
 =?us-ascii?Q?6sC37bnZwIIgQAx9u/1dt8wdjYyRLamvUP0lZ0NhXg+h7j9ACkNwFziz6apl?=
 =?us-ascii?Q?p3XrcrV/gGhGz/eqpUU6btkbBNifztngNnTjNWb7UNIF3GL6WCJHlhJWjaXl?=
 =?us-ascii?Q?pxX/fGeR7hMqofgem5WgoBljimwmRxb0F9ZeSBiCDUskjo8XJVHZaCSD95+2?=
 =?us-ascii?Q?mt1/qpmZFalXFUPaSvL66iaMHZ7hEpfpf5qqdS5H6VgPQp86RShRyxB1Z9Xb?=
 =?us-ascii?Q?q2I9U3RW6g6pzIHN/REOdf2+QCOlKlhxv69k+n5d/hBpR6qAxJFDAas002kA?=
 =?us-ascii?Q?zk54EmItnxRsMpgoe4sBoHfrf4mE27BBFdTQv03axJ0lkju+1mXc1EKuCzN6?=
 =?us-ascii?Q?kB74k2vW+Jbj6fhV+s/78imD2q27DxF5PiqR5JTiU21CVM7xQiYLC7C1JGNa?=
 =?us-ascii?Q?BE7QVq8DxeKd44lBdkZfgY/VcNS+fKPeL17lTl4pPUKacjIzQjKvD8ohevYT?=
 =?us-ascii?Q?8rhUstM/maxzI4DSsM8vYW7ONG3JpnYOsAP5FH9CFgWI403foZQt6veQJl7w?=
 =?us-ascii?Q?4CQfPsKDuK2e/W0lt7/7E+SFoTnhQXYJEzpA2nZgfyw9hsfL1KQC4QDioGxz?=
 =?us-ascii?Q?GjDzeuSMqma9FVxsSq1kpgqu8fY2CQb7Ly04+nqMldeT6K1RHv+iT8s0QoXH?=
 =?us-ascii?Q?tDppbqzmBfnahZ5BJUJ3XlfAFP89x8HS9sv12cR53qc9BYqRmp0ETBCSBtbM?=
 =?us-ascii?Q?2JH57ma05VCJvuMiUXtfoAq/gzZnRG1ixYs9iTI7GV5OdZymrvlqgRmRmPlj?=
 =?us-ascii?Q?TiEDqeT7vaGxvEX4fQstNdl4EcL/JI5KdroW8751YdE1vzMXNwUWOAOjJykA?=
 =?us-ascii?Q?q27dbusPJfY6R4Zetg/AiTcRWXRUSpfyWIFBrM4cYhgL6xz8ULvBmdsbgSzE?=
 =?us-ascii?Q?W99Xry2+ye1ey7cMzcu0uOiRpJLfjqY3gjWUzA+Heh7qHj6KgkrZZiz+JLt4?=
 =?us-ascii?Q?DEbyGcMtq7Lk5KxhzwwF/cy41xx3TdCL74Pk96vDpcgao3LzLYu/05VzvKMK?=
 =?us-ascii?Q?rrJhPMsAERGB+ANCIvQH2Vypki/xZ+bhOPzR+b9AbuVeTN7az7v4S5Uwzg0j?=
 =?us-ascii?Q?BcdkVNfRbn/R/0nyQJ1PkUxLQu1f64Wd2QZ6dVgt3SLMZkbBblkwjE1eD7r0?=
 =?us-ascii?Q?Vlt64QnHyVtvt5cU0K/xa6YhtiGRPuWC3KUzV6uXCyFFFmQUaJmSAU6xdpVn?=
 =?us-ascii?Q?5w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be4f1940-4ee4-4e58-42c3-08ddf6924ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 09:03:55.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diPst1TkhG5Ih5n8c672mXR7oLZxa/DeMj21yw/YY9MUoLyVN2BS6BK9SPiNRCfb+Mq0qeyIczskvvEDwpJZniQ0hFfEDjko9fF+qY9lCFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Tuesday, August 26, 2025 6:37 PM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Greg KH
> <gregkh@linuxfoundation.org>; Kyle, Jeremiah <jeremiah.kyle@intel.com>;
> Pepiak, Leszek <leszek.pepiak@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 6/8] i40e: add max boundary
> check for VF filters
>=20
> On Wed, Aug 13, 2025 at 12:45:16PM +0200, Przemek Kitszel wrote:
> > From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> >
> > There is no check for max filters that VF can request. Add it.
> >
> > Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



