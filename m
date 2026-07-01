Return-Path: <netdev+bounces-303839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H3P3HMuIRWqYBgsAu9opvQ
	(envelope-from <netdev+bounces-303839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:38:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5616F1E1D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GmVwxnZY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303839-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303839-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7D2300E264
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567734C141;
	Wed,  1 Jul 2026 21:38:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E73803F1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:38:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941896; cv=fail; b=WX1gpkadsGJz6WuJZNMq9fFKQKpiceR70aWt5VjtlY3SUUOlIKwtocDyrRqq5nqTwqF7nqnB2iY1aWKV2+h3rwBKKjCwMVVFQTOqOAHAOO9uUMHZJ/Nopb9mf2FJJTA2JdEFiA5nAAwJrmDL+i329pd73XZSwFX3jry7dYD/Waw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941896; c=relaxed/simple;
	bh=/HBWCe1nt3CoreCJ4sczWmW4NWiuoK2t0LbB5Mng5rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iSlp7cQ1G2DE3t/C6OaDyQOlZbN9N//kUbpYBgYF8V4o1sCN+o5xpxr1NTz8MpMpvoHJl3TghYcYEcHNjPHmbFlXIMCSLujk4DBNBePA4w+rkndW3Fr0+n3GNdZx2c8KV0NUdUQ5JqwlME88WkQtE6YlUAnV114QTChRLKYxZJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmVwxnZY; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782941895; x=1814477895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=/HBWCe1nt3CoreCJ4sczWmW4NWiuoK2t0LbB5Mng5rg=;
  b=GmVwxnZYXCDFUfgE6HY/eJDwvzq8vwTdOtF1IoeNNvZOBtXb8Fun2cRJ
   7Ua3Irxz6fIf0y0rpnY1mpjC3jrQEEEok3IaEij75lp9c4wHyc9lqjmx6
   lt1BR0CE6abymMHGMXcqCojBzRn+W/d2fgMPnPcZgl0aOOEW/q8nJaVbI
   wse/KoebtjEYIwt3/5S8wYe+RNQR961WWxdjAattVKkL/pAJqENO9IgLy
   HnICzwnecDZUyZPwaKGQujmQi1vUFOSBeuTWL9CqIAI3w7bG1bQZ24YjF
   aFSP5N5azXFRB7tGwp0AJhS9CqkJnf+yZkGuAUonjDMfyTrMWw2GITTPP
   Q==;
X-CSE-ConnectionGUID: SseZzwZzTjSIfcHi2Xp2UQ==
X-CSE-MsgGUID: LTXnV4l8TzSrDoOr8lDO1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83774199"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="pdf'?scan'208,217";a="83774199"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:38:14 -0700
X-CSE-ConnectionGUID: EDhXjU71Q6aneGxhFn9bfg==
X-CSE-MsgGUID: S5uf9Wx/R6uei2fa3FMTYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="pdf'?scan'208,217";a="250955759"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:38:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 14:38:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 14:38:13 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 14:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN5jrbZjpJ03Qb4ybmvuhTUfmnmtLYfsSt9TbGDn8CjFhtmuz6SlqTTF+SAvaoE37OwC+JrZD8u3Wsyhb6aLI8s39+d4KHoN/saKomPDa0QUkJOJRWdLtDHy0FRb2otPEYj6qARIPNhURkbAjNqiMGQveMcJytTMhLYBvIauADa/daww4dh9L6mKhtpxaA0StNR5X1woUwcnxrp3DBe9V5BW5w84lGVbIgGaUikpsVscbweO9azKE9jlmGQbLl+XySXibfZB5iPmWdEW3AF6ucJAgfhJuOe8yBaHugT76Tj7Ow9KP9vhlOjDC5GoWOTOeIieWVQwvV1+NDud25Xuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZM0JzAvhPTa3D8MtZFdG7BinUQkNEBkJXbfjGs2S3Q=;
 b=RxNFcOCH232TEJOcZ/W08cadfMXG+HRG+IRNLYjdKnNqj2517lCFaKwaFQDwWJUzNpqTpbxHP+jzChxXTWdEb+hj4VqMZVKpCufKjFOOBc5dLVl3FYloBnVAb/HOboDJKZumjoVeGf6SOiDY+FMP/8T+fZZ/19K8YHI/DS1uq4LK/OyEA0T/YA3WUTebmM3FWwoOCdFtsTGGoL4Z6ok6o91jBomB90usMOF4BHsiAUuFqOPncMLkGF7BPEHBzM4u3rZNTaksujBg5sfJK87H9WruV1rvF7BV4yc53jC44Lmxo3f60wyH+UdK2JKlRDpd/bCsPOOiWC+FqZVVhOSyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 1 Jul
 2026 21:38:08 +0000
Received: from BL3PR11MB6385.namprd11.prod.outlook.com
 ([fe80::a731:24a9:6c0f:2440]) by BL3PR11MB6385.namprd11.prod.outlook.com
 ([fe80::a731:24a9:6c0f:2440%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 21:38:08 +0000
From: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, "Das, Shubham" <shubham.das@intel.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>, Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, "D H,
 Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSAAJtcogAAPdBwAABO0owAAG26fAAD6e9ZgAAPKZQAAFsd4YABPDrYAAAbkChIAAZiPgA==
Date: Wed, 1 Jul 2026 21:38:08 +0000
Message-ID: <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
References: <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6385:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 990c8db8-db97-4773-3886-08ded7b90ac3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|366016|23010399003|1800799024|376014|6133799003|56012099006|4053099003|13003099007|8096899003|3023799007|18002099003|22082099003|38070700021|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: iMB5oqish5RLPTLg8L8JO4ugKJu6Sn2+2F6d3Vx8e9r1Q1Oi3VShxxyWCHDAR6YmTRYzC8XiZK51NeqJUjD99W0Yx9MyTs0zMJLcWwNCHeBQplfM7nOicEmPKgeb2E4TMLfgVQXfCVVVSWvaPDTRVhDLk0u4/ruzumZjmIkxZ/MOzem6z8eSvnx0RyS55tZv2NfTTO4sr5j2P4EC8M5bKYamdT9BA7uX09+C9Mc96yhkJVIdtF00muG/wCemrM24rjlKB2exN8lAuSqGooBEf+yDMvAI+i0rDU3h1nkXDMlUC2oyewFSkmr0pGH3bw7OmmORUPZWFxu2Q1ifmuec60CEGEiRvb7akg2jfycmMupwnzaasMCDihDTfu/aCcCyuW3Wpi9RgnJU/+u1wM7xBR2g/b5WJSadNTeWWVMlisY8b+eFjny7u5W9GaOYepYVkMzQ7aiHsrMGgkVxNdLlivpfy/MCaCXodovymi2ig84uiKCYlU6VoVLpfLMdBCsRlRYIVDD1uKMNjUWvNPYKxUKiqtMATObxT1iC11uYyLgPlFZwc3mMYJ38slb3hRaDuBg7tR4ESql8hkRK3E9xaoiijix8/2f83qj0zsv7owonPWUiG6Fnb9MfycxLR3XdSy+1Kvp/FDrfI/H9QqtyunhhAKT2+PEy16QNeEleMWY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6385.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(4053099003)(13003099007)(8096899003)(3023799007)(18002099003)(22082099003)(38070700021)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W8N1MwLenFtH2/S4RwsBTu7wpkSUzqyOEiQWJw145n/MwRiEL66IAfreoA?=
 =?iso-8859-1?Q?tHXLY/v+9gBAFPetFopctYnNwzJuNB8WjmIyvMTnUpNfAUOQi5myvx51Gr?=
 =?iso-8859-1?Q?78o62/TrPrQNehiYIfzNvaJI6DncmQdTbfEky0dIZnpZksAea4IMyRU0+b?=
 =?iso-8859-1?Q?n7cNWxfZjWG5ZxJM+AKwI8I2icrPtJSFJ5ejfKO8B5AxZF3w93Q4KymzG6?=
 =?iso-8859-1?Q?s6xFPNMz93WtCPVZfuEC4CEKkVxzykDOoyntwTQ5TIpfj46KA1wTeHxCuu?=
 =?iso-8859-1?Q?iqvUCa4PNFmygIKKI+PxAerlToCQ+watkDyJ2OdDwYkZmRyMLvQD9SJbRX?=
 =?iso-8859-1?Q?OoJ2A92GFDCHMr18N1zBSw4SNuthLejeKPdEmkPavLoJpdnUtWJj+7QFzH?=
 =?iso-8859-1?Q?vxYu17C2tAwChrD0C+wbVNckWElFu2LtFI5Knt5vHdJS/R9E/kvEhCHDuk?=
 =?iso-8859-1?Q?1QLdj7OCYSy7GezFWdEY5KEetsGX395ElFL1id7gbqBGmdhZJCeEsA1jbp?=
 =?iso-8859-1?Q?kv0bO/YenK66qOxJS0K+f/VKOoV7ZpzvCO5wovG8ZojIqtDr0Pw7gMYq0F?=
 =?iso-8859-1?Q?xE8pOpUGkqGNyeQI+DtRCchXdp4razHdoymklgu7TPMIg1Ku29Au8X2x/O?=
 =?iso-8859-1?Q?NjtoPmdf1dAxQE/8Wvptkf7upfWFNUNSWri61jbLpwFnpuhUixiZVWyu+F?=
 =?iso-8859-1?Q?ReTFH+zu+KSEGEq7hLs2oZK5y0WY+ocX6uzMgg0xoWNaXHTGU4dL4lG9PJ?=
 =?iso-8859-1?Q?x/sr1KUuX+Lk6HmshyOLxxnFnvUHyr1cbM1hSTq08sDM8aJ3XwmhpF7+XA?=
 =?iso-8859-1?Q?A39N5mimYR3P/8A0GTjfcnJHI3sFGFeOokTcepJc9GsYUjfhCye89lJHJE?=
 =?iso-8859-1?Q?x4NsDtcEwY5kybT1w1MUMosF0qBLev+mRnyqH6vkTp0hNUiCfInuDRRBZk?=
 =?iso-8859-1?Q?m0cTcwKtS37H/JiZcPErTMXxKXmChjuUkMVNucSKUzyOR47W8AqjUGAg6T?=
 =?iso-8859-1?Q?9m2D2qtGN/mdsObt9HBPQXZRi8Z7guM48JovGUVqFBoG/P2evGyebnh+Q9?=
 =?iso-8859-1?Q?7MGFaqQjDA0YrI1IXXQf+XSShnyMe1LZ4j6iAF60tngkAXGLF8fcq6RGUq?=
 =?iso-8859-1?Q?n0VupWM91SqEVOAYFMUiDFuKwQSrtPEj4T4jR78INRhQY9AMki9nMHc6gf?=
 =?iso-8859-1?Q?Pcyjd5jiY101lES2loHANehltcB3Lx1F/9mc3gfQFYmEs44h5QlbnRsOr0?=
 =?iso-8859-1?Q?/8ecQ9LWjpzPbB7J79BLJkS3V6ie8ERN3nvjRiI1gfCeLfJvHvdwk/59ms?=
 =?iso-8859-1?Q?/F13CUlsSFI7CDERDAlEGyz3r7c8SDOWuldt2KcDUE1C+COkjrNv1k+Ox/?=
 =?iso-8859-1?Q?1qCUHeFfYrUrfToDK/kIN1zU8mTz0WhZ7SUpRL4tX2GQIjwgUarn0CbQcK?=
 =?iso-8859-1?Q?lccwtbkFlmmaKbhR37ySea8MItv+c5fF8YnvPiSxeZFvkULN73thBMYqGh?=
 =?iso-8859-1?Q?0hZhGyUVJ2KetQkL6ylsmkG2XMzog+qK2doPbraQGUjl6bm5xol+jXrwj8?=
 =?iso-8859-1?Q?s3eFp+5MHkjXcgdC/ZVkiBOJp4WIX6y8ecSTu0x5zWOxTcaeSWYbb2cLkL?=
 =?iso-8859-1?Q?W5ayptdS3mG+8e73YstDx4aaAPYsRE5PxUcpkjoU6BNKKxzccm1/N7pQec?=
 =?iso-8859-1?Q?idBP/16we5rhDhhBPaVo+tCjMRo6zbChjLVtvm9yUe5b1tA9HWAPyxTKlQ?=
 =?iso-8859-1?Q?IZ1hRS/zISRv0pZyBSS3iX1ojz6FeqD4gXGoEbeM/URxXKRNQ4aE8ylddj?=
 =?iso-8859-1?Q?klg4Y/mz1Q=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dwqfIgAVt5FgiETZrT8/1WYap1M8NU/MUHjQ/PX7ITw+E1vvZgrXn3CL5ARbSZfLZBdDtN81dkKRv6JfyvAGqhJ0ceDPUm+0mp7hV/BT5SJ+HLsJSNSYdqA007ojU+VXPudcI/+EqB1B+mocRT3YCC75zm1ibjhggO4YqecZ21C8ADuivaSBU0EAqh/V1sYCiUyEmLkw5miZicrwuypIh/3pwFCseUGh3FVdwS6zku/BjTsCjL8jF3u5NPxFEbwLyzFSyRk9mCD+MGbEAL3xsO3T44tQup5dvLN1LzTv4W53VCjB2x3v6OQlYa8mqEO3N1eRUkEb87IsX6rXK+spNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6385.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990c8db8-db97-4773-3886-08ded7b90ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 21:38:08.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTaqPcwUL3jZTF+Di5/OZ3+kX2+vPo7P9x3izKcqDMkyntmDzAOIAPsVPgQXu17WyuoBzVTGEeIEPo9NRYiyyKKfiHLh8RYTkELzwVQBL/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.14 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	R_MIXED_CHARSET(1.52)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,BL3PR11MB6385.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:shubham.das@intel.com,m:alexander.duyck@gmail.com,m:lee@trager.us,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER(0.00)[vijay.srinivasan@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,trager.us,bootlin.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vijay.srinivasan@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB5616F1E1D

--_004_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_
Content-Type: multipart/alternative;
	boundary="_000_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_"

--_000_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
I think there is a disconnect here. Please see the diagram attached indicat=
ing the error injection location.
Here, we are referring to error injection at the "bit" level, not "frame" l=
evel.
Bit error(s) injected at the PMA/PMD boundary, does not distinguish between=
 data (Frames) vs test patterns (PRBS).
Many SerDes IP's , if not all, include error injection as part of the test =
pattern block (BIST in the diagram).
Some IP's may have error injection outside of BIST in the common data path =
(as shown in the diagram) in which case bit errors may be injected in both =
data mode (frame/traffic) and test pattern mode (BIST).
Regardless, we are seeking error injection capability at PMA/PMD to be made=
 available through user/driver space (ethtool) .

Notes:

  1.
Error injection can be "one-shot" (single error) or continuous (fixed rate,=
 say 1 bit error every 10**6 bits (1E-6)).
  2.
Error injection availability is IP/API dependent. One-shot mode is highly l=
ikely to be available in all SerDes IP's.
  3.
Error injection location and implementation is IP dependent.
  4.
If IP/API supported:
     *
One-shot error injected in test pattern (PRBS) mode captured as individual/=
single bit error at the far-end checker.
     *
One-shot error injected in data (traffic/frame) mode captured as:
        *
Individual/single corrected codeword error if FEC is used for the link
        *
Individual/single CRC:  (a) if FEC is not used for the link and (b) if bit =
error injected corrupts any of the bits used to compute CRC.
     *
Effect of errors injected at fixed rate is a corollary to one-shot with add=
itional :
        *
Errors injected at higher rates (> 1E-4) may result in uncorrected FEC code=
words or loss of link
        *
Presence of uncorrected FEC codewords will lead to MAC CRCs

What is requested:

  1.
One-shot bit error injection (required/preferred), fixed rate is optional

How to inject error:

  1.
Test pattern mode:
     *
Generate any PRBS pattern
     *
Configure error checker on receive side (same device in loopback mode or fa=
r-end device) - measure Bit Error Ratio (BER) without error injection
     *
Inject error and verify BER>0 (if BER=3D=3D0 without injection)
  2.
Data (Traffic/Frame) mode:
     *
Configure and establish link (same device in loopback mode or far-end devic=
e)
     *
Measure MAC CRC and/or FEC corrected/uncorrected codeword counts
     *
Inject error and verify MAC CRC or FEC corrected counts match injected erro=
r count



Vijay

________________________________
From: Andrew Lunn <andrew@lunn.ch>
Sent: Wednesday, July 1, 2026 10:32 AM
To: Das, Shubham <shubham.das@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>; Lee Trager <lee@trager.us>=
; Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.org=
 <netdev@vger.kernel.org>; mkubecek@suse.cz <mkubecek@suse.cz>; D H, Siddar=
aju <siddaraju.dh@intel.com>; Chintalapalle, Balaji <balaji.chintalapalle@i=
ntel.com>; Lindberg, Magnus <magnus.k.lindberg@ericsson.com>; niklas.damber=
g@ericsson.com <niklas.damberg@ericsson.com>; Wirandi, Jonas <jonas.wirandi=
@ericsson.com>; Srinivasan, Vijay <vijay.srinivasan@intel.com>
Subject: Re: Ethtool : PRBS feature

On Wed, Jul 01, 2026 at 05:10:43PM +0000, Das, Shubham wrote:
> > Sorry, but i could not implement that, in a sensible way, given its cur=
rent
> > specification.
> >
> > I suppose i could simply flip the first `inject-error-count` bits, and =
make the rest of
> > the stream perfect? I could also wait until the stop command is receive=
d, and
> > then flip that many bits before i stop the stream? But none of these se=
em
> > sensible.
> >
> > Please make this specification have sufficient details, or references t=
o 802.3, that
> > you could give it to another engineer and get back a reasonable impleme=
ntation,
> > without having to answer any questions.
>
> Andrew,
>
> IEEE has clear documentation of the PRBS Receiver block and the BER count=
er as an output.
> Before performing the actual BER validation, it is a usual industry pract=
ice to introduce errors
> to guarantee that the checker is functional and accurately identifying th=
em.
>
> Similarly, in DATA mode, error injection is used to verify the FEC block
> by ensuring that injected errors are detected and corrected as expected.
>
> Updated description.
>
> +        name: inject-error-count
> +        type: u32
> +        doc: |
> +          Request the PHY to inject exactly this many bit errors into th=
e
> +          currently active test data stream.
> +
> +          This is a diagnostic tool used to validate that the far-end PR=
BS
> +          checker or FEC decoder is functioning correctly. For example,
> +          after enabling a PRBS pattern and confirming ber-lock-status i=
s
> +          locked, injecting N errors should cause ber-error-count to
> +          increment by exactly N on the receiving port, confirming the
> +          checker is actively detecting bit errors. Similarly, in normal
> +          data mode with FEC enabled, injecting errors verifies that the
> +          FEC block detects errors as expected.

There is no mention of how many frames to send in the stream. I don't
think that is part of the API? Because we have no idea of how many
frames will be sent, it is not possible to distribute the corrupted
frames over the duration of the stream. So that means i should flip
one bit, anywhere in the first inject-error-count frames. All frames
after that should not have bit flips. The assumption being, the stream
has a minimum of inject-error-count frames, and if the stream is
short, the counter will be too low. But it does not matter if the
stream is longer.

Your description has no mention of frames. Should it? What exactly
does the ber-error-count count? Can multiple bit flip within one frame
be counted individually? I don't see how, since the checksum just says
the frame is bad, and cannot report how bad.

As i said, give this description to another engineer and ask him/her
how it could be implemented.

https://www.youtube.com/watch?v=3Dj-6N3bLgYyQ

        Andrew

--_000_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Hi Andrew,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: &quot;I=
ntelOne Display CY&quot;; font-size: 11pt; color: rgb(0, 0, 0);">
I think there is a disconnect here. Please see the diagram attached indicat=
ing the error injection location.&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Here, we are referring to error injection at the &quot;bit&quot; level, not=
 &quot;frame&quot; level.&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Bit error(s) injected at the PMA/PMD boundary, does not distinguish between=
 data (Frames) vs test patterns (PRBS).&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Many SerDes IP's , if not all, include error injection as part of the test =
pattern block (BIST in the diagram).&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Some IP's may have error injection outside of BIST in the common data path =
(as shown in the diagram) in which case bit errors may be injected in both =
data mode (frame/traffic) and test pattern mode (BIST).&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Regardless, we are seeking error injection capability at PMA/PMD to be made=
 available through user/driver space (ethtool) .&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Notes:&nbsp;</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"direction: ltr; margin-top: =
0px; margin-bottom: 0px; list-style-type: decimal;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Error injection can be=
 &quot;one-shot&quot; (single error) or continuous (fixed rate, say 1 bit e=
rror every 10**6 bits (1E-6)).</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Error injection availa=
bility is IP/API dependent. One-shot mode is highly likely to be available =
in all SerDes IP's.</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Error injection locati=
on and implementation is IP dependent.</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">If IP/API supported:</=
div>
</li><ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&qu=
ot;:true}" style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; li=
st-style-type: lower-alpha;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">One-shot error injecte=
d in test pattern (PRBS) mode captured as individual/single bit error at th=
e far-end checker.</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">One-shot error injecte=
d in data (traffic/frame) mode captured as:</div>
</li><ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&qu=
ot;:true}" style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; li=
st-style-type: lower-roman;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Individual/single corr=
ected codeword error if FEC is used for the link</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Individual/single CRC:=
&nbsp; (a) if FEC is not used for the link
<b><u>and</u></b>&nbsp;(b) if bit error injected <u>corrupts any of the bit=
s used to compute CRC</u>.</div>
</li></ol>
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Effect of errors injec=
ted at fixed rate is a corollary to one-shot with additional :</div>
</li><ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&qu=
ot;:true}" style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; li=
st-style-type: lower-roman;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Errors injected at hig=
her rates (&gt; 1E-4) may result in uncorrected FEC codewords or loss of li=
nk</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr;">Presence of uncorrecte=
d FEC codewords will lead to MAC CRCs</div>
</li></ol>
</ol>
</ol>
<div style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; font-fam=
ily: &quot;IntelOne Display CY&quot;; font-size: 11pt; color: rgb(0, 0, 0);=
">
<br>
</div>
<div style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; font-fam=
ily: &quot;IntelOne Display CY&quot;; font-size: 11pt; color: rgb(0, 0, 0);=
">
What is requested:&nbsp;</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"direction: ltr; margin-top: =
0px; margin-bottom: 0px; list-style-type: decimal;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
One-shot bit error injection (required/preferred), fixed rate is optional&n=
bsp;</div>
</li></ol>
<div style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; font-fam=
ily: &quot;IntelOne Display CY&quot;; font-size: 11pt; color: rgb(0, 0, 0);=
">
<br>
</div>
<div style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; font-fam=
ily: &quot;IntelOne Display CY&quot;; font-size: 11pt; color: rgb(0, 0, 0);=
">
How to inject error:</div>
<ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:f=
alse,&quot;orderedStyleType&quot;:1}" style=3D"direction: ltr; margin-top: =
0px; margin-bottom: 0px; list-style-type: decimal;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Test pattern mode:&nbsp;</div>
</li><ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&qu=
ot;:true}" style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; li=
st-style-type: lower-alpha;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Generate any PRBS pattern</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Configure error checker on receive&nbsp;side (same device in loopback mode =
or far-end device)&nbsp;- measure Bit Error Ratio (BER) without error injec=
tion</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Inject error and verify BER&gt;0 (if BER=3D=3D0 without injection)</div>
</li></ol>
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Data (Traffic/Frame) mode:</div>
</li><ol start=3D"1" data-editing-info=3D"{&quot;applyListStyleFromLevel&qu=
ot;:true}" style=3D"direction: ltr; margin-top: 0px; margin-bottom: 0px; li=
st-style-type: lower-alpha;">
<li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: 11pt;=
 color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Configure and establish link (same device in loopback mode or far-end devic=
e)</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Measure MAC CRC and/or FEC corrected/uncorrected codeword counts</div>
</li><li style=3D"font-family: &quot;IntelOne Display CY&quot;; font-size: =
11pt; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation" style=3D"direction: ltr; margin-top: 0px; margin=
-bottom: 0px;">
Inject error and verify MAC CRC or FEC corrected counts match injected erro=
r count&nbsp;</div>
</li></ol>
</ol>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"direction: ltr; font-family: &quot;IntelOne Display CY&quot;;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Vijay</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Andrew Lunn &lt;andrew@lunn.ch&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, July 1, 2026 10:32 AM<br>
<b>To:</b>&nbsp;Das, Shubham &lt;shubham.das@intel.com&gt;<br>
<b>Cc:</b>&nbsp;Alexander Duyck &lt;alexander.duyck@gmail.com&gt;; Lee Trag=
er &lt;lee@trager.us&gt;; Maxime Chevallier &lt;maxime.chevallier@bootlin.c=
om&gt;; netdev@vger.kernel.org &lt;netdev@vger.kernel.org&gt;; mkubecek@sus=
e.cz &lt;mkubecek@suse.cz&gt;; D H, Siddaraju &lt;siddaraju.dh@intel.com&gt=
;;
 Chintalapalle, Balaji &lt;balaji.chintalapalle@intel.com&gt;; Lindberg, Ma=
