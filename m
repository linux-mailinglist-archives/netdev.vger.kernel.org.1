Return-Path: <netdev+bounces-21923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3BD76548E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743651C21646
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FC171AB;
	Thu, 27 Jul 2023 13:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D0171A8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:08:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1864C1715
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:08:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0uHgZ007920;
	Thu, 27 Jul 2023 13:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MIBiffONDG6HI94l6EEMQamflVyk9EEWQ307fw7ioVk=;
 b=iBQNOuBL6H/uTTKJ67x/Zi3EmELJ0kzIkzBibeJVlSmLzFWls1AgvBr34hBThZiuFsIS
 w13hKyxvOhiDBmG42fDa1p095qU1a4wjsyO1NqBkEsBV6iLML6S5jq+xTIPoyxHbECSr
 LhIdegaXVqe2F9RAn8aJLzmNpZ0w2ZqCdYTJEiVmd31sg6bSjwd6fjMGywJYa2OCYzZ3
 YorQBh4nc7iapnL21LrDbojgao7NLMvGqVsTJzq5UPXPi46iTflB+7D/yaYJEJMPd72J
 61sMSzwIaOSp/bUUR5s1RDOHs/O3uptdKfXMfGR8+lnXs4PMxc5ZrXrg/Doo58zW5LND Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c9q64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 13:08:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBn0aw030496;
	Thu, 27 Jul 2023 13:08:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jdx3ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 13:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHrbacSOUncnI1pq0LeBb+gGmccDK6pjs2bZ+zOq75z3w0lgfoOQ4peyxq8zMBbC8aokrNKBlbM+fZ6wwIVQuhEqJ+UXcv9vCfthGGeKH0mLjmcm8Rs0ZZBS5U7iPjSuxigBWVTExHYH13xOp6BhUYzqVxNjp5z2c4PRDwAYEAoqH7jxU6uK0oO20KZia7+O98bttF+DmsILluLlrmMSl0WpLmPB7ecRe+08+q9pv3e0vIjquOVzXG2SDXhtsQX/xQ4I7FjI4FUvXTCTRFYEcx0d3G57UMmxmW1LIKllO2pc6n+xQ7UIh2g8OvcLfuPz1Jr2qxz8YSWYn3YhLXrC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIBiffONDG6HI94l6EEMQamflVyk9EEWQ307fw7ioVk=;
 b=Q9rgwMNYXUJLm1wv8t37Kt2i+FNESupIGYFwey6JbHNyTjesAVDQzyx4jQOqt3Ak5rJYL9VAPYBajg0div0hcSXP97Y06PmrykRVN3laMdzoL3dN2NNhy8nSN7VrE69hldYjCxzXOaz4zoV73egAVoOjqmTb+26vu/IIgoZzjMXhHiKdp6PN1fcsD8gb2tvk09MB5rfqA0Xmz6L3WdtSACbOrIxUwNACvJLx32uqoNk2WR85XVz6gUDPyB/lQl9pQbS1YXjP0QNwoKe7U9LEXUUGEObXaLhML6Kh4kPXK7sv4CX1ZUNDIpWH71p9SK/J2suyyx4Q47zcFAnbioBg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIBiffONDG6HI94l6EEMQamflVyk9EEWQ307fw7ioVk=;
 b=k0RS0tPzNR6SVhA8CXj4OqKRQVlLQvFNOQrOnrx9B2dS0CjJ5N2OsO9aHryY81/6dbPIY87FeYDrKZUfjKZdgniRuHljts3fR8r7sCZir3gFnTPbjZECZt27ZX2cARhSwdiD8ZaaxaSjN1qcN6Zdq1h8JCzIAw+tixrFoY/BzkE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:08:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:08:06 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Chuck Lever <cel@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH net-next v2 3/7] net/handshake: Add API for sending TLS
 Closure alerts
Thread-Topic: [PATCH net-next v2 3/7] net/handshake: Add API for sending TLS
 Closure alerts
Thread-Index: AQHZvzfFb8UN0j83nk6UjhR3/ZhhS6/NCg0AgACOOoA=
Date: Thu, 27 Jul 2023 13:08:06 +0000
Message-ID: <28DF613E-7567-4947-8E26-6ABBAE7086AD@oracle.com>
References: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
 <169031739483.15386.5911126621395017786.stgit@oracle-102.nfsv4bat.org>
 <20230726213852.1191273d@kernel.org>
