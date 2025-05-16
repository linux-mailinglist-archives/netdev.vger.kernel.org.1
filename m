Return-Path: <netdev+bounces-190945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF11AB9674
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781E64E4FC1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9422617F;
	Fri, 16 May 2025 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW98gbjH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F7215F56
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747380140; cv=fail; b=H+boPlhnQ3nTmHFnPa9uuxgwFRH3e2EQx4IMl/gMDcI+P4wxT3cAMm3H2wk4bukutWnYCjdn/qx2jQqGd3Js88OaHhtCHVdV8u1AuKPLPSQjgSMXyDC3TG8trQ4cu8wA/5+3nDdHBn9kVcMJH6ush7WyhSDyQWl5m8XONhwegbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747380140; c=relaxed/simple;
	bh=g4bVG5HxwBcFnqG7gE1bxZHJSox0TtzPRHP+pwTb5Vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=femg4V2LhhbDnfzyIbrEmYG85k9hg+DMQZqcgQzJJHfXfDk+24INpRtbEd/EkKS3nFIVbDLGpw7hZUeL+U9AuRxY+oBCc+C6ExbKMY+f71sFt5FWjDcH67H/dgxanzXckYczfhH7KDEtXIX4Qb87UXK4ZFPokQQAKOVRZ4avqiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW98gbjH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747380138; x=1778916138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g4bVG5HxwBcFnqG7gE1bxZHJSox0TtzPRHP+pwTb5Vo=;
  b=VW98gbjHnP7rNsPnGBfPfMGchLl7NTR/kJ/W1IIqMSEcimSrO0AsAVmP
   EEOCxs5w7S5tiwGgvpRpxIzHY/OHRO9bK1KMDylCcZrKQRTTXcY4bVBdU
   YCsRAhen29ZALzsUnks7ePNx4Ru48DSg816jSSRltxyrZFuYYoC5uufq9
   krRu92Os2Zs+UlYUtJ/H6jJyn1Qm97/R/5K/3TevlAXlxbohYfwQ8I2j3
   EqtdkBhKmnvX6ZCzIN23PcJrIYzI4rG0/pDm6c5TytBW7cJxW25UH3RNA
   PENHh0jekgpkTKZFcYoSwut0GTnGyZ0ZkWZSX/AdGTrUjNTI/onZKKD6n
   w==;
X-CSE-ConnectionGUID: JH8dB2bqSlqLnxR5c7rEqQ==
X-CSE-MsgGUID: ay7xK2H4SFyWBPpGimWZ4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49450479"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49450479"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 00:22:17 -0700
X-CSE-ConnectionGUID: KNRIIZS6T8WhzHwaioqiiw==
X-CSE-MsgGUID: JUsLmx3OTle5segi3tx6Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169546412"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 00:22:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 00:22:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 00:22:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 00:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTYMAhJP6j4k7wM3jNwrxKw+6TRVhFkXJXq+RalD3WfhxVxE+bLybXkgggiVJW6ikzh/qXRWu27CWgXSPjqElb8WxIomODVeP0T04i9zWKK7hYOJ7SNY8JsShRzP2Mp9shSDhCWO8lqNlsVwY3gVbIExxVedO8fwnJgQhci/BFKXIlqqyQt+5V7GbQCHJssQkV7kbzm4aM8eXfmElbhhGQQcTYd8ZRU0dFGpNA0PCMjwLxStqVlMeUmvPUorqMlqwpaz2C6Y09ySAkyx1NTuRFLCex+QtyGFeFi/79UgHXQTZGgxAD4CTdimuL1kgu3Ur9i/qHxkC62n+Wp1hlj8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqIwQJoZmyIuclJuGnxkcVbgJsvq0yW6oQsX4RLAPBY=;
 b=RY5oaKSI+CjAMo1Z6Xb8btRAcYb/TivcnLPvjuZ1r/7brxf3gFQFjsiNj8D2u/uVPt4WpUuzgVE7wLNh4dJUaqqS/C1J0JDTiTdgeff04z7o5CX6yjJAo7nssqiuShMBlO9N9Qxl0Gg9osRZRY/UzYEzs0s4gRaxUxhTkPjdyuyGsMTblOo0dZW0h6sLTswlOp5I/cV4l4+K3+aV5ulF8RlWFDlpel1mU+Of9ZCEsDqRgZ2mnX0/RqVboybfhAI5lzeeeeO9EIt2jxrF911XVBeMZheSWNvcKXpjsy6GuEE5CnsscNA3EnqM/Gzy4rhFB1uFNABlbjCLfGJ9MHfvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.24; Fri, 16 May 2025 07:22:11 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:22:11 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 1/3] ice: redesign dpll
 sma/u.fl pins control
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 1/3] ice: redesign dpll
 sma/u.fl pins control
