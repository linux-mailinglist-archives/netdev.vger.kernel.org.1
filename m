Return-Path: <netdev+bounces-118218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC61950F90
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003CE1F2315A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65491AAE20;
	Tue, 13 Aug 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cscA7TSp";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jH41KZDK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CD56766;
	Tue, 13 Aug 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587441; cv=fail; b=Xcm3LFa+eAs8ya86zs7Ufc0jVfG42OVC0FgwRhA+Kv8JtXWfAHf3e/wmD5WoyAAKwIA80gkryZQfW95fQe8hBudi9T0Yqd6/TWxA9ZZoMcifDUtLV2aa6MlXrL9StXXcUhvOtpd2TBoMzIDXd8Us+qNOx8xiiRe2l+i+NtSQ9LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587441; c=relaxed/simple;
	bh=XfzkNTGGGso+GpI90D8YCJKbUgmJF+k+gT0l12dRWFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDF9eXpS674/dxdXsbN25z4ZzZUIRK3fEmtAMJSzPPHRjzV3C3QyA3LXkF9MUhd/OiZzEYr2eq3UiQk9yNpTeK8swTbxwAIv1A1YVepQQ9lwrDX+5afQ3bDJp/YZHpl1doKi9m0faY5Upmjze+qovf1B0xCQzfynFcyRhocTcVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cscA7TSp; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jH41KZDK; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723587438; x=1755123438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XfzkNTGGGso+GpI90D8YCJKbUgmJF+k+gT0l12dRWFA=;
  b=cscA7TSphj26VZuKtltqVN5uZETyhASndffkVYakd9polE68EB1wmdgp
   IHqBdUEQ4aCcWldztCXgBKL10Y8T6m8r/RRGY6oQ32gvZQOovpHcRV1Kp
   HaPehomU12ywdj9ukBoQTm8tT3i5pClnzJYZeyaewXbtknEjfkS+R2T+r
   NX43phWoD+3LbNTb0msYlf9a391nrvBEakijwgAx/4zMcnWdjU3DNcPCE
   7SPTH8430fxiNdAIu5nC+TksWfbmGdhl/YZCbDP8ws+KUnjenhET/Fwmk
   DSPrq8sx29bc5QaxPLDXCcSYVXVD+NZVbtpccAyUulA3fIuC+E7v3XFTt
   g==;
