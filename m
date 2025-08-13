Return-Path: <netdev+bounces-213291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B8B246EA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E9A3A2C13
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365E2BEC2F;
	Wed, 13 Aug 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpAehuaj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931521256A
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079789; cv=fail; b=gwG5V2FgarurMZKAVSUXcVc6/e9uKztBda9haU/oHvoGDcx6UC7UntM2PD6YdWVATeS/jhhvDL0SL5HQdI3OA+ipIbnzAQlESa+Ho5rYjeAYWVKIJDykBSEbPyAQqNxT8gBvFeo3AQcGlDBe4uIFdTmygumsmVM1DMgaf6VbxM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079789; c=relaxed/simple;
	bh=JE8Hh97XIeDjEat0aX3hJN/5iZVuL4q1Cl9/idL6pNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4DLaNR8ZRCrKg5Qg4wCPWsZ/PHfqsXkpFqAS8uRQU/R6k8u4qcA3p0dWG3HAtE+YIq5oeEpjNA+CdmN3qJ3Kko8AfVp54yMpZM1FiMGGOwDekYy7fku7r4B6nvgS6MK3jRSn3x1GSGQpoaGR62ex8WJSIMS55hMs1nTNELdfcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpAehuaj; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755079787; x=1786615787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JE8Hh97XIeDjEat0aX3hJN/5iZVuL4q1Cl9/idL6pNw=;
  b=GpAehuaj57DWI/Zqwp4+ZbPtEF2BRnho7SrUIFJu+Ex8duM5GRrSt/9h
   b/P+eiJk05i0XhRnUDuqjsKTqpm+t/2IHNNZ/K5Izu+hpIQ6y0J8R2pJb
   jW9lN3uE3o3T9hNZlPjvfKG3od3A8AariRZSkacnRVNgdmfx5w09xaUHE
   bHA5xnNek/2QSkibbOZ+OUEo1IGvGDTMyFgJX3WGo334rzDSBkGR+qStY
   kXPTutvFoUqkyJ07lEHAuurcqXpj5IExYei9fxAo2NLcQ7iIF9YYokWz/
   p/5K6RMmFIUhKndLtWY94UN7DyIYkVTkwaVHZ2IcH5KMY7mcLlX3LJ//6
   Q==;
X-CSE-ConnectionGUID: sNSCP9tUT4+KQRGXmLBoMQ==
X-CSE-MsgGUID: Lq0SVxcuQLWJVjhiGlcE5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57432758"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57432758"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:09:47 -0700
X-CSE-ConnectionGUID: wFI34piwT2GDc34ayyOwgA==
X-CSE-MsgGUID: YaNYw0VcRFuoZlcYtxfluw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="197290726"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:09:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 03:09:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 03:09:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 Aug 2025 03:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZGux0xfl3lm2vuzJevrzUbp1LQ1zR+NUUkaQBxJBALd5BAgjl/fPckyP027jxO40h+ttrdj898GHMbdmKmtE+4+ZOdbvQbSEy7Hviciux1y4q3IV9NP2Uz2CxhoFHEuOcM+gPht8gjL4qubT07RvsWPNUFWmu2bIwGj08TntX4nr6UWBFOIer7ozVKvgSVx/kBtAnjRaX6vlWXAStf2VCb2qoUv5gZ0Lh/gGQYo5qXHS18ntFG3O+N47OZoh2DkYkebuJ4xh2roVdtqHq+C6am1DTTJrbP391ucLPDUSHxRcDeX1qi0bkDrSPlkNm/e3GkuhZXPFU9y3yzIr+KkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSBnc7+tks79ZF/NkprhvNRxJrcGctUxEi0FKi+cAhU=;
 b=O1le7Fc1+XPdvkpg8DnnS+fdabf/QAxNgepC82qJXI4mHsX/yP9yfTcCGv5aVtxrkyHTnFh/Q0DbZiSRV69wVUg01xNBTx/+2dJgowW3bHL3Y5FysxnkwhkHei+yPg0usQHROpahy85whw86r/R67yXmVKqZy3UYBiO5XkRf6c7nI8Ug6nyaSGLyYfwp7qQ+9fX4soRsvKJhHgv0/Pehzt0inb7uMuN5g52kzzolhHPZhZNuSCOgvyCw+ywcNFivgDWK3IACO+Lxm7V3lh8h9qNn4WihXlZs0GvGvfL3Z+FKPrmBEzl+8UkJvz0ijMMXZFzB7OfrwmKdxzppvH8/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 10:09:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 10:09:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery clock and
 clock 1588 control for E825c
