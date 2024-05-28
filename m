Return-Path: <netdev+bounces-98427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33F8D1646
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1817FB22F8C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9813C90D;
	Tue, 28 May 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DNOBUHha"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B313C8E0
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885095; cv=fail; b=bXK9Ieg1xvLXt3hjvl7jb4XkBqRUActegTj7NrOidneqOZbv3T8mWV9wRB+ni+ZjqOv3967G2yx3rgcBo+aMIM+oUV6flXYRX0NwfqcbIWo/knoa6moijEVIIkcrGLmqtM+/d+xnRJwqniJIe9ONVM3T+mRN+5Dxuw7tCZby+hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885095; c=relaxed/simple;
	bh=Eonx1kePQPxkqUObMG+rsK/IALg3NyjKc2vGzrJpLhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/kQqhzqGd3sgS9BydX853DlJSXBJYRaxSFjg59s4YxUQO4mTA8pTnOEdx8KpdqFOh8H/Mo0hssf6fEkA2urNGGmlu7FQnalXQLPiHrypma3VeHG5A+VD8sXPnF9pItsO6OZlvgIPPvoXhcwzjBe6bnh0AyUtIiydoh+bPG802o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DNOBUHha; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RMp0Ea020110;
	Tue, 28 May 2024 01:31:11 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ycqpym1mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 01:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLC25ulshzkFA//lbIFC/ODNVcWAib0Rx/xzPOa4om/og7lI+Q0xX4Mp4PRnWMDJPsqhuXJaaM4S5MYnNXGZX2aq80rISyoNqwt2UJicrVFL7A19UBuRNUuPF2YPgkhAPcsjl+2V20DEHRmYF7LZkRh7y/p2XPhtawd7m8B8YJvEd9LhszmBZWKQFp2SlNGgB6ekS63CWd80NV6StaLoi91nq89qwuuiFluqq5zBUBleD3K8mDoCcS/tOzVzzelcN96SeJVmzSejABgjNammwyN6DIg2UagS2t9C1n+2qNt+fi55j7Xq5VmJ0Yv6UxIzaW5tjqxfNeoyLZirCEfjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5KJopoD0SstXBfPj68WktIkqkCMGlARcfiIqXH9vjo=;
 b=OE1hGQko2TYgoE7XUfwQ/4cCEyt+bOpNVQw0e7pb2NkhKGC/TSnB+jkDIPfQRnGiR0hmiTUUmYwf4T4t9/ys7Mq1aJ2BGNQklFTt1Dsj6gHiKuLE7BPeRE2kdhcQ3wgDziInChQaZ7lIotMgvhlbWYi05IFlnPWNiOp6AMVBD09JpudIKb01AhswtAHKDtmB55fxySosEwfQlmGTEz6ZPxcR4LzgLwDY04pEqL++c1+8PVTiduCRTig4FKS3OkzW/bRnrEcXfbUYZWBqx/pg7QbEi4V6+JcRjPEoXFbPUsMsdIqYhUZ6ryyQvA82HRoJxkvPST/Dt7HSU5xdeCOn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5KJopoD0SstXBfPj68WktIkqkCMGlARcfiIqXH9vjo=;
 b=DNOBUHhaagkmBbPNrPViTPDj5WJgqYPRmAUY7A9Z6Xnjx9g6pviXvSiCll583iMe+G0FUf9yuaEa7FyexHMByo46zNJBc8uGS2qzS0L7afudRUySz9FVA54MlzWLaTPSF9Xhx4OPFujWQE6Vh3eubst3wrvqMdXjYOBDPEIB708=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by PH0PR18MB5090.namprd18.prod.outlook.com (2603:10b6:510:172::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 08:31:08 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Tue, 28 May 2024
 08:31:08 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Heng Qi <hengqi@linux.alibaba.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net 1/2] virtio_net: rename ret to err
