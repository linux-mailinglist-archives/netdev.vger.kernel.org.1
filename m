Return-Path: <netdev+bounces-118195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31145950F0C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300B31C23893
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D011AAE1F;
	Tue, 13 Aug 2024 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qhzWoyKc";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0s+7bp/0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99036A8CF;
	Tue, 13 Aug 2024 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583723; cv=fail; b=hWYpRo5POYlVAhwK71bGHwpDt/ktnbb5dNe4Pq6bovMSBmdG4zlhK4vaoflYpeqRPXTOzvtT8PDESxrsiBLOXa4fV1WulQopjyKQ/pN+fwhBT1q3IxMlq3QvaPtxY8Gfti+ABUiIDasJbDzOgjnnnKpJp/NQLa9bhTBIcQ6yFTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583723; c=relaxed/simple;
	bh=DTpFmJF4d5Kxwt0NDjZ3E5fFLxZbiAdBuGnEQPKGpYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EfTTIVHCb7/iwCVPxst9n1+X7ECymwnm+7ogHqMbHuYUaQeYAruaya95tAtAHcMM9YGVOk9Wu7tUMucwE9Ve+ytXkMQiPEaIPNsJIt14sPCGRtOZVsyRW5eSMVeiKp+YWC71PQPX9fMFxOKwzsAmx4gP9CjFQCq2PIbA9ZP3hrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qhzWoyKc; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0s+7bp/0; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723583722; x=1755119722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DTpFmJF4d5Kxwt0NDjZ3E5fFLxZbiAdBuGnEQPKGpYs=;
  b=qhzWoyKcIGOluEvV/6wYqgkMmnoYo4q2PDnD2wCr/bn0q7PRp1Kh4XPJ
   ooSHpeVp9RrlMsJ3NWruFzt/PAXyu5LT3TTYqSNpXmikH7yjlgd5YtvtA
   NL9EkdbzyXYVxkIwD9oqkVZW8kw+OqofqA522gk9JoxZwhyDHwQNcPnv6
   LOy7X9+vFwgrkgjIOIUBzhMV7MHhBrEb75Hwg8rNjyazdi8u7mKMG+Mtz
   RgrFz7SwqAuD+j7Bcn/tDCBOXtWIIUo6n+tw5G5OTL/Q9WkbM6VHzW+1E
   /2hEN4TQK2e+i1p7QysJzD/U77cj6ZUFCb/cWwurjB0IYLVoETkN2T2wj
   A==;
