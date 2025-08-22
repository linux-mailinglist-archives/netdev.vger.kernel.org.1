Return-Path: <netdev+bounces-215969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B0B312A6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542836203F0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489627E070;
	Fri, 22 Aug 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4cK7hNn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B01212578
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854050; cv=fail; b=s47dsJ5VZGtj8cMzG8+iw7ijkEVEfqXI78KAzF3Jni5HtsAECwgJZND2vpWGq+/Ot4GSIOdrYGnscTNDA+wEsm00uWyXEZmV9ny4A+At0jLKREt/E473iMMr3E7ujvKHcTLeSZ2VnSEjW/CVFS5kwR3aj3pkv2q5gxmTorHxNV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854050; c=relaxed/simple;
	bh=kNczrmjvdTZuqVpIllpKdMtSqHHyiZCnf0+Gd20Rrqg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxbSwaRXPMSk1Bzo7dheVLKGDMTHE/GzxmAZx37ncuqREbg+BTi9RtQNCibwYLkaNPtydg0OkawujWYnHjM+yu3Pseju5mXIJW9qDJEphbq/hxOUefe3bGjc57zkdYvPkyiYcC/ycFJm7vUc38i4lR2fIv7aNh4gSMkslhDIA0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4cK7hNn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755854048; x=1787390048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kNczrmjvdTZuqVpIllpKdMtSqHHyiZCnf0+Gd20Rrqg=;
  b=f4cK7hNntfEf0EcgfqLY6kU7NEp8KMgydL8vt++C3Vznm/ZSBk20yfI4
   0HmD986gkp/RU0fIyCFIMHugcJcYgz8z8MzVZJxlNAdzdACJmJc1vBpgb
   9UmqFCyYT1hhLi5oFD91EvS2j069kRPohOtUzTOoGdRcrbCTSr4QgnUPK
   tREU7KDY/rKNt4sHigXB8zmHXYx3+GOzQzlxQ3oVdTyCdMJaepDHSaVRi
   1hh+WZJGELUwm1hPG/NW7Ss4VWnMU8Zns/lUcoCer0lZIFomRL8x+z6iB
   Ocdl1UU30YLqwN1j2I55/Jnxojct9I1WbfMLwcVxQcuuN25LxjYiN0tw+
   g==;
X-CSE-ConnectionGUID: q1556MiaRlarzsGZZqD7AQ==
X-CSE-MsgGUID: DcuzvvN9SDKBi5GD3qC5xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58257145"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58257145"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:14:07 -0700
X-CSE-ConnectionGUID: ifISlsSDTeuOzH2QXT3a+Q==
X-CSE-MsgGUID: aw2o3I3dRpOxqbWNA5W61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168566436"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:14:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 02:14:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 02:14:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 02:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBsB7g4RaCA+py/hOku7mzRUAFsYXton4OmexjTGsG1Qwi0oPfLmLbXGQw2YMXxwpBilAR6eFUuiuo4+kdQiqOPekLHvTU+BUickWD922poMsRy+2IqubBGBtfH9SmCHQBlp7g/5jTz+Ne+HCOdzfsbLKVl9Ln5KL1x26JFPUjG9VZGCT0bJ+3avgS0UNEYvVyPK+Me20WA8jNx+B9Ti2OKGU86ruWZ8UYbazYs0VHPIkIqW1CqEs75DzljShDoSYkq2h2ZzHgs/595OfTZZgKnQuutx40JEGC31OA3NKIXFaVqa2jQzqXbksXDGCaAsC7Fli8LwTk3e95/CInm2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz7v5KZryuE52AccfDagA8C8lRtPenE0NiIzPxBLOW8=;
 b=fBj549tUZMXuL+S92kJNX5DAjIuFjI1Osdz70ie+leusPHjCn3+dcrryv0ZlWL3JV2wY3hQtZJbQzX6MySwcORLPXT4zY/WhX46LlQxeOl1PVHMHC+K89nSjMee4lYq3FrqqTjVNwQBmyRPQhoiDihr7wx0cYIGt0pLOLYrxm4xiWmtcNRIvZTcrCDghRnhgyRfyXivnBkI4Up/ZPlyY3Tu0/nvxhpTY8nK4lGW9FEswikK2uGkEGT2RfK16zyImda16B1pepgH0K4fmZaz/O6bifVAR3Fsnzi3Xfx6F1pvL3GquiLQwLI0WSXhEWKuqnRNBG39uRsKy/dglDHy3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 22 Aug
 2025 09:09:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:09:16 +0000
