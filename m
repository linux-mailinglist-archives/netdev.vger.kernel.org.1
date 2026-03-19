Return-Path: <netdev+bounces-269371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK3gDGzAu2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DAC2C8889
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2568B30E40A1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6554A3B0AFD;
	Thu, 19 Mar 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KH/DaYGy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C893B27CC;
	Thu, 19 Mar 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911441; cv=fail; b=FvD7AnmsxV5zDuEXoQ2qr3o9Jz2o+/KAqwsfZOvgzET1PIwmdwwGoBD3Bmt7pBI8V81i/qSt/eH3WnZxbAQXTvo1X5wrlgudbD4QI16QO2LapUuL+Lp5nDiXKS9XdScDnrOs+T99UKyaYhoX52XPGqb1bPoPFsij+QkJ3tUBun4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911441; c=relaxed/simple;
	bh=2P9L4yGjCAZfiEGp9ui6pLRezVDQFPqRDOZKIrviAA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eKL8lehEpaAHPHYMQAu7be4z4yfWagt3nxpEsiYymnVeVr2/N5jdZHLMtmZlzn9v2RYRCuwz5hZshTHFIr87KgIxp8kXXPVQCK9+HwIOuVSTchpoEcYBdRL8EpoqmFCSoUILxrFo5ILWS9bFWxOMIFLxu7eTDxxFbaLTy09aNlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KH/DaYGy; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911440; x=1805447440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=2P9L4yGjCAZfiEGp9ui6pLRezVDQFPqRDOZKIrviAA0=;
  b=KH/DaYGynC8pV9holn0KAUWGp4Puy32hx1Q4OWUJC98+n1HKwNO/mZX7
   WBQ4/oVoLvTcBoZ7iKODeLgi/ii+ZR3/JE5YG56cJ3FaAao6gHghLoAjy
   Hqm8Nzh42fJPI1JkYattBT02JIB1Ajzn1b2BbVM10NZV/Zl7HBT2x12pg
   9x/POP4r81d2pMSjRS2GQM4lzbu5P2tW5xD2+rWteHoL0yo6WBBSV0Vgu
   fs7bv2M+Ke+XT9UNywEm8snS79rOEBxVZpEk5IB0o6qHTrh1omsVH9Fn5
   4Co8JtmhzHEQGwWF4XrXDB/Cb5R/wKHtYOONMEDldp80nYr2DnYW/LiQq
   Q==;