gnus &lt;magnus.k.lindberg@ericsson.com&gt;; niklas.damberg@ericsson.com &l=
t;niklas.damberg@ericsson.com&gt;; Wirandi, Jonas &lt;jonas.wirandi@ericsso=
n.com&gt;; Srinivasan, Vijay &lt;vijay.srinivasan@intel.com&gt;<br>
<b>Subject:</b>&nbsp;Re: Ethtool : PRBS feature</div>
<div style=3D"direction: ltr; font-family: Calibri, Arial, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">On Wed, Jul 01, 2026 at 05:=
10:43PM +0000, Das, Shubham wrote:<br>
&gt; &gt; Sorry, but i could not implement that, in a sensible way, given i=
ts current<br>
&gt; &gt; specification.<br>
&gt; &gt;<br>
&gt; &gt; I suppose i could simply flip the first `inject-error-count` bits=
, and make the rest of<br>
&gt; &gt; the stream perfect? I could also wait until the stop command is r=
eceived, and<br>
&gt; &gt; then flip that many bits before i stop the stream? But none of th=
ese seem<br>
&gt; &gt; sensible.<br>
&gt; &gt;<br>
&gt; &gt; Please make this specification have sufficient details, or refere=
nces to 802.3, that<br>
&gt; &gt; you could give it to another engineer and get back a reasonable i=
mplementation,<br>
&gt; &gt; without having to answer any questions.<br>
&gt;<br>
&gt; Andrew,<br>
&gt;<br>
&gt; IEEE has clear documentation of the PRBS Receiver block and the BER co=
unter as an output.<br>
&gt; Before performing the actual BER validation, it is a usual industry pr=
actice to introduce errors<br>
&gt; to guarantee that the checker is functional and accurately identifying=
 them.<br>
