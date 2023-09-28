Return-Path: <netdev+bounces-36730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB57B1819
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E259D281B39
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF826347CA;
	Thu, 28 Sep 2023 10:12:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C31D68A
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:12:22 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E5F122;
	Thu, 28 Sep 2023 03:12:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9B264000D;
	Thu, 28 Sep 2023 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695895938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0w3QyFnZ5GzEcVuSjQvNj3lczN8eP+MoNd8bPG9ffps=;
	b=aKCaiyST9Arbjirrx+gb/s4ajF8AuFFBbXJz0N/UkJlGJ146yLZzDShnLNOJ4iH24MTK7A
	hr9+VKbXjAgbKjsRXzOl63ixQQpkKYaUpoUsG3VmVgr/oGXZLxSIFRbhGacKNWq2DzUF4S
	FCnn7ZhSA4g96L/RQTL06Jmkw1u3tyvULYrTKKu89ke3bQVHuSbeYZNm7/GtIPZlhLOKV2
	BqoBQzUIcKREPsWj5zgmvmrx0gfci7NRHEkDUXJ+X47qJfRDYpBdd7zZOsd6hDeTJxjtLB
	vwg0cpD6v/cYn4DWWbfnQOtpjIheVXN9x/h7lOiJisn7FZTNfQDDX0BmbiqZ4Q==
Date: Thu, 28 Sep 2023 12:12:14 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Maxim Georgiev <glipus@gmail.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Richard Cochran
 <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Gerhard Engleder <gerhard@engleder-embedded.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Russell King <linux@armlinux.org.uk>, Heiner
 Kallweit <hkallweit1@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 UNGLinuxDriver@microchip.com, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Simon Horman <simon.horman@corigine.com>,
 Casper Andersson <casper.casan@gmail.com>, Sergey Organov
 <sorganov@gmail.com>, Michal Kubecek <mkubecek@suse.cz>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 net-next 12/12] net: remove phy_has_hwtstamp() ->
 phy_mii_ioctl() decision from converted drivers
Message-ID: <20230928121214.170e31b0@kmaincent-XPS-13-7390>
In-Reply-To: <20230801142824.1772134-13-vladimir.oltean@nxp.com>
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
	<20230801142824.1772134-13-vladimir.oltean@nxp.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue,  1 Aug 2023 17:28:24 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> It is desirable that the new .ndo_hwtstamp_set() API gives more
> uniformity, less overhead and future flexibility w.r.t. the PHY
> timestamping behavior.
> 
> Currently there are some drivers which allow PHY timestamping through
> the procedure mentioned in Documentation/networking/timestamping.rst.
> They don't do anything locally if phy_has_hwtstamp() is set, except for
> lan966x which installs PTP packet traps.
> 
> Centralize that behavior in a new dev_set_hwtstamp_phylib() code
> function, which calls either phy_mii_ioctl() for the phylib PHY,
> or .ndo_hwtstamp_set() of the netdev, based on a single policy
> (currently simplistic: phy_has_hwtstamp()).
> 
> Any driver converted to .ndo_hwtstamp_set() will automatically opt into
> the centralized phylib timestamping policy. Unconverted drivers still
> get to choose whether they let the PHY handle timestamping or not.
> 
> Netdev drivers with integrated PHY drivers that don't use phylib
> presumably don't set dev->phydev, and those will always see
> HWTSTAMP_SOURCE_NETDEV requests even when converted. The timestamping
> policy will remain 100% up to them.

> +static int dev_set_hwtstamp_phylib(struct net_device *dev,
> +				   struct kernel_hwtstamp_config *cfg,
> +				   struct netlink_ext_ack *extack)
> +{
...

> +	if (phy_ts) {
> +		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
> +		if (err) {
> +			if (changed)
> +				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
> +			return err;
> +		}
> +	}

In this case the copy_from_user function will be call 2 times, one in
dev_set_hwtstamp and one in the mii_ts.hwtstamp callback of the PHY driver.
Should we create also a copied_from_user flag? Other idea?

Regards,

