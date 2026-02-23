Return-Path: <netdev+bounces-259980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L+fNs8nnGl1AAQAu9opvQ
	(envelope-from <netdev+bounces-259980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:11:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103F1749DE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1BC2303ACAD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB935BDAF;
	Mon, 23 Feb 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J5nZI/vX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487F35B642
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841276; cv=none; b=RgFHHcqVe0UTSyV1hGOndeRUKpIGO7sb91aOQdTJK1Ts5Xzozw3dNXNFFRdbX20lPQERFh5fshj4/JoveqEWbVtySSXaH2G5va3EZE7lJEWCMUGLLhqg6rzu3bb9rZnKZhTzu/hhdnIeTSUU4eGP71Jiyg9BK6uciZU1mgDNBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841276; c=relaxed/simple;
	bh=SZ727JdPXMEqooyw2d5ESvbW3cot8nxsxOqNTESGnXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F82Q0KJ1/XpuyA6bPyAq03BsQFyfDibxMyUYNrMnxZANSnCyC9Ei7b8iIqOtVxguhhXAD93qs7I6bvNl1bB3h/67gG+vV1wMgPvB3pO20rHaLiL0FjiZ8PwSCsvDjss6jNFz628N8pHoVIg4my1picylY3ZBmutaEbyAYYfB3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J5nZI/vX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gAp/Xg1nrnX4CiArHXttC08M3mYE00ggXxk3KAY2KO8=; b=J5nZI/vXl3NlDxISK8Fkvayd0f
	MrwBytlWFNsqhWpZgH79CGIH1MaylTsiWyZCWenNN7HhWaDcGDfNeyUFk6CEIUr2kW3ZChMBmZlLl
	LMRQlj8i6TD9YrshWYigi5okYuVdi/hxb3P/esau2lOGuiuox5kwnti/96pou2CALdsinihPYiUKt
	dRFWUYMVnfKZyevstIpbjc0QCDGkbNRm/fX4gQV9+lvdef7XGMmft5JNtORUswvILHj+Qfcr+D8bp
	5FuB2dI5B0l4XcIBRJyjKdUhlBjWjeR5sSvYs71ZtgswSiKYmcU/e9OnDeKhzUyeX+MnVUacYjBWs
	Kx7jp+5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36848)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vuSr2-000000003sm-10QK;
	Mon, 23 Feb 2026 10:07:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vuSr0-000000007H1-0pZv;
	Mon, 23 Feb 2026 10:07:50 +0000
Date: Mon, 23 Feb 2026 10:07:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nicolas.ferre@microchip.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 3/5] net: cadence: macb: implement EEE TX LPI
 support
Message-ID: <aZwm9u_xCbuXCkDX@shell.armlinux.org.uk>
References: <20260223090412.44070-1-nb@tipi-net.de>
 <20260223090412.44070-4-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223090412.44070-4-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259980-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.967];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 8103F1749DE
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:04:10AM +0100, Nicolai Buchwitz wrote:
> Implement software-managed TX Low Power Idle (LPI) for the Cadence GEM
> MAC as part of IEEE 802.3az Energy Efficient Ethernet support.
> 
> The GEM MAC has no built-in idle timer - the TXLPIEN bit (NCR bit 19)
> immediately asserts LPI and blocks all TX while set. The MAC does not
> auto-wake for transmit. Per Microchip GMAC documentation (section
> 40.6.19): "It is best to use firmware to control LPI."
> 
> This patch implements a software idle timer using delayed_work:
> - On TX completion with an empty ring, schedule LPI entry after a
>   configurable idle timeout (default 250ms). The work function
>   verifies all TX queues are truly idle before entering LPI to
>   prevent entering LPI while traffic is still active.
> - On TX start, wake from LPI by clearing TXLPIEN, cancelling any
>   pending re-entry, and waiting 50us for the PHY to exit LPI
>   (conservative vs IEEE 802.3az Tw_sys of ~17us/~30us)
> - On link up, check EEE negotiation via phy_init_eee() and defer
>   first LPI entry by 1 second per IEEE 802.3az requirements
> - On link down, immediately cancel pending work and clear TXLPIEN
> 
> The timer value is configurable at runtime via ethtool --set-eee
> tx-timer.
> 
> The implementation is gated on MACB_CAPS_EEE so platforms must
> explicitly opt in via their macb_config.

In addition to my comments, please check the nipabot status for this
patch which can be found at:

https://patchwork.kernel.org/project/netdevbpf/patch/20260223090412.44070-4-nb@tipi-net.de/

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

