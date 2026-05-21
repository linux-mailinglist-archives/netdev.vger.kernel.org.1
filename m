Return-Path: <netdev+bounces-290603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGDAAitqD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:25:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 961EB5ABBFC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64B663011C49
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C141C2FD;
	Thu, 21 May 2026 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jZD9SlwE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737E40FDB9;
	Thu, 21 May 2026 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395105; cv=none; b=GVwD5DL13l1N93lYu7QVki0OIjeIMHb2dB87iQqENTcAChm/gNAjw1efXPNg5pcEQ1k3grgiV7QJZUzoRXQ+bo4cnI15R7Of63Q3b7Hk44b8CgGfiHCPU1kyw2NBRUCXHtrRVl8hd2BtzBhK4LI/OhOvxCNhXkWAzxOUOk7dF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395105; c=relaxed/simple;
	bh=VBJblbfRXVasXmc1tUXRza74fdyKHvYZVpFpOZMDTzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtggtIkMyxUi2sxwzL//fP3rhozj0Z538rpKWNLQtxRgRqxAo0ZPBIxFa8FOxhPwdW81oGhWbaKYk5K7Tir3lZHnmzIBKZ0hZyc+e3RD5PrNdoZShmxACqSmyXjor/40K6D867pSvOBvoqJ8zY7ZcQTyi4gb8Dp3hFiWl4vvqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jZD9SlwE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LHMSF42083442;
	Thu, 21 May 2026 16:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YwjTp
	V7wR1YJqK/hsAlBffHL6vypkkCvpDmi7r3PdLY=; b=jZD9SlwEaFOf9mEOj4FJu
	1dfbyTuKbqleoYu6X9xrN2zfYqMytOhrfBncgNd2GwCO42/y9qRmF6wJ4YlShbX9
	2PZ2kZf41Qu/sU5Cbi4fQoHE97jnjxlUVIHiuIba3zV1fguzxSJu8b1VJO8q0rfZ
	Rw7MIqBepHzRzVWToHZlHKGLxBtuKT186/RN7ozBUjQn1D2C3Ah0CgiqqQuxKaol
	fLk5UsYwKdzhp4FnykoFNWUKUuTPVlSy6X510IkWGNNLpdsT698+LmGU69DqIuHa
	iFaYBBMD4MuYZ4pUnwcg2cUYZY2SlRe0i3S5nofz5N6u8vWfbEvnp1xmoPnAy4pL
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ea6d2gn6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 16:24:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LKOfVu016537
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 16:24:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 16:24:41 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Thu, 21 May 2026 16:24:41 -0400
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
Subject: RE: [PATCH net-next 3/5] net: phy: Add support for the ADIN1140 PHY
Thread-Topic: [PATCH net-next 3/5] net: phy: Add support for the ADIN1140 PHY
Thread-Index: AQHc2or/PLR+XGRoA0qfDv6DdRV2trX7uOeAgB1N4UA=
Date: Thu, 21 May 2026 20:24:41 +0000
Message-ID: <1d7f5247b07f44f2a30cfed8f7d3cd6d@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-3-dd043cdd88f0@analog.com>
 <2cfa6680-503a-4c4a-91bc-5f9a4331967d@lunn.ch>
In-Reply-To: <2cfa6680-503a-4c4a-91bc-5f9a4331967d@lunn.ch>
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
X-Authority-Analysis: v=2.4 cv=dpbrzVg4 c=1 sm=1 tr=0 ts=6a0f6a0a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=3zxtOzucoeEA:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=PVazNrEYVzhFiYv-KssA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwNSBTYWx0ZWRfX+QHZcDJkxNRI
 OMCuXq4ICTSDM7TP/6OJzZq5b2ve0Hl1NtO14ELjK3yiobGgz2neOTdAtnstl7p8MuB17XCotxk
 8pNQ2dyplvBCAvK7RZFHEzCSwmmPBAFChCugfIsnhaQ7PicOwk11VtgzAG+aQaHK3gCBzjxa8WW
 n/K1bheCDZsMZmqnQmk22JcX3B2p0Gh3zTjFJUPfECKNTDcZSuK0qaEo7Zg1tsBE55dDkJRRJN6
 4cgm18UwRX5zm9QttHzk6FVbeL3bEm5oELWa2AGDlK3ORAp7iOOyiT5GaH4F4+9PsyznoS0EBH4
 ziZQzxo22Q6ABcc9vFSvMI0hzUnhB0uE2gYBw7W32Bc393kEiB3M97njTB7dD+3tGlTLMNiaYGX
 IWCpPJRag9JQ+xhawp4tQjfgr/B6GU1aRfGmJBtvlbG2j28P7MJN7dOhaigWJOf0b1+khw2KZt1
 j8KMV7OFgxicuJmP8Cw==
X-Proofpoint-GUID: VfiWibBCwsAhzXUZg141LbN1MCLGwRUx
X-Proofpoint-ORIG-GUID: VfiWibBCwsAhzXUZg141LbN1MCLGwRUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210205
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290603-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 961EB5ABBFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> > +static int adin1140_phy_read_mmd(struct phy_device *phydev, int
> devnum,
> > +				 u16 regnum)
> > +{
> > +	struct mii_bus *bus =3D phydev->mdio.bus;
> > +	int addr =3D phydev->mdio.addr;
> > +
> > +	return __mdiobus_c45_read(bus, addr, devnum, regnum);
> > +}
> > +
> > +static int adin1140_phy_write_mmd(struct phy_device *phydev, int
> devnum,
> > +				  u16 regnum, u16 val)
> > +{
> > +	struct mii_bus *bus =3D phydev->mdio.bus;
> > +	int addr =3D phydev->mdio.addr;
> > +
> > +	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
> > +}
>=20
> Why do these exist?
>

The PHY is always probed over C22. Unless read_mmd()/write_mmd() are define=
d,
phylib will default to indirect accesses to MMD devices. The 0xD and 0xE PH=
Y registers
are not implemented, so those transfers won't have any effect.

