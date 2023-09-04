Return-Path: <netdev+bounces-31882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250679113A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA53F1C204FA
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 06:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE3813;
	Mon,  4 Sep 2023 06:06:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796647FE
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 06:06:50 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1DDE
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 23:06:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96114C0002;
	Mon,  4 Sep 2023 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1693807607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaPIawjT4d991jsJ3ixZD2cTuo+BRd4XVQKnUXS5a7c=;
	b=WHbc55+19d0gbiYaGz13zJCm8S8mhZmMHUZ1x97lkFQHz3UJ9Ov+KSWkTJI1jXHei78GQC
	nHK6cVsQ9gOxMV6hvN+GVZEHuaIhPhXLdEOzSkAZ02Fl/yrxjOnu6CzYri+msWuyqO1j5I
	U78+k+pX86lhKgCFJaVLoJjgPAR0qPYNyTKHvo3GzixufI8n7tbi5+G7k5d8cUjcieHBGU
	EiLrO2IM5tPW+wmTDbjyxN9Fl6LiveAQEX1KUQrOyRZfmXZ5oz1jmTHeLs4zNJOzyaSrHM
	OAQcdBQUC/ozMk56td0rWCWOKDShqop7eRENncIMyj+KNVQRXLET0FqjoVpqbQ==
Date: Mon, 4 Sep 2023 08:06:43 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, =?UTF-8?B?Tmljb2w=?=
 =?UTF-8?B?w7I=?= Veronese <nicveronese@gmail.com>, netdev@vger.kernel.org,
 simonebortolin@hack-gpon.org, nanomad@hack-gpon.org, Federico Cappon
 <dududede371@gmail.com>, daniel@makrotopia.org, lorenzo@kernel.org,
 ftp21@ftp21.eu, pierto88@hack-gpon.org, hitech95@hack-gpon.org,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed
 single-mac devices (XOR RJ/SFP)
Message-ID: <20230904080643.77678736@pc-7.home>
In-Reply-To: <dcb34edd-a7ca-429a-896d-0f056ce02056@lunn.ch>
References: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
	<ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
	<dcb34edd-a7ca-429a-896d-0f056ce02056@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello everyone,

On Mon, 4 Sep 2023 00:51:05 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > To solve that sanely, every PHY-based ethtool probably needs a way
> > to specify which PHY the command is intended for, but then there's
> > the question of how userspace users react to that - because it's
> > likely more than just modifying the ethtool utility, ethtool
> > commands are probably used from many programs.  
> 
> This idea of extending ethtool with a PHY ID has discussed last
> year. It helps solve some of the problems discussed here. You can then
> enumerate all the PHYs connected to a MAC, and operate on each PHY
> independently.
> 
> https://lore.kernel.org/netdev/20221017105100.0cb33490@pc-8.home/

Indeed and I'm actively working on this right now, I have an RFC series
that'll be sent during the week, I'll make sure to CC everyone.

As stated this isn't an easy problem, my course of action is the
following to address this : 

 - First allow addressing individual PHYs attached to the same netdev,
without taking the mux into consideration for now. There are already
cases where several PHYs are attached to one MAC, which is when we have
a PHY between the MAC and SFP port, and a PHY in the SFP module.

As Russell said, there are some ethtool operations today that target
PHYs (cable testing, plca, but more importantly maybe timestamping).
With PHY addressing, we could imagine using the SFP's PHY for
timestamping.

The RFC will be strictly about that, adding the ability to list PHYs
(including th ones in SFP modules), get information on them, but the
main part really is about that id, that we can use in subsequent
commands. I'm also adding a netlink notification upon PHY
hotplugging/removal.

For the actual muxing my current idea is to better model the PHY port,
and allow userspace to pick which port to use (or auto-switch). The
reasonning is that there are a lot of topologies that lead to this
situation : 

 - Your case, with a real mux, switchign between 1 PHY and 1 SFP port :

                 /-- PHY -- RJ45 (8P8C)
   MAC --- mux --|
                 \-- SFP ( -- PHY ) -- RJ45/Fiber

 - PHYs that have an internal mux (the 88x3310 for example, or some
ports of the 88e6390X switch) :

                /-- RJ45
   MAC -- PHY --|
                \-- SFP -- RJ45/Fiber


 - Finally we have products in the wild using a pure-software mux :

        /-- PHY -- RJ45
  MAC --|
        \-- PHY -- RJ45

(muxing is done by putting one of the 2 PHYs in isolate mode).

I think for userspace, it would be better to directly configure which
front-facing port they want to see being used, and the current
representation of PORT_TP/PORT_FIBRE/etc. doesn't give enough details
about that. So I would add the phy_port enumeration (using the PHY id
previously introduced, each PHY would report the ports they have), then
muxing capability. I think we would have a pretty good overview
of the real topology at that point.

This is challenging, and will probably take quite some iterations to
get it right, as there are lots of things to consider, but hopefully 
as this subject is gaining traction (there are already a few people
interested in supporting such a thing) we can make it work.

Thanks,

Maxime


> 	Andrew
> 


