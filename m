Return-Path: <netdev+bounces-269137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCM3HsjiummdcwIAu9opvQ
	(envelope-from <netdev+bounces-269137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:37:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029772C0688
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D32333E5824
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16086318BA4;
	Wed, 18 Mar 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leLv0qz/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372821ADC7;
	Wed, 18 Mar 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852446; cv=fail; b=FD5J347f3Sw9e7aE6uR3iPwgHO2uX/KCRUtzAdafVXJtKutM1auy8Zsp4pqIryK6e6mOWXUDUEZedoS8JvmQDMdExUqbkh8aP8dGdiLPYvkiieHmiw4EoLKzF9qvl+pMijBuAFfu7z1XEJcJRvfo9jcQ8g/ulq9NcDj/Hoi/zeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852446; c=relaxed/simple;
	bh=gnPjrdXPOf9Tj0fWMqi4kmSK/Ssn0t3FXjI/WHlq0gA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evaJ9oCgdl4g9m6O7BYCe0ythI6fr83rFxwnVfeB3pFvejFMfyV5As4ybLq0XpOxP2LGAWiQp8da3E+pfdZ04mqmiZyTTilJ2vmluPta1cH6OWYPfr5sUDTY3EJSfm4/tK9GhWRXSncIW4VPbNUvtHgHgZek+QJEepSkd2GWeFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leLv0qz/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773852444; x=1805388444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gnPjrdXPOf9Tj0fWMqi4kmSK/Ssn0t3FXjI/WHlq0gA=;
  b=leLv0qz/KVTc31wJm0JMurvp9a2wZN+QdKClxuIoTf6GClkQcSzr+pr/
   Arwcb/jA8+Vo/6s3IDZxckswH6dAsxll1zT2uAYt5RdQLvqyQULxJ5B59
   O/rp8AsLEqeBwRg0ZWe4GMwybcu2IoQY3xKbF0mA76FO3YaA3DQTMuNIF
   n8fhwUSO190WabegxCJg79jfx945h2NX3+svhMhf+Wr/lmL/gi103Ituz
   Z3NG99Yeu44Gmp1Y2B/Ch8s86jFqFRXZa1p3a7tQ7he6NWYNVRaBAAnnB
   0xQTnkyGI99pDPkG7nw7YYlj4sSnXMrECa+Ghltq6ikF/S1mS1xebpr/H
   A==;
X-CSE-ConnectionGUID: qMmFNtJMQ1KwxV6+1Kk+Jw==
X-CSE-MsgGUID: Td3wg6+tTImaL1l0B/PnmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74825948"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74825948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:47:23 -0700
X-CSE-ConnectionGUID: wu4nWGCiSQa7H8hpMGGaLw==
X-CSE-MsgGUID: 9BqCEIfeQF2YNdMJwIQbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226815660"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:47:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 09:47:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 09:47:22 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 09:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j49Q2mAY7uLcJaPUbEQAODGz7aALeNce8YgJtviFI2I0+fqKmFzc9Qa3fjFYBy1yNcBlLZ4dB7H7Pu3lpdVohSGmAIfYLnG9TtAxjX+78tS4FDuPxYFROCNYClTJ9ALPzRvdOJI3Eiorn9beOHJqmjwKcr8Cgvp8NzL0oUiW0T4d56LWV5/2ogap7Ypwyqjy1VtPpE0R17kLRdbElCrUpsTrYzRuYl2eBLeBTfnJ309brWUKwqy6vShRByqr6sch4ah4GWtfYnux+QSIGIWdE5ohnkVRz10c26wRyJVnNx6E2jYGc7HIpFhGvpA2vBG+vEjjG6ywyJoc0EiumXbBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rniyIjNyrL+hVd2F/6a+E5JGggxaEowrwFKUuC8AZxY=;
 b=IXd/YlTVbIAOGA1WkRfw2j6eJexzb4uFZbDzsg8AEX4COqJGmPV7MTt9SJm1+5PlqKFuuJClWhLYbF5Nl/TiNluRG1CYG/57S2kBtvYHCDocpEVUnAs17y0Yi2ZH4CvFic8orRNkMkkTel0R8Jomxhuk8kZggsoiDrd179ATgxc0MKwZzOuNKmNaBT+16YLNNfz0NapvsfwOaptrutqn7OwOryWfklUMnuEOP4cYRWpbMSK3MEgit6u23URXdacnHP1i0UwZSMsHVqoJfhdxFSsaNBEivTDCYQ9AvYdnTRdz50DO34EMrTiMEFk3lAty0GzVBylREk3dpCKuNAzSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 16:47:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 16:47:19 +0000
Message-ID: <e15e9beb-03a5-4134-89f6-9afb238085f6@intel.com>
Date: Wed, 18 Mar 2026 17:46:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/6] xsk: validate MTU against usable frame size on
 bind
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <larysa.zaremba@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-5-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260316174550.462177-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0231.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 313063be-2f05-4a4e-0714-08de850e04df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: eCd4pL86fv63eLovxVg3k2AvcLRXplfYbyc+yK8zTzrh+alYVK/oeKMkLVMHbeoJsACPmVwbjd84W4ZmJAicd7SJMWIoOHRfN94m/o2EVMQ5sV7Qif5ivqGo0Bhn9UoCCaO4qjjd5iPqXxOTv0yXF3yYU+BLXlvLKR35ZJ0YjlK+D/4m6ZKTC/xApX5b/I2i9Smd10F+EQIaEtD9LNWCmX67NOCqq/mdUgMd6/vmwdSwqn4m2reIT9uC3Fr1C5ndrqIxWjc3/SKmYasj5BUkn+SzJwDuVQZ5rpxBxp+w8bEWSeJ45h6c23oI83q/9/7iI/iuSxqTubENNEDc/W9mrrfcUAIIOC29cbw1vk5dEl+CvqVxAxptjWD3dx2MG67Gj+itzESlI86fVGNP8EKrQt5OGNkXgXxUjFEA9JGGdU/QZYj0iL1opci8xWO4sUOER98fyGZQA+41pSuuxSqTKt/LkJv/3iXwxPBDiZfRhAUzDFPfRgR7i3kaFec49oGSOqOjU8AQtO01wqAM+CwqmFLc5yo4qm3gGnP/7vgR5Ls8Aop/NZmDkQzDJTgtOrh0c9pYVaMhTNiL2v8WGhJDQcDf5EHfmevXry65wUt9ymjIKsK4ISUWBfxyDUyuuvywf1KV3QYSOeXW1tay2yhH6SIe+MpTpB3VEp4Z8ZHmCrx+pA8x3SM3B/tXdrXFIpSKL3e+CdQ33gCIJHDhblYboe/lZABrGFw2BEzYa5VN56A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWViMXcrNks0Wklmb2h4dmh0WFZ1cFpMRlNxeG9NVERjMVdsL2oxZUE2U1lN?=
 =?utf-8?B?c01aK0pJYTZkdzZtc2V4RWw0WEZDcS9iVUlQUEcvdjBCcWVQc3pvMWhKMWhM?=
 =?utf-8?B?eE45U0ZVL1hlWFNLa3F6a3RYdi9UTUZaUWlBK0NCZVMvQnMwL2dtWDhLVm9I?=
 =?utf-8?B?V0FmZDVOdTVnS0J3OEVlYjJGc0UvY3VhL2JnQTVxeWE3cnVKV0wwZEVzaHZW?=
 =?utf-8?B?MlVKM3lqTkY1UzFSSHFsQzBmL2RubGFvVnBORlFCVTVHQm1LUE5ob0VZN24z?=
 =?utf-8?B?Ti9EYnArOGtpUmZjNHR2TGJ6Z2RpcGJ5ZnA5QmlCKzZ0SWhrSEtqTnMzWUF2?=
 =?utf-8?B?THJ0MVdlM2JucmtBbFg5bE1ubXEzNjRiZVNJNTlMOGdSK1FZZ0FqZWdlQVlJ?=
 =?utf-8?B?YnZ1WWxNOVBPSnpTK3M4ZXFXOUdIQ0FLMUVja0M4em4rVmFaMDB5aGduVjA1?=
 =?utf-8?B?VnB3TjFFUkJ1OXFBc3V3ck9kZVE3c2szSWdJUm4rdUdkdEVjTDhLbGI4aXZZ?=
 =?utf-8?B?dk5EN2Y5bmR3bHZHZDlVbjdBYmxqaWN0bzhLdEkxSXEzTVFPc1M5Y1oyZFNm?=
 =?utf-8?B?OStGTjdzWDAzN1NQdVppd0drbUppUmN3d0s0dlN5ZnlNVVhtRmIyMTJtU1pr?=
 =?utf-8?B?MHl3TmtWYTJZN2VzbnlBNUlpb20wZ2d1N0Z4Q3lGMUdMVzIzcG1lTE5YNjhv?=
 =?utf-8?B?T1BZSy9BeVkxcnFQcllMR0xqbG8vUmhRTUo1M3NaNERKUnFraWRrZ05zNGxO?=
 =?utf-8?B?TTZmbTBvUEsvNy9mY0xMMm5MQnh3UnkreXhhWVFvblFITVBQOG5XbjVYZFFZ?=
 =?utf-8?B?OE5HTzVDU3VnUTJycWppaGpBOHhubU1CU29lRkVpdWNiNUJFLzRhYjJiQUJa?=
 =?utf-8?B?eU5PSm02NDVmaTdzTUtGUzJ3UGN6UXJaUGN0bjhBTC84d29JNjVWV0c0bEMv?=
 =?utf-8?B?Y200dXMxSkNPc05CRXdBYjl5aW5DeU5xYXAxWjRzYWVHSUQ2QWFCQlBidDdD?=
 =?utf-8?B?ZnpvQU1qSzdMS1pmUFIrVUpNalpaRDNkc2doRDh4eFhxdmR5cTN4WHJkSGQ1?=
 =?utf-8?B?QmMySXBYczlXeGx2dC9vU3NsL1d4aUpmeFpYTytyREg4ZGg3L1A3VWhybFQ1?=
 =?utf-8?B?U3ZTQ3RYT1llMUxjSVVETTdLOEV5ZjdQTFhVMSt5TERBNEh4amVUejZhM3Rl?=
 =?utf-8?B?bUdvUkhUVXg0bnFEK2Y0NE1FdGZ6dURZWE9iRXUwNURURUV3SC9HYllOMDFu?=
 =?utf-8?B?Z2QwY29UNzEwaU9QUHdSbFhCc1ZUalhwYmRKblhYMDNlcnc2K05OTm4zam9N?=
 =?utf-8?B?NXQrZm1kYjVGT2d1UXgwS0M2YkJnd2x2aFF2aHBZSUE0cEVmNDMxVjkwY3lh?=
 =?utf-8?B?dlZMZkJUU0VXWGQ3M2s1YmVGcjFySWVROVNsTDE5cGJVMWh1NHM5U1VVT2Zk?=
 =?utf-8?B?aVZuVHlqcHlRUHB2VnZ2cWFXUWlZcDRXK2ZoS05lSk9HVndTd3MvK3JSWFVy?=
 =?utf-8?B?KzVyOTkrcGQxWEdGUGxrbm5PUFI3Ui9KaXlNdW40RFRIU0IwNEpkN1UwR3Rq?=
 =?utf-8?B?MEtDS0gyaERVS2MzWnZrMzZRV20rcDN6QWJLazFrckJrdkdQMHZWZERaa0lF?=
 =?utf-8?B?YVE0ejVwWHFiR0FiS25KeEZIcHZ3Y2R6YWswY0pLQytZNVB3djZKbjQxN3du?=
 =?utf-8?B?a2tlMXNwcWVlYzhTNjk2OEduTGwvZEY4c3BXRll1bVc3NldHeTlyRkhMakth?=
 =?utf-8?B?VEZsNHdRd2RrSTY0QWNtZSt3NURtK2dIU0VmZHhVMm8zVkFyNFRaV3dIWVh5?=
 =?utf-8?B?ekVSRWxWVWMrQzV2LzN4MTBJYVdUWkloTHkvbVBQMzRxSDFGclFPemFWNGNy?=
 =?utf-8?B?ZXlKbWhLaTdMbllwN3ZWUTZKOHRSTFgvTUNxVzBZRjVNVVlvbks3YXJWbURp?=
 =?utf-8?B?cDlLYmVQaDYyRkRubURLZTREdm5QU2dhdmwxWGphSE82Ulpadnd1a3hVbzg1?=
 =?utf-8?B?Rmp3RlRHbjltZHdha3pSM01Lc1l5MGVFeE9GSTV2QWlSakZCbHBuaTB3cEtl?=
 =?utf-8?B?ZDAyWTFySHR3ZmswcTZySm9QTVlKS29uS1o5ZnhkclczaUd2SnVtOFcrdVBh?=
 =?utf-8?B?UzgxejA1dEhtaG9hMkFINE5KSTNFZVBaZVU5MnEwaDRlUmFKblE0VnZvZWtu?=
 =?utf-8?B?ek5RUDhYOUpMVXhHY08rcDFxTnluYXNheTZIa2hvSGpTdUMvYVo5MjFHWEp2?=
 =?utf-8?B?OHZWYzR0VzV3TDNHNlJyazBFeEx5M283S0RHc1pqdkFtSTVKZUJoQ2NIS2Va?=
 =?utf-8?B?MW14SllOVXJFcng5U0M1N3JZYWt5Y3RsdkszSFFsSFFWdnhOYnlnektJeUI0?=
 =?utf-8?Q?T/XHrumtif8mTR9I=3D?=
