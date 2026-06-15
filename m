Return-Path: <netdev+bounces-299556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MwQPNPw3MGpwQAUAu9opvQ
	(envelope-from <netdev+bounces-299556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:35:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707F688E7F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=aeqoIY6f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299556-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299556-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3938300469C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D293409632;
	Mon, 15 Jun 2026 17:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C83CDBAB
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:35:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544950; cv=fail; b=D+x68tX/mlB4uLfhsJ/dR9dqjg3vuKSS47xO+a/EXtGwlf2wfQTkdZFHMFtW23gDzBnDYQA/2OsCy8iOBnLuOSAABOUQAZqGta3PXuPKyY8uAcjKFiwui7c6c6KoMyJFo6V7NpbgWK18W54DYY4b5lQZzH7nvRP9e8XMGuJswH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544950; c=relaxed/simple;
	bh=iDm7VOpShkzbRV0x8InaGGrrXeBF6eQB48j4oG4wrHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RiKORQlh8jgHb1cIq58IK9s4Xu23lqJL1xxyY+tqc5p4sYYEBjXoiHsg98PR2A4uVQ0SExEha6J/QBe6j2lb4RnkjI91vP8iHjg6aanvrAxrkWpWgdivboq2t5GKLZHrjVN2Nkrbiq8lDbXCDOdPugXEco6yn7NOjYZZ/244De8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeqoIY6f; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781544949; x=1813080949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iDm7VOpShkzbRV0x8InaGGrrXeBF6eQB48j4oG4wrHE=;
  b=aeqoIY6fISjuiHKG6MMLp+h2e69+wQDUoZtuilIi6semOvdVUuwplzfu
   7anauoaEU0Ub2PGJIzxjoKwYx5zh4PP42orHe8AB28eWf1ICOPcZgjjL7
   kDIvsdIZ8cY0KidN7QB4QIUsuMZP3dAxPhdyvrOiycmQc/nHCtrKIDsuc
   bbMTTAiR7MjpdaBHZe47d0iOIOYHO8JotEte6M5il67hayeAGf2+5ABAF
   smvKMa4q0K+kh7/olNrSXzSWpFoPS/RU3Zpv0Hu2XVgQDp7VUzeITtqP1
   Eb5YZ0HtfRJPvN9X234MBUqyYHdm/vnH008+pNNyKh+pKB1tiC7KB/C7f
   Q==;
X-CSE-ConnectionGUID: OaqNuS0dRLe4ZvscTjp69A==
X-CSE-MsgGUID: QnXdO0+XSoKTg9jYmNhGMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99869712"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="99869712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 10:35:48 -0700
X-CSE-ConnectionGUID: 9d132hJyQRKAC5Svd+XpKA==
X-CSE-MsgGUID: 2fmDUNYiQ1me6eOF5+imNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="243161635"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 10:35:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 10:35:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 10:35:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 10:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOiSu9FBViIyMPLDZv2SXHmHv/ff7rhfueY1MPZzIPkKhPnfE3dlyKiher2WC0+1ivMS5ZxCOImTMUIRUCclkKt+YXdJi3rnchB9MCl38W8sUAL6kLteXlJT2QeyVxN1XoXxTOxirfIHfcskj2pffdxZ8OwOl27WnXlqpN5l7SXsxyULljiaTeYg//1Vjbj55jUeiqC1xiGEKbcuDGbezVI+opXKxOKpc6OmBn1WNyR/leeq9aJ/vQ5sV7Uegj/zrBqWoByAVpjlT6dgJOsyOq87zrjDkxUa33DPU2u7QJZkpezdkiT9zpMboN8rVWwV8Vn54o96pfLAmnkk7Zu4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVHOU1JhnnpgYBTSylK+YIT8JzozsWHjk/zw+5F5iy8=;
 b=hdFOpvm3nypUEL8FHT2QtYPdtPi0KUmBDvQ3ngy+JVGBH216fys2uMBluzJyXaC+MdNQiZ9NJV5dQewt2JJkEIvgxUB5Krcg4tpOgSD+3yPLlqRbBmzPb3o65KZFJ2OGhjANeN/QLnUPJl/Maz4rKTu4n4YI7ybupgHYi4Jvk5UYpZoj0FjnbzmiTbiqdP7WjKLM8dyfgV14MHJsg/IZ13rHL36IgFadz4p7rteQkH23BeN4c4RaXPtUg5FwDU8hzCd1Ea3wUe8X0UE+GSacAjC0HWcCVG/z5iIGPUkMA1Y99M8jDFPyc3UAw6/nDdsz/Jw0Y9SQz/5uce0vOAfd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DM3PPF076C797B1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f07) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:35:41 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:35:41 +0000
