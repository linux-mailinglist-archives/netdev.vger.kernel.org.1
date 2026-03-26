Return-Path: <netdev+bounces-272115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NP/Bc5TxWmD9QQAu9opvQ
	(envelope-from <netdev+bounces-272115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:42:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73F337C26
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7378230F26E5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996C402B89;
	Thu, 26 Mar 2026 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1T8b5Jwh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6137F740;
	Thu, 26 Mar 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538836; cv=none; b=IGTUL7wJHx80FWZJjc8Fdq3Lm3bPlslPytd55iZM+3cBpYqST244bpaxZvcLvaigFnWUOGshVGaNbjYQjgdy21CnBBoxMOZfuCCeWCu6sv9aBaSe4FWf8DqGTCu1vyxsy3r1qiXw2zIaiau0PNWsRDsFxsuGB9aCwAgNYOs5aUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538836; c=relaxed/simple;
	bh=xp/FcAIY4MWxs591sba8YBWW3xp77iN8bj2fb0SMr0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nby8glWsi8LNylwA4iLma8GNtFvoV7W4ta4iemsfGeLj6CrwtijAaJSdycufD287KeIbjGeodiy1+xg7TXareUl06BR1xvTQpq1MabKVr+DMKeTGJ2nots4uwGM5Hj+jOxr+3zffqMcW3mgtbPtgexI2N8JGDAOOteR+I8QTu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1T8b5Jwh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gzVATzeIpqjOe+8Cx38MLFUSi1q5cYwLtg5AqfYWoD0=; b=1T8b5Jwhep6s1bdWD5TFn69pLd
	SZy76s1Snrm8+z47EkFs8pZ+0aN7O1f/CRLTzggTAK990pTxU/0jKo2cqbVyH6JLzbiRwv14myAiT
	eTR5fybqRfzJ31fYr2YHTHbg2A68ALLDfCJbdipXFN7uhgA+1NVXH2puZFFppl3R+IsnI8D7Rd3Iy
	yxjDkb5v6q0ydugukyqGcRF8U125/05UaD43B7lTf8nI3TnXbp/gXXQfL3QmejCzKSrIvZFu36hxC
	Vn/nM434Xrgmgt020x4M0+hBAje0q8xBEhZ+6yB1qj2vdhNBkchMmXOEv7UmuthB5MCmMx/YrYF7Q
	HQF3D0bA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51150)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5mbs-000000004xT-2JKK;
	Thu, 26 Mar 2026 15:27:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5mbq-0000000078D-0OZH;
	Thu, 26 Mar 2026 15:26:58 +0000
Date: Thu, 26 Mar 2026 15:26:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
Message-ID: <acVQQQiciPQBkQOG@shell.armlinux.org.uk>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
 <acVND6DdpM9czIwU@shell.armlinux.org.uk>
 <044110c5-da1e-48c0-93fd-35553e86b271@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044110c5-da1e-48c0-93fd-35553e86b271@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,collabora.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB73F337C26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 04:24:23PM +0100, Andrew Lunn wrote:
> On Thu, Mar 26, 2026 at 03:13:19PM +0000, Russell King (Oracle) wrote:
> > On Thu, Mar 26, 2026 at 01:04:15PM +0100, Louis-Alexis Eyraud wrote:
> > > +static int an8801r_set_wol(struct phy_device *phydev,
> > > +			   struct ethtool_wolinfo *wol)
> > > +{
> > > +	struct net_device *attach_dev = phydev->attached_dev;
> > > +	const unsigned char *macaddr = attach_dev->dev_addr;
> > 
> > This isn't a criticism for this patch, but a discussion point for
> > phylib itself.
> > 
> > It occurs to me that there's a weakness in the phylib interface for WoL,
> > specifically when WoL is enabled at the PHY, but someone then changes
> > the interface's MAC address - there doesn't seem to be a way for the
> > address programmed into the PHY to be updated. Should there be?
> > 
> > Do we instead expect users to disable WoL before changing the MAC for
> > a network interface?
> 
> Program the MAC address during suspend? I assume userspace is no
> longer active at this point, so the address should be stable.

What is the timing requirements for a system going into suspend vs a WoL
packet being sent? Should a WoL packet abort entry into suspend? If yes,
then we need to program the MAC before the PHY is suspended, because
suspend could already be in progress.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

