Return-Path: <netdev+bounces-293885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK3NJCnRHWqjewkAu9opvQ
	(envelope-from <netdev+bounces-293885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:36:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF8B624119
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F789306103D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B883E275E;
	Mon,  1 Jun 2026 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="QJdsejtH"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9D3ED3BF
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338780; cv=fail; b=TsW3ntcKD7D9m/eTQPo+8LcTMzKYMTXLnhy+orDKG3QLxyIfE8bVVdPnJhBEdrUvBM0r89wYdQGGAYHpbzLbkiIUjYzOKX97JoXYff8yl+mUM3kNfdJjKxCUiTlNkvC2Y7fBrMmUCBhrWWa5jRr8Hogz1AlV18Ke+LmEJ62G/Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338780; c=relaxed/simple;
	bh=LcCyGazZCIW2WlETBv+leK1h90SWSYaxWs1ctwElo1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=emh1I1kTL6IjLFeCFJel+oK7Kb9yvR6ANVS7cXG0iXybzJFRLkz2cDRtInf6d97/x++Dwtl0yhaAXTCv4EXLUSrRT2hPRADR9BgVarDUvx8DlwY84TUjKurpkgKoWidxR6e0GF5F6y4n6qwjhgO83BfBwdWBB8z6+hNLJrnmXoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=QJdsejtH; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651HhMMZ3454207;
	Mon, 1 Jun 2026 18:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=LcCyGaz
	ZCIW2WlETBv+leK1h90SWSYaxWs1ctwElo1k=; b=QJdsejtHWS6Wd5B4GxYpsH9
	grXTPg+y/wEfHbLywfEIJ380Pd78eP9kGcWWmjr2jkNEy9b+0/lbFENKMFY2MhSM
	GZQJxRAsoiDtIkQ6xXgFP8Uz6QUmtapM3MDyMkto1rzFb8JMpwd4tN559AmRZdCO
	00wsKfJ/fqtXTk3FQzvJ7U+Eb8CisJEaDtn+Lrrn3RxRwFBdzo4d0s1dxKU+2Q6O
	Nk2WKS1JxU9RgGmBgxVJ1S+IxuEqiOrTSJ9ZPCoVgPOvPm6jiSPEBVBWebm1mv7I
	/PSLt7o2R4s2R0p4cggWWVwdAEaE1PO9ACEPNGmZd3M4OetDEzMDmYonFGQjzzw=
	=
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4efpryajhs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 18:32:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRNd1rhDFtTwSpeyNzU+QOsDEgc+fAup16Ilw1VIwHuL96GBvoSklZcBso5FXPXnXnp/YqjCagWYdNh/JsXG7AgSMrU0FCfDAjmDVMaomNeFQ5E7VNZx8xOGZZ4Jgo/3IeTX8ANffC531Cib3ht2jTOlaZOwMp4NpeidA3JsCSjxFB0vDGft9dFKIBaQtGg4YcsI0PqxCDy42fTf0htM0dvDBma/pU5Y50fSQ8hGM0c9T+TfnzESMA/8z+g2skNZ9AJCbU9Pg3gKPB43n66/Omp/fgoocB14pGeax2+VUtr927zi8IMmJZRwT3L6wOea1RtB3qQkffv9woBOTZ8g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcCyGazZCIW2WlETBv+leK1h90SWSYaxWs1ctwElo1k=;
 b=lryu5kdhv869NjazOLkcwP/CjxVx2PKpYZtj9gXT3s0ltktG5DdotMsxDm5Tqey/2mdGSPYO/oahwR9oiCBtqSAyvZgL2o4xLuQ+fX75rvfM+As6KqVlhAdl8+9NF0szKc9xFhzjj8mQfDj3poBgiJiz+fCUA+WMikPmMlgcf7/V3a5aSoA+5ua79zO37VAl7eMumTwF0HE/5T1EHYsfGjLj/zFuBFCUonhNqxlN7Uhni6OAwTd94IcD9l7o+m52q04cBRwzw5eZOG98BisrlxcMZx8jdwwdYDuNwASlyc5CTa4VLBIdhPd+/10B0p6oC9wBWsSW59REniOg5dhwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by SJ2PR13MB6094.namprd13.prod.outlook.com (2603:10b6:a03:4fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Mon, 1 Jun 2026
 18:32:16 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1%3]) with mapi id 15.21.0092.005; Mon, 1 Jun 2026
 18:32:16 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>,
        David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Neal Cardwell
	<ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson
	<vanj@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: RE: [PATCH net-next] tcp_bbr: fix SPDX-License-Identifier to be
 GPL-2.0 OR BSD-3-Clause
