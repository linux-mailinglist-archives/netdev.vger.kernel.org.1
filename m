Return-Path: <netdev+bounces-294140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fp/KDSzHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4229C62CC1D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 973A2302D0A5
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75173D349A;
	Tue,  2 Jun 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="iU/zv8Wu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD536A03A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395837; cv=none; b=py0XhqjARTArs2bhDYtDQAsXS3jYmqJR5u/HAGipWS35z+TtdiT2nM2Xom7QD3RDp6fr3G5NibX9B/XmbB42ZKQQQ4KAv9bgCeygFIkR9EbJF5Ub4pOjGk3KjysBrilFfrhME4mZbzQSREPRjxauw7pm6eZPaDribA8cKOf/nkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395837; c=relaxed/simple;
	bh=GX0E5kFJRL4Iy6TUg0ciKUMKrxqHAtk2c2ZsdcByY2Y=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kr5OVppjA+9UgfFBAZHk1xwnYlwqs8gsz9/bbmdHsmIGX/j2tey0irD9yDgmDAvaxrfaEMGpPAhl38jddM9qxdqebjg+Bx0Cp0+NmV1hjACgtUcPZr78q3lL4wl7mbQHQRqSY8F5xFKqozD2iurMsfTa4ks/IWf618QOp/pdKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=iU/zv8Wu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780395809; x=1781000609;
	i=markus.stockhausen@gmx.de;
	bh=GX0E5kFJRL4Iy6TUg0ciKUMKrxqHAtk2c2ZsdcByY2Y=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iU/zv8Wu40Ze/wo07r9hnH2Q3V21ySj7gKVjrCb737cNmOJveLBBxMUZxC1Xvjde
	 ai1TC1GxIrWTers1B+Xm7+dIq07eVd7b6Qll4s3aavggYQxQxypkOToGq5xusUg0E
	 Bg0ZMCj8vai2w/NDSb7S+aHg41n/U/1ELTxC9oA+BksQDj7fpu4Tx7lxAE7qbaiIC
	 mSRCWH9ebGmhiumQatyZXNHRNnVWxHxBEIeRg0syeg89uvZgAhLnGBpDAfcFA+Qgl
	 S22uUpYPsJ5pduy4CrY6KK0UJTGC8yKvfuwLYMvmNe+OO9RdTrrNhWE+qMdhsc1wo
	 WuV8BxipBOSpLGyfPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1wkvED2IOy-00Z09C; Tue, 02
 Jun 2026 12:23:29 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jagielski, Jedrzej'" <jedrzej.jagielski@intel.com>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-3-markus.stockhausen@gmx.de> <PH0PR11MB59021E62692FC52557016A9DF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB59021E62692FC52557016A9DF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
Subject: AW: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package
Date: Tue, 2 Jun 2026 12:23:27 +0200
Message-ID: <012f01dcf279$db256d60$91704820$@gmx.de>
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
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgD+IiDDAudyO3S4ifyGgA==
Content-Language: de
X-Provags-ID: V03:K1:CidbYGg6OwP0dtBsm3zl9VbnWeeJ6Clb5hFknRh58MPUk0kczMY
 FUJm3MT6VnaRQDkdJSyPWTmH02d2RtxsU6/pvju7dgouwMAyp5Ww6xHVnFn28PGtXLtYG08
 hQpUak49IR2xxj4EtZYhofMhU6B4ctcMQQ2KuTx+yxT5z+I1uw4QBJoWZg9CCwbzp2ORbQa
 kWfbTQX+Pmfu6xlX/6Lrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X8/ZUkaSJus=;C95YVgozyhlRmD4XfruUdBHkECj
 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
X-Rspamd-Queue-Id: 4229C62CC1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-294140-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:mid,gmx.de:dkim,gmx.de:email,mensi.ch:email]
X-Rspamd-Action: no action

> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>=20
> Gesendet: Dienstag, 2. Juni 2026 11:32
> Betreff: RE: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly
handle ethernet-phy-package
> ...
> >Signed-off-by: Manuel Stocker <mensi@mensi.ch>
> >Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>=20
> Hi Markus
> quite unclear (at least for me) what's Manuel's role on that patch.
> If he's a co-author please add proper tag, if you are sending Manuel's
patch on his behalf please change authorship.=20

Unsure about this but situation as follows:

- Manuel identified the issue downstream and sent a patch [1]
- I advised to make that a separate function.
- Manuel sent a new version that I merged
- Now I'm sending the same upstream

Please advise how I need to reflect this here.

Markus

[1] https://github.com/openwrt/openwrt/pull/23591





