Return-Path: <netdev+bounces-202439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBDCAEDF1D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D01918860E9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629928A72B;
	Mon, 30 Jun 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUuVLBIh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86728B7D7
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290253; cv=fail; b=pD1s91CHr0O+FwFQc1ieD6RsX9mtJk8hiLL3/PkN0hLBSRw10oPgoJNTZJ4RyksInY8L4B1/oYDQRZffFGascEJBkoT9B0CgtXR3cGlNCYElQ1TE3bqIHofBrk9ZB/elrkIVxTt9UQKnaaMn4Cd0tsq+Z5mBkMfV3A3ZdteKWM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290253; c=relaxed/simple;
	bh=aq6SJxKUhleRP0uaf5NOHvBPZijHnd0R/QRebI2Jmos=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fxIoUCikbNXTOJw4f8xtZM6PVgl6OM4bB1eMllqIVC1A+GC69DIuIg3voIB/m8uJjfBJIuTjwvzJarlKIwFPOpucg+r+mkv2FsmOj+uPRCmgPluQzGNfqQp7MsdTnu1KX2P38SdccDfaz+aQZPCLnG4zelmUi7Fl7mPKF0eWai4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUuVLBIh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751290251; x=1782826251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aq6SJxKUhleRP0uaf5NOHvBPZijHnd0R/QRebI2Jmos=;
  b=MUuVLBIhLyCi8G9SpBnLgGYKacA3mgisWuVQP81B9jw3qbXVylCCLHzt
   8xeTyyMTHxrZ7ZvfUXe7OMH5WCR3A6bgR+NtACTTqCKe1z2WOldBVJSY9
   EPVA4iEa9M9uvLen30XpftrUVX5SBYi6t0P/tsV17ueqF9eVmmUgLPCt4
   zGMUxqnPlGmaanaHdWo3TV2jsuKHskaRnJolvFBWNCI7QAvoGVBmvGePT
   HAH24QEksqEU6e41n33jeKM2XmWDU5guqnLKDxGAEG67snCNvkKlSl4C/
   ogBPeHyPEnmA/7BPXwLOFaf6i2z3IF8Nr5LMsA3G7YJb79EVXIBH4E85B
   A==;
X-CSE-ConnectionGUID: xSkrwxtrTGGXNJE5kYskow==
X-CSE-MsgGUID: 2t7Rh+ICR6a56fvB/9lOfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64210681"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64210681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:30:48 -0700
X-CSE-ConnectionGUID: S+PaBshwTKGp2tadDdk97w==
X-CSE-MsgGUID: W6RY8KP0SGeI29OUWkocqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153638767"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:30:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 06:30:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 06:30:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 06:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVloSfNUnKkC4Zmv9738VYeB04uCU40BXOxg/E0typlBKJNrW7mXo8gempwGDnQ1sDR04/kCM9KklwzHhlmNK9CVvVw65MFaWC5w+nvS0znWtY9xoJl4OWWESC8eW461L9e4AuqqgpvJPVxOAXzsTgFwbzCfUIPyO0PxPIXTMtzTFTcmOumMGXS0DPxnov7OfCpRLYbz2qU68F6u2WkAApIY1rHW0APkxImoFo2BmUkvBMvvYktTqy3eEx9JFFGmbxjm6JjE2SNMuqCDnVUFvyNqCwfz1iZ+7gam5czFIvYFwmwgaHMV29CLt+g4+iKCWZy2XqzwreWwMJVTZjFmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmNV+/jiZZYzFQgbT9/N+OJvGSRB8gZaXtGJwOR6IH4=;
 b=VeROZv11qud4qHqg6WbPa7aFwg7JxWfzkG0HqCZ69EJkuICT+YpFX6HE5Eg/3WB3T+AKt8EDAXtwuLLDCffF/puIe4WmtP7gk3fTqjj21Yq+gh9RUtBwG+RrxVFC+DBLmeJPpqjpHwIz+1BdEBL7TyZV4JTau++WHfjYiOjRkCoVBZHxCzuXO9s2TW8iE+m/wxmkWlN8mW6IS7CgcW1+BhaMZWyr1Kve/BAznTHJdNdn1X+e/RRzfDREZj6ugMSo05CIPPWBZl89xJ1G8zTJuDkyXdb3SJQi3PeXrOpWmidkumRu1ZUFHimDM11lfVh4oR6nZkvkvWryTiEHx1ergg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 30 Jun
 2025 13:30:29 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 13:30:29 +0000
Date: Mon, 30 Jun 2025 15:30:17 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net v3 3/3] net: ngbe: specify IRQ vector when the number
 of VFs is 7
