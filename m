Return-Path: <netdev+bounces-219463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DEB4165D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831C63ADB71
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A22D7DD7;
	Wed,  3 Sep 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfZ8hbWb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0946253359
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884304; cv=fail; b=jmneqd0laB7bLF0dV6yHtHLIFkdxdiMTUSV82NtlNngtFlBcNUQw2hNswIzgciNvxONwzwsuB8CKgaGuGV22PvRzqQi2fi5kC6nS2VQGtxXK7QYZ8Rpba7qUioRCN5ajK3G25TMSrtI1iKSqojPlWM1+Bf6ImUJFvI44LFJRiAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884304; c=relaxed/simple;
	bh=mgVmgMDaAiFK7A3Sz9L2V/fW/85V/MpDzz0TwYL13I8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCxWgcozl9Qlris3vOhA7Jq3qNAj4j6sggUeOdCA6jg/u0nHlLNKqkl8vEphr35/eIu82AXnYNAyf7unaXnoeZnxEa95YNpqvFIo8ZrY9tOCzbS0rJdnTF85Lxc+IHzFSQhfmFNn5PJZX+i6A7mYTtKiKH65hacAmPv3+lvLmqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfZ8hbWb; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756884303; x=1788420303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mgVmgMDaAiFK7A3Sz9L2V/fW/85V/MpDzz0TwYL13I8=;
  b=WfZ8hbWbspic/FI30LXh5bG0x81TZvEbcqmcThMVPb5AynG2M6OOEYIP
   dahAwyqqee8AXde+AwqZ5vbA5H53wnA+EdL5ubI6xZ9SRY27lRxE/K761
   ngywplvV0l16GH9tZPKdTcVGP416mkLw4ddBBwjVI3QjIVxfI3w8Uxzn9
   rsra2KbrOdTVj5+s0Px/voCj8hdg9agy298FFas90pHRfK7CORk0F9s6s
   N2FR2uHrYi9SPAq1xkow0LFrF3XHYkKdFrkur087pksepI6VcEmLsqL73
   pKT2MxWJoJLV7sduEBtxG8iUyJ5AEH75Hy79lGl96h3o4VD5OeMe8Xqh0
   A==;
X-CSE-ConnectionGUID: aDo2hKiBS7uT+IbOFYxcCA==
X-CSE-MsgGUID: AOZxKRVeRBakksczdT22Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69801410"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69801410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 00:25:01 -0700
X-CSE-ConnectionGUID: oVzCpjRLTwG5c7HudohvtQ==
X-CSE-MsgGUID: hT7f9pSrSDSJehSBlDOfbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176791805"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 00:25:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:25:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 00:25:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.75)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKfUD/65C8ucxzQcCbJpXNv0AUMpUkY1M/Ym5f5EvH5y6UAh9OcrTcwQon9+tz0QH+3AYQ4OOmvZbwgtS5GY0Z7ohJxytdWjz72Bm4J0Ucr49+KWlnwBALFIvIffmeBUPJbJFYis2ejOridRwr3+H/Smws4lshRVa5s6KUh3bAUVSHwRb3SPII+n2zKyPfsKJ3h4zaMAZJR9ccSJOn/34vjtEGbutf29Op1/0sTXHX95CsdU+fiHmuGSYMYe27OD4SWFPrdve1sR/fSDGqjtBhxf0FW7nFGxRYANgTNhSVjJ7IckIvQXQfeEn+b/sKezBRNgaihxeWMqXmIPksOKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqR61djPjY6hBVOcjeOu2t/V5tsqpbq/Hp3EmhuiQtA=;
 b=uA73RfTiUfosfsOZHuXtr0q3U831nusuRaUplEYAdtMq8yXoCU87pHOhNHnviGzClExCu6snY5o10Sl6zxYCAGwiULMmG1dBGEXvM4VvwwiQMLl1gKfWqo5r7jm+YXw4vBOwb1i7nxXAjsSfPoQsD5YTXnMJ40q+Q0k2bq13EojEiCLyI2OlRbGvKTlb2OO3FVB2t7lsIYGvB510H0NZ8bViF9TkyTq/veMiDC5N4FZa0r8l/t6iyU+F5hJTTB6nKO0o3YJCTBOJlQKyqwGy1tN+gYYGETJtVal2I1NGUJ8f62aMGVPRWi9OJTjLCwvI60dxZqLWXDsBj/jQPhoZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 (2603:10b6:518:1::d28) by DS0PR11MB9456.namprd11.prod.outlook.com
 (2603:10b6:8:290::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:24:58 +0000
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480]) by PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480%7]) with mapi id 15.20.9052.021; Wed, 3 Sep 2025
 07:24:58 +0000
