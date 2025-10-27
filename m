Return-Path: <netdev+bounces-233219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E2C0ECFE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2FEF50598E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40030ACF4;
	Mon, 27 Oct 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mybnxP3K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC79309F14;
	Mon, 27 Oct 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577204; cv=fail; b=vGsjNzvz1gJralptv+9KOCYgBlL2BjaKNj+UUadeIL+JKbKlZiTz0s8/og02VTH7K8K7UE0mY3l7Bx4RzyhF2lfYmFWjdawbTa9x83t2i5R7f61ScaOTSUTnpjYRVnUvTyRqihvB98PuKnAVUj5MBoERV/vMVR9cUashImYC01Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577204; c=relaxed/simple;
	bh=sDuV6F/p6dbJfPFEFryLFFfSciQF2FGhQ8OoVnRtdpw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFmy6Bmg1duEAQfGuZXELqYFbQGl38fXWPInBCNcZGvCwNwXyhx31tvSooFDP03hGlEZ94X+cIkCh9dDENB7/iGEwiAkzZZCkg5jIpkJroEkWSfaKm6OnvLSIErFI7SKcGmGJLYgHuRin+Q4vCeP6ETmbZXBCnmuaUO0PRWDUso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mybnxP3K; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761577202; x=1793113202;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sDuV6F/p6dbJfPFEFryLFFfSciQF2FGhQ8OoVnRtdpw=;
  b=mybnxP3KQWUJvkJx35aVdVIKjmwj8HKbkg0/PkcMoY58EnbuJaWbHBbW
   jcPfkTlhuAS6vbv447g8ZGT4HR/bwY1lhKwMH3sJkuURAlsvGbFIR5cOo
   3C3ISuSuzhcg1uQrwH+MLMtov0PFkMOzxrJBQmBKw2XCWvWGBb6jrPvg6
   HMd+kSIaWu5I1jjxYqoVwlIvV3o3czFl8UBtQr8EaTo51OBlH1xEKW6Q/
   PcHXxOXSUxINawUQ4usv/SO7mAfF35fe2A47ueNZ/8VpxQCEqaiVHU0Qn
   lTAwvc7ovUp7k0GMacKXTqzaswmhL0leZ5TC9tb3SJGZR89mZMZxpCGnN
   g==;
X-CSE-ConnectionGUID: uaJmQK2kSuCFwKL0MvTzQw==
X-CSE-MsgGUID: pmF9UeEvQpm006YeNz+0XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75103361"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="75103361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:00:02 -0700
X-CSE-ConnectionGUID: +QebSjZCRGmwj3F7xWdfXA==
X-CSE-MsgGUID: 17qgjdk1TCCBXXvJG0HjqA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:00:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 08:00:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 08:00:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 08:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f75K+37+G2Skz7K/BKHsYoQDwKpLytCZw/Jko0tN8/10aiqjwxfghv/6O7msO0lN5AIljajwRGejweK3k5ObB+pWaqNrgKU07uFALcwixSQNLBSdJlTA+XcUTfSl1tbuNfpqgx6AMB5KGtS9EbfsPqdD8YDNROtnK1XbHLD95itkTAKdzXzr32/33gykVnrG2lzocCyJzI0QLixpP/S5o6OQ+0/CvRcKB6ENox9148MKPtjVxhdbQL1FqdaOnPppVq+HJXs8Hv5pt9ECrl9J+92/9LjmqebIVeX4Mq9NvJH9TXTswmlQuqaqnkLyB7z8rbosoHlx4CSjXINhlQA90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm0z/2nNVQWflllZh+kvkMNzB8tyWF7ACEaR5KpjAmI=;
 b=nsWg1oeQ2PVlxOMc5kXmkll2Xzv8xQjnCaTathjzSrV7/3JP6+PQ3e9BN1p+jdSwPRoUC54Dlrq9V4pYDKZ2a2+kAm2DXrpumiNr6fckvdqndspNefHs4emm+9FIJLifWsd6yi15TnwXD5AakHq45M/zSElg5O30ppPYZwJPzARi2esq+gf20jUhXwyC23Ehh0ZNotz9V+zOiSXrqbMmgh0OuKPqq4n9a52p0im9YqwKK22gM/gdO4GehrjoWWxiRCrdlImG+UwuvHGKyfkti+gbBm/u+CAuqf0VNmpq+fXV5bOrbSpgtFR3593v90LhtPqHKksKtYYA7tDbTRhlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB6910.namprd11.prod.outlook.com (2603:10b6:303:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:59:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 14:59:57 +0000
Message-ID: <dfc94b21-0baa-4b1f-9261-725d8d5c66f0@intel.com>
Date: Mon, 27 Oct 2025 15:59:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] libeth: xdp: Disable generic kCFI pass for
 libeth_xdp_tx_xmit_bulk()
