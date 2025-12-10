Return-Path: <netdev+bounces-244303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC543CB43CF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 00:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 215B63024B92
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0354277819;
	Wed, 10 Dec 2025 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3RI13Hr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C02D3A7B
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408936; cv=fail; b=AbDjzU8d7/fwZrb91HZen6csmWUxTpJgpUyOp4K2JcuOXWtDvpatGZWVPn/HlakNvbYVd1yEU/2GYFlXznXPy0h6sr3tb6Ifz2Pw+MSlEmVoGdm1bMjll27CriKmNoynxPWGSWcJh+WnBCXNo6SWd02cT8yQJV2JpnHv3yQWC00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408936; c=relaxed/simple;
	bh=UGGoTpLyYZEpJN2GMPwu89sbWDIvthaLbuvuJXATrSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uF9pFJyBZUh9IjIrfsMKkcVwoWbpJbXLjZAT5hLTloRoOLLpnGqucv8i7lnGM37ITLfTZJC/deNchvRpSZCfgTwAy7iXO5OdeBFeHZiBAhDcSknfeDhp0vf+ws4jhm14kc+lfUqdGxCC3S814vMzVL/RX3O9Fh3zOuaDqbL1lqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3RI13Hr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765408931; x=1796944931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UGGoTpLyYZEpJN2GMPwu89sbWDIvthaLbuvuJXATrSM=;
  b=J3RI13HrIfPCpsVG4K4UFFsUgE/Q+Qy67NG627zJsny6ixpz7hKqzyCZ
   m/mkgSs7FPk7qNvXOTQdv3BI82C1tNVX0klRpbttsbrDxRVu8ijCEAElp
   RnIDEnA/X6ObIWiWFi4lpKNrZQT+vxIMKpO7NhnCxX4GsapOgq9AbYbYi
   jZ5dtA7ECjd1y5a8f5gbUyyDatIwPJuHDJHRu5bALCFwnO32cBXDpJu5O
   ohwOvdWFfRm9eOhwPrUmZ17YWY5GW6vC06INki0elaoBgBaK8sg4dpUzW
   0E88AFmURuRvBoOhytoJ0f/UiVoeJS74MWakJHL1oS9RP28fOyefsZy1q
   g==;
X-CSE-ConnectionGUID: z9OxwJqrTHWMZhE1IxOErQ==
X-CSE-MsgGUID: IehxHZABS668UPkrZCwQlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="54933494"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="54933494"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:22:04 -0800
X-CSE-ConnectionGUID: M5MrRSPrRaah3DgSxYAZ9g==
X-CSE-MsgGUID: 8tvQlLo2QZGav95+77uuWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="200805804"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:22:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:22:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 15:22:01 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:22:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0z4fyzlPuSx7m+1NG2ud3yQ9XPe9bQOjN+EndAD8fxpB/jVQ620lQhsyq+lnebZjPThfhNRh67EMS6dZ1TP2ISAbyMDPZEn2gNgEFVWArazWTXF5cWn5qmYJBAqgChpBR/9OOPfwE5MKnl0hieXD4YG/nEDTh0yhTiYD3H56NHOIy4EPuqJaUnZQlbHQJy6+72iOw2Q3s1f/ZTn1txX1Z/Hsi7gB/WhWIqveodiayVXZthPEPCNP5WodRDeFlLxLVS+je4hiYTzjOjPnvzoUB/HmgwWVMNgqv724xsBFqs7prB8fp/Y+5gljqt10HjmKO36+9MMzuRcpOnsZ/lKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGGoTpLyYZEpJN2GMPwu89sbWDIvthaLbuvuJXATrSM=;
 b=rjLREl06LWAEFBKoizOq2bWqBaxANWuzZf0O26YyyX7jLjg25KF5saX+UD5CQ5xqlmbykT+u51h7gLI+Tyy73EXF2L5fSb7DCfu4MBArCHW0fU3Ls3/AL3XUB8Pz6xTOgDe5F84twooPdtS+XjBtsh6pfvwL9wgVEh11W6+fNJTWwDJgXGj4IXH4CFlA2SD3zThx39igW1WfzJokqCEZJgLtGMmbl/QuImAGqRhAtiPtGDY8MOqa57LvrfMt19Kem++yoVHITQQWWcGZLKLU3WTkJm60G4vzcfJrQw+l8zSuOk+rnOn2jbNOwKdcWloOtSWQPQ0OM2SsKZMrAKlhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 23:21:58 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 23:21:58 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generalize
 send virtchnl message API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generalize
 send virtchnl message API
