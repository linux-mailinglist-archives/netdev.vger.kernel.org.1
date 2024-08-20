Return-Path: <netdev+bounces-120317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C85958EBF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416661F23420
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D2376F1;
	Tue, 20 Aug 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SuG4YlSe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kh3sVBwo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551F175A6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183118; cv=fail; b=eMW73FX9+zF5sfOwuTtYN339amHSRY4ND/AdY5r2zsZRjS338pwkIJdnHBvJzW75zDHgPxGB7FQ0LDGuSKnPuij9pl3lFwelUAL09ln0ggSWoPqDk7cfYSBd4cULrXelPBLw7NFe+uvIhx9emoaYI3jXfUc8lBUegwpguYf552M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183118; c=relaxed/simple;
	bh=/lmmxTjn1GusBVm6bRnojJBr3WyT+SWqP1C01KyW8+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0XWgyboxFai35YqMsgXnyLYXQLvt5cFqD1Cpiby4p9qotOtBDzKh6R9YT0557clpVA75k+OAq0pnXMAd1ZvQa9IPzAN960SyKjFstdN6XxCVQbKk7+yOZIm0MsP6YkoK+ZlJtfZXe5orM+TNoX1b/+mgOIzDOixoC+QGkB/4YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SuG4YlSe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kh3sVBwo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KF4MEE028061;
	Tue, 20 Aug 2024 19:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RDgDc+gu/2MK0RMYv4+BXBy7fChAZJYOJr12tN1OpKQ=; b=
	SuG4YlSeu/VK0qAcHfQhYr3eDROLO/as49qW3fuWYG2yGjHqeBHCF/11Bzq+/qRy
	L2/IXKdlUrFT8ktFxH2EH3DZJKUP6wpHi78EltxClOidFgLcL8RodMpndokI2CsU
	YFRe1JqvAvmvrmMrf2zPSBpL2MyX2LSo/mLHU41HYTd2mCiRU0i+m+sxJ21fywHU
	j3U3tKWvCgJ2yotVGViGEj2E6VtOmY8duimvxTG80KPtCRLoRo+A8NLhqjNHvBjO
	1g7Tu6cziLj2HociczuZRzpVeoQUxStYeUA1ft+yccIiDBNEO+TVFn51DjWxJVpU
	mTQ4nBC2TDnZM+XosXspJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dp5r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 19:44:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KJhpjY017614;
	Tue, 20 Aug 2024 19:44:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4151jdg16n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 19:44:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha8jQ/H6RueJ4r9nBZhvf2jmTKs3QrzBwRM/lkrVGVpVirD6zSaM5wpIPQVq8BH3FEK9xVn6mcs4UjTq0rfnI/ogcLlfw9DlwMvrzaqyZQdFL1QPOcn2nk9U4yOdU6zO99YNnfIDMBot9vO4VC2fh942BRaiNBthlDQrBqiqnJCoXTebm6L0kPaDI+BANuFR24ygkEEhmPnRSu9LYoRcjUZgEj6rpleNwcf6GbrA1UzeAPsmsKwwG0mUYBLCOFV8Efih3L4r/XCPaTcj+YIxFiunFWLoBFERVrHBZvo306DLhQ46srsD5mKTUPM6wyCk0KBwqSKs2I6TZTKPVv1Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDgDc+gu/2MK0RMYv4+BXBy7fChAZJYOJr12tN1OpKQ=;
 b=oUoiK65m+lfah0VG7uWFRLAKMXCapCXnC+URtIivwsLCJqwUnPjbZ4OyHWusmXb0yqgW3JsM8rxYpXF0QfYgfNF3g6+8Y+H/nGP4rwdTz5dKkRPHB21KTjE4wy7cowKZZOach7SEJupg7Z9FPtTfIFGDsc6QmIvkm8x2yJzKuhU+YTynmLKaasy76UKUyPbYT+VbaA1DpuGO4ImbuInVhZOQCSPZjU1QfdhIUwbUu+Khzo9YEXhjNT80rMS44ZMNRfKTHM6OAD5C6xFLc8+6RtUjsN4bzPaeloJeYOXJuMjajvhy8a5SG5bhRXLghu/Qf9QGqqosg648u5JqV8s9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDgDc+gu/2MK0RMYv4+BXBy7fChAZJYOJr12tN1OpKQ=;
 b=kh3sVBwooFeDZazmuQsNJRYSYe3rVQ2XsGyS6jxbeNfDnjDpWO4atzuCF5fVyipo8+iJiIT7LdIjuWlh8tNkQD7qiN9gSWUfK5l+4mbzioRr0VHC7FdfjcMH6Rko1PWR5SrtvYPfLZf+09xZ6D2enL25dXyz34pUAIXSSmjOOPU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7280.namprd10.prod.outlook.com (2603:10b6:8:e2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.13; Tue, 20 Aug 2024 19:44:51 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 19:44:51 +0000
Message-ID: <4df66dea-ee7d-640d-0e25-5e27a5ec8899@oracle.com>
Date: Tue, 20 Aug 2024 12:44:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f80dba-d9f6-494c-1aaf-08dcc1508e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjUxWDdybUlGV2J4TkhFVVA3dkFTdG5qMGxrMVpBUUtHdVdQUWxESWZMWUZ0?=
 =?utf-8?B?bk10aDFWekJITlNiQWx4YVpkSGVHekVFVjh2YzdXcTY4U24raGtwSERJbmsv?=
 =?utf-8?B?cnk1QStUQlc1RnhyZ0FuTGkvSHhkdm4vckN3OFZnbWR0VTAxd3hCUUY3WW92?=
 =?utf-8?B?eklERmFaQUtyZnVvZHVvdjVaWTc0MnQvcTZtOXl6R2lGYndUZ3lYdEVaTEZJ?=
 =?utf-8?B?Rk1UQW1oZjgzZUZFSTJJZEdzalBuOXI4UVM1SFlJYzgrVUpzK1E3QWJ5cDZ4?=
 =?utf-8?B?M3MrK0NZS0VYT2JLaUd6NVVOQ3U3NG9tajQwSlFNRy9YTXF5eE94MDBZamtv?=
 =?utf-8?B?V3IzVVZyVUxXVWFNRUNiaU9Rd0NBL0oxUkd2VnFUdENrVWVVM0t2dHlpbTRr?=
 =?utf-8?B?cDhGRHRJSWxIVEQzdjd3ZEc3U3Jya080bTJmOUJLcHljakZRRkI5eWJHcHBC?=
 =?utf-8?B?ZmlFZzZRb3NGeUR1VEpoZEFFSi9IZnhka2xFeFF1c1BPOW1IMWhTZkZBTk1L?=
 =?utf-8?B?SkJaSVNrN1RnLzJjci9uOExydmJkTGlBaFZZWU5HWmpTeEQwMmE2MFJuK011?=
 =?utf-8?B?RFo3R2lSQW1mZWlINlRpWDRha3BmVUF3VzEreUJvZkJPcnd3UFZyTVU1RUlD?=
 =?utf-8?B?Y3REalE1Q0o5UEROM2RBRGJkbnhTTmpvSlFDSE9ab3dKVzVMRlAyNjVjcHV5?=
 =?utf-8?B?d2xOeCtSOGd1SXoxU0VJem52S1hoeVA3S2lsSm5sc0xIRDRqUFFBaDRXamlX?=
 =?utf-8?B?S0NZdFdnL1hjZ0xFa3FrZU9FWHVPeU8zbTV5YkNWdjM4TmNGM0xRaG1LM1NL?=
 =?utf-8?B?a0hWbURaQmdHbkYwT3VVUG5CZzNTbHY3Si9xS3hnTTNURDJOR0lKTmF3eS8z?=
 =?utf-8?B?YWpsRkxTN0dKT3FwdHlIdWVyQzRXUTBwY1JOOEYxMGg1QTNYc0ExN3YzcnV0?=
 =?utf-8?B?T2hWdzRlZzY4aGdhajVQaEprZkR3dzNSdk8rVmdKWDJ4bUZ6aUplalJPYUFC?=
 =?utf-8?B?Uy8yOHVmdnptcnJLbUEvbW92MXhyNktVdEs5RlhuWTFJemRDSmFjVG5nczRh?=
 =?utf-8?B?SEkrWUpPYmlxb09PdlBkY2dpSkJQbGs0SkVZUTVzeXJXUjlWbDBxT3NGZ1o4?=
 =?utf-8?B?M0RSbEljSTAwd0IzcGl4M1ltRWQ1YkZoSVo3bDdpeWU0eDZuVVl2ZXhmNFNI?=
 =?utf-8?B?VGlYREE0Z2dTODdzMTlMZTFFQ21iaGpZWXlCQmtGVktsVWRIdFNmSzhkR1g2?=
 =?utf-8?B?NHVvMlJHQStYdVpwcGwydEJ2cUt2L1NMYWNXTTdKRGZITmFyOGtOR3BmQ3NK?=
 =?utf-8?B?R2J2Umg0OUVnNEdydzRKUXloOWVJZ1E0TGU4YXkzTEVLN0pWYTRWaVUrSjdS?=
 =?utf-8?B?M0hNNmVOR2hUak4zbHQ4T1UycGxUYlFjRllKaHBaMzZ0cUVWSGlyYTBseGhR?=
 =?utf-8?B?RWwzNU4rQ1ZMTHQrQkNldTh1b0g3L3hXR3ArL09vYnhVdmQ3TWdiME5yUG1G?=
 =?utf-8?B?dFJhdVpVNUxGR0VTVk9YVGlmWUdmdzhNM0xBMk04RjdLU2lUeExYRUlsS0RL?=
 =?utf-8?B?anFWQ3lSRWZaR0xJbDR1bWJFbElwb0lpK1JkZy94QWVuK2ZZc09qMkJmUkht?=
 =?utf-8?B?TG9uVjdPUXY2VFl3aFFWVkpvRDFuWWdaMlJaa3ZmaTFydDdhQ01rdVNRR0ZC?=
 =?utf-8?B?QmJnQ0Z1R3UvbHJ4ZVhHU0NOUy9YNDY1Y3VqenpiVTVzQllZajU4MENvLzF4?=
 =?utf-8?Q?N1NfXvId5xrXl1mkxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFhPczh4ZE5TWjF5WERBWVJyODdWWTJValRXNEVDQnFWT1hIZ0Mrc3pPSjdS?=
 =?utf-8?B?dktCeW5UenJjNkx2a1FtcDFOb2JyUldzQ3pLcXRUN09hd3Y3Z2dIL3JRbHRO?=
 =?utf-8?B?T05BR2NoaG9GdERFa0lvVksrb3pkZ3VXbGRwWGRiMFc3b0gybHN0NjRvb2VJ?=
 =?utf-8?B?WnZKWW9IeFhkbkgwT21MbXRtOUhkQXVUTnpCbFMxY3lROWpzZ1ljQW1weDBk?=
 =?utf-8?B?ZCsrVWpZT25wK1VyZk1YYVllMWJ4Y3drSmJmZ0gwQy95a0JTK1FYZWRyYXN4?=
 =?utf-8?B?NFpiQS9Ec2dxYkF6TlN2bzY5WDlQQitIZmJkWEUxOTNvNlJ6WE55dU5hWWds?=
 =?utf-8?B?dkp4dC9LVmRacEp4aWxidlREYkYvTVhMcUdKakFzcUFuaXdaOVRiQytFWVl1?=
 =?utf-8?B?OHN5VmZHU0taeGxrUHI1VkEwVlU3VW50aEo2dTRjZi9ybS9RNVQ2dERWV3ZK?=
 =?utf-8?B?MG5uckFqMHpLc0tnS2hEWnY3UlBLcHRQNHZKUFFTTG91cENKbGR4MGw3ZUx3?=
 =?utf-8?B?UzZBNE8wcnJwTGtVS1pKYmk1eTJTQ0lOamdmUUd6TjlUK0JlSVpMdngyUVlv?=
 =?utf-8?B?WnpJa1hCZTk0cTlxWTFxUE52S1ZTV0J3bnBwdW5zWjZ5TmRYSWV2alIxdWpR?=
 =?utf-8?B?MU5vMmpYdFdhbmh1ZkpBTEpCejRhUVJvS3d4TEFKcjU4bEU5OUtROHpEZGdF?=
 =?utf-8?B?YXFUUy9YZFlRc2VwVFFuMm5BRzZvNWZVOFBlQUhCcG5oZnlLdCsrN3hoNFdw?=
 =?utf-8?B?blZTalR5bG1tQURlaGUyb0JOaXJvQmpoK0lDZlI5cEVBTXFCZFduZDVhSnNy?=
 =?utf-8?B?bk5ZSVBGTVhCVk15bmdpUTVqQjJwOGtvbVZpZnVvWlpVeU9EdXp1OUhOTDhD?=
 =?utf-8?B?TGxQMUZpYi9ycEdWbzdzaHZxTjFWeHNBdFhIWnlRVm03anphTkhlVXJxTjIw?=
 =?utf-8?B?RkpqRENtSC9pQkZBclZVa21jd3V2enpuUlJMVTJQU1hNYlFQOXY3NWJ2YWd3?=
 =?utf-8?B?VlNzT09PMzQrWXVTNFoyY0lGVTM5cUUwaVJPclhQUkV0YXFXM0Z5djBoYWo4?=
 =?utf-8?B?UlJzYW1aYVVxKzJwUGMzdDR1R09LYm5JMHltdU42endDWFYweUtXN1Z1ejlr?=
 =?utf-8?B?V0grVEVSbWFMdVJLL3dzQlVIdzlDWUlsbHZYb2lnWXIrUkhCa1lUSitMb0Zl?=
 =?utf-8?B?V00wR3dDdUpGWXJHaUs2NGh0VlF5SGlQQkY3YVo3bEVxa20xVVVlZTFoR1Zv?=
 =?utf-8?B?QVRrc2g3NlhwaFcwT24wWmkrQnh4T1J3dkU0QmxBYzk2Q1M5ZmxpengvTVZB?=
 =?utf-8?B?czlhSGwveUI3ZGVCNGdWWXAyRVZTZnhNN1lkOWZ5WGJnL1g2QlpmaXBQWFZa?=
 =?utf-8?B?L2RlWGcvcUNWVGQ5eWtMOW4wVlpWRWZzU2p2ZEVmVU5INkJyQjZFNmFYa1cr?=
 =?utf-8?B?ems1bGszcVE5WDRZZS9wbWRNbkpiNFI4aWs4eE9JRVVvd1ROZzlJZ2F6QmYw?=
 =?utf-8?B?cGFQcDFsZ2s2d1BuWUMrWFdXTHY3TUtSNjZtQ0JrSm9nTGV2WnhncXlwdkJM?=
 =?utf-8?B?VG5qbGMyNE9BQXJjZ3hqVzBRMko1dEZucnZHeEF5ZlM1a280aXdxdDB0czhr?=
 =?utf-8?B?T0J1YXU5TGJSZldOVmwzTGxuaHpscStxTTNjNkFJS2xnRVRzOGhCRzMwbHlh?=
 =?utf-8?B?WXFNRDFkRjlrNm4wbFNJeGY1T2s2NDNKNHg5ZFVsdUo5RCtRSFZNZG50ZUxZ?=
 =?utf-8?B?NVdDeXBTbjFIbUgrNVNVQ1oyM0Zhbkd2R05FWDJIWjUreFBkZ3NKdWhITXpl?=
 =?utf-8?B?VXQvaHJLNkR2ZEQvVVdSNkRwUm9jMFhDWHEwQVUvVUVDcFBXaXQ5NkxLRnBx?=
 =?utf-8?B?WnZ5b243NUhRY3lxOXYvZHBuazlwRXI5MXVYdTlCRllxR0ZubnNNSjE2SjJH?=
 =?utf-8?B?UW1LL3NCYWdlSVp3aWExRmQ0dHJZcXc3M2tkeTFmVEdsNXkyZDczamhaT29D?=
 =?utf-8?B?VzNjR1d3Z2Q0K0hEQTVKYVBIYzFEZWE5TEVNWmFKdW9XWFV0ZDNtb2pDZWRp?=
 =?utf-8?B?Q3YvTkJ0OHQ4VVhlbFR0eWlSc1QvVTAvdEtDRkJOKzVGaXlESVQ2VVpZT245?=
 =?utf-8?Q?auPFmbcRuiqpFY6dcCyOVrl27?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pk/fZFnmhzPWT5BgSGmUcFm3DBg1Rq3d3XBL4jLVE57wmLD4//pkjxZwSS0GMLJbx+JhBq049D4ip689LwUKll/nx/Rj2bLK1pmsy30iQE42olCP4NCY3rilchrCrEKzGsQPQr3+XNQ9ojb0pNs9CNEJjf/gXzX/sI0VXNAdsjoTUzDBI4x7YMxvtKn8pWw3xcVnmE19YMcJWftkU2Drq3/NvC2RN/X/7Hz4ynDEkwBG3pLvSRIBZ4d5pwIet7uBFiSymmXkZWbaNDvsWRVyFYSHI2WLDc+PCwi5FWDeqfxCGyO2q/B0l/VhsUNy83eY3NWFzlDA1JClbk2RnxbUE+l+7Vt+uIteLIkz+GFU8nIaEXTel/SXVPPSECvq7zjFBPRh0JmeZ46lev6AsRplSZbaAHKrBkkwlYBHdjVD9vry3iQw1taH75jEcoK1hUlFPiGASsSx0NnA5ihAzKSBvOCbdbbAkIiM3k8R/90tdzyEGM4KZUHcTLo4Gke07E9GoqQ0UsrkUXni0l0WmgrjgF+wXCkSHsyvPVIDpkCwiwhqd1863GtBC8myWOAKoHGxHslWUP/O6adDZUzwht3ucqyaI5rDvpXjR8IM86R4NUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f80dba-d9f6-494c-1aaf-08dcc1508e4e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 19:44:51.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMrtK4riEa8PfCMmoZb1kLpsUC7vACRfX9Zi0VUPjN2x2VKhEBeqbalGmtxEhUIrUlsj0qnbGvwNe7NMtaSRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_15,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200144
X-Proofpoint-ORIG-GUID: MDZWOzEHfy4-t6dZcxuqeBgUkcYZD0uU
X-Proofpoint-GUID: MDZWOzEHfy4-t6dZcxuqeBgUkcYZD0uU



On 8/20/2024 12:19 AM, Xuan Zhuo wrote:
> leads to regression on VM with the sysctl value of:
>
> - net.core.high_order_alloc_disable=1
>
> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> the first buffer of the frag is affected.
>
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>   	void *buf, *head;
>   	dma_addr_t addr;
>   
> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -		return NULL;
> -
>   	head = page_address(alloc_frag->page);
>   
>   	dma = head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>   	len = SKB_DATA_ALIGN(len) +
>   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>   
> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +		return -ENOMEM;
> +
Do you want to document the assumption that small packet case won't end 
up crossing the page frag boundary unlike the mergeable case? Add a 
comment block to explain or a WARN_ON() check against potential overflow 
would work with me.

>   	buf = virtnet_rq_alloc(rq, len, gfp);
>   	if (unlikely(!buf))
>   		return -ENOMEM;
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>   	 */
>   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>   
> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +		return -ENOMEM;
> +
> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> +		len -= sizeof(struct virtnet_rq_dma);
> +
This could address my previous concern for possibly regressing every 
buffer size for the mergeable case, thanks. Though I still don't get why 
carving up a small chunk from page_frag for storing the virtnet_rq_dma 
metadata, this would cause perf regression on certain MTU size that 
happens to end up with one more base page (and an extra descriptor as 
well) to be allocated compared to the previous code without the extra 
virtnet_rq_dma content. How hard would it be to allocate a dedicated 
struct to store the related information without affecting the (size of) 
datapath pages?

FWIW, out of the code review perspective, I've looked up the past 
conversations but didn't see comprehensive benchmark was done before 
removing the old code and making premap the sole default mode. Granted 
this would reduce the footprint of additional code and the associated 
maintaining cost immediately, but I would assume at least there should 
have been thorough performance runs upfront to guarantee no regression 
is seen with every possible use case, or the negative effect is 
comparatively negligible even though there's slight regression in some 
limited case. If that kind of perf measurement hadn't been done before 
getting accepted/merged, I think at least it should allow both modes to 
coexist for a while such that every user could gauge the performance effect.

Thanks,
-Siwei

>   	buf = virtnet_rq_alloc(rq, len + room, gfp);
>   	if (unlikely(!buf))
>   		return -ENOMEM;


