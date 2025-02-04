Return-Path: <netdev+bounces-162490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FBAA270A3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E841884FB8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8320C48D;
	Tue,  4 Feb 2025 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auk7rh7y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58C20B1EC;
	Tue,  4 Feb 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669850; cv=fail; b=CEM57HEveidc3vtPqbrWXC06agv/1ndztYeL/fweJ9U5Y9lM9aePDMIR/QdJsbuIBehqCX5fGNFfhdSCe4G6ZQ1eVoH0+nUqC9seAsd0NQ/CCu23DfumuRNdiduIzWiKNNbyhTNoyoCgjrpyPpenCmo+ZJmvMKpD/kzgEv4J65M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669850; c=relaxed/simple;
	bh=qoJ4ykYhDBoDBqJ8IjZO7DYGD71RO/OpB4nnjuylYpk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7oF83rbvNtfIuHiJeA0W9VM4ASzuKttJg85hgOxhhF317uA6cz0/LNVdDIJ14LlSH5V4xOenf1yy9c9mxveHuzwdGhF812msNccZrHMux1PyKljYJa2hIMGnmECs4yi/URIS/dZAYcegmboCpVCK6lbHOlzI8OibsjpgXx8m1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auk7rh7y; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738669849; x=1770205849;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qoJ4ykYhDBoDBqJ8IjZO7DYGD71RO/OpB4nnjuylYpk=;
  b=auk7rh7yzSWvTO5iP0x47H5Fw2pyWFpzd1BqQ8T6zXUuHGXu2PzBsgma
   84puw3jX1qRF/NC51DFTY/qAMPhld7ZgO8Mh3+i7KteigEZDqgjE/wIg0
   NHLQ3MJIZ3v089hJdsULzgG5PcVYBsNsHFu/kbwKLQ8MnorOg/p3Lx5WW
   nj+6mBgdaLdQemJp7tpeRLMVmLVY7mYJkBcWew7gm0R2O9g3XNcbtxOQD
   8t7CUYrX+4p4zzAwV7vysLu0cB+D8pHikhaXbYb3UUM8g2sNsIOpLvwEQ
   dKEZXF2HK15+7BZTY5Az2yf4dr0N566FxGXWByLA9vkUP3CvLM5a51WxM
   w==;
X-CSE-ConnectionGUID: cC2y4b1YTiSzNXYcaP8SEw==
X-CSE-MsgGUID: 3ip3IWcoT/6IiZxXQo63Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49448991"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="49448991"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 03:50:48 -0800
X-CSE-ConnectionGUID: F04b9tYhQRCes0Vz0TpBig==
X-CSE-MsgGUID: /0yu4TDNTqaRbjHNljWI3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110415304"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 03:50:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 03:50:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 03:50:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 03:50:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tODuzAHjlHFGCw4pK067Qc0YvfJWERXRrTUMPqk10UVtAFp6wAZLop9EuL2PxXcnnjn4RYHlYm308I/yGCUIpLCam4Y1VTtH/qJSUtjy3+UhGaEONgU2fJnACZJ1KhQ/3qoPstO57xfY3TmLZn9IycCRjy15ZVwWgnPf9KNmOBvzsImMDAA4bycLwp9cv4WpKHibvgLeLGGGWIDmJbEV8gmdddSQP1R6lupLithEz0WHSdGvq+pzhDNv6wNp1n66pN54eqeQKZzyWCCYyAFwFaaivX/vSsGKzIUnCwubmdIL8icasrjP9E3DmTUVdAdt7vyOfmulyWyhDrKaDdWeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjpIJNVg1hVkTJcVpOXBoVRex77qZd5CnbgkaROBMBI=;
 b=xLlxv4hu47YXwuLZIzayHdDhWlRsjGMpB4OFUy3OeR0tnXoGHlnzuRTFIJQA2ZtH27SFGQUwzRUDvuAdo+9U0yKVG23ODYXAfwXtl9U0b7vEIy3WGBquo9NmlnPlOoBp1VW9ZmarkGS3KAn+RJwhL/FwPZMARDnxZyb6WzonHlotgQB1gLIR60z1SgRS/ZSsdFAqjT9cSMKbQdJwOILM671/yaLFYbklC7tuHQWFy8V0sY6dpbLqfFLfbD1s7X6NhQqcOn1jnOCEnPyd+IpqT7a7Z5uojCJ3KZjKXMbsDsQpL5SSEBuAUoZ7tZ012CymKFCXPGjeNeSLoZzrkPabdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 11:50:43 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 11:50:43 +0000
