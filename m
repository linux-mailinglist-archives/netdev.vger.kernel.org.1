Return-Path: <netdev+bounces-232301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A516DC03F97
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88C7F4E6405
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863713B5AE;
	Fri, 24 Oct 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zep4JvyA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410D78F4B;
	Fri, 24 Oct 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266900; cv=fail; b=M23UK9PwdGYlKycwqqDySDwb0aff8FGKCs+ivr3GhjeOkV5NW4RY4BAJhy9ZV0L7GYOonKeCOTl8/z97YWSA0B8ZzpnyAjdV/DsuAckirZ9ZyW6oLONO+khG6kMrZlUq/vVYl+cxu3GRtOsBkHmnVWcCnbEGtputwDB0+BdXD58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266900; c=relaxed/simple;
	bh=znroSSh+eRNTaSxKN6vf/EjdEMwFdCDztwBi8+S8DDA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQhJHXy2PNAFCu/hkd78+cf40Hz/KBQLIvJEpNaaQr5MEcpYtwPhS9UKa//uipPC8S7Fn/BRlviwutk6o3c1BlY9eFtMOkY75/EXNcIj0Vxq2o/QaVBFYZI39Oq78cvCI2VIlHG5Y1ADIQ43YL8es2XZt/CeB9xWsWi4NNCS9RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zep4JvyA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761266899; x=1792802899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=znroSSh+eRNTaSxKN6vf/EjdEMwFdCDztwBi8+S8DDA=;
  b=Zep4JvyAdGUjqMpTYdMDwc/9aZ6/EaROQbea8V2KovH9Z2oVObvD0Nqv
   FNhUzuhX3mmy3qcLTTPxV9NCA5UeP9wattIqgdD2/L9mWhGwK5Ooy595k
   gtugIblaH2dy2EqaUAiY2Jga++FXGLVrlovul6EsgZ781FSbRSiShHgK+
   avzK45HuQtAvv84LOQDB8zyITTos7VJaGeF10nJF6Eo8dgRgE08iVYiR0
   WJucuyAmH9g7v4nqwJuDSZObC8b1wJVtf6R/XztTPYpztxgRhkoqzL11+
   5m+xZoClldgOLijhfjlrtAdP3LoDc1hBkvZRwOXtQ93l90aYLkk5K5Z7D
   Q==;
X-CSE-ConnectionGUID: clQZzo+2Tneg+1O4R9HJYA==
X-CSE-MsgGUID: RwPNx/HOQHeiYnotOM/bZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63339887"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="63339887"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 17:48:19 -0700
X-CSE-ConnectionGUID: QWNj7BjjSYmWxPncObAIEg==
X-CSE-MsgGUID: EVQELq4PQ7ym0aehhE51bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="184195666"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 17:48:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 17:48:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 17:48:17 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 17:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toPfhYO53aSdpEBFw6MF5hBHcP0qxmeMjka8Ly5l2KD5XmpdKtfQVw2f6Fitc5CTewdTHWzFz9oVOzlGpCHP9aBxYUMsQsTa4hPQl7rfX8C0RxVhppY4bGx4OP2/qxK9qp9FChpe0wC31wNOBkw96BQpac5CNnsEkCo3HFEWJ0JjDfrkn0JV/pQk6jL4TNvdsfJf1UEHSK7q4YutlluQJL3rWZ0e14xsLwngrmL7+aIOzTCYlL/b90du3k7JKUHReK3pi8hlTC/LxvrBojvAghbmMndyq+qEPuKI5bCy7ft7ZjgnFZV1JEWuC/7Et4IUrKZjatm7B5FocW/DQP0nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znroSSh+eRNTaSxKN6vf/EjdEMwFdCDztwBi8+S8DDA=;
 b=QYSkCdxmlMpOBRYwOx+FmA8A5sVkCPJjkLO5h51OWz6TgYeWwyKFmVjjvj8thhoeQldQGUuSUGs5B3ii6trZ5yC6eESlH9cu0zbPvQudSHwrlyD1Uynv6LA74AMhxOsuDPw/Xx6aYdrxvf6ie+SYLGTA2wmeDVBf6Y+9Z0G1JDoMPcjUqKdRdkYcb3q2JEJ4A/ex4LHOjRS3YK51N0ZeijYR9ip7DimVjHbnJU/QZJiqCCqytbTj+71j6ZDK50A6ktpXz6A9UZHbYQGcUrA64pdvO0IZ/szXrt9NSY9IE2ruQqyGbKeimPGLFMlDH+ckysRvVaSiqna94iIhSCGs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 00:48:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 00:48:15 +0000
