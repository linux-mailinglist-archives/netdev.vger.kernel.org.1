Return-Path: <netdev+bounces-288298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE8tLIMaB2rnrgIAu9opvQ
	(envelope-from <netdev+bounces-288298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D03015502E8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A803312DE0E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3747ECFC;
	Fri, 15 May 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKvY8oFA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877A45BD57;
	Fri, 15 May 2026 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847236; cv=fail; b=mTdITTY5tXYG1UqLl9UeyvjKqeOg83KCf4474Nf55uNOqvkOefO6s2dtzrnTSQgfMWbZIQmVAMgAn1B5k5hzuEI8ggKMzm+EkxXMuYPvkoZby0x1Ek1HuTvDr8mzmceNZN1FyRmZR0vWdEScZrfasCUFFMJQuKu3fZkzrfGp5As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847236; c=relaxed/simple;
	bh=O+LqdvyeSD7oE9VEyS6dLY7ZVSJHIgTvck8QHFaLp10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=routd7HIWchJSL6SjuDqIgGWqpuIWvFFq5z2tQZNSDqHdXC9OANWh9XPoNlRYIw7mrATa1f0PMVXAlxewER7x8TkAmSk5duxz4O16Vs+hQF+TbYtKhrH996EOJHyUKZedRUSty5Hzr4yYoIWJMBjg/tNIwJ4OiQuoYkbXqL5t5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKvY8oFA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847234; x=1810383234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O+LqdvyeSD7oE9VEyS6dLY7ZVSJHIgTvck8QHFaLp10=;
  b=EKvY8oFAx5jJuBjm93FCdxLFKanfQQ84f4Bhr/yXJYAWeJqcD/NompS5
   Jn6aqD1kQEa/WM+3We7b7lMg7uH7ueAANYIkNSs3/ZPfCrQbyQf+thQlB
   uGLuCmjAoM85bv6EnI7oAxP53tJYAl6gAa8LQJVNUqGoTAgrKfqa1V1Na
   YJvx2w4POohcY2R5o9Mfk2vmFpLRN4tCYV0q1AWVxpXeQQ73WyWn4TtkQ
   CUApdwKa8yoDueue4dE/tn+5B9cnSLel13rBxwBi8lXszj+oCodAtu/wg
   nt3P6MDujNbKFYzhoNoOkUpz3Te97cBJS6dbfe0HhLg2qiL62JyEKzEjN
   g==;
X-CSE-ConnectionGUID: Lp6caRkdSS2jeFdGo15HrA==
X-CSE-MsgGUID: B8YfiVDxSHKfsEj0et0+fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90905236"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90905236"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:13:54 -0700
X-CSE-ConnectionGUID: I2fEgyFNRzuXRObMsle1pg==
X-CSE-MsgGUID: 7rEaOtDNRuabFpq7kX1QSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232275888"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:13:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 05:13:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 05:13:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 05:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vlpjt1AgBT92ynd2YaaCkZ2t7GzHM4+qW6s/1wlJHwwKzLmeR/Z4U4txteDzDP0uFYyJNO2WMOaYMtlmC93b6RuzeBLWKgDklrQhbP8O7n2CBgQTbIHbyxLEd9j0yr42yTm8duWqPFL8r6038tl8t1UaUWZ41tM/upHrRfHbaN1wGKFQ/yD6oMcqCXkUNbOW//GBtqrp+ZGcGA02FCMK/xhOR6Y7VxWEMxZB+uvSAINGJ0ObLnjqzJsLfwAu1dq0/OZBepytNcH9jaLFa7ScxRRUw1ElaZJ2STYrdYwVrGW8IDYJS2TLOdh9A5oDGMCrU1FPXObyykjyYqNiRO87kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhRnepgPOxAU+Oh9kciB3pyk8UBMiijxBlEhXYMeIT4=;
 b=Ib/m+Uir52in5KpIqh0S2NuYa2noBo1KKHylFJ12ZJO6AbeRLnm3rFVkurHE/26XqsR9TwLiPdBUdy5cXDCLryvGk+68z6HRfWQK1g9eswwzbyOD/iw2B9ollyScUXuUJJ+amZJnWw5Z89/8k7Nyvi8BSHTbCmjAut9k/zA+bWxtQxwqgXjjZ/YuAilH374qkTpTS7ToWPQj5s6jwv7hx0xBVQcQRlGcHT8sKuwW2Uien4/Kz5LKj4ULpvKVV87itkwVs7DwXwPNcXEicGmYJuRmb+EvNidoU2ZKT7A8C/pbc58FxzXKEUfP2az8LyPADwN3KwjtAVxiJfQhwonQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 12:13:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 12:13:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v9 net-next 0/8] dpll/ice: Add generic
 DPLL type and full TX reference clock control for E825
Thread-Topic: [Intel-wired-lan] [PATCH v9 net-next 0/8] dpll/ice: Add generic
 DPLL type and full TX reference clock control for E825
