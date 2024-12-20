Return-Path: <netdev+bounces-153705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB19F9434
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CBE169C9C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73BB215F56;
	Fri, 20 Dec 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhIDEtup"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F11C4A05
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704626; cv=fail; b=hZqJttZv8yw1Tj/GwLdxmagUT4Didilx19SVQyw/wNgWDr5frVWJFvxy2M6UGe9MMVFskQzqnMCgrlFb7TMxgytqsnJpq3WEy8WKO9ZJJhXDxPwt0x7+pREz5hbwhdYK9bIwYyQhFGoLoGc96r11YO6ITxqlVQH0X4fsAFgebzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704626; c=relaxed/simple;
	bh=140vdYtFFtnvCKQebgaqkvoN2Ii/CZABM2Yq44wql74=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHJDdiJeLDHomUooXb3PRN1KPlxmNdS9SFmyoYU7LW6sSE+ok9B0QsnzKu+cSyzWU+yeDFJ60dAyPR5tM/tFNNcWRZ0X1Hkuziu51tZqovkspohKNbW2IX0ToKsDHE3qrqs4RES8V+4N9eH4KeTvWO/Eq6S44gi2o9pN9KvcKk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhIDEtup; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734704625; x=1766240625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=140vdYtFFtnvCKQebgaqkvoN2Ii/CZABM2Yq44wql74=;
  b=LhIDEtupFKDOziAI80f2laMWmSJkf5mibt990S0D6JP6Ftyk+xsy4/pV
   oqE2tpq2gc4Dq9vGRw7hIhEgAwCpR3Uc/hqf1GfxXNl/+DizMWoer823n
   x8Zvc9Et5hMj1hqXF38OZVs2CWeXsGD3LbZTvmLjrj83vEjJOedPi9eUz
   3/oVRAjSZgbpJ3pyiIFM49DQh2TRJKG00JD17dEGuIsB598gHjmz3GpPp
   CZgcDzoZlacuOWjS51Rj9CInUQLEdi6WCKGykdJ5Ig6RoQuzF5gRMSUjc
   kKcwtseSN53cT4RrWdz4ilm8FRx/G86u97yJwhVnZRcEDWR1CP6q/RmxY
   A==;
X-CSE-ConnectionGUID: yRB6fxiARwKV+TVu/+Nw1w==
X-CSE-MsgGUID: U9LO44iJQzmhzbDao/Wwyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35469454"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35469454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 06:23:44 -0800
X-CSE-ConnectionGUID: QAEdllRTSAyeab+0C7SGZQ==
X-CSE-MsgGUID: t/sbNIlmRtmoN1/sSD3cLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="103506293"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 06:23:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 06:23:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 06:23:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 06:23:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLvRsFQtcoD5I7oxqLfGLHShPNddbYrE8JQtrlKZM8Z/Flaju1BGhGAZDWnp0ToG2ZfugPGvfZfD7g12DbIMgg7GyN8paYMPg+FgV+C70UdKfwPQH0n8x6OL1w9Js3ypyArpJlGC20QCzFKUC1suMnCclAEDqY4y7Xnk2giPwvG8gihZlVZ7Tx4cz0rvzhePg+9CZMfwJ5+QavJh7YPOInMe18WBznhrth6BR9Emx4JlojfRxT9391jF9vTuEZHQHDYs7Uz9ZmRHXGMU1KhKDGlyBr58wzUYbDN2Lpm3lZKADxj1IGs++baN6aJ46WaQ6wJTzlpFlLxeLzH/MTSy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A15z+QqvZLtwCqzifPqDFyQIJEiPjLURiIc5nMdPqsY=;
 b=QHX4h71sepysAvFbZGwfy/v2JKto2jyxxH+E0RWu22RvAsKsS0rXgcFmdSW0sA3EjUs/OA424YoKcqV9IvG2ex3vuY7q0ulYjXG7GnyEezOqYrAexgn2XnzNJlrqpA9rQnvf7sibxa6qAgxsrwsk7lEKhX+FyTazUE1ffTOmL8MQOqmCigwJYiiCYsphs6FA6xerM/5usi0QnR7/7f2b0ZPDG20/ESfe7g8OiEdmCRDPuhT6YQR/l+dMalkQBvYXYV86I2LhrPnePX10+rvvamB1Hf0+iFr2RsOZtooIf5bjgkFcT5zT2iwK0Wj7Zi41rxJJ49V7BcvuWYnGrWWnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 14:23:36 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:23:35 +0000
