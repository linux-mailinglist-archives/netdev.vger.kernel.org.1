Return-Path: <netdev+bounces-272967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9x/wLaxuyWk8yAUAu9opvQ
	(envelope-from <netdev+bounces-272967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:25:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C0353965
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B98300B133
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39C37FF5B;
	Sun, 29 Mar 2026 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OI9CE+1j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2C2877DE
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774808638; cv=none; b=nqSUDG2IPQXaezzuENf9B5jV0p6DCBpb59O/5EmvknAEoV7WcIIXmH8ywW9VTznFY7F0EcnQvOfbrbpIh0CneTnjTad1+Zb3RG36n3vsKa2oMsSEsmjPRrVtagSYRi7Yv71A+1RDuWyifRXKywIvcGAUAPhjNtv7TZE0D4rrgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774808638; c=relaxed/simple;
	bh=AoHDxgBxFj2ShgUSzbuVPL0dycvSGelmBMc8FaEWCnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuLukgaa+yUWulFI52Zusd4yaCLLn8YAFKb63XcubdhxEzdya2kE+C9drjzlcOej1DMs0pqwVNIobAmzWIPMfFGWgdez2Xw3w8iXteP8dP7q6vfJ6lefEO+jboJj+betMVRX34cEx60v1x94o+8lLBGE7VcQW6ejS17mQrXdL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OI9CE+1j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qGzDB+BbAy2UxWoOKWueCLa/Ve0k5Xt432NyksbrD1U=; b=OI9CE+1jdkOigebK4UrGva7oIH
	3kb6rNiaKlWyPv2pDJn6V1iQL+x3Xtk85WTKuiPDyEx6wH4eVUKwm1tQU6SUbEkj2LpFy75BYdzXI
	ij5MXbjcz8hCG+Nkh+/BOZUT8UpGncxn5isVX7KDE8IIEyltT21JtcHm9VLbkg/JD4+wwEr+bL3fc
	0vmnLgqW07tzcvAL090WEePlhMqKqWKqBvYvGtpvt95cdj2thxGnqttJjOTydf0ENTF0IxPYP0Dts
	+49KfUhFq9JwHkJnQACDdjYh6cLKTSuBsyROp4wJcEQJ6VYOfckxw1Zp6zWc9PyDBYOhot1H7uaJH
	tX13naQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49410)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6unc-000000008Ak-0F8p;
	Sun, 29 Mar 2026 19:23:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6unY-000000001vr-31Tz;
	Sun, 29 Mar 2026 19:23:44 +0100
Date: Sun, 29 Mar 2026 19:23:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: stmmac: fix TSO support when some
 channels have TBS available
Message-ID: <acluMCDdWFPSw_Zr@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
 <E1w6bKj-0000000ELtf-3md9@rmk-PC.armlinux.org.uk>
 <acjzmxY9xmBInSwm@shell.armlinux.org.uk>
 <20260329104223.358351ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329104223.358351ee@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272967-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.687];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: E73C0353965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 10:42:23AM -0700, Jakub Kicinski wrote:
> On Sun, 29 Mar 2026 10:40:43 +0100 Russell King (Oracle) wrote:
> > On Sat, Mar 28, 2026 at 09:36:41PM +0000, Russell King (Oracle) wrote:
> > > According to the STM32MP25xx manual, which is dwmac v5.3, TBS (time
> > > based scheduling) is not permitted for channels which have hardware
> > > TSO enabled. Intel's commit 5e6038b88a57 ("net: stmmac: fix TSO and
> > > TBS feature enabling during driver open") concurs with this, but it
> > > is incomplete.
> > > 
> > > This commit avoids enabling TSO support on the channels which have
> > > TBS available, which, as far as the hardware is concerned, means we
> > > do not set the TSE bit in the DMA channel's transmit control register.
> > > 
> > > However, the net device's features apply to all queues(channels), which
> > > means these channels may still be handed TSO skbs to transmit, and the
> > > driver will pass them to stmmac_tso_xmit(). This will generate the
> > > descriptors for TSO, even though the channel has the TSE bit clear.
> > > 
> > > Fix this by checking whether the queue(channel) has TBS available,
> > > and if it does, fall back to software GSO support.  
> > 
> > This is sufficient for the immediate issue of fixing the patch below,
> > but I think there's another issue that also needs fixing here.
> > 
> > TSO requires the hardware to support checksum offload, and there is
> > a comment in the driver:
> > 
> >         /* DWMAC IPs can be synthesized to support tx coe only for a few tx
> >          * queues. In that case, checksum offloading for those queues that don't
> >          * support tx coe needs to fallback to software checksum calculation.
> >          *
> >          * Packets that won't trigger the COE e.g. most DSA-tagged packets will
> >          * also have to be checksummed in software.
> >          */
> > 
> > So, it seems at the very least we need to add a check (in a subsequent
> > patch) for priv->plat->tx_queues_cfg[queue].coe_unsupported to
> > stmmac_channel_tso_permitted().
> > 
> > I'm also wondering about the stmmac_has_ip_ethertype() thing, which
> > checks whether the skb can be checksummed by the hardware, and how that
> > interacts with TSO, and whether that's yet another hole that needs
> > plugging.
> 
> If the driver "un-advertises" checksum offload accordingly the core
> should automatically clear TSO feature.

Ah, yes, it's in harmonize_features().

However, I think that stmmac_has_ip_ethertype() is tighter than the
checks that harmonize_features() does.

stmmac_has_ip_ethertype():
        int depth = 0;
        __be16 proto;

        proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
                                    &depth);

        return (depth <= ETH_HLEN) &&
                (proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));

If I'm reading this correctly, then eth_header_parse_protocol(skb)
will return the contents of the ethernet header protocol field.

__vlan_get_protocol() will then return:

 - that protocol if it is not a vlan (0x8100 or 0x88A8)
   with depth set to skb->mac_len, which should be ETH_HLEN here.
 - the protocol below the vlan headers, in which case depth
   will be > ETH_HLEN

Unless I've missed something, that basically means that the 
__vlan_get_protocol() is pointless there, and the entire function
could just be checking that eth_header_parse_protocol(skb) returns
IP or IPv6.

Isn't it the case that skb->protocol should be the same as
eth_header_parse_protocol(skb) for a packet being transmitted at the
point that .ndo_features_check() or .ndo_start_xmit() is called?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

