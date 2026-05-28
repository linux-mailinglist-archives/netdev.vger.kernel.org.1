Return-Path: <netdev+bounces-292604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MD8FR4EGGqdZggAu9opvQ
	(envelope-from <netdev+bounces-292604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DCD5EF1D7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BDB130AC4FB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAFD38D41E;
	Thu, 28 May 2026 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jo7gwRGk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4392390C8B;
	Thu, 28 May 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958465; cv=fail; b=N/YziiU4gC+2niuHJjhGGA4PVsN7N2MQmBpEH2lI1yd2fKzfDMEa1LGJdABBaIep2b8+DirKOUkjRNr5p+SVQrza6aXBnESsICxOVp5Z47QH7oTcaYAPcEaHLgD2WsOFUjnpGTC6cAg0e5wMRBMJSoVmnBwycf6FG5mWjfUzGf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958465; c=relaxed/simple;
	bh=5ncmpviDvHA6wxvwnMbKWZOoRM6bspMBZ2V+427ltAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XYvDPSUy6sdrM/OrsmdxyUjq2bHjk8Wa84vMmXHvLtXXmSkFyisC0uQ4MPEovz+u+ewrP265+H85kf2AdYMG4JpUT1GNwMn6UWwW5lc6KxI+IIfNqXhYsUi4qd1QcYgrcGVamqdUNW4GQH48txPBT4e2pbAcHxs0p2BMSSSsPJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jo7gwRGk; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958461; x=1811494461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ncmpviDvHA6wxvwnMbKWZOoRM6bspMBZ2V+427ltAI=;
  b=jo7gwRGkVV84595jOB32TZBKcRoF+SWYtkUe4HG72mE9VzxA7bmPeL0t
   uaLIC43YuI8VxTZQoXnTRBp7aS0lHPStgDItqkGPnc42GzpGnOLMNs+WO
   GKuaiZpBC+J7sni4eG6QBgpRQTZ8j0Ewy/W0rx0pugCLyjmcBBqLbZRxA
   5vJJbqZ9F5cIsfhdSb2CFShZhLFXHTSoiKFRBLtnpOZRD8HrEbYlud+r3
   UPZnX9fyQIT6DntjdF92SJ82J/zgC9eC22/cx4rH3uKAx/FC1P7x5t4YK
   o+wksON0SuEoacp7jDvzd3CriekIEyVBdt8IGuVshQlFtDuvKawuimPyR
   Q==;
X-CSE-ConnectionGUID: 4LiDfAZvSGGn7ARBgUOzjQ==
X-CSE-MsgGUID: FLe+shb/T2C8FVYfnQ6DkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80825203"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80825203"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:54:18 -0700
X-CSE-ConnectionGUID: fU9gN6daR+aIRA6MeNHn/g==
X-CSE-MsgGUID: tbgghmRdRoGMymk4kI93Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="242651171"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:54:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:54:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 01:54:17 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNGisM4u9OpF0iSb8+1s3WgfX+RmeATINHCEc5VmTRauiPfIO3kuUOP+FQUwo3N0WfBLR0nlcbRwzypfCZ7vB8vnKPcQR7PfKJSJtUzKN6TA/sup5ODyJbSV0lO3ctLijYGQMHqplSMrkizCkwXcjzUHDLUpPe0SQzzY0ZStC8I6XhGRV0JKD/GyOsYfmxBWEaLGezH0n4FQcPU64L5robLzbvzbt67Xs0xzmMMPx6DEH79yGCpILNCq91x7wPpHCKx2UMtd5T7gfbz+CPSt841yTypUkOQE7qU4ua4EwslVVjlXhIi7doFNXSOxlCGbK7eUOUedw2IiG+WMsSY/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyTNR/PEF/TObhREOasNhXTBf47fjoHu33KPJx77X54=;
 b=NQkybTeSIXx9ch/TOHP5RUlU88G3gLGQZPUKMMvoMzbSgxQ1VyM3G/U8rJIE6nSDRYgcNYz3Egf8TaneWNr+MNt19L7aOnlMjEkH97ShlQxR6edz/EMkdmN7g8RHybodxcn9rUgFOKM3yma0TPoZ7oJLgFl2DYnvwoOniIAaRQ1xtXT4fAWyfJDxSG6lVLCC7ydHsuxXRHwam8UlIfHkn2LVqH00O+NAzBVr70a+/o/DVXvLrXGozC5TuEJNtGAyYtSTlC2euV4XHj+51UFU+COdzfWQfnCqVGZED4lqPHkj3A8ybeuzDaHXkp67vhAee+CA96nFTOEgrV9IAA1+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:54:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:54:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>, "kuba@kernel.org"
	<kuba@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ixgbe: implement
 get_queue_stats_rx
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ixgbe: implement
 get_queue_stats_rx
Thread-Index: AQHc7SQ4tz3+tZeYaU6mcbymjqCOk7YjJJkQ
Date: Thu, 28 May 2026 08:54:05 +0000
Message-ID: <IA3PR11MB8986F808D1B13DBF4B710B01E5092@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260526074744.36315-1-kshitiz.bartariya@zohomail.in>
In-Reply-To: <20260526074744.36315-1-kshitiz.bartariya@zohomail.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: d6615531-79fb-4919-674c-08debc96ac1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700021|56012099006|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: 9SDOz8Q7LrlZG2wS/JPzLekfEeZSL7ft3VTZaHW2+uQT1FiYDJdCG0f3gqiQx7KNM9F8OZQtnwIKOxGO8r24xEcHjlTtGlDcelFhKDPPJVQ6sZPgL0RgSNj4Q9P8Q4MPszzIHxDifHCg88xYID0s+vYSozJIGfA5ojqjg2fv1NPBDatIdd9FDe1DE8PkeYoJvUc7RrAEcmk0JCTSOvuuLIgS4sWEu8vtAhQRtqe1TNm6d3rUgL0NSPOI35vv3N21emFrtJjX9TUGNfywcIaqzOCwWNSsJK0M2soqd5HnxXoPjGFdh3FituzoDPjLWcoO5RbOQaghQGZyvKXfV3SnoSxG/bcgTocACK4uqXe8E3W0LdvXcLd8J7kJiFFy/XygrTD2xoc1vixJ76I02q0VHQqKeAykMHXY+48L/k5ZRxJpHEqCOX+yk6TSomCMoFEVJ0bCeGEuneQeaw1LRs/36TMm/DglDV0zhFPkPNe0/9wXoJ+IPCOZcXJ6iosxk9m4dXBvwe77eeNPeUHD6QBRBnAp8dbQtZnaE19wGiqLoCGOXgIb7jEx/01026K8oVbXLTzcQ8vkKDMqVxMFSvKg2rGI1eOOgKX0RRlD6HGob9fq+yKOStBEpmpoRl3Uw8OtqjXZ8IkxsLJwkPHMbekshYDdz9czHUexEoU8dlKU7XTZ8Xg7jFjSN6pGaCgUNoBetN24WUMNHul3qMUxjImxKS0AvcmLqFLJbuh9crqfz2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2+WvywZODtyTHh6Y+Y7lLvmcP5+9iCCp+oI/NDOMZZwm6HsiysQKLq+BOOcS?=
 =?us-ascii?Q?PPiSeQV/BsKHmY7mtWqRaV/7TuB9VPEZL+9Rhn/Rr2BX8A7BM5o29d4Mej5z?=
 =?us-ascii?Q?tKcinjSDtv/Zcn+2J9emZSG+gnpQ+3saKsk6z8EdnRk4EPuOdT2BfAUmmW03?=
 =?us-ascii?Q?jU+PrGai/EThMegFCFV9ZKlMw3IrwFs+GzMRAc6RR38MwHMW/Wijdzc2ie6u?=
 =?us-ascii?Q?vUKmMwUmXWADSkFcIcNAu/m0IVLuPNf4KOo6gl69tN6mLai2aswRxnJHw+/q?=
 =?us-ascii?Q?CCZr4Q6D8at+/imlRNCCB8ramCIc4GIZ05mEuG+MXCOL+PL/NxbBrw9EfjTk?=
 =?us-ascii?Q?lYV00LA+iWvtM32GGdcp6fsOt7asrLFuOSLJ+juIf1J0QeXKxWYCWlsHtxZo?=
 =?us-ascii?Q?d2JNz3W16MAL3pO6tBgwfN6VYrRU7dNpJVS1Mt6uMmxJzzRvMHgozPhMN5A5?=
 =?us-ascii?Q?Ozc/+oDAF9xO2paYmAEczFUdmtomv7pWsLdtmR6n+Y6Z0Oe5pZj2aqOuKoPr?=
 =?us-ascii?Q?WAsPpENv7NkkiZ5JSrl7Y0EBsuHzOYT9F7fISKRTEGSOIzANI9UdrraFPJ/U?=
 =?us-ascii?Q?o4Di7jBxQmhL4oYyOCzhHtPwTQJZYEee7IkKkJTPsNbEeafrYQQxlNkoZz63?=
 =?us-ascii?Q?8GkS5kxfp7+0cOWiHlG8BlofeVFEIwdknzwLuKCD233n7p8RA8vRnJQRyL8S?=
 =?us-ascii?Q?gddh/a4QbWkjeuNr2Jbcn9H7I/Yv+P7N+ELUmrNV4w1Zkph4zNP4gzxiQadO?=
 =?us-ascii?Q?3hZWPGfaWGyDPZhJjbqMnJOtSX5nCSqDrxoZ0FHFQig5+6S3K20nWzB3862M?=
 =?us-ascii?Q?ag80BZ1ApITdk9FPaEA96QOCTlc8CbqOjYRZhqcQ0k5tK88sgHslbiYc4CZe?=
 =?us-ascii?Q?1NbdBYoSe2VLv7VXq1uLy86R8pqeWv5i8Obue990a4cYVdDSArTTE3l7fbzC?=
 =?us-ascii?Q?RFgao6YDXXoUQ4wzUP8YhHLRRua+XKZO/tE2+8IEi33T5O/w4mQIn0pFewWB?=
 =?us-ascii?Q?yZMlNagSoo9kFjCWk+Oe/ijzMbF3oC7usT/0VNs1mnj5iumDINZPXvbSv68L?=
 =?us-ascii?Q?r1jU81V09q2+IYEoAUtgoGljqarulPc3W8jwx3hhyyBe66LVGNKCmFZ9K+tq?=
 =?us-ascii?Q?GcPv4Dj5befh9GnGKNcU5IRppad+pM9crIXNcDwSOaG/VM0ChUsfKPpn/eGD?=
 =?us-ascii?Q?qRxJyzbFVtN+cDb6449B4P2AvpngBVPWtKXQWTA3hxiuE34/G+5uk6SdDZuT?=
 =?us-ascii?Q?nYAE3DL9HCryhVdpk9D+v3Tm7aS1Q5tGMxQU9sLkuZfTrb9GIbQPh+dIfQMo?=
 =?us-ascii?Q?O87e5ULZ5eDnV9ZIylVaqcq7OKqFC1tH7pxw2maF7YlhMSmTqY3KaGP3cx92?=
 =?us-ascii?Q?iE5Hve19ebj5djFfaQjbr6NdZ0zIzSsq4lVhpOhmGMMhK+vOvhs7RkZn4m8f?=
 =?us-ascii?Q?4aldK/UqNIZpdJ+GSZINVP/41fLj+bCtzGdp4TOub8gwv4ZRLuhd/4/TXTqX?=
 =?us-ascii?Q?bKGllkqtR+oePMs6YwhsQdT2sjmber/Ht5U7HFLzw/U489DgDhBF4HcA5M1K?=
 =?us-ascii?Q?8dPyeb8NfIxF1foydOAxQvkST6r4sNIWlZqKvL9TZN3NM74WSawBgDsUYz5K?=
 =?us-ascii?Q?o0JaROBOA5f/NFb4jSzyqj+KdfpWbfzwzXd+DF9Woz0VYx/8qGcS0cdJDvfl?=
 =?us-ascii?Q?EDwqHl6sVxztq2L3/wNZGEppEFxf18dTUCrqODNN6Ja7UOTOJNCtZHksljDC?=
 =?us-ascii?Q?4SkOrRnSj2bllf7KhSBg31w5fe3q+Ws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BhQwm9QGZF4i9NCB568wf7pQbZdD6kvGZORoxUhM0lrmIAozxqPu0g+C3yQMnJqHVvb7X1aHhpTwAjuA8hYxiF82/OPA/83QWGmuXFhXY0xne3XWt7UN7Jp4WkTvm7x0rb0cGden76idQNDoUHz44IqXr8pNfcFOsq5p9CNqLYIWaPXShhsIgIFWiIQ5SiYH9L2VGGCjrYyWksi4omkxeOYhKw5Rnu2SOxXmPgOKjaUK0eBGU/rSN/HeAg9wSZXO7pwrTgXATCJZ0AunKX9adslUoI0mxXLWAomLFppqxm9NQ4lxOGqkN/o8NMUywCx/5kJqz/15YBNvg2eaCNTsRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6615531-79fb-4919-674c-08debc96ac1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:54:05.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaVOnnXI24fq8ByVfOqPKiOenrZDHI7dqC1lF/vKcu1CeY4scz2vvTJqE4Et81qMYxJm1tp8HiecKsnDQBiIlyjq05cu4nhJ+Iy+sVbU26U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292604-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,zohomail.in:email,intel.com:email,intel.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E9DCD5EF1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kshitiz Bartariya via Intel-wired-lan
> Sent: Tuesday, May 26, 2026 9:48 AM
> To: kuba@kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com
> Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: implement
> get_queue_stats_rx
>=20
> Hook into the netdev_stat_ops interface to expose per RX queue
> statistics through the netdev generic netlink API.
>=20
> The following counters are filled:
>=20
>  - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
>=20
>  - csum_bad: maps directly to csum_err, which is incremented for both
>    IP header and L4 checksum errors in ixgbe_rx_checksum().
>=20
> Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
> ---
> v2:
>  - Removed setting of hw_gro counters as ixgbe doesn't advertise it
>  - Removed idx and ring checks as they are already checked against
>    real_num_rx_queues
> Thanks Jakub Kicinski for the review comments.
>=20
> v1: https://lore.kernel.org/lkml/20260523144022.36484-1-
> kshitiz.bartariya@zohomail.in/
>=20
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2646ee6f295f..2184213727c7 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9740,6 +9740,21 @@ static void ixgbe_get_stats64(struct net_device
> *netdev,
>  	stats->rx_missed_errors	=3D netdev->stats.rx_missed_errors;
>  }
>=20
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats) {
> +	struct ixgbe_adapter *adapter =3D ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring =3D adapter->rx_ring[idx];
> +
> +	stats->alloc_fail =3D ring->rx_stats.alloc_rx_page_failed +
> +			    ring->rx_stats.alloc_rx_buff_failed;
> +	stats->csum_bad =3D ring->rx_stats.csum_err; }
> +
> +static const struct netdev_stat_ops ixgbe_stat_ops =3D {
> +	.get_queue_stats_rx	=3D ixgbe_get_queue_stats_rx,
> +};
> +
>  static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
>  				  struct ifla_vf_stats *vf_stats)
>  {
> @@ -11643,6 +11658,7 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	hw->phy.mdio.mdio_write =3D ixgbe_mdio_write;
>=20
>  	netdev->netdev_ops =3D &ixgbe_netdev_ops;
> +	netdev->stat_ops   =3D &ixgbe_stat_ops;
>  	ixgbe_set_ethtool_ops(netdev);
>  	netdev->watchdog_timeo =3D 5 * HZ;
>  	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
> --
> 2.50.1 (Apple Git-155)


I think it should go to net-next branch
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

