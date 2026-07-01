Return-Path: <netdev+bounces-303563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zbDCLvzjRGqo2goAu9opvQ
	(envelope-from <netdev+bounces-303563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:55:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001546EBC4B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:55:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jARGUzlj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303563-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12CE130557DB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAF3A48F4;
	Wed,  1 Jul 2026 09:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CD3C81B5
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:50:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899441; cv=fail; b=ojaMXjMDZtA9FK1lQ76jrcgZC07VokxPUFGsSL2IN4ffsBObD5fvLBBSGUFJ3v0a0pN/Fz60QEZgqhLvGW1SgHKeUfoeB9nk1yVtTfkeQuJ2mF0FDM6t+fVds4bjJMcBfMxMik9BY/L0UAkN/KwWVOoupA7z3E0E45IlS7q4Qi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899441; c=relaxed/simple;
	bh=6MQTh/MD4lqXr5zizex78s0X23NnQqjRQfIqz+PYkBE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xf66dNP9nN6itXWkgehOeNchBROH3vM1fssqVqs11OWJmkpMl1FW5OfZBdSNrkzM6yBWTvo5M9nvqT9q7N2w/IYaQzpzAFy7BJqqMnOSEQMi4m9/kIJaTHucyvSDgZnht78u7QuGNT9Uks/0igfaw0HuuHmpbVXysu0FjZZJPsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jARGUzlj; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782899441; x=1814435441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6MQTh/MD4lqXr5zizex78s0X23NnQqjRQfIqz+PYkBE=;
  b=jARGUzljqXTgyIih9qeTofNtjK3/xznkyYugidjEzxzdAYmPFY1Phd5K
   u+qZyz7rzG5vuo2ANs0F4WyQnuf4FPr7wI79r1DRdBbJ6xHd5c8lfVWA6
   6LFF39hIdv47/+hfbaU5QlJEVYhQC5sCXZikdsyYwittMJiwHONVmjMLh
   crFLT7FuZk6Htn+4sUb94vRC6DbTCPwGi46qt3k1i33cyIjN1rYM/uEPZ
   Fstm91amctxEePfnIpXMUvox9wdqhM/qXxnRoBpn5Mkp/MoavQK3bvWgZ
   PcKRCIEJSwzI/7dJSyrsZeGxa9z3Hei2LxXte0zA5EAKonQ9eo7AsKod0
   A==;
X-CSE-ConnectionGUID: wdXecnWSQIiYb/vwBu/JNw==
X-CSE-MsgGUID: P6OUVqMfSuK0opNKqMsU5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="95010183"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="95010183"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:50:40 -0700
X-CSE-ConnectionGUID: 3f2K4YTIQHWJU6PZ+UNR3Q==
X-CSE-MsgGUID: PRGBGG+EQ8CrXplvuimR4Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:50:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:50:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 02:50:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2S+IpFKsTEe0k61m0A7Jm6S1khY+ldhoG/sp4mv5z/6WdGkiKtBUoyAd5ru+F6TXyOtFOIw8JTISIHvFOrJOYV6J6QWpjqd5/20tyqOcK0XCgAHsdbVxHtfLPqdF1WPLNeky9oxoqJRGPLtoLmUNiOfc2nJqSe92f7d3O3K0v45eSKdMvVUUap9fxExEWlmepF04YBuMEmzkna7nyt8yzUrugAHCj80jVJo2eNx7mgEAGWwpMCP04IPWuXBu6vGtrtdE2/NVFJgcJyYerz1TvzsxtT1UBqY/p03S+KyYfqLBfIrcJtC5FWKDhRD9BEs3jW5zcsu4e2RdqrO8q972g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYu7aK0KwDXWZXmfB2zIrAMqacmJ3uOS7eKtisWLYCY=;
 b=mVaTbg9nKqBaKxNuBbtRwydhMrKYkHEfPLqF8ED3NzEko6rN3ot+JybGnoCgsSf0TpQGV4BNVvrCysfa2HoZ5SJ7gCXuRzWQ5qBmEvqqUPie0fup42Gyea3BwBp9zxafDdYJDUWWoM5gYRzc6tm5uOdDWzdVcBQLnv4YoiBPalEycjXwaI1pNn9D0UABPpH4SvrN9Gxr0RloGo3/wbmFN+bwqybOcG6cTP2Nhdlf5UASSOWYRxxCWg8amM8KisC+uEnMAHK7wzUmsRW2c23R/U2FB4ttTJcGmotUCyCp8MjTv0q8X4BZjAo1vAQpUX0nqZCOahu+48SZCVAAh5BB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 09:50:36 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:50:36 +0000
Message-ID: <ef2ddb42-1453-48ba-9025-6c72c371de82@intel.com>
Date: Wed, 1 Jul 2026 15:20:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] drm/xe/sysctrl: Reuse xe_sysctrl_create_command()
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dev@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<mallesh.koujalagi@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-6-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260623101043.255897-6-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0271.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH3PR11MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: c9357732-83f5-499a-3291-08ded7563332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: aM1pyZ4xAmjfOtMEBL4XdSgsfkiDLvmiaSn3a647j0xzYy9udx7LWGvvdu0bndMUuHNcWp39rmYgqi/JoIe/fD3VbWX7Nm+TgkxmlXELdnSguJ5hJzQh41vU222W/UTgr1vnegFcINj7Ka/yKzDNf4ez234R2xzqwXGKqRt0MR7HPYEV0Gc073GOtjMSBFg2wuMLqAq1fW7i6RL8Gp5VRbr7RHs30X4znbolj9XcuTXYaHvl2uKKSycuoxrprQJfqk5nOf+EF23733cKGjw8VVntPfmqWcRbZCqzI8c+6E72TivtZG8ue1yHCJ1MdpvSfop0sHtpBcrTZDAp+YOe9OrrbcZMbJoM4TBNiz8a6YrLXKk/arxMzg6cXIq6MNNb1W7M+Eb4n4/2P/CMazU1hNeZSuVPRqk18J+aKLa+IaV24PbQNV8B6kHGjswJA2U2F95rwwZvRINRP/QX43ijqhHB6h6XIAfV6lRzCouR37dFzrhP7TUdKkOVh78z8NmfEo8Sxbd+Lg28VnkJI7jB2+PK3G46aR1iZVx2Do7NBqNCpkIEejjSUEqLLcLD+TxZPq/NqluUmrNDeNzPDzxnI+vNz0e97uIxIUn6HML8aOOapANNLzv/u9pXHA5CsUzF2/PA+iqoMieGb5dKufMJ6UtAU2DXzOR8P2zgQ+7+P1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZBekl1UnNPWmptMHI0WDNQS2FveWtrVHFSNWIxVUl5ZzJVdjE4TDdYNFI0?=
 =?utf-8?B?SWdoOVNKNGZ2dDRhSnZ3TmhJVVhRWGtFRmdBMVZHZ0t2eWdZWmxyTnd2TVh3?=
 =?utf-8?B?VHk3azVKYzU5aUFqays0WHVoR2lqSnk1OGRmMmx3azhWK1RyMWs5cU9DeUR3?=
 =?utf-8?B?MFlHa3orNmROc0Vpb0FxcjV5NUdYVlFjZVB5dG9TL2tHVExTSnh2UThkMmlI?=
 =?utf-8?B?VG5aVWxOQ1FldEtCREZRWkQ1cGR5MUJaSXcxYkRZek9BN3NzWjdJcmpQekFi?=
 =?utf-8?B?SjZ5SzA1WUt3U05MWFhtU2lMQWNaT0p0Yk9oS2I2MVBycXJ1a0xLaE12UWd6?=
 =?utf-8?B?YmV6aVZmc2Q4QTNFamFVNlM0akRseE8xR1gzKzAxUFordUZzKzRydGRVeGp0?=
 =?utf-8?B?dFZzMUpwMHhqUmZYU2NXaDF0a0dnbmo1eUlaWDFLNHRJTG1ZNFhLNEJNMm9E?=
 =?utf-8?B?NHRUa21SUXJmMUhLbmptYjl6b0tkSDdzZWlRMWlzSENDQVhqdVVqUm0rT1Fz?=
 =?utf-8?B?TjMvQUFhK3lpekFsYk5JNDN0Zk5SVzZha1dYbFlxTjZEOFk5YlZLdk5TSU9J?=
 =?utf-8?B?QTFIaG90Zmxmak1vWUZLWndlWGFJQlhrUzFtb0d2SHI0aUQ4cHc1Z1IwTDk3?=
 =?utf-8?B?MDBTMHdBb3Eyd0MvcmhmdDBtR2l4M2lLRXp5NlMyUTJLUzU4OXNaaVRJajFE?=
 =?utf-8?B?OGpZSzRFZ0NDUlBzcG5wckowRmZlTk1xZ09vanlCS09MWW5IeUJnL2ZYWlZy?=
 =?utf-8?B?dG56TFFWellmeDhYalRXZldxNDkxWWZqT1BsLzNnV2R6UjhRRnpPVDU0WGN2?=
 =?utf-8?B?eTA5bmFIZ0F1TG9ReElMRlkwNndUK2tYd2RpQlpNNGxJUVVNNXlscDkyU2cy?=
 =?utf-8?B?cnJoeGlnZmJraFMxWnlhTlhUVlFnZmVSSCtJb2JqTnJUVnVObzkrK0Uyb1lx?=
 =?utf-8?B?QyszVFpsc0dwWGpRYWhyMzNKUEV6c1NKT0hqd2ovVGlOWXNUUi96T2VkOGhH?=
 =?utf-8?B?aXd0MkQ4WElzZUdxZ1N1MnhmUUNJdlV0Qll3RTBLT3BWbzJGU21XOE5YZEdV?=
 =?utf-8?B?YTRSM3J4SnNBOVNKYWU3aGJKMmdMWEZ1SUJ6bVNIUXlpRkkzclhzMVlKZ3BL?=
 =?utf-8?B?TVRWSWFVMVdEYmQwS0tjNnppb0s4enhsTWlvSjc2R1pRM29vMk9PMW5zVHlG?=
 =?utf-8?B?YnlhK3kwOGlURjBmaHlwaXp5N2J2aUZyMXU2aC9ISGp2eVhTUm5uN0VmQkd0?=
 =?utf-8?B?d3cyaEJTeG4weEZMY1pkQTMzN1hVUC9pNHcyRVBhNzNxTjJlcWtONUZqNkRv?=
 =?utf-8?B?dXV2K3R4L1J2bUtWd2VCQ1M1MmxpNXl0RFBPakNpYnl0OTBuNXdPZFR4NmY5?=
 =?utf-8?B?YjNsWEw1SXAxRWFLU3c2a3RQeUtTLy9VMlBJL0tMRUdXSnBrN1lJc1QxZHZa?=
 =?utf-8?B?dUhaalRzU0FCV1dwMTZWRG9scjNoL2pTQXJhRFNDbDBXazJ1RHVVQ1ZDZVlV?=
 =?utf-8?B?YnNKQ3UrQmVJMzE4aGxwZDBreTMxL3J6anlScVZFZHpZVmh1UFVCd0RhSkV3?=
 =?utf-8?B?ZlVpOFAzckUxcCtBcklZRUFaMVN4dFpmZk5XVmpYOUgyTyt2eWRTdFZ2am1W?=
 =?utf-8?B?QWJHQU5qMDM5MkVzZVdHUmsxNExCNkdnMHlRS3BTSnNiNy9EZ3VESlZXbVJw?=
 =?utf-8?B?bzZjdW1mTFIzK3B1aC9qcndKSGRORlhhN3lIbHFKaEE4STJrbm5jZXllK3FW?=
 =?utf-8?B?V0RGVGRoR3BCcndyWWg1K1FvdzRXWE4xQUtWVFBkYjAvcS96ZGVheTRZYkVW?=
 =?utf-8?B?ZEtOUTBOcFlWRXRzcDJxSWVFZzlYSEc4K05HQUhCc2lYQkdQbS84NCtWQS9B?=
 =?utf-8?B?b1VOVmJTY2grZDV1ajZLRWxWSnNQYUhzbCs3eVptREsxc0ZSRXRPUnJ0VkR1?=
 =?utf-8?B?ZjJRckZaWk5Od3RGdVVLZkpLYkZxZnNqaDI3MFJINTcyVWZhQ2drRGJEa0F0?=
 =?utf-8?B?aHhkckdMMkRCNHFDSjdlMlBTT0NpVmYzeU5ISlRVdGdYTVIyWCtWV09kZGRX?=
 =?utf-8?B?aTZTWTBOSWxRaVhJTG5iVXFiTlZuZFV2MTd0WmN4Njc3WHZLSWhERW55U0JE?=
 =?utf-8?B?OWlqWENVQisxZzhqWXdBN3QrdTRmRGZTS2dUaUdpTkpsU2s2aFRXQTVRQ0Zp?=
 =?utf-8?B?NDA2VmtmcVFtbEI4RkZKVW5QbUJsbmxmdFJiMmxtRUdKVjFXS1d6dDhQVSs3?=
 =?utf-8?B?M0c3cXdUblJxaEJsMjlFc2QxclJyaUdiOVE2akJtcHNzWXVWVE1vbEdGV0th?=
 =?utf-8?B?VUZxa2FLa2JIcDQrUGQxUXVaUkxURTZCdmhBN0RTdEQwSWFHenlGdz09?=
