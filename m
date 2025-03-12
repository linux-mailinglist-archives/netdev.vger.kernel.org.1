Return-Path: <netdev+bounces-174412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B676CA5E7FC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60001634E0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6621EF0B5;
	Wed, 12 Mar 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2a4Wt3+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621841B0406
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820650; cv=fail; b=hK58Iu+NszyZhbc5i24Er8S8HXIVNpLa2+5DO8A8lj3u8IOuM3CFbqj3/aGlUwuc9msMcXxbYuLXCZVomxr0Ck8H+6Y3UaAmPhgKhaG9y0JMONNelJJfxOAtwr90UUW89fcd5CZX8U5YkYyUguehLQ/uUnHyrS6lD7ZaygexY2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820650; c=relaxed/simple;
	bh=bDPQaZBbr2nBiOh0ijEPz3mvOMX+NrLi0dI1QLxXSe4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bPZSCuGK57KNhXjVqsd+rS7cCgObMjvuXj3T/Vs0YTE7ucNNg+jJ6DR2JnpwJ3BBF//jkRmcWL+9VozVeWYWELpunpmqFkviSb8l01OF1pi2ZBFhNFTYNkAP3WNoGRJBhMnNIs+aRQ0ORDR0I+xQHAssZ4YckcBcLxtnofjFzeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2a4Wt3+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741820648; x=1773356648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bDPQaZBbr2nBiOh0ijEPz3mvOMX+NrLi0dI1QLxXSe4=;
  b=n2a4Wt3+b/nGbDvtsF9fkqilyS/TLCKN5U+OyVX2ZL69LnI8bDKRL+fh
   +1bk48jGgsil6CbsPN8bYDT8RdmNpTBT+RGbQDYJ+X2aH52cfCKRuWj4C
   rEDm0blWGZnU9YL8eoa2Gx5d5WKG21ImxrmNSlbe1tS9rUDs3upvOkSKf
   EnNPxUmi8t6ASARkku+tGs+4fOrD9rudg12Gi7ieN7l/tSrKcPzjg2xI+
   /xSupx33n13hgOBRz5nbU+auaMWGcD4xfg7EgnvQMARIMQm/W4TDsY5lZ
   ZAdY7JHndh0Xx+Cfnascy1h7/7QZnnPuZuClxs/QAZ9RLSAQIYJpxAYfj
   g==;
