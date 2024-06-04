Return-Path: <netdev+bounces-100511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB88FAF4B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB421F21F2A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB331448C9;
	Tue,  4 Jun 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxbVJXFt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F01448DD;
	Tue,  4 Jun 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494934; cv=fail; b=g8Wlsog0E+0ROck3Ypm5gL1CstUfQzsU/akX39m7ARVROBm8gDascOnpkCw3JFfkczPSlIze7jTxk4aYkUYxKE4mTZIeCtiZSjy4Xs5Fsrw9x6o92s5/AqMQcARA1lP7eBmowZFS9irqwYYAct48ApwbVn/0uyQBb2/XZ9GZni8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494934; c=relaxed/simple;
	bh=3JWc+HAExhwvQ7dphh3AerB8fiERKboTZRx+Yg8EKT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xi+F4SMAVhNYmfLSWdLFrKkJiLl+8bMe+d/XsXhdwc2/XfClg1pTBJd1XIZPF+XnR3NyqTbCPWBlzl0rdiBHSraG+QyxDadd5MV211EdbMW3Yf/oDR+9erjXUNO8VKLExCUEqwHqA/92zWVuECCcDQuav7HyvlB59szHLKLZVCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxbVJXFt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717494932; x=1749030932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3JWc+HAExhwvQ7dphh3AerB8fiERKboTZRx+Yg8EKT0=;
  b=GxbVJXFt2EAj95Vydhihr3vOjUMgn6QPNG/W1NwG+1b54dAw7ynzNFt0
   9VBozeWv99Q6851BtxiaqlxlI+5YwkfgwRyc58EnjnaRVdz7gfqTlLKLP
   i9MEkxKyVogZ71yfY/wEoLI2J3ZQkm2GSUt69OiC7jRInGFPmiQ9Tt6sp
   GjWXihQnbjcrpp/rKIZujiE4c2caJr6FSzqzX8e3TynGDE2gRXn72qH0x
   xpJzHPIFDoufW5tBruW8TqiHrQUj6g4R6in+wPGEeRPwiUhSMJoZYWAtI
   Ly/a7B2MvNTTK6awtz4c7VY3r60wCPUHfUSnGy51d3BuSstp4Kmrmls8i
   Q==;
X-CSE-ConnectionGUID: lEcJh+/8QxifDsnkcaqitw==
X-CSE-MsgGUID: PqoEN981RSquIS1hj6ER7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13980916"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13980916"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:55:32 -0700
X-CSE-ConnectionGUID: 3m3F2sq7T4usE/sOdNh8fw==
X-CSE-MsgGUID: CDOySg4PT3CpKVL3FCiQqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37312910"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 02:55:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 02:55:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 02:55:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 02:55:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 02:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc+z3cpmg1hMcsI+JuTx2ibAuf1JhCtqDJ2wusTEFQlT+kXj+uXKtCnlGx6KPuaZmSAGK9RcWx5Jk1FVgIFd3tNe9nvOezgkqBXLv6jewqDFGZ+5ciNXqlrHc0RwjDI2In7v7AoH4GdjO88iI14Pg7wL1hZigqqUHRkC69M9rAzzB9aaGf8nN0MZZjD9rTlB0BEpkyIeaW5ynZGMH18oiTxq7H+VSY36e884aveRPrmq306Up+RR6b2gzE5swqgJYmQCLi10NeBESOULxdwQgZpdTbnH5Udcrk4zvP2a562qEVZGQjixgIhrSWlu/aB8ZZLY4OVXgbrCYw7ZIEgRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFXdB9/sPfWtisSDx+SKCDjB1UO52QOhR04wLpVGCpY=;
 b=BsyGBuJkgj8lcNCNqpeIFsFnjHXCCOX1HoEAmx2DLVk9SGBIedebylJSR4GMz+vBJGho5n1Ir/czMlqUSCb0Oa7661HCK88fZ8TOOp2sAe8uDQihiykh927MkyKoA6A8jmcTk1tNohuG+0WsKfBIAFwfzVt/mURo+N9SxM6K8uq6MWSdZWXoyWFyiA2cBwJn4A9qgHPesliBhPjxvyEDUsWlD83PMDBlljdhgMbT0pQ8R1bDY8yqtck1NnsR7oQlDPeQMbbTgFIyECtEn57NMT9feJmVr8fVNIeTQ9WTnHf8jDaWgKLLR1pX+XqFKwvZYcGW1B85HbxwXFIC1b+oTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 09:55:27 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:55:27 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Ricky Wu <en-wei.wu@canonical.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"rickywu0421@gmail.com" <rickywu0421@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "Lien, Cyrus"
	<cyrus.lien@canonical.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net, v2] ice: avoid IRQ collision to fix
 init failure on ACPI S3 resume
