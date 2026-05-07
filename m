Return-Path: <netdev+bounces-285089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aaCeNGPf+2nLGAAAu9opvQ
	(envelope-from <netdev+bounces-285089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:40:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5B4E1BF0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD4D301BCE7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B2175A86;
	Thu,  7 May 2026 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bpFyt4wh"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C48BE9;
	Thu,  7 May 2026 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.26.1.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114399; cv=fail; b=TlUXg/jAAXY0JIO11J8UxoYiyXVdHCFuLMkABPQOUnTw5b6Nm7FOdVleqpNDOaA/rClpWxMD+YSA67GhnCDK3/kbzdeEnepQJi4rNLkEWgM4xYIhsVhzeqBk32ND1QXqMRPSe68JnoG88Z9YIGNQXOJgyfrJOBdRMSgp2gemFGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114399; c=relaxed/simple;
	bh=r0+I5prPXZ8hV2mkGmW6ubrC1XM+JO5LbYexq0yDWIw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlGVp/Cspoc69m2RGpVONnX+fvnzK1gYu7qi2Vji+FFwCyKPgjhC/uc5fgtiLlG1dOKkB2nCeyXfG9s71wCNg35wxgoDHc+d65L4IrZEW95PjdBlDvorzVIeEAg0BQ1RzHCCU7MtKSoQmWOChW+FW/pWLVSdV5VkeZXSViXGJ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bpFyt4wh; arc=fail smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778114397; x=1809650397;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=r0+I5prPXZ8hV2mkGmW6ubrC1XM+JO5LbYexq0yDWIw=;
  b=bpFyt4whEOCERgzsinkUq5BwCVPTNC1rmqRLaFQsxe4cFO6zo7/f6e6+
   YYRDKKjUJmt7y+CvWpGLHHqNrSGEnTmZx9qcMVNTcIX8H3a63j6kULaaz
   8QYi605mWC5I/hZYIrCCHxlFnb79/xa36BwpROWfEWIv3OQiSTyYqNfLN
   R6vFABrigMXClHNb3JEQqHDNKz+pWI2YhqbFN/SpIFifsPuZoNnq5RjYi
   i/h66Kvw/wHJcUbgS/Csp+O7ouVDyVmhn7DAuQtgEACvE+8TJ3eTzShjK
   YFLzRf1oh2HCasQL8NUqSuFt4oaR0LNnD9dKpNynMCgS1DP9kNsVIJhai
   Q==;
X-CSE-ConnectionGUID: 4oHbs7EITIuH0VSI24DqQw==
X-CSE-MsgGUID: GZ+liM8xS92PwvtIaV7BMw==
X-IronPort-AV: E=Sophos;i="6.23,220,1770595200"; 
   d="scan'208";a="19068413"
Subject: RE: [PATCH v2 net-next 5/8] net: ena: PHC: Check return code before setting
 timestamp output
Thread-Topic: [PATCH v2 net-next 5/8] net: ena: PHC: Check return code before setting
 timestamp output
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:39:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:15737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.165:2525] with esmtp (Farcaster)
 id 638afad4-acd0-4091-b36f-27f276e20f42; Thu, 7 May 2026 00:39:54 +0000 (UTC)