&gt;<br>
&gt; Similarly, in DATA mode, error injection is used to verify the FEC blo=
ck<br>
&gt; by ensuring that injected errors are detected and corrected as expecte=
d.<br>
&gt;<br>
&gt; Updated description.<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name: inject-error-count<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type: u32<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; doc: |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Request the PH=
Y to inject exactly this many bit errors into the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; currently acti=
ve test data stream.<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This is a diag=
nostic tool used to validate that the far-end PRBS<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checker or FEC=
 decoder is functioning correctly. For example,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; after enabling=
 a PRBS pattern and confirming ber-lock-status is<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locked, inject=
ing N errors should cause ber-error-count to<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment by e=
xactly N on the receiving port, confirming the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checker is act=
ively detecting bit errors. Similarly, in normal<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data mode with=
 FEC enabled, injecting errors verifies that the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEC block dete=
cts errors as expected.<br>
<br>
There is no mention of how many frames to send in the stream. I don't<br>
think that is part of the API? Because we have no idea of how many<br>
frames will be sent, it is not possible to distribute the corrupted<br>
frames over the duration of the stream. So that means i should flip<br>
one bit, anywhere in the first inject-error-count frames. All frames<br>
after that should not have bit flips. The assumption being, the stream<br>
has a minimum of inject-error-count frames, and if the stream is<br>
short, the counter will be too low. But it does not matter if the<br>
stream is longer.<br>
<br>
Your description has no mention of frames. Should it? What exactly<br>
does the ber-error-count count? Can multiple bit flip within one frame<br>
be counted individually? I don't see how, since the checksum just says<br>
the frame is bad, and cannot report how bad.<br>
<br>
As i said, give this description to another engineer and ask him/her<br>
how it could be implemented.<br>
<br>
<a href=3D"https://www.youtube.com/watch?v=3Dj-6N3bLgYyQ" id=3D"OWAda2b378e=
-31a6-9bac-043d-655888ab00c7" class=3D"x_OWAAutoLink" data-auth=3D"NotAppli=
cable">https://www.youtube.com/watch?v=3Dj-6N3bLgYyQ</a><br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Andrew</div>
</body>
</html>

--_000_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_--

--_004_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_
Content-Type: application/pdf; name="Error Injection at Bit Level.pdf"
Content-Description: Error Injection at Bit Level.pdf
Content-Disposition: attachment;
	filename="Error Injection at Bit Level.pdf"; size=38062;
	creation-date="Wed, 01 Jul 2026 21:37:53 GMT";
	modification-date="Wed, 01 Jul 2026 21:38:07 GMT"
Content-Transfer-Encoding: base64

