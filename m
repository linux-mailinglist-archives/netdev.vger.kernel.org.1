Return-Path: <netdev+bounces-244422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C5CB6ED5
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 19:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D533301E1A3
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B83168EB;
	Thu, 11 Dec 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="X/Bhcd1f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F52319850;
	Thu, 11 Dec 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478469; cv=fail; b=XBoJAJTeDhiuMPRVdpjbqNBNERmw4Bse9hyd5YMMtXofoXLebhW8hO0XdYxNZwFsFQCkVGjr6LT+43hxlAn0SCy6rLu1ab5vUKx0bxHjDFP9E+0GViSsnMgMhq/B/B+BRhLsbG/UIN8i4l4Z2PLW/Y7SfzsouA0j0Pdkq/sG19M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478469; c=relaxed/simple;
	bh=In8Zb6GbyWRk6nCcSngSeYhlmAAcTUPy4OPpYPeC5Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVcQk/8S+p/S08EO0vWRugWvyOyFPHJWBgDmW/3nUGXNrwUNdf79XNP3TLQMV9iDPgeS6BIXfVTrDwIolN11gJifGBQjadI9qZliQBNFLBB836P4Qx+9cOaH7Ixa1TAhcTAMm9PsnM6gb44SOhG5QLEBEMJxqJ+7vjt6ewjkxWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=X/Bhcd1f; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAns141714690;
	Thu, 11 Dec 2025 10:39:32 -0800
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ayjc8agc4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 10:39:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBGzthVPHzz0cMyQytLGLrfuxC2nAj+6DMzIz7NiX5nsL9gw5iXNWBqTPKokUP+H4qCFemm3fEUsyGhdyR5kEVR9Us9Q67IZ9sEIGzFcWLvN2uBJAxBV6wSQ/kY6rrWYj5ybK5fmSjSMRQ6Mlnfkh73xTFmWtUWg84tSdiOAiqLzP3ETz4DmwubZui0fXRA/Cu/1MzTs90RODmZimF5mYE2NiiJGC7vaz2ZDGNmu2iYHe39RKVfcNh+gfVfETOmYCMP+qCUsUkkUdQWPVSdv8l4BkB7N+tVuiq3E0VMrUVR3uXlYlSFZ0Irzlu8gG0g0jUuWBgKwnYWuScoo+SNpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In8Zb6GbyWRk6nCcSngSeYhlmAAcTUPy4OPpYPeC5Sg=;
 b=lanxax+dax1e3bRi71Z2IQNgAinSxf0rwKIHeXouRN+D35R9i751RBzS8YFSSeL/PRgc+d5YF4Ui1qyh1nK+sySrfUDCAmsLtGYFpgoEwgYXTEG720xfMdPa981wd4eocNL9cDC0SZTHRg7uNmO7lRnm0KxiMHdS0Zu5oDjlACCTMxLElm62u/lNsWRp5O+Tp0w9ATLJtDN07BpcJK+xkSa1cauGwtaHwAXu9GjyQxt+oZ2N1MQJeKdicAAPldZ5V2WvWzG3EY4qdc+6moVMdoqolVpZ1bSvUE2Sx+nP+nUj/F0NvlHlztitnro4jKT0R42JShdDp/3VsUGcP725Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In8Zb6GbyWRk6nCcSngSeYhlmAAcTUPy4OPpYPeC5Sg=;
 b=X/Bhcd1f8KXH3AQ5aJsae5nI4ZUjrXIOZI5QsJ6n/R0koyJZjL0dcXtgFfAM+uC9WXQoeL0oDGgJ2yQOsjQCcCEj3YwSxSrGzJnagE+kuewt/FuoC94A3WX5SdM4AlHv/1pCzf8zmo4DiMxeiYs4UD1MiCmRLoEzx7k048uR+vM=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DM4PR18MB5498.namprd18.prod.outlook.com (2603:10b6:8:18e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 18:39:29 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::ad08:c104:6b33:ef04]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::ad08:c104:6b33:ef04%4]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 18:39:28 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Aleksander Jan Bajkowski
	<olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli
	<f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ivan Galkin
	<ivan.galkin@axis.com>, Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Michael Klein <michael@fossekall.de>, Paolo Abeni
	<pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>, Russell King
	<linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [net-next,PATCH v2 3/3] net: phy: realtek: Add property to enable
 SSC
Thread-Topic: [net-next,PATCH v2 3/3] net: phy: realtek: Add property to
 enable SSC
Thread-Index: AQHcas17vqNXpusD90u93GKSYyYAlA==
Date: Thu, 11 Dec 2025 18:39:28 +0000
Message-ID:
 <BY3PR18MB47076A26714A7AC5A34D7F32A0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
 <20251203210857.113328-3-marek.vasut@mailbox.org>
