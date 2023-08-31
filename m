Return-Path: <netdev+bounces-31595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9778EF34
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797EF2815F8
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4911C8A;
	Thu, 31 Aug 2023 14:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F96FA5
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 14:04:32 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD7CC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:04:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDbLL4009225;
	Thu, 31 Aug 2023 14:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aBC8S/XPYk4M7egqJMPeQhpb3hoebpZW2M5nkXTCFFw=;
 b=oKuvDE+JakaZPQHMrpu009lEo30yXSMNwDjh80vy+GA4HWctLJ7ki6YG5ZjI3nDcpf/X
 WkSjKTYCNIO0eAaIuWOKYi3Tu13g9Kg4ebcb9zBAF4M+0qX8/YFlCLTbSpj20Q73HUng
 hCQ9ahMZoB7afOnQYF5Om8qTnq/rlQ3qs2U9O5Jg+hxqvWXXIzjKfvqIxmwe0a44GBZ3
 vYp1f03hvS6NlQ8Y3wFpxZqjhEYTTNNZLQd/WyiifWQmqTvUROKWwQHDKD7xhr2vHukc
 aHK+DmEPpvQDukThetWoXUV5eqXXAbpx5wcjO+J7KRKPp7gqIMISL3Gcccpov+t/8SRK hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcsv7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 14:03:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VCoKmZ009134;
	Thu, 31 Aug 2023 14:03:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sseq0cu82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 14:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qul5iHO4jDqEfHqeepFoNio155tf2rDWuDxv3I44GFQw1eX48pnTMkcCf5LDbofumbHAKQbHE2hiQaIhzWpD91SiukLu1F9GhVU1FLSnXTnK8yhWsoVdtg1pCRaKRnQK9ZjS0F9echvnfP+IYOg5/nA9O1GlFr/neH9oyO2N9zkeyHP7CjhNAtqosfYq8opB7J9iJQmyWYmuH2x+u0nnUPz6Bs5kTs7JCgR3hc0Ic200ajtBH02Knx4rsb6ulvZq7UT8F6xeWIMTCQGytZU0EKwu1ZSwupV0kJ31+ULDooFXuxJ917aVtHTziCWwg8tNU25aAKlwpbZwNFq+ZKFrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBC8S/XPYk4M7egqJMPeQhpb3hoebpZW2M5nkXTCFFw=;
 b=OjNwzoWWmkgo1nQFf854rIb7vGnTYp1ox+shelauWbvWRe/ax849apU3WUbFxYfwXmlYPYOOS8knN9JlKstwF6BP4sLh4ZFbm6SkEWtY1YIoazriJymnVEKKufjc1qdLSOKLjQTCmdSIooklYoYHcqRZVC7YF+UMa7kXBWWvX/PXo/ikJdZ4/ORMKcgbve3tLyzQpoCuv9GBOM+HjJzVSlANIe9pXo6IF0wdi8tMFnOoCrucaMp3QqRozVPiKoCNNEhaZPGmO4f34G49tYjXmW+R5ATItrOoJ2hj0mEFMPN1yvSL9b3VBbGgNSlXok+jYvu2gAX/33QRwRbbagw6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBC8S/XPYk4M7egqJMPeQhpb3hoebpZW2M5nkXTCFFw=;
 b=jDOMRYjs8xRwi698kgQyZiZ2Mx6Y1Ymwe4dsVRv8NRI9sWyrmaoNgZxAtgqEBlbFTBaH3Rb/eTOhCStB567gTWT/AxiYje3lwnAqZSuhDfOi1Ym7O2CHw4RnzK9tT3nQB3MbNj7a7fc4eApAG4uSmE2mJENM3MfwHK6w6Zcb7ic=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 14:03:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 14:03:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "eric.dumazet@gmail.com"
	<eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net/handshake: fix null-ptr-deref in
 handshake_nl_done_doit()
Thread-Topic: [PATCH net] net/handshake: fix null-ptr-deref in
 handshake_nl_done_doit()
