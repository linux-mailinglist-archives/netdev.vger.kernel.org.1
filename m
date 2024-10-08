Return-Path: <netdev+bounces-133222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF499556C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EA2824CD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F011E1044;
	Tue,  8 Oct 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLb7FjU+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36A1E0E1A;
	Tue,  8 Oct 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407640; cv=fail; b=LTMjnibTfB5OHDN25ddZcRiaKQs0J9ZzO+ZOb2Z/7YzltfDWOSj3qjikWbiBPjvUyrJ5bglF9GgqGiQ85ZDAhjGVjdwlXiAzqDsRTPHVDAEFgx1fQx6Z09hZwvoywIntpAU7C73shAa6M6cDm4FkgK2SIBkS8dlLyO2ZSUYLnxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407640; c=relaxed/simple;
	bh=aSdeZfGG1QLSGasv5Ub81mQcgqVPYR+YWEgAPofS5jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t6rXFlp3vcvW9x0ZJS61oy5wy0s8jylYI+y6CKmr5XkOxmGFz5o+9stqG7sSL0ARBKDE6ch546q9Kul5A4502ieO10gmjo5drDmW+iSZLPdc9OqL0EH2DefZp3BaT9H2i28gWcNr0bGXfB7LUxMAm9XIwpVzQV2KXXDv8s91kIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLb7FjU+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728407638; x=1759943638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aSdeZfGG1QLSGasv5Ub81mQcgqVPYR+YWEgAPofS5jM=;
  b=HLb7FjU+U7sOJZrXkvCufyE5n8N3mD8vDyzN9DAee3kCOmP14mJKk4cu
   zQ+7N/unjnrdzBwt6MwDcUceoOpj+3app7H2F0lZOPTEOieTs//KuabGn
   I9gyHEzmMFKOeDoEf71tF75AmMtFTseIvyx3s+0dSmeJKtqEJDeZC44OV
   ZseOBZTtLw+DZ9hGi4PDooecZ7xvoItcZLv2TkYduSBHokd57ai00/+wt
   LqllAsATWvhFscgH+ttu9NsXlHERzTLNPDMpsq8oJO89dk49yZoJkl9bx
   6ugF7FWdVEM3+5CRIAeKK6CjdXIpCZNNrqyqAvxEOWDzc6guCyMGsWUEC
   w==;
X-CSE-ConnectionGUID: gr1Ah81mQMONpGjGOGBk8Q==
X-CSE-MsgGUID: LmV2UK6VT4u8wSxZ/ixPoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="30507299"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="30507299"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:13:58 -0700
X-CSE-ConnectionGUID: //APaO29SWa/AoUS+HojXg==
X-CSE-MsgGUID: X9dA8C8GStGHjqSIAigxTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76162745"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 10:13:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 10:13:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 10:13:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 10:13:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 10:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kul9ZLBr9vdpZqtsuIvEqZMPG8kMKW8QuBIeXQj192nLuKRmHD3W3B23D5oUkPy7W0ucnNWRa1OSosqcrlMCrvWRn3+EeNR4RMYCpzuFQHvmjwau/nSiJqp5HekfnYDYChlmJDuuPvdqtfA8vl0PpCk5iLssAQtfaYGYsOiYNgw29dABjBPjkJrXnYqACUtofUVxZlfYQzB+KYP77H9pv3GyHp56Dcsu+pI7iw6MMD5qf5Uy+4IArBCII+6e39LPasWM6uZjgRD5Gh+kkwK3YJoRapExTj52gWPBQr2YbrjiXs1VYbkKb8n5NDKWHS1psbwVw3PHawWzIEkSB9sJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSdeZfGG1QLSGasv5Ub81mQcgqVPYR+YWEgAPofS5jM=;
 b=NmFMOR5+8QEUenNROUXT9YAdZtSuC4BlOhPZqgNiJeq6h3OG2CiY9esAxS10Xh3d5gdKg8Uz5nvL0ad6VjBLVI2SKcolCN/YQA1vdalr33j44oDbqgaZiFnmDB3GfrBRao2LVGeHUUxGvD/b/6Sg4daY8gbUGDJ9RdnQifTKTM+qliajWhE9Q6DQFauFCODsLdqi8Mk8tjniRATLzillIfdXkz4Ts3qPT2eFmuffZMI64f0860jU+B00S0veN8KaUPU/rdoLkFxYP6hcQxvgaQpvFr6DOHOGV47eoWiqFAosxgbzTjLnzJaNvU5cyljw5Gy0IdaBQSaFr/H2Izf2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 17:13:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 17:13:53 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Rand Deeb <rand.sec96@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: Chris Snook <chris.snook@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"deeb.rand@confident.ru" <deeb.rand@confident.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"voskresenski.stanislav@confident.ru" <voskresenski.stanislav@confident.ru>
