Return-Path: <netdev+bounces-176256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30573A69840
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60751189D340
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741821148F;
	Wed, 19 Mar 2025 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HexpHpdK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E021019E
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409784; cv=fail; b=VLF2/ka4lpl+l5T7B1GcpTQzMMJ80KRkHOi+al0HN5BN4c3zURnjlU3/ER7kaF0Ah+0swK57ppHsRXPzZ6oDwyNxJCP9CQtt6ahzQW6bc5xmOLmlb9/IBHvCHaF4KS4Ozr4EI8a81VLicm9N0zRKk0DpAIjwFxPD+/Fq3AxRiDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409784; c=relaxed/simple;
	bh=dSSi5NVoH8XLUqYZXqc7dXzt7VZWOjPM5G/CanZvGYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nyp7GXYPCVe2b+YTDqfTfJuwqO0uE0fIdxExP6mbTXSSFlU8KOmtsve5prsB48iQVJK4o2umh8E0EMPGX65PMPfJ44jcZRB5Y6e6/NrlVcM/qfscP5EQoliPVibksKwlfsOFo39V2dVhOGEEy+f8cgKEt/V09Aq+/2S4ZYOrfQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HexpHpdK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742409782; x=1773945782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSSi5NVoH8XLUqYZXqc7dXzt7VZWOjPM5G/CanZvGYc=;
  b=HexpHpdKyQc4JfxF7KnrZr1hV62PN2fDY8vtnCq6hTcDB2PbuKuowLKn
   fxGmbKb8yCartszXnW1qQeT4fXH2wFY3WhpgJ3SV3paQKPA88y1yyikYc
   uEjjGg+jqKz+8NMMcpnViZACKhPpvva7nucvTTBsmCMPyHxqJnMFQit5/
   VAGX4etlQHRsewm2eLdlUzEx9x6XuJSKbhER+Rid8TJ71AOpDxpxeyRQa
   kl4XHcb86StUyr25c+Z4i82Gmybk1zSSXUSiVqB9zZDG0/OqqE4cnqEQq
   XWeV6eRd1PNL07XFudF49tK7pr+a8ByeAXF/gpg28HIB/iW2u5y1Sg0Mq
   g==;
