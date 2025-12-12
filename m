Return-Path: <netdev+bounces-244465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C90CB82C3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998883037149
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544430F7EE;
	Fri, 12 Dec 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjAhWSHC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B723EAA1;
	Fri, 12 Dec 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526277; cv=fail; b=ArJW6NHi9A6HMJfsP/qfFFhdBtm2tgJenSj3U99SOjES0khZXSQ7gh4fxl+/plkHjbwSdf+Brq0+sVe+KEcfxL9gIMGLxXtTmUpAqSu2lC+qqstQPCG2Bc6mFkpDYtjRJKi3YD04KMOZkbET36xC8hkUMrvFKMkxyT94XhDlvTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526277; c=relaxed/simple;
	bh=dQxipcxu/i6ZvJS8FJ7elREaL01OV4qjiHius0tKHqA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMVVmtq3v1yG0/ThUq+36ubNEiwSr14TullsmMghM3YQwBeiAI2dgupNOriGG+NyCJhVd7RqgQrV31/MqqFHb1o+1zGsrfVaLl77Z3dijEjOpfQhFGZblnf+8MeadizO1naCeOB6iAMN2wRuR0ECQYkTWSqUD0lLpldQmbYbYTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjAhWSHC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765526276; x=1797062276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dQxipcxu/i6ZvJS8FJ7elREaL01OV4qjiHius0tKHqA=;
  b=jjAhWSHC+mxSGk4t0ZTkXoOpkhNvOEAuKXG/4LLBYJAG2QTHpAAx0sxQ
   +k1HNTq2Fd414VjXLikRymF+ykj4eqn5fb8wgL/eJgWleuPihFoNWS3gp
   sZGu86ATRQK5Rw+RpKhgBwa+7jfOw94xC4jb2GhwJZJr/xXX2AEsos02a
   HcrTm/dcrgloFQr4EYPvA/59RP3Kr6hYxDUIVrN5cyxx1fdN7KOqJV/wX
   RMBt2ZeQ+FtALkzVvV/gI27B0HIOwKnknPbmM3oepqWT7+iWHfhWXP0fE
   yQYwnAm3aKzDN0/FbUq2BgLqh2Cu3kVb8JpgQ62CizbnRLGJqd+V1Yi4j
   A==;
X-CSE-ConnectionGUID: 3RBTyNb4RbaIKGDLIpz/9g==
X-CSE-MsgGUID: MAikOLTjQ5yu+X+oBM/NbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78219756"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="78219756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 23:57:55 -0800
X-CSE-ConnectionGUID: cjPJ25+WSGytLLsCjsVNkA==
X-CSE-MsgGUID: 13+q59JSSqSe5vjnpweRVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="234419749"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 23:57:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 23:57:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 23:57:54 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 23:57:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMkl9kgar2H221U20neorjWJ9PYiZ0VFGzBhnvZFbvTfQxPtH20G7xVvy59GM/rr2+sXGFrWobZG/6OcRz0Ud1/fg7s6J0e01CWtDgA3alzxx5TGyarLUfaKT1LtWPXWpMXhWzx6HkcXfWytMS/Aq1ktM0okDaGCaERWy7scFEZVzstrIf7vMEjlA0tbbkEY59RRdQscYJcgOc627rfyLocZ7Ezfrhhhfzy37CXpq2SrMI7cy+eas+qIJ/nIZqp+16378yh3ajcmwWO3cxRgzonIudToQAe4FpB/9P2r//MI9gzgMl/AsRMDDCnTpepQp29N3GVi/BLDxjwvl2ppgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=154jb6bM3tsIlzs447W/O++CXccSRtIwp+W2wU1JQbw=;
 b=ZG1HxG8HB7X6uXaPI4nW6QQlUfsdFoynTOFeser+Pbta1XBw7NYnkp6s11fjrOf9BEPzagrtlXXovpNapG/BAoNDP5fi3IHrnvWSVpBkRmu4I2uOvuiASruORfKtrPWjKcK8lOSDiM4nCzrFBxCDrRyZbXSksFY/DtZmyoNN1BkLyCDAxT0Bo/keGwSNvxXYOkKHsizbgk2jB357YtuBXB5lvQ2pD6DoX+QF03w3bQzIoARWPiLpWuLfC20I42mi8AZOvZI6S8Ry0k9bvhmxEfi481yz7NwUcJWLuRTFLgokzvwAUVsdZR0/9eDxd2rCWM0UVDE+Lp5SR/qt8VUFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 07:57:52 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 07:57:51 +0000
