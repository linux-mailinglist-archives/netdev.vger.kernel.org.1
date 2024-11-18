Return-Path: <netdev+bounces-146023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48689D1BB9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7EC1F21E12
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13431E767D;
	Mon, 18 Nov 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CH1vl+f8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02F153BE4
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971627; cv=fail; b=msLbf3ovAeiXHcUiSYetRo2Z2d0/Fb5hlY7uNaTFubDpdEXyTs28laODkvSW8L4BBpoH4tPhfGldnkfjpRuTaItUXbIzbZbV1QQOiQiwqY2JTpEQXYzZMTR+rJTL6qOXAF17LUWG1APprnDr8Wqipl4/FNCzNClWekC+nP36cDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971627; c=relaxed/simple;
	bh=xdyL+q8CDZ0viK1J67XuGgsh9Nyv5Wq4WOKTW8oCCms=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TfK9VtxipUgEUIjK4HnbSg78EPnB+ifx8UQd3WhYi8xd9z6sn+KewUtUVzReKng8vr+hveOtllKqlyvrXUj/u1XGS/1/Q63pWgDSagNihWYYso+jfIyJKWccOfLwjej1bkOneHdlaZUHD6Uj61KtyNIAUUAYDNAOBYGnWTXcSRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CH1vl+f8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731971626; x=1763507626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xdyL+q8CDZ0viK1J67XuGgsh9Nyv5Wq4WOKTW8oCCms=;
  b=CH1vl+f8WSlMTRsvjBOgGT6K4VM2IB1ft69ff5f+05S6VYHDU44llEYi
   Q5n9Cw0Rqee+/saYgT8uG2V7H9ZIYEHRwFMb/fM587t49XtFvayD4sR+d
   sj0IWe7iqz19LJ6sbJW+026Cw47MZyIBEnToLLG/dZIzTl+PvBmOo323k
   UdymSialNQmGmCB7tdYrbRTVk6CKZ4Lk30mRQFHEA6IdvOqwYwhoihVHq
   qWWCiJG+3SvJ1Ohz6/rlyWyKWPR3/ecYDqWoak+mxNIw83icAXJetijm0
   6Hu9K2IOa+7DD5JqIzGQq/6RUE3yG4Q3vKY5uPsmFLQCSuA5gMxb6lbNH
   Q==;
X-CSE-ConnectionGUID: F1X9rGMnSqmsu8k8mECvfw==
X-CSE-MsgGUID: GtYbQ2UNTZiiob4rlYXchw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32051607"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="32051607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 15:13:45 -0800
X-CSE-ConnectionGUID: FqpF6bCRR5+PS1/JO5LHnQ==
X-CSE-MsgGUID: GPrFdwtkSp+wr3A+mruKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89148218"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 15:13:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 15:13:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 15:13:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 15:13:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6w5UNCFQTrYpLJ2vewjJjUkjRdD/+T4wlAHSyfUCqZqAWRSCYarytwvuqL09ra0PbFptS329PKhkQyhtwlzTaEVcBTv/IKthuPf/DfdMVlnqPrevRC/dMUyyMTR6/xhOpIfAwHfKb73sRZjH6PtzLxiTxMtYBMGQQzuwt2783ynYyyJnFYs7fwIpmeitTL1Ev4FUPK1FelVFqp2qPEcQL9Pp1JC0du+ZZHoHv2aQ2P8GmIIZja+V28TOTO7zIwZyw9zQcgDzRh+7RqF/3dQirQ4a2yTxSN3GzmXnd/WpK1luFeZFjhGzkeREY0ciUcUgFJ/7db16eBj8fBioTYrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xRMb5V/woOYqwYN1l9HYZyENL7zcmyrromJh6jfzd0=;
 b=mw8gWa83oEcpu+v5Ck9gGNfiqAS2Yp20CSw3zogy08Hl8qbfo2tpU1/BrLapXb57nfxqcIUjRnZqEErlOai1B5ewo1AsJvwEnXqeeMevlg2fQEVyRCuDFw99bPH14AVJNzpsrHBP30mgC7woOqg+A23Ipc+TrDbjp383T1TeDkripv8Vq/MwVdBGHRyTxMKkapIzAlz7uFUM3qmgZkRfLicmwIpP5VrCuaAGhwnBTh35M6GaG1oMIDe5+vO/lNpgk7nA5lw3vi0TEfaTD7jz+8VqwPTMnjaUoz4yhgo7DiCQNqpt5ipqyWOfHedCOMEnlvNP3cPGe+3ov7aRrpBhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.21; Mon, 18 Nov 2024 23:13:37 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%6]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 23:13:37 +0000
