Return-Path: <netdev+bounces-235270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E886C2E697
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87BD34E38FE
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030E2BCF4A;
	Mon,  3 Nov 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsPfQd3q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA44142E83
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212979; cv=fail; b=hrpdkX192NSbSOn85V0G+D50dxkoQdCIDuhiFsomuCvote3Xa6kjxXF6hX8WDXEIwGSNcD4T1rqj4hKhNKld0rvDzZsCj85Op2uzektKsNqS7mR0RcN+DdJ1PVApVTLnFYlzh0uq9VZDF/Amuc8IHEhUXfInrfas0UcNaU6znI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212979; c=relaxed/simple;
	bh=GsyHnYBmmMZr5PFDT394SdiS1P68snczkmFEI6uF1Iw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsbkgG1qM+3V8kvujUpqPLVYzWFwpJAKlonSY6xv2mIgG54PJ3649yFFhMRx2oU8M4Xu3Q6FJjZilomrujwB37ii4uTVvXkMcMeH4mngQcOUTQXy9x8WWewsTeHa3pw1ll3XfiHeMuOR0rb+xU5zgGpQ640+Bmj1vYRw2rc+2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsPfQd3q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762212978; x=1793748978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=GsyHnYBmmMZr5PFDT394SdiS1P68snczkmFEI6uF1Iw=;
  b=OsPfQd3qoI+GAIUCoTI3n1Da1vhBd/l/ldERV+rXuwHGua88J38SzWvU
   r2rFy6jKD7eEBw2eXBiXqGbrTpaxWSZYjClp+cyr/zxelWsHt61FNH6RA
   J/DU0iRiqm3ucHTpJ4zIx+LNuQ7FfVjXdGewwW/LJaZEQf3sMWBYa8cqw
   t3Chr2vfn0aZi6Xe1fTL0Tl0vczYnIRT8upDbCMKCRGFYPg0WdvzO8Tr3
   DVF7Jz8Q0DKsNmFYZyHftYht6QYLXEN6b1M6P5BpxKSxglUlnZWztA93D
   N7oF/H0qb5S+XJP8VecdXFWXDs5ceHBNm1Wa8OMjEX2wVbJS03JmRanJr
   Q==;
X-CSE-ConnectionGUID: neKnBEI9QvqgTmsD9ih0vg==
X-CSE-MsgGUID: hlBHewUuSnSkH1koqobvVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63997183"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="63997183"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:36:17 -0800
X-CSE-ConnectionGUID: GUrHiWPhS3iFrt0qVuhpUw==
X-CSE-MsgGUID: hzPBk85BSjiKC56yxp0Npw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="186677234"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:36:17 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:36:16 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:36:16 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:36:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn4163lQeni7sD3mdJoHJpiI/oJ3tC41E9I8TM+n8cnpArQ3j0Xb7HeBg4ZW9+ifOHBtLox7d3YyLDwlJjNesvQivzDIPUhGP5GVt3rN8bPzc6h28UD5fnlv01szroIXPLpbW7XrOLXAwr6VU7C5BnaXnJDjiNVtXRlGU3sC5XT8yEKhxVGMsTmxP1yktWaX8T2eeBZM/MuX/Cq3iz/oQl9semEDmG9vLDxliGbRycNbv0HiFMLwBDvFKRd3xXfAjdZiiploKv+Hp6suYBMVxrIbiX0UURd3HCSbtEV7b76R/t14xJIx9/4+pYo+V5k85InBS9B7gubS2aFLNwXgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFDnCt+haBeFK0NttO+LORuoqOQkQ2Rnh9WfFLvKH2s=;
 b=LbXzZJFYdbCx3B7r+193ojuF0xGtCPe9c0GHVP+C3T4XXbDCJvxq3u/V0Xo+0tf4UTwtXI8shivTVqUZZsm7WbtGP4xlSLpv9nDZDyhN/FscSVsRirRD3xtDRI9fu5OepE4xeZBoEuWgl1TqqJ0suBRnk7spgZYlbooEOps/LHiqM4rjGOQCpGt5X7BdskwjXA2Oelm6PdZUK1rcSUJRTMW3EMp3E6k0liGzlARUHJoP7k4IldN/TyABavHfhe0oJbc/6okELF6+yPfCIZqi5AANlxsrj3pzYx/AA9oloOmVccDVJVLfg7W6PqgFsbRkEjmDfVnr4OmzkYK4ae2GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:36:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:36:14 +0000
