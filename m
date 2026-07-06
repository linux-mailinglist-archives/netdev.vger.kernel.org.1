Return-Path: <netdev+bounces-304828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uxkBSQcS2ogMAEAu9opvQ
	(envelope-from <netdev+bounces-304828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 05:08:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7570C450
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 05:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b="FG/d9k56";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304828-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304828-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 739A63006F07
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 03:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF335BDA8;
	Mon,  6 Jul 2026 03:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4A1EE01A;
	Mon,  6 Jul 2026 03:08:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307296; cv=none; b=FtZlHpEnfd4JMDqWCAr6icirSUvx57Vo/31mdQ5DLJnlE3RQMaNAv7lVp72FMkiNbAe3PY05rvG3oTSscafj83xqJ+6dNfFsEJbjUY2ok6wEAGuil761ViOargAnzuFEI+JBW+kUXRKXPkvycVqWZS3k3E9sBqTvX/ISOeFTcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307296; c=relaxed/simple;
	bh=SXa+Zp9hBj2e+vSF0SJ0YFOW31mLUh/RaDaNgpF7I3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SP1SLkSXtcdpJU1hRXjnBj652skh3PkmrYNIaoMo8iFcfAs1FPJg1ZZo+1Y4VLHqbfceJ28hxlfHfTnVdI/GYZ+BuCLWui5Kvrb9awZvvUNkmSZw99chnRhGWei7QcULNd1af0C3bhwCxAl5rzqGhctHQTlIFkNWvBXl68ZPjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=FG/d9k56; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66637U4N0125118, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783307251;
	bh=al1sZ+uv8HDns43vM0txuyuzzLEBdfuTzUipioXzjV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FG/d9k56JsoAniYi1V5wYJOj7CO5s0THZFHleLpurH6MwPE22SaFSb8SIrczKCcBW
	 glCFHNivVjj10ReletkpqhAsXGNrkND+b7VSIphfJZl1j/XXgweOWoDJF/mLd+mqjS
	 +/OFffS1lADTKluQZT7ib3nMDFOmj+7M+xAvriC34sQLgQ9cRngJ5SUcwZXuEnESTO
	 Go5fXDtrDEzFp/CjsugGeKe6LXZpRtNkGAQpFwC7DGrwbC/vkMKikn2wGunPjQbLKH
	 5sJXoe7+7vgrV30PYrD2wPB8qrDk2YePh3esTbcgCrEERGKybgnR+IajofEQQVL5hz
	 I4FpUFECdJxCQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66637U4N0125118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Jul 2026 11:07:31 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Jul 2026 11:07:30 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 6 Jul 2026 11:07:30 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4 2/6] r8169: add support for phylink
Thread-Topic: [PATCH net-next v4 2/6] r8169: add support for phylink
Thread-Index: AQHdCs3TJl12zyZG4k+Q4Ne2oWyVWrZbu9EAgAQTiYA=
Date: Mon, 6 Jul 2026 03:07:30 +0000
Message-ID: <1f09de5536004055ba63862ca7088eeb@realsil.com.cn>
References: <20260703092459.1124-1-javen_xu@realsil.com.cn>
 <20260703092459.1124-3-javen_xu@realsil.com.cn>
 <e9cadf1a-94f3-45e8-9b59-22082ee5c2da@lunn.ch>
In-Reply-To: <e9cadf1a-94f3-45e8-9b59-22082ee5c2da@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:from_mime,realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66E7570C450

