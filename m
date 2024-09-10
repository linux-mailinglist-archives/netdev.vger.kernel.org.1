Return-Path: <netdev+bounces-127150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF759745FC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9934A1F27002
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C371AAE08;
	Tue, 10 Sep 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U681AjL8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pqa1dayV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50C18953C;
	Tue, 10 Sep 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007427; cv=fail; b=NGpeIWTb4ga71R/pTedfnSR89/A9EI2ttjrsWikBqBIlGk7PO6Beo656CiLui6j5FR0tA/vBivnXoLIzR9h4z3yCtQqtnMovOV1FUUTm69S/CiwnWTg6oQyfhJeQlenUYfJjbM1Y+w6fd/L6P529vsXkwotHeYcPnm0AXUdiQwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007427; c=relaxed/simple;
	bh=5KtfT9g0J62tGcEDwe2nfYorl0sC5daHARMV5cRU9JY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HuPNU272TZrUJ5wm+/7RBJ5fwn2ipXc979Ecw7/Iymq4itqOwdsmxPWT/qmwGbQlhyIKIaPdo7ZezlqIbGskYfq2+qpPp7GFJ0+PucT7qOLrYBQXuZmT7SCFHdNAniBhLP1PzHoWnJNnUOgB25s+myNQ/3WV1GPwgQ70MBXZflY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U681AjL8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pqa1dayV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ALBYMw012588;
	Tue, 10 Sep 2024 22:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=DXiF7uMmKOyZanpO91RsEwYzubNB2foUaZXqvwwSltE=; b=
	U681AjL8X3Ijxiifv/x5Q3+g8jTFjisis/roki6HzFtKbuEp77rpe/JwNTL4GhH8
	C8Ly+kweo5f16q77I6wrZzjNRMIi6FdwXmYz6laMD37FdoeFrQFp2Njo/adcn5OY
	t7Bd4IzOpnKNPRTha3HYuvoTLncWcDXdUSpgSuF3x2iokZkn8nwO2dZx1kg46OLd
	61qjKz0XBqf0sOjaChqYftjf+u4kyDz1/9cHSiNq/vXkIme+Z1Q8mCtxf8iGyXAU
	ZvHuiU7lEYzwRoc6yFRlc/OgDxF6J6dkCY7tBKl25KzflTEgCvN2vwPouQZW/4Rr
	9TeKdaSYN2KMzS8YDRlVEw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb6uyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 22:30:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48ALxIvi034260;
	Tue, 10 Sep 2024 22:30:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd99pqf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 22:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPqos+j61fLit8vSbssMMgsV/geozBbPSX0GOSVPSmy6MSoxGZYRllphmJPPaNqFqLmaAqVtV+M13WoW0JEj1bSNZtC7LUOCLZzGyjwAtbOGP+7xrGPEjwWE+tShs0aJ5uuX7YY+8nMLwp3RkbZUd9gg5AiZnVa5KAPWSHkvQMEu/WdidsSpadsFn/NK+/l2iKKl9Em1Jfzgn9WyytY4W5QGDVgOt9DAQNuDQAcQCyv/SjXrsOGODWWtPg5Pi5QyifGfC9coyqbH44UBzZK70e8GqeZwhkJN98C8Ghie5kClgJM0zQk44grGlzjUiiYZ9XsMnayKnhz80YPtsIJ/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXiF7uMmKOyZanpO91RsEwYzubNB2foUaZXqvwwSltE=;
 b=cD5Cy7bk3Bbn2FVfNdecfHVjWhB0qoZ77/X3ZSUUheFlQLr8opvV5QgytW7lbgX5liU94PxMuxLGnBrEstlUEEzm7s9NoHOhCRMX4tHjkJXEDzTCA5UxznCgR0bdUX6ZlzYLRJTTeIkIAoo1Pd1g1TaE8dBuo1Np6U0W7SSdg3rDuZDGy2CCTVXBHIzUrz2LbvXMkJOID3PoLfmy78rpHPikXwxEbFkQtaO6/fXzD16O3ECcXLMgKD7nWiM0IZdNgeaQ2ylOAbex/0ebYdmdtZBYWeT9BmW6rFNG2piOMBlOdyl4nNH9eeHgo6m46A+IvDh70JbcmNVYy4M72kT21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXiF7uMmKOyZanpO91RsEwYzubNB2foUaZXqvwwSltE=;
 b=Pqa1dayVbEFv7NLjVD6DxXaA1H/Ua7p5nWnGkXU8QkTgq44skGAWyHMCv6tya8jm7eUXf6B2Nxl64domH/d4gUZBFzNfLfnmlSRz461B1yCDRZDDD476FFdlDaDS67Zb/VxdM9KZAhrm+CnuWzgxmiTWVIJOj69BZia9KuZSUVY=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 22:30:11 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 22:30:10 +0000
