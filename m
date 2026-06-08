Return-Path: <netdev+bounces-296742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sE9rDcc8J2pZtwIAu9opvQ
	(envelope-from <netdev+bounces-296742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5365ADF7
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ntLldsYj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296742-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296742-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F363040D89
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C6E39E9B0;
	Mon,  8 Jun 2026 22:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3883B0ACE
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:01:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956073; cv=fail; b=T4CkYfLVFv1YbuuHiKTZqSwCtN28gizYImDcKVnRiKsYj3G+6QvnhVxYNVbjK+4sa/0J/GLbSM5yLJ8PGwlU0s9AV725Iv/Rv0ywFLwA/5c/nMQRby/9j0bMqsTRxq9ddM1jw118tjtdw+j+T025RMrvpKubESRYmsUYPUA/1pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956073; c=relaxed/simple;
	bh=U/X5M8JuVojPbr/peuVOG6YMk5BXAxoHB1vJ3NDL1mw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cx06mvkT4NKjIPn3eJvCcEO+pRLY5IcseqhrpnJD8mxIBWUsomaKXLQ9b0zFqQMFFjATwmV3bLss/h3O+SjkR/smSoM6v2FD2WBZnPQKYZ4zfQ0Vjmxr5sAog/zqBJUoX2IusO35x+PKsh+efEJWpf+GBzOXp611/pv29wKITws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntLldsYj; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780956072; x=1812492072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U/X5M8JuVojPbr/peuVOG6YMk5BXAxoHB1vJ3NDL1mw=;
  b=ntLldsYjpKnOgQSDdWbWG/6GJNwnKtFzwqAK9gPXCp76MtT10jTt1mZM
   U0hpF7K5+sxJPG4RbSEk0hog6+W8x76i0kieG7kIWuQ1tEdxS04TXpeRe
   ZF+AlWPHXGuOEovo5GqMhCEpdkh+hvcZ1ePL1QbUwylwh+Xo+D2rJFPsy
   S5ClUwMhbsmCfK5RDpy9kuNjEZRMUf81s4imQhR19Y3D/eGpcmGrTr+a8
   Ew6BVM0wEPNkzt26+qirdsCgufRyFTUmJhXtfevIlX5Wop/8WS8z2b8vb
   v5bx4HvCBFuzlLSyIeECKzp/QGpIR1BKM1ZNE1xphEbJyEtUVew3zDyZt
   w==;
X-CSE-ConnectionGUID: jTn7AU4kRG2IqWuEFhj8qw==
X-CSE-MsgGUID: xyJ1dl2yTSGWwVFH4sFxfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="69238899"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="69238899"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:01:11 -0700
X-CSE-ConnectionGUID: UouBqXm3Q0GpoTDrdBd+UQ==
X-CSE-MsgGUID: sxTGzy48Rwue+aYxSuaIuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244540606"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:01:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:01:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 15:01:09 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksmh54pG/L/q/zkw60+UE0JtniziOjdQGQHkh2aloE9EGN/v5pAHhDhg5Ek606rVxiy9tTfajdIptKX9cBHhddWhhfVr12dMQXAgQ7xaDmQRQCQhHVohFxOzFycMK36L6m5GW+IYFlECa+3pp0WEU83qfxj8muFHje8exr9SGhvqhYKkbMtbZeS6vh6GYpha/t4JUBQOMF8AS/njjNZY3UqVPIyZ6+ngrpnHD58mmaOXMGoDuUNaweDafN7tc7ymlC+ReJtRpp5J2NeBdIqt3uYl/rdHTUoKfl/VQn44tXQKbXDz87D89pfjjZJrVKIK/T4MpQiqrdXQqS/7xnE3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG7xK5AaqfCnHXOSH0prE0dgDg99UGByOwpC9wfetnQ=;
 b=SW+AV0Ws8q05Mv7lw3x35llZKX9WaYzObOhB7l1es9wrSqZaUIbxF06Be6Pr/ZvpQ5J6KLnE5T70Kwl3FgmWzfpMCet4VNLAxvuGNuTP2pXrXOxJlJtm9KvbZsCSgS0T9MKO0bvyWl98MSu+QOLMu+wTUsK1itIm6ZClBYLBH5nG+NVcquZbT0QFaiuAr/euh18QeaVs+hiqpGtwmqgWHEqTVTy4e2+lF7Me/hs6al2pW/yozkwVNslPtBVP8nYkry9Kdtq6+uc0bsegF1IZAwLRJiS4Mv/BmpLXYnVf/n+B+Zd63mbK8w8HjkXbJ3grsdTvEG6JAExORZUddNJw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 22:01:06 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 22:01:06 +0000
Message-ID: <28d4c2e8-739b-4a5d-8d68-cd0d0b0309c2@intel.com>
Date: Mon, 8 Jun 2026 15:01:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] netlink: fec: Add missing newlines in FEC
 statistics output
