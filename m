Return-Path: <netdev+bounces-229703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5FBE0009
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25C74F9C51
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF21230103C;
	Wed, 15 Oct 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSkw4Flv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18734BA42;
	Wed, 15 Oct 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551664; cv=fail; b=ePwzKo+v4SlK0/uieSkjnnW2fi2AFH70uODIBiJUJ8YOBifq/V887i++kwiOkGKuOaamk2vML5Di3Fo9IspEfrYYSZe6e1ybSX3MaU8ygbz1cOgL/3Ze6xI+tER7fycm2w6zjiclLdamZeTThldiPQwPclyHc7YJApOziiMzpjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551664; c=relaxed/simple;
	bh=sxlhlX1tVkB7l5jfM8Bm/GvofcO49x3o49FOXxFMl00=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKsi6LNHGjDcwOyai9d0PCzjCLs3UZOHf1Agxo2dtZ6YeJBKjG/YNSJxlZUzMhp0F1yWgAqe4guTwrM7eWGHZtPMq9YHaawGJkMHQ2hv8OWyuDMBDnq5nsN6zvW1Dq8UFuVJOlLQU5eo2a4ok9iwdtRX9jrKIiGFsPF09trW7UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSkw4Flv; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760551663; x=1792087663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=sxlhlX1tVkB7l5jfM8Bm/GvofcO49x3o49FOXxFMl00=;
  b=bSkw4FlvFmWXZj8CXIprmnQq5S81xqj5JFmYTCRnLS4eo9PiRyI4d8wf
   ezxo2YXr1b0CsiYwrcqPDUQKueGIaFs0UE9gX8L7jecrRTWVLecXA3vCC
   Hr/b1DNlwGRZ14BoAUS0k70O3VehOScZyzOx5VLhClKey9/0quvYhSphM
   InjKYj1yWeSjqB4YiUgNZP63QTlpSedtTdFOGaWm1vaVvnbe4kzYYlz0n
   SAQkRfc09CHXKPtKegb3I2HcBklYuzu+9Zo9W7rPWtkyP8CKHKPUbe0fP
   Hk1ejrv//1frxjp+uD5xrtbIrsdu3/FpEcDC3YTDNnIQ/KSf9xOfowRkm
   Q==;
X-CSE-ConnectionGUID: X86DOUIBQaGf7yYWXrVYgA==
X-CSE-MsgGUID: S4c0kGoZSw210qBNsaWL6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62665226"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62665226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 11:07:42 -0700
X-CSE-ConnectionGUID: a3La8yFLRBKCqEpL8kDTNA==
X-CSE-MsgGUID: 6nU5Qu4NTwiJQ8UZJf2CQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="182649816"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 11:07:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 11:07:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 11:07:41 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.70)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 11:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJpxFdKRWXVc/8b+Ed/r4cWlT2RF14V38yXNNvYErk+rIDxgFk0xsFkwH8nSepIeia2GP+07GxRBt6sZC5QSRuXqrDVqSGzSkJFJYtJTDFjgOybB68ZmNbJqlGgBLJnlgO+YXDoSrQ1ZHs6tDjobqnSEIa4UicD/Q9wLrHpqZnBH5iLzcdSJ556iGBDyFsA9pqeClPRNAx52AR7bx+MCeO3MLD/hMcsTNzMIWz7umn4ah14QU2RDYdv4BMejgv7HiZN3YlDzWPt0aIRFIi3UzG9IfqRhU/KjNsEBELtlaFH2oC+jaoPRPBCesoOXp0ldHospwnAAw7hs8e+xZ9wkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxlhlX1tVkB7l5jfM8Bm/GvofcO49x3o49FOXxFMl00=;
 b=utvnTiOHGJ5h6f296YSGQmmx+PQNn5tA1Ow6MnbHqXpIRmbRa1yHh4WyEKOyUPZiMXfYJyDK1XDSiZtBwgO/5CE4h1UGQrL0eLu3ewEp5WPE4JVyklc869ZeaNUcaoqD9IEhrnSl3lzK67RfYNQlyNlptZG+rdpidoEQFRgnWzaZUXZax3KAuGJihu+6G/LBl2q90cR+BTgcD4sLi5Qa3ScR5Vrne93lgIep17dSIit9BGOMO7ARGBbu7OzZ9ciHp7hJiINU4loQVyz4j84k6fD2aQv2zvTKo33HlzUfcar+Ckv4/IQmLAm5V9Q7m1mBJh12UdqqkF+vAtsjSgXS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPF68472F2DC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 18:07:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 18:07:34 +0000
