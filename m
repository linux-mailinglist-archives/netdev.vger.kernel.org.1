Return-Path: <netdev+bounces-220067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A295B445C6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3CA3B6832
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57F257837;
	Thu,  4 Sep 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h80TWnpe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC616132A;
	Thu,  4 Sep 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011993; cv=fail; b=gJnPxoJShgXVyomM1ZBVMkqaBsoImwVC2Lsjgj+l3Vf0kNTbQflILMmmNn2y54lT27BisbDjWFTOjclwd7mVmIuquwgsO2/nSdYWgvl3b3HlbvyQGAKRt7REnJOS+d6OQ6ejQTCVIt00ZndynlQp7R/uVCBIQydAEZvcc0BfWfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011993; c=relaxed/simple;
	bh=/SnW5pSKjfqVlhZaCqpteoiAYGSasE8y1CNWpLDwP+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jH0rAwF5XQcXaIM0Md/8F4XJwnakAb7Yrpn5VJocWAe7XNvMD5OoiifFaIF2CSu+rt6JoJ4bnBeonpbr7fSNQ9YmZEKCXXUdexxNPSfkEAarwrFqM9/Krw0s5tjkv5UmjV/VF1jfqo5WTWdswmxUeZyHM2m38+1ax/lfls4d1SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h80TWnpe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757011992; x=1788547992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/SnW5pSKjfqVlhZaCqpteoiAYGSasE8y1CNWpLDwP+o=;
  b=h80TWnpeJk2o8vhT8MWWYFkNCS5kdaseQBRu0dEHXjTtnP1d8aB+tYoo
   2yFIsZDcFBYI+tpUXYlAznWusrIPJdHtGjlZTRHluAhThnZwRQEBeXhOU
   x4UCT/OwDfceKlxvKRjXhCbn2eVGtoCTzvynM+A39hSWX1xXbhRJDKdRT
   hSht6P0kDsNuGrXgUNI2dH2TS2aWyGwgmq1KoT+DcAij3jKOIC8/qRrtZ
   Lo/V8i01GA41Oi9eF1d+LYPoFE21IObN4ioNdBPdtEtA6gg0mE3FrQKkU
   RlrwvmDiy5sMsviakZacMKCXSbxCXQr9zGE77A+nkNIUvmwsE38DAnIl5
   w==;
X-CSE-ConnectionGUID: kdL4VyHsROWUnm18oFo7lQ==
X-CSE-MsgGUID: bcUmiWFFSmy/yfx/Hvucag==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70740749"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="70740749"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:53:11 -0700
X-CSE-ConnectionGUID: m6dd7p9lTnSRLIe7ZCJKxA==
X-CSE-MsgGUID: vr7moDEcSlqJeSxBkcfIIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="172781986"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:53:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 11:53:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 11:53:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.76)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 11:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KihnIPNn0yTUeGdwXRCUb8V8Y0uEtTqXMAFpteYxaYt/iP+PyOeSTGltJqbb7ndWHb4I9lzpfC04Ax4VobBe6M+wkQuy9X1rnocUktlqWX2BDQDHPf3EuBVLgMTKa9BS8Ao0lyjxl5/LhYeH4Xn+X7JFeW9Xn09nMc/hUKCA2gFSfDQACaXy7V99Xx+u3fIQoOnBCNiQ9G3kHxfHYadAN/Y4/HMhdKolBPT8wWTfgfLY4IHWC/hFzDU7y1BCvEt1QIk88JCCN6cIveBx2pqNaPqWRkFj/qrJSyg0rQ00fJsfciOc0T92haO0gAv0iy175u3RHzp1aB3ubCw3DJUegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPr6tgLviVmL5Dzayzspc57+Go5EIDOAmU+crPgBj1E=;
 b=Y0/hIois3rKK7O0Bez68QmvuhTe7/wWE8r20w3GJCTHkzWfNsLzj9/ETZAQuXM8G5RH579kTXxKrYncFYdnoLvCpX6Ob84E/u/WLLEtcYBrY0ylI/2E8AieVm4zwj0/2UDBZwguKaTRrBdGO8hZUeb1WH/1KStUu+t5wMya/DOmxju1pgls97IxUGuls/AHhWlpbSCBf0zWDJRlv3GZzRVsDBP8gmVlYSEkV+lVsLGdVpI4QqOucSHNNiSOtLPsapmBvADAKH2uX25QBOW5VGPvJpYuupZ7qCbWyNgxcSgCrlNgutR6x6pEnU35aeAIqJNP/agDRN4tn4HfSIb+I/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59) by PH7PR11MB6833.namprd11.prod.outlook.com
 (2603:10b6:510:1ec::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 18:53:08 +0000
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e]) by DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 18:53:08 +0000
Message-ID: <b7a23bef-71d1-47e6-ab20-d8a86fa3e431@intel.com>
Date: Thu, 4 Sep 2025 20:53:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in
 ethtool
