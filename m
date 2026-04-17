Return-Path: <netdev+bounces-279268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KuuLWf04WnT0AAAu9opvQ
	(envelope-from <netdev+bounces-279268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CA418F1B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E8D301E3C3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5C3B0AEE;
	Fri, 17 Apr 2026 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Yxg6prFE"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A0361666
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415664; cv=none; b=XkhDW8EDKIOCYjrP5JMysoJg+0EfXTUj6X9N9exPR9ITcKBzP3CEAT2GKV4v65dTUScgfNXP0DR543j3gFx0X9YjlWtRzjs87QRSt6L388+8ZkgNdHeerMowGg5Q1nORTPTKPWfRPhhnEPEZUiYqLdLH+jD9uUe8caa0rkbuuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415664; c=relaxed/simple;
	bh=G0jxgV4V8fkhVDwQ+UxtAai/zhuTzQeL/SXMGfKSEbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6WtsISYeZaxIIvlHBZs4Yu+TCBcc7o1NlbtUUuI6K2jYUDZIgErNVmZLJmwZ7TdceLkwUvaETl0FGKnPyPnSZZyMUSr3V/yWm9fqC32L7nmLSrv29fYUB0VH4yNNdWBg9wdfh2jpZp60tS5YNqBxcggV6F43ff6/EdlaatvPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Yxg6prFE; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=l58XSNH8R/mwB60BqCvoOIYMvGSIH31wM+Rks1CFbpc=; b=Yxg6prFE+rhlPUeg5StCJV+gQM
	mTb7z1pMiSEwSlRHUUkv/yzPxIDjbUf65/dR9QpFvSa/3p5U991X4shATrwkuGb5gTxL0x7nCHuqZ
	qNFn7LW5usVSeTlSW26q7KOc4yjxfg/O6UXCUNiK9xJY8s8PifSM06UMHECY3TEbS6SXHy/NqoXQW
	rOZ6YLh58nMyw743cdgcQayPEv0sei9cdhl07OXbqYB7VOXYhd3BxE9d7CidC/ZE+EE5sLUDZu652
	+5lDKnKX6TDqnLOhDa3mNnMFTSsphmlhOTZf1gkqyYo5X4JSdHUS5YCxpTiVEVFn+fXluhz2ZtaX1
	9ZIx+6Dg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wDerM-000PCr-0s;
	Fri, 17 Apr 2026 10:47:32 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wDerL-0006uB-1S;
	Fri, 17 Apr 2026 10:47:31 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Date: Fri, 17 Apr 2026 10:47:30 +0200
Message-ID: <13939918.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <680c384c-135f-44cd-a2cd-7e4fd0ec4bf7@bootlin.com>
References:
 <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
 <680c384c-135f-44cd-a2cd-7e4fd0ec4bf7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27974/Fri Apr 17 08:24:08 2026)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279268-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:url]
X-Rspamd-Queue-Id: 4C4CA418F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Freitag, 17. April 2026, 09:11:59 CEST schrieb Maxime Chevallier:
> Hi,
>=20
> On 16/04/2026 14:13, Russell King (Oracle) wrote:
> > On Thu, Apr 16, 2026 at 02:02:53PM +0200, Alexander Stein wrote:
> >> Hi Russel,
> >>
> >> Am Donnerstag, 16. April 2026, 12:49:25 CEST schrieb Russell King (Ora=
cle):
> >>> On Thu, Apr 16, 2026 at 08:20:13AM +0200, Alexander Stein wrote:
> >>>> Am Mittwoch, 15. April 2026, 14:59:32 CEST schrieb Russell King (Ora=
cle):
> >>>>> On Wed, Apr 15, 2026 at 08:08:40AM +0200, Alexander Stein wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell Kin=
g (Oracle):
> >>>>>>> Move the PHY attachment/detachment from the network driver out of
> >>>>>>> __stmmac_open() and __stmmac_release() into stmmac_open() and
> >>>>>>> stmmac_release() where these actions will only happen when the
> >>>>>>> interface is administratively brought up or down. It does not make
> >>>>>>> sense to detach and re-attach the PHY during a change of MTU.
> >>>>>>
> >>>>>> Sorry for coming up now. But I recently noticed this commit breaks=
 changing
