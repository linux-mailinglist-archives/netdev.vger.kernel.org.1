Return-Path: <netdev+bounces-246489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD34CED247
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 17:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 728413004428
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6148A238C08;
	Thu,  1 Jan 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FrJtoU0u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2930145FE0;
	Thu,  1 Jan 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767283488; cv=fail; b=EaAnfNCfK4nreS+Mvj85vlT3hvQ1YV3OJajsg9J2GmjVTEmZEgUYZZ24lvhBeyB7dHoJSX7g1com8XcRdYOx2OA60dxurPJ/xlcxjolOXye7WBSCx/nWazN0akJKJ5fk4lxS79S4lGQQOYkA0PeChTLZ4XVmLQgVUBbBFGD/UeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767283488; c=relaxed/simple;
	bh=o7GHoJ6/ud5+HCUz8AfybqYtuxjAdnnATd6utH4+wQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ndHnjiOW0m+vvo4hlzI2CaWZ4EJRo8uO14zWnENxzhVJH7+j+VbkZhVun3yw0RJCqruT/oYYdFvKuMcyNKvUIFnLnquIom7cGNsVQq5wpYlrp+T5M8Jw4ezC3YGacZibMTgEPwRJCgF5jgiG+etinUMWEdYiIjH1u/hB/HnnCWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FrJtoU0u; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 601FwX3H3474368;
	Thu, 1 Jan 2026 08:04:16 -0800
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023078.outbound.protection.outlook.com [40.93.196.78])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bcgxekhy9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Jan 2026 08:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LljWYaDRZ6N/XuhT9jw+GNlNu+QY03gKrGFUwLF//IA+tXREhq67umpRmMuWbzVTypcMGHZzQTpl2Si4l+6AoC+DwPcNhI+lpCHz/Z46c6bm/Y+6f7diDxDJCf8m/ITFPcLh+gvHHnpFvLcLoP67ou2wKJ1CU2s2Cx64yYTv+HhDB6BA+TZ0WuKo6GP6Pxm1uvOwQk/qYNOCI7ff3NJeFxKhiT264KYqm3JKU3EO+GjSt9u/FFNT8uP7jBoeLIIuxbvK01b8fqVlqJJyy1MqKYKEFNlpzGZv3NF5Edxy5Lkiq/Ea7a39GFnniW6mlMLssQR+A/Hu59rNL5zE75GFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7GHoJ6/ud5+HCUz8AfybqYtuxjAdnnATd6utH4+wQk=;
 b=ms6Jx5PES2nrcZmXO3idwLu90xXh9y4u7OAL4YJAum9DrEN+OpNLOb9GnhRbUB/LYAk3O1Y8Ql6rVtN6tRaKZg3AaUW6/U9W5xcKqT2FT3+gTwm4SZMIkC03Yswfj0vU+WVmhd8fkQh52kaLFn1V6YXRpI6mXbY94s3cLIFpcBa39QewxpYAYbfZHlOp2GjB0uRruAfF2FXqCf1Ra22yzF+8jbdaHPGX24TWcRqsPQsud4y0UMwFHbQoPKYO8P6WSNspsV78P+sRVrYBJ8Va4tmtUP9NXWF/ULzRSPChASctWNMJq1a49dyXA0ihMGek1bs+fY82ddK2oIbhdjlTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7GHoJ6/ud5+HCUz8AfybqYtuxjAdnnATd6utH4+wQk=;
 b=FrJtoU0uHVoCzjZMe7Wg9Sz6VLFd9sBJcbk0YoMZK+oWkSaTK01j7KNtogg8yal9cEsWaXg0MwWbR91vtBdo0FHWCC6zF+GN5NY9Okb1gBToCDUXZeRVEs7AWB0/MB6z3eNsQb8cwR0bIKie1h/rnZ7iD+/UoKxSFU+1+9n5PaA=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by LV0PR18MB927483.namprd18.prod.outlook.com (2603:10b6:408:345::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:04:14 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::dc04:c5c6:6e8:53de]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::dc04:c5c6:6e8:53de%6]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:04:14 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>,
        Felix Fietkau
	<nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        Sebastian Roland Wolf
	<srw@root533.premium-rootserver.net>
