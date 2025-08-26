Return-Path: <netdev+bounces-217072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A5B37433
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585201B278C4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAF283121;
	Tue, 26 Aug 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrSxM7sc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE01A0BD0
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242397; cv=fail; b=rpoG2jJp8MA5VzFfJuwv/d/rNOw0FtDWvPEos62Kfaicd+kFzgJl2CWbjKVdZI7B5MjxYPq/HQUF3GysjZoSpcDNr+12Dj9rGfC5UnCTi2Juf97qGan18Dak/Y48SiNySnYy4vYscjxIpTS7rFnwjpe+pFWGYJBSYrhmCN7MaI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242397; c=relaxed/simple;
	bh=A5GU7Di09pNVoNdqifveW67v6Inw+f8pBgNJXTF4l1o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0yuBZQRN/1U6v2TcE3qIdd/3D64rVOOqS8F8mKzwvD2Gn+EfbAu4nggrOFnUKP/iQxLYFT7MPN6HmGz+XnZyzZHr3oYmG+luTjJfSrWHgi/1yMk8mPS3R2ZfliMyJbpTQCwqmv/wzhkyAUdmmidiqj/UFkqVZg6Sj0ByPuI9FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrSxM7sc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756242396; x=1787778396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A5GU7Di09pNVoNdqifveW67v6Inw+f8pBgNJXTF4l1o=;
  b=lrSxM7scGsE752JXfq2havRVtnuKIVsOOpwTXetUp5T326MuSB5zhq1h
   mAatn9mSZ+9kwO0XsHlWhBwRCd8xIzZF818Z5M2Fl1EH9Ln4snUaivP4N
   qrZ3Vx1StPtx33ch3F7UWEIGdw51XNIXfsJu7+HaY3GVwIKyhBRFkXoXM
   pplvXRbHXzueqz1KIPmjfuft/l5AlHt6G9/JtWljMELEMpjeZOGZhmGbA
   EGAw7vOX5WEWSVA0yn6M30G1IGgM5UAQSGNOrfLPW9I+//fnzxz6+VjSC
   Jit/zUdfvU0Fg+JIq6DnBOwyz7XVyEdid9stj8Z9kvE2PWMCE58rEchV1
   g==;
X-CSE-ConnectionGUID: t4vhX5O9Sl2E3nuiVHZfdQ==
X-CSE-MsgGUID: kuZtaETyQJOlA0hZ8mgJ+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69929751"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69929751"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 14:06:35 -0700
X-CSE-ConnectionGUID: N6KmIYx2TC2kJBiMhPxcMQ==
X-CSE-MsgGUID: A2NKfoiiTMC1vP+qOMJalQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169610818"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 14:06:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 14:06:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 14:06:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 14:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOComBBHsHMcdarrESKNbziJi1DlB3x2uoJeijRfYocd7gwCk3MjY2KCJxQm9c4tVzHcTlopArXFS7l6XpVrPUkUSr+MfyvVONqE7R7P/IYHEufBHFwukyogJ7U12J5d8V8p9Edq5UYxI5f5k8L+xrlwQMvnmWz70EImH3KIalGKMpoOybP5DUyEBWgZYTHyfl8R8Ka7Kek0TnrWALmmhyJrHajaOyI7ATU+n3WuK+PGDiZJ5UTnn1KYlzBIwvuPrqNy/xhWm0b8K7G7fWikITnK062wJ4tTDYtudNIzxOOPXe8hrMHZ8ipjU0QYlrl2wYi/xvNaF97AVtrycDpLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUft+mojMc4J/ieNCNgI7PPJqibsO+26B/QQ78JUYEM=;
 b=BiEnyxqAElnX9w+LZ2eRgakcyrCimeyjr0FKsMVYQ05a09IqZvTy7UNozZosxrpGVAQWze5Z405znYw6J6s0kua7vyECwKl1Cjw0dw7ONl3/BcWCzNl3S1bj+Q7UU0cCtvvG8nBYtUXjigoxLmUxRPBAeHyKJjbbXrNr4JLbiKz9w6iTBM52gigidoWqw+gY282gSYoQAwO//QvKbkgXZlOyy94KKgk1cnM39Gfd9idnzl5Z19V7BVQDZpz1QyDzcwNk/VM4qu0u1AxqQC/sfNd7Q3sAbEg85nn7Hbkv9orOAJnUJXenD1yWV4Q7Wo6+KF+poKXRA5khu7VjrTeiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 21:06:31 +0000
