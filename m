Return-Path: <netdev+bounces-293641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNwfEnxRHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FB61C798
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE114305D5A0
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984043905EA;
	Mon,  1 Jun 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8JV5VjK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E8306B1B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305983; cv=fail; b=DUIoTbQ7EmDZ9/l2OhtLRNIbqUzXv+de/9iZlX2PP9TCrwswEyRXixS5FULmg1HOO9qxVsadONb6ytWLyqUExMiUUd1652uo4E8WVLcfltdtT0Zr7/5JUs7aU/NmX25y2t9t1buceKZLm4+3oEhxjW5Jqzyj8VgvjtFiLZsvUmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305983; c=relaxed/simple;
	bh=7xQceo2CoDNDTpt+h/a2AfA6JqlQuCj+TEiMXQJPnzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DoV736KUmLkEwtAYv3vp+ssz+zdpoyX+Kmv2JuESwKrzEjetO7xiJolf9lgDPN8QA1gdN2Izl0SbR0tNosoJ/IQ4Fbw119o3eO4lFLT5y2SpkDxd6eK0ufI0LC8woOYdvLMpV5SuhWFje/XfXLOZ3dSk1Vz+9OKrysKQ7L3vk/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8JV5VjK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305982; x=1811841982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7xQceo2CoDNDTpt+h/a2AfA6JqlQuCj+TEiMXQJPnzA=;
  b=n8JV5VjKRY60ffwkRk4qT/TvutIO3e+UlMguhrDchxshTr8shJDQcub6
   Bl9ccrIss32pjbUHocw+pPhL9I2RAPEePO/SC2qsmxoFerZr12rEosr4U
   BDZfJhKfmdtrIAm63mjDa43rbmvvDbtl8OsAIzsWl3ihfe4R7iuev+x1B
   9duoUxgl9A6izsZon/77Qd7IFiC3xXhnRVf00tvB0zcZdugqEu8F0FnHw
   qpCGhzgTemxgzd3i5D2twDggG0wV4Z438zQdEd5CMwIs0T8cwPxN9vA2O
   +dRUfrNYbTJaBw//+DHIPRKN5PhaMBHug7Xjvn5FOrBOUcssftFoS3Ii6
   w==;
