Return-Path: <netdev+bounces-223153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2AB58115
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FC61883543
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD311E8322;
	Mon, 15 Sep 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F082PFVC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2615D1
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950716; cv=fail; b=m/5v4M+iP/w12/yuRp5ml+5jueiL5JNp/oB7XWDuWfJZAkXTpObFpw2AydCEWCgmgVi1FFp1VszAITKN+1s+82HA92aSpo7YkG9z8YjpY40YTbTa2f+nK0aQHsQeSEAFj02Gl3SebwudKBYrSOeZWkGfC8szsSyLlyfWw0pPmt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950716; c=relaxed/simple;
	bh=gVDjtWiZqD6bujCWBGOyA2aZiTS9M/8VAX9gPEJmwoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mvUqRQvxtV//fSaTjq+wSpa9CJ+0kaOq8uhXpEtoxoT9Xuexz+0y0BFDcvu1wy88yier3gzwmBO7Bgz0t+WzAJvXTsQ3P6xCmBbJIu87cfETVSK42nhP8B8npOdsn9p3y2vM8ZKYdtN1dkmsqDAfcSGAhxBFDm1jm0rgp1XRq+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F082PFVC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757950715; x=1789486715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gVDjtWiZqD6bujCWBGOyA2aZiTS9M/8VAX9gPEJmwoA=;
  b=F082PFVCwvaLnwscPcTXtRfxawexGRa+O0UahZH0pDMIPxOtbxdQEFj1
   UBZlcOCyUZTNftGMBCQ7EZI0q3fIpzHpMwepbJhwXEW5AXetJ6sgw4QAq
   wqlgqy4m5UzSD88dvmvb0nSQXgdn8eTHCVqk4Nf5/sGZvwsNmbolXi1h0
   xXuE1AmcEm3iGEvjcfI1Ar9V3zBAERTHbvKz+WRfkN6tcSN5HfkT2mEjU
   F18yMBvtxg6EqcGtx77N364P1kwMRPdMUC92CrkXgnkzicxgJP/yyaaD/
   mvUmqzIe99FJCOCzE2bWT024Z7s7BTVc1bfV1cRMsR08jrVEgd/Hx+5mD
   g==;
X-CSE-ConnectionGUID: /HroZ2ToQoupztyBeLZeZw==
X-CSE-MsgGUID: KE8f6YQlTEezuE59Ezlu8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="85646463"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="85646463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:38:34 -0700
X-CSE-ConnectionGUID: 6DMnHdsnQ6Ow+v9QEj5s/w==
X-CSE-MsgGUID: WMWwUz8eRF6K/NgoRsZ2OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="211844692"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:38:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 08:38:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 08:38:33 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 08:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdYRxzANWSElPk6KgcYqyhqbok2VA2kcJ4yVUaz7uxwhFBRb+OO5/nVr8ag6KO7pljwtMPbutux1V2hfTUTVT++wV2Fmhc8CTfLMh/LzJisPdT31PcQUW4iiq7KTbyvji6sFTgbzfPK1f3Ix/XeK6eSh9HM1FTuBJjLAYeTJdifX0ao1W3l/pD1FvfSxYqkO6qW0DREZmz8oFqXBxDKjaNCgvNXYp2yNeTv6ATytSGlwwyALJtN2WvF8X9WLWj2RWHSKG3L/2QdZOJ61Krk6EZh6aQrRX5IGIHDvxZPf6xv/XGVNyipsKw6RXnwu6wBH21Xw1IWXunXf5Bw98ucGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVDjtWiZqD6bujCWBGOyA2aZiTS9M/8VAX9gPEJmwoA=;
 b=k+Nlq09GBU24JiGFJTqkRUfcOoIUxnt6VOJeEzewi0QzYeNjby9+QVVhYgXLSwMdAY7UTDB64tma7Qou2wrblOlA52e8gARDLBZcPNfL8++0TA6RGYVOdlUBJ8luVSMYEDmQQNS6OJBp+YwfmkQUwqNpvPmoWnlph99t4fGiVEwgV7XI2wiE0lcuWrFlmzBDHXm+2wG82eWCnqoxQdRN3KuFaDBWMq0+EBTEm8xLGZqF0tKTEz0/6XvcBc7GBztoNNbkuzIyXCukZJC2hi4HJiuizsDuFHQzjPTx+cbca/qILhPYeMtWYhtOB1ZwlpAy/ioumAHX+E/+xPoyqCzFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by IA4PR11MB8913.namprd11.prod.outlook.com (2603:10b6:208:565::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 15:38:31 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:38:30 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nadezhdin, Anton"
	<anton.nadezhdin@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] idpf: add HW timestamping
 statistics
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3] idpf: add HW timestamping
 statistics
