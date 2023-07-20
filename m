Return-Path: <netdev+bounces-19519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2075B126
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8931C21410
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E8182D7;
	Thu, 20 Jul 2023 14:22:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C10182C0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:22:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306426BB
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:22:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDdhwS023309;
	Thu, 20 Jul 2023 14:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KhKP0/1Zl6I+YAUCak9PhqsqxTEhP3e3fKiJiVGDR6U=;
 b=Yqe8+eWJiaM0fU9o+G3BuvMtRINZ7+cSR9O7KcoHaPH3z/VvQxjJt6OahM9vqGEaJICf
 SU9EMm3Cg+4FEv9syuNrBIRfYk7aYDOvGJyFFYZwJAL0IGGfRenlIHA7DKTLecyZf311
 GctXO8FhubJFqCUGitkaYFrfrCLheIGp1511aOs92tBcf8VH7jZuRFN6IGyHUsc07vEm
 0vVzy+ZEOhtxELrO0km7eKPdwRM1RVPx27kg+XErFybxmOjjtgZt6FETPwkJmtcwhszR
 6XcG+ScbIoy0T+AnMi7dTIC6LDoOTRVkPjiGYW38UIy8JZXdq8rj7BdFWnBkfTlJBlY2 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run771wqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 14:22:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KCaxS9007802;
	Thu, 20 Jul 2023 14:22:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8gq63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 14:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHgLVo8wdrToXF9h5QEZeWVAu1igUbcHQgn09KFoDEO0m0gUyQBYJHX0YbAJ++8n9rjV29JgO3ro1aEUp9LEcNDKakKRwoWizhmECDOmetDtIjMsfdUhBobHGDm5CWcxINMPQ2YcmlOw1xEufZWxIWAgzqmkVch9P7ecb0PhZuFVDcp6FcHjVQEXCiomhdHoTmozkMB2fK0Dqwm0zaQwPuoqS158vOoT2VoPcyYQcNmQZHpNfLGzR+5jg2CABMEGZca73G8ueea2UCELCLYE+cW7iJ1Oi+DILVPtmyLVcYMN9sj6YtiGcuYSkUbR7TPxH4pl/Jo2u8R55V87oiJMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhKP0/1Zl6I+YAUCak9PhqsqxTEhP3e3fKiJiVGDR6U=;
 b=KWv7MvM9mEq8lg9jBep9L257FKNU9ndPO5cve1GIk6RZyUVXkJlC8knE/F6eM06dc/bWFlEV5PEl5PhsdrIwweVtPEKtjwjxMTcIzhjhXVC1qKVikX1gVV3ZGeqN6cn5G2gYEsQ8O5By0WkMiFYJYtFa06MfhF/5683gsNe7+6VhsD9jwVZJaGWAuwK0W1mLS2tJ8Y3hlj42q6gUnJ2J8n8JBF1gQzRLvGOX3D7uebdArP/g5X7aVT7wBJFcwR8mX+PNAetPjPj7+3mhR21s7IXXnPZ/gQHsWowFwz9bZAIXVK4qBR4zQHlCPWP3E4A9ZB5YtBSuoQ9T+Ep/OxlLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhKP0/1Zl6I+YAUCak9PhqsqxTEhP3e3fKiJiVGDR6U=;
 b=fbiK1eVeGbQTsIk7jiGf7wVXktotSYdWJkZ4IM2KxbroJul6sODmTEIrWIRFPDcfMwrAKehzVG1VErsvaoRImcuH+5q9UUXkuBC9a4AsGkXpbHeNyjU48AjdvwejDL6IF5f1rwIiyFIvyzI9d2zyPj2GDQZGhYhVjUH3o1cvdcY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5639.namprd10.prod.outlook.com (2603:10b6:806:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 14:22:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 14:22:27 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Chuck Lever <cel@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH net-next v1 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
Thread-Topic: [PATCH net-next v1 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
Thread-Index: AQHZuapE+HjJDqz4YkacFEKI8Kp5e6/AuJCAgABgBACAAQ6ZgIAAkKqA
Date: Thu, 20 Jul 2023 14:22:27 +0000
Message-ID: <3886979D-296F-4FC7-803C-C0BF61E2750D@oracle.com>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970685465.5330.12951636644707988195.stgit@oracle-102.nfsv4bat.org>
 <8c9399d8-1f2e-5da0-28c2-722f382a5a08@suse.de>
 <74209F42-2099-4682-9478-54040B1BCC1A@oracle.com>
 <497c5403-fdba-1f9d-5e7b-4aa32481413d@suse.de>
In-Reply-To: <497c5403-fdba-1f9d-5e7b-4aa32481413d@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5639:EE_
x-ms-office365-filtering-correlation-id: 12f1c732-65f8-4700-f3a5-08db892cbf08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PHlMxlPEdx53Nu1qhru8LYX1jnKCeJTb0sHxeZpvAzfRmM4N2Rjke5LeVPdLuysdGZhpQgsu79HrP8/E2hO2ZZr5YTV8a4VXXMDnT3yMxJRwSFci+tJeDYI8k4wx5Dy7RQ1XL5vt8kfw61147WjayJ9+OyxRXblo4nWZFklS/RKegFZhaI0Skf13Gh1IH8HPAFOvLsb/xqtzIVHv/A48aDJ7gnSjuG1RtnHkrn+QdN5KjnHfwXtL19dOYU+iVnwk53pt/OfEkLacQtYcEDHGpsIqiH/jSn0NGp4kMaNd2FW+17tovXN5UAP6EP041qRzskbFlNLBXBzU6DYTnLZJ/Y0IpX2RgEnfSQRiiuMNzK5jMBMJqEUVYNgIN83edGwal+PNt5SXWF/ZwjCtDu6TsG6AC8ahNJQrLUy/wwtuYS+TNd8hJuez63gZsa1hDz7WG5WGBIgn9Z7AQ+I8ErrvVNt9bL7R4x6ptufq5hFrvHH4alLm5CVS4Qg3UKRhWPsC3B0sDRdocrqW6Su8sS15cfHlvqAIi9GFIuNUYzJm/1m41BFi+NK2uxzfWEqrYkfiYnFD6ExTr8anBSA6bSAJ3hYQ2e+4f2QdY07dYMdqzPUleFMvZBMV1lLAzIYzoINwKPqSXNwYQA5ABRASwSQN7A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(64756008)(66476007)(6916009)(122000001)(2616005)(83380400001)(66446008)(41300700001)(8936002)(5660300002)(36756003)(86362001)(33656002)(38070700005)(38100700002)(186003)(71200400001)(478600001)(6512007)(54906003)(8676002)(66556008)(66946007)(316002)(4326008)(76116006)(6486002)(2906002)(91956017)(53546011)(15650500001)(26005)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?IBTm+DC5YLdLOZFFH+BJUaJ6/Gs9EMIuAmMFdVpulLHe/60znxh+mAKYMLRO?=
 =?us-ascii?Q?VJ8wjaVnF5i4TlbqbnzOe8m4bUY85y2xiAITfKvTkkifPbT2kR+rAmDDnlxE?=
 =?us-ascii?Q?A9bfvCAGdXJWZQl27eiLPh9fwPj7CVfbJfahv9+RnqbRfdb1bxbjp1GR5Hik?=
 =?us-ascii?Q?rje8HvXuEgUVOYJvdV/Ksp2EdsKhKHbNb0sk21idKfztQf6vYpFUhrKYq0y6?=
 =?us-ascii?Q?bAzHtNNL8DcbrSBk+nKd6Qgnss+5Tra+kXXHW0iepOJpc/HsdLRIfymorsId?=
 =?us-ascii?Q?K0HKb8X18jZZCegZNpwyZMm6l2ve34HCK81ed43QGTaXSYf+Ungp4u++tmx/?=
 =?us-ascii?Q?ZhwmpQJex4FW4aNUHpqtGTYQzU+u5LbQtgdBxdEYH3h5X8SQ9/8NXlc1xBqr?=
 =?us-ascii?Q?2uSIViAqkNqyZnrL4d5VyB/r+5Wsune989PpsYoCd79FFmgQ9vowAIc681rv?=
 =?us-ascii?Q?sCwuFwo/0bCYTTtjElBR/yUCIS2KpISrMRHLcnFwQgO/SuGNdPqLpHEjGine?=
 =?us-ascii?Q?k/Kvfgj6KmKqmMvSy1GX3JZW9CRhhnXlHDXdEVQJEulj1YIWcqzux4Vvu2wD?=
 =?us-ascii?Q?8CS930VDsrXIfldtE5vJAJrGzhE/jkgj34ZHvsaZ7M8XFI53hTQQlvq/+LoA?=
 =?us-ascii?Q?mu57gmscslNrfaw+PVUB0nOhAeMbIBVZnEZoQJ5/1lSsdlDYwhWRZ9GSm9lI?=
 =?us-ascii?Q?8KqcDLHgb7/UZNijvwF5attqCPxbDTlBRpYtXcHd+GOIqh0cMn0sVJ/Mdyep?=
 =?us-ascii?Q?xi7DaEYXTq1gp/Je7N3/hYON81BmlbhI70N1TGXeYNqDkP3yAWvrujJ6LPvE?=
 =?us-ascii?Q?YLNDYVfqFoVIapL/woiKevGPdsaJzptokS+x9f/TBBMdRtrXQcL7K82rXEy4?=
 =?us-ascii?Q?qzRu4Lxbp6yPWVo1ctWN90uQcPONpW0JVPRISWCscG9stfB5ifq02hBUwD/e?=
 =?us-ascii?Q?sJbsGc8dR65N40vgUi8XOhOol90NYHMdgM6oONgyB5CDIIbfdZskXlkIeGla?=
 =?us-ascii?Q?JVvLiYNYt3TQIrAq/rP5Kk/uXphLjPftij1FcncXKvtV4Y5Sk/Xxip1VfVH1?=
 =?us-ascii?Q?4F1tEj0vji1UIw0xIx8tKKUiiGzOfLsaGM1fPjUYhpA8ZcJtQ3wfKBWNMcf+?=
 =?us-ascii?Q?Ud7dP2ORFE8h11XRne6chQz8Et/l3IfoluMHo+uxBcduHoIJkCKSCEAI1MUy?=
 =?us-ascii?Q?IHaAuKc0oE9jptgEMjut/rnGanZsu02koFCm3iK746B3fyBdHFUzBQigIC8N?=
 =?us-ascii?Q?SIfyxG3hDY5LYZL7k+aXBQprg+f0WZ4S8NHj6oStq3TliQF4gdmadnqQnYKA?=
 =?us-ascii?Q?hiBidGmNs3aqRclrdE6KTE9sX5uJfDbe1dfLsRoF5sSCWIBFSfeKWf9lpOzO?=
 =?us-ascii?Q?HCw1OEGjgULIEBeR2MdPguiXUpsXguBite+5q8Co7PeG0v3Ev3QngJyseubk?=
 =?us-ascii?Q?ZujH+7jt2u6sMNbA8QU/ODcT4FIqraBIVU0AOMS/8/ylWYwLK61Z/Vnh/z+l?=
 =?us-ascii?Q?jJPrUxqxUae37pDY6CHBc4n0ISkyEt7l29VfnDC0X1cGP2H+9ys9UBdM1jle?=
 =?us-ascii?Q?oCTMq2AQ0A6NkW2KgscIoT6kL25yMT+w4nNgOQj1MdvW8HKIpAFlOwMaypab?=
 =?us-ascii?Q?NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3732A4E993C46149883A0724439B8B06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?NTRPmctXYZrmVITYLSg2I3Vp8NoNq5ErnNEdAZ4T2uXbiQbejTmMLmn3/Up4?=
 =?us-ascii?Q?l959viOZ9wNrGwj5c7o0lf5dz/KvzrbHqUl7Wmr+Cqfxen4mUjpF67wm3jxV?=
 =?us-ascii?Q?3JLKNiDeTQl+jJnp4vznHVN5OnOlaz3Yt5+4u80bne/0dY9Q5yfvUU9VJqz+?=
 =?us-ascii?Q?/tM1cO6bs7+3Qqo9JgHUZgGgpzipvcSGgCY4QoE0kVncUb0QVo9DnYF/V4Qk?=
 =?us-ascii?Q?sEvK2NHJPgIoGVIY/OIwjHbbI7eT7ajpHPf1p71h/U7GNtY3udJ7QgFhmBkQ?=
 =?us-ascii?Q?wgjCQDs026YQhtXaRmegBzyjLlUnX5VT9MOasJwY6HRbysLK5SHv+ZKh7DMS?=
 =?us-ascii?Q?gQv5uTy3KF7Y7KvO/TloiRnv8Xp1dZTqpLRWyrPipnk/7M6iNEE2EkvUAXzY?=
 =?us-ascii?Q?545EMu6fZWS7zbyCxD99ubwe/8tnsemHnU0XsXz9zsH2/BI+hvBTNaX+MGXW?=
 =?us-ascii?Q?eZz5pWAzOMthJvGSazaFg1nsyUjke2lIHwNKmZfiZ87YK0SJbNbIcmxUJbuM?=
 =?us-ascii?Q?cem7BBvnmrPf6bstI8LW4X6PVHiTb1d58ZmRhqUdZYpejoETfcuX/UpLKrp6?=
 =?us-ascii?Q?h45C/4qTt1+QTTrv1e7c//fkYfmwhyrhj/HUe7vrHny4A/6DVB+dXl2BrdQ7?=
 =?us-ascii?Q?GaosDrnvarhVQakcd6D+1tProyGlXjnjQjvOc4uDu++tBYn7pxtgeclwsjEl?=
 =?us-ascii?Q?RNGioHcPM/SgDDjTBfWc+AnyKVZMDQEY2seNjpYdJ66NZSqNslISCscRfO28?=
 =?us-ascii?Q?jW5fzHGACU553BoTM1/g4MG3YJKMXxodEHjOSgq3xLcqdHKM54CF6XTOIrQA?=
 =?us-ascii?Q?tRX/YrNrbtzdkV8qLwWdykWxDhuec46zccWQCJx2hBVePGcUY2G+xXebI/ak?=
 =?us-ascii?Q?1h9eX2peltp2iXVJ4hJSTDLde60/utvHQX5yjgJ0vgPLDBWAjkyv0LiwG1gJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1c732-65f8-4700-f3a5-08db892cbf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:22:27.9564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjeqItdRnR990cnFGm+QkopW6n2lNeoVqQNUdGdedD0sLbKVcJTDA+suU/EHMSmP7Hir7KktRohQxSUOXinDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200120
X-Proofpoint-GUID: ANEETP4qUjMSfl7Q94alU4KiCkM4gXD8
X-Proofpoint-ORIG-GUID: ANEETP4qUjMSfl7Q94alU4KiCkM4gXD8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Jul 20, 2023, at 1:44 AM, Hannes Reinecke <hare@suse.de> wrote:
>=20
> On 7/19/23 15:36, Chuck Lever III wrote:
>>> On Jul 19, 2023, at 3:52 AM, Hannes Reinecke <hare@suse.de> wrote:
>>>=20
>>> On 7/18/23 21:00, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>> Kernel TLS consumers can replace common TLS Alert parsing code with
>>>> these helpers.
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  include/net/handshake.h |    4 ++++
>>>>  net/handshake/alert.c   |   46 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>>>  2 files changed, 50 insertions(+)
>>>> diff --git a/include/net/handshake.h b/include/net/handshake.h
>>>> index bb88dfa6e3c9..d0fd6a3898c6 100644
>>>> --- a/include/net/handshake.h
>>>> +++ b/include/net/handshake.h
>>>> @@ -42,4 +42,8 @@ int tls_server_hello_psk(const struct tls_handshake_=
args *args, gfp_t flags);
>>>>  bool tls_handshake_cancel(struct sock *sk);
>>>>  void tls_handshake_close(struct socket *sock);
>>>>  +u8 tls_record_type(const struct sock *sk, const struct cmsghdr *msg)=
;
>>>> +bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
>>>> +     u8 *level, u8 *description);
>>>> +
>>>>  #endif /* _NET_HANDSHAKE_H */
>>>> diff --git a/net/handshake/alert.c b/net/handshake/alert.c
>>>> index 999d3ffaf3e3..93e05d8d599c 100644
>>>> --- a/net/handshake/alert.c
>>>> +++ b/net/handshake/alert.c
>>>> @@ -60,3 +60,49 @@ int tls_alert_send(struct socket *sock, u8 level, u=
8 description)
>>>>   ret =3D sock_sendmsg(sock, &msg);
>>>>   return ret < 0 ? ret : 0;
>>>>  }
>>>> +
>>>> +/**
>>>> + * tls_record_type - Look for TLS RECORD_TYPE information
>>>> + * @sk: socket (for IP address information)
>>>> + * @cmsg: incoming message to be parsed
>>>> + *
>>>> + * Returns zero or a TLS_RECORD_TYPE value.
>>>> + */
>>>> +u8 tls_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
>>>> +{
>>>> + u8 record_type;
>>>> +
>>>> + if (cmsg->cmsg_level !=3D SOL_TLS)
>>>> + return 0;
>>>> + if (cmsg->cmsg_type !=3D TLS_GET_RECORD_TYPE)
>>>> + return 0;
>>>> +
>>>> + record_type =3D *((u8 *)CMSG_DATA(cmsg));
>>>> + return record_type;
>>>> +}
>>>> +EXPORT_SYMBOL(tls_record_type);
>>>> +
>>> tls_process_cmsg() does nearly the same thing; why didn't you update it=
 to use your helper?
>> tls_process_cmsg() is looking for TLS_SET_RECORD_TYPE,
>> not TLS_GET_RECORD_TYPE. It looks different enough that
>> I didn't feel comfortable touching it.
> Argl. Totally forgot that we have TLS_GET_RECORD_TYPE and TLS_SET_RECORD_=
TYPE ...
> But to make it clear, shouldn't we rather name the function
> tls_get_record_type()

Renamed. Thanks for the review! I will post v2 next week, waiting
for more review comments.



--
Chuck Lever



