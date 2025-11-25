Return-Path: <netdev+bounces-241608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8155C86C3C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7C743537B0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EBB33375C;
	Tue, 25 Nov 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="1oEnR7R/";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="R5R6oWbe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A404333723;
	Tue, 25 Nov 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098330; cv=fail; b=pixVE7K+NfqZEiBj8reGwCZh8hB/hxIaHQq/odFUxaOCfjOhzqJVj8zWIT6TRu79aaO83XBw5EnvucwAZshy85mLHQ5vNh7wOob3KezRTDTdGZI5aFyEElEXfYYpDESv3pqfO4zSRmlYD6jP1DZfRzh9yZRMnYDqiNmbuN3uwx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098330; c=relaxed/simple;
	bh=kGu9jAnS30gPE5f4YK88Fj/gFqF9bof6OswUAJlscN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXr5Bh1pITgv3fYwptbSK+i4HuV08qcVBflY4Lcg5TBYiw/INgFKlsoXsHrfKg4hf3tZwLwS4NSY12un8CwqSfcTe4BaeWcwZSVqs8LNkJTaaZp5gCiq94sa6x9yyqvepRs9VYxYidpV28U+qBOvanUS8/796eSuSuGnhDmWQZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=1oEnR7R/; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=R5R6oWbe; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APH2KDc4034968;
	Tue, 25 Nov 2025 11:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=5qnwSmb8KaY0THyUZN1S1sChxZiZ2rl2PmN2y5DCS
	xM=; b=1oEnR7R/EzZ92vvg7MeHChJ/4LpvK4e0gISadHq2kVCiJcj1TYjYL/Hz3
	aweUd7zz3ezS6nL8F3pXOqKQm69o+siJxNflQsy8mlNsz3tfQSAL2F1EqaQx5FRK
	prLThFalWvDtvgWsMAYgWysOavm+h4nj6yMQLkXtrLcuBECg4kN/7j13Q2rM8+u0
	BcwCAXHmII6ja6pcQOQfcc7VMZVWa+SH5BBam8JUrIlz2Cr64uw4jAlUvYl4tleq
	5/av+vBA6Aj3wWoyR848HrfHfGJatrLrSlQESAru0cwxnW5tVA2d7Fzes6ikbiYA
	qdvpca0w232YqEnU8G7H89YSFLVlA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022073.outbound.protection.outlook.com [40.107.200.73])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4amvp52sem-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mgu5QmIRtEZD/gjyKXaMHiyQSnGxMduuP2EqsX0PP2pW15HQQETOk38NQNpa7f69Sx3Uqx2NFa0jIG4L4j8vSyQmnBjj/BUXZq5gUGhuw4s8SRrq3LSc3TZYa58vo76tj511Cz5cSMuwp8JlKFhLZO8lYHad/ni2JQZD/dRYnD+wC+BM0tMxz+jKPPE8OgrP9RUP1WY4MyouJtw3c2M9ZWjUiM0LZPr3LDYsnxxVur554bicXLjIId3gGzXN+KWVqFR5wpWVYibuIqNrsbabXTXEujX5kJ7NALRXcbJ2Gy4m9LLgDWBzC01KcPQmixMB/qwU19nNTYgU9D0iXwa4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qnwSmb8KaY0THyUZN1S1sChxZiZ2rl2PmN2y5DCSxM=;
 b=IcrcNQW9tWQ/JZQOgQg5igQ//95IU+CkZlkqnbkuWiR1oCB8KmpIlmm9bC6Ulm/RSsKJ+/5Dv1NnN90CoeQdgSTRT+9REGCwOUeAyH75uhvJA6mAWAM4lFH91IKEX6wn5ZZPu1ycCUSa8szzO69KttmjKX4T/P2KArHbzv6pUYo4a9tnOlE32qNXrhm9I/ZRR/KuVlBem6hljjaMOfF7ZAFA6o3nr84I6gVJb1lIl7HN40fgfqKNuUyemeNWB/1U32KUoftwydHHVeAC8YnXRCmj2k/iCL0P0wE3/XvzgXnXxLR4eUa9cKQgFVpTqvwmAipEl0YeIp/eFE2ktVx3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qnwSmb8KaY0THyUZN1S1sChxZiZ2rl2PmN2y5DCSxM=;
 b=R5R6oWbeib1kXw0In53VtTKSQNsbhqOAsP5TFDBc0yUWXMApfav+c47WDDW/ZH+Qrw5JDguvCw0QgSpyrLYo1+Tusq/oDJv+IQEgJ0XKj1s6WXoEs3MRfefU2J9s5ZfUgDl+VW/QUaWqS17BpGSMfXXHdCR4JuMV6s4jULdg+f5V9PvACuuFZQ9w840xg9Gz82TTU8WKTOVH+tr8pMqTb8niuT6yGJ21mRRtLh2uY6yEGWZTZcQ0hfv6+VKEuo5yeBAhnbO2/Bw8Sqrfzy9Z28N2imdzXFVuJ/17I9xfpftuN/KIRpNw2jQ/5u40RufIpTcDfhR+uGSDUVrmc190ww==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:38 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:38 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Ahmed Zaki <ahmed.zaki@intel.com>,
        Samiullah Khawaja <skhawaja@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 8/9] net: core: export skb_defer_free_flush
