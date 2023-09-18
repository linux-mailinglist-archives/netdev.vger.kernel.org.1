Return-Path: <netdev+bounces-34642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24667A5086
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD691C2175A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684322F15;
	Mon, 18 Sep 2023 17:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A826282
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:07:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656794
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o8w35RlyhqQ14KOmY0ZXd0tJ/SWMsbJFPzz4zb2jCGw=; b=S0eDgzaQt88Y0b3xfUiom6QmQY
	dvFpH5Qg0gZ9XwEU71ZfcDDFCkM42NhTtbb0pwp2jd0LrjwLGWsqvdKoc2TsqnAAe3bEXo7O3F+G9
	EvPQnfHS/yUnEkWZ7152D6uGMRreFlbq5x03oPkgeUXFbeU3Np4sFjrf1yUzW9LLw91Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiHCD-006oK6-V7; Mon, 18 Sep 2023 18:34:01 +0200
Date: Mon, 18 Sep 2023 18:34:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: fix regression with AX88772A PHY
 driver
Message-ID: <09ce23ac-5794-477f-a5ce-a0cf5f5e3184@lunn.ch>
References: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
 <eeb31d51-2b07-4b23-a844-c4112c34ef83@lunn.ch>
 <ZQhXWfKyfpNQlGew@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhXWfKyfpNQlGew@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Err? Sorry, but your comment makes little sense

Sorry, -EMORECOFFEE.

       Andrew

