Return-Path: <netdev+bounces-200776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439EAE6D18
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF517B32FC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E532E336E;
	Tue, 24 Jun 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axQO4gtE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD142E2F1E
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784272; cv=fail; b=jVmmEGgue1W+WAqtYtnx5PfBpfhrXkrJZXdnQnALqyLk6cWQbFzGgyD3bD2Ho0o1Nbsejb8u9GHy/4Vr6O9jXK9MqP5TohW+soOr+hhAABiASKEux5TG5uKhebhrasms873haA/c4rAQGsUwuHqbR9nvkjs0rTuAQmWfYjEjWjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784272; c=relaxed/simple;
	bh=73+DTwAoN88ZBJZtA3K1k49yyqpHReYS+AqzAj1J/fY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDpxfygPlWuV0V2LRa7l0Rh6dvkJHGd2MR6vov/Qa0IGK7rfeEZeuj+0kjgbjkzo5d3FE2undt9EypaylKj7RqMrX/ARt86EbOO+wYCb9K/tIca2IyM014apEJkmDoyIoxi8lPGNA7n/HxnIZf/bnq9aYuq0hdtRtRM76x/akQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axQO4gtE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750784271; x=1782320271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73+DTwAoN88ZBJZtA3K1k49yyqpHReYS+AqzAj1J/fY=;
  b=axQO4gtEB4FhFeBOtEYI7+OXYAlggQiUT7RsFkEc5ZIWUivSGblUZ7wp
   JydwbnVxn5EwY3ZiPSW2gKMAvvBLI0OmoEQDZBaL6nHZ/m38yxAiTKI2Q
   pG20Sx95ncMEs/yWvL8fPLDXiIJKyaJYiMGZYWmfdKGSv5elCZWwEGalS
   uYk4PC7WsS3rh0xYASZzK8YiZNOk6kHv7TVh+ZxIEW5pd8cZcec9DXdCQ
   dCR1CwM/NUUtbGRv211uJs/BJifSEW1tRHEH4rhd0jVL3r1uiRiz7mNad
   55S7/KhLpaPQYm2xJFNqXADn2G4o27gJ1DN/lhCt5KZeImygPes99QZwm
   w==;
X-CSE-ConnectionGUID: jT8orKyRRl+tFmoMHMe3Eg==
X-CSE-MsgGUID: oLn25oqRTH+ZFs0orcYEIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64466343"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64466343"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 09:57:48 -0700
X-CSE-ConnectionGUID: ctEVdjNqTZGIQ/WooxnCYQ==
X-CSE-MsgGUID: XLx9OtLhTX603vmlxsLR4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="157459503"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 09:57:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 09:57:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 09:57:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 09:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx9sVdYNadziDW/QIvRW/1JTeZfGYU9x5pzgSCsghYL9jXqR0xEPCRhdpQ6R3eUfAfNMCspG4YGtL4nUMKhzB2QxevaW8YqEgfMmqFFJDInGnxJM7YbHMhnS5Khy1FPcLbk7jECPrm4hi2v863IFyIY0Gc/A9DjRBtQ+BqZYBY9GQBO/J+YhAZnd+3QwMUxnXSXiqdVVwtjfsZSDSrMLVxBsbooLVHfXDR1tpd/3ZaUjHTFvU3/7Br3+KGOe2F8N+LpWoPmWbdT6ZMZnbABGlDR7oynjqEnOp8srihym65S3VJCntzBPNCR3TT7+k8do7FZtDQyGtsGl8MgeCHP9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E25ygOc0qaBxCzOSumLPTYbixMtOgOeOH09S7cMKRc4=;
 b=YcRkLndrFhTP+lPmMTxQISvyS4b8AiCJE8yoAZkNIQCsmGHTtfIqcaJmINC3LQ7XHDogM4ipASz2zbI2lbGZ5orDdL/6SPukbVL+UugTUv2zRXOmGnZ1l4Hyq7U1/GxrL9sosdm8DH2U3otpa2Hz7W06lr0MJYjjSIQkNqCKTuNXnAObQyALcOhANMjFePG7AI+6wtMKtull5CFEcxGtf60W5jJRNEh8bQRZs9Bgdtx8Amhe2mgEGpczkA9f7uCJNwv9qa+GMhZeBE8ykXO6l9I644PJnjY43QDbeTRqoGJb6nMPgNZa7083vW223+8REZiPQ6pHjdNxGNjjzKkz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 16:57:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 16:57:28 +0000
Message-ID: <2cc1a2ee-25f9-4201-8a17-c1280f618c90@intel.com>
Date: Tue, 24 Jun 2025 09:57:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] ice: Separate TSPLL from PTP and cleanup
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: Anthony Nguyen <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	Karol Kolacinski <karol.kolacinski@intel.com>, Milena Olech
	<milena.olech@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
