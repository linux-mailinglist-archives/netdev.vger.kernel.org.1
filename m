Return-Path: <netdev+bounces-270914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPmaAz9FwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:03:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F343044D4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5488C30EF519
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BD35F19D;
	Tue, 24 Mar 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYBABqsw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFA35AC24;
	Tue, 24 Mar 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338906; cv=fail; b=UL5b9lRuuJ0vJqRo5JZfBfKbAki/tWiStl0PcBqZFy0IJe6T+uB3Gtb1X8BZ4SloeFzybTpmiTGe2G3P7LxcXkX3HTfT05BGJXXaaeYfVBADGeyB47l8SGyCMn0iUc9UzTUqDwyjT0pqCFXA/vGY8GEaDu5WTyvBSp6/ncrNLEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338906; c=relaxed/simple;
	bh=TrXkO6KeMst0kYpgempeFpVvenNMjv28g4EiqP5OGmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QkT8dPxBXrzD4jW+YsMRWm5Lt2fA+Tv5RA3tdljjubSy0EZAp8o1e8HqqHGYMC0eDrumYMCAHoai0TyNQsIFgCmrfIjg6bF4M7/SZs5VHcc6Nm3v88XL2rFSNdztJLOM6ECJ/FxrQAgl5vFL1c/d58cqIbnHCwmv3OpvihdptzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYBABqsw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774338896; x=1805874896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TrXkO6KeMst0kYpgempeFpVvenNMjv28g4EiqP5OGmk=;
  b=XYBABqsw+vLpODHFobtXSXiMjyeKI1Dti/+IGXGtgo2ofDIrTBBaOoup
   00OtFkKQy4QNEmJ6/6u8ChjcW4Uprj9PkgeLCP7cHavWPPzeoEXN5J+7u
   vOrpcHJWt8pa1bOdr1BYXqp2o/DKryaiPwPXKgCZEjDnuGlFKmsc52/0T
   TEKHUULX99EIbsO3n6/fwY3mgfW4rwfPWQkABRJQV6FdLOIhq9b0mrH39
   hizSkyBnBh/0FKg32hoIY+rtniZ5C3dSKjJZUqcd3V/Jb3ogcUeoStinM
   m2ypeOf3MjVMy8YzAuC4oTeqFRiDHw8pAN4XeejOETOXf1O/7sUzpbxbS
   A==;
X-CSE-ConnectionGUID: bVtvfhA+T66+/WOIiB2kmQ==
X-CSE-MsgGUID: cX49UnSzQIKLIji2xeny0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79204783"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79204783"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:54:54 -0700
X-CSE-ConnectionGUID: KZvknKjQQ1K+bJJYhux5RA==
X-CSE-MsgGUID: UsgbO0WkTtmi48qWKHpfig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="217712526"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:54:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:54:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 00:54:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LovKgSjh6Je4eYAMGAyn3GKZkY+lvuZ804+z6SczTg74+bfHM1K5oLxidP6N+m9kpIVII6ktAFBJy0YcswmH0FAWSSibLq3YEWpvDWeIRoWRhwp/TD1x9gNw6HsFcBy87ykBjRxFQkEfrV4JT1/JBWUmFH1L0pK1bzFdXAd4wjClD0zwGbMYcF/NCbxWR8XECsFo8JUzxOtFnpAU2YUrTdJuUbI4W3TWOjvLmy8UR6NRXOyv5tSOuyqOJYNqmJim/HnRujgiFXYZ1+2RyT/qx1KF+GTxNw3jnmTLMHIJahR8O+ji4amQkXqr4+S5lmakFzFIe7zSVX5fOgDmSgjyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iS0HAYG0eNhpkkIT2UkW5Et1DV8J0+8qHnkTrqslbA=;
 b=j9bu7ZUNCHQ8m1rmKuFN6KJPEgcaGhvJGEGn6ahAQA3UVdRKCJShxHASB57kZ57v5y3r3qRlGSfHoZjlrUhx7VwAIG0zEW3IU4zNNRWAcIJUY6+N62RvoZY8RQuhjiIyedkyRwJUXHET4WSAeJoxcx6jCi9qGHDnvMoIhD7jOfykxYLl2dGQ4SKW9EY4OsEGlUPq7HNB7ne2XaogVINV1gnMVKzMMAYwywpUQwPzJmTLhaduLj+oBv80Z9QcaeN0RbEM4F2zXeMnkTpubkrBqdWaFP8Mw798OuFdCriRPn9JNd06Hi+QABwJJtUAXNKDkulaFYpb4hNfDnl/LKbTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:54:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 07:54:50 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 05/14] libie: add
 bookkeeping support for control queue messages
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 05/14] libie: add
 bookkeeping support for control queue messages
Thread-Index: AQHcuuxRUORis4glxk6X+hSLN9nrOrW9UQFg
Date: Tue, 24 Mar 2026 07:54:49 +0000
Message-ID: <IA3PR11MB8986531BDBB5DCA01698BAA2E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323174052.5355-1-larysa.zaremba@intel.com>
 <20260323174052.5355-6-larysa.zaremba@intel.com>
