Return-Path: <netdev+bounces-243488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC07CA211A
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 01:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791063019B50
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245F1D130E;
	Thu,  4 Dec 2025 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3FSG3iv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148FA55
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809527; cv=fail; b=mSRaKOLjRA+1fIBc3b6V5u4ozyP0YNcQ0KSdzHGdevzdIXrvEH0PO2Lu3pDGJig7Vl6ZTnZPXB+rgvfPj3hha2ECAhQxzh0/OavHqiONESxjADYtgYHXLSWnznSP+r2JET3EWT2EQORH/lcAGLP1ttA5hPg+wMpQ1sCSHe2LXDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809527; c=relaxed/simple;
	bh=C6bIU4Zb/FYf6yGZO2EgHO9X0rdgc3U8Diu0Wn1Odhw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l6lV3Oug0IGif8WXt4BftLM7MIdB3Bnjboq6FkmxYvIjeDQBG5odiOKCd7Rcw/0WMQjP8zwBlAbyZ4kli47QRLz+oweVsNH+tAEtR5wqpQ7IgzOJk+h7MyGZ1rmAvjyU0eEO2Q3BYYakD8oDZuaoiXIncFBAdAJRXd2PEmYzf8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3FSG3iv; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764809527; x=1796345527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=C6bIU4Zb/FYf6yGZO2EgHO9X0rdgc3U8Diu0Wn1Odhw=;
  b=U3FSG3ivweqHLOgMzU0eEjY9Ctf8wqQtvra89VC8MqtfiL7S7fkuh0GZ
   D6um3Kw0vmZ4phyM4Y/ajMKTCUZY2Ee6WdIFBoIWLrxZqJTPoTJgaST14
   3SZw28zpQR6usgBQcApynOl+n2pmDpYo+sSP4Mvq3lYeRgk/ecP+nLeK9
   hLUP7QJ6tkvlN13BQIuyA90N/nDrc+Tdgo+fEkzuNX50yzzO4j4RqoNsz
   1kkMhFqo0t2bfgw+pdcYXM5NfPsuGOsh/iozsWNOG77pgZ1EfkwVBcOqk
   s8nI4KHIJjCjIqP3a3LZSGkG8ZD1OYimeq0ZyQZ225cdv9ziSaeXs3/O1
   A==;
X-CSE-ConnectionGUID: zLbbNCbCQF+Qiqf/dw/ZpQ==
X-CSE-MsgGUID: 4XSVppfvQeSkzAB2ZZiajw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66010544"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="66010544"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:52:05 -0800
X-CSE-ConnectionGUID: FupF+JaZTDSeCcPPbA2UvA==
X-CSE-MsgGUID: qnAOY8WbSPqCGqMZyODH9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="199010697"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:52:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:52:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:52:03 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:52:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX3YImZclTw4UC00zDx7TGqoMAMy+yLgYb8bHa6fj9Ji0uwiRk1IWEKqpLtZrB41uBvFOfo5fhCzDKU9+CDrIS6eELiP+kIeflAjiza76PYJq/B/tUALhY4A4BTLDuKdL/nJLx3ZAjuJqU6oDsEPFR/RxDtiPaZHAz4IGBxqGkseyfVeFImV7aRHDW9IHQ52ePcRCO19TNOJnqIzMS8oPjdqttGySOAiFq15zhgHUViK1xjWYdZ4I34s4wSLOBFkGCIk9OaoD9uc99EnpbmH/s7hNa9faSzd6Rbq8v8nJ8A1vgthJUF8bLdR0QaB4G5RtoCXL25Ak+X2uwWg/IcH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6bIU4Zb/FYf6yGZO2EgHO9X0rdgc3U8Diu0Wn1Odhw=;
 b=y6w7fahE+v16WUR0pCoUr/0kepluZgzwCnPmh55YmHFQW5h28156czFQpLVGoeOaFwPw2HtogXdRQp0zubsd2gGbaf7bD/ZD8qmjmzq/C78AsGkeUcfSYRLhC2qLaag9c+CvxDDaaDH5vHSTThceL78YieJjXtBxQr9fw6BZP1hV+G3ocHQe9UsGpHxG/n4rtwCea/3HxsO8U7U3nJOolG86jvfBk/UeUJWFcrdNnITElUquhd5CgeoOUFISYyD1w/M2TidDXaDnk4FxrCH8V4IPIJU07mX+aM3UwIZ/pZoGHvrTKVNmz65V34q6b8E233PoZxZd2XHW1ct6xlmVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 00:52:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:52:01 +0000
