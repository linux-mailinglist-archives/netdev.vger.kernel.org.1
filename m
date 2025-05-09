Return-Path: <netdev+bounces-189151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7CAB0AEF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4FB1C07619
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6626A1B8;
	Fri,  9 May 2025 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJQNk1x8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D726AA91
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746773497; cv=fail; b=K6R6HMyb+17JGD6wsudBioQbByhbNHamz7rBsk8ain4mKc4R9agFhmaYLsXCmAhccCHsFozWZ4DUH7Glg5yMi2GgM7ZkRL6+LDtuFm3aDhU+XBg6dyUMFiOPXqyPhvaAAd/eptTncSL+1lElZ800BXSrdn/XWZek+e3nhEN33aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746773497; c=relaxed/simple;
	bh=f0XnYQn0z4oiNKEfFckeJyi1WjGup4ZgOF9FhotVp2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uk5wmfYj4Yg/g3Zx2fIVS4FgPMonQ939T12LPmgKm8ogp1YxlJClF8+uSBfzhg/w7NXAZ9SRt7RGkQcZDb8g8g7xudhyg57ekWMgx3hS1aScLjshx7yU+EwXRUXGrj97w7OwXj5PcW78COdG2kQzYqPjuFLoWzUwyQW127WCYkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJQNk1x8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746773496; x=1778309496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f0XnYQn0z4oiNKEfFckeJyi1WjGup4ZgOF9FhotVp2Q=;
  b=hJQNk1x8mNKvpX+eMtlpsbqhX+M3879bm3eWjCbmlehw6UXeBoH0fYqw
   LVYGVcEONqpXtNgwToZNMshXKxsaa84464YWX6pZ14pUTZ5cvOqk/fkgv
   8vuMyhP/Za5NJ1kXC+pvk5i1YA2FydZwPx9D4NlL6RpkMqiF+lURtRGaU
   8jl7eFG7QgqF7/WdkjC8S3YYkBGznH42GB1dEyhoGub/Uvf1IRHY64TrD
   qA6TYSmq3fu/sqGhEz8weND12vgbkCalYx/S9J7ZblXl+4olZ6ERnZ+bK
   H+N7OQTZJmKym7NDZvNQqQUWhP5JeuHZ3EuN9NF7AUlyTK0m4FdE12zdV
   A==;
X-CSE-ConnectionGUID: kD7oaOeeSdWhtGxYZEFlhQ==
X-CSE-MsgGUID: zrk/skq8TQOadiul1wqmuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48703032"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48703032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 23:51:35 -0700
X-CSE-ConnectionGUID: VjBVSj61QZWeex2mGQx2+g==
X-CSE-MsgGUID: SazvmSQ1R6aY8IcrGzU1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136484954"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 23:51:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 23:51:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 23:51:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 23:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJHKa0j0B5Fs6tILhI5a9rnolxG3dKH1dbQH0e2P28Laf4EQoyTfHhM0D/VdWZXTYSpCbA8YIZIaqBSyU+YwQg0SCiV97ix0ymcEiwcpb+z4iiiBZVa6LRlrpoqGZBDb11AKD4tEEeQo9g6qVQFEF7oHCiJreU+aXRXa7BUVBAq2I8QgwEnpq4ZSCEjcku6uNcrO/6R3BZ9MG7MpL0KrR6pc2rDxPihYPUNDEFeGG2iCPys7wdVfRAonWr/usGc+G7BqBV1QE31WkdAT60ZfXsb8NtZjmErkAmumIWz1vz2ihrgI/ujqM5/kVPfjGjmIncFBWfyjL05lWHrWNe+WXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPWL02C4V8ZQtQIJRCuQcxPV0SP7o9vmXwioLSf+HFY=;
 b=BnoWC4K++BJAip/HYFHUV7ZCaJjVfMApKifMHiCgvI6DYEMnPAcT7uGLgfTY1Hk6VqJhcuq9FGrZ2nyhjZHMgshENEGE7rfh39jVyVbTnzEPEOkTO8LG3/W5ZSjo8oBw/xOwPHM9Ubcx9FTLOHqz5XrmHYnmq8jwFNOYJ7h/0cD0w419k/rZFQmCVET0MfK3gFKs9XDNJES6i4sISJDWfrSAkalcPe2KvTCG+9ShXcufJdUFPHv0WRuGPxyBEbn2otFer7EgJx3bVSFs04sBPpTsIUWVv5MKB0E/rmasVDXX6H8r94UrMg1nwoX/SdXbq+iT0xMqHGVzeMn0mCH8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 06:51:12 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8699.019; Fri, 9 May 2025
 06:51:12 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "decot@google.com"
	<decot@google.com>, "willemb@google.com" <willemb@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Zaki,
 Ahmed" <ahmed.zaki@intel.com>
