Return-Path: <netdev+bounces-303176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NF3oAqu/Q2rYgQoAu9opvQ
	(envelope-from <netdev+bounces-303176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:07:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1E6E4A05
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ByzwlBTM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303176-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303176-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E18730A70AF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47B425CD8;
	Tue, 30 Jun 2026 12:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39049423A87
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:56:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824172; cv=fail; b=LnF26TSsSbJ/1frZPi8yMBwZCR8uhHASGOdxQ67tpFNffvt597iiOv02siFHkGPHcuXrIylCsvFgkwrhKInEWHZMNtApglU3eFhdRHSaHYkBsAksUNL+lJBK3BMMEw94uySRHOu4GKK22YQ2GTRBCpHrqBcClxwohidMsBX+fsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824172; c=relaxed/simple;
	bh=sQrOkqaK+HfvD/ZNrEjv3kHuXKWYJY1jTX/XROnbg5c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NC+sAjXeBzf9LPY2AbmhdX42YZNdy8KqeDAFlEIHQLeYMBcJ5L6igdN0zNYRIGrmEFr6qdOu2xOBQArtlYQbsXTx2D/l0iSMJTGiVMnyAuHsH6VVUOiGyhx40WYY+EyL1XxGa93h6BVeJLQI5xNcutWmouGLViPUjSQaxZnwvKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByzwlBTM; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782824171; x=1814360171;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sQrOkqaK+HfvD/ZNrEjv3kHuXKWYJY1jTX/XROnbg5c=;
  b=ByzwlBTM8DT4o1KXdHK8e+Cv/8dAcJ4sngaxj62rAKiJp1/u/lylgxOd
   MuIhBcIXUOqErN71bSbpwt6vYKfD4ak1hP5hcZ5Ccv9WZwHCKbJySe3yu
   bDlbU5WcMdkDhnVNvnUpCsbO4sRc2D4ZgmhG1dtAzVJwvxlVVCcmmhQRo
   AynC+5i2Tbb1mKNLTt2cF9sV7I4+HpnH+Fo8rtzt0+kaM4H7gSu+Zblok
   JRYoepiHEvnkCiz5YII4muvTOVUcHh68ZTUuM7Dr/hELqC4wsMGranrmg
   DqtfIPpHlU5mDfpLxQSp8l8Y0Y1cFu+YkUuJdjn14r3DNqmO+CP+T0cOc
   Q==;
X-CSE-ConnectionGUID: NoJS0njYR12KsK1AYttKfw==
X-CSE-MsgGUID: m+msDsssT3ygB9UYcSedLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="101079512"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="101079512"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:56:11 -0700
X-CSE-ConnectionGUID: Ci4EPcL/Sy+gKr39T1anBA==
X-CSE-MsgGUID: 7UZS+x2xTkKllcM5y0YjMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252395153"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:56:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 05:56:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 05:56:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 05:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owYfuaS01keq5Z76PKipuWs+dDkKtrgJEFWXdiOHXebVlUlnQaUcgZKtn3A696vLoLBZO0f1jhDrd7FtfQn2l2HCZD4SoFHxnRAXUupoooWXudWabWWbBuhBZIBxgrxpfeAdR3IugXhl1FfNp7VQJ43puapRqH5uCHl7At6DN1XCJilhXJPTZDqHalOVp19vOmE8EwnBMwfCcvIEzwmVCIaLE6JVlQszvk8BydOWQtOzwaD1zPaRiJPM2mf9EmRM040tsA8JwMGm8m8r7FKoLodsJGF+GAs1cMSUAUuK+ivsx2UJvvNN4NZPRXLY/t9t4wG6XXgg9Q+D85Ybji5jSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6epwRA6SvUlj2e11QaXtfLMMkcIQKRqDU4yAT/t6Xgc=;
 b=htDPwWX8d/jdDuu1GqbyZFJw2j94jqrb41PsSKF3ShS4AVnn14bdHmgkhA4QM8NKFwyaTXUA5lNoVeBHXucUm8xu/OEFKLNyi0GafqO4wTn399TpryLyLSk1sKYK0GEeu4Im0zWQghTFhqBgjmMHjxt7SBIvvi+L3a1zlHIFw403zvU1BRs9CTPdk3xEnsHq6xvIkEjeBic3vFf+yF4s65h6ubHElRYKfjhL/W4n4iyy6pcxL5b0K/6qC9Md7rSFpOcr52REzK/9FdltW5yaNWDIZi4QmYrihNZLrWSE7BImmBi0gNBUWdYwjvm49eitPBiMKbxNRRrnX5HEMpSLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) by
 MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 12:56:07 +0000
