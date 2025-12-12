Return-Path: <netdev+bounces-244518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2801CB9540
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2663730B24D5
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE302D543E;
	Fri, 12 Dec 2025 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHB//hY9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4A2D593D
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557729; cv=fail; b=Dyxk9j2Lb+AnUpCq4TjaHfr8U5AWIhKzqJJlmDk5cfYf+88DggVoUv17/NUS//aNiS3Tgg+SuVBVg4Afu1WfJhWi8SohQQwKKIfZKYZBngiTBg+mr4usRROowB3clhHUUZXh5tD6Lkvg5TT97AeOogu5WJaPS65idnkHj1M3c8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557729; c=relaxed/simple;
	bh=00AhfjyMpclClJIbbInx78u81BzKvthlLTZFoJMt5XE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofIR4Mhd/oc16GQn/vt1eW0jhFV1W00Abz4x+l7fU1byH+Da1PLHZRMQ7rTl3rA03wBmjGfqCauQ08S7naCpN20IAR0QyO+1a5+Mz2JF3NRNBvpewtu3qWbXLi7gQUxx9TPUVeQUjhWA5dEgF837Z6tkFiu7BVpatnspZzCSanU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHB//hY9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765557728; x=1797093728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=00AhfjyMpclClJIbbInx78u81BzKvthlLTZFoJMt5XE=;
  b=CHB//hY93piBvwWYHywGSQDvkRX2UPTEOKYDht/+o7d8e5260zQBsoKA
   f90R+93pPSMYs3N0y8RtqmjU31A8FDluuQMtZLPZ/mSCESAnFdshW1vRo
   jtUk5p5E5syonaZ5X53nkpG+LqxtV+1Km+hrj8bHZKHAFPr/HqQDeoMb9
   8Bd/SicUkQnvV8ZQGFQWTO8lXnsQlPXAZp62jcaw86wT/BTOZxoXnBnDt
   6WSCI0a6MF+7OGOSjGBXgeeZ5dn2ip5+PRbigucN3Cn3WhGkYSVeNWo/t
   U2Yv7y8k9scY+iihzsEbYgg9mhoOkLJR0V8UP50DcjUqjIdQunpmHrOhp
   g==;
X-CSE-ConnectionGUID: CUJvWhXmQIqxWdMj19tefQ==
X-CSE-MsgGUID: Y/TEdIidSF+NhU5iKqDAoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71189975"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="71189975"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 08:42:07 -0800
X-CSE-ConnectionGUID: erfIqJjkSqq7X8rxa94LwQ==
X-CSE-MsgGUID: 7Kf9/XxBQpi0lZ0ED2QVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="197029478"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 08:42:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 08:42:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 08:42:06 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 08:42:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFWlv2P1vRqI5F0Ev9p07HnFD9/0bKNKjns/2BLYGcwSljkVDeQnc+RtM9qeE0fMVp4NJr4jE8tocQytX8itjCKnXBkz9QIl1gswFk0Qjjvm+xMNFHNlL8JFi+3U4uah/aMP9J4g70jpTeSAM6zVvdKpIVyIiHZKS00P2BJaROvYt25frKyC8B6MP7OhiThFrkEEEh5Z1sKyuO8DZI9QQ8NR0iFsDeA7Y67ei33hE5VOGUe8+Ap7g1+vkBEYDrno2w0eTS9pK5/CvDRAcbDhNQ+Gn4DJh50uvgpleKU9jbVLpVI9NYyk4KeL2oaJ9KCQdUD/VA4LvbCT7T2FQElyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+43tymVLSGdRAk/GngRrv0VJVKFYIv06wU4NKzD4/E=;
 b=V8jOetPGF79FambtN5t731OGo+QNAV3cK2afovyLdcao7qjXTjX7fbQNEVsKI4nMc6u36cT8oF6qjOssWYLqZ1tCmHk8iIsx+5SZhJdZLLvpgKwrIdKqpOZM5K0nxgq8PvgpV7TrGMcYOeI6SQE+b2hb/psHS4ZF7oAmrIZbtRdDeD/IR7FwcmL8qemQQ8gMa8gdHpQElr3T+NhbceqkpMhJc3x+0wmZgrLDXr0W3bValqd5QklzlGxIuM5OKJfZe5ShDwudfbyAyZpuEgqhb14+jNLlckAFxqUE+C7Y5J9xHkRhn5by7GmrfYmKnCavMY/WwYgut2PsJoXF2xql9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH7PR11MB8480.namprd11.prod.outlook.com (2603:10b6:510:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 16:42:02 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 16:42:02 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Simon Horman <horms@kernel.org>, "Joshi, Sreedevi"
	<sreedevi.joshi@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/3] idpf: Fix RSS LUT NULL
 pointer crash on early ethtool operations
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/3] idpf: Fix RSS LUT NULL
 pointer crash on early ethtool operations
