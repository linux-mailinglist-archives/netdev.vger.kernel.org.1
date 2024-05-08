Return-Path: <netdev+bounces-94472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6358BF959
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3800C1F23112
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A76745F4;
	Wed,  8 May 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/UmfhNA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE374407;
	Wed,  8 May 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159487; cv=fail; b=GYp7p1MsUNHOqBlgzxRYCw3Cs613Pi2p+hl13S88u6noaE7sfblzbICUHLa7P1mAwdA4g/E8nyMUVdVZ1KBBI8V9WJFH35xmtnXtIVAr/xIrjPGaB/B/rbUyLM5rftF9fUN9pojpNOZoxBCPPVDCjPSzQCSoaTnxne/xyvmIxYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159487; c=relaxed/simple;
	bh=xS768L9Rao6jyTpUYZQk/BFXHKfrc7rO4jZb/QdjLk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HqJjWaxzosi6kKtlF6sV7+UB3Z278jK+J4mHR7QN4z8QTWG6C8pNdG8Ykis6bTUoYrSRivzXrYFIOdVcCe4yWdh3Wtgc9GQlW7i8TApgLNek0sC22gGp3WTKmXW/MT8hYeAeZLiJ5gUZJMNPDnysYjVxuaYJUzvtUqgo9RfNGjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/UmfhNA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715159485; x=1746695485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xS768L9Rao6jyTpUYZQk/BFXHKfrc7rO4jZb/QdjLk4=;
  b=O/UmfhNALYRBCI5BxC3PXXnDRomU89xyZu6/+fvw8g0Hcsbf89rc4OFh
   jTZDJtxgBUHuSYdpfeiMn4zggJpw8+yTShfcz+8L1iwvw8yybQx4dVSPP
   I41YDjiM+o1PySv9y3Ug8jjP1q4IVn9ZZx7nOkFenWiLvLn8ShgkreMTP
   kn2nF5iCtIE8m8VfIBbVxdKMr153jB//SfreOLzgxMJdPkx+RPp9glpN1
   zjjO+uSs/pvYoW/5WNmBwafbkMJusxLMMeiJ0DW87ssD2TgQcU5V7eFis
   kxi+cV1qtkUFIpsj3eEh+2TT+bBMOw4xUHpqLETtJCDoKioiqwg3UqYay
   g==;
X-CSE-ConnectionGUID: jUTHnKkYSyOlLSHmVazykw==
X-CSE-MsgGUID: k6GMA0mFRB+mtQP1vwtuDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14811025"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="14811025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:11:24 -0700
X-CSE-ConnectionGUID: oIgPRUTTQTC6fAhUmSJIAw==
X-CSE-MsgGUID: c7Akn3R8SrG936chhy+DCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="59679512"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 02:11:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:11:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 02:11:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 02:11:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5YNIp1wGQhpNTRh8P1sKPZVVzBO/476DIv7YtTpFb/DExICPC1X5nm2sYg2bVep1B1QALsjnUjSDllPjLcwJQiM+lmAzcCplUY/BETcNtUzA00l57IhuWjuExiwPxN/f2/ulDT9YCnNEU+xg/0AUU1PGxgo86V9Fn/BjRlpV3HPuAjd0RX5TqbuwU22O9fki0VXfJru4/QQLNcnhp+2zMNUN4p1qs8wqBswko5db6NQnDM5HsM0CHYHQ0HmWfKn+rXl5rggXwqAtb/fVvezP3dBy1wLAKFpGaOixbmlEXmzHzgoEjoJ8mtlwSyFdd55z4jylIRtkm6zcNFFFBy87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOZyb1jUsPNvQkMJl1rxYEYy8a1p9iZqwSIITxg21MQ=;
 b=O2FZzSrEOK53QTVc9SuRyGPobLFg7s5xgtwknpkSKT3FZjOG9PQoNKAa8inlFzByd6rn4XE/7ttXiC0UT0q1XJrHID7Qj2dkh3VIz2DwggiW4jq9uo65ZA+NsAPhTEXvAhGCuK3shGZ1vXSKpOfdx3d6f59+ZfvVld/6QdIxD4Ru0jDIusJTQEFBAPtKNSiutpASsDq7GuMv+0O+9+S6O4MPDa809DKXJzA+OqDj8ed4AdHqLyt70clrtYPvd+fnffFZ48C/ij/XdsSEGNlZIkDAfSxidVWHFNrhv+9J91sm4jRRjWrV9bpiVHDQ9FZwmXme29Xb15WG6kIWJNVUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 09:11:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 09:11:15 +0000
