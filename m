Return-Path: <netdev+bounces-185473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BFA9A93C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F0716CB81
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27843AA4;
	Thu, 24 Apr 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOE7IMxY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fp4FhrZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CB2701AA;
	Thu, 24 Apr 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488742; cv=fail; b=f96D3wuWp8cL9P0ZQnjtlxmP6SEKJed3WrCz6QPUmtozLOJ5lxNrB8jtB3yun78cavqJx1SN/gln5dvwjyEEsjzgyADPIlWM6Ku4s7XAyHwoenwVDO1nep1MTHeXXnR2ClVAWdNgHka3FeevYQ39B5B1xSo8remXnUOOoMuEZrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488742; c=relaxed/simple;
	bh=s5P4IhTVsUz0hdGce3pE2+ReTyRIsstnwH8X5kNmK1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOxSgtzrNHkT0GqXgAbGBLRMTw7+gl4gsWH1T7Fc94Q3tZLFn5kuLMBr+JN+eCQ0bXL7od/fzy8LIvTqQ76YH+JP31q0CGQsQBqQ4U1WhSh0Nlu1ty4Kcov8J10NdlGwxWvmHOhPqBh3zL5vy6hcz+u1KIya9pLt52lHTC+N7Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gOE7IMxY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fp4FhrZ/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9qUZQ031750;
	Thu, 24 Apr 2025 09:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q4gSiUSZT/eswvxIgAtjKXUgfi0arpJnJBtNqEaIDEQ=; b=
	gOE7IMxYsNhxzWiYXrkSHEUP81feDJm0rgLbQ+th9UmyPdP2dQXbP/5WreAzyE6U
	+pCyVhAbK1GWIx4uk0nPCNZ4AE7ROiF2RqzckImQlHgdzcoDoPulkuaJf8m0G28i
	YXd5Aa9LyhM2dejaZza12gTY5QPuAPhtAzjaQg4FmD7Ri+RgmF83U38hb9UfVNBx
	7NEsPw/JhZhTLXEWzMjCvgjV6Z4NBVm6f3wqzLCSNsLvxS9m141F+x4L/WkqUnI6
	Xd+CulEyzoQMEcvh21e0lCMWFAfn08WOKHhpgMZrztoikdel9EWReDcYNucm1Xm4
	LvYlZQTHEqwwppo6Nl8iiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467k1ur08n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 09:58:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7xJ9T028600;
	Thu, 24 Apr 2025 09:58:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx79y2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 09:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjvSfXnKwlKKKOjvXXA0N6TNAaI8mzSeT5n2obkZVy0aHeOKyfbTwj3TpYrXQEwfPv2JRXEhLxOD9WB7NfEdWWXHGwL+QS4c6Lf0YxoltNoKVDW1iA+WD+1cbvKh+tvmdKYToDYe/KaaclM0vHYglvVsp6Ls79FHuA9j//mbRAeW8uh1B0W6VyNtBU9g/HfgN31AQSSptLN/lw020Ou0BAAkYCcPu/t9z14qRvruxu8RO/a3fLLawXu6HfBouBtX7KLvW1WBVwywHaLkHvIaHHedJY6y0ol56ezQBBkkrdC0Rru2DqroD+kG3keytXc1p9Xv/kjqdgeVUV9P1gjxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4gSiUSZT/eswvxIgAtjKXUgfi0arpJnJBtNqEaIDEQ=;
 b=D4J23SmafAci2vsRCDKEt6qjmhei4Zf0cNzzeqz3LOyirnvvVVcXsFULBPG7hm4TSlieQnkuFdCLGMp4Jd1B7CmmGNW7W5gPpw4UBmVRfGVTWRxJh/m6FqwCUVEyWP77iE/l+onvVnQsttglrw8iENNPqVlpf7+GkkEvGruXY+ntyd8XzIHWbeKda3E9o207ldN6Ke7Ap20HytrGWRD62IKzivj4rXfLUXZI9hMthQbLUX1Y35g+LMCrMWuk6no2dBZXkYLRUXecGApbq56neMm3xTiwBMaXGJK260jN0cs0ipc8TQkbFlbyrEas2y1wb9fbMM8CD6NMA76T+d906A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4gSiUSZT/eswvxIgAtjKXUgfi0arpJnJBtNqEaIDEQ=;
 b=Fp4FhrZ/u9aA/yPBKZ2eRtuCUj3sXwBtZjskxLHelWvvefIIpgokdQWpc1u/vcjoZiBwHqO8Qugsn5CJC3QJCMDO2jX0e7Nnr29+UtAPfG0GqomTYuDdz50F+czNz5vIPnzOvuPVmeifVQMF/RgRGm5WK6QpiBrj1CM969HYNnQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 09:58:13 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 09:58:13 +0000