Message-ID: <60b8ac3f-cad4-4aa7-bcf1-230f2067cc77@intel.com>
Date: Wed, 3 Dec 2025 16:51:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Heiko Stuebner <heiko@sntech.de>, "Jakub
 Kicinski" <kuba@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <aS3F36UAkeLfFeHx@shell.armlinux.org.uk>
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
In-Reply-To: <aS3F36UAkeLfFeHx@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------DHT564ugK3OFEEC029osstUC"
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d88630-f4e1-45e4-48b4-08de32cf5597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlVlcEZRR3ZBUDB4enFKeFN3ellzNDdCa054WWwrNjVTQnhCS3V6Nm5yNWpq?=
 =?utf-8?B?Z04rdmhGQ29lYnhEWDdWNUowbzhpUUx2NHl0RHVjT3R6NlRwZkMxU1M3cjdj?=
 =?utf-8?B?cmFBcmFta2FsNlIwaytjRmR0aUlFM1p6ZnRRWVJ5SGt2cGJlSExXQUMxNGkx?=
 =?utf-8?B?UW50YWtqNUlJZnEwT3RzSjdaS1RiMDdJS3hEUWw3YVF5TzNOd1RRNUNJTGV0?=
 =?utf-8?B?YXFNT3drYlJWek9hQjVzdm8rdDZ3V1RFM1F4ZXRqZW1zdFNhSzM5ZTRtY1k2?=
 =?utf-8?B?YUI3M0h4Y05RUHg4NWNwNzBkVUkrV0xROVdPL1dWUU9rY1VIWXQ0QzBOS2Za?=
 =?utf-8?B?cmVUdnYrVkdiajVOd3hTZ1RUQVlRMDNWcHlaS1FOZ3UrVWJsMEN1aDE2Wk9m?=
 =?utf-8?B?eEVOb1lzK0ZneDBwV0s3UnFWdGRTQ2txcDlmWkFLalhYZEZaYlNCNWswUnNW?=
 =?utf-8?B?YWk0M3VzZjlCVTU5WU9FbS84dDZwc0FucHhFbXd6Y2RnelNCM1pZL1RQMDZ2?=
 =?utf-8?B?dkRrT29Da2JGbmxPWjMxWGUxcUZGVkRCVnJRcGNQQy9MaCtDb0FjVUJ4V3dv?=
 =?utf-8?B?TmNlTEdvcHB6dXJjRkdKcHB2MU1icTFFb0c3OWxibGQ1WDM0alVYeHZ0YUVO?=
 =?utf-8?B?ckVhMmt6Y3lQNVBrbGVWejZrSnhnb0lQeGZ4ZGJhWDdNbkpUaVJ3SHQwOFZF?=
 =?utf-8?B?NFhnWWxwZnhIZEdBaVl3RTE0MUxrcUFDb1ExbWxiT1g3bGJFRnZjNnQ2Tklr?=
 =?utf-8?B?RkNYbUVJaHBMb1JTOUdCT3hQb3dsbXBQQ1E3ZWRYck13SisyL0tYc0pZdzZQ?=
 =?utf-8?B?UUZGVDFheGVSY0RQbEhlbFlNb2Y2Sk0vMDUyeXBtTnUxRjJMcCttYnpJWUpJ?=
 =?utf-8?B?MS9XNFBKVHlkQmJ6dnEvNVVqVEwrR1F2YkhxMkhyemFMR1ZheUt6MWZLQVBG?=
 =?utf-8?B?N3IrZmswbnYvbDFZTTdxT0RZVE5TVE9WUUtRTFhEVS9tTlREaUIzc3ltS0wx?=
 =?utf-8?B?SjZpakMxSElmcmVsUWczdEdsd2pPeWhxSnJ3YSs2amkvZ3NhamRWa1gySTNQ?=
 =?utf-8?B?QkNJNlB4Z2ttWmpRV3o4eFVtRXRBZFhabkVDRktHMnR0OXB1ajRwS1dlS25a?=
 =?utf-8?B?Y1F0Zmh5Si9PNnliUkFKSHVFeXVreXo2YkQ2MXFyNytsKzM2Sm1TaStWQjJJ?=
 =?utf-8?B?VGxJVkxaVGx0Unova1R1Wndzb3dUWW5GTFFHaU8zOHd6Nm92UEhweUsvWHBL?=
 =?utf-8?B?Yk9LTkFNU0dzVjhwOE1QMUpSRVo0YWFXRTRadHpFMGJLUk1HMWFnUzg2MnpY?=
 =?utf-8?B?R2ljalMvKzE2NXUyQUt0OC9JWHFlMUx2R28xRGRIR3F3UFNtOTZ1L3VqTnBn?=
 =?utf-8?B?alU2UmVMcDlGckZ5aDJ6V0N4RVFLUWNDTGZaWWxmTk53d3JHZEY2bS9ZaDk2?=
 =?utf-8?B?TUE2KzRudXdFVDg2RW1ER0kvaXFWNmh2N1d6a1NWTWxkQ1h1bmRDZU9RTVVU?=
 =?utf-8?B?VVZ6UktGNk45UUFtMFhTVWlpVGlXSm9vbURrME83QU5VSXhHTm56bGxDYWlC?=
 =?utf-8?B?K2N3V0JWSnRoMXF0bnI4aFNpbEZtbzA3UVhHb1lkNU5veVVlRy93SXB5bkl5?=
 =?utf-8?B?Z2tMem1WckNPb09XUXdsME4wRWY3RUc3NDBTbGx4UEVXckd3U2R2bTFBZ05i?=
 =?utf-8?B?ZFpudU5KN2NEUVlNcUNhbnZpRlNDN1U0OXBiMnJnR3lZVC9ySE50bTM2Ui9R?=
 =?utf-8?B?aXIxZnczTUlJSWoyWFE1MTgyd0pXYWVYbDFCcW5mb01FNldmVUFOZDJKZmNq?=
 =?utf-8?B?a3hzQTIvZE1ERlFxZHFWVStWTjI5ZG5kZkRZc21TaThqb25OWkNwaGhVUVpx?=
 =?utf-8?B?WlhIbm44TzBSdmlDeEtHQmcxUkNNS2tqYmwza28yTi92SVFUVmRpU0lwN3FR?=
 =?utf-8?Q?neMTilMVOQQOZpXwI5bbczc4E0FV+2Lg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnhJQmhBQ1hIUVovRkRzM25BOHNicHJMK0lMbzN6OFZ5U0hSbEswWllhOC8r?=
 =?utf-8?B?ZTY0Mnp0Y0R3WkF5cEJmZDdMUXl2bXRzQnJGYjhLNmcwZDYvOVMyR1FocW5Z?=
 =?utf-8?B?TzdVUFNDN1NTTVFMRTUrclZhTm9icmIwaGwrOGdLUmtKN1ZxajB0V1V2ZXBj?=
 =?utf-8?B?OHA3OENxcTR3ZFNaR2tZNTlIL0tUdHV3enlsNy9qWG5rQVhXcGcrME05b3JC?=
 =?utf-8?B?UHQxcXNyTlp3Q2pyaW9HWFhVTzYyaytxdEQycWgyeG0vWU95aElhdFZTTkhV?=
 =?utf-8?B?bWNjZnJIY29DOGFLc3lGaUROZUZaU2ZzeklZVWtqVjhFNTFJSkcxVFVnbE12?=
 =?utf-8?B?a0F2MXZtT2dCUnVXeTczcGR4aVRBRlZUcHVwU0V5U0plOEhXVjI2YWt1V290?=
 =?utf-8?B?L0RzZlhYOVdQNXBmTHpaSkpiVW95VFpvdVhxYnpNMEN1Y3NqTUxFL3FReFNP?=
 =?utf-8?B?SFViSndBaXNKYnB4dklFOHU2MXJORXJyOFUvaytBYmFZWHJ0dEErSnlpWm9m?=
 =?utf-8?B?VGFobnRyVmZXempCS2dyakVGUktGc3JqVU5EaElkSWQxdjBDdlRjVnFyM3BI?=
 =?utf-8?B?ODJKeUlpWVJBclE4MUE3bU04bHpaVERsU2w5RGUySWhDTHhxMU96azJJR3VZ?=
 =?utf-8?B?bzVVSkRHSVhxY0QrazBZVUx4cTFNRkt6YUdkQUVPVHFDVXNzd0N0T2laYUpi?=
 =?utf-8?B?Rlp6OHB4NU96ZitlSGRtYmNZN0V4SjJ3ZzJyTTBncWhwZ2pQS3p1NnpCODd0?=
 =?utf-8?B?VWZGdDZydG1qdEdvYkgyWlVlckh5bFpUMTNMY2pnVGRFa0xSVDFZcDF6VVFT?=
 =?utf-8?B?OWFTUER1TkVEbkpKVFhMZENudUlmTXYwWW9ZQnFBeStCekw2a2lwRUlHSXY4?=
 =?utf-8?B?cmw3ZW4xaGRFWkxLVjFiWk14M1dnT0tNbzFFdUk1OC8zOHpZVS9FZWlNZ2FO?=
 =?utf-8?B?dDNaQ0tsNlR4V05FZm01QnNvTHJ3a2Y4UW1aQmlYTFFiQnl5VTZscjJ0QU1H?=
 =?utf-8?B?aXpSQ0IvVWEzNWhPRHJyOHpJTmNOL0tuUk9uUHZMaENmRzl0UlNmOW5NYW5N?=
 =?utf-8?B?Y0ZrZVNmRy9TTzBNUlFLaEtYZVdSRGxmTUJOUU5aeFRyN2dsOUdTRlNjQXpY?=
 =?utf-8?B?aEkrdDIvWmt0MnlEVHVaZXJZSGpLdFFLOXlZamRnZ2JueGxKQVV3KzNYZjA2?=
 =?utf-8?B?S3hEOVVrc0hTSVpIWjZIRElmekZIcUFBNDNHcjBXL3FzOWx0Z0laUHhpRWtZ?=
 =?utf-8?B?Ymtmcmx3T0lTMzFvSUcxY2Z5emxNU1FleFphTitYMDdnT1ZiNEEwUFJiTzJM?=
 =?utf-8?B?ZHY1SjZBb3RjS1NOYjJQTnU5TjBNdkV2dld6VFhJL01saGRrTTJFRWZFU2hm?=
 =?utf-8?B?THVmSWhiVURIcWxLYVhjWlBaSjlXL0hJU0VjNy9oZXRNODBJanNPd0Z1c01J?=
 =?utf-8?B?QlNEK1hwd1dZMmk4bERJRlFobjJFVVhFb2lrK3daNmwzVVhiZktxaUhlUzRC?=
 =?utf-8?B?R09qTlNiTDJSUXQxUE9Lcmk4bW9JbkpqeUM5SUlzNnZoYUY1U3ltNHJ6cmpK?=
 =?utf-8?B?UzJZeEFNWWRHVEJJKzdCQytaWlUvbGRwSDUwbFY2WDFFM0V4aTZLdTFNYWRO?=
 =?utf-8?B?Z2FoZ0lZYS9CeFVCQnFKK0pxalVlTDZrdEN3djVsQW9ZUUtUMUJMWGtnTk1U?=
 =?utf-8?B?SEl6RUVhRitucG9MN29LU0NpSit2UXVvU1RSeHNSWHIwemRnSE4zdGVOOTJ5?=
 =?utf-8?B?ZEhaUGRZYTNZMjVkMnQ5UEY1TWd4b2krbTF1OGhmMytOUHhma2N2d1YyOVNk?=
 =?utf-8?B?bkMraTRtWStZY3RpZDAwUjNXa3lKeXNoaFdVRkthUFF6VytUUGMzcDJxeWtK?=
 =?utf-8?B?MUo3WE92c1dVOXpacnR3S3pmcEsySUh3M1piZ2NjNVEyaGE1RVIzQ0lQUUNu?=
 =?utf-8?B?aHhyL2dKVmRxQmVJVVFtR3RKYk0zQlJWZ2c0TTZaV1RUc3hlamFCZTZCSGkr?=
 =?utf-8?B?TlBHUHlkYUZHclltNzUvalhOMWNBazNHOWh5Z3ExRDZJZ2NDOGlvTlAwYlhP?=
 =?utf-8?B?Z1NlRm5qcTNGaTJPL0hENEtoN1pNcmlPTXBOSzVUb1RJc2sxSHduQ0R3djQ0?=
 =?utf-8?B?NG5xa0ZONjNwZm9FWTNrL1J0b3llRWpBMm1wZlh0WklrRFNJSVMyRFBkVEkz?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d88630-f4e1-45e4-48b4-08de32cf5597
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:52:01.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxVSfJO1zX5fiADRz2j7K9C/lVuZew0+1v9qoK1nPFbxQqWwDR9YO/RMReDzAaOZS51oJ0chG5ZkHcLBOg51WcXfv3VTOM5tmqn6pyG3G14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
X-OriginatorOrg: intel.com