Message-ID: <d8f99152-e500-4f52-8899-885017bdb362@oracle.com>
Date: Tue, 10 Sep 2024 15:30:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <58a5f9c2-b179-49d9-b420-67caeff69f8b@oracle.com>
 <20240910215351.4898-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910215351.4898-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c9f221-1876-4c66-853f-08dcd1e8214f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU5jWDhiZHFKKzdGQzhkZ0REWHZic09sTjZkMm5wanFWWlBhMU50cFdRWXgw?=
 =?utf-8?B?a1BySFFxc0UyekI1VFRwc04waDNDTVVSbDBQQmNzNnNraWx2bnNkcDVlZ0pk?=
 =?utf-8?B?M2xnVzVHL0FkVTRpM3BoZzUxS29scmh0TmphbEU2aEU3ZUIrNzJwQXUvWmJF?=
 =?utf-8?B?Z05vaGk3U0tDa0JTSFdlM3A5Q1A5YzFoSFBjOXUyTXZSeFo3M0Fycy9hc3RI?=
 =?utf-8?B?UTZIcVZGbzhLanRsMXdLSEQzdHhwVlVaRks1MlFpVzFYcUdqVFV5QnlJRkJW?=
 =?utf-8?B?WFJ3SVJIMm4rQlVSTXV3bW9aRnJPK3VsSUNKZXFTdWVjNWdlUE1RT1JDWHNT?=
 =?utf-8?B?aU9OOFRJa1NZVytYaFF3WTdIanA1bWprQ0dmMWpnNTdjQjgvNkQ1MGNuems0?=
 =?utf-8?B?N2pZSG04THZncC9qMlFNcXQ3Mk9DZkhRWFhGYnlEUVNOTHZZbW5PYTRUd0xV?=
 =?utf-8?B?azNsSGxsRmZEbUhaSWt3YVJjNllEK3VUVGF1cGwvTURQVDNiNjNQL3UrK1N2?=
 =?utf-8?B?ZEh1NUh5TnFhMkc3bFFoT1hsMThlMmJnMnFDcFd4WmppbG9DamMwanBQL0NH?=
 =?utf-8?B?WmpjRmxxZDd4YlVhSk9Yc050elZxZUxlWG54cHdNbHgreVhjei81ME9aUnRn?=
 =?utf-8?B?ZnZ2VGtkTjRFMTJJRURsSk50NUcxRWJNRWhmL1EvU1VNYzZFMnZZR2R1dnRa?=
 =?utf-8?B?VjJtQUVrY1Bnci94VzVUSzZrZWI4Z28xMkJPQUQvdnQ4Zzk2T1U4YWVHQWR0?=
 =?utf-8?B?VHVrZFlSSjZtVHVoS21qbjVhSUF3MlBZNU5FSE5oT0hqejJ4TGYvSkRlNG9D?=
 =?utf-8?B?Z0s1K2hpMndobEZEU08xcUFXMkZlc2Z2T2lSaW92Snp1OXJIakFJVGxTWCtM?=
 =?utf-8?B?NSswVGR5K2FLenZsc3hVRXk5MVVpMENPelkrRjlMTWJmVVZsaFFmeGJCQ0F2?=
 =?utf-8?B?K0w3L2VYSmhSZUN5Z0Z6c1dVUWsyM3JnYnFuOVFvVTdPQWNHeDJ3cno3RlpI?=
 =?utf-8?B?ZlVvbGswd2FKT0YwcnFSTHRIbi9lTGZpbUxLYWw0QVl3RUgzQ0NzMlMvVEhC?=
 =?utf-8?B?WHlPS3JLSjg2WGk5aGhKclBQNGhPOUM1b0c3OE5QaXBSS0VQQ0FBaDdHeDgy?=
 =?utf-8?B?WFd5RlowbEdCdFZNUTFKM2VwQkROR1FEa2EyZC9NV3Z4alQwdTBOWExPVzhP?=
 =?utf-8?B?VUlYOS9ESjhTRW9BQTZsVHRXNit4b2Qvb3poWGFIWXRqUDR5WDh1TkJVMFlz?=
 =?utf-8?B?cmFwRmdGd1lwQmlIQlFZVVBzUG1XRFRiUW5iYkdqZDZ2UXluZy9zUGJvN20r?=
 =?utf-8?B?V1F0K2duNVA4REdORlVsWjZ4bFJzbUdNV0xzRDRuY0RYSnB0YkhpWDloWm5R?=
 =?utf-8?B?dGpVZXVDSmh2aWFONHpSb1hvaXVnZUVVeG5acXNjdEpQVUhsWDFWQmlIOWFi?=
 =?utf-8?B?a1o2Ymxncyt4eDd3L3BNM3ZtakpqUXFoaTlwY092MEI0dm5hNmdKbEF5Um1N?=
 =?utf-8?B?dStiL1ZCaU9jTkNYd1d6S2w3a0FTVFlENjZoUEQ5WC9BQm1LdUYybVpBU2c1?=
 =?utf-8?B?TGJCbS9KdG1Cdzlpc1FoaU14Nk5yS0RBYWZ6cTdSSUhMQ0EzOVhEZldxT2hV?=
 =?utf-8?B?K3BCOG15MWJEL0Jpc2cxam5yQXAySGxBNWYvMEVabmtNU3ovWlNmNVJ6ckNw?=
 =?utf-8?B?MzBHdFgwSXhoQTl6dXJYc3RpWmxISjBkQ3QyR0pSUFdicTQ5RlJacXN3NkpV?=
 =?utf-8?B?N3NuTUJUQm1nekUyU3N6eDNuYWtpdW5HdDQvSXVlMFZjWTZqNGhCTTFJc3VJ?=
 =?utf-8?B?b1ZOL1krUXdJNS9yTmhQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkVwZ0lkUnd5ek4yTmVPMjE0MXBYV0d6TWE1MXUzckcwZ1B4cDhORCszL0p4?=
 =?utf-8?B?eXlXblFySlhWVEFNYW8veUZCVUV0bmhLZ3BYMEEzZE41a2hUb3piVmNMK0dj?=
 =?utf-8?B?NGlZa0lJS1JMVlFTRWduYVVybWZmeGRhWlJacWJPME5TRDBSN3oyTHlSbzN0?=
 =?utf-8?B?ekUydndIR3BGbDdYQmJ4SlY0aUg3R3Zta2h2OHJ1YmVvcjdLQWxnOWdGdjJ4?=
 =?utf-8?B?WWlOZll1dGtodkRwUkYvQzN6YTRzNUhKTEVFc1NmR1JnUFZqSTR3LzdWRURY?=
 =?utf-8?B?ZHdUanNIcDRlOWN6dGdNSWtZZFhHY1FERmI1M3pnUU9DTk5qcm9GQTk0VEQ0?=
 =?utf-8?B?bUdzaUtTZlJ6TnlGblo3RTZhdGI4VTVzVE0zeU15YStLdFM1Vll5S1Q0V3V3?=
 =?utf-8?B?TUw2VVlKV3RPc1NYaHJhcWZ5OTgvYjJTTFJrcmRNY0lzMFl1a25HTklhdmpG?=
 =?utf-8?B?ZndJRFgzRlRFallDV21STEwwV2paV29qWW5XR2ZlL3hQWHNrRjRTbHQza0Zo?=
 =?utf-8?B?SnA3ZTlvbTF0ekpQSlZpK0pkOEpnWVp0bDI3ekRrM3BFWjBZSERwbHFVVWln?=
 =?utf-8?B?R3VMWUpmdkVCS3NWSmtjSHd2YzdRR1NycGlXbW5wcXlEWk9uSUhsbDdtWG1N?=
 =?utf-8?B?dGVpNE05RGtLUHgxLzNKSERjUC9Oa25HNDJaVVZYV3RiZVJHU0lJR1BheklT?=
 =?utf-8?B?azdtYlpodktyd1Rab2MzVHVGdG9kd0tldFJkbW51d0FWRTZIMW84c2FubkYz?=
 =?utf-8?B?Mm5RVFNEMytUb2VXVEFxV2RFTmYvc2krMjJFTXlpWEJCOTh6ekx1UFhMZTFm?=
 =?utf-8?B?Nk9vdm1VU3lrcTRyNTE5eTNGbnBCZElJN1ZEWU42TGZSM3JpbXZaR3Fyc3ll?=
 =?utf-8?B?Y2pmZDNaMzUvM0U1SEpDcUtMdlhVSENVUzUvS2k4ajd5WTBuZ0t3VVB2eklV?=
 =?utf-8?B?RlNjZ0ZsRGV2bVNCYkJEY3lOcmdDWFF4V2U2bzk5NEJmU2JMQktOa2w0dUlK?=
 =?utf-8?B?bzNDdW1GUkM1em45RzQxMktSTlNFcWVIYnNHZ2JFdVZmcjZidmU3RnNLKzhD?=
 =?utf-8?B?eUJhNmF3aUVVd2RvaGZxbHYrcmthSkpXVmVQeHd0QnpPOUxibGdHUnl3ekc2?=
 =?utf-8?B?NjN0NzNGM3JvdjdZL2Radi9xdUJGYURDRkhxek1hQUc3VFVrTzZOK1JQSStx?=
 =?utf-8?B?dXQvOS9tVERncEg5NkR4U1Fsa3F3TTd3NVJqSElzZC9yaVBxU2FDTXVwNGNS?=
 =?utf-8?B?SExMU2FGTXdaeEQ5OUhlTUZXa3c2emgzdzRDRUkwdzFGM1AxNk9hNzBuVnlI?=
 =?utf-8?B?c3NHcjJQWVkveDVGYmh2WUlWZlpvUkpSb0pad2p1N2tYOHYzM3BqeXFsVTJM?=
 =?utf-8?B?Ym9HVWc2TWJGTzJ3cjlzd1NTUHBTaTJhR2lBSnRDdHk3YWVlOU5SZjZXUFNh?=
 =?utf-8?B?SUkyMVpoNnR6N2tOcEh2ejRCTXRSQi9EOHI4MXdwempTSFJhajZ1V0JZemZ0?=
 =?utf-8?B?dzV1WkRScmxzT29UMDdibnhGeXpHOFJxcGFFaGlKYWMrRlduWmRVMG9TWFBw?=
 =?utf-8?B?S2JGdGFkajlQekRIVE1qenhBNUxGUXlHWmxUcDdxTEZjNHZDTkNMWEdlK0xH?=
 =?utf-8?B?Z3B0RnlDNTJ1aXZ2NThnMUlNV1pFUnJEb1loaTZmcWRteUtWTkc1VVFZV3J2?=
 =?utf-8?B?NTRrUkNXUVdGWGxUN2VsS0lLYUNGYkxjZW91ejhma0JJNmZqcm9mWUVuS1JT?=
 =?utf-8?B?TDYvNERxam91Rlk2L3MzVG1qb1JlaW5JS0praFhqQkJQRzQ1MlVuVVFKSEt0?=
 =?utf-8?B?T0ZiTDFMeitpZnRnREpId0IxTUFFQVJXRWJnd2lHaEJUMGhsSjNJSXY5VWNr?=
 =?utf-8?B?QnBTakFXU2pzQUZVcm9wV1dsUlBoSXNIUlFvWFpTWnB5dDZYaU9EOXFQb2dV?=
 =?utf-8?B?WFh2M3FmRmRWWHhpdS95RTVLTVpQem1HRHBPZUJHODNzNUZlVzBEQ1ErWGwv?=
 =?utf-8?B?K1VGMk1FSXFlMjVMYVc2NkV2U3RESmIzaFZwNVdBWVZiM3hyTFhPdkVYZ3B6?=
 =?utf-8?B?b2VmMEFVdkdJYWtGdFdlamgxU2twNjNhTzU4QWgvQ1B1WXFSdEthZHE1djBa?=
 =?utf-8?B?T0s1ZEs2VzVtUUFyd0EzanBZb2hJeFJpckF5ZnZUbXQrOUYvYXJXYVU4dzlX?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RTHf6++s7OPfb92Xid9ZW1aE39Eftudu7h+XP0glI6ZmqkmpsbTOjjgfzo0x8sumc4/235Dyxr1jrFgvmk6BlWtTv2QDONExR+O6HUtFXTNHk4fRA46NO6K1mfj94IZkplOLuX8FwVLTUCtTAI4snMzWnRj7Fp8cR4V0b08IIA+a/z5BqR+6bLoCJCeolYY12vqD60Knq3l9LeI9Jb+jhoQCrWozKKAZPVVYmPhPCD4p1nNqwWY/JtCRAIYFka0UYB8D25i0+jXF8jeE/6J89V/Jz5RsPhi8MVgmr/uoUSNo0+90LKVvOPPKkNJNfkXk8M5NnUPlAAMcLBxRKkN6U/74H9XePE569REU5hOffCnVGJL2k2Y3TBF+mcxX2QJw9g4RoycHQL8ddTiIv7KNpN/nKM+ck8Tj2+8nTA3iW8ox9p2ehAuJuXzjDZPzKDu1HWpVHi1YRwHaqiaVxk17pBMiCA1uIW7aKZYq76ZEXtZDgayJ41sEbrvwJPCTZsVyJwWr16Thg4HwJFpYkbq5pXQDGs23NMMZ9lud5kt/lnlSrOQ1AmUus5YktwVOA+w3n4HbpwKAW0YzH0q/olmFwnzk63FtrC+3681LPzTiJZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c9f221-1876-4c66-853f-08dcd1e8214f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 22:30:10.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv3o5ToNvuz/6QKxFKhAIMSmUcwtstLw8OMAj0R1ovXWDIyeHUWpYjKAs0TFT9VdGQ2+4qDGOlNfAJFwL6FTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_09,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100168
