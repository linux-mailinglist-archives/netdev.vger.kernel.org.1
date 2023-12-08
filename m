Return-Path: <netdev+bounces-55356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4980A9C5
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827FB1C2095D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D637154;
	Fri,  8 Dec 2023 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daMT4hAT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F91706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 08:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702054234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9G4gtAHl2jdBgyqLp8sobufNphdW1bLmTw+/OLi/vA=;
	b=daMT4hATPXYhk4artMrKm8Ufy6xW/Xwuf7KVsuk9kpTTrxz+jEgPb1/LB9XIwfex1/C35A
	Oy7raYIIamfSo1uCXIswLFCMFUETOBJl3No0JMeeP98mfIDeLsaLlLzd5eRVfO/aCm4hiW
	rpxvQ1A/U42ezUE98L3+B+fuTqCXF88=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-DYpy6WU2Pz6hrSatCyC7tQ-1; Fri, 08 Dec 2023 11:50:33 -0500
X-MC-Unique: DYpy6WU2Pz6hrSatCyC7tQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-423f436ed56so27633811cf.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 08:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054233; x=1702659033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9G4gtAHl2jdBgyqLp8sobufNphdW1bLmTw+/OLi/vA=;
        b=EAGAdgmuqL2mtmLu40Ept8YwoTnefkFVEujm1+aiH0MqTM96l9dzE0W8IRF/9YGboj
         XD+SAWEj1F834Kbo1PHzBd1W9b/AsyfxzrKhnwGfuTpdI+3JNAO6OrMiHnWPYvxWs3n9
         sXPIh6loKJl4poSkR3efILuA0bwDsfucYLBwK7toJlXw6hGE03jlTFTEcD4RW8GW/av2
         cg4o07sSTBta4pUE5oYUegHQDIoksVARMnVJLMj/6Lrg7nfMZNlbZsBvrTWe+RscT5WM
         O51+jqrqVq61yTsSAdaWHQbmACGlraNhImBAfAYBVS4a0yK9z2RqXolnCqzpUKu/QjU7
         Co+g==
X-Gm-Message-State: AOJu0YytkCToeYDcizswBxb34IuREv1BFlM2fXZIdwEU2NjG3k6mnOFS
	aPiygfVlSdyXFguPxRYCC3hc9M0dAKqPcr5j+4J58JW6xqT+qi9WSsQMVx7fO0oLnxjUti0v6GD
	fneTLuJ8uyOxfJ3/P
X-Received: by 2002:a05:622a:1309:b0:425:9426:91aa with SMTP id v9-20020a05622a130900b00425942691aamr454868qtk.34.1702054232704;
        Fri, 08 Dec 2023 08:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3MkP5lk5Sl/2AGIEvzOZH8sOYwYpbdXiAWnTwjUg36SFaoDyLKp2Da3nJ+OEmEbw6FcPKYg==
X-Received: by 2002:a05:622a:1309:b0:425:9426:91aa with SMTP id v9-20020a05622a130900b00425942691aamr454855qtk.34.1702054232378;
        Fri, 08 Dec 2023 08:50:32 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id g23-20020ac842d7000000b00410a9dd3d88sm923673qtm.68.2023.12.08.08.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:50:31 -0800 (PST)
Date: Fri, 8 Dec 2023 10:50:29 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <h5ucipgjtsesrz3jyul5xohu4pqom56v6ayx7aonnfesret3ht@wmblmndj6zir>
References: <20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com>
 <jz6ot44fjkbmwcezi3fkgqd54nurglblbemrchfgxgq6udlhqz@ntepnnzzelta>
 <hxds75erxqcfkufxnfbyo2up4b4jeicmi3f5xr6qlb3yf7fe76@4byeq62jhu4o>
 <hgz3pt625kggix6kzincohw7kr2okcumrwfkmjgiauw2yvhrzt@ekeygo4b7k3b>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hgz3pt625kggix6kzincohw7kr2okcumrwfkmjgiauw2yvhrzt@ekeygo4b7k3b>

