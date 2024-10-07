Return-Path: <netdev+bounces-132724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49725992E78
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68BC1F2255E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD71D6DDF;
	Mon,  7 Oct 2024 14:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003351D2F6D
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310253; cv=none; b=GfESZxFtti0xT9DJ/NSyMe3Pr2YVORNhc9izETaB1SvXOAhA/MaG/xJt3XlTmTqIIKI7An8vQrN4+TsVMuFbvhv63xhHtE7LTE+ZreM1CZ93vP9gdfOgBANwDAIckJT2bW3UeouGxTBc8L+RYzSyWm4Skhd/C45sAl957qypuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310253; c=relaxed/simple;
	bh=D7L7iYMaQ7gcoeyymkN+4iwZeYnDw8As5uttBlI6c1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG/hgGjC2msrKEZhVe9fCNDMteXsuA/bwrzvOq+KEls5Uxo8YrSwH/FMgxG0JHxoQdiEHLjA+HcHLwiDOJ0gG2L0OEqanLk0gOgac6WYRbsaFWEcS6N4js7hoTCtN7h9pnk5iAz/9KRoRaQZiskuAiLk+pUkrWKZP5LuvD/WQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sxoRZ-0007Id-QH; Mon, 07 Oct 2024 16:10:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sxoRV-0009Ar-Tl; Mon, 07 Oct 2024 16:10:33 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sxoRV-00GGMO-2e;
	Mon, 07 Oct 2024 16:10:33 +0200
Date: Mon, 7 Oct 2024 16:10:33 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Message-ID: <ZwPr2chTq4sX_I_b@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
 <ZwDcHCr1aXeGWXIh@pengutronix.de>
 <20241007113026.39c4a8c2@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007113026.39c4a8c2@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Oct 07, 2024 at 11:30:26AM +0200, Kory Maincent wrote:
> On Sat, 5 Oct 2024 08:26:36 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > >  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is
> > > used @@ -1871,6 +1883,10 @@ various existing products that document power
> > > consumption in watts rather than classes. If power limit configuration
> > > based on classes is needed, the conversion can be done in user space, for
> > > example by ethtool. 
> > > +When set, the optional ``ETHTOOL_A_C33_PSE_PRIO`` attributes is used to
> > > +control the C33 PSE priority. Allowed priority value are between zero
> > > +and the value of ``ETHTOOL_A_C33_PSE_PRIO_MAX`` attribute.  
> >  
> > We need to introduce a new attribute to effectively manage PSE priorities.
> > With the addition of the `ETHTOOL_A_C33_PSE_PRIO` attribute for setting
> > priorities, it's important to know which PSE controller or domain each port
> > belongs to.
> > 
> > Initially, we might consider using a PSE controller index, such as
> > `ETHTOOL_A_PSE_CONTROLLER_ID`, to identify the specific PSE controller
> > associated with each port.
> > 
> > However, using just the PSE controller index is too limiting. Here's why:
> > 
> > - Typical PSE controllers handle priorities only within themselves. They
> > usually can't manage prioritization across different controllers unless they
> > are part of the same power domain. In systems where multiple PSE controllers
> > cooperate—either directly or through software mechanisms like the regulator
> > framework—controllers might share power domains or manage priorities together.
> > This means priorities are not confined to individual controllers but are
> > relevant within shared power domains.
> > 
> > - As systems become more complex, with controllers that can work together,
> > relying solely on a controller index won't accommodate these cooperative
> > scenarios.
> > 
> > To address these issues, we should use a power domain identifier instead. I
> > suggest introducing a new attribute called `ETHTOOL_A_PSE_POWER_DOMAIN_ID`.
> > 
> > - It specifies the power domain to which each port belongs, ensuring that
> > priorities are managed correctly within that domain.
> > 
> > - It accommodates systems where controllers cooperate and share power
> > resources, allowing for proper coordination of priorities across controllers
> > within the same power domain.
> > 
> > - It provides flexibility for future developments where controllers might work
> > together in new ways, preventing limitations that would arise from using a
> > strict controller index.
> > 
> > However, to provide comprehensive information, it would be beneficial to use
> > both attributes:
> > 
> > - `ETHTOOL_A_PSE_CONTROLLER_ID` to identify the specific PSE controller
> > associated with each port.
> > 
> > - `ETHTOOL_A_PSE_POWER_DOMAIN_ID` to specify the power domain to which each
> > port belongs.
> 
> Currently the priority is managed by the PSE controller so the port is the only
> information needed. The user interface is ethtool, and I don't see why he would
> need such things like controller id or power domain id. Instead, it could be
> managed by the PSE core depending on the power domains described in the
> devicetree. The user only wants to know if he can allow a specific power budget
> on a Ethernet port and configure port priority in case of over power-budget
> event.

Budget is important but different topic. If user do not know how much
the budget is, there is nothing usable user can configure. Imagine you
do not know how much money can spend and the only way to find it out is
by baying things.

But, budget is the secondary topic withing context of this patch set.
The primer topic here is the prioritization, so the information user
need to know it the context: do A has higher prio in relation to B? Do A
and B actually in the same domain?


> I don't have hardware with several PSE controllers. Is there already such
> hardware existing in the market?

Please correct me if i'm wrong, but in case of pd692x0 based devices,
every manager (for example PD69208M) is own power domain. There are
following limiting factors:
                          PI 1
                   L4    /
		 PD69208M - PI 2
              L3 //      \
 L1      L2     //        PI 3
PSU ============'
                \\        PI 4
                 \\      /
		 PD69208M - PI 5
                         \
			  PI 6

L1 - limits defined by Power Supply Unit
L2 - Limits defined by main supply rail ob PCB
L3 - Limits defined by rail attached to one specific manager
L4 - Limits defined by manager. In case of PD69208M it is Max 0.627A
(for all or per port?)

Assuming PSU provides enough budget to covert Max supported current for
every manager, then the limiting factor is actual manager. It means,
setting prio for PI 4 in relation to PI 1 makes no real sense, because
it is in different power domain.

User will not understand why devices fail to provide enough power by
attaching two device to one domain and not failing by attaching to
different domains. Except we provide this information to the user space.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

