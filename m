Return-Path: <netdev+bounces-152619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BE9F4E3B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1526F18895B3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBE41F709A;
	Tue, 17 Dec 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lx4xYJZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A681F7065;
	Tue, 17 Dec 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446952; cv=fail; b=DobBNVa0EnR501VGLvsBskjhv/U2vSP2XPeSG2Z0Od2nBNx50Kv+OcpRPZzCc8/DCik4uix5B0rA1u2XWSMen8wI0wtAr1XjIn6Y62hp894VZZ6aXYixawHKzLatK6H5DE67xBs360/jYXs55nLexy6VnC5FzjB/1u1TLeEWVA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446952; c=relaxed/simple;
	bh=IBXEdJsW50m4ECLro+iuJ2utiodli+FieSYJeCEHXU8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRJAq1Vobo2di0LaIyqQYdp2C3MXgX6Jfyz+Me5Bb9rNkR9/Ixs3p1e/0Tn1gm8LSBwQq2lXEAPWQiOcLjqbW/dqtHKcLfZeHUdkpa6lR25LDOLKoTJd7lqnzQp0kCUtfJP5J6IpsaHJCGb8V9xmnSMXyLBVKur/5I15LN5Qo5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lx4xYJZ4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734446951; x=1765982951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IBXEdJsW50m4ECLro+iuJ2utiodli+FieSYJeCEHXU8=;
  b=Lx4xYJZ4JBeDgXhwbria89hSZHFWx2ki31rfXOdngc/IBWgxamAnnvRj
   BIUCWlOtp/MmLUbYgU10Bc0UtKhnDtcoKHXH1DWcZczvMLxb41U3UAUai
   Kq8qMQwN0wMPhZG+u4e0X6kYWlzAq+H0X10Ubnuw7wNh53k4xBzIcepKb
   7Z79Fgzb8iKNsShRXrqBqN1no4oHqdFzreVbZVrJGAhjp1oO6KWZTd+Z4
   5R+jKUIjvFcVjAICsGqmRhq2BBRJZvk88hdAjWSYJO2nocIfqpdTt2aIG
   YDHeSN7rSIrSVJKq6tZfYn+BIBGqtVz2vFCxlAFyLJ5+t243mSzHVXSkO
   A==;
X-CSE-ConnectionGUID: 5iritld6TBe1RVx+SSmtww==
X-CSE-MsgGUID: uLKnUoNoS9+ct+ExneTP7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35005036"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="35005036"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 06:49:10 -0800
X-CSE-ConnectionGUID: cvTJrCOQQUyjVI/ZJyZlmQ==
X-CSE-MsgGUID: t6qvkiVMSMCBkTqv86V1lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134898566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 06:49:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 06:49:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 06:49:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 06:49:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asp18s5s2BodCUu22UZpV5lLafXmHZ0gP8ZqGHb5mdJfxSQaKiithCv3g597+7l/eEikmVnSXhxlvaTZQqze4GeqdfOoPYKBz7pf/q6D4qBywIvqGQA6wISTGcA8HeCw1pCyP0D/WUxwSSFNofZy8ksG3vqzpbGKbeOOzPWmIJgpIrCXihVq31EMBUhPr0+u7BWDGDYlE/vBifwoGOgAKCnkV7SUbKhr+mXAs2gdZCrEmAXoj/suHDcAoE92tm5vnDkvu9o5JeIOkd7StoPwQW7aCdVEYhM7LXz+yNJzxXO6UnL8iohUrd8UCbUDzs0GXIke3Ik7GyC9vsS/OK/bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0q8xhoC9YAP0p2n7CBq1cOX2d/1uFwS5AIsDkWJfS4=;
 b=fmUh08QZ39OavWMQcZq4sUD2HtSaX0M9ncPDsd4lqv8Wkc9BxGeS8ezhTkys//Tn9ZtRV36la2EiQ6W8eySUKU871NwncCZSBavpPfBOP/e26VFgNS3C56ipUTrhzfOLuCRSBqSisOsd8GSjstdLgNEj4vQXGRHkDqknQOnBAO24Bbmlpk0x6Cts/JJK9YuI/AO2I8ctu1eBk6rO8DY1mjfrNRA14BYqKUB/CaRAN0jz/PO0Nv+nzB5InPWEyLGiykWhCkhAkKsflJs9ZdhkxddWUZJgZ9b2fqU2H68H9/HeqTF/BtcVSARTQFlWmSebfW7dstq8Nqo/VxTKmxnvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 14:49:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:49:03 +0000