X-Farcaster-Flow-ID: 638afad4-acd0-4091-b36f-27f276e20f42
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 00:39:54 +0000
Received: from SJ0PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Thu, 7 May 2026 00:39:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAvOpVccZAspIEZQ89Eh2uH+n9KR4/KIIQaQVVpiY+F7kWlTsti+/DXER3bwyNIVEEwRcPR3zQbV3Cg99MOtHskCoUme0j88JWVBBH0TlTTKKZoTZcpP6mqwf43kvFUh1LlI48LWCiajgTlfWXDi/mtE80gEPWnBBS/OkdNJY3ZkyALdiDNe5mOs/OFFOeilCbKTpduvUXAvUKP3O8jD+l1kPLjq18d0bfh4RwahdqFMCYVLbyX2FQRccrdPX4j5K8ijsg1DLXfNpGvA8qUQ74S/b/ymw//ofnerLPb4eznajsAjM7vy8iLJ7oGFDOYjCxYPxg86DZ+imefleOE0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0+I5prPXZ8hV2mkGmW6ubrC1XM+JO5LbYexq0yDWIw=;
 b=CxbRQ0BFEwcdffuLONlBnRzsreCkKU6897UW1/2spvyuRjINLaRdln2b05Ys2nwiAVAFW1/S+SgIKOTR2VBAnLWkYgBxQ4qYGLUVKzpCGlbt942dttQlWVvzwV27TFtZa+JGShje4K6QfORuyyVtIyhKprRy4EQ4CVs1u66XP+f4WGtnkDWD5xMAB6mMBFDCD+1e5a6vU7o9I0oDgAdxyM4lBIasG66F3FarRGwt+TsG3OT/o3mT8HtZCO0D8xeDaRnB9Y1zKFLgRHMvIxfd6OTeFH4g+vhxyTbHw4u0kW4QXeAtIOxoFsghGbHFqHPCISI5cFGem5cdH6vODW09WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by MW3PR18MB3449.namprd18.prod.outlook.com (2603:10b6:303:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 00:39:46 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%6]) with mapi id 15.20.9846.016; Thu, 7 May 2026
 00:39:46 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Sarna,
 Yuval" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>
Thread-Index: AQHc2FEc/qbTedGv8UWZ4Xwyg8tasrX/M0YAgAKPAoA=
Date: Thu, 7 May 2026 00:39:45 +0000
Deferred-Delivery: Thu, 7 May 2026 00:38:42 +0000
Message-ID: <SA1PR18MB4664C072462EC72ED65F13BCD93C2@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260430032507.11586-1-akiyano@amazon.com>
 <20260430032507.11586-6-akiyano@amazon.com>
 <20260505093130.GP15617@horms.kernel.org>
