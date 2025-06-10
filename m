Return-Path: <netdev+bounces-196031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC7AD3357
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3125E18964F9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1928C021;
	Tue, 10 Jun 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/J15VIY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA461F0984;
	Tue, 10 Jun 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550469; cv=fail; b=fKC3QyIK787yEF2AvjIsMhL05JNqS9J1XVhBbYqC0D9YonR+EZtZ+mv4dWRCMIAOrSoT0VBNsgOmRsDsb/oj7/ZsAjcx5mT/SgL+UG6V8Q6Igmr0lakV4wIZAtjXU+yEvBZReqr5Jj1/XSmdOO0wplxZAkaINdvBXr6AJznntuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550469; c=relaxed/simple;
	bh=NAH1FeP0X3F5cLyqiOwn0XUPPslE1CY7BRMhZfVQSzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujFabqUkZViaJge9q+UOuOooaUpOLPP2S0cSncHPerzrAO0g3YkorLNV1E5BXMC61ACPW4zUs4XaWBQ5949u48hrgh/JNTS6ss/n6RFE9LVlEBll+6jmNpm6KSeB40f8jlprkscgmkPzck2vXn33mnboVQDtNann0XPdRD197PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/J15VIY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749550468; x=1781086468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NAH1FeP0X3F5cLyqiOwn0XUPPslE1CY7BRMhZfVQSzw=;
  b=f/J15VIYTu+Gn0enWUAJ4rJHXcTZ94PW6AjPfC7eruVoN7087fjP9O0r
   8fMOKUPvyp3a3A+OrFt+nBIAui2kE5WUsompEIKKqBoQdZEVh35Pn8Vhn
   /ZZ1k0cWeGljyc7cIUa5drmQjXJ0iDycvzb6yVSREKELG9+Oag0kgnAZL
   A9kzjlOPdIV0JdCQyuWiyC3XwW0x4buU/SUl2YG69VzqAQeL3V0IRx9nV
   xm+0UfsTwIqWF8YEU6Gx/v+cfWN+WlAPGKdJxoZX4r6fEBSeMcHYQQTaZ
   4kTC/dIWkuLTIeEV/4/BYbtAoMgXfk7JLHduSJz0LMrCf38Hvhh+Rg7B9
   Q==;
X-CSE-ConnectionGUID: rQMZefYHQyOjVyEYJan18g==
X-CSE-MsgGUID: X2yQWF9LT96uaJOTJxsMcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51530076"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51530076"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:14:27 -0700
X-CSE-ConnectionGUID: rNXuA/YuQumfmFlLLXCj0g==
X-CSE-MsgGUID: 8fSXTP+bST+IsUoB5gJTiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146714987"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:14:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 03:14:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 03:14:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 03:14:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAqbZ9HAioOL6+2xU3O6eFW2bNndpfWps6XuT+hXW+QfbxsZJ9u7cL0qXYooCOgbP34h43vZBbD1+0bGleVsYtJlnhmbcNg3hxfSSbRJFa9jA8j3aPjUi3h6rGQVwSCBDYfyqjuO4G7xjJDArp5qKM8wGAPAXWkrsSFhMYmeDUqtU5tlqs5q24J26xjZ9zyF7DstPN63ZjMFsB8S23ByC1fGCCwMP7wSebR2DYhJ84kXw02VeIRhK23Ci8zggJKTVMim/wZHOCmyztwC/TQcZj34KPnLb0w5WYAunhKFk3xKAxgUboEMC10ee01/xkRYjCULNFB0CE1jpohCJkR+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAH1FeP0X3F5cLyqiOwn0XUPPslE1CY7BRMhZfVQSzw=;
 b=B/gIjaFVmYW8Fh5RQuKhVcWrycaCm/YFLoF7axph5hojJa4O1GCleKEeLvG1hDRI1xPLLqVqjEB+zeio/ThEMpY+BYB63ujIevedEcMGs7pY7TbXMv6uuv9dvsQMuIidJCiVjN92fhodjtJwZdzGHN6Yd79RmrAd+lM44MwSvIiMg/8togx/6gvzmzdkxLu2XlCnG4Jj8Bdy0LnAPnctQ/tKVSdLKZG2P5Pj9CIIqsbPIa+29wv/V+BYsFL0Zwglydjzy8+GRevgpvcdNY6HZTDVuYXxg82isLOS/oK0K0MgHgH7dUqzU15Px58dekeDRpk8KCLwUKniVy+zhD+M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 10:14:23 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 10:14:22 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Oliver Neukum <oneukum@suse.com>, Subbaraya Sundeep <sbhatta@marvell.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Topic: [PATCH] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Index: AQHb2Q+P+xtcjrqHp0eA51vEw2F9rLP6iROAgAAKjCCAAZU6gIAABPqg
