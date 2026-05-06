Return-Path: <netdev+bounces-284994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFs/BPqK+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-284994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:39:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9534DF741
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD7C3008A75
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E264A1399;
	Wed,  6 May 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAqz/nkX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7052D97B5
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092683; cv=fail; b=UZUYl9UCSLTGHvyOvIZ6pJ6en6IXDCIlWsyHx72h1/IeVUriE6TMVlggUwfXTLCcPWVOE3NWRnoYbb0WCBdwCFWsGnUb9Lj2UinDke0duMiPm/T50nHKtzP0KKkSWkLE4FgKmlCZAqVf3IkQ29vKtvV/nLl/ezz6gLnT87A1cuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092683; c=relaxed/simple;
	bh=3e3FdmzE6gCq/lk8glWeIlng+wg4vdrofzSQH+BL9DQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFCMs/PNkFcF9uT9suLFqYHd1ucAyH6867k8knBPY3Igr3rcLbxOlh3KfGkKDqTCI1YqLd9BedMYmu474IaD/4YoSzHuG0VVdJ+MxPYYofx+GHfX9BCpegWBIIvq2EzQrJTUa8rb58pVZEHy9E3lEIL9y+2V5KZcuCNxWg1UxOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAqz/nkX; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778092681; x=1809628681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3e3FdmzE6gCq/lk8glWeIlng+wg4vdrofzSQH+BL9DQ=;
  b=FAqz/nkX0eArQTEr1KOPbzfJSxxsEkLUxijXPp9OmSgLN0xGq3Nplmly
   5TaLyYzVk0lLA7ASkS0bp0Jtk70tgBbxhUuGKg+jxfspj4itE4ycj7fh4
   +ucpUHelLlUp00+8H4VYAdDocy/Ruki6NkUMPV/nfM6XCAaNe8VTwwAHR
   hRast2Sn2g83AikKIz8p+SlGpPriLvjSDQ8tP0YpOTZ/XnHJh7ckbXdmo
   OQ3l/5eXsXhwpXA9EqVzpr4Cc7kU9t2nl/kOOwSuqBmzTB5p5oCKYaOqQ
   msA1tJEaohJ4SXxTVBDxiRWjA3wwInpd9OsWiDNHxd4VMcOQ4p8RhRw2I
   w==;
X-CSE-ConnectionGUID: DwS298NBSK2WBaJwRfKvAA==
X-CSE-MsgGUID: Oqc1V2IUScORc49ZEfTxoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78061365"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78061365"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:38:00 -0700
X-CSE-ConnectionGUID: foTo6GyITUK1EhDun29Ekg==
X-CSE-MsgGUID: 3vujlmadQv+vEr86E3d74w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="233567165"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:38:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:38:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:38:00 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMoUbHiJr7/AxxyDTLxgUxNxFzGttJ0oCSfTDxJmu69JiPONlfN2CEd7zb4XEG3WBOGWLzhKzVsIHKS6sqKjNDqBCeZgkb/j4ULv/WBmOFCVUY/hR3Tb9GM9upu5Lhq0oLkCLz23tF0SDW46vKYZbUc55Qpbx6i6KukchfdsoRuUMGCNLOAmer2PTKB4NEeNOIMF6dxzStzEo36aKyRVv97Ac4Y1OomKfLDF7gbpNDW2WJg9FcZLCRfxniNzvcb+CkwxzcrlC4mwg8zeGDugvk3QKwSNrMia9lBDp/KPG16wuWTvXYKzAv+E80NYjRygEtQvVENTJTdeWJE64H5G5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/RJZzIsIdbhh2rVWfH9rOrOUM4/n7feNwCwOvM/B1g=;
 b=G4cRYDQYEd6g8k2HTiqH/XG7UNpBYRzVF104x+/Mg+je1WkM8lNh+bm6CiCqFqhnnSd4dgTiuiBkcpoRbEyDrbfbsZy1nnmajo7/M4LR0Wf1EIoxDJDj4Z8wYer9S3Lhpo0gwk1ZhfXQn4D5+9mEO6AnDNx7Y6D6HmqXHMcwzok2Xj3Oq7o2epZAW6F6eJzw604U6Kg38NOBNt4dNfDw9nj3P484tbKXulyQZ76ld2Ses/yvB26mS/1F8jaKAlY7dQgqHhXbuPbPedJx8hUxQiJiGr3LPfnsh4K2Dy30dUwrrM1/gn6QCsYBQDbElBVnlNIZOm9QocAPt2gdds+oCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 18:37:57 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:37:57 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Cao, Chinh T"
	<chinh.t.cao@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 04/10] ice: create flow
 profile
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 04/10] ice: create flow
 profile
