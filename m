Return-Path: <netdev+bounces-127531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A88975AD9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF481C223AF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5E1BA27E;
	Wed, 11 Sep 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHDLx7L5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dsbgFdiR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5519E96A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083077; cv=fail; b=FeswGmwXMVf7Shb8ak/2KaJIY4jfMZqhm3PNZVkYPP9V95TkSiNbaxq7QGo6jFKu7shySdpkk4YOFMRfHDl+5IUmG3JfHBvmhD1QR8kKdP2+dEvDcG1VMtH5fr8Ua8q0AEHJX7RkYEqZsHosbEzmprRhaYD1CpIQNk/liIifP3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083077; c=relaxed/simple;
	bh=ieyxvGIssIGQkeZpoIwR3mh7VSM02lO1HqCFvskOMlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=giwCcMvDqmN8oKxqBGO5uSwu1EYIMnNPNG/60cbVpjWSL15wMpUOu9O+XoP9fSQcM6x5DIT6n3EI4qHtcefWIkvDgenCfv1WsxauVx4gtoPPzXm+T8aMlp7CnNDJL5LKflDzGm7ZkwT2imhniZGubziETPxavdeXYl3pK7+qCCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gHDLx7L5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dsbgFdiR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BJBXOJ021136;
	Wed, 11 Sep 2024 19:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=uqQEJtqeHbEjXEXCwbSM1wCbiiTNel13SN2cBugvLjg=; b=
	gHDLx7L5wSCqx0gBVx0N80INGPFAm51XuzErYK8p+/DARQDeSzmLYkWEXyNYOeME
	mahKhcralJUlXqosMqLXg4/LF8LV1ZjHSFDcC7IK6uqtoxaGpTFSczwgPapp419E
	WAp3AN4Fb1eMr0Ukbdco6lgp08OypJgru6h7rksBqrMWjrD/bdn93ghRnv+0DK2m
	/f8QOuypDqM6LVI3FwhruKM4TLiprHcMzuQrWcBTsMUSuihx4anNQtpeOTVjQPX2
	WDDzu/LmiKHounuvcpaZqBJ9CkuYMFxQ2jhKNIPP7mvozMiDPuHV01lQaAKlnoZ+
	yiUlj+9GohVIhxNj0jQxzw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjburuny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 19:30:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BJ2UUO032490;
	Wed, 11 Sep 2024 19:30:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9gpjfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 19:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JisaC1GKyDPd64TLGXu7KDlrDxnhfDvKlWU0E3TPnoMUKUUaDS18G51aT8zN5H9SXSQJacorwkmsJyNIWjlv+cVfm7ogF0S2g01fS70d9tKhIZekELU7IBFZ2NSjSS9KoMYZumOz+5Cljiuhd5KY4BOTv9lR3IyFs7LVvwA7//zqIZjCDu4FKAFAXYnOM9lS/ifV4by4Z33rMGaRIljj5MIQs8wdccFUozav0ogkWgv9vBqB6CflBl2iL2XUWhzaWXLB4FNFLmesb82vDxb2TbPHiere799FUM5MM4ezvCkvau+5CVmy8i3pcAiWaaourH6Vh96h56Ki92sn8t6Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqQEJtqeHbEjXEXCwbSM1wCbiiTNel13SN2cBugvLjg=;
 b=N+koh/b55l9X7F/Zj3YzADOtvRenk4xLz5iMDmpvvEFVyO80cngRLxn3LfnXS/nLhbUGx6myOFACmj6h2x8R0LcM3K/Zgkcb7Ja2iel4Py9iyfoUTy1Pxf2jce/nU2uVDo2xyE8SNR2Kf1+S0ud1ypzeBNgF0sXze3fr98TrA1ki36M+IYaEfHXr8o1Xct1AW+s1WjHXInsvNhfUwT7HX04+b0Eh0WOLh/pFonyeDxVRXtvYPJ+JgMMus3Z9aEKQPHpI/S5iz7UGVDIZ0pgDH3/CAfRCSMQvff7EWnfFEt3G72zbSevKwPi4N0ApOPercgRdjy99FDBLt7eLQwepng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqQEJtqeHbEjXEXCwbSM1wCbiiTNel13SN2cBugvLjg=;
 b=dsbgFdiRJnZCNXuJYFFwEwlRjb0OK7Iv3h22iKk7Ueb5wZG/FyHMb8NinfrbSDEuARghFZWvA1RYhL1c07IVEyLXwkpw2k+av4yCT2SfRFXpku+/qrj+kedBBaduSLro9E8vBKbCCWuGss5yGYGN8szRr+4V+iauIAl8w9KbqSs=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 11 Sep
 2024 19:30:51 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.7962.014; Wed, 11 Sep 2024
 19:30:51 +0000