Message-ID: <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Date: Thu, 23 Oct 2025 17:48:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, <ecree.xilinx@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <habetsm.xilinx@gmail.com>,
	<alejandro.lucero-palau@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ghVrz3AfJQt02myGm48xRcG0"
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: e567ed29-e5d8-49cf-70d3-08de129703c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWpKU2RFVDVJSC9CV09WRVNoTStvVVdBamxXU0xxemlrbng1c3BoT0MzMmFZ?=
 =?utf-8?B?VkhjVGMxcTlJek5Dd0U5QkdMVWcvY3MxV2lJRHRjTGxzVFhWa1N6NktQMHRk?=
 =?utf-8?B?QUdOdnhvaGpIcFdsZzI3dHFIaVYxQi9vVnR0OWs2SzVoS3VzQ0pQbi9SdXZC?=
 =?utf-8?B?SGY4NEU2QVNVOXpYWXNhNGZwQmxzN2hBSytjUUJUOWxlSmthNGc4cGJPa2Q3?=
 =?utf-8?B?OGxqVkhOaU1YZm1JanllckVWc1Nib0dIdXAyWFRGdG5weUxVM0s3N1BuTUpF?=
 =?utf-8?B?TW9NQ0VFS1hyc0M4VnNDSnRpWkN3eWwxWTA0a2JlRHN2MCs3OWdxaXdDVyth?=
 =?utf-8?B?SCt0SXZGTElZR29HS2JGYnJXOWpHQ0VuMzRocDJpenBhSC9Rb1UrQnEzbnRS?=
 =?utf-8?B?amVVZWFDR3M4anA1Si8rNHpJSGpuZC9YMDJlcFBnVEJVT1FFV1VvalVjUXg0?=
 =?utf-8?B?dEd6VTZxd3p3NDAraWRRQkovZ2xZckNYZkhrWVphZFh2NlUxWFM4dUpQV3Nn?=
 =?utf-8?B?OVRmTDdrV1AzYm1RWlVSU0lUUVBYc0xhSWdTRllTY29xY2hTdDIwU0pnMnhw?=
 =?utf-8?B?dGJtOUVRemU4ZzAzSWt5SGEzcnNuZTU2WTBKSlQyTWowbS9kZ2oxTTRTakdy?=
 =?utf-8?B?TmI0K2tvWktBTmJaQU14UGUyWnVBSTFDcm9OV2VXVG92TEQyTHZTdVBwai9l?=
 =?utf-8?B?eDMrNS8xVFZzZ3E5SVdiUUhoVHBLYU9KZVVFWWlBa0hwMmNveXc5OElaZ3dH?=
 =?utf-8?B?NTBRS1J6WS9WSXBSVEFnekVwRWlsZjQwMjVtNWdWNFAwdldsMmRQelNiNVMv?=
 =?utf-8?B?T09GRDhLVGJibk9hYVp3OWJHZHRpVmhiV2s1L3ZZMUVBM0JROEVudE9lMTA4?=
 =?utf-8?B?WXFUdVN4UXNOQVJoczJueWZJNHFYdlc3UGhabW5WQkNEZHhnbjE2QVlPd1Bl?=
 =?utf-8?B?dHhnd3JwZytiS3BkQkRHT1BabEttRVM1Q1ErN3ZZS0dPc1l6eHpDSTdGb0JR?=
 =?utf-8?B?MlMvNEZCWi9hVmQrdGpsUTl1T3pTODE1eEVHQVNONlJJeCtQT3lnN0Radmxp?=
 =?utf-8?B?Y3hoNUN3eFBjT0xBZ0ZTNWZLNU1GUm56Q2pNN2R1bThqbklWejhEVnQvTkto?=
 =?utf-8?B?QlRWMjQ1czNVSVRUdzJ2am9vanVCUFBhcFk4cnpPZkVjNkY0QmN5RTBFM3dP?=
 =?utf-8?B?WnFQVTJMNFdNbWhtSjhIaEVLNU90L09yYVpUTU5zejV2bkpyZ1VZUWRXamox?=
 =?utf-8?B?VW1mQ3ZPWDBNUHhNcC9UUlRwQTYrS2V0WGdUeUtIWVBQVnozTm8xdVNEVk9K?=
 =?utf-8?B?Ym04S0s2UFZxQllxSUlkekNERUxVbHBudnBocU45WXN0bzNVZC9MbkVxTElq?=
 =?utf-8?B?N1J2eUNjMnJFM2JnMU84eW1oT3BXaVN4WWIwdndsY2NvdG1RKzlCaTRObTNy?=
 =?utf-8?B?NXpaODVmSGpBZTFhUFVxdHVxRUp6dml0VzhSa3ZXeTJQRjVranQ0TWRnTDBq?=
 =?utf-8?B?R2NTN0Q1R3JTdmR3M3o4b1VFcFlWMnZsKzgxQUN6NmJ3WkJxelIydVM5bDdT?=
 =?utf-8?B?dE02NnhDakt6Vm5zSHJTNnJueGVEb3JJdmxxZ254enNsM1llM0l4K0JzWDF0?=
 =?utf-8?B?YW1BRXpjVng2bDI2VUJ2Wm5vTGFRRHdoWUp6VXI4dHN2eFlmbFNJSlFYaytr?=
 =?utf-8?B?TW5TdUFPTGR4K1pkMTF2bUU4b0NSbVdkMW1wRjdpR2Q1NnF2WjBnblpMU3pa?=
 =?utf-8?B?NHFYTUNwUzdJdm1wWVJmZ05Zb3RwTGVNN3A4YnAwZmZ5QUlaaFlrcEplQTRp?=
 =?utf-8?B?amhsaW9JN3dLUFJNeVJpY2VhcXovSktzdG1sUmtwc3UwYXZmeWpSci9qVnk5?=
 =?utf-8?B?dDVuTUk5eUxVampJY0NueVg4RXVRakF2cmNTRFh6Qnk5VitNUW1sWHF1TWpx?=
 =?utf-8?Q?Ranfwncqs4izhGqunm5riNEEDaioEkjy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFDSDRwRzRFeDgrL0NEeWg4cWc3d3FLbjgwRGtDZE9pWVg3WlNUZ0xGTTEr?=
 =?utf-8?B?cXJiTjRYZi9GMzZUbDZyMVhhV0R4K1M2SlNSZ3gwMFk4UkpDSUhIRm1wNTh4?=
 =?utf-8?B?bXJCKzBOclNKMzgrRTdFMEFTTFBmbEJKWjJZYXBMZXBtTDNKM1RoVCtMQUZF?=
 =?utf-8?B?WHFQeVVHMTlIZGswbWFUM05Fd0ZWRTFTZTVGYzdnODVaWkNFZWtXQndrVmdw?=
 =?utf-8?B?MmNxa2FYWUpmUHZrOVZmK3BKMm5Uc04xWEpiOHJDanRYbTlzdUhuZ0ZJVjUy?=
 =?utf-8?B?Tm8yY1RqemtZbWV6UUQvWGlSRzJLWDFhYWs0c3RLNW9aN1lDN1lJdXpLM3Ju?=
 =?utf-8?B?NU1Sblo1dXJjVGxPOEo0WGpRQ1JLekpKZmRxUVFtT05YTW1OTER6Q1ZXTHRP?=
 =?utf-8?B?cHR0SUJuY0d3dnNJYjd0RllsOGk5TkF2TVpOTFNSaC9GbnZNZmlFUFBwdXRE?=
 =?utf-8?B?UloxTXY4QTFCOEdpWW90SklDSTdHclBKZ3NVbzFndWh3dlg3d2ZlODRkODBX?=
 =?utf-8?B?ZjJkYWRlNXNlNVg4Nys0YVFPODJDNnVyNEV1NDlTczVIWkdMNmZWVmxkL21B?=
 =?utf-8?B?VVhJUTdBRC9nbXk0L0NrQXBOZHloWWpCdXI0blJ1VWN4aldkSlVpZFFnSmNC?=
 =?utf-8?B?UmRZazREWmhRUnUxdURtZFF0Q0FKSUJ1TGtTUENQWUVrajViUUttYldZVElU?=
 =?utf-8?B?OVR1dENJT1IyU0NGRXVReUpCc2pSblpkY3V5Uld0NU40R3VEb256MksyRVc2?=
 =?utf-8?B?ckMzUHdKNXRsUmgwZjZSUFcwY2I0cWpERXJNa2kvUUdmNnBjbHJjZm5XZjdR?=
 =?utf-8?B?T3FxVWtFZU1tMEF3TkJjUVo3dWQxN3R4Q3Bqb0xxMWFXNlhIbWdpMUdYR1RX?=
 =?utf-8?B?aHpoZDdhb21HN3l3ZzZlMVVkVGhMOWVPQURzbnFRQ25Ya2wrNXYzcnNOKyt5?=
 =?utf-8?B?TFpUak1UZ01nTHdqM0dzVjNDdlAyVlViRDNaS0VYanpqQ3hKZGlnR0k0Q0cv?=
 =?utf-8?B?WTBiMGRDVWpOSFl3ZnZSSXF0ZlRMbTBzazg0VGVyS01STFJBK3ZsTWpKMHo4?=
 =?utf-8?B?WitwUEZMQU9HeXJESWRRRGNIUmJFSEtUMXcvUW5xc2trSkQzQk82RnJYMWEy?=
 =?utf-8?B?amxlTFJQclh2aXRnWElFZldqYTg5K1ZNN3FEVGthUzFidTFxWlpPRUR0cHg0?=
 =?utf-8?B?aGxWdnRUSkVCaG0xOCtMMVdTT1J4WjRGNWRsNVdDTk1aak14Rm5CZ251TmNn?=
 =?utf-8?B?dnhoRURVcHRKZVpDdmp0ZmJOTHFPQks3cTB0QkZHT0tCZWErdWxJRTBvdDgw?=
 =?utf-8?B?Mk1icUQ2MjVMdVArQTk0dXNuY0cvcm83R29HYmpMTXZtb09RZ3g5STV3dkJT?=
 =?utf-8?B?ckJwWGpreHJSZzdQRUZ2S2pNREIwMmNUMjZlYUJUTFI0UHhkUEpSNWFYRi9m?=
 =?utf-8?B?K2E4YXl1UG1QSkdKTVlxV2U0QS9aeEJiTVlNaSs1eHA2TGErdEJVLys3Q1gx?=
 =?utf-8?B?eUNlTnVwUU1rU3V5VG5FNFVzdVFxRGw4OEkydzdIUVd0UmpHazJGdWJ1Z1Vt?=
 =?utf-8?B?VVREeTV0ZExhYUVWZE5Fb1RwQjFERkd2N2l5MzVVdUlMQW5zeld4enkxZXVv?=
 =?utf-8?B?YWV4bkRtZE92bjZxaFdRaGdUdllYaE5IWUpPVU82Uk5ieDZyc3hDS3gxdmxN?=
 =?utf-8?B?S09JL2s5YzRiMXBxTitnNVdSRlNyUkczdU1ZYVY1SGVGVHNEczRQK3BOa3Uy?=
 =?utf-8?B?dW4xcmoyNGt6RDJpNFh6WUtYSmNXWWFxMVdDVU9hRmM4aUo2ZFVVZnFWNmp4?=
 =?utf-8?B?QTY3UXJEYVQwekVCNEhHeW1RcGdjYXRoMVFEUExMakxRajYyYkhvOVZvTmxs?=
 =?utf-8?B?ZVRQcU9XbDYxK0k0QXlpUGZPdi9Vd2dhMXBEem16MzZZdk52ZWxZeXlJOWJS?=
 =?utf-8?B?dmduL2ExK0U2d2x5VWlUZFEwK3FzYVJPU043NDlLSXpDNGdqMXZpS3BjcHAz?=
 =?utf-8?B?WTI3REdkeDRUK05CdytoZkJIWER5WVFhczB6WVpVMnArc2tPMExaUFYvdWF3?=
 =?utf-8?B?Zkk3d3JDUkFJeVBnS2hCdUJIWHBpaVVMM2RydG1UR1V6WjVHbVZweDRvWHBE?=
 =?utf-8?B?djlqQkxsWHpySHBXeHpFeGwxMXlpN1FMYS95cnUzdkJUYVVDU3Z6bm9iTm8w?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e567ed29-e5d8-49cf-70d3-08de129703c9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 00:48:15.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0E3B3akEZ/6poI24U1fSTADrWObmIMnakg58Sc5a+tEWRUQnHvWXUq4Ix+vzOW6TkLVJuOvFWfn6i6CmvKKtnReRJP8T+9Owwx6ifa1CpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com

