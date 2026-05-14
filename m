Return-Path: <netdev+bounces-288037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BJmHq76BWrMdwIAu9opvQ
	(envelope-from <netdev+bounces-288037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:39:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CE544CF8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B424300F52B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F68335568;
	Thu, 14 May 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="la5j9l5a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3443016F5;
	Thu, 14 May 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776748; cv=fail; b=evuqpwXUTenqBsFAAPlxhX8bWVTqLgHzkgYn5mHvkwbcLOU62MR8jmw6zNvgsFdQ2HUWp59vmU+fVAtJ6nkOHHakK2r/9y9KdfCkRoP4pexnqpI3KqLq0B9Msm3SojkMh0QJ8rq865HqpyMpo8DFape6GiJjwQH36Bslqxp4sH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776748; c=relaxed/simple;
	bh=cls7IPinDAJ4b3PTL8XCcu0rl21Ew6Pr39r4QM3qoI0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEIKyEzVpD7Is5q4/inT35imf8wRm0Ef8n+yQFgsbPPihxnVh03z6DOx/BUf6az+IZyQLvyu0Yc5uPKl73QgpggbyOPcbUZBty2X5xFUuNh0kaY+XdMcDKF2Az1iD2igFFWH0vYoYPCDafwwWsoor2hoVLm6BF15VoqKfSe0ov4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=la5j9l5a; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778776746; x=1810312746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cls7IPinDAJ4b3PTL8XCcu0rl21Ew6Pr39r4QM3qoI0=;
  b=la5j9l5a8qzu49LYQCjOO/u5HJev850+9fAg0XtsgvY/yxMspeywBUce
   nnZ/W9IxCmqs9VbC1mibfSnzdPOAKaFyFznQ3Zf7pAyxY0qXKvo+SAetu
   uoB51lAiDMbgTopwf2cJuAz+JNbx/02xzYI1EfDqh2VcWkrObWzFevmc2
   NXJaX4EqfFgj6OiRaZy5LSgsZTBU13smsHFIX1vOHLSJlROMJuK1JCjuV
   YBpkBrg4oBPBOUmmYNpwGzOXiE2SKXXB5/FPpxzxF+7+6w7NiMbLalHGB
   kbtRhQhUsq8/UWM06J6suN9pjhM/PATmVx/fXiMffeJcr6d+s0pbkL3Oh
   w==;
X-CSE-ConnectionGUID: bcMsaw/ASnivNtRy0/qWCg==
X-CSE-MsgGUID: S+XkDeTTS0O0uScO+rWxDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97297730"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="97297730"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 09:39:05 -0700
X-CSE-ConnectionGUID: 8cq09PghQLGn8tLqRF0WUw==
X-CSE-MsgGUID: EX+UGtKNR82rsN4eDF7OAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="233995058"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 09:39:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 09:39:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 09:39:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 09:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTaTZ5aTGK/1W6pJvPDMWiIoottPNbKnB8i7DVHgZrHCBPVWFSqCMIFnXXN/6Mv47o0g2cHCNExqVpoSfM0wHU4vE43+DKoN7X4dtISNk570JXBOiydGHzxyeFe337+LIehKFFTPLx9PgvmABdkMr+c1knYeRA/6ZiRRdWey0xIGqrVEF1erSf+3Qu6MY9NXrSBnVxto4hPV2N1xCzFti4FCLeIahn7ooRO5mR4x5Eo7jIuqfyOeXM4QWwmnhQ1Faw+MHHvj0o/alWq4oczEdJ4g1uEYiHQdmxlFttgkITu3YZVwnb1Nmfpqxt5FKTs9AIvOXLnTJrcfjYPlAVGyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5IPGtMTr36U0PQ9/cgM7SuFHGMjQUvHJU9qcrF7GzM=;
 b=S5kW4StPj7peBoUMZtOQbtNjMjAndrQl5vxELrR+H11mIn/y9UJw6fZ3bdZHNs3tbBv95TFQpYfKfpg8nNXaqF3nDc0F79FJLsJF9xVYai97j6uc5n/PpClYYms7IOENCH4Y1afUJrwhKfh7wHPhbODoZ2ltN03RwcCiGV0ACPonBCzSZWDhWAs5XqW8f1uSj/e7cHUfkJc4kYssY98yKtFh8WzDgDgvMYxVHrH7WtD+QCNLlGZXOCqrV5YaOqlXXvY6AH8yH5IRh8d3t0T7FNbowyQhzplJDnSAxVBj/EWkcD94lnSBwWWMhx0Xv8OxX8KebGKQ52ZI9YSeVVuqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by SAVPR11MB9549.namprd11.prod.outlook.com (2603:10b6:806:4e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 16:39:01 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9913.012; Thu, 14 May 2026
 16:39:00 +0000
Message-ID: <c579daa4-2144-4524-b107-6322281f5209@intel.com>
Date: Thu, 14 May 2026 09:38:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ti: icssg: Derive stats array lengths
 from ARRAY_SIZE
To: MD Danish Anwar <danishanwar@ti.com>, David CARLIER <devnexen@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Roger Quadros
	<rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Meghana Malladi
	<m-malladi@ti.com>, Kevin Hao <haokexin@gmail.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20260512060627.3781329-1-danishanwar@ti.com>
 <20260512060627.3781329-2-danishanwar@ti.com>
 <CA+XhMqykBWcMdk+iNnOtUxM4MX6jpDyUwfuAVZFbjAShO9_v7Q@mail.gmail.com>
 <6a1f411c-d7ed-463b-abf1-277d8cc0c184@ti.com>
 <9fbf6682-b521-4b7e-b5b6-af91694ed051@intel.com>
 <e28d2931-004e-4935-a0b5-d554ece76fb2@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e28d2931-004e-4935-a0b5-d554ece76fb2@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|SAVPR11MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: f2476586-d0f0-4103-c36e-08deb1d74cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|11063799003|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: NjQG7c4amekimMB5id5Lml/UV0xfD8M3uPz9LcI6s2xEq+gZ79payMybkJTpeCdtfZoERY2wOMo+y6Bj+4mvm9YAaoX17M5M3IqIdLguO/tbdd2NeJ0Uxp8JTvg9+gsqSSv7Pw17A5ntJx2S7fcEoZCN8sHzmUpQdkmjHXnJcenP7Qw8UqdL11SwwCmigfGiKa2JHIT3Hsnry0KBMTEk8zgJ+NSrVaXtdk9aluM2B1QxPaQ2NgLF7nSjfrmh+IQ5SMZpvqP2IQa0tCqgwRglLUpjfmqy2+6NGEv+E3s6d83Emvj6FbF5bmDoFbgbaWR9Fpal7pXQ9r9OVdRYFOO76DXgflFpL2uD9SLYi3H1wv3lh+bww71Wi+HhWNIhFRn3648jwO+yR9z9MvRF40AOFm8hGYYIEDKenpJT4ng4vmj5DKKb03r8mDfU1oi5lnkEWbsBGD7lQ4f9hqHFKGTKl+2ZxQPJpBui6fPryKHYki5ARKwSLudSz1ImN9Uw3JfC2cXkdJwA+MPu3PYlQ0DevaN7b0oyan5BW3LdfcZXfGkKopMWoAXNJawZSvJeersP0fEydms6rqtKPcvsi0mkIO3WswfkxiCDkafClFZdze01pMY+EYiS07Ddou5F/uqCldJODrTIcLFQYaqjJEG6yB3MiDG+4DCMRM/aXPn/EY7Tz29FwvtrThXBDjCaXYIY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11063799003)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjRHdTdjYjhML0FWNVNFQ1g0c3BLcTVEY1R6bzFnQ0VyTFFSY3FiZWcxVHBu?=
 =?utf-8?B?Z3JVWXJYajlmSEhIK0hTRkMySHFLcEwwNGJybGxOR1pqMVlRR0JXS3BGdVNo?=
 =?utf-8?B?ekg5cWlydnpENGliS0hMWWUzOFh6b2VXb00zWnEwU0UrTnFEOVhzM3RoSmpQ?=
 =?utf-8?B?QTJSSTg1VTlibGV6SVg1YXNFYlpoTUZHS0txT3c3UkNZeXV2UVpFQVNTYW9k?=
 =?utf-8?B?dFdjWnI0RThvT0gvR3Z0NkUzeDlJQzhXUFlQeXJIYU1oRTQyZWNHaEk0aTR1?=
 =?utf-8?B?ZzdJaG93ci82dW14ZWE4ZDkvYUVhbG82M0RFeXZ4amxWenFHL0dzekVzcDUy?=
 =?utf-8?B?SDFJcXpjSVRnbHZlSTgwSnM1UDh1MTZlYkFQRjIxWWE2akhkRHV3dU5Zb1JU?=
 =?utf-8?B?enFnTllrc0prNFcvZEkvb2dhQTF2akNkZm13cGNQbG51V0hTM1hQcENWRmh3?=
 =?utf-8?B?NkV1czQ3VUtKY0oxTHhMNElLT012eW16QW9UdHBDOEE1YWpONjQ4Z0VDbmNK?=
 =?utf-8?B?eUorczE1b0VIbTFiUjd0UDhIWXlRWVhHeEZvMXMxeFB3UFRCMTNEeWdBWm5V?=
 =?utf-8?B?L1dnaTNxUVZ3d3V1QmxhcDlTVEhtYTZ4MWtYRUJkVnppNXMwek9mWm9PaXd4?=
 =?utf-8?B?ZFYrT1NmcUZybXpLN1g0cGx4dVFuSFpQeFNITmVISGNWM1EyK2FBQUpCNWpl?=
 =?utf-8?B?MnpvZGJxRGJQVWUrOE4zUzVuYW1XNmxsVDM1VE1MYTY2TUk4VXQ0YjNEb25P?=
 =?utf-8?B?NlMyaDVIc05kQ2NUN2pCaHZ2N01Fa2ZJUDNKbEY0T1VYNXBDeW1KQmdTNXdY?=
 =?utf-8?B?aHBkbVIzbm9nczdxNjRSMXg1Ni9KcjMxM3B6akk1c05PMUVpS2liOG1oMUFC?=
 =?utf-8?B?Um8vQ3hwOEJoYXNNbUtkTzFUd2Q1b0RLYWU3V1ZhUlVYTzhqaWNtVFNsSEZI?=
 =?utf-8?B?Q0gzZHRHWlY4dk1yRnVyeFdSMmNjQ3hxR3lMVm4xV09FRHFKT3BnbTFzNEkv?=
 =?utf-8?B?Yi95SEFLVnNtZ0RXQTZYckpISGFzKytxblMrdG4vRVlYZFBFSzJKaUFoUUxp?=
 =?utf-8?B?R2RtTFU1bHkrQUNFOG13TENCZm1Sa2xYcHorYW9YUWJoQVU4TEVtbG1YZlF1?=
 =?utf-8?B?eDlDaWRLaVE0UEpPbUQrTHhic0xwRGFHb0ZpdG05MlliOEZBakhkUWY5T0tP?=
 =?utf-8?B?OTJHYjFJWmxZSTNrSDJlSEM2enkrNW9ZOUlTaVk0STdoV3FnVlBxb0w5WTJQ?=
 =?utf-8?B?SDRpVCtXZGhrZDhhb3J0RzhJUSt5MlNpY2lBZ0NOVWd5TFF6Ri8ya3d4Viti?=
 =?utf-8?B?N0Y0VGY2K0ZhNCtKN3JNdEgxQTFSbE1UV0djVEdiVUxySXRYTVhjaGUxQWt5?=
 =?utf-8?B?ZGliMDVPcHZvZFZBdENrdld3WFpDK3BRZXFmTzVpd1BMdnVpYzFZNEhkS0tp?=
 =?utf-8?B?Y1RRZUJwWkNiOER3RUQ5NTBhMDlPSTMrNmpqbjVYYnlQQXV1QTZhUFdrcElZ?=
 =?utf-8?B?clhiMXJybUJ5SFc0UDRBbExJc3luS1NuWjNyRVBya0RObTg4YURiYVNqSzdF?=
 =?utf-8?B?NzBaNUhCNHBlRjVTMlRERUhNT2xnVlhVRHlpRUk1aXRhQysrY0psb1FKRzVz?=
 =?utf-8?B?aS9OQVRvenBHU0NYSFRidkxTbjlPUWtPNmtTUmp2SHlTUit0d0xWRXhvQ2x3?=
 =?utf-8?B?Q3FIUzJxQnorU254aXQ0anZJMVhpVkxXWlVwUXg4V2R4M0pBYndUWmNuT0Jx?=
 =?utf-8?B?RXRsM0hpdHVsdmlwdGNZbkhoZENVdkp4d29iRyt6TUU2RVhoajR2QkVBVHE2?=
 =?utf-8?B?Mm9DRVN0OXNKRVZrWWRRcmxHQnZnakdydDJvcHdyT01vL0RQMjYvZGJuR2No?=
 =?utf-8?B?NGErMWhhTk4zM2p0a3pMOER3YVR5TmRIa1dTRjlXdlFPdzBNbm41a0pxL3Jk?=
 =?utf-8?B?R3p1eTU2dHJBa1VuL0U1TFFSb3ZoSFg1T1F1dWdUeEhLZEZxRXc5Y2lqdlhz?=
 =?utf-8?B?Zmhod3l1ZjNPSTJreVV6ZUxxMG40V3ZUSjMxenlpMWxpbjNIMFcwaUZoajR4?=
 =?utf-8?B?U0QxNlo4OTNVYlVKOTB1RUpiRHJ4cFZ1L3lXakp4R0dpYnVLb01WdTlaZUN5?=
 =?utf-8?B?ZkdvVTdVTzBodGhuSno2d3ArZ3lNWTFhVkE2MC9LZlU2UGNzS2dSMnphQUFV?=
 =?utf-8?B?RW04dFpkZ096Tk9YclM2eVlvWHZxNFNjWFJZM1JtR1orMThFOTVobkFRK2hk?=
 =?utf-8?B?bUtyVUIwcEtGR3pmQ2pzeDZkeHowUFN3Y2R1emNvT1duQ0xGTFZnbnFWSmtq?=
 =?utf-8?B?aGhmb3dBOW84b1dzR1NGMFpyTVRmcWRQNVlYdXVBWiszd2pnVDJxbjMreTBz?=
 =?utf-8?Q?p5OxOf+KDI8q9UHI=3D?=
X-Exchange-RoutingPolicyChecked: WUJWzRFfB6AJInA9yr3gGeQrsJXH8/voLDA2EMP8W0MkTqohZSi/KVE3t2Ej248zJ5VNK3UEP5klaimAkoDLSriHGnfvhc1j33PZnDOO6STuQUDnS1wbH3uizH42qEYAH+vcXFGvFk/SZGbafjeAL5uR7L05hTFDhzorfI5GTFH+Hjxva94inneajiKgAYATayfFlSf5h42HdX6Qbu4SAaTDsFVrWyK+7GHNVe38M58hqCVeWdxu18dZSPTl6tV24Gkgr6CZAJdkXYYcYFwkuCWc30b6K77PzXLWUxp3TWt33zmiN49qUnzeDQvHBcnBuHQA3iawRfzk3mrXX/nmYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2476586-d0f0-4103-c36e-08deb1d74cd9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 16:39:00.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYHtrteL/b46R+5vL/CrwXQ5ZPfJ2VwTLq6VKq3O9tmKS+I8jUa0flHs6XZnQavtS0d10JAxpNfxcQCd9opgSfoHntTnbWm/LAkK05lS2DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9549
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C76CE544CF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288037-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FREEMAIL_TO(0.00)[ti.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,ti.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/13/2026 9:56 PM, MD Danish Anwar wrote:
> Hi Jacob,
> 
> On 14/05/26 1:30 am, Jacob Keller wrote:
>> The way we solved this in the Intel drivers is to use a single array
>> which contains both the stat name as well as the offset from the
>> structure where the stat resides.
>>
>> The stat string code just iterates over the stat list for the strings,
>> while the stat value code iterates the array and computes the stat
>> address from the offset and size and base structure pointer. Each object
>> that has stats has its own stat array structure.
>>
>> This is probably overkill, but the advantage is that the strings and
>> their values are stored together and adding a new stat is as simple as
>> adding a new entry to that list.
>>
>> I.e.
>>
>> struct ice_stats {
>>         char stat_string[ETH_GSTRING_LEN];
>>         int sizeof_stat;
>>         int stat_offset;
>> };
>>
>> #define ICE_STAT(_type, _name, _stat) { \
>>         .stat_string = _name, \
>>         .sizeof_stat = sizeof_field(_type, _stat), \
>>         .stat_offset = offsetof(_type, _stat) \
>> }
>>
>> #define ICE_VSI_STAT(_name, _stat) \
>>                 ICE_STAT(struct ice_vsi, _name, _stat)
>> #define ICE_PF_STAT(_name, _stat) \
>>                 ICE_STAT(struct ice_pf, _name, _stat)
>>
>>
>> Then the stats for the individial arrays are defined like this:
>>
>> static const struct ice_stats ice_gstrings_vsi_stats[] = {
>>         ICE_VSI_STAT(ICE_RX_UNICAST, eth_stats.rx_unicast),
>>         ICE_VSI_STAT(ICE_TX_UNICAST, eth_stats.tx_unicast),
>>         ICE_VSI_STAT(ICE_RX_MULTICAST, eth_stats.rx_multicast),
>>         ICE_VSI_STAT(ICE_TX_MULTICAST, eth_stats.tx_multicast),
>>         ICE_VSI_STAT(ICE_RX_BROADCAST, eth_stats.rx_broadcast),
>>         ICE_VSI_STAT(ICE_TX_BROADCAST, eth_stats.tx_broadcast),
>> 	...
>> };
>>
>> (Note, ICE_RX_UNICAST is a macro that defines the string value.. I don't
>> recall who changed this to macros or why vs just having the strings be
>> directly in the definition...)
>>
> 
> Thanks for sharing the ice driver pattern — that's a clean design.
> 
>> This is probably a lot bigger refactor to make work, and may not be
>> exactly suitable for your driver. I've considered "upgrading" these data
> 
> Yes, I need to see if refactoring is applicable to ICSSG or not. I will
> look into this and send a separate patch / series in future if
> applicable. For this series I will stick with what David Carlier suggested.
> 
Makes sense. No need to bloat this by more work immediately. I just
wanted to point it out.

I'd like to uplift this infrastructure into core helpers so that other
drivers can more easily benefit without duplicating the scaffolding, but
its always been a low priority task especially since the private driver
stats are somewhat of a legacy/deprecated interface. (Maintainers don't
generally like driver developers making up their own statistics...)

