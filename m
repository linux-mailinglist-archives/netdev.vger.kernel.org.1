Return-Path: <netdev+bounces-283719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLBnKANM+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:34:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F27034B9655
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A2430036D5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2BE2EAD1B;
	Mon,  4 May 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I0Qu+iPX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2D2D8773;
	Mon,  4 May 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880020; cv=none; b=rFopUNBlgg9FmtTYmOdODhX3eOprtuFREEt6q+YcrfZWnYylDpOdA2wxP0ACnaCXUsOMoSUm32qUzQTWCg53gzXgSeZuFVQBpNEDWhjddGykwGm1xnixuGsGta38cSLYX4tiHy40fyPuMxoEoBeYZgqAQpjwPu+5tT8gJ/sWTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880020; c=relaxed/simple;
	bh=nj/gyh8/0xeNDHGQe0jUmgUeXHykSC87gB+hq5RHShE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6DePlT4qmmnu+rTyBbMOxxJpJ38IY6DV6DUzWxY+rYH7+bjEG+z7U+kQrWI+ct3OLGe01w9n6sLHzaSvJwjrVcTrliI5kEnbAloNbUfA6ERAVflRKUDFZjoJb0sBJvuYOj3Wn5BUHutOqu9mphn+L8ES/3+ki1TI+8o6ailtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I0Qu+iPX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6444W3kk3187816;
	Mon, 4 May 2026 03:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AI3ls
	Oz/mnkGP/99TOdM2pqfylcD0JQhmOiU3HlVvhY=; b=I0Qu+iPXa+HFE/ho2X1x9
	DCsZlfMMYnxuvSy74sj9PwrO5F1lf8jNeG6O0Sa4x9SmtZEGu9A3xkTyupViOTIy
	GMvIBaQRILXQpMDyiTbs1OuSxK2zafhH8U1rJ8gJR/e/FzXQQX5kTIg52QkCbmDF
	fUlYSRArVEIm/FWmsd2NvFgUJLb3r81CJEANEa/Ku8041YB4d05d/aSCXF55XOQu
	JV8evIWl3MzqMUwSh7+MqHM5Y9pdtGJ3pOSXZZv3YHaCi/kb5xC26l848sn9t2sj
	9RvlB+QfpCRkRp+0k2cVIaEubbQzvVqBzSFukC+SxtAWRwsnfGwao1GRLx2Bh7ql
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dwykcuqvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 03:33:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6447XIQR024594
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 May 2026 03:33:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 4 May
 2026 03:33:18 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Mon, 4 May 2026 03:33:18 -0400
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
Subject: RE: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
 ADIN1140
Thread-Topic: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
 ADIN1140
Thread-Index: AQHc2or/QxrFK7//pU2lwXwyxy+GxbX7wD0AgAG4FvA=
Date: Mon, 4 May 2026 07:33:17 +0000
Message-ID: <2de08ad6ba73477299b6aace38b6de4b@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
 <05ae6249-1f40-4530-b2dc-e52e4f454c0d@lunn.ch>
In-Reply-To: <05ae6249-1f40-4530-b2dc-e52e4f454c0d@lunn.ch>
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
X-Authority-Analysis: v=2.4 cv=VI3tWdPX c=1 sm=1 tr=0 ts=69f84bc0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=h1frbD_qhcwA:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8
 a=pGLkceISAAAA:8 a=PHq6YzTAAAAA:8 a=Wu-g9ui8VkVapFQWFIUA:9 a=CjuIK1q_8ugA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4MSBTYWx0ZWRfX9wSLUIrakRQL
 65IwVdveu0fnDtPXv1RSEhUi5pUiyoKDjrOSOu3Q+vJGIs9jFe9+KiEiZVIoHxS//WqQMyNgAiN
 BX/0Mzoms6rEov2EPz7lZNRneCzMVf7svx9x8RtaqOibqHsUdXFCE+0c5jNBuByrl6/lWamqCHB
 ldUIcDM1JNEPlUl7e8yIwkPQfD/g7dVqCYtA9EDpjMwEv+nV1VGJIpo3X5US/itqq3h5LdEa3Oj
 j6hqbtUo4g3GHr7N02krgbgHnEtUKfrJpzAYffDiiiEeBuCydEZ5uyHkz4gw1fktPQFJZW2Llro
 5i7eiYt8giWPr4nizust5wSvKXYD/90uqf0q8p41+ae9rOs4+KF83/9+gxqA9M2O56VrX/KD7C4
 O3nWAsBG3LHr+Okj/4QPFzSynoSKH6u4BmI22BAT2ngvEfW8rQxT8ZR5f7jnvu7BAUqOlDh8fhQ
 ISwidj8gSpqru6rXCtA==
X-Proofpoint-ORIG-GUID: G8HF5C-YTzTn4d7V2lN-cDMZcicKKfdC
X-Proofpoint-GUID: G8HF5C-YTzTn4d7V2lN-cDMZcicKKfdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040081
X-Rspamd-Queue-Id: F27034B9655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283719-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[analog.com:s=DKIM];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_POLICY_ALLOW(0.00)[analog.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	NEURAL_SPAM(0.00)[0.493];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ciprian.Regus@analog.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Sunday, May 3, 2026 4:07 AM
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
> Subject: Re: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
> ADIN1140
>=20
> [External]
>=20
> > +  The ADIN1140 (also called AD3306) is a low power single port
> > +  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
> > +  and all the associated analog circuitry.
> > +  The device implements the Open Alliance TC6 10BASE-T1x MAC-PHY
>=20
> The device _tries_ to implements the Open Alliance TC6 10BASE-T1x MAC-
> PHY.

Will update in v2.

>=20
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        ethernet@0 {
> > +            compatible =3D "adi,adin1140";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <23000000>;
> > +
> > +            interrupt-parent =3D <&gpio>;
> > +            interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
>=20
> Table 1: OPEN serial 10BASE-T1x Interface Pin Definition
>=20
> IRQn MAC-PHY Interrupt Request (Active Low)
>=20
> Or is this something else which the device gets wrong?

The device generates interrupts correctly (the IRQ signal remains
asserted while there are active interrupt conditions that have not
been cleared yet). The oa_tc6 driver requests the interrupt with
the IRQF_TRIGGER_FALLING flag set, so the DT flag will be overridden
and the behavior remains the same.

However, the devicetree shouldn't care about this. I'll update to
IRQ_TYPE_LEVEL_LOW in v2.

>=20
> 	Andrew

