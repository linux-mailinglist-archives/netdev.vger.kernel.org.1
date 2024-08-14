Return-Path: <netdev+bounces-118599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C0952319
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F001C218A1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4184D1C2320;
	Wed, 14 Aug 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TW0M9TZG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B9370;
	Wed, 14 Aug 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666491; cv=fail; b=Freuk2dusUyBoiSKn+KP0myLkp0yHzX0yEYMphWH1iYitTDdVIiMFrG+VdqEVoIAQPOuAx2M3zHOZ1jRSZNszoYKp8LkMHYJlfgFTfqVgw1jFU0v9EJHFQcSg8+ZCJuH591mTGE2jNU5BUQFOXbNrYBGOMPosZ8GoatcjPX0lYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666491; c=relaxed/simple;
	bh=vGhtb04FYwDeh3ClZBFQbkLcpNAvrHi43rNinQOOaKY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7lzFyBE12uHNOYJSiTdj6bbsDgsInEzIslvLpHI6i3WxqVoiuYH7TQbnT6jyMfwGOdshm0d6vu/EYe+RkTZ/dhwpJw7FxliCsCEfN9Xu9SkRwmR8ktxlaJAQk+gGoG80Kkj6SZ5C9hhqk+RLIen73x/0ECZpPLelMa5KvmFwBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TW0M9TZG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723666489; x=1755202489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vGhtb04FYwDeh3ClZBFQbkLcpNAvrHi43rNinQOOaKY=;
  b=TW0M9TZGcAo/YwKefqEFfXFyP6/R8fSJdMOvo1T8K/gvao88A7pqZlRd
   iicMbkzVxD+d2zEBNBE58Hm31S2oRbKgTT5tSEqjjfxJKQa1IbFqYkE/L
   MSpksPDxf+DaXJT/2KFrvV0bqFxMjiONZgyPOTG/veSp0lah8m2xXGN4D
   HbbA41/hTT5RnfG+ysaHXX76EXUs2uVxxRBglY5DTmj0kAFmvsfYl0n0E
   suoG2PJf59JqvcJfKWUcj9tAD7vFwWs/LfyRAhNOb6vfNZMz3PxsH1e96
   XZpDiRDMopS0hoQdoOD4YW04zb4849t/xYc0LjL/whUevOy7Ti6Nnwv07
   g==;
