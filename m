Return-Path: <netdev+bounces-45084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF87DAD87
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95DAB20CE2
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A555DF69;
	Sun, 29 Oct 2023 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xEMHzxMr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6336DF59
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 17:36:00 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E87B6;
	Sun, 29 Oct 2023 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4xyVcC54i/pj7YjIG5QNyqM/WGtgEIQ1Fy6oJRwheck=; b=xEMHzxMr1QEo9Oin4+rEpvLymQ
	tSY37YCpYP6egq3NKt1c/B8at0KIzPs5QRQJ/H5NOc33smPQHAY7N8oDeXLizROD0yIJB00ccBOw2
	+BUIdmnv8P0dkSPy+9FLycsUNcneGDNTTYamlnMGYzwm2KyjflBS975JJCNXa4v0PSD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qx9hV-000SDI-9P; Sun, 29 Oct 2023 18:35:49 +0100
Date: Sun, 29 Oct 2023 18:35:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Message-ID: <6c10edf1-dad1-4a4f-ae0e-42b17febbd5d@lunn.ch>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com>
 <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>

> The switch is pretty bogus, all documentation we have of it is a vendor
> code drop, no data sheet. The format for ingress and egress tags
> was discovered using trial-and-error.

The code drop does not include tagging? Does the code drop also pad to
full size Ethernet frames?

I still think it would be good to do some systematic testing to figure
out if there is any pattern to the drops.

     Andrew