--------------ghVrz3AfJQt02myGm48xRcG0
Content-Type: multipart/mixed; boundary="------------xFUiovp3lBi7VevJcHkTkSFB";
 protected-headers="v1"
Message-ID: <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Date: Thu, 23 Oct 2025 17:48:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, ecree.xilinx@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, habetsm.xilinx@gmail.com,
 alejandro.lucero-palau@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>

--------------xFUiovp3lBi7VevJcHkTkSFB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/23/2025 7:18 AM, Abdun Nihaal wrote:
> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
> passed as a argument to efx_mae_process_mport(), but when the error pat=
h
> in efx_mae_process_mport() gets executed, the memory allocated for desc=

> gets leaked.
>=20
> Fix that by freeing the memory allocation before returning error.
>=20

Why not make the caller responsible for freeing desc on failure?

--------------xFUiovp3lBi7VevJcHkTkSFB--

--------------ghVrz3AfJQt02myGm48xRcG0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPrMzQUDAAAAAAAKCRBqll0+bw8o6B92
AP0ToTNeySZoA8+rASZvkOKqayX3y6hSrStx/QU4EbA76gEA3cX0D89vk5NEcqb/1skWkCZyrxiW
a2CxPHxKBieTzAw=
=tOh+
-----END PGP SIGNATURE-----

--------------ghVrz3AfJQt02myGm48xRcG0--

