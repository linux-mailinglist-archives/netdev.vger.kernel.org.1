Return-Path: <netdev+bounces-32417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441F79760A
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D85281776
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A912B9E;
	Thu,  7 Sep 2023 16:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95A28E7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:01:06 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B405261
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iW9qexjhy8+LyUL+K3aytg7/qTwPeKlLpqIkH3ZXji0=; b=jGG0c1D10CSnKpz1tY7DxglbkW
	7aRSvKvH8L3bTau3Dm3hy94mbC7jpzBPi66IOog4PXyZ9qIf9OVm4Mpi1AzT+C8nxTrrDygbHzk4G
	htPbFECv05h8bZMPoLqH2imjz0FODQ2azZHsn7cDyH6ouDeb85bxtb6tabZivfuRdppvlF1qTdmET
	ezb70l1qY/TC8UOqq1TdB26+hG5y3F2B+0LdyZEqmOWH7CFil6FHD7YI4EFTaIiGWnL4QnTcizBSl
	3LYFQP+gU33vypEfoI24Uzv1vjhebAn3tm/TujXEIoXeb7U8Z970QRfGPJyhnfG8rtjkOrsHeFtHo
	Kut3IM/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54310)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qeBKW-0001qD-2B;
	Thu, 07 Sep 2023 10:29:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qeBKW-0005iw-1R; Thu, 07 Sep 2023 10:29:40 +0100
Date: Thu, 7 Sep 2023 10:29:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	glipus@gmail.com, maxime.chevallier@bootlin.com,
	vadim.fedorenko@linux.dev, gerhard@engleder-embedded.com,
	thomas.petazzoni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH net-next RFC v4 2/5] net: Expose available time stamping
 layers to user space.
Message-ID: <ZPmYAwb0Gz++XCAA@shell.armlinux.org.uk>
References: <20230511161625.2e3f0161@kernel.org>
 <20230512102911.qnosuqnzwbmlupg6@skbuf>
 <20230512103852.64fd608b@kernel.org>
 <20230517121925.518473aa@kernel.org>
 <2f89e35e-b1c9-4e08-9f60-73a96cc6e51a@lunn.ch>
 <20230517130706.3432203b@kernel.org>
 <20230904172245.1fa149fd@kmaincent-XPS-13-7390>
 <ZPYYFFxhALYnmXrx@hoboy.vegasvil.org>
 <20230905114717.4a166f79@kernel.org>
 <8fd9f2bc-f8a2-4290-8e52-17a39175b3d7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fd9f2bc-f8a2-4290-8e52-17a39175b3d7@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 10:29:51PM +0200, Andrew Lunn wrote:
> > Maybe we should try to enumerate the use cases, I don't remember now
> > but I think the concern was that there may be multiple PHYs?
> 
> You often see a Marvell 10G PHY between a MAC and an SFP cage. You can
> then get a copper SFP module which has a PHY in it.
> 
> So:
> 
> "Linux" NIC: [DMA MAC][PHY][PHY] 

Let's be clear - one of the reasons that this whole topic was triggered
was because of mvpp2 plus Marvell 1G PHYs. mvpp2 has a good PTP
implementation, where as Marvell 1G PHYs are not quite as good. With
the code as it stood, merely adding PTP support to Marvell PHYs would
result in setups that use a Marvell 1G PHY with mvpp2 to break - some
PTP API calls would end up going to one PTP implementation while other
PTP API calls end up going to the other.

Once this gets solved properly, then I can think about sending the
patches that add support for PTP in Marvell 1G PHYs, and then we will
have the situation where we have a MAC and a PHY on the *same* network
interface that are PTP capable.

People have been asking me about the Marvell PHY PTP patches - and I
have had to tell them that they can't be merged because of the PTP
API crazyness.

So... it would be entirely possible, if PTP were to be implemented for
the Marvell 10G PHYs, that there would be _three_ points with a SFP
module to do PTP, although it probably does not make much sense to
attempt to do so on the SFP PHY. In any case, before we get to that
point, we first need to work out how to support multiple ethernet PHYs
on one MAC.

Even with that solved, the situation you describe above is likely to be
problematical. PHYs that connect to SFPs generally only support fibre
interface modes and not SGMII on that port which limits the usefulness
of copper SFPs - they won't be able to do 10M / 100M unless they're one
of those PHYs that does rate adaption which seem fairly rare at the
moment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

