Return-Path: <netdev+bounces-123594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E5965750
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB227280D50
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8E14C596;
	Fri, 30 Aug 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VglzAm/A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455CF12F59C;
	Fri, 30 Aug 2024 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997898; cv=fail; b=FpLIzmrIeZgXZyvxyluKLtTPXMOzEbjz/4Z794Q0IWaK3D0vLAuYBIIm+TNqnKSAplI93OAB/WcVv/+3dwcBcxs9Zg3V0+6HIbURpzj6L7DM20MjLmNQX6TP6q+DzfDejlb5mjvHYKat/JkTG1WojYsaK4IZYxOWCplx/p+35so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997898; c=relaxed/simple;
	bh=JBHuAcxvSGG0OZY26T/gjcRI14VFKQzZxKWKQQERFeI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pltIFHmnlGfN2B34M2UDv7zrvK3kCl0uyMqEMe72QOm/KDu7YsJRck8vtvbfT81QM8wHEBLmBrau0si//3jJZNSegy3IQ5f/Zu6h7kgJrR8ttSNwZEoCdy1Ua3e1+A1Dhftt7vWSYP2vLphfKK2ZAM/jS1+AaMh5WCeNXVgoeF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VglzAm/A; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724997896; x=1756533896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JBHuAcxvSGG0OZY26T/gjcRI14VFKQzZxKWKQQERFeI=;
  b=VglzAm/Akal6NKaqiHfdK8CH1qkGmFWh2eWKF/kYkIq6W8IKWV3psvKA
   8CjwSy6+PyRhrSvwHVI0bfq9uv137KPW5U+zU2CS7t4OqQiziQej0vaFv
   dzUNVkQ40Ix3ObI1PhtF8uOJPXX/E2m/MdbgIlg+xue0NSnBl96Iy541O
   hurhBGo8zenqu+mZlz/S6EKo5QdhmlqFc99W4PeLtE/htZHCu20gAskDD
   3pEI9CFRMTdT1S6/dgoBJloZUFf2yIy9D6+qmzQFkRgMdwOpnIWesrGIT
   pjP7diFf4ag42Su7w9Ib7enT1gfu5pC3BQMKp7DM6HLUhhUAGGPdN9mr8
   w==;
X-CSE-ConnectionGUID: OVksYg3QSDC891p/03dTSg==
X-CSE-MsgGUID: GjYlPI/1Q22YfXhvla+sZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="49010600"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="49010600"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:04:55 -0700
X-CSE-ConnectionGUID: ug/vAHIVS/qDhXi8xypfWA==
X-CSE-MsgGUID: 6Xw4UcJ0QbugHRmOcJVp1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="63791509"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 23:04:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 23:04:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 23:04:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 23:04:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 23:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgTsSIu8heeMiDHvcuNFfj5iOhRJ5MEcY6zjMV7yh6/l//dQdlkQ0ZBbN2eW5L/M05C+SSn2GP3oCNiDdeoPTWMvhf7zgRySXZ8HXLmklVxNi9nzyS6xiknubg0WGKFvxhZfqq99Oi/qEXBse+C17Pt+TJmupkjEZVxRmT7NqONPAp/5RyfFQXK1i/TIzEPl2kLCN36zCpi5rrKnU9wkThXDt9ES+N/ARKKqusdG/bESfEGLFh/f3taYSDAedIODpCw8BwJEQnFQKds4aDSivaTJCIjk825yLPm5503z1IS5Y+HfxLUlO2QRzyaDQIxeYWPiWQuST1dkQIeqmmahpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANkGI2MmAydyIohUmo4PTEZ9437QxSWkMdkXKkQlQ5Q=;
 b=W4NuN/LXjWPGo5O4lPEgBkTHl3jjVNN8vvXOWDXHOYh6fOSUc2kXjpotpPSEzQNnSvZxj2rS3OeCqiPxxwQ8JFFfuInF+s0g7YMwvQW1ntMF1c2HY3VnfsnQC0hjnfLdSJfWEXdR66A8SUAO15pB5EOKKmUhiyetkQMexzPul9OSnoM8m2ofZziErzIavtlgv7boxG/14agI+3mFKugqb0ogVrpuebT8Tai9z6KMG6IHJ2IivcxCSTH6YGdi4k0hDyYZCllmRo2FisWlmvtvdQcqz2TwM+xv7AYedJn0smYVZ/pXCkPA6uacVjfwbat26VSTSZSDfJpCT8mSZs/w+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 06:04:53 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 06:04:52 +0000
Message-ID: <0b5a2906-0018-4a6b-9837-56c8a2786f02@intel.com>
Date: Fri, 30 Aug 2024 08:04:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [[PATCH v2 iwl-next] v2 2/4] idpf: Acquire the
 lock before accessing the xn->salt
