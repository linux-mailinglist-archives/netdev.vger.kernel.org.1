Return-Path: <netdev+bounces-290547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JMXMnY8D2rQIAYAu9opvQ
	(envelope-from <netdev+bounces-290547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5E5A9EC3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03CC432C9642
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA9356777;
	Thu, 21 May 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="woSc3Wsj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DED35AC1C;
	Thu, 21 May 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378134; cv=fail; b=MPeqPgqRS5E8U86VZwd8lFgHeGIPBXF/WjmWbL9+I+bGiracAElEZUa0mJMt8WmQXnWZxAQAsBROzQbUn3s5aAaqHto8bUYiuR+kRDvncdsUtqY9jNXm5jKqTSQxS0jAf/b1uCKXvlBJNldE5zL4MeGRDjxmr0rPtz7FincUtPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378134; c=relaxed/simple;
	bh=x9LQfD7dWNP1HcKD6oF2UGdlNP4Ibcq2uMCY7HxNfpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VXIR9+IhEVUdU7Rcl2s4Wb8k1/Q/7bCNcYZ8YcQphKXTvsLDpEXhRVuoApRjfLwBKWqfIj55P86VuDcyb5UZGTitdhIxS2Yw+H80CzUD4vdDBQdFjz5PlNMjN3aLfSvkvYVg7NV8icFUcnSXjxDf4yg+RFHmJG7TcomT6PZnQ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=woSc3Wsj; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces1;
  t=1779378133; x=1810914133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9LQfD7dWNP1HcKD6oF2UGdlNP4Ibcq2uMCY7HxNfpM=;
  b=woSc3WsjNV3QSBO5aJRoFOpa5B+86XIbGJTqi7O9u5tD4XJDADXhd50+
   XIrvroRQ0Roiswo+OTIq7/vBVg56iYS81CNGFVXmq/ukcpHAZBNFlOi/t
   49DxxWIpgQzTh7xseBRDuu71HprGPh0ISTARCzPQTlwzqHaCHhmieMRci
   g=;
X-CSE-ConnectionGUID: 6ZsGqmDlQSKA5ynRzxIZzw==
X-CSE-MsgGUID: Om05W6fdQHKrgbj9e8plig==
X-Talos-CUID: 9a23:sIxdS2O601BFOe5DBht821cRNsQcSV70kWbWGV2oKFR7V+jA
X-Talos-MUID: 9a23:30BfnwklpvHI1QU8VPjpdnpFMZ813PqgBHktso8JscvVOHxoPzaS2WE=
Received: from mail-canadacentralazon11020112.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([52.101.189.112])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 11:42:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgGJ8K+lVlxD62PwCdgMYbL/Ll/QvrQ4FnZJJSj3rjtYYfJpDDf8KARjZHtcu28DbyoLxSZdxmfnJbro4dkKrqxnje94A1vMVzexWbRCdyROS36twt664K9IjPqGxd5t/2Hj73Y2iD6Dc6kN6N5rpdr4J33zOBqapDBxqG/4DKY0tpOYAIDCxCAgf3oDhADOPMopkf9SKBGZ/ou0HQwLlfKsZ8LEFrKnQOxE6P7mrMO1UZTe2kqTSODHdLA4wwafT89aqir24XA7+L/DbLDI9jhiYkXy6dVJ8RDIKBJWTWuw5VBac94ZZdjoSZeJUR64HKv0zHudjUZ4pXJqdxn5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+EADSV/3+XjRnWD5wgp4tk3GT7Z2InH0MEBHsTwQEI=;
 b=GVs8B+zl4Cl0ZZhZNGh9v460Hz+hOuvQh4fegd1Jp05ROD8tJMLVFrO852ZlaUSbWJNLyAxOtiNngJqUJVtPKp6PGUzRNXvLsw+n35OtDsWhF9fFwfx2ANfr/b/Lfsh2A5RIjHCzg/Om8WJziGKHJTLtLQzy0uv78C7Tvv/PTWe3zPl7EFZF6HRKEk5GCIU1Nqftrz+m0SO+kQfxmQmtyaomG00n/2BQCsWuAHKaaQipEXEC56IrSNQQADDiE0R16f5anXHvu4fjXy1UVGDemNMSqnWfHPuNZrTdnALHK2skh/pBC7DUuoV431XEC53XHAjSeDJ1M2fKngq57gigjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB9062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:bd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.7; Thu, 21 May 2026
 15:42:05 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa%6]) with mapi id 15.21.0071.005; Thu, 21 May 2026
 15:42:04 +0000
