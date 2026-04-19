Return-Path: <netdev+bounces-279573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PB93IBeX5GmMXAEAu9opvQ
	(envelope-from <netdev+bounces-279573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 10:49:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7926042374C
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F4C93002D1B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E2378822;
	Sun, 19 Apr 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="PKYryhQR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103E346AD5
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776588560; cv=none; b=p7JxJ/hX8dv1K1JpMFUoYt6gOTyAZmop0BJidOvwy1sMH47XimOkUoQ+dkJBEAxkIR0mxOij5xP28+/vZS94oR6njK87mikhRKqIC7Umsi/xCxe6EAbluO7gSRYREbGzCkdGiHR4HTetkUQTHJqMTS/7CFBVZrYRduKgoEaR/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776588560; c=relaxed/simple;
	bh=XMI38Jzl8Ahxx1KV9YnBFaDpklfkcEoie2Fc9CmHS1Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/EnjfWPZPb0xLAtQgGfRDWXlqoUaussbeLGa0oY/hhsJWJWK9ZckVTj+YH4BYEHU6cBwo3g9AmLyvjVvXPbsXOyo80hW3DSsdrQ/Sb7CCiI1ZRE3x4LULCrHpHWUyG9C5eEa4PB4CPyR4g589qyZ27JIpPXpb0lGM7+tkRm3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PKYryhQR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776588556; x=1777193356;
	i=markus.stockhausen@gmx.de;
	bh=YiT+hBdLhlgcATNTSUzX2vfZc6J8URGXoyCcvFt15KI=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PKYryhQRjxyt79EJkAiwAw0njlLR36g7Hl0yCdsq988SEMjRY0N6X/CCGG0F3vRw
	 CHWhng9mlxQ6VXPAyL8QpJP0cRFmE/gJn1DeazquqEz4Z5Bs37WHpTAlMhzkiDATi
	 TYnRP2aoY9zQ31W8rqwvuzQU1iZAMv5/JkT+BFOv2vKSI/cPPWpGI2gpsvlHnzI7q
	 d5JgkrSF3cdzU+PbuHlPKDjKLmXZ0RHG75jhhS6LHmJPQ+TXy2eBC3hssQQ3nqp+D
	 Lag1ZaYfppT0yPn0pWC+ghcJ/IwvV+tdGJVciZddkpmAXmI9wm3KiZGVhrijeC7wZ
	 prY2BmMJz6HVYAW3sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1vd9Hx06dl-00c6Xu; Sun, 19
 Apr 2026 10:49:16 +0200
From: <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Jonas Jelonek'" <jelonek.jonas@gmail.com>,
	<jan@3e8.eu>,
	<nbd@nbd.name>
References: <007c01dccf15$9b4622c0$d1d26840$@gmx.de> <90958cc3-e291-44ff-8fc3-102c0f62a269@lunn.ch>
In-Reply-To: <90958cc3-e291-44ff-8fc3-102c0f62a269@lunn.ch>
Subject: AW: pre-boot plugged SFP autoneg advertisement
Date: Sun, 19 Apr 2026 10:49:13 +0200
Message-ID: <00ee01dccfd9$673ebd10$35bc3730$@gmx.de>
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
Thread-Index: AQLkskcwgxwIhsA+/fZHIKXXJV76iwIbPyhFs8Vv7sA=
Content-Language: de
X-Provags-ID: V03:K1:Z8CoDFjyaO+WpDrqyT6C/7OMnWWYtARTpmXLoFuL5sRMhdFwYXH
 kWRWNWP5u56IaUmiovFpikFliM4q5aE8rWAv44nDg7o/Jg8IGJT4tXBDY7QpqIcxLPAqfqG
 qKH849kQLhBp31S1+sDTV1xQYgpNgmfXF1+AB3aZfYwU6+HtTNGvMAe7j6ajzvRxgbjWzG+
 uoxunpw0UrhwjPWK7HLUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BTJhMJp6TOU=;Ph2JLjSdnCwbGD3ikkOQywirekF
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279573-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,3e8.eu,nbd.name];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:dkim,gmx.de:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 7926042374C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Betreff: Re: pre-boot plugged SFP autoneg advertisement
>=20
> > On Sat, Apr 18, 2026 at 11:27:40AM +0200, markus.stockhausen@gmx.de
wrote:
> > Hi,
> >=20
> > I'm currently analyzing an issue where a pre-boot-plugged SFP module=
=20
> > comes up with autoneg=3Dno advertisement during boot. After an
> > unplug/replug autoneg=3Dyes advertisement is chosen.=20
> >=20
> > The following addition in phylink_start() just before the call to
> > phylink_mac_initial_config() mitigiates this.
> >=20
> > +  /* If an SFP module was already present before phylink_start() was
> > +   * called, phylink_sfp_set_config() was unable to call
> > +   * phylink_mac_initial_config() as phylink was not yet started.
> > +   * Ensure the SFP capabilities are reflected in advertising.
> > +   */
> > +  if (pl->sfp_bus && !linkmode_empty(pl->sfp_support))
> > +    linkmode_copy(pl->link_config.advertising, pl->sfp_support);
>
> Let me see if i have the call chain correct. This is net-next/main
> from today.
>
> phylink_sfp_connect_phy() ->
>   phylink_sfp_config_phy
>
>         if (changed && !test_bit(PHYLINK_DISABLE_STOPPED,
>                                  &pl->phylink_disable_state))
>                 phylink_mac_initial_config(pl, false);
>
> You are saying PHYLINK_DISABLE_STOPPED is set, so
> phylink_mac_initial_config() is not called.
>
> What i don't see is how phylink_mac_initial_config() does the
> linkmode_copy() you are adding.

