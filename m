Return-Path: <netdev+bounces-95972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6788C3EF4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7F5286FB1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8175101A;
	Mon, 13 May 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PYsnkN8P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78921101EC;
	Mon, 13 May 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596385; cv=fail; b=CNpV/1naAP4cR63dEF6DrHn9f6Y4UOh/05gg130sy3nyd5bawHw2nWncAnPSp4BWLBSjjyzFWiMusIXW83XRlplqqCrpqCLUB4qQBYGgGS9Ukn/iXpejbIPWYC2WMyvOevrQCc/MvKeQVss18lhArQcIpYJ/VRQWwap6gUyojZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596385; c=relaxed/simple;
	bh=Z1YCmYVMvhEY2SDJXpgI6ivUEEF+tXvAiph1eb688o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZR0ThwiyfHTWJIgmEjAQ+YBb6Juj5wJEDj9Ll94QL7TkEzoHt1UFAYxJdbawsRgUC8KexB0gfh1gNSi6yKgCF1lx4lZwEDTAfRq0F/9u8Xn5hiy1DSuxXAB84fb1vHFMAisnwAIEVrj0pBwYzqaIIZX+bCNr2vE68bbygUQ9Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PYsnkN8P; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8X8L1002147;
	Mon, 13 May 2024 03:32:54 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jbwu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FavXYd1xtey8VnetQRGecwOUdNnhCh41gdXVOEEycBzn3lV1SHZHmT9ayJi2bING2CXCtUEJqR90b+f9HAOIkElOMBHyBQjxGGBicK738AmhHriD6uo4RsHwv+xkGgGMbM6PFCRFwnToADIZ98toQyQk38n4lR8hwPwd/wIqj8+NLq223Y5bclzZepHTlnQEcZDTh3mSCsWT0M8jobQsMNMq0YNhVBg1h14++nSdK8FmyHYX8rEzxey/BQbiJoYtr0eok+6JoM0QaPNZBBLryRIvao5QqICugu2gHf8/msQEHAI7X5R33LSuD0Ct2Uc1bvuq7SwmgPn8CoSaMmaD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1YCmYVMvhEY2SDJXpgI6ivUEEF+tXvAiph1eb688o0=;
 b=NliS5xtACBw4+lGe4ws1wmaKzyf/XV9IP5AqcZAXTIO7qXj+I7DX300SUzCJ+kcA0rHNEj2U0ptQmBuJcwjthHVdfTFBEDwxHvzjW+1XnmggjcsuZWWqLJu2s/jEQkQmfy8YudTknt/0cr7+RkiSGhOcIIN5ZS/i7o5g3UGTjERmOREsaVszFki9UZFudHXup02cWetjW+1Y6y+d90kd7rXMtKL9LH0Xy9PV/2FyFBDdgyiYclKC9B4aZ46rOBLq85V74hkqYIf6OaIzxIqY4twejzZHCNu3aCF1XtUG8Sf+6GfebRu+yomrKKQGodJMuSLHFxTBw+WB4aIuoIbztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1YCmYVMvhEY2SDJXpgI6ivUEEF+tXvAiph1eb688o0=;
 b=PYsnkN8P3dfLRNHcvhMmI7Hgj2ch2swa/peEgrImpTyUYKl0AiDvfIWYVf7+t+pX6SMxOt0sPFKe3TP35O3Reb496aydBZ7JY+Os9Gs+GDl2zmGrh9rZZ9vXeRSTN8Zix77YG7RZp0NlPw2gThOryx947JsHd8P3VKhnAKndB+w=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MW4PR18MB5082.namprd18.prod.outlook.com (2603:10b6:303:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:32:52 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:32:52 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v4 09/10] octeontx2-pf: Add
 representors for sdp MAC
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v4 09/10] octeontx2-pf: Add
 representors for sdp MAC
Thread-Index: AQHaoJ00yzPhs04nM0ilWPCSIYwod7GP1DuAgAUsHFA=
Date: Mon, 13 May 2024 10:32:52 +0000
Message-ID: 
 <CH0PR18MB43394631EAD7062F19F3E838CDE22@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-10-gakula@marvell.com>
 <20240509203249.09a5630f@kernel.org>
