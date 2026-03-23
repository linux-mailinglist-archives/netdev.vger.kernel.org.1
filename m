Return-Path: <netdev+bounces-270630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LacI0N6wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:37:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 306452FA134
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4941305C31F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22793C661C;
	Mon, 23 Mar 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyRKwPqs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A143C73D1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286482; cv=fail; b=jUTAmU4EO4GyrkvKiZUQ3GcoTRgAjM6SwYP3TfKr9zp9+pkAzTv08coyh8P8aDXeRJ6W3H4DoeYBnl983F9vTbrZrjvW1gpopezIbN5IgjZdPtts6Lt8OgPDCXQ2GNOzJke9moNfnsyNDxabwf1xa/aRfGSO4tKTulaK4JWKN9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286482; c=relaxed/simple;
	bh=bxGqLvgWG/CAL/EjgjDw2nEEJE/52BoSRBr95vPJ5gc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KDs0fLRrFWgFQwTAjY2Le1YwioySIL9bGPP4W0CrxKsYEoJ18dqXvBaSBQkuQDUOSRE3GhXarb6yeXy5Djb4TkaVqfHKGyiXmI61I26VGxqRrXnMyq4DtJqYvOJihBY+6x5LBhXvYjq8sgb5U7P+AgjqIlPYdS2BZ5J0uMBalCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyRKwPqs; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774286481; x=1805822481;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bxGqLvgWG/CAL/EjgjDw2nEEJE/52BoSRBr95vPJ5gc=;
  b=PyRKwPqsiMdncxUOmShODG6gCC3S/cNN/L+2C+zLNeuRgACR9jt+rE58
   ENYqAvhmf7ydaT/VnQ+WJIRKuBJNQrkSxsrzIuRjKMi9y53IZF6BCpo/E
   50ksQuECCI4wFycdtTVA9BAyBi528UzIgtRr/oUt4hWdUgl1f2ePpEMsa
   uflkgqvuHRyXWR18MQK9VQSdtbWoLyEz9sqVsYVkG+kEQhu36a7S62jfL
   8iAte1ysJw5RPaoqWY415wHdqOguHHqaEzHHWqNbCr4/lVy7gff2JSYLo
   BgVAoez3r1n7ptxcJAcAQKG4Wr0xxliZsBSz/tecz21llRYVR5Xs76ApB
   g==;
X-CSE-ConnectionGUID: m11WJiR1QzeWNaYTpg0N4g==
X-CSE-MsgGUID: qNP5vEs/TvywogwqrAZVzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="62850041"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="62850041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:21:21 -0700
X-CSE-ConnectionGUID: q845Pu57S/qQlREHb7/iZw==
X-CSE-MsgGUID: py9p3vOKQLGYRGAo+pmOmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224099040"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:21:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:21:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:21:20 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:21:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAhOwJvWSeFX0ROqQKdAcUg40sYQJpXSDhS2ChVUMTK46S4FUlvQIu5IalmjQ2ukYT4E08zhoxqyKTCAu+XcmUH5uxSKkSHuc29nzf8PHsJj+cyvDWJgkcjMPqc0iqmAQ90A1A/2P/Riw7ZItDhHCcpcwrMg6VyZU324wQmihWrpjF6DTBvHp4dwQIFCZy15Sk+6gS+xTP9+OWTtW8sJuKtXfPZVzrojjkjTLz6q7nGdt27Xc8F5HaRYFKCOGMamQD/AWScl4m2QwAe0VvXyxtJPJ/GyrgPiFiQKyZwuqqA9FUBSxdw8bMQ7v+aKp6rOUK18PqaM2g4hW+iE6l/qXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro+jzwclxYFtvk9NqwyrygsiaxJJ1oXbjo7TEHdhQvg=;
 b=aR6xvwsfsrDzETKew04iR+ccOnuylehSmn4oxHvw+GwRwBU3qZ9hGS5+p9Qd4chw02w3qzkPBAwnpL10M4ODujl2fwUBF1sKR7T2bafY7PjWL4PhhJ93NNGp0DhDrDa/LpmGVZqQbMlEixD0O+ZWCTMABeyznAnV6xZgDnYf0umWHDNk9E/PMjohWdDcDe3+pSMuhMCY3WD/YBtyma/rCloTZK62S+vXa7u2KH+TwlUziDx8Ect9+w8YG5TtrSDs5S26IK4YQbUihPjwYlnXf/cd+Cx/IbpsNK4USVbw3PQXHimEvYiHVcxY0UdlF5FGPrecVNlrULtdY9aCIIyg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:21:17 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 17:21:17 +0000