>
>> +     if (jumbo) {
>> +             if (!tp->jumbo_pause_saved) {
>> +                     struct ethtool_link_ksettings cmd =3D {};
>> +                     bool adv_pause, adv_asym;
>> +
>> +                     phylink_ethtool_get_pauseparam(tp->phylink, &tp-
>>saved_pause);
>> +                     if (tp->saved_pause.autoneg) {
>> +                             phylink_ethtool_ksettings_get(tp->phylink,=
 &cmd);
>> +                             adv_pause =3D ethtool_link_ksettings_test_=
link_mode(&cmd,
>> +                                                                       =
        advertising,
>> +                                                                       =
        Pause);
>> +                             adv_asym  =3D ethtool_link_ksettings_test_=
link_mode(&cmd,
>> +                                                                       =
        advertising,
>> +                                                                       =
        Asym_Pause);
>> +                             if (adv_pause && !adv_asym) {
>> +                                     tp->saved_pause.rx_pause =3D 1;
>> +                                     tp->saved_pause.tx_pause =3D 1;
>
>This does not look correct. Pause is negotiated. In order to determine how=
 to
>program the MAC you need to look at what the local side is advertising, an=
d
>what the link peer is advertising. I don't see anything here about lp_.
>
>I forget what the issues is. Is it something like, if you are using a norm=
al MTU,
>pause is supported? But with jumbo MTU it is not?

Yes, exactly. Pause is supported with normal MTU, but not with jumbo MTU.

The old non-phylink code handled this by clearing Pause and Asym_Pause
from phydev->advertising when jumbo MTU was enabled, and then restarting
autoneg:

        linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                           tp->phydev->advertising);
        linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                           tp->phydev->advertising);
        phy_start_aneg(tp->phydev);

With phylink, directly modifying phydev->advertising does not look like
the right thing to do, since phylink owns the advertised link modes.

What would be the correct phylink model for this?

Is there an existing phylink API which allows a MAC driver to update the
local advertisement and trigger autoneg after an MTU change? Or would this
require a new phylink helper/hook for dynamic MAC pause capabilities,
since the pause capability depends on the current MTU?

>
>For this to work correctly, i would expect a change of MTU to trigger a ne=
w
>autoneg, with the local advertisement changed. That might require changes =
in
>phylink, since it does not expect this sort of thing.
>
>> @@ -5288,6 +5326,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
>>               r8169_remove_leds(tp->leds);
>>
>>       unregister_netdev(tp->dev);
>> +     if (tp->phylink)
>> +             phylink_destroy(tp->phylink);
>
>
>I've not looked in detail, but is tp->phylink optional? I would expect the=
 probe
>to fail if it could not create it.

Yes. I will remove this check.

>
>> +static int rtl_mac_enable_tx_lpi(struct phylink_config *config, u32
>> +timer, bool tx_clk_stop) {
>> +     struct rtl8169_private *tp =3D container_of(config, struct
>> +rtl8169_private, phylink_config);
>> +
>> +     if (!rtl_supports_eee(tp))
>> +             return -EOPNOTSUPP;
>
>Can that happen? You should only be telling phylink EEE is supported if EE=
E is
>actually supported.

Agreed. rtl8169_get_lpi_caps() returns 0 when EEE is not supported, so
phylink should not call mac_enable_tx_lpi() for such devices.
I will remove the redundant check.

>
>> +static int rtl_init_phylink(struct rtl8169_private *tp) {
>> +     struct phylink *pl;
>> +     phy_interface_t phy_mode;
>> +
>> +     tp->phylink_config.dev =3D &tp->dev->dev;
>> +     tp->phylink_config.type =3D PHYLINK_NETDEV;
>> +     tp->phylink_config.mac_managed_pm =3D true;
>> +     tp->phylink_config.lpi_capabilities =3D rtl8169_get_lpi_caps(tp);
>> +     tp->phylink_config.mac_capabilities |=3D MAC_ASYM_PAUSE |
>> + MAC_SYM_PAUSE;
>> +
>> +     if (tp->sfp_mode) {
>> +             phy_mode =3D PHY_INTERFACE_MODE_INTERNAL;
>> +             tp->phylink_config.mac_capabilities |=3D MAC_10000FD;
>
>Only 10G? Is it not possible to slow down to 1G for a 1G SFP?

It can support 1G SFP as well.

I only added MAC_10000FD here because the original code path only added
the 10G capability, and I was trying to keep the behavior unchanged in
this conversion patch.

BRs,
Javen
>
>        Andrew