Message-ID: <efd3bfa7-d336-4a55-a185-055174e9b4e0@intel.com>
Date: Wed, 15 Oct 2025 11:07:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: cxgb4/ch_ipsec: fix potential use-after-free
 in ch_ipsec_xfrm_add_state() callback
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Paolo Abeni
	<pabeni@redhat.com>
CC: Zhu Yanjun <yanjun.zhu@linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>, Harsh Jain <harsh@chelsio.com>, "Atul
 Gupta" <atul.gupta@chelsio.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Ganesh Goudar <ganeshgr@chelsio.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------9wMnGby8tEmzf6DoBDRAg3mF"
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPF68472F2DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0a1e02-636a-4f5f-3472-08de0c15b743
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWpzVFZib3ppRkFOdkdJL3VXbEhyV3crQlJpZUVLWGZCMmdOdks0dGZ2U1ZK?=
 =?utf-8?B?ZVJGMEpKZmdab2VxRlk2aTdFY0U2Qld3cHRQRGwxblJ5Nks5bjU5dUFDVW1o?=
 =?utf-8?B?Y1VodU54c0FEYVNYN3hvQ3JZME9mQmhxNWg1N0pKZks4UGdGVXlKRXpjdWtv?=
 =?utf-8?B?VzR6bCs5aHhjSFFMa2FmNlEyZnBHQ2RwVkpma0tzM05uc0dUcUpBbDRTMU9X?=
 =?utf-8?B?c2JENmJsRnU5amtDWldsRVhYa0ViU01JVHU0a2M2MTBPZDM4S1VtcWtSd08r?=
 =?utf-8?B?UXY2TGpYVldhSGRuVEJMK0REZWFtaVEwQlIvOHJNU0U3WGVKM1ZHSEZsRlZR?=
 =?utf-8?B?bWlpaDV4dm5pbzhmS2p3S2I3UThnUGQvUVRLVXB0ZW9KSjBCTmZoWmdjUGpt?=
 =?utf-8?B?ZkNtbWtCdEp1L0JzeGtOVytiYlFjL3dtWHpxb0hRUW9PZFVjNFZqSUx4cWR6?=
 =?utf-8?B?TGlZd2dvTUJQaU1Md0l0ZFh6WklySnlTWFR6bmNkV3V2ZzNJTTJyeWNZL3VM?=
 =?utf-8?B?RlhoZ2w0T2V2Sk5IcXZnYzFGaE00L3BIZE9JUHBvVVljY3VFNnJuZis4K2JN?=
 =?utf-8?B?YllDbGdoMEVQaDErc1RZMGRiR2daTG5rdXNuNTN1cWZLdEljai9aV05RMnNw?=
 =?utf-8?B?RTZ4ZlJtQlRBdjA1aGdUd2NrVkJhdGZ5VTR5TVJWR09DdDkxNkdMWWdRYUpr?=
 =?utf-8?B?bnBJRUhGLytMZ21iU1pEa3kxZXhpWGhHVjBva1pMZnFyN01COEVuTS9UWG1C?=
 =?utf-8?B?UUNjbnBkdTFHbFFQODVHd1ZZaDVqZmtNWG0zYjJYNFF6YVZqK09qNDlPaXk1?=
 =?utf-8?B?L01EU3dSL0JNd1U0VUUxWHE3RUdzdXRESStVSEVIL2k4V3pOYmd1aUx2eC9t?=
 =?utf-8?B?ZnRGUXk1ejZnTVhlUVdMdTBMbVFhYWxMcU5yeUIya0ZsNUtja1V0SWRWOTJE?=
 =?utf-8?B?dlFpWGUveXd0MEZHYmhQdjdTa25VcWlFMG9JUnpHZ3dkVDYrOUhsdkxFUWxw?=
 =?utf-8?B?anFBWUZER0hxU2xqWURkSVlwMGpnbWk1bURYaHpYbUxwOExpU01MTVBWMmpE?=
 =?utf-8?B?eXpGT3RzU2tlTk1BMUxPUUN0KzNOSWQ4M1l5OENVcG1PQ2FHVnNGbk5zWmUx?=
 =?utf-8?B?QjQ4RUo4RytCUndSV3VnbVljcFo2anVuTWhIVWFDUCtva0lQaTZMd1JFclNG?=
 =?utf-8?B?b2JxWGpxd1VSUmU2L2pWRmJyNG5DZldXb2Y1NXVVVjBRanBnZXdJZTNia08r?=
 =?utf-8?B?YWJoZDF6cXlTQmxaRm52eHpQUVhqaldTMXRGSFFXN1dNV214TEM1a0VSdW5h?=
 =?utf-8?B?RGJ1ZndBZUNrRXRUbVN3Ty9wVHBFNllRaTdPUUFDb1QyUG03V2FweTZLQldr?=
 =?utf-8?B?anUxdzJSWFFCaHZvSlR3SFJMakIyOEs0cDZGcThoQUppTTFhdFdPa3RiSUU2?=
 =?utf-8?B?UExRK2pGUXo1azlyZG1IVDVuNlRFazdXU0sxVmZJQ09qSmIxM0Q0N3gxUlg5?=
 =?utf-8?B?ZE5qYzI0eW1NNkZKZFBpeWNCbkhsMTZ2WTkzWnc1bmN0RHQydmV4T0RKeFhE?=
 =?utf-8?B?UTM4Mk93Ti9iRGttcnk2eWJYajBicFBVVkVsa2FFTWJCSVNkMk4vZk0vQUdM?=
 =?utf-8?B?YitERUxIanJPSHg2clQ2TmQrYzhWU2dFeWx4Q0Z5Nk40MjF2Y2dmNk1pd29B?=
 =?utf-8?B?R3hvTkZUYlpraTl2RnhET1B0VS9jdE1lSzJjaVNldVNieUgveHJsTUh6UjM2?=
 =?utf-8?B?TFpXVnBObGFlU0FjelVoMUJXT1RsQzVOYTV5SVM0cUxhRVVCd3lhaVhTM3VX?=
 =?utf-8?B?b3J3NHFrSTFuRXcyOS81WnNnSlNNN1NuNGRlYUNGeERNYktaZ3BGMmZlZFVP?=
 =?utf-8?B?ejBuMStYb0Q5VlVhQktCS1l5QnBXOTFLelNHZnc1SHA3MlRSTFl5Ri9GQ3FS?=
 =?utf-8?Q?tT5v4WP/uIzyC6kRKXCzLjvwlVxUYxpG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUhaQWxQUUFXNW4rWU81bkJyUGZ3ZndNbWNzalJGMDlWaFNGbVlaVk9qRHFQ?=
 =?utf-8?B?MHBEMnhPNHBYYS9EeGlCdnl6R2FUWTJZSGRQMUloWXBUZmtEc2MvQm51MjRM?=
 =?utf-8?B?TUt6UFZRdjBhdGZONndnaTE0Z3ZLZFlWbHpKdjN1a1V5ODhLNm1lYm5lNUdo?=
 =?utf-8?B?REVkSFhGdmttTVpvSVE1SmNFVVR1NkxHZGJQajRPRng1V3B3bGxicHcvS1ow?=
 =?utf-8?B?ZGxiRzVXeXVhU0hkQndQbnVERm1iZ0h3eHNCNkY0K3BjQ0dod1krMFpmbUhz?=
 =?utf-8?B?VGdVSmJMMjAyWmYxZnpxYnpDcTY0aTYweVdWbDFEbDJEK05GR2FFYmk2YktD?=
 =?utf-8?B?b1Iva2Vha00rRkJHTlBvaE40bnJqcXZIeDlFZHVyTUJ5S0VrNFhHTXl0QTNa?=
 =?utf-8?B?KytrWHpIVlZZbEMyWkl6aUZHcFc1N29ScklHWC9YQkVZbE9mUHJCU1NFL212?=
 =?utf-8?B?czdkQTF4YW8wRXA5WmFrOC94YnhZamRLenJLQWNrNTRkVml4THBudzNZcmZV?=
 =?utf-8?B?VTdDdGhXcVAwS2dVZ0dteFNScWtoREZLcG9wUUgreWt0bkVXRVRrY09sUjBH?=
 =?utf-8?B?OTgwakhQK1JUZVU3MzFmTXg1QmRjNy81RnZHVllkblk2M0hqYU9kVEtWZzV1?=
 =?utf-8?B?MzlaK1dsSFE2dnVSOGVoQ3ZNdTFzUzIrY0NTQVZEQ1d2WWpmZ0pyMG9rbHY4?=
 =?utf-8?B?NklXbnoraVhNVHlJWDI4S0FkMTQ0SW9TRUpLSlFIeVBKR0tSdW8rajA4bzhl?=
 =?utf-8?B?NDdkeUo4T1dsRG5rdDF1L05hbFRFT2dXR0JsWXFoTFV4eU1lY1BraE9vRnd5?=
 =?utf-8?B?cGF4RXVRNVQyd0dDcFc0S0VNL3VNN2FnYStCUk9WclNwMjFRY05DNGdESDR1?=
 =?utf-8?B?aEZpN1ZmL01zeHRmaU05TC82MVhLSlhtbHVXc1JFOFJneXNGVTJRallFNW5I?=
 =?utf-8?B?UHRBaVhkTHQ5Y0hraVlvQ003T2J5K2p4NmZkUS8wZlVDL2N6WXNoYWhValJP?=
 =?utf-8?B?UmhZb0htWjF4YjFlS3lhTWNxNmNEaEROTmsxVGtlMFpSbEZRNHFWTFlSOFVP?=
 =?utf-8?B?R0xPMGp2SnN2STdGTS93WVBCSUt4N0lQMXI4K3Q3ekNQaFhwazc3aFVEY25k?=
 =?utf-8?B?SGZ4MkllQ0tRclY0ZzQzSDRYYzVJVGVoazNIN2luQmw1dDQ0VXZSV0w3b2cz?=
 =?utf-8?B?cFY4TFNoWHZpMFNxdjl6OHduVkNuSmVMM2NvNSt0WFpYUlZpb2h5WFdYTGRO?=
 =?utf-8?B?bG5FNXppUUdYVmlEZ3B0UG1vc2NCU3VSK3NJbVpzdDFwT1VCVWcxNVNMSWcz?=
 =?utf-8?B?Z29RT2Y4bmZwSkhyazZkU3FNVDh5WHU4eWZEMzR4MjZTcjlrYksvTmlBQzY2?=
 =?utf-8?B?cmVtSWRtNk4xQVI0RHROQSt6eTQ3aXlvaS8yNmF6cVJ3K1ZKQ0lDUEpBRkdm?=
 =?utf-8?B?V1FLSUdWdDhONVoyN3lWcDYyMllZSWwzS2xwZFhZSG5KOXpOTTVXR1hwTHRz?=
 =?utf-8?B?NWxUODZVVmRjYXBodjBSS1p2NFZueTdZaU9GSHhCc2Rzbzl4R1JmYlgwSUNM?=
 =?utf-8?B?N1lsRjhBOS83TmRxNVhUSEl1TmxWVGIwdWhrQUxnSlBVcm41WldITmNrUitx?=
 =?utf-8?B?emNOMHF6cTNQOVpSYlpaN3ZmS0pXaldaVHl6Nm0weERmOEg5S0RmbzV1OWZu?=
 =?utf-8?B?S0NPdG9WUm9VUjBGeWtiMXFqTUpkNVVGTXNaTkRSTnBhVUMyRmJDODNINXlz?=
 =?utf-8?B?dUc3SWc5WkF2b2hhT1U3cElQRTl4cHlGR2h3R250bkQ4Ryt0WjQ3Y0ZHM1RX?=
 =?utf-8?B?Ritoc2pkdE4zc0VMblB6WXpLakJId21ac0dHR0pROEhmaDIwOVN0SW5lMjVM?=
 =?utf-8?B?TDdVT3RacG9CcHJBNUtZUmwxVDc1NWNZNS9xTEtXSVlweFF2Qm41WTI3WEZ4?=
 =?utf-8?B?N0xFdmZYamRiNFpyLzVvQmY4azRFRmUydStvM21UTGNQTWh3T3FuanpoTkRt?=
 =?utf-8?B?cE5sQVBXZmFZNkl3M3J6ckVOeFJTN3p4U25qaGZXWStXbXJIRWNWNjF3L0w4?=
 =?utf-8?B?KzZZWXRMTXQvandxNXJNOG1vN0hQd0FWS2J5c21PaG4rbkdGV0dRemt3bUUr?=
 =?utf-8?B?anI4eGpOQy92RDltY1hwSTRJT0RtdXhseXdaMmNBR1BCNHN1ckgzWnhqQ0R2?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a1e02-636a-4f5f-3472-08de0c15b743
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 18:07:34.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7PA9O5HglYglPd1vBOHenCL4TSQQ47KdhWxwar677ooSDXm61HDb5SWSFbjaG7BUNnxF8v19ln6duE64rpNeFfUY+zB4OSI8EvHnTHp13k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF68472F2DC
X-OriginatorOrg: intel.com