Thread-Index: AQHcXXL4Fjopyy0XR0Cf9ymmpUxqg7UGa50AgBflgEA=
Date: Fri, 12 Dec 2025 16:42:01 +0000
Message-ID: <SJ1PR11MB6297A743B97D8E8C4B07B1899BAEA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
 <20251124184750.3625097-2-sreedevi.joshi@intel.com>
 <aSg5uiOiAyRds6gM@horms.kernel.org>
In-Reply-To: <aSg5uiOiAyRds6gM@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH7PR11MB8480:EE_
x-ms-office365-filtering-correlation-id: 29de5406-7326-4a97-9e45-08de399d6035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?nLgt8yMvivbftJprIuHmvhzjSjFreAXpf+x8MvEp/LNzAq2GlPXufVaJsDrA?=
 =?us-ascii?Q?o6880POSfG0mJaqo0MBnJIfM3IShxkYS+D1KZy7czw46wnZyFAJspG+EoFl/?=
 =?us-ascii?Q?+tDeIqPGVgbInU6g8HYXaefe6SEOZNBasWY6cC0dUzjLbtbkrs3yVPNW8F0D?=
 =?us-ascii?Q?haQzmWYnUXV8lNYiycY0Lgl9fx/kWbp/906Du7vlrre2QgB0+C70m6qxABsF?=
 =?us-ascii?Q?It3iJe7hC3Iy/uwyRxlys8mUEejYkk6wFN15yBvwDiVUdrdse0n0InAadqgc?=
 =?us-ascii?Q?NI6uoYKKmkUiXAxOzfYo8J9K2DSTg5WKeUhXdBvghe74+odzvTC9OXU/cili?=
 =?us-ascii?Q?ATQabRaf/Y6/5trZ4avcPY5kraTrSppvq+e+ktfWyQfGZhD13hUpfp/2y33a?=
 =?us-ascii?Q?6GZaPNFed/YxlIyYPilW4bM3NqCTB4wrFqJCitf1IC7cF6dK+cZyL92Sa6Gs?=
 =?us-ascii?Q?nnHaLBB6vZP0MG8ytYLbYSzyhVaGyWVAH1Q1b/n3hyskIy8cyIPE82PooxCY?=
 =?us-ascii?Q?reWNcG4z9BoJNfW+9uXOKw3nCPTlWCRdaPWHhUor7L9EDU+zI8CHge+RcGiD?=
 =?us-ascii?Q?jotkaTTi7hCpjl+H1SOBk5kCy+28rioNc62aFYHFI/1hUb50B9nkaLaoqsTA?=
 =?us-ascii?Q?UocTKnpMIzGA5m3xDD+20Q3G/4VlNNm3K+S49dueyX6LNcB3wuTGaDuyVSUd?=
 =?us-ascii?Q?mLw/082t9YHAuyOBcQH2/7+n43tsrm84OX9ho91MoczROH0mFtetzPjkEKdK?=
 =?us-ascii?Q?GJFWG3ZQGeBpr9fKMaTPIOC0S87ratt3iWOZKygZ8yHMKs+X/K+KjZbi9Vmc?=
 =?us-ascii?Q?B162afKPPInWWR/4ksgYLBgImWHLkFe6vspcFVjrrTDscPoMYA8JXkMyKsnK?=
 =?us-ascii?Q?WHxYYFYfz/qZhw2yyWj5r68STKU0Rj2tqcuIVFy1IdKcv3/DtDasdsWiEvqx?=
 =?us-ascii?Q?Fobf2Pe8di76gZL4Ao6rk6yyEXUVnn7O+Tz4uvFQpIhPm/wGy+II5IOmgc0l?=
 =?us-ascii?Q?7Ryfnkr+fXAn75imHCncj46uE0dA9vXb2NDEOtmU65KjatIwTN0XQm/29rXJ?=
 =?us-ascii?Q?Ko7wUr+HU7me8O37wiKbJJ/Lx7V0PQdn6AX25mgT6F3BctZyIqjSyCksLGK2?=
 =?us-ascii?Q?C6ubamu+gNk2xYGowUdD2JVJOCVPo5q1ioVI6Q0ruqksNbQXsyTFcYCsAlfT?=
 =?us-ascii?Q?6coYHvTZm1aHngnW3uuKBmPF9y77ofDYX4f+Gpr1GMGHbanP19dtvx7s4opY?=
 =?us-ascii?Q?s+VWHAtAEfdTeDxu7izBXnTHrZrFb7vYWyNYUuxdIz/TGQcqWGtlC/NaAjDr?=
 =?us-ascii?Q?Z3YWVKZVv8H8VqHJvhJQnTfOgS4VbVDT95FyOJt3IWNHlAiNfCTto2M8ptul?=
 =?us-ascii?Q?R4a+NNAo7iekw7qB//wtvJQYSsvca7Kcz0xyolnz8DiQSd2gAtooUDi/PEwS?=
 =?us-ascii?Q?ns5vCEiEw5PM02Xb6X2pPWENLokSOkUL3BDc6JWGYgwm+FMojuxjRxqKgZs9?=
 =?us-ascii?Q?3DILZyNkaBv37KAwsjnButlTu/scn3oQxpjD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0eT8oEEb4IUSOEEA0BNoKLmKVN3+zACDvTG3BAy20qdCMVso/CGspTmqLO+y?=
 =?us-ascii?Q?dGSjyeg0N3r+CdRRLwkYKurKNU+AwO+DONyDboUOObMQiGQm2Y5oj2aIlyI1?=
 =?us-ascii?Q?mjCzC8Nc9/dBs8Ctlvp4xZB+9gr2MqR0mEzf08O3/7Zq6euSOBR5tpqCLIFQ?=
 =?us-ascii?Q?eH87zeHvN+WXr3yQv6DvzDSyamGLmywzyuQSKNqcz3RDxd0W2y5riJB6v0d4?=
 =?us-ascii?Q?KSB1NLQ7AAu5LTnXQJoxJRlf74SL1nIqXTe3SLfgvFFdcBvTaoQ0JWtwrMvS?=
 =?us-ascii?Q?Hwi4rb7JPC2kcvJJMuuv4jNXnSsdALtDiXELbaKuHem4JoLNM+WR72a0WRV5?=
 =?us-ascii?Q?shSDCl8q4uwepymOAolQBcyG0sHoBKAXco4lFnIg8EVwUxq+VeZaZtUVvxUw?=
 =?us-ascii?Q?OEgJIshOZyBTl55JotgRLUDQjfHo1IEaro8HyWY5prjuZ/kZhh56gY3HEKFY?=
 =?us-ascii?Q?hcM2QgFPgmRoQ+8KJgAU6qw4/zPdk0Wd94ClvrBWrSbk9bLtjVqCI/ZaPOd8?=
 =?us-ascii?Q?2ImdVx75oZITq4XbwBBkOpu5FKqKwcEfVHfcu4xKa5LuonkFyC23+T0Jdwnt?=
 =?us-ascii?Q?ypQxEoC0tyA3Co9d1LqkEI0WVmZCJzo7JPpPn5OZ+QVPqEmQa11pGMJy0cx6?=
 =?us-ascii?Q?A/KGQS32FTL7oG+or0JiO9TBcSRJe5Auh7ctwjgpaMkzptsqudluydokooma?=
 =?us-ascii?Q?AhMr1kR9k0y8DCbT/T7d4ubDmy4qSveTYHjzP2VjGdI0T1TrAmDeNKm1HVdv?=
 =?us-ascii?Q?7gzAIGNvw2ha1wTMtUNhYTfJWYmQMF1M8N9ri6Qjd6Qr/jIVUL8k9Lfng+/W?=
 =?us-ascii?Q?m+D35Vm2gZSzuyapsH77UT5DZXG7qNqbarMKmbOGLyLuZKhNNsFGb/j2PhrF?=
 =?us-ascii?Q?KZ/RcQeXLFibatgwWReHG2mJzyObp2tp/uLfcDY/eewuOEQhJTZKZqryEzzA?=
 =?us-ascii?Q?LjvfNcSj5xWsy8O+iEiuX2Bh2MgfhJZBu5g6JHeRw303GQI+b/kb3rhQVskN?=
 =?us-ascii?Q?9cEKjKecLEGoc5QTeoRjBNcy2nG6iymENs3kccOusFJuN2Xp8gGI3FRI/E82?=
 =?us-ascii?Q?u1vdjiZmQXA6pW/Y4Ccnt0GLq1X/Pbky07Ow7XfibH0wVU2c67ZP9b2UIhI4?=
 =?us-ascii?Q?B/dhEtDCI4p1sDw0Py1RxjIqc4peCDSTaxp3RWnTbY8BFMkkR6ihDatm4OQM?=
 =?us-ascii?Q?TZ2nGa1pipvK/le9LTa9Eq3LBIIW2b53Rb4wxr+Jx42ukE7iaQpQ/9F+i/ZM?=
 =?us-ascii?Q?1sDRx53fe+CahftRc3td9XVXz9IC40n7Q3SmgmUooKYPpJaIO+RQj4XSuF1E?=
 =?us-ascii?Q?axyG5pZA5rE29eSm8UBbVHKQPnlh5Yz4TH97TRRcGaE76nI+wc4XGF8CyQkE?=
 =?us-ascii?Q?kGwQE7Zy4CBm4itT6HJD4kpSImg1DNIZoMD0c7kXSGxu6fWgQur1YnIoyDaz?=
 =?us-ascii?Q?3dbetShZO2v3wjAWbGK/vX1btQHBd+FGUYgV43ngKcjbKVhnVYbKqeugqCCv?=
 =?us-ascii?Q?lVgMu0yurOVV3DpNag6+hU+WoiOjJXNjBWRI4nNeYxpxdZ3RjjFHKIjYj1PG?=
 =?us-ascii?Q?FAlggzUoHn+2LPTmi/5e13il5AmePvGc2kFnAleo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29de5406-7326-4a97-9e45-08de399d6035
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 16:42:01.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsOqRgE65gcPjfhBb+jh7umuI5W4t/S/4Axgr0xwbJn9SE0FbKiaxFFjVRc4eRqggeQMb1G/56JGeAFiudZjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8480
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, November 27, 2025 3:45 AM
> To: Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/3] idpf: Fix RSS LUT N=
ULL
> pointer crash on early ethtool operations
>=20
> On Mon, Nov 24, 2025 at 12:47:48PM -0600, Sreedevi Joshi wrote:
> > The RSS LUT is not initialized until the interface comes up, causing
> > the following NULL pointer crash when ethtool operations like rxhash
> > on/off are performed before the interface is brought up for the first t=
ime.
> >
> > Move RSS LUT initialization from ndo_open to vport creation to ensure
> > LUT is always available. This enables RSS configuration via ethtool
> > before bringing the interface up. Simplify LUT management by
> > maintaining all changes in the driver's soft copy and programming
> > zeros to the indirection table when rxhash is disabled. Defer HW
> > programming until the interface comes up if it is down during rxhash an=
d LUT
> configuration changes.
> >
> > Steps to reproduce:
> > ** Load idpf driver; interfaces will be created
> > 	modprobe idpf
> > ** Before bringing the interfaces up, turn rxhash off
> > 	ethtool -K eth2 rxhash off
> >
> > [89408.371875] BUG: kernel NULL pointer dereference, address:
> > 0000000000000000 [89408.371908] #PF: supervisor read access in kernel
> > mode [89408.371924] #PF: error_code(0x0000) - not-present page
> > [89408.371940] PGD 0 P4D 0 [89408.371953] Oops: Oops: 0000 [#1] SMP
> > NOPTI <snip> [89408.372052] RIP: 0010:memcpy_orig+0x16/0x130
> > [89408.372310] Call Trace:
> > [89408.372317]  <TASK>
> > [89408.372326]  ? idpf_set_features+0xfc/0x180 [idpf] [89408.372363]
> > __netdev_update_features+0x295/0xde0
> > [89408.372384]  ethnl_set_features+0x15e/0x460 [89408.372406]
> > genl_family_rcv_msg_doit+0x11f/0x180
> > [89408.372429]  genl_rcv_msg+0x1ad/0x2b0 [89408.372446]  ?
> > __pfx_ethnl_set_features+0x10/0x10
> > [89408.372465]  ? __pfx_genl_rcv_msg+0x10/0x10 [89408.372482]
> > netlink_rcv_skb+0x58/0x100 [89408.372502]  genl_rcv+0x2c/0x50
> > [89408.372516]  netlink_unicast+0x289/0x3e0 [89408.372533]
> > netlink_sendmsg+0x215/0x440 [89408.372551]
> __sys_sendto+0x234/0x240
> > [89408.372571]  __x64_sys_sendto+0x28/0x30 [89408.372585]
> > x64_sys_call+0x1909/0x1da0 [89408.372604]  do_syscall_64+0x7a/0xfa0
> > [89408.373140]  ? clear_bhb_loop+0x60/0xb0 [89408.373647]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [89408.378887]  </TASK>
> > <snip>
> >
> > Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> > Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

