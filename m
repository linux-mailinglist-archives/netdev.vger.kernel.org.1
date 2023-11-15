Return-Path: <netdev+bounces-48064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40037EC6B0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214CB1C20978
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9735F16;
	Wed, 15 Nov 2023 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jcZbQDDD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965923418C;
	Wed, 15 Nov 2023 15:07:25 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65605125;
	Wed, 15 Nov 2023 07:07:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12BBC24000C;
	Wed, 15 Nov 2023 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700060840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dy5Pt08X+zZERsZIfegEmYR9OttXODBuhXhRa0MCI8=;
	b=jcZbQDDDhYGFHk72VXnxdjYiNDUyrCQ/WJb2qldiqupZ+jnENFi6d7pXZXPO7zaOXqZN3n
	Z4UOhaIhkVC0nXMh7vH5oTL0/A06nc1Txuz7OmqMXjFECAuutFDIXTdSMJnAfYB8UnmMZe
	ttvMHMAJWf0cvaeB8X0L6KngKx0ZRIaZk9xXtWdkDQfUBJhitM4g2/Jbs8COQHx07UPjoo
	xfezyffYVPzr6Mtk1f7i/r+PEdAxk8EAWmkanywsqEyVwyx3fvhrbNXW76JSBg6B4Z+dM6
	nC9XZV4NrBVjciM+ew12qhG8KmvR/dsxMEt7PvLivSOyDLVDu/zKCnN3L15jSA==
Date: Wed, 15 Nov 2023 16:07:32 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
cc: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
    Vladimir Oltean <vladimir.oltean@nxp.com>, 
    Luka Perkov <luka.perkov@sartura.hr>, 
    Robert Marko <robert.marko@sartura.hr>, Andy Gross <agross@kernel.org>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
In-Reply-To: <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
Message-ID: <d52d766f-11a5-494a-63cc-cbffd2945069@bootlin.com>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com> <20231114105600.1012056-4-romain.gantois@bootlin.com> <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

On Wed, 15 Nov 2023, Wojciech Drewek wrote:
...
> > +static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
> > +				       u16 vid)
> > +{
> > +	struct ipqess_port *port = netdev_priv(dev);
> > +	struct switchdev_obj_port_vlan vlan = {
> > +		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
> > +		.vid = vid,
> > +		/* This API only allows programming tagged, non-PVID VIDs */
> > +		.flags = 0,
> > +	};
> > +	struct netlink_ext_ack extack = {0};
> > +	int ret;
> > +
> > +	/* User port... */
> > +	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
> > +	if (ret) {
> > +		if (extack._msg)
> > +			netdev_err(dev, "%s\n", extack._msg);
> > +		return ret;
> > +	}
> > +
> > +	/* And CPU port... */
> > +	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
> > +	if (ret) {
> 
> Should we delete vlan from user port if this fails?
I'll have to look into how and when this API is called in more detail but I 
think this would indeed make sense.

> > +
> > +	/* Flush the FDB table */
> > +	qca8k_fdb_flush(priv);
> > +
> > +	if (ret < 0)
> > +		goto devlink_free;
> > +
> > +	/* set Port0 status */
> > +	reg  = QCA8K_PORT_STATUS_LINK_AUTO;
> > +	reg |= QCA8K_PORT_STATUS_DUPLEX;
> > +	reg |= QCA8K_PORT_STATUS_SPEED_1000;
> > +	reg |= QCA8K_PORT_STATUS_RXFLOW;
> > +	reg |= QCA8K_PORT_STATUS_TXFLOW;
> > +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> > +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(0), reg);
> > +	sw->port0_enabled = true;
> > +
> > +	return 0;
> > +
> > +devlink_free:
> 
> Why is it called devlink_free, I don't see any connection to devlink.
I think this is leftover from a previous version of this function, where it 
interacted with devlink. I'll rename it to error.

Best,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

