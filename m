Return-Path: <netdev+bounces-94488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489208BFAA6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA31D1F25430
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B87E772;
	Wed,  8 May 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbUGaGMC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639E79949;
	Wed,  8 May 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162877; cv=fail; b=bX9X7Bla6VY/vRkAum1IzaUmsIPu5Yn+ev9NLWJUTlPJcoKQmfjRFziG7pvMwY9EOnWMmAyMOxv3y12IUzB04PbqKkhEYMl/RkBXHg1GEfvQeUJlvG68wsBlxrBqOUlUmfEtBJpej5eUwGFIJkrJOI02KAD0cY9z1L28jlRmmDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162877; c=relaxed/simple;
	bh=ji900K/bmeazov/xq5Z6bouu13jLJt9BOWBxPzo39LM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcUf/CBe4RISF+q8KyI/gjPiZITDYkSnH+ePRNQHIX9FO1Y8of0JDbQVFogpieBqX5Lzzk2IoTT8FHw62GnPnfPkpwJ+lxJD7DcE0quYUuVuAzN3M1fulTYCjySJarw8+LX6jY6toYxwcREdFEVm9/cBJ5qfybL5DYLzCOocXds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbUGaGMC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715162876; x=1746698876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ji900K/bmeazov/xq5Z6bouu13jLJt9BOWBxPzo39LM=;
  b=JbUGaGMCODgf7RrANA8q//HswZHOnJWwCyEjDmb+Ah06OYJ3jT7+PPW6
   6aHAFM6g1VXEhGaB1hMpaXcoe6mHBlLpvXUAXO+0BwF0uL6hNk0g1bu+4
   8KkBonOiEUVDmCw+u5zpguMaHVNOTodomEREo8g7NZzkd+s/PJkKHRQ7G
   C7NvIS9TWpTmjk1ulRrO7QmAAiHHsW1zQx7PRu+yYq4wG4TNScJ1PTtP0
   AGN+2MUpVz1sMN5eLBCm1cfhlh7EcUXpPPphaeklkQi++pv/vglPEf8hU
   GXlI1XANweR9nA45f0Lk/mk0kHLpTFtFa8/0qIgV7Q9bJXUVtGdQOBHBZ
   Q==;
X-CSE-ConnectionGUID: kAEX1rBmRdKI+99RySmOhA==
X-CSE-MsgGUID: cAzmGUS1RFya5pr9HkvNBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22405136"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22405136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:07:55 -0700
X-CSE-ConnectionGUID: QgH3rzQGSlaSZdqU/SpqVQ==
X-CSE-MsgGUID: nEkgKmrLRH+Zdq9AeE2psQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28779251"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 03:07:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 03:07:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 03:07:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 03:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ8C5so0Sy+ISOn8bnkZBmCn9wrKhsS3CqOsf7c5bGKKnF4S00cVixOBlM0d1zLDxsfvkrHhGvjEv50ZCYGWg5kWr3p8dnpM0x38b58cPAXILqSndl6Jl3JTEmSM53+kDNzfzxhBGa3DOXR2JHjSntp1l/Q3jV6rGstwswMHj6y/zzZb7uQMfC6IbgOD9QUwcTZb7fHEImvI8zIt8lLm8E7fxeZmMJLd+NEgEIey19fqDUta3jv9BJn7yGBBcZF1qsSeOoSQ9t4ySYpLrGX9CzHmgR8wfUwVGekaiaBb0iBhtTi3k4R0bIU9u+kkrCUTLtePfU5dITOA+ZAV22k9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K4bs4/h+0Q6F7gdfz1pAQGFsXlcNW1/dTo9gRoIoCk=;
 b=MKbI1uml94wXLVuCSSqD1HUM1wjF/42xkcg7ExergTFFzEtSCHt05gMLuSXmt72rFNJThn/zfq5NF81tns6x1cNUTRXgMY+ITcAGqcFSuRf1jejBw9+g3tmTyUNzDwh0Ncmh60tuGhzH0F93YRHDkjHU6rmiTLjPXy1qdo2vMzuTzeO3HmjpmjghFiMzreH/r2O/JDrEwlDLV2JZ41CJLcR86Jv6Qnuegm3TkjHLhHdsPVtjKjBvNFR4bi+W05JwrHEExiuyelTn0A/9hSAW4ciAr2NkE6k2xF8KrFgrcLuNDC2XUac00Qcxanwj9jTzYMjVABTSgC8JTuG73bpiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 10:07:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 10:07:52 +0000
Message-ID: <e3993bb2-3aac-4b07-8f8a-e537fa902af4@intel.com>
Date: Wed, 8 May 2024 12:07:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/14] net: qede: use extack in
 qede_flow_parse_ports()
