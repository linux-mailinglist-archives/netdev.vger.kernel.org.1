Return-Path: <netdev+bounces-21921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C9765485
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D03A282339
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE6168DE;
	Thu, 27 Jul 2023 13:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44901FBEB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:06:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDEA2118
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:06:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0s929006048;
	Thu, 27 Jul 2023 13:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=e1YZt6RDGArTZIJW+NzaSDDW3pfoNH4rQ14NOFV8ggQ=;
 b=Xg7fP8xTxBQkauNzSM0HgAmpw9fs5P9BegRpUwUsYPVM+M2aXcDrQ6RQHaWETaoqnJI2
 69/cLVg8b8xPNuXr9gSKuVYSU/0ReeX61nXsUSRnTdhrwIXtzSmZyC4x9Ax1BwrFA2m1
 fptg5ebLulMCI93Njjoa5IYILqLW4IVcfw8V50d/cryDmq+ZPCd+DuLIQowmhNM33Lsr
 cUgwtuh2uzQPvhS61eowirOvh+7bSn0BiHhOxIjNhFqD8gSiRCPc/OeLvxH0xoc/x5No
 4x4a48rZRz7kygzb2t1rbJSgPkCnK1E/NfOHYVMkZ0mIHczq8vR9MHVEqjxkEVdQMji3 nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuskw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 13:05:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBePwR023017;
	Thu, 27 Jul 2023 13:05:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j7kvua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 13:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3hDh9q6/9YpvhxiuBS1PHPm7Mb6YyUAPnBuWzWc6Rx3ZzGbgLWeZAeQhcv0Aczi78Zg44Y/YvVvO9WsdPpcunn6WbrGvnOQApJU7KOVzGNg6eSk1chpshs3vRf86R7k86cp5ayoxiEgjHlpGiysEROqrGwkSYho4cDRS4xtMnx8Z3AQhDxB/KlUWmvgBsTBILHKM4xxBY3w3kYKWxx84fcBERxBSX5vqywT56h0DetnUFAupDWxHMhkvybepBAxFDds91V4LUuFyWEsedBtMa+MsdgAaLNv4Hg+mixvUWXWPvpL8yxl7+Nloz62YTFwGzN10bwoH9WorFN6g79H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1YZt6RDGArTZIJW+NzaSDDW3pfoNH4rQ14NOFV8ggQ=;
 b=RnUOExwVQcOImICJahX5KTTWwDsyszkCkouNGB640uuM9OEj4IgvLPwTQFs5L7RyO3cfLnzdIk2LnY86Snh8Wqn68OsnVvlUqZGiPKM5oVFPiTcNZ+CLZkrZ/hx9fnMdtekTatqu95RGfNzsnSNK2wCmRv8UNwz6UbFANXZYqj3gucWswK/3cd5THzJ4yLjKW1v6dWhqxXQqkT35oun+Qw91V+z4O77pPMrXH8X1FuepbcQoCVCY9Wr7V0Kv95SQA9c+W0w+8jQQt9h8r8TX5cMf92Dw6b/RtckfPM7br1N4aWScbE596o1darN0Zt+136D7WMSQYLwL/m4Mykxjyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1YZt6RDGArTZIJW+NzaSDDW3pfoNH4rQ14NOFV8ggQ=;
 b=jcF97xjV8uTjrzYrHt/RM/F4OVvsH1iex9xL4w5qdUSbuQTcDdFp7KDWbkv7JfO9eSX1ObMAjGSc7SZwiLEdk52jWaEpZXSxbcLB0QEAyey/ZcLNOa7a1UkxZKmrqFc4quoTO5yK5MLy0D/OFG07QSZEBaGuUICeXQrc7t1jwmc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:05:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:05:50 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH net-next v2 1/7] net/tls: Move TLS protocol elements to a
 separate header
Thread-Topic: [PATCH net-next v2 1/7] net/tls: Move TLS protocol elements to a
 separate header
Thread-Index: AQHZvze47+c48cqw4EqDmZ58AQwhEK/NCVMAgACOUoA=
Date: Thu, 27 Jul 2023 13:05:50 +0000
Message-ID: <E459C68E-59C1-422C-A0A4-49CA1E656802@oracle.com>
References: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
 <169031734129.15386.4192319236812962393.stgit@oracle-102.nfsv4bat.org>
 <20230726213616.25141508@kernel.org>
