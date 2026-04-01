Return-Path: <netdev+bounces-273892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLimNzirzGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77803374DAC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A7B6301B7AC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400492D061C;
	Wed,  1 Apr 2026 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm7nO1XM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9771A9F82;
	Wed,  1 Apr 2026 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020850; cv=fail; b=eBu68Q20M4VEzVFghpZXdSMnjNlHyyDn+caRfm8fUbOcsMZT6cuKKJ20xOw1hdnmb21VeMHKdOCfoMAIdV3vGUXj0eBZGSwQFG/7/wX2deRaSFU+a5wjfj/ofVOV41lh3qZfUTzIbZE9sp78SRnZbP3NL0XAl8NRgojvc6Gdq8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020850; c=relaxed/simple;
	bh=IJMSQEcZzQ+Hpq3eqOWLCYlBO7oPINiEsJVS5uVO/rk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=coX1OkRdMPIIBDjdTriqaBdEQ8CFN6QI0g2QeKUNDf7pKD2jbZ2dYehfM/U1fVKYdrCKkIK5G0MtFkSFnTESOHaRjvghM5mqHdtVQCGwbj/1fOg/4fNrcqUIssAFBWqTYSIrGAfE2/lvbYa+ecnZ8SBjXpw6Zjwyxt4drNmgX+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm7nO1XM; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775020850; x=1806556850;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=IJMSQEcZzQ+Hpq3eqOWLCYlBO7oPINiEsJVS5uVO/rk=;
  b=nm7nO1XM1WBecT2OpGwtwwc3/zJKBZh2nvzoixRGcob3cET4ogXG9uDk
   JCFiSzxQ8Az17kFv5c0w6Nzl2HaAiXiKgXqkbkEAg1B5ao8dDk7rasbWN
   Trx+v3KxhKRSR8jirpX/UGfldyefKsbzZtxWfHQ97uiI7VIeZhqjMJsD3
   kJIM6GeYc211zqZ3mW4L6Q5N0uuolhDWDUdz1GytTdP+4CWj5EsYtRrXG
   ry23FP//nbJBq6zaTqWslrHT+H3uOgGhHKQVVmzsUNtdmFCrRWpwuvYt+
   kjTc+UAcg1yj2RB+4y8su7mibGDtI7oAP2GFBExqcRl2Jo9S5pl0lYYWh
   w==;
X-CSE-ConnectionGUID: SnR8FnyZSNijEMnUeWHjaw==
X-CSE-MsgGUID: pBSxcbngToS1C+MJb5cnsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76008628"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76008628"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:20:49 -0700
X-CSE-ConnectionGUID: tVxVdwYqRr2Bs0mOMNgg8w==
X-CSE-MsgGUID: tMBKPptaRFef8J0NAVn1fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="222185121"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:20:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:20:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:20:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcVqChVjUj/uuk1nunsoaaWnr7c3XO8nERRk259/3ngS5KYDY5/fKLWLwPwnqyPrd8AmK/bLBoew524sToiHnqU8RoDPmVRzHJljBn/j0TjK9/1pxCSnH51h/328gw5cJD4kLLdrwsN7xebW2D01NVu8jHqDAWDRcZzZ3VPdCG5TubldDDx5OPxSfcNwNQsogeVTnznV8qh72ffaPcZTLqsS8q97u/GPtwjZ7p7WcbODh8J16VOPu/ncxSSjKkIxmApsqjTw5dXUHr1ub3UCdXbDB1lxkx+d6dQcgR6TgX+HFrBIbn1KD4MPJAKIb94ATs5tgMxOsjpQQEhri4T4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCsgW6ZM5+3XLbTXzNIkHFgt0Bd7q88tdHONJHcdUP0=;
 b=YLd3ub2htHjyb5AomZ3p+spB7XU1Wldks2EqWOU4Zw/Nq6JrdtcTFadHs37VzdTeKThxQ77DsVkiu+eR+y/a8u4qL0HcMLRatxTUnXumMhOSLIiJ0kq7TRqptR/z1fcz6qXsa/4FG/b8mt1WGaRrVTTp+CYi3mwtGo71iOelcCiZoROLnh/NgdzorPtzxd4mt2kbMeOb6mxedfucdAFCF91o97zO0Fxa6shvXmKrq5VkvcqpTwlzqz3miKf7MHZC0m/Qq/fWaf7J1kTINQphQamHO6b//Lc4Ckz0aJLcYAilWVSGHy++bm8JtqQARR2nZyucEuJzJU6VsjSFb0WZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 05:20:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:20:43 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 22:20:40 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Message-ID: <69ccab28a9896_1b0cc61003e@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-8-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-8-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 07/11] cxl: Add function for obtaining region range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF5217261E0:EE_
