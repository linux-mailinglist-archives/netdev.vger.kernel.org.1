Return-Path: <netdev+bounces-279864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOtKOJll5mlmvwEAu9opvQ
	(envelope-from <netdev+bounces-279864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:42:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BE431E15
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30670305153A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C73321A2;
	Mon, 20 Apr 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="VXf6VxTM"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F73112D0
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701815; cv=none; b=ngGwLMqFm1CCeBGXkGiIKxQxm4MSHcIAPe0g8AdLekkR8u0Oba+fqadKWdRp+vys0AnOqM4K28Ae5jEU/hJLb64Ybd/LtQJNylmIR1dgcb4aIt+rHjrUny0/gcqSETNUiRgtpiewTQyh/Gzjss+31Wmo1qkKo1EK1I6U7JUC3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701815; c=relaxed/simple;
	bh=Bnlh6CFlpvlUwAOgy28bPaNngFNpXInqJVzVCK95tic=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLTq1uUKU9PIrOkz5b3HaUntasIgkYbdcxQ2a6RQjzvtDnDDuxs5FOv4WBSbTgalMomL0xHgwiasLuMr3rvw0T8PlYv3UVnT2FnKV3lBPeQO6tHvv7KDs+yn/0HmP5X8UzHDJWkFTD3QcjDRao4sVFOT4XhTywVKPR+al0V3QhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=VXf6VxTM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776701800; x=1777306600;
	i=markus.stockhausen@gmx.de;
	bh=0m11gKN6CjMyuCMUDtIicUpaMzRvtcNv3vfuKJGqyYY=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VXf6VxTMLPLzHOEuxVuIBbkuJppAFiEBbw41pvDemsGqtLL3r7+DxuTKRpNgf5R5
	 4mfakxxSS8g/1zOM0h+XoqLb5mt5QQTOpmIE08nfYPy+mIw007GUGdcjvIrn6LnRz
	 ol2ItrkR4nMMaG/vlNxTSe/aqK03wgkNwXltnDcrQmSNrj+BLqltSiPoTZ1+YIoma
	 Tb8e/ops5w7ED4J8pRFDZ1jxWT0e4iq9qPiUoOe+0X22yDMjvS6hkrTZbCHI0Q2VP
	 SoypYdv9lv2EjR9NZ5J47u0oHP5rlOHHRbKPYg9AidQLQAmIkSIdYsdASKO9FcyEr
	 TgChfrH+IIik+5AFDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1w4zvX3NzQ-008mqP; Mon, 20
 Apr 2026 18:16:39 +0200
From: <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Jonas Jelonek'" <jelonek.jonas@gmail.com>,
	<jan@3e8.eu>,
	<nbd@nbd.name>,
	"'Daniel Golle'" <daniel@makrotopia.org>
References: <007c01dccf15$9b4622c0$d1d26840$@gmx.de> <90958cc3-e291-44ff-8fc3-102c0f62a269@lunn.ch> 
In-Reply-To: 
Subject: AW: pre-boot plugged SFP autoneg advertisement
Date: Mon, 20 Apr 2026 18:16:34 +0200
Message-ID: <007701dcd0e1$11c45210$354cf630$@gmx.de>
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
Thread-Index: AQLkskcwgxwIhsA+/fZHIKXXJV76iwIbPyhFAl4Wat6ztI+VkA==
Content-Language: de
X-Provags-ID: V03:K1:x66W4g7kvPZiC8SQdue82L3Fu3Hs1MamHohf7huCaWZN3amAWxO
 soZWnAprg7BwxJnW/oltbgLtoZaPGJJtPivNlY8wvQOyF4Ej/mkeiZSKiOEmPeQoAlM54dW
 ySCqk529z4JIhC5/lVJqapqCw/gFkO6zVUJL5mxJgWYYJqSw3rq5KUjCKZWMsUQkHNE/5zO
 +RA2F+KsfOW2ObMbJdkQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/Z3uXwc6ImE=;s8shLDkq9GWEXPZhNZUvafjoCNU
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,3e8.eu,nbd.name,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-279864-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,gmx.de:email,gmx.de:dkim,gmx.de:mid]
X-Rspamd-Queue-Id: C93BE431E15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Von: markus.stockhausen@gmx.de <markus.stockhausen@gmx.de>=20
> Gesendet: Sonntag, 19. April 2026 10:49
> An: 'Andrew Lunn' <andrew@lunn.ch>
> Betreff: AW: pre-boot plugged SFP autoneg advertisement
>
> Took that hint/question and digged deeper. Added further debug
> to each and every linkmode_copy. I think I found the culprit in=20
> a userspace ethtool call. For now I assume OpenWrt netifd.

Hi Andrew,

once again thanks for your help. After further investigation I hopefully c=
an
add=20
more details. I think I got the whole picture now. So some additional
background=20
information about the environment.=20

- Realtek RTL930x devices with SFP+ module slots
- These are driven directly by a SerDes (controlled by downstream PCS
driver)
- The DTS reads

	port11: port@11 {=20
		reg =3D <11>;
		label =3D "lan12" ;
		pcs-handle =3D <&serdes8>;
		phy-mode =3D "1000base-x";
		sfp =3D <&sfp1>;
		managed =3D "in-band-status";
	};

Sequence of events during boot is as follows:

- SFP module is already inserted (in my case 1G)
- phylink_sfp_config_phy() runs long before any network config starts
- OpenWrt netifd daemon starts and wants to configure the network interfac=
es
- It reads current settings via ethtool ioctl and gets autoneg=3Doff
- It writes basic config values via ethtool ioctl including autneg=3Doff
- Later on it starts the interface and phylink_start() is issued

With my limited knowledge I would patch phylink_ethtool_ksettings_get().

		/* The MAC is reporting the link results from its own PCS
		 * layer via in-band status. Report these as the current
		 * link settings.
		 */
		phylink_get_ksettings(&link_state, kset);
		break;

+	case MLO_AN_PHY:
+		/* SFP module present at boot but phylink not yet started.
+		 * Return autonegotiation as set by
phylink_sfp_config_phy().
+		 */
+		if (pl->sfp_bus && !pl->phydev)
+			kset->base.autoneg =3D
+
linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+
pl->link_config.advertising)
+				? AUTONEG_ENABLE : AUTONEG_DISABLE;
+		break;
	}

	return 0;
}

This comes from the observation that

- pl->link_config.advertising is filled by phylink_sfp_set_config()
- state MLO_AN_PHY is reported before phylink_start()
- state MLO_AN_INBAND is reported after phylink_start()

Is this reasonable or am I totally off?

Markus



