Return-Path: <netdev+bounces-208014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A42B095A7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CE7AAD6F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125F224AF2;
	Thu, 17 Jul 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHskkFh/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA41E0E14;
	Thu, 17 Jul 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783923; cv=fail; b=hmu/S9lNh4gKA2KYaPZckWfLVDnwPflTIX5JBsUmY/pYcYkZ+Ep5BqgVlYGyNr4ATB7HPBJiW/c454P4Wnd+fBSjCXrOM10bWWyE1JPkcHc3IFBhcsQMil2+LRLbQG6V4VEzCsGG5OfFi94Z5w62b7kasHf6n1cZPL9bEG18Lxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783923; c=relaxed/simple;
	bh=x1FuzJaLEz2oJt6/JafzQcMMk1c/tfhT26DRm72KYX8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rNsn9ZWwTIaY36I0LbxT7lddUIYMOWUSTSwJ3O+gUvgu/34LI3SfyL306PH1CQjuJdLBEka2RLKIXzHlYsHBkzgLRm4maqDfdJ5c3RrFvgjbr4J024SosDIkpiQEOK9+Azwc9AsUZNsm/CUKUHWv6PDONhSowLhwOmWVgKHkzbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHskkFh/; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752783921; x=1784319921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x1FuzJaLEz2oJt6/JafzQcMMk1c/tfhT26DRm72KYX8=;
  b=SHskkFh/tkc0x5zq9Llup5lhjci842RTGXD68R0Fi2tTzrrJuPNCOjIM
   uHLNfUwv0QwsEcOUoplGLTfIFLNh9TqDghjQVAZfXT0vInNd66vEwDe0V
   Et1ibcQ/Vr6GZgtXZUpqmmIxynnKYmKP2w/dV5FGFA8aFvU6P8zaqBVkl
   KkStiHdE+sMqqQl/wk82Eyy0zzRQwQ4I6VNIaHZKp2311cMw/zGc9C2B1
   2oWgxOsU6nKkrwKYor9oZ8g+aEnrOUkNrSCk4YGtz6spLNjIlzkpHjwwP
   oBWW1U1jO8SoECT5yMqMyTQnWE5JuirMf0l+tQCotZsRJWBD1GumueI96
   Q==;
X-CSE-ConnectionGUID: ja8H789gR2eDwzAKBmiOxw==
X-CSE-MsgGUID: W7F/22QRSqG9y1EzmpXpSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66523162"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="66523162"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 13:25:20 -0700
X-CSE-ConnectionGUID: I77bnyiCR8CbI+vPFXqIQQ==
X-CSE-MsgGUID: D0ku13epTWyqUey7o4dfOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="162184725"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 13:25:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 13:25:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 13:25:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 13:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8WlQneqZLtI5fVvz03LCBgZMKt7mzKfAFLm6TJ0obbS1emfa8MIfBHi5dhYP3CM/WDxqZNV/cFlrzuTWZko5no7aA6sDesd07BoCXVVP8ZkAeW/Rx3Nb/NIPV9JTw+9b2qznAsH6wf8WFpYzruLPVHQ27ZRCzpplLuj+shj5lYH5m91TFXegbZacoeG5jatZb4yiqtaNw1XsbyPJROVZJ2ODM9hJtx9c0/Cxfwy6PEEevK4TcTPL5hK28jD1b63FgiI760TUuVkP2fbrLOxWVGjcoiGkf6UwYgmvNirv+Pz0i656VFzhgMBTb9MU1xuKlqwslTLp36HnOtMrMmzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySk02GfDYWMhMC81weOHb62VQtJZVSmZkGgoAoeF5xE=;
 b=tolbj0RXnyh4GGq6sB+BhMxp6BZ4xTToPtKciGSqcO7KlzslrPmp/GzSouxaIm4Gsm5qcYBuBhF76OMlKYo7lnKaFBhJGeRBzX1TbgLv4K+/fMvqE0LqPKTBv0sAjJywjYTS8NNGFLrBMVULMEW40NLIzNAhh94MeKv+UDt5TAqtqdC+TcBtBbugv3GlCM3tl79RCTa3z9jCXrcIBWfig6xcT+sk0aSQSY3BgzpQLm/70oGGnRqIDVjaMI6kVew/2EKdWceBbARU8/AbyHlEnE1Z3HXbSHaLwjE5um9Dw7aEWY3mjMoT1ZVqGIX48W9T8fR4Wc4bmNm/03sSTk11nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 20:25:10 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%4]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 20:25:09 +0000