Received: from DS0PR11MB7335.namprd11.prod.outlook.com
 ([fe80::10dc:9cac:bbf5:72c4]) by DS0PR11MB7335.namprd11.prod.outlook.com
 ([fe80::10dc:9cac:bbf5:72c4%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 12:56:07 +0000
Message-ID: <35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
Date: Tue, 30 Jun 2026 14:56:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] intel: low timeout
To: Jakub Kicinski <kuba@kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <leszek.pepiak@intel.com>
References: <20260627095400.3c3d9f80@kernel.org>
Content-Language: pl
From: "Pielech, Adrian" <adrian.pielech@intel.com>
In-Reply-To: <20260627095400.3c3d9f80@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To DS0PR11MB7335.namprd11.prod.outlook.com
 (2603:10b6:8:11e::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7335:EE_|MN2PR11MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e859813-4373-44dd-3007-08ded6a6f342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dRBfUU7azIAHQAbTt8fmRRyXAbk5Qw32pmBIkA35HxF6kZEUsC9ZoEBUA8HYxVPuxwujCb2+iSKrf5RfGd7dXDxPkYeYG6Zaup9MGwxDrWa4bPqfPCkZQcgWbxHg2yBLy1tOs3/8ubvTAFn5s9Fw2f+gG9lX6rieOEAswbyphV6+SsEykRptPc5SR8pp7XCGAxSi0O2lUxF0X9RT0HS8vCfqBjfXeSdfGaW8aQp+2IBv/eWnQchnYwxtJSSvMz5G2jDnmHN529GdOhFzxFhG2oHj2RzcWCqvEQRhFczPnu9uVNqt02IMwKevDs2BEEyvJ7dmVbE64S8JL+JPOR7IDFI6niIe5+bhkWkyeaiqH6/o1JU3nGthrrEXRuYpI0DfjqzFdFCfys6XP7KC25JFiXFB4h306WWqF0jbtTojq5njPzeBo2fBwFqRv/8oYdq9RBK/dE7bxnvocaOxBeIV+AW+6fAm23cp98g8shI23lUPxkriQnmCqIhNwGZjERwiwGa4t0cEeQmo/En0NXQ9neBXHGzpRzSwtXQxf78Xy6+mFsoE8P/xIcfXa2x2P6ioHMYC7UJm3C/TIhlewgLw/wRbThuH31zyYTdhLCpF8vDGNzwSSiIB5UnnrhTuL9hPWaEU7nthCm52MWrvx8wNoyM0Mjj0I3qGNYE34HVq3zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7335.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckx5YTc5b08zd0c0ZW91WDdGSm1oU3FCV05UZkRja0RPSnpaS3EwTDN0aDl5?=
 =?utf-8?B?dDJHWC9qVXFoSWcxQjR4c1RhWkg4eXluMTBxaFVlRE9yU0E4c1FYNmEvOWFZ?=
 =?utf-8?B?VTZUZm1yd3ZmUVpEUWk5eDJaOCs5Tk5Ib1drZVpSOXcraklMMnd5YVk0Lyt2?=
 =?utf-8?B?R29DVDZhbXhMLzZobUZuMm5JWElwWWdlWkM2UEN1VmYwRlArdnUvQzJ0U25p?=
 =?utf-8?B?OFhlQnY2QTFvdGZvcE1jNHREU3F2SysyV1NpTzlFZVFmazBLWDlNcFhLWCts?=
 =?utf-8?B?RUtBYkNnV2J3OU1KNWZWZzVNUEpGYnFYRUJXQlI4cG1wYS9XcGw0MVdzS1VE?=
 =?utf-8?B?SVdyTDhwenFVc0RRVG9Tdk9xWmhXWEpqQ2F2eEExK1NMYk16QnJBS3Z4N1VF?=
 =?utf-8?B?RldQWXNnWU05T3k4aVdhQm03UEU3Z2RHcHZOdDJoaFVYWmhTVUdFTDZ1aWpo?=
 =?utf-8?B?L0UrM1BMSHc1R29lWXgyWXFUK0pneWhOcDhjNFk0RndSUGVmYTBkL3JESDZX?=
 =?utf-8?B?NFgwWnp0UzRpbnJuN05OaEc0bCtBS0JJVW9kYXkwWkpyVzZmWmNjY3V1VTZz?=
 =?utf-8?B?T3JDZ1hBMFFoM3NpN1NWbFREL0NYNW9EVzRobDlkdUJ4YUhDdHcvRHBhanpq?=
 =?utf-8?B?ZGRNczVaT2VHRjJCTFlSb2Z5d1VPQ05wdzFsQVhJV1hyVXdyMGVTWmM2M1hz?=
 =?utf-8?B?c3RFMTR2TkxEYVpaY1p6U3A3ems4ck4wek1FZ0FSQWpTUUJiRmxWNVM2aVV5?=
 =?utf-8?B?ZmE5MFd5aUhrK0dUK004UlFtWkZ5MGVCem1kWk4rR1MwMUZpWWc2cmJTc0Zj?=
 =?utf-8?B?Skh6YnBLS2tTQitXUmR6eWpvUS9FbFhNQ3V0UEk5WDJRVHhBWEpPR1hiU0Qw?=
 =?utf-8?B?R2VkMXl3eXBjSTU4UGhJWnNGeWNPYlhYa0xLcU1aQWY1NG9jd3JZWFAxa25E?=
 =?utf-8?B?bVJDc2NxcURXZnZBQ2tDZXVkV0ZqQlBRVFFGR3hrMGNxbUFqNWlsMC92UDZK?=
 =?utf-8?B?T01VZUs1TkxRNGF3TWVWcUtiRFYvSjFPMUovRktEZkllNkM4S0hLSENIWVZB?=
 =?utf-8?B?RldZdHRhUTlqY3cwNnpQQnR0RnRpVEI2UWJOMGhHQzZodkpNcTdiYk03a3RL?=
 =?utf-8?B?VTJPdHg1dmVEQk12TUVTdFJ2MmMwM2NWV2JFNkN1dlNkOWROYXJOem5Tb01k?=
 =?utf-8?B?djliS0NaakpqVXgwK09qd08wWm00ZnVDMlZUeElyQkpjczMzREZUMnloOGFy?=
 =?utf-8?B?aC8rNVpreDV0SDFieWZoR2tJUWk5NHJuYTJZaVhxN1IxbHdYTTEzdEhCcEx3?=
 =?utf-8?B?c1hOYk1McmxtL3l2ZTZveGYvSlFUazdVQmxIc1RKU0pBYTNDWU9aNmljSXh2?=
 =?utf-8?B?U0E5anQ3TjE1b205bmdRc3ZnSmd3eW5EZ3VVOVU1UDJrbXlDQmRVckNIdHdH?=
 =?utf-8?B?WFl0ZGNFTnQ0RjdYdDNTcC85Um5nOUZFRE55WmVMa3ZrWlRMVlNvZnBzU05C?=
 =?utf-8?B?WTNkV3hFVlRGRm5sTGJJOTNQVXN6WE9HcmdYWk9lVEp0VWxiS1hPTG0yd29p?=
 =?utf-8?B?emlsUXZrTU9CK3h5eFJTY0VyUXFnUTh3c2ZsVGJBMHhSZVhGM2NFRDRLeHhL?=
 =?utf-8?B?RDViMDl6R09PQUtrYzcxcUQ0UGlBNnJ0VExUR25XUVY0NUx0bGJESXZ2a3hM?=
 =?utf-8?B?WWk5UGNuR2JaOUNKUEZDRkVYMTFhZEhLeGZtbzdSS0o3Zkp6a3U2Nk81V0Uz?=
 =?utf-8?B?RzB4VWV1eXV0TnRQR3M3RU1XT2lqbGJyd3VjWFBGbDJHVTNUcE5laVgvUVAz?=
 =?utf-8?B?U0U5MGdTdDdYbzJORlJBQjBkVGR0SnBXVDQvUTlOZzdDZ3JwenlmVitvVk5F?=
 =?utf-8?B?L0Z1ODFhekJHY3BJVWJUZHRQaW8yV05VcHdSZ1BJeTMzMlVhSWxJUFh0SmJ0?=
 =?utf-8?B?cjBYeDBGOGVjU2NyNVpMbElpR29IQmhpTDFkTDBNM2Y0Y2dkQXdaWHBoUFk2?=
 =?utf-8?B?WXNDWllrRjA4LzdOa2I1bERkNHNSS012NnM5UFVUZjRUdGx1NVZwZEtVMjRX?=
 =?utf-8?B?S1FicFVGa0xTR2N4VmMzMVZ4TzJlV2M3QlhVSmNha2lZVmhPS0k0MWM5Wk9Q?=
 =?utf-8?B?SFo3UHd0cDlmTHJub0E5Q2RtTFZLbDhjRUxMUjRrUmJCb1RHc2VRTTgxMlZa?=
 =?utf-8?B?ZDJMTXZSRVBidXNyYzBaNGpKeXlNSThOd3N1dUZOS2U1L0VrR2psSjFWN2ZS?=
 =?utf-8?B?VWw1c1FSb1VwVXNQNGh2MDh1U25hZFRBWUdhVWpvdUJxeS9oUEhsN1NoN1hP?=
 =?utf-8?B?S3FITS9kdkJpTTUwSjJWTTIvZDZQbENTWnpaQUhnMG5IY2JFMFZFZz09?=
X-Exchange-RoutingPolicyChecked: UnOOD/1wnFXXjgyKGChgM/2JA4rKSXf+bdq36W0uHtdA3k2f1GXoqogv9kSLPML0AwR0t0Iomut0iFNILyQNnJQe8/U88AhduLgTSsQxRoAJeioQnE0iIp7FnLuUb+d1EgS2H7bv3a/fa/fHFJ7DlRv0uFAI8GZdxkasmNxtu5LB8m4mhOWAEocNatmZrAhiume0nVxLgTmDq4D6i0vprwfvxf04KDzM937ORfaPSrdKG5U6BHJhjSD+v/FTWZ7jsWCFsuRqSfxN4bRvruBjmDf6EDc/iRi5kak/PWAfsk5uibaJwmSeoP1UbTiXE0fBaDsavsei89v7mdCy58vhTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e859813-4373-44dd-3007-08ded6a6f342
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:56:07.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4Ew4/80vV6NUyoNihuoYrAEFOHSVSI56JjVazz6zurmIzMJB0l0hWsp0/l82wCw9vGwJ6SNQloWwenXtGYeaoNB6e+vMzgyxdbUsHpPkH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-303176-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:leszek.pepiak@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[adrian.pielech@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:url,intel.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.pielech@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A1E6E4A05

On 6/27/2026 6:54 PM, Jakub Kicinski wrote:
> Hi!
> 
> Some of the tests need more than 5min, could you increase the timeout
> in the runner to 10 or 15min? Looks like it's hard-killing tests right
> now after 2min:
> 
> https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout
> 
> which leaks config across tests:
> 
> https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout
> 
> BTW the JSON reports the timed out tests as pass.

Hi Jakub,

I've increased timeout to 10 minutes per test run. It seems to help with 
XDP tests score.
I'll later take a look on default behavior of runner in case of timeouts.

