Return-Path: <netdev+bounces-272814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAgvMdMzyGlbiAUAu9opvQ
	(envelope-from <netdev+bounces-272814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:02:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC08A34FE41
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF0D8300A270
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B82E8B81;
	Sat, 28 Mar 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="QmBmqAFs"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBADEEB3;
	Sat, 28 Mar 2026 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728142; cv=none; b=bSlSpLSzuDsKP56lhAYlzrkaCB61W7Nguew5WIv0EKJsa1JrbTNiDZdezQyIWTUjiw1LZHVnPgUFt6QBON0vqCR4xEsmdZL5JeRVXDqwUcVrAaq0XhFPN8/lkm0fKFnzd7s0MCEoaNhAJQ1Av9hc/ECZZHG+SaBdIuYcK7m/pbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728142; c=relaxed/simple;
	bh=RGfBobdezF52Pe49YZ4hBRoClOfKkMnnw7d/RzJEGL8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEnjgHstu0dBtwHsTyu+vT9QSDFcFfm5be9Ma8yocTNQ2HjDtidtybBgVdTKXR24/c4kuTJFf+ipaXs9OJLS3HkklTU3umlux77MPD/O6+ye++oCF/ZtH39mVgQoMSI72Xe3OTXmv0zlAAcbPCg+zWuiUymYMHeQnMd6qFvfsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=QmBmqAFs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774728128; x=1775332928;
	i=markus.stockhausen@gmx.de;
	bh=KSrSfjzTxYSKqIzYWDSWe17D5wfwNkeXQ188OFn2hGw=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QmBmqAFsU7vkkBth4Z9agAqZxpDBXccUHFWcYwzPfTPnEsV4TpbmVeR6FPBkC9Ny
	 Bet5d47srcswL7AGHw2hOv9Ev9L04lwH4sJnwnSxELXjcC/H9xB2Ur9f/1aRt/xWT
	 TFjHSlhWTiecL90FKYHiR9xl6fN1LNshTGabgKSgQq8hy/3TbECpKLy41/4I7mu2P
	 p7MmZbLVS0ZaE4g3T5fuRguGSH0+0QJ/Zw0/thuCn0oGDPXNL9oeDTY9QO3zoF6Fq
	 U8evw1NAVtXxruxGK05EOqi+oElwqiRRskj+zK1haGXVRRkVSQcezDtlEdTEsHcc9
	 ElekkTnSk0I+lZKvrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1vomWl0Yut-00O9zk; Sat, 28
 Mar 2026 21:02:08 +0100
From: <markus.stockhausen@gmx.de>
To: "'Jan Hoffmann'" <jan@3e8.eu>,
	"'Andrew Lunn'" <andrew@lunn.ch>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Daniel Golle'" <daniel@makrotopia.org>,
	"'Damien Dejean'" <dam.dejean@gmail.com>
Cc: <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260322193235.990881-1-jan@3e8.eu>
In-Reply-To: <20260322193235.990881-1-jan@3e8.eu>
Subject: AW: [PATCH net-next] net: phy: realtek: support MDI swapping for RTL8226-CG
Date: Sat, 28 Mar 2026 21:02:05 +0100
Message-ID: <005e01dcbeed$c1dc0220$45940660$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsscWDCsukjy3yqNYdgqms5XBmDLakdahQ
Content-Language: de
X-Provags-ID: V03:K1:PfgVThndcEIdD6lHxGDJsPWWlrUPq1Ygf6UaOmvIHrwRzMkISEW
 C7IibMZL3iCmDiW/8U2ltKfnlLI5K1lSG3RdLSelf4GFuytblEXB6TPfkmdwIWeu5n3Wx+/
 QmKNkTv0BVV5FUn8fim8bdyj99fU6bq/ShTls8Wjh4wrMFbn6+7y0dBYy79MbidAs6Q4JV1
 tpTsTACUDT/NeH8mZnwiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FGU6JY+mOiA=;AgW9jXrKU/GrCJ45VOvt0C3f18n
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[3e8.eu,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:mid]
X-Rspamd-Queue-Id: CC08A34FE41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Von: Jan Hoffmann <jan@3e8.eu>=20
> Betreff: [PATCH net-next] net: phy: realtek: support MDI swapping for
RTL8226-CG
>
> Add support for configuring swapping of MDI pairs (ABCD->DCBA) when the
> property "enet-phy-pair-order" is specified.
> ...
>	ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x7, 0x1);

No real knowledge here. But from other register combinations around=20
the Realtek ecosystem this could make sense:

#define RTL822X_MDI_CAL_CTRL    0xd068   /* MDI pair cal index/control */
#define RTL822X_MDI_CAL_DATA    0xd06a   /* MDI pair cal data */

Markus