To: Jakub Kicinski <kuba@kernel.org>, Konrad Leszczynski
	<konrad.leszczynski@intel.com>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-2-konrad.leszczynski@intel.com>
 <20250901125943.243efb74@kernel.org>
Content-Language: en-US
From: Sebastian Basierski <sebastian.basierski@intel.com>
In-Reply-To: <20250901125943.243efb74@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFE396822D5:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 20979f71-0780-4d81-4108-08ddebe449c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1EwSlkxK2lzbHBHcGUxMGl2cEgwQlRPSmZ6SVhMV3Rsd3ZhbU5PSkI2MnIx?=
 =?utf-8?B?NHBRMlB1OTI2L05keTFHVjBnbGNkSndJL01tQ3B4SVRYMEZjRXRjLzhvOFVh?=
 =?utf-8?B?ejV1eUQ0VGh6VXpzekxoRS94R3E3YSs4K1E1Zzh5NGN0MU1rN0FhVFBENldm?=
 =?utf-8?B?RFhaeGNqRXlkZlhqaFlQMFB0SlNzNUFXK0RPL0NTRXE2eEtWcCtOSVp1Yzlr?=
 =?utf-8?B?NC9qVi9sQW5XSFVJNDQxUnZHcFBLb2h2b2NwZWM1Vk9FQWI1NEhHYVVud1lL?=
 =?utf-8?B?TTQ4ZW5NaXZPVlk3T3dLcE9ZcXlWV3Rkb0RocGhBQmg1bG55V2hjYXVQL1BS?=
 =?utf-8?B?ekxveUZzK1RrdXFOa1pnaFEwSm5WVGNWNGNhUFA0Z3Z4bXN1QURsdksxQ1pM?=
 =?utf-8?B?N29RMFI1WXlQSVhnWTUrUStvek85Tm5sZzlmY0FERXJ5dHJFZndhRzlsQm0v?=
 =?utf-8?B?K3c1R0VQaU9RUlg3aXBxeVNIUFhVd2ZnZHZ1bGJDaVJjblZ2T0pHWmpZZ0VN?=
 =?utf-8?B?NHYzQW9jQ01ZS3ZXb1FqazBVSnJYV1BKbTduSm5vaVRYcy9yVm1GNjZTK1lr?=
 =?utf-8?B?ek1INWE3QnpvdzJpWWNuQk1TZjl4Sko1UWg2dnk5Q0N3MHRNejdIY0prajRv?=
 =?utf-8?B?emxEUWlDRmdWQUg5QWcvSnNkUXJkWTI0U1ErdVYxZkZJVnAyY0Z0cU5WZnly?=
 =?utf-8?B?cjIxYUVZUGp3ZEpnbHp6YXk2UjM3NTFuUDllQXdXT05jV3RHclAwbVRRUUFB?=
 =?utf-8?B?WHR0ZnRDZHc3M2FYYk1FcXZUREdGcDJnQURpNmZGVXQ2YUZzSVM3Y3BZZHha?=
 =?utf-8?B?WHd4MkFiaVVaa2NzMEs5d0c0em5CcURGdWVtU3ZYRnI4NXJLYXU3TExJMTZF?=
 =?utf-8?B?TitTckFVZ0xETU92TzVIS25HNkd6bGpZc01TME5MMXE0bHVTemFxcWFlQzZC?=
 =?utf-8?B?MVMxQWdWMEdVVjdyZGoySHc5U0l0VW1adHY4cXZzS2NhRzZMVmEvZzN3ZGhL?=
 =?utf-8?B?WTI4aUY5N2JBZm54ck9nZEZIOEIvR1NNOU5tMXpXWGQ0VHF0NEFxc1UvMEdK?=
 =?utf-8?B?ajd1LzRSUFlsYTFGcGZCNlhQWUVPN3pUTHByTDNrREpPaFFsT2xGRlhPVWxF?=
 =?utf-8?B?S0RsYmVJUVlwNm5PRFphZTF0dmgxM0JsMmZJVnAwQTF1UVR6TE0yRmlETFZ1?=
 =?utf-8?B?VGdGMmpwTFhYK2YvUlEvYngwUnprNWhqVmw0VmdPbFFEZXdlMFE1Y3dpSmhS?=
 =?utf-8?B?TjJxS1ZFcFBXc3RrRWFucE5OdVlibGdGam1LdjBqb3FWOW52c09MWUEwK3pZ?=
 =?utf-8?B?cTdkaGFWRmxaUWE2Mi8zekM0RDNpSVU0dWtGTVIwa21OYS9LcWZrK1lyamlB?=
 =?utf-8?B?bTJyNFlXa1lxM1daK2hsVmZSRjh0RXdQYXVheWxBYWtJQXI0RmVsTjhSRW82?=
 =?utf-8?B?Ry9ZN0Ezb3BpS1JwSm52M1hZREtNSHVNRmpJV1VzNGtrcS9SSFZQUWt4N1Zj?=
 =?utf-8?B?WnR6VTBaQmdsc1ZsaXkzSXRUTXpVWjhtbW1sWGFvVWtKVjJITGpSbWxjSFVG?=
 =?utf-8?B?Vk9SUVBkNjFpTjF4VmgybUNPUzNmUDY3ODZjUktIZ1g4MlFjNWMvVjZKUGZQ?=
 =?utf-8?B?TFIvdjhuM2ZqWkpEcDJuakxONnlnbjNCeWdMck5JaC91KzljMGdvTHdhLzAy?=
 =?utf-8?B?YW4wQjYzMHd4c1VUdm5JU05KK1hUdWxWQysrQ1YvZ2xCd3RUS1VMSk1NMWd6?=
 =?utf-8?B?TDJKTXVNckh2UHV2UERCT2o2RFdGRHhDcmViMlNCeGtIVm5SeC81ZGt5UkFo?=
 =?utf-8?B?VG9EQjBRNzBHeC90T3c3ZmJneEZTb2dXcnc4cFhOWis5WjFEMzlPdVIvemtJ?=
 =?utf-8?B?TXFjQmZLU24wSW1EcG1NNmF5NUNQdDluOVpUd2h3aEZ2aFBTL3Rwak12UHZN?=
 =?utf-8?Q?VTJSbsNuCss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE396822D5.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpOaWhrUWQrak5lWTR5dllmekFUKzlseDl6c05lNmdHMzNhNVpYeEFkNlpN?=
 =?utf-8?B?VGhVeXBmeERIYTBCQ3BlaTIxT0hxR3pRMytSeURtWVFTNzVNbDB2TmtmRXFH?=
 =?utf-8?B?QmVwaWRyMWptek9EUWRIVWh5aFpLdlY3UzBYb2tGOEVsYmxXMS9TUlBVbldI?=
 =?utf-8?B?MTh0cVZraXhoUk9HeThCWlhnSzRtWjJpcVZ2bDJXRXJ2WU5sWGdzSVZ4OXJ2?=
 =?utf-8?B?cGdFOVFpRjA0VWVsYWt2TzZ5Zm44UzFkNHhQSkpXQjV5QXRCYzhwUXBVTXBD?=
 =?utf-8?B?UTVZcjV5cFRRM3hIMktGNStxby9DbUlsM2dZeWNYSWZUakhZSUJybTZVelNN?=
 =?utf-8?B?MnVtMDJUcTRjUEpqNTNNekpsNkZJSlRxajQzMlZZV3Q1dTdrS093TVlEOVZ0?=
 =?utf-8?B?bitvSWs4UTRVZzNvL2ZSaWpDcU1lemRESGFhOXNvdFE2cmJSRExJcTdxNnhL?=
 =?utf-8?B?R0txZ1JKK2g5N3h4RmtKeFpXVXk4a2FDampMRE45WmV1RG16QlFzUlkyWENu?=
 =?utf-8?B?OUFhQTBGOVppL2tSemxLN3Z2eXNzOUZ4S2p5QTBUL3drYUVhenJEREhERU8z?=
 =?utf-8?B?WldydDhXR215U1EzRmF3bXFuMXJTMUZwZkF2ZzdFSWxNV2RyTW9lcHhHSlNN?=
 =?utf-8?B?bGd1RnlGamYrZlF2NnpaMTFNNlV6LzFxVXhXNUFnbDk0clZyLzNRa3Iwa0FJ?=
 =?utf-8?B?NmU0Z09xNy9wTjJMaDdqV0RTYUdCQlB1MzBCSWxGSHZGQUlCdHM3Y2oxaEl1?=
 =?utf-8?B?MUl0QzNYemw4WlpJQ1pLREMzaTNmaENTakJEbi9oUVRRcU9QTXlOaEJBMFBD?=
 =?utf-8?B?YzREQlJYU2ZiMG83NXRLTlQ0a1FxZUlTVmtpRzZkZVZHNWQvN2g4ejRzeThU?=
 =?utf-8?B?S3I4b3F2Mno1Ym1vWG40Z0MraDJPRWJnWnorQnljbzFmTk1aT1RVQXhQL2tz?=
 =?utf-8?B?V0FjRTEzUFFSeEE5MnczSUtYdU1DbHlKcUFSMXpiTkpoR3J1dXZVS2pFVzFW?=
 =?utf-8?B?OFRnVThFdEpXczlHMFpSZEFneFRFNkl3dUticFUwZkY4c20vT3NDL1V5R2tu?=
 =?utf-8?B?OHBxdERIY0hrR21scHR5SGR5MUM3Z2RiT0czSWg3d2RQYS8vT2x3TDNkUXhY?=
 =?utf-8?B?ZnR3WlpNZUpyWDlDQXVEVVI5NkFPYWZ0QTRSTUdIVDBKTWgraHVGWmRtbkRT?=
 =?utf-8?B?WWFmbUdjTWJLdFpCVnhFRjFwdTc4OVI2QkJpZzBuNTZob0FkamZPd1ppNi9q?=
 =?utf-8?B?aVdxYnVKK1J2ZklHWS8zNWNNUUxSMTNnc2tsL3lWZk9BcmJqUFcweDZnRTJk?=
 =?utf-8?B?NTVlQXU2b3JyaFhvd1BjQVN2aHh0K1VzaGlxZjJwejNhMXNKQ2MvZjZxYzBC?=
 =?utf-8?B?QVlUdktHYkNTUkVPcGpMNDBMSE5rdnI1a1QyL1AzcXg3QURja3lqcWp3eGlr?=
 =?utf-8?B?d1pkSEgvOERRZHQvQ2ZxYkZPRXJYNlZkeXZ0TjFqYzFTekdHM1p0aDg2ZGlq?=
 =?utf-8?B?Ym0zK0laZEY5TUhxQ3o1UVFudnJxaDlIWGw3UkpocmNsbXZ4SjlpdXJzcFhq?=
 =?utf-8?B?dXV5OFN0Qlo0RmlXUmdzLzlIUE1ob3hteTBzZlVxZDZPUFhYN081ODU5a3Jn?=
 =?utf-8?B?cHdtcG1PWGVHenhNNlNjTGZIR3pXODF5NUEvZ2psbFFVOVhwZk5TbVhXRlFv?=
 =?utf-8?B?a1dPM0YwUkdvSmpaVzlnNFhTUCtHdmFVSlAwM1ZBc3IwdFV4dHpOQW0zaDlV?=
 =?utf-8?B?UmMyRXJ5Vk1iMHRxa0VyMTZaSUN0MXQ5aDRjcDFPZEZ2V010c01scGZIcUFH?=
 =?utf-8?B?bDZDWHRvUkhRRUQyRzhmRUViekVxVW0xendXamxpUks2eFplc1lhYmkySlZY?=
 =?utf-8?B?YXA4eVU5RDcvN3FwZTBqbElITmRGVDZBNGFVVGowYU9QSHExMlNsYWdWVWF3?=
 =?utf-8?B?WnJxZEVjQUxUQXQvUTNuUmt0NDhpNjdIYnNUSDBraklGZVVwNHplanpidUVD?=
 =?utf-8?B?MmhyUmQvdkgyd0tJTGpwWTdoRzFOTXZyd0R6WlNxbU1GSnhsamw3dU9xTVg3?=
 =?utf-8?B?RlFIa0xTNExVMDNRMUlHYTFGSzVuYlVsbFdrMERyaDNnakZ2VnRMUWxjUVBY?=
 =?utf-8?B?UXZ3YWZaYkNoamVZWWhncS9rMEZlSmpxanVack1kRy80ZXUwMTRFRWZuOHhu?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20979f71-0780-4d81-4108-08ddebe449c5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE396822D5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:53:08.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5wfstKEdx8FT4ZsVR/TR/yGmWHRHVidnGfjNUec/3GlQIxaBH8alrsz6Xbbra85UjNIudgs4D9qyC6OB5z+qOqAX78EuQlMeFTHo7j0qXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com


