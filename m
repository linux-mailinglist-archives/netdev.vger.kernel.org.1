Return-Path: <netdev+bounces-306494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIjXJ17BUGpb4gIAu9opvQ
	(envelope-from <netdev+bounces-306494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26ED7394B4
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="U8i/7h/Y";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306494-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306494-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41835300F50B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A33F9A0F;
	Fri, 10 Jul 2026 09:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50F3F9F50;
	Fri, 10 Jul 2026 09:52:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677134; cv=fail; b=Umnw04tT1AhTXlUUlUHwLy4/kXSrV4v9YjL/cMb7DbM0g9VaKP8AeFzyYs3rDuM5Co2pYfykJK9cE4qkOA8f4qcE6cVL1HZZhUwgzH8YfWryM9MP9aM6a6CzIC8pFcOwfMfwjcTLsq1F/MhOprOb7xtO1HqucTl3+z+qIwMkd6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677134; c=relaxed/simple;
	bh=79cjWDyVDPPJTrfDZuFHOO7mXzLQzaWntK9mZ+FmHbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5MXam6xZfe3iOiPpjF6HMSxEZgE8crUifOk+ZGHDBaoN2sejCrN6B6L8p6jDpvabGRX/ZN7WAVpUy0SJYYXJ930oVAiwWlbeiwg8aP4V4tEiQC9TNaW6wLtg4RsABjgYQEQH++4/ldUD0lmW4exQ09eaJB2ChOCXsj3ArXa8/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8i/7h/Y; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783677134; x=1815213134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=79cjWDyVDPPJTrfDZuFHOO7mXzLQzaWntK9mZ+FmHbI=;
  b=U8i/7h/YRE7RGlVgbF1XEPLeR+Eq7pXe8jH/98Ro6MfI+3F/8nWIPhyk
   Va7F7DBNdOz+EbzlyvcJ6y47j0bQKqL9CXlh6myO1eS/tm7+mOcJ3NfYF
   N+8DIYvz31d7irR2wipb7T8djRQ795QSKfb3NmtUuXU4bJFc6tCb1fO90
   PJET6sY4xNJJZgxSZkrtlONjA5QN8+bIfW9FQ4G0A6WS4SW4ENW1p0R4w
   4dCKfPMDpUgO16EFecvKTsW/R4Yd8+MZV3M4saozxLqm4aK5p7vx7j38O
   A/pj4/ovrNVJB5Xos2K2dr+l/Bb5veZy+VFkbvknAReAOxy8VLXozUL1D
   A==;
X-CSE-ConnectionGUID: Htqedz9VTe6lblYP761xSA==
X-CSE-MsgGUID: 02HbcBRLSIuo49eVPzBQcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88287871"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88287871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:52:13 -0700
X-CSE-ConnectionGUID: dSjDM8LhTl2sKpkT6cB/Eg==
X-CSE-MsgGUID: 4Y7cjfChTa2wWiIM2uOBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259740817"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:52:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:52:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:52:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev+qN5WBygBdi1xfHEW9gnJTnAqSixpHz8soO8ECc0J9yswnrM91OTgDeG7hfP3UQec+9nqJEf5My/xfZuljtf1JbWfa3HO1CDEeaCLAnNJAlouF8FJSrv1wy8+uXMfjxE+5HVHaoQ47wvjew+E8myTb249yuH4IZeXjZwkUFng04T9b6z/xJ2TNNer7qvMumfz+y99UwQYx2G65RVVQgAWs0T815muVRDMK313sxZHPfxMsboOaDNOK/8pdx6ZV3we6c2Z07o+EYO2VNwpVfgR+2e0OEmfH/Q2jadDbPwcsPVGVo/50C3kz0/KdGPdxJbOLdDleA9d1wbVRvWNCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrvIikYKENvaTRWpJ2YwA6KmJ758Woja6EwcHKAxYNM=;
 b=Do1e2BOglKhX8OG9thMbBkwmsxIpx3DcRjbbB/Oeqcd/hUAuCqp1T7WZsVk99C+Ktfz8f6Egc8UnAR3vuCc7C9AExkOnQ7qiWVVdxDDtGESQK3gwZMH4Kb/nDepaPfPd+ni6UcOFtpZzmzMCKG3rOwMkGKvlEbWi/p7uLKRUb+3mW5gi7tVEA1TNu5DGSYx3q/Wzxi15loSYeR7RUYWhINW0HsvqXJLN66cI9XF8iEDrlnCLzGY8jdf8cLV/OnGcO3UQ7LhYnc8WSTlXX9Uq39NVZAVNKVWEtXj2cBiy2TR6MogB8wWxIH0coRg52USuHize7Rg03aPtkQ576rvLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 09:52:04 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 09:52:04 +0000
Message-ID: <8e4f59b8-0354-401e-89fd-5f8686587bf0@intel.com>
Date: Fri, 10 Jul 2026 11:51:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] nfc: digital: Do not dump a NULL response in
 command completion