Message-ID: <90fd7cd7-72dc-4df6-88ec-fbc8b64735ad@intel.com>
Date: Wed, 8 May 2024 11:10:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device
 _properly_
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Simon Horman <horms@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
 <CANn89iLANEp-tjkKSawPTmH8DxaSQZ_OoJaAYHjLPkmwGEJ6nw@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iLANEp-tjkKSawPTmH8DxaSQZ_OoJaAYHjLPkmwGEJ6nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c73d623-b1bc-4dc4-4701-08dc6f3ed02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTBCL0lSUEh1WGZtSDlYTnlkSnE3Q1lhY3ppbWVTelBJcHQ2WFR6VnBubEdL?=
 =?utf-8?B?SzREOXB5UVhYdmRlSy9Md0ZXS2JtQm5GZ1lvQVlRK242SzBkMkRPay9JTzdm?=
 =?utf-8?B?SjNOQlo0TzZXemlEVTZMb3M5MEMyNGRKK3lIeVd2aFlTeHlXRHZHckptNHdy?=
 =?utf-8?B?V3h5MDJxRFBTS01CdURIZmFnTHlncjl1MWk1cG43S2NLbzFsdGd6Z3c0dXBi?=
 =?utf-8?B?NTZPbzVmdm9wbDlNMG00QVJEYzVkU242M0tlN0ZacnBCSGx0aGdZT1VVcmpq?=
 =?utf-8?B?UXhtY2tVNCs1amVuS2Z1ekhwK085eTkyUUUxR1FNcldSNW5pU0U2NzF5alBT?=
 =?utf-8?B?aE8yaGI0ck1aRmU1NlZRdmtmNTJ1bjY1cnVleDdmY2JwQTdER3hIZE9QN2J5?=
 =?utf-8?B?alpHK2pWVHRSWm9MZ1FTWGQ1eDhHZ3pLVnd3QVZlWFk1MEZ2WmgwRFd3ZWVJ?=
 =?utf-8?B?NmEyTmxXYkRlQnRqRGRCNVdNaEJmNG94WVFCdHdER0hxT1NtRTY1TEFabmZt?=
 =?utf-8?B?SXNzbXdDWXowMzVHYkhiNEpkMXVVQTg4dnFNWTc4OUZDOWRBb0lGRDl0am9k?=
 =?utf-8?B?em5CdWl0clhIa1R6NFIwTFBCQnpSN3ZLaGhPcEFjQlM2RmpPZ0psMVBMMHN5?=
 =?utf-8?B?VXF3ZzlPVGhRQ21USHRZZEJWSVZXRlp3dXZQUDc4OWdDdERQemdnc0hRcWNs?=
 =?utf-8?B?UXlLQmVtWUV6T0E1bHJEa1ppcEd6WXBpOFU0T2djS0JscnNTdWxENFZBUHpS?=
 =?utf-8?B?cndPSFRyT2tlaTJhUnNWQ2VZb3JyM3FsUGR5VkVPWGxIYldDaWQxcndGTGNR?=
 =?utf-8?B?SnpmVm9VMDY3cWQwcjBYY1ZQWFpxNGZYNmZpd0pkYVpReHFwL28rY1hDamNV?=
 =?utf-8?B?dUd0aDFNR2ZwaFRKTWFkbktnenJrdmNCM0NYOVNMcU80MlV6dUFUZFhGRTYr?=
 =?utf-8?B?WEZwSkk3MjhNOVUwZ1pwWldIaXJucVVqb1N0ZUZEZEVjbG1XYWtXNU9KTGdE?=
 =?utf-8?B?bkEwWnBKQ0MveDlRTzQvSUVNSVh5TVhsaVBvR0ZHbHFya2lBbWNRZFNMaXFr?=
 =?utf-8?B?UlNWUC8wYnNvSXUvTThUQms2OElFSlJ4M29yS3BGRXUra0RGZWRrRHpQM2NX?=
 =?utf-8?B?cEc3TGFxa3RISE5CZVpnNXg0SnF6dTdoWnAxamtuME4wV1JPeFh0UHhhbC9j?=
 =?utf-8?B?OU9wSHR1ZiswMTBBQ0V6c2VHcjN3S0VjR3F1SFVES3VvOFFzWFlpSVA5WDVn?=
 =?utf-8?B?bEhNQktTV3RVclRId1BXZ0FUaFpYVEExbW5MdUhmYzdUMzdQQ1lIYSsvalZi?=
 =?utf-8?B?QWREdHNZWHBEUklhVjVqcE85azJmUTBsRmdqU05zZy9aWkc5cXc2QUZEb1p6?=
 =?utf-8?B?czZKRzBEc3k3Z0tiNXN3RUIvS0pNeWlTcWxBeHJqV1ZPMU9KczNFNHdnd3JB?=
 =?utf-8?B?aUR6Nk4wOEF2YUpQME5HQ3BHMTN1ZmhCdk1BTjlDZkczWG4wUUJIbkFDVXZh?=
 =?utf-8?B?cFE3V2JjY0pVNEY1RFRZTjB6UmI3Yko4UWZBdjc4bGI3eFpBS0VlT1Jzcktm?=
 =?utf-8?B?ZDVHM0pTSkJaQXBqODJ3Ump1a3N2ZmkraHB3bHM5WU9JK3pJL2p4UUg4R0d1?=
 =?utf-8?B?Mm9TQzZjTU5qMHZkMlNUd29pYWRkNXpHNXhtOTh1NzFZTEMrNVBqMUpHMmFj?=
 =?utf-8?B?U1BrUmpVL1p3QmlDSWhZSWZXY0JUVHdkbkt5blpkWENVem04MnptclZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JaT3dRMllaMmUydVVPNlFBaEVlUFdqMVNaR0NhYkJmR21BK0tWWFdEV3Qr?=
 =?utf-8?B?NUd1UHRBbThmRHlYSWsxbFVGM0JLbzRLZHViYlgvQUZoaUNyOUtJdkR4UXdV?=
 =?utf-8?B?WnJIYnIyejNLcWVBNzZVQ0pybDFzSWd6eUpsbGlPQjhSWlBtNHNPTWdzTlVv?=
 =?utf-8?B?TnJONzVuTVorNE9yZE9FOGpjTmhlYzJpblhqaEJoTjAvV0NiaXpSNkxkdWto?=
 =?utf-8?B?NU9acURLSDFFaEZ5U1dJOVNhYmpQY2VYdUF0bkwzd2htN2tKMk9XbCtvWDBv?=
 =?utf-8?B?T1VwNktnTytxdUJraDNMSjJvdTRXOVFwYW1VSDZqUi9MUWdlcy9zV2xROVZX?=
 =?utf-8?B?V2xBZ2l0S0p1YWkvTEJLTFJiWmE2ZTVWK1FhZ042REtxTVBEOG4yNStLOGsr?=
 =?utf-8?B?RXZ1bHBUK0xLUHRzaFlkTUZDZ2lnQTg3L1JtQkd5aWhUeWtNdVJMaTA4VHFu?=
 =?utf-8?B?VU1jRUJrZWNpenRxWVpQM05PUEdaT2x5enFHVE8xUHVHNHZTSE05OTR4YTlH?=
 =?utf-8?B?N2J0RFluam5wSkh2R1I5R3A3MzFvNlI5SXBvZE1ic3Z6M2paeCtFSGlTSG0y?=
 =?utf-8?B?a1FwWm9xbmd5MldpT1NvaWNYUEowTEdPQnFuVHNLdHdSYVAyMHo4RllNc00y?=
 =?utf-8?B?QUhNZ2ZLMDVlUitML3ozQXZuQ0NIOFoxK2k3Q29NRWxyeTg4M09kdjFLeSs2?=
 =?utf-8?B?MjhYck1kbUZLYUN0TVdEZmtablM4ZnRHK3NFbTREY3d5SHRKOW9EaWpxeSt2?=
 =?utf-8?B?MnBUM3V6TTdUZWRtUHZmT3lPVEJBQXcwU3NSUHM4Z3lwVWdWejZJSlFYN1RT?=
 =?utf-8?B?ZHBDamNFQ2tVTmloSEVramF6WlFHa0J2VkNrQ3NxaXdRMHNJSWJDK0JvRUNI?=
 =?utf-8?B?SHlQTVZIanA3MTBDSkxwTTFWR2lub05uVXV2YW9SZ3o4L3Q2ZTNVb2RQQ00r?=
 =?utf-8?B?T1hHazBUNmlRRUVIbzNOdE5YSHVWVTJES1BXWXExNEZIN2p5SHdWMmJjam5t?=
 =?utf-8?B?blJMMHU3ZW9BL25HU0xIVzZoYjhhMmJ0Q2k5dEtLNE5raXJKNVVVeW9hMUxH?=
 =?utf-8?B?RnJTcC9TRXBVMHMrQitPTVBxUzB2bEhuZzFvOXJONk50NndhTFZzeXZQNWM1?=
 =?utf-8?B?d2ZwVng3YWFsdko2OGxaenhyMjVSWWErNGl2dVJkYjYyaGdXb1dOaTM2MWgr?=
 =?utf-8?B?S2VTU3A3cWZGbHMwSzRMSCtucjNQY0F4c29SM2pkMklRMHNuVEphcEROSmMx?=
 =?utf-8?B?amg0VUxuRWEvRzJUWTg5ZjhuTWh1RFJxVHk4MlVvSnFqb0RzZmZzazFGUVZY?=
 =?utf-8?B?SzJkZGIvNkVDaSthTERublVycWpIQkN4ZkhlalZzb3JSYXpDd1lUTElnbFZY?=
 =?utf-8?B?Y3ZXYjdQWkVwQU5WMmNrTkRyc3YzandBWWZTQzlyTERENnBGOVR6WVhUazZL?=
 =?utf-8?B?bHJDN3FLQVYwbVl4S0xNck9hSVE4WGZrdXZ1cmZpUitKc242ZzhBL2lnbDVw?=
 =?utf-8?B?eEdNY3VwRE4xVi9LS2o1cFNnekJTUG1JNG9VbHB5bWYyNldmNXNsdUFpeXNY?=
 =?utf-8?B?UnBGSkhlRHF3bGpTZnJ4cndVM09xTU5DY1YwUlZBblcxRCs0Q09YN3QxODNu?=
 =?utf-8?B?SDFGdDZBTDNuOUpsNXo1cElzNHk3elB5VDBFR2JFTFJCZjhxWnJIT2V0Qnda?=
 =?utf-8?B?aStRNE8xZGR4UzI2ZUEyYmRSdllPUVdtcGcyRFh5Skt2T2QzbXNaNllGUFVw?=
 =?utf-8?B?R1BUTk9Wd1RpdnlBTnlzUUlLb3lqd2xma1BBK0F1aGhBTExTN0FKRXhIU1Yz?=
 =?utf-8?B?ZEo1R1oxaGEydHBkMVFoOXF2Q2Fha0RWYmJmUXhTLzdRS2x6NEtucVg1M3k2?=
 =?utf-8?B?NTV2VUhnQmI1ek82NmtOWTRCRVBuejJFTDhHVmZXdnBlTnVVVkUxNkN1dHlQ?=
 =?utf-8?B?dENaTFkrZXpQUldmV0VTWStiL3IzaUQveExWaURpb0RGRzhZVHpBMGxqb3RR?=
 =?utf-8?B?bkVnM0NZL2VvRElPdWlSMVR1NnVYNUZkVWcwdVRhcW5iUGcwenZXT29ObnVJ?=
 =?utf-8?B?QjhtQ3J5SWwvUmR4STRNQ3NlZ3U1R0pPTUlZVGc0WHNHTFppUldROTVTVkRh?=
 =?utf-8?B?Rjc4MmpRSlUvZk5DMXhzUFFDNHRXQ2U4eWpOUS9kalpEMUx2VkY1dTVpS3ow?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c73d623-b1bc-4dc4-4701-08dc6f3ed02b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:11:15.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L+wmnOesKJ41Ld/maM64caiYZJForZcfSqlebDdpirEP4DY6tf5k9eptDDFzxTcehZOOhxYE6/wNRzE4DBcEJCgyp1lsg3wIrxHTvUYcOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 20:21:58 +0200

