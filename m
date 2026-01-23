Return-Path: <netdev+bounces-252824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMg7HJBgc2kCvQAAu9opvQ
	(envelope-from <netdev+bounces-252824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:50:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF677563D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E539304D91C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF73009DE;
	Fri, 23 Jan 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="YF0DZdZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429A2EDD63
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168860; cv=fail; b=KOaBvqI9Bsn2VK1HoDx8ZJzKesH02FYt4Dm7egTZQVq0D+yI8ebYGVikaifguRKo1CUgxg9Q/5MrxfSxZB8F7YXdaYJvfCC5FeL7yML2x1fcpzomu09jWJyL9Jefo0WfqVWc6u0LHe3mWc166BNpE/cB0A+RE0VW2hqCCKbgFyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168860; c=relaxed/simple;
	bh=pfw5D/MrBMBEEkKD2RRph722aBHQSXz9iC2viK63bJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTiLkmgMSl7XDLxAcwDxrC6XO4+uTdAmIsOXN1dqtHHgF1RxQwWDu4GODbnlECemATQ+kImN3wTPQjMAtIFILFrODTewfzksakJX80L3qPeiBPBrcSvvb33E2TzrIGhmbodsZZmrxzAr+4PLB1MXCOSpGs+QJnqisRAzbTIaHU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=YF0DZdZ6; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MNSrGu3719281;
	Fri, 23 Jan 2026 03:46:53 -0800
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023116.outbound.protection.outlook.com [40.93.201.116])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4buwkh98ge-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 03:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh/65Lny6ESU8+Ja5u+BlQmQWzq8X6lZ1jleQ/A92m8etWUUoAtTr0vbZWZ/ypUMEcoyXmRn6Ex6fSfM0A6BTDDcf+j3iKoNpJriAVhtFeLTLCv9t2QrMDJrXVJ4rw8Q/6AYOceUqnCdG9N+a3cEER3mQPZ0R4Imr+1Vmr8F3jWOoLkqnqnsUslAXpsFQUQPXuFviUZLokg4ZnmU2/PRlmBUxydBs08XPv8YurtKKJxcmtjcXANtXfHxikEKE6+dvQAawSk4YPVXb1MGaLOiehuV89EbEKhKyUcm7wOo8+LCKbVYuq0kdLAVg6R1YjXnHYi8ndv9I04y0/2Zi7h4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfw5D/MrBMBEEkKD2RRph722aBHQSXz9iC2viK63bJM=;
 b=yAuUgl8PTmmlu3FNvSp7/KjBxpkJtiBSO2mf4G1f6MSOJs4OoKRVS+IJIH3xF05Wu3vblkZneJvxz3HYOkySRS4M/KqL+W4XszU+RLrIKJFb5DHqPe3jp1z7qpYrQO7hEH3FNQZ93gMy0KpUxpG3LmtHhpMzO+vl5y9+PgCxGMhhR/0AjcbvHJzXiQfaey3F160/FOc6I6bLcJPJflsP0oX0WtvmPEHFMe9Ue+aHtyz0QlHGh2Xpf7VMLsq/0GBleeBbky9r8/LTX1TKDejkBLXoAExhAbD2IEueSNFbDsyqtuJsrp1AcVT5AmRKsvldMiL4eLyEWFXG82gaHi+RDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfw5D/MrBMBEEkKD2RRph722aBHQSXz9iC2viK63bJM=;
 b=YF0DZdZ6T4WX9v4WroijDfqPxjBtfog0plvt/YDsRljthCKJtpCWyoo6fQqRh+qn0gWyL0DRzo52rnEiaQFq8bMjwrvHGLHbt0H1x4YyTEHCDofodlSQDlCVCsVw2+8sFStH/eLF36ezvFP6EF15ZgWymm1aXWkXY2ZjfRBjS7U=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by IA0PPFD3A24D7B6.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.4; Fri, 23 Jan
 2026 11:46:49 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac%7]) with mapi id 15.20.9564.001; Fri, 23 Jan 2026
 11:46:48 +0000
From: Srujana Challa <schalla@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] virtio_net: Increase RSS max key
 size to match NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] virtio_net: Increase RSS max key
 size to match NETDEV_RSS_KEY_LEN