Subject: RE: [PATCH] net: mediatek: add null pointer check for hardware
 offloading
Thread-Topic: [PATCH] net: mediatek: add null pointer check for hardware
 offloading
Thread-Index: AQHcezhGLbGxw9X4jEuX27Igy1wzFg==
Date: Thu, 1 Jan 2026 16:04:14 +0000
Message-ID:
 <BYAPR18MB3735AF774DB282E5744018E1A0BAA@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20251231225206.3212871-1-Sebastian.Wolf@pace-systems.de>
In-Reply-To: <20251231225206.3212871-1-Sebastian.Wolf@pace-systems.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|LV0PR18MB927483:EE_
x-ms-office365-filtering-correlation-id: f89d3fa7-f73b-4c78-dd59-08de494f68fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzFRUW01SjRQV0djcmdhMktsRkxQV2dhSGRTRXMwY2h6WG9hVmMzQ3krenhl?=
 =?utf-8?B?YitHb1RDL2phNURmNEd3TDVQTkY5Vysvanc5SjhwSkJrVnBWWklGMWxWbVBV?=
 =?utf-8?B?WkUrZG5YYk9OaW4wTG1uN1h1eEZHWnJQSndzVXRNOEk4Ri9VcnF5WFY5dFZw?=
 =?utf-8?B?Z08vZUpHYm1xMVRMTzVzU3hvTWtNN3pZZ3ZMcTY3VEFzUDBtclZ0c0lhVHpL?=
 =?utf-8?B?dTUyRkVSckdxT3g4dW5lNWdoek85dmZtTGdHaEdxMjgxOWhGT21IRXpaa1ZZ?=
 =?utf-8?B?QmV0V1Y5YlRQT1pDWmk0NDdzbVFUeU1WTEcvNVlmalFNNmkwTDduUlY0dUFz?=
 =?utf-8?B?V016VVY1cFNIM0FNajNrazBqK3ozVE1xMk1PUDg5bFR0cVFRVjVzaEs5azlv?=
 =?utf-8?B?bm9hK1EwUDg3RmZVbmpUUDFPNkFuOWFLQUJTeTRBU1ZveWZYRFpDMWY3ZURY?=
 =?utf-8?B?M0VmK0dMaUZlbHhEUjY0YUNFR3ZjM2NzSUFrSVlBdnNzTDl3UExHZHkvZlVj?=
 =?utf-8?B?TUY0M21BTHNKaWYya3BaL1ZhdU1pQ3VHQnFUdlpreVdTeFJ5ZzZTYnNxbTBY?=
 =?utf-8?B?UThnenZVODV1SllpTXZwbXlBWTM5bStLY2NqcHlmaTd2SjhJcmNnZjdqOFJm?=
 =?utf-8?B?a1E0K2FBUThPVC9rclF4enVBZ29rWWMvTFFoc1l4dUJhdlZVbDVCOHJXSmNa?=
 =?utf-8?B?alVseGtKN3gvamlFZEZzQWZDZUo5M0tMb09nVE5aRzlZY1gycFRrT2VyaFhz?=
 =?utf-8?B?cW9xTzRzZkl2aHN6NHc4NUY3WlFZRTVtd01GcWo1WkFsb1BsVU5FSmZ0MWw3?=
 =?utf-8?B?RWJuUlZJSENZLzhXWXlMSFdxRG40T2tyYkp6NWtDQ0d0ODVtR0tVVUdXM0NV?=
 =?utf-8?B?N1RGbnB3Z0x6LzZhV0gzVkliMEc2NkphaHNBRFowVXlHaE5LMnlRNlhuaXVX?=
 =?utf-8?B?bjEvb2N1UGRNYVgrOXc4OUVEQmNHcnFFbzl0TUhJcHdwcktvT21ucjI5bmQ0?=
 =?utf-8?B?eERjRDBJcUU2RjZybTdMWlRGU3dRaERKR2VESktaalRMZkFQNjVJZDZuZHcy?=
 =?utf-8?B?U1c4ZkRDSjdxdmR3NXlVczF2dGs0TlJJMHpLWUtxMGNXZW5yWDQ4cHNEd05l?=
 =?utf-8?B?Y2dHZnBmZ0J6b2dXdVk2NGVSQUFJWmhFYndaTXhEREJsZlRoc1ZhNy9QN002?=
 =?utf-8?B?M3FzVkorYjM3TG80NTd2UjhrTituVlU4clVROWI4M3o3a1BkVHorSDVXNUtE?=
 =?utf-8?B?bU8vUVJUa1VIODVkSWREclBkc0pNSlNEdDd3aDVCbHpTcXRLdXFhZkJhUVFj?=
 =?utf-8?B?SWMvSkhoVnN5ekdSZ2pGSnpTeitBUG90L3JJTzFpeUxxUkZha2tTRW1zQk1N?=
 =?utf-8?B?dGtScWJmK3QwbSszSXFibzRGSFNIc2dBVkFWYm53OWR5M05pazRwWXU1VnZ1?=
 =?utf-8?B?aWdua1d1d2kzaFZRSUtEaU5oUXJBbVhxaEx5UDh1OC9FdlgzWmZZcmgyMm9q?=
 =?utf-8?B?NlREcHB3WFBwK2tlOGUvclp3T1labXltRkx6S3c2c3hweDhySE45SEdBemdT?=
 =?utf-8?B?NThBZkI1TGNWUWwzY0EyREpRRTU0cHg3LzFDSit4bmp6OC9sR1RUaWhSYk5X?=
 =?utf-8?B?RDJTRUpUV01qbWVUQUxaT0hiZTU2Wlo1V0lVQVdya0dBakZ3eE0weFFiTDg1?=
 =?utf-8?B?eG5ZYlNVWm41VlluZktYVXJNdGxSTDhFL3JHS0RsUDFRcnhpRGM2S3BKNFVR?=
 =?utf-8?B?aTcwakZza21seDdORmVIRWxNeXF6MlA2cFNuTEs2QzdBR2dwL1hKNTlsK21t?=
 =?utf-8?B?WHREZ3dCR0MrWWs1N3dRYjUwS2RlSEdScnpQVUI0ZmtsMi9SY29MN1N6WDZG?=
 =?utf-8?B?Z0pYYkZYTGlodjhWU0Yya05qditlZENpOTZNNW9BMGF4V3d1K3lEMURFK0pV?=
 =?utf-8?B?OHpHRWxRV3I3L1lkdGp5YnIrWFJUNGJCZXV6VjJvSW8xMVl4S0R0UzN2K21U?=
 =?utf-8?B?Y2hWbnpIZWJ2SmRVRGVnb1ZHaHc0akhNald3cENqMWsvQytmZmtOejBVRG0x?=
 =?utf-8?Q?ZS/CGU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amFkT21NemlVd0x6SVY3alYzNHhmL09TUm1IRnp6bXdBcitPMS9aL2ExcE9T?=
 =?utf-8?B?clU0LzR3MVpOOFFnNmFFTGQwTjBHSGQrZXZRSTlnZ1RYTXFBd2dpaE9YQW5F?=
 =?utf-8?B?Z2lqbFdKMnBjZmpLTzdiWUd0eHBWUkt2RE1HdmxqSU0xcDA0VlI1M2tkOW4r?=
 =?utf-8?B?U2xtb3JTVGFxVlV6aDZBc3lHNlZLZW1KRHBvOGVlYXFSNEFXblF0VnpyUS8z?=
 =?utf-8?B?YlZsWnFQbXlOVmRIWnJWVUVRMGpmK1hnMi9RcjRydzI5Mk1PWnVmL1hDaW53?=
 =?utf-8?B?WXVJNHRKUmduVDUrKzh3c2VpYTBwd1VTK0FRNHNObGNvQ0hYK3lWZHArSGpH?=
 =?utf-8?B?T1ZZbGQ5Y3E4czhWRmt5RFVDdzJxMTZIRVlDdGtYZFpPNFJKdW9DMjZwTXBM?=
 =?utf-8?B?akZUNEN3KzhYMTFxWW5xNTdrZEdtY0E1TnNlcXdpTWhsK2hZRmtVSUJMVFJP?=
 =?utf-8?B?WW5iUjRDQjlydWd0NWV5VFZqU3ozMzVZdk8vY0IxdTFmbVMrMkxNeFBhUFh5?=
 =?utf-8?B?dndiMUpuVjF5eVZUY0IvV2x5MlBKWUxkNC9HY0pRWXFERnBTZUNGV1M1bnZz?=
 =?utf-8?B?TndYd2hHWnJObHlpaGl6ZUlIUW9zRzdTb1hOdm52YlBYTGxSR28wKzU0L2JI?=
 =?utf-8?B?dGllZkpzeVYzQ1Q2RWI5K2kzSm5NNzdjTHEzY2Q0OC8vSEh4VlZFejBpOUkr?=
 =?utf-8?B?UmpaTjdyV3M4NUt3eFBrVVp0OXpObkx2WllqMk5PQmdoU3VadFhyeW5QbjNY?=
 =?utf-8?B?anVuRnRmam92N0tRaS9tK1VKK3VsdWhLd2RsZEV6UXVreko4QzZxOEs2MVMx?=
 =?utf-8?B?dXdGSzJuMGkyOU9aOVhuQUdEZzdMZWthUVVVVEhWbEpBMUMzY1NheGQ0Njl3?=
 =?utf-8?B?KyszSGQvR2NpdStPMDdmNkNrVU96Nm91Z2hvdHBLc2ExTjRoUmlyTWNCTG8w?=
 =?utf-8?B?a3pCWlFyZzNXWStNS2FDS2UrVkQ1VFVsNWpxK2ZNUjB2VWREL1k3SGQ2cjNM?=
 =?utf-8?B?bGtnM3RFU1dmMk00elRBZDI4SkxwRWc5SEM4cDFJQU8xbkxGZGpaZXN2MnJS?=
 =?utf-8?B?ZGxqYjE5WEtrWURLbmlIZ1d5MlBzb1RGZWFZcTNpb1pzeGNjT2R0dXhwVmNa?=
 =?utf-8?B?ZDE2THI2R3d6T1J1ZnM2Y0puS2JTQ2oyL0pqRzMrNTNqNi9TYXZoTmtLTE9J?=
 =?utf-8?B?dzFQd2xaNkdBelNtMStkdUVHVUZHc1NIZ1hyVVZYc0c4M29pTVU0TURMb1py?=
 =?utf-8?B?U3k4QUk3aS9pZHpqREpLamlMM05pOGJZUWV6dmpGVStkNWVjdGVWMm1CM1JV?=
 =?utf-8?B?QS9JeFNuL1IwMmVXSGFmVEZ6VkdwMitFM3U0aWUrRDArSXErcWMxaUo0cE9W?=
 =?utf-8?B?YUhnaTJRenRVMHNCUUZoeU1tRGpISjB6djMwNmhBKzUxb1l4Nkd5UFR2bjZq?=
 =?utf-8?B?clhBY05rT1MxTWpUUzg2U3dDTVRyV2hpakcyUHN1L1RteTNEcTUxakhHdTBu?=
 =?utf-8?B?dURIanJxQXdSUVoxbUlJb1lJZlNTM1FMNE05YUtkaDg5V0ZMSElUUnIxd1VI?=
 =?utf-8?B?UkM3NDR6dnJPVVZTVW1iYnFRRUhNRW1RdkRIbGY2Ky9walBBSlZPbkw5bjRJ?=
 =?utf-8?B?b1N6VDRlRjJYRFJURVZjc3NrL1gyWFdFcWwwUkF0NmNBQVY3dlB6VEdVaDg4?=
 =?utf-8?B?L1hEbENkTkZVejZJMzdmOE85N1dYM0oxSUJHaUxEQjYzcitKTU1Rb1FHMW01?=
 =?utf-8?B?NTdIalZIQS9PbGRSakRYbGIyakRkWkI5bzhERk1XdHFqMjR2SGFuNGhNSGZQ?=
 =?utf-8?B?RzhuMlphUllEaFl1VVRIVUk1dk8rQ1VJRy9UMDJZdEVTd3F2UGMwTFhCUGRC?=
 =?utf-8?B?WFlscWtxUkNZVHB1ZTlrcXhlVXBBRmYxSHk5bEt5eUg5YUZ4SEt2N215TjBP?=
 =?utf-8?B?Znc3VitYZS9DVHNHM0c5QmV0Z21xYnBITnZVK28yYmNybnduY3U2dmVFUmh5?=
 =?utf-8?B?ekVidDlpejBsUnFZU0hSNHdoeForWXV1QzNYVUd1Q01JNFh5cVNBSXRnRGFk?=
 =?utf-8?B?TUZsWHMvSWhTL252bTREbFg3Q0J3eFNJYWZIbUFkYVVKMFBNTmpQOUVDWU1h?=
 =?utf-8?B?TEJFVEo5TXZPT00zbXpidGhRbldSQlFVS25wRHRobDNMUjc1TWtuTFJkRlJv?=
 =?utf-8?B?VWExQWZIaEFUSU8ycDZCb3VUQUppV1FYS2Qxd2xLUDN0dTc1VWhFRWc3K3V0?=
 =?utf-8?B?cVZLWlhBbHV2cU5CYVFHTndtNnFqNnJORmVZa2xPazJvUmtUNnlESVVZblJM?=
 =?utf-8?B?SExwS3hMbGRRbWlFRlk5Y0VWTGVONUxPT1c2T1ZFTDlqdlVEM1h0b0RQRjBY?=
 =?utf-8?Q?ySS6LYOseSbzHNRdkQxdNV/CiA1c8JIYL0I0JQy0elqPd?=
