Return-Path: <netdev+bounces-219687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532AB42A68
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A673B2F55
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410D2DD5F0;
	Wed,  3 Sep 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y343xazo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B841A9FBE
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929593; cv=fail; b=YunZBb5+N0LRQO3NElso2uDF1yyYfxEoSL+QpRRSEURO009MsnP5gmGzTIzW1fZs/gNzNd7zkRtemBSN1LN5vVZ68oVBJ/U5Ps0mhhfdpMZXAw+/dSrXoUnG/7+B5TtvXF+KnKRcvOIPNi6cLlUSuoxjMu16WGOK4hNOoZFOrmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929593; c=relaxed/simple;
	bh=67jayT24kaJEF8one6hWhiJTnLcOdbAnsloHsvre+Ts=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iNB503vsZXpAW3stWpzRHXhPfrpr4swDANbLm8xCChmMS8TkKWMFlwBH05KjtqIu6N/pjdDpriD7lQ8ZxuchqmADM14yoSPcS7XIqrvHd4Fh5ub0AZqx4Io+cvDh7Xo+1mI+JMwifAwBMORTGFZ2uTUzX6EAwI7XhdwyN9uW3As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y343xazo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756929591; x=1788465591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=67jayT24kaJEF8one6hWhiJTnLcOdbAnsloHsvre+Ts=;
  b=Y343xazoEvp0hssmnW5G0cIuRtqS6sw5ZgkereDeD2qYagfqsozPdKvf
   oEYQ5wF+wW6y+QoySAdBiZ3wNnPrkW+43MVuFlGCg0yJF6+uDkt5YyAga
   1cXn3LlhMrgnYo0j/cMWkHXhI/OMxCWmLFb2znGG8oOMqRjPgxMnV5R5t
   OBOsugf903YV4S8NeUv6oFe1VSgXi6zOMwpGp0v/EjdTMg0s7QT5pFbxW
   //Io5+eDS5DpUkhgz8LRgO3X7NvHwrVqFHKK6UVFTUNBKscdYxv0CSiWe
   yBgmK0qBW83AsOfkMIAlGROMTk8dy4en1sW/Ad4HfmrYmvmYNvmSUPXLh
   g==;
X-CSE-ConnectionGUID: awcPY7kgS5+5x+4WP/E5uQ==
X-CSE-MsgGUID: douXLwsuSHSHfQ71/mRlfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70630867"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="asc'?scan'208";a="70630867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:59:51 -0700
X-CSE-ConnectionGUID: KqIazxMkSc6RLkyazDV8fA==
X-CSE-MsgGUID: O9l7etv7SDGdZ8IQJNkXUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="asc'?scan'208";a="202542843"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 12:59:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 12:59:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 12:59:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 12:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpWfsfLm4pQoGGQvoOdECvMyjMtCO2Q/L/fnEAZ8H7SbtQDzlteZD/UsHIi0kK4j4Y0I1xPeNvaDCbzLUhQ8w89k8/6HIrE7Mc9lbQ0m8frjQaNFmp3d5JsIMxT38fOxpmT3tIioWocHiouIU9eNx3aGHtZJiZdADFQcFTvryyjAx0oZKI4S9BVgG7Iz+mMPIOfgCeNt/WDba/lkcirIDUFoDfNfiMVbJn61bmqggjBB88DZPfajdociR5lcdKomXQs15L6/Df9jxCy9halEEz6n7F3cLhJMcRHnQsW3sBwUB2fcJMLtgmDDRdMwv3fFHHcbsm0qp3pmqfQ7W9hnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67jayT24kaJEF8one6hWhiJTnLcOdbAnsloHsvre+Ts=;
 b=Hr3n30yoUuitNXJYP5TjKxpQfrQ3M47+533Mvv+yK3fFVUBwBI2HHr1Mh6FPz+f6fl3rXpJb9DKOuEFe3h41fVhVO0C478wCN1sEreT4eDv4bTMcrEjo96DAeigerfOZsFFibEWFAD6dqZdyf3ylNBsgisVXl9U7xXva1csXFH4BEokA+fVvdms38l29vJED9f62g6F4kV8/7TKvo0+DjkImdgb1F9TvPjxqITAbJ80buSxIs4SojMhJoVwCi8yzoRvcjaW7YznojJxrlia86KNhl7sG4PJhEf3ToE4zNSRfVFURKBfEw/rPc2lbQqa7475TiCJcXfPQfeni26wFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Wed, 3 Sep
 2025 19:59:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 19:59:42 +0000