X-CSE-ConnectionGUID: ncM+kgujSEKTacsBmWFdJA==
X-CSE-MsgGUID: RB2VTZAhQP6h3Sd6EfNcTg==
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="31126268"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 14:15:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 14:14:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 14:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViRWufQ4hzZWnA6Zyhr8RenJaStWwJF9dklq0I/tKbIudwb9aRwlQVWzMPV6enjaS2BlN773IRPZu0mtMRCtweMza1aDxPNJDRzizcj5OYGxRqE5o1Vdx4gj1+tRS4S7hG59ehHR9xzXrJEULWE1cje+OIoNRZONpkYg0fnAje7TNN+T15ebOXYfRdWhEh0oCM1uMVlrUmkKC3X4cTr2eE7IMQtUfGrkRHa3l1FLjxoQffdZO3aaZcntA8Aycq9EFvtgD15BiFFgTMG0U8XFrI6VAQ7eDM0LeVbNc4+i11bA1xEqDeRv57mS67r/RUfwUqOLShPJmd2/KrCRIEXr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylayOjsMzxsOFAmzCesZw/5ePxy42Icd0KDhdkOkoxI=;
 b=eOijtxWLLbEbndZj0s/pgWge4CbEdlwuiX93A2E7hJV2ujCdeQDApe1CxHMKVx6U+mOTVFpvqnA+qzJ7TWfqO+nYJPzMkSQUr9Ztc+iq6LDZTTJ7c919M051oXXzWUC9o/trp2qHMqmNH5egQa3wpVmDf9uLfi3xzRFW/r9rmQC51QAi7xwmVN67kL+PRzsKTN529B6ODj2hBW+plab2ie0M3/pxNjxeitGlVaKF9kYlztE/DTNi332xPcuqnXq5rn0lbPJpRqZAGB4Fmv4Vtq21JU8YJciDA4t1uphtWOnnhyyqK+2BS8VtyRyqeP6N+ugFJ1+DvSkIWogdAr+jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylayOjsMzxsOFAmzCesZw/5ePxy42Icd0KDhdkOkoxI=;
 b=0s+7bp/0MIEgYhowZQ6gD9zHX/tuPvZETaV/1PaO+iiH+yKI7/JpJyCu2mS/TpoSIGSWyFXyy8noR6JMY620yNMCgqCTPshSsbDuSG6BWShbpjAlSaTKDrgmPtIlCV7+bhEOpwiEeBMhHca9Mj3TI+vYn6qIrlxBq4NEHdvZ5xYryVHlsAV/UgW7v6KQrUM9nhENdKudMKIRKSHwvzw83mNB3iomFIEGdGjJzpex1gngOdYXMzffN4pXH1scVHicZX+B/vyaVIR2xy+78iK5HyG++q5rB/o/rapgEAsDFJXflmwN//ThNsR2Z6eOjVyQ52d0bUMwUmXVp1XtSYNVIw==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 21:14:34 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 21:14:34 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Topic: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Index: AQHa6rVb6R5b4khOr0216lt4AbdkW7Igv2QAgAT0oCA=
