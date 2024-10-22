Return-Path: <netdev+bounces-137869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1579AA311
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E0282D72
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D719E966;
	Tue, 22 Oct 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kn+4QZ/D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5319DF6A;
	Tue, 22 Oct 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603467; cv=fail; b=m4qaqxlyQH06SjXz2gYqJ5GCiD67u3Em8v92kuTbhc2SLgKE1UZ+SYAztvsuPPmJA2v3YmycfQsb5SNeNLTSZ20JClYuk+6eYrHTBK4735HlFCuqhtasG9NHkahJqaxZjdFp8oaLreBrHNVlLjnM9KnliwlMl9Cf8g/xYQ6nNlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603467; c=relaxed/simple;
	bh=+n8Dlx6kLuCSu7ySw/umBeGlXKnBdEI8yYkavKBjfcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDAYhAObwyLtxSxUx+Fdr4wyf/I5dqXgJe3Pm6ADmE4P2KBnrMacJp5+Tvx0O6Rhikg+M5vd8uP2GcEe5GxpV18FkXgP67uCGEtdy05gcQg+xiFeuFOrghUa81pCDdcEQOlrkjvG5wEgVraxOysbW1ZyWu5bOGsJlUZ+GP2Agr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kn+4QZ/D; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729603466; x=1761139466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+n8Dlx6kLuCSu7ySw/umBeGlXKnBdEI8yYkavKBjfcw=;
  b=kn+4QZ/D7OzjRzygrzIhr//l0e+/SBnSU7yWz/m6iiJRGhQUnsIfkcxL
   TK1r5gDKG70uG3dtO+QRIoSyLDU1vbvvUL3xANgYyL9yWCkQi1WRbocIw
   jd4iM/qEqnbSjr3FyYGIG+zwl5Q4hQHdz9zu1M4OK53ECIylz0QDt3B5P
   Xq9l4V3ErN/glOJrnbZrK9ZfeYwoa4hvc6SiDpejs9MawlKLg3W8JDOVN
   OOSWIkNwYoM8njsfwDRYc/YQbWahlR9T+qiksk6TP5jr5uf7z3kHf/hvj
   VN7gmcEWSj6pKius1KSSXH8WQV+bF5T1k/6PiV3uY99ZnTF69dl8cunkX
   Q==;
X-CSE-ConnectionGUID: gdcg/uf8TpqfYanWkTLTBw==
X-CSE-MsgGUID: UMHQxCyoTjuT/PgHyVQ4Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28568283"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28568283"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:24:24 -0700
X-CSE-ConnectionGUID: cd0njWn9TvW6hHjKLV35+g==
X-CSE-MsgGUID: 4BQtKpcuS8C+EwpItjlZjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84657921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 06:24:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 06:24:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 06:24:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 06:24:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+VbzHE/u7OpGqmWOOuxkSV/+7AAfTzwzIxb3lV4q6We2VLgCjs4gHccVXTGTgjtxOskmp9JB7LeAj8/SJ7NHkQwk2g0+HvN45V8c48AnOpS2zOUI3Sk+S8a1CFtkXCnc/59qYQzgIXZjxk71sU4yB1+z4n+tumDH7dmtDRUj5RxUUUX7sLfZA4FgRhpTtINLf/plnFRSBzIzwU7ihjIivh7oLt8EwR4TSLbKVNVwjzmQULrMQzJ+gMTP5o79dZOnGrUmC+v5HLVl1lypa+72y08MZSnRQ4lPjVHbRilY+h7XCmXo9pABWjzRLI+k7vjoYPIIwx237p/uWIkbxxY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n8Dlx6kLuCSu7ySw/umBeGlXKnBdEI8yYkavKBjfcw=;
 b=jEXqWSIC/vjs5BKZsALgXfX8KZZLZ6lfKHByxqn8MIjCopaV7UpA9yJJ1CcXmKhtZnLqyBr107ePINVe+PiIsFpckAwuqlXKyk2VFAHZqfdEU7uzG8e05nnVsUUjjR/P2i2nDxze7Uo66DeKxDRg3e/EZ3dBi714cI7246me6tJhvU+g1u9U+v+x+fftf+3q3BaWfocJsJu4iwW9KfrRtrxfjEN8l7Bo+jo9vg5Td6aQTxCle4DjkDRWqM/LLspYJcDBpAfCX2jcQ10cUZfn+KEBcza1XeCMjgnRaYODkz0W5DH1Y8rDcnQyETLOjYigmV6sWg5dpBvHOOoLUrs6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB8738.namprd11.prod.outlook.com (2603:10b6:8:192::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Tue, 22 Oct 2024 13:24:20 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:24:20 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 1/2] ptp: add control over HW
 timestamp latch point
