Return-Path: <netdev+bounces-196395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73AAD4779
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 02:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2C6188B22C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002079DA;
	Wed, 11 Jun 2025 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OERa/DC2"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F15EC4;
	Wed, 11 Jun 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601461; cv=none; b=cnkWNli/gN9ShUHExAj+9dXtPC/M/d4kVc9Yxqlh1MC1RSXLfhvUt1mvD5Idq3o4sayP906gZRx2JDm4JNmrYkmwhScQCxQlaASV5tYdWDk3yXzUHfCvkvCKOI0gxHJMPLJCbj5kVxpuzh9Fe0lGURoPJAOhv9IwumFSy5aHA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601461; c=relaxed/simple;
	bh=IVm0goz3CniBVUljGLrw4V1pfZi1rYq3L/LJlF3nFms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gmc1Chc1jq6v7KppqrdAXow/Xt9RbIKnxGr3QBTKDVnKMcZBQJ97c3HlER5ql/Ef+BWUzYgUaC2Y/tl0vtkKkPkKm9H9TEOadc/JMIP4sdFykjsiqK8mYr41+wREx6ThT2tFYYQPWmRTdJASWre6FZfCaCyhNe+UoKfXXONFPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OERa/DC2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=W5WmDo95Xn51VsMSBY51s9wgDJb9kKGLVAW/HIReidM=; b=OERa/DC2pVQ24dez9qLd4fEZXV
	xbHcmzcTQIiAtuZgqOEVeEpVeYpbV0Ip9cqWX4Ltb9wXKFHxi0zdmbpa8fp8kRhVOrA0wqXPPhXuF
	HvWoc2ZjeLyLgMR68HBCDjR+grb26BcZwMxn+ZjzjajnkXJPqf7A4MkTN1VFo+J5nKK3k3yBTVKga
	3o9vK1gGOnmFxWkKRbpLsD3yKT7BuDuym7foawp7ahAP1CIyvu9I1VCmYzbUyKPIzhkovhRNsSfTE
	gedhvIqaA1lRhfcwmhuq0BvQyM72DwQ626JIsaK5KtK6M9quPiwx+EgNAnt4pHLODLNqTSYEzSVbN
	l9z8xQrQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP9GH-000000022uX-1BI3;
	Wed, 11 Jun 2025 00:24:13 +0000
Message-ID: <f5b16bd6-01b6-45c0-9668-41ccf90445a3@infradead.org>
Date: Tue, 10 Jun 2025 17:24:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 03/10] net: pcs: Add subsystem
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Horman <horms@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
 <20250610233134.3588011-4-sean.anderson@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250610233134.3588011-4-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


> diff --git a/Documentation/networking/pcs.rst b/Documentation/networking/pcs.rst
> new file mode 100644
> index 000000000000..4b41ba884160
> --- /dev/null
> +++ b/Documentation/networking/pcs.rst
> @@ -0,0 +1,102 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +PCS Subsystem
> +=============
> +
> +The PCS (Physical Coding Sublayer) subsystem handles the registration and lookup
> +of PCS devices. These devices contain the upper sublayers of the Ethernet
> +physical layer, generally handling framing, scrambling, and encoding tasks. PCS
> +devices may also include PMA (Physical Medium Attachment) components. PCS
> +devices transfer data between the Link-layer MAC device, and the rest of the
> +physical layer, typically via a serdes. The output of the serdes may be
> +connected more-or-less directly to the medium when using fiber-optic or
> +backplane connections (1000BASE-SX, 1000BASE-KX, etc). It may also communicate
> +with a separate PHY (such as over SGMII) which handles the connection to the
> +medium (such as 1000BASE-T).
> +
> +Looking up PCS Devices
> +----------------------
> +
> +There are generally two ways to look up a PCS device. If the PCS device is
> +internal to a larger device (such as a MAC or switch), and it does not share an
> +implementation with an existing PCS, then it does not need to be registered with
> +the PCS subsystem. Instead, you can populate a :c:type:`phylink_pcs`
> +in your probe function. Otherwise, you must look up the PCS.
> +
> +If your device has a :c:type:`fwnode_handle`, you can add a PCS using the
> +``pcs-handle`` property::
> +
> +    ethernet-controller {
> +        // ...
> +        pcs-handle = <&pcs>;
> +        pcs-handle-names = "internal";
> +    };
> +
> +Then, during your probe function, you can get the PCS using :c:func:`pcs_get`::

It's preferable to use                               PCS using pcs_get()::
instead of the :c:func: notation to make the .rst file more human-readable.
They produce the same generated output.

> +
> +    mac->pcs = pcs_get(dev, "internal");
> +    if (IS_ERR(mac->pcs)) {
> +        err = PTR_ERR(mac->pcs);
> +        return dev_err_probe(dev, "Could not get PCS\n");
> +    }
> +
> +If your device doesn't have a :c:type:`fwnode_handle`, you can get the PCS
> +based on the providing device using :c:func:`pcs_get_by_dev`. Typically, you

ditto.

> +will create the device and bind your PCS driver to it before calling this
> +function. This allows reuse of an existing PCS driver.
> +
> +Once you are done using the PCS, you must call :c:func:`pcs_put`.

ditto.

> +
> +Using PCS Devices
> +-----------------
> +
> +To select the PCS from a MAC driver, implement the ``mac_select_pcs`` callback
> +of :c:type:`phylink_mac_ops`. In this example, the PCS is selected for SGMII
> +and 1000BASE-X, and deselected for other interfaces::
> +
> +    static struct phylink_pcs *mac_select_pcs(struct phylink_config *config,
> +                                              phy_interface_t iface)
> +    {
> +        struct mac *mac = config_to_mac(config);
> +
> +        switch (iface) {
> +        case PHY_INTERFACE_MODE_SGMII:
> +        case PHY_INTERFACE_MODE_1000BASEX:
> +            return mac->pcs;
> +        default:
> +            return NULL;
> +        }
> +    }
> +
> +To do the same from a DSA driver, implement the ``phylink_mac_select_pcs``
> +callback of :c:type:`dsa_switch_ops`.
> +
> +Writing PCS Drivers
> +-------------------
> +
> +To write a PCS driver, first implement :c:type:`phylink_pcs_ops`. Then,
> +register your PCS in your probe function using :c:func:`pcs_register`. If you

ditto

> +need to provide multiple PCSs for the same device, then you can pass specific
> +firmware nodes using :c:macro:`pcs_register_full`.
> +
> +You must call :c:func:`pcs_unregister` from your remove function. You can avoid

ditto.

> +this step by registering with :c:func:`devm_pcs_unregister`.
> +
> +API Reference
> +-------------
> +
> +.. kernel-doc:: include/linux/phylink.h
> +   :identifiers: phylink_pcs phylink_pcs_ops pcs_validate pcs_inband_caps
> +      pcs_enable pcs_disable pcs_pre_config pcs_post_config pcs_get_state
> +      pcs_config pcs_an_restart pcs_link_up pcs_disable_eee pcs_enable_eee
> +      pcs_pre_init
> +
> +.. kernel-doc:: include/linux/pcs.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/net/pcs/core.c
> +   :export:
> +
> +.. kernel-doc:: drivers/net/pcs/core.c
> +   :internal:

Thanks.

-- 
~Randy