In-Reply-To: <20230726213852.1191273d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYXPR10MB7976:EE_
x-ms-office365-filtering-correlation-id: 7f2abb70-92cd-4c39-e542-08db8ea28476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DortXOrdNbW69NcuHWyLqNrColQTwTMAdMbfBEWtDgQC+Ta1MmQXZ6DD18zXvwmCS9cc3FhxpfwdnejYgoU7ZByHt6YwdPq2TEpkC3e3SPoYMYhEIXe7Z6V1fBvD2TrUONVjdS5482YD4z44otds2tIzjyjaTzrohzojNedAHtt8DgxgIGXbRoKy43CAvv5JmBiX10n93Mxae5xk6FkuDqtu2wKD5euTmg/q1otvZUT10hx023iPoBOtqmJDutHoKcr+nZGJs4M9c8pCNo9ZKSKD+ggQuP45gfNPI8iN5kFjcjMiMR4hhAmC9zZiNAupgQnYRO89NnvhjOpdPvRdMY7FlF+4c0XcHcDWvduQoKAdNnqfyKCsiT2HKihfOKFXu7GkVPTBi2m/DGYlZPMuow0+pyW3+JPiPA/7UJx/HAvB/wRTRYM/Nna+1sM5rrjYmXgDjlkIbv3nAzkCBj/Cyap9QiDMWBkPQ7/njepA/Dukf6clFirLFv9CQMCm/zJ3xSlc2cEuHbXwKF/GX7OdKao8i0bs3KdG/HiscT0kvGydeynboMD7H/Vw6Vi34o/zvEX6EWgoiBRE13hPb1ZBv9Cpy09S2e/mhKH8jBg7SCR7GjNCsQ3sS/PKJ5AxgBzBZxPbcbtEQefNmN0L15eyWQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(71200400001)(6486002)(478600001)(83380400001)(26005)(53546011)(6506007)(6512007)(91956017)(76116006)(38100700002)(66556008)(66946007)(6916009)(4326008)(122000001)(54906003)(64756008)(66476007)(66446008)(186003)(2616005)(38070700005)(5660300002)(15650500001)(316002)(8936002)(8676002)(33656002)(2906002)(41300700001)(4744005)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?9f3VAuL1Br/p6y2Cv56ldOO/TOeqm+L2KyX+qhM79du6ZRJYZSfQK3HATspb?=
 =?us-ascii?Q?dMh3UtR2HywdgsHM0jQ2xB7Vgvc2hOYB+4yqICHsQe5VmW2M10Em53GcakcC?=
 =?us-ascii?Q?GEYQDX0xeq3GHPRgTFqCyHJzrox+bD4NDsinLJPE1WuNtqr41DL2B8Df/w5a?=
 =?us-ascii?Q?Tg/Vrg9adQwExI1YeM/R/2kDuHLKQ22pWFG3KetivV44Jm4ysymJ3MmcFZTA?=
 =?us-ascii?Q?REljJXg+dU7FxpzXO4k+O+mysv8yb+Upfno7WOUIW06HBMkn3QQHAVUWPJ4u?=
 =?us-ascii?Q?IWBKbmgeYN174xRVOHhWoGpXxpAP7uTJ1BNPgK8vwzz/b7/knqeOSlmJaAIJ?=
 =?us-ascii?Q?+cgsBUGGlxeWIxZs4IhgM/jUxXZC/LzlpZ0jOzbKH04wkEHyym9fuI46BPXq?=
 =?us-ascii?Q?avnu/Tv+r3TVh/X40W2rzG5R2/fzHKBtTozBKhDMo1WJKLJUfyG5qdB6Vr6A?=
 =?us-ascii?Q?oEmxCIAMo1MNYTK9lbmgh9jwcz9u0TFG577Dr/qVe30gR0t/qABvPuK34ev+?=
 =?us-ascii?Q?JfV/WDTwFo2HGDYR6MYPRkpiu3yEK8pf5tncUBrXwNQvwruziyB2AY3k4ZrI?=
 =?us-ascii?Q?ftqSVC/JB3BX3IkJYwEhlbyIsDQt7gdVt9k//3r3GNbFzU2aGaXbVZHBT1eH?=
 =?us-ascii?Q?6YpudJp8bI22oG5yvOJqP0vfApDC71QJVHxAmRGlQcXAPE7vxpbr6ME+Y1Go?=
 =?us-ascii?Q?9NLqGxppIFXgQBTngRgRaNJ81wrYtinSrooYOzAjYcp8Jv2JByjRSIoi/mda?=
 =?us-ascii?Q?5X33jIZ+K/fFr+oB5k1Nxa854ZdLpt9pan4KlUhMLDGIat8UAbvpfwEfT34w?=
 =?us-ascii?Q?QUGTYE+bZjqpclMDdrp33QxdQpUn5PtwzpN36dF7VR9MoAggXT4847i+mWsa?=
 =?us-ascii?Q?ziRWqLg9M5ti53JpmNL06DauzYkujH3Li1tig7RrKjLuppxdfdmnI4YRCJu4?=
 =?us-ascii?Q?ScEhzZghSfF9j23+rRGwTR58IB6toIR1T6XzzO9mn10dDItSif+FXTCzIyuP?=
 =?us-ascii?Q?6Ehi/LMChW7zbU8WLWAUEjtKyq0Im2n4o+reFseJEneDMoErmmV0dJSX3S2r?=
 =?us-ascii?Q?hivftOWG1YKo+7DrPjplFxFKai2rc9Gblqt6goEDTsCoWXW9CigqDmSie58r?=
 =?us-ascii?Q?yV/nj//MGHrA4tcomskSuOG8HuKamy/R6e+hPZfS8qzBDI7TWa/SSZB+yHec?=
 =?us-ascii?Q?IvAZYxFauvVV/zDmBKYoW71gU3p5ASnhn0yNLq78j8IKI88tWtzu5xQWvpUD?=
 =?us-ascii?Q?tOEe1K59V2VbUTxgVwxgi/GIVafCZTdafOyMJLdIVwzCaPSYvQH4jC5atAGP?=
 =?us-ascii?Q?I1eTh3qbmqFomVNKV7I5HFOagTcYkgQ5Q2FitTQ/Ut82sIYl7KZ9EgO1xFdA?=
 =?us-ascii?Q?xOQ8Cnpm90gwHTChX48WgoDQeYJpQmgvJOf2MvGWucr5XA63rJsdgX7sR0dW?=
 =?us-ascii?Q?Xhl950Gy84mgxPIKAQ3nc0aYAOAXMKcLhrLOZ/txsWJfUlCNaVOKfKp0fEgB?=
 =?us-ascii?Q?kk/+EWWS+xhsdRLnPDIyJian/in4PUXpEgvnuofedw2VNL8MyBJ1nWvqH0dL?=
 =?us-ascii?Q?eMnTBhLNHGB+fU+czDUQU94G5ZwkAXeINjsBhU3kp3ueuV/5khBUWnFA9JLf?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E5F9EF13AE1C141BAAE380E18163563@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2BSVNBFnGFMIzW8bLSO5QA8SgYOjgWI+rFF85M0AVXeyI8zO04Dq4Si55TEcNGeMwrFTHaE8w+k33ZMpgpm+eKaJwjr1kvrX1ob+YRjS/XRhOGnqwUfYNRH0qxff0QMo3tcBx4oYA8IfDNmtDP9Ezbk8sDKlqPttH82PIfJHCsAHYajwbhGZMFf5ZU9ltoYdlUQooyrfBTY4khUZ3r27VbKRJIRhzi5fr3jsgEaCUF+dkb/aWadEzdmOwPSCFymacS5vQ/aeBkqJNnwJjZxEa+Ukv+VsSKTnTUcxc5lvfPFPqPePAltMIxmsP6abTY9IkojhWOD+K3GWGwDvKuzBnLWfZow9W5+K555L4eIYcD1Lzy2DAk9JcLXTFNXu7KKA4yrt8Rxj78ASRR+GjYalrr7nOv5bJDG2f0glqdpNjdxBQKJm6BpYUZRPwfAX3b2UMkEsb7E8a/TbpaWWUff6syu5yzvaAnigkcmD1vjEQqDO89ssldqwIO+QBwY3z7/0eAqcsoH693kIDyZj/GS5O16DYW2BKxbnXcUoQTZv1qapzL6O6SDTK40UxbcD1K4U1rNGF12vl4zFbtH+2ETv9UfdI11mKVGb060Gvh4oCdo0YKXvvbbi9x7TZAHHe3abEBVuwrhCAXjv5eJ//wnl5HiSMRVp1f3KbA9PXQzHKZmx8qswOmFN7dpIs4wOFa1eF5XRuCbJE7VM3uL0CPFsoxjrNDTb7we67ukSOK2RygGwPS16HWUuThBjDBVRpYgF/qkHTJb6BwJTFsr4UvlYnDppYZ0ohykxD1hCCgnZo4QmcpgpcIdQgjs1CyB6Rx2NcHvl+CTfc/NtB6DNnAXLDw2TEElhPlupS4v4+3gNjO/cfFx0u/VZyUsfdkOCSavJyPblyNKILge1VMfUwEM0u/bIZqI9b+QC8DMCos3KR88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2abb70-92cd-4c39-e542-08db8ea28476
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 13:08:06.0822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/60d11wXEDXowTkpo3dC6DohESHr8J557lsF69W/8QMMi/AZDesiEDbNwTfTHOMo27+RSADf+XkZfgvCkzP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270118
X-Proofpoint-ORIG-GUID: ih5dQd_VN9agO-oqI7vurxRYeVU-VzX3
X-Proofpoint-GUID: ih5dQd_VN9agO-oqI7vurxRYeVU-VzX3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Jul 27, 2023, at 12:38 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 25 Jul 2023 16:36:44 -0400 Chuck Lever wrote:
>> +#include <net/sock.h>
>> +#include <net/handshake.h>
>> +#include <net/genetlink.h>
>=20
> nit: genetlink? copy&paste from somewhere?

Probably. I'll remove it.


>> +/**
>> + * tls_handshake_close - send a Closure alert
>> + * @sock: an open socket
>> + *
>> + */
>=20
> nit: the empty comment line is on purpose?

My personal method of marking that there is no return value
to document.


--
Chuck Lever