> >>>>>> the MTU on i.MX8MP. Once I simply change the MTU I run into some D=
MA error:
> >>>>>> $ ip link set dev end1 mtu 1400
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Link is Down
> >>>>>> imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
> >>>>>> imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine init=
ialization failed
> >>>>>
> >>>>> This basically means that a clock is missing. Please provide more
> >>>>> information:
> >>>>>
> >>>>> - what kernel version are you using?
> >>>>
> >>>> Currently I am using v6.18.22.
> >>>> $ ethtool -i end1
> >>>> driver: st_gmac
> >>>> version: 6.18.22
> >>>> firmware-version:=20
> >>>> expansion-rom-version:=20
> >>>> bus-info: 30bf0000.ethernet
> >>>> supports-statistics: yes
> >>>> supports-test: no
> >>>> supports-eeprom-access: no
> >>>> supports-register-dump: yes
> >>>> supports-priv-flags: no
> >>>>
> >>>>> - has EEE been negotiated?
> >>>>
> >>>> No. It is marked as not supported
> >>>>
> >>>> $ ethtool --show-eee end1
> >>>> EEE settings for end1:
> >>>>         EEE status: not supported
> >>>>
> >>>>> - does the problem persist when EEE is disabled?
> >>>>
> >>>> As EEE is not supported the problem occurs even with EEE disabled.
> >>>>
> >>>>> - which PHY is attached to stmmac?
> >>>>
> >>>> It is a TI DP83867.
> >>>>
> >>>> imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:03] driver [TI DP838=
67] (irq=3D136)
> >>>>
> >>>>> - which PHY interface mode is being used to connect the PHY to stmm=
ac?
> >>>>
> >>>> For this interface
> >>>>> phy-mode =3D "rgmii-id";
> >>>> is set.
> >>>>
> >>>> In case it is helpful. My platform is arch/arm64/boot/dts/freescale/=
imx8mp-tqma8mpql-mba8mpxl.dts
> >>>> Thanks for assisting. If there a further questions, don't hesitate t=
o ask.
> >>>
> >>> Thanks.
> >>>
> >>> So, as best I can determine at the moment, we end up with the followi=
ng
> >>> sequence:
> >>>
> >>> stmmac_change_mtu()
> >>>  __stmmac_release()
> >>>   phylink_stop()
> >>>    phy_stop()
> >>>     phy->state =3D PHY_HALTED
> >>>     _phy_state_machine() returns PHY_STATE_WORK_SUSPEND
> >>>     _phy_state_machine_post_work()
> >>>      phy_suspend()
> >>>       genphy_suspend()
> >>>        phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN)
> >>>
> >>> With the DP83867, this causes most of the PHY to be powered down, thus
> >>> stopping the clocks, and this causes the stmmac reset to time out.
> >>>
> >>> Prior to this commit, we would have called phylink_disconnect_phy()
> >>> immediately after phylink_stop(), but I can see nothing that would
> >>> be affected by this change there (since that also calls
> >>> phy_suspend(), but as the PHY is already suspended, this becomes a
> >>> no-op.)
> >>>
> >>> However, __stmmac_open() would have called stmmac_init_phy(), which
> >>> would reattach the PHY. This would have called phy_init_hw(),=20
> >>> resetting the PHY, and phy_resume() which would ensure that the
> >>> PDOWN bit is clear - thus clocks would be running.
> >>>
> >>> As a hack, please can you try calling phylink_prepare_resume()
> >>> between the __stmmac_release() and __stmmac_open() in
> >>> stmmac_change_mtu(). This should resume the PHY, thus restoring the
> >>> clocks necessary for stmmac to reset.
> >>
> >> I tried the following patch. This works as you suspected.
> >=20
> > Brilliant, thanks for proving the theory why it broke.
> >=20
> > I'll have a think about the best way to solve this, because
> > phylink_prepare_resume() is supposed to be paired with phylink_resume()
> > and that isn't the case here.
> >=20
> > Please bear with me as my availability for looking at the kernel is
> > very unpredictable at present (family health issues.)
>=20
> FWIW I am able to reproduce this with imx8mp + ksz9131
>=20
> I can give this a try as Russell isn't available.

Thanks for conforming this for another PHY. What I'm wondering right now:
Why is the PHY stopped in the first place? We are just changing the MTU, no?
This has no effect on the PHY itself. "all" we need to do is reconfiguring
the DMA. I have a proof of concept running, but it needs more cleanup due
to code duplication.

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