From: "Singh, PriyaX" <priyax.singh@intel.com>
To: "intel-wired-lan-bounces@osuosl.org" <intel-wired-lan-bounces@osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] ice: switch to Page
 Pool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/3] ice: switch to Page
 Pool
Thread-Index: AQHcCH01M/icgVqGGkGNwBWqS/igJLR/gCxwgAAOZKCAAab74A==
Date: Wed, 3 Sep 2025 07:24:58 +0000
Message-ID: <PH3PPF67C992ECC632806C8E123CB24D1489101A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-4-michal.kubiak@intel.com>
 <PH0PR11MB50137E847BF9F0BF2FBF127D9606A@PH0PR11MB5013.namprd11.prod.outlook.com>
 <PH3PPF67C992ECC2B85C5436B969773E2759106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
In-Reply-To: <PH3PPF67C992ECC2B85C5436B969773E2759106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF67C992ECC:EE_|DS0PR11MB9456:EE_
x-ms-office365-filtering-correlation-id: 7f82fbf3-23c8-4ca7-d623-08ddeabafd03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nOD0ru9iDLt9sUfUYUQ3KNA0UUvVPL9v6X2zmJTLXl+FiCcIf7ZiMxbJuZlX?=
 =?us-ascii?Q?L4ZhFLHyH9fGUZhUolCUC0uoNb4zBYp42d8zjgMQIeJGibH+hPOhVBkkzjYC?=
 =?us-ascii?Q?2FelP9659Rg1a59QV/MZffyQ//NsVivPTvxY+kIewpVZ15qV8NWkBdv1TFDi?=
 =?us-ascii?Q?hp//TfLit1KDI40uWiRM6MKPJk0Nm32zzlHwdsSy2Urhd6VfO374pbcIgjdw?=
 =?us-ascii?Q?eWi9I6E3ZFJheJOM2oAqab68Q1KQ5t3Y+94uARsIMrrTukDDAof3DXRZNe6L?=
 =?us-ascii?Q?32AF8yikgRsqwN/+k6Ifyrq5sMba4limJcJVngnkS3MJ+RbDGef0/nngdrG0?=
 =?us-ascii?Q?4QclfXB83T97Ds2ipDX+suJ8Vbctl0QxgQuU4VwX7kFr/kn7SaAI+0Sx0efY?=
 =?us-ascii?Q?s9rnaiTN+7gkZniQa16JRHVrvt/x8qO7248x4dcoPhn8evc2D3trdsPg+CJw?=
 =?us-ascii?Q?GBmidN6Tv/ypOxbaWFPP4gaCv/Q1CQQ4El9Ud7FmDs6AeWqZT72c2Aor40gV?=
 =?us-ascii?Q?kshqHNB7BV2DYWTUKiizo3lAMBenYC0bliqA9RrW/UCGbgGQmwAk0wyuOfyE?=
 =?us-ascii?Q?5OGgovL+OIeAJvyRVxN3LdFkjhCRLlY2FsHGkdDHGXrauYMF5+YiYTsMUIoz?=
 =?us-ascii?Q?Te8uKE9knWAAuoPvy3XuytwHhngun6mdacHuDL3LfrqeamGD1tvsUIBl9bk6?=
 =?us-ascii?Q?7e7zNPBvP8uXMl2ncpy5Df20Zm8mb2QMuwaGCByWmj54PoBvRd5a6JJjp0nR?=
 =?us-ascii?Q?xwOXjRnnGSEb7LIJRBttf5SWsYJub7uRBL56DNbd6SsS3Yynr9jXnE72f7nn?=
 =?us-ascii?Q?OjCr5jd1WqCePnk/bwvGE8Edv1+4aMnf1WwsbNfJ1Koty//n2KMnG7uIhxIe?=
 =?us-ascii?Q?i1PSFoKpGq+1WicqTNaHnk9y6MY8G7ExkcoeG5dogkSvc5Nzf+Y03w8MHk0E?=
 =?us-ascii?Q?u1E/g0gYA74c8ns+RGLjgwZttfS/Nfn9Pf0UsAtFZdck6Ga5BdjAQAYVNGI5?=
 =?us-ascii?Q?/mAAT3yjVFGRHb36nRVuAlUtMZakIf0BgS+Z1qCIQtTZ+3MsnTsue6y61QY9?=
 =?us-ascii?Q?ExikJmUbQfZUocWsX+txKB6xLEg2Gj8hUFyjbH/X7hvDpeIRjU2YQSa/Wo0W?=
 =?us-ascii?Q?JGLuiQw21F7N9ehG5ahJfGkhKAarDAbxPp9Cq+XAf5JcUK6FL1EVhHmmkfII?=
 =?us-ascii?Q?Xp5BgOgbpT5zyHYk2TZTx5RjDLdsKYUnde70Mgq2a0oLw+4+tBLPWga5qeIP?=
 =?us-ascii?Q?XVzeORev2epQAEPDcA3XFMwar49gH5S67vGGzHcSlGiSiflKCuiz/OOIltUz?=
 =?us-ascii?Q?TaGse1mc7+XncH5a98zlNEiW+DB1rUBfHwo265nPy+b/0dKf+v8lccp6UESq?=
 =?us-ascii?Q?LoRpe4/zBRxJtrb9XRrJr0lD/cyGzbRIE/du11v84t7C/TBOeeQXBwzn3znG?=
 =?us-ascii?Q?p9h28kqkWtDyfcwsjJDhxp73CzlClsvgqgE3THGpvtqWunXG9XhrMD1WB27N?=
 =?us-ascii?Q?z/rRBJ0cUuc5fsA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF67C992ECC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xIoADo4O7CvTjofHxaR73RLAFOLRAyN6kgK1KXypcCMi0FIAJbn+F68+XV+E?=
 =?us-ascii?Q?l89RvpsWh7R2gh25p5Y/9xA4xQBto6ByFXazA0VQ9Lc/n1/xCR637PGHWwgg?=
 =?us-ascii?Q?Dl6wkTFEX+p4FZpIwRdWxkPZEYp78rlAqNtnCBCGYPRM7a20+VuXJJR2OoW2?=
 =?us-ascii?Q?DaiuJRg/l9jLcX4oXHrsdnrnrgcD8d+/JmDBzY6l2i38oZhtbXHsRsEP2jL0?=
 =?us-ascii?Q?NgZSBHya5W1qIyjn/HyzWxwmEnVtDo6rT8gjsl5MdwaJz3l0aJn76grRk9Vs?=
 =?us-ascii?Q?0tN/mNb+RzV8O+b+/PJGHk1ivNQozsZ0nZGKfURGLWy+YOASgKR43V3BzeAY?=
 =?us-ascii?Q?gyQFLGgcjwdmQfNJ57prEyXTHXswVnoffSOZQ0ZC/9JAPPT5icb+lfDrXQJG?=
 =?us-ascii?Q?WciX2VhO5NrRB0+FN3GVywUwD8RPa2fe2YykDnr8VqykGekj2yO/IsL8D71x?=
 =?us-ascii?Q?gg6oQJfAWWXvTZi0N2CP4f8ImYhXqTUfyc7YtOdnZDLJ/Qo3cgmgDdtyF7gZ?=
 =?us-ascii?Q?A1edqqcsJIJZlH/MDRGqLxRmOJvkXmrTX1N0WWJYQM3H5KWU5/o1ckY9+hUu?=
 =?us-ascii?Q?60DU1dhwIvWN/rCLn8vNrLQKavUusu0VqDZjaS6P+REpwvwJNaSH3r+MgmUu?=
 =?us-ascii?Q?pjfBdo85+/98pkzao5hzospBmJ8o/uzGW4B0XgGzjlI3OHfMAQp0XzYz3mj2?=
 =?us-ascii?Q?BsynYMYNFxI8qHerdqfmobnIUW0nlNSMUhh24P8aLZklgTF+f0pJE1a/RXZr?=
 =?us-ascii?Q?6ONuV3nTLiivJDtQOq0wsuG8CA835bRnMfvRESC0wG0/n4Pikkax74sgDJP+?=
 =?us-ascii?Q?icy9213eo2tHX/pM5peJgLdKLT+t+jI24IFxSzjBx7Q4wU9QVc7evI0SMd5W?=
 =?us-ascii?Q?6GqRl93w8q7Ihk23wERh5jbEDv6i+2Gzx4m6zuh4Zp+1ShZIyyzJfRnG80zU?=
 =?us-ascii?Q?/fZNKw5MofrOQJATae3Wju73ZmjCMAgu2mPFTkNNo1S035FYb0yWOcmwhh11?=
 =?us-ascii?Q?1hcAL8W2XqraVYHUW/hywO7ycNmYFeUvB7a4ZocraKqBK4bXgqd2SapbpIfP?=
 =?us-ascii?Q?l3wR+8J3qOVHcgIJAc95rHGtVLe5wyX6zbBwqIw3ICrv7RKoJKeQ5EvuNR8c?=
 =?us-ascii?Q?CI0Ufg03uz0tyPJXyrT5s2fgbh09hDuX8b3ugbxIMGfsXltITHKf9k7aDSPe?=
 =?us-ascii?Q?Q6Z96VPjm9dgUh3rwlSmiChF1VGHUSxmc5F0dLUidK1yVsOCD/rukuyYOEFy?=
 =?us-ascii?Q?AF+p7inmy5fwblNVSkKd60YmB1DkrHn7f4hqZwrcM9+/EaMU3Ksw5r6QNIyA?=
 =?us-ascii?Q?87pkGuwaDjJQV6a2u4WasmieSzr1+8z6hp1VmXkdhL02/VPkKm/XVoVKTMjI?=
 =?us-ascii?Q?4ft2YHOIXTIvy1QRisVcB4C/oyig8dN0Ey5lM/YRcacCY0bP38cFDNrHjh0J?=
 =?us-ascii?Q?c6XhnUnSu8bYgN7tRmOeC5XRoMs8dqc+dupPY+6ylD3D68YPFlSGnBqS0N6Q?=
 =?us-ascii?Q?SOiaQ5oVsB7kGxSRHhjDMIRHqCQwpknDjpQFdG/SM3uz1FI4U8KK7gcW6u89?=
 =?us-ascii?Q?w61fkZZp21P0VUmPmY/M26gnv9rbniIeXPzGgyXX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF67C992ECC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f82fbf3-23c8-4ca7-d623-08ddeabafd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:24:58.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1TZimsg+QzWtPKISq05znYviSDJE6Mv8MlbmJa9OypYXpdAXmwqVA6psvifATZqWFP0P/DsHaQxTqfnpwgRog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9456
