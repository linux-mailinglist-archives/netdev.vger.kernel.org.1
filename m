Return-Path: <netdev+bounces-160143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E9A187D2
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7922C188A5E1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97481F8AC5;
	Tue, 21 Jan 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaBLzj6u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9C1F4E37;
	Tue, 21 Jan 2025 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499332; cv=fail; b=alwGELAZKbyNPf4p0lgSrZxZtO/vLls0+uh/VjQNJ9erh1Txb+sGH6fyETje7RANeCasfDafJ3MWP5BTvWEMTf29zRlDU/UPhu6eaXoNm8DVO55oIPJDXaKzKqkHlruwsCQZuiWnrLhNI6+YyGsae53AdD7Vdg2loyZkF6pgQog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499332; c=relaxed/simple;
	bh=08Dqj1Of/pCTFl/1D+Xa9ZuBGfUhZpOk1L3j6hM1eJk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZRtDbvnTvDwZ0/lyr5yAo/FLsg3rAMmP9a4Q5xGtwC4PTZBAWOrjiJ/eqqL/3oWRk+BuYcFzGxpfH+t2BIl6VQYTWJB2QdGZACpYgAzHzzb3UrNqDVIEVIypQCKTNFLHIDXZwERs0mXcMkxzLTK5qU1fcQWyCHyDwYP3spPrCgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaBLzj6u; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737499331; x=1769035331;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=08Dqj1Of/pCTFl/1D+Xa9ZuBGfUhZpOk1L3j6hM1eJk=;
  b=AaBLzj6uWAFUJQTdHcNirL7OW6pob2JaeFiUvkmYE2A/7rhO2PRZCZfW
   krXoobSKUJyKOxeFyAl04JPN64nwQBFJkCYN4KLCVH5KF0rZjeIOmDHmf
   0tYorDxZ4AkO9YzF7INHBiTJ1nCu/Svjk7dGLWOFRWylpM+Xk0ZrqVSMG
   3ARzpGA4tHIYqzY3FYqd062/cd7G99N1YXSnSrY6ZJMfykHd5yqvWp801
   HNvzcWyo44xRDLoYqt0eDSRXfrpBSCZ/KQ8ryPfz3MfSqbww/NccvewlJ
   1k8fKDdS7UJg7UAiQo2sBkQQjvrVfxYcJizoul/NWp3JKUqkO5NvWMlUF
   w==;
X-CSE-ConnectionGUID: h3OAx0o3S/KVt1Mau+Ho7w==
X-CSE-MsgGUID: 23AMFm5aQgOAdO56Wc+W/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41695205"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="41695205"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 14:42:10 -0800
X-CSE-ConnectionGUID: tmyoM+aKR26FEVuowTtDzA==
X-CSE-MsgGUID: TpJNpEBrTNKHUqCjuf4Uqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110972140"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 14:42:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 14:42:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 14:42:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 14:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d99LXY6KT7qFihdSV+mNQL4+zRmxznKGNFmPRY/rJk5qKPtW2aUgMhQEZu87XFIzMd0uiEERIr+gPuyIGTYaGykiLJtePwW93nbs/u/UMHnURlwUHvxoCpWCV/Fi13ZdX/gBtVl+EjkJsjcEp5NPmuClkiZIqalpWgccmKZ9KDeVJv63Oy4bVBPrs7W1fjz294RVlQidsshAuNU4+i7zgfbLwhbU8vbcDaJ1tYLY9T+2XQ+TDf0fJxOWIv+U9kdlJ9tgUScBspcUBvxzzHGRhU/iC+vITdR0epV+A/F+KxenRG0otPCYCDOcw19moVYaPutnFis2QRXvN2pP2+5gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTosVVC77e9Zf4b8WVkN8x7xfhjT8H5a29etQEMkv/w=;
 b=d8Jz8ieBCCVRDNAJ46BNhMrJVWY9oZqwjeCB/yc9IQPZuS79tod6StUp6Dyd4uhPoFHmA+xXkP81azPW0JLo9zNre5EkjO/2/cC3zOLkaim1WVQME1cojMwAr15ue6gz72yod9LWcTdXHzkawMa4+x6WepIUHWLTgZCOXdNSopX3+ZiBv9w3YXLkGousDYPxwm4A/jJDoH9nFBalX2hoJ2ufEzkXCY/ztjJM6CZju5B/UnO4j3iYi3HjXLGtz42BwjER3V3N897YgcA1LrEuZIpbH5uFRjSxE3QAgJu+C2+FTxO504HpTcgDrGiQ6zph0bDxFNzZVj+dYMQlT4zwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 22:42:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 22:42:06 +0000
