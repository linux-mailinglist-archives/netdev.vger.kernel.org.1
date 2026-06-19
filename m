Return-Path: <netdev+bounces-300731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MVFeGi9uNWq9wAYAu9opvQ
	(envelope-from <netdev+bounces-300731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:28:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC9F6A70DB
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:28:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Plf3GhoZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300731-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300731-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09693003301
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC73BB133;
	Fri, 19 Jun 2026 16:26:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A653BA239
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 16:26:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886402; cv=fail; b=BdJ0N4tgXgFP2zOA6Lc/UlPGuZ1kBfWO40f/nmh/GxvfjZOkNLtyhrNSiHBqKhisrNh1MLbAU/T2BWiCTevD+qZNFPR9GCCp2X/lZY0rMmOU/v+julDPvEVCoTl2Vv6EdmhYEmqz0KHXi6ddQkqu2wfxOtbVlmNlSWw6tJFkjYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886402; c=relaxed/simple;
	bh=WWjB4YUpxSOHDJfZsexfgwQo3d6qxNMVbzSQcItAu2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4ElJjgDvkGdiJ4hHbWmsz1OshWak0QmdIATBXPXjM1zVm5Qp0xCDwHkzrKJLbxRVfHT7n64Sw3IHQeo0SY+YqIEU5gULdPP/Zv+JunX2qkX+m92Afcvy6uUZJXXNwc1MgAW3Tp2AWLmCD6+LkVlKGIIU/ov7p/unNtI29/hVMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Plf3GhoZ; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781886399; x=1813422399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WWjB4YUpxSOHDJfZsexfgwQo3d6qxNMVbzSQcItAu2I=;
  b=Plf3GhoZXw1qzm8Her2G26OzQZskpnOV5l5o6fov5uatsS/GnQXIzvQM
   sJ8gZdbyaKfnjKtoR9MHA1V6EczfGO2vYoZZ3roFNxFxe9g03SNlliD3W
   R0AMs4PrB42TGvY9wj3wkUKMlSMhEPaBxuiLYWjhPYrgLIA24f8TRaLOt
   LI5tMMci5WKl4dQtTFfooHF/b1qlYEdOi4HTN3dSFUQJYiB3LLrfbPgj9
   Mm5yFBcZmpkH0OiMgC4MPElJ0HKbP3fiT6NjvY2gLZmbTjz6IAr/Zz4P7
   /PDNycUqca6izHRAdDkhGiUuVFuZQdYpUGtyRi6aITNZkp3TcIUFpQRqC
   Q==;
X-CSE-ConnectionGUID: OvbDhBxJSqOv4xcbIA4P+A==
X-CSE-MsgGUID: +E7owCq5S8af7UTCz0V2Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="82607248"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="82607248"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 09:26:38 -0700
X-CSE-ConnectionGUID: kilyxNffQpaKkcIvZv5zdw==
X-CSE-MsgGUID: uOfIr1seR9eAipC+yU6n3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="272356647"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 09:26:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 09:26:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 09:26:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 09:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thT6MzZiPN8oOJbC+yo9h4ES7yi/BANMi4EHyyxnUe+NL/6PVr1tUA/D18K3GI6NQCFJ8jSk1YdME7+k56djSUFcJ8u/+yuT0lujU1KEDCVgBxgu5jLznAzk7DTHb1jZbVsD5LYRXiqz6ixlSnc+TxLrbLhiy9XZEPrS/0Eg0PcCL4GebR9NzI9nggPRyK0ZqMheKwxu5xhVff84ZRLUFULDXOjUKxqFHbb2mCptzWhUShQKL8urmCaycVskdYQFYE0RILYNqtnQMvaN7Yi8QdZacoAq5/XlPTCdZcVdjC89azBq33B6APKT+ZvJYn42A503djfboEbX7v6r+QrFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWjB4YUpxSOHDJfZsexfgwQo3d6qxNMVbzSQcItAu2I=;
 b=Y+mTm4PaozEJ+Vsp2vvaO7nxx0oQoWh0jka7TaufmjaIXPi3UhfAF2EZcop3kkpc+3y3XwPzVu4gv0ulTXwvuHH3ChkzITv8cqUKOsC2CeT2ilDZY1+rk63yIAan1d54r3auZn3Au6fzRxZMHQ0ZsI+G1WDAJ1RDuW2fpMwXYOLar+cwIAyFlBUHP/8w9a+NQ1Gbt5Wm8pNUbHzwXcdqlwluT02pIBFPnxNjBCBgboYYZNTVharNIZ+pYeJOe1+amj8Ng/yKothlQJsjB4kjcC+Z0mqaXiE6BuAt9M0T0HBsb6pfV7AcnRS2axq8h/VwBCrCJh6RJpInOCrFmVX3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 16:26:35 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0113.020; Fri, 19 Jun 2026
 16:26:34 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>, Andrew Lunn
	<andrew@lunn.ch>, "lee@trager.us" <lee@trager.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0A
Date: Fri, 19 Jun 2026 16:26:34 +0000
Message-ID: <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
	 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
	 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
In-Reply-To: <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|CO1PR11MB4931:EE_
x-ms-office365-filtering-correlation-id: c64dd7de-c959-4416-31b2-08dece1f87a8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|38070700021|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|6133799003;
x-microsoft-antispam-message-info: h+hSM/mdsnXgr1GcrlMunxnCe23TM/y9WWtvmg35a1j2NVnEx4m8EDRKcMQ+XEt3R9Jpn0y2P7Fa7TKD4FRz3Py7iFhLv02kiJjVs1NWUVyYgKlZJLqZQoBhp2UskmhkRWlw7nmWcpRWfxX4GVuA3kHVIieco4g12Wzgg3aaO7DGiUfYcLwDo4SjMycksqJZp6d3hBbFTpVRONHR6aLapjQNOlyfwSTNJH8MeLtTnJQxFlKqmpXnnmx+QvfOAnw6VZa2HinEPYTTjkqebn8aD5ZH7GSNRIAdZUI0B2+47EyNLqAJQwo7erepxPdiERWq213C6aXPbG7e0dKcdT8O4puwSEO7GLA66HLKCP6mjI+dzWFS5QXgG//cg62Ho07DHNqJrBI4zuh26ONhF0IkxvbrMznaNUD++RulNL5Sq9qQNPUwbodaY4dw2C4ld2PIPWTeHhZkC7EDKLa9JZHkrW98zy9jJ6n7TDSDvkNALRLiEPT/lMQ0j68fJ4acee6PM6ovC3cNK6TIUPovjmOKK3/hq54KIVTR+cRbAaTUBcm8HOOyMtHWnhixh9XTZRbcOfVsM9lHa09lS7WwY3D0y7SkOAA6mfw7m/AY7Qe7X3oOsB4zAjNzNPmUR4rsdb/hYe+emaVs6LSjtXssLPEOYllMDEW4QWG90JA+Fw+0iERwGgFd9nFhWHBWPBgh40dDAEo4ZaU7XaUbt+J9EMAulKPCpZQqHEH/HoM6iqP0tcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNzV01Xd21LQkhFV2VUNzhmbmh5bnRnUis1b000UGU0eWZPQTM0b3RidTRW?=
 =?utf-8?B?ckUrNFQrZUk0Q0NaaXB1K1pIUzBWR0IvN1ZOZFo5OW5ibitXbDl0RzNFcTdR?=
 =?utf-8?B?ZWkzRkVhbGVCUzU1VjB0d2Q4SGY0RnZPUkxHQUxRc0pPYTZWRzJzLzVQZzli?=
 =?utf-8?B?aVlCQXlsMlluOFdEdDZ4ZGRIMkx1K3pEZFROdFFKUU1ha2FMOVZucmY2QlVE?=
 =?utf-8?B?ZG1Yc0QyMkdRYWN1QmZhM3JENVpSVjB4SVZidVhkNDVmZXBhL3FnNGg5RXdW?=
 =?utf-8?B?UWd4bjFnempxSEhaK1VvVVk5cnNLMGxLclpqazZKWjZPVE1sMk9qOHd6cm4r?=
 =?utf-8?B?RmNKbWMzY3RCTWYzcXM4ZDEwZ2ZaMVQvMlFaNVV3bUNEa1FVemVNbnk4aHhs?=
 =?utf-8?B?UjAwYUV6UkFzVFUzbzk0VTZWS2NLcGQ5TkxjTE5uVTludC9BNWJsUEhaK1Fn?=
 =?utf-8?B?bjhMV1d2dnp6QzhiRXN0UHg2dXhpN0VIWkdYeEFCQzV6a05VN3RwZ0VrNXAz?=
 =?utf-8?B?T1F5NnFzdTdTamZRK0NQMmJZOUdTZEVxU3hxQkdKSUF5aWhQM1NINGxQRjk3?=
 =?utf-8?B?cW9MK0RCNGkyTHYwMFpXdzU2aldxNXFCTk5kLzM5WjZ0U1BmV3RXTjUwMEtk?=
 =?utf-8?B?ZDJYdlZrWWk2dU5JV2V1Y0ttUHIwQ29LL3Y3ZDJGQWtIK3A3Z043Rm4xOU1X?=
 =?utf-8?B?RWw1Y1daUTc5KzdxSlcrQXN0TzdFaWFCT1Nja3NrQjZxQzdJMmptSUtYT1dz?=
 =?utf-8?B?NlNOeHdBeWlKd0ZxQXRWaEwwczZuckN4T1MxQ0JvQWJnTWQ4akhUZEJxdG5N?=
 =?utf-8?B?cUtscGpENDBpTXhRc2NZT1pYb1hFR055ck0zR21Iak1SY1o3cVAxNHh4Mmlx?=
 =?utf-8?B?dU01MnZ5aXZkSW14RWRyREV6VG1RV0tBaVpiVld4VHlRdE9XTm42ekJkbTZv?=
 =?utf-8?B?SFBqd3oxZTFDK1JSbnE2OGpZKzJ1eE5zSlk0YXNocWIrM2hZYWdYU0V4RUZh?=
 =?utf-8?B?T3EyM1dmaGY2ZnBjUGUvVm8zcHdyWFYzRnVQdTNkYkdBSGNmMGZFNDB4dENQ?=
 =?utf-8?B?M3pTaCtuNjRYWHZaVGg0ejk4NWVScVJiY3hVUUFpenUzK2FDOHAxaTduUVlD?=
 =?utf-8?B?eHdhOENaWWZML2J0dDFpVW91bDJWMXFhTndsd0NncVY2N3FMdDBFd3NTUnB3?=
 =?utf-8?B?ZEpVeXRzTW9Za0pHVGg0eEE0SWllOURBMHo3d3JDT0hhbEhoTEhtVnFwbnln?=
 =?utf-8?B?cW80aC9YalV2aDQ5ZmZDV2p5NHZSVW1pQ2J6QWVEZE81ejRYRVkybE9saE4z?=
 =?utf-8?B?UFE0RGZ0YVRmdnVKa1dGNmdZUWVCdFJmUVk2VlZGMzlqUW5vRklmbmFMWjVE?=
 =?utf-8?B?NCtPaHI3L0EzaVg2R1ZvWnR6ZEV4dnB2WGo5dFV1MXVDVkxmRDFSZXI1MzJY?=
 =?utf-8?B?c2s5MlFOcWZZNEtOdFdwVlJmbXk0Wm01WDJmbHpoazlCMU0vam9iUG5QVUpi?=
 =?utf-8?B?TXNoWjdHbU1oR2wxdGtHUGNTU1RWVktyWGxFWWVHcWlhaTFaNE9LaFBlOHNm?=
 =?utf-8?B?bEZWTGYyU2EwSUE5R1Z1WDZQSUJwTE5yQlJxTGx2MmU4WFJ6c2YxSW1YdnJq?=
 =?utf-8?B?QTREYkw5L09ubC9obEQ0Q0pNT2tFSXFBcXo4dEFLSE4wcUxIV0Yxa2tSMUd3?=
 =?utf-8?B?UjZ4U1VJRHlrNlUyT096bmpiYmNMUk9aRjQ0bHNDaVloUUEydXlwVlI5VFFJ?=
 =?utf-8?B?Y09VSWRZQ0U0Y1VudEZUbmVad29PN3FtdVROT0xRSWNHS1R4R2JERHJQd0dr?=
 =?utf-8?B?MkVoMUtZZXozMjhUM2RTWmhYMXNpcDdPR1FYYzZ3dDMzZVdUdU5HY0NZSk1t?=
 =?utf-8?B?aEhRQjV5S1I0UldxdWZvZmZyVlNlOVNrdnV4RlhCOGI2blpnRTVQbkNCSFVk?=
 =?utf-8?B?WE00N2dwWTBua0dMdzhjS1RGdWppMGN2Y3I4RDBDdGlwbzNvdmxHa0pGalND?=
 =?utf-8?B?WU8ycGNabnVLZkM1WHhUUk0rUFpTL2p3aXd6Wm1KR3F4amJWM0ZlWjIrb01w?=
 =?utf-8?B?UTlPcVFFZGJ4Rkl1cTFYZFN2YWg2WUZFbEVJelNLUnNqOTNsTHBtMFdLTFA0?=
 =?utf-8?B?UE4wUFNEdHlnL3A4MjlpTWZMNGhHeXg4MWRPMmwzR090UjArSGI3d3hpZlVP?=
 =?utf-8?B?ZVRjY2JKMTQvWjJURFFodmVkcFpUdDROdzdURjBjSlNUQlBkZWJSRVYvQnZ5?=
 =?utf-8?B?QXNENTNNSkVibWFhcWxxdDYzSXB3ZW8vSkwvQVk4VWFyQUYwOUZpZjdpOEVM?=
 =?utf-8?B?SEJBay9DaWRpRVZCbWNZS0VUSUU2NXVrOG5ZMGIzQnRVUlpWUUJPNjI0Y1Vr?=
 =?utf-8?Q?THcch0Lp94VjRnPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GQjvtxa1gBjmfvOhTM1Vt8avDY1PN/9Hg8Q+8Z34vLYOFtMZ49QsKTphiACkVpbY7kBCWTkR7+uAIV4fPQa1oyMV1yQJ+nRR6f40I6SWDTD4k0uc9hCkTPchQaFbFobHwjnZ3/D0YMNDLtl44IPvSiXtPDI8jghUrwWybrMbKkNYXg2hSDcBh2GeBFriYlmPbouLRmMq3QES1hfdFlJ/doxEhEQUa3PbzILn1SwWtFlPI4ktilZUchalF6pLkYqPEKsR00UKxGSdf5vf6dh7JbPjd3mhG8ooZPP/Zl09rMCKrJFijOjsg00EOTMt8ykG8ThzDgY+pixyr/QxSW/lEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64dd7de-c959-4416-31b2-08dece1f87a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 16:26:34.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBD5GnFSC58tf30DX1NTrV08dQbvCYIcM6Hf8vHGr7NlVAgbgtwRrI0sKWMgTB556vOKcpdG+/gEZM3sT8xZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300731-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.duyck@gmail.com,m:andrew@lunn.ch,m:lee@trager.us,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,trager.us];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,intel.com:dkim,intel.com:email,intel.com:from_mime,suse.cz:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DC9F6A70DB

