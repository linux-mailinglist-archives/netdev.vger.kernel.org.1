Return-Path: <netdev+bounces-271898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJk3Cj3gxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:29:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BB330718
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F87B3026064
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425738839E;
	Thu, 26 Mar 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaKwznjM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E802734DB78;
	Thu, 26 Mar 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510053; cv=fail; b=uzeceXre9rB/ldd0zTGfuXyw4Lx40fJP5eCnCAv+HVDyFkqL9fRC2S9YzoJq7o8n/TxUIwIkXH5yKhgSjqzR8z/aSfJF9OQ64WSCwHUmi6+aTG4u8o4wVP6YFxAldsCKcy2J8gPniJbVa6ydsHrMU5tFb/spD6e8SyKMfHMdAbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510053; c=relaxed/simple;
	bh=v6VQNC5d7s92TOyzJA6m+/yRuXLdzvyYYc9583FxtC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yy8KU4KD/a+yyk5JyCq+M32mKJOCnT50htEqS6h6AGKCekixwo5qOVXZzZqg1kC1On0ecZyPOGvPuVOYpK2jYqg+1/Jh44kfAC9vRXb79ZWUZs8XvgmxfkPsuDW3bZX1m56IwGTgCZanMp1hnVK+sm6poVd/9L78P252S0esDoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaKwznjM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774510051; x=1806046051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v6VQNC5d7s92TOyzJA6m+/yRuXLdzvyYYc9583FxtC4=;
  b=aaKwznjMctjcEykxVR9AeU47F2vhMDzVUmXymEjf2iytEJUTKqpcZgPF
   9UpbSjYq8aSqzDOU5uff6l+gq/TmElW90xWOO32hzf5QUUtptAf1sBv6q
   R446RjEm8Ud6IsIUBsi4oTpy5Ux118Nwn0uJXn6j8CukJ8keMndF/N9lV
   z/XkXCG969HfyCYI5sGCZZD26I1jJ8txK0Rp88hbZEemSAL33ahjUsG+c
   aj6oZAhpaOzOwXsHjyoXnrtUG3lka2vIilmQl4QzhR19Pmtfv7oJBNKy+
   M1WjdK1YRAHFT/JiO3ikHhrIKw5butwiQEzuSAcUJlknRl2ZFkoE7H/WH
   A==;
X-CSE-ConnectionGUID: jUUDJlXCROGN2gKAZzDZpQ==
X-CSE-MsgGUID: hZ8NN0YtTaOvTUbBucus0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="85866293"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="85866293"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:27:30 -0700
X-CSE-ConnectionGUID: 3JPz2CrbSwW1NXatHREkyQ==
X-CSE-MsgGUID: pp3HUVoeQ3KTNMoIcoTvTA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:27:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 00:27:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 00:27:28 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 00:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOQxY1B1J3nh5WZs/U3ASvKs5dWEhrGsfbBWjF8n2iVrNBTy1tf518bdaJ/hzVOCT7MyJ0FjqmpCV2bUlY76E+t6hP+FUwZkOkt2CN7BoKPiApQ1avWjTSjVPm6zvLmSK4XTiwRuwffXkLEoqoRUyEL9l/xBeLTYQErWXYBh0y8lgIpMQNdqNnsf0tKrp0Wrz+Pz5g5gu6uak6DAUDcjzPhROkKBTg3lknU4xpTJUcjyUV/W9rw5XR1ql4Va9KByRoodr6GcYzu+CRKy7cdaVGfALxKh7BJfSaqfuyRNCzrQyBtzexju0dtxh9hOeeAVlP//qG/ebQ6copNFt4PL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYDoPvDSymALwoz1WQkdpn7PHpyhtSKnbdef+nc1Qd0=;
 b=eFkbjJk4Qu69g41DOlyXEQ3Q0cVWI9GOEAZwpk1KqZ0DXg5CZ+xqCFcCpZ86AM6UYLbFc99LFKXxXQv9VpOWBwrRCjXIb1Hw5WHOAkoNt2St+WMm5Wgwarnfm18k3R4Pi4t//72bB8Y3nrySws3jueAnLycQ8QVRMeRKh369l+PwS3NYwgMQzY8f+jGP1PFmptO3xAv3FKQE2VHRmLa/F+lxUsxnXt1wzkgW5hjom/D7tuQuaUF5J75ZIVd/6KOg0FNLYYD4Du+aiqwZhmyxuRSDmWgMmNObm7RHm6K28jRUwj4zaKrr8rBmAGLItfvqy1m/5F2pb/uYwsBINGPbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 26 Mar
 2026 07:27:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Thu, 26 Mar 2026
 07:27:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michal Michalik
	<michal.michalik@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix U.FL pin state set
 affecting paired SMA pin
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix U.FL pin state set
 affecting paired SMA pin
