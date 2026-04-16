Return-Path: <netdev+bounces-278884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LsNLksn4GkIdAAAu9opvQ
	(envelope-from <netdev+bounces-278884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:03:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234A409256
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29EAF306EFCB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3A1391;
	Thu, 16 Apr 2026 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K147q+Ak"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A834632
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776297801; cv=none; b=Qw7k0pj6DQSTQppX7AItnjsFiWfIW5gliQK/XAlsKH+kQiV6u2DQg+HMSkLaLA4tyL7sLjjqzJeOz1MGtkB/QUJYijQW0/0b9GLX8xGe9/oy5vNameXTTCoygbGN9F6OSOlz0LzivMfd8I7P1LcJYNhOOLRhQB0C2NJrLsYYnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776297801; c=relaxed/simple;
	bh=VZHq/4IIYmMZT8B+cwiT+YdTMMHSfWNwYesSsotBDKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3ttj5rXDJMBoq6K73jHMhxTGOFh70j3a9r2oy7Ch7HNgNILoekMWPvQ2sksnc03f19KouGjn1BYLG7V9m0ttPXCujEfCLRUZixtTem8ZV6hlcwzSLfuoNqk/zDNrf4N08+1PbAiW1Lm2fn05uihIQS2JJ3V68IBwxPycmsntYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K147q+Ak; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b1XEqYLz+VFVxVLLY5sh99l0d3isS+L35SSH4/U236E=; b=K147q+AkNu7v6MOBFr/Kx4ZCS/
	T0csGRKPmVl/FJDc2YFb2Bzm5v5cwtje9EpZ6KgxOUb2amWuMMo0wFreTVxnU9hsCKzKZb8RoaQHl
	brC5TGP5MX2BvqHZZbg0QvpD/1swD/EJRWAX42+71zg6jBg1xF4SJQXJbyRXn3kAnIFt1JH+uCXpc
	9v1IJV3rorGpFxGr8ACW0UEYa0ON60Wya88Na71bjBSjJsSzSDVSulraB1IHGeRO1fSdrFIsbSJPj
	fIH6YoeI2nxlJ8Jq5a5ex2QOji0i6GP8TDSCVBqVReHYCT7BbDB7H9x04siYBRQdMsk7X7FYrgbbp
	2bzSa/2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55132)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wDACE-000000002d7-1Y8c;
	Thu, 16 Apr 2026 01:03:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wDACA-000000002fX-2zo6;
	Thu, 16 Apr 2026 01:02:58 +0100
Date: Thu, 16 Apr 2026 01:02:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <aeAnMTU6iiPPE0_W@shell.armlinux.org.uk>
References: <20260413110222.49fc3759@kernel.org>
 <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
 <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk>
 <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
 <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com>
 <ad-ID2WaPgPJqdsa@shell.armlinux.org.uk>
 <CAH5Ym4jKdzDeYwCfkMLmUz0FsiD2vFwfuAvqFE=uvMtPmakeMQ@mail.gmail.com>
 <ad_o4aDP0UBY_8i4@shell.armlinux.org.uk>
 <CAH5Ym4j3GePEMEMmg1Z27gYfQ0N8Sc1BMW1rnvNZ4aLQ+cfFyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5Ym4j3GePEMEMmg1Z27gYfQ0N8Sc1BMW1rnvNZ4aLQ+cfFyQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278884-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.614];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3234A409256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:50:53PM -0700, Sam Edwards wrote:
> On Wed, Apr 15, 2026 at 12:37 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > It's not a question about how I define RBU - this is defined by Synopsys
> > and I'm using it *exactly* that way as stated in the documentation.
> >
> > "This bit indicates that the host owns the Next Descriptor in the
> > Receive List and the DMA cannot acquire it. The Receive Process is
> > suspended. ... This bit is set only when the previous Receive
> > Descriptor is owned by the DMA."
> >
> > In other words, DMA has processed the previous receive descriptor which
> > _was_ owned by the hardware, written back to clear the OWN bit, and
> > then fetches the next descriptor and finds that the OWN bit is also
> > clear.
> 
> I'm only trying to leave open the possibility that the Synopsys
> technical writer and the hardware implementation team weren't
> communicating clearly. We already have a situation where RPS isn't
> behaving as documented (even if that's likely just hardware
> misconfiguration), so while I'm currently pretty sure RBU carries no
> other (actual) meaning than "DMA caught up to OWN=0," I'm only about
> 75% confident.

It doesn't make sense for RPS to be set though. RPS is "Receive Process
Stopped" and it's documented as being raised when the receive process
enters the stopped state.

If we look at the DMA Debug Status 0 register at 0x100c, then this
gives us a four bit bitfield for channels 0, 1 and 2. Further channels
are in 0x1010. I've added code to dump these when RBU occurs:

dwc-eth-dwmac 2490000.ethernet eth0: debug status: 0x00006400 0x00000000

bits 11:8 are RPS0, which indiciates that the DMA channel 0 receive
process state is "Suspended (Rx Descriptor Unavailable)". If this were
0, then it would be "Stopped (Reset or Stop Receive Command issued)".

So, RPS isn't being raised because the process state isn't entering
the stopped state, which makes sense - because we haven't issued a
stop command, nor have we caused a reset, and the documented recovery
from this condition is to merely advance the tail pointer, rather than
issuing a command to re-start the receive process.

When this is done (because stmmac_rx() continues to periodically run
because of NAPI) RPS0 does change back to 3 "Running (Waiting for Rx
packet)" but it seems that although there are packets waiting to be
written out, that never happens (the Queue 0 Receive Debug register
indicates that there are packets in the receive queue, the receive
queue fill level is above the flow control activate threshold, and
the MAC itself hammers the network with pause frames as a result.)

Thus, I think that the fact that RPS isn't being signalled is entirely
reasonable and consistent with the available documentation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

