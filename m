Return-Path: <netdev+bounces-290793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B0rKx1EEGo6VgYAu9opvQ
	(envelope-from <netdev+bounces-290793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:55:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C75B34F5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 921AF302CDB1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98D3E9C06;
	Fri, 22 May 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb2rjwSs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F43CFF5D
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450224; cv=fail; b=MoDt+pnwycEb61LyhZatm6B7c2wBmDJUvd5g6/fFbYPyje6I3z65PKdKoaJ5i17Xcx4oWOVHyKqmZ32igxF9G53TfksBaKOrcdVWgpXu5ufATk3NmC1FtQlJN09JivalS9SzupJdzq3ROR3ka0nUnuradFurRKSnfA8lthYdNcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450224; c=relaxed/simple;
	bh=b2rJ4Fh89D9TUq/v/xjG2DlzAMguIZa/kL0KQV9abqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+BWPu5RaCNGcA1+Pbq2uyYtmtmRBuOYrBWJs0vBqjVXIcOMbc0qRryPekbgvLELq73SwgA8XapYYTQdL7HZvM7tuKGhDJe7He+bspFZGWuc6QNex5fCwXWYMmrsI7bS+hSB1ddacHJi8mR1FZZt6NWVrp6M7Ryo4sexBDxuOh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb2rjwSs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779450217; x=1810986217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b2rJ4Fh89D9TUq/v/xjG2DlzAMguIZa/kL0KQV9abqQ=;
  b=Bb2rjwSstyvZbfG/dg83C5LIdaD1T1sY2aGygZqcCMWWu2PtlI2/3N0B
   t1Uvqdik1mE8T64nA6refE+Uk9ZiGZ3pVOTIHbZhS8J1KNRNCDOS0xmZ9
   zgX8Rl6gyPZX9njBUmGyyQlVwFRvXs9qy1eAI+q3wu6F6OhumE6GYCve2
   oDSf0Idg0MF0TuyV9hHjnQtU8UhFW/mX8RBdeTuntXKaOfB7vnLla3GiU
   8mVKrSbgaH0LipfJwehTppx9JGLfC8j7W2m0LUXXio2dcHx8uSDynHRfK
   2IzQb7GMOtd8CHvpZIYjQd/X96RD/YdDQwfCEhiSZTsZsufDcjHGwMZeS
   g==;
X-CSE-ConnectionGUID: LZjWZgoUTG+je00edoFOFA==
X-CSE-MsgGUID: TMnt986sTwSTRAtL+J6XOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80347967"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80347967"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 04:43:31 -0700
X-CSE-ConnectionGUID: 0S0w+XJpTeyEOVWLfxWOqQ==
X-CSE-MsgGUID: zMxL0FvsTnCt4boFw1CO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="237851800"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 04:43:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 04:43:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 04:43:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 04:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5+eUMels4UuTWLyKEqFg6jAO45DDBm6NY2GK4Ji1BlWSy3ji4iceClt+S+6SVlxxuIeIRYFIutQPoOXy4se+j/FXs9NoG1kj/RIO1JSi1Ptcpg12DIgHpWJJZ/c7qCoP58mVKpKLdiRxx1HmZpNatGXijG96n/EzbsRfTT9sTjirYXpRxWaJlDkhpGNSXWeLkdrzPtoiR72/4AAdaioc8H4h+EAHIi4Z21Q5CRQ1bKStbZPngCk1Sd9fuy3hKcRC1Fd1PQBlNHpqeLD/Muo9q6F3NYG1Az065z8hfpA6RqruTBg4ZEbg+Hp3tEMh1I+2218FhtHnYgfKenuOR0NLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2rJ4Fh89D9TUq/v/xjG2DlzAMguIZa/kL0KQV9abqQ=;
 b=e8BJnWDVbV0fMM85m6Q+m1OJ4o+1cCYTvf+B0Lz5ZSEk63DKuEkN+wnTK/JqbUBfuIsuGkaZ/VLPQDUT4+N05ZMc84NvJsC273Vbq7qM3gB+K8rD9l8eZRZrwMq72SfWIeyUj3jMBPmxECf9uqtQPioXQEH3xTeuW5aO442fCvlE6FhrrM2A24uVBfqJVVaRZCFwM9NwWOxzKbRaSBDPhb35rHfa8O8nb+piKRo/eKw/rVEtLt5isSOuvJKNLoLMKCctyfugBteMm6RbvlbHYc0vWvRo3og9lTYWCDHhdxjhqzhftbycz1qW8m2gEyoPGnHd3LtgVg/QuwkpaI5zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 11:43:21 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%7]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 11:43:21 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC: "e1000-patches@eclists.intel.com" <e1000-patches@eclists.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Ilichev, Konstantin"
	<konstantin.ilichev@intel.com>