To: Eric Joyner <eric.joyner@amd.com>, <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Jakub Kicinski <kuba@kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>, Nikhil Rao <nikhil.rao@amd.com>
References: <20260605001237.11708-1-eric.joyner@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260605001237.11708-1-eric.joyner@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b05c40a-f79e-4f5a-b02a-08dec5a9708b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IOdg6Zx6yC+BxPuczuMD9Drub9BNDwGak9Ay+9Ru2cB5hazemRpwtTvlikXdejZaGJhuZfikTj7gwaNVV/6KPpSbTxW6I7KeCxAK/CMrxlHeVHu0dgt6T8ZM06PAerI2XfCT0FmofjDpReS1NT8ICuEHWS4uq98/yCvAoDo7vmVnhLEmbw5OY4NY+bs+UXniVnAuJuHNC/2+ng9x847r4jRJLMDR5E1nj6v9xse1Uafm618iYu8917W4YtiNpAwgJtgJp9h+xu0PVOC1/ebogiM/SC93/r5qLa2d6wXf5AUZya7S8T6ATXp+BCw9OoCbvHfLivYrlhruxj0daNQkSNmpXkMriFVKV+EoSVXl/DZEx2v2TKuoiqcwFg06x7rYH9IWNaUVJAL8ld3/8VvBZB7RDOHNIvFLEZIJfE/7rBVB23ZTZBRYJTPcwRqu39zT9MYX+73SSUhAso2fCv7Jj1ESmNCiLdJGpSERSaFXHlzpO56c7FV8c+V0Zhltl6bNopVzVifhhiJC53eJUXQUIUrZ6gGuwYy6MbJRe3MCAF4f8b6trIyYo035z1G/4SdUmAa01K+j1ee3f0Jyyw575k9u/qDAyxg2kE1+rMHNQ2a1EgZ4ZWREWJG+6arkwK2h6i+8mcxGRIRcEyZxSiiwVlIjHvOVcJzJjFizLxBq3vdUdqfEXfZou6suVYfe4lTP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JEVVI4eWg3Z2tFZW9selh4MFB5QjBhMkNpajdybjRPNHlJQnNUaHBKd2Nu?=
 =?utf-8?B?TERsdmRiUnArRmxBdWRyRHRENHdoRTl1d2I5WWJEU3hXSmpXejB6dERXZ3ZO?=
 =?utf-8?B?QnlONEZEMGQvRjE0Tml2ckQzWDJpQTVpZ2RGRDYwYXptUEp3SVVVUS80dXVU?=
 =?utf-8?B?cFd3WnVJKy93eVppWHYwUWNZU2VKUTYrRGFjNlNBd2xGek9OR0NlU0NQOHFW?=
 =?utf-8?B?QUlNRG0zUkpoTmdmL0V3b25DcVdqYlQ5MmdneVloTGlJRllCQ1ovdHhvY0R6?=
 =?utf-8?B?V3BvWmhTeWZFN2FYbmlFZWFDTnlZUUN2SVpoZXNFV29XWGtYSFZBbzdSY1Va?=
 =?utf-8?B?SjdPRjVkQlhBQmpXNlhlS0N3bDkvK0Z2djlXUU81YmQ5b3F0V3BydlIrN0x6?=
 =?utf-8?B?L1N1ZElnRFJpZ1Y3S0FySFZ4aFMyUW4wNmtIbUxhbU9JdFVnTWNsaHRsUjYw?=
 =?utf-8?B?RDlYS0tZbjNZazRUenAvTWNkUS9HWVRET0k0TzdkRGdPczFuWE9FMU4yWlFi?=
 =?utf-8?B?Y1FqbVJ1VDNvWGtPUGV3alVjaitkdmNNU1BaNTMzcVZUN3BIZDdpVTh1aWU4?=
 =?utf-8?B?aW8rY3hrRlEzWnRMbUN1dGJROVNYTy9GTnZJWEg1OE15ZHJNV21QSW4vMVg5?=
 =?utf-8?B?Zk5LNUN5SE1ha1IxcnNUVitrajJxeURSQ3dxVUlpK2ova2JlcU9SYWwwZUVD?=
 =?utf-8?B?aUpvWU5KN3NwTzN6cTY2RlVrYXRZM1IxMkNnb3YzWlZGTzU3SXhWb1huOFZ2?=
 =?utf-8?B?SmFCRXl1OUxrNFhRaEd3RWxvUE0xUWE2NWdic1g0aUx1RjZ4U1h4L0hZaXZM?=
 =?utf-8?B?UFRQTEMxcmFqeFJFZWdXRVdscGxJeWFvbksvNTROdmdJS2wwbkFYVGRobFIv?=
 =?utf-8?B?VVhDeUd0NlNxRGx6elhrZHYxaE5VWWNLaXdWSWZZSWNrQVlvd0RKVzg1SXN2?=
 =?utf-8?B?YWttcG5lWXlUMm5SUlFVbW12RTg2aUdtZ3kwQURSaXZwVU5UV3o3WXFZUm5a?=
 =?utf-8?B?eFNkV0E3M1EwcHVVOFdPM2k5UC9mbEp3YTYzaTZlaHhOZEVlS2JnWjVxOGdL?=
 =?utf-8?B?NXhrS3hDMGNqaXF0bFdBMi9GU1U3Y1luSEVWSmhmMVpBK2VlYlhWL0ZQbjhF?=
 =?utf-8?B?WlFzN1M4T0ZjRysyeXBMczc2ZXFTRkFadUlhVG0xM1VUUXVVRUtteFJ6d3My?=
 =?utf-8?B?d2pFTHZVTkdaSVhuV2J4dDRDTGd6UWNtNmtYQW1ERGhnQm5rWjZZQ1VtbHBv?=
 =?utf-8?B?ZzJPNEZiQ091Nm0xMlZya1dpakZlYk9tVHRhTm1ZV2FSMHk2ajNFb2REQmk2?=
 =?utf-8?B?VTdUSE84eDZaSjdiWFMrUXNFK3ZFRFVlTEg4VU9FQS8vdzRzNjFmVDBsb0x1?=
 =?utf-8?B?TzlJcmVLSkc2ZElyZTBOYmZsc2xyUEd5SXdCRTN0bFFVT3M5aEQrMG5kZWE2?=
 =?utf-8?B?b1VESFZDM0lDaStIeWZMdytsckpvdGZvMlE0dTI1a1RCZm1CSWU1WEE4bmpC?=
 =?utf-8?B?bnFOdU1QMHprRzNxNlFBNE5rYkloYWw1TmZMTXpybnFGNFNON2ZBK1ZNNlB6?=
 =?utf-8?B?K1dqS29naHgyT0pXa3lFdjhsRmZUdmRNa1ROWjlQYTIybmV6WG0wbFRHbzJi?=
 =?utf-8?B?Q3VqRVhLd21pR3gzNkpFYkdXSm82d3Jka00xazd2b3lEaWpFSGlUdldoOElk?=
 =?utf-8?B?MnBqTTVRbDBlRkxKczJJN2VzdUlNWHIzMWU4NDJMOFVMcDVJc0I2YUQvY1R1?=
 =?utf-8?B?Z3B1NGtMYitFSk90MzluQlRWbHo0Tm53KzQzQytmd3dtMVdWcSs2dW8xckFk?=
 =?utf-8?B?bG54MHhXeXBjN2ZGMjYzWEViZUt6K0hNRzNXaGZvZFVsUWVreW93Y3Q2WVlN?=
 =?utf-8?B?eUE5OVZGL3NZY3k3WjBsN0dyQ0ZtVTBZaEM2N2sybEMwUGxtRWt2aGF6N2ls?=
 =?utf-8?B?Z0MyRTBQdEVlcld4YWkxYnlrT0VDaTFYOGVhc1RzZ0hyZEwwaDVnUW9mZlk4?=
 =?utf-8?B?NEQ5L3VINnREeVRoUU04MTliV3pmaWFBVkVNSkswUHpKa2tFSFJxdG85M1di?=
 =?utf-8?B?aXBpVUQzbGVTeW9wdGtkVXNTYlVZbW5UU2I4enNTb0UvZWgvL3FxME80TlFU?=
 =?utf-8?B?MkV0MDBNeDNrRzZxOU5DUk9lOFVPYURSVXZ6V05XUlRtblU5S2F4Zlg2ZXJN?=
 =?utf-8?B?ZFNvejh4SmE3aW9MUDBqaGdaQTVXNStMQWZ4QXpmMUpteXhoZ2lhZ1RkcUNv?=
 =?utf-8?B?RWNoSUJlTmY4VFo4cGNQckpqNURTNG5XRkZSckRzM1NpNlpRL24zYjJKbEdw?=
 =?utf-8?B?YUhNSEZxVUhRY2w2dXpXVS9iaFJKVTg1OU41WWZLSEF1YldiK21Ddz09?=
