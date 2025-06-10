Return-Path: <netdev+bounces-196132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44816AD3A0E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA3E3A4D9E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DCD2980D0;
	Tue, 10 Jun 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SL/qastE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31648296160;
	Tue, 10 Jun 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563905; cv=fail; b=KbTylOKKRW3IH071Ji8wdoAIlLW7p6MqAuo7x/CNNoRDiH76ZuQHNINbCdo4MkxF/cSnbp7F6areGEoei0QOiRpyJX7R0hki6aI+UQt1lxaZNlvDq+gCC0nxDTAQq8dKU+eZDvBP3k2BCm57cuNUnUxyqIpELp2cmN3RLT94an0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563905; c=relaxed/simple;
	bh=w0wi+uwcasAUTqr1SxAvHC8O1wJedRxJszhlmDdvw5U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BvJxHvYR+ATFwvvY+daQNd3rLlxVMTwvti0NwJmbIVPfPVSwdFud6wdjezCy5/9RtnKJ3Elhgje9Q4bE0E11K70i0H4lWxsNP7oyDYQxlg5f+jEfI8J804+aX6WhYxu/dcOf6ozRGHfaW8UMbo5C4nCeJaetgyDjzLCJPyaGFc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SL/qastE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749563902; x=1781099902;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=w0wi+uwcasAUTqr1SxAvHC8O1wJedRxJszhlmDdvw5U=;
  b=SL/qastEc99Avxr//l39nYroup3L539vOIW2KNA+gZgEWkqGjMixWN/I
   S5CmkJRvgHTGmtmJ/V3rPM5MpcDbgfcTTF/9Svhpnq+O3IMDGhz1hUCzq
   N5R5zw6JtH0ZtQeACNv6FTz7hLEwfkXQTRmbz4jKbQY/oSZnXbbEUFlpw
   vyeZa4GpNAEVwMKMzUoxVnfyqWk5LZyIXde/aIseMGr1bN5LdI1XRFtg/
   CnlsZbDqy+kGdBJXmwLEAwz9BJL+1YqvzpsHwYGyZVSDiQszovR5bnmD4
   Rz8fu9OsN946YSKSA7FCg0i8WC+hrndSY7pNUzzaoQGUqVRPJDaScGn1y
   w==;
X-CSE-ConnectionGUID: IbZcmXdtRjyzAcIpeWTL1w==
X-CSE-MsgGUID: OQmJ7iwMSLWdUjVYUTgcpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51819828"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51819828"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:58:21 -0700
X-CSE-ConnectionGUID: yRIa/ijSRcqEbio+ic9iDg==
X-CSE-MsgGUID: W3YmGmWQRqGuG+xX4A/E/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="184025742"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:58:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 06:58:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 06:58:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 06:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kORPbkiZ3+DGVbN8VjA8S5C3FJgl3codGPRj/eGsEVEC1Nw/WmUGrXEDQqCowzD9RulPeLvLaxOtUvwu5htCeRz9BrWeVPhpdq6EVAx389RV3+bDR2+fiGmVGW/slA7PEA/frMJ18WgXwEMESkWzAhivMMUhGjLDgvfBBRbOm+iBWyGIOyRr4ZpYP2EX0OIGw4fvIHx/XCmMOPzM2pjqMJlA6CFBnfhSHCMERxF1lfgk6cw/B/wlhAq4ERoyDwlBEdTuSbYE15XtL7CHFRiphZXrl5Ig//omr/WKxq3bS3wHP6YiRF7StTOWWbfXJu8jpnYkX9zJqVKDKcxjnSz9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkaTgVCXdiDs7wh9fAkqCpLIUsWF385H8bC6ErXauFA=;
 b=FtTFDoojwwmDQOlH157It+5mAJM1NjxQFQFaNwWF03x35o7SImij2wk7T6rpigr10H0/4EPZxICY1WSlMka9nBofUIJQD3Zf6G3p1ASBqc9bTgFh31xvrxRR9WXn14PRxeaXiohP5wbo/8EWK8FcHb4VmxyO58C9XnOAnyhiuqOOuPCky9++B0cqdT8FeE/R6OWeUhs+WorAk0uRgLJ0fP1AhrYlcHtZFGRj7gZwI5ezC1rchYGlg50fnFBlKBbZ3lzSLMGphB94kTeVNTqbup0mZ523LKVYVpoUyeNWd/ZIfOClKBru9KAPEzmV+3HjA6bs4l+oLQkE4BJAAOY5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Tue, 10 Jun
 2025 13:58:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:58:03 +0000