Thread-Topic: [Intel-wired-lan] [PATCH net-next 1/2] ptp: add control over HW
 timestamp latch point
Thread-Index: AQHbI8T+Af2gKLBXbUqBk3x6z/Z7+LKRUh+AgAFvN7A=
Date: Tue, 22 Oct 2024 13:24:19 +0000
Message-ID: <DM6PR11MB465775B78DE73254840F44C39B4C2@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
 <20241021141955.1466979-2-arkadiusz.kubalewski@intel.com>
 <15688d2d-b3a0-4730-9cee-15bb6c7f78fb@molgen.mpg.de>
In-Reply-To: <15688d2d-b3a0-4730-9cee-15bb6c7f78fb@molgen.mpg.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB8738:EE_
x-ms-office365-filtering-correlation-id: d80878f3-6673-42b0-b4bd-08dcf29cd615
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmhTVzc0aWNWdmdnYjdHVUVRWVhGWjZwM1VJazZzVUkxQXJnN3ZVSlVBNnA3?=
 =?utf-8?B?dGFZcUZZSE5mWDh3cDZzRU9kYitBeEo4WDNyR1dZYUYyZEIrNlEwYWdiZndD?=
 =?utf-8?B?aWU1cEUrUUpPVHJPY0pGOEVzU0tNVS9lbFppU0VlZU9qTEt5MStuTEdNc09R?=
 =?utf-8?B?WnNjVDVtYXZaZjRKWEhTYmI3c01zTWVMdUxldHZhLzdUNHNHelh2R2lIaUp4?=
 =?utf-8?B?OVhqaGd5enRxSVduUDVHZzg1VzJ3TGRSM0t3a0R6V082Z1ZzTytTTXFoYkZE?=
 =?utf-8?B?eDZJVytOWHZaN3ZDTFBPSWMxbW9WSjl6YloxOHZCdTg2MUI2NmRGOC8zeEJh?=
 =?utf-8?B?ZG5nZWRudjdLem1BTUNNYlJqVTNGdWJxZWhNZlRKTmtLWENqUEx5SkRIKzkx?=
 =?utf-8?B?MmFJUDNmVmlzZTk0dEtIMVlXazBVSWRiM3VqR2dJVzZNVFp4RHZpeXlRUDhm?=
 =?utf-8?B?N0x4SWl2ZHM2ZXpsNFJGUVNITTgwQWd3VUhySjlQazJUaWJwd3krQUtFUGhj?=
 =?utf-8?B?YzhDRlhic2dxRytBRUR1WW42QXFhREM0KzdnS2V1azZDQ0doeEJIODhtZEhD?=
 =?utf-8?B?U2dQcXhrR1NzekVPVFRqbzEwem52R2VGMUFGc3VldGdMbFIzcGRDNXV0WnZz?=
 =?utf-8?B?bXMyV1YvdmZlbVJRd01Zb2Nsc2tMVnYySm9MbWdLb3VkTWtaSGtkUzFESll5?=
 =?utf-8?B?RVNXNEJmRGd3SmZ5b0d4YWUxVUgrWDlvRjdGODRlMk54RGRxM2VPZSt0N2tm?=
 =?utf-8?B?MUlIYXRQdnJSd1prb2NSQXFvVHNjQlltWUF6UytGd1VxUkNVSk5CeUNpNFpx?=
 =?utf-8?B?TlFiUVRzQk1oalc2NEpwVDIwdW80OGxpNXJiM01xUG9SR3NYTHh5VW5CWFdM?=
 =?utf-8?B?RmZVdHBkNnQzZElwUVJLZ2lBUEJOZUZMUVFFeWZKVm5WWlV4YVEwV1FGN3Bo?=
 =?utf-8?B?Y0hmVUtySkZERURDUi8wMUQ2S2w0MUNJaFBGRklYSU9pTlVaWndwemxCNFRj?=
 =?utf-8?B?cU1jdVBTUTZ5RHl3MzhrOFhZZG83VHVsKzVjMzRUV1lPMmxleGE0K0hyU291?=
 =?utf-8?B?SldDdTB3OWFhTm1RTUwvQWZyTWtqeXAyakhOU3Z2S1UyNFlqSUV4VVVRYXVF?=
 =?utf-8?B?YzM3cy84L014Vlp4VHNYYVBUNzFnUEZxcVFIUnBSeTFhd1RtUjcyTVYweGNT?=
 =?utf-8?B?UGxyM0JnN1BXeVpnTHJ4NWNDK2IyM09XVFNSemFXSVMydlpISkZ1dzZyVFhL?=
 =?utf-8?B?cGtqekhxQk4vYWhRdTZWV0dtMC9vNmZXMW9BYmxaTU1xcmRlRjEzak55dTln?=
 =?utf-8?B?TzdaMHlWdlVVQmhEWUZETUpWMExLZWFFWFdWaTZVM0doREdoOUtQRHdYeEtp?=
 =?utf-8?B?SFU5M0NFalE1SHQ4UnRjMDdqQUExbVBieGhBNWJ0ZHdYeXh2QmVhdGtxSWZO?=
 =?utf-8?B?SWZ0RWhtaUc5aHBER1NPUHUzKzhscWdueFJxME5lRmdocUFjZ3BvOHlXK1hj?=
 =?utf-8?B?NWpEYkF0cWN3ZWorY2dhQVBOZUk2WFRTR1ZEWmxIelVXNUhhbU1OalNGdHgw?=
 =?utf-8?B?U2hlWnBXbnJtcVUxdjVIRDFYVFBiQkxVWE51VGtObGNnRGhtMU9JdlBXNm9z?=
 =?utf-8?B?ZU5BdWpsVjgzZysxY0VqQU96ODZCb21hcGdZdG9TM094L1ZsZWorUFBQaDJM?=
 =?utf-8?B?dEVkTTB1T1MzcDhXU2tnaVF5YlRiTWNxd2k2QU0yT3VkVGduMzFZYjlSS211?=
 =?utf-8?Q?Dx33EyIByXNaXN3CgxbfCZDFJfvFccanzrtlALd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhiaGpKUWxKSmhnWVRHSkZwK2tjSCthWTE4ellsMG42TFEwR0laS1hCbi9J?=
 =?utf-8?B?TWNwNWszdFloQVNmNlh5Myt2U3YzbW5TYzBHeDJ5ZzRIWW1pZ3lOdS9WdjJi?=
 =?utf-8?B?ekY3Y29WbXhvL1JTQThaK0NQNHFYOFFXcVNQWlVaUGh4bGVwSXRUS2c2b0JQ?=
 =?utf-8?B?T3VDT2M4YlNvQkRpdFYzSXFCN2E1cXMvOE0xYUZvb1FFellWcU9zQmZsV1B5?=
 =?utf-8?B?RE1BYVQ5MXFpaG1vdGxqeUVhckIrdWxNYWF2c2cwa3pLOWtwbGl6YW5HK2dI?=
 =?utf-8?B?cjVIZ2xFMTFoOUE4YVBhUzR3aXhvalVGM3hvR2ltYmgwS2h2Y0E2cTBuQ3Rl?=
 =?utf-8?B?dDMrOVVOWnNxU29YMVlicDhmOWtNUzRQQ25JMm4wNXlVak5JaUhCOWdpK0c1?=
 =?utf-8?B?V2NiaCtWcTRGM1dqYlgzUlB0VHNFb3FXcmVCUFE2YVRTNElyS2FIZHlqOStP?=
 =?utf-8?B?UXVrbTJGdXJ6eTBmRkNpdEJWRHlOY1l2UjR6dnRCNVg1blVPUE9YUFNtNjMw?=
 =?utf-8?B?anNkQVQ2ZmVFM2IrNURZNzlQL3I5RTkzbGlyQlppM284WVMrNjJ5bVZlNWRr?=
 =?utf-8?B?YVZGZTlBb1diaTFCdEpsWG02MjBhdlBBajdqWUgyS21TWjh2SUdOektzcTEz?=
 =?utf-8?B?aHlJb0NVbkZua3RadWtrQVJ6Z2Q0MnE5LzVFbXovMW9zbms0NldxcU5QaGZS?=
 =?utf-8?B?SWpMZzJzVGN2MnJ0SkVHemx0MUxGc2h4WWlOblpsL1VLRExra1V3cE1VQ2hH?=
 =?utf-8?B?S3BPTEl4UmJrZnNSaWxkSmNxZlM0aTFLaEUzSVIwdWxRVEx1bGZYcXVIVWhK?=
 =?utf-8?B?dTdxdzVtcTZYMFFYTjhnaG53OWE4SEtkWGMxUWRmeU1QMVJzS0dBUm1BQ01r?=
 =?utf-8?B?VW1PcWRXZmlrbzFZcFZxbGJvMHJVQnlvQUU5dE45WlpUSjdKMkJDemFTelVU?=
 =?utf-8?B?eHlCTStPbFE2MVRaTno3ZGxXNDJTb3ptL1FNbnE4YXEycUF1VUNvK3o4bmE5?=
 =?utf-8?B?bE5Vd2ZkSFlyNnVOb3dtci9Wa3ZEUlE1MGRKa1ZYQjArQnFsRC9tL3BtdDV5?=
 =?utf-8?B?cW14SHlTcjRZVlRNcytvYW9pbSszbDBUd0FnK2F3K0tHRG1tNUtnejB2NSs0?=
 =?utf-8?B?bFpOQkRQSXRoN2dpbTJyVmZ2Ty9aazVWL1g0U1hYZzdVcDlLYXNiV2lyblFN?=
 =?utf-8?B?K0lUQlY4R3NWR0I2T21DTnQvQm81WXhhL2c5NHUwd093blFZdjBrMTRXYVE5?=
 =?utf-8?B?Z1VTL01yRkJaTzVqOGZOdGFyL1JWM2hCdDE5QjdIYzB1eUh0TFYvSnRVTVRJ?=
 =?utf-8?B?Nm5YbS82eUhUOXQra0cyclNCUW1OcDJxOFpGcHplbmFBWHM4ZzFwQlo0Q25V?=
 =?utf-8?B?NlVwdFFZS1EzWXRvc1pwQTJmNWgzRTRzTEU5WW9QNjE0aXU5MEU5SEhJK24x?=
 =?utf-8?B?U0tQNUU4QlNNTG9hdDBPTUJJU3dRK0lFS1JpMWl3bis3SmZvbldIelcyUmJs?=
 =?utf-8?B?MkY0T0tLQWt1TGZndURpK010NWlRTy8yMFBuVVVyMTRPQ3hBQ1VaUVRCSkkw?=
 =?utf-8?B?NlIrMndXWXRkaXdacWVOR2dYZmR2UVBOdEczMEp4MUdraUZZT2ttVXJ6UXhU?=
 =?utf-8?B?NnFhRnZ2aTVxWTJhYlVySHpvVFU3aFlPRHNraFJkQXpwQkhPaTVzV25xZTdB?=
 =?utf-8?B?VDBzSW9kOFJrNENnVk9yc3pxWjV2RmlzUmdCUm9JejlVRTBPWDBmYURHdFFN?=
 =?utf-8?B?TkFHMmkxRVZ2L2VhVmNxSk52aDloMmRKeUN2NWs3Z1NzbE9nQTJtV1hNSnlV?=
 =?utf-8?B?cTBXVURxVGVBbWJ1Yk1yNlZ4MkZxM0FrQXg2NDlqVnEwUVE0bzFFdlZ2cjRz?=
 =?utf-8?B?M2k2aXhRYjNzWEtyd1pGajluZVk2UWdGSXNGdFdUQzFNaVl1N1ZvSnpPMkhs?=
 =?utf-8?B?RFdTbEVGdVFWMWoxS3BxaWhFcWNrdDFnMmZvenNhZ0xPTHIxTGpoRGFWUEpa?=
 =?utf-8?B?QkFlWkJiK09Ha3FUZ3lVSHpoYlEyNG8wN2gxdm9XNVg0VmwrVUppUjVqd1pq?=
 =?utf-8?B?SGh5bTJoejA4K0paZjFERVBuZkQ2TDViOUFkK095V09nTUEzTDA4VXRsTFYx?=
 =?utf-8?Q?gDaL5zZlQU/vHZkno59u35eN3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80878f3-6673-42b0-b4bd-08dcf29cd615
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 13:24:19.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uST21x7LYS93RBNP6JLxjd+SVfhHphLl/whu1c3RW1mDelhICZW3Ued0WDZBZA1uUjZo3V2leXvgbmQ6THzLQI2G5iqFkX1Vv6TVCI6RdyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8738
X-OriginatorOrg: intel.com

PkZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+U2VudDogTW9uZGF5
LCBPY3RvYmVyIDIxLCAyMDI0IDU6MjEgUE0NCj4NCj5EZWFyIEFya2FkaXVzeiwNCj4NCj4NCj5U
aGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyENCg0K
Pg0KPkFtIDIxLjEwLjI0IHVtIDE2OjE5IHNjaHJpZWIgQXJrYWRpdXN6IEt1YmFsZXdza2k6DQo+
PiBDdXJyZW50bHkgSFcgc3VwcG9ydCBvZiBQVFAvdGltZXN5bmMgc29sdXRpb25zIGluIG5ldHdv
cmsgUEhZIGNoaXBzIGNhbg0KPj4gYmUNCj4+IGltcGxlbWVudGVkIHdpdGggdHdvIGRpZmZlcmVu
dCBhcHByb2FjaGVzLCB0aGUgdGltZXN0YW1wIG1heWJlIGxhdGNoZWQNCj4+IGVpdGhlciBhdCB0
aGUgYmVnaW5uaW5nIG9yIGFmdGVyIHRoZSBTdGFydCBvZiBGcmFtZSBEZWxpbWl0ZXIgKFNGRCkg
WzFdLg0KPj4NCj4+IEFsbG93IHB0cCBkZXZpY2UgZHJpdmVycyB0byBwcm92aWRlIHVzZXIgd2l0
aCBjb250cm9sIG92ZXIgdGhlIEhXDQo+PiB0aW1lc3RhbXAgbGF0Y2ggcG9pbnQgd2l0aCBwdHAg
c3lzZnMgQUJJLg0KPg0KPlBsZWFzZSBkZXNjcmliZSwgdGhhdCBpdOKAmXMgZG9uZSB1c2luZyBg
L3N5c2AgZmlsZXN5c3RlbS4NCj4NCj5Ib3cgY2FuIHRoaXMgYmUgdGVzdGVkPw0KDQpTdXJlLCB3
aWxsIGFkZCBzb21lIGV4YW1wbGUvZGVzY3JpcHRpb24uDQoNCj4NCj4+IFsxXSBodHRwczovL3d3
dy5pZWVlODAyLm9yZy8zL2N4L3B1YmxpYy9hcHJpbDIwL3RzZV8zY3hfMDFfMDQyMC5wZGYNCj4+
DQo+PiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraSA8YXJr
YWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtcHRwIHwgMTIgKysrKysrKysNCj4+ICAgZHJpdmVycy9wdHAvcHRw
X3N5c2ZzLmMgICAgICAgICAgICAgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gICBpbmNsdWRlL2xpbnV4L3B0cF9jbG9ja19rZXJuZWwuaCAgICB8IDI5ICsrKysrKysrKysr
KysrKysrKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4NSBpbnNlcnRpb25zKCspDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcHRwDQo+PiBiL0Rv
Y3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcHRwDQo+PiBpbmRleCA5YzMxN2FjN2M0N2Eu
LmEwZDg5ZTBmZDcyZSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
c3lzZnMtcHRwDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLXB0cA0K
Pj4gQEAgLTE0MCwzICsxNDAsMTUgQEAgRGVzY3JpcHRpb246DQo+PiAgIAkJUFBTIGV2ZW50cyB0
byB0aGUgTGludXggUFBTIHN1YnN5c3RlbS4gVG8gZW5hYmxlIFBQUw0KPj4gICAJCWV2ZW50cywg
d3JpdGUgYSAiMSIgaW50byB0aGUgZmlsZS4gVG8gZGlzYWJsZSBldmVudHMsDQo+PiAgIAkJd3Jp
dGUgYSAiMCIgaW50byB0aGUgZmlsZS4NCj4+ICsNCj4+ICtXaGF0OgkJL3N5cy9jbGFzcy9wdHAv
cHRwPE4+L3RzX3BvaW50DQo+PiArRGF0ZToJCU9jdG9iZXIgMjAyNA0KPj4gK0NvbnRhY3Q6CUFy
a2FkaXVzeiBLdWJhbGV3c2tpIDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+PiAr
RGVzY3JpcHRpb246DQo+PiArCQlUaGlzIGZpbGUgcHJvdmlkZXMgY29udHJvbCBvdmVyIHRoZSBw
b2ludCBpbiB0aW1lIGluDQo+PiArCQl3aGljaCB0aGUgSFcgdGltZXN0YW1wIGlzIGxhdGNoZWQu
IEFzIHNwZWNpZmllZCBpbiBJRUVFDQo+PiArCQk4MDIuM2N4LCB0aGUgbGF0Y2ggcG9pbnQgY2Fu
IGJlIGVpdGhlciBhdCB0aGUgYmVnaW5uaW5nDQo+PiArCQlvciBhZnRlciB0aGUgZW5kIG9mIFN0
YXJ0IG9mIEZyYW1lIERlbGltaXRlciAoU0ZEKS4NCj4+ICsJCVZhbHVlICIwIiBtZWFucyB0aGUg
dGltZXN0YW1wIGlzIGxhdGNoZWQgYXQgdGhlDQo+PiArCQliZWdpbm5pbmcgb2YgdGhlIFNGRC4g
VmFsdWUgIjEiIG1lYW5zIHRoYXQgdGltZXN0YW1wIGlzDQo+PiArCQlsYXRjaGVkIGFmdGVyIHRo
ZSBlbmQgb2YgU0ZELg0KPg0KPldvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gbGV0IGl0IGJlIGNvbmZp
Z3VyZWQgYnkgc3RyaW5ncywgc28gaXTigJlzIGNsZWFyLA0KPndoYXQgdGhlIHZhbHVlcyBtZWFu
Pw0KPg0KPjEuICBiZWdpbm5pbmdfb2Zfc2ZkDQo+Mi4gIGVuZF9vZl9zZmQNCg0KQWN0dWFsbHkg
SSBkb24ndCBoYXZlIHN0cm9uZyBvcGluaW9uIGhlcmUuIEkgZG9uJ3Qga25vdyBtdWNoIHN5c2Zz
IGZpbGVzIHdoaWNoDQp0YWtlIHN0cmluZ3MgYXMgYXJndW1lbnRzLCB0aHVzIHN0YXJ0ZWQgd2l0
aCBudW1lcmljIHZhbHVlcy4gQW5kIGZyb20NCidjb25zaXN0ZW5jeScgcGVyc3BlY3RpdmUgaXQg
aXMgbXVjaCBtb3JlIGNvbW1vbiB0byB1c2UgbnVtZXJpYyBlbnVtIHZhbHVlcy4NCg0KQnV0LCBh
cyBJIHNhaWQsIEkgY291bGQgY2hhbmdlIGl0LCBqdXN0IG5vdCBzdXJlIGlmIHRoYXQgaXMgYWN0
dWFsbHkgYmV0dGVyLg0KDQpBbnkgb3RoZXIgb3BpbmlvbnM/DQoNCj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3B0cC9wdHBfc3lzZnMuYyBiL2RyaXZlcnMvcHRwL3B0cF9zeXNmcy5jDQo+PiBp
bmRleCA2YjFiOGY1N2NkOTUuLjdlOWY2ZWYzNjhiNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
cHRwL3B0cF9zeXNmcy5jDQo+PiArKysgYi9kcml2ZXJzL3B0cC9wdHBfc3lzZnMuYw0KPj4gQEAg
LTI4LDYgKzI4LDQ2IEBAIHN0YXRpYyBzc2l6ZV90IG1heF9waGFzZV9hZGp1c3RtZW50X3Nob3co
c3RydWN0IGRldmljZQ0KPj4gKmRldiwNCj4+ICAgfQ0KPj4gICBzdGF0aWMgREVWSUNFX0FUVFJf
Uk8obWF4X3BoYXNlX2FkanVzdG1lbnQpOw0KPj4NCj4+ICtzdGF0aWMgc3NpemVfdCB0c19wb2lu
dF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUNCj4+ICph
dHRyLA0KPj4gKwkJCSAgICAgY2hhciAqcGFnZSkNCj4+ICt7DQo+PiArCXN0cnVjdCBwdHBfY2xv
Y2sgKnB0cCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4gKwllbnVtIHB0cF90c19wb2ludCBw
b2ludDsNCj4+ICsJaW50IGVycjsNCj4+ICsNCj4+ICsJaWYgKCFwdHAtPmluZm8tPmdldF90c19w
b2ludCkNCj4+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4+ICsJZXJyID0gcHRwLT5pbmZvLT5n
ZXRfdHNfcG9pbnQocHRwLT5pbmZvLCAmcG9pbnQpOw0KPj4gKwlpZiAoZXJyKQ0KPj4gKwkJcmV0
dXJuIGVycjsNCj4+ICsNCj4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQocGFnZSwgIiVkXG4iLCBwb2lu
dCk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBzc2l6ZV90IHRzX3BvaW50X3N0b3JlKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0DQo+PiBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPj4gKwkJ
CSAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQ0KPj4gK3sNCj4+ICsJc3RydWN0
IHB0cF9jbG9jayAqcHRwID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiArCWVudW0gcHRwX3Rz
X3BvaW50IHBvaW50Ow0KPj4gKwlpbnQgZXJyOw0KPj4gKwl1OCB2YWw7DQo+PiArDQo+PiArCWlm
ICghcHRwLT5pbmZvLT5zZXRfdHNfcG9pbnQpDQo+PiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+
PiArCWlmIChrc3RydG91OChidWYsIDAsICZ2YWwpKQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
PiArCWlmICh2YWwgPiBQVFBfVFNfUE9JTlRfTUFYKQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
PiArCXBvaW50ID0gdmFsOw0KPj4gKw0KPj4gKwllcnIgPSBwdHAtPmluZm8tPnNldF90c19wb2lu
dChwdHAtPmluZm8sIHBvaW50KTsNCj4+ICsJaWYgKGVycikNCj4+ICsJCXJldHVybiBlcnI7DQo+
PiArDQo+PiArCXJldHVybiBjb3VudDsNCj4+ICt9DQo+PiArc3RhdGljIERFVklDRV9BVFRSX1JX
KHRzX3BvaW50KTsNCj4+ICsNCj4+ICAgI2RlZmluZSBQVFBfU0hPV19JTlQobmFtZSwgdmFyKQkJ
CQkJCVwNCj4+ICAgc3RhdGljIHNzaXplX3QgdmFyIyNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYs
CQkJCVwNCj4+ICAgCQkJICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKnBh
Z2UpCVwNCj4+IEBAIC0zMzUsNiArMzc1LDcgQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnB0
cF9hdHRyc1tdID0gew0KPj4gICAJJmRldl9hdHRyX3Bwc19lbmFibGUuYXR0ciwNCj4+ICAgCSZk
ZXZfYXR0cl9uX3ZjbG9ja3MuYXR0ciwNCj4+ICAgCSZkZXZfYXR0cl9tYXhfdmNsb2Nrcy5hdHRy
LA0KPj4gKwkmZGV2X2F0dHJfdHNfcG9pbnQuYXR0ciwNCj4+ICAgCU5VTEwNCj4+ICAgfTsNCj4+
DQo+PiBAQCAtMzYzLDYgKzQwNCw5IEBAIHN0YXRpYyB1bW9kZV90IHB0cF9pc19hdHRyaWJ1dGVf
dmlzaWJsZShzdHJ1Y3QNCj4+IGtvYmplY3QgKmtvYmosDQo+PiAgIAl9IGVsc2UgaWYgKGF0dHIg
PT0gJmRldl9hdHRyX21heF9waGFzZV9hZGp1c3RtZW50LmF0dHIpIHsNCj4+ICAgCQlpZiAoIWlu
Zm8tPmFkanBoYXNlIHx8ICFpbmZvLT5nZXRtYXhwaGFzZSkNCj4+ICAgCQkJbW9kZSA9IDA7DQo+
PiArCX0gZWxzZSBpZiAoYXR0ciA9PSAmZGV2X2F0dHJfdHNfcG9pbnQuYXR0cikgew0KPj4gKwkJ
aWYgKCFpbmZvLT5nZXRfdHNfcG9pbnQgJiYgIWluZm8tPnNldF90c19wb2ludCkNCj4+ICsJCQlt
b2RlID0gMDsNCj4+ICAgCX0NCj4+DQo+PiAgIAlyZXR1cm4gbW9kZTsNCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3B0cF9jbG9ja19rZXJuZWwuaA0KPj4gYi9pbmNsdWRlL2xpbnV4L3B0
cF9jbG9ja19rZXJuZWwuaA0KPj4gaW5kZXggYzg5MmQyMmNlMGE3Li45MjFkNjYxNWJkMzkgMTAw
NjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3B0cF9jbG9ja19rZXJuZWwuaA0KPj4gKysrIGIv
aW5jbHVkZS9saW51eC9wdHBfY2xvY2tfa2VybmVsLmgNCj4+IEBAIC01NSw2ICs1NSwyMyBAQCBz
dHJ1Y3QgcHRwX3N5c3RlbV90aW1lc3RhbXAgew0KPj4gICAJY2xvY2tpZF90IGNsb2NraWQ7DQo+
PiAgIH07DQo+Pg0KPj4gKy8qKg0KPj4gKyAqIGVudW0gcHRwX3RzX3BvaW50IC0gcG9zc2libGUg
dGltZXN0YW1wIGxhdGNoIHBvaW50cyAoSUVFRSA4MDIuM2N4KQ0KPj4gKyAqIEBQVFBfVFNfUE9J
TlRfU0ZEOiAgICAgIHRpbWVzdGFtcCBsYXRjaGVkIGF0IHRoZSBiZWdpbm5pbmcgb2Ygc2VuZGlu
Zw0KPj4gU3RhcnQNCj4NCj5UaGUgYWxpZ25tZW50IG9mIHRoZSBzdGFydCBvZiB0aGUgZGVzY3Jp
cHRpb24gbG9va3Mgc3RyYW5nZSB3aXRoIHRoZQ0KPnNlY29uZCBsaW5lIGJlaW5nIGZ1cnRoZXIg
cmlnaHQuDQo+DQoNClRydWUsIHdpbGwgdHJ5IHRvIGZpeCBpdC4NCg0KPj4gKyAqCQkJICAgb2Yg
RnJhbWUgRGVsaW1pdGVyIChTRkQpDQo+PiArICogQFBUUF9UU19QT0lOVF9QT1NUX1NGRDogdGlt
ZXN0YW1wIGxhdGNoZWQgYWZ0ZXIgdGhlIGVuZCBvZiBzZW5kaW5nDQo+PiBTdGFydA0KPj4gKyAq
CQkJICAgb2YgRnJhbWUgRGVsaW1pdGVyIChTRkQpDQo+PiArICovDQo+PiArZW51bSBwdHBfdHNf
cG9pbnQgew0KPj4gKwlQVFBfVFNfUE9JTlRfU0ZELA0KPj4gKwlQVFBfVFNfUE9JTlRfUE9TVF9T
RkQsDQo+PiArDQo+PiArCS8qIHByaXZhdGU6ICovDQo+PiArCV9fUFRQX1RTX1BPSU5UX01BWA0K
Pj4gK307DQo+PiArDQo+PiArI2RlZmluZSBQVFBfVFNfUE9JTlRfTUFYIChfX1BUUF9UU19QT0lO
VF9NQVggLSAxKQ0KPj4gKw0KPj4gICAvKioNCj4+ICAgICogc3RydWN0IHB0cF9jbG9ja19pbmZv
IC0gZGVzY3JpYmVzIGEgUFRQIGhhcmR3YXJlIGNsb2NrDQo+PiAgICAqDQo+PiBAQCAtMTU5LDYg
KzE3NiwxNCBAQCBzdHJ1Y3QgcHRwX3N5c3RlbV90aW1lc3RhbXAgew0KPj4gICAgKiAgICAgICAg
ICAgICAgICBzY2hlZHVsaW5nIHRpbWUgKD49MCkgb3IgbmVnYXRpdmUgdmFsdWUgaW4gY2FzZQ0K
Pj4gZnVydGhlcg0KPj4gICAgKiAgICAgICAgICAgICAgICBzY2hlZHVsaW5nIGlzIG5vdCByZXF1
aXJlZC4NCj4+ICAgICoNCj4+ICsgKiBAc2V0X3RzX3BvaW50OiBSZXF1ZXN0IGNoYW5nZSBvZiB0
aW1lc3RhbXAgbGF0Y2ggcG9pbnQsIGFzIHRoZQ0KPj4gdGltZXN0YW1wDQo+PiArICogICAgICAg
ICAgICAgICAgY291bGQgYmUgbGF0Y2hlZCBhdCB0aGUgYmVnaW5uaW5nIG9yIGFmdGVyIHRoZSBl
bmQgb2YNCj4+IHN0YXJ0DQo+PiArICogICAgICAgICAgICAgICAgZnJhbWUgZGVsaW1pdGVyIChT
RkQpLCBhcyBkZXNjcmliZWQgaW4gSUVFRSA4MDIuM2N4DQo+PiArICogICAgICAgICAgICAgICAg
c3BlY2lmaWNhdGlvbi4NCj4+ICsgKg0KPj4gKyAqIEBnZXRfdHNfcG9pbnQ6IE9idGFpbiB0aGUg
dGltZXN0YW1wIG1lYXN1cmVtZW50IGxhdGNoIHBvaW50LA0KPj4gY291bnRlcnBhcnQgb2YNCj4+
ICsgKiAgICAgICAgICAgICAgICAuc2V0X3RzX3BvaW50KCkgZm9yIGdldHRpbmcgY3VycmVudGx5
IGNvbmZpZ3VyZWQNCj4+IHZhbHVlLg0KPj4gKyAqDQo+PiAgICAqIERyaXZlcnMgc2hvdWxkIGVt
YmVkIHRoZWlyIHB0cF9jbG9ja19pbmZvIHdpdGhpbiBhIHByaXZhdGUNCj4+ICAgICogc3RydWN0
dXJlLCBvYnRhaW5pbmcgYSByZWZlcmVuY2UgdG8gaXQgdXNpbmcgY29udGFpbmVyX29mKCkuDQo+
PiAgICAqDQo+PiBAQCAtMTk1LDYgKzIyMCwxMCBAQCBzdHJ1Y3QgcHRwX2Nsb2NrX2luZm8gew0K
Pj4gICAJaW50ICgqdmVyaWZ5KShzdHJ1Y3QgcHRwX2Nsb2NrX2luZm8gKnB0cCwgdW5zaWduZWQg
aW50IHBpbiwNCj4+ICAgCQkgICAgICBlbnVtIHB0cF9waW5fZnVuY3Rpb24gZnVuYywgdW5zaWdu
ZWQgaW50IGNoYW4pOw0KPj4gICAJbG9uZyAoKmRvX2F1eF93b3JrKShzdHJ1Y3QgcHRwX2Nsb2Nr
X2luZm8gKnB0cCk7DQo+PiArCWludCAoKnNldF90c19wb2ludCkoc3RydWN0IHB0cF9jbG9ja19p
bmZvICpwdHAsDQo+PiArCQkJICAgIGVudW0gcHRwX3RzX3BvaW50IHBvaW50KTsNCj4+ICsJaW50
ICgqZ2V0X3RzX3BvaW50KShzdHJ1Y3QgcHRwX2Nsb2NrX2luZm8gKnB0cCwNCj4+ICsJCQkgICAg
ZW51bSBwdHBfdHNfcG9pbnQgKnBvaW50KTsNCj4+ICAgfTsNCj4+DQo+PiAgIHN0cnVjdCBwdHBf
Y2xvY2s7DQo+DQo+DQo+S2luZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0KVGhhbmsgeW91IQ0KQXJr
YWRpdXN6DQo=