Message-ID: <1f584fff-1b35-4073-9270-67fc0cc3b864@intel.com>
Date: Mon, 3 Nov 2025 15:36:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue struct
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
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
In-Reply-To: <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------DTRwI80bvNPx7hIxzOjk7AVP"
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: fc05fd12-f610-4bde-088d-08de1b31c71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2VsV1BCR3o4Q3FoRDlzejk4YnFrUWplTE9jYXlVNHo0ZisvUWNSMzJ2Qjcz?=
 =?utf-8?B?aWFSb0gzSEJjQVVBMitUUUI3eGFkUTFDbDg5bm50MDNYK1pXdHNkTkFYbzdl?=
 =?utf-8?B?UmRJUnZCK211dTNNcjMvb1hJMTBOVERPRkFEL3c1ZXVUMmN3bDZHV0tybDM4?=
 =?utf-8?B?dFg3aXoyVHhQM2hvYnZLOXh4d2VRbDBieDVPdEFoSHROaEtZbzBueFdjMnVP?=
 =?utf-8?B?RmllVWMwUkhIZW42ZUNWcmFEVytzUnJNRlFZakFUVm5INVdDZFd3dzAvWDk1?=
 =?utf-8?B?amdYeDF6ajRxOVBwanVjeE0vZ1I1MUxOeDBsUmg5T0FhRDVXcHA2Z1kzL1hE?=
 =?utf-8?B?KzlQMDEwK1dvOU0rZC90dVFjRjYwRGNBOHlXenVPM2ZMUzVkTUhsSDhhaWhK?=
 =?utf-8?B?WitQbUdxVzFUZFQrcmlPTEpyS1QyeTNkeWlpODJ2clA3YU4zd0x0ZVVpTkZZ?=
 =?utf-8?B?VUh1REticDdha3BKZXg0dTYzbTlXdXRoWmxpd3BNc2ZYYVppcTk5UkRHekY4?=
 =?utf-8?B?VUV1SmFwUzJnWmNZNXQ4QnNjbWx6c01LcGxkVDkyUm9iWUVCVUltTCtCMjRG?=
 =?utf-8?B?NTBPZVNNQXFEbExIa0tiTTBmNzloSFM3ODJYTFAzaDBFVWdqYzl4OVM3UGs1?=
 =?utf-8?B?MEo3MXEvL3JlUWJTQzIvYmtBVFZscEFsemJQWlBrcW1DUXVqWDM3bzBBZTNU?=
 =?utf-8?B?T3ViQ3lldHVtODBtZDI3QUlzaGhDSERDTXM3ZWJWUTUvaWZTWng5VDhhTVlu?=
 =?utf-8?B?azl4OUZJZG5vRnY3UHRoRjJOSWJzV0ttZnJHcWpvMWNKZDA1V0pOa2FZeFQz?=
 =?utf-8?B?MGdUSHJFMURuM2c0aU4vaElEd2xYVVhZaHZtSWxkSXp4SUp0Zy9IKzZ2dkZU?=
 =?utf-8?B?Rmt6a1Y0dlY3YlIvQkhtUk1EQkY5SWVXSWtKUENSUG5WWktKY3AwY2pROGI1?=
 =?utf-8?B?eW90akJzN1dFcXJ5ZmFycm5TZ0VScnlZRHlRRnJrN1I2T1EwL3E4ZVNVYlpJ?=
 =?utf-8?B?VjZvSWxPUUs1bzU5dW9NaDRzVXQ5WlMwR1p3MEFuR2RjYVhvT1gxMWxLQXhS?=
 =?utf-8?B?NURRMXV3eGhGcXNnUjF6dEtZZmhQZzRZeHZGMU9CMGU4dm5BWW02Zytia0RQ?=
 =?utf-8?B?OXg3ZTI5TFpIYjdaRWRFeVptT3pRT2ZrZ2FWekQvZDYxNVVLVEVrQVVNeEtE?=
 =?utf-8?B?aVJMc3JTQ3Q3cWg2bFFQSG5nKzdsOTEveGNkV1cwQlNkN1dIVEdxWGtXcnVV?=
 =?utf-8?B?SDNmQmpGd0VtNmQxbTlTUFgxK0o3enUwQkFDY3pObkpyTzEyWmtmeGNwY3o3?=
 =?utf-8?B?MUNpc1NhRE0xUjE1RDRDY1R5NWFTZkV2eWVtcmpka0U5ZEJyL1AzbW1uMkV4?=
 =?utf-8?B?SGVmN2NaR0xTMGtSSWFiNXVJZ2orMFljbjdnWEZDL2ZYb2gySGNnSktUcERV?=
 =?utf-8?B?VEZEVUlPSWNST3M1Qjh0MDd4by9tbVlrQ1JjSzRjbnpkNDNoOFYvdGZOSFdV?=
 =?utf-8?B?N0F6V0JuQTJkN1hpQXdocVZXZUl6NG4zTHhiMktVdnh1bVN6Z3ExcjVIL21O?=
 =?utf-8?B?Mm5Kc2FFREZEdForOVhuSjVPS2JhSzFUWWI2Q3V0T0tYOGFyVGxCL05CRXFz?=
 =?utf-8?B?VEFSMkhERU5TNnBuTGNTdFlvU1lNb0Yrdk5iQk81NlU3aC9oZUdFQ3lqN1ox?=
 =?utf-8?B?eTVoVU9qTXg0b01kWmZDVElpbHh1NTMxU2o2RWNLMC9SSmRLNC8zZUJsK05K?=
 =?utf-8?B?TEJkaWNiM3ZwVk1qLytmNlgrc2U1MFRkTGhtcWxWWVJtemdERVNrZ1FBTGlW?=
 =?utf-8?B?T2p4c0hBU1czZlJMeWpiWlVDT1NqamVnOThQR2hYRFhMdTBpMVVWeXNMd0lv?=
 =?utf-8?B?WnRrM1RyMWttUzBmRUtnaTZGM2ltVXZ1TzlEYkFtSkpPako2dGJQcEZ2ZTUx?=
 =?utf-8?Q?K4t9AqSbUO0gDAsaZOUC7lJjnDuUWMe+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpSekpBdUtCa0x3SG9vRksrME5rallLdWVHNS9oZkVTK003SW9lRzkvRWdi?=
 =?utf-8?B?Rkt6WGJUanFGU3hRNEZzUm94VEd5VUUvU21NZWxuNHd1c3JNQmJFTjAzVDl1?=
 =?utf-8?B?d0VNVFJpNG5idjlGcWxtZ29uRGdoZjJIc0cwNXRBZCttcW1zdmdJT2hEYTRw?=
 =?utf-8?B?RDZQVFd4bWhzYUR4bnFkcVhDWDE5RC83bmNwdzUvNWhKUThlTFRWMnhlbS9t?=
 =?utf-8?B?UzJrRUR1VGxYY25zbGwvRUFsWW5mNXlVUTY3MC9jTU9vV3J2b2p3Tit1M2wv?=
 =?utf-8?B?NEZnbjRRU0Zya2lkUjVlWkdlSDE1U3IwVU5PUEdXNm9yMnV2dmdHYnNCSEpx?=
 =?utf-8?B?ZkEzU01OdUh5ZWRueS9ucUZJRXBnNGY4M01kb1RYcWhiVlcxTTdJcjh2OVFB?=
 =?utf-8?B?c2hscVFDVVcrOXh3R2VQaVl1Ny83eFlsdTZmNDM2MTMrNjgwSlRiL1F5SkY1?=
 =?utf-8?B?cFlabWNQeTBpbFpzNzBNVTNMRlFHWHlENGl2RTRtSk52bGdIRVFhUXl0dGNC?=
 =?utf-8?B?S01lYjZkcHRaOUtaM2hjWWw4QWp5YUVJMzFiWFBUSXl5R25vRllhVUN6bFN6?=
 =?utf-8?B?SnFRZWwvM0tZVEtWRmplOTZKNmZxVG82cTB3L2RCTjJKVVJ1eU5RbnBDSkxH?=
 =?utf-8?B?YnpWS0RYa25pQlBjdHpGbnNBRXRtVWtEcTMxYVBWRmZYaEI0WjNYd0tRTlc3?=
 =?utf-8?B?YXZSdGRMS0c3NDZ0TTF4VjFGeTlHVVFKSFVVWm5JRHd2SGU4d0gwNHMvWjJn?=
 =?utf-8?B?N3NVaStrTmMzRmRlUW9GUllkV3ZWY1NUcitpZkNNeSs4aFhpTTlCWUJQczJv?=
 =?utf-8?B?UTBkV3ZqOUlvcjJ3b3EzMDVGZXJqTVkzMmRLazc5ODE4UkxuWlhScVd0Qk1F?=
 =?utf-8?B?SmJQYnhsME9YTUQ1RmtBQWd5bm9kY2U5RVRjUDk2NXNOeVVUOS85OXlnRW42?=
 =?utf-8?B?QVJNMnMweGViNGJuMG9iNHhDMFczbERTNzQvN1lNc0JhUEcvem95SktTOERn?=
 =?utf-8?B?THFnVlcrais1UTI5c2lZQVZ1WWkwZENnMThOY3dyVTVybHlMMHJKRlk0b00z?=
 =?utf-8?B?VFF1d3BJUmVYMXp3aEJzVWlBNHBJaXpnVkNNZWpiOTlCNE81bTBqcS9OK0RM?=
 =?utf-8?B?M0Fja0RmaGpvMy9FNUJIUEYyWVpzaFRjTWtDN2FnYW5FSjNSNmVRYjRTK0Vj?=
 =?utf-8?B?SGRXM0hHTEYxT0VrN1RRcnVCaUJRZTVCN2VHZjViY2hDZjJpdGw0ZitVT3lB?=
 =?utf-8?B?Wms3THpvWjNVSFkyc1oxSVpDWHhXOC9JNnpnTENmQnJjaEdVQlhIcEFVMlFL?=
 =?utf-8?B?S1ZIb3JaQWljMWRjbGYwSTdvekRKajl2QTNXQ0xlaTNmWFEwQjhyeWQwdk5U?=
 =?utf-8?B?MnhMREk0WmdlaGlyTk1Wc0NVdGxWS2dCZkZWbXRFeXAzd2ZtKzlRWUxsekxE?=
 =?utf-8?B?TUxaOWlBeGVCR01MQXhhRWZHNmVrcyt6RDZvNFVMWUZBRUJobFBBS2gvdDFB?=
 =?utf-8?B?NEMwbTFlSzA4RHJoQWtzRFI4VEFRbnlGZFRDb2E2WEQxZGtEUlV4SS9HT0k3?=
 =?utf-8?B?UktXckwydjZuMmphKzN5YjFUei9EZVlHZktMeUYrOGd3SlpwOVh2R0xQVVIw?=
 =?utf-8?B?bnUvMGxqc2E3OFFEU01SWXBZVGpKZ09OQnlzZC83NlNyb2xwTVpBQTFPTHFj?=
 =?utf-8?B?K3I1VEJncUVaWm15Q0dRUkRLVlRJWmhFblVsS0Z2THE3ekszNjVFVlBlY1ZC?=
 =?utf-8?B?SDNVYlluZlpnREFNQ1NNcE5mQndiTGdNQllqUklZQ3RQdkFiOHg2dkVFcS9n?=
 =?utf-8?B?U3pxTVF6c0UxeGRQZk92U0E4Si91ajZQNGZzK0pyZFc3UVVJaXZyU3pjRWVQ?=
 =?utf-8?B?LzJDanZkWWVJWWIwaXFqU0ZYcnMwMUp1OHlBK21nQ2dEZjY1Z2ttdk1KZHVY?=
 =?utf-8?B?a285VGs5NEhkTVM1TzZud21DcVl6VllLYytUcXNoY0RBQ1pTQ1FsUEdGU2ND?=
 =?utf-8?B?Tm10cjJkVXFSdXlTSEJKb2lHNTdCT0t2R3FTZE1pWVNSMWlIcDdUaGpOMndP?=
 =?utf-8?B?ZDEvdjJzRGM5Tm1TNHArUU4zVkhCSlNKSmhjalNnbW9sWi84L2FIWndab3Ra?=
 =?utf-8?B?WS9zT0tkRStTZ3dyZ1p2Y3FuZzcwVDlBWGhTVVZHbmUyVUlTMmVwNlRsSWJi?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc05fd12-f610-4bde-088d-08de1b31c71b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:36:14.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARdQ8MjOTtgHuMnOxBIEUXrf1bWhFETUzKKfs1yiID+I6i8u+m/aWj1Cz30dlz5mKDNlv3rfRuve8NUnewbxCt6XtPGM44fnTuzJ7EAMDVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