Subject: RE: [e1000-patches] [PATCH iwl-net] idpf: add padding to PTP virtchnl
 structures
Thread-Topic: [e1000-patches] [PATCH iwl-net] idpf: add padding to PTP
 virtchnl structures
Thread-Index: AQHc6P/dZ9wkiKkKcEG0ieF3El4ozbYZ66MAgAACqpA=
Date: Fri, 22 May 2026 11:43:21 +0000
Message-ID: <PH0PR11MB490458ACBDFC91749DE0E472940F2@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260521085428.117991-2-przemyslaw.korba@intel.com>
 <8096bd0c-5e14-4cff-956d-33ac6b8fcce3@intel.com>
In-Reply-To: <8096bd0c-5e14-4cff-956d-33ac6b8fcce3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|SJ2PR11MB8299:EE_
x-ms-office365-filtering-correlation-id: a84b5755-c10d-4aa4-54c6-08deb7f75315
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|4143699003|11063799006|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: bFJOLAFqyZ3v3AjE4nOUU21dmfSdQERIniepvq0e3bnFJ0otQSOu2oCA6LePNb8B2fnNE+rOuC5aqxTLeDUQSd/IGcavJsLPQHMWNvXdD4yA0Z6EVHmXmI1l/lhq+wVJyYLo0z0WwSqFRP5fjFjhx+5tyqtpQYEMjCZorEgT/bkq7rZMMaRhS37VwDRKO+DeGNXOspGb3oDgMBzFhn2CHuTAU74yJpYZ07CQ339/nl3lFtYiZWoR6RuKU2ZuIB/e8RkXtNrZRjZTyaKjeKh+dn2/DXK4+rFGlQEE9LG/2y6aTqV87XkUki5Iyyi2YjGDNLb1k6eSZUElrOzlKnwLa07W9KiAxHj1qh11bDSMzUTUtuLE51/emsXBYb/suC/mGUQUsUH/T5QGCdAbDowPhd+PLJB4pZTKrbsJtQuR+bt+/sVGtZAyJKH8vJArvexHOO7vzchPhMgSk43whZzS2VlkvhPjKUjKAy9fXI05oti/YeOvvl6gsvJDcPd2qVE4l+KJ558r8RmDO4pHfz9yZ57nndp6e3w02uQi9UT2yPJRVioFj6bcE8nQswKmhfAkgqrWxjG93tCFZWA2a1ipLsH+/Kgk/kVDCyEmPkZtjrwlYbX7ffqirJTQLgau6TzAUKB+v3DVahk6fcWPY3u+qI1jJaI21HjmTt0rFDxjk1Vjz4NsfZIggBGeUNO/O0m2ad084Lrnars39GknqyWr8C/TkAlycGM5gCURO2KRVmSwyFtd8Ys+ZloH2f0j148s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkdIb0lOdlJtUEloSDdJeVVGTWUyMkRNclJpRUJUZDg3dDhyN0U0QlZxMWZj?=
 =?utf-8?B?bWoyVVE2NVZvOWZEaTB2WDlkbzZKUkNFMFNUbE9hbWZLRkRNc285M2lqa0Qv?=
 =?utf-8?B?dG5YNzBWeVZZZ2lGdlNYcGMycXkvYWt2a0NvVlkxSWxFbmZwMmcwd3oycDZ0?=
 =?utf-8?B?cHBQMEd4ZnFtbUNQV0pqeXFwSGh0bi9KV0xjR3ZjU1dOakZFVmp1Kzh3aUpG?=
 =?utf-8?B?RjF1bXpRbVBSYVozSWk3MGhTQXRmMStyMXlURHdnbHNnTjNBS1piZllDMDZ4?=
 =?utf-8?B?Qm1UYm5YUEJqUFBWZEVaREFQWWFubHcrNDhablQ5VmhTRURiaEU5Zy9SRy9G?=
 =?utf-8?B?NVc3a3dJbisxenByelBTb1BIcG8vTTdIcmVtUEQycnFRK2p6RFNNeXhkUHhx?=
 =?utf-8?B?N0phTTkyaGtFdVhwWVdrV3l1U3d3MUJTUENSVmhzNlZRRWtnVDJHa0RkUWUz?=
 =?utf-8?B?aHFyd3N2UWtvWkc2VURqcWEwVGhTSWtxRHpObGFuNWhVSTFLZGVWdnhVR1Vl?=
 =?utf-8?B?OFl6Y1FpSlROYmdRcWNrVytXQ2FaZjBTUlpsVTl1MEMwMldJcGd2d2dER3Ju?=
 =?utf-8?B?dlQ2N1RJUk9WWUliR0NJbnJNNklyM0tiTDVCT2xxeHYrQmxMMG5ONTlIeHgy?=
 =?utf-8?B?eUhiVlZGZXJxclRGc0ZCQW1FSlBXYjZUM3lnSExDN2xiNXFpQ1JBWE9YcDZR?=
 =?utf-8?B?TXFTQUNjbWI1QUgyYnNLaXNjOWVaTDBZVzIxbTByNnZ1UlZ3RWNoaVJrSzFI?=
 =?utf-8?B?eVZyaWY2VERIWjFsMW5LTzRSM3FuUW1vcWlIZmFsVnpPajVNdGthOXFDUzc2?=
 =?utf-8?B?NitBR29VNHo1cno3OXNPYlhaUUlSVFhscEZzdVJOenFXelcxZHA2YzZBaThy?=
 =?utf-8?B?YmpQazVZL0Q2d1IyYUdOem9xWXJ5VFRNaGJKb2lycWNHWXN3cWJhU3V6Z0Fa?=
 =?utf-8?B?bnpnZVZ0YmI3aFlhMDMwYUZsQmlKc1RzdDhPSVB5b0lNd1BvRDNSbzM0RWtC?=
 =?utf-8?B?VmRBRDR3aFJ1OHVOc0tydWRWUHBwdlZXcllLd1dHVGNzK0xnUEFxNjNzQS92?=
 =?utf-8?B?ckxOSTdGVjZqU3hRVWV5N1FWS3NjaG1JZEZ2LzR0c3BOR1RPWTdoNlE3cCti?=
 =?utf-8?B?TmF5dkl0aXdqYkN1WDY1cjdEZXJYa1Z3Y1NodUNIbVpIdFlBUCsveDdWdmxn?=
 =?utf-8?B?NVVBQnVaaTJZMEV5eE5HOUVXZVZUWUc0SnlLZ0gzUmREZCtSMkpzb3VDQVg0?=
 =?utf-8?B?VC9FTDQ5Z2pFMnpGeE05OGJQT1p3RndtSUgzWkxKUy9qeXJFcnExa1FwTy81?=
 =?utf-8?B?V2NLQnVLQTZkajVJdjhkbm1keXl2UDc5ZWU2SU9FejlMZ1VjUU1nUzRtM0Ux?=
 =?utf-8?B?WVBXRDBwejBqb0NqY3dMelQ1eFNucitWalo4YmVOZHRoa0xjdVFkbmQ0R0N0?=
 =?utf-8?B?cWcvbnZlNGF3M0E5NDJDSW9JK3lSOGNpZDhoM3ZiKzhiRlB4aGtNVC9rWnl1?=
 =?utf-8?B?YStyUWphRFJVb0FyWFhpZ2g3MytvUVBUa1hCSHJZb1ppSTRrdWxKelFNK1Nt?=
 =?utf-8?B?RFlrdWhJTk1BTzZLRUZlTmN6ZWhnVXU1eUdtVUNpWGlPeGkvUzJYUUdrSlNE?=
 =?utf-8?B?UG5saW5iWGU1dHJYRDlUYzRBRW12UVkrMGJJN2NDV2VGbW9PQ0QvcFRJU3Qw?=
 =?utf-8?B?Q0RzTTBvemcyNnZBTkxObHQzcitYTDhydWlBSmZoSzE5eVB6UWhRRkxBekxm?=
 =?utf-8?B?b1pUR1kyb3JsRkRNcUpvUTBla05MVjVWeHRHRUhIYmErcWNmaUxDckptRWZM?=
 =?utf-8?B?OUc1YUFNaEFvL1h1N1ZRbjErTU5FRVduOUJ4b21wOEVHcmszajFZWDF1WEsx?=
 =?utf-8?B?YkV6aTdVZ2VJQnRlOG8ySXRrWnBsQW5BWUxaVTNYNE10RFhYcmdOemFGRExR?=
 =?utf-8?B?NGNLSUhGL1picDNxb3FPUmdoRTNKaTJtK2xLZ1lUQVl2SjR5MC9CcjhOenRm?=
 =?utf-8?B?THJNdHRGb3ZoaDdIR2twNFRuYjliWmV5akhuVkZ2anJwSUF3ZmtGMUR5Y2Zp?=
 =?utf-8?B?SFhHcWw3aFd4M1hjL3d0N3ZFbGFUcDBsL09PTkk2UHkyRFBoOWNMZmFDd1dv?=
 =?utf-8?B?ZVRYQTZhNEZZcTB5UXlHV3JvTEx0eGFrZVVjSERDY1cxNHpPOXhHcHc1UENF?=
 =?utf-8?B?Mk1Ob09tY2ZlUVoxZ0xOWDdCMGpOUTdNTWl3TUF2ZHphbk5VSFFzcTN6a2hl?=
 =?utf-8?B?TGdpNDhNcXRZOC9GWjBDZno3VE5mZlp2T1hpcWRhTHNwclVBSjVzcXlhK2JC?=
 =?utf-8?B?dkVJVUhtc0RZaWVZVEdyZVJQUUdyeFlER2ZyMW1DdHlmdmljWk0wYjhCanRu?=
 =?utf-8?Q?ZmRym0gdvZqwAb3yNP88lywy5bSolm+7BvZx6VD0xGc42?=