Message-ID: <35fbf36c-a908-443d-b903-9a5410af7cf4@intel.com>
Date: Wed, 3 Sep 2025 12:59:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
To: Saeed Mahameed <saeed@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
	<horms@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org> <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org> <aLC3jlzImChRDeJs@x130>
 <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com> <aLfj-9H-GL_amuYc@x130>
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
In-Reply-To: <aLfj-9H-GL_amuYc@x130>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------GQq0LVT9IzD18OP7nX9u4n6t"
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 3238a856-d336-485d-f1ad-08ddeb246c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUFqNEVzVnduUEdQdmo4RWIyWHNXWTk4SWJKMFZnR28vL2R4ZmxtcEVraERX?=
 =?utf-8?B?MjZuZTZ2cFdoL3M4U3ltVXdodHlVRXF1Z1pSRkZYNGhXZlB3ajhmOFBKbC93?=
 =?utf-8?B?MnlWUldXZEtwK1VtYy9ZQkpLYzZsdVpOcTNFK2RHT0FtM3NMcmx5NWFFWm4y?=
 =?utf-8?B?TENoeHZPVDNSTEhZK3o4ZjJXVG5hSUtyRE1KWlNxM3I2cWFFbGpKcG8yb253?=
 =?utf-8?B?b0xOV1FrVUw3dTRPRnVaelF6L2c3ak5HSWxuM2puWm15bEJqTHlSVTQ1QjYz?=
 =?utf-8?B?dU1WSWYrZUxiQ0JnTGtiWVppajRCdzhKZG8zN3BjQXJSNlBTd0dXaFlueEVv?=
 =?utf-8?B?ZmtUZVFmVnJkc1FuRVo2TXJWaEd4bzN3SWdJQkppVFlrdGpCNUgrS093OGk3?=
 =?utf-8?B?Z3dlZVFWVWhSWGY1cDZSdHhqK0U3L3N5akh0aVUzbmpuL0pucFYrRzFLSlFi?=
 =?utf-8?B?aTV2OG1ZMWlGaHlkVGlCKytSOVY2aDdHVGZZNVdhR1dyR2ppcmVTMEl5TStz?=
 =?utf-8?B?dVBMVnZjTGU3YjNjZUlZeWcycUpOZVRLd3V4TnVQZGtGWmRiWmFJbElMdVZ0?=
 =?utf-8?B?RFRMZUJQYUxDbGNtNU1SQ3hYYVJ2S25TamtxdStxRVpmY3V5T0Y1NGtmZVhl?=
 =?utf-8?B?UTNRK2Z3RnByQ1Q1YW03UXg5ZkZHVlNkcUFhNUp3UGxtcGsySCtNdTFYbHp5?=
 =?utf-8?B?U2Z1eS83VHFZSkdHTmZYQUZLVzBwL1lyRGxpYnlRYis3NWRtV0lHTnpsNGxS?=
 =?utf-8?B?d1RxcXJPbW51SHdEa0psTnhWNlB0NnFTd0QvNHRid09JZm91ZTZwMHZYNW5j?=
 =?utf-8?B?eTk3NkpNbk1qS0FYY216KzdTMW4rSWQyRUl4TFdDN2dTL044cC83VVIrWEJj?=
 =?utf-8?B?b3FVYU1PeXdpVWp6Ky82NjVmditSRTVzWjI4RGxJN1A5SWkyWnNPcUZ0czJR?=
 =?utf-8?B?ZFdZK2kyV2RPOGR5MWllTVBpY3JvcExmWnZic0hJallyK2lQL3RBcE5NWlYw?=
 =?utf-8?B?MFFCczcySGNOd2x3OUFoUHhzdVBzT1lobmJFRnBTZ0dmYzRxNmM4YkRvU0x0?=
 =?utf-8?B?ZTVybWpOd1Nza2QrdHAySXhEeG9GbEVhUGg3UEl5VTB0NU5WYmlpcE5sVnBF?=
 =?utf-8?B?NnBzbDhRK3FTV1lQWTZpOUU1NmRPd3BGdkV5SFJONGhvMXNhZi9jSXFDVVpY?=
 =?utf-8?B?bU1DMEM0NWRBMkhnbnlzZlEwNUZyTGszOTFFTlJ4SlZHWUJSVzlWOXFJK3lW?=
 =?utf-8?B?OEVPQzFBOTZ4MFRheVZLK0hKUjBxV3pSbmUxd3pYRmxRcHZESUY5RTFFdndt?=
 =?utf-8?B?aVZEZXJ0TGc0Nm1GaFY3dVJUMU02YjEvL3pZTWlxSi95bE5hcTlyM1JZajJF?=
 =?utf-8?B?TFBBWHh6RzYrR2JsZlFXYVcyZGdQY0FlQnlsMWlmdld2b2VHWEtUMVRYVkxn?=
 =?utf-8?B?bTNobUxmMzJPRy9oY2R0ZlR0QzJuZ3V5UWY1Zk1KM1RsY1NDVjJpSGFPRFVq?=
 =?utf-8?B?b2wyNi9rYTBubUNBLzR6bnAwMlIrVFh3dU13Rmw0NExRbmpIaWRKVFZ1elEw?=
 =?utf-8?B?TXpVTk05OERwMFZZYXNlbGI4SHVvZTZwUzRwMDk4US9QZ3piMEU3cGpFU1RX?=
 =?utf-8?B?MlBmQkVaaTkyczVHcTdIZHk2Tk1mc01yQWtxc3lEZWE3dGF5UllmUU1ycUMx?=
 =?utf-8?B?NUdUK2VxL0dGRFRveHBRaUZNdXNUNjF4VVpqQUdaU0o1cjdnTDFTMlZXeTlH?=
 =?utf-8?B?bk5takZwMGVaQ3ovdFlnUjZaazVJZ21pYmlEWTNSMG5nRXFKWFJSU2UrOTh1?=
 =?utf-8?B?b0JEKy9ER1ZITnRhTTNVSVpWVmw3V014MUk2dkNnZjVGSHhGWXQ4LzA0ZlZY?=
 =?utf-8?B?WkpmODBLbG9jdUV4aVJTMmVBOEVmQlNXL0t0MjJlM3BBWFFEUllXSmJaS2FK?=
 =?utf-8?Q?hfKfcGJhpQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFISUIySDQwNml3RkdENmxGNE5VZXBQOTJxbGNHSXlScmRRMk5Vak42Q1Fq?=
 =?utf-8?B?aTBLR0thV3kvR1FicTNHdWxIeFYwSE84eXRnSUxDZzBZaWZFZkNreWprdDFQ?=
 =?utf-8?B?SmFUSnpmUnpZV3RJUzExbWJJME4vMTE1cGxPd0lwNDJvOXlUTmRZWlVJRDg1?=
 =?utf-8?B?TVJ5NEV1b0FMUUdqV0tVYkxIaFJ0QnVhTi9uSml0TUY3dkhIbXUrdWVWOTFy?=
 =?utf-8?B?ZGIvbG9FSytyK2NYNXV5a2JyTjMzNDVKNE9uejdUeEliREgvTDZiLzBFV0hp?=
 =?utf-8?B?VksvaHBSVDErOVZzNE44Wk9lZnkvWWt6ZjQvSDdIdjMrS1JiUVJpRnJHZ3RF?=
 =?utf-8?B?UHgveTI0SVlqQmJoWG55QU1SclVOTVZlc3Q3NEFuTDVlWUhZSmZ0cUxEaC9U?=
 =?utf-8?B?UWJ3OHRhUmdjY1ozL0lTVFZPc0RySFh3bTdJZjJVcS9UM2t0QjViSlZBZXZL?=
 =?utf-8?B?WVZ0M2JSaDZwbW5QV0hteENIdXFjUDlKOE1VT3dnUWxrU1hvSUg3d3ZGeExk?=
 =?utf-8?B?MmR4bENEcVRLelJUY3AyK2sxc3NHc1h2TkJmNXdmUzVVeldYRVpUVkxGM2tp?=
 =?utf-8?B?WDJKQ3E2WVdFSjRTbGZVbTJtZVpSMXJkeFk2RndqdzQ4bHd1SzkvRlVSU3lM?=
 =?utf-8?B?T0NKUDFOcWlzVG02cjhtT3k3WnRJYzR1bXRvTG1RV3I0UEJ6V29RRVhFbm1u?=
 =?utf-8?B?S3A5YzJMNVhQbW5kY25SYjVJUlJsRHVKRVBsRCtPcTVxTmphbDM3aExCSFJ1?=
 =?utf-8?B?d0czclRxc0Fpcnh4cDVyQUdyWm51N3ZzVExSR3gvZkVQbUhhWlRqWFIwWFgv?=
 =?utf-8?B?UE1pMGt5ODV6TG1BSUhvczlySldEUDR1TlVScEw2RWtEVEt5KzFzdXovdE8v?=
 =?utf-8?B?OEsxbXBEZ1hWRTNOckRGZGM2WEhLQTlYdStFUGl5c3QrRTJ0UXpMM0wzODUv?=
 =?utf-8?B?dEwxaFZDTjdab3Racm9QWkJBd3RyMDg5K294bkdHVUxXWmJzSThLS1MzSEJw?=
 =?utf-8?B?MFdyUWRadFBpSFNJMnN4S3VHdW9pSHpEUXNqTUw5M1VwV0VDb3lRR3p4dVB1?=
 =?utf-8?B?QjhSNnd1QW1RM0JSb0ZQU04xN0FkbVNjSlZhelZzTkJTeGFBNFZPdmhPVUxV?=
 =?utf-8?B?cTF1S0pXQ0FFZEcyamRiUURwR2ZrRTJRWTNndStEQ3hLMTd6T3pnQS9XR2Vk?=
 =?utf-8?B?TGRkaXlPUnVIbEk3NVJjTWdnRnpYd1lyYTgzSEFUcElBRVY0eGcvQ1ZBWG5Y?=
 =?utf-8?B?ZWh2cmJld1Y4bTZlUzFnMWVhWjRhOVdNVEpiMVA5c0dudzFwQ3FQSHNrRVRQ?=
 =?utf-8?B?ajAzajVydk5WNjFKYVRLYmE3Vmlkb2RJMHpteHM4RTRvSHRGZFk2R1hGMzIw?=
 =?utf-8?B?MEJibEZUbjloaUtzbE4zR2c3TUI4bHpWK1ZmRG1FcGVaY1pIMWlYdzJRaEEw?=
 =?utf-8?B?MlArTUFsY1Awc1k1Uis1RGxKODBnZjhKWkhwY1lCWFFEVmlGUVdiMVdQZEEz?=
 =?utf-8?B?ZXJ4YzF4UmVwblZ1YTl4RjI1SVVqTVlqajZaaVd4ZUZ5by9Uc3JPSFUvRU5l?=
 =?utf-8?B?cHBQM0FkbEFxckZpMzEvWnlKOGk0MGNidlo0M2NkQmVXK0tqL2ZjMVlDTDZk?=
 =?utf-8?B?MnBZckltS3BNcWR3OUhQbFpyY2tSUTk2ZUw3ZlpVMXNQUVhDbGF0VFFVUFc3?=
 =?utf-8?B?S0gzb3drUXNBR3JtQVRkL1ZQNVQ1c0xFNXpuWTVTN2QwNXpOb3JwTjd2U2Fq?=
 =?utf-8?B?akRDY2tUWFVwWHJLWCtPSmdTMUsydHRBRDR0dHFReVMraDlSWm1ka2JubFN2?=
 =?utf-8?B?OXd4UngwbFNaSEZUMk9aeGxkT3dZVVM5TmQ5eVFxajNCbkhhRy9lQ1JOdEw0?=
 =?utf-8?B?MG1yZHhCblNVdEhRcnZ2dFR2YXlSaDRYTlJKVnlBbXpHRnJwTnBFZEppTlRQ?=
 =?utf-8?B?dGwyUVJBZHdHWit5c3N5ZWh4bHBRZkFGc1NnRjRwa3VqTGVNUTNjWDBzTGly?=
 =?utf-8?B?N21nTUFGWHR5THlQYTJIbjl0NVR2aUJPeGhqZVVwZ0xGVVo3d05ES2E5cXBz?=
 =?utf-8?B?cy92WFZMNVlxdXVLeURmcWQ1VlV4R0NQSkpDR0R0Z1ErNit4RTFMcWtaSEVH?=
 =?utf-8?B?cTRUaHZscWFjOWF3dTErRWcvYnFvVlFOS2U5RU5PUllxUzRGbW5QTXZYeS9k?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3238a856-d336-485d-f1ad-08ddeb246c6b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 19:59:42.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HkavZ02o73zkF9UeAoXhDmd07P/nfm2vFO7b54XgWN5TErijr/vzApRK8rRqFIs2R7QJzdQ3cfo8OhAPftsobO8zhP2LOq5GJBrsQ47rK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