To: Linmao Li <lilinmao@kylinos.cn>
CC: Simon Horman <horms@kernel.org>, Mark Greer <mgreer@animalcreek.com>,
	<netdev@vger.kernel.org>, <oe-linux-nfc@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, David Heidelberg <david@ixit.cz>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260710061254.80975-1-lilinmao@kylinos.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260710061254.80975-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:110::22) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SJ2PR11MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e96bace-875a-41d2-2785-08dede68e564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|18002099003|22082099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: KrjxTiR00oWJ7ov6iSlx8hByRVHX0bp/gviB6i9cfUzzMGEFUdQeoFuWGqPWUXWlhHU/GqLLaRBfTrymr6OJkzhzfIdnemM+dmJabOoqKgolq2gtupodoLNx9pKbDJL+SR8h6q/yFEkh3vAk89p4II/rPndMqprwNRyLOY+ZVf0u20TzBNqLLUG9LlA+Q9MPaVaTAloVJOadZmEIhy3R8Y7pwF6RZIZ6eFcsHa058Uhg7kETVlu6d+mdF+RaIaqHkO6essSlSxJr7/LNmCBLvpwddu/bEiJ6wHqzNkRz90nicWVSEBEoJ0hrST/mnfRv5vsCU15V5yVEEEb8v3DROO6VpP4FwTNwj60kZlgX8XQTgsc0j8jkZv/dUV++t5x3L9NBIpA3xdHIQrAq4oZF3RGBsXK2ycjsbgEc0JxwXxyH5KVo3a7zBSRnoLFu9GN5tS6tdXiD+CXyNgXWKTvwL0B441jTQM54EJTr+lNNZOryYCNOVFqNBcTXgio08leJgEN7ZAD2CiQgwxm3aVeZkBKa/s+68EMOZ1aOkgl4rmwpUz18zGNL4jogUReGsDout4zev6MePPD3ZU+g8IIaQ66d2J7+ER1+RsMUU2m6ItLkd31g02BnfQqS4Atmx7kf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BJNEVKTitSUVB1R0xrcnE5UmVlZ1gySDliQjhnQlJHUUlrRWNFZk5tcXJP?=
 =?utf-8?B?RndnRlVzUkM3MndPbndxYklMK1UzQ2dhbmRpWnVoYk1IcXlpcGtUNG01RXI0?=
 =?utf-8?B?RVBWRXduWnMxeWdUK2dYQ2hPd3BzUHdEbmV3aXQzSnlXOVNLNjFjN3laYlhB?=
 =?utf-8?B?Z1h5b0s4NmZPVjNJRVI4YzcvcHU2OXN1S253YXc1aXcxSzRweTV2Rm9Lakpv?=
 =?utf-8?B?QUZiK2EzRXNZNmswd1Bjc1JqTjZLTnYvdEU4b2NrV202dHJVR0ZITS9iV3M4?=
 =?utf-8?B?NGVDTzhFem9nOGtZeW9FZ3YvUzFxaHIvMEhyamVlR0ltVERIenZTbVVaQW9F?=
 =?utf-8?B?UUV0disreUZiM2JldzA5ckRlSG5QU2FjSU1jOVV2ejJXVTFkTzNQc0xkbFhV?=
 =?utf-8?B?TEQxRllPS1FFeTRaeUdKV0t3NjdtWnB6bmNTNENYaCsyR3JLMHFOUUQ5Wnc2?=
 =?utf-8?B?amNFSWZRNmpSc1ZmeTZUQlFwUlNrL3FiQWlYSGY5ekpjVGE5Wm1rTHFJdVo1?=
 =?utf-8?B?ZnNlVERPc24wSUdDVHpTT2Q4R3FpOUFiKzNIazFZeEtDUmhFeDAxQ2s1QzhB?=
 =?utf-8?B?eC9nMzJSK0tNdG1nRmhxOEwzRjVzZUFIbE5GZW1WQk9ZVnE1Z295NDc1ZUZV?=
 =?utf-8?B?cDJMalNUUFBXckJ1Z0QxdDM1U2dSVVpuUWpUWjNZR1JyeTVvT2ZvaERzaHdD?=
 =?utf-8?B?S3R6L203TVVtakpyOGg1QmJoR055Z2wybmpCemUvSThPNGVwNUJHSDJiQTJr?=
 =?utf-8?B?RnhnZkRjT0dhUXg5M2RWbE52aVRjQnhhdGIzV2ozaFJGVEw5cHE5V2R0WnBt?=
 =?utf-8?B?NWZHTFRQeXgwa2Y1QW1mdS9ERUdVU3pIMDNJeC94ajdISlYxaUN6ZEtZQ3hQ?=
 =?utf-8?B?ZjhibUNVVzM3TjVKSFhtTndFd3Bydk1wOU1GRVIydHRNZCtQUFhtTHdJQ2RC?=
 =?utf-8?B?VEgyR2N1QWxJaE5GanBQWlJCWWZJQVdSd1dob29qT2xkdDhLb25zVTBJK2Vk?=
 =?utf-8?B?TG56ZktsQzk4dDB1cVRna0lqdmlNVWd5SEp5N2NCWlJyamNnODVhUkNrZkR3?=
 =?utf-8?B?YzEwbU5nd0dyU1lDMzJBK0JrcnM1TjNodlN2NHFuT0U4cTl5b0dSUnFkN3dh?=
 =?utf-8?B?WHA5SHNhei9ONkVOWVNkWTZvNUJadTU0R2tRY1VNZzVXd2ZJVzc0WXZsQ2Vw?=
 =?utf-8?B?cmZta0s5WXEyQnF4UmNkM213RXFvWGVYK2xyMjdPS1RMSGJrOTlaQjdzbHlC?=
 =?utf-8?B?TUwyN1lGRTlGaFM2Qml5ZzViWnFpTW11UVNmcVlKRTFZTnNlVmpDNGk5UUF2?=
 =?utf-8?B?MzRhbnhPOHRDa3h3Wkt6UWtRaGhrc2UyMGlTY2dkWTlvbmIzVU5JbEgzSVF0?=
 =?utf-8?B?M3dEeExpN040YWRwZS9NWVBPaStqRUY1OHh1bklTQ25sZ25hanREejQ4Y1dT?=
 =?utf-8?B?aDY4NTM5dHVUb1FIVGw5S1hRdE91bHZYUW12SVV3bjZER1VMQXVGdlZUb0l0?=
 =?utf-8?B?a2l0Y0Q4bzdTSGJIMDVjTTMvUEFGUmVJUm9GN1k2eWJxbFVQNkJzbEV6NHhH?=
 =?utf-8?B?NEdya3ZaKzAyOGxPbHNJOTBwM0NQMklBM01XdEpISDAza09uN3JqM1FoTjA3?=
 =?utf-8?B?QzR6VVdhWmVVWGd6cnp5RXlMS3JyY0RneDZWejNBSS9PVFVzemgxRU9ITzJw?=
 =?utf-8?B?OHgxQWxlZlZMYVQraElhdmFpNURoUDk4WVlwTkhpMHc2MDVIc1VzbGxMYk5S?=
 =?utf-8?B?Y2ozMWRRUDU4dnJOc2hFRUovZEx5UXdmRUNKUG15LzBjaUdaRk5qdDIxVzNu?=
 =?utf-8?B?Y3BYSmZjRWF0NzRvd294bEdUK21POHR4MFhudjBxdzRmdGRVdVowNjRib3Zh?=
 =?utf-8?B?THc0NEdGcXNpM2RIOG0xSlBiaERnNUF2OVZzUFhPeDlabUFRWFhIT0Z6UEN1?=
 =?utf-8?B?TGdXZVRMNGVUa0duYm1DTjdhNFM0dEYyZUwyZjFhVjRlK0p0TFd5NExTWG96?=
 =?utf-8?B?c0hHSCs0ekl6S094dXp6eDhENjM0ZW02L0k0cVEwZFlkeFFKMXMrcHpFYy9W?=
 =?utf-8?B?ZXR3WWtibU0ySzNZSkFaQ0E4SzIzWnlvY1JyWHNIZ1NWMENsTG5Zd0xNYU5H?=
 =?utf-8?B?dzZaOG5ZZGF2a0o0aUNCMTVtczc5MXJ3UlliaktNZ2IvZXZTdWZJOTlkNkd1?=
 =?utf-8?B?d1kzdXhzcVhKU2lsU1NRNEtLZEFqVVNYZGZWMkdkbkxYYWRSMVB3K0ljM1g4?=
 =?utf-8?B?amFxbFlMUUd6R1dBU1E2ZUNXR3orRXBPNmZna2I2azRLUWUvYkJ2NTM4TVZu?=
 =?utf-8?B?RzZsUnV6SVpVTklqWnBRT0k3SlpUZG5Hdnoxem1STVJ2MlhCNzBJN0VDS3kv?=
 =?utf-8?Q?/IqkGNl7T6xeAmv0=3D?=
