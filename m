Return-Path: <netdev+bounces-279098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHZFKGsc4WmmpAAAu9opvQ
	(envelope-from <netdev+bounces-279098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B14412B6A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF1DA3042260
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41743264D4;
	Thu, 16 Apr 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcTALLG7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CF327BFB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360237; cv=fail; b=iuH0MIGtk7InLXHKmRL4hpf+ii3IUwX25Vai6ArC2pCVv+7vB/Hpe1JUHmguG1D8AChF8bQYWdUsa4/6suFhzhIgF5HgX/d+Nsdu0DE9cCcfKSVOydxoe125Z8GkC1UbG+60g97T5/4b3yqxRv1i9D8VIbQndhMUHeS6pCKNLkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360237; c=relaxed/simple;
	bh=8wE/WRHy8OjUx9+KMcgKFZLhghG8Cyhl0ajAKxTnA54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PfSBmerYFaKz70FJ8K/TiNkbV0xqY2/NrGkDPhC+BarFPW2pAO2LQ3XLP87irrgXlJapz2VzUkyVsf/5jusmNk6/+o6LFc0Ozo75X2yKoFpEdsBEPGy5hSmXdp8hsOy4rAdvEGST2zHIzZ1LZz/ljBWEJywlm3M99NEExnTauuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcTALLG7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776360236; x=1807896236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8wE/WRHy8OjUx9+KMcgKFZLhghG8Cyhl0ajAKxTnA54=;
  b=YcTALLG7KzArO/zPq+0YrkBKQbzrL5fAn2+UU6iGk7fuplSx7AZGIuhd
   GFhpWNU3uDiBCdLtDcmq6WzKqZM4UE/b+0OkSdhjSIsUQMNLC9BKxkobN
   /dzEO/Byhi4jICpj0DdoiFQbFK9yO6360y6hfnATd6zVH1CziejGewCPc
   OSvEoQNvgUrczdQUkfxrue/7lPKANnzlXJN+LhJl5EWkq5E/jN5cb3qzY
   1KoJMWfFTiQSoJUuXZ78yj1XGIVBJp4+poyijChiFSexmIvKj4wl5ubye
   pDavaB2DACtPZfO3wacnDpOyVeZ+wz3wavJgFwlKWABFnVS1HUt9WpJVS
   A==;
X-CSE-ConnectionGUID: XiYYQIPGSGKy9tollrBldA==
X-CSE-MsgGUID: Ii3psuXoS5KP2cM41mJEyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="102830296"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="102830296"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 10:23:55 -0700
X-CSE-ConnectionGUID: MWtaVmdRRW6v90BwE5hYog==
X-CSE-MsgGUID: NRTfstL/R0SbOxM522/wnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="226451815"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 10:23:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 10:23:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 10:23:54 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 10:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Voob9LAtTby4SmIUJyQBwknCRqqrDZ9GDttfeZ6/GKUxHYo7K1OPelEUwiO2y+ZKYAX26tAD2TlFlhiggAWOUPDyd7+n3QckLNVM6t1sNkPF5F5ARtJXR9veaZsFm7dXpVsyGqkVnteOdW/YbdN0l7mQcGrQHT5RLkM/mHPFqJg/zM2/crs0Q7oRJgosyBUQNCxfxDWfbgnrOt8008RGGdV1iNbqTaKRipTZaep/p/jvJvdD7bUQLRPHqhsDZRFq+ya0bYErh+CM4/dJIqQbPywNoHlE79BWExmS6W+6aQ4F4NWAZt1yoEjj1HwvufxAnky3ZxA556djNIXD4MJ2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wE/WRHy8OjUx9+KMcgKFZLhghG8Cyhl0ajAKxTnA54=;
 b=ThEQOj3hG2XygxRW3bYU9SmA9cBhdNgrDetXkSd8urd+pVKhSfZHoFauxXb6H1+nHdm6UATbJlgcz3pkoPhjTe96V0+hNAdwfaZmiud3c/boeeGdFpwvyHVXv2X492A1blrZpABah/pCDdc/t5foWSDutygBLf0I+gs9k9GzxDy35/gSsNktWgyHXHuxI0YQMaZcBtr8ik/V1mSRIGoC2cSoYwf3T+3W6UwnE+WNqiwzpnHzjmex/pAbLTGSr7KyiDsmJvluZEjkJ1TQoV24YOJbvy/I5Dgy8Ocm/Ty2K3co2MVDPgaqgtEgw2YSGhCuDYynqcen+A4ViC9ee+ebQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by DS4PPF240F42FB7.namprd11.prod.outlook.com (2603:10b6:f:fc02::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 16 Apr
 2026 17:23:49 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 17:23:49 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/4] ice: fix timestamp
 interrupt configuration for E825C
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/4] ice: fix timestamp
 interrupt configuration for E825C
