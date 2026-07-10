Return-Path: <netdev+bounces-306506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JW0OACLGUGqI4wIAu9opvQ
	(envelope-from <netdev+bounces-306506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:14:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CB73986E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TIbS6MDk;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306506-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306506-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C652B3031CAF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C23EFFA8;
	Fri, 10 Jul 2026 10:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E23BFE5B;
	Fri, 10 Jul 2026 10:12:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678378; cv=fail; b=JvBqW2/zq1EVWd2PQEeKx3LrBUxgLUnAD+mSa6GImD78EhHo2fB2S2+habtI6FZCBOBMjQrZKuOl6KM8PuZRYWsg9D1/q+sWqpW1u+NMky/0za8VvYaldwVIG3waekdCUR/uUIv6ntZVVt0FMpmkIu744lg08Ye6++oKTHoEDZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678378; c=relaxed/simple;
	bh=Ue+2+1X5BtcZqULy34fSTHreExHFCZF71TT64qFtwKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NxV9oEQBvP1BIsYIAazcKJ47cH9B/uMyUeVGtRTKSybwsk+v/+VcpoQIL3j5QSCCbVQUj6EaeXtYCHLnkWI7RYty+kd/zF+QVO0+vajQz86afENkNF1EjxE3/vsGCP8C3tpsxEub94rKRhETt3DeNDLbrWP8LFPDnE15DlPUAUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIbS6MDk; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783678376; x=1815214376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ue+2+1X5BtcZqULy34fSTHreExHFCZF71TT64qFtwKc=;
  b=TIbS6MDkSqa+iCK2cCwn9Hjnt7qBqibAAdH8+s4ExiU2ykjx7wO7uYke
   SMhetkMOPWx7GU1WrPKzgKvEmASTf2lHNH2ywz50j8xQxyNbYUeYGatxM
   sxS0jLzzjwhiDu4BIFvpL6E6dqUFs+KiA3LgVf8kMi3OeqfjvXF8yWoMD
   3Zg+v9FVv1JXVwtSLH2KEt7wszwbtwzeKxhFv36DPCwIzXGy+UDk9zY+D
   A9uouuZFmosS+qqkrIl2J2ZQtpU4kvAtRfEX+s27iaDZCtWZ1a91viiDk
   a/RtslhKC1MjC4Jec9sOeqjNfGyegq/Lya55HcubgMnQq0fOa3VvP2DwZ
   w==;
X-CSE-ConnectionGUID: g0CoUXxsSvGlIYIqlxXHPA==
X-CSE-MsgGUID: jl4x9Fx3Sfaj9wlN3vOnAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88289481"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88289481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:12:56 -0700
X-CSE-ConnectionGUID: cM5heZS3S7WtwjUMSawmZQ==
X-CSE-MsgGUID: /Ito7mPWR0WQOQ9KpHrBxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259744430"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:12:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:12:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:12:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6kMQa3lKmVbCM5l7FMRqCL63Z8BrzJdzphITc62k1lf8SgjX+WgLeRaien57v04cdYvdH/mWetnXkAz/g4aytLsda1X315Wtu4o3L5kCQIV4Qc2dOfiINUYR2QeTRqZe1EoVDAERDEbkfOkRCuHj0E6KLXaNB1/m+YeUWrY7nADnRyl/xlWyidHVT60bTRXXaV7Fd3+KGizRbVVbQXoGSBBstKEz6lrZStFq8uVzoVHuIlXTyJrNHWkM9V00TLAHo7K12OaiFQZ9s6VnXKTHOvjCrN0Lh4L4SDWaPahpkEF+zDtvAfaiA1Iojuu/dzS+bchHG3unE5c1HqX7y436g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMoA6JaloHaRqZsCpEJAyKFjC0bwpQilQLMiaprOpas=;
 b=gbRzGEUxzVH4D4iJMblv3jdmIx9lLMkO/Kmjl438QbNsuzehOjEwU9JNHqtXVJ0PvwHbdG8PeTr/cKGC+YmIOz02bYWnSM6TUrbywpS2YMX7yHm/fi81D9qqWsJKe4MEaqyub6KtP3cx8NRfMIEW1TYYTw9Ls5TuSk/iF+l6ldU2AmImSBtBKzyuohiPWLFEp+feCrL8oRE84Y8F6O45g5b/xZflxYsJYADMHICcW4FDyp9UoJgxtVMwtCIxsz6TZH97O7ehz0WgPlY1InE07zRbcPnm0GpZZ07t5I4plIbR0AK+kCWkV1R98KYVrUlwfe5oXUWCV7tYDGNc50cudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 10:12:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 10:12:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Vladimir Vdovin <deliran@verdict.gg>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, "KP Singh"
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
CC: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next v4 6/6] selftests: drv-net: add XDP RX checksum
 metadata tests
