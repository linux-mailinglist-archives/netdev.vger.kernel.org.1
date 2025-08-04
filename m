Return-Path: <netdev+bounces-211599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBCB1A533
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF473BCAA2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D571F8EEC;
	Mon,  4 Aug 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="FB1aAQZT";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="JPagYKLY"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77B2F2D;
	Mon,  4 Aug 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318853; cv=fail; b=Xo046W5ShaYaOpxssPvGuYjpuN33ddH2X3tszcnOASHh5C6NSVwQwgpu0zqUECzITAO7GEighloKgEzYthQcquHD6lI/qMVE74RXzKjokTuc59a7lOZzwJQgdOS/Eye15mTOZfdJR/C4UPCG4cBNwNwxQq8FlXgvdxPVBdNjtP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318853; c=relaxed/simple;
	bh=8M0q/0c4Nf3OZzPQOuXM8T0wJGrpUtkGdwGi/5iHRv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imDTApADvh9dnawBgNFaj4C6Q/ltAe5vyJ+4lI9CfaupBGgeBQSSGRJ7uDFUko5ocx3pV12ErMfJ2X3TOE0PMLVubML1jSLiciX0ebvm0oI8b5GAQj97IlHYbN/71H5nBEB7gtowR4iNjlREN9WpG9pOAu1/HrT6A7TZ9q7viLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=FB1aAQZT; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=JPagYKLY; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5744YdiW1042071;
	Mon, 4 Aug 2025 16:47:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	mv1XQkyWBHO+J6PxbcZ8rNglzCOrfxUqH4Ipjkib4cg=; b=FB1aAQZTVzUhkgPm
	bGAJ0/MakoLEr1LXyXiaoRVwjDVsV5XA1mvoWSGsEdvQGuoM3a4Tg2Zxt1a+f2yZ
	HHIHocT8CZMQ9r8HPqTRRvv41GukOFkyUyXi8Oo7hgdz3bOBwbby5mkH2YHNoT8p
	V8MTLoGL/6cs3TzJuzMU7GpjePkmYb69uec2R5J8Ka11+LLnQyBgKI0L3j9hxTJI
	7M3NcZmoUyNc5OJvKcmQlUue9cqJkUCO0auE5HGklMjC1SwV4bLeS6FabwLlm+XN
	HP8Guy+rYDuM90YXdwvfRUPYnJy2BzL/QGzTdyEEMM+Wh+J0SKaR7j7gN7b4xMcB
	eA65hg==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4896p1sr4m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 16:47:12 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYol4szcCcSwvFgSs1Q96BkwD0k960v/5QjFNF5OSE6fz723wDzg1Tq5c74RiOr3keO4hTXeKowYHelcz7yOJCgRP9/aXc0ro6rFMILLrJcTuzKxixGI9LAMRBmGMDwTUaRZxpN8RKqtbSk+m4b+/kHU6C6i76PrhfTcRksEIs7Eb0H3GMU/DVK21kqDNADDQVhbwxHDUelcPSziKADHC7s1NBEhBeqZjyCnPZbVjDrhOVVW9Ulg7ZsZIot7u6butNGPat1u1L0DkvGld8eqbNYsIhDBcoZCqzwSGX8qhysv+dY8zodLL+mH0Ur0wpIBYrQihd6l0wFoIc7exd5Bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv1XQkyWBHO+J6PxbcZ8rNglzCOrfxUqH4Ipjkib4cg=;
 b=Ao3UbJu/vmg/vCnzLgJSeQQnBTwWw6cAE6/54rtVvQtLG5xldylMGRZbdLsDiW9kIsVRGlc/xiSDsexb6ShBg4PBXFmS2WUe8DGxxFNN9LT2kgQkOZboN1b+dBXqzTJSSC9L7VEG4flBT4Z2OUiPlGnrcLBIG0vtBzWRmYw7ybbqZcVpnmwOPc0H2AR8DBnM5tEWdkxrTdDTKhiWN+3IX1zj2obhrQoVT94HUrxlzdToga9eIT1WC4OS2ZyejniIi5SMS9GiQOy8aakTMU7RMU0QJJXL4GkP4M8RdsxvlRQ6/Ud9WKPLG6YQC220qGbYStwOaZQkMzpUN6GhVpm3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv1XQkyWBHO+J6PxbcZ8rNglzCOrfxUqH4Ipjkib4cg=;
 b=JPagYKLYp9sfQaqvwgDRZXmPk2tLaA3yEpoG79sS/3ay8wGW5zght9TWDBsrekUcShiXYJmu1n6OaefhN17D0ieGa+qzyoGJnHjIOnDkvIbfPCqga9X+87glMIQXHexsG7mAH59sZWDm8H2E5mgVnJD694W8Sv6D+L1UgfSZmf4=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB5P192MB2200.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:48e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.9; Mon, 4 Aug
 2025 14:47:10 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.011; Mon, 4 Aug 2025
 14:47:10 +0000