To: Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<google-lan-reviews@googlegroups.com>, Manoj Vishwanathan
	<manojvishy@google.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>
References: <20240826181032.3042222-1-manojvishy@google.com>
 <20240826181032.3042222-3-manojvishy@google.com>
 <e2fce229-34b3-4877-8019-63dd3cad001d@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e2fce229-34b3-4877-8019-63dd3cad001d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: e07a2ee1-7a9b-4cbc-70fb-08dcc8b9aa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmFMU2oxSUhHREc0bi80emZTM0s4M2xVekIrblhTM21RVmY2K2F3eFNmOUk0?=
 =?utf-8?B?cUcrZnRYZkJ0cmNkb0VqWHdDZnR5NTdwY0dJNWFrVXJZSjdEZWdMUUtscmQy?=
 =?utf-8?B?eDFJWlY5VEVhVjJqVmNEUmZpQ00vMjRaRFVaRjhXRld0NmJnWDl3amFad2dp?=
 =?utf-8?B?dUFDOXRtQzVlazU3SmJYM28xbjk2TFJ6UUEvVFFPNGMyc3ZNZ3NGOHFhSitr?=
 =?utf-8?B?MDY4UzVRWi9jR0NtRmZKc0d4eGNYc2VMbEdWYmtsUCtUODUzWVRuUzJxVGFz?=
 =?utf-8?B?cnYzTDJxUnlHbDhFMEZxREoxUU9jUXhJenprcHVvcXpxcE41d1BSQVpUcjdD?=
 =?utf-8?B?RjhYajZ0aW1HZ0ovY2dpS0xLcHBMd1QwUDhoRUVDUmUvNDkwdUpMYkF2S3ox?=
 =?utf-8?B?N0prbWlZcVA0Rkh4QnlocEhSVFBkNFJySHl6aGVER2pDOHNUUzdLRXpQbHdX?=
 =?utf-8?B?djJEd0d3WVQrMmMzUU5hdUJIMy9XNEhvMWM4UG5OTlF0NzdTMzlpbHpJU3ho?=
 =?utf-8?B?czdQdkxnNE5JZFBEN1I4WitTUFZ4eUxFaWlZSXkrb0VZcjlSbWdOeHVYNktw?=
 =?utf-8?B?ZHAxUnlzaGNlSUJ3SHJnVUY1OVhhamhqVEVpbXJpM1VxVlZndlduODJoYlFU?=
 =?utf-8?B?UE9WOEQ0cWN0RmlZUm96c2JGd09IUWNLTWFHVGt6OHgwWDBGYzZwaVJZbWhC?=
 =?utf-8?B?aHQ0VzBwbGNNLzByUzlqNTdhaUgzM29lRkpjWWZhaW9BL2YvVFRxekpYSmMr?=
 =?utf-8?B?NGRqRnlBMWZuTFpudVRvWk5mZ09vRnMwajNUVUtxalM0YW0yb1hRbytOY3dh?=
 =?utf-8?B?ckduaWtzRzJaYmtZaG9HRnZGRFljNGIxNmxpM3Rpb2xUeXR3bW5nVVRwa25Z?=
 =?utf-8?B?VWV5V3ArSXlyY0ZLeFlrRFFoTjRmNGlqUFpkbkxLV1BQbnQ5MzVBQTlxaTcx?=
 =?utf-8?B?Qm1sYkUyUG5zSDNXMjhyOUpaWGdsWFRacjlENW45dWx1UkZaT2R5VmRVeURo?=
 =?utf-8?B?M3A1WjhrOXhCaHhYSHYrNnlxKzFMa1YrZTB5ME1XN3V6Q0pHSnNpNTVKVXZM?=
 =?utf-8?B?TDFDYXFmQTExbnltSXhEUXozMzBES25CZGt0dTJoUVFLMkFMZVZwZlFtSWEy?=
 =?utf-8?B?MUtDbUk5cFNYZ3RsRnZ0QUpUbUNTU1Z0K2R5L1Vlb2VKT01QTlFhWWtSVnI3?=
 =?utf-8?B?NEEyS1NhaE85QkJNM3lMc0xDQ05lVE5ITHAxb1RCWUtLSlZrblpZZHJkd3Yw?=
 =?utf-8?B?Wmhra1JRVk5HT0VKcGhtdi8yNmFoZXRoRG5jMGNxYnR6MkQvQ0pWWGNFY2dm?=
 =?utf-8?B?OUk5NEFSeWcxeFdYVHhHM1Z2Y08zNis0bXYzU1dNQkpicXltYXUxU2VBeXBK?=
 =?utf-8?B?T05jWWtSbGlUS0NWQ1RjUHE1L0FXSUNOTDFwTE54R1dZTUh3dHp2Q1YvcTdH?=
 =?utf-8?B?R1ZPRXpJcnVuYVNrUE9VNTJQOGFFYkJRR0NiRTVzaVlCMy93clA2SmlWV3k3?=
 =?utf-8?B?OGZRK0FIZ3c0ejQ5bzI5SFFUSVRjTE16ODI2MWx2N2VabUtxUzFzREdYbVJZ?=
 =?utf-8?B?aXlTMHNSWTI2eEZjOEUvUkRuMUh1dVZOckdtbGQ0VE1wTm9ud0dLL0oxblJ5?=
 =?utf-8?B?UE95MlBORmhZWHM4V1hDQks4WDBwUUo3NTM0OWU2M2tXSE5yUm5pM0xibkFU?=
 =?utf-8?B?K2VDOTNnYkFscWg0ajRGTnI0UWRXb09zVHNWRVN3Nlp1RGRQSnQ1L2ROcnZT?=
 =?utf-8?B?end3OFVUMytiRVdmcE5xRVdPNG85dGJvWmJmNjZ1TzJTMWUvVHVuM3RLL3E3?=
 =?utf-8?B?ZXVLY1czMWFZcWlNc3d0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdmVDV0VkRSS2krVWlKaWo3MkowazM2dkJ5VHl4L2VHTzAya2QzWnZETy9i?=
 =?utf-8?B?cWdocG9ZVEZJYUY1WUd5K1piWnJQOFBxM2U3bFJkUFRlekJpRjh4WWpxNlJG?=
 =?utf-8?B?a0M1b1ZOT1Mwakt6NmdWRldRUHZUbWovNmFMajNaODdveDB0QVg3eGFGSXRw?=
 =?utf-8?B?MW5GYXVmTlFLOHh6V3NOUjVkQzdSTHowYVNJVkdDaEtoOGI3RXcrdU9PVnFL?=
 =?utf-8?B?QzNGUFRpM2ppWjM3cmRNdHBXVVJYMjhIQ2YwbnRRWk0wSURGMFFCeis2TkVB?=
 =?utf-8?B?UXEzWnQvUWxMeDg1NWlLV21WNGt0UVVrRHNFMmlxYnV3WU9HMzVUMWFVcXRW?=
 =?utf-8?B?NFlaU1d4dm11S3hOL2NjTTVyVUlkb0lFbjl1SWNKcXRwL2pPU2QrOHdGT0ZR?=
 =?utf-8?B?cUloQm9hRWNpbjYvQXkxc1pwd3dLRlhRVXoxSHE2WGRKUmhGRkEvTldyd1RM?=
 =?utf-8?B?eFdhSXNXKy9GRTdQRVpJWE4xWVVBMzJrUGtsQ3JWMFBSLzVCalEyd0hkcTli?=
 =?utf-8?B?S2tIblhsWjlqcjRXMGNRbFYxbm5waTFEeVc5NG04eXlqUEdtWlJLSmtkOGRK?=
 =?utf-8?B?NGtQRmxEN0lZK3UxZGQzWWZDT0tCMCt0bVQ1WjJEaTJsOTROMFJhQy9uUVdY?=
 =?utf-8?B?KzU3ck4ycS9va3FabVF3eHQ4TW54YzdGNGpUY0M3dnRtNlZGdFA4SjIyaERw?=
 =?utf-8?B?L1IrWEZyakx2UWs1ZHZpWFdxelRvTDVyMDdrR2syMk5FRUhFMXlNR3VNM2dM?=
 =?utf-8?B?c2YvT3pQSW1UQ2lDcEwyTDRJSVV2Q2hKR2EzZEViTUNOczJ4UXhBazR0UVll?=
 =?utf-8?B?L3E1Yi9iSkVLQnZKZk81N2hZZmpzdS9hcGRVb1dScWZOaFNOVHRVeHlIcXht?=
 =?utf-8?B?SGlFTXV5K1BhSjEyVElGbkd1S2Y2NXMvbFRQampkbEkvbkpzd2QxNlIwMm1O?=
 =?utf-8?B?eXIwUDJYUjlsMjgzWXpuc2VQZ1ZrS1Y3NFByYWp2SDJ3RkVFc2JMK2J0ZWFD?=
 =?utf-8?B?a3R3ZEtaZm5GUE85NEpXbmFqeXQ3V3MzcENQVTlvQnFycTg5TmQzb3RBQldD?=
 =?utf-8?B?am9UQW4rTG4zeEdpeGF5K1llWHRNWmtCWmd2NXhldnpjdUZZR0ZlU3NQQ21D?=
 =?utf-8?B?OWdlTHpNNmJ0cFVieGxDZWFDOTNsK3BjZUNkNGV5bmJLSWlVaFd5SjZmd1Zl?=
 =?utf-8?B?THZXRW5pRDBZSFloMWh6d0RlOUtSb2tiOUlyeVo2dVh6MkR6cGN4WnBnb2Uy?=
 =?utf-8?B?TmkxWUcvcHV3Q3E5VjdCN1pVcHB3WDVXdW5yUE1zRUFxQ29VMDZIL3Y3RUo3?=
 =?utf-8?B?c2x1c0dvdS9nUWlWeWtyMCtST09ScGxzL09WQVc0RlNyL2pRbUNJU0lld3ZD?=
 =?utf-8?B?OEE2Z3dySXpwQ3lPTHBXWitIOXlLL2xjUmpKbkVOVW1GSi9mRXBISEpRb1ZE?=
 =?utf-8?B?di91U2hXMEs3bXZsbGVpS0trWFUyUG9QbVpCbDZzRE4xVFJJZktMZE10MWpE?=
 =?utf-8?B?VnFZazZGQ3VOZFJXc0ZidjljWEEreVlONVBYdXFxVUdzNWFrcWY2eVJVekhj?=
 =?utf-8?B?RzhFY2x2VmFYZU0waGRNbVFsNVdZR2NUM0pGZWpqWFUxZmcwQ3o1YktEV0hv?=
 =?utf-8?B?bEdneC94emVBMkhkYXQ2WThzY3o0T1ZrODNMSTAydmdnVGV0SUUvZWE1TzlC?=
 =?utf-8?B?TXdadHpTeTBKbHU5dGd6ZldIVVM3ay9ucEhlTFBEZUZoNTFXRmdkVTF5ZU1y?=
 =?utf-8?B?S2VRZ2dQWlIxM3pwcnJsd25Ga2RFMEs3T0hwTVd1ODVwV0UxaHlJclRBZnFH?=
 =?utf-8?B?dzRmOW4rS3pHUFNnbTNsMWw0VjBKWkR0UHkwSm1oVlE3ZFdabmpFR3dJSUti?=
 =?utf-8?B?S25HM3FyQjFFMFZ3eWZZOC9oSXdmZjkxQU9LTU9TUXgyeWN2TVh6VVNmSlZW?=
 =?utf-8?B?SVJoTVViZmsrdWRKSXVMQzlUanlVMGFqQXdiaU42VVdSeHhLNFhtR2RTMWxD?=
 =?utf-8?B?YmRJNnAwckY0dFdwNHBmN3R4cWlPVFZtQTlXdWE1enlRWW9qRXZneWdhRHRv?=
 =?utf-8?B?MDRmZU9MRnRmenpIWmFKZ1YvWjRTMFJlRytUY05pZFhYWlhlYndvSXNMQmRW?=
 =?utf-8?B?OWlQZ1Y0WGR1b3JPV2prM3BnRlZsYzhBQ2dPVnl3SUMzaHJwWmVlWEtIY1l1?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a2ee1-7a9b-4cbc-70fb-08dcc8b9aa0b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 06:04:52.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5SkSazKN0PjGyqcGUxYKPw/qiBiVUfUjwJQsRjXNIMnEMCRX9twJ5PFsZeQ/xZO5tpMM54gjJHLl7sLMwODn8I7a1wkYMW6g0zXieAfnCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com

