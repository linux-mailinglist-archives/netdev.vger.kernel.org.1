Return-Path: <netdev+bounces-280513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK3fOGwA6Wl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104CE44928A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F28230075CE
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AA37F8CB;
	Wed, 22 Apr 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Beh6EEK7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0437E310;
	Wed, 22 Apr 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877235; cv=fail; b=o6idJG821e7PBJfKBRGahUU9q+GbrpAU9AEnRVsfS4oNuiSd+BpgjutOIhsi3qE6cQUOp73L2bSV4vIkLyu+Hvg4caFc8TIV9x18/YYetrIEIm284YG3ER+KNTcwGCzBsJHTM/h7TRSC3lI1vFmPayMZHGS+1vLBGQrv8FyHaQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877235; c=relaxed/simple;
	bh=EOhuapxXAG7zQQ2ccB1mpgCX19QERNIxdYm4O56JsRk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o6hc8axMGU64vzPwqeDiTI4/Id8nDwpmdys4ujAEZLWXUnP5+bivFlSp0tbYdSvem7hHGG7F5crDmoTFO6ehMmijGJqzuzGt/mzekjtgNzpyM5k4DMCXPTFAgzim9B++DrKGIlQp0cT9fOOwO4bM1StTMVNClSfqfkBMGWTbpvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Beh6EEK7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776877234; x=1808413234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EOhuapxXAG7zQQ2ccB1mpgCX19QERNIxdYm4O56JsRk=;
  b=Beh6EEK7dqAC8dTqdyAN4Q5tzKMkAqkCsfT/RUFO/QX+TfCVPMuUDjMu
   TRlGcQSCu2IgEornuee3FzXvaZg/plnjy2PmccKaP2mAtfd3J6jo1dEOs
   1q5G+Y/pgjuqhh88Dtb0IGjqN/58+099eb6P9wB8h8/P257rgnoXtJ8Bv
   FjR9OeUqLkKDFUjVDACBS5xq7gB3lFJZxhoGhG247uJCq5RLhgZ159VqT
   MhjQRALZh/UvnoQEOihDxUovkd644TyHaoMuW7kAqiru+691lg3jg+Ydy
   +eRVd+IwiocNXe2LWcpeO6+GioSlFLQt70Nh5u2879hbOyd4onlUEBt5n
   w==;
X-CSE-ConnectionGUID: tbUG+ippRHuKtepOchLjUQ==
X-CSE-MsgGUID: Odcd9NHKRYq4q8hsgrWM3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88138277"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88138277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 10:00:32 -0700
X-CSE-ConnectionGUID: b0OT0Lv7Rn+yanVvV0FEgg==
X-CSE-MsgGUID: uyUWSanqSkulvYJ6qYN0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="229225757"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 10:00:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 10:00:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 10:00:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 10:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+NHf1QauUWhOnTEgKSpQGTnQ3UU0/9pBwCLEqiHX7KBunmghgO2kDBro4AUATwlB8zqZh7TQLknPlYf3OHCalw/rDRvCuthG0dQzPy9cf8v1I/SrVzE0zjgLoKWhV+IMFAAq36l/haDn6gX7xaIzPHh8NvOx+aZ1kvkxh/HudS4PsmATsS301w3zQV43hUmb/PodyK5iknlvXWaIGNrfvr9hLob5aBTvndtpVPG4VqCMmcQKum0p8mm0RZOmm4oeiqM6iSCRaw04ijWzFPInipGWWn3Cf7skNEH6YG2Hni1z2PcOAr1ZLKi7RcbYVXfHmOVTqDec52FJRR6AR7DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkgZrDs3UtZVdrWpa2BjsWjhTq859KrYL7LJ5rCKKGU=;
 b=PpL4mB+rjFldtMd3Rsye5dwboE/Fp007I549uH8Uuj14Omabjco9B+AG8w26SGmf1GYpzqXvuJEV372qlEZoCZFymg6lcDgu9BmgJ77rmTu/IFjCizlq6dPxN6vfebTrmUjoX1JQefjbaLv8Jb0BxZOoGT+PA7nvlP0QZAjpA8+udq8+MCGia8v+iwSrBtt3eiJwkl66YFOpqQQwjMFEGphz7seACJiI6163pkUtGacJnplhwQ6JOB/BXoGK1isOL3YJdzdjV7ETBeaiDtD7n9mX8LfS65j42hbB9uqlbMDaE1u/mKnKAFu6fdwqaTL6li7Egpv8PRdunFhqfqyKeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 17:00:27 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::b10:6045:9014:a81c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::b10:6045:9014:a81c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 17:00:26 +0000
