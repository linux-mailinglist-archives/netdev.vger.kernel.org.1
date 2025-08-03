Return-Path: <netdev+bounces-211489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E39B1940C
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84777A36C2
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635172586EE;
	Sun,  3 Aug 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kP+My3w9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C01CD0C
	for <netdev@vger.kernel.org>; Sun,  3 Aug 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754224772; cv=fail; b=TKznoxIMpwbvkgNwqldXNAsGJHXeSaam+psJH6eQ90uS8eBDoufvnEC0LkCSmW2HCieNkuYO3ETPXq/9F4qmodxYRvRMjgGQNBQS78CZGevXfoxC6xLzFjjCNqbOFXi5gVr2c6GRAhUwG8rlC/QEr3BMVi6iyeewOmNUxAkbHrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754224772; c=relaxed/simple;
	bh=fgoLiMHvWCF0ofIcL6HgXNov27VeIrT69FWnHMngONc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RGewqFVOGhNLLjWYDftCAhPn+hvOW98JGk+L/ed2KQqus+qKSIn173CQMm60yNXLW1u2nZKrFGvG7XrOX/bdhlel9ZQADYiBFT51OtUnDADbeGYZ4hJG9G93YowqO5GjuEfl0OhHRbrq8qs0a4mZ+POd8DlnGzWGvEC2WLOLCmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kP+My3w9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754224770; x=1785760770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgoLiMHvWCF0ofIcL6HgXNov27VeIrT69FWnHMngONc=;
  b=kP+My3w9PkbWlO/Y3nG0tRi1Fk+RNE9zGfY89OP2N286P1heYsR0rzjU
   eVuygCDOqCQJNPh64HHobIS+JsdXhjsY3Qum1fE3DOrMZzpVBnd0vmQxM
   MJ01GzRtXsPlo86VVzeAdGQBW7s9KISFvmAUe9ye1yLEZENK6iA1rQsX1
   9yNTI2I3p7N9FBz0FRLEkdtMmzDY5r8DswlQynthWk+e5LDhyOR99Gzfe
   iqQueV2QKWfs9l8aHt0SMprXt/UTx4SqDXTvbecdheYK0xd0rrlzf1JwA
   rMuKF8JmdQcwPR61luAkGxGizavfZSpEYqaEooVpHsq1ul/up1KpDpNac
   A==;