On 9/1/2025 9:59 PM, Jakub Kicinski wrote:
> On Thu, 28 Aug 2025 12:02:35 +0200 Konrad Leszczynski wrote:
>> Fix kernel exception by replacing memcpy with strscpy when used with
>> safety feature strings in ethtool logic.
>>
>> [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
>> [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
> If you hit this with upstream code please mention which string
> is not padded. If this can't happen with upstream platforms --
> there is no upstream bug. BTW ethtool_puts() is a better choice.
Hi Jakub,
Sorry for late answer to your review.
I double checked and made sure this bug reproduces on upstream platform.
Bug seems to appear on first string - i will add this information to 
commit message.
Also thanks for code change suggestion, indeed, it looks much better.

Best Regards,
Sebastian
>> Fixes: 8bf993a5877e8a0a ("net: stmmac: Add support for DWMAC5 and implement Safety Features")
>> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> index 77758a7299b4..0433be4bd0c4 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> @@ -752,7 +752,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>>   				if (!stmmac_safety_feat_dump(priv,
>>   							&priv->sstats, i,
>>   							NULL, &desc)) {
>> -					memcpy(p, desc, ETH_GSTRING_LEN);
>> +					strscpy(p, desc, ETH_GSTRING_LEN);
>>   					p += ETH_GSTRING_LEN;
>>   				}

