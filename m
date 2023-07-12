Return-Path: <netdev+bounces-17274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024A750FD8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B294281A20
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6013420F9A;
	Wed, 12 Jul 2023 17:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48220F88
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:42:03 +0000 (UTC)
X-Greylist: delayed 30933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 10:42:01 PDT
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2342CF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:42:01 -0700 (PDT)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C7PTGe015651;
	Wed, 12 Jul 2023 05:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=91k3hrheDte8BB6hhWuSDo0K5GqwW11fq6bFLwnSTJk=;
 b=E5zYy5kMAAH/EnymWzFbzHioa9Su/bhY4kX5nx2M3g3AGtLXpFdnU+mQs9wxP6Ia3Dc/
 epxn7uUkSwSBf0zvM4dppDvI4IkVht3P5E3nwRvrFGeJZxTFgZbzhrkCuA0Bv6TDRJOO
 d9g8WwEjFarDSnvgu7V8Ws7j7YulL7An6o2Ta24PEg6HZZksU0qsKdwqoX9mRGq9lc6T
 AwexdMivqqWysIawi59gxtv63d4XF6FEelYTkDO77hznOpnZ3jI79t20HjbAeNQ+HEnm
 5qa6+KyHK/SrxEJdi4QcG1iTd+eWZCeKz62Jog9qUUs7I7JavDrSEOL45u2UR2ZsoYQj KA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3rq0vu0q6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 05:06:26 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8mbUj010224;
	Wed, 12 Jul 2023 05:06:25 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3rqnap4jea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jul 2023 05:06:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFxmxeGIspmj9dj9kljBxCK6Kjyqj0scA/uE6OOFw7wZ8TGvN3ZOBqdBVjqQ5i+6EO3Qx1XE2tPYDmcZtBRpg2e2ordqsYz9GFL0/DUaVaY3zsJeq2jBiVllZXI/zoWuwsiReUbRhPHbpNuyYW9cVHQAE+IurtDrGVZxqEK0sVlPgBrHdOYWeaBKRuTbNsJbpJeRBesJsJGHWNwtI5xZaENrPFqH8nHQaw12E6KA70GRWAiaJOzeNd3lxC20h5kmsaBgmsaAhQRoI1YeLbBnCpllD1mcMPvnMhbAa9g1wfweIBMimFiaq1iF4brU3vo8ytticJ7emLJrpSpRvvgPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91k3hrheDte8BB6hhWuSDo0K5GqwW11fq6bFLwnSTJk=;
 b=GHIVNK+KHqjA010Zpc6OiJOaIm4umjYqryw3afxMRcKRL2rOS0hRB0iS/lGncvcienpZuJBEOzRqkg+6emMrl7IhFdlp9DNgclUe2eutVbclIVV4X4Y/W3UQQLDAQgwdil1CT7sCtVBVcgogCnk2EeCqPqe0alTIaObDM87l0IhxcwGyKfVwAMm+TGlngoY3gwB+Imf7GhXD6BhqaVIQF/B2nZ3ie9KlzgyBlvIq1bzRY9GmVIbia2+Qjns4VfEU4Gg7hKk6lneKCXSpnWmXjdK7ICFJTMGI9cZ8/6pWluEZ2PMddCTZ4VvApTLBqBTwNsvYcmjksdfvHFmwUuX6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BN0PR19MB5310.namprd19.prod.outlook.com (2603:10b6:408:155::10)
 by DM4PR19MB7953.namprd19.prod.outlook.com (2603:10b6:8:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 09:06:20 +0000
Received: from BN0PR19MB5310.namprd19.prod.outlook.com
 ([fe80::85a2:6f1a:9a9:1757]) by BN0PR19MB5310.namprd19.prod.outlook.com
 ([fe80::85a2:6f1a:9a9:1757%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:06:20 +0000
From: "Zekri, Ishay" <Ishay.Zekri@dell.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        "Panina, Alexandra"
	<Alexandra.Panina@dell.com>,
        "Barcinski, Bartosz"
	<Bartosz.Barcinski@dell.com>
Subject: MCVLAN device do not honor smaller mtu than physical device
Thread-Topic: MCVLAN device do not honor smaller mtu than physical device
Thread-Index: Adm0nnOW/GY+fujYQUOSxkfA6dMMTg==
Date: Wed, 12 Jul 2023 09:06:20 +0000
Message-ID: 
 <BN0PR19MB5310720D5344A0EBDFC66D9D9F36A@BN0PR19MB5310.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-07-12T09:06:18Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=17abe418-7014-4ce4-b822-be94cd487de9;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR19MB5310:EE_|DM4PR19MB7953:EE_
x-ms-office365-filtering-correlation-id: 14416c4e-5e34-491a-c8fa-08db82b7420f
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Rl3iqLbz89CvMgOEgBJ4bOdJOGe+ECF+sP/BTvEtJf5Q+LqpZXvWbNP5dXUAE9WQRleozzrmPy5J7M9REx8UyvB89V39zZP7/113fPSJh3/Dpw8AZVcK1J2a7iVQMJQQYwXmw5Q5vkcrOXiqjj7AhSa4W6AgMuPcULgt2j6c5DWvgVopdRYEsz2keLRUu3mAsoCVmUwV3ikoaQOPBTDV9CIqAOBq4+OgLvl4sygCnRZv3K5FDtxBQ1IiGxMBU3Z+2oMs3zCK/pM4FaaUcm8S1uqn4Ody0uYyPuuEyRTOOFbXKNfkwZWfh0dlQNNHhd+OE+NIk9lZX1VRJU8IzIpCS0Uerqjq7QhtW5BQ7iVeDfEZCDXbpf0nrSBaonyil/QGaSlSfoZ0LKsUUPKw8nAajQv/g55F5XehZMTcmI+ha7ZWSJ6sCiUYrTJaka2ICPysbZP1tX3ZZAE/Hj0eYYmGwHlGFey5wvZUNupm2iSOxnuLKLRndRvpObVLZVhEJzXPrtqLxQdaI2H0HFed6Y0j291ohLfEgMDe+bCe3IUDmd3ytKtgVj5XNjsVp+3lmyLoxT0JrASh46X7XnDKx9xOFNxiNya+cyt7qyGAPcs988M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR19MB5310.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(478600001)(8676002)(8936002)(5660300002)(186003)(52536014)(83380400001)(107886003)(41300700001)(33656002)(6506007)(26005)(86362001)(7696005)(71200400001)(966005)(316002)(786003)(9686003)(66446008)(2906002)(66556008)(64756008)(66946007)(82960400001)(6916009)(55016003)(76116006)(4326008)(66476007)(54906003)(4744005)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7PgaeH5cNWwAwz4AaYmWgQveDzk3JxPV52lwLy70BELmlztD+4n1F4CHnVDO?=
 =?us-ascii?Q?dTe4OdGAlgtWT2+s1MACTz08ZXwIJicAbVxwjArO5EXk3djQuYOuNH47BniA?=
 =?us-ascii?Q?GvVD4jaTOYxBFSNvqfcg2AFXlepS8CNCdT/FAdkj2seCpQh32wRZezr/Buqm?=
 =?us-ascii?Q?kEwZ72UF7/e4bJsJRArmVM3zuU/KXtF1H8HIQm2HKlgdhkhAR4gqt1tClSTA?=
 =?us-ascii?Q?mQtJ3QHhD4+b4XZ3HFYBU60brfvbwVJI9/wRksL9fXeM5t/85stWKG9Pu6og?=
 =?us-ascii?Q?aMOXi7yHVUMEeABQ6xWOypfiHiLXHVZ+mF9GuIpmfd2pUc+nXwUWDBfBRFjA?=
 =?us-ascii?Q?1hbmg0CfZsI2diJVUrv7nDx9aOR1tk+zgn6xg62wjwGEHFvFCFhF5LyGoVOd?=
 =?us-ascii?Q?CsGo1EQlORJ0/v0Q/HM31Qh1W02xghxUp06RwIAaS//U+USybmOYgdA/KzDv?=
 =?us-ascii?Q?ekWgIlxJkDz39U0UL/IfdKKidWowOrkh38jjFsXVdzmzvEeJUJqRRJOcPrv2?=
 =?us-ascii?Q?z4LOrAf6MUMI38eD5/N93OTFhcW/sJgt3WSzmctxIseaPG5EnZgx/9n8A1Un?=
 =?us-ascii?Q?+FklWluWWaGWPh7r+40xe+li1+h4YX+GzOpdMWItuRbWvfaZ40F5A6oGNYtI?=
 =?us-ascii?Q?TfQwwTAoVIeUoOeg5I2L0jlpUvYeg9AwDipgAZm0bJPAnd8Vr0RQacQGlqVV?=
 =?us-ascii?Q?1Yq/XvMvNvNivfYE3fjX5dlSCe1DxhK9iEN4Qiw2PmC7LNBj1q4Fj8jtAHbW?=
 =?us-ascii?Q?QrwM9FY8Z95i1NIFuO4rKdqsnTg5zNL8nMurydaGvSQEjkViCjZg7utOn1Gp?=
 =?us-ascii?Q?ZOSQJhDC6FWmxCPT5F6Fya5Wfm0KbhiiSO7LrVMrFMTZGnP2Lmwj8qHDqd0a?=
 =?us-ascii?Q?1fLSMtRPXSHmOUK/RdQNiiAQWZHDCyg28zeNLkf5PoZvn1q56yGvabjrRAjz?=
 =?us-ascii?Q?lWw4D1o7Md9YlMC22tQZvoT4xtjZRkCAR125wPRLnu14NoGAE//I+rBqCCDf?=
 =?us-ascii?Q?+TTeN7ryTWpMB6GnEw4/OXHYF+K2Tw+R3ybIYL+hlEJPFvhOfPTWP1yFOeg5?=
 =?us-ascii?Q?MVC6KAL+K7bnOcVOpEKp1Ir5ioOeTH+X99DL0kLH6fbsFIanILNqq1qNyh+i?=
 =?us-ascii?Q?uXw6Ks+UdkEiUdCRWh+3TXAgjXSwrAiWqDIEF15Nk7Dp9UbhUfd+012Ln3wY?=
 =?us-ascii?Q?9x6D1xIfRBub3tf3uuWcf5Og752J2AA9N9iWNGKCMiMibD5yy4rk+18G8FPk?=
 =?us-ascii?Q?H9c0c0g7tJC6q59/eyg0E3B8EIZ4kpFmcBahlgcGbAmeoGmki5CBzVtb3BEu?=
 =?us-ascii?Q?h+0Y559nugWwH2ONrQLsM/liz9Bou7zEhSufQsVjHUMJGyPumJ8whOgV5uoK?=
 =?us-ascii?Q?5OtxwNxEhWVDCq79yu+cuaiqPeCI7B/GvT48kkf0gV5Q405sWYWmckzc0Wep?=
 =?us-ascii?Q?vGfJ/LgLEfMGIvSxWBMxd8m/8F5lWP7dm31VSF3W2oTvnPEvFerOZE1yBkBq?=
 =?us-ascii?Q?OFXn+M++v0krcp1Jb9X5XKnrC6iK7M/y9RD2k+FLmMSkXsO9AdVD41hmqZaf?=
 =?us-ascii?Q?lSBpjv/NZxotJSg5C3f0uHMvG9p0g4uOh/Dhp0he?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR19MB5310.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14416c4e-5e34-491a-c8fa-08db82b7420f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 09:06:20.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZfXjEQzu8i+tUXWNAmSQmDNjfrCURBZB5ijTrRfbGHDWwkDu4a+33PoOOrZFzz+5BJpYOkJaKpIXut2g1pe7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=722 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307120079
X-Proofpoint-GUID: Mqxqr5HQSjdCYGQ8b3YdtwPxUjmghHf_
X-Proofpoint-ORIG-GUID: Mqxqr5HQSjdCYGQ8b3YdtwPxUjmghHf_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=766 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

We experiencing an issue in which MACVLAN MTU does not limit the frame size=
,
i.e. the limitation is coming from the physical device MTU.
Kernel version: 5.3.18

As described in the case below:
https://unix.stackexchange.com/questions/708638/macvlan-device-do-not-honor=
-smaller-mtu-than-physical-device=20

it seems like this issue might have a fix.

If there was a known kernel issue that was fixed, I really apricate if you =
can provide to me the commit in which it was fixed.

Thanks,
Ishay.

Internal Use - Confidential

