Return-Path: <netdev+bounces-217887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A30B3A486
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A895169C34
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D423A562;
	Thu, 28 Aug 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGIaLpHp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716B230BF8;
	Thu, 28 Aug 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395232; cv=fail; b=hKI9hH+qrTsXN+thAeGPBs2svKYdbsX4cHMISCtES9+/yuwAMZd1h6QxNbHYLa6axLa3kZrPGPRQcc5S3YJFtpNoFTe4+7fQVvat2jupUPPnlGkA29GaGwoVS945NlWT0mu56yXOTQ0QWwdrz+jRMTDxExlOuD1JJ3it7aKTdaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395232; c=relaxed/simple;
	bh=Pgq0o+9uCfn+rKqj0Ik486/rikPkCssRNgOLi+NxBnI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RoX5W+44m1MaS7GBSm4qqPQhvFyFO2+ZdmsNo7Bxbwoc8bIDdl6cvIW3lMIKIxlgdWLJoPOjz8gHliW9FbmN+l00fDWT30XG8h+7E+kcvAlL53VtV9mAFsvEv56vNOdrHn1FGtOqGOxdA23kwrLc8SsNw4iOBtsbFeCGIyctvEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGIaLpHp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756395231; x=1787931231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pgq0o+9uCfn+rKqj0Ik486/rikPkCssRNgOLi+NxBnI=;
  b=BGIaLpHpPfEnPV20IBaKeoGr3wJOH9s6U/RAG7IiRuDnoU7c8Gqt9a2i
   t22Ot6GxLMKZmzzX6jTyevNbWQrR03V8qFsLYWKhs7p7hLSJPU52KJ9Cq
   QLUMwjeoQKXck/LYLQTKKq9Lqed0sy5oXakutWOSg34SwbUUX0cMTYlup
   fr+NH8t1ZuLbRHj8sJaSzFDCZEg0YGD/MHcBPXAv5Oz/X+iaHkjJncDru
   xoSNsRxFxiCe8PNYL8SmRvkdgCSfTQ66+BY2JJODtBNYzvlWjKF6QHpTU
   Hk7eMpEUE5pNMI1HebM2aiVz9DVblRcV25wDYgCUHdYW2MlSiyV8CUP6T
   A==;