In-Reply-To: <20230726213616.25141508@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4242:EE_
x-ms-office365-filtering-correlation-id: 892601d6-0022-4fab-53df-08db8ea233cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eYwxFt2K5Zqpwj8q6+XlmDir95kV3AunpzwWb8SJ3XyIYEOoI5RKgXsVSjp3wBzb6o8jtnmi//FCm+UuKLFbWmld1DVRpXtSUBt7x9LQ9cyqYkSBf1vlkstM/yFYnE4heFkjOWQpanCGW2UUlgdcDIYgAMnjK8d6ajTrFsIOwTeccef1+M0iJjaI+syCOFpv/h63VjQSuT2QlXDvOY1ri9x8UB9mleofNiknslLXlg7jKr3USM7tbyVXOnqHOjsHsH9KOHR8t2JDjedbD13akWQNuPfjCE27gIIf/zwO5iqKrsT8tY+O6/nN9GC9iayRCFLbJJLHjfw6S/IMbM5LKSlV6ahEvEvBnTqyzDNou2KQt9w5M0nuMONLSIzp6aGD1GSd2MmSA4xHV5i2G3icxTB/6MoHsrXB1wx6lo+nbNILpu1FZREokRlh0Ld3Lc4OC8wtyqyRIMVQ+XjRgGV2z/YhZULakcSx7hvTlYmeX3Y6PgZrUTr9PLqbGmHLdroviB7V+MBhntVVHy5uRb3P5KkY1Lc5erl7CDCgCd/PVRQZVo14FWXogC4UnT4SJqJbq2J/sY6H5YDwGeFp7IZVknKL4AoNH11PWhK+N+QPovfVo2QFOJbAF67+Ls18YD4rymE3e00Bi0QFZ+3/7JXWMA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(41300700001)(26005)(53546011)(71200400001)(478600001)(38100700002)(91956017)(6512007)(86362001)(6916009)(36756003)(4326008)(8936002)(8676002)(316002)(76116006)(66446008)(186003)(66476007)(66946007)(66556008)(33656002)(64756008)(6506007)(122000001)(5660300002)(2906002)(2616005)(54906003)(38070700005)(6486002)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2BlM4AoCz/sF8ZRup3wZllYry85a6MW6dblS/JxA7TNm4C7eX3OUkN8VLU5m?=
 =?us-ascii?Q?UfpRwxmR2pBgdG2if6yUnquP1A+whKTIURqEKo6mWhGYsxtYcX54pv8bNQ22?=
 =?us-ascii?Q?U/Jo8vfgBg5Buh+mNsIKJyrbpwzb0KqTUZuTucqCjrWN+zZ2L5ma+4j2oT6n?=
 =?us-ascii?Q?D8Peeq6bX5Lt2lu2eHYqTnlbNCLbInzeNo0PFuoXDs2AGB3S6PER/9LlxH4B?=
 =?us-ascii?Q?eSfCBBfimipGiFtl4CBWW0O6PUChvhiypf43b1MG8UfQ4Hicc2EHKKo/ezQq?=
 =?us-ascii?Q?omFz3tvLXikyVKVTGjDz1rwJswmx3CbP3FtOi609+/2QhDfxLLKfN5w3mvJT?=
 =?us-ascii?Q?0Vbfsoz2fq2z1eA80yc98UhbhIRq6MAn9vAYpW2Dbw9pg4P01BDdZ/601yaw?=
 =?us-ascii?Q?OT0Eg6bHmniWaYK1OepKzueHirjLJT+ptzkLCBsySYrVAgUA8MG+AKF6T0I1?=
 =?us-ascii?Q?s3etmVQKi6rdZSA98Y/iliG8MhPPbWD4t8quthfAkn+LSiK9MrM7SxMymII/?=
 =?us-ascii?Q?XmHKlHt3oX9+GfnAliXw940zHkmEz0B+jY2thYmW3TCvMPhKBs2vODL+K+Gv?=
 =?us-ascii?Q?vQQRkeIFAg5I2mEiFPxYGOrmdPcr+phbnmqcGIKqG9W2h6vSa79ZBF7zILrY?=
 =?us-ascii?Q?StIoPwULQYHTJ/0valAsjmkqU/Hw+ytdXwmEtbr/833m9wli/urohezNRYyF?=
 =?us-ascii?Q?p6inlSwdPE5HuRlGbKyxI8yQZ68OFBfZdGNeWgsyt2agW+zDGSazJNei865E?=
 =?us-ascii?Q?b/zMn3/4AeiTqacUijrpDprEjx9+7j9FnsIzvGXlfmWTmFMw7JbdvzbKIxZw?=
 =?us-ascii?Q?V2iNQggrFV6+CiZjVktUxdcyPKXBqvkOo5ZhcCkmKrfXlHco8b9g3NOCbnfe?=
 =?us-ascii?Q?HFRNMX5mu/DHLCiQVq8odfnjxF83FifCacSy21/n8rs4f/NmrjxefHYYdeTw?=
 =?us-ascii?Q?l+SHjsxI/2/iERW0kE+tlKZjum22lBHli0LJs7KV9VzFkjaSnT5ytH76jCuM?=
 =?us-ascii?Q?hSC4QYWOvXnV+cx/dx+ldOb0FTv6A/mmpzOMngMMHNTiP5LoM69oIDmeYQUh?=
 =?us-ascii?Q?3FFkWPodGCtI8KKWfQWq9zadc0z4IidUFdyMJb7uhvNwGcCedcnq9cqxr4PM?=
 =?us-ascii?Q?QzkhVLvfFa3EJ0oOmJpONzDF4/DJFoLezWKP5FAMGn+Yy6CBQv4sfNuPIeUP?=
 =?us-ascii?Q?CFEBizjYGb5RDR0TALxQPVm/U8gf+f/vu1r89CIuOGtEPsI2QdwvezVcjmXg?=
 =?us-ascii?Q?vdl44NtYF6xNg/6siTLaPCtC5zFZgqneK1f3ta2s3yp+c6OhE/JumSFzNw1R?=
 =?us-ascii?Q?7FHfkzD3mV2oFinn/Cynqm7LPEcqfSoSp4HXVtikdjylOMj8PBkUlxVZNbVB?=
 =?us-ascii?Q?+r3VpL8YjdwtfkwiGxpsnMtXYBp1kshHlbBeDbgSqvvZkwCZWznx24m9Idij?=
 =?us-ascii?Q?T342lJnmTEeHoF4G3kViQ4cG2C0AFmpcogGwrERhBK971GwFmrr8RYvDTCzM?=
 =?us-ascii?Q?Fel1eouSdTTemu3RCyFRuOqi2+Ildf/I2BnhL0uqz1xUZIOepHCAXzOWew9u?=
 =?us-ascii?Q?uRb4VdrpMFH2xmb7LEXHWuPiVbyiheoEdkTlirJ+eRfWqixiDib3X4YOr8I9?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6543EDFFC1C33745B8EE5E5A2A0B8344@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BNmCM0NAExKYRph1P54fUvVLVUEcb/jD99rY93l0KuDT1/GkKKbhxQ5laI/xF2KU6NdILAqwNwQVlmCziCruFvnmXOA0BOwTdh4nZp94OCJsdsNCDi0Aco3KDIxycYUngI4X2WPPBsRJm79E3CBjOCuF7HwANGAxd+GxGa/fF7KQdCLzV2PyWedKBgBmKIhPGbjukSNsDEWr3e+0TcH5SvtYyNQ9o+AyqTvRU14JCtMAF90KSF0q7z64MDP5lMxuKQ7ZJNMtBKEwtMyzUq1ZbjHldf68GQcsYm5zhAKb6N4KVcSy8zEI/xus+I6ItrEsyp8CBBIfDJGh7n31hG5nuGHwFQmgWVK8JEyQ3RbG0AwVg3mUPiA9iZVZzxkQOS8KK/SwDbQ3TTBEiSS74Kr2lvkuMb6ZC4gYtAJ1ryGRK2LFsrBSYe7f7nJHUYg984kVSJbfniw/y88zF6+CIgLAlwugf8tTcJd+4v8VRIahABbMDYa4krkNW0qj2vH3b+2qmrh6vl7ybQH8GQob3dLSqdhJQVWVSoyL/xmwDI5nIIb4/nMc9kZvncFGTZEveHHLF2jFdvZtZGxrslyhvQNJOTs2bhIgQo9vGobwiiRVgRqV4BfWAopY2u1UiT6lKdQK/SNW3pe6qVnV8hAAfGEHYwhozTBT79b0RPr0vsbxcmwGTWninI1D/IriBr3fUSe7PN8Uo8bnzdYuYKJce9oW5k+xEyhaJstr8ovPOP/1nvoqn1KjcFMWI4n3IBLuDswOT0619JSgW+85RotjSloWvig8kz5ll9iisfvuqt8Ze17KJDY05tSNK7Ek2KgalZn/X2cpp+go5T9LlGbeueQHLutofHvGAITGabXBHOUi8DbgUQtsrB4VVpC9H+f2If0NGLrg1sxfqJ2ovmdl9wIuGEZrEdrXtkph7z89DA/M8XQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892601d6-0022-4fab-53df-08db8ea233cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 13:05:50.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8ZlcG/NrL9k4HEYMIN1OosKHdC1HnYA8yJODWMk+/+XwJKxf2GYgRvZSk1MSaLnc57SDP+ivf1IEQrkdd2wyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270117
X-Proofpoint-ORIG-GUID: XojhHZLQXMcB_rV0jJFodAyuT4kw3aIu
X-Proofpoint-GUID: XojhHZLQXMcB_rV0jJFodAyuT4kw3aIu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Jul 27, 2023, at 12:36 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 25 Jul 2023 16:35:51 -0400 Chuck Lever wrote:
>> --- a/include/net/tls.h
>> +++ b/include/net/tls.h
>> @@ -45,6 +45,7 @@
>>=20
>> #include <net/net_namespace.h>
>> #include <net/tcp.h>
>> +#include <net/tls_prot.h>
>=20
> I'd be tempted to push this only to places that need it:
>=20
> net/tls/tls.h
> net/sunrpc/svcsock.c
> net/sunrpc/xprtsock.c
> drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
>=20
> to make rebuilds smaller. Bunch of ethernet drivers will get rebuilt
> every time we touch this header, and they don't care about the proto
> details.

That's sensible -- actually that's the whole point of this patch.

I will respin.


> But I'm probably overly sensitive to build times so up to you.

--
Chuck Lever



