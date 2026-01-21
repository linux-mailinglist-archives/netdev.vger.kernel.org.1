Return-Path: <netdev+bounces-251893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFIRFgnccGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC258135
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A071046BDBF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A778478E52;
	Wed, 21 Jan 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMc1pKDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BC2D5C74;
	Wed, 21 Jan 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002667; cv=fail; b=K3kJDysKMQF+yhmBaWN/N69CovcpcnTp5KaQ9YH3QXtqLXD/PMpwzMnmktzP8y2X9p6fnasLj9y4HkEzNitfOqr1AiK14S+cRb0KCvB6hUTvzaP9HyLv/b9KiUcEOYNAB26h1Q5paKAhg7uKNJtfb39UX4UkJNWYPCS4o33vnmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002667; c=relaxed/simple;
	bh=TvtflOPDWtaCCvE+GOWPiQDCpdiHKaKGGCi6m6TJzVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YSOr8y6PMsBoqDqzPhFp5tp6yxySXdPqgC1vuk5TbFDCvsvrFu3gIy8FVvK4coYuCcQbm+AB0LiOgAfbeuIMMLI2CofDB8hvaOk1KivF4Q4S/D9J5Q1oswv8tHfou6aJANcHyfNFY+nTtymKfjouHDLo5wIAO1dO/PSM266Pais=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMc1pKDC; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769002665; x=1800538665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TvtflOPDWtaCCvE+GOWPiQDCpdiHKaKGGCi6m6TJzVs=;
  b=fMc1pKDCy4C40pohVW7PnHH72jnm7+N4SLb3eVCKWHzdCRMNgmTsgy0k
   UDzUCfFbKB+HgwoOIRMyWgXCpHfynW0pOnHRidLZJskXjETL+w12xv2nt
   9AEHqrsKXwaxg8vTlDbKTkpJB86rj2+zzWJuXpdAJNSedoBq1RcR4GizI
   5ALcYjEmJIcALtpwWYIOeyaLLcUQgzavPcZKhyn0KW3yqR0QvAeWWtLMg
   yiHkK0tBX3AN9Qy7RuIotiFlftsSZuF5z4+7uU7/Cg+dl+/f1n4ctKwUW
   zbEyPFbJGbZblf1VjFHKqI7UGRQL2ty3Ekcp/jcm7QHTDY5Wm2xgNKGB+
   w==;