Date: Mon, 4 Aug 2025 16:47:03 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804134115.cf4vzzopf5yvglxk@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB5P192MB2200:EE_
X-MS-Office365-Filtering-Correlation-Id: b7306552-7669-473c-4514-08ddd365cac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TC9CejR3NmExUUFUM2NWMy9QM0RjVnlBZGQzUXVlSURtdlBTaFd5QUVNL2p6?=
 =?utf-8?B?a3RuYmU5aTVpckxlcGVGNzVZVll2ckFEbnVQQ2VCMjBYY0c0R3krTVdwN3pV?=
 =?utf-8?B?RUpnaGZnUU9YaDNwWnVuUjVRWHkyY0V2UTlBUUl5dGlOME4vaHJiYlNWWUFa?=
 =?utf-8?B?ZGtUamt1aFh5Ym4yNk40cmdTYllnSXI0ZjVBdHE0UE1Ndnpia2FoZWVtb0Np?=
 =?utf-8?B?elMvT3RhTWI3bEJhei9BeHdOenB0NEV4b290QnA1SU1UU2FnMXNtaUI1L05p?=
 =?utf-8?B?M05SWm5OaDNQOC8vbWVXRXRESVM0T0tmeEU4bEFHTWxURmUyRWt0VXlHOEwx?=
 =?utf-8?B?eFVKU2MzNGFXRGpHNVdtbjF4ampUcFpDZm10Ri9WcHpMQWkwUldBN1daNDdR?=
 =?utf-8?B?Y2VhZnJ4L2FXd1p1V1owNVVoZExMUjJxQkRJV2FvY2NxQVU0TFdMR2hNck12?=
 =?utf-8?B?TkNxZWNITVRwRElCcVRmdWIrVTdrUW9CS1hudDhYZDlMYmMyaXVwYng1K3g4?=
 =?utf-8?B?K1VZSUJ0VDJucFU1NTZoTDhLS096Y0ZYeWIvdklKMDU2TlA3NEI1TllzNUVP?=
 =?utf-8?B?dHNSRGVHR0dZbkt2d2F1ZHg0ODFJWXlGWGxsemQ5SE9kTTNTbTE1djV1RlJL?=
 =?utf-8?B?cjRtc2ZyMHd6Yk0xNWJ6SGo5TEphclFNd2k5Qmh3MHgvWjVHcTMxL1RUWDdl?=
 =?utf-8?B?RGFYdFNLNk1LWmY1VUJLV1U2Z0xhQllGeW92WDVHNlZJa2R5V1dENUhvUkNq?=
 =?utf-8?B?czN4a1RYUUo3RHBCSU1nWWt4OGZaSTNDMGVoYUVYZkxZTFZiMHV6MUVBSnhQ?=
 =?utf-8?B?TE5EbmpHWU5mVkg1UXRkT0dWWUFBUiszNlFXS0Y0S2xwN3ppMTRCUXhnRk9h?=
 =?utf-8?B?Sno3TllrYUJNaHNTbUpLemhwdVpXbmNpLytleWI2elAwSUg5ZStURnhlRXVJ?=
 =?utf-8?B?K0VIOGlSbGJhNnE4L1p5UG41NURuandodlZTbDNxVVZManlCUWt5cmF5N1ZC?=
 =?utf-8?B?Nk9Vd3dRVUFFNFIyMDhMZWE4T29DOUhpNXptNTExY0g0MFJXcE5ycjdXdGZE?=
 =?utf-8?B?ZCtkcmNKZ0s4T3Q0QXdQNXovMDgxczBZczdBWExoRlJoVXF2dnVZSlVyUWtr?=
 =?utf-8?B?NnRMNG5oSmJzKzVtV2YyaUFUT3F2LzRpa1VJUngzNGZQMzZNc04xMEQxbk5X?=
 =?utf-8?B?ekgyY0NxMWVMTUFXcjBNNzduWEFyd21aeWdvbzBibXU5bldvenFldCsxc2pS?=
 =?utf-8?B?Q1A2UEdPQTFSSTJxUmFOT1JWK2Eva25TSlNEVHBqNUZNVC9VMU4yd0hSS05H?=
 =?utf-8?B?REQ3N3d6c3BGUkN6cktDcmtuZFBjQUJOc1h1a09IZGR2MGY2STZjcTNxWDFq?=
 =?utf-8?B?bmNtNUptVkxLenBUcitJVUdYNEZoRFU3eGFxWEhpYk1WRzdGT3VPSy9Bd2Ji?=
 =?utf-8?B?cmRiYlZDQzh0bVJTZW11K0piblJQbmJBWGx4SHBQcTBpT3FiWDJwUU5EajIv?=
 =?utf-8?B?RnRzYjYwYlBKSXJTd1VodDBMNERpSzRxWVpyVmZlaVB3N1dHczZCZ3dLcXNG?=
 =?utf-8?B?V1dtY0UwOXpmS1l6R1hYckZ6RHptWktUL2EwVFc4S0Q2b2xMRWJkLytYVGpS?=
 =?utf-8?B?Wk56RHQ4UVI3ZWpRNThuRnF0M21MMVh3eEtwVFZhNkZ1ajExaVAyOFJIcTY0?=
 =?utf-8?B?KzdLTE5ZdC8zdzNnNFFoR0ROb0kva2JnSEVuTEZmS1k3QjZUeE5ld0RLOU1I?=
 =?utf-8?B?bUErYjNWVnlwL0IyTVpHTFFvRWpBL0Rnbm9JUXhYVFRjOVZmQVR5SEQwSitk?=
 =?utf-8?B?L0J3eEo1Vm5ldW8yN0J3b3lmbzQxb0JIZmRRaVZ4VFJnMTBsU1ZYbnlMZHZy?=
 =?utf-8?B?WlVtaUhyY3BvRTlHMkl6ck9URUpnbXNiTW00SndmTVJIQ2RpQXRwTXUwSkVO?=
 =?utf-8?Q?xnlPQAkpqjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZCTi9BMGVqTENxeEprM1V6SFdiTWxwOWcvcG5QRmxkYm1yK1B6RWk4OTRX?=
 =?utf-8?B?UmYySXQvREEvcjFhbFdhQlNVWDBLbHR3MS9IR0tOc2wwZ2FrQ1F1ZXIzVTR0?=
 =?utf-8?B?L3JSbUF6KzZKZDZPVjNRMVlnMXhVTzVNY2w2Znk2OTA4UXVYVUQ1ZnBPbEVx?=
 =?utf-8?B?a09oVjdwamh0QW5qUTdERXYxZjk2dlpndm81bXlUVGZNZXZqdXFMeUR2SlQ1?=
 =?utf-8?B?akw2ZGN5TUpiakVUTmwyVGpMSWE0aGsxNEtGUEF0MWlzYVZWQ25vWXRRMTBu?=
 =?utf-8?B?T29oeVZnTzhvekJ4NCtJdHIyK2hNWmJqQ1Z5NXZSZS9GSVlsUDZXTGRZNS91?=
 =?utf-8?B?dUR4VWU5NlovMmdHQUE5NVNWWS94a0lzWGRwSWFqeWhOZFdVVFFVRGpTSkV4?=
 =?utf-8?B?YU9wUGxrc3VuTWJPeXhwWGlGMVJtUERYc3ZvZjNwbWc3WlY5V0xwWTlzUElm?=
 =?utf-8?B?dFZtK1lHUEkrck9xc2RTVVlqSWlwRFo2T3ZSSzB2SXgyNkduVloyZUI0eFlt?=
 =?utf-8?B?dXZ1U2ZoZ2hua2I1M3c3VWo3VTlXSHdBZCt0aFQ1ZXF6a0ZOZTN5Y3JHeUJT?=
 =?utf-8?B?U2h6QWFzSnVRTmx5cVZXUXB5VmFwUlZ0dEhuU1dKZllMK2wzZ0JPdEh2Z2d3?=
 =?utf-8?B?VEJubklPM21oYkN4eWhkU0FDQVZkY3FCUlp2SUFmaGh0WCtraVFkemMyMFE0?=
 =?utf-8?B?MTRBNVg3MGFmSXpERG45K05JMHRrZWhtWmtSbU8yWXhSWDVlWCtDRGZHVUFv?=
 =?utf-8?B?Ujc3ZDJuZS9weHZtaFFhZnZ3UkN1VGZYRnpXK2ZFZ0YyWC9ab0NXa2NaTlVO?=
 =?utf-8?B?WFE3MFZKUzExKzdNZmhySHltRnZ0MG81RHJSYnRkWThEdTVSVUNmalJXM21l?=
 =?utf-8?B?R0x0QTQvU0ppZllXZm5mT1BvUm9LN3FVbzA0Q3dDUVFEQ2VNdjA3SS91dktE?=
 =?utf-8?B?RGl2eDV2QlgrVWYzTmpPM3VqNUxlS2hWeWVsMDduR2x4T2JBS3QzbTRSV2JJ?=
 =?utf-8?B?RUtxT0x0RG0vTWRUQnlsTUZBMVlneHFEMlNXREFhNDNkNy8ydDF4OS9aclEy?=
 =?utf-8?B?U04xeEZmWk56anNtMnVHdDdTNEtPQ3l5YTlJNGU1Wmk0OGZSU1ByYnFvQzNK?=
 =?utf-8?B?QTBMTkd1NGJxOUpTSUl2QTVkQXhtb0E0YjNWTEpMRE8wSC9tMlJ4YmNYZlhP?=
 =?utf-8?B?SzhLQThNZjVlZlpSVzNNY1l5TllRRGVhYjVTNkV4WS93UVJJeFdtVSszbDZ5?=
 =?utf-8?B?TllScFF0UVBqd1pFNTZBeWp2Nlhpa0Z0RCtGcVN6dy9CZm1PTWp2RmhMWVBn?=
 =?utf-8?B?b1BuVSs0aVVQQWxLeGlTNi9QeHQ1VWYzemhJa0tmL1dvRzBSWDd6MGJvNkdO?=
 =?utf-8?B?RURMWmtmSndFMitnMGRlTkNrZExRODJoOW1Yc2tEQWErTHZOVk5sS0x4N0ht?=
 =?utf-8?B?em5NakxSdkZwaWF0RWxVdkl2RVlIY3lmV2srOUwybWpwSkJjWWdnV1FjaSta?=
 =?utf-8?B?d2Z1ZTJCRFVnV051ZHUrd1pxYzJiSXBrUDE2akRBUTNSMXFxWE1salBIemdv?=
 =?utf-8?B?UjZvdUpSY0xteC9wSDBGeEp5dGxjVkcwM01nUHIyNTJ2VXVLam9OUmtMLzUv?=
 =?utf-8?B?Q2ZhZmlLRFhORUhrYXdYWFVJU1dnQ3B2QXlRVUgyTGVpYUdXNDNnTWdvbHMv?=
 =?utf-8?B?ckpDenozbjNaR1Q0RjcyRzJPT2RWN1ZNekdzV2x1dDNvWThtemQxblJFejJX?=
 =?utf-8?B?aTkxamtKck1KUmNRUU1OczFLZGMrZjlsd25STHFrL3BMMmhRaUlWaGZoOFpt?=
 =?utf-8?B?R2VmNkxnYjhhbjQ2ekthZDNkKzM5eGVYZCsxZzFSaVZ3QkZKUHhkZjVmU3hX?=
 =?utf-8?B?WGF1Z21nZEJzUVVQaUNmeEZPTGV1V0d4MHNtWGYxQzVlZkJ1bmFPNGI1YkxK?=
 =?utf-8?B?OEx4U21yN3NrR05ZR2I1c3YvU0FkTmY3RCthcW9yWWZaNzdWMFVqbWEyR28r?=
 =?utf-8?B?dC9kUDRxb00rZ2RSTzhNSlJUQTQ3dlZ0OGRzVmlVcUNENHFjY2tGeCsvSmZ6?=
 =?utf-8?B?U0hHdXJ0UmtDdC81VDBNeDZsc01hOGNBRE1uT2tRRmJsNWVZcmV5Z3g2QTVX?=
 =?utf-8?Q?UUNV2r6q3vmbbQEPnSehf98fo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ltAMambBEQDPGM1WkOuB95mVUOiFXGGJSVkrtQzTbOJ+Yt/K7GucuFU5M6rcT6Ma+bnUMv8jWQwUE+siFjCEX+jQCjeiDCohcvZQnzdLxeuKrWXMqxEztJrRHL1K4d2oqurD7RyUlahm2N962FBVIjpXmcFtmpO6PVh5AWgoSu8cB6J2yth0CK5+XZucfyQPafCS/GszSfFByeKPQj4fqKlJg5t6d3w+8nPSjiovkEFq1aJIHJPZaCgk9GIlV8dDDNioJ8r5eOghRC4usN76uCDKueKk5g7tIqH8Uy2V5zScwEft5yCy5ZIHC9kpv+tquhJa0fFc9G8umamrPtn0v9JreLISgBMfTaxhq2VvZTjYk+4frt/7YhBLkGcv9I5tEkHJSU02MkTZFAYZ0MF8vaR2EaXxZ+EFcYuivcd/80BLNCxs2IEosruQI86xl+emjscVM2hq5ZMAvF73ofeYmZdd1RPk9qBo6aMzdibZpKpB0wrHd1K7Ag0KFzPuDBboSFV6CQLebD3bynn8X3WHmJ1AG2r/EA+S4IJJMJS0zqehKHGaupVAAA9gA/+tN8uGk11GSi29vz5OCafWYlDKIN5mePPKZSZZV1JBeMiUEfH4c/tgSIFKw3KKnmk7Hwxn
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7306552-7669-473c-4514-08ddd365cac3
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:47:10.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlDpzfI2GjgwUPVc6bK/8HUuvL1MrUcACAUuFr/Igm6jS4TyQeIq9rE4lP0ZdQikJwSPJ+nPUzPPHsPmWhYxGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P192MB2200
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DB5P192MB2200.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: kHYeyy5Pqcr3W98FYqqZcwjivLPZ1zwi
X-Authority-Analysis: v=2.4 cv=O+I5vA9W c=1 sm=1 tr=0 ts=6890c7f0 cx=c_pps
 a=LoGhXiM/JxXibspYCOTuzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=-i4I5E_jAAAA:8 a=2imQQCwUAAAA:8 a=FJmkK1aqQc_TlGh1ubwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YQreJwxzuLcQAHRr27xt:22 a=ssJKQMnrLbq1UR0lVSsA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4MSBTYWx0ZWRfX4Zlle6WN32YF
 ewPJ3E6JeHPCfCrpfTec3PW061XD8M7HcT4D8OTHFXHraVTeV/gqE+F96v+1VG4KIC55RvdKfto
 P7kjuj+0G047BF6/UUyydY0AnoGsvoOPprpKfXp7NDhITv9vtZUprzP+qr9xYLE5g9nNwJK2f/f
 tYdcOO05WkQScCkzEqViUrrWVsjo7Gl3ohAHfU38iFxSyPQvRXNNJbeXZZ24b2RtZLKXJvZWlLI
 ZaBMBt8Kw5vBELIko+S6IOHFN9amGG2jF/C2lDhpW4nkCfUrCZ8F+PbAdtit8RPK5LpJJGzA1tN
 82S8R0BOtOTe1+jWztRhAQiRcOs0DXSy9RQOJEbkkAa7AkKzb+U0b2kLLlb5vo=