On 8/28/24 23:29, Jacob Keller wrote:
> 
> 
> On 8/26/2024 11:10 AM, Manoj Vishwanathan wrote:
>> The transaction salt was being accessed before acquiring the
>> idpf_vc_xn_lock when idpf has to forward the virtchnl reply.
>>
>> Fixes: 34c21fa894a1a (“idpf: implement virtchnl transaction manager”)
>> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
>> ---
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
>>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> index 70986e12da28..30eec674d594 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> @@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
>>   		return -EINVAL;
>>   	}
>>   	xn = &adapter->vcxn_mngr->ring[xn_idx];
>> +	idpf_vc_xn_lock(xn);
> 
> Could look at implementing cleanup.h based locking here so that we could
> use guard or scope_guard and not have to litter the exit paths with unlocks.

only scope_guard() for networking code

> 
> I don't think that needs to be done in this patch, though.

+1

> 
>>   	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
>>   	if (xn->salt != salt) {
>>   		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
>>   				    xn->salt, salt);
>> +		idpf_vc_xn_unlock(xn);
>>   		return -EINVAL;
>>   	}
>>   
>> -	idpf_vc_xn_lock(xn);
>>   	switch (xn->state) {
>>   	case IDPF_VC_XN_WAITING:
>>   		/* success */


