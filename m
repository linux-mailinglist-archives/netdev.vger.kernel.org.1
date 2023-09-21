Return-Path: <netdev+bounces-35458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851617A98F8
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94691C21251
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5043A94;
	Thu, 21 Sep 2023 17:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04B18C3A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:22:46 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1917858080
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:18:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L9SCFM004003;
	Thu, 21 Sep 2023 13:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Sfmct8VFiiO8FIIkLhAufqdofct/vuHteopPXIaX2m8=;
 b=d6aaYIDz37h8lKHg20l40HdlP3vyi4iF7sYAPTZn3COyAuzDbOe61lWGQ925sVn0ReJO
 fhXc5j/H5zX/9MUo+toQ89SOVPkw0HzjZJoxEh20Hu84Kc7KTexxPiexy+hSPAhwFGg1
 rwfeQwwwzNgCYUp2JekkFTXoj56VDRhdBq003t6ggw1nGjQociokLE+amJfH1aePl9nh
 fWiOba/FihZk+iHcxtBkDc4AdMPVmpwDWdG0UYPx9jbbatVI7TOCXLkInfu41poqTVI2
 vYIqtSb/E8PKxpPsJtjxNm7grCNiEvYMdhUY1J4MjaCgkf4xU0LXucRBBGKfjLt9JGus IQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53531r19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Sep 2023 13:02:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LBUlwX027003;
	Thu, 21 Sep 2023 13:02:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t8s70t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Sep 2023 13:02:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn0I1V0fW1Iwu0DfQrGjdscK6rWxug6bfnUc/a/56dhrlnYItD70IXZDX3egdIti5WvliYyaz+NUOWyGxDSNVPlqFH4ZSvBAbTfAeSYBcIq8wCL+jfNkG2owygLO7kiMSwvMGjxMJjwEwL8y654jg1IruMX2MvpXLfFfEuQNJgZElPHWB2yY0Pckg6tDVl726oI0Qc6EYYe/kbsYv/rnGg50MsBUpystdB9AUQdzYFf02DmSsR2FZNBj6JYobEPV3ee9+a5ZckcDO4sfYccJgG3JeCzJon78gOQqqP+h1UXn+kuOY67fMBQpheLGtFzkk+GcnIhtix6zXcaYO3d40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfmct8VFiiO8FIIkLhAufqdofct/vuHteopPXIaX2m8=;
 b=Iqn8FTqG0Empdmn0RFb2Vjrnt9Vro5wqegvHVhLVMlFittqgJxVYjQPQSM28IjAdKFky1nFfcWZVpXJ8BSy6KXthzM5ay6gRSxU1uuy9FuPYVN3Gv0A0Cx+y3GKMrpG4652wkFe0lNtwE8bA8Us5EnbfBNZWv7CxCfKKoNeTQcz4ulczTILkxQloPFcgqMDorg+qBi8Q3O2E8t3cY502IROGvztVr+LzCdaVmtErvj3LF6Ov4zYNi6Fvh9jwpDjBiQSR/7Ie1yN01PhqKWMzbpC8B4VLTiQGVaGFyk9GzL0DQLcmRwUI3mzU5Al3vgAoEq+xJ1nPe4CH0sTWLCdxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfmct8VFiiO8FIIkLhAufqdofct/vuHteopPXIaX2m8=;
 b=RqVCADpOPPT0OLBMjNKZP1jvnupefKh3oZDjzPE2ongjX9MQHfyrbJ6q77Dg6tlFYyyrwVoeyCKOIFdw5WViFXeVCX6+hdeQLfm/GS1ZcRIZY3svWsgtRYo4j0Bt4Y0GiXw8z0FQCqeBFdxS4JMYUIof2+jnkjV8qfSdA6RsEVQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7784.namprd10.prod.outlook.com (2603:10b6:510:30a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 13:02:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 13:02:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Chuck Lever <cel@kernel.org>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev"
	<kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH v1 0/2] Fix implicit sign conversions in handshake upcall
Thread-Topic: [PATCH v1 0/2] Fix implicit sign conversions in handshake upcall
Thread-Index: AQHZ6zJmYWA9RllQbEusjrgS3jTTN7Ak/XuAgABDuoA=
Date: Thu, 21 Sep 2023 13:02:07 +0000
Message-ID: <E8AA8416-0914-494D-B463-D3F8AE5F087E@oracle.com>
References: 
 <169515283988.5349.4586265020008671093.stgit@oracle-102.nfsv4bat.org>
 <b5db3535a15b7e1bf89724d934fb880d292913cd.camel@redhat.com>