Message-ID: <062b57cf-7f5d-412f-9288-685c4c600d53@intel.com>
Date: Mon, 18 Nov 2024 15:13:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next v8 0/9] ice: managing MSI-X in driver
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <pawel.chmielewski@intel.com>,
	<sridhar.samudrala@intel.com>, <jacob.e.keller@intel.com>,
	<pio.raczynski@gmail.com>, <konrad.knitter@intel.com>,
	<marcin.szycik@intel.com>, <wojciech.drewek@intel.com>,
	<nex.sw.ncis.nat.hpm.dev@intel.com>, <przemyslaw.kitszel@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <David.Laight@ACULAB.COM>,
	<pmenzel@molgen.mpg.de>, <mschmidt@redhat.com>, <rafal.romanowski@intel.com>
References: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS0PR11MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: fb95f261-bbd6-4811-5e0a-08dd0826a198
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2NEQ2pVclFrVzQ2aHZraGg3SGFQMzhwNzBtR0luUDFFanN6eUdYN09uaXVv?=
 =?utf-8?B?Ny95ZFVXU0pOUkN4amNSQm5Cc3hFK2l5L3gxODZCMzcxK0hIckd4aDEwcWNs?=
 =?utf-8?B?aEVMSTlpQW91aGFZM3lpSnIzbmx1c3R6Y0xLY2NORzZKdGVNL0puWHpEbERu?=
 =?utf-8?B?ZmZFSGxROGlTWGFuUm9QM2RlYkF3c0NQZnJoOVlQRkQ5bG0wS3EyRHVHNnlW?=
 =?utf-8?B?S3N1eEkrTSt3dlQ1OGkrSjN2MTlQaWlUV0Zqa1J1bVQ3SHAzdkV5aks5SWo4?=
 =?utf-8?B?ejZsbEtMdFZkTWZVNndVbXJjMFRkZVhQTFVUNStFNGdzNnh5cUM1NmdWdVpz?=
 =?utf-8?B?YWxPVHE3c3lVeVhFbHlxUVFRVTFKYTlRRU9kNWVYa2R0R2FDanF0UzZ5Nzg1?=
 =?utf-8?B?Z2pEbmZiemhsQWY1MEg2d3dnUHI5L0FvaFk1UjkxbFVKMmdOaHdkOUpnMHYr?=
 =?utf-8?B?bXNNTjVreThveGx0OE4yQ2xBbGhzUWs2OVRQZmtaU2cya3JwcXZhYjBKRjZu?=
 =?utf-8?B?TXk3ODJVWjRKZjR1UUp6RTkxbGo1UlJ4dWtOT3Q1R1g5VzVLQU8xYTFLM0dy?=
 =?utf-8?B?UlBSRmJmRXdNWExGOUdQbGlNRWo3SzNsVzJ6NkZJanRhTngxUGdSQVhKd1dn?=
 =?utf-8?B?OTlTQ1kwNjZFbEJrQXdsZVdxZTR4dzRmTlFNWVRnREsrcTZ2ejJtUTdPL1Bw?=
 =?utf-8?B?a0xKOE0vMlZaNFV2d1Nma0pEeHZ2VGhMLzdoRnJOWU5QTWw2Znd3QjNRaEV1?=
 =?utf-8?B?c25oV2ZsTldUNUhaTzJEd1VGTTN2N1BIcE1YYnZHMDFNd3Rkb0FTblQ2WklR?=
 =?utf-8?B?Q0svNS9aNXd1Yk5ybGl0K1R5dUVGSFJIaHdRZWVjRUlDZmM0cHZMWWR1UmVH?=
 =?utf-8?B?QzRCcTFSVFp4T01GVjErL1M4MWExbVhuYU8vbWFzLytmM2k4bG5SbkpEaWg4?=
 =?utf-8?B?Ulhya1psdmtIZk5lSFdYTjVtYzlpdmN3U0FocldoWnJ0LzJNSFZ4enR3NUF5?=
 =?utf-8?B?SHJ0S29GRExobEFYL2dHeEcvNDJMRTZRR2pOcW1jOTBxdzcyUDBPWTJBcUZn?=
 =?utf-8?B?cFNCR2crTy84OWFYUGZGZ1Q2aDhoaTk1eERoU0lQZTJkVnByMDllM29iOVlS?=
 =?utf-8?B?Wnl6d0JPWVc5T2ErMmQ5QUxNY2VJUjFJMkdWTmpFNmU5NzB6ZHlNYzljM0wv?=
 =?utf-8?B?S3E0ZmYxQUZQK1hhZmZqNlpENFE2ajhmSGJRN1RtT3pZYmhEc2Z0REdvc1Q3?=
 =?utf-8?B?N0Z2aE04TjF6eWxJVWxFcjBHNk1WcGp0Vm1RejgxR2U2bzVQU3ZqS1h0bkcy?=
 =?utf-8?B?LzFRdzdURWl4aVBwK1hGV3RyS21adnE0NUNKTUtWcG9Ca2RsdEVTdURsbUpK?=
 =?utf-8?B?QUJ0NURUMlplbEh1bWhuRHdKTDFPbDhJaFFOOWVtSlpBbTNubVFhdVAza2xn?=
 =?utf-8?B?SFp0K05SdWFoY3dCUkYvcFVsa2ZVcXJSdmNpN3BlSGFUek5pV3Vna1duUC91?=
 =?utf-8?B?ZXY5WVlSbCsxN2Nvb2Z4N2UvQ3pWc1hCY3lpZytXd3crK242UFRqZ0lJVStM?=
 =?utf-8?B?OHRka1h5U0J2L1R3SkFBeDluRWZ1RFo5RXltSDYvcm5PeE9HVXVueFgxSzZ4?=
 =?utf-8?B?dEZWc1podENCcHJtdHk2U0tRRHhmZEtrMDFldlRBRzc2Yk5kc3VaeVpRSlJw?=
 =?utf-8?B?RGFrT3BsRWtJTk9QR3hjSVlraXVBRFpqYjNBUm9kMENLa2ZZNnk3dXJacGFH?=
 =?utf-8?Q?FlxLuc798/fferAI0MBfTYCueUuYPj0mBXsgvJb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdhQjh2b3Yyam5JaFBHUzg3UTkwU0p3czVGbk9lSWpvb3ZTZlVnVmpXalo5?=
 =?utf-8?B?NUFReXpRc2JIeFBGektPYnBwQnpZa0k5RXVQOE93NzdxcFowODVOZ203T2dt?=
 =?utf-8?B?MFdWekphajVPVnBHQ25KWXZpYzhHajVEaTBMOFcrdTBjNUFlZTUrYk1Hcmxj?=
 =?utf-8?B?SFBYYWMrRE5uOU9sYUc5Vis5MDRqVUVGY3VIR1ltSk81TUJ3eTdqa3VhK0Fn?=
 =?utf-8?B?dGdZeXNpeWhLeWlzdGRlRk9TK0hwT1lsekVDY1FON2wyb1hBTmNxYW1QSjgx?=
 =?utf-8?B?bG4zN1VURVgvMXhudVE3TjhldGNsck9NOVhGMDN0MC9qanUxdXhvV3d4UzVr?=
 =?utf-8?B?dnV2TGppMVhNQXZKNG1UNTJDdStCRHl0YXRnK0Z2K2tJYU1qVzF4MnhVVGVo?=
 =?utf-8?B?NHVyY3hkdDRPcCthTTY4eVIxdWloMTY1cnI0d2VIUXJKUzJFY3hUTTJ4ajdx?=
 =?utf-8?B?ZllONHJ0dTNrTTZDbytDTWZwZDlzaFZnckZnTXdyZndwdTNBTnNsQ3ZJbWJS?=
 =?utf-8?B?OXROVkRjRGRIRi9CUVVJaEZUd0tQeDdhdFB2Mk5YNEFDMVM2bkRuL3lvLytQ?=
 =?utf-8?B?WkEwYnEvMFdGWHEvREwwR3pKSndpOUlGNUtRMHRxV3g1d1BCRG9PbmdDYkFu?=
 =?utf-8?B?RzRlTnIyMXRPOUE4S0V1YnZ4T3BEbmVUUmhKNjNFb01hZkxMalJxb3lwNkJM?=
 =?utf-8?B?c3RxbG53YjJ1OXN2b2tha2M4TjBadktLOXVDcWtFVlhhajllSGpDK0tzNzRP?=
 =?utf-8?B?dExGSFowMlphSVg0L2xFMnpkeE1PVmhVa2w0YWhoMDQ0N2xaWStRTDkvdTRI?=
 =?utf-8?B?VFA2bkwxYkZZdSt5TWVGQkF2MVNMbDNaV01vM09uUWhIWURoTEhGRWppejNU?=
 =?utf-8?B?QndUY1ZPckdkMTFwTHQ4Snk1Z3VoTGJNd3VsSVdIblZ1eTdETmdvR2FwZytu?=
 =?utf-8?B?RkVZdTFZREFTNGYyMUdzMnJUSjNIRzZ1eEpFS0cyWldQQ3hOYTRnVlpJQS85?=
 =?utf-8?B?SmlSMjJrTXVObVlYK29ud24rdmhYMFVYNkFzVy9SSEVMM2VmT1NoazNYRmRN?=
 =?utf-8?B?U1pvd09vVER0dGYrU054cDN0VzB0TUhMWUpWdnRDcU9Yc2dmS3duWDAwSlh1?=
 =?utf-8?B?QXNRNnQzbFVSdURPNWthc2gwVkJYclNCV1RnY1ZFMGNwbDYzZm1TT3hXL3gz?=
 =?utf-8?B?S3J6Z0tyWFhOTDRTN3FzVnJCUXlNbDRzWmwrQVl3Y09xRGYxSGJnYW1HanV0?=
 =?utf-8?B?em92dThLZlVwSGUxZy9yWjVQbHlscXVURFpuM3FRY2g2MDlxVFFEdUhneUdB?=
 =?utf-8?B?czA1TnU1NmtIdUF4M0dQREs3c3RjMGowREhpQVpVZXJOZ2luaWRWelNRL29U?=
 =?utf-8?B?TC9oVGZNRms5UjFtaGlkSVlNbGlwaVpTckhxYmFHL2dDUUZibVFpekYxL2ZC?=
 =?utf-8?B?T3JGcU9VNlpSbXdtZEFGTDRYc0xqaTBmRFVvcTZLMFZJS0RBRnpNODh4d1VC?=
 =?utf-8?B?elVVRXRqRUxtSE03bEtVS2QwWFpucGUxcDNEdXEvREJBVUYzWUhJY3BNODlF?=
 =?utf-8?B?THlZSEgrc0htZFBtaHlVb0ppTmRQVXNSd200VitJOWhzVWpWQ21FM2dZZkdW?=
 =?utf-8?B?bG0vc0hpVEQ3YlJ6ODREOHJiSDJvaHdELzNzZlhPNExmaU9mZHJpbURkZHRx?=
 =?utf-8?B?UkFPRDg3NW16akJiZjJLcXdqTVorTDdsYUgvcFNKUWVtWXdkejd4RDRVQTE1?=
 =?utf-8?B?OG1iOWgvbjNUVktrREt2QWpYT0xQem5YN3FWU3BqOEJkQk5PUkFPVFhPcTFs?=
 =?utf-8?B?K2NUOEV6RU5EME16UlNsaFdyelBqdWVjTDAvbWpwZi9BayszRkZqOXdvWlQr?=
 =?utf-8?B?N3B5V0ovOEJXcktCanFjVmZnaTdVZWx0U044Y0NqK1VKWHFZVFlaemhHOUcy?=
 =?utf-8?B?YjNUZU5peDBxU1oyYzIxVklKNm52ZWU2Ym12d3dvWEFoakQvamJaRkludmNU?=
 =?utf-8?B?bE1FR0ttWW12NXRRWHJUT2NFWG1vb2ZIbnNqRm91bXRXMFN6N1RJenZadEh1?=
 =?utf-8?B?ZTJOMFoxRkxyR3BNbHk1OFlLOUpSWVpqZFZEVmFEVzRIWktiYWdCTU92dXBw?=
 =?utf-8?B?UkpNWGowNUR5YUc2Q0FSdFIwVDhlWDhaK0FWK25qR1k4ekRYNVh6bDVWUlpr?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95f261-bbd6-4811-5e0a-08dd0826a198
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 23:13:37.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMYTbVFpgSJuV6N3zcCrhpwJS9dv8RTOfL6grSzRU8RpykMgcSSN3FV2GQ5W++kBxdJGDaZcQm2dfhFcnY06bAUL3iU0HcTPXoLBaUcqb9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352
X-OriginatorOrg: intel.com



