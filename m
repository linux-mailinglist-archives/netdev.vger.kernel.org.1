Return-Path: <netdev+bounces-117752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45594F14B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FF51C22104
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE517E8E5;
	Mon, 12 Aug 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bVOYa27l";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4wnUV/TL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63317BB35;
	Mon, 12 Aug 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475288; cv=fail; b=fDZIVW5jkZk/P1/Tzx6zpGcX1R6tDa4kUmxYsv7opq5LsdKnENhrCedVbzbJ5vzzzPVFcGVf252TJJchFBl+thcLFHUyWc5CmyVseOt3aK9RtYiV4no6GnT5KuFzaOrzKQGXZpCy1yma41DSYl1a3V3ES/i4Ku0rZMDYBIicrY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475288; c=relaxed/simple;
	bh=arSvAWSePKrh1JFA1dzClbRabU9NNZZUzvX/kQ7SMmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jhv9f8AftoFVrj1qUFaZVo7qlPJsz4qKVXvvzSMwqKHOxLmpVUs6ub1bSMZG4Auz+dkRok67gLfplQsJGGz6pq+Vb3q/Ncoirr+JXe/eP8nkRsf2XbviTaDQBAe8E5VhAvb+KYBv0+FsHH83Gg3KsFaWgQJdZ6JwxYVwLAPsJaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bVOYa27l; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4wnUV/TL; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723475286; x=1755011286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=arSvAWSePKrh1JFA1dzClbRabU9NNZZUzvX/kQ7SMmQ=;
  b=bVOYa27leX0ig6duk0lyCoEEjpagtiwaG3yBrMdk2onXg/AuXqW2ALf8
   68yQfJe7kf5b9JXJKGcJZKVE3WxrqSdX+W1jauORJM72JJvcEMcWtLYQK
   nUYXzoPTsCLZOSXXHjZ2yriwtLxX5HFmjx2ZBuQ+veMXJLvJdbGiD58AE
   uxLX30s7WGzaPsL0GkCuWGi5w7ibF2LdI+MegzUK+tKkpFxSqxy8l3HOU
   tUYy00AdqxqyTR6zSvsHWB89aWn0ftiCxpmz7XxX/N2Dd4Yb5kRvuOhae
   odR3k3V/wHzFwmuM2aSySQPxP6fjDIXkMw2Mq6FnS2ZiisWujhVERjlH1
   A==;
X-CSE-ConnectionGUID: Yqm9+/dqSveNZzhxQc9rIg==
X-CSE-MsgGUID: bcg78O6VSEW3bfo86Con7A==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="261303182"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 08:08:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 08:07:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 08:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNcYLKjXMUsvdbyKxjgVnOPI34AF5/ZxQQHF1imWWj0IOHjEwZr9js3owga8tD1g31oxuRspnX/0oZcqz6/fgVZb7cQp3rVDZ8YlInD7O3z0InAK0g6zFZaV+q487+GVGLECalT6THaZGUodpIi/hC97C8mVb2sYm0Fvw+t4iHPVXUjAjqRfh1zLP2GBsbeS1Pkpi0NREfbqE3mtr8klftd8zD5VHcI563BPeq27xbxBG2Zw0qyFumI7A4Hg+SssUrFUZvTMSZY+NkTuV8BXUr6oSIGlDeWwJBo34LISYwB+5XC2XT3yaKSbK2JZMKp9tc0Nv4wkBQHtwH7Rew1Lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trvDTws2Wp+j4wdcjhg3Gp/40KUYG2NWPAZ0b8OCuoI=;
 b=Mc511pGAdYK79g2T9b/UHVNBwaE/M9hoj5HSp2P9KLxeueg6bdVF7uPH3qg16yEZIvF52p/QvdERNRe5h3SSftKlB+m/iCPXwAsYcQ482/m1IGtX1c08Ntf6WEnUKB5NpDeDsPvJ45GnS3N/hErvOj9bpuGD7Wu0z+xFj6YE6uP6Mqn39P/JsjgAvP1Ze0TcVs2UuG2SGbjGNleyYV9Km3GVy0NYWp60fNBBIQCjREmdpZOhETz5lHk3omcoD/GvxPQ6/ZPOAWrlwv1w8LBmP34k2HgWt5hdH3cter3XUaedC/jumovfvNBnXvPmfmDvvMKyFNa3DERgHoeZgl/ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trvDTws2Wp+j4wdcjhg3Gp/40KUYG2NWPAZ0b8OCuoI=;
 b=4wnUV/TLV8VeWTRUgMQPoUPjy3RWRz1WydBQtpj08MSwk5Rj5PiYYEa69Asu2QJqVPLUOchcetThV9wSYno5PMl05LtScUEc4i/o4JaKgELQdeyU4mn6/hx4QsZjk9iRw1XXTMTUy0NJlqMx5gVV/4AKZXTcSu3YDxfzzvsKZOakB3gm+2sYyWJqsxBGD2Tobd9YfAc3WpJrnVuJO6gg2Sc2oEyNwqZp/TarQkzZHiDWkNJN8cSAH0PmZeP/HQDaZVm/3mRrrb+e3UxMfD+qA7IPQUu5Dhs2jdscvke4Y4+11J0oAlY9O5LO6Sl/B4/xj4Tp7xTZmFnGhjdzYYEZ+w==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 12 Aug
 2024 15:07:53 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.7828.031; Mon, 12 Aug 2024
 15:07:53 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <linux@armlinux.org.uk>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Adds support for LAN887x
 phy
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Thread-Index: AQHa6Yq368FyCB2W40W0fvYzUDQ2srIdRxmAgAGGJOCAAB22AIAE04yw
Date: Mon, 12 Aug 2024 15:07:53 +0000
Message-ID: <CO1PR11MB47718C1F661DE9CD19D98432E2852@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
 <ZrS3m/Ah8Rx7tT6H@shell.armlinux.org.uk>
 <CO1PR11MB4771395A5D050DC1662E3C08E2BA2@CO1PR11MB4771.namprd11.prod.outlook.com>
 <ff514ba1-61c1-45ff-a3bd-c5ca1f8b744d@lunn.ch>