Thread-Index: AQHc4/YJ+bUkYh6dtkm8AzZ/R8/pBrYPAFXw
Date: Fri, 15 May 2026 12:13:49 +0000
Message-ID: <IA3PR11MB8986B93163E2FEC79BAB36EDE5042@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
In-Reply-To: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CO1PR11MB5121:EE_
x-ms-office365-filtering-correlation-id: 57f66805-6c3e-4577-0651-08deb27b6bf8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info: 2b+cV8ZpI6sOiV4x0oVtXrMRsyZhkRc+vjf7j3qQZRZmFZZ/skOYZ7d8ZQU+NEr5fXvOv5dnk3QK7V4wRy/yv1D4gWGeuUhLQe7k5RIOfDLUTVTUKGiJljRwoGORf8MxLbjODZlwv2mwLz4GcAmp5CyYr+Fa0yq3HMm//CVPy76wOEdG/r9GNMtqdYWibljQoQp3gfTChQbB/jlw7uZOEKBMpP3QljF/eI5qrmM4ytpy9CCsU9MQEtWF80mB93Oskarg4wHWQfJrlpvRoVbPecQp9TECNHzZ21533nezwhE5hq+sAY3snK+EITGmMoC3X2b/7UWXuOqkdMzc/1p5wjl3rTfGj4jh5bp+MboI6dWJ6WxTTgxS0VT0Mls9tToHIfgeW5Nf40aSAhavgmoz3sYiTJScgxr9pIsKW2bS5BaKLIJxFcsgh+4Nv2vuaNrAAuqkqdxZ+RR8jUCeuBqIbvgFoHmGykhwv6gAUZEZ6s4hzaTDkOTUBdTnYkLwUsYf46oJ0cekOfq7CF/M4fnz2mdaA6G0M1mqSrQoLbonMXA5VAyOlegL2MTusIcG/0ogtvkcfdsY1vRieExHDB501ubjHLEUFi4jqwgGtAOxglNfw6Jc+eS4IoxWKNuHOrCpfKJA8HUbiu1gXusmnqiNhVu3lAz1hEQmSuExMvoU7aiP85w+U6zHx5RrRUJQ9ItBSvg7xmsDlV1jaz9Iybi7t0qe8hjQ06JlEnfckYxhWrYNmZOZJpkZk6AndUvDxH1q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kaNMwdDOGjI3+QmodxwbwplmDI90BkSYMkm20axxQ9QfaJpix65fR5H2TWws?=
 =?us-ascii?Q?m4TtKo+FbNSDz1eJHO0AG8gyg7DUZovYgHWZQOHC9oHgzkiWog8d0UkAJivX?=
 =?us-ascii?Q?sW+Z3dkKBPpJwxaf4o9hhmen+UlCnVPa4edKNeinX/3uFIYv8ARbT+rScCxL?=
 =?us-ascii?Q?RbhQqxL5s3FURqniUG6O6osrEPAIfVXeelCZu/XSRBel04AQqJIXXdN54YJt?=
 =?us-ascii?Q?+bAlwuRdvGRfAa6X3KxHoNf3P9dcujcz468/Nvo4bdKacDkcNMda/FyLzpCa?=
 =?us-ascii?Q?cGzeA7CcrsD4bEpwF7TG/dRtwF5nK+1zfQ1VSJ/ZKv7FSnCwxOn/Df3QVRW+?=
 =?us-ascii?Q?SZh50X/hZsG9O23NzV8Hs4oU4przoxlcwQ/Rqn54xoAr5fx/pYgxiRbt5Hf5?=
 =?us-ascii?Q?8P/uiVSa1gjXsPmBj+0LKoYvJzvmtMK3HqNS40eqKYQaPjsCvpP278yH3uFp?=
 =?us-ascii?Q?nUYHAlo813GzMQ7XpJk7DlOZ3LpDLgiWp3RF8soAw5apaokPXyXRJgHxpUYS?=
 =?us-ascii?Q?ZT2WBIomhfzeyX7Pah6Zd7IXYdAAZGX3xTL6hErM+KVOngR3EdcwFEnzCNpg?=
 =?us-ascii?Q?j9EmBj1HrqVr9Eq+NJ4P4k/guh4jfiLCbfR4jyh3DBWZmmKMzMD5IdK3P5XB?=
 =?us-ascii?Q?LH6RBZAolOex+z8n+8GxNvGGg66WsMD/I154u5oYule6jt53x2bTOH0ziH1z?=
 =?us-ascii?Q?gTgOqXit9bhilVkOhEXcw/JE8+lUJPgl44yYhkpX4fCdT86l0qzj3JFEynnf?=
 =?us-ascii?Q?HAjvQH55TsRwMhEZQGrIJJoxQLzG51d+l2mvVG/C3dy2nL8rr1Jsug2RyqIk?=
 =?us-ascii?Q?Uf1/URRylg6Kc0VngXfot3YuXYcYhvY5OqNsJBaQ6KZ2AeO/JO2szvhMQUKV?=
 =?us-ascii?Q?DLr0RTuGpsHA+tXTZNIK48f9yQe7MLuj4tQMtELwtKAXoG0buSuQQ8qI3znE?=
 =?us-ascii?Q?oZ29vBaF4/v/K1XOmhqz6Fewq5iYKU2Ck2sSybYO/aPAFA8FbTGg2EjEGJJL?=
 =?us-ascii?Q?pLOW34rH5gBzwgRf9fQyplkJLl9ZFhjtY0xwYPfyRo9Cn9pOAPYJ4jzya2n+?=
 =?us-ascii?Q?JM1GLKpFp9M/iNNfQ08Jw98HB7kSFRr/dLRfnS1kvC2mcdAMyYJLYYSU4yAT?=
 =?us-ascii?Q?XSdeshYREh4Gtro1fYuSMFj1WPhibfGSXxRLPfzA1wYU64ClqAVgziDZVmiZ?=
 =?us-ascii?Q?a3ooIvC4VUjFPfn8XRHPgW1jfHhQL9Uocx9v7nqtG+GLG7dIFs/R31Hk/gsG?=
 =?us-ascii?Q?Ibtm03gRxRQp14csb/FAdC0MMN859iswXl08UgkActK7tRrXphF+VmGYY0xz?=
 =?us-ascii?Q?Ctt1EIZqtvwQG2lDRzaROMjRizdmrX1wVZGF/eee8ZXJvKfb3d05oL+cWFJy?=
 =?us-ascii?Q?psqc+MV7krqJSt2eLciT0J+Ra186HHGN38sg5Vf8BtQS4tSs4bT3hoZeFsxS?=
 =?us-ascii?Q?H8Fo8otx35rMOs4c7+3yWO/wbG4IqdYNU/QykMQ3Pu0Ekr6sdEa2wl6v4Rbx?=
 =?us-ascii?Q?wUmmlg5TELOEqWqI0dRi0aBXXM8AHGrVOwXpMKyYJmvRcLNYBJcAgLGCcaAF?=
 =?us-ascii?Q?1WlqyXAxyRLgWFna9fde4xJMfbCcArGN1JPvKmiJ4mcZvL7Z6Tasmtsl1vO1?=
 =?us-ascii?Q?4LLfHwtVDSXH2kpyursFeFB+YZ78pJ1O5VePUbsBqwDY1joYDmcH6WIpGEys?=
 =?us-ascii?Q?OrCFlHyguuaccvEeESmrvSpJHXrxCY0AxXssLyFBdh99uZl7TrkWzi08CSQH?=
 =?us-ascii?Q?ziGyIFspInYydOP3anoi+9KczYNYJPI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nG8Gx2AcnPoyGES+ErUhllJiKsvokhmKaI/TswANY+eOjfhLGHzUY+nYwg2UEE3SEqgvUMzepBPmiBsD7YSBHlfxlIgXtAuAWOHsXLw2oqoZzfLxploWLRYXUWhg8IplcfLYvLML0GadthkzibPQnZs3KYBlSiShhAH2v/4LAt29ugg9tazi0FXuVUjuycNOML2eMtzxG1hLeW/DjeGqiNzC8n53+QdUbrqHFF1+kpAUq/pmffUUxOhS2XHkEYT+0tv2J1O0HsvRyn7kWwy2uPDaE1XzVhK7+AyDBL6Fojiv76xJJS04cVVVLhY26STCEgakY7/b/4067AiG3So9wQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f66805-6c3e-4577-0651-08deb27b6bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 12:13:49.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXarNEuJZz4F6WqhHrBEaNKAwaVaytjMcZShkJbuOx+39oHOscpCa3xLRDKLoV2Mj9eFdRPJrUNg15wd2NawTLcXSkfTeCZeRTNYSqqeFC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D03015502E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-288298-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Friday, May 15, 2026 1:00 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v9 net-next 0/8] dpll/ice: Add
