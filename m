Return-Path: <netdev+bounces-119548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E9956248
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773F71F224D2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060F157A72;
	Mon, 19 Aug 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQMMOMVj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21564157A41
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039901; cv=fail; b=lYZVBGuRafgxSMOiLdn0G4Jzlr/12lV7jNp0wmcJGrPbe15eD4S/XO0nxxmeQVf20L1/pm/6ELtLiVrMf5qkXyk+TvpNpmVXAnpht8kpT79lvGvLqUESbsChtKlA0abNqE02bnjlOaBomMNUApFozv2R3Vb9M2CyRmjFMnHqghk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039901; c=relaxed/simple;
	bh=wQ1GnsFNA3GDdUCXYawxDkI1cQrvdTJb5tBUFsyb77c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ndp2clNIO1hkGWv4xY3o6NEVgPuCBa9zD38E7Xntrt725G49N/rxHLrCpMFg+2NdsHV9NqvlMgRU95qbsxNzvVHA8dsYkh8Moj1G88373WdX61Tjn+S6X3O+lcfoOtOSkg0vnKu6ixm4OfhmRz6QbGptIIE2hmBfBy6FAWiy3eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQMMOMVj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724039899; x=1755575899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wQ1GnsFNA3GDdUCXYawxDkI1cQrvdTJb5tBUFsyb77c=;
  b=OQMMOMVjlmYV9Mfwxf0kesH2FcZHjYZR04XTSHh/4Uv8DRo5xuZ0/VOr
   H+dtkA7Xxv9W+zj5vH74A7GooM6z1JFewcXyP6mr+jYoP451KUsDsrU9A
   bhkUKJGS51k9T0L4Kh3GEtEHossmzco4n5P7VA+PEWbYS5g3pKv3ENfMW
   mofmtFRXUglxNWwgTGAA9mgH2FN0XINkpfDZfYDeuPtpnOzXm39pe80yb
   fU5koar+zFE4SgO0pTSpNf7ZRZdNamHUydtUGSsgc1pJQjc32u3ErxWP7
   +CMwqLfaMPCOI88TORbwLwtL0NOOLa4TTLXYAW5zBU1eiYgLOSXHMV9Zo
   g==;
X-CSE-ConnectionGUID: KxNl1rfNR3Gkc30ejRZD+Q==
X-CSE-MsgGUID: vvyQTM0cTs6L1y8hRgIyjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22409897"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22409897"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:58:19 -0700
X-CSE-ConnectionGUID: jxb0nJgcREGz53yN/fHGdQ==
X-CSE-MsgGUID: IH++sD//QbKnnm8suAQQ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60226335"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 20:58:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 20:58:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk9U8fPLtnw2tYl/6lhZ14LR8xshRXh+IkifWa8RPsgnETIr78EuQEqSsnEsqqUB4fg7UmteS/bC0PJE+SKP4PryCI9IcqCFfY7dy4feVnbiUwXmgKhycMxr/NyfKOOKsY/vIqxgQmgwBwcGJ/UYK6cK+egx3JElmNQ7IoPFtAa+ZoONAnqGAdKKGu8ne2mGVexI1Jj9rrwVD1C8FrKP6WLovDgeTBF39rHnZrMzQ+gvBpppyuvY4x+h5lFsJOfUMSPvBW5SvVqn+TxnWS7fpBD+fcpeQ5fYw8ZHxh8QUq06tr/NxV8aA/oozftLzgs8jNw5cSBWzhoSqyreVjROaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afuspkmt5myh8AfjTVWzBrnIvhPI+q09P5gQLNaWmYM=;
 b=lIChHdulWrT2rNu1B7KYneffokViepZJe6r/AUcBPNqZt/ReFS6XHtVRPEoYlITxPuSGIv6L5XYZpcAiiomCKgdoPse/90NTAZxUOT3eh+oEEx8Tauw7nPB1UpEZcu6J4fZuc60txe3JLBTDgXWw4cU9b/QASwlNgn/dBL8+wf8DiETAvy5PC10sYqUY4+3RLHTtGMIyksDKp19loEp5tyoaGqPMXueoysEhIcETU62O8haXue+/hfOMz5QjBmlbaMHmFbRpKn/B+Vno3d24NVK6uSksc2CeV2QP/5rdY56P7dNdtQOHqRV2kF8BiHAekGgYI6CMK6TRRdR59M6tRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 03:58:15 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:58:15 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 4/7] ice: Cache perout/extts
 requests and check flags
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 4/7] ice: Cache
 perout/extts requests and check flags