Thread-Index: AQHZ2Y/zCUml1l1800S38i2aQ5u8t7AEDb6AgABm4IA=
Date: Thu, 31 Aug 2023 14:03:20 +0000
Message-ID: <38F21A5C-DDFB-45C4-98BE-1690A3E5CA42@oracle.com>
References: <20230828091325.2471746-1-edumazet@google.com>
 <566a0f821ec2fdbcb6b31aae56e478c6d4d59fa3.camel@redhat.com>
In-Reply-To: <566a0f821ec2fdbcb6b31aae56e478c6d4d59fa3.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4785:EE_
x-ms-office365-filtering-correlation-id: 5c353b5c-8959-400a-96c1-08dbaa2b088f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YDH/68xZ1lpT8WHRTxEHc1vOkyb827xAVFKoUMg2DtNlsUIdDpW93GLSqaNzWYZMJBcjETzWmtMixNKa4snDRkW4Uf6VJg7kHbhYM6190j5+sygCWfUiP/vugokvHJJuoyPo7ri+VopDDbasGindEm43Tft6pUt6qnHnHPyp4L+6U3KD3p4Naa6ff2m8SnqXCoZU3RXlf524oep4fJi2Xz9AXc13sT51oKyxtHz3V+1qtS/XRnYhn83ri48VmRkULAWMF6xa/3QvabhZs5o9aHJWz2yx8sMK266YL3G0EVijSAxIu92cX2NRnrTEWN4fjipeOaNJSOMBT1iPCMDvdKr08LfC8t1nZH6VigwH0dNXC/jiK+jBIs35YjGF66Tq86/BmC9VRh6gRY1e4zpV8yqCRkWRPaJGqGNQxhf5oko1rxOTYlm7/JM64A6ul5p9AOfCvYlttQsVpIFiavz9/Pq2FDrvFsb12/b+COaEegg3IZQ+jB0PskJJLyHr0/ynvl0Sc41KZZ/XL924UCtTaRudAkEIIs/Vk2KI2jhb1g645SkXCyT/jqJZhxkKWCLw1tzRUKUrQZ7hxETHUAfk3xoryliuW5JbDnzWJwno+OBsHiy0GCqoQnmk4fw11yxTiTdvrx76fXPa9hgxDfPQ4A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(36756003)(41300700001)(33656002)(38100700002)(38070700005)(26005)(76116006)(91956017)(66556008)(66476007)(66446008)(66946007)(64756008)(83380400001)(54906003)(316002)(6916009)(478600001)(71200400001)(2906002)(4744005)(53546011)(122000001)(5660300002)(86362001)(6512007)(8936002)(2616005)(8676002)(6506007)(6486002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4yIYOHDaO4XE00/h0FmSSlCM/cyvV7m5M1R5DzovVSSUEBVirWvEItkMfAk3?=
 =?us-ascii?Q?/5X5ZGyyFYL+IY3WxqqutCNYpCrkH2Xb92pJRFGdvuLi3HK4pXJ1Y6iDnqtK?=
 =?us-ascii?Q?LygStGo0PulO4UWviOlgnSIfpv12Gu1M7azpajKyMlq4mtm9iYqXSmIuuA/D?=
 =?us-ascii?Q?D7knI0NLhxXM6mV8FWtjeJUVAKZ56lkD4k036xKzHAsQJ6ab1kqyge3NdXq0?=
 =?us-ascii?Q?6SgVChjY8jAoFZR9E1XL6UCGnyHuHYu6coHIYKyVWxObXZ7qyXrV9xjVuFaM?=
 =?us-ascii?Q?B+AL5Oz7IlnJ2jlmcyXbGpA03XiHXCvxRCnPDeGlYxEphSc2tXVPyzynIGFb?=
 =?us-ascii?Q?hFGseByw1IBmi9OsrSd+h+AGiaHdP8NRjwUqqua1b1KbfrZuYrz/Y7Q0Us44?=
 =?us-ascii?Q?fpQwfIu3xmH97AOxJkhlymjWyQs26xGSWy7bxH4glPAYMhjhfM4/NZ5idrVW?=
 =?us-ascii?Q?YxnKV6Ck1JwNG6gHVpwa6LU8CrBInVxdwrlw/KE5FXnQ8UVtH9v9qn1VMuED?=
 =?us-ascii?Q?tFqoWsRUy3229NudqgzUr03KNwdj9r5yBLYnyxFET7KzSTILK3eeLddhp8Ec?=
 =?us-ascii?Q?BHmuRK8pTqCFfQmz2dEv16Ziz/MNHVI/xsN12PsIP9aNdeZNOT6jXL49XOL2?=
 =?us-ascii?Q?rpkOCA7rdqeKGQclM0PUAqW2evsC5kXVDGNhdHa89sikgXV/tCXeCiDbNEXs?=
 =?us-ascii?Q?wyQo/noAdVh1IZTS5yunfrold+SUWA4NAIYt0t6okxPbiGcScrZQC046fL2K?=
 =?us-ascii?Q?Ige6XUkuRuCCYVfH/BN3o5UlIHGudKh4BkxnSM5iRyJk3DX8WfOg53OyAvAt?=
 =?us-ascii?Q?bUlKDaqwHyxeyELyFiw8M3mmuAB7rMXtY1A8Zy6IIH9UICPSrqRKf7lBTKUO?=
 =?us-ascii?Q?u/yVEVeTUOAL6G8bcd5OI60s9h2AqDsILP7zV7ehm+8oP7wyGt2ciL0FSsue?=
 =?us-ascii?Q?37ja76JVnPt8yUB6KnqRW5+jMWibE3z5CVNZc2gv1OSzFxCGY3IDE8qsi6o1?=
 =?us-ascii?Q?eFMSIAk9Q4qxwi55JNsdfwXNEjJMWeaAsOWsHT93mHC8DlbDEPhB/cuM+hLQ?=
 =?us-ascii?Q?8ZP4OUTyQqxe0cQkOaA0yDjBUFJ1QefRALj1Jp5wepP4Ks9aMRc79AO00dfR?=
 =?us-ascii?Q?ObSy+5iYgShBzQyy731GvA31ncjzkUyea/TuTT8gAEGsyFzO7NQpKbLEYLnZ?=
 =?us-ascii?Q?rZVnUW30BNUkc1cWdqUt/KJS0a0ZNz2PVvcunbqnQ0nXkurhIJJbKeOswdug?=
 =?us-ascii?Q?7f/CQTOL9ScBqCP/GIZmguTmWZOGTZffpda+41DbP66vLBnb7qpsCYA4g6Fg?=
 =?us-ascii?Q?m9pGlJ3EQqe0bmqmhaX2bsq3pn8JP8009XFkyfXf4QtT/6ydjRjS4M4FICWm?=
 =?us-ascii?Q?3Lu+UsU5SCGWglouoRAUp62JiRw4pEFUMb93XBwhv/Nkyq/GTQk4TH9U50Vh?=
 =?us-ascii?Q?jZR7LPE6Tf7X97AjsJ1nQYasBJVyH8ikytRrfmrsFJxu7E8aY2XWotENen+G?=
 =?us-ascii?Q?hp8UblY6425vF9qs8X30FkY2oFsk9dnu9VUZHoJIFV33nEXfuokkboS70spq?=
 =?us-ascii?Q?yVk0BY3u+5ACiib7/FXkP4y8mNJN6amel0O98twL6jrdAGvMkr8R2+3eFM8v?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0EC54AF458B3C47A757E7AF7B3201C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?E6guE7xESZSXnSSkGLHXJ4vgqVuPIw/7EKTDtGvsW7u1alJGmZzqABtLTxSD?=
 =?us-ascii?Q?bDN+k7lR45t0uOvvWmrYmtStas7oBMcytwimIo1rh4gJDozRRZpfQ4CJM+vE?=
 =?us-ascii?Q?gCvbncfXeo8T7gCNb3K5S9njyW9t02Vqyfm0ydqAGXESa1Xe9xfEQW62eXVA?=
 =?us-ascii?Q?g4HHPLGw3F8+y76m0mBC6zsFMJLJPdIYhzMi5vUage/XVVxwbFL58OKiUnSR?=
 =?us-ascii?Q?lGjVH1pY2DybDhwdoe/KB1SEcwyT7maXsYtu2MyfVBK+dACMMBDCuBImT4Fi?=
 =?us-ascii?Q?/CWlOVe8T4XdmAcsQXFyxpTSvLs6lzIbbXH5QNWyDZdgWy+GyHrwZrFON0ZQ?=
 =?us-ascii?Q?/p0yXVFt4anrisX3nwpj+pNHlHINM1Bmjq5HV0DmlwVzAqLBts3jlvafgtSA?=
 =?us-ascii?Q?7nutRsAldwVtvX4P/1Gq55lj6B+RlJJ5KYwcJqUMMXy+bmmWNvyA9gxbSeT3?=
 =?us-ascii?Q?e1pa7wFN//B0ayCrVJCleXvX0p3QrocdAgHNYgJ95KtHlPcPWcqQNRCPDCTV?=
 =?us-ascii?Q?jQ52gEcpyZHlYa0dipXAhFuNvE21Qb/KFPFAewngU1BHyycJDC6fIywApOlY?=
 =?us-ascii?Q?Z8CZkZv/hKxYFW3u4vz19+3bFRB4TLSQgsUNnIGv/2kDF2gHB+QMvafIWsxz?=
 =?us-ascii?Q?qq3LeZ29Cm2O8//+onuomnUU/49CGhziCiWAxtEkSnJQQmCmSbqsP+s07R7P?=
 =?us-ascii?Q?7L8WUFB2bUSfEXhcUv0yj6i1j94KVQIt46TKrYTWd0l9TlDeCm8UpgMvVq3F?=
 =?us-ascii?Q?3fvoe+JHcZqgivERBiIoQHLXJZjgpFS1hcy0hmFr0NitFrZE822Ed5lreGOM?=
 =?us-ascii?Q?BGFAV+tPEMk4vzJkXwi1Nx/FtsvurtPVpJxGMXkcU175T0PlJzYvcxyM6usm?=
 =?us-ascii?Q?TodhH25O/ifeZ8aHfen93k3elxumN6VOz04J3kkHYTwDWY7LFvshwuiBY2MJ?=
 =?us-ascii?Q?jQ+ZLw1q5wlPegTWqqK8og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c353b5c-8959-400a-96c1-08dbaa2b088f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 14:03:20.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6yXiF1AZ6NH5zHDw6BnApQHYWByh4hXhrm7t5eHr4HUytNUJdvAnr70O4/VnSCgqJ3ZWxMKf22t35S1Hop4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=759 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310126
X-Proofpoint-ORIG-GUID: wIPu1s4iLu0XqnEP6mxUL1vxAFPRemsU
X-Proofpoint-GUID: wIPu1s4iLu0XqnEP6mxUL1vxAFPRemsU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Aug 31, 2023, at 3:54 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> On Mon, 2023-08-28 at 09:13 +0000, Eric Dumazet wrote:
>> We should not call trace_handshake_cmd_done_err() if socket lookup has f=
ailed.
>=20
> I think Chuck would like to have a tracepoint for all the possible
> handshake_nl_done_doit() failures, but guess that could be added later
> on net-next, possibly refactoring the arguments list (e.g. adding an
> explicit fd arg, and passing explicitly a NULL sk).

Agree. A separate trace point that requires fewer arguments
can be added later for this case. But I don't feel like the
omission here is a show stopper.


>> Also we should call trace_handshake_cmd_done_err() before releasing the =
file,
>> otherwise dereferencing sock->sk can return garbage.
>>=20
>> This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local =
variable")
>=20
> I can be low on coffee, but
>=20
> struct handshake_req *req =3D NULL;
>=20
> is still there after this patch ?!?
>=20
> Cheers,
>=20
> Paolo
>=20

--
Chuck Lever



