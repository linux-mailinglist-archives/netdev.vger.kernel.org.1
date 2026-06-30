Return-Path: <netdev+bounces-303278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ga5DBgzgQ2p+kwoAu9opvQ
	(envelope-from <netdev+bounces-303278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC56E5EAE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="u8 YI+Vb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303278-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DC9A301F4A5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626D37188B;
	Tue, 30 Jun 2026 15:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE41E1E12;
	Tue, 30 Jun 2026 15:25:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833151; cv=none; b=k7Oa+n8ITeiHlKUxl1qaZ6eySl+6S3g9qV/O7leyUHLmV4FwnQavbs8vKXmMw3wGWj3gudgTdw9uR2oE4/fgPJZjxHesUCObpbyP05q18AdloIdaIjdaEqwVhe7/ua4CidO66onbnBPhAFXqlDTDx3m/ZQ8fO8NPj2R3c1D0EFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833151; c=relaxed/simple;
	bh=8a4ySrCqBZoZgZUvcFOaG0obPwn0zLHi3GWJzeWfVn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0+AIhn+v5ajBJN4HHdRLXA6Vw+i+j9SkGrTbfneBmAOgyz0RlZP7v5jcKLfGQc9CoyYOMCf1Ry7tKvviSOOO/AHlzqsq1V/NvEuLQFfvPXxddqWOK3fpXnG1RNUBv9lNydPI5I72xZ99oAW4czF0t5+SRRLLqAlJeyfKFwRwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u8YI+Vb2; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DmD+OzcP3hxAXs0Zz1yHPXf2Fl6f2W68HIV2dY8Fuvo=; b=u8
	YI+Vb20Zu09I/rIon96W7/QgPk4U+ZkBc/rYUj1VeEInlWZZ9zvHkyrlBBNVyPdsPoWLosuzvd2sO
	LlYNxr4IPV1a65A3sDas4YfkHmAOGmsdVWlzhds6kElu/PZfs9ganbPwKe/AnLhPV5BbcCY4BYCjG
	D41n0/HJS9Z2seg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weaL4-00A0Yx-C3; Tue, 30 Jun 2026 17:25:30 +0200
Date: Tue, 30 Jun 2026 17:25:30 +0200
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
Message-ID: <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
 <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
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
	TAGGED_FROM(0.00)[bounces-303278-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 13BC56E5EAE

On Tue, Jun 30, 2026 at 02:39:50PM +0000, Nazle Asmade, Muhammad Nazim Amirul wrote:
> On 30/6/2026 9:58 pm, Andrew Lunn wrote:
> >> + * gmac1 is the TSN port. The MAC operates in GMII mode internally
> >> + * while the PHY-side interface is RGMII, so mac-mode and phy-mode differ.
> >> + */
> >> +&gmac1 {
> >> +	status = "okay";
> >> +	phy-mode = "rgmii"; /* TX/RX clock delays provided by Agilex5 I/O hardware */
> > Could you provide more details about this. I want to understand the
> > big picture.
> > 
> > Normally we talk about the PCB providing the delays. This sounds like
> > it is the FPGA? So i need convincing this is correct.
> Hi Andrew,
> 
> Thanks for your quick review and yes, it is the FPGA — specifically a 
> soft IP block in the FPGA fabric that implements the RGMII clock delays 
> and is configured before Linux boots via the FPGA bitstream. The driver 
> must not add additional delays on top.

So it depends on how the converter block is described, but ....

From a big picture, MAC and PHY pair, it is the MAC which
implements the delays.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L346

# There are a small number of cases where the MAC has hard coded
# delays which cannot be disabled. The 'phy-mode' only describes the
# PCB.  The inability to disable the delays in the MAC does not change
# the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
# 'rgmii' is now invalid, it cannot be supported, since both the PCB
# and the MAC and PHY adding delays cannot result in a functional
# link. Thus the MAC should report a fatal error for any modes which
# cannot be supported. When the MAC implements the delay, it must
# ensure that the PHY does not also implement the same delay. So it
# must modify the phy-mode it passes to the PHY, removing the delay it
# has added. Failure to remove the delay will result in a
# non-functioning link.

    Andrew

---
pw-bot: cr

