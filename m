Return-Path: <netdev+bounces-256894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FMyLWXrg2kSvwMAu9opvQ
	(envelope-from <netdev+bounces-256894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:59:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69503ED854
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47FE2301413F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9821A453;
	Thu,  5 Feb 2026 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHtboEd/"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023414F9D6;
	Thu,  5 Feb 2026 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253153; cv=fail; b=Drh/KAVap/FOE13LF+HLUbSqkNMZaM1AJGyKtEyLbY+d5mYSi4xwKHkvZgCvlzJX+icxLKHJ/sJp/b8f6kKUrwdk0M2+u7cllrWV7Pton7gao6KVJZTXC5UAjY+Cls9OF36nPUgdxOard2Xv/7SUb+BoUdIpcPI1tCqWkwAUOAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253153; c=relaxed/simple;
	bh=ovkL1tlY1WlgYbbxSPEJtOezUnbKicjQuR/PPBdbqWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k3jyPgu0U1XzbQrkOQdlxDI7dVlb14xzmT/f+3wDYIkK9dhSRWWfENavNrPdNLnmvkSWGwG1Rh6lzs1tJNfuSOMCSi1EA8tvipK+xZzr6ol/YjN8ekz4l8uxrp2J8Xioh1Pub9EcSaeFNuGUelcCucy5SRTU6qIdpCbbc+Bpdss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHtboEd/; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKILfu308vp0eVadzKinWDz9DCqZvAB1Ya2r8iGTwwEqCUmS9NM2qcPzheuaBVkOa5kzrkB8IOrA0/r0bIgH2bffDnqltIhDYDUr+0a5MpBwO9FE9SXDLhoowhxJXBgCmomA1zA7ea5mYfK9IyeceI9eH9VX8tMS8eOnYaxGkfVtxkBxo/ovW2j1JkeVC7rqDx7jRwUKYJqginhDNOvUD8zsp2WKowLorBtHyM676ac8OmPaaIJ9QK1AOSm3a/vQ69AN5MedtQUzp70bsVs4npNq0nBSDCaZJl/7D9+YnAqxvV+z8oyYv/2on/pcFZtNXXhcpuQFfkLaWc/VV3vN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8LDDYhdc794jl9CSP4mSnpOmcJfLFsvVv3w+NBtdyg=;
 b=hrMLiDBQ3/oJDDYSzZB7HKn/xwY/xBLkJqu7pQsVyodZSZ4rVsN8hC7bxIpBladMhcndhqC8tP8yJAdPx0W+NmSwCqUKiHmWUf4bznvRVh1TNrGrlR8e9H4IjhIp5eV9DdC+L/AzTxQxgJxglKz3m5dMqYw4mo4ahOkWPQQHS9jvCy9bbzPZimYe05un1DIk0vPAIrSz/ukwt8U6T3RWJyiIp3b6kijFmZVv2JuydztpuqI65k83gmfxVzLLjmtL6dcXAXtexMPaNpcTfI9hDQ0GwF0LmAGkwzgaAj6fXlv+7YLUv12/LLo9SEu3tgh5Xkg+jOH/DwZhBuQ+KYM8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8LDDYhdc794jl9CSP4mSnpOmcJfLFsvVv3w+NBtdyg=;
 b=DHtboEd/x7CapS9p82uY3YtgXyrrmkkhb50b96HLuDJY9yZ+mF7cqoKrKBUsHh0J538uasxw9RKzq3o0n/KuLTNY1wl7lUiWMarYHLioAyxyLo1GXHFpzdJp39pIWKX8CF+izsrsPoNQYvn7LsGove7+0c6fIxY4cIAkIamYDlv5hiEdw9eRP3m4Ym8lwBFYXFCt2OyAr7g/8A+RlmNWeN9KEBtXhKls9ZeO1+06+dCh2Rw8cNCc36fsNcmQdXlNZ91om6QLCpV6rYa+Ys7EGUM6BFDN+/M+CzzfKs/ApRedWavw3qtTVt45msaY2GPnSkzbUs+AvSLOixgqU9dDHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10112.eurprd04.prod.outlook.com (2603:10a6:150:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 00:59:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 00:59:06 +0000
Date: Thu, 5 Feb 2026 02:59:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	Ricardo =?utf-8?B?Qi4gTWFybGniiJrCrnJl?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
Message-ID: <20260205005901.gnju3zmqimtgeu2b@skbuf>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-7-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203105417.2302672-7-larysa.zaremba@intel.com>
X-ClientProxiedBy: VIYP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10112:EE_
X-MS-Office365-Filtering-Correlation-Id: cde789aa-f1b0-43ab-d75b-08de6451c2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42YBjz+4uWjNCQ09CQ80sLGTTC+ENaPaBplgdbBqK3d8AF8/5ZVnKVzf/47p?=
 =?us-ascii?Q?2bbRwC56vajuB1oDTvERqGVWpyBdbcW6UPHkA3SF5MbRZAuN7rg4XUipaFAS?=
 =?us-ascii?Q?wDx9BDI4DYcTqVHRSFvYbyhaLBn1ruM30svCa49ZA75oCNbhFQYTi2t4rdB1?=
 =?us-ascii?Q?5z+T7LFfAjr7fY6DRlrGyOPJSaYQ1INGpJ11M86dyLePh+Vw23oCfn2GbHdy?=
 =?us-ascii?Q?zqQU2njIya8Uk3rWSsG0ldtri3c4ccfmNdp6EoX0YhwQuPvMt3tgWENtmTSt?=
 =?us-ascii?Q?gA19ErT0tfXn+f0tuBOIZDtQu3n4FohOMb5QD4BftlltU5nF4b3nAfuIuIjH?=
 =?us-ascii?Q?kXTpgi5PjQAuRszIxFU8XM8KWTWu1vMH852xoGQYpi9Nmb7eBWwZF2sh1X3b?=
 =?us-ascii?Q?nhO/ZKo4hhR0ecceBAs/PsbjZmjiO8ANEXMpNpZsTia1GUm1YV2OyUZgs4kk?=
 =?us-ascii?Q?czmzoR6VBH5aSe8/0/fHSrimzMvtaGo+YM0zU3sGkf++Ulk02+kD2elyscLJ?=
 =?us-ascii?Q?0zp5dBXFyR6TYS+DwSjy5Dm5iKON3sfSSOAIzHaZsU0Z+fXhaSKHDYLELtgc?=
 =?us-ascii?Q?ilNyXJK8UduPVt0U179+DRY27MfFFrEkTcWYl9r7zWF1/VD5BG14OI+xCS7z?=
 =?us-ascii?Q?qSLXP3uqOSnqE1+mG+w2+E2oWyHtQoMUE2zhuMCnKLiA05tk6sfUkSWvnfQ6?=
 =?us-ascii?Q?mw4zXoTwDyfYDAIojRNuzyaiP9xqC90a4CvQaojKX7P48ovOT1/hdUxRyGTO?=
 =?us-ascii?Q?QH3gQSKg/HEz/dhLqTIkWET2zMmXjRS6N5KiQ8Kb5hDU0X0q5dUm0C0lhcKy?=
 =?us-ascii?Q?IDuhk21jOqfZr1HqXHwzrrG9BvsWffMIULyVD/D4xDdA0OKViTXKXY/SsGxB?=
 =?us-ascii?Q?JQHGKA/7lGoDpW4ao+He9+iclHOu15hyOSUFx59w2ufioS7oQcUhiRQqis39?=
 =?us-ascii?Q?fYC2hVa1QrI2Ki/tO8xGBi0fMADyatGBqC70yCKJLc037GbkgNypIBuAr4s5?=
 =?us-ascii?Q?bPmJq6UIH1AblsPJ/NYskpqAcJB8YLBllHicqciQ5nRyYEEpDrQUKaOSvvnx?=
 =?us-ascii?Q?VxjW+y9JfL5Bwgrfr/QSnPwBqFCtyPhHJCxTxousvIfK7Svsusbbj9vdYU4B?=
 =?us-ascii?Q?+3l/f6Q24zuWZldhHHk8lvj8MdgKj6wuLRGvqaG/WLWLq6TIvS7GqeSn7Ki+?=
 =?us-ascii?Q?t5Y8WxcsBnM/+YQY1ZFwuUdf+0DHNT6ILr4xWTAbGGJc/75t0vqHAO8Q0yd5?=
 =?us-ascii?Q?c+Sd8RepmCOUpohmBvvJGCYN7aLP4OM00L/TQ5kU8Zjje0LS/a/aGpK1ICCj?=
 =?us-ascii?Q?9ud//ys5Ca2siChaPwktFcDe8ueAkEyYD/AeiCBmjBKJLL7o/7LA6PabQUba?=
 =?us-ascii?Q?NpnsRVEnzLohg8TLRl5KbicyVjtm0UTMLrgj3Tupry2rcCESD7SxyfPaztMo?=
 =?us-ascii?Q?jLVvJSDKzMFR3UwmfL6amkTkyCMJGb1sCwRjUOtmStXje3rvwy9ppumaNY6R?=
 =?us-ascii?Q?bJVhiEptmbWc3F5x6kSOSZqNVFnjtbBKuYFH5OU2gh7721Lki1MOJuoQI/Qd?=
 =?us-ascii?Q?ALij1nVi3JbzCOqQoCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqQXlP755UA8mI056QwZU+O/yo55KqLMsPZ4GA1FxkMbvWrWus8ll1R2CXIo?=
 =?us-ascii?Q?MsgSvGbgKCSNl/uLb79PQvQMbonJTe41qB8IQulda5J3KuttsNf8jvztvIJK?=
 =?us-ascii?Q?m1Af9qZnkj9ZCwFwlPj9DapEDrxXSwI4FFMU+Ga+d3HLcrIt5Nh2uxLApU6O?=
 =?us-ascii?Q?ldTheI0SqbjEHlGEsVWzmLXl/752NTTIVxwRXP8SSnLyL2Gim2ZkK7mqqwTO?=
 =?us-ascii?Q?aZGsmUPMuazHiXulB831b3FqPoN4WiQymtRvM8IU8l60TaVog9AEL52cbEVG?=
 =?us-ascii?Q?FwpPdstOxlDOaoFFd4exJHL8Dy+zVUi8xP1Sp57g2fDRaulnqMKpStCizSTB?=
 =?us-ascii?Q?/q1xHvWaun+IXul4plzpFIcZmSZrRZ5/ZxSxYuFxpNnGFNWcQqfgFgSXbjme?=
 =?us-ascii?Q?mw889QtqaDqZpjohhVOPVaIp/Sca0ZfR1Cz4BGGBYQMQ8JVljHbyk093yOGM?=
 =?us-ascii?Q?psaDbRM1VmR3VR9qvx+/MKNc1W0feyT8MZdrp8wnhAMn/saS4j4kjddxpDhT?=
 =?us-ascii?Q?vRvw5ImXFtfc5FYjivjc/kTgiTWZiM9aaIa1/ogLebhhoSvhTGQMKDUPf+OQ?=
 =?us-ascii?Q?5nUHeqlA49VVlJVoFIb4OAC95HCwA27/TS8nqzgzFJ3Pg+18nCy+aoQbXVup?=
 =?us-ascii?Q?aOGHP82Ew3K+KnMgeoNK7Dh7Jw2n4pxjMd9wojBE/UjsIaN0FHtGCkYsNjGb?=
 =?us-ascii?Q?Beq+61H741dvIkX8r4FEeWL8VZItdTdPn/8m+uxGWYEgubD7mYOd3RX9iAlk?=
 =?us-ascii?Q?LA7FxfXxT1ZmA2SPK60tq3xJtpyGqg9W9HcSKibdsf2ZcdzKVRKAcuyIz0aN?=
 =?us-ascii?Q?AYTGmzKYqwDk6RGlRmhIZEnT/h5v1L5PbPzEdwK8RoB7A59mH/3AtSeY4P1i?=
 =?us-ascii?Q?mUnWQpXlVnIzHTpJkQ3kNAG8DVoC/YSr1OCln2mF4N+B1yeZwS3fiJDo6gEy?=
 =?us-ascii?Q?pwCuClvW3xQ9kyraoEJj12/8pm0VQh+KCXpGaHPSSrEV4ot/cbo2/rCwswkg?=
 =?us-ascii?Q?/cFzidMBWSZf556nHd84ssh1yzDIDp+sXpUKcgO+BMC6/2mDan/mjBnWkDCL?=
 =?us-ascii?Q?l3ytRyYz2i5huNEOrF8dRBsoIghhRACFpTy0rQ4m96YGAcrnmOjVhG2zQgQd?=
 =?us-ascii?Q?psCFevC2nYY+WEDwDteqSW3OpwC3RHFrx/zPAHNRoWuaH/135GgneP8qWSI6?=
 =?us-ascii?Q?HLkiy4dF7fPQN5GhCDb6+oBxJlMDlGps7sVapdSmpeJTsCr3eM2xzxMxVAK9?=
 =?us-ascii?Q?JY9FJQQ6GV5P/DURAlYgY1p2wYghffwYdIEfoqwSF3a8h0caW5VbScVVJcHI?=
 =?us-ascii?Q?3qjeGild8idAOUdSuS7WWW3inUGMibUw4Qse23gNdFqTJ1RGZKux2tuV8d7M?=
 =?us-ascii?Q?LDcJLmb36AvK2DVsJnyNFA4XW3Hg9qQVkVhiO3qHkd+gRDHo/rKRf1793mXl?=
 =?us-ascii?Q?4V2iHzqW7Wvr+44YLO4u1h0dtYcvHefuL++V92WQujapzmpnl3JPhkUAbA63?=
 =?us-ascii?Q?ffSijMk8h2Ke23M+43fIOfwCWpmP3pJiSkSlyMEGUUgBiayc1iTlVjZswo4M?=
 =?us-ascii?Q?hp2WA0s0cmGbLZuzCRgeAuigHOnfbVZR2N03YKBATI342mSvwa8rtMdtqgKY?=
 =?us-ascii?Q?d8B9JO2loYA4aEJf4zs3IOQ6reJuvgKNVMC4/+mL62fN1aCJGuGARB1l/j7M?=
 =?us-ascii?Q?jvVztPkh2g1W6361BpV8EViURm1pamg5BxRos3IPPQY1H9tDGGI8OWBltzv3?=
 =?us-ascii?Q?KgZwJVLe6PazOd0oG8WV8ABPep+aiTL8UEE+gYnsMTpjBWsYRtJpRVXxtnd/?=
X-MS-Exchange-AntiSpam-MessageData-1: l3bRp+AnslxUcWdeIT41PFxtJFHu9aRN5Rc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde789aa-f1b0-43ab-d75b-08de6451c2b4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 00:59:06.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYMsvxeI1sOIfYIdE8uY0XNtrR+po9IDZvriZaRf7wA369G1YY405FoZjghu1QAW/38uwS3Z7lZ9RTocFY6FOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256894-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 69503ED854
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:53:34AM +0100, Larysa Zaremba wrote:
> The only user of frag_size field in XDP RxQ info is
> bpf_xdp_frags_increase_tail(). It clearly expects truesize instead of DMA
> write size. Different assumptions in enetc driver configuration lead to
> negative tailroom.
> 
> Set frag_size to the same value as frame_sz.
> 
> Fixes: 2768b2e2f7d2 ("net: enetc: register XDP RX queues with frag_size")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 53b26cece16a..389331571d9e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3465,7 +3465,7 @@ static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
>  	priv->rx_ring[i] = bdr;
>  
>  	err = __xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0,
> -				 ENETC_RXB_DMA_SIZE_XDP);
> +				 ENETC_RXB_TRUESIZE);
>  	if (err)
>  		goto free_vector;
>  
> -- 
> 2.52.0
>

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks! This is an extremely subtle corner case. I appreciate the patch
and explanation.