Date: Thu, 24 Apr 2025 18:58:01 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the
 percpu allocator scalability problem
Message-ID: <aAoLKVwC5JCe7fbv@harry>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
 <CAGudoHGkNn032RVuJdwYqpzfQgAB8pv=hEzdR1APsFOOSQnq1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGkNn032RVuJdwYqpzfQgAB8pv=hEzdR1APsFOOSQnq1Q@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0049.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 29143fd4-3349-495a-b862-08dd8316868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUh0WktIaEpUM1YwMzNDWjJlUjNCL2l4OHFia3pyYkthN1ZLTDREMmpDREtT?=
 =?utf-8?B?d2FzcDlDdU45dmpJU3QvSzFsb2xzTXNVa2p6TlY5cVBIaG9LUmErQmNWQ2dJ?=
 =?utf-8?B?TU53ejRJdVVsSDlFTUx0RHp3dkdVcE1qV0x2MnIvV2tZLzVHZktkcEg5M1hr?=
 =?utf-8?B?VWs3NzgxT2xJekNlN1BXQ2tCdGNqR0QxQkc0WjVKVm5JSGt4Q2FzSGpCTkVo?=
 =?utf-8?B?VGRzMlozc3FyVTZyTktEUmVtemFjMTNWd2hzZDlQbXFHenhjTDhTUGVUcHRt?=
 =?utf-8?B?ZGpDNU9MUjVtWTRXaVJlUmsyREhWUkN2VjQ3Z2xGV2hDM2krdWw3MEJnS0tX?=
 =?utf-8?B?a05TUlkwQnZTbS81NUhzQnpPMWgzZTNuUUlwN3dTb3JhbW5WVytEYmQ1QXN5?=
 =?utf-8?B?anlrSzRVbnVwSDRMa01ibUZmNHR5aEk1Z0RucjNFZXE3VnVjc3IyMWZoaXd0?=
 =?utf-8?B?NlZMTG9FRE1tK0RweFVYZFE0a1hzZ0xMYTA0bk1YT08xTnpjSTRDb3VOMFhK?=
 =?utf-8?B?TUEzOFNraCs4Y005MDRjQlN1SU1UNmR6Z0dMdTJPWlJvdGYxdSsvWGYwYlU2?=
 =?utf-8?B?SmQ0elQrakkxYjVUekE5QmM3ZjhwTTUxdDZWVzRCYk9JOVJZRnNMTEU3SHBE?=
 =?utf-8?B?VlUvMHJsY0JQV1RpMVltZDhQRm4rNnFYdkg3VUJLWWxqQWJYTjFMcUlkVGVx?=
 =?utf-8?B?b0VaRXFxQ2NzZkpubFl3WEtIaVk3UGc1bkVZajBnYjlwVFdvMHo3Wm1lUlBl?=
 =?utf-8?B?MzJqeEtvVXFJOExUQXhmTUh4bFZCYW9IbzJ6NjdOMWlGazRzSUgvUWE4ZDJE?=
 =?utf-8?B?cU4zRlVMZUVlc2VZdml0TWYyY2h6TEN2WHJsdEJtMkJDZ1dzQ3lpQUNIZ1Ax?=
 =?utf-8?B?M3BnaVdEU3dlUytZMzBOVVQ3QWMyOXdULzYrSW5kZTZvVy80eGJ6RWJqc2Fj?=
 =?utf-8?B?aEJrUDhLcVBGaEtGSXNTOHd0elkzZWVGRmRzYWt6Qy9WckRPaUxRN1kvb3lO?=
 =?utf-8?B?TXVnN0k4aGdpVGROYURPdlJUd09BWlJnQ2VzeURka1Y0bjlkM08zZWZjRUg2?=
 =?utf-8?B?N3VrZjc3UjhlNFhYVHAwTHRLM2MrRUtKOFdiZ2RqZm9nTHIycU5TNEFIdmsr?=
 =?utf-8?B?eGY1V2V4bzVBejR2OUhNYmdZNjlBaEx1SVhjTHIrVWlLZVVOQmZKeU4zMHVF?=
 =?utf-8?B?enJ2UU8zUGhVeTBCRXJ4dWlsUVUzSU1YeTg1N3RXSnZyQ2Q1MG1uam9BMFJG?=
 =?utf-8?B?VGdna0Y3eEtkN1ZISldsaWtMSzhhdlhYdml2TEdwNUVKeVVQbWVGUktGSkF2?=
 =?utf-8?B?Y2Rtb25yWTlBTmJjZTZURzNxK04rTXBHRk55UTNBOW5nRHp3Vk54VHZPQjdj?=
 =?utf-8?B?WG16M1VKNXpWRzlCcFd4a3hOVlNLZGh5ejJITjZJZ3UzSXpNd0RTWTBteW1V?=
 =?utf-8?B?STk4eU1ybkhnVFVGN1VBeHM0a2JtVjltRzRZUUE0Ym1KbmV1T1pBaTFyTVFp?=
 =?utf-8?B?QjY3M3NoeC9aNmVWM1ZOL2F1WHNNMjl5SGZzOE8xbXVvenkyN3dTVUUvRzly?=
 =?utf-8?B?TlVrbXN1NDVIM0FMRUZISFZUMFFka1VHaFVZd2drNm5iK0xubGtUUWJkdFQ4?=
 =?utf-8?B?SkZJZlNiQzBnWDBpclE3ekRiclRydUcvQ2JyaHowQkY5NGg0dnZWZWVUN3R1?=
 =?utf-8?B?ZXJGU2VQS2hZTjlBSUswQm5LYngyRVA4YitmZVlFYWxtS1NJTVlBVHQ3VEdR?=
 =?utf-8?B?dmg1VE1OSmdmZUtwSFV4NjFGRjBiVGdNZW5YNVd0UDVxVWN1Y3VzSFNiYkVY?=
 =?utf-8?B?MVZ0V1lvYXR6bVg4YVpkam1lY1N1R29oYWFhVlBQeTFValpHaHdjR2U5UnRH?=
 =?utf-8?B?bFRmeU1jeWFocEpmcG5oN0JkNTBaUWlvNFJrTTAyNC9LdkZBWTBxbUxpcW8w?=
 =?utf-8?Q?Gi/oMqZk72I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elB1dDlPK1AwYXVRWUxhR2xiVk5UYlBPYTgrZEFqT1g1Vnk2cnRmNk9sQmwz?=
 =?utf-8?B?MUlaNGYrV0VMaU1MdXBITUlxYVg1d0JsSDRHd1hjZEptRGwxTGJWVEVHZTFn?=
 =?utf-8?B?bXFFc3VLNmhmUy9MMFhqaFVHRmxxVXQrejFiRXFDaU11YytNYllGYzBBdFNU?=
 =?utf-8?B?ZS9hYXhtRHVTQ3o2MGV2NzJ3eXdYd212OGRhZDJpZDl6QTdhamhLOWJic01T?=
 =?utf-8?B?MWUwWUVULzRLNVpGelBkT1p2UUh0T3BvNTArdjFpcThSQ2xyTnNDR0xwTXl5?=
 =?utf-8?B?Z05SeGRERUVUdFpQZWNzaVhVTmxLdlQvM1JMNG1ZRDJDNzE4VVhmd3VjMDEz?=
 =?utf-8?B?bGE4d1U3L1BoOVBqdUtLZERFaWtjNlN6Mi9LK2x2YmMzeGh3NHRMWnJESDY3?=
 =?utf-8?B?Y2syYTlDSWhCZjhhV2tyalJSQjRReGswZkQyOWpoK0grdXpwZEN0Sk04QWhW?=
 =?utf-8?B?WC8wU0VNYk8zMzN2TDdIOGU0dnlJSlhiOUk0WVZ0TDJEaUdycm1ueURPUjh1?=
 =?utf-8?B?cE5sTm9HYXVCbjQ2c1dpd0R4SWdyWFZCVFN4aGlCczI5RGlSdDJ1QkNHL2RG?=
 =?utf-8?B?bkkyOVEvek1xOUZlaXRZZWpxdDlsZDJxWGU5YjVDbFFrUDA0Sm81Z1FEZ2kw?=
 =?utf-8?B?Nllac0ExLzlMbVlSY1FYQ1RJRlgvTkRFY3Y1bjlnZTl1eVlrdEducjhiaEQ3?=
 =?utf-8?B?S3dLSTRtQUhNQlg2Z3BMTHRVS2JrRzZYK0NpbWZzNG1uYmUwK3Fkd0wwcmdJ?=
 =?utf-8?B?YW1obTlMZXFMQUVtOTkvczZ0eEhqcmxLMS8rbnJic1MyNWxUcVBPTCsybDIx?=
 =?utf-8?B?QlZDRWZwdE1UTHhrdkhNYlNnOFNYOEo1K2ZlLzhlZWtDN2F1NW50RWNhZEU4?=
 =?utf-8?B?bmRHY0VJZmVBTGF3TC9Yd0hUTlJ2dFNFazkzTXlSMzhGb3FLWnNIODVBVTVB?=
 =?utf-8?B?Z3FNWTVNemY1YjAvUERJeWxCaGtCeVB1N0VRVytEMWVFTmZXUFFxMWdXdWpy?=
 =?utf-8?B?VS9TZU1oWGUydlpkbUZaY0hVKzBRMllMeGJLdzhkajF4NStBNkwwY3ZPTGZq?=
 =?utf-8?B?M01pS1RTM2RvTUQwZmhRK0t6Skd3U25GY0doOUNQTit3THYzQkZBMm1OaXFz?=
 =?utf-8?B?Z0JtN0xHUEJNK3IzOW1sZkxTNkNKNDY3SnNWQlR1cGROalhSV0MvUFhkNTFK?=
 =?utf-8?B?UXFSNzBndVBFSk1YV3A0VTl3TkUvNVJ5MC9QVjBKM2JJNFd3b3lYNWowcThx?=
 =?utf-8?B?R0E5dGZyeFVndDloVFh1cGNiNzJaazJBZzhHYWJXd3lXVUdydmxvSEJRZ0ZZ?=
 =?utf-8?B?WWliVVdLVmtEbGR5R0J5YnBla2NEcy96Q3RNVlc2VU93RmdiUEdoaWpHbkE3?=
 =?utf-8?B?NnorWGtCNE9HZGJ6b2duMUM1YW15dXdJeFhDZm9VbWE5T01ycmtHbDBuMlBH?=
 =?utf-8?B?NERsbWNmQVNzc0ZUMkhiNkx0QnhxbU9DcCs1aHNCenp2d2EvQ2ZOTUMwR05M?=
 =?utf-8?B?dGg2Snp0U3lIVi9uazU4TkxkT0xRZ1Z5d3dOemhSVnFTUmFKNC9UWDJjWk82?=
 =?utf-8?B?eGw2NFA0bjNXU3ZEcTdudURyWVAwRnZqZDJlSklsamxKbWtOZmNWZWJ4aCtr?=
 =?utf-8?B?eTZ2bDJ2QXVIMFNrN0gxSTNXc0UvOSt3NnNIaUJUZkxyOFpBRmVFdHpycTAv?=
 =?utf-8?B?Nk00Wi8rYW9DTzFFcXJOY1RyK01TUEw5bTdUS21KSmVpRERRSk9xY285Q3FG?=
 =?utf-8?B?NCtUTlNEYUhEZ0lzWVVSMkhOemZMMWgzT1hxVnJKL05XZWU1Yllva3ZBNFVr?=
 =?utf-8?B?aE1VTmw4Q21GeEN6VU92TEpRWHF3R0tPeGNRMXFPcFpIczhLelRLTFJWcGlp?=
 =?utf-8?B?Q2tiM2t1VkkrSHVhdzhHSTM2TFByNnA4bHB2ZE12TVVIT0UwMFI1aWlWaWFx?=
 =?utf-8?B?YzhBalpxUVpPbGFxTTNHQlBlM3JWV3p2TlBuOW9QUTNna1BEcGNSb05DUm9S?=
 =?utf-8?B?UkFLYjQxRmp1OFNKUXd0VWJTTnVkM0FDL01CSXIyaGNaZnE3MlBVckdmbGVz?=
 =?utf-8?B?blBqVEFQSDFqUUtUdDdxbVVLSlF0QUVraFlGQVFxQWpxS1pXeE5ZamFGK3dR?=
 =?utf-8?Q?4aEhvsSJWnB85LCko3gE2YOGd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aMHQaCd2RoTMgWmiGg5M2BYjA/ThkirMbTelFMxhoD0Fqs2XVFAdcLS016ps2FQtxs2A+sLfs2g8SYlEi0W65uV4Lj78Qbc8I49ERsW3Dq673Np5tt3sp9pKjXuYHLYZrSkuLjmANHLk+2KrvvimKwlyEnd/8ywT6A7hLrwRrLNlID9IgdJxd+JoLwyjLB1oYOCBYegFX5q33TP8+5kWYiM2khZ5y9j0um48Erqghr26mTEaxy9h7rwXpuvsnPQSuaM8rhOHHMpYZuj0DbTrwTTV2GKKdTUixFBL7BHKoU8rtwtZ/S5ReiqUEw6Fzy8ody121Vn2ERYh8XSODTrncWrK0Db/fn4m2WnVHmvSalMRdozqFSq+X948tTWLnAmwO3bGTQQ7cJiwPWcpHUGhK5tptZvNkF+LfX0TO3rr8XVRb6A57tM8rb/SFBZm3RcGTf/lVYx4TIGVHs84AXyDFDz1xtpcY6GpF9ROBZpGXQSZU+swCMaFJnk3kJAviKYCj6VrJ06BTKU8/6yFBcOghvA31i1OqL3vXbOe46+nUC1BxDoAEjOsJ+Rqmox0vlq/44ihgSoDKyfaZRN1SSnlkV3tr2qVxSkPAvZSINXlHW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29143fd4-3349-495a-b862-08dd8316868c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 09:58:12.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHkqqj/Ky4TbK4usH4gTgGQcy8guMta2Zr3TKodfzYsuepAmX/HCBKmFh/CQYUq4QAlS3Ad83hI3tXDMaxWmgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NiBTYWx0ZWRfX9/eLEtkfuaEX zWlIITFDWQcCC/e6sha8z9h5VZXR4kJy/j+r/YmjQXL4n163ozBuImqTyHvgxQIDhbKchBCThOr 4bwqrqW4rO9ag/qgTOuOX2z1ICGoAxPerQBT7QeRVwEbVw+1w6hSV4vHH+aabWZDtADH8qsvd6C
 cycTcInOSkov77FQjL5OdRSVOe+I1C//y4+jOh130BwicRO+q7qamD+ed7d1XsCRCi7Ce+JC8J/ Wzf/1uZ/mp3pOgl6HPu99jqgDPeobcJlDCH7VjBK6SVAx6KYZjwrIUAmM9ZyN4tG8djuFmKG7UK a6j2r0qSY9XBDvCTNo6z9XdLUe3Mh/De0riVpWtMeM1WhU/f9Eg9LF7uQIL6O7sry6jjCKbcuGE PpHsbFHb