x-ms-exchange-antispam-messagedata-1: qUPa8gS8KcwGiw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f1on5GBZDtlccQvPEifpqQF/yaOMsW41fO5lD9deST+zlleilFNP74MG1Zpyv+RTph15GArKRHQDIswjcABX968M2ovB4Y8QT02gnNfumHEpvre21hq/O4Yo5qrNjIS+b0wkaMNMGYD5wUJ5LRahbnVxOLrfow7BpYJxIdUeJDPWmqIV1O59ttHD6HovoXUg1Ee2BkoXdq1Ie4zKwOHnRTmI9Sl5UEcX4byov36S7wZHg2NlNr0zOaoB4i3pGMvCkFCsn77F70KHOTUSLQ7XdlSwWZMT1XlDdUpnDDtOMpdSzkotpv4RhZdl6f/HoQkQ+36BUksEk/4rALgsPAGChA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84b5755-c10d-4aa4-54c6-08deb7f75315
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 11:43:21.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH/1y+hjJ46kVZAVbaJQD67Uq0acsE9R+6gHPvov15+57rDuNS1KFLmh2BDn68p9qPRiWITmBUHnbt3xdYvE1skYp3DR6NJve6YyFwP+Yj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290793-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,PH0PR11MB4904.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.893];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0A1C75B34F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2Jha2luLCBBbGVr
c2FuZGVyIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1h
eSAyMiwgMjAyNiAxOjM0IFBNDQo+IFRvOiBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5r
b3JiYUBpbnRlbC5jb20+DQo+IENjOiBlMTAwMC1wYXRjaGVzQGVjbGlzdHMuaW50ZWwuY29tOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxA
aW50ZWwuY29tPjsgTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6DQo+IDxhcmthZGl1c3oua3ViYWxld3NraUBp
bnRlbC5jb20+OyBJbGljaGV2LCBLb25zdGFudGluIDxrb25zdGFudGluLmlsaWNoZXZAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW2UxMDAwLXBhdGNoZXNdIFtQQVRDSCBpd2wtbmV0XSBpZHBm
OiBhZGQgcGFkZGluZyB0byBQVFAgdmlydGNobmwgc3RydWN0dXJlcw0KPiANCj4gRnJvbTogUHJ6
ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IERhdGU6IFRodSwg
MjEgTWF5IDIwMjYgMTA6NTQ6MDYgKzAyMDANCj4gDQo+ID4gQWRkIHBhZGRpbmcgdG8gdmlydGNo
bmwyIFBUUCBzdHJ1Y3R1cmVzIHRvIG1hdGNoIHRoZSBDb250cm9sIFBsYW5lDQo+ID4gZXhwZWN0
ZWQgbWVzc2FnZSBzaXplczoNCj4gPiAtIHZpcnRjaG5sMl9wdHBfZ2V0X2Rldl9jbGtfdGltZTog
OCAtPiAxNiBieXRlcw0KPiA+IC0gdmlydGNobmwyX3B0cF9zZXRfZGV2X2Nsa190aW1lOiA4IC0+
IDE2IGJ5dGVzDQo+ID4gLSB2aXJ0Y2hubDJfcHRwX2dldF9jcm9zc190aW1lOiAxNiAtPiAyNCBi
eXRlcw0KPiANCj4gRnJvbSBteSBleHBlcmllbmNlLCBpdCdzIGJldHRlciB0byBub3Qgc3RhcnQg
bGluZXMgd2l0aCBhICctJyBpbiBjb21taXQNCj4gbWVzc2FnZXMsIHRoZXkncmUgc29tZXRpbWVz
IGhpZ2h0bGlnaHRlZCBhcyByZW1vdmVkIGxpbmVzLiBJIHVzdWFsbHkgdXNlDQo+ICcqJy4gQnV0
IGl0J3MgdXAgdG8geW91LCBwdXJlIGNvc21ldGljcy4NCj4gDQo+ID4NCj4gPiBSZXByb2R1Y3Rp
b24gc3RlcHM6DQo+ID4gT24gQUNDLCBydW46IHB0cDRsIC1pIEFDQ19wZiAtbQ0KPiANCj4gQWdy
ZWUgd2l0aCBKb3NodWEsIGl0J3MgYmV0dGVyIHRvIG5vdCBtZW50aW9uIEFDQyBvbiBwdWJsaWMu
DQo+IA0KPiBZb3UgY2FuIGp1c3Qgd3JpdGUgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAiVGhlIEZX
IGV4cGVjdHMgdGhlIGZvbGxvd2luZyBzaXplcyBhbmQgdGhlIFBUUCBuZWdvdGlhdGlvbiBmYWls
cw0KPiBjdXJyZW50bHkgZHVlIHRvIHRoYXQgbWlzbWF0Y2giDQo+IA0KPiBZb3UgY2FuIGFsc28g
bWVudGlvbiB0aGF0IHByZXZpb3VzbHkgdGhlIEZXIChvciBpZHBmKSBkaWRuJ3QgY2hlY2sNCj4g
bWVzc2FnZS9yZXBseSBzaXplcywgdGh1cyB0aGUgcHJvYmxlbSBhcHBlYXJlZCBvbmx5IHJlY2Vu
dGx5IChJIGJldCBQVFANCj4gd29ya2VkIGEgeWVhciBhZ28gd2hlbiBNaWxlbmEgd2FzIHdvcmtp
bmcgb24gaXQpLg0KPiANCj4gPiBPYnNlcnZlOiBmYWlsZWQgdG8gb3BlbiAvZGV2L3B0cDA6IFBl
cm1pc3Npb24gZGVuaWVkDQo+ID4NCj4gPiBGaXhlczogYmYyNzI4M2JhNTk0ICgidmlydGNobmw6
IGFkZCBQVFAgdmlydGNobmwgZGVmaW5pdGlvbnMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFByemVt
eXNsYXcgS29yYmEgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3ZpcnRjaG5sMi5oIHwgMTUgKysrKysrKysr
KysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lk
cGYvdmlydGNobmwyLmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL3ZpcnRjaG5s
Mi5oDQo+ID4gaW5kZXggMDJhZTQ0N2NjMjRhLi5iYTk1M2RkNWZiNjcgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi92aXJ0Y2hubDIuaA0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvdmlydGNobmwyLmgNCj4gPiBAQCAtMTU3
MiwxMyArMTU3MiwxNiBAQCBWSVJUQ0hOTDJfQ0hFQ0tfU1RSVUNUX0xFTigxNiwgdmlydGNobmwy
X3B0cF9nZXRfdnBvcnRfdHhfdHN0YW1wX2xhdGNoZXMpOw0KPiA+ICAgKiBzdHJ1Y3QgdmlydGNo
bmwyX3B0cF9nZXRfZGV2X2Nsa190aW1lIC0gQXNzb2NpYXRlZCB3aXRoIG1lc3NhZ2UNCj4gPiAg
ICoJCQkJCSAgIFZJUlRDSE5MMl9PUF9QVFBfR0VUX0RFVl9DTEtfVElNRS4NCj4gPiAgICogQGRl
dl90aW1lX25zOiBEZXZpY2UgY2xvY2sgdGltZSB2YWx1ZSBpbiBuYW5vc2Vjb25kcw0KPiA+ICsg
KiBAcGFkOiBQYWRkaW5nIGZvciBmdXR1cmUgZXh0ZW5zaW9ucw0KPiA+ICAgKg0KPiA+ICAgKiBQ
Ri9WRiBzZW5kcyB0aGlzIG1lc3NhZ2UgdG8gcmVjZWl2ZSB0aGUgdGltZSBmcm9tIHRoZSBtYWlu
IHRpbWVyLg0KPiA+ICAgKi8NCj4gPiAgc3RydWN0IHZpcnRjaG5sMl9wdHBfZ2V0X2Rldl9jbGtf
dGltZSB7DQo+ID4gIAlfX2xlNjQgZGV2X3RpbWVfbnM7DQo+ID4gKwl1OCBwYWRbOF07DQo+ID4g
IH07DQo+ID4gLVZJUlRDSE5MMl9DSEVDS19TVFJVQ1RfTEVOKDgsIHZpcnRjaG5sMl9wdHBfZ2V0
X2Rldl9jbGtfdGltZSk7DQo+ID4gKw0KPiA+ICtWSVJUQ0hOTDJfQ0hFQ0tfU1RSVUNUX0xFTigx
NiwgdmlydGNobmwyX3B0cF9nZXRfZGV2X2Nsa190aW1lKTsNCj4gDQo+IERvbid0IGFkZCBlbXB0
eSBsaW5lcyBiZXR3ZWVuIHRoZSBzdHJ1Y3QgYW5kIHRoZSBtYWNybyBjaGVjaywgaXQncyBub3QN
Cj4gcmVsYXRlZCBhbnlob3cgdG8gdGhlIGZpeCBhbmQgbm8gZW1wdHkgbGluZXMgYXJlIGludGVu
dGlvbmFsIGhlcmUgKGV2ZW4NCj4gaWYgY2hlY2twYXRjaCBjb21wbGFpbnMpLg0KPiANCj4gPg0K
PiA+ICAvKioNCj4gPiAgICogc3RydWN0IHZpcnRjaG5sMl9wdHBfZ2V0X2Nyb3NzX3RpbWU6IEFz
c29jaWF0ZWQgd2l0aCBtZXNzYWdlDQo+ID4gQEAgLTE1ODYsMjYgKzE1ODksMzIgQEAgVklSVENI
TkwyX0NIRUNLX1NUUlVDVF9MRU4oOCwgdmlydGNobmwyX3B0cF9nZXRfZGV2X2Nsa190aW1lKTsN
Cj4gPiAgICogQHN5c190aW1lX25zOiBTeXN0ZW0gY291bnRlciB2YWx1ZSBleHByZXNzZWQgaW4g
bmFub3NlY29uZHMsIHJlYWQNCj4gPiAgICoJCSBzeW5jaHJvbm91c2x5IHdpdGggZGV2aWNlIHRp
bWUNCj4gPiAgICogQGRldl90aW1lX25zOiBEZXZpY2UgY2xvY2sgdGltZSB2YWx1ZSBleHByZXNz
ZWQgaW4gbmFub3NlY29uZHMNCj4gPiArICogQHBhZDogUGFkZGluZyBmb3IgZnV0dXJlIGV4dGVu
c2lvbnMNCj4gPiAgICoNCj4gPiAgICogUEYvVkYgc2VuZHMgdGhpcyBtZXNzYWdlIHRvIHJlY2Vp
dmUgdGhlIGNyb3NzIHRpbWUuDQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgdmlydGNobmwyX3B0cF9n
ZXRfY3Jvc3NfdGltZSB7DQo+ID4gIAlfX2xlNjQgc3lzX3RpbWVfbnM7DQo+ID4gIAlfX2xlNjQg
ZGV2X3RpbWVfbnM7DQo+ID4gKwl1OCBwYWRbOF07DQo+ID4gIH07DQo+ID4gLVZJUlRDSE5MMl9D
SEVDS19TVFJVQ1RfTEVOKDE2LCB2aXJ0Y2hubDJfcHRwX2dldF9jcm9zc190aW1lKTsNCj4gPiAr
DQo+ID4gK1ZJUlRDSE5MMl9DSEVDS19TVFJVQ1RfTEVOKDI0LCB2aXJ0Y2hubDJfcHRwX2dldF9j
cm9zc190aW1lKTsNCj4gPg0KPiA+ICAvKioNCj4gPiAgICogc3RydWN0IHZpcnRjaG5sMl9wdHBf
c2V0X2Rldl9jbGtfdGltZTogQXNzb2NpYXRlZCB3aXRoIG1lc3NhZ2UNCj4gPiAgICoJCQkJCSAg
VklSVENITkwyX09QX1BUUF9TRVRfREVWX0NMS19USU1FLg0KPiA+ICAgKiBAZGV2X3RpbWVfbnM6
IERldmljZSB0aW1lIHZhbHVlIGV4cHJlc3NlZCBpbiBuYW5vc2Vjb25kcyB0byBzZXQNCj4gPiAr
ICogQHBhZDogUGFkZGluZyBmb3IgZnV0dXJlIGV4dGVuc2lvbnMNCj4gPiAgICoNCj4gPiAgICog
UEYvVkYgc2VuZHMgdGhpcyBtZXNzYWdlIHRvIHNldCB0aGUgdGltZSBvZiB0aGUgbWFpbiB0aW1l
ci4NCj4gPiAgICovDQo+ID4gIHN0cnVjdCB2aXJ0Y2hubDJfcHRwX3NldF9kZXZfY2xrX3RpbWUg
ew0KPiA+ICAJX19sZTY0IGRldl90aW1lX25zOw0KPiA+ICsJdTggcGFkWzhdOw0KPiA+ICB9Ow0K
PiA+IC1WSVJUQ0hOTDJfQ0hFQ0tfU1RSVUNUX0xFTig4LCB2aXJ0Y2hubDJfcHRwX3NldF9kZXZf
Y2xrX3RpbWUpOw0KPiA+ICsNCj4gPiArVklSVENITkwyX0NIRUNLX1NUUlVDVF9MRU4oMTYsIHZp
cnRjaG5sMl9wdHBfc2V0X2Rldl9jbGtfdGltZSk7DQo+IA0KPiBCZXNpZGVzIHRoZSBuaXRzIGFi
b3ZlOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2FuZGVyLmxv
YmFraW5AaW50ZWwuY29tPg0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQoNClRoYW5rcyBmb3IgcmV2
aWV3LCB3aWxsIGFwcGx5IHRoZXNlLg0K

