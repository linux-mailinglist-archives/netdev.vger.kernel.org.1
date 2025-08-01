Return-Path: <netdev+bounces-211339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABDEB18156
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35000627D01
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC521019C;
	Fri,  1 Aug 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="qr5IfmMY";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="exLZJxKl"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC520F098;
	Fri,  1 Aug 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049294; cv=fail; b=jdP5l4/seUF/+gH43vP4hOOCJdeqgI/CRjncPL7pwCN3Mj+p8XBjbBTBOJPuFdSg9DwnpUHNHQgafBHTTWqLgFz/j7koOUK8QfB0KF9fwGaF5OtQE9HYnhd0HOF5gvgrX3QIspecYc8cOhg/VqzpGuePyCap0TFFAOOLqoXBFic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049294; c=relaxed/simple;
	bh=jGvwfg7jUm0zgCQmqbRSZ92PujlvC2h2zcQOvJhbjsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBb3+diGkZpCoNfoLHv402j0R84zzmugiWSWMEUs7ayBfuZ0Q04qtbTmj7vSRh1CfXa7o2MaQxcHxp9I3fmfzWR8rS+6kksHA//fmLoA9hCU6vzUaByqPneRYiX7WZnDqg02kcYLokQPza5KKyhzURbZudUKyzj6yEkJUtfcik0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=qr5IfmMY; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=exLZJxKl; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 571Bsaat3229215;
	Fri, 1 Aug 2025 13:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=EkD1qemr1byVhqxx/ZITxKF3
	6VG7Jo1oOyBObqPU8ls=; b=qr5IfmMYcofwlIjMngzng8A+9mlyeeUfbZttd7uC
	luN+KpyJWTnIBMrO4ihmWctAXOM1uqhpEy74/7aC+WnQkn3Kxi+54N/5hPRRbXsF
	M7ugDYh7mckY3zVt6IJJ8+kosv+K0AGENE8ZhQ0uylh1Bxe0nxjoVtm5p7cJzAU7
	hrEVQI9s4N/IQseMcHCtpBdVKz5vv5f0mSqD/pRFDPoyZ6hRc8VgIwrqc39F5Ct/
	+u1pzl6QEUC10c8asAupWneO+9Pg2XxwY6hrsL/6KL+29yYUXxhg+2u8Q4dWu4cr
	iaB/dWsirXlatSsjh8OMFNJ9ZuA9VBcuFWeit/lzPaXbnA==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2097.outbound.protection.outlook.com [40.107.22.97])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 488c9crp30-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 13:54:35 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buNBdWgcZxLdKH7lHbvalg2hXOM0NiVZSq0O4mjHaT14NpXOf06+NvzoScyANNwXM0XHBnv1yuzSnGohIJ0NSVABf1u8spS6TepJ5/savz3xWdCysRjGGpchESmEfj53oAfRiJD8n/8sUIoFnYMsUL/kI6jfQ4vmqVVkvUJDqrEJAuVFJS1xXPJ5vgBXL+ZH4RJMB2FAoJbaSM8S3FWaepEGa26tGu9yaqvvcOxKrbvjA6jeYtzNkQVd2WDd71IlT/XMzC8TRphDleDxwnd6JT7mA+rKOg08YJ7byyXusjdhGtPRvjkgF9mZVQTkD+118KBUx4BDs3b6pyDdXmJOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkD1qemr1byVhqxx/ZITxKF36VG7Jo1oOyBObqPU8ls=;
 b=JlHQH17q4fpu2sF450lCQcyFrXOsQ7G1Zvq+Gew8ez5MbSJN0WvxQoJOHT8elYNxMMS0SWCBmyQaJZUmv6k4hmPSuYoV2G1Jf40+MNeBVpycf8GnL2D2zTVXmifsLPEERObox66Lq/2DD6xBqO9gEMj6J5ql0Kikw0oabrw8kijijzBml66ouEBfs3coWKIdj4NW8PpZQLkybaVUZlkgS6kHMkUcnJI/DgPHyKMdhDaxahFqcezjzIxDXAx0q4/OXTPrjKO5Jm4AdSL0YM+gKfzVZOp4nLct31BS1xXunblbOPxFdg2bOMqIPI6Eyo53aDMXWVQbhcvXbyrewWOOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkD1qemr1byVhqxx/ZITxKF36VG7Jo1oOyBObqPU8ls=;
 b=exLZJxKlspRgEYqWLJn2tRwZPTyUZTXMToCm49WY0WH1HIQ3Lpu6Y69gdu0EMFW+lqdRApN4NuztOWpMTNJrhpBc1h2A5w/AUwGhlcnsZXwOJF9Cio/qV31ktJ/wq/lTIRVgWxJw9beB8T1l5Dg3SsANcuyIFZ2O6WjTmq94brY=
