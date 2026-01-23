Return-Path: <netdev+bounces-252820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CwcHoFfc2ngvAAAu9opvQ
	(envelope-from <netdev+bounces-252820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:46:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A075521
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 805E330B0E2B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E07F342C94;
	Fri, 23 Jan 2026 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="EBUGoMYp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265E359717
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168298; cv=fail; b=TtgRUuvsPlcTXEdEYIXTrIRKQzUMvleCl4RzvueGKVUTvJ3mXRhVSHJDujIZM6zQ5XA+KbrWlfZ59mAPFlSbaJ9Xf+ZrW1IAkGjPA+Gn+Eg7Pjnm8hNGz8LTsgtjmtBjHPYJE8D/Se3b05k3QvOPK+5mV99XuVhPH9YOGudXddM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168298; c=relaxed/simple;
	bh=YdzL0kJDJmcSoaZyJuJy5kG7jKm6LzTR2YhNGO05UOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYjQ52lS1QEeHwhLp/mqVQ3RQ1uHvdgxoFNcfQEgD5NyFbHBT1z0bSI5Dmz5s1cZsA2RVK60NJn+7LZqI7MtfUkvImnJVUe+RGhHX+WogA4y+k9cmGNAZhmHUfHw93Jiqmj8eL9gHH3jGvjpHSvXsmBmzPUMtXiTMFRpG4T0Rnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=EBUGoMYp; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MNSVk23718392;
	Fri, 23 Jan 2026 03:37:48 -0800
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022133.outbound.protection.outlook.com [40.93.195.133])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4buwkh984r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 03:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVF5cJbJzEfMhHMRDyEWg5m9GTN+wkH8wv+2PB88ejnGHQuVmiBUfd8u+/IorTTSwR871h9Y8Bfj/GzAyYuKVD6gkWlcxNEvycn2zXa0sNCsgqOsLipw7JMCXk2vjtRI/tcLqD8QSKyEGWME1FQOu1uF05QrYEt1OiG//n6ZzYzCbFvzBLG3FWwBd5IZngf8itGCFpP9b8E/lbJjBPLetK3QVWWFjFcIoBIU74ZtJYAGxIt3y/4kCDKonjIRDGjJLiDxL9WjMTJfdXjJuO8qzOS0JstdnuVU3PVr9Sz8FLVpQAYwcBUi0MYiwNdBbOsUfdGvGXaVFCQqCLEs0iaL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdzL0kJDJmcSoaZyJuJy5kG7jKm6LzTR2YhNGO05UOk=;
 b=LiX79FUL9tYaVbLjLTjZNz/4XuHG5FmB44nc6Y8/TJxQ0LfnKyWkjFgRVY7OiYKylawSfjlewI0zTCPOubFaOYgzNSxTd8MpFsPbsogL9fb6lrsA8JOXDA2EG+xRqpqAlfNO1WaZZTPi1onzsEpAG26z3DRNpOqbelYqRe7BNOMdyYGVM0QYZSaUfJ2Nu7KgA/PU4R51shouKJBakajmuTZ4vYLy+Gm47RY7i5K2PbK4q1t1/tP7A3Y50CrxLcN17k0YYxChCl47X+ggag/KwYCNpU5yxYHNxROPpm3PQV8huGdvVuAzlKmjctZ+eRr/wtr2O0xXhNgqDedKolXmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdzL0kJDJmcSoaZyJuJy5kG7jKm6LzTR2YhNGO05UOk=;
 b=EBUGoMYpcHFmI9fB7+7TNEZT46YWPz8EgZUU0nFFUbgsPSVLXhKvdUML1Zo2pYo4jDXKNvTAwaSOINk0bBFMNVGO4CqBNfocC9lETNacJyVP0VwPEO/F/xqPpJcDvh7pUKpoOybdV5f0bKuY4wwHaxQI8S/uKUEXn+nAZw9ixt8=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by LV8PR18MB5560.namprd18.prod.outlook.com (2603:10b6:408:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.7; Fri, 23 Jan
 2026 11:37:45 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac%7]) with mapi id 15.20.9564.001; Fri, 23 Jan 2026
 11:37:44 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Shiva Shankar Kommula <kshankar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] virtio_net: Increase RSS max key
 size to match NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] virtio_net: Increase RSS max key
 size to match NETDEV_RSS_KEY_LEN
