Return-Path: <netdev+bounces-114394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3793942570
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAEF2839C0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E11BC40;
	Wed, 31 Jul 2024 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jmlCaKuh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zTCCq3za"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1828182A0;
	Wed, 31 Jul 2024 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400179; cv=fail; b=ZdW90N28MsLskJGybIa2jsKlqilp35l8ULIchCe+KNiPhsSQteQ8oZHk4DUMThetIMm8Mx6Jbr2V6ektNPzLkHOhx1ocACcBKPPHsii7fRLR7xQW/Gse6omNPaL6zk7rHafA1SKJP47/xApQUQcqQgG+zdDuAx2FsfgXuhp3Hjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400179; c=relaxed/simple;
	bh=9AMIqd/B+TbSTV6zjlGor5nYTvD+zif51vmm32qVhwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PR7LhI4j35C5dzzSf/lrx+Wa7qZG8TFds4BnjcSbIrpk3opy/iQvFo+UzncSWrW60jTxIJ29Z/ZHz0LroYt0PeOz/lE4WGCdxIxtciPlgn1c6Fphjb92pF8l7l5gdOlLzEP0BYGzlTu6Arw4xrn5xkoE25osGAG3OMONtw8w6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jmlCaKuh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zTCCq3za; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722400177; x=1753936177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9AMIqd/B+TbSTV6zjlGor5nYTvD+zif51vmm32qVhwU=;
  b=jmlCaKuhl0YPAv07dDNqwB4zfbjnaph+9NG2J/IhYJ9r5vdm7jWES4RX
   52wlJjM595lV7TeH/vUrTQ/RlNCGey1bAIib29BLlkXYlXHLt8baU31cJ
   UDA+64sX2HvsVO8vI4qOlmsVdGBFPLJh7wnYf0e6aTFKQXOLyHJlJLW4e
   vTdN0LF3QJD7jzbQT1HlgAMdUz3ROC/yTrZTTgnhX/ZvvKcf+yxCPO1TX
   ggsl09Ouvv+ecfYpAU8ZYKDHgdYJvBtbulb1p+oSQIOCNRaPpMAoh/M0k
   H5REXegr3OfSId/3gTulIHjn0bYDPQT9kfgu5bbNmLCwXkSRl/F7mxkbV
   g==;
X-CSE-ConnectionGUID: VzWU8HS6SgmplWRbmh17gg==
X-CSE-MsgGUID: jx695DfQSYyuO7XNfEyvIQ==
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="29899651"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2024 21:29:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jul 2024 21:29:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jul 2024 21:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4ck5RDw7fDriAuhyj1n6nQgteOOsWHqk9xqZM6OtiTCzy4hcLxG03D8y0WTHOdEUZL+2tvjpn6Idv9go+x2GH9G2HdxRzNNCZTem/d698ZQ3oJ5yHWkdtTxs/YkLnOBo4JBgWxdAzZCZpHh/AzcKaGIMAxZ7uLY20xZ7gKbU0GjUVf3/9ORtEhVVyZ8kYb5DUmV9v2zeXJyWuWMhjhil/j+19MOXBnBhREumssdDQVl9QYZ0fGctyhu17qwBJtgb7+tZ8nCCB/CEgDVzdAs4uu5nG8dxzssk+FkcF5Ar9HwmbWvRCZ5K6meqbvarkkVkVAHLGeJdnphEOFuat2Kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AMIqd/B+TbSTV6zjlGor5nYTvD+zif51vmm32qVhwU=;
 b=W5/C+8L4dLV2QhRrpuTt3Ai5NhHhVYdLJVY41HxTtrOGT4koZQBZrl2nZUFDy1DW1JjGHrgpVXIoOjbMZPFhJgJ1N8+EPhrm3aAec696q+WaCH0aZCg/zpg4KLlQTZcMXSHS9ARgYmzP/Camd9uVzXZI6EQZe62TZD5oZADBBZSPYk9ATM9bn6gfN/zPRfAWoHf5gpvvG1pR5H10qjbAGsIBpaGNJzGHPua6Lv/UYb4iQdmXVREZURepMOVVJcyF5NbxhPhrT2qypwbcZsm6k6SzP765CIT2VG8tqfS48ffx6S7d83m5AQTJZ1TCawMwfkHvAlI75/kTmFclilPzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AMIqd/B+TbSTV6zjlGor5nYTvD+zif51vmm32qVhwU=;
 b=zTCCq3zaEeg6VTHlJJPKYbvl3VfRL9vEMkqYSaFFiIpxtcsjM3RlZ86Yg9wWLENp8k/ttG1L5f5xw4mMX8ZvH+RIuAhw2fpXaYGOPsfFzhJ7QeWBejalhCD/zYz6G0ROftMB3svemc5F0qiVru7qjWP5MO4+piHeEUByUK+xwkoSSX+zj76H7aOUdEICldmAYuGwdsXrURvjBGw0Jn8BEGz1y7xcR4+0AfU3DeTyQhyIAupKx3lgkB46lEyIHExksuROaBscy3gysiMGK2uFBxydl0fHyGbay43w8fIZIWXx26FkVAF8PLssgI+nDMMlspJC5MgzY0vBM4fZxnnoQw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Wed, 31 Jul
 2024 04:29:25 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:29:25 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <robh@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<Horatiu.Vultur@microchip.com>, <ruanjinjie@huawei.com>,
	<Steen.Hegelund@microchip.com>, <vladimir.oltean@nxp.com>,
	<masahiroy@kernel.org>, <alexanderduyck@fb.com>, <krzk+dt@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHa4jaU+UIiM1HAg0yLfnMgIkEo4rIPYqsAgADdS4A=