Thread-Topic: [PATCH net 1/2] virtio_net: rename ret to err
Thread-Index: AQHasNljQsuqlYrF1UW+LF0LtgxUxQ==
Date: Tue, 28 May 2024 08:31:08 +0000
Message-ID: 
 <PH0PR18MB4474392FB2C0EEA2085C1E71DEF12@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240528075226.94255-2-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|PH0PR18MB5090:EE_
x-ms-office365-filtering-correlation-id: fefb5714-3ac3-4d30-8d26-08dc7ef085e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?7qySqJj7+/ebiXNbREIojkrNgI/whTo5rNKTKgtpHtjO8+Fw2kIQbfpxV6?=
 =?iso-8859-1?Q?+eGGDRc4h8xzvoJpyzpgC19PiWc4fydRjBrXuRuo+OhZ7Zd2+Iso9WlNMp?=
 =?iso-8859-1?Q?TTtHha/IQXUUf/q8ESv+8T/HIBvjD3HP+xsrOxm0gxmFUvPJ/km9iOLYvr?=
 =?iso-8859-1?Q?Nx77J2uT6oMBHNbq1WBpgPZlaBil3UlQclXmTLhZmoXvGSUMz7whn/1duo?=
 =?iso-8859-1?Q?HoeJYIexoJElm/zHCTUuhcrEdYh7SNNX1GoLllDlOJXiW4z2Sx2vXQYZUy?=
 =?iso-8859-1?Q?15bbead6AZewrJvDZDYF6jc8/bZ6Hy93Ec/UgKE1ht5+A4xfuGNL6NoIE9?=
 =?iso-8859-1?Q?P+quldfSZZVHyXIOIpXo7BSGVcFCZpi8R5+HH8Y6x+Oi9CzirRYN8OZIpD?=
 =?iso-8859-1?Q?i3ipfnMdJXgP0B4yD6e3Re5cgq6ab7RjCy9UNkjnVV1yDXDm0aOaV/1GQz?=
 =?iso-8859-1?Q?NXCMOljT3X3TL7sAfUd+lHDWRKPT5HQ12stacDcevtoSp5EVG1NA6v5zI0?=
 =?iso-8859-1?Q?M5VlftMhXXS6j/JJmY+7f5HeWa+Mtg8xPhVjC7ywkfMRheuWEhqXcHwsbO?=
 =?iso-8859-1?Q?3ZmqJMmXYqmuHfOJe9eEsWQNrZ6qik+4CTcHw63FMauwniFZF1JGksbspb?=
 =?iso-8859-1?Q?Xi+LynKbIKdBGw1NAF0aNXXmZy0W+gHC9zU+xJ62KSs1CIhMHJYh7WsNLw?=
 =?iso-8859-1?Q?GSjJRwA45VYntHtWjeiGDEabEp7Uo3lHOoCULdnSt438MeDCiLWvjyfrHn?=
 =?iso-8859-1?Q?8HPEMnqWTTR5EhcF/Vn96J1sCmZ07Obs7FiI/6jDFAAsUrWcPbZCVHI9zl?=
 =?iso-8859-1?Q?vbxNFoIecLcjb7CDCI6zFJi7fz9GqKjg17XeNGQm26N8tF3aTrX1EuNyW/?=
 =?iso-8859-1?Q?s9w5UpwUdXtT35mbA5jcvCkZtyHCjaCiKxZwQzmka7oOzdkMGi/jmvbRSy?=
 =?iso-8859-1?Q?N1lq14rq6P+Jo68l0nZuOKaDwQM6haXtazLblpctTTpgfFTu6FOZgiWKRq?=
 =?iso-8859-1?Q?+sPmufln8bcN7UNLSX54LhMG6BbCVqq9FKl0OBZZDihFPxO/iNcFLRBnxs?=
 =?iso-8859-1?Q?9C3bP1cbNwxjXETueVR0pJukM6Dw7g3ZEVS9QIi3AVCgmj/Gad6E/ablKX?=
 =?iso-8859-1?Q?Ub/X9kuQhiU8E3JU/d/mPg+HgehE4n48HuhVobk8OKIMXIT4/F6+u7t7DX?=
 =?iso-8859-1?Q?r1WtRpOA8qwxwrVC/ww3OpR5LoHDksNuwDw+6+kXKOgdvJa1JqPJZ01+Sw?=
 =?iso-8859-1?Q?NiH4sisPOdMeApa8uuFRFyNrhOyFp9e0Ru6TK8FylJT/lR08kxTcTh1vV4?=
 =?iso-8859-1?Q?R6KTS0KFDnh6TPnGYbVpO91yH/dIl9V5e8laIiY4GhrQ4Y9H7ewRJOP5tU?=
 =?iso-8859-1?Q?5Wvxqx600vvg4qozsHW3otFXRnaXFuTw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Z0YMvYvetWKg5xPaYE/2s9/nNWrMJzo3c2rxvOU+pM4TKFpjFLruhG+5Ip?=
 =?iso-8859-1?Q?J8TwGAqEjWfZgV+L+V0no2vJPwr0uT/jDbqd0A66f8pxJ4XWdgzeBQpdHd?=
 =?iso-8859-1?Q?MpK0msYki267VIOVBc7M8YkUDtPk75Fj5C8JKUCiRjrQRpDC6RSf2AvqjC?=
 =?iso-8859-1?Q?aMfd2oqgdCyW7biAS5oF0rDnLYHMt/LEdlt5LrqxePqkfAb9JUAr7q1XdQ?=
 =?iso-8859-1?Q?vbJAjLuzf+M7rL6UHMyKtzmANxULztYEUlUAchKptl1AsDnYSa4ch4E0NT?=
 =?iso-8859-1?Q?5gi8tIUauLGik1JFThms7VBJbqFt9K5eTwBorhosUmm5KFg1cLo/GjFB2u?=
 =?iso-8859-1?Q?15zCC6G9LHNWafBHb4wGYCyUS7AtkqfgtqbRx0iIfZvEHe6nW9L+GByLzF?=
 =?iso-8859-1?Q?FMe+mFHZqsxLd/WtTPHAx01KEA2wL4fzKwHTRs75QT+hxuqfPQuyW/hnMH?=
 =?iso-8859-1?Q?MJxm5gMRn21aGrMocpCQicOtCnlBDMzMTc/DyFhDf85Mec4aPx47Euz9Vx?=
 =?iso-8859-1?Q?AWbLIuVnBBVJhhxlkNQDy2hZo7H1KN/Fzl3TyCohgEg7vsQx3nm7tKF9Al?=
 =?iso-8859-1?Q?ChM6FjnMK7wuOCFx+A2ZGV2TdGRJkhX9qGMzWOmqsJaycIH9kizrpq4CFu?=
 =?iso-8859-1?Q?Hx1KN1L07esdd9TMNGC9QeptL6ROPkOtECbXYS8pWRv7sHQhsU+s8Z3ctJ?=
 =?iso-8859-1?Q?PM6fhsj2/nYKiqWmH8n5nqBqMJZZhbv2CP5+mNrggnL0iZw7Y0yy+zeJyO?=
 =?iso-8859-1?Q?vAx/BSREU0VAqpXWWiLneuje6zCJ6FMFGgXn3xgFvV2bDAwANlpGJj9Cq7?=
 =?iso-8859-1?Q?h2DZO3Kc08IV3htNUABdLoCrOV33duSOvMoDd12M5PreQ+y8zbjGOMr7Ar?=
 =?iso-8859-1?Q?Ey3ZDR/pbw9vT4szXoBzsP2TwwoOy/LHanKq3B8gQjGlui0AVS4fpn0+J+?=
 =?iso-8859-1?Q?tehJlyD1ptPaxQMW9miO1TANPRea5HoBooekVryc3fxNqLSUrqBeSlfnNH?=
 =?iso-8859-1?Q?WTF7me8X1wkMbEFYUWjnnvaaA6cshIi6j4OFizg1FtYp92vYZJ9AXLwYwS?=
 =?iso-8859-1?Q?cgYO3pJ6le9cyBtYYlqNy2P/5Au4Y3hbm4/keQ8dJXvWmAyugU8QMYXpsK?=
 =?iso-8859-1?Q?GW/dlSV+Pyv8GgilkinI9lXC0C5mL0hsWoWwJ4lX/+uC5cUp3867fjTpOK?=
 =?iso-8859-1?Q?Ky/kqJCU9lSKAWWke09cGULIgG2DisPV1YCHnnHmnl748jWxuiyw4SgnmL?=
 =?iso-8859-1?Q?VksGQ4GXvNSAUkqV+74OWIzG9v4bOl1ZgiAcJOEkrcxrN24zcsFiyk7fCm?=
 =?iso-8859-1?Q?y+demC4wkq5yUR7d9Mt0ZkGvkhm1O39+vMskFF/Ch4S9uSCzWqkpYSTM46?=
 =?iso-8859-1?Q?5lJNpJIQYlp/st69q6tj1Dqwte6t6FWMjLAhBYqpjnDvYSnnSAr9jEcFMq?=
 =?iso-8859-1?Q?ZedLbqqCimV2oG2DwN0uHgPJByQvYi1CnToQWhMIEHl8W1moJ3saMrjWZ1?=
 =?iso-8859-1?Q?37bSjowKGyAb0xIMU5fni1ijjV4hZTaRUvFaDKk2/kiB4/CoQrTz5i/NZF?=
 =?iso-8859-1?Q?6SYZwV3fw2/w/lZZ1P4EGLazzcwwysU6wSFERni3WdlUTO7TpJ0rHS22Qd?=
 =?iso-8859-1?Q?k/zvdSSCQs4aU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefb5714-3ac3-4d30-8d26-08dc7ef085e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 08:31:08.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BODbXNKtH9XRaDSFftaGyBqJkHk9KAmCSY+MVwmVb8RI/1Zyc1ULpCk2RE7OFgrr4N6GuEQvh48r/OIAuXIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5090
