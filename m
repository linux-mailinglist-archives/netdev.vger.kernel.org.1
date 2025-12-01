Return-Path: <netdev+bounces-243029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 892DAC9866B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FF7A4E157A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A131813F;
	Mon,  1 Dec 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV5Mk9g/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007D30E0D4
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608634; cv=fail; b=TYbXBYPLcWG2Fif6D+GBY57Nx7z4T8EukbBk7lyevwAJ0UhFEE/30rYeyNimFAgsgT3VSZWmRKw8Dqj4+qeF7vPvKruNQxXXEmurq/VBRcc4EZUFDmf2ocnDigMeEdCxKqKUMeOCmSt5iL07bfsDl7hJYapIZQDb8qEL0JyjO+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608634; c=relaxed/simple;
	bh=uLbtWaNtFtqp3jhWblyVnvr9rlxRzOkNgyu9jejO/oY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IgXEQprOSfw9MWpBpi82LBP7ZKPYEaJ8nAWhmvU2+Uq+DtwvXSdG/44l6wjXvv19xySbrDdm+QR9MYvXRlgCSPWNl/UkkpFQyMt9AIFvDsMR64FZt+mQcALeEu7kJYbuSGubZCFtE68fF65FA0EpNxoKF+5IGsdHwvoEfvzwZPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV5Mk9g/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764608633; x=1796144633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uLbtWaNtFtqp3jhWblyVnvr9rlxRzOkNgyu9jejO/oY=;
  b=kV5Mk9g/5oJVrNaAxrpYE7cPAkLcJj15BjzEz3flrmy0ReckBI1eExeb
   93CbgVWcwpQM71WFYdIBlnNO80D/YnZRPSHAKXUcLvlHRhFcdCA4u0qcj
   ChLfCFMBEKfVAzrKxagSUj7MtE+jGn84OB/2CkOlqgBEUGn6DOc+3PJGZ
   jBX/quyhrvXwof5TVK33gMjDTfgx4/RcDxB4GrJqN2myeyNTBGSK4xOXo
   omsLYmTAG8F6GBUcxgUWE38kcSSwbetKZamrSueJBBGhAPpB0/tiIocrV
   +jiM7KQ7YWziDi736PQHfwPoyBOtMIuqI88cg34r9OsEuokc0W7gQMZFw
   g==;
X-CSE-ConnectionGUID: MYQHkJWbRnikqiXoGRMc7Q==
X-CSE-MsgGUID: aDt8vNFsT82EDBjPhXzOAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70404907"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="70404907"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:03:52 -0800
X-CSE-ConnectionGUID: D+4eEXCPQcGKMA1QuO0jbQ==
X-CSE-MsgGUID: bi1qVoimQSi9OIAO/Kg83g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194909211"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:03:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 09:03:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 09:03:49 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 09:03:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8YK0iugyvUzSHVJSLaLpVLVHGyPasE2+psSpyR+gWrZd+KB7IMXVTqO+rhl1wBO4u4klJofQYSxwkr5r4nQeayEZb1erFOPedleZLDEIgZC7sck+PXyyWhtOnklIxCHKflP/qIGlCo29AXV33dBo8XXBh4H7yZYg+dZq5HOtk4qGIrvJPxGxZtrebSpzasXONs+A7fgGsFEtYRWLuEkR9vwAfENIim+MWFnNS5AtxXFyCxyVD9IXy9CKSk1v7YfOkXcxIrDzq1AwHKYxRGAsg7Ja0hvsBvp9RNDyC9peYAMTQB8ONMKEeHBI813eHGrLCzYttjL11JQsa56nz5FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvvDsvLbYCPqUmjDjvDgpBuG0lO57ZtNz4wC2R1kJxQ=;
 b=hnqsxUJgDGedSzTLdG01LvjfCOVHoOBRc5r6dxOf7CoXb2TBx0hNgCt9JhU2x7uv25CQPS88Y6CVDF4+tc4k3dKIVxBeWYBRJNpKlsMrTmucDmqaqklY7HRUSLbSaey/TOfRvqVULdTfEQTXHT6h/8aWMf6JWjhIE0wXdXQ50yijrGvfBOuceW4jKs9HkIxq54BMwt0CPR4oh2jphFcQrbVIpnMDcTiAUxEYHrj4+mmNSmJVizxL5plhfrj0VjAf7LAeixV+polgPwR7T6SpWQX92FxA42T0CYfq5AiMWeTkcjq3aRK3Gua3wrz3kJlCbqpm6ice8e1zgTqKGmDWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:03:27 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 17:03:26 +0000
