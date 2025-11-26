Return-Path: <netdev+bounces-241722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD4C87AA4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04CF3B38A6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD631D6187;
	Wed, 26 Nov 2025 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="sTuayrQT";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="IPTKqBto"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024179DA;
	Wed, 26 Nov 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119756; cv=fail; b=XoDHdbqkKgwbk1mMZBtxqSeNEhaww+PSzWzgN7Cv9HZlMY/t2syyv9uJFQxzjVG++4FypJrdFlmuy/zObgYAc7kvcuj+wYU/Tlw/svFc6ABGzqr5SkHtFxfTLvYNQTfIKfA2IXi1vBhlJm/DmxSRvaRhYg4v6UpdZylKXnXHpQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119756; c=relaxed/simple;
	bh=4nzJ+LoNyC0A0xL58qLvVl87TkF+ly1BSsTQGf0Totw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cL3fr89O5DxIN1zHF4fWEpY8QVT23RdxuT85vCZpapEx+rPsojHytwAXIdGD0iIgLjf01PkeXxrmv7KuI5oNobmDnqFReh2ov5i/LdjZl66xgAFlRPywyhdYWQmLiurB2miYzFuSeDyvSFtWLFHoGKVIn8PztDNwv3HdTmz4/QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=sTuayrQT; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=IPTKqBto; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKdQo2184076;
	Tue, 25 Nov 2025 17:15:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=igPhNwdXVQAVG
	ixp3S+u3WIVK3ntv57+aLsbg/QksEs=; b=sTuayrQTZ3RGZTJDi/nZewXHIN7nn
	AQqviisBs23hNeBA/XPWwTg6LvrcYNOOKqwPqEyByIGJe/KdiZ4Z6AYGZw2vxMnO
	Z6qfQNbx9h3NyI4lYIcWxJaXOnucLfUDqIpThs4ILPVw3o6On2R/pEHorxNjfRgg
	L+iHmPBrtBBLvwSDRWLKMTeJfTkDh5zjGDWWkQWK4O3pXMIOyR+gza0KLXdGDJv9
	ONDzzaK/ZtFzVRezDFIc7yi8QezLT/+LQHc7Y8APaOiNKEvYzTRT3RMDMkqdFOQR
	jDk4l8J5gd1zG/YCKZMg7s/PVsq3RDXOY8tYB3wRVjQHKSAAXPMikOhyA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022120.outbound.protection.outlook.com [40.93.195.120])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40xjj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 17:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/qLS2TbQEgrkMukhyoh2sKeFRKIl2sS70wB8PI5X6L2ufgVVaPcM4DA5jJtZ3JE+NyS37351PwLFKeuD2ryc7FHO5ccDKhoVC6Lioh+m8hJwL4S3SHYEQ3JVtyfX9Vo2YmQ/LIVjIAnSMM3gotA/Zxmv0Rnh8PcOJf6uI2LF7NWJcOcSq/P7Nu91Sa8SjVgQJhIOTxcQeXHfaJh51p9ThbDtdDaTsepXQC6y28/WLBW+faSAtaJ3T5NNmGdkhDxUDn10rrv8BZJbFJh+4s8bozhHFAZF2ky7aQtwZwsDEz5JSdrPU0Lllx+w1dlx6Ges81b/nwYIQnGHzyMvpRwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igPhNwdXVQAVGixp3S+u3WIVK3ntv57+aLsbg/QksEs=;
 b=u5+yShewWAJZAhBOSUjU8RqmCLf4+lguatkf8x5LRwa1kAdmsFrCzQo4/XO8xQyDxwHv6+JVqT1HHptUtK98eXc1/SKgMwXiqIvDXmoi+ZLQtAkkXg5Y0bPv+AHM8XwFCMC45uKFXArIj+PJrZLuxUlWxf9V1G/1V9JmkXSUI5LAsoAogn4yypIirPdULSPcylwYIWEBC8TOAuWfCQmXOCxSZdVkl5VNoQgxXcQlbBBB//noNULlko54GBJ+Le8aWGOm/m7cMfnIge24XjIVPogMmLsHKKvHtEBCTd8epYX/kDaL6T9VZlyjxc23Vt6gEab/430b2PYiWjLoTMB1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igPhNwdXVQAVGixp3S+u3WIVK3ntv57+aLsbg/QksEs=;
 b=IPTKqBtofRGk3KA8eoVDE1WuPS2tMn5r2j4t2zZS0Fv7u9iHmwbNKvQ23P2cHgZDkCZc9QCXqk28H3VrPkhf4QhN9+Ul+s0eVDLujmr194WYSTz8Lr5RZvae4Gku4mGbMt2JYTY79f/EmanVhyF8CB26qOZ5lkUIqSyGp7opAIMXQvAxg7qraIAa8PwrSnILVqzJhdMJ5f3v/w9jSgtqQMXWKqkpGk5PP6PnbbmUB/mW/VJSO0eee/atqs87mb8WK+6xDU/CSI6KiyrUBSarue18vHA/hiWJ6SUR3jB10FJ+fyr+dhWwTBqelrP4BQOLP0Cy8cXY1v2q5cBf7lKgpA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BY5PR02MB6962.namprd02.prod.outlook.com
 (2603:10b6:a03:235::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 01:15:39 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 01:15:39 +0000
From: Jon Kohler <jon@nutanix.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2] MAINTAINERS: separate VIRTIO NET DRIVER and add netdev
Date: Tue, 25 Nov 2025 18:57:48 -0700
Message-ID: <20251126015750.2200267-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::16) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BY5PR02MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: b326381a-dcf3-4c6f-a1ea-08de2c894fce
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDAxenZVb2pTOTZwb2gzSC9rZDgyNklKQjg5dUFvQmdRb01GNDkvU1RJaERo?=
 =?utf-8?B?aEdUbEprVDBjUTNBN3lacnBHSFRrQjIwaWJ4eHpVQnNYVGlqYS9HN1l0NkVD?=
 =?utf-8?B?eWZISmZBUEk3WU9XU1FmQzI1OWo1aS9zUi9HS3huM0VROHhJYU10cjFPb2cr?=
 =?utf-8?B?SmNrdnlnMXZlVC8rRkVTR3N2dkdpQUxPd2RGaW1ZdGxEQk1hTGhJS3cwSDds?=
 =?utf-8?B?emhHcVVXVGIxR1k3c296ZFQ2S0JiLytrYlV6QXU2dW1pZDNwZm42OGlvL0th?=
 =?utf-8?B?eFpuckZJNEt3aFBGQThDenpoMUE1TkV3cktldEtIUlNmZkM3MDNvQVdicWE5?=
 =?utf-8?B?VlRGb0Z5dTNSTG1JbWNMMXlqQlpxck9KbnRzQ3NMcFR2OEp2TzJYM3dkTVpl?=
 =?utf-8?B?MHRHOHcycGpDazNrZUxxVW4zcDdPWkRnY3cxSzlGWkpxM0NLS3ZxY3FkSzcv?=
 =?utf-8?B?ZFhvSnZVYitWU0Z0QmQ5Z21yR3ZUa2x6YnAvWWJxY3QyM0d3c1FKeHNuQnBE?=
 =?utf-8?B?SFhsYXRFVnZYOWo4eUJqUDFpTUYzQVdubDk2Mzgwb0xyTWpTM09KKzV1V3pG?=
 =?utf-8?B?c3B3SzQ2Qm1pSUplUFFhSkQrbVhJQlF4eUswdUQyUm0yb1M4YTNuSWNYWm03?=
 =?utf-8?B?eUhyWjlsRlVWZFpUM1VUaEFQS2hPOG1VUDFiOGh1c0tPZTdkd3Y5NTc4T3Ns?=
 =?utf-8?B?NVZIYThWZTRSNzVIQ2E4MlAvSzlrdjd2K1d5OGdhNXJhZjNUOTJXWm52ZzF5?=
 =?utf-8?B?QWRjRXoxb2Z3d2RCYnJUWUM0UUM4VEFGeVZ0dnljWlhLWUxtT0NCTnE5NGpD?=
 =?utf-8?B?L2xpcnh4WHk1cHRFdWk2RXVXMHdKRXJDVjZXU1hkenJSV3FHT29RVVFKbTU2?=
 =?utf-8?B?bS9LY1lxYldzY00yTllwNW1jYUhsQW1vbnBGVlNZenFjSGV3ais5OXVJQXpS?=
 =?utf-8?B?L3VTTFArNkFjMVNhNU0yTTZQbThBNng3ZTNvZHBNelArcVp5Z3dpWjE1a1ZX?=
 =?utf-8?B?Uk1lSG9Vd01LN3JINXZvd3lKWHFabWZXNnBCbytHelE1MnJtNDliNmNiOG0y?=
 =?utf-8?B?aWZGc3ZjdGlrTGFIOXYvSUNSUlk3c1FMM1pyUEtUeGR2ZC9KMlVpVVRrNEJZ?=
 =?utf-8?B?RFZpMkNuT0JIZWx2NUo4VDdPZnpPcHdxeTE5Zy9uaHpXU0NrTWJZc0JYQlk1?=
 =?utf-8?B?eDBvZkpLM1E5bW80OXlQUGhpOE9zM1JBSFdUL0w2U3lZb2cyMW5PdCt4eTJU?=
 =?utf-8?B?YUM3bm42clVBMXhlZXpJNzcreW9CNklWcTlhNklvd3I4U0ZLU2xZMUJYT0JD?=
 =?utf-8?B?NmJQUjdhMXFrL21yTmw2dGlJa256aTBJek93Z25rUzEvcXNiVGFHOUhLcy96?=
 =?utf-8?B?RG1iZ01TRDZZMVZCTG5oYTZva1FrWlNGZm8venlPTXVrVGE2QzExNmlYbStC?=
 =?utf-8?B?Y0MvU2VKQ09ERmw3c284SExjUDlaL1dNd1M0MlRqTTJlazA1V1FhSUptYnNU?=
 =?utf-8?B?YVFTK3VOb0tQL1JYVllScUFyNWZOQnNWQmxhdzRmWGF5eUxXQ2FEc0dvQ29s?=
 =?utf-8?B?RVRuZVA1WGJrcmd6RG1jSy9hOHJ1NEg5emFnY2tncTBsenVCZDhXcGFDK2hw?=
 =?utf-8?B?NHdLd0c5aGVBOTdlQmxISWJZNUFscFdINXA5bGVRMUJudFFsUCt2WGJKRjEy?=
 =?utf-8?B?S3ludG1Qaks3VWo5M0w2cCttcEVKYUxhQ1VkTUhBK0ZwN1dObytIQU9hbU45?=
 =?utf-8?B?c3lCMUFQTVpmSjRlTHgySjBPSHBxMEdVRVdqU2RDUkVOOFJSenFiZ1BudWZ1?=
 =?utf-8?B?NG5UaWNZeTFacFJhbUtRU0hEaG1nU0t3QnNrMjB6dUowa2FySTZHK3lMdVRp?=
 =?utf-8?B?UU1rYzg5UmdRaVU2aXo4dzBRSzJ0MXdLNjd1SzFaZ0NnejZINjRTZS9vajZF?=
 =?utf-8?Q?U+mj0SjD1XsCfa4Q1iRrERcRyvoyWBeD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGlGRTVxS2lyRjZ4RkpmYjdBZVlDRlRHZ2xkM2ZFeU96OHZwYkFUdHJ2bzJ3?=
 =?utf-8?B?NSt1SjhDQzczMm90RzdYZW5BbFA2cC9abWtqMUxwbE5IZkwxaDRQSSswSmVy?=
 =?utf-8?B?RVFHQXI1dmdUdlo0VG15dWU0L0pySGtZcFhDd1VTbG0xN3kxd2hSWHF4M1VR?=
 =?utf-8?B?WGZTdVBUaC9pZWw4eTFNUkFPb0R0UXV6a0RhUHlOa3F4VWl3YmxPeUJSR3R1?=
 =?utf-8?B?R3R3SFMxWDNoL0UrRlBUYXBIUXBKaFY3V2RBUDhqNmo2NGVWbDdRdmUxbEtM?=
 =?utf-8?B?cy9tbnlEcVpZTFpFSmVXbVhZUmxMQWg2RmVEU2dQeFp4UU9lYmRDa1J5eGxk?=
 =?utf-8?B?UDFZT2RSV1ZjQTFUaGVvUUJjSFBBczFVRWwvVXlRVmVmYnhUdVR4eFV2YytC?=
 =?utf-8?B?SFhHQ2E3dnJycnpQMUoyZnhCM050YW02aVpMbG1lMTVpYzM1YkRsWHhHMWJj?=
 =?utf-8?B?SFQ4a2YxTnhLRnFSYnFJeUphcGlRRmVGQzRNMFI0eTVoZzlmKzZQNUFzTC9s?=
 =?utf-8?B?K3Fsa1NaeVhnbnhDa3ZNdVVGc0JOUHpyV25MekxlaHA0LzlLZjJBQ25yT0RO?=
 =?utf-8?B?a0hWOXB1SlZVRzIyZWgwLzVKOW1PK3FzWWpVOHdBNmNaK3JWc1RKRUxSb2ds?=
 =?utf-8?B?RHR3QkkwNHBaM2dOQ25yekFUNVRXLy9iZ09VUkZHUU5TbmYzb3dYT2ptR2gr?=
 =?utf-8?B?cVBCZWhGNEZ4SXR0YjNjWGczOG9hd0JOZGdQbHhPaWN4eFVvc0dHZFJ2bmVQ?=
 =?utf-8?B?d2JxR0I1ZTRsdU5HakpyazFpemtyRGdDdUFCMTZBOTFwWWFmTnR0UzVPb2JD?=
 =?utf-8?B?ak1UTVI3VEVVQ1UwSjdnVmNOcjVJaTBVUmlWT0VWTDBzNkdpM0x2Tm04bEpL?=
 =?utf-8?B?Z2x0ZUJZRzVsK3N5c2FTRDJxdEhHK0huRHZXaDY3cVI1S2xKMVVucE5TMkpU?=
 =?utf-8?B?SktiZWR0SEExeVFnUHVsZStWRTI5ZHJLM05yZG1mS0pRbE9JU292alF1STFh?=
 =?utf-8?B?K1RPN3Z1VVhDSVhvdWIwZ29HN2xOeG9hb0N1L3IySG5pdWlNalk1WGVlTjdQ?=
 =?utf-8?B?WjZjK0NucVFZenNtWEdzTE11d0tQM2Y5RTBPT3pUV1plRXRuWE04TkNpbS9n?=
 =?utf-8?B?cXp4VHNZNVRLS0c3SHlNR01lcEl2RWNTZnh1UEZKaXZYWlN2NG82TkZ3dTNG?=
 =?utf-8?B?eCs3ZmY2OEE0NjJ1bWFNSTlLdDRhQngxaWUwSzNhOW0xWG1DeENPVGVmbE1X?=
 =?utf-8?B?SFRYVEV2WWtqR0krUmJpcXFlYVhjUVFINVN4aE45TEtNWjBvZW1rRi9idDJO?=
 =?utf-8?B?a0xRKzJiZndvRmxwcFJ3NU04YzYvME5tVFFVcTYwVzZoYThyZlZ5alloOUg0?=
 =?utf-8?B?c3l5bnVKcDNCeVlCc2tMUjBNYWx1VUcycUgrc1Y3K0xyZFVPdWVaSHRwVVlE?=
 =?utf-8?B?WFlnUExVc1lsN0VUUHY4NC9wWVZKc1R5b1UxZmFjTVRXYVZ2RnlibDlmUW4v?=
 =?utf-8?B?SEN3bFFKcHhlODl2d2pURkZGRVBkcnpNWjArQWJDL0VieGtzSFNJbFlTbFV2?=
 =?utf-8?B?eGZMKy9jZUJOODZvck5PbHl1eHNlMHE3SHB1aXJ4WjJTWkNjQWNCVmxncFp0?=
 =?utf-8?B?L3ArdTRrTUd3dndUQmxWOXN5TlF5VmJHZlhnUnBOTWxDM0pOK1ZoeHR0bzUw?=
 =?utf-8?B?bnJEUUI0WXVZQk16amFCRnd2NjVhdXBoNlFwVHp3VDI1b0lKZFFLc1k4OXRU?=
 =?utf-8?B?MzcrUDgyZ0J2MEVwK3pEcDZOYjE4Yys4OGNNTFBZRmM5RUZka1FBK2o2VmZq?=
 =?utf-8?B?SEJDYld2YUhUWDVsMUVJdlduRlpaWGg4VFljTE1HM0VFdWVmN3laU1lyeWdH?=
 =?utf-8?B?dU90VURUZDdPRXltUm1OS2lNTHdTSndkVnVJNU4xNWk3Q203Q3laNUdlVGto?=
 =?utf-8?B?eXJLazliMmwxcW9WR011dzJOUG9FTWRDb3c5SFoxc0FCeDZVdG1WMU9tZytD?=
 =?utf-8?B?MTBrdy81bnh0MXMyUHFtTE81ZG1DMS9ld2ttN3h6ZTMrNlk1aDFTcTc2ZDFK?=
 =?utf-8?B?TVR2TWhzODE4eG5kVkorRWtXaUs5QmFqUTRWRit6QnVMeVlVS2l2RnVlalUv?=
 =?utf-8?B?c0g2Tndzc1I2OHViRjlHMXlwZnZnQWpUVWdoR0FDbXEyR0o2cXQrSTM5dGZm?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b326381a-dcf3-4c6f-a1ea-08de2c894fce
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:15:39.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTa2iTvZ5WoSirdE4KZS+6PGENBR/+guoeKidf8DqI12+BS1BYT5OxUXdOdUDz8RDINGoteXwQVYpyBhDDQJskoHlTRjKhoRuRlmQHauo7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6962
X-Proofpoint-GUID: pwATW5uYWFuGnVIybPlWexArc4FFUsY7
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=692654be cx=c_pps
 a=mafLo/wATi4HPiUbedi6XQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=YJAArCuFAAAA:8
 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=i0EeH86SAAAA:8 a=pGLkceISAAAA:8
 a=IBW31Wycr_8ObnY0O-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ABE9cqDPcR8SteYt8ADh:22
