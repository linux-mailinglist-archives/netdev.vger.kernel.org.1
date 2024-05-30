Return-Path: <netdev+bounces-99340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86E8D48D5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584C81F22BEF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E227152169;
	Thu, 30 May 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="AM+UtM1C";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="GdsT+WnF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8594142E6C;
	Thu, 30 May 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062292; cv=fail; b=RXZ3hh/LqiScqW9SYIMCq5l/w9Vdbzk3aibUy0AJtILARIUbnM0noYmZ6sloxEuxVEvRIqFtYv2/2VNhC4sJdElXPSyr50XYBpCp0I9JjFTklAdwQbOXuTROYekjRIVYjrCvA9enR/ZpldNqgnhoT/Z3XQE/LACQusWJ/qpFIXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062292; c=relaxed/simple;
	bh=wp5TfPFt0tHDMXumZ6fLXIMXNIvxpIIUZ0x4qMN+IEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAzul04gotNFOewRaQWDV8fT+EK6nsSS+LOrqfq62frYgaCFrAc4OBH/iexdUhbCDzR/Fvj4vQpk/DQ67vLEIJQbxScOOjFI+jdEoMY5ZsATwHy6YHSykMc5CxrqVvkLwwnkPCW+QFEqpMSS0xSPGqzBYg1cZtgHv93+uIN3lkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=AM+UtM1C; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=GdsT+WnF; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U2L4VQ006960;
	Thu, 30 May 2024 03:43:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=mCA1pL+49zBHhUxjsWt/uK7U9qD7P2R4F/Yr6jCtm4k=; b=
	AM+UtM1CUM1tXt3JmfFRLIQE8BmF/udNJGNAveCEf9dgWD2JxLZ5grmiMRX72+xY
	XyFy97JwAvHSisgtlg4RCTDpmXNBdWokwvXTuQ47D24l7EUSr0jBgQ5CWW/RdNn3
	NgjllOHD1vHesdIPYs4n8a61PAIR+qzYX2NbjGGfO1R3bCMV0btAEuZuUxKsj9PA
	0xbixmoWIoTjDjukiEBB04xVOWe3knVcYCjT6vBGxd8Xn25glWRbKSNpj0RCHDn7
	WgXGLmSKqLwHmfKMaCQ9fdATQgVIqR1qGYcdXOCJMwJr3Chxt/5hhdAFy3UQVVI6
	YSkL6EF3RSBYWjE4tV6sMQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3ybcw63237-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 03:43:59 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYen+IfKp6YjH32p4WEROgN7iM0ikMnOPWvSsarT7S4dECTLEX4pZu4EfRBMBTL1FKgPvTrBUg09eDsxBQYlIur8aVBfoIs/J/zy6vNXroD1gicescSG/iU4ASIU38kuWBJi+miFs3WQSWLQcmlbIEO+fzq4y0GkRH8oMdmhFkLyMlgzPLRb8ZMbrcH6RLLOgShfGBrn+XH3drrS7QNspqRBvlYCeTlSqrF+NG4g1qBd/2ImQtKph055hodh7tOKSDr75FGx5K9rCqQGZv6ZGMU7DQy2veWMQLhM59bJRprd7HcXs43OgB6b1nAZwE2apY8+5vNXdMV8S6XIwk54dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCA1pL+49zBHhUxjsWt/uK7U9qD7P2R4F/Yr6jCtm4k=;
 b=oCJMR31zPaiV4poXWFCkftBZhkKoISSc4pRKOwSAbMO7OB8GQZt5d8mvF96fdvIip8OqUulPX3AV214RgPpDO6meET695lzxw2O9jJGyVclkwY/NIUy7BWLw0ycHmCBnb6HbqNnzjj1wBixFloEjqQuqVX3LunnS68quCDWyYn+ELJbCHbqj/jSLWi/rz2GweBsmUSDk6zs3CFtsd8C6l6renClWgn5x6tRzctk4LgB6fHw0ku/NiGvnVzMhVwXF509apFl3phAAft1vatCWPTSMLK/Gzojq2PeSZSGgmlpy+FbMaglvreALroramsfdvr/dO4eby1J1DCaFfua2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCA1pL+49zBHhUxjsWt/uK7U9qD7P2R4F/Yr6jCtm4k=;
 b=GdsT+WnF5cDEV4sRM8Spik8KiMApdaS3QpPwmDFwZDQNvHVMwmn95ZLQwZbRjROCmd0dpvZ1hrQNbx8oLLMDKHHCcR7ZBg7fxIwIRROFu2Ir20EUysyQC/zUMv4agf6PV+z3R6F+iC4MiK+uoLPu61/vbRqsRKYzdWaOBPo8E0A=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:43:57 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%3]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:43:57 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
        "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>,
        Viliam Vozar
	<Viliam.Vozar@onsemi.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: RE: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: 
 AQHakZAxosrycArunkaHEujJo3A4abF0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaf7QCAAAnBAIAAAr5ggAAE7gCACKAxgA==