References: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:303:b9::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fbd3ad-42c8-4dcb-4f40-08ddb340336d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UythaEIrQm16TzRSNnBVUmhkYmNiaHZ5cFZpenh6b2JoWlh6alhKUHBta3ZT?=
 =?utf-8?B?ekRyNzhhNkU5aTBwdVRJTmJNVHc4UkVaWkplS1c4UXUvYnRaSHlvMjNhUFQ2?=
 =?utf-8?B?dVo2OVdxTGZnRTVwSlVkcjFNQW85STA4QVlUNVVPM0p5aFQzNzlLb1NKbjNW?=
 =?utf-8?B?M0dwN3VrU2JCWG1hTnd5c2FEZ1RSSjV5ZTBuNlplSmFUOWZmcWtSck56Z2VR?=
 =?utf-8?B?YU0zY0lFdHVtUVN4b0RtcWhXMjVhZTJFbWMrZWVQUmYyWVplQzVwV1ZsMmRw?=
 =?utf-8?B?K3NYQnlWdFdnN0dKSjZpMkZFbTdLcjFScC9aaXN0ZHlKTVorU1dadlRYQXhJ?=
 =?utf-8?B?RWNvdDBNUGxFV0tOL2VvaTVKampOcGhPaUk0WlA5dDlHd1FCV25pVmlOSU8r?=
 =?utf-8?B?NWNHSWJmNXlJNVFDN0xzUG5nUTRsYnpoU1FPdzlwZ0xmOUlKYVRHa0RpR054?=
 =?utf-8?B?czY5UzRVaGtqdkVCajZQdUVjRkxlQlEyWnovUitoMUZ2RnErWXE4QWMwR0xY?=
 =?utf-8?B?YUJkMXBJeXBoNDRwM2NRUmJTdkI4QTlhVUV1UWJyaTQzbTRyQWtCMC9XZkJn?=
 =?utf-8?B?Z01WS1VSS282WThOdkJBQTV0YnBwZGY0RHJDUm13RUU3eHpyOG9uZEJZQ3hj?=
 =?utf-8?B?QTVCUXViWDFtdUc0UWZvcUp4d0EreWNPbHRoekttVmc4Y0lqOXdhc3Z6ekZq?=
 =?utf-8?B?elJUb2NqeVkxdjZlam1BRVY2MkkvSkdTUlBLemVBZ2FuSHlRUjlxSlg5eDdT?=
 =?utf-8?B?VVZkS3lPUVd4OE9vZ1VoSmFCL2pqWENTckNJaE9sYmVFYXJUSmVhWFc2elpJ?=
 =?utf-8?B?TWxxOXVaVG41NFJjRGFCNGJsYWMwTWZzZmNEZlMva0NRMnZqSmVuVWtQelYv?=
 =?utf-8?B?NmNMK2I0NFFoUmlFYmRjRldWYTc4L1cwN083by84ZnljbHo1UEZKejJaTmpT?=
 =?utf-8?B?QWt0SUtwVnZ1SlRJN0pEVXZncDlOV1NNUVFnQVpsT3J4V0dXU1RYck1sS2t0?=
 =?utf-8?B?Tkl6Y20yODhnRm1WcTJ1TUxmb3F0S2NqYnZFMU1CZUYrZWo4Y3V6d0R1K2h3?=
 =?utf-8?B?TmkxQ3BFeHZxZUhML1pGL3RzMEFoeDd3L3RVMW1KS21hNitKMk1KalBRTDds?=
 =?utf-8?B?bjFQUlN1YUlsVktnTHdCWVN5cU5VbUJyd3hPVHE5WEhTdUlqamh0TS9MMkFn?=
 =?utf-8?B?REZFeG8va2I3MG9LWFVLcEZyUHJEQXZJMk10cEJyZjN3V21sZjJ0aHNReUhW?=
 =?utf-8?B?NEJIYVowcnE4Y2dVVElhb0JnVDlxQlRlNDFmRGJQZUo3cUUxc21VVU9IcW1P?=
 =?utf-8?B?L2crSzd6aTA0MkdPdFBUa24xWGN6ZmRTZ0lGL2tUVjh5aXlObk5DZ2JFOGNQ?=
 =?utf-8?B?VEx3NHEzT2tiRXdneDh3MUhXMElTTHBCVDFQb29QVTVzY1RvSmtSWDE3NDVw?=
 =?utf-8?B?Q3pSVnFOYUZIZ1FOcUJzaGdhVjRQanRtakRLaU1DcFRRSDB2NDNVQkg1S0dP?=
 =?utf-8?B?b2RvYk1CMDhUOVg0eGVCcTdQN0RVbVdBdWVuTllRcXdVUVlTL0ZKRjNmd1I1?=
 =?utf-8?B?ZkF1cmZ2dktyZ2VQeE82eFFzL2xuREE1WXRnOUlsOFI1cjBSZUt4Q0tBOXhH?=
 =?utf-8?B?NmZIby9qamxmWHo3bk1mYmIyZGpjWERqSEYyZXFEci9rcnNibE8wdmI5dVUv?=
 =?utf-8?B?Q2tmaTc2bE9vTm4vYXVnbWpvdTZVTENBc1cvQktYNjZjRUpmeVk0RWJRcW9a?=
 =?utf-8?B?UklxU0RsQ1RnM0lhTHFpdlprMTM0aHpGeThsQ29zYkxpaWpyblA4d3lwd3VT?=
 =?utf-8?B?SENBZXZiT2JRM2NaQVlmbmY1K3VHVnpiRVBoOGVzNWQvUGQ0NDBIRmdVbkFr?=
 =?utf-8?B?eDhCcU84bDI1bEpmd3BvRStjNzN0K0NmRnVaRG1YUkduSW5xemZDWSthU0Rr?=
 =?utf-8?Q?6IV7gAcZns0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STE0TisxRGRweW9valdyR0VBUllmZ29LdFVBYUczVDJuMUh4WC8xazdkSXB5?=
 =?utf-8?B?WEFDWXA5N1dDQ2tla2E5V2VQNXZ6c3drMVc3TWI3MDZZS0htc2c3b1lUUEFR?=
 =?utf-8?B?NytmV3N4eVRQTEp1Y1E0cmJWMGh4WVFiY0VydVVkWmhKRlNRckNXa2pXUVJp?=
 =?utf-8?B?QUx6N09HcDRWQWI4VjA2VS9WeXRYVENDdWdDd2xJZTJnQ0Yvb0hXYXVYZmdt?=
 =?utf-8?B?dEVjT2lqUXRQNENNanVBbGRHT05NaEVIellhMUlKWmVJTWdYZWdmZTFCY1RG?=
 =?utf-8?B?TlhVckY1WWZ2QzIwVzI5elEzblZPMTlQOGhJbU5DTTBhUTJXa3VyNzJBYU1H?=
 =?utf-8?B?bzRqaEdvMnZXNk9UM2Q4UEVYblo3WmxFWUNXUzJZMG9zOVZZR2syWXRMSW9Y?=
 =?utf-8?B?SDJkc2pwYUFNbk1nM0dPYnBKMmdHaHBMemZyYmxleWc0Q3BJcHhmQiswanlz?=
 =?utf-8?B?ODZtR3FVOGh5OGNMRHlsNkhNc1Z5L25VOFVSang0UjVlVGlrTVRFNkJmOFZO?=
 =?utf-8?B?VVlpR2FnQk4zUm9jYzNZcHdHS2FQWi9JaUdCYTF3NTFtK2VyU2k5SEljejdm?=
 =?utf-8?B?aTg3U3QrcUVVWnNnb1ZXV3pMeC9KYkZLSlR3TVdzRXlIR0dLeVV3TjR3d1Bx?=
 =?utf-8?B?OExVcm9hME1iUE5NQWJHOTJscjZxUkpzR1VSdi9yendZVElGVXdRZklERnY5?=
 =?utf-8?B?R2Q0NjlCN0hGbmgrWEg4aXVhWElKdFBaeHZ0NmRUWDNPVFFHZXRQUE45Sm42?=
 =?utf-8?B?alVDTDhJRVcyRTdHY3B1dHVnU1VtdzdyR0psc0xMWEcwbHc2em1BTUZNRmVp?=
 =?utf-8?B?NHBGNnNFYUdjZjNRR3N5dXVGekJzZXVGQm1uYzQ4clFFVGs1RW55TDJyVzVK?=
 =?utf-8?B?VGdWK0V6ZDFENUViTGtHcjlnM3MyY2lTcGlyY05kc01IbWlHQU9XNmVkU2xF?=
 =?utf-8?B?NWtqMGljOU5teUdiTlkzWkprUDVDbGpqYUcyaW55YkRNenpOSGdwRHg1aVZz?=
 =?utf-8?B?ck5qRVlkeW5jWHBtS0JmUGlhbkJDOWNlYzhOTTI3SVI4SnkyOCtOVXhEQ1pM?=
 =?utf-8?B?MWhHdkFEUWZkR0tiWjkwWlhEUjFIdzlsRm92VXk0Z01Ycmp4eTFKMmpPV2ZK?=
 =?utf-8?B?SCs1SWNFRjVDcjNCaTJWM0RrSXhLeDh2UytLbGhWeHI2WDkzZHp2b0ZvK3V3?=
 =?utf-8?B?bDBDTGRHb0Y4aThKNW5zOGZKUWwyY1ZRY2FmZklzbE9hbjVtck1OK2lVUlg1?=
 =?utf-8?B?dmpKTDVycloyNUZQSHd6OXk4NHJzdWpNbkVNMldGZlg1U1NUSWgwQ2VVL3Rp?=
 =?utf-8?B?OEYxMDYrQTR2aWQwLzdZQ3FnbE1JN1pibnNHanZkUStXZ1VOR1FRaHpMZEx1?=
 =?utf-8?B?SUdrclhMUFpIVDNuQ2hHanRBdEhQdUp6N0VLRUIvVmlORExtM3RkOVovOWFp?=
 =?utf-8?B?Zzg1bSs1RHZLdmhBSG5UQVp2cCthQUtiU0taTlU1eTJPeE4xSnFKQVJWUnlM?=
 =?utf-8?B?bEVHVFh0RkhwNzdaRGV5Q1RIS2JRejJMOVlHRjh2aVZpRHV5TVoxMzZza3V2?=
 =?utf-8?B?ZVNjYXBGWU5VenhNb2dmREE1V3RMTXZsTnJ1WkhaMHNYUDJPSmxrV0txNWRi?=
 =?utf-8?B?UlQ4L3krNjB1elc0b3E3dkpiSXJoNVhaa01ScHRzQ09xU25kMGhJTjVaaUtB?=
 =?utf-8?B?cEYwbWdzK3JmcG03clgzMjhzVVU1YXRVeCtiUE5WVjhvY3haYmFza3JnOFBp?=
 =?utf-8?B?R3lCcjlLQW5ObHA3NjRjd1h5YjlldVdYVHBpVEJ4alZGTEJwOHFwZWdPc0VT?=
 =?utf-8?B?M3gycWFlRWY0ZmY4YlhpNVppT1BmYSs0VVlMR2RpWHdtZGRyM3E5bWVBV2Nr?=
 =?utf-8?B?K09DbE5nYXpmWTlXWTJnbjN2bU9OU2tSVFU0NDY1WFcxV1dKVWZVNm5IQm5E?=
 =?utf-8?B?N3E1L3E0dkltek1BRGprQTZFV0NDOTB5Umt2RWxvT3hkRXBxWDBLc092SDZT?=
 =?utf-8?B?T2lXbU1HZjZvUDBZdmlBbVdnbE1kYjlHblVXZGcwZllGVVZEZ1VUSzJTU3lF?=
 =?utf-8?B?MWp3b0EzZWNUemhPOWRQa1pHd2lWSTkvelRETENyU25ZVmRnZ01Kci9RdWhO?=
 =?utf-8?B?V1k1NlpkVHpHeTRFRHVWbDZqeFdPaW1PM3dEOUlDdHdLajV0Q2JpaXJGS2Ez?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fbd3ad-42c8-4dcb-4f40-08ddb340336d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:57:28.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyL/HVJQNEpD63QArqB4Y0+/GFIUnDN5F6VZtrRuBVd/YIyl10462glFXT358E/bcOVht1lRY1tHVrebPtXdv4Lu/n1RSUIp02yUvVdSkWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com