X-CSE-ConnectionGUID: 2DmzzCJnS2ao/elqKLaxOQ==
X-CSE-MsgGUID: 13vGncsGQwWffjxj+isS/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="45695795"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="45695795"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:04:04 -0700
X-CSE-ConnectionGUID: xvbgX1orRiOm+PQ4YiHqeQ==
X-CSE-MsgGUID: VF/+BBkuSre67YMv+hhd8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="120762049"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 16:04:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 16:04:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:04:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI5A1NkMoh9FvNYJf43gQe14vmhwufBgFXQFg9GdJwAY5T6AYk/cArWRlEXpzey3ME4kmDPH82IkgDTZpIliUuv/GQid7EZ/Cy0raBf/UpvGcUUAdTVG7jmT8xt6L5C4EItM6u87Ji7prV2EA9HAo0LQKzr8TS5PIX7EgyYPdRPl4pB2z7e+UKX40PbBeywin3TxXHdStb7md1GRL+0YbSMIQCWEuazAf3wiySDjc2bjNDRLQ/w/jaQHi2VamjMZsJAFRrrJJbODI17Y06qkuU/OdzZCGM9uIPMAyK7oIw45sJba7WUxeaKAEzKzJ0ys5AOWLbHjzJ+5J1O6mUK9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDPQaZBbr2nBiOh0ijEPz3mvOMX+NrLi0dI1QLxXSe4=;
 b=I0MUQVZrpeE0XYFxohYqc7NLvUpD4UlbM3UsFlxodKrgAdslZzSXGswhk2D43WsbbtU2DCp3TJoZfpyF6WFtIO0Waglc9S0TFcAAGDkXLSrWmjcy/5P6rbTey+FSi6LtRtQr/75jfPiH/u2ukl2lT13wQDQZlfUtrhFDM/sBwWNr7R4Dw5E7bdMUH0D7fX5vPU8Fe7GhZ5H4v8CB/JNX0XTod7gioUL3Id4GnTrZNLIkxuxOzzoggoANjqIOWo551UsCsQwLHSEidtiIHW5o9sv5dE4KJBja0RNi1Tm6bHBSMQqJgSx3YL/w/VcuAWK0Ux4UmneqLSWyy5tSkvwUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SN7PR11MB7466.namprd11.prod.outlook.com (2603:10b6:806:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:04:00 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:04:00 +0000
Message-ID: <c96de81b-932a-4c39-a886-8d84da524b70@intel.com>
Date: Wed, 12 Mar 2025 16:03:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 02/10] ice: rename TSPLL and CGU functions and
 definitions
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Milena Olech <milena-olech@intel.com>
References: <20250310111357.1238454-12-karol.kolacinski@intel.com>
 <20250310111357.1238454-14-karol.kolacinski@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250310111357.1238454-14-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SN7PR11MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: c28da0bc-9423-4f37-01b6-08dd61ba2d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGt3WWU0c0VFR2I5bVZFWkhLWi9YZjVNM3h0YmpLWkJaK1A0RmxrVjBZNk8w?=
 =?utf-8?B?RTFZNnM3RThCWm04VGo2eElYaDhubHlKNll6TzN5RWZjZ1lJdXdKK1k0ZUFV?=
 =?utf-8?B?VHc2ZmcxWkNmLzZPVTdUNDFGZUhueU9SdndVQXpiMnh3SE1oVnhodE1FaDR1?=
 =?utf-8?B?SWpiT283RWdGcERsWFFiWEovcjVEeVVBakZIRTZlT0o5aUEwY09YeWdoQ2Rp?=
 =?utf-8?B?Z2RWQzJrM0s1UTNaYVR5WjljeFBuMnNsVHZGVCtsbFB5ditlVjZDMWx6UVE4?=
 =?utf-8?B?RHhZdEJKNzlCOHREd2lRSXJmWVVQaWxLZG1oZmlYbk9kaXorQ0FnM0NQNlRT?=
 =?utf-8?B?ZDRRbTNmK3h3T2h5dEZVMlA1RWJyZHdWUkltTndMWlJNallZVUNIZVdRdGh4?=
 =?utf-8?B?SExvOE9UTDhmYm1iWmt4RFJwYTRLUTU5aGtPU2Vkd3I1STBxL1pHUDRQaG50?=
 =?utf-8?B?Q3BWQ1R5VDN0YnlqMWxkQ3JiWUZoRm5oU280dXQ0eVpIUk5YVFh6a3FiYWVk?=
 =?utf-8?B?UVM3YTlkYVhoMHZhQVlPRkgyYy9ueS9DWVNaUlVsVWgxbWI4NU1ESGgvS0ox?=
 =?utf-8?B?MFcxR0hVWVI1WVNBdzBXcFN4TVNPcWU4VG5NalYzejUrZTdabTFtVXJIQndr?=
 =?utf-8?B?b00veFRRTzdvWE9PdDBuQitjMG5ianFwR3kvT1dyd2JnVkRiV0NNcUxiTndw?=
 =?utf-8?B?TndrNUQ0eVJnTkVSSWJFcWdQSTUzc3VWeWZ6WTFZL0tiK0Q2VnJhWVhOVzlp?=
 =?utf-8?B?c0s0NkU2Y0s5REJyZm1POU8zSTUvMUdDRU12NlM0bFlVTlV0VDZpVHlJb2Js?=
 =?utf-8?B?Q24vY1lDdWJ0ZElFNmdhS0VQQmlhK3cveGNrcHY1OUVjMTNjdlY5OTRnZlVM?=
 =?utf-8?B?bTM3RGhDbmtKUXluRTkxMU1ZVkoxRUQyK0lUSUZwTWNTQW42S1pNTEpVUEM2?=
 =?utf-8?B?d3pNbS93MlREK2xoUENXUHgyNStURHhVWUlNVEcvNlhHU0Vjd0JSQTNaVnk0?=
 =?utf-8?B?TDFNQWMzWHpaRHRXY2hvdXQzdm5tVUJxYnJseUNRdC9vM3BoSExTYWFoTFBZ?=
 =?utf-8?B?TGhYVUk1WC8xcUExa1NZdGZmSXdUOHJPN2xmbjlwRGRvb24wK2RWOUpSdUZD?=
 =?utf-8?B?NVZKYVpCZUROSkg0OU9iNDhoU2hMMG5BMUpCN3k2eVJvZFJHNWR2TGtxVnI0?=
 =?utf-8?B?MS8vTDJKUFViWGNvclMwNzNIV3oyQ2ZmUnJCZEtSaTd1WFFzT0kxM3dyTThM?=
 =?utf-8?B?UmI4TVZ3VHpMM0VNRUxHM0ZScjNFQW15R1grNnE2djVXc2w4VS85STk0enNx?=
 =?utf-8?B?UCsvbno1NThqMXJQcFNiRTdiTHdlYVI4VHRRL2JTQlBCdWhVQkcvOW1ocmhi?=
 =?utf-8?B?emF0WTliN2dZb0hMVTRoOVZURm9QVDhRNGhVYzYzaVJvc1ZRSG85SU5hYVQr?=
 =?utf-8?B?Q05ZTzN4R2k1Wmo4QUw0TlRFcXJQZG9sN2JjSHVDQTE5UjNRQ2ZNektPUFM4?=
 =?utf-8?B?N2I0d29wbzhVNE9xb0hRcFV5NUlJeGVUaG9Dd1oydElCQVJCYU5qTlA2eGo2?=
 =?utf-8?B?U0pUMFFMYVJUekxwZGZSZmE2ZVNZMFNlamhTV200VUtDZVFXblQzdDQ4ZzR6?=
 =?utf-8?B?ZitDUldpc0FZZVluRmZ6NCtIdGxuY2RiSitEdWFHUHFITlFnS1BBSHFPYW8z?=
 =?utf-8?B?N05VdCt5YmtBL0dFM051VHIrZWFPZGV1NDJnWFBHM0lsb01ZRUo0OEpScDgx?=
 =?utf-8?B?N29URUtQSE1XYUNGMjIyZUZvVzRjMDNUckM1eVVlL0ZDcHF4VjdaOGtvNUh6?=
 =?utf-8?B?ZzhzTDVsTnJLR3lPdlE4c1ZjTlY1OHJaVDd0ZVBMVzRKTkozNzY3eU0zZVNa?=
 =?utf-8?Q?ZpHdFkkG6yu1f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEhaQTJBOGVKaVFzdEluMzNNZVhTazBHaDVtZWFIVGhSbWlTMVZMb3JxZXli?=
 =?utf-8?B?cFowWGp2N2VnWS9tTzhjR2lWcERsNytBbkQwd0FtRGxIQThqcjZYUUxtTjJF?=
 =?utf-8?B?RTR6aHRTaXl0d010Q1FuaHl0V25RS1ByOVJkNFQydzhrNVF3RHM5RzZndm9N?=
 =?utf-8?B?UzNBQXkwMnlEa3c5QnNvamNCcE0wUEZJVjMxWUpkaTFoZWZOODZmaUJrY1BK?=
 =?utf-8?B?YUhHVUZKblhvdUZZQUpIZW5Id1lYUlRJQjlZcmlMU0U5SlBacXpBRjhMdGsy?=
 =?utf-8?B?YWVZZkZ1OURhTDhOOUdMVzh6YVVwUWppWG5sWFZ5Mjl3dzg0RGh5aVhodm4z?=
 =?utf-8?B?blUxa0xwNWhBbGJaOXFXSkFiZXd3WVEyQ293QXk1YVV0d2FhSUdEU3NQcU04?=
 =?utf-8?B?elo1c0hBT0lWc2pZSUU5MEhrRHJOcU02ZEh5ZTAvRDArZzE1NEFZSldyRU01?=
 =?utf-8?B?WVMyMmR1Njk3U20yam5OMlBML3VnZTZ0R21Fb3R2akhqZGZ1WVNDU2JORTJL?=
 =?utf-8?B?WjZxdGxUMWZ0WU9sR0JIL095cE9WSTY1VHNqd2h0c0pRNTVsWTV3K1dod01Q?=
 =?utf-8?B?aS9FaUFxUnRrS3dERkVDRi9nS3RVeE5MWUk0RFVuKzZCNlIwY015NWpreWRJ?=
 =?utf-8?B?RFc5eEtYSkhKYUhXNFZVRkhRdkNxNkVwSm1zeWp4bldMTktEYllTb3pSRG9s?=
 =?utf-8?B?azNFREthSUN1NndXUHFRZDk2R05OUmVtSXk1RktXVi91eThhd0pOd1FxajZR?=
 =?utf-8?B?NEhaYWtVb3RIWlZFQVB3aVRMcm1KdmdSR3g1WXAzRXp3WHdRVkxPZ3RueUpt?=
 =?utf-8?B?VHU5K0hhVEJQNjM3dU5YdUxKc3dqZmM2TWIwUmU4UmR3cE51M0JUNCtJZmlk?=
 =?utf-8?B?M3N2ZVg4WVNTRW1ucVhFdFlyZGZIWEhZWWc0ZEYyNTcvSGx4SFpXUWROWXhU?=
 =?utf-8?B?ZzhTaDA4WXFSUUxpaUUrWUt2ZVNhZWVZVjQ2RlNTbGN0NkxOUHEvUkpHVXlV?=
 =?utf-8?B?cjR0U2djbTJzaWtFSHJRSDFVMHNINWQzc3lkZXlXYkZHUDZlMGZaVGp6YjVk?=
 =?utf-8?B?WjlNei8xbDJDUmFqOVpSRHpodkNxditRV1Foc3RwSnJDUWMvTlJEenZtS201?=
 =?utf-8?B?bGs4OWphekF1MzcyaEhnYXI5VEVKekFQK0x4cDJPYWUvL2ROS1BjM01MS0Zj?=
 =?utf-8?B?NDJ6ZG85cHFRcC9sS1hvaWNTM01yNXBXSzluN0NYZmRYTTQyL2hUKyt5bFZN?=
 =?utf-8?B?V2NGT2g5Tm54UEVrM0Q2Z2tTMlh3KzNNYTdlYm5vOWc3bDBRcFNoM2hwVFlq?=
 =?utf-8?B?MStlamNERW9JMENqNjBnVWJXbHJueUlsT3I5SXQ1UWpDL1VSZmozRnpBemJy?=
 =?utf-8?B?dXIxZ3JBOEdSOHZOMlNxRTZ1SHh4cXRRckhKV3MrMzNwb29aUlIrdE0rTEhs?=
 =?utf-8?B?azZHSmZTZ3laZlhuSWdtZ1h6OTlJV2tsYnhwVG1ud3NXWWNHUHREUTZ6elpj?=
 =?utf-8?B?ck1NSCtTRTZQZHB5SjE1Nm45cHR0b0xKQm5XcVY0SnRHck9QSDVXQ1RvMHd6?=
 =?utf-8?B?MVMzZUQvUkgrM0lYRXRLeFVDY1RwZUtUV0pjRHJ3ZGF4NWYxM0pNdm1BUHJV?=
 =?utf-8?B?LzhBb0lxNGdPQWtPWmdJNU1KUnNQNEdsOVp5ekVFWnhiVjhHRkxFUXFWdmda?=
 =?utf-8?B?VkpYQ3k5bkJ0WlFsT2VkY3RoeEZTQjhwRkp0SzJ0dFBWVWtDNUxlU1dGVTlO?=
 =?utf-8?B?OXIvSkk2VnZrZjlmeDdaZDQxNXZsSHNraFMvWlZDQTNmRXgxRzJTMll2Q2gr?=
 =?utf-8?B?N1g1U29WeFBmR3RWZXk5MUdJbjBySDFsTW81aUs1QXczbGhlU0pXQnZBZjJa?=
 =?utf-8?B?L29KRk10MnhjRFkxSll0Q2NiYUVFRDdFSmIzWFF2Z2VXQ2d4Y05sckdPazBO?=
 =?utf-8?B?a29jNFlESElTSTRId1JKZitXc2hrZVZUWVRjZ0kwV1Q2OGlmSTFsSEJNMURU?=
 =?utf-8?B?Wk5xZkFLREs4eFpIOGdUblNsSG56T3RFdGtXVXV2aHEyYkgwZzNMZ1pFWXpy?=
 =?utf-8?B?dUJDMXN0ekRUandkVjJrNWFYQU01RW9DODh5aTJ5NitxM0J4bklVZEVDOUNr?=
 =?utf-8?B?OVQ3ejJoQUtVT1piWGJmQzJaUjRRU1ZCR2d3UEtPRDJTc0dnelZxYUE5MkJI?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c28da0bc-9423-4f37-01b6-08dd61ba2d1d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:04:00.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FG/HkTkP2RMBVncsgI5GI4/Cr6qs98E2H1QDQgTQBqPr/Mu+nBNOMeRWTofPFUHML9T7MCZFXYeLj5qyOqDPWw5m29PpJv3ZJDIhV6cMOhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7466
X-OriginatorOrg: intel.com



On 3/10/2025 4:12 AM, Karol Kolacinski wrote:
> Rename TSPLL and CGU functions, definitions etc. to match the file name
> and have constistent naming scheme.

s/constistent/consistent

Patches 2-4 do not compile stand-alone.

> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Milena Olech <milena-olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