Thread-Topic: [PATCH bpf-next v4 6/6] selftests: drv-net: add XDP RX checksum
 metadata tests
Thread-Index: AQHdDxlYVYaacTK4cUq9yf596jdhB7Zmiv1g
Date: Fri, 10 Jul 2026 10:12:45 +0000
Message-ID: <IA3PR11MB8986C7DB1613FE2F55BBBA1DE5FD2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-7-deliran@verdict.gg>
In-Reply-To: <20260708203410.45121-7-deliran@verdict.gg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8509:EE_
x-ms-office365-filtering-correlation-id: 27ac7b8b-fe1d-4e82-d29d-08dede6bc96d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|11063799006|921020|4143699003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 6A4NlpFnme+Sfb7aZx4yVcwMVb63uf+n1wPB/AHkipaBSqei2CcMgTVoki3uBW9r02Em6k3JSN6AsjcLp4ukEeKuJ7p+IbnH9fHDhXHXCNH84Nm7Iv6eUCPtX0OB5bDMLNQQXWmGrHn+RW8k/eDHJBgLMduh5zaFWq1yG1ehhjwPagOrvkSDO6ISsH7wlpq6enFWa9CQAIvm3WZhlNgh6nc2SDJGNEGHgLSa+ZpwDkkAKHcJH/7bptjXk8KniT3DDYEUALv525h2kWCYO6/q3sUXxLccFDSaoUQAvI3TURDw1KYshF+7VBvBl7nVW5aqU7RaQa999Mp+CzZLpa4tnszXSvp3EL6SMxkIKc4m/ImXn04w+WuuLnoomO5cLvoKE7uKY2H8S12bdRlmLHzV9jLYY2pquQBqsNaqMoNSR1Z84xCC4iVnzndO3jUvnuqr3qQTxww6Mf/rd7Nbuc52obPqBMRsXUT03iOO412mZusELl3aG2fX9PFv/3Qkoa+EAFae5h/iKPICSgFoU2BKeMbZPw53dvfCKBl3a3ImnlxG7UOLvu9TRNE8cVULV8LQiReGkxo295mlGf6CAPBO9pFN9AmARhd9yTsrpxCCWqrgWrcnBsG3j5fwpphQ5SmbaTkUDR+f4tRC50yFCLHQ98NNFpH//saGXPuSDTdleEPdXkJM69pmX8G44rhvqxySKX0KrHwIyAxawQu4SNJpujDUhFwW5jTbTWZpjFCX/LnxwBgCM66XxxLfKqLYFEhV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(921020)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P/UaZ8c8j99wXarJY3yWdUigKSIL7eFVjbA5krFOJgUeycP4Gyr5ZVmFmm8l?=
 =?us-ascii?Q?xO0ri6KyCOBhMfooki6qCFUsyVHbrol+Cm2slxiSvfq4WADslS1A2KFT5ibh?=
 =?us-ascii?Q?jpNlfTpvboN5AirHbyC1EU6cP7H/CN5ZAcnnFGrLRC7HCwvsLaRkOcUL2oow?=
 =?us-ascii?Q?2thNHp5/2ZKpr6OQPuhjYLkd9kjEeh08MNorbBpzUEM5rLI636igZp4ZeI3a?=
 =?us-ascii?Q?LCp1qyf1TKmzEegI2fyebPgmFiKQKX5BXDmM0MD8ni+RV+uF7Bkz1lr/rePK?=
 =?us-ascii?Q?9CkFhiyQf4kMKY1ky70SL3ZBl0a32b6LWpa53x2TQybwuZ4oxbXZE+ky6gMu?=
 =?us-ascii?Q?AJBY5WxPZyPPj3kAo9aqJVwblt+04EtT8+eFi1E3Pdqrvy9N7IZgG1pxxooz?=
 =?us-ascii?Q?bj4z9Bkf3fP2hWS67aV7PUBKdcI23pTOdjI8Bx9o7e6opWHqjKU5C+jQ5EmP?=
 =?us-ascii?Q?787MY7E6GqnRn8ttFqMXlnIFS0mMU2Ej7P864f1Qh1WHRefn75JwxylkC54S?=
 =?us-ascii?Q?1flZZgnf9lmFBLUm63ZCuNOzPhKVnMXyzIIbSF8HgWabjOAQfbEGfcjx4jU9?=
 =?us-ascii?Q?X8zYn9M1K9jSbSznuMHx+6dQ13m/aS4WbL2EJlQjEFBuL1ynbDTw9wbWj5h+?=
 =?us-ascii?Q?nix1GzcOoOQ9kwM3G8Rmzsy8A+gcI+LlDJeqqovCEiEV+GJXyfWRQTajCH03?=
 =?us-ascii?Q?dnIKDHGfu3CWQK/L7JPHilyTmjIl8SFD+wrojXdblHv6sVeVQYHfqUr/e+QV?=
 =?us-ascii?Q?ipOyr07VnAtaV8jHMkHKaK2VdKoMxX6GgcSPGQpLaWIJFvVMZIECYI7UnMNB?=
 =?us-ascii?Q?yxntkdLDRTqLzLH4/M1G4bLVRabhE1/iCvbBTkLh8bjza4Trfd1dEyG/DVAm?=
 =?us-ascii?Q?4QnRgO2o9XQ7B6DAGEluPNitonH+2eCN56vUSHq5CGfViOi7t4ZkRA8VpgTu?=
 =?us-ascii?Q?wo8lTa9WW7/ATXuYrSTE9ZKWKm7pZdBhz5g8wNKc8ycyE3pnhZ+/p1JHiNkO?=
 =?us-ascii?Q?4/1zEjxzDVQW3ran9zSln3D3i6K06JMRrmcNTeguivLOu/Tg4exUKDoNr0CT?=
 =?us-ascii?Q?qyzLio0KzRNAKZzRSeZqy+lQ44RIW6DoYWF67eMQyzJy69yiEaMCz+Ofl4uY?=
 =?us-ascii?Q?BPYV350l6RhPhv2I6giS0nl7PuzmZuqSNBDCj0MvTJaeLEVaaVKBggDSnzkZ?=
 =?us-ascii?Q?mslQcJNBBgT18p/MHJwNZQRM4cataA6EdoMHnMIMZvrJTETirBSqET7J/o90?=
 =?us-ascii?Q?mgI9BISxh2VDtRLD1dtryLPjmHJ5EGhc+5Z2XdqRAXV3qr6iiZe0P877Bcfj?=
 =?us-ascii?Q?hobGsuJdltnP0eUBnQoEmJYWydF9TwJok2BQbtBKbm8r449fr72oJskOTcv9?=
 =?us-ascii?Q?QY0e+QbuLFMhFMct86yk52SY4ijGmtOWpdrYTfFtgtCZ7gOkPi6EeoQgigyJ?=
 =?us-ascii?Q?HSsZZEZklzfXWR5h3+rbFmDsplHeuv8zFv/hg7lkt5FuU72lzkm9vI1geVt4?=
 =?us-ascii?Q?1tyZnHb0glyn6u9kQI1OqLqBcy8f+30QGZZuSCa1O/SQJ9ZOKNPGISsvGVzW?=
 =?us-ascii?Q?RyuHRQ5qCXqUn4gQqH40jOeN+bf8el9n1jhdxnleFhpxgC1fx1IU96AcVtru?=
 =?us-ascii?Q?Er03dLVjzxY/9idlz76H6h6lLJCdmvDG7dAq1fr9ZFWSLc5e5o8vQDi67+fl?=
 =?us-ascii?Q?WmhPKpDoJnQ/1qkD09CBtGg5Mj5vbpFFnmhn97+sqblugrkKzQvR4Kxr8fyo?=
 =?us-ascii?Q?FsGDQIguTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bvgm5JWOo838h+O45rcVZg0r/AMLiknFYd/FZkNbWaybzrLmKpEl4Qhqw5U64brxc2yWOkWf8zy5O0WudzzG6wYw1AdeJLZ1boloA2uxCyN83b19aQR1ELum2Uvqm1rY+XUe06FN3iyFi7511gAtTTbgSB2f0l0FmtagDo/BMWZhm5Po6T1PTboKUsyA4GU8sC2+O8iJDKSfu6iEGx7LPnd+lN8MVeloKKlbUcOkAKPDzaRwbvsg01/En8m1de3ZNMtzdwhgqmKbEgU2yVlhxoOCAmWv5Mn3RVK2n+iuXjTph3c+TIE0ffIXPDQKk0IbDwRG4+JzzAn1vgoE1+Qzuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ac7b8b-fe1d-4e82-d29d-08dede6bc96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 10:12:45.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oef1LdxDNtnDWZgt40oF5HFnxMrZa2GSQuFALXmgdLtNhXuJYIUUm2g8XlhLO6Cqvop6/ClEfiWBs1q8noYDgmohUzjQz42fG/6ZMvPkikg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306506-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[verdict.gg,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_RECIPIENTS(0.00)[m:deliran@verdict.gg,m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 636CB73986E



> -----Original Message-----
> From: Vladimir Vdovin <deliran@verdict.gg>
> Sent: Wednesday, July 8, 2026 10:34 PM
> To: Lorenzo Bianconi <lorenzo@kernel.org>; Donald Hunter
> <donald.hunter@gmail.com>; Jakub Kicinski <kuba@kernel.org>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Stanislav Fomichev
> <sdf@fomichev.me>; Andrew Lunn <andrew+netdev@lunn.ch>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Andrii Nakryiko <andrii@kernel.org>;
> Martin KaFai Lau <martin.lau@linux.dev>; Eduard Zingerman
> <eddyz87@gmail.com>; Song Liu <song@kernel.org>; Yonghong Song
> <yonghong.song@linux.dev>; KP Singh <kpsingh@kernel.org>; Hao Luo
> <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Shuah Khan
> <shuah@kernel.org>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; netdev@vger.kernel.org;
> bpf@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kselftest@vger.kernel.org; Vladimir Vdovin <deliran@verdict.gg>
> Subject: [PATCH bpf-next v4 6/6] selftests: drv-net: add XDP RX
> checksum metadata tests
>=20
> Extend the xdp_metadata.py driver test with coverage for
> bpf_xdp_metadata_rx_checksum().
>=20
> Add an xdp_rx_csum program to xdp_metadata.bpf.o that reads the RX
> checksum verdict and stores the ip_summed bitmask, the hw checksum
> value and the checksum level into a map.  The L4 port/protocol filter
> is the same as in the existing xdp_rss_hash program, so move it into a
> common helper.
>=20
> The new cases only run on devices whose driver implements the
> xmo_rx_checksum callback, detected through the "checksum" bit of the
> xdp-rx-metadata-features netlink attribute; on other devices they
> report SKIP:
>=20
>  - xdp_rx_csum_valid (tcp/udp variants): traffic with a correct
>    checksum sent from the remote endpoint must be reported with a
>    usable verdict, i.e. CHECKSUM_UNNECESSARY and/or CHECKSUM_COMPLETE.
>    CHECKSUM_NONE is a legitimate verdict for a device that does not
>    verify the packets (e.g. veth reports it for locally generated
>    CHECKSUM_PARTIAL traffic), so it results in SKIP rather than in a
>    failure;
>=20
>  - xdp_rx_csum_invalid: UDP packets with a corrupted L4 checksum
>    (sent with the net/lib csum tool) must not be reported as
>    CHECKSUM_UNNECESSARY.
>=20
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
>  .../selftests/drivers/net/hw/xdp_metadata.py  | 110 +++++++++++++++++
>  .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++++-
> -
>  2 files changed, 209 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> index 33a1985356d9..1a623771477b 100644
> --- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
> @@ -8,6 +8,8 @@ These tests load device-bound XDP programs from
> xdp_metadata.bpf.o  that call metadata kfuncs, send traffic, and
> verify the extracted  metadata via BPF maps.
>  """
> +import time
> +
>  from lib.py import ksft_run, ksft_eq, ksft_exit, ksft_ge, ksft_ne,
> ksft_pr  from lib.py import KsftNamedVariant, ksft_variants  from
> lib.py import CmdExitFailure, KsftSkipEx, NetDrvEpEnv @@ -81,8 +83,22
> @@ _RSS_KEY_TYPE =3D 1  _RSS_KEY_PKT_CNT =3D 2  _RSS_KEY_ERR_CNT =3D 3
>=20
> +_CSUM_KEY_IP_SUMMED =3D 0
> +_CSUM_KEY_CKSUM =3D 1
> +_CSUM_KEY_LEVEL =3D 2
> +_CSUM_KEY_PKT_CNT =3D 3
> +_CSUM_KEY_ERR_CNT =3D 4
> +
>  XDP_RSS_L4 =3D 0x8  # BIT(3) from enum xdp_rss_hash_type
>=20
> +# Mirror of enum xdp_checksum from include/net/xdp.h
> XDP_CHECKSUM_NONE
> +=3D 0x1 XDP_CHECKSUM_UNNECESSARY =3D 0x2 XDP_CHECKSUM_COMPLETE =3D 0x4
> +
> +# Fixed destination port of the net/lib csum tool _CSUM_TOOL_PORT =3D
> +34000
> +
>=20
>  @ksft_variants([
>      KsftNamedVariant("tcp", "tcp"),
> @@ -130,6 +146,98 @@ def test_xdp_rss_hash(cfg, proto):
>              f"RSS hash type should include L4 for {proto.upper()}
> traffic")
>=20
>=20

...

>  char _license[] SEC("license") =3D "GPL";
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