X-CSE-ConnectionGUID: BzJFj1szRsCOha08/CcaPw==
X-CSE-MsgGUID: ziIEnZmsQ8mRsOEuKXby1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81673365"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="81673365"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:37:44 -0800
X-CSE-ConnectionGUID: bLAuT7ytTiWrHshp5RFniw==
X-CSE-MsgGUID: m+br48VRSNKSNSo/UCDVsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206689307"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:37:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 05:37:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 05:37:43 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 05:37:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj1ceiEkSo7Qbv4hlAFdBIgbcSWdF9p7uOudDi5HANOHvn2r3nsUPCwBaaQz+vE7k/lnT4GLHUq1o1fz/w0LDBfr6C8yvZx/8negfox6Z6vjth31N3l4Bl5A0H4gaVjwE+iN0CW1Goz+YJUN4odJL/aSAILEkuZcAbZI8ZmiscxIR8hP2MgnbTlGJ35p2K2eGKVQxXMlZv9e3GWs2N6T520XhIUQ0sWY53WK07IN9HHpXn32xlbnSIYiLeNLOtjYVW8CQjhBlx2XMbb2DMsXpzdNRUcRi9ZX1LVHC34e8TyORcwISJN9bwPLakCTPUf8/v3JnAR7ejL0AYXRZ9ktDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFcvQ3m3VYgLPiLEkX30316wvMI7MnALoomLbg0sKpE=;
 b=vqZW9SH+vxBWFjj3Vm3B5V0V0sX8AGI7j+xlazUHXadwrXB7EGAJpehLsg/f5hYGENh7dcDLjVQSkSGG1J0+0Fl+0FGdHlb81X3WzQ47/8YVpTuQQ+I7ltQa7AL4gfZzhNNHE2C6+VeiowvsW0K2+bREII/PKY7Q9duvdtjXt8Xj3fNwTYusgN04MggPwrI5igPgfRkDQbcJ4q0frXmkPuV6siAuBQoIUsJAA9iHNY15uVxVDxuu+Hz8MRBDEZRH0MU8HQe38jTjh2unu7zdC9fHejzmmGtGGhFu9eHNvnD9vbSj/fP1pohTJ4x+xbI7tZwebG5nx14ad8/omFHhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 13:37:35 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 13:37:35 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko
	<jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Michal Michalik
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] dpll: Prevent duplicate registrations
Thread-Topic: [PATCH net] dpll: Prevent duplicate registrations
Thread-Index: AQHcitX/4OZPvpX57keVL223l6X5+7VcoFFA
Date: Wed, 21 Jan 2026 13:37:35 +0000
Message-ID: <LV4PR11MB9491BC664A5ADA3D0DA7F1559B96A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20260121130012.112606-1-ivecera@redhat.com>
In-Reply-To: <20260121130012.112606-1-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|DS0PR11MB7959:EE_
x-ms-office365-filtering-correlation-id: a1da1f8b-4f09-40d2-3af4-08de58f23cd0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?H6nxuVf6u9xfOIO3jrPwe3mp+yOnsvRDg2UuGsBjrw7CuQ+/JyaJORqE1kAx?=
 =?us-ascii?Q?NLCJJxC1DmxMfY0ty3RW8R66Po1a0wHFqtoLysl9z+xAK0B7FqCakeW9h2KG?=
 =?us-ascii?Q?aTrtAT62FeoqPBMmLlaYUGMAo95hIq4qBVSkb3Bx9rRshz9MTuvIqvmMVgYF?=
 =?us-ascii?Q?t6JD9fO7a1c5RmsT1wNel3lhA1Jaqk9Gk4CDL4nnCGzrb0GxL0KvjAKWLt1y?=
 =?us-ascii?Q?CoZsXqDi+ZIlptRaMxvlSIB3+4uaiIhtEB8cWjN4P0MVOZyNqZP3ZstbxHmh?=
 =?us-ascii?Q?3gdb/9vv6hmAOvYb1NQx5Pww9cirD5/9YKeIstu9Zgh8Dmzu0YCaagThLnkJ?=
 =?us-ascii?Q?Kav+stBfSD0HF1//mthEfVjLwxjmRvQuKNP53/TZZCfO3PYNwCVgN2bbHur3?=
 =?us-ascii?Q?AZAdvpxI9oN94IHGleMdSIfQbEdLCaCez4VBANnaVHZEEBavhWF0jKdlMtZe?=
 =?us-ascii?Q?S/faoYLzbsUR7O11qjl5wmj6OxM95Nn3tp/WUK4l3a3AtsLo6MgQ+5WDjnGE?=
 =?us-ascii?Q?narCZ0mLyUX4yYsUfV+Q58bTx/uOQMSYJKZe62VvFI52lcRlz/3iWEqz8NZr?=
 =?us-ascii?Q?5NWUrnVaWgZv7DB0iHXGKLGbxqQlEf9Q/oIYWis0ZA8FKCMhgGSuXqr7pqag?=
 =?us-ascii?Q?8AKPVp4RL6IpObG+CrhWYcRPui/X5p1w5mDr76chyw49bWTMUreg+L3EqWVp?=
 =?us-ascii?Q?2cGlqvOXKqhRG2xtfIPwMrk1nPki2m5STdPI5OkI2wwX42rS826IL7RcvApa?=
 =?us-ascii?Q?X87X9wZBmkVlzWcojMWv8THUHyd0FmHCPfpkU4GKMhPgPLs2Znl1JRrGx+tk?=
 =?us-ascii?Q?uWzrvCl3pNXNxoP9e3Kn8Ih8pCdyLEAtjKiI94nq/OU3pCS1Q+6Lts986RIN?=
 =?us-ascii?Q?bdJlqgho/+5jG7Utmu7D50C7PmBfyaxHs/vkqufEF18YmJPEYAgrpxxKOe6r?=
 =?us-ascii?Q?sldiQNgFuQV34i827eih/P4EAlSEVhsYxHaAivrlU+NItbC7XbZnQ7zIrWD9?=
 =?us-ascii?Q?TGVcD+tlsUmtA9rqxns5Xsagw1I0hdGMG/eYQE8avbBXkoehC7JKTGGa1Cpa?=
 =?us-ascii?Q?BQjZ6mZmqDY6JkX68w8XySLdamux2SOKUPV4S7uhOF/4qfAv/S2kufiggFpN?=
 =?us-ascii?Q?ApTWbSUCRWUBkIwkEC60CTBEpXrCCiYTlYqfQirGnEyqTeB2ux4M+ptR3Sgx?=
 =?us-ascii?Q?Puijymn9AB4UvaEBUZMSu7ghgpLTn1+Q++3OmwNFv/w4GdI1K8B5FQkc2eTF?=
 =?us-ascii?Q?jq2RnFDED0e8GdUwnbQLNzW8W2Utsb0pzSqB3l3+knmTpfaFx83LYN85OF/M?=
 =?us-ascii?Q?Xofe1beruAxBH6hy84s/QkRxXa9lb9xdMADEOFkI3z/T2Q4HdCwvUdwU8s+O?=
 =?us-ascii?Q?W9ALrdqSm89MNSmPQDLPxs+OLxS1nb/vRKBBMt34nyOf51S8vYFjxXqd063C?=
 =?us-ascii?Q?5zjao2qttscde/Y3b0vB0XJ2xkQwmyr3b1uxvU8R8wCdalgJslIkD4awBtkL?=
 =?us-ascii?Q?HAJZXCPP90VpTLcKo+PA8jb9Lro++XO0HqgxBtb2moA/FGVlyeuWJB94/RIp?=
 =?us-ascii?Q?+h6lDIOAsh0vM/+B80PSlRPhBe2jDvg4HS0L1xNk0Yu7r0Zay+Ypof6Nxgx+?=
 =?us-ascii?Q?4Nqlq8vRXen66LCn4G9etYE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rvcRpMy8KzvG4N2SiGApV7mzDdsoGSdddSDwAGtHYWO6WQx0Mc7bQx9kFf3?=
 =?us-ascii?Q?0Amr7jTJ8nmVO6vkcASalWBMYh0vB4mitbWf8Q7olALo3IWMgnT56szFtqJx?=
 =?us-ascii?Q?XnxpfNTeHoSQM7IdeG05JF0x2tJa/rtuoKPhPi1Ix0JUu7BIKOpZtK/LvG8o?=
 =?us-ascii?Q?26DJro3TKb/rtZTv8AnGSBy73YDdI7JmbUx6cK6X37Cnbun7RfZvdTjyMzHq?=
 =?us-ascii?Q?PlbFrKNCXqHkEJZEHGJtbz4IIvzeNqU2XFfHbQ+PY9VmyWmIfVONum+v8H8u?=
 =?us-ascii?Q?lNbMuxXAtU3qVRF9/z38FGCJctsIkFMupMHdaaSsIQazTj9A2cknG3Jfjs30?=
 =?us-ascii?Q?3M32uyQh+no2lNxPF4X6AqR+kbg1WoVEUp1l5tBYBXkGnAEN0io4SrIEYGyW?=
 =?us-ascii?Q?qPSTynUuwNxkdDTYgE5Y2cLJU3q4kTtcKi4xq2gmxsOZbGXQvgK6/24WoUhV?=
 =?us-ascii?Q?WgLaNGDl9JAI76H9OHdWc/xK+J3hLEMbnrgYMW+zEmTi7qYp1/qT4Z+Mfff3?=
 =?us-ascii?Q?N2jB811zyP6fotoacYrdsispbpKnM3iJZfDi2jh8R4inNjs52mo4QMy0lArL?=
 =?us-ascii?Q?RAM5mM4t6b1MycgwK5uZYWtPyYMZj+gasdFr80uKntQyCNZRM93BRMLIrGT0?=
 =?us-ascii?Q?XpG3S8EDb6sfOf4LS781XUoK2VRZgshVDvqFV53qgt8XbUF7pIUgurcsdsbM?=
 =?us-ascii?Q?Gn9GAkbjlkkXDKFQKH6lMpDZaJICc4z1NLd+TVrgfAHo8srGVuBc7+Hu03Ty?=
 =?us-ascii?Q?lY3YPcNdlz/3PAsiOWeoYhFOWj1SebdBYkqNcK8z7R47QIpb6vf1tErKXeMG?=
 =?us-ascii?Q?DmxeOZDK55LQClvL/9mkkpZJcvWtwcpYxq5nzWpBv+f7bvJlYRfZXHJ8ooSd?=
 =?us-ascii?Q?ho1QXt8jLfDT4uPx9EYES1iTQFK1GRrk7lv9EiSezkKFW1vGiaMMBKgHq+EA?=
 =?us-ascii?Q?RXv3Vt0G9hedCCHjtEgtmwjHnmDRSebDQOaHmF1ekCkO3PfKBVhMVFoRJAZP?=
 =?us-ascii?Q?1o/dVzdEqUolyuwhJKNa4X56mKRCXRHaPfrVXKi8Y/mb0O1kzPUCVaAZfn2C?=
 =?us-ascii?Q?CsiCPCbnTeD6WCIHHX/NttF2Olq5FHezqQGcr4AxTtxG5dAQvTbh0uCyE/UD?=
 =?us-ascii?Q?hl+YXQU7RIrSn2XNZwghtzFqnDEX0nsZR2KtpG/NhFidBYO6nXXfL/QFEpKq?=
 =?us-ascii?Q?f1+fWFzD0elZTnTR+HRYQbNEEsbAZKEhYLmPskGaWSFD25xvwK6GRVQMaqLQ?=
 =?us-ascii?Q?uqekwZJ41F3CNdCRFE7jRNxOXwNzz+527o7iZkVAitjJOBvxJwYJ/gj/eBgN?=
 =?us-ascii?Q?I/1gjFqCGmHnuBYnpWf/DjP9wlom0Y5FzuV2v6yvPNa27FzBqqVp7LF0RIlo?=
 =?us-ascii?Q?PY8enhv2EKIS/g3lZRDqOoPMr4Jb9YvPl2l+FUDl8a0AJxaLtyYh8Q54/onX?=
 =?us-ascii?Q?YhheiHqr3ljFPeErtp82wzWQKRN770ynqwD5UEUhpCGAVE4y4qDtY6dyKEHn?=
 =?us-ascii?Q?zQ+oFdWXqsCY0M7zymudBFnajA7hUmOndUfbj0eX+eXMHgE4r3OXXZzr1W/i?=
 =?us-ascii?Q?jZ6dwB/AuxA8VxSXxuH4EBVwWK7kDcaxKLUrVhx2HPundBBua9EEzj+EotC9?=
 =?us-ascii?Q?2xbHHFDyEY275iDbAsIQWdyWAy44d4w1t6IfI3RQn5UP+uBmNwWc5rI7PFe5?=
 =?us-ascii?Q?WwDjLxer0P8xySusj5KbRm42jK+q2SzLLGDxIyuxcKg4ojFpTdVpJ1hEtL1Z?=
 =?us-ascii?Q?SH/wJrWNhkNFb5dLSUQDxLklll3lKOw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1da1f8b-4f09-40d2-3af4-08de58f23cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 13:37:35.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sbmD8deqfN3r53ImbZN7HQKaIEvojP9iDX/YROSEk+zL0EDl65z1aqiHCJFSOLXTARxPmZq+Pf56LaktzwYQVZ78i/gzG/1n+fd8G1vEsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251893-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 69EC258135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Wednesday, January 21, 2026 2:00 PM
