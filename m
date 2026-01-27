Return-Path: <netdev+bounces-253978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFjSDUYIeWmPugEAu9opvQ
	(envelope-from <netdev+bounces-253978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:47:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A79953A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEBA53023015
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A3366546;
	Tue, 27 Jan 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1VZaULR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652C36605F;
	Tue, 27 Jan 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539554; cv=fail; b=C9APjf+2dUd+AUL69x6WQ3ivbziwecbWq0PDRb4fH0G4X5mOo51REMK4imNupVsIVzUI7PSY4A+9XpqQTZMlbwYcqeC0aDoV5SHc0ufQ3JDVRWNathNPliLtoJBxRP+orcRY1WAvpSJBcxnbzu8cY8MEigq+i6MWf5UdYiaaGB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539554; c=relaxed/simple;
	bh=zSYItfvS1pWasjndU0bkqu7M57zeLINsucuC+o7IrvU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJIOi4yLC+2oqIgxxBwp9zotI8WzLlYTNFsrZB5rvU22KyRECYZLcqz+E+oTSie6AKBW/iWjiLMkzgc25lSweVHA7o/CcJxibT7Fse3+qE9IigVQxH6RPlvxbW04YnBSc3am28aF7/NEB5+qRFuFet80KWxINeDSXTH6h0Ir79c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1VZaULR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769539553; x=1801075553;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSYItfvS1pWasjndU0bkqu7M57zeLINsucuC+o7IrvU=;
  b=c1VZaULRlIkp70FzM0YBqaPyjz/lfiBbOJY0qlx8ewTs8Oel9y5Xg9zh
   rfHP6mJ4+5qfX8PRf5SECjkdC77Sn68Gm7ICycx1aorgjAGffTEpxSN9/
   caOPJVM4BXeagEGeUOHtz2aSe1DmTBS15A286aSYSakuamMbZiOcCnzio
   R+6wFjur9E/Ia2ldcwXhr363nNy4xISWJ3aE32VtF22FvpVMnOK0iKRsI
   5tzRJAfh6k8Gy7mzsYQUgQZiCiUjFm39glmJwTBOcBlHn7hDJx15GFroV
   ST0FdHFMHSUArpG2BRNLjsgkImk10Zf/44p7Hx2Vkn64amy8ZPj2Iukpz
   g==;
X-CSE-ConnectionGUID: qk3Up5ywScCL83xcR0Mrhg==
X-CSE-MsgGUID: BA5S+JU5TDaIO7vtcfO4mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81375820"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81375820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:45:52 -0800
X-CSE-ConnectionGUID: bOEHfYSAREuITMK1fkz8Pw==
X-CSE-MsgGUID: YPrQsFYRQsa9YnBjlFiHVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207288742"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:45:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 10:45:51 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 10:45:51 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 10:45:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPajyjE6W7Q4RPrey/W+DIdkbW/7a73HpGahREFJdO3lkaCc05NaVUAQ19sUudDHmKbBYe3t0t/FBj9Ig4rvvvuDBiGNq8w4iWQu5S4HnEv+G0Dd8S4m1vxZMl/g2hbxtSb9zBw4cM0Qn79Zn9sWLDj55ISrkz2cGPuWPbt2ShLu13xczTwi23wZAkrJG+C3hHaJs19YYkgFEk2upNr4Waxrr58JV8dPnestg1DfvsigLYgpvLpd/WzjkGjRS1s7lY+rIGuXtMtJTMfN7y9avDiinItW+7CYJ65zfn2Wku31dnSA4m4xaGbZULBjA4cZoPNfqnbf7rhI7lfAvnUH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiidJiIBAMTz41sdCNPXcejvO0QcXWHScMmWXpfO/VE=;
 b=XO3WopWAT3T4l1L6AOxp9NG/kOdqaT6UByrcs4OHTk3UkrqdCLPAG1UrLaSE2m5DErTj4vOsfXrJxsFNE6JU6lgdLQC7M2cwkrVjchwXFGjGXWOlKA9H7tRDlHCe9VoYAFkZpS2H8D0Cv7ryrm+FxSqseAyphDKy2DhwV7aeqbFahw9ek+s0V6rM0Q6OR5B9WXoEfjBaX5e1HzhwIjpENi4GWFRVTV++Y98jVUipdDwIXkKjgCxgTUc0R/pQy9e10zz6pHwOivBzoP5lnpfnVLF9bsrQViqeDl9lEt9yoNC/+GQysxU3fIrqd55Qhcq+XH4QXmQA6JWY5ijGtkdbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17)
 by PH8PR11MB6612.namprd11.prod.outlook.com (2603:10b6:510:1cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:45:49 +0000
Received: from PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::383b:f937:dab2:be0f]) by PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::383b:f937:dab2:be0f%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 18:45:48 +0000
Message-ID: <e899d90f-2d29-422f-8690-3763e7a7cc87@intel.com>
Date: Tue, 27 Jan 2026 10:45:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/8] ice: do not check for zero mac when
 creating mac filters
