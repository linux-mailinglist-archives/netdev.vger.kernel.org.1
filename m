Return-Path: <netdev+bounces-281840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBU9ErKq8GnOWwEAu9opvQ
	(envelope-from <netdev+bounces-281840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC8484F9B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E107F3054C1E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2843C055;
	Tue, 28 Apr 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I50uQ6uG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64B27A916;
	Tue, 28 Apr 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379992; cv=fail; b=CWxNB8ZnGhZWCtfsP6oZW0O8Zl2MsLQdujIlpCwYx58c8Y7fyinfUU/5WMoo+NXrDZmOZMNtvhVtTDKqmsYCRbTudL55K9037HumLbq+P5aAhl52qIIkfnZ0U0/K123ziewTRfqijLINyM2eG1WuPv9CfunzWqUu+gpaJdzaqfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379992; c=relaxed/simple;
	bh=phGBkWLyukbfx9xI6zffzguhf4BBK+2/5ZyjT/0lKec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9nRbnn8ORyr4umF3bk8HDSB6cpXZtt3KadF3B3VP9PTHN/Xz20GzyjCwQ/m5PoIIU6Wl8R8Ye+dHYSVr4XEYsW5RmQHew280szamzz+y6jlRSFataPbWKayQYU6k7AYQ4GY0wvfFfKoyphwuBkGuHyMtF51m66cDs9ZwNLv6N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I50uQ6uG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777379986; x=1808915986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=phGBkWLyukbfx9xI6zffzguhf4BBK+2/5ZyjT/0lKec=;
  b=I50uQ6uGeTGrZwVPAU7sNAzGjaoTzPAq8Y61uIXXq8AKFTQgENOvCR/N
   QHrbATBN58jY8f1wOx7C0mM4+mqeM25CnXj7jeuQlmu+Bvqq5paRxYgpj
   jZAHZCdJvbTNzaFVpksTUOX/91xajv7ybaW19UJCADsUiig2NqmIlhU4u
   G8p5hsW1Lt7z9ja1Tfe7sy/FVwzb35rCWw0IXl4byglZxvXW3Il2w/GyY
   mPrUxWKVO30H4Df9IY8D3GS8wCUEmeu0ulhIELQMd7Re1IsoUHXlOptt6
   V1fCJNDdrmiV8nBMti0LNt4U5G6UI3NTpaf8mxGsWIY92KHfnpSLUH4hP
   A==;
X-CSE-ConnectionGUID: AA2KjzDhT06qGJ80rDui9w==
X-CSE-MsgGUID: gndgh/u7TMeWj0/jjUCXeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100943597"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="100943597"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 05:39:41 -0700
X-CSE-ConnectionGUID: pk11ncyLS/WSvSCeKkeDbA==
X-CSE-MsgGUID: 7B1J1UvjRBWrhYIpeG/Z0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="238287946"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 05:39:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 05:39:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 05:39:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 05:39:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FARY3W8sbz5QWE/3/Bi3ODs6TvdY58qf3nIXuYUozc83eG4d1BkABFF5V7jwOeRB5pq+wLsBsLHi4c4sXnr6IQtn+f0s0+uuHjD7V9GaQhim/zYm/96383vwv4s62T4RVvw99h4V9mIhsO1KBSgNdK2juynRgInvxj1C6KEnnlQzY+ZbhPzO5+bPR8rw93nNRc9VBC1R4kZLRnSBFIXdTFj0iM9i1n0hT1jgnxWkROXLiZ1BfR5OoJ/I7WSgpZ0Jtn5A3L9BLgC1YwumoDqx3/yVQXhBkm7j/FXfJbqwRNAFLFLp17MuJ+YzMabhBsWBzvTJ6P5LT5z1d0CnMelY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxwyE96eZwkU/rwiWiiil2DMmoyBzCLzLYP2lapzZFM=;
 b=j+Jc2BJxJtas+aRBK0/8nkWoiarw88uQ+lzAyDXOFc0ZYFdZp5dvrvubZNY/3R+QukHEOqib6cVpw6/gOxpyyouqK2EQxHFFB6rNnb91SjnfZglHy34T5IikSQ6idVSocm36hNCrvS9L1+1X+R+due3WP0E8oZwjdOwGnfZCkiiWVWbgp49qyvmZk0MMy1JhRfCiSJzxYqhVK4u2uF5Kxn6N23LlsxMdPn5WZiQyJuijJh02hmTW2Tu4HAADn6dAY3788PAC2kxiKCsVCzg5qeawYo8NI1uevYon5RafyZrKdoelQ+y+41UqFuodr9nD0nnL7MZWrbvKOqzqr208yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 12:39:35 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::4c62:9ba6:df27:c731]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::4c62:9ba6:df27:c731%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 12:39:35 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "kernelxing@tencent.com" <kernelxing@tencent.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@kernel.org"
	<martin.lau@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "clm@meta.com"
	<clm@meta.com>, "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>