Message-ID: <afa45d20-7d45-4f82-92d4-185fb2a73d5c@intel.com>
Date: Wed, 22 Apr 2026 19:00:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit
 architectures
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com>
 <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|DM4PR11MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 49345b16-f097-4e65-475f-08dea090a5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LvvWQ1TxGcpH6U260epCBLUH37e+rxFqsVOKrYkQvlIWWQmRElINh+i2E1PBMxhe2oW99TxKSO4v+1oeLNfMSBWsdumnj0wnMiq6r7+BHgc7OAXwQwVfVSNJb4znm4uSUIm2JOyUcLPNMsIzAhyc2b9baFxQhauAJXTfL9GFi282FIh1GR7QhZhE3cL3T1eSAeV3cK2FP4csZQYrZPazu3e7c/J1ee/sgVQxh1l6D6eDCgtWlA5aaRDx5zAjZT5cWPv0tLsquZtHMMwzKDEfiWPztE/bPlCEklu2QbV4uQO47LxNezCetzGgAjc+4/PiJ6nrxW+AVCx3w4I6LDGmGfMdnyHwc9W2VwJyttp0+0E2CIFWbRwgdPdOc/4iy9pHA8d72ej0Glr+g63sS79jKbbT8tYAepFxLigeYTX3T9Lhps83QmE3iiQGhonWqbK7f78c2hEhvwqvlU19CaD9GJ0nOYRC5IBWdWK1pHBQkxbXl4VRFC3OXWVjNEsbuUajQvys9Wh9UzO/2bE2YdXx+6FinoTHBusCYE77U45nYuJ28ZcBQCpzdKY6tzjjUVFOLfBALqpKYmGa4li41RQsqzME07aky22O7AulGBhPCJaY7eou8eE065zj7eGAr8r/nAmjb1sOqSPqdNttVSIDWbMrn0XB604QH4QtYhDgEsetA+jbz5UjHwoo8PyRb6qKyhYKxNeqanFxEf0MofZbeItBwbxwhKi7BNLRib8dSmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RRUXd5ZXhtd3BabE9US2hIWmFVUEcwNjNyNVFROEEwZTZ6cUVveDlEMnl3?=
 =?utf-8?B?N3RNZGhodVFzaGZLQUZtZm12Q3JNemorNUpmekI4K1dVQ3E2Y29sT0FKaGlS?=
 =?utf-8?B?Ujg4cjNjTFlBOUN5U0lLaW9aUVBTUHVYRzFXTEQ2T1pPckM2WTBBdDdLMFpD?=
 =?utf-8?B?UjQyeGp1cW1RV1Fad1VmNkxWbEJRWWZQZ3Nldmc1QlNDaE1UYUI2amdTWGJz?=
 =?utf-8?B?THRtTUZRejFIT0IwT1ZFM09Hd0VLa1B4MHJ1Nkg1QmV0M0tyTjhVS3ZrRGpo?=
 =?utf-8?B?SjMzb0FtNDdZb1RDbGpZZjM3empLc1lyanVxUkluakVsSWVVSSthalZMa0V3?=
 =?utf-8?B?TmNEM3BzREltdHc3aWtSaWNsMjIzelpsVGRJT0phNWdvS3JlQkRFeEVObm96?=
 =?utf-8?B?bThJVjI1bEtZT2FGSytoeGJrZTB6UnM4Ykt6NGUxVWM3VHBhQUlqNTJuV29I?=
 =?utf-8?B?aDU3REpJQTNwcXAyUlJGN1d6RW16aklPR2x4RlpqT25VM1FqdVc0cTlzTXRR?=
 =?utf-8?B?dG9GSDdHVE1wVlVxbFh2bjIvYnd6ckdRb2tvd2dieW14eWdOL0JEd041Y0JP?=
 =?utf-8?B?T08zM1FldWphd1c1eTFWZWpVUVQybkRhMjloVmdhWkNvcUI2Z0hKbzZoRE1Y?=
 =?utf-8?B?T3NDWVVLalJIMjhtQkNVOXhvM3o5WmpZUUtEbEVBZWhXK3BhdXg3RTZJWUl6?=
 =?utf-8?B?N2l2UWhYbTZpWnBQOXEyRlZPQi9tWXJoRHd2NlUrRWQ0amJHSTFmeW9vaVRI?=
 =?utf-8?B?eldQMzg4SklIRGZ6eTg3SXJTelAwb3l4enRXNXNjUk9ZSlB5RUJhM0JoNFRo?=
 =?utf-8?B?VTJ5N3VnT0VNdXhvRHVBMTVXOEpybTg0NTk5NVczTnJzVTl5ejRZclFiRHR4?=
 =?utf-8?B?YitYcUhldXVBVitRS2svRjVlYnpJQXUyYU1McTI1NTJIbTRXVHgycFdqSTdV?=
 =?utf-8?B?Z1pZRWVZR085dm9LNHRjeUpuakdLaXN1Rkk3cEpRU3NjT0o1ZFpVSXBXL1lG?=
 =?utf-8?B?ek9FQW8wWXkzUlhDQW05dzQ3dDFFb0FHK3piZHBaTWZoSldYM0o5dHFIejVw?=
 =?utf-8?B?WVcvdFhvakI1aGc5TFZjZXdaVkFOTTRPLzBVZ3lwYVVjK04wUzVKY252dlFX?=
 =?utf-8?B?bEdYb0ZLWXUrRy9DenVZVVFSUnJkbWpIM0hIQ0ZPMG1Jei9TbnhmWUdTMUtv?=
 =?utf-8?B?cS84ODEzNG1NVEpLekZMTmtYNnNiQUhsZ2xBK21UZ3F0UnJ5RGVKMXcvb2NL?=
 =?utf-8?B?TmgyZGVIb0N5SjFnZEc4K29hUlAzYm9pVFAraEQ4d1hKcGFvMmxJaUhNRFho?=
 =?utf-8?B?ZDBQaWRmQzJJTDVMamp1MlFmUnFvSE9oNkpKdmpEZGkxUTcrNUY1eDFMT254?=
 =?utf-8?B?Y2JyTVVwUFNucXQ5RHZLZUs4V3dTcDdwUmlPTzY1RzhtQ05DRVoxUnVoQUdN?=
 =?utf-8?B?RGhiS2hLcU5pZmk3V29lUWdqUzVpa1h2MkgyUitoTENEZnRQMWEwNnIxMERk?=
 =?utf-8?B?RlYxTkV0aEtuNlJHQThud1RkaHowem9kVUttMzNjem5wWlpURVNXU0kyWTEz?=
 =?utf-8?B?RjZDL3hIbTEwQWp5Z2tQMStaTlZlRHlYejBuODExNHAzKy84K0w4azdHL2w1?=
 =?utf-8?B?bk1WdW5vUTJTV1BUUElNemZjVGdzVm11TFg4d09tNFZtUDhsZUZpcG15K1h2?=
 =?utf-8?B?bTJkUDNrZVFPSjRqQzVqRE1weGZ1ZEhEaGovTkw2d1FiZDNZQzhSVjhJcEdn?=
 =?utf-8?B?ZzQrUFRFUHY0VERmMVE0RE5oRFpsK2M5dElvTlAwc2VxbnduQWw2c3J1VkI4?=
 =?utf-8?B?a3dMVlNaVXQra3N6ZWNBc1IrY0RvZitNUjdaNVJNV3hsYUNhbnZ4YWNVQUJv?=
 =?utf-8?B?R2RTRnc2VE5xcDdrQmY2SSthVjl4YStrNm1hNkxMZWNGVTJUczlsTjg0aXNL?=
 =?utf-8?B?aklSdjJadDNyT29ISklybUVJY3dtU3BzYjR4c09XMWxDQXNhcjk2c09ZcENz?=
 =?utf-8?B?d1kvQVM5SktvVGxEdzlnc2FOZHMzQk9HUFNrL0xxRUp6QmxNWVVqVGl0WHpI?=
 =?utf-8?B?cUxEellIYkpUMEtTR3lVWHozRDI4bk1SY2dMTmY4QXNzZHBDZ0JPMmVVVjZw?=
 =?utf-8?B?Y0QzUDdpRVhaVXBZRithQUNDNDhRcUNPdmRlVkRZQWM0MmJjOTVoNkh4TGp5?=
 =?utf-8?B?RDg1VnU4WjVGd2RVaUdNeVlMM09TQXN2Y3V5UHhlc2YvT0k0TWpocmFKeUww?=
 =?utf-8?B?MlVBUVJndXBsa0xyOWVaMGhweTJKT0l3VXVrL0RhL3l5dGwwVHlLaHN4ZVp3?=
 =?utf-8?B?azRIVGQ1ay9UMTZFVlpBWFJZVy9VKzdFRVRKak41Q1QzVFduOHU2blBwZk91?=
 =?utf-8?Q?zybGuahkTJZLWWPQ=3D?=