In-Reply-To: <ff514ba1-61c1-45ff-a3bd-c5ca1f8b744d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|CY5PR11MB6511:EE_
x-ms-office365-filtering-correlation-id: 53e6603e-1c8a-4c37-3454-08dcbae08a73
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BQQstP+wpBQFRMoavevM45FPLYRu1ZTFZ8YHu2068s2Y9F5qeETst4iWi5yH?=
 =?us-ascii?Q?aXCg5hwJlMW14hkmSkdbKfEaQTT5ON3LmkjQ0OgEqxao5vuD7FXDBuhsopPF?=
 =?us-ascii?Q?gs8o843Yb1JiG7UkYPfGsZbkFvaMyI36jtPNh5NnUTKxyWP/YS+eAZzyTwXD?=
 =?us-ascii?Q?h+gsfS7f8Yaps1QIbbhxZmSJK8iCicMsIoLRztu+llCgqS7jQQApYykPIj8v?=
 =?us-ascii?Q?KOoS+aJoOH7xUR3O/zmhQEhsdps4LpX2ttq0lDyKwUY3oIgPgwGNzHBESKOI?=
 =?us-ascii?Q?qybAZ0UNuFrqmVnL5W5/ufCggGC0DeSxljJtPpnZfFS93komJGZPgRcnjZ5H?=
 =?us-ascii?Q?gHdejtvVTMAZZmdhDD9oIESOZDQ9763afpOL/WsWb88l5f/4g5o/OWIHx5EM?=
 =?us-ascii?Q?xQD+QbzXGUQk7Z2RwyMyUNxklX0NFfcHrwbA5Q/X1Cf9aVct+rnF+YFfMXEH?=
 =?us-ascii?Q?3hlXzMZdGhrdivlkrzd8MbWsKppNiPxKbnUr9sfL86Cym6XQxqK09Gd3XEJ+?=
 =?us-ascii?Q?LwXFlSBqeNiVEsxYJ3QioTH4GtclfDKncwof8+VXNd6DZHMP/jZNiweQso/h?=
 =?us-ascii?Q?fUP3z3vb4tSWHz+5elkskyiTyrZkLjItD4rOhdhgjgG35IaISdBztH+A5FLB?=
 =?us-ascii?Q?oR3wQJFafKH0kDMZ2hE9vZIC019r81tOofhnSiehu/+IJhBAhaPqISTOPNLC?=
 =?us-ascii?Q?zRsYjodP9mpQ39337bFoFPtSjvsfEyifDa/Hovb0S0U7TmJLLfclkxhD8bcs?=
 =?us-ascii?Q?qznvbdl+M0miuQOhJqM5dAWsDAbciU+6/WVb+SNqlT2gF9X859sktjS1C1Yl?=
 =?us-ascii?Q?NZHzvqoBODdOfWlLAxZob7xx4Mkg22WGh88OtAFl+DsHFqaTgRtz77ySVq2+?=
 =?us-ascii?Q?bD1g3vCI7+R0K1xZ4sj96mgNvksmuEE7idbbZprjcNjUXgRaJJgzEkL9BVA4?=
 =?us-ascii?Q?9WsnLNb/6ZvqQwGPjEEPGWufloJ6BDUZu2DTkbsY/WcOChL3+BOR7oBTNclu?=
 =?us-ascii?Q?GseCdpYXNJ4+b468vOE8DzPr4gxyw+YpQxIhxksZ9ZU1C/DWRv3aFnRefN6j?=
 =?us-ascii?Q?yEauzFC5Q8kFQOT2YnQqWg859zlal73bgaO3KsooxRoSHTYUd6f1GtWxtRzW?=
 =?us-ascii?Q?Yqi87DjihMxQ0sTGtyLraYe781RENqHuA807AyT+dnOK7/+FHdLvt7Rdt3jx?=
 =?us-ascii?Q?SzMouwK5jB/EFb6HM5PYCAtUmosdQi1YTC7GRZfpY04dbGFZlWwHSa4XDmfO?=
 =?us-ascii?Q?IdgXumAiX1w+Z4BclFwwQVIr4mdD8v8eJZ83i2gG7ASFepHz9e2ERzZUXR1H?=
 =?us-ascii?Q?GizD7Xba2t3kqCbvhV5FqCETS3YUt2pMweFj3g/2KriYuv+IQlyrtilmm//W?=
 =?us-ascii?Q?mkvY/DI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gwt/HrvrTZik0p0j6ddtFHm2ghR3PpOacjBmcMu3moAt0tts7pZRUEqlycna?=
 =?us-ascii?Q?c1hDyRS2rUFLWiGV4htEEtt60550IYLVoOgFkCykZSTvuyKEoAEwr9rwKOZg?=
 =?us-ascii?Q?03QbupiFGocWvUPwWb+CIRZSYMW0n961QFduAv0+WqhKcgOR8nQD6ovBhHvI?=
 =?us-ascii?Q?whdoBKjP3CbL61AYxceNX0Kkb1B9UsjMo3S+P2g86dsYZVQMMNK32tMua9BS?=
 =?us-ascii?Q?Nrvn/bq0/3/hpiv6tC7Vtu0/rHDmvA5gNnhktKuUqLlUfYv7QyAPekgu3jps?=
 =?us-ascii?Q?kWxr6jxllztjQj0f/ULlF4xh7JhWSwDztrAk2F10Wj+VyfHphJcr6iKlvoks?=
 =?us-ascii?Q?Z1+qk+pplnuyu2q+AQPR9XqTpY0bKcYIxdAyz6OFVMSDMZUfgEiyblgAAzLZ?=
 =?us-ascii?Q?Gn/mNQF2hbi7yjwf6+1u/cW2FU6yb5wpi5gadeIJXfPgcUB0iykDLQXMXqpY?=
 =?us-ascii?Q?yCvlxcvwk2+olaYz7PgjlkL5sxrM+pTRIE9qnCzaJLZPHi2ZgIVkTUORSXuN?=
 =?us-ascii?Q?y/3kORL7J3WfpNZZLlqT/FZHeV040T6lxG+m8B6Lp3mMVGQFf0KWtYvgRYbA?=
 =?us-ascii?Q?jzvpMHKo2ahVLMDEwO9PcKyFmmqi43E0QfxGLiT6ZICVukJtW20pcTCXmklO?=
 =?us-ascii?Q?KuZcp4cR6tpSu+EITnmFeuiNDYa1f5DQxFjiSez4BVLPybCQB5pslLCkyR5O?=
 =?us-ascii?Q?3t/XtsHFtX3fYDiVAnLQNIlm9qA7vWhdYG/jkjGstTEynlQLhn874OUBX/mf?=
 =?us-ascii?Q?gJk0eKZWOc93PWhvJNE2avAwA23nlbgu1ChrbhiXmfVXHS4p5I8t9df+B5pt?=
 =?us-ascii?Q?IcQqu0K2uhsxt28aQjw5hk9uFTuw8/CdZpTwDVTtxZ4BLBg+XPeAoe51xlzX?=
 =?us-ascii?Q?L1jZ7JKV0GmbaBpo5MAI8BTpYHB7TU7EIeNtWzeSXYchr6/jNScQBftnXPCH?=
 =?us-ascii?Q?otIDgNbr76DGuD4mwrJpvWELH03ZEvQjpERPb4tF5u8e3uPp247PEq7R29AG?=
 =?us-ascii?Q?dDBn7COiNUaV0mCY7MnKM7UR08mfDmcqQ3PJbcU5GeC4/tjw5xd5qVLfqFTN?=
 =?us-ascii?Q?qzUeYs6W2m5brAj8oMpDve+KmGsCwe6tr21ZO8IJt6UKhU8FEwlgjiGXHZaS?=
 =?us-ascii?Q?hMegz+lW5Llxnp8AViaXSB0EfIFzLepb5rYpml3YT608kbSaQBXzgAFOGfEM?=
 =?us-ascii?Q?DkGhpZpX4meELFIZpWbXKXqCEl9FuDXW0ZbVXy5UQe/YESQRO5D5R3VEKXC0?=
 =?us-ascii?Q?9UgWsxcN4p9NQ3odAtdlXvzG1SygOLMBhteQrd9nA/hUbPv49X1FKLiNF9wK?=
 =?us-ascii?Q?eaTeM2pEh0N0I0SxTRrfYzsy82hmGO1/Oah2vNe6g5mEO1affB1GWa1mlIF7?=
 =?us-ascii?Q?8Hp2c/IYZEz3b/GQkyQRLoDLqx8DxzL/znrto48212NQqd0A+9EOau7zSO5B?=
 =?us-ascii?Q?6RwCnaWKTSabQK+bXbT+UF4Q6MS75c75HgUj7xypHIur+Fhu1DMr9HUh8h4n?=
 =?us-ascii?Q?BAUPTfl878cKQidfPOTRpUGfHHJIvmeqEF3KW3vGKVtj2QyuLADrBphz6aax?=
 =?us-ascii?Q?zGb/pJETJVxTQVpjhYGECnuPT4RpGal4U5mbF0Iv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e6603e-1c8a-4c37-3454-08dcbae08a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 15:07:53.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HR744Lw5eGfy6r6b/rAJevm4WbHMSuy4wqiJ90YYMkfyJgjlOCMh4P5urlT9IW26KxrRg2LvCqWhQsxyOmI8jYoeV6y0fGCoyQhgzrK+2G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511