Thread-Topic: [PATCH net-next] tcp_bbr: fix SPDX-License-Identifier to be
 GPL-2.0 OR BSD-3-Clause
Thread-Index: AQHc8SxeYP3o4z2OsEGpOIo+M2cyW7YqBwTA
Date: Mon, 1 Jun 2026 18:32:15 +0000
Message-ID:
 <MW5PR13MB5632A50FC7CF62847223F4F7FD152@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260531183558.2337381-1-ncardwell.sw@gmail.com>
In-Reply-To: <20260531183558.2337381-1-ncardwell.sw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|SJ2PR13MB6094:EE_
x-ms-office365-filtering-correlation-id: e7c1d701-bd5f-4656-3247-08dec00c1b1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 bsd73J8nrW/yOSE0gL8f1mwEj2OOT9VWaq/ozT5ojbr89JsgeJPoqc79rmOmZRSxgyqbe/Khmht7XgDfZFVtus57MISmvhFCMHwkQTLAGecuQLyIxu/UKNCMrJ2oNl8PH6EOUl401STLLbMpqUAdPEE1sHZKNYGmNwV/YUqYtBtBoxNOXnS0JOxV6N77dahiZTxkFOpgH3gSdQz7GqsYQ1h1sIUlD4GEIp0trJR3B76sPwCpzGha4YOoCGtDrJ5b1SK+efhZmU9giDo4VeVwhrZVfgHQxLvcIpMTieY/weB3+TPTvDMeb47tuQ0wa4vwhF5xeUbicAvJbKMRzR+ahpeg1YMdMN2tqMDmhjiBn6Ht9L2XM9LVk+XWpXM8/JDJ/9ls9j0m8vdulZM1iOQg0soswWs1qyDllA3Mc1JNNta1n+xz4W2bf6CGC8lSr3oxySFE/zsJHk9iYYzvipLr1S72uHGnpwUqhKCXyHB0gXjIqBiuFVTR+hxgLn5Y4/QlXBdsAQt3mg7WHH9pV6LLYKRbyh6eT8uUFF3amQ8g8eocD77UJSSI6ldG4pz1FChZH2dgAd+W0CEH5aHkbWgBewnNWGbYAtRpl0+t64ksjG8YiwJrginTks7roP9H3ezPmW0Yn9UaSEEMVek5vjmIFefFrHm0cvYgqV41OEtvZP5QtVUkf8F80xy+lrk48goCcs8CaY4dd9BExEIefdzsU1hQFK+hwyQuLr7EZScDlxJ6hyUxUYF4s3TczQEkJ+W7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q29wZ2s4anc2bGozSSsycjJ4eTFtL1ZQVUlIcG53MSs0ZXZHNHYvekdYU0dZ?=
 =?utf-8?B?aWs4SjBxUFhBeGpxWFJtSzdKbVpNOUJZREJYMGZPOEFQV3Zva3U0N1VpL1B5?=
 =?utf-8?B?bjBUS3JUMFJlQk1RUDFXanVLVUdBWEUwSmd5MzdhWkdOSmVtRzVyUmdtYVJq?=
 =?utf-8?B?THNmc0JaVCtUVThxZTUyc0plZGt3QytvRVlJL0VlUVZlRUtnVEtPbTFSYjNP?=
 =?utf-8?B?U1FsQXdHdmhlRXNZQXVFSExHWGt5S2psa2pEdUxRaHh5bjNHTlpmczlLb3kx?=
 =?utf-8?B?R0g2NURTa3ZRM29LTWFSc0NOMXJXVk5GWmNSemw3NFFCenNDcHRIOXA2OE9x?=
 =?utf-8?B?YjJzYlBqbHZxcUhVdTFNTnRJWVEvTzFIV1pQZXhmNVdLOXlmdi9lVHFiN0Iy?=
 =?utf-8?B?KzRQSmhnL1dhMVczQzZVQlNZUWMyaFN5WkNBaVl2RDdXWUwydlZQRFBsRzhR?=
 =?utf-8?B?aUxtcldCQ2t1L3NvY1Ixd2pXUXJLazl6d01wRFZWVm8xZnhnOTZTbUcwNGxN?=
 =?utf-8?B?V2d0UFpESERmSlJqeDh2ejd0TWRHelRVUTBmZWxCb1RjVXUxR09WODFHNlh3?=
 =?utf-8?B?Z2RGTDNYQU9MUG5jVlBmaTZyYjh6SUliQTJ4cGwyaFVLYmk3YUxIbzhFeGJR?=
 =?utf-8?B?RWRWTDdlQ0haSitVNGVmVlNrOE8wMTgwOXk2a1l6cUtCL3pPREh2ZDRVN00y?=
 =?utf-8?B?MTdhNHZ0TDhhY3h3dE10ZWJBbzdlOTRpVGhnZFJsbmxiLy9mUTZwU083TlVW?=
 =?utf-8?B?dk9jazlkMG1oYTRkQmIwclBreUNyeEpFemVUY2VLSmphQ2dvSi9CTmZFc2Z2?=
 =?utf-8?B?WkZwUXczc0hibXZuMjZIYkh0dWVUQnorT3ViMkNyMHdvRktnaUR0dFI0N043?=
 =?utf-8?B?dVJTNDAzODdFTXhVcmtQbUUwZVhLVjRCNFU2eEZCcWNybW9RYTRtRTRkMWtp?=
 =?utf-8?B?UDZSc2tCNndNYXFYR2NCUE5naWd6bFNHYzNVZzJ4ZWUvZWZ2MmZ6dUhHMThH?=
 =?utf-8?B?LzhWQStUV0oveVVPUEk3TnRvWWZUbzFWeGpyLzduYzNOZDNMdFFzOEdpdEN2?=
 =?utf-8?B?Q3JFOW5KQmNJcmNGbEUrZDN3ZFZXNU1vdEp1MGZqZ01TMERpOXI2QmVxTmEv?=
 =?utf-8?B?RWl1TFRpVWJWd2tsQTlDZWhkeVZoSkNldEpyRlNOR00rSWdPSEtRalpIbG1y?=
 =?utf-8?B?N3BpTUJKUE9rWTQ1cE4zc1FVQnBvYzR0UE50c3pXQzZPaGFBL1F2WmE1clJ4?=
 =?utf-8?B?V1FRUmNoMm5EZzhKRkZsc3d4bVY5R3lPa3JEblVRT2JZR1RhYVVKVG5ydmZy?=
 =?utf-8?B?SEV5SEovaEJMT0RrY3pSUXk5WFhjZW5CQ0F6YU1uSHBkWUlBSEV2WFRPbVE0?=
 =?utf-8?B?WnoxSjFwTXRTYldaMXFUM1JFVEorRWIzcUhvYXdvYUthb0hmSVl1cW1SaUEz?=
 =?utf-8?B?MHVnekVJemx3dWF5NHZDWlI3VDRaQnlqZDNyT1B2a0R6SEt4NkFDNHpBRUVU?=
 =?utf-8?B?TzFUb2dkeDMraUwvcWp1T3ppLzRnS25jNEZVQ1JzNC95Q2dqeDZOUnZLWWdo?=
 =?utf-8?B?WVpGSkVtN0d1eUxtTUlZSEZEMTBRWFYxK1RSOXpuUERqMXg5YXhaTEdFQzMw?=
 =?utf-8?B?cVV2aUNQWGQ4MXp3QXdNTHB6VmhvdVB2QjhuTGJkTGdWdXU5U2xCVUpSWTAr?=
 =?utf-8?B?V29SMEdoNzhHSzdNdHVDcllJQXI0WFlHNXNnQXJmM2tTako3Y2swU2ZlTUd1?=
 =?utf-8?B?M3pTUWRJTW51VGo4MHZhbkpYQWY5aWFrbml6UzE2NlZFNGd1ajdKWTkycVV0?=
 =?utf-8?B?WVRlbFByODVxMGFYanYybjhzcklvbE10enIvTlZ5eTYwVk5NVlEzMUZOSmZo?=
 =?utf-8?B?MWdiUkdJSlN6Q2RDaVZNMUd6aVlqV1FUNHo3aTlDR1I5bjZWV3dEVDVaYjNs?=
 =?utf-8?B?aS9BdVR1OW0zQjQ4NFJKcXorZ3FGQmNMYWYzQnErdE1wb1YxRzhnMERKNWtR?=
 =?utf-8?B?RkZSV0JOZ0p3QTZ0RHR5YXRXUVhyRThFaThteTQyTFJFYmZ1azhPNkNhbGh4?=
 =?utf-8?B?cHltYkJkT2U3YURFUGt0dHkyamNIOElvRGpKK0d1UTdpU1VkUlhaK1VqbU5F?=
 =?utf-8?B?VlRzVmhBa0toZVM1NjBhdEVVNkd5cWNBSzRnaFVLbVdPQisva2IxUlg0YnR0?=
 =?utf-8?B?NnlyWjlwNmY2ZWM0Mm9YVlkzSTdlM3Zua3gwR0NHVDFHUEJKM3E1TEZmL1Av?=
 =?utf-8?B?K3pPRW96ZVdNbnNqRmtWdm9KNlMvL0VtaENqTjV5MDgyNU9tT2Zid1FwS2xz?=
 =?utf-8?B?V0p0NFpEaUV4ekVGL0RrQVVNUWY0Rmc2QXJlZ1Rlb0NzbVNMY2htS01LZkk2?=
 =?utf-8?Q?YoUriBljbsbDiS9VTHQR65ZWYumoCgJgvoG7p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	s6CpJboFStcL9No+RuxnBN/LjmTB9Bn1ZJOTMJnO3yWQJG0E28eq5bmUKgkomhNzN0RtLM21PzRiH9wEl/SmvQUd5jdH4yXFZUdnckilDIOJFWiyf/31Q5z4Xs7AvcWfChcYdj8hBv7uR3uMmX3ABh334tecrnNURXj/E8YUwiYq/Lhkjw+LxQBF84IaZt3scDrMdj4EDR/eDKn5DZTiW4IRhhP/Sn+a7L39VBJvzidhbLzzPQmZkg3BAXsboZpLIkBQ7JGxBiUjBnKuLEGpNyApfzUJ1Ex1tCZJuyGIHeliudiFyY/Vd4FQS6dc+3jM1P2dq3bLfGgFs5E1tIjXrg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IgWGrnTZFuoRIcR8SHA6oWebQ9lTTUG77i87AaEWHMQqOUOFzZBlzMAnwotV6gYRKv1nHuOCWEdzBLnRVBP17LoSx+6a6Qp4PnLz1QJXzSSv5AvOsoixo9rF5RfPCnCJvRCUFgjko7C9HfbzE8sDofJC+ygdZFYeOw5ClplDIqEJYxCQwOwwICASYZl/pvW6iqf1XN+5EYUtSbToJbSBVJLtFjrgSHkc4aVDtSzQO5qKpddfCP6gnyC5IdY6DSe0q65Uy9Jc2imyfhjulQ0JWgTvK4xHc+Zp3LepEnhp5d9NiX6vacriQYLJZu4wXemBdKSMmOZiXTq8CMbN5I4Jzi4ARqeIkg/7vPgiqDpuX0oimnYjcV7grQjbUVk+EGdkLGfNMafPsT7O6tMb5/8dPmw/Z8cty6JY6DM0EW216eNv0fhJu+V+CPWLwSOCL8a2/97FilE3qTOOrq0858puJiIWOwJ74r2ZA/O6srIGnJAsl3TDRDWmATXYHyLZ9tsxyoNWDVyP9tYlrjexOXHqI1Bfw7o4ruU1fF38Zz62riQtSzjFkliXIyFGv4Ip01+L5Gzzu4Fo3q6cvuVYU+S73+rdXUQWs4CYR0DFctvSNITeSinlaxcGMQzctVv6CmJY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c1d701-bd5f-4656-3247-08dec00c1b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 18:32:16.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrwLvC27pfTH+Ulu0GcPvVliuKTRs0ZZns76gTWVqTYJ0AqZGT6A++hFi4HS9DWub/7W2WpqZZ9SyK4lhnBDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6094
