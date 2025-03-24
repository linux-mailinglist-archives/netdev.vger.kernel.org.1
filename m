Return-Path: <netdev+bounces-177099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBFA6DD81
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A73A83DF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D425FA36;
	Mon, 24 Mar 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RNxgZ5NE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218C25F986;
	Mon, 24 Mar 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828166; cv=none; b=soPINecXnYbAtxswArNzb/C4a94k36xJIlfzX0yFHCRNCky45gTaT9zuFw0LNzyJiOxsYB51Oh+fE8ISMQw8D4dawLbwipVKKQWcNcKamziHcmpngD/yeetX6Gr1aGfl1cc7p+zZnOGe7JP2sjSLUxB7UOOKGaOPa6/1E0ADO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828166; c=relaxed/simple;
	bh=aJtROEr0p4QqFHVIFesS50f9Sn8u07RSp+2NpoUYgtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmdje9mJJrBWb/bRSDU2yTqXbTUPt1lDjwrDv+vYDz7ETQf516Kt2vo1TY81jz/6+1Pj+4nvnZ+aU5/6Zx9TnAOZ+hhyP9IqhmchlitfZcPJLLEbxVcDXp3jsB+7aq5H9bJauCnflqpUbl40ToIxbBgCUo/C6zOxtYcgpOtz/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RNxgZ5NE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z0WKSF5GzBb+pmeXkSnUp4O1kxJLVDjr8oStmoA+P7c=; b=RNxgZ5NEnVGPgjYZu79iK/oB6F
	HN3lPNZVjpH42XQWXmDubPn8tTMIus7z7HiAYeO2LFmLBo9JSHcKrF9R80CERENuV1Nwl8Gxj46v3
	vEYCZrj+lP3ZlIIgnWqxYNWK3rIWqcZfSE2KeBe+M1xEY+FVTHUrGyyvM2RrxkQJFDFNVZ0VY/LQT
	HAimw1IhPlud60qVuACBuRTURPXsyxclsfkatdjO6y9AKwS+hDkOCsUqluRGT/Ogxo5dlSSScy8hb
	Ttwlsj9iThqF8goILtfVpItrp7JamSnGcri1z6SPoZ6jEruAAa9qhhTFoKVgL2p5cYdREUYh+Uwj5
	wZLvDqVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46752)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twjDR-0003gk-10;
	Mon, 24 Mar 2025 14:55:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twjDO-0002KC-1V;
	Mon, 24 Mar 2025 14:55:46 +0000
Date: Mon, 24 Mar 2025 14:55:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <Z-FycizAnGoxQLOj@shell.armlinux.org.uk>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323225439.32400-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

First, please include a cover message whenever you send a patch series.

On Sun, Mar 23, 2025 at 11:54:26PM +0100, Christian Marangi wrote:
> Add support for new Aeonsemi 10G C45 PHYs. These PHYs intergate an IPC
> to setup some configuration and require special handling to sync with
> the parity bit. The parity bit is a way the IPC use to follow correct
> order of command sent.
> 
> Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> before the firmware is loaded.

Hmm. That behaviour is really not nice for the kernel to deal with. C45
PHYs have multiple IDs (there's registers 2,3 and also 14,15, each is
per MMD). Do they all have the same value? Do any of them indicate any
kind of valid OUI ?

If there is no way to sanely detect this PHY, then I would suggest that
it is beyond the ability of the kernel, and at the very least, an
initial firmware version needs to be loaded by board boot firmware so
the PHY _can_ be properly identified.

Basically, it isn't the kernel's job to fix such broken hardware.

> +#define VEND1_LED_REG(_n)		(0x1800 + ((_n) * 0x10))
> +#define   VEND1_LED_REG_A_EVENT		GENMASK(15, 11)
> +#define     VEND1_LED_REG_A_EVENT_ON_10 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x0)
> +#define     VEND1_LED_REG_A_EVENT_ON_100 FIELD_PREP_CONST(VEND1_LED_REG_A_EVENT, 0x1)

I really don't like the pattern of "define constants using
FIELD_PREP*()". It seems to me it misses the entire point of the
bitfield macros, which is to prepare and extract bitfields.

