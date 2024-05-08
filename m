Return-Path: <netdev+bounces-94503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A78BFB63
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617D01C208E9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86281729;
	Wed,  8 May 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUEkZ3gO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AE7C085;
	Wed,  8 May 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165901; cv=fail; b=ATdBSNaqjzbMj03Yq5P8mHmicX2DU06QiMSfhOkZ+WIblHIn6qHQQLCQyEHfFPW7+Pef1bjd95OcG/LRr56CK57xI1ijo98Rr5RXIKi8EaORIjyyUC5hpwvYBEUbUEDMJq4OZZRpFU6LJw/siNKdZ0FVCQV6xWk3Pt43gbFx7Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165901; c=relaxed/simple;
	bh=sYBQFyviWVirQfM0eFRQ9upuU93mq5yXOugIwT6nvlo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/QnBRdWf5QBTys/L+7CcDlMlpnW31NSjcewHcDOCc2G8qbyhvFY7S1+9Jb09ydyNoLnztwZ0erRImROiA/Mhg6on0kvXikHhavj+5+Awx8UUWP+Xeu81AGqm1ErNNvRmZ+q737NsI9m0XZtRHii/bKOcMEWhdmXLKrOsCmoqPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUEkZ3gO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715165899; x=1746701899;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sYBQFyviWVirQfM0eFRQ9upuU93mq5yXOugIwT6nvlo=;
  b=aUEkZ3gO0OaLcXemoEJVTKcjQZjq3z6+MK3bI53aYEo0P1ojlsE+A1vE
   AHl+/uXZMHh4mNmArRwiq7w5ucoPjAP7BD4suKeb5WNXjB2zhPIibwrID
   cW89e6XQVsOcEx5O3gxP7p6ADiDB2KCS4rQi78nkwAWnaqnNoAGDTvZ9e
   i0zV6ntri4wpqfbmso6MB1QC/Wrh0Zmt7PQrRlZkfv0DI+kQzJP2oHcRP
   UwbCUOK7jJF2Cu1y2KG1yfF8AMXnwiyVZWtkfbGy3GGM9YyW/mpfqu37t
   3vaDNtwHhKlogzDJLWXxT8BEmpy0/z1DV2pntAjrnc2iDaPcTttlvy+ZZ
   Q==;
X-CSE-ConnectionGUID: XW5eq8JVSqGfKhnKZAVDBA==
X-CSE-MsgGUID: rwKz0fHQSc2WAwZmoasHGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11171812"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11171812"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:58:19 -0700
X-CSE-ConnectionGUID: QWS12xkBSBiWF+Rie7SQKw==
X-CSE-MsgGUID: 4RkH2ISgQUqRHc4OwaqrBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33321750"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 03:58:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 03:58:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 03:58:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 03:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlFh4rttmr2AKBop9D78UxW+scLWqAHdSpdxI1PJW3rgzRnDJxARcT/MEdOL2gI/bri/t0haIyapuNgqpyWkvEK2xZVFnlN0kdcnD4Vt91Sb3H5fNWiGjFRa98cBzOUSCgFbPHxqc7Ak4M/q1+DQIcvNYvaRfhrvaQn+cRLPFJLnhU+1uabG/8ZSzcjV7vMSkh0PA4qj4xGj+3GsSPd7npBvUjyiTkxc8nT+PZ3t1kLA0HlZYImx+MAkdku2wg93yNHGQfDMRvG7UGZyhf/mrOqCwgqJOS84FKNT4+Z/o+OII5azCcrpOg6rwdUA71WlHRHnmXF5//gBI2668pRiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsRrLM1mNUY9NV+AndvpGxxdDU3485/4KDi6IW/G35I=;
 b=dDPXAFPAe2x3afWxstmHBJtBO4sY7hgAjp4gM6tr7ncOE+RFTaSa1PWc0QjJFUUZ4vrGwZCB8O9GyDw/SiR9qIFULmMOy64fzsktHZvDzTqXmPslLgf9DYMvHFFeB7fhC0HktjEAD1VuM3HKfN1A0V1itcKS45SO1m43i8xpdPXr41cBWRB3oBMJMWWhevQoEFrOdaTFp8X869SQNF5jUug8d8xekyEQRJg59rEsxjPylmRQIUuIJ6r0Mctbu2iBI1qdZHczVjIIfQnlLdqGBJGzX73BTPgCH443Ibo2sRTWVWg4NORrPfkldZKaemjYItCJi6e3/GXJbtJcxOYWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 10:58:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 10:58:16 +0000
