Return-Path: <netdev+bounces-205556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41ACAFF3DB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60D5561C0D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BA23AE84;
	Wed,  9 Jul 2025 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9Uv7UyP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EB239E8D
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096243; cv=fail; b=rwAk9aemDZtB/24nqFTyKTJv2ZuVQTmBO1iBZLsdCfWr6DWtwjAzeR37cq8YwRS+ZqryHf//CaTP8EbRg5UAYnNi9mjwJ4YDLPXz8xkXfvKm3jk8S35XScH0PsaYA+xm/YeioaGgCoaXgiEO1otO0vIoGXS5agWSuME9E+CpQcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096243; c=relaxed/simple;
	bh=re4wFiXJjgidI4W2imW5Y+sE5MhGHn2t15jHTvB5eWo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cRzfsEGTggyCefIZhVH2CV3azce65Eo1B7yFDSAl3Ko1dKHkgGG9mUSwOSr+RDjFu0B4a2Loum0jGJm7egDFZyeLSp0ejYcAYE0isRPVnaH/q/we51jcdxA4rgqc3JLCsy5FmELlOju4Auj7u4OSj654F6gWFz2bxeo1dDmKBPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9Uv7UyP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752096242; x=1783632242;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=re4wFiXJjgidI4W2imW5Y+sE5MhGHn2t15jHTvB5eWo=;
  b=G9Uv7UyPcNG6Smb/utm8GUrEAesm38u2bV/UZKChlX3Kx53WoKs94yXt
   E16CpogrqH02KOW0sUV1Xtt3qPpikI1nsD5i8NjhGo7t1k22uUsjK4I4f
   V7CVjcebglnqnAqccfmlgaDUx6WIHdGVyhEPumw3cQZ4eHr9Z7/Z6ZUpx
   SP6N57Dz7NTaMNkhDv96EsXwkaG9tDu8XsfZhpXaKVUQCdCqf4Ezk0wJW
   yQ5XR8Mh5C3vboB04UXy8OU/bz/P6VLUsiw60aIwaWAq/bECIpEMoOZMp
   TfPuAFuAfd5nPGn8JO0uEuOg0thCbPg648ruEVifTz/RaM6G4DNTIyNEj
   A==;
X-CSE-ConnectionGUID: pnkhsw5FSsmZcl+hoxs3rA==
X-CSE-MsgGUID: 4aRbTklKSsqMaNDsYfTvXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53583895"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="asc'?scan'208";a="53583895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 14:24:01 -0700
X-CSE-ConnectionGUID: NNhrj2wIQDeK4a/151PVGQ==
X-CSE-MsgGUID: tZesR5kZRnK8TejURJaHJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="asc'?scan'208";a="155300696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 14:24:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 14:24:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 14:24:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 14:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xz7UvPHIdb16+8MlBecXxqIU+za2dqQSYCUQBxWv9fEQL63smIQE+x8t2NqDhH8mDGwb07uyOL2YOrM8IBOtFiyQRZ5jo6+8pxicoIynKRaVjCKAIEbAMR78Pg2S/mwH5GaPDiA0iUnUIJQ4e0UOAemMx8r2hOk8QQsCBfeoYWa1OkSpuLp95bvqHFiDjgA06xwPhKN+03T/xgc+IDKmg1qj30vdeqOe4UpbMGXcTva/E24yoeMgg2OFiWXjwDrx3JstFd6BRhCDAMo7SK6J7q7wwe/P5bgDFVTfC/FjrXG2AOAHnZiP96POffaA8yxkoXDypOiTkuTtyZcqT6M74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Kag3Wn6BV+2ZvlpLDqfxQG611686BR1Wnodi2lPTk=;
 b=XNfgL8H2cjv9GGEoGi7g8tGz2wJ4Sxe35fKAMlQEhQMZ7qywNquztVeAWtNILNv6gtsjEZGAHuRh6aeq7a+O31ukWUF8NXkZpvIfIAFjLCJM5HdhIFW+LOcxkvUjUnqCcLFcsHjzlcPQbAHEbWyeDOkfLFDKF4CJrYOSwImpAvC61w4gCKd/1/gLHn2hUCq/TgGCuAueU6mrIa/AQgeN/Cq7b+zAH1R1EfkN3arEnGHpEMAHr/XYqUj1Qv04cBcHvhIMhl5PzWYYty/4HHBvSCqYpWPLJvG1ez2Rq52mH2lI2bw6ozFx0oHj6CwM/2WGKMfJCPdd/1rbvB7/+V0Mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 9 Jul
 2025 21:23:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 21:23:12 +0000
