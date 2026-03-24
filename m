Return-Path: <netdev+bounces-270935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O6pHe5QwmnNbgQAu9opvQ
	(envelope-from <netdev+bounces-270935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:53:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E6305135
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12073305D62C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2FF3D9037;
	Tue, 24 Mar 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKpcaYjk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AF3DA5C1;
	Tue, 24 Mar 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342099; cv=fail; b=k6Z+pNyuVCVpwkb5HdqEo6+Zz5qF+oj8tR0lz/TLk27GIi/4c4gC1+ueavMu+XdYgWHkSHU313kZbbXzvDzU4u4QSty9SqRs7Jv6D8VPSZ6+kAjR30N6OvDteHU7zzI32sn8EOG6/lFPrZ7JXrsdO4vmwzt8JcExA6DGnujHrT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342099; c=relaxed/simple;
	bh=QiGKGNtZt2PCZisDu4eAsqDrCWnN6S1cSJvIGYicvg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ON/wqj9hQlRgNFc7JNV53TJdmvYYC5J2Hw+QT0oE7KS0WtQIM1cLYjdD1JMMS1zUn2m/tsfuYLOyNKZF9eVuk+Kn1O3mewmX1LKO6QVfpqsZnyn9/JFCw40MEDJCCWgRHdIdKFYph4v2Qwn6pPuaJmZ5hMufsX92x9k2VYYyNY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKpcaYjk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774342097; x=1805878097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QiGKGNtZt2PCZisDu4eAsqDrCWnN6S1cSJvIGYicvg8=;
  b=YKpcaYjkMto6SH9xUuH4wxP2e+xOsYGd8NWXA0FHVgAjcuSuNddBewh9
   ip2vmIEGdVUJEHdEsT5K+Gxf8nBIZzoIIORgd1+PEL9Z84teva42Isnm+
   CbLwAa4rnbLHx1Q2MmLbkjgDJPKLrBb+TJTSPU9mgv54ByY6P7srGRm+X
   H9BPNAUetpzRIRLDf3goL9yicprH+3T+bVksbBULTCZheH5+Ag8/h67xl
   qK0DZkqeIlwa66veMGXQm7RQzoKajIf6SOviIli5t+afHEy8HaH3+GhCx
   cCDyz8Ko4jZ0ag57aTxV2ai5NhVtf9T3Q0L0QUmemdINFrkmRFDTQKWl1
   Q==;
X-CSE-ConnectionGUID: ncLg35W1REKk/t+sWrGPqA==
X-CSE-MsgGUID: HidRDkniT2+QGxJREsaDvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86721288"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86721288"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:48:16 -0700
X-CSE-ConnectionGUID: VAdDE13wTkK1nKTAoCgE8g==
X-CSE-MsgGUID: F7j8g8n6QMWOnKy+C+q3Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="229220736"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 01:48:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 01:48:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 01:48:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 01:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtWrujr3RatgaDLApZoTGdh66WaOcwQGWWlr9LMjoyFqXJ6ynPUlXMP7OcTSB5hqpeIjKi/mk0izT1jU+pq2D/89SStysXlr+w0+M/R1hxGDIElMnZxmW6udzKZc92z32hfssfcrHb4t5seCX2uKsLXTc7YOx1hWxWWRRRChOed964TlYRHphCHyZcsXB8ai2keJx57/OHMwWrgTsbVJlMFU+9Of7+BRso2JgavDtNP4ipjNzvVUfdbn3DzX74vEa2FhLJGJKp9rq5nVoCCbMm+t96UJwKdms9w81Myb9qccw1SHVn6g2Y9CO0hM+Mcc0yNX5pqKo6OUVpf9Mb8p2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lRk8lT/JMYWWA3sd68jrDSgdi8vqnByG0qMD9K0zJI=;
 b=RNyaciJJSTPhB0bmbJ2SitVuj9ZSMjcDS7OBsg9Nxab7hdOJL37QVrmz8wSjSkdA+MGkV8F3odIdV/Oq88xH3R49YoX6D4n4RMDEWigi1tuKLsxq9OSfNzBB5RP0z7X2d0FKGa+XKL8MEo6bXYTpjv0HUYeJ/5nVwn3i2MQYmu6leROlml1EXw2SEcyn+gjto14mfB3BSHj+iY8i+cshbWaI00xMtaZJhrq0C5qtMaGSz8Hjh5NoZdvpMgAvaiECQJLH7t8uAQaAG+Mi8upqeX3EwiUpwcbLVJUw1X4Kb+quZcVUHr0doPc8TZggUrP32UmL915+krMD3/HEsOH9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:48:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 08:48:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matteo Croce <technoboy85@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
 XDP_REDIRECT support
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
 XDP_REDIRECT support
Thread-Index: AQHcuvLz67mnVru9XUG9XM57cAylnbW9X3Jw
Date: Tue, 24 Mar 2026 08:48:06 +0000
Message-ID: <IA3PR11MB8986307A14724905DE2FDFF6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323182823.5813-1-teknoraver@meta.com>
 <20260323182823.5813-3-teknoraver@meta.com>
In-Reply-To: <20260323182823.5813-3-teknoraver@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7534:EE_
x-ms-office365-filtering-correlation-id: a9e9f8b1-bba1-44a9-83b2-08de898211ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: S/c7Rccy0aAkruxeT9J4kA6pbPUrqRhv4iXFX9oywKSQiswUr/Baye5uI74KMcRVCIr4skZP4FJSAniqSf7rNA0KfypAca8xC45wSZCFdx9vjd3tYSAT8x4GapCJK4yQNPVUG7ZyXzq9G2XA44w83q7HrhJqrl3Zy/+pC13r4hUVg5041rSvEgOTjuobsU8biiuTkYu/qKA8i/bt9NdJlK6bjMx14SO+ObDCEPwZRQitS1ALplp1W7oXG9sBlDH9ccCVvsYfIyuPqksrpuLvZaTdZuxf1CyjC1WXL6W3734pINg/9YObpQuTfpIJWyAKUrmNn43CPdKt9d678XfjoYP4bKzLwAnZRINI7Hih7MZHgpaxFMIVjz2inBvGB6K3MP2pMD/l5//B6uNbR5ig88ERVww7ZI5WHj+qf4bZu+9p9vEgjT+QCLF5y6TlfJMTwu9pS85x9ba47g2pQfaJPud9HChp/p3LVqiHyqr7ZhZeZq0iA0MC26ZynScIIeeWL0tBgrhjhirm7oefqsnfySX7FIMC335Qq6NKg2EHEKIzyuwhX3N7maoiZZ6KDnw2Dgeqp2upAW6p0Mu4qyzOj8fC1golnqGvMohHuUulAC3G9zciczGh60hzJm7zTqTl6GpVghAoW1bP9XB/xQeBVHD48SC2shs72631uRfP8qRO0ELtN/KzPcdFyx21ITJKZQTe41cUwsuQqqNp8/00LOogspxEa4AKZc1OqpaLKYeA4+oIclqagdOGZZcdj4kffC9AePgLEirZeVqX76RWXVZI6ca5KhUiFJgH1GBXyzKMxi/y/sINYAuIeeyApXrs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cqxmKueTssaOzSqa5xGGFKRY6KSt9jIDT54RxpTw0cyhIawU6+ehb7qvINrw?=
 =?us-ascii?Q?vbMkc99oRvi77JmFynKDsfnkGL1UVun0h4cPtVjb+Q6bS7T/73uetoz4Vig6?=
 =?us-ascii?Q?lowCrIFJDv8kgtI3kpyd3KNrxTxUlJrvKs97WDB2Elewf0U7yTra+r4qQUMM?=
 =?us-ascii?Q?/h14h+AUdiL3zZN2IjRdTe057+t/SdLPLt7cgm1sw4bIK+9MQnSyXAPzoe6y?=
 =?us-ascii?Q?O12Zzi+S4CbRZYdTWMJVspiswCanymKfqivuNjiNFTYzQq9rgdEVSyqF5R/r?=
 =?us-ascii?Q?t5HoqWhp8PIb0GsM+ZyFwo7zzsXtRttzhQbcTZK2W6of9np6ZU3Bc2EQGPzu?=
 =?us-ascii?Q?k8QvC3APBrSj/nfHOOJSVHEQ8624f0WmDKZEUYizEkPjpLnO0FtRjkwEw6Im?=
 =?us-ascii?Q?Rv84pc9+olQHLJP/PSbx83w8MqA1QKURo+AqlwtM6AbqkQ2jopELpQRSd23j?=
 =?us-ascii?Q?f/KD938LB9IIzf49DogJX2BcB/Ap1FzoLdPnmRPjgdaPb5DhheWaOubfS/TS?=
 =?us-ascii?Q?6sU2eVzfbkOfwYSTMHUg1t90oZi2qbiQMndPxc2lAQP1GgiSxnFkXM5jOs6k?=
 =?us-ascii?Q?pSeFbQKN7kCT+YAeA5hRlELl9JqRW83AVpGgE8MBqyGFYlY8UBrE7EfzleFf?=
 =?us-ascii?Q?kKiuwv9JJoZKvpelFJiynXzf7iD9NwiYl1iFDt165XahKL7jqlt42GIMdThz?=
 =?us-ascii?Q?mUw4bt5iQvBr4QACNVCcC4qvxp59q99tVoiLyEiyvVgxGgzxcz4WTUGTI6E6?=
 =?us-ascii?Q?B3wGijkIgTeWgwkLZluHxc1+9rsS1gO4CFWjUBpQHoSUBDRg8C7EriDJJunE?=
 =?us-ascii?Q?M9MIFKoT9CwV4yTAZCV0G3mXvlIdQYNRIXr/+7XkhyUlknPzuSnFtzhzwTMI?=
 =?us-ascii?Q?s0qkmfJyvcrpbAo8RZSIFG6E9Am9krPh+MzCPAvulNjfUIIjbYHuPtgKzQ91?=
 =?us-ascii?Q?I0qJrCVhfivFQD17bGE6Cl2JwhraGR3tVBvC41iQqXkRvAphDIUia8VUVV3u?=
 =?us-ascii?Q?JDRYwRwEoIIWAXDw6U81wNxaHseXRKl8x36wIwMbGc4+eKU1o5FwTDKAK3TD?=
 =?us-ascii?Q?s7EdTXRacVA0drDlqapdq4LRCcnp9ql0PuYbCD1ys6MrajqGFHZMh9einzxE?=
 =?us-ascii?Q?y8hAh5SRinO1x5j+TG+WKauyfqbeZu3kgk8QCTKjd91q6xknyCHuWwi1yLxC?=
 =?us-ascii?Q?K0a82h4GF3Ulk802IJ45iIpKNrUxbZ6bG4HlPqrblQ2mHS7mcd7xmlEnfw+5?=
 =?us-ascii?Q?qu1ci1OaciuPuFu5bLR/eMWNUdfMDgvv8aLSy7ZFMlhlPPcf8YUuYTLu8hHd?=
 =?us-ascii?Q?w7b1yE+Rde64Lwb3rgvpB4mFWnXV35cTcpBqW7qmS4n+FynfKdV/fylwUkYD?=
 =?us-ascii?Q?RTv8mFaFBq5QANy0HAjrOfxYbsDMz4v+76DmJ3F4iy6eYimbYfKYAQLNCfX8?=
 =?us-ascii?Q?qfQJVjmBDrgsv/H1vdk9RIEQ34jRHfroLKeNUDI+Vd4kYkcJ07K6CrKyUN86?=
 =?us-ascii?Q?ybHF7rkgFdLAdtt6DYAHIxG26oPvlQ506XLcBbs59y3FIgl3pBEKxskxbs2/?=
 =?us-ascii?Q?h0m2GPRDzUfXS03T+rAh5X92m+BvL7dTlKRTtGCccC6kBAwX9gV9TVq0wito?=
 =?us-ascii?Q?LNeEvzhu0ZgQ3eg0anOpbuprXAmNhbWBE5rPzRpF5D+eBXY4va0BLXtkxgQo?=
 =?us-ascii?Q?jZj1AzKUaqy1gXLgsHOTT9+3r5mWuYu6df/JQY7sYzbf9rVmNq8O4HfUiypE?=
 =?us-ascii?Q?ZFh+WBMkSrFOGHTdtsTH+MuI4Ew9US4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: khU3YgdQyfSzBYRZUqNehfqBA+1zHxbar5ZE0vmmvPLpbNRf5hwoS8p5t2nXeuKhSAu5cCN+P23pIuMIldEQMNpJLyr2oxuuWHIXDi0gHguEfHn3+05SnPZkRR4Jp9ncMP5jbVxdatITrH8x9EXzeLIJSVSfLSNjjE6woMFNVIn18zItj2b5fEquhDnrqpF3riNZK+pPaGc6sRSqQYmOoeskaN7pFe7bFEncnXslv0VKmTJrj7C/RCD1U12LcL0VaDIgmur9bflssMmtAJElsOxwpZeMUj5AFz0WnH5f4IbFUqoLro1tGxyDC+XdTcbjOYaR5KhS3LLfhYGlWOH9+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e9f8b1-bba1-44a9-83b2-08de898211ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 08:48:06.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPDDknKl4/Lya9UGzdqdR24eyHME1YAsvMXfoo0bhg8QK4goeBba/9prtbt1pT6KybTRok2ZyNU3DuIJbl8xsno0vtahkcyiOeDrdFrPwJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270935-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 159E6305135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matteo Croce
> Sent: Monday, March 23, 2026 7:28 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> Bashir <mohsin.bashr@gmail.com>
> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
> XDP_REDIRECT support
>=20
> Add the ability to redirect packets to other devices via XDP_REDIRECT
> and to receive redirected frames from other devices via ndo_xdp_xmit.
>=20
> New functionality:
> - XDP_REDIRECT case in e1000_run_xdp() using xdp_do_redirect()
> - e1000_xdp_xmit() as the ndo_xdp_xmit callback for receiving
>   redirected frames from other devices
> - xdp_do_flush() in e1000_finalize_xdp() for REDIR completions
> - xdp_features_set/clear_redirect_target() in e1000_xdp_setup()
> - NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT advertised
>=20
> Assisted-by: claude-opus-4-6
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 85
> +++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index d77f208f00cc..01661e1a74e5 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -41,6 +41,7 @@ char e1000e_driver_name[] =3D "e1000e";
>  #define E1000_XDP_PASS		0
>  #define E1000_XDP_CONSUMED	BIT(0)
>  #define E1000_XDP_TX		BIT(1)

...

>=20
> +/**
> + * e1000_xdp_xmit - transmit XDP frames from another device
> + * @netdev: network interface device structure
> + * @n: number of frames to transmit
> + * @frames: array of XDP frame pointers
> + * @flags: XDP transmit flags
> + *
> + * This is the ndo_xdp_xmit callback, called when other devices
> +redirect
> + * frames to this device.
> + **/
> +static int e1000_xdp_xmit(struct net_device *netdev, int n,
> +			  struct xdp_frame **frames, u32 flags) {
> +	struct e1000_adapter *adapter =3D netdev_priv(netdev);
> +	struct e1000_ring *tx_ring =3D adapter->tx_ring;
> +	struct netdev_queue *nq =3D netdev_get_tx_queue(netdev, 0);
> +	int cpu =3D smp_processor_id();
> +	int nxmit =3D 0;
> +	int i;
> +
> +	if (unlikely(test_bit(__E1000_DOWN, &adapter->state)))
> +		return -ENETDOWN;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	if (!adapter->xdp_prog)
> +		return -ENXIO;
> +
> +	__netif_tx_lock(nq, cpu);
> +	txq_trans_cond_update(nq);
> +
> +	for (i =3D 0; i < n; i++) {
> +		int err;
> +
> +		err =3D e1000_xdp_xmit_ring(adapter, tx_ring, frames[i]);
> +		if (err !=3D E1000_XDP_TX)
> +			break;
On first failure, we break out of the loop. frames[i] through frames[n-1] a=
re silently abandoned.
It should be no memleaks I hope, but silent packets drop is nasty!

> +		nxmit++;
> +	}
> +
> +	if (unlikely(flags & XDP_XMIT_FLUSH)) {
> +		/* Force memory writes to complete before letting h/w
> +		 * know there are new descriptors to fetch.
> +		 */
> +		wmb();
> +		if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
> +			e1000e_update_tdt_wa(tx_ring,
> +					     tx_ring->next_to_use);
> +		else
> +			writel(tx_ring->next_to_use, tx_ring->tail);
> +	}
> +
> +	__netif_tx_unlock(nq);
> +
> +	return nxmit;
> +}
> +

...

> --
> 2.53.0