Content-Language: en-US
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Manish Chopra <manishc@marvell.com>
References: <20240507104421.1628139-1-ast@fiberby.net>
 <20240507104421.1628139-2-ast@fiberby.net>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240507104421.1628139-2-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: e88756ae-4ae3-471b-ad43-08dc6f46b93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bno0SmFOdHVYR3VjWnY4TU9QSG5Rb1ErZHJRQjVEckVmWXFqZUp2Q3lUSEcw?=
 =?utf-8?B?Sm1aUzFxK2d1dzduelNMbjArSFhOa3pHa285Y3F0Mm1hZHZqOGxQZ2lsMVRi?=
 =?utf-8?B?NkgxRTZCL1o5TWRocjYrL1RUNGYweWdtdUp1R3BIRllPeGNEckNtVmZQZHpJ?=
 =?utf-8?B?QUJWL3N5Wm5VaHdRcDJlN09qV3NlMjVXUjVzMVFQMVc3U0Q4TmMxMldSZnJm?=
 =?utf-8?B?RWFWQlEwbWQ1d0RqN09naG5nLzhMcllucE5VR0JFOU40TFJRYjR1b05PQ01C?=
 =?utf-8?B?YklCQktRT0U3Q0FqYVJ3YTRndFFkSjhhUGR1WlExKzdkdDg5L2QxS3ovWEts?=
 =?utf-8?B?bEd4M3Bsb3lQT3pUMUJjRWx0T1lGZ2JxU2Y5UTlJVDBNQ2pWZ0FuemFQTmpN?=
 =?utf-8?B?S0hxNXI0SWM3YXh5OHNNZ3ZlNmVlN3J2aFZDeFQ5dDhaT1o3cnZpYk1QNXNT?=
 =?utf-8?B?eUlyOERFM1V1THYvUE5hSXg3Qkg2VVF6ZUgwc09EQ2VlaXorc0lTNEJBSjJp?=
 =?utf-8?B?RXl5OW9IVG56Zm5oVUdqRTc1NUllWnhaaE8wOTZoSzAvNmpkWkVFUWZSOTBB?=
 =?utf-8?B?Y0hTeHVTWGtyaGFzM0poZFJqL1Y0RHk5N09hUnNONlVmMXFhUEcwWTNKa1JF?=
 =?utf-8?B?VUxheDJaamFTMS9WUm81bndJcUFTZGg1Q3FkbnY3NHh3NXpaTktDL3hGNzQ1?=
 =?utf-8?B?R1NmdDduMzdRS1N5cTdhVkxNMjVnclI2SGs0OEdRVlpHZVBiRWs3VE95NUhu?=
 =?utf-8?B?akduSzlVSThnYXlvKzJMSjEvSERBWURqS2s1STg5c1hQSm54cmxJWGUwRHpQ?=
 =?utf-8?B?eTZVVzg4WWhERmNQeG1VQXE2SXhEaTFUS1pkTXBMS09XdUZyY1BmYzZVdWh5?=
 =?utf-8?B?QlkrL1k1WE5VaG1WWUticFdOUTFlNktJWDAyeXA3K1hFSXczYUdydWxKTVRs?=
 =?utf-8?B?S0g1VEwzZ3dEYkhMakJRajQ3MTg4WkFlWmRnMnNGbVJzOVBMYjhnbDFLOGl5?=
 =?utf-8?B?UDY1R3VONUpYcFF6T28rai9SYVdLcTV1THMvSVdtVmRKZzczUzcxd3VVdVJQ?=
 =?utf-8?B?S1Q5cTJjSXlhY3M3bk41N002clRNUmxwV2ZicHlrMXJVRXB1eHN6ZXNLL0FS?=
 =?utf-8?B?djhBcTBuTkVaMGh2MFdrSzNsb3hlbm5WRkU4Njdud3RGeFVYeDhFZThxYkNT?=
 =?utf-8?B?dkF6bC9WS2hUY1JXNkNNMmZhT3J2SVh2M2xaMDF1L3hwV0Y3VEZPcEsvdytT?=
 =?utf-8?B?RWFyYm9FK2VsNmhIRldGak03UXVrUGRJcStHMkQ4VGRZeEVLUUtzejFTUEtu?=
 =?utf-8?B?dHBSNC9oejlNQXRZQW5OSXhPb2NBMCtKZnNHNWc5T1JYelJzVHdLR2dKMDBW?=
 =?utf-8?B?TElLWGtIUFlSZU9kZVg0UHphY3RnOU93YkRCZUI0aXVQRjNVZmNZMHNTdzFp?=
 =?utf-8?B?TThHUjVVK0pnMFByM0tUaVkvcllPU0FHdjRPemtJMGZiVXdxNjIrL0NMQTNH?=
 =?utf-8?B?NFM5bjBpTFJwMFNqN0FycFk5VHB4bzlScW9wamEyYmwrQnpTZVNiV3dTakJ3?=
 =?utf-8?B?U2wyUlBCQzRJV0RXOE56ZzNxUW5OeGl0ZWZkaCtmSzNZNDVRRyt3dUVzS2g4?=
 =?utf-8?B?THhFVlo1bUxlbHptdW51cUc5RVZvOHB3VTJzNWJMeVJxWnR4aG54WHRCYVQr?=
 =?utf-8?B?OHlxRGxGNE5OY1BtWG5UbG1rSUNrRkF2RVRUVFFMVnkvOWFHYXp1eE9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBmUTYyTnJlcXFGUE5lWUVuWkdoY0dYcU0razVxd3hseGtobzFWSWF0SkRB?=
 =?utf-8?B?QWZmeXo2YW9HVjlSbVdZa0xWWnY1ZEFuMDh2aW9LR3J3N3lscGw0ZFhCY0pQ?=
 =?utf-8?B?VmZ6aXI0UnBzUzRiR0dlVFQ0WTFwd09rRjBXcHVSSjBHd1NqZ3NDNTZyeklm?=
 =?utf-8?B?ZGsrMUEzYkVkNGlrbzgvWktvWjRqYWIxRU9sajllL2IvWjNFOEpPZTJhRXZS?=
 =?utf-8?B?QUdZeFBxK0lYS3EvcHFadDBKeWRnZGJrMTBRWU9jZWV6aUxJWUd5YWMxd0dP?=
 =?utf-8?B?cjFrcHFXcHF0QlNLU2FuRkdBbGhuRWcvZERiSHRMenl2WEhCdHR0M0RGZUsr?=
 =?utf-8?B?NzZvQzd3cEFST2lrWlk2Nmpmb1REVEZmVFZXZ00ybkthTXVRZmRjdmVJYmtu?=
 =?utf-8?B?S09iYjFPZTByTUlFazRSODhoZWovZXBxOENERk9lOXZnRFFpb2VzMTlEbjkw?=
 =?utf-8?B?eGZsS3d6WUdhSHNjU2NodjVvcGxMVVd0SnpyM2p3K0Q1R2NPQ2twZnNrWDFa?=
 =?utf-8?B?SUJTVDFLTWt6dnlScVhTYnFaZFNSNWg0Y1hrL3JDZzRlOFU5MW9kRk8vSDl3?=
 =?utf-8?B?d3JLOUJwUEZwTXgxSU02RHZ0UUFJR0FWRVlDS3V2M0hrcmFQUCthL2ZURDVU?=
 =?utf-8?B?VWZGb1VUZHdicEJRdmJhVW5sZHNzZERwYTNrTm9adHBEbTIvN2tEOURMMHN4?=
 =?utf-8?B?QjhwaE9RalN0cWxLQzJFT2ZBMFNZK0hXYnQ2WFV1VlVzNXRxZFdNZXZVWWhj?=
 =?utf-8?B?SU11Y2dsRiszN3R2ZjRWejcwYmZlNDRrd2ovVGVrS01LcDJLcXhOdkZSZkdY?=
 =?utf-8?B?UmdFTGJDaXNhdGVpeGJka0h3ZWkvY1k3d1U3QXVMRSs0Nm1oMzErRDhsR0I3?=
 =?utf-8?B?QW9keGl1ZE1tYmJXa01uOHNyYmdqRFE1SnpSSzliWUd4WmxWK21FWkxGTFdE?=
 =?utf-8?B?OEdTaXZscm1lNi94OU9jbnFvN1lic0svY1ZKelVFTjBqcUQxbnI4bnRWUDMw?=
 =?utf-8?B?V0o4c1YyUEJGMVFBNUNTVnpORHRpMTFVMWZWaDVGL0xGNC9FSkJlZDQ4bTFW?=
 =?utf-8?B?ZEdZd2NFaHFwREsrbDhVYjE3aWsvZGQva3JSbXNaRHh1TEx0SjhtU3dzZEF5?=
 =?utf-8?B?KzVGTlpXWStWakwyOHZObWlJV0dJOWlwS3FSVHNrYysxU2UvbzY3SVN5S1Fo?=
 =?utf-8?B?RHNYbm1IamErMFMyNjVXSzVycHcyTWpWRDN4TkcwUHljOFRkL0lCbUlKMWNR?=
 =?utf-8?B?WHhHMXNiTlN4NzlpckdTWUp6aDJKaUN1WkpKVEY0N0dBMGI4L2pQSTBHM0hM?=
 =?utf-8?B?RWZyam42VUNaRlBKYzYySEpJMVFUVnowRXU5eE5seHB1elM5RVNzSWpqdVAw?=
 =?utf-8?B?eE16RDYrMFYxUU9IamxHZHVha0x4eW1taHdCeVZmRW1UelhmemZGdW81citH?=
 =?utf-8?B?ZWxhREhlaGpaSHlVTnJ0L05FSGxBREFGUXhsTnhWRVRmbS9talhPQkVNc2d1?=
 =?utf-8?B?WVdlNklMM3d6UHJyUmFPdm8zV2lMN0xURStGQk82RnhSTVR4bVBrSGZkSlk3?=
 =?utf-8?B?dS9hOGNVSStZNlE4YklMejN4SEhpN2NDMldudWwxaGxKNUZGLzNRUVBCeDNF?=
 =?utf-8?B?cDd2ZzlVSWp3dGk0UkRreDFSR2h4M0trNlBHRGtVWVVQTkFTcjMrQzd0QWRa?=
 =?utf-8?B?SjlSaVA4dU5idC96NWVmcU9yYldCbXBWMEhDbElkenJMTmprTmxNUEVzTm8y?=
 =?utf-8?B?MGlrRUJhUm5yTUJVNTc1WExGRW12d2VCYTJLNU5kbG11Mzk2TTBpMytSd0dD?=
 =?utf-8?B?QUMxVG8zeVExd2dmT1JUZnVJa0Z5dUl6STVQZEdQVlF3VXhHYTcrWlo2bFFK?=
 =?utf-8?B?bjU3RlBIK3ZqS1ZPVFF0ZHNML0F5alZQVlIyVHMrbmJPMVhVcnIrWFJtNFA2?=
 =?utf-8?B?WXovUUYxdTVGUExJeUF2aWdON01iVFkvdTRtNTI0ZEpmZU1ZVHVMeloxQU9S?=
 =?utf-8?B?dlIxYWFKYzlabC9KKy93OHN3WTVBV0J2SGxyVkMxdXJmTjFLNzV5RUpXT0Nj?=
 =?utf-8?B?SVI1Z0lJblk3NjdtZExzN2NQWVZaYjJkUVoza2Jrby9SNnRkR2hyYWFCK0hR?=
 =?utf-8?B?SWUwVEQ3dFNtVHNYQjhDWkZaRFJkVGsvOEFVMFhDbEtsa1MvdGFGVWpqQlpY?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e88756ae-4ae3-471b-ad43-08dc6f46b93e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 10:07:52.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21v5rcIZ/iVlaS91acsKbY++DermTvKgsDprjipC6v58g3Ai7nCGrOBL7lCAnmd8UY5esJgUUPiH3TWHJmyfi03EN+nsPhreiN0HxXwvoI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com

