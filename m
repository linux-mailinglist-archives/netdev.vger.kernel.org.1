Return-Path: <netdev+bounces-269386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ClZDBLLu2leoQIAu9opvQ
	(envelope-from <netdev+bounces-269386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:08:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AABA2C93CF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 651B43003837
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F61186E2E;
	Thu, 19 Mar 2026 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LXhl6H2+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D43B531B;
	Thu, 19 Mar 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913210; cv=fail; b=ivsg2sUDIPGvWQRayfU/1IH5MTwBu19YW6fFXry4oWjOHWeIosbXFksznDQN/PkFpUko4JVxhJgAGel/sSLa1oDQHo2nNApMzrhr07AXVFKXCTsM8Lf6GZ9ORzEspJ6nTkrKtYOZ1oF9jMnnGiQarf2EXZwnj5VZyJ4ggeadxIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913210; c=relaxed/simple;
	bh=gUA2QfShXDH+MgZlhfodDsXejtyBuBi8oFp94qa0W7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PScUlo3/A3V1+n7RRkbv9k4VaZhTtK205uL2RqPOok+UV0ZySB8b/4Iv2ix/AbCy0KMI7QCR4tY9Mug+pLq/kG2mmloNpnaJxoMm5WQmSTH2XXy1x4JmZZF+VZ9FQGzhTRabBwMMk6dLGQ+YGu3Jh3K9Ie6I4Wn3997NDshdpFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LXhl6H2+; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4wGuV3368364;
	Thu, 19 Mar 2026 02:39:43 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023077.outbound.protection.outlook.com [40.107.201.77])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d05tf936d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 02:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3k40kKgu9XhSVDPSQTYdWVRTDpXR/MtufbNkSQbblhvs8FZnNZR5NH48l6dZdDwqXo1bev9C7xqWy6uy8GOxmzIXmbs64e80nEOEs+DNWBZ4X27wmeJHUC+1hHwzh3m5MA5DHsX49VznonSslIv4HSEUIWDiEYvCnBCtKZMYdCzwRsK3h2VU/b6ECbTlWAotLxkLcqjD+RuKulbgUB97/15KpKFf1yyD0OS7Nw3tSH7u4sMwtf9kryAb/HkcBmmBy7FupOyajbvz4jUcLHXYeOs9AWhaInXbaTIFcapsK0QHNE3BlYID0ANfEm8db7XSbO2BwfpMO7ZoM6SOl4KwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUA2QfShXDH+MgZlhfodDsXejtyBuBi8oFp94qa0W7M=;
 b=ealJXRh2LlhgoQCP3EB74EpwYu1a5d+lQ0waKJ0Rhl156fWvLWJGtBwXKeiVOZJrrbbpuip6MUXMb/v7/Axx0FCB44+c0xquQTH+8bSg97IK+7xwGEb0zJswUz7Yw7Owc/RozLkgcFqfeH6Ebaom4SoLUGKLvMoocdYUIaglfk9Wy4ZReYqWjFbmUWgHAsNEqKRtt3GTTrkhR3kYmCJNVfhDQK2kwjF3Tweu1a8VLGUFNC3sLt648omTlwVz0bqM6Fkg688GWW7AZp7JJK/gKW30dhC7jVPTTDqdohMWdOzgIRYkAytkiwL6oM4HJyyUPqkMnG2dgMm3VvNA0io3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUA2QfShXDH+MgZlhfodDsXejtyBuBi8oFp94qa0W7M=;
 b=LXhl6H2+k8qopGMCajuIQcAp/bdmMYbuFbJMnQGDkS6nc257NBDay//ZDZph1aeL9KqliBhvNCetkyKxJhTJAc4Q5PFUQtTZ6ELvhZGpRrs0/JzkdclQoNysAvQtGYIDPpf59/iqw1Sgk+4UkjZZZv79orT0QH9Rtg4lpPES//w=
