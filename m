Return-Path: <netdev+bounces-220804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A351B48D35
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC981651D8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683F2FB98D;
	Mon,  8 Sep 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kWD475lh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAC22ACEF;
	Mon,  8 Sep 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333839; cv=none; b=D24jC3HJIhzom2ByUJvepZtGGYs4aXtgDMJi2ncA09olR31/yXYOiBGLbA3oFhzuX72oHnEysi++boLtuAFPuj1FhcP8nYwjEo9OwiJvb/+Miceaq6wjcdRz6GOSs3Oyu8WLGygtF38ekqkPhqTe7g9nju03JntGgo7GQrrwlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333839; c=relaxed/simple;
	bh=qjNm4Braf1LRSKREaq0Qxtcfi+0kjPicH3FdWpBSUPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzEnHPnvaoPa3AmEwBVTGH/mMrGztRCNUf+k/Bv7On+urmTiF6Yr02eFEdWudBAPpFUSajZA+9PJgDQhWejPaUPcru/0larVAX2+YyZPYIsnc5Lb403qxYzH6uIyTFMjZT07uI4UNrxZy0wOb1T+Drb3pcQcfqjnUGkGLjxfZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kWD475lh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NaAQio5GO0utjkR8d58puguB9TyKV2JX53Yv+00Am5Y=; b=kW
	D475lhN1LWrQRrMxVDMtjBpB+BCeBrL29n9kbpUJJDMPWJygXxdjXlTeS1ocqibCSxKv9PJEWzQxM
	d3n40mOwUZdaWTCv82+N5+pNw9oS38ypbxcD2fTHkOEaWGPFkGnpLQHhbCvQb0dr3DtHzQZoRVbOp
	VcFMT4RicVUq/q8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvanq-007fVQ-G4; Mon, 08 Sep 2025 14:16:58 +0200
Date: Mon, 8 Sep 2025 14:16:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
Message-ID: <bc4d6d4a-ea6a-4b06-865b-f521d0a91e08@lunn.ch>
References: <20250904203834.3660-1-rosenp@gmail.com>
 <29a8a01e-48be-4057-a382-e75e68f00cf0@lunn.ch>
 <CAKxU2N-3HvmYztoWs4ER7WhPhFHZt1PS9GN2RRGQP3b=KhNBXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-3HvmYztoWs4ER7WhPhFHZt1PS9GN2RRGQP3b=KhNBXw@mail.gmail.com>

On Thu, Sep 04, 2025 at 02:27:47PM -0700, Rosen Penev wrote:
> On Thu, Sep 4, 2025 at 2:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Sep 04, 2025 at 01:38:34PM -0700, Rosen Penev wrote:
> > > The documentation for lan966x states that phy-mode is a required
> > > property but the code does not enforce this. Add an error check.
> > >
> > > Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > index 7001584f1b7a..5d28710f4fd2 100644
> > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > @@ -1199,6 +1199,9 @@ static int lan966x_probe(struct platform_device *pdev)
> > >                       continue;
> > >
> > >               phy_mode = fwnode_get_phy_mode(portnp);
> > > +             if (phy_mode)
> > > +                     goto cleanup_ports;
> >
> > I think a dev_err_probe() would be good here to give a clue why the
> > interfce failed to prove.
> Probably. Although there are no other error messages in the surrounding code.

lan966x_probe() has 8 error messages.

	Andrew