X-Proofpoint-ORIG-GUID: nk6UyWlht_o4s9mwo2a-ED6eTw6onYiJ
X-Proofpoint-GUID: nk6UyWlht_o4s9mwo2a-ED6eTw6onYiJ

On Thu, Apr 24, 2025 at 11:29:13AM +0200, Mateusz Guzik wrote:
> On Thu, Apr 24, 2025 at 10:08 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > Overview
> > ========
> >
> > The slab destructor feature existed in early days of slab allocator(s).
> > It was removed by the commit c59def9f222d ("Slab allocators: Drop support
> > for destructors") in 2007 due to lack of serious use cases at that time.
> >
> > Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> > constructor/destructor pair to mitigate the global serialization point
> > (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> > percpu memory during its lifetime.
> >
> > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> > so each allocate–free cycle requires two expensive acquire/release on
> > that mutex.
> >
> > We can mitigate this contention by retaining the percpu regions after
> > the object is freed and releasing them only when the backing slab pages
> > are freed.
> >
> > How to do this with slab constructors and destructors: the constructor
> > allocates percpu memory, and the destructor frees it when the slab pages
> > are reclaimed; this slightly alters the constructor’s semantics,
> > as it can now fail.
> >
> > This series is functional (although not compatible with MM debug
> > features yet), but still far from perfect. I’m actively refining it and
> > would appreciate early feedback before I improve it further. :)
> >
> 
> Thanks for looking into this.

You're welcome. Thanks for the proposal.

> The dtor thing poses a potential problem where a dtor acquiring
> arbitrary locks can result in a deadlock during memory reclaim.

AFAICT, MM does not reclaim slab memory unless we register shrinker
interface to reclaim it. Or am I missing something?

Hmm let's say it does anyway, then is this what you worry about?

someone requests percpu memory
-> percpu allocator takes a lock (e.g., pcpu_alloc_mutex)
-> allocates pages from buddy
-> buddy reclaims slab memory
-> slab destructor calls pcpu_alloc_mutex (deadlock!)

> So for this to be viable one needs to ensure that in the worst case
> this only ever takes leaf-locks (i.e., locks which are last in any
> dependency chain -- no locks are being taken if you hold one).

Oh, then you can't allocate memory while holding pcpu_lock or
pcpu_alloc_mutex?

> This
> needs to demonstrate the percpu thing qualifies or needs to refactor
> it to that extent.
>
> > This series is based on slab/for-next [2].
> >
> > Performance Improvement
> > =======================
> >
> > I measured the benefit of this series for two different users:
> > exec() and tc filter insertion/removal.
> >
> > exec() throughput
> > -----------------
> >
> > The performance of exec() is important when short-lived processes are
> > frequently created. For example: shell-heavy workloads and running many
> > test cases [3].
> >
> > I measured exec() throughput with a microbenchmark:
> >   - 33% of exec() throughput gain on 2-socket machine with 192 CPUs,
> >   - 4.56% gain on a desktop with 24 hardware threads, and
> >   - Even 4% gain on a single-threaded exec() throughput.
> >
> > Further investigation showed that this was due to the overhead of
> > acquiring/releasing pcpu_alloc_mutex and its contention.
> >
> > See patch 7 for more detail on the experiment.
> >
> > Traffic Filter Insertion and Removal
> > ------------------------------------
> >
> > Each tc filter allocates three percpu memory regions per tc_action object,
> > so frequently inserting and removing filters contend heavily on the same
> > mutex.
> >
> > In the Linux-kernel tools/testing tc-filter benchmark (see patch 4 for
> > more detail), I observed a 26% reduction in system time and observed
> > much less contention on pcpu_alloc_mutex with this series.
> >
> > I saw in old mailing list threads Mellanox (now NVIDIA) engineers cared
> > about tc filter insertion rate; these changes may still benefit
> > workloads they run today.
> >
> > Feedback Needed from Percpu Allocator Folks
> > ===========================================
> >
> > As percpu allocator is directly affected by this series, this work
> > will need support from the percpu allocator maintainers, and we need to
> > address their concerns.
> >
> > They will probably say "This is a percpu memory allocator scalability
> > issue and we need to make it scalable"? I don't know.
> >
> > What do you say?
> >
> > Some hanging thoughts:
> > - Tackling the problem on the slab side is much simpler, because the slab
> >   allocator already caches objects per CPU. Re-creating similar logic
> >   inside the percpu allocator would be redundant.
> >
> >   Also, since this is opt-in per slab cache, other percpu allocator
> >   users remain unaffected.
> >
> > - If fragmentation is a concern, we could probably allocate larger percpu
> >   chunks and partition them for slab objects.
> >
> > - If memory overhead becomes an issue, we could introduce a shrinker
> >   to free empty slabs (and thus releasing underlying percpu memory chunks).
> >
> > Patch Sequence
> > ==============
> >
> > Patch #1 refactors freelist_shuffle() to allow the slab constructor to
> > fail in the next patch.
> >
> > Patch #2 allows the slab constructor fail.
> >
> > Patch #3 implements the slab destructor feature.
> >
> > Patch #4 converts net/sched/act_api to use the slab ctor/dtor pair.
> >
> > Patch #5, #6 implements APIs to charge and uncharge percpu memory and
> > percpu counter.
> >
> > Patch #7 converts mm_struct to use the slab ctor/dtor pair.
> >
> > Known issues with MM debug features
> > ===================================
> >
> > The slab destructor feature is not yet compatible with KASAN, KMEMLEAK,
> > and DEBUG_OBJECTS.
> >
> > KASAN reports an error when a percpu counter is inserted into the
> > percpu_counters linked list because the counter has not been allocated
> > yet.
> >
> > DEBUG_OBJECTS and KMEMLEAK complain when the slab object is freed, while
> > the associated percpu memory is still resident in memory.
> >
> > I don't expect fixing these issues to be too difficult, but I need to
> > think a little bit to fix it.
> >
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/CAGudoHFc*Km-3usiy4Wdm1JkM*YjCgD9A8dDKQ06pZP070f1ig@mail.gmail.com__;Kys!!ACWV5N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJNnwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnI6wgKqLM$ 
> >
> > [2] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab*for-next__;Lw!!ACWV5N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJNnwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnIGu8ThaA$ 
> >
> > [3] https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3__;!!ACWV5N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJNnwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnIN_ctSTM$ 
> >
> > [4] https://urldefense.com/v3/__https://lore.kernel.org/netdev/vbfmunui7dm.fsf@mellanox.com__;!!ACWV5N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJNnwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnIDPKy5XU$ 
> >
> > Harry Yoo (7):
> >   mm/slab: refactor freelist shuffle
> >   treewide, slab: allow slab constructor to return an error
> >   mm/slab: revive the destructor feature in slab allocator
> >   net/sched/act_api: use slab ctor/dtor to reduce contention on pcpu
> >     alloc
> >   mm/percpu: allow (un)charging objects without alloc/free
> >   lib/percpu_counter: allow (un)charging percpu counters without
> >     alloc/free
> >   kernel/fork: improve exec() throughput with slab ctor/dtor pair
> >
> >  arch/powerpc/include/asm/svm.h            |   2 +-
> >  arch/powerpc/kvm/book3s_64_mmu_radix.c    |   3 +-
> >  arch/powerpc/mm/init-common.c             |   3 +-
> >  arch/powerpc/platforms/cell/spufs/inode.c |   3 +-
> >  arch/powerpc/platforms/pseries/setup.c    |   2 +-
> >  arch/powerpc/platforms/pseries/svm.c      |   4 +-
> >  arch/sh/mm/pgtable.c                      |   3 +-
> >  arch/sparc/mm/tsb.c                       |   8 +-
> >  block/bdev.c                              |   3 +-
> >  drivers/dax/super.c                       |   3 +-
> >  drivers/gpu/drm/i915/i915_request.c       |   3 +-
> >  drivers/misc/lkdtm/heap.c                 |  12 +--
> >  drivers/usb/mon/mon_text.c                |   5 +-
> >  fs/9p/v9fs.c                              |   3 +-
> >  fs/adfs/super.c                           |   3 +-
> >  fs/affs/super.c                           |   3 +-
> >  fs/afs/super.c                            |   5 +-
> >  fs/befs/linuxvfs.c                        |   3 +-
> >  fs/bfs/inode.c                            |   3 +-
> >  fs/btrfs/inode.c                          |   3 +-
> >  fs/ceph/super.c                           |   3 +-
> >  fs/coda/inode.c                           |   3 +-
> >  fs/debugfs/inode.c                        |   3 +-
> >  fs/dlm/lowcomms.c                         |   3 +-
> >  fs/ecryptfs/main.c                        |   5 +-
> >  fs/efs/super.c                            |   3 +-
> >  fs/erofs/super.c                          |   3 +-
> >  fs/exfat/cache.c                          |   3 +-
> >  fs/exfat/super.c                          |   3 +-
> >  fs/ext2/super.c                           |   3 +-
> >  fs/ext4/super.c                           |   3 +-
> >  fs/fat/cache.c                            |   3 +-
> >  fs/fat/inode.c                            |   3 +-
> >  fs/fuse/inode.c                           |   3 +-
> >  fs/gfs2/main.c                            |   9 +-
> >  fs/hfs/super.c                            |   3 +-
> >  fs/hfsplus/super.c                        |   3 +-
> >  fs/hpfs/super.c                           |   3 +-
> >  fs/hugetlbfs/inode.c                      |   3 +-
> >  fs/inode.c                                |   3 +-
> >  fs/isofs/inode.c                          |   3 +-
> >  fs/jffs2/super.c                          |   3 +-
> >  fs/jfs/super.c                            |   3 +-
> >  fs/minix/inode.c                          |   3 +-
> >  fs/nfs/inode.c                            |   3 +-
> >  fs/nfs/nfs42xattr.c                       |   3 +-
> >  fs/nilfs2/super.c                         |   6 +-
> >  fs/ntfs3/super.c                          |   3 +-
> >  fs/ocfs2/dlmfs/dlmfs.c                    |   3 +-
> >  fs/ocfs2/super.c                          |   3 +-
> >  fs/openpromfs/inode.c                     |   3 +-
> >  fs/orangefs/super.c                       |   3 +-
> >  fs/overlayfs/super.c                      |   3 +-
> >  fs/pidfs.c                                |   3 +-
> >  fs/proc/inode.c                           |   3 +-
> >  fs/qnx4/inode.c                           |   3 +-
> >  fs/qnx6/inode.c                           |   3 +-
> >  fs/romfs/super.c                          |   3 +-
> >  fs/smb/client/cifsfs.c                    |   3 +-
> >  fs/squashfs/super.c                       |   3 +-
> >  fs/tracefs/inode.c                        |   3 +-
> >  fs/ubifs/super.c                          |   3 +-
> >  fs/udf/super.c                            |   3 +-
> >  fs/ufs/super.c                            |   3 +-
> >  fs/userfaultfd.c                          |   3 +-
> >  fs/vboxsf/super.c                         |   3 +-
> >  fs/xfs/xfs_super.c                        |   3 +-
> >  include/linux/mm_types.h                  |  40 ++++++---
> >  include/linux/percpu.h                    |  10 +++
> >  include/linux/percpu_counter.h            |   2 +
> >  include/linux/slab.h                      |  21 +++--
> >  ipc/mqueue.c                              |   3 +-
> >  kernel/fork.c                             |  65 +++++++++-----
> >  kernel/rcu/refscale.c                     |   3 +-
> >  lib/percpu_counter.c                      |  25 ++++++
> >  lib/radix-tree.c                          |   3 +-
> >  lib/test_meminit.c                        |   3 +-
> >  mm/kfence/kfence_test.c                   |   5 +-
> >  mm/percpu.c                               |  79 ++++++++++------
> >  mm/rmap.c                                 |   3 +-
> >  mm/shmem.c                                |   3 +-
> >  mm/slab.h                                 |  11 +--
> >  mm/slab_common.c                          |  43 +++++----
> >  mm/slub.c                                 | 105 ++++++++++++++++------
> >  net/sched/act_api.c                       |  82 +++++++++++------
> >  net/socket.c                              |   3 +-
> >  net/sunrpc/rpc_pipe.c                     |   3 +-
> >  security/integrity/ima/ima_iint.c         |   3 +-
> >  88 files changed, 518 insertions(+), 226 deletions(-)
> >
> > --
> > 2.43.0
> >
> 
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>

-- 
Cheers,
Harry / Hyeonggon

