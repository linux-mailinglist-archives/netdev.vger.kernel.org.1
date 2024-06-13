Return-Path: <netdev+bounces-103289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B79590763D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD7D1C235C4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB49149C42;
	Thu, 13 Jun 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwW84bLz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091214A0B7;
	Thu, 13 Jun 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291534; cv=fail; b=pE8jVYd0QokpDSa8nIIqT0Y9KUiHWqDdQfjHpOw6KCRSHE6RWjIMEWy06Je1PoRPqNxXzU+zbhN4V3P6oNaHpOWidhx4pawZvguCL04aY5pRW3J4HQ6lEv3RB5TMve5av21Is7F+XP3rO9uCuocL6ihzXSOY7nUUmGgFgYVcJxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291534; c=relaxed/simple;
	bh=yKAIJCICGElp6wQI0QOFKpMKgsQe5pElP6Odgjig5/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPwfiNSZa0nPy+Aln67ozj1f0MP2tOsWbkzeJyiiMQDAqWlG8IVHT+8iHGEwFwcFSr5OqDC28VEQnTTds2NzJvtcBs8eHs7n8Lti3RXrw6+mBsV3Y0Ovnrs3NrFkNlkfVWBIHOYivp7xPRvPVeJmiwEK2iFwC5HPYXJgaU3CDvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwW84bLz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718291532; x=1749827532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yKAIJCICGElp6wQI0QOFKpMKgsQe5pElP6Odgjig5/E=;
  b=KwW84bLzAAjW6GxIHxDfmDPwHEf1OhdofYimcL7cnbHpv7qIR7evEmEq
   Xh+ar0tP8U5Frzck4ghFS+w0+0z08v0Brda5wQsQ/1c0TbtpwZDUs16CB
   xLmxWVE4AJbDUYrdU8ALViUUeBmMVkd5mvBTs5ucRkYyAJzxYEKylX4nG
   mzhDfu6XH4uOQ1GnsxOVMsI/hJY/2xh9QmiDsZjHEeOut0v4l9GTCyj5h
   HvzcK4su8IFonSs58LZ/FmKvbCtGGOYfBm6CE9AmowFv1QVx/nMlpiPgI
   r9bXtjgL3amZ/olBaKaheYZ7awSVjkYAljCiEdNFIrbBRS2D2kkq/gqdv
   g==;
X-CSE-ConnectionGUID: t7g/tGBDS5eQUUHgX76Djw==
X-CSE-MsgGUID: YO1MWzSeRzyL1zab8rYTEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="26241705"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="26241705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 08:12:08 -0700
X-CSE-ConnectionGUID: C7KzX386TPO6ehkBrfeF0w==
X-CSE-MsgGUID: 9UotDfYURpSVfIvOMAZ/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="44701072"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 08:12:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 08:12:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 08:12:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 08:12:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 08:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+SOFyWI4erSGMeaT13KHXY82xcwhnoWTEGqBRcKiL+7qnEhwQI1ctkhNbROiejnwZmvHx/kfC0t9uAdPXHprdwN1gBn6j4kC2+aBr3kJMifjfMklXBquUTxytUjoOBrI04bKPRHWQ2vMWNVg1FK2W/dN98fjNx4x4bZaPr9K3OA+ELlm1KDq3tHxFhLzjKBV0exgzWVChkBwim5rO/Oo0wRn4CC//tRDUKSJIc2xb0enf2FO17md9DO635RDMgf925pGL6sNHXi+tNpF/lFaF2iHasSFgyW9IyMbYHtRUwVuWd+KtWwoDUO/7fZ8vo/CivOooqZjBbP5kLNCSFnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksNyxXp8DU9VWwIoO83jlzrZi8JdS73rcIPJUN3soaE=;
 b=hGSOOqW4NLulL77qk2+D43Ht+NJogbQETvbeWt1f8naJuQ8FQsI1b6C5t06nn7KgzPuP4tXjtmn7+WsB5VeYivgR3ErvVVcXTEw6Ge3L59lemE+zDxCZPekwW6lBLqpvGA5+tdPMiVbzVTt9pAmOSQmiyWIRyUOLpn3cM9j5unr49ggAzn08Wto/GoFX9cbQ+krnIAHW2/n/7tumhBBUU7DG6VffAOvxfkiFCofJoIrmRaINiUPdALg95jH72/8hCT7BIlSOpBlOlgJa3eFpG+jJ/0U+eYzWHhLYDFxSWkIvsbddtADx0t2Tvn0g6OWhXv4TFYwAQvgAT5SqY3WoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 15:11:56 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 15:11:56 +0000