Message-ID: <bfb5122f-e603-457c-8115-4c4acfe7360b@intel.com>
Date: Wed, 9 Jul 2025 14:23:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB
 accesses
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, <lee@trager.us>
References: <20250709205910.3107691-1-kuba@kernel.org>
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
In-Reply-To: <20250709205910.3107691-1-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------wbzxrjTXG24vxFyfV0OpKuRt"
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 700a1be4-a17d-4f43-15ce-08ddbf2ecf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHZBWFdXbFQrbmE4UVVHckRPZzBhRXg4d2ZqdGFnSXhPSlJneGg3cWQ0dDlS?=
 =?utf-8?B?WDFOQTdNYng4WDg0NDZ4WkN1WmFnS1FBL1dQaFNWbVFTcUo4aHhUU0RhVnkv?=
 =?utf-8?B?VWYvZk5MUkxqYzl4bnFnZ3ZzMkRkVUNiV2xDejV5cDRLMTduc3RXV0FxWDZ1?=
 =?utf-8?B?cWd1UG9HQmJNbkZCcWdRR1VzbmU2UzNhYjdtOWcyK1RFWUtPV2Y5cEZNZWdP?=
 =?utf-8?B?SVA3eWJTZ2loZkp6SnN3TzAzRzBMM3BQUVBxWUZQMHBpVG16RG9QTmRPQjVv?=
 =?utf-8?B?Sk9GVFdIMlYvMGZhckN3SnphTkJaSUpLa1FBdDhWL0hweGgyWSt2YmY1U1hY?=
 =?utf-8?B?YkdPeFhBVzRuT2MraTVwZ1A5cktYWlQvTEhRRCtDV1RpdzViU29WMXVlM3VU?=
 =?utf-8?B?RExtN05HQWtDQ0lVNjJoVm5VSXIrVG95c1ppNUo0Y1hTZkhCclJkUU5FellO?=
 =?utf-8?B?R3F3TDdrZFdGbTdabTdoRzVFcmdPQ2FiTVF0WWZtMHdsRFhHOHdJbnFoc1ZY?=
 =?utf-8?B?RFpyb04rU2dYcWlaSkNCT3dtTnZPdFlNdlRRdCtqeTIvUTNDRkZYTUQzMUFT?=
 =?utf-8?B?UmxvZWcvS00rSTQxRkdTbjBhVWY4QlFyY1BaTnhUalFhc2p0SDRHVWRhRmpY?=
 =?utf-8?B?UklQQjhnajFQdFl5MFFQZ0QwOUlBUG5ySzhNeHdVbzg2Tjl3R0xlR3hlNFBP?=
 =?utf-8?B?OXhPQ3B1bUFXM3NQYlI3V3FDU3dBZ05pZmxYUXlSQTBSTUdJUWVFL0FrOU9l?=
 =?utf-8?B?bGRXdDZkRXpxbE9Bdm4wMVNleXRuNWYzQVZSQmZMejJnU0hLWW1WdHpOWHJn?=
 =?utf-8?B?Rkhpc2V0OGhnR3F1WGFuc1huRm9OUlQybjhVUDR5VldNMWd0eDNFVXdWdTlL?=
 =?utf-8?B?VlBYTmI4TW1EN0xMMHY4aXJJSHErbUp4SFNwYlMxZHBSS1JMdnkzS0ZJMFNB?=
 =?utf-8?B?NXdMSFMrblRVQ1AwNHVqT3UxOFJQaUdnODVTdFRDcXVTMTdpcVlNVWtkZTNh?=
 =?utf-8?B?bC80Q0RudDdidmlsaWpRVlNxamczSnFLU3lVZkRHUjlqZTVKY2FUeStTRVNT?=
 =?utf-8?B?RjYyRmVJazF3Z25LVU1xcWthSVpjd0V2dFVCbjFGYVBBQ2crVWRaWWwvcktj?=
 =?utf-8?B?VXVOTGUrdHc2NHRnd1VBZ0NhK25aQzFVaEptM05RcG8rejRkVy9WWjdDbVFJ?=
 =?utf-8?B?eWcrRU9scGVncHFUOVo3R0RSR3FiMHVYWXlZNHZ2WU5OZjVhaW1uVVYxTGZM?=
 =?utf-8?B?eE0rZWliQ2FvTHFnTDNuS2xITW5UUWgrbHNhMlkzSEJ4UnhjT25ZbElpeEpj?=
 =?utf-8?B?K0ZXTEMzU3dHb1Vaa3lmaGR1TXRZWVppODJHVjFKaW1LRHUzR2d3NWRKTGNh?=
 =?utf-8?B?bjFmbFdkRmx0NXpYM1BKRGxSYVBNWE43U1lSMkZWUTVMNE5MWFRscW9peGpZ?=
 =?utf-8?B?YW96WFlHR0ZUYzBxOWd5UDlWTFlSM0dpa1d3S1BxeVk3UjFTaXBEazF3SzhU?=
 =?utf-8?B?c0gyZWM3VENxakZ4RzVqMGpmWm5DRWVodFdOem4wWHJ0M1RkZkhTemdTalJ0?=
 =?utf-8?B?Uis4U1h4YjFLVzdsdzBMZUIwV2JkWTdzNCtVMU0wNmVVejdVRHpIWFhXamRO?=
 =?utf-8?B?S3Znbk5IaFltZGNmRStaTXhoWEo1bE54OCsxckllU0VNYTBpQi9mSnZ6Sk5v?=
 =?utf-8?B?NGllVlR4ODY0RjBST0xLdVpibmYwbTErQmZpSFRFWUJrd0NRZ0I2ZzBabmVk?=
 =?utf-8?B?UmREekpnWXJYdnU1SUVyZXJhaWtJcDYzdjVYYXVyTnhvVDdURjV0S2VjM0ZV?=
 =?utf-8?B?dUdCbmthUDBkb3I0Wlh3bW5ZSm1kL2cyM0ttNkFSZjBuUTd4bnhzRkpLMjRE?=
 =?utf-8?B?Q1lRend6aEljQU95dld1YVFQcC9EQWdXd2pSRmh3V2VaRlVWblZ4WVVtZk5L?=
 =?utf-8?Q?8EhW8DtV2DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmxKZHcwQUZCaWRLSHQrR21zZHBJVU1QYThXUmZSSXBUeUZxNjhMNmdzWUI1?=
 =?utf-8?B?OXZsQmFocDA3eXF1UzhJaGRUYjNlelpzTWNhelNIRGx4WDdGVktsSG5DQjll?=
 =?utf-8?B?eGRVYU41Rmg0K0pYTVB0M0V3cTF4MnRQeEM0NzlrUUtNbGxCMzR1MWx2Qk5p?=
 =?utf-8?B?VG1UYksrRzJqcG93aHhmUC9pR1hKYThjSGVIQmprbXRZZE9HVWpvOFhkV0dO?=
 =?utf-8?B?dXRFRFNRQlptb0FiWjhLV1ZLc2NwWXgya3NCc0JYbjh5ZFhwNkNmUTdhZDhP?=
 =?utf-8?B?a1NCTXBjd2tpWmUva1VYNHBtT0ZGWlIxYi91QXQ0N2dJak94WVR3SFJFMWpn?=
 =?utf-8?B?WkErQ2thdDR4a2gwUmtxYS9OUjE3aXFvTElRc1llQjhmZVRFNy9paWVZWnBV?=
 =?utf-8?B?QXJJejU4aWlGbFRNWHJwMC8remRiOWw5TGZTRnNhZ2tUc1ArY1U1WEFLeTNs?=
 =?utf-8?B?RWl0ZkdSMmpqNFZYWUtUT01yejVhYjV0TE5aWjJlTGJtUHZNQS9tTndhcE1y?=
 =?utf-8?B?ZkpXQTZtSVlseFE1cXdINlJVUnk1c1UxdVFGaW5PUktxcEVqdTIwOTMreDFG?=
 =?utf-8?B?RGdLM2tHckR5UUE0V3J4dGpTcjJMSzlGemZTOGkySWd5V1ZuQTJzVjM2V3Bj?=
 =?utf-8?B?Sk5ZUUFvZWIxV01VY1JYL2MycnlkVUluaGNjcXg5RDN2cmlvRlMxZVQ3MzdF?=
 =?utf-8?B?SlRCOVhMMFBFa0FLeDJCWkVTbnFqOWxYUVV0Q3V2NFZsSHFOZlhpVXIwbm5t?=
 =?utf-8?B?ZS9VcTNYaDZPQVNFNWcyOGpmNFBaa0JFUmYrc3VlaUZhd2J0Z3pYMHBRdGZn?=
 =?utf-8?B?UnpacytKTWc4dDVmZzV6L0ZmbTl5WUE5OWFUTEZmOE0yWkR6aDZ5eXcrcldt?=
 =?utf-8?B?VG1yOHpLYlVqY2ZXY3R6d2E1Umlkc2svQmthSGRaRkdyM2paWHgwcHNvZzJ4?=
 =?utf-8?B?VWMwa284OWtlUGp2RnlzRjhhNGdUWWk3L08yNlpPZSszQ0M3Q2l1MnhpWndN?=
 =?utf-8?B?RGsyYXdJOFJ4dGhhMGxSQ0w0Z3Zqb21tZnZnckdDcDkxOXR1eHdJT0hYcVh5?=
 =?utf-8?B?blMySjJFSHpRQldzNDlGaVM0RVYzd09mb3c3U1hiamtDMDRkNG1uWU5nalQ0?=
 =?utf-8?B?eFExeVZCZmkwbmFody9uQ3lwaTBVNjdHY1JSR0twSDV1Um80YnhvOVE2YU1a?=
 =?utf-8?B?YTQ2SElRQ1NBeFBibGxmbXFYa3FnTWdEM3Jsd1hpaER4a1Q4cnc2Smdnd1hV?=
 =?utf-8?B?SnZHdzVuRlZMcG5PeGpLNFFBbSs4bnQwNjlEL3MzeU5xTTdUY2NSR2tpWG9O?=
 =?utf-8?B?MjFXTUwyVmV6UXhpSTB4UFNYbEV1c3lXR25uMGZYRTV1aVl3ZFVGNzhXMSt6?=
 =?utf-8?B?a0ZVWVR1TFhvQ29FMGlQQ3NubC9IWHVQOHBIUHZUY3hoNHg3S0tvMWNIWWt3?=
 =?utf-8?B?WU9QZDY4QTdzdER4R3B1VFA1T2NLcGJCNjB2SUFFazJTRUdiWGtSbG5Nemcr?=
 =?utf-8?B?VUUzbFd5dGU4NzdTNUtXVUFvbGoyM2pxamJwajVOcVlIaUc4UHV5UmdTN1F1?=
 =?utf-8?B?TS9peTRrd1VaTlVKRHdsSFJ2Yis4Unk3VFZMMXhKZ2taQ3REU0ZxQWw1dmhB?=
 =?utf-8?B?QTBYcFp3M1dPMWxkajVOejJ3L095MkVLOXNRakdETjEySXNGZXNnV2NMRDFx?=
 =?utf-8?B?dy91Vk9HR0c3dW53emF2TFl2QTFiUkZ3UTNGUThVR2phUzM2dVpvNXQzUmRB?=
 =?utf-8?B?USt6OWwyanhmT0E1NjZjeUFQMFB6R1psNGd4Wm1CVFo0RDd2UHZUVmJ1SU5R?=
 =?utf-8?B?MmltVHRnSEUvL3QwMFVRc2graEFuV0xXaG1aWUJ3dHY2bG5laE9CdmR3TVFV?=
 =?utf-8?B?bTdWalpRcjZPTk11QnUwdnhYeTBka3R0Y2RLMU90UDlKbW93bm10U0VWSjhO?=
 =?utf-8?B?Q0xuTy9sTVptTzFHRGNvaVJsL3h1RWU2UER6cnM0WVdmL2JNUTNFdGZZdEM0?=
 =?utf-8?B?NjJzRHhKTGxrdFh3aGZnaEtKU0QzVENpYU10UCtxT01KNXYyOERkWWJWZ2xC?=
 =?utf-8?B?b1lJN1JuWmJKc2FFcUxQMWVJano2MlhXUXJCMlpZY0hvS1VzWXVPZkJTdUpw?=
 =?utf-8?B?NHJjZzdob0JnOVY4ZzN1ZWl3aHdOdFJrTExKWjg4VDQvOE5QeHI5eU9yNFJJ?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a1be4-a17d-4f43-15ce-08ddbf2ecf62
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 21:23:12.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHvZjmq0qL6ea2K6wlEAYAhPm8kFiW3HS1QFc2SsJKYlLv1gxtyJMUTTgUC+/yguY+h/UGSwG/7wtQbnAq9v+h+LqVc5sU3fntTgaI8FBZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com