In-Reply-To: <b5db3535a15b7e1bf89724d934fb880d292913cd.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7784:EE_
x-ms-office365-filtering-correlation-id: 96f9904c-3df4-4b70-47d2-08dbbaa2f61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WZ+WJ8v6E5cPoPLHNx7W49xpfBiU5bf6ZRRPbPdDRBjZDCdyGOXm6L71fgc9RL5EIIKxJZKQix7H3nAa1F5wqiBukVVNIj2iGzdMXkzFRdaw9P7nBPx6pAXqGXzduiaW2Fn2kqi5X2QURlShHAqAZoU5E6nJ3DBntdltaXMXyOx1JF+w3Yaehq2GSIAf1sakLOX4+AQJcYcPA8sT3BONbxytGZF6VYAdB3H8MG5EyepI3P7O6xlqhbz5dXhTtL+QSPznoR6aK6Cx5gifAlj0N/9KduF/LO807p7OmqJX3BznKFZrMt4pmwvrOVmi/8N6QzNmfkN9pM6+IIlpsyI+PcaYumpJm9A4MZGDxa2hfNsN92S482JNCOXCV5p+o1sYZGfOjKAfaRMP9cTcTLxlLiNMwSHSv2BwL0n1M78PKj20hJKWkZ/bib81C7olJxOqZGKKJYI/pkrV1zry/qwWG85mKOVYgX6ObPwVakCfrV3HyKFtiMVQdDV08ahYqUfU+hMTVJcL4z6bkh1NDkBEY7zv5NEC9fpfExj/oFSpas6dXJ9z+NzbgvVtH+2ttMCf/QgnNz9ZeOjqYMIAlJf8Sm1U0eEy5zgoTCwTUQK0XaiE2hG/anqe/+Jwah5tT5Fg+8ut310xTo/ZhxD/MRwZEQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(1800799009)(451199024)(186009)(2906002)(4744005)(33656002)(36756003)(86362001)(6916009)(38070700005)(122000001)(316002)(6512007)(66946007)(64756008)(66446008)(76116006)(91956017)(66476007)(54906003)(66556008)(41300700001)(8676002)(8936002)(2616005)(4326008)(38100700002)(6486002)(6506007)(71200400001)(53546011)(478600001)(83380400001)(26005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?slDimzej8726Pvjf8RlRASwkjgWFyM0RBNvkfxi05oZoV1ETbwVIm+3SaiU/?=
 =?us-ascii?Q?OjfBw1KeOJkCgqu30rlbgqrAybSUNjUG9n9bmfFajMauZ6CaoN9XltOPfMSt?=
 =?us-ascii?Q?/KlAwf2urU25Fo1U87LxjecNrgBbVu4z5RmkyBbbDbMYPrZL6Qzg92x724hq?=
 =?us-ascii?Q?atpLR0RtqjRS6+0rl5qyV/StIEi/Q6GwCpxvRNA1VVTWSUvTOkI0MHiUtTbG?=
 =?us-ascii?Q?XFhQyOhJ2DmE3BOKkjoj+xVqs6I2yJAYmPrBYELxGKvP+ObSD6geRbup2uv0?=
 =?us-ascii?Q?S5HvFOIlJN/aXWpRfTbYJHb5GXsc6UCRyCLFbOPm9x56nk1m1NooD5x5xS/Q?=
 =?us-ascii?Q?Mn0ocBb9diACY8H7uJfGehM2+n4If1OJuybkFWHVhsDbQqABkb4LhIKQ2znL?=
 =?us-ascii?Q?f/AgZ/jKnaHwsc5TPfOzsmVmKNnIaZDbZm1T/3571kic05JWEF2WUttTfmWk?=
 =?us-ascii?Q?WuoAcOWV3FvSv3OuRQ3EIC6jxtwegDTAT1wSbIyVS5l1nYiCwh5JQbmhdniq?=
 =?us-ascii?Q?mivKwc55HDvS46WGtZ0fUbLQvf/NJUhnGbSSAtPbQyicyLig5wtLGgElFIgm?=
 =?us-ascii?Q?EI7TrBcvmVlwDCgntuS+32S6pitMcnNjduCJdHSWX6W562DteRpfQ3ndEIMd?=
 =?us-ascii?Q?hnZU9kmR4LfXvo6Mu02M40fQpvhGc9QN8z/pGsEFL/WOCgiIKXIlqIC0YWQR?=
 =?us-ascii?Q?FRFZrEW4EV0zisiaECauBOUGNlNJiFmWlMBixrUaBnm7Cs1NJK4IY07uliQF?=
 =?us-ascii?Q?p5Snw7AKakF1Qgp45R8adKb0ba1CA8DLnHrIEFQnmKKL0uieSnhxHkRgPOgW?=
 =?us-ascii?Q?33TFxmCu5VKyyu++VR5V45hon4gaCxFmsgiH1SMecZ6h0lTEwEfZZneN9Sjl?=
 =?us-ascii?Q?1HvRK1yBomwqDFuwdxapOEppa536b586TcIF0piVxB5pLwxaMX8vvSN4yiNM?=
 =?us-ascii?Q?QhL/JqJ9dVWDEBAtyOiQsj8yGN4KQ9/5cnOSurkOithy4lWOoZvBX3Bm7Xfl?=
 =?us-ascii?Q?Gmsb3doJwdnIW1FXxrNiD6H7mzMRusUA+C8nn1PWfRVrDLYvYXKsS+yE7riH?=
 =?us-ascii?Q?4MVQjm1ki3QvWGsC5oiqDF8DVjUDP7pDRi9IjHKO20qmacOl8/Vlm4anhJLK?=
 =?us-ascii?Q?2dybXHu4eUaGjrghCeCLjEj9sC4hghTYB4xP5A/WYbxzXV/CrpRo2q1Rse+n?=
 =?us-ascii?Q?tknvyVbyyyV4Q2vK0+l+oJBAaDUDdR+z1CKXmv1+xRhjC+LPRkx8HI2lzmSQ?=
 =?us-ascii?Q?dHQEpe4Rtn3dwMJlNEnCSfEwayzSsfX+oW7xBi5j7Y65jN7oNs1LBektO1ic?=
 =?us-ascii?Q?QaDvJJo2SOAWo8egZ7ECfo1f0r0spW/nsEesfNwbSXRJm6HX3zQBv65Aj7Ye?=
 =?us-ascii?Q?r0Zt1QCuEj7eGaj3X9gD8QMBQu/BEjY2KcntUwXHg9pEzae/FXC+5X7kXl7w?=
 =?us-ascii?Q?wBrElNnSwunxATV7pwJWXg8L6X7QAZ5mMkV2jX87XP854gDRk7FxGvSJY02z?=
 =?us-ascii?Q?aMpn+TcVQxqVMrDG+3lV5vdrypdxqctoRLSWt5qFqLKEG8AbqG7S5BF/6jPS?=
 =?us-ascii?Q?2qU9P9pMSqd0oIjvcBwsHOZFK9RAUrrpGd3Jakf1XWJV0bw/lnZAagIywjvG?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB8A1F6E15E9DA4BAD787E67D59831EF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jAiT3kqOmVoBRIrA0uN3YawKiNPk9QEYGLsjQNMZQ0iDQavq9ZN/3e/kDDVLnIRGg00znAYgeZLtv56mnR3a8HwnQe2O1WWyEPTaK73EKH4+AXwWm/w6w0mU/Tu4M3LEoTPLEg7TD0Z9BslDOJDRQf5HZwXWZNOXRpN3yzJOvr8JaHgMRKDbL6pvL0kUj3mYcAOHIedlGWBhFLnoTyoJt+9PIIrnng5Pd36CsCixtOgLp8dsAr39EdAB7kMR595OYK1qMIuQ/9AIthZdt8Fu5+l9RJ4Js779XukZCV0FmFQ7IlBD9flqRDTYg+W2F4WI43ry2+FbvTpLBQD12CGKr1kjnOPhc3L0M4QI/4xaSoSbixyA6q8c+Qrrj1RoAao0rk0H6ePvPA/thVug5FOSKUoppFCASg7zidrewb0a/ouigN7CpicXsHGxIgCSUgWnM/Dudjyq4XF5LmvHmNIN1Z1GnqJH5duVRWLUhxWMSj0qtuhf03MbWmhpvu4PEQP6+q9Dt+Gae0pwdlIwLzYoQ+ZGXeiA6vKSBrQ1OuionNY+TkFxiJpwvJUy+D0B5u1WsghS7mSZeIdiAxUDZGHY4QVs58+woC00fd2tgrCVll+vkHIeutw/FK+uJVD5dijD8FQmJ/PVhZYap7TDPTMu9mxlwTUkLtU8O3ru/igha+ViqEmaj+Cy6Cle5wlZdCSgsJbJxK8n1aHX4k7sr+nHw2AqUZ9JmqWdiT5qRE4DEsU6GtA6smf/qKADv7PFmsLoI/ZkkX84uGWMKbsItfxhDUsBVoWwZ6SXjrG7CuHHg8yDEujJtQ4kmfGIQfzMLTw4hZlr4TQX/JFGaCaCXOMjHA3gkC90TclWgOe4YKdcLeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f9904c-3df4-4b70-47d2-08dbbaa2f61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 13:02:07.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryy2rND+bk9toKVqv0I2G1yNU4eE3DkhJXjIZTuT51IxI9MLStbdAU0OTvVYO0dtYRiaTycThmLjlBBkoSCHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210114
X-Proofpoint-ORIG-GUID: 1ARPapSWRoq7ijV-bcWT9cdCaeRS4oAa
X-Proofpoint-GUID: 1ARPapSWRoq7ijV-bcWT9cdCaeRS4oAa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Sep 21, 2023, at 4:59 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> Hi,
>=20
> On Tue, 2023-09-19 at 15:49 -0400, Chuck Lever wrote:
>> An internal static analysis tool noticed some implicit sign
>> conversions for some of the arguments in the handshake upcall
>> protocol.
>=20
> This does not apply cleanly to -net nor to -net-next, and the lack of
> the target inside the subj is confusing. I guess this is for your devel
> tree???

Series as submitted was based on v6.5 because I wasn't expecting
conflicts. I will rebase on net-next and resubmit.


--
Chuck Lever