On 6/23/2025 5:29 PM, Jacob Keller wrote:
> This is the remaining 8 patches from the previous submission. I've rebased
> them on top of what Jakub pulled and deleted the control-flow macros.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Jacob Keller (3):
>       ice: clear time_sync_en field for E825-C during reprogramming
>       ice: read TSPLL registers again before reporting status
>       ice: default to TIME_REF instead of TXCO on E825-C
> 
> Karol Kolacinski (5):
>       ice: use bitfields instead of unions for CGU regs
>       ice: add multiple TSPLL helpers
>       ice: wait before enabling TSPLL
>       ice: fall back to TCXO on TSPLL lock fail
>       ice: move TSPLL init calls to ice_ptp.c
> 
>  drivers/net/ethernet/intel/ice/ice_common.h | 212 +++-----------
>  drivers/net/ethernet/intel/ice/ice_common.c |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c    |  11 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  22 +-
>  drivers/net/ethernet/intel/ice/ice_tspll.c  | 425 ++++++++++++++++++----------
>  5 files changed, 315 insertions(+), 357 deletions(-)
> ---
> base-commit: 96c16c59b705d02c29f6bef54858b5da78c3fb13
> change-id: 20250417-kk-tspll-improvements-alignment-2cb078adf96
> 
> Best regards,

Tony found a couple of nits in the earlier patches. My attempt at
mechanically removing the _OR_DIE macros ended up with a couple patches
inserting and then a later patch converting them back to the non-macro
form. I think he's working on fixing those and the ones applied will
have this issue resolved. Shows what I get for not doing patch-by-patch
testing and assuming I'd get merge conflicts for all of them...