Subject: RE: [PATCH] drivers:atlx: Prevent integer overflow in statistics
 aggregation
Thread-Topic: [PATCH] drivers:atlx: Prevent integer overflow in statistics
 aggregation
Thread-Index: AQHbGJuXxAo7WiVTwUyydrMzd5tCILJ8AG+AgAEVIoCAAAJFoA==
Date: Tue, 8 Oct 2024 17:13:53 +0000
Message-ID: <CO1PR11MB50892CA8EED56D7268038304D67E2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241007092936.53445-1-rand.sec96@gmail.com>
 <20241007172715.649822ba@kernel.org>
 <CAN8dotnMoh9VKd50MQx=FJ9ALhsHp7DMsMNq--EdrbWb8=Vv3w@mail.gmail.com>
In-Reply-To: <CAN8dotnMoh9VKd50MQx=FJ9ALhsHp7DMsMNq--EdrbWb8=Vv3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MW4PR11MB7125:EE_
x-ms-office365-filtering-correlation-id: 1060f965-4ea6-4da8-183e-08dce7bc9600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OTNRa1RtQzNHYlYzam12VElrZTVscGxycHlzcHV1dE51RlZrN0ZINEoyRW9L?=
 =?utf-8?B?OFJxcWxsa2JNazFBaWgvRlRYdU5HYTlINFJVOGJUQ2p6enZuMFp6TUhRNUg4?=
 =?utf-8?B?TnFXNm9DYzZDTTBBT3dFMGtHS2MyUkw3Q0VQcGhZaTVnc2swbXZBczV0K0xl?=
 =?utf-8?B?azNpTWdHRitHdjJsNDJqSHRmbktFRFhFU2IzMUMyeWE5OXBENlYzS1E3QzR5?=
 =?utf-8?B?RlZZT0ZscTIwM1BwUmtqcWhIWStpY2FLb0p0cXlIMFRZYW1BS3B0eGErVUFS?=
 =?utf-8?B?VmZrYzd0akh5QUNxaHdFY0ZaV2hwVlFxQSt6TjgxMVI4YWMvR3JqTjhSMHBW?=
 =?utf-8?B?aVg3Wm5xR2Y2T2RJdG5mVmNzWXlncll3b0l1SUN6RHI0Y3NjU2gzQVZEbHhN?=
 =?utf-8?B?L0pRZStxZU1kQUNLMlNIVC93VStNZ25yc1pjdEpUSk4zNnorMndubnEyYm5O?=
 =?utf-8?B?akFFZzVzdVdOS1g3amVUKzl0WktRNEhXV2NDaVNKanBKTWRkYUE5RXV2RmdY?=
 =?utf-8?B?SGkzWUhUWGVqTFhqdzZkSURUeW9TUDBtMlBCNGl2c1VnRmdEbCt4T24xRWk5?=
 =?utf-8?B?RFQvTG1zWENxcVg4dE5vQUowTzdMRzJDWGFPeHduT3dBbjExZHNjWTBkc3R4?=
 =?utf-8?B?bHdDYUkwMHhyQVJNLzlHaXoxUlVDY0tmbHpuQ0RxaGhUTGtEQWZaMnpBUWhu?=
 =?utf-8?B?TFN6UlcvMnpmNnRFcVI4YWdLRXBnT1JBbkNqSjZ6S3YwS2Q4K0c2c2N1NzJ2?=
 =?utf-8?B?K0lic05pcGZFNGF4S2xHM3U5cmdqb1RqUVNacno3WUhJV1A4ZFpWbXQwUDdM?=
 =?utf-8?B?emNsM3RVRmRqdzlQMjArNm1kczkvQS9HUCtONjN5NzhHL3BVODBoOElRT2VB?=
 =?utf-8?B?ZllFY0dqZzkzYm5USXBUVHhvL0hVa09Bdmk1MHpJSmgzdHNCS2xxak9icmli?=
 =?utf-8?B?L05kNkQzVUorZGpXNGxYUXJlajFUN3paRU1BdWRuQTVna2lQQ2hYNlpRQi9u?=
 =?utf-8?B?bTV3R2orME9sQ2w1Ylp0UDdVQjIyRXFRNE9SangyTWprTUJ3bk1KSWczb1BQ?=
 =?utf-8?B?ZmVrZU9EempSOHZVUlZHWXA0VE5FNUhpckNKaHRjTzF6TVJsemg4RTdNc0do?=
 =?utf-8?B?ZmRsL3JPaDJMdWRnbkZkWnJTWkVWSGJtTGM1ZlR1SWg4VFVMNGk2ZGVveU9F?=
 =?utf-8?B?Q0hwZVZwZDNxNHJvQTBTNmh2T0tLOGIvTG8wSS82QStXN2hMNUx3NFF1QmdG?=
 =?utf-8?B?bW1IT0NDSnd2enRoVXp2cWpkMkJXeHdPWlRkT0FXTkxHZzNQYkJkVk1DSHVy?=
 =?utf-8?B?NnBUcjZVSmwzMUVrbmpKV0xXdkhZdzN2a2RZUkRtMTE5cFJmSHFJU0VrVDY4?=
 =?utf-8?B?TjRKZEZsZWdRUExpMEs4OTM1MUQzckJzSTNnc2ZGZjc0SUZYL2d2L3p2UzFZ?=
 =?utf-8?B?NzZzcEExbW95Z2lqZEFXMmhLUUdOMVFDdWZCR1NDOTdMdDlxSmNBL1p1QkFy?=
 =?utf-8?B?enViN2E0QTkzOWhUTHA5QUs5ZHg0NzJJYXFPSzVUMTlrQmxycXhkd08rZTh1?=
 =?utf-8?B?QlFGVVdYcUdHKzFQNDZ2bHk2cEtORG4wYTNtYWU3MmlWSTUybzJ1NWtWTGZ0?=
 =?utf-8?B?QnkyVHhqMmxHaXVXRW5YZzY1UWVJcjcvR2VHV0I0aFFuemhJanRmZEJudjNn?=
 =?utf-8?B?a3Vha2lOWVk1eDYxcktrcGlCd3FKbXZXaWdFakYrZFBZUmp0MUsrb3pNcm5q?=
 =?utf-8?B?UWhJRkVBWjJvdldXODVjcUtaaVFESFdhVGtEVllER210S3Y3UGhTWXNXOEE0?=
 =?utf-8?B?WFU3UWw1R1JqSDZkbWZGUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhzMUNwVXJ6bFJxRWVxZUNIQXpqMFRWaEJqRnZHK01mZTVxK3V4VXdPMklG?=
 =?utf-8?B?dEd5Y0s4TUE2Y2QyYlI5VUJEcG9tUExRWVB3a1Q2SzlpTWRrdS9RLzNCNXpN?=
 =?utf-8?B?bUx3QnJKUHpTMWFPbHJJTzBxdW9PZXpzZnZuVzFYZzBvNXJ1N0hTOEMwVnJ5?=
 =?utf-8?B?MjFXZk5xRVNMei9MTlFJSTZDZ2pveURhTURZQ3R4Tm4xQVpENjJJZWlueDcw?=
 =?utf-8?B?Z3ZIMjlxWjk0cS9DYmlITnl1d2pNY2o1S1ZLa3o5NUdlRXZMQTZKN09yTmFm?=
 =?utf-8?B?NjRlc1VMREdDV3FlS0JZTVFiUEJ5Y3k5REF5eTN2dUJWQVM4ajJhQVlGRWgx?=
 =?utf-8?B?T09xaUVEelRYclZyVFJVakdyZkM0cWNpdWVUWVlWQ3ZmaE1YUDVSYUNtVkE4?=
 =?utf-8?B?MTJ2QlI1c1Y5b1FtR3ZaQkJFcDdyRFYvRE05WEpaOEppTWdDVCtOZDhFT3Bj?=
 =?utf-8?B?MldKejZ3VWhVa00vSElXUm44T0d0SnBBQlliSjBtK0QrclpWUm54cDlRb3Ar?=
 =?utf-8?B?aUI0WlpXZU1RR0VkRjIzQ3JMQ2FDSUVuRXpDVFcxOWtVaUZCSDFWNXNTOVU4?=
 =?utf-8?B?OTdIeXFFR2Q1TXZRR0IwSUU4cWZWbWx4a25IUGtlOVhndHc0Q1I3TmtMZDNr?=
 =?utf-8?B?VDlUcU41L3NvWnZuRFBIWHF3aGEvMEx0VEx4VkxQbkNncUdrdWdJaGdibGsz?=
 =?utf-8?B?Q09XYVJyUWZZUmlhaDRGQTIwWGVIS3ArR3FWUnpiRnFnaXM2ZUVERkt0c2d5?=
 =?utf-8?B?b241cDM5Y2xxRzZqeVRMWUhzaVFYbm9ZZXBYcnVORjJxd3NEZ0xsTDEzejBj?=
 =?utf-8?B?dXFPSTBUaU00bmlzNHYxQ3VEMGNPTkZDWWM4anV5cTZvdkw0Ti83V3NFWVov?=
 =?utf-8?B?a0VYeXlndHJWVWNWMkV4OGppQjdyL0RNY3EvMGUzSFN2VlZrMmRtOTNwZkJW?=
 =?utf-8?B?dSswRHM4UUVuY0RzMUtwTmovakVFTjRIZXJ5c1FyRkJScENTbWM0VXRrdGpn?=
 =?utf-8?B?UFZBMzFlbGtOVDk0QzhGVEJwUzJUQm1QbjZHaG9DS0ExZmMvTHltSzFneDNt?=
 =?utf-8?B?bUFZVkQxcFVsdEsvUk5EYSthdk9YWVpNWTdHZXpqdDh4KzhUcEpmTWg5anBv?=
 =?utf-8?B?bm1JWEV1SXpMcndSYmJpUnpiUmQzTFl2SDMyVFFBVlJQQ1NneHQwdllUckpH?=
 =?utf-8?B?WG1XN3ZPTGdWNWxzS1JBeUFhZUQrRkI4ZXc0UmFTNmpVdEFMVldvbWZ0SG1m?=
 =?utf-8?B?WXdQdUVYMXhDcUFISjd6ckoxOTdnRDV3VEZud0p3b3VtZXRSc3V0Um4vS1ZK?=
 =?utf-8?B?Ulltd3R0ZmIzN1VCNWtsNXFnY3ZnblRpVDFsYjZja0xtekhoRVhvTkdodXQ5?=
 =?utf-8?B?VGlGNVdlYkhvc3VNVTRHZGUyUmxLenI4U0NvazhVZXlUWkFjaEl5bHIzNjho?=
 =?utf-8?B?enFpY296MUlySklxV2M1bmJxcERJL1kyYzNHWkc3Ky9SVHhXZ3ZQYnRrOGIw?=
 =?utf-8?B?dXQ1TjNvVzdQTng5MnJTQmtRYWVUWUtiaUdldHRrL0lvZ0QvZkd0MlJTeE5v?=
 =?utf-8?B?RW9naGRhTFlOaytwT2dyK2FGem1mbTZmdGNWZDRKZEx6a1hsWlFKelBrTW4r?=
 =?utf-8?B?T1ZvSEpQOEhJMTFFUkt2Ynd1cnRiUHhGM0ZwUEhUOC95ektqTmpYbEovR3du?=
 =?utf-8?B?UGwwdXRTcFhYaG8xc053VC9EWFZ6Q2RWVUNRa1BtY1h6ZUUxNmFvWDgwUVVx?=
 =?utf-8?B?enhTVHI0aFo5elY3blpDMHlHRW9KTnhOM1VGbS8xeVB1VC83bEp2ZU1GMGIr?=
 =?utf-8?B?TjBXdTd2RGpyM3Z2WGtXcVpTT1FYYUdKRnV5WWVqbjRtdUp0ZHVERmNnY0lX?=
 =?utf-8?B?a0xkbERJQms4OVlrN2VqZFNwZFI0UTgzUzBxVDZxVEwwQW1NdVBhWklHS01l?=
 =?utf-8?B?NTRuNWhiZWd4bkdNM1A0dGtmZThLbmhPZUxrUVRMY3phWkdHR2JEZ0lPWHVs?=
 =?utf-8?B?bE5wOEVETndJYjJiSUQxeUt2RFBiL1duUE5kdjQxdXp5ZzYwa2ppbnFPS1lu?=
 =?utf-8?B?Y2JxNzFTV2tRc01uNUZxTzU3VC92OFV4a1R0Ly9OSVpYMi90NjBJdWtUTG5n?=
 =?utf-8?Q?LaqEZlaiHUAVUOz2graSO8gZk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1060f965-4ea6-4da8-183e-08dce7bc9600
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 17:13:53.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+orfLcbnvby7gBnjXjkh2Z/PRSrQKBYDLNveiXOs0HB15/ZstbuKCspmXLiYIXhYlddzCo3UBtDDu/s08k2n7jIHxaapfMo53RgnmCmeXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZCBEZWViIDxyYW5k
LnNlYzk2QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciA4LCAyMDI0IDk6NTkg
QU0NCj4gVG86IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBDaHJpcyBT
bm9vayA8Y2hyaXMuc25vb2tAZ21haWwuY29tPjsgRGF2aWQgUyAuIE1pbGxlcg0KPiA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xv
IEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IENocmlzdGlhbiBNYXJhbmdpIDxhbnN1ZWxz
bXRoQGdtYWlsLmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRlZWIucmFuZEBjb25maWRlbnQucnU7DQo+IGx2Yy1wcm9qZWN0QGxp
bnV4dGVzdGluZy5vcmc7IHZvc2tyZXNlbnNraS5zdGFuaXNsYXZAY29uZmlkZW50LnJ1DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcnM6YXRseDogUHJldmVudCBpbnRlZ2VyIG92ZXJmbG93
IGluIHN0YXRpc3RpY3MgYWdncmVnYXRpb24NCj4gDQo+IE9uIFR1ZSwgT2N0IDgsIDIwMjQgYXQg
MzoyN+KAr0FNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gTW9uLCAgNyBPY3QgMjAyNCAxMjoyOTozNiArMDMwMCBSYW5kIERlZWIgd3JvdGU6DQo+
ID4gPiBUaGUgYGF0bDFfaW5jX3NtYmAgZnVuY3Rpb24gYWdncmVnYXRlcyB2YXJpb3VzIFJYIGFu
ZCBUWCBlcnJvciBjb3VudGVycw0KPiA+ID4gZnJvbSB0aGUgYHN0YXRzX21zZ19ibG9ja2Agc3Ry
dWN0dXJlLiBDdXJyZW50bHksIHRoZSBhcml0aG1ldGljIG9wZXJhdGlvbnMNCj4gPiA+IGFyZSBw
ZXJmb3JtZWQgdXNpbmcgYHUzMmAgdHlwZXMsIHdoaWNoIGNhbiBsZWFkIHRvIGludGVnZXIgb3Zl
cmZsb3cgd2hlbg0KPiA+ID4gc3VtbWluZyBsYXJnZSB2YWx1ZXMuIFRoaXMgb3ZlcmZsb3cgb2Nj
dXJzIGJlZm9yZSB0aGUgcmVzdWx0IGlzIGNhc3QgdG8NCj4gPiA+IGEgYHU2NGAsIHBvdGVudGlh
bGx5IHJlc3VsdGluZyBpbiBpbmFjY3VyYXRlIG5ldHdvcmsgc3RhdGlzdGljcy4NCj4gPiA+DQo+
ID4gPiBUbyBtaXRpZ2F0ZSB0aGlzIHJpc2ssIGVhY2ggb3BlcmFuZCBpbiB0aGUgc3VtbWF0aW9u
IGlzIGV4cGxpY2l0bHkgY2FzdCB0bw0KPiA+ID4gYHU2NGAgYmVmb3JlIHBlcmZvcm1pbmcgdGhl
IGFkZGl0aW9uLiBUaGlzIGVuc3VyZXMgdGhhdCB0aGUgYXJpdGhtZXRpYyBpcw0KPiA+ID4gZXhl
Y3V0ZWQgaW4gNjQtYml0IHNwYWNlLCBwcmV2ZW50aW5nIG92ZXJmbG93IGFuZCBtYWludGFpbmlu
ZyBhY2N1cmF0ZQ0KPiA+ID4gc3RhdGlzdGljcyByZWdhcmRsZXNzIG9mIHRoZSBzeXN0ZW0gYXJj
aGl0ZWN0dXJlLg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgbmljZSBjb21taXQgbWVzc2FnZSwg
YnV0IGhvbmVzdGx5IEkgZG9uJ3QgdGhpbmsNCj4gPiB0aGUgZXJyb3IgY291bnRlcnMgY2FuIG92
ZXJmbG93IHUzMiBvbiBhbiBhbmNpZW50IE5JQyBsaWtlIHRoaXMuDQo+IA0KDQoyXjMyLTEgPSA0
Mjk0OTY3Mjk1DQoNCklmIHdlIGFzc3VtZSB0aGF0IHRoZSBjYXJkIG9wZXJhdGVzIGZvciBhdCBs
ZWFzdCAxMCB5ZWFycywgeW91IHdpbGwgbmVlZCBhbiBlcnJvciByYXRlIG9mIH4xNCBwZXIgc2Vj
b25kIHRvIG92ZXJmbG93IGEgMzJiaXQgY291bnRlciBvdmVyIHRoZSAxMCB5ZWFyIHBlcmlvZC4g
TG9uZ2VyIG9wZXJhdGlvbiB1cHRpbWUgdGltZSBjb3VsZCBkZWNyZWFzZSB0aGUgZXJyb3IgcmF0
ZS4gVGhhdCBkb2VzIHNlZW0gdW5saWtlbHkuDQoNCj4gSGkgSmFrdWIsDQo+IA0KPiBUaGFua3Mg
Zm9yIHlvdXIgZmVlZGJhY2ssIG11Y2ggYXBwcmVjaWF0ZWQhDQo+IA0KPiBIb25lc3RseSwgd2hl
biBJIHdhcyBpbnZlc3RpZ2F0aW5nIHRoaXMsIEkgaGFkIHRoZSBzYW1lIHRob3VnaHRzIHJlZ2Fy
ZGluZw0KPiB0aGUgcG9zc2liaWxpdHkgb2YgdGhlIGNvdW50ZXJzIG92ZXJmbG93aW5nLiBIb3dl
dmVyLCBJIHdhbnQgdG8gY2xhcmlmeQ0KPiB0aGF0IHRoZSB2YXJpYWJsZXMgd2hlcmUgd2Ugc3Rv
cmUgdGhlIHJlc3VsdHMgb2YgdGhlc2Ugc3VtbWF0aW9ucyAobGlrZQ0KPiBuZXdfcnhfZXJyb3Jz
LCBuZXdfdHhfZXJyb3JzLCBldGMuKSBhcmUgYWxyZWFkeSB1NjQgdHlwZXMuIEdpdmVuIHRoYXQs
IGl0DQo+IHNlZW1zIGxvZ2ljYWwgdG8gY2FzdCB0aGUgb3BlcmFuZHMgdG8gdTY0IGJlZm9yZSB0
aGUgYWRkaXRpb24gdG8gZW5zdXJlDQo+IGNvbnNpc3RlbmN5IGFuZCBhdm9pZCBhbnkgcG90ZW50
aWFsIGlzc3VlcyBkdXJpbmcgdGhlIHN1bW1hdGlvbi4NCj4gDQo+IEFkZGl0aW9uYWxseSwgYWxs
IGNvdW50ZXJzIGluIHRoZSBhdGwxX3NmdF9zdGF0cyBzdHJ1Y3R1cmUgYXJlIGFsc28NCj4gZGVm
aW5lZCBhcyB1NjQsIHdoaWNoIHJlaW5mb3JjZXMgdGhlIHJhdGlvbmFsZSBmb3IgY2FzdGluZyB0
aGUgb3BlcmFuZHMgaW4NCj4gdGhlIHN1bW1hdGlvbiBhcyB3ZWxsLg0KPiANCj4gVGhhbmtzIGFn
YWluIGZvciB5b3VyIGlucHV0IQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBSYW5kIERlZWINCg0K
U3RpbGwsIGlmIHRoZSByZXN1bHRpbmcgc3RvcmFnZSBpcyBhbHJlYWR5IDY0Yml0LCBJIHRoaW5r
IGl0IGRvZXMgbWFrZSBzZW5zZSB0byBkbyB0aGUgYXJpdGhtZXRpYyBpbiA2NGJpdC4NCg==

