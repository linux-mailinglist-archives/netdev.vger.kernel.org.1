Return-Path: <netdev+bounces-229077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A2BD8005
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69672346995
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894D30DEAA;
	Tue, 14 Oct 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEp7EL1R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3761E3DED
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428228; cv=fail; b=kA/s0rD5DYA9I8621eWirlfdI9U4LhZ4hkt+eNvglK7xDtnkux0V9Lt85gzgrkr18s7WgFAtd77D1FQBIXjqggLpGxjLIZM3i6DgbuET0gf5JbUEUZ1GBelYXu9qniRG22tZ5Be2JwMLtXV4CJo29j6OruzapiDH+DCVHc9Qr60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428228; c=relaxed/simple;
	bh=o6ca6QJojOz7WTSiwdb8PR4o8ofu59++zfFqWt23lgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4fRXH6CfRT1PZneQLlmMyVLlI8/yBt4o9945+/xyBAl7iPjx7jFG+P+q0a4G2CpURxncXEtXHIM1gXAovaKpzstTpY4Mns5YIALb+0x/XvqzRqB4y3BveRdQIA+chCz6HrfVVU4EuiVSb9toBgPZpGwjGTpthkH8mIwt9aNCFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEp7EL1R; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760428226; x=1791964226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o6ca6QJojOz7WTSiwdb8PR4o8ofu59++zfFqWt23lgo=;
  b=bEp7EL1R0NpXbfs9HvE5tbYVQGm1Ynfkm/ms5jg6+FphjILs27BoROqh
   pzZZx27pmHubft0rthnK2AJKYiTA57uvHEqA4bNxULREHcIBvT4XQbJ8x
   udMcrbgvEA5Ol7q0p6U0qny1Bq0lHS/W/QcQhvQK7YcMowXlScHSfgdmw
   2wHgMS20+sDN5v2s4HgqZEo4aBctkrvSfFcftXIVExFyy73EXQTYDflEJ
   DtcarW782EDEjTvvdyywTa0TjUSJLugJ0Kozp4YyLP9Cv2osJs1JMwLLK
   U7W/r5x3B2Unu/syfA7kKb1HR+M2vh9/BYUjgu6CRvJPy1YPuYH6iSLqD
   A==;
X-CSE-ConnectionGUID: lkh6XexiS1W6OQQC479qlA==
X-CSE-MsgGUID: NAJxK250TSWRs4VkgffOow==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73260230"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="73260230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:50:25 -0700
X-CSE-ConnectionGUID: yL5jWsqTQBWoTUKocQr8WQ==
X-CSE-MsgGUID: 4SZGpzrDTWKkEzzGPLtWPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="205510675"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:50:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:50:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 00:50:23 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caTxlzRtklUyR8CaUo09iDZb0vMXhSvun4LxZN5n65sc6gzM4fx4y8ZrfrnoN8mAmomsn/bARBwmeMSPc+tqIrwwSvXUW/E/anNA+9YWONpnhVgZgHESJqLETSoFQTYuLkyQgEIUJwg0nqqPGQaz7rbEVm2F6O0fk4hY7S2+2JHkO3hivmfDi7ET4bPztXNfWfLuHOf0rqfqvdvcMX4H9E2UMt+D8CqPFtyH3+xRhqF1Ye6TOUdWT1sNnahisPZ+aaLt54fyRSXx+el6lKrNBq3CwWVBWoEMqccnq0bGP+B7SxMVOgplUV+QNpTh1vIF8eATn6WJWXkHwMkHh4LIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6ca6QJojOz7WTSiwdb8PR4o8ofu59++zfFqWt23lgo=;
 b=jTTamFbYPMbnHjCCE1DdiUvRTEVwiWsJM9SlZ3v7+Nk1/iQjDXsuYWT7CE4KRlSZV9gVVLMenMoi6sTHlsFDX0F+pBgp5PtCvoMP6Z6aQmTJVZxsRZSa7ys1SIoliRz4BQ/7Bbk48M+KodWUuSoN0f9IlgcQCkjkB8gp1JiXowHAe6cf2pApes4aPFF0dTq7HF75FmTzK0ZLdzhi9y9IrDn7pK8kJD8Xpjv+ZouYp89PxBS3stxDVZk5dykkXBGy3ficNZLictNjMDgqC11Li3WdXDVfbrJFf6h1x92C2mtXAtgsx5u7Kf6rvcozb9RFL5wPkWTVLZFlMfDPP9Retg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 07:50:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:50:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 7/9] idpf: generalize send
 virtchnl message API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 7/9] idpf: generalize send
 virtchnl message API
Thread-Index: AQHcPJablWNA51PlqEupoc0MJ2jxVrTBRRlg
Date: Tue, 14 Oct 2025 07:50:20 +0000
Message-ID: <IA3PR11MB8986E52C823A448FED2B3394E5EBA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251013231341.1139603-1-joshua.a.hay@intel.com>
 <20251013231341.1139603-8-joshua.a.hay@intel.com>
