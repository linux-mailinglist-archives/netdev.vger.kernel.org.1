Return-Path: <netdev+bounces-297036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MDbkNjIFKGqy7QIAu9opvQ
	(envelope-from <netdev+bounces-297036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8057065FFE3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=analog.com header.s=DKIM header.b=BudPli9x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297036-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297036-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=analog.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08896303582B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6B40E8DB;
	Tue,  9 Jun 2026 12:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD509403E9D;
	Tue,  9 Jun 2026 12:14:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007242; cv=none; b=BrIElPFHhF1ScyCVteHVyMX1FNqIa+BH/N3zCfhWEHD5xFHjw8tOIQLS5RLMp7Vk8WjMIeBb8IC59FDYCiOtcGVi0WY8pey3tC0H/NAUkOZPLorktxxrC+4JBMmSK61VwVUl4qQ6KKVFu55TNjMwIfDG3bC3cDJO3O5MWKUxtMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007242; c=relaxed/simple;
	bh=32Zecr6AuK0y1EVb0X3uac50CzMYlS0gw/408kDalgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IaPsob3bCc1I+9S+F+M7CO+fq5TGHe57/4PX+7dUntj0aNrCF9oewZM2Ly5kVyMC5Tbjjs/3ZLJTeY6Hwd5QuMU7avFy1l4wSrRUWEPbF/+qRVrn/G+3wF1yTq8VlWg3WStxGjzRdfJ51HFMRfp759ZVRtVPZcl71hW8IWbGMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BudPli9x; arc=none smtp.client-ip=148.163.135.77
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599xPZ4684336;
	Tue, 9 Jun 2026 08:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=81SzT
	l+2+kxyi49EMTD9mRYQR2tF88TJGFtn6KVldy0=; b=BudPli9xk8hq/XJ6aJZ46
	yJKrNmfo1rtfLvkv9kcgS7vNnNQTP0A5c7Ge/tCzUPQz6xTdhhLgFAmtCm/avCE6
	baQFWPMHfExiOiW+MjAH578f8+SFJvVKaIGjzepwPxRxzj/ZBJpXOiH1eCyRlA7V
	OKYUyLOa/z3XqPsLZxV4oPPoo+G5PPpAaJ0H94ubkeuLy2yybjDzrzN6OQpcpTL7
	r76KNs6Saa/yZ3HHBFCQSccIT23VTEW9/hHt8yrIggsR3bV6Ubyv9hEQakx2COKM
	7UXAGMEuAUTyq+u0OWr+k74GDxYPHE8u4LEkNlTqwZrWnUafxo45CokQFD6Fkb3J
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4en1vcrysf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:13:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 659CDZrF049065
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 08:13:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 9 Jun
 2026 08:13:35 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912]) by
 ASHBMBX9.ad.analog.com ([fe80::a11:40fc:1a6f:d912%20]) with mapi id
 15.02.1748.037; Tue, 9 Jun 2026 08:13:35 -0400
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
Subject: RE: [PATCH net-next v3 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Thread-Topic: [PATCH net-next v3 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Thread-Index: AQHc9D/TDKzWBNEMhUCJrHhCZ7VZZrYvOwQAgAblhCA=
Date: Tue, 9 Jun 2026 12:13:35 +0000
Message-ID: <8fd58bbcd30f490ea747ca0f9479e3cc@analog.com>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-7-5debdb3173c4@analog.com>
 <905f32c3-9638-46e4-8f52-1bc874f4e8b9@lunn.ch>
In-Reply-To: <905f32c3-9638-46e4-8f52-1bc874f4e8b9@lunn.ch>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNSBTYWx0ZWRfX4h4q1FdX33i6
 hmmNs4Nc6KbdBzx+wYpzCzHRLJWGqwdcHtjsfG5E1SAGa8qhYpIMQ8HqBiLzPk7C2mGY6xriDh3
 Y5bWfmhx9M5xh4+Nvey92iRR8UeZ7uqrx0lL9n6mzPjy1+jQyTcEikTxZixsKBLTONKV8P89aAu
 4Y5N/uZ1WUoTv0rWB4KwxLbfqTI4q41xewvZiU4LZ4s2NHV1PlXcjxssml0PRJWFROoo6xi7LwH
 NCQlu9h4F0zV0ELq2Qd/Tkbc0uctDyuQnCW/65UlYvIQ991bMAo1FI0+w82oXhNlhY+fNxrohGV
 EDD449/tiY97rayOBMlylJjhhhgqttDTYU2VonEz206PfKBml0DT25LZ3wikUxA+81wdsYNu7Da
 a3xZzlw7Ij1XvFQwxdW+bHcLK9vnAgRfQozAq47N+dvuaKsSwxvx/8PmGw+ZfC4jqs43KbT2IBS
 /RH301mUoDLaiplPxsg==
X-Proofpoint-GUID: 3VnXBCFEFmN9HIVfrA7mObX6FpwBhmSm
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=6a280371 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=xqWC_Br6kY4A:10 a=0buomsULfWgA:10 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=W-ArhqCL-FZDaypOkxMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3VnXBCFEFmN9HIVfrA7mObX6FpwBhmSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090115
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297036-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Ciprian.Regus@analog.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ciprian.Regus@analog.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8057065FFE3

> > +/**
> > + * oa_tc6_read_register_mms - function for reading a MAC-PHY register
> in a
> > + * memory map other than 0.
>=20
> Is MMS 0 somehow special? Does it not work if passed to this function?

For addressing registers in MMS 0, we can just use the already existing oa_=
tc6_read_register
and oa_tc6_write_register functions. So, I meant to say that for transfers =
to memory maps
other than 0, this function can be used instead. Passing 0 in the mms param=
eter would
result in the same behavior as if the user called oa_tc6_read_register() wi=
th the upper 16 bits
of the addr masked (so there is nothing special about this case).

I agree the documentation is poorly worded and I'll change it to something =
like this in v4:

/**
 * oa_tc6_read_register_mms - function for reading a MAC-PHY register in a =
specified
 * memory map.

>=20
> I'm not suggesting all the current calls are replaced with this, just
> that the documentation might be inaccurate?
>=20
> > + * @tc6: oa_tc6 struct.
> > + * @mms: Memory map selector for the register.
> > + * @address: register address of the MAC-PHY to be read.
> > + * @value: value read from the @address register address of the MAC-
> PHY.
> > + *
> > + * Return: 0 on success otherwise failed.
>=20
> Isn't the "otherwise" actually an error code?

This function can return the same set of error codes as oa_tc6_read_registe=
r/ oa_tc6_write_register.
Those can be -EPROTO, -EINVAL or any error code returned by the spi_sync().=
 Since the other register
access functions have the same documentation for the return values, I kept =
it the same here.
I'll change it to "0 on success or a negative error code on failure".

>=20
> 	Andrew

