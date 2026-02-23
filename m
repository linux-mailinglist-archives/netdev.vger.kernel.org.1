Return-Path: <netdev+bounces-260124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEcBK22JnGlWJQQAu9opvQ
	(envelope-from <netdev+bounces-260124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:07:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7D17A599
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCB6330022BF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B56328B77;
	Mon, 23 Feb 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5nNjzM2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF932AADB
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866473; cv=fail; b=VoJgnAoRUzTlZcNiBnm2NoC0wPYg44yQWwonPx3IPNGqp83TeJ9MPzWdqNne3aecyc1GMN4Ko3gDCNA8CufWu7IHEJt6LkAiFs3snxz5eJ4A9x7Wu9e+2wQJiiYXDU5k+g7S2jlfbMV9qpxo7kvPjGnN5xfcMXsT0+DBWmSnaLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866473; c=relaxed/simple;
	bh=dDbSpnrfwdQFcDgjmUXndxFkZ1bIh8SSw4oZSL9a6hE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E7iMtxPCcpPI7FZS5WpYzHrcBi4Gzeu/ahWgZRx1hkD2fUg9SThd31pi3hsilC9/+aYsR/BPDor2MuGF23K1Z5Sl2p28Y6sjfv9RpMoq/xAW057kdDRTdu+A/7LIs9hHetnT7w0xJcJdgQpIAkCb87jq/oHv9waKZVyPh5QO6O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5nNjzM2; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866466; x=1803402466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dDbSpnrfwdQFcDgjmUXndxFkZ1bIh8SSw4oZSL9a6hE=;
  b=K5nNjzM2/pTdEBg/7mj3GQwvXLhYnaRoXk7Qv0b3KSzgr5S0Zq3BoL9Q
   8789nJg/uiUJ1KnLHNPDMhCxwrAM1lvPxqt+QQuQ77553edFivTep3LC1
   TGhfxmisEW9flz7tD1eoEm+esPUWDGrHJvhtsWMScy8d8SJPe0/gAzXTv
   1AGbsbkq4zjrjft3QFisH4IWh2wcCj4l2cFzAHDJReeXd5h/Pl7fmzQqm
   xCVlc+iTJ1xHXl51FKyV6tpH9OeiEl1w6wSU2cVSWPHsWBm9SierwSQpc
   UqBeG47/iDu0kVBSkT/pZZovsfDxGMKSPw2Db13YBgyTOYXtaBiDlbuAb
   g==;
X-CSE-ConnectionGUID: eXiej4DAQgu1VPBqjniZUg==
X-CSE-MsgGUID: 6zBkqiHZQm2Vx4386C3xMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84319288"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84319288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:07:45 -0800
X-CSE-ConnectionGUID: Ixe/FyLZTgOZk3dza9mHUQ==
X-CSE-MsgGUID: E3sxlUvhSaOnWc6JFXJdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220177520"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:07:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:07:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:07:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:07:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x56NZOVJ1YcIm1bvGapTKdIjKDcnq1Qkr0yvzGBGac11/bGu3slrThFtCyTd6Icelnk2RGrwCDXrN/NAOrMzNP37eWFmNhYv0KWIgmDNcB7awuaQvdGYvluy85M7VdsXw2zPmCbQ778hvV6t+JIExFTzfdmu0xEbL5cAM0hfgqQTkeRqcTyNhzHXRp+5fZ7+BVtsJUFNRLgNE9Pfg1YI36uQJH28s8onzTZQ370eUjoEnK6iRfM0i0y8VfNyW/wFaXhj0TPgZ4OSuQDuquu/6jZFpKycaCFPPLGjpllSEyAL3oAvjRx+Uisum5yBuIENKj0OUOHRbTiWyfAeWfjXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk7GU/z4WuO1T/M8uW5NL10Wat1rjANdZydTo9FtVFA=;
 b=gkaol5jRfAXYDx4+yAy/ZTv8J6CdClXexuvxcRoKFB4bNIuBcdh9nfwz5kTL72pyCJuED0Ey0kQql+5E1DVgDaDkz2/FFssJNiSJXhZGotaJnZIr9yHYJbG3SRJKueD2Ng1R1Tjl7t/gz3r7hPhe5kEO/5UomxWB1Wr9Q7g3HM/n+jgJux2q5plvGtQEcHpKpI9d53jVvhMxlTyMM6ktkmK8jFyQDnTJzPpVGoCGxm7FM7tLfwIQstVWBzZRnyTgSoin7Q+fPR0cGTW/S16a9fVTWLZ3GmxECSdjele3bZTbSFz9ynm+Wyjtt7nHZIlvfijKbvpCLhdkhKfJh0EHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 23 Feb
 2026 17:07:40 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:07:40 +0000
Message-ID: <79b0f862-c62c-4069-b39c-2574e6025c0d@intel.com>
Date: Mon, 23 Feb 2026 09:07:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in error
 path of ice_set_ringparam()
To: Tony Nguyen <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Kohei Enju <kohei@enjuk.jp>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alice Michael <alice.michael@intel.com>, "Fijalkowski,
 Maciej" <maciej.fijalkowski@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
References: <20260220184031.60113-1-kohei@enjuk.jp>
 <IA3PR11MB89864DB144A3D8990E6512D5E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <b57460ab-d523-4e2b-ada3-4d338dea6701@intel.com>
 <81f91e12-599b-49e7-9299-cfecb994cb6f@intel.com>
Content-Language: en-US
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <81f91e12-599b-49e7-9299-cfecb994cb6f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BY1PR11MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dbbda6-19e6-40c6-f80e-08de72fe0d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE04aHRqbHhmNHc3UmZXSGJkRGVPNXA1M3VPR2R1cUYxekN0R1NVTk1Kaitp?=
 =?utf-8?B?K2NVWXZkdWl4Y1M2RVplaDgvTS9Pc2RiUHNMSGZHcUIrZTBCcFZMWnRyT2Rm?=
 =?utf-8?B?OVZJb2Y2Sm9iMmhRcVNPNkhDT0liZTIwV2pIdnczNDlQYThVMzYvRkVleFRw?=
 =?utf-8?B?eUNyN1NLSGJzMnB0ekZBelhEbUdCRzd5L1h1MTN5NXhtVldxRDBNMUtNOVNp?=
 =?utf-8?B?c20yTEhOb3VVMEIvRUh2LzZyd1hvaGhzMGxwaVQ1M0hWT0NydmY3K0pzK3Ay?=
 =?utf-8?B?ZXhtSTdQSWpTRzJ6RzYxSFBvRzlCQkd5OWtHMHNEZFVndnpGRmdERklTVmVx?=
 =?utf-8?B?Z1I1UGNZNUdwZzVURFRuK0oyTkQ0TDJ4TFRLR3ZNcXFRU1k0aTVjR0IwWUdU?=
 =?utf-8?B?L3o1NTIxM2M5bVdRT1d4dUNEMWNiVjdhZWI4YzVzRTR0MFNNSkNGRm5iZzcr?=
 =?utf-8?B?NWxnemJia3VQN2hRZ3F3STQzOHd2ZnYwRTVzSjBnYTZpZC9VUDhVaEtFU29v?=
 =?utf-8?B?MU5kem1GWjBHSm8xQ3FtU2daWGFZbnRJRjhKNVpydmNNUXp2QjNMVm9hTllw?=
 =?utf-8?B?ZXJmTVhQTENQbjVCVHpTTWpmNmdWMThxUVJHZWtIVVYyRUZZS2czRE4yK1lj?=
 =?utf-8?B?L2RmRmF5SSszRVBkcnV4SWNzUEdTQXpuSUJ6am8xc0tCMDR6UEpyN3o3aG84?=
 =?utf-8?B?VGI1bUs0SmZLckZ5MFRMc0pieTVCSDREMVREM2loL1REamdJM08ySXFsb2tr?=
 =?utf-8?B?MFU2anRWQmVUcXFLalgxeFloY2dFU1c4L3dpR05peUkzK3JpZmlXdndadnZP?=
 =?utf-8?B?WW9OMUVDZnU5UlozSi90ZFhJSG5FY1dOUFNZb2hxM0JxSUdNZGt0Tzdma1A2?=
 =?utf-8?B?RUl3UUg5cytqUFJBMWVMaW40bWZlSElzcmY0aHNrUXNULzFEcSs5VzV0MHdx?=
 =?utf-8?B?c0VSQVYzOW02V1EzcmhYOFlhUE53Tk9Fd2VKRHJ1MnVUTVNXTjk0YzlXY3Rp?=
 =?utf-8?B?bWxpUXIrM3BEa1dURjE5aGtPR3JvbFhmY0d0RXV6NnoyWEs1SXBZSk1ONVJa?=
 =?utf-8?B?WGo1aEpIeElqTGFpY3JhekdWdi9VREIyanVocitGT1MyNndOM21lbm1DanZw?=
 =?utf-8?B?Y3ppZzNMSTB5TkJxNjlOTXl4ck0zcHV1WGpzZG5DQ2hPM0diMnlRRXhtY2NB?=
 =?utf-8?B?b0t6ZVR6THIyVjAzWThkSmZKS2MvQ2FFYm9LNVY1Z29vV1hCdHlwcWxuQWlD?=
 =?utf-8?B?SU1NVzVWOEtxelExeWV4c0FEMTFVV0tkV1lIZEhZRGZyTnVaTHFibnBuOFla?=
 =?utf-8?B?QmR1Y2pBeTE5OGdMUkVraEhZcHliSVdXOThBSHJFRW85aWRjcFBNSlpZb3pq?=
 =?utf-8?B?K2VsYTZkTmRTbTgxeTBwdlFESWVmMVRIK1NiQzVFRjZiR0xFUERJVHZhUzRx?=
 =?utf-8?B?cHkyc28yaTcycTJUcTRsaWJxbnVQVzBuS2taNVRTNGJyZGI3SjI3b0JlK1FP?=
 =?utf-8?B?RVNxOVduMjMydGZvQVYvZkFKVU1KaWRTVFBqOHM3U0FMSDJaaTRhMTFBeUFB?=
 =?utf-8?B?ZmltcTMrOVBJUXJxN0s4cG1kYWt2SFZaVXVvZkhKbmhvODJiSzRWc1F1WGg1?=
 =?utf-8?B?RzRoRXVUMzJYRVUrNTduQWNqeDRoTWtFV2orSTlBTEZiWHlJS2xYd0NqaTBm?=
 =?utf-8?B?R0RKVVZNcEFTQXJVbTBBM2JtVXg2bktaMUlTU290S1h4bFp5aTllYmRyN2gr?=
 =?utf-8?B?L0RWODU3REIxS01CRDJhbWpnR3hzSER6S0cvZEZmaWRub0xqcVN6QlcreUdQ?=
 =?utf-8?B?a3B4T0RJUEpyUXFiKzMvbndPcTJ2L0dYQkh4cE1sV3h0U1E2RFpxcFk0QXBw?=
 =?utf-8?B?K0hDMFNadDhTdXlvU3kwRUJTNjdSN3Yvd2k1RVZMV0dUb2tTZmY0UUE2YUFC?=
 =?utf-8?B?ZlNKMmk1YVRJeHBZSHFQMmJxc2QxMXpIYnZjZHFDbzg4dEZVR2ExVysvSjYw?=
 =?utf-8?B?YVVZZGVIOTUxSjlPcmV2dWF6aW5aNTJGcmNUNytmQ09rZ2xLYndQNEwxaW5x?=
 =?utf-8?B?ZExXc3phUkZUU1Nvb1BLVGIwdE9jdVBDWk9zVGtQRFB6RGRzbGdjS0VnY1E3?=
 =?utf-8?Q?Rvqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjFnWklqWVZOR2svcXNkbkl0NkRISFZFdnJmY3RZd2NpYzBUZ1VGT1dNUnc3?=
 =?utf-8?B?UHFkWmVPV1BYTXVBNHAvRE9iSWtaaWJKTXFTY3E0RU1LSkZZUW1KQXQ4VEw4?=
 =?utf-8?B?U1haWTRsNDM4enJsL0RyOXhQVEpld0Y3QkJTTGN4ZmZ6d1J2MVdJZTlwS1F5?=
 =?utf-8?B?QVI5YVE1NnF2ZGc1OWFPQ25WZjE4bWZxU2lzeHFweEJvd3J1cjhORGZiQ1RP?=
 =?utf-8?B?a3pPZnBFMXZ4ajl0eHBCNGpxV0FZSW4zNlRCMW80eXlzVVduekNSdkl2bEdm?=
 =?utf-8?B?OVhTNEhPb1JQU2g2SVY4eU0yK0RkZXFJYUpTWUFaU1FXUjZQTG9pRTNFWXZB?=
 =?utf-8?B?M3k2Ty9UL21YM1hiRUJQZC9yakFJNkhpTnltVjNOek1RaVc4UzVPMTJpbTZV?=
 =?utf-8?B?UENjSlhSWnNITlc4Z2ttRE1pYy8xZHl1cllETGFhc2NtOFhwRC9OdS84Uzdl?=
 =?utf-8?B?RlVBSmozNk4vOVhOVWRjTG1pc0k3MWU0T3dhbFdYVXlnOWdmWVFuL2NxTEs4?=
 =?utf-8?B?dnB5UGJySDl3Nys5cUorS0pWdUpFWkZqT3J5YUdJZ3Z4NTl2WnQvd2t2ZnF1?=
 =?utf-8?B?RmxoVE5wSGhjYTh2T0FwdlJQV1FUOW1seFd4RGRqV2dZdzE5czc2NTE2Q3Vi?=
 =?utf-8?B?K0IxUmVOYlYyTVRFaDFaenNpdnN0ZHZNNnB1K2FqYVNvMnFUUGVXSlhkMjRF?=
 =?utf-8?B?YW9FeVdhNXFkZFN2b1YwS1duWGVtZ2g1emoyWEN3MGxFZThPcTZ4L1MxQ1RQ?=
 =?utf-8?B?TWxFUCtOL28wRUVvaDJmeEcxSU5YQlJtZ1I2M2pYenlWbzhqN0ZEOXNtbXRC?=
 =?utf-8?B?UUgrZkpkVExHL05xSGlIRjZhazQ0eTJLR2MrR1lZSnRxNTdpbml0R21MemVH?=
 =?utf-8?B?L0JwUmFqdGlDWkk0WU5lM2dDclBhWE13Y0U3WlVMN1Q0b2NLM1JRUEFYYVhK?=
 =?utf-8?B?Szh6dWF4WG8vWmlZS2lpVUladWQvd0U5NCs3dWg3dmlPL0tQT3I3YU4yMGJ6?=
 =?utf-8?B?M2RmbDVnRUhNQTZXc0I4M1pEQTdiTlpzSkxqc200SHVzKzFNQm1meDBVTDJX?=
 =?utf-8?B?WVVWQXB3M0dJZHpSWklWaStkRjJVaUdySTJQUVMvdjVGUDBwQktGU2RpSThH?=
 =?utf-8?B?eFpFeXBZOVJRWU01VDVyQSswQmQ5OTg3ZHJBZnoyY3krZ1FzZ2JCbkRrS1N2?=
 =?utf-8?B?ZS9BSzNGOU1KRVJiNTdaSXMvQ1cxLzlMOGFmSE14MTRYUThYRHhpQkJJK3hU?=
 =?utf-8?B?TVVMR1Fkc2Rpa1l6MHN0blU3ZmJrUWRGNkpBemtWS0dTeTBjNVhTSDZVOVZG?=
 =?utf-8?B?ZWFMODRpcFphSkc0c2ZpOVZlcXFkanNteFd6WmpZWFZvN3VKSFZxRkJLeXNp?=
 =?utf-8?B?eld2RFc3SnhFOHJtcEtCUHBWUlJOVU5kejdkRkxFNTlrMXlvRDZNVERoUmJO?=
 =?utf-8?B?N0lSVlRSeFRiODhxMWNKWEFSTDE5NVk4OXh1NWFrZUpJTjZhWTYwK0x1dUF3?=
 =?utf-8?B?Z0tReU5BUWdmZ0hnQVQ2U2xSckg2SVZPejJKNzNaN0ZNRnRmVmRmSlU3NVNa?=
 =?utf-8?B?TGZST3Qvd1IrQzdjeHpVK2FDVERxQ1IvejV0WkdYSUFUZUJ3Ujl2SkE5ZFps?=
 =?utf-8?B?U1o0azhUWjJTSVpLTU9RazBubVZYY2xjbHJqSHNEakNIZ1crZFZlTVA0QTVK?=
 =?utf-8?B?TTZTVVVjdEV2ZmpiSCs3dkhsa2l6Wm5tYkxua3VIbVVTWjdnTkY4TUZpUDlZ?=
 =?utf-8?B?dkZrN3QwUVJZZjREY0k1SllhSWxWOHY5MC9sQi9WQ3dISEpHeVJld015WE5J?=
 =?utf-8?B?N3dBZTdNT3NobkJaNTBNWDkrLzRUYzZFTW9zRWZENkNjVEVic3pYMFJ0MjJz?=
 =?utf-8?B?TnpMV01uMERKTkw4MEMwbmNEbDBONHVrSElFd2pFcWFtZXUyNGQ5a2lwQzN2?=
 =?utf-8?B?SlRMVFpUZmlrOG5yQnAwV2Z5djhqNDd0R1psOTlwelBRUTNmZHpBTmp0aVo5?=
 =?utf-8?B?dHVOSmpYSUZSSlhSb2JudmdnOHAydjJtVjM3SXYyL3pvM050YWJZbTBlSkhO?=
 =?utf-8?B?MkJRQU1aZld0UzRJU3N2SlNEM3loK1JOV3M4dDNIRkQ4RVZRODkycXF3dGE4?=
 =?utf-8?B?UWpwcjlVak5UVlh0eVVrdUFNT3FIbkNVeTg2Y3lXRHk4OC83TVJhMFdoNVlk?=
 =?utf-8?B?R2NtN0I2ck80aVZQL1JwZmx1c0lZaXpUcUJTcEZVaTl1UEJlcDZkUnZtS0k5?=
 =?utf-8?B?eUc5WVo1THk3aW1RVURjd0hkWkNJdElxejJISWNRVlpHSmZuNlk4MG1weitn?=
 =?utf-8?B?Sy9XVnRsNlhCMWVqZ0UwZURZS3N2Z1N3RHV1NzlwdEEzK2RDYkZ3dEovWFh3?=
 =?utf-8?Q?AYQT0hyxaDDLGxjU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dbbda6-19e6-40c6-f80e-08de72fe0d4b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 17:07:40.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjuRML3WlEg3qICmik+Gvslnhi7dB0cfAm3qx96b7vbsvCLkOEAwMYWAHX4eAt1MOf3RkDraS9aUopaEiNCNUAxwijkwkwQ878Z5h/FkL5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8127
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260124-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.greenwalt@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0AE7D17A599
X-Rspamd-Action: no action



On 2/20/2026 5:50 PM, Tony Nguyen wrote:
> 
> 
> On 2/20/2026 4:35 PM, Greenwalt, Paul wrote:
>>
>>
>> On 2/20/2026 12:04 PM, Loktionov, Aleksandr wrote:
> 
> ...
> 
>> Also, per Alex's comment, please target 'net'.
> 
> Since this is for an Intel driver, iwl-net is the correct target.
> 
> Also, as was responded, this works off changes that are only on net-
> queue at the moment.
> 
> https://lore.kernel.org/intel-wired-lan/20260220204526.7514-1-
> kohei@enjuk.jp/
> 

Thanks for the clarification Kohei and Tony.

Reviewed-by: Paul Greenwalt <paul.greenwalt@intel.com>

> Thanks,
> Tony


