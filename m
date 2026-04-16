Return-Path: <netdev+bounces-278943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFFKAj+A4GlJiQAAu9opvQ
	(envelope-from <netdev+bounces-278943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:22:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDA740AA0F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F6E307AA6C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFC135F5E4;
	Thu, 16 Apr 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="R//Cr3VV"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4919D8BC
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320428; cv=none; b=IiRYSkif1hzCyToNXL1lzDxCeqK7vNSrzPqXvdkj4ucYU9a+eq/qwVsqyCplco1CTkX/Xl1spWYCVUxtkgF119F82HRMWhXHuI3uCdFs+XSTu6k/20zoEIYxkpojxfjR4HLFfXgeFxp96L6yYYxmjYm7gCJgNynbqP/PmGLHWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320428; c=relaxed/simple;
	bh=bh8msoz4EI4a/BdUDMFy3bVSmNNJFCpl0CsanK230Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oU6NZ4+nwSXN5QnaxXsZThXVCpFrugmqMMBPMd//6tswwtmJgHtemAy5Ue75PE1oF5qaZNstUV1rr9Fpe7qlHaC+KrbusoCZ4tz37N7inuA75GjixMbbpvM886yjIqq/+EPjUXnamZzoORR2koOwTt3MA42p0B8+xZkbzxeDhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=R//Cr3VV; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QVEWApQ8SGzvLOzKWrNmtTuBW8dEI9SRhim1vQtgHE4=; b=R//Cr3VV3lQasZ26REI5zhDcVn
	v2b0sJZIvov1K3dg/i6Mbv2ra5hbvuM4Kn7jhhiynrNDyeyUWf2kQArF2zxZo0iMAQahMd3fDQShK
	XBtyVxMXMzJKXAuDMTeZAw4SRrqDPiGUOXAWCJiQLZVDZ7mwPt7/m0I/967IM177d+hrj9UglRasE
	hSk525hrA9eRobjS535sMqEu+eyU8VbObLJ5XvgCwbUM6yp/TI8p+rbBF4BAWTm7fAQhymLZFAOPK
	XABd8Vltp37V3mjgBRNu4UEUvILxywBP8r5AWchJ16yhhzRnZKFwNUx+L40V3E+rkfW1sLb7Ffpbd
	ZvF4K7Ug==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wDG5G-000Fp1-21;
	Thu, 16 Apr 2026 08:20:14 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1wDG4i-000Oj6-2s;
	Thu, 16 Apr 2026 08:20:14 +0200
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
Date: Thu, 16 Apr 2026 08:20:13 +0200
Message-ID: <5987484.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ad-LtOBrKREM1tCk@shell.armlinux.org.uk>
References:
 <aNKDqqI7aLsuDD52@shell.armlinux.org.uk> <8409022.LvFx2qVVIh@steina-w>
 <ad-LtOBrKREM1tCk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27972/Wed Apr 15 08:24:27 2026)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BDA740AA0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Mittwoch, 15. April 2026, 14:59:32 CEST schrieb Russell King (Oracle):
> On Wed, Apr 15, 2026 at 08:08:40AM +0200, Alexander Stein wrote:
> > Hi,
> >=20
> > Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell King (Or=
acle):
> > > Move the PHY attachment/detachment from the network driver out of
> > > __stmmac_open() and __stmmac_release() into stmmac_open() and
> > > stmmac_release() where these actions will only happen when the
> > > interface is administratively brought up or down. It does not make
> > > sense to detach and re-attach the PHY during a change of MTU.
> >=20
> > Sorry for coming up now. But I recently noticed this commit breaks chan=
ging
> > the MTU on i.MX8MP. Once I simply change the MTU I run into some DMA er=
ror:
> > $ ip link set dev end1 mtu 1400
> > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
> > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
> > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
> > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
> > imx-dwmac 30bf0000.ethernet end1: Link is Down
> > imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
> > imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine initializ=
ation failed
>=20
> This basically means that a clock is missing. Please provide more
> information:
>=20
> - what kernel version are you using?

Currently I am using v6.18.22.
$ ethtool -i end1
driver: st_gmac
version: 6.18.22
firmware-version:=20
expansion-rom-version:=20
bus-info: 30bf0000.ethernet
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: yes
supports-priv-flags: no

> - has EEE been negotiated?

No. It is marked as not supported

$ ethtool --show-eee end1
EEE settings for end1:
        EEE status: not supported

> - does the problem persist when EEE is disabled?

As EEE is not supported the problem occurs even with EEE disabled.

> - which PHY is attached to stmmac?

It is a TI DP83867.

imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:03] driver [TI DP83867] (ir=
q=3D136)

> - which PHY interface mode is being used to connect the PHY to stmmac?

=46or this interface
> phy-mode =3D "rgmii-id";
is set.

In case it is helpful. My platform is arch/arm64/boot/dts/freescale/imx8mp-=
tqma8mpql-mba8mpxl.dts
Thanks for assisting. If there a further questions, don't hesitate to ask.

Thanks and best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