Message-ID: <29017a97-7a5c-49eb-b866-e6b22fd8baea@oracle.com>
Date: Wed, 11 Sep 2024 12:30:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Darren Kenny <darren.kenny@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20240910081147-mutt-send-email-mst@kernel.org> <m2ed5qnui8.fsf@oracle.com>
 <20240911102106-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240911102106-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO6PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: f6312607-0012-442d-0630-08dcd2983f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmZtajZvSEMrWi9KR3d6TnlJbkVIZ1F0RTc4enNQNlRkRXZxQ0x3c3BmclQ1?=
 =?utf-8?B?NHdGdno4R05lM3UrQ3c2RnNCdEF4TE93S201VjJTeldTdXdrSVRBeXE1dWhB?=
 =?utf-8?B?a3c4THREUWM3cXZjMzRibTJYMU9mNzlrSEVrUW41Tml3RHRzOGI5b1RJQWlX?=
 =?utf-8?B?Y09QQjVFNFJNQzAxUXBtTDUwZkZMaDM0a3ZUUTFnVTNleE1sK0d1Zm9oSzRG?=
 =?utf-8?B?c05iS1RhUVAveXY3bllRclhKRzNpYm5aSGJyQ1BrZUgzMDNYOERaZmM4cC94?=
 =?utf-8?B?dUJJUWRJeHQxbHNieHYvZ0hOU0RJNXhEOEdUdkROWEI5WkJxdU1USTBDTVBQ?=
 =?utf-8?B?OWl2T0RzY3RVVzhvQUdNVlNXanZSc3czdW1qTytCUHN2RzJHN2c0Wk5YamZT?=
 =?utf-8?B?ZzdsYUdYa1JzdjlEZER2TlNzMUttbTg3cGtjZ2FFbFhjcDB0RFE1eWRiQmE1?=
 =?utf-8?B?V3cvcHh4RHBHeTdXSzJodE9rMTJSN0tjRmwyRWtReEl5bGJxLy9WRk1qMnIx?=
 =?utf-8?B?dGRVUkExczZmV0xlT1hJTTdaMHVma0hmOHB6dVNPaUZuNlBQYUl5alJRbU1r?=
 =?utf-8?B?TnJVTzQ4UWxzMzFlTS82RUdpaURDMzZsa1piTW5HendkUGRZT2NhRDhoOUg0?=
 =?utf-8?B?VmNqY2NNVVVNbW15anhPbFlSVVJsQ3FBOU8xVjhEVFRUYjZWMEpua1FkMHJ6?=
 =?utf-8?B?Ny9HckxCTUJqQ2dKRDJTaWVmQXB2OUdKYXdvSDhWWnNYcDNaTGUzbnIvdVg5?=
 =?utf-8?B?TzYwUjFKM3JLVlV3c1E5NyttM3VDSnVEcUZ4TFJoUzVxckdIcHlVZ2xTZnhq?=
 =?utf-8?B?djE0VzRyMlZPZ1RBSEdlYWZISkVkZXoxaFNVY1lxOWxvRkZHVFB4RFFmSzRh?=
 =?utf-8?B?Q05mRndFK0RtZldyNDhNREVUaGhIU05zZWg0b0k4N3FaTTZBOFFSVHozNk9P?=
 =?utf-8?B?T2pIUHc2Vnp3RlFFQmt4TXQvb2daUGlrNmhCQWhVaEo4ejNzazAxNURhbzJx?=
 =?utf-8?B?NVdMZlYyOXRDL2tnVHN3QU1RK3BWRDFyZGVoaXBZdEQ0dnQ4QUhPODl1UzMv?=
 =?utf-8?B?T1NhSnlBMzdFNC93dDM3cFNCNTVWMHZEd2RvLzAwS2dHNlNyQURZSkxIMWpv?=
 =?utf-8?B?VlZDRDgrWEJacHNFQklmRXFXam55UWpvOHRQSmxRbk5qeEtKRzN4bk5LNVRV?=
 =?utf-8?B?MGlxNXMvVm0va1VqdHZvVUJLY1BPa2hnRU8wUXBQWm1IVmd2R2Z0L05LK0hI?=
 =?utf-8?B?dGZLbmtxRDBuVFM1MWlHUkV5N0FlTk5uTVJFSk1BTmd4dDlFVndZY2JmVEVP?=
 =?utf-8?B?Zml2K3AzdEgvQ0lhS3k2WXN5ZkhxR3BXMnEzUUtFWm82UzkzWGIraUtoZkY2?=
 =?utf-8?B?VEc0Skc3Y1JxRjRxeFhCVGtxVlhOQ1VaMFlwRDJ6QlNmSkNZTkRMVU96Z1JE?=
 =?utf-8?B?SGEzRTdtZDdhZUU0c1JKd2hTL2RrckxwMzJudXViMXVKalFPRnJ1NWQvZ0x1?=
 =?utf-8?B?cHRvVGhHdWtHdDk3L0Z4ODd2TDBoc0pkRzJUMnl3QjVVLzRCOWwxMTkrVEQx?=
 =?utf-8?B?NnYvaG5RbTIrOHJZUzZISG1xd2VmTkxXTHJJdkJLTWhTS0N3Um9DQ01TT0hT?=
 =?utf-8?B?aVE3dTJ0Y1o2ZXd1QUNOT3VoL254ZzFhOGhvYktBS25zOXFzeG1MZWU1cTNS?=
 =?utf-8?B?aVQ5OC9PRWZCK1BZdlQzVEE0TGJ2OXhKdmx5S2xEcmI1OHRxTW1ndjV1bGV0?=
 =?utf-8?B?NmZJYUxtekhiYkJFWVIyREE4RWdmT0gxcXlRT1pYU2dJaTNlZnNCZVZtZDU1?=
 =?utf-8?Q?ZG4BNFcjIsSwss7VEcmqVLxfGtPzsFx2OrqyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cklzK2N0b1Q0NVpRbHZzOVFHaTFFSnZoem1HaTRicHRqNFpNMlZDeW5zWnhS?=
 =?utf-8?B?ZjJwSlNLbDdGMG9oS0VhM0U1RGhCMVZ1S2h5TGdxQW9BWmpmaVFpYTJZZUxS?=
 =?utf-8?B?MzBnQTAvWmZhc1lKWFhuYkRpV0RQVUtQU1p5WHI3dGxHT1RzWUtqbmFub3BD?=
 =?utf-8?B?S0NlWHc4cHRVSmIyMlJnT2dLbmVuUmN4S1NSWCtjT3J3YkxiaEVUcllnSC96?=
 =?utf-8?B?TU1SeTFUYTlDQ1lMSlJYZkNBeHFiVjQwWElVN1ByMkNzRUQ0VitMUWppTmhj?=
 =?utf-8?B?My9XTXZrdE5xSnNoY3d0WjBGb2YvVTNVS2pqb2o2YllySXZuUS9KUFIvbGlE?=
 =?utf-8?B?RTBsVm1kaktZVDB1Y3V2TEN5MEx4N1B3VWJ6dXJOWVpSTWc5a2x2cFRHZStp?=
 =?utf-8?B?cVdpbXpHbzBRQUo5NnJkQW9LdnU0NEhOTitZMEE2K3NiRXpQTU1XbDhpaGoy?=
 =?utf-8?B?MWNsT0xGY1F4bkFyV2JjMUx6QUZhaFJyZktwZUV3SDdtc0NDbFErWVc5MWhl?=
 =?utf-8?B?dWNrYWFwb2VYRnFoc3dDSUkyNnN1T01QQ0RBUkROU3J1K2U2M1M3RFZnTmsz?=
 =?utf-8?B?ekVCYzY1bUNhSVVZaEJMZnVYMGtia1dBOU95V244TS9JcEZhUG9PS1l1ekJz?=
 =?utf-8?B?cllVa0IxcnhwNFllNk5rSW5STXJQWlZ1WlBFUFpwczFxYlAvMnNBTzAyMXhJ?=
 =?utf-8?B?dWlWUHlsTTRmY0FVRUhvcWowYnVkSmJ6TmVGejlZa2NhTWkyRDQydGVMcTVF?=
 =?utf-8?B?MitxWnB5Y2M1dUJDMHB0Y0REUWUyeFZ0NldwZXJ2cmcwVlR3eThtM3B4d1Ny?=
 =?utf-8?B?NnpseE5heDI2cmJCL2Q3RXNpcE1CSGVtTTRLQVBKOTdIZmhOVVJTSytKRDBC?=
 =?utf-8?B?L05vZ2VFWXZUWll5TUFMY1NJbTUxQTJ4N3RvLzN2YW9BRUJQTG00SkxyanJK?=
 =?utf-8?B?dlRCK1JFS1hMUEx3ZnFsWkJjeTBvcnM2R2I5WXNtRm0yQXIwbWRpYWVRR1Yx?=
 =?utf-8?B?V1cvUExKazd5aHdEdXFJVk9ZNFc4NkhKdnp5RFEzRWVWYXphVXh3WXlwRmJ2?=
 =?utf-8?B?cXNuNC9ROVpQVWRYQmQrL1lOTXhBTzg2ZlAxc2ZiWXdaNHdNdzNFYkJ3ZjhW?=
 =?utf-8?B?S1g3aWcxMTVVZk5tL2xPMTNweHBHaDhFVVdGQW52MENrd3JTQXhaeHFYSkxp?=
 =?utf-8?B?Zmc4RkFhaUFscE43TkFKcGhQdTRUenV0V3NpVzZDdVBWaC9xYVdSYTVaUW5D?=
 =?utf-8?B?d3ZpVVhtTXVKV3pQM1E3OEtnbGpVR3J3YS9CYVl5eDB4NGNtenFINWJFYVNF?=
 =?utf-8?B?QnNRYzg4SFlGZGdoUnhDTUxSRHZTY3d1bjE2VUtNc0h2cnpzbXpMMjhTOUkx?=
 =?utf-8?B?b1hVZVRiaVFtZFRkMEd6QjgzczFidlRwWXpDRmVQdUhIZHVURFcxUTRVUG4x?=
 =?utf-8?B?K21xeFljdFdJeU9paW9VRG5INisrWFJaK1ZMVGovTVdzR3FJcGVBS1dhaXVz?=
 =?utf-8?B?WjlMUkN5YWU4QXNkYXR4SFg1bVNCTWRBWC9IbHgyY3JmNDNYVXFGcDhLMmV6?=
 =?utf-8?B?R0RpaHRkaENDZlNTbHJzckxXc0ptR0VVc0oxU3pkWUNISEtvQnk2MW9HOUYy?=
 =?utf-8?B?djQ4N0J4anA2d0pQMDV5UzQyQW1GUUJQcjNFeU9oSURqRzBob01KSm9yUTlp?=
 =?utf-8?B?Q3JwU28rR1NoVDdySW1ZRitYSWxhQXlKM1VsbFo0eVR5eEtpOEFINld2eDNm?=
 =?utf-8?B?ZllkM2YrU0lGTG1lTFk3T2hVUitJMkFHOHcxUFBCV1o0MUlTMTFJSkEyb051?=
 =?utf-8?B?Z2RocDF1SlFxQWxuMkRHemNzcTlmZUFmRlBNdXhRYVZmdlBBZDhYc29VdFJk?=
 =?utf-8?B?ZE5wd2FlTzRpN0UvdXIwOVVSYm1RRzgrVG84SGw0ajVXdG84TWc0WjI0SEpk?=
 =?utf-8?B?U0NIZVRndGcwejh0RENxN21lTTlHVWYxWWJ0SzNtWjdXNWNwcGp3RCswRFRJ?=
 =?utf-8?B?bEpwZUtUWkdtaG9JeXAwU3R5V0xrWnU3R003RTlxMmswWmdnb3Q1QVJIZnJH?=
 =?utf-8?B?ZjlHSE1jWW1Ed3p2L1d4M0s4UnZYdDhEbnJjK0xHbkZaT2htNGY3UTZLZzJQ?=
 =?utf-8?Q?QJNoIUMfg1dpyLf+F8hLhBPe1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2rCHpZyD6FABAGvGbZZvMTqbwp6I1lfsuQ1yqTyEuo3sOVglh3rpoppoamC3mGf6bWWKdwn//ULXXFQRSiu266fDpwXfi5Sw1lwDjp9rZfiOpBPyUUQ7oNTAsY3s63VLwtcTgBZ6Wl2DaUiwirjjyke9vGelcgrNG+rxkpiJ4yPp/AX9xvriCXQpbYRvNEFAKJJpj49H0c7tsg3x/iUgheiW5Ni8t551VJBXTbzDgRT8xoQm0PN2bucnTXDYUx94jSpE0hC2DqhgXdhwj5fsiv6t1chdaGvBa94kbvI6nSS+DOL1blTT3C1+A8IjLE6XgLIHBELTN7LB7uHmES40Tr90oDUkisAjiSJ/Cw48H904ZqGM+NSzYzBQXE11S320Dwc6Dpkelh3JkDeR6q1ICUnoNSMZwMtAJMyna6TBcN8/kz5P7Ym2vfq3C2e1eK8Wpdghvw0kH73lQ4+6WOejbJReEx1lSh+Mv65n0z8RcRcs16NWDZpLoSet8JvKH3tA9aM8ZSPgwvIjkRQISLPGITWrbP3XeXdPJIU/ryvefEU+yvIY7WBVGcDR5Xb9W7I69BRmqLLLnPstmv1upYuSOWTfcjSzWIoz2tgBZj6Zi3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6312607-0012-442d-0630-08dcd2983f04
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 19:30:51.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nh1dwVzbQL4IO0j6xXXU9C647rOf3diYGdbDaj3zVGOchiafkuVuB1vy9BjW4YZDKUFPuAblA0TN9iYGJzlczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110149
X-Proofpoint-GUID: nhx464PRqVNaug7tMR7IAT-tArjBZtfw
X-Proofpoint-ORIG-GUID: nhx464PRqVNaug7tMR7IAT-tArjBZtfw



