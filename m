Return-Path: <netdev+bounces-270915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM/fBt9IwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:18:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C3D30476A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CFBA30D379D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0E286D4D;
	Tue, 24 Mar 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYJIG3sN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF335A3AD;
	Tue, 24 Mar 2026 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338965; cv=fail; b=PZM6LWBiXEUSaDgbPahtXTKoH+eeHxJFUdZJ9tdgccGUU4rXbqTAQyst53UjQfji1xmcVvRhl8DAVd0gOEKMdiXVIXCQe81H57ix90aOoTmYFd9PdzWOSUVqTfTyYnvU+T6ajx+OGBnGUtVXD55PcvRdCAEZKn6zbumMx5bwNAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338965; c=relaxed/simple;
	bh=CJPXrNq6ta1jAyPgSbTf571wT2zcezboBEAsrKUN+/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4JEgMpVLV4snO/U13y1MPXZVY9yVA/ArWtVIW/MsllumG5lV9Dz9kmStawAsw4I9C9UctMo67SvplwaWTxigLJg3Ar9fj91RZT7twD4PpXj9LNOUCzge+aBQs4rZyepK7p3wFi2AlR9qNEga0KdniLe+sC59gdtIpiAQ3WF9SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYJIG3sN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774338955; x=1805874955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJPXrNq6ta1jAyPgSbTf571wT2zcezboBEAsrKUN+/4=;
  b=iYJIG3sNIvAtaEngvsen8ahNrI3kvE+j+wJBmSKlv7TS7StuHbAPbaZZ
   U0zaeP7DpVul0JvpBI97LQoFHdCNDSwL4c3XnT0nwCIy7JtzxmWQsQEWf
   vMDDqAEoawZyNrlM4VcIgUr6hR+SAercsR7uAubDQ+0be5Mn/Aq1GYBvI
   H8lYWwQ2ZiYVBOr+BhK4wh9HPUVQneJCepIBfnCMUumO6pXQc7xr5LIil
   iacLrMAQ1+Ei2m2qEkYJpW0xIyY/Ww7eJ77f55R4e7fE/Vq1y2IPjyc7p
   FQCh71DHYZ3JixSdpUsYaLRqZrBAigScBwX/duaIwVcKzEb287dBZz7xC
   g==;
X-CSE-ConnectionGUID: EoBbYUkUTjyA6ltE4IuW1w==
X-CSE-MsgGUID: HShJMd44QB6GWKk4VOK37g==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75540924"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75540924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:55:53 -0700
X-CSE-ConnectionGUID: 87/tsHczTtmYBmIw6Skwdg==
X-CSE-MsgGUID: 8A0npm42ThKchwTnHSYVog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219390238"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:55:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:55:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 00:55:52 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH/6/5XBN04BHbUOGmfy678Ybldav0nTZ7TVbNXjZou7nu6HrHpPDULJwhQaCsdO+cmN8ETdw4Pt523/MKqSNwpnVSqRIwioLd/E3rkQJJxQjT7ls9ZzDps4VWvO9r/gBdpPwh3ytSdwJeY5gFixTbSPd4ILjEQ+R3/fZ6+2JTxpxUupqaV+cWzT0uiD9Z9NIXcy+aY71sj3kLK1lXpMOWRYOT6QeED6uPZ4m/7ipjoVf0K4zXRp9Fn2uXuBP9353TP26adEepotW97BIMPJ5lxE9mReOuQaS/RpjDIQOvghHDQwFPR2UpHLL++jgpg+vIAMeJQlEMfMKJdO63av6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPaqsmlGPYHW/O6Fg82fc/NPe3BsdKa2E7r9aoSC+8M=;
 b=NZEgJxRGlO72TZKHysgFq9EgR4DQoWDkGDsCc+e9d0lDAYWbbeBzcdHGJ+mM6Dyr7NqS7IMlKsi/PQ7c2YrPEG7ldkLCZmRaz8s3xGhYAlBZwJIUBO6vKTEKDMMwvwYPaJuQ5cuuFAZ1saeAf/1Ol/zL6gJCofuYBd8dgGfT7D0EFMcLI16FRqHK+lXWR8z4T9yiBMwXL52e0SQYLoZNQHurGWPn5sQMKkEnOTe5SrVmX1mony/7ovhTNe2A11ap9LNEHalW7EUzDLgMw4mJnVzqr5CMuVXXb07LvT8NryHlVJdfFkUOiLTLMgxBBKba6wl27tz9EeTEqNA5fLtrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:55:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 07:55:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 06/14] idpf: remove
 'vport_params_reqd' field
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 06/14] idpf: remove
 'vport_params_reqd' field