Subject: RE: [PATCH iwl-net] idpf: avoid mailbox timeout delays during reset
Thread-Topic: [PATCH iwl-net] idpf: avoid mailbox timeout delays during reset
Thread-Index: AQHbwEpBaogIXAeNek6JRtXMP70mrrPJ3Nuw
Date: Fri, 9 May 2025 06:51:12 +0000
Message-ID: <SJ0PR11MB5866D9CE1762BC7EBE30DA40E58AA@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250508184715.7631-1-emil.s.tantilov@intel.com>
In-Reply-To: <20250508184715.7631-1-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|SA0PR11MB4559:EE_
x-ms-office365-filtering-correlation-id: d046cd23-2074-4d02-8e7a-08dd8ec5e2d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?6SHwpkZU25kzjWJCTD5N0ZDpBjjmaAVxlNZ8Hsy28AwZ6MxhtN2VI4m691kf?=
 =?us-ascii?Q?CcNABxUhGuAOQOg7P33+A7Q4ZdnIfjFXWyNC4wauWwSlLgk2AY9rRWOpnL2E?=
 =?us-ascii?Q?N+RHeu/VK09P71fi8yKNwggfmTq3bQWcVlx3poDQ87Z7AWM2aZEvzcdtecw+?=
 =?us-ascii?Q?yM+gC6mk1njZaBojeU0ROjProp60irguvVuQk8igtysDXQBMzEBWtr5dPCDg?=
 =?us-ascii?Q?mptKMTi7Jo0kaLtnzp2Y/tvsuACXrV8ju85dp/HgVmKQwEJ7K+mJe0NUjSOZ?=
 =?us-ascii?Q?jE93AiVM50Pm8/uZrppjf/2N6PzjqLCEkPyHo4C1DRv/rNvkBtyriRU6IOV5?=
 =?us-ascii?Q?biQzDodFUd8wSK1MTloy5qizqQ73mzAPLkgLgk6fDIEojagI2/jJhSic0rDE?=
 =?us-ascii?Q?YT4DDn+42q/h+vES5qFjGc/VcDiZCadGhbUxjP2znA+a9+nS6xKS7igQfdpC?=
 =?us-ascii?Q?SBspt4vFdQsEPPOyxitB5AEzWo780OeNzUYFaoTv4KQZPfZGF5jjv6aSrQ60?=
 =?us-ascii?Q?9vcJRBoxaKjS9MJUw3M+VAkm7U1gy9uA5FXXnfuco2AgZO844P9Araqdjjkf?=
 =?us-ascii?Q?LWNzZ79ALQRyTIGFguFsB6Pc82vqabeEa44rgDe7XyrF8YG1Y7HoXusFa4zM?=
 =?us-ascii?Q?s5I+hQI5127eUCQbpTnmkqXIEgAvo9rrrsD1mh8qQ0KmOPHm/mS5IwaDCh5A?=
 =?us-ascii?Q?+GXgk5tdMP99XIvUBPfcludk/e7AaiBMfPJlFI+zXK4XisXWKr/0BjrTw/EH?=
 =?us-ascii?Q?j5koIXU827cCuGD9MqJPEEj+FDKRgexfhrEtGscbE9V0bP7G/HXypxfuk5Ft?=
 =?us-ascii?Q?wqzsGEJ7okL4/tGmoXGNmb6xS8OSqzZcaxoI1meJcjg2/11yWRkoMRBxEh4/?=
 =?us-ascii?Q?a4QFcSir3jcY7FAUpH8RgHYLl5QFV8mZ7VAP2aUm/sKtI9367QUQs6UyxeRb?=
 =?us-ascii?Q?Xp81PqZ00rkIRdRMRtf7VH5Z7DQv5gGYazruyTGojAF+ss1V4kk77r2HB1kk?=
 =?us-ascii?Q?wiEVZTtu85/Zoma3uqdrZ8EMXzxgfHNyAY8s5YFKcjLCVEa+IRK5wrJwv5Gs?=
 =?us-ascii?Q?RHTSWL+/v3Ld9lwNlNP2gyfQaWp2wv4AWz3o/3gxC1Uk/ur5b2EgxvzwLJpY?=
 =?us-ascii?Q?OUsYnWnxuSKuqmDEKlijR5UkLysY+rQiF21guffW5mUhG6gYwcTiW+sbvkMt?=
 =?us-ascii?Q?pIcD+Lme5Exe6ijJwS48YrPA6zTLwagqVLtznEa6utoWiCSpZtK+ak0xqHnm?=
 =?us-ascii?Q?upYlXnMn8rN8exjW8Dl3lDqcFqNtXJTaZMzIKyEBIS2dlepxbjYXu5Rn0SIy?=
 =?us-ascii?Q?k92B2Yprn9lnqMNoUmUhwegITtUYXyERhxVp+bZEzadI3OfGPp9oUAlLt/ip?=
 =?us-ascii?Q?HuP/ZD7g647QlK/zKwAiI/xxZTg8/nGZUpGng3Cmfa1HGguRbdG7dziuyhpj?=
 =?us-ascii?Q?uf9t6UnUGg2njlEqgf/E55cGTrIihdLITxIn2RBWkjnAhcW202r1xA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+2UuPb86U9Mdh0RYiFPZjbDB6OCTHRybj8c/KvELRqYHYDP6YIDMXoDlAChZ?=
 =?us-ascii?Q?GNuH9PMAlk6YcLc1l4OFH3X74XxscSJ2Ablsfbsq3bfvYOAy6kyLKvN+0kp9?=
 =?us-ascii?Q?mKxBDfqSbY14GAMi0cGLZUvH9+Gnzy7ryEDi/gAQT5Dk+SeLssCr1V4DtqLH?=
 =?us-ascii?Q?kIPUEpGKQioqMN37dYTPQba9CHyF9PZavo/dOzSlLm3D4hkCckWKoClJBILM?=
 =?us-ascii?Q?aNFId8Qd63E6WPEocsyBX/Cnl6lOffsxII8Ro1PNjz7p14SGqLEAvZgzAeiR?=
 =?us-ascii?Q?AM+30dsAZuJY6vktZy8i8ietHQ5Ia0NspN6UeK7bMRLrR1f5VwwM01LHf2UO?=
 =?us-ascii?Q?qRIEsbXXdEeuTzuH3hg/I4GY3ph4Yk2GNlnTzXFdZbk8ohnJYtxXtTvP5Obq?=
 =?us-ascii?Q?/gewZnGL4NvRvm0v40Df47cDYQHjbrgpwgIKKFkb9ET4/0sp6ZTWhQfIB/5t?=
 =?us-ascii?Q?dqk1hElLdeH0jd+hixs3Xi33n4KbM+MPEBCAEVK1LBfzZQ4oC2TF2ciJaEht?=
 =?us-ascii?Q?cmGB7s7SjSVmKrIQCxVM26jIS35PQmoFlFFkX+GQlvS8AGro2lMiZ48rmdil?=
 =?us-ascii?Q?uDrkf0sawMppeT3gvjcdIWUlWJHOcvUbq15PaIFA7sM/0aRMe8gWMRxAgXfj?=
 =?us-ascii?Q?Qj4taRkWM+qDW8s+bQtBQfbruqkT8Vf8Helb2gf87bgniR7zh289Y5h+t7SU?=
 =?us-ascii?Q?imxll8tSsuGJsvUrnGI2+IQ7wlfMABMx2f4Yw+FAuhSO+mA5dr/fYdgGFJcv?=
 =?us-ascii?Q?+On3qq1H9xjscRMVYw0bu//1GPkE5Z342o+KN5ZxGfLzP8i7pbRYIfsIvJ6N?=
 =?us-ascii?Q?xM0Q2pn/pma3Ms/WMw6sDiMXDU0/uyUy1Nf3LWpoP03K/WBqGQmdi/kaYaoR?=
 =?us-ascii?Q?Q8WqYckU6IisICyk3BxtVaQuo12IsS6hfmvEcBAf95pxmcMQld5HO3/gVE0t?=
 =?us-ascii?Q?WKK3vd01bBDvW84Ybq5DHtGbGYAKGQUyGSmMQFoFXot6nkuKFmxxj9otOJPa?=
 =?us-ascii?Q?pejhfCao+FriELMUGduzEYb671mb12yDbs+tlWH50TfqmcfU3a7Jf8GTJeXN?=
 =?us-ascii?Q?3q3TL3S64CFmxzzR01HfxsAAmNeKS4FrG5PNhxNYw0vTRMrpSGqpQKpR9GAS?=
 =?us-ascii?Q?4PEhakOpWz1dzH10jPt3Tthi6wIs1ecKLP4820gIRE53YyCrL9ee95qIFe18?=
 =?us-ascii?Q?qH15VZiud6Yfzkw9qbu7gZUAjfBP9+rUvMbwFmTkGpJOaraj7oJPg5iOzGBx?=
 =?us-ascii?Q?a1VAH7VcXWBX4QC3ZBA67NZ3LTkqaaXsZu1bY+XxyiqmzaUIf+kRh7mHi7vJ?=
 =?us-ascii?Q?MVsvBlyIutDOcCNwbU/VEtGv7k5swz7zrsxNSx3XwwAeagFxXdrrTcU1hzAf?=
 =?us-ascii?Q?qb/I4JSN5d3Puq4ORORxMwziVEoPLgBwUFW1cLNfAWfDDR2KJq7HDGqQoHR6?=
 =?us-ascii?Q?Xp2+dciCg9yDdFV0AUz+ZBaLZc7N2pi2z/CPA5FAYW5PLyOojffMt6xjlzA5?=
 =?us-ascii?Q?L6ujqWETniq7SJc+33gTWUgZOscFUeD8fVBkiGLQoqpVtv3EhQ0wmknRk8ff?=
 =?us-ascii?Q?JD1aSrWAirRuB8H+df3XuPAnmoyWnhpZy4nzB9circXGTfFXjnvrr5/syh1h?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d046cd23-2074-4d02-8e7a-08dd8ec5e2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:51:12.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUbFjcg2Qm2MQOl8p8YlMLV8AUS2n02zImck+wSpZ+zDc+Cfjodh0Tio1YVXScrGaphOG4MvEPGPpHasihhb4Xmz56ZDl2z7mpHWeQvGoNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Sent: Thursday, May 8, 2025 8:47 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; decot@google.com; willemb@google.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Chittim,