To: Nathan Chancellor <nathan@kernel.org>
CC: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, Sami Tolvanen <samitolvanen@google.com>,
	Russell King <linux@armlinux.org.uk>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b0f318-7eb8-4372-5047-08de15697ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzNYTi92bFlMaHBGb1pNUGozSnhJaVFwcndyVVFIMzlZMjIvWTVQZDNiZlQw?=
 =?utf-8?B?bFR0VWRjWUdETGRXeHRZeHlUcTMvM0hneG5jVlM2U2tUaWNIUThHcGhWMUpK?=
 =?utf-8?B?Z24wb2NRN0pkMmtrUkIrN0F2U1ZqK1cxZ2RGR3NyZElubnNXOU5NRkJTdFZW?=
 =?utf-8?B?QWt0K05RTGlXbnV5TmpxWE1wNHgrYlFEaldxUUF0b0FEZGFMUEgxd2VCK2hp?=
 =?utf-8?B?UDh1c0pyblJEbUlUL2VDcHhrQzBnejNPZ0h6Y1RpK0pwc2FNcTlieU5peUVZ?=
 =?utf-8?B?UGtXWHVTWkJWc0VZQlBuZUMyKzBJWnY4NXJDV2dPR2MwYnE1ZlRwNjA1Wmpw?=
 =?utf-8?B?QWpYZDNxZ2Z3VVg5eHY4T0NQQjNWZS9BVXBrSWpjQVhnZGQzSFBYU0ZCbXNn?=
 =?utf-8?B?Q1VwYTc3MVd6bTllNHNNVnhpbi9JdlBnaTl2d1lxRnV2TWlGU3p5SmxRVzIx?=
 =?utf-8?B?REM5VTRnc0d4N1NVall5K0hQamVjL0YveXM2R21ZWG9jeGlIelBYTHVPeE91?=
 =?utf-8?B?T3VraVpheVV4QVZpd3pVcExEYlNHQ1l4VkRLdXIvcE9ZcHpnUittUm5lQ3do?=
 =?utf-8?B?Y3hvL1dqWitxRWlsVHczbk5nbzBwL2NPeEErTW0rUGpRS0x2V1UyRTQ4d2s4?=
 =?utf-8?B?M2xBeWJkbW9BbUs2SFZrT0IwYnRpKzJ4UWVzVnduajNqaGhMbkd6UDFnazRp?=
 =?utf-8?B?T2t3dDI5eHpCUk13MDlmM29JRFFrRnZ3WFkrdzl5cGxVNmhqZkpKNGFkRHB1?=
 =?utf-8?B?aDNvaW1TZ3dpMGlxUGRtR21uNVZQVHY3cEdjWlQwSnJGTHRhRGFjUWZIMVdr?=
 =?utf-8?B?VzFlbWlDR0ZtZ2xCL2lsNGRPWEUrUEdRb3ByNjVMWWJNR0RSeE4yK2RFMUZx?=
 =?utf-8?B?NWVadm9yY290NlhGS1cvaEhodWZhNTRTcVBKTWNaN1Y3M2RTTEY4TnZsejFr?=
 =?utf-8?B?NXVhT0lGbFIvL2luNHhBUzU5Kyt1RDBnckhOd01CeE16WG1zaXByQVFQS3l4?=
 =?utf-8?B?ZjQ2ZjhWZGY5b0g1bzZSckZuZmhGamtkdTlNUjRIYzhRaWp5cXg2L2Y1UWt1?=
 =?utf-8?B?ZFpZRGpGemNYSEVWdDRQTklZZngyTGczQ0dSYzROQkl4alZhRlc3cVVPa3V2?=
 =?utf-8?B?UjhDU3dSelVhaURtS1h3SlRIMnA3TTdiK0FRWU1SMzhlSUdQMUIyZkZCc2py?=
 =?utf-8?B?TnQ2amUvam5JK3hVVnY2Wm05eEtQMmxTbU5DbW1oUTRBWWpQS2lUWTF2OFc0?=
 =?utf-8?B?VWVoUit2ZFBJR2d0VUVVVjNnY1dlQnlrb3Biek90diszY2paL3Y0YXlYLzRR?=
 =?utf-8?B?bmU3VkNmdUVHWjlmZDFFdDQzR3JhcTlycDNtdDYzZUZOYzc1UGJvbmgvV1pY?=
 =?utf-8?B?cFFxblVCY1BrVHpDV0NUbGpjeDFJT05FUlZ2ZzZYUHlVUmNBd1ZFZzc2bVVP?=
 =?utf-8?B?NW5UWXNGK3NvK2xUL09zUHYwUXRWekY5UnpENGhaaWdWak9pb3BESXZWaE9v?=
 =?utf-8?B?VUxiUDhkTldEUU1uazZ1N2JlU2JXSVBLMzJaM3pZWi9WTHUrN1FNaUxIdTYr?=
 =?utf-8?B?MUFYQjk4S2hIRk9ra2FNWHlEM3p6cnVWU2s4UGZFdFNsOTk5M0Jxd1JZMWI1?=
 =?utf-8?B?UG92b3FkSkcyUnA3UWh2WW5YLytlblljbmJLQStBamMvK0RJV3dxRzI1Nlky?=
 =?utf-8?B?MUxVZ3VGUGZpU3BPdjA1MkFYbzNjeVNHRTNxb2ZVbnpzRkFxQjVYWmhXaHVj?=
 =?utf-8?B?aWIzY0dSNm5DT1pDZEpLdVcyL1NuYnQyOWI5Rk44MHBoTXJIRlNPWm9mRlNt?=
 =?utf-8?B?ajVESDBnTGJ1c1hIRk95aDRKVDl4b3ZEem9oSGFGWDBhdjljNFUycnQ0R3NQ?=
 =?utf-8?B?bEF3NGhpT292anRvTWVjZ0oxVktEK29STW5BR3MyNDhhVXdLMDd4cEcrZHoz?=
 =?utf-8?B?U3Jwam9SamwvMkRhV25OTDVrQ2xJbE9EMUoxRU45WjhpVWlMaVVPc0IxNXdw?=
 =?utf-8?B?ZGppcDBUMGFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm4zQ1FvTUhlV1BTVmVDOGNOUGxPbzg0cnE3N1VNQ0hQaXYzcmRKeFVSeTVi?=
 =?utf-8?B?TXdkMExzNVdoYVlmTVI5S09IcUpXVmxlNXZVRGRGM1N2ZFJaSzNyaHUrTHJH?=
 =?utf-8?B?VWZwSStiYWVlMitxY1JFV3Q2MWsyemg2TzY4SVNEYVdFMjFobURETGlPWEFM?=
 =?utf-8?B?QnBEaC8zRTNHcjZzMnBsbzY3K2xOVFphaCtkU2VKV3JHRFE0dHVWeHpQNTY4?=
 =?utf-8?B?ZU9odERERHpGVm9GRXJ4Y2xBOHQ1VUIzanp6UjNuS05seGFOWmdrUnJaVHRX?=
 =?utf-8?B?NmdiQWp3eWljMWwrakVIMDVyMFViRXRHSE94TG9oSWgxWVN2WFZlVGhIQVNJ?=
 =?utf-8?B?WmxBREVCVFBWSU02UHRRbGk5QXAyZjVkMW5RbVN3Y3lSUEpHYjV5U1dsYnFz?=
 =?utf-8?B?MHZ6YXppN3U4T1ZlRUtzL2F6d0g1b0NwVWE1Mm56T1RiL0VKUjNoS0dVbXJO?=
 =?utf-8?B?bUJmNFFmSUVCNEd2MkY1WWUxenlONSs5aGl2QlBUVUN4NHdDYUc2ZzhnQXln?=
 =?utf-8?B?OGtJR2xHeW9ra2MydkxmNktVNCt0T2Rhdms5R0Y4QXZiTC81NktkK0J4cmlZ?=
 =?utf-8?B?VWpYU3dGSS9wbVc5TmcxMGJUNTVodXpoRmFnMTkyVEV6UTlzY2xjbGNqa0J5?=
 =?utf-8?B?QzdiWGU1SVZDamhyaTZoOXpZc2JOR1VlVE12TEg2MW4zQ1l3bml6QzBZSDR4?=
 =?utf-8?B?RW90Q2hYcGtXSjhxa01IZnFVMzN5SDJUdER2N0ZIOWFzWHdiK0Y4QVFOdDZq?=
 =?utf-8?B?dWpFeWpVZENnVUxNdDluZlIzTmZSaEpQVGpKUmxDdHVIL0x1Q1R0NG9pUEpz?=
 =?utf-8?B?ODBLc0hydFhCVXVTQ1hZVld4dVZzM1FpN0FuamZlNTR0ejhWS3VrdkJFN0JJ?=
 =?utf-8?B?bTJOK2RqbWFYNTJmYVJJbEpqT3AzaGlMQzlGUFI5Z1FIRDdPZFZlaTRQVXJr?=
 =?utf-8?B?am1CUFJQNy9oTWxQUTFWcW5GTjhkQXdscHAzZWN0cVB0Z0NLWTFLVEtKUVdT?=
 =?utf-8?B?RTdqbGFoMHQ5VzBwdnBIQnRraFlML1RqMk9RYzlWSGdZS3F6VXFaZm5LYUlS?=
 =?utf-8?B?VkhkZzRya00xK2JhNnBLZVIzY2RMTzZycXNqM1E4Mk9wWWE2d2ZwbjJ2eWVw?=
 =?utf-8?B?QmhCdS9IeFVweDhwdkp6SFZVSkRYVXprdVorODdNN2tIK2o2NFE0dUFZcGY2?=
 =?utf-8?B?NUgyY2gwYnVrOTgvd2ZGdFhHbGVqNFc0RUR0RzdJNmlYdTA1TDJGRkYxZkVm?=
 =?utf-8?B?T3FoTUVwdGNlMERmcU5RNmRMR0NxUjY0WG55MndBek0rNFZvUzQ0NzVud1lY?=
 =?utf-8?B?VXNna0ttWkswRm1GODZGeDR3bFBhUDRERDdlYjg0UEIxcHRyMGEzdklWcHBw?=
 =?utf-8?B?T0kyYWx5a1BqUzU3ZFY4Nzl0alBRTDNmN1dPMmcxZ29yN1NDRmpHZVhyTDdx?=
 =?utf-8?B?R1dOdW9ZendwY1BETDFLbkUwbFArc015cDE1clpSQm1KWHUvMVJzd0xjZmdW?=
 =?utf-8?B?TXE5TVFkOWhWd0hMdXhZK2ZCRW5oWUZTV1ViZFBpdVNoNGlrLzNJakFlYlpz?=
 =?utf-8?B?Q1Z6N2JRbEJCbTNJc3VDQWhpSXY5MkJjVlBGZk4zZW43TndtRFh5WTBDVW5T?=
 =?utf-8?B?TkZHV0xiVktIc3QzSTA5YnRYTGdBUkNYYm1VNW1mTGhJTWl0dFR3WTFiMXZa?=
 =?utf-8?B?akl5bU9EOFJueDZLVGlMd1drS1NHb2o1T1pUWmZDdU5jVnpKOTlrcDkvZUxo?=
 =?utf-8?B?MVh0dzZhRFdQcnAzNHYxUkJJK0xURU5FeEZqSDk4RXJvZWs0UUlrNzVkbXA0?=
 =?utf-8?B?QkJEZVgwNmNLODQ0dGlWL2RVd2M1eCtUS05PMEN5cGZwOTBINmtTbHo2MDhC?=
 =?utf-8?B?RGRyRnVrWHpBYmVtc0IwMjBWYktCdHo0V0NBeGs0RlBoMlo5SlVRa1FMWDFU?=
 =?utf-8?B?NTBkK1JCNTAzK0dvMm91WFBKSGVqQ3ZzZUdUMUttWUFzVkdXVkMrYjBwV1ZP?=
 =?utf-8?B?QWRLLzlYMWNkTmJBa3NqanR0S29RWkczK09YRTRuMWVXYzM2azFoZlYyQ2k2?=
 =?utf-8?B?Vmk1MlcyVmJ3VCtPUWNBcSthL0c4QjE4eVlGWHFHTVBIZ1R3NGhydWpDazl3?=
 =?utf-8?B?Ylc5U2dKbytjUXhKajVDQ2ROeVBYVWR4eVlXVndQb3Z4c2ZXbjllM240a1RS?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b0f318-7eb8-4372-5047-08de15697ea6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:59:57.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wLHCzFa7ZvPyz0WI2veb0QG7vge8eL8yfNES6cqzvCBqQKVnmZQnTKDR5dSgfDJr/yRwJhMBKclrqecDBXToTrizRtE0mJygrEDfNweK3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6910