In-Reply-To: <20251203210857.113328-3-marek.vasut@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DM4PR18MB5498:EE_
x-ms-office365-filtering-correlation-id: 4ef9779f-7239-4286-05fc-08de38e49e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHpPREJOcE5kZTZPWUtxcmYzUDB1OThNQU9Ca04ydFdYclVVWTFnckZMaW4w?=
 =?utf-8?B?SEZzbHgwcEQ5N25RU0dyeWpreUwybzFlZGlPSGVNbmlQdG0rczhZSUJoOVpY?=
 =?utf-8?B?UDBqVzhGNkZ1UTB5c0tqWlpnWVllZXcvdHZtUWY5ZkUrcll2eSt6SzhYK0NI?=
 =?utf-8?B?OHVtalA1aTR5M093U2xhNWViQXE2NFl1UitDU2MzMzU4eURqdVJrRjR0QVU2?=
 =?utf-8?B?bGNvaVBkZnFiT1NDZ05QQng4TWRpd241aXd0cGphRUFuK0E3N2N4bXVPRTd6?=
 =?utf-8?B?b1RlS3hybE8zanZBbElUOHdScUJmOXRMQVM3SmxtV0c2WmxURDFlTFJRcnVr?=
 =?utf-8?B?QmRWUGV2NWh3S1JONkY2MStOU21neExIaW8rK0ZRSnFVMlVtd3o2dys2VzBG?=
 =?utf-8?B?SEgwVmhnRTJFaCtnTldGcU1ORmZTZ1ZFQ0NDSmVGdTFhZW5VOWc1c3luSDBM?=
 =?utf-8?B?UEM2ZWNucXd0ekJpRGxlR2ZqdmVFVWg0Yy9yMnlxS0xnU1VYWklFUk83bENu?=
 =?utf-8?B?cklnL3JIZ1JKRmVLbmozNkhlNFVXdjZpVjNJSkJqZmpFeFFRUElyV2RqRWpM?=
 =?utf-8?B?UkhHMGxTa1hUeVNYbHlYcENkTk00ZG9Dc09uWGlZM0xWUDY4eXJPYlhMWXdI?=
 =?utf-8?B?ZlU3MjYwMmh1M1plRi9QN0JXaG9HQmxvbnhCNXd5K3FtT1ZoQnZnUCtqZ1VB?=
 =?utf-8?B?NXpuY2dRVVg0cHZvb1RsR2pYQmxlb0dqMTY4SGpMV0dBdzNLTUdQYlNaZGpY?=
 =?utf-8?B?YjRtWW1ITUczSFZOdDNGeGdDalRhSG1teXNrR3hma2xlRjFWbEdjMS9RZVNS?=
 =?utf-8?B?bDdqZUVpWGY1WWJzUEhLSGkwV1haYnJnZlBMN2s2ZWpGU3JVVWRxRFhOQUdI?=
 =?utf-8?B?djhwMFh3WEgvOWUrVCt1MnNIU0JEb1phcGpGZnl2K0wvMGlhd2JmLzdTTWpp?=
 =?utf-8?B?UnFLWlo3VEs5eit5RGR4OExGcDRQclJBOUNTSmdLMkdhWHpxaE9wS3g5SW9P?=
 =?utf-8?B?Wmxub0xML0ZtSWVuYzVsT2NucDhHR1dCUlRxckh3c0JzMDhFZy9sWE5CL3Ax?=
 =?utf-8?B?eGY5azJ4UzZrTHpUM2k4cHhGdXJqek5Nd1ZnelV2aVNLQ3YzNTBFa2dOTzVM?=
 =?utf-8?B?T3IxRVU1VnBhbVRmM25QTjlvVFBOYk9sR29xMzRERWtyalMzWHhPcUlRMGRt?=
 =?utf-8?B?NWhjWUZiSTVPZEc2cytFQ0x1UE9pWDVzRmgvbzlpLzlpZTFFempKR1BPN1dQ?=
 =?utf-8?B?N0xjcXJCS2ZHVlIwNmRta2t4VVZXK0QwUSt3a0JqaTZGV3VwTVo0aUJnL3Vy?=
 =?utf-8?B?MW1MSTU0c1p0ZVRVRld0RGxXSFJlR2J1ampjQWpnMXZZb2pvOHhnV0Nhb202?=
 =?utf-8?B?SW5pcWo3dXFhNHBQcmNLQzN3RnBlc3VPZTNEdzllQmtqcVNtcTJyM1JBSDhr?=
 =?utf-8?B?UEdjSXUrNDMyc0I1MzlwMlVCMkg3Y0NiN3h6MGFDVHhxVVN2KzVMUzNvYWVh?=
 =?utf-8?B?RVdUa2R0Vm0vU2xqZWJZVTYySUNtVU4yTXdSbWViVHRaem9QMVN2WDRReGZy?=
 =?utf-8?B?Z0JVYjlqSTB1bnVMY1VqTHkrK0JsRFBXOWV0VXVnOEUvdjllNDZhVGdVNkFP?=
 =?utf-8?B?MlRGMTQ4N1V2YTJpaVpGQkY4dG1IZUhqZzlKNjIyS1Iva0VrVFc2RzRiQlBk?=
 =?utf-8?B?bXhXU1BLZW5hdmZ0NEFWNDM5eDFlRzRXTUsvNDNkU0d0bUliSmI0ZEp1b2FZ?=
 =?utf-8?B?WmFwb2ZxdkRTU1hZT3hUOFo2aDV4alMrOTJ6M1VNVXRGdGkxbkROai9NTmtH?=
 =?utf-8?B?VTFYcFBRTTlFUDdNSU5YMEtzN0ROVlFTeFNkZnd4Mmt0c25PSlBoZzJPaWx5?=
 =?utf-8?B?dy9pcVF1T3pyanJ3RTRQVHZ1RXpWTzZndjY1anpRaCtxaFlIcEpvWWRlZERF?=
 =?utf-8?B?UGRBcEdhSnQyWGc1RHVQNU9JU3MzazZEcVlLRk5idDhXY2x5VTJ3b2hXNjVp?=
 =?utf-8?B?eUhHWkNmZXdXZkRITEY3OWtuSmtYMjJSbjVNWWhRc0k4OGZYVStkckhzV1pM?=
 =?utf-8?Q?LhpifA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wk44TE5BbGhZdjBBSlZROXRONmVJenhnQnEyM20wbnJId3JNZ2VTUnlOenhY?=
 =?utf-8?B?MXVvRkFrR2xRSDVoSGZZQnY1OFRVMDRuWVpJVkJiRE9SbkZkd0J2a2FCQXBC?=
 =?utf-8?B?eG84SGp3NGxOUXgySmU0RFM1dkZMcWp1SkVTdGlyc1hCZUJ1bU1zL2pOUUNP?=
 =?utf-8?B?eThrVnd4Y2dYVzVhTVlYcWs1L0JxbmpzWHc1UWRMbVRTeW9PZUdEb2J5NEcx?=
 =?utf-8?B?UFBYTnJXMEIyNlIzSmNwZjBCdU5EcDRPN3M5RUpDcGtTcFQ1NGg0RzNGbkxi?=
 =?utf-8?B?aTRTTkxyd2l4VVo2N3Y1MlBicituZ3lWcy9sTHpEYmh3MTI3RER4R0ZicnFD?=
 =?utf-8?B?RFhoeG1hc0RLbVBpa0FFdDRTWnpORlhuNy9lY0s0VkY2VFZJY1paemlVOWd1?=
 =?utf-8?B?aFZ2ZlNscVVJZ1dPdEg4bkkxeEFQNWMwV3d1ZkFDN01naTdqV1ZDYmFjSFZw?=
 =?utf-8?B?UjYrVEY1U3FGdHRCUDJ2MEFiRlIrZVh5YnZDMFlVRVlqYkhockxXS0JXaHF4?=
 =?utf-8?B?VlV0d1hxMUpGa25xRThTT2p3OUtuMlU5Y1FvN0FsTzIwb2xIZ0Z1WHo2VmJa?=
 =?utf-8?B?eGtmN3BlZHBOYmZKZWJmSzhvN2d3MXZEWmFoYXcyeG1ldHJONkNtbFN4WUUx?=
 =?utf-8?B?akxicytscmdLdEo5MkMydFo2UWk4OU8yS2FMb3BnTy9XZ3VWQ1gzK2h6Ujcx?=
 =?utf-8?B?bXZwRTVvUHJKbCtacG14cmZWUUczZ1o3cFJJS2JFWjBjRGp6N0NPdDJ4c3dw?=
 =?utf-8?B?c2VxQ0JpN0ZLdHFlWG1WQXdEV1M5ek1CdDlLSlZ5RHZPR3F2dGxUaFFWQklp?=
 =?utf-8?B?akpGaU41YzAxZFpaNkI2N1EvendZNnpPWDVWQlNGTk1NYU11OUt3S1h6TmFO?=
 =?utf-8?B?NkhucHlCQzZQZHQ0eVVKQWFLQy81QTQ0c1EvY0lTeVRuanUwQXhZejNNelZO?=
 =?utf-8?B?UEVpeHdBWHlRZ1MwUGQxOEMvM0ErakR4S2xKRzVrS0d3OG9Pd2dJNnkxWi81?=
 =?utf-8?B?OFJ3MzhCdm1KSTJqdjNIMlZONmw4NGtqU1paaCthUTZ1NTcxREhqS1ZXRElK?=
 =?utf-8?B?ZWx4QU8wR2N1bUJsT2FoTlR2dFl2eE1uS2RGVVB2UFc4RGN3Uk5BaDFnd1Fu?=
 =?utf-8?B?RkdFSHd2Ui9tejVnU2tXd3NQSmxZMW1JdHh5ZFh3LzV1OUF6eDNHN1pnREcx?=
 =?utf-8?B?bmtVVTNocm1tQTFSOHErc01kS2VrRE8rK0J2aXZCbGQwckJVRzcrZmVtamw4?=
 =?utf-8?B?SDFqN0lERWpkaklMbHRYcGdYTDBwYlV0RTg4QlVkTFNQWXdUWWVBRkZ3Z0VF?=
 =?utf-8?B?UDMzcUxTYkVLN20vTE1EMWVjeDVQOEZtV2Y5WUd3M0s0bFNoSXo1NXNNa0R3?=
 =?utf-8?B?OFFMNk80aC9SQ2g0N3pqR25kbVF5LzNpb1ZaT3BCWXJxMlpTc0V2TFRoWFpp?=
 =?utf-8?B?SW0rbzZLTmR0QzJ5TWxSZVlJSXdKNm50TUJuSWNIbDA5aWdoNXNqbHRMbzds?=
 =?utf-8?B?SWZaZHU5czZyYVcvM1VMeEptUUtJbzlvQnlQdlpJdkFLNlErVkdLL1JTbTYw?=
 =?utf-8?B?WVRVL1EzQXNZQlducXNMQUMzVDlleU9MZmgvd29vc0pBMU1lK2d6NTZ6OGVI?=
 =?utf-8?B?dENlNUVvT0VyRXY3SEc3VmJ2eEZIVDNvZ29HTHJYaTNjcmYrRHhETlp3M1ZZ?=
 =?utf-8?B?eFBDSTJlcnl5QitTWXQvNS9wYUNqK1NVWG0rLysydnFsamY3QjhUNlVWT3h0?=
 =?utf-8?B?N3FJTk9OV0ZYanNDVldiWGhLNE0xSDI2Z1J0TWYzelJOYmVXR0tGZVFmTnFk?=
 =?utf-8?B?ZjVzZDFKZlVmU1VYWHRWeThsUDRrZGE0OWtYbngvQ0p2SDdUamJXSmgrVE0r?=
 =?utf-8?B?WCs2MzlxNHFZYXFKTkQ4TTRWM3NYY1ZSZG52Q0V3STlDTjUzU1MwaitFN3Vm?=
 =?utf-8?B?M0lKRGowSzdwUVRCcjZVVmNkWTM0RzN2SGZnM2MwSW1MQ2YvVE13aVYvZFFQ?=
 =?utf-8?B?bFpaNm9XdGFDU0hrYUplaUtmV2dDS0s3K0MvQS9NbytoSVpyNHRHV2NyVW5i?=
 =?utf-8?B?KzRNdW0rOTFEWGJHR1hvTjdycGFuTmU2dy8xMndQaHQ0dmx4ZWNIR0VON1Ft?=
 =?utf-8?B?VUszMngwV1FiREJIL2RtYytleUQyZjNrb3I2dVN1cG80b2RmNmQwc3owdlRj?=
 =?utf-8?Q?Mpsp7TBW5/5+5jw6J3DJMWebpwZ4u6x3+Czgdnp/HkB+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef9779f-7239-4286-05fc-08de38e49e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 18:39:28.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH1ZZmmBgzo5at25ZMuPU7D56SNfrKCb2e0tuH6aX0UHlRpQ18iP8pRtSaCK1577Ul8HofWga6s/QI7b8Wptew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5498