--------------DTRwI80bvNPx7hIxzOjk7AVP
Content-Type: multipart/mixed; boundary="------------5hNmR44Hs0kZndx019TofX6e";
 protected-headers="v1"
Message-ID: <1f584fff-1b35-4073-9270-67fc0cc3b864@intel.com>
Date: Mon, 3 Nov 2025 15:36:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue struct
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
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
In-Reply-To: <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>

--------------5hNmR44Hs0kZndx019TofX6e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/3/2025 2:27 AM, Lorenzo Bianconi wrote:
> Do not allocate memory for rx-only fields for hw tx queues and for tx-o=
nly
> fields for hw rx queues.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> index fbbc58133364baefafed30299ca0626c686b668e..750dd3e5dfecb5d3d0ff754=
f6a92ffa000db3343 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -185,19 +185,27 @@ struct airoha_queue {
>  	spinlock_t lock;
>  	struct airoha_queue_entry *entry;
>  	struct airoha_qdma_desc *desc;
> -	u16 head;
> -	u16 tail;
> =20
>  	int queued;
>  	int ndesc;
> -	int free_thr;
> -	int buf_size;
> =20
>  	struct napi_struct napi;
> -	struct page_pool *page_pool;
> -	struct sk_buff *skb;
> =20
> -	struct list_head tx_list;
> +	union {
> +		struct { /* rx */
> +			u16 head;
> +			u16 tail;
> +			int buf_size;
> +
> +			struct page_pool *page_pool;
> +			struct sk_buff *skb;
> +		};
> +
> +		struct { /* tx */
> +			struct list_head tx_list;
> +			int free_thr;
> +		};
> +	};

This does save some memory since a given queue now is limited by the
size of the larger of the Tx or Rx portion.

You could completely separate the Tx and Rx queue structures, but that
ends up with a bunch of typing issues to deal with since all the
functions take a airoha_queue structure currently.

I think some recent work has been making use of struct_group() for
situations like this, but its not that valuable if you don't need to
quickly check the size of the group.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  };
> =20
>  struct airoha_tx_irq_queue {
>=20


--------------5hNmR44Hs0kZndx019TofX6e--

--------------DTRwI80bvNPx7hIxzOjk7AVP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQk8bAUDAAAAAAAKCRBqll0+bw8o6Jcw
AQCF4J01QM3IsLEG/lbAvIfpAoqxgNMsN5dqgHVCdjx6gwEAwhbUq6izIwBBBdBe+/WR1HZGuZHN
TP6hhL9aPYrIbgE=
=lOPU
-----END PGP SIGNATURE-----

--------------DTRwI80bvNPx7hIxzOjk7AVP--

