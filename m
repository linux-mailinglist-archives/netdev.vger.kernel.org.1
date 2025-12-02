Return-Path: <netdev+bounces-243255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8CBC9C4B8
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D483A6394
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1412BE7CB;
	Tue,  2 Dec 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TGUgnsxb";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="s95b2eHv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05352BDC2A;
	Tue,  2 Dec 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694436; cv=fail; b=j3OIeNUAEvMh0jzjX5f1v+sVt2AdRnHz+6XANtrvBxse7qKvA+Sam2ZT0b5/eCTDSXz0xsjEoLSrE2b3fh5owpL2SY7qlsKhv+QQp/6m4SrsawR08EsE7kipe4RmKbZNRuJ87hDIo7iK2XbzuLdqIfcpXOYWidvGiJFCnCbTYWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694436; c=relaxed/simple;
	bh=V3WCne3NGu/y+bXEhx9GEM7I1re/NAhJ1AT77bfjhWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IE5g4kQAIyqh6JRNyVUeUKEAW2+FICgrb1xbF+DJxuPQ2H8JsvDdeGxc/wW+4902SFrQh+6EWlFXA7DFupKPjmRnfuqU6xL6lzaF1P5YxTG5IBmQnOxvl4KyujXIIaZi5XWGz8jd6OyOYZzCuRdJkoJ7qT3Ue0r8oi4PMFDH8W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=TGUgnsxb; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=s95b2eHv; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2EPlpD1715558;
	Tue, 2 Dec 2025 08:53:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=V3WCne3NGu/y+bXEhx9GEM7I1re/NAhJ1AT77bfjh
	WM=; b=TGUgnsxbENRmVINJ5rIaMr7TjUPyaXrAkvqVTa/HGe2isDfx1G/Nc6CZr
	YtTQH1UI92mOvDilWO2xcI7q5HmC11NgOc30zqp3DBAgA0wWg0Td+j8dMh2d8Rwr
	03xdhmQgtohDUGEvjkSHxOysqfglSGbwSqxrY9nQXWJGb5rHvpxfVS5nEl4ByBdu
	sjpy77+gMHZEl6MN6bXKlsrg+gTBTw47B//8cDaYewxeT9zqHk95t7Of1f03gfuR
	YDIPpacVA1lgLP7Q103E/nxE6mqxl1C1AltGEFoNwxZsto1gB5uoVRKh1vlmda3T
	U49Fnm2e6JxqgjLAVMsns4RLYH0Ow==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021115.outbound.protection.outlook.com [40.107.208.115])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxsjv1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 08:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ0Erx/RUWgWhyNalj9oxNY0foW4ugvc0MZDh3fZSoFxAHj3X4zOyCnO4vY7od7L0D3FplqzygKyXddO9nU+3kfX66xJYjm7Y5jju/MAM8jB2SwySG3FMALtTUp+X0uM2UZG2CwW3XP8UHd/2A1SP/gjnrXEOa0tCWzpKw5Nsz0w56aXh7oZTpDJFI9y/+utiyaQuGCkdQS970fuSSGFzKEPtRJVl7OT0T6wBjnUQxssV+AOE9LQtU9jsOV8OFqbEDS2prC4C7KiqvK2iqbkPxX8c9vpaLxCfvd6eebHzIste9BFNRJr8vqLOsElILhXTxE72mn73ecXQDL1FSTJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3WCne3NGu/y+bXEhx9GEM7I1re/NAhJ1AT77bfjhWM=;
 b=Rauzpk9LrvszuXGutGPmzAYGnTTfCpfWWOz/d21KIMhWugfnLGQNggKhS709KUhwzEZuJAP4ztt3IzI3/Pgi4zv2ZyLfcqwaMzteKKRnrV7TI45+73c2meP3TbdFtpVE/fPBm0xDBBsHCr9rnkXHT3tM2PWP5jLQNp0z8Pmpkp/om6JnawVls0NTwHHZUn7AwP75m3xz7xp/KDYjEqmQuGUA3EAuiry840D2FlUN801nAdR7Cpdsey02gjQzNmTSavbwhKE5C7tpcHeKINhbJiiSGUQ/FBLqnlx5QRlFEyOwqo6SkExWFqcPQyfN+98miAPYWaMcFtzN5io48CJxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3WCne3NGu/y+bXEhx9GEM7I1re/NAhJ1AT77bfjhWM=;
 b=s95b2eHvYckXhZ7FvDr8Q/64W9PYn5LuF6tTn2/EpLBUoq4A+9OysGowNTrwx8w1Ky3CADuYX/eAtnOrZey03awiyBvaF06tfdlbfZ4J6LtNhl17pkp+s+Zedo/2QHN/EJ6dA1nUBVVJEcxtUtL+P9ye/xnyhk1OJFvdzMdnsHdT1yBP4uDiKLXxl1Ru9sy21BRD7RiAx7DMH3I6TiSwton2yhu6K+HaZDanmEdaMxEWZvfooMAfueM6E2BvG54z0DDx/izEyfXu+lewDNN0qkJNhchzloYorCZyYfgcP4rR2PIUeX7foXPuAXkMyTc3yEMfvqmHRQ/6FcQSQh0zyw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SJ2PR02MB9895.namprd02.prod.outlook.com
 (2603:10b6:a03:546::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 16:53:43 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:53:43 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Cong Wang
	<xiyou.wangcong@gmail.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Wang <jasowang@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Thread-Topic: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Thread-Index: AQHcXjIiRA+HhBm9skOMcjqSLJ9e2LUElNMAgACQMoCAAQ06gIAIab4A
Date: Tue, 2 Dec 2025 16:53:43 +0000
Message-ID: <B4079F8E-E823-4848-A3CE-81D319B1FC4F@nutanix.com>
References: <20251125181930.1192165-1-jon@nutanix.com>
 <aSawDrVIMM4eHlAw@shredder>
 <8EA496BE-669B-44C1-A3D7-AF7BD7E866ED@nutanix.com>
 <aSgK2wfLJurn2df5@shredder>
In-Reply-To: <aSgK2wfLJurn2df5@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SJ2PR02MB9895:EE_
x-ms-office365-filtering-correlation-id: 1ac2b5e2-db99-46f8-d907-08de31c35a0d
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDJ2c1VJOUxVZ1prVkRxeHRKd1llc2pmVi9nREsvU21iVHpHZlR0LzMwZmhh?=
 =?utf-8?B?QlVIWEsyV09idEdtb3l5b3F3SDlHSTBGTEUvcFgzYkl1YThBM3JlbW5pMmNo?=
 =?utf-8?B?dllma05DWWkvUm8yaVNuZ2hncERQeUUrdGZxU2dFK0laeEZ0ZERrV09lQ2ZB?=
 =?utf-8?B?eFFEUkxnc3lqRnJCSFlzbm1nV01ERi9aZFR6RklwS0toS25UKzh1UU04RnM1?=
 =?utf-8?B?b2hOZkkxV1FEZ0hsYmsyUXFLT2xKM3Vud3E1TkdxbnVhODErbW1LU1RQWFhT?=
 =?utf-8?B?d3ZLRTRYNGdIV2JXS2tWZWJsSHBEOXdaeGhzQjhLSzFVT2M1a2EyQytJMzhr?=
 =?utf-8?B?bXEzSCtKcEdyTTc5Qm1TZ3RZVCt4RS80OVA0dDJzVXord3NFaStwTHkyT1VJ?=
 =?utf-8?B?MkZCUjFDTG5kOXk3blBFYXN5cnpxMzBPeFY4eEdRZSsvTDl2VnF2d1JJTjhF?=
 =?utf-8?B?MFRCVitwc3R5dVZvY3lIOU84ZC9GeTdVV3BPRnBMMEVuanVmQUhUV0RudDFM?=
 =?utf-8?B?Sk9MVlFGMFkwaXVIdUZ5Sk54bWhZSEhkMHZZaEpCMGVlUVhUQWdtZFlINm1I?=
 =?utf-8?B?QTVpb0hjZnlBT05nWVVQQkpyS09UMzdTZWl1ZndLd3ROVklFaUxJLzZxaU5k?=
 =?utf-8?B?ZUt1UFl3R2ZGT1cyNW9pbEVjMUFDWUg0bWZJdVZ2S2JwWGR2RVJwUC8rdVZ6?=
 =?utf-8?B?VHArN1FWWUw2dXBSdzZSZDFoOXR0WTladlNkVFY4aWMzRjJEcCtVWnRjV1RL?=
 =?utf-8?B?NFJkS1dWd0xZczlYUTVGSmNSZ25Xb0NsS2ltMWhvTWVNLzNvbXRhU0txbWw1?=
 =?utf-8?B?WFNreVpuUi9jem51SVFaeWY2N1JMTm5MQXVPMko0NTlKODJHVGEyM0xrY3E4?=
 =?utf-8?B?RXM1Y3lRSzVkclNzQTVMWXJwRlZNYTZoQTBLUFVRYWZmMjJGd25UVG1QNTVQ?=
 =?utf-8?B?cUVqZkVScTdlNnBEUzhpVnY2Y3NIeFZMczhjM050R2RIOXZIclFMVW1JK0ZL?=
 =?utf-8?B?Kzc3cTlxNE1FdVJpSnlzQ0dJc2p1cFBKa0JSQUU3bVRBZmN1Q3VmUHlzdFFo?=
 =?utf-8?B?RUhNUUQ0SVNha1JmMDJqNGhCUGNjU1RydXdjdS90Wjd6d0NRc1FuRHpXK3dp?=
 =?utf-8?B?QWRaU3p5MEhoQlZWNnRmeVJRclB4LzF4c1l1YWttcjBFUHpnZ2krb1FuTkNk?=
 =?utf-8?B?ZUwwbGRWQjZybDNzRDdQWXc1bVpPVTBpMTNXK1AvTjZqMERKS1FDRThLeWtq?=
 =?utf-8?B?WS9ZQU5KOVBrV0pyVmhFbml2K2hDNlZvS01rY3cxaGljQ1ZhRHM2aFEvWkpk?=
 =?utf-8?B?M3FnZ3FSUHM2Mm41bDErNEEycFBLSzhTdVlIS25WeTBJYjJGT0tnQ2EvOVo0?=
 =?utf-8?B?VlVCSVNsOHhzMHBUYkdhNXh3NUJmbzVYdU1vZGhScTVnN0tGSnc2ZUZ1amxP?=
 =?utf-8?B?UEliL0ZJMjlRN0hOQVJrOTkyV21YLy9ib1U4UTF2dUM1MCtZVWdLKzZKLzcr?=
 =?utf-8?B?dzZXWDFldHV0dmxaODRXMm1wSHVCSlNSUElTMFltVG9lbDAwd3Q3QWtYZWg5?=
 =?utf-8?B?TW43c1BHR1duTTh1Nm04T2k0VlFDVk1XRHlrZG1ZWUZQaWRkcUdia1MwU2FY?=
 =?utf-8?B?MHRJbG9rbWNMQ0ExQ1hGZ0RHa0dxTTJWZWx0LzkrR0h6OGJUVHJxRWpraDJX?=
 =?utf-8?B?eS9EU3pYNUprUDhiQ1I3SDRFVkNBemN0Q01SOENaL2VuYnFJY3FKeU1Uc2ZO?=
 =?utf-8?B?UVB2SlZjbzA2QmpMeXZzSldsN3Vqb2NWcHRJSElVV1VYWVJUa2VScXNGMFlX?=
 =?utf-8?B?amtFaDdibzN4ZlV6ZjZHQWJZdGkxT04yOHg4djlLMmtnZU5aTk94TkxFKy9D?=
 =?utf-8?B?Y1h1WGc0a0txTVJmR3NndkJSTUQ4L3cyNUxCdnE5Rmpyc3l4U1hzRjUwTzli?=
 =?utf-8?B?OTh4eEVDSjVob3MrSTZiWHFLNXEwNTJxRGkxdzhySlBWN04zOVNPWDh1dU9G?=
 =?utf-8?B?ZzBRbEdUSU1rMTVJMkhGaWRuSThObmV4NTErVEZjNEgvZjBMMDRWQ1ZDVFI4?=
 =?utf-8?Q?fSqLmF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVBSUx0S0ZLWTZoRHMxYU1oYmdqa3ovQUlqMnhXRmVyR08wK01CUmg5dG1W?=
 =?utf-8?B?WVp4RjA5OHRMNS9SN0xQd2dCenNhNHV5ZjBKcGZWMFNwQkxXS0x0UE1UczVP?=
 =?utf-8?B?NnVDMXNveEtEN2grQWdNU25WM1pKWHFOUkYza2k1RS9LS2Y2UUE2cVBDZUg4?=
 =?utf-8?B?NlE0QUdWZDltVnoxOWpnUlJPYXVQVXVOQ1NZb3pDL0FZVW43MzVuelFKS3FO?=
 =?utf-8?B?dDc4OVd5NG9MNUVwZm45OE04NDJGREQwcVd4SUVxczhFRy9LYjJYWXdjbUZX?=
 =?utf-8?B?dFlNblQ2ajNXSXJFcFNkNEY4WExIVzdleWxsNWZOVS9IWjVza1BkWFZZOFNY?=
 =?utf-8?B?RmdEa1hJUWpvRjZlcWVHSUIwbjl1Z0FpYnV5ZnpwM3hoWm1DdzlvK29uK2k4?=
 =?utf-8?B?c3daM1c3NWtqZjJVKzN3cU1SbTZsSlhmU2tjRkptQTdiY2VYZmNvZEVmbWNK?=
 =?utf-8?B?Z3JkN0NTTWpDYkxQQWlxYURpVjlETkU2aEpFKzhNWFJqM24zbHF5cGtDNDh4?=
 =?utf-8?B?aXY5cjM5SHF2UkcxTm9sTzloM3BLRnB6WHNRN3MwU2tzK2JvMVAySmhQcjE0?=
 =?utf-8?B?bHF3ZDFaSDA0Vk4xUWwyZERaaEQ4K3JseDlES1VZSHdkSm9sVTdsdEtXdTdE?=
 =?utf-8?B?MS85cnFSYXN4Q1d0cTY0Z1lhV3JSa3lYQWJCTnZ5WnRKTm9OQktOaERFRDNJ?=
 =?utf-8?B?dmZFWFlBQnZESmNSaEhjSjMzNC9MUlFyRHlqWmhySFIxRXY3UE1ySk0weGpo?=
 =?utf-8?B?dGVPTGZKaEwwQ0w1UW9hYTNKOGYrKzFCNlg5UEFCV2ZrL2hvYjhaUjVIQUNX?=
 =?utf-8?B?RDkzOXFGR1lIT2hRU0ZmclZXK2tjUGVsenlpMmpnTnNOamFjRWd5R3h4T1NJ?=
 =?utf-8?B?cGhZUmUrM3haVVIrWXdRNkM5T3gxd3FNZS9iTGNzbHJQTzFxeHQ2VkRhaSsx?=
 =?utf-8?B?azRwamphbThBQ2FDbFNnWFozVEliSEl5Q3NOUXFqMHVscml4OGdRdzdiVmx5?=
 =?utf-8?B?NkU3ZHdxb0ZDbGYwZnNsTUwrZFlVaGVWS0UrODBxSm93dzA5TEJWOGpwTDVI?=
 =?utf-8?B?bzBwZVJuTm0vK3dwd3VXRmtMcHdPODVrV2NPVE5yTFpjREJQVy9QVFQvbDZq?=
 =?utf-8?B?OFlBclNuaytMc2RndWRjdklKMTlrRzFEYW9USGJ4Z215M0UvclpwajdtWVV4?=
 =?utf-8?B?WGtROURIVmlnL3R1R1ZNWVMvcVUvejFBZDdpNkxtMUw1UnZXZkVEb2VCWFdX?=
 =?utf-8?B?dDdpQWhaSkJOVzhXOWNYQ1IxWWl3aU41UWJRemdKK0RlWlBOT21jWWNlUVlD?=
 =?utf-8?B?NS9uZzEyYTV2WlBxRGVGU1cvU1FLOUN4NEorMEx1YnR6SGl1RWc3a1R3VHlT?=
 =?utf-8?B?cVlKcVZaU1B0cEc4V01LNEZQeSsvajFKUVo3YWRBNmt4Wmd5Yk9iR0ZqRjNO?=
 =?utf-8?B?QkFKVkkrWFczay9CTFExcEI0NlpEc1N1M3gwZGphb0NIc1NkR1VQaWViRG5I?=
 =?utf-8?B?cnFuQ3R0Y3MyN3crNS9CWU44VzhpOVhwODcwSEFkcEZDcWJzSXRUVnE3NXdy?=
 =?utf-8?B?ZVdDQUkyRzFDL25nYlRQUUdWaTROSnRHODh4MFBoZzMzbllSRHExR3p1R2xJ?=
 =?utf-8?B?ckQwSmdrSVc4c29ibTN2eTl6UFZmYlR0cUNlMDVLR2ZhZXlya0Fwb0hCelhH?=
 =?utf-8?B?dTdUa1A2citvYWM4L0NQRzlndkp0TzIxdy81N0Y0d1FWSzlPSnM1ODN0SFo3?=
 =?utf-8?B?VEwvU2dZMFd2ekhnWGU4cUxJRkRNUXpOZFArYlFvMVJXRHUreGZ1MjNEMmNI?=
 =?utf-8?B?VkhyQVBCVGRFS2NGMkdQWVIwVjRYS1FiMEI2QXUwZkZscjNmeU9WdVlzcFFv?=
 =?utf-8?B?OGdWK2kwZXVaQlcxdGR1ZlA2dmdwUEY1TWdWZW5rRXRsZ0E0TWU4Z3kwQU42?=
 =?utf-8?B?RjNyNWhUNTR3RHJqUytkeU1XUmtkVG9NaGRRUTZyYzlGS0E5SXpFeXJIMVNF?=
 =?utf-8?B?UEc4eEIzTlVFZWxFVVVzWmFDc0tRbHgwS1oyeWhCcjlXQmtyMjBjSTBwV3V3?=
 =?utf-8?B?Zk5Fb2p1dGlXSkZ5VmZiL0ovTTdST1pWdUZzTUpZTmloWjd0YU56eE5Fb2Zh?=
 =?utf-8?B?VExJWWh6dVJ5OHdDWG53R3l3K1dPWlI3NnFRaUtINGwvZVBVeEtpN0J0L3pr?=
 =?utf-8?B?Y1VKQ2pEbjhOcVVKZklqQmlHYlVURkJxbWJiUEJiT1oyMld1TjdOWDVBeHEr?=
 =?utf-8?B?dllHSE94QlUzRll0M1JqZFV3enhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57D6233E94C659469A32B39AC55DA4AB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac2b5e2-db99-46f8-d907-08de31c35a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 16:53:43.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4qoJXVXZWnOzaDE+mkvQrO2l21nLICouSGBzPEzXJOhHkSEvhUTD0tS/4dHKhptUmUJ+n1eBX2h1xNNmp/3p6t+Vhx/llZowLxqR5/sObo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9895
X-Proofpoint-ORIG-GUID: zkcVbHCGrwgG-yYQeWtUu0GjIU7o5bm4
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=692f1999 cx=c_pps
 a=gSwIq21hjLySy5HhNOa0Yw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=MxTnnzxr7v7CFXhhxPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEzNCBTYWx0ZWRfX0iytjjPt3u9z
 8AvVO6MpyUSSrPRiT3MrPxWLtTWDDXdC1Q3+LW4iy/MIsVVCfo7VUNeDd7GOgI9IyCQPzjG7tB0
 abe8l+E3s0sT5kekIiV4VxYp0H+W9sMzJfSvAcmbkAz4Itc0ly3XVE4FTBp0wCYuHkHdroMizkX
 DxUXJMpBAE4b2i6lvJbozJvZ2sXwmFfxqn273PqzOhcMj2GZZT6ldCCeYgrRQEIYSBQKOxJEBE1
 h/ltf/+O5VdqQ4sMrN+WK9PLv1nNJ/6ND8y3G/UPqjTKgCh02qpdqcwupHIfAMjxFhI85hM/3t5
 wcRC4lY2Zr8VvzJHq+89YMy6q8V2k9xMG3u6SSJVKJPRt1HFY5BeQhva6rbEEes44nt38g9IO5w
 8LlsG0YofAEMPIx4Zk3Tfk0ByLWO6A==
X-Proofpoint-GUID: zkcVbHCGrwgG-yYQeWtUu0GjIU7o5bm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI3LCAyMDI1LCBhdCAzOjI04oCvQU0sIElkbyBTY2hpbW1lbCA8aWRvc2No
QG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgMDQ6MjE6
MzNQTSArMDAwMCwgSm9uIEtvaGxlciB3cm90ZToNCj4+IFdoYXQgYWJvdXQgYSB2YXJpYW50IG9m
IHRoaXMgcGF0Y2ggdGhhdCBoYWQgYW4gYXJnIGxpa2U6DQo+PiBfX3NrYl9nZXRfaGFzaF9zeW1t
ZXRyaWMoc3RydWN0IHNrX2J1ZmYgKnNrYiwgYm9vbCBzYXZlX2hhc2gpDQo+PiANCj4+IFRoZW4g
d2UganVzdCBtYWtlIGNhbGxzIChsaWtlIHR1bikgb3B0IGluPw0KPiANCj4gSXQgd2lsbCByZXF1
aXJlIGNoYW5nZXMgaW4gYWxsIHRoZSBjYWxsZXJzIGFuZCBJIGFtIG5vdCBzdXJlIGl0J3Mgd2lz
ZQ0KPiB0byBjaGFuZ2UgYSBjb21tb24gZnVuY3Rpb24gZm9yIGEgc2luZ2xlIHVzZXIuIFdoeSBu
b3QganVzdCBwYXRjaCB0dW4gdG8NCj4gY2FsbCBfX3NrYl9zZXRfc3dfaGFzaChza2IsIGhhc2gs
IHRydWUpPyBJSVVDLCBldmVuIGluIHR1biB5b3Ugb25seSBuZWVkDQo+IGl0IGluIHR3byBvdXQg
b2YgdGhlIGZvdXIgY2FsbGVycyBvZiBfX3NrYl9nZXRfaGFzaF9zeW1tZXRyaWMoKToNCj4gdHVu
X2dldF91c2VyKCkgYW5kIHR1bl94ZHBfb25lKCkgd2hpY2ggYm90aCBidWlsZCBhbiBza2IgYmVm
b3JlDQo+IGluamVjdGluZyBpdCBpbnRvIHRoZSBSeCBwYXRoLg0KDQpJIHRob3VnaHQgYWJvdXQg
dGhhdCwgYnV0IHRoZSBuaWNlIGJpdCBhYm91dCBkb2luZyBpdCBsaWtlIEkgaGF2ZSBpdA0KaXMg
dGhhdCB0aGUgZmxvdyBrZXlzIC8gTDQgaGFzaCBiaXRzIGFyZSBnZXR0aW5nIGV2YWx1YXRlZCBw
cm9wZXJseS4NCg0KSWYgd2UgZG8gaXQgbGlrZSB5b3XigJl2ZSBzdWdnZXN0ZWQsIHdl4oCZcmUg
YXNzZXJ0aW5nIHRoYXQgTDQgaGFzaCBpcyBhbHdheXMNCnRydWUsIHJpZ2h0Pw0KDQpIb3cgYWJv
dXQgYW5vdGhlciBoZWxwZXIsIHRoYXQgb25seSB0dW4gY29uc3VtZXMsIHdoaWNoIGRvZXMgYWxs
IG9mIHRoZXNlDQp0aGluZ3MsIHN1Y2ggdGhhdCB0aGUgY29kZSBzdGlsbCBzdGF5cyBjbGVhbiBv
biB0aGUgZmxvdyBkaXNzZWN0b3Igc2lkZQ0KYW5kIHdlIGRvbuKAmXQgaGF2ZSB0byBtZXNzIHdp
dGggYW55IG90aGVyIGNhbGxlcnM/DQoNClRoYXQgd291bGQgYmUgdGhlIG1pZGRsZSBncm91bmQg
YmV0d2VlbiB3aGF0IHlvdSBzdWdnZXN0ZWQgYW5kIHdoYXQgSSBkaWQNCg0KVGhvdWdodHM/DQoN
ClRoYW5rcywNCkpvbg==