Received: from BESP192MB2977.EURP192.PROD.OUTLOOK.COM (2603:10a6:b10:f1::14)
 by GV2P192MB2663.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 1 Aug
 2025 11:54:32 +0000
Received: from BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 ([fe80::35d9:9fe3:96b3:88b5]) by BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 ([fe80::35d9:9fe3:96b3:88b5%6]) with mapi id 15.20.9009.003; Fri, 1 Aug 2025
 11:54:31 +0000
Date: Fri, 1 Aug 2025 13:54:29 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:b10:f1::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP192MB2977:EE_|GV2P192MB2663:EE_
X-MS-Office365-Filtering-Correlation-Id: 400cc0d8-98db-404e-acb2-08ddd0f22d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmO/J0lavhhgFeSuKVnrLmIjk27KrcQuIk6CK4U739VIrP6Fzh2Jlzr10IcL?=
 =?us-ascii?Q?A7solSa14/FPul/OSdSKPbrhBWB7NifXyVuHVK3z2NsMq5QnnCb+59D7uLe1?=
 =?us-ascii?Q?FvkvSDKkuvjLjTdHjvg5S8CikBLIDWMx/vTWCk3CDdBUYsmjG4iaczGfZQcn?=
 =?us-ascii?Q?+QvHqKAtKZ8keMvH3yfveObR/j9iqQ4CKoo8/WKtQiCHDmlFCcLyRQrJzPMQ?=
 =?us-ascii?Q?xKeh2NrVXh+fn4CUeiiMatrQe4aawo+NJUYF7HSo6xdblJpzEmSUwyfLKOyF?=
 =?us-ascii?Q?4c+uadqeHuX/4NeY+c5p06tD3xBjMWRt5uGuc14x5rOTMG6Ull3twgyR3scJ?=
 =?us-ascii?Q?iBTQnXurYNbKZDw++8/8cYzH3Ee3sHeyINsNEbZBq0sNmxSTtyP0DsP926SW?=
 =?us-ascii?Q?v6UzFMX6K9hkzG6tcujwVRNIV9mFDtDY86SpaB9YAMugsHp81F0kchUJGT/J?=
 =?us-ascii?Q?arNdWeukdfBQia2yJRjm4SoalAHhJK8s6ln4tCVihapQawhDQbtAOYpABTru?=
 =?us-ascii?Q?37L5RnvCkgin4KlxD9iU99itsvWoyTJykmk2fqdFqlyIyA4NeMkjYq/JE7wT?=
 =?us-ascii?Q?1arkY7KQax8+VFaBih7YuF/QzQ3ru7XTo7yoE6esJGRQh0tX36URsKedkrAj?=
 =?us-ascii?Q?x5vekO3rbEsSo/ufI+8Kt6GweZj2/VPTM5u4kzI5+BdNupL/F2oivmDehHCQ?=
 =?us-ascii?Q?t2i2YQbOUCQ5sBXeVRGdmOrE50S5bEy4slu8LSsqw5ZaBe57LllGpby6y2rO?=
 =?us-ascii?Q?rn0t5ZFkT2MVpa2p26fL1MSMx0PTJd4me5jRsXjlxymM+gX4iKqsCIadwtRl?=
 =?us-ascii?Q?rIJIZVxgZ8qX3WCpMb4Gy02v50gKZHlsB0FUpZVcwnL4jSgqcddgiFMbmEgL?=
 =?us-ascii?Q?/gwUS6F5t4NTKO5LNOQdWPVTUuIBVmtRK85dM9pmji40nsNaerlZkCiXUyyp?=
 =?us-ascii?Q?rucYQ+OHYN0apNugR0VhDaC9WZK5UjloGJ0zop071ZpqTBsem0AMvnXDacII?=
 =?us-ascii?Q?RXfX4I2FqU3uQTjzl5LWvpskdy/YrdZA5AIE9+j5w+i0esBbJpFAcuThXleV?=
 =?us-ascii?Q?eDlaywF0XL+kUG16T671pOpjcJWZIF058PefTy2prdjHHRf0MOHJxuuiSIjx?=
 =?us-ascii?Q?5r3jnNe3HkZkr4k2m57lY4JRKJ9JwkmWLAykCc1Ntg6TXc8oZufMBcNk8uew?=
 =?us-ascii?Q?T14QepalT8X1tZ1HMeGDhXW6CKS8esIIO4lg6s3zQG3VPy/qIV5r6E9HMMr4?=
 =?us-ascii?Q?hbIRkHY1JWCS28voGbdEPYrA/QGTjafvFOaznN6pjxGmoL5Q/o/AqDww1ADs?=
 =?us-ascii?Q?PJqYEkKS28Jw+rw8L7guHww1PJmcKvjiCYVS9nx/COnuod3lu2jpA9RkZfgf?=
 =?us-ascii?Q?dwgQrXu+nzC7B2GklwkkaP6EXJDZ8abBLuR7FdYApiIS0r+QHyrmYOCnzs4G?=
 =?us-ascii?Q?H93Dgv1aYOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP192MB2977.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMsQzdMlVVQGYpd8GsS60v8KQxZstPKdwsvHLqinJCPf+rYRUQgwllvYk5Xt?=
 =?us-ascii?Q?DpIQfxTT5swjFhYn8v6eztYP4bIVaberdasScQ0dQ0Qupqck1Bbhpl/gnSd8?=
 =?us-ascii?Q?kTHmM+AeC3lA/WLBZj0P8BoPJ6a+QZVpQgPO/4RCHUGOTtrGMMCJe+Ug1hFS?=
 =?us-ascii?Q?eVQncb8nQTtTT4D6k9Kk5Zu9bUvf0MDbf9j3yNrnDM0X9oAcGpp3GJkg7QwQ?=
 =?us-ascii?Q?l+QdOke+/0nQyKevioK+4Gl8bgX7EuFfT+RyB8jYi1QbYEIS2VP9bSXfHUy+?=
 =?us-ascii?Q?iwRDdJUX6xCS/wbrUdWuVg8YGBvXfJDKHsVEvjVM1kTK/6SXEs9SSVhtb0qy?=
 =?us-ascii?Q?dSvXIENyBR5EinBH81fN8vKJye+DXV5fkr8EEJtzINplufIu4wodCLBVqCuh?=
 =?us-ascii?Q?317iH3gjyGTOisz0rKhWm8p5TzRRxaAYn4HW87CsS87vRRXKcz16XNGipNY8?=
 =?us-ascii?Q?tKLKoZHmIa4XPsiDD+TRTHncSAd9JP2cjCRWtasQ5MYcl2JD2BNAWYz2pNmO?=
 =?us-ascii?Q?FpvvqiMMBitrao7I143KZerXXXve9ThO7LTjuB3XYZzPlna0KVMoY/IAWr77?=
 =?us-ascii?Q?lwqQH1CTJhsj5tsJR64fxyIDR6xOzW1GYSJVH217ClhyxWwPLp1CCROEkS1U?=
 =?us-ascii?Q?3dZ1cymXtAFT/r6nZ4U7605JonJDyJe/qQQQxuoihsMUF/4maoFY4LbJX5l/?=
 =?us-ascii?Q?pY0jTc/SELeLOadOxZCC0ljch0FbrnRX1rMVf5QgvSm0rvT7OaWwyU9+kVcf?=
 =?us-ascii?Q?LmvBQEMBEIe+vVAiP1qeJ0+TDa//RaYxvfpZOKYwFBAyT8Py+OcM61bo9CKk?=
 =?us-ascii?Q?UjmV0wDhZjrMhfh5hOVlZq4YEfjCzfp0WEYURH7FSdKk5GOK/yxM7jLCQNvQ?=
 =?us-ascii?Q?8u+sZwsm3y6gy3Vvniszrf7X1GtKNuTcWeuLEgsTay/u3ENx/O7O4msAMtRt?=
 =?us-ascii?Q?GkIQWpVX4UqdoGU62U9jf5NyIY1kiZC26n52ki0BzBmoFDqymB6v/NWKSyY+?=
 =?us-ascii?Q?hH0Ti/6/PGBajf4aXL06H33Lm4oiQldKvQ/gNHpsKCE0GFuI9HNYk+h0qBOs?=
 =?us-ascii?Q?PZ3XjsdcpxN+nOYdklFeFiLvSg7q7gKvP6Z5pgsF7+lu78aXTjYmvDWacrKc?=
 =?us-ascii?Q?VolANrk2RefoBfeZ3aTObfx2j+GDbZiltUUJuYQjTTXJxygmMje55+mkwjxd?=
 =?us-ascii?Q?hIOeETNkRfiyO7CMxqFGjG6dA7Km7+5bJegfTC2vtfLnvNqDWJnSA+xlYN2m?=
 =?us-ascii?Q?zrJXjwYqjbqyMzL6eMCrlGdoHxeEbUrAEKDkqU2OusuNicazX/zsg3E9MmSE?=
 =?us-ascii?Q?Qs8GMiQuMVk8VBYyOS9vqLO7c/BW5q7PJ4rtGmKPTNysjnUyyMXmq5afuiA6?=
 =?us-ascii?Q?J9WQtkmSmshf96dpr39t/N7De0OORUDlVsB8TXdUHuUAjNQGACzgpntG/cMv?=
 =?us-ascii?Q?n2g2GA0x7ueDIdrEyVzEvZ8mbrRUH/Ll1Rqf8BIyUcJMnVJWulZ+rTw5NQdA?=
 =?us-ascii?Q?VMnlDTXflrFAmLUihTMQz6rRzbS6xOC/ZOZiCkMuIkY1FmTH/lToIkJOAmwI?=
 =?us-ascii?Q?MKIUmf66nH3Npzct4sl1xqNnVPWwYuZBYZHjsQwV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ScubzBc8lR+P7Ek9nd90TX+vuFb/2biNvHbM/D3pFrwyOwIF5eRnrNlz1ycLG0h5sZaN69xitr1PZr6jmLezc9CJyFVTgue56FMf9ayDRzKm31ItaXOwIRkhep15OycCBtbIFYm+euj1q7HeIltpM5PTFIyWZVj5mOCq9SJYWBBcwp3jfUqVNxbLB/T66Dba79//jY8ynoJBYNIh/vXP7C+SopessR78jxy8rDKCdHPr1CeRsE/0GifE/7LSwHi2TtPwy5FxgwHRczOUo56gILFVAIsbk3iI4PIV2kZorgDxEex1WpGD2WelL2mreqy2OYEB8tgR3FSueO2szODuj+qhyVkUXZRuSPjSxQfP0lnO7zHhOXuWZOywEPyO7W8bbHjaTdyPS3xOcDfuIheJbBmgwqCrYWM+y4RFawhxzl0Aw2IM0AbJnOW/57qUKD8L/w/4XLDR8zzpnyamwWM0YUaSYQeM701cWCwu9+iy48nrhd8k59A1gtUsd5SKoRVffQW8s5oWJC+lnGfgAahiz5bRMYvZctW7dGlMJQxSGQF7h22go9mlBjJ1W5FFbtG6zTPbYAW4bU7fp1gzDhV7Y43TjyDfpKt/nRv0LhuMFuZv0PoU5gHC3Gt4m24NBaPB
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400cc0d8-98db-404e-acb2-08ddd0f22d45
X-MS-Exchange-CrossTenant-AuthSource: BESP192MB2977.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:54:31.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCes0OQVWWcXGa0HaZ1Dqs2ZnkawEcAHykzlMI1kdNAhKnnG5gPHoXTvpVsSejazh/895GIojVoIvtTgRNM8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB2663
X-MS-Exchange-CrossPremises-AuthSource: BESP192MB2977.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GV2P192MB2663.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: MoFSlTOVrmnH6Z1BLWBs1UjaY6ATb4-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4OSBTYWx0ZWRfXweRUEqNkNY01
 kU/wLPQX3k19A3hX6g8eidMVTzE4q/M1449kB0CuOQY36MmYvzPR8E+3JxgU1pSN6Qk2s1xDgCd
 RNv9xMqEL1K+NXkqdlwVSrtLIYXGqE8U5e6AnnShbmHIsLQYH7ZcDYyq4aUrZDSciaEs9rNNF1U
 YzbR36H0AVA8X+JaZPKTTQ+iRKHwYOFpjf98BnVor8WjjhaM+IcX8/tF4vTE3MGxPaSjTOPKXIS
 1B7jboTGD3Wn4vcwOjHwRClcSGaGLHKCYojFK5emAc14kg/TcAADeXpz+i3TPr/C5ZUEov69T4E
 nKRpdhhKE8nSZF289YxwWhokXizncsH4WENNsMvwO9A6gQneZp7J2ZnaAd2xVY=
X-Authority-Analysis: v=2.4 cv=IaeHWXqa c=1 sm=1 tr=0 ts=688caafc cx=c_pps
 a=1Un7+LruITlTKEh0Q+cszw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=n9WDw6XJi7PglbCx_EAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MoFSlTOVrmnH6Z1BLWBs1UjaY6ATb4-P

Am Fri, Aug 01, 2025 at 02:01:06PM +0300 schrieb Vladimir Oltean:
> On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> > and this works. So... we could actually reconfigure the PHY independent
> > of what was programmed into the firmware.
> 
> It does work indeed, the trouble will be adding this code to the common
> mainline kernel driver and then watching various boards break after their
> known-good firmware provisioning was overwritten, from a source of unknown
> applicability to their system.

You're right. I've now selected a firmware that uses a different provisioning
table, which already configures the PHY for 2500BASE-X with Flow Control.
According to the documentation, it should support all modes: 10M, 100M, 1G, and
2.5G.

It seems the issue lies with the MAC, as it doesn't appear to handle the
configured PHY_INTERFACE_MODE_2500BASEX correctly. I'm currently investigating
this further.


Best regards
Alexander Wilhelm

