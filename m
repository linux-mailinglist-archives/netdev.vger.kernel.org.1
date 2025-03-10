Return-Path: <netdev+bounces-173552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C17A596FF
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864B4167891
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D1229B1F;
	Mon, 10 Mar 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UY8N/HIV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6C185935
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615411; cv=fail; b=qQR6lvl/QeXINaaRXUVrnhjpUfg5n12Dwc+QDcdd+sgS+1d4S/7iSdxhIn/7XuV2oBOyAxlibE7AxPC8zRQbvZtd3vP36as99RE0GyodCKraUMzPZoyWoc8JSNaTYQlaXt6FFg2vu3fZgNFZkd9eCORaHC0CUlHmbNBM0PdEg6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615411; c=relaxed/simple;
	bh=RPkOskfL24C9eaHirIxwBsnwoUldpM5FWzWyJ3NJxBA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+IBt31/8qIY9h9aCngmAcHVYcpN1aEgqmnpqE7bke540V0ytLv8hWJ/2YQtyPzLmECIXmKbHtxHTDVkaVcJ7Ra6NvzNyZhGgnk1ewXjbEu+5bhhGJ+9aTrJ4PuDXSx55JHxvgOa6ZAWzhGhSOc3T7mAb+3zI2Gtp87iH95xC50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UY8N/HIV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741615410; x=1773151410;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RPkOskfL24C9eaHirIxwBsnwoUldpM5FWzWyJ3NJxBA=;
  b=UY8N/HIVO9YEqq1k9sp3Fg1uwjJCb0PWKiNQhE6neZa10e9Cq1fesoS5
   nAZ+QUIFtjuCAfB6yyiNXMbCPXNf1wHGvaof2nRRqA0WvmgbyEFbyQkeh
   jmM5kXKi+xYiXQFZ15mWKUtEeKm4KSuaod+YcM3gID1ALZfEzHZnV1Nem
   es7egbwEeNf/Qjv7Ne0KBHbizX1krh3k/+JJ/n/a5dhtHbyqubD3QvvKc
   PSPGwufmQ+YZfSfxdfnvgtJq6wY3gpnqgWOdWdVioUIs6igAXo78DCTVT
   e+pqMje7wZTq9BTLk3VGsF/z+xaJvHg5qAHcizMjjuuWLfgX2Lddq44iK
   g==;
X-CSE-ConnectionGUID: p3TizgKORC6uo5g9HLFaZQ==
X-CSE-MsgGUID: w/O5W2qLSg27aaoKcRJ+Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42744943"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42744943"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:03:26 -0700
X-CSE-ConnectionGUID: Wlqj9RDuQaWYiw93hEH0yA==
X-CSE-MsgGUID: CvU2YhUbSrql9+QvTWJRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119844260"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:03:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 10 Mar 2025 07:03:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 07:03:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 07:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYuUpMM/MhofRc0vefO1ZCu2tGSfMHPfWb00BzsMZDN9sP63+79P35CSwNfm0dS4ZvwBRbBv67MkMogChfn3KqpDV0zZx+6cyVYRIFew1hoaqgncTIpKRsi6Ora/4V1RG5l8eYZa4Wnq5BYh5HIH7jQrYTWWfsgf6+pHkf2iCxq9UENcSvqaxg2ttisrgvr6/XE2P5F4eMG/cEsLON9H069sv+ZZ4DrVI+FgKljgbkPSmCUiqd5sVhIexrdXka+I2WYmnp2L8vJVZTWoEgb5hovxuV5sP5r15NviG4U+rFJXerro+XotBdy5tEbE2d0uvLAxRxEoKd+ZidCsl3kFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zsKg7bsksQ+BrRBt59+9uj8D4+SGm4Z8BBzj2aQKVc=;
 b=d/3vJUcwf+m962chEs4qDumyN5uLqxo4pgWHH23Qb54/46fgHN/WtABNfFiEejG+JmFrNnKThhQNK4Ba87RyBqYw9cEws05LBPprHmRlkXkxID+tGYnokHoA5TI7hycDUwIzvPcCg5sYOjho7NmGCTx4GEaCA/WVigbPWHfw2bqAFe57u7N1tP5l6+B8g8oA8rn6IIJqGp5xS/993r/wpCQ8nMtKTihmzGs5IGdkCfXkbdWrh6u7nQMMa7RawUg+ydW2om8OWJYtteWbT0U1fhym9HiwUgZnLtoLIj75ZYEQl8024SQISTDN4g+Wj3x8FuK+1zfEGe4ghYFLbLTmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:03:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:03:19 +0000