Date: Wed, 31 Jul 2024 04:29:25 +0000
Message-ID: <db9dccf2-8d31-4f1d-af94-1616d833637c@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-15-Parthiban.Veerasooran@microchip.com>
 <20240730151710.GA1279050-robh@kernel.org>
In-Reply-To: <20240730151710.GA1279050-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: 1cc8532b-39ac-4043-13c9-08dcb1195bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmozQ0dWNzRyVXMwMFJyckxmVmQyM2x1QmxzTGErY2J5NUc3NGREUnk1dEZT?=
 =?utf-8?B?anF5dXVqdndBZ0hsaDdhQXFEOXgxclBpZ0c5WGIzQktqcEtmZG9nNFRkaW1t?=
 =?utf-8?B?aHpNSG5ac2JLb2pQRGdIdTBmU2swL2t3c2VPRDFlc3A4ZStSTGN4TG81dWhz?=
 =?utf-8?B?OE1pc1l2blpHdnRpRVlxdjlReGN0anR6NGdFM0hEdWMwSW1pRmp4d0VsalpB?=
 =?utf-8?B?M1UxL2hhZjRZU0RFZzB1UmRSNjRkSEpuZTI1VnpoVjdWZDJUY2JwaUx3MHB2?=
 =?utf-8?B?QXFybDdwL29nSXd3QVBsUFF2ZUMzR2tZRkJYaUwrWDdUbGlJV0t0SFJISjNV?=
 =?utf-8?B?d3U2U0Fkc0t5cHZRdnhLOFluNE1vQm1mNDYyWHNGQXVTS2k2SXR2TnRmQ2pN?=
 =?utf-8?B?cjdKRVhXTHc2SHVwWCtSc25FY0lhcHk5NVZNdEhzM3ZnaEg3bXJUMFk4RS9D?=
 =?utf-8?B?Q2xNY0FBSWUramdjcTNXZHNSUFpEOTlJOCt3ZzUraHB2MVdYMlFuM2JCR01a?=
 =?utf-8?B?WXZTQnVMTmhjVEJ3MFlLcHRPYXRRRk5nRHgzRmFDZ0cwd0V3OWVtNXVJNEFZ?=
 =?utf-8?B?SUFodlNhS2U0bUZOOGtUZVN5RGVoRzM1czZQWS9xajA0SytwRU5TaVc3UGNw?=
 =?utf-8?B?RExzcGZzaFJ3ZFJTeG9mOWhhYjhHbEdDMGg0R05VUTg5aUVlYklBT1lhc3kr?=
 =?utf-8?B?c1VDQmllNHpIcU15bHZVN3J5NGR5TzJYdklDZXh3REFBYzhXNGdzOW9Kdkcz?=
 =?utf-8?B?OWRSY1lGd2xMWElabzlSVDNlSUk5dWFIZmRicU9zNnJmV0RtRVp6Z0VLdEwr?=
 =?utf-8?B?QThGKzN3VEFkTVNGcFlOa29ZTUhLOW5HeSt4d203bzk3K0tlcVFlbnVHSmtZ?=
 =?utf-8?B?U3N6VTBJYXlDUHJnOG9tSFQrQ1I5cW5ONmFGdFlrdG1VTzdqbmczOFMxZXZo?=
 =?utf-8?B?MnB3czhWc0JFb0FPZmptc1daY3hiU2Y1TG9yYlZxMngrTkRJQkdqYTBOSDhJ?=
 =?utf-8?B?aHU5STV0Z2k5cTFjMlNwaW5CMWdFZG5NeEQwRWlpMFpKUEp2RENiUFgyUmd4?=
 =?utf-8?B?MGlEMnNnem1kVE9mdm5NMmFpTVdhOCtlVXZ0eE9ZcnVFTWZmelZYckxkODVi?=
 =?utf-8?B?OEwwcS9vOG1Td2ZlczI2MGp5MGQ1Q1grbERuQVkvampXblpXYitpY1VVNnkx?=
 =?utf-8?B?ZWV2ZFcwTzg5QWxYbWxHdko2a1IrUWtETXJKQ1pEOXFBMDZVd1NLWXdsS2c2?=
 =?utf-8?B?N3JjTm10disvclhJNmwrdmlXUjNoYVRuLzRiNVZ5aGgxajdSR1BpaGlOZ0VG?=
 =?utf-8?B?ell5ZytFZWRoUnVmU2NBVGpNTjRTNDVBQ1Z4eEplZTBFL0JBL1RQekZ4Q2pY?=
 =?utf-8?B?UWVyVE1BTHlVejcyR09sVElZTFZYclUxSTFwa21LV0ltbk5MRXdsaG1NbU14?=
 =?utf-8?B?T0xGSHE0OXJVTnJkVU1LNGFQVjl4RkNrTWhhSTMvL3FrOUNmdkwydmhrTWIr?=
 =?utf-8?B?aWZ6MTNaSS9KbWN2Rk1KcTAyS2ZGclZ4QnVQV3dWTGw4RFJYbzRTOG9ZMFg5?=
 =?utf-8?B?TFlYUTMyYlRXSjBFN05IZjgzSWpmOWUyWXlISkpKYnpOZWVOTTh2Vy9lbWIy?=
 =?utf-8?B?VkNBa1VnaTArSnE0QzJFT2tJbDZsOUtvckRYUzFCV3Y1SEl6WkhKTmV4ZlMy?=
 =?utf-8?B?ejFZN283d3FuVFdveU9hL0RqdXlHTEZ6SXBEVnpWbnRISi90Q1RWOVpnRDVv?=
 =?utf-8?B?V1V5VHkyVWQ5Y2lscUptamtSQWVSOVVhcTl5QWcxUk8yMGdocHNLY3JIazFh?=
 =?utf-8?B?WFhzSjllWDNvY3RDMjJGUWRIVUJvUEdYeUJFb2d6MHNETzVKL04xd2s3Q0Rt?=
 =?utf-8?B?eWxJMlljbnpVUjZDOUVLSWMvRm9QUjAzejhDbnhIc0Rjd1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2laZEV0OUw5YWtSQnJDNnFoT0o2TVdHcGJiV0YvTVRqWEtjZ1pqZmNQcGw3?=
 =?utf-8?B?UHhQRGdzLzVNUUxzdVNpcHhDV0hVWEdqT3BVZmEvQytQbjkzdEp6VkpWN0Ji?=
 =?utf-8?B?QlR4RDBlNVVEVUk4QWI0RWhEOElhZWlRZWpKUW5yV0JTWnB5VWV5ajNBRzRn?=
 =?utf-8?B?VCszek1HODlmSExaVSsyVmRES2hWbG1IWHRuN29LSlpITGpES1dFaHVhYXNE?=
 =?utf-8?B?Tk1ZWGpRdzhTVGttOXBHL2dTblVNbmhramQ1WENPazlpMlVjRU1XTEVxUnZV?=
 =?utf-8?B?QTh3N3M1cGM4UFBoMDl1YzUzOTlRMVJtMCtDMlBRUkRSa0JFWGovTEdrMUla?=
 =?utf-8?B?bzRaU3IxMkJleERlKy9oVEw5eHZkMS9Hb0N1NHFsUnhDQzZnTmtMUUp5cHht?=
 =?utf-8?B?bkw3dlJ4U1N6YnlyWlpkRDdPRG5QdWg4U0RLRVpJN0RGYWhOcXVEUTFTWDNC?=
 =?utf-8?B?MTBLQi9hUVJweXBrUFY3aFJlMThnRVBrbXBiVCt3TFF1blBkcWZ6Z3BmTGFI?=
 =?utf-8?B?OUxDcXhwVG90T1ZBOUVUdzQzMGc1MHh4bmFPQzNzNlRnQmNlR05GckoxQWJ2?=
 =?utf-8?B?d291S0NvK2tDL3pzYnJtWlhVRkV6bzZBaU9CYlpNRm9QaU5DTEZ4elR6cUE4?=
 =?utf-8?B?dE9sRUM4bWV4cTNRVVF5QktScW14amhGbEN3cG05ZXNrZjlDSmN1Wm1zYTVr?=
 =?utf-8?B?dW1tR1plaE9nSUZ2RXVJTnNmeEdHTjB5OGdUVTVqOTYwVktNUG5RYXlzT25o?=
 =?utf-8?B?Tkc3aHBhaFhJdW1RQTB2RlRSRDU4aDJCZlNJa1JXL01SY1RVWVphNFVZTkFS?=
 =?utf-8?B?K3VsOEU0bW5ieVE5Zmwra05jV0cxRkRuVFF5V2ZxeG02bW1IOUhFejN6Mmll?=
 =?utf-8?B?S0JRTWtTWDRQZk8zWXUzQkI5bFl4RGtWZENoeENBZ05vQUJLeThPcnA0MW1o?=
 =?utf-8?B?ZjRhK01tcHR3blBZT2N1NWxsUDFJTGxZRlRCb3p3U3REYktsUjVZbTVCWFF6?=
 =?utf-8?B?dGpFRkdzTE5pU3ROcFYxTTkvaHBEVFJqZDBxWnNTcU4zSC9qcGwzUThRSFl1?=
 =?utf-8?B?MksyeFRsdmxLL0pOTmhZRy9TbnNScGlxL0xzejJSMUZVMEN3cHBDS256MzFL?=
 =?utf-8?B?SXRpWVlsQ2U4eWRvUXUxQ2F2WWRZSHhLRmxlZDFsVXdRRXhseStaaFpERTJk?=
 =?utf-8?B?K0ZnU0ZJRGhaZ2VRUFRJRFdWT25ndnNFZ1NZWTVnNzFvU3o0bERFMy81MFZ6?=
 =?utf-8?B?cVFjdFZMeGdmRkFGYlp2bjBiaS82U0FBMk84VDBrUXFUTDJFOC9Oa1BzUXgw?=
 =?utf-8?B?VWhvRldHNUYvSldyeDlyQ2luYjJxOTI2cDE0U2ptUUlhQXdEWUVNQnlKeWpy?=
 =?utf-8?B?MW12N05rS0xTSlRvM3pBTUF4by8zVWdjK1hwRVBWbWdrbjdtVXlIcnpnaG5N?=
 =?utf-8?B?SGR1K0l6VzJCYWxROTluV0F2Sk1INWdhUE5lWTRsNURpL1FSZjdTQlRITDFI?=
 =?utf-8?B?cWZKOFJPNVpqc1lMQjJIZC8wNExvMTIwekFMakRzaW5Tb1pxQ0lpWUdmMkhV?=
 =?utf-8?B?OHZxYWNRT3JtdXdnYzhtNEoxazUzVlZwY1RGOW81ZEVrZkVPdVJPcU8rTUx1?=
 =?utf-8?B?ajNSNXY3WDhkRHlYOS9DQ2l5YXhac2tFUGJNNTErT1FLNWZ4djh2eFBYSm8z?=
 =?utf-8?B?a0Nxd2FDVjloWExtN0FrR2cxaVYyVVNPbDFmUCtydi9MSk1hcVhXd0s3bEIx?=
 =?utf-8?B?a2pGelhQS2VMWkw4c2lUWkxpYURxcmhKMk5rOFc3enhmRUZGRmQwOW1VWThK?=
 =?utf-8?B?bXduYnRFNTNzVERkcjFsRXlhemxnb3hLZlYrQmhqb1VWZlZaVlc0dTE3ZE1H?=
 =?utf-8?B?K0lYbHM3WEZXbzNUQ2V2RDIwU240ZlFFenY4VXhJL3JDNHRBdE1OcUVJaXo2?=
 =?utf-8?B?ZFhtaTZabXlCc1VmaHg3QnZuUzFjTXpCOEJtTXFQSkJvYndmU3plSWxUZSt1?=
 =?utf-8?B?WlNBSkVRSE40Q2RPK09KVlJxNzVkR3c3aEpBZll4Vmw3YmNVVVJuanhMaS80?=
 =?utf-8?B?bmlsaWNicUJPaUpwZVYrKzAzVnhteXVBRGVCdHJhOUdzTkMvUTFWUDhBbmd2?=
 =?utf-8?B?cjI1d0svYllKUTB2aGNNeFhwK1ZhWWZUUGwrR1J6bWlMUk9rRTVFSVJ6UGFk?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E51E5BC2EF8B914595CA7E769F208524@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc8532b-39ac-4043-13c9-08dcb1195bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 04:29:25.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehKIurAsmDqM1DaP9pfOqV9aR2VyM9jFQDMsg1eh36NSD13wxo9LA3qKkt8y2qesY0WxIbZ8JDeSU2x+SejfETtGpjlcrqpWCgh2xZbHbUuOEvXEAAzBr5Ps0NsPb0sJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078

