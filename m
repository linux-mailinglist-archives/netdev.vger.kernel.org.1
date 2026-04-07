Return-Path: <netdev+bounces-276060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO6GHNcm1WnB1gcAu9opvQ
	(envelope-from <netdev+bounces-276060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:46:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6C63B13E0
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FFC2302E192
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BEE3CD8C3;
	Tue,  7 Apr 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Um8vfHvO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320E3C5553;
	Tue,  7 Apr 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576583; cv=none; b=LUuGRau0/xpSN2oTGZWgxoqd+g/ih6xu6ou+/N7LLuzO+7tN++ha73/iKCUZ6nP6Ndia0FkexZidTRIgsWExyOsyqSPfDB4KSt8+bFoI605Wbztz4rfrtkgx+RfEdpWqhXV5NVrognxpt097mRuVmLIN1ttWHJzn+zgTYaTVYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576583; c=relaxed/simple;
	bh=VYbzcb2pPCHBh0xbTYEVbIxE7G9rBtWYie2k5BiQOJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvC/ZknN+XoqxSZTAeZ5zDdPWuiurDGaioX0YrXulEZiKgwkXy3fJ5hP+u2YIfUWNW/LMOvcDEf+p0uhL5TjWAXpjK2Xp+OPLlmIsT+Hp1sMqxfBoPSWlpdh9Fb34ncdK91zYjsAxhVXbGlBTdgcv1lFY87koEr1rNcdFEGC+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Um8vfHvO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K6eG3w8oiPUCd97QZfkNIfRJmJJfLCqermLxkdTt38E=; b=Um8vfHvOGVLnBSi1YYwENGR4vX
	XA9btB41CoP26mDXUqrtPLuhlFVMsmt228uPgpV4TCuJ4Q9lXEKBrCH1g1BirZsPmK6H4ovx1dfrU
	bliXp1c/yaX7FOvcBCsv9pi1DgKRLhYCu+qWx9mXArKxw2FBiaRX4JFBW7QO51ca+1yFZNjqUNIDc
	X0ELogoWHD2b2nUBtmTIyB4N5zHG8VlicmoObcg8z5abng0crlcXhIC8XRx4YhXlMUV4RX1HQnKVn
	oxzkDqMh7nXOSRDwL/xfbmk19ErBXMmJtRmDTIPU3nftLTBKJGERrp8cERvtF/DV+cMrGTxOcJclb
	x3uyXA8w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA8Zd-0000000017q-03UP;
	Tue, 07 Apr 2026 16:42:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA8ZT-000000002NZ-2JxT;
	Tue, 07 Apr 2026 16:42:31 +0100
Date: Tue, 7 Apr 2026 16:42:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	me@ziyao.cc, siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com, wens@kernel.org,
	vladimir.oltean@nxp.com, lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com, yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org,
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 1/4] net: stmmac: Add DW25GMAC support in
 stmmac core driver
Message-ID: <adUl51QqkeVAd_Pa@shell.armlinux.org.uk>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
 <20260402213629.1996133-2-jitendra.vegiraju@broadcom.com>
 <adUQHHBD0d3p1OSI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adUQHHBD0d3p1OSI@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.290];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url,broadcom.com:email]
X-Rspamd-Queue-Id: 5B6C63B13E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 03:09:32PM +0100, Russell King (Oracle) wrote:
> Not withstanding my comment about the other Synopsys xlgmac driver that
> we have in the kernel...
> 
> On Thu, Apr 02, 2026 at 02:36:26PM -0700, Jitendra Vegiraju wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > 
> > The DW25GMAC introduced a new DMA architecture called Hyper-DMA (HDMA) for
> > virtualization scalability. This is realized by decoupling physical DMA
> > channels(PDMA) from potentially large number of virtual DMA channels(VDMA).
> > The VDMAs provide software abstraction to driver that map to PDMAs for
> > frame transmission and reception.
> > Since 25GMAC is a derivative of XGMAC, majority of IP is common to both.
> > 
> > To add support for the HDMA in 25GMAC, a new instance of dma_ops,
> > dw25gmac400_dma_ops is introduced.
> > To support the current needs, a simple one-to-one mapping of dw25gmac's
> > logical VDMA (channel) to TC to PDMAs is used. Most of the other dma
> > operation functions in existing dwxgamc2_dma.c file are reused whereever
> 
> Typo: dwxgmac2_dma.c
> 
> > applicable.
> > Added setup function for DW25GMAC's stmmac_hwif_entry in stmmac core.
> 
> In a previous review, I questioned the use of DWMAC_CORE_25GMAC and
> asked about its version numberspace. I believe you indicated that the
> version numberspace is the same as the existing XGMAC core.
> 
> I'm going to question the value of adding DWMAC_CORE_25GMAC.
> 
> 1. What is the value of splitting DWMAC_CORE_25GMAC from
>    DWMAC_CORE_XGMAC given that it's in the same versioning numberspace
>    as XGMAC, and most tests (via dwmac_is_xgmac()) test for XGMAC or
>    25GMAC?
> 
> 2. Have you reviewed all the places that explicitly test for
>    DWMAC_CORE_XGMAC, looking at their "false" paths (for non-XGMAC
>    cores) to determine whether they are suitable? For example:
> 
>         if (priv->plat->core_type == DWMAC_CORE_XGMAC)
>                 ndev->max_mtu = XGMAC_JUMBO_LEN;
>         else if (priv->plat->enh_desc || priv->synopsys_id >= DWMAC_CORE_4_00)
>                 ndev->max_mtu = JUMBO_LEN;
>         else
>                 ndev->max_mtu = SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN);
> 
>    XGMAC can handle a max MTU of 16368, but with your code using
>    DWMAC_CORE_25GMAC, we fall back to the next test, which tests the
>    IP version against 0x40, and uses a max MTU of 9000. Given that
>    DWMAC_CORE_4_00 is a different "version number space" this seems
>    wrong.

