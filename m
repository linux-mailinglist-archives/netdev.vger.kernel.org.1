Return-Path: <netdev+bounces-243380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F08BCC9E7BA
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 10:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C05E348FBC
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5202DE1E6;
	Wed,  3 Dec 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JwIC1pYJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EC2DCF4D;
	Wed,  3 Dec 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754196; cv=none; b=alMB8YITK+rsYT8H3rB/4hzZvT8M8pptw+usOrnqfOtRcmuxiuv+uUAppqo6WPXjqJiis3lv4t7mU8iIg0UD15EHi0do+6gm7nRebFtgDsGo0zTVDXoIDYhFTIJmUJqDstbrKcI0dd4KgdI4hoIpwJiZzDXX9gnNmaE9NGj62hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754196; c=relaxed/simple;
	bh=ded+QBGC6xLs3khUezFdO4xx+eh/BxqZQHkKWcfOLs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueQgn+5pumLKr8UKW2BCwMxI8cugO/fQlw5XYdSlDq4UYEcz8bm++2FIl1Bfr14KZG7Xv1DCNJrSrqKDXVu4ZGjY9dCu3Yhv2c0KBNpzbx0tM+eaGKHWFGBqYmYDOLjaADPVtlc48bOqW4xeb0XfrOrltpJnbvDatGCVuWJTJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JwIC1pYJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=++x36++AQYMYArARypVUnlYPyOBV4DEhIySU5+Og1zY=; b=JwIC1pYJ+kdsaD+CGxDPI7j5sw
	BXlULWrb7ZSbl4nvGLcVtbK0LSCmgVkgj0xxnriKIzMh0OEOdFju1lo1yi64Dx5ABROZsBHvbTa0r
	aw63/h/wYHm0d6s7244BN3sYs2OJ9oYU6ZQprlVOM7CSEnMokY7hjcYe2hgzNKs0OmXaRxQpjC5Kf
	TqeMYHYkY4tjCXEiEerc9o53UadzUXapiRlRnzVoLPdsFuTdf0jMNLetqVfwefSwwk+vEwznb8ajq
	Lpxg0DHgBz5Z9hDdPwENwpP0NpFM4tBBTalU0SC9t8dx1wSNyzBt3KuVLnnBim1/5LAKVBhq658+M
	elAMzHbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQjB6-000000002PY-1BLE;
	Wed, 03 Dec 2025 09:29:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQjB2-000000008LC-04oA;
	Wed, 03 Dec 2025 09:29:36 +0000
Date: Wed, 3 Dec 2025 09:29:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aTAC_xLUztl9ZHqT@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 03, 2025 at 03:07:20AM +0100, Andrew Lunn wrote:
> > +/**
> > + * struct mxl862xx_ss_sp_tag
> > + * @pid: port ID (1~16)
> > + * @mask: bit value 1 to indicate valid field
> > + *	0 - rx
> > + *	1 - tx
> > + *	2 - rx_pen
> > + *	3 - tx_pen
> > + * @rx: RX special tag mode
> > + *	0 - packet does NOT have special tag and special tag is NOT inserted
> > + *	1 - packet does NOT have special tag and special tag is inserted
> > + *	2 - packet has special tag and special tag is NOT inserted
> > + * @tx: TX special tag mode
> > + *	0 - packet does NOT have special tag and special tag is NOT removed
> > + *	1 - packet has special tag and special tag is replaced
> > + *	2 - packet has special tag and special tag is NOT removed
> > + *	3 - packet has special tag and special tag is removed
> > + * @rx_pen: RX special tag info over preamble
> > + *	0 - special tag info inserted from byte 2 to 7 are all 0
> > + *	1 - special tag byte 5 is 16, other bytes from 2 to 7 are 0
> > + *	2 - special tag byte 5 is from preamble field, others are 0
> > + *	3 - special tag byte 2 to 7 are from preabmle field
> > + * @tx_pen: TX special tag info over preamble
> > + *	0 - disabled
> > + *	1 - enabled
> > + */
> > +struct mxl862xx_ss_sp_tag {
> > +	u8 pid;
> > +	u8 mask;
> > +	u8 rx;
> > +	u8 tx;
> > +	u8 rx_pen;
> > +	u8 tx_pen;
> > +} __packed;
> > +
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
> > +	enum mxl862xx_logical_port_mode mode;
> > +	__le16 bridge_port_id;
> > +} __packed;
> 
> Does the C standard define the size of an enum? Do you assume this is
> a byte?

It does not. Some architectures are allowed to choose the storage size
of enum depending on the range of values.

> > +static int mxl862xx_send_cmd(struct mxl862xx_priv *dev, u16 cmd, u16 size,
> > +			     s16 *presult)
> > +{
> > +	int ret;
> > +
> > +	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
> > +				  MXL862XX_MMD_REG_LEN_RET, size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __mdiobus_c45_write(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
> > +				  MXL862XX_MMD_REG_CTRL, cmd | CTRL_BUSY_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_busy_wait(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __mdiobus_c45_read(dev->bus, dev->sw_addr, MXL862XX_MMD_DEV,
> > +				 MXL862XX_MMD_REG_LEN_RET);
> > +	if (ret < 0)
> > +		return ret;

Error codes go via this path.

> > +
> > +	*presult = ret;

Register values via this, and if the sign bit is set, *presult is
negative.

> > +	ret = mxl862xx_send_cmd(priv, cmd, size, &result);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (result < 0) {
> > +		ret = result;
> > +		goto out;
> > +	}
> 
> If i'm reading mxl862xx_send_cmd() correct, result is the value of a
> register. It seems unlikely this is a Linux error code?

result here is the register value, and a negative value is the value
from the register. So I agree - this assigns a register value to
"ret" which gets promoted from s16 to int (sign extension) and thus
gets returned as a Linux error code. So yes, this doesn't seem right.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

