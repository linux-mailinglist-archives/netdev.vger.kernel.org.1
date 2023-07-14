Return-Path: <netdev+bounces-17776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD1753050
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E474281D1D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2A46B6;
	Fri, 14 Jul 2023 04:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155011C08
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:05:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87C2708
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iJC2u3ALyJFouYqdO1jXVDTl8VGpmVKHXOQAe9T08l8=; b=eh9yO7iaYcLQ/oAb0PyPFX27v2
	4jGHXnAD9pP4NCBD9Ag6cyoMLXQMLQ9df4/YWb0WhcZp1r3IgJuAdqX7zk+BoyMTB52qsjfAraOK6
	Al1EtvotKU7GWePts0GIl+SV3ML8pWDRoiSmChO6KJA+Rp8j7z4I+8SXR06yHBA6idYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKA3X-001JbC-6i; Fri, 14 Jul 2023 06:05:23 +0200
Date: Fri, 14 Jul 2023 06:05:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: add the link modes for
 1000BASE-T1 Ethernet PHY
Message-ID: <b01fcf28-6cc7-46d5-a169-af8b7cb51916@lunn.ch>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-2-eichest@gmail.com>
 <cad4c420-470d-497a-9a1d-a43654af9a7e@lunn.ch>
 <ZLAFzaN7IRzerGpX@eichest-laptop>
 <f33be5e3-cfb4-473f-8669-58e1982d2a17@lunn.ch>
 <ZLDGLqRuzKhtSALY@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLDGLqRuzKhtSALY@eichest-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Thanks for the suggestion. Unfortunately,
> genphy_c45_pma_read_abilities() directly reads from the PHY registers.

Please consider refactoring the bits of
genphy_c45_pma_read_abilities() you need into a helper. You can then
call the helper directly from your driver.

     Andrew

