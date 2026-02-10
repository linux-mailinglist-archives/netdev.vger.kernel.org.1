Return-Path: <netdev+bounces-258164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCHbHHW3i2kKZAAAu9opvQ
	(envelope-from <netdev+bounces-258164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 23:55:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E511FDA2
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 23:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C2C3037881
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F243126A0;
	Tue, 10 Feb 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aug3/yS1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73930BF69;
	Tue, 10 Feb 2026 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764146; cv=fail; b=AXxSqJ7YOExfINDLuG2WFMd1GG+5HnpwZjgbDvMGJBh4qs2o75mPfajkyaaB7MUkkZe3d1cYBId9vlVa+xcx3dtLOlV5q4xfHpYiYubWErc8TnAfRFAItMELa+tuo+Yx7NmuFJzhIhlh4w3ekBVdvkGKMvKKcdyhCLnaTTZ3mGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764146; c=relaxed/simple;
	bh=ZPHMb4iqDqjCoMx9IFDnrwyveU9qNm3OpKkk8KrVbpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dj9+JAEoOPHs/QUNavLgTOXlSnTACLFvHp4dEIFrvkPyYXrPHiXfTIXQ0ypL2iAlT20x4C8joyFzUrnbpd1PPoTLEzmxo8YCvMadaguS8MchGU2LWypeMIrLZ+GqLhC48Y1sHP3pGBfO7IlIAszw9jrbLgMT5ecJjd3zwkqiICg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aug3/yS1; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770764146; x=1802300146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZPHMb4iqDqjCoMx9IFDnrwyveU9qNm3OpKkk8KrVbpA=;
  b=aug3/yS12uiAJlHle5F2+VoGBC5l5bK6wtPKqabAKV8vwcz7HKXkHdaP
   lStQBjUP0V+O8icDLn7n8v5yYRhV30m+BfIIyByfCu8FQJ37cLHeKIStU
   rNjbZMf4lsLhjFTnMcpAZKszrD+J0+zAWQASD7iZ9RXQ1OI6LagbHalCV
   i4LaxqpE84Rrz6OHmneg8z1HpDx7Wjkd9CmPLdZk3906r3GuiemIuqytt
   lUZmeY1m6HdAHJC0P29EGxrio6q3EDe1YP9dx+vWvhlMSMYhZaMdCSvaN
   xzgNgnfICsN/WXLJSmb/9frFx+REnFZPwMwmtBBrZCBzLAkyeHDG7Sl0S
   g==;
X-CSE-ConnectionGUID: kIAuDW5mSCy/qCV6OF22RQ==
X-CSE-MsgGUID: Upu05n+NRy+ryisgelex6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75750404"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75750404"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:55:45 -0800
X-CSE-ConnectionGUID: OnsQwEE3SNeUwnGzPKjroQ==
X-CSE-MsgGUID: WkTcHjBLSdyyrYBMG6C6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212150903"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:55:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 14:55:43 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 14:55:43 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 14:55:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D57RqgNcxBzzWRdbXaHtclzGdgOJyCUxlDynDLWPuRLL/vlxLDrqeVkz8QjylpFsvWkfVL1oeasFxLuZGBgNZ3+eNtTnWbjoxDNMq3ke0dHMCNtX+k5NMOpb14PuJW0W3/vFaDIm8lmePsVgUPPMLBvruTjXIbO6WyQ38I90Bq78TQfEPArtQgvpxwSQvMOFFx7Oku2ON1lMlUElToH4X+vAJ4FHWg5IucY//tLwCvR1N6RZCSAZgEoHe8cDpXeKAoYr1cI1C1EMVaJw1MtlkywLSkAbgXH15yo57kjOJ4K/Ds2MEENw+0nPwBWzESPR7q51YgBIgbsc43W3VPHM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPHMb4iqDqjCoMx9IFDnrwyveU9qNm3OpKkk8KrVbpA=;
 b=YuwVcD5bQPM9tRwWJeBJh4RmQmbJ6kscAGRDWU8yI7VZmPtybROs7BOlRhE50By5xqb0FyZrctV1tiRQnddNBRlH24AsNbaTkPvLzjTXt4LxCZpzQzld4pwNNnk8UmA6zSULkHMeYeZrnw3eloEYsgsC+15jL6S6tcURVy4Hoytk5N7LxDgSfvfe/94tWUhOEwpt3kIFYtEEkaYY12C/RkilAHtzo5y+5mVvRCmYLOvgBJ2mGUCIMvWWOPbXI2x3G971ZSzwcDkscFXvhlwNhhmAziNbA3SdKSayTSGSee0cTxiXLUO4OkhP0dKfPrK8sw+9UoZdEYfd4sTg+xT3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 22:55:40 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 22:55:40 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, "mike.marciniszyn@gmail.com"
	<mike.marciniszyn@gmail.com>, Alexander Duyck <alexanderduyck@fb.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "kernel-team@meta.com" <kernel-team@meta.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, "Russell
 King" <linux@armlinux.org.uk>, Mohsin Bashir <mohsin.bashr@gmail.com>, "Lee
 Trager" <lee@trager.us>, Dan Carpenter <dan.carpenter@linaro.org>, Pei Xiao
	<xiaopei01@kylinos.cn>, Stanislav Fomichev <sdf@fomichev.me>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v12 3/5] eth fbnic: Add msix self test
