Return-Path: <netdev+bounces-105671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5967912383
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554CF1F26F8C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA7176225;
	Fri, 21 Jun 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdbM/KHU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4C17557B;
	Fri, 21 Jun 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969103; cv=fail; b=eYeJhGy8aLt2qbIOlJf35LitxVG5iTeRgtrzIcM8VTVrUbkb5U8bH48J5x1l8ZnlOrYkOKlOIu/HGBP+vd7/NqgJWXzmZ796SwwHgvP4tkC3zmETQ5scGYBVou/OAUEodoqt20wHZeoh9YSe1kRwZoF8c2Ay4Y8Sz+Pgoed8ILk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969103; c=relaxed/simple;
	bh=/sVDMmxkKda9aGY2J5BRW9E+kux9H3hdmkNWsV7qLAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHlZqhN5ETI3ZkaoMI8vQqpIcMANFF3sGIRxKtzE6r+M23Va3oXLc97xPy1ebe/ZKlhwVUu+5tJKvMXvK46K9C3IzZGqy5h64+PBbDHzd00Q/Kn57HnGBKZyssTj8hYQpho2Ylpci5Z5wQaBJtlOrnYw5fQ30Ev/fBSBeUoWP3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdbM/KHU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718969100; x=1750505100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/sVDMmxkKda9aGY2J5BRW9E+kux9H3hdmkNWsV7qLAE=;
  b=CdbM/KHUqR1SXPZ18rXP11JW+SexCLXFGw5VwjHq5JlApIc5Fo3qKwnT
   cB+s6a77nljQcbnA+uw2i7nBetwJxW1+azHhZTT6Z95RaXfu7Qv/n8lWH
   RZMuCdp7/52aWx/Do5ahenYc5udumY+8XEt8qdAEtspFQcQ3tAe8gzBUU
   f2IQ4dw+5k9vNobe6OQpy0C52BL7+o0qRZhOqQAZuSnn6FSBIdWveRsSo
   nUi6eEYcDw6Wi9YljKjF+B1s4oNhxj32xW884YL06o16i3h/5DU3utzlR
   gNk8KX3B53TXfS/M2bvOv14xY7LUrnPA3f5vkksWvEaJpM0i4h8QQbcyv
   g==;
X-CSE-ConnectionGUID: 3AjwJjDHQJuJeGVX+Y2WIg==
X-CSE-MsgGUID: iHoW2dB1RBmN1lM47h2pDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19772204"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="19772204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 04:24:59 -0700
X-CSE-ConnectionGUID: WOeleK1tRZSkWyUr3f6cgQ==
X-CSE-MsgGUID: PPoW4SZ6SRaSmMmsqedF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42639070"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 04:24:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 04:24:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 04:24:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 04:24:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 04:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSQXfB+pP5l/RwEfCM7XWR4jn7Z6OxkbXxue4BC2XDcWAU4nItmp63aW3NwcLokCp8t6WgOrJ53qWN4HMQ3HsWCYy9POqlFCdISXkw6Q5950KAiOBQM0Vb1VSZUooq13Qgg5cJdd40c5TzVAGlu9SkTlNmN4MTLUlWtdIcgfqqgoKO5op91U1cWaTJXpxKlCCDncMuvdQVS3iaIUyT9rskr4XQQWU5lHhbS/KTfky0ulFEgHEl8wFeXXIxkB5JyTQFiNhKeU2aDgE8dS2xKY4DLE02RgDnUrgIuB9+b0kQ6Sa3Qq1eOkmFfDSdzKmayMK+HeuH42BTkhjFJbbStJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sVDMmxkKda9aGY2J5BRW9E+kux9H3hdmkNWsV7qLAE=;
 b=Pcow3w6DCK8DPwCXttJAn01xQ65mUYGoHWmhG4/JEozLH67b0TLQrizcn+UjzxL4oxiZv9o3jQnd32NtVHJKirqDqHNCnBZgvYQaiCqDtpKRhSgPSGueOR/hjrOYcXPW4Mme4OZe3kJwJDK0PYmYXLBF2L3YZaZ8LzOEdfbuACs2OXma5b4lpuoeVxij3GuKTD2Oea5mQhqMMXxa3YOGTGTXAVHgRk2zSJBlkSo1UBEUz+3W1W3AhMx1TcHBtx4GYOuzZbrH9SC07ezaMSInA4M58D6HpuaW6we8GVptXZWnuZdlDIaKDneGkaUP7Gpv7hdplzXMSOTjuN2CKyKBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 11:24:55 +0000
