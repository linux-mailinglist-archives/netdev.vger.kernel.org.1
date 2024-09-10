Return-Path: <netdev+bounces-127160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B940974675
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0854287311
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF951AC431;
	Tue, 10 Sep 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gy7D586s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IS9SF2oq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536741A76C7;
	Tue, 10 Sep 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011773; cv=fail; b=dEkfpA2LQ+n9N0JU2awzPveTmtjBl6JBWHZkIxln0WsjpGjciEo4g1GAw547PXY4TPYVAZ++MPt01UzxONiM57yCexNi0lC/kNHA/+e1G/mA0CmFGo8emyih7ZQ4hv7viwHnf0j7jRBvgakjtz921zEDRJHCs/7wk0/05BIm7aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011773; c=relaxed/simple;
	bh=31ScYHea5ViXePAi9OAT04bZgQ19KrHjUccLwVFlvxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5ahTwdCqXoZ1kyLzbQ7MajvGRmOGLNoZPbZ5kgdtGLE5JdevdvC3FAUYq2LUIVapRWq037nf34TO7g07xQJfmzVtV/SRqESFAZpaPa6uOtrQdiB/8CgFwhkSiZY9OsXAIIoaBbfpP3tKazTLSD/X6+mMNgPDnLdGD60PkbiLZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gy7D586s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IS9SF2oq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ALBUAN000344;
	Tue, 10 Sep 2024 23:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=cpwBYq6ytSYBCTCIGKfFDZmJyJHH3KAacks/ee2GJNM=; b=
	gy7D586siYQaFYfP5zLYYRw9DJ5sifgA4jCnC4C5WxRC0UK8xH5ElKWkd+XNxYXp
	ZCYJnjndN8giXswxXqCuUg6x7YCrqpisfq8KlwaifL4sF9SgApYdJecJ9yJi1Abo
	a0HTyw3eOH/6LjvyQNpgkGj6Pq0TKKz9qaHqKwoIXtMmSWvrlJ5xTTYHRivEwG/a
	43rbslwpmYkJpTfQruY/crHeijW0AlW9Xeoggvt30UOlCzF/IheSbZgU0GU6GLdI
	1jK6y7tbjGFwViOe6fUXVtfQFnf5C5rIz1IUnagFcedDoTeWMkxXZJ+eGoMwLGCn
	AfnCmTjC6H61OxbLpQv/Uw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcpwan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 23:42:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48ALvtG7032469;
	Tue, 10 Sep 2024 23:42:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9fhs2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 23:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUO14uWQp4cdNIBEDFULYmDpExrB3VVhLGaqAUdxjlyvZSCOWTfENJITGuULvffoHqTJfWJ8JSbOEThhitibAGyQjegso6erzZfBkCvceGNunG4jMQmPMCyjw9sXEpNreqeg103P2KrydPgpYWa12vR4KelJco5aw6+nOR7uSLWunnzZpiDBuGnxo+fdXalvqpj3rHzQUQ7Mv/ZE5CtxTpA/SuywSqb4+hrkoeiBen35+uY0TpH9XfnF0LQwDxFZSnz3nwXSbuQTkMOiNu1wFU0mYj/MESgbw85TlRCQByvG/p1PjfxlgrzbT46HBv0fx1VRAOqCcpQt3LS4m6eiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpwBYq6ytSYBCTCIGKfFDZmJyJHH3KAacks/ee2GJNM=;
 b=sxC4BzMDspzYfiVNzYRJrBpyqtyEfjN4snSM2P+yJVbgwAGeR8uC5+PcJPwSnXdvEylJXlMZRvXb1JeZlvMGu0c5mzPoCeDeF55lmIAyfLxy0+KRtXPzaSDi0P3qBkF5x6dE876rt9ps2y/FKR4Z3T3h5OogoSuIfUJ1GlQsPYnMu5yal6evkMbbWhCzbwSIBAYO5VJXY6qgxt7kfa8nqPSoBhFc4gi2lM8pZ1IzbCxwucv2DFSac34RAPK0+q6gavs/ZnrS9VwFaGAnQ6l28K1rBV1Ji7KdryS6kzdAFhyKC9SDrD+M8zjouXtxKqmDtKdDgMlYKkzPzpZmqCC34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpwBYq6ytSYBCTCIGKfFDZmJyJHH3KAacks/ee2GJNM=;
 b=IS9SF2oqMS1rJc8f+OTATqn+Qt1K317Erhw0z9ZN0sDSYUQ9ItyhbrT4Z67A68LBCBKfUjWSeWAC3tVHEp6POyf390+pqwr+IhjwomkBMxYMMw++hcr/uzr2l0+UuDVG53JRfdIkXUXwJ+VowpacB/eHDciDgrx/JrqP5st+9rc=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by IA1PR10MB6074.namprd10.prod.outlook.com (2603:10b6:208:3ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 10 Sep
 2024 23:42:35 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 23:42:35 +0000
Message-ID: <1b494cee-560c-48f0-99d7-60561c91b4f1@oracle.com>
Date: Tue, 10 Sep 2024 16:42:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <d8f99152-e500-4f52-8899-885017bdb362@oracle.com>
 <20240910225920.11636-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910225920.11636-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|IA1PR10MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e18b03-afa5-4dfb-2c27-08dcd1f23ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVBGSitqMC93K2M5MDVEMDNxSnpLR3pNYmlOSWhVLzRSMENUb1NoRWVYZjdy?=
 =?utf-8?B?RXhxUEpIeTRlM2VsMTJOeEd6ek5HQXlOcWhxM2lGK2VjUDhUYVkxdk5nVEdx?=
 =?utf-8?B?WmhERVJ4NFYwZCs3SlNZR3NyV1lmWGtWYS85SC9lVGZMYzk1MWtkM0U1RlpP?=
 =?utf-8?B?VmFMRVllcE5jdGxZMVA0YnVBZDEveWlSQUZjY0xiNklaRHdjSlVLNmRFaWxM?=
 =?utf-8?B?YVhDd2xuYXR3M1BvYWJzYnJ6OStWa2tSYzA5VUwrNlpRbU4ySkVVaVFPbElC?=
 =?utf-8?B?RDg1SVNKZWdZY01zL2RHWTdlTTF3SmZiWGRnbnpOOWpPeUtvWFR4MFNPOGtO?=
 =?utf-8?B?Q2RuL29DVVM5UXF3eUh0K2E1NEZMcXMvdHVRWXE2czBYTkQwZEZEVGwzYXV0?=
 =?utf-8?B?b2NEdVM3c1ZpRG1Fd2hwTVZiTS9wRGgrOXRxdTZGYUxtOW9BREVDMUM5S1p2?=
 =?utf-8?B?RWxTQ3ZBZXlRSDlJZ05FbHcveTdJeGVJbk5QdXV5TmJ2ckRTU3YxenRJdjNR?=
 =?utf-8?B?R21FSTAwMFY0aWxrK3RPYXRCdU5SeEpoV3ZXVWhGaFFaeUtKclBtaUtMZHJ1?=
 =?utf-8?B?ZGp1Z0xTYjVnNlo5aU9HcTZ1enRNa00reFAzZEQ3UGlYTGZHZllpVmFxZjhJ?=
 =?utf-8?B?VFhpRzQyS0h2WXFBNkFENzVPUk4zMWFYZi85dkdmSUtLVGJpTkI4YThTSThX?=
 =?utf-8?B?cG9OLyszM1RMaGVOK3BWQXoyc2xOeUFoRE9EYlZzOGlVb2hXOXhlUjdjMlIz?=
 =?utf-8?B?WmxpQ21KZUNwRjhEUzVRQ2FvRmpMYmZUVjhlS3I2QlhJaHpielZHNkxOWEFy?=
 =?utf-8?B?WG81NS9GR0lPY2VwMlBTOGp1Z3IyYlp6dmd2aHhyZTlvWDdreEpza1VIU2s2?=
 =?utf-8?B?bFBSTDcxUjB6Vkh3SjZLQ0J0cWV3eVI1bFozOWgwTkR3dlNUMENwY1FkRzFl?=
 =?utf-8?B?QUFoT1BUTTdmbXVDRG5hQVZ4RU1pc1ZKYkpNMzNoektsNm5GeUQ5dWNnQmc1?=
 =?utf-8?B?TDdxY1QwMFZzR1RVTk9ROVJaTUM2b2xCTkdnQklVYllBdURGclpaSUVXL2Jq?=
 =?utf-8?B?U29lWkZBMjVKVmVnR1hWbjV2RHNLUmNZVmtLaFR2WkI2VGVXb1VlK0VFN3I1?=
 =?utf-8?B?N1lFQUFvd01aQ0dJQTRRa0h6ZmgrS0p3WHZkamhDcy9ybEtIVnFzUlJTdUZ0?=
 =?utf-8?B?Ri82QVlLSW93UGFiNThjbjJMUW5ONlFoZnBmNXpkVGJXNElmV2FIV0dwdkF6?=
 =?utf-8?B?NjZlZWd1eEt4Q2xDT1B0NEcvTEdNOWwzZWc5WHJObFlwWTZmakVneTkzSnhD?=
 =?utf-8?B?SHdJamR4Q1RLWWhka043TTJicFByQTZmQ0VsQlpCWmRCUXNMZHlPZFhva2hy?=
 =?utf-8?B?Y3FiUG4vUFJjdytmYVJzempVYnJ0bm1Ra1Y5MVVDME83ek9wbU5hWllySS92?=
 =?utf-8?B?ZkdVNjc2ZnFMVkhkazR2N0ZtMStEYzhSRGdobUM4TVNNVDVQazY2MWNzaDVM?=
 =?utf-8?B?SlNqUmRBTE1scXhIdkhlRFhsNUU3SFQxTW1KRlRBTmdudFhuZHpVakhUWDAx?=
 =?utf-8?B?MEU0elpBQlJ0WWswRlBHZE1kNkE2TWNyV3BSeTNhcndwcGVIN0Q3aUcyS0tD?=
 =?utf-8?B?dW10OUp3UGhwZm95MXJLMXpIdzlUSVJodDBaakZtR05ia2pycVNjT3J2eVl3?=
 =?utf-8?B?Z01QbmtOdENwZXEwb2VubTcxN0thK292Zk92SkR5Z3psTGQwUWdKQkxDemVl?=
 =?utf-8?B?RzFHcGhiZjlKZTFmbkEwQUVQeXQzSGozbzU1aFh5TVBoLzdKSlV6M2tMeVFQ?=
 =?utf-8?B?L1FKZ0dOMVVlQ2Y5dm53UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TElrQlQ5bU5YcVFqSTF4andDMXR5cnR3V25aS2pKNkFsZk9LYXc1Y3ltRkV5?=
 =?utf-8?B?OU5BRlZIOWltaWJxT0tLMExNSTFSTFgzNHNJZWw4cWI1OEJKS1duaHpySWp1?=
 =?utf-8?B?NXdrY0pGS0xxdEhXLytvR0IxcjY0VThjRWxEdUNrRDVDVk4zczNpUTBESW81?=
 =?utf-8?B?dW9YY2VPVFoyRyszTTc5d1hZYTBWaGZkYnVsSU9RdjAySGRLaWNCUkV0cWtl?=
 =?utf-8?B?QlpvSTBUeU5xTHBBN1FKVWdUR2xnb1lCVFREdk00Ui93bDlDSFo2WHpUM3BY?=
 =?utf-8?B?cjhtWnVEOU1TQTFmZytKTUdibjJvWTdnMmRCMllFczJQNnVQSlB4ems0YlJD?=
 =?utf-8?B?dFQ4ZC9XNEowMHZkdE1yd0t0Qk9OQVhDbnU5cW1iQzhSbjM4QXR2S0wvV1hz?=
 =?utf-8?B?R1ZXQ2xLRkNNdVRvS2dCOXUzMDZOb2E4RkZrUm92TE1HV2pzS3lNRVVMUzZC?=
 =?utf-8?B?RE0wL05rcEhEQXBCZkxNUFVSNC9iVTI4WGZsSVJTbGR1Q0ZtYVA3VnZTMktT?=
 =?utf-8?B?ZytNdDR5bUdxRHN3VnFUY0lnVWUwQyt6cnpvWmNaNUdzNkkyZHA4R1grclh4?=
 =?utf-8?B?dTN2WTM1Z2xIUEVVM0tkWFk5b3dqdkx3V0RqdGxNMm1xVFZaWUplYTRIaERE?=
 =?utf-8?B?SVB6NWVNOGxoZ1k1eEtKZ1phR3pPcHQrcHdWVnNXVTJvS2xOVUVYTFdtVk4v?=
 =?utf-8?B?U2NxM1YrckloTXoxZ0dtL29ZWDV0d0JEc2FOYWtLR3A5dHJwcWVVeENiNlFB?=
 =?utf-8?B?aHd4T0x4dllNNVZ1bFpVZHFHcGtpbHhIWThEenhLc0gvOFhiVzBWRUc0RGlJ?=
 =?utf-8?B?dzJEQUpkSWhBMEp1R2paZnhNNGxzTnlxTTBvbzBrRjVSd0JXbmpUcmtCcm5O?=
 =?utf-8?B?KzVabmpraG16WXVERHI1SDJFSTJQdlZOS1Y3eTZyRCsxVWVqc1lCTnRibmM3?=
 =?utf-8?B?cWo5bjBpd0RndXNGRXRqSDNVVGdnQkhKRFlTR3Q5WU9MMHFpbVVHM1kwTjdX?=
 =?utf-8?B?UEwwTXFUZkh2V0pEajBSQjJqbG1JVDN6TTRBNHF1TFdXVXJ1aXBYVHI0bHdE?=
 =?utf-8?B?UE9wSkw5cHBtYjNmSnNTZ25xSEhlbzdmM2Z0L3g1WDU2bzNyNS9BNmhDcmZq?=
 =?utf-8?B?YmhSMnBCai9GZjB6dnhjL0QrS3NWeGw1WUZWMjg3SXpUWTY3RXpnQ1lYSnQr?=
 =?utf-8?B?azIrNEdEdCsrR01UemZOUHRnY2pEUWpMZDEwZnM5d3YxSTRFZzRmQTZGKzFv?=
 =?utf-8?B?cUtMZmRseFZ6WXZ0c2lJdmNOeXc1RUhJalBOVGs1VVgvM2xLUXh1ck4xMGhy?=
 =?utf-8?B?SzA1aURzOERvVDhrSHFVdjJOWGw4OVBXaWtHT3JVMmVkbExwd2lvbytvdFNM?=
 =?utf-8?B?QjB5N2QvUzdOTjNiMXVFVENNK0hHblhwZlppVjNXYjJRK0ttbE5ENlVYdml2?=
 =?utf-8?B?YUtpZjBXWG56N1JXcjRjZHVDY21HYUN1R2ZiM211VEc0WnMxZjNNRTZCa0Nm?=
 =?utf-8?B?ZnlET0g3c3dMd1ptaXVhMEZ5WnE2dE5iL3p0aTRaTHF0MHpma3FXZGdXSFov?=
 =?utf-8?B?NjdwZFR2aVIwY212dFNSelJmSGVwNkVIbjZCaFlETTk1V1J1blN2SzB0M1lF?=
 =?utf-8?B?cW5QT2EzcVduT3dUSHk3eDJnY2dyQXpRbU5xTlUwUzFXZmt6UzY2T2R2b2J0?=
 =?utf-8?B?Z0J0Yy9EWDA2V29qUXo3b0JjN2p5NTQza0JxTXp4M1AvamxhdEo0Q0JERDF0?=
 =?utf-8?B?MktITFJlNzc1TUZWakxNRHV4Mi9FcjJXOGVNYkVHaDFlemthejBLMnhFajRN?=
 =?utf-8?B?aW5vWTlEZjNpaTlqMXlCRU1lSyt5SEJNWnBxeVBLK0JET1o4MStYaytDa2ZR?=
 =?utf-8?B?MVBmb1B5Vk9OSXI5V1FGaGRMVXpYVHdRM1JmWDVYREI0SlRwUWIwbjZTVEVN?=
 =?utf-8?B?UXFNRUFNYW1nYzVvdzdkRld3VVdzcW5vd2FYcGdFaSs3MHFSNy9PbjRaTkJw?=
 =?utf-8?B?eVpCNmtvT2g5cG95VVp2MEY3ZFRGOHp0UUE1QXFqNzFzZ3lGUlFySnlrd2hO?=
 =?utf-8?B?SGZaenhON3ZRQS9oZHp4TDYvcHFQVHZLSzNJRndnSUxVNmkrUFE2VElXQnBO?=
 =?utf-8?B?SE50bzRqeEpka3RyNHY0M1ZzcXF0RFJHUkgrRkZTbWs0M1g3MXhYcVZoaFNy?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eQawfkgH8+knET9oSlKnPMzldDNPT4nYKOIrQyA3xmhRSVaA40eDw2hMf8At/4v99op5VYQAjSPegtXxIpDTDCFRHu/IPnlMTBOIetmhaisOO49wiIzW50E0dgKC4F/TQQHR0WhFjuDvowRxsga0NeiGh74STpo/mWs5EUAyJ3viNUtTh1ylgtpTSJCRD5oWC4oz9DmQUTclrHBjENTDxlFpGp7OJ5clEOkLdliH8jc0v37FeTSIlOqETHcZUcGBcekBr9pW+1PkyFh/sYZsA3KHlDcn7UmsfOKxTOqVeqABPFiMvxfNyCeUepM/2vZ6KJKNyNy6Yk7AvVdgSAGjAjzA2PQRvkSDzMeuPpgMZbd3kZlStwRjFHegFrnQLczqUuYE6C4MGQiYaRr1zmzigxn0fsMhjMtYcNGlClv0kBkE5cYyoUcO9dY0TWHel9HaNGNyf74S4Dc2UiU41DOXiCN9CJyMnw1NNwA64JUFHo9jdq7rJa4H/ieHF8Lx8+KeH561I2Eqo4kudOMUHS0JEDE5lnOLGqQN7YJIgS2N6YwENnOgGvniUId09PGu12YqULgCQA04Icfs364m9w5PUrKHlgaj0d/3/vvoks2R1k4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e18b03-afa5-4dfb-2c27-08dcd1f23ef2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 23:42:34.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGl03h0iw8Wg26rto+1HkGpMGP0sc0zWEoMEzkRalftBhsxmyG7eRLW9fb2L2gDLe5/2xeCaP7l5DWmaWBIx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100178
X-Proofpoint-ORIG-GUID: BEk037l881CgPcrNNARZVGuwe7Wm422u
X-Proofpoint-GUID: BEk037l881CgPcrNNARZVGuwe7Wm422u



On 9/10/2024 3:59 PM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Tue, 10 Sep 2024 15:30:08 -0700
>> My fellow engineer let's first take a breath and calm down. We both are
>> trying to do the right thing. Now read my comments below and if I still
>> don't get it, please be patient, maybe I am not as smart as you are.
>>
>> On 9/10/2024 2:53 PM, Kuniyuki Iwashima wrote:
>>> From: Shoaib Rao <rao.shoaib@oracle.com>
>>> Date: Tue, 10 Sep 2024 13:57:04 -0700
>>>> The commit Message:
>>>>
>>>> syzbot reported use-after-free in unix_stream_recv_urg(). [0]
>>>>
>>>> The scenario is
>>>>
>>>>      1. send(MSG_OOB)
>>>>      2. recv(MSG_OOB)
>>>>         -> The consumed OOB remains in recv queue
>>>>      3. send(MSG_OOB)
>>>>      4. recv()
>>>>         -> manage_oob() returns the next skb of the consumed OOB
>>>>         -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
>>>>      5. recv(MSG_OOB)
>>>>         -> unix_sk(sk)->oob_skb is used but already freed
>>>
>>> How did you miss this ?
>>>
>>> Again, please read my patch and mails **carefully**.
>>>
>>> unix_sk(sk)->oob_sk wasn't cleared properly and illegal access happens
>>> in unix_stream_recv_urg(), where ->oob_skb is dereferenced.
>>>
>>> Here's _technical_ thing that you want.
>>
>> This is exactly what I am trying to point out to you.
>> The skb has proper references and is NOT de-referenced because
>> __skb_datagram_iter() detects that the length is zero and returns EFAULT.
> 
> It's dereferenced as UNIXCB(skb).consumed first in
> unix_stream_read_actor().
> 

That does not matter as the skb still has a refernce. That is why I 
asked you to print the reference count.

> Then, 1 byte of data is copied without -EFAULT because
> unix_stream_recv_urg() always passes 1 as chunk (size) to
> recv_actor().

Can you verify this because IIRC it is not de-refernced. AFAIK, KASAN 
does nothing that would cause returning EFAULT and if KASAN does spot 
this illegal access why is it not pancing the system or producing a report.

This is where we disagree.

Shoaib

> 
> That's why I said KASAN should be working on your setup and suggested
> running the repro with/without KASAN.  If KASAN is turned off, single
> byte garbage is copied from the freed area.
> 
> See the last returned values below
> 
> Without KASAN:
> 
> ---8<---
> write(1, "executing program\n", 18
> executing program
> )     = 18
> socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
> sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT
> [   15.657345] queued OOB: ff1100000442c700
> ) = 1
> recvmsg(3,
> [   15.657793] reading OOB: ff1100000442c700
> {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
> sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE
> [   15.659830] queued OOB: ff1100000442c300
> ) = 1
> recvfrom(3,
> [   15.660272] free skb: ff1100000442c300
> "\21", 125, MSG_DONTROUTE|MSG_TRUNC, NULL, NULL) = 1
> recvmsg(3,
> [   15.661014] reading OOB: ff1100000442c300
> {msg_namelen=0, MSG_OOB|MSG_ERRQUEUE) = 1
> ---8<---
> 
> 
> With KASAN:
> 
> ---8<---
> socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) = 0
> sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\333", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_DONTWAIT
> [  134.735962] queued OOB: ff110000099f0b40
> ) = 1
> recvmsg(3,
> [  134.736460] reading OOB: ff110000099f0b40
> {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=MSG_OOB}, MSG_OOB|MSG_WAITFORONE) = 1
> sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\21", iov_len=1}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, MSG_OOB|MSG_NOSIGNAL|MSG_MORE
> [  134.738554] queued OOB: ff110000099f0c80
> ) = 1
> recvfrom(3,
> [  134.739086] free skb: ff110000099f0c80
> "\21", 125, MSG_DONTROUTE|MSG_TRUNC, NULL, NULL) = 1
> recvmsg(3,
> [  134.739792] reading OOB: ff110000099f0c80
>   {msg_namelen=0}, MSG_OOB|MSG_ERRQUEUE) = -1 EFAULT (Bad address)
> ---8<---
> 
> 
>>
>> See more below
>>>
>>> ---8<---
>>> # ./oob
>>> executing program
>>> [   25.773750] queued OOB: ff1100000947ba40
>>> [   25.774110] reading OOB: ff1100000947ba40
>>> [   25.774401] queued OOB: ff1100000947bb80
>>> [   25.774669] free skb: ff1100000947bb80
>>> [   25.774919] reading OOB: ff1100000947bb80
>>> [   25.775172] ==================================================================
>>> [   25.775654] BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0x86/0xb0
>>> ---8<---
>>>
>>> ---8<---
>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>> index a1894019ebd5..ccd9c47160a5 100644
>>> --- a/net/unix/af_unix.c
>>> +++ b/net/unix/af_unix.c
>>> @@ -2230,6 +2230,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
>>>    	__skb_queue_tail(&other->sk_receive_queue, skb);
>>>    	spin_unlock(&other->sk_receive_queue.lock);
>>>    
>>> +	printk(KERN_ERR "queued OOB: %px\n", skb);
>>>    	sk_send_sigurg(other);
>>>    	unix_state_unlock(other);
>>>    	other->sk_data_ready(other);
>>> @@ -2637,6 +2638,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
>>>    	spin_unlock(&sk->sk_receive_queue.lock);
>>>    	unix_state_unlock(sk);
>>>    
>>> +	printk(KERN_ERR "reading OOB: %px\n", oob_skb);
>>>    	chunk = state->recv_actor(oob_skb, 0, chunk, state);
>>>    
>>>    	if (!(state->flags & MSG_PEEK))
>>> @@ -2915,7 +2917,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>>    
>>>    			skb_unlink(skb, &sk->sk_receive_queue);
>>>    			consume_skb(skb);
>>> -
>>> +			printk(KERN_ERR "free skb: %px\n", skb);
>>
>> This printk is wrongly placed
> 
> It's not, because this just prints the address of OOB skb just after
> it's illegally consumed without MSG_OOB.  The code is only called
> for the illegal OOB during the repro.
> 
> 
>> because the skb has been freed above, but
>> since it is just printing the pointer it should be OK, access to any skb
>> field will be an issue. You should move this printk to before
>> unix_stream_read_generic and print the refcnt on the skb and the length
>> of the data and verify what I am saying, that the skb has one refcnt and
>> zero length.
> 
> Note this is on top of net-next where no additional refcnt is taken
> for OOB, so no need to print skb's refcnt.  Also the length is not
> related because chunk is always 1.
> 
> 
>> This is the kind of interaction I was looking for. If I have missed
>> something please be patient and let me know.
>>
>> Regards,
>>
>> Shoaib