--------------9wMnGby8tEmzf6DoBDRAg3mF
Content-Type: multipart/mixed; boundary="------------yaViHN1z0lTcF3y0A0jNc0eX";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Harsh Jain <harsh@chelsio.com>, Atul Gupta <atul.gupta@chelsio.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ganesh Goudar <ganeshgr@chelsio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Message-ID: <efd3bfa7-d336-4a55-a185-055174e9b4e0@intel.com>
Subject: Re: [PATCH net v3] net: cxgb4/ch_ipsec: fix potential use-after-free
 in ch_ipsec_xfrm_add_state() callback
References: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>
In-Reply-To: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>

--------------yaViHN1z0lTcF3y0A0jNc0eX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/13/2025 2:58 AM, Pavel Zhigulin wrote:
> In ch_ipsec_xfrm_add_state() there is not check of try_module_get
> return value. It is very unlikely, but try_module_get() could return
> false value, which could cause use-after-free error.
> Conditions: The module count must be zero, and a module unload in
> progress. The thread doing the unload is blocked somewhere.
> Another thread makes a callback into the module for some request
> that (for instance) would need to create a kernel thread.
> It tries to get a reference for the thread.
> So try_module_get(THIS_MODULE) is the right call - and will fail here.
>=20
> This fix adds checking the result of try_module_get call
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 6dad4e8ab3ec ("chcr: Add support for Inline IPSec")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------yaViHN1z0lTcF3y0A0jNc0eX--

--------------9wMnGby8tEmzf6DoBDRAg3mF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO/i5AUDAAAAAAAKCRBqll0+bw8o6K4M
AQCECijHqZEkZJ1c13SDoWyAk4+rbjFy4Q8eIx2g0zPoLQEAq2hHunEGn4YQOBx82jmXEFfClZGy
fyWwTdc1+d59LQk=
=Daxd
-----END PGP SIGNATURE-----

--------------9wMnGby8tEmzf6DoBDRAg3mF--