X-CSE-ConnectionGUID: eRrISGwiTiKVqSjCzZo0ug==
X-CSE-MsgGUID: aAbsve0uRGWR08CaDGaaYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86339137"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="86339137"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:10:39 -0700
X-CSE-ConnectionGUID: +T4Z67pCTwK/iyVc8ueHwQ==
X-CSE-MsgGUID: UZlmikcLT+CntAEOd6qmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="245929339"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:10:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:10:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:10:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgUUh7+HprnjUGA0WC2Dpj9C6oryY7l8cGaMKyKCudFozNhB/cTzbrwpZ1rV7Ftw5MaVHEKQiKJZeKCFaoAyjfSGrAA0qUQtmusoUviR6EzcR6nmXN9bdeRPBNMha4Njw0W2E7m7OmR52Pdf9ZHUEkdq/uHr2Bi4DCQlbq1XJNq7Exdwpiy0nlQ2RBEgQy5Ml4pESfuixjWkZ0IRHgQ49SKwW7k0BGTYUnKTBubzmo4mJIDydHWboL+dLduPwm7K6yJprvhwg/vBRIJRb6ezazZPr7HCg7G2TA0abIbExcqDwKbPYiypViZkiR1Hqi7LcPImtrJUCJZngliLdU898Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnwWsi5Om6Koy2sl5Y3INljEnOVMJ1N1drUpuIoMwRA=;
 b=ZRR3tTOntDcljlOtfso9RGxGfMOMPs6LahC5WRQdGRaBW7yQlBdRwh4AV0PBxBOYoLZ22AmMFP7RRHgSIeI1wNmZRrNq9fKBpecHH2bwYC3+BAZlHmTv+FR3UJhn47DiROmFi4O9FhOClYTmnATpLnwhyzajHNnvBlNEtesfZ3j0ggaKpFPy3YobOK3v5+3vtH+tS1OyiEyhxOJlJCdOdXnAI+S95I6T4wd9jZGBsMcsUErbErglyZl5RoUBqkD1qPBfMEgnCMlBrFx2zAU1bMrU8bYmVzai2cXzF+Ze6okIf2SDS/34iuxo55BUKTscMRNviXbdghIRVHrXwOvy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by DS7PR11MB9475.namprd11.prod.outlook.com (2603:10b6:8:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:10:33 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9700.010; Thu, 19 Mar 2026
 09:10:33 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Oros, Petr"
	<poros@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Drewek,
 Wojciech" <wojciech.drewek@intel.com>, Simon Horman <horms@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix inverted ready
 check for VF representors
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix inverted ready
 check for VF representors
Thread-Index: AQHcm/S7N2bP5X4h90W+5SzeOEMm27V+0TSAgDb2H+Y=
Date: Thu, 19 Mar 2026 09:10:32 +0000
Message-ID: <IA3PR11MB93012F753C0333F18462BE898A4FA@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <cover.1770882260.git.poros@redhat.com>
 <a76096058dd9b6d0cccaa5c2c699458351d02cec.1770882260.git.poros@redhat.com>
 <aY2hnyXFM9wplF3i@mev-dev.igk.intel.com>
In-Reply-To: <aY2hnyXFM9wplF3i@mev-dev.igk.intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|DS7PR11MB9475:EE_
x-ms-office365-filtering-correlation-id: 72d7dc8c-425b-4053-e449-08de85975ff3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3J51dFIdvpYhOQB9gW4ZV6497oZFI2JPvCiSSaGYxHeraEKag5ff6wLzGROtNmDxYrzIwIKa7pRLfeeTRS89FYb4KVwFe4Bmi3wmg8S4YwoNc6923dfeXYO16LOsDQO4qIW1qKntpWTTPYBRDqIVVVD4bgFsu07lB7ZLed7bAQTrMouvES2381heILhiYBojYPLuQOXTNEY3Kso5KyTmRdOoLNpOzVeBQQTq0ocCFeQon1QpfWZDxL5v6c4T5adeEVaPZUqBcSBecf/QwSoigBmVRWaE0E57wGlc1eQtm8SOUdbnGEV8kFfIBw1ItP+lExXW2HN0evUjyW/Byv3eqwFXROHIzh9O/CoV3gfFJ29zKjtNiugcZCxdEVXd0nEtVAeClS8SC8KB45pDYvFDTBh8SqpMlP7dlCQ+d/eZKx4ipmhf/ni/5WU0y8Hnk/4WhBU6LG8xiivOFUdRxggU1/tfVtgpqZvL6xEY70uBYIRyHeykq4As6FxqdbLF38lD3IOAqKLtcTqk4yf0+kpvVjkKUrx2ZNuedbz9tqOx5g4rKmsCqB/FoMq7z+M5iOk1sDKzv/9kuxiriVY/F6/d/WalkH3YHu7UnXGHBw0xF8mDFArrX8VQdRFe//AhXu4NwsF95/Wthl2VFYUxTpvILtRBfQFS6bwD/Z12IbheRRE2qZngZxIebjKECaxjV9Mdzx1gcn2uOH4Uf7/fs3bp/4suAXWuFL1lJSpvjSKV5K9WeyFYz8WRxGsQsVMcoOzfuTwRnJSd1KyK+fYJO4hSxoNstjSMVunDVPAqBO1AqP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eElw1bDZpgu+uIrMb+wZRzI72xD7itF3Jes+9PYUxRtT7UF83HSXap5kc/?=
 =?iso-8859-1?Q?F0/ZoVA/+EbKzTjiZHhCWc3fZ5tcHKFNGW3de9+UYdoHF3zMITWhPDdgFU?=
 =?iso-8859-1?Q?v+BX0tAGLaz+xuRmVrSRA8NiemGNWUeP9D5SwiiZP1n2X3WPUw+BiaEqv1?=
 =?iso-8859-1?Q?bUCXEyypT7Ua6DYEmsFLqeyrZ5cJsXfpfhy3zqsQz+4WuwcjLIsqokYTY3?=
 =?iso-8859-1?Q?SZAxd1Tqqg+iFE1vNVOLoMND2upRHAkZosqU6FrawHsdnwSOl3Eo9qEyNa?=
 =?iso-8859-1?Q?p0R59FV9R9M8DdTLGecd3EXoe7pdDY/g2R/7Jh6jFbjvssJyhwRvcyA652?=
 =?iso-8859-1?Q?V6ipBMM/SsiT+LMyvvFYN8or2GLvCwbJKIMCWzbvEIo9uVy8vpCw1NTTGq?=
 =?iso-8859-1?Q?AUj0IVqXAFhx+HseenN6Ra7zOuIPo6pLX1dJ6dQ4I+wQIaWC5gOPY7n32S?=
 =?iso-8859-1?Q?WnevDYhiVTgPMXQPuIdQoJJ3blu1FWMTtr4rKWY+/EMtZU3ecA5ZXI0acr?=
 =?iso-8859-1?Q?E8okkSsZmhGeX9Iqi0XxPtxdTWxS3afD1Mw91RfFUp7OQDzlhK9rU2Ubpt?=
 =?iso-8859-1?Q?HaZ2Rvzkwur+2rdQlt6Ru6GjI0N27hEZqzWUnLZVlOHpUUIORDvEIqV98l?=
 =?iso-8859-1?Q?JkZ5fRpPCfoh5gMbC3mVBl3j+jCO4YMhuMG+RULycl0UNIdR4NHOOSh+B5?=
 =?iso-8859-1?Q?Uj6sbYMgSmkhGg6lDUMztXaYgFG1oOdPy7mZKk80t1HASRSMbbHRhQxCAR?=
 =?iso-8859-1?Q?x1JahcpMPcCwoHjJ2dGoLEhpNNwkbZm2FryEekgCYZHZdQ7dQ/bPt/pc45?=
 =?iso-8859-1?Q?D37K/nCdhmsbeeMI6aAz42MfJxsDIH321qb8cJJAIx0kuNP/JF1vth5fq9?=
 =?iso-8859-1?Q?To2SnhmI1886Uyy5HRSD4ngSol+9fgcATbO60hqG5UVeOlPxwHTgQ5f/da?=
 =?iso-8859-1?Q?rX14xUat0YgAnf1e3TMlWdcp8JcN7hNTz1xfs4LnqJyowZnAsHoqy9QqGh?=
 =?iso-8859-1?Q?lzvTLH5QBQJSwWnT1MAvTAF9KlyuKtVHxw9XsKdTV/xuZlLSSA34TMtlxH?=
 =?iso-8859-1?Q?U1oZ1byXbaiCWbj0bJbTiJr30GnvLdhrZ1vqtH/5SKzaBaMMHz72ggX/Xf?=
 =?iso-8859-1?Q?EWv2t0JOYqc4kPDT2so8KFgP/4F0qQJ0TmfUc99fgd9q6P9AHBUMVTa4qG?=
 =?iso-8859-1?Q?XE6uNqixKg/hpbCSQe4CsIyYULFJaxOnxLF6WOf0W66IhHL7K56HxULGIM?=
 =?iso-8859-1?Q?y2X9u83bXyMpkCb2yAGNhScGYjMkIo2dJGKd1XZkpx/4/M03i3a5h/BQf8?=
 =?iso-8859-1?Q?WMUOTmD1LhXJmqquwNus+2BADeGeDidGZe+1MthlNVK09x7a9KFv0LEw28?=
 =?iso-8859-1?Q?SAZnMHE0DkUuldi8K4QoKLqh9Kg14J/G6qIiWs0Tnj98uYD+yJ1CWouHU3?=
 =?iso-8859-1?Q?24tLMC09Ilq2ZZwAGDiRZ6B80mCWIDRw4ptXvNy+nHI2D5MKFfbSXgNq9Z?=
 =?iso-8859-1?Q?8EsmxSYjwUo0MWeR+R2SzRwJpN7AkfL8O0N8rl4KMH7bqeEz3u+twhsK0x?=
 =?iso-8859-1?Q?xV4DPs/g8pDhgaYWw9ILkbU5Q5fIDutTNApTYKWJwht5jqtU2KJRTzZSO4?=
 =?iso-8859-1?Q?3VDS1xueJS+X2Clz7AGG2hi7Hi7SDeTe7Ajy5hujUkbDGiyQPZ9WH0IE2S?=
 =?iso-8859-1?Q?pPo9JnLxx4V104DUk+wI1gFNZUyc1XLixYqcsui97subOSt56CvWWzzmms?=
 =?iso-8859-1?Q?bJnaEgnAqRgi2sI5yvOVw8hTYdWwMXf0iPuS4oISDrdgHy?=
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K+IOxFEubiSMeLOSUR1L8I+lRDhwdk+eAGuys3AKM0D0NPIyOjO+tCVuNkMhGLWq2uXCBkonznjv/ZcVcvPGajjBBTHsSOigxfNA85zlqmxN2iyctFLKqSejUF8iNY56CpLRhphatLStDtZvuitV41BvramuJ1TZx67i+6ozkGzrTFLblyfNUMd6x0rVLTOLl8qOviAePqEHTQ+LzNDg4ayDcEkfG32moyKmFCIuDaM5zEhnDGxRhSSD3wLQobFsfyCUts380FxDB8gSL6HWvxr41GwYFWj/wnUznFuWu8UqQXPj4JEI4vS2O1pm3EmXa9Jub97v7NLRUFV38Ngfgw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d7dc8c-425b-4053-e449-08de85975ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:10:32.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSuLBnsNPo1qIVgVB7/T+7pz3I8Q5N1kouiYkCKrdOoreuw6e35g+DfByDzNB6TLK7RKnHUAuMPT1mji0Rv0Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9475
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269371-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,osuosl.org:email,davemloft.net:email,IA3PR11MB9301.namprd11.prod.outlook.com:mid,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 85DAC2C8889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr






________________________________________
From:=A0Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> on behalf of M=
ichal Swiatkowski <michal.swiatkowski@linux.intel.com>
Sent:=A0Thursday, February 12, 2026 10:47
To:=A0Oros, Petr <poros@redhat.com>
Cc:=A0netdev@vger.kernel.org <netdev@vger.kernel.org>; Nguyen, Anthony L <a=
nthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.c=
om>; Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.=
net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;=
 Paolo Abeni <pabeni@redhat.com>; Michal Swiatkowski <michal.swiatkowski@li=
nux.intel.com>; Drewek, Wojciech <wojciech.drewek@intel.com>; Simon Horman =
<horms@kernel.org>; intel-wired-lan@lists.osuosl.org <intel-wired-lan@lists=
.osuosl.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Subject:=A0Re: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix inverted read=
y check for VF representors


On Thu, Feb 12, 2026 at 08:53:10AM +0100, Petr Oros wrote:

> Commit 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")

> refactored the VF readiness check into a generic repr->ops.ready()

> callback but implemented ice_repr_ready_vf() with inverted logic:

>

>=A0=A0 return !ice_check_vf_ready_for_cfg(repr->vf);

>

> ice_check_vf_ready_for_cfg() returns 0 on success, so the negation

> makes ready() return non-zero when the VF is ready. All callers treat

> non-zero as "not ready, skip", causing ndo_get_stats64, get_drvinfo,

> get_strings and get_ethtool_stats to always bail out in switchdev mode.

>

> Remove the erroneous negation. The SF variant ice_repr_ready_sf() is

> already correct (returns !active, i.e. non-zero when not active).

>

> Fixes: 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")

> Signed-off-by: Petr Oros <poros@redhat.com>

> ---

>=A0 drivers/net/ethernet/intel/ice/ice_repr.c | 2 +-

>=A0 1 file changed, 1 insertion(+), 1 deletion(-)

>

> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethe=
rnet/intel/ice/ice_repr.c

> index cb08746556a670..2a84f656405828 100644

> --- a/drivers/net/ethernet/intel/ice/ice_repr.c

> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c

> @@ -315,7 +315,7 @@ ice_repr_reg_netdev(struct net_device *netdev, const =
struct net_device_ops *ops)

>=A0

>=A0 static int ice_repr_ready_vf(struct ice_repr *repr)

>=A0 {

> -=A0=A0=A0=A0 return !ice_check_vf_ready_for_cfg(repr->vf);

> +=A0=A0=A0=A0 return ice_check_vf_ready_for_cfg(repr->vf);

>=A0 }

>=A0

>=A0 static int ice_repr_ready_sf(struct ice_repr *repr)

> --

> 2.52.0

>



Thanks for fixing

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


Tested-by: Patryk Holda <patryk.holda@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu usta=
wy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w trans=
akcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.