Took that hint/question and digged deeper. Added further debug
to each and every linkmode_copy. I think I found the culprit in=20
a userspace ethtool call. For now I assume OpenWrt netifd.
Adding my last trace below including the original (wrong) idea.=20

Thank you very much for taking the time and your assistance.

Markus

[    3.301299] XXXX phylink_create lan12 set pl->link_config.advertising
(autoneg =3D 1)
[    3.309954] XXXX phylink_parse_mode lan12 set pl->link_config.advertisi=
ng
(autoneg =3D 1)
[    3.318964] XXX sfp_module_insert lan12 called
[    3.323935] XXXX phylink_sfp_config_optical lan12 set config.advertisin=
g
(autoneg =3D 1)
[    3.332815] XXXX phylink_validate_one lan12 set tmp_supported (autoneg =
=3D
1)
[    3.340629] XXXX phylink_validate_mask lan12 set supported (autoneg =3D=
 1)
[    3.348165] XXXX phylink_validate_mask lan12 set state->advertising
(autoneg =3D 1)
[    3.356527] rtl83xx-switch 1b000000.switchcore:ethernet-switch lan12
(uninitialized): XXX phylink_sfp_set_config requesting link mode
inband/1000base-x with support 0000000,00000000,00000200,00006440
=2D-- ETHTOOL CALL HERE ---
[   81.213726] XXXX phylink_ethtool_ksettings_set lan12 start got
config.advertising (autoneg =3D 1)
[   81.223542] XXXX phylink_ethtool_ksettings_set lan12 set accoring to
kset->base.autoneg (autoneg =3D 0)
[   81.233961] CPU: 0 UID: 0 PID: 1470 Comm: netifd Tainted: G           O
6.18.21 #0 NONE
[   81.234010] Tainted: [O]=3DOOT_MODULE
[   81.234017] Hardware name: Zyxel XGS1210-12 A1 Switch
[   81.234026] Stack : 823a3bbc 80139d20 00000000 00000001 00000000 000000=
00
00000000 00000000
[   81.234094]         00000000 00000000 00000000 00000000 00000000 000000=
01
823a3b78 82040d00
[   81.234152]         00000000 00000000 80992870 823a3a10 00000000 ffffef=
ff
00000001 00000224
[   81.234213]         00000226 823a39d4 00000226 000019c8 00000001 000000=
00
80992870 80a00000
[   81.234273]         82764648 00000016 00000016 82764628 00000000 80a913=
b0
00000000 81990000
[   81.234334]         ...
[   81.234350] Call Trace:
[   81.234356] [<80115e48>] show_stack+0x28/0xf0
[   81.234407] [<8010fc78>] dump_stack_lvl+0x70/0xb0
[   81.234432] [<80592718>] phylink_ethtool_ksettings_set+0x58c/0x6a4
[   81.234479] [<806bb890>] ethtool_set_link_ksettings+0xbc/0x198
[   81.234516] [<806be01c>] __dev_ethtool+0xfe0/0x1a1c
[   81.234550] [<806beb24>] dev_ethtool+0xcc/0x24c
[   81.234575] [<80678770>] dev_ioctl+0x30c/0x5f4
[   81.234616] [<80603ebc>] sock_ioctl+0x2bc/0x470
[   81.234642] [<8036e530>] sys_ioctl+0xb4/0x120
[   81.234683] [<8011edec>] syscall_common+0x34/0x58
[   81.234715]
[   81.234723] XXXX 2 phylink_ethtool_ksettings_set lan12 set
pl->link_config.advertising (autoneg =3D 0)
=2D----------
[   81.375070] rtl83xx-switch 1b000000.switchcore:ethernet-switch lan12: X=
XX
phylink_start configuring for inband/1000base-x link mode
=2D-- INITIAL FIX/IDEA HERE ---
[   81.388408] XXX phylink_start lan12 sfp_bus set and linkmode not empty =
->
would run linkmode_copy()
=2D----------
[   81.398688] XXX phylink_mac_initial_config lan12 called with
force_restart =3D 1
[   81.406752] rtl83xx-switch 1b000000.switchcore:ethernet-switch lan12: X=
XX
major config, requested inband/1000base-x
[   81.418459] XXXX major_config_entry lan12: autoneg_adv=3D0 autoneg_sfp=
=3D1
sfp_may_have_phy=3D0
[   81.427612] XXXX phylink_pcs_neg_mode ENTRY lan12: pl->pcs_neg_mode=3D0=
x0
[   81.435102] XXXX phylink_pcs_neg_mode lan12 advertising autoneg=3D0
[   81.442034] rtl83xx-switch 1b000000.switchcore:ethernet-switch lan12: X=
XX
interface 1000base-x inband modes: pcs=3D03 phy=3D00
[   81.454495] XXXX phylink_pcs_neg_mode lan12 base-x without phy
[   81.461134] XXXX phylink_pcs_neg_mode EXIT lan12 pl->pcs_neg_mode =3D 0=
x40
pl->act_link_an_mode =3D 0x2
[   82.085493] XXXX phylink_mac_pcs_get_state lan12 set state->advertising
(autoneg =3D 0)
[   82.094391] XXXX phylink_mac_pcs_get_state lan12 autoneg is 0