> Madhu <madhu.chittim@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; Hay, Joshua A
> <joshua.a.hay@intel.com>; Zaki, Ahmed <ahmed.zaki@intel.com>
> Subject: [PATCH iwl-net] idpf: avoid mailbox timeout delays during reset
>=20
> Mailbox operations are not possible while the driver is in reset.
> Operations that require MBX exchange with the control plane will result i=
n long
> delays if executed while a reset is in progress:
>=20
> ethtool -L <inf> combined 8& echo 1 > /sys/class/net/<inf>/device/reset i=
dpf
> 0000:83:00.0: HW reset detected idpf 0000:83:00.0: Device HW Reset
> initiated idpf 0000:83:00.0: Transaction timed-out (op:504 cookie:be00
> vc_op:504 salt:be timeout:2000ms) idpf 0000:83:00.0: Transaction timed-
> out (op:508 cookie:bf00 vc_op:508 salt:bf timeout:2000ms) idpf
> 0000:83:00.0: Transaction timed-out (op:512 cookie:c000 vc_op:512 salt:c0
> timeout:2000ms) idpf 0000:83:00.0: Transaction timed-out (op:510
> cookie:c100 vc_op:510 salt:c1 timeout:2000ms) idpf 0000:83:00.0:
> Transaction timed-out (op:509 cookie:c200 vc_op:509 salt:c2
> timeout:60000ms) idpf 0000:83:00.0: Transaction timed-out (op:509
> cookie:c300 vc_op:509 salt:c3 timeout:60000ms) idpf 0000:83:00.0:
> Transaction timed-out (op:505 cookie:c400 vc_op:505 salt:c4
> timeout:60000ms) idpf 0000:83:00.0: Failed to configure queues for vport =
0,
> -62
>=20
> Disable mailbox communication in case of a reset, unless it's done during=
 a
