Return-Path: <netdev+bounces-133713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C38996C56
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1726281893
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A55197543;
	Wed,  9 Oct 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kza5lAT7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4319644B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481130; cv=fail; b=lSQjT6oee8O97eKXksH3LtFAGwrNGnVtSsXRPo688UPPdOjbMBZPCV9WF92mJZ8oineQhpySyoe+HQPb8g5fVWs2m9yaN3YC7su6vl8pcTECECvEg0aILRl+YZD9P1g34AzwpucNuAQJ8F5SczHxjidBrnl9MB/fCE9p6Ka3GSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481130; c=relaxed/simple;
	bh=UjbDSAxgovc0EdkQITgkUkO1UXTx70LeuN9DeqBk7So=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOCuw9X/GI4UOmfiI2kVsFLiHqibbVqTDia3sVMV+vcG71f8+siUB9H0oxyXXdEEQ2MpwawKN2v1yGT1KiTOml3kQq7eAw/mEjJOvbBWuaP/yA66vi8dwn7m/RD1bsSyr/XKIO74n45HK8UkLJ+GPLwmr6+ZdH9D9IMMSeEQSJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kza5lAT7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728481128; x=1760017128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UjbDSAxgovc0EdkQITgkUkO1UXTx70LeuN9DeqBk7So=;
  b=kza5lAT7U5YMOQvtl2I6wJr6xcvRRytZXNhGQQDxSrtF+6H8T9Z2Fxnm
   bruW7Z7V2Fd2Yvrq60xL9gnPTn3FTEdmWnZT973jXDNMfjbM2nTIgOVcd
   8PJtv1qIeTh2Yy7FKd0HzmApQBdZ/YrigZKP5+t4huHPfXt4EN2X+KELz
   ScGrzxnDKJforo0BvNFtbdfLQyu4MOKDW/9Mfvh/CDhfhO33z7Q2uUW2/
   yLwiu4HK+pX6NVNr8fdWxzlGbxR+sPuMWRtfCEutZT+SygY2l3nGEhKh0
   0DngKsSTnaSG/iDjrcgzjEvx0MQ9iuZx+IUx2OYJg3ZDB8gQvn6fjtA8a
   A==;
X-CSE-ConnectionGUID: aNTVSRJCSt28EYw5/Z6HXA==
X-CSE-MsgGUID: QLqh5PYxQVeYmqHgUpcUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27674257"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27674257"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:38:48 -0700
X-CSE-ConnectionGUID: kJ1u3M1dRiuiyx/5CRyNpg==
X-CSE-MsgGUID: NxoffRAVRCSWh1ksF8F2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76261834"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 06:38:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 06:38:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 06:38:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 06:38:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 06:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHHCsctRmPkyBxOWMOhYumxDoN7YwffOLoI8Xh8tv0ORGwX+4Gv/hOJDcj5pp2JyBO5KHbGVok07DxSWhCs8OyJU32IW3U9ZbkgaE9Dl7lERC8ysmeyp0hH/6pshlToLzkEbG6ea8wfnvBfex5PsiBq4e3SPMFjOowNsh2IRw8QVzJ4qfRmVDz8RSYrcQN5HkE35NHD6T4v8qGUMAJSqjvRDut5bTNSgmskOLOHJoD8IdWtd/WYBq6jnYhi+G9oaId69lTzvN87wRCbzmJZAlnzpoO48azak0D1IddzrNy3woKiRY2j54EwnmVHhUs+GG2ZJH0TqHpDZzh2NXa8AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDV0loybYSm6Onf46acL/0B57E+vsrZJohalAF9aiXs=;
 b=gvWtIVt3/MLCljwM2MxsN+22VAe6iaSwnTdStpkN8FJ79k3+QkNwHnYmYudT/oZ3BWmb697VbwqgTCF1CdcDAOH9q/0Az7onJLyu+5/PcIdTyn4AZRyCPfM/SDcyViWHNzcLF6g0FQTrVZnEbOM5CzRLYdClroPtumlCj4e3AQs6Q1dHRTPupUP6O9oR+S2q/EDLTnHTWIMdDUJZPWT9S/sRpJXzMqWTwBkXWlVARAVXRgpSepQiVMQ4az1voT/rl0rgNznuf4LNDMpOnGc/9Fq9nEBn1BSt+VUx9a9eQaoFT0fiK3jjSqojnghoyPX2JGqqZo4b+ca7uBw5daEeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 13:38:44 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 13:38:38 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>