JVBERi0xLjcNCiW1tbW1DQoxIDAgb2JqDQo8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFIvTGFu
ZyhlbikgL1N0cnVjdFRyZWVSb290IDI0IDAgUi9PdXRsaW5lcyAyMiAwIFIvTWFya0luZm88PC9N
YXJrZWQgdHJ1ZT4+L01ldGFkYXRhIDE1MCAwIFIvVmlld2VyUHJlZmVyZW5jZXMgMTUxIDAgUj4+
DQplbmRvYmoNCjIgMCBvYmoNCjw8L1R5cGUvUGFnZXMvQ291bnQgMS9LaWRzWyAzIDAgUl0gPj4N
CmVuZG9iag0KMyAwIG9iag0KPDwvVHlwZS9QYWdlL1BhcmVudCAyIDAgUi9SZXNvdXJjZXM8PC9F
eHRHU3RhdGU8PC9HUzUgNSAwIFIvR1M2IDYgMCBSPj4vRm9udDw8L0YxIDcgMCBSL0YyIDkgMCBS
L0YzIDExIDAgUi9GNCAxNiAwIFI+Pi9Qcm9jU2V0Wy9QREYvVGV4dC9JbWFnZUIvSW1hZ2VDL0lt
YWdlSV0gPj4vTWVkaWFCb3hbIDAgMCA5NjAgNTQwXSAvQ29udGVudHMgNCAwIFIvR3JvdXA8PC9U
eXBlL0dyb3VwL1MvVHJhbnNwYXJlbmN5L0NTL0RldmljZVJHQj4+L1RhYnMvUy9TdHJ1Y3RQYXJl
bnRzIDA+Pg0KZW5kb2JqDQo0IDAgb2JqDQo8PC9GaWx0ZXIvRmxhdGVEZWNvZGUvTGVuZ3RoIDIz
MDc+Pg0Kc3RyZWFtDQp4nNVa62sjyRH/bvD/0B+lA7f7/QAj8GsvDmd2YznkQi4E43jXDlpvovMl
/35+1T0zGs1T8mgDAT80NdVd1dX1Lp2er99ePj88vrGL20v2r+MjwQQXQkilhGfRCWaNYOun46M/
/cBej49Of1xa9uXX4yPJvlTIwkmh7Rb25x+Oj/5wfMSusSs7/cTOzk5vL2+umFgs2MVVppSWSqts
HKaZSCnpuDJMG8OlY17RT43QXvtxy/6TjuLSUQT78fiol8CyfpDlPx9eq7PI058eXr+w2dPryR+X
89bBjBaWiQ76F/cg/kEyGbgAxfvPdESIkkmmtOZeMu0N14HdfyXmvhQc/mV2Oz/Rs/O5UrPL+V/Z
/e+Pj67vu8WsNtycZHbAjAw7yFnbyFUoxRAMj64t6j32zLLOIh7Yu1/K+vBS1sFy5fuk/OlyOSJd
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
ANKQ4DNS4CFPggsRU3slD35LDFUABjRk91DefaiA3ELJpI25uooy0Ii9AKxqAF0UU9USvamuInLI
hOSK6ioqXa7KxVSFIXqqqy39sQcO9MErjgyeAj0Suz3m0ttcTQvxpqPXRd+KIBeMFJTe9M0kUwd8
cRLOqi64lLkNbnMb/CT3wVM7PLfCU+vc6zR1QPUiU0e+fcT/AnCJv0oNCmVuZHN0cmVhbQ0KZW5k
b2JqDQo1IDAgb2JqDQo8PC9UeXBlL0V4dEdTdGF0ZS9CTS9Ob3JtYWwvY2EgMT4+DQplbmRvYmoN
CjYgMCBvYmoNCjw8L1R5cGUvRXh0R1N0YXRlL0JNL05vcm1hbC9DQSAxPj4NCmVuZG9iag0KNyAw
IG9iag0KPDwvVHlwZS9Gb250L1N1YnR5cGUvVHJ1ZVR5cGUvTmFtZS9GMS9CYXNlRm9udC9CQ0RF
RUUrQXB0b3MvRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL0ZvbnREZXNjcmlwdG9yIDggMCBSL0Zp
cnN0Q2hhciAzMi9MYXN0Q2hhciAxMTgvV2lkdGhzIDE0NSAwIFI+Pg0KZW5kb2JqDQo4IDAgb2Jq
DQo8PC9UeXBlL0ZvbnREZXNjcmlwdG9yL0ZvbnROYW1lL0JDREVFRStBcHRvcy9GbGFncyAzMi9J
dGFsaWNBbmdsZSAwL0FzY2VudCA5MzkvRGVzY2VudCAtMjgyL0NhcEhlaWdodCA5MzkvQXZnV2lk
dGggNTYxL01heFdpZHRoIDE2ODIvRm9udFdlaWdodCA0MDAvWEhlaWdodCAyNTAvU3RlbVYgNTYv
Rm9udEJCb3hbIC01MDAgLTI4MiAxMTgyIDkzOV0gL0ZvbnRGaWxlMiAxNDMgMCBSPj4NCmVuZG9i
ag0KOSAwIG9iag0KPDwvVHlwZS9Gb250L1N1YnR5cGUvVHJ1ZVR5cGUvTmFtZS9GMi9CYXNlRm9u
dC9CQ0RGRUUrQXB0b3MsQm9sZC9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvRm9udERlc2NyaXB0
b3IgMTAgMCBSL0ZpcnN0Q2hhciA0Ny9MYXN0Q2hhciAxMTYvV2lkdGhzIDE0OSAwIFI+Pg0KZW5k
b2JqDQoxMCAwIG9iag0KPDwvVHlwZS9Gb250RGVzY3JpcHRvci9Gb250TmFtZS9CQ0RGRUUrQXB0
b3MsQm9sZC9GbGFncyAzMi9JdGFsaWNBbmdsZSAwL0FzY2VudCA5MzkvRGVzY2VudCAtMjgyL0Nh
cEhlaWdodCA5MzkvQXZnV2lkdGggNTg3L01heFdpZHRoIDE4ODQvRm9udFdlaWdodCA3MDAvWEhl
aWdodCAyNTAvU3RlbVYgNTgvRm9udEJCb3hbIC01NDIgLTI4MiAxMzQyIDkzOV0gL0ZvbnRGaWxl
MiAxNDcgMCBSPj4NCmVuZG9iag0KMTEgMCBvYmoNCjw8L1R5cGUvRm9udC9TdWJ0eXBlL1R5cGUw
L0Jhc2VGb250L0JDREdFRStBcHRvcy9FbmNvZGluZy9JZGVudGl0eS1IL0Rlc2NlbmRhbnRGb250
cyAxMiAwIFIvVG9Vbmljb2RlIDE0MiAwIFI+Pg0KZW5kb2JqDQoxMiAwIG9iag0KWyAxMyAwIFJd
IA0KZW5kb2JqDQoxMyAwIG9iag0KPDwvQmFzZUZvbnQvQkNER0VFK0FwdG9zL1N1YnR5cGUvQ0lE
Rm9udFR5cGUyL1R5cGUvRm9udC9DSURUb0dJRE1hcC9JZGVudGl0eS9EVyAxMDAwL0NJRFN5c3Rl
bUluZm8gMTQgMCBSL0ZvbnREZXNjcmlwdG9yIDE1IDAgUi9XIDE0NCAwIFI+Pg0KZW5kb2JqDQox
NCAwIG9iag0KPDwvT3JkZXJpbmcoSWRlbnRpdHkpIC9SZWdpc3RyeShBZG9iZSkgL1N1cHBsZW1l
bnQgMD4+DQplbmRvYmoNCjE1IDAgb2JqDQo8PC9UeXBlL0ZvbnREZXNjcmlwdG9yL0ZvbnROYW1l
L0JDREdFRStBcHRvcy9GbGFncyAzMi9JdGFsaWNBbmdsZSAwL0FzY2VudCA5MzkvRGVzY2VudCAt
MjgyL0NhcEhlaWdodCA5MzkvQXZnV2lkdGggNTYxL01heFdpZHRoIDE2ODIvRm9udFdlaWdodCA0
MDAvWEhlaWdodCAyNTAvU3RlbVYgNTYvRm9udEJCb3hbIC01MDAgLTI4MiAxMTgyIDkzOV0gL0Zv
bnRGaWxlMiAxNDMgMCBSPj4NCmVuZG9iag0KMTYgMCBvYmoNCjw8L1R5cGUvRm9udC9TdWJ0eXBl
L1R5cGUwL0Jhc2VGb250L0JDREhFRStBcHRvcyxCb2xkL0VuY29kaW5nL0lkZW50aXR5LUgvRGVz
Y2VuZGFudEZvbnRzIDE3IDAgUi9Ub1VuaWNvZGUgMTQ2IDAgUj4+DQplbmRvYmoNCjE3IDAgb2Jq
DQpbIDE4IDAgUl0gDQplbmRvYmoNCjE4IDAgb2JqDQo8PC9CYXNlRm9udC9CQ0RIRUUrQXB0b3Ms
Qm9sZC9TdWJ0eXBlL0NJREZvbnRUeXBlMi9UeXBlL0ZvbnQvQ0lEVG9HSURNYXAvSWRlbnRpdHkv
RFcgMTAwMC9DSURTeXN0ZW1JbmZvIDE5IDAgUi9Gb250RGVzY3JpcHRvciAyMCAwIFIvVyAxNDgg
MCBSPj4NCmVuZG9iag0KMTkgMCBvYmoNCjw8L09yZGVyaW5nKElkZW50aXR5KSAvUmVnaXN0cnko
QWRvYmUpIC9TdXBwbGVtZW50IDA+Pg0KZW5kb2JqDQoyMCAwIG9iag0KPDwvVHlwZS9Gb250RGVz
Y3JpcHRvci9Gb250TmFtZS9CQ0RIRUUrQXB0b3MsQm9sZC9GbGFncyAzMi9JdGFsaWNBbmdsZSAw
L0FzY2VudCA5MzkvRGVzY2VudCAtMjgyL0NhcEhlaWdodCA5MzkvQXZnV2lkdGggNTg3L01heFdp
ZHRoIDE4ODQvRm9udFdlaWdodCA3MDAvWEhlaWdodCAyNTAvU3RlbVYgNTgvRm9udEJCb3hbIC01
NDIgLTI4MiAxMzQyIDkzOV0gL0ZvbnRGaWxlMiAxNDcgMCBSPj4NCmVuZG9iag0KMjEgMCBvYmoN
Cjw8L1RpdGxlKCkgL0F1dGhvcihTcmluaXZhc2FuLCBWaWpheSkgL0NyZWF0aW9uRGF0ZShEOjIw
MjYwNzAxMTQzNzM2LTA3JzAwJykgL01vZERhdGUoRDoyMDI2MDcwMTE0MzczNi0wNycwMCcpIC9Q
cm9kdWNlcij+/wBNAGkAYwByAG8AcwBvAGYAdACuACAAUABvAHcAZQByAFAAbwBpAG4AdACuACAA
ZgBvAHIAIABNAGkAYwByAG8AcwBvAGYAdAAgADMANgA1KSAvQ3JlYXRvcij+/wBNAGkAYwByAG8A
cwBvAGYAdACuACAAUABvAHcAZQByAFAAbwBpAG4AdACuACAAZgBvAHIAIABNAGkAYwByAG8AcwBv
AGYAdAAgADMANgA1KSA+Pg0KZW5kb2JqDQoyMiAwIG9iag0KPDwvVHlwZS9PdXRsaW5lcy9GaXJz
dCAyMyAwIFIvTGFzdCAyMyAwIFI+Pg0KZW5kb2JqDQoyMyAwIG9iag0KPDwvVGl0bGUoU2xpZGUg
MSkgL1BhcmVudCAyMiAwIFIvRGVzdFsgMyAwIFIvWFlaIDAgNTQwIDBdID4+DQplbmRvYmoNCjMy
IDAgb2JqDQo8PC9UeXBlL09ialN0bS9OIDgxL0ZpcnN0IDY1NC9GaWx0ZXIvRmxhdGVEZWNvZGUv
TGVuZ3RoIDEzMjU+Pg0Kc3RyZWFtDQp4nK1YS2/bOBC+F+h/mOPuSRy+CRQFgj7QRdAgaAL0EOzB
TbSJUccKHAdo//1+I9IPqbYSyznYI5LzfpAcGkWKjCXnyBhi5ck4Yh/JBNLakPGkgyWDCXxaJqvw
s2Q9Rp6cxiiQC5qsIw8CG8knTU5RwIJNFFIixxQ9k7OUNLA9pWhEJCtIcwEwBfKKmIMib4k1hHno
oyPYAc+An0/EljEfAfEXmNgZyAGdi5oC8D1Ugy7sk4d84uCAB/xomALkRMiNwE/QNoBfgtzIpJVL
FB1p1g6aAgI5WnhAYz4CpkgRHhE9YiJtWVMCneiRFGmnFUwDhB4JfDzcABId4B+Gx3SIYiVWIpzA
CqyTCq2/dRIDVCKj4HMGYyPrDEsNi42M0GgtMwEfwoeBbKy4B7EzMJUZ8bFwNkOeEWVYYucCljQY
ei1L4COhYfAyAQ5gDRFRwT1YNjGIn0Ge8Mfwq0nwABtEViGSCAHCzzKT8BEFJ5LVyB2WtIAZ+FBk
xUXgZy0bWIvs8OIn5AX+oIJNLP5BSojfgmQQNEVuaCC/e1edC7Gib9VFdbJYTv+bXC+ry98PdXWx
XDxdLz/N6vvq/JZMi3NK6v37t29aMmMK2fkf+KdXxP/SmmxNspZ0Wf9a/mh+7SKEfcAZpH6Jnnqj
px/S04zWMzyr5+fp7dOi3kVst+iqE0T+UAauy8Dq8Z7yazKk6ICnwi5bh0niWOfaNmay071GLqSN
umkwZ9VYfZ06IhmYu8F0RwSTN3nvBkPDoxPf+ZfaejJb/vU37ZTeKwCcGoc6rVcB2PS2OfjhzcmP
Nd4/vzsN6Bx6OvuuznFQ59HF5NM+nYMalJjGSgy8V6IekqhHF2Awxyel7tVhcF3Vw6DqerTqca+z
BncrPbqC4zG7le6VbuzuVtEO6ux2SX2GZnSxxjaAcr/cY24cDunOE+9FgveG9LA7TFzTpcFK1aMr
Ne2t1BekglHdVEhjK8/0Ki/5g1XRPQ4H36iM6XJg1U1s6RGG7pF2bAikSzkiBq6vdjiYhe+xYHUw
i9Bn0TVEeqoh540+26Rre41SM2lL18Fz2O48o54jGt0OSe8pm5i0nq9hqN1cEKVTHdJ59PkivfAe
XaUXHpI5vor0MVVk+1Wk91TRi1y86aikrR8yd/QJIw8HR5gbe+aaw1mkPovuni2PFQOWu9E3PTZ7
r7PyHDIkc3wR2v3eXpl5MZve7DlY2gLO/qHsFsoMS/tc2lJ5tWtBnnRtCsorXQsyF5/XcqtQ7u/l
Ui3vby3IdPnyKI9tLchr+cJTbhPygNaCzDNlnvJ6lqEt0BdYNiLWBboCC50u87rQ6UKXS6B92Mqw
0BVPlKDt9O1qr/jYXD/d1/M/q669++wm30K9XNT1t6ZZVt+aWf118kB5r6jOJwswlVXKyrb81ne3
9eoZMuO0/k1cWH8Gr3mzrKsz+fs0v9kMVkl0UWOP+FJPbupF/haa1fc/89l0Xl/cTURDmTiZg8Nk
OW3mZbzaZdrR92bx80fT/Ny4QWYe7+p6KUouq6+T60WzNf5wh/+t8cfpZNbcbk3kXG2Zt7j5E2i3
i8n9uuiny1ldfeHqQ3MvUk/m13cNLHiYzFtbH1uq4pKzp/vHKzhutS2tpif39eNVHsp9MZdATpCS
B/kdrV8XGaXzDCQv3W1dqE6xZMz8KNGvGdupmZy/uTctDeO6ZjLr3Bita2a7fSh3enmMbouFX1JB
7pkKKvMcCuwc9e3bcoamQNetLF3wDe+psLK+2r3evvkfynhDgQ0KZW5kc3RyZWFtDQplbmRvYmoN
CjM5IDAgb2JqDQo8PC9PL0xheW91dC9QbGFjZW1lbnQvQmxvY2svQkJveCA0MCAwIFI+Pg0KZW5k
b2JqDQo0MCAwIG9iag0KWyA1NTAuOCAzNDQuMTYgNTUwLjggNDE2LjE2XSANCmVuZG9iag0KNDIg
MCBvYmoNCjw8L08vTGF5b3V0L1BsYWNlbWVudC9CbG9jay9CQm94IDQzIDAgUj4+DQplbmRvYmoN
CjQzIDAgb2JqDQpbIDQ0NC4yNCAzNDQuMTYgNDQ0LjI0IDQxNi4xNl0gDQplbmRvYmoNCjUyIDAg
b2JqDQo8PC9PL0xheW91dC9QbGFjZW1lbnQvQmxvY2svQkJveCA1MyAwIFI+Pg0KZW5kb2JqDQo1
MyAwIG9iag0KWyAyODguMjQgMzgwLjE2IDM1OS4yOCAzODAuMTZdIA0KZW5kb2JqDQo1OCAwIG9i
ag0KPDwvTy9MYXlvdXQvUGxhY2VtZW50L0Jsb2NrL0JCb3ggNTkgMCBSPj4NCmVuZG9iag0KNTkg
MCBvYmoNClsgNTk3LjQyIDIzNC4xOCA2MzAuOSA0MDQuMV0gDQplbmRvYmoNCjYxIDAgb2JqDQo8
PC9PL0xheW91dC9QbGFjZW1lbnQvQmxvY2svQkJveCA2MiAwIFI+Pg0KZW5kb2JqDQo2MiAwIG9i
ag0KWyA3MDAuNTMgMzU3LjY2IDc2MS45NyAzNTcuNjZdIA0KZW5kb2JqDQo2NiAwIG9iag0KPDwv
Ty9MYXlvdXQvUGxhY2VtZW50L0Jsb2NrL0JCb3ggNjcgMCBSPj4NCmVuZG9iag0KNjcgMCBvYmoN
ClsgNzAwLjUzIDQwMy4yIDc1OC4xMyA0MDMuMl0gDQplbmRvYmoNCjc1IDAgb2JqDQo8PC9PL0xh
eW91dC9QbGFjZW1lbnQvQmxvY2svQkJveCA3NiAwIFI+Pg0KZW5kb2JqDQo3NiAwIG9iag0KWyA1
ODYuMDYgMzgzLjE0IDYwNi45NSA0MDEuMzJdIA0KZW5kb2JqDQo4MiAwIG9iag0KPDwvTy9MYXlv
dXQvUGxhY2VtZW50L0Jsb2NrL0JCb3ggODMgMCBSPj4NCmVuZG9iag0KODMgMCBvYmoNClsgMjY5
LjcxIDQwMC4yMyAyODAuNTYgNDcxLjU3XSANCmVuZG9iag0KOTMgMCBvYmoNCjw8L08vTGF5b3V0
L1BsYWNlbWVudC9CbG9jay9CQm94IDk0IDAgUj4+DQplbmRvYmoNCjk0IDAgb2JqDQpbIDU5NC40
NiAzNjguMiA2ODAuNCA0NjYuNTZdIA0KZW5kb2JqDQo5NiAwIG9iag0KPDwvTy9MYXlvdXQvUGxh
Y2VtZW50L0Jsb2NrL0JCb3ggOTcgMCBSPj4NCmVuZG9iag0KOTcgMCBvYmoNClsgNTIxLjE5IDIz
NC41MSA2MzYuMzkgMjYxLjQzXSANCmVuZG9iag0KOTkgMCBvYmoNCjw8L08vTGF5b3V0L1BsYWNl
bWVudC9CbG9jay9CQm94IDEwMCAwIFI+Pg0KZW5kb2JqDQoxMDAgMCBvYmoNClsgNDkxLjkxIDI4
MS45NCA1NjUuMzMgMjgxLjk0XSANCmVuZG9iag0KMTAyIDAgb2JqDQo8PC9PL0xheW91dC9QbGFj
ZW1lbnQvQmxvY2svQkJveCAxMDMgMCBSPj4NCmVuZG9iag0KMTAzIDAgb2JqDQpbIDU5Mi4yNSAy
NDcuOTcgNjE5Ljk2IDI0Ny45N10gDQplbmRvYmoNCjEwNyAwIG9iag0KPDwvTy9MYXlvdXQvUGxh
Y2VtZW50L0Jsb2NrL0JCb3ggMTA4IDAgUj4+DQplbmRvYmoNCjEwOCAwIG9iag0KWyAzNTkuNzgg
MTQ3LjAzIDU3OS40MiAxNDcuMDNdIA0KZW5kb2JqDQoxMTAgMCBvYmoNCjw8L08vTGF5b3V0L1Bs
YWNlbWVudC9CbG9jay9CQm94IDExMSAwIFI+Pg0KZW5kb2JqDQoxMTEgMCBvYmoNClsgNDkxLjkx
IDIxNi44MyA1NjUuMzMgMjE2LjgzXSANCmVuZG9iag0KMTEzIDAgb2JqDQo8PC9PL0xheW91dC9Q
bGFjZW1lbnQvQmxvY2svQkJveCAxMTQgMCBSPj4NCmVuZG9iag0KMTE0IDAgb2JqDQpbIDU3OC43
OSAxNDcuMDMgNTc5LjQyIDIwMS44OV0gDQplbmRvYmoNCjEyNyAwIG9iag0KPDwvTy9MYXlvdXQv
UGxhY2VtZW50L0Jsb2NrL0JCb3ggMTI4IDAgUj4+DQplbmRvYmoNCjEyOCAwIG9iag0KWyA2ODku
NzUgMjQ3Ljk3IDcwNi4wMiAyNDcuOTddIA0KZW5kb2JqDQoxMzMgMCBvYmoNCjw8L08vTGF5b3V0
L1BsYWNlbWVudC9CbG9jay9CQm94IDEzNCAwIFI+Pg0KZW5kb2JqDQoxMzQgMCBvYmoNClsgNzc3
LjY5IDI0NS44MSA3OTMuOTcgMjQ1LjgxXSANCmVuZG9iag0KMTM2IDAgb2JqDQo8PC9PL0xheW91
dC9QbGFjZW1lbnQvQmxvY2svQkJveCAxMzcgMCBSPj4NCmVuZG9iag0KMTM3IDAgb2JqDQpbIDg2
Mi4yMSAyNDMuOTQgOTIzLjY1IDI0My45NF0gDQplbmRvYmoNCjE0MiAwIG9iag0KPDwvRmlsdGVy
L0ZsYXRlRGVjb2RlL0xlbmd0aCAzMTE+Pg0Kc3RyZWFtDQp4nF2Ry2rDMBBF9/oKLdNFsCQ7aQPG
kDoJeNEHdfsBjjROBbUsZGXhv680clKowIbDnXuZR1Y3h8ZoT7N3N8oWPO21UQ6m8eok0DNctCGc
U6WlXwj/cugsyYK5nScPQ2P6kZQlzT6COHk309VejWd4INmbU+C0udDVV90Gbq/W/sAAxlNGqooq
6EPQS2dfuwFohrZ1o4Ku/bwOnr+Kz9kCFcg8NSNHBZPtJLjOXICULLyKlqfwKgJG/dN5nmznXn53
LpaLp1DOWLGpIhW7RDukzXOiGqk+IG050jH5tjnSqUiEKZxvE2EKF4u2R8pFomOifaIT0iZlPgqk
EIZURMoPqTPBcKylf36b5jZ9wTCwYLFzwXi9VCc97iOe7b5seXUu7BlviwuOq9UG7ue3o42u+P0C
p4Wd3Q0KZW5kc3RyZWFtDQplbmRvYmoNCjE0MyAwIG9iag0KPDwvRmlsdGVyL0ZsYXRlRGVjb2Rl
L0xlbmd0aCAxMDA4Ni9MZW5ndGgxIDI0MDYwPj4NCnN0cmVhbQ0KeJzsfHlAVNe5+Dn33lmAAQcU
UEHnjgO4DIuCoIAxIwgILiCLMiqBy8wAIzPMeGcAMZIQjUsmiZqYaGIWl6RqY5sMxhjNL02zvyya
NkvTl/7Sl6Tpa5q8V5O2adomMvP7zrl3hgGJTdOm/ePnPXPPPct3vv37zrnDgjBCaBxUHDJV1+Xk
Vv31mBIhvBFGW+rqF9W/fvEnQYTWfA79zRan4K7+RdcyhBJ3AsxcS4+X19+X+CJCM2pg/uk2d7tz
9c3jtAglPQlIt7Y7+to+2bHEidBMGBs/0GETrGlH/nQAYC/CXdABA5qLsccJLuindTi9G1/Nmgj4
8X8CvN/hsghNZywGhBbsQSha6xQ2utVObQzMNwI877R5hYIHNtYhZP4MxpguwWlL7Bz/V4TKD8H6
LLfL4w0eRLkw/1MC7xZtbve24HiEMkwIMeMQkZ1hdr98pqK2edyCP6EYNSLXLx/s/pI8f9WRm38R
D52P6lZPgK4SMUi6YJ1q69CPgaeMi/gvf4B5NPLiXicwChWaA3pNQyys1KIcTJhcNm4r9DDiuM14
D1IgtSKPOw9LDkhP5jxqY/4vPGMQx5CL4xGzA+bZEO7ldTyPnkaxQxclHtQTmDwe4YNkjn1NUUIk
RSz7AnDxOFKTG32HF/cz5CdPhQ85xppX9Evzl6zzjD3+D/OTe3m8iuPD80ziP4cHNjg2HmXt3+Dl
3bF19l1c3P3DvHDvjOSL24GWXW4t+xZK+G64+mYX50Bx3Mpvt5aNR/O/MR0TWv/tqPz9F5c3Ni1u
89eMz/vX8Xa5C3+MboH78Fjjl18X/DW5x5qDONw31rjyTXSYs19KK/Li1v979ML8cCRf7Ieo7W+u
2QeZedTFbUT7/1k8sff/szCNvLjr/v2+x7pQHbsX1f27+bhyXbmuXFeuK9eV68r1j184LfDMv5uH
b3vhQ98clmlEP/zGsI+jZPo8iyyj59iHZZhXUOco/DfCXXUJrrVo21jjYXz3o23sQTRAYWdKz0tw
/Alt/6a8X7muXN/9hc99x/jf/27xj3mRbxfJt3wToMb0yWEennPhrZGD3jQ0E2WhHFSOKtFyVIPq
kRk1IwHZ4O3MhXrQQ+gJ9Ayew8xjVfwkfgq/OBhE5LvAGXTVIrQELUPVqBY10lUWZEcOJI5alSqt
Yt9in2efjuBtLbt/+LsqHI2+Ci4K/iZwAfs//PzDCx+2Ab9z5clctAAtRCZUIvdNaDFwPOb3S+w7
7K+58bB2MkoF6WbAOiLbWuDOjm5EO9DNaC/6LbqAPsdJOA0b8Ryci4twI16HbXg97jdV3X3X/n07
tm+7ceuWGwauv65/87Wb+jb29nR7PeIGt6vL6ehcb+9ob7NZLa1CS/M1TevWrjE3rl7VUF+3sqZ6
xfJlS6sql1SUz9Bpo6My8WBMdKmh1BadlYkGo2OgGZOVif3KUr+KDvqrjbzftLJRv7S2sWxxil5v
TjHo/SY/l15GbsHqs4QmzIACVsFaQLG0zrB05ZpGvszXQidhpH5ET5qfH56TW36mtL7RX26EXkS/
gvbD3SWjpitD0wbej2p8PusgYtNh3JQyiGlDUXqzGSQxG/ytRoPe0GgD2EE10ujrW0qhpQm1MF8B
GPkzWtQKt2W14QyWW2sa/XxLm3kJQCMm3U8/dWdQvmGj1G7x8xae9yvTDa01jT69H7cYUuR+bSNo
DAspPr1Bz5vNZ4LPpBJogx5wMahk0IB3rhw04Z11axrPasFzd9Y3nmQwU9pSYh5Mg7nGsxAOJjrK
kFEySDo86aClGCxzklFT+JSzJoQG6CxHB2jfAlLQMXVoDCPLGUYa00qEMighE0Sj5QwnzZhC0ByM
qaWxAQl6hgythhktmXkCMRC7dFK6QEtgGVO0wqQ2RZk0TCwDtiBDJ2HkCYCNwuhRDY7FKYOAs5YO
n8EDg1GmlLMUU60MOQCQZGwgPAacE7AIREBPErxhWIKGNY2PahDgpzVAlJArK7NskFlhNAy79cpG
sF7ZIF5hbAHXJl02vYwHt/ab6hoJbEsK+Dx49+KsTOJdfKPBlmIwD06Y4HOXDWq1pUt9peDI4GvU
wQYFZUaL0Se5HHE0g7YI3JRNr7QYylsAxABhA59KGLKs4lv8rS1GaPLacl858QqBQKOkQYZNH8Rc
Ol6IFoLelBp/tMFW4o8xlIRnrkZXSzNKMqMylPhxkqT1MkMZP9HusxhawQNNNY3tKW1mAXD7TQbB
zxlKUgY5VALxMhGDSGWDaIURZFsKPlhtrFkLQUqUwft8i/lBE5chWATSX6yHuPfJU4bFi80RK8p4
n98kWFoAosxMgSESYbDMIPBW0DKIC5qrM0BzzRqypn5No09jNVgNoGGTySeA2Cm8xZziM1uoxmE9
sIayMhXD2UlOTgyJ+XRLG1RneNTaYmiVBkh0jh5rHz3QBlCRY4YqQo4+MX36qgxlVoAgt2D1s+Bx
et5qllwG1dC88bVAOAKIB5tS5D5tcaiH5R504OPzt4/sdoS75eRuAa1lS77i5zKI5zXq/etT/A6z
MQwi+AdaeR+vNRQZSEUXV5C7xa+AxoBFIMlJSXwPBqpggG9sBV8GhOUtvpDHwTIuI0zJ32UcgRJS
Kq4H0kw6Ecc/UMO3mPmWFhiF6NGn8H4FPPk2gTgXSbs1kjw1kPvhIfjqYC0iAZTiV8EO0CbYDHrI
1n4StJL2CY8ccIfqGv0oxecz+PwYWEwvB2BAn+FXZlSSB3zcRoNgAyMSerxgo2vLgV2qHYItpcyg
NwMIk051CYqDbNFKKosPvNHfBNGmSI/3Jfj4Qh9krSZIuFyGZVULbAu8li/nqakF8GSihErSMwMi
CTAqnQDCevrJ8DuNg02q9OER+nEZJWA1xQqc1Tb6a0IgKvqBxgajn0meD5NEeFwL+YOjhiLKU6RX
gnpN4FUpZDXvZ+obZfPQ9ZVkaUrIYNIyGKFpl2yL+hC/MRK/ElEl/WjoJyrdr04HQ/s54EGaVhFx
hp0A2sC0tIal7EoCQBtI8fIMFaRF7nDpNiqTtB3yJH3CQUEwkDvlTPDpGsiRLQZym82EvJoSIiso
ap+EmKhLSSbHUoVMSfrEkE8lFSFyOJp+VJRnMieJpBipeFl7Z4NPI0lzevkiPkOk3CFHpRx3thR/
h9lolVYp5QzOQ0aFzG1ZSU8bayEaDHoV5DEQH6KK99cZYROhsu2QtFolZQfilbjcgMrBh+QGSkJ+
ZFiCSYUgtAxL/Ax0wy3DSQZhtWE+eUQZ5g8yWAXZniQjbawGEr3P0mKVNmrQMpqfsoAcjZTU0FHU
tj0kNdU3KlI4M3WZDH+vUfZiqe4xhud7SUyqQppUkzlfeFJB0fVKvpEh1z1G9ZirfOpvRkwtW9Mf
RedINspQX54UKxmoSjJXFSNhrpLyBIxmWHw+ktoGm+JIhGoy4mE8AVgrBCYLZS5BN5uBlRpCWk1H
aBfCTUXYkcyWHgMTWoB9RnLtGJjUAjfPpEhQ8DkLLw89xhC0pATgOzpd8nN5Wl4teWev0QytcnK3
AEg5ueVIipGjVDMq68voJZtGjZw0hJGRjd4Qxkh6g1gDZ2AuRQEUM3gtqKuI6jMDWIW+r2gQqzJk
AAUBYNKLfL6YUP4n6f8seaGhh0tk9o0e8PeDPcDWsWPPqEePxtJh2cqx4ScZlMMhutQfU0rOL2Rv
iiIOkA327X9Bzjn0OBGhGDpEQjFydCLRvSqUElzG0NqQ3tpoSMtrR43WN/bDKNHUC2Qn8WN4KjL0
5E4hqqPUiI+7jPJBt59YdwtFt8XI83Y4Z5ViOG3BRmknWxVPoNUZNMn54MBjFwSah+hrzEQ4S9WS
0zG8ARi0PF6AFkgvQwb5PQP2AC69cUFKoRneK84EP041S6mKgU0e7nofz2vjYcrHJ8CLhn8bVa88
Z6BjsIsrM2QoIsE2CE4JjnCvYXxL60AJ5I0sen5KNHnLC71g3WW83DRP1kOW8jcbNuqJKvyrDH1w
WCg1+Hl+HaREGKxINft8sJ36DORNalWjVJMpnJlKTgbkFCPDpqTCO9pwV5NK3E04E3w0lbwuhald
G6ImAjXS8IXI+S1jUiNehtdKvgYfyv5gATJI9LkMmahvnW8NvB/q/VMIYZkP6MalmikG4OQuwgky
BZtnB3XXzAnqmnJE3bqcvbq1OUHdmuygzpx9XteYGdStzgrqVmWd1zUYg7r6mVW6uplBXe2soG7l
rBO6mpm8rnpGmW7FjBO65TOCumXTg7qlGUFdVYZRV5nWrluSdl5XkRbUlacHdWXpJ3SLDUFd6bSg
rkR/XrdIH9SZ9Cd0V/PndQv5oO4qfq9uAZ+jK54q6oqmBnWFuqBuvm5AN2+KqCuYEtTlTzmvm5t6
XpeXGtTlpp7QzZkt6rIzr9JlZYq6WTOv0aUDrbTJKZPWGaaZdNPYyZPW6SdfpeMXQEM3tV03debE
pHVTkoO61KSgLiV/UtHaiQVJRWsnm2pIO5m0EycVJ3WsGV+Y0BBfqG1IMGvNsYWaBkUh08DBrTGP
K4hriCmMblAVKhvizNFmpRmZowrVDSzMqs2MWYtYk0mBz+I9qN649IwqWLvUr65Z68c7/el1pIbX
Br9ypx81rFnbOIjxLvO2W29FU0qW+vfUNZ5kETThJMmUrmwc5Nhd5hJkREajEcmFNuW+0YgjCoKb
fJBRakjzMrjcDneMIVB5fMTMRKQoIQUlBH8W/Ij9XxSPUPBC6A4cCP5OkUx+l4j00WZ0A3JC6UVW
KKS9CblRD6pDNtSNHKgdIDqh9qD16OdIQGuQiOoBoh1dC9DbUQes6IF6A/RvRC3IBZiuRcthfSPF
IACkA2Z7AHs/xUTga6Fnh9mtgLMBcFphVEQr0WrUBBAb4OhAvpl6QVGFWDQOjSffnZkmz0rmJ09X
pHHRE+zRnFabPSVt/HjMiEgtgvC52hdz4/OgMsYnJBfOnrMhXh+fPi0jf25BXm5S4gSlQh+vxxkF
8woK8udmGKYpEw2hGZVSqWJfCExKmz07LS03N7CIXXjxWWzjiouLCmpX1Te7j9yw5Z6a0nnTOEXV
l6ffy0lLyyH3vdyzF7+o7czKrCgorm6s6d+5ubPGOte4NJ98h6iGc/wjYAEVikYppthoTq1UIuCV
o8wCj4U5efHApQfnYQOrZ8frWTX+y1P4908MDL2x/XH8yq8VJV8+hfsCOxgtcz2CHZtiVD6nzCDf
SmIl95MMOFGfZmIwxhtXIeNc8q2lH2B6geo4NAkZ0BRTnHry5EnQBMJamXAuoZxAKMfrJemTSK00
pOtzJdXo8/NySSPDAHut/9U/9rbectTxi6OBd3Baw55Vx/cG3v1qy00Le1d9pSh58Pj6o5OSB7ds
+uG6fUZni1e8vde2eG0WcOgIXlCkKeoRj5JNMbGpKF7NipNQlMRCQiHQL5uWxuTPTUgDGyQlG7IZ
MIkycUJSEhCflxfHMBdeD/xq71489XXfnx6Ie0zjeqDpyMvr1r185MFz2tPaA5/DLlJw7hye7295
YZ9tq+mOL/bv++K2I4cPvt4B2gc9KOJAD9EoEWkfTwTxY0LiS4JzCYkTGM6QnifJTEV94U086977
Am+/Efj048HfbPB89PDHipKDgTfe+lngjfv3b/h40P+RCJIRHccA7hg0yaRRqNWIA/RRkdqlJBL1
8u1n1w6ZmQ1Du5ljipJ9gbo7AsZ9SMLDfgF4ooiGQnhkVx6Nxc+WD3Ux9UM/IBhq9w7dKfPxRYgP
NjoaKWG9ejQfeRAFefEGqP2nmPdPnhziFSVDrzL5Xz5FWJL5wFbAwyLNY2EOpKX+U8QJZV7fARgF
ijsNMKxMRSaQCKi7FSVfme+R8SkOUx/UmbRsVCyr0ShH8ZZQmJNMPRB8HxPupKf/BfxeJX776cGF
gXk9gdkLFSUXP2InffkU94OLX7GKr+pJXBG/6gK/Auxg2YngVdqQV0W6lGTf6SHryq7FXHgz8Kvb
bsNT33wTp952W+DXbx55qanppSPUscIO5Q+8dO5c4BX/3tv/vG//n/fu/fP+fX++HUlexVWDZBrw
KuLVMTEocQyb5coBpY+HthRRfvyb/pe83pf6A6/htE377+oLvKsoaT67fevJdUO/Y473X79zi4z/
bsCfBFEDsRuVnJyYiHigMG7M2KXBO5VJHm9gIXokaiFyQ90/Fnf7lrUumth4ZvmEeeuWB57HuVUb
K7ZdH3hZUVJ1/3UDp/iYZTc0Bx7B+XXdVw29yPx0/vqlG64D+y0LXuAWgIZz0FRTQmasIn7G1MQ0
NdJPYsHLQwGcTAM4IyM/T4pYqubp2aD9ApJUkxINBTTHwmzyVIaog1m+57c3PdZ0YF3DrfUld99w
1/PNjldu3vKfN5zCD/XfsHvh/h33Prduy/sJjU/u69yUm9e+snxNqX5G8y6n577a+uP9Yne7pbja
ZJjVsm/TlhOriJ/B/sU+SzPseFOUSi0qGYZlCHvxeeCYQrw+n0QOvi1wA+sPbOFO7N//VQNZFwda
bqZxM9kUx2FVNBcFSyMimLomhrxMPgaM4/AzgWvO4QW48tlAE372jcDxwP3MWeamod8z44a8Q1VM
9tAb9CdFiFsJeNUQj7FYxbHg9cywd1CVCfES2nh8PpD3IrZg4T8CucxEdtZQD+O7+PbQbyEK54Or
vUPjUQU8JpqiY7Ca7Bsqyh8wmEvw5MWny8kB55wKNDCHh5rJTeL1rrsUJXcRf10fvMB+n30PTUUz
kN4UPzlaVBsM45BmgkrUpaIYGV18YSHVGDXn3IK0ecPbI5gSjBdvmK5UQijNy+eIQfG99TfXPYgz
X97cbPMdaX+se+lNTtO9qtLBKuuhgsAXHzUlmPrXbd05h1nc39TWtfGOxalV2+xD3XcsXTtwzZIX
2Ws6K1eDttYHP2VfprzB7hg7OXYy0qpVYrLEFd0hcnLCPBVIe0RGyKVCW0TWjec8G17dseExB/s9
5ebOXbcsvO6azu3s91jn2XjXe8ePf7Ch6k7xGsdz/u4HVrs6e+5bEdLKu+RsBBlkikkbFy3GInFy
DFAfrw0rJddoHEE9mSRRWQ3xIT7whd6Hm21n+jsO5By7P2rug8s7d2XO3GbbtuP6BPHDY0f/a8Pa
FYzmy6d2VZhvslXg3trOpx557CmZg3Mg+2SkJ3GekoTGQTojDITEhzhPKMwbwQEJdv1URhYd6ykT
TMHBV1ubn9v3H79imKEqXDxgd18H4ltPBQRmAruzb9PNCdv+e/edHw589sG4mVHNB1vslvY7VzLm
nXt2Ax+3QDg0KSroCUv7eDSHlSKKJt76Wq6U2dmI49PhY/U5xChFRexrF3O5bfNmzZpHbrDlYcCz
hH1N2kFCOCQMh48RaDi9yLSUGTgZWiru8cCPIWCiH6VEja/NnoOY4K8DByg/MSiZxHSCRqUUIV6p
SghLpfRgAlgnKA3jI1hLNVZWHttx4LzMX+DAzrKVXNJXf7n9gOJ/wmwiTPETPmNgF4tAPRKxjCwC
CUhINuzf08wfd1qBxGgqIlkpEAORhUl5eYn4bO912UdzzFlLb7Vwqot4bctO0DJoR7mAfRdNQOnI
YEqYOlmv17JKlQiCp8MOEi2nLPA5eEh7drJkcdgYpc1LBdu33JouTx0+pDQe3Xxk1/EpKyrbdxm5
5VNWLOnYlT2paBAG2df2FdufemjoFmZdRdfVluKhFbQhFG8ydZFhyWbs65SrZJMmxI/MjZHmmDH5
ALJZx7ceuv3Y1OWVzjuyKKEfnYggJEXYZxxiPwjv0SpRG3LskSFN9oVL9ujZu891dp7bfftPXK6f
3O4YmD9/wGG/tqDgWm3fB/cc/HDTpg8P3vNB37bmY+sdDwnCQ471x5qRJA+zk/0FZPdEU0yULI/k
iZHS5CUSOiDHfcqZt3dPSK7squXZ144ua7s7ozRzqJ5gaoPo7IfonE33P41y3Iyp48n+N1EFe0TM
iP0P9jvY/6TTMt38FjI0Yxrmjtj8IFy/rN3rvvrwreubr3XdIt67Yp5l+4rlO9oXHNlsXuPO7bE6
71habL81IW3F9WvEpsr6JeX6lApn3SJLiT5t2cb6jlWmxdMLjBMnL9nQuMxVMY1wyZPfKeJ+CPZL
McUp4+JiotarYpRigmzBXGNefF7IPQ35efl5iSC67Ka/6bku54EHjn72WY55Pbgqo9nx3ns7hi6u
FXYQzPuDv2d/DlEieUa0OI4DtNHhzCjlRcnnaSKWMyN++/v7jk+tr+66I+v4YUXOiXFPfo/ZPHRP
SUfR2gXMyYu5+4o6kbRLsvcDdiXZ2VgFUoTNRI6FwLG87/YEfIOYx4aHAnsgg7zNzrqYSz3rd+wv
2f+iuTvdNGFctKhRismTafZOGh/O3xBOtBqVw/PHyuGf9j3SZH2833l3Nsnh36t27jHO2GHbetPA
+A3vHz32vmfN0jsv5u5dunanvQr3Vdue8T/6JPHxOiaL+QpOSakoA3J4LD9lil49Tj2RnYw041FO
3vO5ybCr5hIbLJI5mDfitTMpYluljo+rSjYs3nrhyDVLlrXtPb179e6GW1Vzb82puU7/6iOVTNbc
9mWdnTOYgtWLK6p912Z77EN/dl61eEP11beyS1cWlUgcsYvoyTgVxT2mVSN7sho4ITG36NKYk0OO
EH5ePGo2HxV7Hmpqeqin35bZWt9ttTJZwqn+gcdahMeu7z8l9B3qqx2oOrS57xDYkPymIGNRTKL5
ntGKKEHK98R0gWfYyTsv/rdi0pcfES39MPgFPkHfcRJJRkdabTRnj6bw1D/rMhjqSYwqcqsZ0iY/
khyfM7+ycn5BRQW+z4vT95I34b2BX3gC5sr8gvLygvxK4k2wlzCH5HcXhNeHOCEv1cn4k4OBJPn9
xYKPMauYYoBTD0KXHNTr4HhowX/Ex+64g/plcAL7cNATCdEAEOzD/9tM80snk8dcw7w4GkMn/iOT
t3cvgbgxcA8Tp6gC/Uc/CsoH3QMnizIY8kaSMC9PCYkgIRlvW+m5aoGn9qYe8Yb2wD23YBWe+MAh
nI6Ttr8SmHfhrUDjSYKrKnAP/pmMS4nsSoqrriAhfy4zPS8pgbzcMKqqXnFL+85a71VXeeoC97yK
X/70LXz0pC/w18BvHzgU+EXgkx2AaVswiRmneGEkV2Wjudpe45W42jDQ/onE1EGcITH16ZuEKeAp
mAQ8vTCSp9WX4emTYZb+EvgYWHon8Ml24hXb2AZWp1iF4pEBspdmSkzMVI0mQYXsk1TUYck+KEcO
DZxkyNjTqWfoLxlhNs2vKPEsmW6qU8XMq6wIrAx1lRrosg011eZbWlNW65pKosrmzisb1SXfqwwA
N5MVq7jpXCzugfSk5GLJL1eRcfwg5VJ7mlMoYpA9BkSmr1910wkPER6rPDbdVKvSEI+dX1Eqsg2r
+XUSheoaIAgyb2cdjItGwniIzmgOrY/jQtEJwQn5mZzvwi38sWbc4bjYwAqN9si4GNbR7F/f1NT5
g9bQE2F8jtvG3E9PS9GPIuV6JPlbBFNMPhyGyIEo4rAG695XnGYtyufAk2EdDq0bDzn3/WefCQQV
p3Fs4I+ggWa0Ex34O8t76D08NaIsiyjuv6PsGVVO0fLiNyjvDhcmZlSp/Falj5YnpcJqR5XMf7A0
spsvUw6PWT79NoXLjCjOiDL4Tyg/4z4Kl7+OLIqZivKIYo0ojyh+ObIok/+BskAuuy8pT4bL/3yT
oor+O0r1P1zuUp2/Uq6UK+X/g/Krf31RJ4xZMqDMC5cKKI1yuU79QLi8pP5dZImaG2WC0h5R9lwp
/5Tyg7+zPP2vLXAezMCvSe/v8AY/H8nv8lAroIflv5xQsRvkNhsxzkW0FSie3Si3lRHjKlQYbsfi
59mb5HYcMiqWy21tBHz8MC3MIaVCxokVSKG4Tm5HRcAUI41iq9xeAPC7yV93cFHAhFtxp9zGKFqj
kNsMitP0ym02YpyLaCvQNM02ua2MGFchMdxWowTFA3I7CqVqjsntGFSveU5ua9Ds2GS5HcvujK2Q
23FolfYnclsbgT9+mDeQXROfLrcVKDp+jtyOioApRhPji+X2AoCv+z6fOzt3Lr/cbhFdHlebly91
iW6XKHjtrq5sfpHDwdfa2zu8Hr7W5rGJPTZrNl/fYeOnddrErmm8V2h12HhXG+/tsHv4NleXl+8V
PLzV1mNzuNw2K2/v4t2C6OW7Pfaudl7gPd5uax/f2scv6rKKu/jybkuHh3d1wXobL9octh6hy0IR
EvxkiVuwix5+RofX6/bAG0y73dvR3ZptcTlzBMBgy2ojGHJk6CwKndPqcLXmOAWP1ybmLKssLVtR
V5bttM7MBtncfSIRB4SeUxjJQzZfYxOddo8HxOZBlA6baAMu20Why2uzZvJtoo2yZekQxHZbJu91
8UJXH++2iR5Y4Gr1CvYuSUIL0AhrhGi0VxBtAGzlBY/HZbELgI+3uizdTluXl6qZb7M7bCAj0cG0
OnnFtJmUiNUmOIgSyVxoiu8FJbi6vaAwj1e0WwiOTACyOLqthIfQtMPutMsUqHolOwLSbg9IQPjM
5J0uq72NPG1ULHd3q8Pu6cjkrXaCurXbC4MeMmixdZFVIEeOS+Q9NnAMwGAHvqmsw9xRGELFTRTq
lVVE6fZ2uJwjJSFO0w2m83TY6BqrC1RGKa63WbxkhIC3uRwOVy8RzeLqstqJRJ4i6oZCq6vHRkWR
zNrl8gKnEgdE/+5ho8pTng4BWG+1yfqSXFSIkEYk1D1esLsdVA+hQMmNljJ7kdvr8hD+Bd4rClab
UxA7Q0DDwdQuurrd1G9cTrfQBQSya23t3Q5BXAVqIWzlZs+eU1ydV5A/vMjT7XY77MAZiads3uzq
5p1CH7FaRJiBaiyiTSD2AVu5HUKfpHi3aIdZ0JMX3AtcTjYDcTrwZ8KdbEseosNJ5ZUbbZJfXCKD
W3RZuy1esArEP6zNJGtCBEB5vR12S8eoBBBS7jD3ri5HHz/DPpO3OVtt1ghwwHA5bik4desIb/eM
sF4YVzHVwAw7UPHanCSLiXaganX1djlcgnWk9gRJVTaRiOMCUlB3e90QN5C9iKcATIfN4R6pUUiJ
EPYSODEI8THR1WFvtQPP2aEsBeHtyXaGNEizlbfP7YJs4u7oywGn7fauthGHXW23ejuq3eCZ4Gt1
9k22Sq8A9kHfRzzKRbPhJn9quBzZkQWJyIU8cLchL4yVQktEbloLMGKHVhfKhplFyAGFR7Uw1o46
YM5DezZ42gC6B2orhayHWRs8p6FOOtMFLR7gBdQKGMgMoUZGOgAXwdJGqRD6vQBFRqwARzA6YMZN
MfMA2wW1GyBECtsNkGSsHdoC3B4Y7QbIPmi30noRzFoB+mNol8OcBSh6KP0umT7hRqR0CD0Bxi0R
HIb4D1Fx0z9YFCmOGVQHXhjzoCKUA6Ud5gjObqCeDXhcyAmjgsyDDWUBzhAPOaNwZ0XgzqF6ckGd
AxgEKheBzUHLUCVYqAytQHVQZ8OsFc2kOi+leuoDqJB1JEvPQYVfqweyroZidlI7eGRr87JVOuic
TdZlO/WILsqLFWVSq5HZYW0RrMQ27TCWSfXropbpouvdFJtHpkCk81KJu0bY0CLLcamPhHy0l9Kw
yZit9Omhs+QPXQWZP+JBZKQbZLNRroe9mXBupxaX7OgN+2vdKBrkD3GHJSE+KdAYsI/wn9GriBdL
nuAC+l7Zw4gVRRpxIT4yZUwWwNlNf1lR0sPo1Q7oO+lYpAzD3hsZjxKn3TQmMyP0SdpOaBMqbeG+
LcJabuq3DqrtDjpipW2J61bKiwTpCUNaqG5DtCR75NDcwdNRKWNIPNhlfQ/bdSzdZUbYVZLFHfZQ
7ygvGpa3l2rLeVmbhDJNtxx1Hgo5TMdKa4J5WMb1AGGhdCWYEHaSrxw0RnvDVrNQnqyUT7vMX1FE
NiTZz0Vz2rBVIqO1C8a8sk4jdRDy/2E9REbqyFUeGoGS1ltlqYf9KzKLCl9jGzEsu4f6WxfFLnm9
tCsMS/e3bJkNecdNNecJ61+g8CSTEH6cFLLzEkxj7UzttN8NGIfzDbG5m3IpSZBN96N2+kvFBPMq
2VtC2soFCJITi1E1ykMFKB949so7DaEq0Ixuk/0rlN+l7N5LSza1wEjehnO9F2xKtCTlSjdg6IPR
0O7mkfN5JI1LVxDsnjDOsTThoVpw0wiUbBqiQDK6mWqJp5T6wrlg7N1W8moLtZYQjm8p7t1Uh30j
ItJNPVZaa5Gx2OS+MMpLveFMLO0fIduOzBu8vLc5I/xv5EjbiHz2t/3ETftWust55ViWzicS3cww
ndESSJHRK9ug42t0FjqhjI6ssXRP1jhoawbAz4Qn8fnWcN65FLvEw7fV7TD24d1k7L1nLAki97WR
fBVH+ACRRJLFS+mFzooi3VP75EzaSyV30Ti/nO8JI7zKRu3ikmuvfALh5Z3QLe+H0tkwlPMkPB10
t3Ff1kelU2yXbJlh7KEICeVZ4j8ddM+zy3rOvuSsJ50uPN8qH0g7AZFlNWAP7QCroWWlXFXTrEmw
Snm3DtqbALKSZmQpflD4/wQH7yX/93jMC8tP8h872Fa7wyq3rVZHVzs874I73yO1yX8mzicvMfUu
lwNeg+dmzy3Mnl3Md7e5ctu8RXxe9hzSbXf0uTs8y+ytRXxBNpRi3ukhqxxkZHZ2Yfb8YvLmQl+z
2+3ku4QeO3khLeLzLZY5sy35lmWCtyuTL+0THZl8hWizdWbyPfYsabS1PUua8Ihyo7uTNr7VIqoB
jNT0Lz0m0HouYlxuzyZcjFAvvCdhDuFeeFXCCsTY4RUJLyC/fYFSYZNYQP9LC4PJd2cIxUw6gLT0
+0dMxvAeQC3CfYbSYCiclbZZ2kbyeJxkAKYW2i30/59g+vs8GMKIfM9YBKGF0UIoGJkgfWC0FpHv
FgfQbVDvRSegfhidhfr/oAtQf4b+APXnwC/GKqCDcQzWIPILxDOhNuJqqFdiC9Q23A/19dgH9S34
YagfwSeBt9P4NLTP4Ceg/hH+EdRP41fIz/rJd6/4p/gtqN/GP4f6l/iXUH+AP4D6Q/wbqP+AgTr+
HH8B9V9wEGGGZVRQRzExUMeR/7PNJDBToNYxs6DOZLKhzmcKoV7AXAV1KbMc6pXMSqjrmHqoVzGr
oTYza6BuYUBHjJVZD7WTcULtZtxQ9zIDUG9ntkO9i7kd6ruZQ1AfYX4A9SPMINSnmFNQP848DvUT
DMjF/Jh5GuoXGZCL+Snz/zq4exaCoyiO49c5v38mkkEmg115BSJ5G96aV2AhBmyeBrM8RkoxCBlM
ku/f8uks99a59zed4SxxZWvc2hb3tseDHfFk9Ghnu+HDnvgyOrW3ffBr35BwWsWk8+ae9jRmPINZ
z2LOc5j3PBa8gEUvYdnLWPUa1r0eEqqIv1ZDDWyqiS21sK1OcHXVo+5rQ73TjvqiK96j6J9l/8+o
AxmK9+/Eu8U7mmqmOflyzg1C0EjjEGnBHak4gxpq8gPsU2jODQplbmRzdHJlYW0NCmVuZG9iag0K
MTQ0IDAgb2JqDQpbIDBbIDQ3MV0gIDFbIDU4OV0gIDI2WyA2MDRdICAyOFsgNjkyXSAgMzRbIDY4
Nl0gIDQwWyA1NTZdICA2MlsgNTI0XSAgNzBbIDcwN10gIDczWyAyNjBdICA5MVsgNTAwXSAgOTdb
IDc5MF0gIDEwNVsgNzMyXSAgMTMyWyA1NzddICAxMzVbIDYwNl0gIDEzOVsgNTY2XSAgMTQ3WyA0
NzldICAxNzlbIDU1MyA1NDBdICAyMDVbIDUzMV0gIDIzMlsgNTI1XSAgMjM4WyA1NjFdICAyNDRb
IDUyN10gIDI3OFsgMjM5XSAgMjkyWyAyMzldICAyOTlbIDI2MF0gIDMwNVsgODUzIDU1MV0gIDMx
NFsgNTUyXSAgMzQ0WyAzMzRdICAzNDhbIDQ4Nl0gIDM1N1sgMzIzXSAgMzYyWyA1NTldICAzODFb
IDQ1Ml0gIDk4NVsgMjAzXSAgMTAwN1sgMzM5XSAgMTAwOVsgMzQwXSAgMTAxNFsgNDYwXSAgMTAy
MFsgMjkzIDI5M10gIDEwMzRbIDQ1MiA0NTNdIF0gDQplbmRvYmoNCjE0NSAwIG9iag0KWyAyMDMg
MCAwIDAgMCAwIDAgMCAyOTMgMjkzIDAgMCAwIDM0MCAwIDMzOSAwIDAgMCAwIDAgMCAwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgNTg5IDYwNCA2OTIgNjg2IDU1NiA1MjQgMCA3MDcgMjYwIDAgMCAwIDc5
MCAwIDczMiA1NzcgMCA2MDYgNTY2IDQ3OSAwIDAgMCA1NTMgNTQwIDAgMCAwIDAgMCA0NjAgMCA1
MzEgMCA1MjUgNTYxIDUyNyAwIDAgMCAyMzkgMjM5IDAgMjYwIDg1MyA1NTEgNTUyIDAgMCAzMzQg
NDg2IDMyMyA1NTkgNDUyXSANCmVuZG9iag0KMTQ2IDAgb2JqDQo8PC9GaWx0ZXIvRmxhdGVEZWNv
ZGUvTGVuZ3RoIDI5Mz4+DQpzdHJlYW0NCnicXZFNasMwEIX3OoWW6SJYchy3BmNInQS86A91ewBb
GqeCWhayvPDtK42SFDogwcfME09vkro5Nlo5mrzbSbTg6KC0tDBPixVAe7goTTinUgl3JbzF2BmS
eHG7zg7GRg8TKUuafPjm7OxKNwc59fBAkjcrwSp9oZuvuvXcLsb8wAjaUUaqikoY/EMvnXntRqAJ
yraN9H3l1q3X/E18rgZoisyjGTFJmE0nwHb6AqRkvipann1VBLT81y+iqh/Ed2fD9P7ZTzOW1VWg
+oiUc6TTU6RdIM7zSAXSLo10inSIdEbK90iPWaDdniN5QaBjgZQydHf1wW+ubp/IGD6YseAuZby+
Tsd++FZI/56ZWKz1ceGKMKeQkNJw36KZTFCF8wtkqZLBDQplbmRzdHJlYW0NCmVuZG9iag0KMTQ3
IDAgb2JqDQo8PC9GaWx0ZXIvRmxhdGVEZWNvZGUvTGVuZ3RoIDk0MzYvTGVuZ3RoMSAyMzI3Mj4+
DQpzdHJlYW0NCnic7XwJeFNV2vA5994sbdOSlC7QluaG0LCkG92gpZTQ0tKFpXQPlNLbJG0CSROS
lFIWqQjiRGXcRcdRUGdccDBFUeDzm08fdZxvPnH89fd3XJFBnXEWx08dx19p87/n3Js0LbiMjvo9
/8M9ue89y3ve/bzn3FCCMEJoCgAOmVY35xWsyLonEyG8FXq7m1uWtrw063kWofa3oL3D4hI8m35i
uxah5I8Bh7Ns8fO6q5KfQmjOVTD+eK+nz9V+5RQ1QimfAtHL+pxDvaeWW29BaO4KaD9ltwnWrOv/
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
YqsQ5io48DVXzVUD7OK6AN7B3QHwF9xRxHIPcceg/gj3CtRf416D+h+4PwJ8XyajsczS78MRxBD5
/Q/6O8rc09yvuGfI/1+AeScR4h7jnkQy7r+ARjyJQe7fuKf+H//DV3gNCmVuZHN0cmVhbQ0KZW5k
b2JqDQoxNDggMCBvYmoNClsgMFsgNDcxXSAgMjZbIDYxOV0gIDI4WyA3MDddICA2MlsgNTM3XSAg
OTFbIDUxMl0gIDEzNVsgNjM0XSAgMjA1WyA1NTJdICAyMzJbIDU0OV0gIDI0NFsgNTU2XSAgMjc4
WyAyNjhdICAzMDVbIDg4OSA1NzldICAzMTRbIDU3M10gIDM0NFsgMzY5XSAgMzU3WyAzNTVdICA4
NDhbIDUzNCA1MzRdICA5ODVbIDIwM10gIDEwMDdbIDM4N10gIDEwMzRbIDUxOSA1MjBdIF0gDQpl
bmRvYmoNCjE0OSAwIG9iag0KWyAzODcgMCA1MzQgNTM0IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAw
IDAgMCAwIDYxOSA3MDcgMCAwIDUzNyAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgNjM0IDAgMCAwIDAg
MCAwIDAgMCAwIDAgMCAwIDAgMCA1NTIgMCAwIDAgNTU2IDAgMCAwIDI2OCAwIDAgMCA4ODkgMCAw
IDAgMCAzNjkgMCAzNTVdIA0KZW5kb2JqDQoxNTAgMCBvYmoNCjw8L1R5cGUvTWV0YWRhdGEvU3Vi
dHlwZS9YTUwvTGVuZ3RoIDMyODA+Pg0Kc3RyZWFtDQo8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9
Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/Pjx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6
bWV0YS8iIHg6eG1wdGs9IjMuMS03MDEiPgo8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cu
dzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgo8cmRmOkRlc2NyaXB0aW9uIHJkZjph
Ym91dD0iIiAgeG1sbnM6cGRmPSJodHRwOi8vbnMuYWRvYmUuY29tL3BkZi8xLjMvIj4KPHBkZjpQ
cm9kdWNlcj5NaWNyb3NvZnTCriBQb3dlclBvaW50wq4gZm9yIE1pY3Jvc29mdCAzNjU8L3BkZjpQ
cm9kdWNlcj48L3JkZjpEZXNjcmlwdGlvbj4KPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIg
eG1sbnM6cGRmeD0iaHR0cDovL25zLmFkb2JlLmNvbS9wZGZ4LzEuMy8iPgo8L3JkZjpEZXNjcmlw
dGlvbj4KPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgIHhtbG5zOmRjPSJodHRwOi8vcHVy
bC5vcmcvZGMvZWxlbWVudHMvMS4xLyI+CjxkYzp0aXRsZT48cmRmOkFsdD48cmRmOmxpIHhtbDps
YW5nPSJ4LWRlZmF1bHQiPjwvcmRmOmxpPjwvcmRmOkFsdD48L2RjOnRpdGxlPjxkYzpjcmVhdG9y
PjxyZGY6U2VxPjxyZGY6bGk+U3Jpbml2YXNhbiwgVmlqYXk8L3JkZjpsaT48L3JkZjpTZXE+PC9k
YzpjcmVhdG9yPjwvcmRmOkRlc2NyaXB0aW9uPgo8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0i
IiAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIj4KPHhtcDpDcmVhdG9y
VG9vbD5NaWNyb3NvZnTCriBQb3dlclBvaW50wq4gZm9yIE1pY3Jvc29mdCAzNjU8L3htcDpDcmVh
dG9yVG9vbD48eG1wOkNyZWF0ZURhdGU+MjAyNi0wNy0wMVQxNDozNzozNi0wNzowMDwveG1wOkNy
ZWF0ZURhdGU+PHhtcDpNb2RpZnlEYXRlPjIwMjYtMDctMDFUMTQ6Mzc6MzYtMDc6MDA8L3htcDpN
b2RpZnlEYXRlPjwvcmRmOkRlc2NyaXB0aW9uPgo8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0i
IiAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iPgo8eG1wTU06
RG9jdW1lbnRJRD51dWlkOkUwRUNFMDA3LTUxNDAtNDFBQy04NDg3LTM2MkNEN0ZBOUY2RjwveG1w
TU06RG9jdW1lbnRJRD48eG1wTU06SW5zdGFuY2VJRD51dWlkOkUwRUNFMDA3LTUxNDAtNDFBQy04
NDg3LTM2MkNEN0ZBOUY2RjwveG1wTU06SW5zdGFuY2VJRD48L3JkZjpEZXNjcmlwdGlvbj4KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCjwvcmRmOlJERj48L3g6eG1wbWV0YT48P3hwYWNrZXQgZW5k
PSJ3Ij8+DQplbmRzdHJlYW0NCmVuZG9iag0KMTUxIDAgb2JqDQo8PC9EaXNwbGF5RG9jVGl0bGUg
dHJ1ZT4+DQplbmRvYmoNCjE1MiAwIG9iag0KPDwvVHlwZS9YUmVmL1NpemUgMTUyL1dbIDEgNCAy
XSAvUm9vdCAxIDAgUi9JbmZvIDIxIDAgUi9JRFs8MDdFMEVDRTA0MDUxQUM0MTg0ODczNjJDRDdG
QTlGNkY+PDA3RTBFQ0UwNDA1MUFDNDE4NDg3MzYyQ0Q3RkE5RjZGPl0gL0ZpbHRlci9GbGF0ZURl
Y29kZS9MZW5ndGggNDE1Pj4NCnN0cmVhbQ0KeJw107tPk2EUx/G3gBbt/aZiW/r2gihqvYFaK0IL
yq22TToTHVhr4qJx0kQSoxMLiSszTiRsbiYMJsbGwdH0HzDuHSzvOV9Oh35yfs8553nT9HUc7zMc
+rzvmOMIh/BXGYkrgeewC9+V4Esl9EwJB5WIA+9hT4kuwicl9kaJ+yAH35RESElylqrBO+9BvL2u
04Cn0IQWbMA6nAy0Zbxn1Qj4YBROwRic9gbSW3ptes/m/FL90jATsXAcAnAGzkIQwhCCiIzX2fLW
tkQhDjFISMsBnf+sU36TrKthdtPCc5CC83K2Q8sPa5mAC5CGi5CFDEzK3H8dn6zauAs5KEAeitL5
goF9G7gEJZiCyzANV+AqzMA12fJHl+XStuy6VA3CjxaWpfpKOLDwhle5ZQ3droW34CbcljP+kW7f
Wu54VT6pYb5j4axUHwiPLLwLc3APHsB9qEAV5uEhLMAjWJTVA72hULEbarAEdViWli6dX6zzsVR9
DYs5C1fgCazBqrR0tLP0W2l8VpotpcXr2+4pr/zA2/96X9n+6TjH3TVEtA0KZW5kc3RyZWFtDQpl
bmRvYmoNCnhyZWYNCjAgMTUzDQowMDAwMDAwMDI0IDY1NTM1IGYNCjAwMDAwMDAwMTcgMDAwMDAg
bg0KMDAwMDAwMDE4MSAwMDAwMCBuDQowMDAwMDAwMjM3IDAwMDAwIG4NCjAwMDAwMDA1MzAgMDAw
MDAgbg0KMDAwMDAwMjkxMiAwMDAwMCBuDQowMDAwMDAyOTY1IDAwMDAwIG4NCjAwMDAwMDMwMTgg
MDAwMDAgbg0KMDAwMDAwMzE4NSAwMDAwMCBuDQowMDAwMDAzNDIzIDAwMDAwIG4NCjAwMDAwMDM1
OTYgMDAwMDAgbg0KMDAwMDAwMzg0MCAwMDAwMCBuDQowMDAwMDAzOTcxIDAwMDAwIG4NCjAwMDAw
MDQwMDEgMDAwMDAgbg0KMDAwMDAwNDE2MCAwMDAwMCBuDQowMDAwMDA0MjM0IDAwMDAwIG4NCjAw
MDAwMDQ0NzMgMDAwMDAgbg0KMDAwMDAwNDYwOSAwMDAwMCBuDQowMDAwMDA0NjM5IDAwMDAwIG4N
CjAwMDAwMDQ4MDMgMDAwMDAgbg0KMDAwMDAwNDg3NyAwMDAwMCBuDQowMDAwMDA1MTIxIDAwMDAw
IG4NCjAwMDAwMDU0NDEgMDAwMDAgbg0KMDAwMDAwNTUwNCAwMDAwMCBuDQowMDAwMDAwMDI1IDY1
NTM1IGYNCjAwMDAwMDAwMjYgNjU1MzUgZg0KMDAwMDAwMDAyNyA2NTUzNSBmDQowMDAwMDAwMDI4
IDY1NTM1IGYNCjAwMDAwMDAwMjkgNjU1MzUgZg0KMDAwMDAwMDAzMCA2NTUzNSBmDQowMDAwMDAw
MDMxIDY1NTM1IGYNCjAwMDAwMDAwMzIgNjU1MzUgZg0KMDAwMDAwMDAzMyA2NTUzNSBmDQowMDAw
MDAwMDM0IDY1NTM1IGYNCjAwMDAwMDAwMzUgNjU1MzUgZg0KMDAwMDAwMDAzNiA2NTUzNSBmDQow
MDAwMDAwMDM3IDY1NTM1IGYNCjAwMDAwMDAwMzggNjU1MzUgZg0KMDAwMDAwMDA0MSA2NTUzNSBm
DQowMDAwMDA3MDEyIDAwMDAwIG4NCjAwMDAwMDcwNzMgMDAwMDAgbg0KMDAwMDAwMDA0NCA2NTUz
NSBmDQowMDAwMDA3MTIyIDAwMDAwIG4NCjAwMDAwMDcxODMgMDAwMDAgbg0KMDAwMDAwMDA0NSA2
NTUzNSBmDQowMDAwMDAwMDQ2IDY1NTM1IGYNCjAwMDAwMDAwNDcgNjU1MzUgZg0KMDAwMDAwMDA0
OCA2NTUzNSBmDQowMDAwMDAwMDQ5IDY1NTM1IGYNCjAwMDAwMDAwNTAgNjU1MzUgZg0KMDAwMDAw
MDA1MSA2NTUzNSBmDQowMDAwMDAwMDU0IDY1NTM1IGYNCjAwMDAwMDcyMzQgMDAwMDAgbg0KMDAw
MDAwNzI5NSAwMDAwMCBuDQowMDAwMDAwMDU1IDY1NTM1IGYNCjAwMDAwMDAwNTYgNjU1MzUgZg0K
MDAwMDAwMDA1NyA2NTUzNSBmDQowMDAwMDAwMDYwIDY1NTM1IGYNCjAwMDAwMDczNDYgMDAwMDAg
bg0KMDAwMDAwNzQwNyAwMDAwMCBuDQowMDAwMDAwMDYzIDY1NTM1IGYNCjAwMDAwMDc0NTYgMDAw
MDAgbg0KMDAwMDAwNzUxNyAwMDAwMCBuDQowMDAwMDAwMDY0IDY1NTM1IGYNCjAwMDAwMDAwNjUg
NjU1MzUgZg0KMDAwMDAwMDA2OCA2NTUzNSBmDQowMDAwMDA3NTY4IDAwMDAwIG4NCjAwMDAwMDc2
MjkgMDAwMDAgbg0KMDAwMDAwMDA2OSA2NTUzNSBmDQowMDAwMDAwMDcwIDY1NTM1IGYNCjAwMDAw
MDAwNzEgNjU1MzUgZg0KMDAwMDAwMDA3MiA2NTUzNSBmDQowMDAwMDAwMDczIDY1NTM1IGYNCjAw
MDAwMDAwNzQgNjU1MzUgZg0KMDAwMDAwMDA3NyA2NTUzNSBmDQowMDAwMDA3Njc4IDAwMDAwIG4N
CjAwMDAwMDc3MzkgMDAwMDAgbg0KMDAwMDAwMDA3OCA2NTUzNSBmDQowMDAwMDAwMDc5IDY1NTM1
IGYNCjAwMDAwMDAwODAgNjU1MzUgZg0KMDAwMDAwMDA4MSA2NTUzNSBmDQowMDAwMDAwMDg0IDY1
NTM1IGYNCjAwMDAwMDc3OTAgMDAwMDAgbg0KMDAwMDAwNzg1MSAwMDAwMCBuDQowMDAwMDAwMDg1
IDY1NTM1IGYNCjAwMDAwMDAwODYgNjU1MzUgZg0KMDAwMDAwMDA4NyA2NTUzNSBmDQowMDAwMDAw
MDg4IDY1NTM1IGYNCjAwMDAwMDAwODkgNjU1MzUgZg0KMDAwMDAwMDA5MCA2NTUzNSBmDQowMDAw
MDAwMDkxIDY1NTM1IGYNCjAwMDAwMDAwOTIgNjU1MzUgZg0KMDAwMDAwMDA5NSA2NTUzNSBmDQow
MDAwMDA3OTAyIDAwMDAwIG4NCjAwMDAwMDc5NjMgMDAwMDAgbg0KMDAwMDAwMDA5OCA2NTUzNSBm
DQowMDAwMDA4MDEyIDAwMDAwIG4NCjAwMDAwMDgwNzMgMDAwMDAgbg0KMDAwMDAwMDEwMSA2NTUz
NSBmDQowMDAwMDA4MTI0IDAwMDAwIG4NCjAwMDAwMDgxODYgMDAwMDAgbg0KMDAwMDAwMDEwNCA2
NTUzNSBmDQowMDAwMDA4MjM4IDAwMDAwIG4NCjAwMDAwMDgzMDEgMDAwMDAgbg0KMDAwMDAwMDEw
NSA2NTUzNSBmDQowMDAwMDAwMTA2IDY1NTM1IGYNCjAwMDAwMDAxMDkgNjU1MzUgZg0KMDAwMDAw
ODM1MyAwMDAwMCBuDQowMDAwMDA4NDE2IDAwMDAwIG4NCjAwMDAwMDAxMTIgNjU1MzUgZg0KMDAw
MDAwODQ2OCAwMDAwMCBuDQowMDAwMDA4NTMxIDAwMDAwIG4NCjAwMDAwMDAxMTUgNjU1MzUgZg0K
MDAwMDAwODU4MyAwMDAwMCBuDQowMDAwMDA4NjQ2IDAwMDAwIG4NCjAwMDAwMDAxMTYgNjU1MzUg
Zg0KMDAwMDAwMDExNyA2NTUzNSBmDQowMDAwMDAwMTE4IDY1NTM1IGYNCjAwMDAwMDAxMTkgNjU1
MzUgZg0KMDAwMDAwMDEyMCA2NTUzNSBmDQowMDAwMDAwMTIxIDY1NTM1IGYNCjAwMDAwMDAxMjIg
NjU1MzUgZg0KMDAwMDAwMDEyMyA2NTUzNSBmDQowMDAwMDAwMTI0IDY1NTM1IGYNCjAwMDAwMDAx
MjUgNjU1MzUgZg0KMDAwMDAwMDEyNiA2NTUzNSBmDQowMDAwMDAwMTI5IDY1NTM1IGYNCjAwMDAw
MDg2OTggMDAwMDAgbg0KMDAwMDAwODc2MSAwMDAwMCBuDQowMDAwMDAwMTMwIDY1NTM1IGYNCjAw
MDAwMDAxMzEgNjU1MzUgZg0KMDAwMDAwMDEzMiA2NTUzNSBmDQowMDAwMDAwMTM1IDY1NTM1IGYN
CjAwMDAwMDg4MTMgMDAwMDAgbg0KMDAwMDAwODg3NiAwMDAwMCBuDQowMDAwMDAwMTM4IDY1NTM1
IGYNCjAwMDAwMDg5MjggMDAwMDAgbg0KMDAwMDAwODk5MSAwMDAwMCBuDQowMDAwMDAwMTM5IDY1
NTM1IGYNCjAwMDAwMDAxNDAgNjU1MzUgZg0KMDAwMDAwMDE0MSA2NTUzNSBmDQowMDAwMDAwMDAw
IDY1NTM1IGYNCjAwMDAwMDkwNDMgMDAwMDAgbg0KMDAwMDAwOTQzMCAwMDAwMCBuDQowMDAwMDE5
NjA4IDAwMDAwIG4NCjAwMDAwMjAwNDcgMDAwMDAgbg0KMDAwMDAyMDMxOSAwMDAwMCBuDQowMDAw
MDIwNjg4IDAwMDAwIG4NCjAwMDAwMzAyMTUgMDAwMDAgbg0KMDAwMDAzMDQ0NSAwMDAwMCBuDQow
MDAwMDMwNjM1IDAwMDAwIG4NCjAwMDAwMzM5OTkgMDAwMDAgbg0KMDAwMDAzNDA0NSAwMDAwMCBu
DQp0cmFpbGVyDQo8PC9TaXplIDE1My9Sb290IDEgMCBSL0luZm8gMjEgMCBSL0lEWzwwN0UwRUNF
MDQwNTFBQzQxODQ4NzM2MkNEN0ZBOUY2Rj48MDdFMEVDRTA0MDUxQUM0MTg0ODczNjJDRDdGQTlG
NkY+XSA+Pg0Kc3RhcnR4cmVmDQozNDY2Mw0KJSVFT0YNCnhyZWYNCjAgMA0KdHJhaWxlcg0KPDwv
U2l6ZSAxNTMvUm9vdCAxIDAgUi9JbmZvIDIxIDAgUi9JRFs8MDdFMEVDRTA0MDUxQUM0MTg0ODcz
NjJDRDdGQTlGNkY+PDA3RTBFQ0UwNDA1MUFDNDE4NDg3MzYyQ0Q3RkE5RjZGPl0gL1ByZXYgMzQ2
NjMvWFJlZlN0bSAzNDA0NT4+DQpzdGFydHhyZWYNCjM3ODgyDQolJUVPRg==

--_004_BL3PR11MB6385517EECD04C783E9DC42488F62BL3PR11MB6385namp_--

