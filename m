Return-Path: <netdev+bounces-114109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A8940F9F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5062866E7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853661A00D3;
	Tue, 30 Jul 2024 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmqkWWsR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B31A00CE
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335633; cv=fail; b=lJXFnfadXraHBMufwD829SMjCS00JoRjtCd5Z+xzwHHeY4bI1mSzZB3z7CkhkK/6auomi3h7tsBKJoLQFJtpq510hRJ92sRBvTvKib+39wIUESJ+cJSndjWBmFMQfp+ODHRmEi5SlxSXy9OkDup1+a9v0EE+383DYuVvQArnT0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335633; c=relaxed/simple;
	bh=/m+CGLlszHIPLvS56zSYa6yZVrjB74wTEbaimliVC2Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxavKPeL9374kkwbYRR88qrtNVIXdMYA2wfvnzk1wcgKbwXT8RBtMCisHjXHoQNxIplRYR6a1+7lrlaZj7FQH5AOF1HuAdigJPVPiUSttltNR96tWuNsTr3l5uaJF5Ikc7u7dZk83tfszfevo5DpSFd6O5On4qjUm873yqXVmK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmqkWWsR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722335632; x=1753871632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/m+CGLlszHIPLvS56zSYa6yZVrjB74wTEbaimliVC2Y=;
  b=AmqkWWsRNH8HXxvygWb4R/1/6la3H9PnRbyzPxhMJ2ED4gbZDJ1CfV4p
   nFgqsZ3n+ID13w7Xaky4rNT3LHdxNQ53PecEjxodIVL5s3jcstciumW9Q
   ux94Vj5XBIGp39hdFo2AAKTNYTbg2igpABc8ppstW4aqUCziTJ+WEav8m
   2OQGNNYJcv0g6rYknM3/ANPLlHyj8PyG4K74wcEYIYI6M3vBum4f0kGE+
   Ol+rpF7FoqK7tCkGPMggDb+ur3EDZNS83UIvX++FCAeYk588e4h54/ZOn
   X557wSx1ritNg/PFqHKZxQdHIhwxNurXBV40G0pPXICAUOS4pTgHLJmlG
   g==;
X-CSE-ConnectionGUID: D2UbmOxARe68NN3I+pGtRw==
X-CSE-MsgGUID: TAxoDqBsS7q1uv2MOe+DUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31550568"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31550568"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:33:51 -0700
X-CSE-ConnectionGUID: Tzj56YsvQ9uYet3y7YIbeg==
X-CSE-MsgGUID: aZc3PeRfSpydHj8tklj0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54268561"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 03:33:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 03:33:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 03:33:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 03:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBJf/bpI8xVfaZ0m8Bb4rQOzgBs72jD+fS/gFqaMZO2Na+ZIUJ+a9bmKIYPsE+FT8AQV0VzNTBFHpZLbKAPKG2XxcyTP9M7pzxux3PbaK5wrNG+XiSIEFY29w+Mfa69N0ZYZMYso34QyB6mbepOcQZ3nQFvwXfq8KdkfN3TLeLxMiMp3l29KbHae+CSPC7vpUkmbuv6XJZwY66TagEF/zyyLjbBtKxhsYthtBfIM+PM0aYJvbKzchBZn/hty2q7BNjgjO0pla+MYlIKcJVWHA1vGWLOnEFkuWgu7H34K4fKMgqwgl8GRCbZVQvDGP5U8fXPkZRMsLDq046gm192kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgBBo38LVEt1SiTTt8J99z3JBk1JN4iUbJ/FQPTp6oE=;
 b=bAxcsYA+mvP7R1kPBVhtwowOu3O9CcMDcoxGELhSxzWvZAXqVZsY60oUFOiOQtxsiq07r4dJufF51Xisuzy/pc2ciY1J5V5P/DV4AeTb78UYk9YVOqoCvrIKnIZH2d008TFrFbEB8DBC8WXdwG0eNr6l6nvlqUcat7WU1zG+Qgbzaf715kIIrBGCnE9E2BP2G4FhH2cxWTBgepklH0+cIlBvhQRicJodMNAkwCPWHGIKkjCiEMBU5kLYRJFbber49AkuhQbbvj0oIfwU1+6XcIoE6NRnyX+du8153NTGnka678J+fbgZ1Leox3qHvuao6TMWIR5pSI3xhrf51hUICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Tue, 30 Jul
 2024 10:33:47 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:33:47 +0000