--------------wbzxrjTXG24vxFyfV0OpKuRt
Content-Type: multipart/mixed; boundary="------------mw688oQn0UN0Trjd0Zck1xBl";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, lee@trager.us
Message-ID: <bfb5122f-e603-457c-8115-4c4acfe7360b@intel.com>
Subject: Re: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB
 accesses
References: <20250709205910.3107691-1-kuba@kernel.org>
In-Reply-To: <20250709205910.3107691-1-kuba@kernel.org>

--------------mw688oQn0UN0Trjd0Zck1xBl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/9/2025 1:59 PM, Jakub Kicinski wrote:
> UBSAN complains that we reach beyond the end of the log entry:
>=20
>    UBSAN: array-index-out-of-bounds in drivers/net/ethernet/meta/fbnic/=
fbnic_fw_log.c:94:50
>    index 71 is out of range for type 'char [*]'
>    Call Trace:
>     <TASK>
>     ubsan_epilogue+0x5/0x2b
>     fbnic_fw_log_write+0x120/0x960
>     fbnic_fw_parse_logs+0x161/0x210
>=20
> We're just taking the address of the character after the array,
> so this really seems like something that should be legal.
> But whatever, easy enough to silence by doing direct pointer math.
>=20

My guess is because you're pointing the next entry at a pointer
generated from the address of a flexible array marked with __counted_by.
UBSAN assumes the array value ends at the end of the flexible array.. it
has no context that this is really a larger buffer.