> generic DPLL type and full TX reference clock control for E825
>=20
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].
>=20
> This series adds TX reference clock support for E825 devices and
> exposes TX clock selection and synchronization status via the Linux
> DPLL subsystem.
>=20
> Here is the high-level connection diagram for E825 device:

...

> ice_dpll_deinit_txclk_pins and
>   ice_dpll_pin_notify_work() that is about to register the SYNCE pin
>   (patch 5/8)
> - resolved potential path deadlock during driver probe and error
> path
>   (patch 5/8)
> - relaxed kernel-doc regarding cpi mutex usage (patch 6/8)
> - fixed ice_cpi.c header (patch 6/8)
> - fix retry mechanism in ice_cpi_wait_req0_ack0 (patch 6/8)
> - fix potrntial leaving LM.REQ stuck asserted on the hardware (patch
> 6/8)
> - fix kernel-doc for ice_cpi_ena_dis_clk_ref
> - removed unused CPI definitions (patch 6/8)
> - fix header inclusion (patch 6/8)
> - addressed Sashiko issues for patch (8/8)
>=20
> Changes in v7:
> - rebased
> - replace TXC-specific DPLL type with DPLL_TYPE_GENERIC (patch 1/8)
> - update TXC framework to use DPLL_TYPE_GENERIC instead of
> DPLL_TYPE_GENERIC
DPLL_TYPE_GENERIC instead of DPLL_TYPE_GENERIC
Something is wrong

...

> --
> 2.39.3