X-Proofpoint-ORIG-GUID: kHYeyy5Pqcr3W98FYqqZcwjivLPZ1zwi

Am Mon, Aug 04, 2025 at 04:41:15PM +0300 schrieb Vladimir Oltean:
> Hi Alexander,
> 
> On Mon, Aug 04, 2025 at 03:01:44PM +0200, Alexander Wilhelm wrote:
> > > Please find the attached patch.
> > [...]
> > 
> > Hi Vladimir,
> > 
> > I’ve applied the patch you provided, but it doesn’t seem to fully resolve the
> > issue -- or perhaps I’ve misconfigured something. I’m encountering the following
> > error during initialization:
> > 
> >     mdio_bus 0x0000000ffe4e7000:00: AN not supported on 3.125GHz SerDes lane
> >     fsl_dpaa_mac ffe4e6000.ethernet eth0: pcs_config failed: -EOPNOTSUPP
> > 
> > The relevant code is located in `drivers/net/pcs/pcs-lynx.c`, within the
> > `lynx_pcs_config(...)` function. In the case of 2500BASE-X with in-band
> > autonegotiation enabled, the function logs an error and returns -EOPNOTSUPP.
> 
> Once I saw this I immediately realized my mistake. More details at the end.
> 
> > From what I can tell, autonegotiation isn’t supported on a 3.125GHz SerDes lane
> > when using 2500BASE-X. What I’m unclear about is how this setup is supposed to
> > work in practice. My understanding is that on the host side, communication
> > always uses OCSGMII with flow control, allowing speed pacing via pause frames.
> > But what about the line side -- should it be configurable, or is it expected to
> > operate in a fixed mode?
> 
> So there are two "auto-negotiation" processes involved.
> 
> 
>  +-----+ internal +-----+          2500base-x       +-----------+  2.5GBase-T  +------------+
>  | MAC |==========| PCS |===========================| Local PHY |==============| Remote PHY | ...
>  +-----+ GMII not +-----+   in-band autonegotiation +-----------+   clause 28  +------------+
>     represented in the                                           autonegotiation
>         device tree                  (1)                              (2)
[...]

