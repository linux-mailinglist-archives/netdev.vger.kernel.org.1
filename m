Return-Path: <netdev+bounces-180762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B8A8258C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757C11B63C58
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2362397B9;
	Wed,  9 Apr 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWA8Ezeu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B725634
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203719; cv=fail; b=gjFOruFO+0vLE2MB1kS8Ml1+xyA/B3RmRne1MOmxO/vyknQs481nBRbfd8u4YyEJfARrICoJASkOcu7bPr8JyDiTdh9GbQezdIbN3er5S+eH+nTvit8wvNu7SYL8KB9C6tS4wqanFvckZW0+L1rBu8djo6qn0ONMEK9jMr1DCLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203719; c=relaxed/simple;
	bh=a3EObzrmSxXkdiYX6fSFsStSTFxSpSjEomyrsspU0ys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAdkNJQAx9KRqmdF9pwEYR0uO734KCSp4F9kki03FBynKdxDE39QNdDUFwSK4aM8TArFdCffiVj9zkzmJ4yn+wT2+bFaeYrexpzR4vdR5m5NSq1fxURQFJGJ7v9mMuTnfP6r78yTLJ1otNIhRjSQJX0sktm3grgc9toq1zYXkzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWA8Ezeu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744203718; x=1775739718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a3EObzrmSxXkdiYX6fSFsStSTFxSpSjEomyrsspU0ys=;
  b=mWA8EzeuKgawuuxiqC2pCR7Iwkm1mHNtStaEjKgi9hElbQKjHCcJlZTW
   Gt1EWpm6PEqNpm0Dlwxn5nOoyVRRsKNPdI4GfU4LVDkPiB0fjkV6tUw/D
   42zN+ts3IsPYPo8MEg9S3WHdPTwox3UcbIvcIlm4/Qv3t51l7m8PNVMhR
   6chogaq9Ii3qoXQar3DvDTFdgo5dEvoCJsyWym8bEsh6sfPfC5m4ZqIO7
   5ZrVLCm5MQHt4NCvpD6Vb3CyAO1i5q8ljsOZG+EDZSdBUuEG46sGuJckZ
   YOtaoqwaV7QGDURFdA/KBiy08oLuesryMkNPTOLRY9Ajr46mRgTR+dY+Z
   Q==;
X-CSE-ConnectionGUID: VJHMGvx4RsqP0kEinwPcUQ==
X-CSE-MsgGUID: QrueROAwRS6cH8IQMz+stg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="55856680"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="55856680"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:01:57 -0700
X-CSE-ConnectionGUID: j4kh5X9GRkejZmTcpT+b9Q==
X-CSE-MsgGUID: 8rrwQuWfSv60VFFysgYiLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129540508"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:01:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 06:01:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 06:01:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 06:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogUFrf4RA2oY99AMPumtykFh4yqfwx8C7N33n0u/VcWN6yqn/BJz7tNs6JhQVikU4ep5/iA55eLhgjUqSKNZOS1RGL7nHOWRC8T2blS59vbLCWnj8Pvly+9vI5+S/ZxRYAzgVhpIouBYIvqq/LJRPLEzypPVUs1VDP83N0IYV//hTXwfF6ybzDuOKVgOnXm6a6vv/ixWuVGHRoybX0eRlmFiOnTuBDBbqdRMR9FZANG/ATtleGzCn8oHBdtOBovnNp8vyPrS+sNvli/AU4BAJT166cm6tdyICAWUxcHXcGLC3YLTdgEzKb6sQwV12vKD6O0EJo9NgJEulQoRmmmJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iJBhs1X8VX58v90etcm1ujrRdWudPaXA7gY7PWDKac=;
 b=pr5071kUINHeKEt2SuBhgTc4j9vvLSoCqa7BvpIz2kqh8qO+kw2gff2rhEcAA88RaMtLSCFJL9PGDzgOP9nZ+gwCm/GjUcEceSJpFARrTud6L8/i4RzuH2kPGJYoLWwj2UZqQv2SNr0TMZf9He9O93DIOZaK71NcwHH0EhdOmt/Y6jECD1q46XEIxvllNRSHMDpVdWkbXySEVuj9pTSu3p7uTvgKUBpFKUjBL5boSKkKbhEKKPyVRwkpp8oScrREdl7IX2EcegjX82iIxTpN3X5V4SPxcO7oXdpij7iJxlu1Re1b3tRLF3lBSBJJufUZO3FfHcte11MTd8UZIhVyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 13:01:21 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%3]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 13:01:21 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
	"Salin, Samuel" <samuel.salin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v10 iwl-next 06/11] idpf: add mailbox
 access to read PTP clock time
