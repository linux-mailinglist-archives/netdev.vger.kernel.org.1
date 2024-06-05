Return-Path: <netdev+bounces-101184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDBB8FDA7B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB554285995
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591CA169AFC;
	Wed,  5 Jun 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="QD8tLFru";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="Y11Y5tbF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68892168C35;
	Wed,  5 Jun 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630061; cv=fail; b=BHn7/9xjffGBbsTBwrLGkqJoNAhuHDNzj5PbKkpDThzBSX9H4xlAaOrnpWyICRHK5FoMDgybwYhMAUcx+Rl68hh7GmxVSkEBU2IO8K8tJtCWcEVPSIv6JQasEEteU1JLf80Fd3MqeY5ZpruwMQoP1ozLq38jQFRG86Zna4R2BAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630061; c=relaxed/simple;
	bh=TTRXyDgxb2Y2s4q7R/vDTHP8qqvFqFO+E8SDyju5vn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhYRcnaRXQIMQcMb1puWFIfUXwVup/FaOqDKnInjZcC+MgRKyynTLL1MKe5VcxWFx4K45v80EshJOarrhnf8hpnJKGu0J0aMo7Zfi294tY5UP2T2QKabP/1Wye7x5TvPY90hCCxl/slfUgr8pbVLpdl4/oKtNdCpXoWaZIwdBtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=QD8tLFru; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=Y11Y5tbF; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
	by mx0a-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455DPnL3008188;
	Wed, 5 Jun 2024 15:40:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=8Ze5w4FmHI9nvB9s35vgx+sAFx8TfwLHtXNZjIaLBbQ=; b=
	QD8tLFruK6APhd+JGFb37ofGOC36+mHP0imJRItEjHHRDYKJL05g1H0QxvmC2elO
	OU8WiH/dYrG3LGf6Q7FY7ak4Nbkkk8eyTkT7JJ1U7zDn6ciXmYtgufdQumAMNavV
	RKeD7OO7vZm1KfjWJDR9qAFP4bNQ3msHn5OZGOK/aPyP08Jsc1Z69kp9E8tWhozV
	jP8I2XYD3vvX8vJ/9hS6VLaoW2hL3+Fd5OslvQfMSiuj+OdYEpBhtw7q6vdG6dyI
	d6UH+lo4nRPep6/mzajPi2OHU3xu0RKDcWjl92Z5/6ahBTO2SsVW/118srQi0ipp
	hpl94yeJQDQtMxnvp2qneA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00183b01.pphosted.com (PPS) with ESMTPS id 3yjrvx0vug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 15:40:16 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH+0sMsBw6x2YH21wPKmo9gJSu8emwSY9ve4cMMVe4Y444yYhnD6KRbso4jhbqb0MHV1hHk67iqv0Uy2glhWh8hIUFEMecNwMtXEMucamvv2iq7bYn1eKK2PwUAawmEUDBDFVZyWVt73xF/hl2J/Pj6hQKp4YHhHNLG0GrKJojBoD/a+WJLfyzZr29cJqjrok+eyO4UZufHjXntTjemaUGLNwDRaCR98fv7zju8OEn5mtjPIcs1yhf28rsZiqzioxhApYL+GgljGdSv460D8oWWcSieSGkg6YgZBxEyKaK8BM4TDz8biy+lrKYlm/BZl+RWyRrYrfhr9iWP9k2UF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ze5w4FmHI9nvB9s35vgx+sAFx8TfwLHtXNZjIaLBbQ=;
 b=l+07WWy4X2kpdrZRaidtwJXmGlvrzPP+LwNW1PbVuVaNkPXhc8YYUnBdbsLsdPnuNvcku0xS7gCH/33TBewleyTX6CCCvlQ6JbpJtoTItWJjy3yxj2eiBwKzuz4lHaQwtod0UvOntRrEoR1IjMEcq9n6CJICB46UjiNa3q3zI2w2ANozof4nCz1Ypf1vVusvgReDFykoGQE7KuDQ4iws75Ro1eBKHFrDbUsawITPZGb/r/by03ws+aeR1sXdKtVZ/XlEwHa7vW5X/+YtDwQ1B9jRKBnoCdvCfcqqfG487ZD8/pAkQ6yHMissQhTdRGbTLHrPhArChc+6RWlJItzZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ze5w4FmHI9nvB9s35vgx+sAFx8TfwLHtXNZjIaLBbQ=;
 b=Y11Y5tbF6zbJ3CLT4hzvGLIk9hg4BFeli0TlljnAVbU/RoAlXAMe+YyL8rIq6N8Trz4MdldiIwsT5RoZzQDYPfxa8pj4gVQbegLkmxLVhV1o5HOQEd4zfgijMRGSp86sQaSFEttfPyWvQLN2+eH+vfe7X8dZe4jyCy025clYmWU=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by SA3PR02MB9376.namprd02.prod.outlook.com (2603:10b6:806:318::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Wed, 5 Jun
 2024 21:40:12 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::9050:b9f2:336c:edaa%4]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 21:40:12 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>,
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
 AQHakZAzTzY8uLDqjU+aLRkJ24TPX7F0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaZtCCAAA/6AIAABQ4AgAACngCACKHOAIABvDqAgAAGhgCAACuYgIAEK/gAgAQWz/A=