>
>Modify the internal registration helpers dpll_xa_ref_{dpll,pin}_add()
>to reject duplicate registration attempts.
>
>Previously, if a caller attempted to register the same pin multiple
>times (with the same ops, priv, and cookie) on the same device, the core
>silently increments the reference count and return success. This behavior
>is incorrect because if the caller makes these duplicate registrations
>then for the first one dpll_pin_registration is allocated and for others
>the associated dpll_pin_ref.refcount is incremented. During the first
>unregistration the associated dpll_pin_registration is freed and for
>others WARN is fired.
>
>Fix this by updating the logic to return `-EEXIST` if a matching
>registration is found to enforce a strict "register once" policy.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> drivers/dpll/dpll_core.c | 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index a461095efd8a..8879a7235156 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -83,10 +83,8 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>dpll_pin *pin,
> 		if (ref->pin !=3D pin)
> 			continue;
> 		reg =3D dpll_pin_registration_find(ref, ops, priv, cookie);
>-		if (reg) {
>-			refcount_inc(&ref->refcount);
>-			return 0;
>-		}
>+		if (reg)
>+			return -EEXIST;
> 		ref_exists =3D true;
> 		break;
> 	}
>@@ -164,10 +162,8 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct
>dpll_device *dpll,
> 		if (ref->dpll !=3D dpll)
> 			continue;
> 		reg =3D dpll_pin_registration_find(ref, ops, priv, cookie);
>-		if (reg) {
>-			refcount_inc(&ref->refcount);
>-			return 0;
>-		}
>+		if (reg)
>+			return -EEXIST;
> 		ref_exists =3D true;
> 		break;
> 	}
>--
>2.52.0

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>