X-CSE-ConnectionGUID: +uYaJS0JR42USAObT3usNA==
X-CSE-MsgGUID: 5eqF9XDvSQGR8R3VkbcGfw==
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="33385540"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 15:17:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 15:17:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 15:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPJezkwfCsqJnLWuydTBdiQR3pwyTumr+GZL5PvAS308s1QOY8oEuO5/KfJ8bAPN41S4YTBTDq59CkqrOJCKkZjwpZa5ehcb7R0to+2cZU9XNS+fkadQc4Gj9eCOUcvwOdJ7qmcroiPJvDEhSFaW0cCy9CKkNI91AxkcXKq35j+5MKzFJ77t/PIMsaxjAlLJuobhPBRbpcqtc7LkiYlUYAXaLG5fm73HduUjQNhwcLypUxjY48Eg8oadyhFPw0voPYk8UJRt8p1nZ+JQ1U1yx85higo46GDuRzSYDjv0cBiKu55s5dB9JoTPDHMTutbX4c7/7EFSd3Ve10dZIgdSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JPaMB4n8onwRSJmnOxQyozOJUId64wIkfnT1soUHYM=;
 b=UmzaO2G+DGkEZhcdBIit+Cw0Kz4CSJhe8qAgfBYgN+scSriioz1XtaTGe5W+5Ta6b+anjPNwnHivQ+La254L/+sOzXwDcprEqWFz9rFn03WHs6m7lUgK697H3+ylIuzHbcG6M2TfXU0vNG+2nNaNSnoB8HEHeOKJrd8TN1Cx0udmkGH8kMultqfg0v+7K9Ikoom3jh7+NxCbnnAKeSa+yM0lM5WNeOddimLZiF78xuJeRxFAYUNGD9EwCzbfu39EBRLiKDInYhx2z099WlR6KcjO24rE/1JMGGPEe/2nFAtoc7108IIrj7nTjDi0HK+ngZfD0oFGUlaQKLsvbkELug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JPaMB4n8onwRSJmnOxQyozOJUId64wIkfnT1soUHYM=;
 b=jH41KZDKeRmGhbsbff7KTJVzFlhQ+X/5DHAXzChJAaMqQQhQZ6+0kG20oq6Y9V7/0WcnOR3/cSyEmxXis4GKWQcnujPNQ0HF8t+3liRmCgng19pBIG3LVeWb0cuTwazW8A/9CboRhVJaBTminkKwJEk2bmLsP25Yh98te75gLkOYq1TdFGnUQl0pHhJW0B1FDZQvJvvB1y9+b9oAPijgnkxoDdfI4eM7OJCAdY/ibWiKWijdi8grbitGu/76KxCsbHXpk7uFL30dXjYPgDau5IUyCe/n5+O97M+y2FoSrbn+m1Lr69y0Ny29Ygmq/Zj9Z5IVRczL+twff14jJjhU7A==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Tue, 13 Aug
 2024 22:17:04 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 22:17:04 +0000
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
Thread-Index: AQHa6rVb6R5b4khOr0216lt4AbdkW7Igv2QAgAT0oCCAAAcxgIAACFyQ
Date: Tue, 13 Aug 2024 22:17:03 +0000
Message-ID: <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
In-Reply-To: <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SA0PR11MB4639:EE_
x-ms-office365-filtering-correlation-id: fb367f66-1758-4cc6-ad69-08dcbbe5a925
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/ow4DSFIWBkDNlXk+rQCQqGEITCivVnH3iFEvvJe/BF59GqpFx7vmToqqJ0q?=
 =?us-ascii?Q?y56kLkdE+FqJlGE520IFaBnyGrzmwRnrHAdtQuwMPJzdC17iRwfYpyFXxrxt?=
 =?us-ascii?Q?Cw5vFD4QEkLI76Br793xgyGqF2ozFEtmS+cJ7qmjm+OdCSJ2JWir4g6OfwbU?=
 =?us-ascii?Q?urIcppMMmVgtzOczkDAs9+ErSyaoaudOKtCxjbrLoGTAl6XRrYfZc5wuGw0a?=
 =?us-ascii?Q?CfTXfBkbMPAWwRE4EUUVV0qcnEuPyvhpTp19hshBq9HmkyOSOWTAZsWAl4nC?=
 =?us-ascii?Q?6XhSCLWFj7+4QTNYnHUsL8SKgKX1NBrW2GuWdcgycJbjnkBtocjRAZlVra0n?=
 =?us-ascii?Q?iOcWQ1JQIND1QefhuFZKtczC74UKwDTDO5q/SHuYVRTjUFU3Jgwwvgy++Bd0?=
 =?us-ascii?Q?dYZCOODRjkV8mH5DfGWCExb4tI2wHv+5nIuDSX9GMhhkukbGHmrSSxSASFAZ?=
 =?us-ascii?Q?a1Mvm5J3Rrnlvp7LQVJiYd2PHrqnwfUXppVVINo8zUTkutb3W2tz7rge5ubt?=
 =?us-ascii?Q?nUjD1GiyeYhAoaIDL9ML+ShuqyEHmZ0W5tsCXEzjAi8sS+kYBWZWVCN+E5B8?=
 =?us-ascii?Q?WeCgvjZaqLgkSlNnfeM9i/ExiuhAlfEx9Siayy7QxmcMIq0FZ4Hbr6E49ver?=
 =?us-ascii?Q?t91lwc/5FYSHSSJgfb2GM9CO8bExA8AEmy8xWa7XW1UiULaxzEE9DmLV0wyw?=
 =?us-ascii?Q?AGZP2QjXzteDhsa2eo1QrFdVphzcjbYu5DbWutN05WzwdUH/K4Xs+pR7AgFd?=
 =?us-ascii?Q?rDdgG3K848E7OjKbYwBihjJEof5ETVmxcHF9kNejB2X4PtcmzhK17X90tLzY?=
 =?us-ascii?Q?hlR1Gb7yY8E0Vg/8ZkEJ/zCbcM50Q2Y9ULpSOb36JvqBtELIyhyPuqQ/tjRg?=
 =?us-ascii?Q?Ul1By/v7tdtWLSQdvvEHCLeVtgkdMAycDOnJx+vNtYQlyX4iPUt/wY8VJYJa?=
 =?us-ascii?Q?Z6G1zeKaWnxrE837BekMXzMrBAIUtSwY4tsQof9NvBzhULPbqsq453LdvuGa?=
 =?us-ascii?Q?MBsLgY+4fw9jcWeA+jVt3VsvpvGyjoCi9oMfc5LlHkhc97rAdZcJM+d/2qSA?=
 =?us-ascii?Q?G5CSiBGY/6UnJXOm7vF7DphpuUjLc3DQXQJx/Yl49/SLXux7WzhTyWPQKF/Z?=
 =?us-ascii?Q?fiva6qLKh0I+bjLQGsDWfX9QoJyYX3DdRQd/iQPT/wK5uEq2er7YOT6n77po?=
 =?us-ascii?Q?ee5nkcradXPneEhhv4CU4yY+F2mLQBF62OOMZPHw+gH0SwAxPT4IsRqxC/Ff?=
 =?us-ascii?Q?hqoFGjqJ4JnEFPYX4tlTYLyO+1x4uCLIDNFlzRenLsxmWkpLAO0pzH7q9Y3d?=
 =?us-ascii?Q?vBn3fdTHyIEHL7ZZd8mUVkUx27eSfT83nO0IfN12RzbfHA6OHnQ/nXqk/+7z?=
 =?us-ascii?Q?UkNBbCDgW5bWJ+vHcD+4g5EX8vKu3DRJIGOUhwOu695WhbramA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nC+fypij4Kt6PHZeduJ1krruNOZtVUsb+4gIF/GeaYlL6jMWoRwAc0W9aRHN?=
 =?us-ascii?Q?YeyKTAOdKh8UPCKOcAOW6osukE6/SDIfLjl3EAUxPs/c1RckF2U3zajTBieP?=
 =?us-ascii?Q?DjS68NTE1XbQvagwDV/rNXEI0NXnXcEAVPAkG8NM2UjskZcVffvZmUgCI5zH?=
 =?us-ascii?Q?mNvUe/qCa8q6pfSmLRclYlLk/z8UsS38Y+yB7zG6nrlQtfmWuW8QeQqmBrJb?=
 =?us-ascii?Q?fFGCFVTU7BP1+hzrXXcAQqhRxWlGZl4M9OwEwbIChg+B71jYHdIjMFKgKNa/?=
 =?us-ascii?Q?HGvltI4F7GD4q/iQeikHjrmCLmsV9jSUSKn3tBRVxMOim0Mn1bSnXLTvV0Sd?=
 =?us-ascii?Q?BDUnsgMljmnoHOgekru6yn5gTDAIZYKWLgTSLqRFrwhMWm6Ceuh7L88SyZkK?=
 =?us-ascii?Q?Dzn6PlZRiWv2c5V21Fek74zKWTtlUe6TvyxrIOtt7cgBoHsn2VEfb5pPIqtE?=
 =?us-ascii?Q?VusX0Q1eBLY6x5d7xXeIB1rSBKhYj/ybKHepkGMp3QZQBSlF90UMNAx7aFQD?=
 =?us-ascii?Q?I7cJAOjiZVEEGoJQsOEVQfQ/4KbfZVA1i59T3nZxDraDiCmiW7boFjbTZaCq?=
 =?us-ascii?Q?iG6v2jaTAaRtrnd7nRuesGHK0MIw+LZ9M1BXEgnaGjtQ3jD8+hDrnaZZ2/O8?=
 =?us-ascii?Q?r88Zhkkdy3vJ7X7yLfyyWNbePTSPansu9DLPYKN4eEBTTGkfgCUDNE0JjSoD?=
 =?us-ascii?Q?zQS8XxkS5xMpZ/Hq8z49YZISg4binjJuJivjQuaPxxSCVPfgJ4HYsyT6Vfnr?=
 =?us-ascii?Q?P76Qbe2WI+oITxCl3TqQmRCegPxxbsZPTfUZR0h3r8kQ381wUaAj0SPUty01?=
 =?us-ascii?Q?Ovx9s3HOiA3nlDTbJtvD/JoTm5oqUdAeC6mXHg7etM3PJvddq1YU43oImvHz?=
 =?us-ascii?Q?XzWLusegHLKfSdLwFLpmYLvdX6QxxPOljZCEsouSzmdmbCY0jXkMw6OWgKvn?=
 =?us-ascii?Q?rQkl7yI/i/TelFCcIbBry+ivAYe0NH7ZTWARJ5muSy1dMQnUMsciuukIh5NF?=
 =?us-ascii?Q?1/WpRybum07gYPiI23fPC1mDmpqDc1wrZoOY4NJpDXk6UYuTjmxGMHCrUEzw?=
 =?us-ascii?Q?6fOBg3Cnl5zNMFJ2g+e8lEesaaqFusF+8ly0vE74EwGMrjuxLqqbn62QI1lJ?=
 =?us-ascii?Q?/tH47pyWAEazIyR8l3gBJMbxHpPGhaI4yVt6J3jDO+qBn/gisb2izNCb1T9d?=
 =?us-ascii?Q?+IbKbcpOE16HGzmW2jjt2PqdXLB/PFSGxLCYhFchmRNzidx25Dar3Jj9/U3T?=
 =?us-ascii?Q?dbLd2aVDG1WgKYK+WfR4SxSe4I8TM7b+jXTIKrhfaI9au7eahwmZtcbbtzAu?=
 =?us-ascii?Q?gSRGpP80liBcU9IIDsvOWBK3YXtb5FyVaGxmdc1m2Xap1CVqODIL1QOnmhZ3?=
 =?us-ascii?Q?AOGD57g3npZq+mOZNqhGBpyay/eb1TDrilkQtQ9likInqX5crKQy2X7FVBC1?=
 =?us-ascii?Q?mWW3NlOdg1+fnCfZQkok3zR0hvOCjjgqcWkWFY3xAg7fwxU47tnRFiheLULg?=
 =?us-ascii?Q?TTSjWOdo+lrRloV2KJwernUKco2Pt3ywNfU/2RlrvCSqOHdyCUoJcRIYilwN?=
 =?us-ascii?Q?A/jocCosUJxM08AzaxUDSYXAt0TSkVhdfskOVck8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb367f66-1758-4cc6-ad69-08dcbbe5a925
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 22:17:03.9269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuTzBxKpLu3RQYHYz0Y81zy0iCuNHJXKSrK+8/JQK1Zxj1yBjbWi7jfGVD1+ui3ucfnwV1W0Gwrm37aoenOCQFVNkragNWgdEmbz5EUpqm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639

> > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > >
> > > > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for di=
rect
> > > > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> > > >
> > > > SFP is typically used so the default is 1.  The driver can detect
> > > > 10/100/1000 SFP and change the mode to 2.  For direct connect this =
mode
> > > > has to be explicitly set to 0 as driver cannot detect that
> > > > configuration.
> > >
> > > Could you explain this in more detail. Other SGMII blocks don't need
> > > this. Why is this block special?
> > >
> > > Has this anything to do with in-band signalling?
> >
> > There are 2 ways to program the hardware registers so that the SGMII
> > module can communicate with either 1000Base-T/LX/SX SFP or
> > 10/100/1000Base-T SFP.  When a SFP is plugged in the driver can try to
> > detect which type and if it thinks 10/100/1000Base-T SFP is used it
> > changes the mode to 2 and program appropriately.
>=20
> What should happen here is that phylink will read the SFP EEPROM and
> determine what mode should be used. It will then tell the MAC or PCS
> how to configure itself, 1000BaseX, or SGMII. Look at the
> mac_link_up() callback, parameter interface.
=20
I am not sure the module can retrieve SFP EEPROM information.