Thread-Index: AQHazIYxeAfxy96KKkq7j5OBraCRkLIuPdNQ
Date: Mon, 19 Aug 2024 03:58:15 +0000
Message-ID: <CYYPR11MB8429D55F9882C2D4837CF7BFBD8C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-13-karol.kolacinski@intel.com>
In-Reply-To: <20240702134448.132374-13-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB6792:EE_
x-ms-office365-filtering-correlation-id: a0c9d641-0c00-47ce-825b-08dcc00326f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ee1trX63p4dkmDO6tJLxk0xC52DM9ztWeH9qn/CseYGqPXD7sQHriUeueO8V?=
 =?us-ascii?Q?JslKRgbQyP5IVnPrsgMi+QPHfcKBxzrb3/RkZKwNLNEjkpBkJ3Ht3G6UQRPe?=
 =?us-ascii?Q?JbwcTOQEhcVsU9yQwiZkNBoESofcQTRDIPlu2ne/78hLAdEEmrnyxjwVKLP+?=
 =?us-ascii?Q?4tK3INfCIGr0U1p/45YYWRtq/Ig6mKHSEFBM0vAuK6Qxx1UjLnVc3zfDzBOD?=
 =?us-ascii?Q?VYaVFI45x92GDP76JYq90bbKzYTWcDeQnq25gSdUt/FNX+gyX8/KiDSkDD8N?=
 =?us-ascii?Q?ABJNVQr69sW9wKK8fPG2XeDlpKy4F/m/adIYyB+v9cbTw85dYsb9KwUvGYaS?=
 =?us-ascii?Q?D1w5blAwP+XRczLOK4aR9XmgIKp60Taqa7HE8npPTKi4V/40KkgYwJrhSLdu?=
 =?us-ascii?Q?tzRHuP8JCnk0EgJ1Fi37/MIhaF35l8yAxcarD24XISNeY7Lu9R9Cl9n5SOzU?=
 =?us-ascii?Q?1zXCO75ILfbWUCTDHBlsjER0IdTcZKoqPr+j3ncK+4DJQczN0AEZst7c+3HJ?=
 =?us-ascii?Q?SyRQFz1RoH6BOxLeMqFyVDC8bJ2bzyGp4NfRDc4+/WxsKeG+xWnCpEXFV6gN?=
 =?us-ascii?Q?y5ZG1KBXKF/BsnEm4f6vly3+PG/fmlZhwC1wHEDlDJhCxKPzErdqCMHKbhBz?=
 =?us-ascii?Q?1GXZMLADvlNkW9xk7kxRtSbAyDq/BlOF5dSSjqR3RvFNVVULeYTMT5a5mIje?=
 =?us-ascii?Q?7vUhZb6F+BQbhPOnN6uJZNIAVVB8sNZt/+AIRfKyENlYFgO3zD6HGtWmxr66?=
 =?us-ascii?Q?Pt16e9VMlqrIePQAFzyOwYxKOYM//HSvNLZYTAm6NJ4L0PF83dqnE1XmZdr7?=
 =?us-ascii?Q?J4XmCZM6wdiSZOpMlcmLQKXgpLUwqqkx95ijKQJR8GtLbz51bK6EGgkS8U+8?=
 =?us-ascii?Q?lpzOXQA+Co3Ak/IemDJAv1QtB1vVLzw4VEABRBv3Qnab3MqH7W1dyNYxwEJD?=
 =?us-ascii?Q?aoAYLNMU204z47s7IHc4cSo+YwMLXnIbLByD7lVK71EBYQiGwIyXD83HZlri?=
 =?us-ascii?Q?Tn1ToKWDnFNITtYRr8hVU064B9k1pyWDLDRwXnip+raWW2RUMjMZeMVbmg5w?=
 =?us-ascii?Q?4jn+fNrcgR4myxsKK4JXSfDmFgb2kBtyb4nP516stRdAJ8j0KppgxF83i0Zx?=
 =?us-ascii?Q?DQn6HS8quGY9Y/6LnFg0NGJ+PFAp09bMFnIGuRhXaPZTdo2Qsvh1FCRIl9L/?=
 =?us-ascii?Q?kkFTfeB20VGgO/aXri1o18fJpbMr9RQdm65Nm89LmvgEdfZGGiRjJCtjObJU?=
 =?us-ascii?Q?YV381C29eEDwLCgImjgh/lbzCQhhdvQI3aiQqZc9qceW6sDRind9gb3C4PuI?=
 =?us-ascii?Q?ULiU50ZEZb7hfOz08HqxTwp2QdwgU9NV5SEXtJ99m9MbKJRiwHzbM27JKd1d?=
 =?us-ascii?Q?id4hd8jiDKsmAP9Mh0q475pn6ZDPk4OqIpT0YrR2n1W5/jZ3qw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BGmgipxLfqAAA+t9fJ/B0qa2fx4BJH6dP/ZfVLwYoeF/Cp5pSDUrHcwrNTs1?=
 =?us-ascii?Q?p3epdjUK4GWWBmBimNE2LhC2Z4fGmQ/ddLg9Hc+YbgKG2FM1D6VQy3r7whaC?=
 =?us-ascii?Q?rH0L9bnN0upHXwr2/zXKcrf0O3TTaVv56UFmSKdUu4osZrLT5TBP6YQvCfUF?=
 =?us-ascii?Q?5ffM3c60OYKwlbZP7b4q49NQ4dulVItF+RcrYno1u/SxtRMTN7/cbt40fMkA?=
 =?us-ascii?Q?xr2Em4grHoNmtmj/jPqJomwGlrWEpTzymt2aQb4YfYPo12kxtyR52D6FGZJg?=
 =?us-ascii?Q?zBLrPbT9aFiYffByGvR3cX/Q//exV7PjbJCuLVYNQPYE7qOYngY6kotYwzYj?=
 =?us-ascii?Q?q+Im5gPW7nvWhs+peSojxA3HObeNpEX+L1Ht1dExPyIutFgl49wimNUHvocN?=
 =?us-ascii?Q?jt/eW3XM8/hq0yOTtvzuTFBkz0HdhWr9IR/4N9LPaLGKQku676rCix+RMd/2?=
 =?us-ascii?Q?2wK4CDKwqc5VJOH0ToPMKS3UEbhd3eUjTUtbxb21eZ6s5+aX1JsAbXVSZZqo?=
 =?us-ascii?Q?qTR1eZK65kHmJLaMd7EfVnC+peZ3Gudrr9lM3QetMlUsTXux7WyLZRUMspYs?=
 =?us-ascii?Q?sPH8EAPSuEnPd9fwpgxjL0IaWTmq85Qg8haish99N/2mWP4vRbyDmouoQz3f?=
 =?us-ascii?Q?1tIFfIpBrnNpQn8LNSUh6lIVAc/WTljGrkfD+dctekDr5ND6yuj6z9ieNHLr?=
 =?us-ascii?Q?6sBz0Oojr/dDxQBK7vDVXjxN13U7vz/3FvdUvkpuLYn5wiZJP4f8CyH5dJ9B?=
 =?us-ascii?Q?0/lBgB4MHMVFV9EYc8nYwN2pwHGSnLjSEjjoykNhiU2SF9+E3S1gwZ1okm0P?=
 =?us-ascii?Q?/RbRV5P2iUCXx7dbSda2EKy2wvYNezL38N/6raorriGhDy1hSwHj8zlL3U8O?=
 =?us-ascii?Q?o+D2zpT3H6+n7i7kH61sCkts8hR0fA5yy4g8Sfg9dtZID07X5AhzjY1hgcEL?=
 =?us-ascii?Q?PsBt2pzeCQQeLz3Q1D3iR6UQURVW75OBbxJnaOdMZgwwamCgE8h5uqj1GF5F?=
 =?us-ascii?Q?O2L4fWG2rUxDENl8sd2G+Fg+5LiVcSS3ssbCv+u/UthE144ed/vBQbrsoJ8P?=
 =?us-ascii?Q?+Wy4M5NY6qWxyXwSOarIqmqcI55M88pJl6XXrnd3ra5dPe+3jhk8KN0pZ059?=
 =?us-ascii?Q?lPm00eH7y6wId1VlHtf1k8CBrcyO4uOxk+F666vHYLAAmeCkujI3NIGM785w?=
 =?us-ascii?Q?wofwO8weaB6imILsJMziKSmjqcSgOZcgSQQpXvTrtS9IuH3gPuj7orto13I7?=
 =?us-ascii?Q?rUb4kKJvX3Wjq6yq4B0yntcZnZ5RJNWXM82UQz+CBWeNWJ9qU9GDdVxJqad7?=
 =?us-ascii?Q?zY/cLbBu7s6Hg4rlj+hHLtQiE1SKGjt4AAbLK6O3WLjwQBdZOaRJTFYdMIEV?=
 =?us-ascii?Q?oKvwmmUzgtSEXliW9BCAQ9ASEEeS8IYse+nCKCxGKuPlR4DO7/Qh1YCDMZVo?=
 =?us-ascii?Q?4q4MADuHnBkONZjQljYqhAUa/NtJ5nfAJckZBbEa57yd9RwUuiGqKn+/4vgT?=
 =?us-ascii?Q?WF6Q+YtzXIX/o455JXF+NowRGdvvKt04nTD5g0DxdPg3jw41Jc402qAbVQLD?=
 =?us-ascii?Q?Af8OeCx4dtptqQeXjTEyBicTrkjopRfpslNExOmCYXCIAxC5qS/dCop1VEq7?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c9d641-0c00-47ce-825b-08dcc00326f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 03:58:15.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ua/y4N3PN1R6abInlMlQz28GPwkcV7AbGYncaVFpmlQS0UXL+eUlBc+6S6hUOcM+KBcvX8gP69ecrqNIx2R3jvbRGB5tHd/MiEqJlfh4obG4GHiIZnFFFB5bZFuqGtE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, July 2, 2024 7:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next 4/7] ice: Cache perout/extt=
s requests and check flags
>
> Cache original PTP GPIO requests instead of saving each parameter in inte=
rnal structures for periodic output or external timestamp request.
>
> Factor out all periodic output register writes from ice_ptp_cfg_clkout to=
 a separate function to improve readability.
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Fixed unresolved merge conflict
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 354 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |  27 +-
>  .../net/ethernet/intel/ice/ice_ptp_consts.h   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  27 +-
>  4 files changed, 213 insertions(+), 197 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