Received: from CYYPR11MB8431.namprd11.prod.outlook.com
 ([fe80::546b:dc38:a70f:1c27]) by CYYPR11MB8431.namprd11.prod.outlook.com
 ([fe80::546b:dc38:a70f:1c27%4]) with mapi id 15.20.9052.013; Tue, 26 Aug 2025
 21:06:31 +0000
Message-ID: <cd911ad9-b590-4880-b72f-5b65f7d33a52@intel.com>
Date: Tue, 26 Aug 2025 14:06:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] idpf: add support for IDPF PCI programming
 interface
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <madhu.chittim@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>
References: <20250826172845.265142-1-pavan.kumar.linga@intel.com>
 <fba6fb6f-4d14-4e75-bbb3-2fae2862a7ca@intel.com>
Content-Language: en-US
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <fba6fb6f-4d14-4e75-bbb3-2fae2862a7ca@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To CYYPR11MB8431.namprd11.prod.outlook.com
 (2603:10b6:930:c7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8431:EE_|MW3PR11MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e46f336-9312-4599-3b8e-08dde4e46e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnBpV2xIc2xxajVvYVZTbHVTMHFncHN6NllURkJ1OVRuT3N0dUJ6ajE5a2tN?=
 =?utf-8?B?R3RJTVVDU1JrZzJVY1A5Und1SzFzdFNDNlNZMUpHRGdpcWtlRlF4aHgwNm9O?=
 =?utf-8?B?eWhQNlhEbmh3UGVjSG5lTHZLVnJHZ1FKeHhlczhCei9EOU81bkV2aU9jcTcr?=
 =?utf-8?B?Y09SK2RCWFNvbmFOa0VhNjRmbEYyMGd1SnlMdWk3Vks3dTlrQjRGRDZVVVhI?=
 =?utf-8?B?OXUrbU0wS21pcGZJMkNDYW1OVEtPdGtNSkhlMkp2YzVBbUFTdWNYbExBTi8v?=
 =?utf-8?B?MEc2RUJQSEFMNEFyVzFSUmdZTk5GTGlKY1dhVGUwdWpSamlhMkozWEV6RXFC?=
 =?utf-8?B?RGJuMlY4VFhWRys1K21XNWJkNEVQTHZoS096MXZETkV4aExaOElzcG5qeUJr?=
 =?utf-8?B?UG9ia0NoTHMvWXIwSGgvbmxCeWxlUG96aUhHY25GUEZidTJCdTQ1ZFdWeEtH?=
 =?utf-8?B?eHRFZGdCaTgwQzcxd1RNS29KMWdQckthSWVUOVpEUGJJaXRnZ0l5WTMvS1Uz?=
 =?utf-8?B?SGdYWjVjMlRmZm9LYW9uT0ticVlSa3RQMHJJY2VsTjJlWnA2aE04NVdjbVRr?=
 =?utf-8?B?NU9KdE1MaDM2SVExUEVDNEp6WXpFMkFFOGlRNzdMbU50Qm5TUldaelJPdkVN?=
 =?utf-8?B?UkpRalhZNlpHcXZadEFCZ1RyRnRtYlpnWk1qaFJZTHdISUw4Tk9kV3JBQ2RH?=
 =?utf-8?B?T29kMG53YkZ0bkVxQUcvOGhmakRZU0lRNWRuR3d0ekxIa0NaUW10R0xGS2Jj?=
 =?utf-8?B?NWpWaTVKSXpYZjRmaFhvZDRCdkIzelM1cGYzVnBKTkpMZXMwQ1pZTkpQUk5G?=
 =?utf-8?B?U0hsUjQ1U3ZhcW15dzdYaFVJUGpXN2dMd2xkS21HdkZxRXJVU1Y4c3pzOWU2?=
 =?utf-8?B?cDVRMGw1YzE0SE5rbWIxK1Zlbno5RUhLK1hDVGVlSlkvZnFYZTNramozV1FP?=
 =?utf-8?B?RWlad1N2Z3IzZE12REh3YU1XWDZQbzJuZkFNNHZtWUtEenBNOHJYRlk0OUxr?=
 =?utf-8?B?b0xXbC95ZHFMbk1qYmgyVEhVaXd3Wmt4MnYyN2NMQVZNcFJGdjZkR1FDUll3?=
 =?utf-8?B?MUppWW9HWUd5UFAxaDZPRHR6bzRObUdKVjJjczBRSWozRmt1bmk1eHorN0dC?=
 =?utf-8?B?T2ZWYUE5V1RzVEJyUCtBWjdDZnk2eU1CdXQ1SjdXSE5rWitZNHVlV3hCVkkx?=
 =?utf-8?B?dUM4dEFnRkk5dEhIY1RhcXl3akpkaTVuSFpUWGxmazNaZU5CeE1jazJ4Y0w2?=
 =?utf-8?B?SHoyTGxlY0srVm15WStTbUdGN2Nwc3pqazhwa29jbE9NMUZSRDl1RXo2Mk8y?=
 =?utf-8?B?aXJCSVRWdzNkQkNVR21CNXBYeUR1ZGpYWHkvc2toNkNzbW1ZSTZMNmJLMWJJ?=
 =?utf-8?B?SWl1VlNOckM4b0pIbEpOTk0vWWtwZDJFaDVOMCtGK29qSUFkcFZKMkJIa0I4?=
 =?utf-8?B?akx2WFZRanIwV0RkWXZQZVVpSE1vem1DbnEwTUVWMEFHeGkzVnNkMmRQUHFY?=
 =?utf-8?B?RCs1dVNKNlNjYWFmUXE5aEJuQStEa2U2Y2x3T29yM3N5aXZtc3YvcDFNMlNI?=
 =?utf-8?B?ek1kRnlxdXRrMDVmbEVFZTJBVmlybkJ1Zk5YVi9EWlZkN0RUcmZBTDFabnRy?=
 =?utf-8?B?dDFUNmFtMTkwTW1KbGdoeVFjMmNHTHZXeTVkSjBnTWF3Nm5MaHhxMEp5KzM3?=
 =?utf-8?B?UUxGYUdQWU81UGc4Qy9IczJqMTFjdUNTWFlvUjNUYTZjYWZjYW1xZjFRdGlq?=
 =?utf-8?B?QVNHVzRLMGtaalAwaXY4VnRsYmFMYklXQkNWcUYxV2FCM2JkeVpDR0NEeFor?=
 =?utf-8?Q?2jxb8GsB+L+FAg4piZ4WxqrrIEorDcHxrtcjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8431.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpHaWdINDB1YmdlQkRKTUJxWHZWZm96ZWJzeS84N2JGTHZyM2tJeU9ER2Vs?=
 =?utf-8?B?b0VYQ2wrT1lmRGJqVFJQbTNMTFdTUCtWN294cHJ4eENRMlljeXgzbkRDYnZp?=
 =?utf-8?B?U09FV1lRZDQvNTIzdkJkLzNXTk9VYUI4Y1NuUTY1V0tjUWszWit4clJUUjVz?=
 =?utf-8?B?dXloZEdYY2lKZmZtTUtWUkZPWGpjMi9sdFJKOXcwTmlwZXdFTUxsWmFSNUd0?=
 =?utf-8?B?TU1SeWluMEYrQTd6cllZK0k5RjhEd01nM2JpSnpmbmV0Z0wzUkhaZGIvNEV0?=
 =?utf-8?B?aUt6TlB0SnlQYlNBdzR5ODNBYXYwek9GcUtjdjBZK1htWDBGVnpjTUQ0eWp1?=
 =?utf-8?B?UmNlMWk1UHQrQ0hTQlduNit0VTdwUnpUaTlaaDg2Ynl1cmRTMnY4RitBc1E1?=
 =?utf-8?B?blIwS3ZtWDhxcGxveWtZejM4QlJRcmY0MU1JbjZRc3dpd2NGYzdkWStHL3FO?=
 =?utf-8?B?b1M5bFgyUVpDQWNYb3lPWTN0R1NiM1RJanhsaHZxTXcvVTZ3QlV1dkZDK3Zj?=
 =?utf-8?B?YWNmZnNIYjJ3ZUcwRTBYMjRQcm5hZEc4amdqblhwRGhxZmVianRFT2JiTEpC?=
 =?utf-8?B?VGIyM2FLVVozUmhPRFRVanVOTFhJUVhWZUNYRHZSd0NBUzNFWWpod0ljaExx?=
 =?utf-8?B?MTFhVTFSbkdOVEdTelZEeHQyWWU0QUMvNlJ2TzVjR2hQL2ZzWU0rdmt1ZkhE?=
 =?utf-8?B?RDhWQ3J1QnFQdEVFWDZPRG9uSzB5THBFQWVMeUJkOVplTGxWNnRXdjUwQTRx?=
 =?utf-8?B?UVlPN1dMdm94QTdFYnlJSWhYWWtqL3FDRW9SNVpQSmVDZ0FaSXRkQkZDWWQ1?=
 =?utf-8?B?STlmNFQ5N29nTklDVEZTNHl1UjVzMnZyY1poK09QVG9BTnNRYit4NFZEQ0Vr?=
 =?utf-8?B?dU9VaHE2Z0ExWkNRd2V5V0hZcm9YM1c1K0s1SUdlMFB0VjdMUkthdW9zWEVh?=
 =?utf-8?B?QzlDSjMzOUlVQkJaRC9vZ3NEMGVJZjdnV0RSK2dIUUJHUmNqcGNiS0gyRjBq?=
 =?utf-8?B?WDFQTlhQUkhrUzUrQ2diYmtTcDJVeTM0cmR4TXF6ejRLd0pXM3UxZ09pN0Y0?=
 =?utf-8?B?NkU2cTdPTmxiSEtGQzhGcFJqdU9hb3dpWFoxendWaU82V1dUUjhqaXIwL0E3?=
 =?utf-8?B?cnoyVEs1NVN1dlg1b0Iyb0pxenhSZ3lzWmpVK1BtckxWaXhueU9NWTByQTRm?=
 =?utf-8?B?dE1oTzlHZ1FUaUFxK1RNUGRhL21aR2NIdzlxN3FDdWVQZEVjSFJVSnpycU5u?=
 =?utf-8?B?Yy93OENpb083TnhWa1E3YUhEU2RRSUJHVUMzTmJ6azdvQUpSRzlaL1ExMWRa?=
 =?utf-8?B?V2tmU3NaOWt3ZnU3SzlVeitzV3B5eFd1aHMyZEY4WVJhb2xLZG5kUHFpVjNl?=
 =?utf-8?B?M0pBWHkzZGpMUno3YmZJZmlRRWRxbGo3clF3VUZTYlBjRUNUTU8yQkZiTGFV?=
 =?utf-8?B?WDdWRGs5RGwrQi95N0FKWDZoRWxOWi81bGRSeGErY2ViLzQwNkZBSVpMUWFt?=
 =?utf-8?B?dVRjaHZLVnRoTnlhZTR6Y0VNMmV5aU5LRS9QdWdaUWFneE9icU52b05Wd1Qr?=
 =?utf-8?B?UnlNSC80c1Bjc283NktuOHlVeDVVNHc5TEgyWkkyODZtZjFjR3ZMemVkZkZC?=
 =?utf-8?B?Znh2QjRROWRHclJXRWVtUHJjakpEREovL0xoZzhSYUM3Qlhkc2FORVByeUZB?=
 =?utf-8?B?bnVlYVU3b2Vad3QyRkIvVGtWZk9ScmZ1RVZQYisrZkZ5SDhPUTRZY2k0Z3Vo?=
 =?utf-8?B?b2xOWXRvODFqMTFBWnRwTWljdE44S1RoeURZYWtYUThiVXU5ZGo1SXdWSjd1?=
 =?utf-8?B?TDJYY01ON0xMTU84MElBL041ZFN2RnhBNWZnWE9JdlpGRiswR091a1hvbGpz?=
 =?utf-8?B?ei9kd1pRclBoeGJCczZJRDd4bjhSRVJWTkZHNzhjejN0T1VFbWJhTFl1dmk3?=
 =?utf-8?B?MUszVWt2Mzg5MXB3ampSNWRQbitVek1GQy9SSmF1UTdsK3ZZR0MxYVZPcHAr?=
 =?utf-8?B?ckcwUDVMQlA0NERONXBaQ2VHU1ZVZWdWQmNZdi91dmM5MWhCRlo0czlHYzJs?=
 =?utf-8?B?MTlCdXFpOU1PY1g0dHVJTGZCTkRuQVYwaXhjRndlQ0s2NGpGd0JzWUhVc3p3?=
 =?utf-8?B?bjNwaEdnQUg2dmVXYmdYOE9aN1FUU1RvOEpzNHhGQjBuaUM0em9WYnp4SEw1?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e46f336-9312-4599-3b8e-08dde4e46e81
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8431.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 21:06:31.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0gE3qN8+57+08DhG3+yV81bS5q9RE5aQjfENC2aPQhNhu2/4zBTiCEg5HwuJ9Ywxl7J+T76OakCnt4llLiX7WzZ6dvdgCXA4BNAgovEacQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com



On 8/26/2025 1:12 PM, Przemek Kitszel wrote:
> On 8/26/25 19:28, Pavan Kumar Linga wrote:
>> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
>> on our current generation hardware. Future hardware exposes a new set of
>> device IDs for each generation. To avoid adding a new device ID for each
>> generation and to make the driver forward and backward compatible,
>> make use of the IDPF PCI programming interface to load the driver.
>>
>> Write and read the VF_ARQBAL mailbox register to find if the current
>> device is a PF or a VF.
>>
>> PCI SIG allocated a new programming interface for the IDPF compliant
>> ethernet network controller devices. It can be found at:
>> https://members.pcisig.com/wg/PCI-SIG/document/20113
>> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
>> or any latest revisions.
>>
>> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>> ---
>>   drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
>>   drivers/net/ethernet/intel/idpf/idpf_main.c   | 73 ++++++++++++++-----
>>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 37 ++++++++++
>>   3 files changed, 94 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ 
>> ethernet/intel/idpf/idpf.h
>> index 19a248d5b124..4b8e944994cb 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf.h
>> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
>> @@ -983,6 +983,7 @@ void idpf_mbx_task(struct work_struct *work);
>>   void idpf_vc_event_task(struct work_struct *work);
>>   void idpf_dev_ops_init(struct idpf_adapter *adapter);
>>   void idpf_vf_dev_ops_init(struct idpf_adapter *adapter);
>> +int idpf_is_vf_device(struct pci_dev *pdev, u8 *is_vf);
> 
> please change it to *bool

Sure, will fix it.

> 
>>   int idpf_intr_req(struct idpf_adapter *adapter);
>>   void idpf_intr_rel(struct idpf_adapter *adapter);
>>   u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/ 
>> net/ethernet/intel/idpf/idpf_main.c
>> index 8c46481d2e1f..b161715e1168 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
>> @@ -7,11 +7,57 @@
>>   #define DRV_SUMMARY    "Intel(R) Infrastructure Data Path Function 
>> Linux Driver"
>> +#define IDPF_NETWORK_ETHERNET_PROGIF                0x01
>> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF            \
>> +    (PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
>> +
> 
> [...]
> 
>> @@ -304,6 +342,7 @@ static int idpf_probe(struct pci_dev *pdev, const 
>> struct pci_device_id *ent)
>>   static const struct pci_device_id idpf_pci_tbl[] = {
>>       { PCI_VDEVICE(INTEL, IDPF_DEV_ID_PF)},
>>       { PCI_VDEVICE(INTEL, IDPF_DEV_ID_VF)},
>> +    { PCI_DEVICE_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF, 0xffffff)},
> 
> PCI_ANY or ~0 as last param would be closer to what others use,
> in this form it looks like you avoid to be found when someone adds
> a new helper for such usage
> 

That makes sense. Will use ~0.

>>       { /* Sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(pci, idpf_pci_tbl);
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/ 
>> net/ethernet/intel/idpf/idpf_vf_dev.c
>> index 4cc58c83688c..5bf9d3ccb624 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
>> @@ -7,6 +7,43 @@
>>   #define IDPF_VF_ITR_IDX_SPACING        0x40
>> +#define IDPF_VF_TEST_VAL        0xFEED0000
>> +
>> +/**
>> + * idpf_is_vf_device - Helper to find if it is a VF device
>> + * @pdev: PCI device information struct
>> + * @is_vf: used to update VF device status
>> + *
>> + * Return: %0 on success, -%errno on failure.
>> + */
>> +int idpf_is_vf_device(struct pci_dev *pdev, u8 *is_vf)
>> +{
>> +    struct resource mbx_region;
>> +    resource_size_t mbx_start;
>> +    void __iomem *mbx_addr;
>> +    long len;
>> +
>> +    resource_set_range(&mbx_region,    VF_BASE, IDPF_VF_MBX_REGION_SZ);
>> +
>> +    mbx_start = pci_resource_start(pdev, 0) + mbx_region.start;
>> +    len = resource_size(&mbx_region);
>> +
>> +    mbx_addr = ioremap(mbx_start, len);
>> +    if (!mbx_addr)
>> +        return -EIO;
>> +
>> +    writel(IDPF_VF_TEST_VAL, mbx_addr + VF_ARQBAL - VF_BASE);
>> +
>> +    /* Force memory write to complete before reading it back */
>> +    wmb();
>> +
>> +    *is_vf = readl(mbx_addr + VF_ARQBAL - VF_BASE) == IDPF_VF_TEST_VAL;
>> +
>> +    iounmap(mbx_addr);
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * idpf_vf_ctlq_reg_init - initialize default mailbox registers
>>    * @adapter: adapter structure
> 

Thanks,
Pavan

