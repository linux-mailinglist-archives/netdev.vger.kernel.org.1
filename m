Return-Path: <netdev+bounces-127926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8024977114
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EC8B243A5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74D1C1757;
	Thu, 12 Sep 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdBTPSUt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9391BF7FC
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168048; cv=fail; b=mlXA4I45LqtyNcogGcFyENxOTSUDju2uMeTRKI42DdRvwyFrHshJsgxcOKmB/2S1OKzFrZLtC5L1qIXU1HQ+F/1fCYpjTAxhnf+ctyQtsV/Xw0d9W3p+lcKtQ4rPJk0cUJEZTtnM3mFSuDwI9vV8Yw6HQRc29xyTmK/ZYkQNbzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168048; c=relaxed/simple;
	bh=Sq0ypfaNlyV6ZY5mm4kBe5rAf7WSAxMuobY+zIcZDiM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIJ11toqptgXE0bd96nOi2q5Nl/eUEKOcLFWYCmWja1w99Q4gFXMjmEjCBS2aqXTW8asQIY/nUjuHPyYhSArPMAa5hwWuexxYNy5KfY/WILkaE3JUzRQPQx4Wd3N+Rgo/VH4o22m5Qx+prEkRoByc9CvD/riNpvN872xxv6ryzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdBTPSUt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168046; x=1757704046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq0ypfaNlyV6ZY5mm4kBe5rAf7WSAxMuobY+zIcZDiM=;
  b=TdBTPSUto/Gtt9wrRag6NzdRVvKTUXc2Tz+O52/SqK3Hiz72nvN4rK8h
   wqUMJHjqIYtCOCF3xLa0cyRizae+WPx6UGg2pzI3cIcrE3e5z1TPYM9u5
   AfK8N2VN+QoC/UJrWmP1vyPZGDNiOQsggk0VOb+J2qdLxLNnAgAMaonrq
   W369bVYS9QQ6o5uESBvAwc9inYYGmZcTeCmVtvulftUpBCTKYj31NxgQq
   /QshEXEhF3q28lj6A+Ar1l8PZh0Pn5xtgzUcgLM97EiO1YEG7Q4gvOcmJ
   ERWe8G5xhEPtZ7JPc09c7UfK93ADHBCmvQFacWW7j7mjFbKYeRTc9xGN2
   Q==;
X-CSE-ConnectionGUID: SAQIUdLDTUmXJ1utFQUvMg==
X-CSE-MsgGUID: XZVAVAYIRlmQczIU2q3j3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25204288"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25204288"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:07:07 -0700
X-CSE-ConnectionGUID: U/1vPnaHQnaeubMNbiAt3w==
X-CSE-MsgGUID: Yu8GZKQLR6SjdTz4GAlrWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="105268591"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:07:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:07:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:07:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDt1o6LvvIBcRoGytZ9GzRgqoWQz05fMT5nv0Xm9UhNT+gl2Sy4RmMJEDUcfkMvDemIy2zeAdngey7vmQhlKzgEC87lyE1fHIMJxBy8PYZSTSZzEFMR/ZkCzzSnqTAImX8xPjtOg6Se/jCEKcdEM+rVgOkEmjx0FGXwsRZoSIyvKMnmgxs493Ooz5RFaT5PW+kYKiCk8YVC15Wpk3M63E0/a9eN5NbhUm9rC3Q6g4Yl2LOQbjH95GKIEaPkN1iDztEZAmB3N4vio42u2f10WpOkexeASgyaXj/J9JT9W7vpLINDUleF/A7gBljj8sOgMBjNidVm5IVVdPsTiYdrvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B02MbRbpjQNDQq+AqIT7hy2dMXQxwp+ck5vGXL9euKg=;
 b=F7SjerNZX/tpUuX648Yu9XYsBkl0tF1ewZiYomHxK5zEz8/qK77FaNsUs6qROf+CjSEwgP3zES4etf/IWnvshlkqUP18Zvlh9m2Ay1pj6vnexJKUdFjHSo7NfSiEhwDZfvgT3L3hCpe4z82uyUQL6B/9My2itD7hiapNefcF5N2UnZXO0N7Ihbt14emXfgz1VKweRvdWwTHXkB/j4QZsCpJDwGCeotln7v6u6KICKgkJ8YmWBFszqpOFVUX7buU2psBCHTe8fVoBrBBeM7veIzkig1clkj49etgwicZ9GizUQ7TG7YOEpgdC0YDMNKdHaTISg8Z660QLyHbs6KY13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:06:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:06:58 +0000
