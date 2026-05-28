Return-Path: <netdev+bounces-292769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULf0K7hzGGq4kAgAu9opvQ
	(envelope-from <netdev+bounces-292769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:56:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DC5F54AB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D527A313E1F5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2693F86F8;
	Thu, 28 May 2026 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xaqIWKXT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99FC3F7882;
	Thu, 28 May 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986847; cv=none; b=MbbDhoBJWIvH307IFkkVzpyfbGyNthpXaci06jfOm5RTqGcY42B+9cxlVfd1SD87XoMEOVyV7LIYXfwm49eL/lKlxdi+0anhpchqwX6tJ+Y5dDjVF3bHoWXtR2Y3anzresPL+jYRvynqA/D5CFTx8msNrHAu4KB/UoqCBYQrzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986847; c=relaxed/simple;
	bh=wj8hahdPjkjzs0jnbz5LUaTyOITT60B/vUVZ99xZNdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZeYmNqjgXgVWZRPzm46v1HPYPjiTVbURsAMqse0pjGvNiFl/JTZPhWHAGCEUMlt/BTMNaQe7K6/xc72J9XiMRiCC9aecvSsu3l3gqERY7fBfYgLTMZOqCDQQkut5cEXTkJziWv9md76wtipTYUOdxj2wN+SedpYF0XxJ+575QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xaqIWKXT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SFD0xR651297;
	Thu, 28 May 2026 12:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kdmrn
	48MzzK6aj62vBc2tYZtNhaJS0IKAmCJl9WJqDY=; b=xaqIWKXTWYtKTHImJ37pG
	qMf/rTHDC5VMZjHHNTYcee31OR7RUS2YyVnG/PEpaA4MeoOmD50FkoiS8rYfj8GH
	fVsPReYVfk9+v5dsg/EBq0glSbyP9m3ZUhqZzhC5GuZwN8XZULXDkdy5yHvFj1ui
	stpQWkV5FE3wjeTruL7gTxwHFtvVftGeoGK9ckLVYtKMjxlYzWXOIWPlpC4OGT0V
	EhIjRPoTWsUZyelemtOxFKrq5srA0b6S9AvugTsZGSFnFLHCS9+ImA4bqmg+2+zP
	kahYy2GbLuw/kZMkKzg2cx03llQ2c/CrrFG/1yZTsvqdQl8ZHKUFKUFqk6S4k85N
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x43mh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 12:46:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64SGks4A018582
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 12:46:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 28 May
 2026 12:46:54 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Thu, 28 May 2026 12:46:54 -0400
From: "Regus, Ciprian" <Ciprian.Regus@analog.com>
To: Conor Dooley <conor@kernel.org>
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
        Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v2 01/10] dt-bindings: net: Add ADIN1140
Thread-Topic: [PATCH net-next v2 01/10] dt-bindings: net: Add ADIN1140
Thread-Index: AQHc7Vny63pu2ZCi3kqLvdxOu2lQULYiPpIAgAFdMXA=
Date: Thu, 28 May 2026 16:46:54 +0000
Message-ID: <925d1903a01a44d8ac61b1302a820e6a@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-1-37e5c8d4e0a0@analog.com>
 <20260527-nearness-antacid-9f94a3f43abc@spud>
In-Reply-To: <20260527-nearness-antacid-9f94a3f43abc@spud>
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
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a187180 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=SuJlEMG_fVsA:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=sIgrHmZHMssAOK1AOucA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2OSBTYWx0ZWRfXz0PddYfaVPdM
 dMPUnjnf7uhONk7kvCKdSTwP+xQdvWkrDrn4H9LpR1mMv8jxdOeL3X0o5CZ0Wbzyiy0pIrAWynr
 7DuUlAr1jxHDdWAJD0wxqYbT5CbifgGTL4NzEvUcMxH1mbwY05pDvCJq5rXWujgafAsx3Jr6Ukp
 /+ma6iLTh2XDkYY6qR++SQN8/HMA8geTVv/Pitj4hXfgkKd0SVUimSJFv8TSX7G9GDI4o81lW/y
 d+2Ttp1Ty9ehBaSwLVLwuD2eQVpBdrSN2PdXVgU9pHwoGxM7gMePOyZKymetB8NejqW0FFpxhAi
 w8akKbOEyjmuU3PWJ3c3Mv1Y+VA6QRaIVvRPpdDxW4qZXtd19XW+kF4QvkzptfGA/77T9savigG
 mVUsvFvOC/D9Bgas9SF4xK7OaAkp2hQ/I69p8ruybJst4zKNDIqKBcd5fRKTMqn/2XndNCM+M9Q
 oTzgvhhx5a0uEIJmjFw==
X-Proofpoint-ORIG-GUID: BEBfjRElMlo2w4rmdkKDmR3t-kiiuZlj
X-Proofpoint-GUID: BEBfjRElMlo2w4rmdkKDmR3t-kiiuZlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280169
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292769-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:email,analog.com:mid,analog.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 111DC5F54AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +title: ADI ADIN1140 10BASE-T1S MAC-PHY
> > +
> > +maintainers:
> > +  - Ciprian Regus <ciprian.regus@analog.com>
> > +
> > +description: |
> > +  The ADIN1140 (also called AD3306) is a low power single port
>=20
> Can you explain what is going on here please?
> Is "adin1140" (which I can find no information easily online for) the
> exact same device as the ad3306 (which has an entry on your site)?

The adin1140 is an upcoming version of ad3306 that lacks some
(stress test) qualifications, but otherwise they are the exact same die.

>=20
> > +  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
> > +  and all the associated analog circuitry.
> > +  The device tries to implement the Open Alliance TC6 10BASE-T1x MAC-
> PHY
> > +  Serial Interface specification and is compliant with the
> > +  IEEE 802.3cg-2019 Ethernet standard for 10 Mbps single pair
> > +  Ethernet (SPE). The device has a 4-wire SPI interface for
> > +  communication between the MAC and host processor.
> > +
> > +allOf:
> > +  - $ref: /schemas/net/ethernet-controller.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad3306
> > +      - adi,adin1140
>=20
> Because if they are really two names for the same part, this compatible
> setup makes no sense, as it means they have a different programming
> models.

Since they have the same programming model, should I just keep the adi,adin=
1140
entry?

>=20
> Thanks,
> Conor.
>=20