Hi Andrew,

Thanks for review. My reply is inline.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, August 9, 2024 6:51 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: linux@armlinux.org.uk; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
> LAN887x phy
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > On Thu, Aug 08, 2024 at 08:29:16PM +0530, Divya Koppera wrote:
> > > > +static int lan887x_config_init(struct phy_device *phydev) {
> > > > +     /* Disable pause frames */
> > > > +     linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev-
> > > >supported);
> > > > +     /* Disable asym pause */
> > > > +     linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > > > +phydev->supported);
> > >
> > > Why is this here? Pause frames are just like normal ethernet frames,
> > > they only have meaning to the MAC, not to the PHY.
> > >
> > > In any case, by the time the config_init() method has been called,
> > > the higher levels have already looked at phydev->supported and made
> > > decisions on what's there.
> > >
> >
> > We tried to disable this in get_features.
> > These are set again in phy_probe API.
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tr
> > ee/drivers/net/phy/phy_device.c#n3544
> >
> > We will re-look into these settings while submitting auto-negotiation p=
atch
> in future series.
>=20
> Let me see if i understand this correctly. You don't have autoneg at the
> moment. Hence you cannot negotiate pause. PHYLIB is setting pause is
> supported by default. Ethtool then probably suggests pause is supported, =
if
> the MAC you are using is not masking it out.
>=20
> Since pause frames are just regular frames, the PHY should just be passin=
g
> them through. So you should be able to forced pause, rather than autoneg
> pause:
>=20
> ethtool --pause eth42 autoneg off] rx on tx on
>=20
> assuming the MAC supports pause.
>=20
> Does this still work if you clear the PUASE bits from supported as you ar=
e
> doing? Ideally we want to offer force paused configuration if the MAC
> supports it.
>=20

