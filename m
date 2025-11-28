Return-Path: <netdev+bounces-242640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDFC934C5
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F5D3A92BA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 23:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC58253B59;
	Fri, 28 Nov 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jluj7a6V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63D3B2A0
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372666; cv=fail; b=MDcdzg+mXgVds+ZjWRzoGCA3MDcUT/urN8zRQTodFYteVAVtB4wmNqGJVq52VxjpXYHXo4mm2TYf8GfdPV4st+W+7YMeS01RBrbl7DGrykpslgDkw80zRUBUxSk6bdI0+r2lvgzIIf/tBmfqVxsHUPbDgk6PQ6a1UIiSJJ+in/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372666; c=relaxed/simple;
	bh=ZECXTYqhZUftrSl7LNauWlmMo43Uw0t5yfcOA/P3CIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c24loMQKEuznVeYn25kbrJdLXveDHszd1F1pnd5o39fIj3SVoS197ek8JX35qbywadFrqzqYuLXmL6PW+c+1IWkknxh+ohg/exAwWnlkmPk0epAV6et4PR/Cqlw4HdOYnG6F8JrWzHb8+XDxBQIaDHtMO6U15QXuyKoVHRLuVnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jluj7a6V; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764372664; x=1795908664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZECXTYqhZUftrSl7LNauWlmMo43Uw0t5yfcOA/P3CIM=;
  b=jluj7a6VSD8qJP1t6Jr7yVdNjf6tZHwHWMpD7kkleXoPGYiNdp5LJlr2
   EEe+ZPbVUdNAjF/xZcdMF76yDsZ29iNMP9jvoJ47mY5uY6spGpX/49FLA
   PLKa2c0gMEb+Y7G+rALIre4jXYyGacEsqaPkkgn3IVBLzlhNTWeOGHBMJ
   9NDeKX4nSj4OZzkFRVILKtNalw57WTBwmGXzGk2C1QBh7BNyrtSn1Rwhb
   4cpe/mP8kBiKSEXjOTfyf+gPJqxo6gsxo8ZSL4SYgSp47OvAnT5kQMoQO
   4NcK/1NXAYFCbt01JsP8GSBo19scyCcA1ZioVzriXsURUKkflhooxGXMj
   w==;
X-CSE-ConnectionGUID: 6azhKQq3RyGvRGfSYWX7rQ==
X-CSE-MsgGUID: lF9UlxpeSOScQMoyrmXZEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66429884"
X-IronPort-AV: E=Sophos;i="6.20,235,1758610800"; 
   d="scan'208";a="66429884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 15:31:02 -0800
X-CSE-ConnectionGUID: N40g7NxPRnaSqRhy2o0E6Q==
X-CSE-MsgGUID: 8w5/g2SfTomqq+3wMOMYrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,235,1758610800"; 
   d="scan'208";a="193554881"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 15:31:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 15:31:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 28 Nov 2025 15:31:01 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Nov 2025 15:30:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QytsiKJ6Kx5JB+5bz6PaNHZfhnZa2D+OmNWCx9ovmZcL5nWz3Jq7EB9F2PuAOs4x8PfCvxqHCGUATT8oYw1QvPZChMzRdO9SC4hjNeYM2gujAM/PGGTvgWvlyaxMx/vk9OyB6drrSJiMgBKdX9BLtwN9IkgLoQILBBAJHXWDxCNR5uLwP1sIj+Ghk966ElPMYOCBpUSNgIL2W693YX+wBLrkQFobBo4qgmm7quYxDt3evCCYU+V0dCGGkOv5QACYgULpwjJ+LsA9OG1tUJoh/aVXy3vJwXlPJz6AbzHvT06uy86u+bWolM67t1KnsMsgRi6XccNIJPUB1yFsC3vmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmSUy1t0EMmUNkqlcpzNFX/FbAqDVUpjyqlhDv4NR78=;
 b=hvbs5Ex1qN8lZ5H9efFrpI3tghP6sIkMT7M+Y8naUrG0Ix7LXD7l5JuPuDPktdk7OkS+E/adKLsLsBeXa0JcvX+M6+3UbdJBz+mHQ+2hG6ZWl/FNEboWDH1z7Fm77LDt6WYKwn1IuTdfQlO0PB1qnLC2ebY0GDG5ULeUjMwfbCKOBEBhIIcuD7bh7Rd7yeBojZYAyWpmc4148g70pGqkbJi4qPudQeUbmFuBtCIrenFI16kmno1ofZXFgpAxMY5aA51lHyB4E755gd1j2FdV+bo9xwLKGau7G0OjLOPztI+rPqUdPakjhreH8v//8Zu67YqLFwZb7Osn8ZakoLfblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Fri, 28 Nov
 2025 23:30:48 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::bd8a:8f94:f384:bf93]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::bd8a:8f94:f384:bf93%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 23:30:47 +0000
