Return-Path: <netdev+bounces-169217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D34A42FD9
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26B83AB0C4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6221FBEBF;
	Mon, 24 Feb 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7udzYgX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE11F419C;
	Mon, 24 Feb 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435163; cv=fail; b=hQzmtFoJ3aYg1WaVsucOQ7PVXkjiTC6GLKbdQjPp0t8Z115L7YptU8jMUDABgtGS9i1fO1+PxsQhNpjrDSRv+dXL/LLzl9FiJaYscG/QJs87LDGrsNuZ4UIu7Quf5w+oANNMjvUm6iV52G8pzByP5CPE91YNJxae3XTcjvcrBGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435163; c=relaxed/simple;
	bh=N7WRof2pOHLmg2h9ihU1vpi0RWygrEAH2VXVFw6Q0mU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QV8N1Yoj6NhCcUyYQ+yxDDuyu5P0jhWzfBQkyW/z4J3+tbRNpExB9PcDS6CnTTVP1ucA1Qwd1tMIAA5nf/0NyQuFmUgcqv3V8aSzDLqlXl7dbDOzb4uCPbpDe10/QrzRtFODXGm59iV4vd2STfdm9wE0U8SEWh/BNCvnFgwge8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7udzYgX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740435162; x=1771971162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N7WRof2pOHLmg2h9ihU1vpi0RWygrEAH2VXVFw6Q0mU=;
  b=A7udzYgXTlatQNIHH9/keVAdupC7Rhe8Hg6EltjhB3t1JUNKgwKRT2yb
   QtiOpsrJbhEHlZDmRxScN0w9Pt2cm8iQ4odNbMxpPw4YZb/AbgWbOyb8J
   iE7fMCD5k+vwgOe7a3HLh7jydfoXQdb4bT0E1tXIcwvxiTwrmVC1jBn4M
   j7dvVNKirSi2hiws4oIFXg2ZUx8IF2f7oOoZ9/kU6SOeQxRZD4/Av2ILH
   G6F1+VJvxYH1TtXd9ocBG6y0/84LwrS16nnwyqgaAoD6EEu8Kw9lBKLge
   6wg14TXv74iIs8N3e5UMPneClj4yN0S0MI1cFVEnMxayZUXIXgnGxNxRq
   g==;
X-CSE-ConnectionGUID: G/yaBn13RmylHuG3aJQSTw==
X-CSE-MsgGUID: rRAw7KRKSzCOqecxkHm0FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44872055"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="44872055"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:12:40 -0800
X-CSE-ConnectionGUID: tckxVScaRoWVryt9AUboKA==
X-CSE-MsgGUID: Y8jirPCrRW6hEFEnnGmn4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116688842"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:12:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 14:12:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 14:12:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 14:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZb2w500zE5s6VWmKFc8DtOqP2OOAxnr4XDQCdhrtrYzeDVMIzOXAU+/9IOQ5ASpfpr/aeQTVyKsF0eMcR/JjG2TTlAKCPdCL52SorODLZfa5260K4mkg57pbRoYsxF13NS4rSvqgIZ1bn0C2OzL+pn9RTI5mJcXQx3dga5dVHUDTsqlyCoxdD7r42FEnc9qfEVEbK1oUMFNzFsrFbY/i2gM7aNy5gR0ao+Z7b9noDcPJyCJd8iTdHVjwA5iMj+6re8W6KnCbi54aRALOa0X5qosUAoWcZNyYc9x7xhAW5MCzqp/EDCQTSkKvtxKiHDRLNmRYKaHsDlgvy9tohBt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGbel38iCEw3vdLJMUlX2n17UDT9BjRe7cQLYFi2jNw=;
 b=wVVnsAYAa/296BTWiMCtiKSrusAfyt6G9xY1Qr3ZLVedw4fx+zy7Dmeu/g0iHaqzkbTFqKsOraEMkgt73Cq0SaUSjUzqZu8jJFUy3aU44suMoBP4S+ZH/4S22dkCvrlPMUJCPJOVz7coyqOf2hDwIJzzUSb7NXxsFITW8py4PwmzKUN9Qu5UB01JVSsEhzZZpyov+nzylAHVIf2Fads7yS3Ci6OahuPf+Q7+nHdq/MLyh4wg7AuOvK/untmFEOXA5ae1lifEYaXTuUs5NbgvaCJ+Ol/HCY9GOOhTYQxFD+du8/5P8k7/i1N1tWKlvdtdcoP11OokgBOXnndqI+Ym8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 22:12:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:12:31 +0000
