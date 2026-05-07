Return-Path: <netdev+bounces-285299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE70JsGB/GkcQwAAu9opvQ
	(envelope-from <netdev+bounces-285299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:12:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5754E808B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1136B30065DD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DB3EDAD6;
	Thu,  7 May 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="Z25JEbRA"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0193399375;
	Thu,  7 May 2026 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155963; cv=pass; b=EwErx0395Aff2PBa2j72t0X3LA4KeR/d+8YsWgzBu/bvv0lsSkcleDV5KgLPyyYdsE/TRQK+lXWuTer/yJqG9ZFvyNZPREKfZ0Rux6QwkjMkWLMo5dKdRVPquHyM9wcmQVHlo761P+AZWh73DB5AUDfDTx7m0UMQWMo2Lz5F13o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155963; c=relaxed/simple;
	bh=KGezB8CFKk6umGZCllHLAZYg1/rr7fGfklybicq5nXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AdrYoHbaD6hmPhRMSp9LtI1Aff2PP2STFo7D6pHPscoxyAZw4U4rNkqyH9Wt6WP9jLVbzkYExofKCXWt0Pl9MqmsD3JEusdoPgQpeHBs511U1UlMk1Hqkpu4/1hU3xNHTG13eNQI3Ok2Vb9n5XS6jbsx64MrB9XLImrzrTMmWSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=Z25JEbRA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1778155922; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SDqglZccFbVPk9LWQ0GXBIIjb5MTR7/+sA4n+fjXZXzD2J20OQUNcGzzI8P2ThMpfbxK0suJSqw8KJoBxUETcpz+Zc1EsGX5POHky3de0r5e5g2HHPRZpf/A66O4+k6/I53xMY74F7R0YsQ7AfWTkzcr6RKxCUardLqYkuBWWMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778155922; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZrnqX96u+Flxd2Q9FYBoadC2ai7BMu/bBuPcHTaRBc8=; 
	b=LYk7OweCiBXGFeROcxl94OQydGvYw21aGDkgLo+D1qZw4lSgNAKmsD4LBq99l0c5nxOdVNjUcxb0ZORrKWKRllaWvWOfa0SAtujSYSDKZH9OzQ6BH22mvkJUimyAsUyQzusXbCKMgQ88pUXTz/BGOjLc2qrjZW5lRU70bdIpoIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778155922;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ZrnqX96u+Flxd2Q9FYBoadC2ai7BMu/bBuPcHTaRBc8=;
	b=Z25JEbRAuz4jHpuHjKB0FLBVYYQUt9rboPSOl82e/pL+qjfex4RSH2vRvdYw63Ix
	zq4cfxq08lheqbLqpsL6cC/SUNOrT3BXqQr9WSwsjFWj+f5KbYlmn6rw960vb09NAzS
	ER90yeFBhvryN8yxHZfczpNpOZdDwFMWxNGocsm4=
Received: by mx.zohomail.com with SMTPS id 1778155920789528.3783773258275;
	Thu, 7 May 2026 05:12:00 -0700 (PDT)
Message-ID: <9f569ba00b959b701a7a51bcd7347c1a108a15ee.camel@collabora.com>
Subject: Re: [PATCH net-next v2 3/4] net: phy: air_phy_lib: Factorize
 BuckPBus register accessors
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Heiner Kallweit	
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, 	kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 14:11:54 +0200
In-Reply-To: <3bd7803d-4c4a-4f61-9434-a6bf25627b58@lunn.ch>
References: 
	<20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
	 <20260326-add-airoha-an8801-support-v2-3-1a42d6b6050f@collabora.com>
	 <3bd7803d-4c4a-4f61-9434-a6bf25627b58@lunn.ch>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 3C5754E808B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Action: no action

Hi=C2=A0Andrew,

On Thu, 2026-03-26 at 13:30 +0100, Andrew Lunn wrote:
> > @@ -480,8 +287,8 @@ static int en8811h_wait_mcu_ready(struct
> > phy_device *phydev)
> > =C2=A0{
> > =C2=A0	int ret, reg_value;
> > =C2=A0
> > -	ret =3D air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 EN8811H_FW_CTRL_1_FINISH);
> > +	ret =3D air_phy_buckpbus_reg_write(phydev,
> > EN8811H_FW_CTRL_1,
> > +				=09
> > EN8811H_FW_CTRL_1_FINISH);
>=20
> Is a rename required? Is the namespace air_buckpbus_ used somewhere
> else?
>=20
> 	Andrew
Sorry for the delay.

The air_buckpbus_ namespace is only used in the air_en8811h driver.
It seemed better to me that in the new air_phy_lib, all functions (the
buckpbus accessors and air_phy_read/write_page functions) started with
the same prefix. That is the reason I renamed them, even if not
required.

As an alternative, to avoid renaming those buckpbus function calls on
air_en8811h driver and reduce this patch changes, I can add macros at
the beginning of the file such as:
```
#define air_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data) \
	air_phy_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data)
```

Would it be okay?

Best regards,
Louis-Alexis