Thread-Index: AQHcyCD86Db4FcG910uiSX1FL7/t1LYBflqw
Date: Wed, 6 May 2026 18:37:57 +0000
Message-ID: <LV1PR11MB8790B7A5175A0B088903F80B903F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-5-marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-5-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: 0d82ddd5-4af4-4389-a390-08deab9e9803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: HojDuuIWpgoBAmPIubAV3ERWNwpniMTXK9qUFIjXC/mTBHoCCong0YLavWJA3gsvPc7FbkkvdCAiJ0mJfU7KbazxPqg7dvY+3vpSBVXvPn/eYLKA87bvIc5KRmGColaDBi0l9GYTccXIR/ehEHbxHIH+HTE7/FSehs98i63J8nfTHPv0KPgz1vC2EiHIjv4u7MJVc6EEMB6xAnKs4B+3nN8Or4U71j7ovB4vvzXUgz4ebgwhkzHfia61Fu2P3/VECI2Sak9YM/Jm80xdNzksx6oxo7MPPnlTGFfZ8y5wcxC8gLdOlMxyDxUw1WuTTTn0Js8jWIy2vRZ5koY1QGaaFT05VRIG7jfyOd0jwPaNDI0yqGqiyjQNR4LrFDKjr3PXxNCF5fivhQnfYWf/OWI7SZ3t9+h3Osu4L4dAPtPaj11bpHGl8WshaCZYDrdBoJukLeta0e7/xdICYdCYgi4+Oz4Ck9QavwrJh7MEX7B82kyKH//oCDO9acoEI9EHJgyGWlnMDYaoRKNsTqCY/VFfVvAGuAPpmNvELKaVoThLK+1wZHkPj4FecKDxFBc8As7iftQ0FQmCuFCXNRlrbDWF9Ihd/9MYZKQebU27yJntzPc2zQjdOOaTnqEjz4ml7uucuO5SHSYsRo5ajL4unP3VMmcwwFm5kDciSYnte3Z1Y1Qm+FDL3l6F/y3qLEOVWnwEVlYk4pR5/grcREweXrdXHvUsdxGYbGJ8Q33Bu7n41rE1FiSgn+9qWnJYx+hMBo7e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?umaM9S5vkV5c8AaF3+XNSGHntgjPmD0VHsaWARJrWylpaqwjx+7ZM6W+Q6XE?=
 =?us-ascii?Q?kEMAJE9P4njDh9K/oATAcWywKydNOK3Qg2ksZ4Qk8A/mFLpGdKz8Wlu1Z7z3?=
 =?us-ascii?Q?OjDqPeGYyUEXC74+oe/RdPCH2+TdQRcLaxriuGTinHMo6e8nKOClYIMzeUbO?=
 =?us-ascii?Q?8Ktt+7lM8oGLmkCOsiAdVZVZRSj/dG62vfZ6ZV9RU4twbw9ECTXQ4bzN9nM6?=
 =?us-ascii?Q?iu3Z6TzQvkOV94jNKXW6wfc/VtIP7ASgSHMSIT73YLXkVuyyRe3WxFPLHLDC?=
 =?us-ascii?Q?gzN+uWm6fBHf5swawapyoi0svw/OsPtrY2ADaiYM/G9G6XWMDq/zc/rQOYkz?=
 =?us-ascii?Q?5NTkKms5fNQenAHsvJrEF4jCHwU7xLrtpAhkfN9MW/LjOpVwTjasnZSOtmGQ?=
 =?us-ascii?Q?QbeieCfVqe3im5A09FoEMJupgj1R+RIdShFiUEyAMEr0B+mSgAHSvweIMrII?=
 =?us-ascii?Q?VHU1Mp9RSf/laGcugQbjIdM47JsJJkyE33e56NWa/IDYlA0eNUs0ZP/10xrk?=
 =?us-ascii?Q?ioJmKJ4bdhFRNBUHFtsjodDzQk7qDggTMHeCyjeYmvomrAXzhj+BIUdvG4WC?=
 =?us-ascii?Q?sm10PepNt/hiUF1znaNMiMLfb8XoBBH50srWwnvWBYcGgpA0C75WBgeKa0bR?=
 =?us-ascii?Q?kzSzkoI9NEqES4ogvbvigR3KJ36q+VbBH4SltsBzb4zdOaLHmAT7ohdSF6DS?=
 =?us-ascii?Q?XH86Iiw5qPSdepxYDbuQclmGs5GorO/QkB9MHn1jDYeSAoYMqMi8SK2gYN1G?=
 =?us-ascii?Q?eXvDnL6rCh5sVDcj1vx/tjIjyQpMH0lQ05qiLV8t/mPGC3fmxlcJlCHwKxtH?=
 =?us-ascii?Q?b14uac1U2t+YFHkg8iX8K3xLrR4EiRAQ/QT9ycGMhtrmboUoyjVdnXEp2E4T?=
 =?us-ascii?Q?ONs54fCNwP3YyoiIWGmJHcv8BtEha3gRZG+P5tAGWbX4frGPAcejWg6yvtur?=
 =?us-ascii?Q?/YFDcXmdFzQBfrmRy2wKbzjwpqLK9C1sxwSO7noOE+lFjW0X0sTLvqSuiX67?=
 =?us-ascii?Q?DzXu0kksepOZIvmEDl3oLURJGOkhDcpbjjxhBRd7o+5k+8FfhElRaLTCqpEQ?=
 =?us-ascii?Q?Pv1g2Dg+jLCHy3Ss/jTtsB5erp7hqkhN0S7iPiilqkWfSsQC8Ol12ivWYtba?=
 =?us-ascii?Q?A2+B/2XZjCbzhK7FhkA/SWFLka1lkUQ46C96Va03HGxJSfXdlszZseSa1iJt?=
 =?us-ascii?Q?yeOYNrQdhdIzp/f6JkCdo6zX/kE8YtZ0+xMqN4XwGaAggIRcFsFWnbDYUAkx?=
 =?us-ascii?Q?wJ2tAGFwM/CC0an+y6+pdgltNPYjV7oLN2C2Z8X0A7V5uhi/dReyTrxf9L8o?=
 =?us-ascii?Q?PcqXQQmmiGzOUun5nCmgMSkvZIyAl3GiuGVi+Z8oVau3uL/2CXu8aSe/u5gX?=
 =?us-ascii?Q?vhAT4Eug7kE9+H7pOsD3pFwZI4tDqmSDfgtilLXEeNzABfVXn6JGPki3UMrG?=
 =?us-ascii?Q?Q4LH8Gu4WmriGsKIRG4sUSeZouL1IaitCcWEPkIZImHtJu2VFWQpqv43+fvP?=
 =?us-ascii?Q?WYesn6z191ldObSgXBynOGZSB0h8VbBwEtYEAEd2MLYtN2/0ceKrMzRo8KVQ?=
 =?us-ascii?Q?MmxALs7DyhH91Vk9VEjPGKuNbxACGcL+D2o/SjbPQOQQ/fiUDU4gwhI5UO+s?=
 =?us-ascii?Q?Zyq7cqnD/LpuwwGZQJVCyYBZRlptjNGP6LwGXUfh0pgrg2aPJvKiq1L1IOmv?=
 =?us-ascii?Q?ZGt273rxLE3dwSiPFeNt3Nts+8A7shJSgXxaDUIc4uhCha2lbAQeSYAyyH6T?=
 =?us-ascii?Q?SXdbWsSPSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kTelOlX9z3MGGcyEyu6hvbFyaf0AL+jnZKKJqG6Y7YZeYqKk/2vxqyQwSYl0Yf/v153rmEsfvD7W5qFoglZxW1RGzfu39AOcZSZsH3VPH8x3aSerCKghxzAgpA82mT78QLb9li7B8ycumDys2dtSTOXr9t4dQFfjQaOTl97xdP4rDQasuXNfOuBPGaEqiGW69ZAthfbEVS/eergPH/2oGQNF09Y+k/CliQP1vEKagMmG8MiZCnlhdsxbi78nO7h/7g79CiK5Y8K7cSWPdgoMC6qCCkrn4EkaTAaJAwiOWkFyfHC0oSA0l+ji6fOMGUQ6YB/PhFU5P++Zrhe8PjnL9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d82ddd5-4af4-4389-a390-08deab9e9803
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:37:57.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WKVLnXnyjyPcAYxMJAvO97BRpemDH4A5me3GgniXEnY61U69r1bQVnsF2KQHX3oFfhaL8GNA/1PE9oSY+TmXOnZ6PGpC472TCpAse5XsJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4C9534DF741
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284994-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.547];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, April 9, 2026 5:00 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Cao,=20
> Chinh T <chinh.t.cao@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@inte=
l.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 04/10] ice: create flow pro=
file
>=20
> From: Real Valiquette <real.valiquette@intel.com>
>=20
> Implement the initial steps for creating an ACL filter to support ntuple =
masks. Create a flow profile based on a given mask rule and program it to t=
he hardware. Though the profile is written to hardware, no actions are asso=
ciated with the profile yet.
>=20
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2:
> * Add ice_acl_main.h in order to not awkwardly add prototypes to ice.h.
>   This will also help avoid potential dependency issues for future
>   additions to ice_acl_main.c
> * Rename ice_acl_check_input_set() to a more fiting
>   ice_acl_prof_add_ethtool() as it adds a profile
> * Set hw->acl_prof =3D 0 in ice_acl_prof_add_ethtool() to avoid use after
>   free
> * Add ipv4 and port full mask defines in ice_ethtool_ntuple.c
> * Move hw->acl_prof allocation to ice_init_acl(). Previously, it was
>   being deallocated when hw->acl_prof[fltr_type] allocation failed,
>   possibly with already existing other elements. Extend array lifetime
>   to driver's lifetime
> * Change hw->acl_prof[fltr_type] alloc from devm_ to plain
> * Add hw->acl_prof[fltr_type] and hw->acl_prof deallocation in
>   ice_deinit_acl() - previously were only deallocated on failure
> * Tweak alloc/unroll logic in ice_acl_prof_add_ethtool()
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |   6 +
>  drivers/net/ethernet/intel/ice/ice_acl_main.h |   9 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  39 +++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  17 +
>  drivers/net/ethernet/intel/ice/ice_acl_main.c | 229 ++++++++++++++
>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 299 +++++++++++++-----
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   6 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 173 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  33 +-
>  10 files changed, 731 insertions(+), 81 deletions(-)  create mode 100644=
 drivers/net/ethernet/intel/ice/ice_acl_main.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

