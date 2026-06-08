Return-Path: <netdev+bounces-296784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJGnMxdSJ2oiuwIAu9opvQ
	(envelope-from <netdev+bounces-296784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:36:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E952F65B2F5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:36:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KBiWXUln;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296784-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 220B1301ABAD
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2C32AABC;
	Mon,  8 Jun 2026 23:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC896288B1
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:33:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961621; cv=fail; b=KotYlVpnuvEid/2iwAgqcAstE6Vz3pV3U5R2+KFXGixnr1BFe8qJBTjjGwWnPd7jwE4f59eA4EaJW1OiCVwuYH+ANRAN46lfRKMf1GiUuWajITe9/k2r8y0H+iWb18JWuOk/LbY4XMh6l08asmn3RifH9sHPXPNJmmdkK+22P0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961621; c=relaxed/simple;
	bh=OE2h1TJQQId3af7Z42cEHOVrN3Vwl/Z4/ziBwfuiH/4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+ifAytEe+w+2NzdYOXeZNo1mDHqrOHDnZp0ST2ypkYF7xCDArMOeW/IiJan2wcyeueX5/kN3mxrlIGujS45wjQQCMcpxUnfptwuet8zASXmnHWK6hIAhqSdUr85r8GOylfoDlhlWhlrP2ymEq1bmnSJ3kfIh4QwEkJTcsIa8bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBiWXUln; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780961620; x=1812497620;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OE2h1TJQQId3af7Z42cEHOVrN3Vwl/Z4/ziBwfuiH/4=;
  b=KBiWXUlndUfUdinUQSzs8wvZCtBTUVVJ+9nMVBhWfyqFjxcEGjZKyJKc
   ziLIhjjd72f3LT0iqIdOZHC5aej1oaQUj8tNg6E2xxHlt4X8jkf4X+5QZ
   r5AJDdD9zL96VFK5x9H06/wBVzz+u03YKpX6+7zWITVa3DZGVSwp61CQ/
   JglcSicCVQ8yrN6R22tSPVebeq/T6PWeB91c5/VJ+i/ADQNiuy3HeSXPh
   k2XlfY4RRBePekznLB6kJZFpNwZ3qEtr/NujZsg8hthu6yVQMqLZHU+5+
   /+4m3hmkCj42iYrmWmBc05Z4KnIvAFboGpOp4t73hV+RdNDTzBLYncVS9
   w==;
X-CSE-ConnectionGUID: FpOiQth4QtOlownNFhpwTQ==
X-CSE-MsgGUID: vkABg+UpQneR20LjIaaedw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81565814"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81565814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 16:33:39 -0700
X-CSE-ConnectionGUID: TR+aPWQISU6AGa7pfGVqxw==
X-CSE-MsgGUID: 1WzneDl8TkC2oitHrXoq1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="275876101"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 16:33:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 16:33:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 16:33:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 16:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kr3E7velpiVM4sK2K4C+UiczYsknPYfVwHkVJhnvIhBxxex522vW+91rDHkMCnnV7dW6nZylnlw5t0EJrO4tsv4dBm1ra89Zmq7dnP2nUcbBy1Aphvr94d95Dwul5Bebg040rauIvHxgq9jtisZudk98wQhK2QjSB3tB0htOuJfHc6PpBuCgJ/mSycslFx65Q5TmZxlcFqPZm9IYiY/1YgJyfnPQW3hartWej3bPX3f1KttvBFf1rqajADO6Sc++IYaFwUGaLHkkxWMM1MY5K0gI6bDBqjpyCI2Yw6JO0Evf5eEtauh1AeWTctsV/Do650O6NKbdAEzSOFPjh6Abqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUW2FqF2Ubx1+hNnoMekG0GK0lufVwDonvC0bdGceVU=;
 b=XlNnzNDGTius31YGRvR8plFKkAKBEmc8nIEeWuE8U0ffLMmtHTO1xBzwXRxetQli7p4bbjjvjtJnZN70qko7UZGDn18BhQZ5wl7vEL6OjIAxHIW0UmYrQVp1iRSP8NDIEYQ/jvddCbzXa3vL+6dvD4ebxnq/3da3berBu6urUtijYs5reMTM3cHvBIgDfkvHrnm5MT1A+fBFKCrRosE8D5vyCuYF3NzCJW6fvzA3TtjwajAeIMHh021WdwSbotRtT74VXLdX5u+HrnI2SO97Y1tWAEsoCsf4qIJPyITpUGls0h/GIVQwjnu/kMZPrZdSN6762FJsBWok2qlTVa0eUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 23:33:36 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 23:33:36 +0000
Message-ID: <bdabf4af-187c-4df3-a64a-6f41dea9bf27@intel.com>
Date: Mon, 8 Jun 2026 16:33:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	<davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <michael.chan@broadcom.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<joshwash@google.com>, <tariqt@nvidia.com>, <alexanderduyck@fb.com>,
	<willemb@google.com>, <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
	<jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <9c013ab0-e96e-4670-932c-bcd1e30a85b0@intel.com>
 <abceffa3-3544-4da3-83ea-e23b64b3c0a7@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <abceffa3-3544-4da3-83ea-e23b64b3c0a7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|IA3PR11MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe58df6-1d96-494d-5469-08dec5b65c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|3122999024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: q5nncFYdkXKE1Pg4AbQPL8uCmWR/kK9E4JnRjiN9/X0vPdLc0b704pkESaJo8uhoO+VfyWwNS+n8lPeNY+qRfl3OvRarA/0OT9wl8Rz9yduqQHrCPRx0Yg6vmWS+RM24xSZQodILntG3sjKQoHuxU7w2pJQPVTCYSvqF567nWBlmDUn+Y5jWpR0Pq77ZvEDkNBJGSkLjoPv9t4BWQDjk0YDcEf69OWvWCSt2Z3sK3QJjtYdmF+/NGKvcl/QwjS0+0ZEIF4hCmOpM3Hcx7vY8BANogpsLr8+H5/9WMLFLkIkVNdHrikAmlMirYic134yVfmHu6LLTMuEP+cZvOC7/WKg5HMrTiPL0ZMTCy3uEfr10/uDxrFKZbUOu5RfWFEJKVLI0XrIxIxemBVijGQlFD7Mn0Lfq4s00KHkem1VhhyGP7v6vqdaL3eOB9gnEm76n+xOrrJ3SnfnB21yoH7yn6w1wIF9c3mr/7xARhXp47XhxCjwupL+PWWuGoKesnTMHAzZm+qTSKMFXx5dmT0YjWSIhLCpwbLl8bk3oplhVYx4KWNB6/TV4fWpCcbJNcLANvzyiRs/lmmdJZZpoWf/T6fJdqAQK+Ea5qOdP65xYz4DY2oNFdcS9TPsIzHS7TNY0Ojp2Hol7cVmKvEA8H462AmJTrnhVAEZzUFgg08HiSy//JXMvNh1xufkN8Cly/jNn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(3122999024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtnTlNIM1RHWUsrM282cnpPL1ZDMXc2Q1h1bU1MZU9tcHhobTQrbGZJdzNi?=
 =?utf-8?B?TWVVWlVPRHZNUGZTSXBra3ZOY1FFdkd1c1N6NkdPWGhydE4zOHM2L3I5eXh0?=
 =?utf-8?B?MFVvcFNrUVF1aFNQZDVRbndKSXlhSEoyelZMWnNEMmlEWXJ0d0FJaURvdm1F?=
 =?utf-8?B?SGhUU2JFMGx2WTV1bWtqcjBDdHd2Y1l5SzNQNEZGYTBuaCtYcHB3RHJ2VTZT?=
 =?utf-8?B?cmJuQkJ6SkVHaG1WdHFNS0JUYjJxMi95Q0FoWmVvMnY1bFlyU1J6eElINUo5?=
 =?utf-8?B?cm1EYlgwYm82VmNWV0xndWc2WGE3Z3dIdFpuUGJzdnlaOU16QzRNWUJxTWpH?=
 =?utf-8?B?VE1YUDUyeGtuVEpBOXVCQk43Y2R0YkN0SzA3QXRMcTh0UUNUOVdZa2dxYlZL?=
 =?utf-8?B?NFFkbkFlb3Z4TlhYU3FPc3R1cWFLdGhQK1pWTXRDbFo0ZFFtY090ODlhR21Q?=
 =?utf-8?B?TUR0b3gwUGd6TUF6RDA5dU5jU05MK0NjdWlNY09PTUNaRVk5aWRuZjB0UkNS?=
 =?utf-8?B?dmhQZlRrQmthZTdrYjNteTIraElXUC9jSnpGR0pDQUh1cTYxMTUwYi9LWDZi?=
 =?utf-8?B?V29EaTArTW9CcUg5dWdvYisxcGEvZGpnN1FnTk9jN09PRkNOM0o3ZkJCeVd3?=
 =?utf-8?B?NmRkZWttVE9wMlBKL3c2UzF4NU1VWCtXUDFOeTh1VituSTkwT2oyQ0E5UXQ4?=
 =?utf-8?B?WEhYbmFWTElaWDJubE1jdmxpUlZUYWlJdEZoaVA4NVg1OS96ZVpNdmY3THhR?=
 =?utf-8?B?bE13bUZTbWN1amdBWUxRTDFNT0pUTVdIb2hwMGJkTkZtSWZlWDg4MVlrd2JO?=
 =?utf-8?B?NDQ2citaenlIMmJIaEgrbktVVnhvVjlUc1FrMVY5Yk1OZmZWMEtVVytYYXRZ?=
 =?utf-8?B?RkJ0NWRaWU1QU2pIeXFkbUJVVmJiZVdKRlJmU2ZpOHNRNkk2N2owSWJvMEFp?=
 =?utf-8?B?ZEg1d2VZQzljTFN5ZmQ0RkxBSUpvY2xYQzVZRkRXQm1MazdWMm1HZWZPdGEw?=
 =?utf-8?B?WkZWeTRqcXluZ3lxems2aHVzRzMzSXJFTWhFS2IrakVtajd3Nmxkck1ZQjF4?=
 =?utf-8?B?dHBDSHdhcjB4UVpjazE1UEYzMStqUkN2ZTNrek5neVBmZTdtTUo0Tk9xZmU5?=
 =?utf-8?B?U0xETDh6blpId1lRQ2FGdjdFaElFYVh5SW8vWFdCOXVXbDlCc0ZpQTJSTVhH?=
 =?utf-8?B?NExsdk1rOHlic1lwWlgzRmxPdWtsdkwzdXVmNHNqTGRHcmNHMWxBWWQyazVw?=
 =?utf-8?B?djVpUUYwWmg1K1pwaUlxZ2pKL0Fyb0FTdmQwMEQyZ1djWDZmTkVTUGdqWEZE?=
 =?utf-8?B?ejdhL0VGOGlHZFd2Zk4zL0QxcjVqWkNIdUx6aXoySXZnbXpEc240NTFrakRN?=
 =?utf-8?B?cWpOVy9uSktZdnhaN3Zxc2hVdXFaWngzb0VqWXllTHZIVUhaSXhqdjE4L2t0?=
 =?utf-8?B?Y0JuK2w4cGFpTFQ3L2F1aGhSQXBKTC9HT0NsdzRxNGJVb05Tc3Raa0dHbndG?=
 =?utf-8?B?UW1vSHgzemU1eGRha3lIdStreFBiZHBYenJFK1pVK21QdEZRSFQ4QWpvZHY4?=
 =?utf-8?B?Q1Z1OElkcktLV3lUR25kRmp4dXhjSG0zeGQxV254NmJUZ0hJVjJEZjdLQm1B?=
 =?utf-8?B?Q2x3ek9sRHcxa1c2bk5EZG1GY2tNcmJWUUpYSlVLYmpkUUNFY2FMY1IybVhN?=
 =?utf-8?B?SzVTRlVzL0loaUxWcGFJZWsvL05FYXZhTXBvbnJ1c3hpZFVWbGtaaGV4SGgw?=
 =?utf-8?B?NzB3R2dybXY2Y2xkaENuYW9SQWpHZWhid1NlSm16Vy9sSWxuWnpzdzg2SFFo?=
 =?utf-8?B?V2dOM0txR21XNjEweUxiZ25nZEV0V3FCNmF6U0Q4U0FHazNjWWxPSTBTZlk5?=
 =?utf-8?B?QU9sT0xhL1VCTjR1WTJIOGprNVJING9TNkJzYkptWFQzcUdLQ3VSYnM1L0s5?=
 =?utf-8?B?SmVLLysxN3hDblpvbmRTeWdqdXJkSk5Jd1duaUxMMTRCeThOVnBqM24xTkZj?=
 =?utf-8?B?M1Q0MzRkWEN2SzNRRGg5VFpTWGhvMEREeGZoVjFpU0ZySUc0MkJsMThHNHNC?=
 =?utf-8?B?bTlPU3JkOERSR1lnYU5YUVk3NENSKzNVZ1c3ZkdKSVZlQnBZdmQ0S0VMaW1z?=
 =?utf-8?B?cVpYMGpVd2UwbDJybVYzQUVwQ0Rydk5aZ0VQVUlLNTlCMFVoYWkvZTc1NG4v?=
 =?utf-8?B?cFNoZ0U4K0hhV3R6SmVqU3A1THpKQStGcWszUDBWdy9HdVBPZHUwQVQ4dGY3?=
 =?utf-8?B?dC9hNTVBZlVQNXYwRWdMckRlbG1BekZETmVxOXdlNkZraVZabnNmQmRZbWVm?=
 =?utf-8?B?ckkrSmRsTjJleHlnbUV3emdLSDUzc2kzNHcwV2NsNGs0V1luVVRGQXV0QVo2?=
 =?utf-8?Q?uK4UZCBN2BfQnaYU=3D?=
X-Exchange-RoutingPolicyChecked: T2vivr2UV3vIMrQuk+weAlrNEp/2/glPY26upDuHKXOVA/cMJnUYN5ZEQZ9ABGc5kF2UHgcPG0XV5oNMLZUMqwM7IA4D2bdAkm58FOAIb+5q0bjIzRGzWekIlk/c0yEyit//lmq4UOUdxK0U0FRexxboDd4Ru1YRkCqTZ0v3kKVdotm1uTV4ad5kUNebmV2epbAmugzIJCQVNnlfr5Id/aNLQZ9jSXWeiY0o8r2Fv/ugZAEl4VTSb7migNIArVfiyAWmkCBmrgaMA9jqi7gPjVdwGXd57NuxpXvw1nZ/LdGva/EiIwasS3KSu8jpXvYyC4ytdYWLtz1QUaRELO+A6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe58df6-1d96-494d-5469-08dec5b65c5c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 23:33:35.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVkR81ymZ1vlAHFVd42i9N1m/a8KZeEvNf15XwBrfuO/ab2cRZ3qQdV3G3krLnGF5ihwWfXmv7NBDCrL6vJHRZCZfDFlGA/ofj7WwVKnKdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9254
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E952F65B2F5



On 6/8/2026 4:01 PM, Jacob Keller wrote:
> On 6/8/2026 3:31 PM, Jacob Keller wrote:
>> On 6/4/2026 5:29 PM, Jakub Kicinski wrote:
>>> With the ethtool_get_link_ksettings() situation hopefully ironed out
>>> the previous series (commit 6a5d837f0ce2) let's return to the main
>>> part of the series.
>>>
>>> We have been slowly moving towards removing the rtnl_lock dependency
>>> in driver ops since the concept of "ops-locked" drivers have been
>>> introduced last year. Since last year will take the netdev instance
>>> lock before invoking any ndo or ethtool op of "ops-locked" drivers.
>>>
>>> We dipped our toes into rtnl_lock-less ops with the queue binding API.
>>> Queue stats, NAPI, and other netdev-netlink objects are also queried
>>> without holding rtnl_lock already. It's time to take the next logical
>>> step and lift the requirement from ethtool ops.
>>>
>>> The direct motivation for this patchset is that ethtool ops often
>>> involve communicating with device FW, and may take a long time
>>> to complete. Aggressive polling of device state on machines
>>> with 10+ NICs have been shown to significantly increase rtnl_lock
>>> pressure.
>>>
>>> There's a handful of areas which still need rtnl_lock (see below).
>>> I decided to convert everything to rtnl_lock-less by default, and
>>> add a set of flags which let the drivers request rtnl_lock to still
>>> be taken. I don't love this, but I'm worried that opt-in would be
>>> even more confusing.
>>>
>>
>> Agreed. It might be nicer to opt-out first, and then opt-in the drivers
>> that don't do the update_features.. That would make it easier to prevent
>> buggy drivers slipping in as easily... But that would result in the
>> following messy situation:
>>
>> ethtool ops for ops-locked drivers don't hold RTNL lock, *except* some
>> which do because they might call update_features.. *except* those which
>> opt-out of RTNL because they know their driver implementation doesn't
>> call update_features...
>>
>> Yea. I think that is too messy. This approach requires slightly more
>> vigilance on the part of reviewers to ensure that ops-locked drivers
>> don't make a mistake here. However, the checks to see if features
>> changed while the RTNL wasn't held should be enough to help catch most
>> cases. Ok.
>>
>>> Known issues / exclusions:
>>>   - qdiscs - qdisc configuration currently assumes rtnl_lock, this
>>>     is mostly impacting set_channels callback. qdisc config is probably
>>>     the easiest one of the exclusions to tackle, it's fairly self-contained.
>>>   - features - even tho feature changes are (correctly) plumbed to
>>>     the driver thru ndos they are part of ethtool uAPI. ethtool itself
>>>     calls netdev_features_change() if it has spotted device feature change
>>>     before vs after to the callback. Some drivers also call
>>>     netdev_features_change() directly in response to various changes,
>>>     e.g. setting priv flags.
>>>     Since features have to propagate to upper and lower devices anything
>>>     that touches features is quite hard to move from under rtnl_lock.
>>>   - phylink - phylink and SFP depend on rtnl_lock today, I suspect
>>>     that this is purely for historic reasons. I started poking at
>>>     it and don't really see a need for a global lock. But accessing
>>>     the netdev instance lock from the SFP entry points will require
>>>     some attention from the phylink folks.
>>>   - phydev - similar to phylink, looks quite doable. But no ops-locked
>>>     driver currently has a phydev (fbnic only uses phylink) so phydev
>>>     related paths retain a ASSERT_RTNL() for now.
>>>
>>
>> Makes sense. Taking some steps towards the end goal is better than
>> trying to wait until every piece here is done.
>>
>> Whole series looks good to me. I had one minor nit about one patch
>> adding a bit flag at BIT(1) and then later changing that to BIT(5) but
>> its ultimately harmless and should not force a respin of this important
>> work.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>>> Tested on mlx5, bnxt and fbnic.
>>>
>>
>> I think currently only iAVF is ops-locked for Intel. Tony, would it make
>> sense to see if our virtualization validation folks have cycles to give
>> this a quick pass on iAVF? (Regardless of whether it merges before or
>> after, it would be beneficial to make sure we don't have any lingering
>> issues there).
> 
> Just to clarify, I'm not suggesting a delay on merging and am 100% fine
> with merging this before such testing completes. I just want to make
> sure we (Intel) do double check the iavf code so that development team
> can try to fix any lurking bugs within the kernel cycle before they
> become wide spread.

+1. I've asked our validation to test iavf on this series.

Thanks,
Tony