Date: Mon, 10 Mar 2025 22:03:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing
	<kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>,
	<eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()
Message-ID: <202503102159.5f78c207-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302124237.3913746-5-edumazet@google.com>
X-ClientProxiedBy: KL1PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:820::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 93718f25-8473-47f0-7ba4-08dd5fdc4f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pi7ufSGwStoc6DNu0+rAGJohQzJGTbWO76JA4O2HR0HEsdUkkCfSaJQqN6?=
 =?iso-8859-1?Q?X7IcPGJhyRWvAVQ2vqH4f1dAcz6x3Vcv1z021XXfH1RUftDB4w6hBxqHjN?=
 =?iso-8859-1?Q?h7ObwgAdRALP/5U6JHlQbswcHBjQXMjslba1AyEv1O8trZcvGIPidBKwez?=
 =?iso-8859-1?Q?Yld+uihTuaswvg40OmJ07j4GmYhzGQ4cOO8fqoosuT5xwPcApK+8LsbUsm?=
 =?iso-8859-1?Q?O5GYMxLAsx2r0HGseiTDlffWvdBzxm+dXcbDndbOROyEHRUowQ5V/B9Lps?=
 =?iso-8859-1?Q?4+NA1JuuUoFqmpoixCiRax0cTei0zpNoBqE+HCL9kzXeJUUnlUhUenfanV?=
 =?iso-8859-1?Q?Qnn5+Ue3+XNXz/XNOUTZQSJfg8ZYz5HFodMf1DsSKA5b1YPzTxS9lADv8C?=
 =?iso-8859-1?Q?3OS8NO9r0oAsAbgDMMHFMK6Z9glDUKp2dB4C6DDwK0JCEG54yXEUtnagFM?=
 =?iso-8859-1?Q?zhyxAh72Q+xeDJjTuBMTzcKbVanORRRpxiXgNZH49zlAtBAuVK6tePY1Hc?=
 =?iso-8859-1?Q?aGK+LLTQYulqE8DPNCY5uocBVkK/nJIgOeq6aSIAUPYbCwBfm8kl8gFMbK?=
 =?iso-8859-1?Q?2zEhTBiRfRxad6IHpz4YjYPw476U3/qmXJNqjUMpXk+f4JZS7MX31ik9ER?=
 =?iso-8859-1?Q?jSi6BSN675S0Mib0E+T/ibaI2K/0rYuBa25Fi8OYvoi0u/GmDeB6H+rv5/?=
 =?iso-8859-1?Q?aY8bd4mDN2XGC2G5+xVX++FwgUdAWnxzicMKAfREzA8BaUWqRAbrd9nPn5?=
 =?iso-8859-1?Q?V21pxkkTsbWGaftI4FPtTyItFuiU3jsKGacgGvEgTxcaP+Fdbu2jr65OD3?=
 =?iso-8859-1?Q?ECInbd7G610h2N6heBSGKgFSQpzL220oE7PXrSNYYK7ALPIqGc1QOqefWo?=
 =?iso-8859-1?Q?s27dyPZ1u38E9bYcXgBGo28VsNxEuuPPzrvpZQCvbZtvZvVlSKlEUa5LFF?=
 =?iso-8859-1?Q?t5IKYhbMC5qnM4rXgVu3g1m7bnH5jBJPRXdNN+4Im9KxfcDuyY/iZzM7JH?=
 =?iso-8859-1?Q?D/rfmbb1dvL21QIX+0P6UuVDVV2cBJtbN3Q88L+Eqhme0LaH6ekYcXgJVV?=
 =?iso-8859-1?Q?XmAb0I+J06skrZcxyC4FbrTkOmkUvOKFumMezrf9GvEoybVe4w0Ymz/DWh?=
 =?iso-8859-1?Q?N24CT4I/uTISu4R7nrn+L6KiZXQFfCaplQ1k7vD4YTODda22x/wrWrz1ML?=
 =?iso-8859-1?Q?n7974NskgtwTd1GVMp4BDaVXeOzsSXP1LbEE3AJAAcv0TwtlrZVNmeVe8v?=
 =?iso-8859-1?Q?fTUn9xYjbr0cZF6LehivURf72NAuLx/2WPdTw4WWRbRjzNAyyYdt4zkTPy?=
 =?iso-8859-1?Q?6MnEyWz5CAN7aETLP4A/7dLzIrVzWeFib122CaQXL+gI2c661kAKmOoEVX?=
 =?iso-8859-1?Q?ANW5M4KUrOBrod4U3qcpkzZ0nTZTjN3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xqLAwjgvvqnaxxl+ECv6eL+bIz3pn2zYQvuP5ozYWj4sKfv1QFzi1r0PHm?=
 =?iso-8859-1?Q?Y+ewg4zcFVQr6IjEKP/r2ZY+ECbt/qWOPW2n+W6ZD7v+Z6frFkW1aIuH0e?=
 =?iso-8859-1?Q?uNS7bw2roSuyerXYg0ZPbjWia3ZfZkaa+CiF4ffB+c1ojTCE5bptp6U8eT?=
 =?iso-8859-1?Q?GHG5OONYKwSowY6Dd5QsM3vgWTmoHoaEaRZ0c+1Hh9JEa8g+JNNyLLcjw8?=
 =?iso-8859-1?Q?LtIYjMK0isECG7D1jNnY13LMBJsYBapYMAckC0C5GGvZFu4yjfR21krRmN?=
 =?iso-8859-1?Q?m0WhC+6Scmmt1tVuwfKCgDa97Lb+nj/tNxJuHH4jZtlGao8cubnVjU8zQg?=
 =?iso-8859-1?Q?4CXtDThO+SlUFt/wiJiFqSqPGtY6sZLXmcqEWb7edC5jlKUJGUjE15J0Ou?=
 =?iso-8859-1?Q?l1DwSSvJp+BE2cBt/Vz89OnNOIq3o5i9KY8VvSllubLR61avtsD2czDS8z?=
 =?iso-8859-1?Q?9iBMfMTHJTROHrPY5fQ1b4ZZr0P2FSFYEja381bRf8/1uNxtaz4/htKapb?=
 =?iso-8859-1?Q?VwEPSsRlvznppMQWqDNBNKvOrEG4NZA8Ro0mIa9qaT4g8g+QTLbxYDWP2j?=
 =?iso-8859-1?Q?+iKnNVVlI1lhykkagxQfJ5SqHL0gOm54KT030lXDrPA7+xgA4BFO0OFMn4?=
 =?iso-8859-1?Q?wvK6Tk6US/oIRkFQPUZ5liT95Yc/yWJuvGASzSibACT1Hy63uRuLzNYSG/?=
 =?iso-8859-1?Q?bzFrjngEq1YJhX9mt30sCLntEV1CPpcZj2tOl/ClKczL5lY5GJuB0xde53?=
 =?iso-8859-1?Q?11f8E6zdHXHHzcR3RAITFHocHhrfZchPZCHjxRnAVuN8Zqvg5iAnUETFVC?=
 =?iso-8859-1?Q?bHIPLkYw0LMTeMsHzI7dSoeX+oO9KPZtaNTaDP9zo6o/zMIUccvnbhek+p?=
 =?iso-8859-1?Q?pYb7Cy9givlCQXWEn3yXasq3d1JcZnwRtFI/AtCBEnub4qvgAbesh965kV?=
 =?iso-8859-1?Q?ZLzRfMnEULtZdbJnHVCgXivXboS8tvs4b+VLrJKDsKLv5ADT5imIqSeusM?=
 =?iso-8859-1?Q?P6fJAESGAaUkbiiiMtYzeLr6pky37py/jMxjmGW928edEwFtR+g5R00Svb?=
 =?iso-8859-1?Q?+RMd+D74cC2ngsvPRT3TlsWsh2hEuRmIdFR9SiUd+jdb6N0qfNu9DACgYv?=
 =?iso-8859-1?Q?44i9bJ7snJ30BToNCpGvpOBaFWaY0GzpwTfkfeH+tPBAONg/CVlKlYQls3?=
 =?iso-8859-1?Q?KogAcWJI0RjHWHoVPw3Fv0q7wm6HRY2Mx1TOk4zDK6/LA9Jw14DBXME/lx?=
 =?iso-8859-1?Q?j1Z/ycyfsqfIjImtJxb0aN0dKsprebqErIB1TrI3VGnMBLHlQqfN9ct4J3?=
 =?iso-8859-1?Q?DlgHlIfBxTSN6340nmdYR2LIkz+ZmmnEQubKe0Xj9tKohkUm7i/vYlU2n3?=
 =?iso-8859-1?Q?oGtprH+yxcT7TQ2zmp8VnJ5WLxPWCRtaHH4ipnKKopXCfQhGB2sqHipPm+?=
 =?iso-8859-1?Q?LyAbty6jJXofN7ENsyiwvsIYbIhdRsUq8eViMHY+EqExU6q6jGN4LskJbE?=
 =?iso-8859-1?Q?GMhWdvReyMSZjbYtfgUejL7QSN87xzduFY+SAkWqEKqU+t2C0l9ij0d4G6?=
 =?iso-8859-1?Q?TxMKXy6R6oaXN4R7mkhKC8aBr4eA8I+AhKXLtsMa+ZjEb6YIR7emcGsjma?=
 =?iso-8859-1?Q?vJfTAHfiOJu7p6EAnPaPIUhm/KCyoWxA5rHf3GdymmVaRuyWwZKY7dUA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93718f25-8473-47f0-7ba4-08dd5fdc4f8a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:03:19.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61GortYruelgSCrUka0UAezcbot9h5Q00tBFguidYSwVmu+lyoNsK7rC/Lmvx6kq2gNjStTK8+Z4AeAjAP6pyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.9% improvement of stress-ng.sockmany.ops_per_sec on:


commit: ba6c94b99d772f431fd589dd2cd606b59063557b ("[PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()")
url: https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-use-RCU-in-__inet-6-_check_established/20250302-204711
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git f77f12010f67259bd0e1ad18877ed27c721b627a
patch link: https://lore.kernel.org/all/20250302124237.3913746-5-edumazet@google.com/
patch subject: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockmany
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503102159.5f78c207-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockmany/stress-ng/60s

commit: 
  4f97f75a5b ("tcp: add RCU management to inet_bind_bucket")
  ba6c94b99d ("tcp: use RCU lookup in __inet_hash_connect()")

4f97f75a5bfa79ba ba6c94b99d772f431fd589dd2cd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1742139 ± 89%     -91.6%     146373 ± 56%  numa-meminfo.node1.Unevictable
      0.61 ±  3%      +0.1        0.71 ±  3%  mpstat.cpu.all.irq%
      0.42            +0.0        0.46 ±  2%  mpstat.cpu.all.usr%
    435534 ± 89%     -91.6%      36593 ± 56%  numa-vmstat.node1.nr_unevictable
    435534 ± 89%     -91.6%      36593 ± 56%  numa-vmstat.node1.nr_zone_unevictable
   4057584            +7.0%    4340521        stress-ng.sockmany.ops
     67264            +6.9%      71933        stress-ng.sockmany.ops_per_sec
    604900           +12.3%     679404 ±  4%  perf-c2c.DRAM.local
     42998 ±  2%     -55.7%      19034 ±  3%  perf-c2c.HITM.local
     13764 ±  4%     -95.2%     663.67 ± 13%  perf-c2c.HITM.remote
     56762 ±  2%     -65.3%      19698 ±  4%  perf-c2c.HITM.total
   7422009           +13.2%    8403980 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
    195564 ±  5%     +62.7%     318178 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.23 ±  7%     +25.4%       0.29 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.stddev
     39935 ±  4%     +27.0%      50726 ± 29%  sched_debug.cfs_rq:/.load_avg.max
   7422009           +13.2%    8403980 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
    195564 ±  5%     +62.7%     318178 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.23 ±  6%     +26.6%       0.29 ±  4%  sched_debug.cpu.nr_running.stddev
    387640            +5.9%     410501 ±  9%  proc-vmstat.nr_active_anon
    109911 ±  2%      +8.5%     119206 ±  2%  proc-vmstat.nr_mapped
    200627            +1.9%     204454        proc-vmstat.nr_shmem
    895041            +4.9%     939289        proc-vmstat.nr_slab_reclaimable
   2982921            +5.0%    3131084        proc-vmstat.nr_slab_unreclaimable
    387640            +5.9%     410501 ±  9%  proc-vmstat.nr_zone_active_anon
   2071760            +2.0%    2112591        proc-vmstat.numa_hit
   1839824            +2.2%    1880606        proc-vmstat.numa_local
   5905025            +5.2%    6210697        proc-vmstat.pgalloc_normal
   5291411 ± 12%     +11.9%    5921072        proc-vmstat.pgfree
      0.82 ± 13%     -29.0%       0.58 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      4.50 ± 16%     +29.5%       5.83 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.03 ± 56%     -88.8%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.07 ±125%   +3754.0%       2.67 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
     19.83           -22.3%      15.41        perf-sched.total_wait_and_delay.average.ms
    177991           +32.7%     236147        perf-sched.total_wait_and_delay.count.ms
     19.76           -22.3%      15.35        perf-sched.total_wait_time.average.ms
      1.64 ± 12%     -28.9%       1.17 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
     13.69           -26.2%      10.10        perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      6844           +11.8%       7651 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
     78701           +33.6%     105168        perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     81026           +35.2%     109539        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      2268 ± 14%     +90.6%       4325 ±  6%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.82 ± 12%     -28.6%       0.59 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
     13.49           -26.5%       9.91        perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      3.05 ±  3%     +16.5%       3.55 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     30.10 ± 20%     -64.4%      10.72 ±113%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.14 ±  9%     +22.2%       1.40 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     13.67           -26.3%      10.08        perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      7.36 ± 57%    +103.9%      15.01 ± 27%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 56%     -88.8%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.07 ±125%    +4e+05%     275.31 ±115%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
     35.70           +15.3%      41.18        perf-stat.i.MPKI
 1.368e+10            +4.6%  1.431e+10        perf-stat.i.branch-instructions
      2.15            +0.1        2.27        perf-stat.i.branch-miss-rate%
 2.884e+08           +10.7%  3.192e+08        perf-stat.i.branch-misses
     71.62            +5.5       77.09        perf-stat.i.cache-miss-rate%
 2.377e+09           +26.3%  3.003e+09        perf-stat.i.cache-misses
 3.264e+09           +17.4%  3.832e+09        perf-stat.i.cache-references
      9.40            -8.1%       8.64        perf-stat.i.cpi
    292.27           -18.0%     239.70        perf-stat.i.cycles-between-cache-misses
 6.963e+10            +9.8%  7.645e+10        perf-stat.i.instructions
      0.12 ±  2%      +7.3%       0.13        perf-stat.i.ipc
     34.12           +15.0%      39.25        perf-stat.overall.MPKI
      2.11            +0.1        2.23        perf-stat.overall.branch-miss-rate%
     72.81            +5.5       78.36        perf-stat.overall.cache-miss-rate%
      9.07            -8.4%       8.31        perf-stat.overall.cpi
    265.92           -20.4%     211.72        perf-stat.overall.cycles-between-cache-misses
      0.11            +9.2%       0.12        perf-stat.overall.ipc
 1.345e+10            +4.6%  1.408e+10        perf-stat.ps.branch-instructions
 2.835e+08           +10.7%  3.139e+08        perf-stat.ps.branch-misses
 2.337e+09           +26.3%  2.952e+09        perf-stat.ps.cache-misses
 3.209e+09           +17.4%  3.768e+09        perf-stat.ps.cache-references
 6.849e+10            +9.8%  7.521e+10        perf-stat.ps.instructions
 4.236e+12            +9.1%  4.621e+12        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