Date: Tue, 21 Jan 2025 14:42:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 04/27] cxl/pci: add check for validating capabilities
Message-ID: <679022bb8a962_20fa2949f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-5-alejandro.lucero-palau@amd.com>
 <678b06a26cddc_20fa29492@dwillia2-xfh.jf.intel.com.notmuch>
 <5bbc2504-6dc0-6d2b-eedc-06b4aafc43ca@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bbc2504-6dc0-6d2b-eedc-06b4aafc43ca@amd.com>
X-ClientProxiedBy: MW4PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:303:6a::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d334a02-51ff-47c6-af39-08dd3a6cd4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dyhkEeZBfgDeldFeflFnnzqXoo+XQQXztcl6DjQAhEtCkygldQQ1ZMzH+l?=
 =?iso-8859-1?Q?sl856vnYoH5kJxkZ4V8fWpMWAfrnUjuhOczC6iPyi6P6XKPsnsv3GLCt+i?=
 =?iso-8859-1?Q?k2Gynx8KCEs2p+q59M+SXwbumDTs+kVnSTXyLACtkBQXmO+oIrpv96VpC5?=
 =?iso-8859-1?Q?Csoow+IGVVCIpTdJg96ZIYLgOHvYbVMgx9//ONrCBvD9wdIW0Gq7ynVWzc?=
 =?iso-8859-1?Q?+R5qBmIok33VDV2MLWnFZRjg1+Y1ymVj73WN9DhBVdtMqxkwc0b6ihdIH1?=
 =?iso-8859-1?Q?4H1FSUSWB78ThZcuO7lrFzYr8pXwUQFARmpYUol7RgVZDElf0bS+hfxsTF?=
 =?iso-8859-1?Q?/wQ33f443H39Ps4hp1csjhppxjiVYLgmdBt+UxOngPf2teAGaRwoEFzhzW?=
 =?iso-8859-1?Q?jyMu6cqngXetj7EPeOAFTGvPi22bxUUg+zVZgVXs0IQfL5eGGlmfwxFiIB?=
 =?iso-8859-1?Q?clNNCQFKOnAOKFg3zcqN4MLyCrbikusKzNwpIMXL3jH2isRN04KRdS5bV7?=
 =?iso-8859-1?Q?MllRLnu7D4V3sXXmwz3tAcTpvX08UodisaAiAcgKvmZkCVafqgMu18jSkd?=
 =?iso-8859-1?Q?rDZk6jr69khPeJ0+xuAQx+x5ERTaNrKhJdbDWdCb+lFqpILengBYBO/nrL?=
 =?iso-8859-1?Q?ujruSHGjdAaDSt+CsY/88tofsq3aS/EjNf2zfZ2Yw/DOVOWKRhpMRXmqhb?=
 =?iso-8859-1?Q?6fs7i9VURFqtPyyAEg/IQuySjntzYUmvJRY6ge3T9U0LBDHOHFzheKxkRM?=
 =?iso-8859-1?Q?Of8Q8nlKdbNCn2bKippzkNTmjbKgzkTTUTZXszMS6ypRwjBQPDYhIeTy8k?=
 =?iso-8859-1?Q?F3RZ3506sK8MxzjB9xvUBY8ajhVkZixVzuAjVDkC4IJgTscSkXFZTO2d+Q?=
 =?iso-8859-1?Q?Dq1JoNpkJorOe0niXiFp0QnyFAMyLvJKQ56jgh0ng1MjGpB2kcRN9FbmZZ?=
 =?iso-8859-1?Q?3zPyuy45fgAq8HS2Pejg4iG7Cmr3G5TJ1Z6NQRtvWNLfOz11hgWBY5G7QA?=
 =?iso-8859-1?Q?neXOsHlmwVm+1lnLI+DU2Oks+R1RLgeOUwQNv/tiF+4giENwRkPXmtZN5H?=
 =?iso-8859-1?Q?3HJIZevf7eGO7MZ/zZd+LqQlIbnTEQAT5/oQ+A7xWMpwLyp34/VBOW0yQF?=
 =?iso-8859-1?Q?xin6rES+Sdfau1JvfUizdyuOXvCc+Z9rX/dGW6tLHwgRclt/srtdwzUmPy?=
 =?iso-8859-1?Q?liPbeS9Eqtt31BUIWXHub0ZSzw2U3QgtsyuljvJgIIkAM4PmZhdYYQQlvZ?=
 =?iso-8859-1?Q?BLE86FYsZdyG+2QVZm6sZvLcOCy3cVHN+AK9NDL8pGWr+PVBhEuxR8YK9R?=
 =?iso-8859-1?Q?IfwbWu/U0zmAmJBGP4Oc0M+xGIbKBVhiiEPQCDr4c205soXiSc4K6G+MVR?=
 =?iso-8859-1?Q?RC7zdl34j6B34gusmaqYyEQ4/cye311oyEsRCIRUH6j9yqT+TP1eNnleRn?=
 =?iso-8859-1?Q?dwl5MGYjYu8aoG3Z3R1pV7hsGYqfkZ6s6A+Pc5HvpRoOCmu0Qjrz9r4IEu?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?k61b+LMhnKl3Ip50Z/yjCyPRT2xtDVxTjCZN8GzE8EOmebx4PKrMI89Tcm?=
 =?iso-8859-1?Q?VJ+e2fFUIk35mKjqyBUMWC7iUGJ506tRAg/Kf1hcwI1CIBvqFH/Eg7FjfM?=
 =?iso-8859-1?Q?w8LiH/jsoi8R0FxRLrRrIb76u4oaM2YyowJuJGVYM2BmuLVHU2VDb6+D6c?=
 =?iso-8859-1?Q?LVfCGSiXO2MiFE/j7zRFVl7B2qKzkCScTRYuV//Y44rBRkBOb/ZYYj0xiM?=
 =?iso-8859-1?Q?4QruyiuGFeEbNCWNEj8BMvyLY8zK+lb4InTvM35nMoFkb4LNjM0ZMrl/PM?=
 =?iso-8859-1?Q?qfMdxAKpg3z71HKYJn1S1ZY6NzX7g30dB0eu3GvOQYasMYI8fhNTPmigGY?=
 =?iso-8859-1?Q?b1dp5J1WgwGKTxkKZlFMUhp5lNb+mh/kkyTa2opGsg/4p3FfLC/Nm7Q5dM?=
 =?iso-8859-1?Q?hLYr3l93gUKvPCIyF1WwwVc9Bg/pHYUyi9QiifIqgbTDnpkkoHVSJy16jB?=
 =?iso-8859-1?Q?XzWJ4HGiT4vss9ycmn+EiJ+aANMew8rpjUcaiXwzzvzF12NaOs3OgPK23q?=
 =?iso-8859-1?Q?o2ssJa1SYf1S5S5JSivObD8O+q6KFMuqRkb/WZsRQFxjxi+gFjathLvone?=
 =?iso-8859-1?Q?FJeykcYq/OtqIkqXNnTQ13wQ9gjbyNh9+e8zT5kYP3AA45ZIAX4C51NdI7?=
 =?iso-8859-1?Q?luSdy2rWNggxxxoAYVGBZ/CKoBhuFmjztao6qKltaS7Wm2heInSivIqKPq?=
 =?iso-8859-1?Q?sXykCWd67qVw14VgnNnEUcoanAJbsMR76lBOu/OCNrnKtiF6W3iWQHGDn4?=
 =?iso-8859-1?Q?gbsP4ZvFoRs6zpUE1L3+ApLQVcMcISg7gCA9hXyrXDPbPSI0+iUCSCDLo2?=
 =?iso-8859-1?Q?Q43UnpAh9vpSsPiywVqiIsDlsWS+ioWpnrizmNKwzU5PHTqE8Eu2rBsrmI?=
 =?iso-8859-1?Q?FU+q4JiwUWOw5CZiq8XEWT8N7g0tiNGHaZgZ2i6LE5FscM67K8FBHVoaME?=
 =?iso-8859-1?Q?J+XV1Bn8FnZn7Ynoq+1zkHWKETnOf73l1Z8TYR4/Si0c/zXWZZYGiG5cSq?=
 =?iso-8859-1?Q?kEyAD3gZll4POcwqNx7KFe00njaO5l5uA8NjTUn97plD95puvqQMbwNZlJ?=
 =?iso-8859-1?Q?W0SLQPnh7C9yK+JWAQ3YU//41Tm9GOu2XzBzqbOHYb9cA5+QM6VqbhecI/?=
 =?iso-8859-1?Q?WeUf5hqzRI4b24Gom0A0tG+9iz6NLmkvz6h7t6GS87Srt3PXEQbV4/RU8F?=
 =?iso-8859-1?Q?zLLZw7KN/KoZHTSdyhzK4tSeXAZXzzh2AjN998bloDEZtguQxujvxOd2CS?=
 =?iso-8859-1?Q?eXdLWHAEValPE5g6IKflP1NBcipET43r6uuSI4DdDhJeQWV4+tMrEYqVuM?=
 =?iso-8859-1?Q?ahx6V1jcheXYHAYUYkRAgMyYHGl2lziMaKy66LsFMU0p9NzMN1j0KfL6hr?=
 =?iso-8859-1?Q?vJxdisXfOMylDdoo5YBY8U6TMgJQA61aeapwAvZFgzD4MOYuFfzyiTD8+z?=
 =?iso-8859-1?Q?GRYMwmC3M5L1C6NjplfMPGKWq3ORslo251GAhpkY83hLiIl5ZrMB/zMEFv?=
 =?iso-8859-1?Q?oaseC7DP5kqsX9hNJPAvv3Nppxz7VpLoAAYkQEndWwHY7LPIwASdaVM+IX?=
 =?iso-8859-1?Q?N0o4cBJiB7ZMJk+VMF6jWjfd4RzbzkFAIwl+hDpF75j3gcPUdVyIasajdh?=
 =?iso-8859-1?Q?esKP009rG7CTxcTdg/8IKZQ50K3xMcfFQmo6B29H8/GT6lN55uyRs5rg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d334a02-51ff-47c6-af39-08dd3a6cd4ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 22:42:06.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwN2AGIDHj6BhWzNpOUBWS9j9Z6WSDI51AZgX5vqxOQ5IHfHerxiPdTRkegsb4raPZR6Ocu4W8XS1VsxIvWv4+wc9Ol7MzKYJT7SsycKCaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/18/25 01:40, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> During CXL device initialization supported capabilities by the device