Message-ID: <51452dd7-a574-4bf7-9b5f-4939f7f189e4@intel.com>
Date: Fri, 20 Dec 2024 15:23:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/10] eth: fbnic: support querying RSS config
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexander Duyck <alexanderduyck@fb.com>, <netdev@vger.kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <20241220025241.1522781-1-kuba@kernel.org>
 <20241220025241.1522781-3-kuba@kernel.org>
 <aa36e48f-a54d-43df-979c-bb81a90257f0@intel.com>
 <20241220060807.6b5103a2@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220060807.6b5103a2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0211.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::32) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: d2197218-7542-4339-109f-08dd2101e366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmtTc0Nld3o2S2E0K3hJU1UraitLd21reUxMWWhUTTR1UnRHSzI0SVRkeWU4?=
 =?utf-8?B?UVFWbUJsNXI5Q05EbHpITVpXaVNDMklTdmFBMU9tOGd4aXpZWGR2aEdlaTZs?=
 =?utf-8?B?UHlZMmFrVnBDK2hMMlpIMHJhQTJlUDJwRVZPT1MrVENEVmx3WjZ2S285T3pP?=
 =?utf-8?B?ckFnTjZyUitYcGc4akFLVFRGOXRnL0JWMlh1Z0VYYWZXZExLNXpMVVhnbXV1?=
 =?utf-8?B?NlFORFh6NDFUbXhxMkNGcHpucDQ3dlgrR09XVE5hNVRqbXZIdnNNTUhYZW5i?=
 =?utf-8?B?V2FpdGg4THdwN0VGNWdxd0RESG5xSUU0cTk0V2NNbDdOVTgzd2xXZnZrUVhD?=
 =?utf-8?B?NnEveStSK3hDUnVnU29nTnJ3L2szdXRhczNTMWRLd2d5WXNoT0QxQUxxQklY?=
 =?utf-8?B?b2hIdkhyMWxqSG03TkM4bHFiUG1CYllaQVBNWDluZzBUQmN5WHhuSXkyL2dP?=
 =?utf-8?B?UjIzSUppMlFEeGZMa25oUjhEVjZ4MGFCR0JmZ3JZck9tZ3UvL3kxdUo3TWda?=
 =?utf-8?B?RkhPU3lsRVp2cDhDTmxtbXRmdTdhTmRaY2F3bEQ0NVZiMUo4QWtYbGFJbWNC?=
 =?utf-8?B?MUFZYTRUdWdDOXZHeHdUME42ZWVhRjBzVURobTk5WnRaajdtWmpUQUt0QUds?=
 =?utf-8?B?VUpMMk9CR09vWjlNdjRwbks1bnRjZ0pXRG5TVUg0b0RnVC9DUEFWK2JpS1h6?=
 =?utf-8?B?MDgzeUxvdW9DMHZUR1YxcktyQWs1dXM5UUR6LzZuK2hkUHE3YzdFbGRBRzQ0?=
 =?utf-8?B?U0NsSFFSK0ZEazkrYk9Pb3FUUW5QZFhzakE5a0JDZThrYWdkSXgvcElxNkNI?=
 =?utf-8?B?TGQvQ3VrTEVUakIxRTAwM3VwaHpuZW5kRklMeEtuQXlHWUF6Z1BsRjJvSFk2?=
 =?utf-8?B?NE9sak1Td1VDUlZiZktTVytsWVhZY2dvVXNQSGt3SllnYm5MMTd1RE1Yc0NI?=
 =?utf-8?B?Uk9yWVJrOWE1dHdDMkxQVlFaM2o3RGpsS0xOWFFVaFhvcGZqL0FyQnFIcXBP?=
 =?utf-8?B?Y25iMDJHeC9yREM2ZWE5YmRMSHRtNlk0OEcreVczeFF1QkQ0eElPSldETjNC?=
 =?utf-8?B?eEZUVW1kNUo5TnNGZ1hZcUw0NGdMZTROY0VvcmlvYkNMNmgvMXlMTXhlWkhV?=
 =?utf-8?B?M241L2RjUkI5cmV6T1Zpc1BhK2RMQ3BDWVFZbUcrRk84TWdmVWhMZVFkVWZP?=
 =?utf-8?B?b3hodnZEU0VkL01PcHlOUENLSzdsa0EzbFpWZTQ5M1dGUXF5Y3hEY1daWmxG?=
 =?utf-8?B?S1NsTGtFVmZBQzNpOGp5TjJnTURLRGFSeW5UZklsQmNBTFFYRnRlYjVDWlBB?=
 =?utf-8?B?YVF3TUFUdGkyNzB6K3ZnbDRwVEQ0VDR2YXdQMFMrb2laSjRUaHZEKzlkb3F5?=
 =?utf-8?B?U2p0ck1hQ0dmbEhWNE1UblVTeEhHK2JvZ1BvcGpZb3NRcUdGOGNJU08zeFdh?=
 =?utf-8?B?UWZEKytWZjFIclJjNFcvWVNwRXhVb2FIZlEwWkE0TXlWYkJIVGtaUkh5Y1Bm?=
 =?utf-8?B?OXZkcjUyWHZZd3BpazVMSFIzN2RTTzFudmFBV2F5SnVWdFpyYkdqaUlXeFVR?=
 =?utf-8?B?c3FpY2FHM2sway9oZFg2SURzM1RCdnlSeUpMZWdPTWFrdEV1QlM2L0FJa3dS?=
 =?utf-8?B?RVR2cnBGOGJrRTJJdE10bEhtYUZTZHB4QzZhOWZXM3J2ZDRXMEp2VGh1MkZU?=
 =?utf-8?B?THZKbzNmZW9YRXB1bmZ4QWVwNmVDQmN4TTd0S25XK2VZSFJxTExJYXpPc3hs?=
 =?utf-8?B?UmdDeHUrS0tTWEo3QmxROWFwOFlqckRaOWZmM29xNUNZaGlic3BhTkRtRWEx?=
 =?utf-8?B?SGQyUW14MHFDNE5WMWFnaVFMVEJteFlOU0kwMW5BNDNXQUNmT1RCL082dnE1?=
 =?utf-8?Q?ka+ukY6MLTXZ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFDTXV2ME15NHYyNkhZWFoxMGZpRW9nTEIrQldiaHlQb09wWUY4MVZZMVh1?=
 =?utf-8?B?VUkrVzBoeEM3SjB4anZkT3dPY0ZoYkp6cCtrSTJLQzVPeE8vUm5ZQlRIak5R?=
 =?utf-8?B?bXU2V3liK2NwQnE5WlowNEpmOW0vcURuWHE2N29TajAwM2dXN0lrUHZuSFo4?=
 =?utf-8?B?ZEdLaGJ5MCtWU3hBREYrRitja2FIN3o5YUowQmVTTWJSQXM1bW9aOVRQZzRQ?=
 =?utf-8?B?cFloQk9hOWRPTmNFN0hsVFRxa2x5SVh3bDN3UHg3azdweFkzQll3QXZPRVFu?=
 =?utf-8?B?RjhIbzlmQVozamJwckNHT0w3RWVXTEkzMjE5bjJyU3B1YyszQjNDaktBVzZ6?=
 =?utf-8?B?QXplbmdzbHpKeXFkelZGUXNuQU1TcXJoVVRyNStGRytEbHhwSEJWY0NML25B?=
 =?utf-8?B?M2tUSTFDb3o2N05RbzNQWHVPbTlYZFlDSk9JYlFWK1F3bS8xMWRxYzh6VzJn?=
 =?utf-8?B?MEU5M2l3cmJMSkMzblFmdTlGa2pvSGt0QWRuQUNPT1FNWHRhZStDejUzNExs?=
 =?utf-8?B?NThCQVVPTmJDeUxwWUZiZjIwK2hleWFNV2t5cUtMeTFiMkYveWVTdk9GbzBn?=
 =?utf-8?B?eXpjRWx4ZlJ4VG1PU3FVVTNndm9WYVdCNGU4SjRST1NnUWRNWFp1MnRyeHRF?=
 =?utf-8?B?L0xLRVVzaGE0eW1SLy9sR0lwa0VVS0s4MkFGMjk3a2l6ZTJIL1VtazZFVmx6?=
 =?utf-8?B?bGpsNzVsMUt6emJHNFROV3NNMVd6U2xIekNKVDR0MWFybG9rQWNKUnp4NTB6?=
 =?utf-8?B?eFVtN084YWZ1QmpVRi9vbHlNQ2tUbVlKUC8yQzlwNUF4dGk3YXZUZGp5VHUz?=
 =?utf-8?B?bjQ1NjRTQVd6cjE5TEJtYVRTODh2cHYrNER1S2VpcjVwUk41UUhXeTRxcy9S?=
 =?utf-8?B?aDZCdW9XKzdSRE1oek03REhaRFUvMjQrMDNOblhBMkhURjc5Mys3MVpuandt?=
 =?utf-8?B?U1BaY3NJb09mVzVJZ2pzUGt3OTlsY1NuYlVTcUVmNW9XQ0RsZnk5djJpTXlh?=
 =?utf-8?B?OXBraXMzbG1xRE8rcjRCQXZsRGdsZUNzaWg5UHVQN3hUMXY1OHIzNlRybURP?=
 =?utf-8?B?NTF6K2lJa2xzWjg4Z3E4dmU0NTgvVGlWbmxGNXRBVmEvR2ZJb2tra2NZakVD?=
 =?utf-8?B?TVRnOE5nZURLQk1XT1p4TUVxd2F1MUw0UG1QdFI5V2ZTb2hXdTBYaXY1QUc4?=
 =?utf-8?B?eTQwYUlhdi96ZjVwZUt5L2F5RHVaNG1vRG9uaVVoNUtPM2lGemptSHJwaDVE?=
 =?utf-8?B?K0I4SFRwS05iMW9la1JHV051ZUtXR3lNd2swYmU5Yk50Qi92ZWx5NCtWWGcw?=
 =?utf-8?B?K2swK2pwb09BSkhyK29lNkRGOEliU0x3MkJ6ZXl2UTIzNTQxVU9CdjA2dmFn?=
 =?utf-8?B?N3hEWnVVL2RGWVFLL3JOWXEvLzRIYWFiL2l4bVhmNjlhSVZ6Z0c4S2pVNytX?=
 =?utf-8?B?dFNVaEhJYXErbEdIVEVQMWNOSHg5cTE0SFY2OTZ2SSt6dXVUeGszcS9sMGFh?=
 =?utf-8?B?Z2ZIeHllZSswbVo1Wi9GaUhNeUQ4dmt3aFhrejRROXA5Nm4vTmhBQyt1S1Zi?=
 =?utf-8?B?Y3BURFNlLzFaOWgveFB0QTM0K21CRDNCUUpIOXdGbFI1YUltc0twT0x2bWRY?=
 =?utf-8?B?TG9TSlZscGxDaXYyRDNFejd0MEVGUTZ1N29Pc0tpeHRBRTNaQk5mWWJxUXQv?=
 =?utf-8?B?R3Jhb1AycFZ0TkdIV1Z5MFovSEFlNmROUkNhd01DR2xxZWZlNk5kT0J3V3lS?=
 =?utf-8?B?SkFjdFl6dXM1N3dHRzdYRkhvUXlxRUtQMXk5c1U2TFM1QThPOUFOOEtjaVdZ?=
 =?utf-8?B?eHYwSDRvZFI5cG1ibkhhMXFCMWdtalhqZHoyRU5EeTEvSzQ2YnFMdGphYVYr?=
 =?utf-8?B?dWRlamowTkYzdmtBR2FsbG5YQ0w3VkpLcHkzTCtZNlpjbTQ3THRLTzJQTTdh?=
 =?utf-8?B?TWpxa2gzSkxBMDZ0a2FqTHpoekgxYjkyUjNYUmNIaGR1a2dYUkxtY0E3Q25I?=
 =?utf-8?B?R2p0WGxKZjNiS1B5cEhZaDFZa0FjbmRBeDVYUjVDdGkra1VueUs1eWtzekI5?=
 =?utf-8?B?UTZQRnZNaGxVMWhXbnN0S1VJR0RhYTA1U3RLdmNyN1BYeEs0S1paMzVzS09D?=
 =?utf-8?B?bzhTWUdIMm1yWGF6VGltdVRneHpIN09VVklXc1pLdm5ybzg0YUMyRXBOb2Fq?=
 =?utf-8?Q?cQSvfkBb6dXJ6OecxzeZpIo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2197218-7542-4339-109f-08dd2101e366
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:23:35.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ubKbIWqV/EesLuxi5UU+tk/9IYzWVx+JHs1ROu7+kSue1aS+VXJVc2LLf1WsOD6GdFRJwNItCefw0pgoRnMsDIwOMRA8evTstU5PPaSdF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com

