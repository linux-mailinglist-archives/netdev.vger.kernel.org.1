Return-Path: <netdev+bounces-247669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4ACFD1DD
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3341A3001978
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2A3043BD;
	Wed,  7 Jan 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QATOg1IZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3E306B12
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780605; cv=fail; b=VsySU6O0iF+CWKOjnbAh/nZDgyGESv9HXRQ0Jhsq3r0vzH4IJ+dJrsRKbV4YawAr2568gV10ALgS+3ou9ARIvsVe6Zs660S1XiXHcLyjbvTOMaP55q2Tqy9Z78fEjNgTcD6x0fpR4l28lh53+afTFJVjKrKML6ABU4FpK/01qxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780605; c=relaxed/simple;
	bh=bukZv1fOMKUevACeheLjbRQgsNIxM/mg6I3+O3z3hpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAcvhngbyXYjXsR7GlfwC87TrbcWiuANUgdPFwXKFEq6tjLVZdTIgIPsI0E0zRnDIuZmYEQxTNv+aLGRDpSQxZ3ojWBkUbZjEIrikf8bB4c8lv5O+JBAC6vhdiPP/holIcwQJLX3xQPmtCyUUVO3XUYSj5eHuh9giiC4Z7sB8YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QATOg1IZ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767780604; x=1799316604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bukZv1fOMKUevACeheLjbRQgsNIxM/mg6I3+O3z3hpQ=;
  b=QATOg1IZtAuWxiDXmJZxxfCyCR00e7h+jCM4zAOciP4JIqe8/Roz2eF8
   PTPkurDV5LUK/bBDTiTbHIbAM+t/Mja/YzFoGDese5YXgNDrEwSxsg/JA
   kRPbG9xJiSz/M23r3IlZLULwdQRUL4SPftwj0KG15i5J3Xc3iiY97AK3v
   /1xelFfAzE3JUATWj57CBETykBebM8krl9Ua1Y8TPkFTfLzxq8hzdP+n5
   ZIWtu4/+hkcWWBKe817KE+8jAcrgsGpAc2fzQIqnItdSkfreGkkD8CV9V
   sWN282cjszZ6cgUy+qcXli6iN34fPyQqak+GYnKBrBH9891Hckm9Q/dIn
   A==;
X-CSE-ConnectionGUID: 4LBrwF+ISHCclJBPINKx8w==
X-CSE-MsgGUID: uDbMS3bXT5mX8rCJDlZp/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69196908"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="69196908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 02:09:52 -0800
X-CSE-ConnectionGUID: YW46afBYQCO7Kv/SXwMXPw==
X-CSE-MsgGUID: aY+91WbeSnSH8UG/Sgusqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="202023217"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 02:09:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 02:09:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 02:09:51 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 02:09:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yroq2PWTDIvcxrwRpqCz+CbxBnelLhJ7t9Qr4BNZm1sK6Vcd9Nm2GEKKMu5+oSFVK5b9OVJbkS6UsAti1hTfTdSYJAseWM8fC0N6EO2+XPhBq6sDJqb+MBZJCnBCh3yTvH9yEYUU7K2EB9b6bVmQlxPWv3Jp5Z6xBnqM+2CwplgOYIeuvyNs6ZiPIvmHvkCLH2c5pQZVZZznXN8cQYgr093MoggSD/k1sgdQzo4Su8gafc5C/mPNXKzaE2rKtj0Gy+u+Jjxx4AteHDfdZgVPJJbgHfPuCdeAHl7oaWnPpSnh5Usj8XzjrPANOSaSzzvGNKEQ8gmrqh3KICm+/RO1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bukZv1fOMKUevACeheLjbRQgsNIxM/mg6I3+O3z3hpQ=;
 b=sXujlN05T302cnwIy6M5oREnQoz9FObkYPlUlgqOzajon/qs+NC4xqMqHyTT73x2Tq/9xY5pwt4rNGqseiK/Q5v9Y3Pcd8A9BuNtMqxsXuOdzvhsflKPuvatxkYZuoU1zuLL6vOb/1yowuvjchQz/ET7lNnRAw46s+ZVCHI0Hh4ZX+S9eKu4SPLrrs/dJ4yQ4XnfuuScUAtG7Eqyp5Bzkprn867YlKTFZ54eLUEMVAWLsrg8HHQt6hJ7qts/V7gp7DFRLb1lyYvvo5yy70811v8fDgfgTZzoDoVhrvpFZmgR2+IabuXqC1ezJ3tR/50aCHlc/AsCMsjINk/WDUh4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM3PPFF3F4DC26A.namprd11.prod.outlook.com (2603:10b6:f:fc00::f62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:09:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 10:09:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net] ice: fix 'adjust' timer programming for E830
 devices