X-CSE-ConnectionGUID: er1JTtABShaWiAQCZE2AwQ==
X-CSE-MsgGUID: PW3r20KzSv2gh88hYzRk9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32481881"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="32481881"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 13:14:48 -0700
X-CSE-ConnectionGUID: 7q8SqOHRQlmUmLQZMcKbXg==
X-CSE-MsgGUID: aGD2Yt0ZSJu3agl0DpkGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="89920857"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 13:14:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 13:14:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 13:14:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 13:14:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4e+R6iyJqMNp53HsRsWy+4FhQM6ypgqZ/7jy4jNd0R/KSEHUxQnHfv70m2pmjZ0UmR4TmpChjr13igT6thdDarm9cep0RisGW9q+njZF7D6csTBhIxIEFnfWZNfqyqY5EyGcjGXJ+Y13KSTjUcDSI1Gwkx4oT4CYQRvq1vQ6sPEoCK1dTGVpdR2h/N0JFc0ag8I1mpRA7esAsnqm7wAQg3o83jI3frccIEM4KKSKpiVkQkFxcll2PUQDJlF1qp8ksjMsRw+FxEsCk/vettv6Dc+WPH/mo2SkHyXxekQtJbH91gLbx2MZgWj51f8INk8P8VoVc7oPPWsVc8czhGkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVsfihqbo2mgY3pJ8PWZmXbCWL9m3WsIb/r0Ssn24Qc=;
 b=WFfYJf9P5w42ldfZjp/Mvw4wFLqd7JzSM9xi+GSPHjA63i9qrTJPmG2b/hJEV1sSZ/SSjVpfzj0A192TjzncTwGNYoBuYTA8GzjqENy8PAaybFI0G+aYh31L+AwnoThzGeHAv2wyFr+fxVORJHyC/PH4eyVUQrEUFPni3mcvzeFmYrCh7xISYqWzYOIR2KDGQmTogiin3B8XpS1mHJzStlSMQ3KQ9ZqzRUHDajpGRIQLl47T7Y7uwCJhn58reH4h2Lmdwh3qAy3Kq5+8ovWFdsGqcGpDKLLyPv8DuBCthYHlm+RPGHEu8KhTt1rGvguFtDhbb4fmXj3wFvQ7GHT/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS7PR11MB6174.namprd11.prod.outlook.com (2603:10b6:8:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 20:14:44 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 20:14:44 +0000
Message-ID: <4a4c4a1d-2091-384c-1fc9-68d9e6c07727@intel.com>
Date: Wed, 14 Aug 2024 13:14:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [regression] igc does not function anymore after second resume
 from standby
To: Linux regressions mailing list <regressions@lists.linux.dev>, Sasha Neftin
	<sasha.neftin@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>
CC: netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	intel-wired-lan <intel-wired-lan@lists.osuosl.org>, Martin
	<mwolf@adiumentum.com>
References: <acaa3e31-a6f4-4c45-b795-d12b0d2743da@leemhuis.info>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <acaa3e31-a6f4-4c45-b795-d12b0d2743da@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS7PR11MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3415ff-eac9-4171-906b-08dcbc9dbcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alJyM1RKRnJXcE54MFZlbUJidlNRNVhWUjg4bUlJQVVrRXBId2M4NFFGSDVF?=
 =?utf-8?B?aUE1K29LYS9MKzFqMHZpbGxsS0dGaGcyZEdhUEdaRHlVNi9oVkdycFVuZmZq?=
 =?utf-8?B?TUxYYkdjdjNxblFUa1I5M2JuOWY5NUJEcm5QYTRVU3p4Y3k0dWRxVGhKZGdG?=
 =?utf-8?B?SVlPNWI2c0ZQVWhtcVQvTkthQk9YQ3FEOUVqSUdtTkt0dE5FcjAzMEtkUnpi?=
 =?utf-8?B?a29lZ01WalBqcHI1b3F3cU13SDhZeVRMT0dMbkhnUDhaTUphWEdSMExXekRE?=
 =?utf-8?B?czNtQUh2ZllOejk5c0FiOTBYbWVWd0ltTWg1VU03d2dqV2pBTG95TDYwWHZh?=
 =?utf-8?B?TUFKWlZ0bnc5cm4waXVGdkJGTVQ2ZkpDeHRDR0FWdk5COW1qTkhkVkxoWTZl?=
 =?utf-8?B?UCswNVFsMHNNVTlQNXF0b2NjNVJOclM1TWZOZUwxNTlod0FQZlJ2UUprOVdt?=
 =?utf-8?B?MkhyMVppUG9sWThFSG43ZzkyVTE5eDIvdUVoeURuRk9PUHVxNnUrakNKMnM3?=
 =?utf-8?B?ZzFPZDV4Y210RlVXN1VNOHRwd2tKZGhFaGJJVUhjaWc4cS9RbWlWKzZTa1JI?=
 =?utf-8?B?djhlMnFOQmg2Z040cXl1NnN3aGZTSjZuMW1PVDBFbjhaUGYxckxMYzY4OWEz?=
 =?utf-8?B?SnljbW05M0hlUmpKQ241ckswTE5PSHN5aFVUV2JYR2doQzJGN0xQblVzOVpX?=
 =?utf-8?B?K3dSVjJ0R1diNXVsaElWVGtLOWdpcjVvQVFhZWhuNUlnS2hRQWJhbHF5MFRF?=
 =?utf-8?B?R0FlOVkydzFMQStEK295WFYxOUVVdlA4ZXlEOXR2TFZ0TFhsM2NuZFlXeXll?=
 =?utf-8?B?eDZZR282Z1Vna0tGZ1p6WnVFUlZybEliazJPWUgvRGZMZWlZWjVLdlRLVG1U?=
 =?utf-8?B?QTI0Vlc3WjFiWXB5VG5WUnY3bXlrdkl2TVBnYlhlRi9EMFdpZHFLSWYxL1JN?=
 =?utf-8?B?MjkrUmljdUtTUmVoaklNRDJyVVVVek9VQ1lSeDlHOUlQamd6Z3lnRlMwQmth?=
 =?utf-8?B?NUxRSE1FWmd1N3NDdkFQaEU0aHYvZ3FIY2N2aUtvejZCMXJJNm41ZU44bmJ4?=
 =?utf-8?B?WkhqWk5HTE5xaTJKeTNHMzlKaWVJY0lodWVFRGlBN3gzUmxHc05OMjV2OEpE?=
 =?utf-8?B?eDNOYngyOVdQM3l3VlIyUEZHU1l4R0Vndmt5OEZNMEpVbTBTNk1ybE5kSU9H?=
 =?utf-8?B?M2xMMUVqbjUybGhHR0Myc2R1dlFvUWxBT3VkcWI5UDlZa05vNmprcE9qK01k?=
 =?utf-8?B?YkJFRjVlcVZQdG91bGlCUnFLY3JXbjlMWTR6SHNWbUhsbEljczJEZURmUzM1?=
 =?utf-8?B?Z3dkNERpUFJFQlZkNjVlZmExcDcwcUsyU0UrK2FCNW0vTU51Mmw3M09oYXhx?=
 =?utf-8?B?NmoxcndnSGhXSUNhU0tTSmlIVkFHY0NYUHNCMTdOa29JN0dqTXhTekVMa0NL?=
 =?utf-8?B?ek5zelRxa0toaUtkRGZaNXJjT29sTjZ3aytzN0pMTVBHU29ZaUd1UU5xSDJN?=
 =?utf-8?B?UjFJMlArQnhPNU5ieElMamV6TWQ3b1BocGdPSllSUGE0RFhKcWZXUHV0QzQ0?=
 =?utf-8?B?Q3ZtYW5nMXJHdEJDZmpMOXVqL2w0U3Npd3I5ek1saEVQb2grYWFOemV1Ullk?=
 =?utf-8?B?ckFRUmJuRDQxV05tZjNwT2NFeVZtOFk3amlJeHNXQmdqc2I5SnNkRXZsSlgx?=
 =?utf-8?B?Q3I1aHB6emtNOFdTSVZaL3d4b2I4RE5kSm10RlJqSHd1a0YwY1RQNFNMMDZp?=
 =?utf-8?Q?P4DsAe/uVp6dooGkOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2N3cWxnL0M1dVE0ZDYxbEZrVEpEdlRpbDFWQTFvUnlYa05VQVJsUEhLdlZk?=
 =?utf-8?B?Q2dWQlVyM3h1TDhaaW9mQVNmWE1IWFN4TFlmQ1FiUGJFcUZZV1NrS1AzdWlV?=
 =?utf-8?B?TGJ4aWxUOVlQN1VrMENCSlZmYUNrVzM2RnlZR2NIeHpBY2x0b3NvVlNkSi9a?=
 =?utf-8?B?ay9nU3pHczRpSEJiOHBMb2ZoQ1gzYW9CdFAyTTJhSkVDV3V1blBlNzd3THV4?=
 =?utf-8?B?OUJ0STJ6akhpTklDSVlhdVNOWDdaVGcxTnUxLzZSZmVkbjZ1Q3ZTNnVsbEJy?=
 =?utf-8?B?R2syYThSZEVqL1pnQ0hwMnhodnJsQlkycmFsYVRlcUZIU25ERFI4M2hYVVFU?=
 =?utf-8?B?a2llZUtQb05zQzMydUcxYklORHFlcFZRUTFlQ0RQOCtFWlpFL3Q0MjQrNTBV?=
 =?utf-8?B?WnY0WWMvdWdoNlZENENER29MdGVMT2kzVURPNGNUa0taMi9sSjZOR05RWWNu?=
 =?utf-8?B?ZzZ3VllseTRlbXhEZTdGUTRqQTE3S0U4MW1LZkdlWWEwRm5NWmpZUyszcWRz?=
 =?utf-8?B?TjZyb1g3a3c3ckRseDYwc25pUDBUSDdPek5LOWFCcFkyZ1pCdTJaYjVDSUR6?=
 =?utf-8?B?UnhzUk5admZ4SnQ2aGF6VFU2WXE0Rm9veEtkYzY1bGNNTGZ5Sld6ZHUwYnFE?=
 =?utf-8?B?ZDJFeFN1aUQ1ZHAwUHc0QllHT1lmSDlBK1Jjc051UUpvREo3STllL2tiT0sy?=
 =?utf-8?B?bzZ6cWJ4OE8wTkZEVEhNYWtxRzNGcjI5eGhneUlPcUsvbk45S0Z5MlZtTTMz?=
 =?utf-8?B?Q0lxL29USEpmU0NPYW1salhJdDJ2WlNJd2x2VHlJYXN4dVR3UTArUVREdFZ3?=
 =?utf-8?B?UmhlU2M5UnN5Yi9RREc5MEw1Rlo2dklyNTFyNEtXUzF0QVdxdTZQL0g5Rngz?=
 =?utf-8?B?cE9YWWQ1clNLUjRWbUJmVCttVWdZNHZBUUpsSnFkNno3TUM0aE9XcU1EK3g4?=
 =?utf-8?B?MDdWcXRETitGZFY3aDhQUnJFa1dOK2VPRE1xblNvNm1ZV1pXVVNBM2pzZksv?=
 =?utf-8?B?QnZIVVdJeWFCWjJFUHhCbnU2N2JaVll2ZHdDSDQ3UDNXVjZsUTJucVRRT2E3?=
 =?utf-8?B?c2g2QkVLZXV6SHdBMkh0UHFvQU5PNm5YY3pKbXpldmVMak1PenZxdTlBN09p?=
 =?utf-8?B?elcxQ2JZT1NkcDZtTXV5dldsTHdqS0EzSEkxaHZmNnZIVjNuYk1DaFZLaStX?=
 =?utf-8?B?M1ZaQ05lTWRXOFBSeENnZU8zbTlleW13SW9pK3ZaQnFYY1UrL2tEU1V0a2kv?=
 =?utf-8?B?dXc4Qk5HOHRFRFlUNUxNUk9NKzZ1RjlOWlFyRFI5Y0c1eXFXSGFyYmVDVmFF?=
 =?utf-8?B?OVVZd3JKWE1VNnNxejZpcUZ4U3Y3amczcXZrdXVzQXBheVJBenRXUVhyazFl?=
 =?utf-8?B?QlBQd09xdUNDQXNQQzdRb1M3ZDQwenJFdFNnaEhSYWx3alJCNmZtWEdaY0VU?=
 =?utf-8?B?Vlgra2VaUlVvZ0Y0dnltVkYwbnN2Ky8zRmg0T1I0dnE3aVU0aUtMOWVFUWRz?=
 =?utf-8?B?Z1lmWjFSMWtjdERaQlpCVGJ4M3pCZ3FKNFVyR1RMcFp6amdSN2lUZG1vb01Z?=
 =?utf-8?B?NHVOaWs0a0tRLzhRek5TZG9CSFhCWUdUaFN3OGxSa1Q0YmZVTjNBbWlVdktM?=
 =?utf-8?B?cTE1STJ0YzNsQUNhRzc0Ky9FSndlaXdNdVErL1cwV3QwOFlzMStrNmFJOWdv?=
 =?utf-8?B?WXBvR1BnMjFSMkZjRXpZcURoZmsvSEphSVJnQ2xGQXZ0bmxpR256aElCUzhN?=
 =?utf-8?B?NW4yZUk3VkxsSDFoeWlMcDdkbkhCci93RE41NW5uM2tvTzRRWVlhYU5kTlRv?=
 =?utf-8?B?MDUxSDNqUUkzemY3ajZVM0I1ZXJsc004MzBGVi9GTEtvT2JHdG1YTVVzRlBK?=
 =?utf-8?B?QWlEZ1kwZkFWUHAxWmEzRFRmM3RkWVhjNjUvZC9CaTRsSGtJYUVDQjZ1T0RH?=
 =?utf-8?B?aGxRWklJbzBrV0xhME5aQjR5b1p2RU1XRlJtR1FQSFEzSXpVUnJlNGRVMWcw?=
 =?utf-8?B?dUhHUmxWSXFpalJLVGdZbkpRZElKU05CZDNlcGRxUmQ5UWN6bUxzQ3VLSXJY?=
 =?utf-8?B?cWJOMUlyVVp1NUNWRzBraEtKYkkyZ3hLSWxJR3NRZUwwbWJDM2E0YU92SlhZ?=
 =?utf-8?B?andvbGZJcXhtQkxkWWtLMzByTVcveFh0TmFteG8xeFJYQmxKWDc4RkxrMUdy?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3415ff-eac9-4171-906b-08dcbc9dbcc0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 20:14:44.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOZsxvoWdpFvxXbZUiisms3F+zYpyyDTEdNlEkxiRb7Z8MrvgMvpAzYJiitpgzi7rdtYj4xMNtrVuBgNaBlsw7q/rmrMA1nQPwww84cq3CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6174
X-OriginatorOrg: intel.com



On 8/14/2024 3:42 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> [Tony, Przemek: lore did not find any mail from Sasha in the past few
> weeks, so from here it looks like this might be something somebody else
> needs to handle.]

Adding a couple of others who are involved in the driver.

Thanks,
Tony

> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Sasha, I noticed a report about a regression in bugzilla.kernel.org that
> appears to be caused by this change of yours:
> 6f31d6b643a32c ("igc: Refactor runtime power management flow") [v6.10-rc1]
> 
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to write this mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=219143 :
> 
>>   Martin 2024-08-09 15:17:49 UTC
>>
>> Starting with Kernel 6.10.x I experienced network connection
>> problems after resuming my system for the second time.
>>
>> My system contains two Intel I225-V (rev2 and rev3) cards.
>>
>> I ran a bisection and got a hit: 6f31d6b643a32cc126cf86093fca1ea575948bf0
>>
>> rmmod igc ; modprobe igc remedies the issue till the next but one resume.
> 
> See the ticket for more details. Martin, the reporter, is CCed.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219143
> #regzbot from: Martin