Thread-Topic: [Intel-wired-lan] [PATCH v10 iwl-next 06/11] idpf: add mailbox
 access to read PTP clock time
Thread-Index: AQHbqHM+oVY7wl6vTkKRI0vBuajUsbOaRjeAgAEHpMA=
Date: Wed, 9 Apr 2025 13:01:21 +0000
Message-ID: <MW4PR11MB58896B0420FE0EDCBBAA67D08EB42@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
 <20250408103240.30287-15-milena.olech@intel.com>
 <8e97d23b-f848-4649-ab1b-51e310757ad8@intel.com>
In-Reply-To: <8e97d23b-f848-4649-ab1b-51e310757ad8@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 0e4d1fa5-b7ba-4bce-c887-08dd77669ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4gJx9Gm+hAufrpQBfpAhFPeKZY/5QHQoQkc9RyHZSP0SfYPMHOTTdNTkwobr?=
 =?us-ascii?Q?1Cjvf6dMdHP8n70sSXwfT9qLb44syvG5OGLPgorx4+O8PSJNoJD99jcMLInG?=
 =?us-ascii?Q?EqcFAf3nUXg2AuZVE0jcbfStBzeqceRmuEogLBBthppTjQp6aZSa8I1m5dA9?=
 =?us-ascii?Q?UUb/Kyx79Ar2lwfjlj+I+3K0ozMCG84gVaQhdRHv8MniEcSzBLPeYpipmynr?=
 =?us-ascii?Q?pnOlFLoj8n+eXsjWEbq9xXlrZRxZi/5GbZ4En/spf1nndH4BM2kmODKJuB1f?=
 =?us-ascii?Q?rpAjy+khNscBV3O6MKe9XDoJLXQno1Ixh7b4JV2QIHOlIFTjvRiRDl4F3d9/?=
 =?us-ascii?Q?iOGt1whYWDBNyQ5TPqbFT5TduEvzNlBJOCPhuH95gPKoTbRex9sdsdgOBAMU?=
 =?us-ascii?Q?siX/YB9ppsP6sfSJBmgMGtGLrX2EbpQ93ZINtIeOspg9ImJ0yjauvUuhrHLr?=
 =?us-ascii?Q?cY0Rqrf5Fgdx6sgsLHyQ/nZjGHuvuoZNP3CBct9EgUfLRwLITUYkK4DEpc0/?=
 =?us-ascii?Q?4Zy5CHdfY3cJyybeL12ZG/3T/oBAt5I6c5C1StBAkyDB1FPBnSQZCakRix5y?=
 =?us-ascii?Q?pImSf79FQDmXasaZv15wcxMBbzyalHeOdrPj2JU6XGnn8O822xVi/8RwObRf?=
 =?us-ascii?Q?XLbtBPr21IqDjTj3yDF9GubnfCo7ldBC5G5n5q3eEg6R8hlxiI9+YzYxWBn2?=
 =?us-ascii?Q?Gma3Wpzoe7/p4w2ENmRITfn7o3sY1sfyNW8NRqsA3lQJz9ihPM3HNggtDdrh?=
 =?us-ascii?Q?M+TP2f2jhI8jxVSgNk5ToJtl3PbLKLofMde8YrgJaeE38T3hKR7eRg8sHlCn?=
 =?us-ascii?Q?deTC/G/U9uyTaTq7S4ir9Xf0DUIc7TOwhcZwpPz9N+A9n81nAGQhhJBc3Hql?=
 =?us-ascii?Q?ktxNH+8Kcng9Z/NtoyRZKE4zWIdaF6PvnC7ovSAfEGQE6TY7KJVJIJ4wEKYV?=
 =?us-ascii?Q?XW2lzQK6lzFiB6f1SjFc5W4Lz/iwitRqqm1ATnAoWfZy1vkU2Tf5VFahBGxc?=
 =?us-ascii?Q?aTsB9FU6f6/F1uTOmw3+7ZMRQ6sRYt56E0trYvzqnfTguQvdqbrCaWBgGG7u?=
 =?us-ascii?Q?TgSf66Tbd4M3t+cfgtPWaJCvijSVcaXByzMI8lsK3dfs6k2S03iemCfeOBTw?=
 =?us-ascii?Q?MiUuYRBTLVYy8bIH49fl5IUO2UGoD10H9nS1BxIINaivf49rb99TOBa/+u0v?=
 =?us-ascii?Q?u9iEWj8YaIjVypbGPzFA0rl+Mvp4ksqjZIDoc8y5QZweKL3yPsm+k79XjwZ+?=
 =?us-ascii?Q?orTiOSqUkPR8rS4cQfpW2GpBlaYpw+ncl0MITdcl+573wnFnxwbw/1jQSCqQ?=
 =?us-ascii?Q?S/Hi8M92HsxVCm1XcAblm6wzAXTOnfAPkVziMUDSlM6BnjQXfzEnFxLlcEB+?=
 =?us-ascii?Q?MU9cwNDG4AKTNYmnphdhC/hbkIft9Q/vRx+GPU3RMYQqj04nlo2ywgvM95O/?=
 =?us-ascii?Q?jZy52TWmGApaRS0t6dQQlGRSDJ0ml1Vn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zV8XFISKbd1PIokkskZB/r0tgxSRirmhCft6+5CCgNPd1e9dCGQg7VYArJuz?=
 =?us-ascii?Q?S3Q5x0vGO0k18D5BApONg6AzGsOcB5nwskKgo4oTg4scr6OdW79KNOGqC5/0?=
 =?us-ascii?Q?vrWl0YPd4SzXSvuPrN2AirdtCHzsFCDaPBdq03y2F5Z68CDGwEe22eM1Tdbx?=
 =?us-ascii?Q?bqvTsPS48dbm6ilfm+BHSh5RIcsX3RSFcz/wMVrDRA67qWKJAsSpbG74ZjHH?=
 =?us-ascii?Q?JqtLa7v5NU6Hj11NR+xHaHYU6mDzLgHoPf7n5Vz4yGJwQ7xnwgxzw26UN4L8?=
 =?us-ascii?Q?/adzdWHc7dmWmbaP7TP3sKBWnp0gnfc/nMRJr/B3K9B+1nyR5x454bImVO5f?=
 =?us-ascii?Q?jHwhST21gxYhgiU8fT1z7BHecnoZJvJJz1XR/vS4xU9xvvA6YhpZJz/8jxiS?=
 =?us-ascii?Q?vVRocA/bCMcMWQcGYC4/BAO8ITodQcHEkPSCDihksb23RS0he9Ur5OhaQpuh?=
 =?us-ascii?Q?/rLZtTSd+umXD+8TncyvbYaXlQooW09xzAm0qLPda1Ru41y1Ho3a/l6T0Iql?=
 =?us-ascii?Q?xRPWYSJFDK7J87MycFpIQLX6ebRiaxM2g2eCY7CLtsvkBZGcEoqt739jMj/r?=
 =?us-ascii?Q?TyQ41c7lmDRnkJ5CqqHhv7IFARvY9HRxX0rZCnjv6Dl7G85f2JG5ToEZAHUv?=
 =?us-ascii?Q?PkH+9y8dajg9VVqxSKTPMGdb37nbIZw5I4xwXqYOrnMp/nUPA4as3eZI/IfT?=
 =?us-ascii?Q?JVjVBvRoHRpfO1qx9oQjni737DnOaJi1xcEkGdyCqOyEZ/jo/ZItgBdUclQy?=
 =?us-ascii?Q?Fyt5OTM2HBhacwyidE4qS0TarwR6W29ufBDqU9yM1rBi2PBTvnmPhtW/MJsA?=
 =?us-ascii?Q?NXyLc7CvmrsOvzn6ZDxzC6yMZOkGK7fEnb3E+Q61YEvlirjV9TKwRrNlXyAE?=
 =?us-ascii?Q?Ngqe/4mqnbiRdbrle/GNwZgddPgeRPnD/1CR1vdo5LpDU5buy9eQMXYykIAe?=
 =?us-ascii?Q?06mv+Ifa0jw5uyBaSZ6lUy75nBMz/ZXceV7q9nU6NOhD3HpyzYbyVWs3jc6+?=
 =?us-ascii?Q?V+eaBC2m4hY2o5gYWLoTY0p4FO6ybUtIcQdIWIsxQ7pcwGWXChtyg8ApwJzh?=
 =?us-ascii?Q?Zn0cnAyc9HOaMEQwCQa80ixOg3C3KA2Rky8lKr19Sgk6N8jrhT8HDbEdXIM+?=
 =?us-ascii?Q?+fzez+t/5JYteOcp2OM+QKtSaJ2IfExSJpmm5BzOSz0NtBTSle2FnzqJSN5/?=
 =?us-ascii?Q?eesakHFQCofR1RlCzx9N4eH89XqzSK0elfBunC/jeAO7I4DCk8uT0oTimrVA?=
 =?us-ascii?Q?/jEEedMsa4h3nE2CBP5V4IT+9/Zb1+FXZFR8yT8ZJv6a2g98222aaQx/Zwwr?=
 =?us-ascii?Q?DTMQo/KDFuJGjMnwsuoQ2enkQH1WwFOqVAduL3Nrxa7GYp9nj5tKvGe9iQ1t?=
 =?us-ascii?Q?RcL73ZABc/OzzmeitPGULWYFuZF72JJJ4TimLygG694HfpLJ0X13O2AtESi+?=
 =?us-ascii?Q?XRCtTR0VYgIMCHbspTX+w651QaP7H6/LD2zoP9/9A3r3pYriUL1W/pjGbgSP?=
 =?us-ascii?Q?WJsyqBUKyXNBsOA9/AkODH4K+7qGebhtIg6cV9AtPeVSXSkFQa6SVG6Bxkz3?=
 =?us-ascii?Q?ZOI/Ed99JnjhYrYSJnWQn/7pd52SYfp8Qww2bqfK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4d1fa5-b7ba-4bce-c887-08dd77669ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 13:01:21.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeUu5s/GQtO4FDIJEsz46aw2+sAAmhLM6uhCa1OAdMsGsUbiXx+Jc1FOgZtFeptehfQl5+0Sz4pe4zMpK3lMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

On 4/8/2025 11:17 PM, Jacob Keller wrote:

>On 4/8/2025 3:30 AM, Milena Olech wrote:
>> +static int idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapt=
er,
>> +					     struct ptp_system_timestamp *sts,
>> +					     u64 *src_clk)
>> +{
>> +	struct idpf_ptp_dev_timers clk_time;
>> +	int err;
>> +
>> +	/* Read the system timestamp pre PHC read */
>> +	ptp_read_system_prets(sts);
>> +
>> +	err =3D idpf_ptp_get_dev_clk_time(adapter, &clk_time);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Read the system timestamp post PHC read */
>> +	ptp_read_system_postts(sts);
>> +
>> +	*src_clk =3D clk_time.dev_clk_time_ns;
>> +
>> +	return 0;
>> +}
>Not an objection, since its obvious using the direct register access is
>preferable when it is available. This will result in a fair amount of
>jitter since mailbox timing is unlikely to be consistent. We also cannot
>have sts be filled in somehow by the host because it might not be
>operating on the same system clock.
>

You're 100% right, reading the time of the clock through mailbox is not
efficient. But as you mentioned, direct register access is definitely
preferable.

Thanks,
Milena