Thread-Topic: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery clock
 and clock 1588 control for E825c
Thread-Index: AQHcC8fKoCcWfC0AmEKv7rWLZXKE5LRgXNdg
Date: Wed, 13 Aug 2025 10:09:43 +0000
Message-ID: <IA3PR11MB89864D7323B7E3662CAD765AE52AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250812202025.3610612-1-grzegorz.nitka@intel.com>
In-Reply-To: <20250812202025.3610612-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7524:EE_
x-ms-office365-filtering-correlation-id: 24fafd4a-a6c3-43f2-9781-08ddda51860d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2M4fKVxxpeuLwmrnNg9OwEoDhvjdBX4v1YHt3kWXFNWLq6KEq6ABjQPOZJkY?=
 =?us-ascii?Q?lfp7cv0SjmkwziNkDQFtv5dydY9nktPLP8XVU7GQX+yxUTyaGJDUEWYcocZI?=
 =?us-ascii?Q?e+RZR8HTRnaGmvH+iIuF+TKXTjjTVKpFAQLIUae62gqTr6WjcRgPI4m3ioLk?=
 =?us-ascii?Q?dqPlMJJtdTTyMaMPCw/BktWBROcFMjhmhWs8cpgQRsGN6Wem91/i4fXOywY+?=
 =?us-ascii?Q?7sKRSy/SAYmpnOcsq17ngLX0MlVT82X+T9SlWmuiZFJpc70GPILvpaEmp/AI?=
 =?us-ascii?Q?qNkFgtEaBNadHmKwFhYjyJaDfdn3cN+bVRk088C4t+PPijrsVn/3ubBWEuN2?=
 =?us-ascii?Q?6hoRGdHZke6wI/JUZUCLodt27FwDVJpfJ7m0CAnaHRTINK4DHUJ6nt+oZ5nr?=
 =?us-ascii?Q?SgKT3kQev5/krWhZuST8jLu9vUPdXTocLFXO1NY2wVo5C8dZ4D9dBFjWGNeU?=
 =?us-ascii?Q?baxF0hl6fMjLyJDoDfXgK6Nxb5MahwuPckm/ei9EinsKub9wi9QOS4lObs8g?=
 =?us-ascii?Q?DbpvWF4pITwTLOp8rF3393mr/sXhWHmR8r6yMRdntpsZtSnBNy5IA3eUZzMo?=
 =?us-ascii?Q?lXMxztnNS75DWrEeZbMHen9+VAUDDSZFjUCtqXlTeOtstkTTorUzz7dudg19?=
 =?us-ascii?Q?lli27AJTFwX1MlfxIUGtNSFCIbzfR7zoycGTzA0FmYVcOxhTnqKbCPOLfv9w?=
 =?us-ascii?Q?YRMl9e7GRPI7Tx15qqeeceN4vOYXWR0gG52rPPr7YuwNTyQo5wDa8SLT0npw?=
 =?us-ascii?Q?CryhfdrGxlSwVDxgdqVDQgHYQWmuseRHOTlXGupHdMCpx+BroJX03p3MM9B/?=
 =?us-ascii?Q?VIc9VfEIloxYdXxNJnPc5ruU0AjxTnb0mfuFDdMKUrQ7uJtw90B/WNdCWHbu?=
 =?us-ascii?Q?+91ROAuFxi8YwnWnSIGN7iZDwtzdx/r7L5vvI8TS42qB6yBaT48hzMM2Qd60?=
 =?us-ascii?Q?TirvGlqOZOUVqm5sQ7K8pupgTRLzLhHTS9biAnpgP9cen6N8Kq7impX1ccb1?=
 =?us-ascii?Q?I+XaY0ZbAVKkGDP7wFPJ9dVS2vLRtUOIKKNnfr6/ypL7n/MPTFvYws/LAmED?=
 =?us-ascii?Q?T/lZmkKvQ5x9JR6Z9kW9nDiZTAfLMhpgFMekgsbQS9hG81N+V6OQ79ThMI5v?=
 =?us-ascii?Q?SE5NlvKP1VmZLY9F13IsyGxvNXUJUk8Er66FjxHwPhvBRD1GXapqYfEgbWoW?=
 =?us-ascii?Q?upQonlSJOLXTLcS4vbpHUgFrftzbFO9hKUkbU85YtapfAYL/5LxNR5jpqWwm?=
 =?us-ascii?Q?VYZJ04B0Xy8255ASwm33UJABnXChJI09MpbE58glz1FYbeLg3Vjsb58saidQ?=
 =?us-ascii?Q?frHMT2+Zz8TLD3bgdBGaQy3fRIsjNeBZuQxQIVL8ON7bgwrtkgx2v9HRwJX9?=
 =?us-ascii?Q?f6Z922SyviM7BmOBtfGs8vutelLj65FDpqUePyJtnN1bs3GQQfyrXIr0Nlzn?=
 =?us-ascii?Q?yoyL2eqQ9aTAu8t56gt/4qCek3p47y/4l9EhrgY1Izyw08pewUKvqnfhWuqN?=
 =?us-ascii?Q?IMEdbcG31E3ZPBo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HHBXGNPyJ4nqEfY1Qwkgc9Suxi/EO0118jrrrSMHLvkrICpYFoEQ20ZPC/Mm?=
 =?us-ascii?Q?NTM54BUSZZxhRUwCOEThfnsRdSWGnWN78Igj+6rxP1nURKvx1t+09sSvqt/g?=
 =?us-ascii?Q?nLFFx5NnDnocZSNETfQ6d2b4NHbbBITa9u5pHAU4WZtHQlM7DdnrgvLSDz6H?=
 =?us-ascii?Q?BEGbVfoUD/QRkhJrS/1lXLSz1lNMZW1Y3uOOe4I0YveQM/GOcxuLcr+jSz1c?=
 =?us-ascii?Q?s1X60a3oqljQQwyPq7bc92GTrH6gGsSAgwi2iKMDaLzRHyD3pbVzXpjNm4PF?=
 =?us-ascii?Q?tGaPU1T0CjlFwqLMqYZV26dcMbCeAtQsudYHirEW6TZot+ksuqxROnO1yLlp?=
 =?us-ascii?Q?smEc08Hjfl09ByDtTUAc8WJjGh1uRxb7WPudtUVBB0CwbpE0HS/BEfJNtSiV?=
 =?us-ascii?Q?HHyPfN0FHn8Ri8cB1bqOngsE+1YWL/oCnLwF09TF3xr+UFA6e4lQW3zec3Wg?=
 =?us-ascii?Q?lLvStR7b+FQGVBM50ri/L8i+Ovwtes7pwuKwa5DarR/MGqQPI+e3eMMfykxa?=
 =?us-ascii?Q?3O8jlKrFjMWF79UMgFAzTLLWrz3n5Ol/Z99ikaxGiaMvx4zQ5oQWlPSIQMp3?=
 =?us-ascii?Q?G3xQm4v3jA7puefll/rEbBqvnel1oalUHiNslri2tD0xFFOvxb5XJ1l59+MR?=
 =?us-ascii?Q?SLjgIy6LFj2P+pY1wod2zGG8mO8DlvQVxGbJqiCHkJO0Ex8H5AefHtNjRIMu?=
 =?us-ascii?Q?XfyvWKpU/QY7Cy7tEXZ7WT/DmcWpLlZ8GydDhu+GJQAnCeD+YaFctmZU2Vuw?=
 =?us-ascii?Q?wKa3IHzXSRZuVl878kuVo60N/XhMqbWy8DEk04FvlXhJBuk3uiTEUiDSRWhg?=
 =?us-ascii?Q?XLZ4ixdTwmhbLvKVBbGmqyLCbGFfw9yWAgsINFwuPoTCIl2J5Wlp6dnaQaX+?=
 =?us-ascii?Q?7Y1xDQw/31rQcglKBsME7pT4EgFcD0AxpJ9ayXGBg15nCLlNZIFH6PZRTp7s?=
 =?us-ascii?Q?SmTIja6CUZm5WYorqVM1p+uvMlnuZ2kKfYuw9P+NI/RRlyVEtUUjdDY4TnCK?=
 =?us-ascii?Q?iDfADqxB9SWmboGTCr6HuHhy5BahfpZqI9mw3ZtKZ9eIWG1F3AucYAolfFET?=
 =?us-ascii?Q?56bKQFPBS6n+cUGD3OeZpP1rYI2O+xFtQzCJ9jLNtpOc61lGieQAuhgbEuic?=
 =?us-ascii?Q?mGCDo2G+8FPsrCQ/0mtAp5msB04YaioYIr25CoUAI8tkvzCkgZkqQJp3cmF7?=
 =?us-ascii?Q?3bM33w/5G1/YUR9QrG/vwl80FiOhYQPFjHcAQ4X652ffbngr1lBSVF83ymI0?=
 =?us-ascii?Q?cryN8qH4nYLOFLTvTj70ChXkCYmTMO9cFG0UfyubVDeqUIQYU0e5+0vM6Tk2?=
 =?us-ascii?Q?064VC16IjXGhtS3IjiH+zlOtlI6/HzaeFrNfIudXB1lLyDuyqjdO4vK7rBwJ?=
 =?us-ascii?Q?3fCd/TYrr3u1MDjm861kQvCFN7org/5gwaX7HI/IudLHkU6PuOGD7Xy5FSNF?=
 =?us-ascii?Q?fmOhreTzXpxRe30/Oe2Xz7kbrGDz5Q2SrmlHtqJMDOj+KFjdBNakOhPtSryC?=
 =?us-ascii?Q?WcQ2KwgmI1ZkWMfzJNdzPHMz9e4pLipRuvQJe9aWhfuKSbIzrDQSEj1bmjh2?=
 =?us-ascii?Q?+hEOzZAEYl1JHv/9u5bD7EzDQELFzCW+dlshxu0l/H4Zz0uhI+2pii/Vyht+?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fafd4a-a6c3-43f2-9781-08ddda51860d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 10:09:43.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfNVO/K1RLXDlhpiiVKM8adV+cvbRitf3DjFqColoHc/wJH1wj4pwGs076PBk2Tg7z0ArczPJnydy5bgAfuNzkG+FvHiii+dEcG0ghJ6ig8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Tuesday, August 12, 2025 10:20 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery
> clock and clock 1588 control for E825c
>=20
> From: Przemyslaw Korba <przemyslaw.korba@intel.com>
>=20
> Add control for E825 input pins: phy clock recovery and clock 1588.
> E825 does not provide control over platform level DPLL but it
> provides control over PHY clock recovery, and PTP/timestamp driven
> inputs for platform level DPLL [1].
>=20
> Introduce a software controlled layer of abstraction to:
> - create a DPLL of type EEC for E825c,
> - create recovered clock pin for each PF, and control them through
> writing to registers,
> - create pin to control clock 1588 for PF0, and control it through
> writing to registers.
>=20

...

> +
> +#define ICE_CGU_R10				0x28
> +#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
> +#define ICE_CGU_R10_SYNCE_CLKODIV_M1		GENMASK(13, 9)
> +#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
> +#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
> +#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL		GENMASK(18, 16)
> +#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
> +#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
> +#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
> +#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
> +
> +#define ICE_CGU_R11				0x2C
> +#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
> +
> +#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
> +
> +#define SET_PIN_STATE(_pin, _id, _condition) \
> +	((_pin)->state[_id] =3D (_condition) ? DPLL_PIN_STATE_CONNECTED
> : \
> +			       DPLL_PIN_STATE_DISCONNECTED)
Can you consider implement it as inline function instead of macro?

Alex