Date: Tue, 10 Jun 2025 10:14:22 +0000
Message-ID: <PH7PR11MB84553D5B8C97EDEF4BF277009A6AA@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250609072610.2024729-1-jun.miao@intel.com>
 <aEajxQxP_aWhqHHB@82bae11342dd>
 <PH7PR11MB84552A6D3723B68D5B83E4BE9A6BA@PH7PR11MB8455.namprd11.prod.outlook.com>
 <dc4e3500-b5fb-4aa1-b74c-c37708146c3c@suse.com>
In-Reply-To: <dc4e3500-b5fb-4aa1-b74c-c37708146c3c@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|SN7PR11MB6773:EE_
x-ms-office365-filtering-correlation-id: 03112c3d-22e3-4f1e-1835-08dda80791f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDRZbUFIdnFKYnllL0pCRVMrQVFXQ1Z6OWwyNklxa1o1Mnl3aTJPM1Z2WmtU?=
 =?utf-8?B?WUUwYzNLK0VtVmp0eldrRDBSTXR5dFlJWU95S2x2eUdEMFljUEVJbExmUk1P?=
 =?utf-8?B?aDZpUUxrZnhNa1pqTEZmQnBBT0lBcU41SXlGTjhHOXAwTlhwdzkydE9JNDlU?=
 =?utf-8?B?a0ZvL3JUL0RuWW5qVG40ZVFyTWwzVVBUK21xaXZvTTBkKy9CYS9QTXJSQVY2?=
 =?utf-8?B?ZFczWlpCTm1BanJid0JzSjhuakZTVXdxOEpTeHNJWW1ZNjJFMFl3aGcwTFFD?=
 =?utf-8?B?ekpYc215cU83L1NaNFpmYVd4RE0zeGI0UnUzdzhvZHhpSzl3a2Y1emhvYlg2?=
 =?utf-8?B?Tmp5MnQ0MTlBTDlRdGNJN0x3RjU1SU80bU5XdUE0MXF0YW5wRTJUS0VEWUtz?=
 =?utf-8?B?dXJ3R3VwVjJTK1YySW1TL0szek5oSFdkeWk0OXNDcHppRnd0YUtzVjNLOHFS?=
 =?utf-8?B?Z0U0SXo3dUloeXUrVUNXRDFSTHZvdmZ6clhuclBqWG9Qb1AxWU50QURMajBw?=
 =?utf-8?B?NzFTa0JLNFc2djdJVTZvRkt5Mzhhb0V4SkFuc1V2eGVSajVzR1U1aFBETGdR?=
 =?utf-8?B?N3VXMldlamRyUysweEtRSW92V0pUN0lBZUQ0SFRFTDBycGZ5WkhWTzBuVERD?=
 =?utf-8?B?SjRxdjQ3TmJyQmpRNTRteWQvL3VVdTdlVnp2ODR5LzFqc1NoT3Z0M1MzTFVH?=
 =?utf-8?B?UGE0ZWNVejhPdWc3djNCY2hTNTNQYjJ0Z1hrZUFOaVp4S0EzRWhFbGJjL2VB?=
 =?utf-8?B?MmpvcmdvUHVNMnpOcXJTYVZncEtPaW91SkhYWkd3ZkxidS9kL0dMWlgrb2x6?=
 =?utf-8?B?ZEQreUlGV3ZLeW94b21nYURxT09QMGdNKzd3WEEvTnZjWGlGc1RyOVFqUFM2?=
 =?utf-8?B?MHRIcmwxK2lYVmNBL3R0SzVwOFdNMWk4MnlxUG0xK3RTL2N2aGJaZVAxbkFq?=
 =?utf-8?B?ck4zTE5iZmN5UWgxdlhrMzdwWmVjM3J3MS9ZMkFXdmhJWnIwZmNsejlXQnI2?=
 =?utf-8?B?UVkwR0xPUXp2RHFxaUFLTjJVS3dvR3JHLzJsa1Q1TW5RQzlYUzlJTXFKOXpi?=
 =?utf-8?B?SklLN1dGNm1UaEZ6VENOMzlWSnVyS3BXRGdUbXdjdlFEaGw0TStjMUx0T3VP?=
 =?utf-8?B?TDNLV0FsSHk4cmVBdzdWdTJuZCtLYW5wd0N3NFVER2lwVmlDSW5GUDIvbTVU?=
 =?utf-8?B?UmZZd05XbFUzYjVBMGRvUjRQak4zcnpiQ0RUcEhQMnduYTQrY3ZYSzcrZ3RS?=
 =?utf-8?B?eFJWMFBDd21yeWtsL1AzTUhtYjF2b0V0YmxFSnQ3RGF3K2xsNllLSXhCdzV3?=
 =?utf-8?B?MGhwc09CdjVZOE1NU1hSRlpaUW1MVXdzUGUzdEdwKytoclFESmdkbXRSWkhC?=
 =?utf-8?B?UlU4dDVpODByTm56bnJzTHd2ZGFFOHJVVUM1RThZRWY3ZzVHbWhoVDBWSGpB?=
 =?utf-8?B?ekZoV3hYaXlPcTNEbTArRkN4a0lTWXZPeEhkUlRLZ0w0T3BzUjNraWJOVElm?=
 =?utf-8?B?MmpGMTZTT2I5Z2c2OHdUeUl1SERBTk1GbUlQdHlZVXpMQkkxMm5vdmFsNUtG?=
 =?utf-8?B?Wlh5Sit5THpya2xVdk1zL0ZSekFlc1VPenhuM1R4Rkh4UXRNMUkvd1pWZnBk?=
 =?utf-8?B?dHcxK09tTTBuaUNHVGRrVFRkRlA3SHA1cmkrTHY1TDJFNFpxNzFITGJMN0lV?=
 =?utf-8?B?cGtiUlVUVDlYNCs4Z1lRaVdWUHZmU1VWTkRNUGlWT3lQSEF1Wjl4U1ZiRVAy?=
 =?utf-8?B?MWFNOHNCUlJmdndpQ3huV2FzWDhBOXhhbElGT0RaTU9NN3ZCcnNib3BMeC9i?=
 =?utf-8?B?UCtuRkQ5dnZmL3kvaU92TEQ4THMzZS9zclVjOUJ4RGR6YUVabWpCK040TElx?=
 =?utf-8?B?bFVZL25NTGlOWlFTNWVaY25sMzd4cjFFaDRTT2VwRGl0R3ZWbzJjWkJxR3RQ?=
 =?utf-8?B?TWVTTzRrTWJTaGZiZ1R0QUE4WUhhWUNwOUVBMGxxUHM3eVE1cFBnSEExUDl2?=
 =?utf-8?B?dTJSd0dHb2Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS9ieUR3emM2emthQzBKYlIwaWUxTTRQOEJBU01xcE5sTWZRYlBjR1UzUlAz?=
 =?utf-8?B?Qnh0dkVMbkM2SzB2ZmV6RXlTZ3h5U0tmY2xkTG9IbTRBeTc4bHBDbnR2eVcz?=
 =?utf-8?B?eHZCc2pQcm9iM0F1WVpFYSttRUFxUUt1a0cvRGZBdFBtV09xK2NFNGlTNzIy?=
 =?utf-8?B?cTdwVW1qV21nRDlEcW9Wc3VMTXRKbnRFZGxoNzNaT3NtT0llUzkrOGYvNDBW?=
 =?utf-8?B?VGQ1aHlUNHYwZjJOck9ZQ1ltTFc4MzYrcDBuQWdkZ2FzRWRZMDNobWtXSkpk?=
 =?utf-8?B?eTJVeERFRzdSbEJLd2x6anlGVTVjZWJMbnRTaGM2eHJUeGRkUGZHeHVteFRV?=
 =?utf-8?B?SCtZaUVlUWxNQkRoTlg1V1ZianhsbTJVV3VMdUlMbTJWK3J6bElmWjJuMmEw?=
 =?utf-8?B?a0dkMjRTenI5blR3UEZSaHpzeEhPSTdSOEpKakNaSHpCOWNPN1RXdzd5Qyt0?=
 =?utf-8?B?R0VURmVoVTJTNDYzRkhQK1BjU1hUYVFXTVlpeGlhMGdjeC9CQ1ZkZ2pCVUdv?=
 =?utf-8?B?NUhHcVZER09JVXMrL0NuT3JSUmZqVmsxR1JyaUNsSUk5OWNlak5TdFlZRjBC?=
 =?utf-8?B?cjJwcWNOajF3d2JJMmc5Rlk5KzNZYXdoZ2RPSEp3cFlTYXlRVkdCd1FiZzVL?=
 =?utf-8?B?bkFhNVNvejRveS9JQk55dFk4RlVVemJRNUd3VFRpQ1FOakRHVTg5UGtmVm44?=
 =?utf-8?B?dzRqUzJ0aTh5MXhuU0FlSHNvL2VDb09jOVREVWJZdzhTMkNZY283NmVoTk1L?=
 =?utf-8?B?RXJuRkxVcHlkOE9reTZYZ1dMa3dzdjkwTU85SElsSXM0WWFhbXkyeVFwWEtW?=
 =?utf-8?B?RVYwMkZLTU9kb3NQUkJHU2dML2locXJON3NFK252b21RZWFuajlRL21oSEUr?=
 =?utf-8?B?UmdIemU4VHYrZitTeDhLcUcwbHNJZEw0VGgwdHNTM3o0eGo1c1VXS0FJS2E2?=
 =?utf-8?B?cnJzWFhRcFF3NllnT1gyNDFORlRqckZERitJWnVMb2RwdHVrcGp1NktkbUJ1?=
 =?utf-8?B?NnM3MEhvZ0Q3SXR3cWRSZytjZjdubU84dnFjbWFTbHpWVHNDM1NuUmMvYzNq?=
 =?utf-8?B?V0hESzhtVnZSdVo5S2RKRmlnRUhzV1ZDMGNmYkNBeHVBVVAxZVc2WE5FMWli?=
 =?utf-8?B?WXBtaG9iT2JjejJ3dFFoMTRRZGt5L21mUFFVaTRJalczN1pXNDlCdmZKcTR3?=
 =?utf-8?B?aUptTEsxRXdOZEVrUEVJc2VvMkxBNk1xb2ZTZ3RHVmFveS9xajhVQ2ZZV3NF?=
 =?utf-8?B?b2l3R0cxL1Zwc2JkZHp1aFZFZnlLYUMwejBSaEZ4Q21Ea1ZSdUdGeXRxcVpO?=
 =?utf-8?B?UTZqK1JwN2JCZlpxdEpqTzl4aE1aSmZUYkdDdzVzSyt3UWZ0OFdsRWtRNTZy?=
 =?utf-8?B?eFNrdkYycGpVeHBCVkRiMkdGRUFHbFg1WVNuQ09mdXR1ZHZHSVU3MnVQekdS?=
 =?utf-8?B?dXgzbmt4eTVMMGFuV0JRdGc4WEJBMkdocjZtb2FTVVJIenhyd2RwQ2oxSDJG?=
 =?utf-8?B?YXYvWTJrNytuanEyVFJsVWxSMytvcGxXbzNNTlRsTmE2cXhnZHg2dlcxY2pL?=
 =?utf-8?B?RFFmbVVQM05TOW9KdW5za0craFJDNjhmT2JWV2dqaVJYclEwRlBxdjVOSHVH?=
 =?utf-8?B?NnZXeXNjcitFdzZhd3ZrQytSUjA4MTRuczhHdHo5WXI3amxldDJ2MTZhd3F4?=
 =?utf-8?B?a0NhaTZVdnhVaXYzZ2U2R1oxY3Fxb3JIbmpITHF4KzBpbktUaytKU0RHRW5Y?=
 =?utf-8?B?OWs0d1RXQjlmZ1hTS01nR2JNQVVqeG1QeGlITmpHVHhOOHREbkJBV0dJMUYr?=
 =?utf-8?B?OEx5M1BaMklHcThOb3VrZGVtK1lNU01USGJiQ1FNZGg4cHI1bm1yaXM2YzBQ?=
 =?utf-8?B?Vjk2N0NHODNETUhTc1BOVUhyZTlrNHlNVzl6cWlBeHNtL0VUekNVeW5Uelpx?=
 =?utf-8?B?K3hWVjIvcFVVUEpOZTJkY3V6akFmREw1NFNBeVBqRjByd0pmWld6S25DcTFK?=
 =?utf-8?B?ZE9rZEZ3VXJtN1ZmblVOOGJhb2prcWhFY0NCZEMwbEJFa3pQTHF1STEwNnpF?=
 =?utf-8?B?ZTFpd1dYemdzN05uMWNXZGgxc1Q4YnZubUlKdUJrNW5FYUZkTXRjOEx0RkNY?=
 =?utf-8?Q?T+cMXFjIVBC8t49E5UHc4XH5w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03112c3d-22e3-4f1e-1835-08dda80791f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 10:14:22.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeAm4NVLqOwdcxXYWgwt4TsvDSPzMqxHNgSmxNqDpzsY/mkw33Ly0xz351SB6fm+scSrLpWu6yjSQcvLSznOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com

