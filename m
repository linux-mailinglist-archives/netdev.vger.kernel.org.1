Return-Path: <netdev+bounces-98986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AA8D34FF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F4287A69
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AAA17DE0F;
	Wed, 29 May 2024 10:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318917B50C;
	Wed, 29 May 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980175; cv=fail; b=HsjPBiHtS9qaok3KxxM9PWk8NkhJtwTsYLf/7dUU68qtVoIJlYvJhDv5Ah0/NIcd2nlm07iqq8CQMcI6SH52PId1WbLzzQEkfeHHlWblk2OtoBj2w1Iv8u8Tjb/lt+2xt/55rB8adNbrB2Hqx67udlKjxHM5hbosasAo42HLsqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980175; c=relaxed/simple;
	bh=zA0b7jZFmZnXq9mpRDuvPGWsxKqFq/A31wPSaGnpZI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JURrgUHDZ6p0moDHQfKCiqNHR1WiMuxYzli6k1QGhE5BlGx8zRzEyaEu1atP+PudDKAN+he8WX3pthSFKD7T3mgvElp1EkrNR90D77mx8La6A0Y1lm3hUzM8M3CKTDyQoy+7TOCskIMoe7shDU9gc5MQjYPX5/NFLnVEOmbrT6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T3sIvr032597;
	Wed, 29 May 2024 03:55:39 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90bwrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 03:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gshX+C9F/Xxe69mPW+h8mfOgqDxEkCXLJeHlvEivMu3Huaeho2Lufe7BLCCMJJR6TMYz+JwZlFBOEdABJvzkI3adabuzzY1hpalVdw2RTjelCYpkJ/jbPRRXUxH9dgD9tnsO/SUn1hvTVRg9wL2XxKv1rwdOLf2NN4h9sLAA0fzBDg+rU14ADP6PRn5l4PFJzOTKTzIv1aAuWGaEmGvesEEc71toW8ixR43HX3UTG0IKmNN5LQO67FWcaGQqrBIVALV1Bp/jGtK158T3PwaOuKFL0XIv1NOdjc0mBKbcActaG9XHCDNG1ptfvhUMVX1AmB5wGL3IbLgOgBVOwPzYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3PI2EvYZymAhDH7wWEJ6k5IhomyayBwaHVqh1hedM0=;
 b=hVIorC1HY646ObziRRNotcnpwA6VOfbYrqp1XHIt2ovMVFgmflx/1FMEWIHp8qX9BWQ3bgvMY2FDqPyVIUV1j5Kh87VRW7fJIMcf2/uCB2zRA6VN+W2LMCW7qUsRUNJy6M7j61WG/j4eYdPaNTXj4IEghbFaKrbsTopTUC9Pnkw9gTAWxkKy4OFWZHZtbYqb4YwbCXkpFEOJNBtuZyOPLzOUD+UemuFrH4Io1H4ze3PoHx8acWsDpYKKj2uqgJT6IbqOMq6jhbN9LcvBrw+my0w75KzghsuKiEHRwUawHBAMPxx0DOdD5qMrLcu4rxpHzVfhYnkaecFUekU/Xwctiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:55:32 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:55:32 +0000