In-Reply-To: <20240509203249.09a5630f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MW4PR18MB5082:EE_
x-ms-office365-filtering-correlation-id: 47954f75-92fe-4ee4-b367-08dc73380b4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Lj+b71b3EWxZUZHtRvMoaeezxiS5D66fPqIYxT4IhAcVYqEqWz+real0m4Dg?=
 =?us-ascii?Q?WlHNvgqv+D3OD5hazkNjGyQb6j7/M5mddHWS3dJmQp1kAAb5eq48GrcFaNzJ?=
 =?us-ascii?Q?aAWuNsmDWGNaDg/LNQJ1HM9UixO7FBRpMsKRPDY9ikGP0NJA68GOW0wBhgPV?=
 =?us-ascii?Q?4mkjI81zWLRzaG/a1LxdqLLCIzBe9UCXZlfN7ZIzClHQhusdcFgDrGKCPj51?=
 =?us-ascii?Q?pXymvKN4NiQpKaKeolZw1Zn9xYy1DomgQr1KrZUGZaYdJyuBs8patFB3gED4?=
 =?us-ascii?Q?cWLeU3GYqPu0YCqhPPCpvTbfuZ0EJWwL8A2C8wxHanCUXpmIhB0Eriq4992J?=
 =?us-ascii?Q?xBWdUaW0lz6dOWdlEHbzHhvRMRn7OlQiyfGzdiEsX2VGjjrNEJfsJpym86Zm?=
 =?us-ascii?Q?TfG1XGk+pe2GmmjmOm85xHliJzayyKztK/zOH+hrwUqmUYkNHOrJnVAEcPb1?=
 =?us-ascii?Q?SxexjY2SPPGmJ4XOVSl8AsWdDS4WSYWtgTxK/O0iKOchJv7Lrq9D8vVOlyS1?=
 =?us-ascii?Q?HmGMq+1nqWB49QqDq5xkvJSs3oSf/wNGxwr+ULYfai+3avR9zAFp4+pR2R+N?=
 =?us-ascii?Q?6pHV0t7QfbpKrsHM08v6QqcZVA2/5c56DdZiougdFhGNus5bfQ6Qst60nhQ6?=
 =?us-ascii?Q?6Ft+/yBuFyx6eLc1RfCHfcxOA627JSS+V2Z2AoT6GUyoPMhfkoM0lqjkEpn4?=
 =?us-ascii?Q?eJ/zsXU6s8g88TyXUP/N3ot9W2hKTl/dcnA1PA7Q03iwiWf59TIbdV1KbY0K?=
 =?us-ascii?Q?gk5SnpxXDLqu22lvLoZk9O1HfxbsnJSLX414FeDIOWs/vicO8LoDVRhvZWAu?=
 =?us-ascii?Q?4yAq4rOx5EO2fPBroodS2bzd2izJk40E1D1blCNXRuw7WpQ2IVVpk5kH2Bfr?=
 =?us-ascii?Q?gJA0tect0hLgtO/2fjRp206Kyx8vHkZN5X+7ljW7cOb2841l9vq5M1gdsrdp?=
 =?us-ascii?Q?WHzRuDbwOfeeGUZsFgWaYx3d1zB00DS6n2q2nG2G9vi5N+XriYzPsGRQSinZ?=
 =?us-ascii?Q?yrNsW6JUFSI5NDXg2fogHCn1WndhNmK0MagaW7a5MHWsu0TjuWFsPaa5ZyWR?=
 =?us-ascii?Q?NCy47ACrbi/A0TXuMRGTlRV+lP/VgpquXoaTl9J5mRHD21/Wo23YOi9wZDh/?=
 =?us-ascii?Q?Ndy07bzoWg7a8KgS2Z5yS1WeozOMnYOLw+SA2LgdqcNirt1EXisptPDURmJd?=
 =?us-ascii?Q?aFuK25hOp9yhRISx7m3JtMPfkYOVyX/uNGXsm8/idWClTsWKN26/4GW3Ytfe?=
 =?us-ascii?Q?+7ihWk/g3kDevQsL0mXCXKSCtY4jBDFvAfgqudZ+pysHSo2081J7GlfKZs1Y?=
 =?us-ascii?Q?FqZfVAfEBWqt9OzdAUSYL3kiP0nwk7OWKPm8v9b3XypTlg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4CGCMhKFCCrKDF55Fwc6rtSWF3+XNXM8RzzNcEmIl8JYWmvEtzRFIsLfmONt?=
 =?us-ascii?Q?qMCN4dXqupJ7yeZGOYcYkjHUgByW8G1awxA3ESSv7eY3WxjIyLH4skU78XJp?=
 =?us-ascii?Q?L46xRPqvHr6CrPC5ZLk1u5GZzxr2dr4Ih6QvBsFxTx2QcXx4yG5qpXzQClnb?=
 =?us-ascii?Q?NIiemlHZZ8x7UJNBeUyNleEBeDbe2SJyov4eUBhp2LXodMcpoX3r0XJiLH9a?=
 =?us-ascii?Q?X0Z9NdYJJhK87L+9tDNoBYDnu/++2iKvaFZwEKM3cUFdFaI7Xv9aIIHRshzU?=
 =?us-ascii?Q?+wYJix1wk5b7pTBulwEb9sepmi6XgHddjOXuFZOzRvpJQf7C3jPX6UfPJHq7?=
 =?us-ascii?Q?BrO+jsNVhuABdtqc8DWD6kA5UXUsXJ/NzXsc+mHuRW8VBbJhnwRK9eXyWQUF?=
 =?us-ascii?Q?f+QMVvJ5Glqa1v8QRr2L06DCRJKTAc2xiuD/4VkjyR/Fb2Mn6JWGox5BjNtG?=
 =?us-ascii?Q?J1n76DcrZAP3QOfS/yU3Hw+R1rT4/+myhqpppHdKaK+eQSy/VPvt7yZvsUn8?=
 =?us-ascii?Q?3QrxjZtYWeJlsFYtk1+4sgtvvx5LsmzFVdyUc7tVw3aYm1t2rIx4FrWz6hwB?=
 =?us-ascii?Q?84fSFh+rvi0AmTSz1Or+THEegSYbJx4ISVvY/ApFTfPY/MvfFNuswMOy3mk5?=
 =?us-ascii?Q?M+mZqSX0MWRmP7eJJXks7FxVAEWIrqbsyFHEvJG4ei36z7iwgCjIQ0PT+vLj?=
 =?us-ascii?Q?JA2qB67GaKX477q3arMfUjVvZDwWu3mDLcT5faFzA8bn8fRJfSUNMl5rU0C2?=
 =?us-ascii?Q?wJGSOx1U7Eac2hCjk4nwXZxWPajR7hE8xdybwL7Q03Q0x2hbiNMEcVSlfgor?=
 =?us-ascii?Q?jQQ6/8TmmviVMdwalKXRUY5WHcreARWzrNZGEH6uD0zV/enUx/9wPujKun15?=
 =?us-ascii?Q?2MfZR9SJ5jyHxykgoSTyU6OJ4DuqAp0X3qzR/mO42gW+7pekqj+Thva4/iW8?=
 =?us-ascii?Q?z1YqeMw76ppSlY46ncyMGa4hDS/Jj1hn0c2EjY5EpSOwafl1M0MEDnfUeAte?=
 =?us-ascii?Q?hJv4FUZvaGviMOc47HCdecWk7TL/smw1fiKqPTOMFzHbbvFcsPZNGLbNrwxf?=
 =?us-ascii?Q?h0CZvaHNXDBBewDcNaVwY3/RkrojU7mM0YJQziNCmPk5lHWWIec42Gz+pR5v?=
 =?us-ascii?Q?4znOUMfddpA478XhX8tR9sjQu8aD4GYJ2Q01tw8eleiazOdMpUX04DBW7Pq4?=
 =?us-ascii?Q?EZpqMTRrvkXAlthFAJoa83D8ZJMBjBZQu2XM0JMOFktXwGUjwqbb3YRYiOj+?=
 =?us-ascii?Q?00MXjtNiG8HPdwH8bC/M18N2tUbaOJEKwUczpS2Asy4T+z0Ogk7ELz33kLDR?=
 =?us-ascii?Q?/OTiBB1rV5kFqNrnoI1TjT2s18YAQKql7brKSlYM19w8Un98YOp24LIiLD9O?=
 =?us-ascii?Q?VVNIGwM08eMdbRq6UlNPmKUyfcOx4lIT/NFIyJa6PpickDq8Fkgk72GryC7b?=
 =?us-ascii?Q?xYfRxuCMjY+6wZeHT5RMa/7XION9ydLTBPwzArsohNPAb6WoXajoN2h84ifJ?=
 =?us-ascii?Q?Rn8OdZDft/2R9d17/zmCgcmwJ5wJbgzF+CNtGGtXiWhRH5t0Y/WpLul3sLum?=
 =?us-ascii?Q?wQF9U9BDCv/dAsVeLY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47954f75-92fe-4ee4-b367-08dc73380b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 10:32:52.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2ZMktpHmXejbgahCSGJe/Yah7C38/dd5SoGxqtoqsLyKOJWMqQbJrTtwqVzLqTmitKIL5wQuApxmwc6hZevtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5082
X-Proofpoint-GUID: 3xGVOLej1-in457NNPMEvR2oKAoQvkMN
X-Proofpoint-ORIG-GUID: 3xGVOLej1-in457NNPMEvR2oKAoQvkMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, May 10, 2024 9:03 AM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v4 09/10] octeontx2-pf: Add
> representors for sdp MAC
>=20
> ----------------------------------------------------------------------
> On Tue, 7 May 2024 22:09:20 +0530 Geetha sowjanya wrote:
> > RPM and SDP MACs support
> > ingress/egress pkt IO on interfaces with different set of capabilities
> > like interface modes.
>=20
> This doesn't explain much, what's "interface modes"?
Our hardware has multiple MACs RPM, SDP and LBK.
Also, hardware doesn't have an internal switch.
LBK is a loopback mac which punts egress pkts back to ingress pipeline.
RPM and SDP MACs are the ones which does IO to outside of system each suppo=
rting different modes ranging from 10/100/1000BaseX to 100Gbps KR modes.

