Return-Path: <netdev+bounces-31856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2828790F20
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 00:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54BF280F7E
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0880BE49;
	Sun,  3 Sep 2023 22:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6389445
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 22:51:17 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5698
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nKvErEuXL+byc6Zj3HacKs+rUTskDNxsoPDU37WIag4=; b=joGldspFt3TZ0pep0ShVBuodw2
	PWa9sHYa8PPN55GkceeeRYm22KW/dujuZ+x9+MfUKJSHHvQWPxBBV76xH2XbmvGyYNpDPummQuOFE
	Fln5UGVfFR5iTErF8RMdYLyaA5Bdi2gkd108I/Yjhc0m/3CMlt0gASRZVPuMOlg03upY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qcvvt-005hc3-2y; Mon, 04 Sep 2023 00:51:05 +0200
Date: Mon, 4 Sep 2023 00:51:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	netdev@vger.kernel.org, simonebortolin@hack-gpon.org,
	nanomad@hack-gpon.org, Federico Cappon <dududede371@gmail.com>,
	daniel@makrotopia.org, lorenzo@kernel.org, ftp21@ftp21.eu,
	pierto88@hack-gpon.org, hitech95@hack-gpon.org, davem@davemloft.net,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	pabeni@redhat.com, nbd@nbd.name, maxime.chevallier@bootlin.com
Subject: Re: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed
 single-mac devices (XOR RJ/SFP)
Message-ID: <dcb34edd-a7ca-429a-896d-0f056ce02056@lunn.ch>
References: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
 <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> To solve that sanely, every PHY-based ethtool probably needs a way
> to specify which PHY the command is intended for, but then there's
> the question of how userspace users react to that - because it's
> likely more than just modifying the ethtool utility, ethtool
> commands are probably used from many programs.

This idea of extending ethtool with a PHY ID has discussed last
year. It helps solve some of the problems discussed here. You can then
enumerate all the PHYs connected to a MAC, and operate on each PHY
independently.

https://lore.kernel.org/netdev/20221017105100.0cb33490@pc-8.home/

	Andrew

