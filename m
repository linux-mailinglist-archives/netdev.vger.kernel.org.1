Return-Path: <netdev+bounces-169301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BBA434E8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 07:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B259189C3E0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A51254B18;
	Tue, 25 Feb 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mVNI6t79"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17144254875;
	Tue, 25 Feb 2025 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463590; cv=fail; b=I9i8yz5kbaR+icHBqBwPA8u0GpRxHr2grV4RCghI+7humx9k5LcItgUq6kij43K7Gr/3DL1W00jYIHiKFdCsI2DSNAnGVWlKwREnXY+s2AArFxf9AGHCMRsMIv1KghUVo0jDus4KhAPy0LYshD+ivrVCf0yTXYPNKxaNux7rfaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463590; c=relaxed/simple;
	bh=PLJZKy5zOhP6NUsPxAPYYDgCrmIFRquYmuoqGbwYICQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lCUun2tjO1aATKopUaRgTrEwEmHCa8s3+7VS1H6U0KIPNLSah9iTKpJs+Yz6OOuZwBpMi04s3Z7zGKvtMYs0pucJV9v8/08XUA1vNLFEvfqnsodYhAhqfRcvN9qIAYqhWJeyix7x5wpLPagTyZhBRfm0sU1aBzh5ZHGFYmXa4bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mVNI6t79; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ONUwHX005162;
	Mon, 24 Feb 2025 22:06:01 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4512gh8ra6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 22:06:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvjOB/wAXi5BCS1Hk9X7zsUogrSdsKcmSmeIIt+I8ZGN1VoKRYCc0HC3Hla5Ccr/bM/N80yRpUWpbpNTrm312RDiToBvzaBBsm/abL/uS5EviI5VmOVLih/Fg5rUix0JSuY8vo3dZOIUDmD+G64LtzLXy1nOBA49XRlP8TyGvd6gapwcPEP9i9TQ30BPkqGtdJ7HzVEjY9bDbC5NSRZTlJsIBeOTh1Rf3OeMRLl9jBNbCU+r7XhWM7nEThXRSLrfO6uah+ez4wA5Jkv0QC9Cx1pR45qagb9S90pAtGHUvzw22+gVtM6J3dcEQyNSr8r6ThGSv+HjgCfJJgmlbOFCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLJZKy5zOhP6NUsPxAPYYDgCrmIFRquYmuoqGbwYICQ=;
 b=d7MZTJ7ZVsAYakUAsvZSVxBQL0Z48K0fqO074qeB3kBNBf5eX9X4oYJPxYP5r+HanfTZtoUPMSxDe+Ji0ahrMbpGXyVPI00N4lb7VEGFvInYLJZhXLZ4on6NiwTfsz/pvL/cFuIPfUUxdqRIkp4pzOKjwy7uRlivsTqZGxOOC9mItz2iyU5XKaje5Cw1yWbbOzMTGb1fowxWGguT1JECrrChdKlpVA9pjmjrQoJYeNPRVu6QlxBK1EAtakGhM7DYqZTZoqQRqzxABdWtwmwek+0MLCCQ411WM1ejaTlFMbtB/xx68fCE/8pGx14SU5PGAY53CveKCxsOa3s08nIhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLJZKy5zOhP6NUsPxAPYYDgCrmIFRquYmuoqGbwYICQ=;
 b=mVNI6t79VU+DIXXNRSyNj4wxCJGTMwU+P6dYbR0zesmmMU83NNhBhvn57GE3YcqEmXHqWQ0OICWdp32aZwjCzL5K+z/T8VBoawB2DuuXxCKEmtAxmWB6Lbm0XyCADUDlwonH3MH7a+po272MuY7UWX4GPh7lkjNF7Ierpvvu3xk=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by MN0PR18MB6013.namprd18.prod.outlook.com (2603:10b6:208:4bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:05:57 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 06:05:57 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v10 2/6] octeontx2-af: CN20k basic mbox
 operations and structures
Thread-Topic: [net-next PATCH v10 2/6] octeontx2-af: CN20k basic mbox
 operations and structures