X-Proofpoint-ORIG-GUID: PM9sia0LTvl6wv7LhnvnBDldpdLbr1zs
X-Authority-Analysis: v=2.4 cv=ROeD2Yi+ c=1 sm=1 tr=0 ts=6a1dd039 cx=c_pps
 a=9fOKxQ6q+1oHddUNM5AUXA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=b20fedWF67CaGdYoUt4Y:22 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=z6gsHLkEAAAA:8 a=2DcZfJWCmJLYAL7pcoIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PM9sia0LTvl6wv7LhnvnBDldpdLbr1zs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4MiBTYWx0ZWRfXxL33BrtRbfA0
 1QstyiJwFLdSnWDq5l7Gi/SDReTdNPYiO2+OqPw25refqAn+A75LObv54WMCi6Xn1SLmlKDkzKY
 h1Ogb1BVKBGBccIQMWPWhthSqxVaj0tYHnYDjE/ziFeQLrnsD8lfk/Km3WItIJJ3FhEKueLGxEI
 X1VN8RuxDmL65/FfWZRhdGUU/oXWIWFYyV0auhISFEswHg/hVNtbV3qmYwnfXk/iKxHeyA06lEI
 Rjgg8/mTUZQUM8nEawwTj2xcgLrhE1o00h5T9xHuoDjDEl+DZ3PttHn3wdN3Jsp4b1jbzp4Z156
 fXjHOcXseL3kIdiVENOHh6mRQxUdVer1+4F/K5PA5nH8qx8QeEknYRk16Pta9zBxjQoMwwAbuvl
 FRdyckDUCl5q7RW2VJPomYxCOM5Dg75A45xaIIqFq7R0iyQSnqh7e4bZ/by/IssRJn8rBA/oXS5
 maUtNROtsGiDdnnKrEA==
