Return-Path: <netdev+bounces-260909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JtxFcXnnmkCXwQAu9opvQ
	(envelope-from <netdev+bounces-260909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:15:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3101971C6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02873302495F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5D3AA1B8;
	Wed, 25 Feb 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="cOq4x4o7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD127703A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021626; cv=fail; b=MN5mj7TF6+wN9wFaKhsj08ZKV/1IJtIQJTnoQ66Jvczx7I+iUfb69R/kotrZN8bhLxW+LCMUVw9REqxh0ze5eVv6NCVtZ+jeTUEyJ4CwEMMl5rGW6C1/p53eaIxZa8uPvHPT7SLLL1elrPVHKLO4UL/g5P4jN0MnAyeadeEIFJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021626; c=relaxed/simple;
	bh=WlhqBxYi+BvbUQh1RTdoTSkClurMnOFVr+/PUw3mycI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHMnuuZtk5cQC1q/jIQFgVn/fWQSdMWTUCuQ72dQV3Sz7Ws5NITIQP9ynzAlNl/JBzkhvMtwmRB4ZlUBG/gD8LxPDZoOB7fih9/e1dreM47shEfB19Z3+5qPGsTxgwHBrNCDQio6y7yeF5W5/LYhpLSNXP4lIPQD6A3xwj3Z/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=cOq4x4o7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P1PHig3896397;
	Wed, 25 Feb 2026 04:13:04 -0800
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020086.outbound.protection.outlook.com [52.101.201.86])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcys6r2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 04:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrImAgs6Ob7DBnFnI44lH7Z1dJCG77kfhHIaxd3BLucvSSTffohYX0YzeC9BxBgVhLVWMhRsgdhNbrwYMVXi6ig0Hyx0dBDbCsEfLrBJVO5UET6ThFYGpE978SUj+lVX3xNwZhPSE7AMzxb0wkgyjpOtKoTlQbBlK9RJ6FjgeS0bwC1hGqrZ+qJY8T/ooZI4yVkJ1qEK29LN4OUr6YoGo2J8qQX6Wec/6zAKXEK5K2cJoNd066dbIQ5f9b3OfbaGr2FsHHqO3731+3Z4X5rcvXnmvKpWWDPhht5DwvKPgpmq8NcV5gofru7apaYFndH/oN/ShsmHCy+F/EyvgiTQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlhqBxYi+BvbUQh1RTdoTSkClurMnOFVr+/PUw3mycI=;
 b=I6dDUdkUT64/3bSOMn3XUCkgd8bCA91p0l0O/gTaWkO46wyv1JR0WA5uoHMG0Az5laUS2+MXGIazIq4pX7OdFYBoGy4J0mqRlYAxQmb5b1IuKVSTj7P7scbusFGR1jqbr9OyulWfooJZ4pMuxf+3vu69s0COp8XNdDIAhEjfFelmrIcxZUkVhnZwQJeNpeUcSFFvxrjWjBpqDnSmgfgDn86WgViPD1oTos1SjuhUJmA0agaq56U5LRj2IVy8hGTt3FMA2WMkvIwSbxnUiq1TT2JFUx38X2uBSEkwn3XGwWJryDbF4keIiaLT3Bb3hifrdHu6F+kQpO9DMtTwXxMSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlhqBxYi+BvbUQh1RTdoTSkClurMnOFVr+/PUw3mycI=;
 b=cOq4x4o78GtUFvKtg7xlyItNM8tuMBU3B14h1oJk8Wx1NIsxCNXjTxRb4qVWs0cxmUltwvwri2HLNtunondvJWMa2ha1PF1o9ZxUsS2mWrULceazI149LIzyYCviyrKenTkf65wordHw2Vud6abGQe/LynH8SzsIgMkp9oYLCFE=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by CO1PR18MB4779.namprd18.prod.outlook.com (2603:10b6:303:ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Wed, 25 Feb
 2026 12:13:02 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 12:13:01 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key
 size max check with BUILD_BUG_ON
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key
 size max check with BUILD_BUG_ON
Thread-Index:
 AQHcpVsTmeb1lmO0a0uCjC1oU/uQqrWTIswAgAADgQCAAAHEgIAAAPOAgAAAmgCAAAMmAIAAAW6AgAADlwCAABzOIA==
Date: Wed, 25 Feb 2026 12:13:01 +0000
Message-ID:
 <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
 <20260225050441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225050441-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|CO1PR18MB4779:EE_
x-ms-office365-filtering-correlation-id: 7209c9a4-71d9-4f8c-cbda-08de7467389e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 ygiDVU8d6a6IImS7fkCvy1FmoCNPzVWhwcYm9Z0gnNxeFAhZsFTcZDkKCtGzn2/DzmMkwSCitrISq43SPMawlb+CwpZFHry9tdDOce4+RNgskMp3JFbE1hNVq5bRmofJiLaKjBVJEBcDDKg/eI3QqybASGuzgyjl1P0VwVLCCGlo4Wsy39a2ehvAAtb3w97CP+G2EllPWXU3Zl5o9GxKeHUkMUnAOOnfsSXiTCwC/1b6cz1XPMrn/xsh8heLIslt2b6mqarZYlc5BrN7CxvxGbkhCoOzg9RLBpGBexzvVp/An93PCGdVC2KHtSGGEU9rX0jVSFdvf8NJOckpBh2demvL9hSbPSg6G7/MAw0Z6zKkd3kwEPqb2WD4Cx+Lbr+i34BRfF+2VwYjc/DG4wEPLocgjvB4yUBrU98sFoqorl4yIo7T84t+RaM72OfnNhOoCyKvS+JGUqo+dov3uPnL4KWxphbmIoqvQK5pQvGmT3AdN1Ifbvl9G0d+2+5jQf+clsT52EvA5/xL2nMlYPaLtnBZpLmWORSAC2+oTKPgpF6iSTq6M+7kA2s3RRFbvNPRK3z54KkyVOmFoADCps2LPuE0XyoHqjTBnGNIrDUCqXZYVqJcvSLDyyyNgz4HMABuAp2gatY1M7sq0aQKmYcQv9kx7CaJY3vYU35OY+MJyckHi3Iz6Rx48aKWL9GSxo2c0DOD/APqUbwD29QwjmLtOLf6+MYDl48IU5BgNWiyGnnNJWC1UNQ1a7m3MLnwN53J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk54L2lDQUZ2OXpZWWF2Rzg4QzBHMTB2MDdBNDNjSGtSazZNRUYxNGRKT3Vw?=
 =?utf-8?B?M3FGSEkyUWI0WmNmbEhRaTFwcWloejQ3MlFoZ0pvanRNc1h5YmZFTnFLTkNq?=
 =?utf-8?B?bFJxb1UzaEM5Z3B1MklST0ptajFJclhTRHFxM202NklqdDdvY2VielNYWnBx?=
 =?utf-8?B?S3dnYjdkb1E1WkJZWEI3Z0cydTZHbm5IdFBiSEJuSG1RNVZrT29vZzE2OHNr?=
 =?utf-8?B?VXRadERYZU52dktuUWxiSGJWRC9RRkhwMHJ1M3NxYlk5SnBuNFZUREswNTRB?=
 =?utf-8?B?YlBCZzExbDlpb0tVTVJhVnZ0TEZCOEhVTDVsOW5CNEg1VGVkUGZDM2J1Q2hT?=
 =?utf-8?B?TXlBUkRoZFgrOFQ4dmo4L1hCaUdKMFdnWGcya081L24ySWlKbDZOMWtZZ0Zz?=
 =?utf-8?B?UWFnZ0JYNlpHWXZOUS9PVWE1TmIxMXNTQ0FRSVFtdmZTU0U0M3lXQ3B0L2hZ?=
 =?utf-8?B?NnRybVpYbzRnS3BtWW92TTFFa05yVng3UHVDYXdncEcxcklFaHZUMHNQTmFR?=
 =?utf-8?B?SXIvVEVoY2t4K1c1Nk1CanlFcjFvWTF6b1U0elJzZklOQ0VIY2xVK3NDN0N1?=
 =?utf-8?B?KytIOTM3NHlpbzEydjRiaEVEdEloRVVMR1JsT3VObE1NV2ZuczljRkNJUnJq?=
 =?utf-8?B?NU92VWYvZDZ0VkMvODdLbjV6OGZxVTdQalo4WlZZSk5tNzJ4MUVocFdoWmR1?=
 =?utf-8?B?Q2R4TlR5czUrbVFveHlCdFpsY0RCL2c3QXBpcUo3aXcxbzFjYm1vWnFUbTlX?=
 =?utf-8?B?Q3RnbXZFaW1RWGE1K1pxSjhNWUFFbTFsejVHZE5qbVVQSjl6cHhhc3lrcnND?=
 =?utf-8?B?bFEvQWdBcTJuQ0QySmltdEdGNkcyTDhMc0wzekZpQnZtNngyMnhnTzh5R3h3?=
 =?utf-8?B?K3crdlNKdWE3L21EVDYyaWl2L3NSTlM2ZjJmUHg5K1J3NldWbEtRcW5hMUpl?=
 =?utf-8?B?bWJDbHJsbzQ2VEtUS1daKzlJNjFER0VsN3BESkVOSWNiSnhwQ0hoTWpjdldl?=
 =?utf-8?B?emxyeWtnbndvVmtMeDNFdjdZRGlPN1piRVh4VXczNDdKeTJzNmUrM2RMVVNN?=
 =?utf-8?B?czBKNndRVlhocW1sSGxGc3QxQkh2aEREck9vWWRaOXBDdWNZdERWS1JYR0l6?=
 =?utf-8?B?Q011ei80blVQaTVhZGZ3MFM5bFlUbnVZSjJVUzY2Q3VLSlN1WSs3KzlhbkUv?=
 =?utf-8?B?VjJCR21yQk5zWHB5RmxYSjQ3WVNxc2RrMkhnaTVTTmVkTFN6VlYrUXZ2VnMv?=
 =?utf-8?B?SG9tWWlvUDI0QlZmRTJVREdsQkFtWkZFL0kzaEUwM1dSTWlyeFJUU29ObnQx?=
 =?utf-8?B?MmNNYWs5TFQ5VDJLU3NIM2RpUTNUZDhkT2RtVW1ReWU1L1RqYXN0a2ZNT2dK?=
 =?utf-8?B?RXErQThxYlk0SHBsbHhRRHVpdVFQaGpyZEROZUFuRXY0ZnpYblhoT3RBUi9F?=
 =?utf-8?B?TnZUTml3TWU1N2o1Vm0wRFlua0xxUzVKWElqc1laOFBXZTkrTkFMcE5JczZn?=
 =?utf-8?B?NjlaUldHYm96QjFFSUtHWUtPRXhEcUtsczBzdlpzdWxGTmpwWFhNVmlXWkQw?=
 =?utf-8?B?WmVLRDN5TERqRXdzWGJvaVFtQWhkVjJYS3VtQ1p0bVU4NzN5bEZSVUtKOVRD?=
 =?utf-8?B?L202U1dYcjBoZ2xrU1hIM1BZbmhXUUVLaUdOc0NSVG02MzRKZ2VNUlp6aWtD?=
 =?utf-8?B?dEc0a3VCaXpZdDdlN1hjVlpRQUJrZGtQVUV0Y3huc2l0OHJNUHI3cGVualFi?=
 =?utf-8?B?a21XaDNxaXBvWGgxT3JqaTA5ZjRPY2NHQmk3WmdKMmFvajF4blVlQ0l6YU1p?=
 =?utf-8?B?OVlMd1NDMXp6YTNrN2lMYjhOaFkxQ0V6QUhlZmZoWWFvMW51UUhaRjRIVVlG?=
 =?utf-8?B?aDRKRzBXb2dwWThPMmwzYWZJTkRadkxNcyt0bHhFMXJjd3A4RzhuLzJ1Skw2?=
 =?utf-8?B?eGo0b0VBZlpTMWV2SVFFbHhoYi9hWDVYVXh5aVpjTENVOU9WZ0UwKzRCaERB?=
 =?utf-8?B?bnhJTGlkK21SR0hMNDlud0hha3N6RFF6aHhQVStCTGhqdlJONlB3SEVxSyti?=
 =?utf-8?B?WHA1Mm1pNVBFZUFZVmlpNDBRMlI5SjRidnJVaW9ydU1Uc0tIRWR4YVIrUWd3?=
 =?utf-8?B?bEs1WmhKS3J4MXM2MllZeU1MWVdySU81NzByMXJQOHRxMlVURW9tejFFNTJw?=
 =?utf-8?B?SCtyK25EV1lnZ0p0aXVxYWxvUWxyaVRUVnl0T2NOT014aExjbVJ5L2ZaNTlP?=
 =?utf-8?B?TXZweGhrZ250dHRQWGk0dUduSDNtMnVPRjNxT0FIOXBUOWgwcDlJNFNHN0dp?=
 =?utf-8?Q?/9JTeqFLkNw/ps1GT6?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7209c9a4-71d9-4f8c-cbda-08de7467389e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 12:13:01.3248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijBVziMhlxRMLR+8Zi4Z1+HxxIu2LcDt6JVH+JRU3QBvcaqlntoS33U+mwwsn63yHWTC9/8k4RnvjcOmIxfN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4779
X-Proofpoint-GUID: HEGWrIdR-cwNT5hodqeDIoYvExXBLAFz
X-Proofpoint-ORIG-GUID: HEGWrIdR-cwNT5hodqeDIoYvExXBLAFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDExOCBTYWx0ZWRfX5ZTSbJ/2DDut
 UUBOAu+kESaYrU222oFT8fvnhDeSXx8kQksOC9MAyow+s+LZtmPqiu2IY2LCjCaqe5vheDhtA2F
 UY8FZYLbasUE3mOoCj9loO8m+NG7HjruN0PcL0nbkk9JZv+STBZ3MEgYIqhJvBMn+1Ux/QgSkS2
 /ca22xlvpt2oTreg2UpqxHGuLGyO+xDEFVhhPC4sGIJbaZz4r7VJXLfPtyzIFYxz0CW/1VDODp2
 IHtqOQUpOckN9hDxok1ROXiVJBh9bEwDAZHMGng6ly4NvtiYUQZR+y1T1F9+vZKP4i5c95vQF7X
 Jj8U9jGr93XNhtdZ9QxtKxuHYxM0sSYK+o5C80FjkwhTqZTwTo3KZUobMczSeFdAy/eO+s4oOSh
 OmLsPcdwhDXftHK80rC1+V4Cdthsq4IrueP1SyEAk75ETz6h64lBnSbn3kpiU2Uv3nE53nAWpOV
 g5bFoZmUqfF8IBuOXAA==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=699ee750 cx=c_pps
 a=BOmCsCMGzHmsfBvT2K/0Ag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=20KFwNOVAAAA:8
 a=SRrdq9N9AAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=RpNjiQI2AAAA:8 a=nOLp-5-4cuHo-82UfpAA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB3101971C6
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNSwgMjAy
NiAzOjM1IFBNDQo+IFRvOiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPg0K
PiBDYzogU3J1amFuYSBDaGFsbGEgPHNjaGFsbGFAbWFydmVsbC5jb20+OyBwYWJlbmlAcmVkaGF0
LmNvbTsNCj4gamFzb3dhbmdAcmVkaGF0LmNvbTsgZXBlcmV6bWFAcmVkaGF0LmNvbTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBO
aXRoaW4gS3VtYXIgRGFiaWxwdXJhbQ0KPiA8bmRhYmlscHVyYW1AbWFydmVsbC5jb20+OyBTaGl2
YSBTaGFua2FyIEtvbW11bGENCj4gPGtzaGFua2FyQG1hcnZlbGwuY29tPjsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6
IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQtbmV4dCwyLzJdIHZpcnRpb19uZXQ6IHJlcGxhY2Ug
UlNTIGtleSBzaXplDQo+IG1heCBjaGVjayB3aXRoIEJVSUxEX0JVR19PTg0KPiANCj4gT24gV2Vk
LCBGZWIgMjUsIDIwMjYgYXQgMDU64oCKNTI64oCKMjlQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
OiA+IE9uIFdlZCwNCj4gMjUgRmViIDIwMjYgMDQ64oCKNDc64oCKMjIgLTA1MDAsICJNaWNoYWVs
IFMuIFRzaXJraW4iIDxtc3RA4oCKcmVkaGF0LuKAimNvbT4gd3JvdGU6DQo+ID4gPiBPbiBXZWQs
IEZlYiAyNSwgMjAyNiBhdCAwNTrigIozNjrigIowNlBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6
ID4gPiA+IE9uDQo+IFdlZCwgWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2Vj
dXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczoNCj4gQ29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQg
c2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nDQo+IGF0dGFjaG1lbnRzIDxo
dHRwczovL3VzLXBoaXNoYWxhcm0tDQo+IGV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhr
cVchdGMzWjFmOFVZbldhdEstDQo+IDhHZDNhN2lMQUFoanp3TmFzZExEUnJEQ1AtTV94VUVBRUN6
OWoyZnd4V2xXcTNFdWdGZnpZOHVLQWhRLQ0KPiBRMlhJZFFzODlsZG5senJwc2w5QSQ+DQo+IFJl
cG9ydCBTdXNwaWNpb3VzDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+IE9uIFdlZCwg
RmViIDI1LCAyMDI2IGF0IDA1OjUyOjI5UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToNCj4gPiBP
biBXZWQsIDI1IEZlYiAyMDI2IDA0OjQ3OjIyIC0wNTAwLCAiTWljaGFlbCBTLiBUc2lya2luIg0K
PiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBGZWIgMjUsIDIwMjYgYXQg
MDU6MzY6MDZQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDI1IEZl
YiAyMDI2IDA0OjMzOjU3IC0wNTAwLCAiTWljaGFlbCBTLiBUc2lya2luIg0KPiA8bXN0QHJlZGhh
dC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFdlZCwgRmViIDI1LCAyMDI2IGF0IDA1OjMwOjMz
UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwgMjUgRmViIDIw
MjYgMDQ6MjQ6MTQgLTA1MDAsICJNaWNoYWVsIFMuIFRzaXJraW4iDQo+IDxtc3RAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIFdlZCwgRmViIDI1LCAyMDI2IGF0IDA1OjExOjQy
UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIDI0IEZl
YiAyMDI2IDEyOjI4OjUwICswNTMwLCBTcnVqYW5hIENoYWxsYQ0KPiA8c2NoYWxsYUBtYXJ2ZWxs
LmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBTaW5jZSBORVRERVZfUlNTX0tFWV9MRU4g
d2FzIGluY3JlYXNlZCB0byAyNTYgaW4NCj4gPiA+ID4gPiA+ID4gPiA+IG5ldC1uZXh0LCB1c2Ug
QlVJTERfQlVHX09OIHRvIGVuZm9yY2UgdGhlIGxpbWl0IGF0DQo+ID4gPiA+ID4gPiA+ID4gPiBj
b21waWxlIHRpbWUgYW5kIHJlbW92ZSB0aGUgcmVkdW5kYW50IHJ1bnRpbWUgbWF4IGNoZWNrLg0K
PiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNydWph
bmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZlbGwuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArLS0tLS0tLQ0K
PiA+ID4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYyBpbmRleA0KPiA+ID4gPiA+ID4gPiA+ID4gZWVlZmU4YWJjMTIyLi43
NjhhZDU1MjNkZmEgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMNCj4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYw0KPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTY2MzksMTMgKzY2MzksNyBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0DQo+IHZpcnRpb19kZXZpY2UgKnZkZXYpDQo+ID4gPiA+
ID4gPiA+ID4gPiAgCQkJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9SU1Mp
Ow0KPiA+ID4gPiA+ID4gPiA+ID4gIAkJCV9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LA0KPiBWSVJU
SU9fTkVUX0ZfSEFTSF9SRVBPUlQpOw0KPiA+ID4gPiA+ID4gPiA+ID4gIAkJfQ0KPiA+ID4gPiA+
ID4gPiA+ID4gLQkJaWYgKGtleV9zeiA+IE5FVERFVl9SU1NfS0VZX0xFTikgew0KPiA+ID4gPiA+
ID4gPiA+ID4gLQkJCWRldl93YXJuKCZ2ZGV2LT5kZXYsDQo+ID4gPiA+ID4gPiA+ID4gPiAtCQkJ
CSAicnNzX21heF9rZXlfc2l6ZT0ldSBleGNlZWRzIGRyaXZlcg0KPiBsaW1pdCAldSwgZGlzYWJs
aW5nIFJTU1xuIiwNCj4gPiA+ID4gPiA+ID4gPiA+IC0JCQkJIGtleV9zeiwgTkVUREVWX1JTU19L
RVlfTEVOKTsNCj4gPiA+ID4gPiA+ID4gPiA+IC0JCQlfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwg
VklSVElPX05FVF9GX1JTUyk7DQo+ID4gPiA+ID4gPiA+ID4gPiAtCQkJX192aXJ0aW9fY2xlYXJf
Yml0KHZkZXYsDQo+IFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCk7DQo+ID4gPiA+ID4gPiA+ID4g
PiAtCQl9DQo+ID4gPiA+ID4gPiA+ID4gPiArCQlCVUlMRF9CVUdfT04odHlwZV9tYXgoa2V5X3N6
KSA+PQ0KPiBORVRERVZfUlNTX0tFWV9MRU4pOw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gRG8gd2UgcmVhbGx5IG5lZWQgdGhpcyBjaGVjaz8NCj4gPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiA+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZSBpbnRlbnRpb24gaXMg
dG8gY2FwIGtleV9zeg0KPiA+ID4gPiA+ID4gPiA+IGF0IDI1Ni4gSG93ZXZlciwgc2luY2Uga2V5
X3N6IGlzIG9mIHR5cGUgdTgsIGl0cyBtYXhpbXVtDQo+ID4gPiA+ID4gPiA+ID4gdmFsdWUgaXMg
aW5oZXJlbnRseSAyNTUsIG1ha2luZyB0aGlzIGNoZWNrIHJlZHVuZGFudC4gVGhpcw0KPiA+ID4g
PiA+ID4gPiA+IGlzIG5vdCBvbmx5IGxpbWl0ZWQgYnkgdGhpcyBrZXJuZWwgY29kZSwgdGhlIHZp
cnRpby1uZXQgc3BlYyBkZWZpbmVzDQo+IHRoaXMuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+IFRoYXQncyB3aHkgaXQncyBCVUlMRF9CVUdfT04uIEl0IGNoZWNrcyBpdCBoYXMgdGhlIHJp
Z2h0IHR5cGUuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFdlIG5ldmVyICpuZWVkKiBC
VUlMRF9CVUdfT04gYnkgZGVmaW5pdGlvbiwgd2hhdCB0aGlzIGRvZXMNCj4gPiA+ID4gPiA+ID4g
aXMgZG9jdW1lbnQgdGhlIGFzc3VtcHRpb24uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gTW9yZW92ZXIsIGlmIE5FVERFVl9SU1NfS0VZX0xFTiBpcyBldmVy
IHJlZHVjZWQgdG8gYSB2YWx1ZQ0KPiA+ID4gPiA+ID4gPiA+IHNtYWxsZXIgdGhhbiAyNTYgaW4g
dGhlIGZ1dHVyZSwgdGhpcyBjaGVjayB3b3VsZCBubyBsb25nZXIgZW5mb3JjZQ0KPiB0aGUgaW50
ZW5kZWQgbGltaXQgY29ycmVjdGx5Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiB0aGVu
IGl0IHdvdWxkIGZhaWwgYnVpbGQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU28sIGRvZXMg
dGhpcyBtZWFuIHdlIGRvbid0IG5lZWQgdG8gYWNjb3VudCBmb3IgdGhlIGNhc2Ugd2hlcmUNCj4g
PiA+ID4gPiA+IE5FVERFVl9SU1NfS0VZX0xFTiBpcyAxMjgsIGJ1dCB0aGUga2V5X3N6IHJlcG9y
dGVkIGJ5IHRoZSBkZXZpY2UgaXMNCj4gNjQ/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhh
bmtzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHllcy4NCj4gPiA+ID4NCj4g
PiA+ID4gV2h5Pw0KPiA+ID4gPg0KPiA+ID4gPiBJZiBORVRERVZfUlNTX0tFWV9MRU4gaXMgMTI4
IGJ1dCB0aGUgZGV2aWNlIHJlcG9ydHMgYSBrZXlfc3ogb2YNCj4gPiA+ID4gNjQsIGRvZXMgdGhp
cyB2aW9sYXRlIHRoZSBzcGVjPw0KPiA+ID4NCj4gPiA+IG5vdCB0aGUgdmFsdWUgb2Yga2V5X3N6
LiBJZiB0eXBlIG9mIGtleV9zeg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBpIGFjdHVhbGx5IGRvIG5v
dCB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4gdGhpcyBpcyBub3Qgd2hhdA0KPiA+ID4gQlVJTERf
QlVHX09OIGNoZWNrcy4NCj4gPg0KPiA+IFNvIHRoaXMgaXMgdGhlIGlzc3VlLiBPcmlnaW5hbGx5
LCB0aGUgY29kZSBjaGVja2VkIHdoZXRoZXIgdGhlIHZhbHVlDQo+ID4gb2Yga2V5X3N6IHdhcyBs
ZXNzIHRoYW4gTkVUREVWX1JTU19LRVlfTEVOLiBIb3dldmVyLCBzd2l0Y2hpbmcgdG8gYQ0KPiA+
IHR5cGVfbWF4IGNoZWNrIG1lYW5zIGl0IG5vIGxvbmdlciBjb3ZlcnMgdGhlIHNjZW5hcmlvIEkg
ZGVzY3JpYmVkLg0KPiA+IFRoZXJlZm9yZSwgSSB0aGluayB0aGlzIGlzIHVucmVhc29uYWJsZS4N
Cj4gPg0KPiA+IFRoYW5rcw0KPiANCj4gDQo+IHBhdGNoIDEgaXMgdW5yZWFzb25hYmxlIGkgdGhp
bmsuDQoNClBhdGNoIDEgaXMgdGFyZ2V0ZWQgZm9yIG5ldCwgYWRkcmVzc2luZyBhbiBpc3N1ZSB3
aGVyZSBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUgaXMgZml4ZWQgYXQgNDAsIA0Kd2hpY2gg
aXMgb25seSB0aGUgbWluaW11bSByZXF1aXJlZCBieSB0aGUgc3BlYy4gVGhpcyBsZWQgdG8gdmly
dGlv4oCRbmV0IHByb2JlIGZhaWx1cmVzIHdoZW4gZGV2aWNlcw0KcmVwb3J0ZWQgYW4gUlNTIGtl
eSBzaXplIGdyZWF0ZXIgdGhhbiA0MC4gSG93ZXZlciwgdGhlIGRyaXZlciBhbHNvIGNhbm5vdCBo
YW5kbGUga2V5cyBsYXJnZXIgdGhhbg0KTkVUREVWX1JTU19LRVlfTEVOIChwcmV2aW91c2x5IDUy
KSBkdWUgdG8gdGhlIEJVR19PTihsZW4gPiBzaXplb2YobmV0ZGV2X3Jzc19rZXkpKSBpbiANCm5l
dGRldl9yc3Nfa2V5X2ZpbGwuIFRvIHJlc29sdmUgYm90aCBpc3N1ZXMsIFZJUlRJT19ORVRfUlNT
X01BWF9LRVlfU0laRSBoYXMgYmVlbiByZXBsYWNlZA0Kd2l0aCBORVRERVZfUlNTX0tFWV9MRU4u
DQoNClBhdGNoIDIgaXMgYWRkZWQgYXMgcGVyIHlvdXIgc3VnZ2VzdGlvbiB0byBhZGRyZXNzIGZv
bGxvd2luZyB3YXJuaW5nIGluIG5ldC1uZXh0IGFmdGVyICBORVRERVZfUlNTX0tFWV9MRU4NCndh
cyBpbmNyZWFzZWQgdG8gMjU2Lg0KKy4uL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo2NjQyOjE0
OiB3YXJuaW5nOiByZXN1bHQgb2YgY29tcGFyaXNvbiBvZiBjb25zdGFudCAyNTYgd2l0aCBleHBy
ZXNzaW9uIG9mIHR5cGUgJ3U4JyAoYWthICd1bnNpZ25lZCBjaGFyJykgaXMgYWx3YXlzIGZhbHNl
IFstV3RhdXRvbG9naWNhbC1jb25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZV0NCisgNjY0MiB8
ICAgICAgICAgICAgICAgICBpZiAoa2V5X3N6ID4gTkVUREVWX1JTU19LRVlfTEVOKSB7DQorICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgIH5+fn5+fiBeIH5+fn5+fn5+fn5+fn5+fn5+fg0KKzEg
d2FybmluZyBnZW5lcmF0ZWQuDQpTb3JyeSwgSSBmb3Jnb3QgdGhlIGNvdmVyIHBhZ2UuDQoNClRo
YW5rcyEgDQo+IA0KPiB3aGljaCBpcyB3aHkgcGF0Y2hzZXRzIHNob3VsZCBoYXZlIGEgY292ZXIg
bGV0dGVyIGJ0dyBzbyBvbmUgY2FuIHJlcGx5IHRvIGp1c3QNCj4gcGF0Y2ggMS4NCj4gDQo+IA0K
PiA+ID4NCj4gPiA+ID4gPiB0aGUgY29kZSBtYWtlcyBhc3N1bXB0aW9ucyBidXQgaXQgZG9jdW1l
bnRzIHRoZW0gYW5kIG5vdCBqdXN0DQo+ID4gPiA+ID4gZG9jdW1lbnRzIHRoZW0sIGJ1aWxkIHdp
bGwgZmFpbCBpZiB0aGV5IGFyZSB2aW9sYXRlZC4NCj4gPiA+ID4NCj4gPiA+ID4gQWJvdXQgdGhp
cywgSSBhbSBvay4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzLg0KPiA+ID4gPg0KPiA+ID4gPg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiA+IE1vcmVvdmVyLCB5b3Ugc2hvdWxkIGFkZCBhIGNvdmVyIGxldHRlci4NCj4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcy4NCj4gPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiAgCX0NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4g
PiA+ID4gPiA+IDIuMjUuMQ0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPg0KPiA+ID4NCg0K