x-ms-exchange-antispam-messagedata-1: KOiDwHmGtJhmXA==
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89d3fa7-f73b-4c78-dd59-08de494f68fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2026 16:04:14.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6R5bNQcyUTEat8smomJXjUwTQt7apeAioO1kMKHJxq476SJOP4tSfN3TfaIOl+Y6r4mejk/pYQBjf+GnSRaSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR18MB927483
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDE0NCBTYWx0ZWRfX3V2FcCWeRcHj
 e8evIxqKuxtsiILf7T9Tsr2/aOnIIec5RUEw0eyo/jNyTWR7GXVIHZdT5cb/du5gMNNyazvoKPY
 jTXIl6ChkAoXFcJc/QB4K4ruFcJPjPyncma4zPqISPtXZAiEm00XZwv7MdnPh0CKX98TxSeeEAW
 tcS+SAGFJs2sQPgGsFR0s62fh3A37Hpguk6yLjMs+VaQf8wahEYimvpELfoYB6WLXbSw9kTKEMS
 lTIQx2ey4vnmj+XN//HMbd4wS47Q7nt+6TihrCKEPO72f7epR9m2XsIXavFCnU8G5Wd8fdpSo8E
 TCvy/4GejxHjmTlXDNA7axg2OvNQpxqMgff/q9szDH7Z7xNQqMY5If6f04L2gXL3W4zKsdQsAf6
 qEJbJpR1uDaI2aKepCB9rjl46iKM6jd5yGZ36uz8DQ5gjanaQzHydCKJZPNvjy0oHUA13htLom7
 9kz1+Fg6Dt7vhT860aQ==
