Return-Path: <netdev+bounces-99561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D48D54AD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE39428670C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F01181D03;
	Thu, 30 May 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="maEEPzDr";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="W7V9cFcL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B2181B91;
	Thu, 30 May 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105073; cv=fail; b=B/1Y3JkStiRTNAD08NJijg2PlRcE4r3QT0DTfc9UehFEJ/41ormjLKt4ydGzJfYrW6X5vrImV7+89qjA2SdgHUAJepRYPGAWoa/PZBqPvRhSKESiztbo16AJW5BFgQok9sEmptgflKnzDTh+h4InGaP7bgmepA0sNveEJSM4JCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105073; c=relaxed/simple;
	bh=0GEUQRg77BTJSJRUgB8cqJJwGsTU0Y5/hwSneNmliH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQNq4+cmUwRzT+/54EL0O8ZVId693978Zv5tYo1BUFB8K7gbcEHcB8F305m34oF2vPPk8kriUR0Q8wC6UPJIzQIdjQ++yMjra9Z5hyUhr8K5mHkRPC72xG9QetNZUyy5TujXcvHkOIcff9Ea+rYRVV/6cwgAKi3lxQSvEdG2GSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=maEEPzDr; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=W7V9cFcL; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UI329Q017130;
	Thu, 30 May 2024 15:37:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=0GEUQRg77BTJSJRUgB8cqJJwGsTU0Y5/hwSneNmliH4=; b=
	maEEPzDrSYbETyirG3/y+jNumHdJHtbwB0kqdG2+3Wnwb9cM/m2ZsWS5inoTViAT
	qHRWL9xRkvyqalCxax3fnEgnq1u3utZynUMoRrHkCPUkMJZqRhdosDZZm7iI6D1e
	+aBP1qmNtC3qPjk62WjNR7DxEWOxPpgVDH8fgnFb09yvNthwqE5m+Cnvl9yTwKOM
	dSHygNooAbZXbKRtnovAPDsf7CxVMTKn96VA1bFeqjQNlcJ4YOTeiGZ67BunrjpP
	oZPDuAbvpXMIIdHgxNXCVMXRj9pfRGJb+mn6XX7ZmbNnaCHocvPTFUgIngonanRS
	6zHm1X5b8XHrk0O7VcbOlw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010002.outbound.protection.outlook.com [40.93.20.2])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3ybb77mjka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 15:37:09 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbejg52snibudZInymejtuHYjldoQyApQp4aTcPukkerNu616xp9Kph5kjI+3LIflPedXgz/Z6hv6XvN2zZvRCDm7pVJxbWvxKI4jNfA709AiLLxOECTLC9K/teDZwWX1Z/NLoq0Xi5isC8i+mZE+OQ243vrmtj3jt6XSLjUFfLB8cZZgF7+G7AFAK8rRht/a/qQ867kfOsJ13zw3wEU5dAtrva4S4GlJgGdxG4Kt+ZRAu62o3eTuNRREvBz3SZykSBFQtDgmJ9xFmQ6fA1gVLJnj/uGzP7+xUt61QnV5F3e9G8n+HZFtnR9SUcnj8XZORbHUeX2GUhLVDaRVgQAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GEUQRg77BTJSJRUgB8cqJJwGsTU0Y5/hwSneNmliH4=;
 b=OXRfcwbvzZco6WxEqg6tXZcgoDshSaUT8YRcqQEMzSfZvmnkAjBmdg5tVmfU2RcW/M1CzMceezDLiYPD57TfCIvgkohz2WgptpDlRqZfyPhh+Rvb2rZIY9ZkqREbifefJfFI6z/wSjh32/EhIIj7/Y9SbjcsMeMbFZii8KlGN911Le1zz/cWBG+fVjEvaY1TYkGLl7YjKb1wE+tO4xdVeUhtX/TK7/s6p6z7g+JU/7wB+BwNMS8K5M0MbOUrKawyjLdd2dL71XcJGsai90781unIeZm2YrybNi2zURW36lEDoKsMOTdk6FuS78EXFpMJrLFlhRJ6oBmPSmdp2LHVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GEUQRg77BTJSJRUgB8cqJJwGsTU0Y5/hwSneNmliH4=;
 b=W7V9cFcLV79bITT/NYauA6D/3neNq5JWeVWlHI9nLFADbkycLUTbDgKnBSDddLYxBGWxnGzT1/oJmRIypGDnXdnYnSZ6a96D0KC5ZRdfWXpmV8OZ7LGBRZp07j0o6vg/j8x6WLM8H8bp92Ph4/DZQv/9qENAG+4eU2IoxaCn3a8=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by SJ2PR02MB10076.namprd02.prod.outlook.com (2603:10b6:a03:566::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Thu, 30 May
 2024 21:37:05 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%3]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:37:04 +0000
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
 AQHakZAxosrycArunkaHEujJo3A4abF0voeAgAA2YYCAGHiwAIAAQuMAgAFPWgCAAH78AIAA9q2AgBaf7QCAAAnBAIAAAr5ggAAE7gCACKAxgIAAOlGAgACMgZA=
