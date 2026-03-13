Return-Path: <netdev+bounces-267351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOH+E3vYs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:27:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5885128077B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EF35300692D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF00389114;
	Fri, 13 Mar 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nRUwz6qi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651D38A73B;
	Fri, 13 Mar 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394038; cv=fail; b=O2WN3h99t9Vd9uxX/IPulvj37VMwBtg9/zgrUR6o8sgGZ/nV/z7XDYJIaxbprMG9CWWXhX4CxjM9iWOkBpnnZWvY6kzWmLgr8wcIf+enVBqnUZAadE3c/NfsrHds299XOa/0HD9OuiCJeSPF7L+FDaPFhKxR85wnD6Kxw+0wyuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394038; c=relaxed/simple;
	bh=8YeKN//0qPAcCUeQp+nbjfZyoiqADO01MIkcbO25f1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MAA9keh88gEaF44Z6A66PoLd4fQIVOIo+EjEewskdxwYEIQEA4Z/J4GyBPOCk61p/5AAXOScc4ISFie/IM09XFWMq03NaYvcPWR2y/pSx4porEhxzcZyoZNJaH/NdGgADwQDV1vu5LwhexO42uLCi1UkjQdBupQ9T4MztyHdRms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nRUwz6qi; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D8cDBf1000675;
	Fri, 13 Mar 2026 02:26:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=DhdjtzthcId+OvVOlLGurHDeP+QSTXnq4wf0njROdBM=; b=nRUwz6qiDbav
	VulYZCzwYsvTkzBxEICX5gKYN3hfkRuZYIXhYS0odpdjCLNMVd1li9bB5yGPJB+Q
	sIU1JMOsTnqewJObALIyFSi1oAxqNWNyFjPOdAQ4FvdqwoS/q13EyorBLgBVqf6z
	jTeRi8kptMY35xQzVLI4wxOxdYYLgcfUb/khlbDx8LKeUQSwgarsbxamw2YjkpYK
	ESivVd+cOOls5jWPi5mXJM8vZYA/W+QiinhrWUAVPPt4qyi3kCVE//jFvJrIjyj4
	Pvy+woSpde0g2i2QFLDjL92Nod4egsx2hEMrXblnih9l27dYdwE6xF0QBX/E3jjP
	Mg4S1iRhbg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cvf8bgehu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 02:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYhIBdR9odcJETIXmWblMvUWIO9sHe/5pqmv+Q5t2XJ4y9v3hz9PXkUsH5Jn9r1L947rsjodW3/ka+aqFXoPo1HBmFygO9dJtcIuylbnpeAvJastMs3Rdto6vWy2RWdY2kraCGwikkGfOB57MbUbPSUM/+LIAqZv0JYqSFOWs2KhNddSYh6Rl7J5fXpvsVUNZMQO6/gAqS5EjeNY8swHwK9D0svk+7sPex1mE21oqXLdhVZMB/f5+Eh1MPYedqNZ+PhYiPDCmeHmwnU01EZzGKrN7/7qaI+WmKn70TSA0gKK2gposvXsp52uOAmMvBLwBVw7LTz5mugwmFfzDw1FMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhdjtzthcId+OvVOlLGurHDeP+QSTXnq4wf0njROdBM=;
 b=ocDYORlZT0DXfia0XvTrb4gQkV5j4MgRQqI8zQ84watUODUR/PUGn/0LELb1YaeBNGXC7H3TwY5zm6zT1ow8luPdNcLXW5+6F9LijHPvc2MOYKInb8hxHUDuXNh1p4adnAg6NcCG2m6BA5nNE4//iYL98w5XNFIbwuvtXrqUvOzY6jwh3yZqvLh6njHA4TFEW5Nt0qm6vZGvDTwpg8URogaU02tsXDIMdvkx36UHJyTiPTeKVv7Cbwa6WQ8QsaqqaoBnjLxBhgfD74ureppYIBi406v1deUkMBzywy4+vadOROVChjurmCu8728Q2GcDiQBwDDf8+Cg0oC6z9y+9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by MW3PR15MB3865.namprd15.prod.outlook.com (2603:10b6:303:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 09:26:53 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 09:26:52 +0000