> driver load, where the virtchnl operations are needed to configure the de=
vice.
>=20
> Fixes: 8077c727561aa ("idpf: add controlq init and reset checks")
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c     | 18 +++++++++++++-----
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c    |  2 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h    |  1 +
>  3 files changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 3a033ce19cda..2ed801398971 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1816,11 +1816,19 @@ void idpf_vc_event_task(struct work_struct
> *work)
>  	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
>  		return;
>=20
> -	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags) ||
> -	    test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
> -		set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
> -		idpf_init_hard_reset(adapter);
> -	}
> +	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
> +		goto func_reset;
> +
> +	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
> +		goto drv_load;
> +
> +	return;
> +
> +func_reset:
> +	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
> +drv_load:
> +	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
> +	idpf_init_hard_reset(adapter);
>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 3d2413b8684f..5d2ca007f682 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -376,7 +376,7 @@ static void idpf_vc_xn_init(struct
> idpf_vc_xn_manager *vcxn_mngr)
>   * All waiting threads will be woken-up and their transaction aborted. F=
urther
>   * operations on that object will fail.
>   */
> -static void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
> +void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
>  {
>  	int i;
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 83da5d8da56b..23271cf0a216 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -66,5 +66,6 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
> int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs=
);
> int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);  i=
nt
> idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
> +void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
>=20
>  #endif /* _IDPF_VIRTCHNL_H_ */
> --
> 2.17.2