I will recheck and apply in new version.

> > > > +static int lan887x_config_aneg(struct phy_device *phydev) {
> > > > +     int ret;
> > > > +
> > > > +     /* First patch only supports 100Mbps and 1000Mbps force-mode.
> > > > +      * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be adde=
d later.
> > > > +      */
> > > > +     if (phydev->autoneg !=3D AUTONEG_DISABLE) {
> > > > +             /* PHY state is inconsistent due to ANEG Enable set
> > > > +              * so we need to assign ANEG Disable for consistent b=
ehavior
> > > > +              */
> > > > +             phydev->autoneg =3D AUTONEG_DISABLE;
> > >
> > > If you clear phydev->supported's autoneg bit, then phylib ought to
> > > enforce this for you. Please check this rather than adding code to dr=
ivers.
> >
> > Phylib is checking if advertisement is empty or not, but the feature is=
 not
> verified against supported parameter.
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tr
> > ee/drivers/net/phy/phy.c#n1092
> >
> > But in the following statement phylib is updating advertising parameter=
.
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tr
> > ee/drivers/net/phy/phy.c#n1113
> >
> > This is making the feature enabled in driver, the right thing is to fix=
 the
> library.
> > We will fix the phylib in next series.
>=20
> I'm not too surprised you are hitting such issues. Not actually supportin=
g
> autoneg is pretty uncommon, and is not well tested. Thanks for offering t=
o fix
> this up.
>=20
>     Andrew

/Divya