On Fri, Dec 08, 2023 at 06:07:06PM +0300, Serge Semin wrote:
> On Thu, Dec 07, 2023 at 05:07:24PM -0600, Andrew Halaney wrote:
> > On Fri, Dec 08, 2023 at 01:16:12AM +0300, Serge Semin wrote:
> > > On Thu, Dec 07, 2023 at 03:12:40PM -0600, Andrew Halaney wrote:
> > > > The stmmac_dt_phy() function, which parses the devicetree node of the
> > > > MAC and ultimately causes MDIO bus allocation, misinterprets what
> > > > fixed-link means in relation to the MAC's MDIO bus. This results in
> > > > a MDIO bus being created in situations it need not be.
> > > > 
> > > > Currently a MDIO bus is created if the description is either:
> > > > 
> > > >     1. Not fixed-link
> > > >     2. fixed-link but contains a MDIO bus as well
> > > > 
> > > > The "1" case above isn't always accurate. If there's a phy-handle,
> > > > it could be referencing a phy on another MDIO controller's bus[1]. In
> > > > this case currently the MAC will make a MDIO bus and scan it all
> > > > anyways unnecessarily.
> > > > 
> > > > There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> > > > be created and scanned for a phy. This case can also be inferred from
> > > > the platform description by not having a phy-handle && not being
> > > > fixed-link. This hits case "1" in the current driver's logic.
> > > > 
> > > > Let's improve the logic to create a MDIO bus if either:
> > > > 
> > > 
> > > >     - Devicetree contains a MDIO bus
> > > >     - !fixed-link && !phy-handle (legacy handling)
> > > 
> > > If what you suggest here is a free from regressions semantics change
> > > (really hope it is) I will be with both my hands for it. This will
> > > solve the problem we have with one of our device which doesn't have
> > > SMA interface (hardware designers decided to save ~4K gates of the
> > > chip area) but has a PHY externally attached to the DW XGMAC<->XPCS
> > > interface. PHY is accessible via a GPIO-based MDIO bus. BTW having no
> > > SMA interface available on a DW *MAC device but creating the MDIO-bus
> > > on top of the non-existent SMA CSRs anyway causes having _32_ dummy
> > > PHYs created with zero IDs.
> > 
> 
> > I hope it is regression free! I have tested both the [1] and [2] cases
> > (I hacked up the devicetree for [1] to make it look like [2]) without
> > any issue.
> > 
> 
> I doubt you could have tested it on all the possible hardware the
> STMMAC driver supports. The problem is that the DT-bindings thing is a
> kind of contract which can't be changed that easily. It's like ABI but
> for the hardware description so the kernel would bootup correctly on
> the platforms with the old DT blobs. But if the change isn't that
> critical, if the device-tree sources in the kernel fit to the updated
> semantics, if the networking subsystem maintainers aren't against it
> and I guess with the Rob, Krzysztof or Conor blessing (at least it
> won't hurt to add them to the Cc-list together with the devicetree
> mailing-list), then it will likely be accepted.

To be clear, I don't think we're violating the dt-binding ABI contract
here. My intention is that all the existing use cases continue to work,
and this just improves one use case. I did a write up
over on v2 about the use cases I see and the current logic vs what
changes with this patch series:

    https://lore.kernel.org/netdev/plvbqgi2bwlv5quvpiwplq7cxx6m5rl3ghnfhuxfx4bpuhyihl@zmydwrtwdeg6/

Please comment if you think I have broken some backwards
compatibility. If I _could_ break compatibility, I'd make everyone
describe their busses entirely... but as you said that's against the
spirit of dt-bindings and would upset a lot of people. That's why I've
left the "!fixed-link && !phy-handle (legacy handling) logic :)

> 
> > Sorry, I don't have any docs for stmmac hardware so this might be
> > answered in there (or just common net knowledge that I can't find
> > online)... what's SMA stand for? I assume it's the MDIO interface.
> 
> Right. Synopsys names the MDIO-bus interface as Station Management
> Agent MDIO module.
> 
> > 
> > I agree though, if you have a phy-handle and no mdio node in your
> > devicetree this patch series should bail out without registering a bus
> > in stmmac_mdio_register().
> 
> On the other hand why would the MDIO-bus needed in such case? If the
> phy-handle property is specified with no MDIO-bus DT-subnode, then it
> will point out to a PHY residing an external bus. The only case I can
> imagine though is that the DW XPCS device could be still auto-detected
> on the internal SMA-MDIO-bus. But the only driver which currently has
> XPCS auto-detection activated is the Intel glue layer (see
> dwmac-intel.c and has_xpcs flag), but it doesn't use DT interface
> since it handles a PCIe-based device.  So this case is out of
> brackets.

Agreed, I think making the bus is not needed in the driver as is in that
case.

I'd like to think (but am not sure) that when a devicetree based DW XPCS
description comes around it will allow you to describe it exactly
instead of doing auto-detection (i.e. something like phy-handle), but I
am not very familiar with PCS and friends in the stack so that may be a
crude extension from my knowledge of MDIO.

Thanks,
Andrew

> 
> > 
> > > 
> > > > 
> > > > Below upstream devicetree snippets can be found that explain some of
> > > > the cases above more concretely.
> > 
> > <snip>
> > 
> > > > -	if (mdio) {
> > > > -		plat->mdio_bus_data =
> > > > -			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
> > > > -				     GFP_KERNEL);
> > > 
> > > > +	/* Legacy devicetrees allowed for no MDIO bus description and expect
> > > > +	 * the bus to be scanned for devices. If there's no phy or fixed-link
> > > > +	 * described assume this is the case since there must be something
> > > > +	 * connected to the MAC.
> > > > +	 */
> > > > +	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
> > > > +	if (legacy_mdio)
> > > > +		dev_info(dev, "Deprecated MDIO bus assumption used\n");
> > > > +
> > > > +	if (plat->mdio_node || legacy_mdio) {
> > > > +		plat->mdio_bus_data = devm_kzalloc(dev,
> > > 
> > > Special thanks for adding the comment above this code. It will really
> > > save time of figuring out why MDIO-bus needs to be created anyway.
> > > 
> > > > +						   sizeof(struct stmmac_mdio_bus_data),
> > > 
> > > Should v4 is required I would suggest to change this to
> > > sizeof(*plat->mdio_bus_data).
> > > 
> > > Anyway feel free to add:
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > -Serge(y)
> > 
> 
> > Sure I will spin v4 to pick that up, thanks for catching it. I'll also
> > improve the motivation in the commit message a hair more per Andrew
> > Lunn's request over here on v2 (and will hold off a little bit just to
> > make sure reviews come in before a respin):
> > 
> >     https://lore.kernel.org/netdev/e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch/
> 
> Ok. Thanks.
> 
> -Serge(y)
> 
> > 
> > Thanks,
> > Andrew
> > 
> 


