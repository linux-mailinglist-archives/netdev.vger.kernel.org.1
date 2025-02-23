Return-Path: <netdev+bounces-168827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB1A40F4D
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11943B56C2
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE1207A2D;
	Sun, 23 Feb 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ntcyK2RY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D555204085;
	Sun, 23 Feb 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740321676; cv=fail; b=irjHQ/ews+uVsFpXlV79FoliJWGWtyadqV4NWsTISdSTZwPSS+KTvD8UD2gTAh9cJqHIgeFyBWSyW9kmZ5MJWUjSMyZo2bf8gDRLdWo6MZX64+FmwpWF7FV84/U5Jk38r8H+Lxm+rMQh/QuvUFuvJmX2t4/1b2hcpRYoBeA9ckU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740321676; c=relaxed/simple;
	bh=lpg/TeX+AO74y4sDnU42Y1hB1D5hgAmXtKPuKXNPM2Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKrOO/mskGT8nJ6Dr0hSmVt5t1tb59na9erF2suP8Us9ozebdmSVEdlPtDLa7bbPhJD4keb7WcayAHHFhzYumHMoR156ptHQSJd0eo2uiKGmpBmkLteKEbzxYbQzQfO80o8fKT632vN+fPFCeowI17dMtBPeLlBdWjOICK/BsUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ntcyK2RY; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NEUg8b002170;
	Sun, 23 Feb 2025 06:41:02 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45007b0dyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 06:41:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM4X0ywduMaAesbWqIUGYF3ieMJUK3bfhOemsAn1hLtdGHBhHfrxOp3UJZSbYWlX1sX5uUiwzid4mN/bX0mZJlzo/ZRgVtvT/y4ppsXXwl3tlTQk1YeRNkMeMfsdHY+ril7eu3dM/XtrR0hwJpFfB0JcE9FhrVqdcseYChSsJHFJLKncXm5Az87ptrr7uTatI7OM6HjpKR8fmKLFSgS7bDcJBQ8s7hVKM2nLFSyZhNQWu8njRom1wiPM308yAVOUSpbZLs/TDl4LbBj2nJfqv2U1h0SC8+TN9+R5JMuPZfHleULwVHq1kiGKN423KaQAHduDUntwKreDA1KGAmHABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpg/TeX+AO74y4sDnU42Y1hB1D5hgAmXtKPuKXNPM2Q=;
 b=fD4Wcxdl5VjXvUp9WNJB6bzHc+RQrDxp+TPRHdPxB3fqtY0KpNWv8Lxt65+G/YG4PdWTai8UZ4PoXdu4wot2ACuhxE4TvV6jWiCXKxkUiCmb6+eHhF3VvxHKnrlI9ICuz7WONoklef+kP52wD1nr/8RWuMp2A0xyzxA1C4HxWZWwBvBa5z2Xx5ikmHch8HY4eZtkF5rEBBGX+XLMgG9Dt7RCdZRoky6srnGsDKfonDmMS+X1FgFiQJ8FMVRi2/fa34QUisTWHcxWXluuvbSSr4ZbjF6OQgtxcLRGDjLQ/X+XtsU/8b97VqNH0m2DYJhHWtVwSORU0+jPt9PKyFeRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpg/TeX+AO74y4sDnU42Y1hB1D5hgAmXtKPuKXNPM2Q=;
 b=ntcyK2RYfs1huxlcEXM9zZS7HETLLCeePrVPu+keVnxfx55WpDTXJ+oebvBFkaYPiEeFOOCd1gskGi1RU48nqg4T1hM2EXOvmxejHvfGr2VsijAcoIOdu4zQsCf01wbeahr8d82kFuTgDggqQ7phMHVNSAigwd8k/OjcvWqhw3U=
Received: from SA1PR18MB4709.namprd18.prod.outlook.com (2603:10b6:806:1d8::10)
 by SA1PR18MB4582.namprd18.prod.outlook.com (2603:10b6:806:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sun, 23 Feb
 2025 14:40:55 +0000
Received: from SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::cfa8:31ef:6e1b:3606]) by SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::cfa8:31ef:6e1b:3606%3]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 14:40:55 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v10 5/6] octeontx2-af: CN20K mbox implementation
 for AF's VF
Thread-Topic: [net-next PATCH v10 5/6] octeontx2-af: CN20K mbox implementation
 for AF's VF
