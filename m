Return-Path: <netdev+bounces-222921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8846BB57054
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E01697E2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82132258ECA;
	Mon, 15 Sep 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HghDghkD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB11C695
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917910; cv=fail; b=rezH4xA0HArVeVvuXecBiZueQxDAw1x89cb8WY9+m7Nt+Ks8t4Dvk8yYjQBypihn7S91iu09bJrrH8d5KlDW30FZm8rTQiuLepcUj51t5rHipbbkwMEFgW0yHXh02xI4g3ckaluyC6oz2OC5UUsR0wVmhR5H1CRqeyBC9HzYtXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917910; c=relaxed/simple;
	bh=oMK9Zg0bN2YmH5oqZjmjECP68Tn9Nj1K4V6VCxaz0M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNodHDC7azdFpHH18p61r+UAabxfHPKi8gtln/E9fBZUPJKJdx3fIY8gjzMu+KubrRkoEEI7bJyaOk5SERjpc1emNQeOnIcBDsslEfQUGDd4Wb7WXpxUb++siI4ZBJDKFZwKSjvBTn0zNUpnkGetuL+2Atgb8ouLpNWD680luqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HghDghkD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757917909; x=1789453909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oMK9Zg0bN2YmH5oqZjmjECP68Tn9Nj1K4V6VCxaz0M4=;
  b=HghDghkDnlD02upQaXapyAFbde5wl6syju7bS2Hag17acpNltBt0qRR+
   cAwVIj9KpJ69yG1veDV9MxbfEKUVsfWCWjnhVqx5vbTHIOmC2H6w8a+62
   PV64yTCQ5bbMBvPqQbmrZr9a35VTrjk7D6of/UWTw86p4rwxFAxK1v5ZV
   LZEiJQvvLz4fB6qDt8XzPC1+6Ww5SPWU99JT2BemiDB0t7qjjOONaBrAo
   RZ4n9CIRiEe5VnTttP+QhfD8P9MbKHn8y7MCeJkrlmU0yF4AYm75wef+w
   hy+dqXt4xAdyOb96Me1RSQpjcYWF5tqnJPGLQUHVgC/5ZCpdqdvOM7VtW
   Q==;
X-CSE-ConnectionGUID: 6/j1+mmoS7+XDQNO0pcD7A==
X-CSE-MsgGUID: 4vK8X3oGSq287kYsUynpnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="82750385"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="82750385"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:31:48 -0700
X-CSE-ConnectionGUID: 0X62r7a5RM2Oq0iy8VTTAw==
X-CSE-MsgGUID: P8kh+ORpTZ2E/CAx+ukIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173677159"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:31:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:31:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 14 Sep 2025 23:31:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 23:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTynfJfcD8vwThgJJSbpn0PRlGajc1sPP6lmN9JuAwZ9QEW+MW06HNMpZz5XrebfntVtikiz1VeseIZpy4O673laLjew+qv3bwVxAqm21VkO4i7KQdPY//RcPRmPp5cF8cj5FP7A6+Ci4FQkT2i4gHoH9QkpqWa6Fna0L7vr8dpp7vmp3ddnmZvBgUrUPkzvzqIlBuVIw00lPahq96rj6NKJMxP4Xnxw0wRMnq36ocyWpfKTRDwjErvffLBojevVdBwS8nlkZJEQ69QwjCsZPNvKZCiCl6WZKJjQeCjU4jiJGA9wi935oi2FQ25rgGLlAnm/NSkoHzWeSTGq6vJT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMK9Zg0bN2YmH5oqZjmjECP68Tn9Nj1K4V6VCxaz0M4=;
 b=wNDZdar/1Zbip5aaDVjXwY1wtVbqsxMOrqh4iJebBdIiUhH2RUecnSGy0JlULF63tugWKKHzANgQPDua/iSttyVgehYdKs/bkPB+I8yswFr+9JrbiwsCuiK4JOAU3sUzKS/BBiaqZv7ca0bbMOpZxa1yn4Ax45B0/MQJSkR46IisxkxrB5ucAgXqWu0yXRXfmw+rbndlbxolyJ8ok3zzbFxiOAd5jT+f1Ho6lLosjtEOuhdZnGujLAXQROGVHwJJF6l6QE+8Yq2fiFqhX94tMVRaJyIGXthZGDYS+zamNa75fJRFa67W7c03wNRHa3L9qRJo/ge8JTr5mXZYoZMbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8A8418B02.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::840) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 06:31:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 06:31:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/9] ice: move
 ice_init_interrupt_scheme() prior ice_init_pf()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/9] ice: move
 ice_init_interrupt_scheme() prior ice_init_pf()