Message-ID: <0f42a6ef-9d7a-4dfa-909f-36578a027320@intel.com>
Date: Tue, 4 Feb 2025 12:50:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/2] net: phy: Add support for driver-specific
 next update time
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20250204093239.2427263-1-o.rempel@pengutronix.de>
 <20250204093239.2427263-2-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250204093239.2427263-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b392f0-2fbe-4f11-2965-08dd451227ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1k0Rzk3ZklGQkVjSjNKY1pnb3N4VERIWlQyZDhoNmZpT0JuY2NGZHYwNXhx?=
 =?utf-8?B?eElaRlNpZG13TThYckFLcTNmWmpoSkFqUStabDFpSDNUbDBjVWNzeVhELzBF?=
 =?utf-8?B?QlRzdEtTL00xZEQzeWVuNGZwQkh6ZTcybmRIN1lkdTNGNWF5WkN5RTltNk5r?=
 =?utf-8?B?TnR3clNXOUpZYytUcjNZYzdRU21zeE9YYnpqMGFEMmRjcWZ5cXpKYWdBWWx2?=
 =?utf-8?B?bE93d2xrRWY0Zk45dGducUVlSlhPV3p5aFVOVit1b3FVcFhHSHJxZjlDczhN?=
 =?utf-8?B?S2FvbW53Z2ZqMzQwcURIMXkxaXUyTUs3Zzd0VFVZeFhjanZKNjhqaGNuaXFB?=
 =?utf-8?B?QzFFL29TTmsxSC9CUmNPc1dtVnB5cUNjU0c4UmJyRURsWjZXOGZQQm5CZFQ2?=
 =?utf-8?B?SGt6cGtnY282KzVnWmYvbVVDZ2VuK3ZXYWFJVHFkRExtR1liMzBKTHR4WFVI?=
 =?utf-8?B?NSthVVJCMkJNWlR5MkNUd0w0eEpiUHVTWFZndHZpUkMwYU1PQTVEcnBIQUNK?=
 =?utf-8?B?RytJdzhleUVBUXMzOE1sUmt2OU9ubzVUUTRMTHk3RUw4WURPOUFLY2ovdk9U?=
 =?utf-8?B?NUdxSGR5SFJiQ0NwNktPSmJOMXhtRWsxNU1qeU9ndEhiZmpGQ2ZWbUdVZHVQ?=
 =?utf-8?B?L1c3UGRqbU1LNUw4Vyt3Y2F6T0REMThGNnljZWRzVWpYUi9yT25wL0ZiMUNQ?=
 =?utf-8?B?cDRCQWxWb0dtU3hGUDA0bXVIQVRZdUJ1RUEwQ1h3SUZiMFpoakM3YVdXU1Aw?=
 =?utf-8?B?b3NGMWZnTFlSSFZVdWhscWFVOTZHQ2s3YkdKZUN3cTUrMFI2UTB3YjllSWU3?=
 =?utf-8?B?V0NHODdvaXNYNkxzUXhLWGI3Y0FBWFdXYUY2QysrakJxZzQyYzBYdmt4Qys5?=
 =?utf-8?B?TzFxN0hrY0JhUVRxbjluOHR6TytDR0ZZdVV4bE5SVzBWQzl2UUg0cDFlWWx6?=
 =?utf-8?B?MGZOM0tGQm9hd2JpaDhmUEhVNFp6RnBFZ3R1M204NWFBUnlkWERhbUZNNG9o?=
 =?utf-8?B?by9SdnVCMzc3MG9TaC9ZKzhaYUducXpGbTZuQjZtYUtnelhTVmU0S0ZRaUNk?=
 =?utf-8?B?STJjNmxFay9pcCtCa282OVcwN3NkSzVObWRRRmxHc3VBV0UwRVdicEFBZ3hh?=
 =?utf-8?B?RGRaYzdEYTZCMVZwQW5mUFdvWkVHcVhwR2tncXV0RkZGaGNHaVFZNHgwaGc3?=
 =?utf-8?B?czdNSkErU3pjWlQyS2ZHV1NtclFhUGNCdWppcjRKVERQYTFoaEt6a1BvL0tv?=
 =?utf-8?B?SHBzcS80cGNxTXNtQU8rZkVTZDVoWXYxc1NLSzZRK1lGQU8zWUxITU5RVno2?=
 =?utf-8?B?TjllS1Z0cEpjMkpBbXhudWVLbjVWKzBhREZFZnZPTHFOWlRmS1dlZVE5QkRa?=
 =?utf-8?B?RXJlQm4raTlLMEU1aTNjbW9NM3RLNkI0Z1J6QUhsT05YTXoyaXR4d1BVTEZP?=
 =?utf-8?B?ZVhIcEVHMXJGNzJoZkJCTzVyWXUxWG1GU0ZTdkN1T1dEb0d3b0o5Ykk1VHoy?=
 =?utf-8?B?ZXpxWCtiaWpUY3dUMlJrZmk0ZmtuNU55aHpGQ0RvSC9xNDAxNWcxWkNoMlVX?=
 =?utf-8?B?QWw1UXhNTGVCaG90WUx0RUZSSGl0N1VGMEdVR1A1U3pkc1QyZDBWRDhWMHVV?=
 =?utf-8?B?ZnUxMHRpb21lak5zQTBQNlJHMnYwK0IrdVVUbGFVS215N2VVK0hFSG9WTmlC?=
 =?utf-8?B?bWxCZ1FhWU5tTGFSMkFGeGN6YnBiR1hUaE5YUkRyTGZRK3hSOUMzdjczbFk3?=
 =?utf-8?B?cTlDck1YWE9PZy9pak04bVlTM2RrYmxYdTFHK243aGdncUpnNVlBSm9aaDVh?=
 =?utf-8?B?T1RKdDZ1NE1WY3lQZXhRNTlzR0NUU0xKblVMUnIzTW1Rc0hZUHNPMk80eDN1?=
 =?utf-8?Q?+ASKiZBQKjull?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBHVjkyK2Jvcmd0eUkzWlVxZXhJdlFLblRGNlJtMUVLdXFUUEFPSEcxWStB?=
 =?utf-8?B?MnE0R2pCK2hIdUpicnVTQmVJM3NBbjA4dTczdmI1VDIvV0RvaHpTMTZXS1J1?=
 =?utf-8?B?OUloSkxZOFpQTTl5aXlyV1FJeDhHL1RZc1VWdVFJdzhuSDBzSC9JaEhrbW43?=
 =?utf-8?B?UUxZbjgxdVpGN1RQT0o5QThqcmYxZWVGTGlmY2lPZkhVMmNleVdyV2k4dGcr?=
 =?utf-8?B?NWl4YTROMDhRbkVSTXoxUFUzSzgyYjJtVEhIRmhHR29mK2diTjJtYVVsSkh0?=
 =?utf-8?B?NGNwK0Jnc1k4S3RUTXgvSzFjbzNTa3Z0ZjhHN0laeGlZSy9kakJpV1BRaHls?=
 =?utf-8?B?TDBOUDVUVGpLTkNXZWlhL1pyZjI5d0J0S3h4ZFFFemE0SWY2YndmaVJjbklM?=
 =?utf-8?B?UXAyUUNjWW5CRGNRYVZhVzlWWjQ5a2RvVGlrV2owTlpDVWR0T0gyZ1RzblJY?=
 =?utf-8?B?VExMRDRlcGhaWHJaK0RFZ2ZaVnJ0bkNpalNFNEMwUWVMSElHcTFnZmxmNUcx?=
 =?utf-8?B?djdJaFZYNUhxM1JsZmtDZ3NwZHRBSkYyWWVSaXZVUFp5TEVPOUlsOS9kQk9L?=
 =?utf-8?B?dE9zT1BOYjB4blRZdnJ3MC9uOUs3cXd0a0ZmeE1wdWdjdGVPd1NvczlTVklR?=
 =?utf-8?B?L2ZFNFk3NjgzdjQ5bnduYlNhd1hlV0dCOFVvN0dSaHMyZGlwcFI4L3BsRlJT?=
 =?utf-8?B?ZGI5UUVNTzBNaDZtelRBME9Jb3ZxUE5wWlhndThaV1h2ZWNuQWwxbHkvRUcz?=
 =?utf-8?B?WkdoczA3NU5QNjJJUzBnRm1OQVE1ajN1VWdhUlY0K3BjUjIvcHJWV0VVY1Bi?=
 =?utf-8?B?SUR0bElzcjBYaWdTV1oyckFNdmZiUTVGTkJDd3dLVWI0RDJNWU1TRTZuNXJz?=
 =?utf-8?B?RkorMUNEclBYdWVSb2xpTzZrV3k5SXUwMmc0S0tkeVdzYmNMOFdjOUYzcCtv?=
 =?utf-8?B?b3NiVUd2WkpGSkg4b3RMajB6bGl6aHRubUV3UnlseXdWR1hiRk9lU3gzU3Rn?=
 =?utf-8?B?OTBTWlJWT1VTQ0Q2S0dlN2lhMk9DMlBxQUdyZnNNUU9CZDBDTGMyNjRSQkF4?=
 =?utf-8?B?WnpLL3Fqd29LeTNxM1dscUpCbXJBREljOUJhN05lMnJ3cUlpREhncmpjbkJi?=
 =?utf-8?B?ZXB3UTMrV00ybGZKZlFVdzJiT0M2aGdlZm9tV2xyWjh6djRMU2c4M3RvS3Fl?=
 =?utf-8?B?VG16UGI1TVVjV3lHYlNTNU83Z2gyeFZzNFVOaDJCRkxXTlVqeXVPY0c1U1NW?=
 =?utf-8?B?TmI4TUpzV09vQ2wwekN5amhVY251dnNtRFpMNGZNbkdBYjJESE83TGhrNk9F?=
 =?utf-8?B?OTBDR2xTMHd5czZCZnVlOXNsRVEyb1cxR3BNZHppdDIyMnM4aDFVRFpxc3g0?=
 =?utf-8?B?THBnOXFNTzdtOUx6MXFIbzAraCtCaFJVTGVPd0tiaHdOVDhwTGRUQUhvRDJL?=
 =?utf-8?B?OXhZRzlndVlja2Ivbm1TTHc5YVhuSDNVMHJNOXdtczBEbXZwbTVTWitHamhQ?=
 =?utf-8?B?aXJoRE83Uy9nRFlsVm1aYkF2R0huaVlRdlRBYWtTVGdhWXdZQVVHc3IvMytH?=
 =?utf-8?B?VG40a09MV21iOFdtMEtDU0JRMnExaFZRYlJIRDVrVERBSVJRZ0xyM3ByaytQ?=
 =?utf-8?B?MlRTRnRVWWI4L1l1aHZTZzJVWW95eVBHL3dFL21PRE56M2szVGFURFNyQ2ph?=
 =?utf-8?B?VTNUNFhUSTlUVXdOUEp1RzdnUmNtRTB5dHp0RUFKZHlOZ3VZdlVweXBJMFEy?=
 =?utf-8?B?bVc4bkswQU5mc2ZpemdVaE10a29kMTMvaUVmN29pUDRXM1dlNGpqWC9XMWVK?=
 =?utf-8?B?SW1lcW9GNkdDbXBrUzZCam9YTzFuVTVEVHBnUXUrMXBiOFVEdGdjUkVDVEVB?=
 =?utf-8?B?bmdSeFhkaW4wVVpPQ0cyS2hVcEJ2aUJvdkhuQVREUDd6OXFMLzVTSkdhVlRh?=
 =?utf-8?B?SnhYWHRTZTByN29nTUJ3c2hSVUp1WXk2MEVZL3dQWHlvbWI1VWFXenVPenV4?=
 =?utf-8?B?Q1NSV1VtUGU5WEtMeHcrakVsM28vdFRnaGJtbTZjZXZXbFIrdjZ5NkJVb3NG?=
 =?utf-8?B?LzAwUXVqbkVrYjY5bU5zY3JvQUN5bHdmZGcremFjVHFRTTd3SmxBVlJGSkVa?=
 =?utf-8?B?ME9kWlRzelJDS3dPWEpOS2c4bGErcVBhcFhPQW1LdTFxajVpdmlCSHZveHVG?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b392f0-2fbe-4f11-2965-08dd451227ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:50:43.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnQ6LQhHekz+jFu4tMddEqqjZ6rPS8ZIQsk2tXVUvFbfhBPxZaoTbdehbPrTj6pGjEx8oAaGQ7sM20SWTxhGxcpHgTeEIAJVlA82ZsndxHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com