Date: Thu, 30 May 2024 09:43:56 +0000
Message-ID: 
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
In-Reply-To: <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|SN4PR0201MB8838:EE_
x-ms-office365-filtering-correlation-id: 25a086e2-b9b3-4ac2-66d7-08dc808d06a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?7X3o7YcL4Pb253iJBgrWPJf4Jq54b1ki9wAZLD1xK/y6iMN/TZNZBHaqLdyX?=
 =?us-ascii?Q?TabSm8cdvQDUzgemVMUEp+y7hXBb+Wkdde0BgsSN1ePoTxtdDmXiMT94nWCv?=
 =?us-ascii?Q?5d2CSgjQToCGuiHR8o1Ec86xVNWFj+hQ6BIbgJDHKsesJJhbcgi6wzMEnQ1A?=
 =?us-ascii?Q?V0wUYR2ie5SGK6e1W2do3IeGN2/VXptryUkAILmqYXa4jNUAniuzTDqmL1TB?=
 =?us-ascii?Q?aQrBRRMoi88Yz2KEfuAgbBc4urex/yBxKkIs7AbS4bPxYhlJMaufLy2w8flA?=
 =?us-ascii?Q?EoAWwRC2cp6V95MoBknZxi8AcjFfW1gv5fRjs3+au0mGPkBtqpmJnMyaFgz5?=
 =?us-ascii?Q?ryWF9mXZwknOwgU/BsUKnABEkx5qipfHuKQKRCbY7BOg3qQ1F+7TyFAaRJ1X?=
 =?us-ascii?Q?tr+WoQiFCzbAxIOnagzsTQyouAQOcll2GXarofBJM0Ovv+r/cF6nIvu28r/L?=
 =?us-ascii?Q?9Nw3FYifsRUOb1FpPpQ4NVzSjenEV77QkPo7D7/boz98+lMsnk2qVcf9BZGS?=
 =?us-ascii?Q?s4XSGRhNo+59ctNaVRuUS1hmciHDYZKA9pDEsOS2GnCtTcGu66ivieeRHuze?=
 =?us-ascii?Q?X7sAkfqqN7GqF8sEvOljpT9ef8j2JnWFwxwjx746aq7nyzUbyj+wdcBjwzCr?=
 =?us-ascii?Q?fgI9JazvRU/K11+y/p5tTSQgIV/HprpT732D87Z8iwUN0sFOywZQs4UfwiTQ?=
 =?us-ascii?Q?5UfB00IMkfOvnpixaWq/kdwRFSzJJGyIHLwb9LtGZysYRZ9QVSBl+hS/HGD0?=
 =?us-ascii?Q?tuaeErgOEwpbKvLj/P/So9rkkZWOVqPGc5ftoo0v1c2Oo03ibSL/F1c9dein?=
 =?us-ascii?Q?tBA7QKld2fIj70yQzyQj+vFLRIL8FlK2qYSfa2ZHNvuxOTSHBPK+CTCBEHms?=
 =?us-ascii?Q?eSHMXlodJ8icDZr+caI0jfIkLvrKZ6qe1LR8HWuG7mTgwVSRcotn6ue2FdTf?=
 =?us-ascii?Q?8yr/1ojz81DfKwUVF1iNAycc3BP2rInwVF4yUtXwKZ92Hd/tqB2Izj2yxr2h?=
 =?us-ascii?Q?wMlH8OMwiYuYEJa5LJb7j4hCiv7gr0iN4dLXF65dd/3XXqJXghRxgV6qRz5W?=
 =?us-ascii?Q?3bRNgPRK1TZv/KHrn0PvGUVZESv6G+NW1COV0IyEyPNuwPNIYq8VeVOHaUfM?=
 =?us-ascii?Q?wwe5aohpYexFYqYL8HrDreH0AAAYIO9OsZkP/bfQrvIOWLZhKhA/Nxwoks48?=
 =?us-ascii?Q?VnriCvi4aWqImIqRfOsckmU+TWNy8DoCxXE0HOoYQnGM+w+iLl6T5CigPi29?=
 =?us-ascii?Q?qtvSss0fqFWfzxrRg8hmJLbAoAJSxtwIIcvTpS8/minWDn9AK5/NkV5iifdj?=
 =?us-ascii?Q?qo9IbFKm7SWMwBjpYbzmi8DbokjmKTJKWPIXmsY5geg1Yg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?x13k4TJP1YdLt5JTedyB+6LZNx8wpb+859eXyubYtxBFvJtuPKHUBU/zD4CE?=
 =?us-ascii?Q?ePtss3gXNPZOe/cA7DUkg63Qx9DX+2l8z6XUnh3OPlREphciPQOdROo70RyU?=
 =?us-ascii?Q?G/mPI/J65xDsB/72Re10NBShD+qIADuFxUFhsWcApTplbD9MulnhRebz1uOj?=
 =?us-ascii?Q?hIHm83/1WzCUSbOB+5e3dM7YLeugMC8IQ7k2rnHThklGCXGh+KZSJWHlW1BD?=
 =?us-ascii?Q?UzoltRoHIvpqLxdjCCBqsAmrt/d3MNDKpzg0BK2JSrEeulwnl5ybvJYwAWvj?=
 =?us-ascii?Q?bwSp4xe1dxmXmYX8tVNWFO9geC1zKAVQG7EMNRN0yP9U/BL9QNUjuHAOaZsn?=
 =?us-ascii?Q?PIjB52nPrxUIX3TmHaYO4Wf5WgQEio6n8aW03HaMCJJOn3MaIS5iYyE+RGtT?=
 =?us-ascii?Q?pBzfdoL3Rl2VtwLUVluXvq6PoP9gHYqPjy/5NJqu+ySxvGOPLqybfI/NMY1N?=
 =?us-ascii?Q?mBHDQPT550FyzHleOU0STeG6AlPNPZg6cIAnJcagV2EIbzoHGrpx5xofiCI8?=
 =?us-ascii?Q?0D4OBpZw8BYghTQqqY5lgF3WKABLcNx3/1WfJmUARo2TgHRaflsbA62e70aD?=
 =?us-ascii?Q?AXiibZJjY81G+wU2XtCXOpiu7RC60qdOfmm7f2Aorn/9QLVy++cActqoydyG?=
 =?us-ascii?Q?iFC1hZNRvX/zAc2NLTTzBYnv26DnFJbvrlb4QtLb2z95sPfjNRUEP+v4hgFy?=
 =?us-ascii?Q?jptNFDfjIJzvErVLUeUXVUTLj0AZy6RpF2AIQmC8X5r1hz2qqEWtTgh4wM0K?=
 =?us-ascii?Q?57bz2pRbnRA+V0CC7yGOu6ydxhREPT1/hX2dE+1f2+dce63vO5phD7evJLLI?=
 =?us-ascii?Q?NmtLFZa3HevuhekWoqubiZVjn7w1uhlXob8A5HWMdLQ6BaHP3RtJ1sF4lI6I?=
 =?us-ascii?Q?CBxG0mUZyC1cbffypFPWoEl2y5t929Y7MlUuB8eVBcCcrvgDnYW0GGPWBuMj?=
 =?us-ascii?Q?6O0/gtd/URCPPynObXtiGPokFPju3irrXq3V5FxlKpIh9IjF3R1pIiPfKYpj?=
 =?us-ascii?Q?txkmqgB6g1WrT9IzCA2xs+eww8rj2Y5DGDSSkuctH3rX8X3/ytVZJdh28L9b?=
 =?us-ascii?Q?5NhgtpRsNvWXcKo8dkYZnJLfccMOcBniPmYz4mxOIdi/Q6p5EAzo8z5R3oG1?=
 =?us-ascii?Q?3y25GaQF3OCL6zWXUvmYSjeGy83jQ4EAQtj7+VoHqylgL94gou5yCHXmKal7?=
 =?us-ascii?Q?uildsr/aD7ZZUM1FN2LI5Jsz+8Px+tEZSh8X6UqlLbz+OAtKngXtTWhcJd7X?=
 =?us-ascii?Q?gHuwzYDFrYQzbYr5Who6MzgCYhBDfDPaBvZMpnQUOJhRTUhx3+2R7s7eU/FS?=
 =?us-ascii?Q?VeVwA7EnSR0MBVtPikqf6HZCFO7y0qumspakz4c5AuXNWA4m0i2i9+RKKHhX?=
 =?us-ascii?Q?MlYjeC5HW1A23Usaf7aD+mIp3+Lqrt8yWimjiPaThUhCVQGnSaB9fPSqmgXl?=
 =?us-ascii?Q?2+Ld+Pctgyt7HmQtrY94Lj0ZjThgpimE6rtSgWhaQhJ1kpYr+VYle5B3Asdo?=
 =?us-ascii?Q?7BGJX6gUbbsDsGOcCzcP+b0UvvoRxPtu9IJsgL9QuDdYzAjQpZHEi2HTVTIr?=
 =?us-ascii?Q?fE3pTUt2bmqzYBGIGdgQE4G0EI+mKuyPmakc+5Qb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a086e2-b9b3-4ac2-66d7-08dc808d06a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 09:43:57.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwxKecJLHaeFqfdzeI8pHxz4HCj5MJLQ+GFoEbLmsN0F56oSAFbiVaoNNOGjTcCCByMMuR+F8CRSeKt/tO0l1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-ORIG-GUID: qUGq11LR5qwvAMewfqQ6baVg0fNctafg