Message-ID: <d857ff81-a49c-4dd2-b07d-f17f9019bed1@windriver.com>
Date: Wed, 29 May 2024 18:55:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN when
 link down
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
 <Zlbrf8ixl9jeTTIv@shell.armlinux.org.uk>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <Zlbrf8ixl9jeTTIv@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9bd34f-5b15-4f25-d7a2-08dc7fcddc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGRhTE5idTRoVFhmc1diY0t6MUtIcWJRMFN2VW82N0kxOWJQZFR6ditFcnVp?=
 =?utf-8?B?YTdXWE01UFliSFBjd0cxa3FCVW1mVXlocVNDWnJSU1FOY1RBZkhXS3daNnVW?=
 =?utf-8?B?QWpodmVBSlBORU1ua1M4aldKTVljNUdnak1jd09CWVZVQ05sYi9saFlmTDRH?=
 =?utf-8?B?ZEdQVWowakJJZDdhYW9yQndBaG8yN2xkSVA0MW1wL1BHMFYxSThpL0RHQTQ3?=
 =?utf-8?B?WUVjcHB3NW9uYW5xWjNkU3Z2T0cwWmU0ZlZYTWxKTXgvQ0RrM3ZueE1ad0lk?=
 =?utf-8?B?Y0ZDUGFOdnBTby8zQUFVQUtRa1dNLzNIeENGYzVsWlRMN1JYVmNFN0l6NWYx?=
 =?utf-8?B?cXN6SmdOSFFMbTNZb09EenBvdEVBUVViRkMvYzFGeUFtVjY2Uk03b1h1VXJv?=
 =?utf-8?B?MmlMUUtQeVNQY0NxYndWWVdWZXJMWUxKNjZyVWJxQzZoSHYxTnlMSmNTTVhh?=
 =?utf-8?B?T244SnpQSm5MS3Q1cVhINjRwR2RhWVZRUk9KYnNZUU1KWnZXR1NETWJ0Q2dr?=
 =?utf-8?B?czhaM2NCL0hUaWNlblphT0tlOXRTUWo0aFFGc1NhMEgwQW9jMGVqODZXd2dX?=
 =?utf-8?B?UmhZdU1zL0gvZTJUaWRMT1pJZ2k2bUtCMkptUTREZkJ4T09tYU82VThMRXZO?=
 =?utf-8?B?UXVud2FxQmIyTUZ4dkljVlk3NTUrcVhTRThqM21SeG1EQkkyRVpkZ05FRTRI?=
 =?utf-8?B?S3lmWmgvVS91aVBjb0pRYUJtOWk3VGZpOGlDbW1LMnlSdnZTZmNWSnA1Ritu?=
 =?utf-8?B?WVcycWJnVllvQ0RtU1cvME9BTXlqcVVKS01MaVlmQ2hCQmF5eTFKY0V4Q3ow?=
 =?utf-8?B?RGg2NDlTWno0M1g2SWJJSjlGcUIxb2tsVDU1N2FBVTRlaXZxem9qWFJNK2Vz?=
 =?utf-8?B?YzRZOUhOTE1sRExyN1ZvdUVHQ21ad0ZKMnpRT3c2aS9PQnBOUmtxelg0WXBj?=
 =?utf-8?B?MTBUL0RTUDlVYk5kU09pRDlKZ1dRYlYvZCtGY090SGtqVUtXcnp5Qk5Vb0w1?=
 =?utf-8?B?dXUvd2xyRVZDYktkYVpUaUxlVytRdEZVSW5VdTZoWVl5QmZYaWRBMjI5NXc2?=
 =?utf-8?B?aE9aOC9Yay9UK3U1UlhnR3FaSkZZNnExYkpHTnFGRmxRUCtGV2J5eGV1bGF2?=
 =?utf-8?B?RlpZSW1oM2pDdVgxbUNFMFQvelBaWXRpQis2QjRZMXRZTzZVanZraHVYdEtv?=
 =?utf-8?B?S1pwUlVNRGowbG9iNTg2bmV6OFdYeHRVQjNCbUNNL3Fja1FZYzRYd1JpbDZs?=
 =?utf-8?B?K1NxaDFUNEo1ZllNUXBUTVdZSFZFRElETkVlSWhvZ0NRWU1BTms5aU15Y3ZM?=
 =?utf-8?B?WE1PdEVFT1N4dHM4UWRIVnRQUGlLN2RFTE1uRmNwb29yMENIZ2t1S3Y1a1dF?=
 =?utf-8?B?UEJyWW03cXJzZ09RZEZiVWg3N1FiNElFREZtaWpvQWVOS0hSRnY0K3RUbk1L?=
 =?utf-8?B?TysvSU1RTEJUQmVGRFBXQmFIMXJmUGFwVmgvaEFEdG5acElDbUplM0hPQ0Vs?=
 =?utf-8?B?ODk3N2pzWGJPQkZyZEQ3OW1ISytjTUZFcXpVbWJFNXEwcUl6Q09UQkpLeGdt?=
 =?utf-8?B?RmYwRVdlOC90VTY5OU9jMUhyT0J6RUpoQTg5R2h1emR3SjFEMm5qdWRlYzU5?=
 =?utf-8?B?bktHaC9KWVlhQmowTmRLZzVTOXZiaEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3c1YUdFYXpUbHd6SENGTW5TM3Q2WnZ0VVhaQzRFVHdkZFBMOXRKb2FNM0VR?=
 =?utf-8?B?ZWdhMFpqQW5HNW9CbTRNWDBNWG5tVGZIYUdNT3Y3dHRqMzIxNUN2MDQrMjRo?=
 =?utf-8?B?UGNNMmtoWlpqaXdIT05yeklPb1oyV2FGZmJndUhuR2pqYkpRZnlFU1M1VXQx?=
 =?utf-8?B?U0RXcG5vVEo3S2U0ZFVTQ2FwYVFPcFJ0Ri93RkEvREVCTFEzWUY4ZW9La0pI?=
 =?utf-8?B?THZlVlJFOXVpRnNLeXRYYUE4QUt5U0ZkYXdTWTA2cVplUUFwTXYxQXY5dVp3?=
 =?utf-8?B?MFd5clFteW11OGFOZWJsS2NFU1ErRDhtNGJsanQyVGNFSlFsS09YZTNxbmdU?=
 =?utf-8?B?L0RSd1Q5QTlQbTkyQllsRmJEYTVaNkJoQ3k3NTVIdk1RdXZnTDJBU0JyRmtR?=
 =?utf-8?B?RkNCMWVaR2V5THQ1aDc0TjMxSFdqNTJ0dit3N3BNbmlUamJpdDdEdWd2Qytz?=
 =?utf-8?B?RkxmakU5OTdEVXdqRVZUNHgya043RTAzMWt4SS9VR2c4NVg5Z0VhN085Q0pY?=
 =?utf-8?B?dzlrYWk3V3JOOThWV0dna1JVcDBkY2dTTW56ZGM0WmQ3bjB6STdtQW90ZW12?=
 =?utf-8?B?Ri95MDE2a05NNE9QS0cySkRkci9UcEVqVnA1RDJHL0JyYitnYThLRys4Nnhk?=
 =?utf-8?B?b0JsR3UzWE5Nd3BhN3FWVENzWm0yUTlSb1UyY0FYWWhHcGhNTTVSbXpjRGx3?=
 =?utf-8?B?RmlXY2VNa0habmU4bkJuWXYreDc1RlJ6Z3JOREVlc0FtTkNZcFhGYkJiMVpM?=
 =?utf-8?B?eEMzY3NTMW14TldwRmtCNy8xRFBOWjFxb2VxdXZpQUI3THJtTGZ4MmhBZVpw?=
 =?utf-8?B?Z3B3Q251R0lZTVNsdFZhQ0dUbXZSbVB6K2xQVitwRW80eVdRbExVN1JOZ3VS?=
 =?utf-8?B?OGo1MkdNd3oyQTU3aUoxdDdlbUs2SnNFVUpQdnN0MFBCU0xOQlBZSGM3T1Ni?=
 =?utf-8?B?UlM5OThVcTRIVVl2ZXJmK1hBMkNmdDRFcjE4WTdlSDlrcFVCN2JGaXNZTXM0?=
 =?utf-8?B?NEs3bnBhZWYyczZNdDE0VWplRjltN2VvamdOZU9ScU9SZHFubzFpendXdjNi?=
 =?utf-8?B?UmJ3NGdtMVMwN1d2ODJRUlROWDJOMXFoOVd4WFNJd0hIMVFWWnNCUjhTME1L?=
 =?utf-8?B?ZzZ3d3R1ZHovZkhIQVZhNGZYMlgrKytsWEZEVi9vNEtFSDNiUlk4LzNhMm1T?=
 =?utf-8?B?bjdqbVlnYXNNVHcwd09KTVE4TVNTbmlaUUJiMjA3aG1jd2FpbC9mMmprZlJM?=
 =?utf-8?B?Z0w5NjFoNStCQkRNM0JaOVIwdWo1dUJXRThIOFdrT2dpTHlPK2Mxb1dRWTJN?=
 =?utf-8?B?R1ExRGhpL0pLM3RqWjZBaVE2dm9rcEdUMG5XUjd3bDIzS3B3UnNHaUM2clIr?=
 =?utf-8?B?c0I3UzZ6OUNTb0owMkJiSHFSM2RBU2lPZHp6RlF1bklDaHJKRnlacnFiN3pR?=
 =?utf-8?B?Nk5wNmFUeG9RekVGb2RrTklsc2Q2a0MvbEhjN2hoK1F0NDllVUZpTVN6MUxv?=
 =?utf-8?B?RlY5ZHhvL2NMSHllNkdHU2JHbDZGeGJqMnYxNGIrR3pZUzIwenlOQmQrZ1FK?=
 =?utf-8?B?ZUo3NWZaV3dHS0h6NjlxTTZDYzg4aUJERjlTdndOZ2NjcGRkYm1QSmZpdk1I?=
 =?utf-8?B?RzJxRUJybFJVeXpVUVFIaGNGeGQ4TWlYQlQyckpKRTVvbk9YaWtFaStxclQw?=
 =?utf-8?B?ZjNCY0JlR3hQMUsrYytONlFOR1VpVFlobE8wcWtSTWRaRmVPYS9PWXJhcHBx?=
 =?utf-8?B?SW16d1Bnc0FRWDVNQlJVemV0UEZkMUlFS1lHRHMxWG01K21JUEVTeHVHTnJr?=
 =?utf-8?B?aUprbStUTURLVDVUSkVnczB3YUtPVzNSZEFaeHlCRWFva01Tc2dWUWpFN2tt?=
 =?utf-8?B?VDBRWjVnaXFCakRORE1nRHRaUUVDS1FZWHZtTVRpOEhNNHZJQkRHMmtNdFp5?=
 =?utf-8?B?Y0J3MjVZT2hobjUwTHFpc2VVZ3E0aDh4eVpHVHMvTExwaG1xUjBxOUFYL05r?=
 =?utf-8?B?VXFrOFQrRTVlLzl4WWUram1wQU9YNzRyeHB0VERkbWhBbVJSaEFSY2FWWHls?=
 =?utf-8?B?M09QSjI2VUViRTU4eEVKSlBYRTlsZWQ0RTdUSERpNVNBWUprRUhSUWc5Z0Jz?=
 =?utf-8?B?TUlEOHU3c01IR3hnaTI5M3QrY0VXUEszRnF3dS9VcnIxQWZGRUhRY2IrcjVY?=
 =?utf-8?B?aXdOdk9CS25qTmcyTVZ3WVVNSVJrY1VRc1o3aUNNUHBWNC9JSUR1cmxWMk4v?=
 =?utf-8?B?UGFVTUEraVlFR1M3SEtVU2JibnlBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9bd34f-5b15-4f25-d7a2-08dc7fcddc17
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:55:31.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q6VQAqndWVDAgMWbewJy9tbBk6d33HS2O+Cylw43xG5/tEy6fB2tULIzM6Rkv0Ye6NQMQKoQw9wFZBDLTji1nD4vP+nv2SsGtEyoTD+KoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-Proofpoint-ORIG-GUID: aBUsdqcO5D89T1xR1yzM3vpKS5adNjQI
X-Proofpoint-GUID: aBUsdqcO5D89T1xR1yzM3vpKS5adNjQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290073


On 5/29/24 16:46, Russell King (Oracle) wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, May 28, 2024 at 05:20:10PM +0800, Xiaolei Wang wrote:
>> The CBS parameter can still be configured when the port is
>> currently disconnected and link down. This is unreasonable.
>> The current speed_div and ptr parameters depend on the negotiated
>> speed after uplinking. So When the link is down, update priv->speed
>> to SPEED_UNKNOWN and an error log should be added.
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> So what happens if stmmac is connected to a PHY that can negotiate with
> the link partner, it has link up at e.g. 1G speed, one configures CBS,
> and then the link goes down and comes up at a different speed?
>
> I can't see any way in the stmmac driver that this is handled, which
> makes this feature way more buggy than you're referring to here. It
> also means that with your patch, if one attempts to configure CBS
> when the link is down, it will fail.

If there is no connection at the beginning, we still cannot configure,

but after linking up again, and then linking down, we can configure again.

This is very confusing. I think it makes sense to give a prompt for the 
stmmac

driver after linking down.

>
> To me, commit 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> just looks very buggy.

This makes sense. I think it is necessary to update the parameters after 
linking up.

Does anyone have a better suggestion?

thanks

xiaolei

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