X-Proofpoint-GUID: lnpI3bJ4UIuurt_SxAasraVFylAVeY9F
X-Proofpoint-ORIG-GUID: lnpI3bJ4UIuurt_SxAasraVFylAVeY9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-27_01,2024-05-17_01



> -----Original Message-----
> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Tuesday, May 28, 2024 1:22 PM
> To: netdev@vger.kernel.org; virtualization@lists.linux.dev
> Cc: Michael S. Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>;
> Eugenio P=E9rez <eperezma@redhat.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Jiri Pirko
> <jiri@resnulli.us>; Daniel Jurgens <danielj@nvidia.com>
> Subject: [EXTERNAL] [PATCH net 1/2] virtio_net: rename ret to err
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> The integer variable 'ret', denoting the return code, is mismatched with =
the
> boolean return type of virtnet_send_command_reply(); hence, it is renamed
> to 'err'.
>=20
> The usage of 'ret' is deferred to the next patch.
>=20
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> 4a802c0ea2cb..6b0512a628e0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,7 +2686,7 @@ static bool virtnet_send_command_reply(struct
> virtnet_info *vi, u8 class, u8 cmd  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num =3D 0, tmp, in_num =3D 0;
> -	int ret;
> +	int err;
>=20
>  	/* Caller should know better */
>  	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> @@ -2710,10 +2710,10 @@ static bool virtnet_send_command_reply(struct
> virtnet_info *vi, u8 class, u8 cmd
>  		sgs[out_num + in_num++] =3D in;
>=20
>  	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> -	ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi,
> GFP_ATOMIC);
> -	if (ret < 0) {
> +	err =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi,
> GFP_ATOMIC);
> +	if (err < 0) {
>  		dev_warn(&vi->vdev->dev,
> -			 "Failed to add sgs for command vq: %d\n.", ret);
> +			 "Failed to add sgs for command vq: %d\n.", err);
>  		mutex_unlock(&vi->cvq_lock);
>  		return false;
>  	}
> --
> 2.32.0.3.g01195cf9f
>=20
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