X-Proofpoint-GUID: qUGq11LR5qwvAMewfqQ6baVg0fNctafg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300073

Hello Andrew,

I was reading back into the MACPHY specifications in OPEN Alliance, and it =
seems like MMS 10 to MMS 15 are actually allowed as vendor specific registe=
rs. See page 50.
The specifications further say that vendor specific registers of the PHY th=
at would normally be in MMD30-31 (ie, excluding the PLCA registers and the =
other OPEN standard registers) would go into MMS10 to MMS15.

So I'm wondering, why is it bad to have vendor specific registers into MMD1=
0 to MMD15?
I think the framework should allow non-standard stuff to be mapped into the=
se, no?

Thanks,
Piergiorgio

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: 24 May, 2024 23:55
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>; Parthiban.Veeraso=
oran@microchip.com; davem@davemloft.net; edumazet@google.com; kuba@kernel.o=
rg; pabeni@redhat.com; horms@kernel.org; saeedm@nvidia.com; anthony.l.nguye=
n@intel.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@l=
wn.net; linux-doc@vger.kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+=
dt@linaro.org; conor+dt@kernel.org; devicetree@vger.kernel.org; Horatiu.Vul=
tur@microchip.com; ruanjinjie@huawei.com; Steen.Hegelund@microchip.com; vla=
dimir.oltean@nxp.com; UNGLinuxDriver@microchip.com; Thorsten.Kummermehr@mic=
rochip.com; Nicolas.Ferre@microchip.com; benjamin.bigler@bernformulastudent=
.ch
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance 10BASE=
-T1x MACPHY Serial Interface

[External Email]: This email arrived from an external source - Please exerc=
ise caution when opening any attachments or clicking on links.

> In reality, it is not the PHY having register in MMS12, and not even=20
> the MAC. These are really "chip-specific" registers, unrelated to=20
> networking (e.g., GPIOs, HW diagnostics, etc.).

Having a GPIO driver within the MAC driver is O.K. For hardware diagnostics=
 you should be using devlink, which many MAC drivers have. So i don't see a=
 need for the PHY driver to access MMS 12.

Anyway, we can do a real review when you post your code.

> Although, I think it is a good idea anyway to allow the MACPHY drivers=20
> to hook into / extend the MDIO access functions.  If anything, because=20
> of the hacks you mentioned. But also to allow vendor-specific=20
> extensions.

But we don't want vendor specific extensions. OS 101, the OS is there to ma=
ke all hardware look the same. And in general, it is not often that vendors=
 actually come up with anything unique. And if they do, and it is useful, o=
ther vendors will copy it. So rather than doing vendor specific extensions,=
 you should be thinking about how to export it in a way which is common acr=
oss multiple vendors.

   Andrew