To: Jakub Slepecki <jakub.slepecki@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksandr.loktionov@intel.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <michal.swiatkowski@linux.intel.com>
References: <20260120103440.892326-1-jakub.slepecki@intel.com>
 <20260120103440.892326-4-jakub.slepecki@intel.com>
 <73cfe48b-cb57-4698-8166-c3cc587a45d2@intel.com>
 <f41330d8-f686-4e04-844e-86c37351ad74@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <f41330d8-f686-4e04-844e-86c37351ad74@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:303:84::20) To PH7PR11MB6449.namprd11.prod.outlook.com
 (2603:10b6:510:1f7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_|PH8PR11MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acfd6e2-7b47-4b2e-d004-08de5dd449d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTBjY1B1RWNkL3lQbHRmeFlza3c1bGdXaWh5S05qYkhLV1NEVEN3VmFwMCtm?=
 =?utf-8?B?ZWR4Tk0xcXI2ZERkb0FTS3R2UnVRUWJPakJnTDJuRXMwYlI2VGxhWStvQlUy?=
 =?utf-8?B?ck4yTVRUeDliUTBiZmVCSXBTZ09rWHZEVGhYejE4MUNLNkNNbFcva2c2SE0w?=
 =?utf-8?B?K2xtaUhyLzVRSENPS1N0NVRtZmN6Z1ZBS2lTNmRYQzJ1LzlLNXF0b25LYlQ2?=
 =?utf-8?B?cTIvMGFjZUt6Q1p5ZER1WFhQcCtmQ01FWDRKcjBpUjRIZ3lVc0tsV1ZIaEEy?=
 =?utf-8?B?MUJibk5MWW1mN2RPc0lybEUyQXVKQ0N4NXpNRFRoUnFkR1BlYnE0a1RlZlB6?=
 =?utf-8?B?RDlHbHhQd09BRzRMTWZJTGJTOC81U1Bra0lTRC9wd0dkbjBPTnExUlpkUUJt?=
 =?utf-8?B?cDF3MldJUFI2UmhMeGJicVJDaFNhVU9SSWNsUHRVQm5HSW1sdHBMcHh1MFVK?=
 =?utf-8?B?WjZYMUMxek9UdGJVelRPQjVPazdkcEQ5SFN4bHdTc3owNmI1UkM2d3l5TUxC?=
 =?utf-8?B?OEJoRzdVOGEwdTgwY3FqMlBOVVFERmJxc3k3a21QREFHRHRsZUNNd2UxNDRM?=
 =?utf-8?B?cGhpYXN2cXBVeFBLWTFKQUlMczEycEh3YzkyL0hKUkx0UzQxTi80NFI1bTNF?=
 =?utf-8?B?RmF1RHJURjRpNmUvT1pEam9IOW9EbnpzK012ZS8rRGZHT01nQ0VkWjBWbENQ?=
 =?utf-8?B?bVRPd1AxRmU4OUlEOWtjODg1cmdVOHkrSnN4L0R1Y1dBT0FoZWFnQW5Bd0V1?=
 =?utf-8?B?NXRLcXIycTd5NkU3SXI2Z0JKb3F1SDVZSmNkMGd0cVYxNDFzeHFaSmdMWm5s?=
 =?utf-8?B?dUszNUpncmZtV2xEdUFLbFQwZ1RDdzFUTXRHL20wMStZRmtaNzZzd3BGY0dP?=
 =?utf-8?B?MjM2VTZLTVFPcHA1RWhkYjloWnZqZ01OSm5hVTlUckhoSkZjRHRCQ2s3M1Vk?=
 =?utf-8?B?YkZXYzVKOCs3L0x1MVl5U1ZGais2d1IzQWlvMVpaVCtPdUVIUm1NTHF3S2da?=
 =?utf-8?B?YkNEaXEyZjFlYXRQSldTcnp2MlAyVUVaTnhGNFJpblJkR1JiSGlNZ3dwUFlI?=
 =?utf-8?B?YWxwQldCdVNCUzVVMWpoSXJMZlhaS2tzSCtHQzdtY2lCNW1CMit3bm1qNWNq?=
 =?utf-8?B?VlUyc3F0eEJLalNRRGdCMjRONGVzQTY2bTVSRDkwQW5lNXpVeGo0V0RHK25J?=
 =?utf-8?B?NFpPd0puY3o3MDMvMExOajVuQ3ZaejB4S2JNSVlJL3dYdUtCOXllT0RnM1pM?=
 =?utf-8?B?Mlp4VGt5TVlQYVpiUmtWcHFzaDlnTUtMZ2wyUWFWeW5yRWN4b0J1QU5waTZo?=
 =?utf-8?B?WFJWcnhyMEF5VjEza25sQWlTM05zbS92R0FpVDRVWlFxTzdsbmhVWkFGSzh2?=
 =?utf-8?B?WXkrdjdqVzlhVjBQYUdXNkNhNW5aRW5Kc3JJdWZIQWFGRElJU3pucTZoV3hN?=
 =?utf-8?B?RmU2N1dJeHNiMkhFK1dyVzI2THp3bGdmVzJxSGNCeFB0dXZydnNWTktuZ1F2?=
 =?utf-8?B?MGp1WTBoUTJqTzJLdkltT2NMTlB6Q0o1cGZwUFhZUzJNM1NBQ1RYck1YdWhp?=
 =?utf-8?B?WTlpemhwWVJLUmNmUXd3Nkd2bTQzeFBkY2lib0FGalJMVnNESTA4eXdpWHpo?=
 =?utf-8?B?eE95OXBrWFYyR3AvM2E5U1ZwYlhzUDRCbm5lSWV2NDc5NUkvSHJxZjF0RFZ2?=
 =?utf-8?B?a2c4QUYvTXRHQTN2cG9JVU8zZ09wV0FiSE5EY2V3UWFOcGlMUEdBL2JuYS9E?=
 =?utf-8?B?U2E5OHhVVEtSSkE0aTFoR1MySmNlSFQ2VmpJMUZoRnJBbm03OHRKZitFbHhT?=
 =?utf-8?B?S0tDWHA3WUhIcE5vRWRORVpVNktCWUtIWUVTWDVoSmhSc3FpMWFHTS9kamJx?=
 =?utf-8?B?UjRzbHhaMFRlN0ZFczJqRy95TCtmenJsdWZUdmtaUi9ieXRiMTYxYWh4SnR0?=
 =?utf-8?B?cUFNZlZGZ2JiUU1qQ09UZlF5VE90SXFQNjlwQWdVTkVMTnVCYjdGejg0TzRr?=
 =?utf-8?B?UFN6eERoNTk4TGJqeUUyMVdYQ1dXc1JaSWd3aDJVWWdreWJLY213WWFCZE1R?=
 =?utf-8?B?WVkvT1RQOG81SDgzckVNZC9HcDhueFVoRm9oc3BFcnZGem5xZGlOZVVLa1Ro?=
 =?utf-8?Q?29tw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6449.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFwTGo0RnVMVDdmaHFsRUZGM1Z2ZkF0a2x6UjBoQitHUDdZcXZVSnQ3Snpq?=
 =?utf-8?B?Z3RWQ1hEdVlYWnFmVmtvemZOV0g1dUx3UHR3TGNIcFREL3FXaDE2aXhnTWta?=
 =?utf-8?B?Yy8zQzF0OUN3K1M2S1l5SzZsOWtHenUyL2FWQjBwNmMyOHdmWmErSUp5OVdX?=
 =?utf-8?B?N1Q2OTJxSW1uOE9nSU1RaXRvbE5JT3Vjcmp4VHpZdWRyakhrMSt2K2tic0ha?=
 =?utf-8?B?cGRuSjR2dDRPbzY5L1QvS1JDanU4T0FTNXFoR1FhaGFLcERuOVhsQVhjTm5x?=
 =?utf-8?B?b0ZXcjYvMkdXdnBHT05WR0lHczhmVUJ1UjNIV0lRdEp4UFNWR3BaYU5UM2Vr?=
 =?utf-8?B?NmtlUEhHck41OEJRbUQ0SlNwTFY1YzZrOCtza3hGK3VrWjJOVXkydFlGYlJj?=
 =?utf-8?B?MnlFT3A3S2lXRjlEdlhYbjJxQUpnWUlqTE1FemxoRXRiVVJNanNjM2MzRjR6?=
 =?utf-8?B?VlNjWXFvSUNLU0UxZEgyRkVZMHhFZytlMTk3T3QvcU1DazZOVmVxbCtmb294?=
 =?utf-8?B?T0pPNml4eGtvUi9lTjZMTTRuMUF6SmVIK2puK0hzbXNkU3JYUjc1K3dHUTdW?=
 =?utf-8?B?L3ZzL3NKS05Oa0QxQXJMY0xOdTllUjNyOWRIR1RBSXRGY3hhYXYxQm5NemFC?=
 =?utf-8?B?dWtvVCtTeDNwejBoMlRRdHpWWTdTZXE1MXdxbldacDUwa1pKQVVkSkduRE54?=
 =?utf-8?B?NGFMRzRwaUVKeHB0cWhkN1huY3VFUDRRL2xlSUhPaHZmRnBwWEFLRldOMStj?=
 =?utf-8?B?ME9tZEpLZ2dKUzRaMlNuOHY3Wk4zQ2FxS3lhSzNwcUplVExlVUNUTzNiOEVS?=
 =?utf-8?B?V1RtSlB0dUtncFByOUd0a1Nob3RnUVc2aTJPSFBMaWVDdkpCUHorVGg4emVP?=
 =?utf-8?B?bXhZazJRc2JQTTN6NGs0VWU5eFBQZ3F1clJiN0RlWlozWXo0S1lsdjgyMVF3?=
 =?utf-8?B?MlkxV0Z3bU1rc3I2QUFqUytkS2pKelRXOEc2WjRBd1UvMEJvYXlqbk85dXJP?=
 =?utf-8?B?eGdLaTVyZ0hROXdoWmhXYVdTNlhIek8rTjRhVFZHV0RuVWZBNmdaKzJXTTlO?=
 =?utf-8?B?ZVpWZ01ZSFQzNnd1QkJVRU1sK0NWSDd6dDdKNnhjOVBLTTJ0b3ozK3l0bHha?=
 =?utf-8?B?L1pCNXc1a3lDYndia2Z5RkdXMkxOUW1sWWI4a2RKekZoWVlJZ3lQWnppdTJR?=
 =?utf-8?B?ajFxaWZqUGZRN0w4Qng2SnhkZmVuTW5pSFpZQWJFV0hpTWlqQkRnRHpHd2hm?=
 =?utf-8?B?UW1qRE83cGExRmdHaWxxUGRRdjJiVnJYMVZFQU96ZHEwMS9RemNCQkI4UmtQ?=
 =?utf-8?B?ZUg4S1c0elJtZVdsWDY2Z2NiNUNVYmJ6Y1VxTzcrSlkxKzhQeHhOQi8wb2xt?=
 =?utf-8?B?V2JXVlRCeC9IdWZqa3FkSEhRc2h0OFdSRzlmTTRxWXVndXFYR21NaCs5UEtL?=
 =?utf-8?B?bzlhOXZmU1BuZjYzU0pBaVYrODNLRlN6aVp0M1BwUXBJZWFjWVdkMkp1ck9s?=
 =?utf-8?B?OFhxajF6TzR5czl2d0VUaGwwWllSVG9DSEZmb1RtOHAzNFFjTzAxTjhHK0tJ?=
 =?utf-8?B?OVlZcUlsMjdZaGNhanJxL2xwTlpoTXdOai9zMlNnTERibS9XcVN5b2RJcDFa?=
 =?utf-8?B?SVhhd29qMXYzdDViRE51ZG1mWGtZcit4RkdKb0VJS1dWYlhjdXJCazN1cUx6?=
 =?utf-8?B?NE01bExIOXV2aE43aitpaHFBV3VDZExQQmg0ZE1sN1hrelNhNC93WEwvVHZ2?=
 =?utf-8?B?bmplT1lPVEFkMHRGSzVqdmtmZ0Jlb2ZMK3JDMWt5STFseUUxQTY2TXhEbTcz?=
 =?utf-8?B?OHFiWEdCclM5dzdlUWZSK0JJbyt0ZFdlZ05XcUNlSmg5ZENCc0hDOGRaN2Zo?=
 =?utf-8?B?YStDaG4vcWlyVlJxbzZRSXZEWjROazZXcUsxL2hySjQ4UzNzaTJPcHI1cURq?=
 =?utf-8?B?QTIvSzJiZUV4STNQMVhRdEh6RnhPVnNSbUt0a01STGFOZlZadjhTR3BEQkhD?=
 =?utf-8?B?Z1FmMFFaK1V5VzgzbFpVV2tXZDk0TlJFQ0ZWWWtnVWhrc1Vvam1mbExaSHA0?=
 =?utf-8?B?OHBSNEFWVFMrVzZrdVhtcHh6Rm56K0ZaaGhsZllySTVVQ1FxV254R3RxSEgv?=
 =?utf-8?B?c1NKWUF6N0dlL080bjdNQkhYQklrQmdJQ1BXWFFsNXdGT0xjR1V2SXZiMmU5?=
 =?utf-8?B?dG1MNzJURGtRc2REdUgrcEFsZUpZcEQ4KzA1NzZiVGNOTXIwVlJ1dEVxMFFr?=
 =?utf-8?B?cXN6akp3ZEVURWhHMzVEY3NrWWVpaTRzcEhwSTJ0ZjVFenlHNCtlZEVmT1ZP?=
 =?utf-8?B?VktJak1jZ2xCYTE0Q05SMWg2VGgxNnlZaXhuTXNQSStlRmQzQlA5NlpHSVNy?=
 =?utf-8?Q?feUqhm7q8XTtb+Rs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acfd6e2-7b47-4b2e-d004-08de5dd449d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6449.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:45:48.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0O09b9Jmcswo1Po3spJrM5VufLoy3edTYotCBJjvf3pkyKItiTNMdyzUZZ8KJojXVNIOcc+VZZKAoj2i2V7fIdZf+4ZHRuObsCFDy6FOX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6612
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253978-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 916A79953A
X-Rspamd-Action: no action



On 1/27/2026 2:31 AM, Jakub Slepecki wrote:
> On 2026-01-27 0:21, Tony Nguyen wrote:
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/ 
>>> net/ethernet/intel/ice/ice_switch.c
>>> index 0275e2910c6b..04e5d653efce 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
>>> @@ -3648,7 +3648,7 @@ int ice_add_mac(struct ice_hw *hw, struct 
>>> list_head *m_list)
>>>           u16 hw_vsi_id;
>>>           err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
>>> -        if (err || is_zero_ether_addr(addr))
>>
>> This is introduced in the previous patch; it would be better to remove 
>> it in the original patch.
> 
> Previous patch moves it from
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ 
> ethernet/intel/ice/ice_switch.c
> index 84848f0123e7..0275e2910c6b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -3634,17 +3660,19 @@ int ice_add_mac(struct ice_hw *hw, struct 
> list_head *m_list)
>           if (m_list_itr->fltr_info.src_id != ICE_SRC_ID_VSI)
>               return -EINVAL;
>           m_list_itr->fltr_info.src = hw_vsi_id;
> -        if (m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC ||
> -            is_zero_ether_addr(add))
>               return -EINVAL;
> ...
> 
> here, as a call to is_zero_ether_addr(), to the chunk right above, in
> 
> @@ -3614,16 +3637,19 @@ bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 
> vlan_id, u16 vsi_handle)
>   int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
>   {
>       struct ice_fltr_list_entry *m_list_itr;
> -    int status = 0;
> +    int err;
> 
>       if (!m_list || !hw)
>           return -EINVAL;
> 
>       list_for_each_entry(m_list_itr, m_list, list_entry) {
> -        u8 *add = &m_list_itr->fltr_info.l_data.mac.mac_addr[0];
> +        u8 addr[ETH_ALEN];
>           u16 vsi_handle;
>           u16 hw_vsi_id;
> 
> +        err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
> +        if (err || is_zero_ether_addr(addr))
> +            return -EINVAL;
> ...
> 
> here, same call.

I see now, I mixed up the hunks/functions. I'm ok with this being by itself.

> 
> The intention of the previous patch is to allow adding mac,vlan filters.
> Check is removed separately to make it visible.  Alternative is hiding
> it somewhere in two active chunks and in a long commit message.  I think
> this fits well into "separate each logical change into a separate patch."
> 
>> Also, AI Review says:
>>
>> The is_zero_ether_addr(addr) check was removed in line 3651, relying 
>> on the claim that ice_fltr_mac_address() performs this validation. 
>> However, the helper function only extracts the MAC address and 
>> validates the lookup type—it does NOT validate against zero addresses.
> 
> Removal is a result of internal discussion about ice_add_mac() and
> ice_fltr_mac_address() using zero addresses to mark errors.  Reading
> through the comments now does not make me convinced it's the best way.
> As long as errors are reported via int returns, I think the zero address
> check can act as a sanity check.  AFAIK, all calls that may result in
> ice_add_mac() currently are guarded by is_valid_ether_addr().
> 
> As for the phrasing in the commit message.  That's my mistake and if the
> patch remains, I'll correct this.  This version of this patch should
> not say "previously assumed zero-address cases."
> 
> I'd prefer to remove this patch in v4.

Sounds good.

Thanks,
Tony


