Return-Path: <netdev+bounces-25516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9042E7746E7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02801C20F33
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121C15ADC;
	Tue,  8 Aug 2023 19:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC3156FE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D180B0;
	Tue,  8 Aug 2023 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r10h6nVMk04j6nRxoY62Y1rHsX1nNYozakCPbJXDblk=; b=G0AnBQDNcml/ZR//sKTnjynE4r
	80iRL3AcMWA776SfbTIHkbVQK9yPk08vd1NrwK8Ldc+zL8AdcbA87tN2wNNu8HSiAdL7x+w0Xb2rI
	4Bu+QljQkFUgQQuKBwvVGQy7OljI5Fwy7qMhFCiev8lJ8yrHkMJ+64VA8SYIQSzQDm80tgCyli72X
	fGpsOaMoUUM61OdT4sIWsEtyqnKHyS9qBg2DlDD/rb/7AO2POmVMtMAWv2OJc4NseezFPDWFSwybl
	0IM1vqtSyHBh9OAiaKgjzBL7iKLwQAhhMlzyVP0j3J8jlbtWev83mp4aaZEV1ZxuH8S6KN+pWdOuw
	M5PrwVUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36762)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTOc1-0000HF-2P;
	Tue, 08 Aug 2023 16:27:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTObz-0008Dn-JR; Tue, 08 Aug 2023 16:27:07 +0100
Date: Tue, 8 Aug 2023 16:27:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
Message-ID: <ZNJeyxeZIr2DahTl@shell.armlinux.org.uk>
References: <20230807193102.6374-1-brgl@bgdev.pl>
 <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
 <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
 <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
 <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm>
 <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 05:15:45PM +0200, Andrew Lunn wrote:
> > > > > Good point, but it's worse than that: when MAC0 is unbound, it will
> > > > > unregister the MDIO bus and destroy all PHY devices. These are not
> > > > > refcounted so they will literally go from under MAC1. Not sure how
> > > > > this can be dealt with?
> > > >
> > > > unbinding is not a normal operation. So i would just live with it, and
> > > > if root decides to shoot herself in the foot, that is her choice.
> > > >
> > > 
> > > I disagree. Unbinding is very much a normal operation.
> 
> What do you use it for?
> 
> I don't think i've ever manually done it. Maybe as part of a script to
> unbind the FTDI driver from an FTDI device in order to use user space
> tools to program the EEPROM? But that is about it.
> 
> I actually expect many unbind operations are broken because it is very
> rarely used.

rmmod! Particularly useful during driver development, I tend to use it
extensively - and it has the advantage of testing those unbind paths!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