In-Reply-To: <20251013231341.1139603-8-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: 137dd2d8-aa93-4284-4e8a-08de0af652e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?YDo4jx0+s5UCvwPQV+cSgV6TvEaknFde+l5EM20P/zZ4vVcfbvrG4pldf+cC?=
 =?us-ascii?Q?v+kfbwNy0/AXu6H5wqf05hLwq2Q8wOVEAWXM/IPYUFKt40b2/oRMebjuqCSk?=
 =?us-ascii?Q?YpwjUNnboRPGnYgmAnsI5MmyCJovt9DMtlqRSPwDFbIGTLET5Q9sgUh7oTcI?=
 =?us-ascii?Q?9C3RPWSpmTbibfZ40xtZqDRG/BZ6ZSX1SgTh2ho9Z/qgx5IPQveAfyjCzda8?=
 =?us-ascii?Q?+9zx58o3JYo+AXe328OUU0Xpn6LO2IXmtBL4K/UnCWMiWXrdGw6mp2Xw1QxF?=
 =?us-ascii?Q?8zBPXKseMknAk3YQ6N3YZibIUIjCo4moSpg9a11UmN9kxqO11hIpL1a98kpe?=
 =?us-ascii?Q?K3f2C2jMf4Ctp9bCtvc6BR9TX1Wu/XV8LzM9wqFc0BGRfov6m3Iax4YiQkdt?=
 =?us-ascii?Q?4teZA+dqD6VI8FN80I5Ymax3yBIWeOoKLYvwRYp8Lk3fHJrYZYOsGeOi3qFj?=
 =?us-ascii?Q?KAEpRxezsw4cGR5kngtIMk+6+Y/zXwAjvBNh3uqz6/9QqI8ZttExli2qaIDy?=
 =?us-ascii?Q?uKSOiFjICKgEkr514YfLZmyFX4Vf6dXAc8N2/zaX0/Pjcj0bsfJlY5wW7K/o?=
 =?us-ascii?Q?NJjUEh3mR8WinB+IWvhYc5a/4SGg6DgsQ6ThhlwQNHRodz97+buEuSMaNC8e?=
 =?us-ascii?Q?9Wqo5wwv2TCB4jNIBz9z3kUS9piILihecC9XBEjzhNp++nL9CXDgjMPU4dkh?=
 =?us-ascii?Q?QQMGiXLrYAcZBAcWxBp+r7o8bXmo+sUSJxJtQWamaDCCVSv37DOHPbhD5c7T?=
 =?us-ascii?Q?+8NqM46R6s9dMpRFZJaBbrArCMbTwHO8UvtnVt977BfL2s189RYtaS7vu0Dz?=
 =?us-ascii?Q?qUK55yFX2LovSDj/az0mfc8sINR3xWqe6xbHb46m0W+52G3pO2sn03aldvbj?=
 =?us-ascii?Q?0u2DqtNNk6HwsoxI8QpdNYWWtR+aOhojECfGhyOw3pYyi9Q1xb1Kpxo2BXoY?=
 =?us-ascii?Q?4ZM+JiMat/FCBL9CfqVU0oRP6rhEpWwAQt4IOPBz6DLJ+fZqoMgzIo2Ipsp1?=
 =?us-ascii?Q?rwJI+u20QQeGzgEsyNifAr1m1+8AgNv9mRQol/EM0ECFjQTmmqwbcVBt/umf?=
 =?us-ascii?Q?/QPpjofk/YI0UVj1tEcUWUhF8GKL2vfKzNJO48ovK9skThS/fEkJMtcR1Fqf?=
 =?us-ascii?Q?v9oQHYg1I4GG/qgDV1sGT9woeEsYGUZuk9HlC+iy8PdG17j+h0SE40DJfEFe?=
 =?us-ascii?Q?EErR5+BKXcpx1XTYTcostn7Au4WHQaX128lzPOzGBzDx9W8Ys5P2QMhQlhOF?=
 =?us-ascii?Q?lUWGrDFhpfy/c8cmXeEbivPZhx5BWRqWYxwmRlgT121W7kZScTy3+k/Tz22s?=
 =?us-ascii?Q?JDHmEs6BM812bsfPxBENG1b4xkutKg7qKwr0p/8zI4Kkj41FCNG4ecsM12G7?=
 =?us-ascii?Q?Pv3nP4NHoc6EFe1eMCpT7cefk2st1MVKq1oe/91ZKxCkno7zbPxmmuVN7TVG?=
 =?us-ascii?Q?f8Z6QYKUpNcafTcAEdjZsygaZQj37eYUTu0G93hlVG3dDMB1XLyrwkQ7MYa1?=
 =?us-ascii?Q?9mUdiRUb30Jp5tYi7TeOujLQcYL7PlYUevDO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TE4klMA5Hf4v7DODE56KOMzSPfskiKQPg8QAB8RT86Br2j+vrgzCnn4MV3wr?=
 =?us-ascii?Q?yJa/LbYW2Vx2/It0QY8AEL/94RpjrO3PKSttAPd2DCg2EfhbabFewagozDSj?=
 =?us-ascii?Q?hR4A72AfJht2+G676ok8N6tgT7Pf1jZg+GQoI76LR47sYy/IaafDm+8NCPe9?=
 =?us-ascii?Q?LYxLfgyWgr+FJ+4cr7C1+cyRv9/u/O5680jTr3hayrW9ig6IHOp8M2Y5PnWo?=
 =?us-ascii?Q?VyDZULhcYdTjZuMmQUeLLxjuvhltalNvfUKEcxK3IwxI4kcXsqtncLHN4f4r?=
 =?us-ascii?Q?v1cYBRiVmRPJamc+Z83YigQmRFgzCWmXFCHGBqW075fJuPgSZdWSWsvYjYSl?=
 =?us-ascii?Q?Z8+9P61QndkPHOukkdC23/Rj7FaEBrKMxWPJ/T5FDgydybjcqH43CN4d5Nim?=
 =?us-ascii?Q?K/kBqwLsdsIq1D3dqkkmXi185RqV4f9V1MYCTfbEy/sf4YYRrmVoHRHAnjNP?=
 =?us-ascii?Q?F4cgRZnMZmayB3bbx3A8r2NEdoPFc7azOrwIXDzTsz1gceo1WXGQ7Qq1SNlK?=
 =?us-ascii?Q?0A0A7A9Q83CGUqn2vpi8DTZjkA0Pl3xy2UyPvF8h6eHSMCnjmBKV83zbZ//X?=
 =?us-ascii?Q?+gXdm2e0kqIooE59LFZ3As/C3sudSZ4cu6JfkQN3hrhErey7l83idBwtn13x?=
 =?us-ascii?Q?7udnHYagjo1ZvidmMZfiTMuHw89EM3ZUb403RYvD2fKKtlGvgyu/4B33pNvY?=
 =?us-ascii?Q?EAOUD4szOwKSeRvDwbgIR22ygReWM7hap5ZcSsB857UJzEFOvxbSCZG99bAU?=
 =?us-ascii?Q?ig/G5NrOOmIyG1Un0yX7BjOW/yLXyebKBEM08z4nGC48dPt+cKDt3UpTy+H9?=
 =?us-ascii?Q?LGr8B1pXj2hSzmrY9Fi9E7/05A4WWVQ9zIXvge5zBNatWnHCc01IWdS0TG4m?=
 =?us-ascii?Q?3pI/40uBHQMm9gIbvMaPT0bmnCREPITqxL5W0v/Zq9KAFAJFGEgMcmJ3urXK?=
 =?us-ascii?Q?99goMIIzGEXN1zfXXieUPLTkS333uzwRzzf5DQmw+4AtEkFYGXQw20VNkh/7?=
 =?us-ascii?Q?yYrsagXSP5F4TFRd/Bq5XO57RTXlTWuSeQLgPMUuf02zZGmt5Sd5zPgz5bqw?=
 =?us-ascii?Q?FiASVGN5PDD7S+2jWpggcu18w2ejAN7GBRq47fvHUAPymptRwZpihngzq9Wj?=
 =?us-ascii?Q?9j8Zgl5H+JlMk4orrzghJTGvPj+eA/bedST0Dbda9wskQjrPM9m2Y3f6fpr5?=
 =?us-ascii?Q?+Zl1PhClQm7xWfRDy8LTG8MXLLh+4t3+57s3nh0FO4AHhbwnGYuWdwLa9MiK?=
 =?us-ascii?Q?AA0RPbQGejn4PZuPLYKpJE1CWEjmtOXnG0hm8uN+nVOaG9xIOX4iSInshX0g?=
 =?us-ascii?Q?EeMBYDxcUiFj97P+TdgxCvZSYfwY65xLu2GDYiHwIzstU3wfUfksndaa/gsZ?=
 =?us-ascii?Q?alTW2j18YDFC9Ef2xl8fokV6NZJgbYGuUcxnZEo7webfzBiv93QlyuRR41Lq?=
 =?us-ascii?Q?2itLpaeFXbtQToB/U1yYfeERpJKIPdIuEXQHozjtHSlxxfufwepIZd6DykBI?=
 =?us-ascii?Q?V5P4VytSEqLPQMS3KmRApaSmp3mkgADvXkdoXx+x9VepVCfgCRyni7yb1+BU?=
 =?us-ascii?Q?bQ0EWZAyj6Dr+ixnjhY3akCufrATs0Li+FscFusbQuPfUwjt9zPY3eyZvtBO?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137dd2d8-aa93-4284-4e8a-08de0af652e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:50:20.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+kToyYRcGgjFbvBD4U8ieb7bALYAVLreGt6qnihicILFsPDU85dBCIPVTaMS9edBYskuQuSvmTIKXLWFbW77uBALW5dW9Kggfh2EQQmi/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Tuesday, October 14, 2025 1:14 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 7/9] idpf: generalize
> send virtchnl message API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> With the previous refactor of passing idpf resource pointer, all of
> the virtchnl send message functions do not require full vport
> structure.
> Those functions can be generalized to be able to use for configuring
> vport independent queues.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
...
> --
> 2.39.2

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


