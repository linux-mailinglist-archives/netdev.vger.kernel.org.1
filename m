Return-Path: <netdev+bounces-244263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59CCB3480
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0572307ECD2
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB13016F3;
	Wed, 10 Dec 2025 15:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AE2D0C84;
	Wed, 10 Dec 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380005; cv=none; b=sq3YbB7t5GdAYO3OMGeP+HPIcIDgdJNSEeRwCgjg3TbDUomi6wKiTN2zOi+VwfkV/ZLIA4AiWoZb9ralDrYXehOtMCGR/OAhEDSSrsrCtwG95C8SoZerURxkt9IRTJs+CKK+XQkpAFq4SVGx8eJF1bfkyUaYFIX9DRko+CQ+TP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380005; c=relaxed/simple;
	bh=sT4TETdEy1ZyWcz1EzvQR0+wrpP7pkz8Jn/nlWmhFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aML9nhIKG/C2l1ychyui6hID6piOTx2INVqStlRlvKWA8GGhz+//IC8Rtu1NveN/Oy7e7GoJ0LroxZkD9StiRfwA9Z36fzhxx0ngbyEWmudXsV2n3G71JDPfNdb+BrN1yaUvzJekCXiCdI7HkSuUUmmtS0lvV1h/N0avYH47AAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vTLyl-0000000059m-2uJN;
	Wed, 10 Dec 2025 15:19:47 +0000
Date: Wed, 10 Dec 2025 15:19:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aTmPjw83jFQXgWQt@makrotopia.org>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
 <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>

Hi Andrew,

thank you for the detailed review.
See my replies inline below

On Wed, Dec 03, 2025 at 03:07:20AM +0100, Andrew Lunn wrote:
> > [...]
> > +struct mxl862xx_ctp_port_assignment {
> > +	u8 logical_port_id;
> > +	__le16 first_ctp_port_id;
> > +	__le16 number_of_ctp_port;
> > +	enum mxl862xx_logical_port_mode mode;
> > +	__le16 bridge_port_id;
> > +} __packed;
> 
> Does the C standard define the size of an enum? Do you assume this is
> a byte?

Yes, it needs to be a byte, and I guess the best is to then just use
u8 type here and cast to u8 on assignment.

> > + * struct mxl862xx_sys_fw_image_version - VLAN counter mapping configuration
> 
> The text seems wrong, probably cut/paste error?

Yes, I agree ;)

> 
> > +#define MXL862XX_MMD_DEV 30
> 
> Please use MDIO_MMD_VEND1

Ack.

> 
> > +#define MXL862XX_MMD_REG_CTRL 0
> > +#define MXL862XX_MMD_REG_LEN_RET 1
> > +#define MXL862XX_MMD_REG_DATA_FIRST 2
> > +#define MXL862XX_MMD_REG_DATA_LAST 95
> > +#define MXL862XX_MMD_REG_DATA_MAX_SIZE \
> > +		(MXL862XX_MMD_REG_DATA_LAST - MXL862XX_MMD_REG_DATA_FIRST + 1)
> > +
> > +#define MMD_API_SET_DATA_0 (0x0 + 0x2)
> > +#define MMD_API_GET_DATA_0 (0x0 + 0x5)
> > +#define MMD_API_RST_DATA (0x0 + 0x8)
> 
> What is the significant of these numbers? Can you use #defines to make
> it clearer?

I'll simplify this to be

#define MMD_API_SET_DATA		2
#define MMD_API_GET_DATA		5
#define MMD_API_RST_DATA		8

which makes it more clear I hope.

> 
> > +
> > +static int mxl862xx_busy_wait(struct mxl862xx_priv *dev)
> > +{
> > +	int ret, i;
> > +
> > +	for (i = 0; i < MAX_BUSY_LOOP; i++) {
> > +		ret = __mdiobus_c45_read(dev->bus, dev->sw_addr,
> > +					 MXL862XX_MMD_DEV,
> > +					 MXL862XX_MMD_REG_CTRL);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (ret & CTRL_BUSY_MASK)
> > +			usleep_range(10, 15);
> > +		else
> > +			return 0;
> > +	}
> > +
> > +	return -ETIMEDOUT;
> 
> We already have phy_read_mmd_poll_timeout(). Maybe you should add a
> __mdiobus_c45_read_poll_timeout()?
> 
> Also, as far as i can see, __mdiobus_c45_read() is always called with
> the same first three parameters. Maybe add a mxl862xx_reg_read()?  and
> a mxl862xx_reg_write()?

Imho it would be nice to introduce unlock __mdiodev_c45_* helpers in
include/linux/mdio.h, ie.

static inline int __mdiodev_c45_read(struct mdio_device *mdiodev, int devad,
				     u16 regnum)
{
	return __mdiobus_c45_read(mdiodev->bus, mdiodev->addr, devad, regnum);
}

static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
				      u16 regnum, u16 val)
{
	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
				   val);
}