X-Exchange-RoutingPolicyChecked: FBxEQBTYUXsXuHHV/fIKasP6me4NjOcI2paFS9OKu1OxkPUtaEoec+JiM0AcmqfQMzju3buvYcI8dHxIWUkOn1W+e7/e8WLui0jfes7VYYISNN2GYyPV1sMuN+FryLm5jfZpYJHJsqFWtReuxf4TpytQ15tN6Rycdd9o7sQvpynIVyffxDjZBYWprWg7zIwwIz1sH/hnaTi3Q32k8koYsIIOi3PBCDZZAicvC5LI5x7NHDnmmjuGgDRyvGvwVRKtidqyHn0u0Go3Js2Upx9xcgpQNQcydOm0tUllcP5WmQI79szFIKCUeFieMM3mhKgJejiwKcHZaQk4KVVzPOh6iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b05c40a-f79e-4f5a-b02a-08dec5a9708b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:01:06.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8th66clIWqhFupRkQueIcPNviqxHEy1Cjxw96OYJB9ISdA7Yb38QHpa2iOPyzMjtHFzSmSj5k7wf32bLzGYdtnXu0HLAKaMfH0+BXDnlbDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296742-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:kuba@kernel.org,m:mkubecek@suse.cz,m:nikhil.rao@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CA5365ADF7

On 6/4/2026 5:12 PM, Eric Joyner wrote:
> The non-histogram stats don't have newlines printed after them if they
> don't have per-lane counts, and so they (and the first histogram bin, if
> applicable) were displayed on the same line with the rest of the stats
> being displayed with one stat per line, which looked inconsistent and
> doesn't match the display in previous versions of ethtool.
> 
> Fix this by printing a final newline in the case where there are no
> per-lane counts so that each stat gets printed with a newline at the
> end.
> 
> Fixes: 3426a920183f ("netlink: fec: add errors histogram statistics")
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>  netlink/fec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/netlink/fec.c b/netlink/fec.c
> index 36ad3f504a83..c014749ac950 100644
> --- a/netlink/fec.c
> +++ b/netlink/fec.c
> @@ -166,6 +166,8 @@ static int fec_show_stats(const struct nlattr *nest)
>  		if (lanes) {
>  			close_json_array("");
>  			printf(" ]\n");
> +		} else {
> +			printf("\n");
>  		}
>  
>  		close_json_object();
> 
> base-commit: 75fd12445ffd6d697d53b7d296e345d524a9bedd

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