Message-ID: <aa49d578-dee4-4ee8-b17b-b6e941d9126c@intel.com>
Date: Tue, 17 Dec 2024 15:48:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [net-next] ice: expose non_eop_descs to ethtool
To: Jon Maxwell <jmaxwell37@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241216234850.494198-1-jmaxwell37@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241216234850.494198-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 324abff2-d8e3-412f-9613-08dd1ea9f2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWNUSWQwK0RZNVBYWmRzLzJSL0grc1gza3ZCMkI2bUFxblVFWnQzM0lBOXB0?=
 =?utf-8?B?eDIwMEtFVGtQbE0yeHRUem5CQWpNQzh3T2loY1RIKzkydFkwZDJPZjU2Zlpr?=
 =?utf-8?B?cjFUV2tqdTlJTkljU1ErNDhKd09Vd1VNZHdGbWJlQnVuR1hEL0VDMlg5V3ZV?=
 =?utf-8?B?LzVSY3EyNlhDdkJtWVhBMWRremhXVWtCS0JSa2hmYzlQUDRjRjJqUnBna3dS?=
 =?utf-8?B?ZkViaGJnOEtINU1KbTMzY3FFamt2Q0xPdHJXUXhDVFB0QWo2UjhPZmtmcHg2?=
 =?utf-8?B?OUhFUXZyc0VSQ1lJc0tDc0M3QmlqNnAzcDIxVytFS2FmbFZ3bmRzNWpUeG85?=
 =?utf-8?B?RnloekMwbDk2UTNFZHlwWDE2N2JzRmdZcFg2K3dpK2RJQ0NRcDlMamdQd2pW?=
 =?utf-8?B?aVppSGM5Yk41K3I3U3FzMDQ2S0JkVVZVV2V4K1N0VlMrRFVoeFlZdWdXLzNL?=
 =?utf-8?B?alpzSXB5WERJcXc0M3dpSkNQKzBIZkw4RWw2Vk13T0xrdEh4NjFuK1VBT2hX?=
 =?utf-8?B?RS83TVdNbzZoa3VDMmwzNTV1UCtMOEYyeGJSNXQ5SkFrSFJHRk1BV1hxcmx0?=
 =?utf-8?B?VlBsYU1wZXByTmhPSXg4NS9zaWtzZVFuaFQrUkNLTXFoRXV5WSsvRUlQNE80?=
 =?utf-8?B?dFhQWURxTWJMQkx2VHJvdlE1cXFSZFVmWWtid2xZR1V4V2w3N2xLZDhVS3d6?=
 =?utf-8?B?cTB2aURlbjM2SmE4Mk5VVUc1ODJBd21BRy85ME4ybENxZlE2RzNwZ0t6NnVm?=
 =?utf-8?B?dmVZMXhHV1RHYWx4dy95bG1wMG9FZk1TTWlFYkdZNFlzcCs5RmpkRVB4amU5?=
 =?utf-8?B?YWhjdCtjNXFvOWM2K3Fmc1FNNlQ3UlROcGlMdXg0MVNpd1B1SWlkRnc1cHJJ?=
 =?utf-8?B?NURCSXl6WTVZcXJUaks2TGVJZDFtR0Z5bjdJK3NZNWpUVmtnL1MrYS9RZURM?=
 =?utf-8?B?UktZQ3hZdWRzbWJnaGVwVERQTEVCTWRCMnRtQ08xNFJ5dExidnVFQkZwNkVn?=
 =?utf-8?B?YXF4TTROR2F2STlQOTZIa0V5WTJpdkFYZmtCL2ozODNPVU5WVnd6d2hya1E5?=
 =?utf-8?B?VmkvY3RwRE4reldJVEFIK2lYZnE1L1BsdGtwZHpEM2xqbmluQm9CMU9nazU1?=
 =?utf-8?B?eHcyd2xaRHE1RlpYT1VQY1hyVnpjN0tYaWFhZW0xZlNlTHZ6Y05uTEhQSkxo?=
 =?utf-8?B?MDh2eHBBeHpWSCthVnhqVUhQcm0zNGZuM3BCRHNwVUUwS3lNUTljUXQrUDhB?=
 =?utf-8?B?dVFKU2JVM1hkRVNMb1c5RzZGRWRMZ2t0dTkxZGkxK0N3SHBhMnZCUDNqUXRp?=
 =?utf-8?B?TTdPdENrVDhYNWc0dEZGakIzZVVBQ3JxeHpDWFFlMi9CN2Y5STV0NkxnNTBw?=
 =?utf-8?B?cU1kOHZTL2Z0OG9UcGFUOGlsUjdQa0ZzcFFudkFHR0NZRmtXbm12SUhHQTI2?=
 =?utf-8?B?MFNveDIzZXNKbVhGVUNKTjhmQjNBYk85T0hPbHpIcyt0aXZRVDBGVEFPNk92?=
 =?utf-8?B?N3FDY2pIR0lWcVNUVUVoU3kzdkNSQkdiUndTYkNUME1ZcXBYZ0lRV091aEJK?=
 =?utf-8?B?MUR6YVdSTGtyWUdnR1Njb1NtdU5TbWREdEVaNU5PbUJxVlF4TkFQMENtR0Js?=
 =?utf-8?B?ZENGaUNrWGcrSGN1M0VLa1UzbDRsVDB3YmV4Y1dQVHJYZVFjVFBLUDVRYXVo?=
 =?utf-8?B?MEJkczJRaW9HQlVHdys0WCtIZEVDRTVyR2hNam1yVU9yNXJMYlhMeHpIQ1Nm?=
 =?utf-8?B?K09RN1N2cjU5L1B4OHV0ckJERnNaMUxWdmZVZ0JRR2dsSWFpcXJJR01aMDJx?=
 =?utf-8?Q?KKTIbOBLkwkPPKo/w7YMh3aJDmAD9ZpqtvxCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJxVGtoUzBaMHhUMDVoYzlGVlhFcW5zNkhBT0Z5eVRIUG0vNXZVOFNMZXRY?=
 =?utf-8?B?VURLeExHL3JmTEdiQWZFWER4UXdMclczVTgvYjhSUWtpcG40R1VrTGR4M1hm?=
 =?utf-8?B?UlJ6UUJLcW1mRnU0SXp1WE1naS9PSDVKazZ3T2Q4VS9zVFhiUVQyK25CWGs3?=
 =?utf-8?B?cCtUVWdEYTFQUkRRRDlwOW1OZlNyOHMwRzFtU3ZwNjhIQ1hiZ0JDdm5GZmgz?=
 =?utf-8?B?ZVRYRTBicTQ0YWhqa3MxdnRoOGhndlJkQ1pBeG0zZmhZZmF1LzI5bU5UYTBK?=
 =?utf-8?B?eFVVZlFCS2dhUzFRS0FRaU9KcERMK0R1YU8wQlFpakNocWIwZDFxaURSa2hw?=
 =?utf-8?B?ZExzNzhwM1dyUEpvVnhsa2hvOXNPV25HaXZEMUdobExhMzQwMFd5R0ptdjFS?=
 =?utf-8?B?TWlHZ21kRzR2b1FMK1lBU295WHlnamk4dkJVQldrcWN2M0EzZUlnWktpUHhI?=
 =?utf-8?B?NEFxME96OWEzY2wrNEd6Q1Mrakt2RUxqU1hFQk1xNG5QUUtFQjFXbXBua3F3?=
 =?utf-8?B?ckUyM0ZmamhLWEkrVjdWVVZnT2hYd2ZiZGVORjVvN1JQd3NvYmFIWGlHQlNN?=
 =?utf-8?B?M2VrcElSeWNObk84TFdpR1UyQkpnM1FEWktLbXJxSVNQR0Qra2p4blJWS2hG?=
 =?utf-8?B?MGNnR3BHc0lSNTFCd0V5REZNbkJPT08zbnM5bWUrWWFtMVhvT0VqMTRISkJM?=
 =?utf-8?B?d2tTZEl3OGV2by8xRHYweUZDYzhiQW5QYXlFbEUzTUpGVHBJNkkxRmxrN3hr?=
 =?utf-8?B?bG5DMFhLcFBHbytxejFBQjFCckh5MVprMTJYYUJvOXpzbS9sOWFadnRncFhY?=
 =?utf-8?B?Vlk0bUZaZENDdm9VdDlhQzkxM01wUmgxSVAvczIzTjQ4UGZRalMwVGU5VTJJ?=
 =?utf-8?B?QktZaW96Zkxtazk2Q29UTVkyUTRxQ3FkMmthVGZ0SDRXNENVaWVIaXU1SDB2?=
 =?utf-8?B?eWU4R1dZVWRqVnB2VEcxRkFlbFNXemZiZTJOYVZHM3k4YlViWlhFRWdlME8x?=
 =?utf-8?B?TlE5TWx4SVRBS1RnQjBlT2YwSkhTakFyZ2Z5TUpRSTMrMzhCVEpWRFMxdDdy?=
 =?utf-8?B?U0ljcTZvRllPSlFnbzhncjRENCtvNnU4QzBKMG1MUjBxcEJ4QlJYS0RRVGlm?=
 =?utf-8?B?dGdCYjRXOXJQZjNOWWpLc0MrbmRGdmg2NkVUQzlSckh0czgvaHM2UjZsZDdW?=
 =?utf-8?B?ZXROdm9WZGY0WGszQ2tjRW4zRFZBTktYOHg5ZE93eEdaNGRmTGh1aEIzbjl6?=
 =?utf-8?B?ZlREU2hhSmp5WldoUzlDeW82VkZxckROeHplM3FaQXZlbkdaMEpBbGI1Z0NC?=
 =?utf-8?B?UVJmcnpqQzM4Y0pXNkVVRFJHdFk1V3ZHamFpZ1g3WlU0dVBtUDdEUi9aTlgx?=
 =?utf-8?B?TkorZkNpblFEMzNpN3JIemFCcTlYY1FnaTRSaXdmd0pvdVVnT3JlU2t1c2pi?=
 =?utf-8?B?V2I3dWd1UUV2NDRjM2hnS0RyUnhvVThQdTdub21NRUxsTHozNFNIckNYVGw1?=
 =?utf-8?B?c2cramQ1aHZZK1JLQlZnZ1Z5WWlUYWFJeG5OYjV6WGRoT0NPZ0QrMEdoZnJ2?=
 =?utf-8?B?Q2szOWdWeWVWa2h6OFp6TmJyT2FWc29vTVoxSE5lS2pkYTB1WDNHb1ZWZ1hn?=
 =?utf-8?B?M2o0eDdpc05zTnhCU21JZzRvREh0eklyZWw4WEdjUGdaZHNQbDgvVzhZenRM?=
 =?utf-8?B?ZCtOQUp5OEdzS1ZhVk1tSk4zcFNJazBEUHcxbklnV1g4RHpuTEVrcTZKRGNh?=
 =?utf-8?B?WnFDZXkxREY3OGxDTTREM1lnQTVIWXMwemhzd1gwKzhYYWtDcWdyNUxuL1dj?=
 =?utf-8?B?WGhPanVtREV4R29sbTZtMDFHRmYzSlZJTVdsek5mMG9waENhTjl6ek1YNDFu?=
 =?utf-8?B?NzlOcVZjVk92ZHJSSG1YSHdzSklUQjFWNy9FSzE2WkpaNHNYK0lLRUh4a1Aw?=
 =?utf-8?B?TFVnM0poRVdLQi8vd3VMSlJ4am9tbzFDUVJrblkxM0J1RWt6NlpXUTJPQmg5?=
 =?utf-8?B?amhUT0MyWmM5bmpVcTcvRzJ5WGo4aFBWWTVWNkVva2FyWllDWitYdU1xR3hM?=
 =?utf-8?B?WExCY3Fwa0lHWk8yeFFkSkdQUy9nVmpocnZSWDd3YWRzQ0ZpZXc0QUM3RGpq?=
 =?utf-8?B?NFNTekVabHl1Y2FkK3M5eWJ4b204a3dNMHZxclJtdngzaEFjMmNmSkk2QW4w?=
 =?utf-8?Q?ZUbdKR7/QSqocXvuERPj+Es=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 324abff2-d8e3-412f-9613-08dd1ea9f2d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:49:03.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGyfa6DmEyCsQtw1UBQYyVpGMHYncqD1otdjn+4IPtspta1tGw7iZ4TjRfSwDUdWGllb7f71SewxdoaHTQNsynC9kpjtBy0dmWYKfbqd2VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com