Date: Wed, 5 Jun 2024 21:40:12 +0000
Message-ID: 
 <BYAPR02MB5958BD922DAE2D31F18241B283F92@BYAPR02MB5958.namprd02.prod.outlook.com>
References: <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
In-Reply-To: <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|SA3PR02MB9376:EE_
x-ms-office365-filtering-correlation-id: a3ba9fc2-ce31-40cc-9432-08dc85a8144c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?L8TdOSq8RrL6Snn8bNJOr6J3J7p5NmwpMcI4GGbfiUpLJTcJx2A0WU8SnSIE?=
 =?us-ascii?Q?NonRZVw2UKqTlvlI4H2RdU/tjSvKhJJ0khIf1Vm4mtNbmemRdrTo/KFFyFqz?=
 =?us-ascii?Q?Aso9D8YeBXDFU+ICIOThibiLAmMqkwykIc6a0ys+OVw7xQgsZ1+TNs6NooQS?=
 =?us-ascii?Q?O4LnFZWkMZvEL6VBR6k5+ZUIzz7kQprk3PRN+QqfyTZuVjnhfA0NjrzBTC5p?=
 =?us-ascii?Q?XCSwad7k7MhRU4dkWmbukjnwrLMy5sZeQGtQzGo4hr4ptaS25gCbawuT5eV3?=
 =?us-ascii?Q?8ata/L90jZbA0tgMN+kYK4C9D4wi8MObux48PqoknVbY/Pl+Kkn8gpsa/hIP?=
 =?us-ascii?Q?f265JsiCuUT62inlJAHHl1Ba6GTCie1XePpyPZ2LbGCp7/wXIfhpmijAJEoe?=
 =?us-ascii?Q?o31NnYQKpAZNQb6mqm9/Y+kySYrpPaOstnBvhM7CAHVy4yyhIFd46CLoxjRL?=
 =?us-ascii?Q?Rp9Drzu/vNdT8fg8lqSiNGrFZbs+OZJz/IzuGuEXrb94lNWX0FPIB4AViANK?=
 =?us-ascii?Q?6v22cVQbybr6yY+BIGQzuOp9rKgBYMLJoFnCFeBaIzi5ycUaLd3BWcK84INe?=
 =?us-ascii?Q?2MpCZN10YzNe/zD1SlXHC6ekSnQWrbC5EQ7v4+MeRtysQJc5/KxDAJ6F2Bj3?=
 =?us-ascii?Q?752J4n3NZUA/te+U87htW5DtadwvtIUOnRKeSqWN+U8VuvuvaJxIinvI8m/t?=
 =?us-ascii?Q?/aQtq4pZsTxYUSMYg7zXg9jcrgnL9HfkP6isluNFTFj+MYkTmRUIMJls2SIl?=
 =?us-ascii?Q?Ux97fU2SMOPSpSgVDWlZmWxvWC2SsbTem1v6d2DiACg9uK+H1PjoHb6CZ5pJ?=
 =?us-ascii?Q?nnWIHl787G01aIWPZ/5vq2Xl0mwppwRnLRJ9s/TiGK3y53HjFMjbYOYZLHXR?=
 =?us-ascii?Q?rd0qy83E8yFS8K3PnE+jbJ9rNauZagTnbJONqnCQo9/I8lksMcRzIyHayLFj?=
 =?us-ascii?Q?kCplSVKGoMGATZJ8F7GQen9k+GdcSUfsRg1FEUsb75ZG84JS+1u1koa6uoIl?=
 =?us-ascii?Q?K4rjMPc8IjxCETwkgtj7ymNRrm/JS6wOF6tJnwpLsuBuy5zu1kUhiOi+3HdM?=
 =?us-ascii?Q?FQBFZ3ml82r3QlvymqbTn/eA11b5YVc0mCapVHbPmoqc7U4n5go7d2vutN/U?=
 =?us-ascii?Q?/gYVD7b6FXxrma5FqYKE0kxo2jcxgdMbh502//3/hC2GSdlZKNf4Kt5I7cDm?=
 =?us-ascii?Q?So3Ci8scc3rELfupQsmwoLlBcioxSimJY/rxsFIDonXIyaFVgX/S95FILEv/?=
 =?us-ascii?Q?fsO7KJmf+chPfDWTjCgYKIWPO4aeRGwA5FexADijNA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?s6sNL3cNKP9XZf0dT4KprG/fsJCycO4lM9r0faMhbH2eLitLqGUkRlkckLtP?=
 =?us-ascii?Q?VS8OM/DkJvfXAbEWNh9HZ78J2X1xhFc2gdovvYfXIH/QNf7fn5KR48F1TAXw?=
 =?us-ascii?Q?cJe2wvFTVEFhrVI2tOnkGim6pjzmynzkSQZ+x8dmzGD/2aDwWrvDd3u/iSOZ?=
 =?us-ascii?Q?6HijI0gcYXzRm+NWbm0u7ZDySkL5acWjohTkuRJsPQCf3X0udAFw/ca3JKiW?=
 =?us-ascii?Q?sW+QQDA3Hhrz6LN4w0kC+f9gyNRQGZIjr+mI0OnmSgRSYlw0mLXOqRA46I9o?=
 =?us-ascii?Q?pi/YLJla9y/V8GmF+vtmCrPluCEfQOjYnuKENe2835NdxjvBTCmC6rP2/ctJ?=
 =?us-ascii?Q?U9kkLZoEml2JEAqjFlc4huCQgudIRFvueNUJNwBS302sMEhPJE05GFPv5Rr1?=
 =?us-ascii?Q?ukbykhbFrkqKMoIugR3xR76XING1b61MOvrHdDnqUUufoe6sNtZdq17Ug93m?=
 =?us-ascii?Q?JTdynHHl9CRCV8YUuhDuZQSBzfbdgh/oQicT0evGob0k53JQDogqPD1RsRQq?=
 =?us-ascii?Q?5n6FmugjmZBCfawY7m/jCU6dT/DYSYr//lwE3tFLQTkjl5UapnpYVE1u+ZyX?=
 =?us-ascii?Q?TU66vv13RMWDxDhkk4UpH7jHxtdT3BoTCeaH6L19lFb8IxjXCtBQ/eQ/iG0A?=
 =?us-ascii?Q?2dIZ52C/XXP0Z4SKQIlS/khUxxJVZKQ79J1QxtkcLrnVzF66RHyRsIvN9/Mb?=
 =?us-ascii?Q?AhbaxBgQex2t2KfmH5uYzrC65vpbFnJIl6cxZIoOowoL0QfsuuiPX6rIueIi?=
 =?us-ascii?Q?P/0R844IH27sJgNUAbG/bha+7j6pCy0Rp0a/KBXVzomzWtqOIED6Gc+ag0i8?=
 =?us-ascii?Q?xNyMOEyizPoSSskvzzwmiOE2b/r0I51UrtuCgGE1xKrnGC4WJbM210vqE6uB?=
 =?us-ascii?Q?OZdtj2iLLS3r5/v6tw8e3nqN1RqPDx1NMWGZwnh5jxk6IAeehs/PhaWVjoV3?=
 =?us-ascii?Q?F+ayN4+tQCQmJdpBwjfh/XKVwVKHzDwmtQ+R3kHngmUYN5lYbxDEIVRgdCER?=
 =?us-ascii?Q?fJ9vMQB2pbCJURII3WziUDDQ7blrPxH65GZ0jf5QxFZSLQWqNOszyjNk3R5S?=
 =?us-ascii?Q?05V4PGTdc+oJpv7+jsFRDL+CanvKP5QHrbOlF5YgrK7aDbrM39dvNs/UO4y0?=
 =?us-ascii?Q?7zjlrB5vSWNS6ClYxzufJmMaQ0IRWE6YqACJ0w/+vEcTQPzcKKefQ061UWbt?=
 =?us-ascii?Q?VRyeVioLmi1SEh57laM5V7IU8KM1qCguAEvC0NuVLYPLOi+C3vMSO5D+8yW2?=
 =?us-ascii?Q?+UjTHtOYG6Ft09ZkLHTbLhRHzaOyxo1zCZ6mQAFFjDHHwn/Mycmkd/awEvUw?=
 =?us-ascii?Q?8idqgXiTiHUELEOavFrt7VC+YSNH1CdJa8yU7ryL0R62UOwRemSdZ4eTTp7D?=
 =?us-ascii?Q?IEeQfMozyWiBL+qsS2qbWedHimgGIi6moibADO15ONHcFPaVcJx5Hcp5QEhh?=
 =?us-ascii?Q?GvP7jPbr6cvZmrIpC7cEvx6wYSSn717/YGdahdQJC8oPBHzNmjJ8EJFLZcy1?=
 =?us-ascii?Q?t7IFtGWaonaAp+0dPD4C0pbI+T5RuT9n0A9DaJSNDXjlHKSdJIwdFBl0WEdU?=
 =?us-ascii?Q?T7ASLzaVGd/xxXE5Z5t0HzbPcG0Dd+y5bG3gYJI6LuansluRmzK4F9E6lgTv?=
 =?us-ascii?Q?8w=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba9fc2-ce31-40cc-9432-08dc85a8144c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 21:40:12.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nrt6T9rIL1wMgjvdZptWbXGrvKrWe2di0zB0zOfTugPqlRK7I31bLepfHP4hwM8sx56nKmPPJLO/1y66ncZU9cHGMs6ybuN1Sh4hiusDns8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9376