On 2/4/2025 10:32 AM, Oleksij Rempel wrote:
> Introduce the `phy_get_next_update_time` function to allow PHY drivers
> to dynamically determine the time (in milliseconds) until the next state
> update event. This enables more flexible and adaptive polling intervals
> based on the link state or other conditions.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/phy/phy.c | 28 ++++++++++++++++++++++++++--
>   include/linux/phy.h   | 13 +++++++++++++
>   2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index d0c1718e2b16..77ed7bfdf200 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1501,6 +1501,25 @@ void phy_free_interrupt(struct phy_device *phydev)
>   }
>   EXPORT_SYMBOL(phy_free_interrupt);
>   
> +/**
> + * phy_get_next_update_time - Determine the next PHY update time
> + * @phydev: Pointer to the phy_device structure
> + *
> + * This function queries the PHY driver to get the time for the next polling
> + * event. If the driver does not implement the callback, a default value is used.
> + *
> + * Return: The time for the next polling event in milliseconds
> + */
> +static unsigned int phy_get_next_update_time(struct phy_device *phydev)
> +{
> +	const unsigned int default_time = PHY_STATE_TIME;

Why you create this variable? It is used only in return, so I would
rather just simplify by doing:

return PHY_STATE_TIME;

> +
> +	if (phydev->drv && phydev->drv->get_next_update_time)
> +		return phydev->drv->get_next_update_time(phydev);
> +
> +	return default_time;
> +}
> +
>   enum phy_state_work {
>   	PHY_STATE_WORK_NONE,
>   	PHY_STATE_WORK_ANEG,
> @@ -1579,8 +1598,13 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
>   	 * state machine would be pointless and possibly error prone when
>   	 * called from phy_disconnect() synchronously.
>   	 */
> -	if (phy_polling_mode(phydev) && phy_is_started(phydev))
> -		phy_queue_state_machine(phydev, PHY_STATE_TIME);
> +	if (phy_polling_mode(phydev) && phy_is_started(phydev)) {
> +		unsigned int next_update_time =
> +			phy_get_next_update_time(phydev);
> +
> +		phy_queue_state_machine(phydev,
> +					msecs_to_jiffies(next_update_time));
> +	}
>   
>   	return state_work;
>   }
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 19f076a71f94..d5cf979f4a6b 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1273,6 +1273,19 @@ struct phy_driver {
>   	 */
>   	int (*led_polarity_set)(struct phy_device *dev, int index,
>   				unsigned long modes);
> +
> +	/**
> +	 * @get_next_update_time: Get the time until the next update event
> +	 * @dev: PHY device which has the LED
> +	 *
> +	 * Callback to determine the time (in milliseconds) until the next
> +	 * update event for the PHY state  machine. Allows PHY drivers to
> +	 * dynamically adjust polling intervals based on link state or other
> +	 * conditions.
> +	 *
> +	 * Returns the time in milliseconds until the next update event.
> +	 */
> +	unsigned int (*get_next_update_time)(struct phy_device *dev);
>   };
>   #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
>   				      struct phy_driver, mdiodrv)