Received: from BL1PR18MB4248.namprd18.prod.outlook.com (2603:10b6:208:311::15)
 by MN2PR18MB3624.namprd18.prod.outlook.com (2603:10b6:208:261::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:39:41 +0000
Received: from BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::2f85:8970:a4bf:7404]) by BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::2f85:8970:a4bf:7404%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 09:39:39 +0000
From: Elad Nachman <enachman@marvell.com>
To: Rosen Penev <rosenp@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kees Cook
	<kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\\b__counted_by(_le|_be)?\\b"
	<linux-hardening@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] net: marvell: prestera: use kzalloc_flex
Thread-Topic: [EXTERNAL] [PATCH] net: marvell: prestera: use kzalloc_flex
Thread-Index: AQHctwxx5BpImjZvo0+VcYkE5ffzabW1mfhA
Date: Thu, 19 Mar 2026 09:39:39 +0000
Message-ID:
 <BL1PR18MB424871659ABDA646E7FE2718DB4FA@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20260318192111.6802-1-rosenp@gmail.com>
In-Reply-To: <20260318192111.6802-1-rosenp@gmail.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4248:EE_|MN2PR18MB3624:EE_
x-ms-office365-filtering-correlation-id: 607c587b-a3c4-4a11-1bae-08de859b70d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 llOVHMgKBpq09FdaUCe/9tykzrJsE4qNQUEtre/4lAhglkXmRTMgXJv8WqurOj3agtcU8qT7k2LAjIaPg+lgDpg2UKApvv/sPCA0F5by24xX18Yh9W0NdupP4Nc61p3jH+xWIemaPaj2R68tXByD+IYs7gjeLRoTQ9gMz0hXqM1y4NNGYIEgGHPRpJ0uSH3znAbv5gGuQn2JJIXimAHMDqpbOverfIU50cKYeTfeQaFsFKGpfAyVGOtTtAzYiC+atXvhE+Fohlm2EJV0TxGAU5WGDOyhDJWw4tExDkIbyq0BoipYDTfhh/z5oFln4j1ERcwR84865/eLjeNYO3HLXVkxz/G2BgZTcDPAcBXy3gAW7geDVaKNGmWs3B/gVugR1nGyA+/So8dxrHkJeWukOi+lzAs8MmTzVikNF137xn4hCZ9K+m28vYJKhEYFLuk9pk6cNPO/fqWrr0fUCuLzHnXcqemgwbC7/yyRJswf9IMgxoidH3ZR8ZGEWI5f26nM/2FWeSk/wLOu0SbyZfhJYaGPr4j0FGtmmw5SVmbteCZ2hH0N7KCFumWr8cY/i76JERwZ6ckN+XDx324hjBhmF0hTJL15WouDY+xs0/REBzM2Zr6TN/Xgz+/kl7ARYiE9v3yFB3jEwxg/9JyobcTDFLy8aUt0zErhq7WWpuntxdymzlWNAF1bG2YOlQkbHG/nlUWFksSjssryyq7RhqD4NzkRbzQ2C8HnDT48rMQlwO5wwno8S/Xg5nuvj6hLT147Pa+IUknPRdb8V9afYyJGtEUPuGiGUyE0nAUkh6L9sxk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4248.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXBLMzBrVFRxQzZuVm1CL3BiZ043Ty8zT2pxeUxMSlI4L3FvRGpmbHhKSm05?=
 =?utf-8?B?K2s0b3V3SDFlbldROStZRWRJVXNLd05vdDVUQ09vQXoyWFNUSUNtQnhXSjhx?=
 =?utf-8?B?UFF6TUs4TUFDUkF6ZGREc2ZkbTJUVndIZ1Y3SE1DTDBtcSsySCt6TGxMM0VL?=
 =?utf-8?B?TnhuTjdCenJlcmZQQ1kwMmQ3T3dXOHN0NmY3K3A4RnpXdGNUNTJqY2hRQkJs?=
 =?utf-8?B?NzVtN0VnMGo5ZGw5RHk2aTVoY29NN05FUlkrbVNVYkVIVHRNek5IUkRIbHFy?=
 =?utf-8?B?NmhTTE9xcUI0U3IvQ0FCYW92eXdEZGticjNhSE5aZzFaMnBmTEpJRVVnM3VD?=
 =?utf-8?B?RFN2VGYxUUxWUHk2RUw0Tzc2SmtuRFNGU01DVWpuejBGWnlCbzRnTVl6OU41?=
 =?utf-8?B?ZE9keXo4Wkp2STFyb3E0NzZ1Zi9FSGVlNzY1L0tDZG02cSt5MXpxK1BIYi9C?=
 =?utf-8?B?ODdtc3FaMjQvTkU1NG5mWkxwVng0Q1NjSE1hYXB1RHVFQmlHMlQ5UDlBT3pS?=
 =?utf-8?B?bG1NdFlpVmVuMVFJY2JCUmQwdEJzdjQ3SThXLzFoTzBsd1lRUU5SRlduaUdX?=
 =?utf-8?B?b3M1OE1lOE9VYUYrUU1yZ1pURDJCU2puUFBpOHlhL0cxMDZFbkUvYVpWQ1lm?=
 =?utf-8?B?WEUwMlRWSVNQZWVDZ29vRTFiTlhhWEJER0pENVoyT3g2TDYvU01WRGZnY3FX?=
 =?utf-8?B?bVA1KzBtN3RRVURKVWtiYjYrMFBkN3M1NWptamlqNmFDNFU3OHlsOVQ3YkJh?=
 =?utf-8?B?QnRQT1BSSzNjU09yU2xQdnJYbldyQURGRlBBeFY5RnBjNEE4eDg1US9kQjFH?=
 =?utf-8?B?QWtJaytxMU9TYWg1WUZ1dXNlTnltQVIzWGlXUEszanRWak9uSnBZZHU1UlZJ?=
 =?utf-8?B?R0VaQmVqLy9tbHVMdXBNMytpOVkyUG1kK2ZMVHI4OTc3UldaMStmek5jWThT?=
 =?utf-8?B?Vk90SW5HMWh0dTF4VWVSU0xUcE9aYmZhMEpZNWp2NlY0VFN5ejY5bEtERDJ1?=
 =?utf-8?B?Z0JDN2hheTBCaENKQmF2ZVovU1ZXRFcyL2tVUWJqR2Urcy94K0UwUDd3cGJt?=
 =?utf-8?B?bjVTL1RXRE42NWt5cURxUjNMN1VZbmhNZ0FZRDFPTmNEUFZNakZZV3puMVRo?=
 =?utf-8?B?QkUzTkNON0g3OTZERTJUeE01eDU4Nk1IanVUT3VjamQ5Sk9TM1lWRjl3WFF5?=
 =?utf-8?B?OHRhR0w5N3E3QWVXT09DWkNEdlNKaGkrdkticG13MkpmdTE4TGVXcENwZGdq?=
 =?utf-8?B?alBHQXF3MW9MMW1PaGRzTU9UQ29qQ2txNHVEUkx0WXNrdEdDRDcrZmRGRjYz?=
 =?utf-8?B?MUIzb016a1ZiU3BOdHNiNGt4L0dHSEVOVERHMVU0QmdMR2g5cWh2cW1uSUJU?=
 =?utf-8?B?L0hMRzQzL3pQVnA5L1BnVDV0UEdNTTJCZE0yMXhVN09QeEw4UUdEWWV2QWtM?=
 =?utf-8?B?Wk5NQjBDcmFXN0FmcGt0NmJMVlBwZ1lmNlcxdFgvVUhYSFhnV0hvb3dHZnIx?=
 =?utf-8?B?cUh3am9jMkl0Y3FEZXB3MlJscjU3aFF1anB3QzVUTW9mNlJDY2hESHlLeWZK?=
 =?utf-8?B?OCt0MU5jSU0zTll3UWg0ZUo2SzJJT2l3TTJudTRCeFFVdFEzby9IaktXejc1?=
 =?utf-8?B?STY3ZVRybCt6ZkdTcTVWTE5mS2VXclpyVHk0MkdWSnlPZVFITmpRMkx0emkw?=
 =?utf-8?B?UEZiTmpPb1gxTHluZ21HQzFOMmhEUFVlUnU1NklzTG1uNkJ6dWVWaDQ3N0l6?=
 =?utf-8?B?VHFRWXVUekpkL1VqTVZDYlZIMmFjMWRIWlg2ckM0RFVGbnhqeTJZdm9Sa1ZY?=
 =?utf-8?B?Ui9vckZUeW9rcEJuQ0FqVTNjRTJGa2lmb1RxWGp4ZDhnQlp1Q1JUZVVFWnEr?=
 =?utf-8?B?ZndrMUc2dXR1ZSs3djVEZEo5c1pOSEl6RksrejFQdkd2V21oVFRBU2xZdFlS?=
 =?utf-8?B?dGlUbGs3WXlIZ2xZSllsOUtUQ0xRR2pnb2xYa2xpeEhTRjhxR3VWK0dEMElG?=
 =?utf-8?B?Nys4SkI3RHZvVjhaQTRSNE8rSHRWQUdCOWY0d2FLM29XQXZWaDJraXk5R1hV?=
 =?utf-8?B?aFBnb1ZxYWY1UE8rMGRwa2N3a29icTFYREo1Si93U1hJSnlhemd6UnFCSzFM?=
 =?utf-8?B?SDNidTJCOGgzL3ZTVExIQ3lBVHZBZDdxNUJ2OEFPd1FzMlQ5N3BWNFVmSmVi?=
 =?utf-8?B?SDIzdStPRWh6TlAxT3kvWXloYVZibXlqcXg3cFdVQ3g4eExQZ1V4K1ZOZ0ZT?=
 =?utf-8?B?UE1WVXBTUHVZZm1vV3Y3SVAyMDRaaUVENkU3V3pYdHdHcUlxR0tld2ltK1Fk?=
 =?utf-8?B?M0hPcTNtOVpwYnNOejhCWlg4YTFGVkJZWVQyWEM1WU9CTFdoQ0tqZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GFL/rm9lOfZWQ7dlQml/yFuCBBBhGo3Q5j3oA6eEF3aQnqf5yerffg9tKLkYYzU9cP9gJQvnhtYfrE2WRVnxYvo6VTscNt3L2fy5fTIvgM08dBtzW5qUlzbAfEcPHpyszc5xmvTyIDeLfUy9pxIPyw0JF+FretHIkmMwh9ulJ6/WxOUoDY85obagrqWUK2xEVutXWT/o4ViCJjnZ4A3lOQQtqC0Wh3yVhy+zbVFQturjDiH08M6CNn+Wug0WduoXkvX1h7Dj0Pha67bpZeNOOFg+TlAJ2oy1Wsm4O+H6dsPAZSM3kKbZGvTHZoq26KnfBgPRNhLCzUKx6EhumtP5Lg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4248.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607c587b-a3c4-4a11-1bae-08de859b70d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:39:39.2433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkvVZSQS28rPaRnu/SO2PssG7nAvF0bitXcB27FY1oBunzqj9BNghVaekDMIA1KoMiDZegGMxRKWMbiNN2KCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3624