Thread-Index: AQHbh0tW2txFP3w/hkKf+GAvXYfIJg==
Date: Tue, 25 Feb 2025 06:05:57 +0000
Message-ID:
 <BY3PR18MB4707CCD4F93834C9408DAD64A0C32@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-3-saikrishnag@marvell.com>
 <a0f4651c-31a3-4831-89a4-ee3010b3b4ca@redhat.com>
In-Reply-To: <a0f4651c-31a3-4831-89a4-ee3010b3b4ca@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|MN0PR18MB6013:EE_
x-ms-office365-filtering-correlation-id: d68ad3a3-5ef9-4e46-4ca6-08dd55627896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDlzaEdHOG1DME1FTm1EemdGbnkzTCtPb2xYZndnbFhuU0wrYzRQQVMxZlU2?=
 =?utf-8?B?VHdHRWRaT0JMS3lCdlZvdUZMMFJNYkUzOEt4emxaUDAxc2pQSjNCc0t2eDA5?=
 =?utf-8?B?UW9CdHd4eHgrQ01Wa2hMTHFZWTZpY2x3Vy9Lb3dDOFpnMDhla2QwWktnTnZF?=
 =?utf-8?B?cEV1ZGttQ1RSTVc4TWs4ejJBUXJyaTgvcjZhNEV0Q3BKSnNRUkZkOXVvR3hQ?=
 =?utf-8?B?VHVDeVF5bVNpUG9LQlBFa0xwcE82WDJMK2dva1dZVWlkUHpmc1A2MUk2Wmhi?=
 =?utf-8?B?TzVYODdsL24ybHMwQk02OEJKSVJNcjBCMkhjVThSR2orMzAzKzNQWTRBVmx5?=
 =?utf-8?B?RGVISk1yd2JLbUEwcm5zSnNEQWQ2bXQwVmRqV3pxekVDRUgxbWczejQxVExl?=
 =?utf-8?B?Q1l2NTQ2VEdtTy9Dakl1UGdzcTF1MHhFR1J4YjlNNHZ5bzlMcWlhVlptTjlj?=
 =?utf-8?B?RlpKZENMa0xma0gwNGZzK24rZzh5V0JtNU1vbVlHUk1BdDhFNC94WDFlR0Iz?=
 =?utf-8?B?Q2RCRDJVcVdXRmFzTEZGcjNNb2wzTDdYWDBJZ01XQVhWaU5mTFB6K0RXTUxH?=
 =?utf-8?B?SFVtVFYwYTl6MUQzSmFGMkplaUs3cDZZT3JSQnROM2Zvb1U4N0x6VzhzcG1q?=
 =?utf-8?B?MUxkM28wa0NBMFRIbTBlRUdsQmdzL0JMblZVd0ZuTnhrRWxtT0x2Ui9KbUFJ?=
 =?utf-8?B?VFVXVWduT2VVTXdiRk96aTdYZVNWL2t0ZEVtU3hOV0paR3RIOWpHZEdNZTdZ?=
 =?utf-8?B?SzRLaEhqcWJNYTF3eCtLbjNXREI1NTRib3VRM3AxWElKeGNxYW5ZM0Z1cTha?=
 =?utf-8?B?bFNTSFpOTk1HRTVJbkh5cERKOXF3eXJ4T1NtRWxnb0NpK1ZCRit2VGFTWEgv?=
 =?utf-8?B?azZyeFU5bE5iVXpTR2EzT3M0aVNVWGxMSElBRS9lRHp5YThlcncra3J5cElE?=
 =?utf-8?B?SzZtbEpFMGFIQllrN0dWbm8rTjF3SmZwNXRUZ1hGbGRwN1JKN2VFQjZ6YXVv?=
 =?utf-8?B?V2pRTVFxTXVTUGVPK0c0UHQwR2lXTzBrc2FDWGVqYzJNdW40TVBvd3pXRjkw?=
 =?utf-8?B?WTN4bE5jUlpBMXpsRHVybnFpSjBnbExuSFhmbXlYTk13Y3p2WHYxTlJ4Snp5?=
 =?utf-8?B?Q295Z3VlV29mMldBcUx4WGV0cSs0YTQrWkJxWUtWZys5c0Nld0hDWEZPWWZt?=
 =?utf-8?B?eEkybHorL0VVOXovRHBORHUvOG5sOHFudjljZWg3T2tYNVBHZ3FBcXdhdk1O?=
 =?utf-8?B?dHZXOXhkM2FyVk1zMDdXYXlzeE9CUk56VjlHU3ZQRU9rVCtFK1BNMFZqaFNa?=
 =?utf-8?B?b0dFcVJqQ3RzOTRnL3dCNGVweENrcWhGRUxBajlxK3JZMFhYQWtEQ2pMQyty?=
 =?utf-8?B?S1Z4QVc0MzVtOG51ekxjMEdVald2UzVUSHQ5M0pOZnliL203WDcxc2wwS0dX?=
 =?utf-8?B?K1lYQ04yUXJxcmJDUklUaGhVNVVtVGtKaFZCTXVPTFRZWE9QOW1wL1dwejlh?=
 =?utf-8?B?TlZqZzBPd1ZHWEtlMkh2Q2ZzbzFBWEJ6cGNrZUFyUFV5cGpEbk9wYzZTTFVR?=
 =?utf-8?B?L2Y2bmp6ZG1ocG91WW1RbjlNTHJLdUlRUllkempZdGhnNWZGNlV2YkZ2WEM0?=
 =?utf-8?B?ZFFGMXloVWdzWE5FaWJKNUNZbXBiOG9LSGhyMmJyT2o0MlZSQy9xVnBsOE1s?=
 =?utf-8?B?SEt1RFFyZmNGZ3pMZVV1dURKVDdsU3FHWlJDTFI4ZEs2S2k3aE5URWhCQS9m?=
 =?utf-8?B?MWxJV21oL0RmVW5QTmhpR3hYU001Rjd2MUxUdUlZUDNkWlE1NEFWeEdXaUk4?=
 =?utf-8?B?dklvK3k1RFVWdXBtem4rMHNYd1YxNnp5aTZrZkNramZwcXRoK1ZnY3FCWFZ6?=
 =?utf-8?B?WHZSVnpqdGROcFp1TTRPNDBZMDhTMkpFMkFURW9wbGlKY0FiQm84N0dvOWFo?=
 =?utf-8?B?NXI3YlcvUEJENWtERGExVC9tNGVmMzVEem9oY2ZMTnhJRDkvckcrY20vVmtT?=
 =?utf-8?B?K0pOU2F6UG93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TW95SjhwNUorR3RmTDJIRVRHZUFGdlZOeDB1Ulo1cUV2eEFoMWNsYkQ0ZzNx?=
 =?utf-8?B?UHc2QjMrdVpMeDZWeVVWQzdBenJSWWVyTmU4SmtINStsVmd6YnlGMHRweXJZ?=
 =?utf-8?B?djVXeEU5Ri9RRHZIVk15NDFwVXFZbFI4dWhtQVFUZDYxVEd2QUpEREpXR1NQ?=
 =?utf-8?B?THVReUo0VEFtMUI0RURIclgyQWRlQ1U1dklLS0JhKy9nRW0rNEJhc2ZsaHZJ?=
 =?utf-8?B?M1NsY21HZ0poNkVRdlRpQ05SUGF3aCsyY1JKd0ZhSnp2Q0hpRHpGeXJhNHFx?=
 =?utf-8?B?T2JId1lxMVFUSzBnS2tEUW1JYWdBRjVaZ3BNKy9lQXRxdWsvVzlOaU1xWjFL?=
 =?utf-8?B?c1RUcWkzaDF5ajZlZVZvdzhTNTR0WXJESEZKVFlrclB3TTBpZWJGOTBReVBQ?=
 =?utf-8?B?VEJ6d1hMQmtsSFFpcWorNTZOdmlUY1d1ZFlDTXZEQWRLZlJuTmdCbVVNKzJI?=
 =?utf-8?B?eFVKRXI1dncyMXV1SGZacHAzWlhFVHRjL2t2TWJPWWpaUjFmeW1OeU00OG9k?=
 =?utf-8?B?aTdzdkoxSmRHYUxvbkZJa3NJMWQ0VVpMQjJRa1lWNjFSRXVQemdNQldaTng4?=
 =?utf-8?B?RFVVUnpndzAwOE1sQ2ZzUjltTnBXUzM4VXNrRWlpQzdSenhDbS83ZjZ1OGJ0?=
 =?utf-8?B?SU9FbzFLZVlqWHkvcXVhdUJUMmJ2MTZKY3FPamtCTzkyUkg1dmxKRVN2VjA3?=
 =?utf-8?B?bGpFc1BFT1FaYUpYWDNhZW9weit4elZ6ODE4N2Zjdnd4MnZZZk51YmNhUVdG?=
 =?utf-8?B?bGZsM01TTUhiOUdMQ3ZjQVhFRlVMZlVianllME5aWVRFdjZVMGpKTEY0R0o1?=
 =?utf-8?B?aUxmaWdhMjlPU1JlaFNoZWo0RjZ4dU1PN2gvelFMV3RiaWljSUljYjJZbVdG?=
 =?utf-8?B?bEtGV1FneEphTHJBUzZscUNvUk9Cd2FVNEVVUi9DMGRFQTVqQjFwWFo2MU5C?=
 =?utf-8?B?aExac2kvdFVZbjBiTzRReThRdys5dG00cExONE00aHFPRitZam9xaHRVajJk?=
 =?utf-8?B?c0pCZThiN2s3dWhPa1BSQ1ljTm5jcVJtNkxWWEZBT2ltenpteVBPZGVLVTd2?=
 =?utf-8?B?WjdRaUYxRHFTVldlTkpzdCt2Nkp3MmkxWHZHQ01SZzMyRmFUUnE1OGRiRnA0?=
 =?utf-8?B?cjZKQWFwSHI2Q1o5bW5pSVJON2V1RXg1TUt0Z1A5VTV0N2k1U25SNDBicnMr?=
 =?utf-8?B?VUNtY3djaFNVK0c0ejRzL2lIRnQyeWVGZXAvaE9NK3U4YXVIMkFtQVFZYW1T?=
 =?utf-8?B?N1huS0kreE5DYTNHWlJYV3M0SEdQN1ZzdldaV0ZNWVlUeFNGMnNpMWowRUF1?=
 =?utf-8?B?bEJIcWtDbUpYZVVmdUVOTEg0Wi9oY0VWVFU4Q3RyQUk1MC8xUkxDbUNGK1VQ?=
 =?utf-8?B?U3NQbkN3RjRjdHVqY1pmdkMrN3RreDVQY2hJdEtaZ2JnL3ZON2tlUlRVcG5m?=
 =?utf-8?B?VzVhRmlVajEvWnBHVWhVLzdDWDhLcjRJbGRHZHMzdTE3cHFEdDZ5TUtUUjMr?=
 =?utf-8?B?ZGhqbzlBbHQ1dEJjZG1rOW1EeDNaQWFOTGZYUlhsRzdjVkZ2LzBYRitqQWlj?=
 =?utf-8?B?K3lJYnNwdVp3c0lRSkNDdVUxS3lmUGhTRG8rTHFtUDRqV3JhN0NMYWZXWE1L?=
 =?utf-8?B?UVlNMDl0Y05JajdvY1E1ZFNsVzIrZ2E2RzZCRDdkcm9RdWtDS1NKcUdPNXBq?=
 =?utf-8?B?L0NvZEpKeDZERCtVNkJnektjelNaWXhkNEI3Rkx5S0JsNUROZGU5eVlNa05o?=
 =?utf-8?B?NVRDUlNqME5CSUo4eWJaMHVjUlFMc25ham5IZVFjVGlhZ1h2enBqcVY5NzNE?=
 =?utf-8?B?ejdqZ2hjbXFGOFRkeGhDN3ZKYXpwMWVldUczcmh5WnJXYlpNdmxnZG03RXlt?=
 =?utf-8?B?elc4TFRCU0k3UktDMzJNRzhxVDlzb0NjMzBKQXBFSXppZkJsQm8veEtqQWpo?=
 =?utf-8?B?Y3lYcVdORU03UTFMYWdITjFpV2hONW93ZU9MWWtHZ3BpeVo4TWZRRWVlMEM2?=
 =?utf-8?B?eTMyZmVwWURrYWQ5TkpuanMvZTJGN3d3elVob3pmODBvSldwcTVYVGN5UHpa?=
 =?utf-8?B?V2t5N3RRQ0xTZ0FxeGU3Rmt4U2o1WlIyZmVKOTRveFR4eGljMFF0d3BQU1cv?=
 =?utf-8?Q?+AYmJ4PWqx/NnecdZ2IAHavaX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d68ad3a3-5ef9-4e46-4ca6-08dd55627896
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 06:05:57.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28g1GSLzEnh7MXqXPJXyvsOc9dvx9vGDUqkgJTsJe2bA1RAXfm2x9iIvDWuJkcTC3m4mICEIIv6oKqhJosoIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6013
X-Proofpoint-GUID: sWqlKOGjFxyBfrdTp4HFr7p68ebIB0Pu
X-Authority-Analysis: v=2.4 cv=FLrhx/os c=1 sm=1 tr=0 ts=67bd5dc9 cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=BDye6A67q35e6UNUlbwA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: sWqlKOGjFxyBfrdTp4HFr7p68ebIB0Pu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMCwgMjAyNSA1OjIwIFBN
DQo+IFRvOiBTYWkgS3Jpc2huYSBHYWp1bGEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPjsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47DQo+IEdlZXRo
YXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+OyBMaW51IENoZXJpYW4NCj4gPGxj
aGVyaWFuQG1hcnZlbGwuY29tPjsgSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IEhh
cmlwcmFzYWQgS2VsYW0NCj4gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVw
IEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsg
a2FsZXNoLWFuYWtrdXIucHVyYXlpbEBicm9hZGNvbS5jb20NCj4gU3ViamVjdDogUmU6IFtuZXQt
bmV4dCBQQVRDSCB2MTAgMi82XSBvY3Rlb250eDItYWY6IENOMjBrIGJhc2ljDQo+IG1ib3ggb3Bl
cmF0aW9ucyBhbmQgc3RydWN0dXJlcw0KPiANCj4gT24gMi8xNy8yNSA5OuKAijUyIEFNLCBTYWkg
S3Jpc2huYSB3cm90ZTogPiBAQCAtMjQ0Myw2ICsyNDY5LDE4IEBAIHN0YXRpYw0KPiBpbnQgcnZ1
X21ib3hfaW5pdChzdHJ1Y3QgcnZ1ICpydnUsIHN0cnVjdCBtYm94X3dxX2luZm8gKm13LCA+IH0g
PiB9ID4gPiArDQo+IG5nX3J2dV9tYm94ID0ga3phbGxvYyhzaXplb2YoKm5nX3J2dV9tYm94KSwg
R0ZQX0tFUk5FTCk7ID4gKyBpZg0KPiAoIW5nX3J2dV9tYm94KSANCj4gT24gMi8xNy8yNSA5OjUy
IEFNLCBTYWkgS3Jpc2huYSB3cm90ZToNCj4gPiBAQCAtMjQ0Myw2ICsyNDY5LDE4IEBAIHN0YXRp
YyBpbnQgcnZ1X21ib3hfaW5pdChzdHJ1Y3QgcnZ1ICpydnUsIHN0cnVjdA0KPiBtYm94X3dxX2lu
Zm8gKm13LA0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPg0KPiA+ICsJbmdfcnZ1X21ib3ggPSBremFs
bG9jKHNpemVvZigqbmdfcnZ1X21ib3gpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghbmdfcnZ1
X21ib3gpIHsNCj4gPiArCQllcnIgPSAtRU5PTUVNOw0KPiA+ICsJCWdvdG8gZnJlZV9iaXRtYXA7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcnZ1LT5uZ19ydnUgPSBuZ19ydnVfbWJveA0KPiANCj4g
QUZBSUNTIHJ2dS0+bmdfcnZ1IGlzIGZyZWVkIG9ubHkgYnkgcnZ1X3JlbW92ZSgpLCBzbyBpdCdz
IGxlYWtlZCBvbiB0aGUgbGF0ZXINCj4gZXJyb3IgcGF0aHMuDQpBY2ssIHdpbGwgc3VibWl0IHYx
MSB3aXRoIHVwZGF0ZXMuDQo+IA0KPiAvUA0KDQo=