On 11/14/2024 4:18 AM, Michal Swiatkowski wrote:

...

> Note: previous patchset is on dev-queue. I will be unavailable some
> time, so sending fixed next version basing it on Tony main.
> 
> Michal Swiatkowski (8):
>    ice: devlink PF MSI-X max and min parameter
>    ice: remove splitting MSI-X between features
>    ice: get rid of num_lan_msix field
>    ice, irdma: move interrupts code to irdma
>    ice: treat dyn_allowed only as suggestion
>    ice: enable_rdma devlink param
>    ice: simplify VF MSI-X managing
>    ice: init flow director before RDMA

It looks like something happened with your series/send. It's marked 0/9, 
however, there are 8 patches here. Patch 1 in the previous version [1] 
is not here and patch 8 is on the thread twice (as an 8/8 and a 9/9).
Also, it doesn't apply either with or without the previous patch 1.

[1] 
https://lore.kernel.org/intel-wired-lan/20241104121337.129287-1-michal.swiatkowski@linux.intel.com/

> 
>   Documentation/networking/devlink/ice.rst      |  11 +
>   drivers/infiniband/hw/irdma/hw.c              |   2 -
>   drivers/infiniband/hw/irdma/main.c            |  46 ++-
>   drivers/infiniband/hw/irdma/main.h            |   3 +
>   .../net/ethernet/intel/ice/devlink/devlink.c  | 109 +++++++
>   drivers/net/ethernet/intel/ice/ice.h          |  21 +-
>   drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |   6 +-
>   drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
>   drivers/net/ethernet/intel/ice/ice_irq.c      | 275 ++++++------------
>   drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
>   drivers/net/ethernet/intel/ice/ice_lib.c      |  35 ++-
>   drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    | 154 +---------
>   include/linux/net/intel/iidc.h                |   2 +
>   15 files changed, 335 insertions(+), 422 deletions(-)
> 
> 
> base-commit: 31a1f8752f7df7e3d8122054fbef02a9a8bff38f