Message-ID: <b785b518-3a76-4058-ab76-644df400cd0a@uwaterloo.ca>
Date: Thu, 21 May 2026 11:42:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: napi: Skip last poll when arming gro
 timer in busy poll
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, =?UTF-8?B?Qmrvv71ybiBU77+9cGVs?=
 <bjorn@kernel.org>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
 <780d21ed-4ab3-478c-a932-6feb7aa6d7b4@redhat.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <780d21ed-4ab3-478c-a932-6feb7aa6d7b4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::30) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2030b5-0ba5-4a46-172e-08deb74f8218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|786006|366016|11063799006|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d/cu5xbQMeBBwlV91uxYCLOsX5WyPuOa50pp1asHIVJlCsAL6sanKkHzJ9WqDwoCpVelePc/AEXlU4BOljUvSsWxw9lAuR/2W/FKEtxCF5tHBv+v4x/7ov5uI+87dOAksVNugMXATDiSXx3dzdRUg2Zb5dXIOcr3ZBV2G03I+gXkMMeHfQmD6JxpN7RHeKUwkqvC7aHs1MMvM7PAxaxRIQGBFDYS9b4QNZZRZg0D4zFPaMP5z58n8K1C1KW9ed1AlgGz00K13p4dE6Nbo52HveS0RdfKWe5hCJHgawT1KGOaih7/RCH8DfGlcqK2nsAA075aEv6WEJii1xN1stMtNmnj32VbIsqaKtGW85PQvVnrmcjrCjLEjeP9z1DPE8em1cfeSPmpcnLlb1trFM1SP0MKKBUuQtlsd+Tb5oc+wyGzn7VQlEFq3stvlHhjtIcZtaJ7VAq3zNKr+VJ0bv27zvw12rM3QwlhrCycKZB+VqbmJWnne6zEZtbGojp8Smx29kzWGT0ilgkF9uLwkyRCd3K2E5Y5YbmrtbIhNfDj3yd940VLWDvTQqw0yVV0GTcWeo04MD9/HEi8sujuBbBw1jA/LA163qT7OALp9hZyHQr3fMTOSBG0fixZG9ui/DI34RPPT7i3+CrLO55mj5HrSpwWdKQxhydU7bNilqKpcKU8i6u45zsFr70JO9pXhypD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(786006)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjlsQlN2QXNhTjRvcW5vdW5LWXdTbTQ0eTVsZWJaM3FkcEFLQ2xpUzFDdC9D?=
 =?utf-8?B?N0JidG14MkRDMWlrZzMvVW9xRUZtTHh2bm01RmM0TjFHUGdnUTIvSXg0bDNH?=
 =?utf-8?B?VnBibVVSOHBoMk5VR3BJaTRKb0FsRk05ek1yemRmaHlNUHRNblh5YzVncis2?=
 =?utf-8?B?YkNDaGRBSVpYYWdyMXBVbFZkMnFGMFduVC9VTE1UeHlGTy80Z2RWUTJESTVl?=
 =?utf-8?B?Wms3SWk0amNXdXJ2a0FVUTl3Y1JiVTdVVFk2UVk1UTF5ckxrYTBpLzhBMTE2?=
 =?utf-8?B?aGdhNkVPRzM3bkZ5QkVsRnBkNDNYRlBzQmNQZnZOK1ZGclBjN3NIZXdlWGJD?=
 =?utf-8?B?dTd6OG16SG1NUksyQU9pTnlRM2lVVG1wUzlIQjVZM1hiWHM0RjhOL0FxMGdq?=
 =?utf-8?B?ZHdlTXdRWmQ2cUNPa1pvTEtUdGJPRWE0VzhnRmpmMFdzekUwRzhIa1VHK2hD?=
 =?utf-8?B?KytoRHdWZDlIblhTZnZCc2ErSVJUTlNvODk3OUZ1Qm9pOEpkQWFFTTFabFJ6?=
 =?utf-8?B?cyt5WTNTNXJ3bGoxOEljVUk5NzBBYmUxOUlrQkhmSGt0b0tEdHd6ZDNjeS9j?=
 =?utf-8?B?ZFZtc0QrK3Y5ODJER1EyTXBXeWF2Y3pGNjliQkw0clFqSFJCNDR4azc0ZEth?=
 =?utf-8?B?RTNMVTE4ZHdnaTRPYnB0QzF5U21SMlNFdElIcUFkOGRtMzFjZi9FaGl6Qk1x?=
 =?utf-8?B?UXZMaWlPZ0RjSVlOUU14cWt1VkRvWm5RbVkrb1NkakI3U2xpcTJSVkdiQmJD?=
 =?utf-8?B?MFVLZ3VoS3dzSmJyMytaWDR0VXV4cncycFlnZEZTeG55b25LK2RnVmdMNVdJ?=
 =?utf-8?B?OUlGdW94d0ZNaW5tZHdDZ1hSZDhjaTBNOUtUb0diR3ZHNUo1WEFuWjhRQ0Yz?=
 =?utf-8?B?YzIzZThzdWNhV0U0S21zY292NE43OFJNZ3lOOE9uVkdvbDdJNTRRVXFpY0kz?=
 =?utf-8?B?aFZRWWlBbDJaaUpqUmtGb2duSEFWdlkrSUxPNDVmUzN3L3BlZ3ZoL0RJajJN?=
 =?utf-8?B?VWhySlVqWDJIZ3MvQkYzS3dYYTRWK2NEb0w2WFMzbTJKOEN4UXlNZWdYZ3JR?=
 =?utf-8?B?MWpXMWVJcnR4bkxrOW1sMG1NMmRURTlSYjM3cVcxcU9iZS9kREFjSzdLTGpj?=
 =?utf-8?B?NjVJeVc2bk9MaW1sMkhXV3hVUWNNcTRhMFFVTGN5WUZZTXFYN0RwU0FYeUpP?=
 =?utf-8?B?bE9aYzU2NGRWZGZYNnhDK1R3V1BibWNWM1diUTJtNkZnQ3R0bjNiNWtST1R5?=
 =?utf-8?B?ZktGMFZwSnIzbGRKQVBZaXRmVjVwdll0VDR2bW5LWTBaR0Jwck1EanhxVkho?=
 =?utf-8?B?cWY3bkk4SzZPbklMSnpqbWNZS3NMYk4ycVBQVUxOV3lIV2t6b01hTWZuTTd1?=
 =?utf-8?B?aEczVlEzTnpibWNEcnR3RWVXMkFFR2F5d29DQm45L25wMkQyQ3lWRzBqUXly?=
 =?utf-8?B?RzZzY3FuUnk2aWJHbmFHZkhmb3FpQ04ycWhzakZsWVk5U0FlWEd3L25sWUhr?=
 =?utf-8?B?QnFMaFY2UlI1alk0MVE0S2tkV24rVGwxWnFRSmk4dWRyazRVMjFKM3Y5M3pQ?=
 =?utf-8?B?SURnTVg4bE5IemwyemU5dHlTMGxvaERnVDhQcWllQ2M2aHJhTnB2TkozZTRJ?=
 =?utf-8?B?V08rVi9iMGx6ZWhMcXlNVHU5dm1ibzFTWUIrUUZ4Z2Q5ejZEaHMzb2tQNnQ3?=
 =?utf-8?B?OXJpekVNSUFFYVFaYTd1NFd3TlBLMDdrVVRZK0g0dk1adUhnM1YrY2srQ2xy?=
 =?utf-8?B?YURBQXB3c3dEWmVhclhoVjlQdWZhLytmd2wwMDA5VnBWbXUrNEtoY2xKdE1x?=
 =?utf-8?B?aThaUTM4dzdISWhCZDlYMGh6T1k5Rjc3czlpMjdJVWd6WjJFZUI2L2dxTEh1?=
 =?utf-8?B?ck1qekEzTVZVVUZDOU9TVjNFaVBSeklKcGJGK09VaDZRbG5nWnFrODBqOU4z?=
 =?utf-8?B?NlNTKzVtd200NkwyZlA1OWpDUUMzVUVReWYvS3hXQXRkNDJNcGUxKytKdGVK?=
 =?utf-8?B?QkFBYTBYZHFDVGR6b0hmUWFsZGtqcE9oTFdheTMzRy9vNFFuVVliemppVUZy?=
 =?utf-8?B?dlZtQzdkLzNadXVLQWU3ZXNtN3dRZHZOdytHdFZTTUlzWmxNcTd5MllsWnB5?=
 =?utf-8?B?RDE4dDVNT0VWWHRzNWZGMUpKdHNydHBiY3FhVHovU3drNmNLWDNrL1AydHZS?=
 =?utf-8?B?RTQ4M3NVbDBudHhuSXAxazQ4Qm5zMUtVclpSaDVCaWQzRVptc1Z4TVYyZXdp?=
 =?utf-8?B?T1A1ZEdvMVdubXpKS0NvclJhS3doSmtFZUJrYkUrKzJSTWYvcEFFd1JaMHdD?=
 =?utf-8?B?OEhGbGVDYWVuWkhLc054Z3J6WGZUUkNyQ0xCZS9mZ1lod1pCbElpUT09?=