Message-ID: <973b9a78-7ef2-4f2d-9952-81755a17d719@meta.com>
Date: Fri, 13 Mar 2026 14:56:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260310183107.2822016-1-vishs@meta.com>
 <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|MW3PR15MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: cd46a41a-ceda-4955-2963-08de80e2a96a
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 wgjYMoLFe0l5tR6Am0ZAg1N0UkwgTbq7coH4yms2m5wBOFkVl91AT5uw8pg78vr2mDs0jOMso3PiJ0MIUXC/b9690ypUvVKLtCn6X6/67w8qGmmz9hAo0VqSi+ehWjmfD2sIZeTECmXT9wIR991C1e3TE2FBPTpajiCS/WB9XeoPcGPY+cCZgjYlbIITm3hFJAB2rc+Yr08uuXo/92D+GqV3qm4JsL65ZOn4yzcUGyhoirFsiNgAacFvZBPTpGWNasRp7hvYbJ0jGatlwk/lNDaMBXNyg3fUg6qG8cGI2r1z8IR5T8CbalmhrDnn4CoqqQ8mzWdwDH4emIGDPByrflq0uP0A2awWVgBSsvYYZCOPNouY8unbcUt/hjkQItZK3QwG1K+l1fg3eARJqrSJ7kFkhmbuzV64Gd/0ywO8A2eUq762NbyduFjtWMr8lfK36PpmHC4tGo/lO9miehxd9bk20Pd86KkDWhUIbIzQFh9mcnVV+L7UR5NYSGoQ0dPH2FGY5jOUxU8VuP9pBIQjy7w2KOQGRXo4TWojegAvq0AG7QGxxOjYtjNqG9c5xD7JznE8lCjvHnoexrob15Dxe39Hemuwnay+YEBzkLQD8QMDmFvcYmRL06ahb4WfTTTdyFAlUNyBWygc+QyuzulK3dJAh9+f0+tf/SmAwcnw8P6YhJVbO/mP50nM+hjmRVea
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L0JCcnR2NW44MHFVUlM1cWF4dWNnUXIzQnkyUnJ6Y21obU01UytGaG1kUjZB?=
 =?utf-8?B?V1VjRFdWM0kyUVpCcGVROWRwUUo4Mkp3TWZEUThtMm1ncWNPQkc3TjVtQmNl?=
 =?utf-8?B?WkFjTDN3ZDBqd3BSNmZvQ1R1YTFKRjZaQ2QrTzluWVVHazF3S2JYZ243dERL?=
 =?utf-8?B?THg4UWFhTGdhYjNLY0U5Zm83SjU3Z0g1WFhWa0ZkTEJRUHBzYVRkcWcyMGxt?=
 =?utf-8?B?N0kxb2pQSlAzTEdFY1g0amlEZEtwdVljblJ5NDdiZlorcWM3bnNUaUdLZElh?=
 =?utf-8?B?TjdnVGtCM2VSZnQ3VEhTS1lYM0VwS2ZQOWMrZW5OMmVaMytzcElNRGRES1ZX?=
 =?utf-8?B?QTJPZW9DM2IxU0pWUFpOczV0L1hYaEpSbG5zc2cwaVZUOXNjWi9XeXFLQlZh?=
 =?utf-8?B?am5QWTQ0Rzd4eDQ4RG1DeDhTRXU4QWtldW5WTndNYnFjZXYzaWtGZnpJVU5k?=
 =?utf-8?B?NU43ZksxUUhOV1dFRTBHRC94R0d1K0p3NUkwdzhIOVlqZ3AwT1BBVCs1OUxs?=
 =?utf-8?B?VkJxS21kblU3bDVuL0RtaWdYKzFhajRTWVhFUE1Sbks1aVAwejhidStNMlRX?=
 =?utf-8?B?NmdPMEZSUS9KK2FJYWpwMDJvTkNtVGZQUEtsWWxRN3d6Wko1S0RJeXAzdUFX?=
 =?utf-8?B?R0RTRzJMYUFUc083eXVuUjNVY0FDZ05jNmpiVExPYWxQM2gzWityMkxreVFD?=
 =?utf-8?B?V2UxZXQ1N01HcUh6b2Vyb1paUUg4cHo3NDRHYm1LM1EzbERBL0RjZFhRNndO?=
 =?utf-8?B?VXBDNk8rSGtBeEZNdG45NDVOTW9BeStMa3p5Ulo4T2RNSitOaUFHaHc4QVNH?=
 =?utf-8?B?aS85R285Z2MxM05haXZMM01sWXNYUjd1ZW9hNkVFQ25KcWJwVEYxZ2k1N1NS?=
 =?utf-8?B?U0dQWHF4N2dUdFpRMjFYTHBhbVRmS0t6UklQcElKdHc1RDBlU3VORzhRVUVv?=
 =?utf-8?B?Y2s3MTNlaVFTMXRLaXlDMzJyRkhjZlZmcVNhMEc1djR1Z0RVemQ4bjdLTzVJ?=
 =?utf-8?B?Z0xhSExCYkQ4REpGRS9pOTZ0SzhyUzNxUFFTRk90Znk4ZUs4R3VEQ3lBVGND?=
 =?utf-8?B?US96RUxERG9KSTZMQ1VOT2RnNzNRVFB0VVFSM3VsKzNvMnQ5dnZDY1dWYWti?=
 =?utf-8?B?bkFHdGdVbjJxQXVrWWFoMTN1MnFlL21Kb0pmdG9HVmZ3VHNxQ0prQmU5dzNu?=
 =?utf-8?B?dWRBSHhnT1lTQTJCQ0lWMENZRFhjNmxBVkpRN0JaV0RBM0ttOUVWOVlyMTlp?=
 =?utf-8?B?bGFXc1NodmFIeDdaOUUwTFhjL1lwQlNCYnFJbFdKZmxmL09QNlNiK2FEc2p5?=
 =?utf-8?B?ZUU5QitFL1hkUVBXOWN5ZGZGbzhQOGl5OHJKdVFxWE5ycEJOYk9nYXlEOFdl?=
 =?utf-8?B?SmN2WE5LbUZtcUtiSS9VaGVlcHo1YnEzM25hZGNZMXpKQ0trZUhWZTB4RjdB?=
 =?utf-8?B?VWlXMU5qV29kT29QMUQ3cUpIcCtqSjVHWDZpUGdQSXltaXdtaE1DK0pscCtI?=
 =?utf-8?B?V2ZFb3kzdmlybDR3TGllQVM2NjFHZk1qMnlNa3hqeGR3MWhWdklWZTJOUW0x?=
 =?utf-8?B?OTRoYkNvdkEwNWpEVWxEK0JlRWNNN1FheUhvNkQzbHpFMXRnTnVqb3NBYVAy?=
 =?utf-8?B?VERVRzJ2YnNMR0hud2RiVGUxSVZzZTZOZ3dzMHhKY2FYWWhhbnVNaFpkTko4?=
 =?utf-8?B?OXdrVU1JR0hNSldyUDdFeUlVa3lCSlJrdmZNbThjUzNacVltOXBIbFcyUi95?=
 =?utf-8?B?VDhrRnhmcU45LzlXeHBrTm10ME1ySVNDT1JYelMreFU2UlR2eTU1M3lVcEdC?=
 =?utf-8?B?b2dOMytWNW5KZGFOb01YeXJoSFI5OXBmTEdFdDdrMUtIdjRIb2pYZENTcHg5?=
 =?utf-8?B?UjZJNlpYMmQ3d1FoaXZ6L0EvR3NCVzNOekxkT2pvQXRpK1M1Mm4zZUxSOUVV?=
 =?utf-8?B?TFVBREF4NllzTGIxVkFFMXpTNk95b1BlM3FpL3J5cklYTFJaWFFnZ2JoOU5E?=
 =?utf-8?B?OTRJanZseDlMNFJ1SWFISVRWNlQzaGNFYUJGcGhTdjk1alFVY3Z3dTB4cDVX?=
 =?utf-8?B?TFI1NEwvSjBnajZ5czZCT2EwblZqUERoaEt6YmZpQW5HQ3ZTMmlJaGdDd09o?=
 =?utf-8?B?MWlqc3lWb0o4TlpvVzJ6bkZLd3dmZzdjR093TXpBOTZ6R1pyWnpkZytoUXAz?=
 =?utf-8?B?aEFESExrdW9SVEpJNnZGUFAwY0NmU00zbW81aFU3UnIwc05iRzJsTFMvMkNj?=
 =?utf-8?B?WFhOTUNVWjN5ekFLL3RjUFVZYzIxQmZFckR0VXlBOExkRnBValNIN0FUMGtY?=
 =?utf-8?Q?hkMfblwD8FNdQ79Jii?=
