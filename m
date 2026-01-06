Return-Path: <netdev+bounces-247300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA50CF69BC
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 04:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0B9A3008190
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 03:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48991F09A8;
	Tue,  6 Jan 2026 03:34:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623E1E511;
	Tue,  6 Jan 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670451; cv=none; b=dA8IonCd3NWkIfaZGVjFsEduCxT0NypixSvH0WL5ynXLgCLaOfrZ5t3GbG0plBbZWlAVwIVglNFyV+lhKwgt1W3XyrvzptBUQhUq5DTQaJKBwlJ5viSIy++uRHg1XlsfZ3MYSaMBFjzeX1HgJ1gZ9hU3iaNUnK0SeoD/SMHKB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670451; c=relaxed/simple;
	bh=wzujuR8RhvcXzrzodfWym4BduKyrEoyl9V7NYzaE4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8kxjTVL5Q6oiIwHuhvYbBzvSy9Hs3GjC7H+b/MwPp4fU2KJ9xRbht1ogIP5TK7EK6gfHHnzl/lWYfmyTK0K5OApINTXkmP6fFnMA+Mc0xfZR4DXzXN9zbLARrvF+oWLSDLOoxKIQhEmur6q06PIfO3c+L6Vt5DQCXiziZhbRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcxpc-0000000042j-1hfN;
	Tue, 06 Jan 2026 03:34:04 +0000
Date: Tue, 6 Jan 2026 03:33:59 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 4/4] net: dsa: add basic initial driver
 for MxL862xx switches
Message-ID: <aVyCp9kvl7QXIOZX@makrotopia.org>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <cover.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
 <20251216224317.maxhcdsuqqxnywmu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216224317.maxhcdsuqqxnywmu@skbuf>

On Wed, Dec 17, 2025 at 12:43:17AM +0200, Vladimir Oltean wrote:
> On Mon, Dec 15, 2025 at 12:12:20AM +0000, Daniel Golle wrote:
> > +/**
> > + * enum mxl862xx_logical_port_mode - Logical port mode
> > + * @MXL862XX_LOGICAL_PORT_8BIT_WLAN: WLAN with 8-bit station ID
> > + * @MXL862XX_LOGICAL_PORT_9BIT_WLAN: WLAN with 9-bit station ID
> > + * @MXL862XX_LOGICAL_PORT_GPON: GPON OMCI context
> > + * @MXL862XX_LOGICAL_PORT_EPON: EPON context
> > + * @MXL862XX_LOGICAL_PORT_GINT: G.INT context
> > + * @MXL862XX_LOGICAL_PORT_OTHER: Others
> > + */
> > +enum mxl862xx_logical_port_mode {
> > +	MXL862XX_LOGICAL_PORT_8BIT_WLAN = 0,
> > +	MXL862XX_LOGICAL_PORT_9BIT_WLAN,
> > +	MXL862XX_LOGICAL_PORT_GPON,
> > +	MXL862XX_LOGICAL_PORT_EPON,
> > +	MXL862XX_LOGICAL_PORT_GINT,
> > +	MXL862XX_LOGICAL_PORT_OTHER = 0xFF,
> > +};
> > +
> > +/**
> > + * struct mxl862xx_ctp_port_assignment - CTP Port Assignment/association with logical port
> 
> What is a CTP port?

I asked MaxLinear engineers about all of this and turns out these terms
come from their xPON CPE SoC platform.

Connectivity Termination Port (CTP) can be used to map to PON GEM ports.

On the standalone switch it should just be set to Logical Port +
Sub-Interface-ID (saturated to 31).

The Sub-Interface-ID describes the offset between a user port and the
used CPU port.

> Logical port?

Logical port on top of physical port (MAC) and CPU (MXL chip CPU)

> Why is the "GPON" logical port mode for the DSA CPU port preferable to
> its alternatives?

The standalone switch IC only uses MXL862XX_LOGICAL_PORT_GPON, and that
actually describes an Ethernet port. I'll just rename it and drop the
irrelevant EPON and GINT values.


> 
> > + * @logical_port_id: Logical Port Id. The valid range is hardware dependent
> > + * @first_ctp_port_id: First CTP Port ID mapped to above logical port ID
> > + * @number_of_ctp_port: Total number of CTP Ports mapped above logical port ID
> > + * @mode: See &enum mxl862xx_logical_port_mode
> > + * @bridge_port_id: Bridge ID (FID)
> > + */
> > +struct mxl862xx_ctp_port_assignment {
> > +	u8 logical_port_id;
> > +	__le16 first_ctp_port_id;
> > +	__le16 number_of_ctp_port;
> > +	__le32 mode; /* enum mxl862xx_logical_port_mode */
> > +	__le16 bridge_port_id;
> > +} __packed;
> 
> Can you confirm this alignment is correct? __le32 mode begins with byte
> offset 5 of the structure. I haven't decompiled the code, but I suppose
> the compiler will have to perform byte by byte accesses.

