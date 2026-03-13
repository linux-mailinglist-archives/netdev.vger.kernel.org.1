Return-Path: <netdev+bounces-267265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIPEJnVws2kEWQAAu9opvQ
	(envelope-from <netdev+bounces-267265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:03:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8327C767
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABD43030EA5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74ED1D6195;
	Fri, 13 Mar 2026 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1IkjObG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662D1C8634;
	Fri, 13 Mar 2026 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367410; cv=fail; b=gnO1E3MlNJmXwsuoXZuvt5HhUc3ZtfulAXJEeHuAf63dtCdpmOA51G6tNy9BFbgQTlSzxRvqnIva1ljjLC14f+yKDqjIGRaEp4qTUO6Gvb/33Zwjhep/oIJZFfn+jL0o7OMUnJNpXeEU7SfxkL3yopkjAyqh0l04tdp6k05p+70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367410; c=relaxed/simple;
	bh=9CU3Z1wdggixAQ2jsfB7aARA/4S1B6bdDlY+2lIiDz0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ujfVepc7splfmnBDegi1DMlTmXdbjUukNkMcTY2McCUXEzDYqrG5+PdX6sW7+ER7PJU4p0AmUuDEbc/SOu1tgRAJ2sGhpJZy1rVTvQGIT9S0CCck0+QdpzQwiNjR5bWFgTN+055TA6ITUZQ+VChRbB/sRBdz/VHmtIHw3YWqUaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1IkjObG; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773367409; x=1804903409;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9CU3Z1wdggixAQ2jsfB7aARA/4S1B6bdDlY+2lIiDz0=;
  b=W1IkjObGhqc4xRfE7He5q5tGKdW887NLAbGcJ5E5UTYq662l5R8P66aR
   W5iTm8afp068sa6C6zy2vSiGjRUdtaewIUFtx/AO5cQ+w0HbFkYAfe1Yb
   utvSLzj3j6HlecP7Jl1UnSoTxHufl/PhAk5kczAO5fHFd6CI+TVelBMT9
   8znE4s8ghv0KZKv7TiEtcDRZv2fMjYU6KwURFzbcMCNwzD4NS+o4SfqYh
   Mo7aNJuRZJ9ZoWqDu2HFSCXgXPe9w2GKex5kO0qt+B8l5DYDQQ63HN/Bq
   CgvM9sIya4NMehnKqiRKSSgr85A5qzR9ftyAXEmzGO2uLwR+LGpLCikj7
   g==;
X-CSE-ConnectionGUID: xD3Xd/XoTFqI4V/onNK5Zg==
X-CSE-MsgGUID: nR0kL8lMRau/cKh9l2or/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74554361"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="74554361"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 19:03:28 -0700
X-CSE-ConnectionGUID: ufuv90IfRDyUKlSzPT/9iA==
X-CSE-MsgGUID: gmN/zVs/TX2bD7a0pgw3sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="221082104"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 19:03:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 19:03:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 19:03:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 19:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiDxXhZHi3L+EinXN+btb7Q40YJY9LWghEodh/jwgQWDND1GPpTDcgQmxzVHUr/O6digrhUGqg/QexDIkwqjZJTh6eHMt+Hh3k8UOMGtn64BEQftfgDfi4/B+rhgIvc1wiVTvGUN7OsVIbXAPS8KWi9yjSt9jwIGofqEFAK/r5EIuU5NULx5K+mOed5EUY861+DJ2ICdXvMLk3mbJKb3UasUIVUZvCc+lbUglJgqauLhtZ9yFfd0ENdR+NmSoTzWIdiTy0c5vzoJySFBKlQKqodXx8PcA8gElYVlronXU2LRHHV0vh0uXFqX2QSlgi/oqbSLtqceZsWPRkbKnw0aUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaDJyhgveKkt5h1ZtFXVOTUAuU+iCXRyT1wYF7+6VUg=;
 b=UPzkVEYPZvfd/gsdsK1KrLfj4r+oaAQe4qdBPXAtnPI6xSysWjkFxT/AQZ/2vHtb3j6VudJJMwoCuXB8nYScm97+YNLIeoifU6VtFqz3WiOAJCFfTWc4snf6hjWGKb5JVJEm0AFh8VqNLOO1TTI8KVdTDHUa92xUd4bMqO9PbD/+iQ7pu4ax1mgcdAsqzDaHmPwspqv5s+UamYhf3IXBlbKt8aPKihl1VQuxOimr9xxx6RUwPVOv125440BThGzkXXH1LuxH6Pl2Jnml/KGfPDkjEVggNvJgqexb1+Z4th+EOkHvk+YgZ92JHYkeeG4dJZU0Gq4bTt85XAJs+hOB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB8989.namprd11.prod.outlook.com (2603:10b6:208:56c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 02:03:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 02:03:23 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2026 19:03:21 -0700
To: PJ Waskiewicz <ppwaskie@kernel.org>, Alejandro Lucero Palau
	<alucerop@amd.com>, "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Message-ID: <69b37069af0f8_b2b610068@dwillia2-mobl4.notmuch>
In-Reply-To: <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
 <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
 <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
 <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: ced694d2-f184-426d-136d-08de80a4b4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: hQSijvHMsorRPRWFbB1IMsunb2GNhAN2480EfUTyGa8XshxME2VU66M8SUw2V6GmSRiY0TGsWK5hNi3+b+pneQa7K3q6ez6O4EBm5kuae5cr2eAV/vOZkLci6/tq8Dvd1QFajFFydb7MEuswMC46TH/s5rkZSpTQ1KfVXFeTuQk+FmKAmn/X3Ut1r0mFq3s9dwB7OqwaA9ft4Dhw+jqFglHRpBsjZutnJhA4zSacscMUqG5CCXO+CbvkIVoQfyMvoiyp08Ves6DyhK761YkMEpbApN8c88Y63iQwcFVfRf9Qylg3c6SSGTp83DUp0KsVClcZoVoM3mpORhTTcdsYAhGENyrMu/jb2P6sjkJkZ4qtfzauf5k5zsX4LgDtQDj+g3PJOOswfeIFFa7ubxublrEksMXAcQHqKrW8Ule+KuJtLXG9Hc1qKUgAXmm1dbDKD4d7xUerm3y5VbCCbobPeEpJmNQLON0K+AiZJzOoF+l3BN696zW7UUCCNMofeylwBHLD78uUOvqx+PtZ8rMyJF/yCPD3ch76ZduDKftcKA6NT2nYDbeeIpZvgfXhWgAuM0o+N0x4cdXf56Lzb2Srzq6TzIBHfwMDqXBZFCgpq9aZS6t9CJqHeX+1PMy0JuZ0GRPjcoxe/I/lL7S2/RlM/NQQBJubDmx+vojjgEioLuCZrFxCvBViNZEB0r2nspoWsSZywiHUH7Juf+ZPXy6nHafEtjBnBC1rGGVbmaf2qdIi/ibUO5qKW1D5HF8pzczu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRidzhuMkplR1dHZGc2Zmwzb3pzQmU2aWJnMjJnajRZcUV5a0FadnQvems4?=
 =?utf-8?B?N0VOeTVBQ1k3dDR4RmE2UzEycWYzR2ZxTDZicXREdlhKQVgzNjNvcUkwdWFI?=
 =?utf-8?B?NWR3a053YSs3T3ZUR0RhZlNCemwvZzlmdDFtNCsyU0cyN2F6ZnR5akZzS3o1?=
 =?utf-8?B?eXpjOUx3eHRMVXJPMGxpYmVzWWpIM1B6eVBsUjZ1d2xWQVMrN0RGL2xydFVk?=
 =?utf-8?B?R3RBcGJSNUIxYnF3YWxPdnYvYjRzc0FKOEdUd0lqUWVPM0t3dkNXUWpCKzlk?=
 =?utf-8?B?WVQ0elhDbzZjNng4Z0E0b3FaTFFVeFNCdmlUQlpmc2V2cmdsa0ZPc1V4Ri85?=
 =?utf-8?B?YUtrN1hCVm9LT1o5UmJYQUxhUDZsc0VzKythd2VzK1FneFpaWWxjZkp2a0dY?=
 =?utf-8?B?ZDFpTWdFdS91TWY0YmhqQVNWQmJHM3BkSnRneXBoNzVEM1E2a0dNMVRWVURC?=
 =?utf-8?B?Ymx4MStYVWFvK2pXaTM4eDVvZU91UC9QMEZmdXZ6U0tjTGMxRERVcmVwbVBw?=
 =?utf-8?B?amVGNWIrU2FmdGR2ZURXTFMzODdudGtFR284VFNUU0w2VnBmV2l0V1BMbmRw?=
 =?utf-8?B?clgvSUtKRlptYTRkM28vVmROK2MwYWlrcjJJY3pBMVFWVFh3Z1h3bGlrWVJw?=
 =?utf-8?B?K0FpNEdkSVgzTDA0VEhYQTZXRWcydWgvZG9KdzYrb2FBZWJabkhjWDFoU2lS?=
 =?utf-8?B?YVF3b05DVC94TFpKbVd3V2V5eDZwOVU2ZWx3ZkIra3B5RGgvY2NYdzZyRXFC?=
 =?utf-8?B?TnNoUGM4RFN0UXhMcmNNKzg3SE5MNUtveSsvaTM2dTNzR0kzVHA5RVU1UCtm?=
 =?utf-8?B?eWNBSGpMMEZOUG5pN1RqRk1HbStMbWl5cGh3WGttRGpSbUdLQkRoVFU3NDda?=
 =?utf-8?B?bStGT0kyNUEzNTNZeE1BRjdtMWxsZkJhaG0rb0tUaGpaeXVnbkVVamZ4d0J3?=
 =?utf-8?B?NEV2UjVVaUcwMVloL1VXaWpwWVhXSzBVSktEVE1Kd3Z5T08vMnF4N2JvNW5h?=
 =?utf-8?B?WEVNUVhaUGdxY1lYUXdEY1JCTkVpSGQ3VGZ1VDlQbFdjcEZTMDIxMVBUaFV2?=
 =?utf-8?B?QnFWQTdVQ0FYK2EwNnU2dm5FS1Zkck95SDZac24rcVg3N0VqYkZsaU1HRGds?=
 =?utf-8?B?VTlGeEZWa1NXVmpBT0t5QjJBWFp5MjV6cVZuKzRJUWhnT3pUZEZtWnZQYWZy?=
 =?utf-8?B?TUdvRXpkdktoZ1BjTjJ4dDNhenZJYlVQMFFLTEdKYlpGeFFZdE5CbkgzM2lw?=
 =?utf-8?B?b0JCL0NjMURwNGJ2QjRpbjg0MHcxVW1zamZPa1FSbW1tZlE4Z3gyVDVRWjV2?=
 =?utf-8?B?K0srazd3MzFqd1RLbmFBVzM0Q2w1TzUrSmFnWWQvRndTbGo0SnpBZ1JKbk1o?=
 =?utf-8?B?L3AveG5tU0RiZjg3aFF4WUozS2xnZUVjNEFRY1lxZ3ptZTZxazUvNXVzQWx3?=
 =?utf-8?B?NXlRaXd5d1JiK1k2ZllPK1hwbEgwVFRvNk92aUpGSmRmSFZtSXVwWitJQUtX?=
 =?utf-8?B?QjJxY3BMSnA2bk9tbHF6WHZqZUhVSDdzU3d1NjRLcnRIMW5ZUFNwUXJ4Vmtz?=
 =?utf-8?B?YlpRb0xESHhGUGNoNm0yaDZkaXptcDhBS0tudzkzS3JJcXpIdmtmZWZOTlpE?=
 =?utf-8?B?WlVncUpOWm1LWCtXS3d0cjdpOG92UDNDMjc4MERpbDZhSUdTYThLb2djMi9v?=
 =?utf-8?B?M282dzB0RStwRTJEVUREYnlNa0FmTGUxZFA5dGNsZWsrU1hqc2JGT2t1c0Rj?=
 =?utf-8?B?eFpwNW1sek5GQzZGbEZEMys1bVdWeU10Y25CT01MZVF2Ky9Ec1ozS2ZZQUdn?=
 =?utf-8?B?bEI3WC9GV0hRRzZjdWhMajdFV1dhQ0l6RlRUbmxpSjQ4aHN1bWVsZHkyNWlV?=
 =?utf-8?B?Unp6NEdqN1ZnZjdYSkdvUHdGNVFSYTI1dlNnbklkVUxWMEhzUjkzdE4zVDha?=
 =?utf-8?B?RUFycVU0cTAvZHZCeklhSXJjWGh5emdyUFBKMjlhb2tieGVuSEZPK2RiVVZp?=
 =?utf-8?B?aDVJQ2tJRksvWkRub3hPU1FVdE5ZVXFOTTFzM2dhaDRiLzM5Y0dtc2RURDVD?=
 =?utf-8?B?cVMxRThmZloyUm1FZTF2YTQ2UUNPb0J6TldnM0JVd1MwcnNpTEYwRmRNaFhK?=
 =?utf-8?B?dHhIWlVVTDJuOE1uand6QjF5bHJlTld1WDRlYmV5RVFTMTBxeSt4eUErQitn?=
 =?utf-8?B?Z290R0tCZ2NxZjNHMks3SEtVbWJuYlkyQmhYYTl5bC9FVGV0ZExOT1RFaUlk?=
 =?utf-8?B?UWJRNVl6M2NSM1NpUGxOVUJ6aXpHdll2bVluRjBtZFdPNHg0Ly8xYWwzWnEv?=
 =?utf-8?B?V3E3WDhmZy9zNUN0M2ErYjk1dnRHK0ZkL1g3Umg3VERNMmh4Z25XdXZCdXo3?=
 =?utf-8?Q?it6ikamHTCSf0ISU=3D?=
X-Exchange-RoutingPolicyChecked: Rb29NB7ebnDCrigLiQWWv3XbftOpm83bgSydI8t3ViDHV1AABx9ihQAHWm2T5OSWpnae0l3a0jdFr6B3FXkmjAaMVnsAo1GjOuRW2BhSfJZ4mEZc1W78upbgk+Oeh7cZFep1Ah5WgBiCD0v8/kevDPw/hvejVZNXKD8dBLYMXy8GAgDOcA46y6x4Zt4SE+W7TU79EhhuKVle98SlrEOHcrhCbhTvgjDHk0m0S7q6cbKi5OFi5zmTlMcBXJxdDyMFlIjEfVLF2KbbWtxrAL/7hWbo1vVYa7+D2/kEgTdziczzmtvppTGoqftlmRYbasuqZmo54wHETAv1iZc0er+Hig==
X-MS-Exchange-CrossTenant-Network-Message-Id: ced694d2-f184-426d-136d-08de80a4b4d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:03:23.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hgRgXer3GF2nj9qQWZY3qYTM+2jSAVEIHVMnWTFm90gFD/ARcctiYZ4K+lLR9UwOj8MZO+krF6/uYYCOV6MqlXNPeLMioG9ZiXTXpo8KBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8989
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267265-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: F0C8327C767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PJ Waskiewicz wrote:
[..]
> > Yes, I think you are right. This works in my tests and it is safe 
> > because I check the region does exist before using it. But the error 
> > inside sfc should then not be fatal for cxl sfc initialization and 
> > fallback to the other cxl initialization possibility.
> > 
> 
> So I'm running into this situation I think.
> 
> When you're testing, are you surviving a reload of the driver?  Right
> now, I can load and successfully create the region0 device.  However,
> following the same teardown path in SFC, I cannot reload my driver
> afterwards and map the region.  I get:
> 
> cxl_port endpoint5: failed to attach decoder5 to region0: -6  (ENXIO)
> <driver> 0000:c1:00.0: CXL found committed decoder without a region
> <driver> 0000:c1:00.0: CXL init failed
> 
> I'd be surprised if SFC in its current patch state would survive this
> same insmod/rmmod/insmod test.

So over here [1] I reviewed Smita's patch to stop resetting decoders by
default if they were part of region auto-assembly. While that stops
resetting the decoders it does not allow the device to get a hint of
where it should place its HPAs if the decoders get reset while the
driver is detached.

I am going to draft some patches to allow an accelerator to mark an
address range as "designated" so that it can recall the memory it was
assigned by boot firmware.

This also dovetails with the conversation I had with Paul Blinzer at
Plumbers about an ability to designate Soft Reserve memory. So a generic
facility to designate memory allows accelerators to recall their address
range if the decoders ever lose their configuration. It also tells the
rest of the CXL subsystem "hands off, this range was accelerator
designated by platform firmware".

[1]: http://lore.kernel.org/69b1e0aacb9d0_2132100c5@dwillia2-mobl4.notmuch

