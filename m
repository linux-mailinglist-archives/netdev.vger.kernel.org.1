Return-Path: <netdev+bounces-182622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1BA895B7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2705217591D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7610C27B4FD;
	Tue, 15 Apr 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6TMisQL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93A27A918;
	Tue, 15 Apr 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703612; cv=fail; b=XBz//wxAWrIaNYlOhliN8EQR1lQw98LQtIR5d/ptwwvncJCBWrxaxfNvToJgsNGjogLtqlIfZ6sRLFwIMYtIeJ+dxDjC6TeFaTfww8y+4jMas0JO4IuW39qdVRw8U2Io2JXss3RU6mcIYVOatM4sRdM1wrMXh3XndohjC0x1tK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703612; c=relaxed/simple;
	bh=USCxkafWBbjsOSRQehc9RrurfIpKQ7D4y+PwjsQKHYE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PvlUmHKhZxx0sNabP2G6MvyDF8F1vvtkILSUdd+Nlq/PZlCaYhOPc6LPmDasNG2Ew2DgkuOBbs095HSI9hfASPK/IJ9VtSKnacud/La9EZkw/I2n6Wb2JC6bVe9MFLnlKZTpXWe41ADsHzkdrfNpZ6Ii4WWS9Yaoy1klhht37OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6TMisQL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744703611; x=1776239611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=USCxkafWBbjsOSRQehc9RrurfIpKQ7D4y+PwjsQKHYE=;
  b=K6TMisQLJLdUTxm0J45U75jnro92NjpgMmHksS6kcYXogFKdhP4zesxG
   HIewWxqQOkZXlHwKB+MxdvP3J/byDBWeXKvU3QJ4RNtpYseyHqCJw0lz+
   mHnvp/qDCXRnJrzP1t9kBk9srvXIN1Kfv6teC1K6eVZ1Ehh6gH6Bcu0zj
   vf6YOkOtcuheYR8JQqsGYswMzRceguZtAgeTc+oM/6VX6aHHgaebYMUfG
   LLNUstpCHUead+z/lmx/y15BstMVvSBr1FDr9J1hgiVuT4aFP9KTJWu26
   7/Zpq2eqFfdrcM/4edHWNxu69cAR4SvWpRqbVqz1hWz2Ch+Z9oiFljwdp
   Q==;
X-CSE-ConnectionGUID: KjydqM18SaidKiiOHzV19A==
X-CSE-MsgGUID: lfMXrHw5SYO4M2IH3jFuxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46330333"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46330333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:53:30 -0700
X-CSE-ConnectionGUID: jLfW7oP8T1y11WRFTGwhYA==
X-CSE-MsgGUID: 21J5WXQSQIGa3F7JNyw9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129810959"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:53:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 00:53:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 00:53:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 00:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi2zzy8GiH7FHKaOctFW7hR3aJzGXb1arwBl/d68z4J1XlH5diZJ4WNznSc4/NZ5LuYtbanbWbLB7/GD/5OrORovTokyURedoBcWXJFgoyuaDojQG+HisWFY3q2wL71gjB3jHtUqtV8/ww5WWHtrQsoRS5RvARRosE6P7Tjk7kJHYYTh8+j3venr7iWb+HA6yvZVxw+Pj5oZJ6+gDnnVfIoLH7DZel4QAA26NeB/2aAZhYz4QoLi3ALv4JZ78wKbTu7FpgapepaftEnhndr6F3pkUN9n4lKLMgXnUYa3IWsddXPCFFj76p5VWaJvhg0MkasIE7OzYgiL08m/Gzeurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA/eYjysqYtqk/llMBPpvkWwbzTWreEijtUi9zWdspE=;
 b=oxUJeGbASwjujtUrJUqndfT5bn4D3V/pnltu2UcG4dIT7pjB0p6amnwDcDghacUg+gMnEgP2Ms6yCTGxRoxF4ptoShiYgfpMeAaGOTKNukRG1MeX4szY6doptNoeQ5/HI1wXgmL1ZlmzJNWqNfs+XxHOhCnI+Srnku/1lo58Ph1TSt3sd+xW3H7AljzQU3QQUm/Q4h2GXFeNOsliOuN06RdzakMO1CDkatHNo6eqIBerHMs+vVo4p++D3Iw+vP7/4UJ7SCtRNCIIafAZxFCRL1v3ftJ+ZEW2qNmpbHWtje3jg9PKZzCFvMBBwBnu1vLlF7tbwIEyUByGXhugEmEOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 07:53:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 07:53:23 +0000
