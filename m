Return-Path: <netdev+bounces-94400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B418BF569
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E5C286FA4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC4134B0;
	Wed,  8 May 2024 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXqbZw9P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EBD17BA7;
	Wed,  8 May 2024 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144742; cv=fail; b=HIvp/1OBbUWPRcateeOzhC2xsRrFYz0vitwa1pAbmWpQgYakAL9H3/wVQOyy1Hw7B+vUQEbn8l+uXc47ZZXFGg2mTiAwWRa2YV2L9WVIuKgJHi1HvRoBe86q867jJJ1EPhhVAPseQOGtoYhIwFJeJAYZEjAP6j8Ft4f3wsVQBSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144742; c=relaxed/simple;
	bh=z2TeHdSyj37XY1pdnrv88qhVtXmSrRi1XnBidcWUNkk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cBQQSHBhhW+1NwLDqRUfJTZKbHqDc5HGTJX5klskvRYzyqof5pD5De/3RQqPo31izNBYP9EPkWbnAfxY0QISCLRzjBCwPiYoRGNQHbgUKAEAGxy23Zxyd0Qi22wp2GnfjR9uJ+chZC4ZX9wHKxI11028hN6sNoU9LWb3HyDwTC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXqbZw9P; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715144740; x=1746680740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z2TeHdSyj37XY1pdnrv88qhVtXmSrRi1XnBidcWUNkk=;
  b=DXqbZw9Ps0xPwB1/PL0i2dIG2389w362EiXgHxA75coI2QgbIctXippy
   5x0gP3pfSScA06LVwYq3bTDisDotBBrtut4v4Zrqmd0DjZjjHQ/HCO+Fi
   gQsTMxLC7kO+ptlxL8xSRzsnSNxqjlB4gsRvDlURIDFki+ZP1zISoRqXr
   CD+vZBwYiyNmK2OpgDg9ktO/rt4DD5tzBD/wF89vK0D83l5wfhhJKFC1n
   Ve46yJUI/ry3pl0cWWqPXfqpAllYmD3Ho5BJa+ZLmNtSn/jnFDphCeFeS
   rdj66Sml9MlQ0tRaSfJ7JgYmJ8V64iZwhi9DuHNivtpa/WgpCW7qWINfi
   g==;
X-CSE-ConnectionGUID: vjWJoPnESMOcgtcH5aPe3Q==
X-CSE-MsgGUID: RVVJyIxwQdSRAXI9AMweOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36358314"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="36358314"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:05:40 -0700
X-CSE-ConnectionGUID: f4fYqCzkRgmpMZh6w/zWBQ==
X-CSE-MsgGUID: vPTd96IAQnOeWtM2N0cKTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="66189176"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 22:05:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 22:05:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 22:05:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 22:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4pLJnoUHu59Zcqsh1K5hqPgVZljE4ExwlC8GkG8tHVYsedJTIqSZS19JdOSC5gWwrw9AuFBG7ana4SZ40AnftKuHuveDZEfggcqW7NfiCVGGuHhMYqCSL+mQ7WCQ8kxb3bfbBKdPtxCED53K5FymOv/XeYh6l8umrYS6fL/+/lBQas+htJT9iJdxUfB/YvXOytjTLlUrvM5tKocU5qoaFciMhXAM5qJIZ3Rb31fPIr9eDbFpuualyaH053GL504fMoPlTan7H+ta9WUs94DivEi2nTUgl+4tEb7/IdmnEZ858aUolgrN5YO3mMOelDZE/nRZKzIMGWIFyQO0YUvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VsCMK2kXhoxAxLuCnwt7a6yam0pNtWw9Dj9+IxFlXE=;
 b=giaav7NBDeYM5FsIyeKbrn3RAQ5sJSQEI9ZLA07r+yTsma/AglOPvY3sitsJP0J2R8Y1bk8+4w+nGMyAcH4YqS5dgSjq2XV1sWwgRtJ3yOaOMCferiz+yPmLAfj7365/b5FhVb43wghkI239pFFx71yalx2SkSjxHjQ5l211ZttPl2GKfdGdHugXmu7URQ2LCRgI5DBvDxDGPfru8JX828tm5KUf+O59inFsb2UpPhqKVOOVTWDZ6gr0u9S84Ul4Em5xd98qiDALgNc/3F1tJUnRADKZ+1YQA2Mslq4pwueLF9hzIy7KR10hpbT3JAIBkhgGil4AUUAnd7/VFbZqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 05:05:37 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::f174:29be:e20c:113f]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::f174:29be:e20c:113f%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 05:05:37 +0000