Message-ID: <41eae08f-5f77-4099-bcd4-ccc7bbcf6426@intel.com>
Date: Fri, 22 Aug 2025 11:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: add devlink param to control VF MAC address
 limit
To: <mheib@redhat.com>, Jiri Pirko <jiri@resnulli.us>
CC: <anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, "Simon
 Horman" <horms@kernel.org>
References: <20250821233930.127420-1-mheib@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250821233930.127420-1-mheib@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0048.eurprd06.prod.outlook.com
 (2603:10a6:10:120::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f3882a-497f-49bf-e275-08dde15b9222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWFWcXRUZWVUeEdqSWlvMFdLNkl2RXpIMEtUNHdrSXFOSUV5Q0x2dUcva2ZZ?=
 =?utf-8?B?bGVHQTBKOU1TcHVUWmErd0VmRmpWM2hnVHFqbUtVMmpPQ2xtOFhZNC9zNmZm?=
 =?utf-8?B?dThrNVplUjB5aHFLZHhNUXg0K1BvdWU5bDdDRlVXdUZXeFNoZ2xobkNyWURG?=
 =?utf-8?B?cmJxWmdLQ3RmZFhZKzRFVk1peXR5V2JoV3QzWGhqcCtjS09mcG9zd2puczRo?=
 =?utf-8?B?Y0RuTXFWUnc2a0VoMnZXUkVTMHRLMUtlK2R5cjJsOGFpSmdPcUhxTWtxUkpE?=
 =?utf-8?B?ZWRUNDlZQW16U05XTk5YclhqdlFIK1pFdkc2MmFHM1hjWG9SeUt2NkhRT2dz?=
 =?utf-8?B?bitaSlg2cVg1NGRUK3lYd1MwOW9CQ2gxejhPWVlVUWNnbDA1d3NyMW9senFQ?=
 =?utf-8?B?by8wTjVwOG54Njg3cjVtL1RKWFUyT241dHM2bmRKRm81Y2l0Mnk4ODdVVUlR?=
 =?utf-8?B?WVYxS2Y2OXIySmFJNzU0bkZkalpoU045UzZyM0srWG5ITEFzL3lwcllTZ1FM?=
 =?utf-8?B?bkxSaU41SmlhckpkcXRLWUEreTRJRmcrVElkaFdxVGwvN1pKa0tvT1ZrbmZo?=
 =?utf-8?B?R0g3cmVyY3BLV1lOaUtQYkFtVEU1WlB1UHpxS2dBRDFMcVJuWi9IUmRyN0hS?=
 =?utf-8?B?aHNlaGpHYjE1SDB0MmZzYWVaZTQ0ZXVoc0RNMzJUcWFjWUI1QklIT0NPNmNT?=
 =?utf-8?B?a0txR0NrQldNTnFtb2xRa0ZUbllqY3BOUGNZMHN4NTlnQzduanNXOVkyajdj?=
 =?utf-8?B?STZkTEY5d0xLZzJqR0xJc3hDcmdhZ0tPWnN6TzZ5WjlPcmwvbnJ3RmdFNHpM?=
 =?utf-8?B?WlVmVjE5Yk93S09la1BURzlVeGNNZGhhODdSUHpNT0ZNVEVQSG1uaXk2WjF4?=
 =?utf-8?B?OW9uTTNwbHgvOFcyNlFwR3UrYXNBSm1YTk9OSmNzUGtoS0RmL1FNeDZiRCtn?=
 =?utf-8?B?c0tzT1pHNVFFTlBLcVFTOFNieThmam5PQkswZ1p2N2pNSVdrT3lteE4waHI3?=
 =?utf-8?B?UjgvbFkydkZWWWE4cEN5NEttVWhwVTRqU2NNemFROW1KMVBBV3dtL29LSVpU?=
 =?utf-8?B?RjA1Slk5T1BmMVBISG5ObUVmdHRjZmhpaUZTemszYXlReFNJclZSbFZxZURs?=
 =?utf-8?B?aGh1YzE5MmhieXlva3lZbHIrejRGWEN4UFlGWUhLMVg5ZG9rbndaSnFUb3Zh?=
 =?utf-8?B?VGlyeDAwbm9yQVR0b29zQjVyVUVUZ2ZCUzFkelp0UFZ3Tys4dHQ2ZHpZMTFp?=
 =?utf-8?B?VTFIdisrZVdoWC9sZE9hakRCTGtpNXByY2QxL2NJRnc1b1ZBelFNQ0RUQ0ky?=
 =?utf-8?B?K3h3WnpHaG1uenhRNmhDSVdZekVqbGZ2RW5pUEw2RHYwOENHMk5KUFVvakVi?=
 =?utf-8?B?a0RNK1BOM3hhek9Ua294ckU0Ry8zalF2bXV2OXZJM3BwbWVPcm9NNmVBZ0Z2?=
 =?utf-8?B?TWpnanNWZFk1T3kzZUJzb0hWMHhWeGFxdVRucTB6Ykc4RXJFaDI4blpMM09T?=
 =?utf-8?B?azFkV1NMdEU1WWw0VGRrNU95ZUE5UkVqTjBERm1xVVpWV3ppK2RrdDU2TWtR?=
 =?utf-8?B?Rkp0VTNCcS9hRm10YUlxbDRSQlN5NTkxZEVDbnN4WnZrSldRYXg1WEZtMW1J?=
 =?utf-8?B?ZGtVUlhXZU8yUG5haDRERUpZY1ZJWmdmTzZjYVJUWEZiQWVhVzlKenprc0di?=
 =?utf-8?B?WEVocG9qemVUbUxzNE9OMzJKT0RKRGtNc3l4OVh0clcyZFRxN2hibmJDdHFj?=
 =?utf-8?B?TEt2NGg3QllQbXFaWnQ4bk5id3Y0UzFXZytqZEZZUXhmRTlETWVDVEJib3RR?=
 =?utf-8?B?aTI1OGxMV3dvbzd2dldEOThRZHlMWkx6RmJWbmN1VUlybzZVWG1OYkJFWFM0?=
 =?utf-8?B?VVIrbSt0Yi8yczB3Wk5Pcy9XdnhicHUzcVVRczVYWC9XY21hcVRWa0tXSVdP?=
 =?utf-8?Q?oZyWLHel5gw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRyeGVaZzc1eGJVVm5FdHVNSUE3NTg0THlkaDBxOHFkcHdHNFZYaVlqRmtK?=
 =?utf-8?B?S3ZEa2NxQ2ZSbjJZeVN1NjBpOC9VNGhYZVVmSjR6ZlE5eDBQOFl2ZHZDUmJx?=
 =?utf-8?B?NGs0RzJKZU14dWczNG53WnQ2L1FvSC9KRE1QOXVaL0JnczdKL1o3UmoxeitO?=
 =?utf-8?B?aTVHaTh6ZXQ5YnRKRTZ1R0FEWXlDdU5iZnM3V1FvVlR3SHBSOG02aVJRSUhw?=
 =?utf-8?B?K3gzQU5Nb1FvNDBTZzR6clJZMDNpR1pqRWJCRTNzOU9TUEcvaXZqOUZmdWFP?=
 =?utf-8?B?TjFFQS9LbkQ5dElwU3Z5THdQNDFXd1VtclJWRTRFQkpnd3RLT0RncG5Wcncr?=
 =?utf-8?B?b2VvMHN3azdwMkM0Y1Zkb3o2TGpWcFl1Q1dIMi9HWnlKRmdoOTM3d01FMnN6?=
 =?utf-8?B?SVdPb2V2Sko3OGd0ZkdjcDg5QXRvVHpvR1ovRFJtMVFPWGRaOG0wYk5MNU9Z?=
 =?utf-8?B?dWUzZEZRaEFHOUlTMjR3Z2JINzBHRGZBQnRQNnRlUXNVcXJuek02cFhnSjdL?=
 =?utf-8?B?U1k5eFB2TTRPdms2eGlES0JGelBIcWVQSWFvSGFoMTBlRXhsNi9IZWIrZytI?=
 =?utf-8?B?MjNtNEROMGYydFpQdnExaEQvRHFNaDZ2MHBaYWhYK3gyMFFTZkREdkVCTjhG?=
 =?utf-8?B?ZHkzTElZNHhMN1N1QUk2MlEwRXJ5Rjgya1RnY2RjQ2p2TEw4TDJNdEdqU3F5?=
 =?utf-8?B?TlpzTTZobkVXU0toeG5LNDkzazJpZExtajdpSTJ4RURlZGVNaW02a2VCbTd6?=
 =?utf-8?B?dnFZQTBJWVUzWFVPZ2l4alkxN25FM0craXBJckNBL0w3aDU4UGxva09xRGFw?=
 =?utf-8?B?NmRRUFB6NEFhQVR0RFdnVGlHNndRUWdRd2N1TEFvU0RySWhhZDJjbUc5T3RF?=
 =?utf-8?B?YWp5N3NUb1BNNEgvS3VTZ0RMQzBGcVdBRElJazVzT0lvbDJWS1pFdjErWm5t?=
 =?utf-8?B?ZFNCc2orazduUnllVTcwTnpCeHhKbithS1RTMlF2UmxrNUtOWW1KNFh1UnZ3?=
 =?utf-8?B?S2ZqeXY0ZWlmQmg5elJObEpLaExod2RMV2NqS2tNZWRvc0kvR3FiNGpyeGht?=
 =?utf-8?B?c1k5ZnlCMGptWjh5RnAvUXhtc1BjREwvWCtkSUphNTQzV1hSVTgvQzhRWVRx?=
 =?utf-8?B?bjRiRkoxOGEraEdvS1owTUR4L2w2Y1VjdG9Ydm4zWnhtNDR6N2l1RUtFZk1Y?=
 =?utf-8?B?NkQvSjBwY0ZKWVhLdjNyMHdnN09rZGoyb0FGdTluUVJGTUcrNWkvNVlsTTFK?=
 =?utf-8?B?cUNaL2IxUlQ1UmwzeEVSYjk5eXMzbWZHMG1EYmkycXJhZXVhcngzektBWFJC?=
 =?utf-8?B?dXEvaVJ6S1FhK25yd2cxK01wV2tDOXR1anJZcXZ0OTdVVk5IYUFGTEkzWG12?=
 =?utf-8?B?Sm5xMzE4M3hxK1p0ZUt2NHR0T05ycmJ5dzlQYzRtWDBnUk5hTWgvRmJwaWZO?=
 =?utf-8?B?UitGSk1pTG9WWUhoaVVvUXNoM0pjTFBxNDhDbjhDNnE1azlSdHRXUEM3MWJ0?=
 =?utf-8?B?dmNERDMwTFpZbjNHK3FqMkM2eVJ5RFRwZDVRb1dyR0JzWjYxajkvZFl2SnYy?=
 =?utf-8?B?ME1WOXJUNnJCdGl4RUxtZmVGVGxWdzdrdXFpLzhIZkxQeG5FUHE1ektPb052?=
 =?utf-8?B?VHJDekZOREh5V2FGaGY1dXU1N21CQnJLTmZWUUZkZ013WE9Ja012aDg5QjdJ?=
 =?utf-8?B?Ri94Qk10TXU5Z1VwZ0IxdUtwN1ZKVHBiN2F3OTNDdllJZmM3aUxDSGhoOWx3?=
 =?utf-8?B?OHcyUzZlUkhYTFBWZ1YvN0U1SUJCNEVuRmlkYXlQQWVaVG1QTFJsSzZmNlo0?=
 =?utf-8?B?VFBaR0JlSVdJWkpDVlBKamZka1JTZFAwallHazVRRy9ReXZkd2t2SUtYeG43?=
 =?utf-8?B?YUV2Y28vMm9RWnNUNFZKc1VlR2dmSlNZYk5KS3lhTW9KcmdGWldvQjNLZm55?=
 =?utf-8?B?Q0YyaEdZcjUzdHYxL3lTVmt1akk0ZlRxc3M4a1lMNXE2UWFNK0F2b08wUlh4?=
 =?utf-8?B?ZVNqUEFYVnNKR3NhY3hmUGY5bHBKb3B2aUk3NUhzVlI3NEVyYzdmTSsvWFZG?=
 =?utf-8?B?S1dSM21jcUhWd1pCZWc3S2kzWGNEeE1GbjJMSVNvcUxVZ0VwQ2tneHQ0VENT?=
 =?utf-8?B?ZmhXcytYcDFqdHp1aVNHekZReVBudWo2bUpBU1lPaDdoc3NzWHRHZkdTZFFX?=
 =?utf-8?Q?bDxulNvQWpaaflpv7gL7q10=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f3882a-497f-49bf-e275-08dde15b9222
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:09:16.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+Wf9vVKnTo6qCbsXGGv/TNzTcMLrUukBwQDxEDmJArNu/FkNpExCcibcHL/Cn2U3zAi+kZhuuXsmWv0syPRG0UMl7GTc2f7wC/pCcF3++U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8286
X-OriginatorOrg: intel.com

On 8/22/25 01:39, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> This patch introduces a new devlink runtime parameter
> to control whether the VF MAC filter limit feature is
> enabled or disabled.
> 
> When the parameter is set to non-zero, the driver enforces the per-VF MAC
> filter limit calculated from the number of allocated VFs and ports.
> When the parameter is unset (zero), no limit is applied and behavior
> remains as before commit cfb1d572c986
>     ("i40e: Add ensurance of MacVlan resources for every trusted VF").
> 
> This implementation allows us to toggle the feature through devlink
> while preserving old behavior. In the future, the parameter can be
> extended to represent a configurable "max MACs per VF" value, but for
> now it acts as a simple on/off switch.
> 
> Example command to enable per-vf mac limit:
>   - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
> 	value 1 \
> 	cmode runtime
> 
> Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

thank you for the patch, I have a few questions/objections

1. it git-conflicts with [1], please post your next revision based on
Tony's (fixes) tree dev-queue branch [2]

2a. it is good practice to link to the previous discussions, and CC
individuals involved (Jake, Simon)

2b. for changes that utilize given subsystem (devlink), you need to CC
respective maintainers (Jiri)

3. it would really be better to treat not-zero values as strict limit

4. this idea is not limited to i40e, the parameter should be global
(for all drivers to implement), as it seems generic enough

5. when someone will make a per-given-VF param, this one will not be
deprecated but will still work as a cap (max) value. (Leaving it at
zero will be ofc perfectly fine).

[1] 
https://lore.kernel.org/intel-wired-lan/20250813104552.61027-9-przemyslaw.kitszel@intel.com/T/#mac68de249365b8c4fa83054592dd98f0f789fab4

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/log/?h=dev-queue

> ---
>   Documentation/networking/devlink/i40e.rst     | 19 +++++++
>   drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 14 ++++-
>   4 files changed, 89 insertions(+), 4 deletions(-)
> 