Message-ID: <0a25e40b-60ed-4c93-8a5a-c8bfc07890bf@intel.com>
Date: Mon, 15 Jun 2026 10:35:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2026-06-09 (idpf, ixgbe, igc)
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Przemyslaw Korba <przemyslaw.korba@intel.com>, <khai.wen.tan@linux.intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
 <20260612120309.GA671640@horms.kernel.org>
 <7ede2980-e7ac-4311-99af-5cca54841f36@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <7ede2980-e7ac-4311-99af-5cca54841f36@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::15) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DM3PPF076C797B1:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ba5f06-faf3-4e33-e579-08decb048575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|6133799003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: h0SDk3th5Jl+yWdwL3EfsVnt5CrXrcm1tufsgRNa7FDKeEFkieeB8hPVvq8KBDSScbFtV1LkKU9LdmkKHvFyZcYmpGxfitAsZaNCwlgAp1lFNvciC726kvcK5uoJvvGoPHdbaTLc6x9eZLGLdLzSRjrwSTZC8cE4ga/4XPnWrr3K2VwUorVfFwWbXtsdycm1CYIKTcJITjAtY2mCSBE0xcDBi275GuwbZ2onTyEUu/mAvzt60sJoISxdPyU4dlLS2UIaqAQTijtlTPXGGRvtxY4b0+jDm79tVA0OGHNEWJktA8ehIhHtRnREaafPDfj250gkzw+VLqHzhlSr8y7USjy4TAX1TcLouXXA8QTB7ysRpSgd4TrzOg7SizJLeVPKPv7VmQPCgttfMMYh+CS0+CQ87OWKZbzUuUpe5WqLcp8ewlJZCeydIBWh8rJSM54pGseXnDZblD05zLti8jOzEYh6DJl41N2dj4jnrzYY2TaeUqFN1YSiFZiZb6PppTxTk1FeNGp+dV5+biniSrb6orMwiRP7fclkK9tI/rjlidd99kSxXx9RePflrFW/PoETKwtErv83RV6l31hg+HhF0oLwSp4eQtTgqG9Y73IsrPE2jmJkIPL4gvozkqtL3q/DByICSNmygimGvI48oRiUCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d291UnRZUWFraHl6TWxOb1JWekNUemlQcGltU0tCWjAwTk1tVm1rYXo5L3M3?=
 =?utf-8?B?dEZEa04zMkJMWWRqSUxkcWxINzExbThBRUd1ZCtteTdTRXlBMHNsVmlxck9W?=
 =?utf-8?B?ekNML05FQm1kR1VCQnZCRUlpRmg2dnlTZ3FvQStwa3psNE4zVGw5bHZEYncx?=
 =?utf-8?B?VDl3c21rTEk3MkV4U0hsV3lSNDVBNFhwcDd6Z1JnOFhZRndwWEdXUXlDTVo1?=
 =?utf-8?B?WFVVVWVPTm5lSG45VGlyS2VWWStRQTczR3VTMDhwU3VidkV0THRSTkNqYjNs?=
 =?utf-8?B?R3pEQ3UrTjUyMzM0aVBMbWZJWGd5WlRFU21wK2E4a0ZzOVlzZ2E3ZmJkRzNO?=
 =?utf-8?B?T0tPSE9KdUk4NjdRQmZZUHVYMVJCOVBRSnFXVmhFdGdiMXJBU01pcWhacGUz?=
 =?utf-8?B?VklBcXJuN0RjUlNFc01HaE5zZkJsQmZiVVBIUTBNdnlyQ1BZQWRlNTA3WndX?=
 =?utf-8?B?Y2NMeTFKTjBRcCt2d3dhT2laMGV0eUxCeUR4UlkwOFo4SXZtaW5qRUt3UWxp?=
 =?utf-8?B?YytKQ3pYU2JZcVBHWDhIYS9zN0JROVlJRTZ4WXVqaGh1SEdQenUraWZCWDlV?=
 =?utf-8?B?Zk9idzlocEtGb2lTV0ZVL1ZtR0tmK2RZV0JMTllwYjNxM0tneEtSblp5U1kv?=
 =?utf-8?B?SjJ3bmxTNS9kWmp0MXZRN3RaVitDR0dlSEtzMWhROHp1bUd2KzVWb0VLMnVE?=
 =?utf-8?B?WWpKR25VQ2ZYdytONFdvUldZUWhtams2YzRQYjc4WXFTeFBtaGpxVy9WM2hu?=
 =?utf-8?B?NWVjRTJOV3h0eGZ6d0JiUytjY05HYkQ3clkzZ3FDMC80cTRNeGwzenhRMDlw?=
 =?utf-8?B?N2l2Q1BCd2FhSi94NkltZ1NJYXJDUGFpZHpzeHJVeHBoMnJDUW1HMmYyUUkr?=
 =?utf-8?B?SmY2Y21qN2R3cVhlV09aS3MvZVNjWllSbmlBNnM1ZGhxUzNzRUN1cjI2T2tR?=
 =?utf-8?B?ejArRFpzVHhPZjk5bHhhbnFXQUxTV1Q1WUlQSkxBQ1Zha2lCNDY3Zkd5cmZx?=
 =?utf-8?B?akVFcERDOGord29XVEU3OWhvQUtHVVI2d0ZQN3ViZGhONGx0cE5WUXk3Q3I2?=
 =?utf-8?B?K2d5WXF5QWFnMjlLQ2Z0ZnBGcVdYMVFPR2c0Qk05TFpGWEw5SHVoMzRTYkd3?=
 =?utf-8?B?VWwxODB2bEFvVEdmT25UMG5HVTdobll4NkJjaVFRVURQMCtjc1oxbW1QU2tX?=
 =?utf-8?B?YTBaMjFvdEw0V2R5Rms4Ukp2YTFHckJTT0svLytVZWJFemhjb056M1p3c29z?=
 =?utf-8?B?UUw2YWpSemw3K1FIYTV5R1lRQklWZzk3dlFxanl2Tk43MmhtcEd0TktEZjg0?=
 =?utf-8?B?aWFlZDBJMkttWUhEamhhVXU5dzZnL09GODNmNmJacElra29kUWFIK3lxaWdm?=
 =?utf-8?B?czhsSmJXM1RHQXZWNUdoOFdtZTRodTFuSVlsblBHOEhZS0pMQkVHalpnOGhz?=
 =?utf-8?B?Z0pVdE55L0dUM0JNVGFVQy9LSi8zbmU5bEg4OUhXUEI4RFgzUzVSSHdGQlU5?=
 =?utf-8?B?SHl2a3kxQmZyWDB0dG9Pc2dCZTdzYWE2YWs2N1E3OXVxY1JTc05zdjRXMklC?=
 =?utf-8?B?MWsrZWJsQ3ZSZW93a011MG81STJLK1IyOTBHck1SdmpZZ0RZbnZvVjQ5N1du?=
 =?utf-8?B?L3dzeS9qeTUzUXhsb0h5b0dJalhKVlZRVjI0N25UVlk4NnlkK0x2bkFPRE96?=
 =?utf-8?B?aUdxb25UbjNEcXpjVTNTMFRpTXY0RGNqdUJTYzd4cFlwREtGVGk3V0xxWXRO?=
 =?utf-8?B?SFpVMDlFUkRtS2R2d2NRTzc2SjBBY1FwMVlCR05wWGxQb0xSZ0xzNEMwYllq?=
 =?utf-8?B?S1diUGJQZVdJeDJZYVlReVhTT1pwWnhDNnlmcm5vZ05Eby91ZXdXVkRXTUcx?=
 =?utf-8?B?aVV1QlpjZ2JJWG9lQXk5dHRRRk5ibEVmOWRJNWo3S2lETzJZLzMyTXZZdzAv?=
 =?utf-8?B?SWFiQUg1WW95a3BnQzV0YzNmZjBZbHF2UVcxU0MyY1ZnTFRjcEtlL2R5TEhl?=
 =?utf-8?B?ejNEdm1QL2JiNVluanc3b29uRkVlalFHZzlKMjdGL2ZZMGVnQXRROXNaSU5R?=
 =?utf-8?B?NUhkU0M4QjVqbGNWL2xNcTFRbzZIOUdLY1B4TVFJME11L2ZDSXFOUlY5Zk9Z?=
 =?utf-8?B?V1FrN0hYbkpKcHdwTVBNb0ltWDIrdDVOOXFRMTNXaW9HQXFua3ZXUDBOc2J0?=
 =?utf-8?B?UlBjMWNoOFI2QTVqZk14V3NpQVhoRTFUbi9LaEN3YzNuVERBZW1FZkorangx?=
 =?utf-8?B?K1U4UVNuUjhzRGV2T3V1Qnp6ZDF0SExpM0R2a09vcWR4RGluTDc3c3pDZGdR?=
 =?utf-8?B?ZHlMVUk2ZjBOQmNBd2ZCZlNGTFFTaEhQSUxwVjhFMWI0RnJzTXFKMHd2WjM1?=
 =?utf-8?Q?D6+wZGVuRjOSfpf8=3D?=