X-OriginatorOrg: intel.com

From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 25 Oct 2025 21:53:20 +0100

> When building drivers/net/ethernet/intel/idpf/xsk.c for ARCH=arm with
> CONFIG_CFI=y using a version of LLVM prior to 22.0.0, there is a
> BUILD_BUG_ON failure:
> 
>   $ cat arch/arm/configs/repro.config
>   CONFIG_BPF_SYSCALL=y
>   CONFIG_CFI=y
>   CONFIG_IDPF=y
>   CONFIG_XDP_SOCKETS=y
> 
>   $ make -skj"$(nproc)" ARCH=arm LLVM=1 clean defconfig repro.config drivers/net/ethernet/intel/idpf/xsk.o
>   In file included from drivers/net/ethernet/intel/idpf/xsk.c:4:
>   include/net/libeth/xsk.h:205:2: error: call to '__compiletime_assert_728' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(tmo == libeth_xsktmo)
>     205 |         BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
>         |         ^

I've been wondering why I keep getting these reports for some time
already as my CI bot's never been able to trigger this. So seems like
it's CFI...

>   ...
> 
> libeth_xdp_tx_xmit_bulk() indirectly calls libeth_xsk_xmit_fill_buf()
> but these functions are marked as __always_inline so that the compiler
> can turn these indirect calls into direct ones and see that the tmo
> parameter to __libeth_xsk_xmit_fill_buf_md() is ultimately libeth_xsktmo
> from idpf_xsk_xmit().
> 
> Unfortunately, the generic kCFI pass in LLVM expands the kCFI bundles
> from the indirect calls in libeth_xdp_tx_xmit_bulk() in such a way that
> later optimizations cannot turn these calls into direct ones, making the
> BUILD_BUG_ON fail because it cannot be proved at compile time that tmo
> is libeth_xsktmo.
> 
> Disable the generic kCFI pass for libeth_xdp_tx_xmit_bulk() to ensure
> these indirect calls can always be turned into direct calls to avoid
> this error.