Thread-Index: AQHcGP3weNRTIJUvgkOg05PVVvBv1LR6HlOAgBpdE+A=
Date: Mon, 15 Sep 2025 15:38:30 +0000
Message-ID: <SJ1PR11MB62973D0C2F5BAD330699DAE19B15A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250829175734.175963-1-anton.nadezhdin@intel.com>
 <22d92b44-887f-4aca-b281-aa5f813d3c3b@intel.com>
In-Reply-To: <22d92b44-887f-4aca-b281-aa5f813d3c3b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|IA4PR11MB8913:EE_
x-ms-office365-filtering-correlation-id: b0f91fea-b86e-4f8c-d2c9-08ddf46dec25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHAyQzBlY3B1NUtpbStZTllON0diZnFiaVVJWUcxNjE3S0dRVSs2ZEhsYnZ0?=
 =?utf-8?B?WkNpdFhKcGFneTBEWGgrY3YxcEtwTE1GdmVnRXJBZU1oWWFNK1ZQVXhvR3M5?=
 =?utf-8?B?SElnQy9zdXArMGtzemMvd1hpRWYvRFNaa3pqaXJaY01SUkZLYnhzc2pTOXkx?=
 =?utf-8?B?bDIwQUplUXNRS05JTkdxVldWTG1HaFFpMGptbGxqM3dFMkhPNUl6WnZrN29T?=
 =?utf-8?B?dFVaSHAwTEhMU2lpRWd3SEgwcDF3UmNQdHZXSy9JUlNpcWxmYzZXTFVpVmNv?=
 =?utf-8?B?SHZQRkgzWlNoZ3h5Y2x0M0U5TVFFbWFJNjZ0V1hqT2RiWG94NHRrZUhBdXRS?=
 =?utf-8?B?dmlZSUZ3bkxYVk90Q0kzdzN6TldkR1VGN2lNV1NNOW8rY0U5QWwxcHoxTXc4?=
 =?utf-8?B?UkFyTHhjSDVwZFJqNzMwcDIrVEY4Nmp1L3ZLeDdBTE1DWll3RTJ0OXZBYnJs?=
 =?utf-8?B?akc0UEJWRUhQYURoV3EvUUprdkhiYnZoS0hlQ1NWOXRhTHQyaWthNDF1YVVB?=
 =?utf-8?B?eDVaOWxUNU9DNXI1R2piV2dQK3F3YVpBVndCZDNhd2h5ODZicklkU09yMzcw?=
 =?utf-8?B?K1Q0NGsveWJncitOUldBQzhCcDI5RUlwWjFESTJ4ZXJjVmhmdmF5bHhuRHNJ?=
 =?utf-8?B?SFhrbTM3MVhjbHZFUUZBeStPc24rVUZVd1hSSmx1Y2lpaXVKakY2cDR0NEEy?=
 =?utf-8?B?czlVd05uRmVMaGlEVlhtblpFTjc1U3BhRnN2M2NqVUlmVGpDN1FZWHdRVUQ4?=
 =?utf-8?B?SjBzei8vSlRpc2VTQlhJb211RlIydzRaVU1razdZK252SFJGWlVYYlIrVWxK?=
 =?utf-8?B?SjM3c0FzSEhiQmVRWlREaGJXKzYremtKMUtIcktDRXNOaXlxRElBRkk0dGdl?=
 =?utf-8?B?ZTFuR1hxRG5qT3pORkJISkp0WGVSdEQzakI2ajZYY29wU01QV2RrY0ViTzg2?=
 =?utf-8?B?eXluaGI0NkVjSmYvRk1ZOTlJOXY1V0NrdSszdUV6SmxKaUQ4cVBvYXFkMExa?=
 =?utf-8?B?cjlSOVBMQTQ4RmMySmo1NXh6SzBWUThCQWNhNFpkakdLYTg2WVEwQ0lhcWx6?=
 =?utf-8?B?OWpxZk5DcjVUdWZPVHQ2ejU0dStXNGlvWDdmTHJSQ05pRDFrYU5kYnJORFUx?=
 =?utf-8?B?UUVCNThTS09DNzZpK25IejhjNjdVaW5xblZIbGgvQU1FYVpQQVF2Y1kvQVZ2?=
 =?utf-8?B?SXFrZHp4MGttZGdkRmpETDBqSjRwYU9HN0hrUWZrZGhqT1ZHMktXUS9pMXBJ?=
 =?utf-8?B?OEZSbjc3QzRHaGhzVi8vejRHM3YyU0RQTTZ1TDBBUmZZSW5iOTdzV21DSk5N?=
 =?utf-8?B?R2VZQXord2hCVVZaSi9iYnI5RkNtOWFkSlZRNGFMWFVmWTVDSUppRUVGN25R?=
 =?utf-8?B?UkdmMmdEcGdjR2g2T0l3NTZJVWN5bEpNRFNBYVlQZGFZMmJzZUVTYjJrN0VW?=
 =?utf-8?B?Q2h6b0E0OUNYSjJpWTJhdG5ydEx6TGczSWxZRzZoVnNEVGV2RVVEdUV6dXZ5?=
 =?utf-8?B?T2FvUHNQTzNDbVdERGVobkR3OTZteU1WbWN3RklpMnlyWktlNEtEZFNPcGdy?=
 =?utf-8?B?c3JNclhLSVNDTk5yOTFqSVIxOTFoSVBzMzJsenVPM05SY2l2NEErbHVtM0dZ?=
 =?utf-8?B?ZWtKQ0dxTHJxMUFmdktzMHBqemdhYWtwTTlocjNsb3RDWnBzV0xheWwwcHRN?=
 =?utf-8?B?cFVTRTZhSEZtVzhYdko1aWdSTnZzRTNVbFZ4YjVUc0ZDVnVmTEhJQ2pxUnhz?=
 =?utf-8?B?Nm8wcHZtbTQ1Ykc1d2J4QmREeFUvUmJSVkMvV2J3QXFZVFR5Tm1oZzR5MXR6?=
 =?utf-8?B?cmdQTjFpcjNmWGl2RHRpVlV3V3RBK2NUOEZSRjFQM0FFVGlFbVFPeFpxaGhW?=
 =?utf-8?B?MzlHdGdLWE9XNGc3UFAydEFCV1BhbTR0RHF4LzNNOU1jRm9SdnRiTFlHeStT?=
 =?utf-8?B?ZXNGNVNwVzRJWkdYYlpxWEVxQWxQTytSdjNUbVRWN1ZpdmN6VkRQRi92MEQw?=
 =?utf-8?Q?HYXZB4+1PmEKhp5DrqInpaEW+LOVbs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdUVTA4Vys3SFE3eEdGY1Y4SzNrdTgzaC8rQVNUaWpQU1FPbk5rOC8yVEdi?=
 =?utf-8?B?dzBSZjR4Z2JiTVdmUWd1VTRodGQraGZKNWprdU9OOStpa1NVdjJ4ZGdBSU5p?=
 =?utf-8?B?RllkcjBnV0hHbFhudVpPT1M5Mys3Z3l6aWVnamZlWmRiZjI3RGo5OHVWblgw?=
 =?utf-8?B?emdXSzRpU1Z6SWJmWWY3K0JXRVRuaStQajNBSGw0bmdTTDdWbU51UG4xQldw?=
 =?utf-8?B?QXZRUEhIZWhaU0VYdkJTY3oyMzAxRFJwVDU1RVA4N25ERFJJZ2VQelpXMWlL?=
 =?utf-8?B?V21yc004MnhvRzVsNTFsMzVueWhaZUVJRVZ0R3lFNmxpWDY3S0RNSjhHVjQ1?=
 =?utf-8?B?ZGtBalJGQnFKRDUwQ2R1VHd3Q0JCbkk3c2hQWCtwRXF0SXdKckVhbmhDYlI0?=
 =?utf-8?B?R3JpQ1RmcURqb3JqNWZWd3pkM2JwK2tQMEFtbHF0OWQ0cjhLY1lzMFkvUmtq?=
 =?utf-8?B?VHZoSGJtdlcwZURyL1VqOHFtaWUrbEpiUm8xK0ZLNTBGQi9YUmhsRDNxeTNT?=
 =?utf-8?B?SG85UWdpMDJ4bFhSclQ4dUd1UE5mQXpqdHVxbi9IalNyTzlsSWQ3a0xtZ0k2?=
 =?utf-8?B?Smx5MllBUGJOS1pSWkFnbTUzRTZDQkxhL2dvNHlRNDd6WVRENkRqK2laMVNx?=
 =?utf-8?B?MXNEUXZJLzV5ZERzVXhLUmVPQzdsR3JSRU4wUU9vRllQc2JSeVFLeWppMDFo?=
 =?utf-8?B?WkdnMmJSampmTjZrTlZuTGRoSk0zY3RIMGxlVTl3Smd4blE4aDI2MTZyZGxI?=
 =?utf-8?B?ejlVWWZMTGV4YkxOY1lvT3ZLNDd5U0tPSXFnSEtxaEJRMjkyRmlONzYrMGxQ?=
 =?utf-8?B?SUEvcE9HL3dkRHU2ZElmclRvZkZmaHZuVEhtNVg4SlNFQ2lJS3VxRE1vbTl4?=
 =?utf-8?B?TzFjNzQyNXM5bWV2UWxjbDd0ZE03cWhRVU02SUZOOWQvSkhkUlNldFN5QjZN?=
 =?utf-8?B?UFZpU3FPTUxteGZjdy9JV3RBVm92SC9MRkpyZ0pjZE1JUFdac0lhbHVXekVi?=
 =?utf-8?B?VVFMSXVBUGpuZlVIcjhENzBmZUF6VjlVY0tlZmo4dU1oTm1JanloQWhEZTYz?=
 =?utf-8?B?dG0wcmhQTUJYZVgvTjNYTzRkVzV4b1BOTGpEL0E1UmdYbDFhRVVLWGJRM3lZ?=
 =?utf-8?B?VTFQdzVTVFlZQks2QmZlSmZlOG9DZVd4eE0wQmpUV0ZVR0dZZitrTXZidTF3?=
 =?utf-8?B?eUxySzBCNjZGaGRJZ3BNRkdBWCtTWHEwQWVSMGNkZUp4QkpVTzk4TFFHMWJt?=
 =?utf-8?B?eFBrRzdCT3pqaitIWE1UR01TNGtRMGZEcVJqeVpQb3o4T0EzVHRrU3JpeHA4?=
 =?utf-8?B?QU9GTDBLTnlFa0VGTlBObEZZWkxpckt0cExKUlhOU2JPSFV4NDRZOGg5Qk42?=
 =?utf-8?B?Z3h5VDAxNGdqNTQ2TkVxcmdGSU15SGFSNXJJVWVtdXkweVgyOWFXMlFydFVN?=
 =?utf-8?B?Rkt6Q09OWkxUaGpva25QZzlKUXlNY0ZOVGRFeFNxL1pKWW9LZHJaVFY4cTg5?=
 =?utf-8?B?SDBWSHFIdStaQlZEM1E5dGlOcGZhdVZ4TnpTNkg3OGZhdFNVZ2N3Wm9RN0tF?=
 =?utf-8?B?K2IyaDZVUzRFbGd5dlFwTHFaYkxMQmdrOVUxWW5tWlBBdjVreDkrd1c0cndU?=
 =?utf-8?B?TnhrVVRZNmd5WE04cUthSTdpcEtoV0hNNzBBZXZzc01PSGoyNFhlN3hWbWJp?=
 =?utf-8?B?TGYvQ1RXRnIzMHZQVERVUVRHYURDK3JxRGZsREMzYWRXa3Zsc1E2Tmt5ei94?=
 =?utf-8?B?bFlqNHNxYlloQ0dTU21VUW9CeE5lSlpRSCtwd1pTRE13WTk1L1hvNnRDLzY4?=
 =?utf-8?B?VW9xenJwT1EzYTlXK1YyQmhnQU5DR2U1clRRNy9UNHRFdDlyOWVtSGQvZWpZ?=
 =?utf-8?B?SklWQUFHK3QwbitmNnowSGJwa25vajJTSTgyVGZWTnRmMXhxNUJ3Z0duakJw?=
 =?utf-8?B?enMxUTJmM0FITzlxMHhrTUpRMzVPSmtYLzhPMGRvL09yekwwcm9CdlQxcWtk?=
 =?utf-8?B?ck5mc3psa0RIMk53elVaV05PRzkydkdLWkt2VXlKS0dNcW4xMEJlVU95MFVv?=
 =?utf-8?B?dW5NNEM0Qjk5RHhJNzVxZWg1R2xsRWlrWkxvajJFYVhyRWx4aGp3eWxLTzVw?=
 =?utf-8?Q?dYkUvgVgXiUhd6FnisvzkPiZG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f91fea-b86e-4f8c-d2c9-08ddf46dec25
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 15:38:30.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+WMwTOCDTlQVjCHxlrDhRCMpC7bCphbiA7EQF38GSBMBeFsjkbI0ByiQ2tz+HNY+bXOT1LYJQBBHdS2aN36/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8913
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBKYWNvYiBL
ZWxsZXINCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjksIDIwMjUgMjowMiBQTQ0KPiBUbzogTmFk
ZXpoZGluLCBBbnRvbiA8YW50b24ubmFkZXpoZGluQGludGVsLmNvbT47IGludGVsLXdpcmVkLQ0K
PiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTmd1
eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgcmljaGFyZGNv
Y2hyYW5AZ21haWwuY29tOyBPbGVjaCwgTWlsZW5hDQo+IDxtaWxlbmEub2xlY2hAaW50ZWwuY29t
PjsgTG9rdGlvbm92LCBBbGVrc2FuZHINCj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0IHYzXSBp
ZHBmOiBhZGQgSFcgdGltZXN0YW1waW5nDQo+IHN0YXRpc3RpY3MNCj4gDQo+IA0KPiANCj4gT24g
OC8yOS8yMDI1IDEwOjU3IEFNLCBBbnRvbiBOYWRlemhkaW4gd3JvdGU6DQo+ID4gRnJvbTogTWls
ZW5hIE9sZWNoIDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkIEhXIHRpbWVz
dGFtcGluZyBzdGF0aXN0aWNzIHN1cHBvcnQgLSB0aHJvdWdoIGltcGxlbWVudGluZw0KPiBnZXRf
dHNfc3RhdHMuDQo+ID4gVGltZXN0YW1wIHN0YXRpc3RpY3MgaW5jbHVkZSBjb3JyZWN0bHkgdGlt
ZXN0YW1wZWQgcGFja2V0cywgZGlzY2FyZGVkLA0KPiA+IHNraXBwZWQgYW5kIGZsdXNoZWQgZHVy
aW5nIFBUUCByZWxlYXNlLg0KPiA+DQo+ID4gTW9zdCBvZiB0aGUgc3RhdHMgYXJlIGNvbGxlY3Rl
ZCBwZXIgdnBvcnQsIG9ubHkgcmVxdWVzdHMgc2tpcHBlZCBkdWUNCj4gPiB0byBsYWNrIG9mIGZy
ZWUgbGF0Y2ggaW5kZXggYXJlIGNvbGxlY3RlZCBwZXIgVHggcXVldWUuDQo+ID4NCj4gPiBTdGF0
aXN0aWNzIGNhbiBiZSBvYnRhaW5lZCB1c2luZyBrZXJuZWwgZXRodG9vbCBzaW5jZSB2ZXJzaW9u
IDYuMTANCj4gPiB3aXRoOg0KPiA+IGV0aHRvb2wgLUkgLVQgPGludGVyZmFjZT4NCj4gPg0KPiA+
IFRoZSBvdXRwdXQgd2lsbCBpbmNsdWRlOg0KPiA+IFN0YXRpc3RpY3M6DQo+ID4gICB0eF9wa3Rz
OiAxNQ0KPiA+ICAgdHhfbG9zdDogMA0KPiA+ICAgdHhfZXJyOiAwDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNaWxlbmEgT2xlY2ggPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+DQo+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBBbnRvbiBOYWRlemhkaW4gPGFudG9uLm5hZGV6aGRpbkBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQW50b24gTmFkZXpoZGluIDxhbnRvbi5uYWRlemhkaW5AaW50ZWwu
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9r
dGlvbm92QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFJldmlld2VkLWJ5OiBKYWNvYiBLZWxs
ZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCg0KVGVzdGVkLWJ5OiBTYW11ZWwgU2FsaW4g
PFNhbXVlbC5zYWxpbkBpbnRlbC5jb20+DQoNCg==

