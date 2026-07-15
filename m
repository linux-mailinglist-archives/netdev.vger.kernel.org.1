Return-Path: <netdev+bounces-307627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id REBhAgHVVmriBgEAu9opvQ
	(envelope-from <netdev+bounces-307627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:32:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91740759B6F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:32:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CuVQD3WY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307627-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69B83004F3D
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44911A01BE;
	Wed, 15 Jul 2026 00:31:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A646B5
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:31:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075518; cv=fail; b=QOxUSVrLp3kt5BZJVeR6lHQVDzPA+PaUNXQBr290FrMjr1Z9RsAFI4GpFHTittQe73s9jdKmTHx5LH71Zq+DvQDg1Ge0A0eV2Z2Rguswa1tU7UuYqmF6KrtzQyvgQBqE8lVABXLrliaYa2Fbl4/INBLIJFi/9H2cXTZIsbVk6ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075518; c=relaxed/simple;
	bh=lL2dAajO5cPHfcwY30yvLEwYRo73oTDW4n4aETyqTXk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovalNBY/wXvnEZwcvPuYcY3QtQEAxBOKcwtL9Fm5qoqklSZ1UBOJmueoqpf90hIjN2Hs5o6JDgOjVH7nhPy2o0x2J3/uDk3rznx4fR0Y7jYb7cU+2LKhlXSH3NsJqlW/L/I4rmr9qSGpZXuKIhHU6aDdUAd8eNVXE5IKapiDhZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuVQD3WY; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784075514; x=1815611514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lL2dAajO5cPHfcwY30yvLEwYRo73oTDW4n4aETyqTXk=;
  b=CuVQD3WYlhp8qdLQxK6WjQhquhCfcdCvPRpYj7gMk0kT57ERJpYRvCei
   SuEjZKFx80UCb9uTM+M4JgFG4igYmmAeskyIYdaD10uhsKgwz9W41XsOj
   GpiSjIV8+X7M+i13A1GTs2TEOFh8jcfEvce3YCKpKTVstt1fR3UPjs0x0
   wKgfA4suOLsdh486jlm5FghaJv0ZMQGPSSbtJejJrZwVRfeNLEtt0uaAf
   3dcB79bJUYB+TL5Faa92qEWSqUVNlavsiosC3G84TSkYdKqiaKYmI2Pla
   ByPoiWRN/GmpPMZbKrEZEizaL3kcgAw2hZ6Odmrh/3ydaBPnmSqLa62Q6
   Q==;
X-CSE-ConnectionGUID: p7VZONSJS1GkZhPVHjTNgw==
X-CSE-MsgGUID: vs0uKgtlQmCfZh65lnkmXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95306690"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95306690"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:31:53 -0700
X-CSE-ConnectionGUID: Y1PBJO5BSWiJVc77DG5qaw==
X-CSE-MsgGUID: 6bPYBm4gSimm82ieHxJ6iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259585362"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:31:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:31:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:31:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVGmfrsIaiP9CuhO8e8VfLQFjMDgefN/cmqDR1xU9O/rUrasL0TvGXyYJgFlI40w2tZ2obOfH5LMP44yxjSY82w2AboXADmNtefAV1855RGDkxJOMPK0+No5vi3I77u70TMNkT7+vR4+/hLVVX4SI0gL7jLaKtEPDBRNXUGjc9yfurzZp2BDrbiVv3A6SLLIAFP7scKVoZf2ww3aSvYbFg8KYkYO9wGTYB3vqVHGkE/bbOrWzdDvwGFWVCL8/Sen3WQwKFwl9BGbU17rTEydAjBjm82j1o62B3PPRc1ZSVdNa2o6b3NxeJDvLeIXQgYliu0v4VtZ3GmaKOD20wNTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhzMgRDoz3upBw9pQx3Q7D+3tiLnT4fChUhxA2tvfR4=;
 b=ycXcjxVqYUOjR9eLrtMqBDYWxQJPYZ4Dj6Li/SXYE0wToHXzFWWd9PckN5qytBlm3KIVtmlqSWNuCrJm5H3rQdycU7qhU7MrXCNX0ZOu8kreFvtUESfUXONLPVyM7PN9EJJp6ZgPvKdRkFeY8nQ4MpihWFUWZT0Ed4EEhdPuvKP70Cj4M36Q+cTrvt+CMb+K9g3HdILz7XLk5l4UJ68WlLP6SRhlONzt4seQd52HHA27f1+mcImB/OuS0ABQkMyRDzuwEtT+QbEFQl8VtEPEoOSVu4a4eH8rplG9nXohmaLTPZC9EfYaZlC1DBhFc4p15kigdTk19UyYiCJwP3CM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 00:31:44 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:31:44 +0000
Message-ID: <cd326f52-274c-456b-aa67-75ff8cc3500c@intel.com>
Date: Tue, 14 Jul 2026 17:31:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: txgbe: fix heap overflow when reading module
 EEPROM
To: Chenguang Zhao <chenguang.zhao@linux.dev>, <jiawenwu@trustnetic.com>,
	<mengyuanlou@net-swift.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>, Chenguang Zhao
	<zhaochenguang@kylinos.cn>
References: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: acfa1038-af5c-4488-f24f-08dee2087275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BKKh1fj+zTuPmnHTBZAfnprEYto/BPxWXmS5cdMQQ+jJKBqOBNiy1noHi89QyCNFpHqvtoKmaa1PWd9rM8RXctkj6EWg7xXExBdC3F7GzIrFvwO+VFlXxf3nxRx+svK+sgo2qEhCMBZ9A1p+aHNBx4tGW6+s9JqRBUXB46tkyNwB9m1ZEfTaNXIJTfiWSauYEOmsWO0EOMdMlio7A1UJ6Spf631Hn8NyYZlmIoVxk3Qn+en6k+gJAkZglP/qD2TCD0NOydfxIQawES3NgFVl9K/4QYGBiEhABbmlnTMDwkhZpPQ2TjkWmNpYMZTbztXyaS+V+DYODGPg8LSlLfNc4ri92rhO6GuxRVo+dT6iA9rACNzdA/LgQKaL4a7AVuFJC5oJKQB17PgmGts0/JTgSfT+fAVcLd42DGl8EdcukpQSC/CR0Uh189E/QJV/pXI4D09sUf3BL1YWPvHeMg9OKGlMEdFFuJyD/PkQd65l08/1yEl4IcnT46Lc1Our6Kvi41ori+UrxkSLc7BUtkEZPOBHVRH3675WQCrAu0L/YK2TVuHM3kQ4GlxvUuCZYS7+13UobJs6XoXdDNEdTiBuh95h2FsVQyg9IYi+Qj6JDwZ6CTIpDoeEPZQJcajpoW7oOVWAxJXhJG2RDfj7DQM4CYJ0ZqKa9qQqSRoHVUn0eCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T00vRyt1UWNjL25KbjZmWXNwQndsK2VWKzBBTHp5ZXJFTmdLQkNVMjJBV0la?=
 =?utf-8?B?RnNVRFJzNC9WejdEOWlWUjF2U3h1bWd0ZWEwUTVNSElRS2hEQ0QzVG5BZ0hC?=
 =?utf-8?B?Y0FvQ2t1UnlSc3BrZ1pYU0JsZkVab1RCbERMRFlVc3E5SUV1ZG0wZ1dXNksv?=
 =?utf-8?B?Ym55SXZzTndMcGE0VERrVC85eWVjOU5Tb0JqQVNZMlRCdTN6bExkaC9ub2h1?=
 =?utf-8?B?eE44Smk1V3FiL2RJWXZHUkU2OTBVZnJjYjA5aTAwYWRZa1VuejEzb0pWK0dn?=
 =?utf-8?B?SXgzYmhrU3BUdm01K1JaK0xmaGFwRE5pNVMyNVIxZFVyb0lPUWt6SWlQbWtV?=
 =?utf-8?B?bS9qT3ZXKzJ2UXJ0d0pJRDlRcWNqUmoxNVREVjhDM005Z3B1d2FqUUJ1R1Vx?=
 =?utf-8?B?TlRWcVl4a2tVODY2bytEaXBBQ3lFMGNYVnVSanF3MVc2Ykhxb0UrWmFFRjNq?=
 =?utf-8?B?R1NTeEl2cFBYS3Y3dktGRUpkRWRCSEZ4czNQM28xcldFc3F3cDZzY2FFVERM?=
 =?utf-8?B?NkFSZi9KMklSVWJuQ2grV0FlL0NDcmxMc1ZSNFNBeGJoUVNyMXo5SmJ5S2dj?=
 =?utf-8?B?Y3dUM2FudjhhS2FtS240OW9sRDVVTEg3eUhJMG12Q0c1bmpwMjdXNzJpbnJp?=
 =?utf-8?B?VXNuNmxjMUxiY1JnY1cyK0JrMjJHcTIzREpBMldCd20xSmJHZlVQL3A4SDAv?=
 =?utf-8?B?aGxSWGNZWW1iZXlQVFJPZUtEa2hkNFQ4bGZ3YnJYTk15dXhTUmZsUnd2WWM0?=
 =?utf-8?B?cDhsOWY2bHl0NStyNGdUb2FlZFRvZm50aE9laEVwcE1mbFBuby8wckFBM28v?=
 =?utf-8?B?T0U0RmdlZ2pqSDZYWXFsZjlDaE5MWm1MUjRrbEVneko3NWVEcUpVV0luTGFN?=
 =?utf-8?B?UHhyVEtyNy96aHpsK2hZaVNRandyeEtqTjhHUTgzQ3NVbEt6SHdpUXJYb09k?=
 =?utf-8?B?cVNpVUc3UU9ZNG9hQ1V1b3dzQ1dkYlc2bW5wZG1SYW0xTDZtY0xMeG5xRVZH?=
 =?utf-8?B?RGh1YjJFM2x6UzVZb0Fnd09DVy9lcGsrcjI0aU5lSG9yWjd2YkVkcDJBblh1?=
 =?utf-8?B?YVNXMlFpM3A2eWJjaElXcmpLUlJhQUFpNGdZVEJCOVNZa29HVnNNblVmd3BL?=
 =?utf-8?B?Z0x0dlgwY1I1dUMrUDRmQXJEcHcwZzZLTEFNS1NpSXVrT3NUMHUzT2c5OUhx?=
 =?utf-8?B?UElYYVNYQitRNWhSamJUNEJrMlRSMzFkYVgvZDNkbG56WEsxRHFoMTZ5cjZi?=
 =?utf-8?B?c2oyREUzUzg5bmNUc3JUdUp2NkxLOEozQ2svMTJOaXdwM2w3WVJzbzdiS0tV?=
 =?utf-8?B?djFOeHZLL0lzT0Z4WDkvZktJdFRlbkxBdndpaDd1cGVFM241YWlGcnJrZGpI?=
 =?utf-8?B?SUF3d3IvN3ZTQkFXc1p0SlZxL3Y0T1BRU01vSVhncnY0TGFMb3BQR3RoSzdL?=
 =?utf-8?B?YXhLdndueVQwNVhZWUU2UWN2SGVjc216b1lHQ0lGWHYvaG5LY2QxN2MwYzhC?=
 =?utf-8?B?cUhoNm5EazlSN2w1NjZhZmdxdmhMaHBDSTBUWjAraUhuTWZvc1ZjVExZL3Fh?=
 =?utf-8?B?N04zTDJraEF2Y0RRT29wUDN1eU0yaGZoK3pTNjZiekw3QXNQbndqSFh2YWp6?=
 =?utf-8?B?dHJGM1dlMDZ3ZGVjTWxqV3lJRVlzbVcxdXppdjRocVZzNGZ4UkZNaUpPcG02?=
 =?utf-8?B?bitpTk55SitPazJuMTRBVmM0azZQaUZqeUU0L3hhQm5Obm1aR01qQjc3OVFI?=
 =?utf-8?B?Zlh6UnhZKzZaNUFSRlVDRWQ3NWVNWGVEeUF3cFBveUpNNjJvOWYzZFUyb2xE?=
 =?utf-8?B?RU5ka2ZweU5wbUxpMFhmbVhtQy8wR1pBbEh5S2JVUFI4UVdOdVBMNDlraUhr?=
 =?utf-8?B?Vm1WWFpMVWJobUw0RWpWUXdQN1drRHR0dGltU0ZBS0U0QjcyVGxpYjhBMmlu?=
 =?utf-8?B?UGxBRFBGSkR0cmJJZDJic0Iwcy96V3N3UGZIT1VZS3FvVkVaZFZxaHI2K3FP?=
 =?utf-8?B?SVZIcElsUC9RV2lSVmRlcWtSVjZwK2phTzJZWExIQWd3L3l5SGcxWld2Wnh0?=
 =?utf-8?B?RThMb1c0N3hobFV4dEhTR3djT2FDRys3UEliSi9Hd1ZyNU5EazFaM3RxMERn?=
 =?utf-8?B?dUkzMlFKYmlBK3JaZSt5NGtLNXlXNDhSbHFVb214eFJOSXV5TXZyL2NJeWt6?=
 =?utf-8?B?bU5lTnc3ZTlHSGE5dDhpamJzb3pSSlprMHRzVDdLSS9iWWtaR21CM3UvZy9H?=
 =?utf-8?B?UFU5RmdQTlNQYXU2Q3ZaY3NZTE1XcU9Kblg2czVJdU53d3lRcm5OMVpvVnlY?=
 =?utf-8?B?bHlVcTU0MEhnNGVjN05YZ1VUYzZTQ1dwS3p2VHZiUXJ4S1lLZFV5QT09?=
X-Exchange-RoutingPolicyChecked: r7IK48Q1wFktL+ZLMCewApKb1lHAe4sw7i/oK8gp2DRqzpmEhOrFuJoS7AyO5irKMV1hO9yThZ102iYutPuDj1Oi+p8EODyoyWcFnACZcbow1ZDZAQcCVIb5IYB9HCQxMnucvA5CKKxFhrjsC4N/XGvWzQZaAbucoBRHWW2cA8hYpjuE9t1BBWzzxbdlu8hjPQbUDvmJaBvt4crKxm7OyayEZisMMizuSo7/WYl9fH2esFU6Q9wqXgQiGR++MBBxglLZ13wQff8Ebe31SXVSNcuT2V+s2WVULek7x2sIgaeAhnbulJuAPsNHJ0yzCY1MzRF5RTpV+/uqECFuuf4X+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: acfa1038-af5c-4488-f24f-08dee2087275
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:31:44.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK+po1ptVyRjDPzp8iVZySHFWG1fbcVMpWI+vEzpewaJ3eoUssVhIPmQtHmuLikxeD3YFXhk0GaMn0bz40enGYamljDNDm0sbmkBmaludxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chenguang.zhao@linux.dev,m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91740759B6F

On 7/13/2026 1:51 AM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> txgbe_read_eeprom_hostif() always copies round_up(length, 4) bytes
> into the caller buffer, which ethtool allocates with exactly 'length'
> bytes. A non-4-aligned length therefore causes an out-of-bounds write.
> Copy only the remaining bytes on the final dword instead.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index affea1a364ef..26d0cfc58ee2 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -96,11 +96,13 @@ int txgbe_read_eeprom_hostif(struct wx *wx,
>  	dword_len = round_up(length, 4) >> 2;
>  
>  	for (i = 0; i < dword_len; i++) {
> +		u32 copy_len = min_t(u32, 4, length - i * 4);
> +
>  		value = rd32a(wx, WX_FW2SW_MBOX, i + offset);
>  		le32_to_cpus(&value);
>  
> -		memcpy(data, &value, 4);
> -		data += 4;
> +		memcpy(data, &value, copy_len);
> +		data += copy_len;
>  	}
>  
>  	return 0;


