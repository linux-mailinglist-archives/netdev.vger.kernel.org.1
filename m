Return-Path: <netdev+bounces-303641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oereN6MVRWrU6goAu9opvQ
	(envelope-from <netdev+bounces-303641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0F66EE161
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="04 AB/X5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303641-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303641-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 158E331510EE
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A387481229;
	Wed,  1 Jul 2026 12:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1C48097B;
	Wed,  1 Jul 2026 12:47:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910081; cv=none; b=RhM1hpVXJkY6LBTOZskMvSjYYLf0E24fUDNDYHmYg5NTv4R/uGeVepc55tMBexUumcUl2JYv/EYac1WdDr174XQGb4MRhG5BqzKK8ZjBIDkazl8AuzquCxVqDXxDebZxb1xLyyLKNYxeF38AXHBVOmaJPcds6ReM8WiHTZf+7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910081; c=relaxed/simple;
	bh=CqASPK2DpOZ3vcTRgJZ6g6iWSFf2OOIi3rCnd9twhrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3OQ1YnlDUiZ1v3r6FdNEZ0mQmLCxykj6iA9MLKzyOm5OdUd2H6+NjQ1n7yTX5Ugp0Q4KUUghG+El2fktRLcYo8gQltz15slPytE1rdWwNuaF4WHvqI2UhFGZINhxVOyEKCx2cgCqBkCrCFRq8e3j7Ixmx9B5bMpwE61DR3T2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=04AB/X5R; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6wRKSXChsr77WPNeKS78AynfZLFETLZw16rerEeWi/o=; b=04
	AB/X5RnPsqzGgx1YccBerkuxPYKjwwo+gB/hs3d37IkMLuDJMzh//bklmlN1Xj69rwO+Rk3cu7u6x
	KuSWMsJv507OOHmA6VtUYdAC025fpud8QZxcZ1Cc6+/E90SUVJ6ZqizLcMyd7Qcl0IE/SLf4iD/cS
	jx/BkoPXUIHe25I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weuLx-00AALT-D6; Wed, 01 Jul 2026 14:47:45 +0200
Date: Wed, 1 Jul 2026 14:47:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Nazle Asmade, Muhammad Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Message-ID: <d70a6795-e1a2-43e2-b523-0fc668324674@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
 <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
 <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
 <5a0c962e-1af0-4d6a-b871-d8a0b0197ff5@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a0c962e-1af0-4d6a-b871-d8a0b0197ff5@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303641-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A0F66EE161

> > # There are a small number of cases where the MAC has hard coded
> > # delays which cannot be disabled. The 'phy-mode' only describes the
> > # PCB.  The inability to disable the delays in the MAC does not change
> > # the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
> > # 'rgmii' is now invalid, it cannot be supported, since both the PCB
> > # and the MAC and PHY adding delays cannot result in a functional
> > # link. Thus the MAC should report a fatal error for any modes which
> > # cannot be supported. When the MAC implements the delay, it must
> > # ensure that the PHY does not also implement the same delay. So it
> > # must modify the phy-mode it passes to the PHY, removing the delay it
> > # has added. Failure to remove the delay will result in a
> > # non-functioning link.
> >
> >      Andrew
> >
> > ---
> > pw-bot: cr
> Hi Andrew,
> 
> The delays are provided by the FPGA GMII-to-RGMII converter soft IP,
> which is hardcoded in the FPGA bitstream and cannot be disabled or
> modified from the driver side.
> 
> Using phy-mode = "rgmii" is intentional here — it prevents the PHY from
> adding its own internal delays on top, since the FPGA converter already
> provides the full required delay. This is consistent with how all other
> Agilex5 SoCDK board variants are described, as seen in commit
> c5637e5ceb4b ("arm64: dts: socfpga: agilex5: Fix phy-mode to rgmii as HW
> provides clock delay") already in Dinh Nguyen's tree, which applies the
> same rationale across all Agilex5 boards.

I've become more insistent that designs get this correct. So i don't
care too much about past systems. Many vendors are having to fix up
their drivers and DT in order to make new boards consistent.

You can look at your system as the FPGA being the MAC, and the PHY is
the PHY. The PCB is not providing the delay, the MAC is. This exactly
fits the description above.

     Andrew

