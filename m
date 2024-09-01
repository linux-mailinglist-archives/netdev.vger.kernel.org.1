Return-Path: <netdev+bounces-124013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7059675D8
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5CC1C20D5A
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1000E1442F6;
	Sun,  1 Sep 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="BdTO7Auf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F41F951;
	Sun,  1 Sep 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184438; cv=fail; b=NJI6DlZRAagD/TkNl/cItGaFUYAQKLF/r/pnHMkTPB8u5/dX6pUf8IJ4C9gvd2wt50/wAs35uf/FfHe+kUBryJA04ObuIFKt094aQ3hP0WwAT1+yDWiS7bBFU42/iTq5SAbpEGx6aOqjiCCJJRnvIxTpN1xaKoMpcv3r+7XXjc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184438; c=relaxed/simple;
	bh=RrQE4YkzhbbTzKy4CCENC4j4XE0jDuejlN2LGyHj9mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofaW3jerZ9s9oeUJU5zneGM5eANYCjEqBE7GSFC0v7E0uiCmNu/5AjxIsd2pU8P/aUDm88ta65y06FqDyU8h8HLHGFBbZvQ4ipTVWvcZDs19Gz4O8kRJU5l66XcIs6/hInW5+sHIwvqgrny6Ui9wxKAnvygz7/4RgvCwdyj6OJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=BdTO7Auf; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4818qAv1016765;
	Sun, 1 Sep 2024 02:53:49 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41c2pgt7gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 02:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyQKbqPEFMjgTqEIBU1d/hi304eW/Xr3UdBj33RnW8HdBt86mN/L72kazkMqLJ2LnJIcR7JKnbUuiSmDkn+gJf3MfYrMnKd1uBnGvPAFmHSB7hvz9xK1kd2NF7VzNNp/iO42+qvKc+vcW4SWEdmhhDfQzR0+3RSjguO0BL5kJmWAcdrcsiBuZaSTbleTkZPrNaM080E078fOfut3ve2URm8SZD2tpQKd6V2ceS7sJ98V+Shg/5QfY327gcXDgGU7CvxBNGfUDv778v2ItfOLLoeIXqxBuzFTeSQoirMIsTkzPgRhWCQOaFAkGa6l59M55oNH5Uv6xwlY9ckOzM501Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrQE4YkzhbbTzKy4CCENC4j4XE0jDuejlN2LGyHj9mY=;
 b=vs3+NBL3Eqh3ETmyNHS9z1/FK2kakaFBA0VlgmPZ+LJsLOzloYmJPSK+83w0MOOq0YOQq3NreEwMWPcHbSFzrZhIIWQHqHyhyP9gzMak8pSKrJF/iMFSOCEsaYqfgPPC7H9ucoN53rN1ZP9M9eAN9/Ihva8P0pm3RtEiQalIL/dMp46mINb3qDJn3VSieOFAuynvK3ZqqzLd72LPvUxtisPbNAmasRCWAI3zUNxTRLUcX1PMlNECJA7tAOhhsc4YmVwbT+6WTcDSowVkDjnxWc1YtqAOAC9jo3DNfX8dy2Ys8LWv2juli6bUq3+u4WsRYddnZCQUwB5TYbzmttWQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrQE4YkzhbbTzKy4CCENC4j4XE0jDuejlN2LGyHj9mY=;
 b=BdTO7AufS9Gtv6hkljxJGz/0xeg2EgdSnPqEPuxr4+NmMrzj5h1DctOmAvDh5i0hEYSYgWpUm0G1Duuec8UxAiNEL5/CDELoITxwKGb8X7xAoVDCUZVV9qg9q67GSA/nWQ02IRmed29pEsp9yo+aYVrLcMaXCtdeYp/1mnvhymw=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH8PR18MB5265.namprd18.prod.outlook.com (2603:10b6:510:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 09:53:46 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 09:53:46 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v11 03/11] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v11 03/11] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHa9JYy+yMpOeUPF0ivFXU/HU+UeLIzU6iAgA9sbGA=
Date: Sun, 1 Sep 2024 09:53:46 +0000
Message-ID:
 <CH0PR18MB4339456AF2CB3C89EE327767CD912@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-4-gakula@marvell.com>
 <ZsdJI0nAj5QeVHoM@nanopsycho.orion>
