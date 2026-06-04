Return-Path: <netdev+bounces-295389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X73/E/nKIWrfNgEAu9opvQ
	(envelope-from <netdev+bounces-295389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:59:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46514642C38
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:59:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CYfmL9Uo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295389-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC66C30207E1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1739A04A;
	Thu,  4 Jun 2026 18:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD132B138;
	Thu,  4 Jun 2026 18:52:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599162; cv=fail; b=IkOoYnf3fBL74mnn2hGxGUUW1Ke/269QqAgEA7qGQpCPCzfGuqVCExTYQReV5ktBVinqyGdcEapAHL8V5TDmIUqoaTTytFlczg1msYYlQHrrRNrPrthWghN4S4Wpy2e/RzBedTglP546EPbBTyfELCqc//3Chb7AFBQbszzEvQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599162; c=relaxed/simple;
	bh=dikE1SPRx7+tWMTfc3G3Gr+s1mWwoL1NiM899CIBp3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+giSCkpkxh1hximFdtiW7cxgAsAy1+4BOFk5saGNwb28QQKaP+hK80mP+K4zt1lVsBC14spbhikqiWuw37A0dNFunLWo5a5LXcMb/cmFwqLZh6dcEEyibYB1xcD1O3jNaszBTGPNtqtqEijG1+QKjghApD8/X2v+zZfvJDeOqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYfmL9Uo; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780599161; x=1812135161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dikE1SPRx7+tWMTfc3G3Gr+s1mWwoL1NiM899CIBp3s=;
  b=CYfmL9UofvnFM43E8TdsMM7e7pLdKktwR/20RCJPajfMpkljhqpRvC9t
   Jr3v/RmQuj6ZFKZBI0q3EpKyijQLvqsNQGvGWkN9sFXgzDTxEBgCr63jc
   oWm/kCARXtO22WwrONZZ73Slqv6bgBacer0aLkA2mYGvNt0DRsdME5fnv
   FXEuCjbZbY10A80vTCQFSGhFsw4HRpt3YXXwIobx9qvNRPuc97zXe7COJ
   mSMBqcPdi/WxrPRJ8KH/0B7XYkgn1ZMx0wg1KT97MLsVeiI1HwgRZF1NM
   h/j4RBDky+rQnA0/8z9snzeVc3RfcSaidixgLpjE3N7aytRB6pVsvgbvc
   g==;
X-CSE-ConnectionGUID: 4zXAQGDMQ8i8TlGtKO+VMQ==
X-CSE-MsgGUID: 8ylSx8AQQfeu0HKfZPi4+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81411464"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81411464"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:52:40 -0700
X-CSE-ConnectionGUID: YpbgvrS6T3KrWPNS1l2AOg==
X-CSE-MsgGUID: gSOg6ZbQQ0CI8AFQeV579A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="248559476"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:52:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 11:52:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 11:52:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 11:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/nYcKRszApbWSngVVnlYEiYyAb7EZGv3iHrtj623OKrCF8t9V+/mxjUJIZ46EZTLKqxliZuoD/zt/nJo893n0nG1FhS3W4ZbReen6KsWoqwIZEFMj8X1YSfC94w8SMblhxnRZKzR2OEDsB47LRRgTM6a4If47nx8KqEo04rQmzWe8huL4S6uQP582sy2L5SIpSPMKIGkQ6DNjeYU/l7pyIiO0PBAPY4WaTpwcGzG6+uqfDWxDOu9Wm3LxLPKYyaTYl/zvmKRTBYHolI/6cvejXDcjdCM7mvjf5xMQxc8DDspSxbglvU/pGjdisFsbDXO4HadEQlWeXECRqDUXQtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32u6crY831NkXAGpsRm/k7dZIkKWaDAoG2818ReN5Es=;
 b=Z8ryDJseiRE/hXoeAc9FC5ScY1/L3hhKOFLqN419Gw1nSmLJkAfW7UXn6PqxJAGF2OMHhDYYUsp5gf/WgDTWO5NXpWKQr8lsPuDUZzdGjRD2o7B9eImNHcIfx5HpFslEYwRw2igApwRX1e9A3OLfkglifiHQzPUNTIGXDDjtbZqeyS8bIaqQH1ZMFC0ZXPzkmsEOi5FUY5YTdE3SRhhMoNQeAkm3/qja6qq9CLQjqoWIsg9VkhyB473QZU3WqHAJce7HCQkp9LQpcVc3s6pEn0CUa63y2MkrK6QaXkYbEc7exvxeC1Hx6Slxpl06N0fgTEC78XsCpm682ekjhYIsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Thu, 4 Jun 2026 18:52:34 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 18:52:34 +0000
Message-ID: <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
Date: Thu, 4 Jun 2026 11:52:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in
 mal_remove()
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik
	<jeff@garzik.org>, Roland Dreier <rdreier@cisco.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260603230821.5619-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260603230821.5619-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS7PR11MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 1956d2ec-dd72-42cf-c6f3-08dec26a709e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 75ZckKSEB5LOnYkkSgrF0+X9KiJbTznoCkns0I2tzXpS2qBMXz50UdDlOaRkgjhA/Iimt0PIg//Z+PwV4k31eqnbCCoYar3l1OaztGT2giFHIendJ/4cTXqAQMNy9QD/UW0lfKUrxwVuTgnC0WipEOW1sPSTfvOEnw/EDUlf9SShf3inA+RBoxAcMp1rRYvanPelE3M5HjAGLdNIS2PHbtPHW6TCQmtuZ4UciaVhu6tsh5F0Ms/Ys0SArmzXX/aaFmQihZThlph3LSBD3e3zWd3Z9O14Q2gMjy62WrxV+UjY7OhQTqFIUd4eRDk+zf1u36mtmXj3WYqs7uP2bWDccaN4nNjx7bL2HhYEeoOCzEMQmaw9NjG5C8L0Txk7oyKuu3oEDtceXFX/fSQSPiMD5YpJ6LC5OeVjKsKjpXDilYrWhXyicga1gpqkyyusr/nWHFSbuPE7oFqae4y/dO6diMt5qPUy8Pqng6/o5JPt6umNu9pkh+SVhhssU6DawdMOZkVISOUBsuKKHOrXPpdf9MivxpFTygfoPTYZw+HlIQZ60ll744AX3+8Jr+zZ8EZvYUeiyaWkQpNOcCC3JStRz7VX/aVL/ozRSLeRZ8QZoz2BlEN4lM5JKwzNiC+eEl6OQOOLk7zPHRTotK/9WSRHyTL4AOYK0lV8UuOGiTrdViz+4YfaDddMwoGrjnx+YIQ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U054eTJRQ2lBbnprWEZ3TUNzb1Vqc3dOK01UL0VxL01KcEg1YWVaMmI4MnV4?=
 =?utf-8?B?bUFjQlRTZU5TbzFXZFZ0WFJJZkh1Zk1yMkJpTGYraEo1NVFOSTdSL1MvS3JI?=
 =?utf-8?B?amEvOHhhdWNDTmRwYU9EK28wVGlZSnRJTmJtSVRreWlwSHNZblNod1dvZTZX?=
 =?utf-8?B?c3ZBeEY2enpGTGd4bmV0U21Na1dzdFlWS2E5K3BSMEcvUmE3dkpQYk9XR3dj?=
 =?utf-8?B?TTJJeDA3VHFrVEZRY1luUmhxaWM1UUw1RjJyQlYxRWdqdFNDSmpDZlc3cldX?=
 =?utf-8?B?K0JuL0ZWcW9yTUpHdGFpUlRhdWpyTFNybG9Qc0RrcEwwQkhaS0FvRjR4RCtr?=
 =?utf-8?B?clZ4bURGSDV3TEtPVTlRejQrLzZnMExKdzJva200ODBCRWx3bUZyTjFveEFl?=
 =?utf-8?B?QUtIcXZnRUllWkJsNTlkL0JXWkNWbzU4bjgxb0JLelVKZHZNcHdUMVptaER4?=
 =?utf-8?B?NHg1Z3B0S0pPOU5DWlFyRDhMSDQ4VEo2RFRTZ0JaMnN4YWVzSE9CVnV2WHNw?=
 =?utf-8?B?eEVaSDNDaDROL1ZLbEp1dTh5TUphblhNVGdNQnl5ajVaZDhXOFlYTCtGR25W?=
 =?utf-8?B?L1ZzK3RmSkhNMWpRdnlBTzR6NkdvbWRORlROWDlsYjhEMVR5WFNueEhzd3hL?=
 =?utf-8?B?ZTVvWkRibis1bFBsNzFrenBKNXI5cDdtb1k5dHVac2s4K2xicjBSVWx1M05m?=
 =?utf-8?B?SkU4Q2ROeTMyM0xDOGJSeSs0T0FjWDlZUlJ6TGRHNVhvby9rdUlkQThnLzJY?=
 =?utf-8?B?VjZKS2dOMFBMQ2pKYVEzWnVwQnI4WEpHSzNvcFZFMWdIQUE5VHkydFpFUkdK?=
 =?utf-8?B?dzZmYmpKN3RMSVlYbk9PVXd5cE9oZ3lKOWliamtIL0tVbSt1ajVKTUJlSTZN?=
 =?utf-8?B?SUlFWUZCVGc4dWo3UEcwalBZME5VNU9ublFqSWF2MjQwanZzVi8rM0lUSFdz?=
 =?utf-8?B?YlRsSXQ5aHptQ05jZGRBT3gvRzBPQXZ1NUpsMFAvWWNWVjJKM2tndHRTbzRH?=
 =?utf-8?B?YVJQSFFwcyt3Q1BMWkRDQ0VJeldTYm45NE5PcERqeC9Kb0xkTU1XRUtpdzlt?=
 =?utf-8?B?aGM3bnQyUlY0dmNZMndjYzNIcUlTaHk3U1FpeDhNekJWYldyRmVDTEk5VEhO?=
 =?utf-8?B?TEhwRWVadi9hMmNwaHRqamVTNWZxdzFzZVBCK3ZNUGV4cEJaTkdFTDJCck10?=
 =?utf-8?B?UWxrWWVqN0kvb0IvY3ltaWIybStnS0ZKeFlqRjUvUnB3aU5wYnNWbjh3bTM4?=
 =?utf-8?B?d0NnSGxGZ0IvbWpxTUdVRWZSU093VU1RYU9nbk1YblB5a2dOdVBFTjlablkw?=
 =?utf-8?B?VHJob0hLZ2pOTWcvTS9Wb0J5ZUJDUDRiRkJUTytOZCtUbk1CaG9RQ1hpQnVJ?=
 =?utf-8?B?Qnk2aWtqQ3JCemhEbGFMZG85ckVQVFczTEplbUlNc2ZOTFVsREdsMHNaOG5j?=
 =?utf-8?B?a3dteEdWKzJpazY2bFN5OVZRSWs1b2lWSnVTYWNPQUtxZ25qZEdyS252WkRr?=
 =?utf-8?B?cWlJNlZ2SE9YWXFKekliSXRxNnJnM1hqVk9kdUhOOTY1SWVrSU9ldFYwVEhF?=
 =?utf-8?B?NWNIdDUwZVc0cEpzdjVhblZlNnh0dG5JQXdhYldUTlU1RmE4b2FiMDdkcjZP?=
 =?utf-8?B?a1V0OUFLY0N6UlMxUnB2dHdkQXlNNlZjcTFvdzN5cmIwUmE2MnprZllmZWJq?=
 =?utf-8?B?WXNxQXVPaXJvajFWcldldnJzaDRxMTZJa29zaURXMXhiaWFpdEVzU2N0ZTN2?=
 =?utf-8?B?aExCYWRJWFFuSGNXRlZRUGJkcHJ5MHFmcDkyWFlMNW5XOEhQOVoxY05TdVc1?=
 =?utf-8?B?Vld3K2dKOWFQN255bDBmZVBvWUFVdjAyVUE3aWFOY1o5NUFLVVg2eFlKS0x5?=
 =?utf-8?B?VGpIZ08vTmptVHhwQk5udStKU1Z0U1VDVHM5MjBzbnlRcVZrTFVZVHRzQWlx?=
 =?utf-8?B?WC8xalJNN2UrK01uM2t4a1FDcHZGanY1d3p6STFqUFBVTXFnbGRvbVVFa2RJ?=
 =?utf-8?B?YXBQM0tuNnhlMXBqTjM5QUJnZSt2dDdiK3JFZVhmaUYxRStUZ0dJUEhhWitK?=
 =?utf-8?B?OGZVN3RVTzBpSXJQRFcrbDZzM2JtM3BTM0Z1THJZNEZlc3ZnemoxeDVkSkwz?=
 =?utf-8?B?Ry8xQ1NVNzFpeTdMN2lPdFpLUnVjdi9sTTVCT1JUOXU1b01DU3czVmJKNERS?=
 =?utf-8?B?WGFuN2kvM096eUEzYTR2eUFXTkJxTjFXT0kvQjFaV05aK0xSWDMrSnBxc2hV?=
 =?utf-8?B?VW9qVC9lVThaTk9OZDVRQjJsaTBrNDBuRTNJYjJqVzZaR2plNVg5U0Y3SjFq?=
 =?utf-8?B?R3hHREcxbFJQUzFxb0ZhYmVMRFI3TE9wUG8zUXIzbHo2UDQ3cklCWURPK3Ew?=
 =?utf-8?Q?1mBJtVDjxqHeYULY=3D?=
X-Exchange-RoutingPolicyChecked: OJ6POEZb4Le8rZJcmTd5EN6Xevw2VPLswe4mgoq8nyVH3glAftExkhItxa3QhO0bmnRnYvjyTlOjMZrYeTGxpMl0wHI7HFVjAGIfpaE6aWH9YUp5RrdhFAZekZqdEIA/7ojPLOIE6QfQKha4RyTNxMAN/3LQWsZ9ENbNY3/S4ewELxPuQc198sw4FU9AgR+SHhwkb3BwsbDEHHj7EzatFo8NirwRUQJTMZOdadxjnUumzpjtFOAuQ//GBhPDff7Yv89MndV37GRxMvzt1E4eUuxzZQ25IBd7qkFi8cpD0/trdDQBhpVhvof+x2MD9K4rEpaPfPFIEDCsxKLIrcX1ZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1956d2ec-dd72-42cf-c6f3-08dec26a709e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:52:34.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPOunm4WV+oJX+MrsJH613hhBzCUWiTzcTphvUxR7+a/GBryUHG/3z0HoziCwadywF6grdsQAAb4xwGAJBPx3oEOShAZcIVttqYI42IneGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6039
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295389-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:from_mime,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46514642C38

On 6/3/2026 4:08 PM, Rosen Penev wrote:
> napi_disable() is not idempotent and calling it on an already-disabled
> or unenabled NAPI context will cause the kernel to spin indefinitely
> waiting for the NAPI_STATE_SCHED bit to clear.
> 
> In mal_remove(), napi_disable() is called unconditionally. If no MACs were
> registered, NAPI was never enabled. Also, if they were registered but
> subsequently unregistered, NAPI was already disabled in
> mal_unregister_commac(). In either case, calling napi_disable() causes
> the kernel to hang upon module removal.
> 
> Fix this by only calling napi_disable() in mal_remove() if the commac list
> is not empty (which implies NAPI is enabled).
> 
> Fixes: 59e90b2d2250 ("ibm_emac: Convert to use napi_struct independent of struct net_device")
> Assisted-by: antigravity:gemini-3.5-flash
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/mal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
> index 83dd7f99d8d5..74526002d52b 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -712,13 +712,13 @@ static void mal_remove(struct platform_device *ofdev)
>  	MAL_DBG(mal, "remove" NL);
> 
>  	/* Synchronize with scheduled polling */
> -	napi_disable(&mal->napi);
> -
> -	if (!list_empty(&mal->list))
> +	if (!list_empty(&mal->list)) {
> +		napi_disable(&mal->napi);
>  		/* This is *very* bad */
>  		WARN(1, KERN_EMERG
>  		       "mal%d: commac list is not empty on remove!\n",
>  		       mal->index);

This one doesn't make sense to me. The list_empty check does a WARN()
indicating that this is not supposed to happen.

This implies that list_empty should be true, otherwise we'd see a WARN
every time mal_remove is called.

But in that case, we'd have been calling napi_disable incorrectly in
most cases where it was previously unsafe according to your claim.

At best, this list_empty check is the wrong way to tell if the napi is
disabled, at worst, this whole change is pointless.
> +	}
> 
>  	mal_reset(mal);
> 
> --
> 2.54.0
> 
> 