Date: Tue, 10 Jun 2025 21:57:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [tcp]  86c2bc293b:  stress-ng.sockmany.ops_per_sec
 6.8% improvement
Message-ID: <202506102156.1d2bde14-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8299d8-5273-407a-ecf4-08dda826d154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?V3I/Gz9N0+nXyhcBFhPMeXPISv0OcXtTVAWZkD96i98qvIJlCJJgsq0rNI?=
 =?iso-8859-1?Q?tayj16J3ZIUW8b35CIw7ca1IxLb3IzC6AlyInhOjbL+FTzpysxrTdcBgL/?=
 =?iso-8859-1?Q?yW0wHFq4rnXr1EeOz86aAO8Mlv772Jmc7uPZlGF4Ekzswkley3OBcd8Kxw?=
 =?iso-8859-1?Q?A0pcws41PzaTuIYWREU310Q80bb3UYIuRApcdBy+f1nPaRhJIGIPHSjl9L?=
 =?iso-8859-1?Q?XT1IQ0MPF/H8xOVz3sFEzT+RNb77dvD+GL2M9UWYOznV4jGFNFe2RERt8S?=
 =?iso-8859-1?Q?pBVevv6NIoHLkI9mUXzNA7dKs3tEh6g0zfUI+IWDAHfWnb6mQZpOu5Wjub?=
 =?iso-8859-1?Q?G2TPr1EdnpoW8m4+aFHr+N4Anr9j8Hkr2wUKCL4yJ9SKwnisvvX5+F8haF?=
 =?iso-8859-1?Q?av5p0Lje821VaqezDAE94FnBb40O4cKGRqWmKZJ8plBvXkLNWoGu6T3vCF?=
 =?iso-8859-1?Q?kRoUlnTB3YwB6n6MtzIX3oSC8VBpGqVCJgVXBZJmBaW6EgNIqft4qssbyv?=
 =?iso-8859-1?Q?5OO4FqrPQi4WJVxp+KTZJOYBue6mjS//48YJkCbMXy7vnIUZUmyu+DFpIg?=
 =?iso-8859-1?Q?x4sh+kWoNTBRvOQhAgI1b6bzKdzkbE+JOCk+RhJetDGT4rFSLdQ1821cUM?=
 =?iso-8859-1?Q?aLY784EdBHIuHVJXrXPa4imrl99ZPZ3CRD7AOemV5QIU8VI/Tx7zymYAXG?=
 =?iso-8859-1?Q?+L46AxEluGZMFvsA/BpfayoKFF0+YJjpa8r/hmcJ0l0FD0l5p9t/BO/GMe?=
 =?iso-8859-1?Q?00Dgv7+ZDZlAHhr9skaLV2YyASeKhEcfK31Ih7cFz9wticKG7vNwbbOask?=
 =?iso-8859-1?Q?y6E9KqqGSv+amq/PEA9QkMnSe5LiBxiGTx5cKK/YaWMbAEre0m+YbXRuKE?=
 =?iso-8859-1?Q?s272lyGKzLLeBl1bc8hSDqslrzPsGMi+SZQnm1/2qZlXkMA/dOesWJs0GN?=
 =?iso-8859-1?Q?p7A/pibPW5lLGBxlklB5ZGMuBc2W5BjuAe43SDqclvnDY6chG8LHe1w1FE?=
 =?iso-8859-1?Q?Xu6GwA7i6pCMBmWnLE3x3VAyaDL9JUD8PJUkG8K2etAm7df4QjkSw8NQGh?=
 =?iso-8859-1?Q?uWZHVyErl923hmTZoX1pB3HyU9Xd01hHvN8nrm9eCjPf4K7uzHbbuTjS1g?=
 =?iso-8859-1?Q?Iv5BWn8VLWJjfLVe5r569C22OjNm4P/Z6cz8DBpaaj8bpnNpzyrGWQEw9A?=
 =?iso-8859-1?Q?sXiXNY3pBprzOqeOzWueS1Sda9scmn86qsvRMlUC7hLJGvUsWj3l1TiyCA?=
 =?iso-8859-1?Q?hqCskEAzqP6TwfsHLy75KC37sJN5IY3mu08PohBFmOs54c8w6w7yc9Hdm1?=
 =?iso-8859-1?Q?tbgbuzUWggEvgV7vIt07wriE3qrwAPWtL8E7tCPakMy7+w8GfBuvEGYffN?=
 =?iso-8859-1?Q?fap3L+AMPN+alvMPr0hzKOFKf1pnSXL+SyfyCp5uMoMWdzMcMDiol2G8cX?=
 =?iso-8859-1?Q?AMHLTCn8wgp+VY4F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?j/yFSq35sQCTmsPp9I8oo5IAtYtuvDRz02juZ4CKUoJIpq0wiLqus99ONq?=
 =?iso-8859-1?Q?SWwCyDvP92prKqToiJxuGEsd+D9MuF7byDRJ5nYdEFuCQ6IoHQomWKovmj?=
 =?iso-8859-1?Q?GQn5C6jlUMP6MFMnGB2wOiyj8H778tuDyDvcBg7roInyYIzZ5lZ79MfMPm?=
 =?iso-8859-1?Q?jsDfNyHGpkhdN5KCFXXDXP9KOJ9uQ0dslQdXCvVyo7BabFbb6UzBFd9hVk?=
 =?iso-8859-1?Q?UyWRxTcsHR7obFryWjF4fEvYj2DvQcbvZbo/ROg/fOYOQ7jAeoXFLOHrbP?=
 =?iso-8859-1?Q?cMv0vc16WgwBs53XW+JUaODCpO4UJtaliImhBc7iTwIIgQEv+lUuBagNbP?=
 =?iso-8859-1?Q?sk4dDhdwtGLGWYh8HpWPCe8gIMuptCZGCAwjsN1t3kNXR1okfd7HHwIhvA?=
 =?iso-8859-1?Q?hk7TdJ4f/IQj6Do+gfh1Gd5WTYF+VrW420qqGX9+/OwZsQ6LepqfLMCQSU?=
 =?iso-8859-1?Q?RUENyQP5IsVPjak46O8MoSIPIYdMVhI2IWWqxEYu8UwFeTcAlPkyCd3NEh?=
 =?iso-8859-1?Q?1X1mpWzdGzVhecZ9pw4xJG6eWC/dLCQ2WJyPsN8bjTVzQ34QSMkhSUoxOE?=
 =?iso-8859-1?Q?yz+KFFoQj1h2uUEUEYlXI9Y42FrnUi84g8zCl6UPnwn5Nyq9Nh7pdcqFlV?=
 =?iso-8859-1?Q?rVVTzxJilDCEevZT5yk3urRiNILvENX/ATGohM1m/wWmoXB2YFBX75T0tU?=
 =?iso-8859-1?Q?S/pg/ue/r/D/6PbnAfpFB1QPsMWqtIq6Uxm2byEFZX6zSOUASfRvgHG4LF?=
 =?iso-8859-1?Q?FVSfa0T0ch3C1zJysKdzVo3lD1x5jEw/5SvVrfnyz9E4qeihWWONhoB+mZ?=
 =?iso-8859-1?Q?NWXY6M/YcOhloQgJNR7OIqgUcRB5+/hH+yNdEGRFpJZE8eJGv+jvi9YvKh?=
 =?iso-8859-1?Q?QgEHTVtYcFnCVhRk8+v9zKml4pqd3jbE9JoPZN/X9Sy9eKfXViXbKe5zZm?=
 =?iso-8859-1?Q?JSGQX8iOfymUVqct1hzwOiww29LBlQ2O7Kw8aV6kdynkDwTit+BsxmUg9q?=
 =?iso-8859-1?Q?eJ8tjarzjTbcH/jE7SIQ0pP8XmUqcSzf4++erfWLheCaxRWQQdIBb9lib6?=
 =?iso-8859-1?Q?i/Styx/LTznVr4ZHbCp5JLlVh7Dfaw6NefLSSsFjY+n7ri62GWZU0jX7cy?=
 =?iso-8859-1?Q?ZXGNlS9JQ0oErC0iRyHtHjhV1bOVYm9ydzBq52N/esRPRQlQ3iFsXjCjuY?=
 =?iso-8859-1?Q?bCbNbJy2B+EQsSu9fdu8oY2v2fOJ7Ij21uoDho6NmsrqyeATQDZequKfJM?=
 =?iso-8859-1?Q?oHmPM9hBPHGICdny2RfebbvaVeApdMNrfoYtnAxfOPvDhoEYAUZejxVTyV?=
 =?iso-8859-1?Q?VV5N2MCeajhFJGzvab5NDUMyUBZIJ0/6iJhdAOv3UlEWw5h53uVMPWyThd?=
 =?iso-8859-1?Q?n+6Esa5ziottYCWRyg5wp5q0gSHVW+uwixpYVGTTMN1S2ujsqkXIRWQSAz?=
 =?iso-8859-1?Q?mCh6A21nPmwAoFCRcpVP/FGk7JCpRj9D6hqTCHP6v4aM1Cbp3j8P5MYcjP?=
 =?iso-8859-1?Q?zlPH4Xt70O3WdeuLbDhVBL+/l4ngqe8mxiJgo5HbNzp65SzWIKTUMOYNSu?=
 =?iso-8859-1?Q?j79oSVNymQhFkd/aeFHoZ6gOUlUasio3a4q5nOmlb61IQ4+WJT9Jabv+BS?=
 =?iso-8859-1?Q?RQZOSxXzzAeDQrM1A76QVoUK0bmV/jdNEomBqzUSjeBDX4YJgxE5ysrw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8299d8-5273-407a-ecf4-08dda826d154
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:58:03.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onByYbaA1W1zgtnAvm21am0Moy3YrFU+1Gz6pV+vbm7VzXSUWFqj6prNTdg5VWNz1MigVxlAfSzyTyWKQwz3Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.8% improvement of stress-ng.sockmany.ops_per_sec on:


commit: 86c2bc293b8130aec9fa504e953531a84a6eb9a6 ("tcp: use RCU lookup in __inet_hash_connect()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


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
https://download.01.org/0day-ci/archive/20250610/202506102156.1d2bde14-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockmany/stress-ng/60s

commit: 
  d186f405fd ("tcp: add RCU management to inet_bind_bucket")
  86c2bc293b ("tcp: use RCU lookup in __inet_hash_connect()")

d186f405fdf4229d 86c2bc293b8130aec9fa504e953 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.62 ±  3%      +0.1        0.69 ±  2%  mpstat.cpu.all.irq%
    521879            -1.5%     514052        vmstat.system.in
   4059292            +6.8%    4335271        stress-ng.sockmany.ops
     67315            +6.8%      71863        stress-ng.sockmany.ops_per_sec
    903062            +4.0%     939576        proc-vmstat.nr_slab_reclaimable
   5715333            +5.7%    6043532        proc-vmstat.pgfree
     30955 ±  4%      -5.6%      29223 ±  3%  proc-vmstat.pgreuse
    617802           +12.5%     694736 ±  2%  perf-c2c.DRAM.local
     43535 ±  2%     -55.2%      19524 ±  2%  perf-c2c.HITM.local
     13760 ±  4%     -94.7%     726.83 ±  9%  perf-c2c.HITM.remote
     57296 ±  3%     -64.7%      20251 ±  2%  perf-c2c.HITM.total
   4862651 ± 23%     +26.2%    6137833 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.24 ±  6%     +23.8%       0.30 ±  5%  sched_debug.cfs_rq:/.h_nr_queued.stddev
   4862651 ± 23%     +26.2%    6137833 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
      0.24 ±  6%     +23.3%       0.30 ±  6%  sched_debug.cpu.nr_running.stddev
     40590 ±  3%     +18.8%      48233 ± 17%  sched_debug.cpu.nr_switches.max
      0.63 ± 12%     +20.6%       0.76 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.32 ± 10%     -41.2%       0.19 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.19 ±195%    +772.8%       1.62 ± 82%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.30 ± 31%     +51.8%       3.49 ± 12%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     20.10           -23.3%      15.41        perf-sched.total_wait_and_delay.average.ms
    177307           +32.5%     234941        perf-sched.total_wait_and_delay.count.ms
     20.04           -23.4%      15.36        perf-sched.total_wait_time.average.ms
    125.96 ±110%     -73.3%      33.69 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     13.68           -25.7%      10.16        perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.65 ± 10%     -41.0%       0.38 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     79042           +32.2%     104463        perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     81037           +34.4%     108937        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      1965 ±  9%    +125.3%       4427 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      2427 ±  3%     +12.5%       2729 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.36 ±  2%     -25.0%      10.02        perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
     13.66           -25.7%      10.15        perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.33 ± 10%     -40.8%       0.19 ± 18%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     35.56           +15.4%      41.03        perf-stat.i.MPKI
 1.386e+10            +3.1%  1.428e+10        perf-stat.i.branch-instructions
      2.15            +0.1        2.26        perf-stat.i.branch-miss-rate%
 2.923e+08            +8.8%  3.182e+08        perf-stat.i.branch-misses
     71.48            +5.8       77.26        perf-stat.i.cache-miss-rate%
 2.391e+09           +24.9%  2.985e+09        perf-stat.i.cache-misses
 3.296e+09           +15.3%  3.802e+09        perf-stat.i.cache-references
      9.36            -7.4%       8.66        perf-stat.i.cpi
    291.67           -17.3%     241.22        perf-stat.i.cycles-between-cache-misses
 7.053e+10            +8.2%  7.631e+10        perf-stat.i.instructions
      0.12            +7.1%       0.13        perf-stat.i.ipc
     34.03           +14.9%      39.11        perf-stat.overall.MPKI
      2.11            +0.1        2.23        perf-stat.overall.branch-miss-rate%
     72.58            +5.9       78.51        perf-stat.overall.cache-miss-rate%
      9.04            -7.8%       8.34        perf-stat.overall.cpi
    265.78           -19.8%     213.18        perf-stat.overall.cycles-between-cache-misses
      0.11            +8.5%       0.12        perf-stat.overall.ipc
 1.359e+10            +3.4%  1.405e+10        perf-stat.ps.branch-instructions
 2.863e+08            +9.3%  3.129e+08        perf-stat.ps.branch-misses
 2.353e+09           +24.7%  2.935e+09        perf-stat.ps.cache-misses
 3.242e+09           +15.3%  3.739e+09        perf-stat.ps.cache-references
 6.915e+10            +8.5%  7.506e+10        perf-stat.ps.instructions
 4.246e+12            +8.2%  4.596e+12        perf-stat.total.instructions
     66.41 ± 70%     -49.8       16.57 ±223%  perf-profile.calltrace.cycles-pp.stress_sockmany
     66.32 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.stress_sockmany
     66.32 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.connect.stress_sockmany
     66.32 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.connect.stress_sockmany
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.stress_sockmany
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     66.25 ± 70%     -49.7       16.52 ±223%  perf-profile.calltrace.cycles-pp.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
     66.09 ± 70%     -49.6       16.48 ±223%  perf-profile.calltrace.cycles-pp.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
     54.17 ± 70%     -38.3       15.86 ±223%  perf-profile.calltrace.cycles-pp.__inet_check_established.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
     10.32 ± 70%     -10.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      4.67 ± 70%      -4.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_bh.__inet_hash_connect.tcp_v4_connect.__inet_stream_connect
     66.53 ± 70%     -49.9       16.60 ±223%  perf-profile.children.cycles-pp.do_syscall_64
     66.53 ± 70%     -49.9       16.60 ±223%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     66.41 ± 70%     -49.8       16.57 ±223%  perf-profile.children.cycles-pp.stress_sockmany
     66.33 ± 70%     -49.8       16.54 ±223%  perf-profile.children.cycles-pp.connect
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.children.cycles-pp.__inet_stream_connect
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.children.cycles-pp.__sys_connect
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.children.cycles-pp.__x64_sys_connect
     66.31 ± 70%     -49.8       16.54 ±223%  perf-profile.children.cycles-pp.inet_stream_connect
     66.25 ± 70%     -49.7       16.52 ±223%  perf-profile.children.cycles-pp.tcp_v4_connect
     66.21 ± 70%     -49.7       16.50 ±223%  perf-profile.children.cycles-pp.__inet_hash_connect
     54.25 ± 70%     -38.4       15.89 ±223%  perf-profile.children.cycles-pp.__inet_check_established
     10.37 ± 70%     -10.4        0.00        perf-profile.children.cycles-pp._raw_spin_lock_bh
      4.67 ± 70%      -4.7        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     53.42 ± 70%     -37.8       15.58 ±223%  perf-profile.self.cycles-pp.__inet_check_established
      5.65 ± 70%      -5.6        0.00        perf-profile.self.cycles-pp._raw_spin_lock_bh
      4.62 ± 70%      -4.6        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