X-Exchange-RoutingPolicyChecked: a6zCFThj81O+Kw9Hb8LWm8YvJ1xSLI7JMgOt7nKmvlboMYFWwvoUn8w5oLZqhm5cfCsz+cWgA3GP47ksXKg1wEgMSHc6hxV/ahdTe3UpgPUZRFIN/JoHpapoDsSe/e5HliVHmom9C8CtXcD3Xnce+EUqSZl/Uee4mvDBfefJkvn0np3tDvhQT5qRCNFOwpdEtehcFgxpkGev++iNA3df4zHYjaFdcKycHxDZSldUfF24y+KZ4xn5TBKVFy6Qp8XZ/6Uv7xRFq5bVbZsR5gx0qwosj9lmeDyUrdjpqqXJpZ/6nW9QUQpFQWZUUvFbeESIEVQiKsIO7EBOH2mv3wB5/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9357732-83f5-499a-3291-08ded7563332
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:50:36.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0aA7cWC1ExwnFvDk7LhYaDIUwHPt+SnlCXi/4M89jR2bQzR7UUnXNO9jYi2YDiHE2zYvDs/GJK69hOqqdin0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303563-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 001546EBC4B


On 23-06-2026 15:39, Raag Jadav wrote:
> Now that we have a helper to create sysctrl command, reuse it for
> threshold crossed events.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>