Message-ID: <684b2ce6-c8f4-4ecf-9fbc-b75137689083@intel.com>
Date: Fri, 12 Dec 2025 08:57:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v1] idpf: read lower clock bits
 inside the time sandwich
To: Jacob Keller <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Mina Almasry <almasrymina@google.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Rizzo,
 Luigi" <lrizzo@google.com>, "namangulati@google.com"
	<namangulati@google.com>, "willemb@google.com" <willemb@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Olech, Milena" <milena.olech@intel.com>, Shachar Raindel
	<shacharr@google.com>
References: <20251211101931.2788437-1-almasrymina@google.com>
 <IA3PR11MB8986D6D6FEB5B8D443E6F087E5A1A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <25a83e83-46d1-4a16-9383-6d492cb37c7a@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <25a83e83-46d1-4a16-9383-6d492cb37c7a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: d9180e09-2dc8-4135-ddfb-08de39542426
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW9KTDVWdnBrdEJ5UXVCMlI4QUlRUk16eXRSOERtWVlwZHFlNjRjYUpzd3I3?=
 =?utf-8?B?aVdXcUgwNk5CTWFsRTJXbHdWSklVRWVwYkpKSHRZTmFZQmhaNjEySk0xaDVI?=
 =?utf-8?B?bWUybTJBbExFMWZ5QW8xSDY2SzExV3pXMDdxMml6c0pkUVBnWTV6V01yVk9I?=
 =?utf-8?B?eUdna3RNbFFsZWFtendWYXdRd1ZhL2NwdGtUNkoxRWFlUTJ4aVFYZmRCa1BE?=
 =?utf-8?B?dHNnUVcwSGtjNEdMZzRPVGhTZml2TVdLNTVrMERrVGptbnd2RFBhdmppbGdL?=
 =?utf-8?B?TlVUU3hpU1FZR3I2d2NBcTZQNVlqeUhuczRubHZkdytTaGp3UjdnRm1zQTdu?=
 =?utf-8?B?dm1FTTNjcERaTm9xS0lkUjZza3BIREVnWmw3dm5yOGZrNkNPcTlNMEdqUU5i?=
 =?utf-8?B?T3pBaXB6eWlmM2NQRzM5WkVSNm5WenBQcVJTM3QxbkkwOUJrb2YwdHlSWUc3?=
 =?utf-8?B?TFUzWVIyOUFUanp6Qk1sRlJsYlp5aEo4dmVFenVOMklSYTJpQ2swK2p5dUxI?=
 =?utf-8?B?cXBVeCtHc0RsbXpvVXRGT3FqY2lwcjh5UkxQdlA1UWNvMkNyTU42SmRmWVpW?=
 =?utf-8?B?dEF3UnR3NUZEZlFDMWVBMkVLME1Vd25BaEx0dDMrOUtMVHhJSFJJOFRkcUc1?=
 =?utf-8?B?eVp4SkcwdkRldjBYVXgrV1ZXNDVzdVROdFFBekJaV1NPcVcvYkp0ZGpTaXJT?=
 =?utf-8?B?T0NsUTk5eXRMK0J6QjY5VnNhWGliRkVNZzBMb092UUVuZ1B3QlRWVDY5U2dk?=
 =?utf-8?B?Kys2V2FKeCs5cTM0dUNhWEMwQ3o1K2VjaHJNbnRsUDRvem9GRUEyTkFicGpw?=
 =?utf-8?B?TEJpbnBRRFhDYWpDMjdpTWtKbGhIYy9jdlA2QWs0SThaRmNVblc4M3hIa3ZD?=
 =?utf-8?B?eExPTlZmQVkvVlB6UklUTkhnaWJKVFJSUkcxUkxwWGNhSVNTRzdkdTFxTDNJ?=
 =?utf-8?B?NStvQjNGYmZCektKcDkvUmJVbFRteHkrUW1nV2dQSys2dTc0NmJyazFQU0lQ?=
 =?utf-8?B?V0t1L0FBUWgydlNGZ0REWVZHdjJ3UkZXL2xEZmRybmY4L0w1SDRwUlZRZUo2?=
 =?utf-8?B?eEhweEs5ZmhYUHE5SkdUeXVLWXJoZ3F0OXRlMTVNSk1UVXJhNVpHaHhDekxr?=
 =?utf-8?B?MWpKdHdSV05sbFNUNTY4YStnaFV4bWFQZ0tRSGdnV1A3MGdFY3VMN1JoVXVQ?=
 =?utf-8?B?RWlpck1Vd2tGai9ROEM1OGI4WHJKWnc4cUF5TG1zb0hqczdMcDZRa0hMWlVR?=
 =?utf-8?B?QWtBYi9CSnpINmNscFhuN0dYZkJLY3NxaHdVZmIxa29kNFRDaGVNN3lXY0V5?=
 =?utf-8?B?SW1CcW5LZW5SS0tZM3BQSW9GVEpwRzFBQnhOa0loOGhXK2JZQUFFaitoUzFi?=
 =?utf-8?B?RTJVKzIxQ3o2cVcvSjB4K1U4SjI3NXZMb2ZCWSsydmRxTXpUcjVtMkdJYUNO?=
 =?utf-8?B?a3FneTV6RnBUWWUraWdjcDhMdWxvZDRXOUxmSUpZb1dGRU1CQkY1RSs2aG9G?=
 =?utf-8?B?SWdVK0NvOUdzSjJLL3dUcnYrYW1IaC9leXBvZythb0RHdUl4MVlCdUxFempp?=
 =?utf-8?B?T09GTjNheUVuaWxtS3VQeVVDWE1zcDY4Y0xvaFZXTUNSTC9yOGVpY2NMakRC?=
 =?utf-8?B?TWlrZUxoYmMrdit1eW9za1ZFVGZ3NXFNbFBZSVFVelZ6MUF5U2ZXV2xqRVVm?=
 =?utf-8?B?a2JQU25aQzJUdis4NUR1TlZraTlzNXloZlZaZzc3SHhmczViQWsxY2YrRW5n?=
 =?utf-8?B?VXBvUjZKaVRQVGFTNm5mWXp0cnpLN0RoVlltaTROM3p0MjNpWVdCaEhtZzFi?=
 =?utf-8?B?OVY5V3dMM0ROUE03aEwrQkZhSEZSZVQrbnNrZHNZSXIyMkRCYjhJM3dLNTg5?=
 =?utf-8?B?bytlM21BcTFLRlQxbXBmZkE2Wkt4NEw2Ukp5UXFRb1lXNjZ4dEd6WHFGT3hr?=
 =?utf-8?Q?3ACslbiG8q075UspmEYdqXbfQPHIX9bZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBFcjNuQXFhOTVFRktjeG00WS9TUURUVXFlUjlhZkpiL2tCT0hpaWFzc1JG?=
 =?utf-8?B?MitLajJWMml2SXlUbDlZdkNncm9kMk5nRlhXMWdRM01ld0VQTDN5YmRGTDZF?=
 =?utf-8?B?WTZCclVTanpNalUxbnV1TTZ2aTVUdnpsZ21hTTNOdU9iRU51N3FUTVVUWTFL?=
 =?utf-8?B?cG5xYXF6dVh5WkwwT3d5TXgyMGRIK1NiS25GTkg2aHdTWXhuL0IrTmNYSzNB?=
 =?utf-8?B?V1FaUG51eWZuQjhXRjRBY2llVmozUUlZYldYd0dpVU5hWEozQUZvbDZOWTg3?=
 =?utf-8?B?VFpZMlhHZnZIQVN0WlJPbG9kZ0szdWtpMmx4U0NIbTdHRllEa2VTU0lYaWFi?=
 =?utf-8?B?T3VwVHk0U1ZGcGtWdmoySjNhZXMwSTlyaC9HL01iT212bXluR25ma09oZ1pk?=
 =?utf-8?B?Vk5EVlllZFV2ektOZUdBdjg4RTdqaFlpL0hXK0pFaUVZTEZGR21FbFNickZE?=
 =?utf-8?B?SktFZEJ5SDJzQ3A2VmgwNGxBa25EZEgxc0ZWd1VaZ2hqcTdRRFk5MTlVZGtB?=
 =?utf-8?B?MHptWXJoMm04dkI1UnhNYUUwRzZvVVFoQmh6ZU9jMEswQWtPM29iYlpuWFFM?=
 =?utf-8?B?cmpmWnhvc1lZN2JRazdkNW4xbjdCaXo2Z3J1c21PdXhQbUJXK2g2MDc0TW1F?=
 =?utf-8?B?Q21pOUR4UlVsTWZzSkFVVkhuaUs0bWs5eEhaQmhjd0dVWlZpMXN1MTM2d2R5?=
 =?utf-8?B?czZtRU5yUGt1N25ZWG1FM05hWEF3a2FtRWVMVWI5djVkUXlkU09DZ0VVZ0ZT?=
 =?utf-8?B?TGlWZ2hGbnVUYWpOVjJPMmVlcEFWTnc4a2FIT01jaGZ2RGl3UFdyYUZIOEJE?=
 =?utf-8?B?RVlZaW5nc3NFMzI3aFY3STR4Mk1tNVgxcWxnRGdncGdRZkoxUG5kMVNIMW5L?=
 =?utf-8?B?UnhxVWd1SDJ2S1Jia2ZZZDU5YTRZMlpMS1Zab3lDUXdFT0drWG1WbTRIaU5k?=
 =?utf-8?B?aHA0aGlpaFBzME5wM2pzeEhUL0dWQVI0eEJlWjhneVIyc0tvR0VYUHd3dG5i?=
 =?utf-8?B?cXl6ajRnaFpIcG5SM1AvNEY5YmpmcFhkWlY3NEVOSENVdGJ1YVNqZ243S2dF?=
 =?utf-8?B?M3lybzVNZ0kxb29IemlEMnVDMzJzekVjTjcyMjYxakxsdFhUWTlIeldBUDhJ?=
 =?utf-8?B?NE5VVEZlYkZKSWNMWHVJZjZxeTNwVlh6MWpKK1RnZkd2YnJ0WHc0dHNaRDJR?=
 =?utf-8?B?WEw3UWJmRkJrbkFHM1dXWmhzQjNtdjZOWjhybVZlbkFyNE9UbTFxL2VjdXRt?=
 =?utf-8?B?bzBqejBUdFpUTk1KRDY0cUh6SmlaV1drSW53ekMvM0RpeG9UbW5rWjlYcGsr?=
 =?utf-8?B?TFJZOEkyMzg0aXdRNFlndHZzS1EvN1c3MFZ5Kzg4UkhBQU5HeEVrZklUMDNq?=
 =?utf-8?B?WXp5Vi9TKyt0U0hGL3JCRDBGWE8zNG5qSFNhbzdodm9SNmJDc1Q4amNPbjlK?=
 =?utf-8?B?anlBaGhzWi9ZU1VtNnNaMnIvQXZsbUFGdUNIajUweHMrTHJTQzFNd3dtYUtN?=
 =?utf-8?B?dTBUbWRoTkR5c25uZHppdnNITDVCWDFDczhNT2RhMWtxa1pmVkNQL21mN0Rt?=
 =?utf-8?B?YkVmYnd3aVJRWC9nYWdKcGlWeVJzUFUzUmV3SWZvcnhHWXNVT3YwQkRjNnY1?=
 =?utf-8?B?REF4Rkd2S1NFNlovTjhLV1BaRXNWdUNjdTNraXp4LzVFMThsSFpEQW5nL1pG?=
 =?utf-8?B?K2VvR29QNG1QcG5TYXk0TXp0T1RvbDdaQW5VckZHREJZZzdGWlhiRU1pN09a?=
 =?utf-8?B?bzdNZXo5MExJd1hqcmZCQ2JvWXZCVnlDR28wQnBFNTlBdTh0ejg3NGd1WDhK?=
 =?utf-8?B?QXFIN1BQMVdCakhFc1g5VEdlZ0NIeE9rVG4zb2hzeVJqQmluM3FYWEtoTFNP?=
 =?utf-8?B?U25UWjhkZGFDb1g3Qkczd2xLTUNNNUprWWtBVUxramdoWVRGV2xhZDhyb3ZX?=
 =?utf-8?B?cS9tOUg1NFJxcUE4eHVmbkFHZ0pNSmh3eDFlQTFVdWFaTkQrclJaTHhzT3g0?=
 =?utf-8?B?c3Arb0ZkSjdDcERvNFlQdWRWdVdQZmQ5Z3BDZWJCNHFHa2hvM2ZMUU1aM0tL?=
 =?utf-8?B?TlJDRVFIb3dFWVNTYjRVWDdFWjQrcHhPaUNocXhZeDdjRTRYbTUzako2UnlU?=
 =?utf-8?B?Z2RVU0FZdDNRV2sveHlUQm05MDA2WnhpRjZzaVorRU1NVjQrY3BNbnFOY1ln?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9180e09-2dc8-4135-ddfb-08de39542426
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:57:51.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLENbm5UIMXmhldDlCzgIhxlFKhN79rvRFb0qJ8B+nHZublXCEWpmsNBDGlg9x6U2UnRfuTEgoPwkXnySmaJkrocqSJMB5U0UH37RXtf784=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com