X-Exchange-RoutingPolicyChecked: ZeaWF+0xL/Bn0kRCqmh7gwCtwWZzhwMAykKlOvZBXGuuUSRmhsYW4k81ccNO8euMU3ASlPI8CZA9KkD3DUK69/JSQnrgL6AHP6NKP/CMF1nR1q6e57HPuiqKvkCc1pqzNLBNmnAis3TBMsFGg00ObloM2s5JJyXF6G22tYNpHTB16266e1pRG5/AfVv0A4U4/y517YfZOM9Iyn/MzOa+se+v8WLOJbvvjWnBedRqcNNqfF8R3v0zQctmCnmqN/YwPb5yixEAiOv5YdA0sN6KRQhnJQQGqJU00n1kLK/uyxd5CbB4QDbLDusHYrmbNIn0Krrorr4Bc+xgZGG0ovU7Jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ba5f06-faf3-4e33-e579-08decb048575
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:35:41.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYoPKTXKEFLW11KsWG85isgU/Lj8RBbq1v8Rmsylb4cBQcX+BrxFCwWIjPQ2K/NsRbvh019EvDzrVrxzXPzJ0axMWErmEDnJN8hFW2KVlhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF076C797B1
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.korba@intel.com,m:khai.wen.tan@linux.intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8707F688E7F



On 6/13/2026 2:49 AM, Paolo Abeni wrote:
> On 6/12/26 2:03 PM, Simon Horman wrote:
>> On Tue, Jun 09, 2026 at 10:24:53AM -0700, Tony Nguyen wrote:
>>> Przemyslaw adds needed padding to idpf PTP structures to match firmware
>>> expectations.
>>>
>>> Larysa bypasses XPS configuration on XDP queues for ixgbe.
>>>
>>> Khai Wen corrects offset into packet buffer when handling for frame
>>> preemption on igc.
>>
>> Hi Tony, Przemyslaw, and KhaiWenTan,
>>
>> There is AI-generated review of this patch-set available on both
>> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
>>
>> I would appreciate it if you could look over the AI-generated review of
>> patches 1 and 3.
> 
> Going over such comments looks like pre-existing issues or things better
> handled as follow-up.

For idpf, Przemyslaw is preparing a patch for the uninitialized memory 
issue. I don't believe the firmware is a problem, but we are 
investigating/testing this.

For igc, KhaiWen is looking into them.

Thanks,
Tony

> /P
> 