X-Exchange-RoutingPolicyChecked:
	UtF+fQDx9NYCIUXqlHVmnYvRbvTwmeyZ6DlYDzt6KjeUgKhacy06BHxEDEiYC80ftdQE7mNPBHHWxRb/jYXIJF/k4bqwJI5O29O77snGxu6UYty/DGN7WukwwN7Yer/IHej8p71y37dWIsi/gb9oPt+ahPZxBwTfkDA74RixLMZt27n+B7VeApDo1hnoNt6Ps4zZKK1RjPzVYMHThcCx5Dbx42Dnhwqk4lxwlMYvQ3m8HTrwg1aq3r8jB9MJbPkTJ71tfCTXadS6xm4KI+8zQJdE7GkIOzT2aOv25A7a5N7LfjyDIVWIifykn9WbJ/hkAs3zply4X9SLd9hFq3rQEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3B11FMBJbcqTC4pQP0N500QwjP2D8OVuyO7cJWyMggrGDcIQaj9Bvau8ndtV4zOqIHn6SR8qQTTVzo8mOehNIndUJYXmEOqXcj7mDjvHr3hoGqd3OqhSPPXkUMKJ6bEpXMIsiMCC9vATzsEwk3DrjyLvRvxsF/Oao0qPnQwdmvSxOOF0tcsuqlJEqvipOsG35/cVoGyIxUOV/+uZvIKvIvu8Exzj9JbHkWPXwMQ9HIBMhp7buWrYMzB/h68e6OGeMVSUMfOD1S+/cluRpcw6Wex++kN1PKfbIl/3SZnnixrfjezEczEi9alzc/UNWFry+UQFQsQfMTlxq7cwY4Pwzh4YbTVnv2DuFGvw2Ks+WysuzSCFcPs3EM+7XDFeO3ShHh6TnM/CP29XaaRvGr5fSf7YsB67cqFyEhyBxaHWDSKaioxnMplk1ohYYbAgXYsg4tH/TtXL9LiwIiQ/d6IbE5kskcdli1P/Wk6lIyvqdum5MDGtvH5cmWqkbmri/OgJLBINEZWH8eUWKwb1dPMY8ZPy6Uhjy5AbjEkQSiIvmE0IZdyQXjq2aWkbTUYKNBaZ7MFSKw0Xbvfw3CbJMikT0jAO77CFHIeF/SCO47JtWEsVYxKHQYQ9sBwT9R965VFZ
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2030b5-0ba5-4a46-172e-08deb74f8218
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:42:04.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwfPNGlbbq0HIxN+ONriQE4G0mv242ZMPg9lQhuj4eeBivnaDay4XV0YlTH+SU3RRJgsdhEODRFgUNs3iU+lCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9062
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=ces1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 43F5E5A9EC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 10:13, Paolo Abeni wrote:
> On 5/18/26 8:13 PM, Martin Karsten wrote:
>> +	} else {
>> +		/* All we really want here is to re-enable device interrupts. */
>> +		rc = napi->poll(napi, budget);
>> +		/* We can't gro_normal_list() here, because napi->poll() might
>> +		 * have rearmed the napi (napi_complete_done()) in which case
>> +		 * it could already be running on another CPU.
>> +		 */
>> +		trace_napi_poll(napi, rc, budget);
>> +		netpoll_poll_unlock(have_poll_lock);
>> +		if (rc == budget) {
>> +			gro_normal_list(&napi->gro);
> 
> Not blocking, but I find the above slightly confusing after this
> refactor. Perhaps it should be re-worded?

I'd be happy to reword, but I am not familiar with the internals of gro 
processing, so would appreciate any help I can get?

Should I try-and-error via subsequent patch submission(s) or can you 
comment on this version:

		/* Use the driver poll to re-enable device interrupts. */
		rc = napi->poll(napi, budget);
		trace_napi_poll(napi, rc, budget);
		netpoll_poll_unlock(have_poll_lock);
		if (rc == budget) {
			/* If napi_complete_done has not been called by the
			 * driver poll, the napi needs to be rescheduled.
			 * Use the opportunity to pass up completed gro skbs.
			 */
			gro_normal_list(&napi->gro);

Thanks,
Martin