On 5/7/24 12:44, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_ports to use extack,
> and drop the edev argument.
> 
> Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.
> 
> In calls to qede_flow_parse_ports(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>   drivers/net/ethernet/qlogic/qede/qede_filter.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
> index ded48523c383..3995baa2daa6 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
> @@ -1700,7 +1700,7 @@ static int qede_parse_actions(struct qede_dev *edev,
>   }
>   
>   static int
> -qede_flow_parse_ports(struct qede_dev *edev, struct flow_rule *rule,
> +qede_flow_parse_ports(struct netlink_ext_ack *extack, struct flow_rule *rule,
>   		      struct qede_arfs_tuple *t)

there are ~40 cases in drivers/net/ethernet that have an extack param as
not the last one, and over 1250 that have an extack as the last param.
My grepping was very naive, and counted both forward declarations and
implementations, but it's clear what is the preference.

Could you please convert the series to be that way?

>   {
>   	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
> @@ -1709,7 +1709,8 @@ qede_flow_parse_ports(struct qede_dev *edev, struct flow_rule *rule,
>   		flow_rule_match_ports(rule, &match);
>   		if ((match.key->src && match.mask->src != htons(U16_MAX)) ||
>   		    (match.key->dst && match.mask->dst != htons(U16_MAX))) {
> -			DP_NOTICE(edev, "Do not support ports masks\n");
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Do not support ports masks");
>   			return -EINVAL;
>   		}
>   
> @@ -1747,7 +1748,7 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
>   		memcpy(&t->dst_ipv6, &match.key->dst, sizeof(addr));
>   	}
>   
> -	err = qede_flow_parse_ports(edev, rule, t);
> +	err = qede_flow_parse_ports(NULL, rule, t);
>   	if (err)
>   		return err;
>   
> @@ -1774,7 +1775,7 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
>   		t->dst_ipv4 = match.key->dst;
>   	}
>   
> -	err = qede_flow_parse_ports(edev, rule, t);
> +	err = qede_flow_parse_ports(NULL, rule, t);
>   	if (err)
>   		return err;
>   