X-Proofpoint-ORIG-GUID: YSDLkcqxZaW5XZFXS-euesCPjdh_MsZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE0OSBTYWx0ZWRfXw5Rj8pe6p613
 aJNDOO2EnKUcrosUK9aJiBXBMeOr/2KzpO2bK2/1OFrLsC0NzRr7Fj3CWAkvn+dAIXSXQTQdNOu
 RAnjNnmYKON3oje6HirFdfAgo5BH38AoBBGSDuXs/5kfja93jPL+HKzb8lXiRJ5Bu+6BwI4KLQB
 MV3D0ppPT2z1/v7Ox5WKJ7+HisoIocz5Yd0SemrFg+jbXEsCysVvkEtKWx9IFHnJy5CF55dBavz
 b1VpntMCy5nMMBup/8IND0cSqqNM8TyrN+tyrsLRQGTbP5MZjAUFvWey/8SnWarHAn8wMElR/Rw
 GifFSD8kaOSiR+0PVf0PYuLT/hne5NhPY5ammi8eEDfAVkbc0wgwON2qtpCDFZDJN2lPgx7jt+E
 tvdG9N0DWYLU48pelKAFi+V8aAVDdg==
X-Proofpoint-GUID: YSDLkcqxZaW5XZFXS-euesCPjdh_MsZk
X-Authority-Analysis: v=2.4 cv=a+c9NESF c=1 sm=1 tr=0 ts=693b0fe4 cx=c_pps
 a=Oahh2kgEN5ymB8sO0SiNEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=b3CbU_ItAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=pGLkceISAAAA:8 a=3-RhneuVAAAA:8 a=20KFwNOVAAAA:8 a=PHq6YzTAAAAA:8
 a=8AirrxEcAAAA:8 a=V-JLjH9PmMcRRIdnLigA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=VLVLkjT_5ZicWzSuYqSo:22
 a=ZKzU8r6zoKMcqsNulkmm:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgNCwgMjAy
NSAyOjM4IEFNDQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNYXJlayBWYXN1
dCA8bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRh
dmVtbG9mdC5uZXQ+OyBBbGVrc2FuZGVyIEphbiBCYWprb3dza2kgPG9sZWsyQHdwLnBsPjsgQW5k
cmV3DQo+IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJu
ZWwub3JnPjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgRmxvcmlhbiBG
YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+Ow0KPiBIZWluZXIgS2FsbHdlaXQgPGhrYWxs
d2VpdDFAZ21haWwuY29tPjsgSXZhbiBHYWxraW4NCj4gPGl2YW4uZ2Fsa2luQGF4aXMuY29tPjsg
SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBLb3psb3dza2kg
PGtyemsrZHRAa2VybmVsLm9yZz47IE1pY2hhZWwgS2xlaW4gPG1pY2hhZWxAZm9zc2VrYWxsLmRl
PjsNCj4gUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz47IFJ1c3NlbGwNCj4gS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPjsgVmxh
ZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtuZXQtbmV4dCxQQVRDSCB2MiAzLzNdIG5ldDogcGh5
OiByZWFsdGVrOiBBZGQgcHJvcGVydHkNCj4gdG8gZW5hYmxlIFNTQw0KPiANCj4gQWRkIHN1cHBv
cnQgZm9yIHNwcmVhZCBzcGVjdHJ1bSBjbG9ja2luZyAoU1NDKSBvbiBSVEw4MjExRihEKShJKS1D
RywNCj4gUlRMODIxMUZTKEkpKC1WUyktQ0csIFJUTDgyMTFGRyhJKSgtVlMpLUNHIFBIWXMuIFRo
ZSBpbXBsZW1lbnRhdGlvbg0KPiBmb2xsb3dzIEVNSSBpbXByb3ZlbWVudCBhcHBsaWNhdGlvbiBu
b3RlIFJldi4gMS7igIoyIGZvciB0aGVzZSBQSFlzLiBUaGUNCj4gY3VycmVudCBpbXBsZW1lbnRh
dGlvbiBlbmFibGVzIFNTQyANCj4gQWRkIHN1cHBvcnQgZm9yIHNwcmVhZCBzcGVjdHJ1bSBjbG9j
a2luZyAoU1NDKSBvbiBSVEw4MjExRihEKShJKS1DRywNCj4gUlRMODIxMUZTKEkpKC1WUyktQ0cs
IFJUTDgyMTFGRyhJKSgtVlMpLUNHIFBIWXMuIFRoZSBpbXBsZW1lbnRhdGlvbg0KPiBmb2xsb3dz
IEVNSSBpbXByb3ZlbWVudCBhcHBsaWNhdGlvbiBub3RlIFJldi4gMS4yIGZvciB0aGVzZSBQSFlz
Lg0KPiANCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZW5hYmxlcyBTU0MgZm9yIGJvdGgg
UlhDIGFuZCBTWVNDTEsgY2xvY2sNCj4gc2lnbmFscy4gSW50cm9kdWNlIERUIHByb3BlcnRpZXMg
J3JlYWx0ZWssY2xrb3V0LXNzYy1lbmFibGUnLCAncmVhbHRlayxyeGMtc3NjLQ0KPiBlbmFibGUn
IGFuZCAncmVhbHRlayxzeXNjbGstc3NjLWVuYWJsZScgd2hpY2ggY29udHJvbCBDTEtPVVQsIFJY
QyBhbmQgU1lTQ0xLDQo+IFNTQyBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcgZW5hYmxlbWVudCBv
biB0aGVzZSBzaWduYWxzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiAtLS0NCj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZl
bUBkYXZlbWxvZnQubmV0Pg0KPiBDYzogQWxla3NhbmRlciBKYW4gQmFqa293c2tpIDxvbGVrMkB3
cC5wbD4NCj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gQ2M6IENvbm9yIERv
b2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4gQ2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRA
Z29vZ2xlLmNvbT4NCj4gQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29t
Pg0KPiBDYzogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4NCj4gQ2M6IEl2
YW4gR2Fsa2luIDxpdmFuLmdhbGtpbkBheGlzLmNvbT4NCj4gQ2M6IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5l
bC5vcmc+DQo+IENjOiBNaWNoYWVsIEtsZWluIDxtaWNoYWVsQGZvc3Nla2FsbC5kZT4NCj4gQ2M6
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IENjOiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4N
Cj4gQ2M6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQo+IENjOiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0K
PiAtLS0NCj4gVjI6IFNwbGl0IFNTQyBjbG9jayBjb250cm9sIGZvciBlYWNoIENMS09VVCwgUlhD
LCBTWVNDTEsgc2lnbmFsDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRl
a19tYWluLmMgfCAxMjQgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5
L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFs
dGVrX21haW4uYw0KPiBpbmRleCA2N2VjZjNkNGFmMmIxLi5hYzgwNjUzY2RiZTI4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYw0KPiArKysgYi9k
cml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYw0KPiBAQCAtNzQsMTEgKzc0LDE5
IEBADQo+IA0KPiAgI2RlZmluZSBSVEw4MjExRl9QSFlDUjIJCQkJMHgxOQ0KPiAgI2RlZmluZSBS
VEw4MjExRl9DTEtPVVRfRU4JCQlCSVQoMCkNCj4gKyNkZWZpbmUgUlRMODIxMUZfU1lTQ0xLX1NT
Q19FTgkJCUJJVCgzKQ0KPiAgI2RlZmluZSBSVEw4MjExRl9QSFlDUjJfUEhZX0VFRV9FTkFCTEUJ
CUJJVCg1KQ0KPiArI2RlZmluZSBSVEw4MjExRl9DTEtPVVRfU1NDX0VOCQkJQklUKDcpDQo+IA0K
PiAgI2RlZmluZSBSVEw4MjExRl9JTlNSX1BBR0UJCQkweGE0Mw0KPiAgI2RlZmluZSBSVEw4MjEx
Rl9JTlNSCQkJCTB4MWQNCj4gDQo+ICsvKiBSVEw4MjExRiBTU0Mgc2V0dGluZ3MgKi8NCj4gKyNk
ZWZpbmUgUlRMODIxMUZfU1NDX1BBR0UJCQkweGM0NA0KPiArI2RlZmluZSBSVEw4MjExRl9TU0Nf
UlhDCQkJMHgxMw0KPiArI2RlZmluZSBSVEw4MjExRl9TU0NfU1lTQ0xLCQkJMHgxNw0KPiArI2Rl
ZmluZSBSVEw4MjExRl9TU0NfQ0xLT1VUCQkJMHgxOQ0KPiArDQo+ICAvKiBSVEw4MjExRiBMRUQg
Y29uZmlndXJhdGlvbiAqLw0KPiAgI2RlZmluZSBSVEw4MjExRl9MRURDUl9QQUdFCQkJMHhkMDQN
Cj4gICNkZWZpbmUgUlRMODIxMUZfTEVEQ1IJCQkJMHgxMA0KPiBAQCAtMjAzLDYgKzIxMSw5IEBA
IE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsgIHN0cnVjdCBydGw4MjF4X3ByaXYgew0KPiAgCWJvb2wg
ZW5hYmxlX2FsZHBzOw0KPiAgCWJvb2wgZGlzYWJsZV9jbGtfb3V0Ow0KPiArCWJvb2wgZW5hYmxl
X2Nsa291dF9zc2M7DQo+ICsJYm9vbCBlbmFibGVfcnhjX3NzYzsNCj4gKwlib29sIGVuYWJsZV9z
eXNjbGtfc3NjOw0KPiAgCXN0cnVjdCBjbGsgKmNsazsNCj4gIAkvKiBydGw4MjExZiAqLw0KPiAg
CXUxNiBpbmVyOw0KPiBAQCAtMjY2LDYgKzI3NywxMiBAQCBzdGF0aWMgaW50IHJ0bDgyMXhfcHJv
YmUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gIAkJCQkJCSAgICJyZWFsdGVrLGFsZHBz
LWVuYWJsZSIpOw0KPiAgCXByaXYtPmRpc2FibGVfY2xrX291dCA9IG9mX3Byb3BlcnR5X3JlYWRf
Ym9vbChkZXYtPm9mX25vZGUsDQo+ICAJCQkJCQkgICAgICAicmVhbHRlayxjbGtvdXQtZGlzYWJs
ZSIpOw0KPiArCXByaXYtPmVuYWJsZV9jbGtvdXRfc3NjID0gb2ZfcHJvcGVydHlfcmVhZF9ib29s
KGRldi0+b2Zfbm9kZSwNCj4gKwkJCQkJCQkicmVhbHRlayxjbGtvdXQtc3NjLQ0KPiBlbmFibGUi
KTsNCj4gKwlwcml2LT5lbmFibGVfcnhjX3NzYyA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYt
Pm9mX25vZGUsDQo+ICsJCQkJCQkgICAgICJyZWFsdGVrLHJ4Yy1zc2MtZW5hYmxlIik7DQo+ICsJ
cHJpdi0+ZW5hYmxlX3N5c2Nsa19zc2MgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LT5vZl9u
b2RlLA0KPiArCQkJCQkJCSJyZWFsdGVrLHN5c2Nsay1zc2MtDQo+IGVuYWJsZSIpOw0KPiANCj4g
IAlwaHlkZXYtPnByaXYgPSBwcml2Ow0KPiANCj4gQEAgLTcwMCw2ICs3MTcsMTAxIEBAIHN0YXRp
YyBpbnQgcnRsODIxMWZfY29uZmlnX3BoeV9lZWUoc3RydWN0DQo+IHBoeV9kZXZpY2UgKnBoeWRl
dikNCj4gIAkJCQlSVEw4MjExRl9QSFlDUjJfUEhZX0VFRV9FTkFCTEUsIDApOyAgfQ0KPiANCj4g
K3N0YXRpYyBpbnQgcnRsODIxMWZfY29uZmlnX2Nsa291dF9zc2Moc3RydWN0IHBoeV9kZXZpY2Ug
KnBoeWRldikgew0KPiArCXN0cnVjdCBydGw4MjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7
DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQo+ICsJaW50IHJl
dDsNCj4gKw0KPiArCS8qIFRoZSB2YWx1ZSBpcyBwcmVzZXJ2ZWQgaWYgdGhlIGRldmljZSB0cmVl
IHByb3BlcnR5IGlzIGFic2VudCAqLw0KPiArCWlmICghcHJpdi0+ZW5hYmxlX2Nsa291dF9zc2Mp
DQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJLyogUlRMODIxMUZWRCBoYXMgbm8gUEhZQ1IyIHJl
Z2lzdGVyICovDQo+ICsJaWYgKHBoeWRldi0+ZHJ2LT5waHlfaWQgPT0gUlRMXzgyMTFGVkRfUEhZ
SUQpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJLyogVW5uYW1lZCByZWdpc3RlcnMgZnJvbSBF
TUkgaW1wcm92ZW1lbnQgcGFyYW1ldGVycyBhcHBsaWNhdGlvbg0KPiBub3RlIDEuMiAqLw0KPiAr
CXJldCA9IHBoeV93cml0ZV9wYWdlZChwaHlkZXYsIDB4ZDA5LCAweDEwLCAweGNmMDApOw0KPiAr
CWlmIChyZXQgPCAwKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiQ0xLT1VUIFNDQyBpbml0aWFsaXph
dGlvbiBmYWlsZWQ6ICVwZVxuIiwNCj4gRVJSX1BUUihyZXQpKTsNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBwaHlfd3JpdGVfcGFnZWQocGh5ZGV2LCBSVEw4MjExRl9T
U0NfUEFHRSwNCj4gUlRMODIxMUZfU1NDX0NMS09VVCwgMHgzOGMzKTsNCj4gKwlpZiAocmV0IDwg
MCkgew0KPiArCQlkZXZfZXJyKGRldiwgIkNMS09VVCBTQ0MgY29uZmlndXJhdGlvbiBmYWlsZWQ6
ICVwZVxuIiwNCj4gRVJSX1BUUihyZXQpKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsN
Cj4gKwkvKg0KPiArCSAqIEVuYWJsZSBDTEtPVVQgU1NDIHVzaW5nIFBIWUNSMiBiaXQgNyAsIHRo
aXMgc3RlcCBpcyBtaXNzaW5nIGZyb20NCj4gdGhlDQo+ICsJICogRU1JIGltcHJvdmVtZW50IHBh
cmFtZXRlcnMgYXBwbGljYXRpb24gbm90ZSAxLjIgc2VjdGlvbiAyLjMNCj4gKwkgKi8NCj4gKwly
ZXQgPSBwaHlfbW9kaWZ5X3BhZ2VkKHBoeWRldiwgUlRMODIxMUZfUEhZQ1JfUEFHRSwNCj4gUlRM
ODIxMUZfUEhZQ1IyLA0KPiArCQkJICAgICAgIFJUTDgyMTFGX0NMS09VVF9TU0NfRU4sDQo+IFJU
TDgyMTFGX0NMS09VVF9TU0NfRU4pOw0KPiArCWlmIChyZXQgPCAwKSB7DQo+ICsJCWRldl9lcnIo
ZGV2LCAiQ0xLT1VUIFNDQyBlbmFibGUgZmFpbGVkOiAlcGVcbiIsDQo+IEVSUl9QVFIocmV0KSk7
DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgcnRsODIxMWZfY29uZmlnX3J4Y19zc2Moc3RydWN0IHBoeV9kZXZpY2Ug
KnBoeWRldikgew0KPiArCXN0cnVjdCBydGw4MjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7
DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQo+ICsJaW50IHJl
dDsNCj4gKw0KPiArCS8qIFRoZSB2YWx1ZSBpcyBwcmVzZXJ2ZWQgaWYgdGhlIGRldmljZSB0cmVl
IHByb3BlcnR5IGlzIGFic2VudCAqLw0KPiArCWlmICghcHJpdi0+ZW5hYmxlX3J4Y19zc2MpDQo+
ICsJCXJldHVybiAwOw0KPiArDQo+ICsJLyogUlRMODIxMUZWRCBoYXMgbm8gUEhZQ1IyIHJlZ2lz
dGVyICovDQo+ICsJaWYgKHBoeWRldi0+ZHJ2LT5waHlfaWQgPT0gUlRMXzgyMTFGVkRfUEhZSUQp
DQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJcmV0ID0gcGh5X3dyaXRlX3BhZ2VkKHBoeWRldiwg
UlRMODIxMUZfU1NDX1BBR0UsDQo+IFJUTDgyMTFGX1NTQ19SWEMsIDB4NWYwMCk7DQo+ICsJaWYg
KHJldCA8IDApIHsNCj4gKwkJZGV2X2VycihkZXYsICJSWEMgU0NDIGNvbmZpZ3VyYXRpb24gZmFp
bGVkOiAlcGVcbiIsDQo+IEVSUl9QVFIocmV0KSk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0K
PiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgcnRsODIxMWZfY29u
ZmlnX3N5c2Nsa19zc2Moc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikgew0KDQpNaW5vciBuaXQ6
ICAgS2VybmVsIHN0eWxlIHJlcXVpcmVzIHRoZSBvcGVuaW5nIGJyYWNlIG9uIHRoZSBuZXh0IGxp
bmUsIGFsc28gaW4gb3RoZXIgcGxhY2VzLg0Kc3RhdGljIGludCBydGw4MjExZl9jb25maWdfc3lz
Y2xrX3NzYyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KSANCnsNCg0KPiArCXN0cnVjdCBydGw4
MjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0g
JnBoeWRldi0+bWRpby5kZXY7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCS8qIFRoZSB2YWx1ZSBp
cyBwcmVzZXJ2ZWQgaWYgdGhlIGRldmljZSB0cmVlIHByb3BlcnR5IGlzIGFic2VudCAqLw0KPiAr
CWlmICghcHJpdi0+ZW5hYmxlX3N5c2Nsa19zc2MpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJ
LyogUlRMODIxMUZWRCBoYXMgbm8gUEhZQ1IyIHJlZ2lzdGVyICovDQo+ICsJaWYgKHBoeWRldi0+
ZHJ2LT5waHlfaWQgPT0gUlRMXzgyMTFGVkRfUEhZSUQpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+
ICsJcmV0ID0gcGh5X3dyaXRlX3BhZ2VkKHBoeWRldiwgUlRMODIxMUZfU1NDX1BBR0UsDQo+IFJU
TDgyMTFGX1NTQ19TWVNDTEssIDB4NGYwMCk7DQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJZGV2
X2VycihkZXYsICJTWVNDTEsgU0NDIGNvbmZpZ3VyYXRpb24gZmFpbGVkOiAlcGVcbiIsDQo+IEVS
Ul9QVFIocmV0KSk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJLyogRW5hYmxl
IFNTQyAqLw0KPiArCXJldCA9IHBoeV9tb2RpZnlfcGFnZWQocGh5ZGV2LCBSVEw4MjExRl9QSFlD
Ul9QQUdFLA0KPiBSVEw4MjExRl9QSFlDUjIsDQo+ICsJCQkgICAgICAgUlRMODIxMUZfU1lTQ0xL
X1NTQ19FTiwNCj4gUlRMODIxMUZfU1lTQ0xLX1NTQ19FTik7DQo+ICsJaWYgKHJldCA8IDApIHsN
Cj4gKwkJZGV2X2VycihkZXYsICJTWVNDTEsgU0NDIGVuYWJsZSBmYWlsZWQ6ICVwZVxuIiwNCj4g
RVJSX1BUUihyZXQpKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBydGw4MjExZl9jb25maWdfaW5pdChzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2KSAgew0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwaHlkZXYt
Pm1kaW8uZGV2OyBAQCAtNzIzLDYgKzgzNSwxOCBAQA0KPiBzdGF0aWMgaW50IHJ0bDgyMTFmX2Nv
bmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ICAJCXJldHVybiByZXQ7DQo+
ICAJfQ0KPiANCj4gKwlyZXQgPSBydGw4MjExZl9jb25maWdfY2xrb3V0X3NzYyhwaHlkZXYpOw0K
PiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlyZXQgPSBydGw4MjExZl9j
b25maWdfcnhjX3NzYyhwaHlkZXYpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+
ICsNCj4gKwlyZXQgPSBydGw4MjExZl9jb25maWdfc3lzY2xrX3NzYyhwaHlkZXYpOw0KPiArCWlm
IChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gIAlyZXR1cm4gcnRsODIxMWZfY29uZmln
X3BoeV9lZWUocGh5ZGV2KTsgIH0NCj4gDQo+IC0tDQo+IDIuNTEuMA0KPiANCg0K