From: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Subject: RE: [PATCH iwl-net v2 2/3] idpf: Fix RSS LUT configuration on down
 interfaces
Thread-Topic: [PATCH iwl-net v2 2/3] idpf: Fix RSS LUT configuration on down
 interfaces
Thread-Index: AQHcXXL2odkNMTokKUSxthrMSSgKfLUGa4UAgAJU34A=
Date: Fri, 28 Nov 2025 23:30:47 +0000
Message-ID: <IA1PR11MB62896483A29729204B33F12989DCA@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
 <20251124184750.3625097-3-sreedevi.joshi@intel.com>
 <aSg5pg9aLwmiVR6G@horms.kernel.org>
In-Reply-To: <aSg5pg9aLwmiVR6G@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|SJ0PR11MB4973:EE_
x-ms-office365-filtering-correlation-id: 21579805-cae0-412e-0435-08de2ed62905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?+ekeaaAn7LIIcsoJ7qvKCptYGJAqtf7jNUCaevqzpESL619hZrRpqiUoyR+o?=
 =?us-ascii?Q?ZuNm2B0+DnYCfqfc+i1shsg+S239GJGCnoZbf6SXkJTmO7yPsALl8FkSWxLb?=
 =?us-ascii?Q?WIsUD71j0Ocfwpln1uJmZO2miY+pcMqiqAuPfXiW92wu8b8jIslR04tM+NT7?=
 =?us-ascii?Q?F8Iz+Yx9cr+3sEwfkVrNWvPbXyGAJFr0yQkaVkNYLtzFhAwmgFWZIoQVW3c5?=
 =?us-ascii?Q?P1+rkEWc8X+reLTPRhWWjRUtlXUhIggr8s08Q/RQCxyhoJUEeAKL5P4rHHGy?=
 =?us-ascii?Q?DPOkY3coHB139mooRXslFwqZXjoqgMZA4Rchuc0V5R4sINNGwq4zl3QF8oJv?=
 =?us-ascii?Q?R1HZfceZn9pSGmsFl+Vx/gsi+J31k3yOsYZEOgpZq+wvMbzEKHYAGEMevTQt?=
 =?us-ascii?Q?IHE+JvnG0pMdAaOGtVMtJ6uehYIB8XALc5Z9+EdN9eEHXWiBa6zOn29g0eDD?=
 =?us-ascii?Q?HZQp90KJiCo54v3h62Z/TzUkyTMYRoOBjvcVhXCnsXZJrZKqiLzbvzkHxLFj?=
 =?us-ascii?Q?2P3J642cxYL43CuiC0GfhMZ5VmkpciBtxSGGYGQTD0zjXrp8lbaRjJFCqNAx?=
 =?us-ascii?Q?DefQwGg1U8tjwB4bARNVjFEHoD2TG6P37jUP6VWbLjjZG3bf7arI76NnTug/?=
 =?us-ascii?Q?IOfqDQs3L4wvtfW3UaimDfqJnKZOC1EUyMFPPAaAYhZyY9mZpwZnhmHP5iw6?=
 =?us-ascii?Q?ZG3TxsZagG9hzSb1L9pNYYjZyCYt2jWjgeFc80eph7ZKZudRXHYe7b4zqzSQ?=
 =?us-ascii?Q?7ksuJRQb5t/zyqi6dLq3EgN9Aue9Vr7WYngzc4Vsqx+FrdR+Sv4Rv1b/E+ri?=
 =?us-ascii?Q?TFIix1YjjYPcpmoWosqaHeoiRlJacdOoXN8MFKFvBCExF2dv9mCcNiY6aJwp?=
 =?us-ascii?Q?VWaPBokVa/wMMhmzJ8jpiI5WiHM14PQcYgDrsc3kWKPrUTcrh8fVJXmQn4E6?=
 =?us-ascii?Q?gS3WDryMK4Ik24lAK4tPcsuVlYl7rGr26jqpxcwybKp+RL/FpyucwqSYALD7?=
 =?us-ascii?Q?VqKYPYmOG3i9cdv1ECnJHf/ZlDxsFM+AjE3Pag1UG3E6Em9otDREOcrNo8mg?=
 =?us-ascii?Q?ERfA8qnm2ZUVIkeaKIh64PjduTglz7+y6sgz2RHg2GjK14AwXllIXNrgnkmO?=
 =?us-ascii?Q?m3rq24+t+YfAtKb8jxFGD+o3o4iRLlY5/EEByKVXTe9jrAOr5rXyTN+pZfM1?=
 =?us-ascii?Q?nwz1YfauTMIEqUQTgoOgyeLA7N5mHxRDoqKgHOrAc0UBGQbtTD9E9aIteF82?=
 =?us-ascii?Q?aw0CwSE0hzAXJjEoi48GRpyxZfTXGD5dCoo0eRgBzm11UE46ShaLa/GxWLWz?=
 =?us-ascii?Q?30J5W2S/61tzaCZSatc0TbOC0Bg8hQNQq5K7dFi3IToCVkiAVKIXdZLzn/x1?=
 =?us-ascii?Q?Z3otgQxRZ/5R/gA8Q/EWEJSkTEGiyhIjfBVNxymvPLv9ZdwIhNT+yjoOGvLn?=
 =?us-ascii?Q?qU8TasAT6n1OrMzF1L2RTyDBNkrnOEkSJCC97UdTNsxIZFT5rZ6SUp6HO+N5?=
 =?us-ascii?Q?g86BevjyCpFFrpqoacR1MmEtakRoo5+LlWkS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fvUDxgX1wIJ5qvC4nLxKySpBZvhm9jXLmh7NDyD75++lS24WcM1x7iZQCiOB?=
 =?us-ascii?Q?vf+GiWM2MpzuDdR8M+FxpurJ+b1LaW59bH95iViaIW2muL1bUBqOz3iBeK4p?=
 =?us-ascii?Q?LaFHegXnwAGOBuzlaBlHD/xzch867PCiWjuPbUPsBHZVTMdiKorvmXavzh27?=
 =?us-ascii?Q?/7PlFeRLr5U0tieVcDcvidNeeh2WroOlCyPZovEn028lj0i20GwYr7xF7EcC?=
 =?us-ascii?Q?WoEtjOaxR1g26XeEwuefXzQiMgvmy3GI7FZn+aetPTbC1+vexYkNRaATTWXG?=
 =?us-ascii?Q?QoZfEw7gJXrvNWV41lZr/oICpIC42lpHF6XZ8KGH80gI6uDDKEXOaH9N3Nk4?=
 =?us-ascii?Q?GZytdfzdncl2bGtPCX7LX6p7bYY8vVqnBq7g/TJ8E/H6AfORq01dAwcEIr70?=
 =?us-ascii?Q?UWWbVNpHfdB/qFGRCU4hksqW7IVdvOmv7gJsY1LLzXO0y9jPhd73J/KmUHLL?=
 =?us-ascii?Q?NgRoTGuz63mxM1lnc4pEHP2eEfinHpKUg6NoiTQpT228ccdGdlRIxAedcp/S?=
 =?us-ascii?Q?WZo8GqjBOBGTQ/j8xLD3fxUhcwmIhQf+uXrMaYVjCRfAsnUvi8+Q1a8bpal1?=
 =?us-ascii?Q?mwhme19WlgLSQ03ahGF/xEGoBTwKLqTeu+6Y2X5//O2n/7bMgtOJbsSLjmoC?=
 =?us-ascii?Q?HpQ+JOWLH3VGTBc1pdvfcsg5utC3ockPYWh7CyZcjIotyRtlILk1Tio+wf3I?=
 =?us-ascii?Q?JPX/8KYGTt9C2qPGp/hBXycsZt6grDvF9eu+w8rUdD4UTky2PaFmLUCoKnDm?=
 =?us-ascii?Q?sV8mJjp323oglv6+pt1VzxoYvf3YYYfo2dJHRjFKBmgRR1IRxon6CT9hTh0F?=
 =?us-ascii?Q?IZaTZ7C28RoVbUCzcwI8wjN4ew3L4un8aDcVZ8DcNEQEc0t9tphquOxvCmdD?=
 =?us-ascii?Q?F5Z9SpcctoijtTxPQi5d/z7oY5M++c6JaZbxRXBQjuJIDeW9hVo4JK9ZjrOI?=
 =?us-ascii?Q?LXaUQOo4M9pt4wjbZWwDBKurD4O6NOlJ6+DV/h6emRXryIjS5xBcmjDQSJoN?=
 =?us-ascii?Q?9tZfcTdZ3ZiJ+twD31+N/rYvjz6M/mjkOAi6fXH9TO9OFma8GHn2FRyY+BgE?=
 =?us-ascii?Q?puiyzHqJxlO4ixUKlp/+YmA6VoZKYeqKMXdhjmv89ADlsspQyO4NZFM+uRuu?=
 =?us-ascii?Q?/aUUuMlmKSb/G7hfZ67LsWidpmvG1VgSDGteFkHCrD8HkgGkKrQK8mW+pBJZ?=
 =?us-ascii?Q?Fe7gfpIVjzIOj/qky9N9ebgmgxQkCEfxrxaxTZfx2IcxD50L6Mbsg5TOXjhd?=
 =?us-ascii?Q?rYk7QE8TANSgZFMeeN5ERalmtPbTu+7mmhXM+Fr32E9mr9nuj2YVB5QziYER?=
 =?us-ascii?Q?viwNLcl+jJfJNAe9L4qkhHz8aH30Pg0TFCuaP5FYIul4qy9MzVmyQSFQh48u?=
 =?us-ascii?Q?pHYWOJjFKhyZztGTNQB/dNDtpl9Fqcpu1//n8bSeET5Kyc+LRhyRil9Do5wz?=
 =?us-ascii?Q?WmD0SpslN7tRQkVP5tFVugoyJSMN7zIlLTovXOAT0A3egDKvbeEqZEmtyt/e?=
 =?us-ascii?Q?KiCv13vuVc05l/B+L4JzJ+XbZAeKxLqmD3JR0efQaY5dak6AsD7S1ArqxaVZ?=
 =?us-ascii?Q?WsEWzrPhs5vIB1teJq6O0KEJ23Hnjcpe8EPUK5hQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21579805-cae0-412e-0435-08de2ed62905
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 23:30:47.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtWD8GEG3jpR8XZsCw/53ZIt0Hkiv9CnHR7OEubHs0Ww1FocmCbYiMomG3hO2G9vT57hcSPSC7Aa0LsAeLygioi0EAi+TNAY/pFrrlOEEO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, November 27, 2025 6:45 AM
> To: Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Loktionov, =
Aleksandr <aleksandr.loktionov@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Tantilov, Emil S <emil.s.tantilov@=
intel.com>
> Subject: Re: [PATCH iwl-net v2 2/3] idpf: Fix RSS LUT configuration on do=
wn interfaces
>=20
> On Mon, Nov 24, 2025 at 12:47:49PM -0600, Sreedevi Joshi wrote:
> > RSS LUT provisioning and queries on a down interface currently return
> > silently without effect. Users should be able to configure RSS settings
> > even when the interface is down.
> >
> > Fix by maintaining RSS configuration changes in the driver's soft copy =
and
> > deferring HW programming until the interface comes up.
> >
> > Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> > Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/n=
et/ethernet/intel/idpf/idpf_ethtool.c
>=20
> ...
>=20
> > @@ -424,7 +429,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
> >
> >  	if (rxfh->indir) {
> >  		for (i =3D 0; i < rss_data->rss_lut_size; i++)
> > -			rxfh->indir[i] =3D rss_data->rss_lut[i];
> > +			rxfh->indir[i] =3D rxhash_ena ? rss_data->rss_lut[i] : 0;
>=20
> Hi,
>=20
> I feel that I am missing something here.
> But I would have expected rxfh->indir to be populated by rss_data->rss_lu=
t
> regardless of the port is up or down. IOW, I'm unclear on why
> 0 is reported for the indirection table if the interface is down.
>=20
Interface being up/down does not affect filling out the rxfh->indir[]. User=
 will be able to setup the indirection
table even when interface is down and query the table as well (changes are =
cached in driver's copy and setup in HW
when interface is brought up).  However, when the rxhash is disabled on the=
 interface, the indirection table has no
effect, and it is programmed with zeros in the HW and returning all zeros i=
n rxfh->indir[] here reflects that state.
Thanks for your review, Simon!
Regards,
Sreedevi
> >  	}
> >
> >  unlock_mutex:
>=20
> ...