Date: Tue, 13 Aug 2024 21:14:34 +0000
Message-ID: <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
In-Reply-To: <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: 6f194b24-58c7-43a2-2a6f-08dcbbdcee3b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZPAjvzW4FwlN1Kcqze9efNOw4xcX33SI5OhXlM024oJNjWkars2YrEzaR37C?=
 =?us-ascii?Q?mH0cfw8R8uNM7uDtq7djsrYJ6vlLnDF6Kb1doCaeI9pGtTIQWOAZS3PPowsT?=
 =?us-ascii?Q?EvKf2V10tmunqG+ZkNRgX968v1tSjcCpPdnLb6kdJWPHBKNQKk1vqv8xmsIZ?=
 =?us-ascii?Q?lBgi4LP/3ADqdLtvXuUHLNc+3ugdCJFVQYbvJyp/FsguJIgvn1MZ2jkehwE8?=
 =?us-ascii?Q?BQuLrbV7C/xV1bC5VmWVpbPttCB3DaeCL7YXmxZIma/jFW3Po8imxZlJrfNB?=
 =?us-ascii?Q?BlOl0FVqieeIaRGeFRD5jZPDzlBabdpv5VjtapGipKXwRhJZegA+0W/GB5D8?=
 =?us-ascii?Q?xAKpHznrpbAR8Q4bLFD1Tj500oIdHnqKc+q9abdgcblXXPRRazElV/gxDSYd?=
 =?us-ascii?Q?6LpItR712ty5eb5EDmY7Kv1NZ6HFoBC9SXUJNWv27ZMmk9Zk1sgKNOT/7NT5?=
 =?us-ascii?Q?w64v9HBVJd36l9x81Lr4v4YkM2DeePrj2Mq7nfauQxqUd2t74/35G00qhCWH?=
 =?us-ascii?Q?FgcaO+7heiWxLqevog+KkCgLGeCkNx3OBx4ixP1fOo7HLesNajQFohCix9yN?=
 =?us-ascii?Q?V89pfw3F3XWNdFP08AfAGrqcy0t7nmRJMmpIQrZ1t/eJIMTpubDQkWUQ2S42?=
 =?us-ascii?Q?OCusvhr4eXZITtfXeOjmqI/gj7v2/jdnYBhpvraJlmVrKkIbDgDnOEq+pRFl?=
 =?us-ascii?Q?LLARyyW6NRGuQ+s6lzAG8iDFXuKQW+ofenO02qE/PfZDq0Fang0keNzFrK1E?=
 =?us-ascii?Q?FivfK5gMQQ8Fwl5xVisNz18+YqskZ4cjpG3NjtuT94CW+L5trpUhT0uTPkV9?=
 =?us-ascii?Q?mjDExZxbdUqC12wdBUn8fuIFsdvLxqN8kLwMKVr9SvEGOPy37wmsykYtdFKX?=
 =?us-ascii?Q?N6EpU+dZil66MzghGonzcFPZrTM1tNmVKIRvmfHW+/VyTWCYyFh74V/23zAo?=
 =?us-ascii?Q?o1akMlCnGvURlNr+otoCHuCuwNjwXhqhI7poT8h+1FlNobzEo197RwXThriI?=
 =?us-ascii?Q?0BZbiHKK826E7FWeCulzF0C5dMHHRTq5Lzh5IkE7lqPTJayi+pQluGvuhSd0?=
 =?us-ascii?Q?sqLfEAjZmEN3LCFE98f+/GWJehNm1XYjvA32RmERYP6naAOlCWy/Z5gSrk6a?=
 =?us-ascii?Q?3LNzw/At9Ht5ron4WYIAuAm4eFe5KI1Q4TXedL9CsUzoO/QP8P8Vo89ZTL8x?=
 =?us-ascii?Q?xEMixo7zaRDp4piZ/mlS5+YJIvzw9OqQc/XvSzIGzPY9m4cQztwP4Za+Dejn?=
 =?us-ascii?Q?OOSY5d7Ro/X/GG/LBW6fO7c+TjzI/9MSwmT3edsFRI1/R6XKQKjPzBSNoFoy?=
 =?us-ascii?Q?2TA06yco3navFbSeOu5HWtuEBL6CBnT1dDbok3e4tPnnNpU2bjges5Bx+G5A?=
 =?us-ascii?Q?m8drKT5ApVQyDMCZcwYXDv3q78rFVhSo1n2M5b0IUgVsprg2lA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0kplnh/BYcmt9Yt+O/kKIedVxJJMSjm28AUvJh+DWmoBn0BXD0IE82MDs4v0?=
 =?us-ascii?Q?vpCwz+jtDjK9yZp/o/0Oz07Lku84YpKiqUEpyZvWbo/rJJlcPm/A6yL/CdCD?=
 =?us-ascii?Q?PAgTs6EdxE+h9Vp8NdGHvEAXkQMVrYej2O0H4tBSCoYz6615qJg4QiBRive2?=
 =?us-ascii?Q?ZGcbm4dEAU1VZAwQEVQLt544FW9RS+UOXGPQYsJmRa7dtYiMlbZsGTSnwkMb?=
 =?us-ascii?Q?3Gaeyf2U3a8xHgXggVjjMebibLltHkB/ZhJdMfkilZ+QFKbF+rMpWHgXT5MI?=
 =?us-ascii?Q?S+59fRdfcSnQaJ7Q1CwNEmQiGhbTo4GyLkVqi0d1W5kizCBCZ9XVk4hS0tb2?=
 =?us-ascii?Q?ihsCSS/XgMckERG8ecWAjsU1nhsBF0LmauKlOjPux3KLeRwvMOv8s0LJHoN/?=
 =?us-ascii?Q?gZHGBZFwZcdSKu/6GHtBOgwLO5khkALITpfiCLVi8N+EhrGdoKUp8iZau+Kg?=
 =?us-ascii?Q?vV9+qtbtNnKI3bOxmwqn+Fdr0gKga23RaWAOMgKq8OrE7Hd3CDsLNrjr//Fs?=
 =?us-ascii?Q?/6bdMPl5eBmUG/sXZ9NHjFB7RN9hwzEiUCeD3MzsD5xigSxiNuvM+/5BBlLn?=
 =?us-ascii?Q?CA9W6LuSHF0JQ5VApfKqo6vTQqXLLTgV1XjFga0P60y2CRqBvtZtN4MVFbso?=
 =?us-ascii?Q?0nMUXT6ZNRU+SWuSx/q5IVOeqmaX5So7E18O1T6RCSoj/Lhe5yApVWzoan3d?=
 =?us-ascii?Q?GNrIU3xT2OdRu+Wckxzt8Mb2t/YSfns7Z97FxPo0apM/39d6ALLv9sxy/gFV?=
 =?us-ascii?Q?DUqIL0U82NsNX/ZvZdotl7NcKKs5bL43gBMHjcxHl52cq7G/T/WMiCQgtdod?=
 =?us-ascii?Q?Cx28UNP07FSsaawp/C6LR2DDQg2N+nLEZDfwMm/AMBqGMXsf8ftUfqTeIzuJ?=
 =?us-ascii?Q?H4zIOifKudCL8fI+oboyMDktzKpDLxVklwliirnCaqtY0/xp584fJ+jhaBaB?=
 =?us-ascii?Q?iByCaMt1r+VgUm3p+ZC1QljjKmCf8wPkT4+Z4AwdDu+h+3I12Vp46Gj9gtgT?=
 =?us-ascii?Q?2osnmD8rzg4GnXA8cn0hgK3X/420Fc9s9EsxlrcEeLuVi31d43KmI6hruhRE?=
 =?us-ascii?Q?2ZeC8G+ln8ec8XL/vS6mPPNw0VUeQzFsIU2DXkRKYw/w09ACxFYhnmZXBba8?=
 =?us-ascii?Q?WxJ7uWnYC3pCnxswGgE0H0vxiKVU27R2UwkBi1wF3RO3XPy91u1MHVqrcAfe?=
 =?us-ascii?Q?36eRMFdM1SPoYD+HkEztRtjd9XyBt6racvg/WC3pznw6S7WBs3DP7EXVR1EP?=
 =?us-ascii?Q?Zy+ddnMxlCppvqklnhuWPZSH9Hl55NHx3YO69AjooAMGcRdEJ+HB/6qFmuAg?=
 =?us-ascii?Q?+dLmIyK+ufYrpz4Fnq3R3d6xMXs5np27xgiLUUrqt2+rue74pqDRUHAHQx1m?=
 =?us-ascii?Q?tquj7Xo4mYBskQEX+GVVFmK1lhmV//woRi3EznuMfkRNLSs+jdOg+nmVU4jI?=
 =?us-ascii?Q?Q0tdVKnZTB0+/yqqKLiljgYQNx/TqguXW6iWZcDZTSCERVsCHWPUbdwQBs7r?=
 =?us-ascii?Q?ZcaK7tgkmQeZTiSdb8NJS4kQ/UmQNvymrYcRmjZWFMaxxJrye5s/QJW8otoX?=
 =?us-ascii?Q?H0mryABJVY2ylNzj9JnXM1T73asuR1tK8Lqf30X7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f194b24-58c7-43a2-2a6f-08dcbbdcee3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 21:14:34.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlu99c90xo5/nVhXjLSl2UokqjgdmAT5ukwGyR1aOz9BHnTNRCjRVyqYSGLmdfcDYay5kXA1R5obwlIz9eIm33CYfg0CMNqLuf02qwUBavA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175

> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> >
> > SFP is typically used so the default is 1.  The driver can detect
> > 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> > has to be explicitly set to 0 as driver cannot detect that
> > configuration.
>=20
> Could you explain this in more detail. Other SGMII blocks don't need
> this. Why is this block special?
>=20
> Has this anything to do with in-band signalling?
=20
There are 2 ways to program the hardware registers so that the SGMII
module can communicate with either 1000Base-T/LX/SX SFP or
10/100/1000Base-T SFP.  When a SFP is plugged in the driver can try to
detect which type and if it thinks 10/100/1000Base-T SFP is used it
changes the mode to 2 and program appropriately.