X-Exchange-RoutingPolicyChecked: ksWCklL6nhsi2awMTXuZI6NliUqjXMtjTFXEaa53Mw1Q8pcP0tXfMrPEzgBhnIH+ct6rqYSauZM6TZBDB/CpUGBX7xsbkpmLKjlWk3N6DU+dpD7DQtqBmBrdE03gPqsOKNWKld61NLv9L/F+A9TG4jmsZYkwgr9WIe08J7aDSD7GvcRjk2PPzBpqi3J3ZA1mWJJiRnrSM8E4B4+eZsTx8uXmUBkUBZYwD3qq+FVVdw9zraGfBMn3pyFFIOesVvv+Qn3ml3vysMQq4XiUqZs0RiHrZBcjviRMB1c3QBkLzgC9QNg/WkA4f7ycAgemrHMQZL1tl7eE4mkQrHiCYvoURA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e96bace-875a-41d2-2785-08dede68e564
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:52:04.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSgSOzFpw0Y1j7IfwmiLnRKzOpQR/ttwZOyiQTCDiak7HQfnYR+1KMbA/rWANKLX/efwPbV2oo3WFzbk+A1IcE1tIa6prrenG8GPJpyXiZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lilinmao@kylinos.cn,m:horms@kernel.org,m:mgreer@animalcreek.com,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E26ED7394B4