On 12/20/24 15:08, Jakub Kicinski wrote:
> On Fri, 20 Dec 2024 12:42:42 +0100 Przemek Kitszel wrote:

with [1] this patch looks good to me, thank you for explanation:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

the rest of the series is also fine for me, but I didn't spend that
much time to inflate my RB count

>>> +static int
>>> +fbnic_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
>>> +{
>>> +	struct fbnic_net *fbn = netdev_priv(netdev);
>>> +	unsigned int i;
>>
>> AFAIK index type should be spelled as u32
> 
> Does it matter? I have a weak preference for not using explicitly sized
> types unless the bit width is itself meaningful.

me too, unless it is "unsiged int", but I', not gonna fight for it

I would say that plain int is fine for iterator unless you want to
explicitly get the non-UB wrap-around (or count more than 31 bit wide).
But again, does not matter

> 
>> And will be best declared in the first clause of the for()
> 
> I don't see woohaii.

with such long to type types, it would be inconvenient, but the usual
argument about the proper scope of the variable

> 
>>> +
>>> +	rxfh->hfunc = ETH_RSS_HASH_TOP;
>>> +
>>> +	if (rxfh->key) {
>>> +		for (i = 0; i < FBNIC_RPC_RSS_KEY_BYTE_LEN; i++) {
>>> +			u32 rss_key = fbn->rss_key[i / 4] << ((i % 4) * 8);
>>
>> are you dropping 75% of entropy provided in fbn->rss_key?
> 
> Nope, it's shifting out the unused bits. And below we shift back
> down to the lowest byte.
> We store the key as u32 (register width) while the uAPI is in u8.

[1]
OK, I've double checked and the fbn->rss_key array has indeed
FBNIC_RPC_RSS_KEY_BYTE_LEN/4 entries


> 
>>> +
>>> +			rxfh->key[i] = rss_key >> 24;
>>> +		}
>>> +	}
>>> +
>>> +	if (rxfh->indir) {
>>> +		for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
>>> +			rxfh->indir[i] = fbn->indir_tbl[0][i];
>>> +	}
>>> +
>>> +	return 0;