From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Tue, 17 Dec 2024 10:48:50 +1100

> The ixgbe driver exposes non_eop_descs to ethtool. Do the same for ice.

Only due to that?
Why would we need it in the first place?

> 
> With this patch:
> 
> ethtool -S ens2f0np0 | grep non_eop_descs
>      non_eop_descs: 956719320
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 2f5d6f974185..8ff94400864e 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -345,6 +345,7 @@ struct ice_vsi {
>  	u32 rx_buf_failed;
>  	u32 rx_page_failed;
>  	u16 num_q_vectors;
> +	u64 non_eop_descs;
>  	/* tell if only dynamic irq allocation is allowed */
>  	bool irq_dyn_alloc;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 3072634bf049..e85b664fa647 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -65,6 +65,7 @@ static const struct ice_stats ice_gstrings_vsi_stats[] = {
>  	ICE_VSI_STAT("tx_linearize", tx_linearize),
>  	ICE_VSI_STAT("tx_busy", tx_busy),
>  	ICE_VSI_STAT("tx_restart", tx_restart),
> +	ICE_VSI_STAT("non_eop_descs", non_eop_descs),
>  };
>  
>  enum ice_ethtool_test_id {
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 0ab35607e5d5..948c38c0770b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6896,6 +6896,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
>  	vsi->tx_linearize = 0;
>  	vsi->rx_buf_failed = 0;
>  	vsi->rx_page_failed = 0;
> +	vsi->non_eop_descs = 0;
>  
>  	rcu_read_lock();
>  
> @@ -6916,6 +6917,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
>  		vsi_stats->rx_bytes += bytes;
>  		vsi->rx_buf_failed += ring_stats->rx_stats.alloc_buf_failed;
>  		vsi->rx_page_failed += ring_stats->rx_stats.alloc_page_failed;
> +		vsi->non_eop_descs += ring_stats->rx_stats.non_eop_descs;
>  	}
>  
>  	/* update XDP Tx rings counters */

Thanks,
Olek

