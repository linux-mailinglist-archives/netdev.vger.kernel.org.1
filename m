Return-Path: <netdev+bounces-128697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D7997B169
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D62C1F22598
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25145176227;
	Tue, 17 Sep 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u6zD4BP8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DC2D045;
	Tue, 17 Sep 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583357; cv=none; b=os3LOXxFeJF1iywHJmmN5RCUMjvXT7M07aUN5vrf6bvf25hdSsIzOzoS9T0cRvYHBcxENO+s6MPs7dJhdn75xNpQGdApRbCGrN34YZZlMQWpWvNO9e9RJcaHi4irTPP+ZQJhxRmnVPE50BCqiWcF0PlS/fM3m7wvs5EqE3qXSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583357; c=relaxed/simple;
	bh=ZP6XQprDxJyMq8EJeXV+IkTjSp4IQ2U2+3oVieAYruI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf9XdhjdSUElqQukRAyqJkuOx/lIKlGx3VlkZPbOjRCnpRFfrNyfUzvVhsaehNUDRDXWyqAYVYvY8AI1tA8LFgz1CIKjziodKXUw+6LTFKck8FDtLNPZ2WTz65TXygF46m6KOogADGJe2XEiq2ggvmrWzjkyOf8WQTIBsxxYDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u6zD4BP8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XG6yf4g+joT5ilCykaPZRer5B3JSc7Iv+1l8SYUUTg8=; b=u6zD4BP8vmUtfQFC66N3aCxTtY
	EEIwK1kfmz1NgN/+6YmDH2h1n0lE/mcoUYD4uwE5e+/qZ/j7uhpaPoz3ZWkPCB9j7BiSRN4XN4+S1
	NaFIGVV7HSCW70Kwfq3WOFHuibVLQ1+lzINKVjkWTct/41nGNKdNEyLDnTmkezsBkPmbgRjFJGStX
	drg2CeQKV1Kr0sykKS4i64JpRAT3nnvVXLTp/1+S5SNLdjXqm7rwsAdUv9kjDM0sekOQZEIZHqVCR
	6eta9BuPyH9vZxP5chVSRItuN4o5v5mLsm27pIiQX2G1qGQ2MRku9J6UY3rsCD/2szqSJfrNWS84M
	bhwHXvoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34884)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqZCP-00070m-17;
	Tue, 17 Sep 2024 15:29:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqZCM-00082i-0N;
	Tue, 17 Sep 2024 15:28:58 +0100
Date: Tue, 17 Sep 2024 15:28:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V4] net: phy: microchip_t1: SQI support for
 LAN887x
Message-ID: <ZumSKSI6vMfR61wP@shell.armlinux.org.uk>
References: <20240917115657.51041-1-tarun.alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917115657.51041-1-tarun.alle@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 17, 2024 at 05:26:57PM +0530, Tarun Alle wrote:
> From: Tarun Alle <Tarun.Alle@microchip.com>
> 
> Add support for measuring Signal Quality Index for LAN887x T1 PHY.
> Signal Quality Index (SQI) is measure of Link Channel Quality from
> 0 to 7, with 7 as the best. By default, a link loss event shall
> indicate an SQI of 0.
> 
> Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>

Please note that the merge window is open, which means that net-next is
currently closed. Thus, patches should be submitted as RFC.

> ---
> v3 -> v4
> - Added check to handle invalid samples.
> - Added macro for ARRAY_SIZE(rawtable).
> 
> v2 -> v3
> - Replaced hard-coded values with ARRAY_SIZE(rawtable).
> 
> v1 -> v2
> - Replaced hard-coded 200 with ARRAY_SIZE(rawtable).

Hmm. We've been through several iterations trying to clean this up
into something more easily readable, but I fear there'll be another
iteration.

Maybe the following would be nicer:

enum {
	SQI_SAMPLES = 200,
	/* Look at samples of the middle 60% */
	SQI_INLIERS_NUM = SQI_SAMPLES * 60 / 100,
	SQI_INLIERS_START = (SQI_SAMPLES - SQI_INLIERS_NUM) / 2,
	SQI_INLIERS_END = SQI_INLIERS_START + SQI_INLIERS_NUM,
};

> +static int lan887x_get_sqi_100M(struct phy_device *phydev)
> +{
> +	u16 rawtable[200];

	u16 rawtable[SQI_SAMPLES];

> +	u32 sqiavg = 0;
> +	u8 sqinum = 0;
> +	int rc;

Since you use "i" multiple times, declare it at the beginning of the
function rather than in each for loop.

	int i;

> +
> +	/* Configuration of SQI 100M */
> +	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +			   LAN887X_COEFF_PWR_DN_CONFIG_100,
> +			   LAN887X_COEFF_PWR_DN_CONFIG_100_V);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_SQI_CONFIG_100,
> +			   LAN887X_SQI_CONFIG_100_V);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_SQI_CONFIG_100);
> +	if (rc != LAN887X_SQI_CONFIG_100_V)
> +		return -EINVAL;
> +
> +	rc = phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_POKE_PEEK_100,
> +			    LAN887X_POKE_PEEK_100_EN,
> +			    LAN887X_POKE_PEEK_100_EN);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Required before reading register
> +	 * otherwise it will return high value
> +	 */
> +	msleep(50);
> +
> +	/* Link check before raw readings */
> +	rc = genphy_c45_read_link(phydev);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!phydev->link)
> +		return -ENETDOWN;
> +
> +	/* Get 200 SQI raw readings */
> +	for (int i = 0; i < ARRAY_SIZE(rawtable); i++) {

	for (i = 0; i < SQI_SAMPLES; i++) {

> +		rc = phy_write_mmd(phydev, MDIO_MMD_VEND1,
> +				   LAN887X_POKE_PEEK_100,
> +				   LAN887X_POKE_PEEK_100_EN);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1,
> +				  LAN887X_SQI_MSE_100);
> +		if (rc < 0)
> +			return rc;
> +
> +		rawtable[i] = (u16)rc;
> +	}
> +
> +	/* Link check after raw readings */
> +	rc = genphy_c45_read_link(phydev);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!phydev->link)
> +		return -ENETDOWN;
> +
> +	/* Sort SQI raw readings in ascending order */
> +	sort(rawtable, ARRAY_SIZE(rawtable), sizeof(u16), data_compare, NULL);

	sort(rawtable, SQI_SAMPLES, sizeof(u16), data_compare, NULL);

Although renaming data_compare to sqi_compare would be even more
descriptive of what it's doing.

> +
> +	/* Keep inliers and discard outliers */
> +	for (int i = SQI100M_SAMPLE_INIT(5, rawtable);
> +	     i < SQI100M_SAMPLE_INIT(5, rawtable) * 4; i++)

	for (i = SQI_INLIERS_START; i < SQI_INLIERS_END; i++)

> +		sqiavg += rawtable[i];
> +
> +	/* Handle invalid samples */
> +	if (sqiavg != 0) {
> +		/* Get SQI average */
> +		sqiavg /= SQI100M_SAMPLE_INIT(5, rawtable) * 4 -
> +				SQI100M_SAMPLE_INIT(5, rawtable);

		sqiavg /= SQI_INLIERS_NUM;

Overall, I think this is better rather than the SQI100M_SAMPLE_INIT()
macro... for which I'm not sure what the _INIT() bit actually means.

I think my suggestion has the advantage that it makes it clear what
these various calculations are doing, because the result of the
calculations is described in the enum name.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