Thread-Index: AQHcx4g0EGAL/uzh/ECfLl9FqND5m7Xh+ZSA
Date: Thu, 16 Apr 2026 17:23:49 +0000
Message-ID: <PH0PR11MB7522CCB5F284B9456B9EB8D5A0232@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-1-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-1-b959da91a81f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|DS4PPF240F42FB7:EE_
x-ms-office365-filtering-correlation-id: bd8c249c-ab0c-44e5-4e34-08de9bdcec8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: gKcrFaOGjDtb/WM3ofGTVb6m4H7XRFg2uftn4YRegeeYliE0Uv8SbC2VTbM0Qygw8gsvJSW0+j/mlahPzvqeYEU6cuP2r7plY08ptEZnmKQgmJ9PKh/XpZn8v42PGSREFYWxTmRXEwRoSdSMgnnNHFGEA/dCKySzgYdxTU7VClCwE2W2Vxq/AhbS5oWhWUr4apXx1teJuJTJIXlCK9I6c9QVMooOnL1wC4vrfJLPwWvP/dZ8Xah4szpFsB4E4Zc9fAx98uxZgJZOxrjLhEgpr3kIrGDPsSV/5uEhyinu4WlP+SZwrwO0PfkVazodtBqMGLe6/qMIz3shpXvWyHcoTWeS3yJPKETpKwwnrTtPUF73Rnql/P5Pu9CEg3XvKWypeQhWI8B0BDnP4njDj4FuM4XrdLCM+SJmPUDo/BOUG4M8hW/aXp4dbi1M3O4c/DN+1kRY0pX3wegPvUchLNQaST9JqTmDOAgnGcLqgh7OJ2fTPS7s9SRkhrymomaocqDWDijAqarju/74kI5l4KScm+NsHkSIIax+8uoGuRkcTyYMKq3UVUYAEqm4SubuwMqtqZsfrU4Fi4YaAliZzxYVD/PHRKdZkQGWquL96RyKiyRWMUB2qvw1ROCFWA8azijvdVzdVlTPuo/re4zrGDECqBhH1qEOQG3vC+VWqNhhH/xTNPUZcckv2NZuLM0GsNV3ksFQjlUfkSVf1/3FbLjZSHsoiGP8IMnDj70lpU+M/2wvWAeclVIIE7N9UZXFgnje+IoM/wYdEpPyKbpFrMxQ1vuLA1F7lo015jeyysNzB3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHd3NG9Wc0R5MU5BdGRZM29GUDdDTkJBbTg0a0tzbmx5NDFLeUFsSEZGdVE3?=
 =?utf-8?B?azl1NDRjSUkrOXVDaGxQenEraFhlZzNYeTI4QkMwcVc4WFd3ZTN3Rnk2bkdV?=
 =?utf-8?B?UU9xNUl1SFQvb2ZvVHg3ME9KdW4reFF3eE9BZ1ZLaW96L1NPUXhqZDluOG5s?=
 =?utf-8?B?VFM3TS9oV1Zza0xRZ3hzbCtleE1jcTVkczB3SUxZU254ZHgvcnUwSFFVTkox?=
 =?utf-8?B?UWxGZnY2Z0hsNEpqVFdISDFjKzFjNWxuYjQwNG9sV0R5VmpDSXRpRnlvN29N?=
 =?utf-8?B?SjQzeUxodnJ1MHcrQWFZeUcwbDVpSGxEZVJGVEE3cHZRN0E1WE8vM3RUTU10?=
 =?utf-8?B?ZnhMNktFdVdsVnZTRDlWM0FpSkpRN0hTckdnd3JyS0hQbit3alNqZlR6bzFV?=
 =?utf-8?B?eU1MVHlhNWtaTW1DOS9ldE52L2VjWG9ZUlZQaDQvTzRITzdIRU0ySFRXT2dZ?=
 =?utf-8?B?eDI2bTIzaVhpRU14ZDh4cUFRRnJSeUROTG1EdVpkZTRjZFcrbnRibWd5bCsx?=
 =?utf-8?B?NmttT3lnQXFnY3FKZVl2am1jN1VrQlkvTTBub2pSSzBKNUVERnlHQk5Cbncx?=
 =?utf-8?B?cjBteFB3aTdMQTRoZldwSkFtQXI5MEE2MFpPRytZcnVxdWZvWlhBdDlOdUJM?=
 =?utf-8?B?anR6dDU0Q0NEU1JmamtvOG91eFFaVldzRFMxZ2JnZ1lEMlNocWd5WEtxZ1BN?=
 =?utf-8?B?TlVnY0NPWG5KMTd6dUUrUjdpVzdYdW1iT1dTSEE4ZkZHQVZwRTdTaEhjZzc4?=
 =?utf-8?B?N0Uzd1lySHFweVR5S2pHV0pVVHFDb01USVpIOEsybmNOSEZPVGgzZ2pZdHRr?=
 =?utf-8?B?SysrVFpTUXA3R2tIOTMvRGFvaUxnRGtEaWpLbVg3c0cwTjNGM0RyQVZOZmhv?=
 =?utf-8?B?ZzNYVitZZk1sZW9aOXhRdGRIOXZaZmtXbjB6NCtOSjdtZ1Nha1lCb01QM1k5?=
 =?utf-8?B?Q0svb052cTFjSXJwZ21RWVUwMkxKREtWTVluMlVKWThiQ2NmUVlZYWs4ZmRR?=
 =?utf-8?B?bFdiNW0wUkE5ZVJZY0FCa2hEek1XVzIrS01XdDZKdHB3Y09qZ3JkdG03WFJU?=
 =?utf-8?B?c2xjQmZKd1hYMTZKMWc5K0ZZMklETWhOSTlaYy9yZ3hVQXNNSU0rVkxMckVH?=
 =?utf-8?B?RUdKVFBFS1VIOE5kdkFlRER3aEVJMEdSbm14S1U4R25hNlp1MWRkNGhPbUFG?=
 =?utf-8?B?NTZlQWJJeHlJNHlyNFRBdkZNaGg5S2VaekZBb01FTmJIc3ZUSGtQY0hLVVlQ?=
 =?utf-8?B?S0VhbFVOODdCNWRoVS9LYzU3WnJ0QWVmbVVpdFFxc0ZnZ01UbzJ5VEhJYWFY?=
 =?utf-8?B?NXRqY0paSnNpa3gwMUNYWGRNNFR3ZXk5K0NYUk9yWnV0MTVrRkFSajJXaEJX?=
 =?utf-8?B?TzhDeXlTVzBJaXMwVnV2QUdOMjcxYms3ZnlBcXozazNDQlVyNXE0dHRWM0c2?=
 =?utf-8?B?aWN1ODVMWTNWSk1STzgxb1FxbU90NngzTHJYeG10MDBvR0xrenJRYmVheE4y?=
 =?utf-8?B?RVpQcTFPd3AwR2pWOGpQRmRIUGczdVZaUXVXaCtyczl0c2FvN1F4aFhieUN5?=
 =?utf-8?B?OEhtYUJUM24va3loY204amtyV09rcFFUK3ZoS3FDbnQ1dmJSQ3NEZkVTbnZQ?=
 =?utf-8?B?NVIra0Z0RGs0UTVzSnBWT0JUZUs3Y2t5YXRaRytyUWhWYlRCdjFBalg0U2Ju?=
 =?utf-8?B?cmFQYWpSOUcrcXlzZW9KSG9YZS9oN2dQZlVraW8xNEthei9ib2lBbFJacUZQ?=
 =?utf-8?B?YUxjNFRXcEpUWld1VmJYWjFtelpPaUx6K2svZnV4Q2JEcDJvQmpTNmdBSHRm?=
 =?utf-8?B?V3dKdzhMeld3b1lHbmJlSHlUSHE0VGZ1RzNRZ2dJVVJPRXUydUlmUDZLa3g2?=
 =?utf-8?B?V2FUS2xuQ292a0JiZTB3QlpHWFgyMWJaVkhuS0pSMG5qMFM2MXU4aE5EaGJO?=
 =?utf-8?B?RThKN21qN0FBZERNM2RIWXc2NmhYeTJiMEY2U0F4UEQ5TG52WWk5NWtJRERT?=
 =?utf-8?B?dktZSk9jZ2pUWm5lTkR3bFdQc3BGaGhpR1dFTER3ODV6a1pTVFVHMkRoVDhp?=
 =?utf-8?B?cCswOTFoeTBrdWlsZEZVT1JmRERsdXRtNEZKZ3c5WXFiZC9Deks3TGw4VG5X?=
 =?utf-8?B?bEJBNjdnbXlKRU9MZjJVeE0rcmo5dUZnbWs0dUJTQlptSFg2NWpYeGp5aWJr?=
 =?utf-8?B?SzBzOTJ0c0hnNkVHdFZ4V2tsL2YwOWlqbWhvVk1qUi82c2kxQ3JRZVNWS2hX?=
 =?utf-8?B?RTc2UkxmODE3b0NPa3BHc3NkeFMyeS96WkowWmhDQTlFMmtCU3pDMzFyMUlS?=
 =?utf-8?B?em9uNlZWMExtT0ZTaWNJOVlvNnJQWHd6dXFTRG5nKzh0cDlxZFJJL2VrNkdZ?=
 =?utf-8?Q?dmxOAGHUbInOVLxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: itRES7JJZqFul0XVUudXyAhgqEsfv1TvCnrQYZxFRFJhcwRiv4cADe9AoNgpQ0WkH13gVpJYxE8WEBBuwT24O5FL4u1uE5T1vgfu+dSmcx8cCwv+fl8pPch/GMdJ9mmG6mQnIB8W6isZq1sNY/t0HFs+NgeV2JFc4JtTIUPdEF84tRropA/c5kVSIeft7R1CdrGNx+uji9cx0urVlpZFopC4QEfKAQIGkTui3g7+m6SAq/ijdTZQ/TEyKdNyiDPqkskZ2rYTketuH/0LpFTx0zwlALTeG74QEXtmXKbBEKBFqDtQz40RO5WzTAsJ0XAnR4jH0kZq2qMeNk96rr1X9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8c249c-ab0c-44e5-4e34-08de9bdcec8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 17:23:49.6794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb9RYRuKdmhUDFu40s68t9O+1scEXJz65nsC/uYc+cLrCDMznGCyTX+0tJuX31IBF2CLqw7v44+i1JiM+RnBcKlpkTl8qpOOW+V6OCfFoQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF240F42FB7
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,PH0PR11MB7522.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 03B14412B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCA4LCAyMDI2IDExOjQ3IEFNDQo+IFRvOiBOZ3V5
ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBJbnRlbCBXaXJlZCBM
QU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPjsgS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBNaXNr
ZWxsLCBUaW1vdGh5IDx0aW1vdGh5Lm1pc2tlbGxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50
ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5ldCAxLzRdIGljZTogZml4IHRpbWVzdGFtcCBpbnRl
cnJ1cHQgY29uZmlndXJhdGlvbiBmb3IgRTgyNUMNCj4NCj4gRnJvbTogR3J6ZWdvcnogTml0a2Eg
PGdyemVnb3J6Lm5pdGthQGludGVsLmNvbT4NCj4NCj4gVGhlIEU4MjVDIGljZV9waHlfY2ZnX2lu
dHJfZXRoNTZnKCkgZnVuY3Rpb24gaXMgcmVzcG9uc2libGUgZm9yIHByb2dyYW1taW5nDQo+IHRo
ZSBQSFkgaW50ZXJydXB0IGZvciBhIGdpdmVuIHBvcnQuIFRoaXMgZnVuY3Rpb24gd3JpdGVzIHRv
IHRoZQ0KPiBQSFlfUkVHX1RTX0lOVF9DT05GSUcgcmVnaXN0ZXIgb2YgdGhlIHBvcnQuIFRoZSBy
ZWdpc3RlciBpcyByZXNwb25zaWJsZSBmb3INCj4gY29uZmlndXJpbmcgd2hldGhlciB0aGUgcG9y
dCBpbnRlcnJ1cHQgbG9naWMgaXMgZW5hYmxlZCwgYXMgd2VsbCBhcw0KPiBwcm9ncmFtbWluZyB0
aGUgdGhyZXNob2xkIG9mIHdhaXRpbmcgdGltZXN0YW1wcyB0aGF0IHdpbGwgdHJpZ2dlciBhbg0K
PiBpbnRlcnJ1cHQgZnJvbSB0aGlzIHBvcnQuDQo+DQo+IFRoaXMgdGhyZXNob2xkIHZhbHVlIG11
c3Qgbm90IGJlIHByb2dyYW1tZWQgdG8gemVybyB3aGlsZSB0aGUgaW50ZXJydXB0IGlzDQo+IGVu
YWJsZWQuIERvaW5nIHNvIHB1dHMgdGhlIHBvcnQgaW4gYSBtaXNjb25maWd1cmVkIHN0YXRlIHdo
ZXJlIHRoZSBQSFkNCj4gdGltZXN0YW1wIGludGVycnVwdCBmb3IgdGhlIHF1YWQgb2YgY29ubmVj
dGVkIHBvcnRzIHdpbGwgYmVjb21lIHN0dWNrLg0KPg0KPiBUaGlzIG9jY3VycywgYmVjYXVzZSBh
IHRocmVzaG9sZCBvZiB6ZXJvIHJlc3VsdHMgaW4gdGhlIHRpbWVzdGFtcCBpbnRlcnJ1cHQNCj4g
c3RhdHVzIGZvciB0aGUgcG9ydCBiZWNvbWluZyBzdHVjayBoaWdoLiBUaGUgZm91ciBwb3J0cyBp
biB0aGUgY29ubmVjdGVkDQo+IHF1YWQgaGF2ZSB0aGVpciB0aW1lc3RhbXAgc3RhdHVzIGluZGlj
YXRvcnMgbXV4ZWQgdG9nZXRoZXIuIEEgbmV3IGludGVycnVwdA0KPiBjYW5ub3QgYmUgZ2VuZXJh
dGVkIHVudGlsIHRoZSB0aW1lc3RhbXAgc3RhdHVzIGluZGljYXRvcnMgcmV0dXJuIGxvdyBmb3IN
Cj4gYWxsIGZvdXIgcG9ydHMuDQo+DQo+IE5vcm1hbGx5LCB0aGUgdGltZXN0YW1wIHN0YXR1cyBm
b3IgYSBwb3J0IHdpbGwgY2xlYXIgb25jZSB0aGVyZSBhcmUgZmV3ZXINCj4gdGltZXN0YW1wcyBp
biB0aGF0IHBvcnRzIHRpbWVzdGFtcCBtZW1vcnkgYmFuayB0aGFuIHRoZSB0aHJlc2hvbGQuIEEN
Cj4gdGhyZXNob2xkIG9mIHplcm8gbWFrZXMgdGhpcyBpbXBvc3NpYmxlLCBzbyB0aGUgdGltZXN0
YW1wIHN0YXR1cyBmb3IgdGhlDQo+IHBvcnQgZG9lcyBub3QgY2xlYXIuDQo+DQo+IFRoZSBpY2Ug
ZHJpdmVyIG5ldmVyIGludGVudGlvbmFsbHkgcHJvZ3JhbXMgdGhlIHRocmVzaG9sZCB0byB6ZXJv
LCBpbmRlZWQNCj4gdGhlIGRyaXZlciBhbHdheXMgcHJvZ3JhbXMgaXQgdG8gYSB2YWx1ZSBvZiAx
LCBpbnRlbmRpbmcgdG8gZ2V0IGFuDQo+IGludGVycnVwdCBpbW1lZGlhdGVseSBhcyBzb29uIGFz
IGV2ZW4gYSBzaW5nbGUgcGFja2V0IGlzIHdhaXRpbmcgZm9yIGENCj4gdGltZXN0YW1wLg0KPg0K
PiBIb3dldmVyLCB0aGVyZSBpcyBhIHN1YnRsZSBmbGF3IGluIHRoZSBwcm9ncmFtbWluZyBsb2dp
YyBpbiB0aGUNCj4gaWNlX3BoeV9jZmdfaW50cl9ldGg1NmcoKSBmdW5jdGlvbi4gRHVlIHRvIHRo
ZSB3YXkgdGhhdCB0aGUgaGFyZHdhcmUNCj4gaGFuZGxlcyBlbmFibGluZyB0aGUgUEhZIGludGVy
cnVwdC4gSWYgdGhlIHRocmVzaG9sZCB2YWx1ZSBpcyBtb2RpZmllZCBhdA0KPiB0aGUgc2FtZSB0
aW1lIGFzIHRoZSBpbnRlcnJ1cHQgaXMgZW5hYmxlZCwgdGhlIEhXIFBIWSBzdGF0ZSBtYWNoaW5l
IG1pZ2h0DQo+IGVuYWJsZSB0aGUgaW50ZXJydXB0IGJlZm9yZSB0aGUgbmV3IHRocmVzaG9sZCB2
YWx1ZSBpcyBhY3R1YWxseSB1cGRhdGVkLg0KPiBUaGlzIGxlYXZlcyBhIHBvdGVudGlhbCByYWNl
IGNvbmRpdGlvbiBjYXVzZWQgYnkgdGhlIGhhcmR3YXJlIGxvZ2ljIHdoZXJlDQo+IGEgUEhZIHRp
bWVzdGFtcCBpbnRlcnJ1cHQgbWlnaHQgYmUgdHJpZ2dlcmVkIGJlZm9yZSB0aGUgbm9uLXplcm8g
dGhyZXNob2xkDQo+IGlzIHdyaXR0ZW4sIHJlc3VsdGluZyBpbiB0aGUgUEhZIHRpbWVzdGFtcCBs
b2dpYyBiZWNvbWluZyBzdHVjay4NCj4NCj4gT25jZSB0aGUgUEhZIHRpbWVzdGFtcCBzdGF0dXMg
aXMgc3R1Y2sgaGlnaCwgaXQgd2lsbCByZW1haW4gc3R1Y2sgZXZlbg0KPiBhZnRlciBhdHRlbXB0
aW5nIHRvIHJlcHJvZ3JhbSB0aGUgUEhZIGJsb2NrIGJ5IGNoYW5naW5nIGl0cyB0aHJlc2hvbGQg
b3INCj4gZGlzYWJsaW5nIHRoZSBpbnRlcnJ1cHQuIEV2ZW4gYSB0eXBpY2FsIFBGIG9yIENPUkUg
cmVzZXQgd2lsbCBub3QgcmVzZXQgdGhlDQo+IHBhcnRpY3VsYXIgYmxvY2sgb2YgdGhlIFBIWSB0
aGF0IGJlY29tZXMgc3R1Y2suIEV2ZW4gYSB3YXJtIHBvd2VyIGN5Y2xlIGlzDQo+IG5vdCBndWFy
YW50ZWVkIHRvIGNhdXNlIHRoZSBQSFkgYmxvY2sgdG8gcmVzZXQsIGFuZCBhIGNvbGQgcG93ZXIg
Y3ljbGUgaXMNCj4gcmVxdWlyZWQuDQo+DQo+IFByZXZlbnQgdGhpcyBieSBhbHdheXMgd3JpdGlu
ZyB0aGUgUEhZX1JFR19UU19JTlRfQ09ORklHIGluIHR3byBzdGFnZXMuDQo+IEZpcnN0IHdyaXRl
IHRoZSB0aHJlc2hvbGQgdmFsdWUgd2l0aCB0aGUgaW50ZXJydXB0IGRpc2FibGVkLCBhbmQgb25s
eSB3cml0ZQ0KPiB0aGUgZW5hYmxlIGJpdCBhZnRlciB0aGUgdGhyZXNob2xkIGhhcyBiZWVuIHBy
b2dyYW1tZWQuIFdoZW4gZGlzYWJsaW5nIHRoZQ0KPiBpbnRlcnJ1cHQsIGxlYXZlIHRoZSB0aHJl
c2hvbGQgdW5jaGFuZ2VkLiBBZGRpdGlvbmFsbHksIHJlLXJlYWQgdGhlDQo+IHJlZ2lzdGVyIGFm
dGVyIHdyaXRpbmcgaXQgdG8gZ3VhcmFudGVlIHRoYXQgdGhlIHdyaXRlIHRvIHRoZSBQSFkgaGFz
IGJlZW4NCj4gZmx1c2hlZCB1cG9uIGV4aXQgb2YgdGhlIGZ1bmN0aW9uLg0KPg0KPiBXaGlsZSB3
ZSdyZSBtb2RpZnlpbmcgdGhpcyBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbiwgZXhwbGljaXRseSBy
ZWplY3QNCj4gcHJvZ3JhbW1pbmcgYSB0aHJlc2hvbGQgb2YgMCB3aGVuIGVuYWJsaW5nIHRoZSBp
bnRlcnJ1cHQuIE5vIGNhbGxlciBkb2VzDQo+IHRoaXMgdG9kYXksIGJ1dCB0aGUgY29uc2VxdWVu
Y2VzIG9mIGRvaW5nIHNvIGFyZSBzaWduaWZpY2FudC4gQW4gZXhwbGljaXQNCj4gcmVqZWN0aW9u
IGluIHRoZSBjb2RlIG1ha2VzIHRoaXMgY2xlYXIuDQo+DQo+IEZpeGVzOiA3Y2FiNDRmMWMzNWYg
KCJpY2U6IEludHJvZHVjZSBFVEg1NkcgUEhZIG1vZGVsIGZvciBFODI1QyBwcm9kdWN0cyIpDQo+
IFNpZ25lZC1vZmYtYnk6IEdyemVnb3J6IE5pdGthIDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9wdHBfaHcuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBT
dW5pdGhhIE1la2FsYSA8c3VuaXRoYXguZC5tZWthbGFAaW50ZWwuY29tPiAoQSBDb250aW5nZW50
IHdvcmtlciBhdCBJbnRlbCkNCg==