Thread-Index: AQHcvGmwRfb74f8xCUivBRi3uN4wkbXAavHA
Date: Thu, 26 Mar 2026 07:27:21 +0000
Message-ID: <IA3PR11MB898670E22CAA3D031CA1A177E556A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260325151050.2081977-1-poros@redhat.com>
In-Reply-To: <20260325151050.2081977-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM3PPF341F90799:EE_
x-ms-office365-filtering-correlation-id: 3c8e46e9-ca32-4057-0a48-08de8b091e9c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: TAtnt/2nLEzyNlnG+OAWioX3yEq/nj3pRqJYUMvQr0okzfzPhbbjqPgX9fAVQvjZgHXtsR/Iv6fm4wffUu5tGmAqBPELrgZE/gMvg/ekbTEWo97HsSy9lZjn7odHE5abdqcyPMW2xgfqJHi0RfpMaecu3xqupA0+KieBU6jdQZDaOD+uOhpCqUOfW/niFvFyxGav0UWVs+T8m40wLRkavwG6HaUkue/EUb6DRCQh92xKAq3KtA+LRj1E+blT0FXQ2mfeCiygv8E6WKlP0gLdZFKuK1fLHm5HWsnYdTHmjyZVpaLhXP+KY736PbtmzXZGVMf1ulfQMu6mf8WK1ITaVU75Ov7cpB+pARblkqL2ePqhIku1Mgf1XMp81jZRgyVDW0Vb28rvNj11KcB53KLXzDt7RZCA84emQEbuq+0doKMzNizgCxfM8iAt4rLVCzCTQgRB+rmLocpqfBnU6mvY/WNtv/zgaxGFx17gCjiQzDZk3OjjBdvIpOkfvf6mWGciBjg1JTMTwi0b1FpuP8TPt7YUbsUMCllcjyqsp1EW5r+ncXpMV0jSVoFOmmv9cp+8V89XA4S5pdPEAebGdpiOzzQfYvVgByqzG21EXlJX8Ht8coUaLmuSb1iN8RM8MBAj06CuPPicHGO9MRwTf3MxHU38SUv5/P/0+CqA+3w+pkS6Kg7jPAjieep3A8dFAlPGRq4p7BUPbvvbMTDDikwA0pca0yUvGsafA608qyxntEr5Z0g+7vFr/QW2B3RNzhBoITFRzHawRZFJV4FqxS2CMmrQ7H+G9fS0dkuT/a0WnAI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y+FRXB5KZwYSeHr9udqIeqCX4Uo6YNtePPc/rgaVqOPC9AyjtVKvIk15tsDg?=
 =?us-ascii?Q?IUXd+ILfCQWcec6gP9HA4ZWtM5cpnVhYQTk5hb+Uh3ClMLLLLqITyk2kHIep?=
 =?us-ascii?Q?bKjN8UUbAj27lxbAb0NfoIeAf24UA1p5GBTHFwM5YpkhKXqFVvq5rpMOgA4V?=
 =?us-ascii?Q?NFV1U9EAyaPU3yRJDcTCa6RPZ8l7t/qJ6Bf6+88t/6JIbjYorTEgkziV89Is?=
 =?us-ascii?Q?LB8a8H4n7u/P5K3XhDh0lF2xqVzcXDUjfjU/uwVkFMk7dwi7AMzjaJl1Dbt5?=
 =?us-ascii?Q?BS1qPoSPe+ZPLK2/9PYOpOmQ4Bk40bIDaFcazIcl+ZRrmWPoapjlsoBZcJs+?=
 =?us-ascii?Q?LQ0UEuKKfVIsdtn77lcLDTycQfINEgrQwpC/cLLuZQsIzah1eAc93JORx4U7?=
 =?us-ascii?Q?LoobRZz5ZkO1PZtMJVoXjVtj4NzKJ/72I2TC6kRRvk5GbCATn8Yf2XIjeBSS?=
 =?us-ascii?Q?Z5IaPeCJFIc/eRHFXTCQyMEerSYbBdDWXlYSUy1M23kdXBpRHqgFuFbCpvlY?=
 =?us-ascii?Q?fTs0seQbVrHGK7rnip/YJ4fD80fyhu66Klw0pOJ8S8XKz0CmT+W5d8ubO8fE?=
 =?us-ascii?Q?TrVKawbt3Q9OIRqF/VUW//UYaGUwIN40Wo75CpEv5Yh5Ksesr5ZCBUTkJU3Q?=
 =?us-ascii?Q?aFwUJH96fuDgBScDZNuWz3cpREiuOVrOiFBEW5NExcoPUcsA1NyMQiWBm3/B?=
 =?us-ascii?Q?hqwmLcwJYwXzFztorDMXlXR2bgtPOxG9S1TuKff2Qd+XQurF7JOOklyLjwnY?=
 =?us-ascii?Q?1XSePEPSLhAhtiZRE7YfVb+fYw05xRyagSfHTz4WKiMZlXo+LZVDuTnchfxa?=
 =?us-ascii?Q?yyGL5o5tBkeu9BwvDG3S7P9fO5CYJY/N2WiYRpp3d6bENFj4jHU0Qe4GH7Qu?=
 =?us-ascii?Q?LDqOh3QSyYW+Ky2KsxiG2xEhAc7p9W12CYrObjiAvO6vHNnHCSfxoDXDLR9M?=
 =?us-ascii?Q?Epsocx565ZE1TV/vywqEJV0tj6rNBWuzh26VjOaXW5sjMVhbRbwTEO5TO2aq?=
 =?us-ascii?Q?OkQH7oPY7fIHAIq+OkDLy+4FY2uYgTrXeuYjwcQBWGyemlqBvsZExq6ADgGc?=
 =?us-ascii?Q?G15QBd6J+th0hVfefVHYONr6UiWIYZXVRV106uKFZvYJ8sYOZzzLLBuQO+Hn?=
 =?us-ascii?Q?HjHWu+hAAYSR2x2biP89b7GnS8fiYcF8uF6hwoRJvN1C4+bBda0DHSJ1RSY+?=
 =?us-ascii?Q?ZVtaiZSF0Qj9Wh3TvwJ4t8PrV6uQONP8Jpx4bajcvwLwb4V1N6NRVbKIGJjn?=
 =?us-ascii?Q?wWz1KBZc5fYSlOPorUrxWkFBrASoG0kjLY7P/rxQBnRqAfmOWlivwhNYyy/O?=
 =?us-ascii?Q?E2wZQvG3I5CYlGXt/aHSmLbvETsXiucZqud5ELs0ps5EtdDinndTZGZNBL7N?=
 =?us-ascii?Q?6QDTfZoE7520xwkweIcCghtKb3ljwrEVA+KpLtzuM24Ymh0s6VoQ0RZPJAX9?=
 =?us-ascii?Q?MV1KOZxBzmiU61QZ7eg1Oqmz2xgVuE6sbmfgVdEqsI7GyPcjb+UfeijDJuD6?=
 =?us-ascii?Q?Ame4+sfKnhZswRUOUEnopgRFjrzQsQkKH5ft240Wbo75RSPJCmYHhf30HD09?=
 =?us-ascii?Q?+BEqtzov3VoeD0v7CXdxJdGcetEzrZOeGEkjkW0v5bEfhR0pAGKWxbPkspHf?=
 =?us-ascii?Q?v5JHBVyfUIRW6akgob3pgMPyRqO0l9AVIXTYfP/EYldPKxAqLCVQaJHB5kTZ?=
 =?us-ascii?Q?4EqOdOiRb3NYiE7ll9JE2DaDpvHFE+krM7gNiLqSJuyBy/VEXWU9INc1Bhs/?=
 =?us-ascii?Q?L9G80j61Q5VZBQ0z2PiWBcnblE2NQnY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QoMCeDfwbf7qojOy3V6B5M577FEHuJ72w4RSdRBCPI37OQgo0VXT78wVpAf4O/SAwHiPWdo2n4MEJpcX3BLJkRnyNzYswg5OEoO7mLWBZ5uQUJC4qLVAUwR5kTIdDj+bxkhtm6nSA40/22L/8B3mmUsQ+aTCUGUaYUg9sPw+j4YSgn7nseacf7pmybH8VSVz8IGpoCualvRwEwKKCJyTT48O4uYosnl0B7cAi6Iy0MO1lR4KenrPqs6/uL0NgoNIvtOUIZNkpn+ZjeLg7tTU09tGdRXELmtbFjoI/kTFpUTgGg0JjOMN1UY1h418e2AdOejp3aRQ4uGcp6iq7Q2MiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8e46e9-ca32-4057-0a48-08de8b091e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 07:27:21.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaodmzHroEbVwtBC8T2MzAfmo1qbDEBsFu7JowvnAjOCBD8AoZyhOM79r0El5Q0C3P9KjOWC5xHzKoVHjT/Oon8XFJvjFgFtuOI8Iya8ky4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271898-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osuosl.org:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 376BB330718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Wednesday, March 25, 2026 4:11 PM