Thread-Index: AQHbs6C+jKxiccv4tUekpyedx9nR9bPU/F1A
Date: Fri, 16 May 2025 07:22:11 +0000
Message-ID: <IA1PR11MB6241E932E1B39576E5846D128B93A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
 <20250422160149.1131069-2-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250422160149.1131069-2-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM4PR11MB5969:EE_
x-ms-office365-filtering-correlation-id: b0678ba3-eff7-4e2c-2e17-08dd944a5feb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?o7dujo73WFLZjan9n5FUc1xwftnrHcEBOXHSFsr18HVAFgysXzKTuyZumP0p?=
 =?us-ascii?Q?cfRwQZb2x6M6mukn+oSZQsue/nIVGf3g4o+T/kHoRbfqOX5+AXOyyxIBIcBl?=
 =?us-ascii?Q?5/lm1q56bwnVEaIu+v737vkF0E1M0uyEHxO/rMCd9khP+UKVBUFYUuI94ixi?=
 =?us-ascii?Q?KiCycN2gzze4fv/CxxxE+QoqN2w+ErVNjSHEK7d7CMhzfuauAZ2/+cQ7mKPz?=
 =?us-ascii?Q?s9Noe8ySQVduFJrclAZGrxIA8xA2HLn53Q7UeBvWO69rpWC19Y8OxWMO4rlT?=
 =?us-ascii?Q?gUtxUg1SVkW2qFo5EUQQvBFuh/7HgXxDaVfShZYqfTiCdvve2QJCsRDXzdz8?=
 =?us-ascii?Q?5qZF/bBYJDZejfPPix2vcj5ldYBpfpYLHd26hrPL/8n5tnqskGrz0d57vPMj?=
 =?us-ascii?Q?ixDqPQMceMImg5oTGuFN2DSlOLNs8hsfK2IuqUPO1+5kk/RXDjpVp3f5hfcl?=
 =?us-ascii?Q?f2VrHJengq8KXdNShXSOUrLsf1qEyVDpnBMFamAu4wSXwV7gRYPb3NrJORuE?=
 =?us-ascii?Q?PT2tnAzxXQhpQGS4uJq6aRYp3hloiCiJbVxRTkZypsGibU6/YzkRFie3D38a?=
 =?us-ascii?Q?uhHmRrjVm9eUCoRLlOCei5E+OmXJn9pr++XHaNAo95fDcg330lzqdnp9gXlf?=
 =?us-ascii?Q?iVNBxBSxJZyeikd0RrKrEP5S2vMywxLPpAl/dg38/aclSnOhCrmP9yBoXXob?=
 =?us-ascii?Q?G0pLaXB0iNZyVnjeYKtll6t4tspjo3hX34JA+IGb20sBkulkiAzp4Q/rWBQw?=
 =?us-ascii?Q?72jVZfCFSw/j2UggZ8GvFHmtruWDIh2VGu6PaLCRLITJMcLQwcAA/HWqKa76?=
 =?us-ascii?Q?dYo0vlHXvWOBZ17vBLqzi1gbsNOt7hB01pvjWZQqeiZXL/9yt1xtaDBKPRxc?=
 =?us-ascii?Q?NnfnC7pZba5n3Pxu3dx1RCMzK+U+qwOupIXyTzKi42AtzcQfKzl5/2jUy1iH?=
 =?us-ascii?Q?0J92m1Sqr/UYNACZrdWr0YFEdkWP/fJTznSS9XO2bejmi5MTYBXbOCCLKL6M?=
 =?us-ascii?Q?U4YNrb/i2jrewwP7coxEeOqAdRgvvt7jjpETpri+Jualp0Mbo2aJXfqYNzea?=
 =?us-ascii?Q?2v7aYsA9YsP0x2jizMZG+7qh/3L4EqUApgTpQuJNgMkrXLJ79ZU/ue03STL7?=
 =?us-ascii?Q?jrcilIsCadX8+nXC9kDk/CBCS6N2P9CSw512RJVFVYRWLtFm9cCdG9t94jjZ?=
 =?us-ascii?Q?U0DYXIGJlI5hqXJ+7KFw6291IQvKQkQ7lEIbuQX/O5KKDeB10R7WVjniyizD?=
 =?us-ascii?Q?BsZ1nbAuHuMwb9XLzC4PKLzkOTWgrYrUoryDdNXj/UuDpM98NY1q2usRotdI?=
 =?us-ascii?Q?qj76VKRRkN9ypp8C5/sw9y+LZ0Neu3BN4oUvFeftC+DWusczMsn0zu1jxynj?=
 =?us-ascii?Q?pUi4HMWGcIdBGSW1D374fCmxvacBN0TIkn3cxQmi31APdWGFTlFv0kXohb8n?=
 =?us-ascii?Q?ODHOd2jkmedbUwf9+tVEMK/erJHFxcVxkuGQnkPBy6MQqXnlnfihEEnmN9Rh?=
 =?us-ascii?Q?frai1rYAf9faZyY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4e1mXyOamsyndWO5BYiiRUWQpmyD1u4TbqxI2dK7OKthOdwfSzayzRRyufa?=
 =?us-ascii?Q?wbot5/u3l+2oB/jnWfJ5c5wd0mJh9VPN6T4D8atJavrRQnJSuUCg3KxqICil?=
 =?us-ascii?Q?rtJ7IrvbxlMptjVVZx2P5TRuHuLDygEt+PrRjIiB4ZpEHQWikQTBlAEu6tZm?=
 =?us-ascii?Q?lZVYl4t6C08WzLELblJVnDmvF2g2ZgmqQ0kfE54UHpSDsSZp8ZJK2b9xI96J?=
 =?us-ascii?Q?l1hsYlxtaZF68qWZOcI49mJ8J2i0+hlwNY67r9ngOO4uF41pIQSW3E0MuaoO?=
 =?us-ascii?Q?ULlo+7Dt/JoS3VftBU3MrJtZaDevYHgRDX4ElY6yWMiJPWZriWfZ62eQO3Ie?=
 =?us-ascii?Q?Li2tVAK0hkr4r5m+L4p2SxH03tFQDaHeZdSdyrK0jMyU2VwYO7Ll6A1Y6NgL?=
 =?us-ascii?Q?l3ev95ARwOtV4hgL6PS2JDS6OpYHu+1xJSBngWXkwSHqa/5wm+jlnlEspJy7?=
 =?us-ascii?Q?ZP+gQVw0VvbX5ZnNhBlCNv8aWMtHu21xHwbeH1YZ0bOOpQ3GgWTlLg7uwEBU?=
 =?us-ascii?Q?jYlFSzcQ7aLFF6IXL4rIAzjhKg81OhTSIROgOnqbWjGY8hZcj4AyHuRcFj/I?=
 =?us-ascii?Q?kEgXv3W3ZOXWbNzcQ6tHzVV3p1XrqCb3ugdpsL5Z8fBN8zRI/JMWr0atQuct?=
 =?us-ascii?Q?yJT57n2RET/vo/oqpofkTc1tlKC58OIrrY/zdcMYPOK6iLoNNAUWGX8bN34F?=
 =?us-ascii?Q?0eOkHv16lgJMBVi2IzfvLhwUJeWhB+CuciY7x9B8bwa5DFXv6+kEvbnp68Lv?=
 =?us-ascii?Q?E8f4gYXv2dpHxWkZ814z1XHWYFw27lLxh5ZJDl7GGOtjT1Fh72fzuOo1LFAx?=
 =?us-ascii?Q?cS0LZ7W0Y7F7K6KeBCSAmXmryHJYEO0sAaabhSp/3HFC6GuhybZjfUDykHDh?=
 =?us-ascii?Q?Glmlrsyd/vCgLsKRgFwfpNKBpwDdvXjiaUciqn+X3TC483qzcqWysqrrE+EO?=
 =?us-ascii?Q?xUuo/pIoTYqVJ7cMjTsbXTE6YtpiVVbz6wKzolkdxKdSeyjKrZrOC2YW4i55?=
 =?us-ascii?Q?gOQjGNFCSKRFIB6ggND9O6Zs9k/LOwZZk4veJzGDgVVwx8WiIuZfe3FY3r2B?=
 =?us-ascii?Q?i9uzVKxegjVBLP39trGL88aVzDJ9I74tz04DVbFMjmTbvBKb+n3L7WKJqqGS?=
 =?us-ascii?Q?KWfbeG3K0ZPvzGg6hrulHscMMiqidsR+QxhNCZnL6GIlfJsR8NOuRZPxe8L+?=
 =?us-ascii?Q?EiBHshUtmR0oNag4zcQ0ulhlBHPiDTHmSivJNjD0bjpj2wh7XZ6qumWa8LmC?=
 =?us-ascii?Q?poRPz7Wgq24O7WA4bD4KqNyOPZZaL/jxGf9jkNtLs4EDBaznVrJ7NGe+Z1Vy?=
 =?us-ascii?Q?EbtZ+VdBwXO/fG+tCSeOYqOcL06S44ZKnxX5j5FZByV/4uW9e8OlZgbHEbh0?=
 =?us-ascii?Q?I0r1FlBRoxxurdBpLOiW0cXqA4HdhRXbn0Eo71Kl71K33CkCD1/4cr01QFc8?=
 =?us-ascii?Q?c++Il5dxQe7T3CLUT/Z/uS9+Oi7SR8PeGsFc6BPQybkBfSLmg4dLBLa47lVU?=
 =?us-ascii?Q?Eesp6v34/YzDPT9Rc7dDibKx+gDA+mD0VfgMPpwXd3yh/3TwupgMuzCIlNL+?=
 =?us-ascii?Q?bx3LsW+dVU4rRqBqBAi5Zom67WV8Bd6Yd+W+6FtQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0678ba3-eff7-4e2c-2e17-08dd944a5feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 07:22:11.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEgGcSgvx22MwniYj1ryOzujMiqqy9znZwPXIRl51M777DfcYahf26aTiIuZiHLX2auWhVqAlH7aYnwpp9TATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