Thread-Index: AQHci3+uIaCSUqWgmUudoVFL+txQiLVeVx4AgAFMv6A=
Date: Fri, 23 Jan 2026 11:46:48 +0000
Message-ID:
 <CH3PR18MB6379E3B3806363B793912AA4A094A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260122091527.339180-1-schalla@marvell.com>
 <20260122075206.504ec591@kernel.org>
In-Reply-To: <20260122075206.504ec591@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|IA0PPFD3A24D7B6:EE_
x-ms-office365-filtering-correlation-id: 92a29ddf-677a-4c09-c777-08de5a751794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c24zWkZneGkrcGN6Y0NsRVB5VlA3M2VSZVNaRXA0YnIzU2d1b3hLS2FvRTN5?=
 =?utf-8?B?eVNKTDQ5ckhZVUlrNzlGK1p0WXE1Y0twKzI4SlVUcXJtdit1NVFCeWxPOVl6?=
 =?utf-8?B?bnNaVHJGZzFPU3N5U2ljWGhsVnMrWmVVak5kenF6a3h2OHB4dkNjY24vVzVr?=
 =?utf-8?B?VVBEZUgyRkk3OHM1cjR6dG9YL1ZyRVZOVCs5T2tnL28wQllPKzlZTE9ZWUg3?=
 =?utf-8?B?YzVnMW9QOTE0U2c4dE11WHB5WHd4UDJEZ1VVeHVwaWJsRDcrQ3BuSUVtS3p6?=
 =?utf-8?B?MFUwYkdhVHhFYnRjSTdXR2hyNFMxOFFyZmRDWTQvcEpyL0RDRXgrb1daZWNP?=
 =?utf-8?B?bVBXQ2NYNDFVbVR2R2poSnQ2WS9XVVFDd2NsYThtN1VuQmVSWmZxazJlN29n?=
 =?utf-8?B?aVVINmQ4aHY3YSt3ODBIYWlUMTJ4dG1wZEVaT0VxQmFuUGdnZDAzd2hqeEFR?=
 =?utf-8?B?QkVTRmd1YnNKa2toNTRXdnlFaWRWNFFDc2VIY2xPWThCMnR4QnJxeHJjcjd6?=
 =?utf-8?B?R1FocDZOeU9OM3p0bFFEZVdwR0p4VDAxTm9MSkJvei9TSENwbU4yVUxJYXB4?=
 =?utf-8?B?STN5NHNLNlRnWHRvSStmeWd0c0hzeEhMVDV1MmdKNkFtcis2cU5FRURNZzZD?=
 =?utf-8?B?WjEzbUtRYWxWa2MxdHBkMk5QQzBvRjM0dENQc1dJRFV2bXlNeEZDK3NHZzlH?=
 =?utf-8?B?dGFLUEdpUnhkNldza0ZQekhKTDFza29Id2J5RzlCRGdieEc2NElnSVQzRzNk?=
 =?utf-8?B?eUdQeHdLcHliNWJsa2h5L1F3dHBkdFk4NnA5UklkbEVqVWtsUlNOdTRrcFB3?=
 =?utf-8?B?T2U5UzFjQlY5QUNDU251bExJODJTdlZwZy9CTnY4TW1BSEtseWoreDVpQk4z?=
 =?utf-8?B?UlVjY1AycGEzRTU5VFZoY3doRmw3eFJCS1pzVzhySWZXbmdjdk5aUUFOZG5Y?=
 =?utf-8?B?OFpRRmVRbFNXaUxGMGRnRTdtMGlOZ3VzblRQWkxvN0VlREZncVBBSHErZ2RH?=
 =?utf-8?B?dS9BdERvM0xBY0xaWXNhNlVHRFNZbE92WnFtK0FoWFlxK1ViK2FoUXhaWUY0?=
 =?utf-8?B?Z24vK3ZUbTNuRmZORkthMmxobVBNZmdWSWRXUkJMOFFRSlJ0bmNIT1d3NGZk?=
 =?utf-8?B?WGFsSHVBd1VCaGZQOGFxcDhleHo3ZklmNlVjNmpHZVFRZk1nbFQ3eTk1RDVV?=
 =?utf-8?B?bm5XRWZpUWxZc1hwTUI0dkgwMEc2SFR5ejJtdzV0MFBWVGVSYm5PTlZxMWNS?=
 =?utf-8?B?N0lVNWJQTTNzbGU5ZWpobnBMZnc3QXpBS3ZVMVJFam5qaE9TSlFBekk3RG83?=
 =?utf-8?B?WC9PRDNKL0xoQXFOcnl4MzIwajRmckhTZmlEbjJKVnhrYzluNFBFRGF2VUZk?=
 =?utf-8?B?NDZ1TzN0UkhmbW9OVDltSEQ0ekd0S2V0azJGd2Y0MmNsZ2pFcWpMbitjOXpq?=
 =?utf-8?B?NG93Sit5Zmw5MzNLTmFtblMwWi9EOHl5UUpLcnNQZzZydStsR2VhcXNJTXhE?=
 =?utf-8?B?UG5JTjB0d2ZJSWEzSXRXSlp3em1RZENTRkMxZHNUaXpZTnEwaVNrOUxvaHJR?=
 =?utf-8?B?N25xWXN6V0RKMENXUUlpT0k3TFYramVXakFjVmcrZ0x4MzRHb1M0TU16c3Vv?=
 =?utf-8?B?L28xSW0xeTh0d1N1NkRnd3VnNTB3eEZSWkNLRHJoc0NXL2pCanBaMDJDeFFh?=
 =?utf-8?B?RzI4aDhjS0RqWXN0NTE2bXJBbmRldlNKeExXaWwvWk5hR1Jrb1NhK0o0YkFa?=
 =?utf-8?B?b2x1OHB3NkQ5blRSZStDVzliZEJpVkYrQVpMY2J2Y0lqWEFYZ3hGRVJwMFVo?=
 =?utf-8?B?ZnFpR3lrYW52WVJFbTZKcVpKOUhsRnNqVVBuL2FzY0dKb2VOQ1JEZVZEZ3FE?=
 =?utf-8?B?REUyTlpBUEN1SmlVa01CbkRESEJtOHhGSGNGV0FyVlluRE13MytRVW9hRU9m?=
 =?utf-8?B?bDJkK2htTkRFenpFS3BPbHRnTjI4Y3hkemh3UjJrbjEwQXh3UmtjQnlaakRG?=
 =?utf-8?B?R2YwU2JFa1dpUllCY3hjZG1iWXRSQUcxRVFYQVlwdnB0RnVIZnFzTkFWWlA3?=
 =?utf-8?B?OFU2VFBhcFhLcHhlTjFNOVo4THlzc2ZUSFFhUjEvR3QyalVsRzJ4bjNIRDlm?=
 =?utf-8?B?SVBhODU5VlVwU1l5VEJUMjl0WGFJT2UxNXlUUTlaaWYvTDVoMHJ3M2pFUUx5?=
 =?utf-8?Q?RdXaztMRmLosnqNAtsp7rvA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHNEaVpReWFTc0lLS2RHbEZScWcxL2ptQkRJNVp6QUwyM0hkV3BuQU1IZXZL?=
 =?utf-8?B?eDFqNytidEtWTG5RcWxYOWZYbnhWRHZHWFpEUS9CRE45aFBFK1RtZkFvdldQ?=
 =?utf-8?B?amFYNkV3UU5iWjFFR3UxMXZNRVVtbGZrWHdtcVlhM0lxK290UjhvdEcvbkcz?=
 =?utf-8?B?ZTlieUNtNWJ1ZGU1cU11N21IOU9lUkpmckJQUkthZHhJejJsQU1uR1pKaTF0?=
 =?utf-8?B?cHJ4VDZIeHVzWkkzb2tKbUVyQ1ZFbENZdzN0cko0bmpoZURjRkEzeFhlVTRl?=
 =?utf-8?B?QmNzRXduWCs4M3djK2ZHQjZzenhPVTZQbC9nbVlXRzVLYkd3d2w5L2ozWHps?=
 =?utf-8?B?TjRwaSsvempqcHZHdUVBd2ZydlowcTdoblRlZm10L2hwKytKWU12aVREdmV5?=
 =?utf-8?B?MzN1S1czTGd0V2FiZEhxRkE1dy9kVktNYmFrbkFhYk1OUUhPM2tzRDVFV2xU?=
 =?utf-8?B?T01leVJrUzJhd256ZVBnekhsMk1WdVRpYkRsTDMxanZFNlo0R3Z2aGpxVDVJ?=
 =?utf-8?B?TFR3VWdGRmFpbmxRT0lhTE5uODBZRERoZFVqOEM0OXVQVHVuY3IyKy9VNmN1?=
 =?utf-8?B?dGQ1UGpVMXAwZ1BVNkdlR0tTQ3hyaG5aaGxVUENDTGFBT2hCM2lkZ3gra3BS?=
 =?utf-8?B?SzcvelFHcThOdVQ1VGFNNDFkd0M2RSsvOUNjcHBhV2pHVURkRWlYN3RhUHM0?=
 =?utf-8?B?RTBES0ExcmNod2M1cUE2cVZSclFUc1BpWldaMWJNVzZ1VHNVMjYzZUVuSnox?=
 =?utf-8?B?TWF3T3dXWkdmbEdIeVEwalgvVXRqN0dYZ2RWa3pySTM1SDFTTjlreXBDZ0t4?=
 =?utf-8?B?alk5M21xTVZuT1poTldLeGM3K1NKM1pyQ0ZqVmpFZHNRMnFaay9IWnlYeEtB?=
 =?utf-8?B?ODVjbTlOVlg0WEt1N3dZNG9BNW50WDd6ZEQrU2IrSFlDM3pZMTRaekp6M3g1?=
 =?utf-8?B?YVlqZFVzWnV2aXBYUGcxcXNFZ1h6RUNIaW1KcTRtTHpFL1gwVytLelRnNlBZ?=
 =?utf-8?B?RHF5d1M1WWZPS0hlUGZoTTY3WXcwdzA5azdhVnlQUUFwYmh2Tm5lNjNZczJ5?=
 =?utf-8?B?S0NHaGp6aHBxT0c2UWpoQkxjOTJsQ3psL2lrNGh0cE5jRmZWWFBlZGtDeGZh?=
 =?utf-8?B?ajZyQ1ZyTVRhVFE1RkltNkpadzdLVkZmcGdVNjRRb1FaWTQ5RVFDTWp3NXpW?=
 =?utf-8?B?WVl4NjEwcDhNanJuRXcyeCt0S1JQdEQvTXV4YVNIVTFWNTNiTDJTYTk2ZWRR?=
 =?utf-8?B?TVo4WnpPV0JObDFHVDk0OGpEL29MRHBCdU9FY2hYVWxZZ2ZMT1ZWbDc0bTRh?=
 =?utf-8?B?SnNSWmZBanBXTjY1dW5FTElWQXFVNC93SGtkcUpLR2wxRU53UTUvdGxQUjhi?=
 =?utf-8?B?TkhYQ0l5MEkxcFUxZDRjNHg4dXl0YVJqM3dFd2FkdXVYWkJhb2JNN0hiNUFj?=
 =?utf-8?B?WmdIYWZNT1BPNE1HSFBCOUk0RUJlUUpFR3BRNmNQdkhHZlB0YmRWbzc1c2pP?=
 =?utf-8?B?WDZwalZTY3UzYk9xbWo3NDNCNW1YeE9JRkFVQjZWYWs4MC8rMWJDaHVvR0M2?=
 =?utf-8?B?b25TVmxTTW9vZ0QrZGsyTzVJVzFQNEpvcUYrZlVBMFRlOUxlMFNSeFhQS3FF?=
 =?utf-8?B?QlhUaENHNnZBbXlzVlJHY2VNRTMvRXVLZHB4KzY3MWphYml4RFh0ZGFqRk95?=
 =?utf-8?B?WTlIalgySU5KMndYZ243Ly9ZcVhWNEJ6NEJDdVlzM0JXWlJjbUxsMTBHb2oz?=
 =?utf-8?B?Z3Q1Z1VINk5IZ05YcElEZ09rQWxjMzVHTzE1TWtnVW9RUjlnZmxZemFSbXNK?=
 =?utf-8?B?eTE1OWNoWklxM2ZZQ3JoTWV5Q3c5bVNJK3FqWDJMSmx0MmtMVXFhNWZZQkNi?=
 =?utf-8?B?Q2g3eTkrSndKelZvQjBUemZOaTkrYzk2c1FVK1c3TkpPR3pyRG1kY1E5cHlC?=
 =?utf-8?B?R29sbWFrU1lnWUZpcE94SEdQVnVLT1NTdTQ4bzlCV0lObnROWHJReDRpN09o?=
 =?utf-8?B?aGJuMkZoWmxtS0R0akZieCtVWWtSb0FPNlBOT09sTE1LUi9jOUZuNmdBRG1F?=
 =?utf-8?B?WkdKWm5DWXRaSlc2YVRMTUgvMVEwenNWMXBRVFpteFRBZFJIa0hsUHZlV2Nm?=
 =?utf-8?B?M2YzQWJLaEVUYVBKMzFtT1ZTK3BPR2dWUlNsSTQwYVZuWlNsUDZWdnRDWWVv?=
 =?utf-8?B?QXlnbGZpbnErRXB6T3FOb09QMzVYM0hrdkdDVEFpbEoxcUZXeEhjVlp1MVJU?=
 =?utf-8?B?RkFlTGZxNHN1dGg2TWIyd3ptblpjQWVrQXhaY21aRnhJRzhHNVl5ckNab1Vx?=
 =?utf-8?B?eUVscWsxNW94RUFwMTdOUTY2eThCYW1zdVh6L3I4RDFOand3S1JENlJMNVhu?=
 =?utf-8?Q?5Jxtr+eKazoDeYab0eTn37Nq4muuPXqe1dRvz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a29ddf-677a-4c09-c777-08de5a751794
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 11:46:48.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiYQSMlkOLXH0zNo5v8OojDGDK4j5fngdhyZAAy4Fgom3QuPC7yJcz0LVwMH2pfo4vP3LSpd+DT1yVwoppEYHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD3A24D7B6
X-Authority-Analysis: v=2.4 cv=F7dat6hN c=1 sm=1 tr=0 ts=69735fad cx=c_pps
 a=0c6nIVSIW9eNWsIgvcvAAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9UnnJO3Be1qlD0lAZBMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VFv1FKt-ihyi3H3I-pV_dzaZ6RXJ38rU