X-Exchange-RoutingPolicyChecked:
	vc7rYsp+KiSF2PeozozUa/RsC2WPAasLTJ96/ts0e0riO9GNdPDp3tVD3fqN/SG4+AgQTb9yMiclMukFzbGEg1vMldbjh9WXOuwIA+p+bjGihNKgWMYpoYfRJkuiDAKWRjibSJSZoiJF5gzlQHQhevCTsH297gkmFr535Qsrm7f/Si8i6sHqXWYmZAGIby3NWCypKjC4P8AoJccFTW29kR1zzyx2UhEcq9UW+G96AJXjQdTUnI4p5qeNqGT/fLH/t2kI6fvTKpHE1IJA9v1vTwDTUV24u8EV+017bMJeJDoQGdxepLgY5ujcgv0rmpia+PF+KhRm0d3gkTjmqTYvKQ==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd46a41a-ceda-4955-2963-08de80e2a96a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:26:52.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YocU7k50leSr9Dr95EGBWBKV4MgYgqGGCcrMgB/Lo8XP0I/14itrViyP23TefBmh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3865
X-Proofpoint-GUID: G18zZw7NqV6Kn39TC6LYdkiWNTOvGv2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA3MiBTYWx0ZWRfX51cD1zSjEeEM
 7qTre8JIaksV1psTHvllaB+QaLjVx/sKqA9Vbp7TrQ6PB5xAOHHRz1bhQL2KyakFSVVoyfRbNOt
 B3Mzcs4JSrKaOx8JmUR2mazjFXRRyVDduPJDcIEja3iibzM8eg36UHjAHEAJvncViVYQX1AjNkF
 qwGCoSZvMzEQ5Hs5d3IEG9bEBuqaH0FXRkYAa0ekwfDD3Mi4Po3FXzO9meAPtUoIblCbZNg0147
 6i3Vs4pTe+6GkhT/zqVPPHMOcehY5T5FHohLTuGh3mq5DJ9PtNTHf4dAG27zs/RACNcBcX//hxq
 0LwRV65otS9TNSvkHGdoCS1X0HmTe4nXYlcQ7euVaR4EV+TgOuUOvgfINhN3tbbEOSx+7cT0lsp
 wyaHmh/Lk6i807SZ6i/9ruUOpUW8WJlbN36CXJ0XYXAHX1Xvx6DdSXK/uPkbeTJzzulp1V8lsR8
 ksICSQAiPeOalGR+H0A==