X-CSE-ConnectionGUID: z9/HbX33SSGBzbCoWWbDug==
X-CSE-MsgGUID: Gbw1foywS+WiecyOAfdLjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="56205476"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56205476"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 05:39:30 -0700
X-CSE-ConnectionGUID: r6QFjOqkQ6mLYqPtsTncUg==
X-CSE-MsgGUID: qOOyG+/kQGWv4Cm0hG0Ieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168141639"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 05:39:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 05:39:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 3 Aug 2025 05:39:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 05:39:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogzp2rzMG7wuwKaTLKpNpPewWZXYrJ9JiARM9m1Y419SRModm8aTjBcAS5z7aQfKAWCXEVZZsOgGCIt9HxWB0zAHavuxOmnGwytez4lsGYIZZjNFq5SQ9ktxRj/jMPkMEXIRJYZlVAaLQDpcHq93ePzYceSZawTEAPTHKpFfa1cDW7Mt3JSi7fcIUkmswAHsLXpvidEhK9XQXlk1Go6/pFoGnhVkhZTUuFKZqZ8nexq50/RsfAIVZlpZEDgwQ+3RgSwNkyeMACsaFnsF+j+2rLYLQETE4yKlSgpVJI9pvWUiEnTb4GVrhzivdZy+TsR/3ROYfGrKGAEAurzhDg6/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1T2+rE+2wSzjjSrNLsxUXEfQpzlzO6ngJ+cIkjzi4U=;
 b=GBLsESKGERb72YXpixeGXAQTxLgPuMysI7wpr/klsS4qFucrfX2GZDysHRMJP5vjlT6wLfOAI+sw4/FNEa99TOPn6cJDjONnFHKTUZeDrkpmdxRhLibhnIkKPzRDR5hZYQaNtdPBdE7itAAAf4D0tUTxrzOLld5mIaMv6nsGlz8c7K8dDsNTphibcADXf1RetuosBSj7QBOMv6ZCp2r/qlFByD1zZa6JOnMZuZSt4DHdgLrAQrLpK6cY91F0yKiHLL3CtGXgreUibWCBxWIOZ8mh7rvJOxgzQgSSNAhh/PfdT6s9BsocBcNtbsKvyJnJCY4qQQavirPNXzBh9tq/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF818092190.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f34) by DS0PR11MB7457.namprd11.prod.outlook.com
 (2603:10b6:8:140::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sun, 3 Aug
 2025 12:38:54 +0000
Received: from DM3PPF818092190.namprd11.prod.outlook.com
 ([fe80::e299:d332:ba8:87ed]) by DM3PPF818092190.namprd11.prod.outlook.com
 ([fe80::e299:d332:ba8:87ed%8]) with mapi id 15.20.8964.023; Sun, 3 Aug 2025
 12:38:54 +0000
Message-ID: <a9794885-5801-401b-b892-f1fed4157a4f@intel.com>
Date: Sun, 3 Aug 2025 15:38:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>
CC: Simon Horman <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org>
 <20250730134213.36f1f625@kernel.org>
 <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
 <20250730170641.208bbce5@kernel.org>
 <e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com>
 <20250731071900.5513e432@kernel.org>
 <f27620c4-479b-4028-8055-448855991e6a@intel.com>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <f27620c4-479b-4028-8055-448855991e6a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To DM3PPF818092190.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF818092190:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e94c29-95c3-4a60-0b48-08ddd28ab508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEJvbmlPcFF2dS9iOGkzd2RjK2JieG9BalM2WHlxODVuTkE0K3JCY0lrR3gx?=
 =?utf-8?B?QUVYbmlPaDNPVEVFTVZYSmJYZWh4ZGUxMXB0ZndvUlFPUGdaMGpDZWR3Z2Zm?=
 =?utf-8?B?b2FUNElpaFFERm1QUElHRWVLRWYzS0lKMjB5MlpvWGJUR09XR1UvOFBJOUdE?=
 =?utf-8?B?Y0liZ3pMNW1oeC9DMEFaRXgzQjhDQUNaNGRCS1lBSkdjRzJ1UFFGODdLN0VR?=
 =?utf-8?B?Y2UvcURqaUhqUkVRbWp1cjgvOEt4Z3NNZ1h1VEhtRHl4eUlnZ2FJcWRnWk1p?=
 =?utf-8?B?OWs0ZTN6c0gxTWYreGJJaTBnRnEyY1N0ZTUrTUN1NlM5YXJZVXR5b2ptdDVs?=
 =?utf-8?B?L1FHQlBwUnkwZGhTUXpZMU43eE0zZnhZdHhZVFFEbWtUc3FxeW9Faml4bHBD?=
 =?utf-8?B?djVDVUp6WHlBYXAyVEc0cHBmVTU2N3M5TDJLdGtlSDlMZWFRM256SjBxOFNS?=
 =?utf-8?B?d0V3SHNpenFNMDJMd2RuZm9lWTJzZGoyYmV5U0dkT09iOFNQU0lhYmJPekMr?=
 =?utf-8?B?MXEyOWFMWHcrR2EwbmVVUllnMFVYS2ppVmJrWkZaNXB0ZXI4dHRlQmJQM1Nl?=
 =?utf-8?B?RzNCNGRHOGNtTEsxNktaYlNxbDN2SkVPNUxxMHJWMm1uaHFSaXRsUUlQMHA4?=
 =?utf-8?B?cEx0VXdVZUJzdnMvRjg5VUdoZUxBNGw2eGhCaE1hUG9OUjM0cUlaYm5HWTM3?=
 =?utf-8?B?MHhRWkVrWlJxalVucmpQVWVrNTFZY3FXeGY1ZUdScDZOaisyQ0s2OTdDTTkz?=
 =?utf-8?B?YTVjVUZKN1JYUXgyUDk1M2VTUmhhZWlQYlQ4RlQvSW10UjdTa2I0MHA5QnRh?=
 =?utf-8?B?aFhkdUtSdUxQb3kveklPVDlFWmNWRDkzY251T3p1QUxyc0xTdi84QkRFaVpm?=
 =?utf-8?B?N2p6Q2xTdzdvVGlWMGljWWhEamtsVWZYNmNjNnpGMjZCNmpwZVBjRFFWd0Fp?=
 =?utf-8?B?YUl0RUpXdWxXd0hhZ0pwL2J4TDcrWDIwNlI4SE82dWUzNHJHUHN3RncyTjls?=
 =?utf-8?B?YXYyUXFoaExIMFVQZldjUXBFcTF2QmZNajNCV25ZeEFCWkpuVGZrMC8yeU5U?=
 =?utf-8?B?M1lwZGQyRzFhSklSQWxHTmF2bnRUemlJUHFTNWlmalRJUDkvZndGSU0vbUhM?=
 =?utf-8?B?RU5xSVVaQXZmc1lHSllmRHV2bzVCZ0pqWE1hb2RwUGpPRWJwdm5tQWlyMlpD?=
 =?utf-8?B?aHp4bGlXd1R4ZTNzRm9wMk5pTVFBeGNjaTBiSHBmZmZEM1czOHgzQUN6ejZN?=
 =?utf-8?B?d01VK0lkdE9GRE1ER1RsbDF3cGdDbUtrL1dwNE1xNnRjcWxBMFUwNkdoUjRZ?=
 =?utf-8?B?S0ZsTExXd1dKRUFZaWNkNTE0bis0YzBJUXp3a3FUaElpRVZCemJQRk5raUJn?=
 =?utf-8?B?cEFoMDJwcTlvNHUydEsyRHFDQ3ArMVNIaFhyWC9Ca3YwckR5c2VsaUlXZHZ3?=
 =?utf-8?B?TWdoc2E5elZqNTlGQ3hPdEk2WmpsUm4zTGptdEhzSWlrOWlQQzVVam94Tkhl?=
 =?utf-8?B?RWdpR0hYajdDdXNUTmJrT3gveCtPd3VZS1N4TnlyOVF3WWFiblRHT1kxNFA4?=
 =?utf-8?B?RzYza21vVHJhWU5mdVprTk9JMkc5bDRvcWVPN1A4RE9KTDgrdXZoOTVwZWNw?=
 =?utf-8?B?MldWWUN1cHBxSDkzSzNnWENYRVpnRjE1TFR6Z3Q1aW5YWUExLy9hOG45THZr?=
 =?utf-8?B?R1QrRDhQdmtQdGp6TUJYOTFFUEcvQWNDd25DUmxTY296QlNjQTFRbklXenRK?=
 =?utf-8?B?aWNycUFobm1Fa1V2NHRiVTBPUW1EbXdsalE0NHA5enNnaFAzdjlENGFZKzdG?=
 =?utf-8?B?a29WSjV0MzhxOFNXS1VvVUV1VWhZTjYzZituaWRscHIyOGVVUzRwK1dibnVD?=
 =?utf-8?B?L0ZoKys4Um5FbFVjQnZLOFNTQnozdlR5VnRLTm14djJCRmJoOGJQOTdQbWNy?=
 =?utf-8?Q?ujL88XrsIQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF818092190.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJIVDdPY0Z2WG8xMlZKeWRSUzJvMHZUZXZIOWRBRW55YTY0SzUzUGtEeFhQ?=
 =?utf-8?B?ck5iYTBzbEVpV0lVVEhJZDY4VUZGSkVuekQ0eHZyNE9tN2JLcEgwMG94UEZJ?=
 =?utf-8?B?V3ZmVlhZb2RpR2p0US94aFNDd2YwR0lZWEtmUTFsbk5FTnZ2NVdrT2RjM1V6?=
 =?utf-8?B?eXlsNGtQcWxmYVJYS1lyWWdweXduU2N3QlZqR2ZEV0loWEdzb281aVplTHBv?=
 =?utf-8?B?S2FtSVFaOURFa0ZuMVdySnMzMG1xa0VGMTROa0pHblRpSW95Z2ZyODBYUVd0?=
 =?utf-8?B?RVVwdU9hendwbGVjQk1TeEVhMEpnM2hZNE9uWllQbTc1R0xjVjgwK2E0MVlN?=
 =?utf-8?B?SlpweEdNYi9zQmJKMURuZWhWNlJDZFJsR2JBVGNQMkwrR1ZtMEZWWWdMQUp4?=
 =?utf-8?B?c1NQbHZaQlcyWjVYZmZXK29ZTTRtSzR0bmM5VHVFWmoxeTgrSWNQY2JjTXVv?=
 =?utf-8?B?ZEdCMy9pTEFnYTdPMHRDdWRqVk5QNWtQKzY3SjBaUE1RMkpiUkJKbHdycVJs?=
 =?utf-8?B?OHlyRmFVTWFLSmg0QUFLbkhGNFhwenZManM2eU9TK1VOZ2JtckM1a2l0Q0dy?=
 =?utf-8?B?RExORkpvM3Q2VVBraGRJeHhrMUlDWFVtVy9FdDB0ZXkzbklMTmZ3YytkRHp4?=
 =?utf-8?B?WVFncjA2bzZMdHc5UzErc29oUUx6YjQvdHRlMW9EM1M5SGlpT0xBU2JvTEV6?=
 =?utf-8?B?cm0rUkFmbGVkbnJkQmU5Nmt1dHlKbW9taXBTWDJCbnFYY0Y4T2RlWC9hZkdQ?=
 =?utf-8?B?bU1icE1DYVAvSlFaRTJVSU1xVE1nMzZXT0ttSVIyNTNUd3d6NWsvNGpRNVVG?=
 =?utf-8?B?aDNDK3dqdFd0cXV3dE5mZDdqMUhNTTFuUmlSRXZ4VHdrNXVLaEU0YW5XbXB3?=
 =?utf-8?B?WWRocm5lcUFvMjJkRlhTZFBUaE11UVR3cHlrTDNYSkN4ZjMxTVlGT294VEVM?=
 =?utf-8?B?dWdiNXpLMEVHZlZ2S0dFamo4N09qajFyeHlIUmtXWDhkVElXbWVBK3V1eDR0?=
 =?utf-8?B?aGtIVUh5TGdxZUJYTjViRnViMlFwNjIrc0RwdmJyaTl3c0tPN3BuOGhRbmx6?=
 =?utf-8?B?cjVwbnJCV2lRM3lBUFdSbEltdzA3WGo0cU1qaEwzRUMzRkFoM2FVSE1KM254?=
 =?utf-8?B?R2M2YkF5MXRjWmxDb1A3bitNYVVJcFVKNDUxMDFoZktKbXZ4ZnpUeFRUZUt1?=
 =?utf-8?B?b1BXaTdyeGM5Y1M3b3JvTWp0UXVGNlBRUWk1aWp3WUNSWXV0ZFpYc2loOE1P?=
 =?utf-8?B?eis2V3JYVTRpeDZyL2NFaEFPOXBIajVySEhybUYweUNqKytQVlNXcUd6alVk?=
 =?utf-8?B?b3ZybXk4RlpXRERSWUxIZ21tcEtuRExKTFRCQTI5Sk1pci9CUGprZktNOTZO?=
 =?utf-8?B?c0VNN1VPaml6S2ZlbFBoNWpBN2VlcTBoRjdQTzdQWnEwTjZFakpyamZ4WXVC?=
 =?utf-8?B?OGxYbW9ER3hiYWxmNGhOZDBtYzNCRXJoOExpdXIza01oYmVDTlJmZGZtcHVK?=
 =?utf-8?B?YlJ2WFJYMlFpcmV6VWxnRVQyTEFUWVh0ZFh6c2E1Rk9JSzV3RHhQZnRQYjJJ?=
 =?utf-8?B?WEZveC8wWFhxczduV0xrN3lWQnlRQUdrYW5uNmVuQXZuZXFiTEtDZzVibEZD?=
 =?utf-8?B?NVlaSSttOFN0NWRkTFJiT0Y1YnhGTUNWZjF6RG1QUysxb0pNRzA3NTNMR0NJ?=
 =?utf-8?B?ZjdlM0U5RHVtMERWMUVxYnRpa3pwa0NTMG93RHZnYkxhdWJGdGZCaVQ1WDND?=
 =?utf-8?B?Q2Yxd0xTNUtWVzh1c29OSWRXNkxqcVZ5allweVlXVE1XNEUyYXIxS01YYjly?=
 =?utf-8?B?OU5YOFRUZmRGSXUrcmR5OGZwbGlka010ejBRUUhvbjZLLy8xU2wwbTRlWXA2?=
 =?utf-8?B?bFJLbmt6TFVHaCtqWnlIakxWaTlNYXc5M0Y1aVBxQi90RlVrdFpFM2xFV0tH?=
 =?utf-8?B?RjB1N09WRjVJRk0vMUQ2eTF5ZnVic0w1NkZmVE5FYUtJWmlGMW9sMU92V3hj?=
 =?utf-8?B?Y041MEtUelIzbW8wQ2RubmN5dW5XYjhBN1VpRVVVWXJuWllWY2c2aGpSMzRR?=
 =?utf-8?B?NXlmN1pWVzJrL0YwTG5zWUdLVG8wUkNMcHlqR3IrZy9wb0RSSjJGSEZQeU0y?=
 =?utf-8?Q?6JRtbgTflm2VU4Xm81ZBBXHiL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e94c29-95c3-4a60-0b48-08ddd28ab508
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF818092190.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 12:38:54.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl/cPpDWEccRYLXUhqmgSbe//EZny5sgBe4tuzCYG6FDVnNS/DsguslqDomX3US3iHpbxLV2iEsCM3xvQHR2hVFHEY6OoB06dLNoJuL9Csk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com



On 7/31/2025 6:51 PM, Jacob Keller wrote:
> 
> 
> On 7/31/2025 7:19 AM, Jakub Kicinski wrote:
>> On Thu, 31 Jul 2025 10:00:44 +0300 Ruinskiy, Dima wrote:
>>> My concern here is not as much as how to set the private flag
>>> automatically at each boot (I leave this to the system administrator).
>>>
>>> The concern is whether it can be set early enough during probe() to be
>>> effective. There is a good deal of HW access that happens during
>>> probe(). If it takes place before the flag is set, the HW can enter a
>>> bad state and changing K1 behavior later on does not always recover it.
>>>
>>> With the module parameter, adapter->flags2 |= FLAG2_DISABLE_K1 gets set
>>> inside e1000e_check_options(), which is before any HW access takes
>>> place. If the private flag method can give similar guarantees, then it
>>> would be sufficient.

This was precisely the intention behind introducing the module parameter 
initially. The private flag isn't a comprehensive solution—it's more of 
a mechanism to allow configuration changes without unloading the e1000e 
module.

>>
>> Presumably you are going to detect all the bad SKUs in the driver to
>> the best of your ability. So we're talking about a workaround that lets
>> the user tweak things until a relevant patch reaches stable..

Regarding the SKUs: the issues we've encountered aren't tied to specific 
SKUs. Instead, they stem from broader environmental configurations that 
the driver cannot address directly. For instance, misconfigurations in 
the BIOS can only be resolved by the BIOS vendor, assuming they choose 
to do so. Until such fixes are available to end users, the module 
parameter provides a practical workaround for these system firmware issues.
>>
> 
> I think you could just default to K1 disabled, and have the parameter
> for turning it on/off available. Ideally you'd default to disabled only
> on known SKUs that are problematic?

As mentioned earlier, defaulting to K1 disabled isn't ideal. While it 
might help avoid certain issues on specific units, it would negatively 
impact the device's power consumption across all systems, the 
overwhelming majority of which would never experience any problem. 
Therefore, it's preferable to keep K1 enabled by default and allow users 
to disable it only when necessary.