Message-ID: <b0857058-98bd-4de5-8e8b-e1e52d66bfe9@intel.com>
Date: Mon, 24 Feb 2025 14:12:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
To: Jiri Pirko <jiri@resnulli.us>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, Konrad Knitter <konrad.knitter@intel.com>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	<linux-kernel@vger.kernel.org>, ITP Upstream
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, Carolina Jubran
	<cjubran@nvidia.com>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:303:2a::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3fabe5-54ad-43ec-2c06-08dd55205485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0xvUUI1RzR2WDEwTzQremV3cE9LQnhVUWRveVpiNDZPVnpwV255akNGaW9H?=
 =?utf-8?B?citJZGRQMzYvdjB3d3djamxiU0pISHRiVVJ5UkVpUDBZaCtCbmJ5MWFOZTR3?=
 =?utf-8?B?R0pyZ1J2WUJ3RzVLcEREVUF0WFBHVTNBR1JWdFpnZjkwQU9xMXFxVmtmZUNQ?=
 =?utf-8?B?T2lnMTdnOXhpaWc4cmVwMW9CU3JWdmlXQVNyZmJ1VmxKRDlnZzk4RmJVTGxp?=
 =?utf-8?B?STdwc1NGaDdyNDIwdmRLOCtmZzdodzVGZW9tNWR5djBkbjl2NFlEb1ZTUW5V?=
 =?utf-8?B?Qys1dHEyekJoTDNHeGQ3YmpyeSs5RFlta3VIQjhBZ2o5bGkwN3dQQWxROHZk?=
 =?utf-8?B?Uy9YT1FFY0lLeUpScE5uczlpcmJ4djdUUVNod3pmK0NuZzBmUHB3V2RMSTNY?=
 =?utf-8?B?TTRVbGMzcUxxQnFUN2k2SVhHb3lmSi8rdGtUM25wQzQ4MXBvNlRjUWtUcjBG?=
 =?utf-8?B?V1ZvRG9WZUxFMEtmQlVocE5ETmdWL29Qak5kSUZDQk5wUFhNSURWVUI2ZFFz?=
 =?utf-8?B?WkY0NHFqYlYyeHQwMXE4Q2lEWVpvSHNqMTJyYUE3WXVyWWVLczRaemxtN0V1?=
 =?utf-8?B?UXlqOU1HQk54bVFkTVpoZjZEWVZJWGdUR1pkSWF5NWtkWVVlVHErVHlmVElq?=
 =?utf-8?B?NVRSN0pRb25HRmlEV0d5TW5jbktoUFdDMHJSZzVUK3BBblBxQk9MaHRlNitN?=
 =?utf-8?B?N3lOTWVsUmNKRjZpUVV2ZGFSQWdMWW84NGRGTldCRVN6ZEMrZGtPVkNuK2l4?=
 =?utf-8?B?ejhCb2kvWkpETWYvZlZFeDFLOXFDL0NkOXVYMTd4K29VR29kbTljR1J3VGxa?=
 =?utf-8?B?aDFOaUZGWWp4d2dwb0ZGdUwwUVM3Vkxjekd2cFBnUFB0MTVkU3VmTkRFTTdp?=
 =?utf-8?B?a1ZYRzhlWWxwemVJQ252NjU0VDhaemNFWlBxSVVhWGR3ZWwvMUtyZ2JINjNK?=
 =?utf-8?B?K1hYc0Npa25EUDZ6U3pLMUNncStQVHJHRDN4VTZTTjZhN2kzUkc5TG5ROXkw?=
 =?utf-8?B?VUIvbnMzYlRRMGtyRDJ2ajV6YTZtcTBVQmJmN1RpVk1HUTFtTzVxMUJhdFFl?=
 =?utf-8?B?Q3k3SjBEdE9SQ2YrS0oza2QxZXNRU1FYemZDZEs1SE4wT25vNlp4alVFMzN3?=
 =?utf-8?B?NWUrS2dlUDJwK0V0WFMrYnYwSVg4MEdlVTFXNGFmZy9LSkl5bnJxaG5CRkQz?=
 =?utf-8?B?eVZ3NDlQREdZK3FVWlZudjVUcGdON2o5akdlYmk4Z3lGRUM0NVZCTmVnei8r?=
 =?utf-8?B?a0RKdkJQalZYQlpnWnN4T2N6RnAxSjVidzV6cVFTTGdsTGtDQUFZaS9Fa0ww?=
 =?utf-8?B?WVJzbEFOeHllTnZEY1BWdG4yZ3RGMlI4YUtZK0NVWk1aajBYejFjVlExZSty?=
 =?utf-8?B?MHNhd01aN3liRDFzVmp5OTkvb2pHSnhuU05VazdDejRubGFzUFhrc0hLNmZi?=
 =?utf-8?B?UDZldnZ4YzR4ZTZRb3M4Z2Y0ODJpTHRlTWRUT1I0elJubHVmQTBKUlhNb0pz?=
 =?utf-8?B?UWlpUXIwMFRoR1JQeXRBTTZCdFVKbm1Jd2ZpMGlQdUEzU0dxTGZxTysyQnRv?=
 =?utf-8?B?Y0M5WURlNnE0djRRZTNvVDI2M1JpbGNFSXAwTm5MM01TcmIvMHFXQ0ZRSTJ5?=
 =?utf-8?B?Vlh0c2cydlA4ajlheERjTnRjUXlLYVdwdFFSNXdmK29uOWh2dWJycXo2c3o1?=
 =?utf-8?B?WFI3NWxYUmJVa1o2ZEczYVVHWTJJSzFpQ3Q2SmVDNDRpMFhQQWlxbkppRzVy?=
 =?utf-8?B?VFdac2RObzNrVnVRcEFTaDk1endmbW5pOUZ2eTd2VHJYS0crTGNFNE5Fb05I?=
 =?utf-8?B?NFNSV0tOUldHVGthWTVNTklPTU5GbHRaRUFPekRySWZEOFRnWkJDQUZJTEpF?=
 =?utf-8?Q?ClksHKI8GHZPT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZIeVpnU1M0cjJKYUlBSGVYZEszYW14YVlMdVVoVU1RUVpxcXVNY0ZRM2NQ?=
 =?utf-8?B?b2EyTHI5U1ZIb0JTVkZ2dVJkM2xYZitxQkRqdjdlaXFzR3lXMDlZTW43Y0Rk?=
 =?utf-8?B?OS9sSWNQd2VmZEFrSXJkVkFHR2Z5Y0RlK1N6R05TNW9vUFRZNlVWa1NBZFFI?=
 =?utf-8?B?RythSVhFL2pXZkprOW5FTmRINVVoWGs3eHhPWUEvaFh4WlFOVTFpMDZMeFNL?=
 =?utf-8?B?SThnVFhseE1QaUt0WkZQOEdHN0FDSjhPMVJTVEVRYjV1MVdpOVI1Qnh6ajc5?=
 =?utf-8?B?bmdrMDUrZktJVzdLS2dTTDNMV0gwN2t5eTRiVVFNUlJaZlpwTzlZM2NyQUx0?=
 =?utf-8?B?QzBHZndOODJ3Rk9ZM2FXTXU5elAzaVlzck5NeFQ0U1RKV29lTi91Y1BLS3A0?=
 =?utf-8?B?YlhoaCtEZzFxZ2Q1cWNyUmY4cVFla2c1aytYWEpqb1AwKy96R2I4dkpmRjJH?=
 =?utf-8?B?N2R4VlF4a2VueXB3YWk3MWxCRTR5eGI1aUZmcmtIa25iaG5MRVdPaU04bS9V?=
 =?utf-8?B?QWk2bEJBUWxXbmVqa000WUtiWU1sU2djek5UTWxWWXBiS0tDVjc2dDBlQzBN?=
 =?utf-8?B?MUdnbXoyLzVKL05jSEk0VmJmUmx1VzlJS0hacGxBL0l1RHY0ZzJPWDdoWnNO?=
 =?utf-8?B?SWJLM0tDRGh2RGNvcVFFWkhoSlhIMkdvUGpPZysrTHEzNlVsaWxwUUgwSUk5?=
 =?utf-8?B?cFRrVmxBNU12c1ZGWWpGWkVTbDF5dWFTVnNhbmN1OWMxQWtzaUUwaUJKZk1Z?=
 =?utf-8?B?M09OazZTYlZ4b0VBWDFxc3BYbHVMbnBlbkQyMEppRnVCVXpKMUN1R21NOXZl?=
 =?utf-8?B?S0EwT1BaSmZJeTZ0QWNiWXBkbnFVNWQ4amhtbGlKN25iSDhUMFlpOXdKWjE1?=
 =?utf-8?B?ZjFhKzJQbzMrekhUankyQWVmVE84c1NoOHpWR2h2YmZuSksyL1UyOE5JMEFV?=
 =?utf-8?B?bWhjTE1iYU9aVjRYNlNkUjJOUi9PTkdTNVBRckFqT0d5TVZrRHp6MW4yWjNP?=
 =?utf-8?B?dnE5b3VYbFJKa3pic2NGNHQ4NWhkbGlWbG1xdUV0RXI4ai8vTkd6bHFLUk5l?=
 =?utf-8?B?c0I1R3hoUWpHNmRjQUs4U2dwc3ZIZ2VqSGw4UEpCWmRZc3NnK1FoVW5KSFM4?=
 =?utf-8?B?RjRvZCs2b0hUMjFRcW9iRjQ4MjZnTkdZQityallZZHpES0xEUTU4bjcyaUJF?=
 =?utf-8?B?QmxnWWE3TlRBL2tqcHVSNTFyd05Bdit5Q0N1Ri81ZXhvUTBVcU1ScTZURmF2?=
 =?utf-8?B?andhQkxISGhaYmR4S2g5dFlxYVVDWjQ3YlFBdjRhaVdjRFRsbDg3ZVpGdjNU?=
 =?utf-8?B?YUk0QnNKOEE4ZWNDMEZHT0tRQWwzTWg0R01qaVBSTzJZRTlBTDVlMDBuNFNO?=
 =?utf-8?B?M2tJRCs4TnNyUHdrSDJLNHRSYU0ydTlyeWpsMXZjVDRJclpPZSsrVVZVeFhs?=
 =?utf-8?B?K3JUU2ZBUGlWMjZDUXEvSS9ZR2lDakdYUDFoMEZxTXdhOXNqUktLWndGK0Z6?=
 =?utf-8?B?S3VCcXQwUEpDaWVUOGhQOFpic29tYnhESkt2UGlQZkxjRmZVSXp2dWZvd1ph?=
 =?utf-8?B?dnVVbHdtVHVZSHVIUXpPWmxqZnh4Q2d5RW5aMFl2cVBaa2U3bkNwTEZMWlRN?=
 =?utf-8?B?ckxnbFFoY2daWnlDS0c2US9KN2QzK2FFMEtOZHpENk4rMlVaVWVrM1FUU21C?=
 =?utf-8?B?UnQ3Sm9velh5S2Y0elhFMG0wUVhiT3ZyMFB5RFZXbUxSWWczYXNLdU5WeUFH?=
 =?utf-8?B?OFlPdlcydDMrSGVZVkFvcThKTFU3K0RSejFkRko2U2hUOFBFOHlTM3pza0N5?=
 =?utf-8?B?NGZ0YmZKQTRKMkFxWUlpZFVNd0RKNU1Zd3kyQ1dNdTZMSUFnS0lEb3AvUHlG?=
 =?utf-8?B?N015ckQyUzlNUlNWcDJrYVNadHA0M1l1cTI1MWNWM0hsUTA1dllENzNCTjlR?=
 =?utf-8?B?L1hFNk5NYnhOVWxyRndFSWZkQU4wK3VZSWhrbkJvVHZ2WkJFVldYb0FFY1NZ?=
 =?utf-8?B?R1RvM1djOUhrdHYvekpiZ3RsK3k0ejY5dVo2SWZXcnRkOUt1ZTUrUEpwTGg3?=
 =?utf-8?B?MkY5UlZTYng5K3JkaVRBZzdHdEE1RWtBTktvcGl0Zk9pK2MxdUZpVFhZMDds?=
 =?utf-8?B?SFEzKzdKQVB6VXpRVlNVYlBZOVA2YkVYUnFmSDJLUjhReXFiZ1Q5YWlOK2pn?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3fabe5-54ad-43ec-2c06-08dd55205485
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:12:31.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzWlFos/OOBIDqm4yDUo7Hm9Tl1dy4aM6euL2EI996Es3ObiuD4eNWMlZbUwAQqXmCcYkqcPxP/kpXPY09ON9b+XxnejT7OgEo3ToFSWZM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com



On 2/24/2025 8:14 AM, Jiri Pirko wrote:
> 
> The shared parent entity for PFs (and other Fs) is always reference
> counted, first creates, last removes. I feel like this is something
> missing in PCI spec. If such beast would exist, very easy to implement
> this in devlink. We have all we need in place already.
> 
> 

This is basically what I was thinking too. It does feel like it fits in
the PCI layer better than in the devlink layer.. but Przemek also
mentioned the following from reading the other lists:

> 
> I get that the general sentiment is to "leave the complexities to the
> driver/other layers", but it was based on reading only limited amount
> of internal (non networking) mailing lists.


Which makes me think going the PCI route might be tricky. I am not sure
if there is another way to get that model without though...


There was also something I saw recently merge, faux_bus? Not sure if
that would be just as ugly as your other 3 options though...