Thread-Index: AQHcVDTaeLjvmu9qf0mT83msFxnhWLTwQPgAgCttmrA=
Date: Wed, 10 Dec 2025 23:21:58 +0000
Message-ID: <SJ1PR11MB62977E08B6A8243F2DD1D57E9BA0A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-9-joshua.a.hay@intel.com>
 <IA3PR11MB898642FDBE8D123704A7CD82E5CDA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898642FDBE8D123704A7CD82E5CDA@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ2PR11MB8451:EE_
x-ms-office365-filtering-correlation-id: a871c681-ebe5-4203-6889-08de3842eaa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?BZuASdo3uXIOpl2kDJZQAeWbORs+dZTPhE7DxRBJbKoVLn7mV/+wZgmAz0z7?=
 =?us-ascii?Q?HCnM2954YBee66+HhYCIeY6PKqByIlEoPiwKnBJ2BN3eQqOQAJRhq3r1IFQn?=
 =?us-ascii?Q?wGkTdU3vWmoLOgKHFALQqPLWRLfbr0vVqwMpdqxIzimlZFVaEX+ITcSPbWVV?=
 =?us-ascii?Q?lujc5pgowrSAgPhw1as3TXaf+Fc3XKJQneqfvaw/JPMoNbMcfXmRmXH1IxCk?=
 =?us-ascii?Q?Y5orddCkc/ALysQa+Y2jg2Lkv/vYRSH+pOv9IAQUUi+UuE6z9uimn+069M+E?=
 =?us-ascii?Q?s/KRuntPY1iOcpblrW5R7MpjjN8VIoOrqY5WuCPAM+ElBK5jStyiLK2Qyz50?=
 =?us-ascii?Q?GV+z8nBDU0xG2FQ0RqBYJadiRM4kY4Yxevv4GBYNG5NEqXJD72/Ui+JQ7ViD?=
 =?us-ascii?Q?GsmdALuEraYytjG5+CMqT64jOaNjEmewjgJ/a+qa4AXPcE0dBJxqYkeJutsC?=
 =?us-ascii?Q?Fe5ztYpUDzg6Xw+valc5rjqz1tDUd9LbcWmEKdWmFVxW/PhemNDfVByg7iB/?=
 =?us-ascii?Q?kWTM/2TPre8oHYsnQqujzYhTIoEdBFMzY3eymuwlExYx2W0hRXCtX1LGr5yc?=
 =?us-ascii?Q?G4tJj243nw2mdJnxavtkX8SH1POaLs6cZOAPHul5JpGpNyYSnm1k6l6ZcfO2?=
 =?us-ascii?Q?IzOpmcTosd0UW/OtLknn3x2DB89PYizH/fqQ0DZ0Z83k6/uRTlblma1zOVjH?=
 =?us-ascii?Q?BwiFl20PUkz86z0L20R+P/Y5yibr81KseaNjQDDPdU1AaVNLJgP3B6SG0nvu?=
 =?us-ascii?Q?iHMtqg2IyAqZNnfgXbdEFRZaqliFVZd4V6Wdj4eorDRANeCDjZMExTTnVHG2?=
 =?us-ascii?Q?CzxGqC7mvUHZ6paPQPo0hjydgox/A1jWkmnLx0ExCi9lrP0k03Sl3BEYFb+r?=
 =?us-ascii?Q?dOcxcRsqd/dvuO9GS9DiKhDkBclpp5uILMdlU+8JO739L9XROLI8+rgFSs7w?=
 =?us-ascii?Q?TXmq2eEGgY85V762NnkWfn8Zn3qS3oNqXireMrQ4A1PpOV7RSmyArQpGdZ7x?=
 =?us-ascii?Q?PIy2JmMQD9eG0Hpgm7hMGIwM7WukEnXewAAlXvJZhwo+vEUubBUFCF2tczYK?=
 =?us-ascii?Q?FDkZQuod3wdBwGyJsB1I8MQvB7+7w6ja2e/seIHg0nCv2jyen3FxxtCxQgt2?=
 =?us-ascii?Q?PxbDo1yfa2oafyeaCSa5karEU7PPnJaAsqgdUh9T9PWXwh3Q4D1Vfeuu47cI?=
 =?us-ascii?Q?q3yxN3BWjSEgE+kqEu4Y6gYvF4vVCMeBQTrzdWS4GbxJQcH7ENpLylRXmDYF?=
 =?us-ascii?Q?PZ1xpu6OGdlP2Ln8k3Veqo4D/h+eiKeJi/ofE1YVKQJCeeYoclkT+OSY1+6z?=
 =?us-ascii?Q?N8IoIDPhvxB8x/4zLAML57vRKbKiCg3yYXIpq0cVmQ3LLVsQGnA0Bf4WDAIu?=
 =?us-ascii?Q?UXAFMFrCH0AYPWDLY/wuU+nKJXn3aa2qGcRgo8rHAGHlQhT28gopAXBc30Dj?=
 =?us-ascii?Q?FBfrAroxA6wEqRoxmkeJQAn63lAGqikVU7kZz81w20esmjuo0r9UXdh8DOZk?=
 =?us-ascii?Q?2YcMt3fUMf7gO31GlW179RwLCzmd8Cv54Da1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JBHCt6Ew5unvm+Y+d8rdqHfgmdtlbcc91UTTIwBn4eGrX/eJ3L6CVE7KwhDW?=
 =?us-ascii?Q?lRRQeJ4QJwbB0BNsh/DlLJYxGDmmZCBUh6UQmhyDXS3OUQfJ49iNGjlrL8dr?=
 =?us-ascii?Q?jmLUVFG3gO7dEZusV7joS6tgSsWmn/V/JOJXjlI4G8EuFZg0JxPyjcal6GdP?=
 =?us-ascii?Q?YMD1UZ87owJdJS4wNny85OzZjm6/2jgrUEwW5A2jlzxx43SGKGUlysBZZauu?=
 =?us-ascii?Q?QZYJGbqci2atadf8i5x+CWTRJrWAKWUPg6mzDAZzfHuTvLA6RidU+x0omwG/?=
 =?us-ascii?Q?tiOhEiJX3iVxjkj0Qnl3e55YA6SxSKdjJrhHyj8HgrnB+zZ1IHumIBw6U71r?=
 =?us-ascii?Q?oODgL3tQl9RNTiqf27k2M7AMuPJYl4w/VhsDvrzfFhDLDdZBT1dH+l0YV/bC?=
 =?us-ascii?Q?aT61xY7LMT2C30M50wmLXshUVYB3CQwL0IkcLx3SCFCr0o7na2O0UdUk37o5?=
 =?us-ascii?Q?gREI8YJQ2fSTOq8UzhEQjyKmSGkY/ZWXO5R9kDDAg/+SdMMUdyxgJXaqhmSH?=
 =?us-ascii?Q?gKIvX7mf3Wop3D0TTRSSzy/oiZle7nQ1BoY6hF6odMuPUU8CxUs7QvMAiLwi?=
 =?us-ascii?Q?2KH10tA2nKdxH6xBgJkwThoDgqtqWYdeION6ScX5qfdBxfrLFREjOEg084EA?=
 =?us-ascii?Q?A/42fJ6lpKCiGvuMFhDlsyLAHPlI01YY7IF0iVGz5kTjmK8f7RNrKQir+j1t?=
 =?us-ascii?Q?DpEriOVrXkKtSgGwJtOC7xi1kxQlitEy/viz5AUFt+FBWYCNdzKynzhyXt+8?=
 =?us-ascii?Q?0e8L/MrL43WtfWQJkHzXt5hr5wyYfPw1vrt9W91UY/Z6S2drr2MMjZVZ/CtZ?=
 =?us-ascii?Q?6k65I+O6oz0pMXAict0A24XRE4ZfqrBj19AtruAh2qBNIC6Mjrw67yY9yGUo?=
 =?us-ascii?Q?ro0DelcUdC20eaArkDmeCdzN1gAmdhUcm1KvN3lNuGEm8k6CzRNFcGZW3VUR?=
 =?us-ascii?Q?XqMBrEA8Ou9fZV+Q5wsAQTT0c6q5rFiIlutKNMWGNy2cteo/uTH2TGEBc3qJ?=
 =?us-ascii?Q?7IbZbykbTVn7AnL5G+IycjvNlHfD2B81yzfo2IB7n0qj3q2nwFcTV/V+nOCA?=
 =?us-ascii?Q?9wy+5ad00+k2S/uPJtZ6Okh0gHljsJqdLTMUk4/EYJmwctVf/nzwb+v3gznM?=
 =?us-ascii?Q?rEtW2BJ0Ss/cUBX8lywGpHBRccW21pUQsz7UNogbbwEV6dzDNCuA4UwobnDH?=
 =?us-ascii?Q?DbMGDeVaRmmJaDTdPDsgJ3YDmEWAKyha68UAJ98KgjJ4YslEWZ2i8i1na1Bn?=
 =?us-ascii?Q?OjsZNFYJG7fJLBgN078r2hFn782QYS2uW6RTjUp0DNidiGV9b442Ra+3rhPz?=
 =?us-ascii?Q?EXZuUaYj54TIzUNyK2MzWz9J+ToLJXRMLdZQKCZwEbuB5Wfe+fnBrBsxTZU2?=
 =?us-ascii?Q?aYQKJzMBIHRySnBfzrakBRsxvQZ4Zuprl1zI059pTwhTpbIavvHDYyK/RMrh?=
 =?us-ascii?Q?JPY4wqofdDDQy7aRPXpJOZOtneaMeRzuYOM5/YiPlsGDHtVv9fpfbAtdnJrY?=
 =?us-ascii?Q?LxVpI2JMMcAuyy/giMHJrHSg5dlVrOoCZXLVkjcJrfOOqSNCa5OX0qIC+o2X?=
 =?us-ascii?Q?SzZ/AoO8Z4pZsLBiR0d2O2rEOws6FCpbVOl72SyZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a871c681-ebe5-4203-6889-08de3842eaa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 23:21:58.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyXnGeI4EKASgtjHBr0lTRjhKcYgEw31jZw0bL0VMHBiQQYtl3QaUmgxu+D74Tsy8jAwD9r11UNTfZ2rUAfOjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Thursday, November 13, 2025 12:08 AM
> To: Hay, Joshua A <joshua.a.hay@intel.com>; intel-wired-lan@lists.osuosl.=
org
> Cc: netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generaliz=
e send
> virtchnl message API
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Joshua Hay
> > Sent: Thursday, November 13, 2025 1:42 AM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generalize
> > send virtchnl message API
> >
> > From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> >
> > With the previous refactor of passing idpf resource pointer, all of
> > the virtchnl send message functions do not require full vport
> > structure.
> > Those functions can be generalized to be able to use for configuring
> > vport independent queues.
> >
> > Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > ---
> > v8: rebase on AF_XDP series
> > ---
> > 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