Thread-Topic: [PATCH net-next v12 3/5] eth fbnic: Add msix self test
Thread-Index: AQHcl39ILV1f3NqYKUiKhyFvFR6IFLV8DqWAgACDA9A=
Date: Tue, 10 Feb 2026 22:55:39 +0000
Message-ID: <PH0PR11MB75889BAC137B53534428EB87D662A@PH0PR11MB7588.namprd11.prod.outlook.com>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
 <20260206154246.814-4-mike.marciniszyn@gmail.com>
 <e806861b-acd4-4615-aada-577e0275bb5d@redhat.com>
In-Reply-To: <e806861b-acd4-4615-aada-577e0275bb5d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7588:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: e8ee843b-3a9d-46a3-829c-08de68f78332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?N2hJTGZIbzkwN0lCQmtpTW9BT1lCMlB2Vk0wVWZKU003QnBoLzFYMWJaUFRU?=
 =?utf-8?B?ZEhBUnd6YU94ODRaaytvMkFMSzczbFFDSVloR0FyYURvRHRXY1FFSzlzcDlW?=
 =?utf-8?B?YzBLanFkSlB2V0JGN2ZYTHJvM2Exb0VWQnJKaTErTmxYd0pVMzhTZDFYNVYz?=
 =?utf-8?B?THFJUlYraEdUNEVYeU5YQUEwZEhLaG1WWmEzUmR3V0NsbFlITDBwVGlHN0NR?=
 =?utf-8?B?UEFRSGRPQ3plRnJkVWx1UGdweWVNMFlMTitJNEp4RGZvQTg1QnZmb0F2Mkth?=
 =?utf-8?B?TVJSYTVmRTcrQ3UzU0gzNTNZcEZObTAwTXVuTnVzL3JTTUJmdHZWTU9PZG41?=
 =?utf-8?B?Yk00V2V6SnN5QTk4cURXMlRsdEtiWkpEM3hRd3FiSjkvVHBXbnNVZ1VXNk51?=
 =?utf-8?B?ZDdiNGtOcng3TiswV1V5enlUK2F5TWZyaTNKTHY3UUhOMnZRWnJCdG5MUytl?=
 =?utf-8?B?V0VhOUtQMEVCcndrNFB6TlBrZllTeS9tT1lwT005U2NXS0dJL1RxRlQzelRy?=
 =?utf-8?B?OVlqTlU5Y0g0eUN2VHE2OER0UEpSa0RKM2lKWXRwLzdFQVc4cHI1c1R6cjBo?=
 =?utf-8?B?MFc2cEpmVjFiN0Y2OHFHeklhdVhkakNLRFZ4L3hSUWRSejNIcU1yK3N6OWVz?=
 =?utf-8?B?S05HaXUrZkNYME5wcTFoOFJoZFRrZnZ3bVVUUXo2eVFnZEtiSGhKV3VBaFUr?=
 =?utf-8?B?ajQvOXBkYWpvcjNnNW5DTkt1SEFDWEZIUkNTeUpWTm1PeVQzVjZwWitUc2Yy?=
 =?utf-8?B?WVJPMmlob2RBUldkb1ozMlpuZ2RQU0tqMkdhUEN3VXRUd1dTZGFsVFU0bzAz?=
 =?utf-8?B?aG9PTEtBNVhQTXY1MngwcVN0eTlxTkVKdjZ5bTBSQ2tRVUxBVlZ4c3BGaVJ4?=
 =?utf-8?B?cUdKOCtzM3RzTCs1TDVFanR0R3hoelBZeWJwZDJoMlNiLy80UFprdldxSHo5?=
 =?utf-8?B?aEtPcnJ3dHVvNWFabUxvRUFUWks0ZWwwOC93TnNjcXJZUEUzRWtwWXEvd0Ey?=
 =?utf-8?B?TmhUaTk5NC9CMTdPRGtCRnlWZUswVEVPL2V4Z2ZRa1RzOC80UjhDQUNBL09F?=
 =?utf-8?B?OVVzNEZENzdGd0pXYzh5ci9zcG4yWmNvTW1KZ1cvbTVMd1FmT09IQWFFUCtK?=
 =?utf-8?B?VTVvbElWSnlXdURYemUyZVhoc2hqTXdaaTI4WTBGNEZyKzAwaEZ6Tm1HRDBu?=
 =?utf-8?B?aVVQcFN3eU85NGxzSnZscnByNGFhSXNjZ2hLTC9ZYmxwTUhZaVZXeDlTVGdj?=
 =?utf-8?B?VXdvWnE4bmpTd3UyMDE0cHR0ZFZTWk4weXJvSDAwU2l3a2M2Zmx1K3pXVk9m?=
 =?utf-8?B?YWtnQU00NWRmaThqZEF1TnM4RTlpTDQxWG1HSHVqYjVQdjdrL3NkRDh1N282?=
 =?utf-8?B?SHZ2a1FRZjYzUmU3M1dVRVR5RVhGZXdrSU1Ka09qTWtGT2N4V0lBazV0MGJD?=
 =?utf-8?B?ZnZubnh0UHRGL1JuQlQzYkx0VHJxdDF5ZTJxd0t5Vm9NamlRbjQ5NCtrQmFq?=
 =?utf-8?B?NHVrcWErNVhCdzRmbnpvRHA4cHkzSmxwRDRiNkRLTnRrSThhQWxDYkx1Y2Rr?=
 =?utf-8?B?MTdSamc4ZW1tOTJJN2JjYlRzQ1V6TnRUM3FmREgveXh4Mkx4ekxLRDl4Nlo1?=
 =?utf-8?B?UVpLWDJuNTAvaGN4TTE0UFFneFpScFJrdHgwS2VKdVh2dE91SzlITmZjK1hM?=
 =?utf-8?B?Z1FkYndOQjFiK2pLamU2di9oNEd6OG50Sm5wMjRqMXRLbG4rQi9TdE1CSjVR?=
 =?utf-8?B?ck1sVFoxT2J3SkoyQ3pDdzNlMTZ3VTUyaW5WWEJDVTRSeDdIajJjcWlXUnpM?=
 =?utf-8?B?WmNieG0xbEJ4bjBDZ21EOEMzNi9xeXlTVkRYL2VqczErSE1pZzNNOFQzWm94?=
 =?utf-8?B?UHNHY1ArOWJQMVZySDR6eWgvSVRUNSs1UUEwTjlqSCtiSStkdVN1US9XbEh5?=
 =?utf-8?B?SXhBMzlpZjlTV3QwS2ZjSUZPcTdhQU5qaWszSysyMGF4aEZBVlg5M1JwSFdq?=
 =?utf-8?B?bkptM3NSUVRzUTNDUzBWVTFha0RNLzRYSUNBZmlYN3MvWWtkSHlQVytGZ3Vj?=
 =?utf-8?B?RmErOUUwT0YzTU5TMUNYWXdSYnZ5RzVDbTJzUFhSMHhaRnRHbWFZVWFaaStt?=
 =?utf-8?B?Q2ZrZUJCNHpIWnRXakxiajRtR0xMSE9IcWNOOHRRdVhaYWE4VzZxVC92L3pw?=
 =?utf-8?Q?2SbyUVxXdEV3qlPeL56OZmmjiN8qfBrM3YM18QJ2319H?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWF5eDdEWnB2UW9tenh0dWVIN2FSWTZGU1E4aERveUw5UGtPMGpNTTlvd1JQ?=
 =?utf-8?B?NmN1bXpTK1J6dW1tdk5UMUlCdUpVbE9oUHBvb3pnM2hhcjdhbTZMRmMwdXY4?=
 =?utf-8?B?MkxCTE9OV2VRZU05WVZtT0VJNnNKbnEyY1FWOEJTaEM1cWZvQndKQkduWmN0?=
 =?utf-8?B?dC8weGRBMHNLbVJCQUVaMGVlZGdsRzVWU0gxZHhPUUVtTDBPdlhSdWtoUWlK?=
 =?utf-8?B?eTFDQ2J5djRvaGVXVWhyUnJCWVE4ckJIRXF6dHpSd1RRaUlpd2wybWVqdkV5?=
 =?utf-8?B?eEk2dWRqd1lRZlRqQllYNU56NGdkMjBhMUMvT0pidUFFdkQ1US9Ndkl4QkFq?=
 =?utf-8?B?ZE81WmlFRjQ4SVNhV2E4VGZpNXo4UzRMNjFFRGsrNXhsbEJWUzNSQVYvWXF4?=
 =?utf-8?B?UFMrUTBCczV4OUVtSnpLQ0pQQVFoSVA3MWg3SWcyUkRYL3dxUDhQOE5NR2lm?=
 =?utf-8?B?VHZJUEFkeWpzZzZ1T1RDc3p4ODRQeUs5SDRxNHorS1NjcldzTXFnMXNpbkhN?=
 =?utf-8?B?OHZ0UFIyazRONDBKeDVjMmQ0eFAzRkFsZWJNc21OemplSElNNzdialkxc3M5?=
 =?utf-8?B?Z3YyRVZsUFE1WTh2Q3JCMU9FbUp3ZjU3S21iZk81RFlIS2d1S0VieGd2RXJO?=
 =?utf-8?B?QytySHRjU0hyczUrcW9YU3ZMSFpqMXdyZStqUEhzZ3FUUTRlNm1IQVNCRFQz?=
 =?utf-8?B?TXJzQWplOEVKVjNOK20xamQvb016MVhWR0dLTVp0TlZ5Q1laeWJGdmk5WWJM?=
 =?utf-8?B?WW51NTRjUC9ieGdnSURUMnpGQmhpSVRiYXNFZnFGMDh1ZDJjRjAwbEJObVNi?=
 =?utf-8?B?TlVqT0c3eCtUZFJCNjVJblVFOGtWaEdRTzc4R0pxbU1jcEk1OURlclF6SXF4?=
 =?utf-8?B?Ym9CZWloYUNRbnJHMUFQdm1BcUR6a01vMTlMUVF3djdmc3d5dFlQbUw3a1dZ?=
 =?utf-8?B?OTRJcnhLV2daT3VxcENGQ2VlZWxhaUhycXY5N0RQOGtLRFpWQ1dhajBGMFpL?=
 =?utf-8?B?MzBGekJTMHk4Q0xDZVlTeTNDcUFuUk93N3NYQk9YdVZLdkpxd2VoY2ZoSWZi?=
 =?utf-8?B?cmFnU1N3azhRN2F5K0c3YlFTVUV3NjZjd2Y0bFIvT0tuc3g2d3hCL2UwVGFv?=
 =?utf-8?B?Y08xU1Z2dFJHUW5SeHdCdzk0c00xQkRqWGpSazZLNkZHaStCSW91TXZTU24y?=
 =?utf-8?B?SWZoMVBnMVlhQ1VpNUFydnJtcDNtV3V1V0xPUTY5NGljblZGZ2VPY3VieWpv?=
 =?utf-8?B?MkxPUXRXc3RHT2tSSlZoaTgzeXNuZmJUOTBUM25rNVFuYkh5M1BnZmZqQzdm?=
 =?utf-8?B?QWhaYkFBVEdKRWN5dUEwaURqcTBXNm4zNVY0WHYrNFBNY29kdjRuNWR0dVBv?=
 =?utf-8?B?NldmL0VQeUxPN2R4bEM4MUhXeS9PMXJvRTFDVjJ2OXc4SCtPUnVTRU9NU1lZ?=
 =?utf-8?B?bERocjV6c2d5U3VRZG5DRm94dHVSd0NoVzRFYTZCL1NUNlR1Smpsb3Qyb1Ew?=
 =?utf-8?B?Uk1ya1dNT2pwanpRZmFETHpvSFkvVEJKbmdQRXZVeHVURWQ4RmVOQmtKSVZP?=
 =?utf-8?B?U29Yb0k3KzhITzFUNm96MGpKNnpjZHRYTXEzMGdCbHlYZklJS0JrUlZFVWp2?=
 =?utf-8?B?bVhZUmhrWk9HUGNES0xMSkMyRE04ajFyMU5zUUgydjJOUjFlZ0xiRHJnT0J0?=
 =?utf-8?B?bTFzbkdHWEliTDdqMUdRR2dnRElOQmpvVHRJVzY5R3hic3N1b3JpTHVOQXZT?=
 =?utf-8?B?clhoS1ZRaTVNZUFWLzJYN3UxZk1HOVBubVNDOWh0NW53M2pUM1RZaVdOVWZZ?=
 =?utf-8?B?U3Q3UmgzZGVXdHJYSHRQTEpNbmhFMGpJTlpRTktLK1UvWTFrMGFBNjE2Wk9z?=
 =?utf-8?B?T05ZWlhMelJnSzFGRjlLUVlZVnBwazM5TkRENU1NNk5HZjdUVnR2ai9Va09O?=
 =?utf-8?B?K3lsOGtTV3htcDBEZk9iV2d3dlFnUndvQk05Z3RqVUZ6YTRvbkpDSFB2QjBB?=
 =?utf-8?B?eHo3OU1XNEcrN0hSaVVxejN0M1FuWHlWcmdVSG5nWmxLL1pxV2NGOG9HNE1k?=
 =?utf-8?B?NHgvR1VLNGRXTlRwOW1FQUtHYjdma1RsSU90OGVuQmdUM3ZSWXRHWUVVbXNP?=
 =?utf-8?B?aHZiTWxxYnRNbG9GV0c4cEh0T0Vtd2lIWCtVRERPYmM3OFNpcWYyZ25wYU13?=
 =?utf-8?B?MmlKREZxZmxrOXNVR1Z4amZiTVVhbHNFQi8xOVNHbEp4WVpKNlUweXpzYytR?=
 =?utf-8?B?L2FVVjE4V0YzR1F1YTY1WU5wU081OGFQY2l4eXFhZXBUSXUrWTV6aU5NS0dC?=
 =?utf-8?B?eE1uTDUvbmYzVjV3Y0JJdEplUWdOdm9XcVFlYXJTMDFmYTNQVGdPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ee843b-3a9d-46a3-829c-08de68f78332
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 22:55:40.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8nT9yJSlaizj6LzWV+OeRcot+EUHejeGgH62nZAYdguL+clFX774rQ1zmi8kDp6TeELGDqkwV5yKYnHvhF5lE61IklmWIUuhg9xcaSUGxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258164-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,armlinux.org.uk,trager.us,linaro.org,kylinos.cn,fomichev.me,intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 983E511FDA2
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxMCwgMjAyNiA3OjA2
IEFNDQo+IFRvOiBtaWtlLm1hcmNpbmlzenluQGdtYWlsLmNvbTsgQWxleGFuZGVyIER1eWNrDQo+
IDxhbGV4YW5kZXJkdXlja0BmYi5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3Jn
Pjsga2VybmVsLQ0KPiB0ZWFtQG1ldGEuY29tOyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBs
dW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgU2ltb24NCj4gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPjsgUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+OyBLZWxsZXIsDQo+
IEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IE1vaHNpbiBCYXNoaXINCj4gPG1v
aHNpbi5iYXNockBnbWFpbC5jb20+OyBMZWUgVHJhZ2VyIDxsZWVAdHJhZ2VyLnVzPjsgRGFuIENh
cnBlbnRlcg0KPiA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPjsgUGVpIFhpYW8gPHhpYW9wZWkw
MUBreWxpbm9zLmNuPjsgU3RhbmlzbGF2DQo+IEZvbWljaGV2IDxzZGZAZm9taWNoZXYubWU+OyBL
dW5peXVraSBJd2FzaGltYSA8a3VuaXl1QGdvb2dsZS5jb20+Ow0KPiBTYW1pdWxsYWggS2hhd2Fq
YSA8c2toYXdhamFAZ29vZ2xlLmNvbT47IEFobWVkIFpha2kNCj4gPGFobWVkLnpha2lAaW50ZWwu
Y29tPjsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNv
bT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MTIgMy81XSBldGggZmJuaWM6
IEFkZCBtc2l4IHNlbGYgdGVzdA0KPiANCj4gT24gMi82LzI2IDQ6NDIgUE0sIG1pa2UubWFyY2lu
aXN6eW5AZ21haWwuY29tIHdyb3RlOg0KPiA+ICsvKioNCj4gPiArICogZmJuaWNfbXNpeF90ZXN0
IC0gVmVyaWZ5IGJlaGF2aW9yIG9mIE5JQyBpbnRlcnJ1cHRzDQo+ID4gKyAqIEBmYmQ6IGRldmlj
ZSB0byB0ZXN0DQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgbWVhbnQgdG8gdGVz
dCB0aGUgZ2xvYmFsIGludGVycnVwdCByZWdpc3RlcnMgYW5kIHRoZQ0KPiA+ICsgKiBQQ0llIElQ
IE1TSS1YIGZ1bmN0aW9uYWxpdHkuIEl0IGVzc2VudGlhbGx5IGdvZXMgdGhyb3VnaCBhbmQgdGVz
dHMNCj4gPiArICogdGVzdCB2YXJpb3VzIGNvbWJpbmF0aW9ucyBvZiB0aGUgc2V0LCBjbGVhciwg
YW5kIG1hc2sgYml0cyBpbiBvcmRlciB0bw0KPiA+ICsgKiB2ZXJpZnkgdGhlIGJlaGF2aW9yIGlz
IGFzIHdlIGV4cGVjdCBpdCB0byBiZSBmcm9tIHRoZSBkcml2ZXIuDQo+ID4gKyAqDQo+ID4gKyAq
IFJldHVybjogbm9uLXplcm8gb24gZmFpbHVyZS4NCj4gPiArICoqLw0KPiA+ICtpbnQgZmJuaWNf
bXNpeF90ZXN0KHN0cnVjdCBmYm5pY19kZXYgKmZiZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IHBj
aV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGZiZC0+ZGV2KTsNCj4gPiArCXN0cnVjdCBmYm5pY19t
c2l4X3Rlc3RfZGF0YSAqdGVzdF9kYXRhOw0KPiA+ICsJaW50IHJlc3VsdCA9IDA7DQo+ID4gKwl1
MzIgbWFzayA9IDA7DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwkvKiBBbGxvY2F0ZSBiaXRt
YXAgYW5kIElSUSB2ZWN0b3IgdGFibGUgKi8NCj4gPiArCXRlc3RfZGF0YSA9IGt6YWxsb2Moc2l6
ZW9mKCp0ZXN0X2RhdGEpLCBHRlBfS0VSTkVMKTsNCj4gPiArDQo+ID4gKwkvKiBSZXN1bHQgPSA1
IGZvciBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsdXJlICovDQo+ID4gKwlpZiAoIXRlc3RfZGF0YSkN
Cj4gPiArCQlyZXR1cm4gNTsNCj4gDQo+IEluc3RlYWQgb2YgbWFnaWMgbnVtYmVycyB5b3UgY291
bGQgZGVmaW5lIHNvbWUgbWFjcm9zLCBvciBzaW1wbHkgcmV0dXJuDQo+IGEgYm9vbGVhbiBzdWNj
ZXNzL2ZhaWx1cmVzIHZhbHVlIChhcyB0aGUgY2FsbGVyIGlnbm9yZXMgdGhlIGVycm9yIGNvZGUp
Lg0KPiANCj4gL1ANCg0KQXQgbGVhc3QgdXNlIC1FTk9NRU0gb3Igc29tZXRoaW5nLi4uLg0K