In-Reply-To: <20260323174052.5355-6-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: c49a9efb-6521-40dd-4fa0-08de897aa037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|18002099003|7053199007|56012099003|22082099003;
x-microsoft-antispam-message-info: A0q93OJKG8jqEMxzjVlD2nRiq5HOGbOhVzVffRrvQvlv3tULnRNMMJktKX508AGsugYcv5itPWzJYZ7J9pDfmk8jzHlHu15g4ozvUZpU7fXSO36lSvPpfydEgSaD/Hmw6gqcIZI0tazPelKD+T6cFQ0nEAxvXfG6QFxsSfhrsKxvNYU1jXo+6GHVlXF6noyedjv9AKtxXWZnLaelOYUqhf0bGowTb9iBNK9zVrWv7HD7aagtmScQx5phJsP0ZSnY+5rmdo1tGxanDTWoZc06Fis09ZVAbE0ZnUEkFFTPvjYwb351XpnVFAAcJ5nUClhvDdkr7SlBxjP8OuSrd2qMfhktN/IzLDiqXslJilyOqeuCt83RQ5xtClVZWiqGe/F2LAxo6vpJ2n5O/fp2vqT3klbM0Hnky4iFPzM+bMaUIriZVPJcpCEKj9UEltg3Q1Vhs8x85U8Eg5E0yjMTkPkxazdudEBf2hcouqEGydOxNSACpQw9fDOItkA609+wwwYIPKJsrG+87iA2UORGXlE3HvRtIqjCTXcMjEc5xGTtvEOMKPWgJZ5xVqznBqQKJjI3iOAYsrpq5Bn+tYvMdIyLL/6U/u/c7LLKtwoUsona1oazQaMZGQTY1rpWpgpqu90thMDKG/4WRRiMJdR9MrTqYlpc3YpgSpgM9htx0cTFHUP1vNNSwtp1gn3LYmezG//ojkj8R8ZbwsAvohtX8JQSILHoAsCxpx46u5UbHw9w6cokA0cV9TFAyCsIyIWSZyHsLI2WQX+CfE6y2lFFhlLztARi2M0ZjlAptG2f9OqgF/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cLpVacZ6miTeNCAD3iaESRuVDTw+txOOtaDEV4uYSRERmr6v1aj0tS40ZBc9?=
 =?us-ascii?Q?dlctDgazsUgejB0vluouaiYTGDhR4+f5I88tYHryYTxecDf0dxXbR+1cM6hn?=
 =?us-ascii?Q?CcVfZQxYPYAGF3CGukK0PYjGTDgLxQC8fnJK3ss2+NkAnbEOBPmb86TXhKRT?=
 =?us-ascii?Q?lW1pNEMt0NeZBvebR0Vwr2F5N6p6dTKdGnzccnEmEs7UjjK36RN/OXuOT+V0?=
 =?us-ascii?Q?lYBnYmWYBHSwKPOAFp/zpjvDUaB8TpUN9EFCDn8/yPRBXi+i1pPQRlmQBGTZ?=
 =?us-ascii?Q?KpZB7vorUFrrPp7J9VfNGcVkmVbg1i6wWOqorJ7ylgc1I2acz9BevCz7lIlO?=
 =?us-ascii?Q?cjWAfwYY9BzfaxszoyrSxP+3hWERsMKuMJpnSPTOlXNLTVFulloXdz5d8iU7?=
 =?us-ascii?Q?88rGHx+Bfe/2cM+gwBojxTbU828nyjazrcVaLz2nuGn+0BlGLmEZ2VuTeT2u?=
 =?us-ascii?Q?gYKoAOq3R+Ra2WgxIrlDu4GAsZ3XErwFuLRLlyGGO9FDRAKrhWOw2GQ7gnpR?=
 =?us-ascii?Q?dg4hja0Hm7hmEFAujjkFexaNROog7WFh/807A0RoEu6SPGssY8ZDnkYjYmwO?=
 =?us-ascii?Q?CQHzk1FPPNY8Ak/ixXLAnynCIdIZxPQFYSB24Bk4Vd9LDIVFMfBpus0NddBB?=
 =?us-ascii?Q?EtUCv5ii1EubnO+hRkI/YFDG45lY8wtNgWGKFDRdEBgeXud2Qi0e6+zZ0GP3?=
 =?us-ascii?Q?R8Y9BcCkl9ZV3oLda9Tf1axBba9om8oRT4CdwZEPMYiA1GKdODKYCYAfJSzV?=
 =?us-ascii?Q?aTdvkd04Z5APPyidDAxTTskFIYXF2DIy7oIdxizBppSj3j1NbvulVMffw/cx?=
 =?us-ascii?Q?R9xIEkkxQ1ncSCEvMHuhn3nF+NR0fH5+FetLOLQNK4AhIDSDcJ2bVpN1KQ5b?=
 =?us-ascii?Q?Z3XxcxHshYNjP/MtfeF7MGCT5FKO5m6lzrG9yOrua/c7hFkF6gusuY2bwtvs?=
 =?us-ascii?Q?wabO1oc76BGaOF1xjjmwdcxkYPTMec36oPWVfb2IL/x5+gpqT/9Uue+lVnRC?=
 =?us-ascii?Q?1EyNx0xeCQfcraK2JERRaiDU6Bwq6WkwlR/mL7LOjdvVeMbvLa6ZDKteHjaU?=
 =?us-ascii?Q?fbp/yLr9kBeTosZL3AnaoxsqldKG8T4BhLcY+wl/Nz/lvb6L82ZELUm6n97M?=
 =?us-ascii?Q?M1fFXohqUzvy6NwkRvpW6iyMgSyyeNcSLypirb3qXTzCkACCBb97Aw/+qHyZ?=
 =?us-ascii?Q?SC0oJAn62EZBfsnTMUsvmkSZAQ7gF67IgoxyIAolKXLaAZBqyQ+JNCmDXoDl?=
 =?us-ascii?Q?u2/OXWlLY7q+K7dTaoVy20IKDY68J8NjBZC+KLKCcz2c5QcRKLauaPVatPZH?=
 =?us-ascii?Q?jN3FOP2j4T0EXKNpBq7qWmvb6FVLWOibbLjB2WKaY47Tf7NsVf/urYIkCKvq?=
 =?us-ascii?Q?tw9cXkJZuFRJXN4EvHyGjLBvNFPpwH/UerN9wWHPPQMOP2M9+13ByA1kEn3l?=
 =?us-ascii?Q?SqK5+rvxhZz1U3LDsziD9g7q+YW6WJL1+Ae7jHdd4Us5pvr/Yz9TpTGQInGg?=
 =?us-ascii?Q?2XEAiE6z8wwpqABAR3M74+Mkg6PIqAz7dfAvEz0bhaXZfakdHIczd2T1Ywu7?=
 =?us-ascii?Q?KMBtEyDJf6odV+qLbdGH4QJxlYYBcEVS380o4sTyHhUBbOYprUKGXEuWGFiB?=
 =?us-ascii?Q?Gl72oGwuNqNKhC+9Zr36k6qKto5dtoAxfujrV6BQatpAvVfuIqZUzSnbwC30?=
 =?us-ascii?Q?lgcKLVz7D8XrEvkr8A5kImtQ4YNyRxphhNio6Vy+U+Fs4HyQGST/zIR18UrC?=
 =?us-ascii?Q?8Xwv+bVyvHs1tww3w9QU3OynMlgxAJU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tBruTg/h3vsSINdrIjnaMoA3sDD3O8/T+2KgagVhOW//7ryDRP23wfAenRSUGakH+Yi+v4n2NYxPXO4gsE7Jro6Hoq74Ej2aYcfNoGIrCeountLXeLNEU9Nn7qwZAEVgaGvpH0B1gTX5ywBrPHORFs01Jp1NslWzDS8Hx4IxmjEkAbJMKNXUvZoKyNicEwomF3wN4T920j71FIPO6PEm6upORFaolYd2OsPcfVGqsCZmA54xFs3K2mLjE8BZS3/Cp0pXTfFdyLop8769+Ex1Xf1VKWZa7uzFJA26J6XKrTJE+PzaWDDtxbpuRWXQ4sqCZxJe0gKJYWduQVKP+QP4pA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49a9efb-6521-40dd-4fa0-08de897aa037
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 07:54:49.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJy/B/bKHU+pGd92iC9IuMM7xJeVqs0a4+Qfi4Rls0iRe9hDTbU/ZH8LZXR+7E1gUhUKB0XYLXqjLsbp8U+KxS6YJTh1hZ+IZON/nLKFIts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270914-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 55F343044D4
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 05/14] libie: add
> bookkeeping support for control queue messages
>=20
> From: Phani R Burra <phani.r.burra@intel.com>
>=20
> All send control queue messages are allocated/freed in libie itself
> and tracked with the unique transaction (Xn) ids until they receive
> response or time out. Responses can be received out of order,
> therefore transactions are stored in an array and tracked though a
> bitmap.
>=20
> Pre-allocated DMA memory is used where possible. It reduces the driver
> overhead in handling memory allocation/free and message timeouts.
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/controlq.c | 592
> ++++++++++++++++++++
>  include/linux/intel/libie/controlq.h        | 175 ++++++
>  2 files changed, 767 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c
> b/drivers/net/ethernet/intel/libie/controlq.c
> index a02ce58cd8b8..ebc05355e39d 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -598,6 +598,598 @@ u32 libie_ctlq_recv(struct libie_ctlq_info
> *ctlq, struct libie_ctlq_msg *msg,  }
> EXPORT_SYMBOL_NS_GPL(libie_ctlq_recv, "LIBIE_CP");
>=20

...

>  #endif /* __LIBIE_CONTROLQ_H */
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