Looks good to me

Reviewed-by: Riana Tauro <riana.tauro@intel.com>


> ---
>   drivers/gpu/drm/xe/xe_sysctrl_event.c | 28 ++++++++-------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event.c b/drivers/gpu/drm/xe/xe_sysctrl_event.c
> index b4d17329af6c..0547b7b39726 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_event.c
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_event.c
> @@ -49,18 +49,6 @@ static void get_pending_event(struct xe_sysctrl *sc, struct xe_sysctrl_mailbox_c
>   	} while (response->count);
>   }
>   
> -static void event_request_prepare(struct xe_device *xe, struct xe_sysctrl_app_msg_hdr *header,
> -				  struct xe_sysctrl_event_request *request)
> -{
> -	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> -
> -	header->data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
> -		       REG_FIELD_PREP(APP_HDR_COMMAND_MASK, XE_SYSCTRL_CMD_GET_PENDING_EVENT);
> -
> -	request->vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
> -	request->fn = PCI_FUNC(pdev->devfn);
> -}
> -
>   /**
>    * xe_sysctrl_event() - Handler for System Controller events
>    * @sc: System Controller instance
> @@ -72,16 +60,16 @@ void xe_sysctrl_event(struct xe_sysctrl *sc)
>   	struct xe_sysctrl_mailbox_command command = {};
>   	struct xe_sysctrl_event_response response = {};
>   	struct xe_sysctrl_event_request request = {};
> -	struct xe_sysctrl_app_msg_hdr header = {};
> +	struct xe_device *xe = sc_to_xe(sc);
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>   
> -	xe_device_assert_mem_access(sc_to_xe(sc));
> -	event_request_prepare(sc_to_xe(sc), &header, &request);
> +	xe_device_assert_mem_access(xe);
>   
> -	command.header = header;
> -	command.data_in = &request;
> -	command.data_in_len = sizeof(request);
> -	command.data_out = &response;
> -	command.data_out_len = sizeof(response);
> +	request.vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
> +	request.fn = PCI_FUNC(pdev->devfn);
> +
> +	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_PENDING_EVENT,
> +				  &request, sizeof(request), &response, sizeof(response));
>   
>   	guard(mutex)(&sc->event_lock);
>   	get_pending_event(sc, &command);