Hmmm,

For this patch:

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

However,

The XSk metadata infra in the kernel relies on that when we call
xsk_tx_metadata_request(), we pass a static const struct with our
callbacks and then the compiler makes all these calls direct.
This is not limited to libeth (although I realize that it triggered
this build failure due to the way how I pass these callbacks), every
driver which implements XSk Tx metadata and calls
xsk_tx_metadata_request() relies on that these calls will be direct,
otherwise there'll be such performance penalty that is unacceptable
for XSk speeds.
Maybe xsk_tx_metadata_request() should be __nocfi as well? Or all
the callers of it?

> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2124
> Fixes: 9705d6552f58 ("idpf: implement Rx path for AF_XDP")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  include/net/libeth/xdp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> index bc3507edd589..898723ab62e8 100644
> --- a/include/net/libeth/xdp.h
> +++ b/include/net/libeth/xdp.h
> @@ -513,7 +513,7 @@ struct libeth_xdp_tx_desc {
>   * can't fail, but can send less frames if there's no enough free descriptors
>   * available. The actual free space is returned by @prep from the driver.
>   */
> -static __always_inline u32
> +static __always_inline __nocfi_generic u32
>  libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
>  			u32 n, bool unroll, u64 priv,
>  			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),

Thanks,
Olek