Received: from CH3PR11MB8751.namprd11.prod.outlook.com
 ([fe80::8777:a5ef:b50e:26]) by CH3PR11MB8751.namprd11.prod.outlook.com
 ([fe80::8777:a5ef:b50e:26%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 11:24:55 +0000
From: "Ballman, Aaron" <aaron.ballman@intel.com>
To: Nick Desaulniers <ndesaulniers@google.com>, Yabin Cui <yabinc@google.com>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] Fix initializing a static union variable
Thread-Topic: [PATCH] Fix initializing a static union variable
Thread-Index: AQHaw0rLxZ0v2j87Z0OiKHfzdzeVBLHREKYAgAEBLjA=
Date: Fri, 21 Jun 2024 11:24:55 +0000
Message-ID: <CH3PR11MB8751EEEAD1E6C970F68FF2CBF3C92@CH3PR11MB8751.namprd11.prod.outlook.com>
References: <20240620181736.1270455-1-yabinc@google.com>
 <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <CAKwvOd=DkqejWW=CTmaSi8gqopvCsVtj+63ppuR0nw==M26imA@mail.gmail.com>
 <CAKwvOdm+uudyu_JrHUBBJnU_R4GYprym6HWmcYYyHoCspbcL3Q@mail.gmail.com>
In-Reply-To: <CAKwvOdm+uudyu_JrHUBBJnU_R4GYprym6HWmcYYyHoCspbcL3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8751:EE_|PH7PR11MB8455:EE_
x-ms-office365-filtering-correlation-id: 9dce47e5-cf5d-42a6-d2d3-08dc91e4c6df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|7416011|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?R0dHQTFFT2NvWnNISDFYbGJhVFpFa05CSEJMOTE3cUdxc3paYlAwN2xiSEdq?=
 =?utf-8?B?ZEErdTcvYlcxY1pENllTVTI5VHIvM0NxNXV2cEpWS05DNWdkNFRQUmJUdU9N?=
 =?utf-8?B?RENod3ArTmtWNGh6R0lUQWFGZ2dTK3lBajJkVDhxcTVjNUQ5U1MxRDMvYzBI?=
 =?utf-8?B?ZmZWRTgveks4L0xnN2xJb3BQaWdJWmM5T0xpMVZSbG1FS2RMOW1CKzd3UzV6?=
 =?utf-8?B?Yk1uYXZaUzlIVmxmRGNkc3cvMTdKTzNFOG0xRWFGNWNtTXRyRWFtb1NTazBB?=
 =?utf-8?B?OWZJTSt6eXBXaW9Ib0pkbWlFQWpKU1dyOGwvQWhiK2RlZVNxTG5EQ09jSUE0?=
 =?utf-8?B?TkV5OWdRWThoZHh4dmRBSEtrbUxrZW5tVitDeCtsMFB6cXErY1NTNDNDak1z?=
 =?utf-8?B?UFZKYVdGN0swUjgwUTAvVnFzM3lyTi9DeURmY1Q5V055NWJxaHBBVGRlM0R3?=
 =?utf-8?B?U0NUNzZ4Y003cDBqcXQzaU1IcWVXNU14TmpoRDZhcUF3NkgvWkgwcHZmVmNJ?=
 =?utf-8?B?SVR4Yktia1g1cUdSOUtscWJkTmxXSVVZNWlNdnkwVDNpbXZjdElvTVU0clky?=
 =?utf-8?B?Yi9DK1RhUU5xa2FxcEtGQitoblVNSitTaHpMWWJoQzROa0JnZUlPekQ1ODZB?=
 =?utf-8?B?YkNSUDVqTk1HZFdtVFYyWStWRXJvekFqMklXNTRBUVZ6b1FYMGdLUU5wRlk5?=
 =?utf-8?B?M2pOZFhMU2c4ZlpvcDNYVzUycGZkS1BPakhqdU5sd2FYT09mOHFyc2p1MU1W?=
 =?utf-8?B?RVJwaktVWGI5bVdudTVWaER4Ri93MjhGSWZuNTFYU0hsVU9XMXlRMnlQWWwz?=
 =?utf-8?B?allNbzUwQjdRSVVCL0VYcWpzNVJ1SUN0S1I4ak1BYWlCWnBGV01DOFlLR1kw?=
 =?utf-8?B?M2lweW44dENvZmFmRWlLUzJ1aUd5QXNBRGRON3N6UlFvNk9uK2t5WXAwLyt5?=
 =?utf-8?B?Uko5RmZjZ01pU2pwaXdaNnV2TEtFcVpuTS96Y0ZuRm1EYmhwN2xVNEJuTDRS?=
 =?utf-8?B?Vmh6NHUvMkV4Mk9qc20waEZXNExCRU0rYkxsYjVqZllZd0pWczZibDczR3BT?=
 =?utf-8?B?WWZvRENQd3hwNFUvRlBSQkhSd1JrWTJLYk52M3BsR1paRG9WcTlLYkhyZkor?=
 =?utf-8?B?emNYUW54T3o5aHkyaThXL0hFb3FoRDRCLzhZSWFvbkh6ZG1aSGJPOTZkMWMz?=
 =?utf-8?B?TG56L0U0Y0ZpNXNQcnZKWDNQdGRIeGFkdWd6TDBpbTFpWVZ4TEJQY1pYSjkx?=
 =?utf-8?B?UjVmQmRtSDBsekVBaDRJQnJzRVZ6S21HRVdPci9nNHRiZENoVlpnRlZoeVVn?=
 =?utf-8?B?dmJSdnRjTElzTkJmemwxSEhjTmdvd2lkblRmQU4wUmhaaDQ5RDUrSmIyYlZZ?=
 =?utf-8?B?bkIzMGVibk1kUWpYZm9vQUhoamlvaC94R3crZzAxcTRDM3RjQ0xYS2RxcjJZ?=
 =?utf-8?B?REU4aGRHRzBYeTdUZ2NRODBBSmo0NjJ2NEp5V1pKVFpQRnhEdC9iOHIxVGNK?=
 =?utf-8?B?b1JscnFzaEF5Q1hLdFFuRS9xOTFVN1VQeXNBdWovMG1uSEU2b2hTZGROT3lO?=
 =?utf-8?B?bnY3cEtuNHhpRWVkMVBmcnpJbnVhTXBQd3ltUDgxcyt3Nko3cWg3WHl3SXgv?=
 =?utf-8?B?cWFqS1Z2RWlTWDJ3RVpMa3pzbzU3NTN0clltVk13REVZT0swclg5YnA0VnlE?=
 =?utf-8?B?UWE5NWR2VHljNjc0SGFPbGhOWFVVcVBwUGZ5c3Y0M2RiMzVBYjY0SEM4M25H?=
 =?utf-8?Q?GZ0BSEWRNz9VKtwPYmTJkMYAPDvw4S4agbVl7rA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0tlRkRsR3lNdGlxWkJlM3JBbjhyRVRmUWlRRkQwRHRITU9venE2S2sxTHVV?=
 =?utf-8?B?WUtoNlFJKy8yell0eGtXdHBFQldZVU8xUHBtMWliNXYvdFRmREFBYm5rN0NE?=
 =?utf-8?B?WjFYZGNUUTlrQTErMEVFRmMzUURMZ3NiWVA4ZVBwcUVyTlJIdENmK3E4VjZy?=
 =?utf-8?B?S0R3cGE1R1E0emw2SHFEcnoyaGN5Z3FZTTdISEdwZEpPMysyQmNXTjUxb2ha?=
 =?utf-8?B?UE1FUW9haWp3TkVneUdQTUZqbExFSTVlOGpERFJOaGR6ZExwblF6b2ZKQ1Rk?=
 =?utf-8?B?Tjd0L0lJMm56cExPVUM3RnNpK2JqU2liTVgxbzVVMmRxdTZHV0FBWTNFSWcx?=
 =?utf-8?B?bGRadlVXS3BDQ0gxOFVYeXZTZ2dzbmJ2WjJZcld4a3FnYzFWbm1veGhMT0kz?=
 =?utf-8?B?eGZmczI1NjJiRW53bnFHRTlOdVFsclVCaU9wU1ZqUnoycHExQjRaQTF1eDhk?=
 =?utf-8?B?MDh0U0lnUGxyT2xtRk12MlVWb2pSa3pGOTFZekh3dENTZ2dsdjZhVGVxaGZL?=
 =?utf-8?B?SHp6MXgwam1YdGpIQXhJOWRXSThiRXBjdGkrN280VW5XNlE2VXo4NlMwODJo?=
 =?utf-8?B?V2xoU0FTUDJqUGVLRDdkK2VYTEs1SWpSQ0V0V1ZhTGttK0NhTnVCb3AzaS9P?=
 =?utf-8?B?VDk5b0dRZkNtS1hEOEQ0U0VDekVqV2RqcVpBQitrS0JrRkc2bnJBMWdPcVVm?=
 =?utf-8?B?RTlqRHg0NTF4YlF2TFFqUzdxZzJYVlFBOE5RWndoMEIrdy9DTW5mZXF3d2J1?=
 =?utf-8?B?aTVONDRaWExLWVBCb1pkTGRaNTJsbUZQRmtSU3cyYmxiZ0VTbHhnVGw2aFA1?=
 =?utf-8?B?QmNjUXJsbDlnbEZaK2J5aVY2bHgzdTFYcTJ2NWlXNlgrZXNmNFpSU21XTWJr?=
 =?utf-8?B?RnZIOHNDaE50WEZGaTJ5Vm16VTVHSjFrekxmaU00ZEpQMDIxckYzZGNiQlJp?=
 =?utf-8?B?dDBuNkcrWkRXYmlxdk1yVllKS1kyRWZsZGhXTk4wOTdmU2FMTjFUMGJoWGZi?=
 =?utf-8?B?WnFhbnlOaDlhengxSGxNRHYzYjVGaVVlZHk5Z3ZaSmVraFZ0bDVGRDJmUFk5?=
 =?utf-8?B?blBGdWNTVUNjRi9WNUZSTjk2RURQR2x3b0xqODhYdFJyNE5wTFg1TUcrajZn?=
 =?utf-8?B?K2hqcFROeDZadjd0SjExR1RIRXRYeVhrbU83dy9yUVhZL3JJRFlrVW5ZR21B?=
 =?utf-8?B?Sm00akJOakFHSm8vL1FQTXVIK28yNWNuYUdpSVZkRk5KVUFpSVJ6Q1NRbjVi?=
 =?utf-8?B?SGNuT1Y4YWlEOFJlQ3c0RnFwN21qZUhaQ2RlOHV2c0VGbUFBNytpdEhvM3I1?=
 =?utf-8?B?NmVmZ0pzWTVNWUFNUTgyblIwbFZHYWsvYmVlOXJCMEZITVk0K2RCamxJOE5t?=
 =?utf-8?B?ajdhVzFuaEJMbmhrMHJUOFZ3MmFnNHJaS05HMTR3RjRJcEdEYTJWVGoxTm9O?=
 =?utf-8?B?djQ3KytEU1l3TlQxWUx1VHdOSmlONmRFbkc0VVRlKzJIZm41NFo1bmVJZ1c3?=
 =?utf-8?B?RWJHVGIveWpjUi9PbSs1TWtObFhOSU1peXFFY1p4NmcxaVEvMkwxYnY1VnRm?=
 =?utf-8?B?aS9rM3Y1U3ZnOERsS0NDanZNWmgxellkVW1sc2gweGFhOExnNGJnMkZBOUNn?=
 =?utf-8?B?ZFZ6RXFkUzVkdzRYVUVjVHdnR0t1VUdPRzQ1aG0zeVFGUVFvN2VqbTlDR1Jl?=
 =?utf-8?B?N2tMendOV2ZyZjU3Mm1oWko2K3libmtKZGRtUjgwOVhBSnJqWnpiVjFWamxT?=
 =?utf-8?B?dFBPcUp2dnd4SnRueENsdDB0dFcxcWp2YVhyYkRYNnAzVG1iVkU5M3dZWk1h?=
 =?utf-8?B?T1NYTVZrL2pSYW94NEhXeUVoMzBXdGdoc1lPRlpVNEFTY2JOV1Ezd0dFVFhP?=
 =?utf-8?B?YlFMa1AvWjE2RTNOcGFNenNTd05iTkpVOERMZENQOU44Qm5wRnUyVGZ1VnRw?=
 =?utf-8?B?NVArV0dwUU16S1cxVitSeVBtTU00a3djNDFkV2M3MWlaWVBVZDNTVlc3Qitt?=
 =?utf-8?B?MjZ3Q0NyNmE1N1E5WTVlaGk3amlTZzhCMzdnWHF0ZTFZMjF1WXRUa3lMaXhw?=
 =?utf-8?B?QUVLSWU0dnNRUTF6blpucWdqY1ZZYSt4Ui9xTXNtOEh6Rmx5NU4vOEc1K1R1?=
 =?utf-8?Q?nYeFlLkhVbdb9NpAm04pm6XGQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dce47e5-cf5d-42a6-d2d3-08dc91e4c6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 11:24:55.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtY1sb+DSv5+Y6jATWn937MRc0quDD5+PqHqoh5gCc824YUQD1gqBVYA4DAYQiLeWHZqj1fc3S49Ze2SoapwjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com

U2FkbHksIHRoaXMgaXMgbm90IGEgYnVnIGluIENsYW5nIGJ1dCBpcyB0aGUgdGVycmlibGUgd2F5
IEMgc3RpbGwgd29ya3MgaW4gQzIzLiDimLkgU2VlIEMyMyA2LjcuMTFwMTEsIHRoZSBsYXN0IGJ1
bGxldDoNCg0KaWYgaXQgaXMgYSB1bmlvbiwgdGhlIGZpcnN0IG5hbWVkIG1lbWJlciBpcyBpbml0
aWFsaXplZCAocmVjdXJzaXZlbHkpIGFjY29yZGluZyB0byB0aGVzZSBydWxlcywgYW5kIGFueSBw
YWRkaW5nIGlzIGluaXRpYWxpemVkIHRvIHplcm8gYml0cy4NCg0KU28gdGhlIHBhZGRpbmcgZ2V0
cyBpbml0aWFsaXplZCBhcyBkb2VzIHRoZSBmaXJzdCBtZW1iZXIsIGJ1dCBpZiB0aGUgZmlyc3Qg
bWVtYmVyIGlzIG5vdCB0aGUgbGFyZ2VzdCBtZW1iZXIgaW4gdGhlIHVuaW9uLCB0aGF0IGxlYXZl
cyBvdGhlciBiaXRzIHVuaW5pdGlhbGl6ZWQuIFRoaXMgaGFwcGVuZWQgbGF0ZSBkdXJpbmcgTkIg
Y29tbWVudCBzdGFnZXMsIHdoaWNoIGlzIHdoeSBOMjkwMCBhbmQgTjMwMTEgZ2l2ZSB0aGUgaW1w
cmVzc2lvbiB0aGF0IHRoZSBsYXJnZXN0IHVuaW9uIG1lbWJlciBzaG91bGQgYmUgaW5pdGlhbGl6
ZWQuDQoNClRoYXQgc2FpZCwgbWF5YmUgdGhlcmUncyBhcHBldGl0ZSB3aXRoaW4gdGhlIGNvbW11
bml0eSB0byBpbml0aWFsaXplIHRoZSBsYXJnZXN0IG1lbWJlciBhcyBhIGNvbmZvcm1pbmcgZXh0
ZW5zaW9uLiBUaGUgZG93bnNpZGUgaXMgdGhhdCBwZW9wbGUgbm90IHBsYXlpbmcgdHJpY2tzIHdp
dGggdGhlaXIgdW5pb25zIG1heSBlbmQgdXAgcGF5aW5nIGFkZGl0aW9uYWwgaW5pdGlhbGl6YXRp
b24gY29zdCB0aGF0J3MgdXNlbGVzcywgaW4gcGF0aG9sb2dpY2FsIGNhc2VzLiBlLmcuLA0KDQpp
bnQgbWFpbigpIHsNCiAgdW5pb24gVSB7DQogICAgaW50IGk7DQogICAgc3RydWN0IHsNCiAgICAg
IGxvbmcgZG91YmxlIGh1Z2VbMTAwMF07DQogICAgfSBzOw0KICB9IHUgPSB7fTsgLy8gVGhpcyBp
cyBub3QgYSBicmlsbGlhbnQgdXNlIG9mIHVuaW9ucw0KICByZXR1cm4gdS5pOw0KfQ0KDQpCdXQg
aG93IG9mdGVuIGRvZXMgdGhpcyBtYXR0ZXIgZm9yIHBlcmZvcm1hbmNlIC0tIEkgaGF2ZSB0byBp
bWFnaW5lIHRoYXQgbW9zdCB1bmlvbnMgbWFrZSB1c2Ugb2YgbW9zdCBvZiB0aGUgbWVtb3J5IG5l
ZWRlZCBmb3IgdGhlaXIgbWVtYmVycyBpbnN0ZWFkIG9mIGJlaW5nIGxvcHNpZGVkIGxpa2UgdGhh
dC4gSWYgd2UgZmluZCBzb21lIGltcG9ydGFudCB1c2UgY2FzZSB0aGF0IGhhcyBzaWduaWZpY2Fu
dGx5IHdvcnNlIHBlcmZvcm1hbmNlLCB3ZSBjb3VsZCBhbHdheXMgYWRkIGEgZHJpdmVyIGZsYWcg
dG8gY29udHJvbCB0aGUgYmVoYXZpb3IgdG8gbGV0IHBlb3BsZSBvcHQgaW50by9vdXQgb2YgdGhl
IGV4dGVuc2lvbi4NCg0KfkFhcm9uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4gDQpTZW50OiBUaHVy
c2RheSwgSnVuZSAyMCwgMjAyNCAzOjU0IFBNDQpUbzogWWFiaW4gQ3VpIDx5YWJpbmNAZ29vZ2xl
LmNvbT4NCkNjOiBTdGVmZmVuIEtsYXNzZXJ0IDxzdGVmZmVuLmtsYXNzZXJ0QHNlY3VuZXQuY29t
PjsgSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgRGF2aWQgUy4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUu
Y29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz47IEJp
bGwgV2VuZGxpbmcgPG1vcmJvQGdvb2dsZS5jb20+OyBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0
QGdvb2dsZS5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsbHZtQGxpc3RzLmxpbnV4LmRldjsgQmFsbG1hbiwgQWFyb24gPGFhcm9uLmJh
bGxtYW5AaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gRml4IGluaXRpYWxpemluZyBh
IHN0YXRpYyB1bmlvbiB2YXJpYWJsZQ0KDQpPbiBUaHUsIEp1biAyMCwgMjAyNCBhdCAxMjo0N+KA
r1BNIE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToNCj4N
Cj4gT24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMTI6MzHigK9QTSBOaWNrIERlc2F1bG5pZXJzIA0K
PiA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBKdW4g
MjAsIDIwMjQgYXQgMTE6MTfigK9BTSBZYWJpbiBDdWkgPHlhYmluY0Bnb29nbGUuY29tPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiBzYWRkcl93aWxkY2FyZCBpcyBhIHN0YXRpYyB1bmlvbiB2YXJpYWJs
ZSBpbml0aWFsaXplZCB3aXRoIHt9Lg0KPiA+ID4gQnV0IGMxMSBzdGFuZGFyZCBkb2Vzbid0IGd1
YXJhbnRlZSBpbml0aWFsaXppbmcgYWxsIGZpZWxkcyBhcyB6ZXJvIA0KPiA+ID4gZm9yIHRoaXMg
Y2FzZS4gQXMgaW4gaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L3JXdmR2NmFFeCwNCj4gPg0KPiA+IFNw
ZWNpZmljYWxseSwgaXQgc291bmRzIGxpa2UgQzk5KyBpcyBqdXN0IHRoZSBmaXJzdCBtZW1iZXIg
b2YgdGhlIA0KPiA+IHVuaW9uLCB3aGljaCBpcyBkdW1iIHNpbmNlIHRoYXQgbWF5IG5vdCBuZWNl
c3NhcmlseSBiZSB0aGUgbGFyZ2VzdCANCj4gPiB2YXJpYW50LiAgQ2FuIHlvdSBmaW5kIHRoZSBz
cGVjaWZpYyByZWxldmFudCB3b3JkaW5nIGZyb20gYSBwcmUtYzIzIA0KPiA+IHNwZWM/DQo+ID4N
Cj4gPiA+IGNsYW5nIG9ubHkgaW5pdGlhbGl6ZXMgdGhlIGZpcnN0IGZpZWxkIGFzIHplcm8sIGJ1
dCB0aGUgYml0cyANCj4gPiA+IGNvcnJlc3BvbmRpbmcgdG8gb3RoZXIgKGxhcmdlcikgbWVtYmVy
cyBhcmUgdW5kZWZpbmVkLg0KPiA+DQo+ID4gT2gsIHRoYXQgc3Vja3MhDQo+ID4NCj4gPiBSZWFk
aW5nIHRocm91Z2ggdGhlIGludGVybmFsIHJlcG9ydCBvbiB0aGlzIGlzIGZhc2NpbmF0aW5nISAg
TmljZSANCj4gPiBqb2IgdHJhY2tpbmcgZG93biB0aGUgaXNzdWUhICBJdCBzb3VuZHMgbGlrZSBp
ZiB3ZSBjYW4gYWdncmVzc2l2ZWx5IA0KPiA+IGlubGluZSB0aGUgdXNlcnMgb2YgdGhpcyBwYXJ0
aWFsbHkgaW5pdGlhbGl6ZWQgdmFsdWUsIHRoZW4gdGhlIFVCIA0KPiA+IGZyb20gY29udHJvbCBm
bG93IG9uIHRoZSBwYXJ0aWFsbHkgaW5pdGlhbGl6ZWQgdmFsdWUgY2FuIHJlc3VsdCBpbiANCj4g
PiBBbmRyb2lkJ3Mga2VybmVsIG5ldHdvcmsgdGVzdHMgZmFpbGluZy4gIEl0IG1pZ2h0IGJlIGdv
b2QgdG8gaW5jbHVkZSANCj4gPiBtb3JlIGluZm8gb24gIndoeSB0aGlzIGlzIGEgcHJvYmxlbSIg
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiA+DQo+ID4gaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L2h4
blQxUFRXbyBtb3JlIGNsZWFybHkgZGVtb25zdHJhdGVzIHRoZSBpc3N1ZSwgSU1PLg0KPiA+DQo+
ID4gVElMIHRoYXQgQzIzIGNsYXJpZmllcyB0aGlzLCBidXQgY2xhbmcgc3RpbGwgZG9lc24ndCBo
YXZlIHRoZSANCj4gPiBjb3JyZWN0IGNvZGVnZW4gdGhlbiBmb3IgLXN0ZD1jMjMuICBDYW4geW91
IHBsZWFzZSBmaW5kIG9yIGZpbGUgYSANCj4gPiBidWcgYWJvdXQgdGhpcywgdGhlbiBhZGQgYSBs
aW5rIHRvIGl0IGluIHRoZSBjb21taXQgbWVzc2FnZT8NCj4gPg0KPiA+IEl0IG1pZ2h0IGJlIGlu
dGVyZXN0aW5nIHRvIGxpbmsgdG8gdGhlIHNwZWNpZmljIHNlY3Rpb24gb2YgbjMwOTYgDQo+ID4g
dGhhdCBjbGFyaWZpZXMgdGhpcywgb3IgaWYgdGhlcmUgd2FzIGEgY29ycmVzcG9uZGluZyBkZWZl
Y3QgcmVwb3J0IA0KPiA+IHNlbnQgdG8gSVNPIGFib3V0IHRoaXMuICBNYXliZSBzb21ldGhpbmcg
ZnJvbSANCj4gPiBodHRwczovL3d3dy5vcGVuLXN0ZC5vcmcvanRjMS9zYzIyL3dnMTQvd3d3L3dn
MTRfZG9jdW1lbnRfbG9nLmh0bQ0KPiA+IGRpc2N1c3NlcyB0aGlzPw0KPg0KPiBodHRwczovL3d3
dy5vcGVuLXN0ZC5vcmcvanRjMS9zYzIyL3dnMTQvd3d3L2RvY3MvbjMwMTEuaHRtDQo+DQo+IGh0
dHBzOi8vY2xhbmcubGx2bS5vcmcvY19zdGF0dXMuaHRtbCBtZW50aW9ucyB0aGF0IG4zMDExIHdh
cyBhZGRyZXNzZWQgDQo+IGJ5IGNsYW5nLTE3LCBidXQgYmFzZWQgb24gbXkgZ29kYm9sdCBsaW5r
IGFib3ZlLCBpdCBzZWVtcyBwZXJoYXBzIG5vdD8NCg0KU29ycnksIG4zMDExIHdhcyBhIG1pbm9y
IHJldmlzaW9uIHRvDQpodHRwczovL3d3dy5vcGVuLXN0ZC5vcmcvanRjMS9zYzIyL3dnMTQvd3d3
L2RvY3MvbjI5MDAuaHRtDQp3aGljaCBpcyBhIGJldHRlciBjaXRhdGlvbiBmb3IgdGhpcyBidWcs
IElNTy4gIEkgc3RpbGwgdGhpbmsgdGhlIGNsYW5nIHN0YXR1cyBwYWdlIGlzIHdyb25nIChmb3Ig
bjI5MDApIGFuZCB0aGF0IGlzIGEgYnVnIGFnYWluc3QgY2xhbmcgdGhhdCBzaG91bGQgYmUgZml4
ZWQgKGZvciBjMjMpLCBidXQgdGhpcyBrZXJuZWwgcGF0Y2ggc3RpbGwgaGFzIG1lcml0IChzaW5j
ZSB0aGUgaXNzdWUgSSdtIHJlZmVycmluZyB0byBpbiBjbGFuZyBpcyBub3Qgd2hhdCdzIGxlYWRp
bmcgdG8gdGhlIHRlc3QgY2FzZSBmYWlsdXJlcykuDQoNCj4NCj4gNi43LjEwLjIgb2YgbjMwOTYg
KGMyMykgZGVmaW5lcyAiZW1wdHkgaW5pdGlhbGl6YXRpb24iICh3aGljaCB3YXNuJ3QgDQo+IGRl
ZmluZWQgaW4gb2xkZXIgc3RhbmRhcmRzKS4NCj4NCj4gQWgsIHJlYWRpbmcNCj4NCj4gbjIzMTAg
KGMxNykgNi43LjkuMTA6DQo+DQo+IGBgYA0KPiBJZiBhbiBvYmplY3QgdGhhdCBoYXMgc3RhdGlj
IG9yIHRocmVhZCBzdG9yYWdlIGR1cmF0aW9uIGlzIG5vdCANCj4gaW5pdGlhbGl6ZWQgZXhwbGlj
aXRseSwgdGhlbjoNCj4gLi4uDQo+IOKAlCBpZiBpdCBpcyBhIHVuaW9uLCB0aGUgZmlyc3QgbmFt
ZWQgbWVtYmVyIGlzIGluaXRpYWxpemVkDQo+IChyZWN1cnNpdmVseSkgYWNjb3JkaW5nIHRvIHRo
ZXNlIHJ1bGVzLCBhbmQgYW55IHBhZGRpbmcgaXMgaW5pdGlhbGl6ZWQgDQo+IHRvIHplcm8gYml0
czsgYGBgDQo+DQo+IFNwZWNpZmljYWxseSwgInRoZSBmaXJzdCBuYW1lZCBtZW1iZXIiIHdhcyBh
IHRlcnJpYmxlIG1pc3Rha2UgaW4gdGhlIGxhbmd1YWdlLg0KPg0KPiBZaWtlcyEgTWlnaHQgd2Fu
dCB0byBxdW90ZSB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4NCj4gPg0KPiA+IENhbiB5
b3UgYWxzbyBwbGVhc2UgKGZpbmQgb3IpIGZpbGUgYSBidWcgYWdhaW5zdCBjbGFuZyBhYm91dCB0
aGlzPyBBIA0KPiA+IGNvbXBpbGVyIGRpYWdub3N0aWMgd291bGQgYmUgdmVyeSB2ZXJ5IGhlbHBm
dWwgaGVyZSwgc2luY2UgYD0ge307YCANCj4gPiBpcyBzdWNoIGEgY29tbW9uIGlkaW9tLg0KPiA+
DQo+ID4gUGF0Y2ggTEdUTSwgYnV0IEkgdGhpbmsgbW9yZSBjb250ZXh0IGNhbiBiZSBwcm92aWRl
ZCBpbiB0aGUgY29tbWl0IA0KPiA+IG1lc3NhZ2UgaW4gYSB2MiB0aGF0IGhlbHBzIHJldmlld2Vy
cyBmb2xsb3cgYWxvbmcgd2l0aCB3aGF0J3MgZ29pbmcgDQo+ID4gb24gaGVyZS4NCj4gPg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhYmluIEN1aSA8eWFiaW5jQGdvb2dsZS5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBuZXQveGZybS94ZnJtX3N0YXRlLmMgfCAyICstDQo+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL25ldC94ZnJtL3hmcm1fc3RhdGUuYyBiL25ldC94ZnJtL3hmcm1fc3RhdGUu
YyBpbmRleCANCj4gPiA+IDY0OWJiNzM5ZGYwZC4uOWJjNjlkNzAzZTVjIDEwMDY0NA0KPiA+ID4g
LS0tIGEvbmV0L3hmcm0veGZybV9zdGF0ZS5jDQo+ID4gPiArKysgYi9uZXQveGZybS94ZnJtX3N0
YXRlLmMNCj4gPiA+IEBAIC0xMTM5LDcgKzExMzksNyBAQCB4ZnJtX3N0YXRlX2ZpbmQoY29uc3Qg
eGZybV9hZGRyZXNzX3QgKmRhZGRyLCBjb25zdCB4ZnJtX2FkZHJlc3NfdCAqc2FkZHIsDQo+ID4g
PiAgICAgICAgICAgICAgICAgc3RydWN0IHhmcm1fcG9saWN5ICpwb2wsIGludCAqZXJyLA0KPiA+
ID4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIHNob3J0IGZhbWlseSwgdTMyIGlmX2lkKSAgew0K
PiA+ID4gLSAgICAgICBzdGF0aWMgeGZybV9hZGRyZXNzX3Qgc2FkZHJfd2lsZGNhcmQgPSB7IH07
DQo+ID4gPiArICAgICAgIHN0YXRpYyBjb25zdCB4ZnJtX2FkZHJlc3NfdCBzYWRkcl93aWxkY2Fy
ZDsNCj4gPiA+ICAgICAgICAgc3RydWN0IG5ldCAqbmV0ID0geHBfbmV0KHBvbCk7DQo+ID4gPiAg
ICAgICAgIHVuc2lnbmVkIGludCBoLCBoX3dpbGRjYXJkOw0KPiA+ID4gICAgICAgICBzdHJ1Y3Qg
eGZybV9zdGF0ZSAqeCwgKngwLCAqdG9fcHV0Ow0KPiA+ID4gLS0NCj4gPiA+IDIuNDUuMi43NDEu
Z2RiZWMxMmNmZGEtZ29vZw0KPiA+ID4NCj4gPg0KPiA+DQo+ID4gLS0NCj4gPiBUaGFua3MsDQo+
ID4gfk5pY2sgRGVzYXVsbmllcnMNCj4NCj4NCj4NCj4gLS0NCj4gVGhhbmtzLA0KPiB+TmljayBE
ZXNhdWxuaWVycw0KDQoNCg0KLS0NClRoYW5rcywNCn5OaWNrIERlc2F1bG5pZXJzDQo=