Thread-Index: AQHcuuxP/bsXXMU7JUqdOhSjzk27E7W9UTXw
Date: Tue, 24 Mar 2026 07:55:32 +0000
Message-ID: <IA3PR11MB8986D038DDA6811114E583D6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323174052.5355-1-larysa.zaremba@intel.com>
 <20260323174052.5355-7-larysa.zaremba@intel.com>
In-Reply-To: <20260323174052.5355-7-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: 7461226a-1fe0-4680-11d5-08de897ab95a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|18002099003|7053199007|56012099003|22082099003;
x-microsoft-antispam-message-info: 6gsHSLx0yMHMZ0qzzW1LoDgSvxPBm/pmz7Gt4FEKQ8DmCwLgJhLplgVUAN3L2/pnZAdodH6vkiW7fmMcG8IkCAjT6ESqsdHAdv+lqOx9FxcXmgJJuT6RMNe2u7zpeB6Z6O+FsS8zlmjU0g2HUpRfQJpjIN2SQqDmNXBQEKAy3RJWei++AEOrDw6RpYkXTQQvuB/0Smu4/ltgyYqZtL+QML2XhCbMJZVY3k/68ZOtOu6FvHnE4ljwZ28ci5CGR/Si7obi2MVvjnBF+6EZRtDcbDa2pVIKKDqoZg1+Pl1NHYGtjccv42KB1s8Cgf1++80dZBT/G8F9X9YVyRbjye/1ivWHJ6nfivhTrl4DI3di3+KD1mEHW1DMn7g+iktMo3ZMOv0UzI3vqtu3MfYcjWRBM4Crt9K5eSBPuh0YNu9o5SPuVnoqtJcpM6YnfgAMgPufTmp1/W9g0Dh9Nw9KKhrHrBWdT5cyPOreMdoqRWMguopQ18nzJmYcDNS9kQtXvdbVvoZtAZAysiOVLiySbbotUv9ye5uxavXo3v7IbJPQzN4+vOd6yAO+P3W2+asMbfcOsHqW8WdNP8Z9DmEIkhkBiJuHSAs3hKP+0Bol4688xVaF5E5mQM5HLz4qq4jXRYsAb3bhdZpZX+afmiNHPuxYQLO5l+8+iR38Otx4TYVOpWBEka5yqN95hABSE0OgFJfRNO8DLc7HYuWiLc5SFobwm6WZZOAsaJJGkrBWCAcj7eaHI9IyfRKtj9F/d8dtTLNpx0TfPRo/YAM29daJo0GThnH2OB9+SpBfvaNs6KIxqcg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WYe5wbJlym7OGtI1mcPNKqU7lTTVWsYKPIlAkRc1fuPpPuhCsR+c3qsb2lLn?=
 =?us-ascii?Q?CmxLs3GbCn1fIF5ieQzy9dFMxU4CcwRbp0+AhCTSW9znMW9r0gLBFd/thwYs?=
 =?us-ascii?Q?jdkQidq/m/H8DhZgqEgy/G+umHBz0KS9pss9fNbhSeEJzGIdBrlNkgz0xq8c?=
 =?us-ascii?Q?Wr7uHKIKLJ83ESEpHac6Ga5+S39VyE5EeTcmMy96ffz1ZHb7/19MQAW+KUtG?=
 =?us-ascii?Q?YUuSZIBSd/KTfgQeFy01XCowLAG2y/rvMajkbncxquBvbmyU9f3anlHVHnBa?=
 =?us-ascii?Q?47Qnp0Dn1e/iaoo5xkv4vW6jagOrln78XPlZBMY830zuwfyKrd7siyBILzbM?=
 =?us-ascii?Q?GOVkQQVW2Ul4/7clH2BIxTNJV8ZbfUKxRe+8LDkxCFNTg6MHTCxAKXiGQb3/?=
 =?us-ascii?Q?OmG3yQ7Kw2VCJetiV1XBZ47aepZII53tNPUf5Z4gdSBPZNcn4BCFpv2Q0Hg9?=
 =?us-ascii?Q?gY6ScFxiUpKaUMobKAwKeVvfatiSQWK4oWmIdrDmPeT/gu6IaBbg2UKLqByP?=
 =?us-ascii?Q?njCF3QtSma1yKYEoc2k77uFFXUJ/Er/bwLEeSuKaqDz7rzpAKNpxsPU9G9Tt?=
 =?us-ascii?Q?B1p9fKZFSlNBdh7TKl2uio4RHQv71BJpCsEqGF2azkpV+LZ9O5W3OsZ0cNM9?=
 =?us-ascii?Q?grlsr9gUcHOyhTG2n90ketiqJGYT9RRsXOjJ5YkNqS8RFiCXfB76FQi40HcA?=
 =?us-ascii?Q?w4Z8T6fjP+qX0tJEV+8u+ZP0AL1OuYpWfbWrYp3nfqQuWH+zYlbNsUz4NIr3?=
 =?us-ascii?Q?ogT0wf4Dh0DdO8PXHxNHw0z+lLpgukw8mD7KFQ4/Jewz/GwhUrty5MbwoUYx?=
 =?us-ascii?Q?QAdc1NfmAtgKKRmB2zsIdHW4MhAxGXe4JI6wPqI/xOCN9xzzDtBdFi6EM0od?=
 =?us-ascii?Q?t/vU0OwyWPXTk2ZCxNq50B0fjuf+NU9t12i3cu1HXBs6twnb7zZiYLZdj9TH?=
 =?us-ascii?Q?nUq2SS+Kp7VYH5U+uPP0zKZUihMd8fbuvJlPTc1ur0EC99+jwUL7ETrDgQxz?=
 =?us-ascii?Q?6/XUyqcABPpanV1YnV7JA59HZT3xmy2JftNgjUwjPJ/nrcOiIfmBTOJXb3Lg?=
 =?us-ascii?Q?TEyCvSz6Kef7Cx04VnDj73LBMPyqhL0RaO1B/FLR62vykjJlp8/T+pQOm46b?=
 =?us-ascii?Q?w7M9qsDpChIupP+uapo3F8zXNX7/FNClCICG/iJ1cE3utUoJy+eBx2sEk8WO?=
 =?us-ascii?Q?jGxIPv2Rg1lZtt+GNUwkeeKMt7+F9KgdSsN7KuE62+LjqAgfdNj/hz0/NY04?=
 =?us-ascii?Q?Yy7dfP/SIvgzrRCTQqqVQjxv9dHtBAWMJXBilxQLmWlBp5SxyAi9uQLKXwP2?=
 =?us-ascii?Q?kPoCNHDxLMD8443NIASazkVam0pODI5g8b8W0j8oZuaO4cxI/eco6xEki470?=
 =?us-ascii?Q?eSZNZtjKmWgLgJywRJClzmkgJilwQGkkbUHS/nX/KE0qOzk3O2YntiORFlez?=
 =?us-ascii?Q?bQMJmKfJtWb5Q6CKTbBLzfP6Ugwc5fGA9jadvMeieQJABFrI8SaXdahX3zxi?=
 =?us-ascii?Q?CqaqC6jiSmDTEyjR8b2AAuEdDIUc9sl6OZv3eN319RWLhOuGZAN+WngAatCc?=
 =?us-ascii?Q?b5aaP4dxwlM0wjSkS3Y8HrdJsBZdfDshYruazqRilFRY2mBskKwYhTiuhWYN?=
 =?us-ascii?Q?gGPZnnTa4DrAJdzS5Hq+GfObjrEgUPN4967C8HPGGEWIdc/Te3Elh5KscrtQ?=
 =?us-ascii?Q?c2qnwRz3+AQLn2LAZw+RduQMruVII/NXcqwgSmoJW+YSDiODf247Wh3p7Bbh?=
 =?us-ascii?Q?65qmEB1uKpDapPg/MfVFykQ0aMafq+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qf7hZQyxAvpwrpkgNlTYDtSleY3l3s5XMO9VkaSqgQe3aiivwnO6WYJgGGlJJZzyKgNycf2XHcjX1atTIrHyCt/Yn4a9WxuTTEHkckOAsm4+48B57LwFnlR5d+OEddzUGiPgjYk7lWmWUOdusMaQcI/i17EfCTmL2DYR4duT1GksckxOgJA3N5jjvspQavvb1RpGFGnsteRmpXjoVlPzUAomMJvuyq6/skHW9YqGdxeHastt3zGAdCm3/dExZEFAKh9m3uA8iea9OypP8YJrFdGYPlb/Dc0Rzie64oYS7myq0ekBfinEjjQ3+JdEfXYsU1JHEfEkvOc+6JEawujeqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7461226a-1fe0-4680-11d5-08de897ab95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 07:55:32.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6EPEEQs+rryKy9gTlYCPSShmMPeurFndaB1vMfE4RX8kzVIb4TWhWmAUK8vV/26v0HjekWr7+gaGMsmYiIdA+ulIUGPJehcN3tZ09ldKeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
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
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270915-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: C5C3D30476A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Monday, March 23, 2026 6:41 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 06/14] idpf: remove
> 'vport_params_reqd' field
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> While sending a create vport message to the device control plane, a
> create vport virtchnl message is prepared with all the required info
> to initialize the vport. This info is stored in the adapter struct but
> never used thereafter. So, remove the said field.
>=20
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  2 --
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 --
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 30 +++++++-----------
> -
>  3 files changed, 10 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index fe6ca5fcc5e3..e717f8097d23 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -638,7 +638,6 @@ struct idpf_vc_xn_manager;
>   * @avail_queues: Device given queue limits
>   * @vports: Array to store vports created by the driver
>   * @netdevs: Associated Vport netdevs
> - * @vport_params_reqd: Vport params requested
>   * @vport_params_recvd: Vport params received
>   * @vport_ids: Array of device given vport identifiers
>   * @singleq_pt_lkup: Lookup table for singleq RX ptypes @@ -697,7
> +696,6 @@ struct idpf_adapter {
>  	struct idpf_avail_queue_info avail_queues;
>  	struct idpf_vport **vports;
>  	struct net_device **netdevs;
> -	struct virtchnl2_create_vport **vport_params_reqd;
>  	struct virtchnl2_create_vport **vport_params_recvd;
>  	u32 *vport_ids;
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index cf966fe6c759..d88ca59edf97 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1109,8 +1109,6 @@ static void idpf_vport_rel(struct idpf_vport
> *vport)
>=20
>  	kfree(adapter->vport_params_recvd[idx]);
>  	adapter->vport_params_recvd[idx] =3D NULL;
> -	kfree(adapter->vport_params_reqd[idx]);
> -	adapter->vport_params_reqd[idx] =3D NULL;
>=20
>  	kfree(vport);
>  	adapter->num_alloc_vports--;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index d5a877e1fef8..6e6aa38654f6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1555,14 +1555,10 @@ int idpf_send_create_vport_msg(struct
> idpf_adapter *adapter,
>  	ssize_t reply_sz;
>=20
>  	buf_size =3D sizeof(struct virtchnl2_create_vport);

...

>=20
>  	adapter->vport_ids =3D kcalloc(num_max_vports, sizeof(u32),
> GFP_KERNEL);
>  	if (!adapter->vport_ids)
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