X-CSE-ConnectionGUID: 0Ka4dJRbTm2B6kHIdNTe0g==
X-CSE-MsgGUID: j8qm+E5NQP678OjzESoKDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84948838"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84948838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:26:21 -0700
X-CSE-ConnectionGUID: 15KHqWYjSxyg0whF54CcYw==
X-CSE-MsgGUID: rmWr6rvATle+R2/axDqiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243621676"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:26:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:26:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:26:21 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlflfUQ64PUbGQK1rsvvJaqFyHOKyB3RqYp1UBD19iUgWewo+qm4x4Soq/yyPZGhCL18/gA49diZts8cFGZsnWOuryZLHJszSysC8of/W05fk3HgF8k4Wpy2umJo4icwoR1qYNSoHQwBqgXVjkhkiDYC1yy02qZpU+9Lqa7DU7v30aIBYDz3W+6ERk+EKmiqawsvTJ+xdd3OWYRZXtR9LWQJdg4Z89SFyH0iVMgcF1XKFz7Rx2vgfMB0/w+v7Ca1XXLypyuozspYscu7xXd6tqHIAu2VEsr/7EO8VHpfGHVJ8hplfgdjnckqFF7ohlSU7EGRpRIrd4qApSgaI3RJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF3PigWbbIcvglqyCWBSPHW4hmUncarqCaGXea/X5JQ=;
 b=DrJEPTfbQr52RBpWbgv4m6VkZ+m1AA5dQ9xRXXHSK7o+1qvhn7RNkhOH8XcpJmEJWkrJOPYnDzsYc85BhM3Mn3+LmTG03NAH6YVbAPP8Toa3BwJmjo4JffdRXhJHAFAg2GZzC/YYI+SePaJdSaYRsqQOMwlwUGlSov5+NwfiNsWl8Da3LoWY3hwdp48bIvchaJjIeIB7OM3ouCbdWKwLkLjnWL5AUyImHS4TKJ93Ynm5y+NFPExouFRKwRpgLIiVw+t+lN3MJIA/p10MbDxMSEySGQWLl/DPXti5ruwCFKz7LZlZP0CcyoXe9BEk5dDCB9LO+4R94zRhgyxb7lH53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB9462.namprd11.prod.outlook.com (2603:10b6:806:47f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Mon, 1 Jun 2026
 09:26:16 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:26:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: RE: [PATCH net-next v4 2/5] net: wangxun: add Tx timeout process
Thread-Topic: [PATCH net-next v4 2/5] net: wangxun: add Tx timeout process
Thread-Index: AQHc8Ze6jKejoM3zV0yN73DwwyXkm7YpbUGw
Date: Mon, 1 Jun 2026 09:26:16 +0000
Message-ID: <IA3PR11MB8986784612A2A7FC5D4262ECE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-3-jiawenwu@trustnetic.com>
In-Reply-To: <20260601072221.2952-3-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB9462:EE_
x-ms-office365-filtering-correlation-id: 212e6471-7ed9-428d-6e6d-08debfbfd4f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|4143699003|11063799006|5023799004|6133799003|56012099006|38070700021;
x-microsoft-antispam-message-info: b8kqBPGyIS9kR8+loZlz5Ib6fRj0V/UdXM+7yoU+RgIqh9uHDRHla5bnkjbSXYHyPBdSRsScVV6VHYHOL7jSOrraRCjbwRE+b7B+FnsyxyVKiJ4TGmLVztLiuPQIV3APKt/ZpPkfq+Vc8KgEt2bgtsmAIONSXyZLC/yPJCz4GtbPRHW81+DLMYPErgRXVctoSkWBKCBLrQXJ1Ca4DlHB67P5kEzoAyE0zBOCMRL0Hma1SajLh1ydGAighKs3ivJFYfcFYtoyCN27I9J97JedUCUf5ub+pjnmOc9JePM8oOqINgEGlQ8aLd993nHJNGdh51mMbug+LoTT4mnFDLF2HQlSNfzQGdvp51orCL0/zE33txWnXfP1OjuVwWOt34tSu4tsxnPwAHZgbBNT6WVXaR4Pvwr46dcy64cxu3rtc/ygXG8nXP6VU8sNAR80nG46x1i4KZklv2eachbSsRF8w9nJWWIJWxzBVHdFy3Zb94TbIxEhQDcQ8FB93Oih2Oj+PlWbLuxwYwDLd6bIxQxXbbO08llxXdzj88/KSenV9tG9ccOiu8Q7TRmdUbnpzEpfEsWszYIE7feUpSgF5VJ/n9ILiHIxFgrA//ESxQ7YhImA7oTY+tOzTIJThU2kcgkRmBY8Xry3VCgo67/E2eBuxEE3dn1DW84u22wxnH+/L6uJZHLNWhWuMyBIO7EZIPKQRkgRqvYHhtTnuSwM7JxaAQXAr/x+NftDSB2jYMUwApa+Ju28DFXdTj+22dAO1dXi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(6133799003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PhmuVu3477ACuab0GWaXvYzGIEnPazP3sXV7ij1QJcpYP8ZGQtLqEadpPB?=
 =?iso-8859-1?Q?4WnsLBiWLLavoIjLeekz2r8jbt26lVACK9S6pb9NWA/ejVlfp9synvACgr?=
 =?iso-8859-1?Q?8uuim33Ycifi62fp4wtPlfUM99QK3huFXhNYm/1n2JSRk3sVwqBreoIS9o?=
 =?iso-8859-1?Q?wp7sDaRuazMi7blpzI5fTHWa8kWrvGwHJKZShw0kV7ILZE+Kx+vE7xP3ca?=
 =?iso-8859-1?Q?ku0TrdIV7LTuAmFN/6F29RCgPbLf/93fD7tG3FngJ1BEhcKYmm/icesCnY?=
 =?iso-8859-1?Q?ysRp/+UgBmjaiCiXUd8WToTn6UpQM/Y4kUtLplgtr6KhXWH8P3sKHLg/ag?=
 =?iso-8859-1?Q?tx/drHfupvuD0X9TOYb3Lg76Hb++M1nSBZ54s41giIIw8F/dxPPEnkCOX2?=
 =?iso-8859-1?Q?7hAFPM+xtcOFVC2d1+eG23CXgv1CYhkZNEReLQcwgraa/yGA6O5BrwInMp?=
 =?iso-8859-1?Q?232IUt/du1Spk3ktGe7EYQe8kwgT9g6sFW1YZraUwwzk3A0iJydcLoJJAL?=
 =?iso-8859-1?Q?sNZ7BiVH9B04KYlA5xiySVeT+If8zfzgsp39l7/pVgXmtHtcIu0ph5XcE2?=
 =?iso-8859-1?Q?5cvPdMVYXnmiql3eGwn3ToXyd5VH6L3psUZVmicG+hmSzLlnYMJn8szped?=
 =?iso-8859-1?Q?mdTtue2ht6NGN3tPJkIjPy17caXcZBzK2l6kBttwCyO19miKpo32ysUB/x?=
 =?iso-8859-1?Q?uoCfmnZNBUjfMTC/DARRG8U2sF6KjP8dBiPQwyM6yvJavah5YNx1+oTLNA?=
 =?iso-8859-1?Q?iJ/EgO1dCNUsAT/I4QvV1HVFuj9TcepXxiHqjqlhUGeiDd0c0jzZp/Y/i3?=
 =?iso-8859-1?Q?RhEudbcIzQTp8tWSFktJj/7R0Oo1FBL9Qt4K6iLJqNCJ4QjHYrP4NjQbtZ?=
 =?iso-8859-1?Q?6x5g/weslxntixWqCR9iFdeaCQsdj1RvhOr+Ccr7biteBXy11JeDf0/+yl?=
 =?iso-8859-1?Q?/iOgP2G929NBe6Gm7LJBLdJQHULs5fVSKmIx7x/9l2RfKPhDWr2DwjZ4r8?=
 =?iso-8859-1?Q?ZzwE3hdGxXoKEsi2YbwedaCtSn2xqLUO17jNl1tcF9VTHevDtvznocqoDm?=
 =?iso-8859-1?Q?5VXyiGd2bS2Enhgb0dU15fGlmsIJ+F8wKDoB4I6LKKuc6nqa92V62wve2S?=
 =?iso-8859-1?Q?camy0oPrQUAnHgxfFhajgqfWf8Sze/mu6FDQg0HBa37psHG44jvVC9xp1F?=
 =?iso-8859-1?Q?nvTDTSZJkssqvFDKtSjwBTC1q6iiuw7jGkc86OuZgOiWu0TLRneIUgcAuB?=
 =?iso-8859-1?Q?eNVslwhX2yyiIfyR5NshM95wXn4WnTVtAJeA139Nbv6xTOJxrsvKVKIBlN?=
 =?iso-8859-1?Q?Ur4wTfPkOSfnyS/yCQKVyyEvuA+wNxUaX58gyoBSSrTuwN6Dsr9iF4/b/W?=
 =?iso-8859-1?Q?mafHQEiLSCyc5qDfL4J9frzBnxKd3U7lUN/FEFHz3V/ALq1ZUvLlhGNX3d?=
 =?iso-8859-1?Q?GNo6dEU5cabyQt0014RUWOWAE+loiXixkA0trRt5+edgNrhDnQVL/bxXI/?=
 =?iso-8859-1?Q?ZaGQ0AjD8obodiOnDDrDso5f75rY1ic+/pmuCNk71YKQcIPjgCMTdy1QBu?=
 =?iso-8859-1?Q?sitMHsgLVvYOdPBBUFZg1Ze7rX7ZVJ4PxJZ9gWIku1Bmfc31hIhKdYAWXf?=
 =?iso-8859-1?Q?in7x1SjEifZ2hd5Cu9kI6EZl1Sk+DLj4zimHr+TLQMQX/lCo1hD7gbpiZd?=
 =?iso-8859-1?Q?pCVJMs8DrQ6pr7jjb7/jeqoP2ZEa0+Bih5BEwtYOJrr9CHkWDl6Dr2JfZe?=
 =?iso-8859-1?Q?/RDka5WuJWmAQgsSUh4KNQQBb6zthlrVnAl9pyfQ0xYOPEaSp/BZKhCsxY?=
 =?iso-8859-1?Q?uQh2zelkmht0pKT/aFjWLT0VAYZH5q0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oIaleY9trWAizLyMUEzDH+bz/FXTvfpf7lX3pW9BN7PmTdzmJgCdAUuRnTG/ilTpB0d04GT0aez1ER7QcnFenMoM7Ipv/VX/42KB04SSM/Me23n9tHCM3EY5lLPZ26ZhTT0NjRIrdlQlTerebUqPXkrC61/YkH10HunA4Avv2O/rlxNvmBL2DB4AE0LZE08GYIk6ToI84X0/BHnu3GAoCX6kh2vPwsaC0xTMMOFHUL8JGX3Et7Pwz0pDI0kOnV6TPET7chYGhHyWRFmtewH693pNzvnELi+uNW2L01mzrM77vxMaCFdF3BHCALr2CnjX9s6yhD2P9bj5+6FJ1hPQhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212e6471-7ed9-428d-6e6d-08debfbfd4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:26:16.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgDdmGPSDeXJSYEp9/aQ881Gdnmu1Ilz9wSfcYeSYlwmCmDHEc4js0ac6ZehapUpBvnnvciDIomrvgsMsi7mN8sn378eLHrpXw/6Z6Cv458=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9462
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293641-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CE2FB61C798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, June 1, 2026 9:22 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Kees Cook <kees@kernel.org>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Ingo Molnar <mingo@kernel.org>; Joe Damato
> <joe@dama.to>; Breno Leitao <leitao@debian.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; Johannes Berg
> <johannes@sipsolutions.net>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next v4 2/5] net: wangxun: add Tx timeout process
>=20
> Implement .ndo_tx_timeout to handle Tx side timeout event. When a Tx
> timeout event occur, it will trigger driver into reset process.
>=20
> The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It
> will be cleared if a pause frame is received to avoid false hang
> detection caused by pause frames.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 170
> ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  37 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  19 +-
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  14 ++
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  14 ++
>  8 files changed, 284 insertions(+), 5 deletions(-)  create mode
> 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile
> b/drivers/net/ethernet/wangxun/libwx/Makefile
> index a71b0ad77de3..c8724bb129aa 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,5 +4,5 @@
>=20
>  obj-$(CONFIG_LIBWX) +=3D libwx.o
>=20
> -libwx-objs :=3D wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o
> wx_sriov.o
> +libwx-objs :=3D wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o
> +wx_sriov.o wx_err.o
>  libwx-objs +=3D wx_vf.o wx_vf_lib.o wx_vf_common.o diff --git
> a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> new file mode 100644
> index 000000000000..982a438d009e
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
> +/* Copyright (c) 1999 - 2026 Intel Corporation. */
> +