Date: Tue, 25 Nov 2025 13:00:35 -0700
Message-ID: <20251125200041.1565663-9-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 141b6c42-435e-4a69-6045-08de2c576fb8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtrFkevC7uGzjA9Yl2iyP1OaZD4Tb+64a7OjDrclGxi5Vj4ocSJ9QMDxxwBO?=
 =?us-ascii?Q?wyFnsR87amSqJdpR2HvUIfPZFy5HbUACdu/gL3TB7Cia1U/F0qxO80VGt4NE?=
 =?us-ascii?Q?3HEnPDL93oPWs5F9GTFX4L9GZLpVoTjTV5J8D7C2QNcpQL4h9rY0j3JptcQ4?=
 =?us-ascii?Q?b9YFePkIfa4G3MmsZ4uXrcR3usmWYDvzzi7lJv4pUzYBXita3rxEeBdxfjKh?=
 =?us-ascii?Q?gXeSlQ7R1ZHtSxQTQeUlppOWm2NP4YfngOelCn8gkAYt9G2/xLoHTlwQIJuw?=
 =?us-ascii?Q?heb92pUgpPBQcRvowWCjkqy5Oq0nOdacpoGZ+p3Mq5aQrkRfMaCwnShkFel+?=
 =?us-ascii?Q?lFInAejvoqkA8z+0+L+bq6S0+vxhSQmkP6LtMAzT81ehwbCNkbh15saAkN+A?=
 =?us-ascii?Q?bqWSYnAQu/re2jVHHdV1r8NKOMpdvqo5gpkmLx9PFBLGCHZNHj2Bkqb0cDF0?=
 =?us-ascii?Q?fX61hxkQLWEgOlWaBFo4Se/0AKvBPhSaaivbF9pN4sBHimdtEZU2Su1jzIdQ?=
 =?us-ascii?Q?VhA2eO3a/uWHaaFviwvHAqAwAgTEjvN8fuIYUy66qvnaSGRYOeV+bTyzuCuj?=
 =?us-ascii?Q?PJ4u5/ZKetI6tEqKXBhnKAZhTtO60KSYYKgFmjlv7/bAPM1I+U1MskvHKcXZ?=
 =?us-ascii?Q?fCWwAfAdTVVVHwrDypv6RTwIDLFrBkZRXZy7CFg1NKZeNnVE8tYiwBNZ7tt3?=
 =?us-ascii?Q?f9R/ycZGQ50lkbFO6kv5STehMW/9C418XVatgTr+wfG7zk6hHZ114M8YXOfp?=
 =?us-ascii?Q?V9aBXgStpgsYEJ4OKWR60dZ9J4XImd7zmlKmFrs5G9zjqA2B1R3eMyyRsMs8?=
 =?us-ascii?Q?4k3PSpMlOyHN8et/hosaSDzOvUmD6gXxSjqKwv0sr0H8MJGel/fvfkVBm9BZ?=
 =?us-ascii?Q?LIwacdoxw3VxQVBeBwk0zmskL6zYeEutDLkpWR/2NDyyGazKcpatIQ6yqXD1?=
 =?us-ascii?Q?DgvAVMuLk5m6olhuGKWrsdlBwRbJkrhFQhbh+AWOfwUxSkOoFItRh/Ptm8AI?=
 =?us-ascii?Q?cFui2lVk0c3OAyD38hLmJ2xtK9LQ/EQMcFbW9LXXqfcYC7EXb9nh+RPt5GJG?=
 =?us-ascii?Q?r056WTI7sBUKn0tap/AekCXg1DOIavTQQtIL/Hc7vXpShyUfec0LNCho7Af/?=
 =?us-ascii?Q?ER4Cf2hMTMflVcExLYunJFk50daUB4eK02RIqfqpKrhPDbhrjMizFW2+iu6M?=
 =?us-ascii?Q?1UWzSSeZW9+UXTbmey1NcuTn9MChPfvn8pZD6uI1AIIcDxiLsh4o6AeMmZkL?=
 =?us-ascii?Q?UenQF4pd2RWIDx4CQze9IGqyzD/B1IA2pgZ8yC5XnyUr/TMapSXk76D8lcwn?=
 =?us-ascii?Q?5QS6rhg+/0g52F7o3K+acKWJKbiI4heXCO6E4nc8gUNEeZmwOtAkKw9Om97X?=
 =?us-ascii?Q?LZUwZjrszL/edRwmjnO0+o5hoF/cQlZIuay1I66I5NltBqwIPtxLC2Ty40sb?=
 =?us-ascii?Q?YVnUEBcdscqyAFY4/orsJbHeFt7SiOwcCqNcevZQeCdMdJLp/jfkCHuJl5ap?=
 =?us-ascii?Q?OOtDYlKNFMq1r8e20Y1BNbB2/ZYnjpckARpqq3bpXW45S1EWwDqssNyhGg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMypuXfP9VopmhTFI9Pyhjgy6dwAp2laYbLLm4qo97OtyxW6IckfgboZbzgU?=
 =?us-ascii?Q?FL5nLi+oINVALq0u3lF4VfpwMkDyj1bzO2Z8ROxhUT4opQO7UIvmG391yb7d?=
 =?us-ascii?Q?+KfvpptBVN+RffwUIvgfoxqSJL/qGy7K5xnAnKYstKWIM1L5fYTWJ66rY/aG?=
 =?us-ascii?Q?hVH1CQMxIrieXLsZtxp5lFuQM3JbcuThfjNWTPi2ZVMNUCaJi4oJuhxVL3LF?=
 =?us-ascii?Q?MlLAaV6fhmHFYX9JsQvPN5NHj8FzeNBXl87PVPCXPy5XXu6R1SsMNl44+vJu?=
 =?us-ascii?Q?RJYWXn48AmQcoIl9Z18nqQDLJ9MM/ix5qSMxzrFlPPdreULkg/2vUyDtve1F?=
 =?us-ascii?Q?GnJxPue7hhCJtYdLwsUnZJyEdHuD+C2QverMQMb8M5At5y/V795UEuP2Xz3/?=
 =?us-ascii?Q?8coOHoPhQMY/jS78ysQ+YRnDdjFN0O4Ns8AByQU6+dbGTlzyQ/eQt4Can72R?=
 =?us-ascii?Q?GajNHxNfu8FMQumHvVu/3tTzqB7tLV4qORzh9kX5ELfzP8nz2re2exjI8nkr?=
 =?us-ascii?Q?QztMtD1TlNWOhi/oNGQVUd9W1FTG1XZucJnoXjyecs1VnN2z21DfhlLXZ72Y?=
 =?us-ascii?Q?ra3yadpSIDEJJcWfWFwQ/mRZ/SnhT1UC4rXOaYunEeyhnHcRbe1JlLh7/mWr?=
 =?us-ascii?Q?Eyq5TPK7jmMIB1TlHiw0l7igw83fj60aAbUE+aQayNT7hmrSsvzIJyAvR/L+?=
 =?us-ascii?Q?Oli94DI3/ibpGcI1Hbg9JovMZkyuaEB05LEExCko9z5D544MiKCv1bsokQM+?=
 =?us-ascii?Q?oLDIn1/wTBzySvym8CiQ+KFiF7QT0+wY3W1w6lJic7QL88ykuPYICB2eyqO6?=
 =?us-ascii?Q?5H376F4wdOT3obxSPGodsxQyirDV+Au8SLSfkV5zSJyElLBsiRfzUrYjJmXI?=
 =?us-ascii?Q?v24MD4nmoTA3RnTAqQbGkSlEq2YrxFMDEol6UQ5Z4Wvqx2+NA23IT9+SN2ah?=
 =?us-ascii?Q?iTrG2TquoE1MnhvtUgmkCLHDYpg84BFDM1rnHL4agZyvwQn3pZx8WIq4UXyi?=
 =?us-ascii?Q?y8rqULTQnZrI0IC+OzTD5Qsv0furlUSF7Wqo9ERUoODITAiKO/fN6lYI7ZyS?=
 =?us-ascii?Q?ZlQlYvHpx3W61YdS7vqqcyaeTsxac2PeksWPoWb0TQUBZ7FNy46SkCA8BzsN?=
 =?us-ascii?Q?t6zdHWy0ry4mTLPJc10Sc0Qydz+q75ZtRZZtPrHYRa6P7xxeSfBZTxWaC00O?=
 =?us-ascii?Q?FqNZlEq4YAQfl7HSdyXSycuLIwrc6rqgLt+2L81KRpadB6Ulia+r9xqeqkyT?=
 =?us-ascii?Q?GyXEZF49WprP5bhn115vHjKSif3ydMR78qlwBFXZ4xdj+2pYGzMI3IJUpXRx?=
 =?us-ascii?Q?qG/4DhKQRNYxeY10gqE12L415o0DMXvmG++2WexoIjFpu7ODc6j4caHVUxEi?=
 =?us-ascii?Q?LxEGJD5/bcxKJ90dhHqk6fCkUeYw/QQAxp7O8mdFRaQA4erlhPP5UHoGNUVU?=
 =?us-ascii?Q?rYSBXpS2m97iiLWcSTglSvGcegGNgSgZ18i7nb/Xih6IBOV1B1izBkvbRQkQ?=
 =?us-ascii?Q?VrxqMHA10QA4pxQSeREP1jKk4di/cqL9cE0G5+4FQkMgrv28hMda2oezZtuE?=
 =?us-ascii?Q?u/hQDDlPbiucD0JciAbNXFBF+Pbc7jod508qsOv2plkc0nkrtuwHsLf1c6Sr?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141b6c42-435e-4a69-6045-08de2c576fb8
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:38.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG7mD7UmeCSM3AKIiU41KoRo0Oz5lLAfQWVmGDhuKFWoSBJQO1sRHO4jGgYfYIXPsGbeDZiBKOv7eCg6ezuwcbviIFZ1KcyIq0SHznUPX4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX35I+B3+vsIPC
 fMpklTczDZ/b+AQRCKOs9AXeM2qfO5y73FREipZmV3LzvfiAZZcUg+KszswPmE2V0NVHbdOWKGY
 DDu2IB7pl1Ymhl1wJb71DDSb5DrEbhoMb8MzL/tg+EPcbvQA4tciXc2mdDZbvMr4cpe4UuqmE5V
 1oGclmuGs5pCKzHuVaaoqg+dHNU0Z06BrfG9uHE69by7PHCmQoni+yNG7cu5RUFT2DBP/4AYlWV
 m70idsjBvy0pQPGyZC5i4vBKQv82mvoIV4OTyXJOlY4/4VWJoSSGMiOfr2IUkDly57DvjBRUimL
 rTrxK8i3i2LULQqjBKoCELj9GrbWdcMnkeILeyUWJaDJwFZ0F4GkcHn2CqT7cm/htMSHxMhduKX
 YvMTID6RYtpJrdoCwLN5wzLb5KmMJg==
