Return-Path: <netdev+bounces-292387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG1IJ8IfF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B385E7F8C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B45DA300B9EC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18443CECD;
	Wed, 27 May 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/mAlfun"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C143C04C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899837; cv=fail; b=XPregtDZDp3SEx3x/I5qV4qQXm0f/3HwipG4of/5kIJcD7B4jl0HbTFES6U3w0AMMy2VhQIf6GCaLSADl3E9PGrqauhkliMKMwxtn5MBzLncY3QVkPuWp8Emm7g2Xcwt6d5VoCCLRCojnSHXvC+gPpmxZSAQjBYL8eOwrPbJfGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899837; c=relaxed/simple;
	bh=BuFGN/9q4GgVWGiEAM7KXuk8FBDmafeUNTnk3Ss8org=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JR8+g6Jka6480e8Qy6o5otARnpxUeqlLRzjQOyfOgO0P8miqN5XwL2HSlLuHPuzH1p+NRtUyueMpPE+yqnUusKJ1HWXw+bG4gQqWhyt56GecmF61NiAjiMeovf1GwRLqp/3FMD+AwhQjVMUgQwhNGGzXEdWPBA7/Xqm70997Yas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/mAlfun; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779899834; x=1811435834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BuFGN/9q4GgVWGiEAM7KXuk8FBDmafeUNTnk3Ss8org=;
  b=C/mAlfunU+9l9Knxu36pnKFnmJ2pRWy2hyo0hFckZg6cQvaazeOSe3Bn
   r9uBwHyOkBNN4BJqnUSVGlhR9b0AgKR9tDj5zdguD5FWiU4UoOQuIz8Ih
   KnfUbR/sBENeN48IUO+6AI63S+kOLVLJ2XKxhanNOX6vM2nfpk1OFv7Sa
   TU3OJ3f3OY+psOm8YiDEOHShcAdsN5dxIPlaUcaQdx7mFJ23zZMu3SG4B
   tQe9vaOVfwLjxmS09V94GdWkI7zbZ+DABD0bemhGjOOm4WpU7yc7ZcY4w
   cD576kRQ+AwM3dVJUg30KhYeAGjb9TpriTwRnzbW2xcHaWfm4A0gCsJ7f
   A==;
X-CSE-ConnectionGUID: PCcVuveSSHyXcqkYr0ysRQ==
X-CSE-MsgGUID: KJ9NEJ35S1CDtGZyC+ocoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103412420"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="103412420"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:37:11 -0700
X-CSE-ConnectionGUID: /cwkFRL3SwiC9URA8h6dOg==
X-CSE-MsgGUID: Ulv6PV3lST2MhQXvIj9nNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="244116425"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:37:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:37:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:37:10 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vISE0xt9PAASe/8VhMJse6Mze2kX0tZG3zA5qlUZRDaLDq/EUAnPbqsQvwCrhINHNOCSg4lmyELujn8JkbVSoKzO6QtJNvePMXsRPpkT+qECiyKW7QJLlJ+QRdNHJhb7gxmSuZ5lIAva6Cc4iLSgRF7V84Domj0T10EF9crpD39gIR4obf6Kn5QgeTVSzmoi7m6OtGCAJ+xjkptCateLPOddPpgWLeIIMw7t+xXdr+xQq/nMMDlfUvDZUqH6avOTvZl3vC6CLBwmMKAZuAlLZwVmXVqTV8AePqq5ViKwH17DQeYi7dyLzMp0TyWHxtE781waBvDdX9VyxSrDh5SK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0/IC/kZ4KJCYys06dx15aq2Y+U30MGqP34Dm3F2Mao=;
 b=Fon2ArzCpluUSji+5qZKT4j3vz861B1DgAt5DSAcGirPZgn69nhVyWMC21oKhJLObzCF4wq8UwKP81UPVSgLzEBqGNjTxGOqqGNeQS46EO+e+2HdezlaJxEpl8meVqDyfoYVU0Jzua4t6oTAjg59Pok+MFqCW6TPbXy0cd9V0i8YUkyGZQJaIaEKMGeLZ6UeBoELH6IM9YZKhYDHjqoMvVHiKmXdgQzBgJr9h5GDckVcKSyJUXkRza2cFLTEbjm5XnUkwsx98h2p9/fyyaRrOg+p+IsWItQleExFbS/CiLt63kbpamCf5xr54VfICnV5NrnDUNgYKKUTliknaYbaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:37:05 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:37:05 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/8] ixgbe: limit ITR
 decrease in latency mode to prevent ACK overdrive
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/8] ixgbe: limit ITR
 decrease in latency mode to prevent ACK overdrive
Thread-Index: AQHcx1lr4DgkoXu1CU+TEOw60BoCVLYiXzJA
Date: Wed, 27 May 2026 16:37:04 +0000
Message-ID: <LV1PR11MB8790EAD977ED6D3B45021CC290082@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
 <20260408131216.2662245-4-aleksandr.loktionov@intel.com>