SGkgUm9iIEhlcnJpbmcsDQoNCk9uIDMwLzA3LzI0IDg6NDcgcG0sIFJvYiBIZXJyaW5nIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgSnVs
IDMwLCAyMDI0IGF0IDA5OjM5OjA2QU0gKzA1MzAsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90
ZToNCj4+IFRoZSBMQU44NjUwLzEgY29tYmluZXMgYSBNZWRpYSBBY2Nlc3MgQ29udHJvbGxlciAo
TUFDKSBhbmQgYW4gRXRoZXJuZXQNCj4+IFBIWSB0byBlbmFibGUgMTBCQVNFLVQxUyBuZXR3b3Jr
cy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2VzcyBDb250cm9sbGVyDQo+PiAoTUFDKSBtb2R1bGUg
aW1wbGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFDLCBjb21wYXRpYmxl
DQo+PiB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2lj
YWwgbGF5ZXIgdHJhbnNjZWl2ZXINCj4+IGludGVncmF0ZWQgaW50byB0aGUgTEFOODY1MC8xLiBU
aGUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIHRoZSBIb3N0IGFuZCB0aGUNCj4+IE1BQy1QSFkgaXMg
c3BlY2lmaWVkIGluIHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbA0K
Pj4gSW50ZXJmYWNlIChUQzYpLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXk8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBtaXNzaW5nIHNwYWNlICAgICAgICAgICAg
ICBeDQpBaCBvay4gVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cuIFdpbGwgY29ycmVjdCBpdCBp
biB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+
IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29v
cmFuQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2JpbmRpbmdzL25ldC9taWNyb2No
aXAsbGFuODY1MC55YW1sICAgICAgIHwgODAgKysrKysrKysrKysrKysrKysrKw0KPj4gICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgODEgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1MC55
YW1sDQo+IA0KDQo=