In-Reply-To: <20260505093130.GP15617@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|MW3PR18MB3449:EE_
x-ms-office365-filtering-correlation-id: f798e123-8d2a-4b0d-8891-08deabd12359
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003|38070700021|3023799003;
x-microsoft-antispam-message-info: oTAGMa6AHu9gIqpO87Mgea96dYjSLk8Ba/CUnorM5V7NMS19oLlb0hLl+u42y0C0vn/Id2DQiepMyvtBfjJPc7zPoM1J1gZV5Cf3GCkP4JYzL463IwQUnUdQQRy0piLTkNBkqhxPjWvDJw4xEVrhSG5fc2/d2QkZOIG9FkNci9KCIoyykMn5AKkBHyqe+jYluCLbcrH9s6y0IG7synTfySX9iod3WS8RBZbljLwnOgY3rzp4RqBR8PZXmSkdQz+phUgqJA9lLAlUvp0kVzbm9fHAyenkhGipSpIcOXm+hDFtKv3KIv81E9LRQnYpo+KOsjOiu/KiNUoSt+ILT9aSBuJGBT5dSmupYDLOoXXeGztlxxmzMq1i/xafPgEeJCmCYNB4/253uaGMu7PPod0Auo6PrBOxD+c6w2UjJuIoV/lZcaQoz97ivRNXcv34FZm8QsXeRt6rhE6eDmSqJw8xHTOdhKRHWQCVnFMwycgGYXhKUXMZN8iZ87HQmtxaMwKNaCsIewRO8dRbzik0T1Lnob2JOZZWLXr69WfhpYTDa3xefNafCXIw5byteJ5GGiJMlDf4so6C5gLSur9NtbJQiRk7+REELQ1KuwkJg3Xgzkp8QsMUnn7uLBdf3hEH/0n7Xc/xew9XgMwpkQD8Raj22h15xPOH+C1tr+KrjqKAMCArtEF/WUck3dp4WXoLlezJD6xoyxEK7j9ilNPOyD15AwqfrQZ+e/zTJehTaHhJbR0JzlEWuuUfG8JThP+kNnoI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ROufWxO2bKsyb1IO3V6yZMYZdt9SRMRGgyCnGbODE18fHyZLHlh2r6eFxCxk?=
 =?us-ascii?Q?VGzA6TtTkPGraogL9ykYvTfdPrskVe62+tirGEP+qGwskAmEpVFahEgonB7I?=
 =?us-ascii?Q?pyzXttfG7WDQ0pFH/lafXRoAuSL17k2zuf7ZJEFWjzYITFXsZ/MD1mMs5f/l?=
 =?us-ascii?Q?yH2GJPuWcI+vtUBTD7YBK0zyXfPwv4uVEoo6BhxCtDl0JO1/dIHcrcfVxqnX?=
 =?us-ascii?Q?I4lwXm3Kwlf8Paqt3zKR5gS2lePL7h8cPLGlyeTEelLsyS5h4FRYMZWc3DVd?=
 =?us-ascii?Q?o7M347mFBtikrjY3IsXjdrCiXAkN9DA0qfI0nztYKS3jvZahCrn4JXys9hew?=
 =?us-ascii?Q?AVvflqOs84roKJvIuQmBdF22h4S8KfYxp0g6fC2cjZWm6u7LPnRthxLDDP2C?=
 =?us-ascii?Q?QTPnIPSMgO0f21/sokqK3tmdlDgO/6XpTmkqxzvzLBlpfcUiEyixYvvd7MlO?=
 =?us-ascii?Q?ymqw+lZ7ACggdSNgXfRkFK8JqK6yGiSZrWhcCyDLS1sbN1k0dbgc+u3B5fHs?=
 =?us-ascii?Q?1aI8S0NQ+P0QXcS7Oydi7c+p4Yi59IqpWUcEEDHQQ7mgeHUo9GsjA+v4mRm0?=
 =?us-ascii?Q?IJ3mNEDN5T9NoIycVPcyVdSYBVl7c+mW5JCCndi9L+t2svcEmYLvMQg+EQ1+?=
 =?us-ascii?Q?LQOE02B2tdxc4RIjSuygtQ3XvS5ShjtVONTXHa+Ds4elDnAto9a9whW8Is3M?=
 =?us-ascii?Q?TpSNwd+IaHbeuzX1R2xG+6kS9M0IpF9yRuOrDihWC4Q3hWCvagqv6p+unMXe?=
 =?us-ascii?Q?uRggYJcBIhKP+kptXros+NErv/so3W7Ira4EKKo0mEBKUL6c/+9e/6G316SX?=
 =?us-ascii?Q?AxWr+ns4vxAy9f1tCEQRFraAz5qx+PCunTQkOxkUyguB61PE2RKdnX3u4cR8?=
 =?us-ascii?Q?wztO/FyxuGqZ2yRnje5A3KibcMGA/qXWVl1GTYncH+1VBi7JrErT6xV+Qip3?=
 =?us-ascii?Q?d2kgdnnCibe+B4oVyIEUFujG5IdKKaYo9mqd282B4EVQbaE/7fd2yc1WVfBi?=
 =?us-ascii?Q?Ks/kwaDf4TEQw0hnxUbUF5+oXwXzA4Twmr57Kr4guu1G3GcwI74khLyvP43a?=
 =?us-ascii?Q?Ly59Jg5sW0FlTAizthrCaWEMUi27QEn/7IBhIjP1MniMdV8FawCuA7QbU7XY?=
 =?us-ascii?Q?ug2dP9JbEeCrQVynk8J3DZ0PAGeUMscpLX/BSSIwmIVlHfie0Kt/MoVKJUV/?=
 =?us-ascii?Q?PAmJbALW66xCt0LcqQirbaudSwioJ5pmqPu64y9CtoLqkv9EDuiEHWlhLwqD?=
 =?us-ascii?Q?wYnZjFt13rcT4tv2yyAQBs6zmOV/DidjhExegYynPv0C5XvWQiwpbqN+mifh?=
 =?us-ascii?Q?nbsrMTAALuKezbFCmmOzfqpaTmAlJbHaxEZdsKNoLOBP+0/BOh1xh0rEeYhQ?=
 =?us-ascii?Q?9s97aR/oYoVzEWrgSZrl71QMQdVk/cw86CgzXT3i7u5VxlAB5UH/cUj7RUR5?=
 =?us-ascii?Q?pHlm90tnLa1kxogPHAyuqfbTSPQe6vUTHLK0TmvdgKoyA+Ff7rdJlK0rUB3z?=
 =?us-ascii?Q?g5GCe3b2j9hg0Cn4BZ82IjsfjbcLG+458mSHdaL3rZidSB8ovG1pGllnDvBO?=
 =?us-ascii?Q?O2mdRYXD66jxXv46grt4+RukeJoTTKq0y0wlpIodFB9iAoW+Q1I3pMF8Vp+p?=
 =?us-ascii?Q?HcdgISjs5IFqreUyRs8ez0csLNMbJhT5bs9OvsSpYsMP753GByBU4PUHhxZc?=
 =?us-ascii?Q?xFMA3XyK/Ayvw79wGgBm7C7+E35JEwOpBKGklvQ57FjJJ6X/9XhA1dRb3Egf?=
 =?us-ascii?Q?g+cl9bwliQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vUMH2wlJJbvpbKoKzgLAjD0XdcYKU6AwnqeYJTtJEOGm95cwOaDJRqzteObltYC2nwmdsl1KYn7OQSQQdt95rjBy0xgbgeiEQ4dC6QNZRyofymXFg7HZdKvbn2o2q4gYZ8NG2SOrBeuyPUCLBhlUlswfI5ITVIVSx0KjzIAe8A7Ny5nYc+HYk46MXAReDwubnREZr+h4tUIiYk6KdjiRpYIitRcr0Z93AxGGb29Em+rmR8idOyFCQzNV/u/WxPcGrWEiuIa8YbR1/QLZGS6DqL5IJQoUxKYIwJA4lkS6TxWetG3LfxIP2REwXICnmNS3zF0sGe8TlNTk5HOUmikokQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f798e123-8d2a-4b0d-8891-08deabd12359
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 00:39:46.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns3ODWWDisPUhwy88jd2Y4LVMa0cZDoy9WaWuI8vbTdmWJvaQwjxtwyyrCCGlgIr+coIOTLNAi0Dg9z+OgmB9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3449
X-OriginatorOrg: amazon.com
X-Rspamd-Queue-Id: 5CA5B4E1BF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285089-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.co.uk,amazon.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR18MB4664.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Subject: RE: [EXTERNAL] [PATCH v2 net-next 5/8] net: ena: PHC: Check retu=
rn
> code before setting timestamp output
>=20
> On Thu, Apr 30, 2026 at 03:25:02AM +0000, Arthur Kiyanovski wrote:
> > ena_phc_gettimex64() is setting the output parameter regardless of
> > whether ena_com_phc_get_timestamp() succeeded or failed.
> >
> > When ena_com_phc_get_timestamp() returns an error, the timestamp
> > parameter may contain uninitialized stack memory (e.g., when PHC is
> > disabled or in blocked state) or invalid hardware values. Passing
> > these to userspace via the PTP ioctl is both a security issue
> > (information leak) and a correctness bug.
> >
> > Fix by checking the return code after releasing the lock and only
> > setting the output timestamp on success.
> >
> > Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> > Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
>=20
> Hi Arthur,
>=20
> Perhaps I am missing a dependency, but it seems to me that it would be be=
st
> to separate this patch from the rest of this patch-set and post it a fix =
targeted
> at net, CCed to stable.

Thank you Simon,

I resent it to net separately.

Thank you,
Arthur

