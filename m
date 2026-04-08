Return-Path: <netdev+bounces-276377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGhdJ2If1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB8B3B9DDB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF843007E0D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555A2DCF74;
	Wed,  8 Apr 2026 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W0wsZ9dB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAF33F370
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640416; cv=none; b=qqkHtFkmRpZGm8/8/JkfQikOF8dcS5ucSQ7nMCFwKZoNJFkYUkfOwHCWR2oHfL8JNGKvj65ytuJbfgpYlMLUJcMhPl6DTw2esU4cM1qveAzVFdeyVSuqlsw3CEO7kZIJrQ7+hsGx2RouL8dIjPOXWzJYDsg4pTHUouB+WccvUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640416; c=relaxed/simple;
	bh=78Ko98hsaX/e+jcpdGnfKpNygfdhEIQpv5cJXvh7qnY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LneS1UtGuRIKehki3JnvrGIdPXnKoqxyDPcqxuXoc4kDNbEMwc5+yFBEgnl2SINMPPYdk314QD+y9WhYFbwmuVUcxtArb8ZS6Q00ftGPf+PAnTJV6RkQEQimQwTQgt8Y5s5H5mCiuqLsgZLzqisZr529W/+XN8V/h9iXg/QEVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W0wsZ9dB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=thoDyULEy80xUszvwV4YGikQLccE3AIuTyWYUwIhVXg=; b=W0wsZ9dB0ETevNMVK+H1yRd9hH
	0aInVnNI8+yuUzJaT7Vb8dekviS61nnKO2XOY2XL+f3bVvaKlw6lADcP+rK0b3pTDpEG+20EVTLZv
	ymF20IB4S3hIcVu7rL4GG8U/bAgIeqrpri3ISbzRCj2DQhsAn3c2nPO4VET++vxctzFxVfbyNvXpo
	ZSacx8uHAk7dAsHeAZ0WAvWKVcp08uNvTKYkZ+uWoJcbhjVdt+aAgVXyrfeTEokif0l3B8PeFvTvy
	E74o+PiL/MaoNof6/VE6HTKqOjetxSUhmPlndM2K+jaL4l7OU+tcZdyT+UHVYIJclsJcwzm3b0l2I
	p5/6iM9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47356)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAPB4-0000000022Z-27Wj;
	Wed, 08 Apr 2026 10:26:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAPAy-000000003Df-2tfK;
	Wed, 08 Apr 2026 10:26:20 +0100
Date: Wed, 8 Apr 2026 10:26:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: [PATCH RFC net-next 00/10] net: stmmac: clean up / fix synopsys IP
 version checks
Message-ID: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276377-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.264];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 0DB8B3B9DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Oh lookie, another relatively large stmmac patch series as a result of
reviewing Jitendra Vegiraju's patch series! Yay! :(

This series cleans up and in some cases fixes the Synopsys IP version
checks, which is a per-core numberspace.

For example, for dwmac1000 and dwmac4, we have versions such as v3.4 to
up v5.2, which are represented by two BCD digits. For XGMAC, we have
versions  v2.1 and v2.2 represented by 0x21 and 0x22 respectively. For
XLGMAC, we have v2.0, which is 0x20.

Note that hwif.c supports GMAC4 core type with the IP version in the
range 0..0x40, which overlaps with the GMAC core type.

Thus, testing the Synopsys IP version for <= v4.0 will match dwmac1000,
potentially some dwmac4, and all xgmac and xlgmac cores. In some cases,
the latter two are provably incorrect.

The Synopsys IP version is named "synopsys_id" in the driver - as
stated, it is the Synopsys IP version, and the register field is called
snpsver. Use this name throughout the driver to avoid confusion. Also,
dev_id seems to actually be userver.

The first decision making change is for dche, which is only looked at
by the dwmac4 DMA code which requires core_type == DWMAC_CORE_GMAC4.
Thus, it makes no sense to merely look at the IP version. Since setting
this to true makes no sense for non-GMAC4 cores, force it to false for
non-DWMAC_CORE_GMAC4 cores.