Message-ID: <f488810c-9e5f-4561-b708-ab79e9ac3117@intel.com>
Date: Thu, 13 Jun 2024 17:11:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: hsr: Send supervisory frames to HSR
 network with ProxyNodeTable data
To: Lukasz Majewski <lukma@denx.de>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Oleksij Rempel
	<o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>, Nikita Zhandarovich
	<n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, "Arvid
 Brodin" <Arvid.Brodin@xdin.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>, Casper Andersson
	<casper.casan@gmail.com>, <linux-kernel@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, Shuah Khan
	<shuah@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>
References: <20240610133914.280181-1-lukma@denx.de>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240610133914.280181-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 036ae732-5e42-4d6a-823a-08dc8bbb2a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2ZlaVV1TTYwMDQzVmx2UTh6QWxkdi9kbHowS0FldlY5dk0vRWVZeXpUNW1u?=
 =?utf-8?B?aVUzellsUDhKcktCdThwdFphanVMd0NnT09qZU9yWUIvdmtUaWFyeW5OMk8v?=
 =?utf-8?B?QjluazIzY3h6K3h4QXVUYlRpQmZrRTdVM0dEYk05eHFscjJuQ29oRy9vdVBS?=
 =?utf-8?B?TDg4TkZOdlBKZy9ZZHIzcEhWOE1ZRERtVUE5KzB6Z0xLeFlVQjIzRTEwQUd2?=
 =?utf-8?B?dlNSbW9CRHk4UHU2bTBSK2ZuRHY0Zyt5MzhxaVV6T3B2RnRZRlZmNEVkQnNO?=
 =?utf-8?B?a1lMUGtNVlVsK0NKZmxJbGYzdkdKOEt3NXRsL1NMS2cyYzA0TWdvSGkwZEtH?=
 =?utf-8?B?YTRLZnk0K05zYUdkTFp2WUEzc2R6VEgvcW5rb0ZsZjJlcUdUTDkybzJUYUxy?=
 =?utf-8?B?cFlQaW5sV0hZSExMRmp2UHVLN0V5dnlOTVZUNGRkbzN1Y1dVd2Nza0NHT1k5?=
 =?utf-8?B?K0xyeFc1REpkZnBab0grbTJpQnJqTnA0VFh1OStDOFlYeVNrRUh0R21UVUpn?=
 =?utf-8?B?ejF2Yk1KT1VtVEI5SmMvR0UxUTZZMy8wRmtqSnJPVVIzbDNRN2NCWE50aWhi?=
 =?utf-8?B?TkZXVTNOR0srSEc5WkE1SFFncDdRT3NHRXVqVjJCWjhsQThXazZLNENVK3l3?=
 =?utf-8?B?QjNKZ0lqOVJ1QlgwSURUQXhDdGg0ZDFiSVZacDF0NTRJYS92emQzc2MrTEtT?=
 =?utf-8?B?dEZsRk9OYVhyS2dnOUx3L0dIYjZxSzNKblZUYm9vOVhGR1JIdkRNQnVLU0Rq?=
 =?utf-8?B?NjFVZkRVLzF0N2FsNGpHYTVYS3dQOEt0MWoxdm9BWVNVVk1zQUx0SG1vL2NI?=
 =?utf-8?B?UDdxWFV5eEd4K0tvWTZEbjhjRjFTK3BYTUtIZ0dHeTdzWW9OcjFDUnlKNG1I?=
 =?utf-8?B?QzhjTktrVzZvRFU5YWlsUmFqbVdxRjRZWC9lSVNyU1NXeE04LzNDanJOck5D?=
 =?utf-8?B?aFlobHZueUszZTQvZWhWOUs4MVFoZDNtY3NIQXArRGt1L1NEVFp1ZndOYkRK?=
 =?utf-8?B?UVNraTJqZzEwUGl1dVNubkJWL21WVWNkNmJyZGQzTzc5cHNpeDFCaDFoVldD?=
 =?utf-8?B?UnJmTlE0ajY2MU5tb2I1aFNGZXhJdFF4KzZZM2hiTEI5d0VmR2Z6K2FOMk9Y?=
 =?utf-8?B?VjFsR0lyZ081MWlNRTdKazNYcVNkbUhoOEJnTkxKNmcwOG5BVXFiaVhySENu?=
 =?utf-8?B?Q3A5Q0RHVzQ2TGp0L0VlVUc0aXkvVGVHeDcyamxOTStLa2gxS0ZCdEhQNGpJ?=
 =?utf-8?B?cHpwaFFxZ2dHQTVzdFFEcS84dXVsMmFIVkZwRU9QYWhGMHVFbnpRRnJndTBN?=
 =?utf-8?B?bkprZWVTQWFCSkcrOW5oUEZENWhxaWJ3MERWMzBXQnpJOGpiNUc0Y3Q1TTV4?=
 =?utf-8?B?YlRDQXZEWGswZ2pQbDRha0drK3hoZWFrUUFRcDcrREdCbDdURUFaZGJKeXZj?=
 =?utf-8?B?L1Y1aTBEb0hyUnNUdHpNU1QxY0RISWVuaHZrQzM1MjE1Y2tRQUplMVArU1lw?=
 =?utf-8?B?SUFJMW5xelc3eXBGTnNZRjB3RkgyWXlrdVVMVlN3VHRkYkc0N0pWWjFNWmVW?=
 =?utf-8?B?aktiYkRVdVcwRGR4UWpuVzRkbEVtVXFlVjVvZ2FJNlQ4Q1RqbWdOZVRhWlpw?=
 =?utf-8?B?Wm90aUNvRzVZb1A1R1pGRSttSTcvdlNwYlI1M2JwbktsaGlEZE9RcUNGMi9T?=
 =?utf-8?B?R1crMTlGU2NZZEI0czQ3QXg3QktERXBJY2ZvdTBjY0FuMjBHVi81QUVreG1v?=
 =?utf-8?Q?Tbts0hVuFVIlPSdPJTEsy8Mz1Xh+F5SF5sE6Tld?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVUUzEwTGI5dmEwb1lQVGprUVh5cnVMVnJXMUZkV3k3Z1NRQUUzT3kvNTRD?=
 =?utf-8?B?UTR6dHVBcGRKKzVjUjJDamFoQTA0bUxWeTFTdFNvYUc4VnZ4bVluVXpmYUJP?=
 =?utf-8?B?cjEzSTZ4a00zZ0dqQ2V2Y093b2ErTllnYXpzell3a0RqWXNsdHNxdTU3eW1S?=
 =?utf-8?B?K1lPYkNlQU9jSS9oSklTZ1I0SG9XOG5zeGZIZ2RyczFCcDJWV0tyTGNHcWNi?=
 =?utf-8?B?OEtNalJOY2taamRnSkM4ZUVGaU5tb2xTQXRyQ2RVTkVSTzcrTWpYb0hLOG9y?=
 =?utf-8?B?NVJ6OW91cW9YMXNyOExJTmk3d21Sb0swNDVjeXc1akZ5LzdaV01wUTQ5MFFP?=
 =?utf-8?B?d2FTQk5KZU1HVTJjYjRDRG5DNCtBeTZlNldWNEkydHZERG1PR3A2bW0yKzhj?=
 =?utf-8?B?WFdDdGM1S0xDUWJpeUtWdTMreE9Jakh3QlE1TSsxaXFwajEvUVZDNldLVmZa?=
 =?utf-8?B?QTlhUXdHTnJBaUFNaXR5SjV1U1FsT3c4K1h1Q012VThqaHpSMjBWMThXRFlP?=
 =?utf-8?B?MUMxcGo1dkt5T25qaEhzU1M0NG5TQk1kM1EvL244ejdDOWFZY0ljdmh3UDlj?=
 =?utf-8?B?LzNmSWUzMGlkQVlsYVlEeHlzUnVUK3R0Q1BqSUpVb3A5OEdjMlg5dTFoZGZ6?=
 =?utf-8?B?T1J5UTU4SGpwbjlkVTdRNHFOZ1JqK2NvWVhBdU9EcGZlSVNZekhUWlg5SWh6?=
 =?utf-8?B?a3NGZ1pLOUN4U01raW1nZGdEL2Zqa0pTaWVVUlNkeDBjdG1ROFBJWkVaR25H?=
 =?utf-8?B?OTJsU09JWm4zQW9NWUpSQVFTUC9vWjMxbjVtdVRMWFNUUGVENU41Sk1WUjdR?=
 =?utf-8?B?aHdkcllCQ1NZNkhsMlQwU21mYmRRUEx5Qy9JU0lpenJnNkFzMVJXTUI4bGRW?=
 =?utf-8?B?Q3VmbEszU1g1Zi9DMlB3OU9qcjVOckgycE1BTklWdi9vMEkrYTArUk9HZ0g3?=
 =?utf-8?B?YnkrMjlKeHlnTnlDbDUvUzFZdFhkd3l4NHNMQXNLbVhqK3d2QzhNT1VkeE5P?=
 =?utf-8?B?ejhOWnJta0lKYUFGU2d6dUxZZTNEVHRzUTd6d3dIK2pPcE0vSjJTTkUzSWlO?=
 =?utf-8?B?RFpNa21kbjdVeTR5S2ppVXFTQWljRUthaE5IUmN1RjhWU0lCbWpWWEVoMzNj?=
 =?utf-8?B?Qnk1MVhaSENEWFZSTjJJdVMwRlNRL2ZCSE1XRkVPL1VMTzJFaFNKR3VzNXY2?=
 =?utf-8?B?QWxYakVRTExXZXloazZJZzB4bVdWQm90T3ZHZlMrZExSd2RMUUlSMXk3K21r?=
 =?utf-8?B?NzU2Ky9SclA3a2FPL2poOUFVR0huNW4xQkh5aGptN1RBT2dEUnlITW9yTkE2?=
 =?utf-8?B?aTd6WU5pUWV1bCtVbDBPV1RGeE5VZ09kWHd2b2ZRcStQclUrRmh6MUpaT29U?=
 =?utf-8?B?U0FNTXZySlRUNlR2ZEJna3pvY2R4QWlCVndlOE1iZGk1Y3pZYnh3c0JlZGFF?=
 =?utf-8?B?R1RBSUExV3ppdVpLY2R4bUtjY0o4aXJtRGJ6Qmo5RWR2OXBHOXc1M1RpMFcz?=
 =?utf-8?B?aXg0cTB6MjBYY3daa2s1M1I2c0JWbVkxVVFpRE1kUHhKTS83b01RbUlxS2M1?=
 =?utf-8?B?VUVnekNFZ1lldXcwK3RXZmJtZ0ZicUlBNGY5U3hlRUJRZ24zVDdCUkhxaENp?=
 =?utf-8?B?RzhWblhYMTBRRzdmbXppdU9tOE1SRjdGbFlHeFBXanVtRE9QL09tazdTOEN5?=
 =?utf-8?B?ZkVZSHB5L3V5c2hzM3g0TW9wV2VFeGtOL292ek5zRjI5WTRIZmh4NUVwdXVE?=
 =?utf-8?B?ek1CaHlubTU2NVVxOTJDZlRaL1dJOVVlcTFWSXFRUnlRYmFwSnVLZHdqQUFQ?=
 =?utf-8?B?SWlOSWpDOE9JS0h6S0NiSzlYT1kwT0Z6ZE51cEcrMy9UYldQT3JnRVZDU2Nt?=
 =?utf-8?B?SWN6QVkrK0pLK0VCSm9uTkpQeHdoSHNmQXU1L20rYW02dE4wellWMUg1VDIy?=
 =?utf-8?B?bEpRTFVBck9TS1p2N3hBMVNhdk5YU0g3NWY1dUxjS3JFV1RBVmNUaG1jayt3?=
 =?utf-8?B?V3Q5L2Y3UU9ldWtYWHU4K0dNSFZMRFR6SUNPeXVHbEF6OHpwODdrY3VWOFFL?=
 =?utf-8?B?ZWQ1ZjNJZmVWMmw4OE5hSlFtSlNpTm01R2o4MlZFM05qMU5BeDU2dUNKUU5i?=
 =?utf-8?Q?sAVAqBwfjzjFnoTxLYe6mDqJb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 036ae732-5e42-4d6a-823a-08dc8bbb2a21
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:11:56.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIhQWIiNzV2hADdiN13fzxN8zP+TNS4P3EXb9rXeS3CNQJq9rVRPXhw4nyxbG1jPokAxja8Qm6aqpWy+cmxOLvdX4asK0lt4HMAXcyd4phQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com