--------------GQq0LVT9IzD18OP7nX9u4n6t
Content-Type: multipart/mixed; boundary="------------ymgpIV7vsp2WBiXdQDQvAEYP";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Simon Horman <horms@kernel.org>
Message-ID: <35fbf36c-a908-443d-b903-9a5410af7cf4@intel.com>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org> <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org> <aLC3jlzImChRDeJs@x130>
 <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com> <aLfj-9H-GL_amuYc@x130>
In-Reply-To: <aLfj-9H-GL_amuYc@x130>

--------------ymgpIV7vsp2WBiXdQDQvAEYP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/2/2025 11:45 PM, Saeed Mahameed wrote:
> On 02 Sep 14:57, Jacob Keller wrote:
>> Intel has also tried something similar sounding with the
>> "link_down_on_close" in ethtool, which appears to be have made it in t=
o
>> ice and i40e.. (I thought I remembered these flags being rejected but =
I
>> guess not?) I guess the ethtool flag is a bit difference since its
>> relating to driver behavior when you bring the port down
>> administratively, vs something like this which affects firmware contro=
l
>> of the link regardless of its state to the kernel.
>>
>=20
> Interesting, it seems that i40/ice LINK_DOWN_ON_CLOSE and TOTAL_PORT_SH=
UTDOWN_ENA
> go hand in hand, tried to read the long comment in i40 but it is mostly=