The MAC .debug() method is only populated by the dwmac1000 and dwmac4
cores, yet the test checks only for the IP version >= v3.5. While this
works today, it may not work in the future given the different version
numberspaces. Make this conditional on DWMAC_CORE_GMAC or GMAC4 core
types to limit the version check. Ideally, it would be better to
move the version check inside the .dwbug() method implementation, but
that would require the method signature to change.

As getting to that point involved quite a bit of research, add comments
into stmmac_get_ethtool_stats() so others don't have to re-analyse the
code.

Clean up the resulting code in stmmac_get_ethtool_stats() given the
complexity, adding documentation for each test.

Address the rx_coe handling, which checks for IP version >= v4.0 or
the XGMAC core type. However, the members being printed are only
present in the GMAC4 and XGMAC core type in one path, and GMAC in
the other. There is an odd-ball which is sun8i, but we preserve its
current behaviour. Also, given the research, add documentation in
appropriate places. Note that priv->plat->rx_coe (and also
priv->hw->rx_csum) has different value spaces depending on the core
type - which is not nice.

Lastly, make the printing of the COE type, which as identified above,
depend on the GMAC core type.

This leaves four locations unaddressed:

1) PTP filter code:
                case HWTSTAMP_FILTER_PTP_V2_EVENT:
                        /* PTP v2/802.AS1 any layer, any kind of event packet */
                        config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
                        ptp_v2 = PTP_TCR_TSVER2ENA;
                        snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
                        if (priv->snpsver < DWMAC_CORE_4_10)
                                ts_event_en = PTP_TCR_TSEVNTENA;

I don't yet have an answer for this one, but it does mean that
PTP_TCR_TSEVNTENA will be set for XGMAC cores for
HWTSTAMP_FILTER_PTP_V2_EVENT... if they have PTP support.

2) riwt watchdog:
        /* Rx Watchdog is available in the COREs newer than the 3.40.
         * In some case, for example on bugged HW this feature
         * has to be disable and this can be done by passing the
         * riwt_off field from the platform.
         */
        if ((priv->snpsver >= DWMAC_CORE_3_50 ||
             priv->plat->core_type == DWMAC_CORE_XGMAC) &&
            !priv->plat->riwt_off) {
                priv->use_riwt = 1;

This to me looks like the version check is only really applicable for
the DWMAC_CORE_GMAC core type. So, I'm thinking that:

	if (priv->plat->core_type >= DWMAC_CORE_GMAC4 ||
	    (priv->plat->core_type == DWMAC_CORE_GMAC &&
	     priv->snpsver >= DWMAC_CORE_3_50)) {
		if (!priv->plat->rwit_off) {
		...

would be clearer (note the splitting of the if() conditions which seems
to me would be more readable than trying to munge it all into one
expression.)

3) max_mtu setup:
        /* Set the maximum MTU.
         *  For XGMAC cores, 16KiB.
         *  For cores using enhanced descriptors or GMAC cores >= v4.00, 9kB.
         *  For everything else, PAGE_SIZE - NET_SKB_PAD - NET_IP_ALIGN -
         *   aligned skb_shared_info.
         */
        if (priv->plat->core_type == DWMAC_CORE_XGMAC)
                ndev->max_mtu = XGMAC_JUMBO_LEN;
        else if (priv->plat->enh_desc || priv->snpsver >= DWMAC_CORE_4_00)
                ndev->max_mtu = JUMBO_LEN;
        else
                ndev->max_mtu = SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN);

which I've previously identified is very buggy, and I'm not sure what
the real tests here should be. I'm quite certain that the max_mtu
values are basically completely wrong, especially in the last case.
This needs a lot of analysis and comparing with documentation to get
to the bottom of what the tests and resulting max_mtu values should
actually be.

 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         | 54 +++++++++++-----------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 51 +++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 24 ++++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  8 ++--
 include/linux/stmmac.h                             |  7 +++
 9 files changed, 85 insertions(+), 67 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