X-Proofpoint-ORIG-GUID: 584bLwlJUCmYJYIaXnbP6O77FbQOriG_
X-Proofpoint-GUID: 584bLwlJUCmYJYIaXnbP6O77FbQOriG_

My fellow engineer let's first take a breath and calm down. We both are 
trying to do the right thing. Now read my comments below and if I still 
don't get it, please be patient, maybe I am not as smart as you are.

On 9/10/2024 2:53 PM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Tue, 10 Sep 2024 13:57:04 -0700
>> The commit Message:
>>
>> syzbot reported use-after-free in unix_stream_recv_urg(). [0]
>>
>> The scenario is
>>
>>     1. send(MSG_OOB)
>>     2. recv(MSG_OOB)
>>        -> The consumed OOB remains in recv queue
>>     3. send(MSG_OOB)
>>     4. recv()
>>        -> manage_oob() returns the next skb of the consumed OOB
>>        -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
>>     5. recv(MSG_OOB)
>>        -> unix_sk(sk)->oob_skb is used but already freed
> 
> How did you miss this ?
> 
> Again, please read my patch and mails **carefully**.
> 
> unix_sk(sk)->oob_sk wasn't cleared properly and illegal access happens
> in unix_stream_recv_urg(), where ->oob_skb is dereferenced.
> 
> Here's _technical_ thing that you want.