X-Proofpoint-ORIG-GUID: d_EmbeYTU474fhbT4EGUKzr42Ww-qpUU
X-Authority-Analysis: v=2.4 cv=GM4F0+NK c=1 sm=1 tr=0 ts=69569b00 cx=c_pps
 a=qh32Q7XyPXPg99od4CZmAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8
 a=JfrnYn6hAAAA:8 a=FCGJUuXEAAAA:8 a=M5GUcnROAAAA:8 a=rcom-R4f4X4EVwpdamwA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=V9HjTtw8RXE02ORq8uQD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: d_EmbeYTU474fhbT4EGUKzr42Ww-qpUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_06,2025-12-31_01,2025-10-01_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYmFzdGlhbiBSb2xhbmQg
V29sZiA8U2ViYXN0aWFuLldvbGZAcGFjZS1zeXN0ZW1zLmRlPg0KPiBTZW50OiBUaHVyc2RheSwg
SmFudWFyeSAxLCAyMDI2IDQ6MjIgQU0NCj4gVG86IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFt
ZT47IFNlYW4gV2FuZw0KPiA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT47IExvcmVuem8gQmlhbmNv
bmkgPGxvcmVuem9Aa2VybmVsLm9yZz4NCj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2
QGx1bm4uY2g+OyBNYXR0aGlhcyBCcnVnZ2VyDQo+IDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPjsg
QW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9A
Y29sbGFib3JhLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LQ0KPiBtZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOyBTZWJhc3RpYW4gUm9sYW5kIFdv
bGYNCj4gPHNyd0Byb290NTMzLnByZW1pdW0tcm9vdHNlcnZlci5uZXQ+OyBTZWJhc3RpYW4gUm9s
YW5kIFdvbGYNCj4gPFNlYmFzdGlhbi5Xb2xmQHBhY2Utc3lzdGVtcy5kZT4NCj4gU3ViamVjdDog
IFtQQVRDSF0gbmV0OiBtZWRpYXRlazogYWRkIG51bGwgcG9pbnRlciBjaGVjayBmb3INCj4gaGFy
ZHdhcmUgb2ZmbG9hZGluZw0KPiANCj4gRnJvbTogU2ViYXN0aWFuIFJvbGFuZCBXb2xmIDxzcndA
4oCKcm9vdDUzMy7igIpwcmVtaXVtLXJvb3RzZXJ2ZXIu4oCKbmV0PiBBZGQgYQ0KPiBudWxsIHBv
aW50ZXIgY2hlY2sgdG8gcHJldmVudCBrZXJuZWwgY3Jhc2hlcyB3aGVuIGhhcmR3YXJlIG9mZmxv
YWRpbmcgaXMNCj4gYWN0aXZlIG9uIE1lZGlhVGVrIGRldmljZXMuIEluIHNvbWUgZWRnZSBjYXNl
cywgdGhlIGV0aGVybmV0IHBvaW50ZXIgb3IgaXRzDQo+IGFzc29jaWF0ZWQgbmV0ZGV2IA0KPiBG
cm9tOiBTZWJhc3RpYW4gUm9sYW5kIFdvbGYgPHNyd0Byb290NTMzLnByZW1pdW0tcm9vdHNlcnZl
ci5uZXQ+DQo+IA0KPiBBZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8gcHJldmVudCBrZXJuZWwg
Y3Jhc2hlcyB3aGVuIGhhcmR3YXJlIG9mZmxvYWRpbmcNCj4gaXMgYWN0aXZlIG9uIE1lZGlhVGVr
IGRldmljZXMuDQo+IA0KPiBJbiBzb21lIGVkZ2UgY2FzZXMsIHRoZSBldGhlcm5ldCBwb2ludGVy
IG9yIGl0cyBhc3NvY2lhdGVkIG5ldGRldiBlbGVtZW50DQo+IGNhbiBiZSBOVUxMLiBDaGVja2lu
ZyB0aGVzZSBwb2ludGVycyBiZWZvcmUgYWNjZXNzIGlzIG1hbmRhdG9yeSB0byBhdm9pZA0KPiBz
ZWdtZW50YXRpb24gZmF1bHRzIGFuZCBrZXJuZWwgb29wcy4NCj4gDQo+IFRoaXMgaW1wcm92ZXMg
dGhlIHJvYnVzdG5lc3Mgb2YgdGhlIHZhbGlkYXRpb24gY2hlY2sgZm9yIG10a19ldGggaW5ncmVz
cw0KPiBkZXZpY2VzIGludHJvZHVjZWQgaW4gY29tbWl0IDczY2ZkOTQ3ZGJkYiAoIm5ldDogbWVk
aWF0ZWs6DQo+IGFkZCBzdXBwb3J0IGZvciBpbmdyZXNzIHRyYWZmaWMgb2ZmbG9hZGluZyIpLg0K
PiANCj4gRml4ZXM6IDczY2ZkOTQ3ZGJkYiAoIm5ldDogbWVkaWF0ZWs6IGFkZCBzdXBwb3J0IGZv
ciBpbmdyZXNzIHRyYWZmaWMNCj4gb2ZmbG9hZGluZyIpDQo+IG5ldDogbWVkaWF0ZWs6IEFkZCBu
dWxsIHBvaW50ZXIgY2hlY2sgdG8gcHJldmVudCBjcmFzaGVzIHdpdGggYWN0aXZlIGhhcmR3YXJl
DQo+IG9mZmxvYWRpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gUm9sYW5kIFdv
bGYgPFNlYmFzdGlhbi5Xb2xmQHBhY2Utc3lzdGVtcy5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWRpYXRlay9tdGtfcHBlX29mZmxvYWQuYyB8IDMgKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX3BwZV9vZmZsb2FkLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWRpYXRlay9tdGtfcHBlX29mZmxvYWQuYw0KPiBpbmRleCBl
OWJkMzI3NDE5ODMuLjY5MDBhYzg3ZTFlOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVkaWF0ZWsvbXRrX3BwZV9vZmZsb2FkLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVkaWF0ZWsvbXRrX3BwZV9vZmZsb2FkLmMNCj4gQEAgLTI3MCw3ICsyNzAsOCBAQCBt
dGtfZmxvd19vZmZsb2FkX3JlcGxhY2Uoc3RydWN0IG10a19ldGggKmV0aCwgc3RydWN0DQo+IGZs
b3dfY2xzX29mZmxvYWQgKmYsDQo+ICAJCWZsb3dfcnVsZV9tYXRjaF9tZXRhKHJ1bGUsICZtYXRj
aCk7DQo+ICAJCWlmIChtdGtfaXNfbmV0c3lzX3YyX29yX2dyZWF0ZXIoZXRoKSkgew0KPiAgCQkJ
aWRldiA9IF9fZGV2X2dldF9ieV9pbmRleCgmaW5pdF9uZXQsIG1hdGNoLmtleS0NCj4gPmluZ3Jl
c3NfaWZpbmRleCk7DQo+IC0JCQlpZiAoaWRldiAmJiBpZGV2LT5uZXRkZXZfb3BzID09IGV0aC0+
bmV0ZGV2WzBdLQ0KPiA+bmV0ZGV2X29wcykgew0KPiArCQkJaWYgKGlkZXYgJiYgZXRoICYmIGV0
aC0+bmV0ZGV2WzBdICYmDQo+ICsJCQkgICAgaWRldi0+bmV0ZGV2X29wcyA9PSBldGgtPm5ldGRl
dlswXS0+bmV0ZGV2X29wcykNCj4gew0KPiAgCQkJCXN0cnVjdCBtdGtfbWFjICptYWMgPSBuZXRk
ZXZfcHJpdihpZGV2KTsNCj4gDQo+ICAJCQkJaWYgKFdBUk5fT04obWFjLT5wcGVfaWR4ID49IGV0
aC0+c29jLQ0KPiA+cHBlX251bSkpDQo+IC0tDQo+IDIuNTEuMA0KPiANClJldmlld2VkLWJ5OiBT
YWkgS3Jpc2huYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+DQoNCg==