X-CSE-ConnectionGUID: f2gEvsuOR7mw2+b9KjoxhA==
X-CSE-MsgGUID: k90AT5IWRfG/CSblzL1iOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81260097"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81260097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:33:50 -0700
X-CSE-ConnectionGUID: f8nowS4MRT+HnyasFf41Yw==
X-CSE-MsgGUID: 8/Tmem86RdufaMjG8L+KxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170530187"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:33:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:33:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 08:33:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNggIS7u2FZNYI3VxRbdmgVvnn6hMfHRQH78a9nkltxlIW5lNP4G3FE8A806g8H4DMukWs5Fu/X+oegXDhpa3FBHC6tLbrXRUO0sDMp1v/PPvDMH0qUBEkZp3t5CXYX3jK5CCWF3W4kczYU2JXK9AZzHmXZXgclYQUA1nOVHalj4/IeI451KGPL17tWWm5BSv6g/w7y6P0TxJhTtndtf/wmXzhKFXWsZ0CWBgUlE/7G6OWGVmexGQ4wIhlebwaR+umHRFnnl1gYXPdPXAlsTOs+/fsFCsySKi4lIen5Z4tf5GLswAYABF92H3wRl6Qq2DsNnCv6XFd3kv/zd1S6BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoRSIoPxA2l/USL9Cg8XiaJQDB276zROLmGdHvFV4lU=;
 b=LzEyXYecrS1aG8M5HKV2L5EVO/0ddr/FvaIqfApM1BjvnztHX0hPATJQcrFaP35uUZQCPai3M2XMiyBg2GL69dteUxJPx99anhqOdHOVQT8T6gp9J8uxz1iBn31UfZHC5YVSd62Ht28NzoQ3MdfhFxtFIWLZ4stsxJ0o+aJJ41ubvyqgnCUDA76vmn7JUCzGYuJAui+gc3abv6rcmRhOrWYJuZ7W2yas4gtw+fMbhuyTq1TS76pokI5hU5rQ+TvDvb24UGxgiO/iuA6TLReoj/uhUwn5Max+R48d3JcdZp+g4zLnsRuBUUDi6Q1RbbB2t/M3voNcMX9u2yYQDI3Jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5913.namprd11.prod.outlook.com (2603:10b6:510:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 15:33:42 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 15:33:41 +0000
Message-ID: <56aac06f-45b6-4a3c-9436-f400a4efd3d5@intel.com>
Date: Thu, 28 Aug 2025 17:33:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
To: Yue Haibing <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250827040027.1013335-1-yuehaibing@huawei.com>
 <ec71f1cd-89b9-4a18-bcc6-0bac6f6660d0@intel.com>
 <5b0d6d7c-b65e-4022-b028-05f45fe56bf9@huawei.com>
 <83aeba1c-27ff-4a92-b91e-5719be879e7a@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <83aeba1c-27ff-4a92-b91e-5719be879e7a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 319440f1-940a-4320-fcb6-08dde6484458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkoyL0xiSFpxWnB2RnZ6VE9paHJ1TWM3M0FuMHlHaTBhWmVlV3dFN2RwNjhL?=
 =?utf-8?B?cDVmcERyQk91TnF1UTBOdThjT2J1RUZSN0VOQ1NzQ3hicTlvcGFGNXdVMkVh?=
 =?utf-8?B?SFBZeVV0Zk1KTG5HbnI5RVRUNUVkdXpacTdMbGNPdllnZFI2dXhuUDR4ZFM3?=
 =?utf-8?B?MmtObHZ0enRyRHFhakZuZDRTN0U4dVgyNzZWMlRZQ3N5aFgreVBDd3U3V0ti?=
 =?utf-8?B?SXo5VmtCbnd5S2tCTWhMbE9YOHRORUM5bkI0WWEvMUJSUGR2YldzNUtNWUZT?=
 =?utf-8?B?MU42Z3VzSmJhdUNWUmRwdk5HMytiQTJxVjBzTVI3RnNmYjZueGhWYVlGWVhB?=
 =?utf-8?B?SjJCOWlBcEU0b0hVeC9neWladXdNaU9yNTFvcjRSSjNmVE1LY0dzTzNLSE0w?=
 =?utf-8?B?aUxuMStJN3lKWERBemNqTVVIRHJXd1lwSi84aUtLTlBEVWRVSlN1VDJlcG1E?=
 =?utf-8?B?L1kzQXJpandNOWlZek1GeVJzc3ZFRVVENkc3blFXRDU0cDRoY3NHUGZEVy9V?=
 =?utf-8?B?aTJUbDhEeTgyR2NyZVpETGZkck0rdXlGQ0RiVEQwUUFRNHo3dHRmMnFiUXd6?=
 =?utf-8?B?bTEveDZPUkhjOHRPeGdiVWpDd2p0ZlcxMk1pRXFNcGkwRlJuUDhEQUdmd1Vk?=
 =?utf-8?B?N1AyT2gwa2VsRWtiLzVaODRHU0lrU1JyNkF3aGdydDc1cjZnamVRaEdVdmVs?=
 =?utf-8?B?V0hHbFNlbGVxZldTeHo4TmE4VlBXNDh3aDk4M0JQaFZtQmo3T3RxRkloTzNa?=
 =?utf-8?B?eVluVy9HSE9zT2cyMnZURWRJYU5OMVNCQUdRMG9Md3dHckp5MHByZStmZ2lE?=
 =?utf-8?B?dk9keE5sSEoxbWJ1c1loYUtYRzZzckhkTVE4cVpaN0lLWFFLbmI3OUVKNkI2?=
 =?utf-8?B?VjdvUE4zSTJvSUxCamtBcFBhU0dpdzEyU0JXdXJyVDlLM1RmcnRUSDA5SUdK?=
 =?utf-8?B?enFWYlY0L2JZT1djRkkySTdJMk53T3VpUk5kZ1ZWMWlxWHhYY2RLcy9WSEVx?=
 =?utf-8?B?RDYxZFkwNm84UEx5VmYvUDQ2SzZWbnV2SS9hb1VZU3Z5TDFPT080cGVyemZi?=
 =?utf-8?B?Qnc0WjNtVWVGdmZ6ZDluSitROWJjSWxLTjJWcG9WTGdGOEIzdVNvWmlEVVBG?=
 =?utf-8?B?U1hlMzJXakRZUWpWdmgyaERuZTA0ZmJYVGhLVG9GNWR0SUNyTGZTaVBPN0JS?=
 =?utf-8?B?SFF1ZXZscEhYay9tbFJZd01zNCsrU09RbmlaY0drcmZwSS95UGlGSUdub3ZP?=
 =?utf-8?B?VWRvVGtVMnJLczhSWTNiUENLcHpvMEJZazFGaGJyTXVSblFPVGRobG9DUVNH?=
 =?utf-8?B?SW83Qmhka3o0bW1WQ0MzaHNQZmF5QTBVczNweTVEcmxYNDNZd1JPVzNMNGZy?=
 =?utf-8?B?VTlzd29BSGtmSnpzQkIydjlSUlRGZ2FiWEx2U1JVSEw1MFhMcTNtaWl6UGor?=
 =?utf-8?B?d2QyY0g1NkhhNVg0V2sxVDRUUWRkQ3RYQnhXQlBTWUhhdlI4azRJYy9UTkRu?=
 =?utf-8?B?YnV6Q3IrQzZrNzJuUjVPS0M1TWhXbmtRd2tvVHVYU2JHMllPZzVIblZwZVVI?=
 =?utf-8?B?TXZZOUVJYXFPUmMzMG5PUGlrZWhIOWtUSVBHSStweDZQWmdZNzZlaVMrK3B4?=
 =?utf-8?B?aCswY0J6dWlpK0s2dllHMFBqZWE5YTRQcGZaNFl0eldEajNDZGFJbkdrci9J?=
 =?utf-8?B?QnF1b0NMNzc2bVlXZmY3WlFyQkRTVU1xT0NwVlZjbWJjdzNsbnU1SE9HdXll?=
 =?utf-8?B?aGNaR3BQZUNJMlgxQUtiM0krMXBXN2p2UFFYYi9mZlU3U0Z1cDlENDJUOXdz?=
 =?utf-8?B?YnhOT2FzQ0YrWnpiZlkyQWxwVkt2cFcxZGlsdW1mQ2l2dldQN2ZjT3JQQnEy?=
 =?utf-8?B?NWJHbGppSkEvNVo3WVU0Qmd5dXNnalVTandyNkZhcmNCV0gvS3ZsVFhWK2d5?=
 =?utf-8?Q?K0scE0eFnBc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2thNzIzRjluOWF0NkJYQTlwMHF2RWsvVzRHUVFvczRXbzc1UDdyVHZJbW9n?=
 =?utf-8?B?dS9zRTAvdW9MblFhazRxU0ZwWHNYY2RGYXlpbWdlM2tXVzBXeWp0dnZTUUhP?=
 =?utf-8?B?dHFFYVdDeDBlZ3FQcllvNkliWDI0UFlPYU9nRDRWMDlkRVR0VzlKVjNLK2lQ?=
 =?utf-8?B?aWx4Wk9PZzY2UTQ5TzgvOXFOUGJ6alhlMzJ3cm81VEdXdDd1QlpTZU1jdnBt?=
 =?utf-8?B?TDlIbGxWRGlTN2Z3NW1KRkxBNlVmMWtnSGVQVmZ0M1pqR01pUE5aNXM0V0lr?=
 =?utf-8?B?Y0o5dmt3NGYwaDJZWnNKSWE0bU9ZM1ZiWWszT0lickpsUGNQU1ZSQ1MyajNs?=
 =?utf-8?B?aUpuazRYdFM3WWgwVVZZUFRva2tNdkZocDhYT2M1WEtCS3lkTFlYWDFtdDRJ?=
 =?utf-8?B?aCswTTJCdWE3MkQyNmYzeDFaUkx6WmlPNkdTOWpaZngrVU9LK09lbkZsbTJW?=
 =?utf-8?B?cUVOeWtGVXdIVWx2aTJRRXkraU1yendSVW5VVVNqeDJOYXpMMTBsSFZjZTdn?=
 =?utf-8?B?T2F5MVhKelVPM29yVkZTNmdIdENud1ZtaExRdjJhZHFQbmh4SEl1WFloQ01l?=
 =?utf-8?B?OENQWkYvK1NVdVc2K2gxd21CVGZSUVJUbGZCNnJUdWVxVW5YeXFtSDBZd25Q?=
 =?utf-8?B?T25RYXBIaGtad2xsbUx2bCthNWJKcmN4UCt6WS9DVmlqRlVmNWV5RWdwVitn?=
 =?utf-8?B?Sk5zS3ErZDcrT093SW0xU2NBcUh1NXczYS9WOVJpNUNRc1QrVERJNzhkazRO?=
 =?utf-8?B?emowTnd0M0R6aEpjZy93VVUxTUtFUit0OWdUeVpZYlhpdUE5VForblFTSWYv?=
 =?utf-8?B?QUR0UEVPRkZiNnFhYjE1N003d3FxNTlXRFZBVHhkLzBWVVBGVFNyenRoWVB4?=
 =?utf-8?B?a3BUcWk3ZHZEbWdHbUV1ZjJEbElweGtCeU5RUnlPK0JTZ0VldG9lN0NuZmo1?=
 =?utf-8?B?V05qdnVUenRtdSs3SHdEbGdHaXJKMDJvVmZ4ZTBscUNqWXRFaS92L3l4SDdD?=
 =?utf-8?B?R0x3OVNqYnVIZDd3alhUTXlXREp3RGwvbzZOR096TGozems5emxGSHQ3cEhU?=
 =?utf-8?B?QytXUTdybU1ZWmEweEdHWGNzTnhsY0xjUU1XalFLalFpQUZHK2FtTVRMd2Q2?=
 =?utf-8?B?MWpjTm5LVHNpQk0rM0xKUS90cVlTa0Q0ZlJ4aHdQR0FQMFVLTFZGclNBRTNm?=
 =?utf-8?B?S0hYeGl3aDk0NkoreENSRHJtTFl3blNHd09oQjV6aENtWnR0dFRIRWVyNFFI?=
 =?utf-8?B?bDlpTGtldGwvblVGN3BuNnhQYUU0dXB0cjNWT1JHMWVlT3k3M0RjdEJlZkM0?=
 =?utf-8?B?UFlpZHN4blZwREhDL3Q1aEhhWStuNWJhUzFFMHc2U210VHlvZXRUMitMNXBq?=
 =?utf-8?B?dXUyUWMwQ3FWYzJTUFpDSWdMOUpzK2F3emdVSjZicVE1a2M0VklkY0dsQU9X?=
 =?utf-8?B?dXkwOEtTWC9leHZNdmJiWWxCWjdwUEw3TEFYMWs0VXc3WGVGaWdjSDIzR1Rt?=
 =?utf-8?B?Q2loL2RMR3ZoVHRGYVN3T3JnQWFoOXhHTWVQTDJkMDJ0clY0RUkvRkpxdzJF?=
 =?utf-8?B?OFQ5VThBbVUybEpXL0hBL2gyM3ZrZkFiN2NldmtYYXVHN0tna0NjblZKcDdn?=
 =?utf-8?B?RThhV09ocW9yakpacmxGQTdHYnJsdW0xc2xIem54dFozODRLVXRUemxyMk1n?=
 =?utf-8?B?VmNwTVFSUGdmcGIrdDY0Q0JmZXk4ZUZjOEpkdGRtTWZjU1hDd1hNN0JJMkU1?=
 =?utf-8?B?Si9EZlg0TVJqZ1FSUzBUMS90TFFCMnNJcUtBRkJNOFBHRHRucjZMYndESUho?=
 =?utf-8?B?ZHdQcFk3RitOQzc1QzFTZ1hnUGtYTjVPUDEvQnYrMkNUTVhLeng2enpON0dn?=
 =?utf-8?B?SmFuckhzVG5RTFN3S2xiKzhOMUVrek1Jb2VFN2FzSzRFcUFJT2ZSMkpuZyt0?=
 =?utf-8?B?cUdQcW0rd3JLSU5wVEhlSFdNaHFQSFN3Q3VxUUNSWlRpWjRsRk9BV3BCSEFD?=
 =?utf-8?B?K0U4c2lOQjVqeGtQN0RwKzdMRXVkVVJxcW9qSk1kZXBqVWMvb000L2JydGNn?=
 =?utf-8?B?SUZGak16TzNQd2xQWXRyT0xPVUs3dGtzV3l3Q1J3eDE1T3o3L0dwUExZQmlz?=
 =?utf-8?B?RWhwTDBCZUMxY0VDdnJGOFVrZWNJSXl3dnZEbVBkTi9xV0pybm9ON3gxS3RW?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 319440f1-940a-4320-fcb6-08dde6484458
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:33:41.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItPMFxDjzBrQlfpAyMmYUempjCqlqUl5KCbQsVRkfWGS1TdtB+tTRKFlItIuikKwCmMyxH+sL+FNiv8TQTbZBMJbTdVsbMkDu4lKvMBwysM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5913
X-OriginatorOrg: intel.com

From: Yue Haibing <yuehaibing@huawei.com>
Date: Thu, 28 Aug 2025 14:44:07 +0800

> On 2025/8/28 14:13, Yue Haibing wrote:
>> On 2025/8/27 22:45, Alexander Lobakin wrote:
>>> From: Yue Haibing <yuehaibing@huawei.com>
>>> Date: Wed, 27 Aug 2025 12:00:27 +0800
>>>
>>>> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
>>>> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
>>>>
>>>> No functional change intended.
>>>
>>> ...but bloat-o-meter stats would be nice to see here. I'm curious
>>> whether the object code got any changes or the compilers still just
>>> inline this function to both call sites.
> 
> On a x86_64, with allmodconfig:
> 
> ./scripts/bloat-o-meter -c net/ipv6/sit.o net/ipv6/sit-after.o
> add/remove: 2/0 grow/shrink: 1/1 up/down: 1770/-2152 (-382)
> Function                                     old     new   delta
> ipip6_tunnel_dst_find                          -    1697   +1697
> __pfx_ipip6_tunnel_dst_find                    -      64     +64
> ipip6_tunnel_xmit.isra.cold                   79      88      +9
> ipip6_tunnel_xmit.isra                      9910    7758   -2152

Oh okay, so it doesn't inline the function due to its size. Maybe it's
even better since we have a good object code reduction now and that
branch inside the func shouldn't hurt the performance much.

> Total: Before=70060, After=69678, chg -0.55%

Thanks,
Olek

