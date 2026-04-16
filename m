Return-Path: <netdev+bounces-279028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALvjEKHR4GkkmQAAu9opvQ
	(envelope-from <netdev+bounces-279028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:10:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C940DE45
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 972063025E7A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0C34DCE6;
	Thu, 16 Apr 2026 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="X8q8vfHs"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241238F226
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340982; cv=none; b=utsTPxyC5X4E8rOUpj1GiD9qARmMo+wPlLRx6vIg0bFG/0HHjbrLSfWdZsUSADB92vNn6fM1ZRdlo/oUXJGptf38GmvBheWoPwQq/bCLUq3DSzaPJAPrTjJ9C4qfkUZq8/VwhYVj18O59bPKDY8Db2q17vuWbo8YnRFXbXy6OoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340982; c=relaxed/simple;
	bh=MmojMpQKB8nNws785btoNpr7XEetjyhHlZHMoH3qlQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmVMdt5kyuxkuXB7/2bWg1aDpjlRJpDDjev30ccd/ftBT07Ojcc6qDtXwOweZ9pL9PxWRUu80+Gf0FprGux1jXJC53iYi2qgk3FbsGqxBH1D/VgI8YhWJhcOWDctNXXbCCmSSJuAD/2O1Kuvq1EPvWzLvG43mjYmyAsWCAZhj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=X8q8vfHs; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KLcgYHB46Ktz0E94r19iOcll6svKQTg1l7RztdPevJY=; b=X8q8vfHsh6bHKZaIkqGeHZMvnn
	iPSQ7uUqdZxgQt4uq/c3n5wkOmAB66rdOebMjAY8xDTQ5HC+7le9rfudkTlg04xZPH9+QldfqV3W1
	DT6H38LTf9IyCdpp+iBZlOBvTD+xx0ENtwOyCBfUWW/qDW4QpsLLk2kVpTATLUbvdNEwevq/TsNoi
	fhYlRkT3BKUFfYXleI1ErlCMnWe5MRTapgfvvrHhGtbsEXgQCEZTkI3FutyXUoXPoJzYrMOi+69wm
	kO4YrY4k8Lf+NQ1W1JVnOVnaa/8W6kAwaU7Ci6z7OCFev6/gMfFaIJ/8jmOHqeTQI/3xzVZqwQJeP
	vSb7e7CA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wDLQs-000MvA-2a;
	Thu, 16 Apr 2026 14:02:54 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wDLQL-000EJr-0I;
	Thu, 16 Apr 2026 14:02:54 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Date: Thu, 16 Apr 2026 14:02:53 +0200
Message-ID: <2410317.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <aeC-tc2CooYDoBok@shell.armlinux.org.uk>
References:
 <aNKDqqI7aLsuDD52@shell.armlinux.org.uk> <5987484.DvuYhMxLoT@steina-w>
 <aeC-tc2CooYDoBok@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27973/Thu Apr 16 08:24:10 2026)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A22C940DE45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russel,

Am Donnerstag, 16. April 2026, 12:49:25 CEST schrieb Russell King (Oracle):
> On Thu, Apr 16, 2026 at 08:20:13AM +0200, Alexander Stein wrote:
> > Am Mittwoch, 15. April 2026, 14:59:32 CEST schrieb Russell King (Oracle=
):
> > > On Wed, Apr 15, 2026 at 08:08:40AM +0200, Alexander Stein wrote:
> > > > Hi,
> > > >=20
> > > > Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell King=
 (Oracle):
> > > > > Move the PHY attachment/detachment from the network driver out of
> > > > > __stmmac_open() and __stmmac_release() into stmmac_open() and
> > > > > stmmac_release() where these actions will only happen when the
> > > > > interface is administratively brought up or down. It does not make
> > > > > sense to detach and re-attach the PHY during a change of MTU.
> > > >=20
> > > > Sorry for coming up now. But I recently noticed this commit breaks =
changing
> > > > the MTU on i.MX8MP. Once I simply change the MTU I run into some DM=
A error:
> > > > $ ip link set dev end1 mtu 1400
> > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
> > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
> > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
> > > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
> > > > imx-dwmac 30bf0000.ethernet end1: Link is Down
> > > > imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
> > > > imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine initi=
alization failed
> > >=20
> > > This basically means that a clock is missing. Please provide more
> > > information:
> > >=20
> > > - what kernel version are you using?
> >=20
> > Currently I am using v6.18.22.
> > $ ethtool -i end1
> > driver: st_gmac
> > version: 6.18.22
> > firmware-version:=20
> > expansion-rom-version:=20
> > bus-info: 30bf0000.ethernet
> > supports-statistics: yes
> > supports-test: no
> > supports-eeprom-access: no
> > supports-register-dump: yes
> > supports-priv-flags: no
> >=20
> > > - has EEE been negotiated?
> >=20
> > No. It is marked as not supported
> >=20
> > $ ethtool --show-eee end1
> > EEE settings for end1:
> >         EEE status: not supported
> >=20
> > > - does the problem persist when EEE is disabled?
> >=20
> > As EEE is not supported the problem occurs even with EEE disabled.
> >=20
> > > - which PHY is attached to stmmac?
> >=20
> > It is a TI DP83867.
> >=20
> > imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:03] driver [TI DP83867]=
 (irq=3D136)
> >=20
> > > - which PHY interface mode is being used to connect the PHY to stmmac?
> >=20
> > For this interface
> > > phy-mode =3D "rgmii-id";
> > is set.
> >=20
> > In case it is helpful. My platform is arch/arm64/boot/dts/freescale/imx=
8mp-tqma8mpql-mba8mpxl.dts
> > Thanks for assisting. If there a further questions, don't hesitate to a=
sk.
>=20
> Thanks.
>=20
> So, as best I can determine at the moment, we end up with the following
> sequence:
>=20
> stmmac_change_mtu()
>  __stmmac_release()
>   phylink_stop()
>    phy_stop()
>     phy->state =3D PHY_HALTED
>     _phy_state_machine() returns PHY_STATE_WORK_SUSPEND
>     _phy_state_machine_post_work()
>      phy_suspend()
>       genphy_suspend()
>        phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN)
>=20
> With the DP83867, this causes most of the PHY to be powered down, thus
> stopping the clocks, and this causes the stmmac reset to time out.
>=20
> Prior to this commit, we would have called phylink_disconnect_phy()
> immediately after phylink_stop(), but I can see nothing that would
> be affected by this change there (since that also calls
> phy_suspend(), but as the PHY is already suspended, this becomes a
> no-op.)
>=20
> However, __stmmac_open() would have called stmmac_init_phy(), which
> would reattach the PHY. This would have called phy_init_hw(),=20
> resetting the PHY, and phy_resume() which would ensure that the
> PDOWN bit is clear - thus clocks would be running.
>=20
> As a hack, please can you try calling phylink_prepare_resume()
> between the __stmmac_release() and __stmmac_open() in
> stmmac_change_mtu(). This should resume the PHY, thus restoring the
> clocks necessary for stmmac to reset.

I tried the following patch. This works as you suspected.

Thanks and best regards
Alexander

=2D--8<---
=2D-- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5875,6 +5875,8 @@ static int stmmac_change_mtu(struct net_device *dev, =
int new_mtu)
=20
                __stmmac_release(dev);
=20
+               phylink_prepare_resume(priv->phylink);
+
                ret =3D __stmmac_open(dev, dma_conf);
                if (ret) {
                        free_dma_desc_resources(priv, dma_conf);
=2D--8<---

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