Thread-Index: AQHbhgDxar/nAm+D8k+/vBvE2r+j/w==
Date: Sun, 23 Feb 2025 14:40:55 +0000
Message-ID:
 <SA1PR18MB47090327591A59698DAAD39BA0C12@SA1PR18MB4709.namprd18.prod.outlook.com>
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-6-saikrishnag@marvell.com>
 <d35d5b44-e0a4-4d07-8199-dfc916962c39@redhat.com>
In-Reply-To: <d35d5b44-e0a4-4d07-8199-dfc916962c39@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4709:EE_|SA1PR18MB4582:EE_
x-ms-office365-filtering-correlation-id: 499bd04b-efb8-4dc9-46ce-08dd54181443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFhXbFFCaXdxTGNyTm9MTlpRVmZSdWVlaFFkdk9YaDA5a3dkSHNlUXBMSEhV?=
 =?utf-8?B?Qno2eEtzVWdGd0JvUVlSWHVZYmgyWVkrRGFsem9BSUxEYWlmUnRDbkdLc2ZP?=
 =?utf-8?B?YzNNZXR4c0IvK1FIWFhoMUJuK3FiVDFwZGJabTdCZFV2WkUyMVNjQm5lUS9k?=
 =?utf-8?B?bWpuTlAxT0hkR3RiTkJ2TkpRMCtQbGluRXM5OGNaVnEvNW9FUllwbGVRRy95?=
 =?utf-8?B?dDJKUjZaWmdLTmdyVEEwWDE1dVgyQWtuU2RHc3MyZ0pDajQzTEdkWndwL3dT?=
 =?utf-8?B?UUdxSTZiQ24rOS9VMDJlSmJzWC8xRVduODcydCtLanZjUC9mZ2hteTdhc0V6?=
 =?utf-8?B?MmRYR25xbTczZDlSRVQ2aWpMWHV4cERYQ2JaUGM2angxeDBwSXl5bTJINHB1?=
 =?utf-8?B?Nld4TFUvVzFiZGpzM3plL0Z0andqQU04Rlp6UTFBZzZLVFdrTS9QOXZpaUtX?=
 =?utf-8?B?R2tTVGZFVG9UcElWR3QvR09tL0ZMKyt4blB3SkdyR0JRR3d4c0d6dXAwazhx?=
 =?utf-8?B?SnFiUGRRR2RLUW96b3hLaDV5SmYrRzBHbFI2RDdqa3c0YVh5a0d5UU5SYjUz?=
 =?utf-8?B?Q1FaV2U2Y3BDZk1TNGpyUzd0M0FYcGxtM2FKRHl4dEJzUytsYk0wb0Z3cmVT?=
 =?utf-8?B?NUJ5Slp4bG45Y1RaM1RlcGc4NmdYMGVTd052WjY3alFZTWNidHdkaU1wVHBq?=
 =?utf-8?B?VmVZR3pJeExieDN3dS9henlNRlA1VXdOd0U0S1FhTEI0QnA4Z3BMR1p6eXhj?=
 =?utf-8?B?MlhBMm1RQlIydnJ0eWNNNTdkdnJha0pRbDgraHFUWnVjS0cvYVcyWjJHMjM3?=
 =?utf-8?B?ekJKVDNsZHhad2VmZHNEOTlWUzk2a1ZyTDZMM2tvMklOOVRCcFhjbXI3elV1?=
 =?utf-8?B?ZE1xSmUwWk4vL2lVdUhpcUh4MXpMWGExM0tvWXhuQi9HZXJQVlVINEtVNmFz?=
 =?utf-8?B?QlA1Q1N3cTNpNyttTVB4Vm5sKzlNekR1UDZSb3ZHK25BOHV0a2tkZi8xRWNu?=
 =?utf-8?B?VFN1NTQ2WVFlN2NNTlZWSWlScVlTWlhtTmptSUNJbElOWm01ejlPVnNuRkNz?=
 =?utf-8?B?R1AyK3FDSmdyOXBOb1VYZ2FYeUNJT0dyZ3liMEw3eWRNaHZTd2hMRHgycVF0?=
 =?utf-8?B?Rk44M2h2NVZyRXg2MlNaSm9kR3RDZFVWTFpha2FpNS85QjZtRWIvc25CMzd4?=
 =?utf-8?B?N0lqRmlrUWduYUlkYXFXZjVCQVJnN1UyNCtQK1dMM09BWUl6dFFBamd6Wi9W?=
 =?utf-8?B?U2hUVjFma2x1eDJuRmdaYU13UHVWN0lmQml2RUJyaGtXUFo2QTRYV09QSnFL?=
 =?utf-8?B?b2I3OFRTK2xWbmhvTkdvNlBYR1kwckJzdUM2TjZxWFhFRXJEeFI2Y21TbkdH?=
 =?utf-8?B?K0pIRXo3WWxDcnViUmFNbUxpT1kvSGlzRlR5VXBDelByRExna3lIeU1OTEdi?=
 =?utf-8?B?UUZaRXpWT0p6NVBTaHI1T0hLV2VJVUlBRUlVRE50MDJSNnFFb29Odk5lV05O?=
 =?utf-8?B?R1NGYS8wOG45YlJqbkp0WmUzaklYb3h2UHA0R24rSFA0aDFXL3M3NzJKNU90?=
 =?utf-8?B?cjN0ZDZETWVCV0xiVnZxc28xY1pkWHdlZ3phWEQrOUlxaVZqcHNwTWpQYTJ1?=
 =?utf-8?B?MnpSVkdzdGhPZDZPVWJNekZkb2FiNUtyaktLU2pSQUdteTVhRlRVSEUwN3pp?=
 =?utf-8?B?VWNmNWUvd2tIaHJtMmMvaVA0WmdvdmprQUlkUWlscWt0Ri93ZGJ5NllQVTRB?=
 =?utf-8?B?T3A1OGxVUVZTNU01VVJSZ2xteDJhUUxyaE5HRkNuMFpCK0hoaGlUTThST0hQ?=
 =?utf-8?B?K2cxV09yb1hwVnNLWjhkQjc0Q0ZnVktHS3NXeUdqaDlKRXlpMXlMeHdIUm8r?=
 =?utf-8?B?aitoM2t2eUVMREJSb0JqYVpKMm1BUU9vQy9rVXNvTWFrN1I0a2RrZlZNR3VM?=
 =?utf-8?Q?FP9ECojFpG+O5VHsSY4njTnVodmUBf9E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4709.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1BKUEtULzJhTXFXY2JEMmZPcG04SWVacXRva3RXZ3kxaXhOYlRzY2ZLZXhZ?=
 =?utf-8?B?OTZPZkhpWkZnajZhWGUvSUxYMDRZemNUZVFKT1VLR1J2M3NZc20vWHZmQ0tB?=
 =?utf-8?B?Qi9ROFB0NUxCd1loK0tka2VreTJxbm1EWDNuM1FRazZ1VlhydXZxUGZtdk9D?=
 =?utf-8?B?ckswUmtMMzhJYmhtanVFSzlIMXNRTFFjYVFWbm05TkEvRnVsUW45MDF0N3pw?=
 =?utf-8?B?YW1pb29LeGp4VlpNZzlRVGtNVGNBdGxjT29QRUJSZlArZkFFWkZ2ZkdvNXBl?=
 =?utf-8?B?dUROSHJZOWU4dnJRVS9KeFBJTVptSXd3MDNRY3p5VzVQZFVMMnBmdE90eWdZ?=
 =?utf-8?B?RTczaHcvSitUMklxd2pWSlRLTldoQnBSMzZUa3lKNXRpLzJ4UDhRSUF1OHNv?=
 =?utf-8?B?TXcvazZZek1xWHBsOGZEOFI5RDE3cTY1bW1nb1BPWC9mT1MvUnJDbUgrUStt?=
 =?utf-8?B?bnVidHRqMG9PZy9HNlEvVWE1WjBrc1BxZWZVRDdUK213VzJaZWZRbnE3b1dR?=
 =?utf-8?B?SEhKQWRJeDlYYzRmN2Q1dE01NU1aaHgwVEowc2pNNTBpdmRXMW1ReFJGZXFQ?=
 =?utf-8?B?eHFnNUZsRFdzdVBFNThGTyt0QTZPQU5SYnZHa3JESlpMOXA4QWp3b2NMM0ls?=
 =?utf-8?B?Z0k3bEQzbHZ5Rit5aExMbzVmcFVvcGJuWlpMTVhMYkxoNVZaK0VPUTQzY2h4?=
 =?utf-8?B?VEVVUWxnSXIvZkp6TklNMkFRcTFLSnN5U0tleXJzNlIxdFFFYnlHZit3Kzhl?=
 =?utf-8?B?aHhDdlBKVHFEU1ZmUmxQS08zTmxpMTV0SEtGWXE3STh3NndOazV4MTZ3bzFt?=
 =?utf-8?B?WmZVUFg3alJFZklzanUrcm9PdUVZK0pVZTJVSWs0S0RmQy9aMzVWc0hvb3Ux?=
 =?utf-8?B?eWRCMklCWjdNSldDd0l6UnlFWGlrMTY4Skw0anI0bnVsQWRLbFRVN2h1TjZQ?=
 =?utf-8?B?Y3ZqT1htU0JXZXR6Z1hvR0EyQzBlTDk2aTczbVlxL0NLbnJQYm1yYnhudlNs?=
 =?utf-8?B?QTlKY21xRmpDWENHT1FUd1hZZS9xMk9FSnhyYXBYbVhQV05ScDRqYk9UK2Vz?=
 =?utf-8?B?YUdmN3hRZzJPUUh1KzlpTmVWOVVBd0cvN2hBSStxQzBRUVcvbHJjeGRFc3V2?=
 =?utf-8?B?anI2U3FzcW96ZWVVc2NoWitZNTdDN3NMeVI0RTBxbkQxdlZNZ2ZYdXVLVGlo?=
 =?utf-8?B?ekI5REtWdFI3Ti9WNVNMOWh6dWNWbm1jdzgvbVkwL0tnbFRudDFCTzlqTVFH?=
 =?utf-8?B?WTFMTFV6T3JnV2tVVUN4cXNqOFVNUlBnOFRJOW5zS3U3L3NBSU5wN0VzOHlj?=
 =?utf-8?B?M3dTUTdMdjN0K3NGWVVmOGhuenhkQjNOTmtBVjUxbkhSNnBhVW43UXM1dVU1?=
 =?utf-8?B?S25wdmw1UkFydE5uNHFPZFpWK3A2WGh6L3BZV1A3K3FYYmgxNnJqVlZTR3dm?=
 =?utf-8?B?eDhPWURxWjlWMEFGTXJZMStMaHcySE1hNzhSWUZkNmdiSDB6SHYrTzZqQ2VD?=
 =?utf-8?B?RFZPVEdsZWU0MFF2VkFOSUY2eVZTdlBDNHFDc1R5Z2FYNnZDTVFvbVN4MCtU?=
 =?utf-8?B?ZWtlSFlmRUtHZEVpOFllanEyRHZKRFdseTlFeWVwRUFpeDRPZWZQZXJ6d3RD?=
 =?utf-8?B?ZWw1empWYW9HN0E4UnpMaVlVZDBtUS9ROWJOZUk1dGNkc21iZTVicmZ5bTlY?=
 =?utf-8?B?N2ZZTXpkTzU0a3Z6cHRHRkNKd3ZzQnVuMlFzTDFGUWd3T2RZbWpvMjVYc24r?=
 =?utf-8?B?S0trUHUvbGZIVFdaUXJ4OHlTNWtCSy92Zlh4TmhyK3RQNUk4d3VXcm45TVFC?=
 =?utf-8?B?RXJVazljK2pBcXYrSE1JN0JXOEVJUUdyU3J2V3lXTEFTSndwazVRZHljN0th?=
 =?utf-8?B?R3dBSldvVVJnODVKUkJHM0p2QkorY3h4NjlhVzNLeFB5a2Z5WFR4RWRLVjd4?=
 =?utf-8?B?eTVQbHpvVUptTTBjSWlUUGRaY2lRWUVNTWEvRTMzOHVWMFhnbUNlbENMeVdu?=
 =?utf-8?B?Ly9BN1pKWnFkRnZJNm9HY1ZvbDFrU2EyWFpiV3dVZUtFb3JrNVNQOHEyMnly?=
 =?utf-8?B?QTFnQXJ4dGM2UDZ1T1BYaWJUb2JaQ01VWHR4Y0RqWFc0bTFveVBDdU5jTTQy?=
 =?utf-8?Q?+j0RTIYZgzyD5FGyaSysW46fV?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4709.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499bd04b-efb8-4dc9-46ce-08dd54181443
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2025 14:40:55.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRAXyUuIXqMHbyKBh3nnod6D/CN+JVNz6R96WapO7jW/Jn9BHGMr/jjuYUAJsw8y8svjiO8Dvu5FqleIECeTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4582
X-Proofpoint-ORIG-GUID: Ois8Cs1_Bctzz91vpJYetXv5pmqKTQYO
X-Proofpoint-GUID: Ois8Cs1_Bctzz91vpJYetXv5pmqKTQYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_06,2025-02-20_02,2024-11-22_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDIwLCAyMDI1IDU6MzYg
UE0NCj4gVG86IFNhaSBLcmlzaG5hIEdhanVsYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+OyBk
YXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5v
cmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsNCj4gR2Vl
dGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT47IExpbnUgQ2hlcmlhbg0KPiA8
bGNoZXJpYW5AbWFydmVsbC5jb20+OyBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPjsg
SGFyaXByYXNhZA0KPiBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1bmRl
ZXAgQmhhdHRhDQo+IDxzYmhhdHRhQG1hcnZlbGwuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNo
OyBrYWxlc2gtDQo+IGFuYWtrdXIucHVyYXlpbEBicm9hZGNvbS5jb20NCj4gU3ViamVjdDogUmU6
IFtuZXQtbmV4dCBQQVRDSCB2MTAgNS82XSBvY3Rlb250eDItYWY6IENOMjBLIG1ib3gNCj4gaW1w
bGVtZW50YXRpb24gZm9yIEFGJ3MgVkYNCj4gDQo+IE9uIDIvMTcvMjUgOTrigIo1MiBBTSwgU2Fp
IEtyaXNobmEgd3JvdGU6ID4gQEAgLTYxLDMgKzYyLDQ5IEBAIGlycXJldHVybl90DQo+IGNuMjBr
X3BmYWZfbWJveF9pbnRyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcGZfaXJxKSA+ID4gcmV0dXJu
DQo+IElSUV9IQU5ETEVEOyA+IH0gPiArID4gK2lycXJldHVybl90IGNuMjBrX3ZmYWZfbWJveF9p
bnRyX2hhbmRsZXIoaW50IGlycSwNCj4gdm9pZCAqdmZfaXJxKSANCj4gT24gMi8xNy8yNSA5OjUy
IEFNLCBTYWkgS3Jpc2huYSB3cm90ZToNCj4gPiBAQCAtNjEsMyArNjIsNDkgQEAgaXJxcmV0dXJu
X3QgY24yMGtfcGZhZl9tYm94X2ludHJfaGFuZGxlcihpbnQgaXJxLA0KPiA+IHZvaWQgKnBmX2ly
cSkNCj4gPg0KPiA+ICAJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICB9DQo+ID4gKw0KPiA+ICtp
cnFyZXR1cm5fdCBjbjIwa192ZmFmX21ib3hfaW50cl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnZm
X2lycSkgew0KPiA+ICsJc3RydWN0IG90eDJfbmljICp2ZiA9IHZmX2lycTsNCj4gPiArCXN0cnVj
dCBvdHgyX21ib3hfZGV2ICptZGV2Ow0KPiA+ICsJc3RydWN0IG90eDJfbWJveCAqbWJveDsNCj4g
PiArCXN0cnVjdCBtYm94X2hkciAqaGRyOw0KPiA+ICsJaW50IHZmX3RyaWdfdmFsOw0KPiA+ICsN
Cj4gPiArCXZmX3RyaWdfdmFsID0gb3R4Ml9yZWFkNjQodmYsIFJWVV9WRl9JTlQpICYgMHgzOw0K
PiA+ICsJLyogQ2xlYXIgdGhlIElSUSAqLw0KPiA+ICsJb3R4Ml93cml0ZTY0KHZmLCBSVlVfVkZf
SU5ULCB2Zl90cmlnX3ZhbCk7DQo+ID4gKw0KPiA+ICsJLyogUmVhZCBsYXRlc3QgbWJveCBkYXRh
ICovDQo+ID4gKwlzbXBfcm1iKCk7DQo+ID4gKw0KPiA+ICsJaWYgKHZmX3RyaWdfdmFsICYgQklU
X1VMTCgxKSkgew0KPiANCj4gYHZmX3RyaWdfdmFsYCBoYXMgYGludGAgdHlwZSwgd2h5IGFyZSBj
YXN0aW5nIHRoZSBtYXNrIHRvIHVuc2lnbmVkIGxvbmcgbG9uZz8gQQ0KPiBzaW1pbGFyIHRoaW5n
IGJlbG93Lg0KQWNrLCB3aWxsIGZpeCBpbiBWMTEgdmVyc2lvbi4gDQo+IA0KPiAvUA0KDQo=