X-Proofpoint-ORIG-GUID: VFv1FKt-ihyi3H3I-pV_dzaZ6RXJ38rU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5NSBTYWx0ZWRfX1qP9BidiGxRJ
 jCmS6GBrh0onXTBrthLNhc+Vh+jI0L+Zh0e4Sz0ENaevBpJJ7FW6lr2EpE9Eop2IZv4UsWL9Imm
 KaferfdcR9GeWNEQMcB9h4GLl0miFC8lM8bA37gb43IlHTbrBJtNeaiQ4ihm77gvE+cRsby/3n2
 K9/g7nW5aUOuSDKPg+ysyi9GETJl+4ncsKfUKLsuWeJbH12QRd4ojj8UXTL8N0H57dH5N2NSviw
 3cN/Ea1SG9a1VpsKCB+/TIluhBKIzKhlazBrgazE7jj9BS0K0VF+zs9+ZKV/x7UWy/AaNwcKqkZ
 6+EUMue31LxaEH5vf+9Mvn2inzJGOWcbQLQ0vvQruHZjr4i8yINS2eOWszr81yuQoZHk685px3Z
 lMcF3Kng3ZTPCfxaeguVbSlTga4t4he1ZATjIBc7mNs3eSpFGu8zQUBZQy3y1iQQc8wBaqiGJMA
 5g2luYodfdKhNln7YQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CH3PR18MB6379.namprd18.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,marvell.com,gmail.com];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DAF677563D