Message-ID: <efbcade2-ca5a-43ad-9512-846be207eb56@intel.com>
Date: Thu, 17 Jul 2025 13:25:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] idpf: set napi for each TX and RX queue
To: Samiullah Khawaja <skhawaja@google.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
CC: <willemb@google.com>, <almasrymina@google.com>, David Decotigny
	<decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, "Sridhar
 Samudrala" <sridhar.samudrala@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <emil.s.tantilov@intel.com>
References: <20250716211230.3592838-1-skhawaja@google.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250716211230.3592838-1-skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM6PR11MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0ad372-7aec-40b9-a053-08ddc5700699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3VWZU5zVy9GQzlTY0FGNm9xK1dBK1VaMzl0K2JWWDZ0RDFjTWlHLzg5RS85?=
 =?utf-8?B?THR1OVVKcG1aeWhWc1J0dGNQb0Q5ZWJiSG1xQ2tOeExpZVNBczk0S1R3cHM0?=
 =?utf-8?B?Z2UvRGRJcnlUUW9YdWowaXRTakdiMW9RU25qWmRRbHl1Y1hsajNFU29rWTMx?=
 =?utf-8?B?L2dvVXlkRHBOakNYQnZabWtzSkFReWp6M1NDeXN5L29RUVhFWWRWL1RkSWpB?=
 =?utf-8?B?K3k5L2Z4eUpIekw1QXJQdmhLVHQ0amxjU0ZxTlpBL2JEenk3VWJEWFk2Y09O?=
 =?utf-8?B?YWc4RUNMRG9qMjNNbU1vdjA4cmhGSTBBNWpKZG1rS05lN3lWQVZMZkt0Ullj?=
 =?utf-8?B?NVVTK2RxMlRxMGZOLzEzaEZpcHNKWjBWdUZrUVAxR2lYdmU4SEhLd1ZlQjBk?=
 =?utf-8?B?MEtZWE5CTWZuTHhSTVZDM1g1MkxLdzhwMjUzSlM2VmxzS2gzRzJTS3BhZG1R?=
 =?utf-8?B?Ti90S2lubGlYYzJtSnpMc2VWUFE4bnZJZzBqd0hKZHVMK3NSVkpOclRCRGd0?=
 =?utf-8?B?NTk0TjMwQ3Jvdnc5Rkw3cEtQU0xYSVN6Rnl6QzB4M2dRbjhhTGt2Z2k1UXR0?=
 =?utf-8?B?cGlwM0hubEpmNzJKM2hlWXlablFzc21YQkVxK3AzQzNkOXJEVnZVSzk2NU9V?=
 =?utf-8?B?dWtBMXRFWCtPdEtxTnN0NDFjMHNwUkFyb3VpTVRLZUZrMmErT3NXYUJSL1dm?=
 =?utf-8?B?eFRXM2dZZHpUd1V4SnpveHNJeWFabCtTVXJITURWNE9yTmV1VVVQOGdSL2xa?=
 =?utf-8?B?YllDV3pPSm5ZZFJ0VGlLRWt4VmJ2LzJzVloxOVFNYjVWcXBpY0VBSjh0d1VH?=
 =?utf-8?B?LzZjRktwdmYwb0kxTHlRQ0xTSjVtZlNkTUZWZWlObVh3NDVRK1E0T1dMbFB2?=
 =?utf-8?B?Wnl5aURwaHliZ3Rlc3RrcVlrdnA0djFVZTFUQ0tqZ2I3aHFOSTA2aGN3dUdy?=
 =?utf-8?B?SS9MWE1xQlpPeTRwTlE3WCtIZlpaQ1hpbEp4MGx5Tk1NQXkybmVLcWZtZnAr?=
 =?utf-8?B?bngzZkxFK2xsdVVHVWo5VzI3UmxSV3RqK3FCVzBSeDN1aWZ6eHNKelJBSyt0?=
 =?utf-8?B?ZWUrTDBhLzcwQ1lUZ2ttNGFXN2lmVnR5Q1dabzJnYy9aRThyM2xpV0NVRWMv?=
 =?utf-8?B?alY0MGszRkMrYzhHQlZheDd3dXBtcTdOOUU4UDJsWFZyUW1SQnNDeXk2aldv?=
 =?utf-8?B?eW92dFRta1E2V3ZYOFlLb2l4cGJRTGhSWldtNHhNWmdSb2hTRXlyTC9UaFpu?=
 =?utf-8?B?d3g3L0c4c3JCUTlvam1PRnRGVXhaYkFvaFQvejJaM28yaUFaL3NUclpxYnFm?=
 =?utf-8?B?ZDNHekNrQ2c2ZzVrRTlxd2U2QjJVWXM0NXliRFBNSm9mZ29jOVE3ZnQwaEFP?=
 =?utf-8?B?eFN5VWpSZEpndnZoYmV4eEF1WnRnUGZwdDFob2Q2UUs2OVpzOE5uUnhLZ25Z?=
 =?utf-8?B?YXNhNEcxL21QazRoZm9rV1FxM0ZIL3Y1a2kwaXlpLzUyK1NjbDM3ZDRqb0V6?=
 =?utf-8?B?NjlCOHBsZE1najZpRzRKdlpyRHFhMm51bTd4V1ZTaTNWMXlKcjkrRUp3UDkv?=
 =?utf-8?B?cVhBTVFLc0xtZlUwN1hRNVl2WGVVT1JzKzBTd3RmM0ZVNHMrMU11QU8xemUx?=
 =?utf-8?B?MUR6eEVMNmtPQzYwVWdSOWx2dTY2UEpSaVpNWEJFYWVjS2JzOVZzRjZqNVcr?=
 =?utf-8?B?OWJ1SWhFb01ITlF0SXRkQVBJZGsyV01Ealljb2VCRGhlbnNLTmRkWE5zeDJu?=
 =?utf-8?B?VDlFNXZsblE3dmw4TEM5Z1ZWS1RwVlJIMk95YnByQXRCMjRodGNUaGZFZVVv?=
 =?utf-8?B?RHc3OFhIVmVQV1MzZW9PWUhreWdEbnhaRzVJRURDN2lNS1JMTDY1ejRubm5m?=
 =?utf-8?B?YmtoRWJvZDJwWmIzbVRTRFlMbmNDWnJFYnV3ZTRMZFA5N1RramtoZEVVbTQ2?=
 =?utf-8?Q?SSxTO0vi1+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RiMC9JWHN6SkcwOTFHNUp1cVRHM0JXZytZc08xR0ZYVTFwYzlrWEhrOUtJ?=
 =?utf-8?B?Sloxd1dDNXRDbmFVWi84bG40L2NsM3c0SEpRaE5ZQ3JDaDNsVWtuM3RjdlBM?=
 =?utf-8?B?VVNvbFhQaHJqTDVSQ1hMNy9ST1dVeEQ4S3NFb3dCdWx2T2NVbnk1Wm1HajBw?=
 =?utf-8?B?c25zT0xQemw0Tit2WmgxRXVMckxSVVZRQXI1ZnhuN25qWGxONm1QWjRzU1BP?=
 =?utf-8?B?N3UzMXZVSUkvaFJGNmRNbTZJdkVtZXFlMHlHQ1BienhZUlNUalFheGJnQ1c0?=
 =?utf-8?B?Z05nbVNsc3VkUzVvVFhwTDRTaTNuTVkzUXV5NitZMWxjekVKaXN5aitQU1F4?=
 =?utf-8?B?NE5NcUVLdE15YkZ5aS9MMWRvakxudHpNY05yZWNnU2krNGVralhwRnNzVURN?=
 =?utf-8?B?UGsvb1hJVk9JcEkxU3EvcVdNSlpxTndSaUtvR2tiYy8wNVprdVVFTVRuT3lV?=
 =?utf-8?B?SHBKL3hwOUE4WU4xVmVReGxpTFF0L2dkNWdpQXRMOStlNEpWTHlxU1ZHRVZi?=
 =?utf-8?B?aFhKanc2VXJYRjZQYkg2SGpFQTN0VmJBNDE0S3g0UDFQUlFhYmFzMlRwa09U?=
 =?utf-8?B?N2pMOFZHckdwR0ErTUNDb0twaXJlSVF2Z3FwZElrNG1HTGJjTGc5Uk83U25S?=
 =?utf-8?B?RHBhbHlnc2Q5ZHRmbGUyN2FGYnVHQVFKZVQ4OCtLWTBzVU9ucWdXditLWWE4?=
 =?utf-8?B?b0VabENqd2t6RlpkWDNSUlM3d3E0MjN5K3VWMGp3RXk4UkdVNWVFaHBpZ29V?=
 =?utf-8?B?WDk0ZFZyL2xndWN0KzRUWFBIRE9BYkh2RVh3VWhJSHhXenBvZGVVbHJ5VW1t?=
 =?utf-8?B?d3VHeDhVVkJHYTdLMWc1U2FYK3R5YjRUM1g4QlhwbzdEUUdrQTRoMFlCeWl0?=
 =?utf-8?B?cUFhaVpUQTVxZWU1RUJVaXRCbGUyU2tWOG5ueG1RZldNZk1CSHMvZ0RYbFhB?=
 =?utf-8?B?U0dhckVCeGdmODVmaVF5R3d0NXBOWjFpWXh4WFF3WnVJbVV1cVJIMm1SWTBE?=
 =?utf-8?B?dUo3WUdzdVh1RkhSTHRET3doSzBjQVgxcWNHWGJhVndLWGdxTDRoTmlHRFl2?=
 =?utf-8?B?MVd2Y1g1NTJDTk5Wa1FXWmdXd1ZJajR4Vm4zQkFlZmRBaDBWeHhJaUZtRWlX?=
 =?utf-8?B?dG5teXJ2QnhsdEJGV2JvSlpiN1p2UEVZVnlQT2JsR0JrY0RVWG56OUhXOTA4?=
 =?utf-8?B?UXlRUzhLOE9ETGJwSUhKZmNpNVZNbzNPc3h4SjdtZUhlc3lDbEhSNjJoNmJw?=
 =?utf-8?B?VHNQODJhOWNUdzVsc0FrL0FXWjRsL21KRmhMaW1VbU1xZ1lTTkVjS0RDNUIy?=
 =?utf-8?B?T0Yxczg0UzgxOTJoTEtRb0k1TXZDUmY0OUVMZ2JlaXluVkZBVDV4dXcxZTNG?=
 =?utf-8?B?M3ZlV3krSVU4UnlHK1NWMTNrbmc0d2NWMnAvY2Z4MEU2ZlpDNDExVzZOdGtt?=
 =?utf-8?B?VEpWdlZSY25MSUdZWThDdlpOa0lzc1lpMVJSOTl4SFdPV0RhZ1NWRTFiR000?=
 =?utf-8?B?dWkzV1haVHBkbVc0S3BnYjdzNlhmTXh4dXZ2bTRERlZhcjI1UUttVkdOQ1ph?=
 =?utf-8?B?WUdybUFmR21IVVZRWEJkMm1BdCs5RkhTUXhtUVRtNTdCL21HeDVJaU1lazZw?=
 =?utf-8?B?NVAwQ2Y4ZGdieU41VXdCZ2RuWnBRTjRvU2Z6Z1NFR2JWa0wySUZ5N1hSWmlk?=
 =?utf-8?B?S1pXM0RkVDBMbStabGRjcnd5MjZ1dUxTK3JCb25qZXhoRlZ6VmlQZVkrNUM3?=
 =?utf-8?B?SVBOS0hGVkNrUDhzUjJrMUYvTFQ1OHFqazhlelZtQzIvSXZjUGhiRDh6Y2cy?=
 =?utf-8?B?NmhPUnVqNGlMWGpMZm14Qll4NkxnMFJVdGZmODU2REpvU0d6TkdLUUk3a3B2?=
 =?utf-8?B?N3QvVVkraU5Helg2WG9wVEhsK3l0ZzE2V3lYTHJzNXZzZW8vWit1cGNCZUNC?=
 =?utf-8?B?VkNmRW9QWkw2enVUY2VZVUcwWXZOenB1YmhoVzE4U3MxekduRjFzQ2VtZXIz?=
 =?utf-8?B?eDhOMWI3WXBHQm5ZcXJ1Rkc1VzJzSWgxQmNnL1VBc1UyeVRZMGpMM2drWERX?=
 =?utf-8?B?TTdhOUxhZjYvdTZXNjJ1VEhLanVBSktNMzlKQWxRbXN4dTZvb052dDJXanFu?=
 =?utf-8?B?Vnlab3ZuVUZTQXNQY2xNTlRQMElVNjBETUJxT0V6UFNzbzkycUhFRGFQV0Nk?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ad372-7aec-40b9-a053-08ddc5700699
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 20:25:09.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkJVUK58cHbUh9xvvopQ5SNn3HgtUrTy1UYbY9+h8KkDImJ3W0zUZf90Ayrb7coqf8OBm7HlIe8FxaxjKmiJFvbUqeD/vpeZZ4pd9PcFfJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
X-OriginatorOrg: intel.com