Message-ID: <aGKRaXt96P18QnIt@soc-5CG4396X81.clients.intel.com>
References: <20250626084804.21044-1-jiawenwu@trustnetic.com>
 <20250626084804.21044-4-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626084804.21044-4-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VE1PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::31) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 828c7817-e519-4b7c-8bdd-08ddb7da476f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TJ2qRN6D833DSaCGvd4nNTCYdDqLvdBEzn9UTSl++w90bz/pC/jj70wnNbE7?=
 =?us-ascii?Q?YVLQ0EpEl/tTPGn7GUn8yHpyN0dNgaXE1T+/x60EuxDaHJMRjwmMQP9iwklo?=
 =?us-ascii?Q?damfXG5F4BDyeU+ZS5dKaT1uUyIKDYR33iH7DXvk+qtJGI9BBhJu8fl4LDZU?=
 =?us-ascii?Q?QdmteZvQruqwjZxD6gGtIsQi2o+2wQZYplhLlJcRa3gL+klePZVHXqlEBiiB?=
 =?us-ascii?Q?XPB5ng2eu4mVYOPEzO+9YxkQbTiovTJM473PoTZgfl5Dx5PD5n4nh3nHffs3?=
 =?us-ascii?Q?pOCYSZRQSNF3tFNb4RUVLqw9kfdmoAqGS07jOMGlcQCqP8JpSY5GyfqZxnrX?=
 =?us-ascii?Q?GBzrHwOjfCXYYODCCgii0Ct+sq8oBz033nzOButH/SKJbFdCBGo5ZFG7fuzJ?=
 =?us-ascii?Q?iWa8fTgXFXWR2xNX3s95tue/YjQsN9J0orAVCvsIKa1l7SAZwUsh7ljgS1Dl?=
 =?us-ascii?Q?gnho2s89XncgRHD9/hMnUsmcTpbUtoKd1/QeUlquY3Bt8F03et8iXql1rgZU?=
 =?us-ascii?Q?gKOwYO1hR8BVSAvRp9z+t6AM97rOqt8qc1XfjviDpNa3vynsySmOKYc44GSK?=
 =?us-ascii?Q?wESphHMG159Ym92cBvBfli0VAkDRkzlz9M7+LK8EI27nve89s4USzkVZscrP?=
 =?us-ascii?Q?26+s7wDwXmPH/uTnSssRciJRXfUakh8gYYZfNf2uD5hcjydsSnIHZeXa0qXe?=
 =?us-ascii?Q?qijRdTj1qz6+dnP5xQr+xFf/YlAL5SlaWkXYdMlB2ktrA04GHZ0pNpjXcM4v?=
 =?us-ascii?Q?iB5FaY+00vnmNhpPkUaFbFYYkVk/+D5eItOU99KiXCpWeXwxvdNIG64BWYsn?=
 =?us-ascii?Q?MmIi179C2/TTv1TH4O16g6e15P1bS/GAngE2vtFBbvu5ciqtKgmU/Acw9Da5?=
 =?us-ascii?Q?QZN1Haa9jdcdqYd/jwIwO7pHJgNu4j2cc3IDyUcKKUHjTnHlZcsqSIGC0mp0?=
 =?us-ascii?Q?CYRlh5hMzyLwQQW0xLjNvFGIneIpS3/OOZ84dz672sJHjYKjG9IDBeQJTjH/?=
 =?us-ascii?Q?cpZq02wbBSAzNMZ4Ktsqy/6VZA/8hzqlaMpkhJo6KaCQQJL5IZU52v/qguJY?=
 =?us-ascii?Q?0QoudYQCSzfYMy2QqF4wUfewDjpeypDBFyxxf7xG8UCbQ/uyPiejhO/jEB2U?=
 =?us-ascii?Q?/aYRB58XwF+6miUXCGrtCT32jS91T7fDxXH5f5Jei57LcnNwUYy6+c1TCGGC?=
 =?us-ascii?Q?uyJG2UegH69yUb83cLEyGX4RpxfE0qAdvMaQUmqH1oMGB8B+o7T6FZEqDVAw?=
 =?us-ascii?Q?wZa5xlmrIOKXzr0x593VZ+dv0BuNPzDJEF97Bi6T94c7wyS19V5MpH7GMjEl?=
 =?us-ascii?Q?v3iTjae4iTUozRy7zijfCWNC5W3teyCjcvPcklrstCNCgnWkmVfouZe7+KWx?=
 =?us-ascii?Q?BHnkoH1l6fCrC5jcJQ7kr/iqGv5x3U1ayPrZumfGwvuAoWp8Fxgj6/sfAzCj?=
 =?us-ascii?Q?84cFKigXW6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTxp8foxOirKwTQcodtinjPFFb/XkBHSLU8mmWjDaSg4OKbxYuQo3MFb8/Ps?=
 =?us-ascii?Q?lrSIBepd8BFQexB4en8vp+NzOhQFnqYoixzbWgViSbHhEqRFFLA6u1geo7QI?=
 =?us-ascii?Q?oZiAJra32se+bNzQzpw/Rt3X/r/ao1JsPnftq29exBJwXJMFR8TO3GxV3t9r?=
 =?us-ascii?Q?0YKGm5nKfwaixRlS1uUsyjVRKKzCvSff2kMcubsPkoPelD8UAIw3iizYTZ8Q?=
 =?us-ascii?Q?7GWzkCQTz9dQJoH5jdGGEa0czdTar4MLuzrDmwPznBBx6ahNxbt2senxKQ1k?=
 =?us-ascii?Q?d7sP8Vz+m+laOMXd5rn4Rp8itqraO36C2sC4yWGLfhtpJEl80rSwwiHjTaGd?=
 =?us-ascii?Q?j2vVVGGydGuLvOWzri2OHqh/ACdYtZYNqTJhG+aOj98guF3J9aapuA1nYY8b?=
 =?us-ascii?Q?ULKdwWLJ94XGzgPzrm0IKst6+JyUYvLXsK31yOCEDg45gVX6LsDRqp9OwPta?=
 =?us-ascii?Q?8P6wH+ChiRETPekgT4mB5TYmmuRkFvHj5OaNUGnyiftUFyB2VoBMrkexw9F7?=
 =?us-ascii?Q?yrbCiEypjd+WdPDa1M1wZHW7+xOfuHSthn2YoNV8uwXmyCjlCGxPWaD8hbRK?=
 =?us-ascii?Q?NewibEtmMuwAitMtvkzQToXJhkTkyLimmAHhiigakpY4o2bljo5FNNUO3R/C?=
 =?us-ascii?Q?h7HK8t4vLDAsCFhSaEY5ncmwNiavSeBpS4CX06ajxiLvV9M6fsW1gwVdJdUG?=
 =?us-ascii?Q?yJUdwLaJQ5Mh2CkUWGaVSHEr3p3tJBrBmqgkdjXnywcMGhwmy/sJk0Z19mGY?=
 =?us-ascii?Q?EJpnkXuwz4WQKAyMNz4B19bnK0oPYEbXOvfPdpPLE1/9ubcb5oJVD7PmOkKr?=
 =?us-ascii?Q?S7+8fInMtHHNDsgZqYDKDlHJm7oWuuf+QbOrWaRXt+U1T8Wzip2IsuaYsgcs?=
 =?us-ascii?Q?FQb0l23gAdqQFZOWdtWH6CE5o8x18AXs1e37wsvc4NeY3p0Mxvi1GtRBKySS?=
 =?us-ascii?Q?hl9u7Y0ROTHCmdlOUMnONcw429lIPoMaP02jkQkMgBwKQcd4oEZLWb6NEL7u?=
 =?us-ascii?Q?ZnojP2GGt+15T6ueU0zCICLvrI46ON35GT1q0yQiZfnhpShR8TnOXNI5kxPv?=
 =?us-ascii?Q?OcwMQ+VP7R+ofW3BAs+I2bYNSSZ8QZh2Qq2XGBp2ApUocr5OxJNUgC36O0Mn?=
 =?us-ascii?Q?/mdWGCpQffdM7hfNwUk+4jBvv67WVPG6fguSro5k6FfJc13UsWEn9xl/74tO?=
 =?us-ascii?Q?ljSpMOEObMGjyxkXaEG5hyKngsbLPw4e6c7I5O5cCj76dwvTMbfUaZS+vTx6?=
 =?us-ascii?Q?4u/jRRC1nNSjwyxfBqpJH/KNQ5KQbAkqiOEl0Agr2277Cy3YxHLFjA18DFI+?=
 =?us-ascii?Q?wvqQfG8QUohwHatxQ+oZvNY5efDcjfduX0AVqJ3sSzIA7t5lX6efV96/1AuG?=
 =?us-ascii?Q?yDOGXc5yanVfe0rtawJTvkpm27hHrcwUhDB5SemphFV56JddWinuCKBcsavh?=
 =?us-ascii?Q?T26vJ4sF89dCkkMzYRW2W/2ixGgkj3BuzUapdan3a4DKFHAnaIRLdXgMHfUz?=
 =?us-ascii?Q?eYA/nb2zL75NXv5dbHI1J26UomqM+ETrqYvPXA8ssF+2apDQwiC9EDrgWKsn?=
 =?us-ascii?Q?DDOpoQgKDxil5GM3CGU4FmjR+RmBSKqrBphdSeyajqLCT8WkgEn4fN5TC05B?=
 =?us-ascii?Q?GhvLlveU+1Z167xGetJt8aR5b9JIEnZ/qdw5+UM4FfvO2rEr2cT1ZkndOt9o?=
 =?us-ascii?Q?CMChrw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 828c7817-e519-4b7c-8bdd-08ddb7da476f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:30:29.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfvJnRR7ToGCHyVY9LcEGiLIrS0vGldY/+gNvhicYfSYdaANdSeMDlLUDrk84wD8Iszk3I/fP8QDg5tqGBRXK9XncBxWfL8RVNM3XiCZ4T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com