X-Proofpoint-ORIG-GUID: BTuKSGs2Ug6YRzQRxO9JiidobixtrmcA
X-Proofpoint-GUID: BTuKSGs2Ug6YRzQRxO9JiidobixtrmcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050162

Parthiban/Andrew,

Couple of requests / suggestions after completing the integration of our dr=
ivers to the current framework.

1) Can we move memory map selector definitions (OA_TC6_PHY_C45_PCS_MMS2 and=
 other 4 definitions) to the header file
     include/linux/oa_tc6.h?
     Also, if possible, could we add the MMS0, MMS1?. Our driver is using t=
hem. Of course, we could add it when we submit our driver.

2) If it not too late to ask, Is it possible to move interrupt handler to v=
endor's code? ( oa_tc6_macphy_isr ). Instead, we could provide a function
    oa_tc6_wakeup(priv->oa_tc6) in oa_tc6.c, so that vendors' ISR code can =
use them to notify the  work queue tc6->spi_wq.
    This way, it will provide vendors' code an ability to deal with some of=
 the interrupts. For example, our code deals with PHYINT bit. In the curren=
t
    framework, interrupts are handled in the common framework (oa_tc6.c) an=
d status bits are cleared there.

    I believe that change would require vendors to call "request_irq", whic=
h should be OK.