Thread-Index: AQHcI+ea9PdBoFvX4UeUi3RmtIrsK7STzOJg
Date: Mon, 15 Sep 2025 06:31:45 +0000
Message-ID: <IA3PR11MB8986497D315DAB1711099DC4E515A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-4-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250912130627.5015-4-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8A8418B02:EE_
x-ms-office365-filtering-correlation-id: 22509fba-30f0-462e-e42a-08ddf4218aca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?YlT76ELcM6Pg7YSZW0x0t5W+eDax89Md98Ouyk+d2J6Ay5+mDXHbAAxu3+uA?=
 =?us-ascii?Q?WMIP56aBP6+9WMyVIuuynh9E3GRnCh6b+5nehUJOuPvZka3oZPQ5cs+hKiHd?=
 =?us-ascii?Q?MM/+KFTPdFpcNfZ+kJ3PKJjw3bsooKD4YJCCe5yY2WC/aDvW6z3RabJ2wlvL?=
 =?us-ascii?Q?Pvnt+Athlq9hO7lRP3N64V7sdo3bFmSOeOdekeAzFf1MmEBnXBOs3jwOjLP6?=
 =?us-ascii?Q?i7xICP7GeMdZdB3qQRLAZlO2TzleUvvEh2u6JTYH1+FA5vgXlYX1LMLst30S?=
 =?us-ascii?Q?5rsBr4Z8emLVpa/TRzg3UpWwuuUJSwDSNzOtdLaEM8VXXbAhttvR9RAhXQ+w?=
 =?us-ascii?Q?cvnHiucuLJoF6UE6Eq/ekRRQSYvxKlShHcENCSgets96vxq4y2323KuyfbGr?=
 =?us-ascii?Q?NSMGfF+2O199kLB0V91QFsXHux2MCsjCpKzmeCu3Q9Ni1wWTLpnuB5vT6zeq?=
 =?us-ascii?Q?8YKfM8G7/idh83SotDb/sid63K66wA2OqIAmVUN4wgCidkCgadQur3m+DbWW?=
 =?us-ascii?Q?a8ZglmV3yjV9h4Mx5/Kt8MBqDRQhpqlu2tF2uFD7ZnwQl36O2J5mfX4a8Y3L?=
 =?us-ascii?Q?nJX9b5dN8W6a3NbZ2QYBY+s6AwPVYYTlRpPv8dVxCGFXQ36AVjF0QXHHXzDf?=
 =?us-ascii?Q?5ACgv8Ar9oEPzADWEbBPOy1+P+dKbPkWa0WCJDB+mlPbqsyTpCIfpqJbzcKW?=
 =?us-ascii?Q?jpb7VlwgFtgVlq03SmFBXRA9tzPFX1IvNc/vF39TbZwHE7WXt9e9obf8FBRj?=
 =?us-ascii?Q?x80kFf5DKxYiHTgUoZMkn+OSiMCqfqOyJ8+JMlapeTfhVu1bT3eD2OOZ68qG?=
 =?us-ascii?Q?o7ScdzhkRZnNhVYgaqh33SsF/1XnvdGAUicugQLFvC3eEJ6iX3ZlwpSIsy7U?=
 =?us-ascii?Q?Q8+o++rbyfZZxO97lTlXhbnAFvN+6NDHbOA4nh7mOeIDuSEvZHeD7eAcCjC5?=
 =?us-ascii?Q?fFYc4BJs3dsw5KoUVSru2WniaT+u8ofhQrr++OAM5l6ZAIes9nu//Vphgikq?=
 =?us-ascii?Q?Q1i3nOiKm261mVwTwDzYE9C00pPYAf6AejZmmKq3RO+lIrbpT4oNlvZlbZgj?=
 =?us-ascii?Q?fAs31kLfylMpKE4r67xKfHuVR9V+m0uZrf3LTTPfwGVfGhqvOe7SixoDBjSX?=
 =?us-ascii?Q?HeAvjyuTXjw/OqGuDft8wBI/EF1enDmxaqCHdHLBSRCM6ofX1SP6hI82OaKn?=
 =?us-ascii?Q?opgPefhgrVOm4PQpTZQzTLLWD4AomncRBddbuBeiz4rNDkZzAXMNucibxGan?=
 =?us-ascii?Q?1FFLqRG+p/5nn3lMsrSaabVjadct+DXXGxI5aWwa//aWVw1UUU54Oj6R632f?=
 =?us-ascii?Q?bIBBnXfvvibBlAZnM4H6Pco7wleG4vd6UoZ+k8JlMoXQq0w5Nhqvujtwtyf+?=
 =?us-ascii?Q?CkfXh5QGnTtV1OMt4v+5b/I7jJoY8v98RnpXs6CCcZM7MwIGPuxuain+DvvR?=
 =?us-ascii?Q?F052vqexk0Bd0FZUtggdzn6h8joELm+9R73f610ZtAyCeSqWdJf9p9PwJAgd?=
 =?us-ascii?Q?28TT/UzSlK0dPWI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U415015FclacOqhQ0vqpOM6Ucyxxyr94ADGP6uC2Hih+UVosmQW8bR9GF7oJ?=
 =?us-ascii?Q?sI81+4/oD8ZZxr8+E7A4uk8LlunluezVZA5MxkXh1eWOhTY0hYZenFMBNf+W?=
 =?us-ascii?Q?kYztEKwMUN5biHBaRV8zclHHFi+DtWkLPmLz3GJGe2y2GV7tue/rc/yrzE7M?=
 =?us-ascii?Q?U+gB4tsOwE9jfU02G3xaiAC9vAv/36R/pyrhkcgzmCa1vriWmBMOzPe1UrMJ?=
 =?us-ascii?Q?NfNdr8ATFtoDMwUaJxB8cZHEvGxhhTuqU+tS0oh02o9M3BBk3pwKC6tWOpdD?=
 =?us-ascii?Q?I/nzGLXKTNM/zU8uCDZrw5q5hmBq522luyoJZ/YiB7RpAdeVMVPoEiT5EK0V?=
 =?us-ascii?Q?EhyHCy82btuLlWyUqk9uTMyuIkjd88yndjvEa3pU1GKyiyXb1nVyNsQu1EzB?=
 =?us-ascii?Q?k17xWUC/g5HEhJSmT7IgcAGJNCPqAEL8qDhN8Oq5x0ferjTHnLep83Jj3JYa?=
 =?us-ascii?Q?c6Ge0kBrXkvGOK7pn59NOLkS7WsxIgPCYx9RN3N03ZF6U2WmerOrl+EWDMzW?=
 =?us-ascii?Q?V+iQEJQC3zCW5m7u741iR+9h/HLOHM9KQ6NtAY6FsWmeg4IkOo40HWISdcxJ?=
 =?us-ascii?Q?FViz4/ocUCL5dP0Clyvq8IuAYbyPh/pFPmM/3aEgaMwAYzWXlEGBFxDv4uG7?=
 =?us-ascii?Q?/L8lnv1Tfrns3ce9apxwARAjoJ1JQb7DexnAZJt/NmHEIToRfMM+qfF1y9+w?=
 =?us-ascii?Q?Ib7aZ8cZ8jJmmDrgh8pZeFyukVd7A6cGl4XFSTA1OfI+J9Yj4KLMjuHP7pPS?=
 =?us-ascii?Q?NVasl/D02bBxXli07DYhTu+VSG1oDlG594WYALjEoZ63kiN+K6NLjY5wV8WK?=
 =?us-ascii?Q?VAssZ/xOmKDCaIi0qI4ac7cMHHC6YVQUxH1itDA8eKoQv8IfBXb/IdAoXGZE?=
 =?us-ascii?Q?mGFXqV0/ZCW1Xitj4y1QdvLBosVoFsVUL4hI4nisD4xZpNMi9SCJ7D0B8Pve?=
 =?us-ascii?Q?JwypW6d2ZScXQPpZV2dq194M2+QukoYkAboNG7eOW0JIdrpFL4sgBGgpM72d?=
 =?us-ascii?Q?g/+LFlVb1vM1VCVYIkRQ+8/8+t0U0dPRirWYwi5U43acQNpVw9b187h4L7Af?=
 =?us-ascii?Q?boT02ZI50PvSDTnog6fE9cTNd+arkgvq3ibTxL6H/k/UYhx8bfTeM0pnlLTa?=
 =?us-ascii?Q?EJnsTh0LbRSva4USz/LgiG3V2E2rSUQaw225PgW4fX6P2NI94BAvxJ0OvrEr?=
 =?us-ascii?Q?5v3+K+8Hn6x6hmTqqJkkyR07qL1qapCvk2GJDAgutFVY60Rt6ME3Xyp88kLU?=
 =?us-ascii?Q?CRK3tESMXMETJbQ1DQtun17DT8ccccLXvyT5aK1x8T77asJW7HQXDL+dKqVi?=
 =?us-ascii?Q?3A40056r8YfYVQ6d1jrQjj6usJ8cyea1GYHKFDi1VwN7KVqYBKhoY/iI0KxS?=
 =?us-ascii?Q?dBHOLCcalrzifX90OeTBTaj21V9drdq/upd3/QkBhDvhY8uqftq43snImXOx?=
 =?us-ascii?Q?PENKBcZm3FRDsed1z9zK51IkIoXY5RB3q0dQzpPMq8qv2LeiXyFpz+WgPVM9?=
 =?us-ascii?Q?DF6kEXqiUUJFL1c11i/erKaX+x+GVYXlK3yhiOpRAbyfPhqOwOpO1v+ubtLj?=
 =?us-ascii?Q?Hai5tJLx9D+WCO0cyupoE5oVspq6B/nwH+sDmjk1pkAt3jeKuLTUBJWLNxTH?=
 =?us-ascii?Q?Jg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22509fba-30f0-462e-e42a-08ddf4218aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 06:31:45.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9C4J4nM0tpaX7KqBrtGW8W9Bg+xmVG0dpETFcOM3amqUE3skLFTdlckNbM+hYziBxqsowq5g97UbMxD6NW2aflSNJvFIMHwQQy0f6TWKZX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8A8418B02
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Przemek Kitszel
> Sent: Friday, September 12, 2025 3:06 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/9] ice: move
> ice_init_interrupt_scheme() prior ice_init_pf()
>=20
> Move ice_init_interrupt_scheme() prior ice_init_pf().
> To enable the move ice_set_pf_caps() was moved out from ice_init_pf()
> to the caller (ice_init_dev()), and placed prior to the irq scheme
> init.
>=20
> The move makes deinit order of ice_deinit_dev() and failure-path of
> ice_init_pf() match (at least in terms of not calling
> ice_clear_interrupt_scheme() and ice_deinit_pf() in opposite ways).
>=20
> The new order aligns with findings made by Jakub Buchocki in the
> commit 24b454bc354a ("ice: Fix ice module unload").
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...