Subject: RE: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Topic: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Index: AQHbGkZvGPkGlPu6Y0mXskgCaB/USrJ+WQiQ
Date: Wed, 9 Oct 2024 13:38:38 +0000
Message-ID: <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
In-Reply-To: <20241009122547.296829-2-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ2PR11MB8450:EE_
x-ms-office365-filtering-correlation-id: 4bbe293b-05db-492d-cd59-08dce867ae4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vU3KiWp7h/V+tx8+3t4gklwSn/yqpOetCgTH1Y3HMIW+f4AVChshavUi58GC?=
 =?us-ascii?Q?4OALh4LhVH3eToIUgnSh91Z+H7OiPIxibbf+q0D7/+UM62k134VkPBhQErd2?=
 =?us-ascii?Q?XztxJ0rBrxQL5po/syHwd2+e1M5HfVGDWPM55BDf4N4r++nsxf/yF9hs+6Cq?=
 =?us-ascii?Q?iK8Y58dpRSy1iMmMZWyc9pxoUnGQY52wv88tH4AB02kivuA8ee/wcqTjRfhc?=
 =?us-ascii?Q?bWatQjvtO8L2CJ2T8GmGr7m+HywVrjiSNj1IgRxAJ39hXyg/o3mLy0tcPlMP?=
 =?us-ascii?Q?Okp1QwHE0DpAdiijWhQ/mLSDXgDeKCjZp/Y3ffSvDOKnzyEQ3/fjFIpYhR3Z?=
 =?us-ascii?Q?d3H0Pe4YJUA8ic1ZFzd/Tt8awoDA/IGlL6A5AYQUAxp7EbXTzoeS5AeC0v7k?=
 =?us-ascii?Q?BdWhzGJ/BDT4tfDx2u8I6S6M48sk4d1EAVDHniyP2tLrK460J64E643elwLt?=
 =?us-ascii?Q?if7Z1qHOkTZzLtlSG9/0bRIHUbgzE+/XpyQwu9I+RsHKzwplzQYaYnWozmxg?=
 =?us-ascii?Q?FKCJPIobhA4z9Nhb0Bxnvy8tWs4kuBWDPmuls4nuNbnBgNNxX9VUvQCtxNDs?=
 =?us-ascii?Q?Vq5IIfwJ257bG1QWAg/a2t8TuP7gfPEssjX5Q+4N11YWtQ/x4Am67SafnfXW?=
 =?us-ascii?Q?xOZP21nVSaFLouXDc5QVyx10vHl0Z3w1nehPrhYIoK8ayDD6SVMO9JV7R3Mw?=
 =?us-ascii?Q?eUNMGau8k/xTQs1j2nRVNnrz/m6iR5nPw7+NW1irg0gJpOy4Vy1gZdqor6qo?=
 =?us-ascii?Q?s0z6VAOy6AzHo9dbbeVfBZ8PWZnoYDoJ5d79VUBbaHvHF35PKOXFEi+kCSQ6?=
 =?us-ascii?Q?oGsa6dTyrs9WiRbU0Qd2mW/NKCIUi1umA/7VE8FIAuGYI2g8C5ULYwzZ6FgN?=
 =?us-ascii?Q?jzHaRxy3TykObH1UJBJ3BEXsF74CfYASJ179AGHHiHGXgqvmYxNVLVp5QotO?=
 =?us-ascii?Q?0ByuY4ExUwT7PMZPx9CiCWPt1IPgzjKp91zlSPpsbWfbdrC/h2FZolaX+Ri1?=
 =?us-ascii?Q?LqV9v9K22+tY84JX+eA66KqNMcx2lVDRFxETVCOKe+/g6ki8XlaIDz78W3Rd?=
 =?us-ascii?Q?hUTl+ulyNASZkj0cUyY4zAkwZ0mWau4XO99+AuT5OOdjqFC5SBzCJlX3jsHN?=
 =?us-ascii?Q?QZwOCeziqIIfGZWDhjUIFY8fHuyOknielbYUXix8vxttBMcUbOnmzYATBt6x?=
 =?us-ascii?Q?HB5dSzlaRUO7sw8da3WTsYItl4vYMbwQD4mf4rADyC6zgIfigk5BmM5YoPbE?=
 =?us-ascii?Q?kUSjXKTXnM7EU8yJ0d/9+WB7hsj2LbNVtM4iJcAOKVvexB3JjtSpVJsrDWr/?=
 =?us-ascii?Q?6CwarMKDtBTbQCV9FTmRMxOhpIyil53UIB9t4ozvSLDsmA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?afk1EKx/qgi/ZvWDxXIXYeftnvxMHmWxBqf4WGnV/MyPaTs5njAk5v6d4tX3?=
 =?us-ascii?Q?9hjQwhFVVuhS3GuIWOP23ZRvK3DyBIWBXt5bdlfEI2/R1h8lEjbDHm1m1pBL?=
 =?us-ascii?Q?UviiYZ2AD6oGoVYUUXkhuefC/7BayGe+D/Cpl7Fe/AEwBgYb2yCU4XZw1tyX?=
 =?us-ascii?Q?+N85HkuNOYfC+YoWEAp1rEPoMgh3N/QQsVJ5ZQa/oCvkDFhAY2ImBnU9CJpH?=
 =?us-ascii?Q?EOwXIrJvw8MyYWtdWbaaFa8LCxN+HnLlKhZSmuzLQ4JfoWmao0GDUUSwSDA2?=
 =?us-ascii?Q?gwX9qsYhqNQm6/ETXvqfvCLMSmqH1Z4haFGrEultvYxu9ATMJBZNXCeCVNAK?=
 =?us-ascii?Q?0fL16EncRbjN468PqU2C+9Kecw5diVT51Mh5YMINHvofI7v8T5goA33+xbfq?=
 =?us-ascii?Q?gUL29IXVhVm86hS3R25HVTWnnnbPY6fEhqICfCrEiY5OdSQisuzWFNN/Rj18?=
 =?us-ascii?Q?YjPogqqy0HsNvYJ4wQLpY03a/4q/YglLG0+7OrJPtFQ8PM6vEQnDyufGfDlf?=
 =?us-ascii?Q?47Pq2eddUTB+U/d0UXlNLOcra33R/v8wtlL3c0cS1jUMN9f82PkqYR1wbAjq?=
 =?us-ascii?Q?2OcZgih37w0gwyxS/Rsc3kKsRM9E3qOe3zbrqOu9q74tnXhBa1spxJURpasz?=
 =?us-ascii?Q?qFqUA5FYTNuyYm3OTztlZEY7gxhV/gRJPq8zN1pIFmZOLkcygCrzCwGg+QFW?=
 =?us-ascii?Q?/NN5I9GuZMDDsVQAZMpVEY8Ib3a4TsxPt/BjEsAWMiooQUnem6i3LZbjXGDK?=
 =?us-ascii?Q?175K4PQ2S5gKyvTrpdDeEhRODh6BVAOnkklQwHJssMbOfSG70iJ/l1ZbKvg/?=
 =?us-ascii?Q?m/CkxwvDVBLCs5Goh7dMyM9VDZjPJ2M1+ecjNCRjt4FGVj3v1p4fPUe+x1L6?=
 =?us-ascii?Q?ChAWLKheFvmEDHOJduxawLMHAl2FA8po6JuizHqxp3CyX5cE4JqQuxSfyxQQ?=
 =?us-ascii?Q?zDKPV1O4emn0ksiA3cpGCTJHNNWnvSIM6fUH1U5W6j30OLfkFUwbc7AQeFN7?=
 =?us-ascii?Q?ofcH/X7hUrpLMGDoCaYPsA2cuEApZnzg/lVRiZ4QoztiUFOvO1D4JDF0W0lV?=
 =?us-ascii?Q?CxQxH9WoGiqmrW+W4dWvtktMbWCaCNbpjB7gqbfOo20I5HzZ/lX/rfGG3Ij0?=
 =?us-ascii?Q?ByjTMo6bXtgi8aFiEGfnciEuBF3cK0eSyUPrdrADPLYneGAYlugrJqhNV1Ua?=
 =?us-ascii?Q?liG+7Do54v0A5MsxC11yGhzTetrHEa433K7Eliq+PA0Ldj73KeHBXPW/5R5j?=
 =?us-ascii?Q?drjopYAcw5IjLHoejmOUaAiU1FNhAfH88XEevw6i1pJEnlN9wBNQEAY/k5x1?=
 =?us-ascii?Q?51G8fWxPucWZw5PLwD3DAQgpNm/9jCSaMkHmTIVDLAeDKtHNQgcHuDGhFsG2?=
 =?us-ascii?Q?l//TCg2tBj0c00wlVk1F4YSI5R8RrkQ7vjnp69RkVw/UgO2c/UuRpIsJQGDn?=
 =?us-ascii?Q?N8u8J/l24gRiObp7g9/52n9Ls9VUImvZAdwHDG2XGSa5RHXdCRa6izVQxY6I?=
 =?us-ascii?Q?ugQdKO/WpzkvH/a4DuiBTjl9RRfS7tsCtHxWVNKuXOEePvfvuSvdd7zGjZlg?=
 =?us-ascii?Q?ZNA5KJ5N1han5qVL9CMg83VPOUCHoGK4KubvXcI6FP8bp6JJY8HKBq8p75H1?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbe293b-05db-492d-cd59-08dce867ae4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 13:38:38.3400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbF2i/5HDJMiZQtr+aFAXIhlVdkBJzGBo9zxuLUTd3PPjfbvpYnqiwtVk4cG49SXnaVNZk5C1hfdPG7LeXyKNs58uKT8VGeCktQfX/8chu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8450
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, October 9, 2024 2:26 PM
>
>In order to allow driver expose quality level of the clock it is
>running, introduce a new netlink attr with enum to carry it to the
>userspace. Also, introduce an op the dpll netlink code calls into the
>driver to obtain the value.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> Documentation/netlink/specs/dpll.yaml | 28 +++++++++++++++++++++++++++
> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
> include/linux/dpll.h                  |  4 ++++
> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
> 4 files changed, 75 insertions(+)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index f2894ca35de8..77a8e9ddb254 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -85,6 +85,30 @@ definitions:
>           This may happen for example if dpll device was previously
>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>     render-max: true
>+  -
>+    type: enum
>+    name: clock-quality-level
>+    doc: |
>+      level of quality of a clock device.