Sincerely
Selva

> -----Original Message-----
> From: Parthiban.Veerasooran@microchip.com
> <Parthiban.Veerasooran@microchip.com>
> Sent: Sunday, June 2, 2024 11:56 PM
> To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>; andrew@lunn.ch
> Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; saeedm@nvidia.com;
> anthony.l.nguyen@intel.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; corbet@lwn.net; linux-doc@vger.kernel.org;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; devicetree@vger.kernel.org;
> Horatiu.Vultur@microchip.com; ruanjinjie@huawei.com;
> Steen.Hegelund@microchip.com; vladimir.oltean@nxp.com;
> UNGLinuxDriver@microchip.com;
> Thorsten.Kummermehr@microchip.com;
> Nicolas.Ferre@microchip.com;
> benjamin.bigler@bernformulastudent.ch; Viliam Vozar
> <Viliam.Vozar@onsemi.com>; Arndt Schuebel
> <Arndt.Schuebel@onsemi.com>
> Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
> 10BASE-T1x MACPHY Serial Interface
>=20
> [External Email]: This email arrived from an external source - Please
> exercise caution when opening any attachments or clicking on links.
>=20
> Hi Piergiorgio,
>=20
> On 31/05/24 8:43 pm, Piergiorgio Beruto wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> >
> > Hi Andrew,
> > We're currently working on re-factoring our driver onto the
> framework.
> > I will make sure we can give you a feedback ASAP.
> >
> > We're also trying to asses the performance difference between what
> we have now and what we can achieve after re-factorng.
> That's cool. As Andrew commented in the other email, let me know the
> feedback if you have any to be addressed in the v5 patch series to
> support the basic communication.
>=20
> Best regards,
> Parthiban V
> >
> > Thanks,
> > Piergiorgio
> >
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: 31 May, 2024 14:37
> > To: Parthiban.Veerasooran@microchip.com
> > Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>; Selvamani
> Rajagopal <Selvamani.Rajagopal@onsemi.com>;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; saeedm@nvidia.com;
> anthony.l.nguyen@intel.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; corbet@lwn.net; linux-doc@vger.kernel.org;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; devicetree@vger.kernel.org;
> Horatiu.Vultur@microchip.com; ruanjinjie@huawei.com;
> Steen.Hegelund@microchip.com; vladimir.oltean@nxp.com;
> UNGLinuxDriver@microchip.com;
> Thorsten.Kummermehr@microchip.com;
> Nicolas.Ferre@microchip.com;
> benjamin.bigler@bernformulastudent.ch; Viliam Vozar
> <Viliam.Vozar@onsemi.com>; Arndt Schuebel
> <Arndt.Schuebel@onsemi.com>
> > Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN
> Alliance 10BASE-T1x MACPHY Serial Interface
> >
> > [External Email]: This email arrived from an external source - Please
> exercise caution when opening any attachments or clicking on links.
> >
> >> So I would request all of you to give your comments on the existing
> >> implementation in the patch series to improve better. Once this
> >> version is mainlined we will discuss further to implement further
> >> features supported. I feel the current discussion doesn't have any
> >> impact on the existing implementation which supports basic 10Base-
> T1S
> >> Ethernet communication.
> >
> > Agreed. Lets focus on what we have now.
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 2Furldefense.com%2Fv3%2F__https%3A%2F%2Fpatchwork.kernel.org
> %2Fproject%2Fnetdevbpf%2Fpatch%2F20240418125648.372526-2-
> Parthiban.Veerasooran%40microchip.com%2F__%3B!!KkVubWw!n9Q
> OIA72sKA9z72UFogHeBRnA8Hse9gmIqzNv27f7Tc-
> 4dYH1KA__DfMSmln-uBotO-
> bnw3PC2qXbfRn%24&data=3D05%7C02%7CSelvamani.Rajagopal%40on
> semi.com%7Cc9784216cb1143af435408dc839a3822%7C04e1674b7
> af54d13a08264fc6e42384c%7C1%7C0%7C638529945611367664%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DeT
> wuSpyx1KIPuOXV3krpjqElcbhU0zBoTmPjj0srUTs%3D&reserved=3D0
> >
> > Version 4 failed to apply. So we are missing all the CI tests. We need =
a
> v5 which cleanly applies to net-next in order for those tests to run.
> >
> > I think we should disable vendor interrupts by default, since we
> currently have no way to handle them.
> >
> > I had a quick look at the comments on the patches. I don't think we
> have any other big issues not agreed on. So please post a v5 with them
> all addressed and we will see what the CI says.
> >
> > Piergiorgio, if you have any real problems getting basic support for
> your device working with this framework, now would be a good time to
> raise the problems.
> >
> >          Andrew