Message-ID: <8dee9f0d-9fb0-41b1-acd1-2ed2a5322610@intel.com>
Date: Tue, 15 Apr 2025 09:53:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
To: Jakub Kicinski <kuba@kernel.org>
CC: Edward Cree <ecree.xilinx@gmail.com>, "Nelson, Shannon"
	<shannon.nelson@amd.com>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet,
 Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, "R, Bharath"
	<bharath.r@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
 <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
 <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
 <DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
 <20250409073942.26be7914@kernel.org>
 <5f896919-6397-4806-ab1a-946c4d20a1b3@amd.com>
 <20a047ba-6b99-22d9-93e0-de7b4ed60b34@gmail.com>
 <69a0bf15-5f52-4974-bbaf-d4ba04e1f983@intel.com>
 <20250414093356.52868a1d@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250414093356.52868a1d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: cc76904f-d70f-479f-5dac-08dd7bf298ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkxpaXhaUE91VU1CSWpaNFl1c1RJMzJQNHczZlNJSmxUOXU0MUtGZjJkSytI?=
 =?utf-8?B?cjE2ek1BNE4xZFZVMC9Ld09NdUFxNGtiUGtYUFhPTGpYR3ZqMlQwMitMd2Mz?=
 =?utf-8?B?M210dkxBcjQrek5WK0hGYlFUMUdRVU4rQkhPcW9lblFlNDhHUm9sdTBnNTRZ?=
 =?utf-8?B?SFJsMWNyWFVzNTBleGc0TndJbng4eDk0dDJmUTM1TTRidEFPYzhHRjBUNXda?=
 =?utf-8?B?TXVsM3J2ZmVRU2gxVUp1NlpaWGpSZGhuckl2VGxGN1R0VXZhMkI3YTVrU1E3?=
 =?utf-8?B?OER2eUxxV00vYkFnaFEwU05QWXFldTRDZ002NVp6Vm15eVExVHAvL2IyekR4?=
 =?utf-8?B?MDBLUnYxa2lVbHpoeGtWcUdPQzhHbjA5emphdkFieFhnTkJWT0JKM1Y3UlIw?=
 =?utf-8?B?V0FwU2tVT1JOZC9LMzJSUE9UcjZUQ0Z4dVpZcnhxUnplSjZTZ09tVTFXUVlu?=
 =?utf-8?B?Mm1tNHZIMWZtcEVjeHJKKzdQZDkvRXhGMk5aWXlDK2JEWUtFeG1qeUw1Y3FK?=
 =?utf-8?B?VnY2S2djSTFiSW9iRkFaZFZWbGtHSmtJakFjQTdHYlhiMDYxcEFNMXVYMXZ2?=
 =?utf-8?B?b1VLVEpIenMxTGJCWkZwcHJzYTUrQnBXbGJTRllVdjRjVCthOVFEZFhuVWs3?=
 =?utf-8?B?M3lVOTduOGhaa1lXWER3cng0M1FiRU9weEhVZGw1K1pSSkZUSHdTMVlEQ2Yz?=
 =?utf-8?B?Nkl1MFA0ZFBySGpOTFdNUE0rTXBQY3VjeW83cGxVc1h3aG1UYzIrcjBWZkZ0?=
 =?utf-8?B?ZFJhaWRPRWMrSU5SSTB3aXZCc20yR2h5UDY5TmgrUmRiT3BIVjU4YmJrUlpQ?=
 =?utf-8?B?WmRSN1ZSSEhteDhPT2N5eWpXQzRTWmRUdVhxNWV1Z2ZSSTNvQ2ZIUGVyV3ZS?=
 =?utf-8?B?QkdvUE40VTJ0VFJCRUVqNXhPUlNCSVNOTjc3WG1WYjZPU2hBSFFaWGlKN1N5?=
 =?utf-8?B?eUxrbmZld0d6QTVWM1piUFRtemlrekhDQ3dWYnhGMlR3RDYybVdWWlZaaXVy?=
 =?utf-8?B?Q2pycjNNSHVNdkw1TG5BUHJJRnN2dHdlY2orL096b3BIMDB0Z3F5elQ0M2dy?=
 =?utf-8?B?NjVwdzZnODV4RnZqdnRidDZQZWpwU2ltQU5oR3VwT1RJSFQ1ci9nUHlzbFlz?=
 =?utf-8?B?Y0VsN0VMQkMwV3pqOEdWV1k3WHAvejFiQ0ZtNlpFNDR0YndrZnBnb0JNbXVW?=
 =?utf-8?B?ckRGN2JxSUhxc29hNjhZYS9OTkVvaG9rMCtGZGlzVVpGdlZZUytLaXREWGJI?=
 =?utf-8?B?eTdOM0N5aFFyN1gvT0ZHVkNMZmp4NkNoQTRhSk1iR0VDL3JhSXJMSnNUeWh5?=
 =?utf-8?B?NnRqYzNZbkZjUXFkclpVcDBtVHZWMC9TRitKeXNFVDhDUlR0Z1RGaWh1S05E?=
 =?utf-8?B?blNYSVUrelVDNUZaMG43UWp4YUM2Rmlxbnk5V092bXNPRFdCRzlaV2NsU2wr?=
 =?utf-8?B?V21ZSWNJRWc1ZXJYaG5DaGVLOEtuOWdPQUJyb0VrUFhSdWdWVDFvNGJtUEh4?=
 =?utf-8?B?TmpqUmN0MTlNbGhJSVI1QlhlRTg2Wld2R1IyQ29ZS2c3VXdCZ2UwYmsvZGxz?=
 =?utf-8?B?dVhRaEFJMlFZSjlLeXZRODQ4VnEzZEZ1RHB0ZTdIc1VmZ2hKbWFQWTBJWHFK?=
 =?utf-8?B?SFBoY2Jqc1NrRVlSa2Z1VWhQc2YzbGxDbTFxQlRzRkhrRzM0MUhlRXc2YWpR?=
 =?utf-8?B?eHRlNXU1MVZ6ZmVIYXJ3OFBvajNNakNpNWUzV1R3czNmVi8vWGpzT1BEdzR2?=
 =?utf-8?B?V2E2d3U3UnNGV3RmenZZWWhjMVhaVUgwbVdCZGRnOTdjQUdhQWlFWnlPbGJx?=
 =?utf-8?B?UWUwMy9rSkJjMGxHQVhEaGlWSmZXNHExR3l0MkUwcTV2UWx1amVMT3pIVWxD?=
 =?utf-8?B?SnhPL1lCT2h4dzFtVXN4U2liRkNIbXBieXg1NUJDZ21jQlYwdEY0WXhwd3Vp?=
 =?utf-8?Q?FXKiV2SY+bI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZqUEdXUXFPb0JIMUlCSGhBckF2RVVqckdHVlMweEZjOGtXTGNXVU5KVnNs?=
 =?utf-8?B?YVh2T0NXVlZKUGcwcUhLdjQwMkhPek1Ja3VGVnEzQm91YlA2VzNIOGMxeW05?=
 =?utf-8?B?TDQ5SGFGY0FGamlrb1VIckQ4enpha3NQY21aU2FFK3cxNDBXZGU3OVpPUUZm?=
 =?utf-8?B?YWdtTmJWclRwUGVXdkIyTVhCUFpZMjRZRFZmcG1VQTd0OTV4NkJYTmNudkE2?=
 =?utf-8?B?enRRRUJXRWN6Ykk5R0N6b2QvZ2ZsbFEvcGhqTjh4THZlaktTWnJTbWwvN0Jt?=
 =?utf-8?B?OHVlVXdEY3NjRlR4Q2xwdHhlY3JidUtidkEzaWtqV1J6ZkQrYmx0Z3N6MU9L?=
 =?utf-8?B?NGM0b3hacWcrZ0JNeWZLL0p3dVdlc0NsMHNkUURPRytkNlVGNDVxWWlYdldI?=
 =?utf-8?B?RWZndTEvb0lDOW4waVA4czk5YmU2dDByNlNpS1N0bnFxc0hvaElIRUsrMTV6?=
 =?utf-8?B?VHhUZGlYM3M3RzhkSEc0dENtNXJBT1MwZU9nSENKZWFQQ3JiQjVHR3RvbGlp?=
 =?utf-8?B?clUrcVBOdTc5cVFBSnorREI3RjNEd3g2eU9UR1hzcDFWYVptaTFHSE9SY3d3?=
 =?utf-8?B?dlZRN0FoOWlTWmtxdGcxTGxqQnpPb1lWU0hZUmpYQmdGb1NvSHJMcHVuL0Rz?=
 =?utf-8?B?eHROMWorQkZnU2s2bHRiVUxWWkdZSlN6YXFhUEROaU4vR1ZDZHhNbVdkak5k?=
 =?utf-8?B?Uy9jR0ovYzZKWEU5VG5RS2l0WkZoakh6SnpIanhzSzBzcVdmelRSbUUxU1hz?=
 =?utf-8?B?eXI5cmRxOXo5b1E1dVlteVVmRTFuQ2RLRTc0dUpSekpiRnQwdkVYbmU2UFBr?=
 =?utf-8?B?bG5jZWJrOWRib3BpNHJoVHAwV3hzekpLNVZ3eFh4RlYzc0JDNkZVc0EvTkFV?=
 =?utf-8?B?UlE4UmQrUE9jSUhFdE5rUUdFWjV0UmJ0aCt1M0NaYzRaRy96SHBxdUVLTmlY?=
 =?utf-8?B?NzBkZ2x0WFlCRnpNc1RYa2FQU3J2Wko5ejFxUmtjRHFzTG5ZM3E0cUNueUtI?=
 =?utf-8?B?Nk9LRTdzZnhxWkt1TzlaMDgzR0xISEpzRTg0UkFRL3FNTFNRS2NlZGxTeXB1?=
 =?utf-8?B?aHdZY2pNWEdUNDVRNFdNUFc3Y3JxK1JJd0k1bHlubWc3TDV3dkpvVjYydDQ3?=
 =?utf-8?B?ajRmNmRtSkFiSDhaN2s2TnJJcU52WjNvU0U4ODcrMFh3TDhlYnQzVFJlTnIx?=
 =?utf-8?B?MFlMKzBaeStZREVyN1JYeDBaWkQzSFhrcWZsSDVVOU54QWUya1BzaTMyb3dn?=
 =?utf-8?B?U2lHS3JZUWtLT2lLU2EvRXZoMndPT3djdnRJRlpEWU5pK3lEKzlpQTBnZzNS?=
 =?utf-8?B?dXo5WUVFY2ZLd2NqODBxcGpzeUIyZXVPRngxN3JZN2crWWlYSnU3UTUyMHFW?=
 =?utf-8?B?T1dYcTIzUVRlKzRLUnFCOVJUcjBjeVgyOGZLWndlaW5jelR2T2RHL2tzdXFR?=
 =?utf-8?B?dGY0c1V3blgzdXhOa3ZJZEtNTStmY2p6NnZKWFFyd0w3WnlnUVVZMUxiNVQx?=
 =?utf-8?B?bWpOdzZuekNqOU9wcG5VbUZmcmtycC9GWHFFdCtiNEFKRVprVnByNWkwZGdU?=
 =?utf-8?B?MUF1Z045V0lqVDNuM2VqY013aHhSK3VFelBLN2RUK1pBbm9vd3lZSHp3Sm0r?=
 =?utf-8?B?RW1YMWJaYi8vRnFPS041WW5Ha1FveXVoK3ZiVXg2RUZEUFI1aG05YWFhUjA2?=
 =?utf-8?B?WXpiMmFpUHdhU3YzemhrcjV6bTVuejhoTW9RaDAyRGxMZGlWSHhTOWtEdmFE?=
 =?utf-8?B?R2swNVcwVmU1RHhudEZPM3FUWkhMbzVYRlZxUjhXNHhXTFMwRlBTaG1IMmln?=
 =?utf-8?B?UHRmVGFnNDFEaFFTNWMyN2d2ZmFvbmVpb3hlRmdpNDRiTzRzbzE5eVJtZ0hH?=
 =?utf-8?B?Q1BNRmZ5Q21LSkppdjMwVmJic0Y3M3NqNDdYR040cmM3ZFZvcDVXQ2U2WDNP?=
 =?utf-8?B?OHVXTkJ1MHdQbTllU1d2NkJRZExtT2w5RG1FWTF4N3RERm1CbDcyZktDQm41?=
 =?utf-8?B?RjdlUUtYWDhjaVgzTFZYOFVQVXhDRFdMNUZFQzVKOUoydUU1MllvaUtGNkdm?=
 =?utf-8?B?bVFMbTREaWNnV2V6b0RQRlVxcVk1aHpqWjNsV3Rmc2xraGd4ODVydUtsQU9E?=
 =?utf-8?B?dmxJSjcwcmt4TVZwcTFCSDNiSkpEaENHYnQ5aDY0bFR1WHdldjFxRy9EUFpZ?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc76904f-d70f-479f-5dac-08dd7bf298ce
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 07:53:23.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0SY9cd9gUwZ+lwSrwu6CJng+L5f8NGdq86L2iUYHKzc35zZGxnE7/0KbKU9kmkd7EY44SGJ3oPGaKoof2mGTpm15lfaLLX7KbuKUfq1630=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com


> Unrelated (I think?) this is a relatively big series so I don't want
> to race with it, but I think we should rename the defines.

you are right that this is unrelated but conflicting :)

> 
> DEVLINK_INFO_VERSION_GENERIC_x -> DEVLINK_VER_x ?
> 
> You did some major devlink refactors, maybe you want to take this on? :)
> The 40 char defines lead to pretty ugly wrapping, and make constructs
> like:
> 
> 	if (something)
> 		devlink_info_version_running_put(...
> 
> impossible. We could also rename the helpers to s/_version// ..

sure, I have also one more refactor idea around this family of functions
so it would fit well :)