X-Proofpoint-GUID: ApLtOmde5zDN6lKA_Q2OuRNYrJpr0bWC
X-Proofpoint-ORIG-GUID: ApLtOmde5zDN6lKA_Q2OuRNYrJpr0bWC
X-Authority-Analysis: v=2.4 cv=FJQWBuos c=1 sm=1 tr=0 ts=69bbc45f cx=c_pps
 a=xM6D3SEWvNmiLvDWDyWGGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=aGYbwIdU2JdQdTcLIDUA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NiBTYWx0ZWRfX5k0uiNDeztSL
 cQut4KTtD/OfFgtYcwdAWmSvJTKmc+pxSZmMwCn6Rvg7YbRA6N/EZ217jqhUqdYw47YTJ3AHWrA
 7BhGowqY+ZOHzm7/rwNTlhhEgsqRnUmy4rT/WZsPz010nF4YnT3ti4SZBU5bnrbabJqNQa+xj9K
 CdHWIL99eSKxueoAJeyIl8nZ+fZ89WNZmsXsHsKNRmuJP+sKuF0+lGfLyhmA1LFnUVHJXE+8jBS
 9e0Xq8FaSNFORbj4zEzEXuZcd9seBYjrvp2VpXRQtjD21yckjb5qYCaxxG+1//ujZswQn7K0h96
 h/Q9WHAwaAmD8ZgOLJnBJKSTJ2crjL1m6F2FmhLaWxxAB6zqda0r5EyMvG/0peaoT2mRU+3SnRt
 Kfe3yn2XGIMbD4Tj7l1eU3oWDZIqVH9XSOI/PLKzapbQNcig0J9KPI8DLu55DWjqQ065/LPSJdp
 0LtXx/Vo+fl8o7rU/IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email,BL1PR18MB4248.namprd18.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enachman@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3AABA2C93CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBTaW1wbGlmeSBhbGxvY2F0aW9uIGJ5IHVzaW5nIGEgZmxleGlibGUgYXJyYXkgbWVtYmVyIGlu