Message-ID: <763a2640-2170-4b62-86db-7d7f8438c585@intel.com>
Date: Wed, 8 May 2024 12:58:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net: ethernet: mediatek: split tx and rx fields in
 mtk_soc_data struct
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>, "Sean
 Wang" <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <70a799b1f060ec2f57883e88ccb420ac0fb0abb5.1715164770.git.daniel@makrotopia.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <70a799b1f060ec2f57883e88ccb420ac0fb0abb5.1715164770.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 626d38c1-b83b-46c7-d20b-08dc6f4dc384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUdSV3dhNEFEcXJHWXBpRmhLb1JuS3pXc3pEOHRDQXJpcHhMUHcrWGFweHVX?=
 =?utf-8?B?Yzk1ZERBTzZmbVAyaDNsb1NHK2ZORDBsam5BWHN1djY1b2doOTYybW9VRUpu?=
 =?utf-8?B?emZFR1UxeldCQWNPQ3g2Z3JHM3JwbHFIa2VOcFUyaGpsVXVsbUhtcENZNW52?=
 =?utf-8?B?Yk15L2VMMDc5S3BQQ1ZGcWNmcUN6QWR6ZXFtbk9wMnBpaFJ0c0RPN0RnMGE1?=
 =?utf-8?B?ZU9DaUQ2MFdFNDVLSnljdi9pOFpmT2RwajRRMTEzZ2JDQ05GYTNiTVJpMjE1?=
 =?utf-8?B?WUJ1UnVRZG5yTVFwenBCUE1wT1pjeXpNaisvMWxFRVJHQUl5ODFCdmpDZjh6?=
 =?utf-8?B?MklreE9obHUzNmw3TGVaZUZza3FlVWo3WVJpTzdEblZmY244SDRJMEhxWjNN?=
 =?utf-8?B?aEZiaGliaWROT0FOOFdlZ1IraGw2T2V3UXBoWTVIRVRjQ0tNekl6dUMxbkZh?=
 =?utf-8?B?NE5IWlNDbERDNkdyWEI3VEVYWTNOYmVHSUhWYmh0dlVqbWxDRk5YRHM3Ylh3?=
 =?utf-8?B?b0dHSmpDdzlNa1BualNUaEtSLzFIWjJUYUlQdHppaDdYclRGOTE4WEsxRS9P?=
 =?utf-8?B?Wit6WXFidDZuUnZYOFRaRFVQVTY2c0Z2aFp2UDl2MngzeWd0UHhsNzZKWm5Q?=
 =?utf-8?B?MjJzTjV1WWd6QkhlT0d1UW5qL3hWRVRnaWVrbDlKQjYrN2k5eStYbkZaTHZa?=
 =?utf-8?B?MFVuVUpKNFBFa1piNjl5SC9pYWtYbytvZlE3R25qN1FYdE94ZGlqb3V3ZFJj?=
 =?utf-8?B?MDc0SkdXZ0t6eGpCaUtDcGFsQUJQdGxDL3kwdjY4d21aU2dMS3ZmdnNpOHpr?=
 =?utf-8?B?ZDJWUXpGVW9kQWJLdERyMUU2VmNaNU1CSTlJNkhOWjdqSHhPTHdJYnVielBL?=
 =?utf-8?B?VWNnSVVtQlJJbUozS2VWcHpCYW11ZXJramxCUDBCQnUzckIvZFNHRnFKQ05T?=
 =?utf-8?B?SmJzMXl2VEplVWtFdHdoM0V3a3Nma1FHOHlWQk1TM3pkZUpRQUpsb0dHKzly?=
 =?utf-8?B?M0d6dlEyekdncSthL3pxNDJWS2tBMzVtUEdyUGIrUStsUVI3MVNISVF6bnF0?=
 =?utf-8?B?dlJVVXRkS0RDSmRtSEdPRXkvbHBDejh5ODRxZnpiSzlpL2dIZ3ljdGFmaW9T?=
 =?utf-8?B?ZXpzNkcyRUhhNU5oUWQrT0xoNzd4UFc5STBOK2o1TFBNVmdPOTU1QnVERThG?=
 =?utf-8?B?cHZrSDNvNVJyMlg2ZGpvUnBRSWdLOWhyQkhGMjVDZzNhYW90ckdzRC9aVkVK?=
 =?utf-8?B?TFA4TjlqUEx4dm13ZGZYS2NqUEpxclZNdnZ2RXlQWnhPSFJzNk1VdVpZdGo1?=
 =?utf-8?B?cDh5Q0Jzd1RpTjQzL29Nd0tOcSt0RlhQRkRFN1htRHZPZlNLWnFEN0FoK1M4?=
 =?utf-8?B?dHMrN2N6TWZ4a0NoT1BXL3JUSyt6RHZqNXh2YzBWUElBak5EQnZpajMwTmI2?=
 =?utf-8?B?RksxcVNoRlZvSHhnRzBCemhVZDk5KzJ6MXRXSlJaZVBvbEFuK2VBQnpzZCtK?=
 =?utf-8?B?MENUNGVwZE5kQVBBY1d6MnRHeDZMWnhUQ21QZTY3cGFnVDJUUGJNc0p2VEkz?=
 =?utf-8?B?SDd1N3ZueUVNTDBZNEoxb1REWGdwakxHWFh0QXZ4RVVRczVGWDlBRlZmOTEz?=
 =?utf-8?B?SE42c201eXRxa2FucmJFbXpPZmFCazZNOG1hWG94VnBtU2ttVzNvWS94V2tE?=
 =?utf-8?B?am4zS3I3N0MxWU5kZjhZdnlGM2Z3Tnh2cXhocEZEL3RVUlNqams0UWFVQ0NG?=
 =?utf-8?Q?kA1p3c8GN/gDoBNBdADNwt1Lp9lBd9G8PWe9PhR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUR2UjN4amhrbmxZUGJTNTQ3VmJXa0pKTGhuVk5YOWExWVY2Ump3bGhmdU45?=
 =?utf-8?B?dHB6QzU1TGltRVZCYXZsd01TUGZvY0oyQkxrUzlpbUMvV0dUSDBxM0tUa2pE?=
 =?utf-8?B?S2VaYWdHOVplMC9LeEdHVXhCTVgrT1ErWDJseWxaRm5nWVY1Ry9OUCtnM3dS?=
 =?utf-8?B?a05YY2J4cSs0TDNtakpNV0dER0xaUU5sakNXcEpqR25PWjNaRUx4TGhrRVRS?=
 =?utf-8?B?TXpCZ255NXpxZWorYVl3REZacjlkc1ZadllLK2VUK3c3bVg2RXdRcFFsaHVi?=
 =?utf-8?B?MDFLWVIzQlM0OXRjVDJLL3NHWFBTOGlZaGxzeUNKV0I3MWMyMDRPejlJZUZL?=
 =?utf-8?B?MXZxaDU1MXJyWi9HZDY3cGhXMk5KMTMrWGJHOEROQWlLcU5FU3B3MWR0OEcw?=
 =?utf-8?B?MWxHK2JhTGN3SXJabXIzRTkzdytCTnpsU01qZXhyY2JXYiswb205QU8rQkUr?=
 =?utf-8?B?ZU9nOGZidHNMaTFURDB3MUtPUDBlZWVSS2pWclozT3pjRjJBT3orcnhldVJl?=
 =?utf-8?B?R0hHWFR6UzRhYXZNL0g2N3JtRGhlSTFxeUg1T3dESnVFY1pDSDl2Nm9OTDF0?=
 =?utf-8?B?NllkOVVQeDFrQzZaTGRoSXk2WGdvK1p6WnAxZG55VnovdDhTV2tRYnVqWW10?=
 =?utf-8?B?M0pmQVBseFBzUnYxRWVrdlpTU2FIN0Y2U0ZCWWNXUVBlUjhNL2ZYNG1TZExP?=
 =?utf-8?B?SlJJV0FLZmRXQUNGRzhrSlJnY25mZE1UbUs1d2NOSGprc2FrcXhjcDZvT0RK?=
 =?utf-8?B?bFJvYW1UVzQzZVpqNUtzS1hSRDRrZmJ1Nm9pRGxmcjRqSUEweGdHa1VnYlQ5?=
 =?utf-8?B?WUVkS3FHMkw0Rk5NQ0FuNWxaajRHaENPT1lGNE13YU82UzNQVFBrNnFFUDUv?=
 =?utf-8?B?eXM5SXRWQ3IvNkhiOWE5K3BCY3V6RjVLdTJIVTJOMXF0SDFlSzJBaDE3OERJ?=
 =?utf-8?B?bFk4RXBQQTdOWWxTVHZRanp5d1hlQkhWUVFmUkdtM3FLSmdyTndYMXVhZEQy?=
 =?utf-8?B?eVkyZC8rMGpLZjM1clduak5NSGhXdS9paHBWUFFybVpSM0hJRzc0QWxVKytR?=
 =?utf-8?B?T2hSRnczN0VJSGR0Vk50YWVDdWdNdktsdTNrRnJyMEk1RHpnQkp3RThaTFJ3?=
 =?utf-8?B?Z3NDYVBLemNDZGYzbSs4djBldm5ndFNmMk1sZHlyd0pldnBSZnlvM1A1ZW9G?=
 =?utf-8?B?dHBYWnNVdjJoRmIvVTdLaWVGcUVTTWdnVG5nZWVTV1dVaGdmNGVWN3doRUg4?=
 =?utf-8?B?ZWxaRkhIYU1FRnFtZzNIWTIvZzhXRmZZY1hwNjExbUVSS1plbEg5cWdEM3VK?=
 =?utf-8?B?WmdIanZZcUhQL3RNcElEN3NwVlVrYW11UklHY1ZjRTcwaCtSQTFEQXN3L3NI?=
 =?utf-8?B?clYzMHBvUmptSEdlbFUyOWJrVE9JdFZXSGRCRmgzZmVDY2ZSUFJ6MTNpU1dq?=
 =?utf-8?B?bnVpeXpXUzVnRm9mRWtFUExGbVdRNUxPOHlmMUNUeXhWV2RiY2dGeG1ZcEpa?=
 =?utf-8?B?d0UvcStSY0ExOVVmZTJuZ1FvRWwxKy9hbURJVGdkWkxnUmZFV0Z5QXQ3ZUhF?=
 =?utf-8?B?UnZLVDl1TkEreTNJOGN3UzYrQmFJckYycUJnR0tKaTZ5Z3NrTDl4OU56Y3JG?=
 =?utf-8?B?WUNIUUtxWEZza2dPZEx4cHlYTmliTklpc21xeUxaYWxwUHBTY3RqcVJiZGpz?=
 =?utf-8?B?Nkg4S2d2OVR5UUduTXRIMmVXZkdYcDIwa3ZPdk1yT1NKVWlPL3VVSUlPSHBr?=
 =?utf-8?B?Z0VBUVdKK3JDUjY3QkVDYnZYUGJ5WU5aL29NVlhCTE91akpaUnVTNWloOTkr?=
 =?utf-8?B?TUNpTnY1YmtGNllBNGNJNE0wcUJxMlgzWS9kYjhrSXJ1aWNnNDBNRW91bFZ2?=
 =?utf-8?B?Z3ZwSWJwMTRVMHJIMFdvdDB5RWc2cGdsZDlPZmVlQ2xlbFFIaGtobnN5ZTdQ?=
 =?utf-8?B?bmpWeldNTjVzRithclJEa1lURnpsWXBnc3JLWjd4VXQ3MEJOelZ2OHRLV01Z?=
 =?utf-8?B?MXR4ZVhSMkVXQU1KM2xHemxidlI5MmM1eGdXM01EdHVSWDJDSE1sVDhYUS9B?=
 =?utf-8?B?bU1iNDJLNGxna0NsL1JSczJxOUYrWjBSYVB5Y1FmRDRJTDl4ZXZxT2Y1TjZa?=
 =?utf-8?B?WXpzT2lXL2pkWVNvak02Y3lWUWdsN0NKQ2lXTVhCbm1iZHg3WnhlWitVYStK?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 626d38c1-b83b-46c7-d20b-08dc6f4dc384
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 10:58:16.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE0htnNnjhHe7DPpP+OGxQAQucS3tdVdVz4pZ34O9jSEGZr2OtK0R+Yk0rRCfi/L00DNlLJSi2LcGWB9I53Oqp26Qg8SlfqartrU8dfXKBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

On 5/8/24 12:43, Daniel Golle wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Split tx and rx fields in mtk_soc_data struct. This is a preliminary
> patch to roll back to ADMAv1 for MT7986 and MT7981 SoC in order to fix a
> hw hang if the device receives a corrupted packet when using ADMAv2.0.
> 
> Fixes: 197c9e9b17b1 ("net: ethernet: mtk_eth_soc: introduce support for mt7986 chipset")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: improve commit message
> v3: resend because messages were accidentally sent inline
> 
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 210 ++++++++++++--------
>   drivers/net/ethernet/mediatek/mtk_eth_soc.h |  29 +--
>   2 files changed, 139 insertions(+), 100 deletions(-)
> 

next time please collect provided tags
for this series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