X-OriginatorOrg: intel.com

> This patch completes the transition of the ice driver to use the Page
> Pool and libeth APIs, following the same direction as commit
> 5fa4caff59f2
>  ("iavf: switch to Page Pool"). With the legacy page splitting and
> recycling logic already removed, the driver is now in a clean state to
> adopt the modern memory model.
>=20
> The Page Pool integration simplifies buffer management by offloading
> DMA mapping and recycling to the core infrastructure. This eliminates
> the need for driver-specific handling of headroom, buffer sizing, and
> page order. The libeth helper is used for CPU-side processing, while
> DMA-for-device is handled by the Page Pool core.
>=20
> Additionally, this patch extends the conversion to cover XDP support.
> The driver now uses libeth_xdp helpers for Rx buffer processing, and
> optimizes XDP_TX by skipping per-frame DMA mapping. Instead, all
> buffers are mapped as bi-directional up front, leveraging Page Pool's
> lifecycle management. This significantly reduces overhead in virtualized
> environments.
>=20
> Performance observations:
> - In typical scenarios (netperf, XDP_PASS, XDP_DROP), performance remains
>   on par with the previous implementation.
> - In XDP_TX mode:
>   * With IOMMU enabled, performance improves dramatically - over 5x
>   increase - due to reduced DMA mapping overhead and better memory
> reuse.
>   * With IOMMU disabled, performance remains comparable to the
> previous
>    implementation, with no significant changes observed.
>
> This change is also a step toward a more modular and unified XDP
> implementation across Intel Ethernet drivers, aligning with ongoing
> efforts to consolidate and streamline feature support.
>=20
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
> drivers/net/ethernet/intel/Kconfig            |   1 +
> drivers/net/ethernet/intel/ice/ice_base.c     |  85 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 +-
> drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
> drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
> drivers/net/ethernet/intel/ice/ice_txrx.c     | 443 +++---------------
> drivers/net/ethernet/intel/ice/ice_txrx.h     |  33 +-
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 ++-
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
> drivers/net/ethernet/intel/ice/ice_xsk.c      |  76 +--
> drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
> 11 files changed, 200 insertions(+), 546 deletions(-)

Tested-by: Priya Singh <priyax.singh@intel.com>