This is exactly what I am trying to point out to you.
The skb has proper references and is NOT de-referenced because 
__skb_datagram_iter() detects that the length is zero and returns EFAULT.

See more below
> 
> ---8<---
> # ./oob
> executing program
> [   25.773750] queued OOB: ff1100000947ba40
> [   25.774110] reading OOB: ff1100000947ba40
> [   25.774401] queued OOB: ff1100000947bb80
> [   25.774669] free skb: ff1100000947bb80
> [   25.774919] reading OOB: ff1100000947bb80
> [   25.775172] ==================================================================
> [   25.775654] BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0x86/0xb0
> ---8<---
> 
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index a1894019ebd5..ccd9c47160a5 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2230,6 +2230,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
>   	__skb_queue_tail(&other->sk_receive_queue, skb);
>   	spin_unlock(&other->sk_receive_queue.lock);
>   
> +	printk(KERN_ERR "queued OOB: %px\n", skb);
>   	sk_send_sigurg(other);
>   	unix_state_unlock(other);
>   	other->sk_data_ready(other);
> @@ -2637,6 +2638,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
>   	spin_unlock(&sk->sk_receive_queue.lock);
>   	unix_state_unlock(sk);
>   
> +	printk(KERN_ERR "reading OOB: %px\n", oob_skb);
>   	chunk = state->recv_actor(oob_skb, 0, chunk, state);
>   
>   	if (!(state->flags & MSG_PEEK))
> @@ -2915,7 +2917,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   
>   			skb_unlink(skb, &sk->sk_receive_queue);
>   			consume_skb(skb);
> -
> +			printk(KERN_ERR "free skb: %px\n", skb);