X-Sony-Outbound-GUID: PM9sia0LTvl6wv7LhnvnBDldpdLbr1zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sony.com:s=p1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293885-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sony.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Tim.Bird@sony.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DF8B624119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGwuc3dAZ21haWwuY29tPg0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29v
Z2xlLmNvbT4NCj4gDQo+IFNpbmNlIFRDUCBCQlIgY29uZ2VzdGlvbiBjb250cm9sIHdhcyBpbnRy
b2R1Y2VkIGluDQo+IGNvbW1pdCAwZjg3ODJlYTE0OTcgKCJ0Y3BfYmJyOiBhZGQgQkJSIGNvbmdl
c3Rpb24gY29udHJvbCIpDQo+IGl0IGhhcyBhbHdheXMgYmVlbiBvZmZlcmVkIGFzICJEdWFsIEJT
RC9HUEwiOg0KPiANCj4gICBNT0RVTEVfTElDRU5TRSgiRHVhbCBCU0QvR1BMIik7DQo+IA0KPiBB
IEdQTC0yLjAtb25seSBTUERYIGhlYWRlciB3YXMgZXJyb25lb3VzbHkgYWRkZWQgaW4gdGhlIHJl
Y2VudA0KPiBjb21taXQgMmVkNGI0NmI0ZmM3ICgibmV0OiBBZGQgU1BEWCBpZHMgdG8gc29tZSBz
b3VyY2UgZmlsZXMiKS4NCj4gDQo+IFRoaXMgY29tbWl0IHJldmlzZXMgdGhlIHRjcF9iYnIuYyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllciB0byBub3RlIHRoYXQNCj4gdGhpcyBmaWxlIGlzIGxpY2Vu
c2VkIGFzICJHUEwtMi4wIE9SIEJTRC0zLUNsYXVzZSIuDQo+IA0KPiBGaXhlczogMmVkNGI0NmI0
ZmM3ICgibmV0OiBBZGQgU1BEWCBpZHMgdG8gc29tZSBzb3VyY2UgZmlsZXMiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4NCj4gQ2M6IFl1Y2h1
bmcgQ2hlbmcgPHljaGVuZ0Bnb29nbGUuY29tPg0KPiBDYzogVmFuIEphY29ic29uIDx2YW5qQGdv
b2dsZS5jb20+DQo+IENjOiBTb2hlaWwgSGFzc2FzIFllZ2FuZWggPHNvaGVpbEBnb29nbGUuY29t
Pg0KPiBDYzogVGltIEJpcmQgPHRpbS5iaXJkQHNvbnkuY29tPg0KPiAtLS0NCj4gIG5ldC9pcHY0
L3RjcF9iYnIuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L3RjcF9iYnIuYyBiL25ldC9p
cHY0L3RjcF9iYnIuYw0KPiBpbmRleCBhZWM3ODA1YjFkMzc2Li44MjM3OGEyYmZkMWUxIDEwMDY0
NA0KPiAtLS0gYS9uZXQvaXB2NC90Y3BfYmJyLmMNCj4gKysrIGIvbmV0L2lwdjQvdGNwX2Jici5j
DQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIEJTRC0zLUNsYXVz
ZQ0KPiAgLyogQm90dGxlbmVjayBCYW5kd2lkdGggYW5kIFJUVCAoQkJSKSBjb25nZXN0aW9uIGNv
bnRyb2wNCj4gICAqDQo+ICAgKiBCQlIgY29uZ2VzdGlvbiBjb250cm9sIGNvbXB1dGVzIHRoZSBz
ZW5kaW5nIHJhdGUgYmFzZWQgb24gdGhlIGRlbGl2ZXJ5DQo+IC0tDQo+IDIuNTQuMC45MjkuZzli
N2ZhMzc1NTktZ29vZw0KDQpUaGUgY29ycmVjdGVkIGxpY2Vuc2UgaWRlbnRpZmllciBsaW5lIGxv
b2tzIGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBUaW0gQmlyZA0KDQpNeSBhcG9sb2dpZXMg
Zm9yIHRoZSBtaXN0YWtlLg0KIC0tIFRpbQ0KDQo=