rkadiusz Kubalewski
> Sent: 22 April 2025 21:32
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 1/3] ice: redesign dpll sma=
/u.fl pins control
>
> DPLL-enabled E810 NIC driver provides user with list of input and output =
pins. Hardware internal design impacts user control over SMA and U.FL pins.=
 Currently end-user view on those dpll pins doesn't provide any layer of ab=
straction. On the hardware level SMA and U.FL pins are tied together due to=
 existence of direction control logic for each pair:
> - SMA1 (bi-directional) and U.FL1 (only output)
> - SMA2 (bi-directional) and U.FL2 (only input) The user activity on each =
pin of the pair may impact the state of the other.
>
> Previously all the pins were provided to the user as is, without the cont=
rol over SMA pins direction.
>
> Introduce a software controlled layer of abstraction over external board =
pins, instead of providing the user with access to raw pins connected to th=
e dpll:
> - new software controlled SMA and U.FL pins,
> - callback operations directing user requests to corresponding hardware
  pins according to the runtime configuration,
> - ability to control SMA pins direction.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v5:
> - stop pins unregister for not present SW pins @E810-LOM NIC.
> ---
> drivers/net/ethernet/intel/ice/ice_dpll.c   | 927 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_dpll.h   |  23 +-
> drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   1 +
> 3 files changed, 936 insertions(+), 15 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

