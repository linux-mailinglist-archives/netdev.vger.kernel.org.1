Return-Path: <netdev+bounces-19033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411C37596AD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7CD1C20FD1
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CBE16411;
	Wed, 19 Jul 2023 13:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B716405
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:25:11 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195EFD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:25:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JCwqiQ026403;
	Wed, 19 Jul 2023 13:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rxpDeIq5og+RrrrObHfD+Eoqf+z3Ng64Wug7h0g4L5I=;
 b=g2bbYqTI0Zr1GlrWV6tw6GBAEeYpuWZZqAEvNS0gyqboG8NRumVwfGY+voz82k8ptHUd
 15GwzVPFDKJKRragDcU1riQcmTgV8SM90nJD4n9miACnkrbcdc94r4vLV3IVpuf1T+Cl
 9X3r6Z49MueVJhvQgNsmeQgNv7S0beMhrwXIdetrpB+zkUL93DG+sVD07SLLQW9OhpiA
 8Lkb0tIepXU8iMVKneN5NXyOLWhsD1LjPffn7aIIgxLUJilS2eLt9cuESxiOuW2/oRz0
 LuOkZ/hv+6fXUjf/RCmCIx6ScFl16ZszbHxlrzBOcqVoGzIZsNf/fN7AnsAOmi7lO5TR 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a7gnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 13:24:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JBOQ3q000934;
	Wed, 19 Jul 2023 13:24:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6uf7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 13:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/pBDE3HBqYjVAqwJIyv8NtHvtB2v8yM8Nv3C1jFkUtkeFvFrNIjqgoi9z9psjPIXIsMWUUd5lWM0I+la8ClA0m9pMos25cIZFDrMhHiYy18ysmQS6ZqN0MxfvpdaufFBODMiaRfA1neso+J1WixiEXnSP20Txea67lJL9mocef4o0cQWUuR9YYoR/i4Tk+gi+vDwGPmBI4JlXvU7/AbRXNfrzLyoqAlwCvcHd6vWUTzfhEhpO0tOdyyOx578mAuuqZ8mov7ACwkizerUKk5fFbRwf+hD47YWYuzoCqihFQL4cT+r5boc0Wftk8vGBhoccmWmI0IlyuU3A7E+oHpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxpDeIq5og+RrrrObHfD+Eoqf+z3Ng64Wug7h0g4L5I=;
 b=G5UlVOYwnIiw6CHvMDJJ4y0D54x8yeSatdSPgI8yjhlcBhH/JNX9cqYjRggR23940Sg3a3lknSPJihhwkop6ZptrldZIO/xFxVd4dH9cffwxwIob34SkSvzxyWlrYxVSD0VRbz82WTriQMD8vhwZo8B1fMsStJ1OeIyiksDNXfSLkt/wm7hzP+qcj4BsPQX6icH4Ai6niOTYYV0rdNx291LTX+g8H9J4wSgtNvrEgMFwCnShagchZ1XOgHlq6+f9PwmasTFTFHY69skhYaj/ZG8kA1kyCsB9tg29bimZeVCStbMNEgm4+FkA9zPuI7U8gpkSeGKVN/g7P3NImjcstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxpDeIq5og+RrrrObHfD+Eoqf+z3Ng64Wug7h0g4L5I=;
 b=fpqfvmNWtUi31T3dsXh1/WGIbsGlv/1mszofl5B5/JorLPlR0PCC6o8KJxOMH3L7lXMM3ZPcU5TSy7TxHqo4SJ29MX8evsbrbxE86u6retYlVz1S8ekQuqylBt7LC+a29EPNTG3ao9es9ANeGCyzNl+YSWSfbTh3K7ONMfXvPG4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 13:24:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:24:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev"
	<kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH net-next v1 3/7] net/handshake: Add API for sending TLS
 Closure alerts
Thread-Topic: [PATCH net-next v1 3/7] net/handshake: Add API for sending TLS
 Closure alerts
Thread-Index: Adm6RF5V4azh2F7WKEiRxsMxNg8GAA==
Date: Wed, 19 Jul 2023 13:24:38 +0000
Message-ID: <33AFECBC-E0A8-4C87-9625-B0DA22F8D617@oracle.com>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970680139.5330.16891764300979182957.stgit@oracle-102.nfsv4bat.org>
 <6dc3e2ec-fa9d-32c5-1d44-023d366d329e@suse.de>