> On Tue, May 7, 2024 at 2:40 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> In fact, this structure contains a flexible array at the end, but
>> historically its size, alignment etc., is calculated manually.
>> There are several instances of the structure embedded into other
>> structures, but also there's ongoing effort to remove them and we
>> could in the meantime declare &net_device properly.
>> Declare the array explicitly, use struct_size() and store the array
>> size inside the structure, so that __counted_by() can be applied.
>> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
>> allocated buffer is aligned to what the user expects.
>> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
>> as per several suggestions on the netdev ML.
>>
>> bloat-o-meter for vmlinux:
>>
>> free_netdev                                  445     440      -5
>> netdev_freemem                                24       -     -24
>> alloc_netdev_mqs                            1481    1450     -31
>>
>> On x86_64 with several NICs of different vendors, I was never able to
>> get a &net_device pointer not aligned to the cacheline size after the
>> change.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
> 
> ...
> 
>> -       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>> -       if (!p)
>> +       sizeof_priv = ALIGN(sizeof_priv, SMP_CACHE_BYTES);
> 
> If we have a __counted_by(priv_len), why do you ALIGN(sizeof_priv,
> SMP_CACHE_BYTES) ?

To have the whole block of &net_device + private part aligned to a
cacheline size.

> 
> If a driver pretends its private part is 4 bytes, we should get a
> warning if 20 bytes are used instead.

Ah okay, so this should be

	p = kvzalloc(struct_size(ALIGN(sizeof_priv, SMP_CACHE_BYTES)));
	p->priv_len = sizeof_priv;

> 
> You added two ____cacheline_aligned already in net_device already.

The whole size passed to kvzalloc() must be cacheline-aligned, otherwise
the MM layer can miscalculate the pointer alignment.

Thanks,
Olek

