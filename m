Return-Path: <netdev+bounces-113782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BE93FE74
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB001F23DF3
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE34187878;
	Mon, 29 Jul 2024 19:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D214A0B7;
	Mon, 29 Jul 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282171; cv=none; b=eubKGIqvhFVWMP8DLZCEGpQcC5ktmc7ZwXazfxGCIsPbn+UJKZFraygJhksFD3eQ0wHRKQ0aIT/pmHElQi1/m5iovZzpBNAUbiq2RKrPKfQuuZAZF9MHy07kOdaGec6oTlTLYuCnKjF+P/cxSLu/NbX5vQ0FOzsBeUAj8+WbcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282171; c=relaxed/simple;
	bh=zQrrcm10kCvHi/oNW5hQkCQZGwRU9jvj2iAUgOU+jWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiXCegapJcm0D3vueXtj1xKqKsaMCdzY6op8RtFVk0TgMd7tLf16eNx3F2qmJgEEWbDqXXrmE9Inq6SUL5aaZDei6faerLnwKNj7QT9cAYV6OonGbhI90OurZdjzrU0FHfFI1WruUglijV1phapkMjrXeEOX7YAOQddK4Dkf9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYWGQ-000000005b2-2xLz;
	Mon, 29 Jul 2024 19:42:34 +0000
Date: Mon, 29 Jul 2024 20:42:26 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Sam Shih <Sam.Shih@mediatek.com>,
	Weijie Gao <Weijie.Gao@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: pcs: add helper module for standalone
 drivers
Message-ID: <ZqfwogNXxmAL1WB2@makrotopia.org>
References: <ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org>
 <Zqd8z+/TL22OJ1iu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqd8z+/TL22OJ1iu@shell.armlinux.org.uk>

Hi Russell,

thank you for commenting on this patch. Please help me understand which
direction I should work towards to see support for the MT7988 SoC
Ethernet in future kernels, see my questions below.

On Mon, Jul 29, 2024 at 12:28:15PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 25, 2024 at 01:44:49PM +0100, Daniel Golle wrote:
> > +static void devm_pcs_provider_release(struct device *dev, void *res)
> > +{
> > +	struct pcs_standalone *pcssa = (struct pcs_standalone *)res;
> > +
> > +	mutex_lock(&pcs_mutex);
> > +	list_del(&pcssa->list);
> > +	mutex_unlock(&pcs_mutex);
> 
> This needs to do notify phylink if the PCS has gone away, but the
> locking for this would be somewhat difficult (because pcs->phylink
> could change if the PCS changes.) That would need to be solved
> somehow.

From my understanding the only way the PCS would "go away" is by
rmmod, which is prevented by the usage counter if still in use by the
Ethernet driver (removal of instances by using unbind in sysfs is
prevented by .suppress_bind_attrs).

I understand that Ethernet MAC and PCS both being built-into the SoC may
not be the only case we may want to support in the long run, but it is
the case for the MT7988 SoC which I'd like to see supported in upstream
Linux.

So imho this is something quite hypothetical which can be prevented by
setting .suppress_bind_attrs and bumping the module usage counter, as
those are not really dedicated devices on some kind of hotplug-able bus
what-so-ever, but all just components built-into the SoC itself. They
won't just go away. At least in case of the SoC I'm looking at.

If you have other use-cases in mind which this infrastructure should be
suitable for, it'd be helpful if you would spell them out.

If your criticism was meant to be directed towards the whole idea of
using standlone drivers for the PCS units of the SoC then the easiest
would of course be to just not do that and instead keep handling the
PCS as part of the Ethernet driver.

The main reason why I like the idea of the PCS driver being separate is
because it is not even needed on older platforms, and those are quite
resource constraint so it would be a waste to carry all the USXGMII
logic, let's say, on devices with MT7621 or even MT7628.

However, there are of course other ways to achieve nearly the same, such
as Kconfig symbols which select parts of the driver to be included or
not.

Hence my question: Do you think it is worth going down this road and
introducing standalone PCS drivers, given that the infrastructure
requirements include graceful removal of any PCS instance?

Also note that the same situation (things which may "go away") applies
to PHYs (as in: drivers/phy, not drivers/net/phy) as well, and I don't
see this being addressed for any of the in-SoC Ethernet controllers
supported by the kernel.

I was hoping for clarification regarding this but never received a
reply, see https://lkml.org/lkml/2024/2/7/101

And what about used instances of drivers/pinctrl, drivers/reset,
drivers/clk, ...? Should a SoC Ethernet driver be built in a way that
all those may gracefully "go away" as well?

I'm totally up to work on improving the overall situation there, but
it'd be good to know which direction I should be aiming for.
(as in: pre-removal call-back functions? just setting
.suppress_bind_attrs for all drivers/phy/ and such by default? extending
phylink itself to handle drivers/phy instances and their disappearance,
as well as potentially more than one PCS instance per net_device? ...)

> > [...]
> > +	device_link_add(dev, pcssa->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> 
> This is really not a nice solution when one has a network device that
> has multiple interfaces. This will cause all interfaces on that device
> to be purged from the system when a PCS for one of the interfaces
> goes away. If the system is using NFS-root, that could result in the
> rootfs being lost. We should handle this more gracefully.

"DL_FLAG_AUTOREMOVE_CONSUMER causes the device link to be automatically
purged when the consumer fails to probe or later unbinds."
(from Documentation/driver-api/device_link.rst)

The consumer is the Ethernet driver in this case. Hence the automatic
purge is only applied in case the Ethernet device goes away, and meanwhile
it would prevent the PCS driver from being rmmod'ed (which in my case is
the only way for the PCS to "disappear").

Also note that the same flag is used in pcs-rzn1-miic.c as well.


Thank you for your patiente and helping me to understand how to proceed.


Cheers


Daniel