This is actually wrong - for DWMAC_CORE_25GMAC with a synopsys_id
less than 0x40, this will fall back to SKB_MAX_HEAD(NET_SKB_PAD +
NET_IP_ALIGN) which is as good as "pluck a number out of the air
and watch the driver fall over if you increase the MTU to maximum".
max_mtu ends up being dependent on the system page size, not on any
hardware limitation, which is garbage.

> 3. Looking at the MDIO code, this looks very wrong if you're
>    introducing DWMAC_CORE_25GMAC. Have you tested MDIO accesses?
> 
>    dwxgmac2_setup() is called for DWMAC_CORE_XGMAC core-type. In
>    stmmac_mdio_register(), DWMAC_CORE_XGMAC uses different functions
>    for MDIO bus access for C22 and C45 from other cores - it uses the
>    stmmac_xgmac2_mdio_* functions.
> 
>    These use stmmac_xgmac2_c45_format() and stmmac_xgmac2_c22_format()
>    to format the register values which do not depend on mii.*_mask, but
>    do use mii.address and mii.data for the register offsets. Thus, is
>    there any point to setting mii.addr_mask and mii.reg_mask ?
> 
>    For non-DWMAC_CORE_XGMAC cores, we fall back to the stmmac_mdio_*()
>    functions, which for non-DWMAC_CORE_GMAC4 will only support Clause
>    22 access, not Clause 45 - which would be very strange for a 25G
>    core.
> 
> 4. What about the feature printing in
>    stmmac_main.c::stmmac_dma_cap_show() ?
> 
> 5. What about similar tests in stmmac_est.c and stmmac_ethtool.c ?

Another issue that needs to be looked into is all the tests that
check priv->synopsys_id without checking the core_type. I'm already
concerned that many of these are wrong.

I have some patches now that rename synopsys_id to snpsver (it's really
the Synopsys IP version field which is BCD of the major version and
first digit of the minor version, not some random ID that identifies
the core.)

From what I've ascertained so far:

    GMAC100 cores do not have a readable snpsver number, thus this
    will be zero.

    GMAC cores generally have a snpsver number less than 0x40.

    GMAC4 cores may have a version number that overlaps GMAC cores
    (see first entry for DWMAC_CORE_GMAC4).

    XGMAC and XLGMAC cores each have an entirely separate IP version
    number space from GMAC and GMAC4, which are distinguished by their
    respective userver.

For example:

        /* Only DWMAC core version 5.20 onwards supports HW descriptor prefetch.
         */
        if (priv->snpsver < DWMAC_CORE_5_20)
                priv->plat->dma_cfg->dche = false;

This will match your 25GMAC cores and the XGMAC cores because they have
a Synopsys IP version number less than 0x52. What saves us there is
that dche is only read by dwmac4_dma_init(), used by dwmac4_dma_ops and
dwmac410_dma_ops. These are all used by hwif entries that require
priv->plat->core_type to be DWMAC_CORE_GMAC4. Thus, I'm changing this
one to:

        /* Only DWMAC4 core version 5.20 onwards support HW descriptor prefetch.
         */
        if (priv->plat->core_type != DWMAC_CORE_GMAC4 ||
            priv->snpsver < DWMAC_CORE_5_20)
                priv->plat->dma_cfg->dche = false;

although I'm wondering if that should really be == && to avoid writing
to it for non-GMAC4 cores (it really doesn't matter.)

Then there this:

                case HWTSTAMP_FILTER_PTP_V2_EVENT:
                        /* PTP v2/802.AS1 any layer, any kind of event packet */
                        config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
                        ptp_v2 = PTP_TCR_TSVER2ENA;
                        snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
                        if (priv->snpsver < DWMAC_CORE_4_10)
                                ts_event_en = PTP_TCR_TSEVNTENA;

Is PTP_TCR_TSEVNTENA needed for this PTP filter type for XGMAC and
25GMAC cores - because they'll get it because they have snpsver
smaller than 0x41.

Similar here:

        if (priv->plat->rx_coe) {
                priv->hw->rx_csum = priv->plat->rx_coe;
                dev_info(priv->device, "RX Checksum Offload Engine supported\n")+;
                if (priv->snpsver < DWMAC_CORE_4_00)
                        dev_info(priv->device, "COE Type %d\n", priv->hw->rx_csu+m);
        }

In stmmac_ethtool.c, stmmac_mac_debug() won't be called for XGMAC or
25GMAC cores, because:

                if (priv->snpsver >= DWMAC_CORE_3_50)
                        stmmac_mac_debug(priv, priv->ioaddr,
                                        (void *)&priv->xstats,
                                        rx_queues_count, tx_queues_count);

snpsver (synopsys_id) will be smaller than 0x35. Is this correct?

The good news is that stmmac_mdio.c at gates all its checks on the
Synopsys IP version against the core type.

I'll post my RFC patches tidying up some of the version mess in the
next day or so.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