PiBBbHNvIGRvIHlvdSBrbm93IHdoYXQgbGF5ZXIgaW4gdGhlIFBIWSB5b3UgYXJlIGluamVjdGlu
ZyB0aGlzIFBSQlMgYXQ/DQo+IEkgd291bGQgYmUgY3VyaW91cyBpZiB0aGlzIGlzIFBDUyBvciBh
dCB0aGUgUE1EIGxldmVsPw0KDQpJbiBvdXIgY2FzZSBQUkJTIGZ1bmN0aW9uYWxpdHkgaXMgaW1w
bGVtZW50ZWQgaW4gdGhlIFBIWSBmaXJtd2FyZSBhdCB0aGUgUENTIChUWC9SWCkgKyBQTUEgKEZF
QyBFcnJvciBJbmplY3Rpb24pIGxheWVyLg0KDQoNCkFuZHJldywgIEFsZXhhbmRlciwgTGVlLA0K
DQpUaGUgaG9zdCBkcml2ZXIgZG9lcyBub3QgZGlyZWN0bHkgYWNjZXNzIGFueSByZWdpc3RlcnMg
YnV0IHJlcXVlc3RzIHRoZSBQSFkgRlcgdG8gbWFuYWdlIFBSQlMgb24gYmVoYWxmIG9mIGl0Lg0K
QmVjYXVzZSBvZiB0aGlzLCB0aGUgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgbmF0dXJhbGx5IGZp
dCB0aGUgdHJhZGl0aW9uYWwgUEhZTElCIG1vZGVsLCB3aGVyZSBMaW51eCBQSFkgZHJpdmVycyBk
aXJlY3RseSBtYW5hZ2UgUEhZIHJlZ2lzdGVycy4gDQpUaGUgZnVuY3Rpb25hbGl0eSBpcyBjbG9z
ZXIgdG8gYSBmaXJtd2FyZS1tYW5hZ2VkIHNlcnZpY2UgZXhwb3NlZCB0aHJvdWdoIHRoZSBQQ0ll
IGRyaXZlciwgc28gd2UgdGhvdWdodCB0aGUgcmlnaHQgcGxhY2Ugd291bGQgYmUgdG8gZXh0ZW5k
IGV0aHRvb2wuDQoNCldlIGNvbWUgZnJvbSB0aGUgRXRoZXJuZXQgUEhZIGZpZWxkIGFuZCBhcmUg
YXR0ZW1wdGluZyB0byBnZW5lcmFsaXplIFBSQlMgZm9yIGdlbmVyaWMgUEhZcyB0byBhY2NvbW1v
ZGF0ZSBhbGwgYnVzIHR5cGVzLCB3aGljaCBtaWdodCBkaXN0cmFjdCB1cywgSSBiZWxpZXZlLg0K
VGhlIGV4aXN0aW5nIGV0aHRvb2wgdXNlciBhcHBsaWNhdGlvbiBpbnRlcmZhY2Ugd2lsbCBnaXZl
IGEgcXVpY2sgc3RhcnQgZm9yIEV0aGVybmV0IFBIWSBQUkJTIG1hbmFnZW1lbnQuIA0KV2hlbiB3
ZSBuZWVkIG90aGVyIGJ1c2VzIG9yIHdoZW4gd2UgaGF2ZSBhbm90aGVyIG1vZGVsIGltcGxlbWVu
dGF0aW9uLCB0aGVuIHdlIGNhbiBhYnN0cmFjdCB0aGUgY29tbW9uYWxpdGllcyBpbnRvIGEgZnJh
bWV3b3JrLg0KDQpTaG91bGQgd2UgcHJvY2VlZCB3aXRoIGltcGxlbWVudGluZyB0aGUgImV0aHRv
b2wgLS1waHktdGVzdCIgPw0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQWxleGFuZGVyIEggRHV5Y2sgPGFsZXhhbmRlci5kdXlja0BnbWFpbC5jb20+DQo+IFNlbnQ6
IDE2IEp1bmUgMjAyNiAyMTo0NQ0KPiBUbzogRGFzLCBTaHViaGFtIDxzaHViaGFtLmRhc0BpbnRl
bC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IENjOiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBta3ViZWNla0BzdXNlLmN6OyBEIEgsIFNpZGRhcmFqdQ0KPiA8c2lkZGFyYWp1
LmRoQGludGVsLmNvbT47IENoaW50YWxhcGFsbGUsIEJhbGFqaSA8YmFsYWppLmNoaW50YWxhcGFs
bGVAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogRXRodG9vbCA6IFBSQlMgZmVhdHVyZQ0KPiAN
Cj4gT24gVHVlLCAyMDI2LTA2LTE2IGF0IDEyOjE0ICswMDAwLCBEYXMsIFNodWJoYW0gd3JvdGU6
DQo+ID4gSGkgQW5kcmV3LA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4N
Cj4gPiBZZXMsIGZvciBtdWx0aS1sYW5lIHBvcnRzIHdlIGNhbiBhY2NlcHQgdGhlIGxhbmUgbnVt
YmVyIGFzIGFuIGFyZ3VtZW50IGxpa2U6DQo+ID4NCj4gPiBldGh0b29sIC0tcGh5LXRlc3QgZXRo
MSBsYW5lIDAgdHgtcHJicyBwcmJzNyBldGh0b29sIC0tcGh5LXRlc3QgZXRoMg0KPiA+IGxhbmUg
MCByeC1wcmJzIHByYnM3DQo+ID4NCj4gPiBXZSByZWZlcnJlZCB0byAiTGVlIFRyYWdlcidzIiAi
T3Blbi1Tb3VyY2UgVG9vbGluZyBmb3IgUEhZIE1hbmFnZW1lbnQgYW5kDQo+IFRlc3RpbmciIHNl
c3Npb246DQo+ID4gaHR0cHM6Ly9uZXRkZXZjb25mLmluZm8vMHgxOS9zZXNzaW9ucy90YWxrL29w
ZW4tc291cmNlLXRvb2xpbmctZm9yLXBoeS0NCj4gbWFuYWdlbWVudC1hbmQtdGVzdGluZy5odG1s
Py4NCj4gPiBXZSBoYXZlIGJlZW4gdHJ5aW5nIHRvIHJlYWNoICJMZWUgVHJhZ2VyIiB0byBzZWVr
IG1vcmUgaW5wdXQsIGxhdGVzdCB1cGRhdGUgb24NCj4gdGhlIGFwcHJvYWNoIGFuZCB1bmRlcnN0
YW5kIGlmIHRoZXJlIGlzIGEgcGFyYWxsZWwgZWZmb3J0IGluIGFjdGl2ZSBzbyB3ZSBjYW4NCj4g
Y29sbGFib3JhdGUuDQo+ID4gSWYgeW91IGNhbiwgcGxlYXNlIGhlbHAgbWUgY29ubmVjdCB3aXRo
ICJMZWUgVHJhZ2VyIiBhbmQgb3RoZXJzIHdobyBleHByZXNzZWQNCj4gaW50ZXJlc3QgaW4gRXRo
ZXJuZXQgUFJCUy4gV2UgYXJlIGhhcHB5IHRvIGFsaWduIGFuZCBzdGFydCBpbXBsZW1lbnRhdGlv
bi4NCj4gPg0KPiANCj4gWW91IGFyZW4ndCBnb2luZyB0byBoYXZlIG11Y2ggbHVjayBpZiB5b3Ug
YXJlIHRyeWluZyB0byByZWFjaCBvdXQgdmlhIGhpcyBNZXRhDQo+IGFkZHJlc3MgYXMgaGUgaGFz
IG1vdmVkIG9udG8gTnZpZGlhIHNvIGhlIGlzIG5vIGxvbmdlciB3b3JraW5nIG9uIHRoZSBmYm5p
Yw0KPiBkcml2ZXIuDQo+IA0KPiBBcyBmYXIgYXMgdGhlIHdvcmsgZG9uZSBtb3N0IG9mIGl0IHdh
cyBpbnRlcm5hbCBhbmQgbWFraW5nIHVzZSBvZiBkZWJ1Z2ZzLiBJIGRvbid0DQo+IGJlbGlldmUg
YW55IG9mIHRoZSB3b3JrIGZvciBmYm5pYyBiZWdhbiB0byBhcHByb2FjaCB0aGUgc3VnZ2VzdGVk
IG1ldGhvZHMgZm9yDQo+IHVwc3RyZWFtbWluZyB0aGUgZmVhdHVyZSBhcyBMZWUgaGFkIGJlZW4g
cHVsbGVkIGludG8gb3RoZXIgZWZmb3J0cy4NCj4gDQo+ID4gQWJvdXQgc3RhbmRhcmRpemluZyBh
Y3Jvc3Mgb3RoZXIgYnVzIGxpa2UgUENJZSBhbmQgVVNCLCBJIGhhZCBhIHF1aWNrIGRpc2N1c3Np
b24NCj4gd2l0aCBvdXIgaW50ZXJuYWwgZGVzaWduZXJzLCBidXQgSSBkaWRuJ3Qgb2JzZXJ2ZSBh
bnkgc3VjaCBTVy1sZXZlbCBjb25maWcga25vYnMNCj4gaW50ZXJlc3QuDQo+ID4gTG9va3MgbGlr
ZSBFdGhlcm5ldCBoYXMgY2xlYXIgaW50ZXJlc3QgYW5kIHdlIGFyZSBqb2luaW5nIHRoYXQgRXRo
ZXJuZXQgUFJCUw0KPiBjb21tdW5pdHkgdG9vLg0KPiANCj4gSSB0aGluayBpdCBsYXJnZWx5IGRl
cGVuZHMgb24gd2hhdCB5b3VyIGltcGxlbWVudGF0aW9uIGxvb2tzIGxpa2UuIFRoZSBwb2ludCBi
ZWluZw0KPiBtYWRlIHdhcyB0aGF0IG1hbnkgb2YgdGhlIFNlckRlcyBQSFlzIG91dCB0aGVyZSBh
cmUgY2FwYWJsZSBvZiB1c2UgaW4gbXVsdGlwbGUNCj4gYXBwbGljYXRpb25zLiBTbyBpbnN0ZWFk
IG9mIGJlaW5nIGEgbmV0d29ya2luZyBkZXZpY2UgeW91IHdvdWxkIGJlIGxvb2tpbmcgYXQgYQ0K
PiBTZXJEZXMgUEhZIHN1Y2ggYXMgdGhvc2UgaW4gIi9kcml2ZXJzL3BoeS8iLg0KPiANCj4gQWxz
byBkbyB5b3Uga25vdyB3aGF0IGxheWVyIGluIHRoZSBQSFkgeW91IGFyZSBpbmplY3RpbmcgdGhp
cyBQUkJTIGF0Pw0KPiBJIHdvdWxkIGJlIGN1cmlvdXMgaWYgdGhpcyBpcyBQQ1Mgb3IgYXQgdGhl
IFBNRCBsZXZlbD8NCj4gDQo+IElmIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHRoZSBQQ1MgbGV2ZWwg
dGhlbiB5ZXMsIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gaGF2ZSBpdCBpbiB0aGUNCj4gbmV0d29y
a2luZyBzdWJzeXN0ZW0gYXMgdGhlIFBDUyBhdCB0aGlzIHBvaW50IGlzIG1vcmUgYSBuZXRkZXYg
c3BlY2lmaWMgc2V0IG9mDQo+IGRyaXZlcnMsIHNlZSAiL2RyaXZlcnMvbmV0L3Bjcy8iLg0KPiAN
Cj4gSW4gdGhlIGNhc2Ugb2YgdGhlIFBNRCB0aGF0IGlzIHdoZXJlIHRoaW5ncyBnZXQgYSBiaXQg
bW9yZSBpbnRlcmVzdGluZy4NCj4gVGhlcmUgaXMgYW4gSUVFRSBjNDUgcmVnaXN0ZXIgZGVmaW5p
dGlvbiB0aGF0IGluY2x1ZGVzIFBSQlMgdGVzdGluZyByZWdpc3RlcnMsDQo+IGhvd2V2ZXIgaW4g
dGhlIGNhc2Ugb2Ygb3VyIGltcGxlbWVudGF0aW9uIHRoZSBQTUQgZG9lc24ndCBmb2xsb3cgdGhh
dA0KPiBzcGVjaWZpY2F0aW9uIGFuZCBmb2xsb3dzIG1vcmUgdGhlICIvZHJpdmVycy9waHkvIiBt
b2RlbC4NCj4gDQo+ID4gRXRoZXJuZXQgUFJCUyBjb25maWd1cmF0aW9uIGFuZCBkaWFnbm9zdGlj
cyBzdXBwb3J0IGlzIHdlbGwgZXN0YWJsaXNoZWQgYW5kDQo+IGFscmVhZHkgd2lkZWx5IHVzZWQg
aW4gZXhpc3RpbmcgRXRoZXJuZXQgU0VSREVTIGRlcGxveW1lbnRzLg0KPiA+IFdlIHRoaW5rIEV0
aGVybmV0IGlzIHRoZSBtb3N0IG5hdHVyYWwgc3RhcnRpbmcgcG9pbnQgd2l0aGluIG5ldGRldiwg
YXMNCj4gPiBpdCBhbGlnbnMgd2l0aCBjdXJyZW50IGRyaXZlciBwcmFjdGljZSBhbmQgZXhpc3Rp
bmcgdmFsaWRhdGlvbiB3b3JrZmxvd3MuDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyBtYW55IG9mIHRo
ZXNlIHBhcnRzIHVzZWQgYXMgYW4gRXRoZXJuZXQgU2VyZGVzIFBNRCBhcmUgcmVhbGx5IGENCj4g
bXVsdGl1c2UgcGFydC4gU28gZm9yIGV4YW1wbGUgaW4gdGhlIGNhc2Ugb2YgdGhlIGhhcmR3YXJl
IGluIEZCTklDIHdlIHVzZSB0aGUNCj4gc2FtZSBwYXJ0IG9uIHRoZSBFdGhlcm5ldCBQSFkgYXMg
d2UgZG8gZm9yIHRoZSBQQ0llDQo+IEdlbjUgUEhZLg0KPiANCj4gVGhlIGNvbXBsaWNhdGlvbiBp
biBvdXIgY2FzZSBpcyB0aGF0IGJvdGggYXJlIGJ1cmllZCBiZWhpbmQgb3VyIEZXIGR1ZSB0byB0
aGUgZmFjdA0KPiB0aGF0IGJvdGggYXJlIHNoYXJlZCBiZXR3ZWVuIHNsaWNlcy4gSG93ZXZlciBm
b3IgdGVzdGluZyBwdXJwb3NlcyBhbmQgc3VjaCB3ZQ0KPiBjb3VsZCBsb29rIGF0IGRpc2FibGlu
ZyB0aGUgb2RkIHNsaWNlcyB0byBlc3NlbnRpYWxseSB1bnNoYXJlIHRoZSBoYXJkd2FyZSBpZiB5
b3UNCj4gbmVlZCBhbm90aGVyIHBsYXRmb3JtIHRvIHRlc3Qgc29tZXRoaW5nIGxpa2UgdGhpcyB3
aXRoLg0K