Message-ID: <6187bbef-15ef-4cfc-82e1-d3de79ff65db@intel.com>
Date: Mon, 23 Mar 2026 19:21:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/2] igc: set RX hardware
 timestamps in igc_build_skb()
To: Kohei Enju <kohei@enjuk.jp>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<dima.ruinskiy@intel.com>, <kohei.enju@gmail.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260317062205.39406-2-kohei@enjuk.jp>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260317062205.39406-2-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 917ce0f1-62ae-4967-2fd2-08de89009785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: VPqDOcXLI5nlJS8EiImYzh1JBVnR9mJy7JFKiqCKhp8uCO6Ng1e1a4aW0eAw8EqSRT5/5uYwwZgX3ruAxAYH5XyKdLrJqxey5wEkKrqyKiwVHylMgnJ3e0zk1Ene/7AaDpOoE75HsaHoos9a542TRTbzlDrYFW3PitM/NW6WTV9QFjg/gMZMdwuWd+QPPVGnvY+43Jb6L0RphV2HNPaBuz4Y7am7nUGUhlPGFzrPYKu/6/g5lJJRjSTL0uv6iDrNXmCCHfYfc257cGPnhCpdZJIOiUu8XoA2g6CEQcGc8zGhU1l6XJ0q5eDFcxjvuf5rBMPIp05HLtW5dCDYW579xzPXl5q/TqppUq084T+YnR+qtDCY5NROwPFPEcrUt595fnR84WfMXiSK9pmqD5hlKLExb8xTg+HzHA7Ql7f+eZl+udVf0Q0xwClIyQ46Rb/XWpbpZyZaEZ8+Fh2ONEiDxqx+wC1Z5tZOM6cn+7mlilZadmfJ3q8O5AMMymUtGJgkE17DYhx8KXYX9EVhodjDPqmuDrLTQEKdOF1Rb+oqLDmfchKfmg/64tPJ5/cHH/s8Q498+lQ4kTFUS75XDJ1EvrHBiAowibB0Vls20ddbJCguFvAqGheX5HIYtNHtG1nhYHP5+IAKbD80fmI5eFYTuG1iM85+cggKwIPESlAga2s2ROhXOtYtoD84/A2cVtyhbVxgZwncCGc0DJd1tDeaeYlY/D0tjum9a81WOrFnmGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(7053199007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BSRDRlSHMwbTNCdE8xUTRUUGVPWEtlWWp6enBvWmNPd21UNnlvSXhnS3dl?=
 =?utf-8?B?eUhZODNUZ0dUOEVSMmJ3R2NXM21IeDRacHhKd094dzhxWm14eEJzdnZTSVZ6?=
 =?utf-8?B?dkNNVEZOekFqQlgvQ25MR2RRbGkwOFp5cGhUM0YxblBUVzZrRTdpbE1lL2Nu?=
 =?utf-8?B?NE9mZXpPMzBpYk90dEVYSE1xSFVOUUkrS05acmp4MzdqQ1ZXYXJrRHNrWkZR?=
 =?utf-8?B?b3hsbDc2MkVNdXdYY0xyeldOb1lUcklZQ3hVSVdBK2NPSmR0djRYQWl2SFZR?=
 =?utf-8?B?TGZJRndGNzRYVkowUjM3STZnL1FwTmNZTVFrMXkwZ0svTFJBdGtDUmVVZE9L?=
 =?utf-8?B?N3pLSDRSeGxXMlQ4VjROV1ZVVFlGZG5NWXVLYkVyYis4QU9xRWV2K3N0SURC?=
 =?utf-8?B?Y3M5clJtd3JDN2R3YWNhQ1hSbUg5d1lYYVd2RmozazJiUXMrRE9GQmZ0RERr?=
 =?utf-8?B?UUE0NkhpZzlXYjRxalBZT0kxckYvaHN5eTNCYmczUGQ4Z1JxT2k2TDAwZHh5?=
 =?utf-8?B?M0IvVzdTcC9jSnN1S3R2VHdOZ01aSCtQa2VtQjJFdjE3UytrVmx4aWxJQmNC?=
 =?utf-8?B?NitDZU13eUhVcmxhL0w1V0w3a1dyNHpGZVlyL2FRTkwwL0N2dUpPbzNJeHRD?=
 =?utf-8?B?QmtrR1dvV2JRakcwVWtyeW9jMDZ4UC9oR3FRbzRJb3ZoU3pvYXhlWFA5UzMz?=
 =?utf-8?B?NTZpTU5KU0lad00yYUFibUdvRTRlWDlhZENxV1dxKzFqenc3ZnRLaVRSOFNk?=
 =?utf-8?B?M0JZUEtQQ1RMc2dWczIrVm9EYlVMb1UwNHpXMTMwT0RVcURqekFHWXNQekZz?=
 =?utf-8?B?ZncvSHpNYXN4VC9UbXc1Qjc1bmo2MTVTbktlY3lQUnUxZGpRV2ZtOHBxSlFG?=
 =?utf-8?B?R3I1SlprRlhYV3dJSnZ2dVBiTFZJTE50VTlGQlFrL0xyY2VlVVpTVE9kMmF5?=
 =?utf-8?B?VktKaDlpOGpHa1YwcTVuaCtPa09zU1hXV3cxM0hJQzhBa3o4cVhJTVJRVjlC?=
 =?utf-8?B?aFduT3pTWnVTMG42WE9LOUV4VllVaHkvS0dhNStRMEE3d1ZhYVJtVjJWT3p5?=
 =?utf-8?B?VGRNK2lYSzR4aVdpT1dDWURDV2tiNHpBRXFvTUJLSXBBblhseEhWSUhCRUcx?=
 =?utf-8?B?aWt6eFBheHN3OHdxVG1zVDFDUDEzdGpZYnF0Q3dvQzFBeWthbXdpR2ZVeU1Z?=
 =?utf-8?B?SzM4NkNTTG5BV0FjT08yMTIxbDlrTjFJaXUrb1FMMDR5dWtGRk9lN2QvVExu?=
 =?utf-8?B?cDM3MStGQUp2Y3JtNndLL1p1TnpMdTAwNHVyL3JVMmJ2bGMyYnJSVzBmeWZn?=
 =?utf-8?B?cW04WWg5a2l2VEFqSmFRbWRHU2pkQmQzdHRTdk5rY3JmZmNnRjd4Y1poc1NO?=
 =?utf-8?B?SWZpeFUxekpBRTVqRHJtekhNZGdHV3JGMkVleDFCWVBVenVHdWo5cEQ0RG9m?=
 =?utf-8?B?MjFpOVhoRHJ6MWRNYkdYSDQ5ZnZJK3BBRkJTYmxhRG5GdkF1eFlOTXdHenRh?=
 =?utf-8?B?OVNvVDZ1dkZEVy9RcXVwOXBJdFZwRGNOUE9TajNHUTJ4VTkrTWV6UEhNUmgy?=
 =?utf-8?B?QkpOV283KzgvRVh2UWFNV1dDL3pMeDEwUjQ2TVBrd09UMFlqWW1UUEQ0WkNB?=
 =?utf-8?B?UzhidG43YkFjUmtubERVZjI4VDc4VTN5dzJwQzF3NEt3NjZ1STBhMmM5UFBV?=
 =?utf-8?B?NHp0SDF5RDlNdy9CUDRUMytZQjFKbEFiRzJBVzJpT0hQc3pWSmNYdEpKL2h5?=
 =?utf-8?B?NVZMd29lTlVhSkpYZmJUenVqOGZtcW9nZkgwQjRGWTBjNWVGSGtaNm5YaGFv?=
 =?utf-8?B?NlFyMFB4Um9iK1AyVW1LZnVSVWhXZ1hDSUUreUlScFZSeEY0MTcrdXMyekln?=
 =?utf-8?B?ckt6RU95QUlPSkdJNUlGZzF6bWZpT2JZMFR0OGZoREZlekxCUzdRamNqS2Qx?=
 =?utf-8?B?S2NpZDZoamZFcUhZV2djUG1iTXZkSzg0T0hmZ1VsNGE2cVFTTU5QZUx0dVAv?=
 =?utf-8?B?UENwRk1qNXp4K0EwTTNCY2lRSzQ1VHNHcUlNOUZuMmpnaFZ0T3ZvWnl0T0sz?=
 =?utf-8?B?ZFhyNFVxVEhtT0ViZ3FOYjFxMytnTFBUWFNSSmJxcTdoaklOei9tYXB2WUIr?=
 =?utf-8?B?Z29tQWZMWGVNd3NXS201NHczNVNrZmhoZVI5V2NQU21JUFB2cXVZTURQQ1A4?=
 =?utf-8?B?dFlYeWNlSXpUdEZLR3ZTYjV2Qm5idWRORzZNSVNYcmJxb09wcFpyZ3B1RGsy?=
 =?utf-8?B?a2xHay8zZ2szOTkvbEdSWmt6b1RONC9Kc0dmaWdtOVNSanFqTksvUER3aVA2?=
 =?utf-8?B?dFZPamYwdlhxTStVclBuYnhYS3lDZGFjZm9lcUJlOUVraUJRVUo2Mm9oZGtZ?=
 =?utf-8?Q?87TwPybyslCVfjL8=3D?=
X-Exchange-RoutingPolicyChecked: vu59+j53vsG84RKDMyafy79R9J5uDL0sYcepzsHFaulAx09Y2iabkWVJhfw/NehB3IlAeVZSulrrUJQi29qY2RCgXeLFVVN22DnM7sndbgDnhA9IXZ4HfTMQJK7JsV6waVSasbtyi13FmqOy4qRuNcLBJjBIoQfW9ahMshf7uk3hkKD7acOVYkgkumNQRSfGJD9c1ScW9j9Ln8/YVET6E8cp3fX7tL+L/7vvcOS4cCUQ9ovLr42iVHZm/bGFGLmU1xORNKLQJyp7idVVJAmnkftPS844Sj/Bal4VmRguydd35w6pvByZmkrsBB03vXSIhUfd+EUiuEXBZN2gBHin9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 917ce0f1-62ae-4967-2fd2-08de89009785
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:21:17.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q5+s3EZNBUZOOzHdK14qZm9gZKuF5gH+maDu8kseyHY0nn/JNmCKffPrkbaLv03zV3yfMJ4zCe5GlY87c/Z6aBMXHyJAYEDm1+VbDCvzwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270630-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 306452FA134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17/03/2026 8:21, Kohei Enju wrote:
> igc_construct_skb() sets RX hardware timestamps, but igc_build_skb()
> does not. This has not been observable so far since igc currently does
> not enable the build_skb RX path.
> 
> Set RX hardware timestamps in igc_build_skb() as well so that both skb
> construction paths provide the same behavior.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