X-CSE-ConnectionGUID: diM3x5lvTOay6dea+nv3mg==
X-CSE-MsgGUID: GMGXsBFvRIiUXe1B8JaYiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43789490"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43789490"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:43:01 -0700
X-CSE-ConnectionGUID: lMZ3NYntTRuRMGMbCgquMQ==
X-CSE-MsgGUID: IgJyaC6oTzSjHrgawwFauw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122567242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:43:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 11:43:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 11:43:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 11:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQmmq+QyOvHiuhAaZN2HlqAMRXzHYbbeAvKS3bAQ7O9545mETuxCvxGQJ21R3kQuMaFT0wCQTIZzPlzKq9E4EOMkyX7buOgRHZECQnTa3b0n4VFbW9vEO+v81pMttpR8zHvzxmS6dwgWLoUS6auO9JE8dLEC5VPw/mTtHg25/ULURAXMFdxf0/1lao7Pz1krGNTdu0vcMzcLnNTpjrMF5NaP6KgIiGuZjH3nNxE1AGFM/J+64lKJO2ANUcUgu+fQy70d7r61L6X0HP8p3E76CRgHJjfG3epfOInGECrbkUuCFyHoqQMqx3v+end7B7kVFLTgZ9HGDGpQWCRsbuGRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzoQh2TsZbNQXkP3UjJMbaUe9dOcOdgEiaFhpRnZ8cU=;
 b=UPCNryif8LydQHyHnsSfJSCNoGsElyFR3grH15AlToG2csoFoEXTFrw4KpjXsAyKTEnUMskPrt7AXdqZ295TfX8Jqq6qfsXdZbIefhnPh9GcDe2Gg+TByRQ1E9OHkhaYeGguFPBxMEx4JbMGDz/faK4aqJfCFSWsKz/5SoYij8S2zAb2Q9VKq3J9rY2OE524mp8w9tVf8RJ8m2EVunl+ep0PSfHcGx5mBzir6Om+2wXTSnyEg1HJ1yTo6C0MtIX+wvHN2kbagGSnUP/w/sEwNkLK7t2Zc7YAi9p3b/E6TiE1vxJLm3/Gk+QoluKLvE4U/iKCYX2YSFGMJXjhfdtpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7380.namprd11.prod.outlook.com (2603:10b6:208:430::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 18:42:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 18:42:28 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "dakr@kernel.org" <dakr@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>
Subject: RE: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
Thread-Topic: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink
 instance for PFs on same chip
Thread-Index: AQHbmAPpzfoItpIqX0GHVOB42/z0m7N5cs1AgACtGgCAADvZAIAAcWtw
Date: Wed, 19 Mar 2025 18:42:28 +0000
Message-ID: <CO1PR11MB5089D1F871606F9BEF805B84D6D92@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-3-jiri@resnulli.us>
 <CO1PR11MB5089BDFAF1B498FE9FDDA3FCD6DE2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <3be26dca-3230-4fd6-8421-652f95c72163@intel.com>
 <emj5f7xfdcnkemdairmpyiqmq5aoj2uqr7bxhfiezqm4zeuchu@wuplknrtviud>
In-Reply-To: <emj5f7xfdcnkemdairmpyiqmq5aoj2uqr7bxhfiezqm4zeuchu@wuplknrtviud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|IA0PR11MB7380:EE_
x-ms-office365-filtering-correlation-id: 265b2fca-4256-4483-146f-08dd6715cce7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QweT1rdcEDGPfAQ0RG7cffjAFmZcjAiZjOqhe3ieQ9UO6OJIiVxtmB9jic2H?=
 =?us-ascii?Q?G3Eliptqt0V5rdh0J72VOY+Iwi1yyHWAuQY7HPBhRd8zhDpFlIGaBuBCRzg2?=
 =?us-ascii?Q?c+ZzzELFNwuzs9YuNL+Wg9XEVaIyuzgX1xdcXPlGNWCjl7znW9uni2k6D0Yj?=
 =?us-ascii?Q?4EP/7150BgtahQqhqEn0+4AZ+K+HlLJrplFpdD1bpyJZrBqAxYLZVKfi6jWN?=
 =?us-ascii?Q?O2bk6rzx+EYI9AGctBXEHecTGFugB1PymgWvB+Xkuv0OgycagUPep/ubdufK?=
 =?us-ascii?Q?c4GklXxSSdVn72wMegi2v/5gx/2kV77VOL92RrCiQanyEZgFDGHNt90Hlj3f?=
 =?us-ascii?Q?jc953IqNtqeajGuu+ci+2Vd1xH6PnQ5lnM3hF30+GAE28u8phZB750ujoxFd?=
 =?us-ascii?Q?39uGgpHp9LZqMqCtzHQracGJySSoevCfsbRJh1/WbPMw13fQgj7iJGEY8WA2?=
 =?us-ascii?Q?sUEAgATHHlqW+ijxVVPCsjwYi0bJ244/GOSElnzP9cyoWbffDgR78ps1oZTl?=
 =?us-ascii?Q?f9XAYvtTXoJXbp+UyHz4DP1KUjVu6nf0he7OcSRoN+0H79xZFz+3NOWBgGQB?=
 =?us-ascii?Q?SVhhttaKW2KEfqZJ9rPs1uFE9FPHI/+kql7DcTWZ2c0UY0ZzCDRNS9pq+eTW?=
 =?us-ascii?Q?77YsPjFoQiz0HKiOXH54m4nU9yk4FRgeEjZMRM/3Grgw9Yr8c9iBlm5otMDO?=
 =?us-ascii?Q?eUt/XTdR9c1xE33H50IpTBUegaSh+RBfEkniwuolDbDqo3Hs2iGMStZ0sjG/?=
 =?us-ascii?Q?J04hIWxKDaRbn1vjZfVlTPW5PTyt0vBuH0hr621SJumjrQN6JQ+4+V73Nzd3?=
 =?us-ascii?Q?q9bPPjokf6YijWh3W9vQRWnYiVtmJm+l/XsdbNRAkm7jNvMy2uJw7nStugA6?=
 =?us-ascii?Q?ZgMI02zdg2TnR5RewQaWjjHMIHvP4WNwEORIr+ivzum9ZiWGY4N/ppnimNFZ?=
 =?us-ascii?Q?3axkFp2qq72n2ufJak+PNV20m/Egon5/0YMg0zSZTwtwCKZXOakM+NISPE4x?=
 =?us-ascii?Q?/LgezcWukw0pns+XNgiNrFYiCPTO4JCAhh2HXkj6AbJflTR8VJOJw9DVQeCH?=
 =?us-ascii?Q?98iAgN8xuls9qx2emQa4qE2OftsfeagXzPWhx9Id/qh2WkPi6fOy3lR2az8g?=
 =?us-ascii?Q?b0x8qsV6U8QnILxWf2YtC+nbWLvMjygEWtRTkYSf224c8WEgv+ZPW2Yej2zo?=
 =?us-ascii?Q?OUa51NWsdvdEp6ZkJmm1p5ExizzspcONYVf2Lj8zuorB/BJo87KmBCzXP1CF?=
 =?us-ascii?Q?Am+qt+L+hCFrzN+uIhocpFgsr1nZHklrJyPkUhb2WijZM9Go74n+dFixZ0KF?=
 =?us-ascii?Q?wD65S6Y8dAvakWLNrMprSy7enRlbdTsofHXURd7VfEcDTRBZgEiyINUiYEI7?=
 =?us-ascii?Q?xgOl1JXbRoEVR/xnB/3cl84TYUGBXEmVxlSKuN6a78YRNGxfNGc4XUeoyc5v?=
 =?us-ascii?Q?q+Z6IyhBLpLRxf1M0XB8ltCvGo/8gqDG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlq/YoYhHMP2njq7V8kBKtns8HtqRGlHYD/eI75MEHnobqbUae5ojrVp3MU7?=
 =?us-ascii?Q?9o8hjuuLbnpgmua0vlhoNvX8mgY5JVVJLOLD3hQ0gRPgOPSMq/irsJi1U5fV?=
 =?us-ascii?Q?drPCOMPpE3JMT2WlCGCigvg3AJKtk376eUN5dRh7ie7x7nkxbrAla8Q9dv/y?=
 =?us-ascii?Q?3sYIFx/czlgIFhDNxgmk8zwbsBPlQDi9xb9QC/s2owyZr0fxuJyvHEqHfLHh?=
 =?us-ascii?Q?dt3UgEXGreqSoZkRMu9ynJCaoeL1AqRcFVQ74YeIByFkmgNmgWIixotkdhDi?=
 =?us-ascii?Q?bXh3dMf3uZ+W4qYVyso9UJBEE4bk3WulECD/QwQrm8o2Yr/hhj5ol9V8FHle?=
 =?us-ascii?Q?VfMiPIqphC9AGcSmpn+XedNCv7Cnc7Mjl9k/B6W2g5FO46emueurb6Cz70+x?=
 =?us-ascii?Q?gbfqfJteoHpUNzELFqL9p5zw1e33kESj0fbvvr3CgJHKW9ssMmKnUPESdU2J?=
 =?us-ascii?Q?vQrpyiRwjymSvHhWsh9SHRDBpalIelssavuaAsfOycRWLezuiI4iPI3qTAF2?=
 =?us-ascii?Q?0+gVNXsL4vWMA+c7MwWWI/P5xV5+SM7pJpgcjzRvkCE3ehKBWXImutODVVcS?=
 =?us-ascii?Q?6vB+mzhmvcG2LqpkzbZ+/B59f7VKsYN4BDd46OTYNOzWqOEp2dAmc1wYGWrV?=
 =?us-ascii?Q?X1azAgpOsqh5tfyPN/WOZtyw4A2fEXywleyhQ8iCdEPm+DiATGTttJvI7zrh?=
 =?us-ascii?Q?M5skJUF7wMRhNtdSsIA5Xqx6yJz4ZiNWUy+iutS25LPCSteK8TdYXJVlkGjw?=
 =?us-ascii?Q?psnj6GmUxRxZaPv5l9uySq7IZtzhaiIoTByGvN8yUZPeI0WFmSE1V5k5VjIe?=
 =?us-ascii?Q?phDMoX/7axtfwL2xePvjzgsBG2/WXND6TQuwHmYKfbP+gB0pAalXyhtPz2Vl?=
 =?us-ascii?Q?yzryaYa2FK1/yq93TmZoNRovAGh4zio3h5rzJdmvztAhgTAXHtidk8gJtIkh?=
 =?us-ascii?Q?JQRw8/2vc7mjIhcV/R/6DvVb8fftGW703yUByVhcOPMCBlx9zs8dwQGHLrxf?=
 =?us-ascii?Q?80KTRQ3tqsFsmcrRtMAUEXYEMDU9j6tJ/zG3GnLoQ/wdHVXwVWVYJI5M5bZY?=
 =?us-ascii?Q?b9PuMbyHsMGttoSOKjJm4JJ2uYv7guGLGC5yqnaDXfRS+UM9cw0f2jWwXJNr?=
 =?us-ascii?Q?xwZguUepX8JwDNet+WpsuH6TaX0CULcO3O9gLfPRdEy2KGEq2DPCPRDRV3vQ?=
 =?us-ascii?Q?3eANs9iGK2j+58F0gZE9HLWGv2FFQB1Meyvj/mRi16A0zz2XXgn8HCeBXtBT?=
 =?us-ascii?Q?ZAyT1WNpWoskpKp+Cf+o4ESzFOkTVJ9hTBqKUh1p7Aq2e5WMIASUWVvJ2Eqd?=
 =?us-ascii?Q?Dj6fQQKkRmFxmI6NU7Yr30gfImj8oyLmWi3vrd+g/3xTxfusHFIBnnHgC94s?=
 =?us-ascii?Q?xbwbJUTqX49QWfJbMwib0BXNgECVWs4xLdLJ5+BCaduGpUoAc4vdg/zaY493?=
 =?us-ascii?Q?Bx7JcGjfpPtGAAl+CHolOvcU6in4MA3hbi33uZOvIT4SjX3jW5p8AIqAHzzp?=
 =?us-ascii?Q?0FYX31frwXJkUVwuXgQe7rGBWxK++5jRBpW1X+fqgf61Y5zXLOn8iTxyRYND?=
 =?us-ascii?Q?9mqJDPB3I5t1IVTf17sjihwgLOc7Qcbo9JuqO9WW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265b2fca-4256-4483-146f-08dd6715cce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 18:42:28.5849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9LmjsTPUWEJfl45/OFqATeUf1LdH2OagR4jK6onY58CMF3x+H9FKl+H/SeXHoj7pKUaLQ0TKYndkeUYplHFBEnuQEknuMD/6ZRaydiO62Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7380
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, March 19, 2025 4:56 AM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; gregkh@linuxfoundation.or=
g;
> davem@davemloft.net; netdev@vger.kernel.org; Dumazet, Eric
> <edumazet@google.com>; kuba@kernel.org; pabeni@redhat.com;
> saeedm@nvidia.com; leon@kernel.org; tariqt@nvidia.com;
> andrew+netdev@lunn.ch; dakr@kernel.org; rafael@kernel.org; Nguyen, Anthon=
y L
> <anthony.l.nguyen@intel.com>; cratiu@nvidia.com; Knitter, Konrad
> <konrad.knitter@intel.com>; cjubran@nvidia.com
> Subject: Re: [PATCH net-next RFC 2/3] net/mlx5: Introduce shared devlink =
instance
> for PFs on same chip
>=20
> Wed, Mar 19, 2025 at 09:21:52AM +0100, przemyslaw.kitszel@intel.com wrote=
:
> >On 3/18/25 23:05, Keller, Jacob E wrote:
> >>
> >>
> >> > -----Original Message-----
> >> > From: Jiri Pirko <jiri@resnulli.us>
> >
> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> >> > @@ -0,0 +1,150 @@
> >> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> >> > +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved. */
> >> > +
> >> > +#include <linux/device/faux.h>
> >> > +#include <linux/mlx5/driver.h>
> >> > +#include <linux/mlx5/vport.h>
> >> > +
> >> > +#include "sh_devlink.h"
> >> > +
> >> > +static LIST_HEAD(shd_list);
> >> > +static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list =
*/
> >
> >I essentially agree that faux_device could be used as-is, without any
> >devlink changes, works for me.
> >That does not remove the need to invent the name at some point ;)
>=20
> What name? Name of faux device? Sure. In case of ice it's probably PCI DS=
N
>=20
> >
> >we have resolved this in similar manner, that's fine, given my
> >understanding that you cannot let faux to dispatch for you, like:
> >faux_get_instance(serial_number_equivalent)
>=20
> Not sure what you are asking TBH.
>=20
>=20
> >
> >> > +
> >> > +/* This structure represents a shared devlink instance,
> >> > + * there is one created for PF group of the same chip.
> >> > + */
> >> > +struct mlx5_shd {
> >> > +	/* Node in shd list */
> >> > +	struct list_head list;
> >> > +	/* Serial number of the chip */
> >> > +	const char *sn;
> >> > +	/* List of per-PF dev instances. */
> >> > +	struct list_head dev_list;
> >> > +	/* Related faux device */
> >> > +	struct faux_device *faux_dev;
> >> > +};
> >> > +
> >>
> >> For ice, the equivalent of this would essentially replace ice_adapter =
I imagine.
> >
> >or "ice_adapter will be the ice equivalent"
>=20
> Oh yes, that makes sense.
>=20
>=20
> >
> >>
> >> > +static const struct devlink_ops mlx5_shd_ops =3D {
> >
> >please double check if there is no crash for:
> >$ devlink dev info the/faux/thing
>=20
> Will do, but why do you think so?
>=20
>=20
> >
> >> > +};
> >> > +
> >> > +static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
> >> > +{
> >> > +	struct devlink *devlink;
> >> > +	struct mlx5_shd *shd;
> >> > +
> >> > +	devlink =3D devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
> >
> >sizeof(*shd)
>=20
> Sure.
>=20
>=20
> >
> >I like that you reuse devlink_alloc(), with allocation of priv data,
> >that suits also our needs
> >
> >> > &faux_dev->dev);
> >> > +	if (!devlink)
> >> > +		return -ENOMEM;
> >> > +	shd =3D devlink_priv(devlink);
> >> > +	faux_device_set_drvdata(faux_dev, shd);
> >> > +
> >> > +	devl_lock(devlink);
> >> > +	devl_register(devlink);
> >> > +	devl_unlock(devlink);
> >> > +	return 0;
> >> > +}
> >
> >[...]
> >
> >> > +int mlx5_shd_init(struct mlx5_core_dev *dev)
> >> > +{
> >> > +	u8 *vpd_data __free(kfree) =3D NULL;
> >
> >so bad that netdev mainainers discourage __free() :(
> >perhaps I should propose higher abstraction wrapper for it
> >on April 1st
> >
> >> > +	struct pci_dev *pdev =3D dev->pdev;
> >> > +	unsigned int vpd_size, kw_len;
> >> > +	struct mlx5_shd *shd;
> >> > +	const char *sn;
> >
> >I would extract name retrieval, perhaps mlx5_shd_get_name()?
>=20
> I had that, did not really make the code nicer :)
>=20
>=20
> >
> >> > +	char *end;
> >> > +	int start;
> >> > +	int err;
> >> > +
> >> > +	if (!mlx5_core_is_pf(dev))
> >> > +		return 0;
> >> > +
> >> > +	vpd_data =3D pci_vpd_alloc(pdev, &vpd_size);
> >> > +	if (IS_ERR(vpd_data)) {
> >> > +		err =3D PTR_ERR(vpd_data);
> >> > +		return err =3D=3D -ENODEV ? 0 : err;
> >
> >what? that means the shared devlink instance is something you will
> >work properly without?
>=20
> Not sure. This is something that should not happen for any existing
> device.
>=20
>=20
> >
> >> > +	}
> >> > +	start =3D pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
> >> > &kw_len);
> >> > +	if (start < 0) {
> >> > +		/* Fall-back to SN for older devices. */
> >> > +		start =3D pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> >> > +
> >> > PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> >> > +		if (start < 0)
> >> > +			return -ENOENT;
> >> > +	}
> >> > +	sn =3D kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> >> > +	if (!sn)
> >> > +		return -ENOMEM;
> >> > +	end =3D strchrnul(sn, ' ');
> >> > +	*end =3D '\0';
> >> > +
> >> > +	guard(mutex)(&shd_mutex);
> >
> >guard()() is a no-no too, per "discouraged by netdev maintainers",
> >and here I'm on board with discouraging ;)
>=20
> That's a fight with windmills. It will happen sooner than later anyway.
> It is just too conventient. I don't understand why netdev has to have
> special treat comparing to the rest of the kernel all the time...
>=20
>=20
> >
> >> > +	list_for_each_entry(shd, &shd_list, list) {
> >> > +		if (!strcmp(shd->sn, sn)) {
> >> > +			kfree(sn);
> >> > +			goto found;
> >> > +		}
> >> > +	}
> >> > +	shd =3D mlx5_shd_create(sn);
> >> > +	if (!shd) {
> >> > +		kfree(sn);
> >> > +		return -ENOMEM;
> >> > +	}
> >>
> >> How is the faux device kept in memory? I guess its reference counted
> >> somewhere?
> >
> >get_device()/put_device() with faxu_dev->dev as argument
> >
> >But I don't see that reference being incremented in the list_for_each.
> >
> >Jiri keeps "the counter" as the implicit observation of shd list size :)
> >which is protected by mutex
>=20
> Yep. Why isn't that enough? I need the list anyway. Plus, I'm using the
> list to reference count shd, not the fauxdev. Fauxdev is explicitly
> create/destroyed by calling appropriate function. I belive that is the
> correct way (maybe the only way?) to instantiate/deinstantiate faux.

Re-using the list as the count for how many users seems reasonable. I just =
didn't catch that's  how you did it.

Thanks,
Jake