Thread-Topic: [PATCH iwl-net] ice: fix 'adjust' timer programming for E830
 devices
Thread-Index: AQHccANL3drucjUFeUCAOvJcolR1t7VGm1jA
Date: Wed, 7 Jan 2026 10:09:48 +0000
Message-ID: <IA3PR11MB8986529A75D72C02A2E85889E584A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251218094428.1762860-1-grzegorz.nitka@intel.com>
In-Reply-To: <20251218094428.1762860-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM3PPFF3F4DC26A:EE_
x-ms-office365-filtering-correlation-id: 58deffda-4a76-4dba-c4e8-08de4dd4e411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?UEpJUFI2TUt1QUdpS3R3RHA4SUIrQWVBSXBwdWZuNU5XR0haUlJCb0RBOEtG?=
 =?utf-8?B?RExZeEI2emU2ZTI3V09uNDkzV2tSZnVvNnFTbmY1NWsrbmJMaEpITVpBUDlW?=
 =?utf-8?B?NFVnNFVMcTg2c1BpVFZNd0hjQm1IT3J5YU9YV3BiWUh3VVowOEtydHNtWmow?=
 =?utf-8?B?T2czdFdsSDY3eWRXeHZSenNHNDE2emdjZkxjRUFDUGppVXpsZXZROHZsNm9Q?=
 =?utf-8?B?Q0o2MC9QWFlBekIybU01TlFSZjNXVU1JRFhvWFRrdVBuNjlVM3RNZmRWUlVP?=
 =?utf-8?B?QVh5MDR4ekZuREx5MmJXcUVVQlE2SEkxZlZlVWVERzEvUzV5TUhHR2dlZU5m?=
 =?utf-8?B?bUZaSFRLa211ZzQ3YmFKRDBEcVhqRFZMWlg1MkFCM0xNeThkN3hTQ1NPWkk0?=
 =?utf-8?B?TU1MVDhyZ29YUzVNMVlMdDV5cVMzTm8rbHljUzE5Z2NUNGVSZE5sUnpQNWVO?=
 =?utf-8?B?aldqdFl3dWpDMFoyVWI2dEIrZnVRejVXTDA2YjVtTjFCMmFxR0F5TUNLMWw1?=
 =?utf-8?B?b0Z2ZUZ4M2I4MjZRVEczL3lRT2haeGFuRjF2aTJSWW5IVTR2b0FHTjlxYzJ2?=
 =?utf-8?B?NkdTS0hvdHhiODZ5SXVVbjYyL3QxSHFkbDZncCt5ZktTRS91UzZmN0dHakNT?=
 =?utf-8?B?dFFCQ0JVbFh2Nmp6RmZxaTdLWEFVWEFPd0o5QmxKSEVPcGpkV1B6Qm13Mm5P?=
 =?utf-8?B?OFRCWmxpZ3dLT2E2dmN2T01ab1diZEhzR0MrYlAzcUswdlllWWRZOW52TWhH?=
 =?utf-8?B?SWVjVzZ1MjJaZGR1SmRxaldSaFViYk9GYlZmaDh5aVVUbG5aTmZ6K09oTlFY?=
 =?utf-8?B?dUpyek9ySFZiT3A1NVdqT0kwYklkT25mMXlQVzhDYnNjN09XRFNSVXBhN1R5?=
 =?utf-8?B?OGxsK0NRakVoQS83Yk5mUm9EQ1UwMjh5eGJwZ1ZaSlNSRnZiaWlQeGYvdUVv?=
 =?utf-8?B?bHZrYU9yeWdpN2g3QTQvN2M3aVJTYmM0S2tEUHdESjNGbHpCRTJ4emIySlhK?=
 =?utf-8?B?bTdTTTlENXhyOVBvZ0JqWCt1NVJ6MWV5Qm9rbUFQVURpWDVaTTZFY2d4bytK?=
 =?utf-8?B?dmtZaDExRndaYXZsRW4xSld1cmhpZjllWm4rMGMyY0w3anJwVlZtemtWQkdi?=
 =?utf-8?B?OFdqckZ1dG13K0EyU1VtVVJsZDhJYnhtblg2c2UxaWswSkhFd1BDUTMrUDhi?=
 =?utf-8?B?SCtXblVJM2FpSjE5bCtlUGwweGpoRks4N2NKaDRXNkpIV0VzeTNldExoU2Fx?=
 =?utf-8?B?UVUrb2xmZVVBREpKcHZnaGJBcWtSTld2d3F0NE1UbmRCVWlQVWw5QVJra2JF?=
 =?utf-8?B?MURyaW1lWjF0dlEvNXlieFJqbjZoUDZYcG1UbVZWeUVKc1F1MEVEY2wzZEkz?=
 =?utf-8?B?SWJpUGpXdnRxbXl3ZHpHaWRRWEdoTU1RNzlXbG5LUlA0Y3FiQmtiSWo5ZUdL?=
 =?utf-8?B?enFqMHYzQXdUVXlKMnpKVDhBdFM3b2NycXZ1WXlRTGFUWWJscUt2T0szd1Bl?=
 =?utf-8?B?VTRQRXZvSHlrWThiNlpRMmRvRWJrbXBYbWxVaHdzbU1wM0N2SXJkR2NOejVK?=
 =?utf-8?B?dER0RG1hdTl3SWU2d0lXT0NuYTJxQ2g1cTBoNVltYzlZOE9TUXU2OUJWVzNi?=
 =?utf-8?B?RTdzSVB1OXcxbmFzNE1YTGZEblJHZVlqYTRkRFovQU54dGF5UnFVMTRTejdM?=
 =?utf-8?B?YzkrdURpTUw3WGdka2hlcVhxcHFxNXJ6RkZ2eUxwQkw5QkVsYzRIeC95UkJK?=
 =?utf-8?B?bTZDenJxN09wQWxDN1ViUFJyMlo1Ti9rRFl4MzhMV1B1VTBianBPcWFrd1Rl?=
 =?utf-8?B?QnBNSXNyVURCMyt0VnR4L09vVnkzZTZ3ZENaRW5Gb2lBY05KMDQ3YitIN09a?=
 =?utf-8?B?dU9UTGF0K05wTk82RmhaNnpUbHcxRjZSaE5kcFp3VXdPV1pTTjJvMDFSeXd0?=
 =?utf-8?B?YytOaXlqaWRtTGdmMUN6cEErSXZ3MzkwcUlqUnJhYVJPbnJKY0lSNWdKUFly?=
 =?utf-8?B?VVdrMEN1cDJSaEwrdzUzOUhFVmx3NGxzWnBtSUhrTUJjTEJwd2IxMkNsVVM2?=
 =?utf-8?Q?qVNZig?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFgxRE41TkQvaG0yQWF3VEU4bTloWTRVT2RMdnZRU2p0YXJGbStKc3JibTMx?=
 =?utf-8?B?ZExSL0ZvaFFqSGRrUWkzTU82R29PRHZVd3pHK20rNnAwMU84THpuRXoyTVRw?=
 =?utf-8?B?N3c2dk1zNzFQT1lvS0VEWU5xUnIyWUZQTlU2WUZoMVdGSk5Gb0Y1cEFsVHRQ?=
 =?utf-8?B?UzZLWEptdE54RnROSzQvdE9YMks0OGpDeUwxbzBtbU1KV3IrTXNqZ0pOUW9V?=
 =?utf-8?B?OFJRNkh0Q1JZem5qZVRidzA5S2V0ZWpBcVRRVmVxeVdnWXp5ZCs5ZlZyenhy?=
 =?utf-8?B?MnhmQUtYSTZiaURPYmZPZ25pazRhc3ZEOVhlMFU5OUlYMlh4ZUlqbTNLWXd0?=
 =?utf-8?B?SkY3RkZMaEJiSnVpaWE2TDJVeC9hdnNUcDhPR1U2TFROaUh4Tnhoa1pQNmgr?=
 =?utf-8?B?Tk1PaGtWczYyZzlVMk1STUJ2N1grb0dBTzZDVHZaRkl2OEVlUTNDbFRxdkxH?=
 =?utf-8?B?TDVYdlo5OThqWnd3K0NiQVhDVUVkRHcrTXFzeDByZGM4TW9VaHdid2lxaktX?=
 =?utf-8?B?Wk1Cd3IvRTJ0Znl4NWZGT3Q4RWdVczh2a3JaVG9scVZESFNMdWZlaXo5ZmZX?=
 =?utf-8?B?QzlkcVRoajZXcmhHT25qbWtGbng3YytqN0kwQ2RNbHFwTGFsS1Ria3RXL2hJ?=
 =?utf-8?B?dVpPNWdVNE5rRFVreHdLMXN2b0JKU3lubHgwcmc5OTkwcG4zdUNvaUEwQ2Ir?=
 =?utf-8?B?MkR2d0NIemJ0aDJpM0diMU1xMVhJRjNPNEY0ckh5aitBeVY3cDBDekdlK3F5?=
 =?utf-8?B?dHljYnduSEx1MzlxaG1weGNsME9vN0Q3bkpzajJMTnBVQ1JIZE9mZ2VzcjBt?=
 =?utf-8?B?NlNyUmh0VDl4TmVmUnVjTExIQ0dDd3IrUW5WUzk5aEVoQ3V1NW1ITmRKQjkr?=
 =?utf-8?B?N2tTMmNneG1abGlMTWN2LzlrUGk1SGNQQzVoR0JzLzZqNDFWRkxZYys2YjJF?=
 =?utf-8?B?UlU0U2F5c0pFam5Kc1pTSEVQaW5MTG5hTjV6a3ZhZUtnMFo3dVp6d3JhUmor?=
 =?utf-8?B?MUNoc0dEMnVrdUNFQTZFa1NnMlRQYXhDOS94Ujg0aGtIRWFnUFRlRUJacjNZ?=
 =?utf-8?B?cityY1VsQ3R6ZXFvclQyT2tpLytRUHhNS1kzZFRLUVZ1STk0K2pQbWVlcUxj?=
 =?utf-8?B?QnFpN2RVTXlRQXJWN3ZiWm1DYmtHSlhkWVFYVmdDekFCU0E2Q1laTVdEM3Nz?=
 =?utf-8?B?ZG00dFJWajU4TzVzT3ZGNDBEZGFHN1dUbElYc1ErZjU2RFJldzd6akRhMVhW?=
 =?utf-8?B?QTBrTmh6Y0pBczZIMWJPYXBuTk55NVBSSHJiWUVEZFVYSHZyZTlseHFjWVBm?=
 =?utf-8?B?TkJ5SmtQUllRSXRYVTQrUVFScS9mb0Y3NWpaWG1nZXdiOGVjZFNYS0FhUkFj?=
 =?utf-8?B?MlhLMzRHSXNMRXpQZ0lrVEVkVjhtejJQWEMrdUZqV1QrUEUxY2FSUkt1L2Q5?=
 =?utf-8?B?TnlsNlpEd21MWFVtTFFPWHhQMFhBbjV4WHg2YjJ4OC9iQjJDR3BYVjJOdTdw?=
 =?utf-8?B?RnFDRnA4NG5IeG96aXlwa3J0S0xGWWx2dEQ2RG5tVnVqRXdXcGRqQmZKdW5Z?=
 =?utf-8?B?cGluMy8zYlhMZ3JlZzlDS0d6aGY2ejd1ZTRQVzFFVE1hYmVkTFJRbGpzSEdP?=
 =?utf-8?B?SzhEUjZsWTNBcCtoOXlyZWpXbkZFa1YyTFRZOW1mREdYUUhXelBDeG56Q1E1?=
 =?utf-8?B?ZlZZQU9yTmo1MWl3WFRkVkNKRlZyVnYwcEZoRy8xb09XR1FYNnp1WUVXMmlD?=
 =?utf-8?B?UVo3ZzcvbFhuK0JpQVJwTER4aUlOV2xTaEJUV0UzM3BaQ2lRRGkrbS9OSVJJ?=
 =?utf-8?B?SHVWUnJnUHlXcGxFdURoZys4ODUxdmlKbEtTSGZtU2xIQ08rdkQ2c3pOSEov?=
 =?utf-8?B?SUo2TlNYQmV6MXRURnViR2JQODY2SCt2RnRFYzdwL2F1SEo1eDhyVmpXK3BB?=
 =?utf-8?B?NzZDN05CdWRoL0lGSFlSMmZ6MFovUzloNW5CZ0pmRkgzaFJOaU41V1hRRUlZ?=
 =?utf-8?B?RjV1SEVSejV3Y0tVaEhGMEJZcFFrUS9Bczc5cXpYdlpmaHhEU1BMZ2V3SHJO?=
 =?utf-8?B?ekpZMXFGYmtFd2gwLzIwM2NhZ2VRTE9NYVA5OVU4YmRadHBtdm1XQzV5eUhx?=
 =?utf-8?B?bW5kd0MwaHozUlYwS3dXODVlT0YyUjVmMkcxTG5lRVdWWURYcm1qWm1WdjBj?=
 =?utf-8?B?ZVhvVkNKa2Y3dWszaUxoaTQvQXBzdkwzUU5yK0hqSitOWmRDSy83VW5nRy9N?=
 =?utf-8?B?K0Nzb2xzaTRSUlhXQ0k4UlhyZGtaT2V5UForaXVENjZobkZ0MUZXQUVRV2JL?=
 =?utf-8?B?WDc4S05IY1FOQkluUnY3V3NRMlE0eTV6dGVWUlN1Y3hnOVI0MHI0eUljUXpJ?=
 =?utf-8?Q?5LPQUXSsCEyN4uBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58deffda-4a76-4dba-c4e8-08de4dd4e411
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 10:09:48.7889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtNFQm7/Zd0Shf5cD4OKNxeACvrPnZaK4WyDGgsQe/1PQE3Up+o8A2btXXXA8kyte+p0UrQKikl63LtSzyQsOZR0I7xUTJjrBj/P0hWl+Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3F4DC26A
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTml0a2EsIEdyemVnb3J6
IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAx
OCwgMjAyNSAxMDo0NCBBTQ0KPiBUbzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcN
Cj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRo
b255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNs
YXcua2l0c3plbEBpbnRlbC5jb20+OyBOaXRrYSwgR3J6ZWdvcnoNCj4gPGdyemVnb3J6Lm5pdGth
QGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXRdIGljZTogZml4ICdhZGp1c3Qn
IHRpbWVyIHByb2dyYW1taW5nIGZvciBFODMwDQo+IGRldmljZXMNCj4gDQo+IEZpeCBpbmNvcnJl
Y3QgJ2FkanVzdCB0aGUgdGltZXInIHByb2dyYW1taW5nIHNlcXVlbmNlIGZvciBFODMwIGRldmlj
ZXMNCj4gc2VyaWVzLiBPbmx5IHNoYWRvdyByZWdpc3RlcnMgR0xUU1lOX1NIQURKIHdlcmUgcHJv
Z3JhbW1lZCBpbiB0aGUNCj4gY3VycmVudCBpbXBsZW1lbnRhdGlvbi4gQWNjb3JkaW5nIHRvIHRo
ZSBzcGVjaWZpY2F0aW9uIFsxXSwgd3JpdGUgdG8NCj4gY29tbWFuZCBHTFRTWU5fQ01EIHJlZ2lz
dGVyIGlzIGFsc28gcmVxdWlyZWQgd2l0aCBDTUQgZmllbGQgc2V0IHRvDQo+ICJBZGp1c3QgdGhl
IFRpbWUiIHZhbHVlLCBmb3IgdGhlIHRpbWVyIGFkanVzdG1lbnQgdG8gdGFrZSB0aGUgZWZmZWN0
Lg0KPiANCj4gVGhlIGZsb3cgd2FzIGJyb2tlbiBmb3IgdGhlIGFkanVzdG1lbnQgbGVzcyB0aGFu
IFMzMl9NQVgvTUlOIHJhbmdlDQo+IChhcm91bmQgKy8tIDIgc2Vjb25kcykuIEZvciBiaWdnZXIg
YWRqdXN0bWVudCwgbm9uLWF0b21pYyBwcm9ncmFtbWluZw0KPiBmbG93IGlzIHVzZWQsIGludm9s
dmluZyBzZXQgdGltZXIgcHJvZ3JhbW1pbmcuIE5vbi1hdG9taWMgZmxvdyBpcw0KPiBpbXBsZW1l
bnRlZCBjb3JyZWN0bHkuDQo+IA0KPiBUZXN0aW5nIGhpbnRzOg0KPiBSdW4gY29tbWFuZDoNCj4g
CXBoY19jdGwgL2Rldi9wdHBYIGdldCBhZGogMiBnZXQNCj4gRXhwZWN0ZWQgcmVzdWx0Og0KPiAJ
UmV0dXJuZWQgdGltc3RhbXBzIGRpZmZlciBhdCBsZWFzdCBieSAyIHNlY29uZHMNCj4gDQo+IFsx
XSBJbnRlbMKuIEV0aGVybmV0IENvbnRyb2xsZXIgRTgzMCBEYXRhc2hlZXQgcmV2IDEuMywgY2hh
cHRlciA5LjcuNS40DQo+IGh0dHBzOi8vY2RyZHYyLmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50
Lzc4NzM1Mz9leHBsaWNpdFZlcnNpb249dHJ1ZQ0KPiANCj4gRml4ZXM6IGYwMDMwNzUyMjc4NiAo
ImljZTogSW1wbGVtZW50IFBUUCBzdXBwb3J0IGZvciBFODMwIGRldmljZXMiKQ0KPiBSZXZpZXdl
ZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEdyemVnb3J6IE5pdGthIDxncnplZ29yei5uaXRrYUBpbnRlbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcu
YyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfcHRwX2h3LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0
cF9ody5jDQo+IGluZGV4IDM1NjgwZGJlNGE3Zi4uMTYxYTBhZTg1OTljIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMNCj4gQEAgLTUzODEsOCAr
NTM4MSw4IEBAIGludCBpY2VfcHRwX3dyaXRlX2luY3ZhbF9sb2NrZWQoc3RydWN0IGljZV9odw0K
PiAqaHcsIHU2NCBpbmN2YWwpDQo+ICAgKi8NCj4gIGludCBpY2VfcHRwX2Fkal9jbG9jayhzdHJ1
Y3QgaWNlX2h3ICpodywgczMyIGFkaikgIHsNCj4gKwlpbnQgZXJyID0gMDsNCj4gIAl1OCB0bXJf
aWR4Ow0KPiAtCWludCBlcnI7DQo+IA0KPiAgCXRtcl9pZHggPSBody0+ZnVuY19jYXBzLnRzX2Z1
bmNfaW5mby50bXJfaW5kZXhfb3duZWQ7DQo+IA0KPiBAQCAtNTM5OSw4ICs1Mzk5LDggQEAgaW50
IGljZV9wdHBfYWRqX2Nsb2NrKHN0cnVjdCBpY2VfaHcgKmh3LCBzMzINCj4gYWRqKQ0KPiAgCQll
cnIgPSBpY2VfcHRwX3ByZXBfcGh5X2Fkal9lODEwKGh3LCBhZGopOw0KPiAgCQlicmVhazsNCj4g
IAljYXNlIElDRV9NQUNfRTgzMDoNCj4gLQkJLyogRTgzMCBzeW5jIFBIWXMgYXV0b21hdGljYWxs
eSBhZnRlciBzZXR0aW5nDQo+IEdMVFNZTl9TSEFESiAqLw0KPiAtCQlyZXR1cm4gMDsNCj4gKwkJ
LyogRTgzMCBzeW5jIFBIWXMgYXV0b21hdGljYWxseSBhZnRlciBzZXR0aW5nIGNtZA0KPiByZWdp
c3RlciAqLw0KPiArCQlicmVhazsNCj4gIAljYXNlIElDRV9NQUNfR0VORVJJQzoNCj4gIAkJZXJy
ID0gaWNlX3B0cF9wcmVwX3BoeV9hZGpfZTgyeChodywgYWRqKTsNCj4gIAkJYnJlYWs7DQo+IA0K
PiBiYXNlLWNvbW1pdDogODI4MmVkN2Y3M2NmMDhmOTkyODhkM2QwMTMxZTA3ZjE0OTA2M2ZiZQ0K
PiAtLQ0KPiAyLjM5LjMNCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtz
YW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQo=