Message-ID: <49aebaf4-e77c-4c32-8abd-ec6a2c98e6f7@intel.com>
Date: Mon, 1 Dec 2025 09:03:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates 2025-11-25 (ice, idpf, iavf, ixgbe, ixgbevf, e1000e)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
 <20251127183853.2158cfae@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20251127183853.2158cfae@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5e7ce4-39ac-4205-4adc-08de30fb8b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUUzMkNDOGpxVUUyQVAza1NlTGxvQUNyMWhDL3F4eU0yZExobzQ3L3FEd3Zl?=
 =?utf-8?B?N2hReDlHZHRlOFRTZ2ZScUNjYmpHQ2JWWW9UWDJvUmxFb1J0VS8zUCtMc3Z4?=
 =?utf-8?B?QmpNR3BUN2FjcnZKUlAweUc2RFBYZzd2N0xGcEJKeGZydFNuTTA1TE1OdEsz?=
 =?utf-8?B?aWZGUzJFWkF0dk80bGkwMDB1ckxEZGxOYUVqMlVqR0tVeC9XSnljek92bW9J?=
 =?utf-8?B?RUM1RGp5VDRkMnIraTdkUVZLcllTWFBadklOQWVGNGxzNUo4NkxPVVIwWGpK?=
 =?utf-8?B?c2xIZFhuU2tVYmVXd2E5UFdiY2JuZ3Q0UWVyRzRlV3FyM0M2T0htNWxkeTRG?=
 =?utf-8?B?UEI0VHkwaW1wTTZ6N1RMQ0Z5a3NuUDFrYWxxaU9nV09maWJ4NUlsbzFBZ3E2?=
 =?utf-8?B?UWNBcnUwcVc5a01ZQzl0S3RMRFpGRERzVnkvWWo2aUx5OUtDc3RDUGJRUGVp?=
 =?utf-8?B?RzFDUWtpZE45V3QvVVZVR285MWV5YWFiZm5JYXdtVkNxUVdFa2x6OTlJbXdS?=
 =?utf-8?B?bERHTWh1a2RFMUtIdG1yZEdnU2Y4aEt5b1NDcFU4aVhYQlpkWUtheVlUcHRE?=
 =?utf-8?B?b0QyakkrNHR0cnNQcGRaNmJ1Q3lQQjRqaGswQ3dMbC9uR0Y3YkNUcllQekV4?=
 =?utf-8?B?cUlaMkNvQWl1eTl1Ull2L3oxT3pvdndnTTBVdWs2TjJsZEtpUXIxK1NsSndk?=
 =?utf-8?B?TXlHK0dicUIrRFNMRFBBNDN2bEovbDJ2eVRsc1Y0NkNNZUNHWXZIbHNRdDRm?=
 =?utf-8?B?RW5jd0ZzQklkbHBNcmlzbXA1bEVXcytSSnduL3VwcVdyK1IwRVExZmtxY0sw?=
 =?utf-8?B?UEpDZ1Y2T3lZckpOOTgvR1YrTzg5VWg5THE5K3ZCanN6YlFLOVdmaUlodXhs?=
 =?utf-8?B?eW4rbmVQekVJL3BzVVZCb1VQbU9wVXRXOC81cFJTWXY3UFhrUm9SY2QxbHlm?=
 =?utf-8?B?U21LbzFZdkJma2F3aHJSYXFkcmYyU2ZmaFVVM2tqempHYWZsazhUOVdTVDMr?=
 =?utf-8?B?VzYzRjlzaFd4MDIrRGN4SkVuWHBnU1JsbHBFOEpPRVdtNDlCcXVuQlF2Y24w?=
 =?utf-8?B?aXg5akIvbUdEUm1RNWNocWJmYmZ5OVF6bnVmYWJsaWtJK1FwQlkyVyttaGhz?=
 =?utf-8?B?N0FzcytjNlBLWTJSR05uREkrRWdHRTNVNURnMWd5RzVxR1VjUnRoeURHTDJo?=
 =?utf-8?B?NnhYSll6eS9UWHhOcW5GQU04bnBjemYySmxJWWRKazdHRjFuNmwzVEZra3V3?=
 =?utf-8?B?anUxOUlhNnU4ZENremsxbG1xUWVmKzB5c3dHZFlTZUVSTjN6Q3lCMzZDTlNO?=
 =?utf-8?B?U1hCYnI3WFZaMTM0dzQwczBLSkllZ0J6ci9GQTNzYkxkbWdlRS9xalExb1RV?=
 =?utf-8?B?SExkU1k1TEpqV2UzRHFtaHlkVkJzY3NNV2VOclIxTEYvQzBXTkRrbFpURHRu?=
 =?utf-8?B?MVJUZkRMQXNDUDR4M09RTStESjhOcGJkTnZpZXpmWC9DcjRueTZETTA1K0Fn?=
 =?utf-8?B?ZisrZHgwbTREZEhTSkJEaW9mUTJBZnFmMlBiQkl3M0R3dVZ0aUNjUWNGMHQ0?=
 =?utf-8?B?SlpEVUo5SnlCTHplN1RmcHY4YnpGUng3WnEvYnhDaVZBM3FoK014MWo5Qllr?=
 =?utf-8?B?c3BCUEYwd3lPOGt0TWhCMkoraHR0S2dzVEQyOHY0bHFQbGFCSUhJd1AvbWo3?=
 =?utf-8?B?bTdEOTNiTE9Rb0ZsZks1eEFGUDZSak83QTdMR0ZSdWhsZUhCNWRzT29aTmdC?=
 =?utf-8?B?N3RZS0hCWmJVb3N3SW5uWGVIR1BqNk1BaXhHT0JOMXBIb0xkUjF1S1ZBbVpR?=
 =?utf-8?B?Uzl2ZEh0MU9xcjhnVjgzSDQrbDBVUnlYR21OUzVDU1FtWkgrbzRSVkl3MHZy?=
 =?utf-8?B?MVpKMUpUUytPUnlzNjVjdjArNkQ5cXhzUkQ2WjNrVkY5N3llSTE5Vk82cDdl?=
 =?utf-8?Q?0TmCOH7HcaLGFmfUjH07mbTyEC1Y8bQX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtLQW1BODhQeHpBQnh2d3QxMVg0d1RhR0s1V1pNY0RRR2pGTk9OYXorek9Q?=
 =?utf-8?B?MDMyUE9UR2lDSEtRamNscEh4Sk1VTVg4TklzaXM2aGdlRWJTQng2QTlXRThP?=
 =?utf-8?B?V0JvOE5qSlhNazFiUlA1MkpPdHZIbTNBeFF6TWVGY1BLT2pxTlhBQzlDTVk3?=
 =?utf-8?B?STdDR3kweU9JanBid1dmYW44TFlzd3F1dE91dWE3cWV5UExjNWdOZTFpWWc5?=
 =?utf-8?B?VzFycVJYa1ZzcThjQlBQdGxUcTJ5My9KNzV0b0Qzb3dFcDQ4MFJHYXRnTzQ2?=
 =?utf-8?B?clh5U1NoZ3hnVWxKdVdNVUNjTkk3ajRXR09qdWk1eTNaYnZOWDVqbVBPaXkw?=
 =?utf-8?B?cE80cEZreXlZRm5PeU45NDVLRDhnRVNQWWdGMTV2V1plOS8zR0tMTjZMZ1lx?=
 =?utf-8?B?cjJaeVRoOTBpVzZWdnFYNlIwaGlSeU1pUUw1WURPa2xENTdXaVVSQjVCM1pB?=
 =?utf-8?B?ZEpUUk5kT0NrdGRpQmFNV3dib2VOUVdNMnBiSnJJekFPT0NuN3d3VlVXR1Np?=
 =?utf-8?B?L21ia053L3VGOEltcWlBZGNuYTFZQ3dodzg3bHMzeTRTaVJNUGh6eXh3Tkh1?=
 =?utf-8?B?dTZnQmJWd3k3aWpaOEZxNnZQMHRsWERJRmk4Y0FHcCtKeENXMnpTU0QrdVIv?=
 =?utf-8?B?b04xN0Y5Wk1qa2lqRTJab3RLeDJiNXZRWndSd2hYYzR2bVVoN1BDNndwaXpN?=
 =?utf-8?B?eVk3OUd2OUlmOUk5R2haLzVKZnZFUXRuNkwwU1NtTXJ1OWQzd2FIc0kzV2dP?=
 =?utf-8?B?bmxoUWVuMkhhSm1RZGY5TFNNYnBtenpzeVo2OWo4ZzZHUys1SklRZDYyQnNh?=
 =?utf-8?B?MG1JSXJhaERnajRZckNiVUFVcXdiemlXU2Q3Y1NkS21RZmxuSnpMRGdWZm9q?=
 =?utf-8?B?Zk1MdGNrY3JtWW5QYWZOWVRJRkZ2ZER5bjVHa2NHdWlna25UN3BmKzY0YU16?=
 =?utf-8?B?a0VMWnk2Lzdabng0a1dqV2RYNkR6L3lNZW01OUZqelRyZGVndU5LekRZSDBY?=
 =?utf-8?B?OXByeXZXVGJVRUhsaEdnT2JBMDFweGl2QmtVMmRRcGJHdExWdm96aEI2aXFa?=
 =?utf-8?B?QUVnaVBIWkl0RUN0QzQwZlBDVXg4cnVZMHZGQkNlTjdyUnprTXFpYTI4VEJT?=
 =?utf-8?B?Nlh6QWM1YWVYRUhPWDBkcUNPaXBteC94aU9JakJkcEdJTTRRaU16N1NzUUlB?=
 =?utf-8?B?WFdaYzQxUUMvMnhPQ01nNjB1SmdzL0RobnpKd25iUnZDSGVSVEZ3dHJRazNX?=
 =?utf-8?B?ckxBV1ZBR3FuYjZYTmRLTFQ1ZmUrMmxiSkgwMXpaWHptcUFHZ3hrUURFMUZO?=
 =?utf-8?B?N2Q0bkhCbmhVaDZRd3lMa3Y4Vm5FZWtzZ2pOdkZOZHJiOFJTSFlEdTFwSElR?=
 =?utf-8?B?WlB3M09xTEFKRlpaalg4YkRyRFFFUlJ6YlNtSGI4dzUraUlPSUlGaEV2Z1pq?=
 =?utf-8?B?enJ5OTFWRHoxRzhub3p6dUpwL1Z0bXNjc0JKVHJnUytaQnlzTkN3MGdTcnhS?=
 =?utf-8?B?VUZYQ0E3NWJzRVNiemcxUjBVZnFSZUQ5WEJ2QWlZTStmTjM5VjYzdDQzZ3dq?=
 =?utf-8?B?QitseS9wamllVFBOV2o4RWZUWlV0eDFqTWJYMmI0eGJoa0xHR05MeUdrS2tX?=
 =?utf-8?B?Vks3N082c1M3aHdHWm1SVnFHRi9DRDNKTWxST3FVT0hUYVl1NTlVT2JFMWZn?=
 =?utf-8?B?cE9OcGNCZ0xweThzN1ZDUTRDV1hoZ0I3OHlTdDdCVW9Mby9vMjNTVWpyQ1ZC?=
 =?utf-8?B?U29HSEJSRmFrcG90UnBoT1VORTByMzJrZHpmR1QzL2VxREhhUUZKdnNrTzBz?=
 =?utf-8?B?VytwWitEN2RWTzVBVy96VW1SOUNWalA5UUNiQTFxb0xFZGk4TW0rWjRLVFZx?=
 =?utf-8?B?QWhKbVFpUExmWlZyUDgwZTNWU00wNGoxU3IycVlMR01ILyt1R1hQRlJ4d0lF?=
 =?utf-8?B?VW4zaHhCR0FNbzk5a0laMzBGVjNxNTJMY3o0ZThUME1TYXBBellYRCtmay9u?=
 =?utf-8?B?eUU5aytaV1h5bDh4c3l6bkhxM285clJWMkVpTVErVkM3RmNHQWMzTll1dmJY?=
 =?utf-8?B?Rm1vZ0FUQjBocThZWFE5OXFDY1VkQW9QQnFzYmo2RWw1NGtwdE92TWdTSnBl?=
 =?utf-8?B?VStCcWdLYzdsRldXZDJjNCtvaWRhOWxJOU45eVBEN0p6WHRRYlpacWdBSjI4?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5e7ce4-39ac-4205-4adc-08de30fb8b39
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 17:03:26.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNOeO/gDETPYpxjC+HnYYy/GDjez8o7NcaV6PN77o68wIOATIEspa+UuZa850h3CnoWKMLL484wwBaQx/FpgBsmMmTlvtc2UDNrz2kPdB+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com



On 11/27/2025 6:38 PM, Jakub Kicinski wrote:
> On Tue, 25 Nov 2025 14:36:19 -0800 Tony Nguyen wrote:
>> Arkadiusz adds support for unmanaged DPLL for ice E830 devices; device
>> settings are fixed but can be queried by DPLL.
>>
>> Grzegorz commonizes firmware loading process across all ice devices.
>>
>> Birger Koblitz adds support for 10G-BX to ixgbe.
> 
> Ah, looks like I accidentally left it Under Review in patchwork.
> Let me pick out the changes to drivers unrelated to the reviews then..

Thanks Jakub. I'll resubmit the remaining updated versions in the next 
window.

- Tony