I did run tests on the blamed commit (which I still have), but to catch
a real issue in a meaningful way it would have been required to have a
program which calls bpf_xdp_adjust_tail() with a very large offset.
I'm noting that I'm seeing the WARN_ON() much easier after your fix, but
before, it was mostly inconsequential for practical cases.

Namely, the ENETC truesize is 2048, and XDP_PACKET_HEADROOM is 256.
First buffers also contain the skb_shared_info (320 bytes), while
subsequent buffers don't.

Maybe the situation for Intel NICs is different, but we don't have the
ability to tell ENETC "you have this buffer size at your disposal for
initial buffers, and this other size for non-initial buffers". So we
just tell the NIC to DMA a maximum of 1472 bytes per buffer, as if all
buffers had skb_shared_info which shouldn't be overwritten.

That means that in non-initial buffers, there is plenty of tailroom due
to the space unused for skb_shared_info, space which bpf_xdp_adjust_tail()
can safely grow into.

So as long as the tail doesn't grow by more than 320 bytes, this growth
operation is actually safe even with the wrong rxq->frag_size (tailroom
pessimistically overestimated until it becomes that unrepresentable
negative value).
My tests were with bpf_xdp_adjust_tail(4)...

I have just one nitpick about this series: your patch order *introduces*
a bug for me which didn't really exist before for practical scenarios
(as explained above), since it fixes the offset > tailroom test to
return -EINVAL in patch 1/6, and then it fixes the driver in patch 6/6.
Normally, you'd fix the driver first, and then you'd fix the bad
condition in the core that was sidestepped, so that you don't introduce
regressions visible in "git bisect". I don't think that's major in this
case, so it's up to maintainers really if they request you to resend for
this or not.

