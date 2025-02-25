Return-Path: <netdev+bounces-169408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CCA43BE4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E133A3063
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17226389C;
	Tue, 25 Feb 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f28kficq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B13260A3D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479735; cv=fail; b=R6C98YFfz6OGuYt2bZH+3dtoDh0Kz7McnzWoRQWR7u0C/w2+TZTa8KPrvfwJ3Z3CB3IMnqi/VboQHRhK5kTBdexqi7lmLcHkjWqln5NKDmlCJ+RNHl1f8JKXOb58Eh3aOsf2YVyKGCV5CkuW+ZR+KDKTH1egWqX51neUW0AvfYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479735; c=relaxed/simple;
	bh=pz3kS0zk8wRFBOmv7uv8aYHCDAQ0WGDYbR2oOR8Q5Fk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwhCzXm9jMMgzv+I9buZ5RxQ2drxmQwtkFHf8w3d8fiZiYxEd/y/lu1h9JeGGojzxwAtNvB7g44h/Iu8xt8CsXnCM0ISGd/XkU6cFZAKkYYTA8Qiy1AlRArNC21N2KFu+TD0fXoYwnz77i4aTkOO4uJ8ADh850WAJwu93D4xwRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f28kficq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740479734; x=1772015734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pz3kS0zk8wRFBOmv7uv8aYHCDAQ0WGDYbR2oOR8Q5Fk=;
  b=f28kficqI4nfU4et+P0iDWnw1V9nZPsYoyYT7I85c68Yl2PGKzy/YsDf
   DFphXDciKfMqBNgL9vm4bKCxmJwU1oPh2Wf8zYpnYd+qxKnhx3JIQYlh0
   1PtBHPBvpkCJygnDjuCC6NTZr80/r7rhgnxfQWSQ/yzxPkSL7yevRBy21
   fy3YjUBj8ziIEcYodFr+fcKmuO36H44giZCpgce7DQz/34Fw0XmWOO+/Z
   qpZj95sIO4ERuOz0gfIUgo4jeB/4YtY3gBd6CI/LlvMvwvtFNWqiX4M3W
   2+mdJQAHKIcFV4UA+AzFMFZqGqcOkleTLazNXEscrhd9mZuSyoECxzIex
   g==;
X-CSE-ConnectionGUID: pdk7ttLnSNCoiFNpitGEtg==
X-CSE-MsgGUID: c7+7qC2RQsKB4wlaq0q3Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="28869294"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="28869294"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:35:33 -0800
X-CSE-ConnectionGUID: vkWQsMpdQWq4f56I+E9scg==
X-CSE-MsgGUID: u02VN0qLQ6+uxCSrx3H3Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147237167"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 02:35:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 02:35:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 02:35:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 02:35:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzyyAvzNvorz9eE5JPRnsG5f/Ef60dsnQMbYIJlTBXsLGV3glLvOZOGMI66+YKbkt2aj/ux7NCthKki242ln0B9IXRJmWnq8ayttNgdfQ80nilBTJKx9ti1p9U2ZAVJ7mMZAf0mQaoz4wf/51uiMjCzJ/kMemmxNMXYx2Lh4RT+VeUrUdRlontNpHhpa1dA2mcX/aXrIAo1dx+zTyvKYASmRFustH5HYuSlEcG9iLsGYGJ1/qxgPKiUdwZ7qCgSXU/RE/bZU6efrL4i4w5LqKb06FJvb8uqglTNoAxmP2RHx9SD3KsR3gQMu5tnycnyaH52EtY88e9hTzYrq/+V7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l9tXOixGHMqxiPW5bAVrdpEVxItXjLDifFZouMWQXM=;
 b=f/HP9iE0U+XDv8yhDomaXjqV0jUSWkY1eCzPOH1d4Y5vBP4/xK44jEbzXd7St1Yk0qiDNkHZlfzGoFJItXdDfJkYfRewRLf/ivdkoPwwFWibpqcevEuTjdhNcJ/NfPCicskIUekBe1LBepQ4yCFz7kCD04csyHVP+GvxET2wg/6sVInQyLSgl2hC4/FtW2+xHIzL7k5RlsmxtHhGPX3/yjUF4BzdUSKQeWyatNkCK3ec/AcUymjwYJ0Xzw+MB8VSDgpsbuZ9w+lLwrpT1xEwb7HzQxjH70JNTbmAJo0Ych/uKF7eTH1Se9pTD2jdMSA3C2OI/+MVoO9ZebUVc1J48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:34:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 10:34:43 +0000