When I see:

	swith (foo & BLAH_MASK) {
	case BLAH_OPTION_1:
		...

where BLAH_OPTION_1 is defined using FIELD_PREP*(), it just
makes me shudder.

	SWITCH (FIELD_GET(BLAH_MASK, foo)) {
	case BLAH_OPTION_1:
		...

where BLAH_OPTION_1 is defined as the numerical field value is much
more how the bitfield stuff is supposed to be used.

> +enum {
> +	MDIO_AN_C22 = 0xffe0,

I'd suggest defining this in a driver private namespace, rather than
using the MDIO_xxx which is used by linux/mdio.h

> +	/* Exit condition logic:
> +	 * - Wait for parity bit equal
> +	 * - Wait for status success, error OR ready
> +	 */
> +	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
> +					FIELD_GET(AEON_IPC_STS_PARITY, val) ==
> +						curr_parity &&
> +					(val & AEON_IPC_STS_STATUS) !=
> +						AEON_IPC_STS_STATUS_RCVD &&
> +					(val & AEON_IPC_STS_STATUS) !=
> +						AEON_IPC_STS_STATUS_PROCESS &&
> +					(val & AEON_IPC_STS_STATUS) !=
> +						AEON_IPC_STS_STATUS_BUSY,
> +					10000, 2000000, false);

Use an inline function, and also please wrap a bit tighter, val seems to
wrap.

	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS,
					val, aeon_cmd_done(curr_parity, val),
					10000, 2000000, false);

> +	if (ret)
> +		return ret;
> +
> +	*ret_sts = val;
> +	if ((val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_SUCCESS)
> +		return -EFAULT;

EFAULT means "Bad address". Does not returning successful status mean
that there was a bad address? If not, please don't do this.

EFAULT is specifically used to return to userspace to tell it that it
passed the kernel a bad address.

> +
> +	return 0;
> +}
> +
> +static int aeon_ipc_send_msg(struct phy_device *phydev, u16 opcode,
> +			     u16 *data, unsigned int data_len, u16 *ret_sts)
> +{
> +	u32 cmd;
> +	int ret;
> +	int i;
> +
> +	if (data_len > AEON_IPC_DATA_MAX)
> +		return -EINVAL;
> +
> +	for (i = 0; i < data_len / sizeof(u16); i++)
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
> +			      data[i]);

What ensures that this won't overflow the number of registers?

> +
> +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
> +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
> +	ret = aeon_ipc_send_cmd(phydev, cmd, ret_sts);
> +	if (ret)
> +		phydev_err(phydev, "failed to send ipc msg for %x: %d\n", opcode, ret);
> +
> +	return ret;
> +}
> +
> +static int aeon_ipc_rcv_msg(struct phy_device *phydev, u16 ret_sts,
> +			    u16 *data)
> +{
> +	unsigned int size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
> +	int ret;
> +	int i;
> +
> +	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
> +		return -EINVAL;
> +
> +	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
> +		if (ret < 0)
> +			return ret;
> +
> +		data[i] = ret;

Unsafe. AEON_IPC_STS_SIZE is 5 bits in size, which means this can write
indexes 0..31. You pass in a buffer of 8 u16's on the stack. What stops
the hardware engaging in stack smashing... nothing. Please code more
carefully.

> +	}
> +
> +	return size;
> +}
> +
> +/* Logic to sync parity bit with IPC.
> + * We send 2 NOP cmd with same partity and we wait for IPC
> + * to handle the packet only for the second one. This way
> + * we make sure we are sync for every next cmd.
> + */
> +static int aeon_ipc_sync_parity(struct phy_device *phydev)
> +{
> +	struct as21xxx_priv *priv = phydev->priv;
> +	u16 ret_sts;
> +	u32 cmd;
> +	int ret;
> +
> +	/* Send NOP with no parity */
> +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, 0) |
> +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_NOOP);
> +	aeon_ipc_send_cmd(phydev, cmd, NULL);
> +
> +	/* Reset packet parity */
> +	priv->parity_status = false;
> +
> +	/* Send second NOP with no parity */
> +	ret = aeon_ipc_send_cmd(phydev, cmd, &ret_sts);
> +	/* We expect to return -EFAULT */
> +	if (ret != -EFAULT)
> +		return ret;
> +
> +	if ((ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_READY)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> +{
> +	u16 ret_data[8], data[1];
> +	u16 ret_sts;
> +	int ret;
> +
> +	data[0] = IPC_INFO_VERSION;
> +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data, sizeof(data),
> +				&ret_sts);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	phydev_info(phydev, "Firmware Version: %s\n", (char *)ret_data);
> +
> +	return 0;
> +}
> +
> +static int aeon_dpc_ra_enable(struct phy_device *phydev)
> +{
> +	u16 data[2];
> +	u16 ret_sts;
> +
> +	data[0] = IPC_CFG_PARAM_DIRECT;
> +	data[1] = IPC_CFG_PARAM_DIRECT_DPC_RA;
> +
> +	return aeon_ipc_send_msg(phydev, IPC_CMD_CFG_PARAM, data,
> +				 sizeof(data), &ret_sts);
> +}
> +
> +static int as21xxx_probe(struct phy_device *phydev)
> +{
> +	struct as21xxx_priv *priv;
> +	int ret;
> +
> +	phydev->priv = devm_kzalloc(&phydev->mdio.dev,
> +				    sizeof(*priv), GFP_KERNEL);
> +	if (!phydev->priv)
> +		return -ENOMEM;
> +
> +	ret = aeon_firmware_load(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_sync_parity(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable PTP clk if not already Enabled */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> +			       VEND1_PTP_CLK_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_dpc_ra_enable(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_get_fw_version(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int as21xxx_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* AS21xxx supports 100M/1G/2.5G/5G/10G speed. */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +			   phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phydev->supported);

Given all this, does genphy_read_abilities() actually read anything
useful from the PHY?

> +static struct phy_driver as21xxx_drivers[] = {
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
> +		.name		= "Aeonsemi AS21xxx",
> +		.probe		= as21xxx_probe,
> +		.get_features	= as21xxx_get_features,
> +		.read_status	= as21xxx_read_status,
> +		.led_brightness_set = as21xxx_led_brightness_set,
> +		.led_hw_is_supported = as21xxx_led_hw_is_supported,
> +		.led_hw_control_set = as21xxx_led_hw_control_set,
> +		.led_hw_control_get = as21xxx_led_hw_control_get,
> +		.led_polarity_set = as21xxx_led_polarity_set,
> +	},

What if firmware was already loaded? I think you implied that this
ID is only present when firmware hasn't been loaded.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