Hi Vladimir,

thank you for the detailed explanation. I feel I now have a clearer
understanding of what's happening under the hood.

> What I failed to consider is that the FMan mEMAC driver sets phylink's
> "default_an_inband" property to true, making it as if the device tree
> node had this property anyway.
> 
> The driver needs to be further patched to prevent that from happening.
> Here's a line that needs to be squashed into the previous change, could
> you please retest with it?
> 
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -1229,6 +1229,7 @@ int memac_initialization(struct mac_device *mac_dev,
>  	 * those configurations modes don't use in-band autonegotiation.
>  	 */
>  	if (!of_property_present(mac_node, "managed") &&
> +	    mac_dev->phy_if != PHY_INTERFACE_MODE_2500BASEX &&
>  	    mac_dev->phy_if != PHY_INTERFACE_MODE_MII &&
>  	    !phy_interface_mode_is_rgmii(mac_dev->phy_if))
>  		mac_dev->phylink_config.default_an_inband = true;

I’ve applied this patch as well, which brought me a step further. Unfortunately,
I still don’t get a ping response, although the configuration looks correct to
me. Below are the logs and the `ethtool` output I’m seeing:

    user@host:~# logread | grep eth
    kern.info kernel: [   20.777530] fsl_dpaa_mac ffe4e6000.ethernet: FMan MEMAC
    kern.info kernel: [   20.782840] fsl_dpaa_mac ffe4e6000.ethernet: FMan MAC address: 00:00:5b:05:a2:cb
    kern.info kernel: [   20.793126] fsl_dpaa_mac ffe4e6000.ethernet eth0: Probed interface eth0
    kern.info kernel: [   31.058431] usbcore: registered new interface driver cdc_ether
    user.notice netifd: Added device handler type: veth
    kern.info kernel: [   48.171837] fsl_dpaa_mac ffe4e6000.ethernet eth0: PHY [0x0000000ffe4fd000:07] driver [Aquantia AQR115] (irq=POLL)
    kern.info kernel: [   48.171861] fsl_dpaa_mac ffe4e6000.ethernet eth0: configuring for phy/2500base-x link mode
    kern.info kernel: [   48.181338] br-lan: port 1(eth0) entered blocking state
    kern.info kernel: [   48.181363] br-lan: port 1(eth0) entered disabled state
    kern.info kernel: [   48.181399] fsl_dpaa_mac ffe4e6000.ethernet eth0: entered allmulticast mode
    kern.info kernel: [   48.181577] fsl_dpaa_mac ffe4e6000.ethernet eth0: entered promiscuous mode
    kern.info kernel: [   53.304459] fsl_dpaa_mac ffe4e6000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
    kern.info kernel: [   53.304629] br-lan: port 1(eth0) entered blocking state
    kern.info kernel: [   53.304642] br-lan: port 1(eth0) entered forwarding state
    daemon.notice netifd: Network device 'eth0' link is up
    daemon.info lldpd[6849]: libevent 2.1.12-stable initialized with epoll method
    daemon.info charon: 10[KNL] flags changed for fe80::200:5bff:fe05:a2cb on eth0

user@host:~# ethtool eth0
    Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Full
                                100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Full
                                100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  100baseT/Full
                                             1000baseT/Full
                                             10000baseT/Full
                                             2500baseT/Full
                                             5000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 2500Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 7
        Transceiver: external
        Auto-negotiation: on
        MDI-X: on
        Current message level: 0x00002037 (8247)
                               drv probe link ifdown ifup hw
        Link detected: yes


I will continue investigating why the ping isn’t working and will share any new
findings as soon as I have them. Thanks again for your support!


Best regards
Alexander Wilhelm