This printk is wrongly placed because the skb has been freed above, but 
since it is just printing the pointer it should be OK, access to any skb 
field will be an issue. You should move this printk to before 
unix_stream_read_generic and print the refcnt on the skb and the length 
of the data and verify what I am saying, that the skb has one refcnt and 
zero length.

This is the kind of interaction I was looking for. If I have missed 
something please be patient and let me know.

Regards,

Shoaib


>   			if (scm.fp)
>   				break;
>   		} else {
> ---8<---
> 
> [...]
>> None of this points to where the skb is "dereferenced" The test case
>> added will never panic the kernel.
>>
>> In the organizations that I have worked with, just because a change
>> stops a panic does not mean the issue is fixed. You have to explicitly
>> show where and how. That is what i am asking, Yes there is a bug, but it
>> will not cause the panic, so if you are just high and might engiineer,
>> show where and how?
>>>
>>> This will be the last mail from me in this thread.  I don't want to
>>> waste time on someone who doesn't read mails.
>> Yes please don't if you do not have anything technical to say, all your
>> comments are "smart comments". This email thread would end if you could
>> just say, here is line XXXX where the skb is de referenced, but you have
>> not because you have no idea.
>>
>> BTTW Your comment about holding the extra refcnt without any reason just
>> shows that you DO NOT understand the code. And the confusion to refcnts
>> has been caused by your changes, I am concerned your changes have broken
>> the code.
>>
>> I am willing to accept that I may be wrong but only if I am shown the
>> location of de-reference. Please do not respond if you can not point to
>> the exact location.
> 
> Please do not respond if you just ask without thinking.


