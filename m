Return-Path: <netdev+bounces-166055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2CA34213
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256051885930
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563802222B6;
	Thu, 13 Feb 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8vTyoU4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BF28137B;
	Thu, 13 Feb 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456917; cv=fail; b=HdD8iffNOaaE0Lq3TAeq5T2UW+rhgjcJnjkkoGjhFN9huVxVtjUXvGH1IABAgLeNfqvz/ohMVQMrg7kH0TJVCG5Kq9f7uI5viR1i6M96KD3gJqRhX1Jmga3lW5AEQJVKT9hpCsnm2yUWPoiSOpvO8JLZZiUfLaq7xal9SoYhXGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456917; c=relaxed/simple;
	bh=fKu3vP5t2iTgcrxTEGFdLrrveNR+K4k/kisrKkdt4Yo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B56rGYy/4jxOssDHsDC2HJmhfO+SK4pnXd6Xym9GRRc3udYYSm53i4HbDqCxH8pMihK2IQLoQQoQjoTPoKcLxbTCRRRhs4l4z1j0qsp5y8c0F5Xzb7fj4U2IN/T1HDUXZKkIvtaf6A2AT4OVx72ALje81v3schP7uqOjvv07NkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8vTyoU4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739456915; x=1770992915;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fKu3vP5t2iTgcrxTEGFdLrrveNR+K4k/kisrKkdt4Yo=;
  b=F8vTyoU4pPQz60FtK75HeSdukntsqMBMoXK7ck4PIHLHhJF6yH9SW3Vw
   AKJkmFOq55LShbIuz3MzMXaD/fRp6pfW9jmgtHNXGEDJ32O/bRSNXujvd
   gT6ttaMpMIxCFNghpDwlBFuFrn5k9Xl8+5pw1DO2wzDe4MfoSQBYLSHdN
   cFVb4vykGH9WkDmUTjVYSvzRdd/23ElkHSiJx0AeWVxItY2++e/kxpc4Q
   8gr/JXPUGMHSmkCBOaiusnX33EECxbkzOWL4DzlWho/zF28LdhiVlhCS4
   uYQaxuV4vrQnqkdGIzK0TBaJQoJP9CGWwTneR3WzU34DdtI2dg9vvuTV9
   w==;
X-CSE-ConnectionGUID: mI3l4+llQ+qVAa5o4Iti5A==
X-CSE-MsgGUID: 2OOEjsWKQfuRSmP5jwpDKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39389415"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39389415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:28:34 -0800
X-CSE-ConnectionGUID: qVxVOSO7S+qcok76EmFqGg==
X-CSE-MsgGUID: j18aSdTcQia9rgM5/OXu5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117780445"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:28:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 06:28:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 06:28:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 06:28:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KADd/foJQEHSwHNHLSF29RRKm0XrqIHq5ZCMUqd3ZGkZum08IlyeTA7eXrLHWlW+/oXTTjvE2AXQmj8PmFNwXSLQDqYNNTwH+Ba3Qy77Vb++HXFTLokWDxHEurpag351q81g0+X2ICruSTVYUHlOF+1xXHkNjCmkwax3mC4G+mrpg1BdnTBV/Zn1mfwGsQ6V5qYS4LKM89VbA+oIhGeizVviefK4siRIltSiClkJ4sOED14oyptBEmzA0+hZGMH8YK4L+JX2u/xgClq2DpvColWSnlmx5RbCTV4tC/4agCXVD5MuzQbNVOzZj/JV3xRMjfKsrGmvIjp7j3APYJoFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rieGo1oCmr70jY7hkmlRVR6RWpcTIiXAUXvw67matlw=;
 b=GrRBM2ylMpgS5YC8tW/OfDJ8Ch1hlOgHBb6cmlv0Xs8qUmTH4SUNjUbgH7DweajJLGJjer4ByoKF0QfseJOPKIQw7mVJTXZGp4ffWOq2pG8lkuG01X4itmaOyFoFKYDt0AFH1lXs8cUiFwRyiJXbnKUtKvwKj9RvRuMxsz58N4sgq/zCR5AuX5R4Jw9H0PvaSc69aFdMxe0XC2woL9VLHZOUp+kdQQgcNbneWHOlwTJ5vTSBxV99TqYZ4rQn+LZYByYRd+g17c2v67mTfE9I4qS+wTrK2cHg6zVWeyfBUHF7HJF+wIlY7viDORSLLpUvwsxgUsVx76V3CulXMQpbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 14:27:49 +0000
