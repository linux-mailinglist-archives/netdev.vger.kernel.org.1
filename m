Return-Path: <netdev+bounces-99579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92F8D562C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF41C22AF8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25816B74E;
	Thu, 30 May 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jU7WZcaW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O+FmYFv2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8F4D8C3;
	Thu, 30 May 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111073; cv=fail; b=nnsJcaNrlrvQLN4Wf74c3f2ZxHXWqU8iC9RN0pdPrJ5uzGSB4svDKrPxY1yrfk1cTo+AeRWMP/HaYWq4fNExjxXrpRWmC2sFIeIG4WoRWYdE+NnV033H0gDhu6z23RWgNHKbyaFIXOwMWt7QmIkhZIsr9H+nfr1J1yYy8N+bHGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111073; c=relaxed/simple;
	bh=SvZMlqFMn5xMOBIZ5tVueGywd1ynjpag44AI2eG/Xus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMOWh6UxwcAwH0QYKjMD0cujeUmgGLuyjF9qQ0g3yR8Gnz8+eAzVJWcF75wkXK88gFQqo5tOUmaXhsoKAwbWXj54ZW7XADHlZMavEDoaujZZs8rEKkfc7K8NTxblZ3luwbnjS0Ip1MyG0/aAPP9q3J0fUgb3gaAftBVlXDA2Zw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jU7WZcaW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O+FmYFv2; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717111072; x=1748647072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SvZMlqFMn5xMOBIZ5tVueGywd1ynjpag44AI2eG/Xus=;
  b=jU7WZcaWfeZGdvjY3GiCR/9y157dVUKQBbejT6LXQuA7RotBGsKUFJQL
   8tGO6yunq/cblbE7AlHrzPoRkAECuTpxVefzwQA1knOU6m9bb98PQZMkG
   WAL/xMqlSl2BImC2dFxGTCXz+Q9Ru6nb6FaeCAcPKLx/cw3Et0oHGs413
   JKkXMGXOMfk0gAV5wkUn/7qblCI9I4EtH7QL4zAOghMHLGsffDRgRzwBa
   PL0mnGw+UjmP20KlwKnMLqdKHN6oF3Ul/cOcmpfiQ8HYwDq5POZWTVZL5
   Kxia26KYh29EVodQRC2o7oHokp3qodPAeUAiqLMSv1DYiEtzf+EqjtKaT
   Q==;
X-CSE-ConnectionGUID: ou+cLjLXRRmJxk7+eQVBdA==
X-CSE-MsgGUID: lJIH9mTMQ0CA81CWVZf31w==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="26776129"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 16:17:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 16:17:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 16:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIXMeoyLHxgTvBtrIIwOhajd9KKd/9cJSnbtni2VmJhSB8ngU98hqm7p8fj3qiBF7j8Z0ZGX/QdUDEPk3V/Xd2lTpd/sEFB+URVWUqUSHURdPcqw/UhcTMn3Rg6WbSAE2QuV/RH/NGZkxEecVK2yjFU53fizAPQ8Bx5MLhBNKSxnFC9qgW/q3dZOTr7r9Wz9w2Hc5Pb+Zw1eotP6cDPnIJSFneWKYlZ8gU5Sr/o6Hn4VYrsik3iLdxgCDJruDfWABJ3bqQf/c1xAQbv6BhwZY7ZsBSVpXRYpNu2lWw6gyNqpJmPm2qGqUrZeyglQIHTnP7/5MMtXpqYfue/PZVrC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvZMlqFMn5xMOBIZ5tVueGywd1ynjpag44AI2eG/Xus=;
 b=R3LDFUfRdTesW7ykmc0tX0ZKtXZKAyBjenupKrfLE7Bl4whLHW+dZdE0YqKbtR9tLULxhQTnMjEKHQu7tenrcJyYwx7dMx2tr0tXZftyg655UsPX+mPAYbrY/4GfF26HF+YyKFh8y4zeq8rx1TzaxHlMqPf0NJ9fPbgGruZyDnvqYCqsXb/w6NGurAxHF2t2WUmOWNVRupmfnnvXzKA8+BevZXJ1uZBBuZqmV3EppcIzDbEBaX81q591yL786qwgA+kq7SLwHALOIqQBFlwRCBAMgYKYtC+cpyYM9Os11gszlks0nNvBQx05WNMMn5Ecdq9KGl0vj1WCFHp/bS8Tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvZMlqFMn5xMOBIZ5tVueGywd1ynjpag44AI2eG/Xus=;
 b=O+FmYFv2M8SMUR7Z98nIGSVfff7DxmcCmb7V0bbezbQpuC+gxD8+d//Y+qKMZ/hkoaqeCOW91efDyUT38/WGQ0OrLaxAJE/6+3x0j5yfLRqzoHbif8F97jDvplBvYeOwfbXafGKH6p5ES6z8Gu01rWeBJbi7Jxbxabv6s/GLjd/B5+0hHJvIKHwMGG98jy0VtvZwZOJ1vmNGh5PTu2x+cSCQGHDlHrj4nMMoCsme7lgHrNSwKtUXzv514qJztFJCaFRl2o8Gy2/XkxYXcCJ7mQlAJlcN4THWG3mpnEUfdp3RcFhixRBdMG0hXEFdqeTSdh+zIyGw3zDOr4yJc371iA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 23:17:43 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 23:17:43 +0000