In-Reply-To: <6dc3e2ec-fa9d-32c5-1d44-023d366d329e@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4133:EE_
x-ms-office365-filtering-correlation-id: 10e8534f-5d52-499c-0174-08db885b80d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZATN5E7dmdBuIKAuZE+YHpNaIydZOv9jEsLlG4ufGlbEVlpIEextV/onTBTB4HsF/Dns8cT+idQFaatP86s+76vn8oRqRcHpQziHflfX/48ofmlzdraJUGA31LHt+A7er7i6E5io/oA6eInsnIgbXY9DkZsHg1lEJlbfkRESgVpko8vPpMj6WmDkulwTRfK/cqFDOIYQ0sK9isHXqrpKtWdTKRugttSEYyBVPhBIvfLV8ikNKUPpaz2YoThFS5xYBO1T8t3zAyxOJ8o8yT6j7sO56tMEYwhSWXdJmoVd/WPgCJ8V7iiSnFym1s6BdvELe2hLL0CWJDoV/7frEtQ8ucGdur4o61P9zBI5uwGGlZJRvvCnwuLQakZGF1loZqlMZxhJZ7ty46nGdf1PCYmxHuXEpqDuwhKOXtBi2Wi6vMyA2cBWs4gW0aoKekHUPgCF871j6GpBP9cNDTNM1KXsY0cf1PH/UvBswd5ztHha1IgZBzrSkaKFd3AK5HhzukIsXbWd1F6GejVrZkP3DcwUgL4Lg2AwjXr6Io4zxncvFKkSAqwc3Y1rbECUcpzRR5gwupabaYUiqE7sZiel64cksyGbC8PR9oxketRP8qsNlmpUoh1tz1c3TL9RTtTqdZt0H4sw6XID4ZVgZuEh6mUQCA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(71200400001)(66946007)(54906003)(6486002)(41300700001)(478600001)(8676002)(8936002)(5660300002)(76116006)(66476007)(64756008)(66556008)(6512007)(4326008)(91956017)(2616005)(66446008)(316002)(6916009)(122000001)(83380400001)(186003)(26005)(53546011)(6506007)(38100700002)(86362001)(36756003)(38070700005)(33656002)(15650500001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ilRcPMxXFF8/JnZFc7UQ9zX/4vtGvy03J+fzAeN/sYliu96+W0qBUbC5EJ1E?=
 =?us-ascii?Q?fBdEgCtn5/shf2t/sWe4rl0IDyhQ+QqLTeu0NWOzXCsy3SHla8eosLUHmgcc?=
 =?us-ascii?Q?P4ZxWEhIqWjHrb06MEia0ckC7MZnb6mC04u3LqG1RdtO9mqLVr/JAMAR2t3+?=
 =?us-ascii?Q?jhg08Etx4eM2Cq68jWZTYP0EZlSPCwtL3qz+c9TjrROLQxyeRCZcjM2GT3uc?=
 =?us-ascii?Q?kh4h9gcKmF3XprhTzrenN9UFQqA99W5PfO43Uq1KtV9STjRudco35jrGaa/n?=
 =?us-ascii?Q?YQG/IqYvW/5oB/X+xJa3jmGVTZzr6eGUfYrSZlObF/uYqB+aKPx+JWgFH2DJ?=
 =?us-ascii?Q?Ve00ds+IjYISVPl8ZYmrZdoxY1gRIbv7K2mmnKuqinExGUiGkEZcA+7t1Faj?=
 =?us-ascii?Q?enOYg2C00OKcg0pCXmW15NdymGRilh2kBXyVxru7C/8w++9qBAYNmnkNd2JX?=
 =?us-ascii?Q?FTuOjID+fLU/Z64BfJhUdLdUvKQPKeLwMm5+WZsu5RiHkkRMSEtOZf3EXEPD?=
 =?us-ascii?Q?5Vo/MnIVj18eocDJZ7qSmZcqVxLl9KTq7fahr+myZ55RBa0FMRfou/I+Sy2o?=
 =?us-ascii?Q?0xO4qUQiP69t8V+JUYsVyyITclxA8+8U05Ifk/sZzqAUe9Sve+lkadRqPQTE?=
 =?us-ascii?Q?xPNc061umWd+rtsdLNDKnIQfO+6FO4jzxb+/4ezKIxl9yhGyvEwHRx7CftqZ?=
 =?us-ascii?Q?T5y/vznpikDe/J+fsgOFJIlb+22Kx8wLFmNwZZTzwOo+7qxq30232Q6WPE9j?=
 =?us-ascii?Q?aX0UCgSsB9G8T2lCMLKyfPYJDPJX3C9UdxB/t6AifSjizbQKMRiRYSqqeCFs?=
 =?us-ascii?Q?kcnuLRyvkJq77EWaS1Cb9lrZ8TAaetregTJXBLiF3bs5jPH03OOgljC/zXTr?=
 =?us-ascii?Q?xZatyxNqwRWypYwLPZKW55trhQ4nF/36C/2xrjKRR0w8TSX3FafyzQ0CzgKo?=
 =?us-ascii?Q?Yr5yn2xtqIebPMcKlFzkn7JF7/nwuxLu1h1m63X1OXAa9AU0XrZWJ/ofolb2?=
 =?us-ascii?Q?qzWRLnIUEM0lKxVeM3CIyXQD7Qv7ixtsKqnAqYDpNLqLfWXdeDbJVDwqaG7L?=
 =?us-ascii?Q?T5xI5YrAP/BVABKGlZTEPvm6/+tyqNdX3RjEDMCanpoyGdhoDT39k1fdmPvn?=
 =?us-ascii?Q?BilTnexKACUtdVZz2t1OTzuewavgLUKTSgc5uPkd2ddX1EO6OtwhU77D0gRf?=
 =?us-ascii?Q?+ETZOXdJragaLQCBroxP6z8auyKkJOHqWrn2ptSViksiw5N3OJrUz5aB8zYj?=
 =?us-ascii?Q?kJBNIWtXvtI7RZ8TbbTJARCstt6Z1X5IxBp6S1cAVZ12HvylD0UyUy+r5DsS?=
 =?us-ascii?Q?rgpkQ4SRRZMERHR1hYx0d3Xq9kVN7ariiYLCni4gUTPa805ozm/qxRXP2iII?=
 =?us-ascii?Q?mDxTK1v+Jjx5OfpZOndobiYgzk6NSc62om5vRiotRlgEQT0XHOjlPTHP1INX?=
 =?us-ascii?Q?YJYEHsOuOdW8ZKqsX+8crQj3Lp7l4pdPVcSFAuOVJS4vPvEmOeExNqI2XOKf?=
 =?us-ascii?Q?gI0kLB2RJ00Cl9IN8ajglK7ZrvUgPIDaft8iSYS44mtTl5UwWpJuFknme8ft?=
 =?us-ascii?Q?TQ/i0uVaOXLFPZGaj+NHsiyadKtFghkjXdQpqcOjJxp0RiTZw8GVBjFzco92?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85327EFCEBE2504B959E61DB04CC049B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?nwBYXLlCKQZKV2QHhIOvzyumWS74PRzbz7qQDA0hW9w/dMD8h9Ep2znVFkbI?=
 =?us-ascii?Q?jiNMrKLSNCn65CdZYpvaOuDMFgC5GAMDhv6RCh9zf4YM+CcBrT0ZugndOAju?=
 =?us-ascii?Q?mVaxTKyTVw79qX2CTfJbj+FNwfcDpjudYf79z8cXvhpPXk78lldP0SzSYURQ?=
 =?us-ascii?Q?Zdk3YcH0ahl6j5jMDz9eQ971FqiX/dlWYaCOLCsMPMmLaQdGJUBhWyei3eX8?=
 =?us-ascii?Q?yYVOjX0GamGRleCQkdNkVTv1GtGs8Bb8wb0FXpJGsiJWfPyn8CYYLGssFeQD?=
 =?us-ascii?Q?04flM+Na1a1nXWEsLU+0AJIbah3szeSUdyW6+K/aa1ak/qv5MjdrQJYbcVJI?=
 =?us-ascii?Q?4Yio7vaRfM/ghYb3iKQysuR5kbR1Su7gImBrkKb4Br0gizGxn9rObmzJjv2q?=
 =?us-ascii?Q?GNa2Z86flKRvwgGY4TlMFVOFUBc7qlAQiAQlPDMC/z3u5p77yDd6pRIM3TFs?=
 =?us-ascii?Q?EzicHswMf+uLQfIJ8Z/wvntEYuq7e976z9DBtXaKQ3GO8P8CG1XULejDwSAs?=
 =?us-ascii?Q?fiqPbS6sAIpfzdTkzDBCAKjN+3+u/ys5ObGJrhZk5fjHsKCRTRoJnPQebEj7?=
 =?us-ascii?Q?bQzKKmiwEy344v6R/pjRgFdqrQJGcaWDtSr36lwjZB8SJb17ybWHs3ZkrjQL?=
 =?us-ascii?Q?JVvAGF5Pc65BvLIYtVwN0tBoTkPgxTVsoYbxnLaqqGRW/xoVB3jnCQ/NOqHR?=
 =?us-ascii?Q?sc6o4hweHzt3KxQe/S9xx8+7HK1+yXcUC3u+NN+GKYFErPga8XooYTI5fxvY?=
 =?us-ascii?Q?dLBwxpUuAhZUmBaag0yXeBGpjy3lms5e8QOL8tsPO3QbXEC9LhUZ7+DPkxQU?=
 =?us-ascii?Q?kRUPyv7/rRdlr+EvoM4wtaoErN3xLU7LdgIVbnQUJI0NEm/mstjIDR9KYUQ8?=
 =?us-ascii?Q?oNOK3EpFJ06UMkykNzucD3o9G8RBW10sK7Jz+kYN6dQxzO8xB0GzcGYYM5WS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e8534f-5d52-499c-0174-08db885b80d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:24:38.7439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs8kpjxAo5654NRcjw9kPK3yyuR2IHVo3idzmNoZCL47qeeq+srjAeIe4lcHdVSWiMmVpHlC1QaU8Aw1YMCgnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190120
X-Proofpoint-GUID: tEH_tMyGjVuRo_q6IpC07z9VD1uGzc7V
X-Proofpoint-ORIG-GUID: tEH_tMyGjVuRo_q6IpC07z9VD1uGzc7V
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Jul 19, 2023, at 3:47 AM, Hannes Reinecke <hare@suse.de> wrote:
>=20
> On 7/18/23 21:00, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> This helper sends an alert only if a TLS session was established.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/net/handshake.h   |    1 +
>>  net/handshake/Makefile    |    2 +
>>  net/handshake/alert.c     |   62 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  net/handshake/handshake.h |    4 +++
>>  net/handshake/tlshd.c     |   23 +++++++++++++++++
>>  5 files changed, 91 insertions(+), 1 deletion(-)
>>  create mode 100644 net/handshake/alert.c
>> diff --git a/include/net/handshake.h b/include/net/handshake.h
>> index 2e26e436e85f..bb88dfa6e3c9 100644
>> --- a/include/net/handshake.h
>> +++ b/include/net/handshake.h
>> @@ -40,5 +40,6 @@ int tls_server_hello_x509(const struct tls_handshake_a=
rgs *args, gfp_t flags);
>>  int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t f=
lags);
>>    bool tls_handshake_cancel(struct sock *sk);
>> +void tls_handshake_close(struct socket *sock);
>>    #endif /* _NET_HANDSHAKE_H */
>> diff --git a/net/handshake/Makefile b/net/handshake/Makefile
>> index 247d73c6ff6e..ef4d9a2112bd 100644
>> --- a/net/handshake/Makefile
>> +++ b/net/handshake/Makefile
>> @@ -8,6 +8,6 @@
>>  #
>>    obj-y +=3D handshake.o
>> -handshake-y :=3D genl.o netlink.o request.o tlshd.o trace.o
>> +handshake-y :=3D alert.o genl.o netlink.o request.o tlshd.o trace.o
>>    obj-$(CONFIG_NET_HANDSHAKE_KUNIT_TEST) +=3D handshake-test.o
>> diff --git a/net/handshake/alert.c b/net/handshake/alert.c
>> new file mode 100644
>> index 000000000000..999d3ffaf3e3
>> --- /dev/null
>> +++ b/net/handshake/alert.c
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Handle the TLS Alert protocol
>> + *
>> + * Author: Chuck Lever <chuck.lever@oracle.com>
>> + *
>> + * Copyright (c) 2023, Oracle and/or its affiliates.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/socket.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/inet.h>
>> +
>> +#include <net/sock.h>
>> +#include <net/handshake.h>
>> +#include <net/genetlink.h>
>> +#include <net/tls.h>
>> +#include <net/tls_prot.h>
>> +
>> +#include "handshake.h"
>> +
>> +/**
>> + * tls_alert_send - send a TLS Alert on a kTLS socket
>> + * @sock: open kTLS socket to send on
>> + * @level: TLS Alert level
>> + * @description: TLS Alert description
>> + *
>> + * Returns zero on success or a negative errno.
>> + */
>> +int tls_alert_send(struct socket *sock, u8 level, u8 description)
>> +{
>> + u8 record_type =3D TLS_RECORD_TYPE_ALERT;
>> + u8 buf[CMSG_SPACE(sizeof(record_type))];
>> + struct msghdr msg =3D { 0 };
>> + struct cmsghdr *cmsg;
>> + struct kvec iov;
>> + u8 alert[2];
>> + int ret;
>> +
>> + alert[0] =3D level;
>> + alert[1] =3D description;
>> + iov.iov_base =3D alert;
>> + iov.iov_len =3D sizeof(alert);
>> +
>> + memset(buf, 0, sizeof(buf));
>> + msg.msg_control =3D buf;
>> + msg.msg_controllen =3D sizeof(buf);
>> + msg.msg_flags =3D MSG_DONTWAIT;
>> +
>> + cmsg =3D CMSG_FIRSTHDR(&msg);
>> + cmsg->cmsg_level =3D SOL_TLS;
>> + cmsg->cmsg_type =3D TLS_SET_RECORD_TYPE;
>> + cmsg->cmsg_len =3D CMSG_LEN(sizeof(record_type));
>> + memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
>> +
>> + iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, iov.iov_len);
>> + ret =3D sock_sendmsg(sock, &msg);
>> + return ret < 0 ? ret : 0;
>> +}
>> diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
>> index 4dac965c99df..af1633d5ad73 100644
>> --- a/net/handshake/handshake.h
>> +++ b/net/handshake/handshake.h
>> @@ -41,6 +41,7 @@ struct handshake_req {
>>    enum hr_flags_bits {
>>   HANDSHAKE_F_REQ_COMPLETED,
>> + HANDSHAKE_F_REQ_SESSION,
>>  };
>>    /* Invariants for all handshake requests for one transport layer
>> @@ -63,6 +64,9 @@ enum hp_flags_bits {
>>   HANDSHAKE_F_PROTO_NOTIFY,
>>  };
>>  +/* alert.c */
>> +int tls_alert_send(struct socket *sock, u8 level, u8 description);
>> +
>>  /* netlink.c */
>>  int handshake_genl_notify(struct net *net, const struct handshake_proto=
 *proto,
>>    gfp_t flags);
>> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
>> index b735f5cced2f..aad3c5b06b03 100644
>> --- a/net/handshake/tlshd.c
>> +++ b/net/handshake/tlshd.c
>> @@ -18,6 +18,7 @@
>>  #include <net/sock.h>
>>  #include <net/handshake.h>
>>  #include <net/genetlink.h>
>> +#include <net/tls_prot.h>
>>    #include <uapi/linux/keyctl.h>
>>  #include <uapi/linux/handshake.h>
>> @@ -100,6 +101,9 @@ static void tls_handshake_done(struct handshake_req =
*req,
>>   if (info)
>>   tls_handshake_remote_peerids(treq, info);
>>  + if (!status)
>> + set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
>> +
>>   treq->th_consumer_done(treq->th_consumer_data, -status,
>>         treq->th_peerid[0]);
>>  }
>> @@ -424,3 +428,22 @@ bool tls_handshake_cancel(struct sock *sk)
>>   return handshake_req_cancel(sk);
>>  }
>>  EXPORT_SYMBOL(tls_handshake_cancel);
>> +
>> +/**
>> + * tls_handshake_close - send a Closure alert
>> + * @sock: an open socket
>> + *
>> + */
>> +void tls_handshake_close(struct socket *sock)
>> +{
>> + struct handshake_req *req;
>> +
>> + req =3D handshake_req_hash_lookup(sock->sk);
>> + if (!req)
>> + return;
>> + if (!test_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags))
>> + return;
>> + tls_alert_send(sock, TLS_ALERT_LEVEL_WARNING,
>> +       TLS_ALERT_DESC_CLOSE_NOTIFY);
>> +}
>> +EXPORT_SYMBOL(tls_handshake_close);
> Why do we need to check for the 'REQ_SESSION' flag?
> Isn't the hash_lookup sufficient here?

REQ_SESSION indicates that a TLS session was established
successfully.

The hash will contain a handshake context starting before the
tlshd upcall, and will continue to exist even if the handshake
attempt failed. Those are both times when a Close alert should
not be sent.


> And it it safe to just do a 'test_bit' here?
> Wouldn't it be better to do
>=20
> if (test_and_clear_bit()) tls_alert_send()
>=20
> Hmm?

Yes, that makes sense.


--
Chuck Lever