On 7/16/2025 2:12 PM, Samiullah Khawaja wrote:
> Use netif_queue_set_napi to associate TX/RX queues to the relevant napi.
> This allows fetching napi for a TX or RX queue using netlink queue-get
> op.
> 
> Tested:
> python3 tools/net/ynl/pyynl/cli.py \
> 	--spec Documentation/netlink/specs/netdev.yaml \
> 	--do queue-get --json '{"ifindex": 3, "type": "rx", "id": 2}'
> {'id': 2, 'ifindex': 3, 'napi-id': 515, 'type': 'rx'}

Hi Samiullah,

Thanks for the patch. We do, however, have this functionality already in 
flight [1].

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/20250624164515.2663137-4-aleksander.lobakin@intel.com/

> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index bf23967674d5..f01e72fb73e8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4373,7 +4373,7 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport,
>   					 struct idpf_q_vec_rsrc *rsrc)
>   {
>   	int (*napi_poll)(struct napi_struct *napi, int budget);
> -	int irq_num;
> +	int i, irq_num;
>   	u16 qv_idx;
>   
>   	if (idpf_is_queue_model_split(rsrc->txq_model))
> @@ -4390,6 +4390,20 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport,
>   		netif_napi_add_config(vport->netdev, &q_vector->napi,
>   				      napi_poll, v_idx);
>   		netif_napi_set_irq(&q_vector->napi, irq_num);
> +
> +		for (i = 0; i < q_vector->num_rxq; ++i) {
> +			netif_queue_set_napi(vport->netdev,
> +					     q_vector->rx[i]->idx,
> +					     NETDEV_QUEUE_TYPE_RX,
> +					     &q_vector->napi);
> +		}
> +
> +		for (i = 0; i < q_vector->num_txq; ++i) {
> +			netif_queue_set_napi(vport->netdev,
> +					     q_vector->tx[i]->idx,
> +					     NETDEV_QUEUE_TYPE_TX,
> +					     &q_vector->napi);
> +		}
>   	}
>   }
>   
> 
> base-commit: 4cc8116d6c4ef909e52868c1251ed6eff8c5010b


