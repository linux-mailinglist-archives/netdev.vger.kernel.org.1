Return-Path: <netdev+bounces-254380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOccJCJJemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:36:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FFA6FFD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B22F0302D956
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548DF313527;
	Wed, 28 Jan 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3ggRSLT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808034C83C;
	Wed, 28 Jan 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621580; cv=fail; b=H9lLD9r3Os5NEJm7TOaJw47ccSAcfntFC8Lh948SwP1qH96TLO2xNw+Gt+kOwyVu3QABOI8ZmvnfYYid1Ykw1k0zewsb715TtZAzzyHC+ve5dTPJhG4IP6kam0GEuRrsQfXS58SlD4hLUS7zjEjKbA7+2NebCL7n78XGi7SdQIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621580; c=relaxed/simple;
	bh=zjwfmVn49V22XUK82ZOC6w9HJzCnpeCUg5PzEsi1Gqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDbdP+TPb120LSYrS+56VqmoxyTh2+KgU1ol7DbRLjPhEwhg0w9BdAKPUdXPuSXMKOhTqnSyju21JM9X/tlOs0E46eCxtP8gpavCkLtitADTRugbeg1aD9JOiGJW7ovXkbYxH+iSL4MOQ9W77OquEVmXf2fPkMyQR1S/Z+/ck/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3ggRSLT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769621578; x=1801157578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zjwfmVn49V22XUK82ZOC6w9HJzCnpeCUg5PzEsi1Gqw=;
  b=L3ggRSLTn6srvh7VCifm4FuAIAUuu43N/Tx7n3LRUiN9oduzA9jb3Pe9
   4SD9KzT9ZdTSRZL+hqLwkLSPq9McabGK1tHsTe13r5iIBoeg45rMJZ/IO
   JcJ69UQzG+Ki1Nc/X3XLjl6lcLRoilTYaEnO2/mRWBmeNU3hon8B4ppNS
   XWx4gOGoitLtTrDC+0TyQE1+Lh6ksBEL9c6jsDP3zIVLyplA4vu0+cxYQ
   QL7z0fmfhrwxNrcTHPW+M4mabPWfIjXpHo1aSiIcyVKVkuidQmk3+fVcQ
   CwuC7be2cWwaNsQSOnbox1d3e61Hya7qsHhBuHmTfX7He4Vq/4dj/3xRK
   g==;
X-CSE-ConnectionGUID: 8DaNoCJfTTCdpUVz7ID3kA==
X-CSE-MsgGUID: OqI+tI+KTYKL/GXw7ROgCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82269892"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82269892"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:32:57 -0800
X-CSE-ConnectionGUID: MLNkqMGOQVWuLZe4XiTrfA==
X-CSE-MsgGUID: 6Cj5+vbiQ0Gplgcrl81iFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207459190"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:32:57 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:32:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:32:56 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:32:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbHOkdyv143JenVQtjRjwQj3oZh2OapMNSyNqYzG4FUjqjTDWzC3uc22Y8xk1HlZxufiVlchwBz/IMjboPl/9SK13Kuak8Jpp8LhgB23N6AaWvci/XKSJ3rsqIBUGEtn6uea1C022A9e/fAdHCcsOYd8hGACJ8f6Qx+b+Ycig1RPA/3ti5S4KCsLAm/IlrPLUtQtRgO30aMfIZWXLQxBieRKaKjJf7KNbVjdCfugNOWLQCM6M8rWFw3HeHsYoWLAo5nFgBEAG2B2aNeOetuHP4w/bGYlOUV/nd02p/B0+3ecz1xFotkP55Bt2ddc8PG7hgfXbSD/UVCj6LSg6dmCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjwfmVn49V22XUK82ZOC6w9HJzCnpeCUg5PzEsi1Gqw=;
 b=HdfVLgwOB5ec5Rgcz1gKbftiuqxIy4nl3wcvX/9n0TH193bANBxU9CEd/f/IGvv9OTjXUKeVuiicGow8Z5+m1DtIKC1+i8qAvqPncMgmivORf3AwuhFNzqiytgBT0I7Rbgi/pOBesxUyfYdrl1A/877/usnOxhwv1Rfbje8hnLjkHjkhuB8ygzig5O65Okz6QBWF7vSUq+bezf64jYigVfpLB8Ve2mTpSaPpL0ed0GwBcQ7T8GkAHQNgUSJJdUWF1b1NtcxjzdHK8Yvcj17ttsuxm76fb2D66eS2XbD1iBPgpNmAmlH2Y/0ZY39CbzrH48efwLvLMHIWcZphSyTL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 17:32:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:32:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [Intel-wired-lan] [PATCH v2 23/25]
 tools/lib/python/unittest_helper.py