Subject: RE: [PATCH 1/5] selftests/xsk: Introduce helpers for setting UMEM
 properties
Thread-Topic: [PATCH 1/5] selftests/xsk: Introduce helpers for setting UMEM
 properties
Thread-Index: AQHc1ut6HgUTHUsptUa+qDjWLBrkmrX0RaSAgAAkU1A=
Date: Tue, 28 Apr 2026 12:39:35 +0000
Message-ID: <IA1PR11MB651448F801CAF903615186508F372@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20260428080317.702124-2-tushar.vyavahare@intel.com>
 <3e859787db4c4e0410c0a4110f162a0238673579eaca9ceb0a18702faf975000@mail.kernel.org>
In-Reply-To: <3e859787db4c4e0410c0a4110f162a0238673579eaca9ceb0a18702faf975000@mail.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SJ0PR11MB6622:EE_
x-ms-office365-filtering-correlation-id: a0216fae-a89e-41c6-db7b-08dea523346e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007|921020|38070700021|56012099003|22082099003|17002099007|18002099003;
x-microsoft-antispam-message-info: 3U8Zt3lhG4aEZHlYy2Ej1frSgtw8ZvevE46f3vw5TlNMBN1mF/De0Mf8nFnnkfUZNyVew6kIORDqaKF3H3MRmhaRGxgLfNfOM/SL4pNSYFD5zUKQNVMBBAsUvdH6dukWbY0dv4nQKDBILGzypOtavRbSajqt4W7Qfg0Hi73nrAVjOyY9itsjqKrWRdLb3SN2zjIf/3dWk5cd5F+rUl7vGuRFau6ESMcOCyrzFcn/F8QZXzZmXMptYVZsZOW8KQdZ9no7OONkUqPcqMuaofFvEN6BteVagsbOVKa15EFiBKr4+LY0Q3ZDB25yIF5u48ceyBW9s+/1+j8ArbdYFPMFZudpkwqVX9e9TuHJ4SFrPanG6MNEgl6qm1AUdkg4djtrtQoVqTRnlyu/FcYm3TxB1Sex3atpzara+I9l/IhjYbTPpthNlFapn9OexqsOBf09TPIgto27lPqOUiLbr+whka6nzCJk6DfqnhZRYQniYh7ri1rdo0ghus+LMCbYK/GY8FbKzyr+MxTsmjI+TTddM77NwExVyfJHL88bWxbU1KtqtJXtwsGAaTUW4132rbc5V8t+eDalff+5K77d3xfmcT1fxxmR9sSNB2+mx828Lxm4g1Ww4EX0K25A6hMNsudi6HGHAfBjZgYnrhWvRZwWGgyebYirZAVRJSrTkRTh+vJYK6UYiDF0n2DlJotBFA5IiAeF0T/eVjZcBqOOZLpj5uyZbDsNLYd7BIkPqZ7Nhklk7L+5kgLzbfRFVhrKsiaczP5wmQnQ1TNtplBfW/ISPaneuPa5LyOshzCF7zpVSERN7Hhq/FWVeobb4Tk57fVs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007)(921020)(38070700021)(56012099003)(22082099003)(17002099007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/S63kLbI33FKl4bphwZHR55Kugn+D417Q07tZBO3I/TyzyffYtEaFcagLwpU?=
 =?us-ascii?Q?zvY5Vsff4HO3MIlk4rgK8FzpwlqJmGcpsR/+VCEXivUVZaJROYJfcmdF3pRV?=
 =?us-ascii?Q?AJVLRL/lD0IZ71K7QijnSAYMhTR5LLeGbvVJQG2GStDxgxeDUQI4AoDybpeh?=
 =?us-ascii?Q?Bn5iL530yM4OfEavx4TUM6D5LcNm6NPrHoy6W4HNmnAgWwymskQA49NdfkeH?=
 =?us-ascii?Q?d/OVN9++QMCEbntF91GWiowCNd41sEWs5G/Y4uko061DzRUxsil3KaRsnSNl?=
 =?us-ascii?Q?kRvvMLTvjWmx5Elt3JD2ylFoLzxEtzb1V45quId9lZ3EQ8jQc+XkY8EErPws?=
 =?us-ascii?Q?4IbySVQz9lHklVPyqkQ59laVullZgKA/cxY9HAZcWmrqYwqxOaAU67xJTIoi?=
 =?us-ascii?Q?dmSYDG1cX2UVopvLRd1wZR2AGBtD0A9rD0ltrfVtp9mgFSxGb33Hq4AahI90?=
 =?us-ascii?Q?AM79G9rB9yZRcVV4AwqR2BZUugSUBjb1NA2zbcmpT3C2PEvFJdIN2xyx9TH2?=
 =?us-ascii?Q?zshBFOM4rUvqXjs5yM8eC2oUNyi4fHc5q91CPemobgFMvFvqUHOmcGykw7AF?=
 =?us-ascii?Q?5n9NKOmiNDqUlr78oRZdDH2JtftaLJ1R7MhEiwwEnsBDEftqWzTdBbN1jiWv?=
 =?us-ascii?Q?TqAVHhpcn9B8+d2p/gL0RdPsyETVGpB5IeppCRlNR65FbBaBSwN+wb1+t19q?=
 =?us-ascii?Q?UXaYPLGPQMksobiK+CpHOri5qLj/1SNqjjdsaskJL9RdtQ17qayMpBDIqKWg?=
 =?us-ascii?Q?+8mm3B9O7WkgQFeQ+oU2FRcCovtbXFPak28rWztEGRKc9tqNo6yr0xSSIHQo?=
 =?us-ascii?Q?SHgAhXNo9tP5XEewNbSRRRaH31orFnKUi5OYsF5z2BjO1Jd5pPtPZIo4fC8W?=
 =?us-ascii?Q?ul9qRWU0dI2xXMo7lr75Bm7oWVnWK8WvKXEmDd/+wZYK4OUoz/nbj22S9RtF?=
 =?us-ascii?Q?2cSIZP7HOves6OhCvCv0sU2IaYlT6WkBwqEHfBXjKom8m01RNqKmla1PYsNP?=
 =?us-ascii?Q?fBOPbsdYo6UP5I0q6Cdhu+yGVNdcdjhMOYB15EmmBfwZbbTdW4IJ0IpApPc1?=
 =?us-ascii?Q?NYNRK89+JlCIXz/yYS4lIfxk6rCsSo8gd6SS33t0XqvnWqvNtQbcSpHlN+zj?=
 =?us-ascii?Q?MhW7V64vOpSFhFXz43cdMZbbkMn589wbUNVCVdVn23BWBNx9bkzEpKyO0H+f?=
 =?us-ascii?Q?ZKxzGdSjsb8UqyMd8SzztEytHuYWfnq/dRwYSikGw5lR7ctvVEwjCPgRhIsY?=
 =?us-ascii?Q?LOnfa3u6ZD6BHiArTVRuYfrIyhAY7T7Tzst666RspKcTSLXHX7274YA4LeFm?=
 =?us-ascii?Q?wyh5OiMaHL+CgipcpWEnV3hcvu+pEPznnNPl2CaWxE/9nqIkAHHlsON2mC22?=
 =?us-ascii?Q?zXepeHmyqrBrY+iVNlnXI6y4yDL1GV2YotqdgA/6Vem9WkL+EbKTAnIwXaKZ?=
 =?us-ascii?Q?/zdugSRlK4BRkrJTwQIZmAz6YFECnEPLXQFwn06qaHXq6g27oOy7o8blZHcO?=
 =?us-ascii?Q?x0EgnmiAGKtRzGBCQsl25cGW4eA3Le1evNXhy6Q9SWZXj01FyPcqWNhlSJvw?=
 =?us-ascii?Q?RRBA0r9zv5PSSkICbwZEVF5Ab3a6C59QfwlHT363TiUXPIGiKDLvzA89sICZ?=
 =?us-ascii?Q?qzZOfAMeY4fKeoyrKKkJMqThi28Nr87R0krp5m0g4WaYPy9zoXKA+VTi5NOO?=
 =?us-ascii?Q?ookODBKA3US/SanjFMH9ArStsZ++VBIEe+KvoBUP6/IXvrL+zsZyffB7vErY?=
 =?us-ascii?Q?iA+UldeF0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GEX51kFgKi4+sybUWdeG0xXz6RFf8uzLDk0SJnQqKyZ9QcC2iQemFE9hd+JMY7U47c2URftjitykroUjYN9XT4S2rJoNtq18G1KNUJerCvG319CELtia0lZf6DtiRQvDoQfvrXZIeK6etIP8TUaxDErY4riDLenc+ND4jSbiwAtYz7mCj+ev3tPafaegEZzp4R2aZz8NSHUszozI2mSt7ew4g9n9XRT25OhAyHIRZJNZCw+Fhbsidy7cD3E9go+nXy9LATr9UIaFv6BUysSia1UlgG1SwApVzo/oNPhI381PH6eviot1ZOVGDa/nSOcUbscq3jxvYILfYDt5XLYQTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0216fae-a89e-41c6-db7b-08dea523346e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 12:39:35.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrMf+D6JFDRbSLaG5aoX11+C887JtXFkLsFLNok5+1awmnv1daUMcXndzVALNApFcTwVJbYwsDIVB28k+LwbExFKz2qUnMyNRW8h7mL8IOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9DDC8484F9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281840-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

Somehow, I messed up my patch set while sending it.
I have a v2 that includes this fix. I'll wait a couple of days for any
additional review comments, and then I'll send out v2.

-Tushar=20
> -----Original Message-----
> From: bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org>
> Sent: Tuesday, April 28, 2026 3:58 PM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>;
> netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; stfomichev@gmail.com;
> kernelxing@tencent.com; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net; Sarkar,
> Tirthendu <tirthendu.sarkar@intel.com>; Vyavahare, Tushar
> <tushar.vyavahare@intel.com>
> Cc: bpf@vger.kernel.org; ast@kernel.org; andrii@kernel.org;
> daniel@iogearbox.net; martin.lau@kernel.org; eddyz87@gmail.com;
> yonghong.song@linux.dev; clm@meta.com; ihor.solodrai@linux.dev
> Subject: Re: [PATCH 1/5] selftests/xsk: Introduce helpers for setting UME=
M
> properties
>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > index 7950c504ed28..d5cd8f590b25 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > @@ -303,6 +303,22 @@ static void test_spec_reset(struct test_spec *test=
)
> >  	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);  }
> >
> > +static void test_spec_set_unaligned(struct test_spec *test) {
> > +	test_spec_set_unaligned(test);
> > +}
>=20
> Does this function recurse unconditionally?  Looking at the functions thi=
s
> helper replaces, the body should set unaligned_mode =3D true on both ifob=
j_tx-
> >umem and ifobj_rx->umem.  Instead, every call to
> test_spec_set_unaligned() recurses into itself with the same argument unt=
il
> the stack is exhausted.
>=20
> Five tests introduced in this commit call the broken helper:
>=20
>     testapp_send_receive_unaligned()
>     testapp_send_receive_unaligned_mb()
>     testapp_unaligned_inv_desc()
>     testapp_unaligned_inv_desc_4001_frame()
>     testapp_unaligned_inv_desc_mb()
>=20
> Each previously worked by directly setting the unaligned_mode fields.
> After this patch, those direct assignments are replaced with calls to
> test_spec_set_unaligned(), which crashes via stack overflow instead of
> running the test.
>=20
> > +
> > +static void test_spec_set_frame_size(struct test_spec *test, u32
> > +size) {
> > +	test->ifobj_tx->umem->frame_size =3D size;
> > +	test->ifobj_rx->umem->frame_size =3D size; }
> > +
> > +static void test_spec_set_frame_headroom(struct test_spec *test, u32
> > +size) {
> > +	test->ifobj_rx->umem->frame_headroom =3D size; }
> > +
>=20
> [ ... ]
>=20
> > @@ -2025,8 +2041,7 @@ int testapp_stats_fill_empty(struct test_spec
> > *test)
> >
> >  int testapp_send_receive_unaligned(struct test_spec *test)  {
> > -	test->ifobj_tx->umem->unaligned_mode =3D true;
> > -	test->ifobj_rx->umem->unaligned_mode =3D true;
> > +	test_spec_set_unaligned(test);
> >  	/* Let half of the packets straddle a 4K buffer boundary */
> >  	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
> >  		return TEST_FAILURE;
> > @@ -2037,8 +2052,7 @@ int testapp_send_receive_unaligned(struct
> > test_spec *test)  int testapp_send_receive_unaligned_mb(struct
> > test_spec *test)  {
> >  	test->mtu =3D MAX_ETH_JUMBO_SIZE;
> > -	test->ifobj_tx->umem->unaligned_mode =3D true;
> > -	test->ifobj_rx->umem->unaligned_mode =3D true;
> > +	test_spec_set_unaligned(test);
> >  	if (pkt_stream_replace(test, DEFAULT_PKT_CNT,
> MAX_ETH_JUMBO_SIZE))
> >  		return TEST_FAILURE;
> >  	return testapp_validate_traffic(test);
>=20
> [ ... ]
>=20
> > @@ -2380,10 +2391,8 @@ int
> testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
> >  	u64 page_size, umem_size;
> >
> >  	/* Odd frame size so the UMEM doesn't end near a page boundary. */
> > -	test->ifobj_tx->umem->frame_size =3D 4001;
> > -	test->ifobj_rx->umem->frame_size =3D 4001;
> > -	test->ifobj_tx->umem->unaligned_mode =3D true;
> > -	test->ifobj_rx->umem->unaligned_mode =3D true;
> > +	test_spec_set_frame_size(test, 4001);
> > +	test_spec_set_unaligned(test);
> >  	/* This test exists to test descriptors that staddle the end of
> >  	 * the UMEM but not a page.
> >  	 */
>=20
> [ ... ]
>=20
> > @@ -2411,8 +2422,7 @@ int testapp_aligned_inv_desc_mb(struct
> test_spec
> > *test)
> >
> >  int testapp_unaligned_inv_desc_mb(struct test_spec *test)  {
> > -	test->ifobj_tx->umem->unaligned_mode =3D true;
> > -	test->ifobj_rx->umem->unaligned_mode =3D true;
> > +	test_spec_set_unaligned(test);
> >  	return testapp_invalid_desc_mb(test);  }
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-
> patches/vmtest/blob/master/ci/claude/README.md
>=20
> CI run summary: https://github.com/kernel-
> patches/bpf/actions/runs/25045852068

