Return-Path: <netdev+bounces-279905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB8yODl65mkHxAEAu9opvQ
	(envelope-from <netdev+bounces-279905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:10:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A24332DD
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E45300A776
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55F3A6F06;
	Mon, 20 Apr 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ef46v5LM"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B53537CC
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712246; cv=none; b=FU0tmovYio1tfdKfDV5HNeEBwLgcSfP6A9efSLMftuIYyPh1dnM6sq/oPD7KweGSwM+/JJy5kxPBOk58HGXPIGL82cVuEQTO+7WqNVueGA6iB21bBaHliD83JOB1usrxzQKih830h2kTZJ0YcQvdCsTNiKIa8wUireJPg1G9LHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712246; c=relaxed/simple;
	bh=FSlw9xFsr3aeEswEUmV2Jgw7g3mlm8fJ7sAA71EmS80=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qO/AowcPTgBnuWgQgU6fqBvjdhdSc3pjKsfWdKdfl19OXIvcmzc1YEWn6m8BHYJokd80HqLXKW4MQiWlY7l6MdTkNoms1V6+b6dnV3gkG3oaXDQ7CPCyUyaqhqTDyWTqXaAxLJJN8TpdMS2Cd0xy/xGYKLqxVi4anyyZAyX8KKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ef46v5LM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776712234; x=1777317034;
	i=markus.stockhausen@gmx.de;
	bh=FSlw9xFsr3aeEswEUmV2Jgw7g3mlm8fJ7sAA71EmS80=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ef46v5LMo1YORyKFPhAUNDBa1IFSvXegGl+UlK1WrTTo+GtNry/QSsPolcvxcb7g
	 8PCyW3Tafqur9QFcorIXUrKX7vQKJL+iIigvXiShOJnuDzthJ97fRJ5O+glsX3E5o
	 LLGeuwFUV1nQgi5Y//W31d7x2ROXNZsgoHDEYQyclyzIG30xG4pylRtU3t3OS8BlL
	 pZ8oNM+UxMgW1ZEEZSCkKrWW988yAcf+pVaskDyjROmul9wW+IzPVIyCvpAS/Vwle
	 XZLctkyIY1wOs6dlwR+NP2vE/4zYTL1gqKOG//YFXwiVJJZc6cFKvlk2hIWG2uTFC
	 uAlYj41sFjBSvdkAhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1wGXdj3flS-00CDLi; Mon, 20
 Apr 2026 21:10:33 +0200
From: <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Jonas Jelonek'" <jelonek.jonas@gmail.com>,
	<jan@3e8.eu>,
	<nbd@nbd.name>,
	"'Daniel Golle'" <daniel@makrotopia.org>
References: <007c01dccf15$9b4622c0$d1d26840$@gmx.de> <90958cc3-e291-44ff-8fc3-102c0f62a269@lunn.ch> <007701dcd0e1$11c45210$354cf630$@gmx.de> <664e6e24-4a94-43fa-8769-773a37a01c66@lunn.ch>
In-Reply-To: <664e6e24-4a94-43fa-8769-773a37a01c66@lunn.ch>
Subject: AW: pre-boot plugged SFP autoneg advertisement
Date: Mon, 20 Apr 2026 21:10:32 +0200
Message-ID: <007401dcd0f9$5cc990a0$165cb1e0$@gmx.de>
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
Thread-Index: AQLkskcwgxwIhsA+/fZHIKXXJV76iwIbPyhFAkT+ugwCic3+47OhOTUg
Content-Language: de
X-Provags-ID: V03:K1:iTibo5F/I0uWYvZP+hgiDkloH7rTT6974soJyCTPj2hMTsydYte
 yTNEaWekOoaxvGOiGA2N8ermlanA9DRkWqFDDXDOz9agBoLw4ImjhqLlbFc0SLE5dFfi5Gl
 4sX00RgGlUgRyTSQ5mmYZTafS6zNq7YgcF4nKO+wt979HbWxHLWrmh/onZwmL22stv8uhHi
 0cxkVUzMKkN692+Vpma5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cwAQ4o019Lw=;9Qp4mz17gAYdxb9qOtqZW0taW4I
 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
 xY
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279905-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,3e8.eu,nbd.name,makrotopia.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:dkim,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 5C0A24332DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 20. April 2026 19:58
> An: markus.stockhausen@gmx.de
>=20
> > Sequence of events during boot is as follows:
> >=20
> > - SFP module is already inserted (in my case 1G)
> > - phylink_sfp_config_phy() runs long before any network config starts
> > - OpenWrt netifd daemon starts and wants to configure the network
interfaces
> > - It reads current settings via ethtool ioctl and gets autoneg=3Doff
> > - It writes basic config values via ethtool ioctl including autneg=3Do=
ff
> > - Later on it starts the interface and phylink_start() is issued
>
> I would say netifd is not optimal. I'm not sure we every agree to
> return the full ksetting on an interface which is admin down. Many
> driver don't even connect to the PHY until open is called, and so are
> likely to return -ENODEV. See phy_ethtool_set_link_ksettings().
>
> Could you look into the behaviour of netifd, especially if it gets
> -ENODEV during the first read. Does it try again after setting the
> interface up?

Netifd has no issues with linksettings reading/writing in admin state.
Getting a rc=3D0 it assumes that all values are filled, changes the needed
attributes and writes them back. I retested and think there might be a=20
solution to avoid unneeded Ioctl access (see [1])

> If we know phylink is going to return a subset of the correct
> information when the interface is admin down, maybe it should return
> -ENODEV?

Or (stupid idea) phylink_ethtool_ksettings_set() should not accept all=20
settings in this state.=20

Thanks for your valuable input.

Markus

[1] https://github.com/openwrt/netifd/issues/76#issuecomment-4283478081