> >> are discovered. Type3 and Type2 devices have different mandatory
> >> capabilities and a Type2 expects a specific set including optional
> >> capabilities.
> >>
> >> Add a function for checking expected capabilities against those found
> >> during initialization and allow those mandatory/expected capabilities to
> >> be a subset of the capabilities found.
> >>
> >> Rely on this function for validating capabilities instead of when CXL
> >> regs are probed.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> >> ---
> >>   drivers/cxl/core/pci.c  | 16 ++++++++++++++++
> >>   drivers/cxl/core/regs.c |  9 ---------
> >>   drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
> >>   include/cxl/cxl.h       |  3 +++
> >>   4 files changed, 43 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index ec57caf5b2d7..57318cdc368a 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -8,6 +8,7 @@
> >>   #include <linux/pci.h>
> >>   #include <linux/pci-doe.h>
> >>   #include <linux/aer.h>
> >> +#include <cxl/cxl.h>
> >>   #include <cxlpci.h>
> >>   #include <cxlmem.h>
> >>   #include <cxl.h>
> >> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
> >>   
> >>   	return 0;
> >>   }
> >> +
> >> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> >> +			unsigned long *current_caps)
> >> +{
> >> +
> >> +	if (current_caps)
> >> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> >> +
> >> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%pb vs expected caps 0x%pb\n",
> >> +		cxlds->capabilities, expected_caps);
> >> +
> >> +	/* Checking a minimum of mandatory/expected capabilities */
> >> +	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, "CXL");
> > cxl_setup_regs() is already exported from the core. Just make the caller
> > of cxl_setup_regs() responsible for checking the valid bits per its
> > constraints rather a new mechanism.
> 
> I prefer to keep the regs setup separated from the checks, and I think 
> your suggestion involves a higher impact on the current code.

Yes, it moves complexity to the leaf consumers where it belongs.

> Note this is the API for accel drivers and by design what the accel 
> driver can do with cxl structs is restricted. The patchset adds a new 
> function in patch 6 for regs setup  by accel drivers.

"restricted" as in "least privilege design"? There is nothing in 'struct
cxl_reg_map' that needs least privilege restrictions.

