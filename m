Return-Path: <netdev+bounces-284507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH8UFnAZ+mmWJQMAu9opvQ
	(envelope-from <netdev+bounces-284507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:23:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F44D1328
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C51C303E4B8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69D15B971;
	Tue,  5 May 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fA4UBdrn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6F48B388
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997803; cv=fail; b=aRkUjW1VV9B0QckWodpB1Ih3Q3XsFug+AHTmVQOGbgwwdTcuGedWWYDxY3BlA2Of2R/uZAvi4NQRvV5KhAYLVWHP4XxATokdG7HqL8lM3XdjIA+484WjWXo1XHZMj+vqDhankzVvSXCZQm9gxbI7Thn24ZdNt48i78LUjxIwiZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997803; c=relaxed/simple;
	bh=7D5rjmxt4bMVuIB0hW0sh0KS/fTZLYn8+nMmDIE5NVA=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7e1CKZ7vEu3tj6IKSgoyLoxWAC2yD6QFpRvr5mTdrAnZEnd8cldV7iHX7bJ6P3DA4062th5K2vDFFGzOQeTQBy3N49KUbuF4nIpOHmVPLDU1CxEGK+V1s715Ik61bEOD1/uy3CRmTfdboUohxZ5Lw/aSONbjS9ugxJz4x/10Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fA4UBdrn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777997799; x=1809533799;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7D5rjmxt4bMVuIB0hW0sh0KS/fTZLYn8+nMmDIE5NVA=;
  b=fA4UBdrnR8X+u4Lxc3aFLGtZqaH8vKoFvR+31hVhkn3yQYzsLC9fq2xp
   BeuezfoF/HmlzjY4Q3a2oUfi9u8I4cpmfJsrbWoGTJp/T68yebizNYT0o
   b8Fk7b4b57HwVL+O2t37HGTGGsiLyT8yehLhBE0gQqTEHM0TzV6kdvMiC
   3x96umW7335ODSHLZamVKxFpzgH+KB7YI2eXj3FAN9Ua9xshmoJJU/W6m
   sf66L5ImkYg2r2i/bWFu1Di8znbXt28gRngxLMyP50ExJz30fIhmEg4LG
   k5cISHBdjadIAy+oQGaF56w8H6VGr6TfBRx4EsURyCOxNZjQ2T10dONG5
   A==;
X-CSE-ConnectionGUID: fkN3V/jjQmibZ9Do0vy+AA==
X-CSE-MsgGUID: X+grs3gpT5ujz1u2VTH/QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78583186"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78583186"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:16:34 -0700
X-CSE-ConnectionGUID: DF6ALJMGSQWCx+MQIkLFJQ==
X-CSE-MsgGUID: H/pljQnOQ4i1QcxdZTN3VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="273986401"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:16:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:16:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:16:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:16:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVT3/acBaAyiukWWMQFY6RZoQMCEPZydy39PeSV2g/L4nkJcjk/6toiS20Os6LrTPBG6+YosGTbmRTgcSdHW2OMf2/vkmNQ9iIM+s9ViIaHIP47zqfMT9QkG8tzvu6UOijFQuf4Pd2bMZBCrMapAnoLKafstEqKWDN4Veox054VCstnVcM6OKIen4FPrzIoKXgK+HihiPXluv1MtycJL8sXDSbn32CIWuFdAGEQp9ljOZX8YQgd+gbCXGnFN/dRvFr5XwkaAzCD+vZUmiMZNuOrEjcRyJ1dCvWO1+NPfyzIA+Xyc5cybsz7xBLpyN8PQTT94K5rbBW8s790PLbtF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dciRcH3XLYbQQ2USgqrk1joTgXMTR9KXG1eDUiKhe+s=;
 b=Oj8VD9yo4WEqJF1gtNz2Az9+zCIoeYe/4ZF4RqDGBjHY7DI6x3ZSUVUojZySwfSkfeVg43dbRuJIdrE86YBsvOCBrs9f0FWIPbj3ThwMS7qWDW4iHOYcdXKPZ/5zzVwGFmGSlq6UBQqqAlUEoUWBygz2npGU0Lu0OGLIMBryzdhd36j48PSj4B3RDPQiGqsChT00rT4L7MSQNZwNHM8HKGUVSVrnYBwQ8z5Yk9AHZOSK3rFpoaa9d8eQ+NAQNzRv9woB+gY0WlFaXCus6+yLss2FN4oKwDk+mhk9Ne80VRKA1fVM3gVle/PZVFRgqYMYDJupsQ+yNTbQWU4Zu2Yh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:16:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 16:16:30 +0000
Message-ID: <41c4fd65-aae0-4bad-b5dc-584ca1702181@intel.com>
Date: Tue, 5 May 2026 18:15:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
References: <20260504152653.1389394-1-kabel@kernel.org>
Content-Language: en-US
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vivien Didelot
	<vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>,
	<netdev@vger.kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260504152653.1389394-1-kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0028.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 6208b3a3-1cac-413c-0e59-08deaac1aaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sQYaf8ipP3Q4qfFZSMIAm+wXeoCpvtBxziE//dK6tRij995iLzWcq41WaNRiiOAeHz4buL8Akpyv+VTApVlidoZbLVTzM7qtTR7/AZmt2o0tR7Xrzk1K5Uh7qytssmLd4ElPo4hY/m8TFpRP388FEYyxqBKGkKDDYmanvUhqxHmKlvTiQmY7nyA1O+wMPYu+kbAUNbIvIejvSmmyNPrX6TUXn1wmHvRnAZVJUpL4HSU1TCeJP/lQvGLkwyOPs8zqxs8egm76qX19PrE6RFw5lW184plfMwxBz9Rq5RGnjFAdN/j2h9NR4ZVZ8HWBkH0JAI7AN0ax0V0PC7Uet6kdh8JorKgcJcaJlq8t/HMO9jW0zUewkF2i5UArMcfrgaEjZAxB75UXptqIxwSOypKjQXF5OZs8NoNpr6uB5CCa4hnvM4BNhuQ/kj9BgXcakj86sqTqLn8lsg6FYy5qr7wphmTHDC1SGjE3gMgmMkENJLelk6uOQgPVkpz+UuarE+/CbwltiNdSQoa4sI+ccIrZmaKwupg9DRtZWlnwmhsyBhcVCkICbLnwZKDxFwl3t6tkPZoZNY+bQa6wKVb+O/1P8M/bgXDqgIUKOb9qxH2ZXxEp5oSBaZER051G45q65WwsW8IyltaI4LhGX9Rqa99ogPDZYcJXZxt38aSSazBiKrJEkSN4qC647YiMsiY7vGKX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01XKzhPTlNhdFVmTC9ETXc1M0tSeDVZT2xzenpvcGUvdkxGTk9lUGtxS2Mr?=
 =?utf-8?B?U2RHWTRCbnFZM2x2V3ZJYWlBcUNrOHQ5TEZJRisrWm5PUFcwUHJjZEpKZDVi?=
 =?utf-8?B?S041YVpBNHpZZG5DcDV5cHhUMnB4MDM5RTZzQ0dGME85eWNqNWxrUDZpYTNI?=
 =?utf-8?B?cnpvb2drVlV2ZlQxanM3Q0pURTFrZXNTa0Z3Vzl2cWtnNDFFOGVmVk5YQ1I4?=
 =?utf-8?B?cHFLZkY4VEh3RW4zQm44Z1VlWHV2ZmxrL0xtbVd5ejNrZzV0aUpLblJjQnBa?=
 =?utf-8?B?R3ZTdk04c09UOUp6ditvUG4zdW5jZkxnTUxXQy9tSnFVTUpsbHBSY3poYWlu?=
 =?utf-8?B?L2kzY0FIV2RkZ0Y4MVhNRHlPcHNaSFhhcG1KWmh6dXRybllscjZWSjVicjB0?=
 =?utf-8?B?Y2NDb3NNOEhmZWpqL2dsVEI2T2NGa1k4RURtNG5iOERCRlp0MkVxdWdEbDUy?=
 =?utf-8?B?dnU4WFhkSXVuRFBKQzJlTE5KZ2Fob1VrRkxSQ2hqODdOdExvbHVtRHdPWVNo?=
 =?utf-8?B?cGx5dHZvL0FjUHB5dE1TVkZSZGlpaXJQc0ZiODBQU1h2VXlGdVA3cEZIYjhz?=
 =?utf-8?B?MlZidW1KaVVNUGRYU1Jkb3FBNkFUYytMS3ZscVV4a1VieWI4U0xHK1liNmZq?=
 =?utf-8?B?T1g2UmpISjJXZjA3bGRkQ0IyNWo2T2hMb3Z0V2lHY05yeDR6UGtvSWpsSGZ3?=
 =?utf-8?B?d3dQUHhEWkxoMkRYVU5KQmMzNHZMalRPaVlVOFB0aVBZLzJyRTJNb2VGcEVY?=
 =?utf-8?B?VlExSStsb0FWTnBqMTdtQ1pBeEx4dnNRYkp6a1JadEF5WlNwNDVaOUZOL3dk?=
 =?utf-8?B?N1NSdHBnL1JINmV2aUY3Ujg2azYxck9GdzVVc01wNmJleXhhZStXcXBlWjdt?=
 =?utf-8?B?Sk9UYjJEakdIWENqTmthUkx6Q21mV0tqbVp0aE9qNE50bis3UlRFNnc4Q1Nv?=
 =?utf-8?B?VGpkV1NnSHB0MmxGb1Z1bFFvKy8zRGhaUmNZbTg4ZTlwWXpSVk9QRncrcHNS?=
 =?utf-8?B?RS82QjdtME1zZ0ZOb1JFRGE2VU1UaVN2TDVxTVlxQ2FYL08xYzJPMitLd1Ri?=
 =?utf-8?B?ejRtYVMzYUdpUEJUMmRnQnh1NnlWOE9VVVMxWitaM3VIRzQxSHNpZVM5TExW?=
 =?utf-8?B?eXV0UzJSSnFWdVVHYTduNm5RLzZNT0NJTFFZT1gzR3ZQeHB6bUpXQmlITnYv?=
 =?utf-8?B?NHRvNVNQTGJnUHM5citnM2ZqdmhYM2kvcFh4Q1RCQWY3bW9uTWV5Q053YTNQ?=
 =?utf-8?B?V1YzNmxIVlFCVDlwZ1lpVXhOR3Y1NngxbkZ6UVZsQzE5ejg4ZjJwNHpPL1V4?=
 =?utf-8?B?SnluOFBZQTFUM1ZTT3lxOXE2ZU10MFE3dkZyUU1UWHU3endocFFGY3lYTXVp?=
 =?utf-8?B?d2dEQ0VEYmdmY293SytodUdWaUpUMEhhTGsxdklVSS9xY3lsajhmdHpYVkp6?=
 =?utf-8?B?TmFsNVdYS0thLys5L2ZuTVFYOEhjR21PQlIrWnJsbk82WDRwVU5QZTd3MUJG?=
 =?utf-8?B?WGdJTGhXdUc1YnQ3ZXdrL01uUm5iaDNDTVBVN05UcnM4Q2J5SnkvckZJc1Vz?=
 =?utf-8?B?bldDN3NITm9vd2p0YU13L3pyTEJ4cFk0US92ZHRvT21lY3VhV3Z6aVU0SWYx?=
 =?utf-8?B?WVNTWXB1b1VCTURERXVnZDlMZWdtbFlLSDZNK2o0WjB2ZEZhZWJ0dHJIZkYw?=
 =?utf-8?B?SjQ0Z0ViSVIvUHBSUU1xZ1lrRTFjemdEdzJJTzhFdzd6MEt0aHZpTU4zSVRZ?=
 =?utf-8?B?UktmZ1REbmgxblVDRG9pY01YMWZSZllobnpLYTR5MDc5TVl4SDJudDlnREg5?=
 =?utf-8?B?cDMxSVlqV295SlFDcCs5dDRYcTBXOUd0ZUo1My8wU0lEd2dMUFF1aURZNW9H?=
 =?utf-8?B?dTNNYnhwdndUNkNzQ0NNS1V6SHNJck9GMWdNYnlwVGJ0SHFkYkFSWTNpazVK?=
 =?utf-8?B?WGh3WFVmdTRjQlErMEdSdi9ja2J0ZWNRem5ZNXJpZHBKY2s5YUplYS9OcWF0?=
 =?utf-8?B?VEszcm83RUdFY2lsS2VJYUVycEdod0cyV1hvMWVGWkdNaUt1d0FLdWtBZXBO?=
 =?utf-8?B?WTBFL2xwalNKaFZEWnpCU0dFbHVMNGRxT1RHandDSUVWUGlOQ3VEUWJ2cjZl?=
 =?utf-8?B?SWpxVUx4Tlk2cFBlNEdwaUU3YVIvbmRoRXIzbzBlYjJHR0dHL3Y5T2VSbzE2?=
 =?utf-8?B?ZzYvald1dWlxQVBKR1lxRGExVjc3R1NpWVlBNXRES3AxUndpWmhNUElZN2hG?=
 =?utf-8?B?S2JFenc4Q2h3OGswK0d0MDJxR0prb2JWdFZhUEM2VDN4RUhpM3ptS3lUQjQ1?=
 =?utf-8?B?QU0rUGZncnZjWEN4ZUFPOG1hZVdrME5NVTMxMXlWTnBuQ01UTTBURXZCY24z?=
 =?utf-8?Q?V0oWhH/K69KcxOcU=3D?=
X-Exchange-RoutingPolicyChecked: o0NPYUs/oEXPcLikvFtisCFBpHoKw/9B24+qTNC+VnFFNKO+BSnIaHdqbOLYhNQOkvhldyn0v+dUDGvJzw/1+PHVBTw97SH3vu86MAT1IDu3D67nsrfKSqWO8HWmyuUMulv8Ba+1hrRbVhsJP4l9Zm0aZ/mBu7xArYThErlOXLRYXmEYW5gbvLl5zZVWdRZ6OWNWKThtEO62L5uwOmgerHSBhqJ6gQ4tr4xoZt9NKYQL3j3Id7WuU+x2lhYC+QXn22/p+ic/bKSUzEWzEFD8JKEeVPpnegqsB3mKKLqvyaAEvLrIq1QK8jPO3WQxjPaa1zXDHSWNTP6gLbunErsyZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6208b3a3-1cac-413c-0e59-08deaac1aaf1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:16:30.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9xkQRcqAIKsxXor+QryrhQbq8CWxItotUsaejzOb7frtp+aX2EpopvabHuwvBU5p7sC/3r4fMzQkM69FX6Vdq60uKL6eIxwsCx8wwjq34o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D71F44D1328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284507-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Marek Behún <kabel@kernel.org>
Date: Mon,  4 May 2026 17:26:53 +0200

> The .port_max_speed_mode() method is not used anymore since commit
> 40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports").
> Drop it.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/dsa/mv88e6xxx/chip.c |  9 -------
>  drivers/net/dsa/mv88e6xxx/chip.h |  4 ----
>  drivers/net/dsa/mv88e6xxx/port.c | 40 --------------------------------
>  drivers/net/dsa/mv88e6xxx/port.h |  9 -------
>  4 files changed, 62 deletions(-)
Thanks,
Olek

