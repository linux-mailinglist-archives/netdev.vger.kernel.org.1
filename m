Return-Path: <netdev+bounces-306503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RJdTChXGUGp/4wIAu9opvQ
	(envelope-from <netdev+bounces-306503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:14:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350F739867
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:14:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KFD6xl8P;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306503-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306503-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3E5302450C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF38383334;
	Fri, 10 Jul 2026 10:10:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21241400DF3;
	Fri, 10 Jul 2026 10:09:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678199; cv=fail; b=VU0PkGtz3cRKyxl2ZtDnC9uV139yaQAO0/GbnJxy1xKn98sqB4s76+Pt04mnVQ0eSv/1szjDu7fXSehkVHRMkbsPK6tgq4u6OHW/asITf1PSVmHmF8cxhTGl+RZ4sIDDDbr/7dmUYEAs8DnKKACasYnQNnJtWle903S7ZiwxzuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678199; c=relaxed/simple;
	bh=CRuv7oIh2VACW/EI+O8EdMN+5Xlv6yP9Pn8CGfRQ1l8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9bJF0lTlM2jh1FjxSITT6c7Zlrv/d4kJbl0aiQWUWt7uiXABo8lYkQx9DVTaDCMWgiDjYG0DLmTWxvDlVjH77lzl2RKX1WtyENft7K70mN292mRG2Tn7ZUL1OiX8NgTCF8ZgujTMrphBxLsm9PM9hoMBE8BJSZir0vFf9caoPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFD6xl8P; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783678197; x=1815214197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CRuv7oIh2VACW/EI+O8EdMN+5Xlv6yP9Pn8CGfRQ1l8=;
  b=KFD6xl8PUZFEsp2zqLvQXdcR2RQOTjf4KSoETWpX19DCjfTz42cxirbb
   zo5Zycud9LqjjBVHIM7I1cZUsULJj+QNJUEQIzzOYiT3fuvvua4x5Ot3V
   7lar1m4VSWYGGk67LbqBdNYmazewSe+4RE+U4sHBW2M8Rz6lEsICvJKqk
   DnmjqHbOSsFzuio7z+atfzMTx5vYHJmHd0WdFstASErsmcToMopiKXk9I
   9DS2+MYXqFv+BgNtYIkjpXHUis7l8z5NpXZrE/2qjKEzKMeESi2Hd4HBb
   j21RhP4+OLM5GQ6S8I/Oeo/JB9TuomBVVpnns02KUiGZVyZdSiH+H1r0c
   w==;
X-CSE-ConnectionGUID: Vz6WXgTlS2Kl4EjVpStWCw==
X-CSE-MsgGUID: 8zbKlcguQte93B0BZTdQwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88060149"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88060149"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:09:55 -0700
X-CSE-ConnectionGUID: c1QCjO2MSWST7wwhvZINew==
X-CSE-MsgGUID: ZmVDKiaQRrW7Kc6GacguAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293047432"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:09:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:09:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:09:54 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItQpsVRCGwOC/h32yqH8n9jV6ZV1JDub5w8ofGydD/MVW9IMzjb3LQ5oUnQ4RlJqrQRI+lzZyYtxKJ789xipNkHWNrZ8pgO3Gw99O399p5KRoUj5Jglq23l/v7UgKmn0CBLVJ//4preDMTLV1RkfsInHf+HwdLYVwNhmP1dCm6GIluLS+lnj9CL26UB6CyUZTcHUO8ZWkDNJWhwQJ547LMyjoLEAN5BklBpMXtiIOIf4cNO2jt+fmp+bJPeksw6s+BcOvtGCE5zWmNEukvUmFehAbesfMS/qTjUXMBDy0ZZ59/0Y9I8EpitgaKIu7TkrKN1AMInQEW7m5RmlofZF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HA3FeO417PLDnfzbYny6UsZFWV9XW/fIxpwfC/AY8A=;
 b=ACZtcHODMFdpC9IIRhqEOfZ9ChExqmU/impsuVCCfCdCxt/fql32LmvGuUAiTTaPp+eWssf/NVbuAcX+CviyDVoBa4zCY7kbgznUHZEPfvIQORUkQnWiB80GiaV5eI+L0L/pLPjXhv+05JVFSXZLCSuis/2q6q+w/vNcr8pDumsfpH8mf69iwAdd3vG8x5yz3QSWpQ2nOtywcSeJfG+8jGzMNVkd9hhnRsf58ENL68M0MfJmIoP/jxDvVsC3s7mTOSsedOXUVR9dEj2QXvYJ44HZRx4mbF8yw7SBx7rRpc+06xm7MK3twNXl0IvDB8SRQcqaGL2aQt08hPQjxc9mLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 10:09:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 10:09:51 +0000
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
Subject: RE: [PATCH bpf-next v4 2/6] net: veth: Add xmo_rx_checksum callback
 to veth driver
Thread-Topic: [PATCH bpf-next v4 2/6] net: veth: Add xmo_rx_checksum callback
 to veth driver
Thread-Index: AQHdDxlfLpOsSXhOZEymmxGAxOsScrZmiinw
Date: Fri, 10 Jul 2026 10:09:50 +0000
Message-ID: <IA3PR11MB8986EFEB423FA81E72D2542FE5FD2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-3-deliran@verdict.gg>
In-Reply-To: <20260708203410.45121-3-deliran@verdict.gg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8509:EE_
x-ms-office365-filtering-correlation-id: 8edbcadb-b6ab-40f9-f980-08dede6b6158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|38070700021|56012099006|11063799006|921020|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: MdqU402MNRqEU02jTbD93STENpXC4ZsJE85O2yUgw26KnEjm3Cwu34QnSqzp/RA1PM/SkmnynikuA/yoyj8gTwT063hgmUBvTfafDXU/BxIINe4Y2aEu814k90nTb3PhlZElXeHhx2yWwG4kDYFV3MWCt1YYl2ZJDt5xZzLhua3uTzR6URyv2bHkJz0GJka+p52hesd3yuoFMhFNBUM7HIfDzc6vTuFrVdhGc/kMJe/w7uBp+su+oZPiX6DNQuCnhlFIaSMimvZBbdARM/e4VAFqHrSAxC23I0o+Q5CaFws9JyG0g7kC3m50ihiQ202Zizw1gO/RU56FSFKlFPgjNUUgdUxtdvKmCrLgHEKJbu7R99E6ukOFtYiRmdP3dNTnoW3XehghWsDEJJfoq5y1wlfJb1Xcly0diBumuFr5n1WhccGHqvSFYOjLk5ionBp/4iIRq8Ygw2iatehWfqpFGUwI166L1EYYgBZrz9hRwa0bxruIsTb0HV1gQv9dUGicyrtExmhveCUJe4dlSh+MG/ObTwJ8CahzsRLbTygWCSv/t1sUE/KaWWKDJQ/zwhmQF8nZ/Y/SDToZPjIavEBvdDr7jhVyIbCDA0X5QHAF4l2CbbC2mbqX1YfVXh/Hq6iSu8yas1FKrQJvcPsNMPV/XwOCE/lf08DuBDjIZrFCQ5mkWJTYEnfjgURKP+2htnSVtMPMtp/iTcXL5ca2S1bZ3307tIQ6bS6S51jDYIBHgpassG7XQMOjSQ+bwPpyak4g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(921020)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fpzt9vYYiTpJ5CR5J6xZ0A0ez97QhEKzK2QB7fwBbks0S9kV7RAY8w++LMo2?=
 =?us-ascii?Q?Y6UnbTVhXFI6XN3Xjuj54ytzANH8zDJhpgZma0z21EXJZFmTaacP5bX9hOuQ?=
 =?us-ascii?Q?imt/veKToK2t9pm/X7pOI34rcw2ZfmaqlV7vhmm0AkxMoQf6NtRIgcOG9HIo?=
 =?us-ascii?Q?9gJpInzgT44JYfP2QTJ8MSmbqrK1Ta5DkWw446cEGaV/wyUhziTGIm6xeIDg?=
 =?us-ascii?Q?r1vR0qtkcj/UV+L4TJBi8prYYE349wmoWS/WciyzS63vpQ4Q8NpVLYWCgiLw?=
 =?us-ascii?Q?XR0Nmt5AUEYPedk8BQdSnfRjZvg4Ew/laDYl6r/R0+eqfgtulayCoSM1nLlG?=
 =?us-ascii?Q?AhyIGmRGHk8/dt7OtySB/yi/lF7vWCQm4wzgtpFitpqdGt5LmthK2qjx/Jb0?=
 =?us-ascii?Q?Y5dSszUCYwlJ3XvcqZx6a5achU4EQ9FPvKVbbHpDocDtf4tmjVwZ3W53zfmH?=
 =?us-ascii?Q?n5SmnH7C/4O0aDm7rEjt9hO/bEMx+x2ERPB2StWrjd78OfWEcx177NiIhkX4?=
 =?us-ascii?Q?wGHn3HuUE8ur2UbZh8XYiVfNYQA73lDoGQEhaDGaCy/Q15qlYLz6rDINH1SE?=
 =?us-ascii?Q?gGwixaHZ1FPvtAJKnPI5blW4vproTJk1qQmCSAiCKsGm1Rk+UXE+xCEuLiFw?=
 =?us-ascii?Q?LTh4VOHxVAATdFlqecP2TvOE64S/Y4eMBpfgvxhC379JZuZxgp4L0k7KU/1y?=
 =?us-ascii?Q?en4wnFS+qywpxc84I1kFWCJmhtxssaTX2608u67gDzyNloCpHjOearjVvLTJ?=
 =?us-ascii?Q?HMb5nZy7Vgkykk0ftcJpU8cqiipXfSeJWorg0Enr1BhBOqfxDdJKZ9Dnkosh?=
 =?us-ascii?Q?bCN2W2sOJODvirTSWPa7aQARA31D5+p6hln2BE6GFkcqch6yZI/adZ+5N69h?=
 =?us-ascii?Q?A3dvsq5B1cSdunOdHV++JMf3dMwiA4qFQfG7wEo+vEh+9+ACD3efI7qQU5dm?=
 =?us-ascii?Q?hYur0plVs7LjBSzMLWRR5OTvKWalwFbcuNIBnJr+Rh7oDGIzrYOcMZAvynqn?=
 =?us-ascii?Q?Xc1G+KLDqws55SVfTEwSfqM2WuvfT/Dnx0ZK2m7jpT1pZoa73HF8TWdjXerW?=
 =?us-ascii?Q?UGsjOGBcc+Lg8BPiQSJJaiTMXlYIAKYKkDEgu7RnHw7CmZuR2xssdwm63qgB?=
 =?us-ascii?Q?ejqE5w6tR3udBvXmNIpJzVuqLMMTEgQgaiO2aFFseyDJpmiuYqVxjmaTU5Fg?=
 =?us-ascii?Q?w4LpKvdxiPPisCBxkMdrgpp0JfPmIpME6kL8t//vrrmgVv0kdpU3ussd0nXn?=
 =?us-ascii?Q?E+r5F+imphqY6D90EhpyrBEnw5g5b1TnOPnKkg++WTiHsVS/Wi4uK8ZMJfHH?=
 =?us-ascii?Q?/1nxPQACZUVfg2zGNdwX2nBGplMtIMvBmeGG8MCEaRlNbUrJWG0EawdIG9vQ?=
 =?us-ascii?Q?8TM83bB2cebWiylyCVGV61T+t6ckNVao9/IyidplQSlZhk4cF55fuJTB8GJT?=
 =?us-ascii?Q?CCVK/+TIT1RLUwlB7yXnORsMQJONfQ2XXxSroLFxKgCsd+GVetoQmzpMUxN7?=
 =?us-ascii?Q?bkKyByo/YceI4DrHNu1KR9rtGe///RXJttipt9ydmQEm+MBBW4duciuZ/BNT?=
 =?us-ascii?Q?90MgZBVGJvDxT/zxMUcvYXpxABT/o7RR/RuaTNbsHo4ckOD7jbgz1XbSeMvI?=
 =?us-ascii?Q?QBXfF29hPfUzStpj3umU2j2MpZHSUNycQQ3xi1Xl1Z8wbfR9GzDnIGOoxMn7?=
 =?us-ascii?Q?adxbWk2YQ4zwRYxWjGnY9XaQB0+CxAMOyTnPmGlDMq7lLvrf8QklcX7fh91L?=
 =?us-ascii?Q?PmmWvdWCoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g4Dg0jwdDR0/Y+1S+Wj8fL3SK51EPiC2w5eOk1WIsyH4iVpQWDSAjdtWhdrF7jyKW0IuHaKGcwm4NSZTsRII/TFtIUELohdVq/7yALxMB1AWG5EA9mbSSxHz388WhGDmcNtyfhxhcyFeaHnl4Yg0ul5h7JtrGkgrrb1sYSgXCs4YagDc7FMeymVF9XvzIIwaKxR0UN7X2V6aa0o6zTcOoJIZ4pGo4gh8tGJovv+RET4DZ8/v9e4M3LfIw4WEaIP9E1CkP2uiGWHTHBZRizjF1bGwOzqASH/d+jcJ5PhMoqUreJjt9C3j4XQU9ZWzGPKljJ3dJek/6TFCTO0j6f4zBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edbcadb-b6ab-40f9-f980-08dede6b6158
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 10:09:50.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fG2unSKpQIpVK3y8SCRyocfFaSzKb5ZmEj0N91FSxFBDbe7kAOazOQr/RO2Pm8Yk1uLg92dT5DfaH33RmAuoRnRY7xCAQKJOmJJpaOUSHpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306503-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[verdict.gg,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_RECIPIENTS(0.00)[m:deliran@verdict.gg,m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9350F739867



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
> Subject: [PATCH bpf-next v4 2/6] net: veth: Add xmo_rx_checksum
> callback to veth driver
>=20
> From: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Implement xmo_rx_checksum callback in veth driver to report RX
> checksum result to the eBPF program bounded to the veth device.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
>  drivers/net/veth.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c index
> 1c5142149175..498d894d043d 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1700,6 +1700,37 @@ static int veth_xdp_rx_vlan_tag(const struct
> xdp_md *ctx, __be16 *vlan_proto,
>  	return err;
>  }
>=20
> +static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
> +				enum xdp_checksum *ip_summed,
> +				u32 *cksum, u8 *cksum_level)
> +{
> +	const struct veth_xdp_buff *_ctx =3D (void *)ctx;
> +	const struct sk_buff *skb =3D _ctx->skb;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	switch (skb->ip_summed) {
> +	case CHECKSUM_COMPLETE:
> +		*ip_summed =3D XDP_CHECKSUM_COMPLETE;
> +		*cksum =3D skb->csum;
> +		*cksum_level =3D 0;
> +		break;
> +	case CHECKSUM_UNNECESSARY:
> +		*ip_summed =3D XDP_CHECKSUM_UNNECESSARY;
> +		*cksum_level =3D skb->csum_level;
> +		*cksum =3D 0;
> +		break;
> +	default:
> +		*ip_summed =3D XDP_CHECKSUM_NONE;
> +		*cksum_level =3D 0;
> +		*cksum =3D 0;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops veth_netdev_ops =3D {
>  	.ndo_init            =3D veth_dev_init,
>  	.ndo_open            =3D veth_open,
> @@ -1725,6 +1756,7 @@ static const struct xdp_metadata_ops
> veth_xdp_metadata_ops =3D {
>  	.xmo_rx_timestamp		=3D veth_xdp_rx_timestamp,
>  	.xmo_rx_hash			=3D veth_xdp_rx_hash,
>  	.xmo_rx_vlan_tag		=3D veth_xdp_rx_vlan_tag,
> +	.xmo_rx_checksum		=3D veth_xdp_rx_checksum,
>  };
>=20
>  #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST |
> NETIF_F_HW_CSUM | \
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