Pg0KPk9uIDA5LjA2LjI1IDExOjUzLCBNaWFvLCBKdW4gd3JvdGU6DQo+DQo+Pj4gWW91IGNhbiBj
aGFuZ2UgaXQgdG8gR0ZQX0tFUk5FTCBzaW5jZSB0aGlzIGlzIG5vdCBhdG9taWMgY29udGV4dCBu
b3cuDQo+Pj4NCj4+DQo+PiBUaGFua3MsICB0aGUgdXNibmV0X2JoKCkgZnVuY3Rpb24gb25seSBi
ZSBjYWxsZWQgYnkgdXNibmV0X2JoX3dvcmtxdWV1ZSB3aGljaA0KPmlzIHNsZWVwYWJsZS4NCj4N
Cj5ZZXMsIGJ1dCBpdCBjYW4gYmUgd2FpdGVkIG9uIGluIHVzYm5ldF9zdG9wKCksIHdoaWNoIGlu
IHR1cm4gY2FuIGJlIGNhbGxlZCBmb3IgYQ0KPmRldmljZSByZXNldC4gSGVuY2UgdGhpcyBtdXN0
IGJlIEdGUF9OT0lPLCBub3QgR0ZQX0tFUk5FTC4NCg0KSSB3aWxsIGJlIHNlbmQgVjIgd2l0aCB0
aGUgU3VnZ2VzdGVkLWJ5ICENCg0KVGhhbmtzIA0KSnVuIE1pYW8NCg0KPg0KPglSZWdhcmRzDQo+
CQlPbGl2ZXINCg0K