Date: Thu, 30 May 2024 21:37:04 +0000
Message-ID: 
 <BY5PR02MB678680FB7F10F1E6B9A859379DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <70cf84d1-99ad-4c30-9811-f796f21e6391@lunn.ch>
In-Reply-To: <70cf84d1-99ad-4c30-9811-f796f21e6391@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|SJ2PR02MB10076:EE_
x-ms-office365-filtering-correlation-id: eef5c493-b89e-4150-c453-08dc80f0a639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1eyN8oqFKO4Yr7slrfuzuf6CDcKClQ7pPg9Tsg+HtFt1QQV6qs+vJY+YpoB8?=
 =?us-ascii?Q?e0o33yuNFTVutKYz5a14b13rCSoOwvDFSjw1gipRxerL1VJKp+nIvWYVdCL1?=
 =?us-ascii?Q?H2K8viTznBIzbrY4qqG4mKGxO507wUSLesAWCEN4Sj5Hfb/TyoM+2u0tVJm2?=
 =?us-ascii?Q?WB7JtuCfs3Y03LFcNCIyIGnwL3cA7iqnd1lKminy239UgKCJscnvr4ximW9q?=
 =?us-ascii?Q?BwDg0psbfC04xfZdP8RF8F7YYB18anImVUa2WKUh+n+mX6Du1WQsjyj3XwvH?=
 =?us-ascii?Q?ifhqa+M+enOtFxuRuLbE9kSD049GDaa8b5hyeVCF+IeKDXbwLJhyIB363cwY?=
 =?us-ascii?Q?FEHMeLzoZuoHBaFw+mlazkEQaN34em/Huxo2OQuDB2WDvYs6otbFE7xgyNgX?=
 =?us-ascii?Q?stWuAONVv9UTKvPWB8NVv/CP85VBzSS7qMbhDliUBtBoTIwHpoWUgeTqEc0t?=
 =?us-ascii?Q?oD4mVThkPq2nd0w0EvN3nXOikgdkSU1m/u4A1z1oYWt9BM9RQ+4Cg7rH6RLm?=
 =?us-ascii?Q?pS00MCTCKma5jCfgDsLibW7gjxgVHy3QOVtt85FINfym/DTTgVcXLNy8QEX0?=
 =?us-ascii?Q?2kb9oFUCEMQ6GCSDh5bu8VWNp2qYzsMnxhAfPAeo/hLH6Yhya+P7gNa8lC2d?=
 =?us-ascii?Q?IoQdeKa1YTXDjwn5FENlzbTcwcuWcFKfgKx8RZgwKDORVt9SzUWvsKBzAv2T?=
 =?us-ascii?Q?8OB9X7EQsMwtsABMJNiHa5XboTJWcsuoU6BkDYf4zOvt/xMCwnzAtmH7uUY7?=
 =?us-ascii?Q?2SFN04yl+I/0/aKb+ObCaqP8jdlepynAOKSwiGGP2NqirACgCXgyNd1808AU?=
 =?us-ascii?Q?rpLbKFhOY3XtdILssf/XeJ/MS0x8Re9x5a5lH54CmcRLBMfveYOa2Xyirz15?=
 =?us-ascii?Q?gsjoWhbGhL2epZQ4Xruz2TDaCoQxnv1TT9nqdLd6t1COHe1OrNQdusdAJ/iI?=
 =?us-ascii?Q?TuDdfBmy4nEVbfdgbC7NNviZXUz4P3jz25yUd/bv1tIUN4qzzhAJ9Bv2rnxh?=
 =?us-ascii?Q?/Vjh67XW3RdKM4EHmTveBDMZtIFACeUtjwgP8k1VOp8Es6WlLSGG0WdS127Z?=
 =?us-ascii?Q?t/0OAc7N3eCRMj0Y48tretZfk1RkJpon1J88/+teBBsFIdjswhVJoa4QIceG?=
 =?us-ascii?Q?kJLa2i3ekPD1TkO2Wtaf/cGleymVTdRQ3EezczGD0OfEFtx3q8VHMG1l67y0?=
 =?us-ascii?Q?9IYXpk5H4yU7mRTB5e6ObrYeK5nGjCpzlOlrG/XD+DbeWbjgmtE0Z5fO20hm?=
 =?us-ascii?Q?1Rt02nS6hAhG4dPBv4xN9ooggIo31biiI/8qVOq+hgXG7M65s9n6j5cO80xT?=
 =?us-ascii?Q?h1LhNoTENRThnBfPufFjCTrSeRJhHJkn2Zhw1p4OOlcYGA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qjB2NtfZkPJrUz17P5J0FF3AGIvkpCwXFYK7LBxogfQZtMrkHaOHDNxcSWmq?=
 =?us-ascii?Q?2ak4i0w7HcCtdrTFyaq1zI1z6RPWNiX1mhApAQ1WuEeHjntkZSdN1u0/fztP?=
 =?us-ascii?Q?2alXSwvf/LUQKKTSN001eBRvqRRpEmnBkkw+wRLfd2QuesbGmZQFNMrmL5L3?=
 =?us-ascii?Q?3tapHTLdhTGyHgN2ErR+k5jhA3woVNDJ98+F/AP2jMCmQqZwvNp9GhXg5X/V?=
 =?us-ascii?Q?+I64sDXd4gBivvLRpS2eZa9SwQoedU/88bDrkfQm+yqd9TOq2Hi0xLwXM9GN?=
 =?us-ascii?Q?tbKUkiosrWWA65N8UO/IMO8MnVDH6qbguB+STQaNfMERor6LQrFG5LJEUbB5?=
 =?us-ascii?Q?n7L1cHM1H10h8EtdcnErQCTqeK4xLjCkgvaMSEPjCSPqdHzp4QJg/mCQIm3W?=
 =?us-ascii?Q?zQP1MPMiVzCH1c4Wwk2EfMb/L91rigYRo/j0oooEoC2PctIB3qWe+jMGB4qe?=
 =?us-ascii?Q?6SynOtQzBbApyu78YM0eAeWJ83mC8A2eYR/HMun+S5Aj5kBBxF1H4Dn4p3qF?=
 =?us-ascii?Q?3XEg5w83VBx1+TM1GfpjBYJqbxFCtPyzzuVjv75tHLdBnoDtcCYzpVQ1NCe3?=
 =?us-ascii?Q?R+TpkCg54WFcM+q3Vc5gKEKvFkyS3Qc1YioGB0GjiUoJ4LmOPhrfzKgYQmhS?=
 =?us-ascii?Q?PG8IPp12zYy7OE3i0dWHzDCtfKwn6tgwYf4TixQigZgdIf9pKcKKJXnalJ/G?=
 =?us-ascii?Q?GzDlFskNn4ccMhk9/mubfaz0xNkEIWwAo7avzdzUei6CLl0x4VyoKsZ81BTU?=
 =?us-ascii?Q?Px08lbm5dLjl5oKVud8K51V8TB4HR51jRD90s5JGx/SqUlQ6DogXDYnZMwkq?=
 =?us-ascii?Q?Vg+Djw5idoeqCbHQR6MDTr0fZS6iRcvHT/PeJNLVI6w7DO7H1yN4/gl4ml/o?=
 =?us-ascii?Q?sEr8iUvN8E4NtSEtqKK9PhSU86ck2wXLjkBvCrh83GqhrSMqsicHO+K3+paI?=
 =?us-ascii?Q?9Yejf5EXBVQVQ5fXxCCJVpOdNzAucGImmliTpATBwVq+ojLR+OXldTK2azvg?=
 =?us-ascii?Q?KfZLLfljZs1n1lmsmm4OruuWGb3sP+cVCOc+RT5pClv0f5SMfDos1WQXscuy?=
 =?us-ascii?Q?ikeF9XAHTESe/PpUBiXW/Ts5iAJ77DWBMLSCiEjSdA3/rEKTTGwsJaxOCb1M?=
 =?us-ascii?Q?APTahZ09rSiXSqDVeDVDT26RyHv3SSe/F+sUy/Sy+LySCZjh1i5t57J/1ZEv?=
 =?us-ascii?Q?9ku0FQNmsAMdlUtH7c8173BtRp4aKKKq5LKnlWHJ+umvBmnrqfxjJcqEFjZN?=
 =?us-ascii?Q?DyvRS45HW7pl3D3UajfghqN8h4M3Lc5wLrABjT4zRXJ+tQFf3fypmbEPRznr?=
 =?us-ascii?Q?LC1OsB11ehwuP1PVpinBeEUtrQWagcQdwMpauUjITL6QqPXGJNuecxduo7pf?=
 =?us-ascii?Q?YS/uc4cUNTGpkxhU0U7twVCS64oCSjvsHdTjjf9xAzfzarWs/jAQjMOdzQML?=
 =?us-ascii?Q?R0DN6MNuuMhJwAn+87yszdZyAQ/P0Nf6MFhpdKC4ywgPBIWjUYjFiRaCBtp+?=
 =?us-ascii?Q?1gsoHIYUB6pVKoAqJsO0rcZZpAIzXqQOgICpFoe+kI0bQocGhu/tRQDpbXn8?=
 =?us-ascii?Q?bNy2gX1j2uDxrJL7VSJn8gll1e8/SWw8va3nRQMb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eef5c493-b89e-4150-c453-08dc80f0a639
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 21:37:04.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jTHHOgBlAITcUs/e1BU38I/2fC1vYykauS8jVEDM1PP0mjJcvLAx5yt7evXxuLVPEBxcXiDdrCZsllF6bMKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10076
X-Proofpoint-GUID: UK72uyg3oXBox3d4yl8suvyMmP0Bejix
X-Proofpoint-ORIG-GUID: UK72uyg3oXBox3d4yl8suvyMmP0Bejix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405300162

