Return-Path: <netdev+bounces-261920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEkBA2XPoWn3wQQAu9opvQ
	(envelope-from <netdev+bounces-261920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:07:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 395B11BB360
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3414E30072BB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420135CBDD;
	Fri, 27 Feb 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVswncm5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851B339B3D;
	Fri, 27 Feb 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212054; cv=fail; b=Ekj73c2xZavDFd69tLJ7YP7/+xWiXUMWJBmjVc2qNSWDtubOmiJ+gaiiXbztQFOoS8X9AlaXfyMhiYtSra+YrL8oV8v86EXqNPUeg5OIFPJNdWWEBDehsGYL4agWl9L377xxM1dvRil/VmY7qG1dbIUQxelCT7ivIQk90URtC0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212054; c=relaxed/simple;
	bh=4LfTjtrx66pbAgFuQrfb7MDu1f9lWD6fp4GZu92fVxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6vd2pEYalFjWSziqcRyTD3cft8EyISz3v0Ii3rkE03qvD/AsjpLUap/N3izVjgvZadwyy9aGld2eew3nIpYnANC7pZYBjPdkPcnBz4Olw8gM5pmug1lpKfL6Fy0dsseitZwJXVGFKrWhN/Tr1gLJs2haCyAuOEw0uYKKFRjuGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVswncm5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772212053; x=1803748053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4LfTjtrx66pbAgFuQrfb7MDu1f9lWD6fp4GZu92fVxA=;
  b=GVswncm5caVXV/R7J0sWKWkZZGEH1NDOTfrB1ieOjNpST+hZo8oI9in4
   0ICedDTX58r5edPf39dtM995yoTV4V88NKACebAUQX7R58gtITu6/IH50
   18I1HoCJwtTxAqiHs4hueMeTH3sXcL5yXgB6Tn6sWdgjID4P4M65dhXmH
   zUFbdyZs9llfik4PDti8dN4R/zgCEeOwPMnctpUVmxcY5b7X21YiUzklU
   faFSjAnmhQ+lHZ+U5g2QJ1rA3KqdRPzcD3/L6n7w5Lfm54muyIgceXj7m
   +XdTyMCE41IhpaxFG3i4723HM1Uu4NvvhUkO9Kr8HGC18e37J9qrjT2B8
   g==;
X-CSE-ConnectionGUID: lUCcRnj6TnakU/rq3VzEEA==
X-CSE-MsgGUID: ehGGRiT0S4ejEPwQnbsr8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="84384243"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="84384243"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 09:07:32 -0800
X-CSE-ConnectionGUID: OJ1sgxCWTwmzMYTtbN1TZw==
X-CSE-MsgGUID: MMtsJdzwRICkAvmGXbOCCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="216848026"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 09:07:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 09:07:30 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 09:07:30 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 09:07:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZq5fT+Cd+6RCHXXZqIXUXBh61pQaeXfXOPxZMOKQ7Ru7XmL84Tfnpa6NOGrlWa6atHCU3puyMYvrLWiqsniwFT6FGP6wC198cryLgmqp7U/Yl44N6Cl2Z3d4DFhPjFXFGhSw5yrErov+Ti+iaiJ5jHCgDxdnFhgNi9A96gBknJkj0KKy8RRazkFpEKKptKcTvISmRYyu8viYSxsRQ7fjDx+qlf3tuk4Wgr2ruenh1SjoQDwKEdMaRqEmEr5hZ7zRZbvnHcErla4g6jZ84J+5pPCYvuKHipiXlFF14btGiRpHem/1PTQ7TylOb+R0A09WP14Nd9djYTgc1oSQQ6KXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LfTjtrx66pbAgFuQrfb7MDu1f9lWD6fp4GZu92fVxA=;
 b=jxKaqQBlwAqA8K8H9fe8lB5dKTwhu85fTVSSR85jB7RCZptsEfsf3dsB12s1NKeY6CQvNQ6w/YZ3P0WDA5Sdc690tIc0jC3P10VvX8jJIUmm48sr21zEZTp/U/1rqZX1zBy2DB/NZUR+2e8osFth+O3bJoTMYzRpFmeiJbMeE88wL0DgFPwfc3mPOsWAoljvcoqBKaOt2NfEBmJMCpoXozKghREEOm29Vc1+o2hgTRLTiKxHwAau2GZ60NTbMNRCEO+foqzq/zpejAkYlYjlsB3lvHpvooiRBVCPiTFTfrj39lmaIeyGlVgyGhCgJ8qa3w31jP8K1Zzwhf0tAMvzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPFEDAA4523C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 17:07:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Fri, 27 Feb 2026
 17:07:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Steve Rutherford <srutherford@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [RFC PATCH 1/1] Fix header clobber in IDPF with
 SWIOTLB enabled
Thread-Topic: [Intel-wired-lan] [RFC PATCH 1/1] Fix header clobber in IDPF
 with SWIOTLB enabled
Thread-Index: AQHcqAnKIuK/e7L28UykSn3iqmULK7WWxnAw
Date: Fri, 27 Feb 2026 17:07:28 +0000
Message-ID: <IA3PR11MB89869444021DB688904EBD0FE573A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260227025950.174755-1-srutherford@google.com>
 <20260227025950.174755-2-srutherford@google.com>
In-Reply-To: <20260227025950.174755-2-srutherford@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPFEDAA4523C:EE_
x-ms-office365-filtering-correlation-id: 63ed2c1b-7601-4651-1d8b-08de7622aff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: PJkN8Zn2ZNx8zMr0QR+IskD0SKLNIf294GTbkHMcmHXC+r0tBdgROLjaIDccE2C8siQ+NhcUnXXl+qgaP6SDPUh+KX9ima32GudWoAxhLf4f7YwhlC2cnXWTyiyW4KL9uma/x71vOkSMk2/oldVynULjPLvTTMgXfXkDAZ9s5JQw8NxrhNZ4Mxq8PH4Akq01Ezg2IEvxghnA7u3Tvhf+ESDC/5hYuFJBaCkP+H8fqPF+yjkGhVyiVLeipc/x+jYJqT/kbQNXhuK4XmF65mM3gF95tGsnGzdx9e4nGWr5PbvDHMTUKrgOWvNIaZShZbFvots7ScW5zzLtpM8k/fIIM8RQur3HbNJ6WVfSD31jw+TeFJrOzEq/Ewgz1NR6KduKBOc+7pC7xvTsw9n+4hIEFGp/5AWm0dzKUnvDHfG3bMVyPiJv01Az6x3ebVPkBbg9Y/hPW1Wz7E0er9TmRrP0HF+IAOhv8xZCsQ3gRDlREJkVtXdfzy0R4hbImYLTnNaghNrgqrM5NwHU39L9XcX6aG6Fmw/azJDE6/Ydfymw1P9eqvOL6sdnh7U3T6byjv4wen3+Xik4hYIOXexEmYMBuwpSdNrEWAiqvFwInTIBSrIZeZFEUP00UMSDHGSTVFdsJ9dmGE9/VIxwUeCPKZe8+KPtJdgeaV68AYzTQOB0EuHEqlEDXMNYMat1DtUYgHTArjtCZCGtLmjU6VFsN1EHL6bFi58K+d1ct0GLnXLkqb3QswkmbeKoVxxBfN3i+d53gNk+Vim7Bkk4c3vSX+LkuDQgLlS9hG9u2S7YFY03O5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am1XSWVhem1mazltOE42TW5KNGJnelV3QnhyN3JWa1l5d1hFUHhvTkJtVStr?=
 =?utf-8?B?Tk9IOTExUXJacnZSZkhwNUdKNW56UUpHVW1mWEVDLzFSc1VKeWh3VTJkN3Bn?=
 =?utf-8?B?YTBMZ2RhYjJINGNOQWgvdFcwVWw3V2l1RHkra2RDbDgvbVpXL0QwZmVyVmM1?=
 =?utf-8?B?eFIwVUd1TFRGUVZZOXdma0tNcVhGM2dvT0Y0dERkYUdQZUhITFRrZkxqZlRB?=
 =?utf-8?B?R1pzbnZlWTRxbmVMYTVPUTFMUk5Dd1hFZ2UxVHZ6Y21vYWFPR3pvUGFRRDAv?=
 =?utf-8?B?VVZrYlZvcWZWZjIvdGpqUUt1NVI2KytWZ3N1WGUxTVpHalVabC9PWlpjcVJk?=
 =?utf-8?B?NlFWTkFnSVl2QVV3UUYzMklZTXhRdUNJMTM5SDNldFJQT3Q0WkxNbHZWN1dV?=
 =?utf-8?B?NUM4SStjajdnYXVDalUzNzcrV1MrckszN2cvWlFmelBwODFXdGRlZ2Y1TnpJ?=
 =?utf-8?B?Qy9HbnY1TktsczdiMzFncGVWekp0RVkwT1ZlU1JMNnNPK1dtYlNlOGRrQ0JY?=
 =?utf-8?B?YUNQQkpJaFVjdHFyaVlNcWJYWW5CbTNkM3N0U04xUmRsWU5nMUpzREVGN0U1?=
 =?utf-8?B?V2VtdWI1K1VWU3pFa1ozbk5UU0ZNNnZLQ2FhT1NMcW5mUkp0bDlNOU9lVFo0?=
 =?utf-8?B?L1ZIYVhBY2dvUmFoQWZ2T3VuMmt5V0R2YUQyc0lqb213WVlJZzJ5WWtkVmxM?=
 =?utf-8?B?clJUVnZvejVEdS80TW5iSU15dklIMGZaMVJ3QUdQSkdRUXBaVGdBT0Mra2h2?=
 =?utf-8?B?aVpiTWlaQ2dBcGo0VmFOUkQ2bjJVNzNQOHg1VFdvdHVnbW44TXN6NUNveUd1?=
 =?utf-8?B?MmRPSXFFbkd6MUU0bWRtYlppWWFHRitEZ3FYdC80amUreUFQMUJtSytocXZi?=
 =?utf-8?B?bHZKYjEzQmI4RXZLNU1uaWlldjB0eWNXekpqcnprWStZNjN4UllRMm9Sc29q?=
 =?utf-8?B?My9EVnZYMTJZMktmOUNOREYvazVrMlZlM3hDRUp5bS93SjN1UmhWTFQvaGt2?=
 =?utf-8?B?aGZicjV0N0IzOG1zNjFkb25xR3ZhRGNWNUlMWFR1V0lqeTVQVzlpbzJrbFJK?=
 =?utf-8?B?cC8vZVk1aXhJWjlBak9QSUdsWEdycEtKNlVsb1dSWjNveExVTk5UeGxWdC90?=
 =?utf-8?B?bHlSVHVuSW03QkVkdHhYOFdYdCtZekJ1anZjUzhCbDRLa1lvUzdGVWhHaTNa?=
 =?utf-8?B?ZmRlc3Zsd0xwQkhCRXBPWGJUeklqUHRqbENwTXlTelBVRUZNUVBwVUF4Mmtk?=
 =?utf-8?B?WG1wcytzYXNyaVRYbXRkU1dDTCsvOHlmUXZBMlhPemM0OEhrV0ZjY29lUFRu?=
 =?utf-8?B?a29vR3VzNWV5Y1g5S3hwWEZ4cmhCWngyNm5WUVNBbVFaMFNvdkRlL0NmVXJq?=
 =?utf-8?B?OGdqekNsRTVhci83OVhQVzQ0cXRsekRiSGJEbHpoV1U0bTFCelZyS2hzMito?=
 =?utf-8?B?bi9pcXdMK0RQNVQwL2lXZ2hHTTVXcTNOaTFKVktmQVE0Z1JRWGVrUE1Sb2dE?=
 =?utf-8?B?Tit5QVVHSUNYV2l3cS9vWGcxeDVUcmM1bTJxUTJwQjNHMDdxc3lWdTZFNTdE?=
 =?utf-8?B?TlBMRVJZemRrVHl1M3FmN051OU00MmNRK3VqMkxLbFVBZHZqb1hORytTTmg3?=
 =?utf-8?B?U0FFRS85OG02Q3JqV3UyZSt2dnJjczQrZnVWSmFoeFg4R3htanZvR3o4WXZM?=
 =?utf-8?B?cDI1MzdXQmlJZTZzZWZCamlpQTZOU0dvaElXa204bEhkV1RsaSthOEFwdkxF?=
 =?utf-8?B?MDNTZjBabS9qNHl5WGwvb3JmdS9nejBHNUk4MHhUZ1ZiVWxjRk1uckFRWTlq?=
 =?utf-8?B?b3VESWdpUk1QVGViSTh2MkhYdWp1YUYvZDVzUU1aVHZjdkFya0FaMStRdWFN?=
 =?utf-8?B?a3ovS3RlOUF5eUFCOTBpbmpUSi9HSG1YZmg1VUM5TERhSkt4UHFGend3VWtr?=
 =?utf-8?B?RXZNZ3ViRll2aVJRZW1zS3pLZmREY20rdTU5Nnd6TmhIbEZ5cHZrZGN3Zkxj?=
 =?utf-8?B?aDFvdXlSSHFmUUNKYWR1YUNSTXhOb0pWUXBpaG1ERm1oQ2JORGpocEpYdHV6?=
 =?utf-8?B?d05TVFQzM0FURkFiZVB3aFlnSkY0QUtQcGpucDRTbUJQNUpZajhPVzk2VUlC?=
 =?utf-8?B?TkQ4dFRNOVVDYmlRL1g0eDgyTU9yRC9nSGRqV08wMEluM1VlSTg4eVY4T2Nn?=
 =?utf-8?B?UzBMSjd6emZwSC9yVkNyUDBqYUtEY2VoalJvaUdnaDRYQkRMZ1M0WG1VZXd0?=
 =?utf-8?B?am01VWU3emFUTTNLR2FiUzlPSjhLbWhUK29ISUQ0Z0NyRjR6UVBJUHlMUWx3?=
 =?utf-8?B?amczcCtkOEdqV2NQT1QyMm9qZGVXdXpzM0x1ZHRFcEdSUUduVnV4M1NJYXZJ?=
 =?utf-8?Q?vtunSaCzGtrQle74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ed2c1b-7601-4651-1d8b-08de7622aff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 17:07:28.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUUFKMa+gRIPz57AM67JJnDIg9wGtHIrXI9oD+X6JT4g+03PR4zBiAM6O5MunOSNg8CoA9KGNhCQP08zCMQUQoKDNyqGow+tjb+gpCFo63Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEDAA4523C
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261920-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,IA3PR11MB8986.namprd11.prod.outlook.com:mid,lunn.ch:email,davemloft.net:email];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 395B11BB360
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgU3Rl
dmUgUnV0aGVyZm9yZCB2aWEgSW50ZWwtd2lyZWQtbGFuDQo+IFNlbnQ6IEZyaWRheSwgRmVicnVh
cnkgMjcsIDIwMjYgNDowMCBBTQ0KPiBUbzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5u
Z3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwNCj4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRz
emVsQGludGVsLmNvbT47IExvYmFraW4sIEFsZWtzYW5kZXINCj4gPGFsZWtzYW5kZXIubG9iYWtp
bkBpbnRlbC5jb20+DQo+IENjOiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJl
ZGhhdC5jb207IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0KPiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTdGV2ZSBSdXRoZXJm
b3JkDQo+IDxzcnV0aGVyZm9yZEBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQt
bGFuXSBbUkZDIFBBVENIIDEvMV0gRml4IGhlYWRlciBjbG9iYmVyIGluIElEUEYNCj4gd2l0aCBT
V0lPVExCIGVuYWJsZWQNCj4gDQo+IFdoZW4gU1dJT1RMQiBhbmQgaGVhZGVyIHNwbGl0IGFyZSBl
bmFibGVkLCBJRFBGIHNlZXMgZW1wdHkgcGFja2V0cyBpbg0KPiB0aGUgcnggcXVldWUuDQo+IA0K
PiBUaGlzIGlzIGNhdXNlZCBieSBsaWJldGhfcnhfc3luY19mb3JfY3B1IGNsb2JiZXJpbmcgdGhl
IHN5bnRoZXNpemVkDQo+IGhlYWRlciBpbiB0aGUgd29ya2Fyb3VuZCAoaS5lLiBvdmVyZmxvdykg
cGF0aC4gQWZ0ZXIgdGhlIGhlYWRlciBpcw0KPiBzeW50aGVzaXplZCBieSBpZHBmX3J4X2hzcGxp
dF93YSwgdGhlIHN5bmMgY2FsbCBwdWxscyBmcm9tIHRoZSBlbXB0eQ0KPiBTV0lPVExCIGJ1ZmZl
ciwgZWZmZWN0aXZlbHkgemVyb2luZyBvdXQgdGhlIGJ1ZmZlci4NCj4gDQo+IFRoaXMgc2tpcHMg
dGhlIGV4dHJhIHN5bmMgaW4gdGhlIHdvcmthcm91bmQgcGF0aCBpbiBtb3N0IGNhc2VzLiBUaGUN
Cj4gb25lIGV4Y2VwdGlvbiBpcyB0aGF0IGl0IGNhbGxzIHN5bmMgdG8gdHJpZ2dlciBhIHJlY3lj
bGUgZm9yIHRoZQ0KPiBoZWFkZXIgYnVmZmVyIHdoZW4gaXQgZmFpbHMgdG8gZmluZCBhIGhlYWRl
ciBpbiB0aGUgcGF5bG9hZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFJ1dGhlcmZvcmQg
PHNydXRoZXJmb3JkQGdvb2dsZS5jb20+DQoNCg0KSXQgbG9va3MgbGlrZSBzdWJzeXN0ZW0gcHJl
Zml4IGlkcGY6IGlzIG1pc3NlZCBpbiBzdWJqLCBhbmQgRml4ZXMgdGFnIGluIGNvbW1pdCBtZXNz
YWdlLg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZf
dHhyeC5jIHwgOSArKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYvaWRwZl90eHJ4LmMNCj4gaW5kZXggM2RkZjdiMWU4NWVmLi5iMDIxOTVmYTI4MTMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3R4cnguYw0KPiBAQCAt
MzAwNyw5ICszMDA3LDE0IEBAIHN0YXRpYyBpbnQgaWRwZl9yeF9zcGxpdHFfY2xlYW4oc3RydWN0
DQo+IGlkcGZfcnhfcXVldWUgKnJ4cSwgaW50IGJ1ZGdldCkNCj4gIAkJCXU2NF9zdGF0c191cGRh
dGVfYmVnaW4oJnJ4cS0+c3RhdHNfc3luYyk7DQo+ICAJCQl1NjRfc3RhdHNfaW5jKCZyeHEtPnFf
c3RhdHMuaHNwbGl0X2J1Zl9vdmYpOw0KPiAgCQkJdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnJ4cS0+
c3RhdHNfc3luYyk7DQo+IC0JCX0NCj4gDQo+IC0JCWlmIChsaWJldGhfcnhfc3luY19mb3JfY3B1
KGhkciwgaGRyX2xlbikpIHsNCj4gKwkJCS8qIFJlY3ljbGUgdGhlIGhkciBidWZmZXIgaWYgdW51
c2VkICovDQo+ICsJCQlpZiAoIWhkcl9sZW4pDQo+ICsJCQkJbGliZXRoX3J4X3N5bmNfZm9yX2Nw
dShoZHIsIDApOw0KPiArCQl9IGVsc2UgaWYgKCFsaWJldGhfcnhfc3luY19mb3JfY3B1KGhkciwg
aGRyX2xlbikpDQo+ICsJCQloZHJfbGVuID0gMDsNCj4gKw0KPiArCQlpZiAoaGRyX2xlbikgew0K
PiAgCQkJc2tiID0gaWRwZl9yeF9idWlsZF9za2IoaGRyLCBoZHJfbGVuKTsNCj4gIAkJCWlmICgh
c2tiKQ0KPiAgCQkJCWJyZWFrOw0KPiAtLQ0KPiAyLjUzLjAuNDczLmc0YTc5NThjYTE0LWdvb2cN
Cg0K