Message-ID: <6ae97740-0a1b-4099-bbfb-1d4b783c6be5@intel.com>
Date: Tue, 30 Jul 2024 12:33:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] bnxt_en: only set dev->queue_mgmt_ops if
 BNXT_SUPPORTS_NTUPLE_VNIC
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Chan" <michael.chan@broadcom.com>
References: <20240729205459.2583533-1-dw@davidwei.uk>
 <20240729205459.2583533-4-dw@davidwei.uk>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240729205459.2583533-4-dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|BL3PR11MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bbd51d-a7d1-469b-1445-08dcb083180f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1gyQ1g1MGI4Q055MEwvTzR3T1lvR3RXMkNtcUsxK2ZZVExJS0FLaHptOER6?=
 =?utf-8?B?OWZoMDgra3doYUpCb2U3Zy9wMTZEb1BpbmdCYVB0NTZ1bW4vU3V6STQxblc0?=
 =?utf-8?B?L2NVSmozVmUvQVZuTzBWOFVqK1AyUGdOc3piZUt0UG1pRW5PRkRtcnZ3M0NH?=
 =?utf-8?B?MThFRHBsK1RYUmF2eXM1MXRrZkw1enUvT2I0VDlNWFpvbTBTUVdCdDVjS3pz?=
 =?utf-8?B?cC9qcmdVQW1SR3luSTFNcFdIR2cvNE5PcjE0d1gvMkl1TFV5RGFVUzdReHRJ?=
 =?utf-8?B?VXJMMVlJdEZLSUlTUUMvZnI4cTFDU0g3a1hmT25JY0crZnltYkNpVElYa25D?=
 =?utf-8?B?UGRXS0tQWTYwSmpIaG9tQ1JjTHRLZ0RyZVMzY1JNdE9IMHJQcmEveEpWOFhY?=
 =?utf-8?B?NjR3Z29neWJtOEgyN1c1VmZReGdGMTJRbEM2MzM2VkZpL1Q1ZmJmZEc5bGZR?=
 =?utf-8?B?MmpGZDR5ZERjdFlQQlhRRys4ekRVSEUzSjNKdmswYTFGaUVDMG5CLy96eWx4?=
 =?utf-8?B?enFNNGRmOXBSRlhLTmZFeWQvWUpuaU9Cb3ZPVHMwVmRqVGJocVY2ZHBxKzVF?=
 =?utf-8?B?UWdUVXhEeFZWZzcvNXB6UmU1UGR3SDJ5NjVmeTRtbmwwRXdoT2JmaEFjd05D?=
 =?utf-8?B?eWRHdytiTDhMNy8vTmx6d0RGL0hJdHNMQTZWblJvMWRvV0xSZXZoeUVsVGxw?=
 =?utf-8?B?K1hjaVY3K1ZOTGFFYzFxcjhuYk42enMraFBmMXJPT2xieW9DRUVxSngyMnpu?=
 =?utf-8?B?L25UdFVVZE0ySTVieE9BL290anhmWXNmTnlxRUZxUHNjOFNNRVQySXVzN2cx?=
 =?utf-8?B?dEZPalBtcGhFRHhxS21Nb3RLMUpyMzcyK3h6NitVdjgxWFNnV3c1RW5ZaHNK?=
 =?utf-8?B?T2NYSU5RbC9PV3RUMHpuYlFTeVpEbVVLOU1raDVzM0M1NWVwK0J4SFUxT2dK?=
 =?utf-8?B?ajNnZUp3WXluSElYU2txSndDU0NOc0ZQcDJJaWM3THc3ZUN6dllGMkNFM1ky?=
 =?utf-8?B?Uzc3ak0vbCtJVDNxOU4xWEUya1BzR1RWREo0dUN1UlFPSi9vZ0xmdDhaZ0V5?=
 =?utf-8?B?RlNhdWpSQ2t1MmVxR2VHQTRWaVdReUhDZWFGRVFFZk93bnh0TnlNZElldnZS?=
 =?utf-8?B?N1BuOGJocmIrMnF6UldLOThRVzc2eHdWbm1RMlVTeW42ZHQ5a3lnTDVzSWs3?=
 =?utf-8?B?M2luR0pJK2VJWmVEb2dCSlhaRWdaNGlDeXdyUFJ1UzIzaXRpeVNYU0ErRGtw?=
 =?utf-8?B?dWY4WkpBL2g3Q1c4aUpVSHlKRERtV1lMbWF4bHY2Wm5YUzhOdUNhTk95NC9X?=
 =?utf-8?B?Y1AxajNVRzdQMnBaNkNMRUU0am8wTEdJWGdJaGFLMllNeGZTSFZaVndxQzRS?=
 =?utf-8?B?bVI1MVB4QVlQWnE5andJQ1ZLZkR6S0NSTUhGSitYRTZkRHBNWnZmTE4xRlkw?=
 =?utf-8?B?bDZVU0ozS0o5ekNsVWNFSU5HWS9LVzRBMmsxOFVWQjBQVFlKd3hNT3Nabytj?=
 =?utf-8?B?Y3RmdE5pLzh0SXd2TFFCeDMvTCs4KzlsQXh4K3hvS2V6THlNUEZYc1ZOWEFB?=
 =?utf-8?B?bGFNcXZ6SStvc1ZFRnJDdW8zbVI2ZE5Dak9NYUpKMWN4dVdkR20rQm5keUFh?=
 =?utf-8?B?UUhVRWZGcFZvMUMyZW4rMzZhemJSdTRQd2ZpbjRkMzJ2RWg3UzhlanR0ek9G?=
 =?utf-8?B?Vy9NbHM4dFc0SUVIMlF6a3hXR1JFOGJmblVDY3BRUkZzMmZqZzlvaC9IeUZo?=
 =?utf-8?B?QWJYKy9XZ202ZEFJVWwwMnpHVVA1MjdnNkJWNU5uTzNsaFpzMzNRQnFBVlJW?=
 =?utf-8?B?V01uM0FkcVZhVC9NY3dWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEN0ZWdXa1dWeTZERVN6dDlDZVVEdVZvQ3Q2VktYWHVsVUpLY1Q4NmVrb1pl?=
 =?utf-8?B?SWlqYmFiZjJva3NyZVBPMDF4aGg0M3RGSnhDQzFMRktybVdBeExNZTMyVU1u?=
 =?utf-8?B?OUQ3OWNrYmZBeDl4S3BuVjhqbGZ5blZJTzlEMDhadm52citKRThmNlhBRlJE?=
 =?utf-8?B?L1VFS0xiZC9JM2NuYnIyeG5jcUtqOEw3RTBkNHJ6enpqeDR4bVczQy84R09Q?=
 =?utf-8?B?VHBYSDlsVHhpRFR3aHR0K3IwMHZhY0NqS2tUSjZqcUtGSk41WXRWMENsdFFW?=
 =?utf-8?B?MXhHdmJ1K0Z3RXUzeTZSOHhsdWdCcnRBNHkrODlzWDI5NHVNbVpydEpWNjA3?=
 =?utf-8?B?VkhjTVdQUzdzcXQ2VzcwemtOYjBaSXFWdlV4WS9LZlZlT284Rkt1bEIrUk5n?=
 =?utf-8?B?d2dET05jaUc2U0NJY2Q4SmNDZnhVVTYySTJvV1JwemoxdjUxUmRTNU4rbmNk?=
 =?utf-8?B?NGF5azdXZkNNc2grcUFSM2VHY0piMHlPVUYxTFU2dHlQQU1ndTluV2lmVzZJ?=
 =?utf-8?B?eXFpZVpnbUpIb3hFbzliYXNsNnFQeGtoZXlLa3grQnhVTmF2RzI1V3BTVDBk?=
 =?utf-8?B?MDBYb1crdzE0N3oxWFVRbHdnWWg5OHByR1p5bTBWNytMcTJCMmdHYjJxcCtQ?=
 =?utf-8?B?Lzlha1d6UHFJN2xVZ3VTTmJSWHdiY3JMbE85UytRUjJDMzFwSGtYVTJZZzBY?=
 =?utf-8?B?N3JYY3NlcGFDQVpjeVljeGM5bFBDMzR5akdiVlNTK2ozZVNKcGNZQkxMc1Nj?=
 =?utf-8?B?SGlKRXk3UUNHdHpNMTJvclc1VitZQmw1SEcwL3F6SktFaTg1N096NHdINUtY?=
 =?utf-8?B?UUNHQU9aNkZCejJFZnpWQStuNHdUVk9Ha016b1JoU0cvaG0wUkxvOHBKMDVX?=
 =?utf-8?B?OEhFWFlEdzlwWU0zWCtMUC9VZjQvVUJvVDI5a2Zma2NWZXBSdG9TUm5sQVVK?=
 =?utf-8?B?anRjZnc2UHA3b2pFMEhTK0dIbHppT0NqSHNMSHZpeFRvUG5JM1NsdFRmUVRX?=
 =?utf-8?B?MHNzTTA4cmlrOGJjMnAvaVU4WTNiTnZBRS9jOUpWU2k4bVNEQjdFZjJ6aFl0?=
 =?utf-8?B?dC96TmltSnB0cERESkk4eXJUV1JzVFNiMUtmeSs0MzA2REwzVCt6Qi9oNWtV?=
 =?utf-8?B?Q1RTVVdNQ3FScXhqaXFFczNnWi9Ea2NVZk9tbmZUNEJHTzYyYzU2ZGZ0Yjkz?=
 =?utf-8?B?eEJtQW5iNzlBTUM3am9iTUJhdmowdHZXemxITmFwcGFGMzVZQVhnQlhoVURC?=
 =?utf-8?B?UER6SlNqQyttWlhIdTNyNmFsRlJ0bVF4WDNKeHJ0K3FMK0Jnb2xZSHZpMFdJ?=
 =?utf-8?B?Um44czluODZVWU9ZR2QwcE9NdGFQZ3hTQ0pPOVB0Q3RuYWZNcGNXWTRKR2wv?=
 =?utf-8?B?YWU1UTJNWnptZ1YxRjllbURRbS9ZOU5nUkVMS2Q0cXkrK1dFeVlNWWNQYkx0?=
 =?utf-8?B?YmZIcWxRWG81b0NzdDdiMnU4eE11bXd3TE1vc3F2dVNxWWQ1KytSdW5hS293?=
 =?utf-8?B?TDJ5dXAyWU53UFV5U0lqZmFodWxhOFozV1doN0JRckhBdjlTQ2lKb2ZmZzVi?=
 =?utf-8?B?Q25tcC8xT1dIR2lKTm0zTHlzcnh6eWpYdkEwZ2lBTTZkQzdjM2wrTXI3QVBz?=
 =?utf-8?B?VmhwblRTSzVQdWRtMHhHZnRCR2EvQ1BTaXBLTTFxYWNWS2JkOTFwQmFQdTI2?=
 =?utf-8?B?Uk1LcllBelduNzlwWDFaeUcvc2syQnVWNGRDNEQ1YWNDWnRkN1BHVGswdmVr?=
 =?utf-8?B?VGMyaXRnSWlRQzVzSmdsTlJHWlVsbFFQY0hUaisvLzJkYldVRXl3WDNFWTlB?=
 =?utf-8?B?dHdYaWk3MW5oNlBWVU9Qc0NySU5nWExPWDB5Z2tuM3Z5dkZ6WEdGcjBsQ29Y?=
 =?utf-8?B?NFIxdlBrYVZ5UXpXWWNaV21LSWlUR3FMREFZdis5YlBHdUVSem8xN3NpMHBP?=
 =?utf-8?B?eVVYTEMvTFZQVUp5ZmVtUDRiMGoxeHprRTR0ZDR2eGk3S1phNUhheTJpWkg0?=
 =?utf-8?B?UitZZE5vTTE0K041MWw5Ykw1d1g5SGUrVGhXQmNPcDlhWjJqMGZ5YVZDczNE?=
 =?utf-8?B?aXZLUUV5VUtYSTRCNEFJQTA5TzkyVnNxcWlDYzBGRDB2MGRaQUdvOGhZZWoy?=
 =?utf-8?B?bDFkVDhHS3pWWExMT2NpK05za2ZSUjVhVEp0SFpsWmVOUlpYVmlpVGxuT01q?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bbd51d-a7d1-469b-1445-08dcb083180f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:33:47.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EtUEUaNLjOK25+dl9Sj+eZreKsuwuiHbZQ6WdWkPFxDwisxrORWN8LXzVF9nXujkWcEv5CRWgpwRkqZ8unfvFBoNvKBmQa8OpJ8jbfyh7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com



On 29.07.2024 22:54, David Wei wrote:
> The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
> packets. It can only be called if BNXT_SUPPORTS_NTUPLE_VNIC(), so key
> support for it by only setting queue_mgmt_ops if this is true.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ce60c9322fe6..2801ae94d87b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15713,7 +15713,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	dev->stat_ops = &bnxt_stat_ops;
>  	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>  	dev->ethtool_ops = &bnxt_ethtool_ops;
> -	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
>  	pci_set_drvdata(pdev, dev);
>  
>  	rc = bnxt_alloc_hwrm_resources(bp);
> @@ -15892,8 +15891,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	INIT_LIST_HEAD(&bp->usr_fltr_list);
>  
> -	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
> +	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
>  		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
> +		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> +	}
>  
>  	rc = register_netdev(dev);
>  	if (rc)