Yes, I've asked them and MaxLinear confirmed that all API is
byte-aligned.

> > +static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size)
> 
> Can you document what this function is supposed to return on success?
> Seems something non-zero, otherwise you wouldn't bother saving it in cmd_ret,
> I guess.

The return value is the return value of the function called on the
Zephyr-based firmware, so it really depends on the indivual function.
Typically 0 or a positive (signed 16-bit) number on success.

> > [...]
> > +int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
> > +		      u16 size, bool read)
> > +{
> > +	__le16 *data = _data;
> > +	u16 max, i;
> > +	int ret, cmd_ret;
> > +
> > +	dev_dbg(&priv->mdiodev->dev, "CMD %04x DATA %*ph\n", cmd, size, data);
> > +
> > +	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
> > +
> > +	max = (size + 1) / 2;
> > +
> > +	ret = mxl862xx_busy_wait(priv);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	for (i = 0; i < max; i++) {
> > +		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
> > +
> > +		if (i && off == 0) {
> > +			/* Send command to set data when every
> > +			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are written.
> > +			 */
> > +			ret = mxl862xx_set_data(priv, i);
> > +			if (ret < 0)
> > +				goto out;
> > +		}
> > +
> > +		ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_DATA_FIRST + off,
> > +					 le16_to_cpu(data[i]));
> > +		if (ret < 0)
> > +			goto out;
> 
> I have only superficially looked at this, but doesn't writing need
> special handling if the buffer size is odd, like reading does?

Sounds plausible, but their reference driver doesn't do that.
I'll ask.

> > [...]
> > +int mxl862xx_reset(struct mxl862xx_priv *priv)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
> > +
> > +	/* Software reset */
> > +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET, 0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL, MXL862XX_SWITCH_RESET);
> > +out:
> > +	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
> > +
> > +	if (!ret)
> > +		usleep_range(4000000, 6000000);
> 
> This unconditionally sleeps 4 to 6 seconds after a reset?
> Does the reset command reboot Zephyr?
> Are we unable to know when we have communication with the firmware again?
> Like read SYS_MISC_FW_VERSION until it's equal to what was originally
> read during probing? Does this save any time?

I've played around with this for a bit, and haven't found a good
way to tell whether the firmware has completed booting.
SYS_MISC_FW_VERSION returns the correct value again pretty quickly,
but then MDIO access to the PHYs doesn't yet work at that point,
for example...

> > +static int mxl862xx_configure_tag_proto(struct dsa_port *dp, bool enable)
> 
> Why pass "bool enable" if you always set it to true?


