Return-Path: <netdev+bounces-34130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D67A23B7
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA51C20C55
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732B111A4;
	Fri, 15 Sep 2023 16:42:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE110A2C
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:42:07 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758E199
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:42:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFhw5c030589;
	Fri, 15 Sep 2023 16:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ec+vlLs3c4ZYzmB02HQiKswOZwCAuzPeLJ03IIQIOhE=;
 b=CPQgYfSzkx6QFiL/MTwG4nP0PXG5zj7Rwe/FoQ99mz+8FsMag5Om+xpXrlq3zmRf1OlC
 g3Jk9X84sLvXxmGcFLXQjTa56zYbWL3LZJhN8zaClgfKWEJ1NZKQaPfl+FHSZVox3ugs
 Qb3w6ZaFjFcCuQwVpI/Ngy6cqX+YPZ7mq60S44oYgvakMkBi13dh6Ujx5z4blyJ5iW+0
 N//yR5UbHK5DP70CEBLwcr7duYm5ZkzHNbKgj+DIypT/4b6/CLK0R563rSsDSDUjMUUO
 vtqOe3c2ZKwE1IZYjDJzhqbXS6Jxi9/aOanbh/oq14FqPrNlJl5iUI3KW1pJrpFdw3NU ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hg6fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Sep 2023 16:42:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FF5Pb3036270;
	Fri, 15 Sep 2023 16:42:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gkg15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Sep 2023 16:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igYgaRkoHR15YmAW1gmisCw5w2eK/aMa87Y8pJZ3yBqYxXqDzCb+SwfpeMZ7y7zFsShDdL4RPQ5snfLAi9++Tn8vDrQ2N8aCJDbpxSYQ8CsFnGCoJzl7QF9OstK5xaRB5zpgwUK4U80uZs50mK7Iw5KYn24+snTUE9MJGdxp2Ptn3FbkfSvzobFZEO/VkNF7reKbSevBTh+90Q8AExPm3d9kc5HSY9x1DahW+maU6JsWSPG7/sKHUqyz7Vx+tRQ6upfhHM715nVfqzoTyTmKpalri9Pf0MDy61eGxVI5SlZW4ktdpAjYefiRlXw9JVKqp49rbVa3YMfJfenN1VEC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec+vlLs3c4ZYzmB02HQiKswOZwCAuzPeLJ03IIQIOhE=;
 b=Q6LpRhQ3wXf1EN1TsEs635LwSXWuNeZRwJf1j8Yh7fyniQm6gRPeGG3wGgxaHjmGdPryBX4aQNM7t4m5Di6r/XTTTrcTON/komZjpB2eiLURU4Bpvym/uu8ivukGpXZpC0rK+3BnvzgQyDugyZ9/qyqUOOulRtETHEcrNXW7UFEwd2Q3xdWZ5jtH0Ymks/4OhBo+sRqHvwX/Dz1B9pn8ZEhGvFbTe8KjQZ+f4nOAi2/NhWmIHZ6HoSntHX32Jxj7WMuwJQrj773tm0jNF25Hwlk7at87y5hhNFwBXh2jcTiqyiMWD5i9cQMnSxcSQ492cFyfTfnTlORavSeaXLMjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec+vlLs3c4ZYzmB02HQiKswOZwCAuzPeLJ03IIQIOhE=;
 b=iwSiIWvPhIjqfGfc7KTFWofgfP9ny+0+IGBh/VMOxxHqcm8kXxebwX52DtChEacVNCaXSzXGbJPxPQz6KrAHWIyTXT9p5trL7KptKULwVEzsp0l7KgBR4ERFkf7QmMqchwzIhsiyp+xSng42TGs15KBR7WhOyWktFNTx/8wsFqk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:41:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:41:59 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: uapi-header: doesn't update header include guard macros