> Fixes: c2b93d6beca8 ("eth: fbnic: Create ring buffer for firmware logs"=
)
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: alexanderduyck@fb.com
> CC: jacob.e.keller@intel.com
> CC: lee@trager.us
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/n=
et/ethernet/meta/fbnic/fbnic_fw_log.c
> index 38749d47cee6..c1663f042245 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
> @@ -91,16 +91,16 @@ int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 i=
ndex, u32 timestamp,
>  		entry =3D log->data_start;
>  	} else {
>  		head =3D list_first_entry(&log->entries, typeof(*head), list);
> -		entry =3D (struct fbnic_fw_log_entry *)&head->msg[head->len + 1];=20

I am guessing that UBSAN gets info about the hint for the length of the
msg, via the counted_by annotation in the structure? Then it realizes
that this is too large. Strictly taking address of a value doesn't
actually directly access the memory... However, you then later access
the value via the entry variable.. Perhaps UBSAN is complaining about tha=
t?

> -		entry =3D PTR_ALIGN(entry, 8);
> +		entry_end =3D head->msg + head->len + 1;
> +		entry =3D PTR_ALIGN(entry_end, 8);
>  	}

Regardless, this replacement looks correct. And if it makes the UBSAN
happy, thats good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> =20
> -	entry_end =3D &entry->msg[msg_len + 1];
> +	entry_end =3D entry->msg + msg_len + 1;
> =20
>  	/* We've reached the end of the buffer, wrap around */
>  	if (entry_end > log->data_end) {
>  		entry =3D log->data_start;
> -		entry_end =3D &entry->msg[msg_len + 1];
> +		entry_end =3D entry->msg + msg_len + 1;
>  	}
> =20
>  	/* Make room for entry by removing from tail. */



--------------mw688oQn0UN0Trjd0Zck1xBl--

--------------wbzxrjTXG24vxFyfV0OpKuRt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG7dvwUDAAAAAAAKCRBqll0+bw8o6MaZ
AQDvr18EH4q6tcVWhZncw2fV5dYHbwhRwU/2KRCz7BcYAgEAssP2uVBAufSDnLIpI0gJRanZ4c7C
p/gxHal3ZiDVXQY=
=TogH
-----END PGP SIGNATURE-----

--------------wbzxrjTXG24vxFyfV0OpKuRt--