X-MS-Office365-Filtering-Correlation-Id: e346e163-5b74-4c9a-3189-08de8fae6c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LMFWlTqivuF9Eo92p0uAAFb9bFHTOjnDEGdrYVPJ6/wKnTD0Hi4scM+fwPx2vrZ6J6yeG+TIS0HLjjd1GmoQ7hiDW0kaM1dMESukhDj0PPgprFqCCuAt0ii4MhPj03dcG/dI+41S/Yl+sBVATJziuhuinHzF9EuNDYs++c5J6T76glsz48LzGnnEi++ocQj9nt9cpbCsFfB+lVwN5EFlXirEUsVxSRphSUTVhkQ/mK4nyghN18iw0OerGmQXv0ykzCtG/5hB2pzJnyuet0I3FoyEKrr7rO39h5rPcetmVy3PbTrZTjxsKjwfBVXUIFTbEJB3pOF5xVmtAtycKYJgqsJiv5tDoaeApmV2mdMZvumZLuoFMuuXmOAO6eZi2droEpPe7Fudq4SECHMlErA5kHDBeoqfq1IbGNeINH/eDz7JcIIbyoDUmKegtPvoEYRtqjFmzYzyCUVXjNlmgYheZYU5Y9fEIE+uhInL2Ogt2NElEoYabq5XuR71jIN7O+2Y5Kztyz9xRTyiLgrqYJIQbmNPLTg+GrhIv7dhZrzVUUAB/itxdjCwAtKLJ1k4wL6ianIY71avyWuIUzE6uoSIyBUTyJo6V8UZNJEwZq7v16WujP9XsbxTImHlfjOWUIA6/YLf0ywJqCQg7VBvswsgZAQo7W3lBmBsv9xddBk4+8MlmsmpHlidSyVxWTGQ+SUMA7bPPKnPTl6UD0jl2n1QyCepBA1nmZYkZY2I9QRt11TMqezbVi+zGq5kS0upEBrRr39mRGuz9lUrwojxCqu3Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJWOE4rT1VWbVYzNEMvUlc0WVVFeGZFY0NaTkRkSkFOQWNqR1haK0lRQ2dC?=
 =?utf-8?B?cGlOQjdlUSs2NmkzTlVQOWNvSlNqNlorOHJaekNvclJXVHhsL1h3UnQ0RlJW?=
 =?utf-8?B?OFo1aGtZMGpFNEROWWc5UVJUSTRpUjNybWVTK20wV01nSkVOZG14aEJTQjNz?=
 =?utf-8?B?WmhlbS9ZWVpLbVZaSEJaYXhBQit5VUR1Mm1SU3lDOHlvMS8ralBnNnlvbWJs?=
 =?utf-8?B?RVBpWStUQXdOYnNrTGJTOEx5UEhFcVdQVWVSS0gyblRMMWE3TXJqcE9JQkZv?=
 =?utf-8?B?RVRiaHFUV2VVZHhydy9Cb2tUU3ZQak8weDR1SS9CN3o3T1FZS1lPZHo0SWhI?=
 =?utf-8?B?TE0yb2trUlFvYktSK0N4U1ZlMVVuM3VKelBqUHVzbUZuaG9PazY4WVRGQ3Y3?=
 =?utf-8?B?U0IzaGZiclI0bnRqbEUyTWtHNjBXK0xoRGNTZTRqMG94VFJRMzZDSEhyV1pS?=
 =?utf-8?B?S1REK2gyNml6L25MZHI5Sy9jMlZ4dG9YWUpHdTdsTUdXclJBVFgzS3FPREh5?=
 =?utf-8?B?d3B0TUxFd20vVmZxRTI5dTBrSHlzRU4zS3ZnQTlWODA4SUtObktza29lc1NG?=
 =?utf-8?B?ZWtmdWdFMkFrcDAvYm9lZ1QxQTExWVVhOGJDVlJXbFRjdVBqQjl2N2M3dlBQ?=
 =?utf-8?B?bDdlYVFZZTcrdWRmNFpOaThXamtaeDJlU3k4c3hmU3hjREJkY3pyalZBOWU1?=
 =?utf-8?B?QlBqWWMxOUlQZVo3V253Rnc4ekpIQktYdVVLQ3dkWnlrbDRacllXYWI2WjV4?=
 =?utf-8?B?cUd6UEd4cktZZDlEbGlNM2JtYk04MFAzN3pIVWY0YUY4U0ptbkxHN2JoNTRE?=
 =?utf-8?B?TXJzejZXWEtybVo5RWFYSFduMjFJV0JDekRPY1BVTUFneW95TExVUnFrMzFZ?=
 =?utf-8?B?cWM0SW9xejZ1dEgyZ1Jsd2pYQmEwU2R2WElhdHpPcnR3K284ZXlqOWlvR0F1?=
 =?utf-8?B?UTZ3UlFsS2oxUGdvRm1UQk14MW5pYmd1cjdNa25JQjJBRGpSWldxNTVBS01U?=
 =?utf-8?B?MTJLbjFBbzVvbnZkSGxERGc2Z0VtWmNXck95aURsbnRnaXhUM1B2KzJ0MmZk?=
 =?utf-8?B?WmNsVzRMcW1jSVJjOWJWR01nSG5zdW85VUFNQ1I2MWN2b0MyNHFFaVl0RDc0?=
 =?utf-8?B?bTZsM2VQMzMwY2ZLdmpPTFVKQ016czRndEx0VjNFVERtTjh1ZlJWRVhuWGM1?=
 =?utf-8?B?bDlGZlR1L1hIY0lPVVJKMy80aG8yU1lKZ2lOeUhGa2p6YTNDQjRGWVdGNkN2?=
 =?utf-8?B?K09TcjdDSENyQk5IWXQ0NFg0ZTIxbFdSSk5wTXhoKzB3VUdYVWZ4NEdjN2RC?=
 =?utf-8?B?WGg4cGhJODEvOGF3OWZ4VktLSjh2S3VRcENhL2ZuT1JXWkJaUHlsbmxoZHJS?=
 =?utf-8?B?NnRCK2MwZGFtV09KTjhWVzlDcFgvYk1nMktYYm4wa1dmUit6cmlXNzNHd2dO?=
 =?utf-8?B?L0NDdDRpYitDNWJlY3pzcGMrOGVQRlhUT1Y5RWZPRUVSaFVSTENJZ2xGUStE?=
 =?utf-8?B?NkJ5OGpZQWFPa1JGRHdvR1p2WEo0Rjc0TDVzcnhjOURPSzhoZFhnakpVc09N?=
 =?utf-8?B?OXVmbysvTU9EM0hmcWZtclREMUo2bFY1NEt3bmdVWTVBSjBjejFvOWhoaEFm?=
 =?utf-8?B?Qk4wVEdORWJFSjJrSFo4Vk9OSGlURHF2NndOZittWm9ZK2Q2Smo0NlMxbFJl?=
 =?utf-8?B?MXQzSkxHM1ZWTFgvN3VyMVk2aFlLaUF1RWxZd0dHUDN1VmNzdzN0bnJrNnlu?=
 =?utf-8?B?QU5zcnJLVnh4SVNCRkNzdmp3aXRrcTZvU2NJbERoVHVqa1hHc0F6TmZYV2s2?=
 =?utf-8?B?MS8wdnZHNnRlbmhzZUNyd0xINEVMNkgyRWg3aU5aMzNaT3BDeCtkZFhFNC9x?=
 =?utf-8?B?cGtPUlFpTnlnTEJBNTlwb0V6RjFMb1VlcTNzUU42SEhMSG9iZTBpUDVOOGhJ?=
 =?utf-8?B?c0tMSkp5bmpRVlhFYnpSY0hlaW1qeUdsazY2eVI2c0sxdExZQ1JOUllrWGFx?=
 =?utf-8?B?d0pKNEVScG9HWDR3Y2RvSnAyUS81dUFTSUVBdFVoSHRlcmVLdnVIVHdOTlZW?=
 =?utf-8?B?V0FmblVZQzBvUC9mOHdnZWVKY2ptSUZGS0pvV3lLS2JGbEptR3BaNWFpUElj?=
 =?utf-8?B?RFFBNXoxSVozSFNnODRGSUJrYU9VQ1UyQXl0dXpkSDllV0I4UlBDWDUvYVhN?=
 =?utf-8?B?cE1uRVI2NDVBejViVXJpQk83cmozOWM2dmtXY1c1eCtLeU80Zzl0VDlaYTF5?=
 =?utf-8?B?TS81NGZVNitFYzhic2hYNTQ4WjM4SDVtRjN6NHpDV2UyS2ZjUGVBUERMZ0hT?=
 =?utf-8?B?RjFnVWFiU2t4aFBuV09OMUdOVmo2MDEzRnpka1BHYW9LZjRweG9tS3o0TEdR?=
 =?utf-8?Q?rz5q0ut8R41l+2nA=3D?=