Hi Jiri,

Thanks for your work on this!

I do like the idea, but this part is a bit tricky.

I assume it is all about clock/quality levels as mentioned in
ITU-T spec "Table 11-7" of REC-G.8264?

Then what about table 11-8?

And in general about option 2(3?) networks?

AFAIR there are 3 (I don't think 3rd is relevant? But still defined
In REC-G.781, also REC-G.781 doesn't provide clock types at all,
just Quality Levels).

Assuming 2(3?) network options shall be available, either user can
select the one which is shown, or driver just provides all (if can,
one/none otherwise)?

If we don't want to give the user control and just let the
driver to either provide this or not, my suggestion would be to name
the attribute appropriately: "clock-quality-level-o1" to make clear
provided attribute belongs to option 1 network.

Then, if there would be need for different network options, just new
attribute and defines could be introduced without hassle for backward
compatibility.

Does it make sense?

Thank you!
Arkadiusz

>+    entries:
>+      -
>+        name: prc
>+        value: 1
>+      -
>+        name: ssu-a
>+      -
>+        name: ssu-b
>+      -
>+        name: eec1
>+      -
>+        name: prtc
>+      -
>+        name: eprtc
>+      -
>+        name: eeec
>+      -
>+        name: eprc
>+    render-max: true
>   -
>     type: const
>     name: temp-divider
>@@ -252,6 +276,10 @@ attribute-sets:
>         name: lock-status-error
>         type: u32
>         enum: lock-status-error
>+      -
>+        name: clock-quality-level
>+        type: u32
>+        enum: clock-quality-level
>   -
>     name: pin
>     enum-name: dpll_a_pin
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index fc0280dcddd1..689a6d0ff049 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -169,6 +169,25 @@ dpll_msg_add_temp(struct sk_buff *msg, struct dpll_de=
vice
>*dpll,
> 	return 0;
> }
>
>+static int
>+dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device
>*dpll,
>+				 struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_device_ops *ops =3D dpll_device_ops(dpll);
>+	enum dpll_clock_quality_level ql;
>+	int ret;
>+
>+	if (!ops->clock_quality_level_get)
>+		return 0;
>+	ret =3D ops->clock_quality_level_get(dpll, dpll_priv(dpll), &ql, extack)=
;
>+	if (ret)
>+		return ret;
>+	if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int
> dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
> 		      struct dpll_pin_ref *ref,
>@@ -557,6 +576,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>sk_buff *msg,
> 	if (ret)
> 		return ret;
> 	ret =3D dpll_msg_add_lock_status(msg, dpll, extack);
>+	if (ret)
>+		return ret;
>+	ret =3D dpll_msg_add_clock_quality_level(msg, dpll, extack);
> 	if (ret)
> 		return ret;
> 	ret =3D dpll_msg_add_mode(msg, dpll, extack);
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 81f7b623d0ba..e99cdb8ab02c 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -26,6 +26,10 @@ struct dpll_device_ops {
> 			       struct netlink_ext_ack *extack);
> 	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
> 			s32 *temp, struct netlink_ext_ack *extack);
>+	int (*clock_quality_level_get)(const struct dpll_device *dpll,
>+				       void *dpll_priv,
>+				       enum dpll_clock_quality_level *ql,
>+				       struct netlink_ext_ack *extack);
> };
>
> struct dpll_pin_ops {
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index b0654ade7b7e..0572f9376da4 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -79,6 +79,26 @@ enum dpll_lock_status_error {
> 	DPLL_LOCK_STATUS_ERROR_MAX =3D (__DPLL_LOCK_STATUS_ERROR_MAX - 1)
> };
>
>+/**
>+ * enum dpll_clock_quality_level - if previous status change was done due=
 to
>a
>+ *   failure, this provides information of dpll device lock status error.
>Valid
>+ *   values for DPLL_A_LOCK_STATUS_ERROR attribute
>+ */
>+enum dpll_clock_quality_level {
>+	DPLL_CLOCK_QUALITY_LEVEL_PRC =3D 1,
>+	DPLL_CLOCK_QUALITY_LEVEL_SSU_A,
>+	DPLL_CLOCK_QUALITY_LEVEL_SSU_B,
>+	DPLL_CLOCK_QUALITY_LEVEL_EEC1,
>+	DPLL_CLOCK_QUALITY_LEVEL_PRTC,
>+	DPLL_CLOCK_QUALITY_LEVEL_EPRTC,
>+	DPLL_CLOCK_QUALITY_LEVEL_EEEC,
>+	DPLL_CLOCK_QUALITY_LEVEL_EPRC,
>+
>+	/* private: */
>+	__DPLL_CLOCK_QUALITY_LEVEL_MAX,
>+	DPLL_CLOCK_QUALITY_LEVEL_MAX =3D (__DPLL_CLOCK_QUALITY_LEVEL_MAX - 1)
>+};
>+
> #define DPLL_TEMP_DIVIDER	1000
>
> /**
>@@ -180,6 +200,7 @@ enum dpll_a {
> 	DPLL_A_TEMP,
> 	DPLL_A_TYPE,
> 	DPLL_A_LOCK_STATUS_ERROR,
>+	DPLL_A_CLOCK_QUALITY_LEVEL,
>
> 	__DPLL_A_MAX,
> 	DPLL_A_MAX =3D (__DPLL_A_MAX - 1)
>--
>2.46.1