X-Exchange-RoutingPolicyChecked: cSbDupZP5Abf2JZ5ndoSXM9VZU0UbQUZBADO/xkDQA5hxtiwz01uwgsM9bLim2ZK9PyQRPiyfOUPamFKciSiN0PRtLZy1SKhXqW13UpbauSXPVAd+FvOZFi/MC8MwM89DRawHTN6Xl9L5MXpBP+wiiFY23SOYK2RMxUM6GTEL+iDTHYhXdEs+bPYJQ/TUXqlyPtgmBxUDEWMJ2htDrg/NP8cb1XPCV1p3SCyM+HQOvxZvbPtOPXkunz5bRLXLvWfGw84+PiDt5saruWdika9ej3bvWJ3YmFnGCTCjL4khQUDbdZz1767gGEnEsE0pWxu2mj0aGYUivoZKX/lVLK4iA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49345b16-f097-4e65-475f-08dea090a5c8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:00:25.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIj8iNx8XR3N7vxZDD8YN2jK7MYgmI8l4Xg682c+zj7SbIKfGDG0ne/4jW1AOAz6ha1gBNl+GhB4VBQRjt/7kc+WI83vITlnV5lhsaLLNec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280513-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 104CE44928A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 00:37:07 +0800

> On Thu, Apr 23, 2026 at 12:10 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Jason Xing <kerneljasonxing@gmail.com>
>> Date: Wed, 22 Apr 2026 11:36:50 +0800
>>
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
>>> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
>>> uintptr_t cast:
>>>
>>>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
>>>
>>> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
>>> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
>>> mode the chunk offset is encoded in bits 48-63 of the descriptor
>>> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
>>> lost entirely. The completion queue then returns a truncated address to
>>> userspace, making buffer recycling impossible.
>>
>> What if we relax the restriction a bit? For example, refuse to configure
> 
> As to the bug itself, yes, It only affects the unaligned mode.
> 
> I wonder if we can support this after someone requires us to support
> 32-bit arch and use it in the real world, then we can use the previous
> patch to complete the full support (which doesn't harm the path on
> 64-bit arch).
> 
> The code looks like this based on your suggestion. Just for the record.
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 58da2f4f4397..03417b04592f 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
> struct xdp_umem_reg *mr)
> if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
> return -EINVAL;
> + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
> + return -EOPNOTSUPP;

