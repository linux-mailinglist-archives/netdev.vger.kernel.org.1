Return-Path: <netdev+bounces-146864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB09D65D3
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36B32826B5
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0C176FD2;
	Fri, 22 Nov 2024 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g8RFOHnu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0115B13B;
	Fri, 22 Nov 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314857; cv=none; b=CjZavJwNPYJ600G2Wr2DZf7kU/DT7kuZVLx/aaIFyvOo+iFZZSHvmBvRb7JSlv2dBbg2slyOCRKvV5KlQCcne6eVnxKTrjcgbJoqLTvPeNYR69DHKGe5esg8/JKWVi8JAE+Av13BFVjNqgkd+daWuuhqIDZIo9/0OD3+KjZcxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314857; c=relaxed/simple;
	bh=7GDB4mVXo9o75acMRcBwekBFkoslTUKg6uqrKU2SUvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j31QWSJ/5LWpNLlWoeasplvtva2f6eKZ8NI8TxZ9o/zuYk/Z/Tq4w6aMKN7h6NDmpxIZ2a4iaIA9ct/mhIKvtpG0tjrjW4idkbPSAa+gKXqnl3olaPG+LaxHmiq3BGEipEadDYqo3XZVIF8n+FF1VZrpy0IMhJVEPQT/ED+oE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g8RFOHnu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U1ogUfqtSeVaKTjdUIilLdBnxMGMcSKrq8zvZ+ildys=; b=g8RFOHnuYMsJPC7H2OvIRbeYgZ
	duKcZjWqW2IoSwP9Ob033NJWa53Q5I32SjdP5zeUge4EL7EyQsD8Q7swrYFx2yBucxdFDGCMBu+jK
	9Ga1z+T8ZviqfFzztPNZ01gGCDTA+COiZaAE/PfJLQ/aWdNt1jheb6Ha3cTH1wDn6pAw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEcE3-00EAi9-UH; Fri, 22 Nov 2024 23:34:07 +0100
Date: Fri, 22 Nov 2024 23:34:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 13/21] motorcomm:yt6801: Implement some
 ethtool_ops function
Message-ID: <bd1c2858-c353-456f-865d-a9e85756e8f6@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-14-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-14-Frank.Sae@motor-comm.com>

> +static const struct fxgmac_stats_desc fxgmac_gstring_stats[] = {
> +	/* MMC TX counters */
> +	FXGMAC_STAT("tx_bytes", txoctetcount_gb),
> +	FXGMAC_STAT("tx_bytes_good", txoctetcount_g),
> +	FXGMAC_STAT("tx_packets", txframecount_gb),
> +	FXGMAC_STAT("tx_packets_good", txframecount_g),
> +	FXGMAC_STAT("tx_unicast_packets", txunicastframes_gb),
> +	FXGMAC_STAT("tx_broadcast_packets", txbroadcastframes_gb),
> +	FXGMAC_STAT("tx_broadcast_packets_good", txbroadcastframes_g),
> +	FXGMAC_STAT("tx_multicast_packets", txmulticastframes_gb),
> +	FXGMAC_STAT("tx_multicast_packets_good", txmulticastframes_g),
> +	FXGMAC_STAT("tx_vlan_packets_good", txvlanframes_g),
> +	FXGMAC_STAT("tx_64_byte_packets", tx64octets_gb),
> +	FXGMAC_STAT("tx_65_to_127_byte_packets", tx65to127octets_gb),
> +	FXGMAC_STAT("tx_128_to_255_byte_packets", tx128to255octets_gb),
> +	FXGMAC_STAT("tx_256_to_511_byte_packets", tx256to511octets_gb),
> +	FXGMAC_STAT("tx_512_to_1023_byte_packets", tx512to1023octets_gb),
> +	FXGMAC_STAT("tx_1024_to_max_byte_packets", tx1024tomaxoctets_gb),
> +	FXGMAC_STAT("tx_underflow_errors", txunderflowerror),
> +	FXGMAC_STAT("tx_pause_frames", txpauseframes),
> +	FXGMAC_STAT("tx_single_collision", txsinglecollision_g),
> +	FXGMAC_STAT("tx_multiple_collision", txmultiplecollision_g),
> +	FXGMAC_STAT("tx_deferred_frames", txdeferredframes),
> +	FXGMAC_STAT("tx_late_collision_frames", txlatecollisionframes),
> +	FXGMAC_STAT("tx_excessive_collision_frames",
> +		    txexcessivecollisionframes),
> +	FXGMAC_STAT("tx_carrier_error_frames", txcarriererrorframes),
> +	FXGMAC_STAT("tx_excessive_deferral_error", txexcessivedeferralerror),
> +	FXGMAC_STAT("tx_oversize_frames_good", txoversize_g),

Please look at the rmon group.

> +static void fxgmac_ethtool_get_drvinfo(struct net_device *netdev,
> +				       struct ethtool_drvinfo *drvinfo)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	u32 ver = pdata->hw_feat.version;
> +	u32 sver, devid, userver;
> +
> +	strscpy(drvinfo->version, pdata->drv_ver, sizeof(drvinfo->version));

Please leave this blank, so the core fills it with the git hash of the
kernel.

> +
> +	/* S|SVER: MAC Version
> +	 * D|DEVID: Indicates the Device family
> +	 * U|USERVER: User-defined Version
> +	 */
> +	sver = FXGMAC_GET_BITS(ver, MAC_VR_SVER_POS, MAC_VR_SVER_LEN);
> +	devid = FXGMAC_GET_BITS(ver, MAC_VR_DEVID_POS, MAC_VR_DEVID_LEN);
> +	userver = FXGMAC_GET_BITS(ver, MAC_VR_USERVER_POS, MAC_VR_USERVER_LEN);
> +
> +	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> +		 "S.D.U: %x.%x.%x", sver, devid, userver);