X-Authority-Analysis: v=2.4 cv=P8U3RyAu c=1 sm=1 tr=0 ts=69b3d860 cx=c_pps
 a=e6K3ZeJSw2wYQu/wAm/p+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=qhZll4JncHksYg3arKAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: G18zZw7NqV6Kn39TC6LYdkiWNTOvGv2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267351-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:dkim,meta.com:email,meta.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5885128077B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 1:21 PM, Jason Wang wrote:
> On Wed, Mar 11, 2026 at 2:31 AM Vishwanath Seshagiri <vishs@meta.com> wrote:
>>
>> Use page_pool for RX buffer allocation in mergeable and small buffer
>> modes to enable page recycling and avoid repeated page allocator calls.
>> skb_mark_for_recycle() enables page reuse in the network stack.
>>
>> Big packets mode is unchanged because it uses page->private for linked
>> list chaining of multiple pages per buffer, which conflicts with
>> page_pool's internal use of page->private.
>>
>> Implement conditional DMA premapping using virtqueue_dma_dev():
>> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>>    handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
>> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>>    submit via virtqueue_add_inbuf_ctx()
>>
>> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
>> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
>> support as a prerequisite for future zero-copy features (devmem TCP,
>> io_uring ZCRX).
>>
>> Page pools are created in probe and destroyed in remove (not open/close),
>> following existing driver behavior where RX buffers remain in virtqueues
>> across interface state changes.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>> Changes in v11:
>> - add_recvbuf_small: encode alloc_len and xdp_headroom in ctx via
>>    mergeable_len_to_ctx() so receive_small() recovers the actual buflen
>>    via mergeable_ctx_to_truesize() (Michael S. Tsirkin)
>> - receive_small_build_skb, receive_small_xdp: accept buflen parameter
>>    instead of recomputing it, to use the actual allocation size
>> - v10:
>>    https://lore.kernel.org/virtualization/9752a952-195d-4da3-bc7a-5a4a1f2fd2ca@meta.com/
>>
>> Changes in v10:
>> - add_recvbuf_small: use alloc_len to avoid clobbering len; v9 feedback
>>    was about truesize under-accounting, not variable naming — misunderstood
>>    the comment in v9
>> - v9:
>>    https://lore.kernel.org/virtualization/20260302041005.1627210-1-vishs@meta.com/
>>
>> Changes in v9:
>> - Fix virtnet_skb_append_frag() for XSK callers (Michael S. Tsirkin)
>> - v8:
>>    https://lore.kernel.org/virtualization/e824c5a3-cfe0-4d11-958f-c3ec82d11d37@meta.com/
>>
>> Changes in v8:
>> - Remove virtnet_no_page_pool() helper, replace with direct !rq->page_pool
>>    checks or inlined conditions (Xuan Zhuo)
>> - Extract virtnet_rq_submit() helper to consolidate DMA/non-DMA buffer
>>    submission in add_recvbuf_small() and add_recvbuf_mergeable()
>> - Add skb_mark_for_recycle(nskb) for overflow frag_list skbs in
>>    virtnet_skb_append_frag() to ensure page_pool pages are returned to
>>    the pool instead of freed via put_page()
>> - Rebase on net-next (kzalloc_objs API)
>> - v7:
>>    https://lore.kernel.org/virtualization/20260210014305.3236342-1-vishs@meta.com/
>>
>> Changes in v7:
>> - Replace virtnet_put_page() helper with direct page_pool_put_page()
>>    calls (Xuan Zhuo)
>> - Add virtnet_no_page_pool() helper to consolidate big_packets mode check
>>    (Michael S. Tsirkin)
>> - Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() when
>>    use_page_pool_dma is set (Michael S. Tsirkin)
>> - Remove unused pp_params.dev assignment in non-DMA path
>> - Add page pool recreation in virtnet_restore_up() for freeze/restore support (Chris Mason's
>> Review Prompt)
>> - v6:
>>    https://lore.kernel.org/virtualization/20260208175410.1910001-1-vishs@meta.com/
>>
>> Changes in v6:
>> - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
>>    page_pool_alloc_netmem() already handles internal fragmentation internally
>>    (Jakub Kicinski)
>> - v5:
>>    https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/
>>
>> Benchmark results:
>>
>> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
>>
>> Small packets (64 bytes, mrg_rxbuf=off):
>>    1Q:  853,493 -> 868,923 pps  (+1.8%)
>>    2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>>    4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>>    8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
>>
>> Mergeable RX (64 bytes):
>>    1Q:   766,168 ->   814,493 pps  (+6.3%)
>>    2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>>    4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>>    8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
>>
>> Mergeable RX (1500 bytes):
>>    1Q:   741,579 ->   785,442 pps  (+5.9%)
>>    2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>>    4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>>    8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
>>
>>   drivers/net/Kconfig      |   1 +
>>   drivers/net/virtio_net.c | 497 ++++++++++++++++++++-------------------
>>   2 files changed, 251 insertions(+), 247 deletions(-)
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 17108c359216..b2fd90466bab 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -452,6 +452,7 @@ config VIRTIO_NET
>>          depends on VIRTIO
>>          select NET_FAILOVER
>>          select DIMLIB
>> +       select PAGE_POOL
>>          help
>>            This is the virtual network driver for virtio.  It can be used with
>>            QEMU based VMMs (like KVM or Xen).  Say Y or M.
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 72d6a9c6a5a2..a85d75a7f539 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -26,6 +26,7 @@
>>   #include <net/netdev_rx_queue.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/xdp_sock_drv.h>
>> +#include <net/page_pool/helpers.h>
>>
>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>   module_param(napi_weight, int, 0444);
>> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>>          u32 max_usecs;
>>   };
>>
>> -/* The dma information of pages allocated at a time. */
>> -struct virtnet_rq_dma {
>> -       dma_addr_t addr;
>> -       u32 ref;
>> -       u16 len;
>> -       u16 need_sync;
>> -};
>> -
>>   /* Internal representation of a send virtqueue */
>>   struct send_queue {
>>          /* Virtqueue associated with this send _queue */
>> @@ -356,8 +349,10 @@ struct receive_queue {
>>          /* Average packet length for mergeable receive buffers. */
>>          struct ewma_pkt_len mrg_avg_pkt_len;
>>
>> -       /* Page frag for packet buffer allocation. */
>> -       struct page_frag alloc_frag;
>> +       struct page_pool *page_pool;
>> +
>> +       /* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
>> +       bool use_page_pool_dma;
>>
>>          /* RX: fragments + linear part + virtio header */
>>          struct scatterlist sg[MAX_SKB_FRAGS + 2];
>> @@ -370,9 +365,6 @@ struct receive_queue {
>>
>>          struct xdp_rxq_info xdp_rxq;
>>
>> -       /* Record the last dma info to free after new pages is allocated. */
>> -       struct virtnet_rq_dma *last_dma;
>> -
>>          struct xsk_buff_pool *xsk_pool;
>>
>>          /* xdp rxq used by xsk */
>> @@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>                                 struct virtnet_rq_stats *stats);
>>   static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>                                   struct sk_buff *skb, u8 flags);
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +                                              struct sk_buff *head_skb,
>>                                                 struct sk_buff *curr_skb,
>>                                                 struct page *page, void *buf,
>>                                                 int len, int truesize);
>>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
>> +static void free_unused_bufs(struct virtnet_info *vi);
>> +static void virtnet_del_vqs(struct virtnet_info *vi);
>>
>>   enum virtnet_xmit_type {
>>          VIRTNET_XMIT_TYPE_SKB,
>> @@ -709,12 +704,10 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>                                  struct receive_queue *rq, void *buf)
>>   {
>> -       if (vi->mergeable_rx_bufs)
>> -               put_page(virt_to_head_page(buf));
>> -       else if (vi->big_packets)
>> +       if (!rq->page_pool)
>>                  give_pages(rq, buf);
>>          else
>> -               put_page(virt_to_head_page(buf));
>> +               page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>>   }
>>
>>   static void enable_rx_mode_work(struct virtnet_info *vi)
>> @@ -876,10 +869,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  skb = virtnet_build_skb(buf, truesize, p - buf, len);
>>                  if (unlikely(!skb))
>>                          return NULL;
>> +               /* Big packets mode chains pages via page->private, which is
>> +                * incompatible with the way page_pool uses page->private.
>> +                * Currently, big packets mode doesn't use page pools.
>> +                */
>> +               if (!rq->page_pool) {
>> +                       page = (struct page *)page->private;
>> +                       if (page)
>> +                               give_pages(rq, page);
>> +               }
>>
>> -               page = (struct page *)page->private;
>> -               if (page)
>> -                       give_pages(rq, page);
>>                  goto ok;
>>          }
>>
>> @@ -925,133 +924,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>          hdr = skb_vnet_common_hdr(skb);
>>          memcpy(hdr, hdr_p, hdr_len);
>>          if (page_to_free)
>> -               put_page(page_to_free);
>> +               page_pool_put_page(rq->page_pool, page_to_free, -1, true);
>>
>>          return skb;
>>   }
>>
>> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>> -{
>> -       struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       struct page *page = virt_to_head_page(buf);
>> -       struct virtnet_rq_dma *dma;
>> -       void *head;
>> -       int offset;
>> -
>> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -       head = page_address(page);
>> -
>> -       dma = head;
>> -
>> -       --dma->ref;
>> -
>> -       if (dma->need_sync && len) {
>> -               offset = buf - (head + sizeof(*dma));
>> -
>> -               virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
>> -                                                       offset, len,
>> -                                                       DMA_FROM_DEVICE);
>> -       }
>> -
>> -       if (dma->ref)
>> -               return;
>> -
>> -       virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
>> -                                    DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
>> -       put_page(page);
>> -}
>> -
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>> -       struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       void *buf;
>> -
>> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> +       BUG_ON(!rq->page_pool);
>>
>> -       buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> -       if (buf)
>> -               virtnet_rq_unmap(rq, buf, *len);
>> -
>> -       return buf;
>> -}
>> -
>> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>> -{
>> -       struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       struct virtnet_rq_dma *dma;
>> -       dma_addr_t addr;
>> -       u32 offset;
>> -       void *head;
>> -
>> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -       head = page_address(rq->alloc_frag.page);
>> -
>> -       offset = buf - head;
>> -
>> -       dma = head;
>> -
>> -       addr = dma->addr - sizeof(*dma) + offset;
>> -
>> -       sg_init_table(rq->sg, 1);
>> -       sg_fill_dma(rq->sg, addr, len);
>> -}
>> -
>> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>> -{
>> -       struct page_frag *alloc_frag = &rq->alloc_frag;
>> -       struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       struct virtnet_rq_dma *dma;
>> -       void *buf, *head;
>> -       dma_addr_t addr;
>> -
>> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>> -
>> -       head = page_address(alloc_frag->page);
>> -
>> -       dma = head;
>> -
>> -       /* new pages */
>> -       if (!alloc_frag->offset) {
>> -               if (rq->last_dma) {
>> -                       /* Now, the new page is allocated, the last dma
>> -                        * will not be used. So the dma can be unmapped
>> -                        * if the ref is 0.
>> -                        */
>> -                       virtnet_rq_unmap(rq, rq->last_dma, 0);
>> -                       rq->last_dma = NULL;
>> -               }
>> -
>> -               dma->len = alloc_frag->size - sizeof(*dma);
>> -
>> -               addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
>> -                                                 dma->len, DMA_FROM_DEVICE, 0);
>> -               if (virtqueue_map_mapping_error(rq->vq, addr))
>> -                       return NULL;
>> -
>> -               dma->addr = addr;
>> -               dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
>> -
>> -               /* Add a reference to dma to prevent the entire dma from
>> -                * being released during error handling. This reference
>> -                * will be freed after the pages are no longer used.
>> -                */
>> -               get_page(alloc_frag->page);
>> -               dma->ref = 1;
>> -               alloc_frag->offset = sizeof(*dma);
>> -
>> -               rq->last_dma = dma;
>> -       }
>> -
>> -       ++dma->ref;
>> -
>> -       buf = head + alloc_frag->offset;
>> -
>> -       get_page(alloc_frag->page);
>> -       alloc_frag->offset += size;
>> -
>> -       return buf;
>> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>   }
>>
>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>> @@ -1067,9 +949,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>                  return;
>>          }
>>
>> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
>> -               virtnet_rq_unmap(rq, buf, 0);
>> -
>>          virtnet_rq_free_buf(vi, rq, buf);
>>   }
>>
>> @@ -1335,7 +1214,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>
>>                  truesize = len;
>>
>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>                                                      buf, len, truesize);
>>                  if (!curr_skb) {
>>                          put_page(page);
>> @@ -1771,7 +1650,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>          return ret;
>>   }
>>
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>>   {
>>          struct skb_shared_info *shinfo;
>>          struct page *xdp_page;
>> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>                  shinfo = xdp_get_shared_info_from_buff(xdp);
>>                  for (i = 0; i < shinfo->nr_frags; i++) {
>>                          xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -                       put_page(xdp_page);
>> +                       page_pool_put_page(rq->page_pool, xdp_page, -1, true);
>>                  }
>>          }
>>   }
>> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>          if (page_off + *len + tailroom > PAGE_SIZE)
>>                  return NULL;
>>
>> -       page = alloc_page(GFP_ATOMIC);
>> +       page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>>          if (!page)
>>                  return NULL;
>>
>> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                  p = virt_to_head_page(buf);
>>                  off = buf - page_address(p);
>>
>> +               if (rq->use_page_pool_dma)
>> +                       page_pool_dma_sync_for_cpu(rq->page_pool, p,
>> +                                                  off, buflen);
> 
> Intresting, I think we need a patch for -stable to sync for cpu as
> well (and probably the XDP_TX path).
> 
> 
>> +
>>                  if (check_mergeable_len(dev, ctx, buflen)) {
>> -                       put_page(p);
>> +                       page_pool_put_page(rq->page_pool, p, -1, true);
>>                          goto err_buf;
>>                  }
>>
>> @@ -1905,38 +1788,36 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                   * is sending packet larger than the MTU.
>>                   */
>>                  if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>> -                       put_page(p);
>> +                       page_pool_put_page(rq->page_pool, p, -1, true);
>>                          goto err_buf;
>>                  }
>>
>>                  memcpy(page_address(page) + page_off,
>>                         page_address(p) + off, buflen);
>>                  page_off += buflen;
>> -               put_page(p);
>> +               page_pool_put_page(rq->page_pool, p, -1, true);
>>          }
>>
>>          /* Headroom does not contribute to packet length */
>>          *len = page_off - XDP_PACKET_HEADROOM;
>>          return page;
>>   err_buf:
>> -       __free_pages(page, 0);
>> +       page_pool_put_page(rq->page_pool, page, -1, true);
>>          return NULL;
>>   }
>>
>>   static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>>                                                 unsigned int xdp_headroom,
>>                                                 void *buf,
>> -                                              unsigned int len)
>> +                                              unsigned int len,
>> +                                              unsigned int buflen)
>>   {
>>          unsigned int header_offset;
>>          unsigned int headroom;
>> -       unsigned int buflen;
>>          struct sk_buff *skb;
>>
>>          header_offset = VIRTNET_RX_PAD + xdp_headroom;
>>          headroom = vi->hdr_len + header_offset;
>> -       buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>> -               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>
> 
> Any reason for remvoing this?

page_pool_alloc_va() can return a larger allocation than requested as it
appends remaining fragment space to avoid truesize underestimation
(comment in page_pool_alloc_netmem() in helpers.h). The old hardcoded
computation would always produce the requested ~512 bytes, ignoring any
extra space page_pool gave us, so build_skb() would set skb->truesize
too low. To pass the real size through: add_recvbuf_small() encodes
alloc_len and xdp_headroom into ctx via mergeable_len_to_ctx(alloc_len,
xdp_headroom). On the receive side, receive_small() extracts it with
mergeable_ctx_to_truesize(ctx) and passes it as the buflen parameter to
receive_small_build_skb().

> 
> The rest looks fine.
> 
> Thanks
> 