> From an architecture perspicuity, PHY vendor specific registers should be=
 in the PHY register address space. MAC vendor specific registers should be=
 in the MAC register address space.
I agree 100%. The registers I'm talking about are not PHY or MAC specific. =
They are related to other functions. For example, configuring pins to outpu=
t a clock, an SFD indication, a LED, or other.
Some devices also can configure events driven by the PTP timer to toggle GP=
IOs, capture the timer on rising/falling edge of a GPIO or similar.

> It seems like the Microchip device has some PHY vendor specific registers=
 in the MAC address space. That is bad.
I was not aware of that. I can tell you this is not my case.

> Both your and Microchip device is a single piece of silicon. But i doubt =
there is anything in the standard which actually requires this. The PHY cou=
ld be discrete, on the end of an MDIO bus and an MII bus. That is the typic=
al design for the last 30 years, and what linux is built around. The MAC sh=
ould not assume anything about the PHY, the PHY should not assume anything =
about the MAC, because they are interchangeable.
Yes, to me the MAC and PHY must be separate entities even for the OPEN Alli=
ance TC14/6 protocol. Besides, you can stuff whatever PHY within your MACPH=
Y chip (e.g. 10BASE-T1L).
In "my" driver you need to specify in the DTS the kind of net device and th=
e PHY as a handle.

> The framework does allow you to poke any register anywhere. But i would s=
trongly avoid breaking the layering, it is going to cause you long term mai=
ntenance problems, and is ugly.
On that we agree. Maybe I was just misunderstanding the earlier conversatio=
n where I thought you would not allow specific drivers to access MMS other =
than 0,1,4 and the ones that map to MMDs.
If this is not the case, then I think I'm good.

Thanks!
--Pier