Message-ID: <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
Date: Wed, 8 May 2024 08:05:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: fix link fluctuations
 problem
To: Andrew Lunn <andrew@lunn.ch>, Ricky Wu <en-wei.wu@canonical.com>
CC: <netdev@vger.kernel.org>, <rickywu0421@gmail.com>,
	<linux-kernel@vger.kernel.org>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<anthony.l.nguyen@intel.com>, <pabeni@redhat.com>, <davem@davemloft.net>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Lifshits, Vitaly"
	<vitaly.lifshits@intel.com>, naamax.meir <naamax.meir@linux.intel.com>,
	"Avivi, Amir" <amir.avivi@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
 <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch>
Content-Language: en-US
From: Sasha Neftin <sasha.neftin@intel.com>
In-Reply-To: <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|CH0PR11MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce0f5b-be3c-45bc-48e1-08dc6f1c7fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1R4SjhrUGphYkZpVTFDTTNjL1BlT2pld1o3NHJST2FDYmxMTjRMeGJ3eFJJ?=
 =?utf-8?B?ODE1QzlRQThFTEVyN2VaNmdTMVFWN3FaQnc2NTg5eHc0OUIwaFo0QTZGNmxv?=
 =?utf-8?B?R2UvbmorNGFpeFpkSm16dmNrdjQvYW0rdFBtNCtCWGN3dWVsbURWVlZodFlj?=
 =?utf-8?B?NW5acjR0WGxIOHFUeGc1QzNCaURKWUYyYlBHMnJCb3BUSWkwaWozazkwcFNZ?=
 =?utf-8?B?U2ZxNEtYUXNtMm0xNERDMEtiZ1JFRU85bE9WaWVOYzB4eThWdTNVQStVSGxO?=
 =?utf-8?B?TFhwTi9xUW1LMlFxODJ3Z1l1QUJCYWY5K2FIaFZEczExWUtPeExjb0VVS3VZ?=
 =?utf-8?B?Y3pldTAyei9zY3ZHa0N2QmF3ZHdPb2RVU2VaSDNhSWVZVDREWERsblE4eGI0?=
 =?utf-8?B?Q0gyZmxBdEV3cG83bUdMRVVQV3NxYS9ubWgvWWFiR1lCTFNOazJhSDQzUkRp?=
 =?utf-8?B?VWhxVldOc2dRL2dkNStqWmtWMEgzaVFzTTFtSkl0OThMRHhIaUZ2Q1M5Z01M?=
 =?utf-8?B?cUtkWENaK0d2VUJhTEdpcndrdjV1ZFFYdytQdlA1OWR1Zjdoc3ZrdzdBbk9G?=
 =?utf-8?B?T0I2RVo1QkN4QXlITnVmYmRmUy9RcFF3RlRGVDlOWURhSklGZ2JCS0x0cDhR?=
 =?utf-8?B?VTFPWUI4dVVvZFlxNld3SDVURG1zdkFxYk84WlR3RmZWdmh4NWhWSksySCtq?=
 =?utf-8?B?Z1piSVFaYlY4VWlMOFZZeklTY0thQlRONjdhL2hhbldtU3lQTTdGOXlEYXhv?=
 =?utf-8?B?OTY1SDNka1VJT2RMbzNTcHlaSmZadFdRQjNlL2xoQm9xME1pemNrd245Nmtl?=
 =?utf-8?B?WCtUT0ZXUXFaOWxYWUZMRWtpblgwN3ZZd21qK2FqUFd4a3NjUEhCazdwWHl5?=
 =?utf-8?B?Y3p3dGlkSzg4VW5mUzdKT3lSRzdpOHZmQ0JvOEgrbEZZYlBXY0NlMENuL2p3?=
 =?utf-8?B?Qy8raHdUb09LTjRmRkg4b1JUUFpJR1VWelZZZHhCWmQydFBXeWhaMFNGR21u?=
 =?utf-8?B?Q2prb3hwdlREclU3S2NETi81Ulp4QVdyVnA0MnJ3Ly9CNk94ZzdxUjRlcVVn?=
 =?utf-8?B?aHFFODNHa05VSW5kYkNWWXc0ZDBJbk9FNUhqOFptc254UU5xZVlTL0wxakUw?=
 =?utf-8?B?QjlyK1V0aTJlT0Y2MWozK21QL2ExeTlVSG82bHNib0kyWFhMOG4xTFBualRi?=
 =?utf-8?B?VGxPYTlSME9nWVdBQkRxL05zRmRKS2h0Y3ZudVBtcElTVTNQTk1xaGhlWUpC?=
 =?utf-8?B?anJNUzFJY1F4N0pTVnBra2N6dHdyMWNLcWZNcStYdXZnOHgvSFVjbXJveWd6?=
 =?utf-8?B?bi96aE9Fck1JdXlRZHNncm1ST1M0NWRYNjNxanBZSkdINmlKTVVvN0tIK0FP?=
 =?utf-8?B?K2x3M0JJa3M2NXgxaU9pblFYWk9MbFY1aWRQKzNGcjBTRDRjK2FJdXFhMUFk?=
 =?utf-8?B?eGMvL3RxWVJFSGQyWUJDemx5WFVqUkhKTDVVNUdEVGRvczFQRTBWUmlPMERB?=
 =?utf-8?B?am8rM3VXTlpJTlVZNGRhVDBsQ043UDZyb2JibjdiWjFVb0pQTVdoVGRINzVN?=
 =?utf-8?B?amRKOHNLTCtCSEwxUW5TNlowa0dwL0tXT2szcHJ0WDl2VmJRSHNqTFg3Rjl5?=
 =?utf-8?Q?HTSR0SGFHFZqDlGxFfFIgwb9U4kjsNy4JLB4YlGXeDY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elFjY3lxeEQyamRzNnFyTlVmbXpDSE1ESFFxeEREN1ZFRElyUXJGR2x5NFNl?=
 =?utf-8?B?eEFKVUJsVUVxcEdvTEJhVTRvc1RQdURxeXZNNE9IdTJ3NmZRVU9peE9vM3Ry?=
 =?utf-8?B?VHhrSUhvOWVJcmhEaWsxam4zZ1Y5ZjUzQXcvNm5lUFJDOTNsUmRkSkl2dkhS?=
 =?utf-8?B?M2JiVHFOcDg0OWsrK2gyTGpWZTVISFZvRXRHbkV5WnczS1Z5SWVBVEg5Z3BI?=
 =?utf-8?B?bFliVWxXd2gyZHAyVzhUTzE0OWNHWDFoMHZaaERCdWlDK1J4dzh0bERIMDZU?=
 =?utf-8?B?cnE0ZXVTSDZkZUlodnB0Y1pQbVpZeWw0RXhiN2NJNSt1dDlXeldvSmp0N3VL?=
 =?utf-8?B?K0plTHhqUEpzVFZlR2E5Mng3VW1mMkNzclgxaUJRQVpDNXF3M2xiNzNaZU1m?=
 =?utf-8?B?Ykswc3JGeGkvZUtqOEdpZzgwT1J6Ti82ZzRNc0hxNzF3ZWwxcGozZUlmeG1n?=
 =?utf-8?B?ZjlJMXowUUpsSE5NYzZZRThCY1FQZGNKU1RYWkExRkI2bHV1dUhFeWRDcDA5?=
 =?utf-8?B?VnBDZFhZN0krZnl0ZVg2c1B1N3Nab2QrbE1kVzk2U0ZEb0swUURJT2pCbUJ0?=
 =?utf-8?B?MWRwQXpxYzZxb28xZWxrbXlzRmJvSHZnblRhQjJZTzBMY3ZMYmxDc1RldHB1?=
 =?utf-8?B?ak1PVHovQjN0Tm1BNWt3QVl0SGg2VFgwckR5dlI3SHZ6YXBUamRkWEp5bFA5?=
 =?utf-8?B?TStWSjlBQ0pTOE1vbExYNDhtemJ0ZkdPckRBYUdENjBocGhNcHY5N2VsWHZ0?=
 =?utf-8?B?RTUrenp1M2p1ZFNGUFVuM0FVdzFvdFJmenhkVGluTG1EcWJsdTl4cURwY0Jl?=
 =?utf-8?B?aElqdmJ6TmpkdUw0SzZRSmpPTkpHVGlXbERCc3d4UVNjUDdxS0l0dndwSCtY?=
 =?utf-8?B?Q1lBSHVyUzBscnMyMk9vSmY5ZFFUZnduZnVhbzZhbitTWldDRTZyRUJWRWI3?=
 =?utf-8?B?dlpqTmdFTkhIMGcxZkhvMEhqUDh5VXVNVG9aeTJMV2hQNFcwcjBDTVNPV1da?=
 =?utf-8?B?WmdVTFFHbXd5cEROWGFUQzRlNEgrK1R6ZU9tMGNHeWR4SENhUDVkUk1FZkgz?=
 =?utf-8?B?ZHJhdE5NeGhEV0x4eVZuYXJhdC9JMWtZRWNpdVFtUXRqMVJhZFlvQnk4Mkx4?=
 =?utf-8?B?Unh0NkkrNnpBRk1XSENLN0pScnFwOXNuaTliYklpdUpETmpDci9YSEtBTHRh?=
 =?utf-8?B?OVp0OTNVTXRiZDQ3dWVpeEtSVy9uQkZWRDNXaktIWkVPRkZ1K0oyQU0zM2x4?=
 =?utf-8?B?ZTBlK2QzSWNFaGNScGIwdHFucFZCL2drMCswNXJpMUZ2eUgvUEgrc0d1ekhi?=
 =?utf-8?B?QWc2dkxwUWl0Z3RHb2x4NDR1MHdBV3AwRnVMejlkcGthMzdHNWkxUjdFQXN1?=
 =?utf-8?B?VHpDVTZtbXhqU1RzdmM0V3lPYlh5U3VqaWJ2cjUxSllSY0dJMkRxTGgzZmdq?=
 =?utf-8?B?TklITWdTby9XUjB4QURuZHNCTVQ5MjZZeHdGcC9zQll1RHJmSkVEM0cxNGdv?=
 =?utf-8?B?L1hZMldKODA5YjI0VmVwUDExTkdwRnNEWnZqcTJMbkdqeU1TeG9heDBHQUhy?=
 =?utf-8?B?b2N2SzltTzFzMVYyYmFpS2dlRXpYamt0SjVmdVEzU3U3RkMxcFBydGJBV1Zt?=
 =?utf-8?B?MVBob3dxN0JsTDhWbHZjN1dyTXlTVzdkTmhaOUNQNU1SaHN1dEx4bDBkaGc0?=
 =?utf-8?B?L1BjRmlaZlErSWtOZnhId00wS1E0a0RmQmsvMFpwWndBdGxDWXdLS2Zpalp2?=
 =?utf-8?B?ZkNtUmUxaGsrcThjdkVTUVBUcnl4czJuTytQM1Y3NmZ2cHYrVVVuUzhONXp4?=
 =?utf-8?B?L0dzc0VpazRJeUJpM0hEVWpXK09hTkU3OVdDVmZ0cDdPYzd0LzNPY3RxcVEz?=
 =?utf-8?B?RXVWSlp0dmpyNTJ0SS9iNmR1VTNaZjVnbFZJVnlOZEVBQ2diclN6aDhiUEdo?=
 =?utf-8?B?OEdYQ25uUTZXeUtRbFA4TytOMDI3dDdZVXVkdkREK016cXg2aTBzQ0FiYTYz?=
 =?utf-8?B?M0ViS0tvcjUrQ2JMeVE3YlVrMXFheGZaQ1RzNW8raUhxT0NHYzYvVlJPNDZX?=
 =?utf-8?B?dVFabVVOUkh2VFg1a1lBakEyaTJCM25HRWRwTXlhTGJzRUJIUjVyekNEa0h4?=
 =?utf-8?B?dzJXS3dZTG1kcXAvSVVKcnZXUnhHL2hGbGRNZUpUczlxOTdZK1VaTndjNlha?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce0f5b-be3c-45bc-48e1-08dc6f1c7fd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:05:37.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4MZr6igQqkhMIuA4d51SZhUwWl+CECVIeZU2mWBSH+k/nM6maqabJ8cezo2i1U7emdE9OaBJUOK1vojgfKg5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5249
X-OriginatorOrg: intel.com

On 07/05/2024 15:31, Andrew Lunn wrote:
> On Fri, May 03, 2024 at 06:18:36PM +0800, Ricky Wu wrote:
>> As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
>> Intel I219-LM reports link up -> link down -> link up after hot-plugging
>> the Ethernet cable.
> 
> Please could you quote some parts of 802.3 which state this is a
> problem. How is this breaking the standard.
> 
> 	Andrew

In I219-* parts used LSI PHY. This PHY is compliant with the 802.3 IEEE 
standard if I recall correctly. Auto-negotiation and link establishment 
are processed following the IEEE standard and could vary from platform 
to platform but are not violent to the IEEE standard.

En-Wei, My recommendation is not to accept these patches. If you think 
there is a HW/PHY problem - open a ticket on Intel PAE.

Sasha