On Thu, Jun 26, 2025 at 04:48:04PM +0800, Jiawen Wu wrote:
> For NGBE devices, the queue number is limited to be 1 when SRIOV is
> enabled. In this case, IRQ vector[0] is used for MISC and vector[1] is
> used for queue, based on the previous patches. But for the hardware
> design, the IRQ vector[1] must be allocated for use by the VF[6] when
> the number of VFs is 7. So the IRQ vector[0] should be shared for PF
> MISC and QUEUE interrupts.
> 
> +-----------+----------------------+
> | Vector    | Assigned To          |
> +-----------+----------------------+
> | Vector 0  | PF MISC and QUEUE    |
> | Vector 1  | VF 6                 |
> | Vector 2  | VF 5                 |
> | Vector 3  | VF 4                 |
> | Vector 4  | VF 3                 |
> | Vector 5  | VF 2                 |
> | Vector 6  | VF 1                 |
> | Vector 7  | VF 0                 |
> +-----------+----------------------+
> 
> Minimize code modifications, only adjust the IRQ vector number for this
> case.
> 
> Fixes: 877253d2cbf2 ("net: ngbe: add sriov function support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Looks fine in general, but I see 1 functional problem. Please, see below.

> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 9 +++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 4 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  | 1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 2 +-
>  5 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 66eaf5446115..7b53169cd216 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1794,6 +1794,13 @@ static int wx_acquire_msix_vectors(struct wx *wx)
>  	wx->msix_entry->entry = nvecs;
>  	wx->msix_entry->vector = pci_irq_vector(wx->pdev, nvecs);
>  
> +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags)) {
> +		wx->msix_entry->entry = 0;
> +		wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
> +		wx->msix_q_entries[0].entry = 0;
> +		wx->msix_q_entries[0].vector = pci_irq_vector(wx->pdev, 1);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2292,6 +2299,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
>  
>  	if (direction == -1) {
>  		/* other causes */
> +		if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> +			msix_vector = 0;
>  		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
>  		index = 0;
>  		ivar = rd32(wx, WX_PX_MISC_IVAR);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> index e8656d9d733b..c82ae137756c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -64,6 +64,7 @@ static void wx_sriov_clear_data(struct wx *wx)
>  	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
>  	wx->ring_feature[RING_F_VMDQ].offset = 0;
>  
> +	clear_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
>  	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
>  	/* Disable VMDq flag so device will be set in NM mode */
>  	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
> @@ -78,6 +79,9 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
>  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
>  	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
>  
> +	if (num_vfs == 7 && wx->mac.type == wx_mac_em)
> +		set_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags);
> +
>  	/* Enable VMDq flag so device will be set in VM mode */
>  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
>  	if (!wx->ring_feature[RING_F_VMDQ].limit)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index d392394791b3..c363379126c0 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1191,6 +1191,7 @@ enum wx_pf_flags {
>  	WX_FLAG_VMDQ_ENABLED,
>  	WX_FLAG_VLAN_PROMISC,
>  	WX_FLAG_SRIOV_ENABLED,
> +	WX_FLAG_IRQ_VECTOR_SHARED,
>  	WX_FLAG_FDIR_CAPABLE,
>  	WX_FLAG_FDIR_HASH,
>  	WX_FLAG_FDIR_PERFECT,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 68415a7ef12f..e0fc897b0a58 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -286,7 +286,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
>  	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
>  	 * Misc and queue should reuse interrupt vector[0].
>  	 */
> -	if (wx->num_vfs == 7)
> +	if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
>  		err = request_irq(wx->msix_entry->vector,
>  				  ngbe_misc_and_queue, 0, netdev->name, wx);
>  	else
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> index 6eca6de475f7..44ff62af7ae0 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> @@ -87,7 +87,7 @@
>  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
>  
>  #define NGBE_INTR_ALL				0x1FF
> -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> +#define NGBE_INTR_MISC(A)			BIT((A)->msix_entry->vector)
>

In V2, Michal advised you to use BIT((A)->msix_entry->entry in this macro. Given 
this macro is used for call to wx_intr_enable(), I would agree with him. The 
driver is not supposed to control msix_entry->vector contents, so it is a poor 
choice for such hardware-specific writes.

>  #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
>  #define NGBE_CFG_LAN_SPEED			0x14440
> -- 
> 2.48.1
> 
> 
> 