On 12/11/25 23:06, Jacob Keller wrote:
> 
> 
> On 12/11/2025 2:37 AM, Loktionov, Aleksandr wrote:
>>
>>
>>> -----Original Message-----
>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>>> Of Mina Almasry
>>> Sent: Thursday, December 11, 2025 11:19 AM
>>> To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Cc: Mina Almasry <almasrymina@google.com>; Nguyen, Anthony L
>>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>>> David S. Miller <davem@davemloft.net>; Eric Dumazet
>>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>>> <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
>>> Rizzo, Luigi <lrizzo@google.com>; namangulati@google.com;
>>> willemb@google.com; intel-wired-lan@lists.osuosl.org; Olech, Milena
>>> <milena.olech@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
>>> Shachar Raindel <shacharr@google.com>
>>> Subject: [Intel-wired-lan] [PATCH net v1] idpf: read lower clock bits
>>> inside the time sandwich
>>>
>>> PCIe reads need to be done inside the time sandwich because PCIe
>>> writes may get buffered in the PCIe fabric and posted to the device
>>> after the _postts completes. Doing the PCIe read inside the time
>>> sandwich guarantees that the write gets flushed before the _postts
>>> timestamp is taken.
>>>
>>> Cc: lrizzo@google.com
>>> Cc: namangulati@google.com
>>> Cc: willemb@google.com
>>> Cc: intel-wired-lan@lists.osuosl.org
>>> Cc: milena.olech@intel.com
>>> Cc: jacob.e.keller@intel.com
>>>
>>> Fixes: 5cb8805d2366 ("idpf: negotiate PTP capabilities and get PTP
>>> clock")
>>> Suggested-by: Shachar Raindel <shacharr@google.com>
>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>> ---
>>>   drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>>> b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>>> index 3e1052d070cf..0a8b50350b86 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>>> @@ -108,11 +108,11 @@ static u64
>>> idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
>>>   	ptp_read_system_prets(sts);
>>>
>>>   	idpf_ptp_enable_shtime(adapter);
>>> +	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
>> The high 32 bits (hi) are still read outside the time sandwich (after ptp_read_system_postts()),
>> which defeats the stated purpose of ensuring PCIe write flush before timestamp capture.
>> /* I think he "time sandwich" is defined by the region between ptp_read_system_prets(sts) and ptp_read_system_postts(sts)  */ Isn't it?
>>
>>
> 
> Any read will cause writes to flush, so we don't need to move both
> registers.
> 
> The point here is that we write to the shadow register to snapshot time,
> and it won't guarantee to be flushed to the device until a read. By
> moving a single read in side the time sandwhich, we ensure that its
> actually complete before the time snapshot is taken. We don't need to
> wait for both registers because of the snapshot behavior.

very nice explanation Jake, thank you

I don't know if it should be considered "basic common knowledge", or
warrants an entry in commit message/code comment
For sure we don't want anyone not knowing that to touch the code, so
barrier to entry is also a good thing ;)

> 
> I think the patch is fine-as-is.

given the scope of the function, agree

> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thanks,
> Jake