X-Authority-Analysis: v=2.4 cv=aPz9aL9m c=1 sm=1 tr=0 ts=69260110 cx=c_pps
 a=mhBramkM2YKFwkQI7AGxcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=7N2qtYrztvdXu8S0JGsA:9
X-Proofpoint-GUID: xMDGOGGBxbG-lXB6fAeC7hMjxZFpZufX
X-Proofpoint-ORIG-GUID: xMDGOGGBxbG-lXB6fAeC7hMjxZFpZufX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Export skb_defer_free_flush so that it can be invoked in other modules,
which is helpful in situations where processing the deferred backlog
at specific cache refill points may be preferred.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 include/linux/skbuff.h | 1 +
 net/core/dev.c         | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ff90281ddf90..daa2d7480fbd 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1365,6 +1365,7 @@ struct sk_buff *build_skb(void *data, unsigned int frag_size);
 struct sk_buff *build_skb_around(struct sk_buff *skb,
 				 void *data, unsigned int frag_size);
 void skb_attempt_defer_free(struct sk_buff *skb);
+void skb_defer_free_flush(void);
 
 u32 napi_skb_cache_get_bulk(void **skbs, u32 n);
 struct sk_buff *napi_build_skb(void *data, unsigned int frag_size);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..c4f535be7b6d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6774,7 +6774,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 }
 EXPORT_SYMBOL(napi_complete_done);
 
-static void skb_defer_free_flush(void)
+void skb_defer_free_flush(void)
 {
 	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
@@ -6795,6 +6795,7 @@ static void skb_defer_free_flush(void)
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(skb_defer_free_flush);
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-- 
2.43.0