You might want to consider devlink, which gives you more flexibility
in reporting versions.

> +static void fxgmac_ethtool_set_msglevel(struct net_device *netdev, u32 msglevel)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +
> +	yt_dbg(pdata, "set msglvl from %08x to %08x\n", pdata->msg_enable,
> +	       msglevel);
> +	pdata->msg_enable = msglevel;

This is an example of a yt_dbg() which seems pointless now that you
have debugged it. Maybe you did have a bug in the first version of
this one line function, but it looks reasonably bug free now, so i
don't see the need for the print.

> +static void fxgmac_get_regs(struct net_device *netdev,
> +			    struct ethtool_regs *regs, void *p)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	u32 *regs_buff = p;
> +
> +	memset(p, 0, FXGMAC_PHY_REG_CNT * sizeof(u32));
> +	for (u32 i = MII_BMCR; i < FXGMAC_PHY_REG_CNT; i++)
> +		regs_buff[i] = phy_read(pdata->phydev, i);

A MAC driver should not be touching the PHY. There are other
standardised ways of dumping PHY registers, which don't involve the
MAC driver.

> +static void fxgmac_get_pauseparam(struct net_device *dev,
> +				  struct ethtool_pauseparam *data)
> +{
> +	struct fxgmac_pdata *yt = netdev_priv(dev);

Please be consistent with your naming. The function above calls this
pdata. I don't particularly like pdata, because that often means
platform_data, which you don't have. priv is more common.

> +	bool tx_pause, rx_pause;
> +
> +	phy_get_pause(yt->phydev, &tx_pause, &rx_pause);
> +
> +	data->autoneg = yt->phydev->autoneg;

This is wrong. You can be doing autoneg in general,
i.e. phydev->autoneg, but not using autoneg for pause. You should
remember the value set in set_pauseparam().

> +	data->tx_pause = tx_pause ? 1 : 0;
> +	data->rx_pause = rx_pause ? 1 : 0;

Why the ? 1: 0 ?

> +
> +	yt_dbg(yt, "%s, rx=%d, tx=%d\n", __func__, data->rx_pause,
> +	       data->tx_pause);
> +}
> +
> +static int fxgmac_set_pauseparam(struct net_device *dev,
> +				 struct ethtool_pauseparam *data)
> +{
> +	struct fxgmac_pdata *yt = netdev_priv(dev);
> +
> +	if (dev->mtu > ETH_DATA_LEN)
> +		return -EOPNOTSUPP;

A comment about why jumbo packets breaks pause would be good. I also
assume your set_mtu code disables pause when jumbo is enabled?
get_pauseparam should also make it clear pause is disabled.

> +	phy_set_asym_pause(yt->phydev, data->rx_pause, data->tx_pause);

You are ignoring ethtool_pauseparam autoneg.

> +static void fxgmac_ethtool_get_strings(struct net_device *netdev, u32 stringset,
> +				       u8 *data)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		for (u32 i = 0; i < FXGMAC_STATS_COUNT; i++) {
> +			memcpy(data, fxgmac_gstring_stats[i].stat_string,
> +			       strlen(fxgmac_gstring_stats[i].stat_string));
> +			data += ETH_GSTRING_LEN;
> +		}
> +		break;
> +	default:
> +		WARN_ON(1);

You need to be careful with WARN_ON() particularly if it can be
triggered from user space. Maybe build cause a WARN to result in a
reboot.

> +static int fxgmac_ethtool_reset(struct net_device *netdev, u32 *flag)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	int ret = 0;
> +	u32 val;
> +
> +	val = *flag & (ETH_RESET_ALL | ETH_RESET_PHY);
> +	if (!val) {
> +		yt_err(pdata, "Operation not support.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (*flag) {
> +	case ETH_RESET_ALL:
> +		fxgmac_restart(pdata);
> +		*flag = 0;
> +		break;
> +	case ETH_RESET_PHY:
> +		/* Power off and on the phy in order to properly
> +		 * configure the MAC timing
> +		 */
> +		ret = phy_modify(pdata->phydev, MII_BMCR, BMCR_PDOWN,
> +				 BMCR_PDOWN);
> +		if (ret < 0)
> +			return ret;
> +		fsleep(9000);
> +
> +		ret = phy_modify(pdata->phydev, MII_BMCR, BMCR_PDOWN, 0);
> +		if (ret < 0)
> +			return ret;
> +		*flag = 0;

This is a bad idea, since depending on the PHY, you have thrown away
all the configuration, and the PHY is now probably dead until you
admin down/admin up the interface. In general a MAC driver should
never directly touch the PHY, it should just use the API phylib
exposes.

    Andrew

---
pw-bot: cr