X-Rspamd-Action: no action

PiBPbiBUaHUsIDIyIEphbiAyMDI2IDE0OjQ1OjI3ICswNTMwIFNydWphbmEgQ2hhbGxhIHdyb3Rl
Og0KPiA+IEluY3JlYXNlIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSBmcm9tIDQwIHRvIDUy
IGJ5dGVzIHRvIGFsaWduIHdpdGgNCj4gPiB0aGUga2VybmVsJ3Mgc3RhbmRhcmQgUlNTIGtleSBs
ZW5ndGggZGVmaW5lZCBieSBORVRERVZfUlNTX0tFWV9MRU4uDQo+IA0KPiBJJ3ZlIGJlZW4gbWVh
bmluZyB0byBidW1wIE5FVERFVl9SU1NfS0VZX0xFTiB0byAxMjggb3Igc29tZSBzdWNoLg0KPiBN
b3N0IG1vZGVybiBkcml2ZXJzIGNhbid0IHVzZSBuZXRkZXZfcnNzX2tleV9maWxsKCkgZWl0aGVy
IGJlY2F1c2UgY29yZQ0KPiBnZW5lcmF0ZXMgYSB0aW55IGtleS4gQW5kIHRoZSBkZXZpY2VzIHN1
cHBvcnQgaGFzaGluZyBvdmVyIHR3byBsYXllcnMgb2YgSVB2Ng0KPiBmb3IgdHVubmVscy4NCklu
c3RlYWQgb2YgaGFyZGNvZGluZyA1Miwgd2UgY2FuIHVzZToNCg0KI2RlZmluZSBWSVJUSU9fTkVU
X1JTU19NQVhfS0VZX1NJWkUgIE5FVERFVl9SU1NfS0VZX0xFTg0KDQpUaGlzIGF1dG9tYXRpY2Fs
bHkgc3RheXMgaW4gc3luYyB3aXRoIE5FVERFVl9SU1NfS0VZX0xFTiBhbmQgd2lsbCBhZGFwdCAN
CndoZW4gaXQncyBpbmNyZWFzZWQgdG8gMTI4Ky4gUGxlYXNlIGNvbmZpcm0uDQpUaGFua3MuDQo+
IA0KPiBXaWxsZW0sIFdEWVQ/IElzIHRoZXJlIGEgcmVhc29uIHRvIGtlZXAgdGhlIGNvcmUga2V5
IHNtYWxsPw0KPiBPciBkZXByZWNhdGUgbmV0ZGV2X3Jzc19rZXlfZmlsbCgpPw0KPiANCj4gPiBU
aGUgdmlydGlvIHNwZWNpZmljYXRpb24gcmVxdWlyZXMgZGV2aWNlcyB0byBzdXBwb3J0IGF0IGxl
YXN0IDQwIGJ5dGVzDQo+ID4gZm9yIHRoZSBSU1Mga2V5IHNpemUuIEhvd2V2ZXIsIGRldmljZXMg
bWF5IHN1cHBvcnQgbGFyZ2VyIGtleSBzaXplcyB1cA0KPiA+IHRvIDUyIGJ5dGVzIChhcyByZXBv
cnRlZCBieSB0aGUgZGV2aWNlJ3MgcnNzX21heF9rZXlfc2l6ZSBjb25maWcNCj4gPiBmaWVsZCku
IFRoaXMgY2hhbmdlIGFsbG93cyBzdWNoIGRldmljZXMgdG8gd29yayBwcm9wZXJseS4NCj4gPiBQ
cmV2aW91c2x5LCBkZXZpY2VzIHJlcG9ydGluZyByc3NfbWF4X2tleV9zaXplID4gNDAgd291bGQg
ZmFpbCB3aXRoIGFuDQo+ID4gZXJyb3IgZHVyaW5nIGluaXRpYWxpemF0aW9uLg0KPiA+DQo+ID4g
VGhlIGRyaXZlciBhbHJlYWR5IGhhbmRsZXMgdmFyaWFibGUga2V5IHNpemVzIGR5bmFtaWNhbGx5
IHRocm91Z2gNCj4gPiB2aS0+cnNzX2tleV9zaXplLCBzbyBpbmNyZWFzaW5nIHRoZSBtYXhpbXVt
IGxpbWl0IGlzIHNhZmUgYW5kDQo+ID4gbWFpbnRhaW5zIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkg
d2l0aCBkZXZpY2VzIHRoYXQgc3VwcG9ydCBzbWFsbGVyIGtleQ0KPiA+IHNpemVzLg0KPiANCj4g
PiAtI2RlZmluZSBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUgICAgIDQwDQo+ID4gKyNkZWZp
bmUgVklSVElPX05FVF9SU1NfTUFYX0tFWV9TSVpFICAgICA1Mg0K