> To: netdev@vger.kernel.org
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>; Michal Michalik
> <michal.michalik@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; linux-kernel@vger.kernel.org; Eric
> Dumazet <edumazet@google.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Olech,
> Milena <milena.olech@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix U.FL pin state set
> affecting paired SMA pin
>=20
> When setting a U.FL pin to disconnected state,
> ice_dpll_ufl_pin_state_set() blindly modifies SMA control register
> bits and disables the shared underlying output/input pin without
> checking whether the U.FL pin is currently active.
>=20
> SMA1 and U.FL1 share the same physical output pin, controlled by
> ICE_SMA1_DIR_EN and ICE_SMA1_TX_EN bits. When SMA1 is in output mode
> (DIR_EN=3D1, TX_EN=3D0), U.FL1 is already inactive. Disconnecting U.FL1
> sets TX_EN=3D1, which combined with DIR_EN=3D1 causes
> ice_dpll_sw_pins_update() to mark SMA1 as inactive too. The subsequent
> ice_dpll_pin_disable() then disables the shared output pin entirely,
> breaking SMA1's connection.
>=20
> Fix by checking whether U.FL1/U.FL2 is already inactive before
> proceeding with the disconnect. If the pin is not currently
> controlling the shared output/input, return success immediately
> without modifying the SMA control register or disabling the underlying
> pin.
>=20
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 5cfa19da099bfc..76c68f54a1cc97 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1253,6 +1253,14 @@ ice_dpll_ufl_pin_state_set(const struct
> dpll_pin *pin, void *pin_priv,
>  			data &=3D ~ICE_SMA1_MASK;
>  			enable =3D true;
>  		} else if (state =3D=3D DPLL_PIN_STATE_DISCONNECTED) {
> +			/* Skip if U.FL1 is not active, setting TX_EN
> +			 * while DIR_EN is set would also deactivate
> +			 * the paired SMA1 output.
> +			 */
> +			if (data & (ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)) {
> +				ret =3D 0;
> +				goto unlock;
> +			}
>  			data |=3D ICE_SMA1_TX_EN;
>  			enable =3D false;
>  		} else {
> @@ -1267,6 +1275,15 @@ ice_dpll_ufl_pin_state_set(const struct
> dpll_pin *pin, void *pin_priv,
>  			data &=3D ~ICE_SMA2_UFL2_RX_DIS;
>  			enable =3D true;
>  		} else if (state =3D=3D DPLL_PIN_STATE_DISCONNECTED) {
> +			/* Skip if U.FL2 is not active, setting
> +			 * UFL2_RX_DIS could also disable the paired
> +			 * SMA2 input.
> +			 */
> +			if (!(data & ICE_SMA2_DIR_EN) ||
> +			    (data & ICE_SMA2_UFL2_RX_DIS)) {
> +				ret =3D 0;
> +				goto unlock;
> +			}
>  			data |=3D ICE_SMA2_UFL2_RX_DIS;
>  			enable =3D false;
>  		} else {
> --
> 2.52.0

I'd recommend adding Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

