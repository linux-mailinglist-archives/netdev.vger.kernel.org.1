Return-Path: <netdev+bounces-283650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJMZLuqR92lhjAIAu9opvQ
	(envelope-from <netdev+bounces-283650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBE4B6FA6
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14E263001A64
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B73D0925;
	Sun,  3 May 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DkTNkRbx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948453CBE84;
	Sun,  3 May 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777832421; cv=none; b=LuMR0Txdf+VTIDAPD4HSvytR0MM4Z8m3FuifXG3+dyCpDsX8IK4F6AewT0WdAs5nicAckAUEJ/YICC+n4mMjhpSle+EZ4m7A5KphLCDiuWfe/8pRtViZ9lwocHjTPYwO9iSeIJNvvPhZJITtt1TsJ6h+d9Wg3fjzTIssOr7IzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777832421; c=relaxed/simple;
	bh=RzINv7C0Bv0GAZFB5TSWPEzlVeYBlX2l1W7C9mocVc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eu7bEAzB7z5Bx7zbV+LRCzuNmMToGJM0yn63gtc18Jzh30uQ2JoSF2oXQhNcCubhapcMIcLkyhDjzQ6HqTPAo7MHaHsRGHt3+UpDWGjCLMegzGiktHcZ5i/HVWK32SN7d825WEl7M+Fs819elPGbMszad0IiV+1xAlvtr48/s0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DkTNkRbx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643D2mJI025250;
	Sun, 3 May 2026 14:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4vAO4
	415P6z37caL+yzayBA15C5TCwbTNDHqi2x4iAw=; b=DkTNkRbxqOji7nLgCYIPc
	oVtHGn5pshnlwpRb5oQ3m5PXcClyM1ytZR90V4Bys7q4dEnQ5Al0iB4OsHC9FDPY
	icFEAsZKTmJZV61ZwVX1yT02itp40eBRU3Jb3MGf4ZFlCZjRqw5N/aLg1PJ5Q87d
	6XQyr9TLdH4Zcf2HX62DXvts9JK+u53GqQliJ+lFxm9BXRp4CaUYGFM6P2D6mQSm
	N++rWCna8o1y/zWiRxayo+PL6wGli4TklSCLP53hZP4EGV6479nU3tqnzK5JCLe4
	4RSwjlB71Qqq93EDz7a6SlFnsF96DMDsnHCScb+HCRi6t4l3Xbr7JepW0+e8UaEO
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dwe6137nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 May 2026 14:19:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 643IJqf2000698
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 May 2026 14:19:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sun, 3 May
 2026 14:19:52 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Sun, 3 May 2026 14:19:52 -0400
From: "Regus, Ciprian" <Ciprian.Regus@analog.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Thread-Topic: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Thread-Index: AQHc2osB4TQBSYFAe0qN63YeObU/GbX76fKAgADDcYD//+2AwA==
Date: Sun, 3 May 2026 18:19:51 +0000
Message-ID: <ea6dfd64c0314bfa9c8961ec36d77f33@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
 <afc1cf8d-4a02-430e-89a5-b213c15a4f70@lunn.ch>
 <0b09b317-0a21-4b9f-aba9-0b9caa14c0d9@lunn.ch>
In-Reply-To: <0b09b317-0a21-4b9f-aba9-0b9caa14c0d9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAzMDIwNiBTYWx0ZWRfX0QD2cBPDm6w+
 o8JHB1kAGrYQoNLXkzO6kjwSTYmscGXQl3+6k1HVz++GfgX6WszOxiEhYqNO5Db9GRyf4Rj0ipG
 zL/eaeyoWs6Lr0NY2YDzri1Q3DPT/ZIWaGnGLtjavmaVZ3ZfuO328tp6pE21TSPZcLFAr+zqhvM
 jU1pG3NJeOiq0MmvMFQRBoo6FNNRGmTYenp5S+6/KRQuhk7es2DCtFohwZ8SVJ5ycEspvV+rIre
 qTsVJpsl0KTKpX2vP86cQ5clpm6rF2I8BkDSWypqjLV9u97cHafrkFYDJYjstIIk/y2oxTyscMF
 CAW7Y7gHBaFt1xDYrfSp2AW8kNW95NK4Oaem+jdhptYPPJaB1hF4HQSvE4MHS+rID5a4FN9vaso
 r7ln73eY5zykMrNGEWQB705EsNvP1dwAbiZor+WTtB9mIbp1aFgUvgR7lT5mFpPrRxAw/oZf1xy
 tCf2EQ77QcNNFYFD1zg==
X-Authority-Analysis: v=2.4 cv=YcONIQRf c=1 sm=1 tr=0 ts=69f791ca cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=HAm-ab27MHsA:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8
 a=pGLkceISAAAA:8 a=PHq6YzTAAAAA:8 a=KytjqbFpDIeuf0yDoPcA:9 a=CjuIK1q_8ugA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-GUID: lkPE0x1i-LLgqNZl4hFLc_cClK2-IPfw
X-Proofpoint-ORIG-GUID: lkPE0x1i-LLgqNZl4hFLc_cClK2-IPfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-03_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605030206
X-Rspamd-Queue-Id: DFFBE4B6FA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283650-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ciprian.Regus@analog.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[8]



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Sunday, May 3, 2026 6:16 PM
> To: Regus, Ciprian <Ciprian.Regus@analog.com>
> Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Shuah
> Khan <skhan@linuxfoundation.org>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for th=
e
> ADIN1140 MACPHY
>=20
> [External]
>=20
> On Sun, May 03, 2026 at 05:36:13AM +0200, Andrew Lunn wrote:
> > On Sun, May 03, 2026 at 02:24:53AM +0300, Ciprian Regus via B4 Relay
> wrote:
> > > From: Ciprian Regus <ciprian.regus@analog.com>
> > >
> > > Add a driver for ADIN1140. The device is a 10BASE-T1S MAC-PHY
> > > (integrated in the same package) that connects to a CPU over an SPI b=
us,
> > > and implements the Open Alliance TC6 protocol for control and frame
> > > transfers. As such, this driver relies on oa_tc6 for the communicatio=
n
> > > with the device. The device has an alternative name (AD3306), so the
> > > driver can be probed using one of the two compatible strings.
> > >
> > > For control transactions, ADIN1140 only implements the protected mode=
.
> > > The driver has a custom implementation for the mii_bus access methods
> as a
> > > workaround for hardware issues:
> > >
> > > 1. The OA TC6 standard defines the direct and indirect access modes f=
or
> > >    MDIO transactions. The ADIN1140 incorrectly advertises indirect mo=
de
> > >    only (supported capabilities register - 0x2, bit 9), while actuall=
y
> > >    implementing just the direct mode. We cannot rely on the CAP regis=
ter
> > >    to choose an access method (which oa_tc6 does by default, even
> though
> > >    it only implements the direct mode), so the driver has to use its
> > >    own.
> > > 2. The ADIN1140 cannot access the C22 register space of the internal
> > >    PHY, while the PHY is busy receiving frames. If that happens, the
> > >    CONFIG0 and CONFIG2 registers of the MAC will get corrupted and th=
e
> > >    data transfer will stop. Those two registers configure settings fo=
r
> > >    the transfer protocol between the MAC and host, so the value for s=
ome
> > >    of their subfields shouldn't be changed while the netdev is up.
>=20
> This device is pretty broken. Has it been shipped to customers? Is
> there going to be a new stepping of the silicon which is less broken?
> A new device to replace this one?

Hello Andrew,

The device has been out for some time, but it's only now being made public.
There are customers using it at the moment. I'm not aware of future revisio=
ns
of the silicon,  but I can ask further about that.

>=20
> 	Andrew