I'm fine with this one, as well as with the check I proposed. This one
would happen during the configuration so it won't affect the hotpath,
my check is just inspired by what Page Pool does when
`sizeof(dma_addr_t) > sizeof(unsigned long)` (rare case but perfectly
valid on some architectures).

> +
> if (!unaligned_chunks && !is_power_of_2(chunk_size))
> return -EINVAL;
> 
> Actually I'm fine with either of them. Right now I'm not so sure which
> direction this patch should take :)

Up to you and other reviewers, but I really do think cutting off 32-bit
arches entirely due to a bug which can happen only under certain
conditions (skb XSk mode + unaligned mode) is too aggressive.

> 
> Thanks,
> Jason
> 
>> an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
>> under CONFIG_32_BIT like it was done in Page Pool:
>>
>> skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
>>
>> #ifdef CONFIG_32BIT
>> if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) != addr)
>>         // WARN_ONCE or whatever + error path
>> #endif
>>
>> I never used XSk on a 32-bit arch, but back when I was working on 32-bit
>> MIPS 1G routers, I wanted to add native XSk support to the Eth driver.
>> Sure, just for fun, now that we have cheap AArch64 and other 64-bit
>> embedded chips, 32-bit embedded networking SoCs are almost dead, but
>> OTOH, as you can see, other subsystems like PP still try to support 32 bit.
>> Especially given that this issue applies to only to the skb XSk path,
>> not native in-driver implementations.
>>
>>>
>>> Since we hear no one is using AF_XDP on 32-bit arch, we decided to
>>> strictly stop supporting it at compile time.
Thanks,
Olek