...


Two functions with the same wx_check_tx_hang() name is not good, at least p=
roblems with greps and ctags.

> +static void wx_check_tx_hang(struct wx *wx) {
> +	int i;
> +
> +	/* If we're down or resetting, just bail */
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +
> +	/* Force detection of hung controller */
> +	if (netif_carrier_ok(wx->netdev)) {
> +		for (i =3D 0; i < wx->num_tx_queues; i++)
> +			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]-
> >state);
> +	}
> +}
> +
> +void wx_check_tx_hang_subtask(struct wx *wx) {
> +	wx_watchdog_flush_tx(wx);
> +	wx_check_tx_hang(wx);
> +}
> +EXPORT_SYMBOL(wx_check_tx_hang_subtask);
> +

...

>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index d042567b8128..da4d9e229c9e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -14,6 +14,7 @@
>=20
>  #include "wx_type.h"
>  #include "wx_lib.h"

...

Two functions with the same wx_check_tx_hang() name is not good, at least p=
roblems with greps and ctags.

> +static bool wx_check_tx_hang(struct wx_ring *ring) {
> +	u32 tx_done_old =3D ring->tx_stats.tx_done_old;
> +	u32 tx_pending =3D wx_get_tx_pending(ring);
> +	u32 tx_done =3D ring->stats.packets;
> +
> +	if (!test_and_clear_bit(WX_TX_DETECT_HANG, ring->state))
> +		return false;
> +
> +	if (tx_done_old =3D=3D tx_done && tx_pending)
> +		/* make sure it is true for two checks in a row */
> +		return test_and_set_bit(WX_HANG_CHECK_ARMED, ring-
> >state);
> +
> +	/* update completed stats and continue */
> +	ring->tx_stats.tx_done_old =3D tx_done;
> +	/* reset the countdown */
> +	clear_bit(WX_HANG_CHECK_ARMED, ring->state);
> +
> +	return false;
> +}
> +

...

>=20
>  	txgbe_remove_phy(txgbe);
>  	wx_free_isb_resources(wx);
> --
> 2.51.0