Message-ID: <a4fe6053-0389-437c-aad1-f0004752e154@intel.com>
Date: Thu, 12 Sep 2024 12:06:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 06/15] net/mlx5: fs, remove unused member
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-7-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-7-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f1fd4e-d533-441e-cc7f-08dcd35e1329
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVUwWnU0a292Sm0xOXpUekRKVGY2N1B5dXRyWk1WOEJid0VNckgrbjVxdnl1?=
 =?utf-8?B?R2YwNDBwTWFmMUdKaFNPQ3M5VG9XOG43eUgxbkgwcFFJQWdnTExEcys1dVV2?=
 =?utf-8?B?SnpSNXlQbEdzc1U3eldoZjdFUlp2Q3V1YWlxVmlJRjR4NURUOFhnanlyV2p3?=
 =?utf-8?B?d3lzVkNiWjByQzg3LzRGYllteEVlVnBTUEZER1ZUOVNhRHpZSUwvQWEwN2Jz?=
 =?utf-8?B?SzNsV1ZNdytXdTYvUnlkRGx2cVhyTFAvZ1pSUkJPMERwZDE0NkNXTDRWR1Rr?=
 =?utf-8?B?UU9jdndZUHJ2WmRhYXUvZlJQNTR0TVV6Q0IvTUhvNVRIY21MMzh0UkNrMDJR?=
 =?utf-8?B?Zmo3ZTcycGR1NXB5ellJblRoRXlOV2VUL2VZZVpDaE1ET25oVFFFK01VU0g4?=
 =?utf-8?B?V3UwdFFzQ3BDMUlPNkMwdmdkYStuOWRHVjBSMWRxVERhcFcxalRrTzE3QUUx?=
 =?utf-8?B?ODI1ZlFpbmhjQmVYR2RQU1pmemVZYjBaSlBVL1JDbnExZFpPUTROMCt1MlVZ?=
 =?utf-8?B?YjlQOEs3NGtNTXZlZzR0N01JVExHZ29FWXpjcDB5RHVXUjhtYSsrNzJrUERV?=
 =?utf-8?B?eE5JRk5aNjFZenJUMHhja2Rpc0tKZUpMK0xoWmtwa3NzSGs1RnVGZnQ0VTdH?=
 =?utf-8?B?MElOc1l5VjBSd0dnN09OS3lweHRtUTQrMnd1MXlreFNYR3JPa2I2dlVCdUpz?=
 =?utf-8?B?WDlpL2pkQ0xQVUlkZ01XMWVMU1dTU0tTbnRMOFlhanlVeW0vNjBoU2lDVU51?=
 =?utf-8?B?cFJnN2ZpVDhTaENqN1pUYUJ4aU5XK2hWN1FxdHNKK2ZVaXdhVzI0ekkwdkcz?=
 =?utf-8?B?TzV3WFVPeWkwNGh1TDVKRnBuaFkyZU1GcVlZNUxYUitIb2tkMkUwWTg2S3pp?=
 =?utf-8?B?RDR6QWlTSk50eEVLNjBVL0JGQ0lpYi9seit6d2lDcEREVTUyNzI2bFR1b1BD?=
 =?utf-8?B?ZDloaVp0bGJNamNCdy83OXo3dlQwbTYvb0l3OFFuTWg5NTRlU2w5dVNDRURL?=
 =?utf-8?B?R3ljbDIrU25rZUpVMmRZZ1QraFQwQk95WGREa1E1bHJ1d3VobGQ2TmlBNnFt?=
 =?utf-8?B?dnlFTjl2NVBDMzRrRFNGV3NhaWZMSUU4UTlsWVBVWC9ldXNYZnRqYk1vN0RK?=
 =?utf-8?B?N1NYdkpqM0F3RTVVT2tNL1YzNVQra2FndVNJWFpNc3lJWTB4bTRDYkxPa05H?=
 =?utf-8?B?LytsQUk5OUZzTjhRVUJvMUFGUjU1b3ZSL05ERGZCY0lmbDdESnlaUEMzVjZj?=
 =?utf-8?B?WG1MSG91ZVNiUnNCVU9FcGJKWGZORU9SdEJGSkFGdEptREpZY2l1Q25hZjhB?=
 =?utf-8?B?aTE4eUZSUm9pUTYyVG1md1lXdjQyVXg3dUlOdnlpS1ZFb3kwU0llY0poejdi?=
 =?utf-8?B?Wk11U1RXcWVVSU9odE55MHpDRlFiRHl5RDZucGVTd01PYkkzeVRFNXBOTVgy?=
 =?utf-8?B?aVhLUFV5dXc1a01kV1FnMHF5ZjE4enQ2ZmZJT3o5SmVJWllveHhLVmVZc3Vq?=
 =?utf-8?B?TjVJeFM4bVF6UHoyWTMwdXVMdmt1eUdndG8vcGNFa3ZESzgwamtWTld1QVQ3?=
 =?utf-8?B?bjhSYm5jeGtRRW41Q0hVK2R3UnUrbndpTFA3L3ZxUFNmOEVGeE0vdDJXNFBJ?=
 =?utf-8?B?ejFaUHpSRmZEZHNBUm9ZOUNYUkpoUXg0UUcvOTZTcElnWTE5TDYvLzFlT1hB?=
 =?utf-8?B?c2tLZUlucTQ0enRQZzdrZ21rTEN1eWNLOXNySk53YzJxVkh6Mm1VMEVTSHdp?=
 =?utf-8?B?dU1GMEwvQWM4Tk1GRGF0bDZRTlZTaDBrcjdVbDdvOFFNbTZTcnN4ZXpwSEsx?=
 =?utf-8?B?NVgzWjAwNVZZNk8zVnZJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpQYm9oL3dMcHBnUHdKSWlzMnU3a3lhRk4razdTRkhBNVFRcmlOR20zOTdL?=
 =?utf-8?B?bWk4T3JNbE5SdmRDTk03MHpFUHBscHN2UUg2VzJPOEZNRWVyekg4Z001ZU00?=
 =?utf-8?B?MzM4eUw1Wm5NMDFOdnRKU1hwU0NwMnFzVFk0aTBsdnJOWGhIMTR6LzdSaTVF?=
 =?utf-8?B?aUFUVWs0SHhjeFVaVTY0eXlQc21KbmNSS3VBSUpZbHUrZTJzMG1EOUlaR2VP?=
 =?utf-8?B?QkRMRjNlRUxQdjNqcFpsem1WZ0E1Yks2ckZYRkNQRUI0VlZJYWIzRlIzM1ZX?=
 =?utf-8?B?MVVXMnRmbHdaNFkzYWVrTEhONGFxaTBpYWs5azNMbEkyK0ppanJCdXZhWUNH?=
 =?utf-8?B?SVdNWDFjaGZVeE03aktkOHBlYXJ1SUo2OUhMSzgwam1BR1FYeWtBTndSdXla?=
 =?utf-8?B?UGVzbXFrY1l4MzhCL0RxVjFmWG9QQjBtZE1OblRrVklqVFhyRXlWUVVuYWx5?=
 =?utf-8?B?NFA3VlJUMGZ1Z0V2Y1RlNWdDdmZUdGw4Q085U2svUkVZZVFRekFpTWVpRjhB?=
 =?utf-8?B?SVhnZHQzdjRWTTNzeWNYRE1VL3FjNkVtN2VFQXJzSGxKdmRuUVQ5dlliUkZh?=
 =?utf-8?B?Uk8zSkpNNlFyOFhzblBsR1EyTHVNVDd2L0tJNTRqRXUxM1pmTnllTUpQUlhw?=
 =?utf-8?B?YytsK3FUUDZ0RmdUNTU3eVdYRExVb2c3bDF2UmZ0TlBBV1lJWnNLd2l4UVdY?=
 =?utf-8?B?NmdMd1ovSlFEYnRIZk9YVWxoeC9LMXB6akJiY3FwV21QL1YrM0ZGZ0R2eVpw?=
 =?utf-8?B?YlkxWjVLbVZNaWJlMldqS3dRRjJ3LzVGdWJXMVlqdXNSSEpNbzUxamExb0Q1?=
 =?utf-8?B?b0lFcnNRTUlOc2t0NHRFRzYvQWQ1VXRDaWFDeW1vMVY0cFltTWtiZjdHM2tY?=
 =?utf-8?B?enFLMEVTWG1vU0p4RkpmSTNhWE5FazhERERYc0xadnJFZytBb1d1YWNHZU9j?=
 =?utf-8?B?c29vMDFmZ09mSnlhS3QxNUdha2IwMXY0emtDcklBRzczY1FSVURtcjArcGx4?=
 =?utf-8?B?WnJKQmpLUUxBVzVHa0NlOU0xN1NrNTBFdEZnVXhDQ3NPS3ZBL2tmV3UxOU42?=
 =?utf-8?B?cmg3YTVXY2dHbzNIdHgzVzNzd3dBd2YxS2NHQ25TUWFJWk9ZcWp0NzNtdGln?=
 =?utf-8?B?RXJkdlluM2Y4OXFMMkRITmcya2dvNDlGSVBSejV2Nk5NY3N3QkxuVG9WQWcr?=
 =?utf-8?B?VmxBdEdHazVDZ2VMTXBqWVBTVUdtYTNEemR6UytVVlJ3bEp0dDdlZFBLUGlD?=
 =?utf-8?B?UjBBRHNKOTVuUzExckhJNVZkeVQ3bElJOHI3SU5iRTlYTURpKzJMenlma1g0?=
 =?utf-8?B?REF3dE1FY0hRaVZEWlZDaWhHQWhFbHg3UVRDVXRjem1JL3ExWU4xZkF0VDZD?=
 =?utf-8?B?TTBHTkZxRTdUU0RjTGlSRGlaazFGdXRyZkU1STE2Vk5vWGY0QjRnNFFpRGtz?=
 =?utf-8?B?Y0RCdS9WaXZhM09EUGN4aFdlVmt1OU1hekZ0Wk5KK05WZXB5WHpJVnQ3c1Zn?=
 =?utf-8?B?RWFwUXRZZ1RkNDBGUGhnM29WMDA4N1pEOXlobmV4V0ZLMExiVlBjREg4aHBz?=
 =?utf-8?B?U3BFUkRiaGVlaTN2Ylk0aEtmL08wQUF5SnVEb1dNVS85Q1dYVldwTEJHbncv?=
 =?utf-8?B?eXh2aTdZV05pM0dtS2hCeWlCMHpWL1o2T3hQRUllNExZcTFwd2g3NlZtM0xD?=
 =?utf-8?B?TTZmOUZ0UHR2ZXVDYjVHTm8zNm85dU95T3lWTHlRVVBZNWtsT0lOMDkyN21k?=
 =?utf-8?B?clFZTzRRamEzUzc5dmlwYXNkS2ViSkwzNHFGNnZNdjE2K0pMbmJZSGlqb2Vt?=
 =?utf-8?B?MGdGM21oK1VCMmN5ODErQTV6WmZxODQ0aERxTFA2eDJpWHFoZ0FSbjdDZHNH?=
 =?utf-8?B?d29YajdGTDhORWluZUQzZUEvZEVEd1J6MGpwYUpqMFNVN1Y0aVFBS0FoYnVK?=
 =?utf-8?B?ZU4zblNqclhqWkxUdWxZSGsvSGtrNUFFT3dhOGNPL25nRTU4N1QyYWllMllr?=
 =?utf-8?B?cGlYTVJ2VFJDS2NlcDA0N05ocGE1b0NWcnExd1lwNXVkQy81SUl5WjFPbERo?=
 =?utf-8?B?Vkt4UFlMU1ZRaFZKMkdxckhWaElTcDQwVE03Qk90aUNUUjRKdk44UFcrSEVk?=
 =?utf-8?B?OHNYUnFwUnFiejFpUjFkdHl5dzhCVDgvT1hzUjR4aUJuS3dEaTdiK1AvdHpR?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f1fd4e-d533-441e-cc7f-08dcd35e1329
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:06:58.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7G63HHXdHE1ajvcHeAn1e51qaUcyJxLHqqF7tuZDB0/mNBx6HFilAdMLMVIsyosIAQlNKWQJUnEuTWoCwx7gGveljv82bWg5HiKK4nbz6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Counter is in struct fte, remove it.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> index 6201647d6156..5eacf64232f7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -241,7 +241,6 @@ struct fs_fte {
>  	struct mlx5_flow_context	flow_context;
>  	struct mlx5_flow_act		action;
>  	enum fs_fte_status		status;
> -	struct mlx5_fc			*counter;
>  	struct rhash_head		hash;

It looks like this was added by commit bd5251dbf156 ("net/mlx5_core:
Introduce flow steering destination of type counter") and never directly
used. The pointer appears to also be stored in the mlx5_flow_destination
which is the only place it was directly used.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	int				modify_mask;
>  };