Thread-Topic: uapi-header: doesn't update header include guard macros
Thread-Index: AQHZ5/OMpieAgjGxGk6VTQ1olsSPtQ==
Date: Fri, 15 Sep 2023 16:41:59 +0000
Message-ID: <5AD3137D-F5F9-42E7-984C-4C82D2DB3C65@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4404:EE_
x-ms-office365-filtering-correlation-id: 7ba073b3-39b7-40b6-19f6-08dbb60aae90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dW+UYm8kKZyZTHDdfMUzhLu4I8IveQtSIAprrTaqq/Uu7NpVEYWZxtNk080+tte36o46rhkx3V9MQ9u3slOhyKbyT0D0MWnxo1HN/ZU+lBXQtYeLcyl1ZYIjvkEVggDKx+73y4lt0OTpg/Cci8q1UoEt/pm+ReiuFud/52wN9CHhnRquFBshna5JVkJcckN0PwhfxwQgCWe11IWqrDYmEfRsyUG3m5KubMthAIN2bb4U42Q9xZw2DmWuaSQu2VrslALoj86EHDLdA8wdModlNHU0st+tBZvKGrm2H/jI2/5nsxSMD9Q8t+C20fPBmy32r+WptQf4gZWwLydBdkaoBBx72EWrJYbzbU4hzHppA5eTOWcTOjEjVZEnUiJI5W8GJBOcVMOJm2d5Xj+SlCLQf6xw9Qg+I77NgIHgpK1jXKE/ZPh54BjfS+Lrc+28U3pdobfG9XEkwGJrZ0iTQhT41nmPLHDjPVejzqjOOqGCzFhZmrKa61QyarxROEQjpQI8Z9XgfAVuUliVSY8pOrvOZFnUiWMcr2nzkF5U33pW3CTvUkcRUZun2sRqzgflevax8Jkbljod56gQWDZPFOVxTMC/g+P5KYF6rsJ9HFaa7REs3zPzENeK/IW3iYu4wcDKXACaq/UrkOoXpZQGL/AFtQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(186009)(451199024)(1800799009)(71200400001)(6486002)(6506007)(6512007)(478600001)(26005)(2616005)(4744005)(2906002)(66946007)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(91956017)(5660300002)(4326008)(41300700001)(8676002)(6916009)(8936002)(36756003)(33656002)(38070700005)(86362001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U2fCKTPXSX5FyiStYKqyR1TUWFoMgVmreyABVCsOHSBjiBaTsympUUH6sRGq?=
 =?us-ascii?Q?XHW/1CgJRC8HBXk4L8I4EUaL+pR5SPJopVGRSihy2g3C/n/wwjJ44cgvHoNf?=
 =?us-ascii?Q?/VEl2tSA6vYCVjnWBj7lLJQiVXfHe/zaQC9VrZ0+zlf8HTTc1MaoZXHBxJB/?=
 =?us-ascii?Q?AVw2OWf8jUMbWgGqN7Ko3UvWkNWPF5n1aTa1Zg7Sa7hrv+Kuir64MoWwWfrh?=
 =?us-ascii?Q?Kkb5g/Bpp5yBA4nnu/EHgMu1qcQ0xyWe5qgwLf7ETgE7Q04jfaIGLT96VDws?=
 =?us-ascii?Q?GB7F3p0axN5UeOlNFMynauIscpB2oqbQgSti96PkH0/NPRWivDtNOLZzhGtY?=
 =?us-ascii?Q?jZhwl5LsBJ8d41vKkDiNfWf8KpCCIl7Y+ayeqTkOs7ymW2C9dgqQcTL7SFwL?=
 =?us-ascii?Q?wKXtFsSpMJYTkDeM7u4SAco2X1dOXWN0CxN5FYK0axJrYfh9UkxPJ83VbwKs?=
 =?us-ascii?Q?kDH5S/Jg/b47OXsrcGRXCHatGGW+XLW0olZDo10e9PmfozH9ZqF0AX2Y4Itx?=
 =?us-ascii?Q?ybOjdJ0l+ahtaheT4tuS2Uyy6qQFAhsNkAe6PWq/FOtUy1FIExP36ILuBRtN?=
 =?us-ascii?Q?tli2dZXJC5ieTKHthoJk2tYiQfQz7XaeyQMODuHD+1G3kW/6C9Q+q1i40kUq?=
 =?us-ascii?Q?EFznq/pJHkTZGBx6M++mfqRN8Eq5CYd0lVkw3gC2GqGJYGqmSxsBUha92b9q?=
 =?us-ascii?Q?9nk9YSTJsVDOLls6nB8reACaN/MD9FN8ZGhEydeWGAl5eY2HoMCCd2pHA570?=
 =?us-ascii?Q?+Eu+j13ehysBYkI5HglzzVo45bIZLishFiryffCueYkWqbHSRegYYSj20QCo?=
 =?us-ascii?Q?DQ9qqI/2hslLqtSQe5hPwc1Jcv2kWXgP6TmDVqXd8XnGxv/Y4VxKqYacyCY6?=
 =?us-ascii?Q?aiNjoT6azCRfgE41LXxPNVEmOoxKLFGoW11bBe7+pvWqWtOsizVgFQ0e/Gp6?=
 =?us-ascii?Q?XAyVfiwBSnoorVgG2ARuKprbE5xR699dPNpVMP2OJy8kM3xP9rLVER8Eta2k?=
 =?us-ascii?Q?Xyzz14zbYWW4ipNX2QA/PeF3Wfoz1a15swevSf9BC3RLo0OkNNflSfTzXq9+?=
 =?us-ascii?Q?E31ahazWlfCkVJfeq5QTJGlUKwXj4GHKfhFdN2YntXo8C6Dbt112P6GL2FhK?=
 =?us-ascii?Q?YF/IxP89BnqIXlPaB+LlgM3dUEsiPWESH3R/BpeycDI6GnKBjVeEMRgJCTgJ?=
 =?us-ascii?Q?Wrw6U1sLSICYwPSApBwj8sDVF89eQ5oFVS/m+WwSQ84sAmKcp1xryH+xkTis?=
 =?us-ascii?Q?toyn98y6XOits+I+4k2OALYVfrbbOXmrXi+JIquxcsb+rsFPuEnh0dLKRfHS?=
 =?us-ascii?Q?JBadD/ELUBLoKLAlTybgzK4Ar8Sm/ZWhVPejBTeIrcHPm4Ll+UZX4zBRwhrv?=
 =?us-ascii?Q?Zx2C2ETf7fEQpjTj8iN7v8M/drkrURVfrrUrj4KYjqaHb3RP9ztu/EmZgaTK?=
 =?us-ascii?Q?GILjssy2UHeT4UoENkJIowaxoQv2hrXi7rlylDczXHwUmAObYcdGvuslnCmG?=
 =?us-ascii?Q?pZABIY3JUC9HdKUIMy2ZkIIw6myTBUXynZelyrX+KSKAG2RfXu08Tt5RPNjA?=
 =?us-ascii?Q?K6B5SrHSaaGLsFQ9nBVmcGyWArPhwJZHgbUPKcwmKHdJAWiOyjGoPsg/q1ci?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F35FB9136CBEDB48BAA8AE7F77A74919@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IQa7tSiIGNui9mFImMektGpcyO2cFG8eI85ay3k+8WwwbaN1TmddlVJi4ng/P2T994Y03T4OIEVbjve4wnkwVoAAfjtEaqYU98ifnANnNd3nLeq28RJlZTgNZa8l/qjv+smJs4r3DbesYE7Pie+Z9jnucFKHUbUcvMfhyhisiVN1q7MqgZvIKRZxpjiRQJwKa7GZ/zIKv7ll4oWm8HZRNCl4zjDk2K94+TDhV0HNFNpXDBMcMbQL2yjNSwlcjEe5mpASltzr9UW5NDrFK+FVhg/6YD9hZG5R3wHhmRMM8Z1qRSmokST9x1HWu2xEw6GF6NaPODxLBBXTh50fK48vBmXmqbbcLh9DgorWv4psXdBiJHYkmOIJfSgBVMfc7lqHoA8sLXUG9PE1yzAVVBHbfGbnK+tQDfe501XxdTVqBIRCWuHDbMKrThsvOA1vlC+AnJB7YAMacmDelbOnqR8LNO98T/Qb/RvTD0lLjrlKwTm36aDq7Svd9Hn6FX9F6ZsQAjHkvU8QDYXeX80fulDnWr8+C3403+A2LCZR04o3i803y6i8DiTTahbn5dFoD6j8hQ6QDWAbuaitlQXY2j/tquIcQUSxJ4tdED4Lw17+JRBfhfrprIiPYoBGOmcCYWX+UoX6/3OFWFPujN0Y5CIKE6WygEmA3iS8e7Yy8o/bdTwyDKWQ2lYOSl+xKqqFGCseDPEKCoZsRnSTLjEjGbudIHthTmTaidubnWevhIZxfNv6OpbzxfQZ+5w3DWuL9h5GVoxfTH/TeTK3GOxecy9k//bhC4wV4C48gXt52sycXBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba073b3-39b7-40b6-19f6-08dbb60aae90
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 16:41:59.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzKHewG+EtaiPslaaZLvTt4ZSb69Rycvu3q7LdhDa48nJMVu1gR2CYMNysji5up+/XSUAkTvaQrb+a9VpUB6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_13,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=933 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150149
X-Proofpoint-ORIG-GUID: h3bjAeA3VD2Cv-K7tNG6xppjm00pUVMV
X-Proofpoint-GUID: h3bjAeA3VD2Cv-K7tNG6xppjm00pUVMV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub-

This is a minor nit, but I have

name: xxxx
uapi-header: linux/xxxx_netlink.h

in my yaml spec, and the actual uapi file is named

include/uapi/linux/xxxx_netlink.h

but the generated include guard macros in that header still say:

#ifndef _UAPI_LINUX_XXXX_H
#define _UAPI_LINUX_XXXX_H

....

#endif /* _UAPI_LINUX_XXXX_H */

They should use _UAPI_LINUX_XXXX_NETLINK_H instead to avoid
colliding with a human-written include/uapi/linux/xxxx.h.

--
Chuck Lever