> 
> > +{
> > +	struct mxl862xx_ctp_port_assignment assign = {
> > +		.number_of_ctp_port = cpu_to_le16(enable ? (32 - DSA_MXL_PORT(dp->index)) : 1),
> > +		.logical_port_id = DSA_MXL_PORT(dp->index),
> > +		.first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(dp->index)),
> > +		.mode = cpu_to_le32(MXL862XX_LOGICAL_PORT_GPON),
> > +	};
> > +	struct mxl862xx_ss_sp_tag tag = {
> > +		.pid = DSA_MXL_PORT(dp->index),
> > +		.mask = MXL862XX_SS_SP_TAG_MASK_RX | MXL862XX_SS_SP_TAG_MASK_TX,
> > +		.rx = enable ? MXL862XX_SS_SP_TAG_RX_TAG_NO_INSERT :
> > +			       MXL862XX_SS_SP_TAG_RX_NO_TAG_INSERT,
> > +		.tx = enable ? MXL862XX_SS_SP_TAG_TX_TAG_NO_REMOVE :
> > +			       MXL862XX_SS_SP_TAG_TX_TAG_REMOVE,
> > +	};
> > +	int ret;
> > +
> > +	ret = MXL862XX_API_WRITE(dp->ds->priv, MXL862XX_SS_SPTAG_SET, tag);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return MXL862XX_API_WRITE(dp->ds->priv, MXL862XX_CTP_PORTASSIGNMENTSET, assign);
> > +}
> > +
> > +static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
> > +{
> > +	struct mxl862xx_register_mod sdma = {
> > +		.addr = cpu_to_le16(MXL862XX_SDMA_PCTRLP(DSA_MXL_PORT(port))),
> > +		.data = cpu_to_le16(enable ? MXL862XX_SDMA_PCTRL_EN : 0),
> > +		.mask = cpu_to_le16(MXL862XX_SDMA_PCTRL_EN),
> > +	};
> > +	struct mxl862xx_register_mod fdma = {
> > +		.addr = cpu_to_le16(MXL862XX_FDMA_PCTRLP(DSA_MXL_PORT(port))),
> > +		.data = cpu_to_le16(enable ? MXL862XX_FDMA_PCTRL_EN : 0),
> > +		.mask = cpu_to_le16(MXL862XX_FDMA_PCTRL_EN),
> > +	};
> > +	int ret;
> > +
> > +	if (!dsa_is_user_port(ds, port))
> > +		return 0;
> 
> I am a bit surprised that the CPU ports don't need the Fetch DMA and the
> Store DMA enabled? Perhaps I don't understand what these blocks do.

Apparently the vendor driver assumes that the CPU port should never
be touched. I've removed that check and unified the handling of
CPU and users ports, implemented common .port_setup op, and it all
works. You'll see in v4 ;)

> > +static enum dsa_tag_protocol mxl862xx_get_tag_protocol(struct dsa_switch *ds,
> > +						       int port,
> > +						       enum dsa_tag_protocol m)
> > +{
> > +	return DSA_TAG_PROTO_MXL862;
> > +}
> > +
> > +static int mxl862xx_setup(struct dsa_switch *ds)
> > +{
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	struct dsa_port *cpu_dp;
> > +	int ret;
> > +
> > +	ret = mxl862xx_reset(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_setup_mdio(ds);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
> > +		ret = mxl862xx_configure_tag_proto(cpu_dp, true);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> Do the ports know not to forward packets between each other by default,
> just to the CPU port? Which setting does that? Is address learning
> turned off on user ports, since they are operating as standalone?

The configuration of the switch at this points depends on the default
configuration which is attached to the firmware blob on the external
flash chip attached to the switch IC.

It's an ongoing debate with MaxLinear to find a meaningful way to deal
with (or rather: flush) that default configuration without needing to
use all the API.

In the next series after that one I plan to add all basic bridge and
bridge-port configuration API calls which can then also be used to
create "single port bridges" for standalone ports, configure learning,
...

Including all this in this current series would imho exceed the amount
of code anyone could review at once.

> > +static struct mdio_driver mxl862xx_driver = {
> > +	.probe  = mxl862xx_probe,
> > +	.remove = mxl862xx_remove,
> 
> This is missing the non-optional shutdown hook again.

Ack, will add that.

> 
> > +	.mdiodrv.driver = {
> > +		.name = "mxl862xx",
> > +		.of_match_table = mxl862xx_of_match,
> > +	},
> > +};
> > +
> > +mdio_module_driver(mxl862xx_driver);
> > +
> > +MODULE_DESCRIPTION("Minimal driver for MaxLinear MxL862xx switch family");
> 
> I suspect this description may not age well, and may remain "minimal"
> even when the driver gains more substantial features.

Yeah, I'll better change it now than later ;)

> 
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:mxl862xx");
> 
> What is the role of this MODULE_ALIAS?

None. It's a left-over from the vendor driver and not needed. This is not
a platform driver. I'll remove this.