From: <Tristram.Ha@microchip.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Arun.Ramadoss@microchip.com>,
	<Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
	<f.fainelli@gmail.com>, <olteanv@gmail.com>
Subject: RE: [PATCH net] net: dsa: microchip: fix wrong register write when
 masking interrupt
Thread-Topic: [PATCH net] net: dsa: microchip: fix wrong register write when
 masking interrupt
Thread-Index: AQHasUZ25zhfiNNFwU6NFRDozBp/bLGve/AAgADwRuA=
Date: Thu, 30 May 2024 23:17:42 +0000
Message-ID: <BYAPR11MB3558611EBDCD3097B764D2C2ECF32@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1716932113-3418-1-git-send-email-Tristram.Ha@microchip.com>
 <6092d48946628c7e41fff25b161fdb71ce55d3d2.camel@redhat.com>
In-Reply-To: <6092d48946628c7e41fff25b161fdb71ce55d3d2.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH8PR11MB7968:EE_
x-ms-office365-filtering-correlation-id: d8552c07-c991-4aa4-954b-08dc80feb536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NHB0WnhJdFQ1dVBvcWNvcW4zSXpJNU5JTVlUdWFOWGE2SFZCMkxrenIwR3RH?=
 =?utf-8?B?UUFvVWx2MzU2OXg1cVNpSHU4UHFGeTdndUU2QnpscU56blp2MUJiUWJZNmtL?=
 =?utf-8?B?cmFaOUhaczRTVVlWVmU4aGxVVUdhb21OMmdZRlFhbEVzTlVEMjRYbExSU3di?=
 =?utf-8?B?YWtXTy9xaGxoRDhOSStPTnVOSUdXTUQyS1ZWKzZybENpOFlsOEw0THdPczM5?=
 =?utf-8?B?U2hSakp2SDM0cERHckpRMzNLVHhDMWNZQWw1OEpTRDZENUxvekF4SmNEcytq?=
 =?utf-8?B?UnF3MDlVRVBKM3hkbncvUHUwKzlOWTlKejdsTy9uSnoxOUFvYkVTRmZJVlJk?=
 =?utf-8?B?T2I2VHc0MGQrUDRxd1Ezc2RKM25uSVlLczdQRW9qSWtobjF6OUJWTkN4MUsr?=
 =?utf-8?B?d3cwRFFDUEVhSk5UK3BiVFhqb29Bd2E1cVEvU084K2hiTjZNRUJjckcvSjJZ?=
 =?utf-8?B?aXZjMkoyQUV5WVFsNjJUNHJWQ3FPSC9saS9UTTN1TkpqWW9ncmcvZmxwWHdZ?=
 =?utf-8?B?VkRZb1RWbzhGZTJ2SC96OE1lZWZ0UzQ1MGZ5d0hkaGJNOXMwQXV0aHBxanlY?=
 =?utf-8?B?VzVkMVVNKzZZOE1YVXYzb2dZYzhRSloyWDhIbGR1bGp0OG1ON3dqNWQySlBI?=
 =?utf-8?B?dWhweGZMWGxCM1A1ZFFDdDBBSHY5SVpVQmR3UUVVZXhOYmpoV2ZFMWMzMUli?=
 =?utf-8?B?SlA2L2NnV1cwM2MzaVZpVmNHVjFRVVQrdUhVeHkzMzNvMmsrZFVuUkRHRkhm?=
 =?utf-8?B?U3cyWE5jYXhETHMzOHBJYmRqVDRTdlFjaTI2Wlp6dVV5cUl1b1U4bWNHckht?=
 =?utf-8?B?dStqWnRZRnpWVlVZRkdNQ1dlV3pvNTZpNkV0WGxIVWVpamF0R2VBQlhkK09T?=
 =?utf-8?B?ZGVWUnk1M3Jabi9Mb25kamlwQUdTa3dEYVJYTjZZN3JwLzFTNjFOY0RtNjhz?=
 =?utf-8?B?Sk92Nm4xNGhGaHVRNytJYjY3ZXVyVzVYNWJlYUkzMkdSSUI5K2h6N2dCVHZV?=
 =?utf-8?B?OW5WM2QyTWlxK3BHamRNZk5KbEtDeVA1dlRNVEhtVktuRkpRMjM2Y0t5ZlFY?=
 =?utf-8?B?ZWJHc2I4VVdZc0tyUWJlV3kzZnlzcVpKd0F5ZmM0Ry9rZERzbC9nd2NwcGtP?=
 =?utf-8?B?T25mZXdveTJEQU5ueHpYU0kxempUTmZTZ2NmRTFuakxUakRRcFBxbFhGUmVk?=
 =?utf-8?B?c3V0SUVxbHlSTzQ0MUcyVHpnU0ZPcWxSUFlqQWxQcnRjUkRuaHY3Rnc2YXpI?=
 =?utf-8?B?YUEvZ0Y2aXVNNlRpQ2ExYXhNNEVxVUYycE16T1ErZUpXKzR4TVBPRk82dVA3?=
 =?utf-8?B?cjY4Skk5MVdsSm5LY1AzZXB4bSsyTE52S1FOVEZvRkwxV1ZEK3hsUWtvN2Rk?=
 =?utf-8?B?eEtsU1N2ZGwweFpVK3h1Rm41eXdSK1RqMmdKSUxEMnNsc3dMQlZyeGJCYWtE?=
 =?utf-8?B?cmlQMTB5VEJoazNtVGFQUG9qcklNQ0EzQnhEOXFzQlpYWi9WR3RIOWUxb1Ro?=
 =?utf-8?B?cTN6R0t3UHdwNUFGaitXZUVmK3I4VjBIMDV3UW43Q0xtN2k3ai9sL0pjSjJ3?=
 =?utf-8?B?QzBtZlI1VVBPSVRxZXRKMTBaK0J2Qk1VWk5FUVZjVWV5YWljc0d1R2NldFRI?=
 =?utf-8?B?cHRBb2Z5S3ZMc3RRdmRweU1XbHFPWE1iUWNrTEJyUHlrTFJGeXZTK29laUtR?=
 =?utf-8?B?eE9rU0VocWFEbW5hVGFheWRTeTFBSU5vc1lmTjlrSVpOWHQ0TFVLeDFqUURJ?=
 =?utf-8?B?WDA3Y2s2eDdsMEVwVzdUaGxULzYxQ1ZRaFdDWFAwQzd0K0tlTlQ4cTJOMjdz?=
 =?utf-8?B?U1FHT3k2ZlNvODljdkZadz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzdjNkt0eUgzM2dMbHpPZFhzNHhYdW1ZOE9CUkRLdGRnMDFhbzdhQkIxZy9o?=
 =?utf-8?B?S245YWVSWWV6Q2NUU0dUZ2NRZERtODdiZEl4bk1xanc3V2hFRVdpWktHaDkw?=
 =?utf-8?B?RHFPdXp1bDQ0MWE0VXdKR0NUd1IzckI4dGYrMnRMVEg3by9rUWx5ZkVEbWJr?=
 =?utf-8?B?V3paaUxYUk5qOWV2S3VXcnFEekErYmJQUjNyalF0NFcyazFjbStEMG5DUEhq?=
 =?utf-8?B?QkUwRFV5b1BQV2txL3Bnb3BTMDJ3Z3Iyd2pmVXFnUk1iSmxlQ0FJWU1kMFpY?=
 =?utf-8?B?d3NMU1ZLUTVDN0dabURDaWdCUGV5QUlWbnUreklHZ3RtY2cvUEF5UjZydzJz?=
 =?utf-8?B?a0FYOFZtdWxINlJycXFsZDc4TitmZTd1WUtkMnVuc3c5VHpFRFRpZU1KSDNQ?=
 =?utf-8?B?UERCS1A0STd4TEhUSTRkN2phQ2p0VHZCNEtuMGlzNjFWVzJaZm1oUWxxdE16?=
 =?utf-8?B?QjI1VUFhMDRiWnd6ZVQrTGpaTmNXUGdFNjkvaWVaenAvN2tTQXdLSXBpVEtC?=
 =?utf-8?B?SFMwWHFLYlpPeTlYV3ZkN0k3VDl3K1pIeG1DYVRnVXZpYllEZ2REaVUxQVZY?=
 =?utf-8?B?VUlHdFJUNjJKMzB6OE9wWDNwc25rb05ya3JhWXdLTDlHSDN2YUFVK3hDKzdF?=
 =?utf-8?B?WG9UR29RNW9DTjNYckl6SmdEV0Q5RlJnZE81NlFSaGhWQk9MaTI4ZEVwYVNj?=
 =?utf-8?B?NFAxTHQ4OXRDM1h0Y3RyTXhOM0Z3WEdLc3g1Y0gwWWhVZFJOL1dlNmJzZkRF?=
 =?utf-8?B?VTN3ZFdSanJSQ3hvS3ZPOENRWXBVT0lsWVlqTENKaitqUnU3ci9qSnljVC9l?=
 =?utf-8?B?YWE2NkR1ZThpZDJRejkzd1lzK3NGUlhLZHl6UDZMZDZ2V21BcThTelllRy8w?=
 =?utf-8?B?dFJkWW85OElPVXVHMjR6Q0lXZ3NFcVc5OUJ5aGc0YlFsSW1XS0FyMy85OWI4?=
 =?utf-8?B?MFMvb1kzMk9WcHh5VnlpNVNseHEzVDZMaDNhYWkxck1RR3BOSTAvV0M4ZDIr?=
 =?utf-8?B?L3Jsa2JxRzgxa09zOHQwS3RkWkZkdU81MXNzVVkrVGt2S280eS9kZGh5QkM0?=
 =?utf-8?B?NEV2c1BVQnZia1dSS29LMXBRRHMrWjNNa2VQQ2svMHJGTjllYTFva0g4Rkh3?=
 =?utf-8?B?RjhHd01oOTZLZURPQU1MYlVmU2UxNGVRR1lwY0piNmp0WUx5N0tmcjhpR1pL?=
 =?utf-8?B?WUZqNE9mb3ZJTk8ra0lMbFVXcEtKdFpxU3FsZXZNWnROYTQ1cEJibjYwM3N6?=
 =?utf-8?B?WjFoTnduZjJnazBvMjJ4UHpNbmtGdElXZC93eHlyY2RNR1NmdU1YeEZYK0U3?=
 =?utf-8?B?R1NCR0RHMk5xVkorZ1dVeWtKdW1HYUFuR1llMU9OQjRuY2hpSHZhYTVqUUoy?=
 =?utf-8?B?ek9FWjVsa2JTNitOajF6YW02VkJtczdQTTgrcXJhYUtpQ05DUStYQUVBdHdK?=
 =?utf-8?B?Vko4b3QzOWk4SVRJNkdYRE42SlBGWDVZd0tIV0hwYXljVFlhMUhBSi8xRmRV?=
 =?utf-8?B?QWIvdnN4YWV6SWFNWFFGeHZvOEE0Y1pqN0doWnpUcndjVFZick9sOEJuaUEv?=
 =?utf-8?B?V3VxeHlwbFdwQ2N3bGh4dUtlcE5rMnYrU0Eza3ozUGNoTk00ditUUFZjMHc1?=
 =?utf-8?B?WVJBUVdSTEIxNEhwckZVZXF2d2pZeitnSzRLQkhxNC8waVJidVlqUk9PVmlG?=
 =?utf-8?B?a0UyN2xoVkU0RVJpeDVnTFNMMnFKa3hpRFVZYSs5Z2Z5dGNFWXI1MW81aGdW?=
 =?utf-8?B?em9JdDhWRTMvRUc4WlZvSDIzZU54S2hlQjVFNXFvZENtSjBXMkRJckhVWmZX?=
 =?utf-8?B?Uy90YmkyUzhid0NKTkpoSWhGWWFOWUllRFQ2cDBxYTBEQ0xYTnJVTGJXdEdG?=
 =?utf-8?B?N2RPT05GYkd0TUUvR2VZM2h5bytZeTNqR3JXY01UQkE1QmhRMk5iU0d3M3NG?=
 =?utf-8?B?cVdoOVVlUGxKalNnQkpid2tCbEJrMHFlTG9RMnI1ejlTZFNLSWRxcXR4ZndI?=
 =?utf-8?B?VEYrZXZVeER4T095dWYwd05zc2dSVEhZdW1WSWZKRkwwYkxTUXVBaEFlRDg2?=
 =?utf-8?B?Vkg4S2N2cUUybitZZG1NcWU1RUNyY093L2Fwc0xPcUNOdlFjSmI0YVpkT3VT?=
 =?utf-8?Q?1aJUlxQFk5/BhM7RXws+vskrT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8552c07-c991-4aa4-954b-08dc80feb536
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 23:17:42.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPTO5AEndLEZpj8utcnYebEX5yYz7dy5kT0Y2ki1Ydx8zDno/SLxByy40PO+eCqOm75IunjmgIBX1L7peHKwU/sUb1Yy+GeaRqegzFkN4dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldF0gbmV0OiBkc2E6IG1pY3JvY2hpcDogZml4IHdyb25n
IHJlZ2lzdGVyIHdyaXRlIHdoZW4gbWFza2luZw0KPiBpbnRlcnJ1cHQNCj4gDQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQNCj4gaXMgc2FmZQ0KPiANCj4gT24gVHVlLCAyMDI0LTA1LTI4IGF0
IDE0OjM1IC0wNzAwLCBUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiA+IEZyb206
IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KPiA+DQo+ID4gVGhlIGlu
aXRpYWwgY29kZSB1c2VkIDMyLWJpdCByZWdpc3Rlci4gIEFmdGVyIHRoYXQgaXQgd2FzIGNoYW5n
ZWQgdG8gMHgxRg0KPiA+IHNvIGl0IGlzIG5vIGxvbmdlciBhcHByb3ByaWF0ZSB0byB1c2UgMzIt
Yml0IHdyaXRlLg0KPiANCj4gSU1ITyB0aGUgYWJvdmUgc2VudGVuY2UgaXMgdG9vIG11Y2ggdW5j
bGVhci4gSXQgc29ydCBvZiBpbXBsaWVzIHRoYXQNCj4gdGhlIGN1cnJlbnRseSB1c2VkIHJlZ2lz
dGVyIGlzIDggYml0IHdpZGUgYmVjYXVzZSBzdWNoIHJlZ2lzdGVyIGFkZHJlc3MNCj4gY2FuIGJl
IHJlcHJlc2VudGVkIHdpdGggOCBiaXQgLSB3aGljaCBpbiB0dXJuIHNvdW5kcyB3ZWlyZCBvcg0K
PiBpcnJlbGV2YW50Lg0KPiANCj4gSSBndWVzcyBzb21lIGRvY3VtZW50YXRpb24gZGVzY3JpYmVz
IHJlZ2lzdGVyIDB4MUYsIHBsZWFzZSByZXBocmFzZSB0aGUNCj4gY2hhbmdlbG9nIGFjY29yZGlu
Z2x5Lg0KDQpJIHdpbGwgY2xhcmlmeSB0aGUgY29tbWVudC4NCkluaXRpYWxseSB0aGUgUkVHX1NX
X1BPUlRfSU5UX01BU0tfXzQgaXMgZGVmaW5lZCBhcyAweDAwMUMgaW4NCmtzejk0NzdfcmVnLmgg
YW5kIFJFR19QT1JUX0lOVF9NQVNLIGlzIGRlZmluZWQgYXMgMHgjMDFGLiAgQmVjYXVzZSB0aGUN
Cmdsb2JhbCBhbmQgcG9ydCBpbnRlcnJ1cHQgaGFuZGxpbmcgaXMgYWJvdXQgdGhlIHNhbWUgbmV3
DQpSRUdfU1dfUE9SVF9JTlRfTUFTS19fMSBpcyBkZWZpbmVkIGFzIDB4MUYgaW4ga3N6X2NvbW1v
bi5oLiAgVGhpcyB3b3Jrcw0KYXMgb25seSB0aGUgbGVhc3Qgc2lnbmlmaWNhbnQgYml0cyBoYXZl
IGVmZmVjdC4gIEFzIGEgcmVzdWx0IHRoZSAzMi1iaXQNCndyaXRlIG5lZWRzIHRvIGJlIGNoYW5n
ZWQgdG8gOC1iaXQuDQoNCg==

