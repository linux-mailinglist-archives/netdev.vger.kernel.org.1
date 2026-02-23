Return-Path: <netdev+bounces-259951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGGwFoEanGkZ/wMAu9opvQ
	(envelope-from <netdev+bounces-259951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:14:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A4173A68
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5093D3021B85
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203E34D4FA;
	Mon, 23 Feb 2026 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KiksxFC9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C534D919
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838068; cv=none; b=b7j9Ivo1DDJ1EltWSJICE3o8vXOE0NvNpHaf5vrnDwdaFFbAZXEWCforOIA2CUENJMuD/fgepCqCgWeGQ5gtjkITfd5nXjkEIlFWEeOus8Va0fYEKUUxd3jEfoocdcrtTZ4PjTJIOBB9boi4JaBg1UxmkWJ9g/jbPtQYzG936wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838068; c=relaxed/simple;
	bh=X4oC/vhWn+CfSPjgxuXE7sRzHTIhY/EkcgL2Pdybg4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU23Y6Lj4QyjMZ2N4LBe7iFrwfyxVnrnlxBaWwmtYu30NgTZv2Z8dpSPYyf86jmgq4jJA52aOamLeLKW+qLOiH3clN4MeMzmGUqKNVr6zdQvpHCLy5Mz2dlne4MXILcla724c33R4nwoq2x/S2/tJa8HKZrpbgJteOr8AaNTe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KiksxFC9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e38xBZDKODM4kDYNok/7rea/GBA9QahZITvH7lZ/BSM=; b=KiksxFC9hojmtbLCVN1c6Dewq9
	84zgWOTvB+LiembkBMGG7H2XgRTvT9CgIe3PCwUCak1ewjrAe86LAJNWpidwyUFp399ubHJdwSqwD
	x7st+0OUEG3OKVrUUfwrSEl4IVmz7FwQZYF59tcSIEejndnHKM+Uy8RRnCQiacTkG9rxzxe/R+/i2
	lKy2mslsEAmGHGsY2/AqBVJOtdm0lwOgbd5llEyukhrOtDlmgKhGIjQqMvgx+qUv3pdVc8/WgnEKq
	4nsvlRonDthBkiHRyBMDf3OYag9/fS/oGMfI0FNjbE+tq0lQFPVYlVw/PbvHXuaLGNHFBd781kTdP
	tIoGkepw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35582)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vuS18-000000003kf-1VMq;
	Mon, 23 Feb 2026 09:14:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vuS13-000000007Fa-25Ca;
	Mon, 23 Feb 2026 09:14:09 +0000
Date: Mon, 23 Feb 2026 09:14:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	nicolas.ferre@microchip.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/5] net: cadence: macb: add IEEE 802.3az EEE
 support
Message-ID: <aZwaYXg_LBn4YiXN@shell.armlinux.org.uk>
References: <20260223090412.44070-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223090412.44070-1-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259951-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.969];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: DE1A4173A68
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:04:07AM +0100, Nicolai Buchwitz wrote:
> Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
> (macb) driver. The GEM MAC has hardware LPI registers but no built-in
> idle timer, so the driver implements software-managed TX LPI using a
> delayed_work timer, as recommended by Microchip's GMAC documentation.
> 
> The series is structured as follows:
> 
>   1. Register definitions: LPI counter offsets (0x270-0x27c), TXLPIEN
>      bitfield (NCR bit 19), and a MACB_CAPS_EEE capability flag.
> 
>   2. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
>      transitions and time) through ethtool -S, accumulated in software
>      since they are clear-on-read.
> 
>   3. TX LPI engine: A delayed_work-based idle timer that enters LPI
>      after 250ms of TX inactivity and wakes before transmit with a
>      conservative 50us PHY wake delay. LPI entry is deferred 1 second
>      after link-up per IEEE 802.3az.
> 
>   4. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
>      negotiation; the MAC-level TXLPIEN is controlled only from the
>      phylink mac_link_up/mac_link_down callbacks.

This needs a rewrite - phylink has EEE support now, with new callbacks
and configuration. There is no need to use the obsolete (and incorrect)
phy_init_eee() anymore.

Please see:

e9f03a6a879b net: phylink: add support for notifying PCS about EEE

and

03abf2a7c654 net: phylink: add EEE management

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