IHRoaXMgc3RydWN0LiBObw0KPiBuZWVkIHRvIGZyZWUgc2VwYXJhdGVseS4NCj4gDQo+IEFkZCBf
X2NvdW50ZWRfYnkgdG8gZ2V0IGV4dHJhIHJ1bnRpbWUgYW5hbHlzaXMuIE1vdmUgY291bnRpbmcg
dmFyaWFibGUNCj4gYXNzaWdubWVudCB0byByaWdodCBhZnRlciBhbGxvY2F0aW9uIGFzIHJlcXVp
cmVkIGJ5IF9fY291bnRlZF9ieS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvc2VuIFBlbmV2IDxy
b3NlbnBAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJh
L3ByZXN0ZXJhX2RldmxpbmsuYyB8IDE2ICsrKy0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfZGV2bGluay5j
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9wcmVzdGVyYS9wcmVzdGVyYV9kZXZsaW5r
LmMNCj4gaW5kZXggMDZiODc2ZjZiMjdmLi45YzA0M2NkZGIwZjkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfZGV2bGluay5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfZGV2
bGluay5jDQo+IEBAIC0xMjUsOCArMTI1LDggQEAgc3RydWN0IHByZXN0ZXJhX3RyYXBfaXRlbSB7
DQo+IA0KPiAgc3RydWN0IHByZXN0ZXJhX3RyYXBfZGF0YSB7DQo+ICAJc3RydWN0IHByZXN0ZXJh
X3N3aXRjaCAqc3c7DQo+IC0Jc3RydWN0IHByZXN0ZXJhX3RyYXBfaXRlbSAqdHJhcF9pdGVtc19h
cnI7DQo+ICAJdTMyIHRyYXBzX2NvdW50Ow0KPiArCXN0cnVjdCBwcmVzdGVyYV90cmFwX2l0ZW0g
dHJhcF9pdGVtc19hcnJbXSBfX2NvdW50ZWRfYnkodHJhcHNfY291bnQpOw0KPiAgfTsNCj4gDQo+
ICAjZGVmaW5lIFBSRVNURVJBX1RSQVBfTUVUQURBVEEgREVWTElOS19UUkFQX01FVEFEQVRBX1RZ
UEVfRl9JTl9QT1JUDQo+IEBAIC00NTEsMTkgKzQ1MSwxMiBAQCBpbnQgcHJlc3RlcmFfZGV2bGlu
a190cmFwc19yZWdpc3RlcihzdHJ1Y3QgcHJlc3RlcmFfc3dpdGNoICpzdykNCj4gIAlzdHJ1Y3Qg
cHJlc3RlcmFfdHJhcCAqcHJlc3RlcmFfdHJhcDsNCj4gIAlpbnQgZXJyLCBpOw0KPiANCj4gLQl0
cmFwX2RhdGEgPSBremFsbG9jX29iaigqdHJhcF9kYXRhKTsNCj4gKwl0cmFwX2RhdGEgPSBremFs
bG9jX2ZsZXgoKnRyYXBfZGF0YSwgdHJhcF9pdGVtc19hcnIsIHRyYXBzX2NvdW50KTsNCj4gIAlp
ZiAoIXRyYXBfZGF0YSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiAtCXRyYXBfZGF0YS0+
dHJhcF9pdGVtc19hcnIgPSBremFsbG9jX29ianMoc3RydWN0IHByZXN0ZXJhX3RyYXBfaXRlbSwN
Cj4gLQkJCQkJCSB0cmFwc19jb3VudCk7DQo+IC0JaWYgKCF0cmFwX2RhdGEtPnRyYXBfaXRlbXNf
YXJyKSB7DQo+IC0JCWVyciA9IC1FTk9NRU07DQo+IC0JCWdvdG8gZXJyX3RyYXBfaXRlbXNfYWxs
b2M7DQo+IC0JfQ0KPiAtDQo+IC0JdHJhcF9kYXRhLT5zdyA9IHN3Ow0KPiAgCXRyYXBfZGF0YS0+
dHJhcHNfY291bnQgPSB0cmFwc19jb3VudDsNCj4gKwl0cmFwX2RhdGEtPnN3ID0gc3c7DQo+ICAJ
c3ctPnRyYXBfZGF0YSA9IHRyYXBfZGF0YTsNCj4gDQo+ICAJZXJyID0gZGV2bGlua190cmFwX2dy
b3Vwc19yZWdpc3RlcihkZXZsaW5rLCBwcmVzdGVyYV90cmFwX2dyb3Vwc19hcnIsDQo+IEBAIC00
ODksOCArNDgyLDYgQEAgaW50IHByZXN0ZXJhX2RldmxpbmtfdHJhcHNfcmVnaXN0ZXIoc3RydWN0
IHByZXN0ZXJhX3N3aXRjaCAqc3cpDQo+ICAJZGV2bGlua190cmFwX2dyb3Vwc191bnJlZ2lzdGVy
KGRldmxpbmssIHByZXN0ZXJhX3RyYXBfZ3JvdXBzX2FyciwNCj4gIAkJCQkgICAgICAgZ3JvdXBz
X2NvdW50KTsNCj4gIGVycl9ncm91cHNfcmVnaXN0ZXI6DQo+IC0Ja2ZyZWUodHJhcF9kYXRhLT50
cmFwX2l0ZW1zX2Fycik7DQo+IC1lcnJfdHJhcF9pdGVtc19hbGxvYzoNCj4gIAlrZnJlZSh0cmFw
X2RhdGEpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+IEBAIC01OTQsNiArNTg1LDUgQEAgdm9p
ZCBwcmVzdGVyYV9kZXZsaW5rX3RyYXBzX3VucmVnaXN0ZXIoc3RydWN0IHByZXN0ZXJhX3N3aXRj
aCAqc3cpDQo+IA0KPiAgCWRldmxpbmtfdHJhcF9ncm91cHNfdW5yZWdpc3RlcihkbCwgcHJlc3Rl
cmFfdHJhcF9ncm91cHNfYXJyLA0KPiAgCQkJCSAgICAgICBBUlJBWV9TSVpFKHByZXN0ZXJhX3Ry
YXBfZ3JvdXBzX2FycikpOw0KPiAtCWtmcmVlKHRyYXBfZGF0YS0+dHJhcF9pdGVtc19hcnIpOw0K
PiAgCWtmcmVlKHRyYXBfZGF0YSk7DQo+ICB9DQo+IC0tDQo+IDIuNTMuMA0KPg0KDQpBY2tlZC1i
eTogRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT4NCg==