X-Exchange-RoutingPolicyChecked: YQVw6LMg7h1Pm16Y6E79rAUHeULransngj3ttvAMACC7XJdP+SnawfS7tPTrK7In+gLHsLexeUAc8ZGp4n4D7W0sG3uVBtVSvgDc+jZQnF+aLjy38nrJVNmJskYjMt54OvPSyWRyiQLJHxZitCUvOIgnORVXFWrLiOk91hT+OXj4qwQJ4q9b4Nyw9pHtjlzdkNND7T9qlS29Gcq1t+aondDZ0Oj5/f3WsiNRm0nhymlIE28NtW5JXb+wakFIMdhYegQH/dXkD9DBUauK9OfItNSNchK1KdZR6qFdQm3a1/b7rAfHop8kzyTK9yWcNm8WrgaYnkTmnv4r52+C0Wb4Dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e346e163-5b74-4c9a-3189-08de8fae6c3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:20:43.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEn0s8Cwn1f04bRqu6TYL+m7xAgkC9jgoAaXwW6evfi4f6hFKBG/mWfDQupxRsro6JjkFK8bGR6e2f2vgF7KI4EHEzOk0SpRJHOGfc+GP7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:dkim,intel.com:email,nvidia.com:email,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dwillia2-mobl4.notmuch:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 77803374DAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Type2 drivers can create a CXL region but have not access to the
> related struct as it is defined as private by the kernel CXL core.
> Add a function for getting the cxl region range to be used for mapping
> such memory range by a Type2 driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3edb5703d6de..9c3ba911d865 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2655,6 +2655,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +/**
> + * cxl_get_region_range - obtain range linked to a CXL region
> + *
> + * @region: a pointer to struct cxl_region
> + * @range: a pointer to a struct range to be set
> + *
> + * Returns 0 or error.
> + */
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (WARN_ON_ONCE(!region))
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");

Missing locks to keep the range valid until this context can be hooked
up an invalidation path like "unload driver on region destruction", or
other protection against user triggered destruction while the memory is
in use.