X-Proofpoint-ORIG-GUID: pwATW5uYWFuGnVIybPlWexArc4FFUsY7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDAwNyBTYWx0ZWRfXwgJtezQaboq+
 wwm1w0Uq6p4eI+6P7jqPIO2DwWQwQ+VNR5r6CTVQUyFVlpTHpZHkmEvd4yXfmpY4LptenkW1aJv
 J/Wfc9869xDF2LhmyT9tBTrFXwJtmgbKMWANiKPk+8xNt01dM+ET+opB8i7V/w7GcOlKQESZpP/
 PjWx0Yh8tvIyDgLMtJNDkLBeN/lcxNfRnSvKkurOExEx17VXYuF9IRbqu89xj4P6rreD6xxhkaY
 NTeySPD/MCD6X1OCQiPYpHT4x2x5NzL7ugNldqS049/8B5betjHszw/GwNxqN6IUFjbjF0GYXGR
 l/fzHpktBDgUreArppYsPgXCWaExLNlNSE99IxRGWxWjXKI/uXqqJ8vNVFQZh4GR7wYGAvVmzlY
 HY5ME9PKXuF1LQMrNTVkqRzcmAcpsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Changes to virtio network stack should be cc'd to netdev DL, separate
it into its own group to add netdev in addition to virtualization DL.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v2: Narrow down scope of change to just virtio-net (MST)
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20251125210333.1594700-1-jon@nutanix.com/

 MAINTAINERS | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a8d945632b..dfe80717b0af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27139,7 +27139,7 @@ S:	Maintained
 F:	drivers/char/virtio_console.c
 F:	include/uapi/linux/virtio_console.h
 
-VIRTIO CORE AND NET DRIVERS
+VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
@@ -27152,7 +27152,6 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-F:	drivers/net/virtio_net.c
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
@@ -27161,7 +27160,6 @@ F:	include/linux/vringh.h
 F:	include/uapi/linux/virtio_*.h
 F:	net/vmw_vsock/virtio*
 F:	tools/virtio/
-F:	tools/testing/selftests/drivers/net/virtio_net/
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
@@ -27273,6 +27271,19 @@ W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
 F:	include/uapi/linux/virtio_mem.h
 
+VIRTIO NET DRIVER
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
+L:	netdev@vger.kernel.org
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	drivers/net/virtio_net.c
+F:	include/linux/virtio_net.h
+F:	include/uapi/linux/virtio_net.h
+F:	tools/testing/selftests/drivers/net/virtio_net/
+
 VIRTIO PMEM DRIVER
 M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
 L:	virtualization@lists.linux.dev
-- 
2.43.0