Message-ID: <47b210a5-ece8-4f06-9e9f-223f604b881a@intel.com>
Date: Tue, 25 Feb 2025 11:34:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-net v2 5/5] ice: fix using untrusted value
 of pkt_len in ice_vc_fdir_parse_raw()
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
CC: <netdev@vger.kernel.org>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0232.eurprd08.prod.outlook.com
 (2603:10a6:802:15::41) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: e7df48c7-1985-490d-4299-08dd558803fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVVoRHdPR1JtN05CWVhNRG1yd2xmM2lRbUhnVjJqUEd6Z2JEN3FJMlpydFRx?=
 =?utf-8?B?N0NLdkdMYkRIeU84NWF6dkMwSVJVNFJLbEdlZndjQmRtK2dlVDlxazFEdExv?=
 =?utf-8?B?YmwxZU1GQXdsTWcrOXVnb1d0ckpmKzJzbEFJMTNXTnNFT1lvOFhZUWpRNENX?=
 =?utf-8?B?d0xRUjVZSWlQNGV6T1lvdFl1TWNrblJiQ2ZkS1ZFWHlwSEdHak1jNkV1UEQ1?=
 =?utf-8?B?cnR2UXZkUXd1dno2UVJ5NHNTSlZVeVE4c0dnZ1ZjdHRXRFJFMFdJR01oWTlq?=
 =?utf-8?B?RlRyRlVvSTBJUUJ6UGVSc21ENTJhUDVZekVlYm1XbVBHVVQ5dnZKSkhBWlFu?=
 =?utf-8?B?QmhFeVMxYnhUaXZ4cnJXWUIrUHNoczYzZ2hFK1ppaFNPc2hDdEdyenlUdnFF?=
 =?utf-8?B?YnY3THNqdEcyQUg2V0NjN1lnU1p0WE10NXIvSDN3WWRXcGNvNXhDOHRMYmMy?=
 =?utf-8?B?aGNCREJBcjROc0tHY2Z5Z3l0bnpQbXI0cnZHd0V3RWFtU2RLeld0aXdHeHdu?=
 =?utf-8?B?MWJmaG9hSVI3VGxlWWhDdWJSUVNNbi9xZDZuOWRqNDNMdlFMRjZTUklDQ0Fp?=
 =?utf-8?B?ckZHM25nMUtYQlFDQTN0MjF2eVNlajI4UWtkaWZkS2hxZEI1dG05emZsR3BQ?=
 =?utf-8?B?bFpUNFhYWTBLaGt3dEN2cXhKMTMxRHdaWEI4YlNrbjMyd0xrZzI4dlVxamxv?=
 =?utf-8?B?OFBQSjhrTGl1Rkt0WUdUdmJPZ3BXTFVsNlpHaDhFVnUrakNMMnBrQUxJRitO?=
 =?utf-8?B?NVloWHcxNDViY0FNWTN2NGY4eUZTaUNjdGpEMEc1SDV4WHB5OC9IN1NKcm1G?=
 =?utf-8?B?LytkVUtwQWdsQnFyWXEvTFNqRzBPRU0rekFWM2U0VHpwR0JrcnI0ZFB6UHFq?=
 =?utf-8?B?bEtCbHp4eGc3R242L3VQWVlubktTSWdqa1ozU3ZWcThublRTSnRBY1lmTzY5?=
 =?utf-8?B?TFFhSTVmazdCRUpXRms5em9MdUdjSitqTWdlT2hMd2dvcVpRWGRMYjVGK1o4?=
 =?utf-8?B?MUQwd2FJS3c5SXA1aWZ1VVYwUFhNQlk4YytlZjlEZlJNekY1NGdycnNranlj?=
 =?utf-8?B?T0paTEc0T0cxRXI5aStWWGpqb0tGR0cvRyt5OHkyMHNjSnBpU09CMGtLTlZp?=
 =?utf-8?B?VVFTTjEzeVBzK0F2cENYUlhjWDZRN3lMTHpWdXZJbEVSUGJCUE40TFZiOGw5?=
 =?utf-8?B?c25IRmFXR1hscGgwNkxUTitqZWFucmVrTk5aWUZBSCs0U1BHMEpXeS9RRnNT?=
 =?utf-8?B?UHZDTGFDRmp3bGU1ZUJXUk9SMzJGY1IxUFlZUFhkL2MvM0wxa3A1U2hTbzlP?=
 =?utf-8?B?QXdlaDBQWnUyaTM5bjUvK1dlUERXckVERHlwSlBDbzFJMjNtbmJ3c0FmVXV3?=
 =?utf-8?B?a014RDNyN1hMWEhKand0NWtUZFhCaTFhOHpESjdPb0pMVGU4T3F3QTFkTXFs?=
 =?utf-8?B?dUJsYjRXVWRmanRaTnJzWE9kNi8vakxsRHBHS1dMV0NBbTJMdXFIUm43alZ3?=
 =?utf-8?B?eFdLdE0vSnFTcVFzNFcva2hlWnhlSGlDaHA5d2JsNVg0bEJORGdPYWhLVlRl?=
 =?utf-8?B?SVIwL1g0OHVsUXNUMmMwSnUrUHpMUWVvaDlrWU5YUkEwZlhuOHZMeDRPVXZz?=
 =?utf-8?B?OUdsQThqeEExTkFtS0hRRWQwMlBBSTlWbnpLUGY3TzVwdmYrK0pmZ2dCZWVq?=
 =?utf-8?B?MlZ6bDZRR09sQjZ1MCtqaGI5Zk5CWmV5andxd1dkajhUTzNNV05wL3Fsa3VZ?=
 =?utf-8?B?aVRSVnhHQWtySGVVUktYU2E2bmZXM3dpcHNTRmMzOXNPWDZMYkMrclFnMmVr?=
 =?utf-8?B?SGQyTVQycElXRHBiTHpCZXE2OGRDYng4NlIxTk02NXcxc05sT3psMWY3d0JH?=
 =?utf-8?Q?jbkM1FiDhmBiS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNYZnpoaGRhcDVQMGVuVkwvMWRiUUQ0YXBkL3lrcUxIb1kxcTh5THVnSlYy?=
 =?utf-8?B?dE9TcFNmUVJCY0VyeGdwdW5xakZURWZLRUlNZW5uM3BEWFQrN0laV0UvV3V4?=
 =?utf-8?B?WHRBWTJhOWdsV2lncWdtdjdlajBJQlFHWTVMMCtCTmVmWXF6WHNmYVdUWkw1?=
 =?utf-8?B?TnZoNFlzRkF2WGFqNGVBbFBlYmIxb1krM3gvVHh2QlE0UzcxWVdxME52bTNr?=
 =?utf-8?B?eGR0NU5QUEZISWV3dzhKc3VQN3ZsSExyUS9tNkhtS25DVVV4UXhQeFlQZGtq?=
 =?utf-8?B?VkpWMHROcW44SUgzZ0llMnBkRlhDTThhUXlnb3piZHFCRjNVZk5XQTdxU1dO?=
 =?utf-8?B?U0w0T2tsUnJvRXhvbFpwVGQxSUhCTWo0em5DQVQ4eHkwMXpsN2c0V2NaR3dp?=
 =?utf-8?B?U0NELzZZQ3dRQklFeVY0eWkvTXpPVVJ5eER6azdtcGs1cU5tUEpnNkt0cTBo?=
 =?utf-8?B?YkRNYXlwcFNtQSt3VmhVTHRhUHhSRHNYZ05nMzF0dGE0YkFvNHVwWFU0MDVw?=
 =?utf-8?B?aWd4eDErTVhkQmxQOXg2aUM0QmJZMzBDem0vT2tMZzZ1UTdLV2Izbll0d3Fi?=
 =?utf-8?B?Vitmd2JHWjVDWWh4RUFOMDVlOFpUMnFHQUMxcndSR0lvTFR3WWp3NFQrZUU1?=
 =?utf-8?B?YnJXOGp5aXNaNUNkL1hRcm1NbVArQmxobXhhSkd6WkswN0huTytVWW5iSW4r?=
 =?utf-8?B?Z1JmZ2tUWTNpYXFieFduMjBSMGh5LzNrSHNnMkwxYUx5UCsyL3pTajEvSFl1?=
 =?utf-8?B?WkVJdjE5OE5qaTFzN0N5WCtrTG9LbjVzU1VKVlBEdE9Nb1FqejRlR2s2UEVF?=
 =?utf-8?B?dGR6dFdZbjRUR0pYUE43NGQ2VW1mbG43eVNacGZyWklObWFLanJHWi8vVmpa?=
 =?utf-8?B?RGluM1pQd3NmbUozem9PdUwyUVZ0TzVKelhnUFNQMlB2aC9IOU9FSnZVN0FN?=
 =?utf-8?B?a285SmRTZ0FLT2NWMnA4NTUzTXh3UUw4RFgzN3lhaFZadFpTK24wcDVMRWkv?=
 =?utf-8?B?UDBpZEYxeGRLVGEwdmtyTGhzZk9INUJZNlo4RkpnZjBLaGt3WVExR1ord3Jz?=
 =?utf-8?B?cXEvckVLbHo4SXpKMjFSeENETHVuLzQ5WHFtNDJyT2NoQS9HaVVvbzEvNXIr?=
 =?utf-8?B?VnJTSWE3Nm93S2xuc243azhuVnNOUzRwT3BFbTJ1d0k1TXdWa3Y2RkJzUG8w?=
 =?utf-8?B?MWt4UGVQME81NE5Db2IrZ0xkVUJqWU5YWkdKRDE0SXRQU2Q5WnhLTTRUdzZn?=
 =?utf-8?B?YUpFZVZrTXBoeXVvM3dEdzhoaEpMd01rcFU3OHA1ZXBZUkJaUkpnV3JhUVA3?=
 =?utf-8?B?WlZkQW16S1BHUXQyaGtyWlNLRlp1azBuejBpRGJpUXJuRmtBY0F0VXQ0QzJn?=
 =?utf-8?B?SkdCRjFld3g3NFhsMnhTZ1h2Zk5IU0ZuMkdRQ2MweTUwUnNUMjBsWHc3aldh?=
 =?utf-8?B?YUpwSHNHUE5xSXNvN0NMWElQUzRGdVhXdlRyL3hyTEtyYzZKR29rQnFrc0x4?=
 =?utf-8?B?Q3g0RkIvUVRRVnBkSlJWSnZKeVdnb045RFg2ZFg2dnhBeE1sSm1lQnpDdVlx?=
 =?utf-8?B?QkZYWEZDQzQ0UVZNQys0SHFKYW4wVE5wL3hhK09MYm1FTU1uS2lyZzhxYnRJ?=
 =?utf-8?B?dVF4YktBYndrSVFEZDVhZ1ZrMERvNForZ2h6dGZXQjNUUWRUSVQyRlVCM1RH?=
 =?utf-8?B?S1pxNVBLdUFrdGVMcnE2NTFnTzlWSGdzdU54QWl0U2VkVzVCeXRCNEVCdWZt?=
 =?utf-8?B?aTU2WTNJYlFQb3F0bUxaZnV3YldSL1BxYzVRWUM5TmVCTDN0S2JDNllTbTNk?=
 =?utf-8?B?WnQ5TUdmSi9xd1RZTkJlMnppWFovbnBNOE9Pa052ZUNrMGJtNWRoRFMxa0hh?=
 =?utf-8?B?VGxvNzkvdktGVXpuaGZlbXVqTWNvVXM3SWcydXlicmNnVUJ6emliK0FsSjN1?=
 =?utf-8?B?dXpsSWVIaTNMSE9HeUFMb0lKZnNUZXJFc2ZVK0l1UkpwKzNmQzVoNXVZRlQ3?=
 =?utf-8?B?b2JLQ2w0WmRHbHRWc1ZOQktQSllrcXlEbHlzMVpwNUVZbkF3akI0bmZ6WnpO?=
 =?utf-8?B?alZGQWNoTUNSV1R6eGZTYmh4ZTFyYmtFM3Y5OWk4S1E1TCtTcWM5SmZvSkxS?=
 =?utf-8?B?ZktiRnI5K2pSYVlINXJ2L0RIeWNqV2ZhVVEySHc5OHlnYmtpblNKNi9lbTFD?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7df48c7-1985-490d-4299-08dd558803fa
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:34:42.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EE3ZKKe0Z8fJFVxXqpvCBM2Eqh3CUFYFpk5QPctP44vTPkgc5mKnk94/S3wpCIc8mXYDKq0HyOg7516b/T/hHw5fQtqdso3zJYvHjoLOrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com

On 2/25/25 10:08, Martyna Szapar-Mudlaw wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Fix using the untrusted value of proto->raw.pkt_len in function
> ice_vc_fdir_parse_raw() by verifying if it does not exceed the
> VIRTCHNL_MAX_SIZE_RAW_PACKET value.
> 
> Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> ---
>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 +++++++++++++------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