In-Reply-To: <20260408131216.2662245-4-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB6839:EE_
x-ms-office365-filtering-correlation-id: bc901e9e-4950-46f6-b33e-08debc0e2fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 3WLF/KMoHjzDNg5TisJacplMhX+Rckgn1/EMgsKrj07qAEa1VfVs2TcSy5BciD/X8Lp3W3WEQq5TMUMaD7iTt9mJc0QwUGlbMn41+DvKuSGpEYUByRF9T50sB1HnzSYNFkAhJOkHU+g7DwgBptHHsHNzFGLzMdnTFw4xbjneeO95mF0ReXP6wrLtCDKOXB+qEjZ3TvG+Qrul3/bsmzJkDzU6oZxWrsymh/ZksNCEEMxXoaboxiaGyqGW1cOc+V2gKipldn7jXz80hu2ZMvvO9d9V07yOCah2v/s0R1ZrvvCXmKlkmvaM9IRbsz35vi0yymXLkgtOKmKTRmyCZzTPe6gYjvlvvfnd19Y+aM+xC9BQ1/9xZWmK0Mawu/oNHnTrfFYlEh/S3b9CBsErfavxIl4/oU3+K6PJbiivxl474oEgNUTHdyvrZV5IzcU+s1UdbcLWEwc7flVyE43f2YHk4e5ssWiSLFoiGY0vNSJO1KjKFoXBJJNIBBjSIApKo0F2Ang53QdhnJP/koo76fmjSKxggJn3VaXDyf07q7pSXzPTXjpJWwIgdOV1/y+kEDQ2N9m01cRa9yTbk90dHKTKJf2FEiAhd9TV6IutLIg6GNWffEueTHr/Ri9NfNgRbrSuTMX/X1U3Z2QcAwP2V5eaH1b7rE3CFu9BpXnaugTd6ycuJOd+Dqqpom3m4NrmeLC2FG8gqmWjjUSLfBoCTt+SoIxlxr+CS6timJ/gIy1tsh1sH5HQp7qwhJ8kDuG/osE/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wzk3un2vsVfDe9aHyayUx2y49PMRZjvzqjlDA5oYTiM26F994z/du6d+91X9?=
 =?us-ascii?Q?MYw5j2+D3fv0L4iGXlV3JmPtpOUOi2xIBc7Bw134LN2ouf4KpCm/TYCG6x7Q?=
 =?us-ascii?Q?x38Smvd1ZUNqKd6k3+e6+t1/o+Oxg81yggEgeJHScPk4+n5jFoY0UWc0Kllg?=
 =?us-ascii?Q?Dxw7Wfsuy1OArn72Fs98OzXlj2J4bdQyTHfMpeYzbXWnzNdU5wd04ES0YeXk?=
 =?us-ascii?Q?LGmGyCc2l1eGVXT0j8sD08q/zeSh6SeyAEeBeXFoYGLwMHBc6n7M56/y1N71?=
 =?us-ascii?Q?47Jt8OwIhd0K4JBbgkfy19tJ+y6oDF9nuNFhdKX2dX2pjlMxuU1MbfZHXf9E?=
 =?us-ascii?Q?EUb/d+4L8iZqIJZpJuzLHEPnv7FueR/Yp5TZ6rRXPKzIJnvvpRiOn5nmUgcS?=
 =?us-ascii?Q?dSi9tZGJOkC4pvddEom/muE2vRCPoDa/Y4U7gvjfGywmPtpCyKJVZKQES8Ur?=
 =?us-ascii?Q?Fq6jZvTIl+nw3c34bM0tkyO/WjDFHdbD9GCHK7JVhOWPC/u2EuYdbvnCk8D7?=
 =?us-ascii?Q?X3H/Z0fVoOo36KzZ7hp+cDF7qnrsjxxn/90jyxmhEWtdPqTdIT87WuvCxNaa?=
 =?us-ascii?Q?GJSIZ+oXtjTC0EbVFiBizWMKA4ivQbqLIRkPLiHQDZLT5zSqj3XxczgCQ9gN?=
 =?us-ascii?Q?HNtUxqwPTC+BHGzDjh58Cg+ZA+2yinLr4ALrxMgymTxTDYxf6ftPEUFQp0Wn?=
 =?us-ascii?Q?Ya3avsbi8Jgqx1Ny8L/kWXw5oOEGHB3qatQAGvq8wj9t+SHVteLd5Ket4YTk?=
 =?us-ascii?Q?xlxGuJWgo5j4pc9uahYADzt48d9a5kEv5t6F2XfOnfnJwYPfAlBKVWQGKI7K?=
 =?us-ascii?Q?c36yMjJ6+IgkcfM5VVH1iAo+s4ti/OuQq/871Tqp8sxznV8p2rpr58gFF7ju?=
 =?us-ascii?Q?Hyo2ekvbQ4HqfAhtdlGX6vuDr/wgOUev2V+fzanOfZqB8pj8WDdxm6YSDhrf?=
 =?us-ascii?Q?CjiRPtGEwA2J9baWZZTTf9TK3/oliSe9eG2b4LkaTblrONDf0Zg4bj+bZf6V?=
 =?us-ascii?Q?pEv93PcYxRt2p/3T8Plm8ZJu2qtk4ouhhX0jbVSrcKjuSy/9eYkMrKExguN+?=
 =?us-ascii?Q?Y72tyAmtqRXtKh7V5AXCOQ35Fp+1FTHDc/UBGlB5mUA0z3dx+EzBqMB8GM/U?=
 =?us-ascii?Q?Q8SLJmaXm+2ODqKvTcKKBUUpPJfVhPyzAIXSQtPkugcFwEPbpi06VZ00C/5j?=
 =?us-ascii?Q?+3NoKbtoii9EAW6zVMQA+nH66+YUXXzEFa8oWfjvzsQGmlMMNL5ZIoySsmf6?=
 =?us-ascii?Q?XbHPZSpTjcYNdx26LZkn0uZDwQsJ+eJqKZy9g49R2BgIbLTCi0ufbTo6LQ5q?=
 =?us-ascii?Q?c0JdB4MGI37eVSTQ/Rhhlgi0dXW1uKp7wDedwL7scLsClpdorI3vC/7bkY/E?=
 =?us-ascii?Q?XEHsFLPX/35nN3NTcuDPPo9nLgrIUr7wC7pEYM1dqlsu8pRw7xmuOKdgpImO?=
 =?us-ascii?Q?M1uotUJmWNs/t2BWgJfhhp0b9QJtHLPVI/57FoN9Ou/CYUdRfqkuFlGByOf2?=
 =?us-ascii?Q?8VpYYmPb2rOVnZTBsnC0FvE/gRdceDoK9cz/sZ5V7l1i8+4AEioFz6aqGiQE?=
 =?us-ascii?Q?hZN5iBUrC2vO09t78SmtCMd2vp1CK0AyeY7WqBuONKsbB2ZCvHhF+s/c+qLS?=
 =?us-ascii?Q?NwjSn2EUkPzLgbqFlz/l1Q8qRwbQKRWWJrH4O+hcfH7fHSzMUArIuaVkFFxm?=
 =?us-ascii?Q?CcoxHDooc3eOSUZ+1gTlGUPs+GnSau8hl6BJ7Dg2yWIGjx/GezN6d3qPcZ0R?=
 =?us-ascii?Q?nTYMCA/t6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gUTBgaFHsuQajbmOfCnCijCE2nDDYucZamMx1ZKpy5GiAMjI59jOfiluDGiBoj7Yeq5BpcXXxmpgWhpHzn+lru6DfHVAnyYBDw4XORbq+edxdUD74mXo0oNwwSrN7gZgTaMDVgpr9XoOcgXist4P7/SjqYd3us8GXDyOoymrFf2Yw2LH+gW67+Ucu0/xFJe8EUzeyvXM1ps9mm+H9/3sSjBqgb+wcSPksPcoM1iIKlbS6TWFWL26z2nBZahh9uy3rEM9EwRrupxS4PhjfbOCjUFKip+dlXpt2yy64DXFwQJfVztfxAl6WO7y+plUA745MBW5Fh2BfhR9IzqY7PKSgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc901e9e-4950-46f6-b33e-08debc0e2fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:37:04.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaKqOqYWgDYmZSlfzKp1PM3h8P/YKGZFktMRNHMBr5/cYA1FuhxWSdUMFQCSRDw6GU8VfhGVqLh0yXtNPF1w2Q8SVxG+mXEisMc0Oju97jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292387-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,LV1PR11MB8790.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 06B385E7F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Wednesday, April 8, 2026 6:12 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/8] ixgbe: limit ITR decre=
ase in latency mode to prevent ACK overdrive
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> When operating in latency mode and the computed ITR is lower than the cur=
rent setting, the algorithm can reduce the interrupt rate too aggressively =
in a single step.  For a TCP workload this means the ACK=20
> stream (a latency-sensitive, low-packet-rate workload) can drive the mode=
ration down to very high interrupt rates, starving CPU time from the sender=
 side.
>=20
> After the speed-based ITR calculation is complete, check whether the resu=
lt is in latency mode and would decrease below the current setting.
> If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us) pe=
r update.  This ensures the number of interrupts grows by no more than 2x p=
er adjustment step for latency-class workloads, dialling in > smoothly rath=
er than overshooting.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Split from monolithic ITR cleanup; this patch only adds the 2 us
>    per-step decrease limit for latency-mode workloads.
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