X-Exchange-RoutingPolicyChecked: VKn1xVwEujsDYCrexYVhOtFW7tiJ/Zxm8M2VwFPskD0VZ7DZuXt8EOsdHgyB2FIjtJZNW61Jb+5YfhMAwmeDTSa0mZskkEdOnaSTVyQwVQX/U7uEVecUDinl/57c65jGKGXyx7mv+HS++N4922yZh3wtwwmH5GgLSy5c566BOb905zzUZ0TFIzfGTn1onFRhhNo1ntGd0maxE1+VwLxDKD5kFeXTCUtc69l0U0ncdTzmdy/OZK06SLh1hGhQkZ/P2m5zyyPtzLTrrrESy5DGe6wlkJoLUot75w2XUdfg8GYeJh+NT6ete6xhCHEqgW+BwMhMD0LCiJYek1p8nMaoPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 313063be-2f05-4a4e-0714-08de850e04df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:47:19.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHbFynu3A54hYhdBuymrgOG1bz/t0Zp1buFFbbjUgIdWizmsfTFIy7hCXVa82AJZZYYXpnA6hVgeekC1t8mfR6Y00NiUUiN11WhoyveSHZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-269137-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 029772C0688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 16 Mar 2026 18:45:48 +0100

> AF_XDP bind currently accepts zero-copy pool configurations without
> verifying that the device MTU fits into the usable frame space provided
> by the UMEM chunk.
> 
> This becomes a problem since we started to respect tailroom which is
> subtracted from chunk_size (among with headroom). 2k chunk size might
> not provide enough space for standard 1500 MTU, so let us catch such
> settings at bind time.
> 
> This prevents creating an already-invalid setup and complements the
> MTU change restriction for devices with an attached XSK pool.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk_buff_pool.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 2cfc19e363e3..0a6d76df97dc 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  int xp_assign_dev(struct xsk_buff_pool *pool,
>  		  struct net_device *netdev, u16 queue_id, u16 flags)
>  {
> +	bool mbuf = flags & XDP_USE_SG;
>  	bool force_zc, force_copy;
>  	struct netdev_bpf bpf;
>  	int err = 0;
> @@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (err)
>  		return err;
>  
> -	if (flags & XDP_USE_SG)
> +	if (mbuf)
>  		pool->umem->flags |= XDP_UMEM_SG_FLAG;
>  
>  	if (flags & XDP_USE_NEED_WAKEUP)
> @@ -200,11 +201,19 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
>  
> -	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
> +	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
>  
> +	if (!mbuf) {
> +		if (netdev->mtu + netdev->hard_header_len >
> +				xsk_pool_get_rx_frame_size(pool)) {

Misses a corner case with VLAN(s).
hard_header_len is ETH_HLEN for Ethernet devices.

Should be something like

		if (READ_ONCE(netdev->mtu) + ETH_HLEN + 2 * VLAN_HLEN >
		    xsk_pool_get_rx_frame_size(pool))

(note that you also need READ_ONCE(netdev->mtu))

There's also a netdev feature which disables CRC stripping, so
ETH_FCS_LEN could also be included. But the feature is not popular,
thus up to you.

> +			err = -EOPNOTSUPP;
> +			goto err_unreg_pool;
> +		}
> +	}
> +
>  	if (dev_get_min_mp_channel_count(netdev)) {
>  		err = -EBUSY;
>  		goto err_unreg_pool;

Thanks,
Olek