On 9/11/2024 7:22 AM, Michael S. Tsirkin wrote:
> Thanks a lot!
> Could you retest Xuan Zhuo original patch
Which one? I thought Darren already did so?

-Siwei
>   just to make sure it does
> not fix the issue?
>
> On Wed, Sep 11, 2024 at 03:18:55PM +0100, Darren Kenny wrote:
>> For the record, I got a chance to test these changes and confirmed that
>> they resolved the issue for me when applied on 6.11-rc7.
>>
>> Tested-by: Darren Kenny <darren.kenny@oracle.com>
>>
>> Thanks,
>>
>> Darren.
>>
>> PS - I'll try get to looking at the other potential fix when I have time.
>>
>> On Tuesday, 2024-09-10 at 08:12:06 -04, Michael S. Tsirkin wrote:
>>> On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
>>>> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>>>>
>>>> I still think that the patch can fix the problem, I hope Darren can re-test it
>>>> or give me more info.
>>>>
>>>>      http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
>>>>
>>>> If that can not work or Darren can not reply in time, Michael you can try this
>>>> patch set.
>>> Just making sure netdev maintainers see this, this patch is for net.
>>>
>>>> Thanks.
>>>>
>>>> Xuan Zhuo (3):
>>>>    Revert "virtio_net: rx remove premapped failover code"
>>>>    Revert "virtio_net: big mode skip the unmap check"
>>>>    virtio_net: disable premapped mode by default
>>>>
>>>>   drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
>>>>   1 file changed, 46 insertions(+), 49 deletions(-)
>>>>
>>>> --
>>>> 2.32.0.3.g01195cf9f