On 7/10/26 08:12, Linmao Li wrote:
> digital_wq_cmd_complete() dumps the response data whenever cmd->resp is
> not an error pointer.  However, a driver can legitimately complete a
> command with no response skb at all.
> 
> digital_tg_send_psl_res() is the only caller that passes timeout=0,
> meaning no response is expected once the command has been transmitted.
> On that path trf7970a completes the command with
> 
> 	trf->rx_skb = ERR_PTR(0);
> 
> which evaluates to NULL.  IS_ERR(NULL) is false, so the NULL response
> passes the !IS_ERR() check and cmd->resp->data and cmd->resp->len are
> dereferenced whenever the debug print site is enabled.  The driver
> guards its own dump with "trf->rx_skb && !IS_ERR(trf->rx_skb)"; the
> digital layer is missing the NULL half of that test.
> 
> Use IS_ERR_OR_NULL() so that NULL responses are skipped as well.  The
> callback on that path, digital_tg_send_psl_res_complete(), never
> dereferences resp and dev_kfree_skb() accepts NULL, so only the debug
> dump needs fixing.
> 
> Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> A separate cleanup patch, "nfc: trf7970a: Use NULL when no response is
> expected", replaces that ERR_PTR(0) with a plain NULL.  It does not
> change behaviour (ERR_PTR(0) is NULL), so this fix is needed either way;
> if that patch lands first, read "trf->rx_skb = NULL;" above.
> 
> Link: https://patch.msgid.link/20260706075743.564658-1-lilinmao@kylinos.cn
> 
>   net/nfc/digital_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
> index 7cb1e6aaae90..18236221d898 100644
> --- a/net/nfc/digital_core.c
> +++ b/net/nfc/digital_core.c
> @@ -127,7 +127,7 @@ static void digital_wq_cmd_complete(struct work_struct *work)
>   
>   	mutex_unlock(&ddev->cmd_lock);
>   
> -	if (!IS_ERR(cmd->resp))
> +	if (!IS_ERR_OR_NULL(cmd->resp))
>   		print_hex_dump_debug("DIGITAL RX: ", DUMP_PREFIX_NONE, 16, 1,
>   				     cmd->resp->data, cmd->resp->len, false);
>   