Thread-Topic: [Intel-wired-lan] [PATCH v2 23/25]
 tools/lib/python/unittest_helper.py
Thread-Index: AQHckHZoFPMnL97tvk2Qhr2aOauK37Vn1y0w
Date: Wed, 28 Jan 2026 17:32:53 +0000
Message-ID: <IA3PR11MB8986E4CC5927FAFF114E3A9AE591A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
In-Reply-To: <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW5PR11MB5809:EE_
x-ms-office365-filtering-correlation-id: bd877235-fe84-4cda-57f6-08de5e934499
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eWM4cU0zZ1dCaTFSa1lqdEZVeTUrWGxtS0p3L3ROaTFvRHZkMkFLZnB3Rk1K?=
 =?utf-8?B?UHVDMVR5cHNydCtaemNybmNCSDNHUTAydHJrMU00ZUlEMks5Z012UEJlczRt?=
 =?utf-8?B?NVh0Y3ZWNnljcWJ3RGpXSjgzVG9kb2pOc21YNTV2Q2NIRjI3OUVsc1FEcnh2?=
 =?utf-8?B?MlAyYVJ6N2NIbTlXZ1FSUkJyb20zRU4zT3FXRm4zdGNudStRb0hUSnl1TjY2?=
 =?utf-8?B?TUxkSnFtTGZlWlpTUTFzMGxEdFBVM1pzRGhxcHhmdWl1UU5MZkkvN2dnbUZ6?=
 =?utf-8?B?NXlVQVlCdHI5Znd2WHF5V3FVbVpSNU5oOStNZHoxeW9ESWw2ZUhNY0RIckZj?=
 =?utf-8?B?cXpkZkZSMU0zZllETDNUd2hXLzIwUmFIeUdPU1l4Q2tEOHdvZHZ0SHBtYUNt?=
 =?utf-8?B?THBxek4rSTV3bDJxaUg5U2MrbWRZbmdRUEFrMEVMWlJ0clZna1A4eTBvZ2lt?=
 =?utf-8?B?aG5iK3VjSTlmQVluakxQS1R0NG1Cd1ZtYXdEeTVmNzI1cHVmWFNHODR2U3pw?=
 =?utf-8?B?UkdQQnNTVWEySEJUWHZhZE9PcmdBTzhubTFRcEVyY0YrcS9YaHl6bExkdHNz?=
 =?utf-8?B?WUFwUXd0Vk9kR0wzLzVmT0hXMHFtT0hKZnNrMFdPQjVQUHlPbkRnd2x3bDh4?=
 =?utf-8?B?aTM5dGR5ZVJOS2FEVTRsbWNDK1FhU2pDMWlMRGFBN041WmdBelF1MWFUMnJE?=
 =?utf-8?B?VW5zdUxKUEtGVmhkUE1UZEpnWHUvTFA0R0J1SjA4VFZwQ0ZUK3dlWG9JaG5Z?=
 =?utf-8?B?ZEdoamhTYTJ3Y2hYNkt1S3V1ZkM3MWdBVTdEN2h0bjErY1hxNXo0bG5iTWk3?=
 =?utf-8?B?bXdFU2FCbG5mK0FROUhZRXMvcVh0ajRsUFhTVGpYS3NCcGptU1lsUGtacTZG?=
 =?utf-8?B?UFdBR2h3Z2M1U29SamZaTHh6M2o2QU5yYlFiNjVHczdRbE5IMWZtazhUSC9u?=
 =?utf-8?B?YmVTNmxxTWljNmVEWEFUMWJrWE04VldHa1V4WnFROGdSeVhrQlJwSU1UMVlG?=
 =?utf-8?B?aGx4Rmh1c0FsUjRlUWNLTnM0OTd5MDJlQVRjNU5mTXByaWlzTFEvbHJYc0kv?=
 =?utf-8?B?c1BlWFdGaldJQ0VwU0lCNVZuYXpjZ2Y0azZqYWZjempRKzdMRG9ORTFYc2Uy?=
 =?utf-8?B?VU1lanhXSVdpK0FLOVRydXoxa3o5eE9aMzIyanRmNjVHQ1RESE5aajVYdWN1?=
 =?utf-8?B?TmhjcUFwbytqL3ptSTFYZWYxTEphbDVmN251aDlyQm5XVWI5T0FLODlLcTZq?=
 =?utf-8?B?dG1DUzR4ZUNRMWl6aFhPWmlTaFpsTHNTTk5rc0hEaThqdTg3QVZ5bzZOalhH?=
 =?utf-8?B?K3RmUXFjd2VEaUQ1aGMxQlhXOFFVazBHUk9BSUYrQzBGaWhhNlJDSnRHWm80?=
 =?utf-8?B?bVhUUTRLdUNOUStsWmEyTnE3bUdaaUZWdXhvWmNJbC9DZzE1dWxkZTF4Nmh3?=
 =?utf-8?B?WVRjOThUQmwvdWVGdlhjRUhzQWoyTUdvS01ldmczY1E0c05leWJObENWV0VS?=
 =?utf-8?B?U1NiTjVBNS9oY2djMXdJekRMNi9JNXFjMlhzYkNtL2QrSmVFYUFWTTVsRTVS?=
 =?utf-8?B?Rlc2cmViZkZCdEw5Q2tWSjVxaVJCU29yZ3RJOTh0MmFUWFVHdzJISlRnZHhk?=
 =?utf-8?B?UFB2anFLRzRmMFJhTjVuSG4wMCtDM29tcHViZm9jQVlsaEtISDBpMXZLM0tJ?=
 =?utf-8?B?MHlUMWFML2RlK3ZHKzh1UzJmSGV5OU56djJSS29jYnBKVnBub2wvaEMrdysx?=
 =?utf-8?B?VDlQa1drbzZUSlp1dzY2SnY5UWo2V1JDbFFIU0NZdEZma2VBeThKb3lSL2FZ?=
 =?utf-8?B?dG96eDZwWUVoZklSYmdqcE9oWHBtNDdzc1NHSi9PU0tjU0xLOWJ5VzlQWmZ4?=
 =?utf-8?B?OFh6SXF6Q09KeXNKd2Nxa2hjakhiUUVrejRjRTVSWlc5Zno2YVZoSnpQUklK?=
 =?utf-8?B?dmRmRXVaS2pzK1c5NG1sSG9rSEN6Mzk4ZUNoOC9GS0xXNDJYYkk3c1NvYzBy?=
 =?utf-8?B?UmlRamxBaEVRSzRlY21zcUEzTXZxUmNQeE1lelVvaG1scjQraUQ2cmd1Z1RI?=
 =?utf-8?B?QkFoYTVKQ2dkbG9OVG53c1hLay9PbU43S3JRa2t5YkNDNVdYbndkcUh3R2s0?=
 =?utf-8?B?dzI5QitNU3RONFFLLzZBREpvOThBcjVFZVg3K0VnSGVtQ2ZrMHB6Yk9CLzVm?=
 =?utf-8?Q?9Sj9X0BwabtpPFwVzEFjo7k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJJK0c1dGxpZzRIQ0NER2F1U2RXTCthREV0MDdQUGIwYTEvYTZ1K0RPK3lr?=
 =?utf-8?B?aWpha2o1NU9kSkxXS2MrbFZ0U01tQU01VFdxeXRGYUIycTFueVhTK0R0YjNn?=
 =?utf-8?B?bjRYblI1ZEZUWHFCZDNOajI1YnJJWmplcHZHTlp3ZjFicFlBaGswQVNEcDR6?=
 =?utf-8?B?enVLT2liRnZuR2cvMi9iUnE1SUlPQS9YeGpUbmNvMTQ1V2NNT0dmcnJOUk43?=
 =?utf-8?B?dFZIcDhzdVkxTG9zRzE4YTFicWFkM3pvQ3NjY3NNYlNUSHNaVzFaNTNmMFd0?=
 =?utf-8?B?MGVGUG03d1FwbGtNRTBlcW80Qk1BYVZNWjNvYUdVTk5mZDltVUpLWmI0dHN6?=
 =?utf-8?B?VGloQ0NBSEZhSUlzL3RORWYvNGdYMzgzTjBIamcrbTgvdVJlOGdCL0ZiMGhr?=
 =?utf-8?B?a0RKOThYWlIwSzVoS01GUC9wOFdTTkI1bkZJK0lrdnRneXE0N0dzY1NMaDVP?=
 =?utf-8?B?THZ1YytkMVBWdTIxeXluakJ1UUlrNHViZ1krYXZUK2IrQks5QVZHZG1nMXQv?=
 =?utf-8?B?RTlWb2FTM0FSWVM5ZWFHYkJlYVNJZGNDZ0hoNHpoMTBxbVlGK2oyU1ZzWGxB?=
 =?utf-8?B?SkYyUStjc2hWVGREaCtHUXJCN05GRERLUWhTVzFLODY1T25MSmp4Sk00YkRO?=
 =?utf-8?B?L01hWkJQV0hzSGg1WnlIMjZHVVN4VmpuV0VYTnlhOGZOcVl0OXRaZ0F5WEIz?=
 =?utf-8?B?S3VndWtqMmQ1VmVFL2p1d09XNnNNS2ZHL3YwVWdrbUFUTlRQYjhheHpJM3Jo?=
 =?utf-8?B?Qm81Ym5TU2w3Z21EZXF6dDJoaWlmODB1R1QzUFVwY2E0L2RBYXVGT05NWXFj?=
 =?utf-8?B?TE1NZGdEMFFWYjIrd2RjQUFwVW1JWW55QmNzV0E5Z00yOEFSbXhiT2EySTh6?=
 =?utf-8?B?Q2l6U0NxUEpKMDd3TUphdkc3N1NxSzVmOHJFd052L0M0cTkvMFVaSDNXaERq?=
 =?utf-8?B?ZEM1WkxGN2JPNkQwczZiMFJkV1lJMUpOMWVMQUNxbkIwRThZVG9UbWxEckp3?=
 =?utf-8?B?d2d2bC9zTm9DMUY4MXpBWjVaNldBcFlTT1pDWnk5Q2NQVkpsUGJYUUh1U0xT?=
 =?utf-8?B?Z0NUaTBENFJFQURRL0F5aEZXM1hORzh4S3l5SGZsZ0NSbmNnNVlXdGxsVmZT?=
 =?utf-8?B?bmZCTFVoUW56WGk5RDM5cDkyTEY0YWlCMVM4NFhFNFNNS0JYaU9ra0MveDhy?=
 =?utf-8?B?UkVmS1FSMFNCeTh2aFdhYmRMUnZyZi9xWE42bmZteGlmRTlzSklGQ3JIZk5I?=
 =?utf-8?B?eEhhQWpTbHFlNlk5RVBYTDAxaW5qSDlNQlYxTjZ4WlpiZWczRGcxalBQZGRZ?=
 =?utf-8?B?Tk9XaXlUUXZ3Rm50TjhGazR0TldObEFCUysrMm1TWVM5MHBNZURsWDg3U25h?=
 =?utf-8?B?ZlhtN2xaNEJRVjkxU3FQcVhhdEsvZkZYMmROSGhvUXI1RUU4MTdRN20zdHln?=
 =?utf-8?B?b3paY25DWmpnMnhFRWl3K3RidEVvcmsvdkNtWGxCUklubzVkTVYwMFNFc0E0?=
 =?utf-8?B?cVpZSDF2QlExOVVITjEwTE84WUhoKzI2UVFacE1xQ09hZTYranZCUDQxTUJE?=
 =?utf-8?B?SlBXVFB1SVhSbEJWM2d0QkRDNFlxbklVSEo2b0tqeHZrWXUyTTNzTEpINHdz?=
 =?utf-8?B?SzVSZkhLYlhiZ0NIQ3dNeGg3TFhFbXdEczN0TnNKc2dWZGswbFc5RzZiVng5?=
 =?utf-8?B?VFY1WFFtUHFwZUQvRkMrODBsbVVFMjI3U0xyd1NDZjM3SXBOcyt1RFd6NXZi?=
 =?utf-8?B?K1cwYWg1TFlBSzV1R3cwcUhhMHR2eml3U0NTZ3d1MDRpSmlnVTUvdjNIWXNj?=
 =?utf-8?B?KzFFUWNLL2lvaGZVY1p6eGJCenNLRUFKVFZKOGZZeXVtSVpyMnVkMVZYeFdJ?=
 =?utf-8?B?R2FTeFZBZU00UCtTeUZkUkxyZVdqampaWGRnMlpRN3IvUi8xQTFrU0htUWZG?=
 =?utf-8?B?UXBFL2VMcndhUXVZc2VWTUcxVGx0Q2d3U3ZvOWVpekVhQ3ZRSm5QZll5MWV6?=
 =?utf-8?B?NzVGcUJCWEt6dkwrcjMrUnQrVXBYVGR1dERVdXlHRTZScjBhejRrMXU0SlU2?=
 =?utf-8?B?QjdueDBHekRWaGJidjBsVDZVOFVkNUNpV3dTYkQya1laWDNhUnd2QVFtSFEz?=
 =?utf-8?B?QlNTSVp0RHgxdWprSGZudFNmbUUvU3N4RFFPeWpGUXJGNUpXNjlpRlR3Vk43?=
 =?utf-8?B?Q1p3ck41QTNDYWRKSkFBVkp0SEp1blZzVzQrUE9adG9aL1pXOE9Pazd5QlJt?=
 =?utf-8?B?YTc1ZS94emdpT0Y1NDg0MVU2U3IrejlWbm9MendHR1ppN3ZxYTExMkZCUS9U?=
 =?utf-8?B?cFJlMmxRUlNOQ3pmMUYyYWFwUlAzdkRFazRhQ2xCMisxVCtpcEM3UT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd877235-fe84-4cda-57f6-08de5e934499
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:32:53.7203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvO8iN9fgEqRPU4yzg1fAzQ2cwZO+HNU4tkpbtZOg5efWqENoNMef6S+hneOSW+UiiAD2p2eXrdLRntE8O208+QcvlkdpALaPNT7TY3sD0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254380-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,infradead.org:email,lwn.net:email,auug.org.au:email,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 056FFA6FFD
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA1
OjUwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTGludXggRG9j
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+OyBNYXVybyBDYXJ2
YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz4NCj4gQ2M6IE1hdXJvIENhcnZhbGhvIENo
ZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz47DQo+IGJwZkB2Z2VyLmtlcm5lbC5vcmc7
IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgUGV0ZXIgWmlqbHN0cmENCj4gPHBl
dGVyekBpbmZyYWRlYWQub3JnPjsgUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+
OyBTaHVhaA0KPiBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPjsgU3RlcGhlbiBSb3Ro
d2VsbA0KPiA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1s
YW5dIFtQQVRDSCB2MiAyMy8yNV0NCj4gdG9vbHMvbGliL3B5dGhvbi91bml0dGVzdF9oZWxwZXIu
cHkNCj4gDQpDb3VsZCBiZSBuaWNlIGlmIHlvdSBhZGQgcHJvcGVyIGNvbW1pdCB0aXRsZSBmb2xs
b3dpbmcgc3Vic3lzdGVtOiBicmllZiBkZXNjcmlwdGlvbiBmb3JtYXQNCg0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgdG9vbHMvbGliL3B5dGhvbi91bml0dGVzdF9oZWxwZXIucHkgfCAxNiArLS0tLS0t
LS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9weXRob24vdW5pdHRlc3RfaGVscGVy
LnB5DQo+IGIvdG9vbHMvbGliL3B5dGhvbi91bml0dGVzdF9oZWxwZXIucHkNCj4gaW5kZXggZTQz
ODQ3MmZhNzA0Li4zY2YxMDc1YjFkZTQgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL2xpYi9weXRob24v
dW5pdHRlc3RfaGVscGVyLnB5DQo+ICsrKyBiL3Rvb2xzL2xpYi9weXRob24vdW5pdHRlc3RfaGVs
cGVyLnB5DQo+IEBAIC04LDIxICs4LDcgQEANCj4gIEhlbHBlciBjbGFzcyB0byBiZXR0ZXIgZGlz
cGxheSB1bml0dGVzdCByZXN1bHRzLg0KPiANCj4gIFRob3NlIGhlbHAgZnVuY3Rpb25zIHByb3Zp
ZGUgYSBuaWNlIGNvbG9yZWQgb3V0cHV0IHN1bW1hcnkgb2YgZWFjaCAtDQo+IGV4ZWN1dGVkIHRl
c3QgYW5kLCB3aGVuIGEgdGVzdCBmYWlscywgaXQgc2hvd3MgdGhlIGRpZmZlcmVudCBpbiBkaWZm
IC0NCj4gZm9ybWF0IHdoZW4gcnVubmluZyBpbiB2ZXJib3NlIG1vZGUsIGxpa2U6Og0KPiAtDQo+
IC0gICAgJCB0b29scy91bml0dGVzdHMvbmVzdGVkX21hdGNoLnB5IC12DQo+IC0gICAgLi4uDQo+
IC0gICAgVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPiAtICAgIEZpbGUgIi9u
ZXdfZGV2ZWwvZG9jcy90b29scy91bml0dGVzdHMvbmVzdGVkX21hdGNoLnB5IiwgbGluZSA2OSwN
Cj4gaW4gdGVzdF9jb3VudF9saW1pdA0KPiAtICAgICAgICBzZWxmLmFzc2VydEVxdWFsKHJlcGxh
Y2VkLCAiYmFyKGEpOyBiYXIoYik7IGZvbyhjKSIpDQo+IC0gICAgICAgIH5+fn5+fn5+fn5+fn5+
fn5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gLSAgICBBc3NlcnRpb25F
cnJvcjogJ2JhcihhKSBmb28oYik7IGZvbyhjKScgIT0gJ2JhcihhKTsgYmFyKGIpOw0KPiBmb28o
YyknDQo+IC0gICAgLSBiYXIoYSkgZm9vKGIpOyBmb28oYykNCj4gLSAgICA/ICAgICAgIF5eXl4N
Cj4gLSAgICArIGJhcihhKTsgYmFyKGIpOyBmb28oYykNCj4gLSAgICA/ICAgICAgIF5eXl5eDQo+
IC0gICAgLi4uDQo+ICtleGVjdXRlZCB0ZXN0Lg0KPiANCj4gIEl0IGFsc28gYWxsb3dzIGZpbHRl
cmluZyB3aGF0IHRlc3RzIHdpbGwgYmUgZXhlY3V0ZWQgdmlhIGBgLWtgYA0KPiBwYXJhbWV0ZXIu
DQo+IA0KPiAtLQ0KPiAyLjUyLjANCg0K