In-Reply-To: <ZsdJI0nAj5QeVHoM@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH8PR18MB5265:EE_
x-ms-office365-filtering-correlation-id: b91befa8-dbd0-4108-5278-08dcca6bf900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG9qRi9NdGJ3U2FSVW1iY1AxdUovSXl0ZzFQRHZENnBhTUNlWnIvSEJoNldI?=
 =?utf-8?B?SVE4eDE4d0YrUFhNQU90d0FMK3kyU2tsL0xzaitVNXhzbG5qKzFuc2JVb3Bw?=
 =?utf-8?B?NjJQTEdZZnljZSttM1k2clh4YXQyMENQT2tGZlRMMjdwNW45RklTckVjaHJ6?=
 =?utf-8?B?UmJkcU5DUkF3cmo0dGdabUVIYnRER1JoYnVZQVNNTmZiL1lWbEJHQXZsbXJQ?=
 =?utf-8?B?MkllSlV3eHk0R1hXbTg2ZktPU2NlclB4cnQ1amprSU1JOHBJa3JZT1JNbXBR?=
 =?utf-8?B?WDV3aWZQTUZjQ2x2Mk5WQXh2NlNCRFI5VFFZdS9iTlBBaWt6cWs5QTZBRFJ5?=
 =?utf-8?B?VUdBVlhQVXJiVzV5MnBHMElBQzBieDBWZ3E4NHVMNmNHalFNaG9FNG9KSHYr?=
 =?utf-8?B?MjAyTUcvWTVGY3lFM0JLMmNrSU9lRGRFMXBndmU5R0pVclYza0NmUkMvaFov?=
 =?utf-8?B?cFk2aklqTHcyTTZVelJSUGVteXZlTmZ0ZjVmcE1ncTBnTmdRMXFWcHJkTVRk?=
 =?utf-8?B?blcwb0ptUEgwdFNhMER1RlZKYk1la2toQUtRVys0SDZRcko2cU9CZU1xOFpo?=
 =?utf-8?B?RkZIMGgyd2JXUVBvM1MreWlvV0pVd2lDT0lSdjZibk5mTER3dTdib256aFp3?=
 =?utf-8?B?ZkdSMjhWa2RKemFSSy9tVnp0Qlo1QVc0TnFrTHNWNFlQRG04QmVYVHFvdUFM?=
 =?utf-8?B?SGZsVk5JQlNRWmx6WFdONURUdFd0c1BiWG1rM21tMjBqNHg1TlBpYkY3K1RU?=
 =?utf-8?B?TDZCR1BDQWF1Z0kwblZXbTF1Vy9KT3JTL0d3SG5nNmRMYWVOaXdYMmJ3N3Yz?=
 =?utf-8?B?QzlFdncrT01hZTZxUUpTL1dpMGpTWUVQRE1NQmVqc1p5Y0tiUGhwdllCWER2?=
 =?utf-8?B?a3k3ZkRpSnQ1ZlBlNUtqbHFhR1FmQ3dFWUl6MFp2TnRNRjNSbzVHUlZ4VjZx?=
 =?utf-8?B?UVJaREVNUUk3Nm1ZUUJRNzJTTFY1L2FqNnZORW4vTU1MY1E3NlF4T0pKQ0lI?=
 =?utf-8?B?RU9kZkZSaGlsSDNEd2JiNUpLN0RKY2dsRkxsTmlkUWVNK1NXUTErY1pGbytl?=
 =?utf-8?B?MHNFZG9ZaThmcGRUa3R1YXlWYlFhN2xmRjJ1cFlhWmRBczVPZjYyT241TGEr?=
 =?utf-8?B?Y3Jhbng2NExJaVpTYlVJMkE0eTBVZjdvK1JqYWs5aHNlWE9XVmJSUEJVbnpo?=
 =?utf-8?B?NmxaT0dWVXFkY0N4UC8yZHdodjB3NGhGTGx3MDk2QXBubGlLWHl0eHdCZjZX?=
 =?utf-8?B?QjkyNWJSSDJQbzFncFNmVm9ZT2x5WG5GL3hJSjR5Y3hPZHJ5M3JqTGxTbnVX?=
 =?utf-8?B?VUZIK0svNGNIK05Tc0J2THcrNHdyRUE3L2RkRVlvSkdpaU1GSDVtNFJta2pO?=
 =?utf-8?B?WnR6dmtMNlJodDJDS2Q2dUNXZjFmd1loTm1vQVdHMjdrTFB1b1o5UjlXOTJW?=
 =?utf-8?B?cUtvbmtZbUtkRUo4T3JacEZvdzRkcVN1eVAyRG1mTlpLS3VjbW1mSWM2M0Ey?=
 =?utf-8?B?QUlBT0V2cG9CTUlCMHhYUWJocW14bk5BaTlPSmczQkVvWVpOM1dVTTNDak1q?=
 =?utf-8?B?OFQzTWlFZjdlemRqVU5xOGI4bGNzeGVaZGZRWXJtY09pL0Z4a08zOFpvdTVH?=
 =?utf-8?B?T0JLM0R6UUx1MUJMWTQ1V01waEVWZ2FvMHpGeVdHRGtVdVBZelNXTThRSDlt?=
 =?utf-8?B?SHlKanN5MkNzbWJGQmlZaUhqSUh4TE1mMHVmY3A3VXdjd1lUa1UvaDBDd3Za?=
 =?utf-8?B?TTNNencrRDdyamN1MWhVeERxRlpoTHIrUTBjV2RFcFJZbFNzdGplZTE2UWE0?=
 =?utf-8?B?Sytkcm82K1hEeTU5eDFhQVF1NEhlektSMCtDVG1Wci8zL3hKVklsRUV3TTFl?=
 =?utf-8?B?MFc1emxsbUtNYytCSnJJNHRRcG9wUmMwWUtoR2xoSXBZdUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWZ0eXRDa3BuaXA1dzJmMmdjZ0cwakp4NE1sWDZGSE5OOTU5bnlzK1BwK01X?=
 =?utf-8?B?ZEFvZ0pTVXorRkVuWXVCQXZBb0tBWFBoWkxCLzEvUWxJekJTSXc4SWNCTEtW?=
 =?utf-8?B?clg5WVJnL1UzZ0xudkNRemdmUTBYQmlpb0FYeDc4Q2p2VGE1bldaSEJUbGt6?=
 =?utf-8?B?b1JlOEFOM0wvTmFBZURZYU9nNjNudEc4cjVBYkt6VHBWeWdjMm95YzBpbWFv?=
 =?utf-8?B?TE5IUHF0TklZa055MUVzSEwwOFViblg4V2FzTkNOb05Cb25iR0NlR0ZLTG5T?=
 =?utf-8?B?VjVPMmVzcTdIekZnWEt5L0dGZmJ0QThlcGFtdXV2TEhpWUJ6cU5GTzVWcFQw?=
 =?utf-8?B?dGNuSjEwSHVHVVA2Q1RHRUZQYU9pQ2JCT1YrUHlHemFGaVVmZnRzL1NSMEIz?=
 =?utf-8?B?NjRYRDdHSDkxWmZ4ODd4UC9UYi9sLzM0RjBVNDh5cE9LdHI0K2N1a0JwOFVL?=
 =?utf-8?B?S1dBbndCQUpieVAyZGp2L3BoZXA1aGthTThVSkF0cE4rQ3lrbkVxb1JneDlp?=
 =?utf-8?B?TFVibkNTQ3hIZUxkdEtucGF5Z0Y1SU1TUnBENnVHWUJaREFIY3IrbExCSWtq?=
 =?utf-8?B?N3diOE5IK1ZyUGxEVGZXSUZYNkY5K2hTdnZDdU5oR0RPelB0Um9UeUpJTURX?=
 =?utf-8?B?THUyTC9Ya0laWkx3eVArUktNdy9MNDIvN2s3SDRJRVNzcTBoRFd4T2UrYS9w?=
 =?utf-8?B?RzN3bUQvSUY0Z0dyNjZWVjBIZVFsVGdMOWZPbGd0NUNmMWZHeHg1NzJZUDVu?=
 =?utf-8?B?cEQzdFhrOUt3TGVQWWQya2orTTNMTU0vY1RmaGJaSjRQeTdCQlVLT3FRbE45?=
 =?utf-8?B?aGJTUTBycE9wV3ZJbmpEZ254MzhjN2RnTmlYWVgwcW1Td2tNbWovdktKL2Uy?=
 =?utf-8?B?SmVPWUhhTmlIV0QwTlVhVW1OaXVQbmlJd05iZmd5VkMvWFQzT3VIRHVIKzA0?=
 =?utf-8?B?VFlSd2ZZSWhONStTWGxRM2JJc21xL09mRXdqOG5XeXhwWk1BUXcvRFFwVXdD?=
 =?utf-8?B?TXRReVdEMFZIQmRNZ0c0VG1Zd0V6cGlIWStpRkMwVmpNOFV6bTZyekI4MU4x?=
 =?utf-8?B?WkFKNWFndEhFN0NNbWZTSzM2Q01ZNU1aUHVLQU5vOGlqNGtLUnBZbWhUSnNy?=
 =?utf-8?B?NEoxSE0zN1dDSUZMaVBNczVyc1c1NWZ4cFZBWFh0aGFqMjRDbWcrZjVyOWpV?=
 =?utf-8?B?WmlycHgwWXRaUDNoT2RSWm90Z0t2Yi96RUlnY3Q4WXhVLzUwT0RGQ29MWWFj?=
 =?utf-8?B?V3lmNEF4NkR6aXNOeUFxRGdkUHkweENyYlJnV1hDYWlNbnZNeXZyY1BUdVk2?=
 =?utf-8?B?Qm02WTlxV2F3QkpBc1ZVcUp4bWh4MkcwNDdhQ3VXMmVMMHBPWVdSVlgzUStW?=
 =?utf-8?B?ekxUdGYzQnRldzNldEhiKzdQZnkwcyt0UWdxZUh1amVJN1BadVFORFhQaGRq?=
 =?utf-8?B?RDZ6WlR0cUl6eGtoOXJIQkNjNFdDSCtSc0gzeG9seUVWK1lnLytJZ1pzb0dF?=
 =?utf-8?B?Zi9NTWZNTDRmaFhxeENZcnY1RG9CaytHK1V4Y0szSUE3MXkvUDc4Vk5TS0lo?=
 =?utf-8?B?TjVpaXBvSE1aeWU4KzU4U1FZc3NFR1Y5ZzQrYWwwRUFuSnR5NG1sU3Q5RHVo?=
 =?utf-8?B?TXRZTXo4S3RiSk1XRmdIaDBCUzRQN0lxc3Q5RVY4c2plalNLSkFDV1NOcUZL?=
 =?utf-8?B?b3ovRWM0dFoyeU5SOXRqQ3llTWtQS3hFQkZkZjlaMlpKcHVPTVloM2xTTGVz?=
 =?utf-8?B?VWJrelJpdU16UzZSVVpCdWRUZjBpT0szbzljcUFFaXZNWjV2eGcwWUU5a3JY?=
 =?utf-8?B?T2FVaExMNVA0Z0pUeWpkaUFlK0NXZWZDdWpLYWdOS2lkcGZwVTh1Z1dzdFk3?=
 =?utf-8?B?Nmk4V215ZzRWVklOa0plai82RnhCS1E4dnN6VDlEbVRsaXFVWHhyTnhaVGR1?=
 =?utf-8?B?UDZkdmlpYjBKMHk0SW5rRFhaSUZueEdqU3pjQnZrYXgyWEVCT1FpWTNOVEFj?=
 =?utf-8?B?QXQ1K21QclZueUo0eUxkOE9QSm9BZG5uZ2I1cjBJcGVCa1F5YVhaMXpqSVc4?=
 =?utf-8?B?Y2k1Wms0T093V3pJSUpQczBER3lnS3E0UmdqS29oc3hIQnorZFE5WlBBOXdN?=
 =?utf-8?Q?F8tOKkyXhKOe7loHwsw/o2y+w?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91befa8-dbd0-4108-5278-08dcca6bf900
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 09:53:46.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbdRg9+HVifmueSa9RxtNb5YytDOOcE8rNEzH01IDJ19vGFXkvOPuPRcDDoeiLFtmDrMzQCwYspDGjj5QWn9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5265
X-Proofpoint-ORIG-GUID: A-d6YytSkCnc2xIy1fG3xjjvYNaCfkj-
X-Proofpoint-GUID: A-d6YytSkCnc2xIy1fG3xjjvYNaCfkj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_04,2024-08-30_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA3OjUwIFBNDQo+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2Vy
bmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBI
YXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW25ldC1uZXh0IFBBVENIIHYxMSAwMy8xMV0gb2N0ZW9udHgyLXBmOiBDcmVhdGUNCj5y
ZXByZXNlbnRvciBuZXRkZXYNCj4NCj5UaHUsIEF1ZyAyMiwgMjAyNCBhdCAwMzoyMDoyM1BNIENF
U1QsIGdha3VsYUBtYXJ2ZWxsLmNvbSB3cm90ZToNCj4+QWRkcyBpbml0aWFsIGRldmxpbmsgc3Vw
cG9ydCB0byBzZXQvZ2V0IHRoZSBzd2l0Y2hkZXYgbW9kZS4NCj4+UmVwcmVzZW50b3IgbmV0ZGV2
cyBhcmUgY3JlYXRlZCBmb3IgZWFjaCBydnUgZGV2aWNlcyB3aGVuIHRoZSBzd2l0Y2gNCj4+bW9k
ZSBpcyBzZXQgdG8gJ3N3aXRjaGRldicuIFRoZXNlIG5ldGRldnMgYXJlIGJlIHVzZWQgdG8gY29u
dHJvbCBhbmQNCj4+Y29uZmlndXJlIFZGcy4NCj4+DQo+PlNpZ25lZC1vZmYtYnk6IEdlZXRoYSBz
b3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPj5SZXZpZXdlZC1ieTogU2ltb24gSG9ybWFu
IDxob3Jtc0BrZXJuZWwub3JnPg0KPj4tLS0NCj4+IC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi5yc3QgICAgICAgICAgICB8ICA1MyArKysrKysNCj4+IC4uLi9tYXJ2ZWxsL29jdGVvbnR4
Mi9uaWMvb3R4Ml9kZXZsaW5rLmMgICAgICB8ICA0OSArKysrKysNCj4+IC4uLi9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL3JlcC5jICB8IDE2NSArKysrKysrKysrKysrKysrKysN
Cj4+IC4uLi9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL3JlcC5oICB8ICAgMyAr
DQo+PiA0IGZpbGVzIGNoYW5nZWQsIDI3MCBpbnNlcnRpb25zKCspDQo+Pg0KPj5kaWZmIC0tZ2l0
DQo+PmEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyLnJzDQo+PnQNCj4+Yi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2
aWNlX2RyaXZlcnMvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIucnMNCj4+dCBpbmRleCAxZTE5
NmNiOWNlMjUuLjExMzJhZTJkMDA3YyAxMDA2NDQNCj4+LS0tDQo+PmEvRG9jdW1lbnRhdGlvbi9u
ZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyLnJzDQo+
PnQNCj4+KysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgNCj4+KysrIDIucnN0DQo+PkBAIC0xNCw2ICsxNCw3IEBAIENv
bnRlbnRzDQo+PiAtIGBCYXNpYyBwYWNrZXQgZmxvd2BfDQo+PiAtIGBEZXZsaW5rIGhlYWx0aCBy
ZXBvcnRlcnNgXw0KPj4gLSBgUXVhbGl0eSBvZiBzZXJ2aWNlYF8NCj4+Ky0gYFJWVSByZXByZXNl
bnRvcnNgXw0KPj4NCj4+IE92ZXJ2aWV3DQo+PiA9PT09PT09PQ0KPj5AQCAtMzQwLDMgKzM0MSw1
NSBAQCBTZXR1cCBIVEIgb2ZmbG9hZA0KPj4gICAgICAgICAjIHRjIGNsYXNzIGFkZCBkZXYgPGlu
dGVyZmFjZT4gcGFyZW50IDE6IGNsYXNzaWQgMToyIGh0YiByYXRlDQo+PjEwR2JpdCBwcmlvIDIg
cXVhbnR1bSAxODg0MTYNCj4+DQo+PiAgICAgICAgICMgdGMgY2xhc3MgYWRkIGRldiA8aW50ZXJm
YWNlPiBwYXJlbnQgMTogY2xhc3NpZCAxOjMgaHRiIHJhdGUNCj4+IDEwR2JpdCBwcmlvIDIgcXVh
bnR1bSAzMjc2OA0KPj4rDQo+PisNCj4+K1JWVSBSZXByZXNlbnRvcnMNCj4+Kz09PT09PT09PT09
PT09PT0NCj4+Kw0KPj4rUlZVIHJlcHJlc2VudG9yIGRyaXZlciBhZGRzIHN1cHBvcnQgZm9yIGNy
ZWF0aW9uIG9mIHJlcHJlc2VudG9yDQo+PitkZXZpY2VzIGZvciBSVlUgUEZzJyBWRnMgaW4gdGhl
IHN5c3RlbS4gUmVwcmVzZW50b3IgZGV2aWNlcyBhcmUNCj4+K2NyZWF0ZWQgd2hlbiB1c2VyIGVu
YWJsZXMgdGhlIHN3aXRjaGRldiBtb2RlLg0KPj4rU3dpdGNoZGV2IG1vZGUgY2FuIGJlIGVuYWJs
ZWQgZWl0aGVyIGJlZm9yZSBvciBhZnRlciBzZXR0aW5nIHVwIFNSSU9WDQo+bnVtVkZzLg0KPj4r
QWxsIHJlcHJlc2VudG9yIGRldmljZXMgc2hhcmUgYSBzaW5nbGUgTklYTEYgYnV0IGVhY2ggaGFz
IGEgZGVkaWNhdGVkDQo+PitxdWV1ZSAoaWUgUlEvU1EuIFJWVSBQRiByZXByZXNlbnRvciBkcml2
ZXIgcmVnaXN0ZXJzIGEgc2VwYXJhdGUgbmV0ZGV2DQo+Pitmb3IgZWFjaCBSUS9TUSBxdWV1ZSBw
YWlyLg0KPj4rDQo+PitIVyBkb2Vzbid0IGhhdmUgYSBpbi1idWlsdCBzd2l0Y2ggd2hpY2ggY2Fu
IGRvIEwyIGxlYXJuaW5nIGFuZCBmb3J3YXJkDQo+Pitwa3RzIGJldHdlZW4gcmVwcmVzZW50ZWUg
YW5kIHJlcHJlc2VudG9yLiBIZW5jZSBwYWNrZXQgcGF0aCBiZXR3ZWVuDQo+PityZXByZXNlbnRl
ZSBhbmQgaXQncyByZXByZXNlbnRvciBpcyBhY2hpZXZlZCBieSBzZXR0aW5nIHVwIGFwcHJvcHJp
YXRlIE5QQw0KPk1DQU0gZmlsdGVycy4NCj4NCj5Jc24ndCB0aGlzIGRvY3VtZW50YXRpb24gcGFy
dCB0YWxraW5nIGFib3V0IGJpdHMgYWRkZWQgaW4gcGF0Y2gNCj4ib2N0ZW9udHgyLWFmOiBBZGQg
cGFja2V0IHBhdGggYmV0d2VlbiByZXByZXNlbnRvciBhbmQgVkYiDQo+PyBJZiB5ZXMsIG1vdmUg
dGhlIGRvY3MgdG8gdGhhdCBwYXRjaC4gUGxlYXNlIG1ha2Ugc3VyZSB5b3UgYWRkIGNvZGUgYWxv
bmdzaWRlDQo+d2l0aCBkb2N1bWVudGF0aW9uLiBPciwgYWx0ZXJuYXRpdmVsbHksIGp1c3QgbGV0
IHRoZSBkb2N1bWVudGF0aW9uIGJlIGFkZGVkIGJ5DQo+c2VwYXJhdGUgYW5kIGxhc3QgcGF0Y2gu
DQo+DQo+Wy4uXQ0KV2lsbCBhZGQgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgZG9jdW1lbnRhdGlvbi4g
DQo=