Thread-Index: AQHci3+uIaCSUqWgmUudoVFL+txQiLVd+SKAgAGbmGA=
Date: Fri, 23 Jan 2026 11:37:44 +0000
Message-ID:
 <CH3PR18MB6379AB2F09B861C3F2B3EC9EA094A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260122091527.339180-1-schalla@marvell.com>
 <20260122050904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260122050904-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|LV8PR18MB5560:EE_
x-ms-office365-filtering-correlation-id: 6b41e246-e3ef-43b6-4358-08de5a73d36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|7142099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzZiU3Y2NnZkekVUeFhzYm5wVUVNQndBejNuUk5tYnJSUFgzcElyMHVURS94?=
 =?utf-8?B?SVQ1dUtic3o1VHBmbVg0bTZPUkZKVm10cER6NEx1S2dtQUlNaW1iVTBjdjN4?=
 =?utf-8?B?R2Zjb3NqbXNqRFd2T251K2pYSi9SNjZ5eG9aQlBLZlh6R0YzSyt2RXhrWTlM?=
 =?utf-8?B?WEsrcHRiejJPcG45eWw1NEhTdkVqZC9JekJaaDZRUmhvajRJaytBcVlRQ3Rp?=
 =?utf-8?B?UlJyK013bWRqWE0vSFdycXMwYlhQOXlqa1pQTGIwY3dTeTJidklKZmJuQ1hS?=
 =?utf-8?B?N0pvcDR3dUtpOFlYZjhOZXVPbzJpbDVUQkVKRVhMU014YUlUNDFoeUVSTDda?=
 =?utf-8?B?b1V6Rnp6OEF3QTJ6amhnTTBmSzJNb1hTMTFPSVpiZVN6alpPSjFZb3lQMFhm?=
 =?utf-8?B?TU4zNWdVYmV2RlY3OG85V2xXZHdBS2s1cXA2Rlh0dmJXUEhlNkp5dmsrN0gv?=
 =?utf-8?B?QlJLT1dMRE12Vkw4Yk1yajJLZERhTVdLMkk2Y1pNa2Y1TUV2enQ0S1Ftdldx?=
 =?utf-8?B?L1llTnVCeVMxK1FSUGRlQ2E4cjBURjFoUk1Fek1aL3ZndkY1aDhwNTdsdisx?=
 =?utf-8?B?UU4yTjhyZWE5ek1YVU9tY1VqbUVJT0tsamhLOTJpOTkwQ1dZUlA3bVcxdU91?=
 =?utf-8?B?S2tmNGM3RDI5MzkxOURXNnZNNCs3dFp4dkV2b3ZNRWxoby8xcW4wZU9KWTQv?=
 =?utf-8?B?bUpoN0Ira3NUTzQxNE1vZFZEZ2tHVHlldmc4VnREaFdlMWN1VGtmdVliaTVi?=
 =?utf-8?B?bHJiQlhYL0U1SHFKbW9Vd2Y5YzBwTG9wK3FLaktZTGppZ3MyWGxNbE1hNXBJ?=
 =?utf-8?B?QVJkbzg4R0VOTjdrVVhaeVplcXFZVHFwMEtYOVR6QXg5SU9kZ3Z0VFg2TEJx?=
 =?utf-8?B?QVFkUkF4VnZJWnU2RzcyR09rWVB5TlVxaG56STRzc3FROElHL1N2OWNVVFk5?=
 =?utf-8?B?VDFweGRsNWF2OWJ1cGgwUDRJd2ZwWG5GRDg4UmJYYmZndGIrZk5PemNTSWdx?=
 =?utf-8?B?Ynk0YzhHdjhhdExDVHA1V2I3OHArM1pTYzQzRDI5OEJpTGFvNkp5OGpqWGMr?=
 =?utf-8?B?UVhqOXp0bVptbHFvSzFsNVRLTmlEWjBpY09nL1d1RUFXUVlxc1g1ZkhodDhO?=
 =?utf-8?B?N0FTWVA5VEhUSnlaeHdwU2dtRVFFZS9TVjFjUkFFeithMUZHSXBqWTJZN015?=
 =?utf-8?B?d1pCL3FUaHU1bXo2RUI4bFNCci91QUdPNE15MUpQNE5LT29FNWNzRjFWVnZP?=
 =?utf-8?B?YTg1MkF1d0hQclBsZ3A5d2EzZEZkb01SSEdTVFp2ek5jWm5ReTJ5VG4zbzVO?=
 =?utf-8?B?cUpNMldQZ0txUTcxVjVsWWp3RFR4cXZ6R3B6d3ZlZTJUM1dMV3YvRGUwSWtJ?=
 =?utf-8?B?REZxS1hKemJheHBYdlhSQktyZnArMFROWFR3R1BjakxyTGhEUXRzdGtvV3lS?=
 =?utf-8?B?UnpCWmpidjNQSkNtbkZTRS81QjNoL2dkVWlBZ1d2cUdmZ1laUGVQQzZNK056?=
 =?utf-8?B?ak9ISTc1elJOaHgwV1crQmQ1RSszeEtmbndrY2dwLzBiK3lxWEtqS2dRbnF0?=
 =?utf-8?B?SVR6WTZodUpwVzlWd3JkUlQrWGdraWZwMUxpaUF4SzZ6a3dqQVJwYWRiZEtJ?=
 =?utf-8?B?aHliR2M1aGZFdmozVUl3TGFCSGJvQnpUeHFNNGh2OE9nQnUxZ0hlZ1JHK2RD?=
 =?utf-8?B?dGRkVS95dyt4elVPOTE3NmRCUWRmQzlkamdDdURXdW1vWFU5eXBpMDNQaysz?=
 =?utf-8?B?bWpVcWRvOFl4WFV4ZkVtMzExQlQxZE5CSkQyZ1ZGNlpIWnJ0d0x0QUdWRWU0?=
 =?utf-8?B?OUJNMy8zV3dPWjBjWGZaaGlOeFNHclF6dzJobVdUUzQvUDNELzZuMVZoc29u?=
 =?utf-8?B?Q0JWc29DSGlzRU9qclBXVDcvck9reWhMTWNMZ3l6Vmh6SHpqUGNVaEJFQUhK?=
 =?utf-8?B?QjdOTkIxUlp3cFByV0pxV3NocUdyd0RUVXlkRkFBZXZGYUJYR3lVbjEzZEN4?=
 =?utf-8?B?VHJwTjNFNnB0TERYeWM5QU9vZmZIR1I2TjF3Rk1iNENsNmY4MGtEZXRBZElK?=
 =?utf-8?B?ZHBqQ2w5K0xTc0lkd1UzN1pqRC9QeFgydm51a0xlSTNvdjFBeFBSajhmeG9N?=
 =?utf-8?B?WTdMVEhnSFREREhuL08rVVZRbFBXdEdyeWd0KzFKZXlaMy9zNXByZFFmZW5O?=
 =?utf-8?Q?kQlj/C2P4XYgi/G70e+0loE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(7142099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWpLZWJSOVNnYVQ5blNlNWF2cVpsWmY2REFsd2YvTEZtTkROemk4aytjMEZi?=
 =?utf-8?B?UVI2SGlhRVprL1Z4Y2U5TjNHZk4vUldNSDl4SkxBZEhjSE5rUTdDUjJaOXpL?=
 =?utf-8?B?WnBiVVNtRW9VRCtuU0dxa0E1T1pqVXZGY3VDNndQbHZ0ZnQrdEhGODJkRStZ?=
 =?utf-8?B?em5pTVBHM0Y0VlZieTNXdzUrS3RHR1dNYXZyV0xsZG95REFER0VpRTlIQWoz?=
 =?utf-8?B?SmZ1ZTQ0Ry9hbTZUZFg1cU9GSTViampkTXppRVAxbWtuTkRzQkJvM2RvQ01F?=
 =?utf-8?B?TjlBdDF4aXpUTnlvODVVTjNPcHBPNGRuWllxZGJ5cFZCSWVhRUQyWGVOdXY5?=
 =?utf-8?B?WitWWnR5R1RFNThiWTJ0cWs4bTlWeVZaQkREdUw4cHhTWVdoYmJ1akFMbjJU?=
 =?utf-8?B?MUlEbW92bW9naHNKQTcwVk5LZ2ZMNDZtVVNvNjYwdUNyeS8yaWxNZTF3N1hV?=
 =?utf-8?B?VDk4SnJDbVBENjU1TTcwZjl4TkhKNjNuSWhSRGgxOWkva2U4YzdaSjFmQ1VC?=
 =?utf-8?B?NnNhSzVFQ3pwY1JjK0FzcG1ZYmFITkpqeE03OEdla2xpcFB6dTRFZWZYK0R3?=
 =?utf-8?B?dzNKTktKUDJSak9qRVV3ZXdtdjRZdkhQMVV3Z2I0UWtxV0dYMU8vUzRYejRF?=
 =?utf-8?B?cXhkZE5LbDVBTkRkR3o2cTdwUUlXeWJMSlB0QmgybFNFdVVmeFNVTlIvcUhI?=
 =?utf-8?B?RmhyRDdNR1FLR2htbmpyWG5ieWwwNzlhbENBRHI1WDUydkE0Qitva0lvT2h1?=
 =?utf-8?B?UHJBclpwbnRITTZxMHd4UDROTG5FSHNoWEIzVk1tMWorbTRRVE4xSEdVOWY3?=
 =?utf-8?B?WG9zbklxb2kwckhrbTB6N2g2SzJ5TDJWcFo2MmZWd1VwUFdEZ1l5VkEwM2Rt?=
 =?utf-8?B?TEEveU5ZcFE5OTl6bFBCNVRBUXdYdndkb0NFYVZJRUZ0RHQrRmRIS25LZjh6?=
 =?utf-8?B?UzVlMXRQbnpGNW5vTG9WOFJ5d1FnOTk0TlVRVVlLN2ZZTE9JTTRlQUxzMCtQ?=
 =?utf-8?B?Z1MyY0M3ZTg5a05wbjE4NlE1WWVzMzYyMlNJcHVyc1NhWTFoUm9NWjdmemJL?=
 =?utf-8?B?UWpIUGVnY1ExQTA4WVNaVk4xYkxWMjkyeDhtTVh6SzgwdjJDd2x0Z3hSUVg3?=
 =?utf-8?B?WHdWeGVHUDh6dU5TVVJxK1llakxEK08wWmRMV3ZzTnQxWXcwOVg5MG1TaXNm?=
 =?utf-8?B?U251b0hFZ01uclorMnVOTG5wQi84cWhSR0wrV3c0U2xvbUNETTAxUFdoVSt5?=
 =?utf-8?B?Ymgwa0hNdG5DUHppc0hkNmpqc3FISGorWlgvUUVDRHN4dnRNN0tXNEl5aHI0?=
 =?utf-8?B?SlJ3Zk9oNlhWVFhjbkdkaXo0OUViQmQ0R3d4Ry9MbytLc00zbXRpQVhKbWhs?=
 =?utf-8?B?R0x1QWV6QWs3NlNQMGRSWERHL2k2bXkwQURUOEEwNE85bTRPajhrdndXNHVx?=
 =?utf-8?B?RlNwVXlpZlFoeUhVOTdPajFYcTh0ZTNYZ1JZL0R1bEhWUkR1QWR1c29HNUFH?=
 =?utf-8?B?NnR3YmJkd095TGpDL0VVOC81V0dSejhhT2ZXdVk4bHNQOFdJTlErK3RaVzlG?=
 =?utf-8?B?MHMrTm9mbFdEL2VMYzNzTVordUw3ams1aDN4U2JJc0RMUWJDZ3V3ZjRzenNa?=
 =?utf-8?B?UDAzUkI3VzQ0eFNHU2Fnc0lvMlJtdUtTZGlVVlpGRkJwK2E2bGxNbWV1VEtn?=
 =?utf-8?B?V2sxMk1HRnluRGZadnBCVzVUa2tENEFRbEo4a2ZiQXBHaXlZdzViVVIrMm05?=
 =?utf-8?B?dGllSG91cHpGZEk5a3JIekdMQ1ZDbXpLMnE3WEJ1NFFPWllMSGhrOHdiK3hL?=
 =?utf-8?B?eEd4UTFYS2ZIdnc5OUlhK0xmbEZQZ0dXRk9OLzVTS05yRS9YckF1NE5NY2Fo?=
 =?utf-8?B?cHhwc2F4VDRnRDlueWcvN1c2WUpmWEdlVE5zeFgxU21QUjZLQndjek15em9R?=
 =?utf-8?B?amphWE5rQitaL21YOTVXQ2srR05vSlRYVlBCQ3MvUXhhV0xkdUl2bXNaNTVs?=
 =?utf-8?B?V1BURHpCS0Z2dThYa0NzaSsvWEViQmVzWUJaTUhmK3hwSHp0UVdzZXpGR29W?=
 =?utf-8?B?c24rZktxY2d1Zk4yZDhOczJ3ZE1GYmNlVDE4ck44TWNoUDF5c29haE5McUFS?=
 =?utf-8?B?M00vYVZjYzlTOGV5d2Z4WEJjanVNd29qUHRxcGU4QUNBc1M1V1NnT3B4T3JK?=
 =?utf-8?B?cmtlaUFTV25PSUlha3hmdy83MXpyL3J3djd2b1hoRkN3aGdlUXdxWWNWUXo1?=
 =?utf-8?B?NnJLdDAwWHo2UFpNOFcrT3hyOEVKME9lc1VWM1pVM3FKbGcrUFh4a1daOFdJ?=
 =?utf-8?B?NU5DNUlSNTBFbGxvOFJlbzZwaU5LSnRSUUlHMlBFbnlkNExzNTlWalhEVk1M?=
 =?utf-8?Q?/0RYmSdYL6ACQOm2zw7gvj80p7fV3zxMi5dHS?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b41e246-e3ef-43b6-4358-08de5a73d36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 11:37:44.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZ0mmtgCdwbtvlOMuafqow9A3BBV8oh28Df8Orm7At1r0/B0nF93/Rs64JGPqJ+4gPYq2ASSoOC30on0U2aFTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5560
X-Authority-Analysis: v=2.4 cv=F7dat6hN c=1 sm=1 tr=0 ts=69735d8c cx=c_pps
 a=OPAOkIGUrGl6b3ZAImYRoQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=8igKW0dhWjGb7ZBhlhMA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YbFMCJn3sH8Ci17_AaF90QzBpmGj5iS2
X-Proofpoint-ORIG-GUID: YbFMCJn3sH8Ci17_AaF90QzBpmGj5iS2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5NCBTYWx0ZWRfX1AoxBYUJdj5H
 NCLXv0uPVGv5Z8jCbk2IGV3IivpwngqWSSPMh6+dRjc6+9fpSrcPLJ/1sifSXOntlAhYqmSwhv7
 5ZyI3Hij/CSy0ZhJjMD0huFv+vfxay2wXsdPGxxwNNk9t6esr9uIRxCToQzJ1x/1zK0Cl7U7p3F
 XI4UZnO8B71VSN0W3mm04pElryKzx/mPLZIzh+PGfgyaMz91ncSvK3TO9fOsXAiOnATPDMUBfJM
 gX7gubiGVhy35JyX/1UtDneUj+TIBWcKN2h+Akz/mdy147n4y4H7mNF5b10C+BY9L8GnWOJJm9U
 wbLSCIJRSZbgSa43+WoH4o13EOwoEpmIZITY/D8k0sLVOOPLF3OW5ITm4tQHLt5jPHtJiRjPRmu
 Oj0okn5EGJbYBtMuwSIEl1en+Yz2hGuQy8JaIDfzGojcN3wbsurKpm19hYOpQ8sQSY53mhr5eaB
 jcbboS5705u529SSo+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252820-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,CH3PR18MB6379.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF3A075521
X-Rspamd-Action: no action

PiBPbiBUaHUsIEphbiAyMiwgMjAyNiBhdCAwMjo0NToyN1BNICswNTMwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiBJbmNyZWFzZSBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUgZnJvbSA0
MCB0byA1MiBieXRlcyB0byBhbGlnbiB3aXRoDQo+ID4gdGhlIGtlcm5lbCdzIHN0YW5kYXJkIFJT
UyBrZXkgbGVuZ3RoIGRlZmluZWQgYnkgTkVUREVWX1JTU19LRVlfTEVOLg0KPiA+DQo+ID4gVGhl
IHZpcnRpbyBzcGVjaWZpY2F0aW9uIHJlcXVpcmVzIGRldmljZXMgdG8gc3VwcG9ydCBhdCBsZWFz
dCA0MCBieXRlcw0KPiA+IGZvciB0aGUgUlNTIGtleSBzaXplLg0KPiANCj4gSW5kZWVkOg0KPiAJ
VGhlIGRldmljZSBNVVNUIHNldCBcZmllbGR7cnNzX21heF9rZXlfc2l6ZX0gdG8gYXQgbGVhc3Qg
NDAsIGlmIGl0IG9mZmVycw0KPiAJVklSVElPX05FVF9GX1JTUyBvciBWSVJUSU9fTkVUX0ZfSEFT
SF9SRVBPUlQuDQo+IA0KPiANCj4gDQo+ID4gSG93ZXZlciwgZGV2aWNlcyBtYXkgc3VwcG9ydCBs
YXJnZXIga2V5IHNpemVzIHVwIHRvIDUyIGJ5dGVzIChhcw0KPiA+IHJlcG9ydGVkIGJ5IHRoZSBk
ZXZpY2UncyByc3NfbWF4X2tleV9zaXplIGNvbmZpZyBmaWVsZCkuIFRoaXMgY2hhbmdlDQo+ID4g
YWxsb3dzIHN1Y2ggZGV2aWNlcyB0byB3b3JrIHByb3Blcmx5Lg0KPiA+IFByZXZpb3VzbHksIGRl
dmljZXMgcmVwb3J0aW5nIHJzc19tYXhfa2V5X3NpemUgPiA0MCB3b3VsZCBmYWlsIHdpdGggYW4N
Cj4gPiBlcnJvciBkdXJpbmcgaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBUaGlzIG9uZSwgeWVzPw0K
PiANCj4gICAgICAgICAgICAgICAgIGlmICh2aS0+cnNzX2tleV9zaXplID4gVklSVElPX05FVF9S
U1NfTUFYX0tFWV9TSVpFKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnZk
ZXYtPmRldiwgInJzc19tYXhfa2V5X3NpemU9JXUgZXhjZWVkcyB0aGUgbGltaXQNCj4gJXUuXG4i
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpLT5yc3Nfa2V5X3NpemUsIFZJ
UlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGVy
ciA9IC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZTsNCj4gICAg
ICAgICAgICAgICAgIH0NCj4gDQo+IA0KPiBIbW0gYnV0IHdoeSBkbyB3ZSBkbyBpdCBsaWtlIHRo
aXM/IEkgc3VzcGVjdCB3ZSBqdXN0IGdvdCBjb25mdXNlZCB3aXRoIHRoZQ0KPiBzcGVjOiA+IHZz
IDwuDQpJIGJlbGlldmUgdGhlIGNoZWNrIHdhcyBhZGRlZCB0byBwcmV2ZW50IG91dC1vZi1ib3Vu
ZHMgZXJyb3JzIHdoZW4gDQphY2Nlc3NpbmcgdGhlIGhhc2gga2V5IGJ1ZmZlci4NCj4gDQo+IA0K
PiBDYW4ndCB3ZSBqdXN0IGRvOg0KPiBtaW4odmktPnJzc19rZXlfc2l6ZSwgVklSVElPX05FVF9S
U1NfTUFYX0tFWV9TSVpFKQ0KT3VyIGRldmljZSByZXF1aXJlcyBoYXNoX2tleV9sZW5ndGggdG8g
ZXhhY3RseSBtYXRjaCByc3NfbWF4X2tleV9zaXplIA0KZm9yIHN5bW1ldHJpYyBiaWRpcmVjdGlv
bmFsIGZsb3cgaGFzaGluZy4gV2hlbiByc3NfbWF4X2tleV9zaXplID4gDQpWSVJUSU9fTkVUX1JT
U19NQVhfS0VZX1NJWkUsIGNsYW1waW5nIGlzbid0IHBvc3NpYmxlLiBTaG91bGQgd2UgDQpkaXNh
YmxlIFJTUyBpbnN0ZWFkIG9mIGZhaWxpbmcgaW5pdGlhbGl6YXRpb24/DQpUaGFua3MuDQo+IA0K
PiANCj4gSWYgeWVzIEknZCBsaWtlIHRoYXQgZml4IGluIGFkZGl0aW9uIHRvIHRoZSBpbmNyZWFz
ZS4NCj4gDQo+IA0KPiANCj4gSWYgd2UgYXJlIHZhbGlkYXRpbmcgcnNzX2tleV9zaXplICBhZ2Fp
bnN0IDQwLCBJIHRoaW5rIHdlIHNob3VsZCBjbGVhciB0aGUgZmVhdHVyZQ0KPiByYXRoZXIgdGhh
biBmYWlsaW5nIGluaXQgY29tcGxldGVseS4NCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gPiBU
aGUgZHJpdmVyIGFscmVhZHkgaGFuZGxlcyB2YXJpYWJsZSBrZXkgc2l6ZXMgZHluYW1pY2FsbHkg
dGhyb3VnaA0KPiA+IHZpLT5yc3Nfa2V5X3NpemUsIHNvIGluY3JlYXNpbmcgdGhlIG1heGltdW0g
bGltaXQgaXMgc2FmZSBhbmQNCj4gPiBtYWludGFpbnMgYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3
aXRoIGRldmljZXMgdGhhdCBzdXBwb3J0IHNtYWxsZXIga2V5DQo+ID4gc2l6ZXMuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
aW5kZXgNCj4gPiBkYjg4ZGNhZWZiMjAuLjVmMDZjYmMwNThkNyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMNCj4gPiBAQCAtMzgxLDcgKzM4MSw3IEBAIHN0cnVjdCByZWNlaXZlX3F1ZXVlIHsNCj4gPiAg
CXN0cnVjdCB4ZHBfYnVmZiAqKnhza19idWZmczsNCj4gPiAgfTsNCj4gPg0KPiA+IC0jZGVmaW5l
IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSAgICAgNDANCj4gPiArI2RlZmluZSBWSVJUSU9f
TkVUX1JTU19NQVhfS0VZX1NJWkUgICAgIDUyDQo+ID4NCj4gPiAgLyogQ29udHJvbCBWUSBidWZm
ZXJzOiBwcm90ZWN0ZWQgYnkgdGhlIHJ0bmwgbG9jayAqLyAgc3RydWN0DQo+ID4gY29udHJvbF9i
dWYgew0KPiA+IC0tDQo+ID4gMi4yNS4xDQoNCg==