Received: from CO1PR11MB5057.namprd11.prod.outlook.com
 ([fe80::4610:6d6c:9af6:2548]) by CO1PR11MB5057.namprd11.prod.outlook.com
 ([fe80::4610:6d6c:9af6:2548%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 14:27:49 +0000
Date: Thu, 13 Feb 2025 14:27:40 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Markus Theil <theil.markus@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] prandom: remove next_pseudo_random32
Message-ID: <sac7e53vnz4djrkpjwvwrr5j54zf3h2tpl4jle6f2djipesyxv@sybj4jr37j5v>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250211063332.16542-1-theil.markus@gmail.com>
X-ClientProxiedBy: VI1P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::25) To CO1PR11MB5057.namprd11.prod.outlook.com
 (2603:10b6:303:6c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5057:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e927b16-9e1c-404f-037b-08dd4c3a9791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2FpbDR2Z1BPTWh4QUUyejVDNHRzcERXSTVTWEs2djFYVHAxL052bGk2djd0?=
 =?utf-8?B?SDVtbFVjMVZ3b1dYbkZTTU1UUGhvTW0rUjNDdUhEWXJHMllubUdOK2h3bW9j?=
 =?utf-8?B?WUZYdkkyQmxpMGlKTHE0WXZwQXlFU1Y2R20rbS9ySjRQU1hNTGxGamhVb0FG?=
 =?utf-8?B?NTJwclVDTnJvYlJFNXNhMWt1dytoNDA0L1grbGV0WnpSYU1aK2QwYXBZdm95?=
 =?utf-8?B?cmFTK3lyRVNXUi9rbzJRMjNYZXozK1pWczdmWjlBSmxGOEdxRWo1VHNnem5j?=
 =?utf-8?B?NkVUVkV0WnhQOEpmRmdBSmZpOFo1ZDJVempzS2ZpdkVqUmZhNHRsMDQxL2Rw?=
 =?utf-8?B?d0VmTlJPV2djZ00wRVd5cFl6Umc4MTBRVmdvVHJydFJsS3QyQnJWcXNhTWlV?=
 =?utf-8?B?b3hsL2RHVi90NmQwb1cwMGtvQUt1VnEwWGd0SFVtYXVBYjV5c0hsL3AzN0Fu?=
 =?utf-8?B?TWhHeDRPNjh1ZEJOZHlxdGdIeEVUOWxXOU45UnQ3Zll2SEVvbnNYOXg4RWd3?=
 =?utf-8?B?M3k2TTA2SDVlWFhvMVRjTk9hTFY0eVk2Ump0ejEyTm1SOU9rMGpLcGc3SENm?=
 =?utf-8?B?TUszd0dETXVKK1hIK1ZVN2JJYm80V2Ziajc5Uk5NTWREOW8zSFRnemhHWUVQ?=
 =?utf-8?B?aGFjOTAxMllOL2JtWFJ6YU5EeUliMEFVUmVhZXFUSG5KM3VnU0NsajJRbnpn?=
 =?utf-8?B?ck1FcTNibXFQYnlvNWMraVlNUkUvSEdiUnV5SzVzdjRzTXRMR1dCbE9MbjY2?=
 =?utf-8?B?U3BqTHp0RXNTNGtXN2c1aFEycEl3WXVNSXNUVkVRb0t3Q0xzeDliR2NuZHpM?=
 =?utf-8?B?VTZURXUzRTYwbWw5eThObEZ0S0s3T3gwNG10QTdCZXNwMEdKaUJTdUZKN3do?=
 =?utf-8?B?akttWVBHNDZRbWlPNzl4VWhqSGJEa2hyck9jMVJVMVNVL2l4UDVXOXFXR2Z0?=
 =?utf-8?B?L05VQTlpS0JaMGUrSzdLUnpWTmtJYUNOTWZPR05Db2pONjdtOWRERDZ1b25M?=
 =?utf-8?B?RTZJaTQvS0l2NXVtZHk1U25NRWNYdmdvMzBRbkNROEhwYXJiV2JhZEZSeWU1?=
 =?utf-8?B?WDVPTmdIbG9KRk5LZ052SktYTGRtL1M4TWRFazhOSXJnb3VYbHpLeGhHTVM5?=
 =?utf-8?B?ZU1FSG0vVDZ4S2hNK1BaVWE2NDhZZ0xtUURSb1ZucnVyc3IwNWphdGkwMmxv?=
 =?utf-8?B?R3hZTzAxZEdxZG45R1RhNlFVVVZiZCtuWmRNRzVwRjc5ZWtCdndwYnJ3NktP?=
 =?utf-8?B?RmdaSGFicEhjSVNYUUFPUDF4a3RYT292SlEvc1k2Q0JFeCs1RWZwam1leHB0?=
 =?utf-8?B?Uld3Zmo5azdiVXQyRGp4cCszdytkRTRKV0k0bklwL21KeFppaVNEUFFmWGZE?=
 =?utf-8?B?azJmZUNMd1JHeE1hbEI1OWRVajgxb3J1RnIrcnplSVJFZDZNcWlmOHQ4MWR0?=
 =?utf-8?B?ekJzZjVFZ0c5U3E0VjdHc0hNWS9kMDdjN1FIWHY4UWExWUk1WEsxY0dVdjd6?=
 =?utf-8?B?QWxBbFltK1ROYkN2dmM3Rk5UMFFNdHJjOWkxTGtBTGkyNmM1MCtpaUxmWnNE?=
 =?utf-8?B?b1NxTm1sN2pzZ0hDSGhreVdGNTl6c243WEE2d2FEbGUrVUFhS1hCZ1NXTVEy?=
 =?utf-8?B?V0pmaHhtdW5PK2RWUVdmUkxsV0NSS2RiZ1hZbUE3WmVFZStMVTVscHoxRDhX?=
 =?utf-8?B?clhRZWJ0TTRXQ3Y0MTNsL3g3LzRuUlJDVGVwZkpZTktFOVowdlZWRmdzOUNj?=
 =?utf-8?B?SXhtOWJSaEtRMDMzbm54aVl6Q0pPcFZWOGJZNHdKUGJPZGRlY0JJSXJXS0Ur?=
 =?utf-8?B?eGtvcEY3eTduQU51cEs3a2orUk0xcnI1R2RkQXJKdU43RWxaZW9vV1kyb000?=
 =?utf-8?Q?ktXuSK4zU0PBi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5057.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elpMVExxMWsxOWkzOWh6Q0lFQlRTVGpBTUl5Z1JwSWk5SE51VHpKN0RjMUg5?=
 =?utf-8?B?dmVHbEtBTE5lOFpSVFRNMGZqdmh4NHRScXlRbzQ2U2ZZY0VTNXVEalI4ZGdp?=
 =?utf-8?B?Tm9SNklXV3RCR2FSNWJ3QUN3TjFlRW5VdmdNK2FFOUlkSW8xNkdwRHQ2c0FW?=
 =?utf-8?B?WG03WW0wVUltWmgyMlkyTTlkeVN6d2FMQkJvRHd0NnV3MVhtSFZKY2RJTmFX?=
 =?utf-8?B?T0RBTnlqNHN5SGFKcWp2S2loMUhmdlFqWmlVVmdoVTYwSUt5MEF1bXBySDJs?=
 =?utf-8?B?TVJhcEJQN3pYZHBFM3dGa2VVL3I4eVdyWE5NQUkrWFZaazMyc2oxREZ6RnNQ?=
 =?utf-8?B?LzZVNEtJRFlYcXNVYmloQTFFYmxQbnBNeDZzYmtMaEJIQjVSR25GZndscUlJ?=
 =?utf-8?B?MlVrbzkwSW5ELzgzdEVuMFVjbHovREVHRThZMXJDb29wNHdNNGxLUU9PQ24r?=
 =?utf-8?B?RUhQbWcwNUZ2NUxFcVZ3eHlDN0kzYzhzVFdoTjhPdDZvN2o3eVpMdTMyRVZl?=
 =?utf-8?B?aE5CbnpKdW13Nk5GWTdnR3FMby9UaXB5S3RyaDEvSWtMNU5xVFZsR3g2elJV?=
 =?utf-8?B?VDNBSE5RSDdkQnNSdEtvMG9KY2xGTmhvQjlFbFZwRGpSaXBRMkxDSFlpTGxY?=
 =?utf-8?B?VUFMR1VzWDYzdEpPS1BlQ0NESW80SWVuVm8yMU0wQWF2dWNqMitPUmpMeksv?=
 =?utf-8?B?dE5jUlpMb3EwamlBcWs1QVJUVkhsZkJRNFZUTW5MeWJzQVIxcHJIbEt6Y2xY?=
 =?utf-8?B?d2F2cXk4RkkwVkFEbXVET0svRWtuNUhWNUNGR203elB6WWlZaUpkTit0amV5?=
 =?utf-8?B?ZkhLaU1vVndYc3hjbTNCbFlrVXlmZTRETTJ2YUplSWt0cDMyV0x2R1IxeWxl?=
 =?utf-8?B?dWJZRUV1KzZHWWMxT1E3eitaSnBOU2cvYjQwQmtMSjNZRkwxV2FlVDlBSVRU?=
 =?utf-8?B?YzJGeVZhSHRBT29jTnl5QVl2S1g3QUpneVdRQy8xWGUvUFkyMXN3ZGJWU1R3?=
 =?utf-8?B?UEV2VHFLNm53aGJJa1F2dy9PNGVnTTZ4ZTNFQ0YrcmM3alpmT2pBL1JQQkJ6?=
 =?utf-8?B?RGNMUGJ6WklIVThxSXNTMWV2d0xhWmpwN3I0TjMzaTBuSkRJWk1Vd05PUTBZ?=
 =?utf-8?B?QStRZUVYWUlRQTMzbWJ3eXRjejBicmJkeElMWFhDZTZXOVVOdGphb2s1ZXU3?=
 =?utf-8?B?czFRRmVYTEtQYjNvdDMyRFEya2pnVVJEUDJkb25UQndFeHdCRTRsSC9PZkN6?=
 =?utf-8?B?NW5vL0JrN2s3Y1paREljdi8rNHJwSzBub1NhNVpxVml2RjNpV1FmRGlLdnVE?=
 =?utf-8?B?a0crS1dMd1RwcHNobjR4Q1dSQTlMZGFzS0phSFR2ZlI0VnZDR1FBZjUxUUwx?=
 =?utf-8?B?c1AzajhlVE9tWUwxSDdyeXdRVTRoWEJRMit6Uy85UFBLNHZ2ekVCVFBWb2F4?=
 =?utf-8?B?TjYzMTFVUERFK0d6bFozZURGR0thYzUxTnZyYjV1Y0gzUHV0V05NdUVZb0Fx?=
 =?utf-8?B?cDJ1NzN5dTZRcGt5MTRTeXBXSm8waTg4aGxLRmtvRDdsT0JyN3JTU1d3dzZy?=
 =?utf-8?B?TEkrYU1rS1dsalgzbTRuQTdaUXRUY0hLUHFyam43UXRKTGliU21NMlFZa2lp?=
 =?utf-8?B?ZUVubmpUNUdFK3ZwSVVnNWZnbFhZL0wxcGJxQjl0dDloNDRIcEdoZU0wcWlj?=
 =?utf-8?B?bW9sWVFsZWZjV0NDY3R3L0RuOFZOQllzZms1ZjVkVjU4KzBiYkZvcGJQb0JQ?=
 =?utf-8?B?bzQ3eUEyS1JXVVV2dXcrc2htZDhydDVlZGpRdnpOWW9zenYzT0YvNTFKUENB?=
 =?utf-8?B?TmNlK0RvdkZBZTN1c1lXKzFvemhIZkg1cUxqUkttRmViTDVKUVBxRWpMaFpp?=
 =?utf-8?B?ei9yN0c3ajZnT3U2cUZ1NHlacm9VK2UycjQ3UmdaQW9pWUNpMU5lT3d2dDhi?=
 =?utf-8?B?MmFZU0tWaUtoWlVibU9yWkhtT3VMcE1HSll0TlR4cko1K0FzTy9jN0J3NE1o?=
 =?utf-8?B?VElieUVNS3JSYmlVa2d0Z3ZJTlNsTWhOK2xjZ1QrWGdta0xYYzZ3YmFZQUw5?=
 =?utf-8?B?NXNUdCtnVHZ5L2RveTYra3l1K3h3TklmTTgxaExMT3FLNE1aTXBldzFHYytZ?=
 =?utf-8?B?aThZNFY3U2wzS3RDL2p3OE9oQldoMjE4RDdMUWU5MXFtZWlEK3czYzB3bnZX?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e927b16-9e1c-404f-037b-08dd4c3a9791
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5057.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:27:49.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdxvWwVdDDujqc4ASTOWdW4YZuDnF8dchpLtkLoezdhihN0C3onLpBCF1AzWpD4CjHrfw0MFLFff7dGIBflnr7oLuPolzE2HNeV8M4+HzL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

Hi Markus,

> next_pseudo_random32 implements a LCG with known bad statistical
> properties and is only used in two pieces of testing code. Remove and
> convert the remaining two users to the single PRNG interface in
> prandom.h
> 
> This removes another option of using an insecure PRNG.
> 
> Markus Theil (3):
>   drm/i915/selftests: use prandom in selftest
>   media: vivid: use prandom
>   prandom: remove next_pseudo_random32
> 
>  drivers/gpu/drm/i915/selftests/i915_gem.c        | 7 ++++---
>  drivers/media/test-drivers/vivid/vivid-vid-cap.c | 4 +++-
>  include/linux/prandom.h                          | 6 ------
>  3 files changed, 7 insertions(+), 10 deletions(-)
>

The series looks good:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
on all the patches.

Best Regards,
Krzysztof