On 10.06.2024 15:39, Lukasz Majewski wrote:
> This patch provides support for sending supervision HSR frames with
> MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
> enabled.
> 
> Supervision frames with RedBox MAC address (appended as second TLV)
> are only send for ProxyNodeTable nodes.
> 
> This patch series shall be tested with hsr_redbox.sh script.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

You forgot to include my tag:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> Changes for v2:
> - Fix the Reverse Christmas Tree formatting
> - Return directly values from hsr_is_node_in_db() and ether_addr_equal()
> - Change the internal variable check
> 
> Changes for v3:
> - Change 'const unsigned char addr[ETH_ALEN]' to
>   'const unsigned char *addr' in send_hsr/prp_supervision_frame() functions
> 
> - Add sizeof(struct hsr_sup_payload) to pskb_may_pull to assure that the
>   payload is present.
> ---
>  net/hsr/hsr_device.c   | 63 ++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_forward.c  | 37 +++++++++++++++++++++++--
>  net/hsr/hsr_framereg.c | 12 ++++++++
>  net/hsr/hsr_framereg.h |  2 ++
>  net/hsr/hsr_main.h     |  4 ++-
>  net/hsr/hsr_netlink.c  |  1 +
>  6 files changed, 105 insertions(+), 14 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index e6904288d40d..e4cc6b78dcfc 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -73,9 +73,15 @@ static void hsr_check_announce(struct net_device *hsr_dev)
>  			mod_timer(&hsr->announce_timer, jiffies +
>  				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
>  		}
> +
> +		if (hsr->redbox && !timer_pending(&hsr->announce_proxy_timer))
> +			mod_timer(&hsr->announce_proxy_timer, jiffies +
> +				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL) / 2);
>  	} else {
>  		/* Deactivate the announce timer  */
>  		timer_delete(&hsr->announce_timer);
> +		if (hsr->redbox)
> +			timer_delete(&hsr->announce_proxy_timer);
>  	}
>  }
>  
> @@ -279,10 +285,11 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master)
>  	return NULL;
>  }
>  
> -static void send_hsr_supervision_frame(struct hsr_port *master,
> -				       unsigned long *interval)
> +static void send_hsr_supervision_frame(struct hsr_port *port,
> +				       unsigned long *interval,
> +				       const unsigned char *addr)
>  {
> -	struct hsr_priv *hsr = master->hsr;
> +	struct hsr_priv *hsr = port->hsr;
>  	__u8 type = HSR_TLV_LIFE_CHECK;
>  	struct hsr_sup_payload *hsr_sp;
>  	struct hsr_sup_tlv *hsr_stlv;
> @@ -296,9 +303,9 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  		hsr->announce_count++;
>  	}
>  
> -	skb = hsr_init_skb(master);
> +	skb = hsr_init_skb(port);
>  	if (!skb) {
> -		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
> +		netdev_warn_once(port->dev, "HSR: Could not send supervision frame\n");
>  		return;
>  	}
>  
> @@ -321,11 +328,12 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  	hsr_stag->tlv.HSR_TLV_length = hsr->prot_version ?
>  				sizeof(struct hsr_sup_payload) : 12;
>  
> -	/* Payload: MacAddressA */
> +	/* Payload: MacAddressA / SAN MAC from ProxyNodeTable */
>  	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
> -	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
> +	ether_addr_copy(hsr_sp->macaddress_A, addr);
>  
> -	if (hsr->redbox) {
> +	if (hsr->redbox &&
> +	    hsr_is_node_in_db(&hsr->proxy_node_db, addr)) {
>  		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
>  		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
>  		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
> @@ -340,13 +348,14 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
>  		return;
>  	}
>  
> -	hsr_forward_skb(skb, master);
> +	hsr_forward_skb(skb, port);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
>  }
>  
>  static void send_prp_supervision_frame(struct hsr_port *master,
> -				       unsigned long *interval)
> +				       unsigned long *interval,
> +				       const unsigned char *addr)
>  {
>  	struct hsr_priv *hsr = master->hsr;
>  	struct hsr_sup_payload *hsr_sp;
> @@ -396,7 +405,7 @@ static void hsr_announce(struct timer_list *t)
>  
>  	rcu_read_lock();
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	hsr->proto_ops->send_sv_frame(master, &interval);
> +	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
>  
>  	if (is_admin_up(master->dev))
>  		mod_timer(&hsr->announce_timer, jiffies + interval);
> @@ -404,6 +413,37 @@ static void hsr_announce(struct timer_list *t)
>  	rcu_read_unlock();
>  }
>  
> +/* Announce (supervision frame) timer function for RedBox
> + */
> +static void hsr_proxy_announce(struct timer_list *t)
> +{
> +	struct hsr_priv *hsr = from_timer(hsr, t, announce_proxy_timer);
> +	struct hsr_port *interlink;
> +	unsigned long interval = 0;
> +	struct hsr_node *node;
> +
> +	rcu_read_lock();
> +	/* RedBOX sends supervisory frames to HSR network with MAC addresses
> +	 * of SAN nodes stored in ProxyNodeTable.
> +	 */
> +	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
> +	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
> +		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
> +			continue;
> +		hsr->proto_ops->send_sv_frame(interlink, &interval,
> +					      node->macaddress_A);
> +	}
> +
> +	if (is_admin_up(interlink->dev)) {
> +		if (!interval)
> +			interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
> +
> +		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  void hsr_del_ports(struct hsr_priv *hsr)
>  {
>  	struct hsr_port *port;
> @@ -590,6 +630,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	timer_setup(&hsr->announce_timer, hsr_announce, 0);
>  	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
>  	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> +	timer_setup(&hsr->announce_proxy_timer, hsr_proxy_announce, 0);
>  
>  	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
>  	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 05a61b8286ec..960ef386bc3a 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -117,6 +117,35 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  	return true;
>  }
>  
> +static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
> +				       struct sk_buff *skb)
> +{
> +	struct hsr_sup_payload *payload;
> +	struct ethhdr *eth_hdr;
> +	u16 total_length = 0;
> +
> +	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
> +
> +	/* Get the HSR protocol revision. */
> +	if (eth_hdr->h_proto == htons(ETH_P_HSR))
> +		total_length = sizeof(struct hsrv1_ethhdr_sp);
> +	else
> +		total_length = sizeof(struct hsrv0_ethhdr_sp);
> +
> +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_payload)))
> +		return false;
> +
> +	skb_pull(skb, total_length);
> +	payload = (struct hsr_sup_payload *)skb->data;
> +	skb_push(skb, total_length);
> +
> +	/* For RedBox (HSR-SAN) check if we have received the supervision
> +	 * frame with MAC addresses from own ProxyNodeTable.
> +	 */
> +	return hsr_is_node_in_db(&hsr->proxy_node_db,
> +				 payload->macaddress_A);
> +}
> +
>  static struct sk_buff *create_stripped_skb_hsr(struct sk_buff *skb_in,
>  					       struct hsr_frame_info *frame)
>  {
> @@ -499,7 +528,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  					   frame->sequence_nr))
>  			continue;
>  
> -		if (frame->is_supervision && port->type == HSR_PT_MASTER) {
> +		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
> +		    !frame->is_proxy_supervision) {
>  			hsr_handle_sup_frame(frame);
>  			continue;
>  		}
> @@ -637,6 +667,9 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  
>  	memset(frame, 0, sizeof(*frame));
>  	frame->is_supervision = is_supervision_frame(port->hsr, skb);
> +	if (frame->is_supervision && hsr->redbox)
> +		frame->is_proxy_supervision =
> +			is_proxy_supervision_frame(port->hsr, skb);
>  
>  	n_db = &hsr->node_db;
>  	if (port->type == HSR_PT_INTERLINK)
> @@ -688,7 +721,7 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	/* Gets called for ingress frames as well as egress from master port.
>  	 * So check and increment stats for master port only here.
>  	 */
> -	if (port->type == HSR_PT_MASTER) {
> +	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
>  		port->dev->stats.tx_packets++;
>  		port->dev->stats.tx_bytes += skb->len;
>  	}
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 614df9649794..73bc6f659812 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -36,6 +36,14 @@ static bool seq_nr_after(u16 a, u16 b)
>  #define seq_nr_before(a, b)		seq_nr_after((b), (a))
>  #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
>  
> +bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
> +{
> +	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
> +		return false;
> +
> +	return ether_addr_equal(addr, hsr->macaddress_redbox);
> +}
> +
>  bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
>  {
>  	struct hsr_self_node *sn;
> @@ -591,6 +599,10 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
>  
>  	spin_lock_bh(&hsr->list_lock);
>  	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
> +		/* Don't prune RedBox node. */
> +		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
> +			continue;
> +
>  		timestamp = node->time_in[HSR_PT_INTERLINK];
>  
>  		/* Prune old entries */
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index 7619e31c1d2d..993fa950d814 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -22,6 +22,7 @@ struct hsr_frame_info {
>  	struct hsr_node *node_src;
>  	u16 sequence_nr;
>  	bool is_supervision;
> +	bool is_proxy_supervision;
>  	bool is_vlan;
>  	bool is_local_dest;
>  	bool is_local_exclusive;
> @@ -35,6 +36,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
>  			      enum hsr_port_type rx_port);
>  void hsr_handle_sup_frame(struct hsr_frame_info *frame);
>  bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
> +bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
>  
>  void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb);
>  void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 23850b16d1ea..ab1f8d35d9dc 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -170,7 +170,8 @@ struct hsr_node;
>  
>  struct hsr_proto_ops {
>  	/* format and send supervision frame */
> -	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval);
> +	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval,
> +			      const unsigned char addr[ETH_ALEN]);
>  	void (*handle_san_frame)(bool san, enum hsr_port_type port,
>  				 struct hsr_node *node);
>  	bool (*drop_frame)(struct hsr_frame_info *frame, struct hsr_port *port);
> @@ -197,6 +198,7 @@ struct hsr_priv {
>  	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
>  	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
>  	struct timer_list	announce_timer;	/* Supervision frame dispatch */
> +	struct timer_list	announce_proxy_timer;
>  	struct timer_list	prune_timer;
>  	struct timer_list	prune_proxy_timer;
>  	int announce_count;
> diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
> index 898f18c6da53..f6ff0b61e08a 100644
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -131,6 +131,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
>  	del_timer_sync(&hsr->prune_timer);
>  	del_timer_sync(&hsr->prune_proxy_timer);
>  	del_timer_sync(&hsr->announce_timer);
> +	timer_delete_sync(&hsr->announce_proxy_timer);
>  
>  	hsr_debugfs_term(hsr);
>  	hsr_del_ports(hsr);