Thread-Topic: [Intel-wired-lan] [PATCH net, v2] ice: avoid IRQ collision to
 fix init failure on ACPI S3 resume
Thread-Index: AQHaspy+X31HbyaOiUixyJ0gaZlPy7G3ZF7g
Date: Tue, 4 Jun 2024 09:55:27 +0000
Message-ID: <CYYPR11MB842939BAE38A750C13775B17BDF82@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240530142131.26741-1-en-wei.wu@canonical.com>
In-Reply-To: <20240530142131.26741-1-en-wei.wu@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB6813:EE_
x-ms-office365-filtering-correlation-id: 078b721b-b3ab-416b-12a1-08dc847c7659
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?p9qDk038c5mWT6oZsEhjuVaJ8vr43DWwc4NErKqKau2Dyr5u4I++136S3cf5?=
 =?us-ascii?Q?wyTC2hmpcsfF4oPca0tgUgi7Wlb88sflxR9od+hzMlZ1HwEyq0K4FpV1Jwio?=
 =?us-ascii?Q?XQlgSZcT+r2azBMPmOhBEVXhsBmHuQNQnwy4Apbtt5BEW28y596mz9Ja+fKD?=
 =?us-ascii?Q?JfGstZfT/DS4scdlgnnEGHRf+9fONkNlivD0xE91tUAm6G8zV1/FpyCma2nL?=
 =?us-ascii?Q?qJ2fGosKLFltWE+/4/5Scg0oGBOk1+WlwlOm0AhO2e1MfVgGpsHRkZN7+kOJ?=
 =?us-ascii?Q?EoR8eCEtH5pTJ0UtbdFd82IXy5e/YYkOBkCJjGrH8gErkV52lYe8FdnreUjp?=
 =?us-ascii?Q?JFevtr/uet+LCm2PRyacDIY5W+Hxb3D5Oo9bp5Q3HmeZ72pbWeh/6FqXRPU1?=
 =?us-ascii?Q?dUqvWIvFND0IBX0gdbStdbDs41283G9s/rQUnUCq1+TuJYCfQjJd/taZQn62?=
 =?us-ascii?Q?ziXT90eD9U4tX7Qa+lzaIOYR6o+0X3HBmAGGZakK0anCsY4XPlta4YW9p0Yf?=
 =?us-ascii?Q?uT0xJUUdRPWYWSogSeWeXjF6vsjoY+QCXzva2WFsadNZooML688ba0VHrnM5?=
 =?us-ascii?Q?UH1IyJZgMpOpR9l7nkdBSyomsDrV4sg0WIltHnMJ0IHRefOlpngtrK98pC2c?=
 =?us-ascii?Q?sFnturS3O/50Wk52uOuhftZaFkPzJt1bTPbSkB0an3NGRYrQ5kRDOFMze49l?=
 =?us-ascii?Q?6bPA9AoMZbfrD2I3bhUCbw7YB+wKdVu5AjG3fAMJ8jQtOIdlGyWL88OL4kfB?=
 =?us-ascii?Q?tytkzRzRC3MlenA+xnqxiP6lkXlQ+xLRUXPFjRAQzulnzFGS+te3gCdfFjfC?=
 =?us-ascii?Q?rl7oWnuGvymRC+yoGdg3wq+hmzKJ3vObavRb1lp0KTDSm77hoe/9N6iggueQ?=
 =?us-ascii?Q?OlZnvYfvzK0S9537pfQBLVD/QZfM5FUyqJ/1hlyEYFEVXGuKIAe8eT/H71SE?=
 =?us-ascii?Q?MK0m0N1awamR2ysBNagq4jfsHsuFJ0FTBsUx4Ud2/MZQ6alWcaczZ3yOY+ea?=
 =?us-ascii?Q?R9ZYQwnCI70Bup9jTCbx24yQs2QOyhaUOtLL6QvI52b5R4yBAwDAJAwbLVyf?=
 =?us-ascii?Q?S928xpT2SgsL6r3vpR6Q4i+Eo/X82JfSLKaB0wwE3G9BShD7g0lBh4eze5J3?=
 =?us-ascii?Q?U1hEYZ3MEHRZncQ284KwzfM5wmTXgeONrVneQXJ6i0G1fDXZphtzj+Gwcqtz?=
 =?us-ascii?Q?a9CXkdWKkjJcIXcqxKnbjlxFHjjEMMhwh/QMhDIPrcmfbSjHUkgxyQVyl32c?=
 =?us-ascii?Q?TEv7vPUZn0l7VXm4AlP2R7ZnzOYumyT9Mm4Ka+zzx1PlrZe296t3+nFiZgV3?=
 =?us-ascii?Q?98N3wA6uoLQFz/AaF4UYPYf7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0HLWEr9Zk/RTMa7dAUavjlfntm4h+OsTgBMWHq2KqxYAOwfathYsWBThAkp?=
 =?us-ascii?Q?esO7h67QXSU7Rzk5rY6Qe1KBqwe9+WC4yXyS+KC3LSCZJuh7d6+pSlgLq7tt?=
 =?us-ascii?Q?ty1LCJzpOoFgMysxhJRfURGB7fzgFhPwd/O19SVjPtQ+Q57p0Qt91ZDXeRkF?=
 =?us-ascii?Q?v9opJUgNZeudIIdpnH1ka1xgyFxmVRarobuZz2ohG5qUT1UuWIYsiP96xL16?=
 =?us-ascii?Q?VZZCgqJpX7atmm9gwrpDXAMS8RAJxaikQJZ55gjKqcRb77JzdlUvSODNR9PH?=
 =?us-ascii?Q?kFQvQ0pv7TPO4TRplVTQIjklIXogj4sRgnSTrd3MaUEPVOcUaW9WMijK8b7I?=
 =?us-ascii?Q?II/64GIDXVCLOVo8ifolriw6Hcb+Yr3OLqj2t5/9FOseE2tXorhWlskj0Kfu?=
 =?us-ascii?Q?v/ndEwRly0LcTmH+iBjO1sjq2I04D7CecKLwJJxCYkjY/dPCL+6cg2YjG28g?=
 =?us-ascii?Q?9ouCBFtW6jI8XKceyYlHX5WnY83P1+8GyHl9nUVtUzlv0u4qyS94bCbPnk7n?=
 =?us-ascii?Q?L71IJABCBJEcwStuCNbbWXI3VI70gzQfTY4ddpPX0AmOTf7YuHv3JKso8RIY?=
 =?us-ascii?Q?2E1z54lFi2uUaipyo0faT/cOSNvgvT1fQ9wJMiskxdqo7kg3cIxqqN23RqEQ?=
 =?us-ascii?Q?EDwpkp5/H1zkzkYwEbqGtdQoU0cynaRwQbIKG1dDPAmvxuPMQZ5ycJupDmPM?=
 =?us-ascii?Q?RULfz3eRCMkaFljyPncj8dfL69w6XWY8ioZtqPzd5pAPhLZBqI60mUrAfKmW?=
 =?us-ascii?Q?e4DYvB1MYyO0F3eYE5kHYm5FcpKog7roDapRplDkdyCLLrSoPJdJ7Up7TaPl?=
 =?us-ascii?Q?8WGHrtB1dzaAsuw7TJehY6V+liP2CkRcdegD8C7LBHSAeDZcAqpNT0+d0KYS?=
 =?us-ascii?Q?SgWJ2AeCjRT8vAq/XC3hH2LwfdFdvlByXomYeCdbC+CUburVT+rOAnNIohAl?=
 =?us-ascii?Q?vqZwUGnGksg9XsdIzTuh4Wimfuw2rXcX/1JuzfBduXnP6h8wyfGu8WGesKAG?=
 =?us-ascii?Q?SsA9MH30/NTKbRTDjoRIUGgM3hWolf0MWLmqjZMvIwek1+UUb+BhmBYF+210?=
 =?us-ascii?Q?PCEHfgVva7f5vcHC+3QPebtyRn2HzJ3trUwZwSYY/2CuGvbpCopiZZnG4tDX?=
 =?us-ascii?Q?cWoG+GR6lCn8r07T9q0l9GxmXLDl74tZC22Fn2Fi1/o+mEjZ1CeT0dyDrwqo?=
 =?us-ascii?Q?AshzB54/vi2BNRKDCNzTCB5TSWG0AtUtKIt2gPk70zl7PmG7XLwopTQgzNyB?=
 =?us-ascii?Q?56vU/8/91YwLwYfP83UrAzqTAXwhCTloMXSL5zBPiz4RnzZwoisYSku89zJX?=
 =?us-ascii?Q?E3JALmvS88h0CvK+/jtlW12vkC9EE9EK5ZkPEyc2GNS/ZYL3w0GZb6oGLXw9?=
 =?us-ascii?Q?WYbPm8bFRPC6z5l5fIHZp0x5nJgvtYwk2MbcWKyi3dXqvYJhj8nnmeZVO6fc?=
 =?us-ascii?Q?Blas8tTw+29VpLSSORgA/AHcbg0e4av/XoNR6gWInQnVBTUBzr/H8r03acs1?=
 =?us-ascii?Q?Q1Y7DEaD3C8KlFCqUxiDGe4bF+3aanM/2E2A7fvfoCnPXVXjylBvAU7uyO1g?=
 =?us-ascii?Q?bpOWI5d0k48WFrEM4nNncZ7G1smUL9TbiTsuVKr8uC/xV9ZVeSjWwrNg3W3F?=
 =?us-ascii?Q?/g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 078b721b-b3ab-416b-12a1-08dc847c7659
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 09:55:27.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIV6TAXxFWRIU2FQqeMUsBpalErTBtKDrXYVBEmbHcnohtGdaVBTsF5PtzVLYxOYqfnbztOzb62A1HnBGGLGnsIBunX5TVYsAetIJGXoAjZ83UIboRrTL+rPQg4WMUGn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of R=
icky Wu
> Sent: Thursday, May 30, 2024 7:52 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: pmenzel@molgen.mpg.de; michal.swiatkowski@linux.intel.com; Drewek, Wo=
jciech <wojciech.drewek@intel.com>; intel-wired-lan@lists.osuosl.org; ricky=
wu0421@gmail.com; linux-kernel@vger.kernel.org; en-wei.wu@canonical.com; ed=
umazet@google.com; Lien, Cyrus > <cyrus.lien@canonical.com>; Nguyen, Anthon=
y L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; kuba@kernel.org; =
pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net, v2] ice: avoid IRQ collision to fi=
x init failure on ACPI S3 resume
>
> A bug in https://bugzilla.kernel.org/show_bug.cgi?id=3D218906 describes t=
hat irdma would break and report hardware initialization failed after suspe=
nd/resume with Intel E810 NIC (tested on 6.9.0-rc5).
>
> The problem is caused due to the collision between the irq numbers reques=
ted in irdma and the irq numbers requested in other drivers after suspend/r=
esume.
>
> The irq numbers used by irdma are derived from ice's ice_pf->msix_entries=
 which stores mappings between MSI-X index and Linux interrupt number.
> It's supposed to be cleaned up when suspend and rebuilt in resume but it'=
s not, causing irdma using the old irq numbers stored in the old ice_pf->ms=
ix_entries to request_irq() when resume. And eventually collide with other =
drivers.
>
> This patch fixes this problem. On suspend, we call ice_deinit_rdma() to c=
lean up the ice_pf->msix_entries (and free the MSI-X vectors used by irdma =
if we've dynamically allocated them). On resume, we call
> ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the MSI=
-X vectors if we would like to dynamically allocate them).
>
> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> ---
> Changes in v2:
> - Change title
> - Add Fixes and Tested-by tags
> - Fix typo
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