> about how these are implemented in both driver and FW/phy but not what =
they
> mean, what I am trying to understand is "LINK_DOWN_ON_CLOSE_ENA" is an
> 'enable' bit, it is off by default and an opt-in, does that mean by def=
ault=20
> i40e/ice don't actually bring the link down on driver/unload or ndo->cl=
ose
> ?
>=20

I believe so. I can't recall the immediate behavior, and I know both
parameters are currently frowned on and only exist due to legacy of
merging them before this policy was widely enforced.

I believe the default is to leave the link up, and the flag changes
this. I remember vaguely some discussions we had about which approach
was better, and we had customers who each had different opinions.

I could be wrong though, and would need to verify this.

>>>>> This is not different as BMC is sort of multi-host, and physical li=
nk
>>>>> control here is delegated to the firmware.
>>>>>
>>>>> Also do we really want netdev to expose API for permanent nic tunab=
les ?
>>>>> I thought this is why we invented devlink to offload raw NIC underl=
ying
>>>>> tunables.
>>>>
>>>> Are you going to add devlink params for link config?
>>>> Its one of the things that's written into the NVMe, usually..
>>>
>>> No, the purpose of this NVM series is to setup FW boot parameters and=
 not spec related
>>> tunables.
>>>
>>
>> This seems quite useful to me w.r.t to BMC access. I think its a stret=
ch
>> to say this implies the desire to add many other knobs.
>=20
> No sure if you are with or against the devlink knob ? :-)

I think a knob is a good idea, and I think it makes sense in devlink,
given that this applies to not just netdevice.

> But thanks for the i40e/ice pointers at least I know I am not alone on =
this
> boat..
>=20

The argument that adding this knob implies we need a much more complex
link management scheme seems a little overkill to me.

Unfortunately, I think the i40e/ice stuff is perhaps slightly orthogonal
given that it applies mainly to the link behavior with software running.

This knob appears to be more about firmware behavior irrespective of
what if any software is running?

--------------ymgpIV7vsp2WBiXdQDQvAEYP--

--------------GQq0LVT9IzD18OP7nX9u4n6t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLieLQUDAAAAAAAKCRBqll0+bw8o6JYM
AQDWyWUaGXx9OPq2hrsgJ6AY0z7J87rYzVGIurCPrTn3eAEAg2s3HvNIIk3uUYPPZ3cANbExBvLR
HDHUHg61u+v3LQw=
=Ec4q
-----END PGP SIGNATURE-----

--------------GQq0LVT9IzD18OP7nX9u4n6t--

