Return-Path: <netdev+bounces-57069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C5811FE1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64DA1C210D0
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711417E566;
	Wed, 13 Dec 2023 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fY4+FmOH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333369C;
	Wed, 13 Dec 2023 12:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=REov+oFNlg6yYMIR/95rdfAyE9Q9tktH/CA0m6KaQUI=; b=fY4+FmOH5yJykXdclne/eOJ4sx
	o1yZxkvltFI5nvWbGcly5/o5zItlScMmj/IcU95tEWUFjEBs3rZVCOhU96oM/Eam5xi0zaduDzvw0
	zOLAqklAejhQ6Sl7dgEWVA9q6UVERPw90kw+UtTMZUmBnhpO2/S8GZ0qE7FkDRUZtDYRuXcqkCIyW
	bdrhW7eK8YRAnbBVYVS5Zqzsnv5YvgEfy/FevlSZtSZOXHR0TbweFpYxhOfdTT7jb9RPqjp5FJccp
	TKt1Rgeby6E8CeGl/Si8sCcIFnIfQrWG1uZiMF/8LYxVpEudA8ZSxwFI0h2N8g+2z5ixkLBpyt7Bt
	j6idMUsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56454)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDVlr-0000Yk-2D;
	Wed, 13 Dec 2023 20:23:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDVlt-0001p4-Gq; Wed, 13 Dec 2023 20:23:57 +0000
Date: Wed, 13 Dec 2023 20:23:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: ethtool: add define for link speed
 mode number
Message-ID: <ZXoS3faDCUuZaLuN@shell.armlinux.org.uk>
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
 <20231213181554.4741-2-ansuelsmth@gmail.com>
 <ZXoPwmDsy7geZe6N@shell.armlinux.org.uk>
 <657a10e1.050a0220.22d18.b3cb@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657a10e1.050a0220.22d18.b3cb@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 13, 2023 at 09:15:27PM +0100, Christian Marangi wrote:
> On Wed, Dec 13, 2023 at 08:10:42PM +0000, Russell King (Oracle) wrote:
> > NAK.
> > 
> > You *clearly* didn't look before you leaped.
> > 
> > On Wed, Dec 13, 2023 at 07:15:53PM +0100, Christian Marangi wrote:
> > > +enum ethtool_link_speeds {
> > > +	SPEED_10 = 0,
> > > +	SPEED_100,
> > > +	SPEED_1000,
> > ...
> > 
> > and from the context immediately below, included in your patch:
> > >  #define SPEED_10		10
> >            ^^^^^^^^
> > >  #define SPEED_100		100
> >            ^^^^^^^^^
> > >  #define SPEED_1000		1000
> >            ^^^^^^^^^^
> > 
> > Your enumerated values will be overridden by the preprocessor
> > definitions.
> > 
> > Moreover, SPEED_xxx is an already taken namespace and part of the UAPI,
> > and thus can _not_ be changed. Convention is that SPEED_x will be
> > defined as the numeric speed.
> >
> 
> Well yes that is the idea of having the enum to count them and then redefining
> them to the correct value. (wasn't trying to introduce new define for
> the speed and trying to assign incremental values)
> 
> Any idea how to handle this without the enum - redefine thing?
> 
> Was trying to find a more automated way than defining the raw number of
> the current modes. (but maybe this is not that bad? since on adding more
> modes, other values has to be changed so it would be just another value
> to document in the comment)

I think my comment on patch 2 gives some ideas! :D

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