and then have something like this in mxl862xx-host.c:

static int mxl862xx_reg_read(struct mxl862xx_priv *priv, u32 addr)
{
	return __mdiodev_c45_read(priv->mdiodev, MDIO_MMD_VEND1, addr);
}

static int mxl862xx_reg_write(struct mxl862xx_priv *priv, u32 addr, u16 data)
{
	return __mdiodev_c45_write(priv->mdiodev, MDIO_MMD_VEND1, addr, data);
}

static int mxl862xx_ctrl_read(struct mxl862xx_priv *priv)
{
	return mxl862xx_reg_read(priv, MXL862XX_MMD_REG_CTRL);
}

static int mxl862xx_busy_wait(struct mxl862xx_priv *priv)
{
	int val;

	return readx_poll_timeout(mxl862xx_ctrl_read, priv, val,
				  !(val & CTRL_BUSY_MASK), 15, 10000);
}

Do you agree?

> > [...]
> > +	if (result < 0) {
> > +		ret = result;
> > +		goto out;
> > +	}
> 
> If i'm reading mxl862xx_send_cmd() correct, result is the value of a
> register. It seems unlikely this is a Linux error code?

Only someone with insights into the use of error codes by the uC
firmware can really answer that. However, as also Russell pointed out,
the whole use of s16 here with negative values being interpreted as
errors is fishy here, because in the end this is also used to read
registers from external MDIO connected PHYs which may return arbitrary
16-bit values...
Someone in MaxLinear will need to clarify here.

> 
> > +
> > +	for (i = 0; i < max && read; i++) {
> 
> That is an unusual way to use read.

Ack. I suggest

if (!read)
	goto out;

> > +#define MXL862XX_API_WRITE(dev, cmd, data) \
> > +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false)
> > +#define MXL862XX_API_READ(dev, cmd, data) \
> > +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true)
> 
> > +/* PHY access via firmware relay */
> > +static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
> > +				 int devadd, int reg)
> > +{
> > +	struct mdio_relay_data param = {
> > +		.phy = port,
> > +		.mmd = devadd,
> > +		.reg = reg & 0xffff,
> > +	};
> > +	int ret;
> > +
> > +	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);
> 
> That looks a bit ugly, using a macro as a function name. I would
> suggest tiny functions rather than macros. The compiler should do the
> right thing.

The thing is that the macro way allows to use MXL862XX_API_* on
arbitrary types, such as the packed structs. Using a function would
require the type of the parameter to be defined, which would result
in a lot of code duplication in this case.

> 
> > +/* Configure CPU tagging */
> > +static int mxl862xx_configure_tag_proto(struct dsa_switch *ds, int port,
> > +					bool enable)
> > +{
> > +	struct mxl862xx_ss_sp_tag tag = {
> > +		.pid = DSA_MXL_PORT(port),
> > +		.mask = BIT(0) | BIT(1),
> > +		.rx = enable ? 2 : 1,
> > +		.tx = enable ? 2 : 3,
> > +	};
> 
> There is a bit comment at the beginning of the patch about these, but
> it does not help much here. Please could you add some #defines for
> these magic numbers.

Ack, I'll do that.

> 
> > +/* Reset switch via MMD write */
> > +static int mxl862xx_mmd_write(struct dsa_switch *ds, int reg, u16 data)
> 
> The comment does not fit what the function does.

Ooops...

> 
> > +{
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	int ret;
> > +
> > +	mutex_lock(&priv->bus->mdio_lock);
> > +	ret = __mdiobus_c45_write(priv->bus, priv->sw_addr, MXL862XX_MMD_DEV,
> > +				  reg, data);
> > +	mutex_unlock(&priv->bus->mdio_lock);
> 
> There is no point using the unlocked version if you wrap it in
> lock/unlock...

I'll throw all this out and instead introduce a high-level reset
function in mxl8622xx-host.c, in that way all MDIO host access is kept
in mxl8622xx-host.c.

> > [...]
> > +	/* Software reset */
> > +	ret = mxl862xx_mmd_write(ds, 1, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_mmd_write(ds, 0, 0x9907);
> 
> More magic numbers.

Maybe someone in MaxLinear can demystify this?

