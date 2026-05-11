Return-Path: <netdev+bounces-286634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cESoAhbLAWqgjwEAu9opvQ
	(envelope-from <netdev+bounces-286634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:27:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6D50DAE2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1B630736C6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A893876D7;
	Mon, 11 May 2026 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="kWM8oXpV"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C137B3F6;
	Mon, 11 May 2026 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501979; cv=pass; b=M1Qb1fZGLiwF5zKQMvo5TAiNlih5EXkj0azGmZKmuWmeO51/ayLuoWPwqtbBsQYtu3Js5yKCbjVhXBNEf3iQsK5ObUcvDQuBcWjO1bF1xf28bO1jgFCJLMc2kzGizmRk/+VEwOEndQB171howpZiF11EfAChrsRRVp0xelRN0BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501979; c=relaxed/simple;
	bh=M/pUcmG1F55wwT4uXNC1aOZk7okt63T3uKSNMRfki4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4/eN7iynkkMLDkX1jYIp6r8l9atF3VqAM5/sFWepLxvQzv2eVgHzVqPa2al9oOEQeRqXKZ3kxvGU6fIZrli6ykxE5S0AagkD6v8AH8uHPGGbazsJui+oKKkKwZ2qse6EAPSg+XGU78gOUmGL4Kfa5+JY0bXlX1HI+A4Z8oaxj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=kWM8oXpV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1778501937; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YzVK4hvLbtCl9NpyRB3GWuSOYS3kV0KUDNWZi9XZNTt2iYuf6UYHbbNYZWsRuDzQPEv/VsrcpLL9z5Mt+LPnfKEePnvt0MkjUaBLX1QgTQ3VjMwhyvBdGPLA8rh0gUDXGmAYp2ZW1Bh+CzSyeYElwWMmo1TofX2vVEbUY0GXc8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778501937; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e3KpDXgFCAnQkBfYlVPDB0FnslGkY39PA015X6zVYj0=; 
	b=DzRpRTKFrXjL+nwK9M/yODt8RUaLXrvsopbDOLQydTLTMGODfKiTufvJqoRMsVBEOBllX08F58iglJwkykK5ZbIl3dDbW7JoW2sg5Xs8wAYAgpXJ8ZINBP0E9LLu9zqS1M0mFy4V0Xd8iIkPS2guQJz8cpd3xpNGWFkEmMd6lR4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778501937;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=e3KpDXgFCAnQkBfYlVPDB0FnslGkY39PA015X6zVYj0=;
	b=kWM8oXpVV/vf2I9SOZYxwamB054/t0Z4fI6yzV92fBRgFDBs/r/2Io2pMytOw8En
	2jT5A8YJo1a0XlciPSxIQFMXy6T+9rVro6CrDIN9x95RkZLlVngsPB6srKULRi21ClG
	YESxMCb8hQowltd6AaESLw1zanniqhGuPXp5JtOg=
Received: by mx.zohomail.com with SMTPS id 1778501935318366.15850500485783;
	Mon, 11 May 2026 05:18:55 -0700 (PDT)
Message-ID: <c7349f39fd10feed71e1188bcbb24f348451ab75.camel@collabora.com>
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
Date: Mon, 11 May 2026 14:18:49 +0200
In-Reply-To: <d7580b92-f165-4135-85b9-ec89a2568949@lunn.ch>
References: 
	<20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
	 <20260326-add-airoha-an8801-support-v2-3-1a42d6b6050f@collabora.com>
	 <3bd7803d-4c4a-4f61-9434-a6bf25627b58@lunn.ch>
	 <9f569ba00b959b701a7a51bcd7347c1a108a15ee.camel@collabora.com>
	 <d7580b92-f165-4135-85b9-ec89a2568949@lunn.ch>
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
X-Rspamd-Queue-Id: 99D6D50DAE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286634-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Action: no action

Hi Andrew,

On Thu, 2026-05-07 at 23:36 +0200, Andrew Lunn wrote:
> On Thu, May 07, 2026 at 02:11:54PM +0200, Louis-Alexis Eyraud wrote:
> > Hi=C2=A0Andrew,
> >=20
> > On Thu, 2026-03-26 at 13:30 +0100, Andrew Lunn wrote:
> > > > @@ -480,8 +287,8 @@ static int en8811h_wait_mcu_ready(struct
> > > > phy_device *phydev)
> > > > =C2=A0{
> > > > =C2=A0	int ret, reg_value;
> > > > =C2=A0
> > > > -	ret =3D air_buckpbus_reg_write(phydev,
> > > > EN8811H_FW_CTRL_1,
> > > > -				=C2=A0=C2=A0=C2=A0=C2=A0
> > > > EN8811H_FW_CTRL_1_FINISH);
> > > > +	ret =3D air_phy_buckpbus_reg_write(phydev,
> > > > EN8811H_FW_CTRL_1,
> > > > +				=09
> > > > EN8811H_FW_CTRL_1_FINISH);
> > >=20
> > > Is a rename required? Is the namespace air_buckpbus_ used
> > > somewhere
> > > else?
> > >=20
> > > 	Andrew
> > Sorry for the delay.
> >=20
> > The air_buckpbus_ namespace is only used in the air_en8811h driver.
> > It seemed better to me that in the new air_phy_lib, all functions
> > (the
> > buckpbus accessors and air_phy_read/write_page functions) started
> > with
> > the same prefix. That is the reason I renamed them, even if not
> > required.
> >=20
> > As an alternative, to avoid renaming those buckpbus function calls
> > on
> > air_en8811h driver and reduce this patch changes, I can add macros
> > at
> > the beginning of the file such as:
> > ```
> > #define air_buckpbus_reg_write(_phydev, _pbus_address, _pbus_data)
> > \
> > 	air_phy_buckpbus_reg_write(_phydev, _pbus_address,
> > _pbus_data)
>=20
> No don't do this.
>=20
> If you want to rename them, rename them. But do it in a patch which
> only contains a rename. That is easier to review, and more obviously
> correct.
I'll add in v3 a new patch to rename the functions and the calls in
air_en8811h.c then.

Best regards,
Louis-Alexis

>=20
> 	Andrew