--------------DHT564ugK3OFEEC029osstUC
Content-Type: multipart/mixed; boundary="------------FEh67YWEiFh1lmjXPrBKa55W";
 protected-headers="v1"
Message-ID: <60b8ac3f-cad4-4aa7-bcf1-230f2067cc77@intel.com>
Date: Wed, 3 Dec 2025 16:51:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <aS3F36UAkeLfFeHx@shell.armlinux.org.uk>
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
In-Reply-To: <aS3F36UAkeLfFeHx@shell.armlinux.org.uk>

--------------FEh67YWEiFh1lmjXPrBKa55W
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12/1/2025 8:44 AM, Russell King (Oracle) wrote:
> Again, I don't like this foo_enable() / foo_power_on() pattern with
> a true/false argument - when false, the function is not enabling
> nor "on"-ing, but disabling or "off"-ing. So, gmac_clk_enable() is
> going to get split up and renamed.
>=20

Agreed, removing this anti-pattern is good. It makes the logic more
difficult to follow and understand than well named functions.

--------------FEh67YWEiFh1lmjXPrBKa55W--

--------------DHT564ugK3OFEEC029osstUC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTDbLwUDAAAAAAAKCRBqll0+bw8o6LOb
AQC2K6E+Ldy8fS+FjrYBWdaSU8TPadlNqFtn/ueyqFyJrAD/UB+MQSNRT/84EcbQf5ggnpl4r1vE
zvGonLKcbMDlqg4=
=dR4+
-----END PGP SIGNATURE-----

--------------DHT564ugK3OFEEC029osstUC--

